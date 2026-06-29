Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53FBC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E57BD84A6B;
	Mon, 29 Jun 2026 10:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XOdzOmbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B091F84105; Mon, 29 Jun 2026 10:46:32 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB8784A52
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-39669bcaadfso32293021fa.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722790; x=1783327590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYlRL+hS4u0N2jkYkJ+fPhIDXFa6hVgBgOTk29g8sZo=;
 b=XOdzOmbRh+YGkcACm3sAj9Ap3guCmYhsVrYcE10RuOk4S3ofMKiX5Hj1c46a6KjzjI
 LsBaLjj5e+2OdCPQT9yJsbFgfXAAPgnJcHS/ZCAPiuy7sJ/DYvkCbBSlY7iiaVdVWmk8
 2qCnQiWynHKLSuXn4eehrUHpDYIJGr6pvjNQnyQsABPnQ3TKY4oIS4J/mRCzZtD3jxGG
 2iFC3oP9UqgRLDTm6Ij6MDU+uH9g3eY1EtMe5ktmE6nsvI3jK50i1B1m4osaBN15Ycy2
 NF20zvcxjytPfkgcgYmx+Jk2xxMhUSDC+Zx0tKgzbspcaT605K5havo5Se9W3sRjOkM6
 fvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722790; x=1783327590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lYlRL+hS4u0N2jkYkJ+fPhIDXFa6hVgBgOTk29g8sZo=;
 b=Iv2RY8dog+VJbpgNRQGlXqfneddHrM6oJGSQuvKehLOfqa6MdSVP85gay41WR296Pc
 qKuFvL+SimwHkzMwKXjHfME1q7tDxaNlAi3c6KG9QZjVz+sPAhM2v0HJKor/gl3KP5l2
 058tPOFl1L7z+I2bpPIFFcShn81oFXGJvj0xEob3LnyU5SXslzvlNIEGmE5NiEe12cm3
 SS97V9JBNh65oWCr+zp+MX0e+/ygXpC2nnNXyviNC4dfF+pilVTGB3ggSs9NgyMiU31c
 TSm+oNeozxWLwEK80wsLB4QnjKS1QLwkT1S3tcOSUd2HfRh7iPv+OkWRdX7ESy17UKxN
 /X5g==
X-Gm-Message-State: AOJu0Yxjhal9xY6H+Vps19e3g9EPHBDCMdSUbWi2UpmMtB9uTCLY+y8Q
 t/RF0K4owSKN+UjAQkgz4ZJyVYUHjQyrDGxJhECLDntB7tOklmAqjJopvyCDM/Bp3q3WG2PcRF2
 DQmv643U=
X-Gm-Gg: AfdE7cmIBI4R1CjvsK0cwzIJPOabE0b6jITCRuHg75GVu88eglkiIKjzHQ2HCPOQuJB
 O8+mjtzuhjpqWzGEJ8tS6C0YnD+Sz58MMt1RmLpl03Jk8TZSB1QupGPciIN9Yya9/0v3/X+g0Tu
 6OGM611BV1bgVtq3AeK61VloESkW54AHbWBGGIfAMRkkaKrqHu9TITjs/UMo8WROxwl8QWS3ZJb
 GqcleuIIwB6jLwvHL36xljCV03PVBFW9spmR/yPGFrPjTiuZdzVEwWc8laZXHuH9vLsCU2xY3XD
 q+zH3CGd0TAPyFcUH5Bjsf6QUzHssCtsWreR8aBv1D+ZYCGKoh7rdA/5AuG9mD8nFofGZp5txyW
 B/teJs5uO55ezSsl9U3c1CSG8wNr8jNJZOWxghnvQ715KUNh9RFOSDmRUj1k/ZZLGK0CSjCaDl3
 prA8bnolg0K5EmXyV7AkFZsKatKxHgyZaqReWS3jVKsXMxFSF46zBvQl3VqulmzILw16pHCnpEA
 lUpzNPTqYClkifubI+yrSXYUAz5fgA=
X-Received: by 2002:a05:651c:19a4:b0:39b:205:20e with SMTP id
 38308e7fff4ca-39b0205056bmr9200011fa.38.1782722789611; 
 Mon, 29 Jun 2026 01:46:29 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:46:27 -0700 (PDT)
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
Subject: [PATCH v4 23/64] usb: dwc3: import from kernel v4.20
Date: Mon, 29 Jun 2026 10:43:59 +0200
Message-ID: <20260629084507.3254232-24-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.19 to v4.20.

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

List of commits: git log --oneline v4.19..v4.20
Commits imported:
38317f5c0f2f Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"
2fc6d4be35fb usb: dwc3: gadget: fix ISOC TRB type on unaligned transfers
7b412b04a0c7 usb: dwc3: Fix NULL pointer exception in dwc3_pci_remove()
ba3a51ac32eb usb: dwc3: gadget: Properly check last unaligned/zero chain TRB
08fd9a82fda8 usb: dwc3: core: Clean up ULPI device
6af19fd10595 usb: dwc3: Fix spelling of 'optimizations'
87dd96111b0b usb: dwc3: gadget: Check ENBLSLPM before sending ep command
3def4031b3e3 usb: dwc3: add EXTCON dependency for qcom
4c19cc14064d usb: dwc3: exynos: Add support for Exynos5433 variant with all clocks
9f2168367a0a usb: dwc3: exynos: Rework clock handling and prepare for new variants
1e041b6f313a usb: dwc3: exynos: Remove dead code
755801cb9feb Merge tag 'uvcg-20180925' of git://linuxtv.org/pinchartl/media into testing/next

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.c   |  3 ++-
 drivers/usb/dwc3/gadget.c | 42 +++++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 88c80fcc39f5..2f2048aa5fde 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -756,7 +756,7 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 
 	/* check if current dwc3 is on simulation board */
 	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
-		dev_info(dwc->dev, "Running with FPGA optmizations\n");
+		dev_info(dwc->dev, "Running with FPGA optimizations\n");
 		dwc->is_fpga = true;
 	}
 
@@ -1499,6 +1499,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 err5:
 	dwc3_event_buffers_cleanup(dwc);
+	dwc3_ulpi_exit(dwc);
 
 err4:
 	dwc3_free_scratch_buffers(dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2b53194081ba..9f92ee03dde7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -270,27 +270,36 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
 	u32			timeout = 1000;
+	u32			saved_config = 0;
 	u32			reg;
 
 	int			cmd_status = 0;
-	int			susphy = false;
 	int			ret = -EINVAL;
 
 	/*
-	 * Synopsys Databook 2.60a states, on section 6.3.2.5.[1-8], that if
-	 * we're issuing an endpoint command, we must check if
-	 * GUSB2PHYCFG.SUSPHY bit is set. If it is, then we need to clear it.
+	 * When operating in USB 2.0 speeds (HS/FS), if GUSB2PHYCFG.ENBLSLPM or
+	 * GUSB2PHYCFG.SUSPHY is set, it must be cleared before issuing an
+	 * endpoint command.
 	 *
-	 * We will also set SUSPHY bit to what it was before returning as stated
-	 * by the same section on Synopsys databook.
+	 * Save and clear both GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY
+	 * settings. Restore them after the command is completed.
+	 *
+	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
 	 */
 	if (dwc->gadget.speed <= USB_SPEED_HIGH) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
-			susphy = true;
+			saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
 			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 		}
+
+		if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
+			saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
+			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+		}
+
+		if (saved_config)
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
@@ -389,9 +398,9 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 		}
 	}
 
-	if (unlikely(susphy)) {
+	if (saved_config) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+		reg |= saved_config;
 		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
@@ -1072,7 +1081,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 			/* Now prepare one extra TRB to align transfer size */
 			trb = &dep->trb_pool[dep->trb_enqueue];
 			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr,
-					maxp - rem, false, 0,
+					maxp - rem, false, 1,
 					req->request.stream_id,
 					req->request.short_not_ok,
 					req->request.no_interrupt);
@@ -1116,7 +1125,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		/* Now prepare one extra TRB to align transfer size */
 		trb = &dep->trb_pool[dep->trb_enqueue];
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp - rem,
-				false, 0, req->request.stream_id,
+				false, 1, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt);
 	} else if (req->request.zero && req->request.length &&
@@ -1132,7 +1141,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		/* Now prepare one extra TRB to handle ZLP */
 		trb = &dep->trb_pool[dep->trb_enqueue];
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
-				false, 0, req->request.stream_id,
+				false, 1, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt);
 	} else {
@@ -1461,9 +1470,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		unsigned transfer_in_flight;
 		unsigned started;
 
-		if (dep->flags & DWC3_EP_STALL)
-			return 0;
-
 		if (dep->number > 1)
 			trb = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
 		else
@@ -1485,8 +1491,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		else
 			dep->flags |= DWC3_EP_STALL;
 	} else {
-		if (!(dep->flags & DWC3_EP_STALL))
-			return 0;
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
 		if (ret)
@@ -2250,7 +2254,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	 * with one TRB pending in the ring. We need to manually clear HWO bit
 	 * from that TRB.
 	 */
-	if ((req->zero || req->unaligned) && (trb->ctrl & DWC3_TRB_CTRL_HWO)) {
+	if ((req->zero || req->unaligned) && !(trb->ctrl & DWC3_TRB_CTRL_CHN)) {
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		return 1;
 	}
-- 
2.43.0

