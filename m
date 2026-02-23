Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82467EC110E
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7419483D0F;
	Mon, 23 Feb 2026 18:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="BFKS5YA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE5483BC9; Mon, 23 Feb 2026 15:25:35 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDBC880077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AA09E27E79;
 Mon, 23 Feb 2026 15:25:32 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WOcAYHWu4TW4; Mon, 23 Feb 2026 15:25:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1771856732; bh=DjXuRHDt+uPixuvScFG3LlmvWE4SgeQ6VGATcMJDU/o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BFKS5YA1KpLyC7jput+zZsHMkoCQhlaOyVpXRvKdTzVPhx4NnE2kOkNraRMLte9od
 RFiMCqMjZ3k1OinRi65HxFJBL5RpMGplQfot0+Bh6+I4mbjLSZjABGGy3HUPYreWGZ
 LK6w5nQxw1XC9xgHgJVjOanciVC2KZ8E0V05Zlrvvpt9YrN86p3qh4Z3C1AXmD55uo
 c0h/+RtkXCd5FXLoJATTjWwQa3gpN/dPZ/VnItQsnqG4oIyDA1aZs1Z6V1VP93DFd5
 AZK0The+rHg3C6v+Mj2VmHafoSGDj7ENiioEaOEjncjCp+2CPoo1SZhkT/zt8wjysG
 GjoCliJhk29lg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 23 Feb 2026 19:55:23 +0530
Subject: [PATCH v2 1/2] phy: samsung: add enum for variants based on SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-phy-usb-exynos7870-v2-1-5e91a25ef42d@disroot.org>
References: <20260223-phy-usb-exynos7870-v2-0-5e91a25ef42d@disroot.org>
In-Reply-To: <20260223-phy-usb-exynos7870-v2-0-5e91a25ef42d@disroot.org>
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 23 Feb 2026 18:29:27 +0100
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/phy/phy-exynos-usbdrd.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-exynos-usbdrd.c b/drivers/phy/phy-exynos-usbdrd.c
index db5815ed184..4ab8da2a08f 100644
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
2.52.0

