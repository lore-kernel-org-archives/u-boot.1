Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2A0CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D509F83956;
	Fri, 17 Oct 2025 17:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="KtCq9lDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 592AF83869; Fri, 17 Oct 2025 17:27:27 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3705883826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0493626292;
 Fri, 17 Oct 2025 17:27:25 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9oHMvFVb5wRw; Fri, 17 Oct 2025 17:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714843; bh=zWxaOSuFOwOnWg2o9Yj3a4SAvPqy3QP+H+LeRINHpDE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KtCq9lDOaBKM1yu6BgOvFhhiNp/zzA2qfV0mcJ09XhlgS0bI0K0ulkf5D7HHAD0g1
 D6fPRdpqQFoAZypw79WSIHdVwFlKd3SPczqzcJS/iiazutfgFknrwMC/irFBaSi7Ta
 EzBqFwwzcLp6eBHy4lz7UhUBJqgU3C2BKK6jeSGQsGlNEE0s6dhz8ZOLP2fbJEeouz
 oGWUcSkRGItC+BGDKJEQfe9OivC3XxrRsA8a3vMHs1SDqSZc/sTqs2R/GXeeLfrEkH
 9O+UPU1uX4CExDYVuHlZE6iDzyUV9mlMP0uw+T1EjxOdpGq+SU7r6ubmIicCUvtAJP
 Xuil7JadUT55g==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:57:07 +0530
Subject: [PATCH 2/2] phy: samsung: add support for exynos7870 USB PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-phy-usb-exynos7870-v1-2-5885b00f0c87@disroot.org>
References: <20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org>
In-Reply-To: <20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org>
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714832; l=12499;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=zWxaOSuFOwOnWg2o9Yj3a4SAvPqy3QP+H+LeRINHpDE=;
 b=zMBKew8Zf1qaBlOHzYmqpTkFPecXj8gRnuJu9VZOIMOeyY9puNYaZHWU7exCkRg1YkYZU3wYM
 QrUu3b9APS+DELpetWWNokWTpJUjLu3wZFZbhXf8I5duJ/d7cXg0BGi
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

The USB PHY used by the Exynos7870 SoC has a single USB 2.0 interface.
Add its dedicated variant enum, compatible, and init/exit functions.

The PHY enable bit of Exynos7870's PHY is different in contrast to that
of Exynos850 and most Exynos PHYs. To allow this change, a simple if
condition is added in exynos_usbdrd_phy_isol() which changes the
bitmask. Since the variant enum is required, the function argument is
changed to accept the driver data itself.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/phy/phy-exynos-usbdrd.c | 246 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 238 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-exynos-usbdrd.c b/drivers/phy/phy-exynos-usbdrd.c
index 4ab8da2a08ff80fcc95f386958f345bba979f9c2..c5eed29a2c8c56e0be2d380263142a4db55f5766 100644
--- a/drivers/phy/phy-exynos-usbdrd.c
+++ b/drivers/phy/phy-exynos-usbdrd.c
@@ -21,6 +21,7 @@
 /* Offset of PMU register controlling USB PHY output isolation */
 #define EXYNOS_USBDRD_PHY_CONTROL		0x0704
 #define EXYNOS_PHY_ENABLE			BIT(0)
+#define EXYNOS7870_PHY_ENABLE			BIT(1)
 
 /* Exynos USB PHY registers */
 #define EXYNOS5_FSEL_9MHZ6			0x0
@@ -32,6 +33,88 @@
 #define EXYNOS5_FSEL_26MHZ			0x6
 #define EXYNOS5_FSEL_50MHZ			0x7
 
+/* Exynos5: USB DRD PHY registers */
+#define EXYNOS5_DRD_LINKSYSTEM			0x04
+#define LINKSYSTEM_XHCI_VERSION_CONTROL		BIT(27)
+#define LINKSYSTEM_FORCE_VBUSVALID		BIT(8)
+#define LINKSYSTEM_FORCE_BVALID			BIT(7)
+#define LINKSYSTEM_FLADJ			GENMASK(6, 1)
+
+#define EXYNOS5_DRD_PHYUTMI			0x08
+#define PHYUTMI_UTMI_SUSPEND_COM_N		BIT(12)
+#define PHYUTMI_UTMI_L1_SUSPEND_COM_N		BIT(11)
+#define PHYUTMI_VBUSVLDEXTSEL			BIT(10)
+#define PHYUTMI_VBUSVLDEXT			BIT(9)
+#define PHYUTMI_TXBITSTUFFENH			BIT(8)
+#define PHYUTMI_TXBITSTUFFEN			BIT(7)
+#define PHYUTMI_OTGDISABLE			BIT(6)
+#define PHYUTMI_IDPULLUP			BIT(5)
+#define PHYUTMI_DRVVBUS				BIT(4)
+#define PHYUTMI_DPPULLDOWN			BIT(3)
+#define PHYUTMI_DMPULLDOWN			BIT(2)
+#define PHYUTMI_FORCESUSPEND			BIT(1)
+#define PHYUTMI_FORCESLEEP			BIT(0)
+
+#define EXYNOS5_DRD_PHYCLKRST			0x10
+#define PHYCLKRST_EN_UTMISUSPEND		BIT(31)
+#define PHYCLKRST_SSC_REFCLKSEL			GENMASK(30, 23)
+#define PHYCLKRST_SSC_RANGE			GENMASK(22, 21)
+#define PHYCLKRST_SSC_EN			BIT(20)
+#define PHYCLKRST_REF_SSP_EN			BIT(19)
+#define PHYCLKRST_REF_CLKDIV2			BIT(18)
+#define PHYCLKRST_MPLL_MULTIPLIER		GENMASK(17, 11)
+#define PHYCLKRST_MPLL_MULTIPLIER_100MHZ_REF	0x19
+#define PHYCLKRST_MPLL_MULTIPLIER_50M_REF	0x32
+#define PHYCLKRST_MPLL_MULTIPLIER_24MHZ_REF	0x68
+#define PHYCLKRST_MPLL_MULTIPLIER_20MHZ_REF	0x7d
+#define PHYCLKRST_MPLL_MULTIPLIER_19200KHZ_REF	0x02
+#define PHYCLKRST_FSEL_PIPE			GENMASK(10, 8)
+#define PHYCLKRST_FSEL_UTMI			GENMASK(7, 5)
+#define PHYCLKRST_FSEL_PAD_100MHZ		0x27
+#define PHYCLKRST_FSEL_PAD_24MHZ		0x2a
+#define PHYCLKRST_FSEL_PAD_20MHZ		0x31
+#define PHYCLKRST_FSEL_PAD_19_2MHZ		0x38
+#define PHYCLKRST_RETENABLEN			BIT(4)
+#define PHYCLKRST_REFCLKSEL			GENMASK(3, 2)
+#define PHYCLKRST_REFCLKSEL_PAD_REFCLK		0x2
+#define PHYCLKRST_REFCLKSEL_EXT_REFCLK		0x3
+#define PHYCLKRST_PORTRESET			BIT(1)
+#define PHYCLKRST_COMMONONN			BIT(0)
+
+#define EXYNOS5_DRD_PHYPARAM0			0x1c
+#define PHYPARAM0_REF_USE_PAD			BIT(31)
+#define PHYPARAM0_REF_LOSLEVEL			GENMASK(30, 26)
+#define PHYPARAM0_REF_LOSLEVEL_VAL		0x9
+#define PHYPARAM0_TXVREFTUNE			GENMASK(25, 22)
+#define PHYPARAM0_TXRISETUNE			GENMASK(21, 20)
+#define PHYPARAM0_TXRESTUNE			GENMASK(19, 18)
+#define PHYPARAM0_TXPREEMPPULSETUNE		BIT(17)
+#define PHYPARAM0_TXPREEMPAMPTUNE		GENMASK(16, 15)
+#define PHYPARAM0_TXHSXVTUNE			GENMASK(14, 13)
+#define PHYPARAM0_TXFSLSTUNE			GENMASK(12, 9)
+#define PHYPARAM0_SQRXTUNE			GENMASK(8, 6)
+#define PHYPARAM0_OTGTUNE			GENMASK(5, 3)
+#define PHYPARAM0_COMPDISTUNE			GENMASK(2, 0)
+
+#define EXYNOS5_DRD_LINKPORT			0x44
+#define LINKPORT_HOST_U3_PORT_DISABLE		BIT(8)
+#define LINKPORT_HOST_U2_PORT_DISABLE		BIT(7)
+#define LINKPORT_HOST_PORT_OVCR_U3		BIT(5)
+#define LINKPORT_HOST_PORT_OVCR_U2		BIT(4)
+#define LINKPORT_HOST_PORT_OVCR_U3_SEL		BIT(3)
+#define LINKPORT_HOST_PORT_OVCR_U2_SEL		BIT(2)
+
+/* Exynos7870: USB DRD PHY registers */
+#define EXYNOS7870_DRD_HSPHYCTRL		0x54
+#define HSPHYCTRL_PHYSWRSTALL			BIT(31)
+#define HSPHYCTRL_SIDDQ				BIT(6)
+#define HSPHYCTRL_PHYSWRST			BIT(0)
+
+#define EXYNOS7870_DRD_HSPHYPLLTUNE		0x70
+#define HSPHYPLLTUNE_PLL_B_TUNE			BIT(6)
+#define HSPHYPLLTUNE_PLL_I_TUNE			GENMASK(5, 4)
+#define HSPHYPLLTUNE_PLL_P_TUNE			GENMASK(3, 0)
+
 /* Exynos850: USB DRD PHY registers */
 #define EXYNOS850_DRD_LINKCTRL			0x04
 #define LINKCTRL_FORCE_QACT			BIT(8)
@@ -67,6 +150,7 @@
 #define MHZ					(KHZ * KHZ)
 
 enum exynos_usbdrd_phy_variant {
+	EXYNOS7870_USBDRD_PHY,
 	EXYNOS850_USBDRD_PHY,
 };
 
@@ -88,16 +172,20 @@ struct exynos_usbdrd_phy {
 	enum exynos_usbdrd_phy_variant variant;
 };
 
-static void exynos_usbdrd_phy_isol(struct regmap *reg_pmu, bool isolate)
+static void exynos_usbdrd_phy_isol(struct exynos_usbdrd_phy *phy_drd,
+				   bool isolate)
 {
-	unsigned int val;
+	unsigned int mask = EXYNOS_PHY_ENABLE, val;
 
-	if (!reg_pmu)
+	if (!phy_drd->reg_pmu)
 		return;
 
-	val = isolate ? 0 : EXYNOS_PHY_ENABLE;
-	regmap_update_bits(reg_pmu, EXYNOS_USBDRD_PHY_CONTROL,
-			   EXYNOS_PHY_ENABLE, val);
+	if (phy_drd->variant == EXYNOS7870_USBDRD_PHY)
+		mask = EXYNOS7870_PHY_ENABLE;
+
+	val = isolate ? 0 : mask;
+	regmap_update_bits(phy_drd->reg_pmu, EXYNOS_USBDRD_PHY_CONTROL,
+			   mask, val);
 }
 
 /*
@@ -138,6 +226,111 @@ static unsigned int exynos_rate_to_clk(unsigned long rate, u32 *reg)
 	return 0;
 }
 
+static void exynos7870_usbdrd_utmi_init(struct phy *phy)
+{
+	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(phy->dev);
+	void __iomem *regs_base = phy_drd->reg_phy;
+	u32 reg;
+
+	reg = readl(regs_base + EXYNOS5_DRD_PHYCLKRST);
+	/* Use PADREFCLK as ref clock */
+	reg &= ~PHYCLKRST_REFCLKSEL;
+	reg |= FIELD_PREP(PHYCLKRST_REFCLKSEL, PHYCLKRST_REFCLKSEL_PAD_REFCLK);
+	/* Select ref clock rate */
+	reg &= ~PHYCLKRST_FSEL_UTMI;
+	reg &= ~PHYCLKRST_FSEL_PIPE;
+	reg |= FIELD_PREP(PHYCLKRST_FSEL_UTMI, phy_drd->extrefclk);
+	/* Enable suspend and reset the port */
+	reg |= PHYCLKRST_EN_UTMISUSPEND;
+	reg |= PHYCLKRST_COMMONONN;
+	reg |= PHYCLKRST_PORTRESET;
+	writel(reg, regs_base + EXYNOS5_DRD_PHYCLKRST);
+	udelay(10);
+
+	/* Clear the port reset bit */
+	reg &= ~PHYCLKRST_PORTRESET;
+	writel(reg, regs_base + EXYNOS5_DRD_PHYCLKRST);
+
+	/* Change PHY PLL tune value */
+	reg = readl(regs_base + EXYNOS7870_DRD_HSPHYPLLTUNE);
+	if (phy_drd->extrefclk == EXYNOS5_FSEL_24MHZ)
+		reg |= HSPHYPLLTUNE_PLL_B_TUNE;
+	else
+		reg &= ~HSPHYPLLTUNE_PLL_B_TUNE;
+	reg &= ~HSPHYPLLTUNE_PLL_P_TUNE;
+	reg |= FIELD_PREP(HSPHYPLLTUNE_PLL_P_TUNE, 14);
+	writel(reg, regs_base + EXYNOS7870_DRD_HSPHYPLLTUNE);
+
+	/* High-Speed PHY control */
+	reg = readl(regs_base + EXYNOS7870_DRD_HSPHYCTRL);
+	reg &= ~HSPHYCTRL_SIDDQ;
+	reg &= ~HSPHYCTRL_PHYSWRST;
+	reg &= ~HSPHYCTRL_PHYSWRSTALL;
+	writel(reg, regs_base + EXYNOS7870_DRD_HSPHYCTRL);
+	udelay(500);
+
+	reg = readl(regs_base + EXYNOS5_DRD_LINKSYSTEM);
+	/*
+	 * Setting the Frame length Adj value[6:1] to default 0x20
+	 * See xHCI 1.0 spec, 5.2.4
+	 */
+	reg |= LINKSYSTEM_XHCI_VERSION_CONTROL;
+	reg &= ~LINKSYSTEM_FLADJ;
+	reg |= FIELD_PREP(LINKSYSTEM_FLADJ, 0x20);
+	/* Set VBUSVALID signal as the VBUS pad is not used */
+	reg |= LINKSYSTEM_FORCE_BVALID;
+	reg |= LINKSYSTEM_FORCE_VBUSVALID;
+	writel(reg, regs_base + EXYNOS5_DRD_LINKSYSTEM);
+
+	reg = readl(regs_base + EXYNOS5_DRD_PHYUTMI);
+	/* Release force_sleep & force_suspend */
+	reg &= ~PHYUTMI_FORCESLEEP;
+	reg &= ~PHYUTMI_FORCESUSPEND;
+	/* DP/DM pull down control */
+	reg &= ~PHYUTMI_DMPULLDOWN;
+	reg &= ~PHYUTMI_DPPULLDOWN;
+	reg &= ~PHYUTMI_DRVVBUS;
+	/* Set DP-pull up as the VBUS pad is not used */
+	reg |= PHYUTMI_VBUSVLDEXTSEL;
+	reg |= PHYUTMI_VBUSVLDEXT;
+	/* Disable OTG block and VBUS valid comparator */
+	reg |= PHYUTMI_OTGDISABLE;
+	writel(reg, regs_base + EXYNOS5_DRD_PHYUTMI);
+
+	/* Configure OVC IO usage */
+	reg = readl(regs_base + EXYNOS5_DRD_LINKPORT);
+	reg |= LINKPORT_HOST_PORT_OVCR_U3_SEL | LINKPORT_HOST_PORT_OVCR_U2_SEL;
+	writel(reg, regs_base + EXYNOS5_DRD_LINKPORT);
+
+	/* High-Speed PHY swrst */
+	reg = readl(regs_base + EXYNOS7870_DRD_HSPHYCTRL);
+	reg |= HSPHYCTRL_PHYSWRST;
+	writel(reg, regs_base + EXYNOS7870_DRD_HSPHYCTRL);
+	udelay(20);
+
+	/* Clear the PHY swrst bit */
+	reg = readl(regs_base + EXYNOS7870_DRD_HSPHYCTRL);
+	reg &= ~HSPHYCTRL_PHYSWRST;
+	writel(reg, regs_base + EXYNOS7870_DRD_HSPHYCTRL);
+
+	reg = readl(regs_base + EXYNOS5_DRD_PHYPARAM0);
+	reg &= ~(PHYPARAM0_TXVREFTUNE | PHYPARAM0_TXRISETUNE |
+		 PHYPARAM0_TXRESTUNE | PHYPARAM0_TXPREEMPPULSETUNE |
+		 PHYPARAM0_TXPREEMPAMPTUNE | PHYPARAM0_TXHSXVTUNE |
+		 PHYPARAM0_TXFSLSTUNE | PHYPARAM0_SQRXTUNE |
+		 PHYPARAM0_OTGTUNE | PHYPARAM0_COMPDISTUNE);
+	reg |= FIELD_PREP_CONST(PHYPARAM0_TXVREFTUNE, 14) |
+	       FIELD_PREP_CONST(PHYPARAM0_TXRISETUNE, 1) |
+	       FIELD_PREP_CONST(PHYPARAM0_TXRESTUNE, 3) |
+	       FIELD_PREP_CONST(PHYPARAM0_TXPREEMPAMPTUNE, 0) |
+	       FIELD_PREP_CONST(PHYPARAM0_TXHSXVTUNE, 0) |
+	       FIELD_PREP_CONST(PHYPARAM0_TXFSLSTUNE, 3) |
+	       FIELD_PREP_CONST(PHYPARAM0_SQRXTUNE, 6) |
+	       FIELD_PREP_CONST(PHYPARAM0_OTGTUNE, 2) |
+	       FIELD_PREP_CONST(PHYPARAM0_COMPDISTUNE, 3);
+	writel(reg, regs_base + EXYNOS5_DRD_PHYPARAM0);
+}
+
 static void exynos850_usbdrd_utmi_init(struct phy *phy)
 {
 	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(phy->dev);
@@ -225,6 +418,33 @@ static void exynos850_usbdrd_utmi_init(struct phy *phy)
 	writel(reg, regs_base + EXYNOS850_DRD_HSP);
 }
 
+static void exynos7870_usbdrd_utmi_exit(struct phy *phy)
+{
+	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(phy->dev);
+	void __iomem *regs_base = phy_drd->reg_phy;
+	u32 reg;
+
+	/*
+	 * Disable the VBUS signal and the ID pull-up resistor.
+	 * Enable force-suspend and force-sleep modes.
+	 */
+	reg = readl(regs_base + EXYNOS5_DRD_PHYUTMI);
+	reg &= ~(PHYUTMI_DRVVBUS | PHYUTMI_VBUSVLDEXT | PHYUTMI_VBUSVLDEXTSEL);
+	reg &= ~PHYUTMI_IDPULLUP;
+	reg |= PHYUTMI_FORCESUSPEND | PHYUTMI_FORCESLEEP;
+	writel(reg, regs_base + EXYNOS5_DRD_PHYUTMI);
+
+	/* Power down PHY analog blocks */
+	reg = readl(regs_base + EXYNOS7870_DRD_HSPHYCTRL);
+	reg |= HSPHYCTRL_SIDDQ;
+	writel(reg, regs_base + EXYNOS7870_DRD_HSPHYCTRL);
+
+	/* Clear VBUSVALID signal as the VBUS pad is not used */
+	reg = readl(regs_base + EXYNOS5_DRD_LINKSYSTEM);
+	reg &= ~(LINKSYSTEM_FORCE_BVALID | LINKSYSTEM_FORCE_VBUSVALID);
+	writel(reg, regs_base + EXYNOS5_DRD_LINKSYSTEM);
+}
+
 static void exynos850_usbdrd_utmi_exit(struct phy *phy)
 {
 	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(phy->dev);
@@ -261,6 +481,9 @@ static int exynos_usbdrd_phy_init(struct phy *phy)
 		return ret;
 
 	switch (phy_drd->variant) {
+	case EXYNOS7870_USBDRD_PHY:
+		exynos7870_usbdrd_utmi_init(phy);
+		break;
 	case EXYNOS850_USBDRD_PHY:
 		exynos850_usbdrd_utmi_init(phy);
 		break;
@@ -283,6 +506,9 @@ static int exynos_usbdrd_phy_exit(struct phy *phy)
 		return ret;
 
 	switch (phy_drd->variant) {
+	case EXYNOS7870_USBDRD_PHY:
+		exynos7870_usbdrd_utmi_exit(phy);
+		break;
 	case EXYNOS850_USBDRD_PHY:
 		exynos850_usbdrd_utmi_exit(phy);
 		break;
@@ -307,7 +533,7 @@ static int exynos_usbdrd_phy_power_on(struct phy *phy)
 		return ret;
 
 	/* Power-on PHY */
-	exynos_usbdrd_phy_isol(phy_drd->reg_pmu, false);
+	exynos_usbdrd_phy_isol(phy_drd, false);
 
 	return 0;
 }
@@ -319,7 +545,7 @@ static int exynos_usbdrd_phy_power_off(struct phy *phy)
 	dev_dbg(phy->dev, "Request to power_off usbdrd_phy phy\n");
 
 	/* Power-off the PHY */
-	exynos_usbdrd_phy_isol(phy_drd->reg_pmu, true);
+	exynos_usbdrd_phy_isol(phy_drd, true);
 
 	clk_disable_unprepare(phy_drd->core_clk);
 
@@ -390,6 +616,10 @@ static const struct phy_ops exynos_usbdrd_phy_ops = {
 };
 
 static const struct udevice_id exynos_usbdrd_phy_of_match[] = {
+	{
+		.compatible = "samsung,exynos7870-usbdrd-phy",
+		.data = EXYNOS7870_USBDRD_PHY,
+	},
 	{
 		.compatible = "samsung,exynos850-usbdrd-phy",
 		.data = EXYNOS850_USBDRD_PHY,

-- 
2.51.0

