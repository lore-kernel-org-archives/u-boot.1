Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DB0C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2FCB84869;
	Mon, 29 Jun 2026 10:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xBDJgnP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6D384105; Mon, 29 Jun 2026 10:45:46 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6737884105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39b14cf91b9so2101501fa.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722744; x=1783327544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Al0y3mizVSfNH7if326zBz4X/yqQOjdeQRhC5kBqfI=;
 b=xBDJgnP9mq4XHicVfxd/m5+D6cOKbuXooGp3Kz1xR+7QqmN8z6qVo8C9LGKDBGXp4Y
 G47NLWZZCUPV7BIMSLEOo784iJCY5fhggzzOmQ2UXcuCCesQ3rBdhjF0Lktjrnh5clJE
 rfXES9h1SBrM6tFfx5hAZowGagxEaZxewdswhJYWjlF+iqvc+OKwE/DIT8VrV7VMQb8C
 tRuDgVoKUEefpfQEJ5/RrKkvAtlqoefncvIM2jYkpUEM27rlUfKVdFWalJcxySRIjv14
 t41WK7TdzizrpJMpoeUS4XwwumS8dq0y8UpIaDKX6CBrcds7xesbbftF/F96Jsnh4Pij
 wGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722744; x=1783327544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Al0y3mizVSfNH7if326zBz4X/yqQOjdeQRhC5kBqfI=;
 b=TeLAgFBDUaETTAwLHvNvYEdB5RmNViCLVBQXcdbuWRxBn1ZXz39hfUyua+jnoLeUoz
 6erGjg21OITlkjZ4Jcp1+SCAx5aImCK1OOKPwruf3XmenMpV2B3sy7UvRw8vgWfIxriL
 BSWRlQ0GyB+/vRW0h/YIyu+3+O+u+ZedXtZivqlDtC1zg9gBLNcbiA/n7enqJe9ZWpEH
 dykdOvxqMw27e1IUJxbt4a3Vriusy5VU/i9SuIDgtImGAWfdnrcofpB47cAHWYv8b+se
 7cVS+A1xmvC2ic0tN5EhK7bpypeif0UD/wUBtVM+IsLxUe6+PYshrXbDVH7bDdEwMD0q
 1oSw==
X-Gm-Message-State: AOJu0YzuiGli1Ko86pN6H8/NLYtiUhWt0ehXQPFTgHrb9QWTBTR3RiRb
 kQdlR6G3ahNTro9OlgkXgvB66mtNWItndHV7nvm45SZq2bx0Yvoe3yl+8EFGD6CatVJWM3JPr5y
 EE0qvmAg=
X-Gm-Gg: AfdE7clZwrvDjLVPpwEFoR3WQza5OB4YSj6Gl6sXZLhlehdsMjvs8pwiVeVPVZOjlQJ
 4Om7H38vCZeZZGdI06JE4LO179zNZ0f/opy9PytbuXoA6BuH2wZNBxj/B0Mprhh/7x69gKuJF1k
 3wCTJbH4GThAyHsIw60xAnCaLjSrBmye8ZjFJJolc0WoOwBOfHzVG93Q3q/oEUABDjLcZznOQZL
 L1oKF52NjeY/EQqRntnyPaTFqpom9QWmK8XBJ6jr5p0CPp9AwQP/aPkrjjk/aQyqK4B6l34CLqE
 puwMvjhMnvIoSnqb5n0bPS+PZZ0d/9WsqcULMQqYkLoiYc5A6Ve4i0pRB1TwqWY4PgOFV1+ky7G
 mU9/AA9V+o9IdePPYgc6d6b6b3TX1oSb66+V/tJoKlolfiktyx/W9iW7ek6nEAP+nMlnX19mRwD
 0L/T3FODgPu/IMHJZHhsuNRdzoIxHm4CJUWlP8Kg/eYsWyRmfhGhtZTNzid3uQvH9TZxL9LyaSE
 nM686BACyLCXsOmRYMt
X-Received: by 2002:a05:651c:1507:b0:39a:cfe8:dcbe with SMTP id
 38308e7fff4ca-39ae1616ad1mr20657621fa.31.1782722743441; 
 Mon, 29 Jun 2026 01:45:43 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:45:42 -0700 (PDT)
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
Subject: [PATCH v4 05/64] usb: dwc3: import from kernel v4.2
Date: Mon, 29 Jun 2026 10:43:41 +0200
Message-ID: <20260629084507.3254232-6-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.1 to v4.2.

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

List of commits: git log --oneline v4.1..v4.2
Commits imported:
aebda6187181 usb: dwc3: Reset the transfer resource index on SET_INTERFACE
43cacb03aabe usb: dwc3: core: avoid NULL pointer dereference
50641056d833 usb: dwc3: Use ASCII space in Kconfig
19915e623458 Merge 4.1-rc7 into usb-next
e152813ff5fe Merge tag 'usb-for-v4.2' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
e18b7975c885 usb: dwc3: gadget: don't clear EP_BUSY too early
76e838c9f776 usb: dwc3: gadget: return error if command sent to DEPCMD register fails
891b1dc02295 usb: dwc3: gadget: return error if command sent to DGCMD register fails
909eacd748b3 Merge 4.1-rc4 into usb-next
88bc9d194ff6 usb: dwc3: add ULPI interface support
a89d977cc04c usb: dwc3: pci: add quirk for Baytrails
3e10a2ce98d1 usb: dwc3: add hsphy_interface property
45bb7de213d8 usb: dwc3: setup phys earlier
c5cc74e8c12b usb: dwc3: soft reset to it's own function
2917e7181589 usb: dwc3: cache hwparams earlier
6c89cce0476f usb: dwc3: store driver data earlier
f699b94789a6 usb: dwc3: ULPI or UTMI+ select
b5699eeee68f usb: dwc3: USB2 PHY register access bits

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
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
2.43.0

