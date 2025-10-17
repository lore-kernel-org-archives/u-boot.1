Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D90CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 921D48394A;
	Fri, 17 Oct 2025 17:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="XIoBdsPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA2768386D; Fri, 17 Oct 2025 17:27:21 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0113583826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C5EA025C64;
 Fri, 17 Oct 2025 17:27:19 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bVtMl_uq_frD; Fri, 17 Oct 2025 17:27:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714839; bh=5EC3efI2+spxiVjGvtZiB2Qp/4WP8TBCwhVyXPR0X6U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XIoBdsPT9WgFrf2n9XeGOFLPnYTtpRGvvKEflAV/X+vk3mDAIK5DxqNhD4D1Gh1mj
 goSIrnFVRndiC+1s/j1FuLGSbusY1s4W6vDglwMun1JiWCftBXPAmLn6jRGfK1wpQH
 +OQSZJIqGVyeQ9qXq/CbPu2bE3A++ZhhMEUjI4L1FXW6O5Uclu7E1JAMBaqRLRBDQM
 AI7pxmxkwnBralnBA9cC4xVl3CrIPGRHbx6JxIB8ThjJUPCq8SR7cKGGqC4VYluuRO
 kFEqwlTgV8rpgSwcRPo/SOooCbODMxPM1g4nQAQRGnq33KurZAq9N+f2tC44+NVFEZ
 ds71ijMGeFauA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:57:06 +0530
Subject: [PATCH 1/2] phy: samsung: add enum for variants based on SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-phy-usb-exynos7870-v1-1-5885b00f0c87@disroot.org>
References: <20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org>
In-Reply-To: <20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org>
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714832; l=2772;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=5EC3efI2+spxiVjGvtZiB2Qp/4WP8TBCwhVyXPR0X6U=;
 b=923+VUhBQHpeNiiXqMDTbraoXUbeI2fnCNzm/q4Xiy+WOraaPw1P9q0mAwTWV7bJaoqHaihrN
 ZNfqLPvmIsdBCmctety3Nvkg3fIc5H04+h4BO7CMEbWf1Y1SWbspbqU
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

The variant enum is used to uniquely identify which SoC the PHY block
belongs to. It is initially set in the match table, along with the
compatible string, it gets copied to driver data struct during probe.

SoC specific functions must only be called if the respective variant
enum is set. Add switch-case blocks wherever required.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/phy/phy-exynos-usbdrd.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-exynos-usbdrd.c b/drivers/phy/phy-exynos-usbdrd.c
index db5815ed1840caf4f01517a382cb1f471636bbfa..4ab8da2a08ff80fcc95f386958f345bba979f9c2 100644
--- a/drivers/phy/phy-exynos-usbdrd.c
+++ b/drivers/phy/phy-exynos-usbdrd.c
@@ -66,6 +66,10 @@
 #define KHZ					1000
 #define MHZ					(KHZ * KHZ)
 
+enum exynos_usbdrd_phy_variant {
+	EXYNOS850_USBDRD_PHY,
+};
+
 /**
  * struct exynos_usbdrd_phy - driver data for Exynos USB PHY
  * @reg_phy: USB PHY controller register memory base
@@ -73,6 +77,7 @@
  * @core_clk: core clock for phy (ref clock)
  * @reg_pmu: regmap for PMU block
  * @extrefclk: frequency select settings when using 'separate reference clocks'
+ * @variant: ID to uniquely distinguish USB PHY variant
  */
 struct exynos_usbdrd_phy {
 	void __iomem *reg_phy;
@@ -80,6 +85,7 @@ struct exynos_usbdrd_phy {
 	struct clk *core_clk;
 	struct regmap *reg_pmu;
 	u32 extrefclk;
+	enum exynos_usbdrd_phy_variant variant;
 };
 
 static void exynos_usbdrd_phy_isol(struct regmap *reg_pmu, bool isolate)
@@ -254,7 +260,13 @@ static int exynos_usbdrd_phy_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	exynos850_usbdrd_utmi_init(phy);
+	switch (phy_drd->variant) {
+	case EXYNOS850_USBDRD_PHY:
+		exynos850_usbdrd_utmi_init(phy);
+		break;
+	default:
+		dev_err(phy->dev, "Failed to recognize phy variant\n");
+	}
 
 	clk_disable_unprepare(phy_drd->clk);
 
@@ -270,7 +282,13 @@ static int exynos_usbdrd_phy_exit(struct phy *phy)
 	if (ret)
 		return ret;
 
-	exynos850_usbdrd_utmi_exit(phy);
+	switch (phy_drd->variant) {
+	case EXYNOS850_USBDRD_PHY:
+		exynos850_usbdrd_utmi_exit(phy);
+		break;
+	default:
+		dev_err(phy->dev, "Failed to recognize phy variant\n");
+	}
 
 	clk_disable_unprepare(phy_drd->clk);
 
@@ -359,6 +377,8 @@ static int exynos_usbdrd_phy_probe(struct udevice *dev)
 		return err;
 	}
 
+	phy_drd->variant = dev_get_driver_data(dev);
+
 	return 0;
 }
 
@@ -372,6 +392,7 @@ static const struct phy_ops exynos_usbdrd_phy_ops = {
 static const struct udevice_id exynos_usbdrd_phy_of_match[] = {
 	{
 		.compatible = "samsung,exynos850-usbdrd-phy",
+		.data = EXYNOS850_USBDRD_PHY,
 	},
 	{ }
 };

-- 
2.51.0

