Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3884C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AAD84AF5;
	Mon, 29 Jun 2026 10:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sy+FBK/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B118984105; Mon, 29 Jun 2026 10:47:34 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A9D84AE6
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-39ae03059eeso19827761fa.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722852; x=1783327652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmQi57yzcMvZRA4mLIOGbFTT3ccxd4QWjbOkiFS+1e0=;
 b=Sy+FBK/FpkZHhKb+3UmK+uSX0gUfZUkfXmix0Sbhg6xZngU32wjXG2W1UCYDITwqLi
 yzUXtB0iBGUKmVga/9Fzdnq2q/yMAcFDlGUYobIMSrpvUD6wdsRiIrTGT1m3Q+TJ6XdR
 5V3l/qOjc1zfW+ZyVSfubKRJJHCRAO6b3/qvVMuHZ/69F0yE5IV/WOm3ZWKNWkpVQk46
 /0Sfbjm8Go3pDk/EoRrJtDYCMDM4V3FN4eJtcMZKFTR0FfDPx9FaYpJmrMahFXB3EuiC
 1JMANLKFxpfIqRZ10vHlstpcB2Wj/sp1kc7e8AcL9esS42JnAcqweiZMlBBiJE0ydoVn
 WNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722852; x=1783327652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QmQi57yzcMvZRA4mLIOGbFTT3ccxd4QWjbOkiFS+1e0=;
 b=WaoGWQJrgA7JTw5nNId45ZUjWLltFK9iWPGvcAxpqIPCaZmFGUxKI63eh9ejkSa2d4
 WQdFVYBVc7UvRN+yCPnzhhd5X72NFh27TcA4+ZL5rVWEyAaSeK+AYdWdNG+hjvm3bXlB
 ao5fwn/aMHmjg4SjV+LCeHsUKxWBCffRTch8GFZPqsYL0W1ZeyHCuZy/E9hloK5q6UYb
 VICcxPazbUKahGv/tdhpXNxvji5/N++T7vxE2Xqsf8g9Ch9Bo0ylcCiF8lDkCGcXlqcV
 lGEugyacsINANIz39WnVcxheMHtmIeZhC+BDIbOzLzU1Qj/92jkesT6OxAz+IPLt+s+7
 1h+Q==
X-Gm-Message-State: AOJu0Yz5idf12I4gobqlt6X1uDQNN9w+ZJfel4qv5k1Xn2ucHuPz01LG
 IRDYqo1q+17Oti2JDvUKUUiE4ETPJfVgOS8OctrpepiTUhqtGAfKK21bb8FTzXUUzz9pam4H2nQ
 sHfImbSU=
X-Gm-Gg: AfdE7cleOizQWTQlpJEklt6pbKWZkWmP6cwx5Mg2oSzhQguLEmv35548/dCzfQMpvmH
 jXzaNEKEeLEdGYUSIS1AeiSQQpeMoGSIeGQvh9BmISIWSgrDN5BKVS07EaBxFGNG/1iFyLXL0YV
 b+S0jkO5d2oyAofSTOAsmAdnhoX8fYdtKtsxrmsdd8dYbePrJj/0ovQF4hTlmAWzXq3YDrVeyYz
 gyfETh/eYnUVF1qXKdHiZIlIioHdgmsxQXut/tjwUKHqapGuE5tIqpUFY6wOx7Q/umtvjjwlWo8
 Gg9q91FThvev0p6z+e9CKANklDJd5ojL/ijMobdSHboBZ8lcgaQIVt1kZAluYuDgDN01VuyIr5N
 Jrcy+jDW8+R2/andniZalDjz0G10x7aSNKMSXp1Ws6Uw+V88uoS1dC8klOi7GGgN9ZdgfAiT797
 gaCzlORGkf8J4R8A21t7ISHsP5SDmdFgVC24iiQpwYJPk99Xj5Uo7i3QUePZ6aFAhEJRD10u8KA
 LKPRGh8X9qIdrS4Lsdf
X-Received: by 2002:a05:651c:12c1:b0:39a:c1dd:5399 with SMTP id
 38308e7fff4ca-39ac9d48f79mr37554651fa.7.1782722851559; 
 Mon, 29 Jun 2026 01:47:31 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:47:30 -0700 (PDT)
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
Subject: [PATCH v4 49/64] usb: dwc3: import from kernel v6.5
Date: Mon, 29 Jun 2026 10:44:25 +0200
Message-ID: <20260629084507.3254232-50-jens.wiklander@linaro.org>
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
56cbceab928d Merge tag 'usb-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
c0aabed9cabe usb: dwc3: gadget: Propagate core init errors to UDC during pullup
01052b91c980 usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()
60d5b71933c4 usb: dwc3: qcom: use dev_err_probe() where appropriate
4a944da70712 usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
8fd95da2cfb5 usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
097fb3ee710d usb: dwc3: qcom: Fix potential memory leak
b4a4be847184 USB: fix up merge of 6.4-rc4 into usb-next
7e530d32a365 Merge 6.4-rc4 into usb-next
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
Tested-by: Alexey Charkov <alchark@flipper.net>
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
2.43.0

