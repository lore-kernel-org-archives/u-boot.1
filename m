Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64273C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFFD84E62;
	Thu, 16 Jul 2026 18:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HmBsSvzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13FC84CE8; Thu, 16 Jul 2026 15:44:29 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4AB984C3F
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-698bf274b3fso1003358a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209467; x=1784814267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=icXYpWQTGV2VtFoQYVU3TnqVHFpTe2IBx1QVTlzBzeM=;
 b=HmBsSvzwijfmxgg52WIQigwyIiX8+l9SlWJFrcCqcBtCaJODeot8jGCFLLK73MWU5b
 +G5hqfa2iu3v799TFRIstkxx67UwW9L0tjbTil1a7Kdy/k1NdzdMiCrJ//b/v2I0Ht3e
 Fby0gfsxAaunHjsyQrAhe/gugWOwjN7gt6rwY23H5m2xix0PgY6o8BNSXGOtye9zW52j
 K4/MZkMQ95U/6mPbLM8AdptI6PB7Zw0yswHJCnYwv1vFMGX+oD9hovAUW0p18TvIUQh3
 Ua6Vw7qzZhLMpC58uvv4WUOyTm4aENY/lpYPPslQZZPckpD0MHLtVmsckROUPaRSNhaQ
 nw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209467; x=1784814267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=icXYpWQTGV2VtFoQYVU3TnqVHFpTe2IBx1QVTlzBzeM=;
 b=lkx9/gvMxQii5f5e1C4zlCA7t+DQA3aXXliucxlBa3X/zOAgN7vPBYskh0dgvW0Bc8
 RKclnlXX7SYEFmiPPXiV6qQ56uSDR/jUDS/V8KDDF0Ah4488+8KMi64M7vpr5aupYNov
 FBL7LDTMULNYgPBoYC+723aDsdVQ4LGyTUUoJFqpQMqOrUIescyXp25+ebj5eESrugzw
 HzmJ3IUU4t3k8qBLVoAD7aNJ/Q5DCKsFIPMdM9ysJrZYCFk1MrUT2LO0cKFG40Ky3Y+2
 FC8R4M7bi/DF7V5bDLqW0KPCl8sIrn18SwR6ZvvtpEN1xq3Xj6NPhc3l7v0OLdcXh+/H
 YtFA==
X-Gm-Message-State: AOJu0Yx4XCkwj3SASaj9ZyktCAnBwoBxVVfzj7/mYD8mAIf+a9q28TEB
 +234l6qjWUIlAcLguUDhhVxUMRHGj0c4M3ekBlx0Z1052qZ+64yVZ89x3tz6AC7y3xoz05JQgvv
 FQ6C7
X-Gm-Gg: AfdE7ckJtiyNuC2NBPjp9wq+VOp/QEkh2Z9lyJdWn/nJ1he/L8mBfVpjdh7PlOM+S4z
 KM5p7a5HcQE6quGFR/uISGDFzucIhkFDB5Fb4yfCcV3GcGC4sQY0hN1EdaKASrFD1WJ2fP/7Pez
 VQ3xVa/uv3G6Iv+Nst2X3BsXa7ZwujkY51VtOIJVKdb9kF3AFRzdzy+oUPfY806XuDce4vwhLkR
 cYKQ7xoZp3/bGA0tEebfbTwEIMgWsmdDdY1e6hb5l9KbsydS6QlyJb5Pl/ITrV8TKqCLYgR/+Iu
 aiwB+Uj3EgkmmHz7BThyGpzR+eLGV6nPYFN+wJJeV4wdViWtB3R9vFlm/CAmEsP1z5YoalI/Jqb
 f8UiJwkXbPoP41FaOJbkl4a6S+kSi2M9MFSlZz2MDHFa+Jb8oKg4aC1xpyNv0fsYTT6j9jvpohn
 Wk4iGlXDqvFtag1nymZtSegyOV+Vdrd5tciypftdzdEboKWKTH
X-Received: by 2002:a05:6402:2691:b0:698:9a31:3664 with SMTP id
 4fb4d7f45d1cf-69c5f1253c3mr6472087a12.7.1784209467100; 
 Thu, 16 Jul 2026 06:44:27 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69cd2877da7sm4771284a12.5.2026.07.16.06.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:26 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 52/75] usb: dwc3: import from kernel v6.8
Date: Thu, 16 Jul 2026 15:42:22 +0200
Message-ID: <20260716134305.614278-53-anders.roxell@linaro.org>
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

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
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

