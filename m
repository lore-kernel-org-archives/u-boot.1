Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C6CCFC28C
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 16:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 609A883A28;
	Fri, 21 Nov 2025 17:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HoO8eVTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D83283966; Fri, 21 Nov 2025 16:38:44 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF40E83990
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 16:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so20012415e9.1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 07:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763739511; x=1764344311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBTR6HEz+fzN0TlIvbbrkwEHMKQDA5hECGhBOBS74K0=;
 b=HoO8eVTxFMP7aQWooorJmdaO17BVRQ6KmFPTqmGRzFZmcLKtd4oqSOwXv9OtVEM4aC
 HibHc/M7dyOi/WcDxpCOCfk9j48BrbhemKJbnvc/GRmDkAMBmd4SW2uT2rEZ5eAZdKTR
 NUYws3xoPTkzKjwiM+KZTlBl3xekH+UVEHXJ5UKdSOOAyDbb2T4flKiA2HvGe3Yo/4Oe
 Y+kR7ySKt4S0cylbC2tkHQcp1Cwkp8oGrqgjLH/irO8Rhvodw+yiVhzYffXMMFet0cau
 NW9uX2CSHd+CigWon9j7/YCo8SiTTZIAyGlCbF1oFgG3KtjWMnSCUtmygFuHgsnsEo7c
 JvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763739511; x=1764344311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DBTR6HEz+fzN0TlIvbbrkwEHMKQDA5hECGhBOBS74K0=;
 b=l4SDzqtMv/kL9kh4L6eXkcx0D5b+5OdttJ2bzWBeHmiRjRP7GuAsZ9QmZhir+gOkIM
 ey1oOzYP2diibtFe46sOY08bdMxRqsTAm8/RF8dlj6sSTrcunLbipaX4KOHuEGpS8L+n
 iMoOtNBfGUlb0N/KoI/Kc0XMU8vG4Hu35Iv2R3mjD8imItvdh22WWK1SgmTlxoeP+u9J
 Z5zQQ629PVHlheXSY/iXm2A5DOJ2ev68hWVl2w6G+LV7LI9Fs79TdxfjhP8tAO36zdkI
 Mra03KzehFvUOocI1aay+KzsjwkZSPK+gI4F5Dw8hjv+tjNg0q0zJ9b6/tH8/j1ByPMd
 gWQQ==
X-Gm-Message-State: AOJu0Yxn+3mKzcDy0SVZj6QUKea1GWRTtiZ1GPkqTXNhH0f37Zx1+Jgc
 kRmmOAJiHWZnxlrj0Ka5KcsyE/VMJwN5YpZKuLJ4DFo+vKeoHlKo4goPeCx2fCQgXrYCF2H1mS+
 qt+cG
X-Gm-Gg: ASbGnct5AxrnHp2QvAn1IKxXSaJCJtGEyIwOKp7ColX+AiCxHREAmEELO2Bzp3F4FHV
 E8B4asDVjip49HzPa+g+SUHicyG5mc3yT52QWTcvwKHAd3KgF9zNOjh1N6q28Hgr9JZLE6FTt+F
 PqkIqsQA3sH4sx2r2kYakZ5o20gygDlq3fr8u8EEkPULNWqIiH8hC55+5wJPtr0iY1e/LjdHBk1
 uUZf9+xSThYzVzD4M8ZUbF5YVUG/Tn1rdjVII5IxVcOHAyF2bHE9nA6hQOMocVsFJ/mBaVAbWz+
 VOPpi0hNwtsKJzipdnZZ4FkREF8vqq1i8F35Hm3D2I90UxFMR1ErKSSN+NwCdltXv0EIqSQO+lR
 0iKqEEe2zGt+I/uY2TzgXg+cEMUfTeVfzHpRwGbJQyVgyErZ3Lavwm2pE3M0uDsuLMXHvxOMiGa
 Gg8r6OLqWgQ4gLVzF3j9U=
X-Google-Smtp-Source: AGHT+IG+egtozF4WbwJBRaAIOmPpXEJGvHpkdquFY/3sjuU0MPvB0st5f5H+Fu63AjFpN3PsPZ4CaQ==
X-Received: by 2002:a5d:5d08:0:b0:42b:4185:e58a with SMTP id
 ffacd0b85a97d-42cc1cbbed2mr2932157f8f.14.1763739510140; 
 Fri, 21 Nov 2025 07:38:30 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:2035:a57d:e702:e09e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd9b45sm11487964f8f.43.2025.11.21.07.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 07:38:29 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [RFC PATCH 1/5] usb: dwc3: re-import from kernel v6.16-rc7
Date: Fri, 21 Nov 2025 16:37:50 +0100
Message-ID: <20251121153812.2076440-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251121153812.2076440-1-jerome.forissier@linaro.org>
References: <20251121153812.2076440-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Nov 2025 17:59:23 +0100
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

Sync the DWC3 USB driver with kernel v6.16-rc7. The files are imported
from the kernel unmodified. Fixup commits will follow.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 drivers/usb/dwc3/Makefile          |   61 +-
 drivers/usb/dwc3/core.c            | 3089 ++++++++++++++-----
 drivers/usb/dwc3/core.h            | 1139 +++++--
 drivers/usb/dwc3/debug.h           |  432 +++
 drivers/usb/dwc3/dwc3-am62.c       |  442 ++-
 drivers/usb/dwc3/ep0.c             |  785 ++---
 drivers/usb/dwc3/gadget.c          | 4554 ++++++++++++++++++++--------
 drivers/usb/dwc3/gadget.h          |  126 +-
 drivers/usb/dwc3/glue.h            |   36 +
 drivers/usb/dwc3/io.h              |   53 +-
 drivers/usb/dwc3/linux-compat.h    |   16 -
 drivers/usb/dwc3/samsung_usb_phy.c |   77 -
 drivers/usb/dwc3/ti_usb_phy.c      |    2 -
 13 files changed, 7969 insertions(+), 2843 deletions(-)
 create mode 100644 drivers/usb/dwc3/debug.h
 create mode 100644 drivers/usb/dwc3/glue.h
 delete mode 100644 drivers/usb/dwc3/linux-compat.h
 delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c

diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index a619cd374fb4..00f7c2410dbf 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -1,18 +1,65 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0
+# define_trace.h needs to know how to find our header
+CFLAGS_trace.o				:= -I$(src)
 
 obj-$(CONFIG_USB_DWC3)			+= dwc3.o
 
 dwc3-y					:= core.o
 
-obj-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
+ifneq ($(CONFIG_TRACING),)
+	dwc3-y				+= trace.o
+endif
 
-obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62)	+= dwc3-am62.o
+ifneq ($(filter y,$(CONFIG_USB_DWC3_HOST) $(CONFIG_USB_DWC3_DUAL_ROLE)),)
+	dwc3-y				+= host.o
+endif
+
+ifneq ($(filter y,$(CONFIG_USB_DWC3_GADGET) $(CONFIG_USB_DWC3_DUAL_ROLE)),)
+	dwc3-y				+= gadget.o ep0.o
+endif
+
+ifneq ($(CONFIG_USB_DWC3_DUAL_ROLE),)
+	dwc3-y				+= drd.o
+endif
+
+ifneq ($(CONFIG_USB_DWC3_ULPI),)
+	dwc3-y				+= ulpi.o
+endif
+
+ifneq ($(CONFIG_DEBUG_FS),)
+	dwc3-y				+= debugfs.o
+endif
+
+##
+# Platform-specific glue layers go here
+#
+# NOTICE: Make sure your glue layer doesn't depend on anything
+# which is arch-specific and that it compiles on all situations.
+#
+# We want to keep this requirement in order to be able to compile
+# the entire driver (with all its glue layers) on several architectures
+# and make sure it compiles fine. This will also help with allmodconfig
+# and allyesconfig builds.
+##
+
+obj-$(CONFIG_USB_DWC3_AM62)		+= dwc3-am62.o
 obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
+obj-$(CONFIG_USB_DWC3_EXYNOS)		+= dwc3-exynos.o
+obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)	+= dwc3-generic.o
+obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
+obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
+obj-$(CONFIG_USB_DWC3_HAPS)		+= dwc3-haps.o
+obj-$(CONFIG_USB_DWC3_IMX8MP)		+= dwc3-imx8mp.o
+obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
+obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
 obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_MESON_GXL)	+= dwc3-meson-gxl.o
-obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)		+= dwc3-generic.o
+obj-$(CONFIG_USB_DWC3_OCTEON)		+= dwc3-octeon.o
+obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
+obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
+obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom-legacy.o
+obj-$(CONFIG_USB_DWC3_RTK)		+= dwc3-rtk.o
+obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
 obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
-obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
+obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
 obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
-obj-$(CONFIG_USB_DWC3_PHY_SAMSUNG)	+= samsung_usb_phy.o
-obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 847fa1f82c37..8002c23a5a02 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1,98 +1,370 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * core.c - DesignWare USB3 DRD Controller Core file
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/core.c) and ported
- * to uboot.
- *
- * commit cd72f890d2 : usb: dwc3: core: enable phy suspend quirk on non-FPGA
  */
 
-#include <clk.h>
-#include <cpu_func.h>
-#include <malloc.h>
-#include <dwc3-uboot.h>
-#include <dm/device_compat.h>
-#include <dm/devres.h>
-#include <linux/bug.h>
+#include <linux/clk.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/list.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/err.h>
-#include <linux/iopoll.h>
-#include <linux/ioport.h>
-#include <dm.h>
-#include <generic-phy.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/acpi.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/devinfo.h>
+#include <linux/reset.h>
+#include <linux/bitfield.h>
+
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/bitfield.h>
-#include <linux/math64.h>
-#include <linux/time.h>
+#include <linux/usb/of.h>
+#include <linux/usb/otg.h>
 
 #include "core.h"
 #include "gadget.h"
+#include "glue.h"
 #include "io.h"
 
-#include "linux-compat.h"
+#include "debug.h"
+#include "../host/xhci-ext-caps.h"
 
-static LIST_HEAD(dwc3_list);
-/* -------------------------------------------------------------------------- */
+#define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
-static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
+/**
+ * dwc3_get_dr_mode - Validates and sets dr_mode
+ * @dwc: pointer to our context structure
+ */
+static int dwc3_get_dr_mode(struct dwc3 *dwc)
 {
+	enum usb_dr_mode mode;
+	struct device *dev = dwc->dev;
+	unsigned int hw_mode;
+
+	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
+		dwc->dr_mode = USB_DR_MODE_OTG;
+
+	mode = dwc->dr_mode;
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+
+	switch (hw_mode) {
+	case DWC3_GHWPARAMS0_MODE_GADGET:
+		if (IS_ENABLED(CONFIG_USB_DWC3_HOST)) {
+			dev_err(dev,
+				"Controller does not support host mode.\n");
+			return -EINVAL;
+		}
+		mode = USB_DR_MODE_PERIPHERAL;
+		break;
+	case DWC3_GHWPARAMS0_MODE_HOST:
+		if (IS_ENABLED(CONFIG_USB_DWC3_GADGET)) {
+			dev_err(dev,
+				"Controller does not support device mode.\n");
+			return -EINVAL;
+		}
+		mode = USB_DR_MODE_HOST;
+		break;
+	default:
+		if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
+			mode = USB_DR_MODE_HOST;
+		else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+			mode = USB_DR_MODE_PERIPHERAL;
+
+		/*
+		 * DWC_usb31 and DWC_usb3 v3.30a and higher do not support OTG
+		 * mode. If the controller supports DRD but the dr_mode is not
+		 * specified or set to OTG, then set the mode to peripheral.
+		 */
+		if (mode == USB_DR_MODE_OTG && !dwc->edev &&
+		    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
+		     !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
+		    !DWC3_VER_IS_PRIOR(DWC3, 330A))
+			mode = USB_DR_MODE_PERIPHERAL;
+	}
+
+	if (mode != dwc->dr_mode) {
+		dev_warn(dev,
+			 "Configuration mismatch. dr_mode forced to %s\n",
+			 mode == USB_DR_MODE_HOST ? "host" : "gadget");
+
+		dwc->dr_mode = mode;
+	}
+
+	return 0;
+}
+
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
+{
+	u32 reg;
+	int i;
+
+	for (i = 0; i < dwc->num_usb3_ports; i++) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
+		if (enable && !dwc->dis_u3_susphy_quirk)
+			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+		else
+			reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
+	}
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+		if (enable && !dwc->dis_u2_susphy_quirk)
+			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+		else
+			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+	}
+}
+
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
+{
+	unsigned int hw_mode;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+
+	 /*
+	  * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE and
+	  * GUSB2PHYCFG.SUSPHY should be cleared during mode switching,
+	  * and they can be set after core initialization.
+	  */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD && !ignore_susphy) {
+		if (DWC3_GCTL_PRTCAP(reg) != mode)
+			dwc3_enable_susphy(dwc, false);
+	}
+
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	dwc->current_dr_role = mode;
+}
+
+static void __dwc3_set_mode(struct work_struct *work)
+{
+	struct dwc3 *dwc = work_to_dwc(work);
+	unsigned long flags;
+	int ret;
+	u32 reg;
+	u32 desired_dr_role;
+	int i;
+
+	mutex_lock(&dwc->mutex);
+	spin_lock_irqsave(&dwc->lock, flags);
+	desired_dr_role = dwc->desired_dr_role;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	pm_runtime_get_sync(dwc->dev);
+
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
+		dwc3_otg_update(dwc, 0);
+
+	if (!desired_dr_role)
+		goto out;
+
+	if (desired_dr_role == dwc->current_dr_role)
+		goto out;
+
+	if (desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
+		goto out;
+
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		dwc3_host_exit(dwc);
+		break;
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		dwc3_gadget_exit(dwc);
+		dwc3_event_buffers_cleanup(dwc);
+		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		dwc3_otg_exit(dwc);
+		spin_lock_irqsave(&dwc->lock, flags);
+		dwc->desired_otg_role = DWC3_OTG_ROLE_IDLE;
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_otg_update(dwc, 1);
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * When current_dr_role is not set, there's no role switching.
+	 * Only perform GCTL.CoreSoftReset when there's DRD role switching.
+	 */
+	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
+			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
+			desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+		reg |= DWC3_GCTL_CORESOFTRESET;
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+		/*
+		 * Wait for internal clocks to synchronized. DWC_usb31 and
+		 * DWC_usb32 may need at least 50ms (less for DWC_usb3). To
+		 * keep it consistent across different IPs, let's wait up to
+		 * 100ms before clearing GCTL.CORESOFTRESET.
+		 */
+		msleep(100);
+
+		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+		reg &= ~DWC3_GCTL_CORESOFTRESET;
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	dwc3_set_prtcap(dwc, desired_dr_role, false);
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	switch (desired_dr_role) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		ret = dwc3_host_init(dwc);
+		if (ret) {
+			dev_err(dwc->dev, "failed to initialize host\n");
+		} else {
+			if (dwc->usb2_phy)
+				otg_set_vbus(dwc->usb2_phy->otg, true);
+
+			for (i = 0; i < dwc->num_usb2_ports; i++)
+				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+			for (i = 0; i < dwc->num_usb3_ports; i++)
+				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
+
+			if (dwc->dis_split_quirk) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+				reg |= DWC3_GUCTL3_SPLITDISABLE;
+				dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+			}
+		}
+		break;
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		dwc3_core_soft_reset(dwc);
+
+		dwc3_event_buffers_setup(dwc);
+
+		if (dwc->usb2_phy)
+			otg_set_vbus(dwc->usb2_phy->otg, false);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
+
+		ret = dwc3_gadget_init(dwc);
+		if (ret)
+			dev_err(dwc->dev, "failed to initialize peripheral\n");
+		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		dwc3_otg_init(dwc);
+		dwc3_otg_update(dwc, 0);
+		break;
+	default:
+		break;
+	}
+
+out:
+	pm_runtime_mark_last_busy(dwc->dev);
+	pm_runtime_put_autosuspend(dwc->dev);
+	mutex_unlock(&dwc->mutex);
+}
+
+void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
+{
+	unsigned long flags;
+
+	if (dwc->dr_mode != USB_DR_MODE_OTG)
+		return;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->desired_dr_role = mode;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	queue_work(system_freezable_wq, &dwc->drd_work);
+}
+
+u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
+{
+	struct dwc3		*dwc = dep->dwc;
+	u32			reg;
+
+	dwc3_writel(dwc->regs, DWC3_GDBGFIFOSPACE,
+			DWC3_GDBGFIFOSPACE_NUM(dep->number) |
+			DWC3_GDBGFIFOSPACE_TYPE(type));
+
+	reg = dwc3_readl(dwc->regs, DWC3_GDBGFIFOSPACE);
+
+	return DWC3_GDBGFIFOSPACE_SPACE_AVAILABLE(reg);
 }
 
 /**
  * dwc3_core_soft_reset - Issues core soft reset and PHY reset
  * @dwc: pointer to our context structure
  */
-static int dwc3_core_soft_reset(struct dwc3 *dwc)
+int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
-
-	/* Before Resetting PHY, put Core in Reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg |= DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-
-	/* Assert USB3 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	reg |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
-
-	/* Assert USB2 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	reg |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-
-	mdelay(100);
-
-	/* Clear USB3 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	reg &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
-
-	/* Clear USB2 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	reg &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-
-	mdelay(100);
-
-	/* After PHYs are stable we can take Core out of reset state */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg &= ~DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	int		retries = 1000;
+
+	/*
+	 * We're resetting only the device side because, if we're in host mode,
+	 * XHCI driver will reset the host block. If dwc3 was configured for
+	 * host-only mode, then we can return early.
+	 */
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+		return 0;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	reg |= DWC3_DCTL_CSFTRST;
+	reg &= ~DWC3_DCTL_RUN_STOP;
+	dwc3_gadget_dctl_write_safe(dwc, reg);
+
+	/*
+	 * For DWC_usb31 controller 1.90a and later, the DCTL.CSFRST bit
+	 * is cleared only after all the clocks are synchronized. This can
+	 * take a little more than 50ms. Set the polling rate at 20ms
+	 * for 10 times instead.
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) || DWC3_IP_IS(DWC32))
+		retries = 10;
+
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			goto done;
+
+		if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) || DWC3_IP_IS(DWC32))
+			msleep(20);
+		else
+			udelay(1);
+	} while (--retries);
+
+	dev_warn(dwc->dev, "DWC3 controller soft reset failed.\n");
+	return -ETIMEDOUT;
+
+done:
+	/*
+	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
+	 * is cleared, we must wait at least 50ms before accessing the PHY
+	 * domain (synchronization delay).
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
+		msleep(50);
 
 	return 0;
 }
@@ -100,22 +372,25 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
- * @fladj: Value of GFLADJ_30MHZ to adjust frame length
  */
-static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
+static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 {
 	u32 reg;
+	u32 dft;
 
-	if (dwc->revision < DWC3_REVISION_250A)
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
 		return;
 
-	if (fladj == 0)
+	if (dwc->fladj == 0)
 		return;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
-	reg &= ~DWC3_GFLADJ_30MHZ_MASK;
-	reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL | fladj;
-	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
+	dft = reg & DWC3_GFLADJ_30MHZ_MASK;
+	if (dft != dwc->fladj) {
+		reg &= ~DWC3_GFLADJ_30MHZ_MASK;
+		reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL | dwc->fladj;
+		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
+	}
 }
 
 /**
@@ -125,7 +400,6 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
  *		from the default, this will set clock period in DWC3_GUCTL
  *		register.
  * @dwc: Pointer to our controller context structure
- * @ref_clk_per: reference clock period in ns
  */
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
@@ -140,6 +414,9 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 		if (!rate)
 			return;
 		period = NSEC_PER_SEC / rate;
+	} else if (dwc->ref_clk_per) {
+		period = dwc->ref_clk_per;
+		rate = NSEC_PER_SEC / period;
 	} else {
 		return;
 	}
@@ -149,7 +426,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
 	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
 
-	if (dwc->revision <= DWC3_REVISION_250A)
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
 		return;
 
 	/*
@@ -182,6 +459,10 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
 	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
 	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
+
+	if (dwc->gfladj_refclk_lpm_sel)
+		reg |=  DWC3_GFLADJ_REFCLK_LPM_SEL;
+
 	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
 }
 
@@ -193,7 +474,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
-	dma_free_coherent(evt->buf);
+	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);
 }
 
 /**
@@ -205,24 +486,25 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
  * otherwise ERR_PTR(errno).
  */
 static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
-		unsigned length)
+		unsigned int length)
 {
 	struct dwc3_event_buffer	*evt;
 
-	evt = devm_kzalloc((struct udevice *)dwc->dev, sizeof(*evt),
-			   GFP_KERNEL);
+	evt = devm_kzalloc(dwc->dev, sizeof(*evt), GFP_KERNEL);
 	if (!evt)
 		return ERR_PTR(-ENOMEM);
 
 	evt->dwc	= dwc;
 	evt->length	= length;
-	evt->buf	= dma_alloc_coherent(length,
-					     (unsigned long *)&evt->dma);
+	evt->cache	= devm_kzalloc(dwc->dev, length, GFP_KERNEL);
+	if (!evt->cache)
+		return ERR_PTR(-ENOMEM);
+
+	evt->buf	= dma_alloc_coherent(dwc->sysdev, length,
+			&evt->dma, GFP_KERNEL);
 	if (!evt->buf)
 		return ERR_PTR(-ENOMEM);
 
-	dwc3_flush_cache((uintptr_t)evt->buf, evt->length);
-
 	return evt;
 }
 
@@ -233,13 +515,10 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
 static void dwc3_free_event_buffers(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
-	int i;
 
-	for (i = 0; i < dwc->num_event_buffers; i++) {
-		evt = dwc->ev_buffs[i];
-		if (evt)
-			dwc3_free_one_event_buffer(dwc, evt);
-	}
+	evt = dwc->ev_buf;
+	if (evt)
+		dwc3_free_one_event_buffer(dwc, evt);
 }
 
 /**
@@ -250,29 +529,23 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
  * Returns 0 on success otherwise negative errno. In the error case, dwc
  * may contain some buffers allocated but not all which were requested.
  */
-static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
+static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 {
-	int			num;
-	int			i;
+	struct dwc3_event_buffer *evt;
+	unsigned int hw_mode;
 
-	num = DWC3_NUM_INT(dwc->hwparams.hwparams1);
-	dwc->num_event_buffers = num;
-
-	dwc->ev_buffs = memalign(CONFIG_SYS_CACHELINE_SIZE,
-				 sizeof(*dwc->ev_buffs) * num);
-	if (!dwc->ev_buffs)
-		return -ENOMEM;
-
-	for (i = 0; i < num; i++) {
-		struct dwc3_event_buffer	*evt;
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		dwc->ev_buf = NULL;
+		return 0;
+	}
 
-		evt = dwc3_alloc_one_event_buffer(dwc, length);
-		if (IS_ERR(evt)) {
-			dev_err(dwc->dev, "can't allocate event buffer\n");
-			return PTR_ERR(evt);
-		}
-		dwc->ev_buffs[i] = evt;
+	evt = dwc3_alloc_one_event_buffer(dwc, length);
+	if (IS_ERR(evt)) {
+		dev_err(dwc->dev, "can't allocate event buffer\n");
+		return PTR_ERR(evt);
 	}
+	dwc->ev_buf = evt;
 
 	return 0;
 }
@@ -283,134 +556,63 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
  *
  * Returns 0 on success otherwise negative errno.
  */
-static int dwc3_event_buffers_setup(struct dwc3 *dwc)
+int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
-	int				n;
+	u32				reg;
 
-	for (n = 0; n < dwc->num_event_buffers; n++) {
-		evt = dwc->ev_buffs[n];
-		dev_dbg(dwc->dev, "Event buf %p dma %08llx length %d\n",
-				evt->buf, (unsigned long long) evt->dma,
-				evt->length);
-
-		evt->lpos = 0;
-
-		dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(n),
-				lower_32_bits(evt->dma));
-		dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(n),
-				upper_32_bits(evt->dma));
-		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(n),
-				DWC3_GEVNTSIZ_SIZE(evt->length));
-		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(n), 0);
-	}
-
-	return 0;
-}
-
-static void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
-{
-	struct dwc3_event_buffer	*evt;
-	int				n;
-
-	for (n = 0; n < dwc->num_event_buffers; n++) {
-		evt = dwc->ev_buffs[n];
-
-		evt->lpos = 0;
-
-		dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(n), 0);
-		dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(n), 0);
-		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(n), DWC3_GEVNTSIZ_INTMASK
-				| DWC3_GEVNTSIZ_SIZE(0));
-		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(n), 0);
-	}
-}
-
-static int dwc3_alloc_scratch_buffers(struct dwc3 *dwc)
-{
-	if (!dwc->has_hibernation)
+	if (!dwc->ev_buf)
 		return 0;
 
-	if (!dwc->nr_scratch)
-		return 0;
-
-	dwc->scratchbuf = kmalloc_array(dwc->nr_scratch,
-			DWC3_SCRATCHBUF_SIZE, GFP_KERNEL);
-	if (!dwc->scratchbuf)
-		return -ENOMEM;
-
+	evt = dwc->ev_buf;
+	evt->lpos = 0;
+	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
+			lower_32_bits(evt->dma));
+	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
+			upper_32_bits(evt->dma));
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
+			DWC3_GEVNTSIZ_SIZE(evt->length));
+
+	/* Clear any stale event */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
 	return 0;
 }
 
-static int dwc3_setup_scratch_buffers(struct dwc3 *dwc)
+void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
-	dma_addr_t scratch_addr;
-	u32 param;
-	int ret;
-
-	if (!dwc->has_hibernation)
-		return 0;
-
-	if (!dwc->nr_scratch)
-		return 0;
-
-	scratch_addr = dma_map_single(dwc->scratchbuf,
-				      dwc->nr_scratch * DWC3_SCRATCHBUF_SIZE,
-				      DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dwc->dev, scratch_addr)) {
-		dev_err(dwc->dev, "failed to map scratch buffer\n");
-		ret = -EFAULT;
-		goto err0;
-	}
-
-	dwc->scratch_addr = scratch_addr;
-
-	param = lower_32_bits(scratch_addr);
-
-	ret = dwc3_send_gadget_generic_command(dwc,
-			DWC3_DGCMD_SET_SCRATCHPAD_ADDR_LO, param);
-	if (ret < 0)
-		goto err1;
-
-	param = upper_32_bits(scratch_addr);
-
-	ret = dwc3_send_gadget_generic_command(dwc,
-			DWC3_DGCMD_SET_SCRATCHPAD_ADDR_HI, param);
-	if (ret < 0)
-		goto err1;
+	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
-	return 0;
+	if (!dwc->ev_buf)
+		return;
+	/*
+	 * Exynos platforms may not be able to access event buffer if the
+	 * controller failed to halt on dwc3_core_exit().
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	if (!(reg & DWC3_DSTS_DEVCTRLHLT))
+		return;
 
-err1:
-	dma_unmap_single(scratch_addr, dwc->nr_scratch * DWC3_SCRATCHBUF_SIZE,
-			 DMA_BIDIRECTIONAL);
+	evt = dwc->ev_buf;
 
-err0:
-	return ret;
-}
+	evt->lpos = 0;
 
-static void dwc3_free_scratch_buffers(struct dwc3 *dwc)
-{
-	if (!dwc->has_hibernation)
-		return;
-
-	if (!dwc->nr_scratch)
-		return;
+	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0), 0);
+	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0), 0);
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), DWC3_GEVNTSIZ_INTMASK
+			| DWC3_GEVNTSIZ_SIZE(0));
 
-	dma_unmap_single(dwc->scratch_addr, dwc->nr_scratch *
-			 DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
-	kfree(dwc->scratchbuf);
+	/* Clear any stale event */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
 }
 
 static void dwc3_core_num_eps(struct dwc3 *dwc)
 {
 	struct dwc3_hwparams	*parms = &dwc->hwparams;
 
-	dwc->num_in_eps = DWC3_NUM_IN_EPS(parms);
-	dwc->num_out_eps = DWC3_NUM_EPS(parms) - dwc->num_in_eps;
-
-	dev_vdbg(dwc->dev, "found %d IN and %d OUT endpoints\n",
-			dwc->num_in_eps, dwc->num_out_eps);
+	dwc->num_eps = DWC3_NUM_EPS(parms);
 }
 
 static void dwc3_cache_hwparams(struct dwc3 *dwc)
@@ -426,58 +628,60 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 	parms->hwparams6 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
 	parms->hwparams7 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
 	parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
+
+	if (DWC3_IP_IS(DWC32))
+		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
-static void dwc3_hsphy_mode_setup(struct dwc3 *dwc)
+static void dwc3_config_soc_bus(struct dwc3 *dwc)
 {
-	enum usb_phy_interface hsphy_mode = dwc->hsphy_mode;
-	u32 reg;
+	if (dwc->gsbuscfg0_reqinfo != DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED) {
+		u32 reg;
 
-	/* Set dwc3 usb2 phy config */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-
-	switch (hsphy_mode) {
-	case USBPHY_INTERFACE_MODE_UTMI:
-		reg &= ~(DWC3_GUSB2PHYCFG_PHYIF_MASK |
-			DWC3_GUSB2PHYCFG_USBTRDTIM_MASK);
-		reg |= DWC3_GUSB2PHYCFG_PHYIF(UTMI_PHYIF_8_BIT) |
-			DWC3_GUSB2PHYCFG_USBTRDTIM(USBTRDTIM_UTMI_8_BIT);
-		break;
-	case USBPHY_INTERFACE_MODE_UTMIW:
-		reg &= ~(DWC3_GUSB2PHYCFG_PHYIF_MASK |
-			DWC3_GUSB2PHYCFG_USBTRDTIM_MASK);
-		reg |= DWC3_GUSB2PHYCFG_PHYIF(UTMI_PHYIF_16_BIT) |
-			DWC3_GUSB2PHYCFG_USBTRDTIM(USBTRDTIM_UTMI_16_BIT);
-		break;
-	default:
-		break;
+		reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+		reg &= ~DWC3_GSBUSCFG0_REQINFO(~0);
+		reg |= DWC3_GSBUSCFG0_REQINFO(dwc->gsbuscfg0_reqinfo);
+		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
 	}
+}
+
+static int dwc3_core_ulpi_init(struct dwc3 *dwc)
+{
+	int intf;
+	int ret = 0;
+
+	intf = DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3);
+
+	if (intf == DWC3_GHWPARAMS3_HSPHY_IFC_ULPI ||
+	    (intf == DWC3_GHWPARAMS3_HSPHY_IFC_UTMI_ULPI &&
+	     dwc->hsphy_interface &&
+	     !strncmp(dwc->hsphy_interface, "ulpi", 4)))
+		ret = dwc3_ulpi_init(dwc);
 
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	return ret;
 }
 
-/**
- * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
- * @dwc: Pointer to our controller context structure
- */
-static void dwc3_phy_setup(struct dwc3 *dwc)
+static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 {
 	u32 reg;
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(index));
 
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
-	 * to '0' during coreConsultant configuration. So default value
-	 * will be '0' when the core is reset. Application needs to set it
-	 * to '1' after the core initialization is completed.
+	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
+	 * PHYs. Also, this bit is not supposed to be used in normal operation.
 	 */
-	if (dwc->revision > DWC3_REVISION_194A)
-		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
+
+	/* Ensure the GUSB3PIPECTL.SUSPENDENABLE is cleared prior to phy init. */
+	reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
 
+	if (dwc->dis_rxdet_inp3_quirk)
+		reg |= DWC3_GUSB3PIPECTL_DISRXDETINP3;
+
 	if (dwc->req_p1p2p3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_REQP1P2P3;
 
@@ -496,140 +700,321 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->tx_de_emphasis_quirk)
 		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_de_emphasis);
 
-	if (dwc->dis_u3_susphy_quirk)
-		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
-
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(index), reg);
 
-	dwc3_hsphy_mode_setup(dwc);
+	return 0;
+}
 
-	mdelay(100);
+static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
+{
+	u32 reg;
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
 
-	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
-	 * '0' during coreConsultant configuration. So default value will
-	 * be '0' when the core is reset. Application needs to set it to
-	 * '1' after the core initialization is completed.
-	 */
-	if (dwc->revision > DWC3_REVISION_194A)
-		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+	/* Select the HS PHY interface */
+	switch (DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3)) {
+	case DWC3_GHWPARAMS3_HSPHY_IFC_UTMI_ULPI:
+		if (dwc->hsphy_interface &&
+				!strncmp(dwc->hsphy_interface, "utmi", 4)) {
+			reg &= ~DWC3_GUSB2PHYCFG_ULPI_UTMI;
+			break;
+		} else if (dwc->hsphy_interface &&
+				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
+			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
+		} else {
+			/* Relying on default value. */
+			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
+				break;
+		}
+		fallthrough;
+	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
+	default:
+		break;
+	}
 
-	if (dwc->dis_u2_susphy_quirk)
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	switch (dwc->hsphy_mode) {
+	case USBPHY_INTERFACE_MODE_UTMI:
+		reg &= ~(DWC3_GUSB2PHYCFG_PHYIF_MASK |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM_MASK);
+		reg |= DWC3_GUSB2PHYCFG_PHYIF(UTMI_PHYIF_8_BIT) |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM(USBTRDTIM_UTMI_8_BIT);
+		break;
+	case USBPHY_INTERFACE_MODE_UTMIW:
+		reg &= ~(DWC3_GUSB2PHYCFG_PHYIF_MASK |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM_MASK);
+		reg |= DWC3_GUSB2PHYCFG_PHYIF(UTMI_PHYIF_16_BIT) |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM(USBTRDTIM_UTMI_16_BIT);
+		break;
+	default:
+		break;
+	}
+
+	/* Ensure the GUSB2PHYCFG.SUSPHY is cleared prior to phy init. */
+	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	if (dwc->dis_enblslpm_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+	else
+		reg |= DWC3_GUSB2PHYCFG_ENBLSLPM;
 
-	if (dwc->dis_u2_freeclk_exists_quirk)
+	if (dwc->dis_u2_freeclk_exists_quirk || dwc->gfladj_refclk_lpm_sel)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-
-	mdelay(100);
-}
-
-/* set global incr burst type configuration registers */
-static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
-{
-	struct udevice *dev = dwc->dev;
-	u32 cfg;
-
-	if (!dwc->incrx_size)
-		return;
-
-	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
-
-	/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
-	cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
-	if (dwc->incrx_mode)
-		cfg |= DWC3_GSBUSCFG0_INCRBRSTENA;
-	switch (dwc->incrx_size) {
-	case 256:
-		cfg |= DWC3_GSBUSCFG0_INCR256BRSTENA;
-		break;
-	case 128:
-		cfg |= DWC3_GSBUSCFG0_INCR128BRSTENA;
-		break;
-	case 64:
-		cfg |= DWC3_GSBUSCFG0_INCR64BRSTENA;
-		break;
-	case 32:
-		cfg |= DWC3_GSBUSCFG0_INCR32BRSTENA;
-		break;
-	case 16:
-		cfg |= DWC3_GSBUSCFG0_INCR16BRSTENA;
-		break;
-	case 8:
-		cfg |= DWC3_GSBUSCFG0_INCR8BRSTENA;
-		break;
-	case 4:
-		cfg |= DWC3_GSBUSCFG0_INCR4BRSTENA;
-		break;
-	case 1:
-		break;
-	default:
-		dev_err(dev, "Invalid property\n");
-		break;
-	}
-
-	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
+	/*
+	 * Some ULPI USB PHY does not support internal VBUS supply, to drive
+	 * the CPEN pin requires the configuration of the ULPI DRVVBUSEXTERNAL
+	 * bit of OTG_CTRL register. Controller configures the USB2 PHY
+	 * ULPIEXTVBUSDRV bit[17] of the GUSB2PHYCFG register to drive vBus
+	 * with an external supply.
+	 */
+	if (dwc->ulpi_ext_vbus_drv)
+		reg |= DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
+
+	return 0;
 }
 
 /**
- * dwc3_core_init - Low-level initialization of DWC3 Core
+ * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
  * @dwc: Pointer to our controller context structure
  *
- * Returns 0 on success otherwise negative errno.
+ * Returns 0 on success. The USB PHY interfaces are configured but not
+ * initialized. The PHY interfaces and the PHYs get initialized together with
+ * the core in dwc3_core_init.
  */
-static int dwc3_core_init(struct dwc3 *dwc)
+static int dwc3_phy_setup(struct dwc3 *dwc)
 {
-	u32			hwparams4 = dwc->hwparams.hwparams4;
-	u32			reg;
-	int			ret;
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
+
+	return 0;
+}
+
+static int dwc3_phy_init(struct dwc3 *dwc)
+{
+	int ret;
+	int i;
+	int j;
+
+	usb_phy_init(dwc->usb2_phy);
+	usb_phy_init(dwc->usb3_phy);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = phy_init(dwc->usb2_generic_phy[i]);
+		if (ret < 0)
+			goto err_exit_usb2_phy;
+	}
+
+	for (j = 0; j < dwc->num_usb3_ports; j++) {
+		ret = phy_init(dwc->usb3_generic_phy[j]);
+		if (ret < 0)
+			goto err_exit_usb3_phy;
+	}
+
+	/*
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY to '0' during
+	 * coreConsultant configuration. So default value will be '0' when the
+	 * core is reset. Application needs to set it to '1' after the core
+	 * initialization is completed.
+	 *
+	 * Certain phy requires to be in P0 power state during initialization.
+	 * Make sure GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY are clear
+	 * prior to phy init to maintain in the P0 state.
+	 *
+	 * After phy initialization, some phy operations can only be executed
+	 * while in lower P states. Ensure GUSB3PIPECTL.SUSPENDENABLE and
+	 * GUSB2PHYCFG.SUSPHY are set soon after initialization to avoid
+	 * blocking phy ops.
+	 */
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
+		dwc3_enable_susphy(dwc, true);
+
+	return 0;
+
+err_exit_usb3_phy:
+	while (--j >= 0)
+		phy_exit(dwc->usb3_generic_phy[j]);
+
+err_exit_usb2_phy:
+	while (--i >= 0)
+		phy_exit(dwc->usb2_generic_phy[i]);
+
+	usb_phy_shutdown(dwc->usb3_phy);
+	usb_phy_shutdown(dwc->usb2_phy);
+
+	return ret;
+}
+
+static void dwc3_phy_exit(struct dwc3 *dwc)
+{
+	int i;
+
+	for (i = 0; i < dwc->num_usb3_ports; i++)
+		phy_exit(dwc->usb3_generic_phy[i]);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++)
+		phy_exit(dwc->usb2_generic_phy[i]);
+
+	usb_phy_shutdown(dwc->usb3_phy);
+	usb_phy_shutdown(dwc->usb2_phy);
+}
+
+static int dwc3_phy_power_on(struct dwc3 *dwc)
+{
+	int ret;
+	int i;
+	int j;
+
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = phy_power_on(dwc->usb2_generic_phy[i]);
+		if (ret < 0)
+			goto err_power_off_usb2_phy;
+	}
+
+	for (j = 0; j < dwc->num_usb3_ports; j++) {
+		ret = phy_power_on(dwc->usb3_generic_phy[j]);
+		if (ret < 0)
+			goto err_power_off_usb3_phy;
+	}
+
+	return 0;
+
+err_power_off_usb3_phy:
+	while (--j >= 0)
+		phy_power_off(dwc->usb3_generic_phy[j]);
+
+err_power_off_usb2_phy:
+	while (--i >= 0)
+		phy_power_off(dwc->usb2_generic_phy[i]);
+
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+
+	return ret;
+}
+
+static void dwc3_phy_power_off(struct dwc3 *dwc)
+{
+	int i;
+
+	for (i = 0; i < dwc->num_usb3_ports; i++)
+		phy_power_off(dwc->usb3_generic_phy[i]);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++)
+		phy_power_off(dwc->usb2_generic_phy[i]);
+
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+}
+
+static int dwc3_clk_enable(struct dwc3 *dwc)
+{
+	int ret;
+
+	ret = clk_prepare_enable(dwc->bus_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dwc->ref_clk);
+	if (ret)
+		goto disable_bus_clk;
+
+	ret = clk_prepare_enable(dwc->susp_clk);
+	if (ret)
+		goto disable_ref_clk;
+
+	ret = clk_prepare_enable(dwc->utmi_clk);
+	if (ret)
+		goto disable_susp_clk;
+
+	ret = clk_prepare_enable(dwc->pipe_clk);
+	if (ret)
+		goto disable_utmi_clk;
+
+	return 0;
+
+disable_utmi_clk:
+	clk_disable_unprepare(dwc->utmi_clk);
+disable_susp_clk:
+	clk_disable_unprepare(dwc->susp_clk);
+disable_ref_clk:
+	clk_disable_unprepare(dwc->ref_clk);
+disable_bus_clk:
+	clk_disable_unprepare(dwc->bus_clk);
+	return ret;
+}
+
+static void dwc3_clk_disable(struct dwc3 *dwc)
+{
+	clk_disable_unprepare(dwc->pipe_clk);
+	clk_disable_unprepare(dwc->utmi_clk);
+	clk_disable_unprepare(dwc->susp_clk);
+	clk_disable_unprepare(dwc->ref_clk);
+	clk_disable_unprepare(dwc->bus_clk);
+}
+
+static void dwc3_core_exit(struct dwc3 *dwc)
+{
+	dwc3_event_buffers_cleanup(dwc);
+	dwc3_phy_power_off(dwc);
+	dwc3_phy_exit(dwc);
+	dwc3_clk_disable(dwc);
+	reset_control_assert(dwc->reset);
+}
+
+static bool dwc3_core_is_valid(struct dwc3 *dwc)
+{
+	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
+	dwc->ip = DWC3_GSNPS_ID(reg);
+
 	/* This should read as U3 followed by revision number */
-	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000 &&
-	    (reg & DWC3_GSNPSID_MASK) != 0x33310000) {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		ret = -ENODEV;
-		goto err0;
+	if (DWC3_IP_IS(DWC3)) {
+		dwc->revision = reg;
+	} else if (DWC3_IP_IS(DWC31) || DWC3_IP_IS(DWC32)) {
+		dwc->revision = dwc3_readl(dwc->regs, DWC3_VER_NUMBER);
+		dwc->version_type = dwc3_readl(dwc->regs, DWC3_VER_TYPE);
+	} else {
+		return false;
 	}
-	dwc->revision = reg;
 
-	/* Handle USB2.0-only core configuration */
-	if (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
-			DWC3_GHWPARAMS3_SSPHY_IFC_DIS) {
-		if (dwc->maximum_speed == USB_SPEED_SUPER)
-			dwc->maximum_speed = USB_SPEED_HIGH;
-	}
-
-	/* issue device SoftReset too */
-	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
-	ret = read_poll_timeout(dwc3_readl, reg,
-				!(reg & DWC3_DCTL_CSFTRST),
-				1, 5000, dwc->regs, DWC3_DCTL);
-	if (ret) {
-		dev_err(dwc->dev, "Reset Timed Out\n");
-		ret = -ETIMEDOUT;
-		goto err0;
-	}
-
-	dwc3_phy_setup(dwc);
+	return true;
+}
 
-	ret = dwc3_core_soft_reset(dwc);
-	if (ret)
-		goto err0;
+static void dwc3_core_setup_global_control(struct dwc3 *dwc)
+{
+	unsigned int power_opt;
+	unsigned int hw_mode;
+	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	power_opt = DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1);
 
-	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
+	switch (power_opt) {
 	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
 		/**
 		 * WORKAROUND: DWC3 revisions between 2.10a and 2.50a have an
@@ -645,16 +1030,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		 */
 		if ((dwc->dr_mode == USB_DR_MODE_HOST ||
 				dwc->dr_mode == USB_DR_MODE_OTG) &&
-				(dwc->revision >= DWC3_REVISION_210A &&
-				dwc->revision <= DWC3_REVISION_250A))
+				DWC3_VER_IS_WITHIN(DWC3, 210A, 250A))
 			reg |= DWC3_GCTL_DSBLCLKGTNG | DWC3_GCTL_SOFITPSYNC;
 		else
 			reg &= ~DWC3_GCTL_DSBLCLKGTNG;
 		break;
 	case DWC3_GHWPARAMS1_EN_PWROPT_HIB:
-		/* enable hibernation here */
-		dwc->nr_scratch = DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(hwparams4);
-
 		/*
 		 * REVISIT Enabling this bit so that host-mode hibernation
 		 * will work. Device-mode hibernation is not yet implemented.
@@ -662,18 +1043,32 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		reg |= DWC3_GCTL_GBLHIBERNATIONEN;
 		break;
 	default:
-		dev_dbg(dwc->dev, "No power optimization available\n");
+		/* nothing */
+		break;
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
-		dev_dbg(dwc->dev, "it is on FPGA board\n");
+		dev_info(dwc->dev, "Running with FPGA optimizations\n");
 		dwc->is_fpga = true;
 	}
 
-	if(dwc->disable_scramble_quirk && !dwc->is_fpga)
-		WARN(true,
-		     "disable_scramble cannot be used on non-FPGA builds\n");
+	WARN_ONCE(dwc->disable_scramble_quirk && !dwc->is_fpga,
+			"disable_scramble cannot be used on non-FPGA builds\n");
 
 	if (dwc->disable_scramble_quirk && dwc->is_fpga)
 		reg |= DWC3_GCTL_DISSCRAMBLE;
@@ -689,101 +1084,566 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	 * and falls back to high-speed mode which causes
 	 * the device to enter a Connect/Disconnect loop
 	 */
-	if (dwc->revision < DWC3_REVISION_190A)
+	if (DWC3_VER_IS_PRIOR(DWC3, 190A))
 		reg |= DWC3_GCTL_U2RSTECN;
 
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+}
+
+static int dwc3_core_get_phy(struct dwc3 *dwc);
+static int dwc3_core_ulpi_init(struct dwc3 *dwc);
+
+/* set global incr burst type configuration registers */
+static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	/* incrx_mode : for INCR burst type. */
+	bool incrx_mode;
+	/* incrx_size : for size of INCRX burst. */
+	u32 incrx_size;
+	u32 *vals;
+	u32 cfg;
+	int ntype;
+	int ret;
+	int i;
+
+	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+
+	/*
+	 * Handle property "snps,incr-burst-type-adjustment".
+	 * Get the number of value from this property:
+	 * result <= 0, means this property is not supported.
+	 * result = 1, means INCRx burst mode supported.
+	 * result > 1, means undefined length burst mode supported.
+	 */
+	ntype = device_property_count_u32(dev, "snps,incr-burst-type-adjustment");
+	if (ntype <= 0)
+		return;
+
+	vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
+	if (!vals)
+		return;
+
+	/* Get INCR burst type, and parse it */
+	ret = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", vals, ntype);
+	if (ret) {
+		kfree(vals);
+		dev_err(dev, "Error to get property\n");
+		return;
+	}
+
+	incrx_size = *vals;
+
+	if (ntype > 1) {
+		/* INCRX (undefined length) burst mode */
+		incrx_mode = INCRX_UNDEF_LENGTH_BURST_MODE;
+		for (i = 1; i < ntype; i++) {
+			if (vals[i] > incrx_size)
+				incrx_size = vals[i];
+		}
+	} else {
+		/* INCRX burst mode */
+		incrx_mode = INCRX_BURST_MODE;
+	}
+
+	kfree(vals);
+
+	/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
+	cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
+	if (incrx_mode)
+		cfg |= DWC3_GSBUSCFG0_INCRBRSTENA;
+	switch (incrx_size) {
+	case 256:
+		cfg |= DWC3_GSBUSCFG0_INCR256BRSTENA;
+		break;
+	case 128:
+		cfg |= DWC3_GSBUSCFG0_INCR128BRSTENA;
+		break;
+	case 64:
+		cfg |= DWC3_GSBUSCFG0_INCR64BRSTENA;
+		break;
+	case 32:
+		cfg |= DWC3_GSBUSCFG0_INCR32BRSTENA;
+		break;
+	case 16:
+		cfg |= DWC3_GSBUSCFG0_INCR16BRSTENA;
+		break;
+	case 8:
+		cfg |= DWC3_GSBUSCFG0_INCR8BRSTENA;
+		break;
+	case 4:
+		cfg |= DWC3_GSBUSCFG0_INCR4BRSTENA;
+		break;
+	case 1:
+		break;
+	default:
+		dev_err(dev, "Invalid property\n");
+		break;
+	}
+
+	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
+}
+
+static void dwc3_set_power_down_clk_scale(struct dwc3 *dwc)
+{
+	u32 scale;
+	u32 reg;
+
+	if (!dwc->susp_clk)
+		return;
+
+	/*
+	 * The power down scale field specifies how many suspend_clk
+	 * periods fit into a 16KHz clock period. When performing
+	 * the division, round up the remainder.
+	 *
+	 * The power down scale value is calculated using the fastest
+	 * frequency of the suspend_clk. If it isn't fixed (but within
+	 * the accuracy requirement), the driver may not know the max
+	 * rate of the suspend_clk, so only update the power down scale
+	 * if the default is less than the calculated value from
+	 * clk_get_rate() or if the default is questionably high
+	 * (3x or more) to be within the requirement.
+	 */
+	scale = DIV_ROUND_UP(clk_get_rate(dwc->susp_clk), 16000);
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	if ((reg & DWC3_GCTL_PWRDNSCALE_MASK) < DWC3_GCTL_PWRDNSCALE(scale) ||
+	    (reg & DWC3_GCTL_PWRDNSCALE_MASK) > DWC3_GCTL_PWRDNSCALE(scale*3)) {
+		reg &= ~(DWC3_GCTL_PWRDNSCALE_MASK);
+		reg |= DWC3_GCTL_PWRDNSCALE(scale);
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	}
+}
+
+static void dwc3_config_threshold(struct dwc3 *dwc)
+{
+	u32 reg;
+	u8 rx_thr_num;
+	u8 rx_maxburst;
+	u8 tx_thr_num;
+	u8 tx_maxburst;
+
+	/*
+	 * Must config both number of packets and max burst settings to enable
+	 * RX and/or TX threshold.
+	 */
+	if (!DWC3_IP_IS(DWC3) && dwc->dr_mode == USB_DR_MODE_HOST) {
+		rx_thr_num = dwc->rx_thr_num_pkt_prd;
+		rx_maxburst = dwc->rx_max_burst_prd;
+		tx_thr_num = dwc->tx_thr_num_pkt_prd;
+		tx_maxburst = dwc->tx_max_burst_prd;
+
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC31_RXTHRNUMPKTSEL_PRD;
+
+			reg &= ~DWC31_RXTHRNUMPKT_PRD(~0);
+			reg |= DWC31_RXTHRNUMPKT_PRD(rx_thr_num);
+
+			reg &= ~DWC31_MAXRXBURSTSIZE_PRD(~0);
+			reg |= DWC31_MAXRXBURSTSIZE_PRD(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC31_TXTHRNUMPKTSEL_PRD;
+
+			reg &= ~DWC31_TXTHRNUMPKT_PRD(~0);
+			reg |= DWC31_TXTHRNUMPKT_PRD(tx_thr_num);
+
+			reg &= ~DWC31_MAXTXBURSTSIZE_PRD(~0);
+			reg |= DWC31_MAXTXBURSTSIZE_PRD(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	}
+
+	rx_thr_num = dwc->rx_thr_num_pkt;
+	rx_maxburst = dwc->rx_max_burst;
+	tx_thr_num = dwc->tx_thr_num_pkt;
+	tx_maxburst = dwc->tx_max_burst;
+
+	if (DWC3_IP_IS(DWC3)) {
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC3_GRXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC3_GRXTHRCFG_RXPKTCNT(~0);
+			reg |= DWC3_GRXTHRCFG_RXPKTCNT(rx_thr_num);
+
+			reg &= ~DWC3_GRXTHRCFG_MAXRXBURSTSIZE(~0);
+			reg |= DWC3_GRXTHRCFG_MAXRXBURSTSIZE(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC3_GTXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC3_GTXTHRCFG_TXPKTCNT(~0);
+			reg |= DWC3_GTXTHRCFG_TXPKTCNT(tx_thr_num);
+
+			reg &= ~DWC3_GTXTHRCFG_MAXTXBURSTSIZE(~0);
+			reg |= DWC3_GTXTHRCFG_MAXTXBURSTSIZE(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	} else {
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC31_GRXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC31_GRXTHRCFG_RXPKTCNT(~0);
+			reg |= DWC31_GRXTHRCFG_RXPKTCNT(rx_thr_num);
+
+			reg &= ~DWC31_GRXTHRCFG_MAXRXBURSTSIZE(~0);
+			reg |= DWC31_GRXTHRCFG_MAXRXBURSTSIZE(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC31_GTXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC31_GTXTHRCFG_TXPKTCNT(~0);
+			reg |= DWC31_GTXTHRCFG_TXPKTCNT(tx_thr_num);
+
+			reg &= ~DWC31_GTXTHRCFG_MAXTXBURSTSIZE(~0);
+			reg |= DWC31_GTXTHRCFG_MAXTXBURSTSIZE(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	}
+}
+
+/**
+ * dwc3_core_init - Low-level initialization of DWC3 Core
+ * @dwc: Pointer to our controller context structure
+ *
+ * Returns 0 on success otherwise negative errno.
+ */
+static int dwc3_core_init(struct dwc3 *dwc)
+{
+	unsigned int		hw_mode;
+	u32			reg;
+	int			ret;
+
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+
+	/*
+	 * Write Linux Version Code to our GUID register so it's easy to figure
+	 * out which kernel version a bug was found.
+	 */
+	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
+
+	ret = dwc3_phy_setup(dwc);
+	if (ret)
+		return ret;
+
+	if (!dwc->ulpi_ready) {
+		ret = dwc3_core_ulpi_init(dwc);
+		if (ret) {
+			if (ret == -ETIMEDOUT) {
+				dwc3_core_soft_reset(dwc);
+				ret = -EPROBE_DEFER;
+			}
+			return ret;
+		}
+		dwc->ulpi_ready = true;
+	}
+
+	if (!dwc->phys_ready) {
+		ret = dwc3_core_get_phy(dwc);
+		if (ret)
+			goto err_exit_ulpi;
+		dwc->phys_ready = true;
+	}
+
+	ret = dwc3_phy_init(dwc);
+	if (ret)
+		goto err_exit_ulpi;
+
+	ret = dwc3_core_soft_reset(dwc);
+	if (ret)
+		goto err_exit_phy;
+
+	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-
-	ret = dwc3_alloc_scratch_buffers(dwc);
-	if (ret)
-		goto err0;
-
-	ret = dwc3_setup_scratch_buffers(dwc);
-	if (ret)
-		goto err1;
+	/* Set power down scale of suspend_clk */
+	dwc3_set_power_down_clk_scale(dwc);
 
 	/* Adjust Frame Length */
-	dwc3_frame_length_adjustment(dwc, dwc->fladj);
+	dwc3_frame_length_adjustment(dwc);
 
 	/* Adjust Reference Clock Period */
 	dwc3_ref_clk_period(dwc);
 
 	dwc3_set_incr_burst_type(dwc);
 
+	dwc3_config_soc_bus(dwc);
+
+	ret = dwc3_phy_power_on(dwc);
+	if (ret)
+		goto err_exit_phy;
+
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto err_power_off_phy;
+	}
+
+	/*
+	 * ENDXFER polling is available on version 3.10a and later of
+	 * the DWC_usb3 controller. It is NOT available in the
+	 * DWC_usb31 controller.
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC3, 310A, ANY)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
+		reg |= DWC3_GUCTL2_RST_ACTBITLATER;
+		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
+	}
+
+	/*
+	 * STAR 9001285599: This issue affects DWC_usb3 version 3.20a
+	 * only. If the PM TIMER ECM is enabled through GUCTL2[19], the
+	 * link compliance test (TD7.21) may fail. If the ECN is not
+	 * enabled (GUCTL2[19] = 0), the controller will use the old timer
+	 * value (5us), which is still acceptable for the link compliance
+	 * test. Therefore, do not enable PM TIMER ECM in 3.20a by
+	 * setting GUCTL2[19] by default; instead, use GUCTL2[19] = 0.
+	 */
+	if (DWC3_VER_IS(DWC3, 320A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
+		reg &= ~DWC3_GUCTL2_LC_TIMER;
+		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
+	}
+
+	/*
+	 * When configured in HOST mode, after issuing U3/L2 exit controller
+	 * fails to send proper CRC checksum in CRC5 field. Because of this
+	 * behaviour Transaction Error is generated, resulting in reset and
+	 * re-enumeration of usb device attached. All the termsel, xcvrsel,
+	 * opmode becomes 0 during end of resume. Enabling bit 10 of GUCTL1
+	 * will correct this problem. This option is to support certain
+	 * legacy ULPI PHYs.
+	 */
+	if (dwc->resume_hs_terminations) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+		reg |= DWC3_GUCTL1_RESUME_OPMODE_HS_HOST;
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+	}
+
+	if (!DWC3_VER_IS_PRIOR(DWC3, 250A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+
+		/*
+		 * Enable hardware control of sending remote wakeup
+		 * in HS when the device is in the L1 state.
+		 */
+		if (!DWC3_VER_IS_PRIOR(DWC3, 290A))
+			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
+
+		/*
+		 * Decouple USB 2.0 L1 & L2 events which will allow for
+		 * gadget driver to only receive U3/L2 suspend & wakeup
+		 * events and prevent the more frequent L1 LPM transitions
+		 * from interrupting the driver.
+		 */
+		if (!DWC3_VER_IS_PRIOR(DWC3, 300A))
+			reg |= DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT;
+
+		if (dwc->dis_tx_ipgap_linecheck_quirk)
+			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
+
+		if (dwc->parkmode_disable_ss_quirk)
+			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
+
+		if (dwc->parkmode_disable_hs_quirk)
+			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_HS;
+
+		if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY)) {
+			if (dwc->maximum_speed == USB_SPEED_FULL ||
+			    dwc->maximum_speed == USB_SPEED_HIGH)
+				reg |= DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
+			else
+				reg &= ~DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
+		}
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+	}
+
+	dwc3_config_threshold(dwc);
+
+	/*
+	 * Modify this for all supported Super Speed ports when
+	 * multiport support is added.
+	 */
+	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
+	    (DWC3_IP_IS(DWC31)) &&
+	    dwc->maximum_speed == USB_SPEED_SUPER) {
+		int i;
+
+		for (i = 0; i < dwc->num_usb3_ports; i++) {
+			reg = dwc3_readl(dwc->regs, DWC3_LLUCTL(i));
+			reg |= DWC3_LLUCTL_FORCE_GEN1;
+			dwc3_writel(dwc->regs, DWC3_LLUCTL(i), reg);
+		}
+	}
+
+	/*
+	 * STAR 9001346572: This issue affects DWC_usb31 versions 1.80a and
+	 * prior. When an active endpoint not currently cached in the host
+	 * controller is chosen to be cached to the same index as an endpoint
+	 * receiving NAKs, the endpoint receiving NAKs enters continuous
+	 * retry mode. This prevents it from being evicted from the host
+	 * controller cache, blocking the new endpoint from being cached and
+	 * serviced.
+	 *
+	 * To resolve this, for controller versions 1.70a and 1.80a, set the
+	 * GUCTL3 bit[16] (USB2.0 Internal Retry Disable) to 1. This bit
+	 * disables the USB2.0 internal retry feature. The GUCTL3[16] register
+	 * function is available only from version 1.70a.
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC31, 170A, 180A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+		reg |= DWC3_GUCTL3_USB20_RETRY_DISABLE;
+		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+	}
+
 	return 0;
 
-err1:
-	dwc3_free_scratch_buffers(dwc);
+err_power_off_phy:
+	dwc3_phy_power_off(dwc);
+err_exit_phy:
+	dwc3_phy_exit(dwc);
+err_exit_ulpi:
+	dwc3_ulpi_exit(dwc);
 
-err0:
 	return ret;
 }
 
-static void dwc3_core_exit(struct dwc3 *dwc)
+static int dwc3_core_get_phy(struct dwc3 *dwc)
 {
-	dwc3_free_scratch_buffers(dwc);
+	struct device		*dev = dwc->dev;
+	struct device_node	*node = dev->of_node;
+	char phy_name[9];
+	int ret;
+	u8 i;
+
+	if (node) {
+		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
+		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
+	} else {
+		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
+	}
+
+	if (IS_ERR(dwc->usb2_phy)) {
+		ret = PTR_ERR(dwc->usb2_phy);
+		if (ret == -ENXIO || ret == -ENODEV)
+			dwc->usb2_phy = NULL;
+		else
+			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
+	}
+
+	if (IS_ERR(dwc->usb3_phy)) {
+		ret = PTR_ERR(dwc->usb3_phy);
+		if (ret == -ENXIO || ret == -ENODEV)
+			dwc->usb3_phy = NULL;
+		else
+			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
+	}
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		if (dwc->num_usb2_ports == 1)
+			snprintf(phy_name, sizeof(phy_name), "usb2-phy");
+		else
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
+	}
+
+	for (i = 0; i < dwc->num_usb3_ports; i++) {
+		if (dwc->num_usb3_ports == 1)
+			snprintf(phy_name, sizeof(phy_name), "usb3-phy");
+		else
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
+	}
+
+	return 0;
 }
 
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
+	struct device *dev = dwc->dev;
 	int ret;
+	int i;
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
+
+		if (dwc->usb2_phy)
+			otg_set_vbus(dwc->usb2_phy->otg, false);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
+
 		ret = dwc3_gadget_init(dwc);
-		if (ret) {
-			dev_err(dwc->dev, "failed to initialize gadget\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to initialize gadget\n");
 		break;
 	case USB_DR_MODE_HOST:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
+
+		if (dwc->usb2_phy)
+			otg_set_vbus(dwc->usb2_phy->otg, true);
+		for (i = 0; i < dwc->num_usb2_ports; i++)
+			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+		for (i = 0; i < dwc->num_usb3_ports; i++)
+			phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
+
 		ret = dwc3_host_init(dwc);
-		if (ret) {
-			dev_err(dwc->dev, "failed to initialize host\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to initialize host\n");
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
-		ret = dwc3_host_init(dwc);
-		if (ret) {
-			dev_err(dwc->dev, "failed to initialize host\n");
-			return ret;
-		}
-
-		ret = dwc3_gadget_init(dwc);
-		if (ret) {
-			dev_err(dwc->dev, "failed to initialize gadget\n");
-			return ret;
-		}
+		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
+		ret = dwc3_drd_init(dwc);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to initialize dual-role\n");
 		break;
 	default:
-		dev_err(dwc->dev,
-			"Unsupported mode of operation %d\n", dwc->dr_mode);
+		dev_err(dev, "Unsupported mode of operation %d\n", dwc->dr_mode);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static void dwc3_gadget_run(struct dwc3 *dwc)
-{
-	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_RUN_STOP);
-	mdelay(100);
-}
-
-static void dwc3_core_stop(struct dwc3 *dwc)
-{
-	u32 reg;
-
-	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg & ~(DWC3_DCTL_RUN_STOP));
-}
-
 static void dwc3_core_exit_mode(struct dwc3 *dwc)
 {
 	switch (dwc->dr_mode) {
@@ -794,60 +1654,57 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 		dwc3_host_exit(dwc);
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_host_exit(dwc);
-		dwc3_gadget_exit(dwc);
+		dwc3_drd_exit(dwc);
 		break;
 	default:
 		/* do nothing */
 		break;
 	}
 
+	/* de-assert DRVVBUS for HOST and OTG mode */
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
+}
+
+static void dwc3_get_software_properties(struct dwc3 *dwc)
+{
+	struct device *tmpdev;
+	u16 gsbuscfg0_reqinfo;
+	int ret;
+
+	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
+
 	/*
-	 * switch back to peripheral mode
-	 * This enables the phy to enter idle and then, if enabled, suspend.
+	 * Iterate over all parent nodes for finding swnode properties
+	 * and non-DT (non-ABI) properties.
 	 */
-	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-	dwc3_gadget_run(dwc);
+	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
+		ret = device_property_read_u16(tmpdev,
+					       "snps,gsbuscfg0-reqinfo",
+					       &gsbuscfg0_reqinfo);
+		if (!ret)
+			dwc->gsbuscfg0_reqinfo = gsbuscfg0_reqinfo;
+	}
 }
 
-#define DWC3_ALIGN_MASK		(16 - 1)
-
-/**
- * dwc3_uboot_init - dwc3 core uboot initialization code
- * @dwc3_dev: struct dwc3_device containing initialization data
- *
- * Entry point for dwc3 driver (equivalent to dwc3_probe in linux
- * kernel driver). Pointer to dwc3_device should be passed containing
- * base address and other initialization data. Returns '0' on success and
- * a negative value on failure.
- *
- * Generally called from board_usb_init() implemented in board file.
- */
-int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
+static void dwc3_get_properties(struct dwc3 *dwc)
 {
-	struct dwc3		*dwc;
-	struct device		*dev = NULL;
+	struct device		*dev = dwc->dev;
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
-
-	int			ret;
-
-	void			*mem;
-
-	mem = devm_kzalloc((struct udevice *)dev,
-			   sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
-	if (!mem)
-		return -ENOMEM;
-
-	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
-	dwc->mem = mem;
-
-	dwc->regs = (void *)(uintptr_t)(dwc3_dev->base +
-					DWC3_GLOBALS_REGS_START);
+	u8			rx_thr_num_pkt = 0;
+	u8			rx_max_burst = 0;
+	u8			tx_thr_num_pkt = 0;
+	u8			tx_max_burst = 0;
+	u8			rx_thr_num_pkt_prd = 0;
+	u8			rx_max_burst_prd = 0;
+	u8			tx_thr_num_pkt_prd = 0;
+	u8			tx_max_burst_prd = 0;
+	u8			tx_fifo_resize_max_num;
+	u16			num_hc_interrupters;
 
 	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xff;
+	lpm_nyet_threshold = 0xf;
 
 	/* default to -3.5dB de-emphasis */
 	tx_de_emphasis = 1;
@@ -858,368 +1715,1100 @@ int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
 	 */
 	hird_threshold = 12;
 
-	dwc->maximum_speed = dwc3_dev->maximum_speed;
-	dwc->has_lpm_erratum = dwc3_dev->has_lpm_erratum;
-	if (dwc3_dev->lpm_nyet_threshold)
-		lpm_nyet_threshold = dwc3_dev->lpm_nyet_threshold;
-	dwc->is_utmi_l1_suspend = dwc3_dev->is_utmi_l1_suspend;
-	if (dwc3_dev->hird_threshold)
-		hird_threshold = dwc3_dev->hird_threshold;
-
-	dwc->needs_fifo_resize = dwc3_dev->tx_fifo_resize;
-	dwc->dr_mode = dwc3_dev->dr_mode;
-
-	dwc->disable_scramble_quirk = dwc3_dev->disable_scramble_quirk;
-	dwc->u2exit_lfps_quirk = dwc3_dev->u2exit_lfps_quirk;
-	dwc->u2ss_inp3_quirk = dwc3_dev->u2ss_inp3_quirk;
-	dwc->req_p1p2p3_quirk = dwc3_dev->req_p1p2p3_quirk;
-	dwc->del_p1p2p3_quirk = dwc3_dev->del_p1p2p3_quirk;
-	dwc->del_phy_power_chg_quirk = dwc3_dev->del_phy_power_chg_quirk;
-	dwc->lfps_filter_quirk = dwc3_dev->lfps_filter_quirk;
-	dwc->rx_detect_poll_quirk = dwc3_dev->rx_detect_poll_quirk;
-	dwc->dis_u3_susphy_quirk = dwc3_dev->dis_u3_susphy_quirk;
-	dwc->dis_u2_susphy_quirk = dwc3_dev->dis_u2_susphy_quirk;
-	dwc->dis_del_phy_power_chg_quirk = dwc3_dev->dis_del_phy_power_chg_quirk;
-	dwc->dis_tx_ipgap_linecheck_quirk = dwc3_dev->dis_tx_ipgap_linecheck_quirk;
-	dwc->dis_enblslpm_quirk = dwc3_dev->dis_enblslpm_quirk;
-	dwc->dis_u2_freeclk_exists_quirk = dwc3_dev->dis_u2_freeclk_exists_quirk;
-
-	dwc->tx_de_emphasis_quirk = dwc3_dev->tx_de_emphasis_quirk;
-	if (dwc3_dev->tx_de_emphasis)
-		tx_de_emphasis = dwc3_dev->tx_de_emphasis;
-
-	/* default to superspeed if no maximum_speed passed */
-	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
-		dwc->maximum_speed = USB_SPEED_SUPER;
-
-	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
-	dwc->tx_de_emphasis = tx_de_emphasis;
-
-	dwc->hird_threshold = hird_threshold
-		| (dwc->is_utmi_l1_suspend << 4);
-
-	dwc->hsphy_mode = dwc3_dev->hsphy_mode;
-
-	dwc->index = dwc3_dev->index;
-
-	dwc3_cache_hwparams(dwc);
-
-	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
-	if (ret) {
-		dev_err(dwc->dev, "failed to allocate event buffers\n");
-		return -ENOMEM;
-	}
-
-	if (!IS_ENABLED(CONFIG_USB_DWC3_GADGET))
-		dwc->dr_mode = USB_DR_MODE_HOST;
-	else if (!IS_ENABLED(CONFIG_USB_HOST))
-		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
-
-	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
-		dwc->dr_mode = USB_DR_MODE_OTG;
-
-	ret = dwc3_core_init(dwc);
-	if (ret) {
-		dev_err(dwc->dev, "failed to initialize core\n");
-		goto err0;
-	}
-
-	ret = dwc3_event_buffers_setup(dwc);
-	if (ret) {
-		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err1;
-	}
-
-	ret = dwc3_core_init_mode(dwc);
-	if (ret)
-		goto err2;
-
-	list_add_tail(&dwc->list, &dwc3_list);
-
-	return 0;
-
-err2:
-	dwc3_event_buffers_cleanup(dwc);
-
-err1:
-	dwc3_core_exit(dwc);
-
-err0:
-	dwc3_free_event_buffers(dwc);
-
-	return ret;
-}
-
-/**
- * dwc3_uboot_exit - dwc3 core uboot cleanup code
- * @index: index of this controller
- *
- * Performs cleanup of memory allocated in dwc3_uboot_init and other misc
- * cleanups (equivalent to dwc3_remove in linux). index of _this_ controller
- * should be passed and should match with the index passed in
- * dwc3_device during init.
- *
- * Generally called from board file.
- */
-void dwc3_uboot_exit(int index)
-{
-	struct dwc3 *dwc;
-
-	list_for_each_entry(dwc, &dwc3_list, list) {
-		if (dwc->index != index)
-			continue;
-
-		dwc3_core_exit_mode(dwc);
-		dwc3_event_buffers_cleanup(dwc);
-		dwc3_free_event_buffers(dwc);
-		dwc3_core_exit(dwc);
-		list_del(&dwc->list);
-		kfree(dwc->mem);
-		break;
-	}
-}
-
-MODULE_ALIAS("platform:dwc3");
-MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
-
-#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
-__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
-{
-	return 1;
-}
-
-/**
- * dm_usb_gadget_handle_interrupts - handle dwc3 core interrupt
- * @dev: device of this controller
- *
- * Invokes dwc3 gadget interrupts.
- *
- * Generally called from board file.
- */
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	struct dwc3 *dwc = NULL;
-
-	if (!dwc3_uboot_interrupt_status(dev))
-		return 0;
-
-	list_for_each_entry(dwc, &dwc3_list, list) {
-		if (dwc->dev != dev)
-			continue;
-
-		dwc3_gadget_uboot_handle_interrupt(dwc);
-		break;
-	}
-
-	return 0;
-}
-#endif
-
-#if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
-int dwc3_setup_phy(struct udevice *dev, struct phy_bulk *phys)
-{
-	int ret;
-
-	ret = generic_phy_get_bulk(dev, phys);
-	if (ret)
-		return ret;
-
-	ret = generic_phy_init_bulk(phys);
-	if (ret)
-		return ret;
-
-	ret = generic_phy_power_on_bulk(phys);
-	if (ret)
-		generic_phy_exit_bulk(phys);
-
-	return ret;
-}
-
-int dwc3_shutdown_phy(struct udevice *dev, struct phy_bulk *phys)
-{
-	int ret;
+	/*
+	 * default to a TXFIFO size large enough to fit 6 max packets.  This
+	 * allows for systems with larger bus latencies to have some headroom
+	 * for endpoints that have a large bMaxBurst value.
+	 */
+	tx_fifo_resize_max_num = 6;
 
-	ret = generic_phy_power_off_bulk(phys);
-	ret |= generic_phy_exit_bulk(phys);
-	return ret;
-}
-#endif
+	/* default to a single XHCI interrupter */
+	num_hc_interrupters = 1;
 
-#if CONFIG_IS_ENABLED(DM_USB)
-void dwc3_of_parse(struct dwc3 *dwc)
-{
-	const u8 *tmp;
-	struct udevice *dev = dwc->dev;
-	u8 lpm_nyet_threshold;
-	u8 tx_de_emphasis;
-	u8 hird_threshold;
-	u32 val;
-	int i;
+	dwc->maximum_speed = usb_get_maximum_speed(dev);
+	dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
+	dwc->dr_mode = usb_get_dr_mode(dev);
+	dwc->hsphy_mode = of_usb_get_phy_mode(dev->of_node);
 
-	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xff;
-
-	/* default to -3.5dB de-emphasis */
-	tx_de_emphasis = 1;
-
-	/*
-	 * default to assert utmi_sleep_n and use maximum allowed HIRD
-	 * threshold value of 0b1100
-	 */
-	hird_threshold = 12;
+	dwc->sysdev_is_parent = device_property_read_bool(dev,
+				"linux,sysdev_is_parent");
+	if (dwc->sysdev_is_parent)
+		dwc->sysdev = dwc->dev->parent;
+	else
+		dwc->sysdev = dwc->dev;
 
-	dwc->hsphy_mode = usb_get_phy_mode(dev_ofnode(dev));
+	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
 
-	dwc->has_lpm_erratum = dev_read_bool(dev,
+	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
-	tmp = dev_read_u8_array_ptr(dev, "snps,lpm-nyet-threshold", 1);
-	if (tmp)
-		lpm_nyet_threshold = *tmp;
-
-	dwc->is_utmi_l1_suspend = dev_read_bool(dev,
+	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
+				&lpm_nyet_threshold);
+	dwc->is_utmi_l1_suspend = device_property_read_bool(dev,
 				"snps,is-utmi-l1-suspend");
-	tmp = dev_read_u8_array_ptr(dev, "snps,hird-threshold", 1);
-	if (tmp)
-		hird_threshold = *tmp;
+	device_property_read_u8(dev, "snps,hird-threshold",
+				&hird_threshold);
+	dwc->dis_start_transfer_quirk = device_property_read_bool(dev,
+				"snps,dis-start-transfer-quirk");
+	dwc->usb3_lpm_capable = device_property_read_bool(dev,
+				"snps,usb3_lpm_capable");
+	dwc->usb2_lpm_disable = device_property_read_bool(dev,
+				"snps,usb2-lpm-disable");
+	dwc->usb2_gadget_lpm_disable = device_property_read_bool(dev,
+				"snps,usb2-gadget-lpm-disable");
+	device_property_read_u8(dev, "snps,rx-thr-num-pkt",
+				&rx_thr_num_pkt);
+	device_property_read_u8(dev, "snps,rx-max-burst",
+				&rx_max_burst);
+	device_property_read_u8(dev, "snps,tx-thr-num-pkt",
+				&tx_thr_num_pkt);
+	device_property_read_u8(dev, "snps,tx-max-burst",
+				&tx_max_burst);
+	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
+				&rx_thr_num_pkt_prd);
+	device_property_read_u8(dev, "snps,rx-max-burst-prd",
+				&rx_max_burst_prd);
+	device_property_read_u8(dev, "snps,tx-thr-num-pkt-prd",
+				&tx_thr_num_pkt_prd);
+	device_property_read_u8(dev, "snps,tx-max-burst-prd",
+				&tx_max_burst_prd);
+	device_property_read_u16(dev, "num-hc-interrupters",
+				 &num_hc_interrupters);
+	/* DWC3 core allowed to have a max of 8 interrupters */
+	if (num_hc_interrupters > 8)
+		num_hc_interrupters = 8;
 
-	dwc->disable_scramble_quirk = dev_read_bool(dev,
+	dwc->do_fifo_resize = device_property_read_bool(dev,
+							"tx-fifo-resize");
+	if (dwc->do_fifo_resize)
+		device_property_read_u8(dev, "tx-fifo-max-num",
+					&tx_fifo_resize_max_num);
+
+	dwc->disable_scramble_quirk = device_property_read_bool(dev,
 				"snps,disable_scramble_quirk");
-	dwc->u2exit_lfps_quirk = dev_read_bool(dev,
+	dwc->u2exit_lfps_quirk = device_property_read_bool(dev,
 				"snps,u2exit_lfps_quirk");
-	dwc->u2ss_inp3_quirk = dev_read_bool(dev,
+	dwc->u2ss_inp3_quirk = device_property_read_bool(dev,
 				"snps,u2ss_inp3_quirk");
-	dwc->req_p1p2p3_quirk = dev_read_bool(dev,
+	dwc->req_p1p2p3_quirk = device_property_read_bool(dev,
 				"snps,req_p1p2p3_quirk");
-	dwc->del_p1p2p3_quirk = dev_read_bool(dev,
+	dwc->del_p1p2p3_quirk = device_property_read_bool(dev,
 				"snps,del_p1p2p3_quirk");
-	dwc->del_phy_power_chg_quirk = dev_read_bool(dev,
+	dwc->del_phy_power_chg_quirk = device_property_read_bool(dev,
 				"snps,del_phy_power_chg_quirk");
-	dwc->lfps_filter_quirk = dev_read_bool(dev,
+	dwc->lfps_filter_quirk = device_property_read_bool(dev,
 				"snps,lfps_filter_quirk");
-	dwc->rx_detect_poll_quirk = dev_read_bool(dev,
+	dwc->rx_detect_poll_quirk = device_property_read_bool(dev,
 				"snps,rx_detect_poll_quirk");
-	dwc->dis_u3_susphy_quirk = dev_read_bool(dev,
+	dwc->dis_u3_susphy_quirk = device_property_read_bool(dev,
 				"snps,dis_u3_susphy_quirk");
-	dwc->dis_u2_susphy_quirk = dev_read_bool(dev,
+	dwc->dis_u2_susphy_quirk = device_property_read_bool(dev,
 				"snps,dis_u2_susphy_quirk");
-	dwc->dis_del_phy_power_chg_quirk = dev_read_bool(dev,
-				"snps,dis-del-phy-power-chg-quirk");
-	dwc->dis_tx_ipgap_linecheck_quirk = dev_read_bool(dev,
-				"snps,dis-tx-ipgap-linecheck-quirk");
-	dwc->dis_enblslpm_quirk = dev_read_bool(dev,
+	dwc->dis_enblslpm_quirk = device_property_read_bool(dev,
 				"snps,dis_enblslpm_quirk");
-	dwc->dis_u2_freeclk_exists_quirk = dev_read_bool(dev,
+	dwc->dis_u1_entry_quirk = device_property_read_bool(dev,
+				"snps,dis-u1-entry-quirk");
+	dwc->dis_u2_entry_quirk = device_property_read_bool(dev,
+				"snps,dis-u2-entry-quirk");
+	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
+				"snps,dis_rxdet_inp3_quirk");
+	dwc->dis_u2_freeclk_exists_quirk = device_property_read_bool(dev,
 				"snps,dis-u2-freeclk-exists-quirk");
-	dwc->tx_de_emphasis_quirk = dev_read_bool(dev,
+	dwc->dis_del_phy_power_chg_quirk = device_property_read_bool(dev,
+				"snps,dis-del-phy-power-chg-quirk");
+	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
+				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->resume_hs_terminations = device_property_read_bool(dev,
+				"snps,resume-hs-terminations");
+	dwc->ulpi_ext_vbus_drv = device_property_read_bool(dev,
+				"snps,ulpi-ext-vbus-drv");
+	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
+				"snps,parkmode-disable-ss-quirk");
+	dwc->parkmode_disable_hs_quirk = device_property_read_bool(dev,
+				"snps,parkmode-disable-hs-quirk");
+	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
+				"snps,gfladj-refclk-lpm-sel-quirk");
+
+	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
-	tmp = dev_read_u8_array_ptr(dev, "snps,tx_de_emphasis", 1);
-	if (tmp)
-		tx_de_emphasis = *tmp;
+	device_property_read_u8(dev, "snps,tx_de_emphasis",
+				&tx_de_emphasis);
+	device_property_read_string(dev, "snps,hsphy_interface",
+				    &dwc->hsphy_interface);
+	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
+				 &dwc->fladj);
+	device_property_read_u32(dev, "snps,ref-clock-period-ns",
+				 &dwc->ref_clk_per);
+
+	dwc->dis_metastability_quirk = device_property_read_bool(dev,
+				"snps,dis_metastability_quirk");
+
+	dwc->dis_split_quirk = device_property_read_bool(dev,
+				"snps,dis-split-quirk");
 
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
-	dwc->hird_threshold = hird_threshold
-		| (dwc->is_utmi_l1_suspend << 4);
+	dwc->hird_threshold = hird_threshold;
 
-	dev_read_u32(dev, "snps,quirk-frame-length-adjustment", &dwc->fladj);
+	dwc->rx_thr_num_pkt = rx_thr_num_pkt;
+	dwc->rx_max_burst = rx_max_burst;
+
+	dwc->tx_thr_num_pkt = tx_thr_num_pkt;
+	dwc->tx_max_burst = tx_max_burst;
+
+	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
+	dwc->rx_max_burst_prd = rx_max_burst_prd;
+
+	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
+	dwc->tx_max_burst_prd = tx_max_burst_prd;
+
+	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
+
+	dwc->num_hc_interrupters = num_hc_interrupters;
+}
+
+/* check whether the core supports IMOD */
+bool dwc3_has_imod(struct dwc3 *dwc)
+{
+	return DWC3_VER_IS_WITHIN(DWC3, 300A, ANY) ||
+		DWC3_VER_IS_WITHIN(DWC31, 120A, ANY) ||
+		DWC3_IP_IS(DWC32);
+}
+
+static void dwc3_check_params(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	unsigned int hwparam_gen =
+		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
 
 	/*
-	 * Handle property "snps,incr-burst-type-adjustment".
-	 * Get the number of value from this property:
-	 * result <= 0, means this property is not supported.
-	 * result = 1, means INCRx burst mode supported.
-	 * result > 1, means undefined length burst mode supported.
+	 * Enable IMOD for all supporting controllers.
+	 *
+	 * Particularly, DWC_usb3 v3.00a must enable this feature for
+	 * the following reason:
+	 *
+	 * Workaround for STAR 9000961433 which affects only version
+	 * 3.00a of the DWC_usb3 core. This prevents the controller
+	 * interrupt from being masked while handling events. IMOD
+	 * allows us to work around this issue. Enable it for the
+	 * affected version.
 	 */
-	dwc->incrx_mode = INCRX_BURST_MODE;
-	dwc->incrx_size = 0;
-	for (i = 0; i < 8; i++) {
-		if (dev_read_u32_index(dev, "snps,incr-burst-type-adjustment",
-				       i, &val))
+	if (dwc3_has_imod((dwc)))
+		dwc->imod_interval = 1;
+
+	/* Check the maximum_speed parameter */
+	switch (dwc->maximum_speed) {
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+		break;
+	case USB_SPEED_SUPER:
+		if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS)
+			dev_warn(dev, "UDC doesn't support Gen 1\n");
+		break;
+	case USB_SPEED_SUPER_PLUS:
+		if ((DWC3_IP_IS(DWC32) &&
+		     hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS) ||
+		    (!DWC3_IP_IS(DWC32) &&
+		     hwparam_gen != DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
+			dev_warn(dev, "UDC doesn't support SSP\n");
+		break;
+	default:
+		dev_err(dev, "invalid maximum_speed parameter %d\n",
+			dwc->maximum_speed);
+		fallthrough;
+	case USB_SPEED_UNKNOWN:
+		switch (hwparam_gen) {
+		case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
+			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
+			break;
+		case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
+			if (DWC3_IP_IS(DWC32))
+				dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
+			else
+				dwc->maximum_speed = USB_SPEED_SUPER;
+			break;
+		case DWC3_GHWPARAMS3_SSPHY_IFC_DIS:
+			dwc->maximum_speed = USB_SPEED_HIGH;
+			break;
+		default:
+			dwc->maximum_speed = USB_SPEED_SUPER;
 			break;
+		}
+		break;
+	}
+
+	/*
+	 * Currently the controller does not have visibility into the HW
+	 * parameter to determine the maximum number of lanes the HW supports.
+	 * If the number of lanes is not specified in the device property, then
+	 * set the default to support dual-lane for DWC_usb32 and single-lane
+	 * for DWC_usb31 for super-speed-plus.
+	 */
+	if (dwc->maximum_speed == USB_SPEED_SUPER_PLUS) {
+		switch (dwc->max_ssp_rate) {
+		case USB_SSP_GEN_2x1:
+			if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_GEN1)
+				dev_warn(dev, "UDC only supports Gen 1\n");
+			break;
+		case USB_SSP_GEN_1x2:
+		case USB_SSP_GEN_2x2:
+			if (DWC3_IP_IS(DWC31))
+				dev_warn(dev, "UDC only supports single lane\n");
+			break;
+		case USB_SSP_GEN_UNKNOWN:
+		default:
+			switch (hwparam_gen) {
+			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
+				if (DWC3_IP_IS(DWC32))
+					dwc->max_ssp_rate = USB_SSP_GEN_2x2;
+				else
+					dwc->max_ssp_rate = USB_SSP_GEN_2x1;
+				break;
+			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
+				if (DWC3_IP_IS(DWC32))
+					dwc->max_ssp_rate = USB_SSP_GEN_1x2;
+				break;
+			}
+			break;
+		}
+	}
+}
+
+static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	struct device_node *np_phy;
+	struct extcon_dev *edev = NULL;
+	const char *name;
+
+	if (device_property_present(dev, "extcon"))
+		return extcon_get_edev_by_phandle(dev, 0);
+
+	/*
+	 * Device tree platforms should get extcon via phandle.
+	 * On ACPI platforms, we get the name from a device property.
+	 * This device property is for kernel internal use only and
+	 * is expected to be set by the glue code.
+	 */
+	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
+		return extcon_get_extcon_dev(name);
+
+	/*
+	 * Check explicitly if "usb-role-switch" is used since
+	 * extcon_find_edev_by_node() can not be used to check the absence of
+	 * an extcon device. In the absence of an device it will always return
+	 * EPROBE_DEFER.
+	 */
+	if (IS_ENABLED(CONFIG_USB_ROLE_SWITCH) &&
+	    device_property_read_bool(dev, "usb-role-switch"))
+		return NULL;
+
+	/*
+	 * Try to get an extcon device from the USB PHY controller's "port"
+	 * node. Check if it has the "port" node first, to avoid printing the
+	 * error message from underlying code, as it's a valid case: extcon
+	 * device (and "port" node) may be missing in case of "usb-role-switch"
+	 * or OTG mode.
+	 */
+	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
+	if (of_graph_is_present(np_phy)) {
+		struct device_node *np_conn;
+
+		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+		if (np_conn)
+			edev = extcon_find_edev_by_node(np_conn);
+		of_node_put(np_conn);
+	}
+	of_node_put(np_phy);
+
+	return edev;
+}
+
+static int dwc3_get_clocks(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+
+	if (!dev->of_node)
+		return 0;
+
+	/*
+	 * Clocks are optional, but new DT platforms should support all clocks
+	 * as required by the DT-binding.
+	 * Some devices have different clock names in legacy device trees,
+	 * check for them to retain backwards compatibility.
+	 */
+	dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
+	if (IS_ERR(dwc->bus_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+				"could not get bus clock\n");
+	}
 
-		dwc->incrx_mode = INCRX_UNDEF_LENGTH_BURST_MODE;
-		dwc->incrx_size = max(dwc->incrx_size, val);
+	if (dwc->bus_clk == NULL) {
+		dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
+		if (IS_ERR(dwc->bus_clk)) {
+			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+					"could not get bus clock\n");
+		}
 	}
+
+	dwc->ref_clk = devm_clk_get_optional(dev, "ref");
+	if (IS_ERR(dwc->ref_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+				"could not get ref clock\n");
+	}
+
+	if (dwc->ref_clk == NULL) {
+		dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
+		if (IS_ERR(dwc->ref_clk)) {
+			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+					"could not get ref clock\n");
+		}
+	}
+
+	dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
+	if (IS_ERR(dwc->susp_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+				"could not get suspend clock\n");
+	}
+
+	if (dwc->susp_clk == NULL) {
+		dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
+		if (IS_ERR(dwc->susp_clk)) {
+			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+					"could not get suspend clock\n");
+		}
+	}
+
+	/* specific to Rockchip RK3588 */
+	dwc->utmi_clk = devm_clk_get_optional(dev, "utmi");
+	if (IS_ERR(dwc->utmi_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->utmi_clk),
+				"could not get utmi clock\n");
+	}
+
+	/* specific to Rockchip RK3588 */
+	dwc->pipe_clk = devm_clk_get_optional(dev, "pipe");
+	if (IS_ERR(dwc->pipe_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->pipe_clk),
+				"could not get pipe clock\n");
+	}
+
+	return 0;
+}
+
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
 }
 
-int dwc3_init(struct dwc3 *dwc)
+static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
 {
+	struct power_supply *usb_psy;
+	const char *usb_psy_name;
 	int ret;
-	u32 reg;
 
+	ret = device_property_read_string(dwc->dev, "usb-psy-name", &usb_psy_name);
+	if (ret < 0)
+		return NULL;
+
+	usb_psy = power_supply_get_by_name(usb_psy_name);
+	if (!usb_psy)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return usb_psy;
+}
+
+int dwc3_core_probe(const struct dwc3_probe_data *data)
+{
+	struct dwc3		*dwc = data->dwc;
+	struct device		*dev = dwc->dev;
+	struct resource		dwc_res;
+	unsigned int		hw_mode;
+	void __iomem		*regs;
+	struct resource		*res = data->res;
+	int			ret;
+
+	dwc->xhci_resources[0].start = res->start;
+	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
+					DWC3_XHCI_REGS_END;
+	dwc->xhci_resources[0].flags = res->flags;
+	dwc->xhci_resources[0].name = res->name;
+
+	/*
+	 * Request memory region but exclude xHCI regs,
+	 * since it will be requested by the xhci-plat driver.
+	 */
+	dwc_res = *res;
+	dwc_res.start += DWC3_GLOBALS_REGS_START;
+
+	if (dev->of_node) {
+		struct device_node *parent = of_get_parent(dev->of_node);
+
+		if (of_device_is_compatible(parent, "realtek,rtd-dwc3")) {
+			dwc_res.start -= DWC3_GLOBALS_REGS_START;
+			dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
+		}
+
+		of_node_put(parent);
+	}
+
+	regs = devm_ioremap_resource(dev, &dwc_res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	dwc->regs	= regs;
+	dwc->regs_size	= resource_size(&dwc_res);
+
+	dwc3_get_properties(dwc);
+
+	dwc3_get_software_properties(dwc);
+
+	dwc->usb_psy = dwc3_get_usb_power_supply(dwc);
+	if (IS_ERR(dwc->usb_psy))
+		return dev_err_probe(dev, PTR_ERR(dwc->usb_psy), "couldn't get usb power supply\n");
+
+	if (!data->ignore_clocks_and_resets) {
+		dwc->reset = devm_reset_control_array_get_optional_shared(dev);
+		if (IS_ERR(dwc->reset)) {
+			ret = PTR_ERR(dwc->reset);
+			goto err_put_psy;
+		}
+
+		ret = dwc3_get_clocks(dwc);
+		if (ret)
+			goto err_put_psy;
+	}
+
+	ret = reset_control_deassert(dwc->reset);
+	if (ret)
+		goto err_put_psy;
+
+	ret = dwc3_clk_enable(dwc);
+	if (ret)
+		goto err_assert_reset;
+
+	if (!dwc3_core_is_valid(dwc)) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		ret = -ENODEV;
+		goto err_disable_clks;
+	}
+
+	dev_set_drvdata(dev, dwc);
 	dwc3_cache_hwparams(dwc);
 
+	if (!dwc->sysdev_is_parent &&
+	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
+		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+		if (ret)
+			goto err_disable_clks;
+	}
+
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
+	spin_lock_init(&dwc->lock);
+	mutex_init(&dwc->mutex);
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
+	pm_runtime_enable(dev);
+
+	pm_runtime_forbid(dev);
+
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_allow_rpm;
 	}
 
+	dwc->edev = dwc3_get_extcon(dwc);
+	if (IS_ERR(dwc->edev)) {
+		ret = dev_err_probe(dwc->dev, PTR_ERR(dwc->edev), "failed to get extcon\n");
+		goto err_free_event_buffers;
+	}
+
+	ret = dwc3_get_dr_mode(dwc);
+	if (ret)
+		goto err_free_event_buffers;
+
 	ret = dwc3_core_init(dwc);
 	if (ret) {
-		dev_err(dwc->dev, "failed to initialize core\n");
-		goto core_fail;
+		dev_err_probe(dev, ret, "failed to initialize core\n");
+		goto err_free_event_buffers;
 	}
 
-	ret = dwc3_event_buffers_setup(dwc);
-	if (ret) {
-		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto event_fail;
-	}
-
-	if (dwc->revision >= DWC3_REVISION_250A) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
-
-		/*
-		 * Enable hardware control of sending remote wakeup
-		 * in HS when the device is in the L1 state.
-		 */
-		if (dwc->revision >= DWC3_REVISION_290A)
-			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
-
-		if (dwc->dis_tx_ipgap_linecheck_quirk)
-			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
-
-		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
-	}
-
-	if (dwc->dr_mode == USB_DR_MODE_HOST ||
-	    dwc->dr_mode == USB_DR_MODE_OTG) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
-
-		reg |= DWC3_GUCTL_HSTINAUTORETRY;
-
-		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-	}
+	dwc3_check_params(dwc);
+	dwc3_debugfs_init(dwc);
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
-		goto mode_fail;
+		goto err_exit_debugfs;
+
+	pm_runtime_put(dev);
+
+	dma_set_max_seg_size(dev, UINT_MAX);
 
 	return 0;
 
-mode_fail:
+err_exit_debugfs:
+	dwc3_debugfs_exit(dwc);
 	dwc3_event_buffers_cleanup(dwc);
-
-event_fail:
-	dwc3_core_exit(dwc);
-
-core_fail:
+	dwc3_phy_power_off(dwc);
+	dwc3_phy_exit(dwc);
+	dwc3_ulpi_exit(dwc);
+err_free_event_buffers:
 	dwc3_free_event_buffers(dwc);
+err_allow_rpm:
+	pm_runtime_allow(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+err_disable_clks:
+	dwc3_clk_disable(dwc);
+err_assert_reset:
+	reset_control_assert(dwc->reset);
+err_put_psy:
+	if (dwc->usb_psy)
+		power_supply_put(dwc->usb_psy);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dwc3_core_probe);
 
-void dwc3_remove(struct dwc3 *dwc)
+static int dwc3_probe(struct platform_device *pdev)
 {
+	struct dwc3_probe_data probe_data = {};
+	struct resource *res;
+	struct dwc3 *dwc;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing memory resource\n");
+		return -ENODEV;
+	}
+
+	dwc = devm_kzalloc(&pdev->dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return -ENOMEM;
+
+	dwc->dev = &pdev->dev;
+
+	probe_data.dwc = dwc;
+	probe_data.res = res;
+
+	return dwc3_core_probe(&probe_data);
+}
+
+void dwc3_core_remove(struct dwc3 *dwc)
+{
+	pm_runtime_get_sync(dwc->dev);
+
 	dwc3_core_exit_mode(dwc);
-	dwc3_event_buffers_cleanup(dwc);
-	dwc3_free_event_buffers(dwc);
-	dwc3_core_stop(dwc);
+	dwc3_debugfs_exit(dwc);
+
 	dwc3_core_exit(dwc);
-	kfree(dwc->mem);
+	dwc3_ulpi_exit(dwc);
+
+	pm_runtime_allow(dwc->dev);
+	pm_runtime_disable(dwc->dev);
+	pm_runtime_dont_use_autosuspend(dwc->dev);
+	pm_runtime_put_noidle(dwc->dev);
+	/*
+	 * HACK: Clear the driver data, which is currently accessed by parent
+	 * glue drivers, before allowing the parent to suspend.
+	 */
+	dev_set_drvdata(dwc->dev, NULL);
+	pm_runtime_set_suspended(dwc->dev);
+
+	dwc3_free_event_buffers(dwc);
+
+	if (dwc->usb_psy)
+		power_supply_put(dwc->usb_psy);
 }
+EXPORT_SYMBOL_GPL(dwc3_core_remove);
+
+static void dwc3_remove(struct platform_device *pdev)
+{
+	dwc3_core_remove(platform_get_drvdata(pdev));
+}
+
+#ifdef CONFIG_PM
+static int dwc3_core_init_for_resume(struct dwc3 *dwc)
+{
+	int ret;
+
+	ret = reset_control_deassert(dwc->reset);
+	if (ret)
+		return ret;
+
+	ret = dwc3_clk_enable(dwc);
+	if (ret)
+		goto assert_reset;
+
+	ret = dwc3_core_init(dwc);
+	if (ret)
+		goto disable_clks;
+
+	return 0;
+
+disable_clks:
+	dwc3_clk_disable(dwc);
+assert_reset:
+	reset_control_assert(dwc->reset);
+
+	return ret;
+}
+
+static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
+{
+	u32 reg;
+	int i;
+	int ret;
+
+	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
+		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
+				    DWC3_GUSB2PHYCFG_SUSPHY) ||
+				    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
+				    DWC3_GUSB3PIPECTL_SUSPHY);
+		/*
+		 * TI AM62 platform requires SUSPHY to be
+		 * enabled for system suspend to work.
+		 */
+		if (!dwc->susphy_state)
+			dwc3_enable_susphy(dwc, true);
+	}
+
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		if (pm_runtime_suspended(dwc->dev))
+			break;
+		ret = dwc3_gadget_suspend(dwc);
+		if (ret)
+			return ret;
+		synchronize_irq(dwc->irq_gadget);
+		dwc3_core_exit(dwc);
+		break;
+	case DWC3_GCTL_PRTCAP_HOST:
+		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
+			dwc3_core_exit(dwc);
+			break;
+		}
+
+		/* Let controller to suspend HSPHY before PHY driver suspends */
+		if (dwc->dis_u2_susphy_quirk ||
+		    dwc->dis_enblslpm_quirk) {
+			for (i = 0; i < dwc->num_usb2_ports; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+				reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
+					DWC3_GUSB2PHYCFG_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+			}
+
+			/* Give some time for USB2 PHY to suspend */
+			usleep_range(5000, 6000);
+		}
+
+		for (i = 0; i < dwc->num_usb2_ports; i++)
+			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
+		for (i = 0; i < dwc->num_usb3_ports; i++)
+			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
+		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		/* do nothing during runtime_suspend */
+		if (PMSG_IS_AUTO(msg))
+			break;
+
+		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
+			ret = dwc3_gadget_suspend(dwc);
+			if (ret)
+				return ret;
+			synchronize_irq(dwc->irq_gadget);
+		}
+
+		dwc3_otg_exit(dwc);
+		dwc3_core_exit(dwc);
+		break;
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return 0;
+}
+
+static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
+{
+	int		ret;
+	u32		reg;
+	int		i;
+
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		ret = dwc3_core_init_for_resume(dwc);
+		if (ret)
+			return ret;
+
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
+		dwc3_gadget_resume(dwc);
+		break;
+	case DWC3_GCTL_PRTCAP_HOST:
+		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
+			ret = dwc3_core_init_for_resume(dwc);
+			if (ret)
+				return ret;
+			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, true);
+			break;
+		}
+		/* Restore GUSB2PHYCFG bits that were modified in suspend */
+		for (i = 0; i < dwc->num_usb2_ports; i++) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+			if (dwc->dis_u2_susphy_quirk)
+				reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+
+			if (dwc->dis_enblslpm_quirk)
+				reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+		}
+
+		for (i = 0; i < dwc->num_usb2_ports; i++)
+			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
+		for (i = 0; i < dwc->num_usb3_ports; i++)
+			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
+		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		/* nothing to do on runtime_resume */
+		if (PMSG_IS_AUTO(msg))
+			break;
+
+		ret = dwc3_core_init_for_resume(dwc);
+		if (ret)
+			return ret;
+
+		dwc3_set_prtcap(dwc, dwc->current_dr_role, true);
+
+		dwc3_otg_init(dwc);
+		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
+			dwc3_otg_host_init(dwc);
+		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
+			dwc3_gadget_resume(dwc);
+		}
+
+		break;
+	default:
+		/* do nothing */
+		break;
+	}
+
+	if (!PMSG_IS_AUTO(msg)) {
+		/* restore SUSPHY state to that before system suspend. */
+		dwc3_enable_susphy(dwc, dwc->susphy_state);
+	}
+
+	return 0;
+}
+
+static int dwc3_runtime_checks(struct dwc3 *dwc)
+{
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		if (dwc->connected)
+			return -EBUSY;
+		break;
+	case DWC3_GCTL_PRTCAP_HOST:
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return 0;
+}
+
+int dwc3_runtime_suspend(struct dwc3 *dwc)
+{
+	int		ret;
+
+	if (dwc3_runtime_checks(dwc))
+		return -EBUSY;
+
+	ret = dwc3_suspend_common(dwc, PMSG_AUTO_SUSPEND);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dwc3_runtime_suspend);
+
+int dwc3_runtime_resume(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	int		ret;
+
+	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
+	if (ret)
+		return ret;
+
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		if (dwc->pending_events) {
+			pm_runtime_put(dev);
+			dwc->pending_events = false;
+			enable_irq(dwc->irq_gadget);
+		}
+		break;
+	case DWC3_GCTL_PRTCAP_HOST:
+	default:
+		/* do nothing */
+		break;
+	}
+
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dwc3_runtime_resume);
+
+int dwc3_runtime_idle(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		if (dwc3_runtime_checks(dwc))
+			return -EBUSY;
+		break;
+	case DWC3_GCTL_PRTCAP_HOST:
+	default:
+		/* do nothing */
+		break;
+	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_autosuspend(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dwc3_runtime_idle);
+
+static int dwc3_plat_runtime_suspend(struct device *dev)
+{
+	return dwc3_runtime_suspend(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_runtime_resume(struct device *dev)
+{
+	return dwc3_runtime_resume(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_runtime_idle(struct device *dev)
+{
+	return dwc3_runtime_idle(dev_get_drvdata(dev));
+}
+#endif /* CONFIG_PM */
+
+#ifdef CONFIG_PM_SLEEP
+int dwc3_pm_suspend(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	int		ret;
+
+	ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
+	if (ret)
+		return ret;
+
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dwc3_pm_suspend);
+
+int dwc3_pm_resume(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	int		ret = 0;
+
+	pinctrl_pm_select_default_state(dev);
+
+	pm_runtime_disable(dev);
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		goto out;
+
+	ret = dwc3_resume_common(dwc, PMSG_RESUME);
+	if (ret)
+		pm_runtime_set_suspended(dev);
+
+out:
+	pm_runtime_enable(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dwc3_pm_resume);
+
+void dwc3_pm_complete(struct dwc3 *dwc)
+{
+	u32		reg;
+
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
+			dwc->dis_split_quirk) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+		reg |= DWC3_GUCTL3_SPLITDISABLE;
+		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+	}
+}
+EXPORT_SYMBOL_GPL(dwc3_pm_complete);
+
+int dwc3_pm_prepare(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+
+	/*
+	 * Indicate to the PM core that it may safely leave the device in
+	 * runtime suspend if runtime-suspended already in device mode.
+	 */
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE &&
+	    pm_runtime_suspended(dev) &&
+	    !dev_pinctrl(dev))
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dwc3_pm_prepare);
+
+static int dwc3_plat_suspend(struct device *dev)
+{
+	return dwc3_pm_suspend(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_resume(struct device *dev)
+{
+	return dwc3_pm_resume(dev_get_drvdata(dev));
+}
+
+static void dwc3_plat_complete(struct device *dev)
+{
+	dwc3_pm_complete(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_prepare(struct device *dev)
+{
+	return dwc3_pm_prepare(dev_get_drvdata(dev));
+}
+#else
+#define dwc3_plat_complete NULL
+#define dwc3_plat_prepare NULL
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops dwc3_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_plat_suspend, dwc3_plat_resume)
+	.complete = dwc3_plat_complete,
+	.prepare = dwc3_plat_prepare,
+	/*
+	 * Runtime suspend halts the controller on disconnection. It relies on
+	 * platforms with custom connection notification to start the controller
+	 * again.
+	 */
+	SET_RUNTIME_PM_OPS(dwc3_plat_runtime_suspend, dwc3_plat_runtime_resume,
+			   dwc3_plat_runtime_idle)
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id of_dwc3_match[] = {
+	{
+		.compatible = "snps,dwc3"
+	},
+	{
+		.compatible = "synopsys,dwc3"
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_dwc3_match);
+#endif
+
+#ifdef CONFIG_ACPI
+
+#define ACPI_ID_INTEL_BSW	"808622B7"
+
+static const struct acpi_device_id dwc3_acpi_match[] = {
+	{ ACPI_ID_INTEL_BSW, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
 #endif
+
+static struct platform_driver dwc3_driver = {
+	.probe		= dwc3_probe,
+	.remove		= dwc3_remove,
+	.driver		= {
+		.name	= "dwc3",
+		.of_match_table	= of_match_ptr(of_dwc3_match),
+		.acpi_match_table = ACPI_PTR(dwc3_acpi_match),
+		.pm	= &dwc3_dev_pm_ops,
+	},
+};
+
+module_platform_driver(dwc3_driver);
+
+MODULE_ALIAS("platform:dwc3");
+MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index b572ea340c8c..d5b985fa12f4 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1,40 +1,57 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * core.h - DesignWare USB3 DRD Core Header
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/core.h) and ported
- * to uboot.
- *
- * commit 460d098cb6 : usb: dwc3: make HIRD threshold configurable
- *
  */
 
 #ifndef __DRIVERS_USB_DWC3_CORE_H
 #define __DRIVERS_USB_DWC3_CORE_H
 
-#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/bitops.h>
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
+#include <linux/debugfs.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
-#include <linux/usb/phy.h>
+#include <linux/usb/role.h>
+#include <linux/ulpi/interface.h>
+
+#include <linux/phy/phy.h>
+
+#include <linux/power_supply.h>
+
+/*
+ * DWC3 Multiport controllers support up to 15 High-Speed PHYs
+ * and 4 SuperSpeed PHYs.
+ */
+#define DWC3_USB2_MAX_PORTS	15
+#define DWC3_USB3_MAX_PORTS	4
 
 #define DWC3_MSG_MAX	500
 
 /* Global constants */
-#define DWC3_EP0_BOUNCE_SIZE	512
+#define DWC3_PULL_UP_TIMEOUT	500	/* ms */
+#define DWC3_BOUNCE_SIZE	1024	/* size of a superspeed bulk */
+#define DWC3_EP0_SETUP_SIZE	512
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
+#define DWC3_ISOC_MAX_RETRIES	5
 
 #define DWC3_SCRATCHBUF_SIZE	4096	/* each buffer is assumed to be 4KiB */
-#define DWC3_EVENT_SIZE		4	/* bytes */
-#define DWC3_EVENT_MAX_NUM	64	/* 2 events/endpoint */
-#define DWC3_EVENT_BUFFERS_SIZE	(DWC3_EVENT_SIZE * DWC3_EVENT_MAX_NUM)
+#define DWC3_EVENT_BUFFERS_SIZE	4096
 #define DWC3_EVENT_TYPE_MASK	0xfe
 
 #define DWC3_EVENT_TYPE_DEV	0
@@ -47,17 +64,24 @@
 #define DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE	3
 #define DWC3_DEVICE_EVENT_WAKEUP		4
 #define DWC3_DEVICE_EVENT_HIBER_REQ		5
-#define DWC3_DEVICE_EVENT_EOPF			6
+#define DWC3_DEVICE_EVENT_SUSPEND		6
 #define DWC3_DEVICE_EVENT_SOF			7
 #define DWC3_DEVICE_EVENT_ERRATIC_ERROR		9
 #define DWC3_DEVICE_EVENT_CMD_CMPL		10
 #define DWC3_DEVICE_EVENT_OVERFLOW		11
 
+/* Controller's role while using the OTG block */
+#define DWC3_OTG_ROLE_IDLE	0
+#define DWC3_OTG_ROLE_HOST	1
+#define DWC3_OTG_ROLE_DEVICE	2
+
 #define DWC3_GEVNTCOUNT_MASK	0xfffc
+#define DWC3_GEVNTCOUNT_EHB	BIT(31)
 #define DWC3_GSNPSID_MASK	0xffff0000
 #define DWC3_GSNPSREV_MASK	0xffff
+#define DWC3_GSNPS_ID(p)	(((p) & DWC3_GSNPSID_MASK) >> 16)
 
-/* DWC3 registers memory space boundries */
+/* DWC3 registers memory space boundaries */
 #define DWC3_XHCI_REGS_START		0x0
 #define DWC3_XHCI_REGS_END		0x7fff
 #define DWC3_GLOBALS_REGS_START		0xc100
@@ -67,6 +91,8 @@
 #define DWC3_OTG_REGS_START		0xcc00
 #define DWC3_OTG_REGS_END		0xccff
 
+#define DWC3_RTK_RTD_GLOBALS_REGS_START	0x8100
+
 /* Global Registers */
 #define DWC3_GSBUSCFG0		0xc100
 #define DWC3_GSBUSCFG1		0xc104
@@ -94,28 +120,39 @@
 #define DWC3_GHWPARAMS7		0xc15c
 #define DWC3_GDBGFIFOSPACE	0xc160
 #define DWC3_GDBGLTSSM		0xc164
+#define DWC3_GDBGBMU		0xc16c
+#define DWC3_GDBGLSPMUX		0xc170
+#define DWC3_GDBGLSP		0xc174
+#define DWC3_GDBGEPINFO0	0xc178
+#define DWC3_GDBGEPINFO1	0xc17c
 #define DWC3_GPRTBIMAP_HS0	0xc180
 #define DWC3_GPRTBIMAP_HS1	0xc184
 #define DWC3_GPRTBIMAP_FS0	0xc188
 #define DWC3_GPRTBIMAP_FS1	0xc18c
+#define DWC3_GUCTL2		0xc19c
 
-#define DWC3_GUSB2PHYCFG(n)	(0xc200 + (n * 0x04))
-#define DWC3_GUSB2I2CCTL(n)	(0xc240 + (n * 0x04))
+#define DWC3_VER_NUMBER		0xc1a0
+#define DWC3_VER_TYPE		0xc1a4
 
-#define DWC3_GUSB2PHYACC(n)	(0xc280 + (n * 0x04))
+#define DWC3_GUSB2PHYCFG(n)	(0xc200 + ((n) * 0x04))
+#define DWC3_GUSB2I2CCTL(n)	(0xc240 + ((n) * 0x04))
 
-#define DWC3_GUSB3PIPECTL(n)	(0xc2c0 + (n * 0x04))
+#define DWC3_GUSB2PHYACC(n)	(0xc280 + ((n) * 0x04))
 
-#define DWC3_GTXFIFOSIZ(n)	(0xc300 + (n * 0x04))
-#define DWC3_GRXFIFOSIZ(n)	(0xc380 + (n * 0x04))
+#define DWC3_GUSB3PIPECTL(n)	(0xc2c0 + ((n) * 0x04))
 
-#define DWC3_GEVNTADRLO(n)	(0xc400 + (n * 0x10))
-#define DWC3_GEVNTADRHI(n)	(0xc404 + (n * 0x10))
-#define DWC3_GEVNTSIZ(n)	(0xc408 + (n * 0x10))
-#define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
+#define DWC3_GTXFIFOSIZ(n)	(0xc300 + ((n) * 0x04))
+#define DWC3_GRXFIFOSIZ(n)	(0xc380 + ((n) * 0x04))
+
+#define DWC3_GEVNTADRLO(n)	(0xc400 + ((n) * 0x10))
+#define DWC3_GEVNTADRHI(n)	(0xc404 + ((n) * 0x10))
+#define DWC3_GEVNTSIZ(n)	(0xc408 + ((n) * 0x10))
+#define DWC3_GEVNTCOUNT(n)	(0xc40c + ((n) * 0x10))
 
 #define DWC3_GHWPARAMS8		0xc600
+#define DWC3_GUCTL3		0xc60c
 #define DWC3_GFLADJ		0xc630
+#define DWC3_GHWPARAMS9		0xc6e0
 
 /* Device Registers */
 #define DWC3_DCFG		0xc700
@@ -125,10 +162,15 @@
 #define DWC3_DGCMDPAR		0xc710
 #define DWC3_DGCMD		0xc714
 #define DWC3_DALEPENA		0xc720
-#define DWC3_DEPCMDPAR2(n)	(0xc800 + (n * 0x10))
-#define DWC3_DEPCMDPAR1(n)	(0xc804 + (n * 0x10))
-#define DWC3_DEPCMDPAR0(n)	(0xc808 + (n * 0x10))
-#define DWC3_DEPCMD(n)		(0xc80c + (n * 0x10))
+#define DWC3_DCFG1		0xc740 /* DWC_usb32 only */
+
+#define DWC3_DEP_BASE(n)	(0xc800 + ((n) * 0x10))
+#define DWC3_DEPCMDPAR2		0x00
+#define DWC3_DEPCMDPAR1		0x04
+#define DWC3_DEPCMDPAR0		0x08
+#define DWC3_DEPCMD		0x0c
+
+#define DWC3_DEV_IMOD(n)	(0xca00 + ((n) * 0x4))
 
 /* OTG Registers */
 #define DWC3_OCFG		0xcc00
@@ -137,6 +179,8 @@
 #define DWC3_OEVTEN		0xcc0C
 #define DWC3_OSTS		0xcc10
 
+#define DWC3_LLUCTL(n)		(0xd024 + ((n) * 0x80))
+
 /* Bit fields */
 
 /* Global SoC Bus Configuration INCRx Register 0 */
@@ -150,9 +194,65 @@
 #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
 #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
 
+/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
+#define DWC3_GSBUSCFG0_REQINFO(n)	(((n) & 0xffff) << 16)
+#define DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED	0xffffffff
+
+/* Global Debug LSP MUX Select */
+#define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only */
+#define DWC3_GDBGLSPMUX_HOSTSELECT(n)	((n) & 0x3fff)
+#define DWC3_GDBGLSPMUX_DEVSELECT(n)	(((n) & 0xf) << 4)
+#define DWC3_GDBGLSPMUX_EPSELECT(n)	((n) & 0xf)
+
+/* Global Debug Queue/FIFO Space Available Register */
+#define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
+#define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
+#define DWC3_GDBGFIFOSPACE_SPACE_AVAILABLE(n) (((n) >> 16) & 0xffff)
+
+#define DWC3_TXFIFO		0
+#define DWC3_RXFIFO		1
+#define DWC3_TXREQQ		2
+#define DWC3_RXREQQ		3
+#define DWC3_RXINFOQ		4
+#define DWC3_PSTATQ		5
+#define DWC3_DESCFETCHQ		6
+#define DWC3_EVENTQ		7
+#define DWC3_AUXEVENTQ		8
+
+/* Global RX Threshold Configuration Register */
+#define DWC3_GRXTHRCFG_MAXRXBURSTSIZE(n) (((n) & 0x1f) << 19)
+#define DWC3_GRXTHRCFG_RXPKTCNT(n) (((n) & 0xf) << 24)
+#define DWC3_GRXTHRCFG_PKTCNTSEL BIT(29)
+
+/* Global TX Threshold Configuration Register */
+#define DWC3_GTXTHRCFG_MAXTXBURSTSIZE(n) (((n) & 0xff) << 16)
+#define DWC3_GTXTHRCFG_TXPKTCNT(n) (((n) & 0xf) << 24)
+#define DWC3_GTXTHRCFG_PKTCNTSEL BIT(29)
+
+/* Global RX Threshold Configuration Register for DWC_usb31 only */
+#define DWC31_GRXTHRCFG_MAXRXBURSTSIZE(n)	(((n) & 0x1f) << 16)
+#define DWC31_GRXTHRCFG_RXPKTCNT(n)		(((n) & 0x1f) << 21)
+#define DWC31_GRXTHRCFG_PKTCNTSEL		BIT(26)
+#define DWC31_RXTHRNUMPKTSEL_HS_PRD		BIT(15)
+#define DWC31_RXTHRNUMPKT_HS_PRD(n)		(((n) & 0x3) << 13)
+#define DWC31_RXTHRNUMPKTSEL_PRD		BIT(10)
+#define DWC31_RXTHRNUMPKT_PRD(n)		(((n) & 0x1f) << 5)
+#define DWC31_MAXRXBURSTSIZE_PRD(n)		((n) & 0x1f)
+
+/* Global TX Threshold Configuration Register for DWC_usb31 only */
+#define DWC31_GTXTHRCFG_MAXTXBURSTSIZE(n)	(((n) & 0x1f) << 16)
+#define DWC31_GTXTHRCFG_TXPKTCNT(n)		(((n) & 0x1f) << 21)
+#define DWC31_GTXTHRCFG_PKTCNTSEL		BIT(26)
+#define DWC31_TXTHRNUMPKTSEL_HS_PRD		BIT(15)
+#define DWC31_TXTHRNUMPKT_HS_PRD(n)		(((n) & 0x3) << 13)
+#define DWC31_TXTHRNUMPKTSEL_PRD		BIT(10)
+#define DWC31_TXTHRNUMPKT_PRD(n)		(((n) & 0x1f) << 5)
+#define DWC31_MAXTXBURSTSIZE_PRD(n)		((n) & 0x1f)
+
 /* Global Configuration Register */
 #define DWC3_GCTL_PWRDNSCALE(n)	((n) << 19)
-#define DWC3_GCTL_U2RSTECN	(1 << 16)
+#define DWC3_GCTL_PWRDNSCALE_MASK	GENMASK(31, 19)
+#define DWC3_GCTL_U2RSTECN	BIT(16)
 #define DWC3_GCTL_RAMCLKSEL(x)	(((x) & DWC3_GCTL_CLK_MASK) << 6)
 #define DWC3_GCTL_CLK_BUS	(0)
 #define DWC3_GCTL_CLK_PIPE	(1)
@@ -165,58 +265,102 @@
 #define DWC3_GCTL_PRTCAP_DEVICE	2
 #define DWC3_GCTL_PRTCAP_OTG	3
 
-#define DWC3_GCTL_CORESOFTRESET		(1 << 11)
-#define DWC3_GCTL_SOFITPSYNC		(1 << 10)
+#define DWC3_GCTL_CORESOFTRESET		BIT(11)
+#define DWC3_GCTL_SOFITPSYNC		BIT(10)
 #define DWC3_GCTL_SCALEDOWN(n)		((n) << 4)
 #define DWC3_GCTL_SCALEDOWN_MASK	DWC3_GCTL_SCALEDOWN(3)
-#define DWC3_GCTL_DISSCRAMBLE		(1 << 3)
-#define DWC3_GCTL_U2EXIT_LFPS		(1 << 2)
-#define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
-#define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
-
-/* Global User Control Register */
-#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
+#define DWC3_GCTL_DISSCRAMBLE		BIT(3)
+#define DWC3_GCTL_U2EXIT_LFPS		BIT(2)
+#define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
+#define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
 /* Global User Control 1 Register */
+#define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
-#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
+#define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
+#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
+#define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
+#define DWC3_GUCTL1_PARKMODE_DISABLE_HS		BIT(16)
+#define DWC3_GUCTL1_RESUME_OPMODE_HS_HOST	BIT(10)
+
+/* Global Status Register */
+#define DWC3_GSTS_OTG_IP	BIT(10)
+#define DWC3_GSTS_BC_IP		BIT(9)
+#define DWC3_GSTS_ADP_IP	BIT(8)
+#define DWC3_GSTS_HOST_IP	BIT(7)
+#define DWC3_GSTS_DEVICE_IP	BIT(6)
+#define DWC3_GSTS_CSR_TIMEOUT	BIT(5)
+#define DWC3_GSTS_BUS_ERR_ADDR_VLD	BIT(4)
+#define DWC3_GSTS_CURMOD(n)	((n) & 0x3)
+#define DWC3_GSTS_CURMOD_DEVICE	0
+#define DWC3_GSTS_CURMOD_HOST	1
 
 /* Global USB2 PHY Configuration Register */
-#define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
-#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	(1 << 30)
-#define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
-#define DWC3_GUSB2PHYCFG_ENBLSLPM	(1 << 8)
-#define DWC3_GUSB2PHYCFG_PHYIF(n)	((n) << 3)
+#define DWC3_GUSB2PHYCFG_PHYSOFTRST	BIT(31)
+#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	BIT(30)
+#define DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV	BIT(17)
+#define DWC3_GUSB2PHYCFG_SUSPHY		BIT(6)
+#define DWC3_GUSB2PHYCFG_ULPI_UTMI	BIT(4)
+#define DWC3_GUSB2PHYCFG_ENBLSLPM	BIT(8)
+#define DWC3_GUSB2PHYCFG_PHYIF(n)	(n << 3)
 #define DWC3_GUSB2PHYCFG_PHYIF_MASK	DWC3_GUSB2PHYCFG_PHYIF(1)
-#define DWC3_GUSB2PHYCFG_USBTRDTIM(n)	((n) << 10)
+#define DWC3_GUSB2PHYCFG_USBTRDTIM(n)	(n << 10)
 #define DWC3_GUSB2PHYCFG_USBTRDTIM_MASK	DWC3_GUSB2PHYCFG_USBTRDTIM(0xf)
 #define USBTRDTIM_UTMI_8_BIT		9
 #define USBTRDTIM_UTMI_16_BIT		5
 #define UTMI_PHYIF_16_BIT		1
 #define UTMI_PHYIF_8_BIT		0
 
+/* Global USB2 PHY Vendor Control Register */
+#define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
+#define DWC3_GUSB2PHYACC_DONE		BIT(24)
+#define DWC3_GUSB2PHYACC_BUSY		BIT(23)
+#define DWC3_GUSB2PHYACC_WRITE		BIT(22)
+#define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
+#define DWC3_GUSB2PHYACC_EXTEND_ADDR(n)	(n << 8)
+#define DWC3_GUSB2PHYACC_DATA(n)	(n & 0xff)
+
 /* Global USB3 PIPE Control Register */
-#define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
-#define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
-#define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
+#define DWC3_GUSB3PIPECTL_PHYSOFTRST	BIT(31)
+#define DWC3_GUSB3PIPECTL_U2SSINP3OK	BIT(29)
+#define DWC3_GUSB3PIPECTL_DISRXDETINP3	BIT(28)
+#define DWC3_GUSB3PIPECTL_UX_EXIT_PX	BIT(27)
+#define DWC3_GUSB3PIPECTL_REQP1P2P3	BIT(24)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_EN	DWC3_GUSB3PIPECTL_DEP1P2P3(1)
-#define DWC3_GUSB3PIPECTL_DEPOCHANGE	(1 << 18)
-#define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
-#define DWC3_GUSB3PIPECTL_LFPSFILT	(1 << 9)
-#define DWC3_GUSB3PIPECTL_RX_DETOPOLL	(1 << 8)
+#define DWC3_GUSB3PIPECTL_DEPOCHANGE	BIT(18)
+#define DWC3_GUSB3PIPECTL_SUSPHY	BIT(17)
+#define DWC3_GUSB3PIPECTL_LFPSFILT	BIT(9)
+#define DWC3_GUSB3PIPECTL_RX_DETOPOLL	BIT(8)
 #define DWC3_GUSB3PIPECTL_TX_DEEPH_MASK	DWC3_GUSB3PIPECTL_TX_DEEPH(3)
 #define DWC3_GUSB3PIPECTL_TX_DEEPH(n)	((n) << 1)
 
 /* Global TX Fifo Size Register */
-#define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
+#define DWC31_GTXFIFOSIZ_TXFRAMNUM	BIT(15)		/* DWC_usb31 only */
+#define DWC31_GTXFIFOSIZ_TXFDEP(n)	((n) & 0x7fff)	/* DWC_usb31 only */
+#define DWC3_GTXFIFOSIZ_TXFDEP(n)	((n) & 0xffff)
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
+/* Global RX Fifo Size Register */
+#define DWC31_GRXFIFOSIZ_RXFDEP(n)	((n) & 0x7fff)	/* DWC_usb31 only */
+#define DWC3_GRXFIFOSIZ_RXFDEP(n)	((n) & 0xffff)
+
 /* Global Event Size Registers */
-#define DWC3_GEVNTSIZ_INTMASK		(1 << 31)
+#define DWC3_GEVNTSIZ_INTMASK		BIT(31)
 #define DWC3_GEVNTSIZ_SIZE(n)		((n) & 0xffff)
 
+/* Global HWPARAMS0 Register */
+#define DWC3_GHWPARAMS0_MODE(n)		((n) & 0x3)
+#define DWC3_GHWPARAMS0_MODE_GADGET	0
+#define DWC3_GHWPARAMS0_MODE_HOST	1
+#define DWC3_GHWPARAMS0_MODE_DRD	2
+#define DWC3_GHWPARAMS0_MBUS_TYPE(n)	(((n) >> 3) & 0x7)
+#define DWC3_GHWPARAMS0_SBUS_TYPE(n)	(((n) >> 6) & 0x3)
+#define DWC3_GHWPARAMS0_MDWIDTH(n)	(((n) >> 8) & 0xff)
+#define DWC3_GHWPARAMS0_SDWIDTH(n)	(((n) >> 16) & 0xff)
+#define DWC3_GHWPARAMS0_AWIDTH(n)	(((n) >> 24) & 0xff)
+
 /* Global HWPARAMS1 Register */
 #define DWC3_GHWPARAMS1_EN_PWROPT(n)	(((n) & (3 << 24)) >> 24)
 #define DWC3_GHWPARAMS1_EN_PWROPT_NO	0
@@ -224,11 +368,13 @@
 #define DWC3_GHWPARAMS1_EN_PWROPT_HIB	2
 #define DWC3_GHWPARAMS1_PWROPT(n)	((n) << 24)
 #define DWC3_GHWPARAMS1_PWROPT_MASK	DWC3_GHWPARAMS1_PWROPT(3)
+#define DWC3_GHWPARAMS1_ENDBC		BIT(31)
 
 /* Global HWPARAMS3 Register */
 #define DWC3_GHWPARAMS3_SSPHY_IFC(n)		((n) & 3)
 #define DWC3_GHWPARAMS3_SSPHY_IFC_DIS		0
-#define DWC3_GHWPARAMS3_SSPHY_IFC_ENA		1
+#define DWC3_GHWPARAMS3_SSPHY_IFC_GEN1		1
+#define DWC3_GHWPARAMS3_SSPHY_IFC_GEN2		2 /* DWC_usb31 only */
 #define DWC3_GHWPARAMS3_HSPHY_IFC(n)		(((n) & (3 << 2)) >> 2)
 #define DWC3_GHWPARAMS3_HSPHY_IFC_DIS		0
 #define DWC3_GHWPARAMS3_HSPHY_IFC_UTMI		1
@@ -243,12 +389,29 @@
 #define DWC3_MAX_HIBER_SCRATCHBUFS		15
 
 /* Global HWPARAMS6 Register */
-#define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
+#define DWC3_GHWPARAMS6_BCSUPPORT		BIT(14)
+#define DWC3_GHWPARAMS6_OTG3SUPPORT		BIT(13)
+#define DWC3_GHWPARAMS6_ADPSUPPORT		BIT(12)
+#define DWC3_GHWPARAMS6_HNPSUPPORT		BIT(11)
+#define DWC3_GHWPARAMS6_SRPSUPPORT		BIT(10)
+#define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)
+
+/* DWC_usb32 only */
+#define DWC3_GHWPARAMS6_MDWIDTH(n)		((n) & (0x3 << 8))
+
+/* Global HWPARAMS7 Register */
+#define DWC3_GHWPARAMS7_RAM1_DEPTH(n)	((n) & 0xffff)
+#define DWC3_GHWPARAMS7_RAM2_DEPTH(n)	(((n) >> 16) & 0xffff)
+
+/* Global HWPARAMS9 Register */
+#define DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS	BIT(0)
+#define DWC3_GHWPARAMS9_DEV_MST			BIT(1)
 
 /* Global Frame Length Adjustment Register */
-#define DWC3_GFLADJ_30MHZ_SDBND_SEL		(1 << 7)
+#define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 #define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
+#define DWC3_GFLADJ_REFCLK_LPM_SEL		BIT(23)
 #define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
 #define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
 
@@ -256,28 +419,41 @@
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
 #define DWC3_GUCTL_REFCLKPER_SEL		22
 
+/* Global User Control Register 2 */
+#define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
+#define DWC3_GUCTL2_LC_TIMER			BIT(19)
+
+/* Global User Control Register 3 */
+#define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
+#define DWC3_GUCTL3_USB20_RETRY_DISABLE		BIT(16)
+
 /* Device Configuration Register */
+#define DWC3_DCFG_NUMLANES(n)	(((n) & 0x3) << 30) /* DWC_usb32 only */
+
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
 
 #define DWC3_DCFG_SPEED_MASK	(7 << 0)
+#define DWC3_DCFG_SUPERSPEED_PLUS (5 << 0)  /* DWC_usb31 only */
 #define DWC3_DCFG_SUPERSPEED	(4 << 0)
 #define DWC3_DCFG_HIGHSPEED	(0 << 0)
-#define DWC3_DCFG_FULLSPEED2	(1 << 0)
-#define DWC3_DCFG_LOWSPEED	(2 << 0)
-#define DWC3_DCFG_FULLSPEED1	(3 << 0)
+#define DWC3_DCFG_FULLSPEED	BIT(0)
 
-#define DWC3_DCFG_LPM_CAP	(1 << 22)
+#define DWC3_DCFG_NUMP_SHIFT	17
+#define DWC3_DCFG_NUMP(n)	(((n) >> DWC3_DCFG_NUMP_SHIFT) & 0x1f)
+#define DWC3_DCFG_NUMP_MASK	(0x1f << DWC3_DCFG_NUMP_SHIFT)
+#define DWC3_DCFG_LPM_CAP	BIT(22)
+#define DWC3_DCFG_IGNSTRMPP	BIT(23)
 
 /* Device Control Register */
-#define DWC3_DCTL_RUN_STOP	(1 << 31)
-#define DWC3_DCTL_CSFTRST	(1 << 30)
-#define DWC3_DCTL_LSFTRST	(1 << 29)
+#define DWC3_DCTL_RUN_STOP	BIT(31)
+#define DWC3_DCTL_CSFTRST	BIT(30)
+#define DWC3_DCTL_LSFTRST	BIT(29)
 
 #define DWC3_DCTL_HIRD_THRES_MASK	(0x1f << 24)
 #define DWC3_DCTL_HIRD_THRES(n)	((n) << 24)
 
-#define DWC3_DCTL_APPL1RES	(1 << 23)
+#define DWC3_DCTL_APPL1RES	BIT(23)
 
 /* These apply for core versions 1.87a and earlier */
 #define DWC3_DCTL_TRGTULST_MASK		(0x0f << 17)
@@ -289,18 +465,18 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
-#define DWC3_DCTL_LPM_ERRATA_MASK	DWC3_DCTL_LPM_ERRATA(0xf)
-#define DWC3_DCTL_LPM_ERRATA(n)		((n) << 20)
+#define DWC3_DCTL_NYET_THRES_MASK	(0xf << 20)
+#define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
-#define DWC3_DCTL_KEEP_CONNECT		(1 << 19)
-#define DWC3_DCTL_L1_HIBER_EN		(1 << 18)
-#define DWC3_DCTL_CRS			(1 << 17)
-#define DWC3_DCTL_CSS			(1 << 16)
+#define DWC3_DCTL_KEEP_CONNECT		BIT(19)
+#define DWC3_DCTL_L1_HIBER_EN		BIT(18)
+#define DWC3_DCTL_CRS			BIT(17)
+#define DWC3_DCTL_CSS			BIT(16)
 
-#define DWC3_DCTL_INITU2ENA		(1 << 12)
-#define DWC3_DCTL_ACCEPTU2ENA		(1 << 11)
-#define DWC3_DCTL_INITU1ENA		(1 << 10)
-#define DWC3_DCTL_ACCEPTU1ENA		(1 << 9)
+#define DWC3_DCTL_INITU2ENA		BIT(12)
+#define DWC3_DCTL_ACCEPTU2ENA		BIT(11)
+#define DWC3_DCTL_INITU1ENA		BIT(10)
+#define DWC3_DCTL_ACCEPTU1ENA		BIT(9)
 #define DWC3_DCTL_TSTCTRL_MASK		(0xf << 1)
 
 #define DWC3_DCTL_ULSTCHNGREQ_MASK	(0x0f << 5)
@@ -315,47 +491,48 @@
 #define DWC3_DCTL_ULSTCHNG_LOOPBACK	(DWC3_DCTL_ULSTCHNGREQ(11))
 
 /* Device Event Enable Register */
-#define DWC3_DEVTEN_VNDRDEVTSTRCVEDEN	(1 << 12)
-#define DWC3_DEVTEN_EVNTOVERFLOWEN	(1 << 11)
-#define DWC3_DEVTEN_CMDCMPLTEN		(1 << 10)
-#define DWC3_DEVTEN_ERRTICERREN		(1 << 9)
-#define DWC3_DEVTEN_SOFEN		(1 << 7)
-#define DWC3_DEVTEN_EOPFEN		(1 << 6)
-#define DWC3_DEVTEN_HIBERNATIONREQEVTEN	(1 << 5)
-#define DWC3_DEVTEN_WKUPEVTEN		(1 << 4)
-#define DWC3_DEVTEN_ULSTCNGEN		(1 << 3)
-#define DWC3_DEVTEN_CONNECTDONEEN	(1 << 2)
-#define DWC3_DEVTEN_USBRSTEN		(1 << 1)
-#define DWC3_DEVTEN_DISCONNEVTEN	(1 << 0)
+#define DWC3_DEVTEN_VNDRDEVTSTRCVEDEN	BIT(12)
+#define DWC3_DEVTEN_EVNTOVERFLOWEN	BIT(11)
+#define DWC3_DEVTEN_CMDCMPLTEN		BIT(10)
+#define DWC3_DEVTEN_ERRTICERREN		BIT(9)
+#define DWC3_DEVTEN_SOFEN		BIT(7)
+#define DWC3_DEVTEN_U3L2L1SUSPEN	BIT(6)
+#define DWC3_DEVTEN_HIBERNATIONREQEVTEN	BIT(5)
+#define DWC3_DEVTEN_WKUPEVTEN		BIT(4)
+#define DWC3_DEVTEN_ULSTCNGEN		BIT(3)
+#define DWC3_DEVTEN_CONNECTDONEEN	BIT(2)
+#define DWC3_DEVTEN_USBRSTEN		BIT(1)
+#define DWC3_DEVTEN_DISCONNEVTEN	BIT(0)
+
+#define DWC3_DSTS_CONNLANES(n)		(((n) >> 30) & 0x3) /* DWC_usb32 only */
 
 /* Device Status Register */
-#define DWC3_DSTS_DCNRD			(1 << 29)
+#define DWC3_DSTS_DCNRD			BIT(29)
 
 /* This applies for core versions 1.87a and earlier */
-#define DWC3_DSTS_PWRUPREQ		(1 << 24)
+#define DWC3_DSTS_PWRUPREQ		BIT(24)
 
 /* These apply for core versions 1.94a and later */
-#define DWC3_DSTS_RSS			(1 << 25)
-#define DWC3_DSTS_SSS			(1 << 24)
+#define DWC3_DSTS_RSS			BIT(25)
+#define DWC3_DSTS_SSS			BIT(24)
 
-#define DWC3_DSTS_COREIDLE		(1 << 23)
-#define DWC3_DSTS_DEVCTRLHLT		(1 << 22)
+#define DWC3_DSTS_COREIDLE		BIT(23)
+#define DWC3_DSTS_DEVCTRLHLT		BIT(22)
 
 #define DWC3_DSTS_USBLNKST_MASK		(0x0f << 18)
 #define DWC3_DSTS_USBLNKST(n)		(((n) & DWC3_DSTS_USBLNKST_MASK) >> 18)
 
-#define DWC3_DSTS_RXFIFOEMPTY		(1 << 17)
+#define DWC3_DSTS_RXFIFOEMPTY		BIT(17)
 
 #define DWC3_DSTS_SOFFN_MASK		(0x3fff << 3)
 #define DWC3_DSTS_SOFFN(n)		(((n) & DWC3_DSTS_SOFFN_MASK) >> 3)
 
 #define DWC3_DSTS_CONNECTSPD		(7 << 0)
 
+#define DWC3_DSTS_SUPERSPEED_PLUS	(5 << 0) /* DWC_usb31 only */
 #define DWC3_DSTS_SUPERSPEED		(4 << 0)
 #define DWC3_DSTS_HIGHSPEED		(0 << 0)
-#define DWC3_DSTS_FULLSPEED2		(1 << 0)
-#define DWC3_DSTS_LOWSPEED		(2 << 0)
-#define DWC3_DSTS_FULLSPEED1		(3 << 0)
+#define DWC3_DSTS_FULLSPEED		BIT(0)
 
 /* Device Generic Command Register */
 #define DWC3_DGCMD_SET_LMP		0x01
@@ -369,28 +546,33 @@
 #define DWC3_DGCMD_SELECTED_FIFO_FLUSH	0x09
 #define DWC3_DGCMD_ALL_FIFO_FLUSH	0x0a
 #define DWC3_DGCMD_SET_ENDPOINT_NRDY	0x0c
+#define DWC3_DGCMD_SET_ENDPOINT_PRIME	0x0d
 #define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
+#define DWC3_DGCMD_DEV_NOTIFICATION	0x07
 
-#define DWC3_DGCMD_STATUS(n)		(((n) >> 15) & 1)
-#define DWC3_DGCMD_CMDACT		(1 << 10)
-#define DWC3_DGCMD_CMDIOC		(1 << 8)
+#define DWC3_DGCMD_STATUS(n)		(((n) >> 12) & 0x0F)
+#define DWC3_DGCMD_CMDACT		BIT(10)
+#define DWC3_DGCMD_CMDIOC		BIT(8)
 
 /* Device Generic Command Parameter Register */
-#define DWC3_DGCMDPAR_FORCE_LINKPM_ACCEPT	(1 << 0)
+#define DWC3_DGCMDPAR_FORCE_LINKPM_ACCEPT	BIT(0)
 #define DWC3_DGCMDPAR_FIFO_NUM(n)		((n) << 0)
 #define DWC3_DGCMDPAR_RX_FIFO			(0 << 5)
-#define DWC3_DGCMDPAR_TX_FIFO			(1 << 5)
+#define DWC3_DGCMDPAR_TX_FIFO			BIT(5)
 #define DWC3_DGCMDPAR_LOOPBACK_DIS		(0 << 0)
-#define DWC3_DGCMDPAR_LOOPBACK_ENA		(1 << 0)
+#define DWC3_DGCMDPAR_LOOPBACK_ENA		BIT(0)
+#define DWC3_DGCMDPAR_DN_FUNC_WAKE		BIT(0)
+#define DWC3_DGCMDPAR_INTF_SEL(n)		((n) << 4)
 
 /* Device Endpoint Command Register */
 #define DWC3_DEPCMD_PARAM_SHIFT		16
 #define DWC3_DEPCMD_PARAM(x)		((x) << DWC3_DEPCMD_PARAM_SHIFT)
 #define DWC3_DEPCMD_GET_RSC_IDX(x)	(((x) >> DWC3_DEPCMD_PARAM_SHIFT) & 0x7f)
-#define DWC3_DEPCMD_STATUS(x)		(((x) >> 15) & 1)
-#define DWC3_DEPCMD_HIPRI_FORCERM	(1 << 11)
-#define DWC3_DEPCMD_CMDACT		(1 << 10)
-#define DWC3_DEPCMD_CMDIOC		(1 << 8)
+#define DWC3_DEPCMD_STATUS(x)		(((x) >> 12) & 0x0F)
+#define DWC3_DEPCMD_HIPRI_FORCERM	BIT(11)
+#define DWC3_DEPCMD_CLEARPENDIN		BIT(11)
+#define DWC3_DEPCMD_CMDACT		BIT(10)
+#define DWC3_DEPCMD_CMDIOC		BIT(8)
 
 #define DWC3_DEPCMD_DEPSTARTCFG		(0x09 << 0)
 #define DWC3_DEPCMD_ENDTRANSFER		(0x08 << 0)
@@ -408,13 +590,92 @@
 #define DWC3_DEPCMD_CMD(x)		((x) & 0xf)
 
 /* The EP number goes 0..31 so ep0 is always out and ep1 is always in */
-#define DWC3_DALEPENA_EP(n)		(1 << n)
+#define DWC3_DALEPENA_EP(n)		BIT(n)
+
+/* DWC_usb32 DCFG1 config */
+#define DWC3_DCFG1_DIS_MST_ENH		BIT(1)
 
 #define DWC3_DEPCMD_TYPE_CONTROL	0
 #define DWC3_DEPCMD_TYPE_ISOC		1
 #define DWC3_DEPCMD_TYPE_BULK		2
 #define DWC3_DEPCMD_TYPE_INTR		3
 
+#define DWC3_DEV_IMOD_COUNT_SHIFT	16
+#define DWC3_DEV_IMOD_COUNT_MASK	(0xffff << 16)
+#define DWC3_DEV_IMOD_INTERVAL_SHIFT	0
+#define DWC3_DEV_IMOD_INTERVAL_MASK	(0xffff << 0)
+
+/* OTG Configuration Register */
+#define DWC3_OCFG_DISPWRCUTTOFF		BIT(5)
+#define DWC3_OCFG_HIBDISMASK		BIT(4)
+#define DWC3_OCFG_SFTRSTMASK		BIT(3)
+#define DWC3_OCFG_OTGVERSION		BIT(2)
+#define DWC3_OCFG_HNPCAP		BIT(1)
+#define DWC3_OCFG_SRPCAP		BIT(0)
+
+/* OTG CTL Register */
+#define DWC3_OCTL_OTG3GOERR		BIT(7)
+#define DWC3_OCTL_PERIMODE		BIT(6)
+#define DWC3_OCTL_PRTPWRCTL		BIT(5)
+#define DWC3_OCTL_HNPREQ		BIT(4)
+#define DWC3_OCTL_SESREQ		BIT(3)
+#define DWC3_OCTL_TERMSELIDPULSE	BIT(2)
+#define DWC3_OCTL_DEVSETHNPEN		BIT(1)
+#define DWC3_OCTL_HSTSETHNPEN		BIT(0)
+
+/* OTG Event Register */
+#define DWC3_OEVT_DEVICEMODE		BIT(31)
+#define DWC3_OEVT_XHCIRUNSTPSET		BIT(27)
+#define DWC3_OEVT_DEVRUNSTPSET		BIT(26)
+#define DWC3_OEVT_HIBENTRY		BIT(25)
+#define DWC3_OEVT_CONIDSTSCHNG		BIT(24)
+#define DWC3_OEVT_HRRCONFNOTIF		BIT(23)
+#define DWC3_OEVT_HRRINITNOTIF		BIT(22)
+#define DWC3_OEVT_ADEVIDLE		BIT(21)
+#define DWC3_OEVT_ADEVBHOSTEND		BIT(20)
+#define DWC3_OEVT_ADEVHOST		BIT(19)
+#define DWC3_OEVT_ADEVHNPCHNG		BIT(18)
+#define DWC3_OEVT_ADEVSRPDET		BIT(17)
+#define DWC3_OEVT_ADEVSESSENDDET	BIT(16)
+#define DWC3_OEVT_BDEVBHOSTEND		BIT(11)
+#define DWC3_OEVT_BDEVHNPCHNG		BIT(10)
+#define DWC3_OEVT_BDEVSESSVLDDET	BIT(9)
+#define DWC3_OEVT_BDEVVBUSCHNG		BIT(8)
+#define DWC3_OEVT_BSESSVLD		BIT(3)
+#define DWC3_OEVT_HSTNEGSTS		BIT(2)
+#define DWC3_OEVT_SESREQSTS		BIT(1)
+#define DWC3_OEVT_ERROR			BIT(0)
+
+/* OTG Event Enable Register */
+#define DWC3_OEVTEN_XHCIRUNSTPSETEN	BIT(27)
+#define DWC3_OEVTEN_DEVRUNSTPSETEN	BIT(26)
+#define DWC3_OEVTEN_HIBENTRYEN		BIT(25)
+#define DWC3_OEVTEN_CONIDSTSCHNGEN	BIT(24)
+#define DWC3_OEVTEN_HRRCONFNOTIFEN	BIT(23)
+#define DWC3_OEVTEN_HRRINITNOTIFEN	BIT(22)
+#define DWC3_OEVTEN_ADEVIDLEEN		BIT(21)
+#define DWC3_OEVTEN_ADEVBHOSTENDEN	BIT(20)
+#define DWC3_OEVTEN_ADEVHOSTEN		BIT(19)
+#define DWC3_OEVTEN_ADEVHNPCHNGEN	BIT(18)
+#define DWC3_OEVTEN_ADEVSRPDETEN	BIT(17)
+#define DWC3_OEVTEN_ADEVSESSENDDETEN	BIT(16)
+#define DWC3_OEVTEN_BDEVBHOSTENDEN	BIT(11)
+#define DWC3_OEVTEN_BDEVHNPCHNGEN	BIT(10)
+#define DWC3_OEVTEN_BDEVSESSVLDDETEN	BIT(9)
+#define DWC3_OEVTEN_BDEVVBUSCHNGEN	BIT(8)
+
+/* OTG Status Register */
+#define DWC3_OSTS_DEVRUNSTP		BIT(13)
+#define DWC3_OSTS_XHCIRUNSTP		BIT(12)
+#define DWC3_OSTS_PERIPHERALSTATE	BIT(4)
+#define DWC3_OSTS_XHCIPRTPOWER		BIT(3)
+#define DWC3_OSTS_BSESVLD		BIT(2)
+#define DWC3_OSTS_VBUSVLD		BIT(1)
+#define DWC3_OSTS_CONIDSTS		BIT(0)
+
+/* Force Gen1 speed on Gen2 link */
+#define DWC3_LLUCTL_FORCE_GEN1		BIT(10)
+
 /* Structures */
 
 struct dwc3_trb;
@@ -422,6 +683,7 @@ struct dwc3_trb;
 /**
  * struct dwc3_event_buffer - Software event buffer representation
  * @buf: _THE_ buffer
+ * @cache: The buffer cache used in the threaded interrupt
  * @length: size of this buffer
  * @lpos: event offset
  * @count: cache of last read event count register
@@ -431,84 +693,115 @@ struct dwc3_trb;
  */
 struct dwc3_event_buffer {
 	void			*buf;
-	unsigned		length;
+	void			*cache;
+	unsigned int		length;
 	unsigned int		lpos;
 	unsigned int		count;
 	unsigned int		flags;
 
-#define DWC3_EVENT_PENDING	(1UL << 0)
+#define DWC3_EVENT_PENDING	BIT(0)
 
 	dma_addr_t		dma;
 
 	struct dwc3		*dwc;
 };
 
-#define DWC3_EP_FLAG_STALLED	(1 << 0)
-#define DWC3_EP_FLAG_WEDGED	(1 << 1)
+#define DWC3_EP_FLAG_STALLED	BIT(0)
+#define DWC3_EP_FLAG_WEDGED	BIT(1)
 
 #define DWC3_EP_DIRECTION_TX	true
 #define DWC3_EP_DIRECTION_RX	false
 
-#define DWC3_TRB_NUM		32
-#define DWC3_TRB_MASK		(DWC3_TRB_NUM - 1)
+#define DWC3_TRB_NUM		256
 
 /**
  * struct dwc3_ep - device side endpoint representation
  * @endpoint: usb endpoint
- * @request_list: list of requests for this endpoint
- * @req_queued: list of requests on this ep which have TRBs setup
+ * @nostream_work: work for handling bulk NoStream
+ * @cancelled_list: list of cancelled requests for this endpoint
+ * @pending_list: list of pending requests for this endpoint
+ * @started_list: list of started requests on this endpoint
+ * @regs: pointer to first endpoint register
  * @trb_pool: array of transaction buffers
  * @trb_pool_dma: dma address of @trb_pool
- * @free_slot: next slot which is going to be used
- * @busy_slot: first slot which is owned by HW
- * @desc: usb_endpoint_descriptor pointer
+ * @trb_enqueue: enqueue 'pointer' into TRB array
+ * @trb_dequeue: dequeue 'pointer' into TRB array
  * @dwc: pointer to DWC controller
  * @saved_state: ep state saved during hibernation
  * @flags: endpoint flags (wedged, stalled, ...)
- * @current_trb: index of current used trb
  * @number: endpoint number (1 - 15)
  * @type: set to bmAttributes & USB_ENDPOINT_XFERTYPE_MASK
  * @resource_index: Resource transfer index
+ * @frame_number: set to the frame number we want this transfer to start (ISOC)
  * @interval: the interval on which the ISOC transfer is started
  * @name: a human readable name e.g. ep1out-bulk
  * @direction: true for TX, false for RX
  * @stream_capable: true when streams are enabled
+ * @combo_num: the test combination BIT[15:14] of the frame number to test
+ *		isochronous START TRANSFER command failure workaround
+ * @start_cmd_status: the status of testing START TRANSFER command with
+ *		combo_num = 'b00
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
-	struct list_head	request_list;
-	struct list_head	req_queued;
+	struct delayed_work	nostream_work;
+	struct list_head	cancelled_list;
+	struct list_head	pending_list;
+	struct list_head	started_list;
+
+	void __iomem		*regs;
 
 	struct dwc3_trb		*trb_pool;
 	dma_addr_t		trb_pool_dma;
-	u32			free_slot;
-	u32			busy_slot;
-	const struct usb_ss_ep_comp_descriptor *comp_desc;
 	struct dwc3		*dwc;
 
 	u32			saved_state;
-	unsigned		flags;
-#define DWC3_EP_ENABLED		(1 << 0)
-#define DWC3_EP_STALL		(1 << 1)
-#define DWC3_EP_WEDGE		(1 << 2)
-#define DWC3_EP_BUSY		(1 << 4)
-#define DWC3_EP_PENDING_REQUEST	(1 << 5)
-#define DWC3_EP_MISSED_ISOC	(1 << 6)
+	unsigned int		flags;
+#define DWC3_EP_ENABLED			BIT(0)
+#define DWC3_EP_STALL			BIT(1)
+#define DWC3_EP_WEDGE			BIT(2)
+#define DWC3_EP_TRANSFER_STARTED	BIT(3)
+#define DWC3_EP_END_TRANSFER_PENDING	BIT(4)
+#define DWC3_EP_PENDING_REQUEST		BIT(5)
+#define DWC3_EP_DELAY_START		BIT(6)
+#define DWC3_EP_WAIT_TRANSFER_COMPLETE	BIT(7)
+#define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
+#define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
+#define DWC3_EP_STREAM_PRIMED		BIT(10)
+#define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
+#define DWC3_EP_TXFIFO_RESIZED		BIT(12)
+#define DWC3_EP_DELAY_STOP             BIT(13)
+#define DWC3_EP_RESOURCE_ALLOCATED	BIT(14)
 
 	/* This last one is specific to EP0 */
-#define DWC3_EP0_DIR_IN		(1 << 31)
+#define DWC3_EP0_DIR_IN			BIT(31)
 
-	unsigned		current_trb;
+	/*
+	 * IMPORTANT: we *know* we have 256 TRBs in our @trb_pool, so we will
+	 * use a u8 type here. If anybody decides to increase number of TRBs to
+	 * anything larger than 256 - I can't see why people would want to do
+	 * this though - then this type needs to be changed.
+	 *
+	 * By using u8 types we ensure that our % operator when incrementing
+	 * enqueue and dequeue get optimized away by the compiler.
+	 */
+	u8			trb_enqueue;
+	u8			trb_dequeue;
 
 	u8			number;
 	u8			type;
 	u8			resource_index;
+	u32			frame_number;
 	u32			interval;
 
 	char			name[20];
 
 	unsigned		direction:1;
 	unsigned		stream_capable:1;
+
+	/* For isochronous START TRANSFER workaround only */
+	u8			combo_num;
+	int			start_cmd_status;
 };
 
 enum dwc3_phy {
@@ -562,15 +855,17 @@ enum dwc3_link_state {
 #define DWC3_TRB_STS_XFER_IN_PROG	4
 
 /* TRB Control */
-#define DWC3_TRB_CTRL_HWO		(1 << 0)
-#define DWC3_TRB_CTRL_LST		(1 << 1)
-#define DWC3_TRB_CTRL_CHN		(1 << 2)
-#define DWC3_TRB_CTRL_CSP		(1 << 3)
+#define DWC3_TRB_CTRL_HWO		BIT(0)
+#define DWC3_TRB_CTRL_LST		BIT(1)
+#define DWC3_TRB_CTRL_CHN		BIT(2)
+#define DWC3_TRB_CTRL_CSP		BIT(3)
 #define DWC3_TRB_CTRL_TRBCTL(n)		(((n) & 0x3f) << 4)
-#define DWC3_TRB_CTRL_ISP_IMI		(1 << 10)
-#define DWC3_TRB_CTRL_IOC		(1 << 11)
+#define DWC3_TRB_CTRL_ISP_IMI		BIT(10)
+#define DWC3_TRB_CTRL_IOC		BIT(11)
 #define DWC3_TRB_CTRL_SID_SOFN(n)	(((n) & 0xffff) << 14)
+#define DWC3_TRB_CTRL_GET_SID_SOFN(n)	(((n) & (0xffff << 14)) >> 14)
 
+#define DWC3_TRBCTL_TYPE(n)		((n) & (0x3f << 4))
 #define DWC3_TRBCTL_NORMAL		DWC3_TRB_CTRL_TRBCTL(1)
 #define DWC3_TRBCTL_CONTROL_SETUP	DWC3_TRB_CTRL_TRBCTL(2)
 #define DWC3_TRBCTL_CONTROL_STATUS2	DWC3_TRB_CTRL_TRBCTL(3)
@@ -585,7 +880,7 @@ enum dwc3_link_state {
  * @bpl: DW0-3
  * @bph: DW4-7
  * @size: DW8-B
- * @trl: DWC-F
+ * @ctrl: DWC-F
  */
 struct dwc3_trb {
 	u32		bpl;
@@ -595,16 +890,17 @@ struct dwc3_trb {
 } __packed;
 
 /**
- * dwc3_hwparams - copy of HWPARAMS registers
- * @hwparams0 - GHWPARAMS0
- * @hwparams1 - GHWPARAMS1
- * @hwparams2 - GHWPARAMS2
- * @hwparams3 - GHWPARAMS3
- * @hwparams4 - GHWPARAMS4
- * @hwparams5 - GHWPARAMS5
- * @hwparams6 - GHWPARAMS6
- * @hwparams7 - GHWPARAMS7
- * @hwparams8 - GHWPARAMS8
+ * struct dwc3_hwparams - copy of HWPARAMS registers
+ * @hwparams0: GHWPARAMS0
+ * @hwparams1: GHWPARAMS1
+ * @hwparams2: GHWPARAMS2
+ * @hwparams3: GHWPARAMS3
+ * @hwparams4: GHWPARAMS4
+ * @hwparams5: GHWPARAMS5
+ * @hwparams6: GHWPARAMS6
+ * @hwparams7: GHWPARAMS7
+ * @hwparams8: GHWPARAMS8
+ * @hwparams9: GHWPARAMS9
  */
 struct dwc3_hwparams {
 	u32	hwparams0;
@@ -616,14 +912,14 @@ struct dwc3_hwparams {
 	u32	hwparams6;
 	u32	hwparams7;
 	u32	hwparams8;
+	u32	hwparams9;
 };
 
 /* HWPARAMS0 */
 #define DWC3_MODE(n)		((n) & 0x7)
 
-#define DWC3_MDWIDTH(n)		(((n) & 0xff00) >> 8)
-
 /* HWPARAMS1 */
+#define DWC3_SPRAM_TYPE(n)	(((n) >> 23) & 1)
 #define DWC3_NUM_INT(n)		(((n) & (0x3f << 15)) >> 15)
 
 /* HWPARAMS3 */
@@ -634,22 +930,58 @@ struct dwc3_hwparams {
 #define DWC3_NUM_IN_EPS(p)	(((p)->hwparams3 &		\
 			(DWC3_NUM_IN_EPS_MASK)) >> 18)
 
+/* HWPARAMS6 */
+#define DWC3_RAM0_DEPTH(n)	(((n) & (0xffff0000)) >> 16)
+
 /* HWPARAMS7 */
 #define DWC3_RAM1_DEPTH(n)	((n) & 0xffff)
 
+/* HWPARAMS9 */
+#define DWC3_MST_CAPABLE(p)	(!!((p)->hwparams9 &		\
+			DWC3_GHWPARAMS9_DEV_MST))
+
+/**
+ * struct dwc3_request - representation of a transfer request
+ * @request: struct usb_request to be transferred
+ * @list: a list_head used for request queueing
+ * @dep: struct dwc3_ep owning this request
+ * @start_sg: pointer to the sg which should be queued next
+ * @num_pending_sgs: counter to pending sgs
+ * @remaining: amount of data remaining
+ * @status: internal dwc3 request status tracking
+ * @epnum: endpoint number to which this request refers
+ * @trb: pointer to struct dwc3_trb
+ * @trb_dma: DMA address of @trb
+ * @num_trbs: number of TRBs used by this request
+ * @direction: IN or OUT direction flag
+ * @mapped: true when request has been dma-mapped
+ */
 struct dwc3_request {
 	struct usb_request	request;
 	struct list_head	list;
 	struct dwc3_ep		*dep;
-	u32			start_slot;
+	struct scatterlist	*start_sg;
+
+	unsigned int		num_pending_sgs;
+	unsigned int		remaining;
+
+	unsigned int		status;
+#define DWC3_REQUEST_STATUS_QUEUED		0
+#define DWC3_REQUEST_STATUS_STARTED		1
+#define DWC3_REQUEST_STATUS_DISCONNECTED	2
+#define DWC3_REQUEST_STATUS_DEQUEUED		3
+#define DWC3_REQUEST_STATUS_STALLED		4
+#define DWC3_REQUEST_STATUS_COMPLETED		5
+#define DWC3_REQUEST_STATUS_UNKNOWN		-1
 
 	u8			epnum;
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
 
-	unsigned		direction:1;
-	unsigned		mapped:1;
-	unsigned		queued:1;
+	unsigned int		num_trbs;
+
+	unsigned int		direction:1;
+	unsigned int		mapped:1;
 };
 
 /*
@@ -662,73 +994,119 @@ struct dwc3_scratchpad_array {
 
 /**
  * struct dwc3 - representation of our controller
- * @ctrl_req: usb control request which is used for ep0
+ * @drd_work: workqueue used for role swapping
  * @ep0_trb: trb which is used for the ctrl_req
- * @ep0_bounce: bounce buffer for ep0
+ * @bounce: address of bounce buffer
  * @setup_buf: used while precessing STD USB requests
- * @ctrl_req_addr: dma address of ctrl_req
- * @ep0_trb: dma address of ep0_trb
+ * @ep0_trb_addr: dma address of @ep0_trb
+ * @bounce_addr: dma address of @bounce
  * @ep0_usb_req: dummy req used while handling STD USB requests
- * @ep0_bounce_addr: dma address of ep0_bounce
- * @setup_buf_addr: dma address of setup_buf
- * @scratch_addr: dma address of scratchbuf
+ * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
+ * @mutex: for mode switching
  * @dev: pointer to our struct device
+ * @sysdev: pointer to the DMA-capable device
  * @xhci: pointer to our xHCI child
- * @event_buffer_list: a list of event buffers
+ * @xhci_resources: struct resources for our @xhci child
+ * @ev_buf: struct dwc3_event_buffer pointer
+ * @eps: endpoint array
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
+ * @bus_clk: clock for accessing the registers
  * @ref_clk: reference clock
+ * @susp_clk: clock used when the SS phy is in low power (S3) state
+ * @utmi_clk: clock used for USB2 PHY communication
+ * @pipe_clk: clock used for USB3 PHY communication
+ * @reset: reset control
  * @regs: base address for our registers
  * @regs_size: address space size
+ * @fladj: frame length adjustment
  * @ref_clk_per: reference clock period configuration
- * @nr_scratch: number of scratch buffers
- * @num_event_buffers: calculated number of event buffers
+ * @irq_gadget: peripheral controller's IRQ number
+ * @otg_irq: IRQ number for OTG IRQs
+ * @current_otg_role: current role of operation while using the OTG block
+ * @desired_otg_role: desired role of operation while using the OTG block
+ * @otg_restart_host: flag that OTG controller needs to restart host
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
- * @revision: revision register contents
+ * @max_ssp_rate: SuperSpeed Plus maximum signaling rate and lane count
+ * @gadget_max_speed: maximum gadget speed requested
+ * @gadget_ssp_rate: Gadget driver's maximum supported SuperSpeed Plus signaling
+ *			rate and lane count.
+ * @ip: controller's ID
+ * @revision: controller's version of an IP
+ * @version_type: VERSIONTYPE register contents, a sub release of a revision
  * @dr_mode: requested mode of operation
+ * @current_dr_role: current role of operation when in dual-role mode
+ * @desired_dr_role: desired role of operation when in dual-role mode
+ * @edev: extcon handle
+ * @edev_nb: extcon notifier
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
- * @dcfg: saved contents of DCFG register
- * @gctl: saved contents of GCTL register
- * @isoch_delay: wValue from Set Isochronous Delay request;
+ * @role_sw: usb_role_switch handle
+ * @role_switch_default_mode: default operation mode of controller while
+ *			usb role is USB_ROLE_NONE.
+ * @usb_psy: pointer to power supply interface.
+ * @usb2_phy: pointer to USB2 PHY
+ * @usb3_phy: pointer to USB3 PHY
+ * @usb2_generic_phy: pointer to array of USB2 PHYs
+ * @usb3_generic_phy: pointer to array of USB3 PHYs
+ * @num_usb2_ports: number of USB2 ports
+ * @num_usb3_ports: number of USB3 ports
+ * @phys_ready: flag to indicate that PHYs are ready
+ * @ulpi: pointer to ulpi interface
+ * @ulpi_ready: flag to indicate that ULPI is initialized
  * @u2sel: parameter from Set SEL request.
  * @u2pel: parameter from Set SEL request.
  * @u1sel: parameter from Set SEL request.
  * @u1pel: parameter from Set SEL request.
- * @num_out_eps: number of out endpoints
- * @num_in_eps: number of in endpoints
+ * @num_eps: number of endpoints
  * @ep0_next_event: hold the next expected event
  * @ep0state: state of endpoint zero
  * @link_state: link state
  * @speed: device speed (super, high, full, low)
- * @mem: points to start of memory which is used for this struct.
  * @hwparams: copy of hwparams registers
- * @root: debugfs root folder pointer
  * @regset: debugfs pointer to regdump file
+ * @dbg_lsp_select: current debug lsp mux register selection
  * @test_mode: true when we're entering a USB test mode
  * @test_mode_nr: test feature selector
  * @lpm_nyet_threshold: LPM NYET response threshold
  * @hird_threshold: HIRD threshold
+ * @rx_thr_num_pkt: USB receive packet count
+ * @rx_max_burst: max USB receive burst size
+ * @tx_thr_num_pkt: USB transmit packet count
+ * @tx_max_burst: max USB transmit burst size
+ * @rx_thr_num_pkt_prd: periodic ESS receive packet count
+ * @rx_max_burst_prd: max periodic ESS receive burst size
+ * @tx_thr_num_pkt_prd: periodic ESS transmit packet count
+ * @tx_max_burst_prd: max periodic ESS transmit burst size
+ * @tx_fifo_resize_max_num: max number of fifos allocated during txfifo resize
+ * @clear_stall_protocol: endpoint number that requires a delayed status phase
+ * @num_hc_interrupters: number of host controller interrupters
+ * @hsphy_interface: "utmi" or "ulpi"
+ * @connected: true when we're connected to a host, false otherwise
+ * @softconnect: true when gadget connect is called, false when disconnect runs
  * @delayed_status: true when gadget driver asks for delayed status
  * @ep0_bounced: true when we used bounce buffer
  * @ep0_expect_in: true when we expect a DATA IN transfer
- * @has_hibernation: true when dwc3 was configured with Hibernation
+ * @sysdev_is_parent: true when dwc3 device has a parent driver
  * @has_lpm_erratum: true when core was configured with LPM Erratum. Note that
  *			there's now way for software to detect this in runtime.
  * @is_utmi_l1_suspend: the core asserts output signal
  *	0	- utmi_sleep_n
  *	1	- utmi_l1_suspend_n
- * @is_selfpowered: true when we are selfpowered
  * @is_fpga: true when we are using the FPGA board
- * @needs_fifo_resize: not all users might want fifo resizing, flag it
+ * @pending_events: true when we have pending IRQs to be handled
+ * @do_fifo_resize: true when txfifo resizing is enabled for dwc3 endpoints
  * @pullups_connected: true when Run/Stop bit is set
- * @resize_fifos: tells us it's ok to reconfigure our TxFIFO sizes.
  * @setup_packet_pending: true when there's a Setup Packet in FIFO. Workaround
- * @start_config_issued: true when StartConfig command has been issued
  * @three_stage_setup: set if we perform a three phase setup
+ * @dis_start_transfer_quirk: set if start_transfer failure SW workaround is
+ *			not needed for DWC_usb31 version 1.70a-ea06 and below
+ * @usb3_lpm_capable: set if hadrware supports Link Power Management
+ * @usb2_lpm_disable: set to disable usb2 lpm for host
+ * @usb2_gadget_lpm_disable: set to disable usb2 lpm for gadget
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
  * @u2exit_lfps_quirk: set if we enable u2exit lfps quirk
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
@@ -739,64 +1117,144 @@ struct dwc3_scratchpad_array {
  * @rx_detect_poll_quirk: set if we enable rx_detect to polling lfps quirk
  * @dis_u3_susphy_quirk: set if we disable usb3 suspend phy
  * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
+ * @dis_enblslpm_quirk: set if we clear enblslpm in GUSB2PHYCFG,
+ *                      disabling the suspend signal to the PHY.
+ * @dis_u1_entry_quirk: set if link entering into U1 state needs to be disabled.
+ * @dis_u2_entry_quirk: set if link entering into U2 state needs to be disabled.
+ * @dis_rxdet_inp3_quirk: set if we disable Rx.Detect in P3
+ * @async_callbacks: if set, indicate that async callbacks will be used.
+ *
+ * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists
+ *			in GUSB2PHYCFG, specify that USB2 PHY doesn't
+ *			provide a free-running PHY clock.
+ * @dis_del_phy_power_chg_quirk: set if we disable delay phy power
+ *			change quirk.
+ * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
+ *			check during HS transmit.
+ * @resume_hs_terminations: Set if we enable quirk for fixing improper crc
+ *			generation after resume from suspend.
+ * @ulpi_ext_vbus_drv: Set to confiure the upli chip to drives CPEN pin
+ *			VBUS with an external supply.
+ * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
+ *			instances in park mode.
+ * @parkmode_disable_hs_quirk: set if we need to disable all HishSpeed
+ *			instances in park mode.
+ * @gfladj_refclk_lpm_sel: set if we need to enable SOF/ITP counter
+ *                          running based on ref_clk
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  *	0	- -6dB de-emphasis
  *	1	- -3.5dB de-emphasis
  *	2	- No de-emphasis
  *	3	- Reserved
- * @index: index of _this_ controller
- * @list: to maintain the list of dwc3 controllers
+ * @dis_metastability_quirk: set to disable metastability quirk.
+ * @dis_split_quirk: set to disable split boundary.
+ * @sys_wakeup: set if the device may do system wakeup.
+ * @wakeup_configured: set if the device is configured for remote wakeup.
+ * @suspended: set to track suspend event due to U3/L2.
+ * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY + DWC3_GUSB3PIPECTL_SUSPHY
+ *		  before PM suspend.
+ * @imod_interval: set the interrupt moderation interval in 250ns
+ *			increments or 0 to disable.
+ * @max_cfg_eps: current max number of IN eps used across all USB configs.
+ * @last_fifo_depth: last fifo depth used to determine next fifo ram start
+ *		     address.
+ * @num_ep_resized: carries the current number endpoints which have had its tx
+ *		    fifo resized.
+ * @debug_root: root debugfs directory for this device to put its files in.
+ * @gsbuscfg0_reqinfo: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
+ *		       DATWRREQINFO, and DESWRREQINFO value passed from
+ *		       glue driver.
+ * @wakeup_pending_funcs: Indicates whether any interface has requested for
+ *			 function wakeup in bitmap format where bit position
+ *			 represents interface_id.
  */
 struct dwc3 {
-	struct usb_ctrlrequest	*ctrl_req;
+	struct work_struct	drd_work;
 	struct dwc3_trb		*ep0_trb;
-	void			*ep0_bounce;
-	void			*scratchbuf;
+	void			*bounce;
 	u8			*setup_buf;
-	dma_addr_t		ctrl_req_addr;
 	dma_addr_t		ep0_trb_addr;
-	dma_addr_t		ep0_bounce_addr;
-	dma_addr_t		scratch_addr;
-	dma_addr_t		setup_buf_addr;
+	dma_addr_t		bounce_addr;
 	struct dwc3_request	ep0_usb_req;
+	struct completion	ep0_in_setup;
 
 	/* device lock */
 	spinlock_t		lock;
 
-#if defined(__UBOOT__) && CONFIG_IS_ENABLED(DM_USB)
-	struct udevice		*dev;
-#else
+	/* mode switching lock */
+	struct mutex		mutex;
+
 	struct device		*dev;
-#endif
+	struct device		*sysdev;
 
 	struct platform_device	*xhci;
 	struct resource		xhci_resources[DWC3_XHCI_RESOURCES_NUM];
 
-	struct dwc3_event_buffer **ev_buffs;
+	struct dwc3_event_buffer *ev_buf;
 	struct dwc3_ep		*eps[DWC3_ENDPOINTS_NUM];
 
-	struct usb_gadget	gadget;
+	struct usb_gadget	*gadget;
 	struct usb_gadget_driver *gadget_driver;
 
+	struct clk		*bus_clk;
 	struct clk		*ref_clk;
+	struct clk		*susp_clk;
+	struct clk		*utmi_clk;
+	struct clk		*pipe_clk;
+
+	struct reset_control	*reset;
+
+	struct usb_phy		*usb2_phy;
+	struct usb_phy		*usb3_phy;
+
+	struct phy		*usb2_generic_phy[DWC3_USB2_MAX_PORTS];
+	struct phy		*usb3_generic_phy[DWC3_USB3_MAX_PORTS];
+
+	u8			num_usb2_ports;
+	u8			num_usb3_ports;
+
+	bool			phys_ready;
+
+	struct ulpi		*ulpi;
+	bool			ulpi_ready;
 
 	void __iomem		*regs;
 	size_t			regs_size;
 
 	enum usb_dr_mode	dr_mode;
+	u32			current_dr_role;
+	u32			desired_dr_role;
+	struct extcon_dev	*edev;
+	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
+	struct usb_role_switch	*role_sw;
+	enum usb_dr_mode	role_switch_default_mode;
 
-	/* used for suspend/resume */
-	u32			dcfg;
-	u32			gctl;
+	struct power_supply	*usb_psy;
 
-	u32			nr_scratch;
-	u32			num_event_buffers;
+	u32			fladj;
+	u32			ref_clk_per;
+	u32			irq_gadget;
+	u32			otg_irq;
+	u32			current_otg_role;
+	u32			desired_otg_role;
+	bool			otg_restart_host;
 	u32			u1u2;
 	u32			maximum_speed;
+	u32			gadget_max_speed;
+	enum usb_ssp_rate	max_ssp_rate;
+	enum usb_ssp_rate	gadget_ssp_rate;
+
+	u32			ip;
+
+#define DWC3_IP			0x5533
+#define DWC31_IP		0x3331
+#define DWC32_IP		0x3332
+
 	u32			revision;
 
+#define DWC3_REVISION_ANY	0x0
 #define DWC3_REVISION_173A	0x5533173a
 #define DWC3_REVISION_175A	0x5533175a
 #define DWC3_REVISION_180A	0x5533180a
@@ -817,12 +1275,37 @@ struct dwc3 {
 #define DWC3_REVISION_270A	0x5533270a
 #define DWC3_REVISION_280A	0x5533280a
 #define DWC3_REVISION_290A	0x5533290a
+#define DWC3_REVISION_300A	0x5533300a
+#define DWC3_REVISION_310A	0x5533310a
+#define DWC3_REVISION_320A	0x5533320a
+#define DWC3_REVISION_330A	0x5533330a
+
+#define DWC31_REVISION_ANY	0x0
+#define DWC31_REVISION_110A	0x3131302a
+#define DWC31_REVISION_120A	0x3132302a
+#define DWC31_REVISION_160A	0x3136302a
+#define DWC31_REVISION_170A	0x3137302a
+#define DWC31_REVISION_180A	0x3138302a
+#define DWC31_REVISION_190A	0x3139302a
+#define DWC31_REVISION_200A	0x3230302a
+
+#define DWC32_REVISION_ANY	0x0
+#define DWC32_REVISION_100A	0x3130302a
+
+	u32			version_type;
+
+#define DWC31_VERSIONTYPE_ANY		0x0
+#define DWC31_VERSIONTYPE_EA01		0x65613031
+#define DWC31_VERSIONTYPE_EA02		0x65613032
+#define DWC31_VERSIONTYPE_EA03		0x65613033
+#define DWC31_VERSIONTYPE_EA04		0x65613034
+#define DWC31_VERSIONTYPE_EA05		0x65613035
+#define DWC31_VERSIONTYPE_EA06		0x65613036
 
 	enum dwc3_ep0_next	ep0_next_event;
 	enum dwc3_ep0_state	ep0state;
 	enum dwc3_link_state	link_state;
 
-	u16			isoch_delay;
 	u16			u2sel;
 	u16			u2pel;
 	u8			u1sel;
@@ -830,38 +1313,49 @@ struct dwc3 {
 
 	u8			speed;
 
-	u8			num_out_eps;
-	u8			num_in_eps;
-
-	void			*mem;
+	u8			num_eps;
 
 	struct dwc3_hwparams	hwparams;
-	struct dentry		*root;
 	struct debugfs_regset32	*regset;
 
+	u32			dbg_lsp_select;
+
 	u8			test_mode;
 	u8			test_mode_nr;
 	u8			lpm_nyet_threshold;
 	u8			hird_threshold;
-	u32			fladj;
-	u32			ref_clk_per;
-	u8			incrx_mode;
-	u32			incrx_size;
+	u8			rx_thr_num_pkt;
+	u8			rx_max_burst;
+	u8			tx_thr_num_pkt;
+	u8			tx_max_burst;
+	u8			rx_thr_num_pkt_prd;
+	u8			rx_max_burst_prd;
+	u8			tx_thr_num_pkt_prd;
+	u8			tx_max_burst_prd;
+	u8			tx_fifo_resize_max_num;
+	u8			clear_stall_protocol;
+	u16			num_hc_interrupters;
 
+	const char		*hsphy_interface;
+
+	unsigned		connected:1;
+	unsigned		softconnect:1;
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
-	unsigned		has_hibernation:1;
+	unsigned		sysdev_is_parent:1;
 	unsigned		has_lpm_erratum:1;
 	unsigned		is_utmi_l1_suspend:1;
-	unsigned		is_selfpowered:1;
 	unsigned		is_fpga:1;
-	unsigned		needs_fifo_resize:1;
+	unsigned		pending_events:1;
+	unsigned		do_fifo_resize:1;
 	unsigned		pullups_connected:1;
-	unsigned		resize_fifos:1;
 	unsigned		setup_packet_pending:1;
-	unsigned		start_config_issued:1;
 	unsigned		three_stage_setup:1;
+	unsigned		dis_start_transfer_quirk:1;
+	unsigned		usb3_lpm_capable:1;
+	unsigned		usb2_lpm_disable:1;
+	unsigned		usb2_gadget_lpm_disable:1;
 
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
@@ -873,21 +1367,45 @@ struct dwc3 {
 	unsigned		rx_detect_poll_quirk:1;
 	unsigned		dis_u3_susphy_quirk:1;
 	unsigned		dis_u2_susphy_quirk:1;
-	unsigned		dis_del_phy_power_chg_quirk:1;
-	unsigned		dis_tx_ipgap_linecheck_quirk:1;
 	unsigned		dis_enblslpm_quirk:1;
+	unsigned		dis_u1_entry_quirk:1;
+	unsigned		dis_u2_entry_quirk:1;
+	unsigned		dis_rxdet_inp3_quirk:1;
 	unsigned		dis_u2_freeclk_exists_quirk:1;
+	unsigned		dis_del_phy_power_chg_quirk:1;
+	unsigned		dis_tx_ipgap_linecheck_quirk:1;
+	unsigned		resume_hs_terminations:1;
+	unsigned		ulpi_ext_vbus_drv:1;
+	unsigned		parkmode_disable_ss_quirk:1;
+	unsigned		parkmode_disable_hs_quirk:1;
+	unsigned		gfladj_refclk_lpm_sel:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
-	int			index;
-	struct list_head        list;
+
+	unsigned		dis_metastability_quirk:1;
+
+	unsigned		dis_split_quirk:1;
+	unsigned		async_callbacks:1;
+	unsigned		sys_wakeup:1;
+	unsigned		wakeup_configured:1;
+	unsigned		suspended:1;
+	unsigned		susphy_state:1;
+
+	u16			imod_interval;
+
+	int			max_cfg_eps;
+	int			last_fifo_depth;
+	int			num_ep_resized;
+	struct dentry		*debug_root;
+	u32			gsbuscfg0_reqinfo;
+	u32			wakeup_pending_funcs;
 };
 
 #define INCRX_BURST_MODE 0
 #define INCRX_UNDEF_LENGTH_BURST_MODE 1
 
-/* -------------------------------------------------------------------------- */
+#define work_to_dwc(w)		(container_of((w), struct dwc3, drd_work))
 
 /* -------------------------------------------------------------------------- */
 
@@ -905,31 +1423,7 @@ struct dwc3_event_type {
 #define DWC3_DEPEVT_EPCMDCMPLT		0x07
 
 /**
- * dwc3_ep_event_string - returns event name
- * @event: then event code
- */
-static inline const char *dwc3_ep_event_string(u8 event)
-{
-	switch (event) {
-	case DWC3_DEPEVT_XFERCOMPLETE:
-		return "Transfer Complete";
-	case DWC3_DEPEVT_XFERINPROGRESS:
-		return "Transfer In-Progress";
-	case DWC3_DEPEVT_XFERNOTREADY:
-		return "Transfer Not Ready";
-	case DWC3_DEPEVT_RXTXFIFOEVT:
-		return "FIFO";
-	case DWC3_DEPEVT_STREAMEVT:
-		return "Stream";
-	case DWC3_DEPEVT_EPCMDCMPLT:
-		return "Endpoint Command Complete";
-	}
-
-	return "UNKNOWN";
-}
-
-/**
- * struct dwc3_event_depvt - Device Endpoint Events
+ * struct dwc3_event_depevt - Device Endpoint Events
  * @one_bit: indicates this is an endpoint event (not used)
  * @endpoint_number: number of the endpoint
  * @endpoint_event: The event we have:
@@ -955,23 +1449,36 @@ struct dwc3_event_depevt {
 	u32	status:4;
 
 /* Within XferNotReady */
-#define DEPEVT_STATUS_TRANSFER_ACTIVE	(1 << 3)
+#define DEPEVT_STATUS_TRANSFER_ACTIVE	BIT(3)
 
-/* Within XferComplete */
-#define DEPEVT_STATUS_BUSERR	(1 << 0)
-#define DEPEVT_STATUS_SHORT	(1 << 1)
-#define DEPEVT_STATUS_IOC	(1 << 2)
-#define DEPEVT_STATUS_LST	(1 << 3)
+/* Within XferComplete or XferInProgress */
+#define DEPEVT_STATUS_BUSERR	BIT(0)
+#define DEPEVT_STATUS_SHORT	BIT(1)
+#define DEPEVT_STATUS_IOC	BIT(2)
+#define DEPEVT_STATUS_LST	BIT(3) /* XferComplete */
+#define DEPEVT_STATUS_MISSED_ISOC BIT(3) /* XferInProgress */
 
 /* Stream event only */
 #define DEPEVT_STREAMEVT_FOUND		1
 #define DEPEVT_STREAMEVT_NOTFOUND	2
 
+/* Stream event parameter */
+#define DEPEVT_STREAM_PRIME		0xfffe
+#define DEPEVT_STREAM_NOSTREAM		0x0
+
 /* Control-only Status */
 #define DEPEVT_STATUS_CONTROL_DATA	1
 #define DEPEVT_STATUS_CONTROL_STATUS	2
+#define DEPEVT_STATUS_CONTROL_PHASE(n)	((n) & 3)
+
+/* In response to Start Transfer */
+#define DEPEVT_TRANSFER_NO_RESOURCE	1
+#define DEPEVT_TRANSFER_BUS_EXPIRY	2
 
 	u32	parameters:16;
+
+/* For Command Complete Events */
+#define DEPEVT_PARAMETER_CMD(n)	(((n) & (0xf << 8)) >> 8)
 } __packed;
 
 /**
@@ -985,7 +1492,7 @@ struct dwc3_event_depevt {
  *	3	- ULStChng
  *	4	- WkUpEvt
  *	5	- Reserved
- *	6	- EOPF
+ *	6	- Suspend (EOPF on revisions 2.10a and prior)
  *	7	- SOF
  *	8	- Reserved
  *	9	- ErrticErr
@@ -1057,25 +1564,78 @@ struct dwc3_gadget_ep_cmd_params {
 #define DWC3_HAS_OTG			BIT(3)
 
 /* prototypes */
-int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
-void dwc3_of_parse(struct dwc3 *dwc);
-int dwc3_init(struct dwc3 *dwc);
-void dwc3_remove(struct dwc3 *dwc);
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
+void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
+u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
+#define DWC3_IP_IS(_ip)							\
+	(dwc->ip == _ip##_IP)
+
+#define DWC3_VER_IS(_ip, _ver)						\
+	(DWC3_IP_IS(_ip) && dwc->revision == _ip##_REVISION_##_ver)
+
+#define DWC3_VER_IS_PRIOR(_ip, _ver)					\
+	(DWC3_IP_IS(_ip) && dwc->revision < _ip##_REVISION_##_ver)
+
+#define DWC3_VER_IS_WITHIN(_ip, _from, _to)				\
+	(DWC3_IP_IS(_ip) &&						\
+	 dwc->revision >= _ip##_REVISION_##_from &&			\
+	 (!(_ip##_REVISION_##_to) ||					\
+	  dwc->revision <= _ip##_REVISION_##_to))
+
+#define DWC3_VER_TYPE_IS_WITHIN(_ip, _ver, _from, _to)			\
+	(DWC3_VER_IS(_ip, _ver) &&					\
+	 dwc->version_type >= _ip##_VERSIONTYPE_##_from &&		\
+	 (!(_ip##_VERSIONTYPE_##_to) ||					\
+	  dwc->version_type <= _ip##_VERSIONTYPE_##_to))
+
+/**
+ * dwc3_mdwidth - get MDWIDTH value in bits
+ * @dwc: pointer to our context structure
+ *
+ * Return MDWIDTH configuration value in bits.
+ */
+static inline u32 dwc3_mdwidth(struct dwc3 *dwc)
+{
+	u32 mdwidth;
+
+	mdwidth = DWC3_GHWPARAMS0_MDWIDTH(dwc->hwparams.hwparams0);
+	if (DWC3_IP_IS(DWC32))
+		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
+
+	return mdwidth;
+}
+
+bool dwc3_has_imod(struct dwc3 *dwc);
+
+int dwc3_event_buffers_setup(struct dwc3 *dwc);
+void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
+
+int dwc3_core_soft_reset(struct dwc3 *dwc);
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
+
+#if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
+int dwc3_host_init(struct dwc3 *dwc);
+void dwc3_host_exit(struct dwc3 *dwc);
+#else
 static inline int dwc3_host_init(struct dwc3 *dwc)
 { return 0; }
 static inline void dwc3_host_exit(struct dwc3 *dwc)
 { }
+#endif
 
-#ifdef CONFIG_USB_DWC3_GADGET
+#if IS_ENABLED(CONFIG_USB_DWC3_GADGET) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_gadget_init(struct dwc3 *dwc);
 void dwc3_gadget_exit(struct dwc3 *dwc);
 int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode);
 int dwc3_gadget_get_link_state(struct dwc3 *dwc);
 int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state);
-int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
-		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params);
-int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param);
+int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
+		struct dwc3_gadget_ep_cmd_params *params);
+int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
+		u32 param);
+void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
@@ -1089,12 +1649,63 @@ static inline int dwc3_gadget_set_link_state(struct dwc3 *dwc,
 		enum dwc3_link_state state)
 { return 0; }
 
-static inline int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
-		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params)
+static inline int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
+		struct dwc3_gadget_ep_cmd_params *params)
 { return 0; }
 static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 		int cmd, u32 param)
 { return 0; }
+static inline void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
+{ }
+#endif
+
+#if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
+int dwc3_drd_init(struct dwc3 *dwc);
+void dwc3_drd_exit(struct dwc3 *dwc);
+void dwc3_otg_init(struct dwc3 *dwc);
+void dwc3_otg_exit(struct dwc3 *dwc);
+void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus);
+void dwc3_otg_host_init(struct dwc3 *dwc);
+#else
+static inline int dwc3_drd_init(struct dwc3 *dwc)
+{ return 0; }
+static inline void dwc3_drd_exit(struct dwc3 *dwc)
+{ }
+static inline void dwc3_otg_init(struct dwc3 *dwc)
+{ }
+static inline void dwc3_otg_exit(struct dwc3 *dwc)
+{ }
+static inline void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
+{ }
+static inline void dwc3_otg_host_init(struct dwc3 *dwc)
+{ }
+#endif
+
+/* power management interface */
+#if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
+int dwc3_gadget_suspend(struct dwc3 *dwc);
+int dwc3_gadget_resume(struct dwc3 *dwc);
+#else
+static inline int dwc3_gadget_suspend(struct dwc3 *dwc)
+{
+	return 0;
+}
+
+static inline int dwc3_gadget_resume(struct dwc3 *dwc)
+{
+	return 0;
+}
+
+#endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
+
+#if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
+int dwc3_ulpi_init(struct dwc3 *dwc);
+void dwc3_ulpi_exit(struct dwc3 *dwc);
+#else
+static inline int dwc3_ulpi_init(struct dwc3 *dwc)
+{ return 0; }
+static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
+{ }
 #endif
 
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
new file mode 100644
index 000000000000..09d703852a92
--- /dev/null
+++ b/drivers/usb/dwc3/debug.h
@@ -0,0 +1,432 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * debug.h - DesignWare USB3 DRD Controller Debug Header
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * Authors: Felipe Balbi <balbi@ti.com>,
+ *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ */
+
+#ifndef __DWC3_DEBUG_H
+#define __DWC3_DEBUG_H
+
+#include "core.h"
+
+/**
+ * dwc3_gadget_ep_cmd_string - returns endpoint command string
+ * @cmd: command code
+ */
+static inline const char *
+dwc3_gadget_ep_cmd_string(u8 cmd)
+{
+	switch (cmd) {
+	case DWC3_DEPCMD_DEPSTARTCFG:
+		return "Start New Configuration";
+	case DWC3_DEPCMD_ENDTRANSFER:
+		return "End Transfer";
+	case DWC3_DEPCMD_UPDATETRANSFER:
+		return "Update Transfer";
+	case DWC3_DEPCMD_STARTTRANSFER:
+		return "Start Transfer";
+	case DWC3_DEPCMD_CLEARSTALL:
+		return "Clear Stall";
+	case DWC3_DEPCMD_SETSTALL:
+		return "Set Stall";
+	case DWC3_DEPCMD_GETEPSTATE:
+		return "Get Endpoint State";
+	case DWC3_DEPCMD_SETTRANSFRESOURCE:
+		return "Set Endpoint Transfer Resource";
+	case DWC3_DEPCMD_SETEPCONFIG:
+		return "Set Endpoint Configuration";
+	default:
+		return "UNKNOWN command";
+	}
+}
+
+/**
+ * dwc3_gadget_generic_cmd_string - returns generic command string
+ * @cmd: command code
+ */
+static inline const char *
+dwc3_gadget_generic_cmd_string(u8 cmd)
+{
+	switch (cmd) {
+	case DWC3_DGCMD_SET_LMP:
+		return "Set LMP";
+	case DWC3_DGCMD_SET_PERIODIC_PAR:
+		return "Set Periodic Parameters";
+	case DWC3_DGCMD_XMIT_FUNCTION:
+		return "Transmit Function Wake Device Notification";
+	case DWC3_DGCMD_SET_SCRATCHPAD_ADDR_LO:
+		return "Set Scratchpad Buffer Array Address Lo";
+	case DWC3_DGCMD_SET_SCRATCHPAD_ADDR_HI:
+		return "Set Scratchpad Buffer Array Address Hi";
+	case DWC3_DGCMD_SELECTED_FIFO_FLUSH:
+		return "Selected FIFO Flush";
+	case DWC3_DGCMD_ALL_FIFO_FLUSH:
+		return "All FIFO Flush";
+	case DWC3_DGCMD_SET_ENDPOINT_NRDY:
+		return "Set Endpoint NRDY";
+	case DWC3_DGCMD_SET_ENDPOINT_PRIME:
+		return "Set Endpoint Prime";
+	case DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK:
+		return "Run SoC Bus Loopback Test";
+	case DWC3_DGCMD_DEV_NOTIFICATION:
+		return "Device Notification";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+/**
+ * dwc3_gadget_link_string - returns link name
+ * @link_state: link state code
+ */
+static inline const char *
+dwc3_gadget_link_string(enum dwc3_link_state link_state)
+{
+	switch (link_state) {
+	case DWC3_LINK_STATE_U0:
+		return "U0";
+	case DWC3_LINK_STATE_U1:
+		return "U1";
+	case DWC3_LINK_STATE_U2:
+		return "U2";
+	case DWC3_LINK_STATE_U3:
+		return "U3";
+	case DWC3_LINK_STATE_SS_DIS:
+		return "SS.Disabled";
+	case DWC3_LINK_STATE_RX_DET:
+		return "RX.Detect";
+	case DWC3_LINK_STATE_SS_INACT:
+		return "SS.Inactive";
+	case DWC3_LINK_STATE_POLL:
+		return "Polling";
+	case DWC3_LINK_STATE_RECOV:
+		return "Recovery";
+	case DWC3_LINK_STATE_HRESET:
+		return "Hot Reset";
+	case DWC3_LINK_STATE_CMPLY:
+		return "Compliance";
+	case DWC3_LINK_STATE_LPBK:
+		return "Loopback";
+	case DWC3_LINK_STATE_RESET:
+		return "Reset";
+	case DWC3_LINK_STATE_RESUME:
+		return "Resume";
+	default:
+		return "UNKNOWN link state";
+	}
+}
+
+/**
+ * dwc3_gadget_hs_link_string - returns highspeed and below link name
+ * @link_state: link state code
+ */
+static inline const char *
+dwc3_gadget_hs_link_string(enum dwc3_link_state link_state)
+{
+	switch (link_state) {
+	case DWC3_LINK_STATE_U0:
+		return "On";
+	case DWC3_LINK_STATE_U2:
+		return "Sleep";
+	case DWC3_LINK_STATE_U3:
+		return "Suspend";
+	case DWC3_LINK_STATE_SS_DIS:
+		return "Disconnected";
+	case DWC3_LINK_STATE_RX_DET:
+		return "Early Suspend";
+	case DWC3_LINK_STATE_RECOV:
+		return "Recovery";
+	case DWC3_LINK_STATE_RESET:
+		return "Reset";
+	case DWC3_LINK_STATE_RESUME:
+		return "Resume";
+	default:
+		return "UNKNOWN link state";
+	}
+}
+
+/**
+ * dwc3_trb_type_string - returns TRB type as a string
+ * @type: the type of the TRB
+ */
+static inline const char *dwc3_trb_type_string(unsigned int type)
+{
+	switch (type) {
+	case DWC3_TRBCTL_NORMAL:
+		return "normal";
+	case DWC3_TRBCTL_CONTROL_SETUP:
+		return "setup";
+	case DWC3_TRBCTL_CONTROL_STATUS2:
+		return "status2";
+	case DWC3_TRBCTL_CONTROL_STATUS3:
+		return "status3";
+	case DWC3_TRBCTL_CONTROL_DATA:
+		return "data";
+	case DWC3_TRBCTL_ISOCHRONOUS_FIRST:
+		return "isoc-first";
+	case DWC3_TRBCTL_ISOCHRONOUS:
+		return "isoc";
+	case DWC3_TRBCTL_LINK_TRB:
+		return "link";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static inline const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
+{
+	switch (state) {
+	case EP0_UNCONNECTED:
+		return "Unconnected";
+	case EP0_SETUP_PHASE:
+		return "Setup Phase";
+	case EP0_DATA_PHASE:
+		return "Data Phase";
+	case EP0_STATUS_PHASE:
+		return "Status Phase";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+/**
+ * dwc3_gadget_event_string - returns event name
+ * @event: the event code
+ */
+static inline const char *dwc3_gadget_event_string(char *str, size_t size,
+		const struct dwc3_event_devt *event)
+{
+	enum dwc3_link_state state = event->event_info & DWC3_LINK_STATE_MASK;
+
+	switch (event->type) {
+	case DWC3_DEVICE_EVENT_DISCONNECT:
+		snprintf(str, size, "Disconnect: [%s]",
+				dwc3_gadget_link_string(state));
+		break;
+	case DWC3_DEVICE_EVENT_RESET:
+		snprintf(str, size, "Reset [%s]",
+				dwc3_gadget_link_string(state));
+		break;
+	case DWC3_DEVICE_EVENT_CONNECT_DONE:
+		snprintf(str, size, "Connection Done [%s]",
+				dwc3_gadget_link_string(state));
+		break;
+	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
+		snprintf(str, size, "Link Change [%s]",
+				dwc3_gadget_link_string(state));
+		break;
+	case DWC3_DEVICE_EVENT_WAKEUP:
+		snprintf(str, size, "WakeUp [%s]",
+				dwc3_gadget_link_string(state));
+		break;
+	case DWC3_DEVICE_EVENT_SUSPEND:
+		snprintf(str, size, "Suspend [%s]",
+				dwc3_gadget_link_string(state));
+		break;
+	case DWC3_DEVICE_EVENT_SOF:
+		snprintf(str, size, "Start-Of-Frame [%s]",
+				dwc3_gadget_link_string(state));
+		break;
+	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
+		snprintf(str, size, "Erratic Error [%s]",
+				dwc3_gadget_link_string(state));
+		break;
+	case DWC3_DEVICE_EVENT_CMD_CMPL:
+		snprintf(str, size, "Command Complete [%s]",
+				dwc3_gadget_link_string(state));
+		break;
+	case DWC3_DEVICE_EVENT_OVERFLOW:
+		snprintf(str, size, "Overflow [%s]",
+				dwc3_gadget_link_string(state));
+		break;
+	default:
+		snprintf(str, size, "UNKNOWN");
+	}
+
+	return str;
+}
+
+/**
+ * dwc3_ep_event_string - returns event name
+ * @event: then event code
+ */
+static inline const char *dwc3_ep_event_string(char *str, size_t size,
+		const struct dwc3_event_depevt *event, u32 ep0state)
+{
+	u8 epnum = event->endpoint_number;
+	size_t len;
+	int status;
+
+	len = scnprintf(str, size, "ep%d%s: ", epnum >> 1,
+			(epnum & 1) ? "in" : "out");
+
+	status = event->status;
+
+	switch (event->endpoint_event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		len += scnprintf(str + len, size - len,
+				"Transfer Complete (%c%c%c)",
+				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
+				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
+				status & DEPEVT_STATUS_LST ? 'L' : 'l');
+
+		if (epnum <= 1)
+			scnprintf(str + len, size - len, " [%s]",
+					dwc3_ep0_state_string(ep0state));
+		break;
+	case DWC3_DEPEVT_XFERINPROGRESS:
+		scnprintf(str + len, size - len,
+				"Transfer In Progress [%08x] (%c%c%c)",
+				event->parameters,
+				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
+				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
+				status & DEPEVT_STATUS_LST ? 'M' : 'm');
+		break;
+	case DWC3_DEPEVT_XFERNOTREADY:
+		len += scnprintf(str + len, size - len,
+				"Transfer Not Ready [%08x]%s",
+				event->parameters,
+				status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
+				" (Active)" : " (Not Active)");
+
+		/* Control Endpoints */
+		if (epnum <= 1) {
+			int phase = DEPEVT_STATUS_CONTROL_PHASE(event->status);
+
+			switch (phase) {
+			case DEPEVT_STATUS_CONTROL_DATA:
+				scnprintf(str + len, size - len,
+						" [Data Phase]");
+				break;
+			case DEPEVT_STATUS_CONTROL_STATUS:
+				scnprintf(str + len, size - len,
+						" [Status Phase]");
+			}
+		}
+		break;
+	case DWC3_DEPEVT_RXTXFIFOEVT:
+		scnprintf(str + len, size - len, "FIFO");
+		break;
+	case DWC3_DEPEVT_STREAMEVT:
+		status = event->status;
+
+		switch (status) {
+		case DEPEVT_STREAMEVT_FOUND:
+			scnprintf(str + len, size - len, " Stream %d Found",
+					event->parameters);
+			break;
+		case DEPEVT_STREAMEVT_NOTFOUND:
+		default:
+			scnprintf(str + len, size - len, " Stream Not Found");
+			break;
+		}
+
+		break;
+	case DWC3_DEPEVT_EPCMDCMPLT:
+		scnprintf(str + len, size - len, "Endpoint Command Complete");
+		break;
+	default:
+		scnprintf(str + len, size - len, "UNKNOWN");
+	}
+
+	return str;
+}
+
+/**
+ * dwc3_gadget_event_type_string - return event name
+ * @event: the event code
+ */
+static inline const char *dwc3_gadget_event_type_string(u8 event)
+{
+	switch (event) {
+	case DWC3_DEVICE_EVENT_DISCONNECT:
+		return "Disconnect";
+	case DWC3_DEVICE_EVENT_RESET:
+		return "Reset";
+	case DWC3_DEVICE_EVENT_CONNECT_DONE:
+		return "Connect Done";
+	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
+		return "Link Status Change";
+	case DWC3_DEVICE_EVENT_WAKEUP:
+		return "Wake-Up";
+	case DWC3_DEVICE_EVENT_HIBER_REQ:
+		return "Hibernation";
+	case DWC3_DEVICE_EVENT_SUSPEND:
+		return "Suspend";
+	case DWC3_DEVICE_EVENT_SOF:
+		return "Start of Frame";
+	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
+		return "Erratic Error";
+	case DWC3_DEVICE_EVENT_CMD_CMPL:
+		return "Command Complete";
+	case DWC3_DEVICE_EVENT_OVERFLOW:
+		return "Overflow";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static inline const char *dwc3_decode_event(char *str, size_t size, u32 event,
+		u32 ep0state)
+{
+	union dwc3_event evt;
+
+	memcpy(&evt, &event, sizeof(event));
+
+	if (evt.type.is_devspec)
+		return dwc3_gadget_event_string(str, size, &evt.devt);
+	else
+		return dwc3_ep_event_string(str, size, &evt.depevt, ep0state);
+}
+
+static inline const char *dwc3_ep_cmd_status_string(int status)
+{
+	switch (status) {
+	case -ETIMEDOUT:
+		return "Timed Out";
+	case 0:
+		return "Successful";
+	case DEPEVT_TRANSFER_NO_RESOURCE:
+		return "No Resource";
+	case DEPEVT_TRANSFER_BUS_EXPIRY:
+		return "Bus Expiry";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static inline const char *dwc3_gadget_generic_cmd_status_string(int status)
+{
+	switch (status) {
+	case -ETIMEDOUT:
+		return "Timed Out";
+	case 0:
+		return "Successful";
+	case 1:
+		return "Error";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+
+#ifdef CONFIG_DEBUG_FS
+extern void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep);
+extern void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep);
+extern void dwc3_debugfs_init(struct dwc3 *d);
+extern void dwc3_debugfs_exit(struct dwc3 *d);
+#else
+static inline void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
+{  }
+static inline void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep)
+{  }
+static inline void dwc3_debugfs_init(struct dwc3 *d)
+{  }
+static inline void dwc3_debugfs_exit(struct dwc3 *d)
+{  }
+#endif
+#endif /* __DWC3_DEBUG_H */
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 99519602eb2c..9db8f3ca493d 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -1,23 +1,129 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * TI AM62 specific glue layer for DWC3
+ * dwc3-am62.c - TI specific Glue layer for AM62 DWC3 USB Controller
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com
  */
 
-#include <dm.h>
-#include <dm/device_compat.h>
-#include <regmap.h>
-#include <syscon.h>
-#include <asm/io.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/pinctrl/consumer.h>
 
-#include "dwc3-generic.h"
+#include "core.h"
 
-#define USBSS_MODE_CONTROL		0x1c
+/* USB WRAPPER register offsets */
+#define USBSS_PID			0x0
+#define USBSS_OVERCURRENT_CTRL		0x4
 #define USBSS_PHY_CONFIG		0x8
+#define USBSS_PHY_TEST			0xc
+#define USBSS_CORE_STAT			0x14
+#define USBSS_HOST_VBUS_CTRL		0x18
+#define USBSS_MODE_CONTROL		0x1c
+#define USBSS_WAKEUP_CONFIG		0x30
+#define USBSS_WAKEUP_STAT		0x34
+#define USBSS_OVERRIDE_CONFIG		0x38
+#define USBSS_IRQ_MISC_STATUS_RAW	0x430
+#define USBSS_IRQ_MISC_STATUS		0x434
+#define USBSS_IRQ_MISC_ENABLE_SET	0x438
+#define USBSS_IRQ_MISC_ENABLE_CLR	0x43c
+#define USBSS_IRQ_MISC_EOI		0x440
+#define USBSS_INTR_TEST			0x490
+#define USBSS_VBUS_FILTER		0x614
+#define USBSS_VBUS_STAT			0x618
+#define USBSS_DEBUG_CFG			0x708
+#define USBSS_DEBUG_DATA		0x70c
+#define USBSS_HOST_HUB_CTRL		0x714
+
+/* PHY CONFIG register bits */
 #define USBSS_PHY_VBUS_SEL_MASK		GENMASK(2, 1)
 #define USBSS_PHY_VBUS_SEL_SHIFT	1
+#define USBSS_PHY_LANE_REVERSE		BIT(0)
+
+/* CORE STAT register bits */
+#define USBSS_CORE_OPERATIONAL_MODE_MASK	GENMASK(13, 12)
+#define USBSS_CORE_OPERATIONAL_MODE_SHIFT	12
+
+/* MODE CONTROL register bits */
 #define USBSS_MODE_VALID	BIT(0)
+
+/* WAKEUP CONFIG register bits */
+#define USBSS_WAKEUP_CFG_OVERCURRENT_EN	BIT(3)
+#define USBSS_WAKEUP_CFG_LINESTATE_EN	BIT(2)
+#define USBSS_WAKEUP_CFG_SESSVALID_EN	BIT(1)
+#define USBSS_WAKEUP_CFG_VBUSVALID_EN	BIT(0)
+
+#define USBSS_WAKEUP_CFG_ALL	(USBSS_WAKEUP_CFG_VBUSVALID_EN | \
+				 USBSS_WAKEUP_CFG_SESSVALID_EN | \
+				 USBSS_WAKEUP_CFG_LINESTATE_EN | \
+				 USBSS_WAKEUP_CFG_OVERCURRENT_EN)
+
+#define USBSS_WAKEUP_CFG_NONE	0
+
+/* WAKEUP STAT register bits */
+#define USBSS_WAKEUP_STAT_OVERCURRENT	BIT(4)
+#define USBSS_WAKEUP_STAT_LINESTATE	BIT(3)
+#define USBSS_WAKEUP_STAT_SESSVALID	BIT(2)
+#define USBSS_WAKEUP_STAT_VBUSVALID	BIT(1)
+#define USBSS_WAKEUP_STAT_CLR		BIT(0)
+
+/* IRQ_MISC_STATUS_RAW register bits */
+#define USBSS_IRQ_MISC_RAW_VBUSVALID	BIT(22)
+#define USBSS_IRQ_MISC_RAW_SESSVALID	BIT(20)
+
+/* IRQ_MISC_STATUS register bits */
+#define USBSS_IRQ_MISC_VBUSVALID	BIT(22)
+#define USBSS_IRQ_MISC_SESSVALID	BIT(20)
+
+/* IRQ_MISC_ENABLE_SET register bits */
+#define USBSS_IRQ_MISC_ENABLE_SET_VBUSVALID	BIT(22)
+#define USBSS_IRQ_MISC_ENABLE_SET_SESSVALID	BIT(20)
+
+/* IRQ_MISC_ENABLE_CLR register bits */
+#define USBSS_IRQ_MISC_ENABLE_CLR_VBUSVALID	BIT(22)
+#define USBSS_IRQ_MISC_ENABLE_CLR_SESSVALID	BIT(20)
+
+/* IRQ_MISC_EOI register bits */
+#define USBSS_IRQ_MISC_EOI_VECTOR	BIT(0)
+
+/* VBUS_STAT register bits */
+#define USBSS_VBUS_STAT_SESSVALID	BIT(2)
+#define USBSS_VBUS_STAT_VBUSVALID	BIT(0)
+
+/* USB_PHY_CTRL register bits in CTRL_MMR */
+#define PHY_CORE_VOLTAGE_MASK	BIT(31)
 #define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
-static const int dwc3_ti_am62_rate_table[] = {	/* in KHZ */
+
+/* USB PHY2 register offsets */
+#define	USB_PHY_PLL_REG12		0x130
+#define	USB_PHY_PLL_LDO_REF_EN		BIT(5)
+#define	USB_PHY_PLL_LDO_REF_EN_EN	BIT(4)
+
+#define DWC3_AM62_AUTOSUSPEND_DELAY	100
+
+#define USBSS_DEBUG_CFG_OFF		0x0
+#define USBSS_DEBUG_CFG_DISABLED	0x7
+
+struct dwc3_am62 {
+	struct device *dev;
+	void __iomem *usbss;
+	struct clk *usb2_refclk;
+	int rate_code;
+	struct regmap *syscon;
+	unsigned int offset;
+	unsigned int vbus_divider;
+	u32 wakeup_stat;
+	void __iomem *phy_regs;
+};
+
+static const int dwc3_ti_rate_table[] = {	/* in KHZ */
 	9600,
 	10000,
 	12000,
@@ -33,93 +139,277 @@ static const int dwc3_ti_am62_rate_table[] = {	/* in KHZ */
 	52000,
 };
 
-static void dwc3_ti_am62_glue_configure(struct udevice *dev, int index,
-					enum usb_dr_mode mode)
+static inline u32 dwc3_ti_readl(struct dwc3_am62 *am62, u32 offset)
 {
-	struct clk usb2_refclk;
-	int rate_code, i, ret;
-	unsigned long rate;
-	u32 reg;
-	void *usbss;
-	bool vbus_divider;
+	return readl((am62->usbss) + offset);
+}
+
+static inline void dwc3_ti_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
+{
+	writel(value, (am62->usbss) + offset);
+}
+
+static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
+{
+	struct device *dev = am62->dev;
+	struct device_node *node = dev->of_node;
 	struct regmap *syscon;
-	struct ofnode_phandle_args args;
+	int ret;
 
-	usbss = dev_remap_addr_index(dev, 0);
-	if (IS_ERR(usbss)) {
-		dev_err(dev, "can't map IOMEM resource\n");
-		return;
-	}
-
-	ret = clk_get_by_name(dev, "ref", &usb2_refclk);
-	if (ret) {
-		dev_err(dev, "can't get usb2_refclk\n");
-		return;
-	}
-
-	/* Calculate the rate code */
-	rate = clk_get_rate(&usb2_refclk);
-	rate /= 1000;	/* To KHz */
-	for (i = 0; i < ARRAY_SIZE(dwc3_ti_am62_rate_table); i++) {
-		if (dwc3_ti_am62_rate_table[i] == rate)
-			break;
-	}
-
-	if (i == ARRAY_SIZE(dwc3_ti_am62_rate_table)) {
-		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
-		return;
-	}
-
-	rate_code = i;
-
-	/* Read the syscon property */
-	syscon = syscon_regmap_lookup_by_phandle(dev, "ti,syscon-phy-pll-refclk");
+	syscon = syscon_regmap_lookup_by_phandle_args(node, "ti,syscon-phy-pll-refclk",
+						      1, &am62->offset);
 	if (IS_ERR(syscon)) {
 		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
-		return;
+		return PTR_ERR(syscon);
 	}
 
-	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "ti,syscon-phy-pll-refclk", NULL, 1,
-					     0, &args);
-	if (ret)
-		return;
+	am62->syscon = syscon;
 
-	/* Program PHY PLL refclk by reading syscon property */
-	ret = regmap_update_bits(syscon, args.args[0], PHY_PLL_REFCLK_MASK, rate_code);
+	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
+	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_CORE_VOLTAGE_MASK, 0);
+	if (ret) {
+		dev_err(dev, "failed to set phy core voltage\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_PLL_REFCLK_MASK, am62->rate_code);
 	if (ret) {
 		dev_err(dev, "failed to set phy pll reference clock rate\n");
-		return;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dwc3_ti_init(struct dwc3_am62 *am62)
+{
+	int ret;
+	u32 reg;
+
+	/* Read the syscon property and set the rate code */
+	ret = phy_syscon_pll_refclk(am62);
+	if (ret)
+		return ret;
+
+	/* Workaround Errata i2409 */
+	if (am62->phy_regs) {
+		reg = readl(am62->phy_regs + USB_PHY_PLL_REG12);
+		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
+		writel(reg, am62->phy_regs + USB_PHY_PLL_REG12);
 	}
 
 	/* VBUS divider select */
-	reg = readl(usbss + USBSS_PHY_CONFIG);
-	vbus_divider = dev_read_bool(dev, "ti,vbus-divider");
-	if (vbus_divider)
+	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
+	if (am62->vbus_divider)
 		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
 
-	writel(reg, usbss + USBSS_PHY_CONFIG);
+	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
 
-	/* Set mode valid */
-	reg = readl(usbss + USBSS_MODE_CONTROL);
+	clk_prepare_enable(am62->usb2_refclk);
+
+	/* Set mode valid bit to indicate role is valid */
+	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
 	reg |= USBSS_MODE_VALID;
-	writel(reg, usbss + USBSS_MODE_CONTROL);
+	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
+
+	return 0;
 }
 
-struct dwc3_glue_ops ti_am62_ops = {
-	.glue_configure = dwc3_ti_am62_glue_configure,
-};
+static int dwc3_ti_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = pdev->dev.of_node;
+	struct dwc3_am62 *am62;
+	unsigned long rate;
+	int i, ret;
+
+	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
+	if (!am62)
+		return -ENOMEM;
+
+	am62->dev = dev;
+	platform_set_drvdata(pdev, am62);
+
+	am62->usbss = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(am62->usbss)) {
+		dev_err(dev, "can't map IOMEM resource\n");
+		return PTR_ERR(am62->usbss);
+	}
+
+	am62->usb2_refclk = devm_clk_get(dev, "ref");
+	if (IS_ERR(am62->usb2_refclk)) {
+		dev_err(dev, "can't get usb2_refclk\n");
+		return PTR_ERR(am62->usb2_refclk);
+	}
+
+	/* Calculate the rate code */
+	rate = clk_get_rate(am62->usb2_refclk);
+	rate /= 1000;	// To KHz
+	for (i = 0; i < ARRAY_SIZE(dwc3_ti_rate_table); i++) {
+		if (dwc3_ti_rate_table[i] == rate)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(dwc3_ti_rate_table)) {
+		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
+		return -EINVAL;
+	}
+
+	am62->rate_code = i;
+
+	am62->phy_regs = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(am62->phy_regs)) {
+		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
+		am62->phy_regs = NULL;
+	}
+
+	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
+
+	ret = dwc3_ti_init(am62);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	/*
+	 * Don't ignore its dependencies with its children
+	 */
+	pm_suspend_ignore_children(dev, false);
+	pm_runtime_get_noresume(dev);
+
+	ret = of_platform_populate(node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to create dwc3 core: %d\n", ret);
+		goto err_pm_disable;
+	}
+
+	/* Device has capability to wakeup system from sleep */
+	device_set_wakeup_capable(dev, true);
+	ret = device_wakeup_enable(dev);
+	if (ret)
+		dev_err(dev, "couldn't enable device as a wakeup source: %d\n", ret);
+
+	/* Setting up autosuspend */
+	pm_runtime_set_autosuspend_delay(dev, DWC3_AM62_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return 0;
+
+err_pm_disable:
+	clk_disable_unprepare(am62->usb2_refclk);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	return ret;
+}
+
+static void dwc3_ti_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
+	u32 reg;
+
+	pm_runtime_get_sync(dev);
+	device_init_wakeup(dev, false);
+	of_platform_depopulate(dev);
 
-static const struct udevice_id dwc3_am62_match[] = {
-	{ .compatible = "ti,am62-usb", .data = (ulong)&ti_am62_ops },
-	{ /* sentinel */ }
+	/* Clear mode valid bit */
+	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
+	reg &= ~USBSS_MODE_VALID;
+	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_set_suspended(dev);
+}
+
+#ifdef CONFIG_PM
+static int dwc3_ti_suspend_common(struct device *dev)
+{
+	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
+	u32 reg, current_prtcap_dir;
+
+	if (device_may_wakeup(dev)) {
+		reg = dwc3_ti_readl(am62, USBSS_CORE_STAT);
+		current_prtcap_dir = (reg & USBSS_CORE_OPERATIONAL_MODE_MASK)
+				     >> USBSS_CORE_OPERATIONAL_MODE_SHIFT;
+		/* Set wakeup config enable bits */
+		reg = dwc3_ti_readl(am62, USBSS_WAKEUP_CONFIG);
+		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
+			reg = USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
+		} else {
+			reg = USBSS_WAKEUP_CFG_VBUSVALID_EN | USBSS_WAKEUP_CFG_SESSVALID_EN;
+			/*
+			 * Enable LINESTATE wake up only if connected to bus
+			 * and in U2/L3 state else it causes spurious wake-up.
+			 */
+		}
+		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, reg);
+		/* clear wakeup status so we know what caused the wake up */
+		dwc3_ti_writel(am62, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
+	}
+
+	/* just to track if module resets on suspend */
+	dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_DISABLED);
+
+	clk_disable_unprepare(am62->usb2_refclk);
+
+	return 0;
+}
+
+static int dwc3_ti_resume_common(struct device *dev)
+{
+	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = dwc3_ti_readl(am62, USBSS_DEBUG_CFG);
+	if (reg != USBSS_DEBUG_CFG_DISABLED) {
+		/* lost power/context */
+		dwc3_ti_init(am62);
+	} else {
+		dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_OFF);
+		clk_prepare_enable(am62->usb2_refclk);
+	}
+
+	if (device_may_wakeup(dev)) {
+		/* Clear wakeup config enable bits */
+		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
+	}
+
+	reg = dwc3_ti_readl(am62, USBSS_WAKEUP_STAT);
+	am62->wakeup_stat = reg;
+
+	return 0;
+}
+
+static UNIVERSAL_DEV_PM_OPS(dwc3_ti_pm_ops, dwc3_ti_suspend_common,
+			    dwc3_ti_resume_common, NULL);
+
+#define DEV_PM_OPS	(&dwc3_ti_pm_ops)
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM */
+
+static const struct of_device_id dwc3_ti_of_match[] = {
+	{ .compatible = "ti,am62-usb"},
+	{},
 };
+MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
 
-U_BOOT_DRIVER(dwc3_am62_wrapper) = {
-	.name	= "dwc3-am62",
-	.id	= UCLASS_SIMPLE_BUS,
-	.of_match = dwc3_am62_match,
-	.bind = dwc3_glue_bind,
-	.probe = dwc3_glue_probe,
-	.remove = dwc3_glue_remove,
-	.plat_auto	= sizeof(struct dwc3_glue_data),
+static struct platform_driver dwc3_ti_driver = {
+	.probe		= dwc3_ti_probe,
+	.remove		= dwc3_ti_remove,
+	.driver		= {
+		.name	= "dwc3-am62",
+		.pm	= DEV_PM_OPS,
+		.of_match_table = dwc3_ti_of_match,
+	},
 };
+
+module_platform_driver(dwc3_ti_driver);
+
+MODULE_ALIAS("platform:dwc3-am62");
+MODULE_AUTHOR("Aswath Govindraju <a-govindraju@ti.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DesignWare USB3 TI Glue Layer");
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 680756532f0d..666ac432f52d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1,73 +1,49 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * ep0.c - DesignWare USB3 DRD Controller Endpoint 0 Handling
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/ep0.c) and ported
- * to uboot.
- *
- * commit c00552ebaf : Merge 3.18-rc7 into usb-next
  */
-#include <cpu_func.h>
-#include <dm.h>
-#include <dm/device_compat.h>
-#include <linux/bug.h>
+
 #include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/list.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
 
 #include "core.h"
+#include "debug.h"
 #include "gadget.h"
 #include "io.h"
 
-#include "linux-compat.h"
-
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep);
 static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		struct dwc3_ep *dep, struct dwc3_request *req);
+static int dwc3_ep0_delegate_req(struct dwc3 *dwc,
+				 struct usb_ctrlrequest *ctrl);
 
-static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
+static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
+		dma_addr_t buf_dma, u32 len, u32 type, bool chain)
 {
-	switch (state) {
-	case EP0_UNCONNECTED:
-		return "Unconnected";
-	case EP0_SETUP_PHASE:
-		return "Setup Phase";
-	case EP0_DATA_PHASE:
-		return "Data Phase";
-	case EP0_STATUS_PHASE:
-		return "Status Phase";
-	default:
-		return "UNKNOWN";
-	}
-}
-
-static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
-				u32 len, u32 type, unsigned chain)
-{
-	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_trb			*trb;
-	struct dwc3_ep			*dep;
+	struct dwc3			*dwc;
 
-	int				ret;
-
-	dep = dwc->eps[epnum];
-	if (dep->flags & DWC3_EP_BUSY) {
-		dev_vdbg(dwc->dev, "%s still busy\n", dep->name);
-		return 0;
-	}
-
-	trb = &dwc->ep0_trb[dep->free_slot];
+	dwc = dep->dwc;
+	trb = &dwc->ep0_trb[dep->trb_enqueue];
 
 	if (chain)
-		dep->free_slot++;
+		dep->trb_enqueue++;
 
 	trb->bpl = lower_32_bits(buf_dma);
 	trb->bph = upper_32_bits(buf_dma);
@@ -83,26 +59,27 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 		trb->ctrl |= (DWC3_TRB_CTRL_IOC
 				| DWC3_TRB_CTRL_LST);
 
-	dwc3_flush_cache((uintptr_t)buf_dma, len);
-	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
+	trace_dwc3_prepare_trb(dep, trb);
+}
 
-	if (chain)
+static int dwc3_ep0_start_trans(struct dwc3_ep *dep)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3			*dwc;
+	int				ret;
+
+	if (dep->flags & DWC3_EP_TRANSFER_STARTED)
 		return 0;
 
+	dwc = dep->dwc;
+
 	memset(&params, 0, sizeof(params));
 	params.param0 = upper_32_bits(dwc->ep0_trb_addr);
 	params.param1 = lower_32_bits(dwc->ep0_trb_addr);
 
-	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number,
-			DWC3_DEPCMD_STARTTRANSFER, &params);
-	if (ret < 0) {
-		dev_dbg(dwc->dev, "%s STARTTRANSFER failed", dep->name);
+	ret = dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_STARTTRANSFER, &params);
+	if (ret < 0)
 		return ret;
-	}
-
-	dep->flags |= DWC3_EP_BUSY;
-	dep->resource_index = dwc3_gadget_ep_get_transfer_index(dwc,
-			dep->number);
 
 	dwc->ep0_next_event = DWC3_EP0_COMPLETE;
 
@@ -118,7 +95,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	req->request.status	= -EINPROGRESS;
 	req->epnum		= dep->number;
 
-	list_add_tail(&req->list, &dep->request_list);
+	list_add_tail(&req->list, &dep->pending_list);
 
 	/*
 	 * Gadget driver might not be quick enough to queue a request
@@ -130,7 +107,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * IRQ we were waiting for is long gone.
 	 */
 	if (dep->flags & DWC3_EP_PENDING_REQUEST) {
-		unsigned	direction;
+		unsigned int direction;
 
 		direction = !!(dep->flags & DWC3_EP0_DIR_IN);
 
@@ -152,16 +129,14 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * handle it here.
 	 */
 	if (dwc->delayed_status) {
-		unsigned	direction;
+		unsigned int direction;
 
 		direction = !dwc->ep0_expect_in;
 		dwc->delayed_status = false;
-		usb_gadget_set_state(&dwc->gadget, USB_STATE_CONFIGURED);
+		usb_gadget_set_state(dwc->gadget, USB_STATE_CONFIGURED);
 
 		if (dwc->ep0state == EP0_STATUS_PHASE)
 			__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
-		else
-			dev_dbg(dwc->dev, "too early for delayed status");
 
 		return 0;
 	}
@@ -170,7 +145,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * Unfortunately we have uncovered a limitation wrt the Data Phase.
 	 *
 	 * Section 9.4 says we can wait for the XferNotReady(DATA) event to
-	 * come before issueing Start Transfer command, but if we do, we will
+	 * come before issuing Start Transfer command, but if we do, we will
 	 * miss situations where the host starts another SETUP phase instead of
 	 * the DATA phase.  Such cases happen at least on TD.7.6 of the Link
 	 * Layer Compliance Suite.
@@ -199,7 +174,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * XferNotReady(STATUS).
 	 */
 	if (dwc->three_stage_setup) {
-		unsigned        direction;
+		unsigned int direction;
 
 		direction = dwc->ep0_expect_in;
 		dwc->ep0state = EP0_DATA_PHASE;
@@ -224,23 +199,19 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dep->endpoint.desc) {
-		dev_dbg(dwc->dev, "trying to queue request %p to disabled %s",
-				request, dep->name);
+	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
+		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
+				dep->name);
 		ret = -ESHUTDOWN;
 		goto out;
 	}
 
 	/* we share one TRB for ep0/1 */
-	if (!list_empty(&dep->request_list)) {
+	if (!list_empty(&dep->pending_list)) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	dev_vdbg(dwc->dev, "queueing request %p to %s length %d state '%s\n'",
-		 request, dep->name, request->length,
-		 dwc3_ep0_state_string(dwc->ep0state));
-
 	ret = __dwc3_gadget_ep0_queue(dep, req);
 
 out:
@@ -249,27 +220,34 @@ out:
 	return ret;
 }
 
-static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
+void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 {
 	struct dwc3_ep		*dep;
 
 	/* reinitialize physical ep1 */
 	dep = dwc->eps[1];
-	dep->flags = DWC3_EP_ENABLED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags |= DWC3_EP_ENABLED;
 
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags = DWC3_EP_ENABLED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED | DWC3_EP_TRANSFER_STARTED;
+	dep->flags |= DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 
-	if (!list_empty(&dep->request_list)) {
+	if (!list_empty(&dep->pending_list)) {
 		struct dwc3_request	*req;
 
-		req = next_request(&dep->request_list);
-		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+		req = next_request(&dep->pending_list);
+		if (!dwc->connected)
+			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		else
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
 	}
 
+	dwc->eps[0]->trb_enqueue = 0;
+	dwc->eps[1]->trb_enqueue = 0;
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc3_ep0_out_start(dwc);
 }
@@ -286,6 +264,8 @@ int __dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 
 int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 {
+	struct dwc3_ep			*dep = to_dwc3_ep(ep);
+	struct dwc3			*dwc = dep->dwc;
 	unsigned long			flags;
 	int				ret;
 
@@ -298,11 +278,33 @@ int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 
 void dwc3_ep0_out_start(struct dwc3 *dwc)
 {
+	struct dwc3_ep			*dep;
 	int				ret;
+	int                             i;
 
-	ret = dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8,
-				   DWC3_TRBCTL_CONTROL_SETUP, 0);
+	complete(&dwc->ep0_in_setup);
+
+	dep = dwc->eps[0];
+	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
+			DWC3_TRBCTL_CONTROL_SETUP, false);
+	ret = dwc3_ep0_start_trans(dep);
 	WARN_ON(ret < 0);
+	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
+		struct dwc3_ep *dwc3_ep;
+
+		dwc3_ep = dwc->eps[i];
+		if (!dwc3_ep)
+			continue;
+
+		if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
+			continue;
+
+		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
+		if (dwc->connected)
+			dwc3_stop_active_transfer(dwc3_ep, true, true);
+		else
+			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
+	}
 }
 
 static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
@@ -316,6 +318,9 @@ static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
 		epnum |= 1;
 
 	dep = dwc->eps[epnum];
+	if (dep == NULL)
+		return NULL;
+
 	if (dep->flags & DWC3_EP_ENABLED)
 		return dep;
 
@@ -333,24 +338,34 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 {
 	struct dwc3_ep		*dep;
 	u32			recip;
+	u32			value;
 	u32			reg;
 	u16			usb_status = 0;
 	__le16			*response_pkt;
 
+	/* We don't support PTM_STATUS */
+	value = le16_to_cpu(ctrl->wValue);
+	if (value != 0)
+		return -EINVAL;
+
 	recip = ctrl->bRequestType & USB_RECIP_MASK;
 	switch (recip) {
 	case USB_RECIP_DEVICE:
 		/*
 		 * LTM will be set once we know how to set this in HW.
 		 */
-		usb_status |= dwc->is_selfpowered << USB_DEVICE_SELF_POWERED;
+		usb_status |= dwc->gadget->is_selfpowered;
 
-		if (dwc->speed == DWC3_DSTS_SUPERSPEED) {
+		if ((dwc->speed == DWC3_DSTS_SUPERSPEED) ||
+		    (dwc->speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 			if (reg & DWC3_DCTL_INITU1ENA)
 				usb_status |= 1 << USB_DEV_STAT_U1_ENABLED;
 			if (reg & DWC3_DCTL_INITU2ENA)
 				usb_status |= 1 << USB_DEV_STAT_U2_ENABLED;
+		} else {
+			usb_status |= dwc->gadget->wakeup_armed <<
+					USB_DEVICE_REMOTE_WAKEUP;
 		}
 
 		break;
@@ -360,7 +375,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		 * Function Remote Wake Capable	D0
 		 * Function Remote Wakeup	D1
 		 */
-		break;
+		return dwc3_ep0_delegate_req(dwc, ctrl);
 
 	case USB_RECIP_ENDPOINT:
 		dep = dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
@@ -380,136 +395,217 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 	dep = dwc->eps[0];
 	dwc->ep0_usb_req.dep = dep;
 	dwc->ep0_usb_req.request.length = sizeof(*response_pkt);
-	dwc->ep0_usb_req.request.buf = (void *)(uintptr_t)dwc->setup_buf_addr;
+	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
 	dwc->ep0_usb_req.request.complete = dwc3_ep0_status_cmpl;
 
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
 }
 
-static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
+static int dwc3_ep0_handle_u1(struct dwc3 *dwc, enum usb_device_state state,
+		int set)
+{
+	u32 reg;
+
+	if (state != USB_STATE_CONFIGURED)
+		return -EINVAL;
+	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
+			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
+		return -EINVAL;
+	if (set && dwc->dis_u1_entry_quirk)
+		return -EINVAL;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	if (set)
+		reg |= DWC3_DCTL_INITU1ENA;
+	else
+		reg &= ~DWC3_DCTL_INITU1ENA;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
+	return 0;
+}
+
+static int dwc3_ep0_handle_u2(struct dwc3 *dwc, enum usb_device_state state,
+		int set)
+{
+	u32 reg;
+
+
+	if (state != USB_STATE_CONFIGURED)
+		return -EINVAL;
+	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
+			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
+		return -EINVAL;
+	if (set && dwc->dis_u2_entry_quirk)
+		return -EINVAL;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	if (set)
+		reg |= DWC3_DCTL_INITU2ENA;
+	else
+		reg &= ~DWC3_DCTL_INITU2ENA;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
+	return 0;
+}
+
+static int dwc3_ep0_handle_test(struct dwc3 *dwc, enum usb_device_state state,
+		u32 wIndex, int set)
+{
+	if ((wIndex & 0xff) != 0)
+		return -EINVAL;
+	if (!set)
+		return -EINVAL;
+
+	switch (wIndex >> 8) {
+	case USB_TEST_J:
+	case USB_TEST_K:
+	case USB_TEST_SE0_NAK:
+	case USB_TEST_PACKET:
+	case USB_TEST_FORCE_ENABLE:
+		dwc->test_mode_nr = wIndex >> 8;
+		dwc->test_mode = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 		struct usb_ctrlrequest *ctrl, int set)
 {
-	struct dwc3_ep		*dep;
-	u32			recip;
-	u32			wValue;
-	u32			wIndex;
-	u32			reg;
-	int			ret;
 	enum usb_device_state	state;
+	u32			wValue;
+	u32			wIndex;
+	int			ret = 0;
 
 	wValue = le16_to_cpu(ctrl->wValue);
 	wIndex = le16_to_cpu(ctrl->wIndex);
+	state = dwc->gadget->state;
+
+	switch (wValue) {
+	case USB_DEVICE_REMOTE_WAKEUP:
+		if (dwc->wakeup_configured)
+			dwc->gadget->wakeup_armed = set;
+		else
+			ret = -EINVAL;
+		break;
+	/*
+	 * 9.4.1 says only for SS, in AddressState only for
+	 * default control pipe
+	 */
+	case USB_DEVICE_U1_ENABLE:
+		ret = dwc3_ep0_handle_u1(dwc, state, set);
+		break;
+	case USB_DEVICE_U2_ENABLE:
+		ret = dwc3_ep0_handle_u2(dwc, state, set);
+		break;
+	case USB_DEVICE_LTM_ENABLE:
+		ret = -EINVAL;
+		break;
+	case USB_DEVICE_TEST_MODE:
+		ret = dwc3_ep0_handle_test(dwc, state, wIndex, set);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int dwc3_ep0_handle_intf(struct dwc3 *dwc,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	u32			wValue;
+	int			ret = 0;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+
+	switch (wValue) {
+	case USB_INTRF_FUNC_SUSPEND:
+		ret = dwc3_ep0_delegate_req(dwc, ctrl);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int dwc3_ep0_handle_endpoint(struct dwc3 *dwc,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	struct dwc3_ep		*dep;
+	u32			wValue;
+	int			ret;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+
+	switch (wValue) {
+	case USB_ENDPOINT_HALT:
+		dep = dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
+		if (!dep)
+			return -EINVAL;
+
+		if (set == 0 && (dep->flags & DWC3_EP_WEDGE))
+			break;
+
+		ret = __dwc3_gadget_ep_set_halt(dep, set, true);
+		if (ret)
+			return -EINVAL;
+
+		/* ClearFeature(Halt) may need delayed status */
+		if (!set && (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
+			return USB_GADGET_DELAYED_STATUS;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	u32			recip;
+	int			ret;
+
 	recip = ctrl->bRequestType & USB_RECIP_MASK;
-	state = dwc->gadget.state;
 
 	switch (recip) {
 	case USB_RECIP_DEVICE:
-
-		switch (wValue) {
-		case USB_DEVICE_REMOTE_WAKEUP:
-			break;
-		/*
-		 * 9.4.1 says only only for SS, in AddressState only for
-		 * default control pipe
-		 */
-		case USB_DEVICE_U1_ENABLE:
-			if (state != USB_STATE_CONFIGURED)
-				return -EINVAL;
-			if (dwc->speed != DWC3_DSTS_SUPERSPEED)
-				return -EINVAL;
-
-			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-			if (set)
-				reg |= DWC3_DCTL_INITU1ENA;
-			else
-				reg &= ~DWC3_DCTL_INITU1ENA;
-			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
-			break;
-
-		case USB_DEVICE_U2_ENABLE:
-			if (state != USB_STATE_CONFIGURED)
-				return -EINVAL;
-			if (dwc->speed != DWC3_DSTS_SUPERSPEED)
-				return -EINVAL;
-
-			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-			if (set)
-				reg |= DWC3_DCTL_INITU2ENA;
-			else
-				reg &= ~DWC3_DCTL_INITU2ENA;
-			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
-			break;
-
-		case USB_DEVICE_LTM_ENABLE:
-			return -EINVAL;
-
-		case USB_DEVICE_TEST_MODE:
-			if ((wIndex & 0xff) != 0)
-				return -EINVAL;
-			if (!set)
-				return -EINVAL;
-
-			dwc->test_mode_nr = wIndex >> 8;
-			dwc->test_mode = true;
-			break;
-		default:
-			return -EINVAL;
-		}
+		ret = dwc3_ep0_handle_device(dwc, ctrl, set);
 		break;
-
 	case USB_RECIP_INTERFACE:
-		switch (wValue) {
-		case USB_INTRF_FUNC_SUSPEND:
-			if (wIndex & USB_INTRF_FUNC_SUSPEND_LP)
-				/* XXX enable Low power suspend */
-				;
-			if (wIndex & USB_INTRF_FUNC_SUSPEND_RW)
-				/* XXX enable remote wakeup */
-				;
-			break;
-		default:
-			return -EINVAL;
-		}
+		ret = dwc3_ep0_handle_intf(dwc, ctrl, set);
 		break;
-
 	case USB_RECIP_ENDPOINT:
-		switch (wValue) {
-		case USB_ENDPOINT_HALT:
-			dep = dwc3_wIndex_to_dep(dwc, wIndex);
-			if (!dep)
-				return -EINVAL;
-			if (set == 0 && (dep->flags & DWC3_EP_WEDGE))
-				break;
-			ret = __dwc3_gadget_ep_set_halt(dep, set, true);
-			if (ret)
-				return -EINVAL;
-			break;
-		default:
-			return -EINVAL;
-		}
+		ret = dwc3_ep0_handle_endpoint(dwc, ctrl, set);
 		break;
-
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	enum usb_device_state state = dwc->gadget.state;
+	enum usb_device_state state = dwc->gadget->state;
 	u32 addr;
 	u32 reg;
 
 	addr = le16_to_cpu(ctrl->wValue);
 	if (addr > 127) {
-		dev_dbg(dwc->dev, "invalid device address %d", addr);
+		dev_err(dwc->dev, "invalid device address %d\n", addr);
 		return -EINVAL;
 	}
 
 	if (state == USB_STATE_CONFIGURED) {
-		dev_dbg(dwc->dev, "trying to set address when configured");
+		dev_err(dwc->dev, "can't SetAddress() from Configured State\n");
 		return -EINVAL;
 	}
 
@@ -519,31 +615,32 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
 	if (addr)
-		usb_gadget_set_state(&dwc->gadget, USB_STATE_ADDRESS);
+		usb_gadget_set_state(dwc->gadget, USB_STATE_ADDRESS);
 	else
-		usb_gadget_set_state(&dwc->gadget, USB_STATE_DEFAULT);
+		usb_gadget_set_state(dwc->gadget, USB_STATE_DEFAULT);
 
 	return 0;
 }
 
 static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	int ret;
+	int ret = -EINVAL;
 
-	spin_unlock(&dwc->lock);
-	ret = dwc->gadget_driver->setup(&dwc->gadget, ctrl);
-	spin_lock(&dwc->lock);
+	if (dwc->async_callbacks) {
+		spin_unlock(&dwc->lock);
+		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
+		spin_lock(&dwc->lock);
+	}
 	return ret;
 }
 
 static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	enum usb_device_state state = dwc->gadget.state;
+	enum usb_device_state state = dwc->gadget->state;
 	u32 cfg;
 	int ret;
 	u32 reg;
 
-	dwc->start_config_issued = false;
 	cfg = le16_to_cpu(ctrl->wValue);
 
 	switch (state) {
@@ -551,6 +648,9 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 		return -EINVAL;
 
 	case USB_STATE_ADDRESS:
+		dwc3_gadget_start_config(dwc, 2);
+		dwc3_gadget_clear_tx_fifos(dwc);
+
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		/* if the cfg matches and the cfg is non zero */
 		if (cfg && (!ret || (ret == USB_GADGET_DELAYED_STATUS))) {
@@ -562,7 +662,7 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			 * to change the state on the next usb_ep_queue()
 			 */
 			if (ret == 0)
-				usb_gadget_set_state(&dwc->gadget,
+				usb_gadget_set_state(dwc->gadget,
 						USB_STATE_CONFIGURED);
 
 			/*
@@ -570,18 +670,18 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			 * nothing is pending from application.
 			 */
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-			reg |= (DWC3_DCTL_ACCEPTU1ENA | DWC3_DCTL_ACCEPTU2ENA);
+			if (!dwc->dis_u1_entry_quirk)
+				reg |= DWC3_DCTL_ACCEPTU1ENA;
+			if (!dwc->dis_u2_entry_quirk)
+				reg |= DWC3_DCTL_ACCEPTU2ENA;
 			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
-
-			dwc->resize_fifos = true;
-			dev_dbg(dwc->dev, "resize FIFOs flag SET");
 		}
 		break;
 
 	case USB_STATE_CONFIGURED:
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		if (!cfg && !ret)
-			usb_gadget_set_state(&dwc->gadget,
+			usb_gadget_set_state(dwc->gadget,
 					USB_STATE_ADDRESS);
 		break;
 	default:
@@ -601,8 +701,8 @@ static void dwc3_ep0_set_sel_cmpl(struct usb_ep *ep, struct usb_request *req)
 	struct timing {
 		u8	u1sel;
 		u8	u1pel;
-		u16	u2sel;
-		u16	u2pel;
+		__le16	u2sel;
+		__le16	u2pel;
 	} __packed timing;
 
 	int		ret;
@@ -637,7 +737,7 @@ static void dwc3_ep0_set_sel_cmpl(struct usb_ep *ep, struct usb_request *req)
 static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
 	struct dwc3_ep	*dep;
-	enum usb_device_state state = dwc->gadget.state;
+	enum usb_device_state state = dwc->gadget->state;
 	u16		wLength;
 
 	if (state == USB_STATE_DEFAULT)
@@ -662,7 +762,7 @@ static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	dep = dwc->eps[0];
 	dwc->ep0_usb_req.dep = dep;
 	dwc->ep0_usb_req.request.length = dep->endpoint.maxpacket;
-	dwc->ep0_usb_req.request.buf = (void *)(uintptr_t)dwc->setup_buf_addr;
+	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
 	dwc->ep0_usb_req.request.complete = dwc3_ep0_set_sel_cmpl;
 
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
@@ -681,11 +781,7 @@ static int dwc3_ep0_set_isoch_delay(struct dwc3 *dwc, struct usb_ctrlrequest *ct
 	if (wIndex || wLength)
 		return -EINVAL;
 
-	/*
-	 * REVISIT It's unclear from Databook what to do with this
-	 * value. For now, just cache it.
-	 */
-	dwc->isoch_delay = wValue;
+	dwc->gadget->isoch_delay = wValue;
 
 	return 0;
 }
@@ -696,35 +792,27 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 	switch (ctrl->bRequest) {
 	case USB_REQ_GET_STATUS:
-		dev_vdbg(dwc->dev, "USB_REQ_GET_STATUS\n");
 		ret = dwc3_ep0_handle_status(dwc, ctrl);
 		break;
 	case USB_REQ_CLEAR_FEATURE:
-		dev_vdbg(dwc->dev, "USB_REQ_CLEAR_FEATURE\n");
 		ret = dwc3_ep0_handle_feature(dwc, ctrl, 0);
 		break;
 	case USB_REQ_SET_FEATURE:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_FEATURE\n");
 		ret = dwc3_ep0_handle_feature(dwc, ctrl, 1);
 		break;
 	case USB_REQ_SET_ADDRESS:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_ADDRESS\n");
 		ret = dwc3_ep0_set_address(dwc, ctrl);
 		break;
 	case USB_REQ_SET_CONFIGURATION:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_CONFIGURATION\n");
 		ret = dwc3_ep0_set_config(dwc, ctrl);
 		break;
 	case USB_REQ_SET_SEL:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_SEL\n");
 		ret = dwc3_ep0_set_sel(dwc, ctrl);
 		break;
 	case USB_REQ_SET_ISOCH_DELAY:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_ISOCH_DELAY\n");
 		ret = dwc3_ep0_set_isoch_delay(dwc, ctrl);
 		break;
 	default:
-		dev_vdbg(dwc->dev, "Forwarding to gadget driver\n");
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		break;
 	}
@@ -735,14 +823,14 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	struct usb_ctrlrequest *ctrl = dwc->ctrl_req;
+	struct usb_ctrlrequest *ctrl = (void *) dwc->ep0_trb;
 	int ret = -EINVAL;
 	u32 len;
 
-	if (!dwc->gadget_driver)
+	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
 		goto out;
 
-	dwc3_invalidate_cache((uintptr_t)ctrl, sizeof(*ctrl));
+	trace_dwc3_ctrl_req(ctrl);
 
 	len = le16_to_cpu(ctrl->wLength);
 	if (!len) {
@@ -771,13 +859,10 @@ out:
 static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	struct dwc3_request	*r = NULL;
+	struct dwc3_request	*r;
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	unsigned		transfer_size = 0;
-	unsigned		maxp;
-	void			*buf;
 	u32			transferred = 0;
 	u32			status;
 	u32			length;
@@ -787,78 +872,46 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	ep0 = dwc->eps[0];
 
 	dwc->ep0_next_event = DWC3_EP0_NRDY_STATUS;
-
 	trb = dwc->ep0_trb;
+	trace_dwc3_complete_trb(ep0, trb);
 
-	r = next_request(&ep0->request_list);
+	r = next_request(&ep0->pending_list);
 	if (!r)
 		return;
 
-	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
-
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 	if (status == DWC3_TRBSTS_SETUP_PENDING) {
-		dev_dbg(dwc->dev, "Setup Pending received");
-		dwc3_gadget_giveback(ep0, r, -ECONNRESET);
+		dwc->setup_packet_pending = true;
+		if (r)
+			dwc3_gadget_giveback(ep0, r, -ECONNRESET);
+
 		return;
 	}
 
 	ur = &r->request;
-	buf = ur->buf;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
-
-	maxp = ep0->endpoint.maxpacket;
-
-	if (dwc->ep0_bounced) {
-		/*
-		 * Handle the first TRB before handling the bounce buffer if
-		 * the request length is greater than the bounce buffer size.
-		 */
-		if (ur->length > DWC3_EP0_BOUNCE_SIZE) {
-			transfer_size = (ur->length / maxp) * maxp;
-			transferred = transfer_size - length;
-			buf = (u8 *)buf + transferred;
-			ur->actual += transferred;
-
-			trb++;
-			dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
-			length = trb->size & DWC3_TRB_SIZE_MASK;
-
-			ep0->free_slot = 0;
-		}
-
-		transfer_size = roundup((ur->length - transfer_size),
-					maxp);
-		transferred = min_t(u32, ur->length - transferred,
-				    transfer_size - length);
-		dwc3_flush_cache((uintptr_t)dwc->ep0_bounce, DWC3_EP0_BOUNCE_SIZE);
-		memcpy(buf, dwc->ep0_bounce, transferred);
-	} else {
-		transferred = ur->length - length;
-	}
-
+	transferred = ur->length - length;
 	ur->actual += transferred;
 
-	if ((epnum & 1) && ur->actual < ur->length) {
-		/* for some reason we did not get everything out */
+	if ((IS_ALIGNED(ur->length, ep0->endpoint.maxpacket) &&
+	     ur->length && ur->zero) || dwc->ep0_bounced) {
+		trb++;
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+		trace_dwc3_complete_trb(ep0, trb);
 
+		if (r->direction)
+			dwc->eps[1]->trb_enqueue = 0;
+		else
+			dwc->eps[0]->trb_enqueue = 0;
+
+		dwc->ep0_bounced = false;
+	}
+
+	if ((epnum & 1) && ur->actual < ur->length)
 		dwc3_ep0_stall_and_restart(dwc);
-	} else {
+	else
 		dwc3_gadget_giveback(ep0, r, 0);
-
-		if (IS_ALIGNED(ur->length, ep0->endpoint.maxpacket) &&
-				ur->length && ur->zero) {
-			int ret;
-
-			dwc->ep0_next_event = DWC3_EP0_COMPLETE;
-
-			ret = dwc3_ep0_start_trans(dwc, epnum,
-					dwc->ctrl_req_addr, 0,
-					DWC3_TRBCTL_CONTROL_DATA, 0);
-			WARN_ON(ret < 0);
-		}
-	}
 }
 
 static void dwc3_ep0_complete_status(struct dwc3 *dwc,
@@ -872,8 +925,10 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 	dep = dwc->eps[0];
 	trb = dwc->ep0_trb;
 
-	if (!list_empty(&dep->request_list)) {
-		r = next_request(&dep->request_list);
+	trace_dwc3_complete_trb(dep, trb);
+
+	if (!list_empty(&dep->pending_list)) {
+		r = next_request(&dep->pending_list);
 
 		dwc3_gadget_giveback(dep, r, 0);
 	}
@@ -883,7 +938,7 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 
 		ret = dwc3_gadget_set_test_mode(dwc, dwc->test_mode_nr);
 		if (ret < 0) {
-			dev_dbg(dwc->dev, "Invalid Test #%d",
+			dev_err(dwc->dev, "invalid test #%d\n",
 					dwc->test_mode_nr);
 			dwc3_ep0_stall_and_restart(dwc);
 			return;
@@ -892,7 +947,7 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 	if (status == DWC3_TRBSTS_SETUP_PENDING)
-		dev_dbg(dwc->dev, "Setup Pending received");
+		dwc->setup_packet_pending = true;
 
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc3_ep0_out_start(dwc);
@@ -903,23 +958,20 @@ static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
 {
 	struct dwc3_ep		*dep = dwc->eps[event->endpoint_number];
 
-	dep->flags &= ~DWC3_EP_BUSY;
+	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	dep->resource_index = 0;
 	dwc->setup_packet_pending = false;
 
 	switch (dwc->ep0state) {
 	case EP0_SETUP_PHASE:
-		dev_vdbg(dwc->dev, "Setup Phase\n");
 		dwc3_ep0_inspect_setup(dwc, event);
 		break;
 
 	case EP0_DATA_PHASE:
-		dev_vdbg(dwc->dev, "Data Phase\n");
 		dwc3_ep0_complete_data(dwc, event);
 		break;
 
 	case EP0_STATUS_PHASE:
-		dev_vdbg(dwc->dev, "Status Phase\n");
 		dwc3_ep0_complete_status(dwc, event);
 		break;
 	default:
@@ -930,60 +982,83 @@ static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
 static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		struct dwc3_ep *dep, struct dwc3_request *req)
 {
+	unsigned int		trb_length = 0;
 	int			ret;
 
 	req->direction = !!dep->number;
 
 	if (req->request.length == 0) {
-		ret = dwc3_ep0_start_trans(dwc, dep->number,
-					   dwc->ctrl_req_addr, 0,
-					   DWC3_TRBCTL_CONTROL_DATA, 0);
-	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
-			(dep->number == 0)) {
-		u32	transfer_size = 0;
+		if (!req->direction)
+			trb_length = dep->endpoint.maxpacket;
+
+		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr, trb_length,
+				DWC3_TRBCTL_CONTROL_DATA, false);
+		ret = dwc3_ep0_start_trans(dep);
+	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
+			&& (dep->number == 0)) {
 		u32	maxpacket;
+		u32	rem;
 
-		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
-				dep->number);
-		if (ret) {
-			dev_dbg(dwc->dev, "failed to map request\n");
+		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
+				&req->request, dep->number);
+		if (ret)
 			return;
-		}
 
 		maxpacket = dep->endpoint.maxpacket;
-		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
-			transfer_size = (req->request.length / maxpacket) *
-						maxpacket;
-			ret = dwc3_ep0_start_trans(dwc, dep->number,
-						   req->request.dma,
-						   transfer_size,
-						   DWC3_TRBCTL_CONTROL_DATA, 1);
-		}
-
-		transfer_size = roundup((req->request.length - transfer_size),
-					maxpacket);
-
+		rem = req->request.length % maxpacket;
 		dwc->ep0_bounced = true;
 
-		/*
-		 * REVISIT in case request length is bigger than
-		 * DWC3_EP0_BOUNCE_SIZE we will need two chained
-		 * TRBs to handle the transfer.
-		 */
-		ret = dwc3_ep0_start_trans(dwc, dep->number,
-					   dwc->ep0_bounce_addr, transfer_size,
-					   DWC3_TRBCTL_CONTROL_DATA, 0);
+		/* prepare normal TRB */
+		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
+					 req->request.length,
+					 DWC3_TRBCTL_CONTROL_DATA,
+					 true);
+
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
+		/* Now prepare one extra TRB to align transfer size */
+		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
+					 maxpacket - rem,
+					 DWC3_TRBCTL_CONTROL_DATA,
+					 false);
+		ret = dwc3_ep0_start_trans(dep);
+	} else if (IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
+		   req->request.length && req->request.zero) {
+
+		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
+				&req->request, dep->number);
+		if (ret)
+			return;
+
+		/* prepare normal TRB */
+		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
+					 req->request.length,
+					 DWC3_TRBCTL_CONTROL_DATA,
+					 true);
+
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
+		if (!req->direction)
+			trb_length = dep->endpoint.maxpacket;
+
+		/* Now prepare one extra TRB to align transfer size */
+		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
+					 trb_length, DWC3_TRBCTL_CONTROL_DATA,
+					 false);
+		ret = dwc3_ep0_start_trans(dep);
 	} else {
-		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
-				dep->number);
-		if (ret) {
-			dev_dbg(dwc->dev, "failed to map request\n");
+		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
+				&req->request, dep->number);
+		if (ret)
 			return;
-		}
 
-		ret = dwc3_ep0_start_trans(dwc, dep->number, req->request.dma,
-					   req->request.length,
-					   DWC3_TRBCTL_CONTROL_DATA, 0);
+		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
+				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
+				false);
+
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue];
+
+		ret = dwc3_ep0_start_trans(dep);
 	}
 
 	WARN_ON(ret < 0);
@@ -997,18 +1072,12 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 	type = dwc->three_stage_setup ? DWC3_TRBCTL_CONTROL_STATUS3
 		: DWC3_TRBCTL_CONTROL_STATUS2;
 
-	return dwc3_ep0_start_trans(dwc, dep->number,
-			dwc->ctrl_req_addr, 0, type, 0);
+	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 0, type, false);
+	return dwc3_ep0_start_trans(dep);
 }
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
-	if (dwc->resize_fifos) {
-		dev_dbg(dwc->dev, "Resizing FIFOs");
-		dwc3_gadget_resize_tx_fifos(dwc);
-		dwc->resize_fifos = 0;
-	}
-
 	WARN_ON(dwc3_ep0_start_control_status(dep));
 }
 
@@ -1020,20 +1089,38 @@ static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
 	__dwc3_ep0_do_control_status(dwc, dep);
 }
 
-static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
+void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
+{
+	unsigned int direction = !dwc->ep0_expect_in;
+
+	dwc->delayed_status = false;
+	dwc->clear_stall_protocol = 0;
+
+	if (dwc->ep0state != EP0_STATUS_PHASE)
+		return;
+
+	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
+}
+
+void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	u32			cmd;
 	int			ret;
 
-	if (!dep->resource_index)
+	/*
+	 * For status/DATA OUT stage, TRB will be queued on ep0 out
+	 * endpoint for which resource index is zero. Hence allow
+	 * queuing ENDXFER command for ep0 out endpoint.
+	 */
+	if (!dep->resource_index && dep->number)
 		return;
 
 	cmd = DWC3_DEPCMD_ENDTRANSFER;
 	cmd |= DWC3_DEPCMD_CMDIOC;
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
-	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 }
@@ -1041,12 +1128,10 @@ static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	dwc->setup_packet_pending = true;
-
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
-		dev_vdbg(dwc->dev, "Control Data\n");
-
+		if (!dwc->softconnect || !dwc->connected)
+			return;
 		/*
 		 * We already have a DATA transfer in the controller's cache,
 		 * if we receive a XferNotReady(DATA) we will ignore it, unless
@@ -1059,7 +1144,7 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		if (dwc->ep0_expect_in != event->endpoint_number) {
 			struct dwc3_ep	*dep = dwc->eps[dwc->ep0_expect_in];
 
-			dev_vdbg(dwc->dev, "Wrong direction for Data phase\n");
+			dev_err(dwc->dev, "unexpected direction for Data Phase\n");
 			dwc3_ep0_end_control_data(dwc, dep);
 			dwc3_ep0_stall_and_restart(dwc);
 			return;
@@ -1071,13 +1156,29 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		if (dwc->ep0_next_event != DWC3_EP0_NRDY_STATUS)
 			return;
 
-		dev_vdbg(dwc->dev, "Control Status\n");
+		if (dwc->setup_packet_pending) {
+			dwc3_ep0_stall_and_restart(dwc);
+			return;
+		}
 
 		dwc->ep0state = EP0_STATUS_PHASE;
 
 		if (dwc->delayed_status) {
+			struct dwc3_ep *dep = dwc->eps[0];
+
 			WARN_ON_ONCE(event->endpoint_number != 1);
-			dev_vdbg(dwc->dev, "Delayed Status\n");
+			/*
+			 * We should handle the delay STATUS phase here if the
+			 * request for handling delay STATUS has been queued
+			 * into the list.
+			 */
+			if (!list_empty(&dep->pending_list)) {
+				dwc->delayed_status = false;
+				usb_gadget_set_state(dwc->gadget,
+						     USB_STATE_CONFIGURED);
+				dwc3_ep0_do_control_status(dwc, event);
+			}
+
 			return;
 		}
 
@@ -1088,12 +1189,8 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	u8			epnum = event->endpoint_number;
-
-	dev_dbg(dwc->dev, "%s while ep%d%s in state '%s'\n",
-		dwc3_ep_event_string(event->endpoint_event),
-		epnum >> 1, (epnum & 1) ? "in" : "out",
-		dwc3_ep0_state_string(dwc->ep0state));
+	struct dwc3_ep	*dep = dwc->eps[event->endpoint_number];
+	u8		cmd;
 
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
@@ -1107,7 +1204,17 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
 	case DWC3_DEPEVT_XFERINPROGRESS:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 	case DWC3_DEPEVT_STREAMEVT:
+		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
+		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
+
+		if (cmd == DWC3_DEPCMD_ENDTRANSFER) {
+			dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
+			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+		}
+		break;
+	default:
+		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
 		break;
 	}
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2b01113d54cd..74968f93d4a3 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1,47 +1,42 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * gadget.c - DesignWare USB3 DRD Controller Gadget Framework Link
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/gadget.c) and ported
- * to uboot.
- *
- * commit 8e74475b0e : usb: dwc3: gadget: use udc-core's reset notifier
  */
 
-#include <cpu_func.h>
-#include <log.h>
-#include <malloc.h>
-#include <dm.h>
-#include <dm/device_compat.h>
-#include <dm/devres.h>
-#include <linux/bug.h>
+#include <linux/kernel.h>
 #include <linux/delay.h>
-#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/list.h>
-#include <linux/printk.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 
+#include "debug.h"
 #include "core.h"
 #include "gadget.h"
 #include "io.h"
 
-#include "linux-compat.h"
+#define DWC3_ALIGN_FRAME(d, n)	(((d)->frame_number + ((d)->interval * (n))) \
+					& ~((d)->interval - 1))
 
 /**
- * dwc3_gadget_set_test_mode - Enables USB2 Test Modes
+ * dwc3_gadget_set_test_mode - enables usb2 test modes
  * @dwc: pointer to our context structure
  * @mode: the mode to set (J, K SE0 NAK, Force Enable)
  *
- * Caller should take care of locking. This function will
- * return 0 on success or -EINVAL if wrong Test Selector
- * is passed
+ * Caller should take care of locking. This function will return 0 on
+ * success or -EINVAL if wrong Test Selector is passed.
  */
 int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
 {
@@ -51,24 +46,24 @@ int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
 
 	switch (mode) {
-	case TEST_J:
-	case TEST_K:
-	case TEST_SE0_NAK:
-	case TEST_PACKET:
-	case TEST_FORCE_EN:
+	case USB_TEST_J:
+	case USB_TEST_K:
+	case USB_TEST_SE0_NAK:
+	case USB_TEST_PACKET:
+	case USB_TEST_FORCE_ENABLE:
 		reg |= mode << 1;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	return 0;
 }
 
 /**
- * dwc3_gadget_get_link_state - Gets current state of USB Link
+ * dwc3_gadget_get_link_state - gets current state of usb link
  * @dwc: pointer to our context structure
  *
  * Caller should take care of locking. This function will
@@ -84,7 +79,7 @@ int dwc3_gadget_get_link_state(struct dwc3 *dwc)
 }
 
 /**
- * dwc3_gadget_set_link_state - Sets USB Link to a particular State
+ * dwc3_gadget_set_link_state - sets usb link to a particular state
  * @dwc: pointer to our context structure
  * @state: the state to put link into
  *
@@ -100,7 +95,7 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	 * Wait until device controller is ready. Only applies to 1.94a and
 	 * later RTL.
 	 */
-	if (dwc->revision >= DWC3_REVISION_194A) {
+	if (!DWC3_VER_IS_PRIOR(DWC3, 194A)) {
 		while (--retries) {
 			reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 			if (reg & DWC3_DSTS_DCNRD)
@@ -116,6 +111,9 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
 
+	/* set no action before sending new link state change */
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
 	/* set requested state */
 	reg |= DWC3_DCTL_ULSTCHNGREQ(state);
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
@@ -124,7 +122,7 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	 * The following code is racy when called from dwc3_gadget_wakeup,
 	 * and is not needed, at least on newer versions
 	 */
-	if (dwc->revision >= DWC3_REVISION_194A)
+	if (!DWC3_VER_IS_PRIOR(DWC3, 194A))
 		return 0;
 
 	/* wait for a change in DSTS */
@@ -138,140 +136,121 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 		udelay(5);
 	}
 
-	dev_vdbg(dwc->dev, "link state change request timed out\n");
-
 	return -ETIMEDOUT;
 }
 
-/**
- * dwc3_gadget_resize_tx_fifos - reallocate fifo spaces for current use-case
- * @dwc: pointer to our context structure
- *
- * This function will a best effort FIFO allocation in order
- * to improve FIFO usage and throughput, while still allowing
- * us to enable as many endpoints as possible.
- *
- * Keep in mind that this operation will be highly dependent
- * on the configured size for RAM1 - which contains TxFifo -,
- * the amount of endpoints enabled on coreConsultant tool, and
- * the width of the Master Bus.
- *
- * In the ideal world, we would always be able to satisfy the
- * following equation:
- *
- * ((512 + 2 * MDWIDTH-Bytes) + (Number of IN Endpoints - 1) * \
- * (3 * (1024 + MDWIDTH-Bytes) + MDWIDTH-Bytes)) / MDWIDTH-Bytes
- *
- * Unfortunately, due to many variables that's not always the case.
- */
-int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc)
+static void dwc3_ep0_reset_state(struct dwc3 *dwc)
 {
-	int		last_fifo_depth = 0;
-	int		fifo_size;
-	int		mdwidth;
-	int		num;
+	unsigned int	dir;
 
-	if (!dwc->needs_fifo_resize)
-		return 0;
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		dir = !!dwc->ep0_expect_in;
+		if (dwc->ep0state == EP0_DATA_PHASE)
+			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
+		else
+			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
 
-	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
+		dwc->eps[0]->trb_enqueue = 0;
+		dwc->eps[1]->trb_enqueue = 0;
 
-	/* MDWIDTH is represented in bits, we need it in bytes */
-	mdwidth >>= 3;
-
-	/*
-	 * FIXME For now we will only allocate 1 wMaxPacketSize space
-	 * for each enabled endpoint, later patches will come to
-	 * improve this algorithm so that we better use the internal
-	 * FIFO space
-	 */
-	for (num = 0; num < dwc->num_in_eps; num++) {
-		/* bit0 indicates direction; 1 means IN ep */
-		struct dwc3_ep	*dep = dwc->eps[(num << 1) | 1];
-		int		mult = 1;
-		int		tmp;
-
-		if (!(dep->flags & DWC3_EP_ENABLED))
-			continue;
-
-		if (usb_endpoint_xfer_bulk(dep->endpoint.desc)
-				|| usb_endpoint_xfer_isoc(dep->endpoint.desc))
-			mult = 3;
-
-		/*
-		 * REVISIT: the following assumes we will always have enough
-		 * space available on the FIFO RAM for all possible use cases.
-		 * Make sure that's true somehow and change FIFO allocation
-		 * accordingly.
-		 *
-		 * If we have Bulk or Isochronous endpoints, we want
-		 * them to be able to be very, very fast. So we're giving
-		 * those endpoints a fifo_size which is enough for 3 full
-		 * packets
-		 */
-		tmp = mult * (dep->endpoint.maxpacket + mdwidth);
-		tmp += mdwidth;
-
-		fifo_size = DIV_ROUND_UP(tmp, mdwidth);
-
-		fifo_size |= (last_fifo_depth << 16);
-
-		dev_vdbg(dwc->dev, "%s: Fifo Addr %04x Size %d\n",
-				dep->name, last_fifo_depth, fifo_size & 0xffff);
-
-		dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(num), fifo_size);
-
-		last_fifo_depth += (fifo_size & 0xffff);
+		dwc3_ep0_stall_and_restart(dwc);
 	}
+}
+
+/**
+ * dwc3_ep_inc_trb - increment a trb index.
+ * @index: Pointer to the TRB index to increment.
+ *
+ * The index should never point to the link TRB. After incrementing,
+ * if it is point to the link TRB, wrap around to the beginning. The
+ * link TRB is always at the last TRB entry.
+ */
+static void dwc3_ep_inc_trb(u8 *index)
+{
+	(*index)++;
+	if (*index == (DWC3_TRB_NUM - 1))
+		*index = 0;
+}
+
+/**
+ * dwc3_ep_inc_enq - increment endpoint's enqueue pointer
+ * @dep: The endpoint whose enqueue pointer we're incrementing
+ */
+static void dwc3_ep_inc_enq(struct dwc3_ep *dep)
+{
+	dwc3_ep_inc_trb(&dep->trb_enqueue);
+}
 
-	return 0;
+/**
+ * dwc3_ep_inc_deq - increment endpoint's dequeue pointer
+ * @dep: The endpoint whose enqueue pointer we're incrementing
+ */
+static void dwc3_ep_inc_deq(struct dwc3_ep *dep)
+{
+	dwc3_ep_inc_trb(&dep->trb_dequeue);
 }
 
-void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
-		int status)
+static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
+		struct dwc3_request *req, int status)
 {
 	struct dwc3			*dwc = dep->dwc;
 
-	if (req->queued) {
-		dep->busy_slot++;
-		/*
-		 * Skip LINK TRB. We can't use req->trb and check for
-		 * DWC3_TRBCTL_LINK_TRB because it points the TRB we
-		 * just completed (not the LINK TRB).
-		 */
-		if (((dep->busy_slot & DWC3_TRB_MASK) ==
-			DWC3_TRB_NUM- 1) &&
-			usb_endpoint_xfer_isoc(dep->endpoint.desc))
-			dep->busy_slot++;
-		req->queued = false;
-	}
-
 	list_del(&req->list);
-	req->trb = NULL;
-	if (req->request.dma && req->request.length)
-		dwc3_flush_cache((uintptr_t)req->request.dma, req->request.length);
+	req->remaining = 0;
+	req->num_trbs = 0;
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
 
-	if (dwc->ep0_bounced && dep->number == 0)
-		dwc->ep0_bounced = false;
-	else if (req->request.dma)
-		usb_gadget_unmap_request(&dwc->gadget, &req->request,
-				req->direction);
-
-	dev_dbg(dwc->dev, "request %p from %s completed %d/%d ===> %d\n",
-			req, dep->name, req->request.actual,
-			req->request.length, status);
+	if (req->trb)
+		usb_gadget_unmap_request_by_dev(dwc->sysdev,
+				&req->request, req->direction);
+
+	req->trb = NULL;
+	trace_dwc3_gadget_giveback(req);
+
+	if (dep->number > 1)
+		pm_runtime_put(dwc->dev);
+}
+
+/**
+ * dwc3_gadget_giveback - call struct usb_request's ->complete callback
+ * @dep: The endpoint to whom the request belongs to
+ * @req: The request we're giving back
+ * @status: completion code for the request
+ *
+ * Must be called with controller's lock held and interrupts disabled. This
+ * function will unmap @req and call its ->complete() callback to notify upper
+ * layers that it has completed.
+ */
+void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
+		int status)
+{
+	struct dwc3			*dwc = dep->dwc;
+
+	dwc3_gadget_del_and_unmap_request(dep, req, status);
+	req->status = DWC3_REQUEST_STATUS_COMPLETED;
 
 	spin_unlock(&dwc->lock);
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
 	spin_lock(&dwc->lock);
 }
 
-int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
+/**
+ * dwc3_send_gadget_generic_command - issue a generic command for the controller
+ * @dwc: pointer to the controller context
+ * @cmd: the command to be issued
+ * @param: command parameter
+ *
+ * Caller should take care of locking. Issue @cmd with a given @param to @dwc
+ * and wait for its completion.
+ */
+int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
+		u32 param)
 {
 	u32		timeout = 500;
+	int		status = 0;
+	int		ret = 0;
 	u32		reg;
 
 	dwc3_writel(dwc->regs, DWC3_DGCMDPAR, param);
@@ -280,29 +259,59 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DGCMD);
 		if (!(reg & DWC3_DGCMD_CMDACT)) {
-			dev_vdbg(dwc->dev, "Command Complete --> %d\n",
-					DWC3_DGCMD_STATUS(reg));
-			return 0;
+			status = DWC3_DGCMD_STATUS(reg);
+			if (status)
+				ret = -EINVAL;
+			break;
 		}
+	} while (--timeout);
 
-		/*
-		 * We can't sleep here, because it's also called from
-		 * interrupt context.
-		 */
-		timeout--;
-		if (!timeout)
-			return -ETIMEDOUT;
-		udelay(1);
-	} while (1);
+	if (!timeout) {
+		ret = -ETIMEDOUT;
+		status = -ETIMEDOUT;
+	}
+
+	trace_dwc3_gadget_generic_cmd(cmd, param, status);
+
+	return ret;
 }
 
-int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
-		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params)
+/**
+ * dwc3_send_gadget_ep_cmd - issue an endpoint command
+ * @dep: the endpoint to which the command is going to be issued
+ * @cmd: the command to be issued
+ * @params: parameters to the command
+ *
+ * Caller should handle locking. This function will issue @cmd with given
+ * @params to @dep and wait for its completion.
+ *
+ * According to the programming guide, if the link state is in L1/L2/U3,
+ * then sending the Start Transfer command may not complete. The
+ * programming guide suggested to bring the link state back to ON/U0 by
+ * performing remote wakeup prior to sending the command. However, don't
+ * initiate remote wakeup when the user/function does not send wakeup
+ * request via wakeup ops. Send the command when it's allowed.
+ *
+ * Notes:
+ * For L1 link state, issuing a command requires the clearing of
+ * GUSB2PHYCFG.SUSPENDUSB2, which turns on the signal required to complete
+ * the given command (usually within 50us). This should happen within the
+ * command timeout set by driver. No additional step is needed.
+ *
+ * For L2 or U3 link state, the gadget is in USB suspend. Care should be
+ * taken when sending Start Transfer command to ensure that it's done after
+ * USB resume.
+ */
+int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
+		struct dwc3_gadget_ep_cmd_params *params)
 {
-	u32			timeout = 500;
+	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
+	struct dwc3		*dwc = dep->dwc;
+	u32			timeout = 5000;
 	u32			saved_config = 0;
 	u32			reg;
 
+	int			cmd_status = 0;
 	int			ret = -EINVAL;
 
 	/*
@@ -315,7 +324,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 	 *
 	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
 	 */
-	if (dwc->gadget.speed <= USB_SPEED_HIGH ||
+	if (dwc->gadget->speed <= USB_SPEED_HIGH ||
 	    DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
@@ -332,32 +341,103 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
-	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
-	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR1(ep), params->param1);
-	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR2(ep), params->param2);
+	/*
+	 * For some commands such as Update Transfer command, DEPCMDPARn
+	 * registers are reserved. Since the driver often sends Update Transfer
+	 * command, don't write to DEPCMDPARn to avoid register write delays and
+	 * improve performance.
+	 */
+	if (DWC3_DEPCMD_CMD(cmd) != DWC3_DEPCMD_UPDATETRANSFER) {
+		dwc3_writel(dep->regs, DWC3_DEPCMDPAR0, params->param0);
+		dwc3_writel(dep->regs, DWC3_DEPCMDPAR1, params->param1);
+		dwc3_writel(dep->regs, DWC3_DEPCMDPAR2, params->param2);
+	}
+
+	/*
+	 * Synopsys Databook 2.60a states in section 6.3.2.5.6 of that if we're
+	 * not relying on XferNotReady, we can make use of a special "No
+	 * Response Update Transfer" command where we should clear both CmdAct
+	 * and CmdIOC bits.
+	 *
+	 * With this, we don't need to wait for command completion and can
+	 * straight away issue further commands to the endpoint.
+	 *
+	 * NOTICE: We're making an assumption that control endpoints will never
+	 * make use of Update Transfer command. This is a safe assumption
+	 * because we can never have more than one request at a time with
+	 * Control Endpoints. If anybody changes that assumption, this chunk
+	 * needs to be updated accordingly.
+	 */
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_UPDATETRANSFER &&
+			!usb_endpoint_xfer_isoc(desc))
+		cmd &= ~(DWC3_DEPCMD_CMDIOC | DWC3_DEPCMD_CMDACT);
+	else
+		cmd |= DWC3_DEPCMD_CMDACT;
+
+	dwc3_writel(dep->regs, DWC3_DEPCMD, cmd);
+
+	if (!(cmd & DWC3_DEPCMD_CMDACT) ||
+		(DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
+		!(cmd & DWC3_DEPCMD_CMDIOC))) {
+		ret = 0;
+		goto skip_status;
+	}
 
-	dwc3_writel(dwc->regs, DWC3_DEPCMD(ep), cmd | DWC3_DEPCMD_CMDACT);
 	do {
-		reg = dwc3_readl(dwc->regs, DWC3_DEPCMD(ep));
+		reg = dwc3_readl(dep->regs, DWC3_DEPCMD);
 		if (!(reg & DWC3_DEPCMD_CMDACT)) {
-			dev_vdbg(dwc->dev, "Command Complete --> %d\n",
-					DWC3_DEPCMD_STATUS(reg));
-			ret = 0;
-			break;
-		}
+			cmd_status = DWC3_DEPCMD_STATUS(reg);
+
+			switch (cmd_status) {
+			case 0:
+				ret = 0;
+				break;
+			case DEPEVT_TRANSFER_NO_RESOURCE:
+				dev_WARN(dwc->dev, "No resource for %s\n",
+					 dep->name);
+				ret = -EINVAL;
+				break;
+			case DEPEVT_TRANSFER_BUS_EXPIRY:
+				/*
+				 * SW issues START TRANSFER command to
+				 * isochronous ep with future frame interval. If
+				 * future interval time has already passed when
+				 * core receives the command, it will respond
+				 * with an error status of 'Bus Expiry'.
+				 *
+				 * Instead of always returning -EINVAL, let's
+				 * give a hint to the gadget driver that this is
+				 * the case by returning -EAGAIN.
+				 */
+				ret = -EAGAIN;
+				break;
+			default:
+				dev_WARN(dwc->dev, "UNKNOWN cmd status\n");
+			}
 
-		/*
-		 * We can't sleep here, because it is also called from
-		 * interrupt context.
-		 */
-		timeout--;
-		if (!timeout) {
-			ret = -ETIMEDOUT;
 			break;
 		}
+	} while (--timeout);
+
+	if (timeout == 0) {
+		ret = -ETIMEDOUT;
+		cmd_status = -ETIMEDOUT;
+	}
+
+skip_status:
+	trace_dwc3_gadget_ep_cmd(dep, cmd, params, cmd_status);
+
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
+		if (ret == 0)
+			dep->flags |= DWC3_EP_TRANSFER_STARTED;
+
+		if (ret != -ETIMEDOUT)
+			dwc3_gadget_ep_get_transfer_index(dep);
+	}
 
-		udelay(1);
-	} while (1);
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
+	    !(cmd & DWC3_DEPCMD_CMDIOC))
+		mdelay(1);
 
 	if (saved_config) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
@@ -368,6 +448,30 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 	return ret;
 }
 
+static int dwc3_send_clear_stall_ep_cmd(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
+	struct dwc3_gadget_ep_cmd_params params;
+	u32 cmd = DWC3_DEPCMD_CLEARSTALL;
+
+	/*
+	 * As of core revision 2.60a the recommended programming model
+	 * is to set the ClearPendIN bit when issuing a Clear Stall EP
+	 * command for IN endpoints. This is to prevent an issue where
+	 * some (non-compliant) hosts may not send ACK TPs for pending
+	 * IN transfers due to a mishandled error condition. Synopsys
+	 * STAR 9000614252.
+	 */
+	if (dep->direction &&
+	    !DWC3_VER_IS_PRIOR(DWC3, 260A) &&
+	    (dwc->gadget->speed >= USB_SPEED_SUPER))
+		cmd |= DWC3_DEPCMD_CLEARPENDIN;
+
+	memset(&params, 0, sizeof(params));
+
+	return dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+}
+
 static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
 		struct dwc3_trb *trb)
 {
@@ -378,15 +482,14 @@ static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
 
 static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 {
+	struct dwc3		*dwc = dep->dwc;
+
 	if (dep->trb_pool)
 		return 0;
 
-	if (dep->number == 0 || dep->number == 1)
-		return 0;
-
-	dep->trb_pool = dma_alloc_coherent(sizeof(struct dwc3_trb) *
-					   DWC3_TRB_NUM,
-					   (unsigned long *)&dep->trb_pool_dma);
+	dep->trb_pool = dma_alloc_coherent(dwc->sysdev,
+			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
+			&dep->trb_pool_dma, GFP_KERNEL);
 	if (!dep->trb_pool) {
 		dev_err(dep->dwc->dev, "failed to allocate trb pool for %s\n",
 				dep->name);
@@ -398,41 +501,87 @@ static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 
 static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 {
-	dma_free_coherent(dep->trb_pool);
+	struct dwc3		*dwc = dep->dwc;
+
+	dma_free_coherent(dwc->sysdev, sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
+			dep->trb_pool, dep->trb_pool_dma);
 
 	dep->trb_pool = NULL;
 	dep->trb_pool_dma = 0;
 }
 
-static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
+static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
+	int ret;
+
+	if (dep->flags & DWC3_EP_RESOURCE_ALLOCATED)
+		return 0;
+
+	memset(&params, 0x00, sizeof(params));
+
+	params.param0 = DWC3_DEPXFERCFG_NUM_XFER_RES(1);
+
+	ret = dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETTRANSFRESOURCE,
+			&params);
+	if (ret)
+		return ret;
+
+	dep->flags |= DWC3_EP_RESOURCE_ALLOCATED;
+	return 0;
+}
+
+/**
+ * dwc3_gadget_start_config - reset endpoint resources
+ * @dwc: pointer to the DWC3 context
+ * @resource_index: DEPSTARTCFG.XferRscIdx value (must be 0 or 2)
+ *
+ * Set resource_index=0 to reset all endpoints' resources allocation. Do this as
+ * part of the power-on/soft-reset initialization.
+ *
+ * Set resource_index=2 to reset only non-control endpoints' resources. Do this
+ * on receiving the SET_CONFIGURATION request or hibernation resume.
+ */
+int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_ep		*dep;
 	u32			cmd;
+	int			i;
+	int			ret;
+
+	if (resource_index != 0 && resource_index != 2)
+		return -EINVAL;
 
 	memset(&params, 0x00, sizeof(params));
+	cmd = DWC3_DEPCMD_DEPSTARTCFG;
+	cmd |= DWC3_DEPCMD_PARAM(resource_index);
 
-	if (dep->number != 1) {
-		cmd = DWC3_DEPCMD_DEPSTARTCFG;
-		/* XferRscIdx == 0 for ep0 and 2 for the remaining */
-		if (dep->number > 1) {
-			if (dwc->start_config_issued)
-				return 0;
-			dwc->start_config_issued = true;
-			cmd |= DWC3_DEPCMD_PARAM(2);
-		}
+	ret = dwc3_send_gadget_ep_cmd(dwc->eps[0], cmd, &params);
+	if (ret)
+		return ret;
 
-		return dwc3_send_gadget_ep_cmd(dwc, 0, cmd, &params);
+	/* Reset resource allocation flags */
+	for (i = resource_index; i < dwc->num_eps; i++) {
+		dep = dwc->eps[i];
+		if (!dep)
+			continue;
+
+		dep->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
 	}
 
 	return 0;
 }
 
-static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
-		const struct usb_endpoint_descriptor *desc,
-		const struct usb_ss_ep_comp_descriptor *comp_desc,
-		bool ignore, bool restore)
+static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 {
+	const struct usb_ss_ep_comp_descriptor *comp_desc;
+	const struct usb_endpoint_descriptor *desc;
 	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3 *dwc = dep->dwc;
+
+	comp_desc = dep->endpoint.comp_desc;
+	desc = dep->endpoint.desc;
 
 	memset(&params, 0x00, sizeof(params));
 
@@ -440,25 +589,25 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 		| DWC3_DEPCFG_MAX_PACKET_SIZE(usb_endpoint_maxp(desc));
 
 	/* Burst size is only needed in SuperSpeed mode */
-	if (dwc->gadget.speed == USB_SPEED_SUPER) {
-		u32 burst = dep->endpoint.maxburst - 1;
+	if (dwc->gadget->speed >= USB_SPEED_SUPER) {
+		u32 burst = dep->endpoint.maxburst;
 
-		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst);
+		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst - 1);
 	}
 
-	if (ignore)
-		params.param0 |= DWC3_DEPCFG_IGN_SEQ_NUM;
-
-	if (restore) {
-		params.param0 |= DWC3_DEPCFG_ACTION_RESTORE;
+	params.param0 |= action;
+	if (action == DWC3_DEPCFG_ACTION_RESTORE)
 		params.param2 |= dep->saved_state;
-	}
 
-	params.param1 = DWC3_DEPCFG_XFER_COMPLETE_EN
-		| DWC3_DEPCFG_XFER_NOT_READY_EN;
+	if (usb_endpoint_xfer_control(desc))
+		params.param1 = DWC3_DEPCFG_XFER_COMPLETE_EN;
+
+	if (dep->number <= 1 || usb_endpoint_xfer_isoc(desc))
+		params.param1 |= DWC3_DEPCFG_XFER_NOT_READY_EN;
 
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
+			| DWC3_DEPCFG_XFER_COMPLETE_EN
 			| DWC3_DEPCFG_STREAM_EVENT_EN;
 		dep->stream_capable = true;
 	}
@@ -482,65 +631,309 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 		params.param0 |= DWC3_DEPCFG_FIFO_NUMBER(dep->number >> 1);
 
 	if (desc->bInterval) {
-		params.param1 |= DWC3_DEPCFG_BINTERVAL_M1(desc->bInterval - 1);
-		dep->interval = 1 << (desc->bInterval - 1);
+		u8 bInterval_m1;
+
+		/*
+		 * Valid range for DEPCFG.bInterval_m1 is from 0 to 13.
+		 *
+		 * NOTE: The programming guide incorrectly stated bInterval_m1
+		 * must be set to 0 when operating in fullspeed. Internally the
+		 * controller does not have this limitation. See DWC_usb3x
+		 * programming guide section 3.2.2.1.
+		 */
+		bInterval_m1 = min_t(u8, desc->bInterval - 1, 13);
+
+		if (usb_endpoint_type(desc) == USB_ENDPOINT_XFER_INT &&
+		    dwc->gadget->speed == USB_SPEED_FULL)
+			dep->interval = desc->bInterval;
+		else
+			dep->interval = 1 << (desc->bInterval - 1);
+
+		params.param1 |= DWC3_DEPCFG_BINTERVAL_M1(bInterval_m1);
 	}
 
-	return dwc3_send_gadget_ep_cmd(dwc, dep->number,
-			DWC3_DEPCMD_SETEPCONFIG, &params);
+	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
+}
+
+/**
+ * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
+ * @dwc: pointer to the DWC3 context
+ * @mult: multiplier to be used when calculating the fifo_size
+ *
+ * Calculates the size value based on the equation below:
+ *
+ * DWC3 revision 280A and prior:
+ * fifo_size = mult * (max_packet / mdwidth) + 1;
+ *
+ * DWC3 revision 290A and onwards:
+ * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
+ *
+ * The max packet size is set to 1024, as the txfifo requirements mainly apply
+ * to super speed USB use cases.  However, it is safe to overestimate the fifo
+ * allocations for other scenarios, i.e. high speed USB.
+ */
+static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
+{
+	int max_packet = 1024;
+	int fifo_size;
+	int mdwidth;
+
+	mdwidth = dwc3_mdwidth(dwc);
+
+	/* MDWIDTH is represented in bits, we need it in bytes */
+	mdwidth >>= 3;
+
+	if (DWC3_VER_IS_PRIOR(DWC3, 290A))
+		fifo_size = mult * (max_packet / mdwidth) + 1;
+	else
+		fifo_size = mult * ((max_packet + mdwidth) / mdwidth) + 1;
+	return fifo_size;
 }
 
-static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep)
+/**
+ * dwc3_gadget_calc_ram_depth - calculates the ram depth for txfifo
+ * @dwc: pointer to the DWC3 context
+ */
+static int dwc3_gadget_calc_ram_depth(struct dwc3 *dwc)
 {
-	struct dwc3_gadget_ep_cmd_params params;
+	int ram_depth;
+	int fifo_0_start;
+	bool is_single_port_ram;
+
+	/* Check supporting RAM type by HW */
+	is_single_port_ram = DWC3_SPRAM_TYPE(dwc->hwparams.hwparams1);
+
+	/*
+	 * If a single port RAM is utilized, then allocate TxFIFOs from
+	 * RAM0. otherwise, allocate them from RAM1.
+	 */
+	ram_depth = is_single_port_ram ? DWC3_RAM0_DEPTH(dwc->hwparams.hwparams6) :
+			DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+
+	/*
+	 * In a single port RAM configuration, the available RAM is shared
+	 * between the RX and TX FIFOs. This means that the txfifo can begin
+	 * at a non-zero address.
+	 */
+	if (is_single_port_ram) {
+		u32 reg;
+
+		/* Check if TXFIFOs start at non-zero addr */
+		reg = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+		fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(reg);
+
+		ram_depth -= (fifo_0_start >> 16);
+	}
+
+	return ram_depth;
+}
+
+/**
+ * dwc3_gadget_clear_tx_fifos - Clears txfifo allocation
+ * @dwc: pointer to the DWC3 context
+ *
+ * Iterates through all the endpoint registers and clears the previous txfifo
+ * allocations.
+ */
+void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
+{
+	struct dwc3_ep *dep;
+	int fifo_depth;
+	int size;
+	int num;
+
+	if (!dwc->do_fifo_resize)
+		return;
 
-	memset(&params, 0x00, sizeof(params));
+	/* Read ep0IN related TXFIFO size */
+	dep = dwc->eps[1];
+	size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+	if (DWC3_IP_IS(DWC3))
+		fifo_depth = DWC3_GTXFIFOSIZ_TXFDEP(size);
+	else
+		fifo_depth = DWC31_GTXFIFOSIZ_TXFDEP(size);
+
+	dwc->last_fifo_depth = fifo_depth;
+	/* Clear existing TXFIFO for all IN eps except ep0 */
+	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM); num += 2) {
+		dep = dwc->eps[num];
+		if (!dep)
+			continue;
+
+		/* Don't change TXFRAMNUM on usb31 version */
+		size = DWC3_IP_IS(DWC3) ? 0 :
+			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
+				   DWC31_GTXFIFOSIZ_TXFRAMNUM;
+
+		dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1), size);
+		dep->flags &= ~DWC3_EP_TXFIFO_RESIZED;
+	}
+	dwc->num_ep_resized = 0;
+}
+
+/*
+ * dwc3_gadget_resize_tx_fifos - reallocate fifo spaces for current use-case
+ * @dwc: pointer to our context structure
+ *
+ * This function will a best effort FIFO allocation in order
+ * to improve FIFO usage and throughput, while still allowing
+ * us to enable as many endpoints as possible.
+ *
+ * Keep in mind that this operation will be highly dependent
+ * on the configured size for RAM1 - which contains TxFifo -,
+ * the amount of endpoints enabled on coreConsultant tool, and
+ * the width of the Master Bus.
+ *
+ * In general, FIFO depths are represented with the following equation:
+ *
+ * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
+ *
+ * In conjunction with dwc3_gadget_check_config(), this resizing logic will
+ * ensure that all endpoints will have enough internal memory for one max
+ * packet per endpoint.
+ */
+static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
+	int fifo_0_start;
+	int ram_depth;
+	int fifo_size;
+	int min_depth;
+	int num_in_ep;
+	int remaining;
+	int num_fifos = 1;
+	int fifo;
+	int tmp;
+
+	if (!dwc->do_fifo_resize)
+		return 0;
+
+	/* resize IN endpoints except ep0 */
+	if (!usb_endpoint_dir_in(dep->endpoint.desc) || dep->number <= 1)
+		return 0;
+
+	/* bail if already resized */
+	if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
+		return 0;
+
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
+
+	switch (dwc->gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			num_fifos = min_t(unsigned int,
+					  dep->endpoint.maxburst,
+					  dwc->tx_fifo_resize_max_num);
+		break;
+	case USB_SPEED_HIGH:
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+			num_fifos = min_t(unsigned int,
+					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
+					  dwc->tx_fifo_resize_max_num);
+			break;
+		}
+		fallthrough;
+	case USB_SPEED_FULL:
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
+			num_fifos = 2;
+		break;
+	default:
+		break;
+	}
+
+	/* FIFO size for a single buffer */
+	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
+
+	/* Calculate the number of remaining EPs w/o any FIFO */
+	num_in_ep = dwc->max_cfg_eps;
+	num_in_ep -= dwc->num_ep_resized;
+
+	/* Reserve at least one FIFO for the number of IN EPs */
+	min_depth = num_in_ep * (fifo + 1);
+	remaining = ram_depth - min_depth - dwc->last_fifo_depth;
+	remaining = max_t(int, 0, remaining);
+	/*
+	 * We've already reserved 1 FIFO per EP, so check what we can fit in
+	 * addition to it.  If there is not enough remaining space, allocate
+	 * all the remaining space to the EP.
+	 */
+	fifo_size = (num_fifos - 1) * fifo;
+	if (remaining < fifo_size)
+		fifo_size = remaining;
+
+	fifo_size += fifo;
+	/* Last increment according to the TX FIFO size equation */
+	fifo_size++;
+
+	/* Check if TXFIFOs start at non-zero addr */
+	tmp = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+	fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(tmp);
+
+	fifo_size |= (fifo_0_start + (dwc->last_fifo_depth << 16));
+	if (DWC3_IP_IS(DWC3))
+		dwc->last_fifo_depth += DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
+	else
+		dwc->last_fifo_depth += DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
+
+	/* Check fifo size allocation doesn't exceed available RAM size. */
+	if (dwc->last_fifo_depth >= ram_depth) {
+		dev_err(dwc->dev, "Fifosize(%d) > RAM size(%d) %s depth:%d\n",
+			dwc->last_fifo_depth, ram_depth,
+			dep->endpoint.name, fifo_size);
+		if (DWC3_IP_IS(DWC3))
+			fifo_size = DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
+		else
+			fifo_size = DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
+
+		dwc->last_fifo_depth -= fifo_size;
+		return -ENOMEM;
+	}
 
-	params.param0 = DWC3_DEPXFERCFG_NUM_XFER_RES(1);
+	dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1), fifo_size);
+	dep->flags |= DWC3_EP_TXFIFO_RESIZED;
+	dwc->num_ep_resized++;
 
-	return dwc3_send_gadget_ep_cmd(dwc, dep->number,
-			DWC3_DEPCMD_SETTRANSFRESOURCE, &params);
+	return 0;
 }
 
 /**
- * __dwc3_gadget_ep_enable - Initializes a HW endpoint
+ * __dwc3_gadget_ep_enable - initializes a hw endpoint
  * @dep: endpoint to be initialized
- * @desc: USB Endpoint Descriptor
+ * @action: one of INIT, MODIFY or RESTORE
  *
- * Caller should take care of locking
+ * Caller should take care of locking. Execute all necessary commands to
+ * initialize a HW endpoint so it can be used by a gadget driver.
  */
-static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
-		const struct usb_endpoint_descriptor *desc,
-		const struct usb_ss_ep_comp_descriptor *comp_desc,
-		bool ignore, bool restore)
+static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 {
+	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
+
 	u32			reg;
 	int			ret;
 
-	dev_vdbg(dwc->dev, "Enabling %s\n", dep->name);
-
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
-		ret = dwc3_gadget_start_config(dwc, dep);
+		ret = dwc3_gadget_resize_tx_fifos(dep);
 		if (ret)
 			return ret;
 	}
 
-	ret = dwc3_gadget_set_ep_config(dwc, dep, desc, comp_desc, ignore,
-			restore);
+	ret = dwc3_gadget_set_ep_config(dep, action);
 	if (ret)
 		return ret;
 
+	if (!(dep->flags & DWC3_EP_RESOURCE_ALLOCATED)) {
+		ret = dwc3_gadget_set_xfer_resource(dep);
+		if (ret)
+			return ret;
+	}
+
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
 		struct dwc3_trb	*trb_st_hw;
 		struct dwc3_trb	*trb_link;
 
-		ret = dwc3_gadget_set_xfer_resource(dwc, dep);
-		if (ret)
-			return ret;
-
-		dep->endpoint.desc = desc;
-		dep->comp_desc = comp_desc;
 		dep->type = usb_endpoint_type(desc);
 		dep->flags |= DWC3_EP_ENABLED;
 
@@ -548,61 +941,134 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		reg |= DWC3_DALEPENA_EP(dep->number);
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
-		if (!usb_endpoint_xfer_isoc(desc))
-			return 0;
+		dep->trb_dequeue = 0;
+		dep->trb_enqueue = 0;
 
-		/* Link TRB for ISOC. The HWO bit is never reset */
+		if (usb_endpoint_xfer_control(desc))
+			goto out;
+
+		/* Initialize the TRB ring */
+		memset(dep->trb_pool, 0,
+		       sizeof(struct dwc3_trb) * DWC3_TRB_NUM);
+
+		/* Link TRB. The HWO bit is never reset */
 		trb_st_hw = &dep->trb_pool[0];
 
 		trb_link = &dep->trb_pool[DWC3_TRB_NUM - 1];
-		memset(trb_link, 0, sizeof(*trb_link));
-
 		trb_link->bpl = lower_32_bits(dwc3_trb_dma_offset(dep, trb_st_hw));
 		trb_link->bph = upper_32_bits(dwc3_trb_dma_offset(dep, trb_st_hw));
 		trb_link->ctrl |= DWC3_TRBCTL_LINK_TRB;
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
 	}
 
+	/*
+	 * Issue StartTransfer here with no-op TRB so we can always rely on No
+	 * Response Update Transfer command.
+	 */
+	if (usb_endpoint_xfer_bulk(desc) ||
+			usb_endpoint_xfer_int(desc)) {
+		struct dwc3_gadget_ep_cmd_params params;
+		struct dwc3_trb	*trb;
+		dma_addr_t trb_dma;
+		u32 cmd;
+
+		memset(&params, 0, sizeof(params));
+		trb = &dep->trb_pool[0];
+		trb_dma = dwc3_trb_dma_offset(dep, trb);
+
+		params.param0 = upper_32_bits(trb_dma);
+		params.param1 = lower_32_bits(trb_dma);
+
+		cmd = DWC3_DEPCMD_STARTTRANSFER;
+
+		ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+		if (ret < 0)
+			return ret;
+
+		if (dep->stream_capable) {
+			/*
+			 * For streams, at start, there maybe a race where the
+			 * host primes the endpoint before the function driver
+			 * queues a request to initiate a stream. In that case,
+			 * the controller will not see the prime to generate the
+			 * ERDY and start stream. To workaround this, issue a
+			 * no-op TRB as normal, but end it immediately. As a
+			 * result, when the function driver queues the request,
+			 * the next START_TRANSFER command will cause the
+			 * controller to generate an ERDY to initiate the
+			 * stream.
+			 */
+			dwc3_stop_active_transfer(dep, true, true);
+
+			/*
+			 * All stream eps will reinitiate stream on NoStream
+			 * rejection.
+			 *
+			 * However, if the controller is capable of
+			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
+			 * automatically restart the stream without the driver
+			 * initiation.
+			 */
+			if (!dep->direction ||
+			    !(dwc->hwparams.hwparams9 &
+			      DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
+				dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
+		}
+	}
+
+out:
+	trace_dwc3_gadget_ep_enable(dep);
+
 	return 0;
 }
 
-static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force);
-static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 {
 	struct dwc3_request		*req;
 
-	if (!list_empty(&dep->req_queued)) {
-		dwc3_stop_active_transfer(dwc, dep->number, true);
+	dwc3_stop_active_transfer(dep, true, false);
 
-		/* - giveback all requests to gadget driver */
-		while (!list_empty(&dep->req_queued)) {
-			req = next_request(&dep->req_queued);
+	/* If endxfer is delayed, avoid unmapping requests */
+	if (dep->flags & DWC3_EP_DELAY_STOP)
+		return;
 
-			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
-		}
+	/* - giveback all requests to gadget driver */
+	while (!list_empty(&dep->started_list)) {
+		req = next_request(&dep->started_list);
+
+		dwc3_gadget_giveback(dep, req, status);
+	}
+
+	while (!list_empty(&dep->pending_list)) {
+		req = next_request(&dep->pending_list);
+
+		dwc3_gadget_giveback(dep, req, status);
 	}
 
-	while (!list_empty(&dep->request_list)) {
-		req = next_request(&dep->request_list);
+	while (!list_empty(&dep->cancelled_list)) {
+		req = next_request(&dep->cancelled_list);
 
-		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		dwc3_gadget_giveback(dep, req, status);
 	}
 }
 
 /**
- * __dwc3_gadget_ep_disable - Disables a HW endpoint
+ * __dwc3_gadget_ep_disable - disables a hw endpoint
  * @dep: the endpoint to disable
  *
- * This function also removes requests which are currently processed ny the
- * hardware and those which are not yet scheduled.
+ * This function undoes what __dwc3_gadget_ep_enable did and also removes
+ * requests which are currently being processed by the hardware and those which
+ * are not yet scheduled.
+ *
  * Caller should take care of locking.
  */
 static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 {
 	struct dwc3		*dwc = dep->dwc;
 	u32			reg;
+	u32			mask;
 
-	dwc3_remove_requests(dwc, dep);
+	trace_dwc3_gadget_ep_disable(dep);
 
 	/* make sure HW endpoint isn't stalled */
 	if (dep->flags & DWC3_EP_STALL)
@@ -612,11 +1078,25 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	reg &= ~DWC3_DALEPENA_EP(dep->number);
 	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
+	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+
 	dep->stream_capable = false;
-	dep->endpoint.desc = NULL;
-	dep->comp_desc = NULL;
 	dep->type = 0;
-	dep->flags = 0;
+	mask = DWC3_EP_TXFIFO_RESIZED | DWC3_EP_RESOURCE_ALLOCATED;
+	/*
+	 * dwc3_remove_requests() can exit early if DWC3 EP delayed stop is
+	 * set.  Do not clear DEP flags, so that the end transfer command will
+	 * be reattempted during the next SETUP stage.
+	 */
+	if (dep->flags & DWC3_EP_DELAY_STOP)
+		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+	dep->flags &= mask;
+
+	/* Clear out the ep descriptors for non-ep0 */
+	if (dep->number > 1) {
+		dep->endpoint.comp_desc = NULL;
+		dep->endpoint.desc = NULL;
+	}
 
 	return 0;
 }
@@ -640,6 +1120,7 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 		const struct usb_endpoint_descriptor *desc)
 {
 	struct dwc3_ep			*dep;
+	struct dwc3			*dwc;
 	unsigned long			flags;
 	int				ret;
 
@@ -654,32 +1135,15 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 	}
 
 	dep = to_dwc3_ep(ep);
+	dwc = dep->dwc;
 
-	if (dep->flags & DWC3_EP_ENABLED) {
-		WARN(true, "%s is already enabled\n",
-				dep->name);
+	if (dev_WARN_ONCE(dwc->dev, dep->flags & DWC3_EP_ENABLED,
+					"%s is already enabled\n",
+					dep->name))
 		return 0;
-	}
-
-	switch (usb_endpoint_type(desc)) {
-	case USB_ENDPOINT_XFER_CONTROL:
-		strlcat(dep->name, "-control", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_ISOC:
-		strlcat(dep->name, "-isoc", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_BULK:
-		strlcat(dep->name, "-bulk", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_INT:
-		strlcat(dep->name, "-int", sizeof(dep->name));
-		break;
-	default:
-		dev_err(dep->dwc->dev, "invalid endpoint transfer type\n");
-	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_ep_enable(dep, desc, ep->comp_desc, false, false);
+	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -688,6 +1152,7 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 {
 	struct dwc3_ep			*dep;
+	struct dwc3			*dwc;
 	unsigned long			flags;
 	int				ret;
 
@@ -697,16 +1162,12 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 	}
 
 	dep = to_dwc3_ep(ep);
+	dwc = dep->dwc;
 
-	if (!(dep->flags & DWC3_EP_ENABLED)) {
-		WARN(true, "%s is already disabled\n",
-				dep->name);
+	if (dev_WARN_ONCE(dwc->dev, !(dep->flags & DWC3_EP_ENABLED),
+					"%s is already disabled\n",
+					dep->name))
 		return 0;
-	}
-
-	snprintf(dep->name, sizeof(dep->name), "ep%d%s",
-			dep->number >> 1,
-			(dep->number & 1) ? "in" : "out");
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_disable(dep);
@@ -716,7 +1177,7 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 }
 
 static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
-	gfp_t gfp_flags)
+		gfp_t gfp_flags)
 {
 	struct dwc3_request		*req;
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
@@ -725,8 +1186,12 @@ static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
 	if (!req)
 		return NULL;
 
+	req->direction	= dep->direction;
 	req->epnum	= dep->number;
 	req->dep	= dep;
+	req->status	= DWC3_REQUEST_STATUS_UNKNOWN;
+
+	trace_dwc3_alloc_request(req);
 
 	return &req->request;
 }
@@ -736,40 +1201,104 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
 {
 	struct dwc3_request		*req = to_dwc3_request(request);
 
+	trace_dwc3_free_request(req);
 	kfree(req);
 }
 
+/**
+ * dwc3_ep_prev_trb - returns the previous TRB in the ring
+ * @dep: The endpoint with the TRB ring
+ * @index: The index of the current TRB in the ring
+ *
+ * Returns the TRB prior to the one pointed to by the index. If the
+ * index is 0, we will wrap backwards, skip the link TRB, and return
+ * the one just before that.
+ */
+static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
+{
+	u8 tmp = index;
+
+	if (!tmp)
+		tmp = DWC3_TRB_NUM - 1;
+
+	return &dep->trb_pool[tmp - 1];
+}
+
+static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
+{
+	u8			trbs_left;
+
+	/*
+	 * If the enqueue & dequeue are equal then the TRB ring is either full
+	 * or empty. It's considered full when there are DWC3_TRB_NUM-1 of TRBs
+	 * pending to be processed by the driver.
+	 */
+	if (dep->trb_enqueue == dep->trb_dequeue) {
+		struct dwc3_request *req;
+
+		/*
+		 * If there is any request remained in the started_list with
+		 * active TRBs at this point, then there is no TRB available.
+		 */
+		req = next_request(&dep->started_list);
+		if (req && req->num_trbs)
+			return 0;
+
+		return DWC3_TRB_NUM - 1;
+	}
+
+	trbs_left = dep->trb_dequeue - dep->trb_enqueue;
+	trbs_left &= (DWC3_TRB_NUM - 1);
+
+	if (dep->trb_dequeue < dep->trb_enqueue)
+		trbs_left--;
+
+	return trbs_left;
+}
+
 /**
  * dwc3_prepare_one_trb - setup one TRB from one request
  * @dep: endpoint for which this request is prepared
  * @req: dwc3_request pointer
+ * @trb_length: buffer size of the TRB
+ * @chain: should this TRB be chained to the next?
+ * @node: only for isochronous endpoints. First TRB needs different type.
+ * @use_bounce_buffer: set to use bounce buffer
+ * @must_interrupt: set to interrupt on TRB completion
  */
 static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
-		struct dwc3_request *req, dma_addr_t dma,
-		unsigned length, unsigned last, unsigned chain, unsigned node)
+		struct dwc3_request *req, unsigned int trb_length,
+		unsigned int chain, unsigned int node, bool use_bounce_buffer,
+		bool must_interrupt)
 {
 	struct dwc3_trb		*trb;
+	dma_addr_t		dma;
+	unsigned int		stream_id = req->request.stream_id;
+	unsigned int		short_not_ok = req->request.short_not_ok;
+	unsigned int		no_interrupt = req->request.no_interrupt;
+	unsigned int		is_last = req->request.is_last;
+	struct dwc3		*dwc = dep->dwc;
+	struct usb_gadget	*gadget = dwc->gadget;
+	enum usb_device_speed	speed = gadget->speed;
 
-	dev_vdbg(dep->dwc->dev, "%s: req %p dma %08llx length %d%s%s\n",
-		 dep->name, req, (unsigned long long)dma,
-		 length, last ? " last" : "", chain ? " chain" : "");
+	if (use_bounce_buffer)
+		dma = dep->dwc->bounce_addr;
+	else if (req->request.num_sgs > 0)
+		dma = sg_dma_address(req->start_sg);
+	else
+		dma = req->request.dma;
 
-	trb = &dep->trb_pool[dep->free_slot & DWC3_TRB_MASK];
+	trb = &dep->trb_pool[dep->trb_enqueue];
 
 	if (!req->trb) {
-		dwc3_gadget_move_request_queued(req);
+		dwc3_gadget_move_started_request(req);
 		req->trb = trb;
 		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
-		req->start_slot = dep->free_slot & DWC3_TRB_MASK;
 	}
 
-	dep->free_slot++;
-	/* Skip the LINK-TRB on ISOC */
-	if (((dep->free_slot & DWC3_TRB_MASK) == DWC3_TRB_NUM - 1) &&
-			usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		dep->free_slot++;
+	req->num_trbs++;
 
-	trb->size = DWC3_TRB_SIZE_LENGTH(length);
+	trb->size = DWC3_TRB_SIZE_LENGTH(trb_length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
 
@@ -779,10 +1308,50 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		break;
 
 	case USB_ENDPOINT_XFER_ISOC:
-		if (!node)
+		if (!node) {
 			trb->ctrl = DWC3_TRBCTL_ISOCHRONOUS_FIRST;
-		else
+
+			/*
+			 * USB Specification 2.0 Section 5.9.2 states that: "If
+			 * there is only a single transaction in the microframe,
+			 * only a DATA0 data packet PID is used.  If there are
+			 * two transactions per microframe, DATA1 is used for
+			 * the first transaction data packet and DATA0 is used
+			 * for the second transaction data packet.  If there are
+			 * three transactions per microframe, DATA2 is used for
+			 * the first transaction data packet, DATA1 is used for
+			 * the second, and DATA0 is used for the third."
+			 *
+			 * IOW, we should satisfy the following cases:
+			 *
+			 * 1) length <= maxpacket
+			 *	- DATA0
+			 *
+			 * 2) maxpacket < length <= (2 * maxpacket)
+			 *	- DATA1, DATA0
+			 *
+			 * 3) (2 * maxpacket) < length <= (3 * maxpacket)
+			 *	- DATA2, DATA1, DATA0
+			 */
+			if (speed == USB_SPEED_HIGH) {
+				struct usb_ep *ep = &dep->endpoint;
+				unsigned int mult = 2;
+				unsigned int maxp = usb_endpoint_maxp(ep->desc);
+
+				if (req->request.length <= (2 * maxp))
+					mult--;
+
+				if (req->request.length <= maxp)
+					mult--;
+
+				trb->size |= DWC3_TRB_SIZE_PCM1(mult);
+			}
+		} else {
 			trb->ctrl = DWC3_TRBCTL_ISOCHRONOUS;
+		}
+
+		if (!no_interrupt && !chain)
+			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 		break;
 
 	case USB_ENDPOINT_XFER_BULK:
@@ -794,138 +1363,328 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		 * This is only possible with faulty memory because we
 		 * checked it already :)
 		 */
-		BUG();
+		dev_WARN(dwc->dev, "Unknown endpoint type %d\n",
+				usb_endpoint_type(dep->endpoint.desc));
 	}
 
-	if (!req->request.no_interrupt && !chain)
-		trb->ctrl |= DWC3_TRB_CTRL_IOC;
+	/*
+	 * Enable Continue on Short Packet
+	 * when endpoint is not a stream capable
+	 */
+	if (usb_endpoint_dir_out(dep->endpoint.desc)) {
+		if (!dep->stream_capable)
+			trb->ctrl |= DWC3_TRB_CTRL_CSP;
 
-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-		trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
+		if (short_not_ok)
+			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
+	}
+
+	/* All TRBs setup for MST must set CSP=1 when LST=0 */
+	if (dep->stream_capable && DWC3_MST_CAPABLE(&dwc->hwparams))
 		trb->ctrl |= DWC3_TRB_CTRL_CSP;
-	} else if (last) {
-		trb->ctrl |= DWC3_TRB_CTRL_LST;
-	}
+
+	if ((!no_interrupt && !chain) || must_interrupt)
+		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
+	else if (dep->stream_capable && is_last &&
+		 !DWC3_MST_CAPABLE(&dwc->hwparams))
+		trb->ctrl |= DWC3_TRB_CTRL_LST;
 
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
-		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(req->request.stream_id);
+		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
+	/*
+	 * As per data book 4.2.3.2TRB Control Bit Rules section
+	 *
+	 * The controller autonomously checks the HWO field of a TRB to determine if the
+	 * entire TRB is valid. Therefore, software must ensure that the rest of the TRB
+	 * is valid before setting the HWO field to '1'. In most systems, this means that
+	 * software must update the fourth DWORD of a TRB last.
+	 *
+	 * However there is a possibility of CPU re-ordering here which can cause
+	 * controller to observe the HWO bit set prematurely.
+	 * Add a write memory barrier to prevent CPU re-ordering.
+	 */
+	wmb();
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
-	dwc3_flush_cache((uintptr_t)dma, length);
-	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
+	dwc3_ep_inc_enq(dep);
+
+	trace_dwc3_prepare_trb(dep, trb);
+}
+
+static bool dwc3_needs_extra_trb(struct dwc3_ep *dep, struct dwc3_request *req)
+{
+	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+	unsigned int rem = req->request.length % maxp;
+
+	if ((req->request.length && req->request.zero && !rem &&
+			!usb_endpoint_xfer_isoc(dep->endpoint.desc)) ||
+			(!req->direction && rem))
+		return true;
+
+	return false;
+}
+
+/**
+ * dwc3_prepare_last_sg - prepare TRBs for the last SG entry
+ * @dep: The endpoint that the request belongs to
+ * @req: The request to prepare
+ * @entry_length: The last SG entry size
+ * @node: Indicates whether this is not the first entry (for isoc only)
+ *
+ * Return the number of TRBs prepared.
+ */
+static int dwc3_prepare_last_sg(struct dwc3_ep *dep,
+		struct dwc3_request *req, unsigned int entry_length,
+		unsigned int node)
+{
+	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+	unsigned int rem = req->request.length % maxp;
+	unsigned int num_trbs = 1;
+	bool needs_extra_trb;
+
+	if (dwc3_needs_extra_trb(dep, req))
+		num_trbs++;
+
+	if (dwc3_calc_trbs_left(dep) < num_trbs)
+		return 0;
+
+	needs_extra_trb = num_trbs > 1;
+
+	/* Prepare a normal TRB */
+	if (req->direction || req->request.length)
+		dwc3_prepare_one_trb(dep, req, entry_length,
+				needs_extra_trb, node, false, false);
+
+	/* Prepare extra TRBs for ZLP and MPS OUT transfer alignment */
+	if ((!req->direction && !req->request.length) || needs_extra_trb)
+		dwc3_prepare_one_trb(dep, req,
+				req->direction ? 0 : maxp - rem,
+				false, 1, true, false);
+
+	return num_trbs;
+}
+
+static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
+		struct dwc3_request *req)
+{
+	struct scatterlist *sg = req->start_sg;
+	struct scatterlist *s;
+	int		i;
+	unsigned int length = req->request.length;
+	unsigned int remaining = req->num_pending_sgs;
+	unsigned int num_queued_sgs = req->request.num_mapped_sgs - remaining;
+	unsigned int num_trbs = req->num_trbs;
+	bool needs_extra_trb = dwc3_needs_extra_trb(dep, req);
+
+	/*
+	 * If we resume preparing the request, then get the remaining length of
+	 * the request and resume where we left off.
+	 */
+	for_each_sg(req->request.sg, s, num_queued_sgs, i)
+		length -= sg_dma_len(s);
+
+	for_each_sg(sg, s, remaining, i) {
+		unsigned int num_trbs_left = dwc3_calc_trbs_left(dep);
+		unsigned int trb_length;
+		bool must_interrupt = false;
+		bool last_sg = false;
+
+		trb_length = min_t(unsigned int, length, sg_dma_len(s));
+
+		length -= trb_length;
+
+		/*
+		 * IOMMU driver is coalescing the list of sgs which shares a
+		 * page boundary into one and giving it to USB driver. With
+		 * this the number of sgs mapped is not equal to the number of
+		 * sgs passed. So mark the chain bit to false if it isthe last
+		 * mapped sg.
+		 */
+		if ((i == remaining - 1) || !length)
+			last_sg = true;
+
+		if (!num_trbs_left)
+			break;
+
+		if (last_sg) {
+			if (!dwc3_prepare_last_sg(dep, req, trb_length, i))
+				break;
+		} else {
+			/*
+			 * Look ahead to check if we have enough TRBs for the
+			 * next SG entry. If not, set interrupt on this TRB to
+			 * resume preparing the next SG entry when more TRBs are
+			 * free.
+			 */
+			if (num_trbs_left == 1 || (needs_extra_trb &&
+					num_trbs_left <= 2 &&
+					sg_dma_len(sg_next(s)) >= length)) {
+				struct dwc3_request *r;
+
+				/* Check if previous requests already set IOC */
+				list_for_each_entry(r, &dep->started_list, list) {
+					if (r != req && !r->request.no_interrupt)
+						break;
+
+					if (r == req)
+						must_interrupt = true;
+				}
+			}
+
+			dwc3_prepare_one_trb(dep, req, trb_length, 1, i, false,
+					must_interrupt);
+		}
+
+		/*
+		 * There can be a situation where all sgs in sglist are not
+		 * queued because of insufficient trb number. To handle this
+		 * case, update start_sg to next sg to be queued, so that
+		 * we have free trbs we can continue queuing from where we
+		 * previously stopped
+		 */
+		if (!last_sg)
+			req->start_sg = sg_next(s);
+
+		req->num_pending_sgs--;
+
+		/*
+		 * The number of pending SG entries may not correspond to the
+		 * number of mapped SG entries. If all the data are queued, then
+		 * don't include unused SG entries.
+		 */
+		if (length == 0) {
+			req->num_pending_sgs = 0;
+			break;
+		}
+
+		if (must_interrupt)
+			break;
+	}
+
+	return req->num_trbs - num_trbs;
+}
+
+static int dwc3_prepare_trbs_linear(struct dwc3_ep *dep,
+		struct dwc3_request *req)
+{
+	return dwc3_prepare_last_sg(dep, req, req->request.length, 0);
 }
 
 /*
  * dwc3_prepare_trbs - setup TRBs from requests
  * @dep: endpoint for which requests are being prepared
- * @starting: true if the endpoint is idle and no requests are queued.
  *
  * The function goes through the requests list and sets up TRBs for the
  * transfers. The function returns once there are no more TRBs available or
  * it runs out of requests.
+ *
+ * Returns the number of TRBs prepared or negative errno.
  */
-static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
+static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 {
 	struct dwc3_request	*req, *n;
-	u32			trbs_left;
-	u32			max;
+	int			ret = 0;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
 
-	/* the first request must not be queued */
-	trbs_left = (dep->busy_slot - dep->free_slot) & DWC3_TRB_MASK;
-
-	/* Can't wrap around on a non-isoc EP since there's no link TRB */
-	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-		max = DWC3_TRB_NUM - (dep->free_slot & DWC3_TRB_MASK);
-		if (trbs_left > max)
-			trbs_left = max;
-	}
-
 	/*
-	 * If busy & slot are equal than it is either full or empty. If we are
-	 * starting to process requests then we are empty. Otherwise we are
-	 * full and don't do anything
+	 * We can get in a situation where there's a request in the started list
+	 * but there weren't enough TRBs to fully kick it in the first time
+	 * around, so it has been waiting for more TRBs to be freed up.
+	 *
+	 * In that case, we should check if we have a request with pending_sgs
+	 * in the started list and prepare TRBs for that request first,
+	 * otherwise we will prepare TRBs completely out of order and that will
+	 * break things.
 	 */
-	if (!trbs_left) {
-		if (!starting)
-			return;
-		trbs_left = DWC3_TRB_NUM;
+	list_for_each_entry(req, &dep->started_list, list) {
+		if (req->num_pending_sgs > 0) {
+			ret = dwc3_prepare_trbs_sg(dep, req);
+			if (!ret || req->num_pending_sgs)
+				return ret;
+		}
+
+		if (!dwc3_calc_trbs_left(dep))
+			return ret;
+
 		/*
-		 * In case we start from scratch, we queue the ISOC requests
-		 * starting from slot 1. This is done because we use ring
-		 * buffer and have no LST bit to stop us. Instead, we place
-		 * IOC bit every TRB_NUM/4. We try to avoid having an interrupt
-		 * after the first request so we start at slot 1 and have
-		 * 7 requests proceed before we hit the first IOC.
-		 * Other transfer types don't use the ring buffer and are
-		 * processed from the first TRB until the last one. Since we
-		 * don't wrap around we have to start at the beginning.
+		 * Don't prepare beyond a transfer. In DWC_usb32, its transfer
+		 * burst capability may try to read and use TRBs beyond the
+		 * active transfer instead of stopping.
 		 */
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			dep->busy_slot = 1;
-			dep->free_slot = 1;
+		if (dep->stream_capable && req->request.is_last &&
+		    !DWC3_MST_CAPABLE(&dep->dwc->hwparams))
+			return ret;
+	}
+
+	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
+		struct dwc3	*dwc = dep->dwc;
+
+		ret = usb_gadget_map_request_by_dev(dwc->sysdev, &req->request,
+						    dep->direction);
+		if (ret)
+			return ret;
+
+		req->start_sg		= req->request.sg;
+		req->num_pending_sgs	= req->request.num_mapped_sgs;
+
+		if (req->num_pending_sgs > 0) {
+			ret = dwc3_prepare_trbs_sg(dep, req);
+			if (req->num_pending_sgs)
+				return ret;
 		} else {
-			dep->busy_slot = 0;
-			dep->free_slot = 0;
+			ret = dwc3_prepare_trbs_linear(dep, req);
 		}
-	}
-
-	/* The last TRB is a link TRB, not used for xfer */
-	if ((trbs_left <= 1) && usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		return;
-
-	list_for_each_entry_safe(req, n, &dep->request_list, list) {
-		unsigned	length;
-		dma_addr_t	dma;
 
-		dma = req->request.dma;
-		length = req->request.length;
-
-		dwc3_prepare_one_trb(dep, req, dma, length,
-				     true, false, 0);
-
-		break;
+		if (!ret || !dwc3_calc_trbs_left(dep))
+			return ret;
+
+		/*
+		 * Don't prepare beyond a transfer. In DWC_usb32, its transfer
+		 * burst capability may try to read and use TRBs beyond the
+		 * active transfer instead of stopping.
+		 */
+		if (dep->stream_capable && req->request.is_last &&
+		    !DWC3_MST_CAPABLE(&dwc->hwparams))
+			return ret;
 	}
+
+	return ret;
 }
 
-static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
-		int start_new)
+static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep);
+
+static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_request		*req;
-	struct dwc3			*dwc = dep->dwc;
+	int				starting;
 	int				ret;
 	u32				cmd;
 
-	if (start_new && (dep->flags & DWC3_EP_BUSY)) {
-		dev_vdbg(dwc->dev, "%s: endpoint busy\n", dep->name);
-		return -EBUSY;
-	}
-	dep->flags &= ~DWC3_EP_PENDING_REQUEST;
-
 	/*
-	 * If we are getting here after a short-out-packet we don't enqueue any
-	 * new requests as we try to set the IOC bit only on the last request.
+	 * Note that it's normal to have no new TRBs prepared (i.e. ret == 0).
+	 * This happens when we need to stop and restart a transfer such as in
+	 * the case of reinitiating a stream or retrying an isoc transfer.
 	 */
-	if (start_new) {
-		if (list_empty(&dep->req_queued))
-			dwc3_prepare_trbs(dep, start_new);
+	ret = dwc3_prepare_trbs(dep);
+	if (ret < 0)
+		return ret;
+
+	starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED);
 
-		/* req points to the first request which will be sent */
-		req = next_request(&dep->req_queued);
-	} else {
-		dwc3_prepare_trbs(dep, start_new);
+	/*
+	 * If there's no new TRB prepared and we don't need to restart a
+	 * transfer, there's no need to update the transfer.
+	 */
+	if (!ret && !starting)
+		return ret;
 
-		/*
-		 * req points to the first request where HWO changed from 0 to 1
-		 */
-		req = next_request(&dep->req_queued);
-	}
+	req = next_request(&dep->started_list);
 	if (!req) {
 		dep->flags |= DWC3_EP_PENDING_REQUEST;
 		return 0;
@@ -933,171 +1692,343 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
 
 	memset(&params, 0, sizeof(params));
 
-	if (start_new) {
+	if (starting) {
 		params.param0 = upper_32_bits(req->trb_dma);
 		params.param1 = lower_32_bits(req->trb_dma);
 		cmd = DWC3_DEPCMD_STARTTRANSFER;
+
+		if (dep->stream_capable)
+			cmd |= DWC3_DEPCMD_PARAM(req->request.stream_id);
+
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			cmd |= DWC3_DEPCMD_PARAM(dep->frame_number);
 	} else {
-		cmd = DWC3_DEPCMD_UPDATETRANSFER;
+		cmd = DWC3_DEPCMD_UPDATETRANSFER |
+			DWC3_DEPCMD_PARAM(dep->resource_index);
 	}
 
-	cmd |= DWC3_DEPCMD_PARAM(cmd_param);
-	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	if (ret < 0) {
-		dev_dbg(dwc->dev, "failed to send STARTTRANSFER command\n");
-
-		/*
-		 * FIXME we need to iterate over the list of requests
-		 * here and stop, unmap, free and del each of the linked
-		 * requests instead of what we do now.
-		 */
-		usb_gadget_unmap_request(&dwc->gadget, &req->request,
-				req->direction);
-		list_del(&req->list);
+		struct dwc3_request *tmp;
+
+		if (ret == -EAGAIN)
+			return ret;
+
+		dwc3_stop_active_transfer(dep, true, true);
+
+		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
+
+		/* If ep isn't started, then there's no end transfer pending */
+		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
+			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+
 		return ret;
 	}
 
-	dep->flags |= DWC3_EP_BUSY;
-
-	if (start_new) {
-		dep->resource_index = dwc3_gadget_ep_get_transfer_index(dwc,
-				dep->number);
-		WARN_ON_ONCE(!dep->resource_index);
-	}
+	if (dep->stream_capable && req->request.is_last &&
+	    !DWC3_MST_CAPABLE(&dep->dwc->hwparams))
+		dep->flags |= DWC3_EP_WAIT_TRANSFER_COMPLETE;
 
 	return 0;
 }
 
-static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
-		struct dwc3_ep *dep, u32 cur_uf)
+static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
 {
-	u32 uf;
+	u32			reg;
 
-	if (list_empty(&dep->request_list)) {
-		dev_vdbg(dwc->dev, "ISOC ep %s run out for requests.\n",
-			dep->name);
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	return DWC3_DSTS_SOFFN(reg);
+}
+
+/**
+ * __dwc3_stop_active_transfer - stop the current active transfer
+ * @dep: isoc endpoint
+ * @force: set forcerm bit in the command
+ * @interrupt: command complete interrupt after End Transfer command
+ *
+ * When setting force, the ForceRM bit will be set. In that case
+ * the controller won't update the TRB progress on command
+ * completion. It also won't clear the HWO bit in the TRB.
+ * The command will also not complete immediately in that case.
+ */
+static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	u32 cmd;
+	int ret;
+
+	cmd = DWC3_DEPCMD_ENDTRANSFER;
+	cmd |= force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
+	cmd |= interrupt ? DWC3_DEPCMD_CMDIOC : 0;
+	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
+	memset(&params, 0, sizeof(params));
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	/*
+	 * If the End Transfer command was timed out while the device is
+	 * not in SETUP phase, it's possible that an incoming Setup packet
+	 * may prevent the command's completion. Let's retry when the
+	 * ep0state returns to EP0_SETUP_PHASE.
+	 */
+	if (ret == -ETIMEDOUT && dep->dwc->ep0state != EP0_SETUP_PHASE) {
+		dep->flags |= DWC3_EP_DELAY_STOP;
+		return 0;
+	}
+	WARN_ON_ONCE(ret);
+	dep->resource_index = 0;
+
+	if (!interrupt)
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+	else if (!ret)
+		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+
+	dep->flags &= ~DWC3_EP_DELAY_STOP;
+	return ret;
+}
+
+/**
+ * dwc3_gadget_start_isoc_quirk - workaround invalid frame number
+ * @dep: isoc endpoint
+ *
+ * This function tests for the correct combination of BIT[15:14] from the 16-bit
+ * microframe number reported by the XferNotReady event for the future frame
+ * number to start the isoc transfer.
+ *
+ * In DWC_usb31 version 1.70a-ea06 and prior, for highspeed and fullspeed
+ * isochronous IN, BIT[15:14] of the 16-bit microframe number reported by the
+ * XferNotReady event are invalid. The driver uses this number to schedule the
+ * isochronous transfer and passes it to the START TRANSFER command. Because
+ * this number is invalid, the command may fail. If BIT[15:14] matches the
+ * internal 16-bit microframe, the START TRANSFER command will pass and the
+ * transfer will start at the scheduled time, if it is off by 1, the command
+ * will still pass, but the transfer will start 2 seconds in the future. For all
+ * other conditions, the START TRANSFER command will fail with bus-expiry.
+ *
+ * In order to workaround this issue, we can test for the correct combination of
+ * BIT[15:14] by sending START TRANSFER commands with different values of
+ * BIT[15:14]: 'b00, 'b01, 'b10, and 'b11. Each combination is 2^14 uframe apart
+ * (or 2 seconds). 4 seconds into the future will result in a bus-expiry status.
+ * As the result, within the 4 possible combinations for BIT[15:14], there will
+ * be 2 successful and 2 failure START COMMAND status. One of the 2 successful
+ * command status will result in a 2-second delay start. The smaller BIT[15:14]
+ * value is the correct combination.
+ *
+ * Since there are only 4 outcomes and the results are ordered, we can simply
+ * test 2 START TRANSFER commands with BIT[15:14] combinations 'b00 and 'b01 to
+ * deduce the smaller successful combination.
+ *
+ * Let test0 = test status for combination 'b00 and test1 = test status for 'b01
+ * of BIT[15:14]. The correct combination is as follow:
+ *
+ * if test0 fails and test1 passes, BIT[15:14] is 'b01
+ * if test0 fails and test1 fails, BIT[15:14] is 'b10
+ * if test0 passes and test1 fails, BIT[15:14] is 'b11
+ * if test0 passes and test1 passes, BIT[15:14] is 'b00
+ *
+ * Synopsys STAR 9001202023: Wrong microframe number for isochronous IN
+ * endpoints.
+ */
+static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
+{
+	int cmd_status = 0;
+	bool test0;
+	bool test1;
+
+	while (dep->combo_num < 2) {
+		struct dwc3_gadget_ep_cmd_params params;
+		u32 test_frame_number;
+		u32 cmd;
+
+		/*
+		 * Check if we can start isoc transfer on the next interval or
+		 * 4 uframes in the future with BIT[15:14] as dep->combo_num
+		 */
+		test_frame_number = dep->frame_number & DWC3_FRNUMBER_MASK;
+		test_frame_number |= dep->combo_num << 14;
+		test_frame_number += max_t(u32, 4, dep->interval);
+
+		params.param0 = upper_32_bits(dep->dwc->bounce_addr);
+		params.param1 = lower_32_bits(dep->dwc->bounce_addr);
+
+		cmd = DWC3_DEPCMD_STARTTRANSFER;
+		cmd |= DWC3_DEPCMD_PARAM(test_frame_number);
+		cmd_status = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+
+		/* Redo if some other failure beside bus-expiry is received */
+		if (cmd_status && cmd_status != -EAGAIN) {
+			dep->start_cmd_status = 0;
+			dep->combo_num = 0;
+			return 0;
+		}
+
+		/* Store the first test status */
+		if (dep->combo_num == 0)
+			dep->start_cmd_status = cmd_status;
+
+		dep->combo_num++;
+
+		/*
+		 * End the transfer if the START_TRANSFER command is successful
+		 * to wait for the next XferNotReady to test the command again
+		 */
+		if (cmd_status == 0) {
+			dwc3_stop_active_transfer(dep, true, true);
+			return 0;
+		}
+	}
+
+	/* test0 and test1 are both completed at this point */
+	test0 = (dep->start_cmd_status == 0);
+	test1 = (cmd_status == 0);
+
+	if (!test0 && test1)
+		dep->combo_num = 1;
+	else if (!test0 && !test1)
+		dep->combo_num = 2;
+	else if (test0 && !test1)
+		dep->combo_num = 3;
+	else if (test0 && test1)
+		dep->combo_num = 0;
+
+	dep->frame_number &= DWC3_FRNUMBER_MASK;
+	dep->frame_number |= dep->combo_num << 14;
+	dep->frame_number += max_t(u32, 4, dep->interval);
+
+	/* Reinitialize test variables */
+	dep->start_cmd_status = 0;
+	dep->combo_num = 0;
+
+	return __dwc3_gadget_kick_transfer(dep);
+}
+
+static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
+{
+	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
+	struct dwc3 *dwc = dep->dwc;
+	int ret;
+	int i;
+
+	if (list_empty(&dep->pending_list) &&
+	    list_empty(&dep->started_list)) {
 		dep->flags |= DWC3_EP_PENDING_REQUEST;
-		return;
+		return -EAGAIN;
 	}
 
-	/* 4 micro frames in the future */
-	uf = cur_uf + dep->interval * 4;
+	if (!dwc->dis_start_transfer_quirk &&
+	    (DWC3_VER_IS_PRIOR(DWC31, 170A) ||
+	     DWC3_VER_TYPE_IS_WITHIN(DWC31, 170A, EA01, EA06))) {
+		if (dwc->gadget->speed <= USB_SPEED_HIGH && dep->direction)
+			return dwc3_gadget_start_isoc_quirk(dep);
+	}
+
+	if (desc->bInterval <= 14 &&
+	    dwc->gadget->speed >= USB_SPEED_HIGH) {
+		u32 frame = __dwc3_gadget_get_frame(dwc);
+		bool rollover = frame <
+				(dep->frame_number & DWC3_FRNUMBER_MASK);
+
+		/*
+		 * frame_number is set from XferNotReady and may be already
+		 * out of date. DSTS only provides the lower 14 bit of the
+		 * current frame number. So add the upper two bits of
+		 * frame_number and handle a possible rollover.
+		 * This will provide the correct frame_number unless more than
+		 * rollover has happened since XferNotReady.
+		 */
+
+		dep->frame_number = (dep->frame_number & ~DWC3_FRNUMBER_MASK) |
+				     frame;
+		if (rollover)
+			dep->frame_number += BIT(14);
+	}
+
+	for (i = 0; i < DWC3_ISOC_MAX_RETRIES; i++) {
+		int future_interval = i + 1;
 
-	__dwc3_gadget_kick_transfer(dep, uf, 1);
-}
+		/* Give the controller at least 500us to schedule transfers */
+		if (desc->bInterval < 3)
+			future_interval += 3 - desc->bInterval;
 
-static void dwc3_gadget_start_isoc(struct dwc3 *dwc,
-		struct dwc3_ep *dep, const struct dwc3_event_depevt *event)
-{
-	u32 cur_uf, mask;
+		dep->frame_number = DWC3_ALIGN_FRAME(dep, future_interval);
+
+		ret = __dwc3_gadget_kick_transfer(dep);
+		if (ret != -EAGAIN)
+			break;
+	}
 
-	mask = ~(dep->interval - 1);
-	cur_uf = event->parameters & mask;
+	/*
+	 * After a number of unsuccessful start attempts due to bus-expiry
+	 * status, issue END_TRANSFER command and retry on the next XferNotReady
+	 * event.
+	 */
+	if (ret == -EAGAIN)
+		ret = __dwc3_stop_active_transfer(dep, false, true);
 
-	__dwc3_gadget_start_isoc(dwc, dep, cur_uf);
+	return ret;
 }
 
 static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	struct dwc3		*dwc = dep->dwc;
-	int			ret;
+
+	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
+		dev_dbg(dwc->dev, "%s: can't queue to disabled endpoint\n",
+				dep->name);
+		return -ESHUTDOWN;
+	}
+
+	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
+				&req->request, req->dep->name))
+		return -EINVAL;
+
+	if (WARN(req->status < DWC3_REQUEST_STATUS_COMPLETED,
+				"%s: request %p already in flight\n",
+				dep->name, &req->request))
+		return -EINVAL;
+
+	pm_runtime_get(dwc->dev);
 
 	req->request.actual	= 0;
 	req->request.status	= -EINPROGRESS;
-	req->direction		= dep->direction;
-	req->epnum		= dep->number;
 
-	/*
-	 * DWC3 hangs on OUT requests smaller than maxpacket size,
-	 * so HACK the request length
-	 */
-	if (dep->direction == 0 &&
-	    req->request.length < dep->endpoint.maxpacket)
-		req->request.length = dep->endpoint.maxpacket;
+	trace_dwc3_ep_queue(req);
+
+	list_add_tail(&req->list, &dep->pending_list);
+	req->status = DWC3_REQUEST_STATUS_QUEUED;
+
+	if (dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)
+		return 0;
 
 	/*
-	 * We only add to our list of requests now and
-	 * start consuming the list once we get XferNotReady
-	 * IRQ.
-	 *
-	 * That way, we avoid doing anything that we don't need
-	 * to do now and defer it until the point we receive a
-	 * particular token from the Host side.
-	 *
-	 * This will also avoid Host cancelling URBs due to too
-	 * many NAKs.
+	 * Start the transfer only after the END_TRANSFER is completed
+	 * and endpoint STALL is cleared.
 	 */
-	ret = usb_gadget_map_request(&dwc->gadget, &req->request,
-			dep->direction);
-	if (ret)
-		return ret;
-
-	list_add_tail(&req->list, &dep->request_list);
+	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
+	    (dep->flags & DWC3_EP_WEDGE) ||
+	    (dep->flags & DWC3_EP_DELAY_STOP) ||
+	    (dep->flags & DWC3_EP_STALL)) {
+		dep->flags |= DWC3_EP_DELAY_START;
+		return 0;
+	}
 
 	/*
-	 * There are a few special cases:
-	 *
-	 * 1. XferNotReady with empty list of requests. We need to kick the
-	 *    transfer here in that situation, otherwise we will be NAKing
-	 *    forever. If we get XferNotReady before gadget driver has a
-	 *    chance to queue a request, we will ACK the IRQ but won't be
-	 *    able to receive the data until the next request is queued.
-	 *    The following code is handling exactly that.
+	 * NOTICE: Isochronous endpoints should NEVER be prestarted. We must
+	 * wait for a XferNotReady event so we will know what's the current
+	 * (micro-)frame number.
 	 *
+	 * Without this trick, we are very, very likely gonna get Bus Expiry
+	 * errors which will force us issue EndTransfer command.
 	 */
-	if (dep->flags & DWC3_EP_PENDING_REQUEST) {
-		/*
-		 * If xfernotready is already elapsed and it is a case
-		 * of isoc transfer, then issue END TRANSFER, so that
-		 * you can receive xfernotready again and can have
-		 * notion of current microframe.
-		 */
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			if (list_empty(&dep->req_queued)) {
-				dwc3_stop_active_transfer(dwc, dep->number, true);
-				dep->flags = DWC3_EP_ENABLED;
-			}
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+		if (!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
+			if ((dep->flags & DWC3_EP_PENDING_REQUEST))
+				return __dwc3_gadget_start_isoc(dep);
+
 			return 0;
 		}
-
-		ret = __dwc3_gadget_kick_transfer(dep, 0, true);
-		if (ret && ret != -EBUSY)
-			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
-					dep->name);
-		return ret;
-	}
-
-	/*
-	 * 2. XferInProgress on Isoc EP with an active transfer. We need to
-	 *    kick the transfer here after queuing a request, otherwise the
-	 *    core may not see the modified TRB(s).
-	 */
-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-			(dep->flags & DWC3_EP_BUSY) &&
-			!(dep->flags & DWC3_EP_MISSED_ISOC)) {
-		WARN_ON_ONCE(!dep->resource_index);
-		ret = __dwc3_gadget_kick_transfer(dep, dep->resource_index,
-				false);
-		if (ret && ret != -EBUSY)
-			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
-					dep->name);
-		return ret;
 	}
 
-	/*
-	 * 4. Stream Capable Bulk Endpoints. We need to start the transfer
-	 * right away, otherwise host will not know we have streams to be
-	 * handled.
-	 */
-	if (dep->stream_capable) {
-		int	ret;
-
-		ret = __dwc3_gadget_kick_transfer(dep, 0, true);
-		if (ret && ret != -EBUSY) {
-			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
-					dep->name);
-		}
-	}
+	__dwc3_gadget_kick_transfer(dep);
 
 	return 0;
 }
@@ -1107,38 +2038,80 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 {
 	struct dwc3_request		*req = to_dwc3_request(request);
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
+	struct dwc3			*dwc = dep->dwc;
 
 	unsigned long			flags;
 
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dep->endpoint.desc) {
-		dev_dbg(dep->dwc->dev,
-			"trying to queue request %p to disabled %s\n", request,
-			ep->name);
-		ret = -ESHUTDOWN;
-		goto out;
-	}
-
-	if (req->dep != dep) {
-		WARN(true, "request %p belongs to '%s'\n", request,
-		     req->dep->name);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	dev_vdbg(dep->dwc->dev, "queing request %p to %s length %d\n",
-		 request, ep->name, request->length);
-
 	ret = __dwc3_gadget_ep_queue(dep, req);
-
-out:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
 }
 
+static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *req)
+{
+	int i;
+
+	/* If req->trb is not set, then the request has not started */
+	if (!req->trb)
+		return;
+
+	/*
+	 * If request was already started, this means we had to
+	 * stop the transfer. With that we also need to ignore
+	 * all TRBs used by the request, however TRBs can only
+	 * be modified after completion of END_TRANSFER
+	 * command. So what we do here is that we wait for
+	 * END_TRANSFER completion and only after that, we jump
+	 * over TRBs by clearing HWO and incrementing dequeue
+	 * pointer.
+	 */
+	for (i = 0; i < req->num_trbs; i++) {
+		struct dwc3_trb *trb;
+
+		trb = &dep->trb_pool[dep->trb_dequeue];
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+		dwc3_ep_inc_deq(dep);
+	}
+
+	req->num_trbs = 0;
+}
+
+static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
+{
+	struct dwc3_request		*req;
+	struct dwc3			*dwc = dep->dwc;
+
+	while (!list_empty(&dep->cancelled_list)) {
+		req = next_request(&dep->cancelled_list);
+		dwc3_gadget_ep_skip_trbs(dep, req);
+		switch (req->status) {
+		case DWC3_REQUEST_STATUS_DISCONNECTED:
+			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+			break;
+		case DWC3_REQUEST_STATUS_DEQUEUED:
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			break;
+		case DWC3_REQUEST_STATUS_STALLED:
+			dwc3_gadget_giveback(dep, req, -EPIPE);
+			break;
+		default:
+			dev_err(dwc->dev, "request cancelled with wrong reason:%d\n", req->status);
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			break;
+		}
+		/*
+		 * The endpoint is disabled, let the dwc3_remove_requests()
+		 * handle the cleanup.
+		 */
+		if (!dep->endpoint.desc)
+			break;
+	}
+}
+
 static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		struct usb_request *request)
 {
@@ -1151,34 +2124,57 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 	unsigned long			flags;
 	int				ret = 0;
 
+	trace_dwc3_ep_dequeue(req);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	list_for_each_entry(r, &dep->request_list, list) {
+	list_for_each_entry(r, &dep->cancelled_list, list) {
 		if (r == req)
-			break;
+			goto out;
 	}
 
-	if (r != req) {
-		list_for_each_entry(r, &dep->req_queued, list) {
-			if (r == req)
-				break;
+	list_for_each_entry(r, &dep->pending_list, list) {
+		if (r == req) {
+			/*
+			 * Explicitly check for EP0/1 as dequeue for those
+			 * EPs need to be handled differently.  Control EP
+			 * only deals with one USB req, and giveback will
+			 * occur during dwc3_ep0_stall_and_restart().  EP0
+			 * requests are never added to started_list.
+			 */
+			if (dep->number > 1)
+				dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			else
+				dwc3_ep0_reset_state(dwc);
+			goto out;
 		}
+	}
+
+	list_for_each_entry(r, &dep->started_list, list) {
 		if (r == req) {
+			struct dwc3_request *t;
+
 			/* wait until it is processed */
-			dwc3_stop_active_transfer(dwc, dep->number, true);
-			goto out1;
+			dwc3_stop_active_transfer(dep, true, true);
+
+			/*
+			 * Remove any started request if the transfer is
+			 * cancelled.
+			 */
+			list_for_each_entry_safe(r, t, &dep->started_list, list)
+				dwc3_gadget_move_cancelled_request(r,
+						DWC3_REQUEST_STATUS_DEQUEUED);
+
+			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
+
+			goto out;
 		}
-		dev_err(dwc->dev, "request %p was not queued to %s\n",
-				request, ep->name);
-		ret = -EINVAL;
-		goto out0;
 	}
 
-out1:
-	/* giveback the request */
-	dwc3_gadget_giveback(dep, req, -ECONNRESET);
-
-out0:
+	dev_err(dwc->dev, "request %p was not queued to %s\n",
+		request, ep->name);
+	ret = -EINVAL;
+out:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -1188,6 +2184,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 {
 	struct dwc3_gadget_ep_cmd_params	params;
 	struct dwc3				*dwc = dep->dwc;
+	struct dwc3_request			*req;
+	struct dwc3_request			*tmp;
 	int					ret;
 
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
@@ -1198,29 +2196,72 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 	memset(&params, 0x00, sizeof(params));
 
 	if (value) {
-		if (!protocol && ((dep->direction && dep->flags & DWC3_EP_BUSY) ||
-				(!list_empty(&dep->req_queued) ||
-				 !list_empty(&dep->request_list)))) {
-			dev_dbg(dwc->dev, "%s: pending request, cannot halt\n",
-					dep->name);
+		struct dwc3_trb *trb;
+
+		unsigned int transfer_in_flight;
+		unsigned int started;
+
+		if (dep->number > 1)
+			trb = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
+		else
+			trb = &dwc->ep0_trb[dep->trb_enqueue];
+
+		transfer_in_flight = trb->ctrl & DWC3_TRB_CTRL_HWO;
+		started = !list_empty(&dep->started_list);
+
+		if (!protocol && ((dep->direction && transfer_in_flight) ||
+				(!dep->direction && started))) {
 			return -EAGAIN;
 		}
 
-		ret = dwc3_send_gadget_ep_cmd(dwc, dep->number,
-			DWC3_DEPCMD_SETSTALL, &params);
+		ret = dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETSTALL,
+				&params);
 		if (ret)
 			dev_err(dwc->dev, "failed to set STALL on %s\n",
 					dep->name);
 		else
 			dep->flags |= DWC3_EP_STALL;
 	} else {
-		ret = dwc3_send_gadget_ep_cmd(dwc, dep->number,
-			DWC3_DEPCMD_CLEARSTALL, &params);
-		if (ret)
-			dev_err(dwc->dev, "failed to clear STALL on %s\n",
-					dep->name);
-		else
+		/*
+		 * Don't issue CLEAR_STALL command to control endpoints. The
+		 * controller automatically clears the STALL when it receives
+		 * the SETUP token.
+		 */
+		if (dep->number <= 1) {
 			dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
+			return 0;
+		}
+
+		dwc3_stop_active_transfer(dep, true, true);
+
+		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
+
+		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
+		    (dep->flags & DWC3_EP_DELAY_STOP)) {
+			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
+			if (protocol)
+				dwc->clear_stall_protocol = dep->number;
+
+			return 0;
+		}
+
+		dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+
+		ret = dwc3_send_clear_stall_ep_cmd(dep);
+		if (ret) {
+			dev_err(dwc->dev, "failed to clear STALL on %s\n",
+					dep->name);
+			return ret;
+		}
+
+		dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
+
+		if ((dep->flags & DWC3_EP_DELAY_START) &&
+		    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			__dwc3_gadget_kick_transfer(dep);
+
+		dep->flags &= ~DWC3_EP_DELAY_START;
 	}
 
 	return ret;
@@ -1229,6 +2270,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 static int dwc3_gadget_ep_set_halt(struct usb_ep *ep, int value)
 {
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
+	struct dwc3			*dwc = dep->dwc;
 
 	unsigned long			flags;
 
@@ -1244,6 +2286,7 @@ static int dwc3_gadget_ep_set_halt(struct usb_ep *ep, int value)
 static int dwc3_gadget_ep_set_wedge(struct usb_ep *ep)
 {
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
+	struct dwc3			*dwc = dep->dwc;
 	unsigned long			flags;
 	int				ret;
 
@@ -1291,30 +2334,35 @@ static const struct usb_ep_ops dwc3_gadget_ep_ops = {
 
 /* -------------------------------------------------------------------------- */
 
+static void dwc3_gadget_enable_linksts_evts(struct dwc3 *dwc, bool set)
+{
+	u32 reg;
+
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
+		return;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DEVTEN);
+	if (set)
+		reg |= DWC3_DEVTEN_ULSTCNGEN;
+	else
+		reg &= ~DWC3_DEVTEN_ULSTCNGEN;
+
+	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
+}
+
 static int dwc3_gadget_get_frame(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	u32			reg;
 
-	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
-	return DWC3_DSTS_SOFFN(reg);
+	return __dwc3_gadget_get_frame(dwc);
 }
 
-static int dwc3_gadget_wakeup(struct usb_gadget *g)
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 {
-	struct dwc3		*dwc = gadget_to_dwc(g);
-
-	unsigned long		timeout;
-	unsigned long		flags;
-
+	int			ret;
 	u32			reg;
 
-	int			ret = 0;
-
 	u8			link_state;
-	u8			speed;
-
-	spin_lock_irqsave(&dwc->lock, flags);
 
 	/*
 	 * According to the Databook Remote wakeup request should
@@ -1324,62 +2372,118 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	 */
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 
-	speed = reg & DWC3_DSTS_CONNECTSPD;
-	if (speed == DWC3_DSTS_SUPERSPEED) {
-		dev_dbg(dwc->dev, "no wakeup on SuperSpeed\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
 	link_state = DWC3_DSTS_USBLNKST(reg);
 
 	switch (link_state) {
+	case DWC3_LINK_STATE_RESET:
 	case DWC3_LINK_STATE_RX_DET:	/* in HS, means Early Suspend */
 	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
+	case DWC3_LINK_STATE_U2:	/* in HS, means Sleep (L1) */
+	case DWC3_LINK_STATE_U1:
+	case DWC3_LINK_STATE_RESUME:
 		break;
 	default:
-		dev_dbg(dwc->dev, "can't wakeup from link state %d\n",
-				link_state);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
+	dwc3_gadget_enable_linksts_evts(dwc, true);
+
 	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
 	if (ret < 0) {
 		dev_err(dwc->dev, "failed to put link in Recovery\n");
-		goto out;
+		dwc3_gadget_enable_linksts_evts(dwc, false);
+		return ret;
 	}
 
 	/* Recent versions do this automatically */
-	if (dwc->revision < DWC3_REVISION_194A) {
+	if (DWC3_VER_IS_PRIOR(DWC3, 194A)) {
 		/* write zeroes to Link Change Request */
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	}
 
-	/* poll until Link State changes to ON */
-	timeout = 1000;
+	/*
+	 * Since link status change events are enabled we will receive
+	 * an U0 event when wakeup is successful.
+	 */
+	return 0;
+}
 
-	while (timeout--) {
-		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+static int dwc3_gadget_wakeup(struct usb_gadget *g)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+	int			ret;
 
-		/* in HS, means ON */
-		if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
-			break;
+	if (!dwc->wakeup_configured) {
+		dev_err(dwc->dev, "remote wakeup not configured\n");
+		return -EINVAL;
 	}
 
-	if (DWC3_DSTS_USBLNKST(reg) != DWC3_LINK_STATE_U0) {
-		dev_err(dwc->dev, "failed to send remote wakeup\n");
-		ret = -EINVAL;
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (!dwc->gadget->wakeup_armed) {
+		dev_err(dwc->dev, "not armed for remote wakeup\n");
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -EINVAL;
 	}
+	ret = __dwc3_gadget_wakeup(dwc);
 
-out:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
 }
 
+static void dwc3_resume_gadget(struct dwc3 *dwc);
+
+static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
+{
+	struct  dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+	int			ret;
+	int			link_state;
+
+	if (!dwc->wakeup_configured) {
+		dev_err(dwc->dev, "remote wakeup not configured\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	/*
+	 * If the link is in U3, signal for remote wakeup and wait for the
+	 * link to transition to U0 before sending device notification.
+	 */
+	link_state = dwc3_gadget_get_link_state(dwc);
+	if (link_state == DWC3_LINK_STATE_U3) {
+		dwc->wakeup_pending_funcs |= BIT(intf_id);
+		ret = __dwc3_gadget_wakeup(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return ret;
+	}
+
+	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
+					       DWC3_DGCMDPAR_DN_FUNC_WAKE |
+					       DWC3_DGCMDPAR_INTF_SEL(intf_id));
+	if (ret)
+		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static int dwc3_gadget_set_remote_wakeup(struct usb_gadget *g, int set)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->wakeup_configured = !!set;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
+}
+
 static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 		int is_selfpowered)
 {
@@ -1387,77 +2491,338 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 	unsigned long		flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc->is_selfpowered = !!is_selfpowered;
+	g->is_selfpowered = !!is_selfpowered;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
 }
 
-static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
+static void dwc3_stop_active_transfers(struct dwc3 *dwc)
+{
+	u32 epnum;
+
+	for (epnum = 2; epnum < dwc->num_eps; epnum++) {
+		struct dwc3_ep *dep;
+
+		dep = dwc->eps[epnum];
+		if (!dep)
+			continue;
+
+		dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+	}
+}
+
+static void __dwc3_gadget_set_ssp_rate(struct dwc3 *dwc)
+{
+	enum usb_ssp_rate	ssp_rate = dwc->gadget_ssp_rate;
+	u32			reg;
+
+	if (ssp_rate == USB_SSP_GEN_UNKNOWN)
+		ssp_rate = dwc->max_ssp_rate;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg &= ~DWC3_DCFG_SPEED_MASK;
+	reg &= ~DWC3_DCFG_NUMLANES(~0);
+
+	if (ssp_rate == USB_SSP_GEN_1x2)
+		reg |= DWC3_DCFG_SUPERSPEED;
+	else if (dwc->max_ssp_rate != USB_SSP_GEN_1x2)
+		reg |= DWC3_DCFG_SUPERSPEED_PLUS;
+
+	if (ssp_rate != USB_SSP_GEN_2x1 &&
+	    dwc->max_ssp_rate != USB_SSP_GEN_2x1)
+		reg |= DWC3_DCFG_NUMLANES(1);
+
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+}
+
+static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
+{
+	enum usb_device_speed	speed;
+	u32			reg;
+
+	speed = dwc->gadget_max_speed;
+	if (speed == USB_SPEED_UNKNOWN || speed > dwc->maximum_speed)
+		speed = dwc->maximum_speed;
+
+	if (speed == USB_SPEED_SUPER_PLUS &&
+	    DWC3_IP_IS(DWC32)) {
+		__dwc3_gadget_set_ssp_rate(dwc);
+		return;
+	}
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg &= ~(DWC3_DCFG_SPEED_MASK);
+
+	/*
+	 * WORKAROUND: DWC3 revision < 2.20a have an issue
+	 * which would cause metastability state on Run/Stop
+	 * bit if we try to force the IP to USB2-only mode.
+	 *
+	 * Because of that, we cannot configure the IP to any
+	 * speed other than the SuperSpeed
+	 *
+	 * Refers to:
+	 *
+	 * STAR#9000525659: Clock Domain Crossing on DCTL in
+	 * USB 2.0 Mode
+	 */
+	if (DWC3_VER_IS_PRIOR(DWC3, 220A) &&
+	    !dwc->dis_metastability_quirk) {
+		reg |= DWC3_DCFG_SUPERSPEED;
+	} else {
+		switch (speed) {
+		case USB_SPEED_FULL:
+			reg |= DWC3_DCFG_FULLSPEED;
+			break;
+		case USB_SPEED_HIGH:
+			reg |= DWC3_DCFG_HIGHSPEED;
+			break;
+		case USB_SPEED_SUPER:
+			reg |= DWC3_DCFG_SUPERSPEED;
+			break;
+		case USB_SPEED_SUPER_PLUS:
+			if (DWC3_IP_IS(DWC3))
+				reg |= DWC3_DCFG_SUPERSPEED;
+			else
+				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
+			break;
+		default:
+			dev_err(dwc->dev, "invalid speed (%d)\n", speed);
+
+			if (DWC3_IP_IS(DWC3))
+				reg |= DWC3_DCFG_SUPERSPEED;
+			else
+				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
+		}
+	}
+
+	if (DWC3_IP_IS(DWC32) &&
+	    speed > USB_SPEED_UNKNOWN &&
+	    speed < USB_SPEED_SUPER_PLUS)
+		reg &= ~DWC3_DCFG_NUMLANES(~0);
+
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+}
+
+static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
-	u32			timeout = 500;
+	u32			timeout = 2000;
+	u32			saved_config = 0;
+
+	if (pm_runtime_suspended(dwc->dev))
+		return 0;
+
+	/*
+	 * When operating in USB 2.0 speeds (HS/FS), ensure that
+	 * GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY are cleared before starting
+	 * or stopping the controller. This resolves timeout issues that occur
+	 * during frequent role switches between host and device modes.
+	 *
+	 * Save and clear these settings, then restore them after completing the
+	 * controller start or stop sequence.
+	 *
+	 * This solution was discovered through experimentation as it is not
+	 * mentioned in the dwc3 programming guide. It has been tested on an
+	 * Exynos platforms.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (reg & DWC3_GUSB2PHYCFG_SUSPHY) {
+		saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	}
+
+	if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
+		saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
+		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+	}
+
+	if (saved_config)
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
-		if (dwc->revision <= DWC3_REVISION_187A) {
+		if (DWC3_VER_IS_WITHIN(DWC3, ANY, 187A)) {
 			reg &= ~DWC3_DCTL_TRGTULST_MASK;
 			reg |= DWC3_DCTL_TRGTULST_RX_DET;
 		}
 
-		if (dwc->revision >= DWC3_REVISION_194A)
+		if (!DWC3_VER_IS_PRIOR(DWC3, 194A))
 			reg &= ~DWC3_DCTL_KEEP_CONNECT;
 		reg |= DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation)
-			reg |= DWC3_DCTL_KEEP_CONNECT;
-
+		__dwc3_gadget_set_speed(dwc);
 		dwc->pullups_connected = true;
 	} else {
 		reg &= ~DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation && !suspend)
-			reg &= ~DWC3_DCTL_KEEP_CONNECT;
-
 		dwc->pullups_connected = false;
 	}
 
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	do {
+		usleep_range(1000, 2000);
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
-		if (is_on) {
-			if (!(reg & DWC3_DSTS_DEVCTRLHLT))
-				break;
-		} else {
-			if (reg & DWC3_DSTS_DEVCTRLHLT)
-				break;
-		}
-		timeout--;
-		if (!timeout)
-			return -ETIMEDOUT;
-		udelay(1);
-	} while (1);
+		reg &= DWC3_DSTS_DEVCTRLHLT;
+	} while (--timeout && !(!is_on ^ !reg));
 
-	dev_vdbg(dwc->dev, "gadget %s data soft-%s\n",
-			dwc->gadget_driver
-			? dwc->gadget_driver->function : "no-function",
-			is_on ? "connect" : "disconnect");
+	if (saved_config) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		reg |= saved_config;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	}
+
+	if (!timeout)
+		return -ETIMEDOUT;
 
 	return 0;
 }
 
+static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
+static void __dwc3_gadget_stop(struct dwc3 *dwc);
+static int __dwc3_gadget_start(struct dwc3 *dwc);
+
+static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (!dwc->pullups_connected) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return 0;
+	}
+
+	dwc->connected = false;
+
+	/*
+	 * Attempt to end pending SETUP status phase, and not wait for the
+	 * function to do so.
+	 */
+	if (dwc->delayed_status)
+		dwc3_ep0_send_delayed_status(dwc);
+
+	/*
+	 * In the Synopsys DesignWare Cores USB3 Databook Rev. 3.30a
+	 * Section 4.1.8 Table 4-7, it states that for a device-initiated
+	 * disconnect, the SW needs to ensure that it sends "a DEPENDXFER
+	 * command for any active transfers" before clearing the RunStop
+	 * bit.
+	 */
+	dwc3_stop_active_transfers(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	/*
+	 * Per databook, when we want to stop the gadget, if a control transfer
+	 * is still in process, complete it and get the core into setup phase.
+	 * In case the host is unresponsive to a SETUP transaction, forcefully
+	 * stall the transfer, and move back to the SETUP phase, so that any
+	 * pending endxfers can be executed.
+	 */
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		reinit_completion(&dwc->ep0_in_setup);
+
+		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
+				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
+		if (ret == 0) {
+			dev_warn(dwc->dev, "wait for SETUP phase timed out\n");
+			spin_lock_irqsave(&dwc->lock, flags);
+			dwc3_ep0_reset_state(dwc);
+			spin_unlock_irqrestore(&dwc->lock, flags);
+		}
+	}
+
+	/*
+	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
+	 * driver needs to acknowledge them before the controller can halt.
+	 * Simply let the interrupt handler acknowledges and handle the
+	 * remaining event generated by the controller while polling for
+	 * DSTS.DEVCTLHLT.
+	 */
+	ret = dwc3_gadget_run_stop(dwc, false);
+
+	/*
+	 * Stop the gadget after controller is halted, so that if needed, the
+	 * events to update EP0 state can still occur while the run/stop
+	 * routine polls for the halted state.  DEVTEN is cleared as part of
+	 * gadget stop.
+	 */
+	spin_lock_irqsave(&dwc->lock, flags);
+	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
+
+	return ret;
+}
+
+static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
+{
+	int ret;
+
+	/*
+	 * In the Synopsys DWC_usb31 1.90a programming guide section
+	 * 4.1.9, it specifies that for a reconnect after a
+	 * device-initiated disconnect requires a core soft reset
+	 * (DCTL.CSftRst) before enabling the run/stop bit.
+	 */
+	ret = dwc3_core_soft_reset(dwc);
+	if (ret)
+		return ret;
+
+	dwc3_event_buffers_setup(dwc);
+	__dwc3_gadget_start(dwc);
+	return dwc3_gadget_run_stop(dwc, true);
+}
+
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
 	int			ret;
 
 	is_on = !!is_on;
 
-	spin_lock_irqsave(&dwc->lock, flags);
-	ret = dwc3_gadget_run_stop(dwc, is_on, false);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	dwc->softconnect = is_on;
+
+	/*
+	 * Avoid issuing a runtime resume if the device is already in the
+	 * suspended state during gadget disconnect.  DWC3 gadget was already
+	 * halted/stopped during runtime suspend.
+	 */
+	if (!is_on) {
+		pm_runtime_barrier(dwc->dev);
+		if (pm_runtime_suspended(dwc->dev))
+			return 0;
+	}
+
+	/*
+	 * Check the return value for successful resume, or error.  For a
+	 * successful resume, the DWC3 runtime PM resume routine will handle
+	 * the run stop sequence, so avoid duplicate operations here.
+	 */
+	ret = pm_runtime_get_sync(dwc->dev);
+	if (!ret || ret < 0) {
+		pm_runtime_put(dwc->dev);
+		if (ret < 0)
+			pm_runtime_set_suspended(dwc->dev);
+		return ret;
+	}
+
+	if (dwc->pullups_connected == is_on) {
+		pm_runtime_put(dwc->dev);
+		return 0;
+	}
+
+	synchronize_irq(dwc->irq_gadget);
+
+	if (!is_on)
+		ret = dwc3_gadget_soft_disconnect(dwc);
+	else
+		ret = dwc3_gadget_soft_connect(dwc);
+
+	pm_runtime_put(dwc->dev);
 
 	return ret;
 }
@@ -1467,16 +2832,21 @@ static void dwc3_gadget_enable_irq(struct dwc3 *dwc)
 	u32			reg;
 
 	/* Enable all but Start and End of Frame IRQs */
-	reg = (DWC3_DEVTEN_VNDRDEVTSTRCVEDEN |
-			DWC3_DEVTEN_EVNTOVERFLOWEN |
+	reg = (DWC3_DEVTEN_EVNTOVERFLOWEN |
 			DWC3_DEVTEN_CMDCMPLTEN |
 			DWC3_DEVTEN_ERRTICERREN |
 			DWC3_DEVTEN_WKUPEVTEN |
-			DWC3_DEVTEN_ULSTCNGEN |
 			DWC3_DEVTEN_CONNECTDONEEN |
 			DWC3_DEVTEN_USBRSTEN |
 			DWC3_DEVTEN_DISCONNEVTEN);
 
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
+		reg |= DWC3_DEVTEN_ULSTCNGEN;
+
+	/* On 2.30a and above this bit enables U3/L2-L1 Suspend Events */
+	if (!DWC3_VER_IS_PRIOR(DWC3, 230A))
+		reg |= DWC3_DEVTEN_U3L2L1SUSPEN;
+
 	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
 }
 
@@ -1486,254 +2856,610 @@ static void dwc3_gadget_disable_irq(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DEVTEN, 0x00);
 }
 
-static int dwc3_gadget_start(struct usb_gadget *g,
-		struct usb_gadget_driver *driver)
+static irqreturn_t dwc3_interrupt(int irq, void *_dwc);
+static irqreturn_t dwc3_thread_interrupt(int irq, void *_dwc);
+
+/**
+ * dwc3_gadget_setup_nump - calculate and initialize NUMP field of %DWC3_DCFG
+ * @dwc: pointer to our context structure
+ *
+ * The following looks like complex but it's actually very simple. In order to
+ * calculate the number of packets we can burst at once on OUT transfers, we're
+ * gonna use RxFIFO size.
+ *
+ * To calculate RxFIFO size we need two numbers:
+ * MDWIDTH = size, in bits, of the internal memory bus
+ * RAM2_DEPTH = depth, in MDWIDTH, of internal RAM2 (where RxFIFO sits)
+ *
+ * Given these two numbers, the formula is simple:
+ *
+ * RxFIFO Size = (RAM2_DEPTH * MDWIDTH / 8) - 24 - 16;
+ *
+ * 24 bytes is for 3x SETUP packets
+ * 16 bytes is a clock domain crossing tolerance
+ *
+ * Given RxFIFO Size, NUMP = RxFIFOSize / 1024;
+ */
+static void dwc3_gadget_setup_nump(struct dwc3 *dwc)
+{
+	u32 ram2_depth;
+	u32 mdwidth;
+	u32 nump;
+	u32 reg;
+
+	ram2_depth = DWC3_GHWPARAMS7_RAM2_DEPTH(dwc->hwparams.hwparams7);
+	mdwidth = dwc3_mdwidth(dwc);
+
+	nump = ((ram2_depth * mdwidth / 8) - 24 - 16) / 1024;
+	nump = min_t(u32, nump, 16);
+
+	/* update NumP */
+	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg &= ~DWC3_DCFG_NUMP_MASK;
+	reg |= nump << DWC3_DCFG_NUMP_SHIFT;
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+}
+
+static int __dwc3_gadget_start(struct dwc3 *dwc)
 {
-	struct dwc3		*dwc = gadget_to_dwc(g);
 	struct dwc3_ep		*dep;
-	unsigned long		flags;
 	int			ret = 0;
 	u32			reg;
 
-	spin_lock_irqsave(&dwc->lock, flags);
-
-	if (dwc->gadget_driver) {
-		dev_err(dwc->dev, "%s is already bound to %s\n",
-				dwc->gadget.name,
-				dwc->gadget_driver->function);
-		ret = -EBUSY;
-		goto err1;
+	/*
+	 * Use IMOD if enabled via dwc->imod_interval. Otherwise, if
+	 * the core supports IMOD, disable it.
+	 */
+	if (dwc->imod_interval) {
+		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
+	} else if (dwc3_has_imod(dwc)) {
+		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), 0);
 	}
 
-	dwc->gadget_driver	= driver;
+	/*
+	 * We are telling dwc3 that we want to use DCFG.NUMP as ACK TP's NUMP
+	 * field instead of letting dwc3 itself calculate that automatically.
+	 *
+	 * This way, we maximize the chances that we'll be able to get several
+	 * bursts of data without going through any sort of endpoint throttling.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+	if (DWC3_IP_IS(DWC3))
+		reg &= ~DWC3_GRXTHRCFG_PKTCNTSEL;
+	else
+		reg &= ~DWC31_GRXTHRCFG_PKTCNTSEL;
 
+	dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+
+	dwc3_gadget_setup_nump(dwc);
+
+	/*
+	 * Currently the controller handles single stream only. So, Ignore
+	 * Packet Pending bit for stream selection and don't search for another
+	 * stream if the host sends Data Packet with PP=0 (for OUT direction) or
+	 * ACK with NumP=0 and PP=0 (for IN direction). This slightly improves
+	 * the stream performance.
+	 */
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
-	reg &= ~(DWC3_DCFG_SPEED_MASK);
-
-	/**
-	 * WORKAROUND: DWC3 revision < 2.20a have an issue
-	 * which would cause metastability state on Run/Stop
-	 * bit if we try to force the IP to USB2-only mode.
-	 *
-	 * Because of that, we cannot configure the IP to any
-	 * speed other than the SuperSpeed
-	 *
-	 * Refers to:
-	 *
-	 * STAR#9000525659: Clock Domain Crossing on DCTL in
-	 * USB 2.0 Mode
-	 */
-	if (dwc->revision < DWC3_REVISION_220A) {
-		reg |= DWC3_DCFG_SUPERSPEED;
-	} else {
-		switch (dwc->maximum_speed) {
-		case USB_SPEED_LOW:
-			reg |= DWC3_DSTS_LOWSPEED;
-			break;
-		case USB_SPEED_FULL:
-			reg |= DWC3_DSTS_FULLSPEED1;
-			break;
-		case USB_SPEED_HIGH:
-			reg |= DWC3_DSTS_HIGHSPEED;
-			break;
-		case USB_SPEED_SUPER:	/* FALLTHROUGH */
-		case USB_SPEED_UNKNOWN:	/* FALTHROUGH */
-		default:
-			reg |= DWC3_DSTS_SUPERSPEED;
-		}
-	}
+	reg |= DWC3_DCFG_IGNSTRMPP;
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
-	dwc->start_config_issued = false;
+	/* Enable MST by default if the device is capable of MST */
+	if (DWC3_MST_CAPABLE(&dwc->hwparams)) {
+		reg = dwc3_readl(dwc->regs, DWC3_DCFG1);
+		reg &= ~DWC3_DCFG1_DIS_MST_ENH;
+		dwc3_writel(dwc->regs, DWC3_DCFG1, reg);
+	}
 
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
+	ret = dwc3_gadget_start_config(dwc, 0);
+	if (ret) {
+		dev_err(dwc->dev, "failed to config endpoints\n");
+		return ret;
+	}
+
 	dep = dwc->eps[0];
-	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, false,
-			false);
+	dep->flags = 0;
+	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
-		goto err2;
+		goto err0;
 	}
 
 	dep = dwc->eps[1];
-	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, false,
-			false);
+	dep->flags = 0;
+	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
-		goto err3;
+		goto err1;
 	}
 
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
+	dwc->ep0_bounced = false;
+	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
+	dwc->delayed_status = false;
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	dwc3_enable_susphy(dwc, true);
 
 	return 0;
 
-err3:
-	__dwc3_gadget_ep_disable(dwc->eps[0]);
-
-err2:
-	dwc->gadget_driver = NULL;
-
 err1:
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	__dwc3_gadget_ep_disable(dwc->eps[0]);
 
+err0:
 	return ret;
 }
 
-static int dwc3_gadget_stop(struct usb_gadget *g)
+static int dwc3_gadget_start(struct usb_gadget *g,
+		struct usb_gadget_driver *driver)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
+	int			ret;
+	int			irq;
+
+	irq = dwc->irq_gadget;
+	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
+			IRQF_SHARED, "dwc3", dwc->ev_buf);
+	if (ret) {
+		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
+				irq, ret);
+		return ret;
+	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->gadget_driver	= driver;
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	if (dwc->sys_wakeup)
+		device_wakeup_enable(dwc->sysdev);
+
+	return 0;
+}
+
+static void __dwc3_gadget_stop(struct dwc3 *dwc)
+{
 	dwc3_gadget_disable_irq(dwc);
 	__dwc3_gadget_ep_disable(dwc->eps[0]);
 	__dwc3_gadget_ep_disable(dwc->eps[1]);
+}
 
+static int dwc3_gadget_stop(struct usb_gadget *g)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+
+	if (dwc->sys_wakeup)
+		device_wakeup_disable(dwc->sysdev);
+
+	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= NULL;
-
+	dwc->max_cfg_eps = 0;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	free_irq(dwc->irq_gadget, dwc->ev_buf);
+
 	return 0;
 }
 
-static struct usb_ep *dwc3_find_ep(struct usb_gadget *gadget, const char *name)
+static void dwc3_gadget_config_params(struct usb_gadget *g,
+				      struct usb_dcd_config_params *params)
 {
+	struct dwc3		*dwc = gadget_to_dwc(g);
+
+	params->besl_baseline = USB_DEFAULT_BESL_UNSPECIFIED;
+	params->besl_deep = USB_DEFAULT_BESL_UNSPECIFIED;
+
+	/* Recommended BESL */
+	if (!dwc->dis_enblslpm_quirk) {
+		/*
+		 * If the recommended BESL baseline is 0 or if the BESL deep is
+		 * less than 2, Microsoft's Windows 10 host usb stack will issue
+		 * a usb reset immediately after it receives the extended BOS
+		 * descriptor and the enumeration will fail. To maintain
+		 * compatibility with the Windows' usb stack, let's set the
+		 * recommended BESL baseline to 1 and clamp the BESL deep to be
+		 * within 2 to 15.
+		 */
+		params->besl_baseline = 1;
+		if (dwc->is_utmi_l1_suspend)
+			params->besl_deep =
+				clamp_t(u8, dwc->hird_threshold, 2, 15);
+	}
+
+	/* U1 Device exit Latency */
+	if (dwc->dis_u1_entry_quirk)
+		params->bU1devExitLat = 0;
+	else
+		params->bU1devExitLat = DWC3_DEFAULT_U1_DEV_EXIT_LAT;
+
+	/* U2 Device exit Latency */
+	if (dwc->dis_u2_entry_quirk)
+		params->bU2DevExitLat = 0;
+	else
+		params->bU2DevExitLat =
+				cpu_to_le16(DWC3_DEFAULT_U2_DEV_EXIT_LAT);
+}
+
+static void dwc3_gadget_set_speed(struct usb_gadget *g,
+				  enum usb_device_speed speed)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->gadget_max_speed = speed;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
+static void dwc3_gadget_set_ssp_rate(struct usb_gadget *g,
+				     enum usb_ssp_rate rate)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->gadget_max_speed = USB_SPEED_SUPER_PLUS;
+	dwc->gadget_ssp_rate = rate;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
+static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	union power_supply_propval	val = {0};
+	int				ret;
+
+	if (dwc->usb2_phy)
+		return usb_phy_set_power(dwc->usb2_phy, mA);
+
+	if (!dwc->usb_psy)
+		return -EOPNOTSUPP;
+
+	val.intval = 1000 * mA;
+	ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
+
+	return ret;
+}
+
+/**
+ * dwc3_gadget_check_config - ensure dwc3 can support the USB configuration
+ * @g: pointer to the USB gadget
+ *
+ * Used to record the maximum number of endpoints being used in a USB composite
+ * device. (across all configurations)  This is to be used in the calculation
+ * of the TXFIFO sizes when resizing internal memory for individual endpoints.
+ * It will help ensured that the resizing logic reserves enough space for at
+ * least one max packet.
+ */
+static int dwc3_gadget_check_config(struct usb_gadget *g)
+{
+	struct dwc3 *dwc = gadget_to_dwc(g);
 	struct usb_ep *ep;
+	int fifo_size = 0;
+	int ram_depth;
+	int ep_num = 0;
 
-	list_for_each_entry(ep, &gadget->ep_list, ep_list)
-		if (!strcmp(ep->name, name))
-			return ep;
+	if (!dwc->do_fifo_resize)
+		return 0;
 
-	return NULL;
+	list_for_each_entry(ep, &g->ep_list, ep_list) {
+		/* Only interested in the IN endpoints */
+		if (ep->claimed && (ep->address & USB_DIR_IN))
+			ep_num++;
+	}
+
+	if (ep_num <= dwc->max_cfg_eps)
+		return 0;
+
+	/* Update the max number of eps in the composition */
+	dwc->max_cfg_eps = ep_num;
+
+	fifo_size = dwc3_gadget_calc_tx_fifo_size(dwc, dwc->max_cfg_eps);
+	/* Based on the equation, increment by one for every ep */
+	fifo_size += dwc->max_cfg_eps;
+
+	/* Check if we can fit a single fifo per endpoint */
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
+	if (fifo_size > ram_depth)
+		return -ENOMEM;
+
+	return 0;
 }
 
-static struct
-usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
-			     struct usb_endpoint_descriptor *desc,
-			     struct usb_ss_ep_comp_descriptor *comp_desc)
+static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
 {
-	/*
-	 * First try standard, common configuration: ep1in-bulk,
-	 * ep2out-bulk, ep3in-int to match other udc drivers to avoid
-	 * confusion in already deployed software (endpoint numbers
-	 * hardcoded in userspace software/drivers)
-	 */
-	if (usb_endpoint_is_bulk_in(desc))
-		return dwc3_find_ep(gadget, "ep1in");
-	if (usb_endpoint_is_bulk_out(desc))
-		return dwc3_find_ep(gadget, "ep2out");
-	if (usb_endpoint_is_int_in(desc)) {
-		/*
-		 * Special workaround for NXP UUU tool in SPL.
-		 *
-		 * The tool expects the interrupt-in endpoint to be ep1in,
-		 * otherwise it crashes. This is a result of the previous
-		 * hard-coded EP setup in drivers/usb/gadget/epautoconf.c
-		 * which did special-case EP allocation for SPL builds,
-		 * and which was since converted to this callback, but
-		 * without the special-case EP allocation in SPL part.
-		 *
-		 * This reinstates the SPL part in an isolated manner,
-		 * only for NXP iMX SoCs, only for SPL builds, and only
-		 * for the ep1in interrupt-in endpoint.
-		 */
-		if (IS_ENABLED(CONFIG_MACH_IMX) && IS_ENABLED(CONFIG_XPL_BUILD))
-			return dwc3_find_ep(gadget, "ep1in");
-		return dwc3_find_ep(gadget, "ep3in");
-	}
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
 
-	return NULL;
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->async_callbacks = enable;
+	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
+	.func_wakeup		= dwc3_gadget_func_wakeup,
+	.set_remote_wakeup	= dwc3_gadget_set_remote_wakeup,
 	.set_selfpowered	= dwc3_gadget_set_selfpowered,
 	.pullup			= dwc3_gadget_pullup,
 	.udc_start		= dwc3_gadget_start,
 	.udc_stop		= dwc3_gadget_stop,
-	.match_ep		= dwc3_gadget_match_ep,
+	.udc_set_speed		= dwc3_gadget_set_speed,
+	.udc_set_ssp_rate	= dwc3_gadget_set_ssp_rate,
+	.get_config_params	= dwc3_gadget_config_params,
+	.vbus_draw		= dwc3_gadget_vbus_draw,
+	.check_config		= dwc3_gadget_check_config,
+	.udc_async_callbacks	= dwc3_gadget_async_callbacks,
 };
 
 /* -------------------------------------------------------------------------- */
 
-static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
-		u8 num, u32 direction)
+static int dwc3_gadget_init_control_endpoint(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
+
+	usb_ep_set_maxpacket_limit(&dep->endpoint, 512);
+	dep->endpoint.maxburst = 1;
+	dep->endpoint.ops = &dwc3_gadget_ep0_ops;
+	if (!dep->direction)
+		dwc->gadget->ep0 = &dep->endpoint;
+
+	dep->endpoint.caps.type_control = true;
+
+	return 0;
+}
+
+static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
+	u32 mdwidth;
+	int size;
+	int maxpacket;
+
+	mdwidth = dwc3_mdwidth(dwc);
+
+	/* MDWIDTH is represented in bits, we need it in bytes */
+	mdwidth /= 8;
+
+	size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1));
+	if (DWC3_IP_IS(DWC3))
+		size = DWC3_GTXFIFOSIZ_TXFDEP(size);
+	else
+		size = DWC31_GTXFIFOSIZ_TXFDEP(size);
+
+	/*
+	 * maxpacket size is determined as part of the following, after assuming
+	 * a mult value of one maxpacket:
+	 * DWC3 revision 280A and prior:
+	 * fifo_size = mult * (max_packet / mdwidth) + 1;
+	 * maxpacket = mdwidth * (fifo_size - 1);
+	 *
+	 * DWC3 revision 290A and onwards:
+	 * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
+	 * maxpacket = mdwidth * ((fifo_size - 1) - 1) - mdwidth;
+	 */
+	if (DWC3_VER_IS_PRIOR(DWC3, 290A))
+		maxpacket = mdwidth * (size - 1);
+	else
+		maxpacket = mdwidth * ((size - 1) - 1) - mdwidth;
+
+	/* Functionally, space for one max packet is sufficient */
+	size = min_t(int, maxpacket, 1024);
+	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
+
+	dep->endpoint.max_streams = 16;
+	dep->endpoint.ops = &dwc3_gadget_ep_ops;
+	list_add_tail(&dep->endpoint.ep_list,
+			&dwc->gadget->ep_list);
+	dep->endpoint.caps.type_iso = true;
+	dep->endpoint.caps.type_bulk = true;
+	dep->endpoint.caps.type_int = true;
+
+	return dwc3_alloc_trb_pool(dep);
+}
+
+static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
+	u32 mdwidth;
+	int size;
+
+	mdwidth = dwc3_mdwidth(dwc);
+
+	/* MDWIDTH is represented in bits, convert to bytes */
+	mdwidth /= 8;
+
+	/* All OUT endpoints share a single RxFIFO space */
+	size = dwc3_readl(dwc->regs, DWC3_GRXFIFOSIZ(0));
+	if (DWC3_IP_IS(DWC3))
+		size = DWC3_GRXFIFOSIZ_RXFDEP(size);
+	else
+		size = DWC31_GRXFIFOSIZ_RXFDEP(size);
+
+	/* FIFO depth is in MDWDITH bytes */
+	size *= mdwidth;
+
+	/*
+	 * To meet performance requirement, a minimum recommended RxFIFO size
+	 * is defined as follow:
+	 * RxFIFO size >= (3 x MaxPacketSize) +
+	 * (3 x 8 bytes setup packets size) + (16 bytes clock crossing margin)
+	 *
+	 * Then calculate the max packet limit as below.
+	 */
+	size -= (3 * 8) + 16;
+	if (size < 0)
+		size = 0;
+	else
+		size /= 3;
+
+	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
+	dep->endpoint.max_streams = 16;
+	dep->endpoint.ops = &dwc3_gadget_ep_ops;
+	list_add_tail(&dep->endpoint.ep_list,
+			&dwc->gadget->ep_list);
+	dep->endpoint.caps.type_iso = true;
+	dep->endpoint.caps.type_bulk = true;
+	dep->endpoint.caps.type_int = true;
+
+	return dwc3_alloc_trb_pool(dep);
+}
+
+#define nostream_work_to_dep(w) (container_of(to_delayed_work(w), struct dwc3_ep, nostream_work))
+static void dwc3_nostream_work(struct work_struct *work)
+{
+	struct dwc3_ep	*dep = nostream_work_to_dep(work);
+	struct dwc3	*dwc = dep->dwc;
+	unsigned long   flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (dep->flags & DWC3_EP_STREAM_PRIMED)
+		goto out;
+
+	if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
+	    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
+	     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
+		goto out;
+	/*
+	 * If the host rejects a stream due to no active stream, by the
+	 * USB and xHCI spec, the endpoint will be put back to idle
+	 * state. When the host is ready (buffer added/updated), it will
+	 * prime the endpoint to inform the usb device controller. This
+	 * triggers the device controller to issue ERDY to restart the
+	 * stream. However, some hosts don't follow this and keep the
+	 * endpoint in the idle state. No prime will come despite host
+	 * streams are updated, and the device controller will not be
+	 * triggered to generate ERDY to move the next stream data. To
+	 * workaround this and maintain compatibility with various
+	 * hosts, force to reinitiate the stream until the host is ready
+	 * instead of waiting for the host to prime the endpoint.
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
+		unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
+
+		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
+	} else {
+		dep->flags |= DWC3_EP_DELAY_START;
+		dwc3_stop_active_transfer(dep, true, true);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return;
+	}
+out:
+	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
+static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 {
 	struct dwc3_ep			*dep;
-	u8				i;
+	bool				direction = epnum & 1;
+	int				ret;
+	u8				num = epnum >> 1;
 
-	for (i = 0; i < num; i++) {
-		u8 epnum = (i << 1) | (!!direction);
+	dep = kzalloc(sizeof(*dep), GFP_KERNEL);
+	if (!dep)
+		return -ENOMEM;
 
-		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
-		if (!dep)
-			return -ENOMEM;
+	dep->dwc = dwc;
+	dep->number = epnum;
+	dep->direction = direction;
+	dep->regs = dwc->regs + DWC3_DEP_BASE(epnum);
+	dwc->eps[epnum] = dep;
+	dep->combo_num = 0;
+	dep->start_cmd_status = 0;
 
-		dep->dwc = dwc;
-		dep->number = epnum;
-		dep->direction = !!direction;
-		dwc->eps[epnum] = dep;
+	snprintf(dep->name, sizeof(dep->name), "ep%u%s", num,
+			direction ? "in" : "out");
 
-		snprintf(dep->name, sizeof(dep->name), "ep%d%s", epnum >> 1,
-				(epnum & 1) ? "in" : "out");
+	dep->endpoint.name = dep->name;
 
-		dep->endpoint.name = dep->name;
+	if (!(dep->number > 1)) {
+		dep->endpoint.desc = &dwc3_gadget_ep0_desc;
+		dep->endpoint.comp_desc = NULL;
+	}
 
-		dev_vdbg(dwc->dev, "initializing %s\n", dep->name);
+	if (num == 0)
+		ret = dwc3_gadget_init_control_endpoint(dep);
+	else if (direction)
+		ret = dwc3_gadget_init_in_endpoint(dep);
+	else
+		ret = dwc3_gadget_init_out_endpoint(dep);
 
-		if (epnum == 0 || epnum == 1) {
-			usb_ep_set_maxpacket_limit(&dep->endpoint, 512);
-			dep->endpoint.maxburst = 1;
-			dep->endpoint.ops = &dwc3_gadget_ep0_ops;
-			if (!epnum)
-				dwc->gadget.ep0 = &dep->endpoint;
-		} else {
-			int		ret;
+	if (ret)
+		return ret;
 
-			usb_ep_set_maxpacket_limit(&dep->endpoint, 512);
-			dep->endpoint.max_streams = 15;
-			dep->endpoint.ops = &dwc3_gadget_ep_ops;
-			list_add_tail(&dep->endpoint.ep_list,
-					&dwc->gadget.ep_list);
+	dep->endpoint.caps.dir_in = direction;
+	dep->endpoint.caps.dir_out = !direction;
 
-			ret = dwc3_alloc_trb_pool(dep);
-			if (ret)
-				return ret;
+	INIT_LIST_HEAD(&dep->pending_list);
+	INIT_LIST_HEAD(&dep->started_list);
+	INIT_LIST_HEAD(&dep->cancelled_list);
+	INIT_DELAYED_WORK(&dep->nostream_work, dwc3_nostream_work);
+
+	dwc3_debugfs_create_endpoint_dir(dep);
+
+	return 0;
+}
+
+static int dwc3_gadget_get_reserved_endpoints(struct dwc3 *dwc, const char *propname,
+					      u8 *eps, u8 num)
+{
+	u8 count;
+	int ret;
+
+	if (!device_property_present(dwc->dev, propname))
+		return 0;
+
+	ret = device_property_count_u8(dwc->dev, propname);
+	if (ret < 0)
+		return ret;
+	count = ret;
+
+	ret = device_property_read_u8_array(dwc->dev, propname, eps, min(num, count));
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
+{
+	const char			*propname = "snps,reserved-endpoints";
+	u8				epnum;
+	u8				reserved_eps[DWC3_ENDPOINTS_NUM];
+	u8				count;
+	u8				num;
+	int				ret;
+
+	INIT_LIST_HEAD(&dwc->gadget->ep_list);
+
+	ret = dwc3_gadget_get_reserved_endpoints(dwc, propname,
+						 reserved_eps, ARRAY_SIZE(reserved_eps));
+	if (ret < 0) {
+		dev_err(dwc->dev, "failed to read %s\n", propname);
+		return ret;
+	}
+	count = ret;
+
+	for (epnum = 0; epnum < total; epnum++) {
+		for (num = 0; num < count; num++) {
+			if (epnum == reserved_eps[num])
+				break;
 		}
+		if (num < count)
+			continue;
 
-		INIT_LIST_HEAD(&dep->request_list);
-		INIT_LIST_HEAD(&dep->req_queued);
-	}
-
-	return 0;
-}
-
-static int dwc3_gadget_init_endpoints(struct dwc3 *dwc)
-{
-	int				ret;
-
-	INIT_LIST_HEAD(&dwc->gadget.ep_list);
-
-	ret = dwc3_gadget_init_hw_endpoints(dwc, dwc->num_out_eps, 0);
-	if (ret < 0) {
-		dev_vdbg(dwc->dev, "failed to allocate OUT endpoints\n");
-		return ret;
-	}
-
-	ret = dwc3_gadget_init_hw_endpoints(dwc, dwc->num_in_eps, 1);
-	if (ret < 0) {
-		dev_vdbg(dwc->dev, "failed to allocate IN endpoints\n");
-		return ret;
+		ret = dwc3_gadget_init_endpoint(dwc, epnum);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -1762,161 +3488,248 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
+		dwc3_debugfs_remove_endpoint_dir(dep);
 		kfree(dep);
 	}
 }
 
 /* -------------------------------------------------------------------------- */
 
-static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
+static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 		struct dwc3_request *req, struct dwc3_trb *trb,
-		const struct dwc3_event_depevt *event, int status)
+		const struct dwc3_event_depevt *event, int status, int chain)
 {
 	unsigned int		count;
-	unsigned int		s_pkt = 0;
-	unsigned int		trb_status;
-
-	if ((trb->ctrl & DWC3_TRB_CTRL_HWO) && status != -ESHUTDOWN)
-		/*
-		 * We continue despite the error. There is not much we
-		 * can do. If we don't clean it up we loop forever. If
-		 * we skip the TRB then it gets overwritten after a
-		 * while since we use them in a ring buffer. A BUG()
-		 * would help. Lets hope that if this occurs, someone
-		 * fixes the root cause instead of looking away :)
-		 */
-		dev_err(dwc->dev, "%s's TRB (%p) still owned by HW\n",
-				dep->name, trb);
+
+	dwc3_ep_inc_deq(dep);
+
+	trace_dwc3_complete_trb(dep, trb);
+	req->num_trbs--;
+
+	/*
+	 * If we're in the middle of series of chained TRBs and we
+	 * receive a short transfer along the way, DWC3 will skip
+	 * through all TRBs including the last TRB in the chain (the
+	 * where CHN bit is zero. DWC3 will also avoid clearing HWO
+	 * bit and SW has to do it manually.
+	 *
+	 * We're going to do that here to avoid problems of HW trying
+	 * to use bogus TRBs for transfers.
+	 */
+	if (trb->ctrl & DWC3_TRB_CTRL_HWO)
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+
+	/*
+	 * For isochronous transfers, the first TRB in a service interval must
+	 * have the Isoc-First type. Track and report its interval frame number.
+	 */
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+	    (trb->ctrl & DWC3_TRBCTL_ISOCHRONOUS_FIRST)) {
+		unsigned int frame_number;
+
+		frame_number = DWC3_TRB_CTRL_GET_SID_SOFN(trb->ctrl);
+		frame_number &= ~(dep->interval - 1);
+		req->request.frame_number = frame_number;
+	}
+
+	/*
+	 * We use bounce buffer for requests that needs extra TRB or OUT ZLP. If
+	 * this TRB points to the bounce buffer address, it's a MPS alignment
+	 * TRB. Don't add it to req->remaining calculation.
+	 */
+	if (trb->bpl == lower_32_bits(dep->dwc->bounce_addr) &&
+	    trb->bph == upper_32_bits(dep->dwc->bounce_addr)) {
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+		return 1;
+	}
+
 	count = trb->size & DWC3_TRB_SIZE_MASK;
+	req->remaining += count;
 
-	if (dep->direction) {
-		if (count) {
-			trb_status = DWC3_TRB_SIZE_TRBSTS(trb->size);
-			if (trb_status == DWC3_TRBSTS_MISSED_ISOC) {
-				dev_dbg(dwc->dev, "incomplete IN transfer %s\n",
-						dep->name);
-				/*
-				 * If missed isoc occurred and there is
-				 * no request queued then issue END
-				 * TRANSFER, so that core generates
-				 * next xfernotready and we will issue
-				 * a fresh START TRANSFER.
-				 * If there are still queued request
-				 * then wait, do not issue either END
-				 * or UPDATE TRANSFER, just attach next
-				 * request in request_list during
-				 * giveback.If any future queued request
-				 * is successfully transferred then we
-				 * will issue UPDATE TRANSFER for all
-				 * request in the request_list.
-				 */
-				dep->flags |= DWC3_EP_MISSED_ISOC;
-			} else {
-				dev_err(dwc->dev, "incomplete IN transfer %s\n",
-						dep->name);
-				status = -ECONNRESET;
-			}
-		} else {
-			dep->flags &= ~DWC3_EP_MISSED_ISOC;
-		}
-	} else {
-		if (count && (event->status & DEPEVT_STATUS_SHORT))
-			s_pkt = 1;
-	}
+	if ((trb->ctrl & DWC3_TRB_CTRL_HWO) && status != -ESHUTDOWN)
+		return 1;
 
-	/*
-	 * We assume here we will always receive the entire data block
-	 * which we should receive. Meaning, if we program RX to
-	 * receive 4K but we receive only 2K, we assume that's all we
-	 * should receive and we simply bounce the request back to the
-	 * gadget driver for further processing.
-	 */
-	req->request.actual += req->request.length - count;
-	if (s_pkt)
+	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
-	if ((event->status & DEPEVT_STATUS_LST) &&
-			(trb->ctrl & (DWC3_TRB_CTRL_LST |
-				DWC3_TRB_CTRL_HWO)))
+
+	if ((trb->ctrl & DWC3_TRB_CTRL_ISP_IMI) &&
+	    DWC3_TRB_SIZE_TRBSTS(trb->size) == DWC3_TRBSTS_MISSED_ISOC)
 		return 1;
-	if ((event->status & DEPEVT_STATUS_IOC) &&
-			(trb->ctrl & DWC3_TRB_CTRL_IOC))
+
+	if ((trb->ctrl & DWC3_TRB_CTRL_IOC) ||
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
+
 	return 0;
 }
 
-static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
+static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
+		struct dwc3_request *req, const struct dwc3_event_depevt *event,
+		int status)
+{
+	struct dwc3_trb *trb;
+	unsigned int num_completed_trbs = req->num_trbs;
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < num_completed_trbs; i++) {
+		trb = &dep->trb_pool[dep->trb_dequeue];
+
+		ret = dwc3_gadget_ep_reclaim_completed_trb(dep, req,
+				trb, event, status,
+				!!(trb->ctrl & DWC3_TRB_CTRL_CHN));
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
+{
+	return req->num_pending_sgs == 0 && req->num_trbs == 0;
+}
+
+static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event,
+		struct dwc3_request *req, int status)
+{
+	int request_status;
+	int ret;
+
+	ret = dwc3_gadget_ep_reclaim_trb_sg(dep, req, event, status);
+
+	req->request.actual = req->request.length - req->remaining;
+
+	if (!dwc3_gadget_ep_request_completed(req))
+		goto out;
+
+	/*
+	 * The event status only reflects the status of the TRB with IOC set.
+	 * For the requests that don't set interrupt on completion, the driver
+	 * needs to check and return the status of the completed TRBs associated
+	 * with the request. Use the status of the last TRB of the request.
+	 */
+	if (req->request.no_interrupt) {
+		struct dwc3_trb *trb;
+
+		trb = dwc3_ep_prev_trb(dep, dep->trb_dequeue);
+		switch (DWC3_TRB_SIZE_TRBSTS(trb->size)) {
+		case DWC3_TRBSTS_MISSED_ISOC:
+			/* Isoc endpoint only */
+			request_status = -EXDEV;
+			break;
+		case DWC3_TRB_STS_XFER_IN_PROG:
+			/* Applicable when End Transfer with ForceRM=0 */
+		case DWC3_TRBSTS_SETUP_PENDING:
+			/* Control endpoint only */
+		case DWC3_TRBSTS_OK:
+		default:
+			request_status = 0;
+			break;
+		}
+	} else {
+		request_status = status;
+	}
+
+	dwc3_gadget_giveback(dep, req, request_status);
+
+out:
+	return ret;
+}
+
+static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event, int status)
 {
 	struct dwc3_request	*req;
-	struct dwc3_trb		*trb;
-	unsigned int		slot;
 
-	req = next_request(&dep->req_queued);
-	if (!req) {
-		WARN_ON_ONCE(1);
-		return 1;
+	while (!list_empty(&dep->started_list)) {
+		int ret;
+
+		req = next_request(&dep->started_list);
+		ret = dwc3_gadget_ep_cleanup_completed_request(dep, event,
+				req, status);
+		if (ret)
+			break;
+		/*
+		 * The endpoint is disabled, let the dwc3_remove_requests()
+		 * handle the cleanup.
+		 */
+		if (!dep->endpoint.desc)
+			break;
 	}
+}
+
+static bool dwc3_gadget_ep_should_continue(struct dwc3_ep *dep)
+{
+	struct dwc3_request	*req;
+	struct dwc3		*dwc = dep->dwc;
+
+	if (!dep->endpoint.desc || !dwc->pullups_connected ||
+	    !dwc->connected)
+		return false;
+
+	if (!list_empty(&dep->pending_list))
+		return true;
+
+	/*
+	 * We only need to check the first entry of the started list. We can
+	 * assume the completed requests are removed from the started list.
+	 */
+	req = next_request(&dep->started_list);
+	if (!req)
+		return false;
+
+	return !dwc3_gadget_ep_request_completed(req);
+}
+
+static void dwc3_gadget_endpoint_frame_from_event(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	dep->frame_number = event->parameters;
+}
+
+static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event, int status)
+{
+	struct dwc3		*dwc = dep->dwc;
+	bool			no_started_trb = true;
+
+	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
-	slot = req->start_slot;
-	if ((slot == DWC3_TRB_NUM - 1) &&
-	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		slot++;
-	slot %= DWC3_TRB_NUM;
-	trb = &dep->trb_pool[slot];
+	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
+		goto out;
 
-	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
-	__dwc3_cleanup_done_trbs(dwc, dep, req, trb, event, status);
-	dwc3_gadget_giveback(dep, req, status);
+	if (!dep->endpoint.desc)
+		return no_started_trb;
 
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-			list_empty(&dep->req_queued)) {
-		if (list_empty(&dep->request_list)) {
-			/*
-			 * If there is no entry in request list then do
-			 * not issue END TRANSFER now. Just set PENDING
-			 * flag, so that END TRANSFER is issued when an
-			 * entry is added into request list.
-			 */
-			dep->flags = DWC3_EP_PENDING_REQUEST;
-		} else {
-			dwc3_stop_active_transfer(dwc, dep->number, true);
-			dep->flags = DWC3_EP_ENABLED;
-		}
-		return 1;
-	}
-
-	return 1;
-}
-
-static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
-		struct dwc3_ep *dep, const struct dwc3_event_depevt *event)
-{
-	unsigned		status = 0;
-	int			clean_busy;
-
-	if (event->status & DEPEVT_STATUS_BUSERR)
-		status = -ECONNRESET;
-
-	clean_busy = dwc3_cleanup_done_reqs(dwc, dep, event, status);
-	if (clean_busy)
-		dep->flags &= ~DWC3_EP_BUSY;
-
+		list_empty(&dep->started_list) &&
+		(list_empty(&dep->pending_list) || status == -EXDEV))
+		dwc3_stop_active_transfer(dep, true, true);
+	else if (dwc3_gadget_ep_should_continue(dep))
+		if (__dwc3_gadget_kick_transfer(dep) == 0)
+			no_started_trb = false;
+
+out:
 	/*
 	 * WORKAROUND: This is the 2nd half of U1/U2 -> U0 workaround.
 	 * See dwc3_gadget_linksts_change_interrupt() for 1st half.
 	 */
-	if (dwc->revision < DWC3_REVISION_183A) {
+	if (DWC3_VER_IS_PRIOR(DWC3, 183A)) {
 		u32		reg;
 		int		i;
 
 		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
 			dep = dwc->eps[i];
+			if (!dep)
+				continue;
 
 			if (!(dep->flags & DWC3_EP_ENABLED))
 				continue;
 
-			if (!list_empty(&dep->req_queued))
-				return;
+			if (!list_empty(&dep->started_list))
+				return no_started_trb;
 		}
 
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -1925,6 +3738,132 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 
 		dwc->u1u2 = 0;
 	}
+
+	return no_started_trb;
+}
+
+static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	int status = 0;
+
+	if (!dep->endpoint.desc)
+		return;
+
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		dwc3_gadget_endpoint_frame_from_event(dep, event);
+
+	if (event->status & DEPEVT_STATUS_BUSERR)
+		status = -ECONNRESET;
+
+	if (event->status & DEPEVT_STATUS_MISSED_ISOC)
+		status = -EXDEV;
+
+	dwc3_gadget_endpoint_trbs_complete(dep, event, status);
+}
+
+static void dwc3_gadget_endpoint_transfer_complete(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	int status = 0;
+
+	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+
+	if (event->status & DEPEVT_STATUS_BUSERR)
+		status = -ECONNRESET;
+
+	if (dwc3_gadget_endpoint_trbs_complete(dep, event, status))
+		dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
+}
+
+static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	dwc3_gadget_endpoint_frame_from_event(dep, event);
+
+	/*
+	 * The XferNotReady event is generated only once before the endpoint
+	 * starts. It will be generated again when END_TRANSFER command is
+	 * issued. For some controller versions, the XferNotReady event may be
+	 * generated while the END_TRANSFER command is still in process. Ignore
+	 * it and wait for the next XferNotReady event after the command is
+	 * completed.
+	 */
+	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
+		return;
+
+	(void) __dwc3_gadget_start_isoc(dep);
+}
+
+static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	u8 cmd = DEPEVT_PARAMETER_CMD(event->parameters);
+
+	if (cmd != DWC3_DEPCMD_ENDTRANSFER)
+		return;
+
+	/*
+	 * The END_TRANSFER command will cause the controller to generate a
+	 * NoStream Event, and it's not due to the host DP NoStream rejection.
+	 * Ignore the next NoStream event.
+	 */
+	if (dep->stream_capable)
+		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
+
+	dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
+	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+	dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+
+	if (dep->flags & DWC3_EP_PENDING_CLEAR_STALL) {
+		struct dwc3 *dwc = dep->dwc;
+
+		dep->flags &= ~DWC3_EP_PENDING_CLEAR_STALL;
+		if (dwc3_send_clear_stall_ep_cmd(dep)) {
+			struct usb_ep *ep0 = &dwc->eps[0]->endpoint;
+
+			dev_err(dwc->dev, "failed to clear STALL on %s\n", dep->name);
+			if (dwc->delayed_status)
+				__dwc3_gadget_ep0_set_halt(ep0, 1);
+			return;
+		}
+
+		dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
+		if (dwc->clear_stall_protocol == dep->number)
+			dwc3_ep0_send_delayed_status(dwc);
+	}
+
+	if ((dep->flags & DWC3_EP_DELAY_START) &&
+	    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		__dwc3_gadget_kick_transfer(dep);
+
+	dep->flags &= ~DWC3_EP_DELAY_START;
+}
+
+static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	if (event->status == DEPEVT_STREAMEVT_FOUND) {
+		cancel_delayed_work(&dep->nostream_work);
+		dep->flags |= DWC3_EP_STREAM_PRIMED;
+		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+		return;
+	}
+
+	/* Note: NoStream rejection event param value is 0 and not 0xFFFF */
+	switch (event->parameters) {
+	case DEPEVT_STREAM_PRIME:
+		cancel_delayed_work(&dep->nostream_work);
+		dep->flags |= DWC3_EP_STREAM_PRIMED;
+		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+		break;
+	case DEPEVT_STREAM_NOSTREAM:
+		dep->flags &= ~DWC3_EP_STREAM_PRIMED;
+		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM)
+			queue_delayed_work(system_wq, &dep->nostream_work,
+					   msecs_to_jiffies(100));
+		break;
+	}
 }
 
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
@@ -1934,9 +3873,20 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	u8			epnum = event->endpoint_number;
 
 	dep = dwc->eps[epnum];
-
-	if (!(dep->flags & DWC3_EP_ENABLED))
+	if (!dep) {
+		dev_warn(dwc->dev, "spurious event, endpoint %u is not allocated\n", epnum);
 		return;
+	}
+
+	if (!(dep->flags & DWC3_EP_ENABLED)) {
+		if ((epnum > 1) && !(dep->flags & DWC3_EP_TRANSFER_STARTED))
+			return;
+
+		/* Handle only EPCMDCMPLT when EP disabled */
+		if ((event->endpoint_event != DWC3_DEPEVT_EPCMDCMPLT) &&
+			!(epnum <= 1 && event->endpoint_event == DWC3_DEPEVT_XFERCOMPLETE))
+			return;
+	}
 
 	if (epnum == 0 || epnum == 1) {
 		dwc3_ep0_interrupt(dwc, event);
@@ -1944,92 +3894,53 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (event->endpoint_event) {
-	case DWC3_DEPEVT_XFERCOMPLETE:
-		dep->resource_index = 0;
-
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			dev_dbg(dwc->dev, "%s is an Isochronous endpoint\n",
-					dep->name);
-			return;
-		}
-
-		dwc3_endpoint_transfer_complete(dwc, dep, event);
-		break;
 	case DWC3_DEPEVT_XFERINPROGRESS:
-		dwc3_endpoint_transfer_complete(dwc, dep, event);
+		dwc3_gadget_endpoint_transfer_in_progress(dep, event);
 		break;
 	case DWC3_DEPEVT_XFERNOTREADY:
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			dwc3_gadget_start_isoc(dwc, dep, event);
-		} else {
-			int ret;
-
-			dev_vdbg(dwc->dev, "%s: reason %s\n",
-					dep->name, event->status &
-					DEPEVT_STATUS_TRANSFER_ACTIVE
-					? "Transfer Active"
-					: "Transfer Not Active");
-
-			ret = __dwc3_gadget_kick_transfer(dep, 0, 1);
-			if (!ret || ret == -EBUSY)
-				return;
-
-			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
-					dep->name);
-		}
-
+		dwc3_gadget_endpoint_transfer_not_ready(dep, event);
+		break;
+	case DWC3_DEPEVT_EPCMDCMPLT:
+		dwc3_gadget_endpoint_command_complete(dep, event);
+		break;
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		dwc3_gadget_endpoint_transfer_complete(dep, event);
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
-		if (!usb_endpoint_xfer_bulk(dep->endpoint.desc)) {
-			dev_err(dwc->dev, "Stream event for non-Bulk %s\n",
-					dep->name);
-			return;
-		}
-
-		switch (event->status) {
-		case DEPEVT_STREAMEVT_FOUND:
-			dev_vdbg(dwc->dev, "Stream %d found and started\n",
-					event->parameters);
-
-			break;
-		case DEPEVT_STREAMEVT_NOTFOUND:
-			/* FALLTHROUGH */
-		default:
-			dev_dbg(dwc->dev, "Couldn't find suitable stream\n");
-		}
+		dwc3_gadget_endpoint_stream_event(dep, event);
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
-		dev_dbg(dwc->dev, "%s FIFO Overrun\n", dep->name);
 		break;
-	case DWC3_DEPEVT_EPCMDCMPLT:
-		dev_vdbg(dwc->dev, "Endpoint Command Complete\n");
+	default:
+		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
 		break;
 	}
 }
 
 static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->disconnect) {
+	if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->disconnect(&dwc->gadget);
+		dwc->gadget_driver->disconnect(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
 
 static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->suspend) {
+	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->suspend(&dwc->gadget);
+		dwc->gadget_driver->suspend(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
 
 static void dwc3_resume_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->resume(&dwc->gadget);
+		dwc->gadget_driver->resume(dwc->gadget);
+		spin_lock(&dwc->lock);
 	}
 }
 
@@ -2038,24 +3949,45 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return;
 
-	if (dwc->gadget.speed != USB_SPEED_UNKNOWN) {
+	if (dwc->async_callbacks && dwc->gadget->speed != USB_SPEED_UNKNOWN) {
 		spin_unlock(&dwc->lock);
-		usb_gadget_udc_reset(&dwc->gadget, dwc->gadget_driver);
+		usb_gadget_udc_reset(dwc->gadget, dwc->gadget_driver);
 		spin_lock(&dwc->lock);
 	}
 }
 
-static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+	bool interrupt)
 {
-	struct dwc3_ep *dep;
-	struct dwc3_gadget_ep_cmd_params params;
-	u32 cmd;
-	int ret;
+	struct dwc3 *dwc = dep->dwc;
 
-	dep = dwc->eps[epnum];
+	/*
+	 * Only issue End Transfer command to the control endpoint of a started
+	 * Data Phase. Typically we should only do so in error cases such as
+	 * invalid/unexpected direction as described in the control transfer
+	 * flow of the programming guide.
+	 */
+	if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
+		return;
+
+	if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
+		return;
+
+	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
+	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
+		return;
 
-	if (!dep->resource_index)
+	/*
+	 * If a Setup packet is received but yet to DMA out, the controller will
+	 * not process the End Transfer command of any endpoint. Polling of its
+	 * DEPCMD.CmdAct may block setting up TRB for Setup packet, causing a
+	 * timeout. Delay issuing the End Transfer command until the Setup TRB is
+	 * prepared.
+	 */
+	if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status) {
+		dep->flags |= DWC3_EP_DELAY_STOP;
 		return;
+	}
 
 	/*
 	 * NOTICE: We are violating what the Databook says about the
@@ -2064,46 +3996,31 @@ static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
 	 * much trouble synchronizing between us and gadget driver.
 	 *
 	 * We have discussed this with the IP Provider and it was
-	 * suggested to giveback all requests here, but give HW some
-	 * extra time to synchronize with the interconnect. We're using
-	 * an arbitraty 100us delay for that.
+	 * suggested to giveback all requests here.
 	 *
 	 * Note also that a similar handling was tested by Synopsys
 	 * (thanks a lot Paul) and nothing bad has come out of it.
-	 * In short, what we're doing is:
+	 * In short, what we're doing is issuing EndTransfer with
+	 * CMDIOC bit set and delay kicking transfer until the
+	 * EndTransfer command had completed.
 	 *
-	 * - Issue EndTransfer WITH CMDIOC bit set
-	 * - Wait 100us
+	 * As of IP version 3.10a of the DWC_usb3 IP, the controller
+	 * supports a mode to work around the above limitation. The
+	 * software can poll the CMDACT bit in the DEPCMD register
+	 * after issuing a EndTransfer command. This mode is enabled
+	 * by writing GUCTL2[14]. This polling is already done in the
+	 * dwc3_send_gadget_ep_cmd() function so if the mode is
+	 * enabled, the EndTransfer command will have completed upon
+	 * returning from this function.
+	 *
+	 * This mode is NOT available on the DWC_usb31 IP.  In this
+	 * case, if the IOC bit is not set, then delay by 1ms
+	 * after issuing the EndTransfer command.  This allows for the
+	 * controller to handle the command completely before DWC3
+	 * remove requests attempts to unmap USB request buffers.
 	 */
 
-	cmd = DWC3_DEPCMD_ENDTRANSFER;
-	cmd |= force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
-	cmd |= DWC3_DEPCMD_CMDIOC;
-	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
-	memset(&params, 0, sizeof(params));
-	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
-	WARN_ON_ONCE(ret);
-	dep->resource_index = 0;
-	dep->flags &= ~DWC3_EP_BUSY;
-	udelay(100);
-}
-
-static void dwc3_stop_active_transfers(struct dwc3 *dwc)
-{
-	u32 epnum;
-
-	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
-		struct dwc3_ep *dep;
-
-		dep = dwc->eps[epnum];
-		if (!dep)
-			continue;
-
-		if (!(dep->flags & DWC3_EP_ENABLED))
-			continue;
-
-		dwc3_remove_requests(dwc, dep);
-	}
+	__dwc3_stop_active_transfer(dep, force, interrupt);
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
@@ -2112,7 +4029,6 @@ static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 
 	for (epnum = 1; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
 		struct dwc3_ep *dep;
-		struct dwc3_gadget_ep_cmd_params params;
 		int ret;
 
 		dep = dwc->eps[epnum];
@@ -2124,9 +4040,7 @@ static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 
 		dep->flags &= ~DWC3_EP_STALL;
 
-		memset(&params, 0, sizeof(params));
-		ret = dwc3_send_gadget_ep_cmd(dwc, dep->number,
-				DWC3_DEPCMD_CLEARSTALL, &params);
+		ret = dwc3_send_clear_stall_ep_cmd(dep);
 		WARN_ON_ONCE(ret);
 	}
 }
@@ -2135,25 +4049,50 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 {
 	int			reg;
 
+	dwc->suspended = false;
+
+	dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RX_DET);
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_INITU1ENA;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
-
 	reg &= ~DWC3_DCTL_INITU2ENA;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
+
+	dwc->connected = false;
 
 	dwc3_disconnect_gadget(dwc);
-	dwc->start_config_issued = false;
 
-	dwc->gadget.speed = USB_SPEED_UNKNOWN;
+	dwc->gadget->speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
-	usb_gadget_set_state(&dwc->gadget, USB_STATE_NOTATTACHED);
+	dwc->gadget->wakeup_armed = false;
+	dwc3_gadget_enable_linksts_evts(dwc, false);
+	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
+
+	dwc3_ep0_reset_state(dwc);
+
+	/*
+	 * Request PM idle to address condition where usage count is
+	 * already decremented to zero, but waiting for the disconnect
+	 * interrupt to set dwc->connected to FALSE.
+	 */
+	pm_request_idle(dwc->dev);
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 {
 	u32			reg;
 
+	dwc->suspended = false;
+
+	/*
+	 * Ideally, dwc3_reset_gadget() would trigger the function
+	 * drivers to stop any active transfers through ep disable.
+	 * However, for functions which defer ep disable, such as mass
+	 * storage, we will need to rely on the call to stop active
+	 * transfers here, and avoid allowing of request queuing.
+	 */
+	dwc->connected = false;
+
 	/*
 	 * WORKAROUND: DWC3 revisions <1.88a have an issue which
 	 * would cause a missing Disconnect Event if there's a
@@ -2171,8 +4110,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	 *
 	 * Our suggested workaround is to follow the Disconnect
 	 * Event steps here, instead, based on a setup_packet_pending
-	 * flag. Such flag gets set whenever we have a XferNotReady
-	 * event on EP0 and gets cleared on XferComplete for the
+	 * flag. Such flag gets set whenever we have a SETUP_PENDING
+	 * status for EP0 TRBs and gets cleared on XferComplete for the
 	 * same endpoint.
 	 *
 	 * Refers to:
@@ -2180,21 +4119,36 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	 * STAR#9000466709: RTL: Device : Disconnect event not
 	 * generated if setup packet pending in FIFO
 	 */
-	if (dwc->revision < DWC3_REVISION_188A) {
+	if (DWC3_VER_IS_PRIOR(DWC3, 188A)) {
 		if (dwc->setup_packet_pending)
 			dwc3_gadget_disconnect_interrupt(dwc);
 	}
 
 	dwc3_reset_gadget(dwc);
 
+	/*
+	 * From SNPS databook section 8.1.2, the EP0 should be in setup
+	 * phase. So ensure that EP0 is in setup phase by issuing a stall
+	 * and restart if EP0 is not in setup phase.
+	 */
+	dwc3_ep0_reset_state(dwc);
+
+	/*
+	 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
+	 * Section 4.1.2 Table 4-2, it states that during a USB reset, the SW
+	 * needs to ensure that it sends "a DEPENDXFER command for any active
+	 * transfers."
+	 */
+	dwc3_stop_active_transfers(dwc);
+	dwc->connected = true;
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 	dwc->test_mode = false;
-
-	dwc3_stop_active_transfers(dwc);
+	dwc->gadget->wakeup_armed = false;
+	dwc3_gadget_enable_linksts_evts(dwc, false);
 	dwc3_clear_stall_all_ep(dwc);
-	dwc->start_config_issued = false;
 
 	/* Reset device address to zero */
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
@@ -2202,46 +4156,47 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 }
 
-static void dwc3_update_ram_clk_sel(struct dwc3 *dwc, u32 speed)
-{
-	u32 reg;
-	u32 usb30_clock = DWC3_GCTL_CLK_BUS;
-
-	/*
-	 * We change the clock only at SS but I dunno why I would want to do
-	 * this. Maybe it becomes part of the power saving plan.
-	 */
-
-	if (speed != DWC3_DSTS_SUPERSPEED)
-		return;
-
-	/*
-	 * RAMClkSel is reset to 0 after USB reset, so it must be reprogrammed
-	 * each time on Connect Done.
-	 */
-	if (!usb30_clock)
-		return;
-
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg |= DWC3_GCTL_RAMCLKSEL(usb30_clock);
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-}
-
 static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 {
 	struct dwc3_ep		*dep;
 	int			ret;
 	u32			reg;
+	u8			lanes = 1;
 	u8			speed;
 
+	if (!dwc->softconnect)
+		return;
+
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	dwc->speed = speed;
 
-	dwc3_update_ram_clk_sel(dwc, speed);
+	if (DWC3_IP_IS(DWC32))
+		lanes = DWC3_DSTS_CONNLANES(reg) + 1;
+
+	dwc->gadget->ssp_rate = USB_SSP_GEN_UNKNOWN;
+
+	/*
+	 * RAMClkSel is reset to 0 after USB reset, so it must be reprogrammed
+	 * each time on Connect Done.
+	 *
+	 * Currently we always use the reset value. If any platform
+	 * wants to set this to a different value, we need to add a
+	 * setting and update GCTL.RAMCLKSEL here.
+	 */
 
 	switch (speed) {
-	case DWC3_DCFG_SUPERSPEED:
+	case DWC3_DSTS_SUPERSPEED_PLUS:
+		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		dwc->gadget->ep0->maxpacket = 512;
+		dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
+
+		if (lanes > 1)
+			dwc->gadget->ssp_rate = USB_SSP_GEN_2x2;
+		else
+			dwc->gadget->ssp_rate = USB_SSP_GEN_2x1;
+		break;
+	case DWC3_DSTS_SUPERSPEED:
 		/*
 		 * WORKAROUND: DWC3 revisions <1.90a have an issue which
 		 * would cause a missing USB3 Reset event.
@@ -2255,35 +4210,38 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		 * STAR#9000483510: RTL: SS : USB3 reset event may
 		 * not be generated always when the link enters poll
 		 */
-		if (dwc->revision < DWC3_REVISION_190A)
+		if (DWC3_VER_IS_PRIOR(DWC3, 190A))
 			dwc3_gadget_reset_interrupt(dwc);
 
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
-		dwc->gadget.ep0->maxpacket = 512;
-		dwc->gadget.speed = USB_SPEED_SUPER;
+		dwc->gadget->ep0->maxpacket = 512;
+		dwc->gadget->speed = USB_SPEED_SUPER;
+
+		if (lanes > 1) {
+			dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
+			dwc->gadget->ssp_rate = USB_SSP_GEN_1x2;
+		}
 		break;
-	case DWC3_DCFG_HIGHSPEED:
+	case DWC3_DSTS_HIGHSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
-		dwc->gadget.ep0->maxpacket = 64;
-		dwc->gadget.speed = USB_SPEED_HIGH;
+		dwc->gadget->ep0->maxpacket = 64;
+		dwc->gadget->speed = USB_SPEED_HIGH;
 		break;
-	case DWC3_DCFG_FULLSPEED2:
-	case DWC3_DCFG_FULLSPEED1:
+	case DWC3_DSTS_FULLSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
-		dwc->gadget.ep0->maxpacket = 64;
-		dwc->gadget.speed = USB_SPEED_FULL;
-		break;
-	case DWC3_DCFG_LOWSPEED:
-		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(8);
-		dwc->gadget.ep0->maxpacket = 8;
-		dwc->gadget.speed = USB_SPEED_LOW;
+		dwc->gadget->ep0->maxpacket = 64;
+		dwc->gadget->speed = USB_SPEED_FULL;
 		break;
 	}
 
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget->ep0->maxpacket;
+
 	/* Enable USB2 LPM Capability */
 
-	if ((dwc->revision > DWC3_REVISION_194A)
-			&& (speed != DWC3_DCFG_SUPERSPEED)) {
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A) &&
+	    !dwc->usb2_gadget_lpm_disable &&
+	    (speed != DWC3_DSTS_SUPERSPEED) &&
+	    (speed != DWC3_DSTS_SUPERSPEED_PLUS)) {
 		reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 		reg |= DWC3_DCFG_LPM_CAP;
 		dwc3_writel(dwc->regs, DWC3_DCFG, reg);
@@ -2291,7 +4249,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~(DWC3_DCTL_HIRD_THRES_MASK | DWC3_DCTL_L1_HIBER_EN);
 
-		reg |= DWC3_DCTL_HIRD_THRES(dwc->hird_threshold);
+		reg |= DWC3_DCTL_HIRD_THRES(dwc->hird_threshold |
+					    (dwc->is_utmi_l1_suspend << 4));
 
 		/*
 		 * When dwc3 revisions >= 2.40a, LPM Erratum is enabled and
@@ -2299,30 +4258,36 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		 * BESL value in the LPM token is less than or equal to LPM
 		 * NYET threshold.
 		 */
-		if (dwc->revision < DWC3_REVISION_240A	&& dwc->has_lpm_erratum)
-			WARN(true, "LPM Erratum not available on dwc3 revisisions < 2.40a\n");
+		WARN_ONCE(DWC3_VER_IS_PRIOR(DWC3, 240A) && dwc->has_lpm_erratum,
+				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
-		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
-			reg |= DWC3_DCTL_LPM_ERRATA(dwc->lpm_nyet_threshold);
+		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A)) {
+			reg &= ~DWC3_DCTL_NYET_THRES_MASK;
+			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
+		}
 
-		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {
+		if (dwc->usb2_gadget_lpm_disable) {
+			reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+			reg &= ~DWC3_DCFG_LPM_CAP;
+			dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+		}
+
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~DWC3_DCTL_HIRD_THRES_MASK;
-		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+		dwc3_gadget_dctl_write_safe(dwc, reg);
 	}
 
 	dep = dwc->eps[0];
-	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, true,
-			false);
+	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_MODIFY);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
 		return;
 	}
 
 	dep = dwc->eps[1];
-	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, true,
-			false);
+	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_MODIFY);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
 		return;
@@ -2337,14 +4302,22 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	 */
 }
 
-static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
+static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
 {
+	dwc->suspended = false;
+
 	/*
 	 * TODO take core out of low power mode when that's
 	 * implemented.
 	 */
 
-	dwc->gadget_driver->resume(&dwc->gadget);
+	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
+		spin_unlock(&dwc->lock);
+		dwc->gadget_driver->resume(dwc->gadget);
+		spin_lock(&dwc->lock);
+	}
+
+	dwc->link_state = evtinfo & DWC3_LINK_STATE_MASK;
 }
 
 static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
@@ -2352,6 +4325,8 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 {
 	enum dwc3_link_state	next = evtinfo & DWC3_LINK_STATE_MASK;
 	unsigned int		pwropt;
+	int			ret;
+	int			intf_id;
 
 	/*
 	 * WORKAROUND: DWC3 < 2.50a have an issue when configured without
@@ -2371,11 +4346,10 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	 * operational mode
 	 */
 	pwropt = DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1);
-	if ((dwc->revision < DWC3_REVISION_250A) &&
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A) &&
 			(pwropt != DWC3_GHWPARAMS1_EN_PWROPT_HIB)) {
 		if ((dwc->link_state == DWC3_LINK_STATE_U3) &&
 				(next == DWC3_LINK_STATE_RESUME)) {
-			dev_vdbg(dwc->dev, "ignoring transition U3 -> Resume\n");
 			return;
 		}
 	}
@@ -2398,7 +4372,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	 * STAR#9000446952: RTL: Device SS : if U1/U2 ->U0 takes >128us
 	 * core send LGO_Ux entering U0
 	 */
-	if (dwc->revision < DWC3_REVISION_183A) {
+	if (DWC3_VER_IS_PRIOR(DWC3, 183A)) {
 		if (next == DWC3_LINK_STATE_U0) {
 			u32	u1u2;
 			u32	reg;
@@ -2417,7 +4391,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 
 				reg &= ~u1u2;
 
-				dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+				dwc3_gadget_dctl_write_safe(dwc, reg);
 				break;
 			default:
 				/* do nothing */
@@ -2427,6 +4401,13 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (next) {
+	case DWC3_LINK_STATE_U0:
+		if (dwc->gadget->wakeup_armed || dwc->wakeup_pending_funcs) {
+			dwc3_gadget_enable_linksts_evts(dwc, false);
+			dwc3_resume_gadget(dwc);
+			dwc->suspended = false;
+		}
+		break;
 	case DWC3_LINK_STATE_U1:
 		if (dwc->speed == USB_SPEED_SUPER)
 			dwc3_suspend_gadget(dwc);
@@ -2444,30 +4425,31 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	}
 
 	dwc->link_state = next;
+
+	/* Proceed with func wakeup if any interfaces that has requested */
+	while (dwc->wakeup_pending_funcs && (next == DWC3_LINK_STATE_U0)) {
+		intf_id = ffs(dwc->wakeup_pending_funcs) - 1;
+		ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
+						       DWC3_DGCMDPAR_DN_FUNC_WAKE |
+						       DWC3_DGCMDPAR_INTF_SEL(intf_id));
+		if (ret)
+			dev_err(dwc->dev, "Failed to send DN wake for intf %d\n", intf_id);
+
+		dwc->wakeup_pending_funcs &= ~BIT(intf_id);
+	}
 }
 
-static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
-		unsigned int evtinfo)
+static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
+					  unsigned int evtinfo)
 {
-	unsigned int is_ss = evtinfo & (1UL << 4);
+	enum dwc3_link_state next = evtinfo & DWC3_LINK_STATE_MASK;
 
-	/**
-	 * WORKAROUND: DWC3 revison 2.20a with hibernation support
-	 * have a known issue which can cause USB CV TD.9.23 to fail
-	 * randomly.
-	 *
-	 * Because of this issue, core could generate bogus hibernation
-	 * events which SW needs to ignore.
-	 *
-	 * Refers to:
-	 *
-	 * STAR#9000546576: Device Mode Hibernation: Issue in USB 2.0
-	 * Device Fallback from SuperSpeed
-	 */
-	if (is_ss ^ (dwc->speed == USB_SPEED_SUPER))
-		return;
+	if (!dwc->suspended && next == DWC3_LINK_STATE_U3) {
+		dwc->suspended = true;
+		dwc3_suspend_gadget(dwc);
+	}
 
-	/* enter hibernation here */
+	dwc->link_state = next;
 }
 
 static void dwc3_gadget_interrupt(struct dwc3 *dwc,
@@ -2484,65 +4466,48 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_conndone_interrupt(dwc);
 		break;
 	case DWC3_DEVICE_EVENT_WAKEUP:
-		dwc3_gadget_wakeup_interrupt(dwc);
+		dwc3_gadget_wakeup_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
-		if (!dwc->has_hibernation) {
-			WARN(1 ,"unexpected hibernation event\n");
-			break;
-		}
-		dwc3_gadget_hibernation_interrupt(dwc, event->event_info);
+		dev_WARN_ONCE(dwc->dev, true, "unexpected hibernation event\n");
 		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
 		break;
-	case DWC3_DEVICE_EVENT_EOPF:
-		dev_vdbg(dwc->dev, "End of Periodic Frame\n");
+	case DWC3_DEVICE_EVENT_SUSPEND:
+		/* It changed to be suspend event for version 2.30a and above */
+		if (!DWC3_VER_IS_PRIOR(DWC3, 230A))
+			dwc3_gadget_suspend_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
-		dev_vdbg(dwc->dev, "Start of Periodic Frame\n");
-		break;
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
-		dev_vdbg(dwc->dev, "Erratic Error\n");
-		break;
 	case DWC3_DEVICE_EVENT_CMD_CMPL:
-		dev_vdbg(dwc->dev, "Command Complete\n");
-		break;
 	case DWC3_DEVICE_EVENT_OVERFLOW:
-		dev_vdbg(dwc->dev, "Overflow\n");
 		break;
 	default:
-		dev_dbg(dwc->dev, "UNKNOWN IRQ %d\n", event->type);
+		dev_WARN(dwc->dev, "UNKNOWN IRQ %d\n", event->type);
 	}
 }
 
 static void dwc3_process_event_entry(struct dwc3 *dwc,
 		const union dwc3_event *event)
 {
-	/* Endpoint IRQ, handle it and return early */
-	if (event->type.is_devspec == 0) {
-		/* depevt */
-		return dwc3_endpoint_interrupt(dwc, &event->depevt);
-	}
+	trace_dwc3_event(event->raw, dwc);
 
-	switch (event->type.type) {
-	case DWC3_EVENT_TYPE_DEV:
+	if (!event->type.is_devspec)
+		dwc3_endpoint_interrupt(dwc, &event->depevt);
+	else if (event->type.type == DWC3_EVENT_TYPE_DEV)
 		dwc3_gadget_interrupt(dwc, &event->devt);
-		break;
-	/* REVISIT what to do with Carkit and I2C events ? */
-	default:
+	else
 		dev_err(dwc->dev, "UNKNOWN IRQ type %d\n", event->raw);
-	}
 }
 
-static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
+static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 {
-	struct dwc3_event_buffer *evt;
+	struct dwc3 *dwc = evt->dwc;
 	irqreturn_t ret = IRQ_NONE;
 	int left;
-	u32 reg;
 
-	evt = dwc->ev_buffs[buf];
 	left = evt->count;
 
 	if (!(evt->flags & DWC3_EVENT_PENDING))
@@ -2551,9 +4516,7 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
 	while (left > 0) {
 		union dwc3_event event;
 
-		dwc3_invalidate_cache((uintptr_t)evt->buf, evt->length);
-
-		event.raw = *(u32 *) (evt->buf + evt->lpos);
+		event.raw = *(u32 *) (evt->cache + evt->lpos);
 
 		dwc3_process_event_entry(dwc, &event);
 
@@ -2566,167 +4529,269 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
 		 * boundary so I worry about that once we try to handle
 		 * that.
 		 */
-		evt->lpos = (evt->lpos + 4) % DWC3_EVENT_BUFFERS_SIZE;
+		evt->lpos = (evt->lpos + 4) % evt->length;
 		left -= 4;
-
-		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(buf), 4);
 	}
 
 	evt->count = 0;
-	evt->flags &= ~DWC3_EVENT_PENDING;
 	ret = IRQ_HANDLED;
 
 	/* Unmask interrupt */
-	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(buf));
-	reg &= ~DWC3_GEVNTSIZ_INTMASK;
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(buf), reg);
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
+		    DWC3_GEVNTSIZ_SIZE(evt->length));
+
+	evt->flags &= ~DWC3_EVENT_PENDING;
+	/*
+	 * Add an explicit write memory barrier to make sure that the update of
+	 * clearing DWC3_EVENT_PENDING is observed in dwc3_check_event_buf()
+	 */
+	wmb();
+
+	if (dwc->imod_interval) {
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
+		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
+	}
 
 	return ret;
 }
 
-static irqreturn_t dwc3_thread_interrupt(int irq, void *_dwc)
+static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 {
-	struct dwc3 *dwc = _dwc;
+	struct dwc3_event_buffer *evt = _evt;
+	struct dwc3 *dwc = evt->dwc;
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
-	int i;
 
+	local_bh_disable();
 	spin_lock_irqsave(&dwc->lock, flags);
-
-	for (i = 0; i < dwc->num_event_buffers; i++)
-		ret |= dwc3_process_event_buf(dwc, i);
-
+	ret = dwc3_process_event_buf(evt);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }
 
-static irqreturn_t dwc3_check_event_buf(struct dwc3 *dwc, u32 buf)
+static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 {
-	struct dwc3_event_buffer *evt;
+	struct dwc3 *dwc = evt->dwc;
+	u32 amount;
 	u32 count;
-	u32 reg;
 
-	evt = dwc->ev_buffs[buf];
+	if (pm_runtime_suspended(dwc->dev)) {
+		dwc->pending_events = true;
+		/*
+		 * Trigger runtime resume. The get() function will be balanced
+		 * after processing the pending events in dwc3_process_pending
+		 * events().
+		 */
+		pm_runtime_get(dwc->dev);
+		disable_irq_nosync(dwc->irq_gadget);
+		return IRQ_HANDLED;
+	}
 
-	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(buf));
+	/*
+	 * With PCIe legacy interrupt, test shows that top-half irq handler can
+	 * be called again after HW interrupt deassertion. Check if bottom-half
+	 * irq event handler completes before caching new event to prevent
+	 * losing events.
+	 */
+	if (evt->flags & DWC3_EVENT_PENDING)
+		return IRQ_HANDLED;
+
+	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
 	count &= DWC3_GEVNTCOUNT_MASK;
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+			count, evt->length);
+		return IRQ_NONE;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
 	/* Mask interrupt */
-	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(buf));
-	reg |= DWC3_GEVNTSIZ_INTMASK;
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(buf), reg);
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
+		    DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
+
+	amount = min(count, evt->length - evt->lpos);
+	memcpy(evt->cache + evt->lpos, evt->buf + evt->lpos, amount);
+
+	if (amount < count)
+		memcpy(evt->cache, evt->buf, count - amount);
+
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
 
 	return IRQ_WAKE_THREAD;
 }
 
-static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
+static irqreturn_t dwc3_interrupt(int irq, void *_evt)
 {
-	struct dwc3			*dwc = _dwc;
-	int				i;
-	irqreturn_t			ret = IRQ_NONE;
+	struct dwc3_event_buffer	*evt = _evt;
 
-	spin_lock(&dwc->lock);
+	return dwc3_check_event_buf(evt);
+}
 
-	for (i = 0; i < dwc->num_event_buffers; i++) {
-		irqreturn_t status;
+static int dwc3_gadget_get_irq(struct dwc3 *dwc)
+{
+	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
+	int irq;
+
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "peripheral");
+	if (irq > 0)
+		goto out;
+
+	if (irq == -EPROBE_DEFER)
+		goto out;
+
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "dwc_usb3");
+	if (irq > 0)
+		goto out;
 
-		status = dwc3_check_event_buf(dwc, i);
-		if (status == IRQ_WAKE_THREAD)
-			ret = status;
-	}
+	if (irq == -EPROBE_DEFER)
+		goto out;
 
-	spin_unlock(&dwc->lock);
+	irq = platform_get_irq(dwc3_pdev, 0);
+
+out:
+	return irq;
+}
+
+static void dwc_gadget_release(struct device *dev)
+{
+	struct usb_gadget *gadget = container_of(dev, struct usb_gadget, dev);
 
-	return ret;
+	kfree(gadget);
 }
 
 /**
- * dwc3_gadget_init - Initializes gadget related registers
+ * dwc3_gadget_init - initializes gadget related registers
  * @dwc: pointer to our controller context structure
  *
  * Returns 0 on success otherwise negative errno.
  */
 int dwc3_gadget_init(struct dwc3 *dwc)
 {
-	int					ret;
+	int ret;
+	int irq;
+	struct device *dev;
 
-	dwc->ctrl_req = dma_alloc_coherent(sizeof(*dwc->ctrl_req),
-					(unsigned long *)&dwc->ctrl_req_addr);
-	if (!dwc->ctrl_req) {
-		dev_err(dwc->dev, "failed to allocate ctrl request\n");
-		ret = -ENOMEM;
+	irq = dwc3_gadget_get_irq(dwc);
+	if (irq < 0) {
+		ret = irq;
 		goto err0;
 	}
 
-	dwc->ep0_trb = dma_alloc_coherent(sizeof(*dwc->ep0_trb) * 2,
-					  (unsigned long *)&dwc->ep0_trb_addr);
+	dwc->irq_gadget = irq;
+
+	dwc->ep0_trb = dma_alloc_coherent(dwc->sysdev,
+					  sizeof(*dwc->ep0_trb) * 2,
+					  &dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
 		ret = -ENOMEM;
-		goto err1;
+		goto err0;
 	}
 
-	dwc->setup_buf = dma_alloc_coherent(DWC3_EP0_BOUNCE_SIZE,
-					(unsigned long *)&dwc->setup_buf_addr);
+	dwc->setup_buf = kzalloc(DWC3_EP0_SETUP_SIZE, GFP_KERNEL);
 	if (!dwc->setup_buf) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	dwc->bounce = dma_alloc_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE,
+			&dwc->bounce_addr, GFP_KERNEL);
+	if (!dwc->bounce) {
 		ret = -ENOMEM;
 		goto err2;
 	}
 
-	dwc->ep0_bounce = dma_alloc_coherent(DWC3_EP0_BOUNCE_SIZE,
-					(unsigned long *)&dwc->ep0_bounce_addr);
-	if (!dwc->ep0_bounce) {
-		dev_err(dwc->dev, "failed to allocate ep0 bounce buffer\n");
+	init_completion(&dwc->ep0_in_setup);
+	dwc->gadget = kzalloc(sizeof(struct usb_gadget), GFP_KERNEL);
+	if (!dwc->gadget) {
 		ret = -ENOMEM;
 		goto err3;
 	}
 
-	dwc->gadget.ops			= &dwc3_gadget_ops;
-	dwc->gadget.max_speed		= USB_SPEED_SUPER;
-	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
-	dwc->gadget.name		= "dwc3-gadget";
+
+	usb_initialize_gadget(dwc->dev, dwc->gadget, dwc_gadget_release);
+	dev				= &dwc->gadget->dev;
+	dev->platform_data		= dwc;
+	dwc->gadget->ops		= &dwc3_gadget_ops;
+	dwc->gadget->speed		= USB_SPEED_UNKNOWN;
+	dwc->gadget->ssp_rate		= USB_SSP_GEN_UNKNOWN;
+	dwc->gadget->sg_supported	= true;
+	dwc->gadget->name		= "dwc3-gadget";
+	dwc->gadget->lpm_capable	= !dwc->usb2_gadget_lpm_disable;
+	dwc->gadget->wakeup_capable	= true;
 
 	/*
-	 * Per databook, DWC3 needs buffer size to be aligned to MaxPacketSize
-	 * on ep out.
+	 * FIXME We might be setting max_speed to <SUPER, however versions
+	 * <2.20a of dwc3 have an issue with metastability (documented
+	 * elsewhere in this driver) which tells us we can't set max speed to
+	 * anything lower than SUPER.
+	 *
+	 * Because gadget.max_speed is only used by composite.c and function
+	 * drivers (i.e. it won't go into dwc3's registers) we are allowing this
+	 * to happen so we avoid sending SuperSpeed Capability descriptor
+	 * together with our BOS descriptor as that could confuse host into
+	 * thinking we can handle super speed.
+	 *
+	 * Note that, in fact, we won't even support GetBOS requests when speed
+	 * is less than super speed because we don't have means, yet, to tell
+	 * composite.c that we are USB 2.0 + LPM ECN.
 	 */
-	dwc->gadget.quirk_ep_out_aligned_size = true;
+	if (DWC3_VER_IS_PRIOR(DWC3, 220A) &&
+	    !dwc->dis_metastability_quirk)
+		dev_info(dwc->dev, "changing max_speed on rev %08x\n",
+				dwc->revision);
+
+	dwc->gadget->max_speed		= dwc->maximum_speed;
+	dwc->gadget->max_ssp_rate	= dwc->max_ssp_rate;
 
 	/*
 	 * REVISIT: Here we should clear all pending IRQs to be
 	 * sure we're starting from a well known location.
 	 */
 
-	ret = dwc3_gadget_init_endpoints(dwc);
+	ret = dwc3_gadget_init_endpoints(dwc, dwc->num_eps);
 	if (ret)
 		goto err4;
 
-	ret = usb_add_gadget_udc((struct device *)dwc->dev, &dwc->gadget);
+	ret = usb_add_gadget(dwc->gadget);
 	if (ret) {
-		dev_err(dwc->dev, "failed to register udc\n");
-		goto err4;
+		dev_err(dwc->dev, "failed to add gadget\n");
+		goto err5;
 	}
 
+	if (DWC3_IP_IS(DWC32) && dwc->maximum_speed == USB_SPEED_SUPER_PLUS)
+		dwc3_gadget_set_ssp_rate(dwc->gadget, dwc->max_ssp_rate);
+	else
+		dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
+
+	/* No system wakeup if no gadget driver bound */
+	if (dwc->sys_wakeup)
+		device_wakeup_disable(dwc->sysdev);
+
 	return 0;
 
+err5:
+	dwc3_gadget_free_endpoints(dwc);
 err4:
-	dwc3_gadget_free_endpoints(dwc);
-	dma_free_coherent(dwc->ep0_bounce);
-
+	usb_put_gadget(dwc->gadget);
+	dwc->gadget = NULL;
 err3:
-	dma_free_coherent(dwc->setup_buf);
+	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
+			dwc->bounce_addr);
 
 err2:
-	dma_free_coherent(dwc->ep0_trb);
+	kfree(dwc->setup_buf);
 
 err1:
-	dma_free_coherent(dwc->ctrl_req);
+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
+			dwc->ep0_trb, dwc->ep0_trb_addr);
 
 err0:
 	return ret;
@@ -2736,41 +4801,48 @@ err0:
 
 void dwc3_gadget_exit(struct dwc3 *dwc)
 {
-	usb_del_gadget_udc(&dwc->gadget);
+	if (!dwc->gadget)
+		return;
 
+	dwc3_enable_susphy(dwc, false);
+	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
-
-	dma_free_coherent(dwc->ep0_bounce);
-
-	dma_free_coherent(dwc->setup_buf);
-
-	dma_free_coherent(dwc->ep0_trb);
-
-	dma_free_coherent(dwc->ctrl_req);
+	usb_put_gadget(dwc->gadget);
+	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
+			  dwc->bounce_addr);
+	kfree(dwc->setup_buf);
+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
+			  dwc->ep0_trb, dwc->ep0_trb_addr);
 }
 
-/**
- * dwc3_gadget_uboot_handle_interrupt - handle dwc3 gadget interrupt
- * @dwc: struct dwce *
- *
- * Handles ep0 and gadget interrupt
- *
- * Should be called from dwc3 core.
- */
-void dwc3_gadget_uboot_handle_interrupt(struct dwc3 *dwc)
+int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
-	int ret = dwc3_interrupt(0, dwc);
+	unsigned long flags;
+	int ret;
 
-	if (ret == IRQ_WAKE_THREAD) {
-		int i;
-		struct dwc3_event_buffer *evt;
-
-		dwc3_thread_interrupt(0, dwc);
-
-		/* Clean + Invalidate the buffers after touching them */
-		for (i = 0; i < dwc->num_event_buffers; i++) {
-			evt = dwc->ev_buffs[i];
-			dwc3_flush_cache((uintptr_t)evt->buf, evt->length);
-		}
+	ret = dwc3_gadget_soft_disconnect(dwc);
+	/*
+	 * Attempt to reset the controller's state. Likely no
+	 * communication can be established until the host
+	 * performs a port reset.
+	 */
+	if (ret && dwc->softconnect) {
+		dwc3_gadget_soft_connect(dwc);
+		return -EAGAIN;
 	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
+}
+
+int dwc3_gadget_resume(struct dwc3 *dwc)
+{
+	if (!dwc->gadget_driver || !dwc->softconnect)
+		return 0;
+
+	return dwc3_gadget_soft_connect(dwc);
 }
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index f28a9755dcb3..d73e735e4081 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -1,18 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/gadget.h) and ported
- * to uboot.
- *
- * commit 7a60855972 : usb: dwc3: gadget: fix set_halt() bug with pending
-		       transfers
- *
  */
 
 #ifndef __DRIVERS_USB_DWC3_GADGET_H
@@ -24,55 +17,91 @@
 
 struct dwc3;
 #define to_dwc3_ep(ep)		(container_of(ep, struct dwc3_ep, endpoint))
-#define gadget_to_dwc(g)	(container_of(g, struct dwc3, gadget))
+#define gadget_to_dwc(g)	(dev_get_platdata(&g->dev))
 
 /* DEPCFG parameter 1 */
-#define DWC3_DEPCFG_INT_NUM(n)		((n) << 0)
-#define DWC3_DEPCFG_XFER_COMPLETE_EN	(1 << 8)
-#define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	(1 << 9)
-#define DWC3_DEPCFG_XFER_NOT_READY_EN	(1 << 10)
-#define DWC3_DEPCFG_FIFO_ERROR_EN	(1 << 11)
-#define DWC3_DEPCFG_STREAM_EVENT_EN	(1 << 13)
-#define DWC3_DEPCFG_BINTERVAL_M1(n)	((n) << 16)
-#define DWC3_DEPCFG_STREAM_CAPABLE	(1 << 24)
-#define DWC3_DEPCFG_EP_NUMBER(n)	((n) << 25)
-#define DWC3_DEPCFG_BULK_BASED		(1 << 30)
-#define DWC3_DEPCFG_FIFO_BASED		(1 << 31)
+#define DWC3_DEPCFG_INT_NUM(n)		(((n) & 0x1f) << 0)
+#define DWC3_DEPCFG_XFER_COMPLETE_EN	BIT(8)
+#define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	BIT(9)
+#define DWC3_DEPCFG_XFER_NOT_READY_EN	BIT(10)
+#define DWC3_DEPCFG_FIFO_ERROR_EN	BIT(11)
+#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(13)
+#define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
+#define DWC3_DEPCFG_STREAM_CAPABLE	BIT(24)
+#define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)
+#define DWC3_DEPCFG_BULK_BASED		BIT(30)
+#define DWC3_DEPCFG_FIFO_BASED		BIT(31)
 
 /* DEPCFG parameter 0 */
-#define DWC3_DEPCFG_EP_TYPE(n)		((n) << 1)
-#define DWC3_DEPCFG_MAX_PACKET_SIZE(n)	((n) << 3)
-#define DWC3_DEPCFG_FIFO_NUMBER(n)	((n) << 17)
-#define DWC3_DEPCFG_BURST_SIZE(n)	((n) << 22)
+#define DWC3_DEPCFG_EP_TYPE(n)		(((n) & 0x3) << 1)
+#define DWC3_DEPCFG_MAX_PACKET_SIZE(n)	(((n) & 0x7ff) << 3)
+#define DWC3_DEPCFG_FIFO_NUMBER(n)	(((n) & 0x1f) << 17)
+#define DWC3_DEPCFG_BURST_SIZE(n)	(((n) & 0xf) << 22)
 #define DWC3_DEPCFG_DATA_SEQ_NUM(n)	((n) << 26)
 /* This applies for core versions earlier than 1.94a */
-#define DWC3_DEPCFG_IGN_SEQ_NUM		(1 << 31)
+#define DWC3_DEPCFG_IGN_SEQ_NUM		BIT(31)
 /* These apply for core versions 1.94a and later */
 #define DWC3_DEPCFG_ACTION_INIT		(0 << 30)
-#define DWC3_DEPCFG_ACTION_RESTORE	(1 << 30)
+#define DWC3_DEPCFG_ACTION_RESTORE	BIT(30)
 #define DWC3_DEPCFG_ACTION_MODIFY	(2 << 30)
 
 /* DEPXFERCFG parameter 0 */
 #define DWC3_DEPXFERCFG_NUM_XFER_RES(n)	((n) & 0xffff)
 
+/* U1 Device exit Latency */
+#define DWC3_DEFAULT_U1_DEV_EXIT_LAT	0x0A	/* Less then 10 microsec */
+
+/* U2 Device exit Latency */
+#define DWC3_DEFAULT_U2_DEV_EXIT_LAT	0x1FF	/* Less then 511 microsec */
+
+/* Frame/Microframe Number Mask */
+#define DWC3_FRNUMBER_MASK		0x3fff
 /* -------------------------------------------------------------------------- */
 
 #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, request))
 
+/**
+ * next_request - gets the next request on the given list
+ * @list: the request list to operate on
+ *
+ * Caller should take care of locking. This function return %NULL or the first
+ * request available on @list.
+ */
 static inline struct dwc3_request *next_request(struct list_head *list)
 {
-	if (list_empty(list))
-		return NULL;
+	return list_first_entry_or_null(list, struct dwc3_request, list);
+}
+
+/**
+ * dwc3_gadget_move_started_request - move @req to the started_list
+ * @req: the request to be moved
+ *
+ * Caller should take care of locking. This function will move @req from its
+ * current list to the endpoint's started_list.
+ */
+static inline void dwc3_gadget_move_started_request(struct dwc3_request *req)
+{
+	struct dwc3_ep		*dep = req->dep;
 
-	return list_first_entry(list, struct dwc3_request, list);
+	req->status = DWC3_REQUEST_STATUS_STARTED;
+	list_move_tail(&req->list, &dep->started_list);
 }
 
-static inline void dwc3_gadget_move_request_queued(struct dwc3_request *req)
+/**
+ * dwc3_gadget_move_cancelled_request - move @req to the cancelled_list
+ * @req: the request to be moved
+ * @reason: cancelled reason for the dwc3 request
+ *
+ * Caller should take care of locking. This function will move @req from its
+ * current list to the endpoint's cancelled_list.
+ */
+static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req,
+		unsigned int reason)
 {
 	struct dwc3_ep		*dep = req->dep;
 
-	req->queued = true;
-	list_move_tail(&req->list, &dep->req_queued);
+	req->status = reason;
+	list_move_tail(&req->list, &dep->cancelled_list);
 }
 
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
@@ -81,27 +110,44 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event);
 void dwc3_ep0_out_start(struct dwc3 *dwc);
+void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep);
+void dwc3_ep0_stall_and_restart(struct dwc3 *dwc);
 int __dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
 int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
 int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 		gfp_t gfp_flags);
 int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
-void dwc3_gadget_uboot_handle_interrupt(struct dwc3 *dwc);
+void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt);
+int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
- * @dwc: DesignWare USB3 Pointer
- * @number: DWC endpoint number
+ * @dep: dwc3 endpoint
  *
- * Caller should take care of locking
+ * Caller should take care of locking. Returns the transfer resource
+ * index for a given endpoint.
  */
-static inline u32 dwc3_gadget_ep_get_transfer_index(struct dwc3 *dwc, u8 number)
+static inline void dwc3_gadget_ep_get_transfer_index(struct dwc3_ep *dep)
 {
 	u32			res_id;
 
-	res_id = dwc3_readl(dwc->regs, DWC3_DEPCMD(number));
+	res_id = dwc3_readl(dep->regs, DWC3_DEPCMD);
+	dep->resource_index = DWC3_DEPCMD_GET_RSC_IDX(res_id);
+}
 
-	return DWC3_DEPCMD_GET_RSC_IDX(res_id);
+/**
+ * dwc3_gadget_dctl_write_safe - write to DCTL safe from link state change
+ * @dwc: pointer to our context structure
+ * @value: value to write to DCTL
+ *
+ * Use this function when doing read-modify-write to DCTL. It will not
+ * send link state change request.
+ */
+static inline void dwc3_gadget_dctl_write_safe(struct dwc3 *dwc, u32 value)
+{
+	value &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
+	dwc3_writel(dwc->regs, DWC3_DCTL, value);
 }
 
 #endif /* __DRIVERS_USB_DWC3_GADGET_H */
diff --git a/drivers/usb/dwc3/glue.h b/drivers/usb/dwc3/glue.h
new file mode 100644
index 000000000000..2efd00e763be
--- /dev/null
+++ b/drivers/usb/dwc3/glue.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * glue.h - DesignWare USB3 DRD glue header
+ */
+
+#ifndef __DRIVERS_USB_DWC3_GLUE_H
+#define __DRIVERS_USB_DWC3_GLUE_H
+
+#include <linux/types.h>
+#include "core.h"
+
+/**
+ * dwc3_probe_data: Initialization parameters passed to dwc3_core_probe()
+ * @dwc: Reference to dwc3 context structure
+ * @res: resource for the DWC3 core mmio region
+ * @ignore_clocks_and_resets: clocks and resets defined for the device should
+ *		be ignored by the DWC3 core, as they are managed by the glue
+ */
+struct dwc3_probe_data {
+	struct dwc3 *dwc;
+	struct resource *res;
+	bool ignore_clocks_and_resets;
+};
+
+int dwc3_core_probe(const struct dwc3_probe_data *data);
+void dwc3_core_remove(struct dwc3 *dwc);
+
+int dwc3_runtime_suspend(struct dwc3 *dwc);
+int dwc3_runtime_resume(struct dwc3 *dwc);
+int dwc3_runtime_idle(struct dwc3 *dwc);
+int dwc3_pm_suspend(struct dwc3 *dwc);
+int dwc3_pm_resume(struct dwc3 *dwc);
+void dwc3_pm_complete(struct dwc3 *dwc);
+int dwc3_pm_prepare(struct dwc3 *dwc);
+
+#endif
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index c1ab02881424..1e96ea339d48 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -1,29 +1,23 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * io.h - DesignWare USB3 DRD IO Header
  *
- * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/io.h) and ported
- * to uboot.
- *
- * commit 2c4cbe6e5a : usb: dwc3: add tracepoints to aid debugging
- *
  */
 
 #ifndef __DRIVERS_USB_DWC3_IO_H
 #define __DRIVERS_USB_DWC3_IO_H
 
-#include <cpu_func.h>
-#include <asm/io.h>
+#include <linux/io.h>
+#include "trace.h"
+#include "debug.h"
+#include "core.h"
 
-#define	CACHELINE_SIZE		CONFIG_SYS_CACHELINE_SIZE
 static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 {
-	unsigned long offs = offset - DWC3_GLOBALS_REGS_START;
 	u32 value;
 
 	/*
@@ -31,36 +25,33 @@ static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 	 * space, see dwc3_probe in core.c.
 	 * However, the offsets are given starting from xHCI address space.
 	 */
-	value = readl(base + offs);
+	value = readl(base + offset - DWC3_GLOBALS_REGS_START);
+
+	/*
+	 * When tracing we want to make it easy to find the correct address on
+	 * documentation, so we revert it back to the proper addresses, the
+	 * same way they are described on SNPS documentation
+	 */
+	trace_dwc3_readl(base - DWC3_GLOBALS_REGS_START, offset, value);
 
 	return value;
 }
 
 static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 {
-	unsigned long offs = offset - DWC3_GLOBALS_REGS_START;
-
 	/*
 	 * We requested the mem region starting from the Globals address
 	 * space, see dwc3_probe in core.c.
 	 * However, the offsets are given starting from xHCI address space.
 	 */
-	writel(value, base + offs);
+	writel(value, base + offset - DWC3_GLOBALS_REGS_START);
+
+	/*
+	 * When tracing we want to make it easy to find the correct address on
+	 * documentation, so we revert it back to the proper addresses, the
+	 * same way they are described on SNPS documentation
+	 */
+	trace_dwc3_writel(base - DWC3_GLOBALS_REGS_START, offset, value);
 }
 
-static inline void dwc3_flush_cache(uintptr_t addr, int length)
-{
-	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
-	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
-
-	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
-}
-
-static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
-{
-	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
-	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
-
-	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
-}
 #endif /* __DRIVERS_USB_DWC3_IO_H */
diff --git a/drivers/usb/dwc3/linux-compat.h b/drivers/usb/dwc3/linux-compat.h
deleted file mode 100644
index 563f8727cdde..000000000000
--- a/drivers/usb/dwc3/linux-compat.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/**
- * linux-compat.h - DesignWare USB3 Linux Compatibiltiy Adapter  Header
- *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
- *
- * Authors: Kishon Vijay Abraham I <kishon@ti.com>
- *
- */
-
-#ifndef __DWC3_LINUX_COMPAT__
-#define __DWC3_LINUX_COMPAT__
-
-#define dev_WARN(dev, format, arg...)	debug(format, ##arg)
-
-#endif
diff --git a/drivers/usb/dwc3/samsung_usb_phy.c b/drivers/usb/dwc3/samsung_usb_phy.c
deleted file mode 100644
index 3563070cb85d..000000000000
--- a/drivers/usb/dwc3/samsung_usb_phy.c
+++ /dev/null
@@ -1,77 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/**
- * samsung_usb_phy.c - DesignWare USB3 (DWC3) PHY handling file
- *
- * Copyright (C) 2015 Samsung Electronics
- *
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- */
-
-#include <asm/io.h>
-#include <asm/arch/power.h>
-#include <asm/arch/xhci-exynos.h>
-#include <linux/delay.h>
-
-void exynos5_usb3_phy_init(struct exynos_usb3_phy *phy)
-{
-	u32 reg;
-
-	/* Reset USB 3.0 PHY */
-	writel(0x0, &phy->phy_reg0);
-
-	clrbits_le32(&phy->phy_param0,
-			/* Select PHY CLK source */
-			PHYPARAM0_REF_USE_PAD |
-			/* Set Loss-of-Signal Detector sensitivity */
-			PHYPARAM0_REF_LOSLEVEL_MASK);
-	setbits_le32(&phy->phy_param0, PHYPARAM0_REF_LOSLEVEL);
-
-	writel(0x0, &phy->phy_resume);
-
-	/*
-	 * Setting the Frame length Adj value[6:1] to default 0x20
-	 * See xHCI 1.0 spec, 5.2.4
-	 */
-	setbits_le32(&phy->link_system,
-			LINKSYSTEM_XHCI_VERSION_CONTROL |
-			LINKSYSTEM_FLADJ(0x20));
-
-	/* Set Tx De-Emphasis level */
-	clrbits_le32(&phy->phy_param1, PHYPARAM1_PCS_TXDEEMPH_MASK);
-	setbits_le32(&phy->phy_param1, PHYPARAM1_PCS_TXDEEMPH);
-
-	setbits_le32(&phy->phy_batchg, PHYBATCHG_UTMI_CLKSEL);
-
-	/* PHYTEST POWERDOWN Control */
-	clrbits_le32(&phy->phy_test,
-			PHYTEST_POWERDOWN_SSP |
-			PHYTEST_POWERDOWN_HSP);
-
-	/* UTMI Power Control */
-	writel(PHYUTMI_OTGDISABLE, &phy->phy_utmi);
-
-		/* Use core clock from main PLL */
-	reg = PHYCLKRST_REFCLKSEL_EXT_REFCLK |
-		/* Default 24Mhz crystal clock */
-		PHYCLKRST_FSEL(FSEL_CLKSEL_24M) |
-		PHYCLKRST_MPLL_MULTIPLIER_24MHZ_REF |
-		PHYCLKRST_SSC_REFCLKSEL(0) |
-		/* Force PortReset of PHY */
-		PHYCLKRST_PORTRESET |
-		/* Digital power supply in normal operating mode */
-		PHYCLKRST_RETENABLEN |
-		/* Enable ref clock for SS function */
-		PHYCLKRST_REF_SSP_EN |
-		/* Enable spread spectrum */
-		PHYCLKRST_SSC_EN |
-		/* Power down HS Bias and PLL blocks in suspend mode */
-		PHYCLKRST_COMMONONN;
-
-	writel(reg, &phy->phy_clk_rst);
-
-	/* giving time to Phy clock to settle before resetting */
-	udelay(10);
-
-	reg &= ~PHYCLKRST_PORTRESET;
-	writel(reg, &phy->phy_clk_rst);
-}
diff --git a/drivers/usb/dwc3/ti_usb_phy.c b/drivers/usb/dwc3/ti_usb_phy.c
index f0ecdea958ae..f1ddc0086945 100644
--- a/drivers/usb/dwc3/ti_usb_phy.c
+++ b/drivers/usb/dwc3/ti_usb_phy.c
@@ -27,8 +27,6 @@
 #include <asm/arch/sys_proto.h>
 #include <dm.h>
 
-#include "linux-compat.h"
-
 #define PLL_STATUS		0x00000004
 #define PLL_GO			0x00000008
 #define PLL_CONFIGURATION1	0x0000000C
-- 
2.48.1

