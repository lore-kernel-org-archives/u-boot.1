Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EB7C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 05:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9081481F66;
	Fri, 27 Jun 2025 07:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751003410;
	bh=szj+8jJ/qQmRFNG0hK+i5Ers2x0VCdL3lIdgC9x2M4s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L/BPTi1EytTk1f+h6TGt3e9GtOPueyStSqjU8/r23rkqC+b700fGP6OSXAinJJjyG
	 Cn4Lu159lGpTOweQZAdnnWq8i3SItFc6Bx5DAVLp4Ms/R92icLZA8ezDMzvl6Z5t7o
	 ggHug7xB3gHx/lKd+KTB/EDK6oFTwAUa2O1umWiZdtln9IXO2ahvRinzax2nJ8KfdO
	 X8WNpMwL7g0tHsn2Nxr6ZGntufKEYwKEBPLZr1EBmNQCKHEJCknA5rOCNII2mkLxV0
	 FBxv8YSwwbKW3Eis+sv04jMsd23VjoCtXHf7cWPasRMOy8j7tu7PLO5XVDlNHikIdn
	 bw4p4Ly0gXFcg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA0182B34; Fri, 27 Jun 2025 07:50:09 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFE680C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 07:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="RluYqRNO"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 38CF910397285; 
 Fri, 27 Jun 2025 07:50:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1751003404; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=szj+8jJ/qQmRFNG0hK+i5Ers2x0VCdL3lIdgC9x2M4s=;
 b=RluYqRNOAd12YQuOBcYJKBAJ5+iXPT4f+FplYwgb1kv2Lc3O18tpz/8tm5ztWmCCCBrvr4
 DTEES+A+esHviLrZSfboHa1FTUF05BocodUtm1K2JmMAnwnMMp7NqZVJxYfqaMl6xPtk/c
 PacSKeEAwfW3XDqDlw3EMYJxKGkTzdORs1ht+tFS09bEDN+9/DgPbhv6xoxT7ocbk88Crl
 hbYYrQHjclFpt3PMwRuUefvphqJsPnll2Na5/9BtytNwCelXWXBVH09HUIlSJAr2HT1Lc9
 PFp2vhqPJUfSCl1vduSZ6GvbS7f6U/wj+XpW75sDmGTtYTBjawRFjkgwONpS1Q==
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, Gary Bisson <bisson.gary@gmail.com>,
 Jonathan Currier <dullfire@yahoo.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Jesse Taube <mr.bossman075@gmail.com>,
 u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] arm: pinctrl: Define .mux_mask field for NXP's SoC
Date: Fri, 27 Jun 2025 07:49:43 +0200
Message-Id: <20250627054943.3140496-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The commit e8a9521e649f
("vf500/vf610: synchronise device trees with linux")
has synchronized U-Boot's DTS with v5.19 Linux kernel.
It turned out that in Linux's upstream iomuxc node description the
'fsl,mux_mask' was missing, so the U-Boot's pinctrl driver for NXP's
Vybrid SoC was not working properly.

As by default the mux mask was set to 0, for example the vf610 based
boards (like BK4) were bricked, due to misconfiguration of gpio at
early boot stage.

The fix for all NXP eligible boards is to define .mux_mask field for
soc specific *pinctrl_soc_info structure and use it directly in pinctrl
MMIO driver, without the need to read the "fsl,mux_mask" property from
device tree.

This change brings the NXP's pinctrl driver in U-Boot closer to Linux
upstream one.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi   | 1 -
 arch/arm/dts/imxrt1020.dtsi            | 1 -
 arch/arm/dts/imxrt1170.dtsi            | 1 -
 drivers/pinctrl/nxp/pinctrl-imx-mmio.c | 1 -
 drivers/pinctrl/nxp/pinctrl-imx8ulp.c  | 2 ++
 drivers/pinctrl/nxp/pinctrl-imxrt.c    | 1 +
 drivers/pinctrl/nxp/pinctrl-vf610.c    | 1 +
 7 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index f67fe166d31..845fe205925 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -28,7 +28,6 @@
 
 &iomuxc1 {
 	bootph-pre-ram;
-	fsl,mux_mask = <0xf00>;
 };
 
 &pinctrl_lpuart5 {
diff --git a/arch/arm/dts/imxrt1020.dtsi b/arch/arm/dts/imxrt1020.dtsi
index 13511ebb18e..336aeedb2ce 100644
--- a/arch/arm/dts/imxrt1020.dtsi
+++ b/arch/arm/dts/imxrt1020.dtsi
@@ -64,7 +64,6 @@
 		iomuxc: iomuxc@401f8000 {
 			compatible = "fsl,imxrt-iomuxc";
 			reg = <0x401f8000 0x4000>;
-			fsl,mux_mask = <0x7>;
 		};
 
 		anatop: anatop@400d8000 {
diff --git a/arch/arm/dts/imxrt1170.dtsi b/arch/arm/dts/imxrt1170.dtsi
index 08665eaf06a..7566402353a 100644
--- a/arch/arm/dts/imxrt1170.dtsi
+++ b/arch/arm/dts/imxrt1170.dtsi
@@ -77,7 +77,6 @@
 		iomuxc: iomuxc@400e8000 {
 			compatible = "fsl,imxrt-iomuxc";
 			reg = <0x400e8000 0x4000>;
-			fsl,mux_mask = <0x7>;
 		};
 
 		anatop: anatop@40c84000 {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-mmio.c b/drivers/pinctrl/nxp/pinctrl-imx-mmio.c
index 6ee108a0120..2f4228a9fc5 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-mmio.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-mmio.c
@@ -187,7 +187,6 @@ int imx_pinctrl_probe_mmio(struct udevice *dev)
 		return -ENOMEM;
 	priv->info = info;
 
-	info->mux_mask = ofnode_read_u32_default(node, "fsl,mux_mask", 0);
 	/*
 	 * Refer to linux documentation for details:
 	 * Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
index 2df63625191..3e8c080d3fd 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
@@ -11,10 +11,12 @@
 
 static struct imx_pinctrl_soc_info imx8ulp_pinctrl_soc_info0 = {
 	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG | CFG_IBE_OBE,
+	.mux_mask = 0xf00,
 };
 
 static struct imx_pinctrl_soc_info imx8ulp_pinctrl_soc_info1 = {
 	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG | CFG_IBE_OBE,
+	.mux_mask = 0xf00,
 };
 
 static const struct udevice_id imx8ulp_pinctrl_match[] = {
diff --git a/drivers/pinctrl/nxp/pinctrl-imxrt.c b/drivers/pinctrl/nxp/pinctrl-imxrt.c
index 39000ceb923..7e55d596248 100644
--- a/drivers/pinctrl/nxp/pinctrl-imxrt.c
+++ b/drivers/pinctrl/nxp/pinctrl-imxrt.c
@@ -11,6 +11,7 @@
 
 static struct imx_pinctrl_soc_info imxrt_pinctrl_soc_info = {
 	.flags = ZERO_OFFSET_VALID,
+	.mux_mask = 0x7,
 };
 
 static const struct udevice_id imxrt_pinctrl_match[] = {
diff --git a/drivers/pinctrl/nxp/pinctrl-vf610.c b/drivers/pinctrl/nxp/pinctrl-vf610.c
index cbff8dcefd8..7d1b95eaa05 100644
--- a/drivers/pinctrl/nxp/pinctrl-vf610.c
+++ b/drivers/pinctrl/nxp/pinctrl-vf610.c
@@ -11,6 +11,7 @@
 
 static struct imx_pinctrl_soc_info vf610_pinctrl_soc_info = {
 	.flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
+	.mux_mask = 0x700000,
 };
 
 static const struct udevice_id vf610_pinctrl_match[] = {
-- 
2.39.5

