Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C053C44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2ED84DD6;
	Thu, 16 Jul 2026 18:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PKhQOoJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F2884CEB; Thu, 16 Jul 2026 15:43:47 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E604384CCF
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c15e62c695cso54116966b.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209424; x=1784814224; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MATNoLZewRPg3gNTtcfjP3OhBCI/1D270HXYLoZsYH0=;
 b=PKhQOoJDYUlOp444XAiaBJwN0plRLI2uKmkIdPIyRwOXQl+FSMUwL1w6djCsBADewH
 6YrLZL6+Weqlz6kMqKVEF24zH3cOjBm8PpeVYlUkfckjKjED5XuuCXUhhmtdTx4TjG5N
 rG3QWe+3RDmC1vixFQAOEa8hEWNCXdn+FodGFb7wiF5BoTqR62Q68XiwKlhbY5Y499y/
 wfHA5voC7G20ph0wSmyRYqyJCYieOLUFryNF08sB4VPcVuhfARH5ajuKtsb8Nltv+fFb
 oJYOvwk6AS+AMGh/m3InHkRQIYRIjhKh0kVzL970VWGAwYE0Jm5T/ussAL2XBJvUW6bF
 8A8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209424; x=1784814224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MATNoLZewRPg3gNTtcfjP3OhBCI/1D270HXYLoZsYH0=;
 b=jnVVJAhBm31N88TvCl92tUwS5vvxw38VR3LHphinxfkIhBJ0NxlISI7i5XzIFERBvH
 RP2y6y2QiyPoFQcQiYsI1sVb//Za2S5ZeBuk4Oa4/6zMK8HGkhLNOALUj0d2PcN+TUyD
 V9j7POuZgzURhnr2MUicekjD3XxyzrQlxQ6Tg5CIN99UDWPITMdPk7v/ugosJlrM2Fl/
 3x9e8vCM5l6jvS/affOWe/7HJWmnByAkwOq+hKqIOHcjjq/RKWdJDBPTZKBsQaXcE98V
 AA8pYw1lPpe5NU00DfTDaMqyzvVadL/5WmrPMbasQBWE89ITOs9o9Sa+NGs3cb6n+nkU
 WRbw==
X-Gm-Message-State: AOJu0YzaXxlnszNkVsn3ew71ce+eRXb2hpKa47XToG8Bz2gmba1YBZVQ
 nsRV5c5oSE4mPNmi67tH/FzaUspknmLw3FwrFGYkhm3YhX4Mf7iOOLLeW8OUiHgAFfiIC2MDp/b
 /2eJK
X-Gm-Gg: AfdE7cncOM1N4IOIbEEjuNKaugnCblhRCa42O/oCTmJughBesYOIscRWAkF/jVvefwH
 asre8KqzE6dGNHEbOaHU2VW8QC1wmwyO3MNH6+6fsgXBkCkWxDGN1P3eYZTbYVtT/dkY1ZKPeFg
 9x5F58hLIe1pXvC9WovNVmBiBXeRgXvnqLtpQz6KDJzhBTL6v+vUgXXo7FEghnNe4e9myT6hsid
 DR3SP7UcHJ0VrApglVRjQw5tKocdJI84d2ZhQIsoCM5xvanKE4oFf6pVFXDMzgAP6xn8Wz1ko02
 dt10Ur06uoJvCZemibHgEFn1usZDQHk8NrB8qwANV9Yp1Gfk619ehKNMpNwjQDBUnXr6cj32j5I
 RaxN6v9xayal6tOkkADDPuoYGFzb9b16JQiJBNef/7+sQFJ1YhkWBYGZIP6HDHYhEPc+ImhLEg4
 /yRTLwCtZKjHm+DKAxVZNSJzLMcqrswyRYb3Oupg==
X-Received: by 2002:a17:907:3f0c:b0:c15:f373:47b6 with SMTP id
 a640c23a62f3a-c161f3bb457mr742480966b.3.1784209424267; 
 Thu, 16 Jul 2026 06:43:44 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16874515basm211361066b.53.2026.07.16.06.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:43 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 23/75] usb: dwc3: import from kernel v4.20
Date: Thu, 16 Jul 2026 15:41:53 +0200
Message-ID: <20260716134305.614278-24-anders.roxell@linaro.org>
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

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
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
2.53.0

