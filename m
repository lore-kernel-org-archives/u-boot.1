Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527F1C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AD1E84A77;
	Mon, 29 Jun 2026 10:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DSYJ+o6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B02C84A75; Mon, 29 Jun 2026 10:46:39 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DFED84A65
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5aea33ffa0aso2106270e87.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722796; x=1783327596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYWXr81QwYhU2linYxZXA7Miqf8I7oaLqUS9OVayq2k=;
 b=DSYJ+o6XtETD2BmjinAj0w1w5Jn0oXNaDhuaZ8kj6vvhv/2vzp4C5suNtIDWVW7m/J
 CZuslBpxbQtoasScFkiPOxvP00kHY3kcWMSKyVCy2M45gUPmY6pNv9Yq4PnuT6d6i8BV
 E+nI159GLZ074jqacxzVnaeCm7J+XB3TOV08fFyAmkFadDUOw0oFK2j/i518i5h+mb47
 wu1YGEzuIiXWBKbAFOjhohGbZpuBqEjx8+3ovoutGsmmCnPMFSPHSntrlYnP9xRhFUnN
 fk1sSthMYMvfdXV5z4S8svdQv8VoCJvBRiv1SQ3/Y6jJBQz3NRftW0t2b9iDdr/h6Jtm
 pnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722796; x=1783327596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eYWXr81QwYhU2linYxZXA7Miqf8I7oaLqUS9OVayq2k=;
 b=UHl30CqKu8U3xpTDFB9aRgAlOHYJejxvPdVPuKRoWUgup0Z1bA+JnxOs+PgDU9yX03
 Wy74Q/HP9/E816fG7HfxQJpJO4Mh4qUj6N/WCIa233RqYdboCsGHAfHNhGpiQ5CT24f3
 BhJyOyZnF+Hd6Afgvu9BbM8/xL8vlKnOuvJQ7AZk1lh7wfqE7xYLL16VmgdwdbjRjBA3
 E/LGmz5wZ2zydjGlCVgK9evtA3Aab5jI4FxV4N90f28koHKr/auO1JpqcDo2uEOk5oDX
 FK1I9U+mpsfRCF9LsyVU+Z2h3HW4Xnq/l2hLHWjoSq6pVTCpDGhjWisAbLA6sAat2soE
 A/rw==
X-Gm-Message-State: AOJu0YwlfiY/PmSOdyT0+Rvw3FDchTbrlml+7zLaofGGi4iN13wxetn6
 OT3YS8z+v1PlgXuLhSlnEPwz+N0CtJa9fS19CnPukwiDvi0UYlpA6T4DWk90FaHLbP4hQE37v/D
 FFsuipcE=
X-Gm-Gg: AfdE7cmFU/BE3o1zHlCux/4hHvJnMxCzF9l6atKFmx+9wfzjiGXZLYDbWyRyvPa5DVr
 1saAw+nSia/kH9IT4XzOsNyU3vjCQfcjrzBp2UG/GTTXmorVe9oPpf5hTerfwcmM0ur3VUWSb9U
 i3eAglzhYIEy48krglypjpO/D1frMX4dFwENx5FhwTdr8A2AFty5Hfa27jXQ9TZMz0Cm5sTuTEb
 1n4bDqd58hZuk3TKcENjWksH82tPy8bVSCfTznZR/ONGdg9WWNtM1tlRpNzAeEeJSGbmqB4FBSb
 3DDf/Z87aoXYgdHynXos+uDn2dHZN2NTj82DPYwbqE7DG3by8+LKRdEmO/EgWdzwWtvT43pCRzL
 QkNKvVMDE4HmH9x8lJyh3stxnPIPo0RNqmyfGhuuaCWdWd5ywcakvUVKf28jjsEHosOcEmzt8Zv
 5xCLgwFxEAOs8D3pmjwnuUEWaCteKUVdjT1leVoWbzqmbCuNE0EZSfyQWNnKZc29lEijb5AQMvD
 7QVyz1Q/HajGl775b3S
X-Received: by 2002:a05:6512:8348:b0:5ae:b2a0:24af with SMTP id
 2adb3069b0e04-5aeb2a02686mr784323e87.31.1782722796527; 
 Mon, 29 Jun 2026 01:46:36 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:46:34 -0700 (PDT)
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
Subject: [PATCH v4 26/64] usb: dwc3: import from kernel v5.2
Date: Mon, 29 Jun 2026 10:44:02 +0200
Message-ID: <20260629084507.3254232-27-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.1 to v5.2.

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

List of commits: git log --oneline v5.1..v5.2
Commits imported:
a2d635decbfa Merge tag 'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRATA
8d791929b2fb usb: dwc3: Fix default lpm_nyet_threshold value
dd24f9b604d3 usb: dwc3: debug: Print GET_STATUS(device) tracepoint
b873e2d0ea1e usb: dwc3: Do core validation early on probe
c729969b2b69 usb: dwc3: gadget: Set lpm_capable
41a91c606e7d usb: dwc3: move synchronize_irq() out of the spinlock protected block
75ecb9dd56a7 usb: dwc3: Free resource immediately after use
c0c61471ef86 usb: dwc3: of-simple: Convert to bulk clk API
c99993376f72 usb: dwc3: Add Amlogic G12A DWC3 glue
67130830ce42 usb: dwc3: Allow building USB_DWC3_QCOM without EXTCON
6e865c723014 Merge tag 'drm/tegra/for-5.2-rc1' of git://anongit.freedesktop.org/tegra/linux into drm-next
f06ddb53096b BackMerge v5.1-rc5 into drm-next
f31d5c24fb2e reset: Add acquired flag to of_reset_control_array_get()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.c   | 18 +++++++++++-------
 drivers/usb/dwc3/core.h   |  3 +--
 drivers/usb/dwc3/debug.h  |  3 +++
 drivers/usb/dwc3/gadget.c |  5 ++---
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a1b126f90261..4aff1d8dbc4f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -828,6 +828,7 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 	ret = device_property_read_u32_array(dev,
 			"snps,incr-burst-type-adjustment", vals, ntype);
 	if (ret) {
+		kfree(vals);
 		dev_err(dev, "Error to get property\n");
 		return;
 	}
@@ -846,6 +847,8 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 		incrx_mode = INCRX_BURST_MODE;
 	}
 
+	kfree(vals);
+
 	/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
 	cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
 	if (incrx_mode)
@@ -893,12 +896,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	u32			reg;
 	int			ret;
 
-	if (!dwc3_core_is_valid(dwc)) {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		ret = -ENODEV;
-		goto err0;
-	}
-
 	/*
 	 * Write Linux Version Code to our GUID register so it's easy to figure
 	 * out which kernel version a bug was found.
@@ -1218,7 +1215,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_max_burst_prd;
 
 	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xff;
+	lpm_nyet_threshold = 0xf;
 
 	/* default to -3.5dB de-emphasis */
 	tx_de_emphasis = 1;
@@ -1426,6 +1423,11 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->regs	= regs;
 	dwc->regs_size	= resource_size(&dwc_res);
 
+	if (!dwc3_core_is_valid(dwc)) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		return -ENODEV;
+	}
+
 	dwc3_get_properties(dwc);
 
 	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
@@ -1600,6 +1602,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -1632,6 +1635,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_suspend(dwc);
 			spin_unlock_irqrestore(&dwc->lock, flags);
+			synchronize_irq(dwc->irq_gadget);
 		}
 
 		dwc3_otg_exit(dwc);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1528d395b156..f19cbeb01087 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -406,8 +406,7 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
-#define DWC3_DCTL_LPM_ERRATA_MASK	DWC3_DCTL_LPM_ERRATA(0xf)
-#define DWC3_DCTL_LPM_ERRATA(n)		((n) << 20)
+#define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
 #define DWC3_DCTL_KEEP_CONNECT		BIT(19)
 #define DWC3_DCTL_L1_HIBER_EN		BIT(18)
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 6759a7efd8d5..068259fdfb0c 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -250,6 +250,9 @@ static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str,
 		size_t size)
 {
 	switch (t & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		snprintf(str, size, "Get Device Status(Length = %d)", l);
+		break;
 	case USB_RECIP_INTERFACE:
 		snprintf(str, size, "Get Interface Status(Intf = %d, Length = %d)",
 				i, l);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e293400cc6e9..d67655384eb2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2863,7 +2863,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
 		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
-			reg |= DWC3_DCTL_LPM_ERRATA(dwc->lpm_nyet_threshold);
+			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
 
 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	} else {
@@ -3301,6 +3301,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget.sg_supported	= true;
 	dwc->gadget.name		= "dwc3-gadget";
 	dwc->gadget.is_otg		= dwc->dr_mode == USB_DR_MODE_OTG;
+	dwc->gadget.lpm_capable		= true;
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -3384,8 +3385,6 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
-	synchronize_irq(dwc->irq_gadget);
-
 	return 0;
 }
 
-- 
2.43.0

