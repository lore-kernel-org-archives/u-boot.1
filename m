Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D376C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2556060667;
	Mon, 24 Aug 2026 16:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wiJFQkly7RUQ; Mon, 24 Aug 2026 16:44:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589851;
	bh=CG0CuhgDfQoUAMWYdOQWn1zUXf5qv5/8tEpLrIGQB48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sOlxWouyL4B2JHPRVM4IddwzEgPpfkPJuotcygSDib033A8obXBs4zy5XXrvzo1yB
	 VywQOtbG/oshGebBYkLgUnL6rr2ZZ3YFOF2ynYrJ5peZYUEVBp+U4Ng/bN8JCyM8Rq
	 SDBdfAiAOjnlbmZlmmleCJx9mW5XfQnsxGBQqDfaGnd6kQqA6lsFThO3Yte5ELVKNF
	 DHuIhPfqx2EXZH0YReuGkNOeypeU5VMDnG4w1WnSDbSIq7ZeE5g9K1U8W4ssU8Kwzb
	 O6JI+4Hac9mVAqGXdGOnD6OOmP7+o3plJZAi+aQ8IxRf2+oNkBAmc1mXz9nel8z8MS
	 DfDzOD7358cvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2FD86068F;
	Mon, 24 Aug 2026 16:44:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5712642B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39BE040068
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ECnndsXVPX4a for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:28:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gl+ry++R
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EAA840029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:10 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c16111a9b8dso34839666b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585289; x=1788190089;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CG0CuhgDfQoUAMWYdOQWn1zUXf5qv5/8tEpLrIGQB48=;
 b=gl+ry++RPylwId4GAv103bhT94mrg1QKPVEStzV1sLi86KDdLsGkMVeCbkaowNfcxh
 RjKUjw96crLB3lAEZ228Z3p77KvpVXh0Xh9AhEWTSkmMx2uu/kPL1p81QxDu+k3to0vk
 rQ7zjywhtKEKJVhwXnJx5OtSUHAx0kHFHv8MikLL/HHQPy/wy5MsUpGOUNtdWl7Doyhc
 fk94qmApIhL+ezHMuLyM/OVIEaW5vKCEb9XtypF1jdlsOuWvJT505cEhEhLZ+Sn+9uN0
 MdISH1Ar613/eG0U098wKFsztokJ1N6nnLABHnDITOOWs+kfL4St+5E6fLpOXpmqajtS
 qYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585289; x=1788190089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CG0CuhgDfQoUAMWYdOQWn1zUXf5qv5/8tEpLrIGQB48=;
 b=qB+nTMlbmIm8gfK4JTsQz3ESgRqmF/rZRNJwOqcjdAg0FWA5W47/b4HQsEEAHNNjq3
 PwpRQxyC9ObF/dryGsR8dzqgYsEWjvkaSxuxtDrivoe+h5E3uhaQ3TvAkQngD56na1Wu
 9uBYleNz8ESHkPjCJThaclxHlcExiM3cDfSwAYanhdsbAoOhkXQcB90QDW3XypK6u44V
 5RBdv4ZUVu9f/4hXQ7m0wvI+sW2qzCUqcJWi9AXiMm12KHpXcYFajivwLETxI4QDkHIG
 wU/vnRFF5ld7WaWTX1ieZHdO1xq7gX1WsrRUK7M3AoFen68s2DFfoR89jcPVmMIfrsed
 AncA==
X-Gm-Message-State: AFuF++meoDEn1M5tg9yw/BksPUkGktjztJWFY+34abn4KP5egEWpQXWZ
 zWGj8bpxkSx9JyYeU6Tg/4tgHafI9qAXEqY1/4BsFuc8LqFFhNUiObYDx8pBUqgugattBP95xoC
 YNAZm
X-Gm-Gg: AR+sD13m5Cn0PjyVzcIEkxbtzqMnjk+Geyq8qA3SV6vmLF/QrMOqHLFHF2C8juWAyzf
 NTiLsWXPb/c+FL3m5Uw0mfYVQQDEs64RZr3BahvnJJdCv1armHUYdPH6j9dmdgoWy16u2/QlpcX
 6s737hlK1KNK3nlgBR8YzZgN7180AqteXz0GlSZF5RqzjyHSjL/1VipFrgWzrhdnnWfdm0dyaFX
 17Df5wC02xPRwOHols0XQFI/yemaM4rzDqb3NnxBTUaHO+D2U1aKjbftltgc4Se3DTfDF862/jh
 zRHjIzLr8ejtughCRASjNO+aAus4mpgYo3jnMfVuNZbShSHgOwszAXYHxWinHCzFrVwbKpSo+yn
 BlXJyvxY4iiRm4QfJ0opdLSxX19N0cDiUUyXMORWIw3kIDf565Ew/yGTvZ+NDc05XtX/sxOw1hA
 yzSQAVhENsVeqBPKsz7yCeAJ9o8/jOz2MjcnQkUzYGfCe7AfhR1SbjsW3qgxb6JuT8pwlf6li4v
 SJd9InnoPhmB83PzNxJslo=
X-Received: by 2002:a17:907:f497:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c246a61c431mr1521105866b.3.1787585288904; 
 Mon, 24 Aug 2026 08:28:08 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa1dsm1247744766b.56.2026.08.24.08.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:28:08 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 08/63] usb: dwc3: import from kernel v4.4
Date: Mon, 24 Aug 2026 17:26:39 +0200
Message-ID: <20260824152734.159794-9-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.3 to v4.4.

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

List of commits: git log --oneline v4.3..v4.4
Commits imported:
62e345ae5b6e usb: dwc3: gadget: don't prestart interrupt endpoints
b9e51b2b1fda usb: dwc3: gadget: let us set lower max_speed
d115d7050a0d Revert "usb: dwc3: gadget: drop unnecessary loop when cleaning up TRBs"
e5f68b4a3e7b Revert "usb: dwc3: gadget: remove unnecessary _irqsave()"
ec791d149bca usb: dwc3: Add dis_enblslpm_quirk
690fb3718a70 usb: dwc3: Support Synopsys USB 3.1 IP
70f3a9caa116 usb: dwc3: gadget: remove unnecessary _irqsave()
e6e709b7ab89 usb: dwc3: gadget: use Update Transfer from Xfer In Progress
6bb4fe12ea08 usb: dwc3: gadget: use update transfer command
8a1a9c9e4503 usb: dwc3: gadget: start transfer on XFER_COMPLETE
3d128919b7e5 usb: dwc3: core: convert to unified device property interface
06e7114f0d82 usb: common: of_usb_get_dr_mode to usb_get_dr_mode
63863b988eec usb: common: of_usb_get_maximum_speed to usb_get_maximum_speed
6344475f5397 usb: dwc3: support for pinctrl state change during system sleep
db2be4e9e30c usb: dwc3: Add frame length adjustment quirk
a8f32817eeb0 usb: dwc3: gadget: improve ep_queue's error reporting
89185916d229 usb: dwc3: gadget: clear DWC3_PENDING_REQUEST when request is queued
1d6a39186b37 usb: dwc3: gadget: start requests as soon as they come
fe84f522ed6d usb: dwc3: gadget: move trace_dwc3_ep_queue()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c          | 104 ++++++++++++++++++-------
 drivers/usb/dwc3/core.h          |  27 +++++++
 drivers/usb/dwc3/gadget.c        | 125 +++++++++++++++++++++----------
 drivers/usb/dwc3/platform_data.h |   3 +
 4 files changed, 194 insertions(+), 65 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 064123e44566..22b4797383cd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -34,6 +34,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
 #include <linux/acpi.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -143,6 +144,32 @@ static int dwc3_soft_reset(struct dwc3 *dwc)
 	return 0;
 }
 
+/*
+ * dwc3_frame_length_adjustment - Adjusts frame length if required
+ * @dwc3: Pointer to our controller context structure
+ * @fladj: Value of GFLADJ_30MHZ to adjust frame length
+ */
+static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
+{
+	u32 reg;
+	u32 dft;
+
+	if (dwc->revision < DWC3_REVISION_250A)
+		return;
+
+	if (fladj == 0)
+		return;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
+	dft = reg & DWC3_GFLADJ_30MHZ_MASK;
+	if (!dev_WARN_ONCE(dwc->dev, dft == fladj,
+	    "request value same as default, ignoring\n")) {
+		reg &= ~DWC3_GFLADJ_30MHZ_MASK;
+		reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL | fladj;
+		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
+	}
+}
+
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
@@ -488,6 +515,9 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_u2_susphy_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
+	if (dwc->dis_enblslpm_quirk)
+		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
 	return 0;
@@ -507,12 +537,18 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
 	/* This should read as U3 followed by revision number */
-	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000) {
+	if ((reg & DWC3_GSNPSID_MASK) == 0x55330000) {
+		/* Detected DWC_usb3 IP */
+		dwc->revision = reg;
+	} else if ((reg & DWC3_GSNPSID_MASK) == 0x33310000) {
+		/* Detected DWC_usb31 IP */
+		dwc->revision = dwc3_readl(dwc->regs, DWC3_VER_NUMBER);
+		dwc->revision |= DWC3_REVISION_IS_DWC31;
+	} else {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
 		goto err0;
 	}
-	dwc->revision = reg;
 
 	/*
 	 * Write Linux Version Code to our GUID register so it's easy to figure
@@ -773,12 +809,12 @@ static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
 	struct dwc3_platform_data *pdata = dev_get_platdata(dev);
-	struct device_node	*node = dev->of_node;
 	struct resource		*res;
 	struct dwc3		*dwc;
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
+	u32			fladj = 0;
 
 	int			ret;
 
@@ -842,51 +878,56 @@ static int dwc3_probe(struct platform_device *pdev)
 	 */
 	hird_threshold = 12;
 
-	if (node) {
-		dwc->maximum_speed = of_usb_get_maximum_speed(node);
-		dwc->has_lpm_erratum = of_property_read_bool(node,
+	dwc->maximum_speed = usb_get_maximum_speed(dev);
+	dwc->dr_mode = usb_get_dr_mode(dev);
+
+	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
-		of_property_read_u8(node, "snps,lpm-nyet-threshold",
+	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
 				&lpm_nyet_threshold);
-		dwc->is_utmi_l1_suspend = of_property_read_bool(node,
+	dwc->is_utmi_l1_suspend = device_property_read_bool(dev,
 				"snps,is-utmi-l1-suspend");
-		of_property_read_u8(node, "snps,hird-threshold",
+	device_property_read_u8(dev, "snps,hird-threshold",
 				&hird_threshold);
-		dwc->usb3_lpm_capable = of_property_read_bool(node,
+	dwc->usb3_lpm_capable = device_property_read_bool(dev,
 				"snps,usb3_lpm_capable");
 
-		dwc->needs_fifo_resize = of_property_read_bool(node,
+	dwc->needs_fifo_resize = device_property_read_bool(dev,
 				"tx-fifo-resize");
-		dwc->dr_mode = of_usb_get_dr_mode(node);
 
-		dwc->disable_scramble_quirk = of_property_read_bool(node,
+	dwc->disable_scramble_quirk = device_property_read_bool(dev,
 				"snps,disable_scramble_quirk");
-		dwc->u2exit_lfps_quirk = of_property_read_bool(node,
+	dwc->u2exit_lfps_quirk = device_property_read_bool(dev,
 				"snps,u2exit_lfps_quirk");
-		dwc->u2ss_inp3_quirk = of_property_read_bool(node,
+	dwc->u2ss_inp3_quirk = device_property_read_bool(dev,
 				"snps,u2ss_inp3_quirk");
-		dwc->req_p1p2p3_quirk = of_property_read_bool(node,
+	dwc->req_p1p2p3_quirk = device_property_read_bool(dev,
 				"snps,req_p1p2p3_quirk");
-		dwc->del_p1p2p3_quirk = of_property_read_bool(node,
+	dwc->del_p1p2p3_quirk = device_property_read_bool(dev,
 				"snps,del_p1p2p3_quirk");
-		dwc->del_phy_power_chg_quirk = of_property_read_bool(node,
+	dwc->del_phy_power_chg_quirk = device_property_read_bool(dev,
 				"snps,del_phy_power_chg_quirk");
-		dwc->lfps_filter_quirk = of_property_read_bool(node,
+	dwc->lfps_filter_quirk = device_property_read_bool(dev,
 				"snps,lfps_filter_quirk");
-		dwc->rx_detect_poll_quirk = of_property_read_bool(node,
+	dwc->rx_detect_poll_quirk = device_property_read_bool(dev,
 				"snps,rx_detect_poll_quirk");
-		dwc->dis_u3_susphy_quirk = of_property_read_bool(node,
+	dwc->dis_u3_susphy_quirk = device_property_read_bool(dev,
 				"snps,dis_u3_susphy_quirk");
-		dwc->dis_u2_susphy_quirk = of_property_read_bool(node,
+	dwc->dis_u2_susphy_quirk = device_property_read_bool(dev,
 				"snps,dis_u2_susphy_quirk");
+	dwc->dis_enblslpm_quirk = device_property_read_bool(dev,
+				"snps,dis_enblslpm_quirk");
 
-		dwc->tx_de_emphasis_quirk = of_property_read_bool(node,
+	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
-		of_property_read_u8(node, "snps,tx_de_emphasis",
+	device_property_read_u8(dev, "snps,tx_de_emphasis",
 				&tx_de_emphasis);
-		of_property_read_string(node, "snps,hsphy_interface",
-					&dwc->hsphy_interface);
-	} else if (pdata) {
+	device_property_read_string(dev, "snps,hsphy_interface",
+				    &dwc->hsphy_interface);
+	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
+				 &fladj);
+
+	if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
 		if (pdata->lpm_nyet_threshold)
@@ -909,12 +950,14 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->rx_detect_poll_quirk = pdata->rx_detect_poll_quirk;
 		dwc->dis_u3_susphy_quirk = pdata->dis_u3_susphy_quirk;
 		dwc->dis_u2_susphy_quirk = pdata->dis_u2_susphy_quirk;
+		dwc->dis_enblslpm_quirk = pdata->dis_enblslpm_quirk;
 
 		dwc->tx_de_emphasis_quirk = pdata->tx_de_emphasis_quirk;
 		if (pdata->tx_de_emphasis)
 			tx_de_emphasis = pdata->tx_de_emphasis;
 
 		dwc->hsphy_interface = pdata->hsphy_interface;
+		fladj = pdata->fladj_value;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
@@ -971,6 +1014,9 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	/* Adjust Frame Length */
+	dwc3_frame_length_adjustment(dwc, fladj);
+
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
@@ -1091,6 +1137,8 @@ static int dwc3_suspend(struct device *dev)
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -1100,6 +1148,8 @@ static int dwc3_resume(struct device *dev)
 	unsigned long	flags;
 	int		ret;
 
+	pinctrl_pm_select_default_state(dev);
+
 	usb_phy_init(dwc->usb3_phy);
 	usb_phy_init(dwc->usb2_phy);
 	ret = phy_init(dwc->usb2_generic_phy);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 044778884585..36f1cb74588c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -108,6 +108,9 @@
 #define DWC3_GPRTBIMAP_FS0	0xc188
 #define DWC3_GPRTBIMAP_FS1	0xc18c
 
+#define DWC3_VER_NUMBER		0xc1a0
+#define DWC3_VER_TYPE		0xc1a4
+
 #define DWC3_GUSB2PHYCFG(n)	(0xc200 + (n * 0x04))
 #define DWC3_GUSB2I2CCTL(n)	(0xc240 + (n * 0x04))
 
@@ -124,6 +127,7 @@
 #define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
 
 #define DWC3_GHWPARAMS8		0xc600
+#define DWC3_GFLADJ		0xc630
 
 /* Device Registers */
 #define DWC3_DCFG		0xc700
@@ -175,6 +179,7 @@
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
 #define DWC3_GUSB2PHYCFG_ULPI_UTMI	(1 << 4)
+#define DWC3_GUSB2PHYCFG_ENBLSLPM	(1 << 8)
 
 /* Global USB2 PHY Vendor Control Register */
 #define DWC3_GUSB2PHYACC_NEWREGREQ	(1 << 25)
@@ -234,6 +239,10 @@
 /* Global HWPARAMS6 Register */
 #define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
 
+/* Global Frame Length Adjustment Register */
+#define DWC3_GFLADJ_30MHZ_SDBND_SEL		(1 << 7)
+#define DWC3_GFLADJ_30MHZ_MASK			0x3f
+
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
@@ -712,6 +721,8 @@ struct dwc3_scratchpad_array {
  * @rx_detect_poll_quirk: set if we enable rx_detect to polling lfps quirk
  * @dis_u3_susphy_quirk: set if we disable usb3 suspend phy
  * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
+ * @dis_enblslpm_quirk: set if we clear enblslpm in GUSB2PHYCFG,
+ *                      disabling the suspend signal to the PHY.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  * 	0	- -6dB de-emphasis
@@ -766,6 +777,14 @@ struct dwc3 {
 	u32			num_event_buffers;
 	u32			u1u2;
 	u32			maximum_speed;
+
+	/*
+	 * All 3.1 IP version constants are greater than the 3.0 IP
+	 * version constants. This works for most version checks in
+	 * dwc3. However, in the future, this may not apply as
+	 * features may be developed on newer versions of the 3.0 IP
+	 * that are not in the 3.1 IP.
+	 */
 	u32			revision;
 
 #define DWC3_REVISION_173A	0x5533173a
@@ -788,6 +807,13 @@ struct dwc3 {
 #define DWC3_REVISION_270A	0x5533270a
 #define DWC3_REVISION_280A	0x5533280a
 
+/*
+ * NOTICE: we're using bit 31 as a "is usb 3.1" flag. This is really
+ * just so dwc31 revisions are always larger than dwc3.
+ */
+#define DWC3_REVISION_IS_DWC31		0x80000000
+#define DWC3_USB31_REVISION_110A	(0x3131302a | DWC3_REVISION_IS_USB31)
+
 	enum dwc3_ep0_next	ep0_next_event;
 	enum dwc3_ep0_state	ep0state;
 	enum dwc3_link_state	link_state;
@@ -841,6 +867,7 @@ struct dwc3 {
 	unsigned		rx_detect_poll_quirk:1;
 	unsigned		dis_u3_susphy_quirk:1;
 	unsigned		dis_u2_susphy_quirk:1;
+	unsigned		dis_enblslpm_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1e8bdf817811..a58376fd65fe 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -948,7 +948,6 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
 		dwc3_trace(trace_dwc3_gadget, "%s: endpoint busy", dep->name);
 		return -EBUSY;
 	}
-	dep->flags &= ~DWC3_EP_PENDING_REQUEST;
 
 	/*
 	 * If we are getting here after a short-out-packet we don't enqueue any
@@ -1050,6 +1049,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	req->direction		= dep->direction;
 	req->epnum		= dep->number;
 
+	trace_dwc3_ep_queue(req);
+
 	/*
 	 * We only add to our list of requests now and
 	 * start consuming the list once we get XferNotReady
@@ -1069,6 +1070,20 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 	list_add_tail(&req->list, &dep->request_list);
 
+	/*
+	 * If there are no pending requests and the endpoint isn't already
+	 * busy, we will just start the request straight away.
+	 *
+	 * This will save one IRQ (XFER_NOT_READY) and possibly make it a
+	 * little bit faster.
+	 */
+	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+			!usb_endpoint_xfer_int(dep->endpoint.desc) &&
+			!(dep->flags & DWC3_EP_BUSY)) {
+		ret = __dwc3_gadget_kick_transfer(dep, 0, true);
+		goto out;
+	}
+
 	/*
 	 * There are a few special cases:
 	 *
@@ -1096,10 +1111,10 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		}
 
 		ret = __dwc3_gadget_kick_transfer(dep, 0, true);
-		if (ret && ret != -EBUSY)
-			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
-					dep->name);
-		return ret;
+		if (!ret)
+			dep->flags &= ~DWC3_EP_PENDING_REQUEST;
+
+		goto out;
 	}
 
 	/*
@@ -1113,10 +1128,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		WARN_ON_ONCE(!dep->resource_index);
 		ret = __dwc3_gadget_kick_transfer(dep, dep->resource_index,
 				false);
-		if (ret && ret != -EBUSY)
-			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
-					dep->name);
-		return ret;
+		goto out;
 	}
 
 	/*
@@ -1124,14 +1136,17 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 * right away, otherwise host will not know we have streams to be
 	 * handled.
 	 */
-	if (dep->stream_capable) {
+	if (dep->stream_capable)
 		ret = __dwc3_gadget_kick_transfer(dep, 0, true);
-		if (ret && ret != -EBUSY)
-			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
-					dep->name);
-	}
 
-	return 0;
+out:
+	if (ret && ret != -EBUSY)
+		dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
+				dep->name);
+	if (ret == -EBUSY)
+		ret = 0;
+
+	return ret;
 }
 
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
@@ -1159,8 +1174,6 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 		goto out;
 	}
 
-	trace_dwc3_ep_queue(req);
-
 	ret = __dwc3_gadget_ep_queue(dep, req);
 
 out:
@@ -1872,27 +1885,32 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	unsigned int		i;
 	int			ret;
 
-	req = next_request(&dep->req_queued);
-	if (!req) {
-		WARN_ON_ONCE(1);
-		return 1;
-	}
-	i = 0;
 	do {
-		slot = req->start_slot + i;
-		if ((slot == DWC3_TRB_NUM - 1) &&
+		req = next_request(&dep->req_queued);
+		if (!req) {
+			WARN_ON_ONCE(1);
+			return 1;
+		}
+		i = 0;
+		do {
+			slot = req->start_slot + i;
+			if ((slot == DWC3_TRB_NUM - 1) &&
 				usb_endpoint_xfer_isoc(dep->endpoint.desc))
-			slot++;
-		slot %= DWC3_TRB_NUM;
-		trb = &dep->trb_pool[slot];
+				slot++;
+			slot %= DWC3_TRB_NUM;
+			trb = &dep->trb_pool[slot];
+
+			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
+					event, status);
+			if (ret)
+				break;
+		} while (++i < req->request.num_mapped_sgs);
+
+		dwc3_gadget_giveback(dep, req, status);
 
-		ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
-				event, status);
 		if (ret)
 			break;
-	} while (++i < req->request.num_mapped_sgs);
-
-	dwc3_gadget_giveback(dep, req, status);
+	} while (1);
 
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 			list_empty(&dep->req_queued)) {
@@ -1955,6 +1973,14 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 
 		dwc->u1u2 = 0;
 	}
+
+	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+		int ret;
+
+		ret = __dwc3_gadget_kick_transfer(dep, 0, is_xfer_complete);
+		if (!ret || ret == -EBUSY)
+			return;
+	}
 }
 
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
@@ -1992,15 +2018,16 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
 			dwc3_gadget_start_isoc(dwc, dep, event);
 		} else {
+			int active;
 			int ret;
 
+			active = event->status & DEPEVT_STATUS_TRANSFER_ACTIVE;
+
 			dwc3_trace(trace_dwc3_gadget, "%s: reason %s",
-					dep->name, event->status &
-					DEPEVT_STATUS_TRANSFER_ACTIVE
-					? "Transfer Active"
+					dep->name, active ? "Transfer Active"
 					: "Transfer Not Active");
 
-			ret = __dwc3_gadget_kick_transfer(dep, 0, 1);
+			ret = __dwc3_gadget_kick_transfer(dep, 0, !active);
 			if (!ret || ret == -EBUSY)
 				return;
 
@@ -2718,11 +2745,33 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	}
 
 	dwc->gadget.ops			= &dwc3_gadget_ops;
-	dwc->gadget.max_speed		= USB_SPEED_SUPER;
 	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
 	dwc->gadget.sg_supported	= true;
 	dwc->gadget.name		= "dwc3-gadget";
 
+	/*
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
+	 */
+	if (dwc->revision < DWC3_REVISION_220A)
+		dwc3_trace(trace_dwc3_gadget,
+				"Changing max_speed on rev %08x\n",
+				dwc->revision);
+
+	dwc->gadget.max_speed		= dwc->maximum_speed;
+
 	/*
 	 * Per databook, DWC3 needs buffer size to be aligned to MaxPacketSize
 	 * on ep out.
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index d3614ecbb9ca..2bb4d3ad0e6b 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -42,9 +42,12 @@ struct dwc3_platform_data {
 	unsigned rx_detect_poll_quirk:1;
 	unsigned dis_u3_susphy_quirk:1;
 	unsigned dis_u2_susphy_quirk:1;
+	unsigned dis_enblslpm_quirk:1;
 
 	unsigned tx_de_emphasis_quirk:1;
 	unsigned tx_de_emphasis:2;
 
+	u32 fladj_value;
+
 	const char *hsphy_interface;
 };
-- 
2.53.0

