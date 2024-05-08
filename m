Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E589DC19F4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 12:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74C4F8843F;
	Wed,  8 May 2024 14:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GGLpNwCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBAB88306; Wed,  8 May 2024 14:46:22 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D7E886F1
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 14:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a59b097b202so853757866b.0
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715172379; x=1715777179; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NA96iGzvP4THh/Stz/YeBJVZGXbQbRgAmZxFQiz/kC0=;
 b=GGLpNwCemb7x7DlU4Zgs0ohsjzYgkorEc1dtLk14CAz52pnHQgNu/LWOoxqIMoAokF
 d3cEqxfW26v9zmBMwX4NXNQwdk6xrKUHgM29JQrTT1RR1Ce2wC+/Ydix4rUjJR5sLqiu
 XboDn/7hDtMEyjU9I41BqtDNmEGZw+WkO8Bb11i2XxIsSwpVIzCERR5KO/liYyP2b7l+
 nC5F+vfG7r4JclyIEC5+g2UcXWjf5g7y0E16Y2KRX5MvEHnxJ5+PA3rQuLLz+Tz1yysy
 /cIVHH9SEIXUpQTd4WdQPQaiHD1w4X7k/Su5I0zLytl3DuqxpYJ1lBh0LoQiYzChP9vZ
 FJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715172379; x=1715777179;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NA96iGzvP4THh/Stz/YeBJVZGXbQbRgAmZxFQiz/kC0=;
 b=U1S3dKdRAF0GKy9ysJNAT1A1Kp0wpliZn0PL31hK/UAuGhUV6h9pefsRvbYINCp+ER
 dzdNX2AtNIqdRJZWRWa5J6k0ZteP899vMlaWEb8fVzA1RJUI/BAN9+sugb6ZwlHOVJlf
 83zlseiMNJ5+iGjuyN3jn9u1wyZMkEcac67TFHkbkZJN9xZf+HY1oQtWH0qQwce5yRQ9
 hs9VcilJZauKgHEoo4VKFrqaTf0HAzgVijBOLuKtp3xJP4Cm+CkcAcbLmFpqP/6i0LsW
 oadFLy6lkgaeHBiOUwOJKG6eGVkFwcYakit6DJkNrqfExJsfGNHQ2al0MI2ICq2aYTHE
 AJHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY59Ajn7CTpNtZN0seLXJNWqRDfdHkSfmcV9pPSrH7rkioJLdm57ISqGN5ZufZgbHurybu/D3ZfcXfeJbc45ZrUzWGSA==
X-Gm-Message-State: AOJu0Yx/9fmALf8OwPJA49dvaSdhwPreBO2SnRWINH/JveF8edC18oUE
 /f1+a0y+Npx2mgwcdFUEx6ArUCG+j1BrsDeIjCod2xR1Cin57YShONtt93+Qskg=
X-Google-Smtp-Source: AGHT+IE3acgWyd8/8pfjFYhVX2y7GbnHZ2qKVLqMw6mhhTGAM5mW2XiAgaJ8iUkTZbFylik3jLQIhg==
X-Received: by 2002:a17:906:b851:b0:a59:c833:d272 with SMTP id
 a640c23a62f3a-a59fb921347mr146874466b.13.1715172379094; 
 Wed, 08 May 2024 05:46:19 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a170906715500b00a599c8b6531sm6223611ejj.178.2024.05.08.05.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:46:18 -0700 (PDT)
Message-ID: <128740dd-0a7b-47cf-a789-7f18ba43389b@linaro.org>
Date: Wed, 8 May 2024 14:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] clk/qcom: apq8016: add support for USB_HS clocks
To: Sam Day <me@samcday.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240506-msm8916-hs-usb-clocks-v2-0-34f741b3a2ec@samcday.com>
 <20240506-msm8916-hs-usb-clocks-v2-1-34f741b3a2ec@samcday.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240506-msm8916-hs-usb-clocks-v2-1-34f741b3a2ec@samcday.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 06/05/2024 12:26, Sam Day wrote:
> The newer "register map for simple gate clocks" support added for qcom
> clocks is used. As a result gcc_apq8016 now has a mixture of the old and
> new styles. I didn't (and still don't!) feel comfortable enough in this
> area to update the existing code.
> 

Thanks for this!

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   drivers/clk/qcom/clock-apq8016.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index d3b63b9c1a..3b8c88c769 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -17,6 +17,8 @@
>   
>   #include "clock-qcom.h"
>   
> +#define USB_HS_SYSTEM_CLK_CMD_RCGR	0x41010
> +
>   /* Clocks: (from CLK_CTL_BASE)  */
>   #define GPLL0_STATUS			(0x2101C)
>   #define APCS_GPLL_ENA_VOTE		(0x45000)
> @@ -52,6 +54,11 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
>   	.vote_bit = BIT(10),
>   };
>   
> +static const struct gate_clk apq8016_clks[] = {
> +	GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, 0x00000001),
> +	GATE_CLK(GCC_USB_HS_SYSTEM_CLK,	0x41004, 0x00000001),
> +};
> +
>   /* SDHCI */
>   static int apq8016_clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
>   {
> @@ -117,13 +124,38 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
>   	case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
>   		apq8016_clk_init_uart(priv->base, clk->id);
>   		return 7372800;
> +	case GCC_USB_HS_SYSTEM_CLK:
> +		if (rate != 80000000)
> +			log_warning("Unexpected rate %ld requested for USB_HS_SYSTEM_CLK\n",
> +			            rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB_HS_SYSTEM_CLK_CMD_RCGR,
> +		                     10, 0, 0, CFG_CLK_SRC_GPLL0, 0);
> +		return rate;
>   	default:
>   		return 0;
>   	}
>   }
>   
> +static int apq8016_clk_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		log_warning("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %s\n", __func__, apq8016_clks[clk->id].name);
> +	qcom_gate_clk_en(priv, clk->id);
> +
> +	return 0;
> +}
> +
>   static struct msm_clk_data apq8016_clk_data = {
>   	.set_rate = apq8016_clk_set_rate,
> +	.clks = apq8016_clks,
> +	.num_clks = ARRAY_SIZE(apq8016_clks),
> +	.enable = apq8016_clk_enable,
>   };
>   
>   static const struct udevice_id gcc_apq8016_of_match[] = {
> 

-- 
// Caleb (they/them)
