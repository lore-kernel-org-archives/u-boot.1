Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2853D78777
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 14:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E69D80077;
	Fri, 19 Dec 2025 15:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BCamZVw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE16808AF; Fri, 19 Dec 2025 15:00:18 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9F780050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 15:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0AF0760008;
 Fri, 19 Dec 2025 14:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A9BC4CEF1;
 Fri, 19 Dec 2025 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766152813;
 bh=DhO+8aUUGKUv8bH1yit1nMIT9zu7kcmSGAr70IzpYA4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BCamZVw2w/PDQkj4sOYvEcnxlGgXWljVZag4GCkzrYBOowEAKtxDNeRV/Y0Rkeg/J
 L4aXnElmeno1+d4AjIN3NNUDFvzQJ2+wjEKM/4r6W0dlAVZnxdPhCI623kaD4kW5BS
 jlDzJgV4wpIUe8fN/bXweUzcFpj8weiI7N/9MW8+cW0+u2ic2JozygOFvrpYU9mGJq
 d+Ns8YaWw2pWa9rXh/86Vu2l5CBcuRbbsEq+E1kzC9Rk0mn6lcm5a5FGh9+mMtPohz
 meNXKnEDMoTxG7zpXpP0fRX6arz2TajYoqYDBO4HwLB+PpbWXeToxVXvq5B/9unR6m
 WScErcF3DupDQ==
Date: Fri, 19 Dec 2025 19:30:04 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [RESEND v2 2/6] phy: Add IPQ9574 support to Qualcomm QUSB2 phy
Message-ID: <aUVaZEYltFOfxeZh@sumit-xelite>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-3-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218061557.1999367-3-varadarajan.narayanan@oss.qualcomm.com>
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

On Thu, Dec 18, 2025 at 11:45:53AM +0530, Varadarajan Narayanan wrote:
> Imported from Linux driver.

Kindly add information as to which kernel driver commit you have used to
import this code.

-Sumit

> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
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
> -- 
> 2.34.1
> 
