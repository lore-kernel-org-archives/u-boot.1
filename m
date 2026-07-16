Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B91C44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8094584DEB;
	Thu, 16 Jul 2026 18:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iHIGbbAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 219FD84CE8; Thu, 16 Jul 2026 15:44:13 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E497584CCF
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c160875e029so64580366b.3
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209450; x=1784814250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Lxoa6AR5/04sCwGvAM6T8eI/eUoVDQ8GlACPiK3gWs=;
 b=iHIGbbALq1V/MQOh5ideST2BqFxnioP/IjEznEVJG6PCBjJT6PYamyLWnqQc0mKPML
 W74Ooh7uNObgPSR160/COhQcWm65mA0fw/kK9E/87Pjob/LjEbN30Q2qqClOE0iAaEDz
 K4x7NgubmIknTNZOgaJy7Hh50fFssJNQjA4/pkdREf9n1RVq4D4IcehaVkNO9+hgXdQj
 BQIUfDg11si9ya8PsmXnnjyZa6usxJ8IdCU9HztBw3AmmzE6EXzf3QJIRpZikxhNwBF9
 5dHeCANYReRmxqRIxOMspBsaErWokM1ftz5JM7fP465GAyJ4QHn1mShwOgQheXWmpDIA
 +4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209450; x=1784814250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Lxoa6AR5/04sCwGvAM6T8eI/eUoVDQ8GlACPiK3gWs=;
 b=kqpT51KtN9+z8Ycp+HEkwsKDgLpZ585Dw4iy9nG3Iy6jRgX7PG+IcRxPwETHvPg5bv
 YXAlzWO0MJZpOOo7R9Ak0oSScndgmqrYhDxz3OhDtfBAh5bshN9wwMS88UDpL2Jq5Sab
 R4U5J4r03cKTSeWzPKCS/i9xwyyhIcMikU8yrUMszt24cyCv/AtA2sK+tVcDBZtHYFNZ
 OhuXbjri05zdvxMvd9j5j9tHa/i0WfDVp6I2ghydePFNIRYb4tYTETeoUx7G0FI9iIUD
 jlhrbDtM43GkPG5k8w0kUApMrUwnRm0kVE2G/LjUvWJixIgoiJQjHPirWXPqkn+v0ORI
 78oQ==
X-Gm-Message-State: AOJu0Yy+VHsiKY1T+8j+utU971bOkFHZFzIizFXF7zbnIP4qlkWhYkhx
 C/nKY6a5gTuNqE3SsvJ/8BcvAvKZ8WDJoN1G/6VlDybybC1ZyidSulSQEAs37pLTgbc64UPQjeh
 wiJst
X-Gm-Gg: AfdE7cn7VmKLeyH0YYEckB47F9suZUCMMSKosQk82zYhM8EtGct9AlFwu8MxcugRjma
 y/m6JkINGz+gWayW0ha9Sh2xOd7hRVM+21fn+BEUKYiSG0lUVU9JOGJz2eWKqvqw767rx/i7hS2
 DWBky8CT8F7Y9DG02s35xQfyZ4K0ngugH6fupIcM7o31qms/sY57U6m59QRS8TXp4zvg/NCTTUU
 8iGFdDXyPXigYUhenvkr7wO79u6vCovQKwgnp7QSEQEe0PBqIc8EdcdvOcrFlfJUcumX3IRJVzD
 l2ogc6H94Jic4LK7L5WIBD13lR0n2X9HPQxki8HHNBb6CmrtZ3HO5CwVKX/p4bhlGFXcOvrUcw7
 hYzHF/auTeq+R9QWnVej+omrCUNpI9N0t46OJRAABQpW/fWqLp2jBiH0lxn4KYm9OgtYDeAaOUw
 V17rrmwyKq7nn+Sqz5wYAcKv2cXH1NmTq2OtMYUQ==
X-Received: by 2002:a17:907:7ba0:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c168dd881e9mr106008166b.3.1784209450201; 
 Thu, 16 Jul 2026 06:44:10 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744fd9csm222595366b.42.2026.07.16.06.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:09 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 41/75] usb: dwc3: import from kernel v5.17
Date: Thu, 16 Jul 2026 15:42:11 +0200
Message-ID: <20260716134305.614278-42-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.16 to v5.17.

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

List of commits: git log --oneline v5.16..v5.17
Commits imported:
84918a89d6ef usb: dwc3: gadget: Let the interrupt handler disable bottom halves.
62e3f0afe246 usb: dwc3: pci: Fix Bay Trail phy GPIO mappings
d7c93a903f33 usb: dwc3: pci: Add "snps,dis_u2_susphy_quirk" for Intel Bay Trail
038438a25c45 usb: dwc3: pci: add support for the Intel Raptor Lake-S
117b4e96c7f3 usb: dwc3: gadget: Prevent core from processing stale TRBs
b470947c3672 usb: dwc3: xilinx: fix uninitialized return value
2cc9b1c93b1c usb: dwc3: xilinx: Fix error handling when getting USB3 PHY
9678f3361afc usb: dwc3: xilinx: Skip resets and USB3 register settings for USB2.0 mode
b52fe2dbb3e6 usb: dwc3: qcom: Fix NULL vs IS_ERR checking in dwc3_qcom_probe
fa0ef93868a6 usb: dwc3: dwc3-qcom: Add missing platform_device_put() in dwc3_qcom_acpi_register_core
74b39dfabd76 usb: dwc3: Drop unneeded calls to platform_get_resource_byname()
666f3de741f7 usb: dwc3: gadget: Support Multi-Stream Transfer
76c4c95dac0d usb: dwc3: gadget: Skip reading GEVNTSIZn
a02a26eb0aea usb: dwc3: gadget: Ignore Update Transfer cmd params
bc27117c7cdd usb: dwc3: gadget: Skip checking Update Transfer status
4ce3b45704d5 usb: dwc3: meson-g12a: fix shared reset control use

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.h   |  9 +++++
 drivers/usb/dwc3/gadget.c | 74 ++++++++++++++++++++++++++++++---------
 2 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5c491d0a19d7..e1cc3f7398fb 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -153,6 +153,7 @@
 #define DWC3_DGCMDPAR		0xc710
 #define DWC3_DGCMD		0xc714
 #define DWC3_DALEPENA		0xc720
+#define DWC3_DCFG1		0xc740 /* DWC_usb32 only */
 
 #define DWC3_DEP_BASE(n)	(0xc800 + ((n) * 0x10))
 #define DWC3_DEPCMDPAR2		0x00
@@ -382,6 +383,7 @@
 
 /* Global HWPARAMS9 Register */
 #define DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS	BIT(0)
+#define DWC3_GHWPARAMS9_DEV_MST			BIT(1)
 
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
@@ -558,6 +560,9 @@
 /* The EP number goes 0..31 so ep0 is always out and ep1 is always in */
 #define DWC3_DALEPENA_EP(n)		BIT(n)
 
+/* DWC_usb32 DCFG1 config */
+#define DWC3_DCFG1_DIS_MST_ENH		BIT(1)
+
 #define DWC3_DEPCMD_TYPE_CONTROL	0
 #define DWC3_DEPCMD_TYPE_ISOC		1
 #define DWC3_DEPCMD_TYPE_BULK		2
@@ -888,6 +893,10 @@ struct dwc3_hwparams {
 /* HWPARAMS7 */
 #define DWC3_RAM1_DEPTH(n)	((n) & 0xffff)
 
+/* HWPARAMS9 */
+#define DWC3_MST_CAPABLE(p)	(!!((p)->hwparams9 &		\
+			DWC3_GHWPARAMS9_DEV_MST))
+
 /**
  * struct dwc3_request - representation of a transfer request
  * @request: struct usb_request to be transferred
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 7e3db00e9759..a0c883f19a41 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -331,9 +331,17 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		}
 	}
 
-	dwc3_writel(dep->regs, DWC3_DEPCMDPAR0, params->param0);
-	dwc3_writel(dep->regs, DWC3_DEPCMDPAR1, params->param1);
-	dwc3_writel(dep->regs, DWC3_DEPCMDPAR2, params->param2);
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
 
 	/*
 	 * Synopsys Databook 2.60a states in section 6.3.2.5.6 of that if we're
@@ -357,6 +365,12 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		cmd |= DWC3_DEPCMD_CMDACT;
 
 	dwc3_writel(dep->regs, DWC3_DEPCMD, cmd);
+
+	if (!(cmd & DWC3_DEPCMD_CMDACT)) {
+		ret = 0;
+		goto skip_status;
+	}
+
 	do {
 		reg = dwc3_readl(dep->regs, DWC3_DEPCMD);
 		if (!(reg & DWC3_DEPCMD_CMDACT)) {
@@ -398,6 +412,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		cmd_status = -ETIMEDOUT;
 	}
 
+skip_status:
 	trace_dwc3_gadget_ep_cmd(dep, cmd, params, cmd_status);
 
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
@@ -1260,17 +1275,35 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 	}
 
+	/* All TRBs setup for MST must set CSP=1 when LST=0 */
+	if (dep->stream_capable && DWC3_MST_CAPABLE(&dwc->hwparams))
+		trb->ctrl |= DWC3_TRB_CTRL_CSP;
+
 	if ((!no_interrupt && !chain) || must_interrupt)
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
-	else if (dep->stream_capable && is_last)
+	else if (dep->stream_capable && is_last &&
+		 !DWC3_MST_CAPABLE(&dwc->hwparams))
 		trb->ctrl |= DWC3_TRB_CTRL_LST;
 
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
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
 
 	dwc3_ep_inc_enq(dep);
@@ -1513,7 +1546,8 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 		 * burst capability may try to read and use TRBs beyond the
 		 * active transfer instead of stopping.
 		 */
-		if (dep->stream_capable && req->request.is_last)
+		if (dep->stream_capable && req->request.is_last &&
+		    !DWC3_MST_CAPABLE(&dep->dwc->hwparams))
 			return ret;
 	}
 
@@ -1546,7 +1580,8 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 		 * burst capability may try to read and use TRBs beyond the
 		 * active transfer instead of stopping.
 		 */
-		if (dep->stream_capable && req->request.is_last)
+		if (dep->stream_capable && req->request.is_last &&
+		    !DWC3_MST_CAPABLE(&dwc->hwparams))
 			return ret;
 	}
 
@@ -1623,7 +1658,8 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		return ret;
 	}
 
-	if (dep->stream_capable && req->request.is_last)
+	if (dep->stream_capable && req->request.is_last &&
+	    !DWC3_MST_CAPABLE(&dep->dwc->hwparams))
 		dep->flags |= DWC3_EP_WAIT_TRANSFER_COMPLETE;
 
 	return 0;
@@ -2638,6 +2674,13 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	reg |= DWC3_DCFG_IGNSTRMPP;
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
+	/* Enable MST by default if the device is capable of MST */
+	if (DWC3_MST_CAPABLE(&dwc->hwparams)) {
+		reg = dwc3_readl(dwc->regs, DWC3_DCFG1);
+		reg &= ~DWC3_DCFG1_DIS_MST_ENH;
+		dwc3_writel(dwc->regs, DWC3_DCFG1, reg);
+	}
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
@@ -3437,7 +3480,8 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 	case DEPEVT_STREAM_NOSTREAM:
 		if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
 		    !(dep->flags & DWC3_EP_FORCE_RESTART_STREAM) ||
-		    !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE))
+		    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
+		     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
 			break;
 
 		/*
@@ -4067,7 +4111,6 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	struct dwc3 *dwc = evt->dwc;
 	irqreturn_t ret = IRQ_NONE;
 	int left;
-	u32 reg;
 
 	left = evt->count;
 
@@ -4099,9 +4142,8 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	ret = IRQ_HANDLED;
 
 	/* Unmask interrupt */
-	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
-	reg &= ~DWC3_GEVNTSIZ_INTMASK;
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
+		    DWC3_GEVNTSIZ_SIZE(evt->length));
 
 	if (dwc->imod_interval) {
 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
@@ -4118,9 +4160,11 @@ static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
+	local_bh_disable();
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = dwc3_process_event_buf(evt);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }
@@ -4130,7 +4174,6 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	struct dwc3 *dwc = evt->dwc;
 	u32 amount;
 	u32 count;
-	u32 reg;
 
 	if (pm_runtime_suspended(dwc->dev)) {
 		pm_runtime_get(dwc->dev);
@@ -4157,9 +4200,8 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	evt->flags |= DWC3_EVENT_PENDING;
 
 	/* Mask interrupt */
-	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
-	reg |= DWC3_GEVNTSIZ_INTMASK;
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
+		    DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
 
 	amount = min(count, evt->length - evt->lpos);
 	memcpy(evt->cache + evt->lpos, evt->buf + evt->lpos, amount);
-- 
2.53.0

