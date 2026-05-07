Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1966FCD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6C184AED;
	Thu,  7 May 2026 11:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FzBnJzDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6390784AAD; Thu,  7 May 2026 11:30:30 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66CE884A1E
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5a3af1b7549so720992e87.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146225; x=1778751025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkafB1IAYKjQLPDEXqDqf1K6SnQYUR/I0YMVPk27cIk=;
 b=FzBnJzDV27eJbsrCD9Km6KOGodWWMthz2OKD2O/wKfhdJGrrZcyHHJnYGTvBu+aAjm
 u5Y5UKrReYKAvSOTcgtIFuc1HqymGg2KpeB7+tIZj/im0UQgmxn7/hvLiWcMvqLUOcl8
 z3rA4BQV6bpsux78AaBRlltVJzdyD4AESPlx7Nr2+eAy4aOYgoVlCeKld0JQO5En56DK
 lCcWFTkbVS+n+VsUKEGs7PiwTAebTl+TLDNMK0l3dhQFu1krM11nLIO3MN8kW/k1EiX2
 46RTtWDUxmUEqc5ICcPif0adcwmZvCegQ4bJ+MGapI35ORkVDW6jEMd/zIqgX75jgchW
 xamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146225; x=1778751025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wkafB1IAYKjQLPDEXqDqf1K6SnQYUR/I0YMVPk27cIk=;
 b=BMgMABIUCbHVVpGpYZuCTePKY8mxIexdqQPfsotLWlc2OifzHx2OzalEa+Ok5X/HqQ
 kYPkJwMFPOw4WFkBjIT8OnP3AhMQQpoVCwEE9GJ2BM6iaIhin78iNRB9M0kxXD5N9d0N
 To52ATgnqb+nbrC8Ij77po56f7/6Yxl7IrEgnGQHppnKS8BQFBjNr8bk3Ll6+cjjj25n
 kQpgl0NWGVS3u4leCgjfPXqEL5FYhkANpopWzrbG0098k1rDqoVUh+yAxVwA527eJaA9
 Hd5fqN5mriWmH586GQKkU4IpeM+tEZ0TWruCvDxANK8h1cSpvnyR3lGy4kK6zNsGR2Z8
 lX7Q==
X-Gm-Message-State: AOJu0YzrBfckdWZ8SI8kDDyxH0QMmkhFQiXFvDrX0Qulq77hpPRQzDiW
 2HfMV+LBJFxa1Zj4tPhJFfUcsjq0O0sHzdMjyGgpR4RlrbhVTi3lwt0n5UtqniZ+Bnkxr6yfEyr
 QCvTVX5rP7w==
X-Gm-Gg: AeBDiesEGetDHcvehR8ADOvhMOvVfMvRsuoo7JbwrtiWKnOfy4rbvTTQmbCqy84+Z2E
 UM7jtn1pq6bCOCHIsZQZSmjjdu44h2TDladnqG5S3PkV5T0l/W8SZ4LMClksU/MV6ECSy+hhVd+
 xvt1vhtHe6xbvC1lTW72XE6vQAdPo0hi5VJcIJlvI3YvrTch1Zdb5xJApWDSKafiecXpNtjL5E+
 +oBrHykkgo5WXNcXqx8Ejltw0DAw+OBs8HNLRCKlckaMGgd/nEwcjFDR7fD4eEYNS4Xy+/tnfI8
 YuW4bUUGEdJaeah8qLtrX7/VYJ12WeW3rybU5eOKGXoAePe4OJ6E+jlHsy45IrKm+6FCcoXP1En
 UNAe+vGg+vFoRflfCAxprnaz2tl5zBQbjpMAR5LvWNfyJvd1EwMcXuiwlsg0HPPC8CRO9WTNl6c
 bb6JkAYdebEc5ALxguGU5wpU6n09P4XnS3bs2JJYiHHPREwS3n1P73Hu9kAVVz2sJiTjHd60e3S
 kI3/O81KA0Lew27hJvzJDfguqLTHo9ASICWsH7HtINIRKtIFhWN
X-Received: by 2002:a05:6512:1149:b0:5a8:99c8:94b7 with SMTP id
 2adb3069b0e04-5a899c896a2mr947816e87.18.1778146224981; 
 Thu, 07 May 2026 02:30:24 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:30:23 -0700 (PDT)
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
Subject: [RFC PATCH v2 33/64] usb: dwc3: import from kernel v5.9
Date: Thu,  7 May 2026 11:27:40 +0200
Message-ID: <20260507092843.358908-34-jens.wiklander@linaro.org>
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

