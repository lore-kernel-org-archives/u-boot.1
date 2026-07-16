Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650D1C44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE10C84E54;
	Thu, 16 Jul 2026 18:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="djFXC+MQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8FCB84D02; Thu, 16 Jul 2026 15:44:26 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B1884C3F
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15de30790bso60038466b.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209464; x=1784814264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KxcVxRWVcKw9Ip0MibMQ/hhHCKxEDoGQ8chC7Qa/eeU=;
 b=djFXC+MQvT8OpUdeaJ5vClLggB0zNM/gLP9JSPfP2ss8ayX4/ggrZ/dt+7LRdqyynX
 SeUsKjIJJnllNyRA2K6pFByLmbl0nRR3Rb4Uobd7ff8YD4m8el/Ela4Yo1hi1hZ22DHC
 jLFU1FoICO3qONVfezqfSiW5E/DFdhcqjur6U2wf9VQ3rSs46qASZcBIGsZaudIzLB5w
 +jHZg64jJy28vJaJ30dAWbkAG8PyyQmULnxj9NwPQsn9Xm1REk9x9KSAyN/3e5zfnEzX
 ZJDtbGY3xI895jrjSsrrtqz3Ov/3PzFPk5g46l2u3p8/P8LI8CIorLWWbiA0gUUFU273
 8w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209464; x=1784814264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KxcVxRWVcKw9Ip0MibMQ/hhHCKxEDoGQ8chC7Qa/eeU=;
 b=QYFunX/zpdxKiOHEweViA5GKDQ1CqLlW0ypFD1/bW8gu2nMaARcxDu6ksUlJnauJIT
 9DeNfAWQnziMRBG7vjyMa4Tilv77GApVS5Vfv+CXzBgXQIfzbjO2i0izFi4TNuGkIO/g
 oDC4LFjUVsXySpgmKZVvBGNWo1O+7JGwploFvH7wdTEmDVpAKNSKYahSKyv8GS115VuU
 5JiFJ1JPTeKWMcIwB+fUSG7JCKS3IKe5I67hJ1IrAHVQJ9CXwPav+AkoWK5ABr473NUn
 d+15nc4h1HqeKjExwFyhQv1St5NGf1RevGKJbErpF7BpKSId1ObnBNAWZHu445lFr1HU
 HyDA==
X-Gm-Message-State: AOJu0YyiiH07jwO82d9Tz8FCenirGVcW4brUvQrxeROIJV9sC0vQipks
 4xK5AJaOC9LLA6Kny5imUCLN0xYgMEaLixcWdUIzP3WeZSqqiLBbw+7G+kOYXHy/6hRG3vOoJ4y
 HBddZ
X-Gm-Gg: AfdE7cmag/WT3Yp4xXrIThAH1QgLWkxEudVaSzA3OcDxgHjOWd0Ze5FcGrbaJFUHeXJ
 /rKGjR/ypEWqZ0KppctGElcVozpiW5unQC1ZlnhTq9YCSLJAO95ZEI0Zpmk6BQdGsLGSbkk1mKS
 VYZBWF8xvmsNSMjHuZ1XuDWYT+zVKWDBUnizQ0KNJkzvItv9dL8wwkZjcJEi/VgUDyVoIbbT1Bc
 F4hGB1alfgqJRdcJAL7ZpsOMlFBpluRaIr5VUIPcsokwGGtafn9gvXp86Cd0ZMQehHnSddLnu7N
 ZuyKxgxALAETGYPs23gBPWgR+jxxD31zrttddRx9MEXplHtnab3kKnyXuhtn9muOfRCRIqAQy8Q
 vthH+31rqqL/jI5hGA3zXAc6P4rlSuxdfITRKtaP/eQFw6mo6R1p5xioT1c0DevkbqJkQRFE3Qr
 jfJYOQDjt+qx4886RXK7+T4vqUJTjkNAoiU1UOjA==
X-Received: by 2002:a17:906:6a28:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c161de22dbemr669245766b.0.1784209462379; 
 Thu, 16 Jul 2026 06:44:22 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e6ecsm211794166b.44.2026.07.16.06.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:21 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 49/75] usb: dwc3: import from kernel v6.5
Date: Thu, 16 Jul 2026 15:42:19 +0200
Message-ID: <20260716134305.614278-50-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.4 to v6.5.

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

List of commits: git log --oneline v6.4..v6.5
Commits imported:
3ddaa6a27457 usb: dwc3: Properly handle processing of pending events
b32b8f2b9542 usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy
734ae15ab95a Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"
e835c0a4e23c usb: dwc3: don't reset device side if dwc3 was configured as host-only
c0aabed9cabe usb: dwc3: gadget: Propagate core init errors to UDC during pullup
01052b91c980 usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()
60d5b71933c4 usb: dwc3: qcom: use dev_err_probe() where appropriate
4a944da70712 usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
8fd95da2cfb5 usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
097fb3ee710d usb: dwc3: qcom: Fix potential memory leak
b4a4be847184 USB: fix up merge of 6.4-rc4 into usb-next
5b3eb973bf38 usb: dwc3-xilinx: Convert to platform remove callback returning void
2f6453761e7c usb: dwc3-st: Convert to platform remove callback returning void
d662268dcca8 usb: dwc3-qcom: Convert to platform remove callback returning void
abe04efc13ed usb: dwc3-omap: Convert to platform remove callback returning void
86a2b452179b usb: dwc3-of-simple: Convert to platform remove callback returning void
3ffea6e0f34c usb: dwc3-meson-g12a: Convert to platform remove callback returning void
039e3dede538 usb: dwc3-keystone: Convert to platform remove callback returning void
3791a3e6f455 usb: dwc3-imx8mp: Convert to platform remove callback returning void
8257d5f548d6 usb: dwc3-exynos: Convert to platform remove callback returning void
890258e22117 usb: dwc3-am62: Convert to platform remove callback returning void
0176568702a5 usb: core: Convert to platform remove callback returning void
6bae03b0484b usb: dwc3-meson-g12a: support OTG switch for all IP versions
813f44d57e19 usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens
2f28c3c9c347 usb: dwc3: Add error logs for unknown endpoint events
ec5eb43813a4 usb: dwc3: core: add support for realtek SoCs custom's global register start address

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c      | 37 +++++++++++++++---------------------
 drivers/usb/dwc3/core.h      |  5 ++---
 drivers/usb/dwc3/dwc3-am62.c |  5 ++---
 drivers/usb/dwc3/ep0.c       |  3 +++
 drivers/usb/dwc3/gadget.c    | 22 ++++++++++++++++++---
 5 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d68958e151a7..9c6bf054f15d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,9 +277,9 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode, then we can return early.
+	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -1209,22 +1209,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
-	if (dwc->dr_mode == USB_DR_MODE_HOST ||
-	    dwc->dr_mode == USB_DR_MODE_OTG) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
-
-		/*
-		 * Enable Auto retry Feature to make the controller operating in
-		 * Host mode on seeing transaction errors(CRC errors or internal
-		 * overrun scenerios) on IN transfers to reply to the device
-		 * with a non-terminating retry ACK (i.e, an ACK transcation
-		 * packet with Retry=1 & Nump != 0)
-		 */
-		reg |= DWC3_GUCTL_HSTINAUTORETRY;
-
-		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-	}
-
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
@@ -1800,6 +1784,17 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc_res = *res;
 	dwc_res.start += DWC3_GLOBALS_REGS_START;
 
+	if (dev->of_node) {
+		struct device_node *parent = of_get_parent(dev->of_node);
+
+		if (of_device_is_compatible(parent, "realtek,rtd-dwc3")) {
+			dwc_res.start -= DWC3_GLOBALS_REGS_START;
+			dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
+		}
+
+		of_node_put(parent);
+	}
+
 	regs = devm_ioremap_resource(dev, &dwc_res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
@@ -1913,7 +1908,7 @@ err_put_psy:
 	return ret;
 }
 
-static int dwc3_remove(struct platform_device *pdev)
+static void dwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
 
@@ -1940,8 +1935,6 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -2252,7 +2245,7 @@ MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
 
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
-	.remove		= dwc3_remove,
+	.remove_new	= dwc3_remove,
 	.driver		= {
 		.name	= "dwc3",
 		.of_match_table	= of_match_ptr(of_dwc3_match),
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1f043c31a096..a69ac67d89fe 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -84,6 +84,8 @@
 #define DWC3_OTG_REGS_START		0xcc00
 #define DWC3_OTG_REGS_END		0xccff
 
+#define DWC3_RTK_RTD_GLOBALS_REGS_START	0x8100
+
 /* Global Registers */
 #define DWC3_GSBUSCFG0		0xc100
 #define DWC3_GSBUSCFG1		0xc104
@@ -254,9 +256,6 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
-/* Global User Control Register */
-#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
-
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index cda9458c809b..1755f2f848c5 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -275,7 +275,7 @@ static int dwc3_ti_remove_core(struct device *dev, void *c)
 	return 0;
 }
 
-static int dwc3_ti_remove(struct platform_device *pdev)
+static void dwc3_ti_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dwc3_data *data = platform_get_drvdata(pdev);
@@ -294,7 +294,6 @@ static int dwc3_ti_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 
 	platform_set_drvdata(pdev, NULL);
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -362,7 +361,7 @@ MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
 
 static struct platform_driver dwc3_ti_driver = {
 	.probe		= dwc3_ti_probe,
-	.remove		= dwc3_ti_remove,
+	.remove_new	= dwc3_ti_remove,
 	.driver		= {
 		.name	= "dwc3-am62",
 		.pm	= DEV_PM_OPS,
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 953b752a5052..b94243237293 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1207,5 +1207,8 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
 			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 		}
 		break;
+	default:
+		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
+		break;
 	}
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b78599dd705c..858fe4c299b7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2703,13 +2703,17 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 
 static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
 {
+	int ret;
+
 	/*
 	 * In the Synopsys DWC_usb31 1.90a programming guide section
 	 * 4.1.9, it specifies that for a reconnect after a
 	 * device-initiated disconnect requires a core soft reset
 	 * (DCTL.CSftRst) before enabling the run/stop bit.
 	 */
-	dwc3_core_soft_reset(dwc);
+	ret = dwc3_core_soft_reset(dwc);
+	if (ret)
+		return ret;
 
 	dwc3_event_buffers_setup(dwc);
 	__dwc3_gadget_start(dwc);
@@ -2744,7 +2748,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	ret = pm_runtime_get_sync(dwc->dev);
 	if (!ret || ret < 0) {
 		pm_runtime_put(dwc->dev);
-		return 0;
+		if (ret < 0)
+			pm_runtime_set_suspended(dwc->dev);
+		return ret;
 	}
 
 	if (dwc->pullups_connected == is_on) {
@@ -3809,6 +3815,9 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
+	default:
+		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
+		break;
 	}
 }
 
@@ -4446,9 +4455,14 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	u32 count;
 
 	if (pm_runtime_suspended(dwc->dev)) {
+		dwc->pending_events = true;
+		/*
+		 * Trigger runtime resume. The get() function will be balanced
+		 * after processing the pending events in dwc3_process_pending
+		 * events().
+		 */
 		pm_runtime_get(dwc->dev);
 		disable_irq_nosync(dwc->irq_gadget);
-		dwc->pending_events = true;
 		return IRQ_HANDLED;
 	}
 
@@ -4709,6 +4723,8 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
 {
 	if (dwc->pending_events) {
 		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		pm_runtime_put(dwc->dev);
 		dwc->pending_events = false;
 		enable_irq(dwc->irq_gadget);
 	}
-- 
2.53.0

