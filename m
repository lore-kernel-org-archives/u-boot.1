Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5BFCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5121A84ACE;
	Thu,  7 May 2026 11:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zi8e7LGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA9B584AA0; Thu,  7 May 2026 11:30:09 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E7B84A1E
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5a8721851e2so552198e87.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146203; x=1778751003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Dv/ir+QlEuxIOd9S4/OSoHriy31DID91CmUQHPuElA=;
 b=zi8e7LGXCIh/26ySt7kLciSJlkjp491TZhqJoTX/mBquoClWYYIIbbWhf5iiG1UBvs
 M5MEtyb4BdlFFjCxwStS3Ee27r0xRDPP4pp0iIXX/AX77bg1arAfH71PS8BTt8d47pWF
 DE6PQI4sjRl/85nHv5CRxA2MDIWny763aM+FRblsvEazI4jedJ34YL9kOudonx980EX8
 F62ToJ3pALgKJlacKR3HsV1ZViRi8PKA9yGcK9+LZ2m0jp0piAT090MJUvwRblWXA/xG
 HML90nHmWS6YQCrEtUWK5eZF5+41LeUCtRh1ft7txKoeYCHsIa0StQhM4kc4O8PTC3vK
 ArcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146203; x=1778751003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Dv/ir+QlEuxIOd9S4/OSoHriy31DID91CmUQHPuElA=;
 b=nvs5LxWW35i+UrwOReemoXZfH1n2PQDbduDuuJu6JLZzWTse+eeAkzVp72+Bdy8JTp
 Dbl+FDGwrqlL5y+KuwwvGmIHJrt7YE69571zfeaFVNYcrkKSK6wA7GcOrstAxkv3qLie
 UROzaXsraRsg3RoNIZvRgxb0NdMoOIJBm2P3asjCYrIHgV0z2lkvIdUh9uHq591GRcFy
 CfbR2258Azrlw9xzHdFmlkDOCCVuGPgAiOPLra8dBzMmBQeigHGeBEy3aByNHJFTot8L
 O+f0ZtQ+PltUhkAkPpWkMsFKrTYYgp+vCoG7WsJ7W1uYCV9HnXDJj2utv4Q2Nw3PrFSU
 vnVA==
X-Gm-Message-State: AOJu0Yx6HPyndGF2N6LzYAvHoNoGQLcg/q7OhXDwWRh9DeMKtWwRTK28
 l1IjsK5+z3BWbxewFNX3EHZi6M2T3b6zTN3j7BklCuwgymmCtZcwDe+xtC8sbbmnhSbgxb/oAp7
 7GIazVnc35Q==
X-Gm-Gg: AeBDietybdKzh5Ry4PNPc9Y5633whhxCfvYuPyNJ5AlvtPHkbKYr4vZkb93UQRhM+oA
 8W0B37Wu3rMdTRo77hjtVisToFNQUYlMGeB8rnymWmnApw8JtDmW+IqVIDQzsbYb2BDT+MrjzZp
 ECYWrIhNymS4eV2AbT+vCx90vvdYM0AJeuGdneN7wAaOvsKjqOD08139dUcCSloZozVnq38E4m4
 yUGZxk/ZBaMcArzX/GGISRV6/YBAA8QQSwETN6WrUgGL4XtQ5Dj8xShTrtFSRY9XGs3Z6vhIAb0
 nH7YsrwjDzfYhJfq7CsI4JP3TAIuKGCUvCaDCUUWZplEOFXSPRcPp4imVV5InIZzB7JrhazfGlH
 8eWXLN6gjq2MPmdJpH8QKK8EMSfg6IBkmfrxGt6KZb7jsO4rGFjQwDvJD0NuHiyoHgbdMe+n19v
 8GYbeTOOIYddQ1HATCcEzjS2dsaMAtbHZ2FRJ8NYm1AwfCCft7krcDtKAxJYm/zmHEr9DBq2uDX
 qe+zT1bDcoEjsXl3Y3s/yaWZy49tqjpAYnuXV0+wA==
X-Received: by 2002:a05:6512:118a:b0:5a8:8db6:b3d with SMTP id
 2adb3069b0e04-5a88db611e8mr2303292e87.24.1778146203084; 
 Thu, 07 May 2026 02:30:03 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:30:02 -0700 (PDT)
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
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH v2 26/64] usb: dwc3: import from kernel v5.2
Date: Thu,  7 May 2026 11:27:33 +0200
Message-ID: <20260507092843.358908-27-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
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

