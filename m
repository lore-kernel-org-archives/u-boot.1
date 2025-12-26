Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA89E8FDA5
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 10:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04B93841C2;
	Fri, 26 Dec 2025 11:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aP6afwaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D51841CF; Fri, 26 Dec 2025 11:29:43 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD09783B95
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 11:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3865442088;
 Fri, 26 Dec 2025 10:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE142C4CEF7;
 Fri, 26 Dec 2025 10:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766744979;
 bh=RNIMsOTwWJ/XhJRYF3i+cR5K/ht6+jP2nZnhTcYQhwk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aP6afwaqMECeu3J3WBWATmHsb4Q8MB7EIebem9b7jpjce7KvHHE49vYPy9wsj3HHH
 +vNyJ7PWhIxQDxwhmPM5LQ8V2RcpnjeVyztB6Bw2Q6TUB9E1VbXgKB586oqJvYUgm7
 kZzUrXqJVT1VGUBtxy6SkQ3cq/qFI7Y9gexoS5CdjjTW22ynZgab3dRfV+ZqY2j7I9
 MjZb8GW7LWRktCPytWjVMM15BVrVE5uxnAvxn7UgXIxjwerDw7Aa0gOA/lslPt7e4U
 MWb/6GIdtUTgbLGK9fk8TQWtJFwwYOO2Qv3zRF675UavYctGRN3AsHfqiWcYGYF+1Y
 JEsAHRZXk3M7w==
Date: Fri, 26 Dec 2025 15:59:30 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 3/3] phy: qcom: qusb2: Add QCS615 QUSB2 PHY support
Message-ID: <aU5jiji7JN0AItZZ@sumit-xelite>
References: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
 <20251114063804.3835132-4-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114063804.3835132-4-balaji.selvanathan@oss.qualcomm.com>
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

On Fri, Nov 14, 2025 at 12:08:04PM +0530, Balaji Selvanathan wrote:
> Add support for QCS615 QUSB2 PHY by introducing platform-specific
> initialization table and register layout. The implementation reuses
> the IPQ6018 register layout and defines QCS615-specific tuning
> parameters for proper USB PHY operation.
> 
> This change is based on the upstream Linux kernel implementation:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-qusb2.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0
>

This kernel reference doesn't contain qcs615 specific implementation.
Once you update that, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/phy/qcom/phy-qcom-qusb2.c | 38 +++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
> index d98f6108e69..a5d724eebd4 100644
> --- a/drivers/phy/qcom/phy-qcom-qusb2.c
> +++ b/drivers/phy/qcom/phy-qcom-qusb2.c
> @@ -176,6 +176,19 @@ static const unsigned int sm6115_regs_layout[] = {
>  	[QUSB2PHY_PORT_POWERDOWN] = 0xb4, [QUSB2PHY_INTR_CTRL] = 0xbc,
>  };
>  
> +static const unsigned int ipq6018_regs_layout[] = {
> +	[QUSB2PHY_PLL_STATUS] = 0x38,
> +	[QUSB2PHY_PORT_TUNE1] = 0x80,
> +	[QUSB2PHY_PORT_TUNE2] = 0x84,
> +	[QUSB2PHY_PORT_TUNE3] = 0x88,
> +	[QUSB2PHY_PORT_TUNE4] = 0x8C,
> +	[QUSB2PHY_PORT_TUNE5] = 0x90,
> +	[QUSB2PHY_PORT_TEST1] = 0x98,
> +	[QUSB2PHY_PORT_TEST2] = 0x9C,
> +	[QUSB2PHY_PORT_POWERDOWN] = 0xB4,
> +	[QUSB2PHY_INTR_CTRL] = 0xBC,
> +};
> +
>  static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
>  	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
>  	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xb3),
> @@ -189,6 +202,19 @@ static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
>  };
>  
> +static const struct qusb2_phy_init_tbl qcs615_init_tbl[] = {
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xc8),
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
>  static const struct qusb2_phy_init_tbl qusb2_v2_init_tbl[] = {
>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
> @@ -248,6 +274,16 @@ static const struct qusb2_phy_cfg sdm660_phy_cfg = {
>  	.autoresume_en = BIT(3),
>  };
>  
> +static const struct qusb2_phy_cfg qcs615_phy_cfg = {
> +	.tbl = qcs615_init_tbl,
> +	.tbl_num = ARRAY_SIZE(qcs615_init_tbl),
> +	.regs = ipq6018_regs_layout,
> +
> +	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
> +	.mask_core_ready = PLL_LOCKED,
> +	.autoresume_en = BIT(0),
> +};
> +
>  static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
>  	.tbl = qusb2_v2_init_tbl,
>  	.tbl_num = ARRAY_SIZE(qusb2_v2_init_tbl),
> @@ -453,6 +489,8 @@ static const struct udevice_id qusb2phy_ids[] = {
>  	{ .compatible = "qcom,qusb2-phy" },
>  	{ .compatible = "qcom,qcm2290-qusb2-phy",
>  	  .data = (ulong)&sm6115_phy_cfg },
> +	{ .compatible = "qcom,qcs615-qusb2-phy",
> +	  .data = (ulong)&qcs615_phy_cfg },
>  	{ .compatible = "qcom,sdm660-qusb2-phy",
>  	  .data = (ulong)&sdm660_phy_cfg },
>  	{ .compatible = "qcom,sm6115-qusb2-phy",
> -- 
> 2.34.1
> 
