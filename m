Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6E0C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C26AF84DEC;
	Thu, 16 Jul 2026 18:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nzB7fCsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A3D584CCF; Thu, 16 Jul 2026 15:43:51 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC3284CE8
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c15df0c154dso75909866b.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209429; x=1784814229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cR7JMGiKXn0XsnMIH6NTetyWi4QOlBmLJ3WkzZeukU0=;
 b=nzB7fCsuuy9zULtEuztaByKjL+bwZ+DyaewJNZdWAjiJy3TiNwT6YnGSAoklHcccwZ
 1dZhAPxhvx4agO5YdAelMoVlzYg03oxkIUa+gJKC/Xo67vuu1CgWKROFxYlZv6qYkkNm
 I7c1uh61fbCClsKfqrBl67QH8Tge6ipm759POrijSsQq8rB39DD2LJfCwsPhwuu/r84B
 1SUUOBrccSfrj5x+o+DMM2syIoXCRDzTrCe1c+J41bgk1pEt2oD3CzieH07aZ6GeEr+M
 9IGE07qX6xWmBtNqyAzW+sEHR9Bt1M0fGYIXdRh7IWkW46vnxO+9OK8KqybWeMwlcO5F
 /wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209429; x=1784814229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cR7JMGiKXn0XsnMIH6NTetyWi4QOlBmLJ3WkzZeukU0=;
 b=ZE9y7PP1RoogsPBQ9Ice92xgh/Ya1h1XI7+CxDwDvXxLgvY73oxMNbmBnWqrVzCMW3
 Qk3igXegm9EXk/oZo8WX5/QZzOBFeJzG1lN2l+iuhplkAVv+iwGmk7yYpNefNGS3Sj8s
 GX/vyXFm4pjQYiiE+E2oOGCjLfD2ae5NnldQnR+5zKcIFhEJP1qzlDU5rTm7b7AjUQnW
 9izfr+rRTSvMMDI9ScXLKCFor6nSUtTen+UJcy1NkSZQL27aksxGHx9DtJdqOlhoXAC7
 RfgT5kgl4tq6QqKTuU8lNgh/2CzRpWxXOYgdMuMVtUxFrPPXUAIUR+1zYfcWhxzRD7A1
 6trA==
X-Gm-Message-State: AOJu0YywYCRqSv8/sRx9RWWLMzZ0To6AhZHur3sriU0E994D+Hsjp9Ni
 k5Fdp/NjWY7/SbYLqTVh9+q2FZ090oLkyX3NdHGkCWuxDlj6ogbs2gI3JQVL2aIAnnmtzJaeS1e
 ASnDp
X-Gm-Gg: AfdE7cmT4CiDbLk0wEy8Bk3GZkSIxExUvF79DrP0qsi0igoG4u2XUMwAadqU3N9HePO
 pLZFl94gpmOKMer25NI6Fx/mzg+FCRTrg8JfAeXEZMOagxuqhKDzisjgxX8+ulsiyajMKF+CibY
 BylnmR2dcPBbX1ln3c1oF1iaeMZvbLIBNi48edUgHVD+tUnTVrz7gDHlN31sRScqUlop/DWmie5
 Z6oJxHKuyUjvKVLYJZVLv/ClcymfVK7Cp2UoLSEj8085GJeJ5XFACYqDdwUnKIwpuEFaiRo9S8u
 IK+Ms9joWrLK3vD9Kzo3uQxwNiK0y6ZIHTbvhXgp1fkTJzBk/qPPchJwEHEULGyx2FZbLH8ROMy
 wRJ8167JkMjNqOQnTWriCZW7+ps1UKgu7oA2beUFE0YFuoWdju5TWeiJpHvwKJarSRp9XwuEZz9
 v/w9gKHBhQ7lBMufb200Q/Qg4tYl6B4e0bSkjrfR/4r6NmnCII
X-Received: by 2002:a17:907:3e0c:b0:c16:6a15:cc8d with SMTP id
 a640c23a62f3a-c166a15d3bfmr372334466b.7.1784209428570; 
 Thu, 16 Jul 2026 06:43:48 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1687316edasm215399066b.29.2026.07.16.06.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:48 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 26/75] usb: dwc3: import from kernel v5.2
Date: Thu, 16 Jul 2026 15:41:56 +0200
Message-ID: <20260716134305.614278-27-anders.roxell@linaro.org>
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
f06ddb53096b BackMerge v5.1-rc5 into drm-next
f31d5c24fb2e reset: Add acquired flag to of_reset_control_array_get()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
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
2.53.0

