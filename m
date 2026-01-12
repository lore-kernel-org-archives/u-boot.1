Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85075C9EC94
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 14:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC83A8398C;
	Mon, 12 Jan 2026 15:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NYXoPg4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52CA8399B; Mon, 12 Jan 2026 15:56:35 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAD78388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b871b6e0c70so161151666b.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 06:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768229793; x=1768834593; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9mcpTDURgoYCBfdoRrcGxo35bQVvI59tx8XzWRBFaVc=;
 b=NYXoPg4j257eERLS2FPPl225URrG5iwFijwZHpFcPW1OM9p1etBRjpeLN7j/GOVZqc
 70qQ5pI7a8A+5PcV5hB3mbknCvUpvqTkHTd4EQmU0EH3SkXRAxAGgXflS/t20IpLmbqw
 IY47sSgdM35jUPBOybk8T7XCoi2sCrRxv5aQU+qlaJKorYyehffYmdwvOgfk/iR5D5zU
 D722nbPgg8Ch2UlOAt1og6bQY4A7pwYxNT0NjM47HQamza/9svzllhCiVcgfj68jzvOV
 XBqVXb294lo77iCCzVYwoRgeoJbGjIEgjzhb512azcqmL2TTNiXltjz6WayDZkzR57jV
 J7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229793; x=1768834593;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9mcpTDURgoYCBfdoRrcGxo35bQVvI59tx8XzWRBFaVc=;
 b=HcELAX2ytMfI4u+3FbAGXotR13y1Ai7tfc+hHrXrRxBxr/tcePhKqMunrl8SZV80Fz
 0zhTSRKFuUOZW8uzFoI7E+xg32juapWh8t3mfUpHYQXPJLt8epyIWXIZ1l9jNBqvvRfO
 wr9iErbSW3jWQaLY7Z81ZiZdek+Xg1ovwFzPPEsASyUi38a9JCEQAjQnpGeBw4iyxlWM
 p6+tEBb1mbODfCx+xPdsd/WJLQ+n7ZNQX1GNLj2NRPRYXkrzk7KI3l9gxkNA+iHhnvDZ
 a0eJ5o9N01j56JsSsKL/clFF4wWkUUQ5c5n6FQ2MkX93QzU9G/TMQjUU4F59oyT0evb7
 0zXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkPYjV36qva4cjG/EVRuc+46RKeI6EXxFmHyl9pifbhGbG0Qt/yaaLl/P3/azUd/jKfrJZoak=@lists.denx.de
X-Gm-Message-State: AOJu0YxYm7s4bqX5wMprFxj+p+ozoe9glByRZ3N2Ka2Ua7GGsr3Xa5rF
 RznIyIkhmCSUSrOB48m4Ymx/GhjptrTT4lwnG0pWscQ3S5zZA0kh7XTQAi1g53x7tI0=
X-Gm-Gg: AY/fxX5Uk6Hsu7b37HoaS0GLp/AIdAA0kCzOJtcK8kP4KhF6XgSUibDQ765SmDZTiXX
 Zspi/REnMWMMl3hkOhHYvkq4xd7WURoWdZ14F9rnELiZ5HJ4Rq7ypPweKiTtRMoMZdXcL4LEHLC
 TBVMlcx7J5yx26FcSukehFIwRtgqKRogrJOGqoDruovuoSUqlK5ZypTkWM4FyZZ5IkN1zNDj0hQ
 cVLt9B9KlAtGuY2dLa46AHJb5CViuJTedtvmTANwWzYDrDXYmK3tRtl6jUzSFSt0vW7ntDmh4fK
 iq3pwxDzX1iW8KkQKg06ocVJwQShZqcwTELj4xEimeo2Ns7tMqT+qili1jgfLzAs4iF25AVdE+B
 96qOvDQ0vI9CjhhMx3oCpgiJaOLwAjQNQTBM9xyG3fti/0zvlq1nZlrY7vTMchiMAjgb2pCDVxn
 1FVmb2iWn12WTyxu2BNtL9Krf2cbkjtWIFCmBN7G40rRRI+65nX6Y=
X-Google-Smtp-Source: AGHT+IFs/zd5ZgTuzhdVOLzwBOL0QljiHiOAiKvoqnmil+P5QS8p7+anX45fSoI4b8pXOcNZ1WuP3w==
X-Received: by 2002:a17:906:4fc9:b0:b79:ecb0:db74 with SMTP id
 a640c23a62f3a-b844540607dmr1831092466b.59.1768229793012; 
 Mon, 12 Jan 2026 06:56:33 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b9d4c0asm17942854a12.9.2026.01.12.06.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 06:56:32 -0800 (PST)
Message-ID: <2626ff6c-a0a6-469c-89a6-7e0b49ed3f85@linaro.org>
Date: Mon, 12 Jan 2026 15:56:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v2 2/6] phy: Add IPQ9574 support to Qualcomm QUSB2 phy
Content-Language: en-US
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-3-varadarajan.narayanan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251218061557.1999367-3-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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



On 18/12/2025 07:15, Varadarajan Narayanan wrote:
> Imported from Linux driver.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/phy/qcom/phy-qcom-qusb2.c | 42 +++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
> index d98f6108e69..df82f2a99da 100644
> --- a/drivers/phy/qcom/phy-qcom-qusb2.c
> +++ b/drivers/phy/qcom/phy-qcom-qusb2.c
> @@ -152,6 +152,22 @@ enum qusb2phy_reg_layout {
>  		.offset = o, .val = v, .in_layout = 1, \
>  	}
>  
> +static const struct qusb2_phy_init_tbl ipq6018_init_tbl[] = {
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL, 0x14),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xF8),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xB3),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0x83),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0xC0),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE5, 0x00),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TEST2, 0x14),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TEST, 0x80),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9F),
> +};
> +
>  static const struct qusb2_phy_init_tbl sm6115_init_tbl[] = {
>  	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
>  	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x53),
> @@ -168,6 +184,19 @@ static const struct qusb2_phy_init_tbl sm6115_init_tbl[] = {
>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
>  };
>  
> +static const unsigned int ipq6018_regs_layout[] = {
> +	[QUSB2PHY_PLL_STATUS]		= 0x38,
> +	[QUSB2PHY_PORT_TUNE1]		= 0x80,
> +	[QUSB2PHY_PORT_TUNE2]		= 0x84,
> +	[QUSB2PHY_PORT_TUNE3]		= 0x88,
> +	[QUSB2PHY_PORT_TUNE4]		= 0x8C,
> +	[QUSB2PHY_PORT_TUNE5]		= 0x90,
> +	[QUSB2PHY_PORT_TEST1]		= 0x98,
> +	[QUSB2PHY_PORT_TEST2]		= 0x9C,
> +	[QUSB2PHY_PORT_POWERDOWN]	= 0xB4,
> +	[QUSB2PHY_INTR_CTRL]		= 0xBC,
> +};
> +
>  static const unsigned int sm6115_regs_layout[] = {
>  	[QUSB2PHY_PLL_STATUS] = 0x38,	  [QUSB2PHY_PORT_TUNE1] = 0x80,
>  	[QUSB2PHY_PORT_TUNE2] = 0x84,	  [QUSB2PHY_PORT_TUNE3] = 0x88,
> @@ -224,6 +253,17 @@ static const unsigned int qusb2_v2_regs_layout[] = {
>  	[QUSB2PHY_INTR_CTRL] = 0x230,
>  };
>  
> +static const struct qusb2_phy_cfg ipq6018_phy_cfg = {
> +	.tbl            = ipq6018_init_tbl,
> +	.tbl_num        = ARRAY_SIZE(ipq6018_init_tbl),
> +	.regs           = ipq6018_regs_layout,
> +
> +	.disable_ctrl   = POWER_DOWN,
> +	.mask_core_ready = PLL_LOCKED,
> +	/* autoresume not used */
> +	.autoresume_en   = BIT(0),
> +};
> +
>  static const struct qusb2_phy_cfg sm6115_phy_cfg = {
>  	.tbl = sm6115_init_tbl,
>  	.tbl_num = ARRAY_SIZE(sm6115_init_tbl),
> @@ -455,6 +495,8 @@ static const struct udevice_id qusb2phy_ids[] = {
>  	  .data = (ulong)&sm6115_phy_cfg },
>  	{ .compatible = "qcom,sdm660-qusb2-phy",
>  	  .data = (ulong)&sdm660_phy_cfg },
> +	{ .compatible = "qcom,ipq9574-qusb2-phy",
> +	  .data = (ulong)&ipq6018_phy_cfg },
>  	{ .compatible = "qcom,sm6115-qusb2-phy",
>  	  .data = (ulong)&sm6115_phy_cfg },
>  	{ .compatible = "qcom,qusb2-v2-phy", .data = (ulong)&qusb2_v2_phy_cfg },

-- 
// Casey (she/her)

