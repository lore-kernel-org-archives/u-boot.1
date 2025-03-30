Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D8EC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E11800C1;
	Sun, 30 Mar 2025 16:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iniI6Mjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD1B81DE3; Sun, 30 Mar 2025 16:49:09 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F137280050
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so19386715e9.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743346146; x=1743950946; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EZl4zZItBZvah0CkH4pbCYfvWqD497lhFHlY3MCdU/E=;
 b=iniI6Mjxeu0CeLFbFvTxzz6F9elc/l2+a83v9TIoPlVSlLZWmZU5C0ylMOsnZSqYEI
 F+Avy7JSWpgJvNx68BhPTm7feW3LPNx0A1reZm5NSeJm3MSEzc4wknYn9kODrNi7IhqX
 urHUoLHlb1kg+yAPXM4e+4Iqc8FNZpMQ2to0PIjQsRHJTmoLUihziF857WVcVRxUXcGc
 K9xeZhZqtywhnb3M7F4T/u5NJxiNsQ5rSAaXCdPfgUlmuX3k3BntxhYlN4xQEVYV7yi2
 N142gnAqeHFo3JE53FKjrXK9oBepv2BdTew3JLtd34hbSEphJoHKl0DuwT5hJdZWlzGI
 VyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743346146; x=1743950946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EZl4zZItBZvah0CkH4pbCYfvWqD497lhFHlY3MCdU/E=;
 b=Vc3b+oGib9NorUKBwShQVEz/Eqxs6yA7DhLwoOauaasEdYphcVoiIzMoiI7ijaY+Pa
 GnzUATxTovXTvYcKcyROY3/JpkaWVSHQc0gzqadKaHYbaiG+5z2NZhHknBrxGLkrdhue
 yC48ww78csWnJiTeZyLYzKnQLaa4+UvxAMZC0J9dSMrZ7i2mDAJutit/12KH6Elxn3gx
 HznE4rmfNQ8qg5vmWg/C3DgMdJQnbcmz+95F4TbOF+6hlxFDLluWAGldSPO6Hy6C/MQF
 jW9jfaiQz3gDhz7t546YEFkdQq6Fx5Dx6wis9mo8pMU5IoKbbUKPDLWIGRFqHSXPB+OI
 Tm4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/O9TF3j0uCK8cKgjXoSqole4Pm0llIoJiq21IAzbiMXyrzax8SYFAvb1bpFdoLNQk1nl1DGU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy14mzZRPkZbsZwc1Rm3aCW6AE3aInVnu8APU0yidSqamUGImxJ
 rBroX/r/2pabkG7o63hTzrDsV9hOE7isFO67bUPw/VCwffhIOtkJeFvS1v7i1d4=
X-Gm-Gg: ASbGnctuCKox76OG9IpHdGCH6sWE5iOErQKYd+GMAuGMK5R6RO9RDJCYLbr1N9N9npn
 L1b0SDxoaCVNzD9lJYuzZdrMmyuVY3m+OY7yGXJZjW9AINNi080ORPDoWqAYjL3yfhKS1F6ZcKI
 Gz6va0NayuuZMkqyDyNesRjh9mpep3Pnyhw/onkKTkK9IztKepmGf3KvaOYJVsqm8XnD3ECigwR
 N5pOEv8MHgVV7BPL/cHKWguZdi9Fl1Rj0MKWDCERoRxeKa4h4Eg3MzlqUGoyU6FJFZTTnvqoWAy
 3P1Xn9S4OPvSQOPkqdx92pfEz7xuVqJzgBJyEmzT/QRQ+klXO5cXcQp6IhQ6nYBUaTbI6ZW1BEc
 =
X-Google-Smtp-Source: AGHT+IHIBV7Xjw0NTMtKoadKJVKXBCRK0a/5NcBRlzv3aNhUCbBTJTR/v4MExOBecPiIqHIGJk8h7g==
X-Received: by 2002:a05:6000:40cd:b0:390:e7c1:59d3 with SMTP id
 ffacd0b85a97d-39c120cb878mr4074138f8f.2.1743346146414; 
 Sun, 30 Mar 2025 07:49:06 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm8860098f8f.10.2025.03.30.07.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 07:49:05 -0700 (PDT)
Message-ID: <976d3ad7-2b81-4577-aba7-ae72f8a4311a@linaro.org>
Date: Sun, 30 Mar 2025 16:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: Add SDM660 support to Qualcomm QUSB2 phy
To: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Alexey Minnekhanov <alexeymin@postmarketos.org>
References: <20250325083713.2425430-1-alexeymin@postmarketos.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250325083713.2425430-1-alexeymin@postmarketos.org>
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



On 3/25/25 09:37, Alexey Minnekhanov via groups.io wrote:
> Imported from Linux driver.
> 
> Note that already existing but previously unused member of
> struct qusb2_phy::has_se_clk_scheme is now utilized for it's
> purpose.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/phy/qcom/phy-qcom-qusb2.c | 42 ++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
> index c91ba18c4ab..cabd05bf5a6 100644
> --- a/drivers/phy/qcom/phy-qcom-qusb2.c
> +++ b/drivers/phy/qcom/phy-qcom-qusb2.c
> @@ -122,6 +122,9 @@ struct qusb2_phy_cfg {
>   
>   	/* true if PHY has PLL_CORE_INPUT_OVERRIDE register to reset PLL */
>   	bool has_pll_override;
> +
> +	/* true if PHY default clk scheme is single-ended */
> +	bool se_clk_scheme_default;
>   };
>   
>   /* set of registers with offsets different per-PHY */
> @@ -173,6 +176,19 @@ static const unsigned int sm6115_regs_layout[] = {
>   	[QUSB2PHY_PORT_POWERDOWN] = 0xb4, [QUSB2PHY_INTR_CTRL] = 0xbc,
>   };
>   
> +static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xb3),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0x83),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0xc0),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TEST2, 0x14),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9f),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
> +};
> +
>   static const struct qusb2_phy_init_tbl qusb2_v2_init_tbl[] = {
>   	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
>   	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
> @@ -219,6 +235,18 @@ static const struct qusb2_phy_cfg sm6115_phy_cfg = {
>   	.autoresume_en = BIT(3),
>   };
>   
> +static const struct qusb2_phy_cfg sdm660_phy_cfg = {
> +	.tbl = msm8996_init_tbl,
> +	.tbl_num = ARRAY_SIZE(msm8996_init_tbl),
> +	.regs = sm6115_regs_layout,
> +
> +	.has_pll_test = true,
> +	.se_clk_scheme_default = false,
> +	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
> +	.mask_core_ready = PLL_LOCKED,
> +	.autoresume_en = BIT(3),
> +};
> +
>   static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
>   	.tbl = qusb2_v2_init_tbl,
>   	.tbl_num = ARRAY_SIZE(qusb2_v2_init_tbl),
> @@ -316,8 +344,18 @@ static int qusb2phy_power_on(struct phy *phy)
>   	/* Required to get phy pll lock successfully */
>   	udelay(150);
>   
> +	/*
> +	 * Not all the SoCs have got a readable TCSR_PHY_CLK_SCHEME
> +	 * register in the TCSR so, if there's none, use the default
> +	 * value hardcoded in the configuration.
> +	 */
> +	qphy->has_se_clk_scheme = cfg->se_clk_scheme_default;
> +
>   	if (cfg->has_pll_test) {
> -		val |= CLK_REF_SEL;
> +		if (!qphy->has_se_clk_scheme)
> +			val &= ~CLK_REF_SEL;
> +		else
> +			val |= CLK_REF_SEL;
>   
>   		writel(val, qphy->base + QUSB2PHY_PLL_TEST);
>   
> @@ -413,6 +451,8 @@ static const struct udevice_id qusb2phy_ids[] = {
>   	{ .compatible = "qcom,qusb2-phy" },
>   	{ .compatible = "qcom,qcm2290-qusb2-phy",
>   	  .data = (ulong)&sm6115_phy_cfg },
> +	{ .compatible = "qcom,sdm660-qusb2-phy",
> +	  .data = (ulong)&sdm660_phy_cfg },
>   	{ .compatible = "qcom,sm6115-qusb2-phy",
>   	  .data = (ulong)&sm6115_phy_cfg },
>   	{ .compatible = "qcom,qusb2-v2-phy", .data = (ulong)&qusb2_v2_phy_cfg },

-- 
Caleb (they/them)

