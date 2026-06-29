Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7A6C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5746684975;
	Mon, 29 Jun 2026 10:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XFiZCW9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C6A84AA1; Mon, 29 Jun 2026 10:47:06 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1830884975
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-39ae75f19e0so15838561fa.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722822; x=1783327622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+keeFXBB33qeHZ67oQ4oCT74NJadGNVDE0ta1ACdVc=;
 b=XFiZCW9OXbZNUPmhQfxjdwBY9uJhCYbz4CVsCFwxUrvU4DgylgmEkhdyl9adAjX5sS
 ssFAwQbpaaaq0OPXV4mVxMDty/Gv3wFrLx0d2BSMg9Fzxaf3/xXs2N+5O7JtAHrHgO17
 4g5u3ZQBUHgqwGO4brjIWoYWG9koCtc3YyCPTu5QXu3mIsuKYPmDwNEqo7O3nTWRJoqG
 2mGn9rWz6afL3hmErqle6Wk3IKu9ux3OvQBvv1tkP2W+WN1FzSVbtLML7oTz1DEQSGNd
 YMVLig+iYD+WMDQO/Bd4TxM6akCVRAxLicO8InOgjjel3s2CL7mxnq3ZlXM6whEoZh7x
 j31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722822; x=1783327622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z+keeFXBB33qeHZ67oQ4oCT74NJadGNVDE0ta1ACdVc=;
 b=VM46JYKy+cMSjGiNxPfA9Y6EZG7AJSpHeehnEBotUdD6GopDXmyiDsSFPwDn6wNxsM
 dK5gtChfg6ZLKjbE5bnD9wEkpUbMjC5TBIydP5s5gBDsj5OZSrvb0F3Wa8G34zX0ekic
 4in1lEMaJh3A7BofsCxY3qt8KbSw48xw1GQdSMxaGI3gCVkZDbII7gnYRXcpE/ibMbrE
 g99h8Vs19Q42Gg4hh5HGsusglOhXjgUi7sSvklFBI0e6OngBcg6jNZwSxHEq7JpIYW1r
 5Hv3R6MesjQwQoqWM+caKaACp9Dj8OmJw595hQJMDGfM85zxsrBJQxarZfGgyB2qB6rS
 2ZVw==
X-Gm-Message-State: AOJu0YzAtxyC/tdi8MfGjnlRNJh8eOSul2AbTdgd19vSEZQOIkbVIfmP
 IHho1JoKHSUasiI+mRFWk2kWbYzm1N+2DF8yiJlvUPl0OgnoM4K1eg69Q/VvT4C2eJxXphtQq8S
 snum/ALw=
X-Gm-Gg: AfdE7cnxWf60atZpUC2Gt57LRV4XBDo14sdvfvBDnB4YhOpCOSCsF/4odOJhHBhbmMN
 PoodhEM/J+Ml8jpL9WqFoaqepeDaiEDHa+mjzjH7Im6JDZLKmj8LdeFu9HQHD4mjv5qV/XznP9a
 ng1x6rPeuUewLo8uoznBhkj4YFgtXjN8zYvU5wm5q0Ftp+z6/Y78gA5Ljnl7r55VlB48Ox303zH
 uNjGDN06TffNvCRD9Ym43ia1pf48a6dq0vHVgwz5UY/+wix5W5vPXj0afjVQ51Y98MoYIx8fjG1
 JpMAD+GkmczIOMzVq+e7/6YYKZdErkn07xSAJph32bv8fThQSp+D9snrrRp3w/WB84ckHnuJuqx
 urNiDMFrGuXtnX293Xc4BlHi+Tv4KiCH4S/d4IkXKzx8OfgeG4bhyZrg11Bu5P0SOnln40lC/br
 cYcZ6dtDWG4x9kHFArKpsV58CwyqoUa8BBYXw/hPjJCvvLYkiPyppMTHudo+l/GCoqkegCOTgYn
 DfpHlSaHkrN844Lr5yR
X-Received: by 2002:a2e:be9a:0:b0:39b:1776:6577 with SMTP id
 38308e7fff4ca-39b17766d34mr1877861fa.40.1782722822024; 
 Mon, 29 Jun 2026 01:47:02 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:47:01 -0700 (PDT)
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
Subject: [PATCH v4 36/64] usb: dwc3: import from kernel v5.12
Date: Mon, 29 Jun 2026 10:44:12 +0200
Message-ID: <20260629084507.3254232-37-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.11 to v5.12.

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

List of commits: git log --oneline v5.11..v5.12
Commits imported:
5aef629704ad usb: dwc3: gadget: Clear DEP flags after stop transfers in ep disable
b522f830d351 usb: dwc3: pci: Enable dis_uX_susphy_quirk for Intel Merrifield
93f1d43c5767 usb: dwc3: gadget: Use max speed if unspecified
cdb651b6021e usb: dwc3: gadget: Set gadget_max_speed when set ssp_rate
5e4010e36a58 usb: dwc3: qcom: skip interconnect init for ACPI probe
f09ddcfcb8c5 usb: dwc3: gadget: Prevent EP queuing while stopping transfers
1cffb1c66499 usb: dwc3: qcom: Add missing DWC3 OF node refcount decrement
2664deb09306 usb: dwc3: qcom: Honor wakeup enabled/disabled state
1edbff9c80ed usb: dwc3: qcom: add ACPI device id for sc8180x
a99163e9e708 Merge tag 'devicetree-for-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
83c4a4eec06a of: Remove of_dev_{get,put}()
4b049f55ed95 usb: dwc3: gadget: Fix dep->interval for fullspeed interrupt
a1679af85b2a usb: dwc3: gadget: Fix setting of DEPCFG.bInterval_m1
d8c849037d93 Merge 5.11-rc7 into usb-next
8cf9045b9138 usb: dwc3: gadget: Remove check for bounded driver
450b9e9fabd8 usb: dwc3: gadget: Set speed only up to the max supported
f551037c0770 usb: dwc3: gadget: Track connected SSP rate and lane count
072cab8a0fe2 usb: dwc3: gadget: Implement setting of SSP rate
678481467d2e usb: dwc3: core: Check maximum_speed SSP genXxY
b1638ee56c1a usb: dwc3: host: Use software node API with the properties
8dc6e6dd1bee usb: dwc3: qcom: Constify the software node
efc9812edc61 usb: dwc3: haps: Constify the software node
c25c210f590e usb: dwc3: qcom: add URS Host support for sdm845 ACPI boot
f08fc2c30e78 usb: dwc3: pci: add support for the Intel Alder Lake-P
73203bde3a95 usb: dwc3: pci: ID for Tiger Lake CPU
e492ce9bcaa1 usb: dwc3: pci: Register a software node for the dwc3 platform device
5dc71f1eb870 USB: dwc3: document gadget_max_speed
132ee0da6e9f usb: dwc3: gadget: Disable Vendor Test LMP Received event
0c0a20f6da04 usb: dwc3: Simplify with dev_err_probe()
370e3d5b711d usb: dwc3: keystone: Simplify with dev_err_probe()
babbdfc9d229 usb: dwc3: core: Replace devm_reset_control_array_get()
a66a7d48f34a Merge 5.11-rc3 into usb-next
7c9a2598463a usb: dwc3: gadget: Preserve UDC max speed setting
77adb8bdf422 usb: dwc3: gadget: Allow runtime suspend if UDC unbinded
82c46b8ed9dc usb: dwc3: gadget: Introduce a DWC3 VBUS draw callback
6dd2565989b4 usb: dwc3: add imx8mp dwc3 glue layer driver
cb4d9b52ec06 usb: dwc3: drd: Improve dwc3_get_extcon() style
c824c73a5e08 usb: dwc3: drd: Avoid error when extcon is missing

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.c   |  83 +++++++-----
 drivers/usb/dwc3/core.h   |  11 ++
 drivers/usb/dwc3/gadget.c | 263 ++++++++++++++++++++++++++------------
 3 files changed, 243 insertions(+), 114 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3101f0dcf6ae..f2448d0a9d39 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1126,11 +1126,8 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 		ret = PTR_ERR(dwc->usb2_phy);
 		if (ret == -ENXIO || ret == -ENODEV) {
 			dwc->usb2_phy = NULL;
-		} else if (ret == -EPROBE_DEFER) {
-			return ret;
 		} else {
-			dev_err(dev, "no usb2 phy configured\n");
-			return ret;
+			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
 		}
 	}
 
@@ -1138,11 +1135,8 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 		ret = PTR_ERR(dwc->usb3_phy);
 		if (ret == -ENXIO || ret == -ENODEV) {
 			dwc->usb3_phy = NULL;
-		} else if (ret == -EPROBE_DEFER) {
-			return ret;
 		} else {
-			dev_err(dev, "no usb3 phy configured\n");
-			return ret;
+			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
 		}
 	}
 
@@ -1151,11 +1145,8 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 		ret = PTR_ERR(dwc->usb2_generic_phy);
 		if (ret == -ENOSYS || ret == -ENODEV) {
 			dwc->usb2_generic_phy = NULL;
-		} else if (ret == -EPROBE_DEFER) {
-			return ret;
 		} else {
-			dev_err(dev, "no usb2 phy configured\n");
-			return ret;
+			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
 		}
 	}
 
@@ -1164,11 +1155,8 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 		ret = PTR_ERR(dwc->usb3_generic_phy);
 		if (ret == -ENOSYS || ret == -ENODEV) {
 			dwc->usb3_generic_phy = NULL;
-		} else if (ret == -EPROBE_DEFER) {
-			return ret;
 		} else {
-			dev_err(dev, "no usb3 phy configured\n");
-			return ret;
+			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
 		}
 	}
 
@@ -1190,11 +1178,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize gadget\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to initialize gadget\n");
 		break;
 	case USB_DR_MODE_HOST:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
@@ -1205,20 +1190,14 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 
 		ret = dwc3_host_init(dwc);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize host\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to initialize host\n");
 		break;
 	case USB_DR_MODE_OTG:
 		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
 		ret = dwc3_drd_init(dwc);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize dual-role\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to initialize dual-role\n");
 		break;
 	default:
 		dev_err(dev, "Unsupported mode of operation %d\n", dwc->dr_mode);
@@ -1273,6 +1252,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	hird_threshold = 12;
 
 	dwc->maximum_speed = usb_get_maximum_speed(dev);
+	dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
 	dwc->dr_mode = usb_get_dr_mode(dev);
 	dwc->hsphy_mode = of_usb_get_phy_mode(dev->of_node);
 
@@ -1444,6 +1424,42 @@ static void dwc3_check_params(struct dwc3 *dwc)
 		}
 		break;
 	}
+
+	/*
+	 * Currently the controller does not have visibility into the HW
+	 * parameter to determine the maximum number of lanes the HW supports.
+	 * If the number of lanes is not specified in the device property, then
+	 * set the default to support dual-lane for DWC_usb32 and single-lane
+	 * for DWC_usb31 for super-speed-plus.
+	 */
+	if (dwc->maximum_speed == USB_SPEED_SUPER_PLUS) {
+		switch (dwc->max_ssp_rate) {
+		case USB_SSP_GEN_2x1:
+			if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_GEN1)
+				dev_warn(dev, "UDC only supports Gen 1\n");
+			break;
+		case USB_SSP_GEN_1x2:
+		case USB_SSP_GEN_2x2:
+			if (DWC3_IP_IS(DWC31))
+				dev_warn(dev, "UDC only supports single lane\n");
+			break;
+		case USB_SSP_GEN_UNKNOWN:
+		default:
+			switch (hwparam_gen) {
+			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
+				if (DWC3_IP_IS(DWC32))
+					dwc->max_ssp_rate = USB_SSP_GEN_2x2;
+				else
+					dwc->max_ssp_rate = USB_SSP_GEN_2x1;
+				break;
+			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
+				if (DWC3_IP_IS(DWC32))
+					dwc->max_ssp_rate = USB_SSP_GEN_1x2;
+				break;
+			}
+			break;
+		}
+	}
 }
 
 static int dwc3_probe(struct platform_device *pdev)
@@ -1490,7 +1506,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	dwc->reset = devm_reset_control_array_get(dev, true, true);
+	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
 
@@ -1555,8 +1571,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = dwc3_core_init(dwc);
 	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to initialize core: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to initialize core\n");
 		goto err4;
 	}
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1b241f937d8f..052b20d52651 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -386,6 +386,8 @@
 #define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
 
 /* Device Configuration Register */
+#define DWC3_DCFG_NUMLANES(n)	(((n) & 0x3) << 30) /* DWC_usb32 only */
+
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
 
@@ -459,6 +461,8 @@
 #define DWC3_DEVTEN_USBRSTEN		BIT(1)
 #define DWC3_DEVTEN_DISCONNEVTEN	BIT(0)
 
+#define DWC3_DSTS_CONNLANES(n)		(((n) >> 30) & 0x3) /* DWC_usb32 only */
+
 /* Device Status Register */
 #define DWC3_DSTS_DCNRD			BIT(29)
 
@@ -964,6 +968,10 @@ struct dwc3_scratchpad_array {
  * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
+ * @max_ssp_rate: SuperSpeed Plus maximum signaling rate and lane count
+ * @gadget_max_speed: maximum gadget speed requested
+ * @gadget_ssp_rate: Gadget driver's maximum supported SuperSpeed Plus signaling
+ *			rate and lane count.
  * @ip: controller's ID
  * @revision: controller's version of an IP
  * @version_type: VERSIONTYPE register contents, a sub release of a revision
@@ -1126,6 +1134,9 @@ struct dwc3 {
 	u32			nr_scratch;
 	u32			u1u2;
 	u32			maximum_speed;
+	u32			gadget_max_speed;
+	enum usb_ssp_rate	max_ssp_rate;
+	enum usb_ssp_rate	gadget_ssp_rate;
 
 	u32			ip;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ee44321fee38..c7ef218e7a8c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -605,8 +605,23 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 		params.param0 |= DWC3_DEPCFG_FIFO_NUMBER(dep->number >> 1);
 
 	if (desc->bInterval) {
-		params.param1 |= DWC3_DEPCFG_BINTERVAL_M1(desc->bInterval - 1);
-		dep->interval = 1 << (desc->bInterval - 1);
+		u8 bInterval_m1;
+
+		/*
+		 * Valid range for DEPCFG.bInterval_m1 is from 0 to 13, and it
+		 * must be set to 0 when the controller operates in full-speed.
+		 */
+		bInterval_m1 = min_t(u8, desc->bInterval - 1, 13);
+		if (dwc->gadget->speed == USB_SPEED_FULL)
+			bInterval_m1 = 0;
+
+		if (usb_endpoint_type(desc) == USB_ENDPOINT_XFER_INT &&
+		    dwc->gadget->speed == USB_SPEED_FULL)
+			dep->interval = desc->bInterval;
+		else
+			dep->interval = 1 << (desc->bInterval - 1);
+
+		params.param1 |= DWC3_DEPCFG_BINTERVAL_M1(bInterval_m1);
 	}
 
 	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
@@ -768,8 +783,6 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	trace_dwc3_gadget_ep_disable(dep);
 
-	dwc3_remove_requests(dwc, dep);
-
 	/* make sure HW endpoint isn't stalled */
 	if (dep->flags & DWC3_EP_STALL)
 		__dwc3_gadget_ep_set_halt(dep, 0, false);
@@ -778,16 +791,18 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	reg &= ~DWC3_DALEPENA_EP(dep->number);
 	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
-	dep->stream_capable = false;
-	dep->type = 0;
-	dep->flags = 0;
-
 	/* Clear out the ep descriptors for non-ep0 */
 	if (dep->number > 1) {
 		dep->endpoint.comp_desc = NULL;
 		dep->endpoint.desc = NULL;
 	}
 
+	dwc3_remove_requests(dwc, dep);
+
+	dep->stream_capable = false;
+	dep->type = 0;
+	dep->flags = 0;
+
 	return 0;
 }
 
@@ -1602,7 +1617,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	struct dwc3		*dwc = dep->dwc;
 
-	if (!dep->endpoint.desc || !dwc->pullups_connected) {
+	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		return -ESHUTDOWN;
@@ -2038,6 +2053,102 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
 	}
 }
 
+static void __dwc3_gadget_set_ssp_rate(struct dwc3 *dwc)
+{
+	enum usb_ssp_rate	ssp_rate = dwc->gadget_ssp_rate;
+	u32			reg;
+
+	if (ssp_rate == USB_SSP_GEN_UNKNOWN)
+		ssp_rate = dwc->max_ssp_rate;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg &= ~DWC3_DCFG_SPEED_MASK;
+	reg &= ~DWC3_DCFG_NUMLANES(~0);
+
+	if (ssp_rate == USB_SSP_GEN_1x2)
+		reg |= DWC3_DCFG_SUPERSPEED;
+	else if (dwc->max_ssp_rate != USB_SSP_GEN_1x2)
+		reg |= DWC3_DCFG_SUPERSPEED_PLUS;
+
+	if (ssp_rate != USB_SSP_GEN_2x1 &&
+	    dwc->max_ssp_rate != USB_SSP_GEN_2x1)
+		reg |= DWC3_DCFG_NUMLANES(1);
+
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+}
+
+static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
+{
+	enum usb_device_speed	speed;
+	u32			reg;
+
+	speed = dwc->gadget_max_speed;
+	if (speed == USB_SPEED_UNKNOWN || speed > dwc->maximum_speed)
+		speed = dwc->maximum_speed;
+
+	if (speed == USB_SPEED_SUPER_PLUS &&
+	    DWC3_IP_IS(DWC32)) {
+		__dwc3_gadget_set_ssp_rate(dwc);
+		return;
+	}
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg &= ~(DWC3_DCFG_SPEED_MASK);
+
+	/*
+	 * WORKAROUND: DWC3 revision < 2.20a have an issue
+	 * which would cause metastability state on Run/Stop
+	 * bit if we try to force the IP to USB2-only mode.
+	 *
+	 * Because of that, we cannot configure the IP to any
+	 * speed other than the SuperSpeed
+	 *
+	 * Refers to:
+	 *
+	 * STAR#9000525659: Clock Domain Crossing on DCTL in
+	 * USB 2.0 Mode
+	 */
+	if (DWC3_VER_IS_PRIOR(DWC3, 220A) &&
+	    !dwc->dis_metastability_quirk) {
+		reg |= DWC3_DCFG_SUPERSPEED;
+	} else {
+		switch (speed) {
+		case USB_SPEED_LOW:
+			reg |= DWC3_DCFG_LOWSPEED;
+			break;
+		case USB_SPEED_FULL:
+			reg |= DWC3_DCFG_FULLSPEED;
+			break;
+		case USB_SPEED_HIGH:
+			reg |= DWC3_DCFG_HIGHSPEED;
+			break;
+		case USB_SPEED_SUPER:
+			reg |= DWC3_DCFG_SUPERSPEED;
+			break;
+		case USB_SPEED_SUPER_PLUS:
+			if (DWC3_IP_IS(DWC3))
+				reg |= DWC3_DCFG_SUPERSPEED;
+			else
+				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
+			break;
+		default:
+			dev_err(dwc->dev, "invalid speed (%d)\n", speed);
+
+			if (DWC3_IP_IS(DWC3))
+				reg |= DWC3_DCFG_SUPERSPEED;
+			else
+				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
+		}
+	}
+
+	if (DWC3_IP_IS(DWC32) &&
+	    speed > USB_SPEED_UNKNOWN &&
+	    speed < USB_SPEED_SUPER_PLUS)
+		reg &= ~DWC3_DCFG_NUMLANES(~0);
+
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+}
+
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
@@ -2060,6 +2171,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 		if (dwc->has_hibernation)
 			reg |= DWC3_DCTL_KEEP_CONNECT;
 
+		__dwc3_gadget_set_speed(dwc);
 		dwc->pullups_connected = true;
 	} else {
 		reg &= ~DWC3_DCTL_RUN_STOP;
@@ -2110,6 +2222,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		}
 	}
 
+	/*
+	 * Check the return value for successful resume, or error.  For a
+	 * successful resume, the DWC3 runtime PM resume routine will handle
+	 * the run stop sequence, so avoid duplicate operations here.
+	 */
+	ret = pm_runtime_get_sync(dwc->dev);
+	if (!ret || ret < 0) {
+		pm_runtime_put(dwc->dev);
+		return 0;
+	}
+
 	/*
 	 * Synchronize any pending event handling before executing the controller
 	 * halt routine.
@@ -2124,6 +2247,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	if (!is_on) {
 		u32 count;
 
+		dwc->connected = false;
 		/*
 		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
 		 * Section 4.1.8 Table 4-7, it states that for a device-initiated
@@ -2154,6 +2278,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	pm_runtime_put(dwc->dev);
 
 	return ret;
 }
@@ -2163,8 +2288,7 @@ static void dwc3_gadget_enable_irq(struct dwc3 *dwc)
 	u32			reg;
 
 	/* Enable all but Start and End of Frame IRQs */
-	reg = (DWC3_DEVTEN_VNDRDEVTSTRCVEDEN |
-			DWC3_DEVTEN_EVNTOVERFLOWEN |
+	reg = (DWC3_DEVTEN_EVNTOVERFLOWEN |
 			DWC3_DEVTEN_CMDCMPLTEN |
 			DWC3_DEVTEN_ERRTICERREN |
 			DWC3_DEVTEN_WKUPEVTEN |
@@ -2302,7 +2426,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
-	int			ret = 0;
+	int			ret;
 	int			irq;
 
 	irq = dwc->irq_gadget;
@@ -2311,29 +2435,14 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	if (ret) {
 		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
 				irq, ret);
-		goto err0;
+		return ret;
 	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (dwc->gadget_driver) {
-		dev_err(dwc->dev, "%s is already bound to %s\n",
-				dwc->gadget->name,
-				dwc->gadget_driver->driver.name);
-		ret = -EBUSY;
-		goto err1;
-	}
-
 	dwc->gadget_driver	= driver;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
-
-err1:
-	spin_unlock_irqrestore(&dwc->lock, flags);
-	free_irq(irq, dwc);
-
-err0:
-	return ret;
 }
 
 static void __dwc3_gadget_stop(struct dwc3 *dwc)
@@ -2401,62 +2510,34 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
-	u32			reg;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
-	reg &= ~(DWC3_DCFG_SPEED_MASK);
-
-	/*
-	 * WORKAROUND: DWC3 revision < 2.20a have an issue
-	 * which would cause metastability state on Run/Stop
-	 * bit if we try to force the IP to USB2-only mode.
-	 *
-	 * Because of that, we cannot configure the IP to any
-	 * speed other than the SuperSpeed
-	 *
-	 * Refers to:
-	 *
-	 * STAR#9000525659: Clock Domain Crossing on DCTL in
-	 * USB 2.0 Mode
-	 */
-	if (DWC3_VER_IS_PRIOR(DWC3, 220A) &&
-	    !dwc->dis_metastability_quirk) {
-		reg |= DWC3_DCFG_SUPERSPEED;
-	} else {
-		switch (speed) {
-		case USB_SPEED_LOW:
-			reg |= DWC3_DCFG_LOWSPEED;
-			break;
-		case USB_SPEED_FULL:
-			reg |= DWC3_DCFG_FULLSPEED;
-			break;
-		case USB_SPEED_HIGH:
-			reg |= DWC3_DCFG_HIGHSPEED;
-			break;
-		case USB_SPEED_SUPER:
-			reg |= DWC3_DCFG_SUPERSPEED;
-			break;
-		case USB_SPEED_SUPER_PLUS:
-			if (DWC3_IP_IS(DWC3))
-				reg |= DWC3_DCFG_SUPERSPEED;
-			else
-				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
-			break;
-		default:
-			dev_err(dwc->dev, "invalid speed (%d)\n", speed);
+	dwc->gadget_max_speed = speed;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
 
-			if (DWC3_IP_IS(DWC3))
-				reg |= DWC3_DCFG_SUPERSPEED;
-			else
-				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
-		}
-	}
-	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+static void dwc3_gadget_set_ssp_rate(struct usb_gadget *g,
+				     enum usb_ssp_rate rate)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
 
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->gadget_max_speed = USB_SPEED_SUPER_PLUS;
+	dwc->gadget_ssp_rate = rate;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
+static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+
+	if (dwc->usb2_phy)
+		return usb_phy_set_power(dwc->usb2_phy, mA);
+
+	return 0;
+}
+
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
@@ -2465,7 +2546,9 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_start		= dwc3_gadget_start,
 	.udc_stop		= dwc3_gadget_stop,
 	.udc_set_speed		= dwc3_gadget_set_speed,
+	.udc_set_ssp_rate	= dwc3_gadget_set_ssp_rate,
 	.get_config_params	= dwc3_gadget_config_params,
+	.vbus_draw		= dwc3_gadget_vbus_draw,
 };
 
 /* -------------------------------------------------------------------------- */
@@ -3239,8 +3322,6 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 {
 	u32			reg;
 
-	dwc->connected = true;
-
 	/*
 	 * WORKAROUND: DWC3 revisions <1.88a have an issue which
 	 * would cause a missing Disconnect Event if there's a
@@ -3280,6 +3361,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	 * transfers."
 	 */
 	dwc3_stop_active_transfers(dwc);
+	dwc->connected = true;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
@@ -3298,12 +3380,18 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	struct dwc3_ep		*dep;
 	int			ret;
 	u32			reg;
+	u8			lanes = 1;
 	u8			speed;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	dwc->speed = speed;
 
+	if (DWC3_IP_IS(DWC32))
+		lanes = DWC3_DSTS_CONNLANES(reg) + 1;
+
+	dwc->gadget->ssp_rate = USB_SSP_GEN_UNKNOWN;
+
 	/*
 	 * RAMClkSel is reset to 0 after USB reset, so it must be reprogrammed
 	 * each time on Connect Done.
@@ -3318,6 +3406,11 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 		dwc->gadget->ep0->maxpacket = 512;
 		dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
+
+		if (lanes > 1)
+			dwc->gadget->ssp_rate = USB_SSP_GEN_2x2;
+		else
+			dwc->gadget->ssp_rate = USB_SSP_GEN_2x1;
 		break;
 	case DWC3_DSTS_SUPERSPEED:
 		/*
@@ -3339,6 +3432,11 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 		dwc->gadget->ep0->maxpacket = 512;
 		dwc->gadget->speed = USB_SPEED_SUPER;
+
+		if (lanes > 1) {
+			dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
+			dwc->gadget->ssp_rate = USB_SSP_GEN_1x2;
+		}
 		break;
 	case DWC3_DSTS_HIGHSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
@@ -3833,6 +3931,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dev->platform_data		= dwc;
 	dwc->gadget->ops		= &dwc3_gadget_ops;
 	dwc->gadget->speed		= USB_SPEED_UNKNOWN;
+	dwc->gadget->ssp_rate		= USB_SSP_GEN_UNKNOWN;
 	dwc->gadget->sg_supported	= true;
 	dwc->gadget->name		= "dwc3-gadget";
 	dwc->gadget->lpm_capable	= true;
@@ -3859,6 +3958,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 				dwc->revision);
 
 	dwc->gadget->max_speed		= dwc->maximum_speed;
+	dwc->gadget->max_ssp_rate	= dwc->max_ssp_rate;
 
 	/*
 	 * REVISIT: Here we should clear all pending IRQs to be
@@ -3875,7 +3975,10 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err5;
 	}
 
-	dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
+	if (DWC3_IP_IS(DWC32) && dwc->maximum_speed == USB_SPEED_SUPER_PLUS)
+		dwc3_gadget_set_ssp_rate(dwc->gadget, dwc->max_ssp_rate);
+	else
+		dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
 
 	return 0;
 
-- 
2.43.0

