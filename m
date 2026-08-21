Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB14C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8FD340C85;
	Fri, 21 Aug 2026 13:13:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pd2GLRj-nav7; Fri, 21 Aug 2026 13:13:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318020;
	bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lzqVgFzWlr1OtBiYEzF8g5IK3eJpw4pe+GZyx4u36X7O+BU3OU3mXyObMOFBV0LCM
	 QKSshQ55p37vb3/tAVRkhJm1zHPQt9AY4s0sCR2MVVVsZsRC4wOH7j3UelX98LEjFt
	 xf2Y11hNp10w1iWJxoOwfe81OypkLs3UL62tkkCvnHpMuSF1/wlTqCxY0kw7UbqG2W
	 5t/Cvnr7jEbtzN/kPVYhtbinQLMa0K07GCfAtOfa3s86XBVAR4Ym3Ow/G5VcB07uzl
	 zpeToLiitURZQtsqi8uPp9iakrBrY12j7ckejuSudBokJfMj4E6OfI1xnzcwmdOPBy
	 iDCVGU3lBcnaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8040F40C86;
	Fri, 21 Aug 2026 13:13:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23BE01B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15C9460661
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGfH11_1bU7B for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Hznb93Uk
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81C4760662
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E0584A1A; Fri, 21 Aug 2026 10:51:52 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC1780117
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 10:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hznb93Uk"; 
 dkim-atps=neutral
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a10d6f455dso136048a12.1
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302310; x=1787907110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
 b=Hznb93Ukln5jd5uxdpUcAnruqPNx/Gis7Fom1WoIrMRt/lGXM6XXA4BvDx1OBu8dm6
 qnA/FppfpiMERAPFcAV1uJcwFCyQ1+osnKWK+mMpa+YvHIiHSe0WucFCu9cVN7Ndm+fL
 fwzMy8kF4YPNb2kAknzEkMgqs50pOwTpzx+R3fWYAVCEV+qUG/JICrotVhmgPL51zYoN
 W45Pyr/LJDoAWQQX78evaZpAkVBkWFgcNIKxsFcyWl5nCmgrhiXDMgd2vCxc1yz3lqxi
 RzRJTPgbzWw8+/tHnJABapH+dHPLEnJauGT+7HGDW45+D3kppJSkLKVVTqhic4PSSRzL
 L8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302310; x=1787907110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
 b=JRKF3mb8PKOLntn82X9Mshb0utupepqdMOUfZLPKyKu3KCgeGgsxIoC2WuzGY5MlJk
 bvszoXoHDWvCCO9G0oS6AOpmsdkKygYUB0qtle0I8EbuhEvCbUwrl2xzwt6I6pvNcV36
 mRypXcisE4h60danc8yU74yfp6S3rq23rqm/C5sqbbRAkT2UIgMskqQgY5z1QRkP6VvT
 1VxJUt351WijtLEvcEVMpbzQ8KRYLhse70gHG3DrKzc3u3feOV2xq4yNLxIJlnJkoSFn
 oJMDSqSiGkF7npf/8ismD0ZEnZu578GoDhRGkFphG+6md4EsyZ1j41VK33XTq5VmDHcK
 ZHtw==
X-Gm-Message-State: AFuF++nQCWc3qzrzxOgJ3MVLe92Pam4gNIRfIFWyn95WZiKm6EWu4/gH
 o/bMuxFtLnT8/tnTpxbCdhXvSqSCM4FTd2MixMj1iM/BhDdbNekSEtnbcED4oVuizHDP5LGDyue
 rXIx4
X-Gm-Gg: AR+sD10Ruo1w1rBYewsjCj1X9zMVR633H8Cj9jvrHoSvf9qwqWPv3qNy8QmXAAA1lC0
 QZVX7uQ7cT2sfR/Yrhu5NwbQZzAZXtwnj83B5eA1A54qasoUVsqHgN+3AdRsbz2kP1XrBYWTt+0
 fgWccFzWr14rgvNr5Ss1IKaWtK1TPwDW+AtdxCMkRxTyEKPGBo7naMXCemn8xRAxG35zkv2xZFb
 RGCY6NVYyE551pyvd3sHmq0J4ERwWJXn4x41BYZYOEGbONS8aDYB2bQyrMN45uOf39UNHccbt/m
 I8RTUBxa0kx9aLajiZ0BBuVx34O52o/MmLgxEIdLggOiH0EluxJoHVivFBcZITLZ3b+dMqBcIxk
 BgHmJRJbn98/T19WxM/xzePtxxPFx4GJ8dUKGCJg8ZnwctIsmEQzqc5Xma0MYruaEbPsnqY+cKS
 3m7BcQgJJrAQ9jHSH6h0WWEEiOcHQbcLe6JqxDp/l2Pvx2GK98Gxj7n/UBRNV4KHF9/uIfy3q0B
 E+Hlj/gQy5CtW325Ubt/j8n+oXHhz7dFAM=
X-Received: by 2002:a05:6402:2815:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-6a42f1a97b9mr2726177a12.2.1787302310071; 
 Fri, 21 Aug 2026 01:51:50 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1565fesm5666504a12.17.2026.08.21.01.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:49 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 42/87] usb: dwc3: import from kernel v5.17
Date: Fri, 21 Aug 2026 10:47:18 +0200
Message-ID: <20260821084829.2070426-43-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

