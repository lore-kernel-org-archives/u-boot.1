Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11023CA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A2F82A9E;
	Mon,  8 Sep 2025 10:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IQHYaGPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA2D800B6; Mon,  8 Sep 2025 10:14:18 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADD438304F
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3dce6eed889so3439645f8f.0
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757319254; x=1757924054; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NM4Rxl7DqxDVxdEdqKM+hPbHynu1pPjxSy/EbaxJIFI=;
 b=IQHYaGPX7ylSDFGSP4X5bUZ2li95LZ9o3pdyl744uwGdcRZZHw7tbV+t7S2W5BanWG
 FvsXj4rCDJ9gybw1BIGjSFAFAZr154TaPyZguhJ8xfhrHbEBPA/8WOIINzMMxRliil6J
 zIpVhfMU1LoJmBpSGzthQCXEDEDmiehtOQ6JzOJ+io5peHGaXCtaAyTjBHeYPRlSJ/db
 Qkm1chvSGrHBVPWJ8fKwtksd7QsPcYpqOKJ1lNlIxdTD0zXTrD/ToaLmgfq2JtfCFQWm
 RQ8ZZr6s5/qTFBNNKFb8vVwSw0iOfD8l9M1T6DswD0BUHLVqi7q0cRdJj31mFaxkucyh
 Dprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757319254; x=1757924054;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NM4Rxl7DqxDVxdEdqKM+hPbHynu1pPjxSy/EbaxJIFI=;
 b=Adxzc/OAuN9Qju4gfyePw4jdd0bHg71L9bSIoogkMK8b1erLqGeKE6wIFw9ps66D2D
 EYoVS6aK4WvRc5x4Nmxkp+IA2HMx+FMAGU+UGh/e+IM5GMe3d4/Y/DdW0oCbBowRKK4V
 29wpMb/Zd3ggu5OglzDmSAREbC/GqZ3r27VlaeWJ77PZ22ySVywvy2gQb1FHw34wXQDm
 bo62nFjw+0gnAVCoXVLqxPENxNOEtCCE7EZw3X86CsqhRxPxFMlXZZqFirJylb8N1aNm
 16wAlXGzk7G7zrbtzFk9QaWzW1HjOsOdSCUOb/L1G8Eu8alIkQdxtl9lXbaEYGyfVcg5
 zVwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe6+GRI9uN06ZxzvCd8l9uMXF/aE85xZ14bKkTa1TznBJbGn47IPjH/OJmNZao+LwFwkahs0U=@lists.denx.de
X-Gm-Message-State: AOJu0YyG2Cj0uLDtWIEgcLYuleMFq3PiLj4nzftn54luG+tZAHzL3Gry
 KrtGBUtfRPFZhyDiMzDTn0Jb7EiOo7V8v0rZfLRr+86T3z/48d3F2+E4Lbw5/RXufQU=
X-Gm-Gg: ASbGncv26s5OqSuTbe4hzqfWkNC+/ne7ipFZn1l9yf/XnjSWbU2EVhwubq5oqtMD/Fy
 X0sxjeUtAqTWAzWl5/+xCiQmoTZ3XmDLEXZqQU52L89hYXF66DeF9e/lTFLgSP1IxQZCPMVOxY7
 Y4C3VxXrebMpjJp/lhpLje/LM25SUqU3J6i5rwayzxzikTQ91ggz2JYCl7E9w4dmKqqQZYxeu1p
 N5yDsA4RGb3KCy9l11pez9Hw8chU4oyCMSQ2UIOYcaeTPhlt5u5X2fmZzAIgMaICrieW20tWDwc
 SJcm2KSYQLr53OYiuYHOLSoznJbui83bahryuxCvVUD2QzEWpScb8QrfPYix9i+K1PN1Kx04hxP
 evnrQk8V/Fzjjf6cJJdJG3fhkWgRWddwHJ6ABDxDhtQgrvnh5AiRm/rWreEjhG7Re97p55lkiDb
 LYK9FYhlOmZQ==
X-Google-Smtp-Source: AGHT+IGCCh1yMeCjGS+g1djYBDYmR060GW/NgY+2zDUdYn7ooNPts98l3UQPUoP6SAkLFXsPe7BCXQ==
X-Received: by 2002:a5d:5f82:0:b0:3e7:42ae:d3dd with SMTP id
 ffacd0b85a97d-3e742aed713mr3577686f8f.53.1757319253941; 
 Mon, 08 Sep 2025 01:14:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b?
 ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d690f2ebb9sm31008901f8f.20.2025.09.08.01.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 01:14:13 -0700 (PDT)
Message-ID: <76c5f608-a5fa-4922-b786-c987035ba6f9@linaro.org>
Date: Mon, 8 Sep 2025 10:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 7/9] arm: dts: meson-gx-u-boot: add binman
 configuration for U-Boot SPL
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-7-37395d9ff5af@postmarketos.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250907-spl-gx-v1-7-37395d9ff5af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 07/09/2025 16:36, Ferass El Hafidi wrote:
> Add binman configuration to meson-gx-u-boot.dtsi to automate building
> bootable images using amlimage.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/dts/meson-gx-u-boot.dtsi | 142 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 142 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
> index 9e0620f395e81048273690af4cee4b196ee7b0a7..d05f869c06ebefa08f5480327e4a72bbaa9a5e94 100644
> --- a/arch/arm/dts/meson-gx-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gx-u-boot.dtsi
> @@ -2,6 +2,7 @@
>   /*
>    * Copyright (c) 2019 BayLibre, SAS.
>    * Author: Maxime Jourdan <mjourdan@baylibre.com>
> + * Copyright (c) 2023 Ferass El Hafidi <funderscore@postmarketos.org>
>    */
>   
>   / {
> @@ -15,6 +16,16 @@
>   	soc {
>   		bootph-all;
>   	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +#if defined(CONFIG_BINMAN)
> +	binman: binman {
> +		multiple-images;
> +	};
> +#endif
>   };
>   
>   &vpu {
> @@ -30,3 +41,134 @@
>   	      <0x0 0xc883c000 0x0 0x1000>;
>   	reg-names = "hdmitx", "hhi";
>   };
> +
> +#if defined(CONFIG_MESON_GX) && defined(CONFIG_BINMAN)
> +/* binman configuration on GXBB and GXL */
> +
> +#if defined(CONFIG_MESON_GXBB)
> +#define BL31_ADDR 0x10100000
> +#else /* GXL */
> +#define BL31_ADDR 0x05100000
> +#endif
> +
> +/*
> + * On GXBB the base address of the SCP firmware doesn't matter as SPL will
> + * send the firmware to the SCP anyway, and can get the base address from the
> + * FIT. On GXL it matters, as BL31 is supposed to send the firmware, so set the
> + * base address to what GXL BL2 would load the binary to.
> + */
> +#define  SCP_ADDR 0x13c0000
> +
> +&binman {
> +	u-boot-amlogic {
> +		filename = "u-boot-meson-with-spl.bin";
> +		pad-byte = <0xff>;
> +
> +		mkimage {
> +			filename = "spl/u-boot-spl-signed.bin";
> +#if defined(CONFIG_MESON_GXBB)
> +			args = "-n", "gxbb", "-T", "amlimage";
> +#elif defined(CONFIG_MESON_GXL)
> +			args = "-n", "gxl", "-T", "amlimage";
> +#endif
> +
> +			blob {
> +				size = <0xb000>; /* The BootROM loads 48K max (header is 4K) */
> +				filename = "spl/u-boot-spl.bin";
> +			};
> +		};
> +
> +		fit: fit {
> +			description = "ATF and U-Boot images";
> +			#address-cells = <1>;
> +			fit,fdt-list = "of-list";
> +			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
> +			fit,align = <512>;
> +			offset = <CONFIG_SPL_PAD_TO>;
> +
> +			images {
> +				u-boot {
> +					description = "U-Boot";
> +					type = "standalone";
> +					os = "u-boot";
> +					arch = "arm64";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					entry = <CONFIG_TEXT_BASE>;
> +
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				atf {
> +					description = "ARM Trusted Firmware";
> +					type = "firmware";
> +					os = "arm-trusted-firmware";
> +					arch = "arm64";
> +					compression = "none";
> +					load = <BL31_ADDR>;
> +					entry = <BL31_ADDR>;
> +
> +					atf-bl31 {
> +						filename = "bl31.bin";
> +					};
> +					hash {
> +						algo = "sha256";
> +					};
> +				};
> +
> +				scp {
> +					description = "SCP firmware";
> +					type = "scp";
> +					arch = "arm"; /* The Cortex-M core is used as SCP */
> +					compression = "none";
> +					load = <SCP_ADDR>;
> +
> +					scp {
> +						filename = "scp.bin";
> +					};
> +					hash {
> +						/*
> +						 * The hash is used by the SCP and passed to it
> +						 * by U-Boot SPL.
> +						 */
> +						algo = "sha256";
> +					};
> +				};
> +
> +				@fdt-SEQ {
> +					description = "NAME";
> +					type = "flat_dt";
> +					compression = "none";
> +				};
> +
> +			};
> +			configurations {
> +				default = "@config-DEFAULT-SEQ";
> +				@config-SEQ {
> +					description = "NAME.dtb";
> +					fdt = "fdt-SEQ";
> +					firmware = "atf";
> +					loadables = "scp", "u-boot";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&vpu {
> +	/delete-property/ bootph-all;
> +};
> +
> +&apb {
> +	bootph-all;
> +};
> +
> +&sd_emmc_b {
> +	bootph-all;
> +};
> +
> +&sd_emmc_c {
> +	bootph-all;
> +};
> +#endif
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
