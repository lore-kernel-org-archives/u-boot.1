Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADB6C61DB6
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53EA580DCF;
	Mon, 24 Aug 2026 16:45:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BGAKaiGdS8qD; Mon, 24 Aug 2026 16:45:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589875;
	bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tbq+7vIgSM+EVB8rOpDfCzc2KIlYeLuUP0vf60NlUB8lFMU6sWdA0kEa15FfUN7qT
	 mKQ/b8dHvpJ96FaDzYlEngmku3usEu8689FsgNglS2nJ/cQvqRAmMxYROtgikBsPRC
	 w+1GQMZUyNTxHr9msqeJx8zOwVxotY4T3j/WsPTmzDRu6F6uqPsDR0nKI3+oSg+pVu
	 J8BaXqPOSWzx93/2SDtSMUoSYrw5RoMhlXVzR3fFXZ9H9yDsGlblcFANb+pn747s75
	 OfsvuishGrYFYMQMoEkvRZqxM2VPtEugSfxNixclf56LHyY9QLnF2NODtf8TPpPvcc
	 HmMe6q995sCtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D023080E13;
	Mon, 24 Aug 2026 16:44:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 093CB386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFB15605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:29:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPyE5M-Q5Y4F for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:29:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZhHwdpFR
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B98160626
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:29:39 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c20e4487bdaso29537166b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585378; x=1788190178;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
 b=ZhHwdpFR8swOIPjUulJa8A9BfOA18g9SkEPOL1KP0evIi0ZKhoFURZfEQQV4Ka+JEg
 bWRlN+sjVpUmZ8WnxFM2E8PW0xInshy7oPh4qADycld6VzUj4tG4lYs6uLv3/xRCMaPK
 qtq7oVaWc9qVysm1ChEhDOoehWz+rpCdIHTiLBhqoHKFoC5RFJcJghF3hD2CyDjduv/e
 9WHFUmPAD50+0CTh0wdrCtoE+0uRBJzHdl9y9evmXUWuBboCa1QiLMhIUr6no+9bOmQQ
 I4Cx/SmrhIcanPPQjYs3lkBz5ZFGn8A3y2c4tiUIjj7T2gnQNNKvbfM4lK7bhvyLAkCt
 4DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585378; x=1788190178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
 b=RVqHm/+xWjmTMGzXRD+9JtAlJpOBaS6NfnIb39QqzwAVW3FwGZVdiGHvUR8n6pwkTv
 nLmrNkXvo8XjtOpeqlNuBwRp1Fd2CBc2VW2KIo1OPdhUEFlFL+j7PjI0V7UFkMNXzxmy
 WnCRJj0RQA2p9yewOJCcfaOfe0JTyQtZ2NjKkmc5URHkpxNH6Ud68WfO9YEkZmWu5yM4
 I2IlGFoJRXQW/ELxKYuxPahZEZiblJyCL+Cmdqd1Zpb5ZZ6sPjG5hQr2u2900W2lo6Xm
 yPRAFGU3gKY+027fSTDvcV0frKK0UkMBJ+YJ/1gvSLzHue9mF2xNNeOUH1ckTwEbm7bN
 Gqwg==
X-Gm-Message-State: AFuF++n1fTnBB3B6fvKItKeLdxPNGk3G39SgCXjWUCh3zXkne9iRT2uc
 Gnit3A6hXbTSV9LV5MSnOybI+HaRf7BKmt3dnnrEyCqBexE7KOLz9taiqCX3FkAqc1g/m9uBwK7
 nbEvD
X-Gm-Gg: AR+sD12+M5o6imahyUEDl/YtOdPJIoQWVxe0ADizSbmi3xxTYdHt4udUweMzCAGmiKS
 6aefGqXVF8eJo2nHOm+pL622E7ksQyIZA1BCXl83kDHH+KHSJGTMonp+LZTgWdrwqrKdVMvMJL4
 A6zFXLz+KOWAfm/z8lxs0NS2PYXGmjAHO8J/Z6rBwwECOKn6nR/VcF02fyw1SdzSFdwExYm43dE
 ydCM/glzutVNp+j3njHuxL4zfCEEi3JO/TCzunKYFliKtsWe64AWWlkiUGOBH9FlOfBo0kM2PSd
 IIUdnWir7ocybcuuMXaJddQDCriJewGScN9v/wE37/JGONK/C1w701ZkCvOBRZAl8rUb1hY7tlA
 Kq6X5Ss99cmTVzyHgG8lvnaADbNQyWj2EKB9UVocs6LTiZ114bg5IEYZwDMKWE2BkNy22cS7M8a
 I3RygUftE8bteq/IrZApAb+fAMCGxq6Ndj4K/LeK86nxMIs+ILbFyfUz1SyEjDv4dAOmukOI1XD
 im2V2cR7qo7D3jBs+it8A==
X-Received: by 2002:a17:907:c19:b0:c21:6f8c:231f with SMTP id
 a640c23a62f3a-c246a2e942emr1714933566b.1.1787585377935; 
 Mon, 24 Aug 2026 08:29:37 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24962bbea6sm1228499066b.27.2026.08.24.08.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:29:36 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 24/63] usb: dwc3: import from kernel v4.20
Date: Mon, 24 Aug 2026 17:26:55 +0200
Message-ID: <20260824152734.159794-25-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.19 to v4.20.

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

List of commits: git log --oneline v4.19..v4.20
Commits imported:
38317f5c0f2f Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"
2fc6d4be35fb usb: dwc3: gadget: fix ISOC TRB type on unaligned transfers
ba3a51ac32eb usb: dwc3: gadget: Properly check last unaligned/zero chain TRB
08fd9a82fda8 usb: dwc3: core: Clean up ULPI device
6af19fd10595 usb: dwc3: Fix spelling of 'optimizations'
87dd96111b0b usb: dwc3: gadget: Check ENBLSLPM before sending ep command

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

