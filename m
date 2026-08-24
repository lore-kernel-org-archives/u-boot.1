Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CD9C5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAB6680DF4;
	Mon, 24 Aug 2026 16:45:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9eBfXPeX0Dl; Mon, 24 Aug 2026 16:45:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589873;
	bh=94u2O8R33+hTEnslRsTieLzpOaCQn1VloGZwwVbF7Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z+FKhhAliZ8MQruH/P5BXIHkqevFoiYtXyI4BYeIRnPIhyjlmyMbmBCcQPFcmB8Ze
	 B3Ahwd6CxUHpB9fyd9ZNzKxgt31Y5c7HC27qqmhUebJxetvjpGin6rxCj1fcz+L/fC
	 FGbKIPngbvVKPJS49MfEG8HrkfUbXPVbevfoAj/sXRqZErEpE6TaEyXigG/gzCt6Vd
	 oVe2DhPB7ER1iWGv839cNL3yO94TG8t1IqqIV0xdybpt9GS/CtsIrUr/qId6Hy+EyD
	 7/I7SUQfM4la6Fpn0CYFZinzY2GJWe88jqjuL+6IEE/XfZ4sMuDRY3S8+kg5AtB+tx
	 ixkoFhdc5joGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 333E380E23;
	Mon, 24 Aug 2026 16:44:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96B26396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94F38403E0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CoI9Ew_jWwuV for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:29:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=nFCZR3vQ
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62BAE403A9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:29:37 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c082647cd0dso28034266b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585376; x=1788190176;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=94u2O8R33+hTEnslRsTieLzpOaCQn1VloGZwwVbF7Lg=;
 b=nFCZR3vQWJSXZjnNYQJ6IuZ3wCKqULdU5B06g74NjMh999YCKlqMgg2UlGlpdbXIas
 NoKKIgEqZFOwOh1idE9VXwbRdPGgSF4f66xsqx0gOOoMxPyNraJ/Jj97LWqN7FRd4wvQ
 w1RgFLH6jz/23BGnp/C7GiyQaq7ZoejhN+41/G2k+c3tlgPOJzST+cPxCcM+19zoOm7I
 YrB0KCGDcFXHfpTIQ4CmJKGfVsgcGGtcKl7utTfdABGr70nr8mP8JCIHhNZ7z9qSVb8q
 Jo97csU1cxk8ZLQySSDdYWWMHRLtmusC3eaMGVN9LfKwZw9Cm+zU8gXy+wq6eEr6ZV7q
 g2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585376; x=1788190176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=94u2O8R33+hTEnslRsTieLzpOaCQn1VloGZwwVbF7Lg=;
 b=jMw+qIZU7EVnkfyrQqiVLlK+DgsrjQrWcasriYhGZdsT8ZWAviTcjXaTbU61SSAJ2f
 RizY1y+0UuzaAPTW6kbJqmKki/tn+5v49tZQK51U+NArlA5zE9ixVT60w7Z1kXnf4YzK
 IX7dNaD/BvKtXJQFLnLI2AhQqEQahCJbpDD5x8XROYqE2pGSh7/P+KaA04Zfc72v3edr
 jZaH9Uz69xcJd9bVIugJJ51zPBaeEDMj8azxcop3y6EHelvwVJ7fHFVY54ag2dkw6n+B
 FJt+s8VBTcZoIyevmU1Yxkksu38yjx9h6pyJG1Sv6ajvtZlPT+jFMHgPBl7gnv9dCMk1
 xriA==
X-Gm-Message-State: AFuF++n91g5Qj8JP59026d5TD4lA6koQh49c6pQ1Qpe9JSWHFXJAzEKs
 oaqYcPcIyiZUAKObng4L/hmqYoQnYDaYoOoZQ+Q3IEYXFS3oXkQCAydcElSJ3gSGBISCLDOLNHh
 jt3NH
X-Gm-Gg: AR+sD11gjbN8n4C7kk8yEsRzbMkawmpYiM2sDXXeISXXV+/e1qbZz7iazmJzIudcmlw
 tsBhMC/Lf1paTY2rLPlDUbOec4hpuad+gO6OC5F2G+0nMjDfuIX5DQVj4/QH5nPDNsJLIMFau+/
 UcbXOlshv7vG4iSxjViW973UvaaQBINfbldnxpQ1TYU7IgyH91eh1Lh4Zn+0XxXIfU18aiThy0v
 HgpDwiFGRknCRozIalyP8ZeSnRB+vceNRbgiPVf96JAdc4BtGJwptPMhuJg56f2HmQBu9Up/JHr
 Zuc+tfa0MO1SNssCgcX1QJTYmll6KxVv7/Acd+2FnlBI5G/spsstMu9MsyqfIXh+OBpX+BxYFZA
 7gbEYaRpEbP7ZpILF3MyfZv/Xwl7cF02GF+QYJLszUkK0TA7QQqA3mCUsToHglj4vDP1ekIcBQf
 UM0zeeGDAB1NH6fK5noYmsImELwzb9gbr+g2JoxerHmEc7LGkBGHjQ7xQXwtrUQ8AD9WT7aa2ks
 OUluKVPCMdMKEvkEbhG9yo=
X-Received: by 2002:a17:906:f59a:b0:c15:c651:f28f with SMTP id
 a640c23a62f3a-c246a62f67amr1494578066b.3.1787585375910; 
 Mon, 24 Aug 2026 08:29:35 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24962bbea6sm1228499066b.27.2026.08.24.08.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:29:35 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 23/63] usb: dwc3: import from kernel v4.19
Date: Mon, 24 Aug 2026 17:26:54 +0200
Message-ID: <20260824152734.159794-24-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.18 to v4.19.

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

List of commits: git log --oneline v4.18..v4.19
Commits imported:
4e3121abcf53 usb/dwc3/gadget: fix kernel-doc parameter warning
4ea438da76f4 usb: dwc3: gadget: Check MaxPacketSize from descriptor
b138e23d3dff usb: dwc3: core: Enable AutoRetry feature in the controller
a77004681148 usb: dwc3: Set default mode for dwc_usb31
d9612c2f0449 usb: dwc3: Enable undefined length INCR burst type
d635db5508b0 usb: dwc3: add global soc bus configuration reg0
9a7faac36502 usb: dwc3: change stream event enable bit back to 13
db9fc500e85a usb: dwc3: gadget: remove redundant variable maxpacket

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

