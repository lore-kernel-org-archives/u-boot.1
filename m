Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EDDC5DF93
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7388F60AA7;
	Fri, 21 Aug 2026 13:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bb-QNVPtcBqh; Fri, 21 Aug 2026 13:11:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317915;
	bh=Bh+B/TmbyVAU3hRTvK0yiCDIWusj8xwi9ldHyrw+DXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HQur3MrBiwqw4XdDoGuGG280aQVHUvgE2NACYpBy9Nd2CBhnmDKkAEYQII0nQ6Nck
	 2ZKjV8qGYK0uI5JhAbTtpuLQRamF7hPB1jkqJQ2xNjgR8BYaLy417AVztfEN3QDzJy
	 Hvkc7sFGEmK0ryB5OnLXl1ggKfZZYLYzZlFwaC9Wb10vRKzb4brj3hCYBBLKAERxYq
	 gtp0ArIXChfYtKnCuupqKF4G9RsuNv0YRFnUmm62ctRF47f7fWc+fLS0FRC8mBUL2Y
	 6xKdu4Q7Mg5F/vId2nr5+Af8oBbbwLYIZ+CFN7KwJVaYmZXLp9+Bm1hX8MUarJ5O2J
	 mh3bidCWQ2H9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A088060AAA;
	Fri, 21 Aug 2026 13:11:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 59B1E476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57C2340073
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id usvcCmX4vuJw for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:50:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=dLolvWkJ
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 112B240071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:57 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69fdfd98eb8so151734a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302256; x=1787907056;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bh+B/TmbyVAU3hRTvK0yiCDIWusj8xwi9ldHyrw+DXA=;
 b=dLolvWkJSB6D/0A17l7IZXfYitLQR2tcYsIbcs1cVbb+rVTBRB5GdsAOHDW7w/rOaX
 PY6YcQFrscJEpzQFIkYusYUqhDKzqWlPFKCxnXVa1KKUBH8+Sueyr9x8a1q3zncFxi+o
 hQbKT0tRl0iHb+ROeU466cjFQoySC3XZP2FBqN8ybqZcWk4UhNpkKFLMLWd09/CsiNOT
 +0QHjOggGuxR1kiVA0KngX00Tid7WVWSD0569x2NkxjPIIGRQlWF6Tucxbj2DNt4m6VG
 8WHPBwNEafk8tUL5hJxmn0QfLtsnjMI+tRML0YqPXrMMWR0U1vGXMJXIOZRz/Df9o5Rw
 XLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302256; x=1787907056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bh+B/TmbyVAU3hRTvK0yiCDIWusj8xwi9ldHyrw+DXA=;
 b=Sd5biTaRSTuVmZMq+YAXytj6imevuvfZc9raYL2FrAyf6ZFwp0BeK+3bA+eLHcn6VI
 SpWlZnsmWNzPjFPmwKoNMudwPyOkHj0008AVA12SN+tw5VWPbj1lbx97N7z7Q8zc8jcF
 Xyqsiq127c65f3EtHe3zA/b0x6y1m7AmAMFpqahutrbTHa7RMSnUJkp/X9HUkHGyIV7U
 r3T5VgYpSRrHw+GUmZ7pzD8HwT+qs9Fb/T8BvkS+O5Va4jMxRKLi/NSSkUm2oIYHtKEn
 +eLZWly2aeE8PCY2W/Y0bBM4bJkMJ/lN388CCqlELHSEhkiNFgE73P5z3/SagRr113yX
 p4iQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/Rk7xNgb1wlFiVM+OWTKF+eY1qEB2Yde741aJNZGRs0PJOLfiql6cBwkmJ/3FqzZLHfaMVYM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mUqq45TR+aKDnan458Ytbw9U/CFluBD7m3OrG4uS6eNvPf4l11
 Sj5F4NZ7gJ56oLKonv0CotiTNFmSQzXrIyRPKh9howlNAtua0tY3b1lvhh48uh5LdQk=
X-Gm-Gg: AR+sD13FCTcTPKvD3BIgBVYLlMjIiXwOyGPVgBftV9INRm5riOe5CAFf4zFAs7GWOwL
 El13b6R9tk62sKAOaz/ziTpb1BjEyJOvesUGjkQzeU/8raMUIhA64bs6IXWh3mU6L1Hv4KT67uY
 bN8cISgdWlQS5hsSwAVZuRe7AjCBwtf3e7DUBukxkuAZTkWxDsPsr5Y15Jp6EsOPaHfds38u+hn
 pC8+WHkE0kJ44FFHBiZ+3+k6P+HQN5JMnmIFRe7zr5HqujeiL/5aMFNIQc6jk6mX2IRyjWcoctY
 UH2YfB+T1fsIjkRDhNRFT4k/aM5wc/yehtvphfYZ/bPrQMEC9qHJeZlcKNErgmSS7JYXjQxNikz
 fsiKPzL9eeJmqBpwnkNO4KA1gtf1MjY41UIuluUQdXMBOhOaGRc1HNGx/N6+706CxCw7pKr5xkq
 lUhDEMHw0Lpjjzv3A1pnihafdnVGduHPWP/qhkRvsVFP7eTYSS41oE3zTOw4606XpciyN3tcepf
 9oD3dM4sDEZGb/qonGJozpcInmYC14hKlyvZq6J4jz4NDA=
X-Received: by 2002:a17:907:c19:b0:c21:6f8c:231f with SMTP id
 a640c23a62f3a-c246a2e942emr277030966b.1.1787302255831; 
 Fri, 21 Aug 2026 01:50:55 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591e044dsm398649066b.51.2026.08.21.01.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:50:55 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 06/87] usb: dwc3: import from kernel v4.2
Date: Fri, 21 Aug 2026 10:46:42 +0200
Message-ID: <20260821084829.2070426-7-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:39 +0000
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

Sync Linux kernel dwc3 changes from v4.1 to v4.2.

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

List of commits: git log --oneline v4.1..v4.2
Commits imported:
aebda6187181 usb: dwc3: Reset the transfer resource index on SET_INTERFACE
43cacb03aabe usb: dwc3: core: avoid NULL pointer dereference
e18b7975c885 usb: dwc3: gadget: don't clear EP_BUSY too early
76e838c9f776 usb: dwc3: gadget: return error if command sent to DEPCMD register fails
891b1dc02295 usb: dwc3: gadget: return error if command sent to DGCMD register fails
88bc9d194ff6 usb: dwc3: add ULPI interface support
3e10a2ce98d1 usb: dwc3: add hsphy_interface property
45bb7de213d8 usb: dwc3: setup phys earlier
c5cc74e8c12b usb: dwc3: soft reset to it's own function
2917e7181589 usb: dwc3: cache hwparams earlier
6c89cce0476f usb: dwc3: store driver data earlier
f699b94789a6 usb: dwc3: ULPI or UTMI+ select
b5699eeee68f usb: dwc3: USB2 PHY register access bits

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c          | 110 ++++++++++++++++++++++++-------
 drivers/usb/dwc3/core.h          |  26 ++++++++
 drivers/usb/dwc3/ep0.c           |   4 ++
 drivers/usb/dwc3/gadget.c        |  10 ++-
 drivers/usb/dwc3/platform_data.h |   2 +
 5 files changed, 126 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2bbab3d86fff..ff5773c66b84 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -116,6 +116,33 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	return 0;
 }
 
+/**
+ * dwc3_soft_reset - Issue soft reset
+ * @dwc: Pointer to our controller context structure
+ */
+static int dwc3_soft_reset(struct dwc3 *dwc)
+{
+	unsigned long timeout;
+	u32 reg;
+
+	timeout = jiffies + msecs_to_jiffies(500);
+	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			break;
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(dwc->dev, "Reset Timed Out\n");
+			return -ETIMEDOUT;
+		}
+
+		cpu_relax();
+	} while (true);
+
+	return 0;
+}
+
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
@@ -367,10 +394,15 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 /**
  * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
  * @dwc: Pointer to our controller context structure
+ *
+ * Returns 0 on success. The USB PHY interfaces are configured but not
+ * initialized. The PHY interfaces and the PHYs get initialized together with
+ * the core in dwc3_core_init.
  */
-static void dwc3_phy_setup(struct dwc3 *dwc)
+static int dwc3_phy_setup(struct dwc3 *dwc)
 {
 	u32 reg;
+	int ret;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
@@ -409,10 +441,43 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
-	mdelay(100);
-
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 
+	/* Select the HS PHY interface */
+	switch (DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3)) {
+	case DWC3_GHWPARAMS3_HSPHY_IFC_UTMI_ULPI:
+		if (dwc->hsphy_interface &&
+				!strncmp(dwc->hsphy_interface, "utmi", 4)) {
+			reg &= ~DWC3_GUSB2PHYCFG_ULPI_UTMI;
+			break;
+		} else if (dwc->hsphy_interface &&
+				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
+			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		} else {
+			dev_warn(dwc->dev, "HSPHY Interface not defined\n");
+
+			/* Relying on default value. */
+			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
+				break;
+		}
+		/* FALLTHROUGH */
+	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
+		/* Making sure the interface and PHY are operational */
+		ret = dwc3_soft_reset(dwc);
+		if (ret)
+			return ret;
+
+		udelay(1);
+
+		ret = dwc3_ulpi_init(dwc);
+		if (ret)
+			return ret;
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+
 	/*
 	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
 	 * '0' during coreConsultant configuration. So default value will
@@ -427,7 +492,7 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
-	mdelay(100);
+	return 0;
 }
 
 /**
@@ -438,7 +503,6 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
  */
 static int dwc3_core_init(struct dwc3 *dwc)
 {
-	unsigned long		timeout;
 	u32			hwparams4 = dwc->hwparams.hwparams4;
 	u32			reg;
 	int			ret;
@@ -466,21 +530,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	}
 
 	/* issue device SoftReset too */
-	timeout = jiffies + msecs_to_jiffies(500);
-	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
-	do {
-		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-		if (!(reg & DWC3_DCTL_CSFTRST))
-			break;
-
-		if (time_after(jiffies, timeout)) {
-			dev_err(dwc->dev, "Reset Timed Out\n");
-			ret = -ETIMEDOUT;
-			goto err0;
-		}
-
-		cpu_relax();
-	} while (true);
+	ret = dwc3_soft_reset(dwc);
+	if (ret)
+		goto err0;
 
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
@@ -555,8 +607,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
-	dwc3_phy_setup(dwc);
-
 	ret = dwc3_alloc_scratch_buffers(dwc);
 	if (ret)
 		goto err1;
@@ -836,6 +886,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,tx_de_emphasis_quirk");
 		of_property_read_u8(node, "snps,tx_de_emphasis",
 				&tx_de_emphasis);
+		of_property_read_string(node, "snps,hsphy_interface",
+					&dwc->hsphy_interface);
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -863,6 +915,8 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->tx_de_emphasis_quirk = pdata->tx_de_emphasis_quirk;
 		if (pdata->tx_de_emphasis)
 			tx_de_emphasis = pdata->tx_de_emphasis;
+
+		dwc->hsphy_interface = pdata->hsphy_interface;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
@@ -875,12 +929,18 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->hird_threshold = hird_threshold
 		| (dwc->is_utmi_l1_suspend << 4);
 
+	platform_set_drvdata(pdev, dwc);
+	dwc3_cache_hwparams(dwc);
+
+	ret = dwc3_phy_setup(dwc);
+	if (ret)
+		goto err0;
+
 	ret = dwc3_core_get_phy(dwc);
 	if (ret)
 		goto err0;
 
 	spin_lock_init(&dwc->lock);
-	platform_set_drvdata(pdev, dwc);
 
 	if (!dev->dma_mask) {
 		dev->dma_mask = dev->parent->dma_mask;
@@ -892,8 +952,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_forbid(dev);
 
-	dwc3_cache_hwparams(dwc);
-
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
@@ -964,6 +1022,7 @@ err2:
 
 err1:
 	dwc3_free_event_buffers(dwc);
+	dwc3_ulpi_exit(dwc);
 
 err0:
 	/*
@@ -999,6 +1058,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	phy_power_off(dwc->usb3_generic_phy);
 
 	dwc3_core_exit(dwc);
+	dwc3_ulpi_exit(dwc);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c0eafa6fd403..044778884585 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -30,6 +30,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/ulpi/interface.h>
 
 #include <linux/phy/phy.h>
 
@@ -173,6 +174,15 @@
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
+#define DWC3_GUSB2PHYCFG_ULPI_UTMI	(1 << 4)
+
+/* Global USB2 PHY Vendor Control Register */
+#define DWC3_GUSB2PHYACC_NEWREGREQ	(1 << 25)
+#define DWC3_GUSB2PHYACC_BUSY		(1 << 23)
+#define DWC3_GUSB2PHYACC_WRITE		(1 << 22)
+#define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
+#define DWC3_GUSB2PHYACC_EXTEND_ADDR(n)	(n << 8)
+#define DWC3_GUSB2PHYACC_DATA(n)	(n & 0xff)
 
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
@@ -652,6 +662,7 @@ struct dwc3_scratchpad_array {
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
+ * @ulpi: pointer to ulpi interface
  * @dcfg: saved contents of DCFG register
  * @gctl: saved contents of GCTL register
  * @isoch_delay: wValue from Set Isochronous Delay request;
@@ -673,6 +684,7 @@ struct dwc3_scratchpad_array {
  * @test_mode_nr: test feature selector
  * @lpm_nyet_threshold: LPM NYET response threshold
  * @hird_threshold: HIRD threshold
+ * @hsphy_interface: "utmi" or "ulpi"
  * @delayed_status: true when gadget driver asks for delayed status
  * @ep0_bounced: true when we used bounce buffer
  * @ep0_expect_in: true when we expect a DATA IN transfer
@@ -739,6 +751,8 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	struct ulpi		*ulpi;
+
 	void __iomem		*regs;
 	size_t			regs_size;
 
@@ -800,6 +814,8 @@ struct dwc3 {
 	u8			lpm_nyet_threshold;
 	u8			hird_threshold;
 
+	const char		*hsphy_interface;
+
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
@@ -1035,4 +1051,14 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
 }
 #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
 
+#if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
+int dwc3_ulpi_init(struct dwc3 *dwc);
+void dwc3_ulpi_exit(struct dwc3 *dwc);
+#else
+static inline int dwc3_ulpi_init(struct dwc3 *dwc)
+{ return 0; }
+static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
+{ }
+#endif
+
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 2ef3c8d6a9db..69e769c35cf5 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -727,6 +727,10 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_ISOCH_DELAY");
 		ret = dwc3_ep0_set_isoch_delay(dwc, ctrl);
 		break;
+	case USB_REQ_SET_INTERFACE:
+		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_INTERFACE");
+		dwc->start_config_issued = false;
+		/* Fall through */
 	default:
 		dwc3_trace(trace_dwc3_ep0, "Forwarding to gadget driver");
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8946c32047e9..333a7c0078fc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -291,6 +291,8 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 			dwc3_trace(trace_dwc3_gadget,
 					"Command Complete --> %d",
 					DWC3_DGCMD_STATUS(reg));
+			if (DWC3_DGCMD_STATUS(reg))
+				return -EINVAL;
 			return 0;
 		}
 
@@ -328,6 +330,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 			dwc3_trace(trace_dwc3_gadget,
 					"Command Complete --> %d",
 					DWC3_DEPCMD_STATUS(reg));
+			if (DWC3_DEPCMD_STATUS(reg))
+				return -EINVAL;
 			return 0;
 		}
 
@@ -1902,12 +1906,16 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 {
 	unsigned		status = 0;
 	int			clean_busy;
+	u32			is_xfer_complete;
+
+	is_xfer_complete = (event->endpoint_event == DWC3_DEPEVT_XFERCOMPLETE);
 
 	if (event->status & DEPEVT_STATUS_BUSERR)
 		status = -ECONNRESET;
 
 	clean_busy = dwc3_cleanup_done_reqs(dwc, dep, event, status);
-	if (clean_busy)
+	if (clean_busy && (is_xfer_complete ||
+				usb_endpoint_xfer_isoc(dep->endpoint.desc)))
 		dep->flags &= ~DWC3_EP_BUSY;
 
 	/*
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index a2bd464be828..d3614ecbb9ca 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -45,4 +45,6 @@ struct dwc3_platform_data {
 
 	unsigned tx_de_emphasis_quirk:1;
 	unsigned tx_de_emphasis:2;
+
+	const char *hsphy_interface;
 };
-- 
2.53.0

