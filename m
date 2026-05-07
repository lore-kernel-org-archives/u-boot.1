Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9145ECD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B64D84AC5;
	Thu,  7 May 2026 11:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hDryBVWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56CE084AA5; Thu,  7 May 2026 11:30:03 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D045A84A8F
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5a4113ab355so585757e87.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146192; x=1778750992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zi8uCopLOQIOsW37+iM8MzirHUHQJT+vahC2iPfeod0=;
 b=hDryBVWNmUHptU7V80wYbsmU2tulBrfvOx+FAMjaHKdTZNtsGdflW749s6JiFsoz3l
 lDLchuhfYwcbxsVot3KzJcx7NRgyzs5/w2pwDYdRJI+MzJddEwpYOLrHGairtIw4lBOT
 Z8T/ZY/qJsFQLb/DK2uYboSc0lhZjYcdzbsFvxNtfbcS4yAQUY+40dZ96bucOx18l5sF
 I/2glVdI5GYLVTtfLSmvfjyP3oM/NS44BZZ4n48KGRBcoCsLbqw/5X6obXspwQpDxMs9
 AXwbXwguAYgJQCBTLhKXq80YBBi7qa17D8NVh3Tk0uCzBbsY4YOCEDOe+Lp8lmh/jXFo
 BTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146192; x=1778750992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zi8uCopLOQIOsW37+iM8MzirHUHQJT+vahC2iPfeod0=;
 b=jUYNlN4FoiVoWJgVjTjS4PIcZZBCzGIZqKGPvBD/Zs4x692oDzA9D/HDqtJNrn4kXv
 JIQ2dzQta0W/oJhGTwCfN/3unIpVIThnsC0bBeFY9H38gP755mOMlMFhn7WH+/UZFBBB
 K9wRknSZyI2IKs3hGNnEDXjvnMZZfmMvOoiZ52jgHtzOZJB4lCORgrhZvApoQ+Cnp126
 sS62+CY7Mf61olXAXt8/ZMVHpdr/WmvTh/kQqNhB30F0uZgdv2qeBgnuz0vs6Ulk3TQc
 jD78xqnpohEAyBP7a1l0xI/+GbX6ybq4Der4YB9wx7rHekoOJJ1bMqnvypnxWSmbZU76
 0TAw==
X-Gm-Message-State: AOJu0Yy5nggV8yvjBYAoMzesTXAdZTH18vMpcFieP41d7smeyvQIQA7n
 vucFWIC6TNtgh1M8cNoBGquQte+JjPsGGXnqbC0IAbvv03u16qvVPbVHbSOmQq4uCEt6isCTIRb
 9YyrIEeve+w==
X-Gm-Gg: AeBDiesZbt2pegouiTMtVdW7PUAN432/PN5PefRzk9QTM6mkz1nQisBAoI+M1G0omYp
 BX+NWvB6NR004pqbIJqZfp2sgSDg7ibvz8tP9HLET10P71ATUSMMH53z4k9xAgUpbpzsQx13YPA
 RfzKT07glhAyIVLxS0sjtlFwgQebdltWUpx22IhaPQ6JQhZBTT55kbCgC1+zcAj+Xo2AwWCWRyX
 KgJuy7hyzFqUTCB7tpyE6OTLIWGFJ7jBq36Iz+klQcJ3NfEpul347RwkFwxKxBTtkfRk3q5oSBk
 321BlnZNxet3IaNZuYvHeSaLeun5Iut9Hyvj4St3mkHx/Z9jhVntB0i+1GngYQt5iF+XG4IOEel
 w2JrKPVYXhn8Wj9JrImbgiMFpm9dOYBXgAIe8aU4Fa3YoUkF6MZQZ0qrnWpizIdFI+jNMyaD0k3
 NfHPG9y3aD7V7aWN/Xk4HvVDiedpPP36NvY64M4r8OHyEj2kxfNTyAgFplT8enP6D5nXKX4qoWe
 P72jqbxmBAVyqVx/V21zARYrccjimK7wxaM7eLSJBWgMpZ3VArS
X-Received: by 2002:a05:6512:318f:b0:5a4:52d:4abc with SMTP id
 2adb3069b0e04-5a887ad8e26mr2188923e87.8.1778146191731; 
 Thu, 07 May 2026 02:29:51 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:50 -0700 (PDT)
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
Subject: [RFC PATCH v2 22/64] usb: dwc3: import from kernel v4.19
Date: Thu,  7 May 2026 11:27:29 +0200
Message-ID: <20260507092843.358908-23-jens.wiklander@linaro.org>
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
bfa150f37f80 Merge tag 'fixes-for-v4.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-linus
4e3121abcf53 usb/dwc3/gadget: fix kernel-doc parameter warning
b497fff6f59e usb: dwc3: pci: Fix return value check in dwc3_byt_enable_ulpi_refclock()
66174b6998a6 usb: dwc3: of-simple: avoid unused function warnings
45dd7af410b7 Merge tag 'usb-for-v4.19' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
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
714c95ce8bad Merge 4.18-rc3 into usb-next

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
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
2.43.0

