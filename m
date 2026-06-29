Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D129C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9FD84A93;
	Mon, 29 Jun 2026 10:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lh0BNmxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4557784105; Mon, 29 Jun 2026 10:46:57 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68A9F84A91
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-39ae3c76e24so15030091fa.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722814; x=1783327614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+sXabI3jBUwXQQswQVqdy+y/Xd6qcoKWkx1cCq9zZk=;
 b=Lh0BNmxdkR6iKCkZ61j55b8NdxAUkJ5DGJUYQMqzoXkXubvtJJ2vHcWYnpdRC7PTl1
 6fEtTZeeSF38qKstgnZy3ll51BJivcud08/96TIvn5ya9BRgux3hfWlm07ldFcyjjrOo
 cYd+wVU8kG72WhlQl1RM6Dvmj3Njs57iQFh37ZLHrCYuptlHmQR4klJQZ1Un+/7dmty4
 fVOmT+V/Xw4RcaK5xIG9UfkWSS6AvZTm775INecmhoAKhh4zmMrlx6oTm+xuPwgv3BKu
 nfk6MEdctw0gmxRyd+qB12BL2h/vz0oCdxcekYX0D9A4sUg2coE5z3nVazA2B90SH454
 1uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722814; x=1783327614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w+sXabI3jBUwXQQswQVqdy+y/Xd6qcoKWkx1cCq9zZk=;
 b=Z31HQ9XhAzFVH83uwSeEIsDBYlDPX5iN+HhW6FVMSWEMEzUY34DAS+v4Idb6CarCg0
 YShoTW0EStQr6Q/S092VifuvU9X4aUMFoO51oI8RpAGuL02v09boBe8R9zzpsv/6Gcbo
 r7OW/yqZLeMayb05Jsqk1p4VpgQ57PhmFVbvq46ZO70QXzRWxTnaecdExg+5Kl/LGaLe
 IHtvYMj3mcYj8aanKE48HBGr0crUqytljbw8mYLfZj3VsdREZJ3KQYQLtgkiZnDRujAj
 EMS8sD6X5O51vNpjM1oU8/XGCmEglZFEADwbqOXmKoVFaXmxhl6XtHoNfShOVWrHz6PE
 VukQ==
X-Gm-Message-State: AOJu0YxoWLeXyxqvCAwmHRNtDdSsZm7r0MRKm2DVOPIxF8VZCEbCFzum
 NSP7u9+jmhxnY81Zii6wvsG8v07Cbbp/Q4fnXNxtJ7/QEp4PXGCOLwED6HgMf97wiqpFFrY/fJw
 i+SvXmxs=
X-Gm-Gg: AfdE7claCWqGZ9G44ekj3GLc0M2XhPM6mIWDGD5CatBaFvSGHm9EFEqaMKHjBTo+D1z
 ilEqJEoFW65K7GPy3ez+4WV5ikscqUX2V35t9mM8zvTsIsptM22n2l9TlJmd+510kG22JkUVhey
 ZTfvHmGqETL4dbJGZLwUJrpjKPEIbRCPb4LZ8kI4VF9PBh7RVkGpT8Rm2nblPkH1W64lqacZWsZ
 CqXAhiOi4TxIx6Sdc0ID1K4wxJjn08bxWMDG1sPmF37fFaoIUSNo7zyME2dc7u2u/X9RmoLMkHm
 krWAyf9mDD3idETuK4iBYJoYpA3OnLX86xUv7ZxfnLTOVb1q9IDQtBEhY4Mge+gpfAAOQfwxtlT
 eQSpfD4P9UugdLiVb5lKAD8KwfVX1LQlQ4xJRa7QTmrO+bAkwR6Z9mv/PUxqD5T3I5Xt12lCCMk
 a2TEqlwK67KGQfuWpLcpzUr4oV8BkBwbSNapksgm/gtnrCo0eyDani72ekxJsz/4Zp3qImcG8Bf
 fcTKrPDSnt0WLOJYnmlMUYrumd5yOs=
X-Received: by 2002:a2e:9fc2:0:b0:39b:1825:d56d with SMTP id
 38308e7fff4ca-39b1825dab9mr1272681fa.6.1782722813476; 
 Mon, 29 Jun 2026 01:46:53 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:46:52 -0700 (PDT)
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
Subject: [PATCH v4 33/64] usb: dwc3: import from kernel v5.9
Date: Mon, 29 Jun 2026 10:44:09 +0200
Message-ID: <20260629084507.3254232-34-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.8 to v5.9.

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

List of commits: git log --oneline v5.8..v5.9
Commits imported:
a6498d51821e Revert "usb: dwc3: meson-g12a: fix shared reset control use"
6f0306d1bfbc Merge tag 'usb-5.9-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
df561f6688fe treewide: Use fallthrough pseudo-keyword
bc9a2e226ea9 usb: dwc3: gadget: Handle ZLP for sg requests
d2ee3ff79e6a usb: dwc3: gadget: Fix handling ZLP
5d187c0454ef usb: dwc3: gadget: Don't setup more than requested
db123bea9625 usb: dwc3: convert to devm_platform_ioremap_resource_byname
f5e46aa4a124 usb: dwc3: gadget: when the started list is empty stop the active xfer
c5a7092f4015 usb: dwc3: gadget: make starting isoc transfers more robust
ca14378560db usb: dwc3: gadget: add frame number mask
7a410953d1fb usb: dwc3: meson-g12a: fix shared reset control use
eed3c957dd8c Merge 5.8-rc6 into usb-next
10623b879da3 usb: dwc3: Replace HTTP links with HTTPS ones
b789710de583 usb: dwc3: dwc3-qcom: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
26ef796f9306 usb: dwc3: dwc3-of-simple: Function headers are not good candidates for kerneldoc
4d72cf0cb9e2 usb: dwc3: dwc3-haps: Function headers are not suitable for kerneldoc
3c373454a9f2 usb: dwc3: dwc3-omap: Do not read DMA status
fb678a5a76a4 usb: dwc3: ulpi: File headers are not doc headers
7679defc3e29 usb: dwc3: drd: File headers are not doc headers
9cf6ffae3800 Merge 5.8-rc3 into usb-next
62fb45d317c5 USB: ch9: add "USB_" prefix in front of TEST defines

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.c   |   7 +-
 drivers/usb/dwc3/core.h   |   2 +-
 drivers/usb/dwc3/debug.h  |   2 +-
 drivers/usb/dwc3/ep0.c    |  12 +--
 drivers/usb/dwc3/gadget.c | 149 +++++++++++++++++++++++++++++++-------
 drivers/usb/dwc3/gadget.h |   4 +-
 drivers/usb/dwc3/io.h     |   2 +-
 7 files changed, 137 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 25c686a752b0..2eb34c8b4065 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2,7 +2,7 @@
 /**
  * core.c - DesignWare USB3 DRD Controller Core file
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
@@ -646,9 +646,8 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
 				break;
 		}
-		/* FALLTHROUGH */
+		fallthrough;
 	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
-		/* FALLTHROUGH */
 	default:
 		break;
 	}
@@ -1411,7 +1410,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	default:
 		dev_err(dev, "invalid maximum_speed parameter %d\n",
 			dwc->maximum_speed);
-		/* fall through */
+		fallthrough;
 	case USB_SPEED_UNKNOWN:
 		/* default to superspeed */
 		dwc->maximum_speed = USB_SPEED_SUPER;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 013f42a2b5dc..2f04b3e42bf1 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -2,7 +2,7 @@
 /*
  * core.h - DesignWare USB3 DRD Core Header
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index d8f600e0e88f..3d16dac4e5cc 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -2,7 +2,7 @@
 /**
  * debug.h - DesignWare USB3 DRD Controller Debug Header
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 6dee4dabc0a4..59f2e8c31bd1 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -2,7 +2,7 @@
 /*
  * ep0.c - DesignWare USB3 DRD Controller Endpoint 0 Handling
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
@@ -425,11 +425,11 @@ static int dwc3_ep0_handle_test(struct dwc3 *dwc, enum usb_device_state state,
 		return -EINVAL;
 
 	switch (wIndex >> 8) {
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
 		dwc->test_mode_nr = wIndex >> 8;
 		dwc->test_mode = true;
 		break;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 80c3ef134e41..c2a0f64f8d1e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2,7 +2,7 @@
 /*
  * gadget.c - DesignWare USB3 DRD Controller Gadget Framework Link
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
@@ -46,11 +46,11 @@ int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
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
@@ -1054,27 +1054,25 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
  * dwc3_prepare_one_trb - setup one TRB from one request
  * @dep: endpoint for which this request is prepared
  * @req: dwc3_request pointer
+ * @trb_length: buffer size of the TRB
  * @chain: should this TRB be chained to the next?
  * @node: only for isochronous endpoints. First TRB needs different type.
  */
 static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
-		struct dwc3_request *req, unsigned chain, unsigned node)
+		struct dwc3_request *req, unsigned int trb_length,
+		unsigned chain, unsigned node)
 {
 	struct dwc3_trb		*trb;
-	unsigned int		length;
 	dma_addr_t		dma;
 	unsigned		stream_id = req->request.stream_id;
 	unsigned		short_not_ok = req->request.short_not_ok;
 	unsigned		no_interrupt = req->request.no_interrupt;
 	unsigned		is_last = req->request.is_last;
 
-	if (req->request.num_sgs > 0) {
-		length = sg_dma_len(req->start_sg);
+	if (req->request.num_sgs > 0)
 		dma = sg_dma_address(req->start_sg);
-	} else {
-		length = req->request.length;
+	else
 		dma = req->request.dma;
-	}
 
 	trb = &dep->trb_pool[dep->trb_enqueue];
 
@@ -1086,7 +1084,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 
 	req->num_trbs++;
 
-	__dwc3_prepare_one_trb(dep, trb, dma, length, chain, node,
+	__dwc3_prepare_one_trb(dep, trb, dma, trb_length, chain, node,
 			stream_id, short_not_ok, no_interrupt, is_last);
 }
 
@@ -1096,16 +1094,27 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 	struct scatterlist *sg = req->start_sg;
 	struct scatterlist *s;
 	int		i;
-
+	unsigned int length = req->request.length;
 	unsigned int remaining = req->request.num_mapped_sgs
 		- req->num_queued_sgs;
 
+	/*
+	 * If we resume preparing the request, then get the remaining length of
+	 * the request and resume where we left off.
+	 */
+	for_each_sg(req->request.sg, s, req->num_queued_sgs, i)
+		length -= sg_dma_len(s);
+
 	for_each_sg(sg, s, remaining, i) {
-		unsigned int length = req->request.length;
 		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
 		unsigned int rem = length % maxp;
+		unsigned int trb_length;
 		unsigned chain = true;
 
+		trb_length = min_t(unsigned int, length, sg_dma_len(s));
+
+		length -= trb_length;
+
 		/*
 		 * IOMMU driver is coalescing the list of sgs which shares a
 		 * page boundary into one and giving it to USB driver. With
@@ -1113,7 +1122,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		 * sgs passed. So mark the chain bit to false if it isthe last
 		 * mapped sg.
 		 */
-		if (i == remaining - 1)
+		if ((i == remaining - 1) || !length)
 			chain = false;
 
 		if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
@@ -1123,7 +1132,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 			req->needs_extra_trb = true;
 
 			/* prepare normal TRB */
-			dwc3_prepare_one_trb(dep, req, true, i);
+			dwc3_prepare_one_trb(dep, req, trb_length, true, i);
 
 			/* Now prepare one extra TRB to align transfer size */
 			trb = &dep->trb_pool[dep->trb_enqueue];
@@ -1134,8 +1143,39 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 					req->request.short_not_ok,
 					req->request.no_interrupt,
 					req->request.is_last);
+		} else if (req->request.zero && req->request.length &&
+			   !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+			   !rem && !chain) {
+			struct dwc3	*dwc = dep->dwc;
+			struct dwc3_trb	*trb;
+
+			req->needs_extra_trb = true;
+
+			/* Prepare normal TRB */
+			dwc3_prepare_one_trb(dep, req, trb_length, true, i);
+
+			/* Prepare one extra TRB to handle ZLP */
+			trb = &dep->trb_pool[dep->trb_enqueue];
+			req->num_trbs++;
+			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
+					       !req->direction, 1,
+					       req->request.stream_id,
+					       req->request.short_not_ok,
+					       req->request.no_interrupt,
+					       req->request.is_last);
+
+			/* Prepare one more TRB to handle MPS alignment */
+			if (!req->direction) {
+				trb = &dep->trb_pool[dep->trb_enqueue];
+				req->num_trbs++;
+				__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp,
+						       false, 1, req->request.stream_id,
+						       req->request.short_not_ok,
+						       req->request.no_interrupt,
+						       req->request.is_last);
+			}
 		} else {
-			dwc3_prepare_one_trb(dep, req, chain, i);
+			dwc3_prepare_one_trb(dep, req, trb_length, chain, i);
 		}
 
 		/*
@@ -1150,6 +1190,16 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 
 		req->num_queued_sgs++;
 
+		/*
+		 * The number of pending SG entries may not correspond to the
+		 * number of mapped SG entries. If all the data are queued, then
+		 * don't include unused SG entries.
+		 */
+		if (length == 0) {
+			req->num_pending_sgs -= req->request.num_mapped_sgs - req->num_queued_sgs;
+			break;
+		}
+
 		if (!dwc3_calc_trbs_left(dep))
 			break;
 	}
@@ -1169,7 +1219,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		req->needs_extra_trb = true;
 
 		/* prepare normal TRB */
-		dwc3_prepare_one_trb(dep, req, true, 0);
+		dwc3_prepare_one_trb(dep, req, length, true, 0);
 
 		/* Now prepare one extra TRB to align transfer size */
 		trb = &dep->trb_pool[dep->trb_enqueue];
@@ -1180,6 +1230,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 				req->request.no_interrupt,
 				req->request.is_last);
 	} else if (req->request.zero && req->request.length &&
+		   !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 		   (IS_ALIGNED(req->request.length, maxp))) {
 		struct dwc3	*dwc = dep->dwc;
 		struct dwc3_trb	*trb;
@@ -1187,18 +1238,29 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		req->needs_extra_trb = true;
 
 		/* prepare normal TRB */
-		dwc3_prepare_one_trb(dep, req, true, 0);
+		dwc3_prepare_one_trb(dep, req, length, true, 0);
 
-		/* Now prepare one extra TRB to handle ZLP */
+		/* Prepare one extra TRB to handle ZLP */
 		trb = &dep->trb_pool[dep->trb_enqueue];
 		req->num_trbs++;
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
-				false, 1, req->request.stream_id,
+				!req->direction, 1, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt,
 				req->request.is_last);
+
+		/* Prepare one more TRB to handle MPS alignment for OUT */
+		if (!req->direction) {
+			trb = &dep->trb_pool[dep->trb_enqueue];
+			req->num_trbs++;
+			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp,
+					       false, 1, req->request.stream_id,
+					       req->request.short_not_ok,
+					       req->request.no_interrupt,
+					       req->request.is_last);
+		}
 	} else {
-		dwc3_prepare_one_trb(dep, req, false, 0);
+		dwc3_prepare_one_trb(dep, req, length, false, 0);
 	}
 }
 
@@ -1403,7 +1465,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 		 * Check if we can start isoc transfer on the next interval or
 		 * 4 uframes in the future with BIT[15:14] as dep->combo_num
 		 */
-		test_frame_number = dep->frame_number & 0x3fff;
+		test_frame_number = dep->frame_number & DWC3_FRNUMBER_MASK;
 		test_frame_number |= dep->combo_num << 14;
 		test_frame_number += max_t(u32, 4, dep->interval);
 
@@ -1450,7 +1512,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 	else if (test0 && test1)
 		dep->combo_num = 0;
 
-	dep->frame_number &= 0x3fff;
+	dep->frame_number &= DWC3_FRNUMBER_MASK;
 	dep->frame_number |= dep->combo_num << 14;
 	dep->frame_number += max_t(u32, 4, dep->interval);
 
@@ -1463,6 +1525,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 
 static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 {
+	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3 *dwc = dep->dwc;
 	int ret;
 	int i;
@@ -1480,6 +1543,27 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 			return dwc3_gadget_start_isoc_quirk(dep);
 	}
 
+	if (desc->bInterval <= 14 &&
+	    dwc->gadget.speed >= USB_SPEED_HIGH) {
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
 	for (i = 0; i < DWC3_ISOC_MAX_RETRIES; i++) {
 		dep->frame_number = DWC3_ALIGN_FRAME(dep, i + 1);
 
@@ -2649,8 +2733,17 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 				status);
 
 	if (req->needs_extra_trb) {
+		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+
 		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
 				status);
+
+		/* Reclaim MPS padding TRB for ZLP */
+		if (!req->direction && req->request.zero && req->request.length &&
+		    !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+		    (IS_ALIGNED(req->request.length, maxp)))
+			ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event, status);
+
 		req->needs_extra_trb = false;
 	}
 
@@ -2716,7 +2809,9 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
 		goto out;
 
-	if (status == -EXDEV && list_empty(&dep->started_list))
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+		list_empty(&dep->started_list) &&
+		(list_empty(&dep->pending_list) || status == -EXDEV))
 		dwc3_stop_active_transfer(dep, true, true);
 	else if (dwc3_gadget_ep_should_continue(dep))
 		if (__dwc3_gadget_kick_transfer(dep) == 0)
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 24dca3872022..bd85eb7fa9ef 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -2,7 +2,7 @@
 /*
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
@@ -54,6 +54,8 @@ struct dwc3;
 /* U2 Device exit Latency */
 #define DWC3_DEFAULT_U2_DEV_EXIT_LAT	0x1FF	/* Less then 511 microsec */
 
+/* Frame/Microframe Number Mask */
+#define DWC3_FRNUMBER_MASK		0x3fff
 /* -------------------------------------------------------------------------- */
 
 #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, request))
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 9bbe5d4bf076..76b73b116862 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -2,7 +2,7 @@
 /**
  * io.h - DesignWare USB3 DRD IO Header
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
-- 
2.43.0

