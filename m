Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C10D6552C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA73C83AA0;
	Wed, 17 Dec 2025 13:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eDc+K1T5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B4383AB7; Wed, 17 Dec 2025 13:05:20 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92CFB839FA
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 13:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 466216018E;
 Wed, 17 Dec 2025 12:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CCFC4CEF5;
 Wed, 17 Dec 2025 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765973116;
 bh=3/VRIX17cxeA69Z6j+AMBD4B/Nh8qHPHYZkdcQ2vzs8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eDc+K1T5nCKvyT3ZhnrORYnx073n8fURhbX7lXjkoEuaLHQYXPjT39zImOORarJKJ
 ydj4DaU8DjWWFVM+t8GBuN+unZO+UQklYX68sv7aQuBmId1/nujZ7fTXCotAaxYqTI
 NUa6GV0m2q2z0sFd4jlhpCtjBR3mtMRpFtaQugUilry46DL59MNUgG8LXtRZsXG08W
 U5M2KLFR2kIFj2+OJZRFAvRyL1PEgcB6/PGyLxo/yTtA6MNj0fg6oXFzSXZcj2s6hj
 ZY2uxQ8swg3pg3wEX/nh1p+ARuYn79yQu1DL4wl873yGSmDFT/bMerxFgxNcfsyrtz
 boSDyLO4n1LrA==
Date: Wed, 17 Dec 2025 17:35:09 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: nathbappai@gmail.com
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH] phy: Add MSM8996 support to Qualcomm QUSB2 phy
Message-ID: <aUKcdakCf2N4-A02@sumit-xelite>
References: <20251207184919.12202-1-nathbappai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207184919.12202-1-nathbappai@gmail.com>
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

On Sun, Dec 07, 2025 at 06:49:19PM +0000, nathbappai@gmail.com wrote:
> From: Biswapriyo Nath <nathbappai@gmail.com>
> 
> This change is imported from Linux driver and tested with SM6125 SoC.
> Note, the msm8996_phy_cfg struct is same as sdm660_phy_cfg but
> qusb2_phy_cfg::se_clk_scheme_default differs only.
> 
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
> ---
> 
>  drivers/phy/qcom/phy-qcom-qusb2.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
> index d98f6108..9e821365 100644
> --- a/drivers/phy/qcom/phy-qcom-qusb2.c
> +++ b/drivers/phy/qcom/phy-qcom-qusb2.c
> @@ -224,6 +224,18 @@ static const unsigned int qusb2_v2_regs_layout[] = {
>  	[QUSB2PHY_INTR_CTRL] = 0x230,
>  };
>  
> +static const struct qusb2_phy_cfg msm8996_phy_cfg = {
> +	.tbl = msm8996_init_tbl,
> +	.tbl_num = ARRAY_SIZE(msm8996_init_tbl),
> +	.regs = sm6115_regs_layout,
> +
> +	.has_pll_test = true,
> +	.se_clk_scheme_default = true,
> +	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
> +	.mask_core_ready = PLL_LOCKED,
> +	.autoresume_en = BIT(3),
> +};
> +
>  static const struct qusb2_phy_cfg sm6115_phy_cfg = {
>  	.tbl = sm6115_init_tbl,
>  	.tbl_num = ARRAY_SIZE(sm6115_init_tbl),
> @@ -450,6 +462,8 @@ static struct phy_ops qusb2phy_ops = {
>  };
>  
>  static const struct udevice_id qusb2phy_ids[] = {
> +	{ .compatible = "qcom,msm8996-qusb2-phy",
> +	  .data = (ulong)&msm8996_phy_cfg },
>  	{ .compatible = "qcom,qusb2-phy" },
>  	{ .compatible = "qcom,qcm2290-qusb2-phy",
>  	  .data = (ulong)&sm6115_phy_cfg },
> -- 
> 2.52.0
> 
> base-commit: c7c2c3c0101f625c01bf101d652e03a6d4aa950f
> branch: master
