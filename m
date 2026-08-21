Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0A5C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E47D460F9D;
	Fri, 21 Aug 2026 13:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KrRCY3he4uSy; Fri, 21 Aug 2026 13:16:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318046;
	bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=stQP8rH+8iiQiZOaylYtp4GRJXeivlwHRgZSu/hJQhf0Y+r3JuQvRbsBancQ+ldo+
	 zsKOiOGZezEa9wMIca4bESwKEwp27UER4hRGtpGsEZXQTfun+H+Ohs7X//mliaU6bh
	 hwyAKGzCPVZjZ8NAvYIOD6cMthwNSIh9anuNBz50bnJ1trbktLte1iq5K4zmIgme0D
	 KK4yX+4Yv5ABaK3S7vAygNUA/E4qpWyE3OF3zRlpyyZTQyttTOGHgm4nBz02caMWrS
	 WqzTEyhyP/bTMkN9m1qndsH1xCMnLg3uX/pffb6ZAesL4sXcFHb2FzBgm1Bud/Lsz/
	 wpv4VIDrxsItw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BD5860E80;
	Fri, 21 Aug 2026 13:14:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 71592263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57CC840841
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pZ8pr6Q4sOJ for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=smISfb86
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CCF1407E5
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:07 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15f025146dso6949766b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302325; x=1787907125;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
 b=smISfb862nyjRivDRiJvbSMO2TsmNT/5o4+XIe9D5UazHgf2pivuHozUA80XB+O9V2
 iOMevskJb8vgefg8y+YaB+OC29qmHx/iI2jVJayMOqX6OQuxhMt3JQUHBml1f9LBOOa0
 0kizCE+T4acmuR669BThZOMw+S/LRaSNpG/GwVNp7/KRE81/DWc2K5vPZXaBF5NaMImM
 T+Q8XqpWmqCMrlObLbMmZUiFe1rnQHfzg5IkxiU3A0Kh4wDnVQgP1HaJYZJcNpLEDfPG
 g1Q7M3wQv/9V3Eg0zeojCZJEJfLqSlvfos4RW+ZHSipT0daR1GvlrWiMF3d5nK4JuQtw
 iZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302325; x=1787907125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
 b=UShInppFMFA+yVXtplWPAOQEb0wxJ1Ok8pnSQuYIfkRNFx3Py/QKoqzA91GNQlnhML
 aRvxk9gHlsE+LjJFoRfdfB3mG6S6eCLku2dF155XkOa9p5c7Mq6iQ2l9L6UQRFlm2lke
 gtCpv8B64Wm6Z4MsCOA6a1See3Hx6qFwbzAfl1ZD/gIKH26iKtjKmECQSKGLLbtGjxJh
 kOFnOcKHVM68XmG25xTFpF3PHzFW5FlXehOArYD3rtbR4ASoQB4WyX9m8ULhsnJ26JJD
 +/kRCLXmWwJCLY38NPUxLIsf0zZvcYZF2+riGLACs5H8IUETxMtM26ICSgqjnNJsERgg
 w9Kg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7icG2knGsWdlepkciGMaAXk2otXztc9S3JdL/b5dZFFNoOcjL/6aKSkA9zNcI5J930Pm1WfI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lT1TeGIF/UCx6diUOaTm3+T59q/rzf2EABglJ4SAevv8tbhg1R
 OSBX4BaAkoGLFgAG0GLmxsJ2waO4eZXcNndRqTwXtg1JKMvU/AOB1NouxBSihrORNBz4qTbtPMM
 1t5l9
X-Gm-Gg: AR+sD10M06rLoD9PBm0mLVSCdZfa+ho86ebOWAjZHUVfM8aryCrQqgb8HHX1nVIXNLw
 rs4MBuKvucJpbWXAXUQ8BOjmwcCC7OxxGLvDhd77o46JkgHQyWrz8XHMUYbaIUGCCvLHeeGb/99
 W3Vgy/JZVPSnIWluRNU3mqBX+I8RSwAvh4w0KrKs8OGqQ35/mY5QnOUQu+rpLmDwNXUUWJ10lD3
 VkGzuzmtC3cuggAjK5w6x6jV09s0bENSm0OOSpePWPlzLP0nStckMIhlURKBJVMKNJ49dm9rsWA
 RIAo4DpIoHQoQEjPoq1EUthvf1ZiiSSNKEgNS0hk/RKX5Qk7vx/sP46y1v2PCaageId+Q8SuMvx
 wR11OTVrqw+EVEQmJWXgYETgbwnjqD070dtICqhbOItgPvvo/eGWSLU+Ez2bbRpnDFrWszVhxAA
 FrJrAyIY1bXQ7DZf7cZXwuwyqp8pt1r7idjLCvY0nwY4xWAkux51vifgTCXxr1IfSp4392pLcZZ
 d3I99Wl+o58BS4NP1ghls5T
X-Received: by 2002:a17:907:d0c:b0:c20:38e2:b355 with SMTP id
 a640c23a62f3a-c246a6c97c1mr232390366b.4.1787302325233; 
 Fri, 21 Aug 2026 01:52:05 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c245921e4f5sm377054066b.55.2026.08.21.01.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:04 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 53/87] usb: dwc3: import from kernel v6.8
Date: Fri, 21 Aug 2026 10:47:29 +0200
Message-ID: <20260821084829.2070426-54-anders.roxell@linaro.org>
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

