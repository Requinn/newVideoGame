﻿Shader "Unlit/Testshader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_SecondTex("Second Texture", 2D) = "white" {}
		_Tween("Tween", Range(0,1)) = 0
		_Color("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags 
		{ 
			"Queue" = "Transparent"
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _SecondTex;
			float4 _Color;
			float _Tween;

			float4 frag (v2f i) : SV_Target
			{
				//float4 color = float4(i.uv.r, i.uv.g, 1, 1);
				float4 color1 = tex2D(_MainTex, i.uv) * _Color;
				float4 color2 = tex2D(_SecondTex, i.uv);
				float4 color = lerp(color1, color2, _Tween) * float4(i.uv.r, i.uv.g, 1, 1);;
				return color;
			}

			ENDCG
		}
	}
}
