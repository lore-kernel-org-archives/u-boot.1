Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46CFE75432
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 07:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39F78725E;
	Tue,  3 Oct 2023 09:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CJEyOjFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3430F8725E; Tue,  3 Oct 2023 09:25:39 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 152AE87259
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 09:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31f71b25a99so630448f8f.2
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696317936; x=1696922736; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=y337/XDAUnT+gz+l2dXCsycRVWdnKCPPU0YlcTa7Hns=;
 b=CJEyOjFnk2LVwLVN8OJRtsnzcBds+dSoFOqH4NUY+712DpNOyrZzpbtvXPqV7dKRT/
 QHCvBCNWatpBczKr9vZUcEP/phyfiMFRQPMhNu35uzI/FoQnckMHYd1DPLp2AY71N5Jw
 +iMq/tJdvvWCPr9a8lWuPkEvHGZ3LM24APATtlI0Zym6wun8mXtdj04ppi59KS51nwE1
 QfFszwrvQsxQ0rxiajczxAsQ2a/ZQzBzqTg5pBvRWXP15y6pjgkGll0yjIwd54MDhA7t
 NrQM+dNS3Jcu9Ksww5rcB0nscwTrcCXcbpwTwt3V6AI7SPNJGfLn0g/ChhPtIeN1fIJ8
 ZzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696317936; x=1696922736;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y337/XDAUnT+gz+l2dXCsycRVWdnKCPPU0YlcTa7Hns=;
 b=ctF9xFpwunQ0dE920iRVrgvIvfg45Plp8iQf4ppwNa7ahVwtZwAb7XlZxVOQibQJyi
 yiekkVwXeVgxuY0kPzfRGUjt7OuTAUh6+VbGVhM90YovPYnQZlHd/z07p3/qaM+C8bWX
 2zdIdUpgwBhZRgtja3mNYRmKsS33xCaWuYlldy5FHhJ+dwYpeGRtRbnh+sTXiabcbQUt
 vwXvjcR+4BzOrgnAJw7GMyAz4aZYv5DtJcYoFcnA51YsHVM6d2uotW1e7jL6oEDIxY+1
 MmjGUcrKGQiCP0bIODHKyw5iCCjilBte3hiSm7NZuSHqW0YCEkksdncWxvhMMzB1zdwG
 1F7g==
X-Gm-Message-State: AOJu0Yxyeoq6/hCnYAxFwL8brs9axPN52vTqLXzE9QNIp6qnQ4FeVQFc
 ju4ZAiYLRhZJcDgkRU8mSVm+Qg==
X-Google-Smtp-Source: AGHT+IHqFAguPp3K7Y2FKnig6EW6f2yFbUnrNuuKfQAQz3H234X6IQgEyJvUBcE5+k7iNKjPKudTSA==
X-Received: by 2002:adf:ef83:0:b0:321:634d:d022 with SMTP id
 d3-20020adfef83000000b00321634dd022mr11409762wro.28.1696317936504; 
 Tue, 03 Oct 2023 00:25:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858?
 ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a5d444f000000b0031c5e9c2ed7sm865579wrr.92.2023.10.03.00.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 00:25:36 -0700 (PDT)
Message-ID: <edd025f8-46a2-4045-9b74-58f0e7a57996@linaro.org>
Date: Tue, 3 Oct 2023 09:25:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 3/8] phy: get rid of raw hex values
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-4-avromanov@salutedevices.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20231002165857.19512-4-avromanov@salutedevices.com>
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

On 02/10/2023 18:58, Alexey Romanov wrote:
> It is better to use defines instead of write raw
> hex values in regmap.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/phy/meson-g12a-usb2.c | 161 ++++++++++++++++++++++++++++++++--
>   1 file changed, 153 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
> index 650b88bd18..2e366b16ae 100644
> --- a/drivers/phy/meson-g12a-usb2.c
> +++ b/drivers/phy/meson-g12a-usb2.c
> @@ -23,12 +23,28 @@
>   
>   #include <linux/bitops.h>
>   #include <linux/compat.h>
> +#include <linux/bitfield.h>
>   
>   #define PHY_CTRL_R0						0x0
>   #define PHY_CTRL_R1						0x4
>   #define PHY_CTRL_R2						0x8
> +
>   #define PHY_CTRL_R3						0xc
> +	#define PHY_CTRL_R3_SQUELCH_REF				GENMASK(1, 0)
> +	#define PHY_CTRL_R3_HSDIC_REF				GENMASK(3, 2)
> +	#define PHY_CTRL_R3_DISC_THRESH				GENMASK(7, 4)
> +
>   #define PHY_CTRL_R4						0x10
> +	#define PHY_CTRL_R4_CALIB_CODE_7_0			GENMASK(7, 0)
> +	#define PHY_CTRL_R4_CALIB_CODE_15_8			GENMASK(15, 8)
> +	#define PHY_CTRL_R4_CALIB_CODE_23_16			GENMASK(23, 16)
> +	#define PHY_CTRL_R4_I_C2L_CAL_EN			BIT(24)
> +	#define PHY_CTRL_R4_I_C2L_CAL_RESET_N			BIT(25)
> +	#define PHY_CTRL_R4_I_C2L_CAL_DONE			BIT(26)
> +	#define PHY_CTRL_R4_TEST_BYPASS_MODE_EN			BIT(27)
> +	#define PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0			GENMASK(29, 28)
> +	#define PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2			GENMASK(31, 30)
> +
>   #define PHY_CTRL_R5						0x14
>   #define PHY_CTRL_R6						0x18
>   #define PHY_CTRL_R7						0x1c
> @@ -37,15 +53,93 @@
>   #define PHY_CTRL_R10						0x28
>   #define PHY_CTRL_R11						0x2c
>   #define PHY_CTRL_R12						0x30
> +
>   #define PHY_CTRL_R13						0x34
> +	#define PHY_CTRL_R13_CUSTOM_PATTERN_19			GENMASK(7, 0)
> +	#define PHY_CTRL_R13_LOAD_STAT				BIT(14)
> +	#define PHY_CTRL_R13_UPDATE_PMA_SIGNALS			BIT(15)
> +	#define PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET		GENMASK(20, 16)
> +	#define PHY_CTRL_R13_CLEAR_HOLD_HS_DISCONNECT		BIT(21)
> +	#define PHY_CTRL_R13_BYPASS_HOST_DISCONNECT_VAL		BIT(22)
> +	#define PHY_CTRL_R13_BYPASS_HOST_DISCONNECT_EN		BIT(23)
> +	#define PHY_CTRL_R13_I_C2L_HS_EN			BIT(24)
> +	#define PHY_CTRL_R13_I_C2L_FS_EN			BIT(25)
> +	#define PHY_CTRL_R13_I_C2L_LS_EN			BIT(26)
> +	#define PHY_CTRL_R13_I_C2L_HS_OE			BIT(27)
> +	#define PHY_CTRL_R13_I_C2L_FS_OE			BIT(28)
> +	#define PHY_CTRL_R13_I_C2L_HS_RX_EN			BIT(29)
> +	#define PHY_CTRL_R13_I_C2L_FSLS_RX_EN			BIT(30)
> +
>   #define PHY_CTRL_R14						0x38
>   #define PHY_CTRL_R15						0x3c
> +
>   #define PHY_CTRL_R16						0x40
> +	#define PHY_CTRL_R16_MPLL_M				GENMASK(8, 0)
> +	#define PHY_CTRL_R16_MPLL_N				GENMASK(14, 10)
> +	#define PHY_CTRL_R16_MPLL_TDC_MODE			BIT(20)
> +	#define PHY_CTRL_R16_MPLL_SDM_EN			BIT(21)
> +	#define PHY_CTRL_R16_MPLL_LOAD				BIT(22)
> +	#define PHY_CTRL_R16_MPLL_DCO_SDM_EN			BIT(23)
> +	#define PHY_CTRL_R16_MPLL_LOCK_LONG			GENMASK(25, 24)
> +	#define PHY_CTRL_R16_MPLL_LOCK_F			BIT(26)
> +	#define PHY_CTRL_R16_MPLL_FAST_LOCK			BIT(27)
> +	#define PHY_CTRL_R16_MPLL_EN				BIT(28)
> +	#define PHY_CTRL_R16_MPLL_RESET				BIT(29)
> +	#define PHY_CTRL_R16_MPLL_LOCK				BIT(30)
> +	#define PHY_CTRL_R16_MPLL_LOCK_DIG			BIT(31)
> +
>   #define PHY_CTRL_R17						0x44
> +	#define PHY_CTRL_R17_MPLL_FRAC_IN			GENMASK(13, 0)
> +	#define PHY_CTRL_R17_MPLL_FIX_EN			BIT(16)
> +	#define PHY_CTRL_R17_MPLL_LAMBDA1			GENMASK(19, 17)
> +	#define PHY_CTRL_R17_MPLL_LAMBDA0			GENMASK(22, 20)
> +	#define PHY_CTRL_R17_MPLL_FILTER_MODE			BIT(23)
> +	#define PHY_CTRL_R17_MPLL_FILTER_PVT2			GENMASK(27, 24)
> +	#define PHY_CTRL_R17_MPLL_FILTER_PVT1			GENMASK(31, 28)
> +
>   #define PHY_CTRL_R18						0x48
> +	#define PHY_CTRL_R18_MPLL_LKW_SEL			GENMASK(1, 0)
> +	#define PHY_CTRL_R18_MPLL_LK_W				GENMASK(5, 2)
> +	#define PHY_CTRL_R18_MPLL_LK_S				GENMASK(11, 6)
> +	#define PHY_CTRL_R18_MPLL_DCO_M_EN			BIT(12)
> +	#define PHY_CTRL_R18_MPLL_DCO_CLK_SEL			BIT(13)
> +	#define PHY_CTRL_R18_MPLL_PFD_GAIN			GENMASK(15, 14)
> +	#define PHY_CTRL_R18_MPLL_ROU				GENMASK(18, 16)
> +	#define PHY_CTRL_R18_MPLL_DATA_SEL			GENMASK(21, 19)
> +	#define PHY_CTRL_R18_MPLL_BIAS_ADJ			GENMASK(23, 22)
> +	#define PHY_CTRL_R18_MPLL_BB_MODE			GENMASK(25, 24)
> +	#define PHY_CTRL_R18_MPLL_ALPHA				GENMASK(28, 26)
> +	#define PHY_CTRL_R18_MPLL_ADJ_LDO			GENMASK(30, 29)
> +	#define PHY_CTRL_R18_MPLL_ACG_RANGE			BIT(31)
> +
>   #define PHY_CTRL_R19						0x4c
> +
>   #define PHY_CTRL_R20						0x50
> +	#define PHY_CTRL_R20_USB2_IDDET_EN			BIT(0)
> +	#define PHY_CTRL_R20_USB2_OTG_VBUS_TRIM_2_0		GENMASK(3, 1)
> +	#define PHY_CTRL_R20_USB2_OTG_VBUSDET_EN		BIT(4)
> +	#define PHY_CTRL_R20_USB2_AMON_EN			BIT(5)
> +	#define PHY_CTRL_R20_USB2_CAL_CODE_R5			BIT(6)
> +	#define PHY_CTRL_R20_BYPASS_OTG_DET			BIT(7)
> +	#define PHY_CTRL_R20_USB2_DMON_EN			BIT(8)
> +	#define PHY_CTRL_R20_USB2_DMON_SEL_3_0			GENMASK(12, 9)
> +	#define PHY_CTRL_R20_USB2_EDGE_DRV_EN			BIT(13)
> +	#define PHY_CTRL_R20_USB2_EDGE_DRV_TRIM_1_0		GENMASK(15, 14)
> +	#define PHY_CTRL_R20_USB2_BGR_ADJ_4_0			GENMASK(20, 16)
> +	#define PHY_CTRL_R20_USB2_BGR_START			BIT(21)
> +	#define PHY_CTRL_R20_USB2_BGR_VREF_4_0			GENMASK(28, 24)
> +	#define PHY_CTRL_R20_USB2_BGR_DBG_1_0			GENMASK(30, 29)
> +	#define PHY_CTRL_R20_BYPASS_CAL_DONE_R5			BIT(31)
> +
>   #define PHY_CTRL_R21						0x54
> +	#define PHY_CTRL_R21_USB2_BGR_FORCE			BIT(0)
> +	#define PHY_CTRL_R21_USB2_CAL_ACK_EN			BIT(1)
> +	#define PHY_CTRL_R21_USB2_OTG_ACA_EN			BIT(2)
> +	#define PHY_CTRL_R21_USB2_TX_STRG_PD			BIT(3)
> +	#define PHY_CTRL_R21_USB2_OTG_ACA_TRIM_1_0		GENMASK(5, 4)
> +	#define PHY_CTRL_R21_BYPASS_UTMI_CNTR			GENMASK(15, 6)
> +	#define PHY_CTRL_R21_BYPASS_UTMI_REG			GENMASK(25, 20)
> +
>   #define PHY_CTRL_R22						0x58
>   #define PHY_CTRL_R23						0x5c
>   
> @@ -78,25 +172,76 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   	regmap_update_bits(priv->regmap, PHY_CTRL_R21, BIT(2), 0);
>   
>   	/* PLL Setup : 24MHz * 20 / 1 = 480MHz */
> -	regmap_write(priv->regmap, PHY_CTRL_R16, 0x39400414);
> -	regmap_write(priv->regmap, PHY_CTRL_R17, 0x927e0000);
> -	regmap_write(priv->regmap, PHY_CTRL_R18, 0xac5f49e5);
> +	regmap_write(priv->regmap, PHY_CTRL_R16,
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_M, 20) |
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_N, 1) |
> +		PHY_CTRL_R16_MPLL_LOAD |
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_LOCK_LONG, 1) |
> +		PHY_CTRL_R16_MPLL_FAST_LOCK |
> +		PHY_CTRL_R16_MPLL_EN |
> +		PHY_CTRL_R16_MPLL_RESET);
> +
> +	regmap_write(priv->regmap, PHY_CTRL_R17,
> +		FIELD_PREP(PHY_CTRL_R17_MPLL_FRAC_IN, 0) |
> +		FIELD_PREP(PHY_CTRL_R17_MPLL_LAMBDA1, 7) |
> +		FIELD_PREP(PHY_CTRL_R17_MPLL_LAMBDA0, 7) |
> +		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT2, 2) |
> +		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT1, 9));
> +
> +	regmap_write(priv->regmap, PHY_CTRL_R18,
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_W, 9) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_S, 0x27) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_PFD_GAIN, 1) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_ROU, 7) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_DATA_SEL, 3) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_BIAS_ADJ, 1) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_BB_MODE, 0) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_ALPHA, 3) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_ADJ_LDO, 1) |
> +		PHY_CTRL_R18_MPLL_ACG_RANGE;
>   
>   	udelay(PLL_RESET_COMPLETE_TIME);
>   
>   	/* UnReset PLL */
> -	regmap_write(priv->regmap, PHY_CTRL_R16, 0x19400414);
> +	regmap_write(priv->regmap, PHY_CTRL_R16,
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_M, 20) |
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_N, 1) |
> +		PHY_CTRL_R16_MPLL_LOAD |
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_LOCK_LONG, 1) |
> +		PHY_CTRL_R16_MPLL_FAST_LOCK |
> +		PHY_CTRL_R16_MPLL_EN);
>   
>   	/* PHY Tuning */
> -	regmap_write(priv->regmap, PHY_CTRL_R20, 0xfe18);
> -	regmap_write(priv->regmap, PHY_CTRL_R4, 0x8000fff);
> +	regmap_write(priv->regmap, PHY_CTRL_R20,
> +		FIELD_PREP(PHY_CTRL_R20_USB2_OTG_VBUS_TRIM_2_0, 4) |
> +		PHY_CTRL_R20_USB2_OTG_VBUSDET_EN |
> +		FIELD_PREP(PHY_CTRL_R20_USB2_DMON_SEL_3_0, 15) |
> +		PHY_CTRL_R20_USB2_EDGE_DRV_EN |
> +		FIELD_PREP(PHY_CTRL_R20_USB2_EDGE_DRV_TRIM_1_0, 3) |
> +		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_ADJ_4_0, 0) |
> +		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_VREF_4_0, 0) |
> +		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_DBG_1_0, 0));
> +
> +	regmap_write(priv->regmap, PHY_CTRL_R4,
> +		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
> +		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
> +		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
> +		PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
> +		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
> +		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
>   
>   	/* Tuning Disconnect Threshold */
> -	regmap_write(priv->regmap, PHY_CTRL_R3, 0x34);
> +	regmap_write(priv->regmap, PHY_CTRL_R3,
> +		FIELD_PREP(PHY_CTRL_R3_SQUELCH_REF, 0) |
> +		FIELD_PREP(PHY_CTRL_R3_HSDIC_REF, 1) |
> +		FIELD_PREP(PHY_CTRL_R3_DISC_THRESH, 3));
>   
>   	/* Analog Settings */
>   	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
> -	regmap_write(priv->regmap, PHY_CTRL_R13, 0x78000);
> +	regmap_write(priv->regmap, PHY_CTRL_R13,
> +		PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
> +		FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
>   
>   	return 0;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
