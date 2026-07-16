Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C90FC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD7784DCD;
	Thu, 16 Jul 2026 18:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KKlFyJlI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1464184C3F; Thu, 16 Jul 2026 15:43:46 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D4E84CEB
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698ae9da373so957665a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209423; x=1784814223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R1v5p8AkfPM0cNXWW3XNvwF8wZ834HVlF8yGqOJAH7g=;
 b=KKlFyJlIo0v5Vm/LzIn44ykr8WrhN8zRawMuERWJf6rfMmbxyr7fn8JpTfyujbuaph
 LxiC4NOfIt4QZgLH1cnG2/tqigWSDN4CnsEU/1IEP6XIKWdadql8mRKxpHtmp6v3sn02
 X3u75EUMocp+kzjjEaMWzA6uKVakgV34YlzCWOg5e9fZxIVDSZUGo0p6vK035SiWr6V7
 DNwE4LuLLcyA3bin3VxiB0UFvucLaSAnPAIV0+2m89cNQKcBLtx05tZFxC9UI+MfX0jD
 7z8yJyU8M+YZf/nCcl+NQXKHPROPleA5bv5bhMqyHMgRpGyNu1P6tgLN5kmvvx3J5BIZ
 bmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209423; x=1784814223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R1v5p8AkfPM0cNXWW3XNvwF8wZ834HVlF8yGqOJAH7g=;
 b=W7QbIG315nUhSHwrLwVXjZhH3NTtOmhFe0QLVXr/1EOnP/CpJ22/ZnoExe5vjXcr0T
 iyzAjYlC0eDA1fVRcETpxW2q0V+3sUKL8+m0qGjwViYqAQJ3Xj0tbVbQR5Kvn2caWtpi
 3e+qPzR+Tv0+392o0u144QGNXMy87sKK2NrPKC8mgsry1HV9Eo097jLh9vL9kQNsVkA5
 Feog0hVb7dCqwILItRt5r0nshfotVv8P5jG/gx/uadhr28xLo1Zn7SAYIqGs19weVY+s
 ZV/kO+ilNL2rlPe2zuFF+bOLndxVtr+OENd1C0tN3hET5/7g+guyYKhQs2+GUSXdVhsl
 xrRA==
X-Gm-Message-State: AOJu0YwzU+GQhgcXVkeF5HaHzVVcFClBYXJLXpgmSXIIJcP3T82ZVY+D
 aoaVPeN9oy4cV165pw5hz1ZZpYVgp+kF+mIejQG3i+Mv/nUCU7oeFQXA3X6nsYw05U+Bb5i3yyE
 g9IiL
X-Gm-Gg: AfdE7clzBpwa0qJfU3HMbWABkxA1EDz0xqcX7Myw4d2taiA/t6MSslU18B4ikuqGKME
 6PJerkgfcl40lnEOI64K/MBFrSLg01sud7/YIerqMRGA85V9g9V8NJz4korWZtJNoB6u6Jl3dIc
 ZIoEunsyGcePh9NQh1WYh0l/oWBVsiCs7KcJAIlUyeVMfiKi4ETuoABXE06t+QBOsvjIqxV5NNa
 xlP4DTAqRFY0mrERk06nI0HPdGyyn5qAuHWBH8cykuWHpY7t5mfXVmlUH8qGaPx8mKI9YNmODnE
 PbfxmqMRpZlEzOeQgxY/5f0dH8oimquHEYUO7JC2+Ofca4O3vYLJnXMfiKD8xtnidpXiwzVGI4C
 4MdJqgaZgxDGasDHO5jsNXcMV8zjV3eGocC+FaEzgnX5CGm1qf1q/plvkUcWj7rLAXf5AcRG/ud
 lmjaIa643cTbNe/86HkA4RfsRmTwHnAvOiAQMsNQ==
X-Received: by 2002:a05:6402:5190:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-69c5ef8767bmr6976919a12.2.1784209422727; 
 Thu, 16 Jul 2026 06:43:42 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69cd28a17d3sm4684408a12.12.2026.07.16.06.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:41 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 22/75] usb: dwc3: import from kernel v4.19
Date: Thu, 16 Jul 2026 15:41:52 +0200
Message-ID: <20260716134305.614278-23-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.18 to v4.19.

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

List of commits: git log --oneline v4.18..v4.19
Commits imported:
4e3121abcf53 usb/dwc3/gadget: fix kernel-doc parameter warning
b497fff6f59e usb: dwc3: pci: Fix return value check in dwc3_byt_enable_ulpi_refclock()
66174b6998a6 usb: dwc3: of-simple: avoid unused function warnings
4ea438da76f4 usb: dwc3: gadget: Check MaxPacketSize from descriptor
b138e23d3dff usb: dwc3: core: Enable AutoRetry feature in the controller
a77004681148 usb: dwc3: Set default mode for dwc_usb31
c31d983beaf0 usb: dwc3: pci: Intel Merrifield can be host
1a7b12f69a94 usb: dwc3: pci: Supply device properties via driver data
d9612c2f0449 usb: dwc3: Enable undefined length INCR burst type
d635db5508b0 usb: dwc3: add global soc bus configuration reg0
87d852de94d6 usb: dwc3: Describe 'wakeup_work' field of struct dwc3_pci
9a7faac36502 usb: dwc3: change stream event enable bit back to 13
76251db86561 usb: dwc3: of-simple: reset host controller at suspend/resume
211f658b7b40 usb: dwc3: pci: Use devm functions to get the phy GPIOs
7740d04d901d usb: dwc3: pci: Enable ULPI Refclk on platforms where the firmware does not
5741022cbdf3 usb: dwc3: pci: Add GPIO lookup table on platforms without ACPI GPIO resources
3fe314ca8c97 usb: dwc3: Add a glue driver for Synopsys HAPS platform
db9fc500e85a usb: dwc3: gadget: remove redundant variable maxpacket

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c   | 118 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h   |  17 ++++++
 drivers/usb/dwc3/gadget.c |   3 +-
 drivers/usb/dwc3/gadget.h |   2 +-
 4 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 103807587dc6..88c80fcc39f5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -78,6 +78,14 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 			mode = USB_DR_MODE_HOST;
 		else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
 			mode = USB_DR_MODE_PERIPHERAL;
+
+		/*
+		 * dwc_usb31 does not support OTG mode. If the controller
+		 * supports DRD but the dr_mode is not specified or set to OTG,
+		 * then set the mode to peripheral.
+		 */
+		if (mode == USB_DR_MODE_OTG && dwc3_is_usb31(dwc))
+			mode = USB_DR_MODE_PERIPHERAL;
 	}
 
 	if (mode != dwc->dr_mode) {
@@ -778,6 +786,98 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 static int dwc3_core_get_phy(struct dwc3 *dwc);
 static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
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
+	ntype = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", NULL, 0);
+	if (ntype <= 0)
+		return;
+
+	vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
+	if (!vals) {
+		dev_err(dev, "Error to get memory\n");
+		return;
+	}
+
+	/* Get INCR burst type, and parse it */
+	ret = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", vals, ntype);
+	if (ret) {
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
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -840,6 +940,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc);
 
+	dwc3_set_incr_burst_type(dwc);
+
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
@@ -883,6 +985,22 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
+	if (dwc->dr_mode == USB_DR_MODE_HOST ||
+	    dwc->dr_mode == USB_DR_MODE_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+
+		/*
+		 * Enable Auto retry Feature to make the controller operating in
+		 * Host mode on seeing transaction errors(CRC errors or internal
+		 * overrun scenerios) on IN transfers to reply to the device
+		 * with a non-terminating retry ACK (i.e, an ACK transcation
+		 * packet with Retry=1 & Nump != 0)
+		 */
+		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+	}
+
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 285ce0ef3b91..5bfb62533e0f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -163,6 +163,17 @@
 
 /* Bit fields */
 
+/* Global SoC Bus Configuration INCRx Register 0 */
+#define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
+#define DWC3_GSBUSCFG0_INCR128BRSTENA	(1 << 6) /* INCR128 burst */
+#define DWC3_GSBUSCFG0_INCR64BRSTENA	(1 << 5) /* INCR64 burst */
+#define DWC3_GSBUSCFG0_INCR32BRSTENA	(1 << 4) /* INCR32 burst */
+#define DWC3_GSBUSCFG0_INCR16BRSTENA	(1 << 3) /* INCR16 burst */
+#define DWC3_GSBUSCFG0_INCR8BRSTENA	(1 << 2) /* INCR8 burst */
+#define DWC3_GSBUSCFG0_INCR4BRSTENA	(1 << 1) /* INCR4 burst */
+#define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
+#define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
+
 /* Global Debug Queue/FIFO Space Available Register */
 #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
 #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
@@ -227,6 +238,9 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
+/* Global User Control Register */
+#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
+
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
@@ -1157,6 +1171,9 @@ struct dwc3 {
 	u16			imod_interval;
 };
 
+#define INCRX_BURST_MODE 0
+#define INCRX_UNDEF_LENGTH_BURST_MODE 1
+
 #define work_to_dwc(w)		(container_of((w), struct dwc3, drd_work))
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 69bf137aab37..2b53194081ba 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -473,7 +473,6 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
 
 /**
  * dwc3_gadget_start_config - configure ep resources
- * @dwc: pointer to our controller context structure
  * @dep: endpoint that is being enabled
  *
  * Issue a %DWC3_DEPCMD_DEPSTARTCFG command to @dep. After the command's
@@ -1121,7 +1120,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 				req->request.short_not_ok,
 				req->request.no_interrupt);
 	} else if (req->request.zero && req->request.length &&
-		   (IS_ALIGNED(req->request.length,dep->endpoint.maxpacket))) {
+		   (IS_ALIGNED(req->request.length, maxp))) {
 		struct dwc3	*dwc = dep->dwc;
 		struct dwc3_trb	*trb;
 
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index db610c56f1d6..2aacd1afd9ff 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -25,7 +25,7 @@ struct dwc3;
 #define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	BIT(9)
 #define DWC3_DEPCFG_XFER_NOT_READY_EN	BIT(10)
 #define DWC3_DEPCFG_FIFO_ERROR_EN	BIT(11)
-#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(12)
+#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(13)
 #define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
 #define DWC3_DEPCFG_STREAM_CAPABLE	BIT(24)
 #define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)
-- 
2.53.0

