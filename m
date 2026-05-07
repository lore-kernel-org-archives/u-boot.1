Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E2BCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0877C84AA4;
	Thu,  7 May 2026 11:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tZjldbck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80CCD84A9A; Thu,  7 May 2026 11:29:46 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9002384A81
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-393ba0616aaso6449421fa.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146181; x=1778750981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIRWoEtPqFra8MyxHN2d4Z9Ri7buyelkORaB3tP4S6w=;
 b=tZjldbckYg1SJkVQ6K/U86QHLVbeNhl0BUZfA7ES0RsJpgqSISBMOBK4vrA1DhIsPW
 dH0K2P+iqZBhmP4odMTxtOxzgielVNDiNleFAPMd2WJYWduR4RjlZDP0uK2fbVGXqNzU
 v9dk+eerrq0F7OBXLTfwV8QGqkinbvOe6O1AixYMVDD5m4buFn74M7cyras40j6C27aY
 RGE+49M3WpFPGI8GH7a/2S4HXGm7S+H5bZjhXXtlVCnpcM64/IaYZgPxJGRoiTLJvqQD
 aqADIoowad+iAkfn2Nj0HDb4RpuOLD+Dv3uhN4XWx61+C6TDdbR35FpiXjyw+YS5/y/l
 MvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146181; x=1778750981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jIRWoEtPqFra8MyxHN2d4Z9Ri7buyelkORaB3tP4S6w=;
 b=L29q1ugnfRH3Znz/c2JUI82ajo/FMcCLGp62UG7RDErQK6R8XWkpec35fYLSieThUI
 +MUs0JJqQAHIqD36mmq6tCzmbFFlrmCTXgXRXHUq3HLFJeLq6i/kDHV1dk7Ev5fD3iG4
 tETw1GsLbs4bIwHE8wrcX6dmXnKazKMLcvL9Mg+bdaNscvJvMsBwi4pOL70fT3RGSQ/R
 d5dw9F1UzZ9CISjr/jur5RuFB8IIrUMCbiQ5KMnfCYLlGx2HsTiZpJ92+G0VYKlr1fZa
 8OQa2INnoFvtiMWFnPyZCm6aAuH011Ck0hRaF8tCJWfDUz46Y963PZCn3Y1PddlZMT0R
 XAVg==
X-Gm-Message-State: AOJu0YzBnz3Ia5IdOVncHIa6q7Fh9E8lCr/kPrGFikLoba+FYVWiyPUM
 cFYdZ7IjyqPQdxm7FPSI49E8mTJdDtNia6W2HaqGKzY/NIEy+JF1mRU3d8/t3PeeDXznPK9PpD+
 LZqTwkUZxHQ==
X-Gm-Gg: AeBDiesGt4QQNVKmUJEWUHdYWAQMbihkn1/0jlMoxo+fJ6vYsSLzMY/kE3Xp5RxDNm+
 IXFrRn2C4Yc+2cweK+9ZWkXRofOUIUzUjTHe1+9PKXe/oBcFSeyCkz638Dtxy9y+MNdaOa4Zj9S
 dX1wozXb/c6LzmBXNuSae565EVR8t2wlVWjJCyLs8wXWoAqcnplRB5JUOj3UlWR7jJephMwdhNr
 +sN11/0LvBGQn5zPsQRbozjVTnFkgnY/sakgppYtWjv5BqW+tGz64k2KFoxBXa2MrhScmrDXnzC
 Gfrnb82+EzubKVIxXUhvQJmh3bcXMbYkyMabZMVFeTliA6QKY9+YGa3e19Pn3SupOIYMduVWOPF
 Pc8IrMYFy8hU7q+ZBuOwGohIU4ESs17fS/ObkO2VpOK43Xh3ooRn1vJ3tzj6+OLwAdwQ2gpx72d
 VjF1DKuBs4zhVBL3jv1GsSy5at8AHUeL/gB/JFdWfEf3egMlCdpCJMXqvh8g4zAc0/+7HQ4CRcn
 rG0nCni0JVW2dAPSzQjJJuk9TbWli2mGx5Yabj8eQ==
X-Received: by 2002:a05:6512:3b8b:b0:5a8:71ab:294a with SMTP id
 2adb3069b0e04-5a887ad9ff7mr2318163e87.2.1778146180678; 
 Thu, 07 May 2026 02:29:40 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:38 -0700 (PDT)
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
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH v2 18/64] usb: dwc3: import from kernel v4.15
Date: Thu,  7 May 2026 11:27:25 +0200
Message-ID: <20260507092843.358908-19-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.14 to v4.15.

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

List of commits: git log --oneline v4.14..v4.15
Commits imported:
ec5bb87e4e2a usb: dwc3: gadget: Fix PCM1 for ISOC EP with ep->mult less than 3
a0d8c4cfdf31 usb: dwc3: of-simple: set dev_pm_ops
ded600ea9fb5 usb: dwc3: of-simple: fix missing clk_disable_unprepare
8722e095f5a4 usb: dwc3: gadget: Wait longer for controller to end command processing
894025f24bd0 Merge tag 'usb-4.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
b5ea47570b5e USB: dwc3: Remove redundant license text
5fd54ace4721 USB: add SPDX identifiers to all remaining files in drivers/usb/
644cbbc3ab4d usb: dwc3: core: Notify current USB mode to USB3 PHY as well
8eed00b237a2 usb: dwc3: pci: Runtime resume child device from wq
689bf72c6e0d usb: dwc3: Don't reinitialize core during host bus-suspend/resume
06c47e6286d5 usb: dwc3: of-simple: Add support to get resets for the device
d6d9c2a3eac2 usb: dwc3: of-simple: Re-order resource handling in remove
86763723eee8 usb: dwc3: ep0: Clean up unused variables
7fdca766499b usb: dwc3: gadget: simplify __dwc3_gadget_kick_transfer() prototype
502a37b98a7b usb: dwc3: gadget: cache frame number in struct dwc3_ep
64e010802997 usb: dwc3: gadget: simplify __dwc3_gadget_ep_queue()
ccb94ebf9e65 usb: dwc3: gadget: check for lack of TRBs a bit earlier

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   | 74 +++++++++++++++-----------------------
 drivers/usb/dwc3/core.h   | 12 ++-----
 drivers/usb/dwc3/debug.h  | 10 +-----
 drivers/usb/dwc3/ep0.c    | 30 +---------------
 drivers/usb/dwc3/gadget.c | 76 ++++++++++++---------------------------
 drivers/usb/dwc3/gadget.h | 10 +-----
 drivers/usb/dwc3/io.h     | 10 +-----
 7 files changed, 59 insertions(+), 163 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 03474d3575ab..07832509584f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * core.c - DesignWare USB3 DRD Controller Core file
  *
@@ -5,18 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/version.h>
@@ -156,9 +145,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 		} else {
 			if (dwc->usb2_phy)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
-			if (dwc->usb2_generic_phy)
-				phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-
+			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
+			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -166,8 +154,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		if (dwc->usb2_generic_phy)
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -927,12 +915,13 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
+		dwc->current_dr_role = DWC3_GCTL_PRTCAP_DEVICE;
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		if (dwc->usb2_generic_phy)
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
@@ -942,12 +931,13 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_HOST:
+		dwc->current_dr_role = DWC3_GCTL_PRTCAP_HOST;
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
-		if (dwc->usb2_generic_phy)
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
+		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
+		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 
 		ret = dwc3_host_init(dwc);
 		if (ret) {
@@ -1293,21 +1283,19 @@ static int dwc3_suspend_common(struct dwc3 *dwc)
 {
 	unsigned long	flags;
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_core_exit(dwc);
 		break;
-	case USB_DR_MODE_HOST:
+	case DWC3_GCTL_PRTCAP_HOST:
 	default:
 		/* do nothing */
 		break;
 	}
 
-	dwc3_core_exit(dwc);
-
 	return 0;
 }
 
@@ -1316,18 +1304,17 @@ static int dwc3_resume_common(struct dwc3 *dwc)
 	unsigned long	flags;
 	int		ret;
 
-	ret = dwc3_core_init(dwc);
-	if (ret)
-		return ret;
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		ret = dwc3_core_init(dwc);
+		if (ret)
+			return ret;
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_resume(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
-		/* FALLTHROUGH */
-	case USB_DR_MODE_HOST:
+		break;
+	case DWC3_GCTL_PRTCAP_HOST:
 	default:
 		/* do nothing */
 		break;
@@ -1338,7 +1325,7 @@ static int dwc3_resume_common(struct dwc3 *dwc)
 
 static int dwc3_runtime_checks(struct dwc3 *dwc)
 {
-	switch (dwc->dr_mode) {
+	switch (dwc->current_dr_role) {
 	case USB_DR_MODE_PERIPHERAL:
 	case USB_DR_MODE_OTG:
 		if (dwc->connected)
@@ -1381,19 +1368,17 @@ static int dwc3_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
 		dwc3_gadget_process_pending_events(dwc);
 		break;
-	case USB_DR_MODE_HOST:
+	case DWC3_GCTL_PRTCAP_HOST:
 	default:
 		/* do nothing */
 		break;
 	}
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put(dev);
 
 	return 0;
 }
@@ -1402,13 +1387,12 @@ static int dwc3_runtime_idle(struct device *dev)
 {
 	struct dwc3     *dwc = dev_get_drvdata(dev);
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (dwc3_runtime_checks(dwc))
 			return -EBUSY;
 		break;
-	case USB_DR_MODE_HOST:
+	case DWC3_GCTL_PRTCAP_HOST:
 	default:
 		/* do nothing */
 		break;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ea910acb4bb0..4a4a4c98508c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * core.h - DesignWare USB3 DRD Core Header
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DRIVERS_USB_DWC3_CORE_H
@@ -529,6 +521,7 @@ struct dwc3_event_buffer {
  * @number: endpoint number (1 - 15)
  * @type: set to bmAttributes & USB_ENDPOINT_XFERTYPE_MASK
  * @resource_index: Resource transfer index
+ * @frame_number: set to the frame number we want this transfer to start (ISOC)
  * @interval: the interval on which the ISOC transfer is started
  * @allocated_requests: number of requests allocated
  * @queued_requests: number of requests queued for transfer
@@ -581,6 +574,7 @@ struct dwc3_ep {
 	u8			resource_index;
 	u32			allocated_requests;
 	u32			queued_requests;
+	u32			frame_number;
 	u32			interval;
 
 	char			name[20];
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 5e9c070ec874..368f8e59219a 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * debug.h - DesignWare USB3 DRD Controller Debug Header
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DWC3_DEBUG_H
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 75e6cb044eb2..fd3e7ad2eb0e 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ep0.c - DesignWare USB3 DRD Controller Endpoint 0 Handling
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
@@ -487,14 +479,10 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 static int dwc3_ep0_handle_intf(struct dwc3 *dwc,
 		struct usb_ctrlrequest *ctrl, int set)
 {
-	enum usb_device_state	state;
 	u32			wValue;
-	u32			wIndex;
 	int			ret = 0;
 
 	wValue = le16_to_cpu(ctrl->wValue);
-	wIndex = le16_to_cpu(ctrl->wIndex);
-	state = dwc->gadget.state;
 
 	switch (wValue) {
 	case USB_INTRF_FUNC_SUSPEND:
@@ -517,14 +505,10 @@ static int dwc3_ep0_handle_endpoint(struct dwc3 *dwc,
 		struct usb_ctrlrequest *ctrl, int set)
 {
 	struct dwc3_ep		*dep;
-	enum usb_device_state	state;
 	u32			wValue;
-	u32			wIndex;
 	int			ret;
 
 	wValue = le16_to_cpu(ctrl->wValue);
-	wIndex = le16_to_cpu(ctrl->wIndex);
-	state = dwc->gadget.state;
 
 	switch (wValue) {
 	case USB_ENDPOINT_HALT:
@@ -551,10 +535,8 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 {
 	u32			recip;
 	int			ret;
-	enum usb_device_state	state;
 
 	recip = ctrl->bRequestType & USB_RECIP_MASK;
-	state = dwc->gadget.state;
 
 	switch (recip) {
 	case USB_RECIP_DEVICE:
@@ -712,12 +694,10 @@ static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	struct dwc3_ep	*dep;
 	enum usb_device_state state = dwc->gadget.state;
 	u16		wLength;
-	u16		wValue;
 
 	if (state == USB_STATE_DEFAULT)
 		return -EINVAL;
 
-	wValue = le16_to_cpu(ctrl->wValue);
 	wLength = le16_to_cpu(ctrl->wLength);
 
 	if (wLength != 6) {
@@ -842,9 +822,6 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	unsigned		maxp;
-	unsigned		remaining_ur_length;
-	void			*buf;
 	u32			transferred = 0;
 	u32			status;
 	u32			length;
@@ -871,11 +848,8 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	}
 
 	ur = &r->request;
-	buf = ur->buf;
-	remaining_ur_length = ur->length;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
-	maxp = ep0->endpoint.maxpacket;
 	transferred = ur->length - length;
 	ur->actual += transferred;
 
@@ -1001,7 +975,6 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 	} else if (IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
 		   req->request.length && req->request.zero) {
 		u32	maxpacket;
-		u32	rem;
 
 		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
 				&req->request, dep->number);
@@ -1009,7 +982,6 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			return;
 
 		maxpacket = dep->endpoint.maxpacket;
-		rem = req->request.length % maxpacket;
 
 		/* prepare normal TRB */
 		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f064f1549333..639dd1b163a0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * gadget.c - DesignWare USB3 DRD Controller Gadget Framework Link
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
@@ -267,7 +259,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 {
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
-	u32			timeout = 500;
+	u32			timeout = 1000;
 	u32			reg;
 
 	int			cmd_status = 0;
@@ -920,7 +912,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 			 */
 			if (speed == USB_SPEED_HIGH) {
 				struct usb_ep *ep = &dep->endpoint;
-				unsigned int mult = ep->mult - 1;
+				unsigned int mult = 2;
 				unsigned int maxp = usb_endpoint_maxp(ep->desc);
 
 				if (length <= (2 * maxp))
@@ -1151,9 +1143,6 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
 
-	if (!dwc3_calc_trbs_left(dep))
-		return;
-
 	/*
 	 * We can get in a situation where there's a request in the started list
 	 * but there weren't enough TRBs to fully kick it in the first time
@@ -1194,7 +1183,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 	}
 }
 
-static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param)
+static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_request		*req;
@@ -1202,6 +1191,9 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param)
 	int				ret;
 	u32				cmd;
 
+	if (!dwc3_calc_trbs_left(dep))
+		return 0;
+
 	starting = !(dep->flags & DWC3_EP_BUSY);
 
 	dwc3_prepare_trbs(dep);
@@ -1216,8 +1208,10 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param)
 	if (starting) {
 		params.param0 = upper_32_bits(req->trb_dma);
 		params.param1 = lower_32_bits(req->trb_dma);
-		cmd = DWC3_DEPCMD_STARTTRANSFER |
-			DWC3_DEPCMD_PARAM(cmd_param);
+		cmd = DWC3_DEPCMD_STARTTRANSFER;
+
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			cmd |= DWC3_DEPCMD_PARAM(dep->frame_number);
 	} else {
 		cmd = DWC3_DEPCMD_UPDATETRANSFER |
 			DWC3_DEPCMD_PARAM(dep->resource_index);
@@ -1258,8 +1252,6 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
 static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
 		struct dwc3_ep *dep, u32 cur_uf)
 {
-	u32 uf;
-
 	if (list_empty(&dep->pending_list)) {
 		dev_info(dwc->dev, "%s: ran out of requests\n",
 				dep->name);
@@ -1271,9 +1263,8 @@ static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
 	 * Schedule the first trb for one interval in the future or at
 	 * least 4 microframes.
 	 */
-	uf = cur_uf + max_t(u32, 4, dep->interval);
-
-	__dwc3_gadget_kick_transfer(dep, uf);
+	dep->frame_number = cur_uf + max_t(u32, 4, dep->interval);
+	__dwc3_gadget_kick_transfer(dep);
 }
 
 static void dwc3_gadget_start_isoc(struct dwc3 *dwc,
@@ -1290,7 +1281,6 @@ static void dwc3_gadget_start_isoc(struct dwc3 *dwc,
 static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	struct dwc3		*dwc = dep->dwc;
-	int			ret = 0;
 
 	if (!dep->endpoint.desc) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
@@ -1337,24 +1327,14 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		}
 
 		if ((dep->flags & DWC3_EP_BUSY) &&
-		    !(dep->flags & DWC3_EP_MISSED_ISOC)) {
-			WARN_ON_ONCE(!dep->resource_index);
-			ret = __dwc3_gadget_kick_transfer(dep,
-							  dep->resource_index);
-		}
-
-		goto out;
-	}
+		    !(dep->flags & DWC3_EP_MISSED_ISOC))
+			goto out;
 
-	if (!dwc3_calc_trbs_left(dep))
 		return 0;
+	}
 
-	ret = __dwc3_gadget_kick_transfer(dep, 0);
 out:
-	if (ret == -EBUSY)
-		ret = 0;
-
-	return ret;
+	return __dwc3_gadget_kick_transfer(dep);
 }
 
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
@@ -2347,7 +2327,7 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		req->request.actual = length - req->remaining;
 
 		if ((req->request.actual < length) && req->num_pending_sgs)
-			return __dwc3_gadget_kick_transfer(dep, 0);
+			return __dwc3_gadget_kick_transfer(dep);
 
 		dwc3_gadget_giveback(dep, req, status);
 
@@ -2440,13 +2420,8 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 	if (!dep->endpoint.desc)
 		return;
 
-	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-		int ret;
-
-		ret = __dwc3_gadget_kick_transfer(dep, 0);
-		if (!ret || ret == -EBUSY)
-			return;
-	}
+	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		__dwc3_gadget_kick_transfer(dep);
 }
 
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
@@ -2487,15 +2462,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		dwc3_endpoint_transfer_complete(dwc, dep, event);
 		break;
 	case DWC3_DEPEVT_XFERNOTREADY:
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 			dwc3_gadget_start_isoc(dwc, dep, event);
-		} else {
-			int ret;
-
-			ret = __dwc3_gadget_kick_transfer(dep, 0);
-			if (!ret || ret == -EBUSY)
-				return;
-		}
+		else
+			__dwc3_gadget_kick_transfer(dep);
 
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 4a3227543255..578aa856f986 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DRIVERS_USB_DWC3_GADGET_H
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index c69b06696824..70acdf94a0bf 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * io.h - DesignWare USB3 DRD IO Header
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DRIVERS_USB_DWC3_IO_H
-- 
2.43.0

