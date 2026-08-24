Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871C3C5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 558BF80FA7;
	Mon, 24 Aug 2026 16:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MeSPzx1hLtzE; Mon, 24 Aug 2026 16:46:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589914;
	bh=1uCLCNb2sgXpnWVWmzbq0DOqclUxbYD55q1P90SziKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BSAQBc4Q051gqUhwLvUkS8D1E4e1O1H6ExXUx0a8YIJsIz0zoSS9JbuQV2NyNZgQm
	 uP+RiOLlHoRVJ/PVs+BZYv3JbffF4bOEOGX3wMsSXFVj7uKpVVVrG/LKOExtJzSc9M
	 1sXw6YBDZN65XuaEo3unuclGC0H0eazwu3Krp9NpmOg5dD9G6tLencwMSQCsO7Fes/
	 BH6u2PMyiv96+Sq/gD3kb0WhwxQdvFsQPt6HwhNCqFc+uW+Q4o9eBD2Yay03uYh3oR
	 kohEgaJFNHA89TBfG7kuwNq4GmGO4YOQLFuX8To3m2nqQLNmis9Do/A50+cIOerDOi
	 bTB+aTnFQaB6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8309880ECD;
	Mon, 24 Aug 2026 16:45:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D6EB386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FD136062C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oSWB9AChLv7n for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:32:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=E6ZqDsdJ
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5E67605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:04 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a09571dd5cso710897a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585522; x=1788190322;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1uCLCNb2sgXpnWVWmzbq0DOqclUxbYD55q1P90SziKQ=;
 b=E6ZqDsdJPZz5yIfG0wVmbWp57X84YNh9CAJkcl+jE5w3Sr2W+XDtf39tRuMW/glZf5
 ON6KUweSsZnnYDPJoezO07D1Zxm2r6ak0y/p08Eaem1WGJgvO7qKJBokOAFoSBTYBb+d
 it3Hct4QeCgrhXv0UfIoIez72Y/4Foy3qq8o3crefUgeND4mW5KMZbwU30yYTRrnnGww
 9wHsOHZnZjOS01tldObX06z+ichMG0MY0nwTA9nZXZ2Ujk1+RSrHf2FI2PJHqqMn5eky
 tyQcL5DKTQU1nNxmQhllrUQRtOPfYUZmXFOX+D7MnDPI8E7X74BJ7E0OcVZ7LutBIGp5
 Hh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585522; x=1788190322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1uCLCNb2sgXpnWVWmzbq0DOqclUxbYD55q1P90SziKQ=;
 b=GhIck2ajwaCUcPt/HC+/WEMpaRllYR75jMgJhkV4HPYelhGGBmXSuTNB+lUX2ysiP1
 iOvhM7kcSeDP5mAVO8iXohW3IM6+ir8GmcfsFrl1OUV1Ij5mtCJ+6rdwc/zJB5p4odsc
 8fK4Me6nlM6NbVL/5dGqNGKNZt7LDzyvtuBgzCeqry5vh6CZNL5vQGLg+iTaMzdDPZ4H
 q8PM7KvqffvLMygoUyePghvK6Et6beufAc21ipTESc1wW9knpoBhHcAb87jXXsnB5ioK
 VAvhPVheDCecwm39/5R2iXPso4w7P/85ysSnzXpCIpBC4+Er+NCW7GC6b1ISlsEZCLKM
 UH/Q==
X-Gm-Message-State: AFuF++m3qvCBBL6WTFHAB+o9rBxoo2b4nMfh54aQ6N9v8MknAGkXPOtK
 NWumSWaaaQefW9oejYlAyeKIcxrh2EyEsAgBB+nldtaKk0Jl3w9cDwqccfh2K/uZUeoYVFUikdc
 u2Ks4
X-Gm-Gg: AR+sD11cXUcpt3rl/1NXwP49wxWp9ljR1JV9atOu4x9mGh/Qg8WkAnw0BdJF40Q3wa8
 GSTQ74GVsJ3SW+B4zooAYFf+co6QFpdg5wRHWI0ozyAQWiAZ2aDNbVbhBME9iUSFUbhuFuthVMb
 nx2n34QjTiVEA13eN0SllSDtsU3P6ssB2zygXI8CbbjlSTf15qPBdkcwI/mbJ8p7spGp3wGDi8u
 aqda88dnvuCXVNrJKcSFTZ7fBQVt+r+zj0EcTkwcW3tw/UejVWJbHUPvFHFSYkKqVGrq+rQ/SJV
 QNoxexMbY8WnQh/scu0bSMxpAF7Ykmbk2PSrkArhf1XnTWyi2CFMdgn48RYY7Z2XC6Jh9U7VYKu
 mueqk9t73vwNnP8gSQUHKuXutcOgOKHWcF2dCAQredWZFBQQdAX0EmdpGQQm/fAbM0kP1DoVYen
 wS/KEJujjXQWn3du46GlqyVxEWdHImJYDuURyZPPFAjOTr5ybzSShYepVZZwE6WZ3F4eCv41e9P
 3wTPzvEbUiGWeoF8TzKnQ==
X-Received: by 2002:a17:907:c19:b0:c21:6f8c:231f with SMTP id
 a640c23a62f3a-c246a2e942emr1716226266b.1.1787585522119; 
 Mon, 24 Aug 2026 08:32:02 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b208sm1233541266b.10.2026.08.24.08.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:32:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 55/63] usb: dwc3: import from kernel v6.10
Date: Mon, 24 Aug 2026 17:27:26 +0200
Message-ID: <20260824152734.159794-56-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824152734.159794-1-anders.roxell@linaro.org>
References: <20260824152734.159794-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v6.9 to v6.10.

The following files are preserved across the import:
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
fc1d1a712b51 usb: dwc3: core: Workaround for CSR read timeout
7838de15bb70 usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock
01be965ce5ab usb: dwc3: core: Fix unused variable warning in core driver
1d26ba0944d3 usb: dwc3: Wait unconditionally after issuing EndXfer command
3f12222a4beb usb: dwc3: core: Fix compile warning on s390 gcc in dwc3_get_phy call
30a46746ca5a usb: dwc3: core: Refactor PHY logic to support Multiport Controller
89d7f9629946 usb: dwc3: core: Skip setting event buffers for host only controllers
921e109c6200 usb: dwc3: core: Access XHCI address space temporarily to read port info
606c096adc79 usb: dwc3: Select 2.0 or 3.0 clk base on maximum_speed

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
2.53.0

