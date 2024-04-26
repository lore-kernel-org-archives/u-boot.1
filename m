Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E2DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 08:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C15D088F0C;
	Fri, 26 Apr 2024 10:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b1BrPvCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2081788F22; Fri, 26 Apr 2024 10:21:30 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E4AB88E6D
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2dd64d6fe94so20210621fa.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 01:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714119687; x=1714724487; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=LdlMorqme09z0hgXtFiVhjo8t9ZBg96TuMKwAPPdPKo=;
 b=b1BrPvCTLCNHQyM9JzqGvGNuRnU763HXSB7ehh+1/CXL7XSuQl4RaWDAASSNROerzP
 fEW8Xlno/MKaTL6fa+/+jaOBnEBHIUl8bAt4ae8TJDGvCtOQPorRM2wP4q+eqqY6SVIK
 alI/lKPR12laLUG+PtVi90Txbn/WH9WQ05rGdJpftAvE7UEvP3tRqN22ne0lserFa3kQ
 4qCEWF5xVQGZMPHJiXV1MHNwNO5WX8fJZUew5nVnt1fQSiJ+5oYxYriiS9N6fb6i+iAn
 me3tk4ugaykBjECI03f8Gv4100N5nWf0D8rqV5diVXYwpcDFBIOLULYMfUij3Bh5nAuK
 ++2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714119687; x=1714724487;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LdlMorqme09z0hgXtFiVhjo8t9ZBg96TuMKwAPPdPKo=;
 b=upxTGWxRuMPODGx4A/FF4abWyJutaGzdcb/0zJKQbduX8yVf7+AaNrcehrd+ey6+LC
 AeoJEVsFG/kOsMFKXfJI395OeCig0TAaL8mjcaur+I/HhG36cR6C6skE22xAhOYANZPX
 YWzXGsrQEWokuibJ2y2P6lsbApHMJ1MHM2QNt2NYyHHXE2gaPssVcNPjCHxWJw7tezsf
 8lyFq2jWdSwwsIgQXZ0jEArBFK442v2KeCV/QQdqwCSDo5z75UlMs4cQMu+GLMUZpFW3
 1Alnim16xbdxLvsSwuYMGxthsxrRC93Mb38TqzNN4sqWQ+/hos67BIlx5i52MxB9yW0X
 9zWg==
X-Gm-Message-State: AOJu0YyAnJQB7SXATF9nixobp1Q417R58YZqZ9ZnuVN/irEuoPeTNfl4
 q9bDZtR71k1dbgOwTvP4BnyrPJf/vc5MZjHLlXZwG316v75L3m7d88jIiyNe1us=
X-Google-Smtp-Source: AGHT+IGwj1rv1BmHu5I+nibAjIOS9EzM4+JDhC72189g2OoM0x6JTUB3GknjV/NAmjCJOXNPRkW/oA==
X-Received: by 2002:a2e:b784:0:b0:2d6:f698:7ecf with SMTP id
 n4-20020a2eb784000000b002d6f6987ecfmr1123902ljo.9.1714119687144; 
 Fri, 26 Apr 2024 01:21:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f335:a8c9:f9da:cddb?
 ([2a01:e0a:982:cbb0:f335:a8c9:f9da:cddb])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a5d434b000000b0034a2d0b9a4fsm20581577wrr.17.2024.04.26.01.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 01:21:26 -0700 (PDT)
Message-ID: <d272b0f6-2f21-4601-b347-f83eac4f12d4@linaro.org>
Date: Fri, 26 Apr 2024 10:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1] arm: dts: meson-axg: add NAND controller node for AXG
To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, kernel@sberdevices.ru,
 oxffffaa@gmail.com
References: <20240425175052.2650301-1-avkrasnov@salutedevices.com>
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
In-Reply-To: <20240425175052.2650301-1-avkrasnov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 25/04/2024 19:50, Arseniy Krasnov wrote:
> nfc: Synced from Linux commit 7ca2ef33179f ("Linux 6.6-rc1")
> nand_all_pins: Synced from Linux commit be18d53c32b2 ("Linux 6.7-rc3")

No need to sync DT anymore, this is handled by OF_UPSTREAM and for next release
it's already aligned with v6.9 DT.

Please try your patches with master or next branch of U-Boot repo.

Neil

> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>   arch/arm/dts/meson-axg.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
> index 3f5254eeb4..4f6fdd5523 100644
> --- a/arch/arm/dts/meson-axg.dtsi
> +++ b/arch/arm/dts/meson-axg.dtsi
> @@ -430,6 +430,27 @@
>   					};
>   				};
>   
> +				nand_all_pins: nand_all_pins {
> +					mux {
> +						groups = "emmc_nand_d0",
> +							 "emmc_nand_d1",
> +							 "emmc_nand_d2",
> +							 "emmc_nand_d3",
> +							 "emmc_nand_d4",
> +							 "emmc_nand_d5",
> +							 "emmc_nand_d6",
> +							 "emmc_nand_d7",
> +							 "nand_ce0",
> +							 "nand_ale",
> +							 "nand_cle",
> +							 "nand_wen_clk",
> +							 "nand_ren_wr";
> +						function = "nand";
> +						input-enable;
> +						bias-pull-up;
> +					};
> +				};
> +
>   				emmc_ds_pins: emmc_ds {
>   					mux {
>   						groups = "emmc_ds";
> @@ -1906,6 +1927,21 @@
>   				resets = <&reset RESET_SD_EMMC_C>;
>   			};
>   
> +			nfc: nand-controller@7800 {
> +				compatible = "amlogic,meson-axg-nfc";
> +				reg = <0x0 0x7800 0x0 0x100>,
> +				      <0x0 0x7000 0x0 0x800>;
> +				reg-names = "nfc", "emmc";
> +				pinctrl-0 = <&nand_all_pins>;
> +				pinctrl-names = "default";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc CLKID_SD_EMMC_C>,
> +					 <&clkc CLKID_FCLK_DIV2>;
> +				clock-names = "core", "device";
> +			};
> +
>   			usb2_phy1: phy@9020 {
>   				compatible = "amlogic,meson-gxl-usb2-phy";
>   				#phy-cells = <0>;

