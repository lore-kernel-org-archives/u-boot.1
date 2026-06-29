Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8961C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A21A8849E5;
	Mon, 29 Jun 2026 10:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TpydJeFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B366184844; Mon, 29 Jun 2026 10:47:47 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0070684B03
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-39adcae789dso21542081fa.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722864; x=1783327664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJuI0x5SmFDJa3jMUj2AFGca1JBm/E0FeUW3D0pSNU4=;
 b=TpydJeFs1tJHaH2K76HfYvf0AOFZdvav94ZYmbB55wpj4u2qnxqlE7qczIELibk0QE
 +6tjPazn/tKTwCKt8Nnt5qck0jZYRAxJi/1yBMRsF1V1lfLd5tZz66mwVhPrNfOo0V7Y
 GqjRqbJNWCB2FEoadGlHgdkD3k41pfNUkyF5Car9CDAq868yNggXAyNtIa8vx0iaRsx6
 hcDoKlTGH2J4EcG3OTBR0aPwFk0+/PdW/zQH1K2oOOT8ssBwR3GVg9OtDA/U/8VHf+gk
 vJutBE/IlKlhfcyLjOj50yYI7IBwQSOwcX2qwVstUKopu5fCJCCKqZEIGwt1ZW06jq9q
 rUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722864; x=1783327664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WJuI0x5SmFDJa3jMUj2AFGca1JBm/E0FeUW3D0pSNU4=;
 b=pzHC6WzxC4H2JJIZlJ/mUwHuiYbhlNS3AhSJmDrhDwBVVEBTDC/30i/m66cAC2G4w2
 5Fxx7MhX5C94vfLgGcjc0PjAsTlNK4GzD5Rcq3kF435TnhFao59VBGMpRNDqls4HJw6Z
 lHG69x66c++eJGSp82bhJyyi5os36CZm/Q9PQV437RB2kszMaDLkahk1p03zPge3ig30
 ic+VQGbi3kmCDbHGvX2oSkwUCOkpD/3ExG2DTgK5PDNoE6pj022HroOmjKGrHdm7cDRq
 HaKBSHcizUuJC+59rnTQhvNBZBzuyGm3wcNT25rZP0wKdCa4igK4PyKI330kaWwq4zB1
 grnw==
X-Gm-Message-State: AOJu0YzspQ8NPf5qOnxmDvTKhaU1rtV26K5HtcRrV41HE/fl46kZ6ZhK
 MoqMihuGSylNmu9YB4lyymqkUWFF8cRWVz4o8ck+HOKdxnzPQ9sJGBJjw3eBQsLgrqDaEFi7WC8
 wnddf+Q0=
X-Gm-Gg: AfdE7ckE5V8SNF4kbJ+bS0yq527nc/UltSKD7LFtHqbwdEe7xOigvqi000pYP3BNCRK
 R37ce6vLZ2O0Ff8sgQET4pjWSSmlyiVHmdKqCfOmFNpMjzp84PNvey8ORHAOpeAJzB4g0WImSMh
 OInQmlJvI853rojuSUBExJ1Tgs6QO33bInfNQu970k2dORtl3aCXoUdA+SnpCkgFoHf2LGcNIWk
 9jzatASfD6LeVAGilyP2NtYTg6pUsAkzunsj3ZvzhR8bu1MovL8Af55YDxXyS4PyOfg6b2yTRGp
 aoJEolaL+38iL7sFee+Tbwwu2EfIFXat0ZNsUTDeznRfB9FSqz+AmeoEMSLm2nFiJlAisdB4ZIr
 mehA1Cy6qYfxcbF8+yFeJKRsTm1lhOOB8fAf2imWzJQSvC51XG/6voFOWN2RqFCkn6olyXeYJp4
 M0Dr+7dhGzQLi/V9Jck3EihUjbSJ2Inc46IezVsXU+CLLrJ6R0PolTwEEnF5TdFvBSkDbMXQBCc
 HB6hlo8o6FYaeD1NaBc
X-Received: by 2002:a2e:bcd0:0:b0:399:6ba6:eda7 with SMTP id
 38308e7fff4ca-39acb44d929mr36054951fa.3.1782722863873; 
 Mon, 29 Jun 2026 01:47:43 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:47:42 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 54/64] usb: dwc3: import from kernel v6.10
Date: Mon, 29 Jun 2026 10:44:30 +0200
Message-ID: <20260629084507.3254232-55-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629084507.3254232-1-jens.wiklander@linaro.org>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sync Linux kernel dwc3 changes from v6.9 to v6.10.

The following files are preserved accross the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v6.9..v6.10
Commits imported:
2bf35ea46d0b usb: dwc3: pci: add support for the Intel Panther Lake
fc1d1a712b51 usb: dwc3: core: Workaround for CSR read timeout
7838de15bb70 usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock
2c92ca849fcc tracing/treewide: Remove second parameter of __assign_str()
01be965ce5ab usb: dwc3: core: Fix unused variable warning in core driver
1d26ba0944d3 usb: dwc3: Wait unconditionally after issuing EndXfer command
adeab5bfb818 Merge 6.9-rc7 into usb-next
9b780c845fb6 usb: dwc3: exynos: add support for Google Tensor gs101
3f12222a4beb usb: dwc3: core: Fix compile warning on s390 gcc in dwc3_get_phy call
a160e1202ca3 usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
5df44c6f4f39 usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
2bfc9916a0e4 usb: dwc3: qcom: Refactor IRQ handling in glue driver
6410c8033ba7 usb: dwc3: qcom: Add helper function to request wakeup interrupts
30a46746ca5a usb: dwc3: core: Refactor PHY logic to support Multiport Controller
89d7f9629946 usb: dwc3: core: Skip setting event buffers for host only controllers
921e109c6200 usb: dwc3: core: Access XHCI address space temporarily to read port info
0d31ea587709 Merge 6.9-rc5 into usb-next
684e9f5f97eb usb: dwc3: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
606c096adc79 usb: dwc3: Select 2.0 or 3.0 clk base on maximum_speed
0fb782b5d5c4 usb: dwc3: pci: Don't set "linux,phy_charger_detect" property on Lenovo Yoga Tab2 1380
5bab5dc780c9 Merge 6.9-rc2 into usb-next

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.c   | 346 +++++++++++++++++++++++++++++---------
 drivers/usb/dwc3/core.h   |  20 ++-
 drivers/usb/dwc3/gadget.c |   4 +-
 3 files changed, 284 insertions(+), 86 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 100041320e8d..cb82557678dd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -39,6 +39,7 @@
 #include "io.h"
 
 #include "debug.h"
+#include "../host/xhci-ext-caps.h"
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
@@ -144,6 +145,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 	int ret;
 	u32 reg;
 	u32 desired_dr_role;
+	int i;
 
 	mutex_lock(&dwc->mutex);
 	spin_lock_irqsave(&dwc->lock, flags);
@@ -221,8 +223,12 @@ static void __dwc3_set_mode(struct work_struct *work)
 		} else {
 			if (dwc->usb2_phy)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+
+			for (i = 0; i < dwc->num_usb2_ports; i++)
+				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+			for (i = 0; i < dwc->num_usb3_ports; i++)
+				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
+
 			if (dwc->dis_split_quirk) {
 				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
 				reg |= DWC3_GUCTL3_SPLITDISABLE;
@@ -237,8 +243,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -506,6 +512,13 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
 static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 {
 	struct dwc3_event_buffer *evt;
+	unsigned int hw_mode;
+
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		dwc->ev_buf = NULL;
+		return 0;
+	}
 
 	evt = dwc3_alloc_one_event_buffer(dwc, length);
 	if (IS_ERR(evt)) {
@@ -527,6 +540,9 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
+	if (!dwc->ev_buf)
+		return 0;
+
 	evt = dwc->ev_buf;
 	evt->lpos = 0;
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
@@ -544,6 +560,9 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
+	if (!dwc->ev_buf)
+		return;
+
 	evt = dwc->ev_buf;
 
 	evt->lpos = 0;
@@ -596,19 +615,11 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
 	return ret;
 }
 
-/**
- * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
- * @dwc: Pointer to our controller context structure
- *
- * Returns 0 on success. The USB PHY interfaces are configured but not
- * initialized. The PHY interfaces and the PHYs get initialized together with
- * the core in dwc3_core_init.
- */
-static int dwc3_phy_setup(struct dwc3 *dwc)
+static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 {
 	u32 reg;
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(index));
 
 	/*
 	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
@@ -655,9 +666,16 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(index), reg);
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	return 0;
+}
+
+static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
 
 	/* Select the HS PHY interface */
 	switch (DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3)) {
@@ -669,7 +687,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		} else if (dwc->hsphy_interface &&
 				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
 			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
 		} else {
 			/* Relying on default value. */
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
@@ -727,7 +745,35 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->ulpi_ext_vbus_drv)
 		reg |= DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
+
+	return 0;
+}
+
+/**
+ * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
+ * @dwc: Pointer to our controller context structure
+ *
+ * Returns 0 on success. The USB PHY interfaces are configured but not
+ * initialized. The PHY interfaces and the PHYs get initialized together with
+ * the core in dwc3_core_init.
+ */
+static int dwc3_phy_setup(struct dwc3 *dwc)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < dwc->num_usb3_ports; i++) {
+		ret = dwc3_ss_phy_setup(dwc, i);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = dwc3_hs_phy_setup(dwc, i);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -735,23 +781,34 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 static int dwc3_phy_init(struct dwc3 *dwc)
 {
 	int ret;
+	int i;
+	int j;
 
 	usb_phy_init(dwc->usb2_phy);
 	usb_phy_init(dwc->usb3_phy);
 
-	ret = phy_init(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err_shutdown_usb3_phy;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = phy_init(dwc->usb2_generic_phy[i]);
+		if (ret < 0)
+			goto err_exit_usb2_phy;
+	}
 
-	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err_exit_usb2_phy;
+	for (j = 0; j < dwc->num_usb3_ports; j++) {
+		ret = phy_init(dwc->usb3_generic_phy[j]);
+		if (ret < 0)
+			goto err_exit_usb3_phy;
+	}
 
 	return 0;
 
+err_exit_usb3_phy:
+	while (--j >= 0)
+		phy_exit(dwc->usb3_generic_phy[j]);
+
 err_exit_usb2_phy:
-	phy_exit(dwc->usb2_generic_phy);
-err_shutdown_usb3_phy:
+	while (--i >= 0)
+		phy_exit(dwc->usb2_generic_phy[i]);
+
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
 
@@ -760,8 +817,13 @@ err_shutdown_usb3_phy:
 
 static void dwc3_phy_exit(struct dwc3 *dwc)
 {
-	phy_exit(dwc->usb3_generic_phy);
-	phy_exit(dwc->usb2_generic_phy);
+	int i;
+
+	for (i = 0; i < dwc->num_usb3_ports; i++)
+		phy_exit(dwc->usb3_generic_phy[i]);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++)
+		phy_exit(dwc->usb2_generic_phy[i]);
 
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -770,23 +832,34 @@ static void dwc3_phy_exit(struct dwc3 *dwc)
 static int dwc3_phy_power_on(struct dwc3 *dwc)
 {
 	int ret;
+	int i;
+	int j;
 
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 
-	ret = phy_power_on(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err_suspend_usb3_phy;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = phy_power_on(dwc->usb2_generic_phy[i]);
+		if (ret < 0)
+			goto err_power_off_usb2_phy;
+	}
 
-	ret = phy_power_on(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err_power_off_usb2_phy;
+	for (j = 0; j < dwc->num_usb3_ports; j++) {
+		ret = phy_power_on(dwc->usb3_generic_phy[j]);
+		if (ret < 0)
+			goto err_power_off_usb3_phy;
+	}
 
 	return 0;
 
+err_power_off_usb3_phy:
+	while (--j >= 0)
+		phy_power_off(dwc->usb3_generic_phy[j]);
+
 err_power_off_usb2_phy:
-	phy_power_off(dwc->usb2_generic_phy);
-err_suspend_usb3_phy:
+	while (--i >= 0)
+		phy_power_off(dwc->usb2_generic_phy[i]);
+
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 
@@ -795,8 +868,13 @@ err_suspend_usb3_phy:
 
 static void dwc3_phy_power_off(struct dwc3 *dwc)
 {
-	phy_power_off(dwc->usb3_generic_phy);
-	phy_power_off(dwc->usb2_generic_phy);
+	int i;
+
+	for (i = 0; i < dwc->num_usb3_ports; i++)
+		phy_power_off(dwc->usb3_generic_phy[i]);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++)
+		phy_power_off(dwc->usb2_generic_phy[i]);
 
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
@@ -879,12 +957,16 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
 
 static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 {
+	unsigned int power_opt;
+	unsigned int hw_mode;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	power_opt = DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1);
 
-	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
+	switch (power_opt) {
 	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
 		/**
 		 * WORKAROUND: DWC3 revisions between 2.10a and 2.50a have an
@@ -917,6 +999,20 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 		break;
 	}
 
+	/*
+	 * This is a workaround for STAR#4846132, which only affects
+	 * DWC_usb31 version2.00a operating in host mode.
+	 *
+	 * There is a problem in DWC_usb31 version 2.00a operating
+	 * in host mode that would cause a CSR read timeout When CSR
+	 * read coincides with RAM Clock Gating Entry. By disable
+	 * Clock Gating, sacrificing power consumption for normal
+	 * operation.
+	 */
+	if (power_opt != DWC3_GHWPARAMS1_EN_PWROPT_NO &&
+	    hw_mode != DWC3_GHWPARAMS0_MODE_GADGET && DWC3_VER_IS(DWC31, 200A))
+		reg |= DWC3_GCTL_DSBLCLKGTNG;
+
 	/* check if current dwc3 is on simulation board */
 	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
 		dev_info(dwc->dev, "Running with FPGA optimizations\n");
@@ -1306,10 +1402,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->parkmode_disable_hs_quirk)
 			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_HS;
 
-		if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY) &&
-		    (dwc->maximum_speed == USB_SPEED_HIGH ||
-		     dwc->maximum_speed == USB_SPEED_FULL))
-			reg |= DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
+		if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY)) {
+			if (dwc->maximum_speed == USB_SPEED_FULL ||
+			    dwc->maximum_speed == USB_SPEED_HIGH)
+				reg |= DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
+			else
+				reg &= ~DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
+		}
 
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
@@ -1344,7 +1443,9 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 {
 	struct device		*dev = dwc->dev;
 	struct device_node	*node = dev->of_node;
+	char phy_name[9];
 	int ret;
+	u8 i;
 
 	if (node) {
 		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
@@ -1370,22 +1471,38 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
 	}
 
-	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
-	if (IS_ERR(dwc->usb2_generic_phy)) {
-		ret = PTR_ERR(dwc->usb2_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV)
-			dwc->usb2_generic_phy = NULL;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		if (dwc->num_usb2_ports == 1)
+			snprintf(phy_name, sizeof(phy_name), "usb2-phy");
 		else
-			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
+			snprintf(phy_name, sizeof(phy_name),  "usb2-%u", i);
+
+		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
+		if (IS_ERR(dwc->usb2_generic_phy[i])) {
+			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
+			if (ret == -ENOSYS || ret == -ENODEV)
+				dwc->usb2_generic_phy[i] = NULL;
+			else
+				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
+							phy_name);
+		}
 	}
 
-	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
-	if (IS_ERR(dwc->usb3_generic_phy)) {
-		ret = PTR_ERR(dwc->usb3_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV)
-			dwc->usb3_generic_phy = NULL;
+	for (i = 0; i < dwc->num_usb3_ports; i++) {
+		if (dwc->num_usb3_ports == 1)
+			snprintf(phy_name, sizeof(phy_name), "usb3-phy");
 		else
-			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
+			snprintf(phy_name, sizeof(phy_name), "usb3-%u", i);
+
+		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
+		if (IS_ERR(dwc->usb3_generic_phy[i])) {
+			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
+			if (ret == -ENOSYS || ret == -ENODEV)
+				dwc->usb3_generic_phy[i] = NULL;
+			else
+				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
+							phy_name);
+		}
 	}
 
 	return 0;
@@ -1395,6 +1512,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
 	int ret;
+	int i;
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
@@ -1402,8 +1520,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -1414,8 +1532,10 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+		for (i = 0; i < dwc->num_usb2_ports; i++)
+			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+		for (i = 0; i < dwc->num_usb3_ports; i++)
+			phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
 
 		ret = dwc3_host_init(dwc);
 		if (ret)
@@ -1867,10 +1987,60 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_get_num_ports(struct dwc3 *dwc)
+{
+	void __iomem *base;
+	u8 major_revision;
+	u32 offset;
+	u32 val;
+
+	/*
+	 * Remap xHCI address space to access XHCI ext cap regs since it is
+	 * needed to get information on number of ports present.
+	 */
+	base = ioremap(dwc->xhci_resources[0].start,
+		       resource_size(&dwc->xhci_resources[0]));
+	if (!base)
+		return -ENOMEM;
+
+	offset = 0;
+	do {
+		offset = xhci_find_next_ext_cap(base, offset,
+						XHCI_EXT_CAPS_PROTOCOL);
+		if (!offset)
+			break;
+
+		val = readl(base + offset);
+		major_revision = XHCI_EXT_PORT_MAJOR(val);
+
+		val = readl(base + offset + 0x08);
+		if (major_revision == 0x03) {
+			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
+		} else if (major_revision <= 0x02) {
+			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
+		} else {
+			dev_warn(dwc->dev, "unrecognized port major revision %d\n",
+				 major_revision);
+		}
+	} while (1);
+
+	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
+		dwc->num_usb2_ports, dwc->num_usb3_ports);
+
+	iounmap(base);
+
+	if (dwc->num_usb2_ports > DWC3_USB2_MAX_PORTS ||
+	    dwc->num_usb3_ports > DWC3_USB3_MAX_PORTS)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
 	struct resource		*res, dwc_res;
+	unsigned int		hw_mode;
 	void __iomem		*regs;
 	struct dwc3		*dwc;
 	int			ret;
@@ -1954,6 +2124,20 @@ static int dwc3_probe(struct platform_device *pdev)
 			goto err_disable_clks;
 	}
 
+	/*
+	 * Currently only DWC3 controllers that are host-only capable
+	 * can have more than one port.
+	 */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		ret = dwc3_get_num_ports(dwc);
+		if (ret)
+			goto err_disable_clks;
+	} else {
+		dwc->num_usb2_ports = 1;
+		dwc->num_usb3_ports = 1;
+	}
+
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
@@ -2084,8 +2268,8 @@ assert_reset:
 
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
-	unsigned long	flags;
 	u32 reg;
+	int i;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -2104,17 +2288,21 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		/* Let controller to suspend HSPHY before PHY driver suspends */
 		if (dwc->dis_u2_susphy_quirk ||
 		    dwc->dis_enblslpm_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
-				DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			for (i = 0; i < dwc->num_usb2_ports; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+				reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
+					DWC3_GUSB2PHYCFG_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+			}
 
 			/* Give some time for USB2 PHY to suspend */
 			usleep_range(5000, 6000);
 		}
 
-		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
-		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
+		for (i = 0; i < dwc->num_usb2_ports; i++)
+			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
+		for (i = 0; i < dwc->num_usb3_ports; i++)
+			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* do nothing during runtime_suspend */
@@ -2122,9 +2310,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_suspend(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 			synchronize_irq(dwc->irq_gadget);
 		}
 
@@ -2141,9 +2327,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 
 static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
-	unsigned long	flags;
 	int		ret;
 	u32		reg;
+	int		i;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -2163,17 +2349,21 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
-		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		if (dwc->dis_u2_susphy_quirk)
-			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+		for (i = 0; i < dwc->num_usb2_ports; i++) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+			if (dwc->dis_u2_susphy_quirk)
+				reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
-		if (dwc->dis_enblslpm_quirk)
-			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+			if (dwc->dis_enblslpm_quirk)
+				reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
 
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+		}
 
-		phy_pm_runtime_get_sync(dwc->usb2_generic_phy);
-		phy_pm_runtime_get_sync(dwc->usb3_generic_phy);
+		for (i = 0; i < dwc->num_usb2_ports; i++)
+			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
+		for (i = 0; i < dwc->num_usb3_ports; i++)
+			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* nothing to do on runtime_resume */
@@ -2190,9 +2380,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
 			dwc3_otg_host_init(dwc);
 		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_resume(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 		}
 
 		break;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 180dd8d29287..3781c736c1a1 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -33,6 +33,13 @@
 
 #include <linux/power_supply.h>
 
+/*
+ * DWC3 Multiport controllers support up to 15 High-Speed PHYs
+ * and 4 SuperSpeed PHYs.
+ */
+#define DWC3_USB2_MAX_PORTS	15
+#define DWC3_USB3_MAX_PORTS	4
+
 #define DWC3_MSG_MAX	500
 
 /* Global constants */
@@ -1037,8 +1044,10 @@ struct dwc3_scratchpad_array {
  * @usb_psy: pointer to power supply interface.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
- * @usb2_generic_phy: pointer to USB2 PHY
- * @usb3_generic_phy: pointer to USB3 PHY
+ * @usb2_generic_phy: pointer to array of USB2 PHYs
+ * @usb3_generic_phy: pointer to array of USB3 PHYs
+ * @num_usb2_ports: number of USB2 ports
+ * @num_usb3_ports: number of USB3 ports
  * @phys_ready: flag to indicate that PHYs are ready
  * @ulpi: pointer to ulpi interface
  * @ulpi_ready: flag to indicate that ULPI is initialized
@@ -1184,8 +1193,11 @@ struct dwc3 {
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
 
-	struct phy		*usb2_generic_phy;
-	struct phy		*usb3_generic_phy;
+	struct phy		*usb2_generic_phy[DWC3_USB2_MAX_PORTS];
+	struct phy		*usb3_generic_phy[DWC3_USB3_MAX_PORTS];
+
+	u8			num_usb2_ports;
+	u8			num_usb3_ports;
 
 	bool			phys_ready;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f94f68f1e7d2..89fc690fdf34 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1699,7 +1699,6 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
-	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
@@ -1724,8 +1723,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	dep->resource_index = 0;
 
 	if (!interrupt) {
-		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
-			mdelay(1);
+		mdelay(1);
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	} else if (!ret) {
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-- 
2.43.0

