Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE678C61CE3
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:46:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A594980C8A;
	Mon, 24 Aug 2026 16:46:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fbU9ZVA13th4; Mon, 24 Aug 2026 16:46:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589897;
	bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XEkxfUq8rN5jjxou3JKjv04FapQdXRmlpM1kMRkj1uG+PzcZQP4UFH2SBs12pv/dy
	 Mu76jK5xfzk+AzKkVMTss6mqqkFGp5gS2JNgRhAqmJnLWEaD9ujmr05l9HQnwR7yWh
	 snwsZmG96X+02tsu2TqPWgJphjjoJvZDfZfTkAxKRIUQhi4hOanNkCnOhyRn9O93o6
	 S8yIXkGa7LY2U48QwVqQMlaGRF6AF5kpIi8/cXUPeYGa8gLEzWHZuHEdaZXaWpCC3W
	 TYAS17p9hxQJHlXlqkYV187Jr1FPjz/RQt2gpm8InX8cUN09hZ9mWPSe518kkoW9q7
	 xUkWiI5nHSG0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0B2480DE4;
	Mon, 24 Aug 2026 16:44:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 02E04396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E94DF8096E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sHx5H7APOZnd for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:31:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Wruw/GT9
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A006E808C1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:16 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a3ec9ef8d4so720751a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585474; x=1788190274;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
 b=Wruw/GT92o6mXh0MlCceG7zf5Ufv2wDlfyIKrX4YABRCWH+Hcq5cW53MG0NfdI3CEO
 HxZm/ivSZ4CH2wghv5hlWtVgsRHcMqLC0UHzLS+w6904JxQ9N+k2M/PeEFXYjS4QssYr
 lFxpu7ktUSwr9iYwcan9C2ijNF3AH8yZgOZCZ5pZAkaKn1c757z6VpOPBJlfO5LdiKSl
 hRiWufvyNJGXGxp14Kp/C9tb5poq9qcPlJZBNTBz4qhYjkVrPwibNvdUcpTm4Cg73n0P
 JrvKoIkzm4wokod8wIQn4t58oBldME2VwaiOncNuA7wEqFJRwGXVxuGxebce2nUaZmfW
 dWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585474; x=1788190274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
 b=e4xfgp3Vc3vgWWPcDCJtuRwL4YJ5ihCPpPI/OSgCwrBamqD42MgpgKiouSP4keaelc
 VHNmbbuHkPsQwODUUDZwnyMmpDzD1cBYGypYKSa1CHzS47EZLozJd2rh6WyI9SFfhSn9
 2A0+H5tNo7TJzyI4d8zAIJCLHdJO0Zec8PhfiL1U53uOORR4eGGDppSW3dxBsboBxn0d
 eX4cHlCltEYkf5a0Pgb4Nk+GlYsebRokGz4kun20NkGANdpj3WEw1davNQSx/mOuZWlP
 cEf8hXgGj8gR7xFyaE5XQ7PO1MK7CUu430oZUWYCGDM5UDHWo62VTJlY6elKzTeVYzGW
 +KBQ==
X-Gm-Message-State: AFuF++ka3IzrzoGoxOQ1Ii+ikAgzoR6RjpK0w7gO3YokILlGGDBOkZxY
 8Z/ERIIXx1C8uKsAKrUnshhwxpvCMQnkAqoic2F/EjD4u2PpYRRIlqquXwEoBZcaomsi7VICFFF
 PfrgV
X-Gm-Gg: AR+sD13TWkrHjD0fM6CqypK4SnG9JL5MW5sX5rIhRaBSvNPrcTV8g7TSxUR6dbBWItM
 JEfHp74VlbeXdZLI7jHTKiJ53kzUAekEbLYNk5y6TfDN4j3lNQjVfaeGDlSJeYByRKHuOMelPmd
 UR+9KKh99T3C+tQowaIVmr6ux+Xhq3L3nKBUE8ZGRZuHR9xiYCnwWnrLHdehvqAyhhG74sSEmhC
 gtrtmpD9V+gWRcvXAPxy3FiHk5HkHg0Zm4Xi50+cTVoxCa69haB+SYkzF9DXWYN8+qTVi3QIx+x
 XrWhptC0zc6c7CP5dVWxqsGicuJYN+kdpQfFSD8lg32EsDrrEpySHrdqS3cZLiB6WxQgWHeX4Jg
 jhE2ZsjAaAivLjOsQcv8056HaqVE3i61buEzeC5Wt4sy+GUQnLAgU+oQI+ijHE2VpudxJePXymE
 3jMtrkOAWWwleWztic6h4LDvn9riYx8Yp8RgQRBbnInbSMQ65ES01PD/7RwnE5mBToBTLxas3GA
 hYv46C2h9tzlgvHqlV/vSd+0r/jqO1/4w==
X-Received: by 2002:a17:906:c144:b0:c1f:e0fd:1140 with SMTP id
 a640c23a62f3a-c2469f92425mr1417496266b.0.1787585472187; 
 Mon, 24 Aug 2026 08:31:12 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm1479917366b.18.2026.08.24.08.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:31:11 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 42/63] usb: dwc3: import from kernel v5.17
Date: Mon, 24 Aug 2026 17:27:13 +0200
Message-ID: <20260824152734.159794-43-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.16 to v5.17.

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

List of commits: git log --oneline v5.16..v5.17
Commits imported:
84918a89d6ef usb: dwc3: gadget: Let the interrupt handler disable bottom halves.
117b4e96c7f3 usb: dwc3: gadget: Prevent core from processing stale TRBs
666f3de741f7 usb: dwc3: gadget: Support Multi-Stream Transfer
76c4c95dac0d usb: dwc3: gadget: Skip reading GEVNTSIZn
a02a26eb0aea usb: dwc3: gadget: Ignore Update Transfer cmd params
bc27117c7cdd usb: dwc3: gadget: Skip checking Update Transfer status

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

