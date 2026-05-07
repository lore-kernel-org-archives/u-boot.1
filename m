Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD7ACD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 753B084A57;
	Thu,  7 May 2026 11:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SqImiPoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511D984A52; Thu,  7 May 2026 11:29:11 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5FCA84A48
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a8704dc3a8so595654e87.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146145; x=1778750945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8f9Vv/CTOal+qQr8OfE55tUHX0A+67/7AaEmBMTsXM=;
 b=SqImiPohCiBlDhwOdQimT5M/m6pDWvWiq3x7i5/n2sv6bJhtgVMDaLWDYLXU8hVWF9
 TY+7tIVVywxR0pjlY1u2931Fc1nd3JwhuCt1bWOI7y9VmyYQvJH+YrZF1pYmbiEUteiO
 A2qa5C+thXCluSdEvQRMmgUfwmcFzK/ouRE0yOu4aqVrcvX0eNJjXFjHkPWwXfod0Pig
 ajMLtdFOlReuYXxyoS4OQqjQvxt9tysFVA6ul96pDtZIDDNqg1A2XkILRfTbPm2XD9wl
 99Gwh/75aJR9KqK/HVdzp+WqAO2YffeeXgSFHmSIRCGA9T4d1IjxyTE7HrWBOF7KnHZi
 6ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146145; x=1778750945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W8f9Vv/CTOal+qQr8OfE55tUHX0A+67/7AaEmBMTsXM=;
 b=mp6hTWjm/Zj+OuLnaNcCuEgWdZgjWkq1scRD5AkifBlKzcXrWnTKAW/er7q7bbWOjA
 aHg7zhOso0v6qhNx+gvcKmvWiE36l7jmPqkrvgVHHySOsCUHYbVu9xcwIdptP8qWt69J
 y2RPBUw3uDuXNUsr0TshdCQkjMLTb5a/NnMf07okNZfBo/RUj9TVGvu7ekG7H9fAQnh8
 cY93flsVfx4ALkP2z4I0nbhBLBz/oB6cm5SOhEiiKau0orsKVKah0Jg9DTZI2IUs7zZy
 ZCnUBcGY2r0jFh5dcioF8jlm0wcC+TzqBjld/VaqHh03it2BOIi/bRArhC8zSddlIyV5
 DDPA==
X-Gm-Message-State: AOJu0YzlZgROO2z5FEWNBg4a6Ak2xlM/ZCH6BvqDmKxr27cFMM4P93se
 le1/qiA1eXB2S46DYEtYCpmeqIMeIvxZBdYYVx4SRr18DD+uh/SXmvoA7A0QY17eV+OlG63Wl3L
 dP7yP9MZujw==
X-Gm-Gg: AeBDies6OnbBRv3HylJ8vw6q1+A/5A0NiNaRLyF+PfYaBqCtNsYkFRfXbpqGNHuAv40
 nAL85L1+ovt86+NsiXSpy1uyLaeRnit+WwvWqDK5jjG0eUQUDSCsIVlT07zUJYinbOmQD3xE0VG
 +yCtCNQLZ9hcjo+cqpxtPkiXYjD1NCcb1kSQd47bS5qRTeAsxYlPsLDVqxPt/FCb0kZfOM2mUip
 lHRE5pH+BmU3tVG2m1kaECXYNh3SRSkA0RexzohfzWA5VAYcAdZ1qNbPWx8FPQQLaVoyUj7ospZ
 1i/jJLPpO5B/OE0BAg4gMNvofMrWh7u+pf14mSQgiz26j6fetuN5UOifPeaw5wgyi0ga/7fddVo
 75kUwAKDgdXPUuMgqytViJJEmwhwKCcBVh+rG7X0gMDp0O6KKWZ3eUiyTcmZv3O8X+4LTcv85x1
 JZhka5pl2Rk4UhMiOyZz3etpr56kx2iG35Ds9x3kQsI5h8GYhTi4T/i2msxtX/Oig5aYhsuinVX
 2mcLKnct6DP6RDYG6p09yyEfJNcjyuvglLbYSAf5g/YKZxIXnDm
X-Received: by 2002:a05:6512:3ca7:b0:5a8:7f30:609f with SMTP id
 2adb3069b0e04-5a887adff60mr3015210e87.10.1778146145271; 
 Thu, 07 May 2026 02:29:05 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:03 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/64] usb: dwc3: import from kernel v4.3
Date: Thu,  7 May 2026 11:27:13 +0200
Message-ID: <20260507092843.358908-7-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.2 to v4.3.

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

List of commits: git log --oneline v4.2..v4.3
Commits imported:
a66c275b3d5d usb: dwc3: gadget: Fix BUG in RT config
e2ae0692bf6f usb: dwc3: omap: enable irqs lately
a474d3b73ba7 usb: dwc3: gadget: add ep capabilities support
c0bd5456a470 usb: dwc3: ep0: handle non maxpacket aligned transfers > 512
2abd9d5fa60f usb: dwc3: ep0: Add chained TRB support
368ca113ca0a usb: dwc3; ep0: Modify _dwc3_ep0_start_trans_ API to take 'chain' parameter
8a3442205630 usb: dwc3: ep0: preparation for handling non maxpacket aligned transfers > 512
2e5464da4e7d usb: dwc3: ep0: use _roundup_ to calculate the transfer size
b2fb5b1a0f50 usb: dwc3: ep0: Fix mem corruption on OUT transfers of more than 512 bytes
aa7399744dd0 usb: dwc3: gadget: defer endpoint name change
7eaeac5c0e44 usb: dwc3: gadget: add a trace when disabling EPs
d9972f470bcb usb: dwc3: core: remove unnecessary dev_warn()
2df033ca39b5 usb: dwc3: pci: make better use of gpiod API
5960387a2fb8 usb: dwc3: omap: Replace deprecated API of extcon
9fcfa463e17a usb: dwc3: drop CONFIG_USB_DWC3_DEBUG
e746b06cc76a usb: dwc3: st: remove two unnecessary messages
2babd0d148a3 usb: dwc3: qcom: switch dev_dbg() to dev_info()
42f69a02e7ab usb: dwc3: exynos: switch dev_dbg() to dev_info()
9ff0fdca3b62 usb: dwc3: keystone: convert dev_dbg() to dev_err()
e4f756675467 usb: dwc3: omap: drop dev_dbg() usage

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   |  2 -
 drivers/usb/dwc3/ep0.c    | 92 ++++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/gadget.c | 61 +++++++++++++++-----------
 3 files changed, 101 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ff5773c66b84..064123e44566 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -455,8 +455,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
 			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 		} else {
-			dev_warn(dwc->dev, "HSPHY Interface not defined\n");
-
 			/* Relying on default value. */
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
 				break;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 69e769c35cf5..5320e939e090 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -56,7 +56,7 @@ static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
 }
 
 static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
-		u32 len, u32 type)
+		u32 len, u32 type, bool chain)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_trb			*trb;
@@ -70,7 +70,10 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 		return 0;
 	}
 
-	trb = dwc->ep0_trb;
+	trb = &dwc->ep0_trb[dep->free_slot];
+
+	if (chain)
+		dep->free_slot++;
 
 	trb->bpl = lower_32_bits(buf_dma);
 	trb->bph = upper_32_bits(buf_dma);
@@ -78,10 +81,17 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 	trb->ctrl = type;
 
 	trb->ctrl |= (DWC3_TRB_CTRL_HWO
-			| DWC3_TRB_CTRL_LST
-			| DWC3_TRB_CTRL_IOC
 			| DWC3_TRB_CTRL_ISP_IMI);
 
+	if (chain)
+		trb->ctrl |= DWC3_TRB_CTRL_CHN;
+	else
+		trb->ctrl |= (DWC3_TRB_CTRL_IOC
+				| DWC3_TRB_CTRL_LST);
+
+	if (chain)
+		return 0;
+
 	memset(&params, 0, sizeof(params));
 	params.param0 = upper_32_bits(dwc->ep0_trb_addr);
 	params.param1 = lower_32_bits(dwc->ep0_trb_addr);
@@ -302,7 +312,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	int				ret;
 
 	ret = dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8,
-			DWC3_TRBCTL_CONTROL_SETUP);
+			DWC3_TRBCTL_CONTROL_SETUP, false);
 	WARN_ON(ret < 0);
 }
 
@@ -783,7 +793,11 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	u32			transferred;
+	unsigned		transfer_size = 0;
+	unsigned		maxp;
+	unsigned		remaining_ur_length;
+	void			*buf;
+	u32			transferred = 0;
 	u32			status;
 	u32			length;
 	u8			epnum;
@@ -812,17 +826,37 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	}
 
 	ur = &r->request;
+	buf = ur->buf;
+	remaining_ur_length = ur->length;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
 
+	maxp = ep0->endpoint.maxpacket;
+
 	if (dwc->ep0_bounced) {
-		unsigned transfer_size = ur->length;
-		unsigned maxp = ep0->endpoint.maxpacket;
+		/*
+		 * Handle the first TRB before handling the bounce buffer if
+		 * the request length is greater than the bounce buffer size
+		 */
+		if (ur->length > DWC3_EP0_BOUNCE_SIZE) {
+			transfer_size = ALIGN(ur->length - maxp, maxp);
+			transferred = transfer_size - length;
+			buf = (u8 *)buf + transferred;
+			ur->actual += transferred;
+			remaining_ur_length -= transferred;
+
+			trb++;
+			length = trb->size & DWC3_TRB_SIZE_MASK;
 
-		transfer_size += (maxp - (transfer_size % maxp));
-		transferred = min_t(u32, ur->length,
-				transfer_size - length);
-		memcpy(ur->buf, dwc->ep0_bounce, transferred);
+			ep0->free_slot = 0;
+		}
+
+		transfer_size = roundup((ur->length - transfer_size),
+					maxp);
+
+		transferred = min_t(u32, remaining_ur_length,
+				    transfer_size - length);
+		memcpy(buf, dwc->ep0_bounce, transferred);
 	} else {
 		transferred = ur->length - length;
 	}
@@ -844,7 +878,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 			ret = dwc3_ep0_start_trans(dwc, epnum,
 					dwc->ctrl_req_addr, 0,
-					DWC3_TRBCTL_CONTROL_DATA);
+					DWC3_TRBCTL_CONTROL_DATA, false);
 			WARN_ON(ret < 0);
 		}
 	}
@@ -928,10 +962,10 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 	if (req->request.length == 0) {
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ctrl_req_addr, 0,
-				DWC3_TRBCTL_CONTROL_DATA);
+				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
 			&& (dep->number == 0)) {
-		u32	transfer_size;
+		u32	transfer_size = 0;
 		u32	maxpacket;
 
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
@@ -941,21 +975,26 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			return;
 		}
 
-		WARN_ON(req->request.length > DWC3_EP0_BOUNCE_SIZE);
-
 		maxpacket = dep->endpoint.maxpacket;
-		transfer_size = roundup(req->request.length, maxpacket);
+
+		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
+			transfer_size = ALIGN(req->request.length - maxpacket,
+					      maxpacket);
+			ret = dwc3_ep0_start_trans(dwc, dep->number,
+						   req->request.dma,
+						   transfer_size,
+						   DWC3_TRBCTL_CONTROL_DATA,
+						   true);
+		}
+
+		transfer_size = roundup((req->request.length - transfer_size),
+					maxpacket);
 
 		dwc->ep0_bounced = true;
 
-		/*
-		 * REVISIT in case request length is bigger than
-		 * DWC3_EP0_BOUNCE_SIZE we will need two chained
-		 * TRBs to handle the transfer.
-		 */
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ep0_bounce_addr, transfer_size,
-				DWC3_TRBCTL_CONTROL_DATA);
+				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else {
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
@@ -965,7 +1004,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		}
 
 		ret = dwc3_ep0_start_trans(dwc, dep->number, req->request.dma,
-				req->request.length, DWC3_TRBCTL_CONTROL_DATA);
+				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
+				false);
 	}
 
 	WARN_ON(ret < 0);
@@ -980,7 +1020,7 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 		: DWC3_TRBCTL_CONTROL_STATUS2;
 
 	return dwc3_ep0_start_trans(dwc, dep->number,
-			dwc->ctrl_req_addr, 0, type);
+			dwc->ctrl_req_addr, 0, type, false);
 }
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 333a7c0078fc..1e8bdf817811 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -547,6 +547,23 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
 	}
 
+	switch (usb_endpoint_type(desc)) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		strlcat(dep->name, "-control", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_ISOC:
+		strlcat(dep->name, "-isoc", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		strlcat(dep->name, "-bulk", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		strlcat(dep->name, "-int", sizeof(dep->name));
+		break;
+	default:
+		dev_err(dwc->dev, "invalid endpoint transfer type\n");
+	}
+
 	return 0;
 }
 
@@ -586,6 +603,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	struct dwc3		*dwc = dep->dwc;
 	u32			reg;
 
+	dwc3_trace(trace_dwc3_gadget, "Disabling %s", dep->name);
+
 	dwc3_remove_requests(dwc, dep);
 
 	/* make sure HW endpoint isn't stalled */
@@ -602,6 +621,10 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	dep->type = 0;
 	dep->flags = 0;
 
+	snprintf(dep->name, sizeof(dep->name), "ep%d%s",
+			dep->number >> 1,
+			(dep->number & 1) ? "in" : "out");
+
 	return 0;
 }
 
@@ -647,23 +670,6 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 		return 0;
 	}
 
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
-		dev_err(dwc->dev, "invalid endpoint transfer type\n");
-	}
-
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_enable(dep, desc, ep->comp_desc, false, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -692,10 +698,6 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 		return 0;
 	}
 
-	snprintf(dep->name, sizeof(dep->name), "ep%d%s",
-			dep->number >> 1,
-			(dep->number & 1) ? "in" : "out");
-
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_disable(dep);
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -1713,6 +1715,17 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 				return ret;
 		}
 
+		if (epnum == 0 || epnum == 1) {
+			dep->endpoint.caps.type_control = true;
+		} else {
+			dep->endpoint.caps.type_iso = true;
+			dep->endpoint.caps.type_bulk = true;
+			dep->endpoint.caps.type_int = true;
+		}
+
+		dep->endpoint.caps.dir_in = !!direction;
+		dep->endpoint.caps.dir_out = !direction;
+
 		INIT_LIST_HEAD(&dep->request_list);
 		INIT_LIST_HEAD(&dep->req_queued);
 	}
@@ -2652,8 +2665,6 @@ static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
 	int				i;
 	irqreturn_t			ret = IRQ_NONE;
 
-	spin_lock(&dwc->lock);
-
 	for (i = 0; i < dwc->num_event_buffers; i++) {
 		irqreturn_t status;
 
@@ -2662,8 +2673,6 @@ static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
 			ret = status;
 	}
 
-	spin_unlock(&dwc->lock);
-
 	return ret;
 }
 
@@ -2685,7 +2694,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err0;
 	}
 
-	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
 			&dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
-- 
2.43.0

