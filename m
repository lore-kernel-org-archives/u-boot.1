Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E4AC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42A046075B;
	Mon, 24 Aug 2026 16:45:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O4uP_HtO8W2n; Mon, 24 Aug 2026 16:45:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589912;
	bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TpSTQ9SCdllnor7fsoP/eCpYGLnZRBIOuV+rpk3FLdRgaMwEGeuxAxYfgtcoykFrz
	 ewKGXkFDygz02wEkSuuo1+z/UGIpfjGBQxdbF7KxpTQSy1C8R+WyU3zmURLmnejuy5
	 scviMSB4oVOzIj3IVox+j62q6iE83udPQlyIh+qzJRXv1XsrtaA0IphQXuImMyr7IS
	 ZZpl5xXmU8JucQ3sEsNWbAuebutUChfXXfmuJI1KL8AjxSC4dCwVhU0tXWJMDnpNoy
	 JivQVYqtOe0rmgsaX0nYmeW0YYGjkrj0w3FQHqnQpgE5kmFA285vc/HcUx11X7EUpy
	 MJL2icnKVmEWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E38D1606F6;
	Mon, 24 Aug 2026 16:45:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 310E82FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17C8C808A9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7CdoOX1FkF2 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:32:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=BWna9IDA
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D53AB808C1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:01 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1676648c1eso25908266b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585520; x=1788190320;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
 b=BWna9IDAJ23yWE+DBZ8XqzfTCOM2i9jad40cSUBUo5t2lvWMSCY18IdqSmtd6NaFGz
 ubHCmL2ovMAgPiENadhZLKqG6L+8D+ZpSp+pKWDTSsPC7QOnRl0VzN9FYSvhgaZ5tQD3
 W1cCRX0syS4kKGrGgqxOYvhs4uirWGBpRiTUwAP0fdLXY4rc60iNARBCgcrI7691fHr9
 JyqIoHa1V5WfaQSusM0b3da+qOFkwYJSBOxJWdfyfj9PjlriMcQvEb4ya4o91l9QcXVP
 7MjnvM50AXWJGmvaLIb0Gxwvb+x/WOtWuQUaDrZF6F317wdTfPk4icnlgIf2XXm7LGKj
 9sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585520; x=1788190320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
 b=lX6EqrCLsNIbuLgJ7s73sXEGv2jA5cwoOucgjIqIHtsy5oJfhpB1IcBZdakTw+jsi0
 11wuVh5WSPH/259zUlcLp+5NMuNyxH/eIWqwKNQvPKiFNfYa+l431eePQfz0QaquEbmt
 edG+k8DYK/7J7WxMidVXyMxfTH9/ieY1XILj0pF+1jM56YoHRZ+1x29JfsZE2wHvhi/V
 MMnFP5iD/+hU9aZeqRCyCOm0sZTpa28BtQ15IdtQ0XuY1Yztr5WNYMR1KbR/GOoC4yZk
 cHDsjuFw25ZUNNqgk9czXGeckPpLbgZAOIPgt46uau02wW9eC3yBG3g5jD7gWWJC1bB/
 kgnA==
X-Gm-Message-State: AFuF++k6rK0CEhVUPHE3sYV+YZBN1gMNBbIOtJRzf4xt+EZ84r6MMUy8
 xFmcuQ4qKsrOrn3G5PEpNg+FOaMguO5baWXfl3v8JdUtexYYTctGgB4V5Lgt1LLqi3CVmLB/RBn
 eDKBQ
X-Gm-Gg: AR+sD11ReuVMTDLEhaGDyl+rDZjD33IFfQ2g4JYj4fzZVXkESnzNcxU3DM3c+mwI3QV
 3QtRX+OzwtaRIwTXJ/oXKjVYFELVx6cIp5DrT73YIJyrFX8VVUkoPSY6vvq8jLmmld4oJqhQZcw
 7e354XGOm4ja5LiI6ikH4dCVTbjeldpzGkVPsNSFuP891VvFVrEvjLb3pVotNuuDwawhBa38PsU
 Jx+w/0fpI9RKIWgjWCYj7tvtun+771+qEJucOTvh6nKSXNRxzMOCKUSoZR2kemXBQ1kz8BtIiqY
 BG2yDobIvSMBfTtUKvqSvPQv0X/yjAO8E/aYWaiNDv4h2ADTvnVmG9u3648FOuVqBmIwqtnQwjr
 pR6rBW1zPagw/4CH9/6Fy0ieX9hYIuehCyCruJxfm3ARL2q0mtLaFc3IHScCdG1lhNCTj/7H+ZR
 zWz8T/BRiD141PkgEf2DqJQGHU42IQZDQokCg8n5QT4TnBThwIJ/E3H4yAHFFDGQZotQZNT2OLW
 w9mGQIGTHweFK8dYSOLgw==
X-Received: by 2002:a17:906:6a25:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c246a396b8amr1737077266b.1.1787585519461; 
 Mon, 24 Aug 2026 08:31:59 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b208sm1233541266b.10.2026.08.24.08.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:31:58 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 53/63] usb: dwc3: import from kernel v6.8
Date: Mon, 24 Aug 2026 17:27:24 +0200
Message-ID: <20260824152734.159794-54-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.7 to v6.8.

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

List of commits: git log --oneline v6.7..v6.8
Commits imported:
b191a18cb5c4 usb: dwc3: gadget: Don't disconnect if not started
7d708c145b26 Revert "usb: dwc3: Support EBC feature of DWC_usb31"
61a348857e86 usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend
3c7af52c7616 usb: dwc3: gadget: Queue PM runtime idle on disconnect event
68c26fe58182 usb: dwc3: set pm runtime active before resume common
398aa9a7e77c usb: dwc3: Support EBC feature of DWC_usb31
91736d0619eb usb: dwc3: core: set force_gen1 bit in USB31 devices if max speed is SS
e9d40b215e38 usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart
730e12fbec53 usb: dwc3: gadget: Handle EP0 request dequeuing properly
afe28cd686ae Revert "usb: dwc3: don't reset device side if dwc3 was configured as host-only"
7059fbebcb00 Revert "usb: dwc3: Soft reset phy on probe for host"

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
2.53.0

