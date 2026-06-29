Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4CDC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB30184AF2;
	Mon, 29 Jun 2026 10:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tJxlLO0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC45D84B02; Mon, 29 Jun 2026 10:47:41 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B818084AE7
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-39ae3c76ee6so15619921fa.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722859; x=1783327659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KecQOBmlDyXOHJRZ/5Dn3euk1MK+6HLNLJhgGlvQOs=;
 b=tJxlLO0nYZFlNBodZkvl62TI7pbQ6EmtFU7/qmXJM7BLwQ897Z0UtabmzP5d1Qaetg
 QJbV/VrztVy4xEeByo2hEROyTnbFchaiXMD23Bx7O7ljfbdVhpf5H1SGswH6PcY6BVFQ
 SKCQa5X/DxoujS0ZF40Y2HC1It+4W0UP5QqCnWszSW6di8/8TOqZxX/jznKk250ox1IA
 9nTpTodVH+bJzUstlA8dQiptYvTf9H1CwAtQZyxJeXGsjFpL6DP85LyklNWdhOTjFRdX
 YRP7gzWfA6rIk4We6krF2utHzVHLu1g15Z5JJln7LbNt87/+C+vJfilr1eXimO38L4hR
 qo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722859; x=1783327659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9KecQOBmlDyXOHJRZ/5Dn3euk1MK+6HLNLJhgGlvQOs=;
 b=GrB4erS3w58/ZEliO9s+DdhCzr0SB8j1y7f6gBVKCu79TU7y1/kd6a1LYu+DdV/qVt
 fKQwm3ZHxno2YIZX0KhA047WfSWAUcLvOJypYOQIGrfgD3r8ZBBTdyK0f7W/avcyg5sh
 5ae5o32+ZADLZ4pFEIMmMu8xSEf7+H9QwMuE6sLVsczJDmDqY+HDKanURPXyVK9p7w99
 Ufen70OLzE15uWyWZEU3chnLlm0RgqtKK9ZD+sfNzvGSGTRSw58JbyZ7MMKC9KvRny2N
 mZnKN2mfWABkayWnGH2+Oztz8Xy7VmlOCDEBM/k1UTF/ddBtvNl3A8JMFsD4KnDZh961
 dUdQ==
X-Gm-Message-State: AOJu0YzG4wNTcisElOCR18UTYmESNvI+6BqIpmwC/wmFJvmohEusxAo7
 DhOzpNFOOxP9+mlG/EjV1jwwNSH+ebl1hJlH4yfDSk75SsrGKCQF40JM4G1yD2y27RPQgKgzqDv
 O01W/6LU=
X-Gm-Gg: AfdE7cmOM51ake/UcxKla1mtaynSqafn8qIIN3p7FhPqr9KEI07IsAgQKpsJ4SvFnWg
 q3XHkm5Skg/pDycOBLyfals/3fqTQHgZwoq2BV7zYWrxT5+JjcI9oyGAlyhojELbJchJPJqhvjK
 IqX/7rvcLdGCGwqEcrDkdgf4bzfjl+kSM9s73fBOx4M0B8sA5WsqWAUG82rumgPGqUeKf7PyOVP
 vYWZL/1qRb38EPPuh9wcmE44D4D5nAQTNg4lGmIasKSYnEG4/fOCPOZfCT1NV70OlYuTzOTt9VR
 oe29jmdLCqkyTa6JbGaKYyrk7tLe1YNKu+jQoENdd4/1/Lu0/jVCE6qDGf+QeFJRSxpYVYDwWrp
 NAUZRFWrZR7WL5HWyfMe3ze572e0ZQUnxq5UVxX5ZoXBq3G/YsqP1KkpvEry8VlqRBcTOUoge0j
 vZ8DpwUdDFPpdty6FJWDojgpaffQgd4UoQRFPEdbi6+npR98ecrzVsFUytrZCJbiLj4pR1mxl/2
 BkPzAAVwZT0ZQmr3Vrj
X-Received: by 2002:a2e:a884:0:b0:396:7547:439e with SMTP id
 38308e7fff4ca-39acb57d3afmr34701291fa.7.1782722858848; 
 Mon, 29 Jun 2026 01:47:38 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:47:37 -0700 (PDT)
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
Subject: [PATCH v4 52/64] usb: dwc3: import from kernel v6.8
Date: Mon, 29 Jun 2026 10:44:28 +0200
Message-ID: <20260629084507.3254232-53-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.7 to v6.8.

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

List of commits: git log --oneline v6.7..v6.8
Commits imported:
b191a18cb5c4 usb: dwc3: gadget: Don't disconnect if not started
7d708c145b26 Revert "usb: dwc3: Support EBC feature of DWC_usb31"
61a348857e86 usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend
de4b5b28c87c usb: dwc3: pci: add support for the Intel Arrow Lake-H
817349b6d26a usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
aefdcd89d72b usb: dwc3: qcom: Rename hs_phy_irq to qusb2_phy_irq
3c7af52c7616 usb: dwc3: gadget: Queue PM runtime idle on disconnect event
68c26fe58182 usb: dwc3: set pm runtime active before resume common
398aa9a7e77c usb: dwc3: Support EBC feature of DWC_usb31
91736d0619eb usb: dwc3: core: set force_gen1 bit in USB31 devices if max speed is SS
e9d40b215e38 usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart
730e12fbec53 usb: dwc3: gadget: Handle EP0 request dequeuing properly
afe28cd686ae Revert "usb: dwc3: don't reset device side if dwc3 was configured as host-only"
7059fbebcb00 Revert "usb: dwc3: Soft reset phy on probe for host"
c084af69a8f4 usb: dwc3: imx8mp: Fix smatch warning
53b5ff83d893 usb: dwc3: xilinx: improve error handling for PM APIs
3396b3372e61 Merge 6.7-rc3 into usb-next

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.c   | 60 +++++++++++++--------------------------
 drivers/usb/dwc3/core.h   |  5 ++++
 drivers/usb/dwc3/ep0.c    |  5 +++-
 drivers/usb/dwc3/gadget.c | 30 ++++++++++++++++----
 4 files changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b101dbf8c5dc..3e55838c0001 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,48 +277,11 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode or current role is host, then we can return early.
+	 * host-only mode, then we can return early.
 	 */
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
-	/*
-	 * If the dr_mode is host and the dwc->current_dr_role is not the
-	 * corresponding DWC3_GCTL_PRTCAP_HOST, then the dwc3_core_init_mode
-	 * isn't executed yet. Ensure the phy is ready before the controller
-	 * updates the GCTL.PRTCAPDIR or other settings by soft-resetting
-	 * the phy.
-	 *
-	 * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings where n
-	 * is port index. If this is a multiport host, then we need to reset
-	 * all active ports.
-	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST) {
-		u32 usb3_port;
-		u32 usb2_port;
-
-		usb3_port = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-		usb3_port |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
-
-		usb2_port = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		usb2_port |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
-
-		/* Small delay for phy reset assertion */
-		usleep_range(1000, 2000);
-
-		usb3_port &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
-
-		usb2_port &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
-
-		/* Wait for clock synchronization */
-		msleep(50);
-		return 0;
-	}
-
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
 	reg &= ~DWC3_DCTL_RUN_STOP;
@@ -1367,6 +1330,18 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_config_threshold(dwc);
 
+	/*
+	 * Modify this for all supported Super Speed ports when
+	 * multiport support is added.
+	 */
+	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
+	    (DWC3_IP_IS(DWC31)) &&
+	    dwc->maximum_speed == USB_SPEED_SUPER) {
+		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
+		reg |= DWC3_LLUCTL_FORCE_GEN1;
+		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
+	}
+
 	return 0;
 
 err_power_off_phy:
@@ -2340,12 +2315,15 @@ static int dwc3_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+
 	ret = dwc3_resume_common(dwc, PMSG_RESUME);
-	if (ret)
+	if (ret) {
+		pm_runtime_set_suspended(dev);
 		return ret;
+	}
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	return 0;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index efe6caf4d0e8..e120611a5174 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -172,6 +172,8 @@
 #define DWC3_OEVTEN		0xcc0C
 #define DWC3_OSTS		0xcc10
 
+#define DWC3_LLUCTL		0xd024
+
 /* Bit fields */
 
 /* Global SoC Bus Configuration INCRx Register 0 */
@@ -657,6 +659,9 @@
 #define DWC3_OSTS_VBUSVLD		BIT(1)
 #define DWC3_OSTS_CONIDSTS		BIT(0)
 
+/* Force Gen1 speed on Gen2 link */
+#define DWC3_LLUCTL_FORCE_GEN1		BIT(10)
+
 /* Structures */
 
 struct dwc3_trb;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index b94243237293..6ae8a36f21cf 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -238,7 +238,10 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 		struct dwc3_request	*req;
 
 		req = next_request(&dep->pending_list);
-		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+		if (!dwc->connected)
+			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		else
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
 	}
 
 	dwc->eps[0]->trb_enqueue = 0;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 858fe4c299b7..28f49400f3e8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2103,7 +2103,17 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	list_for_each_entry(r, &dep->pending_list, list) {
 		if (r == req) {
-			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			/*
+			 * Explicitly check for EP0/1 as dequeue for those
+			 * EPs need to be handled differently.  Control EP
+			 * only deals with one USB req, and giveback will
+			 * occur during dwc3_ep0_stall_and_restart().  EP0
+			 * requests are never added to started_list.
+			 */
+			if (dep->number > 1)
+				dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			else
+				dwc3_ep0_reset_state(dwc);
 			goto out;
 		}
 	}
@@ -2640,6 +2650,11 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	int ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (!dwc->pullups_connected) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return 0;
+	}
+
 	dwc->connected = false;
 
 	/*
@@ -3973,6 +3988,13 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
 	dwc3_ep0_reset_state(dwc);
+
+	/*
+	 * Request PM idle to address condition where usage count is
+	 * already decremented to zero, but waiting for the disconnect
+	 * interrupt to set dwc->connected to FALSE.
+	 */
+	pm_request_idle(dwc->dev);
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
@@ -4686,15 +4708,13 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	unsigned long flags;
 	int ret;
 
-	if (!dwc->gadget_driver)
-		return 0;
-
 	ret = dwc3_gadget_soft_disconnect(dwc);
 	if (ret)
 		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc3_disconnect_gadget(dwc);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
-- 
2.43.0

