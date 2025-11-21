Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8315CFC28B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 15:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7A083984;
	Fri, 21 Nov 2025 16:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Aa5Qd1Ot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BD08393F; Fri, 21 Nov 2025 16:38:45 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3A58394E
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 16:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so19067895e9.1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763739516; x=1764344316; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9f01yahEXeT3pP0zCvMeewQ1dmRLd1WI32afW3bvz0=;
 b=Aa5Qd1OtTHdQ1AAeTdls/qxUfo68C0pBp+Hl6E+0FlZr4KgUPysoxBb3L7HbmEtsL2
 rsU24vgzQKuVzj2RQa5gFj2x3ukwciXA+Ohdei69RzpI7/keXbEYSIsS+MfokXa2VXMv
 FNvfunJJKeN+gy4BsAfpkPeard3BD52qZ1TSysihIonNa4JcBLHCnk8CbcblAbEfkIF7
 nnoib9R+DLow4Uhj9+DLb/eGwqu0Bvjtcxj1aYe0BqnAaRPY48O92Y7nRoZx5GVEzfZf
 pgLF5zNT8WDXrkmcSEXCjbhi/swjB6LsvMmT75TcP7PA44+AVGeDZ2ryMEE4Lq7PUV2z
 1Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763739516; x=1764344316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p9f01yahEXeT3pP0zCvMeewQ1dmRLd1WI32afW3bvz0=;
 b=Zer/ohhp055T8uWiItlS8sGjzbdY/yUhO8Bq7UbcD4YPiyeyXrtSilFQaRGvpvb5XJ
 LeOKRx/SCVPsiANPHC9sHQoGXvFzAGlVPI8ZLXTzu8n/bVfAaW/uidquMHLOBQvwlJA0
 ihOdx5Lyn0vnK4nwc/im72ZBzyDAqSU/3x1MCSGRIGviuZzs+yI+I7aKfsdXyrKQd3Sk
 lrawA/XcuSbHPNqJvD31YxmkUemdAxUBa1+n9u8NSq+pumSKffLszeUe4qpQJW582nO/
 7V0mlm91JYhWHLt0gZ87caLGMaQHId9Pa9Y1e6btUysh4BNlgP/9dWc2yx60HeHfikKb
 4L2w==
X-Gm-Message-State: AOJu0YzAV0rYbKdoRej89AEuqk4F8rIWfV7sXvOPk5GIEx6hV2/mmj+H
 Z9davF+p82HbhEYODLt6uJrmyG+2OjT+r/myGhbKqdGvzxoX1ZdNGeMFxnSQ6TfAEq5+69LmPFd
 ByaOt
X-Gm-Gg: ASbGncs6MFfOB30Uu6hv60niFApHu9Hk9L17T+oAI72w1x+2OhLZCoHTfV7uMYSffJ4
 bQc9t41kWJxJoYiyPPVkVp6v/KVt2e6rfp9Q1DukrhmrPEfh3GbunwlDc7U4POuH3BmSAj4+ZLl
 BzuQs4m0qXUCRSlI6lFLN3MNXzyWxETtER+ONg3qCVqqP3oDyDB59mNQa6yPlMVxQE6U3FoEnL2
 4wMtpRFFXfNWmj2wzTVga69GgmWMXg0OSrO4YvSpnu5G3iIm7AcN8onNZjWKKboFuwDnJ/77F4N
 o3EKYhm1nlxhKiIg0vF6TxGQgCdNl8ngu7+0GY61b0FMNxii3hE5a72aF1bOKN0XoVA80eYRjGM
 jNOarOT9dVVnFRx/L+WjvxU4dxtOZnyj8Dyio9vMOW9kKeSz0ZkBi1RSAO+eYhUWJvWk6umjaWi
 SgVgoQlGv4c1miGuW1uVU=
X-Google-Smtp-Source: AGHT+IEEEo9GMpPOy4iDV5GhAi6eO/aQjOh/FPws/m4aJLskddlUyNgdlMxA681Jaf7qlpQR25rdwQ==
X-Received: by 2002:a05:600c:46c8:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-477c016b05cmr30228895e9.6.1763739514746; 
 Fri, 21 Nov 2025 07:38:34 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:2035:a57d:e702:e09e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd9b45sm11487964f8f.43.2025.11.21.07.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 07:38:33 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>
Subject: [RFC PATCH 5/5] usb: fix build after resync of DWC3 with kernel
 v6.16-rc7
Date: Fri, 21 Nov 2025 16:37:54 +0100
Message-ID: <20251121153812.2076440-6-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251121153812.2076440-1-jerome.forissier@linaro.org>
References: <20251121153812.2076440-1-jerome.forissier@linaro.org>
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

Fix build errors after the re-sync of the DWC3 driver with the kernel.
U-Boot has different needs than the kernel: buses, interrupts, internal
APIs (DMA, traces, DT...) so many adaptations are required. This commit
re-introduces many of the changes that were done locally after the
initial import of the DWC3 code from kernel 3.19-rc1 11 years ago, as
well as other fixes. This is compile-tested only.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 drivers/usb/cdns3/ep0.c                |    8 +-
 drivers/usb/common/common.c            |   23 +
 drivers/usb/dwc3/Makefile              |    8 +-
 drivers/usb/dwc3/core.c                | 1747 ++++++------------------
 drivers/usb/dwc3/core.h                |   39 +-
 drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
 drivers/usb/dwc3/dwc3-omap.c           |    2 -
 drivers/usb/dwc3/ep0.c                 |  110 +-
 drivers/usb/dwc3/gadget.c              |  788 +++--------
 drivers/usb/dwc3/gadget.h              |    4 +-
 drivers/usb/dwc3/io.h                  |   28 +-
 drivers/usb/gadget/at91_udc.c          |   46 -
 drivers/usb/gadget/atmel_usba_udc.c    |  110 +-
 drivers/usb/gadget/ci_udc.c            |  419 ------
 drivers/usb/gadget/composite.c         |    2 +-
 drivers/usb/gadget/dwc2_udc_otg.c      |  186 +--
 drivers/usb/gadget/epautoconf.c        |    2 -
 drivers/usb/gadget/ether.c             |   21 +-
 drivers/usb/gadget/f_acm.c             |   20 +-
 drivers/usb/gadget/f_fastboot.c        |   10 +-
 drivers/usb/gadget/f_mass_storage.c    |    5 +-
 drivers/usb/gadget/f_rockusb.c         |   11 +-
 drivers/usb/gadget/f_sdp.c             |   12 +-
 drivers/usb/gadget/f_thor.c            |   19 +-
 drivers/usb/gadget/udc/Makefile        |    1 +
 drivers/usb/gadget/udc/udc-core.c      | 1047 +++-----------
 drivers/usb/host/xhci-dwc3.c           |    4 +-
 drivers/usb/host/xhci-exynos5.c        |    2 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
 drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
 drivers/usb/musb-new/musb_uboot.c      |   39 -
 include/dm/device_compat.h             |   13 +
 include/dm/read.h                      |   46 +
 include/linux/compat.h                 |   15 +
 include/linux/usb/ch9.h                |   25 +-
 include/linux/usb/gadget.h             |  520 ++-----
 include/linux/usb/otg.h                |   10 +
 include/linux/usb/phy.h                |   56 +
 38 files changed, 1316 insertions(+), 4546 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index acff79ae1ca1..40282cbc3234 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -341,10 +341,10 @@ static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
 			return -EINVAL;
 
 		switch (tmode >> 8) {
-		case TEST_J:
-		case TEST_K:
-		case TEST_SE0_NAK:
-		case TEST_PACKET:
+		case USB_TEST_J:
+		case USB_TEST_K:
+		case USB_TEST_SE0_NAK:
+		case USB_TEST_PACKET:
 			cdns3_ep0_complete_setup(priv_dev, 0, 1);
 			/**
 			 *  Little delay to give the controller some time
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 13e9a61072a9..7c1a413a9450 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -66,6 +66,13 @@ static const char *const speed_names[] = {
 	[USB_SPEED_SUPER_PLUS] = "super-speed-plus",
 };
 
+static const char *const ssp_rate[] = {
+	[USB_SSP_GEN_UNKNOWN] = "UNKNOWN",
+	[USB_SSP_GEN_2x1] = "super-speed-plus-gen2x1",
+	[USB_SSP_GEN_1x2] = "super-speed-plus-gen1x2",
+	[USB_SSP_GEN_2x2] = "super-speed-plus-gen2x2",
+};
+
 const char *usb_speed_string(enum usb_device_speed speed)
 {
 	if (speed < 0 || speed >= ARRAY_SIZE(speed_names))
@@ -91,6 +98,22 @@ enum usb_device_speed usb_get_maximum_speed(ofnode node)
 	return USB_SPEED_UNKNOWN;
 }
 
+enum usb_ssp_rate usb_get_maximum_ssp_rate(ofnode node)
+{
+	const char *maximum_speed;
+	int i;
+
+	maximum_speed = ofnode_read_string(node, "maximum-speed");
+	if (!maximum_speed)
+		return USB_SSP_GEN_UNKNOWN;
+
+	for (i = 0; i < ARRAY_SIZE(ssp_rate); i++)
+		if (!strcmp(maximum_speed, ssp_rate[i]))
+			return i;
+
+	return USB_SSP_GEN_UNKNOWN;
+}
+
 #if CONFIG_IS_ENABLED(DM_USB)
 static const char *const usbphy_modes[] = {
 	[USBPHY_INTERFACE_MODE_UNKNOWN]	= "",
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 00f7c2410dbf..ae1725756c0e 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -1,15 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-# define_trace.h needs to know how to find our header
-CFLAGS_trace.o				:= -I$(src)
-
 obj-$(CONFIG_USB_DWC3)			+= dwc3.o
 
 dwc3-y					:= core.o
 
-ifneq ($(CONFIG_TRACING),)
-	dwc3-y				+= trace.o
-endif
-
 ifneq ($(filter y,$(CONFIG_USB_DWC3_HOST) $(CONFIG_USB_DWC3_DUAL_ROLE)),)
 	dwc3-y				+= host.o
 endif
@@ -63,3 +56,4 @@ obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
 obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
 obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
 obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
+obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)		+= dwc3-generic.o
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8002c23a5a02..5b6004a54d9b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -8,104 +8,40 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
-#include <linux/clk.h>
-#include <linux/version.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/list.h>
+#include <clk.h>
+#include <cpu_func.h>
+#include <malloc.h>
+#include <dwc3-uboot.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/of.h>
-#include <linux/of_graph.h>
-#include <linux/acpi.h>
-#include <linux/pinctrl/consumer.h>
-#include <linux/pinctrl/devinfo.h>
-#include <linux/reset.h>
-#include <linux/bitfield.h>
-
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <dm.h>
+#include <generic-phy.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/usb/of.h>
-#include <linux/usb/otg.h>
+#include <linux/bitfield.h>
+#include <linux/math64.h>
+#include <linux/time.h>
+
+#include <version.h>
 
 #include "core.h"
 #include "gadget.h"
 #include "glue.h"
 #include "io.h"
 
-#include "debug.h"
 #include "../host/xhci-ext-caps.h"
 
+#define msleep(a) udelay(a * 1000)
+
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
-/**
- * dwc3_get_dr_mode - Validates and sets dr_mode
- * @dwc: pointer to our context structure
- */
-static int dwc3_get_dr_mode(struct dwc3 *dwc)
-{
-	enum usb_dr_mode mode;
-	struct device *dev = dwc->dev;
-	unsigned int hw_mode;
-
-	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
-		dwc->dr_mode = USB_DR_MODE_OTG;
-
-	mode = dwc->dr_mode;
-	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-
-	switch (hw_mode) {
-	case DWC3_GHWPARAMS0_MODE_GADGET:
-		if (IS_ENABLED(CONFIG_USB_DWC3_HOST)) {
-			dev_err(dev,
-				"Controller does not support host mode.\n");
-			return -EINVAL;
-		}
-		mode = USB_DR_MODE_PERIPHERAL;
-		break;
-	case DWC3_GHWPARAMS0_MODE_HOST:
-		if (IS_ENABLED(CONFIG_USB_DWC3_GADGET)) {
-			dev_err(dev,
-				"Controller does not support device mode.\n");
-			return -EINVAL;
-		}
-		mode = USB_DR_MODE_HOST;
-		break;
-	default:
-		if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
-			mode = USB_DR_MODE_HOST;
-		else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
-			mode = USB_DR_MODE_PERIPHERAL;
-
-		/*
-		 * DWC_usb31 and DWC_usb3 v3.30a and higher do not support OTG
-		 * mode. If the controller supports DRD but the dr_mode is not
-		 * specified or set to OTG, then set the mode to peripheral.
-		 */
-		if (mode == USB_DR_MODE_OTG && !dwc->edev &&
-		    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
-		     !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
-		    !DWC3_VER_IS_PRIOR(DWC3, 330A))
-			mode = USB_DR_MODE_PERIPHERAL;
-	}
-
-	if (mode != dwc->dr_mode) {
-		dev_warn(dev,
-			 "Configuration mismatch. dr_mode forced to %s\n",
-			 mode == USB_DR_MODE_HOST ? "host" : "gadget");
-
-		dwc->dr_mode = mode;
-	}
-
-	return 0;
-}
+static LIST_HEAD(dwc3_list);
 
 void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 {
@@ -158,146 +94,6 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
 	dwc->current_dr_role = mode;
 }
 
-static void __dwc3_set_mode(struct work_struct *work)
-{
-	struct dwc3 *dwc = work_to_dwc(work);
-	unsigned long flags;
-	int ret;
-	u32 reg;
-	u32 desired_dr_role;
-	int i;
-
-	mutex_lock(&dwc->mutex);
-	spin_lock_irqsave(&dwc->lock, flags);
-	desired_dr_role = dwc->desired_dr_role;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	pm_runtime_get_sync(dwc->dev);
-
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
-		dwc3_otg_update(dwc, 0);
-
-	if (!desired_dr_role)
-		goto out;
-
-	if (desired_dr_role == dwc->current_dr_role)
-		goto out;
-
-	if (desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
-		goto out;
-
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_HOST:
-		dwc3_host_exit(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		dwc3_gadget_exit(dwc);
-		dwc3_event_buffers_cleanup(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		dwc3_otg_exit(dwc);
-		spin_lock_irqsave(&dwc->lock, flags);
-		dwc->desired_otg_role = DWC3_OTG_ROLE_IDLE;
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		dwc3_otg_update(dwc, 1);
-		break;
-	default:
-		break;
-	}
-
-	/*
-	 * When current_dr_role is not set, there's no role switching.
-	 * Only perform GCTL.CoreSoftReset when there's DRD role switching.
-	 */
-	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
-			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
-			desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
-		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-		reg |= DWC3_GCTL_CORESOFTRESET;
-		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-
-		/*
-		 * Wait for internal clocks to synchronized. DWC_usb31 and
-		 * DWC_usb32 may need at least 50ms (less for DWC_usb3). To
-		 * keep it consistent across different IPs, let's wait up to
-		 * 100ms before clearing GCTL.CORESOFTRESET.
-		 */
-		msleep(100);
-
-		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-		reg &= ~DWC3_GCTL_CORESOFTRESET;
-		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-	}
-
-	spin_lock_irqsave(&dwc->lock, flags);
-
-	dwc3_set_prtcap(dwc, desired_dr_role, false);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	switch (desired_dr_role) {
-	case DWC3_GCTL_PRTCAP_HOST:
-		ret = dwc3_host_init(dwc);
-		if (ret) {
-			dev_err(dwc->dev, "failed to initialize host\n");
-		} else {
-			if (dwc->usb2_phy)
-				otg_set_vbus(dwc->usb2_phy->otg, true);
-
-			for (i = 0; i < dwc->num_usb2_ports; i++)
-				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
-			for (i = 0; i < dwc->num_usb3_ports; i++)
-				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
-
-			if (dwc->dis_split_quirk) {
-				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
-				reg |= DWC3_GUCTL3_SPLITDISABLE;
-				dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
-			}
-		}
-		break;
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		dwc3_core_soft_reset(dwc);
-
-		dwc3_event_buffers_setup(dwc);
-
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
-
-		ret = dwc3_gadget_init(dwc);
-		if (ret)
-			dev_err(dwc->dev, "failed to initialize peripheral\n");
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		dwc3_otg_init(dwc);
-		dwc3_otg_update(dwc, 0);
-		break;
-	default:
-		break;
-	}
-
-out:
-	pm_runtime_mark_last_busy(dwc->dev);
-	pm_runtime_put_autosuspend(dwc->dev);
-	mutex_unlock(&dwc->mutex);
-}
-
-void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
-{
-	unsigned long flags;
-
-	if (dwc->dr_mode != USB_DR_MODE_OTG)
-		return;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	dwc->desired_dr_role = mode;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	queue_work(system_freezable_wq, &dwc->drd_work);
-}
-
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
 {
 	struct dwc3		*dwc = dep->dwc;
@@ -474,7 +270,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
-	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);
+	dma_free_coherent(evt->buf);
 }
 
 /**
@@ -490,18 +286,19 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
 {
 	struct dwc3_event_buffer	*evt;
 
-	evt = devm_kzalloc(dwc->dev, sizeof(*evt), GFP_KERNEL);
+	evt = devm_kzalloc((struct udevice*)dwc->dev, sizeof(*evt), GFP_KERNEL);
 	if (!evt)
 		return ERR_PTR(-ENOMEM);
 
 	evt->dwc	= dwc;
 	evt->length	= length;
-	evt->cache	= devm_kzalloc(dwc->dev, length, GFP_KERNEL);
+	evt->cache	= devm_kzalloc((struct udevice *)dwc->dev, length,
+				       GFP_KERNEL);
 	if (!evt->cache)
 		return ERR_PTR(-ENOMEM);
 
-	evt->buf	= dma_alloc_coherent(dwc->sysdev, length,
-			&evt->dma, GFP_KERNEL);
+	evt->buf	= dma_alloc_coherent(length,
+					     (unsigned long *)&evt->dma);
 	if (!evt->buf)
 		return ERR_PTR(-ENOMEM);
 
@@ -817,13 +614,13 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 	usb_phy_init(dwc->usb3_phy);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++) {
-		ret = phy_init(dwc->usb2_generic_phy[i]);
+		ret = generic_phy_init(dwc->usb2_generic_phy[i]);
 		if (ret < 0)
 			goto err_exit_usb2_phy;
 	}
 
 	for (j = 0; j < dwc->num_usb3_ports; j++) {
-		ret = phy_init(dwc->usb3_generic_phy[j]);
+		ret = generic_phy_init(dwc->usb3_generic_phy[j]);
 		if (ret < 0)
 			goto err_exit_usb3_phy;
 	}
@@ -851,11 +648,11 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 
 err_exit_usb3_phy:
 	while (--j >= 0)
-		phy_exit(dwc->usb3_generic_phy[j]);
+		generic_phy_exit(dwc->usb3_generic_phy[j]);
 
 err_exit_usb2_phy:
 	while (--i >= 0)
-		phy_exit(dwc->usb2_generic_phy[i]);
+		generic_phy_exit(dwc->usb2_generic_phy[i]);
 
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -868,10 +665,10 @@ static void dwc3_phy_exit(struct dwc3 *dwc)
 	int i;
 
 	for (i = 0; i < dwc->num_usb3_ports; i++)
-		phy_exit(dwc->usb3_generic_phy[i]);
+		generic_phy_exit(dwc->usb3_generic_phy[i]);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++)
-		phy_exit(dwc->usb2_generic_phy[i]);
+		generic_phy_exit(dwc->usb2_generic_phy[i]);
 
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -887,13 +684,13 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++) {
-		ret = phy_power_on(dwc->usb2_generic_phy[i]);
+		ret = generic_phy_power_on(dwc->usb2_generic_phy[i]);
 		if (ret < 0)
 			goto err_power_off_usb2_phy;
 	}
 
 	for (j = 0; j < dwc->num_usb3_ports; j++) {
-		ret = phy_power_on(dwc->usb3_generic_phy[j]);
+		ret = generic_phy_power_on(dwc->usb3_generic_phy[j]);
 		if (ret < 0)
 			goto err_power_off_usb3_phy;
 	}
@@ -902,11 +699,11 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
 
 err_power_off_usb3_phy:
 	while (--j >= 0)
-		phy_power_off(dwc->usb3_generic_phy[j]);
+		generic_phy_power_off(dwc->usb3_generic_phy[j]);
 
 err_power_off_usb2_phy:
 	while (--i >= 0)
-		phy_power_off(dwc->usb2_generic_phy[i]);
+		generic_phy_power_off(dwc->usb2_generic_phy[i]);
 
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
@@ -919,52 +716,15 @@ static void dwc3_phy_power_off(struct dwc3 *dwc)
 	int i;
 
 	for (i = 0; i < dwc->num_usb3_ports; i++)
-		phy_power_off(dwc->usb3_generic_phy[i]);
+		generic_phy_power_off(dwc->usb3_generic_phy[i]);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++)
-		phy_power_off(dwc->usb2_generic_phy[i]);
+		generic_phy_power_off(dwc->usb2_generic_phy[i]);
 
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 }
 
-static int dwc3_clk_enable(struct dwc3 *dwc)
-{
-	int ret;
-
-	ret = clk_prepare_enable(dwc->bus_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(dwc->ref_clk);
-	if (ret)
-		goto disable_bus_clk;
-
-	ret = clk_prepare_enable(dwc->susp_clk);
-	if (ret)
-		goto disable_ref_clk;
-
-	ret = clk_prepare_enable(dwc->utmi_clk);
-	if (ret)
-		goto disable_susp_clk;
-
-	ret = clk_prepare_enable(dwc->pipe_clk);
-	if (ret)
-		goto disable_utmi_clk;
-
-	return 0;
-
-disable_utmi_clk:
-	clk_disable_unprepare(dwc->utmi_clk);
-disable_susp_clk:
-	clk_disable_unprepare(dwc->susp_clk);
-disable_ref_clk:
-	clk_disable_unprepare(dwc->ref_clk);
-disable_bus_clk:
-	clk_disable_unprepare(dwc->bus_clk);
-	return ret;
-}
-
 static void dwc3_clk_disable(struct dwc3 *dwc)
 {
 	clk_disable_unprepare(dwc->pipe_clk);
@@ -983,26 +743,6 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	reset_control_assert(dwc->reset);
 }
 
-static bool dwc3_core_is_valid(struct dwc3 *dwc)
-{
-	u32 reg;
-
-	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
-	dwc->ip = DWC3_GSNPS_ID(reg);
-
-	/* This should read as U3 followed by revision number */
-	if (DWC3_IP_IS(DWC3)) {
-		dwc->revision = reg;
-	} else if (DWC3_IP_IS(DWC31) || DWC3_IP_IS(DWC32)) {
-		dwc->revision = dwc3_readl(dwc->regs, DWC3_VER_NUMBER);
-		dwc->version_type = dwc3_readl(dwc->regs, DWC3_VER_TYPE);
-	} else {
-		return false;
-	}
-
-	return true;
-}
-
 static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 {
 	unsigned int power_opt;
@@ -1090,13 +830,12 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
-static int dwc3_core_get_phy(struct dwc3 *dwc);
 static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
 /* set global incr burst type configuration registers */
 static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 {
-	struct device *dev = dwc->dev;
+	struct udevice *dev = dwc->dev;
 	/* incrx_mode : for INCR burst type. */
 	bool incrx_mode;
 	/* incrx_size : for size of INCRX burst. */
@@ -1337,9 +1076,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	/*
 	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
+	 * out which U-Boot version a bug was found.
 	 */
-	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
+	dwc3_writel(dwc->regs, DWC3_GUID, U_BOOT_VERSION_NUM);
 
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
@@ -1357,13 +1096,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->ulpi_ready = true;
 	}
 
-	if (!dwc->phys_ready) {
-		ret = dwc3_core_get_phy(dwc);
-		if (ret)
-			goto err_exit_ulpi;
-		dwc->phys_ready = true;
-	}
-
 	ret = dwc3_phy_init(dwc);
 	if (ret)
 		goto err_exit_ulpi;
@@ -1528,78 +1260,17 @@ err_exit_ulpi:
 	return ret;
 }
 
-static int dwc3_core_get_phy(struct dwc3 *dwc)
+int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
 {
-	struct device		*dev = dwc->dev;
-	struct device_node	*node = dev->of_node;
-	char phy_name[9];
-	int ret;
-	u8 i;
-
-	if (node) {
-		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
-		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
-	} else {
-		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
-	}
-
-	if (IS_ERR(dwc->usb2_phy)) {
-		ret = PTR_ERR(dwc->usb2_phy);
-		if (ret == -ENXIO || ret == -ENODEV)
-			dwc->usb2_phy = NULL;
-		else
-			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
-	}
-
-	if (IS_ERR(dwc->usb3_phy)) {
-		ret = PTR_ERR(dwc->usb3_phy);
-		if (ret == -ENXIO || ret == -ENODEV)
-			dwc->usb3_phy = NULL;
-		else
-			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
-	}
-
-	for (i = 0; i < dwc->num_usb2_ports; i++) {
-		if (dwc->num_usb2_ports == 1)
-			snprintf(phy_name, sizeof(phy_name), "usb2-phy");
-		else
-			snprintf(phy_name, sizeof(phy_name),  "usb2-%u", i);
-
-		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
-		if (IS_ERR(dwc->usb2_generic_phy[i])) {
-			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
-			if (ret == -ENOSYS || ret == -ENODEV)
-				dwc->usb2_generic_phy[i] = NULL;
-			else
-				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
-							phy_name);
-		}
-	}
-
-	for (i = 0; i < dwc->num_usb3_ports; i++) {
-		if (dwc->num_usb3_ports == 1)
-			snprintf(phy_name, sizeof(phy_name), "usb3-phy");
-		else
-			snprintf(phy_name, sizeof(phy_name), "usb3-%u", i);
-
-		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
-		if (IS_ERR(dwc->usb3_generic_phy[i])) {
-			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
-			if (ret == -ENOSYS || ret == -ENODEV)
-				dwc->usb3_generic_phy[i] = NULL;
-			else
-				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
-							phy_name);
-		}
-	}
-
-	return 0;
+	/* TODO */
+	return -ENOSYS;
 }
+#define phy_set_mode(phy, mode) \
+	phy_set_mode_ext(phy, mode, 0)
 
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
-	struct device *dev = dwc->dev;
+	struct udevice *dev = dwc->dev;
 	int ret;
 	int i;
 
@@ -1607,8 +1278,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_PERIPHERAL:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
 		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
 		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
@@ -1619,8 +1288,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_HOST:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, true);
 		for (i = 0; i < dwc->num_usb2_ports; i++)
 			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
 		for (i = 0; i < dwc->num_usb3_ports; i++)
@@ -1644,6 +1311,14 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	return 0;
 }
 
+static void dwc3_core_stop(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg & ~(DWC3_DCTL_RUN_STOP));
+}
+
 static void dwc3_core_exit_mode(struct dwc3 *dwc)
 {
 	switch (dwc->dr_mode) {
@@ -1665,207 +1340,8 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
-static void dwc3_get_software_properties(struct dwc3 *dwc)
-{
-	struct device *tmpdev;
-	u16 gsbuscfg0_reqinfo;
-	int ret;
+#define DWC3_ALIGN_MASK		(16 - 1)
 
-	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
-
-	/*
-	 * Iterate over all parent nodes for finding swnode properties
-	 * and non-DT (non-ABI) properties.
-	 */
-	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
-		ret = device_property_read_u16(tmpdev,
-					       "snps,gsbuscfg0-reqinfo",
-					       &gsbuscfg0_reqinfo);
-		if (!ret)
-			dwc->gsbuscfg0_reqinfo = gsbuscfg0_reqinfo;
-	}
-}
-
-static void dwc3_get_properties(struct dwc3 *dwc)
-{
-	struct device		*dev = dwc->dev;
-	u8			lpm_nyet_threshold;
-	u8			tx_de_emphasis;
-	u8			hird_threshold;
-	u8			rx_thr_num_pkt = 0;
-	u8			rx_max_burst = 0;
-	u8			tx_thr_num_pkt = 0;
-	u8			tx_max_burst = 0;
-	u8			rx_thr_num_pkt_prd = 0;
-	u8			rx_max_burst_prd = 0;
-	u8			tx_thr_num_pkt_prd = 0;
-	u8			tx_max_burst_prd = 0;
-	u8			tx_fifo_resize_max_num;
-	u16			num_hc_interrupters;
-
-	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xf;
-
-	/* default to -3.5dB de-emphasis */
-	tx_de_emphasis = 1;
-
-	/*
-	 * default to assert utmi_sleep_n and use maximum allowed HIRD
-	 * threshold value of 0b1100
-	 */
-	hird_threshold = 12;
-
-	/*
-	 * default to a TXFIFO size large enough to fit 6 max packets.  This
-	 * allows for systems with larger bus latencies to have some headroom
-	 * for endpoints that have a large bMaxBurst value.
-	 */
-	tx_fifo_resize_max_num = 6;
-
-	/* default to a single XHCI interrupter */
-	num_hc_interrupters = 1;
-
-	dwc->maximum_speed = usb_get_maximum_speed(dev);
-	dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
-	dwc->dr_mode = usb_get_dr_mode(dev);
-	dwc->hsphy_mode = of_usb_get_phy_mode(dev->of_node);
-
-	dwc->sysdev_is_parent = device_property_read_bool(dev,
-				"linux,sysdev_is_parent");
-	if (dwc->sysdev_is_parent)
-		dwc->sysdev = dwc->dev->parent;
-	else
-		dwc->sysdev = dwc->dev;
-
-	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
-
-	dwc->has_lpm_erratum = device_property_read_bool(dev,
-				"snps,has-lpm-erratum");
-	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
-				&lpm_nyet_threshold);
-	dwc->is_utmi_l1_suspend = device_property_read_bool(dev,
-				"snps,is-utmi-l1-suspend");
-	device_property_read_u8(dev, "snps,hird-threshold",
-				&hird_threshold);
-	dwc->dis_start_transfer_quirk = device_property_read_bool(dev,
-				"snps,dis-start-transfer-quirk");
-	dwc->usb3_lpm_capable = device_property_read_bool(dev,
-				"snps,usb3_lpm_capable");
-	dwc->usb2_lpm_disable = device_property_read_bool(dev,
-				"snps,usb2-lpm-disable");
-	dwc->usb2_gadget_lpm_disable = device_property_read_bool(dev,
-				"snps,usb2-gadget-lpm-disable");
-	device_property_read_u8(dev, "snps,rx-thr-num-pkt",
-				&rx_thr_num_pkt);
-	device_property_read_u8(dev, "snps,rx-max-burst",
-				&rx_max_burst);
-	device_property_read_u8(dev, "snps,tx-thr-num-pkt",
-				&tx_thr_num_pkt);
-	device_property_read_u8(dev, "snps,tx-max-burst",
-				&tx_max_burst);
-	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
-				&rx_thr_num_pkt_prd);
-	device_property_read_u8(dev, "snps,rx-max-burst-prd",
-				&rx_max_burst_prd);
-	device_property_read_u8(dev, "snps,tx-thr-num-pkt-prd",
-				&tx_thr_num_pkt_prd);
-	device_property_read_u8(dev, "snps,tx-max-burst-prd",
-				&tx_max_burst_prd);
-	device_property_read_u16(dev, "num-hc-interrupters",
-				 &num_hc_interrupters);
-	/* DWC3 core allowed to have a max of 8 interrupters */
-	if (num_hc_interrupters > 8)
-		num_hc_interrupters = 8;
-
-	dwc->do_fifo_resize = device_property_read_bool(dev,
-							"tx-fifo-resize");
-	if (dwc->do_fifo_resize)
-		device_property_read_u8(dev, "tx-fifo-max-num",
-					&tx_fifo_resize_max_num);
-
-	dwc->disable_scramble_quirk = device_property_read_bool(dev,
-				"snps,disable_scramble_quirk");
-	dwc->u2exit_lfps_quirk = device_property_read_bool(dev,
-				"snps,u2exit_lfps_quirk");
-	dwc->u2ss_inp3_quirk = device_property_read_bool(dev,
-				"snps,u2ss_inp3_quirk");
-	dwc->req_p1p2p3_quirk = device_property_read_bool(dev,
-				"snps,req_p1p2p3_quirk");
-	dwc->del_p1p2p3_quirk = device_property_read_bool(dev,
-				"snps,del_p1p2p3_quirk");
-	dwc->del_phy_power_chg_quirk = device_property_read_bool(dev,
-				"snps,del_phy_power_chg_quirk");
-	dwc->lfps_filter_quirk = device_property_read_bool(dev,
-				"snps,lfps_filter_quirk");
-	dwc->rx_detect_poll_quirk = device_property_read_bool(dev,
-				"snps,rx_detect_poll_quirk");
-	dwc->dis_u3_susphy_quirk = device_property_read_bool(dev,
-				"snps,dis_u3_susphy_quirk");
-	dwc->dis_u2_susphy_quirk = device_property_read_bool(dev,
-				"snps,dis_u2_susphy_quirk");
-	dwc->dis_enblslpm_quirk = device_property_read_bool(dev,
-				"snps,dis_enblslpm_quirk");
-	dwc->dis_u1_entry_quirk = device_property_read_bool(dev,
-				"snps,dis-u1-entry-quirk");
-	dwc->dis_u2_entry_quirk = device_property_read_bool(dev,
-				"snps,dis-u2-entry-quirk");
-	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
-				"snps,dis_rxdet_inp3_quirk");
-	dwc->dis_u2_freeclk_exists_quirk = device_property_read_bool(dev,
-				"snps,dis-u2-freeclk-exists-quirk");
-	dwc->dis_del_phy_power_chg_quirk = device_property_read_bool(dev,
-				"snps,dis-del-phy-power-chg-quirk");
-	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
-				"snps,dis-tx-ipgap-linecheck-quirk");
-	dwc->resume_hs_terminations = device_property_read_bool(dev,
-				"snps,resume-hs-terminations");
-	dwc->ulpi_ext_vbus_drv = device_property_read_bool(dev,
-				"snps,ulpi-ext-vbus-drv");
-	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
-				"snps,parkmode-disable-ss-quirk");
-	dwc->parkmode_disable_hs_quirk = device_property_read_bool(dev,
-				"snps,parkmode-disable-hs-quirk");
-	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
-				"snps,gfladj-refclk-lpm-sel-quirk");
-
-	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
-				"snps,tx_de_emphasis_quirk");
-	device_property_read_u8(dev, "snps,tx_de_emphasis",
-				&tx_de_emphasis);
-	device_property_read_string(dev, "snps,hsphy_interface",
-				    &dwc->hsphy_interface);
-	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
-				 &dwc->fladj);
-	device_property_read_u32(dev, "snps,ref-clock-period-ns",
-				 &dwc->ref_clk_per);
-
-	dwc->dis_metastability_quirk = device_property_read_bool(dev,
-				"snps,dis_metastability_quirk");
-
-	dwc->dis_split_quirk = device_property_read_bool(dev,
-				"snps,dis-split-quirk");
-
-	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
-	dwc->tx_de_emphasis = tx_de_emphasis;
-
-	dwc->hird_threshold = hird_threshold;
-
-	dwc->rx_thr_num_pkt = rx_thr_num_pkt;
-	dwc->rx_max_burst = rx_max_burst;
-
-	dwc->tx_thr_num_pkt = tx_thr_num_pkt;
-	dwc->tx_max_burst = tx_max_burst;
-
-	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
-	dwc->rx_max_burst_prd = rx_max_burst_prd;
-
-	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
-	dwc->tx_max_burst_prd = tx_max_burst_prd;
-
-	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
-
-	dwc->num_hc_interrupters = num_hc_interrupters;
-}
 
 /* check whether the core supports IMOD */
 bool dwc3_has_imod(struct dwc3 *dwc)
@@ -1875,227 +1351,6 @@ bool dwc3_has_imod(struct dwc3 *dwc)
 		DWC3_IP_IS(DWC32);
 }
 
-static void dwc3_check_params(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	unsigned int hwparam_gen =
-		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
-
-	/*
-	 * Enable IMOD for all supporting controllers.
-	 *
-	 * Particularly, DWC_usb3 v3.00a must enable this feature for
-	 * the following reason:
-	 *
-	 * Workaround for STAR 9000961433 which affects only version
-	 * 3.00a of the DWC_usb3 core. This prevents the controller
-	 * interrupt from being masked while handling events. IMOD
-	 * allows us to work around this issue. Enable it for the
-	 * affected version.
-	 */
-	if (dwc3_has_imod((dwc)))
-		dwc->imod_interval = 1;
-
-	/* Check the maximum_speed parameter */
-	switch (dwc->maximum_speed) {
-	case USB_SPEED_FULL:
-	case USB_SPEED_HIGH:
-		break;
-	case USB_SPEED_SUPER:
-		if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS)
-			dev_warn(dev, "UDC doesn't support Gen 1\n");
-		break;
-	case USB_SPEED_SUPER_PLUS:
-		if ((DWC3_IP_IS(DWC32) &&
-		     hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS) ||
-		    (!DWC3_IP_IS(DWC32) &&
-		     hwparam_gen != DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
-			dev_warn(dev, "UDC doesn't support SSP\n");
-		break;
-	default:
-		dev_err(dev, "invalid maximum_speed parameter %d\n",
-			dwc->maximum_speed);
-		fallthrough;
-	case USB_SPEED_UNKNOWN:
-		switch (hwparam_gen) {
-		case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
-			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
-			break;
-		case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
-			if (DWC3_IP_IS(DWC32))
-				dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
-			else
-				dwc->maximum_speed = USB_SPEED_SUPER;
-			break;
-		case DWC3_GHWPARAMS3_SSPHY_IFC_DIS:
-			dwc->maximum_speed = USB_SPEED_HIGH;
-			break;
-		default:
-			dwc->maximum_speed = USB_SPEED_SUPER;
-			break;
-		}
-		break;
-	}
-
-	/*
-	 * Currently the controller does not have visibility into the HW
-	 * parameter to determine the maximum number of lanes the HW supports.
-	 * If the number of lanes is not specified in the device property, then
-	 * set the default to support dual-lane for DWC_usb32 and single-lane
-	 * for DWC_usb31 for super-speed-plus.
-	 */
-	if (dwc->maximum_speed == USB_SPEED_SUPER_PLUS) {
-		switch (dwc->max_ssp_rate) {
-		case USB_SSP_GEN_2x1:
-			if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_GEN1)
-				dev_warn(dev, "UDC only supports Gen 1\n");
-			break;
-		case USB_SSP_GEN_1x2:
-		case USB_SSP_GEN_2x2:
-			if (DWC3_IP_IS(DWC31))
-				dev_warn(dev, "UDC only supports single lane\n");
-			break;
-		case USB_SSP_GEN_UNKNOWN:
-		default:
-			switch (hwparam_gen) {
-			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
-				if (DWC3_IP_IS(DWC32))
-					dwc->max_ssp_rate = USB_SSP_GEN_2x2;
-				else
-					dwc->max_ssp_rate = USB_SSP_GEN_2x1;
-				break;
-			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
-				if (DWC3_IP_IS(DWC32))
-					dwc->max_ssp_rate = USB_SSP_GEN_1x2;
-				break;
-			}
-			break;
-		}
-	}
-}
-
-static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	struct device_node *np_phy;
-	struct extcon_dev *edev = NULL;
-	const char *name;
-
-	if (device_property_present(dev, "extcon"))
-		return extcon_get_edev_by_phandle(dev, 0);
-
-	/*
-	 * Device tree platforms should get extcon via phandle.
-	 * On ACPI platforms, we get the name from a device property.
-	 * This device property is for kernel internal use only and
-	 * is expected to be set by the glue code.
-	 */
-	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
-		return extcon_get_extcon_dev(name);
-
-	/*
-	 * Check explicitly if "usb-role-switch" is used since
-	 * extcon_find_edev_by_node() can not be used to check the absence of
-	 * an extcon device. In the absence of an device it will always return
-	 * EPROBE_DEFER.
-	 */
-	if (IS_ENABLED(CONFIG_USB_ROLE_SWITCH) &&
-	    device_property_read_bool(dev, "usb-role-switch"))
-		return NULL;
-
-	/*
-	 * Try to get an extcon device from the USB PHY controller's "port"
-	 * node. Check if it has the "port" node first, to avoid printing the
-	 * error message from underlying code, as it's a valid case: extcon
-	 * device (and "port" node) may be missing in case of "usb-role-switch"
-	 * or OTG mode.
-	 */
-	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
-	if (of_graph_is_present(np_phy)) {
-		struct device_node *np_conn;
-
-		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
-		if (np_conn)
-			edev = extcon_find_edev_by_node(np_conn);
-		of_node_put(np_conn);
-	}
-	of_node_put(np_phy);
-
-	return edev;
-}
-
-static int dwc3_get_clocks(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-
-	if (!dev->of_node)
-		return 0;
-
-	/*
-	 * Clocks are optional, but new DT platforms should support all clocks
-	 * as required by the DT-binding.
-	 * Some devices have different clock names in legacy device trees,
-	 * check for them to retain backwards compatibility.
-	 */
-	dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
-	if (IS_ERR(dwc->bus_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-				"could not get bus clock\n");
-	}
-
-	if (dwc->bus_clk == NULL) {
-		dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
-		if (IS_ERR(dwc->bus_clk)) {
-			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-					"could not get bus clock\n");
-		}
-	}
-
-	dwc->ref_clk = devm_clk_get_optional(dev, "ref");
-	if (IS_ERR(dwc->ref_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-				"could not get ref clock\n");
-	}
-
-	if (dwc->ref_clk == NULL) {
-		dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
-		if (IS_ERR(dwc->ref_clk)) {
-			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-					"could not get ref clock\n");
-		}
-	}
-
-	dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
-	if (IS_ERR(dwc->susp_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-				"could not get suspend clock\n");
-	}
-
-	if (dwc->susp_clk == NULL) {
-		dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
-		if (IS_ERR(dwc->susp_clk)) {
-			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-					"could not get suspend clock\n");
-		}
-	}
-
-	/* specific to Rockchip RK3588 */
-	dwc->utmi_clk = devm_clk_get_optional(dev, "utmi");
-	if (IS_ERR(dwc->utmi_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->utmi_clk),
-				"could not get utmi clock\n");
-	}
-
-	/* specific to Rockchip RK3588 */
-	dwc->pipe_clk = devm_clk_get_optional(dev, "pipe");
-	if (IS_ERR(dwc->pipe_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->pipe_clk),
-				"could not get pipe clock\n");
-	}
-
-	return 0;
-}
-
 static int dwc3_get_num_ports(struct dwc3 *dwc)
 {
 	void __iomem *base;
@@ -2145,108 +1400,142 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 	return 0;
 }
 
-static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
+#if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
+int dwc3_setup_phy(struct udevice *dev, struct phy_bulk *phys)
 {
-	struct power_supply *usb_psy;
-	const char *usb_psy_name;
 	int ret;
 
-	ret = device_property_read_string(dwc->dev, "usb-psy-name", &usb_psy_name);
-	if (ret < 0)
-		return NULL;
+	ret = generic_phy_get_bulk(dev, phys);
+	if (ret)
+		return ret;
+
+	ret = generic_phy_init_bulk(phys);
+	if (ret)
+		return ret;
 
-	usb_psy = power_supply_get_by_name(usb_psy_name);
-	if (!usb_psy)
-		return ERR_PTR(-EPROBE_DEFER);
+	ret = generic_phy_power_on_bulk(phys);
+	if (ret)
+		generic_phy_exit_bulk(phys);
 
-	return usb_psy;
+	return ret;
 }
 
-int dwc3_core_probe(const struct dwc3_probe_data *data)
+int dwc3_shutdown_phy(struct udevice *dev, struct phy_bulk *phys)
 {
-	struct dwc3		*dwc = data->dwc;
-	struct device		*dev = dwc->dev;
-	struct resource		dwc_res;
-	unsigned int		hw_mode;
-	void __iomem		*regs;
-	struct resource		*res = data->res;
-	int			ret;
-
-	dwc->xhci_resources[0].start = res->start;
-	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
-					DWC3_XHCI_REGS_END;
-	dwc->xhci_resources[0].flags = res->flags;
-	dwc->xhci_resources[0].name = res->name;
-
-	/*
-	 * Request memory region but exclude xHCI regs,
-	 * since it will be requested by the xhci-plat driver.
-	 */
-	dwc_res = *res;
-	dwc_res.start += DWC3_GLOBALS_REGS_START;
-
-	if (dev->of_node) {
-		struct device_node *parent = of_get_parent(dev->of_node);
-
-		if (of_device_is_compatible(parent, "realtek,rtd-dwc3")) {
-			dwc_res.start -= DWC3_GLOBALS_REGS_START;
-			dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
-		}
-
-		of_node_put(parent);
-	}
-
-	regs = devm_ioremap_resource(dev, &dwc_res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	int ret;
 
-	dwc->regs	= regs;
-	dwc->regs_size	= resource_size(&dwc_res);
+	ret = generic_phy_power_off_bulk(phys);
+	ret |= generic_phy_exit_bulk(phys);
+	return ret;
+}
+#endif
 
-	dwc3_get_properties(dwc);
+#if CONFIG_IS_ENABLED(DM_USB)
+void dwc3_of_parse(struct dwc3 *dwc)
+{
+	const u8 *tmp;
+	struct udevice *dev = dwc->dev;
+	u8 lpm_nyet_threshold;
+	u8 tx_de_emphasis;
+	u8 hird_threshold;
+	u32 val;
+	int i;
 
-	dwc3_get_software_properties(dwc);
+	/* default to highest possible threshold */
+	lpm_nyet_threshold = 0xff;
 
-	dwc->usb_psy = dwc3_get_usb_power_supply(dwc);
-	if (IS_ERR(dwc->usb_psy))
-		return dev_err_probe(dev, PTR_ERR(dwc->usb_psy), "couldn't get usb power supply\n");
+	/* default to -3.5dB de-emphasis */
+	tx_de_emphasis = 1;
 
-	if (!data->ignore_clocks_and_resets) {
-		dwc->reset = devm_reset_control_array_get_optional_shared(dev);
-		if (IS_ERR(dwc->reset)) {
-			ret = PTR_ERR(dwc->reset);
-			goto err_put_psy;
-		}
+	/*
+	 * default to assert utmi_sleep_n and use maximum allowed HIRD
+	 * threshold value of 0b1100
+	 */
+	hird_threshold = 12;
+
+	dwc->hsphy_mode = usb_get_phy_mode(dev_ofnode(dev));
+
+	dwc->has_lpm_erratum = dev_read_bool(dev,
+				"snps,has-lpm-erratum");
+	tmp = dev_read_u8_array_ptr(dev, "snps,lpm-nyet-threshold", 1);
+	if (tmp)
+		lpm_nyet_threshold = *tmp;
+
+	dwc->is_utmi_l1_suspend = dev_read_bool(dev,
+				"snps,is-utmi-l1-suspend");
+	tmp = dev_read_u8_array_ptr(dev, "snps,hird-threshold", 1);
+	if (tmp)
+		hird_threshold = *tmp;
+
+	dwc->disable_scramble_quirk = dev_read_bool(dev,
+				"snps,disable_scramble_quirk");
+	dwc->u2exit_lfps_quirk = dev_read_bool(dev,
+				"snps,u2exit_lfps_quirk");
+	dwc->u2ss_inp3_quirk = dev_read_bool(dev,
+				"snps,u2ss_inp3_quirk");
+	dwc->req_p1p2p3_quirk = dev_read_bool(dev,
+				"snps,req_p1p2p3_quirk");
+	dwc->del_p1p2p3_quirk = dev_read_bool(dev,
+				"snps,del_p1p2p3_quirk");
+	dwc->del_phy_power_chg_quirk = dev_read_bool(dev,
+				"snps,del_phy_power_chg_quirk");
+	dwc->lfps_filter_quirk = dev_read_bool(dev,
+				"snps,lfps_filter_quirk");
+	dwc->rx_detect_poll_quirk = dev_read_bool(dev,
+				"snps,rx_detect_poll_quirk");
+	dwc->dis_u3_susphy_quirk = dev_read_bool(dev,
+				"snps,dis_u3_susphy_quirk");
+	dwc->dis_u2_susphy_quirk = dev_read_bool(dev,
+				"snps,dis_u2_susphy_quirk");
+	dwc->dis_del_phy_power_chg_quirk = dev_read_bool(dev,
+				"snps,dis-del-phy-power-chg-quirk");
+	dwc->dis_tx_ipgap_linecheck_quirk = dev_read_bool(dev,
+				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->dis_enblslpm_quirk = dev_read_bool(dev,
+				"snps,dis_enblslpm_quirk");
+	dwc->dis_u2_freeclk_exists_quirk = dev_read_bool(dev,
+				"snps,dis-u2-freeclk-exists-quirk");
+	dwc->tx_de_emphasis_quirk = dev_read_bool(dev,
+				"snps,tx_de_emphasis_quirk");
+	tmp = dev_read_u8_array_ptr(dev, "snps,tx_de_emphasis", 1);
+	if (tmp)
+		tx_de_emphasis = *tmp;
+
+	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
+	dwc->tx_de_emphasis = tx_de_emphasis;
+
+	dwc->hird_threshold = hird_threshold
+		| (dwc->is_utmi_l1_suspend << 4);
+
+	dev_read_u32(dev, "snps,quirk-frame-length-adjustment", &dwc->fladj);
 
-		ret = dwc3_get_clocks(dwc);
-		if (ret)
-			goto err_put_psy;
+	/*
+	 * Handle property "snps,incr-burst-type-adjustment".
+	 * Get the number of value from this property:
+	 * result <= 0, means this property is not supported.
+	 * result = 1, means INCRx burst mode supported.
+	 * result > 1, means undefined length burst mode supported.
+	 */
+	dwc->incrx_mode = INCRX_BURST_MODE;
+	dwc->incrx_size = 0;
+	for (i = 0; i < 8; i++) {
+		if (dev_read_u32_index(dev, "snps,incr-burst-type-adjustment",
+				       i, &val))
+			break;
+
+		dwc->incrx_mode = INCRX_UNDEF_LENGTH_BURST_MODE;
+		dwc->incrx_size = max(dwc->incrx_size, val);
 	}
+}
 
-	ret = reset_control_deassert(dwc->reset);
-	if (ret)
-		goto err_put_psy;
-
-	ret = dwc3_clk_enable(dwc);
-	if (ret)
-		goto err_assert_reset;
-
-	if (!dwc3_core_is_valid(dwc)) {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		ret = -ENODEV;
-		goto err_disable_clks;
-	}
+int dwc3_init(struct dwc3 *dwc)
+{
+	unsigned int hw_mode;
+	int ret;
+	u32 reg;
 
-	dev_set_drvdata(dev, dwc);
 	dwc3_cache_hwparams(dwc);
 
-	if (!dwc->sysdev_is_parent &&
-	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
-		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
-		if (ret)
-			goto err_disable_clks;
-	}
-
 	/*
 	 * Currently only DWC3 controllers that are host-only capable
 	 * can have more than one port.
@@ -2255,7 +1544,7 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
 		ret = dwc3_get_num_ports(dwc);
 		if (ret)
-			goto err_disable_clks;
+			return ret;
 	} else {
 		dwc->num_usb2_ports = 1;
 		dwc->num_usb3_ports = 1;
@@ -2264,551 +1553,275 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
-	pm_runtime_get_noresume(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
-	pm_runtime_enable(dev);
-
-	pm_runtime_forbid(dev);
-
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
-		ret = -ENOMEM;
-		goto err_allow_rpm;
+		return -ENOMEM;
 	}
 
-	dwc->edev = dwc3_get_extcon(dwc);
-	if (IS_ERR(dwc->edev)) {
-		ret = dev_err_probe(dwc->dev, PTR_ERR(dwc->edev), "failed to get extcon\n");
-		goto err_free_event_buffers;
-	}
-
-	ret = dwc3_get_dr_mode(dwc);
-	if (ret)
-		goto err_free_event_buffers;
-
 	ret = dwc3_core_init(dwc);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to initialize core\n");
-		goto err_free_event_buffers;
+		dev_err(dwc->dev, "failed to initialize core\n");
+		goto core_fail;
 	}
 
-	dwc3_check_params(dwc);
-	dwc3_debugfs_init(dwc);
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto event_fail;
+	}
+
+	if (dwc->revision >= DWC3_REVISION_250A) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+
+		/*
+		 * Enable hardware control of sending remote wakeup
+		 * in HS when the device is in the L1 state.
+		 */
+		if (dwc->revision >= DWC3_REVISION_290A)
+			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
+
+		if (dwc->dis_tx_ipgap_linecheck_quirk)
+			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+	}
+
+	if (dwc->dr_mode == USB_DR_MODE_HOST ||
+	    dwc->dr_mode == USB_DR_MODE_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+
+		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+	}
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
-		goto err_exit_debugfs;
-
-	pm_runtime_put(dev);
-
-	dma_set_max_seg_size(dev, UINT_MAX);
+		goto mode_fail;
 
 	return 0;
 
-err_exit_debugfs:
-	dwc3_debugfs_exit(dwc);
+mode_fail:
 	dwc3_event_buffers_cleanup(dwc);
-	dwc3_phy_power_off(dwc);
-	dwc3_phy_exit(dwc);
-	dwc3_ulpi_exit(dwc);
-err_free_event_buffers:
+
+event_fail:
+	dwc3_core_exit(dwc);
+
+core_fail:
 	dwc3_free_event_buffers(dwc);
-err_allow_rpm:
-	pm_runtime_allow(dev);
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-	pm_runtime_set_suspended(dev);
-	pm_runtime_put_noidle(dev);
-err_disable_clks:
-	dwc3_clk_disable(dwc);
-err_assert_reset:
-	reset_control_assert(dwc->reset);
-err_put_psy:
-	if (dwc->usb_psy)
-		power_supply_put(dwc->usb_psy);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(dwc3_core_probe);
 
-static int dwc3_probe(struct platform_device *pdev)
+void dwc3_remove(struct dwc3 *dwc)
 {
-	struct dwc3_probe_data probe_data = {};
-	struct resource *res;
-	struct dwc3 *dwc;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "missing memory resource\n");
-		return -ENODEV;
-	}
-
-	dwc = devm_kzalloc(&pdev->dev, sizeof(*dwc), GFP_KERNEL);
-	if (!dwc)
-		return -ENOMEM;
-
-	dwc->dev = &pdev->dev;
-
-	probe_data.dwc = dwc;
-	probe_data.res = res;
-
-	return dwc3_core_probe(&probe_data);
-}
-
-void dwc3_core_remove(struct dwc3 *dwc)
-{
-	pm_runtime_get_sync(dwc->dev);
-
 	dwc3_core_exit_mode(dwc);
-	dwc3_debugfs_exit(dwc);
-
+	dwc3_event_buffers_cleanup(dwc);
+	dwc3_free_event_buffers(dwc);
+	dwc3_core_stop(dwc);
 	dwc3_core_exit(dwc);
-	dwc3_ulpi_exit(dwc);
+}
+#endif
+
+/**
+ * dwc3_uboot_init - dwc3 core uboot initialization code
+ * @dwc3_dev: struct dwc3_device containing initialization data
+ *
+ * Entry point for dwc3 driver (equivalent to dwc3_probe in linux
+ * kernel driver). Pointer to dwc3_device should be passed containing
+ * base address and other initialization data. Returns '0' on success and
+ * a negative value on failure.
+ *
+ * Generally called from board_usb_init() implemented in board file.
+ */
+int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
+{
+	struct dwc3		*dwc;
+	struct device		*dev = NULL;
+	u8			lpm_nyet_threshold;
+	u8			tx_de_emphasis;
+	u8			hird_threshold;
+
+	int			ret;
+
+	void			*mem;
+
+	mem = devm_kzalloc((struct udevice *)dev,
+			   sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
+	dwc->mem = mem;
+
+	dwc->regs = (void *)(uintptr_t)(dwc3_dev->base +
+					DWC3_GLOBALS_REGS_START);
+
+	/* default to highest possible threshold */
+	lpm_nyet_threshold = 0xff;
+
+	/* default to -3.5dB de-emphasis */
+	tx_de_emphasis = 1;
 
-	pm_runtime_allow(dwc->dev);
-	pm_runtime_disable(dwc->dev);
-	pm_runtime_dont_use_autosuspend(dwc->dev);
-	pm_runtime_put_noidle(dwc->dev);
 	/*
-	 * HACK: Clear the driver data, which is currently accessed by parent
-	 * glue drivers, before allowing the parent to suspend.
+	 * default to assert utmi_sleep_n and use maximum allowed HIRD
+	 * threshold value of 0b1100
 	 */
-	dev_set_drvdata(dwc->dev, NULL);
-	pm_runtime_set_suspended(dwc->dev);
+	hird_threshold = 12;
 
-	dwc3_free_event_buffers(dwc);
+	dwc->maximum_speed = dwc3_dev->maximum_speed;
+	dwc->has_lpm_erratum = dwc3_dev->has_lpm_erratum;
+	if (dwc3_dev->lpm_nyet_threshold)
+		lpm_nyet_threshold = dwc3_dev->lpm_nyet_threshold;
+	dwc->is_utmi_l1_suspend = dwc3_dev->is_utmi_l1_suspend;
+	if (dwc3_dev->hird_threshold)
+		hird_threshold = dwc3_dev->hird_threshold;
 
-	if (dwc->usb_psy)
-		power_supply_put(dwc->usb_psy);
-}
-EXPORT_SYMBOL_GPL(dwc3_core_remove);
+	dwc->do_fifo_resize = dwc3_dev->tx_fifo_resize;
+	dwc->dr_mode = dwc3_dev->dr_mode;
 
-static void dwc3_remove(struct platform_device *pdev)
-{
-	dwc3_core_remove(platform_get_drvdata(pdev));
-}
+	dwc->disable_scramble_quirk = dwc3_dev->disable_scramble_quirk;
+	dwc->u2exit_lfps_quirk = dwc3_dev->u2exit_lfps_quirk;
+	dwc->u2ss_inp3_quirk = dwc3_dev->u2ss_inp3_quirk;
+	dwc->req_p1p2p3_quirk = dwc3_dev->req_p1p2p3_quirk;
+	dwc->del_p1p2p3_quirk = dwc3_dev->del_p1p2p3_quirk;
+	dwc->del_phy_power_chg_quirk = dwc3_dev->del_phy_power_chg_quirk;
+	dwc->lfps_filter_quirk = dwc3_dev->lfps_filter_quirk;
+	dwc->rx_detect_poll_quirk = dwc3_dev->rx_detect_poll_quirk;
+	dwc->dis_u3_susphy_quirk = dwc3_dev->dis_u3_susphy_quirk;
+	dwc->dis_u2_susphy_quirk = dwc3_dev->dis_u2_susphy_quirk;
+	dwc->dis_del_phy_power_chg_quirk = dwc3_dev->dis_del_phy_power_chg_quirk;
+	dwc->dis_tx_ipgap_linecheck_quirk = dwc3_dev->dis_tx_ipgap_linecheck_quirk;
+	dwc->dis_enblslpm_quirk = dwc3_dev->dis_enblslpm_quirk;
+	dwc->dis_u2_freeclk_exists_quirk = dwc3_dev->dis_u2_freeclk_exists_quirk;
 
-#ifdef CONFIG_PM
-static int dwc3_core_init_for_resume(struct dwc3 *dwc)
-{
-	int ret;
+	dwc->tx_de_emphasis_quirk = dwc3_dev->tx_de_emphasis_quirk;
+	if (dwc3_dev->tx_de_emphasis)
+		tx_de_emphasis = dwc3_dev->tx_de_emphasis;
 
-	ret = reset_control_deassert(dwc->reset);
-	if (ret)
-		return ret;
+	/* default to superspeed if no maximum_speed passed */
+	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
+		dwc->maximum_speed = USB_SPEED_SUPER;
 
-	ret = dwc3_clk_enable(dwc);
-	if (ret)
-		goto assert_reset;
+	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
+	dwc->tx_de_emphasis = tx_de_emphasis;
+
+	dwc->hird_threshold = hird_threshold
+		| (dwc->is_utmi_l1_suspend << 4);
+
+	dwc->hsphy_mode = dwc3_dev->hsphy_mode;
+
+	dwc->index = dwc3_dev->index;
+
+	dwc3_cache_hwparams(dwc);
+
+	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
+	if (ret) {
+		dev_err(dwc->dev, "failed to allocate event buffers\n");
+		return -ENOMEM;
+	}
+
+	if (!IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+		dwc->dr_mode = USB_DR_MODE_HOST;
+	else if (!IS_ENABLED(CONFIG_USB_HOST))
+		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
+
+	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
+		dwc->dr_mode = USB_DR_MODE_OTG;
 
 	ret = dwc3_core_init(dwc);
-	if (ret)
-		goto disable_clks;
-
-	return 0;
-
-disable_clks:
-	dwc3_clk_disable(dwc);
-assert_reset:
-	reset_control_assert(dwc->reset);
-
-	return ret;
-}
-
-static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
-{
-	u32 reg;
-	int i;
-	int ret;
-
-	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
-		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
-				    DWC3_GUSB2PHYCFG_SUSPHY) ||
-				    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
-				    DWC3_GUSB3PIPECTL_SUSPHY);
-		/*
-		 * TI AM62 platform requires SUSPHY to be
-		 * enabled for system suspend to work.
-		 */
-		if (!dwc->susphy_state)
-			dwc3_enable_susphy(dwc, true);
-	}
-
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (pm_runtime_suspended(dwc->dev))
-			break;
-		ret = dwc3_gadget_suspend(dwc);
-		if (ret)
-			return ret;
-		synchronize_irq(dwc->irq_gadget);
-		dwc3_core_exit(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
-			dwc3_core_exit(dwc);
-			break;
-		}
-
-		/* Let controller to suspend HSPHY before PHY driver suspends */
-		if (dwc->dis_u2_susphy_quirk ||
-		    dwc->dis_enblslpm_quirk) {
-			for (i = 0; i < dwc->num_usb2_ports; i++) {
-				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
-				reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
-					DWC3_GUSB2PHYCFG_SUSPHY;
-				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
-			}
-
-			/* Give some time for USB2 PHY to suspend */
-			usleep_range(5000, 6000);
-		}
-
-		for (i = 0; i < dwc->num_usb2_ports; i++)
-			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
-		for (i = 0; i < dwc->num_usb3_ports; i++)
-			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		/* do nothing during runtime_suspend */
-		if (PMSG_IS_AUTO(msg))
-			break;
-
-		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			ret = dwc3_gadget_suspend(dwc);
-			if (ret)
-				return ret;
-			synchronize_irq(dwc->irq_gadget);
-		}
-
-		dwc3_otg_exit(dwc);
-		dwc3_core_exit(dwc);
-		break;
-	default:
-		/* do nothing */
-		break;
-	}
-
-	return 0;
-}
-
-static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
-{
-	int		ret;
-	u32		reg;
-	int		i;
-
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		ret = dwc3_core_init_for_resume(dwc);
-		if (ret)
-			return ret;
-
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
-		dwc3_gadget_resume(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
-			ret = dwc3_core_init_for_resume(dwc);
-			if (ret)
-				return ret;
-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, true);
-			break;
-		}
-		/* Restore GUSB2PHYCFG bits that were modified in suspend */
-		for (i = 0; i < dwc->num_usb2_ports; i++) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
-			if (dwc->dis_u2_susphy_quirk)
-				reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-
-			if (dwc->dis_enblslpm_quirk)
-				reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
-
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
-		}
-
-		for (i = 0; i < dwc->num_usb2_ports; i++)
-			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
-		for (i = 0; i < dwc->num_usb3_ports; i++)
-			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		/* nothing to do on runtime_resume */
-		if (PMSG_IS_AUTO(msg))
-			break;
-
-		ret = dwc3_core_init_for_resume(dwc);
-		if (ret)
-			return ret;
-
-		dwc3_set_prtcap(dwc, dwc->current_dr_role, true);
-
-		dwc3_otg_init(dwc);
-		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
-			dwc3_otg_host_init(dwc);
-		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			dwc3_gadget_resume(dwc);
-		}
-
-		break;
-	default:
-		/* do nothing */
-		break;
+	if (ret) {
+		dev_err(dwc->dev, "failed to initialize core\n");
+		goto err0;
 	}
 
-	if (!PMSG_IS_AUTO(msg)) {
-		/* restore SUSPHY state to that before system suspend. */
-		dwc3_enable_susphy(dwc, dwc->susphy_state);
-	}
-
-	return 0;
-}
-
-static int dwc3_runtime_checks(struct dwc3 *dwc)
-{
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (dwc->connected)
-			return -EBUSY;
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-	default:
-		/* do nothing */
-		break;
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto err1;
 	}
 
-	return 0;
-}
-
-int dwc3_runtime_suspend(struct dwc3 *dwc)
-{
-	int		ret;
-
-	if (dwc3_runtime_checks(dwc))
-		return -EBUSY;
-
-	ret = dwc3_suspend_common(dwc, PMSG_AUTO_SUSPEND);
+	ret = dwc3_core_init_mode(dwc);
 	if (ret)
-		return ret;
+		goto err2;
 
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dwc3_runtime_suspend);
+	list_add_tail(&dwc->list, &dwc3_list);
 
-int dwc3_runtime_resume(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	int		ret;
+	return 0;
 
-	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
-	if (ret)
-		return ret;
+err2:
+	dwc3_event_buffers_cleanup(dwc);
 
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (dwc->pending_events) {
-			pm_runtime_put(dev);
-			dwc->pending_events = false;
-			enable_irq(dwc->irq_gadget);
-		}
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-	default:
-		/* do nothing */
-		break;
-	}
+err1:
+	dwc3_core_exit(dwc);
 
-	pm_runtime_mark_last_busy(dev);
+err0:
+	dwc3_free_event_buffers(dwc);
 
-	return 0;
+	return ret;
 }
-EXPORT_SYMBOL_GPL(dwc3_runtime_resume);
-
-int dwc3_runtime_idle(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
 
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (dwc3_runtime_checks(dwc))
-			return -EBUSY;
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-	default:
-		/* do nothing */
+/**
+ * dwc3_uboot_exit - dwc3 core uboot cleanup code
+ * @index: index of this controller
+ *
+ * Performs cleanup of memory allocated in dwc3_uboot_init and other misc
+ * cleanups (equivalent to dwc3_remove in linux). index of _this_ controller
+ * should be passed and should match with the index passed in
+ * dwc3_device during init.
+ *
+ * Generally called from board file.
+ */
+void dwc3_uboot_exit(int index)
+{
+	struct dwc3 *dwc;
+
+	list_for_each_entry(dwc, &dwc3_list, list) {
+		if (dwc->index != index)
+			continue;
+
+		dwc3_core_exit_mode(dwc);
+		dwc3_event_buffers_cleanup(dwc);
+		dwc3_free_event_buffers(dwc);
+		dwc3_core_exit(dwc);
+		list_del(&dwc->list);
+		kfree(dwc->mem);
 		break;
 	}
-
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_autosuspend(dev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dwc3_runtime_idle);
-
-static int dwc3_plat_runtime_suspend(struct device *dev)
-{
-	return dwc3_runtime_suspend(dev_get_drvdata(dev));
 }
 
-static int dwc3_plat_runtime_resume(struct device *dev)
-{
-	return dwc3_runtime_resume(dev_get_drvdata(dev));
-}
 
-static int dwc3_plat_runtime_idle(struct device *dev)
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
 {
-	return dwc3_runtime_idle(dev_get_drvdata(dev));
+	return 1;
 }
-#endif /* CONFIG_PM */
 
-#ifdef CONFIG_PM_SLEEP
-int dwc3_pm_suspend(struct dwc3 *dwc)
+/**
+ * dm_usb_gadget_handle_interrupts - handle dwc3 core interrupt
+ * @dev: device of this controller
+ *
+ * Invokes dwc3 gadget interrupts.
+ *
+ * Generally called from board file.
+ */
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
-	struct device *dev = dwc->dev;
-	int		ret;
-
-	ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
-	if (ret)
-		return ret;
-
-	pinctrl_pm_select_sleep_state(dev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dwc3_pm_suspend);
-
-int dwc3_pm_resume(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	int		ret = 0;
-
-	pinctrl_pm_select_default_state(dev);
-
-	pm_runtime_disable(dev);
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		goto out;
-
-	ret = dwc3_resume_common(dwc, PMSG_RESUME);
-	if (ret)
-		pm_runtime_set_suspended(dev);
-
-out:
-	pm_runtime_enable(dev);
+	struct dwc3 *dwc = NULL;
 
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dwc3_pm_resume);
+	if (!dwc3_uboot_interrupt_status(dev))
+		return 0;
 
-void dwc3_pm_complete(struct dwc3 *dwc)
-{
-	u32		reg;
+	list_for_each_entry(dwc, &dwc3_list, list) {
+		if (dwc->dev != dev)
+			continue;
 
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
-			dwc->dis_split_quirk) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
-		reg |= DWC3_GUCTL3_SPLITDISABLE;
-		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+		dwc3_gadget_uboot_handle_interrupt(dwc);
+		break;
 	}
-}
-EXPORT_SYMBOL_GPL(dwc3_pm_complete);
-
-int dwc3_pm_prepare(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-
-	/*
-	 * Indicate to the PM core that it may safely leave the device in
-	 * runtime suspend if runtime-suspended already in device mode.
-	 */
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE &&
-	    pm_runtime_suspended(dev) &&
-	    !dev_pinctrl(dev))
-		return 1;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dwc3_pm_prepare);
-
-static int dwc3_plat_suspend(struct device *dev)
-{
-	return dwc3_pm_suspend(dev_get_drvdata(dev));
-}
-
-static int dwc3_plat_resume(struct device *dev)
-{
-	return dwc3_pm_resume(dev_get_drvdata(dev));
-}
-
-static void dwc3_plat_complete(struct device *dev)
-{
-	dwc3_pm_complete(dev_get_drvdata(dev));
-}
-
-static int dwc3_plat_prepare(struct device *dev)
-{
-	return dwc3_pm_prepare(dev_get_drvdata(dev));
-}
-#else
-#define dwc3_plat_complete NULL
-#define dwc3_plat_prepare NULL
-#endif /* CONFIG_PM_SLEEP */
-
-static const struct dev_pm_ops dwc3_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dwc3_plat_suspend, dwc3_plat_resume)
-	.complete = dwc3_plat_complete,
-	.prepare = dwc3_plat_prepare,
-	/*
-	 * Runtime suspend halts the controller on disconnection. It relies on
-	 * platforms with custom connection notification to start the controller
-	 * again.
-	 */
-	SET_RUNTIME_PM_OPS(dwc3_plat_runtime_suspend, dwc3_plat_runtime_resume,
-			   dwc3_plat_runtime_idle)
-};
-
-#ifdef CONFIG_OF
-static const struct of_device_id of_dwc3_match[] = {
-	{
-		.compatible = "snps,dwc3"
-	},
-	{
-		.compatible = "synopsys,dwc3"
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, of_dwc3_match);
 #endif
 
-#ifdef CONFIG_ACPI
-
-#define ACPI_ID_INTEL_BSW	"808622B7"
-
-static const struct acpi_device_id dwc3_acpi_match[] = {
-	{ ACPI_ID_INTEL_BSW, 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
-#endif
-
-static struct platform_driver dwc3_driver = {
-	.probe		= dwc3_probe,
-	.remove		= dwc3_remove,
-	.driver		= {
-		.name	= "dwc3",
-		.of_match_table	= of_match_ptr(of_dwc3_match),
-		.acpi_match_table = ACPI_PTR(dwc3_acpi_match),
-		.pm	= &dwc3_dev_pm_ops,
-	},
-};
-
-module_platform_driver(dwc3_driver);
-
-MODULE_ALIAS("platform:dwc3");
-MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d5b985fa12f4..1b9fca02b4cf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -11,27 +11,13 @@
 #ifndef __DRIVERS_USB_DWC3_CORE_H
 #define __DRIVERS_USB_DWC3_CORE_H
 
-#include <linux/device.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
 #include <linux/ioport.h>
-#include <linux/list.h>
 #include <linux/bitops.h>
-#include <linux/dma-mapping.h>
-#include <linux/mm.h>
-#include <linux/debugfs.h>
-#include <linux/wait.h>
-#include <linux/workqueue.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
-#include <linux/usb/role.h>
-#include <linux/ulpi/interface.h>
-
-#include <linux/phy/phy.h>
-
-#include <linux/power_supply.h>
+#include <linux/usb/phy.h>
 
 /*
  * DWC3 Multiport controllers support up to 15 High-Speed PHYs
@@ -418,6 +404,7 @@
 /* Global User Control Register*/
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
 #define DWC3_GUCTL_REFCLKPER_SEL		22
+#define DWC3_GUCTL_HSTINAUTORETRY		BIT(14)
 
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
@@ -744,7 +731,6 @@ struct dwc3_event_buffer {
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
-	struct delayed_work	nostream_work;
 	struct list_head	cancelled_list;
 	struct list_head	pending_list;
 	struct list_head	started_list;
@@ -1177,7 +1163,6 @@ struct dwc3 {
 	dma_addr_t		ep0_trb_addr;
 	dma_addr_t		bounce_addr;
 	struct dwc3_request	ep0_usb_req;
-	struct completion	ep0_in_setup;
 
 	/* device lock */
 	spinlock_t		lock;
@@ -1185,8 +1170,11 @@ struct dwc3 {
 	/* mode switching lock */
 	struct mutex		mutex;
 
+#if defined(__UBOOT__) && CONFIG_IS_ENABLED(DM_USB)
+	struct udevice		*dev;
+#else
 	struct device		*dev;
-	struct device		*sysdev;
+#endif
 
 	struct platform_device	*xhci;
 	struct resource		xhci_resources[DWC3_XHCI_RESOURCES_NUM];
@@ -1194,7 +1182,7 @@ struct dwc3 {
 	struct dwc3_event_buffer *ev_buf;
 	struct dwc3_ep		*eps[DWC3_ENDPOINTS_NUM];
 
-	struct usb_gadget	*gadget;
+	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
 
 	struct clk		*bus_clk;
@@ -1231,9 +1219,9 @@ struct dwc3 {
 	struct usb_role_switch	*role_sw;
 	enum usb_dr_mode	role_switch_default_mode;
 
-	struct power_supply	*usb_psy;
-
 	u32			fladj;
+	u8			incrx_mode;
+	u32			incrx_size;
 	u32			ref_clk_per;
 	u32			irq_gadget;
 	u32			otg_irq;
@@ -1315,6 +1303,8 @@ struct dwc3 {
 
 	u8			num_eps;
 
+	void			*mem;
+
 	struct dwc3_hwparams	hwparams;
 	struct debugfs_regset32	*regset;
 
@@ -1400,6 +1390,9 @@ struct dwc3 {
 	struct dentry		*debug_root;
 	u32			gsbuscfg0_reqinfo;
 	u32			wakeup_pending_funcs;
+
+	int			index;
+	struct list_head	list;
 };
 
 #define INCRX_BURST_MODE 0
@@ -1565,8 +1558,10 @@ struct dwc3_gadget_ep_cmd_params {
 
 /* prototypes */
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
-void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
+void dwc3_of_parse(struct dwc3 *dwc);
+int dwc3_init(struct dwc3 *dwc);
+void dwc3_remove(struct dwc3 *dwc);
 
 #define DWC3_IP_IS(_ip)							\
 	(dwc->ip == _ip##_IP)
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 9db8f3ca493d..99519602eb2c 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -1,129 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * dwc3-am62.c - TI specific Glue layer for AM62 DWC3 USB Controller
- *
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com
+ * TI AM62 specific glue layer for DWC3
  */
 
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/syscon.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/pm_runtime.h>
-#include <linux/clk.h>
-#include <linux/regmap.h>
-#include <linux/pinctrl/consumer.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
 
-#include "core.h"
+#include "dwc3-generic.h"
 
-/* USB WRAPPER register offsets */
-#define USBSS_PID			0x0
-#define USBSS_OVERCURRENT_CTRL		0x4
-#define USBSS_PHY_CONFIG		0x8
-#define USBSS_PHY_TEST			0xc
-#define USBSS_CORE_STAT			0x14
-#define USBSS_HOST_VBUS_CTRL		0x18
 #define USBSS_MODE_CONTROL		0x1c
-#define USBSS_WAKEUP_CONFIG		0x30
-#define USBSS_WAKEUP_STAT		0x34
-#define USBSS_OVERRIDE_CONFIG		0x38
-#define USBSS_IRQ_MISC_STATUS_RAW	0x430
-#define USBSS_IRQ_MISC_STATUS		0x434
-#define USBSS_IRQ_MISC_ENABLE_SET	0x438
-#define USBSS_IRQ_MISC_ENABLE_CLR	0x43c
-#define USBSS_IRQ_MISC_EOI		0x440
-#define USBSS_INTR_TEST			0x490
-#define USBSS_VBUS_FILTER		0x614
-#define USBSS_VBUS_STAT			0x618
-#define USBSS_DEBUG_CFG			0x708
-#define USBSS_DEBUG_DATA		0x70c
-#define USBSS_HOST_HUB_CTRL		0x714
-
-/* PHY CONFIG register bits */
+#define USBSS_PHY_CONFIG		0x8
 #define USBSS_PHY_VBUS_SEL_MASK		GENMASK(2, 1)
 #define USBSS_PHY_VBUS_SEL_SHIFT	1
-#define USBSS_PHY_LANE_REVERSE		BIT(0)
-
-/* CORE STAT register bits */
-#define USBSS_CORE_OPERATIONAL_MODE_MASK	GENMASK(13, 12)
-#define USBSS_CORE_OPERATIONAL_MODE_SHIFT	12
-
-/* MODE CONTROL register bits */
 #define USBSS_MODE_VALID	BIT(0)
-
-/* WAKEUP CONFIG register bits */
-#define USBSS_WAKEUP_CFG_OVERCURRENT_EN	BIT(3)
-#define USBSS_WAKEUP_CFG_LINESTATE_EN	BIT(2)
-#define USBSS_WAKEUP_CFG_SESSVALID_EN	BIT(1)
-#define USBSS_WAKEUP_CFG_VBUSVALID_EN	BIT(0)
-
-#define USBSS_WAKEUP_CFG_ALL	(USBSS_WAKEUP_CFG_VBUSVALID_EN | \
-				 USBSS_WAKEUP_CFG_SESSVALID_EN | \
-				 USBSS_WAKEUP_CFG_LINESTATE_EN | \
-				 USBSS_WAKEUP_CFG_OVERCURRENT_EN)
-
-#define USBSS_WAKEUP_CFG_NONE	0
-
-/* WAKEUP STAT register bits */
-#define USBSS_WAKEUP_STAT_OVERCURRENT	BIT(4)
-#define USBSS_WAKEUP_STAT_LINESTATE	BIT(3)
-#define USBSS_WAKEUP_STAT_SESSVALID	BIT(2)
-#define USBSS_WAKEUP_STAT_VBUSVALID	BIT(1)
-#define USBSS_WAKEUP_STAT_CLR		BIT(0)
-
-/* IRQ_MISC_STATUS_RAW register bits */
-#define USBSS_IRQ_MISC_RAW_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_RAW_SESSVALID	BIT(20)
-
-/* IRQ_MISC_STATUS register bits */
-#define USBSS_IRQ_MISC_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_SESSVALID	BIT(20)
-
-/* IRQ_MISC_ENABLE_SET register bits */
-#define USBSS_IRQ_MISC_ENABLE_SET_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_ENABLE_SET_SESSVALID	BIT(20)
-
-/* IRQ_MISC_ENABLE_CLR register bits */
-#define USBSS_IRQ_MISC_ENABLE_CLR_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_ENABLE_CLR_SESSVALID	BIT(20)
-
-/* IRQ_MISC_EOI register bits */
-#define USBSS_IRQ_MISC_EOI_VECTOR	BIT(0)
-
-/* VBUS_STAT register bits */
-#define USBSS_VBUS_STAT_SESSVALID	BIT(2)
-#define USBSS_VBUS_STAT_VBUSVALID	BIT(0)
-
-/* USB_PHY_CTRL register bits in CTRL_MMR */
-#define PHY_CORE_VOLTAGE_MASK	BIT(31)
 #define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
-
-/* USB PHY2 register offsets */
-#define	USB_PHY_PLL_REG12		0x130
-#define	USB_PHY_PLL_LDO_REF_EN		BIT(5)
-#define	USB_PHY_PLL_LDO_REF_EN_EN	BIT(4)
-
-#define DWC3_AM62_AUTOSUSPEND_DELAY	100
-
-#define USBSS_DEBUG_CFG_OFF		0x0
-#define USBSS_DEBUG_CFG_DISABLED	0x7
-
-struct dwc3_am62 {
-	struct device *dev;
-	void __iomem *usbss;
-	struct clk *usb2_refclk;
-	int rate_code;
-	struct regmap *syscon;
-	unsigned int offset;
-	unsigned int vbus_divider;
-	u32 wakeup_stat;
-	void __iomem *phy_regs;
-};
-
-static const int dwc3_ti_rate_table[] = {	/* in KHZ */
+static const int dwc3_ti_am62_rate_table[] = {	/* in KHZ */
 	9600,
 	10000,
 	12000,
@@ -139,277 +33,93 @@ static const int dwc3_ti_rate_table[] = {	/* in KHZ */
 	52000,
 };
 
-static inline u32 dwc3_ti_readl(struct dwc3_am62 *am62, u32 offset)
+static void dwc3_ti_am62_glue_configure(struct udevice *dev, int index,
+					enum usb_dr_mode mode)
 {
-	return readl((am62->usbss) + offset);
-}
-
-static inline void dwc3_ti_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
-{
-	writel(value, (am62->usbss) + offset);
-}
-
-static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
-{
-	struct device *dev = am62->dev;
-	struct device_node *node = dev->of_node;
-	struct regmap *syscon;
-	int ret;
-
-	syscon = syscon_regmap_lookup_by_phandle_args(node, "ti,syscon-phy-pll-refclk",
-						      1, &am62->offset);
-	if (IS_ERR(syscon)) {
-		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
-		return PTR_ERR(syscon);
-	}
-
-	am62->syscon = syscon;
-
-	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
-	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_CORE_VOLTAGE_MASK, 0);
-	if (ret) {
-		dev_err(dev, "failed to set phy core voltage\n");
-		return ret;
-	}
-
-	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_PLL_REFCLK_MASK, am62->rate_code);
-	if (ret) {
-		dev_err(dev, "failed to set phy pll reference clock rate\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int dwc3_ti_init(struct dwc3_am62 *am62)
-{
-	int ret;
-	u32 reg;
-
-	/* Read the syscon property and set the rate code */
-	ret = phy_syscon_pll_refclk(am62);
-	if (ret)
-		return ret;
-
-	/* Workaround Errata i2409 */
-	if (am62->phy_regs) {
-		reg = readl(am62->phy_regs + USB_PHY_PLL_REG12);
-		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
-		writel(reg, am62->phy_regs + USB_PHY_PLL_REG12);
-	}
-
-	/* VBUS divider select */
-	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
-	if (am62->vbus_divider)
-		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
-
-	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
-
-	clk_prepare_enable(am62->usb2_refclk);
-
-	/* Set mode valid bit to indicate role is valid */
-	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
-	reg |= USBSS_MODE_VALID;
-	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
-
-	return 0;
-}
-
-static int dwc3_ti_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = pdev->dev.of_node;
-	struct dwc3_am62 *am62;
+	struct clk usb2_refclk;
+	int rate_code, i, ret;
 	unsigned long rate;
-	int i, ret;
+	u32 reg;
+	void *usbss;
+	bool vbus_divider;
+	struct regmap *syscon;
+	struct ofnode_phandle_args args;
 
-	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
-	if (!am62)
-		return -ENOMEM;
-
-	am62->dev = dev;
-	platform_set_drvdata(pdev, am62);
-
-	am62->usbss = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(am62->usbss)) {
+	usbss = dev_remap_addr_index(dev, 0);
+	if (IS_ERR(usbss)) {
 		dev_err(dev, "can't map IOMEM resource\n");
-		return PTR_ERR(am62->usbss);
+		return;
 	}
 
-	am62->usb2_refclk = devm_clk_get(dev, "ref");
-	if (IS_ERR(am62->usb2_refclk)) {
+	ret = clk_get_by_name(dev, "ref", &usb2_refclk);
+	if (ret) {
 		dev_err(dev, "can't get usb2_refclk\n");
-		return PTR_ERR(am62->usb2_refclk);
+		return;
 	}
 
 	/* Calculate the rate code */
-	rate = clk_get_rate(am62->usb2_refclk);
-	rate /= 1000;	// To KHz
-	for (i = 0; i < ARRAY_SIZE(dwc3_ti_rate_table); i++) {
-		if (dwc3_ti_rate_table[i] == rate)
+	rate = clk_get_rate(&usb2_refclk);
+	rate /= 1000;	/* To KHz */
+	for (i = 0; i < ARRAY_SIZE(dwc3_ti_am62_rate_table); i++) {
+		if (dwc3_ti_am62_rate_table[i] == rate)
 			break;
 	}
 
-	if (i == ARRAY_SIZE(dwc3_ti_rate_table)) {
+	if (i == ARRAY_SIZE(dwc3_ti_am62_rate_table)) {
 		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
-		return -EINVAL;
+		return;
 	}
 
-	am62->rate_code = i;
+	rate_code = i;
 
-	am62->phy_regs = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(am62->phy_regs)) {
-		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
-		am62->phy_regs = NULL;
+	/* Read the syscon property */
+	syscon = syscon_regmap_lookup_by_phandle(dev, "ti,syscon-phy-pll-refclk");
+	if (IS_ERR(syscon)) {
+		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
+		return;
 	}
 
-	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
-
-	ret = dwc3_ti_init(am62);
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "ti,syscon-phy-pll-refclk", NULL, 1,
+					     0, &args);
 	if (ret)
-		return ret;
+		return;
 
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	/*
-	 * Don't ignore its dependencies with its children
-	 */
-	pm_suspend_ignore_children(dev, false);
-	pm_runtime_get_noresume(dev);
-
-	ret = of_platform_populate(node, NULL, NULL, dev);
+	/* Program PHY PLL refclk by reading syscon property */
+	ret = regmap_update_bits(syscon, args.args[0], PHY_PLL_REFCLK_MASK, rate_code);
 	if (ret) {
-		dev_err(dev, "failed to create dwc3 core: %d\n", ret);
-		goto err_pm_disable;
+		dev_err(dev, "failed to set phy pll reference clock rate\n");
+		return;
 	}
 
-	/* Device has capability to wakeup system from sleep */
-	device_set_wakeup_capable(dev, true);
-	ret = device_wakeup_enable(dev);
-	if (ret)
-		dev_err(dev, "couldn't enable device as a wakeup source: %d\n", ret);
+	/* VBUS divider select */
+	reg = readl(usbss + USBSS_PHY_CONFIG);
+	vbus_divider = dev_read_bool(dev, "ti,vbus-divider");
+	if (vbus_divider)
+		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
 
-	/* Setting up autosuspend */
-	pm_runtime_set_autosuspend_delay(dev, DWC3_AM62_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-	return 0;
+	writel(reg, usbss + USBSS_PHY_CONFIG);
 
-err_pm_disable:
-	clk_disable_unprepare(am62->usb2_refclk);
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-	return ret;
+	/* Set mode valid */
+	reg = readl(usbss + USBSS_MODE_CONTROL);
+	reg |= USBSS_MODE_VALID;
+	writel(reg, usbss + USBSS_MODE_CONTROL);
 }
 
-static void dwc3_ti_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
-	u32 reg;
-
-	pm_runtime_get_sync(dev);
-	device_init_wakeup(dev, false);
-	of_platform_depopulate(dev);
-
-	/* Clear mode valid bit */
-	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
-	reg &= ~USBSS_MODE_VALID;
-	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
-
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-	pm_runtime_set_suspended(dev);
-}
-
-#ifdef CONFIG_PM
-static int dwc3_ti_suspend_common(struct device *dev)
-{
-	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
-	u32 reg, current_prtcap_dir;
-
-	if (device_may_wakeup(dev)) {
-		reg = dwc3_ti_readl(am62, USBSS_CORE_STAT);
-		current_prtcap_dir = (reg & USBSS_CORE_OPERATIONAL_MODE_MASK)
-				     >> USBSS_CORE_OPERATIONAL_MODE_SHIFT;
-		/* Set wakeup config enable bits */
-		reg = dwc3_ti_readl(am62, USBSS_WAKEUP_CONFIG);
-		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
-			reg = USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
-		} else {
-			reg = USBSS_WAKEUP_CFG_VBUSVALID_EN | USBSS_WAKEUP_CFG_SESSVALID_EN;
-			/*
-			 * Enable LINESTATE wake up only if connected to bus
-			 * and in U2/L3 state else it causes spurious wake-up.
-			 */
-		}
-		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, reg);
-		/* clear wakeup status so we know what caused the wake up */
-		dwc3_ti_writel(am62, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
-	}
-
-	/* just to track if module resets on suspend */
-	dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_DISABLED);
-
-	clk_disable_unprepare(am62->usb2_refclk);
-
-	return 0;
-}
-
-static int dwc3_ti_resume_common(struct device *dev)
-{
-	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
-	u32 reg;
-
-	reg = dwc3_ti_readl(am62, USBSS_DEBUG_CFG);
-	if (reg != USBSS_DEBUG_CFG_DISABLED) {
-		/* lost power/context */
-		dwc3_ti_init(am62);
-	} else {
-		dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_OFF);
-		clk_prepare_enable(am62->usb2_refclk);
-	}
-
-	if (device_may_wakeup(dev)) {
-		/* Clear wakeup config enable bits */
-		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
-	}
-
-	reg = dwc3_ti_readl(am62, USBSS_WAKEUP_STAT);
-	am62->wakeup_stat = reg;
-
-	return 0;
-}
-
-static UNIVERSAL_DEV_PM_OPS(dwc3_ti_pm_ops, dwc3_ti_suspend_common,
-			    dwc3_ti_resume_common, NULL);
-
-#define DEV_PM_OPS	(&dwc3_ti_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM */
-
-static const struct of_device_id dwc3_ti_of_match[] = {
-	{ .compatible = "ti,am62-usb"},
-	{},
+struct dwc3_glue_ops ti_am62_ops = {
+	.glue_configure = dwc3_ti_am62_glue_configure,
 };
-MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
 
-static struct platform_driver dwc3_ti_driver = {
-	.probe		= dwc3_ti_probe,
-	.remove		= dwc3_ti_remove,
-	.driver		= {
-		.name	= "dwc3-am62",
-		.pm	= DEV_PM_OPS,
-		.of_match_table = dwc3_ti_of_match,
-	},
+static const struct udevice_id dwc3_am62_match[] = {
+	{ .compatible = "ti,am62-usb", .data = (ulong)&ti_am62_ops },
+	{ /* sentinel */ }
 };
 
-module_platform_driver(dwc3_ti_driver);
-
-MODULE_ALIAS("platform:dwc3-am62");
-MODULE_AUTHOR("Aswath Govindraju <a-govindraju@ti.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("DesignWare USB3 TI Glue Layer");
+U_BOOT_DRIVER(dwc3_am62_wrapper) = {
+	.name	= "dwc3-am62",
+	.id	= UCLASS_SIMPLE_BUS,
+	.of_match = dwc3_am62_match,
+	.bind = dwc3_glue_bind,
+	.probe = dwc3_glue_probe,
+	.remove = dwc3_glue_remove,
+	.plat_auto	= sizeof(struct dwc3_glue_data),
+};
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 4b219c35eb35..9de8ecff3adc 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -25,8 +25,6 @@
 #include <linux/usb/otg.h>
 #include <linux/compat.h>
 
-#include "linux-compat.h"
-
 /*
  * All these registers belong to OMAP's Wrapper around the
  * DesignWare USB3 Core.
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 666ac432f52d..0a4f69cbc28a 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0
 /*
  * ep0.c - DesignWare USB3 DRD Controller Endpoint 0 Handling
  *
@@ -8,22 +7,19 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
+#include <cpu_func.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bug.h>
+#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/list.h>
-#include <linux/dma-mapping.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
 
 #include "core.h"
-#include "debug.h"
 #include "gadget.h"
 #include "io.h"
 
@@ -58,8 +54,6 @@ static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
 	else
 		trb->ctrl |= (DWC3_TRB_CTRL_IOC
 				| DWC3_TRB_CTRL_LST);
-
-	trace_dwc3_prepare_trb(dep, trb);
 }
 
 static int dwc3_ep0_start_trans(struct dwc3_ep *dep)
@@ -112,7 +106,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 		direction = !!(dep->flags & DWC3_EP0_DIR_IN);
 
 		if (dwc->ep0state != EP0_DATA_PHASE) {
-			dev_WARN(dwc->dev, "Unexpected pending request\n");
+			dev_warn(dwc->dev, "Unexpected pending request\n");
 			return 0;
 		}
 
@@ -133,7 +127,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 
 		direction = !dwc->ep0_expect_in;
 		dwc->delayed_status = false;
-		usb_gadget_set_state(dwc->gadget, USB_STATE_CONFIGURED);
+		usb_gadget_set_state(&dwc->gadget, USB_STATE_CONFIGURED);
 
 		if (dwc->ep0state == EP0_STATUS_PHASE)
 			__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
@@ -264,16 +258,8 @@ int __dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 
 int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 {
-	struct dwc3_ep			*dep = to_dwc3_ep(ep);
-	struct dwc3			*dwc = dep->dwc;
-	unsigned long			flags;
-	int				ret;
 
-	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_ep0_set_halt(ep, value);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return ret;
+	return __dwc3_gadget_ep0_set_halt(ep, value);
 }
 
 void dwc3_ep0_out_start(struct dwc3 *dwc)
@@ -282,8 +268,6 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	int				ret;
 	int                             i;
 
-	complete(&dwc->ep0_in_setup);
-
 	dep = dwc->eps[0];
 	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
 			DWC3_TRBCTL_CONTROL_SETUP, false);
@@ -354,7 +338,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		/*
 		 * LTM will be set once we know how to set this in HW.
 		 */
-		usb_status |= dwc->gadget->is_selfpowered;
+		usb_status |= dwc->gadget.is_selfpowered;
 
 		if ((dwc->speed == DWC3_DSTS_SUPERSPEED) ||
 		    (dwc->speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
@@ -364,7 +348,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 			if (reg & DWC3_DCTL_INITU2ENA)
 				usb_status |= 1 << USB_DEV_STAT_U2_ENABLED;
 		} else {
-			usb_status |= dwc->gadget->wakeup_armed <<
+			usb_status |= dwc->gadget.wakeup_armed <<
 					USB_DEVICE_REMOTE_WAKEUP;
 		}
 
@@ -482,12 +466,12 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 
 	wValue = le16_to_cpu(ctrl->wValue);
 	wIndex = le16_to_cpu(ctrl->wIndex);
-	state = dwc->gadget->state;
+	state = dwc->gadget.state;
 
 	switch (wValue) {
 	case USB_DEVICE_REMOTE_WAKEUP:
 		if (dwc->wakeup_configured)
-			dwc->gadget->wakeup_armed = set;
+			dwc->gadget.wakeup_armed = set;
 		else
 			ret = -EINVAL;
 		break;
@@ -594,7 +578,7 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 
 static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	enum usb_device_state state = dwc->gadget->state;
+	enum usb_device_state state = dwc->gadget.state;
 	u32 addr;
 	u32 reg;
 
@@ -615,9 +599,9 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
 	if (addr)
-		usb_gadget_set_state(dwc->gadget, USB_STATE_ADDRESS);
+		usb_gadget_set_state(&dwc->gadget, USB_STATE_ADDRESS);
 	else
-		usb_gadget_set_state(dwc->gadget, USB_STATE_DEFAULT);
+		usb_gadget_set_state(&dwc->gadget, USB_STATE_DEFAULT);
 
 	return 0;
 }
@@ -628,7 +612,7 @@ static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 	if (dwc->async_callbacks) {
 		spin_unlock(&dwc->lock);
-		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
+		ret = dwc->gadget_driver->setup(&dwc->gadget, ctrl);
 		spin_lock(&dwc->lock);
 	}
 	return ret;
@@ -636,7 +620,7 @@ static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	enum usb_device_state state = dwc->gadget->state;
+	enum usb_device_state state = dwc->gadget.state;
 	u32 cfg;
 	int ret;
 	u32 reg;
@@ -662,7 +646,7 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			 * to change the state on the next usb_ep_queue()
 			 */
 			if (ret == 0)
-				usb_gadget_set_state(dwc->gadget,
+				usb_gadget_set_state(&dwc->gadget,
 						USB_STATE_CONFIGURED);
 
 			/*
@@ -681,7 +665,7 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	case USB_STATE_CONFIGURED:
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		if (!cfg && !ret)
-			usb_gadget_set_state(dwc->gadget,
+			usb_gadget_set_state(&dwc->gadget,
 					USB_STATE_ADDRESS);
 		break;
 	default:
@@ -737,7 +721,7 @@ static void dwc3_ep0_set_sel_cmpl(struct usb_ep *ep, struct usb_request *req)
 static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
 	struct dwc3_ep	*dep;
-	enum usb_device_state state = dwc->gadget->state;
+	enum usb_device_state state = dwc->gadget.state;
 	u16		wLength;
 
 	if (state == USB_STATE_DEFAULT)
@@ -781,7 +765,7 @@ static int dwc3_ep0_set_isoch_delay(struct dwc3 *dwc, struct usb_ctrlrequest *ct
 	if (wIndex || wLength)
 		return -EINVAL;
 
-	dwc->gadget->isoch_delay = wValue;
+	dwc->gadget.isoch_delay = wValue;
 
 	return 0;
 }
@@ -830,8 +814,6 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
 		goto out;
 
-	trace_dwc3_ctrl_req(ctrl);
-
 	len = le16_to_cpu(ctrl->wLength);
 	if (!len) {
 		dwc->three_stage_setup = false;
@@ -873,7 +855,6 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 	dwc->ep0_next_event = DWC3_EP0_NRDY_STATUS;
 	trb = dwc->ep0_trb;
-	trace_dwc3_complete_trb(ep0, trb);
 
 	r = next_request(&ep0->pending_list);
 	if (!r)
@@ -898,7 +879,6 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	     ur->length && ur->zero) || dwc->ep0_bounced) {
 		trb++;
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
-		trace_dwc3_complete_trb(ep0, trb);
 
 		if (r->direction)
 			dwc->eps[1]->trb_enqueue = 0;
@@ -925,8 +905,6 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 	dep = dwc->eps[0];
 	trb = dwc->ep0_trb;
 
-	trace_dwc3_complete_trb(dep, trb);
-
 	if (!list_empty(&dep->pending_list)) {
 		r = next_request(&dep->pending_list);
 
@@ -998,21 +976,21 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			&& (dep->number == 0)) {
 		u32	maxpacket;
 		u32	rem;
+		struct usb_request *ureq = &req->request;
+		enum dma_data_direction dir = req->direction ? DMA_TO_DEVICE
+							     : DMA_FROM_DEVICE;
 
-		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
-				&req->request, dep->number);
-		if (ret)
+		ureq->dma = dma_map_single(ureq->buf, ureq->length, dir);
+		if (!ureq->dma)
 			return;
 
 		maxpacket = dep->endpoint.maxpacket;
-		rem = req->request.length % maxpacket;
+		rem = ureq->length % maxpacket;
 		dwc->ep0_bounced = true;
 
 		/* prepare normal TRB */
-		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
-					 req->request.length,
-					 DWC3_TRBCTL_CONTROL_DATA,
-					 true);
+		dwc3_ep0_prepare_one_trb(dep, ureq->dma, ureq->length,
+					 DWC3_TRBCTL_CONTROL_DATA, true);
 
 		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
 
@@ -1024,17 +1002,17 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = dwc3_ep0_start_trans(dep);
 	} else if (IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
 		   req->request.length && req->request.zero) {
+		struct usb_request *ureq = &req->request;
+		enum dma_data_direction dir = req->direction ? DMA_TO_DEVICE
+							     : DMA_FROM_DEVICE;
 
-		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
-				&req->request, dep->number);
-		if (ret)
+		ureq->dma = dma_map_single(ureq->buf, ureq->length, dir);
+		if (!ureq->dma)
 			return;
 
 		/* prepare normal TRB */
-		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
-					 req->request.length,
-					 DWC3_TRBCTL_CONTROL_DATA,
-					 true);
+		dwc3_ep0_prepare_one_trb(dep, ureq->dma, ureq->length,
+					 DWC3_TRBCTL_CONTROL_DATA, true);
 
 		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
 
@@ -1047,14 +1025,16 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 false);
 		ret = dwc3_ep0_start_trans(dep);
 	} else {
-		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
-				&req->request, dep->number);
-		if (ret)
+		struct usb_request *ureq = &req->request;
+		enum dma_data_direction dir = req->direction ? DMA_TO_DEVICE
+							     : DMA_FROM_DEVICE;
+
+		ureq->dma = dma_map_single(ureq->buf, ureq->length, dir);
+		if (!ureq->dma)
 			return;
 
-		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
-				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
-				false);
+		dwc3_ep0_prepare_one_trb(dep, ureq->dma, ureq->length,
+					 DWC3_TRBCTL_CONTROL_DATA, false);
 
 		req->trb = &dwc->ep0_trb[dep->trb_enqueue];
 
@@ -1174,7 +1154,7 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 			 */
 			if (!list_empty(&dep->pending_list)) {
 				dwc->delayed_status = false;
-				usb_gadget_set_state(dwc->gadget,
+				usb_gadget_set_state(&dwc->gadget,
 						     USB_STATE_CONFIGURED);
 				dwc3_ep0_do_control_status(dwc, event);
 			}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 74968f93d4a3..7f76c2d1aed5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -8,14 +8,14 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
-#include <linux/kernel.h>
+#include <cpu_func.h>
+#include <log.h>
+#include <malloc.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/bug.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/list.h>
 #include <linux/dma-mapping.h>
 
@@ -27,6 +27,8 @@
 #include "gadget.h"
 #include "io.h"
 
+#define usleep_range(a, b) udelay((b))
+
 #define DWC3_ALIGN_FRAME(d, n)	(((d)->frame_number + ((d)->interval * (n))) \
 					& ~((d)->interval - 1))
 
@@ -193,24 +195,21 @@ static void dwc3_ep_inc_deq(struct dwc3_ep *dep)
 static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 		struct dwc3_request *req, int status)
 {
-	struct dwc3			*dwc = dep->dwc;
+	struct usb_request *ureq = &req->request;
+	enum dma_data_direction dir = req->direction ? DMA_TO_DEVICE :
+						       DMA_FROM_DEVICE;
 
 	list_del(&req->list);
 	req->remaining = 0;
 	req->num_trbs = 0;
 
-	if (req->request.status == -EINPROGRESS)
-		req->request.status = status;
+	if (ureq->status == -EINPROGRESS)
+		ureq->status = status;
 
 	if (req->trb)
-		usb_gadget_unmap_request_by_dev(dwc->sysdev,
-				&req->request, req->direction);
+		ureq->dma = dma_map_single(ureq->buf, ureq->length, dir);
 
 	req->trb = NULL;
-	trace_dwc3_gadget_giveback(req);
-
-	if (dep->number > 1)
-		pm_runtime_put(dwc->dev);
 }
 
 /**
@@ -226,8 +225,6 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status)
 {
-	struct dwc3			*dwc = dep->dwc;
-
 	dwc3_gadget_del_and_unmap_request(dep, req, status);
 	req->status = DWC3_REQUEST_STATUS_COMPLETED;
 
@@ -271,8 +268,6 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		status = -ETIMEDOUT;
 	}
 
-	trace_dwc3_gadget_generic_cmd(cmd, param, status);
-
 	return ret;
 }
 
@@ -324,7 +319,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	 *
 	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
 	 */
-	if (dwc->gadget->speed <= USB_SPEED_HIGH ||
+	if (dwc->gadget.speed <= USB_SPEED_HIGH ||
 	    DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
@@ -393,7 +388,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 				ret = 0;
 				break;
 			case DEPEVT_TRANSFER_NO_RESOURCE:
-				dev_WARN(dwc->dev, "No resource for %s\n",
+				dev_warn(dwc->dev, "No resource for %s\n",
 					 dep->name);
 				ret = -EINVAL;
 				break;
@@ -412,7 +407,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 				ret = -EAGAIN;
 				break;
 			default:
-				dev_WARN(dwc->dev, "UNKNOWN cmd status\n");
+				dev_warn(dwc->dev, "UNKNOWN cmd status\n");
 			}
 
 			break;
@@ -425,8 +420,6 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	}
 
 skip_status:
-	trace_dwc3_gadget_ep_cmd(dep, cmd, params, cmd_status);
-
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
 		if (ret == 0)
 			dep->flags |= DWC3_EP_TRANSFER_STARTED;
@@ -464,7 +457,7 @@ static int dwc3_send_clear_stall_ep_cmd(struct dwc3_ep *dep)
 	 */
 	if (dep->direction &&
 	    !DWC3_VER_IS_PRIOR(DWC3, 260A) &&
-	    (dwc->gadget->speed >= USB_SPEED_SUPER))
+	    (dwc->gadget.speed >= USB_SPEED_SUPER))
 		cmd |= DWC3_DEPCMD_CLEARPENDIN;
 
 	memset(&params, 0, sizeof(params));
@@ -482,14 +475,12 @@ static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
 
 static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 {
-	struct dwc3		*dwc = dep->dwc;
-
 	if (dep->trb_pool)
 		return 0;
 
-	dep->trb_pool = dma_alloc_coherent(dwc->sysdev,
-			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
-			&dep->trb_pool_dma, GFP_KERNEL);
+	dep->trb_pool = dma_alloc_coherent(sizeof(struct dwc3_trb) *
+					   DWC3_TRB_NUM,
+					   (unsigned long *)&dep->trb_pool_dma);
 	if (!dep->trb_pool) {
 		dev_err(dep->dwc->dev, "failed to allocate trb pool for %s\n",
 				dep->name);
@@ -501,10 +492,7 @@ static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 
 static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 {
-	struct dwc3		*dwc = dep->dwc;
-
-	dma_free_coherent(dwc->sysdev, sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
-			dep->trb_pool, dep->trb_pool_dma);
+	dma_free_coherent(dep->trb_pool);
 
 	dep->trb_pool = NULL;
 	dep->trb_pool_dma = 0;
@@ -589,7 +577,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 		| DWC3_DEPCFG_MAX_PACKET_SIZE(usb_endpoint_maxp(desc));
 
 	/* Burst size is only needed in SuperSpeed mode */
-	if (dwc->gadget->speed >= USB_SPEED_SUPER) {
+	if (dwc->gadget.speed >= USB_SPEED_SUPER) {
 		u32 burst = dep->endpoint.maxburst;
 
 		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst - 1);
@@ -644,7 +632,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 		bInterval_m1 = min_t(u8, desc->bInterval - 1, 13);
 
 		if (usb_endpoint_type(desc) == USB_ENDPOINT_XFER_INT &&
-		    dwc->gadget->speed == USB_SPEED_FULL)
+		    dwc->gadget.speed == USB_SPEED_FULL)
 			dep->interval = desc->bInterval;
 		else
 			dep->interval = 1 << (desc->bInterval - 1);
@@ -818,7 +806,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
 
-	switch (dwc->gadget->speed) {
+	switch (dwc->gadget.speed) {
 	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
@@ -1017,8 +1005,6 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	}
 
 out:
-	trace_dwc3_gadget_ep_enable(dep);
-
 	return 0;
 }
 
@@ -1068,8 +1054,6 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	u32			reg;
 	u32			mask;
 
-	trace_dwc3_gadget_ep_disable(dep);
-
 	/* make sure HW endpoint isn't stalled */
 	if (dep->flags & DWC3_EP_STALL)
 		__dwc3_gadget_ep_set_halt(dep, 0, false);
@@ -1137,9 +1121,7 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 	dep = to_dwc3_ep(ep);
 	dwc = dep->dwc;
 
-	if (dev_WARN_ONCE(dwc->dev, dep->flags & DWC3_EP_ENABLED,
-					"%s is already enabled\n",
-					dep->name))
+	if (dep->flags & DWC3_EP_ENABLED)
 		return 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
@@ -1164,9 +1146,7 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 	dep = to_dwc3_ep(ep);
 	dwc = dep->dwc;
 
-	if (dev_WARN_ONCE(dwc->dev, !(dep->flags & DWC3_EP_ENABLED),
-					"%s is already disabled\n",
-					dep->name))
+	if (!(dep->flags & DWC3_EP_ENABLED))
 		return 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
@@ -1191,8 +1171,6 @@ static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
 	req->dep	= dep;
 	req->status	= DWC3_REQUEST_STATUS_UNKNOWN;
 
-	trace_dwc3_alloc_request(req);
-
 	return &req->request;
 }
 
@@ -1201,7 +1179,6 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
 {
 	struct dwc3_request		*req = to_dwc3_request(request);
 
-	trace_dwc3_free_request(req);
 	kfree(req);
 }
 
@@ -1278,13 +1255,11 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	unsigned int		no_interrupt = req->request.no_interrupt;
 	unsigned int		is_last = req->request.is_last;
 	struct dwc3		*dwc = dep->dwc;
-	struct usb_gadget	*gadget = dwc->gadget;
+	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
 	if (use_bounce_buffer)
 		dma = dep->dwc->bounce_addr;
-	else if (req->request.num_sgs > 0)
-		dma = sg_dma_address(req->start_sg);
 	else
 		dma = req->request.dma;
 
@@ -1363,7 +1338,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		 * This is only possible with faulty memory because we
 		 * checked it already :)
 		 */
-		dev_WARN(dwc->dev, "Unknown endpoint type %d\n",
+		dev_warn(dwc->dev, "Unknown endpoint type %d\n",
 				usb_endpoint_type(dep->endpoint.desc));
 	}
 
@@ -1407,12 +1382,10 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	 * controller to observe the HWO bit set prematurely.
 	 * Add a write memory barrier to prevent CPU re-ordering.
 	 */
-	wmb();
+	// FIXME wmb();
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
 	dwc3_ep_inc_enq(dep);
-
-	trace_dwc3_prepare_trb(dep, trb);
 }
 
 static bool dwc3_needs_extra_trb(struct dwc3_ep *dep, struct dwc3_request *req)
@@ -1468,106 +1441,6 @@ static int dwc3_prepare_last_sg(struct dwc3_ep *dep,
 	return num_trbs;
 }
 
-static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
-		struct dwc3_request *req)
-{
-	struct scatterlist *sg = req->start_sg;
-	struct scatterlist *s;
-	int		i;
-	unsigned int length = req->request.length;
-	unsigned int remaining = req->num_pending_sgs;
-	unsigned int num_queued_sgs = req->request.num_mapped_sgs - remaining;
-	unsigned int num_trbs = req->num_trbs;
-	bool needs_extra_trb = dwc3_needs_extra_trb(dep, req);
-
-	/*
-	 * If we resume preparing the request, then get the remaining length of
-	 * the request and resume where we left off.
-	 */
-	for_each_sg(req->request.sg, s, num_queued_sgs, i)
-		length -= sg_dma_len(s);
-
-	for_each_sg(sg, s, remaining, i) {
-		unsigned int num_trbs_left = dwc3_calc_trbs_left(dep);
-		unsigned int trb_length;
-		bool must_interrupt = false;
-		bool last_sg = false;
-
-		trb_length = min_t(unsigned int, length, sg_dma_len(s));
-
-		length -= trb_length;
-
-		/*
-		 * IOMMU driver is coalescing the list of sgs which shares a
-		 * page boundary into one and giving it to USB driver. With
-		 * this the number of sgs mapped is not equal to the number of
-		 * sgs passed. So mark the chain bit to false if it isthe last
-		 * mapped sg.
-		 */
-		if ((i == remaining - 1) || !length)
-			last_sg = true;
-
-		if (!num_trbs_left)
-			break;
-
-		if (last_sg) {
-			if (!dwc3_prepare_last_sg(dep, req, trb_length, i))
-				break;
-		} else {
-			/*
-			 * Look ahead to check if we have enough TRBs for the
-			 * next SG entry. If not, set interrupt on this TRB to
-			 * resume preparing the next SG entry when more TRBs are
-			 * free.
-			 */
-			if (num_trbs_left == 1 || (needs_extra_trb &&
-					num_trbs_left <= 2 &&
-					sg_dma_len(sg_next(s)) >= length)) {
-				struct dwc3_request *r;
-
-				/* Check if previous requests already set IOC */
-				list_for_each_entry(r, &dep->started_list, list) {
-					if (r != req && !r->request.no_interrupt)
-						break;
-
-					if (r == req)
-						must_interrupt = true;
-				}
-			}
-
-			dwc3_prepare_one_trb(dep, req, trb_length, 1, i, false,
-					must_interrupt);
-		}
-
-		/*
-		 * There can be a situation where all sgs in sglist are not
-		 * queued because of insufficient trb number. To handle this
-		 * case, update start_sg to next sg to be queued, so that
-		 * we have free trbs we can continue queuing from where we
-		 * previously stopped
-		 */
-		if (!last_sg)
-			req->start_sg = sg_next(s);
-
-		req->num_pending_sgs--;
-
-		/*
-		 * The number of pending SG entries may not correspond to the
-		 * number of mapped SG entries. If all the data are queued, then
-		 * don't include unused SG entries.
-		 */
-		if (length == 0) {
-			req->num_pending_sgs = 0;
-			break;
-		}
-
-		if (must_interrupt)
-			break;
-	}
-
-	return req->num_trbs - num_trbs;
-}
-
 static int dwc3_prepare_trbs_linear(struct dwc3_ep *dep,
 		struct dwc3_request *req)
 {
@@ -1602,12 +1475,6 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 	 * break things.
 	 */
 	list_for_each_entry(req, &dep->started_list, list) {
-		if (req->num_pending_sgs > 0) {
-			ret = dwc3_prepare_trbs_sg(dep, req);
-			if (!ret || req->num_pending_sgs)
-				return ret;
-		}
-
 		if (!dwc3_calc_trbs_left(dep))
 			return ret;
 
@@ -1623,22 +1490,15 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 
 	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
 		struct dwc3	*dwc = dep->dwc;
+		struct usb_request *ureq = &req->request;
+		enum dma_data_direction dir = dep->direction ? DMA_TO_DEVICE
+							     : DMA_FROM_DEVICE;
 
-		ret = usb_gadget_map_request_by_dev(dwc->sysdev, &req->request,
-						    dep->direction);
-		if (ret)
-			return ret;
+		ureq->dma = dma_map_single(ureq->buf, ureq->length, dir);
+		if (!ureq->dma)
+			return -ENOMEM;
 
-		req->start_sg		= req->request.sg;
-		req->num_pending_sgs	= req->request.num_mapped_sgs;
-
-		if (req->num_pending_sgs > 0) {
-			ret = dwc3_prepare_trbs_sg(dep, req);
-			if (req->num_pending_sgs)
-				return ret;
-		} else {
-			ret = dwc3_prepare_trbs_linear(dep, req);
-		}
+		ret = dwc3_prepare_trbs_linear(dep, req);
 
 		if (!ret || !dwc3_calc_trbs_left(dep))
 			return ret;
@@ -1917,12 +1777,12 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 	if (!dwc->dis_start_transfer_quirk &&
 	    (DWC3_VER_IS_PRIOR(DWC31, 170A) ||
 	     DWC3_VER_TYPE_IS_WITHIN(DWC31, 170A, EA01, EA06))) {
-		if (dwc->gadget->speed <= USB_SPEED_HIGH && dep->direction)
+		if (dwc->gadget.speed <= USB_SPEED_HIGH && dep->direction)
 			return dwc3_gadget_start_isoc_quirk(dep);
 	}
 
 	if (desc->bInterval <= 14 &&
-	    dwc->gadget->speed >= USB_SPEED_HIGH) {
+	    dwc->gadget.speed >= USB_SPEED_HIGH) {
 		u32 frame = __dwc3_gadget_get_frame(dwc);
 		bool rollover = frame <
 				(dep->frame_number & DWC3_FRNUMBER_MASK);
@@ -1986,13 +1846,9 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 				dep->name, &req->request))
 		return -EINVAL;
 
-	pm_runtime_get(dwc->dev);
-
 	req->request.actual	= 0;
 	req->request.status	= -EINPROGRESS;
 
-	trace_dwc3_ep_queue(req);
-
 	list_add_tail(&req->list, &dep->pending_list);
 	req->status = DWC3_REQUEST_STATUS_QUEUED;
 
@@ -2038,17 +1894,8 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 {
 	struct dwc3_request		*req = to_dwc3_request(request);
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
-	struct dwc3			*dwc = dep->dwc;
 
-	unsigned long			flags;
-
-	int				ret;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_ep_queue(dep, req);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return ret;
+	return __dwc3_gadget_ep_queue(dep, req);
 }
 
 static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *req)
@@ -2124,8 +1971,6 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 	unsigned long			flags;
 	int				ret = 0;
 
-	trace_dwc3_ep_dequeue(req);
-
 	spin_lock_irqsave(&dwc->lock, flags);
 
 	list_for_each_entry(r, &dep->cancelled_list, list) {
@@ -2270,34 +2115,21 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 static int dwc3_gadget_ep_set_halt(struct usb_ep *ep, int value)
 {
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
-	struct dwc3			*dwc = dep->dwc;
 
-	unsigned long			flags;
-
-	int				ret;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_ep_set_halt(dep, value, false);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return ret;
+	return __dwc3_gadget_ep_set_halt(dep, value, false);
 }
 
 static int dwc3_gadget_ep_set_wedge(struct usb_ep *ep)
 {
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
-	struct dwc3			*dwc = dep->dwc;
-	unsigned long			flags;
 	int				ret;
 
-	spin_lock_irqsave(&dwc->lock, flags);
 	dep->flags |= DWC3_EP_WEDGE;
 
 	if (dep->number == 0 || dep->number == 1)
 		ret = __dwc3_gadget_ep0_set_halt(ep, 1);
 	else
 		ret = __dwc3_gadget_ep_set_halt(dep, 1, false);
-	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
 }
@@ -2422,7 +2254,7 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dwc->gadget->wakeup_armed) {
+	if (!dwc->gadget.wakeup_armed) {
 		dev_err(dwc->dev, "not armed for remote wakeup\n");
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return -EINVAL;
@@ -2436,63 +2268,10 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 
 static void dwc3_resume_gadget(struct dwc3 *dwc);
 
-static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
-{
-	struct  dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
-	int			ret;
-	int			link_state;
-
-	if (!dwc->wakeup_configured) {
-		dev_err(dwc->dev, "remote wakeup not configured\n");
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	/*
-	 * If the link is in U3, signal for remote wakeup and wait for the
-	 * link to transition to U0 before sending device notification.
-	 */
-	link_state = dwc3_gadget_get_link_state(dwc);
-	if (link_state == DWC3_LINK_STATE_U3) {
-		dwc->wakeup_pending_funcs |= BIT(intf_id);
-		ret = __dwc3_gadget_wakeup(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return ret;
-	}
-
-	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
-					       DWC3_DGCMDPAR_DN_FUNC_WAKE |
-					       DWC3_DGCMDPAR_INTF_SEL(intf_id));
-	if (ret)
-		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return ret;
-}
-
-static int dwc3_gadget_set_remote_wakeup(struct usb_gadget *g, int set)
-{
-	struct dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	dwc->wakeup_configured = !!set;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return 0;
-}
-
 static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 		int is_selfpowered)
 {
-	struct dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
 	g->is_selfpowered = !!is_selfpowered;
-	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
 }
@@ -2611,9 +2390,6 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 	u32			timeout = 2000;
 	u32			saved_config = 0;
 
-	if (pm_runtime_suspended(dwc->dev))
-		return 0;
-
 	/*
 	 * When operating in USB 2.0 speeds (HS/FS), ensure that
 	 * GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY are cleared before starting
@@ -2721,18 +2497,8 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * stall the transfer, and move back to the SETUP phase, so that any
 	 * pending endxfers can be executed.
 	 */
-	if (dwc->ep0state != EP0_SETUP_PHASE) {
-		reinit_completion(&dwc->ep0_in_setup);
-
-		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
-				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
-		if (ret == 0) {
-			dev_warn(dwc->dev, "wait for SETUP phase timed out\n");
-			spin_lock_irqsave(&dwc->lock, flags);
-			dwc3_ep0_reset_state(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
-		}
-	}
+	if (dwc->ep0state != EP0_SETUP_PHASE)
+		dwc3_ep0_reset_state(dwc);
 
 	/*
 	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
@@ -2753,7 +2519,7 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
+	usb_gadget_set_state(&dwc->gadget, USB_STATE_NOTATTACHED);
 
 	return ret;
 }
@@ -2786,44 +2552,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	dwc->softconnect = is_on;
 
-	/*
-	 * Avoid issuing a runtime resume if the device is already in the
-	 * suspended state during gadget disconnect.  DWC3 gadget was already
-	 * halted/stopped during runtime suspend.
-	 */
-	if (!is_on) {
-		pm_runtime_barrier(dwc->dev);
-		if (pm_runtime_suspended(dwc->dev))
-			return 0;
-	}
-
-	/*
-	 * Check the return value for successful resume, or error.  For a
-	 * successful resume, the DWC3 runtime PM resume routine will handle
-	 * the run stop sequence, so avoid duplicate operations here.
-	 */
-	ret = pm_runtime_get_sync(dwc->dev);
-	if (!ret || ret < 0) {
-		pm_runtime_put(dwc->dev);
-		if (ret < 0)
-			pm_runtime_set_suspended(dwc->dev);
-		return ret;
-	}
-
-	if (dwc->pullups_connected == is_on) {
-		pm_runtime_put(dwc->dev);
-		return 0;
-	}
-
-	synchronize_irq(dwc->irq_gadget);
-
 	if (!is_on)
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	else
 		ret = dwc3_gadget_soft_connect(dwc);
 
-	pm_runtime_put(dwc->dev);
-
 	return ret;
 }
 
@@ -2856,7 +2589,6 @@ static void dwc3_gadget_disable_irq(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DEVTEN, 0x00);
 }
 
-static irqreturn_t dwc3_interrupt(int irq, void *_dwc);
 static irqreturn_t dwc3_thread_interrupt(int irq, void *_dwc);
 
 /**
@@ -3000,26 +2732,8 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
-	int			ret;
-	int			irq;
 
-	irq = dwc->irq_gadget;
-	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
-			IRQF_SHARED, "dwc3", dwc->ev_buf);
-	if (ret) {
-		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
-				irq, ret);
-		return ret;
-	}
-
-	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= driver;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	if (dwc->sys_wakeup)
-		device_wakeup_enable(dwc->sysdev);
-
 	return 0;
 }
 
@@ -3033,17 +2747,9 @@ static void __dwc3_gadget_stop(struct dwc3 *dwc)
 static int dwc3_gadget_stop(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
 
-	if (dwc->sys_wakeup)
-		device_wakeup_disable(dwc->sysdev);
-
-	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= NULL;
 	dwc->max_cfg_eps = 0;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	free_irq(dwc->irq_gadget, dwc->ev_buf);
 
 	return 0;
 }
@@ -3113,19 +2819,11 @@ static void dwc3_gadget_set_ssp_rate(struct usb_gadget *g,
 static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	union power_supply_propval	val = {0};
-	int				ret;
 
 	if (dwc->usb2_phy)
 		return usb_phy_set_power(dwc->usb2_phy, mA);
 
-	if (!dwc->usb_psy)
-		return -EOPNOTSUPP;
-
-	val.intval = 1000 * mA;
-	ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
-
-	return ret;
+	return 0;
 }
 
 /**
@@ -3186,8 +2884,6 @@ static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
-	.func_wakeup		= dwc3_gadget_func_wakeup,
-	.set_remote_wakeup	= dwc3_gadget_set_remote_wakeup,
 	.set_selfpowered	= dwc3_gadget_set_selfpowered,
 	.pullup			= dwc3_gadget_pullup,
 	.udc_start		= dwc3_gadget_start,
@@ -3202,6 +2898,47 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 
 /* -------------------------------------------------------------------------- */
 
+static irqreturn_t dwc3_check_event_buf(struct dwc3 *dwc)
+{
+	struct dwc3_event_buffer *evt;
+	u32 count;
+	u32 reg;
+
+	evt = dwc->ev_buf;
+
+	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	count &= DWC3_GEVNTCOUNT_MASK;
+	if (!count)
+		return IRQ_NONE;
+
+	evt->count = count;
+	evt->flags |= DWC3_EVENT_PENDING;
+
+	/* Mask interrupt */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
+	reg |= DWC3_GEVNTSIZ_INTMASK;
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
+{
+	struct dwc3 *dwc = _dwc;
+	irqreturn_t ret = IRQ_NONE;
+	irqreturn_t status;
+
+	spin_lock(&dwc->lock);
+
+	status = dwc3_check_event_buf(dwc);
+	if (status == IRQ_WAKE_THREAD)
+		ret = status;
+
+	spin_unlock(&dwc->lock);
+
+	return ret;
+}
+
 static int dwc3_gadget_init_control_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
@@ -3210,7 +2947,7 @@ static int dwc3_gadget_init_control_endpoint(struct dwc3_ep *dep)
 	dep->endpoint.maxburst = 1;
 	dep->endpoint.ops = &dwc3_gadget_ep0_ops;
 	if (!dep->direction)
-		dwc->gadget->ep0 = &dep->endpoint;
+		dwc->gadget.ep0 = &dep->endpoint;
 
 	dep->endpoint.caps.type_control = true;
 
@@ -3258,7 +2995,7 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 	dep->endpoint.max_streams = 16;
 	dep->endpoint.ops = &dwc3_gadget_ep_ops;
 	list_add_tail(&dep->endpoint.ep_list,
-			&dwc->gadget->ep_list);
+			&dwc->gadget.ep_list);
 	dep->endpoint.caps.type_iso = true;
 	dep->endpoint.caps.type_bulk = true;
 	dep->endpoint.caps.type_int = true;
@@ -3305,7 +3042,7 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 	dep->endpoint.max_streams = 16;
 	dep->endpoint.ops = &dwc3_gadget_ep_ops;
 	list_add_tail(&dep->endpoint.ep_list,
-			&dwc->gadget->ep_list);
+			&dwc->gadget.ep_list);
 	dep->endpoint.caps.type_iso = true;
 	dep->endpoint.caps.type_bulk = true;
 	dep->endpoint.caps.type_int = true;
@@ -3313,50 +3050,6 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 	return dwc3_alloc_trb_pool(dep);
 }
 
-#define nostream_work_to_dep(w) (container_of(to_delayed_work(w), struct dwc3_ep, nostream_work))
-static void dwc3_nostream_work(struct work_struct *work)
-{
-	struct dwc3_ep	*dep = nostream_work_to_dep(work);
-	struct dwc3	*dwc = dep->dwc;
-	unsigned long   flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dep->flags & DWC3_EP_STREAM_PRIMED)
-		goto out;
-
-	if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
-	    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
-	     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
-		goto out;
-	/*
-	 * If the host rejects a stream due to no active stream, by the
-	 * USB and xHCI spec, the endpoint will be put back to idle
-	 * state. When the host is ready (buffer added/updated), it will
-	 * prime the endpoint to inform the usb device controller. This
-	 * triggers the device controller to issue ERDY to restart the
-	 * stream. However, some hosts don't follow this and keep the
-	 * endpoint in the idle state. No prime will come despite host
-	 * streams are updated, and the device controller will not be
-	 * triggered to generate ERDY to move the next stream data. To
-	 * workaround this and maintain compatibility with various
-	 * hosts, force to reinitiate the stream until the host is ready
-	 * instead of waiting for the host to prime the endpoint.
-	 */
-	if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
-		unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
-
-		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
-	} else {
-		dep->flags |= DWC3_EP_DELAY_START;
-		dwc3_stop_active_transfer(dep, true, true);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return;
-	}
-out:
-	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-}
-
 static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 {
 	struct dwc3_ep			*dep;
@@ -3402,7 +3095,6 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	INIT_LIST_HEAD(&dep->pending_list);
 	INIT_LIST_HEAD(&dep->started_list);
 	INIT_LIST_HEAD(&dep->cancelled_list);
-	INIT_DELAYED_WORK(&dep->nostream_work, dwc3_nostream_work);
 
 	dwc3_debugfs_create_endpoint_dir(dep);
 
@@ -3439,7 +3131,7 @@ static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
 	u8				num;
 	int				ret;
 
-	INIT_LIST_HEAD(&dwc->gadget->ep_list);
+	INIT_LIST_HEAD(&dwc->gadget.ep_list);
 
 	ret = dwc3_gadget_get_reserved_endpoints(dwc, propname,
 						 reserved_eps, ARRAY_SIZE(reserved_eps));
@@ -3503,7 +3195,6 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 
 	dwc3_ep_inc_deq(dep);
 
-	trace_dwc3_complete_trb(dep, trb);
 	req->num_trbs--;
 
 	/*
@@ -3844,7 +3535,6 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
 	if (event->status == DEPEVT_STREAMEVT_FOUND) {
-		cancel_delayed_work(&dep->nostream_work);
 		dep->flags |= DWC3_EP_STREAM_PRIMED;
 		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
 		return;
@@ -3853,15 +3543,11 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 	/* Note: NoStream rejection event param value is 0 and not 0xFFFF */
 	switch (event->parameters) {
 	case DEPEVT_STREAM_PRIME:
-		cancel_delayed_work(&dep->nostream_work);
 		dep->flags |= DWC3_EP_STREAM_PRIMED;
 		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
 		break;
 	case DEPEVT_STREAM_NOSTREAM:
 		dep->flags &= ~DWC3_EP_STREAM_PRIMED;
-		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM)
-			queue_delayed_work(system_wq, &dep->nostream_work,
-					   msecs_to_jiffies(100));
 		break;
 	}
 }
@@ -3921,7 +3607,7 @@ static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
 	if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->disconnect(dwc->gadget);
+		dwc->gadget_driver->disconnect(&dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3930,7 +3616,7 @@ static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
 	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->suspend(dwc->gadget);
+		dwc->gadget_driver->suspend(&dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3939,7 +3625,7 @@ static void dwc3_resume_gadget(struct dwc3 *dwc)
 {
 	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->resume(dwc->gadget);
+		dwc->gadget_driver->resume(&dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3949,9 +3635,9 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return;
 
-	if (dwc->async_callbacks && dwc->gadget->speed != USB_SPEED_UNKNOWN) {
+	if (dwc->async_callbacks && dwc->gadget.speed != USB_SPEED_UNKNOWN) {
 		spin_unlock(&dwc->lock);
-		usb_gadget_udc_reset(dwc->gadget, dwc->gadget_driver);
+		usb_gadget_udc_reset(&dwc->gadget, dwc->gadget_driver);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -4062,20 +3748,13 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 
 	dwc3_disconnect_gadget(dwc);
 
-	dwc->gadget->speed = USB_SPEED_UNKNOWN;
+	dwc->gadget.speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
-	dwc->gadget->wakeup_armed = false;
+	dwc->gadget.wakeup_armed = false;
 	dwc3_gadget_enable_linksts_evts(dwc, false);
-	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
+	usb_gadget_set_state(&dwc->gadget, USB_STATE_NOTATTACHED);
 
 	dwc3_ep0_reset_state(dwc);
-
-	/*
-	 * Request PM idle to address condition where usage count is
-	 * already decremented to zero, but waiting for the disconnect
-	 * interrupt to set dwc->connected to FALSE.
-	 */
-	pm_request_idle(dwc->dev);
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
@@ -4146,7 +3825,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 	dwc->test_mode = false;
-	dwc->gadget->wakeup_armed = false;
+	dwc->gadget.wakeup_armed = false;
 	dwc3_gadget_enable_linksts_evts(dwc, false);
 	dwc3_clear_stall_all_ep(dwc);
 
@@ -4174,7 +3853,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	if (DWC3_IP_IS(DWC32))
 		lanes = DWC3_DSTS_CONNLANES(reg) + 1;
 
-	dwc->gadget->ssp_rate = USB_SSP_GEN_UNKNOWN;
+	dwc->gadget.ssp_rate = USB_SSP_GEN_UNKNOWN;
 
 	/*
 	 * RAMClkSel is reset to 0 after USB reset, so it must be reprogrammed
@@ -4188,13 +3867,13 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	switch (speed) {
 	case DWC3_DSTS_SUPERSPEED_PLUS:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
-		dwc->gadget->ep0->maxpacket = 512;
-		dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
+		dwc->gadget.ep0->maxpacket = 512;
+		dwc->gadget.speed = USB_SPEED_SUPER_PLUS;
 
 		if (lanes > 1)
-			dwc->gadget->ssp_rate = USB_SSP_GEN_2x2;
+			dwc->gadget.ssp_rate = USB_SSP_GEN_2x2;
 		else
-			dwc->gadget->ssp_rate = USB_SSP_GEN_2x1;
+			dwc->gadget.ssp_rate = USB_SSP_GEN_2x1;
 		break;
 	case DWC3_DSTS_SUPERSPEED:
 		/*
@@ -4214,27 +3893,27 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 			dwc3_gadget_reset_interrupt(dwc);
 
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
-		dwc->gadget->ep0->maxpacket = 512;
-		dwc->gadget->speed = USB_SPEED_SUPER;
+		dwc->gadget.ep0->maxpacket = 512;
+		dwc->gadget.speed = USB_SPEED_SUPER;
 
 		if (lanes > 1) {
-			dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
-			dwc->gadget->ssp_rate = USB_SSP_GEN_1x2;
+			dwc->gadget.speed = USB_SPEED_SUPER_PLUS;
+			dwc->gadget.ssp_rate = USB_SSP_GEN_1x2;
 		}
 		break;
 	case DWC3_DSTS_HIGHSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
-		dwc->gadget->ep0->maxpacket = 64;
-		dwc->gadget->speed = USB_SPEED_HIGH;
+		dwc->gadget.ep0->maxpacket = 64;
+		dwc->gadget.speed = USB_SPEED_HIGH;
 		break;
 	case DWC3_DSTS_FULLSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
-		dwc->gadget->ep0->maxpacket = 64;
-		dwc->gadget->speed = USB_SPEED_FULL;
+		dwc->gadget.ep0->maxpacket = 64;
+		dwc->gadget.speed = USB_SPEED_FULL;
 		break;
 	}
 
-	dwc->eps[1]->endpoint.maxpacket = dwc->gadget->ep0->maxpacket;
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget.ep0->maxpacket;
 
 	/* Enable USB2 LPM Capability */
 
@@ -4313,7 +3992,7 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
 
 	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->resume(dwc->gadget);
+		dwc->gadget_driver->resume(&dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 
@@ -4402,7 +4081,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 
 	switch (next) {
 	case DWC3_LINK_STATE_U0:
-		if (dwc->gadget->wakeup_armed || dwc->wakeup_pending_funcs) {
+		if (dwc->gadget.wakeup_armed || dwc->wakeup_pending_funcs) {
 			dwc3_gadget_enable_linksts_evts(dwc, false);
 			dwc3_resume_gadget(dwc);
 			dwc->suspended = false;
@@ -4469,7 +4148,6 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_wakeup_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
-		dev_WARN_ONCE(dwc->dev, true, "unexpected hibernation event\n");
 		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
@@ -4485,15 +4163,13 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 	case DWC3_DEVICE_EVENT_OVERFLOW:
 		break;
 	default:
-		dev_WARN(dwc->dev, "UNKNOWN IRQ %d\n", event->type);
+		dev_warn(dwc->dev, "UNKNOWN IRQ %d\n", event->type);
 	}
 }
 
 static void dwc3_process_event_entry(struct dwc3 *dwc,
 		const union dwc3_event *event)
 {
-	trace_dwc3_event(event->raw, dwc);
-
 	if (!event->type.is_devspec)
 		dwc3_endpoint_interrupt(dwc, &event->depevt);
 	else if (event->type.type == DWC3_EVENT_TYPE_DEV)
@@ -4545,7 +4221,7 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	 * Add an explicit write memory barrier to make sure that the update of
 	 * clearing DWC3_EVENT_PENDING is observed in dwc3_check_event_buf()
 	 */
-	wmb();
+	// FIXME wmb();
 
 	if (dwc->imod_interval) {
 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
@@ -4558,112 +4234,12 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 {
 	struct dwc3_event_buffer *evt = _evt;
-	struct dwc3 *dwc = evt->dwc;
-	unsigned long flags;
-	irqreturn_t ret = IRQ_NONE;
 
-	local_bh_disable();
-	spin_lock_irqsave(&dwc->lock, flags);
-	ret = dwc3_process_event_buf(evt);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-	local_bh_enable();
-
-	return ret;
-}
-
-static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
-{
-	struct dwc3 *dwc = evt->dwc;
-	u32 amount;
-	u32 count;
-
-	if (pm_runtime_suspended(dwc->dev)) {
-		dwc->pending_events = true;
-		/*
-		 * Trigger runtime resume. The get() function will be balanced
-		 * after processing the pending events in dwc3_process_pending
-		 * events().
-		 */
-		pm_runtime_get(dwc->dev);
-		disable_irq_nosync(dwc->irq_gadget);
-		return IRQ_HANDLED;
-	}
-
-	/*
-	 * With PCIe legacy interrupt, test shows that top-half irq handler can
-	 * be called again after HW interrupt deassertion. Check if bottom-half
-	 * irq event handler completes before caching new event to prevent
-	 * losing events.
-	 */
-	if (evt->flags & DWC3_EVENT_PENDING)
-		return IRQ_HANDLED;
-
-	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
-	count &= DWC3_GEVNTCOUNT_MASK;
-	if (!count)
-		return IRQ_NONE;
-
-	if (count > evt->length) {
-		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
-			count, evt->length);
-		return IRQ_NONE;
-	}
-
-	evt->count = count;
-	evt->flags |= DWC3_EVENT_PENDING;
-
-	/* Mask interrupt */
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
-		    DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
-
-	amount = min(count, evt->length - evt->lpos);
-	memcpy(evt->cache + evt->lpos, evt->buf + evt->lpos, amount);
-
-	if (amount < count)
-		memcpy(evt->cache, evt->buf, count - amount);
-
-	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
-
-	return IRQ_WAKE_THREAD;
-}
-
-static irqreturn_t dwc3_interrupt(int irq, void *_evt)
-{
-	struct dwc3_event_buffer	*evt = _evt;
-
-	return dwc3_check_event_buf(evt);
-}
-
-static int dwc3_gadget_get_irq(struct dwc3 *dwc)
-{
-	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
-	int irq;
-
-	irq = platform_get_irq_byname_optional(dwc3_pdev, "peripheral");
-	if (irq > 0)
-		goto out;
-
-	if (irq == -EPROBE_DEFER)
-		goto out;
-
-	irq = platform_get_irq_byname_optional(dwc3_pdev, "dwc_usb3");
-	if (irq > 0)
-		goto out;
-
-	if (irq == -EPROBE_DEFER)
-		goto out;
-
-	irq = platform_get_irq(dwc3_pdev, 0);
-
-out:
-	return irq;
+	return dwc3_process_event_buf(evt);
 }
 
 static void dwc_gadget_release(struct device *dev)
 {
-	struct usb_gadget *gadget = container_of(dev, struct usb_gadget, dev);
-
-	kfree(gadget);
 }
 
 /**
@@ -4675,20 +4251,10 @@ static void dwc_gadget_release(struct device *dev)
 int dwc3_gadget_init(struct dwc3 *dwc)
 {
 	int ret;
-	int irq;
 	struct device *dev;
 
-	irq = dwc3_gadget_get_irq(dwc);
-	if (irq < 0) {
-		ret = irq;
-		goto err0;
-	}
-
-	dwc->irq_gadget = irq;
-
-	dwc->ep0_trb = dma_alloc_coherent(dwc->sysdev,
-					  sizeof(*dwc->ep0_trb) * 2,
-					  &dwc->ep0_trb_addr, GFP_KERNEL);
+	dwc->ep0_trb = dma_alloc_coherent(sizeof(*dwc->ep0_trb) * 2,
+					  (long *)&dwc->ep0_trb_addr);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
 		ret = -ENOMEM;
@@ -4701,31 +4267,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err1;
 	}
 
-	dwc->bounce = dma_alloc_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE,
-			&dwc->bounce_addr, GFP_KERNEL);
+	dwc->bounce = dma_alloc_coherent(DWC3_BOUNCE_SIZE,
+					 (unsigned long *)&dwc->bounce_addr);
 	if (!dwc->bounce) {
 		ret = -ENOMEM;
 		goto err2;
 	}
 
-	init_completion(&dwc->ep0_in_setup);
-	dwc->gadget = kzalloc(sizeof(struct usb_gadget), GFP_KERNEL);
-	if (!dwc->gadget) {
-		ret = -ENOMEM;
-		goto err3;
-	}
-
-
-	usb_initialize_gadget(dwc->dev, dwc->gadget, dwc_gadget_release);
-	dev				= &dwc->gadget->dev;
-	dev->platform_data		= dwc;
-	dwc->gadget->ops		= &dwc3_gadget_ops;
-	dwc->gadget->speed		= USB_SPEED_UNKNOWN;
-	dwc->gadget->ssp_rate		= USB_SSP_GEN_UNKNOWN;
-	dwc->gadget->sg_supported	= true;
-	dwc->gadget->name		= "dwc3-gadget";
-	dwc->gadget->lpm_capable	= !dwc->usb2_gadget_lpm_disable;
-	dwc->gadget->wakeup_capable	= true;
+	usb_initialize_gadget((struct device *)dwc->dev, &dwc->gadget,
+			      dwc_gadget_release);
+	dev				= &dwc->gadget.dev;
+	dwc->gadget.ops		= &dwc3_gadget_ops;
+	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
+	dwc->gadget.ssp_rate		= USB_SSP_GEN_UNKNOWN;
+	dwc->gadget.name		= "dwc3-gadget";
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -4748,8 +4303,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		dev_info(dwc->dev, "changing max_speed on rev %08x\n",
 				dwc->revision);
 
-	dwc->gadget->max_speed		= dwc->maximum_speed;
-	dwc->gadget->max_ssp_rate	= dwc->max_ssp_rate;
+	dwc->gadget.max_speed		= dwc->maximum_speed;
+	dwc->gadget.max_ssp_rate	= dwc->max_ssp_rate;
 
 	/*
 	 * REVISIT: Here we should clear all pending IRQs to be
@@ -4760,38 +4315,30 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	if (ret)
 		goto err4;
 
-	ret = usb_add_gadget(dwc->gadget);
+	ret = usb_add_gadget(&dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to add gadget\n");
 		goto err5;
 	}
 
 	if (DWC3_IP_IS(DWC32) && dwc->maximum_speed == USB_SPEED_SUPER_PLUS)
-		dwc3_gadget_set_ssp_rate(dwc->gadget, dwc->max_ssp_rate);
+		dwc3_gadget_set_ssp_rate(&dwc->gadget, dwc->max_ssp_rate);
 	else
-		dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
-
-	/* No system wakeup if no gadget driver bound */
-	if (dwc->sys_wakeup)
-		device_wakeup_disable(dwc->sysdev);
+		dwc3_gadget_set_speed(&dwc->gadget, dwc->maximum_speed);
 
 	return 0;
 
 err5:
 	dwc3_gadget_free_endpoints(dwc);
 err4:
-	usb_put_gadget(dwc->gadget);
-	dwc->gadget = NULL;
-err3:
-	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
-			dwc->bounce_addr);
+	usb_put_gadget(&dwc->gadget);
+	dma_free_coherent(dwc->bounce);
 
 err2:
 	kfree(dwc->setup_buf);
 
 err1:
-	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
-			dwc->ep0_trb, dwc->ep0_trb_addr);
+	dma_free_coherent(dwc->ep0_trb);
 
 err0:
 	return ret;
@@ -4801,48 +4348,33 @@ err0:
 
 void dwc3_gadget_exit(struct dwc3 *dwc)
 {
-	if (!dwc->gadget)
-		return;
-
 	dwc3_enable_susphy(dwc, false);
-	usb_del_gadget(dwc->gadget);
+	usb_del_gadget_udc(&dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
-	usb_put_gadget(dwc->gadget);
-	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
-			  dwc->bounce_addr);
+	usb_put_gadget(&dwc->gadget);
+	dma_free_coherent(dwc->bounce);
 	kfree(dwc->setup_buf);
-	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
-			  dwc->ep0_trb, dwc->ep0_trb_addr);
+	dma_free_coherent(dwc->ep0_trb);
 }
 
-int dwc3_gadget_suspend(struct dwc3 *dwc)
+/**
+ * dwc3_gadget_uboot_handle_interrupt - handle dwc3 gadget interrupt
+ * @dwc: struct dwce *
+ *
+ * Handles ep0 and gadget interrupt
+ *
+ * Should be called from dwc3 core.
+ */
+void dwc3_gadget_uboot_handle_interrupt(struct dwc3 *dwc)
 {
-	unsigned long flags;
-	int ret;
+	int ret = dwc3_interrupt(0, dwc);
 
-	ret = dwc3_gadget_soft_disconnect(dwc);
-	/*
-	 * Attempt to reset the controller's state. Likely no
-	 * communication can be established until the host
-	 * performs a port reset.
-	 */
-	if (ret && dwc->softconnect) {
-		dwc3_gadget_soft_connect(dwc);
-		return -EAGAIN;
+	if (ret == IRQ_WAKE_THREAD) {
+		struct dwc3_event_buffer *evt;
+
+		dwc3_thread_interrupt(0, dwc);
+
+		/* Clean + Invalidate the buffer after touching it */
+		dwc3_flush_cache((uintptr_t)evt->buf, evt->length);
 	}
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dwc->gadget_driver)
-		dwc3_disconnect_gadget(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return 0;
-}
-
-int dwc3_gadget_resume(struct dwc3 *dwc)
-{
-	if (!dwc->gadget_driver || !dwc->softconnect)
-		return 0;
-
-	return dwc3_gadget_soft_connect(dwc);
 }
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index d73e735e4081..095c27ffe9ce 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -17,7 +17,8 @@
 
 struct dwc3;
 #define to_dwc3_ep(ep)		(container_of(ep, struct dwc3_ep, endpoint))
-#define gadget_to_dwc(g)	(dev_get_platdata(&g->dev))
+#define gadget_to_dwc(g)	(container_of(g, struct dwc3, gadget))
+
 
 /* DEPCFG parameter 1 */
 #define DWC3_DEPCFG_INT_NUM(n)		(((n) & 0x1f) << 0)
@@ -120,6 +121,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
 void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
 void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt);
 int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index);
+void dwc3_gadget_uboot_handle_interrupt(struct dwc3 *dwc);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 1e96ea339d48..8bb0d891226c 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -11,10 +11,10 @@
 #ifndef __DRIVERS_USB_DWC3_IO_H
 #define __DRIVERS_USB_DWC3_IO_H
 
-#include <linux/io.h>
-#include "trace.h"
-#include "debug.h"
-#include "core.h"
+#include <asm/io.h>
+#include <cpu_func.h>
+
+#define CACHELINE_SIZE CONFIG_SYS_CACHELINE_SIZE
 
 static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 {
@@ -27,13 +27,6 @@ static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 	 */
 	value = readl(base + offset - DWC3_GLOBALS_REGS_START);
 
-	/*
-	 * When tracing we want to make it easy to find the correct address on
-	 * documentation, so we revert it back to the proper addresses, the
-	 * same way they are described on SNPS documentation
-	 */
-	trace_dwc3_readl(base - DWC3_GLOBALS_REGS_START, offset, value);
-
 	return value;
 }
 
@@ -45,13 +38,14 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 	 * However, the offsets are given starting from xHCI address space.
 	 */
 	writel(value, base + offset - DWC3_GLOBALS_REGS_START);
+}
 
-	/*
-	 * When tracing we want to make it easy to find the correct address on
-	 * documentation, so we revert it back to the proper addresses, the
-	 * same way they are described on SNPS documentation
-	 */
-	trace_dwc3_writel(base - DWC3_GLOBALS_REGS_START, offset, value);
+static inline void dwc3_flush_cache(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
+
+	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
 }
 
 #endif /* __DRIVERS_USB_DWC3_IO_H */
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index b3c780a4e35c..5b0c55d59c8d 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1435,52 +1435,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 	return at91_udc_irq(udc);
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	struct at91_udc *udc = controller;
-	int ret;
-
-	if (!driver || !driver->bind || !driver->setup) {
-		printf("bad paramter\n");
-		return -EINVAL;
-	}
-
-	if (udc->driver) {
-		printf("UDC already has a gadget driver\n");
-		return -EBUSY;
-	}
-
-	at91_start(&udc->gadget, driver);
-
-	udc->driver = driver;
-
-	ret = driver->bind(&udc->gadget);
-	if (ret) {
-		pr_err("driver->bind() returned %d\n", ret);
-		udc->driver = NULL;
-	}
-
-	return ret;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	struct at91_udc *udc = controller;
-
-	if (!driver || !driver->unbind || !driver->disconnect) {
-		pr_err("bad paramter\n");
-		return -EINVAL;
-	}
-
-	driver->disconnect(&udc->gadget);
-	driver->unbind(&udc->gadget);
-	udc->driver = NULL;
-
-	at91_stop(&udc->gadget);
-
-	return 0;
-}
-
 int at91_udc_probe(struct at91_udc_data *pdata)
 {
 	struct at91_udc	*udc;
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f7a92ded6dab..1f0015ed36a0 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -32,12 +32,6 @@ static int usba_udc_stop(struct usb_gadget *gadget);
 
 #include "atmel_usba_udc.h"
 
-static int vbus_is_present(struct usba_udc *udc)
-{
-	/* No Vbus detection: Assume always present */
-	return 1;
-}
-
 static void next_fifo_transaction(struct usba_ep *ep, struct usba_request *req)
 {
 	unsigned int transaction_len;
@@ -1187,32 +1181,6 @@ static int usba_udc_irq(struct usba_udc *udc)
 	return 0;
 }
 
-static int usba_udc_enable(struct usba_udc *udc)
-{
-	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
-
-	udc->vbus_prev = 0;
-
-	/* If Vbus is present, enable the controller and wait for reset */
-	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
-		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
-		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
-	}
-
-	return 0;
-}
-
-static int usba_udc_disable(struct usba_udc *udc)
-{
-	udc->gadget.speed = USB_SPEED_UNKNOWN;
-	reset_all_endpoints(udc);
-
-	/* This will also disable the DP pullup */
-	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
-
-	return 0;
-}
-
 static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 				      struct usba_udc *udc)
 {
@@ -1273,52 +1241,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 	return usba_udc_irq(udc);
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	struct usba_udc *udc = &controller;
-	int ret;
-
-	if (!driver || !driver->bind || !driver->setup) {
-		log_err("bad parameter\n");
-		return -EINVAL;
-	}
-
-	if (udc->driver) {
-		log_err("UDC already has a gadget driver\n");
-		return -EBUSY;
-	}
-
-	usba_udc_enable(udc);
-
-	udc->driver = driver;
-
-	ret = driver->bind(&udc->gadget);
-	if (ret) {
-		log_err("driver->bind() returned %d\n", ret);
-		udc->driver = NULL;
-	}
-
-	return ret;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	struct usba_udc *udc = &controller;
-
-	if (!driver || !driver->unbind || !driver->disconnect) {
-		log_err("bad parameter\n");
-		return -EINVAL;
-	}
-
-	driver->disconnect(&udc->gadget);
-	driver->unbind(&udc->gadget);
-	udc->driver = NULL;
-
-	usba_udc_disable(udc);
-
-	return 0;
-}
-
 int usba_udc_probe(struct usba_platform_data *pdata)
 {
 	struct usba_udc *udc;
@@ -1336,6 +1258,38 @@ struct usba_priv_data {
 	struct usba_udc		udc;
 };
 
+static int vbus_is_present(struct usba_udc *udc)
+{
+	/* No Vbus detection: Assume always present */
+	return 1;
+}
+
+static int usba_udc_enable(struct usba_udc *udc)
+{
+	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
+
+	udc->vbus_prev = 0;
+
+	/* If Vbus is present, enable the controller and wait for reset */
+	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
+		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
+		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
+	}
+
+	return 0;
+}
+
+static int usba_udc_disable(struct usba_udc *udc)
+{
+	udc->gadget.speed = USB_SPEED_UNKNOWN;
+	reset_all_endpoints(udc);
+
+	/* This will also disable the DP pullup */
+	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
+
+	return 0;
+}
+
 static int usba_udc_start(struct usb_gadget *gadget,
 			  struct usb_gadget_driver *driver)
 {
diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 4bff75da759d..ae208ea0627e 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -84,62 +84,15 @@ static struct usb_endpoint_descriptor ep0_desc = {
 };
 
 static int ci_pullup(struct usb_gadget *gadget, int is_on);
-static int ci_ep_enable(struct usb_ep *ep,
-		const struct usb_endpoint_descriptor *desc);
-static int ci_ep_disable(struct usb_ep *ep);
-static int ci_ep_queue(struct usb_ep *ep,
-		struct usb_request *req, gfp_t gfp_flags);
-static int ci_ep_dequeue(struct usb_ep *ep, struct usb_request *req);
-static struct usb_request *
-ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
-static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req);
 
 static const struct usb_gadget_ops ci_udc_ops = {
 	.pullup = ci_pullup,
 };
 
-static const struct usb_ep_ops ci_ep_ops = {
-	.enable         = ci_ep_enable,
-	.disable        = ci_ep_disable,
-	.queue          = ci_ep_queue,
-	.dequeue	= ci_ep_dequeue,
-	.alloc_request  = ci_ep_alloc_request,
-	.free_request   = ci_ep_free_request,
-};
-
 __weak void ci_init_after_reset(struct ehci_ctrl *ctrl)
 {
 }
 
-/* Init values for USB endpoints. */
-static const struct usb_ep ci_ep_init[5] = {
-	[0] = {	/* EP 0 */
-		.maxpacket	= 64,
-		.name		= "ep0",
-		.ops		= &ci_ep_ops,
-	},
-	[1] = {
-		.maxpacket	= 512,
-		.name		= "ep1in-bulk",
-		.ops		= &ci_ep_ops,
-	},
-	[2] = {
-		.maxpacket	= 512,
-		.name		= "ep2out-bulk",
-		.ops		= &ci_ep_ops,
-	},
-	[3] = {
-		.maxpacket	= 512,
-		.name		= "ep3in-int",
-		.ops		= &ci_ep_ops,
-	},
-	[4] = {
-		.maxpacket	= 512,
-		.name		= "ep-",
-		.ops		= &ci_ep_ops,
-	},
-};
-
 static struct ci_drv controller = {
 	.gadget	= {
 		.name	= "ci_udc",
@@ -263,51 +216,6 @@ static void ci_invalidate_td(struct ept_queue_item *td)
 	invalidate_dcache_range(start, end);
 }
 
-static struct usb_request *
-ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags)
-{
-	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	int num = -1;
-	struct ci_req *ci_req;
-
-	if (ci_ep->desc)
-		num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-
-	if (num == 0 && controller.ep0_req)
-		return &controller.ep0_req->req;
-
-	ci_req = calloc(1, sizeof(*ci_req));
-	if (!ci_req)
-		return NULL;
-
-	INIT_LIST_HEAD(&ci_req->queue);
-
-	if (num == 0)
-		controller.ep0_req = ci_req;
-
-	return &ci_req->req;
-}
-
-static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *req)
-{
-	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	struct ci_req *ci_req = container_of(req, struct ci_req, req);
-	int num = -1;
-
-	if (ci_ep->desc)
-		num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-
-	if (num == 0) {
-		if (!controller.ep0_req)
-			return;
-		controller.ep0_req = 0;
-	}
-
-	if (ci_req->b_buf)
-		free(ci_req->b_buf);
-	free(ci_req);
-}
-
 static void ep_enable(int num, int in, int maxpacket)
 {
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
@@ -328,126 +236,6 @@ static void ep_enable(int num, int in, int maxpacket)
 	writel(n, &udc->epctrl[num]);
 }
 
-static int ci_ep_enable(struct usb_ep *ep,
-		const struct usb_endpoint_descriptor *desc)
-{
-	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	int num, in;
-	num = desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	in = (desc->bEndpointAddress & USB_DIR_IN) != 0;
-	ci_ep->desc = desc;
-	ep->desc = desc;
-
-	if (num) {
-		int max = get_unaligned_le16(&desc->wMaxPacketSize);
-
-		if ((max > 64) && (controller.gadget.speed == USB_SPEED_FULL))
-			max = 64;
-		if (ep->maxpacket != max) {
-			DBG("%s: from %d to %d\n", __func__,
-			    ep->maxpacket, max);
-			ep->maxpacket = max;
-		}
-	}
-	ep_enable(num, in, ep->maxpacket);
-	DBG("%s: num=%d maxpacket=%d\n", __func__, num, ep->maxpacket);
-	return 0;
-}
-
-static int ep_disable(int num, int in)
-{
-	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
-	unsigned int ep_bit, enable_bit;
-	int err;
-
-	if (in) {
-		ep_bit = EPT_TX(num);
-		enable_bit = CTRL_TXE;
-	} else {
-		ep_bit = EPT_RX(num);
-		enable_bit = CTRL_RXE;
-	}
-
-	/* clear primed buffers */
-	do {
-		writel(ep_bit, &udc->epflush);
-		err = wait_for_bit_le32(&udc->epflush, ep_bit, false, 1000, false);
-		if (err)
-			return err;
-	} while (readl(&udc->epstat) & ep_bit);
-
-	/* clear enable bit */
-	clrbits_le32(&udc->epctrl[num], enable_bit);
-
-	return 0;
-}
-
-static int ci_ep_disable(struct usb_ep *ep)
-{
-	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	int num, in, err;
-
-	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
-
-	err = ep_disable(num, in);
-	if (err)
-		return err;
-
-	ci_ep->desc = NULL;
-	ep->desc = NULL;
-	ci_ep->req_primed = false;
-	return 0;
-}
-
-static int ci_bounce(struct ci_req *ci_req, int in)
-{
-	struct usb_request *req = &ci_req->req;
-	unsigned long addr = (unsigned long)req->buf;
-	unsigned long hwaddr;
-	uint32_t aligned_used_len;
-
-	/* Input buffer address is not aligned. */
-	if (addr & (ARCH_DMA_MINALIGN - 1))
-		goto align;
-
-	/* Input buffer length is not aligned. */
-	if (req->length & (ARCH_DMA_MINALIGN - 1))
-		goto align;
-
-	/* The buffer is well aligned, only flush cache. */
-	ci_req->hw_len = req->length;
-	ci_req->hw_buf = req->buf;
-	goto flush;
-
-align:
-	if (ci_req->b_buf && req->length > ci_req->b_len) {
-		free(ci_req->b_buf);
-		ci_req->b_buf = 0;
-	}
-	if (!ci_req->b_buf) {
-		ci_req->b_len = roundup(req->length, ARCH_DMA_MINALIGN);
-		ci_req->b_buf = memalign(ARCH_DMA_MINALIGN, ci_req->b_len);
-		if (!ci_req->b_buf)
-			return -ENOMEM;
-	}
-	ci_req->hw_len = ci_req->b_len;
-	ci_req->hw_buf = ci_req->b_buf;
-
-	if (in)
-		memcpy(ci_req->hw_buf, req->buf, req->length);
-
-flush:
-	hwaddr = (unsigned long)ci_req->hw_buf;
-	if (!hwaddr)
-		return 0;
-
-	aligned_used_len = roundup(req->length, ARCH_DMA_MINALIGN);
-	flush_dcache_range(hwaddr, hwaddr + aligned_used_len);
-
-	return 0;
-}
-
 static void ci_debounce(struct ci_req *ci_req, int in)
 {
 	struct usb_request *req = &ci_req->req;
@@ -574,70 +362,6 @@ static void ci_ep_submit_next_request(struct ci_ep *ci_ep)
 	writel(bit, &udc->epprime);
 }
 
-static int ci_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
-{
-	struct ci_ep *ci_ep = container_of(_ep, struct ci_ep, ep);
-	struct ci_req *ci_req;
-
-	list_for_each_entry(ci_req, &ci_ep->queue, queue) {
-		if (&ci_req->req == _req)
-			break;
-	}
-
-	if (&ci_req->req != _req)
-		return -EINVAL;
-
-	list_del_init(&ci_req->queue);
-
-	if (ci_req->req.status == -EINPROGRESS) {
-		ci_req->req.status = -ECONNRESET;
-		if (ci_req->req.complete)
-			ci_req->req.complete(_ep, _req);
-	}
-
-	return 0;
-}
-
-static int ci_ep_queue(struct usb_ep *ep,
-		struct usb_request *req, gfp_t gfp_flags)
-{
-	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	struct ci_req *ci_req = container_of(req, struct ci_req, req);
-	int in, ret;
-	int __maybe_unused num;
-
-	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
-
-	if (!num && ci_ep->req_primed) {
-		/*
-		 * The flipping of ep0 between IN and OUT relies on
-		 * ci_ep_queue consuming the current IN/OUT setting
-		 * immediately. If this is deferred to a later point when the
-		 * req is pulled out of ci_req->queue, then the IN/OUT setting
-		 * may have been changed since the req was queued, and state
-		 * will get out of sync. This condition doesn't occur today,
-		 * but could if bugs were introduced later, and this error
-		 * check will save a lot of debugging time.
-		 */
-		printf("%s: ep0 transaction already in progress\n", __func__);
-		return -EPROTO;
-	}
-
-	ret = ci_bounce(ci_req, in);
-	if (ret)
-		return ret;
-
-	DBG("ept%d %s pre-queue req %p, buffer %p\n",
-	    num, in ? "in" : "out", ci_req, ci_req->hw_buf);
-	list_add_tail(&ci_req->queue, &ci_ep->queue);
-
-	if (!ci_ep->req_primed)
-		ci_ep_submit_next_request(ci_ep);
-
-	return 0;
-}
-
 static void flip_ep0_direction(void)
 {
 	if (ep0_desc.bEndpointAddress == USB_DIR_IN) {
@@ -983,149 +707,6 @@ static int ci_pullup(struct usb_gadget *gadget, int is_on)
 	return 0;
 }
 
-static int ci_udc_probe(void)
-{
-	struct ept_queue_head *head;
-	int i;
-
-	const int num = 2 * NUM_ENDPOINTS;
-
-	const int eplist_min_align = 4096;
-	const int eplist_align = roundup(eplist_min_align, ARCH_DMA_MINALIGN);
-	const int eplist_raw_sz = num * sizeof(struct ept_queue_head);
-	const int eplist_sz = roundup(eplist_raw_sz, ARCH_DMA_MINALIGN);
-
-	/* The QH list must be aligned to 4096 bytes. */
-	controller.epts = memalign(eplist_align, eplist_sz);
-	if (!controller.epts)
-		return -ENOMEM;
-	memset(controller.epts, 0, eplist_sz);
-
-	controller.items_mem = memalign(ILIST_ALIGN, ILIST_SZ);
-	if (!controller.items_mem) {
-		free(controller.epts);
-		return -ENOMEM;
-	}
-	memset(controller.items_mem, 0, ILIST_SZ);
-
-	for (i = 0; i < 2 * NUM_ENDPOINTS; i++) {
-		/*
-		 * Configure QH for each endpoint. The structure of the QH list
-		 * is such that each two subsequent fields, N and N+1 where N is
-		 * even, in the QH list represent QH for one endpoint. The Nth
-		 * entry represents OUT configuration and the N+1th entry does
-		 * represent IN configuration of the endpoint.
-		 */
-		head = controller.epts + i;
-		if (i < 2)
-			head->config = CFG_MAX_PKT(EP0_MAX_PACKET_SIZE)
-				| CFG_ZLT | CFG_IOS;
-		else
-			head->config = CFG_MAX_PKT(EP_MAX_PACKET_SIZE)
-				| CFG_ZLT;
-		head->next = TERMINATE;
-		head->info = 0;
-
-		if (i & 1) {
-			ci_flush_qh(i / 2);
-			ci_flush_qtd(i / 2);
-		}
-	}
-
-	INIT_LIST_HEAD(&controller.gadget.ep_list);
-
-	/* Init EP 0 */
-	memcpy(&controller.ep[0].ep, &ci_ep_init[0], sizeof(*ci_ep_init));
-	controller.ep[0].desc = &ep0_desc;
-	INIT_LIST_HEAD(&controller.ep[0].queue);
-	controller.ep[0].req_primed = false;
-	controller.gadget.ep0 = &controller.ep[0].ep;
-	INIT_LIST_HEAD(&controller.gadget.ep0->ep_list);
-
-	/* Init EP 1..3 */
-	for (i = 1; i < 4; i++) {
-		memcpy(&controller.ep[i].ep, &ci_ep_init[i],
-		       sizeof(*ci_ep_init));
-		INIT_LIST_HEAD(&controller.ep[i].queue);
-		controller.ep[i].req_primed = false;
-		list_add_tail(&controller.ep[i].ep.ep_list,
-			      &controller.gadget.ep_list);
-	}
-
-	/* Init EP 4..n */
-	for (i = 4; i < NUM_ENDPOINTS; i++) {
-		memcpy(&controller.ep[i].ep, &ci_ep_init[4],
-		       sizeof(*ci_ep_init));
-		INIT_LIST_HEAD(&controller.ep[i].queue);
-		controller.ep[i].req_primed = false;
-		list_add_tail(&controller.ep[i].ep.ep_list,
-			      &controller.gadget.ep_list);
-	}
-
-	ci_ep_alloc_request(&controller.ep[0].ep, 0);
-	if (!controller.ep0_req) {
-		free(controller.items_mem);
-		free(controller.epts);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	int ret;
-
-	if (!driver)
-		return -EINVAL;
-	if (!driver->bind || !driver->setup || !driver->disconnect)
-		return -EINVAL;
-
-#if CONFIG_IS_ENABLED(DM_USB)
-	ret = usb_setup_ehci_gadget(&controller.ctrl);
-#else
-	ret = usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl);
-#endif
-	if (ret)
-		return ret;
-
-	ret = ci_udc_probe();
-	if (ret) {
-		DBG("udc probe failed, returned %d\n", ret);
-		return ret;
-	}
-
-	ret = driver->bind(&controller.gadget);
-	if (ret) {
-		DBG("driver->bind() returned %d\n", ret);
-		return ret;
-	}
-	controller.driver = driver;
-
-	return 0;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	udc_disconnect();
-
-	driver->unbind(&controller.gadget);
-	controller.driver = NULL;
-
-	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
-	free(controller.items_mem);
-	free(controller.epts);
-
-#if CONFIG_IS_ENABLED(DM_USB)
-	usb_remove_ehci_gadget(&controller.ctrl);
-#else
-	usb_lowlevel_stop(0);
-	controller.ctrl = NULL;
-#endif
-
-	return 0;
-}
-
 bool dfu_usb_get_reset(void)
 {
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 04b85419931e..060788419553 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -833,7 +833,7 @@ static int bos_desc(struct usb_composite_dev *cdev)
 
 		/* Get Controller configuration */
 		if (cdev->gadget->ops->get_config_params) {
-			cdev->gadget->ops->get_config_params(
+			cdev->gadget->ops->get_config_params(cdev->gadget,
 				&dcd_config_params);
 		} else {
 			dcd_config_params.bU1devExitLat =
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 40393141ca95..98a3b59cfa91 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -113,9 +113,6 @@ static void dwc2_handle_ep0(struct dwc2_udc *dev);
 static int dwc2_ep0_write(struct dwc2_udc *dev);
 static int write_fifo_ep0(struct dwc2_ep *ep, struct dwc2_request *req);
 static void done(struct dwc2_ep *ep, struct dwc2_request *req, int status);
-static void stop_activity(struct dwc2_udc *dev,
-			  struct usb_gadget_driver *driver);
-static int udc_enable(struct dwc2_udc *dev);
 static void udc_set_address(struct dwc2_udc *dev, unsigned char address);
 static void reconfig_usbd(struct dwc2_udc *dev);
 static void set_max_pktsize(struct dwc2_udc *dev, enum usb_device_speed speed);
@@ -170,22 +167,6 @@ __weak void otg_phy_off(struct dwc2_udc *dev) {}
 
 #include "dwc2_udc_otg_xfer_dma.c"
 
-/*
- *	udc_disable - disable USB device controller
- */
-static void udc_disable(struct dwc2_udc *dev)
-{
-	debug_cond(DEBUG_SETUP != 0, "%s: %p\n", __func__, dev);
-
-	udc_set_address(dev, 0);
-
-	dev->ep0state = WAIT_FOR_SETUP;
-	dev->gadget.speed = USB_SPEED_UNKNOWN;
-	dev->usb_address = 0;
-
-	otg_phy_off(dev);
-}
-
 /*
  *	udc_reinit - initialize software state
  */
@@ -219,6 +200,18 @@ static void udc_reinit(struct dwc2_udc *dev)
 #define BYTES2MAXP(x)	(x / 8)
 #define MAXP2BYTES(x)	(x * 8)
 
+static int dwc2_gadget_pullup(struct usb_gadget *g, int is_on)
+{
+	clrsetbits_le32(&reg->device_regs.dctl, DCTL_SFTDISCON,
+			is_on ? 0 : DCTL_SFTDISCON);
+
+	return 0;
+}
+
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+
+#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
+
 /* until it's enabled, this UDC should be completely invisible
  * to any USB host.
  */
@@ -238,89 +231,6 @@ static int udc_enable(struct dwc2_udc *dev)
 	return 0;
 }
 
-static int dwc2_gadget_pullup(struct usb_gadget *g, int is_on)
-{
-	clrsetbits_le32(&reg->device_regs.dctl, DCTL_SFTDISCON,
-			is_on ? 0 : DCTL_SFTDISCON);
-
-	return 0;
-}
-
-#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
-/*
-  Register entry point for the peripheral controller driver.
-*/
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	struct dwc2_udc *dev = the_controller;
-	int retval = 0;
-	unsigned long flags = 0;
-
-	debug_cond(DEBUG_SETUP != 0, "%s: %s\n", __func__, "no name");
-
-	if (!driver || driver->speed < USB_SPEED_FULL
-	    || !driver->bind || !driver->disconnect || !driver->setup)
-		return -EINVAL;
-	if (!dev)
-		return -ENODEV;
-	if (dev->driver)
-		return -EBUSY;
-
-	spin_lock_irqsave(&dev->lock, flags);
-	/* first hook up the driver ... */
-	dev->driver = driver;
-	spin_unlock_irqrestore(&dev->lock, flags);
-
-	if (retval) { /* TODO */
-		printf("target device_add failed, error %d\n", retval);
-		return retval;
-	}
-
-	retval = driver->bind(&dev->gadget);
-	if (retval) {
-		debug_cond(DEBUG_SETUP != 0,
-			   "%s: bind to driver --> error %d\n",
-			    dev->gadget.name, retval);
-		dev->driver = 0;
-		return retval;
-	}
-
-	enable_irq(IRQ_OTG);
-
-	debug_cond(DEBUG_SETUP != 0,
-		   "Registered gadget driver %s\n", dev->gadget.name);
-	udc_enable(dev);
-
-	return 0;
-}
-
-/*
- * Unregister entry point for the peripheral controller driver.
- */
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	struct dwc2_udc *dev = the_controller;
-	unsigned long flags = 0;
-
-	if (!dev)
-		return -ENODEV;
-	if (!driver || driver != dev->driver)
-		return -EINVAL;
-
-	spin_lock_irqsave(&dev->lock, flags);
-	dev->driver = 0;
-	stop_activity(dev, driver);
-	spin_unlock_irqrestore(&dev->lock, flags);
-
-	driver->unbind(&dev->gadget);
-
-	disable_irq(IRQ_OTG);
-
-	udc_disable(dev);
-	return 0;
-}
-#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
-
 static int dwc2_gadget_start(struct usb_gadget *g,
 			     struct usb_gadget_driver *driver)
 {
@@ -346,6 +256,50 @@ static int dwc2_gadget_start(struct usb_gadget *g,
 	return udc_enable(dev);
 }
 
+static void stop_activity(struct dwc2_udc *dev,
+			  struct usb_gadget_driver *driver)
+{
+	int i;
+
+	/* don't disconnect drivers more than once */
+	if (dev->gadget.speed == USB_SPEED_UNKNOWN)
+		driver = 0;
+	dev->gadget.speed = USB_SPEED_UNKNOWN;
+
+	/* prevent new request submissions, kill any outstanding requests  */
+	for (i = 0; i < DWC2_MAX_ENDPOINTS; i++) {
+		struct dwc2_ep *ep = &dev->ep[i];
+		ep->stopped = 1;
+		nuke(ep, -ESHUTDOWN);
+	}
+
+	/* report disconnect; the driver is already quiesced */
+	if (driver) {
+		spin_unlock(&dev->lock);
+		driver->disconnect(&dev->gadget);
+		spin_lock(&dev->lock);
+	}
+
+	/* re-init driver-visible data structures */
+	udc_reinit(dev);
+}
+
+/*
+ *	udc_disable - disable USB device controller
+ */
+static void udc_disable(struct dwc2_udc *dev)
+{
+	debug_cond(DEBUG_SETUP != 0, "%s: %p\n", __func__, dev);
+
+	udc_set_address(dev, 0);
+
+	dev->ep0state = WAIT_FOR_SETUP;
+	dev->gadget.speed = USB_SPEED_UNKNOWN;
+	dev->usb_address = 0;
+
+	otg_phy_off(dev);
+}
+
 static int dwc2_gadget_stop(struct usb_gadget *g)
 {
 	struct dwc2_udc *dev = the_controller;
@@ -433,34 +387,6 @@ static void nuke(struct dwc2_ep *ep, int status)
 	}
 }
 
-static void stop_activity(struct dwc2_udc *dev,
-			  struct usb_gadget_driver *driver)
-{
-	int i;
-
-	/* don't disconnect drivers more than once */
-	if (dev->gadget.speed == USB_SPEED_UNKNOWN)
-		driver = 0;
-	dev->gadget.speed = USB_SPEED_UNKNOWN;
-
-	/* prevent new request submissions, kill any outstanding requests  */
-	for (i = 0; i < DWC2_MAX_ENDPOINTS; i++) {
-		struct dwc2_ep *ep = &dev->ep[i];
-		ep->stopped = 1;
-		nuke(ep, -ESHUTDOWN);
-	}
-
-	/* report disconnect; the driver is already quiesced */
-	if (driver) {
-		spin_unlock(&dev->lock);
-		driver->disconnect(&dev->gadget);
-		spin_lock(&dev->lock);
-	}
-
-	/* re-init driver-visible data structures */
-	udc_reinit(dev);
-}
-
 static void reconfig_usbd(struct dwc2_udc *dev)
 {
 	/* 2. Soft-reset OTG Core and then unreset again. */
diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 30016b805bfd..93ea70a5d79b 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -6,9 +6,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/types.h>
-#include <linux/device.h>
 
 #include <linux/ctype.h>
 #include <linux/string.h>
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 7973927e8a7f..13a20441419d 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -925,8 +925,9 @@ set_ether_config(struct eth_dev *dev, gfp_t gfp_flags)
 		dev->status = ep_desc(gadget, &hs_status_desc,
 						&fs_status_desc);
 		dev->status_ep->driver_data = dev;
+		dev->status_ep->desc = dev->status;
 
-		result = usb_ep_enable(dev->status_ep, dev->status);
+		result = usb_ep_enable(dev->status_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->status_ep->name, result);
@@ -951,14 +952,16 @@ set_ether_config(struct eth_dev *dev, gfp_t gfp_flags)
 	 * from REMOTE_NDIS_HALT_MSG, reset from REMOTE_NDIS_RESET_MSG.
 	 */
 	if (!cdc_active(dev)) {
-		result = usb_ep_enable(dev->in_ep, dev->in);
+		dev->in_ep->desc = dev->in;
+		result = usb_ep_enable(dev->in_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->in_ep->name, result);
 			goto done;
 		}
 
-		result = usb_ep_enable(dev->out_ep, dev->out);
+		dev->out_ep->desc = dev->out;
+		result = usb_ep_enable(dev->out_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->out_ep->name, result);
@@ -1156,7 +1159,8 @@ static void issue_start_status(struct eth_dev *dev)
 	 * FIXME iff req->context != null just dequeue it
 	 */
 	usb_ep_disable(dev->status_ep);
-	usb_ep_enable(dev->status_ep, dev->status);
+	dev->status_ep->desc = dev->status;
+	usb_ep_enable(dev->status_ep);
 
 	/*
 	 * 3.8.1 says to issue first NETWORK_CONNECTION, then
@@ -1314,7 +1318,8 @@ eth_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				break;
 			if (dev->status) {
 				usb_ep_disable(dev->status_ep);
-				usb_ep_enable(dev->status_ep, dev->status);
+				dev->status_ep->desc = dev->status;
+				usb_ep_enable(dev->status_ep);
 			}
 
 			value = 0;
@@ -1333,8 +1338,10 @@ eth_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			if (wValue == 1) {
 				if (!cdc_active(dev))
 					break;
-				usb_ep_enable(dev->in_ep, dev->in);
-				usb_ep_enable(dev->out_ep, dev->out);
+				dev->in_ep->desc = dev->in;
+				usb_ep_enable(dev->in_ep);
+				dev->out_ep->desc = dev->out;
+				usb_ep_enable(dev->out_ep);
 				dev->cdc_filter = DEFAULT_FILTER;
 				if (dev->status)
 					issue_start_status(dev);
diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index 8f7256069f58..183e585da580 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -325,20 +325,20 @@ static struct usb_request *acm_start_ep(struct usb_ep *ep, void *complete_cb,
 
 static int acm_start_data(struct f_acm *f_acm, struct usb_gadget *gadget)
 {
-	const struct usb_endpoint_descriptor *d;
 	int ret;
 
 	/* EP IN */
-	d = ep_desc(gadget, &acm_hs_in_desc, &acm_fs_in_desc);
-	ret = usb_ep_enable(f_acm->ep_in, d);
+	f_acm->ep_in->desc = ep_desc(gadget, &acm_hs_in_desc, &acm_fs_in_desc);
+	ret = usb_ep_enable(f_acm->ep_in);
 	if (ret)
 		return ret;
 
 	f_acm->req_in = acm_start_ep(f_acm->ep_in, acm_tx_complete, f_acm);
 
 	/* EP OUT */
-	d = ep_desc(gadget, &acm_hs_out_desc, &acm_fs_out_desc);
-	ret = usb_ep_enable(f_acm->ep_out, d);
+	f_acm->ep_out->desc = ep_desc(gadget, &acm_hs_out_desc,
+				      &acm_fs_out_desc);
+	ret = usb_ep_enable(f_acm->ep_out);
 	if (ret)
 		return ret;
 
@@ -354,12 +354,11 @@ static int acm_start_data(struct f_acm *f_acm, struct usb_gadget *gadget)
 
 static int acm_start_ctrl(struct f_acm *f_acm, struct usb_gadget *gadget)
 {
-	const struct usb_endpoint_descriptor *d;
-
 	usb_ep_disable(f_acm->ep_notify);
 
-	d = ep_desc(gadget, &acm_hs_notify_desc, &acm_fs_notify_desc);
-	usb_ep_enable(f_acm->ep_notify, d);
+	f_acm->ep_notify->desc = ep_desc(gadget, &acm_hs_notify_desc,
+					 &acm_fs_notify_desc);
+	usb_ep_enable(f_acm->ep_notify);
 
 	acm_start_ep(f_acm->ep_notify, acm_notify_complete, f_acm);
 
@@ -454,6 +453,9 @@ static void acm_disable(struct usb_function *f)
 	usb_ep_disable(f_acm->ep_out);
 	usb_ep_disable(f_acm->ep_in);
 	usb_ep_disable(f_acm->ep_notify);
+	f_acm->ep_out->desc = NULL;
+	f_acm->ep_in->desc = NULL;
+	f_acm->ep_notify->desc = NULL;
 
 	if (f_acm->req_out) {
 		free(f_acm->req_out->buf);
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 8df0e3f331d1..e1eed5fa4cb4 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -320,13 +320,13 @@ static int fastboot_set_alt(struct usb_function *f,
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct f_fastboot *f_fb = func_to_fastboot(f);
-	const struct usb_endpoint_descriptor *d;
 
 	debug("%s: func: %s intf: %d alt: %d\n",
 	      __func__, f->name, interface, alt);
 
-	d = fb_ep_desc(gadget, &fs_ep_out, &hs_ep_out, &ss_ep_out);
-	ret = usb_ep_enable(f_fb->out_ep, d);
+	f_fb->out_ep->desc = fb_ep_desc(gadget, &fs_ep_out, &hs_ep_out,
+					&ss_ep_out);
+	ret = usb_ep_enable(f_fb->out_ep);
 	if (ret) {
 		puts("failed to enable out ep\n");
 		return ret;
@@ -340,8 +340,8 @@ static int fastboot_set_alt(struct usb_function *f,
 	}
 	f_fb->out_req->complete = rx_handler_command;
 
-	d = fb_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
-	ret = usb_ep_enable(f_fb->in_ep, d);
+	f_fb->in_ep->desc = fb_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
+	ret = usb_ep_enable(f_fb->in_ep);
 	if (ret) {
 		puts("failed to enable in ep\n");
 		goto err;
diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 71dc58da3f03..350331cfb01c 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2158,7 +2158,8 @@ static int enable_endpoint(struct fsg_common *common, struct usb_ep *ep,
 	int	rc;
 
 	ep->driver_data = common;
-	rc = usb_ep_enable(ep, d);
+	ep->desc = d;
+	rc = usb_ep_enable(ep);
 	if (rc)
 		ERROR(common, "can't enable %s, result %d\n", ep->name, rc);
 	return rc;
@@ -2205,10 +2206,12 @@ reset:
 		/* Disable the endpoints */
 		if (fsg->bulk_in_enabled) {
 			usb_ep_disable(fsg->bulk_in);
+			fsg->bulk_in->desc = NULL;
 			fsg->bulk_in_enabled = 0;
 		}
 		if (fsg->bulk_out_enabled) {
 			usb_ep_disable(fsg->bulk_out);
+			fsg->bulk_out->desc = NULL;
 			fsg->bulk_out_enabled = 0;
 		}
 
diff --git a/drivers/usb/gadget/f_rockusb.c b/drivers/usb/gadget/f_rockusb.c
index d679cdae97c8..37957b202f8c 100644
--- a/drivers/usb/gadget/f_rockusb.c
+++ b/drivers/usb/gadget/f_rockusb.c
@@ -202,6 +202,8 @@ static void rockusb_disable(struct usb_function *f)
 
 	usb_ep_disable(f_rkusb->out_ep);
 	usb_ep_disable(f_rkusb->in_ep);
+	f_rkusb->out_ep->desc = NULL;
+	f_rkusb->in_ep->desc = NULL;
 
 	if (f_rkusb->out_req) {
 		free(f_rkusb->out_req->buf);
@@ -246,13 +248,12 @@ static int rockusb_set_alt(struct usb_function *f, unsigned int interface,
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct f_rockusb *f_rkusb = func_to_rockusb(f);
-	const struct usb_endpoint_descriptor *d;
 
 	debug("%s: func: %s intf: %d alt: %d\n",
 	      __func__, f->name, interface, alt);
 
-	d = rkusb_ep_desc(gadget, &fs_ep_out, &hs_ep_out);
-	ret = usb_ep_enable(f_rkusb->out_ep, d);
+	f_rkusb->out_ep->desc = rkusb_ep_desc(gadget, &fs_ep_out, &hs_ep_out);
+	ret = usb_ep_enable(f_rkusb->out_ep);
 	if (ret) {
 		printf("failed to enable out ep\n");
 		return ret;
@@ -266,8 +267,8 @@ static int rockusb_set_alt(struct usb_function *f, unsigned int interface,
 	}
 	f_rkusb->out_req->complete = rx_handler_command;
 
-	d = rkusb_ep_desc(gadget, &fs_ep_in, &hs_ep_in);
-	ret = usb_ep_enable(f_rkusb->in_ep, d);
+	f_rkusb->in_ep->desc = rkusb_ep_desc(gadget, &fs_ep_in, &hs_ep_in);
+	ret = usb_ep_enable(f_rkusb->in_ep);
 	if (ret) {
 		printf("failed to enable in ep\n");
 		goto err;
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 647001d8dd0c..4624b88632fb 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -624,12 +624,14 @@ static int sdp_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	debug("%s: intf: %d alt: %d\n", __func__, intf, alt);
 
 	if (gadget_is_dualspeed(gadget) && gadget->speed == USB_SPEED_HIGH) {
-		result = usb_ep_enable(sdp->in_ep, &in_hs_desc);
-		result |= usb_ep_enable(sdp->out_ep, &out_hs_desc);
+		sdp->in_ep->desc = &in_hs_desc;
+		sdp->out_ep->desc = &out_hs_desc;
 	} else {
-		result = usb_ep_enable(sdp->in_ep, &in_desc);
-		result |= usb_ep_enable(sdp->out_ep, &out_desc);
+		sdp->in_ep->desc = &in_hs_desc;
+		sdp->out_ep->desc = &out_hs_desc;
 	}
+	result = usb_ep_enable(sdp->in_ep);
+	result |= usb_ep_enable(sdp->out_ep);
 	if (result)
 		return result;
 
@@ -661,6 +663,8 @@ static void sdp_disable(struct usb_function *f)
 
 	usb_ep_disable(sdp->in_ep);
 	usb_ep_disable(sdp->out_ep);
+	sdp->in_ep->desc = NULL;
+	sdp->out_ep->desc = NULL;
 
 	if (sdp->in_req) {
 		free(sdp->in_req->buf);
diff --git a/drivers/usb/gadget/f_thor.c b/drivers/usb/gadget/f_thor.c
index 540b9f882378..210537d51e92 100644
--- a/drivers/usb/gadget/f_thor.c
+++ b/drivers/usb/gadget/f_thor.c
@@ -909,16 +909,15 @@ static int thor_eps_setup(struct usb_function *f)
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct thor_dev *dev = thor_func->dev;
-	struct usb_endpoint_descriptor *d;
 	struct usb_request *req;
 	struct usb_ep *ep;
 	int result;
 
 	ep = dev->in_ep;
-	d = ep_desc(gadget, &hs_in_desc, &fs_in_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_in_desc, &fs_in_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err;
 
@@ -933,10 +932,10 @@ static int thor_eps_setup(struct usb_function *f)
 	req->complete = thor_rx_tx_complete;
 	dev->in_req = req;
 	ep = dev->out_ep;
-	d = ep_desc(gadget, &hs_out_desc, &fs_out_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_out_desc, &fs_out_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err_free_in_req;
 
@@ -951,10 +950,10 @@ static int thor_eps_setup(struct usb_function *f)
 	dev->out_req = req;
 	/* ACM control EP */
 	ep = dev->int_ep;
-	d = ep_desc(gadget, &hs_int_desc, &fs_int_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_int_desc, &fs_int_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err;
 
diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
index 56b9b123fa16..f80ae6e5add5 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_USB_DWC3_GADGET)	+= udc-core.o
 endif
 
 obj-$(CONFIG_$(PHASE_)DM_USB_GADGET)	+= udc-core.o
+obj-$(CONFIG_$(PHASE_)USB_GADGET)	+= udc-core.o
 obj-y += udc-uclass.o
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index d709e24c1fd4..b5ef7f1131cc 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -6,27 +6,17 @@
  * Author: Felipe Balbi <balbi@ti.com>
  */
 
-#define pr_fmt(fmt)	"UDC core: " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/idr.h>
-#include <linux/err.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/compat.h>
+#include <malloc.h>
+#include <asm/cache.h>
+#include <linux/bug.h>
 #include <linux/dma-mapping.h>
-#include <linux/sched/task_stack.h>
-#include <linux/workqueue.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/usb.h>
-
-#include "trace.h"
-
-static DEFINE_IDA(gadget_id_numbers);
-
-static const struct bus_type gadget_bus_type;
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -40,7 +30,6 @@ static const struct bus_type gadget_bus_type;
  * @allow_connect: Indicates whether UDC is allowed to be pulled up.
  * Set/cleared by gadget_(un)bind_driver() after gadget driver is bound or
  * unbound.
- * @vbus_work: work routine to handle VBUS status change notifications.
  * @connect_lock: protects udc->started, gadget->connect,
  * gadget->allow_connect and gadget->deactivate. The routines
  * usb_gadget_connect_locked(), usb_gadget_disconnect_locked(),
@@ -58,15 +47,13 @@ struct usb_udc {
 	bool				vbus;
 	bool				started;
 	bool				allow_connect;
-	struct work_struct		vbus_work;
 	struct mutex			connect_lock;
 };
 
-static const struct class udc_class;
 static LIST_HEAD(udc_list);
 
 /* Protects udc_list, udc->driver, driver->is_bound, and related calls */
-static DEFINE_MUTEX(udc_lock);
+DEFINE_MUTEX(udc_lock);
 
 /* ------------------------------------------------------------------------- */
 
@@ -83,8 +70,6 @@ void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
 {
 	ep->maxpacket_limit = maxpacket_limit;
 	ep->maxpacket = maxpacket_limit;
-
-	trace_usb_ep_set_maxpacket_limit(ep, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_set_maxpacket_limit);
 
@@ -133,8 +118,6 @@ int usb_ep_enable(struct usb_ep *ep)
 	ep->enabled = true;
 
 out:
-	trace_usb_ep_enable(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_enable);
@@ -167,8 +150,6 @@ int usb_ep_disable(struct usb_ep *ep)
 	ep->enabled = false;
 
 out:
-	trace_usb_ep_disable(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_disable);
@@ -190,13 +171,7 @@ EXPORT_SYMBOL_GPL(usb_ep_disable);
 struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
 						       gfp_t gfp_flags)
 {
-	struct usb_request *req = NULL;
-
-	req = ep->ops->alloc_request(ep, gfp_flags);
-
-	trace_usb_ep_alloc_request(ep, req, req ? 0 : -ENOMEM);
-
-	return req;
+	return  ep->ops->alloc_request(ep, gfp_flags);
 }
 EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
 
@@ -212,7 +187,6 @@ EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
 void usb_ep_free_request(struct usb_ep *ep,
 				       struct usb_request *req)
 {
-	trace_usb_ep_free_request(ep, req, 0);
 	ep->ops->free_request(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_ep_free_request);
@@ -300,8 +274,6 @@ int usb_ep_queue(struct usb_ep *ep,
 	ret = ep->ops->queue(ep, req, gfp_flags);
 
 out:
-	trace_usb_ep_queue(ep, req, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_queue);
@@ -325,12 +297,7 @@ EXPORT_SYMBOL_GPL(usb_ep_queue);
  */
 int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 {
-	int ret;
-
-	ret = ep->ops->dequeue(ep, req);
-	trace_usb_ep_dequeue(ep, req, ret);
-
-	return ret;
+	return ep->ops->dequeue(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_ep_dequeue);
 
@@ -359,12 +326,7 @@ EXPORT_SYMBOL_GPL(usb_ep_dequeue);
  */
 int usb_ep_set_halt(struct usb_ep *ep)
 {
-	int ret;
-
-	ret = ep->ops->set_halt(ep, 1);
-	trace_usb_ep_set_halt(ep, ret);
-
-	return ret;
+	return ep->ops->set_halt(ep, 1);
 }
 EXPORT_SYMBOL_GPL(usb_ep_set_halt);
 
@@ -385,12 +347,7 @@ EXPORT_SYMBOL_GPL(usb_ep_set_halt);
  */
 int usb_ep_clear_halt(struct usb_ep *ep)
 {
-	int ret;
-
-	ret = ep->ops->set_halt(ep, 0);
-	trace_usb_ep_clear_halt(ep, ret);
-
-	return ret;
+	return ep->ops->set_halt(ep, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_clear_halt);
 
@@ -415,8 +372,6 @@ int usb_ep_set_wedge(struct usb_ep *ep)
 	else
 		ret = ep->ops->set_halt(ep, 1);
 
-	trace_usb_ep_set_wedge(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_set_wedge);
@@ -447,8 +402,6 @@ int usb_ep_fifo_status(struct usb_ep *ep)
 	else
 		ret = -EOPNOTSUPP;
 
-	trace_usb_ep_fifo_status(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_fifo_status);
@@ -468,8 +421,6 @@ void usb_ep_fifo_flush(struct usb_ep *ep)
 {
 	if (ep->ops->fifo_flush)
 		ep->ops->fifo_flush(ep);
-
-	trace_usb_ep_fifo_flush(ep, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
 
@@ -484,13 +435,8 @@ EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
  */
 int usb_gadget_frame_number(struct usb_gadget *gadget)
 {
-	int ret;
 
-	ret = gadget->ops->get_frame(gadget);
-
-	trace_usb_gadget_frame_number(gadget, ret);
-
-	return ret;
+	return gadget->ops->get_frame(gadget);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_frame_number);
 
@@ -519,39 +465,10 @@ int usb_gadget_wakeup(struct usb_gadget *gadget)
 	ret = gadget->ops->wakeup(gadget);
 
 out:
-	trace_usb_gadget_wakeup(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_wakeup);
 
-/**
- * usb_gadget_set_remote_wakeup - configures the device remote wakeup feature.
- * @gadget:the device being configured for remote wakeup
- * @set:value to be configured.
- *
- * set to one to enable remote wakeup feature and zero to disable it.
- *
- * returns zero on success, else negative errno.
- */
-int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set)
-{
-	int ret = 0;
-
-	if (!gadget->ops->set_remote_wakeup) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->set_remote_wakeup(gadget, set);
-
-out:
-	trace_usb_gadget_set_remote_wakeup(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_set_remote_wakeup);
-
 /**
  * usb_gadget_set_selfpowered - sets the device selfpowered feature.
  * @gadget:the device being declared as self-powered
@@ -573,8 +490,6 @@ int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
 	ret = gadget->ops->set_selfpowered(gadget, 1);
 
 out:
-	trace_usb_gadget_set_selfpowered(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_selfpowered);
@@ -601,43 +516,10 @@ int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
 	ret = gadget->ops->set_selfpowered(gadget, 0);
 
 out:
-	trace_usb_gadget_clear_selfpowered(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_clear_selfpowered);
 
-/**
- * usb_gadget_vbus_connect - Notify controller that VBUS is powered
- * @gadget:The device which now has VBUS power.
- * Context: can sleep
- *
- * This call is used by a driver for an external transceiver (or GPIO)
- * that detects a VBUS power session starting.  Common responses include
- * resuming the controller, activating the D+ (or D-) pullup to let the
- * host detect that a USB device is attached, and starting to draw power
- * (8mA or possibly more, especially after SET_CONFIGURATION).
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_vbus_connect(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	if (!gadget->ops->vbus_session) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->vbus_session(gadget, 1);
-
-out:
-	trace_usb_gadget_vbus_connect(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
-
 /**
  * usb_gadget_vbus_draw - constrain controller's VBUS power usage
  * @gadget:The device whose VBUS usage is being described
@@ -652,21 +534,10 @@ EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
  */
 int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
-	int ret = 0;
+	if (!gadget->ops->vbus_draw)
+		return -EOPNOTSUPP;
 
-	if (!gadget->ops->vbus_draw) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->vbus_draw(gadget, mA);
-	if (!ret)
-		gadget->mA = mA;
-
-out:
-	trace_usb_gadget_vbus_draw(gadget, ret);
-
-	return ret;
+	return gadget->ops->vbus_draw(gadget, mA);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_draw);
 
@@ -693,41 +564,37 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
 	ret = gadget->ops->vbus_session(gadget, 0);
 
 out:
-	trace_usb_gadget_vbus_disconnect(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
 
 static int usb_gadget_connect_locked(struct usb_gadget *gadget)
-	__must_hold(&gadget->udc->connect_lock)
+        __must_hold(&gadget->udc->connect_lock)
 {
-	int ret = 0;
+        int ret = 0;
 
-	if (!gadget->ops->pullup) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
+        if (!gadget->ops->pullup) {
+                ret = -EOPNOTSUPP;
+                goto out;
+        }
 
-	if (gadget->deactivated || !gadget->udc->allow_connect || !gadget->udc->started) {
-		/*
-		 * If the gadget isn't usable (because it is deactivated,
-		 * unbound, or not yet started), we only save the new state.
-		 * The gadget will be connected automatically when it is
-		 * activated/bound/started.
-		 */
-		gadget->connected = true;
-		goto out;
-	}
+        if (gadget->deactivated || !gadget->udc->allow_connect || !gadget->udc->started) {
+                /*
+                 * If the gadget isn't usable (because it is deactivated,
+                 * unbound, or not yet started), we only save the new state.
+                 * The gadget will be connected automatically when it is
+                 * activated/bound/started.
+                 */
+                gadget->connected = true;
+                goto out;
+        }
 
-	ret = gadget->ops->pullup(gadget, 1);
-	if (!ret)
-		gadget->connected = 1;
+        ret = gadget->ops->pullup(gadget, 1);
+        if (!ret)
+                gadget->connected = 1;
 
 out:
-	trace_usb_gadget_connect(gadget, ret);
-
-	return ret;
+        return ret;
 }
 
 /**
@@ -742,51 +609,49 @@ out:
  */
 int usb_gadget_connect(struct usb_gadget *gadget)
 {
-	int ret;
+        int ret;
 
-	mutex_lock(&gadget->udc->connect_lock);
-	ret = usb_gadget_connect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
+        mutex_lock(&gadget->udc->connect_lock);
+        ret = usb_gadget_connect_locked(gadget);
+        mutex_unlock(&gadget->udc->connect_lock);
 
-	return ret;
+        return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_connect);
 
 static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
-	__must_hold(&gadget->udc->connect_lock)
+        __must_hold(&gadget->udc->connect_lock)
 {
-	int ret = 0;
+        int ret = 0;
 
-	if (!gadget->ops->pullup) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
+        if (!gadget->ops->pullup) {
+                ret = -EOPNOTSUPP;
+                goto out;
+        }
 
-	if (!gadget->connected)
-		goto out;
+        if (!gadget->connected)
+                goto out;
 
-	if (gadget->deactivated || !gadget->udc->started) {
-		/*
-		 * If gadget is deactivated we only save new state.
-		 * Gadget will stay disconnected after activation.
-		 */
-		gadget->connected = false;
-		goto out;
-	}
+        if (gadget->deactivated || !gadget->udc->started) {
+                /*
+                 * If gadget is deactivated we only save new state.
+                 * Gadget will stay disconnected after activation.
+                 */
+                gadget->connected = false;
+                goto out;
+        }
 
-	ret = gadget->ops->pullup(gadget, 0);
-	if (!ret)
-		gadget->connected = 0;
+        ret = gadget->ops->pullup(gadget, 0);
+        if (!ret)
+                gadget->connected = 0;
 
-	mutex_lock(&udc_lock);
-	if (gadget->udc->driver)
-		gadget->udc->driver->disconnect(gadget);
-	mutex_unlock(&udc_lock);
+        mutex_lock(&udc_lock);
+        if (gadget->udc->driver)
+                gadget->udc->driver->disconnect(gadget);
+        mutex_unlock(&udc_lock);
 
 out:
-	trace_usb_gadget_disconnect(gadget, ret);
-
-	return ret;
+        return ret;
 }
 
 /**
@@ -804,180 +669,41 @@ out:
  */
 int usb_gadget_disconnect(struct usb_gadget *gadget)
 {
-	int ret;
+        int ret;
 
-	mutex_lock(&gadget->udc->connect_lock);
-	ret = usb_gadget_disconnect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
+        mutex_lock(&gadget->udc->connect_lock);
+        ret = usb_gadget_disconnect_locked(gadget);
+        mutex_unlock(&gadget->udc->connect_lock);
 
-	return ret;
+        return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
 
-/**
- * usb_gadget_deactivate - deactivate function which is not ready to work
- * @gadget: the peripheral being deactivated
- *
- * This routine may be used during the gadget driver bind() call to prevent
- * the peripheral from ever being visible to the USB host, unless later
- * usb_gadget_activate() is called.  For example, user mode components may
- * need to be activated before the system can talk to hosts.
- *
- * This routine may sleep; it must not be called in interrupt context
- * (such as from within a gadget driver's disconnect() callback).
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_deactivate(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	if (gadget->deactivated)
-		goto unlock;
-
-	if (gadget->connected) {
-		ret = usb_gadget_disconnect_locked(gadget);
-		if (ret)
-			goto unlock;
-
-		/*
-		 * If gadget was being connected before deactivation, we want
-		 * to reconnect it in usb_gadget_activate().
-		 */
-		gadget->connected = true;
-	}
-	gadget->deactivated = true;
-
-unlock:
-	mutex_unlock(&gadget->udc->connect_lock);
-	trace_usb_gadget_deactivate(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_deactivate);
-
-/**
- * usb_gadget_activate - activate function which is not ready to work
- * @gadget: the peripheral being activated
- *
- * This routine activates gadget which was previously deactivated with
- * usb_gadget_deactivate() call. It calls usb_gadget_connect() if needed.
- *
- * This routine may sleep; it must not be called in interrupt context.
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_activate(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	if (!gadget->deactivated)
-		goto unlock;
-
-	gadget->deactivated = false;
-
-	/*
-	 * If gadget has been connected before deactivation, or became connected
-	 * while it was being deactivated, we call usb_gadget_connect().
-	 */
-	if (gadget->connected)
-		ret = usb_gadget_connect_locked(gadget);
-
-unlock:
-	mutex_unlock(&gadget->udc->connect_lock);
-	trace_usb_gadget_activate(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_activate);
-
 /* ------------------------------------------------------------------------- */
 
-#ifdef	CONFIG_HAS_DMA
-
-int usb_gadget_map_request_by_dev(struct device *dev,
-		struct usb_request *req, int is_in)
-{
-	if (req->length == 0)
-		return 0;
-
-	if (req->sg_was_mapped) {
-		req->num_mapped_sgs = req->num_sgs;
-		return 0;
-	}
-
-	if (req->num_sgs) {
-		int     mapped;
-
-		mapped = dma_map_sg(dev, req->sg, req->num_sgs,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		if (mapped == 0) {
-			dev_err(dev, "failed to map SGs\n");
-			return -EFAULT;
-		}
-
-		req->num_mapped_sgs = mapped;
-	} else {
-		if (is_vmalloc_addr(req->buf)) {
-			dev_err(dev, "buffer is not dma capable\n");
-			return -EFAULT;
-		} else if (object_is_on_stack(req->buf)) {
-			dev_err(dev, "buffer is on stack\n");
-			return -EFAULT;
-		}
-
-		req->dma = dma_map_single(dev, req->buf, req->length,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
-		if (dma_mapping_error(dev, req->dma)) {
-			dev_err(dev, "failed to map buffer\n");
-			return -EFAULT;
-		}
-
-		req->dma_mapped = 1;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_map_request_by_dev);
-
 int usb_gadget_map_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in)
 {
-	return usb_gadget_map_request_by_dev(gadget->dev.parent, req, is_in);
+	if (req->length == 0)
+		return 0;
+
+	req->dma = dma_map_single(req->buf, req->length,
+				  is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_map_request);
 
-void usb_gadget_unmap_request_by_dev(struct device *dev,
-		struct usb_request *req, int is_in)
-{
-	if (req->length == 0 || req->sg_was_mapped)
-		return;
-
-	if (req->num_mapped_sgs) {
-		dma_unmap_sg(dev, req->sg, req->num_sgs,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
-		req->num_mapped_sgs = 0;
-	} else if (req->dma_mapped) {
-		dma_unmap_single(dev, req->dma, req->length,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		req->dma_mapped = 0;
-	}
-}
-EXPORT_SYMBOL_GPL(usb_gadget_unmap_request_by_dev);
-
 void usb_gadget_unmap_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in)
 {
-	usb_gadget_unmap_request_by_dev(gadget->dev.parent, req, is_in);
+	if (req->length == 0)
+		return;
+
+	dma_unmap_single(req->dma, req->length,
+			 is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 
-#endif	/* CONFIG_HAS_DMA */
-
 /* ------------------------------------------------------------------------- */
 
 /**
@@ -991,11 +717,6 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 void usb_gadget_giveback_request(struct usb_ep *ep,
 		struct usb_request *req)
 {
-	if (likely(req->status == 0))
-		usb_led_activity(USB_LED_EVENT_GADGET);
-
-	trace_usb_gadget_giveback_request(ep, req, 0);
-
 	req->complete(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
@@ -1111,71 +832,13 @@ EXPORT_SYMBOL_GPL(usb_gadget_check_config);
 
 /* ------------------------------------------------------------------------- */
 
-static void usb_gadget_state_work(struct work_struct *work)
-{
-	struct usb_gadget *gadget = work_to_gadget(work);
-	struct usb_udc *udc = gadget->udc;
-
-	if (udc)
-		sysfs_notify(&udc->dev.kobj, NULL, "state");
-}
-
 void usb_gadget_set_state(struct usb_gadget *gadget,
 		enum usb_device_state state)
 {
 	gadget->state = state;
-	schedule_work(&gadget->work);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
-/* ------------------------------------------------------------------------- */
-
-/* Acquire connect_lock before calling this function. */
-static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
-{
-	if (udc->vbus)
-		return usb_gadget_connect_locked(udc->gadget);
-	else
-		return usb_gadget_disconnect_locked(udc->gadget);
-}
-
-static void vbus_event_work(struct work_struct *work)
-{
-	struct usb_udc *udc = container_of(work, struct usb_udc, vbus_work);
-
-	mutex_lock(&udc->connect_lock);
-	usb_udc_connect_control_locked(udc);
-	mutex_unlock(&udc->connect_lock);
-}
-
-/**
- * usb_udc_vbus_handler - updates the udc core vbus status, and try to
- * connect or disconnect gadget
- * @gadget: The gadget which vbus change occurs
- * @status: The vbus status
- *
- * The udc driver calls it when it wants to connect or disconnect gadget
- * according to vbus status.
- *
- * This function can be invoked from interrupt context by irq handlers of
- * the gadget drivers, however, usb_udc_connect_control() has to run in
- * non-atomic context due to the following:
- * a. Some of the gadget driver implementations expect the ->pullup
- * callback to be invoked in non-atomic context.
- * b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
- * Hence offload invocation of usb_udc_connect_control() to workqueue.
- */
-void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
-{
-	struct usb_udc *udc = gadget->udc;
-
-	if (udc) {
-		udc->vbus = status;
-		schedule_work(&udc->vbus_work);
-	}
-}
-EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
-
 /**
  * usb_gadget_udc_reset - notifies the udc core that bus reset occurs
  * @gadget: The gadget which bus reset occurs
@@ -1277,6 +940,36 @@ static inline void usb_gadget_udc_set_speed(struct usb_udc *udc,
 		gadget->ops->udc_set_speed(gadget, s);
 }
 
+static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
+{
+        int ret;
+
+        dev_dbg(&udc->dev, "registering UDC driver [%s]\n",
+                        driver->function);
+
+        udc->driver = driver;
+
+        usb_gadget_udc_set_speed(udc, driver->speed);
+
+        ret = driver->bind(udc->gadget);
+        if (ret)
+                goto err1;
+        ret = usb_gadget_udc_start_locked(udc);
+        if (ret) {
+                driver->unbind(udc->gadget);
+                goto err1;
+        }
+        usb_gadget_connect(udc->gadget);
+
+        return 0;
+err1:
+        if (ret != -EISNAM)
+                dev_err(&udc->dev, "failed to start %s: %d\n",
+                        udc->driver->function, ret);
+        udc->driver = NULL;
+        return ret;
+}
+
 /**
  * usb_gadget_enable_async_callbacks - tell usb device controller to enable asynchronous callbacks
  * @udc: The UDC which should enable async callbacks
@@ -1336,17 +1029,9 @@ static void usb_udc_release(struct device *dev)
 	struct usb_udc *udc;
 
 	udc = container_of(dev, struct usb_udc, dev);
-	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));
 	kfree(udc);
 }
 
-static const struct attribute_group *usb_udc_attr_groups[];
-
-static void usb_udc_nop_release(struct device *dev)
-{
-	dev_vdbg(dev, "%s\n", __func__);
-}
-
 /**
  * usb_initialize_gadget - initialize a gadget and its embedded struct device
  * @parent: the parent device to this udc. Usually the controller driver's
@@ -1357,16 +1042,8 @@ static void usb_udc_nop_release(struct device *dev)
 void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
-	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
-
-	if (release)
-		gadget->dev.release = release;
-	else
-		gadget->dev.release = usb_udc_nop_release;
-
-	device_initialize(&gadget->dev);
-	gadget->dev.bus = &gadget_bus_type;
+	gadget->dev.release = release;
 }
 EXPORT_SYMBOL_GPL(usb_initialize_gadget);
 
@@ -1386,15 +1063,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	if (!udc)
 		goto error;
 
-	device_initialize(&udc->dev);
 	udc->dev.release = usb_udc_release;
-	udc->dev.class = &udc_class;
-	udc->dev.groups = usb_udc_attr_groups;
+	udc->dev.class = NULL;
 	udc->dev.parent = gadget->dev.parent;
-	ret = dev_set_name(&udc->dev, "%s",
-			kobject_name(&gadget->dev.parent->kobj));
-	if (ret)
-		goto err_put_udc;
 
 	udc->gadget = gadget;
 	gadget->udc = udc;
@@ -1405,50 +1076,11 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
 	mutex_unlock(&udc_lock);
-	INIT_WORK(&udc->vbus_work, vbus_event_work);
-
-	ret = device_add(&udc->dev);
-	if (ret)
-		goto err_unlist_udc;
 
 	usb_gadget_set_state(gadget, USB_STATE_NOTATTACHED);
-	udc->vbus = true;
-
-	ret = ida_alloc(&gadget_id_numbers, GFP_KERNEL);
-	if (ret < 0)
-		goto err_del_udc;
-	gadget->id_number = ret;
-	dev_set_name(&gadget->dev, "gadget.%d", ret);
-
-	ret = device_add(&gadget->dev);
-	if (ret)
-		goto err_free_id;
-
-	ret = sysfs_create_link(&udc->dev.kobj,
-				&gadget->dev.kobj, "gadget");
-	if (ret)
-		goto err_del_gadget;
 
 	return 0;
 
- err_del_gadget:
-	device_del(&gadget->dev);
-
- err_free_id:
-	ida_free(&gadget_id_numbers, gadget->id_number);
-
- err_del_udc:
-	flush_work(&gadget->work);
-	device_del(&udc->dev);
-
- err_unlist_udc:
-	mutex_lock(&udc_lock);
-	list_del(&udc->list);
-	mutex_unlock(&udc_lock);
-
- err_put_udc:
-	put_device(&udc->dev);
-
  error:
 	return ret;
 }
@@ -1467,13 +1099,8 @@ EXPORT_SYMBOL_GPL(usb_add_gadget);
 int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
-	int	ret;
-
 	usb_initialize_gadget(parent, gadget, release);
-	ret = usb_add_gadget(gadget);
-	if (ret)
-		usb_put_gadget(gadget);
-	return ret;
+	return usb_add_gadget(gadget);
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc_release);
 
@@ -1498,7 +1125,7 @@ char *usb_get_gadget_udc_name(void)
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list) {
 		if (!udc->driver) {
-			name = kstrdup(udc->gadget->name, GFP_KERNEL);
+			name = strdup(udc->gadget->name);
 			break;
 		}
 	}
@@ -1521,409 +1148,119 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 
-/**
- * usb_del_gadget - deletes a gadget and unregisters its udc
- * @gadget: the gadget to be deleted.
- *
- * This will unbind @gadget, if it is bound.
- * It will not do a final usb_put_gadget().
- */
-void usb_del_gadget(struct usb_gadget *gadget)
+static void usb_gadget_remove_driver(struct usb_udc *udc)
 {
-	struct usb_udc *udc = gadget->udc;
+	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
+			udc->driver->function);
 
-	if (!udc)
-		return;
+	usb_gadget_disconnect(udc->gadget);
+	udc->driver->disconnect(udc->gadget);
+	udc->driver->unbind(udc->gadget);
+	usb_gadget_udc_stop_locked(udc);
 
-	dev_vdbg(gadget->dev.parent, "unregistering gadget\n");
-
-	mutex_lock(&udc_lock);
-	list_del(&udc->list);
-	mutex_unlock(&udc_lock);
-
-	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
-	sysfs_remove_link(&udc->dev.kobj, "gadget");
-	device_del(&gadget->dev);
-	flush_work(&gadget->work);
-	ida_free(&gadget_id_numbers, gadget->id_number);
-	cancel_work_sync(&udc->vbus_work);
-	device_unregister(&udc->dev);
+	udc->driver = NULL;
 }
-EXPORT_SYMBOL_GPL(usb_del_gadget);
 
 /**
- * usb_del_gadget_udc - unregisters a gadget
- * @gadget: the gadget to be unregistered.
+ * usb_del_gadget_udc - deletes @udc from udc_list
+ * @gadget: the gadget to be removed.
  *
- * Calls usb_del_gadget() and does a final usb_put_gadget().
+ * This, will call usb_gadget_unregister_driver() if
+ * the @udc is still busy.
  */
 void usb_del_gadget_udc(struct usb_gadget *gadget)
 {
-	usb_del_gadget(gadget);
-	usb_put_gadget(gadget);
+	struct usb_udc		*udc = NULL;
+
+	mutex_lock(&udc_lock);
+	list_for_each_entry(udc, &udc_list, list)
+		if (udc->gadget == gadget)
+			goto found;
+
+	dev_err(gadget->dev.parent, "gadget not registered.\n");
+	mutex_unlock(&udc_lock);
+
+	return;
+
+found:
+	dev_vdbg(gadget->dev.parent, "unregistering gadget\n");
+
+	list_del(&udc->list);
+	mutex_unlock(&udc_lock);
+
+	if (udc->driver)
+		usb_gadget_remove_driver(udc);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 
 /* ------------------------------------------------------------------------- */
 
-static int gadget_match_driver(struct device *dev, const struct device_driver *drv)
-{
-	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
-	struct usb_udc *udc = gadget->udc;
-	const struct usb_gadget_driver *driver = container_of(drv,
-			struct usb_gadget_driver, driver);
-
-	/* If the driver specifies a udc_name, it must match the UDC's name */
-	if (driver->udc_name &&
-			strcmp(driver->udc_name, dev_name(&udc->dev)) != 0)
-		return 0;
-
-	/* If the driver is already bound to a gadget, it doesn't match */
-	if (driver->is_bound)
-		return 0;
-
-	/* Otherwise any gadget driver matches any UDC */
-	return 1;
-}
-
-static int gadget_bind_driver(struct device *dev)
-{
-	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
-	struct usb_udc *udc = gadget->udc;
-	struct usb_gadget_driver *driver = container_of(dev->driver,
-			struct usb_gadget_driver, driver);
-	int ret = 0;
-
-	mutex_lock(&udc_lock);
-	if (driver->is_bound) {
-		mutex_unlock(&udc_lock);
-		return -ENXIO;		/* Driver binds to only one gadget */
-	}
-	driver->is_bound = true;
-	udc->driver = driver;
-	mutex_unlock(&udc_lock);
-
-	dev_dbg(&udc->dev, "binding gadget driver [%s]\n", driver->function);
-
-	usb_gadget_udc_set_speed(udc, driver->max_speed);
-
-	ret = driver->bind(udc->gadget, driver);
-	if (ret)
-		goto err_bind;
-
-	mutex_lock(&udc->connect_lock);
-	ret = usb_gadget_udc_start_locked(udc);
-	if (ret) {
-		mutex_unlock(&udc->connect_lock);
-		goto err_start;
-	}
-	usb_gadget_enable_async_callbacks(udc);
-	udc->allow_connect = true;
-	ret = usb_udc_connect_control_locked(udc);
-	if (ret)
-		goto err_connect_control;
-
-	mutex_unlock(&udc->connect_lock);
-
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
-	return 0;
-
- err_connect_control:
-	udc->allow_connect = false;
-	usb_gadget_disable_async_callbacks(udc);
-	if (gadget->irq)
-		synchronize_irq(gadget->irq);
-	usb_gadget_udc_stop_locked(udc);
-	mutex_unlock(&udc->connect_lock);
-
- err_start:
-	driver->unbind(udc->gadget);
-
- err_bind:
-	if (ret != -EISNAM)
-		dev_err(&udc->dev, "failed to start %s: %d\n",
-			driver->function, ret);
-
-	mutex_lock(&udc_lock);
-	udc->driver = NULL;
-	driver->is_bound = false;
-	mutex_unlock(&udc_lock);
-
-	return ret;
-}
-
-static void gadget_unbind_driver(struct device *dev)
-{
-	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
-	struct usb_udc *udc = gadget->udc;
-	struct usb_gadget_driver *driver = udc->driver;
-
-	dev_dbg(&udc->dev, "unbinding gadget driver [%s]\n", driver->function);
-
-	udc->allow_connect = false;
-	cancel_work_sync(&udc->vbus_work);
-	mutex_lock(&udc->connect_lock);
-	usb_gadget_disconnect_locked(gadget);
-	usb_gadget_disable_async_callbacks(udc);
-	if (gadget->irq)
-		synchronize_irq(gadget->irq);
-	mutex_unlock(&udc->connect_lock);
-
-	udc->driver->unbind(gadget);
-
-	mutex_lock(&udc->connect_lock);
-	usb_gadget_udc_stop_locked(udc);
-	mutex_unlock(&udc->connect_lock);
-
-	mutex_lock(&udc_lock);
-	driver->is_bound = false;
-	udc->driver = NULL;
-	mutex_unlock(&udc_lock);
-
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
-}
-
-/* ------------------------------------------------------------------------- */
-
-int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
-		struct module *owner, const char *mod_name)
-{
-	int ret;
-
-	if (!driver || !driver->bind || !driver->setup)
-		return -EINVAL;
-
-	driver->driver.bus = &gadget_bus_type;
-	driver->driver.owner = owner;
-	driver->driver.mod_name = mod_name;
-	driver->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
-	ret = driver_register(&driver->driver);
-	if (ret) {
-		pr_warn("%s: driver registration failed: %d\n",
-				driver->function, ret);
-		return ret;
-	}
-
-	mutex_lock(&udc_lock);
-	if (!driver->is_bound) {
-		if (driver->match_existing_only) {
-			pr_warn("%s: couldn't find an available UDC or it's busy\n",
-					driver->function);
-			ret = -EBUSY;
-		} else {
-			pr_info("%s: couldn't find an available UDC\n",
-					driver->function);
-			ret = 0;
-		}
-	}
-	mutex_unlock(&udc_lock);
-
-	if (ret)
-		driver_unregister(&driver->driver);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_register_driver_owner);
-
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
+	struct usb_udc		*udc = NULL;
+	int			ret = -ENODEV;
+
 	if (!driver || !driver->unbind)
 		return -EINVAL;
 
-	driver_unregister(&driver->driver);
-	return 0;
+	mutex_lock(&udc_lock);
+	list_for_each_entry(udc, &udc_list, list)
+		if (udc->driver == driver) {
+			usb_gadget_remove_driver(udc);
+			usb_gadget_set_state(udc->gadget,
+					USB_STATE_NOTATTACHED);
+			ret = 0;
+			break;
+		}
+
+	mutex_unlock(&udc_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_unregister_driver);
 
 /* ------------------------------------------------------------------------- */
 
-static ssize_t srp_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t n)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-
-	if (sysfs_streq(buf, "1"))
-		usb_gadget_wakeup(udc->gadget);
-
-	return n;
-}
-static DEVICE_ATTR_WO(srp);
-
-static ssize_t soft_connect_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t n)
-{
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	ssize_t			ret;
-
-	device_lock(&udc->gadget->dev);
-	if (!udc->driver) {
-		dev_err(dev, "soft-connect without a gadget driver\n");
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	if (sysfs_streq(buf, "connect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_udc_start_locked(udc);
-		usb_gadget_connect_locked(udc->gadget);
-		mutex_unlock(&udc->connect_lock);
-	} else if (sysfs_streq(buf, "disconnect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_disconnect_locked(udc->gadget);
-		usb_gadget_udc_stop_locked(udc);
-		mutex_unlock(&udc->connect_lock);
-	} else {
-		dev_err(dev, "unsupported command '%s'\n", buf);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = n;
-out:
-	device_unlock(&udc->gadget->dev);
-	return ret;
-}
-static DEVICE_ATTR_WO(soft_connect);
-
-static ssize_t state_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
-{
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	struct usb_gadget	*gadget = udc->gadget;
-
-	return sprintf(buf, "%s\n", usb_state_string(gadget->state));
-}
-static DEVICE_ATTR_RO(state);
-
-static ssize_t function_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	struct usb_gadget_driver *drv;
-	int			rc = 0;
-
-	mutex_lock(&udc_lock);
-	drv = udc->driver;
-	if (drv && drv->function)
-		rc = scnprintf(buf, PAGE_SIZE, "%s\n", drv->function);
-	mutex_unlock(&udc_lock);
-	return rc;
-}
-static DEVICE_ATTR_RO(function);
-
-#define USB_UDC_SPEED_ATTR(name, param)					\
-ssize_t name##_show(struct device *dev,					\
-		struct device_attribute *attr, char *buf)		\
-{									\
-	struct usb_udc *udc = container_of(dev, struct usb_udc, dev);	\
-	return scnprintf(buf, PAGE_SIZE, "%s\n",			\
-			usb_speed_string(udc->gadget->param));		\
-}									\
-static DEVICE_ATTR_RO(name)
-
-static USB_UDC_SPEED_ATTR(current_speed, speed);
-static USB_UDC_SPEED_ATTR(maximum_speed, max_speed);
-
-#define USB_UDC_ATTR(name)					\
-ssize_t name##_show(struct device *dev,				\
-		struct device_attribute *attr, char *buf)	\
-{								\
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev); \
-	struct usb_gadget	*gadget = udc->gadget;		\
-								\
-	return scnprintf(buf, PAGE_SIZE, "%d\n", gadget->name);	\
-}								\
-static DEVICE_ATTR_RO(name)
-
-static USB_UDC_ATTR(is_otg);
-static USB_UDC_ATTR(is_a_peripheral);
-static USB_UDC_ATTR(b_hnp_enable);
-static USB_UDC_ATTR(a_hnp_support);
-static USB_UDC_ATTR(a_alt_hnp_support);
-static USB_UDC_ATTR(is_selfpowered);
-
-static struct attribute *usb_udc_attrs[] = {
-	&dev_attr_srp.attr,
-	&dev_attr_soft_connect.attr,
-	&dev_attr_state.attr,
-	&dev_attr_function.attr,
-	&dev_attr_current_speed.attr,
-	&dev_attr_maximum_speed.attr,
-
-	&dev_attr_is_otg.attr,
-	&dev_attr_is_a_peripheral.attr,
-	&dev_attr_b_hnp_enable.attr,
-	&dev_attr_a_hnp_support.attr,
-	&dev_attr_a_alt_hnp_support.attr,
-	&dev_attr_is_selfpowered.attr,
-	NULL,
-};
-
-static const struct attribute_group usb_udc_attr_group = {
-	.attrs = usb_udc_attrs,
-};
-
-static const struct attribute_group *usb_udc_attr_groups[] = {
-	&usb_udc_attr_group,
-	NULL,
-};
-
-static int usb_udc_uevent(const struct device *dev, struct kobj_uevent_env *env)
-{
-	const struct usb_udc	*udc = container_of(dev, struct usb_udc, dev);
+	struct usb_udc		*udc = NULL;
+	unsigned int		udc_count = 0;
 	int			ret;
 
-	ret = add_uevent_var(env, "USB_UDC_NAME=%s", udc->gadget->name);
-	if (ret) {
-		dev_err(dev, "failed to add uevent USB_UDC_NAME\n");
-		return ret;
-	}
+	if (!driver || !driver->bind || !driver->setup)
+		return -EINVAL;
 
 	mutex_lock(&udc_lock);
-	if (udc->driver)
-		ret = add_uevent_var(env, "USB_UDC_DRIVER=%s",
-				udc->driver->function);
-	mutex_unlock(&udc_lock);
-	if (ret) {
-		dev_err(dev, "failed to add uevent USB_UDC_DRIVER\n");
-		return ret;
+	list_for_each_entry(udc, &udc_list, list) {
+		udc_count++;
+
+		/* For now we take the first one */
+		if (!udc->driver)
+			goto found;
 	}
 
-	return 0;
+	if (!udc_count)
+		printf("No UDC available in the system\n");
+	else
+		/* When this happens, users should 'unbind <class> <index>'
+		 * using the output of 'dm tree' and looking at the line right
+		 * after the USB peripheral/device controller.
+		 */
+		printf("All UDCs in use (%d available), use the unbind command\n",
+		       udc_count);
+	mutex_unlock(&udc_lock);
+	return -ENODEV;
+found:
+	ret = udc_bind_to_driver(udc, driver);
+	mutex_unlock(&udc_lock);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(usb_gadget_probe_driver);
 
-static const struct class udc_class = {
-	.name		= "udc",
-	.dev_uevent	= usb_udc_uevent,
-};
-
-static const struct bus_type gadget_bus_type = {
-	.name = "gadget",
-	.probe = gadget_bind_driver,
-	.remove = gadget_unbind_driver,
-	.match = gadget_match_driver,
-};
-
-static int __init usb_udc_init(void)
-{
-	int rc;
-
-	rc = class_register(&udc_class);
-	if (rc)
-		return rc;
-
-	rc = bus_register(&gadget_bus_type);
-	if (rc)
-		class_unregister(&udc_class);
-	return rc;
-}
-subsys_initcall(usb_udc_init);
-
-static void __exit usb_udc_exit(void)
+int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
-	bus_unregister(&gadget_bus_type);
-	class_unregister(&udc_class);
+	return usb_gadget_probe_driver(driver);
 }
-module_exit(usb_udc_exit);
+EXPORT_SYMBOL_GPL(usb_gadget_register_driver);
 
 MODULE_DESCRIPTION("UDC Framework");
 MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index e3e0ceff43e6..bc1876bed1d6 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -51,7 +51,7 @@ static void dwc3_phy_reset(struct dwc3 *dwc3_reg)
 	clrbits_le32(&dwc3_reg->g_usb2phycfg, DWC3_GUSB2PHYCFG_PHYSOFTRST);
 }
 
-void dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
+static void _dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
 {
 	/* Before Resetting PHY, put Core in Reset */
 	setbits_le32(&dwc3_reg->g_ctl, DWC3_GCTL_CORESOFTRESET);
@@ -79,7 +79,7 @@ int dwc3_core_init(struct dwc3 *dwc3_reg)
 		return -1;
 	}
 
-	dwc3_core_soft_reset(dwc3_reg);
+	_dwc3_core_soft_reset(dwc3_reg);
 
 	dwc3_hwparams1 = readl(&dwc3_reg->g_hwparams1);
 
diff --git a/drivers/usb/host/xhci-exynos5.c b/drivers/usb/host/xhci-exynos5.c
index 6a2d422c4b8e..e7573bc649bd 100644
--- a/drivers/usb/host/xhci-exynos5.c
+++ b/drivers/usb/host/xhci-exynos5.c
@@ -92,7 +92,7 @@ static int xhci_usb_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static void exynos5_usb3_phy_init(struct exynos_usb3_phy *phy)
+void exynos5_usb3_phy_init(struct exynos_usb3_phy *phy)
 {
 	u32 reg;
 
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 4b0bc5f02d10..07775d23d508 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -300,20 +300,20 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 	u32 value = 0;
 
 	switch (le16_to_cpu(setup->wIndex) >> 8) {
-	case TEST_J:
-		dev_dbg(mtu->dev, "TEST_J\n");
+	case USB_TEST_J:
+		dev_dbg(mtu->dev, "USB_TEST_J\n");
 		mtu->test_mode_nr = TEST_J_MODE;
 		break;
-	case TEST_K:
-		dev_dbg(mtu->dev, "TEST_K\n");
+	case USB_TEST_K:
+		dev_dbg(mtu->dev, "USB_TEST_K\n");
 		mtu->test_mode_nr = TEST_K_MODE;
 		break;
-	case TEST_SE0_NAK:
-		dev_dbg(mtu->dev, "TEST_SE0_NAK\n");
+	case USB_TEST_SE0_NAK:
+		dev_dbg(mtu->dev, "USB_TEST_SE0_NAK\n");
 		mtu->test_mode_nr = TEST_SE0_NAK_MODE;
 		break;
-	case TEST_PACKET:
-		dev_dbg(mtu->dev, "TEST_PACKET\n");
+	case USB_TEST_PACKET:
+		dev_dbg(mtu->dev, "USB_TEST_PACKET\n");
 		mtu->test_mode_nr = TEST_PACKET_MODE;
 		break;
 	default:
diff --git a/drivers/usb/musb-new/musb_gadget_ep0.c b/drivers/usb/musb-new/musb_gadget_ep0.c
index ea65326ab626..faad283da0cc 100644
--- a/drivers/usb/musb-new/musb_gadget_ep0.c
+++ b/drivers/usb/musb-new/musb_gadget_ep0.c
@@ -317,51 +317,43 @@ __acquires(musb->lock)
 						goto stall;
 
 					switch (ctrlrequest->wIndex >> 8) {
-					case 1:
-						pr_debug("TEST_J\n");
-						/* TEST_J */
+					case USB_TEST_J:
+						pr_debug("USB_TEST_J\n");
 						musb->test_mode_nr =
 							MUSB_TEST_J;
 						break;
-					case 2:
-						/* TEST_K */
-						pr_debug("TEST_K\n");
+					case USB_TEST_K:
+						pr_debug("USB_TEST_K\n");
 						musb->test_mode_nr =
 							MUSB_TEST_K;
 						break;
-					case 3:
-						/* TEST_SE0_NAK */
-						pr_debug("TEST_SE0_NAK\n");
+					case USB_TEST_SE0_NAK:
+						pr_debug("USB_TEST_SE0_NAK\n");
 						musb->test_mode_nr =
 							MUSB_TEST_SE0_NAK;
 						break;
-					case 4:
-						/* TEST_PACKET */
-						pr_debug("TEST_PACKET\n");
+					case USB_TEST_PACKET:
+						pr_debug("USB_TEST_PACKET\n");
 						musb->test_mode_nr =
 							MUSB_TEST_PACKET;
 						break;
 
 					case 0xc0:
-						/* TEST_FORCE_HS */
 						pr_debug("TEST_FORCE_HS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_HS;
 						break;
 					case 0xc1:
-						/* TEST_FORCE_FS */
 						pr_debug("TEST_FORCE_FS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_FS;
 						break;
 					case 0xc2:
-						/* TEST_FIFO_ACCESS */
 						pr_debug("TEST_FIFO_ACCESS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FIFO_ACCESS;
 						break;
 					case 0xc3:
-						/* TEST_FORCE_HOST */
 						pr_debug("TEST_FORCE_HOST\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_HOST;
diff --git a/drivers/usb/musb-new/musb_uboot.c b/drivers/usb/musb-new/musb_uboot.c
index 43ab3245e5c3..16907c4681bc 100644
--- a/drivers/usb/musb-new/musb_uboot.c
+++ b/drivers/usb/musb-new/musb_uboot.c
@@ -383,45 +383,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 
 	return gadget->isr(0, gadget);
 }
-
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	int ret;
-
-	if (!driver || driver->speed < USB_SPEED_FULL || !driver->bind ||
-	    !driver->setup) {
-		printf("bad parameter.\n");
-		return -EINVAL;
-	}
-
-	if (!gadget) {
-		printf("Controller uninitialized\n");
-		return -ENXIO;
-	}
-
-	ret = musb_gadget_start(&gadget->g, driver);
-	if (ret < 0) {
-		printf("gadget_start failed with %d\n", ret);
-		return ret;
-	}
-
-	ret = driver->bind(&gadget->g);
-	if (ret < 0) {
-		printf("bind failed with %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	if (driver->disconnect)
-		driver->disconnect(&gadget->g);
-	if (driver->unbind)
-		driver->unbind(&gadget->g);
-	return 0;
-}
 #endif /* CONFIG_USB_MUSB_GADGET */
 
 struct musb *musb_register(struct musb_hdrc_platform_data *plat, void *bdata,
diff --git a/include/dm/device_compat.h b/include/dm/device_compat.h
index aa9a6fbb5e3f..6b31a72768fd 100644
--- a/include/dm/device_compat.h
+++ b/include/dm/device_compat.h
@@ -119,4 +119,17 @@
 #define dev_vdbg(dev, fmt, ...) \
 	__dev_printk(LOGL_DEBUG_CONTENT, dev, fmt, ##__VA_ARGS__)
 
+#define dev_err_probe(dev, err, fmt, ...) \
+	({ \
+		int _err = (err); \
+		if (_err != -EPROBE_DEFER) { \
+			dev_err(dev, fmt, ##__VA_ARGS__); \
+			dev_err(dev, "[err=%d]", _err); \
+		} else { \
+			dev_dbg(dev, fmt, ##__VA_ARGS__); \
+			dev_dbg(dev, "[err=%d]", _err); \
+		} \
+		_err; \
+	 })
+
 #endif
diff --git a/include/dm/read.h b/include/dm/read.h
index 12dcde6645c7..201a149f310e 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1273,6 +1273,52 @@ static inline phy_interface_t dev_read_phy_mode(const struct udevice *dev)
 
 #endif /* CONFIG_DM_DEV_READ_INLINE */
 
+static inline int dev_count_u32(const struct udevice *dev,
+					 const char *name)
+{
+	return dev_read_u32_array(dev, name, NULL, 0);
+}
+
+/* Linux compatibility */
+
+#define device_property_count_u32 dev_count_u32
+#define device_property_read_bool dev_read_bool
+#define device_property_read_u16 dev_read_u16
+#define device_property_read_u32_array dev_read_u32_array
+#define device_property_read_u32 dev_read_u32
+#define device_property_read_u8 dev_read_u8
+
+static inline int device_property_read_string(const struct udevice *dev,
+					      const char *propname,
+					      const char **val)
+{
+	*val = dev_read_string(dev, propname);
+	if (!*val)
+		return -ENOENT;
+	return 0;
+}
+
+static inline bool device_property_present(const struct udevice *dev,
+					   const char *propname)
+{
+	return (dev_read_size(dev, propname) > 0);
+}
+
+static inline int device_property_count_u8(const struct udevice *dev,
+					   const char *propname)
+{
+	return dev_read_size(dev, propname);
+}
+
+static inline int device_property_read_u8_array(const struct udevice *dev,
+						const char *propname,
+						u8 *out, size_t count)
+{
+	memcpy(out, dev_read_u8_array_ptr(dev, propname, count), count);
+
+	return 0;
+}
+
 /**
  * dev_for_each_subnode() - Helper function to iterate through subnodes
  *
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 623814516175..64fd5f60b2fe 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -284,6 +284,7 @@ struct rw_semaphore { int i; };
 #define up_write(...)			do { } while (0)
 #define down_read(...)			do { } while (0)
 #define up_read(...)			do { } while (0)
+struct device_node;
 struct device {
 	struct device		*parent;
 	struct class		*class;
@@ -292,6 +293,7 @@ struct device {
 	/* This is used from drivers/usb/musb-new subsystem only */
 	void		*driver_data;	/* data private to the driver */
 	void            *device_data;   /* data private to the device */
+	struct device_node	*of_node; /* associated device tree node */
 };
 struct mutex { int i; };
 struct kernel_param { int i; };
@@ -389,4 +391,17 @@ typedef unsigned long dmaaddr_t;
 #define free_irq(irq, data) do {} while (0)
 #define request_irq(nr, f, flags, nm, data) 0
 
+/* From include/linux/reset.h */
+
+struct reset_control;
+
+static inline int reset_control_assert(struct reset_control *rstc)
+{
+	return 0;
+}
+
+static inline int reset_control_deassert(struct reset_control *rstc)
+{
+	return 0;
+}
 #endif
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index c8c553b930ac..6623c6ae95b3 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * This file holds USB constants and structures that are needed for
  * USB device APIs.  These are used by the USB device model, which is
@@ -5,7 +6,7 @@
  * Wireless USB 1.0 (spread around).  Linux has several APIs in C that
  * need these:
  *
- * - the master/host side Linux-USB kernel driver API;
+ * - the host side Linux-USB kernel driver API;
  * - the "usbfs" user space API; and
  * - the Linux "gadget" slave/device/peripheral side driver API.
  *
@@ -131,11 +132,11 @@
  * Test Mode Selectors
  * See USB 2.0 spec Table 9-7
  */
-#define	TEST_J		1
-#define	TEST_K		2
-#define	TEST_SE0_NAK	3
-#define	TEST_PACKET	4
-#define	TEST_FORCE_EN	5
+#define	USB_TEST_J		1
+#define	USB_TEST_K		2
+#define	USB_TEST_SE0_NAK	3
+#define	USB_TEST_PACKET		4
+#define	USB_TEST_FORCE_ENABLE	5
 
 /*
  * New Feature Selectors as added by USB 3.0
@@ -873,9 +874,6 @@ struct usb_ss_cap_descriptor {		/* Link Power Management */
 	__le16 bU2DevExitLat;
 } __attribute__((packed));
 
-#define USB_DEFAULT_U1_DEV_EXIT_LAT     0x01	/* Less then 1 microsec */
-#define USB_DEFAULT_U2_DEV_EXIT_LAT     0x01F4	/* Less then 500 microsec */
-
 #define USB_DT_USB_SS_CAP_SIZE	10
 
 /*
@@ -1055,4 +1053,13 @@ struct usb_string {
 	const char *s;
 };
 
+/* USB 3.2 SuperSpeed Plus phy signaling rate generation and lane count */
+
+enum usb_ssp_rate {
+        USB_SSP_GEN_UNKNOWN = 0,
+        USB_SSP_GEN_2x1,
+        USB_SSP_GEN_1x2,
+        USB_SSP_GEN_2x2,
+};
+
 #endif /* __LINUX_USB_CH9_H */
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index fe79bf64a0e1..e0f67475b537 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -88,6 +88,7 @@ struct usb_request {
 	dma_addr_t		dma;
 
 	unsigned		stream_id:16;
+	unsigned		is_last:1;
 	unsigned		no_interrupt:1;
 	unsigned		zero:1;
 	unsigned		short_not_ok:1;
@@ -97,6 +98,7 @@ struct usb_request {
 	void			*context;
 	struct list_head	list;
 
+	unsigned		frame_number;		/* ISO ONLY */
 	int			status;
 	unsigned		actual;
 };
@@ -153,6 +155,8 @@ struct usb_ep_caps {
  * @ops: Function pointers used to access hardware-specific operations.
  * @ep_list:the gadget's ep_list holds all of its endpoints
  * @caps:The structure describing types and directions supported by endoint.
+ * @enabled: The current endpoint enabled/disabled state.
+ * @claimed: True if this endpoint is claimed by a function.
  * @maxpacket:The maximum packet size used on this endpoint.  The initial
  *	value can sometimes be reduced (hardware allowing), according to
  *      the endpoint descriptor used to configure the endpoint.
@@ -162,6 +166,8 @@ struct usb_ep_caps {
  * @max_streams: The maximum number of streams supported
  *	by this EP (0 - 16, actual number is 2^n)
  * @maxburst: the maximum number of bursts supported by this EP (for usb3)
+ * @address: used to identify the endpoint when finding descriptor that
+ *      matches connection speed
  * @driver_data:for use by the gadget driver.  all other fields are
  *	read-only to gadget drivers.
  * @desc: endpoint descriptor.  This pointer is set before the endpoint is
@@ -179,301 +185,73 @@ struct usb_ep {
 	const struct usb_ep_ops	*ops;
 	struct list_head	ep_list;
 	struct usb_ep_caps	caps;
+	bool			claimed;
 	bool			enabled;
 	unsigned		maxpacket:16;
 	unsigned		maxpacket_limit:16;
 	unsigned		max_streams:16;
 	unsigned		maxburst:5;
+	u8			address;
 	const struct usb_endpoint_descriptor	*desc;
 	const struct usb_ss_ep_comp_descriptor	*comp_desc;
 };
 
 /*-------------------------------------------------------------------------*/
 
-/**
- * usb_ep_set_maxpacket_limit - set maximum packet size limit for endpoint
- * @ep:the endpoint being configured
- * @maxpacket_limit:value of maximum packet size limit
- *
- * This function shoud be used only in UDC drivers to initialize endpoint
- * (usually in probe function).
- */
+#if IS_ENABLED(CONFIG_USB_GADGET)
+void usb_ep_set_maxpacket_limit(struct usb_ep *ep, unsigned maxpacket_limit);
+int usb_ep_enable(struct usb_ep *ep);
+int usb_ep_disable(struct usb_ep *ep);
+struct usb_request *usb_ep_alloc_request(struct usb_ep *ep, gfp_t gfp_flags);
+void usb_ep_free_request(struct usb_ep *ep, struct usb_request *req);
+int usb_ep_queue(struct usb_ep *ep, struct usb_request *req, gfp_t gfp_flags);
+int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req);
+int usb_ep_set_halt(struct usb_ep *ep);
+int usb_ep_clear_halt(struct usb_ep *ep);
+int usb_ep_set_wedge(struct usb_ep *ep);
+int usb_ep_fifo_status(struct usb_ep *ep);
+void usb_ep_fifo_flush(struct usb_ep *ep);
+#else
 static inline void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
-					      unsigned maxpacket_limit)
-{
-	ep->maxpacket_limit = maxpacket_limit;
-	ep->maxpacket = maxpacket_limit;
-}
-
-/**
- * usb_ep_enable - configure endpoint, making it usable
- * @ep:the endpoint being configured.  may not be the endpoint named "ep0".
- *	drivers discover endpoints through the ep_list of a usb_gadget.
- * @desc:descriptor for desired behavior.  caller guarantees this pointer
- *	remains valid until the endpoint is disabled; the data byte order
- *	is little-endian (usb-standard).
- *
- * when configurations are set, or when interface settings change, the driver
- * will enable or disable the relevant endpoints.  while it is enabled, an
- * endpoint may be used for i/o until the driver receives a disconnect() from
- * the host or until the endpoint is disabled.
- *
- * the ep0 implementation (which calls this routine) must ensure that the
- * hardware capabilities of each endpoint match the descriptor provided
- * for it.  for example, an endpoint named "ep2in-bulk" would be usable
- * for interrupt transfers as well as bulk, but it likely couldn't be used
- * for iso transfers or for endpoint 14.  some endpoints are fully
- * configurable, with more generic names like "ep-a".  (remember that for
- * USB, "in" means "towards the USB master".)
- *
- * returns zero, or a negative error code.
- */
-static inline int usb_ep_enable(struct usb_ep *ep,
-				const struct usb_endpoint_descriptor *desc)
-{
-	int ret;
-
-	if (ep->enabled)
-		return 0;
-
-	ret = ep->ops->enable(ep, desc);
-	if (ret)
-		return ret;
-
-	ep->enabled = true;
-
-	return 0;
-}
-
-/**
- * usb_ep_disable - endpoint is no longer usable
- * @ep:the endpoint being unconfigured.  may not be the endpoint named "ep0".
- *
- * no other task may be using this endpoint when this is called.
- * any pending and uncompleted requests will complete with status
- * indicating disconnect (-ESHUTDOWN) before this call returns.
- * gadget drivers must call usb_ep_enable() again before queueing
- * requests to the endpoint.
- *
- * returns zero, or a negative error code.
- */
+		unsigned maxpacket_limit)
+{ }
+static inline int usb_ep_enable(struct usb_ep *ep)
+{ return 0; }
 static inline int usb_ep_disable(struct usb_ep *ep)
-{
-	int ret;
-
-	if (!ep->enabled)
-		return 0;
-
-	ret = ep->ops->disable(ep);
-	if (ret)
-		return ret;
-
-	ep->enabled = false;
-
-	return 0;
-}
-
-/**
- * usb_ep_alloc_request - allocate a request object to use with this endpoint
- * @ep:the endpoint to be used with with the request
- * @gfp_flags:GFP_* flags to use
- *
- * Request objects must be allocated with this call, since they normally
- * need controller-specific setup and may even need endpoint-specific
- * resources such as allocation of DMA descriptors.
- * Requests may be submitted with usb_ep_queue(), and receive a single
- * completion callback.  Free requests with usb_ep_free_request(), when
- * they are no longer needed.
- *
- * Returns the request, or null if one could not be allocated.
- */
+{ return 0; }
 static inline struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
-						       gfp_t gfp_flags)
-{
-	return ep->ops->alloc_request(ep, gfp_flags);
-}
-
-/**
- * usb_ep_free_request - frees a request object
- * @ep:the endpoint associated with the request
- * @req:the request being freed
- *
- * Reverses the effect of usb_ep_alloc_request().
- * Caller guarantees the request is not queued, and that it will
- * no longer be requeued (or otherwise used).
- */
+		gfp_t gfp_flags)
+{ return NULL; }
 static inline void usb_ep_free_request(struct usb_ep *ep,
-				       struct usb_request *req)
-{
-	ep->ops->free_request(ep, req);
-}
-
-/**
- * usb_ep_queue - queues (submits) an I/O request to an endpoint.
- * @ep:the endpoint associated with the request
- * @req:the request being submitted
- * @gfp_flags: GFP_* flags to use in case the lower level driver couldn't
- *	pre-allocate all necessary memory with the request.
- *
- * This tells the device controller to perform the specified request through
- * that endpoint (reading or writing a buffer).  When the request completes,
- * including being canceled by usb_ep_dequeue(), the request's completion
- * routine is called to return the request to the driver.  Any endpoint
- * (except control endpoints like ep0) may have more than one transfer
- * request queued; they complete in FIFO order.  Once a gadget driver
- * submits a request, that request may not be examined or modified until it
- * is given back to that driver through the completion callback.
- *
- * Each request is turned into one or more packets.  The controller driver
- * never merges adjacent requests into the same packet.  OUT transfers
- * will sometimes use data that's already buffered in the hardware.
- * Drivers can rely on the fact that the first byte of the request's buffer
- * always corresponds to the first byte of some USB packet, for both
- * IN and OUT transfers.
- *
- * Bulk endpoints can queue any amount of data; the transfer is packetized
- * automatically.  The last packet will be short if the request doesn't fill it
- * out completely.  Zero length packets (ZLPs) should be avoided in portable
- * protocols since not all usb hardware can successfully handle zero length
- * packets.  (ZLPs may be explicitly written, and may be implicitly written if
- * the request 'zero' flag is set.)  Bulk endpoints may also be used
- * for interrupt transfers; but the reverse is not true, and some endpoints
- * won't support every interrupt transfer.  (Such as 768 byte packets.)
- *
- * Interrupt-only endpoints are less functional than bulk endpoints, for
- * example by not supporting queueing or not handling buffers that are
- * larger than the endpoint's maxpacket size.  They may also treat data
- * toggle differently.
- *
- * Control endpoints ... after getting a setup() callback, the driver queues
- * one response (even if it would be zero length).  That enables the
- * status ack, after transfering data as specified in the response.  Setup
- * functions may return negative error codes to generate protocol stalls.
- * (Note that some USB device controllers disallow protocol stall responses
- * in some cases.)  When control responses are deferred (the response is
- * written after the setup callback returns), then usb_ep_set_halt() may be
- * used on ep0 to trigger protocol stalls.
- *
- * For periodic endpoints, like interrupt or isochronous ones, the usb host
- * arranges to poll once per interval, and the gadget driver usually will
- * have queued some data to transfer at that time.
- *
- * Returns zero, or a negative error code.  Endpoints that are not enabled
- * report errors; errors will also be
- * reported when the usb peripheral is disconnected.
- */
-static inline int usb_ep_queue(struct usb_ep *ep,
-			       struct usb_request *req, gfp_t gfp_flags)
-{
-	return ep->ops->queue(ep, req, gfp_flags);
-}
-
-/**
- * usb_ep_dequeue - dequeues (cancels, unlinks) an I/O request from an endpoint
- * @ep:the endpoint associated with the request
- * @req:the request being canceled
- *
- * if the request is still active on the endpoint, it is dequeued and its
- * completion routine is called (with status -ECONNRESET); else a negative
- * error code is returned.
- *
- * note that some hardware can't clear out write fifos (to unlink the request
- * at the head of the queue) except as part of disconnecting from usb.  such
- * restrictions prevent drivers from supporting configuration changes,
- * even to configuration zero (a "chapter 9" requirement).
- */
+		struct usb_request *req)
+{ }
+static inline int usb_ep_queue(struct usb_ep *ep, struct usb_request *req,
+		gfp_t gfp_flags)
+{ return 0; }
 static inline int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
-{
-	return ep->ops->dequeue(ep, req);
-}
-
-/**
- * usb_ep_set_halt - sets the endpoint halt feature.
- * @ep: the non-isochronous endpoint being stalled
- *
- * Use this to stall an endpoint, perhaps as an error report.
- * Except for control endpoints,
- * the endpoint stays halted (will not stream any data) until the host
- * clears this feature; drivers may need to empty the endpoint's request
- * queue first, to make sure no inappropriate transfers happen.
- *
- * Note that while an endpoint CLEAR_FEATURE will be invisible to the
- * gadget driver, a SET_INTERFACE will not be.  To reset endpoints for the
- * current altsetting, see usb_ep_clear_halt().  When switching altsettings,
- * it's simplest to use usb_ep_enable() or usb_ep_disable() for the endpoints.
- *
- * Returns zero, or a negative error code.  On success, this call sets
- * underlying hardware state that blocks data transfers.
- * Attempts to halt IN endpoints will fail (returning -EAGAIN) if any
- * transfer requests are still queued, or if the controller hardware
- * (usually a FIFO) still holds bytes that the host hasn't collected.
- */
+{ return 0; }
 static inline int usb_ep_set_halt(struct usb_ep *ep)
-{
-	return ep->ops->set_halt(ep, 1);
-}
-
-/**
- * usb_ep_clear_halt - clears endpoint halt, and resets toggle
- * @ep:the bulk or interrupt endpoint being reset
- *
- * Use this when responding to the standard usb "set interface" request,
- * for endpoints that aren't reconfigured, after clearing any other state
- * in the endpoint's i/o queue.
- *
- * Returns zero, or a negative error code.  On success, this call clears
- * the underlying hardware state reflecting endpoint halt and data toggle.
- * Note that some hardware can't support this request (like pxa2xx_udc),
- * and accordingly can't correctly implement interface altsettings.
- */
+{ return 0; }
 static inline int usb_ep_clear_halt(struct usb_ep *ep)
-{
-	return ep->ops->set_halt(ep, 0);
-}
-
-/**
- * usb_ep_fifo_status - returns number of bytes in fifo, or error
- * @ep: the endpoint whose fifo status is being checked.
- *
- * FIFO endpoints may have "unclaimed data" in them in certain cases,
- * such as after aborted transfers.  Hosts may not have collected all
- * the IN data written by the gadget driver (and reported by a request
- * completion).  The gadget driver may not have collected all the data
- * written OUT to it by the host.  Drivers that need precise handling for
- * fault reporting or recovery may need to use this call.
- *
- * This returns the number of such bytes in the fifo, or a negative
- * errno if the endpoint doesn't use a FIFO or doesn't support such
- * precise handling.
- */
+{ return 0; }
+static inline int usb_ep_set_wedge(struct usb_ep *ep)
+{ return 0; }
 static inline int usb_ep_fifo_status(struct usb_ep *ep)
-{
-	if (ep->ops->fifo_status)
-		return ep->ops->fifo_status(ep);
-	else
-		return -EOPNOTSUPP;
-}
-
-/**
- * usb_ep_fifo_flush - flushes contents of a fifo
- * @ep: the endpoint whose fifo is being flushed.
- *
- * This call may be used to flush the "unclaimed data" that may exist in
- * an endpoint fifo after abnormal transaction terminations.  The call
- * must never be used except when endpoint is not being used for any
- * protocol translation.
- */
+{ return 0; }
 static inline void usb_ep_fifo_flush(struct usb_ep *ep)
-{
-	if (ep->ops->fifo_flush)
-		ep->ops->fifo_flush(ep);
-}
+{ }
+#endif /* USB_GADGET */
 
 /*-------------------------------------------------------------------------*/
 
 struct usb_dcd_config_params {
 	__u8  bU1devExitLat;	/* U1 Device exit Latency */
+#define USB_DEFAULT_U1_DEV_EXIT_LAT     0x01    /* Less then 1 microsec */
 	__le16 bU2DevExitLat;	/* U2 Device exit Latency */
+#define USB_DEFAULT_U2_DEV_EXIT_LAT     0x1F4   /* Less then 500 microsec */
+	__u8 besl_baseline;	/* Recommended baseline BESL (0-15) */
+	__u8 besl_deep;         /* Recommended deep BESL (0-15) */
+#define USB_DEFAULT_BESL_UNSPECIFIED    0xFF    /* No recommended value */
 };
 
 struct usb_gadget;
@@ -491,7 +269,8 @@ struct usb_gadget_ops {
 	int	(*pullup) (struct usb_gadget *, int is_on);
 	int	(*ioctl)(struct usb_gadget *,
 				unsigned code, unsigned long param);
-	void	(*get_config_params)(struct usb_dcd_config_params *);
+	void	(*get_config_params)(struct usb_gadget *,
+				     struct usb_dcd_config_params *);
 	int	(*udc_start)(struct usb_gadget *,
 			     struct usb_gadget_driver *);
 	int	(*udc_stop)(struct usb_gadget *);
@@ -503,6 +282,10 @@ struct usb_gadget_ops {
 			struct usb_endpoint_descriptor *);
 	void	(*udc_set_speed)(struct usb_gadget *gadget,
 				 enum usb_device_speed);
+	void    (*udc_set_ssp_rate)(struct usb_gadget *gadget,
+			enum usb_ssp_rate rate);
+	void    (*udc_async_callbacks)(struct usb_gadget *gadget, bool enable);
+	int	(*check_config)(struct usb_gadget *gadget);
 };
 
 /**
@@ -552,13 +335,23 @@ struct usb_gadget_ops {
  * device is acting as a B-Peripheral (so is_a_peripheral is false).
  */
 struct usb_gadget {
+	struct usb_udc			*udc;
 	/* readonly to gadget driver */
 	const struct usb_gadget_ops	*ops;
 	struct usb_ep			*ep0;
 	struct list_head		ep_list;	/* of usb_ep */
 	enum usb_device_speed		speed;
 	enum usb_device_speed		max_speed;
+
+	/* USB SuperSpeed Plus only */
+	enum usb_ssp_rate		ssp_rate;
+	enum usb_ssp_rate               max_ssp_rate;
+
 	enum usb_device_state		state;
+	unsigned			isoch_delay;
+
+	unsigned			out_epnum;
+	unsigned			in_epnum;
 	unsigned			is_dualspeed:1;
 	unsigned			is_otg:1;
 	unsigned			is_a_peripheral:1;
@@ -568,6 +361,10 @@ struct usb_gadget {
 	const char			*name;
 	struct device			dev;
 	unsigned			quirk_ep_out_aligned_size:1;
+	unsigned			is_selfpowered:1;
+	unsigned			deactivated:1;
+	unsigned			wakeup_armed:1;
+	unsigned			connected:1;
 };
 
 static inline void set_gadget_data(struct usb_gadget *gadget, void *data)
@@ -585,6 +382,15 @@ static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
 	return container_of(dev, struct usb_gadget, dev);
 }
 
+static inline void usb_put_gadget(struct usb_gadget *gadget)
+{
+}
+
+void usb_initialize_gadget(struct device *parent,
+			   struct usb_gadget *gadget,
+			   void (*release)(struct device *dev));
+int usb_add_gadget(struct usb_gadget *gadget);
+
 /* iterates the non-control endpoints; 'tmp' is a struct usb_ep pointer */
 #define gadget_for_each_ep(tmp, gadget) \
 	list_for_each_entry(tmp, &(gadget)->ep_list, ep_list)
@@ -630,168 +436,18 @@ static inline int gadget_is_superspeed(struct usb_gadget *g)
 	return g->max_speed >= USB_SPEED_SUPER;
 }
 
-/**
- * usb_gadget_frame_number - returns the current frame number
- * @gadget: controller that reports the frame number
- *
- * Returns the usb frame number, normally eleven bits from a SOF packet,
- * or negative errno if this device doesn't support this capability.
- */
-static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
-{
-	return gadget->ops->get_frame(gadget);
-}
-
-/**
- * usb_gadget_wakeup - tries to wake up the host connected to this gadget
- * @gadget: controller used to wake up the host
- *
- * Returns zero on success, else negative error code if the hardware
- * doesn't support such attempts, or its support has not been enabled
- * by the usb host.  Drivers must return device descriptors that report
- * their ability to support this, or hosts won't enable it.
- *
- * This may also try to use SRP to wake the host and start enumeration,
- * even if OTG isn't otherwise in use.  OTG devices may also start
- * remote wakeup even when hosts don't explicitly enable it.
- */
-static inline int usb_gadget_wakeup(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->wakeup)
-		return -EOPNOTSUPP;
-	return gadget->ops->wakeup(gadget);
-}
-
-/**
- * usb_gadget_set_selfpowered - sets the device selfpowered feature.
- * @gadget:the device being declared as self-powered
- *
- * this affects the device status reported by the hardware driver
- * to reflect that it now has a local power supply.
- *
- * returns zero on success, else negative errno.
- */
-static inline int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->set_selfpowered)
-		return -EOPNOTSUPP;
-	return gadget->ops->set_selfpowered(gadget, 1);
-}
-
-/**
- * usb_gadget_clear_selfpowered - clear the device selfpowered feature.
- * @gadget:the device being declared as bus-powered
- *
- * this affects the device status reported by the hardware driver.
- * some hardware may not support bus-powered operation, in which
- * case this feature's value can never change.
- *
- * returns zero on success, else negative errno.
- */
-static inline int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->set_selfpowered)
-		return -EOPNOTSUPP;
-	return gadget->ops->set_selfpowered(gadget, 0);
-}
-
-/**
- * usb_gadget_vbus_connect - Notify controller that VBUS is powered
- * @gadget:The device which now has VBUS power.
- *
- * This call is used by a driver for an external transceiver (or GPIO)
- * that detects a VBUS power session starting.  Common responses include
- * resuming the controller, activating the D+ (or D-) pullup to let the
- * host detect that a USB device is attached, and starting to draw power
- * (8mA or possibly more, especially after SET_CONFIGURATION).
- *
- * Returns zero on success, else negative errno.
- */
-static inline int usb_gadget_vbus_connect(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->vbus_session)
-		return -EOPNOTSUPP;
-	return gadget->ops->vbus_session(gadget, 1);
-}
-
-/**
- * usb_gadget_vbus_draw - constrain controller's VBUS power usage
- * @gadget:The device whose VBUS usage is being described
- * @mA:How much current to draw, in milliAmperes.  This should be twice
- *	the value listed in the configuration descriptor bMaxPower field.
- *
- * This call is used by gadget drivers during SET_CONFIGURATION calls,
- * reporting how much power the device may consume.  For example, this
- * could affect how quickly batteries are recharged.
- *
- * Returns zero on success, else negative errno.
- */
-static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
-{
-	if (!gadget->ops->vbus_draw)
-		return -EOPNOTSUPP;
-	return gadget->ops->vbus_draw(gadget, mA);
-}
-
-/**
- * usb_gadget_vbus_disconnect - notify controller about VBUS session end
- * @gadget:the device whose VBUS supply is being described
- *
- * This call is used by a driver for an external transceiver (or GPIO)
- * that detects a VBUS power session ending.  Common responses include
- * reversing everything done in usb_gadget_vbus_connect().
- *
- * Returns zero on success, else negative errno.
- */
-static inline int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->vbus_session)
-		return -EOPNOTSUPP;
-	return gadget->ops->vbus_session(gadget, 0);
-}
-
-/**
- * usb_gadget_connect - software-controlled connect to USB host
- * @gadget:the peripheral being connected
- *
- * Enables the D+ (or potentially D-) pullup.  The host will start
- * enumerating this gadget when the pullup is active and a VBUS session
- * is active (the link is powered).  This pullup is always enabled unless
- * usb_gadget_disconnect() has been used to disable it.
- *
- * Returns zero on success, else negative errno.
- */
-static inline int usb_gadget_connect(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->pullup)
-		return -EOPNOTSUPP;
-	return gadget->ops->pullup(gadget, 1);
-}
-
-/**
- * usb_gadget_disconnect - software-controlled disconnect from USB host
- * @gadget:the peripheral being disconnected
- *
- * Disables the D+ (or potentially D-) pullup, which the host may see
- * as a disconnect (when a VBUS session is active).  Not all systems
- * support software pullup controls.
- *
- * This routine may be used during the gadget driver bind() call to prevent
- * the peripheral from ever being visible to the USB host, unless later
- * usb_gadget_connect() is called.  For example, user mode components may
- * need to be activated before the system can talk to hosts.
- *
- * Returns zero on success, else negative errno.
- */
-static inline int usb_gadget_disconnect(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->pullup)
-		return -EOPNOTSUPP;
-	return gadget->ops->pullup(gadget, 0);
-}
+int usb_gadget_frame_number(struct usb_gadget *gadget);
+int usb_gadget_wakeup(struct usb_gadget *gadget);
+int usb_gadget_set_selfpowered(struct usb_gadget *gadget);
+int usb_gadget_clear_selfpowered(struct usb_gadget *gadget);
+int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA);
+int usb_gadget_vbus_disconnect(struct usb_gadget *gadget);
+int usb_gadget_connect(struct usb_gadget *gadget);
+int usb_gadget_disconnect(struct usb_gadget *gadget);
 
 /*-------------------------------------------------------------------------*/
 
+
 /**
  * struct usb_gadget_driver - driver for usb 'slave' devices
  * @function: String describing the gadget's function
@@ -980,6 +636,12 @@ extern void usb_gadget_giveback_request(struct usb_ep *ep,
 
 /*-------------------------------------------------------------------------*/
 
+/* utility to check if endpoint caps match descriptor needs */
+
+extern int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
+                struct usb_ep *ep, struct usb_endpoint_descriptor *desc,
+                struct usb_ss_ep_comp_descriptor *ep_comp);
+
 /* utility wrapping a simple endpoint selection policy */
 
 extern struct usb_ep *usb_ep_autoconfig(struct usb_gadget *,
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index e7e3d259cae5..9fa095ff3a72 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -46,4 +46,14 @@ enum usb_dr_mode usb_get_role_switch_default_mode(ofnode node);
  */
 enum usb_device_speed usb_get_maximum_speed(ofnode node);
 
+/**
+ * usb_get_maximum_ssp_rate - Get the signaling rate generation and lane count
+ *      of a SuperSpeed Plus capable device.
+ * @node: ofnode of the given device
+ *
+ * If the string from "maximum-speed" property is super-speed-plus-genXxY where
+ * 'X' is the generation number and 'Y' is the number of lanes, then this
+ * function returns the corresponding enum usb_ssp_rate.
+ */
+enum usb_ssp_rate usb_get_maximum_ssp_rate(ofnode node);
 #endif /* __LINUX_USB_OTG_H */
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 14b2c7eb2e63..9448d2562908 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -21,6 +21,13 @@ enum usb_phy_interface {
 	USBPHY_INTERFACE_MODE_HSIC,
 };
 
+/* associate a type with PHY */
+enum usb_phy_type {
+	USB_PHY_TYPE_UNDEFINED,
+	USB_PHY_TYPE_USB2,
+	USB_PHY_TYPE_USB3,
+};
+
 #if CONFIG_IS_ENABLED(DM_USB)
 /**
  * usb_get_phy_mode - Get phy mode for given device_node
@@ -37,4 +44,53 @@ static inline enum usb_phy_interface usb_get_phy_mode(ofnode node)
 }
 #endif
 
+struct usb_phy {
+	struct device		*dev;
+
+	/* initialize/shutdown the phy */
+	int     (*init)(struct usb_phy *x);
+	void    (*shutdown)(struct usb_phy *x);
+
+	/* enable/disable VBUS */
+	int     (*set_vbus)(struct usb_phy *x, int on);
+
+	/* effective for B devices, ignored for A-peripheral */
+	int     (*set_power)(struct usb_phy *x,
+			     unsigned mA);
+};
+
+static inline int
+usb_phy_init(struct usb_phy *x)
+{
+        if (x && x->init)
+                return x->init(x);
+
+        return 0;
+}
+
+static inline void
+usb_phy_shutdown(struct usb_phy *x)
+{
+	if (x && x->shutdown)
+		x->shutdown(x);
+}
+
+static inline int
+usb_phy_set_power(struct usb_phy *x, unsigned mA)
+{
+	if (!x)
+		return 0;
+
+	/* TODO usb_phy_set_charger_current(x, mA); */
+
+	if (x->set_power)
+		return x->set_power(x, mA);
+	return 0;
+}
+
+static inline int
+usb_phy_set_suspend(struct usb_phy *x, int suspend)
+{
+	return 0;
+}
 #endif /* __LINUX_USB_PHY_H */
-- 
2.48.1

