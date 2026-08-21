Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC72C5DF94
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35C1E60DF9;
	Fri, 21 Aug 2026 13:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YH0Pkyu09Zwi; Fri, 21 Aug 2026 13:14:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317968;
	bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xTLNptomiD9ZA47lqexV46awj/OPlut7SRDxAkRtLgdQ9nVL5SEo/JxNeIq6+WCk3
	 AkuIaFKf7ylqDHIbQjgYgIrOzLSFcWPoK2v+OgjdferMn9Xpp5ZTVlCd1zDlw39UjG
	 u61gJNEQAoSXDgiMAA1PQYT2BbAzP1Rn1fKllU+sUz64BbuHERmy/K6yrRyCaxw83e
	 95kM+PSxismCrFbtQt6iQr3EhU9gThO6YhQBkcsT8hMHoktmvYL7yfx+5j7XMCssw6
	 l5ovB7sAvXHoqKdr5Vj09RgqEY8LR0ZH7hP7N64C55WhEeBVNlJTNsoSQgRALpFoZN
	 yK4gtmTKy+TDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7075760B30;
	Fri, 21 Aug 2026 13:12:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 70D5D263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62CE780FF9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpR_E3Kle5ep for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=hhM1PBP/
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57D59810A3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:25 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15fc4707f5so5936366b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302284; x=1787907084;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
 b=hhM1PBP/q+76CUPptFJDHS/RlVF7z3nT6eooCsiz/0EGWuTQeaeV4Puhhd79mO5Aco
 6XF6QxxfZqakWJVyESbb6G7O3TzNEPmCqonHESli64wgaz1dRWE7LXZhubocYMB7a9mq
 TZKZbRAPwC8DQZS5uQIbo2zbUidAOspaAqc4NXQVUOiutsHHgSqCvKyr9IaWX60lmYYb
 fIRwbYdKkWbDc/LqerlglfX0H9XNWnVuSxGm4f/Yv1UMyleerDmXtj8gDa/fMRixA+jP
 Qx+D+m+soMFeEkYnPA95ebr7xTMbKyjoEJB73gPkVWVrxgjwfa0TWFMJ8BbYEIjjpBFG
 2Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302284; x=1787907084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
 b=B/sf/FSt3zAOrxXeuvqDGOFYGiCfgGwobR/C1yNhADyX6QJXDrejmcdFZn/LjV3vEg
 Gau/DGeUjPhkZMmUu1vpv82L+fpL58M110D8Ko2Jr0fLRBavWPJWLFU+ad8ZkooaAIOZ
 pazo9lqzJn7Yc3Fp1TtN3aD9Vxhwoouz3PeQT+Vy6x69oXxxpFIN3k3MCu+t0IUm7aSL
 qmPfYClp8wJZZtN+MCKIl1yfPHajRAN9zkd42fZST6OUyZLIxTyN/OLWvjUVt0AhrWG1
 ylscORJs0y/5CnhObndrvhw6LuG9wwISp704ewY5vKHmscUzeU2qLxIdxRAFXWl2illF
 wuNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrzid2khrlXfdd0wSzo7c6aGClN4Q3j2SPcOaGQ08v8Mmu5TXhlx6A+xggL0KV/V4qnFl9UPSc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l0rt1nEDhk5BghS4IDpyuO3UNPDhNCN/gHN5j5IHm2FAtJm+/R
 Qa105Gl0K9b0oeABjQQWzmoUChtVN3djp0Wr3+8b1z6mrsdfXbmYEhtmHHdrRC0Grvc=
X-Gm-Gg: AR+sD11dIB6yFkEeGjW7rtzU82gDHUZ/HfGcl2zKfRM2QvQl7JFLOV3JPRjlgJwGtvj
 rA9AGI3f3r/fiZC3kyRlM7df3odlzRYkSFEiEdHXRExb2eMAUF3tAsk3Dc2Kh6iq1axQWPdiIkC
 oDyQcFC3P531+WeB28KPy2x5DWXuXVuVKoDmwUUNqc3elFYJXimxmLaHV5MPC0Mqj9ZBkomIQEG
 XGjgp8gF+Hy60U+XGvwpSiOvUKh5nbeL4mVSkN3Kaon/Pkh/Fcb8G0+gGz2Zf3l9GHjLGdGzbKq
 ZlzR17VNjO47p6WHiKH6JnpmMEhjAttY0wdPfY8P1Hp9QR7g+pQ70c5otnsh/CJKpRuBQ4JFHvy
 QPaejFiMq8q8N6zKcc4taT0SWWJM7KykwycluNC5Ut01S79IvlNQ9loXjvjEHW0hG1/OYdQHLBh
 lTm92lIBhFtq6QE9tRYXkzkOkrsKdITjegTZcZwMoep5SDxkfNcCcafxPCfrNwvxZh731ghl47K
 jY137BJZQ5U6aln1VZSp22qEQz467e2AdQ=
X-Received: by 2002:a17:907:6d20:b0:c15:9f0c:8d31 with SMTP id
 a640c23a62f3a-c246a5f67f3mr252708466b.2.1787302283896; 
 Fri, 21 Aug 2026 01:51:23 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459223816sm401840966b.57.2026.08.21.01.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:23 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 24/87] usb: dwc3: import from kernel v4.20
Date: Fri, 21 Aug 2026 10:47:00 +0200
Message-ID: <20260821084829.2070426-25-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

