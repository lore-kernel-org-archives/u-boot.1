Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC26CC61CE3
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 959BE6078B;
	Mon, 24 Aug 2026 16:45:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-pIY0C3TAvE; Mon, 24 Aug 2026 16:45:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589907;
	bh=7eayOV4Qjmalhx5WjZQS6102iFUKhdrpzSiuN/cLuFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hgMDUISjxxnTUt1yUm224NoJtBAYn6AXeoVoKmGSrXZSCtDIqew6HIZ5V+cmd9ty7
	 Hm6gd1Wax8/a2qQDz7sIFtI5wcfSRsqf+8Qeu2Fan/ZBFH/oOMFCcX3To82xVC9Sxp
	 gN/qS1fvQJ5VrqildhE8TG5DYQXsKwR/E4nBfNDuDLQDTBHHbk3wCzwrCgWnKbdinZ
	 gppGt6b1mOvd+oyucWQeAphyI823q9bWEyrC/eThw2wRkPeGeDi++gIryG7DJVHXH7
	 L6dudI0ff/rYrlVYZPyYBqIoDP1Hy1OcDFQ6h7GDAQIXfa0usfWilyBW47tNKdxmYS
	 tXFyW2fnIwdBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7267C6075F;
	Mon, 24 Aug 2026 16:45:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5990D279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5715560627
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g7ET5MmIcSYB for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:31:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kJ95dwfV
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9B37605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:58 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c1676648c1eso25907766b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585517; x=1788190317;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7eayOV4Qjmalhx5WjZQS6102iFUKhdrpzSiuN/cLuFk=;
 b=kJ95dwfVidM7Zjy3XaysZrpeIrHt7RT68R2VPB4EbRWQYWD8FcDi7gXYgZ35lxlWTL
 jWjAEwg5GD8omZffYGT37DgnfhRuCUcjhlxuohR0A3Xm/xm6dw+H2l/OGfKuEo4aG/TW
 iP7Okb0q2I0FC9Ls1Yp2v6JUidMC1rtCBK78Sp6HxjUWBqeyZChqewhFXpw61eSfrvkM
 7uBHp+aLbpLqeaB0ZmQmXgnezZFQLnWJMyo3IiBCOWTvWcL8iqKYeISd5ohmPUl+dcE6
 51P8R0WbdkvdQjr4kiXA2zp7hsTyZny3cteqOLRXuEUUKPdE+i46qcIg633cBXpGZP0i
 XVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585517; x=1788190317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7eayOV4Qjmalhx5WjZQS6102iFUKhdrpzSiuN/cLuFk=;
 b=sZfKIdfXZ3D4m9qMfoI53aTGTLuOGu1L4YbCjBnDnAzHIL6tq3EcL9xzykJ6vOg/ed
 F3AD+JDE8QnKeeXpoxsT5pCkg0UGIAeBHK7mSSLPPqczHxfAo/nWSEbOP4LqcbVJgkhU
 WGKvvqSowW1oFIfdHxy/VSKz6pT97ZwMe2T654n0Slu9OICXKUdVxvu0KAdsBtXLjcP7
 mXKx5V7ZFNL/KIYyCLNUoyPeOG3zIKITNjEX0FevVM7ezKLZp/MaD0IIGLiQzkuTAJlD
 r9TSvt+cQ+aGj+C7+fCeqWee1YBADo+h1ThVEEggzzPk37VwrPrxL0tC19m6kv9GPV/a
 Cscw==
X-Gm-Message-State: AFuF++mjgV8rhkvNK2zH9Y09w9Gtck+PWYbhCYE3NgPgiRhuYQZsi93m
 aAq5BuU6dvS8S+VQ8mK/7jXv1/5NU3ItnscuEogeSu/agZJwQyX3cdQ2F+PYSAwPpwAdm/S1O05
 pZW6I
X-Gm-Gg: AR+sD11qcONlCAq0J+7NIiFcZSDRyOHnh/tvJ+Dco1FEckkmGUAGycsk56pZ7r0gAa8
 vnDD0iQ+/IbNPb2klxha0lhKDc/zlcqwzBST9VunIC2QA+nrs3mVljaixCDhvaHG+9lpnVYH2i+
 EYkgHjVojc+WFpm6IhXJFacJ8xv84ixji97YN4DpMy6otfgvPN0F+pYjxaJZz6FaS1OoWKqHN4T
 dDhxy1J6RQ4+oOdUfilruhUwfwAL6nmHqdYUgjX4x8/180d8Bfa5GsxbKdowYArjf+k/VOEGMa0
 bicRNGChpqJbmYhVkIBZwIwVNQPnoCLxLdjWNuJpv0ynqkHAUqqJsUuxBtzX/mVZzbEL/vmupQO
 Izv5UQT8t1mZF0mx9s3l9+DUdNEWDQAlyNFNZ2IqmHrfgaR54NBTNM3xErEXp2deArgiy77yBqb
 zJtRO/hMhxNUsgNI51Q/2IHBUQuwLlIy1mkdaUNQdFH5QrtJT6YE3xUp8pim/KZWJGqRMwhuFX/
 pWac8el53+AN7v2HNVEIA==
X-Received: by 2002:a17:907:97d1:b0:c12:732a:fe52 with SMTP id
 a640c23a62f3a-c246a6bd74emr1500162866b.4.1787585515093; 
 Mon, 24 Aug 2026 08:31:55 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b208sm1233541266b.10.2026.08.24.08.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:31:54 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 50/63] usb: dwc3: import from kernel v6.5
Date: Mon, 24 Aug 2026 17:27:21 +0200
Message-ID: <20260824152734.159794-51-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.4 to v6.5.

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

List of commits: git log --oneline v6.4..v6.5
Commits imported:
3ddaa6a27457 usb: dwc3: Properly handle processing of pending events
734ae15ab95a Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"
e835c0a4e23c usb: dwc3: don't reset device side if dwc3 was configured as host-only
c0aabed9cabe usb: dwc3: gadget: Propagate core init errors to UDC during pullup
b4a4be847184 USB: fix up merge of 6.4-rc4 into usb-next
890258e22117 usb: dwc3-am62: Convert to platform remove callback returning void
0176568702a5 usb: core: Convert to platform remove callback returning void
813f44d57e19 usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens
2f28c3c9c347 usb: dwc3: Add error logs for unknown endpoint events
ec5eb43813a4 usb: dwc3: core: add support for realtek SoCs custom's global register start address

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

