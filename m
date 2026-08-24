Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865B4C61DB6
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48DA080E19;
	Mon, 24 Aug 2026 16:44:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYa-o2kLbJpl; Mon, 24 Aug 2026 16:44:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589854;
	bh=T/TQHJVqyqNkgzJtT2kYZ7dmRO5Av+sI0L4cTFBOr1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rDt9iI2ckXggyAyLcJfiay0g8kB4jz0YqY4EtkSRW2FMWkzgyjYppK/J0CWFsYxjQ
	 nEuSRNEn28xTyxII4pmIO9kO4pesQhA7tJzM28X7gePeu3fA224sDXH0f8kC/z6VFH
	 y4r4G29ML7g9aCp4juYQgNRmCD4FTfPW6BwtisHBkXJ98JkRVu6R5MStNpxNP+BTaI
	 8YeEmYToOg7kDR2LANAIQ2szPTGRmA612UhQznuYjWpPpw6yBaod1e4Fnx8DPlSNut
	 LAFbzgIt1EpnkMcldV3OjkoZL9nSochSiukTm1eR1t9NhHRW9l7LXmRn3MFmrIgomo
	 RW4IBgAZ3L4NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1989C80ADC;
	Mon, 24 Aug 2026 16:44:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D3A4396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B1C84036A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u3KLmWnwRAzG for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:28:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=MzMDjnFM
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 089894032B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:47 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69a33fb0031so579325a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585326; x=1788190126;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/TQHJVqyqNkgzJtT2kYZ7dmRO5Av+sI0L4cTFBOr1A=;
 b=MzMDjnFMz8OpsmHWOmGNJvjRYwM5vNrrLZPSXr35cWG0A/4YCRJmOEGBOavXKixdFF
 CbYV4BGWzz8xf8lmem9xGi4doRiTdbAkF6jfWmnKiywDKka9Az7Ki2eIw+U4HnxgjYsA
 MU3pVIGCp/km+BsjtThf4y+9NmatqORMFn+EzsDNauBgKqJLkpWMVfQ64XxEo3vjHJCh
 8j7GGoN3iI6PglC0Clcyq4yRdnnAj2R8LEZGwzwhGivhYESex7/JG4PV7I1hDr56yV1a
 Swr5vxSEhrRSoKDLHaYpmpnI7M/yKLprlQXgxVtKBT80NkN8DRzWl6BNTcFds0OElXcM
 pogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585326; x=1788190126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T/TQHJVqyqNkgzJtT2kYZ7dmRO5Av+sI0L4cTFBOr1A=;
 b=EZl4lvopBJj6jpEzTVFnlMnLc5VTGYBJgGwnV7PcIOT8LxT5d9Wvw9LcKXCh2/8Dwf
 5VhMKxZ6VTL2VWGAWUC08YUr9N57fOwf2ytERDjJI/01yiGzRqLFh8A5Vx2wAw+JYtSD
 ka4PsxRuh920X+cZts6xHAJXR9t1wx7K6A2EHelN5lh81gs4HHRy4aMx6OzupUp2crDS
 uucL8TYwdpS25Z0hpI64vG9p3KGY65c1C/cUasoD5jK6qlobVP2qb/2M/i2k0p2+60SL
 leC2M9VfWJ58mdVEb0EYUeUccnfKApKkcwlJoDHEGM40MidxnFfnJTPqTXA+NNA7oscn
 jdGg==
X-Gm-Message-State: AFuF++lw8lueu/n2E49h8YrLkB2JblcABkq73aZ8naGiyoaaeeRs4pcK
 AN/eC7UsjKl/eN9j2TIRFqEqMRlKU+PLMWCcZgQDJLyZE5VsO2F+xyPRpsfipH55Hsae3UKSjUv
 RY2Nm
X-Gm-Gg: AR+sD138ddubs7/R+N9P5llqy1WDoH5F8jyRACqAxiY334k7Il4UijgWEjHRamo6enG
 zDXzsmEqZtlpH5jO4qucZ9/3P394GDZT6VOKD1sWXxBuQQJHep+UceSitMsaC6c29Bxfhr/jWEm
 I1LH1QN5QdCE1Lct+Znwp3jKFpjUzVc2qN0jDh+X9YsOJ3XMrOqVA9rGFO17ZSR8WotKXVG1aa5
 p5dXep/odRbH1mJvZv8BvK9JnjdJfSvLwy+TiWpQRns7Gk45P9vc34ySxjhod9Q5AULg97wB8dt
 8YU7zw0L8ZBXNhmukT+P89V+fkdI0R1jHVnbddEiuW0ksa8Zxqo1bSLzuKYJKu1LabyT8uKq4Gk
 zM1+A3CZIon/SFqYu0MMzwUE5UdLXyt+lsmYTJ6yhfZZqtzCbesKRP8/STek7n41FUcptNMy4QC
 KC8saskCzDo6dyC+g7jQvhrmKEWvSioX0uGx4y/O5isKE2j1DtEEW2jWIyBYZ+e/TaxD4f3vHY4
 SK2z96CRNhn+S8OZwotww==
X-Received: by 2002:a05:6402:450d:b0:6a1:f95b:8cfa with SMTP id
 4fb4d7f45d1cf-6a42f1b47d8mr16434497a12.1.1787585325631; 
 Mon, 24 Aug 2026 08:28:45 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1cdbe9sm9209455a12.24.2026.08.24.08.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:28:45 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 10/63] usb: dwc3: import from kernel v4.6
Date: Mon, 24 Aug 2026 17:26:41 +0200
Message-ID: <20260824152734.159794-11-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.5 to v4.6.

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

List of commits: git log --oneline v4.5..v4.6
Commits imported:
9772b47a4c29 usb: dwc3: gadget: Fix suspend/resume during device mode
5c4ad318de3b usb: dwc3: core: fix PHY handling during suspend
e901aa159dac usb: dwc3: gadget: fix endpoint renaming
ad14d4e0308a usb: dwc3: gadget: release spin lock during gadget resume
f59dcab17629 usb: dwc3: core: improve reset sequence
77966eb85e6d usb: dwc3: Validate the maximum_speed parameter
7580862b3e80 usb: dwc3: Enable SuperSpeedPlus
2c7f1bd9127a usb: dwc3: Update maximum_speed for SuperSpeedPlus
ee5cd41c9117 usb: dwc3: Update speed checks for SuperSpeedPlus
1f38f88a24c8 usb: dwc3: Update register fields for SuperSpeedPlus
c4137a9c841e usb: dwc3: DWC_usb31 controller check

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 102 +++++++++++++++++++++++++-------------
 drivers/usb/dwc3/core.h   |  11 +++-
 drivers/usb/dwc3/ep0.c    |   9 ++--
 drivers/usb/dwc3/gadget.c |  47 ++++++++++++++----
 4 files changed, 119 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index de5e01f41bc2..34277ced26bd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -67,23 +67,9 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 static int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
+	int		retries = 1000;
 	int		ret;
 
-	/* Before Resetting PHY, put Core in Reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg |= DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-
-	/* Assert USB3 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	reg |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
-
-	/* Assert USB2 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	reg |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-
 	usb_phy_init(dwc->usb2_phy);
 	usb_phy_init(dwc->usb3_phy);
 	ret = phy_init(dwc->usb2_generic_phy);
@@ -95,26 +81,28 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 		phy_exit(dwc->usb2_generic_phy);
 		return ret;
 	}
-	mdelay(100);
 
-	/* Clear USB3 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	reg &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	/*
+	 * We're resetting only the device side because, if we're in host mode,
+	 * XHCI driver will reset the host block. If dwc3 was configured for
+	 * host-only mode, then we can return early.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST)
+		return 0;
 
-	/* Clear USB2 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	reg &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	reg |= DWC3_DCTL_CSFTRST;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
-	mdelay(100);
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			return 0;
 
-	/* After PHYs are stable we can take Core out of reset state */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg &= ~DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+		udelay(1);
+	} while (--retries);
 
-	return 0;
+	return -ETIMEDOUT;
 }
 
 /**
@@ -962,10 +950,6 @@ static int dwc3_probe(struct platform_device *pdev)
 		fladj = pdata->fladj_value;
 	}
 
-	/* default to superspeed if no maximum_speed passed */
-	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
-		dwc->maximum_speed = USB_SPEED_SUPER;
-
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -1016,6 +1000,33 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	/* Check the maximum_speed parameter */
+	switch (dwc->maximum_speed) {
+	case USB_SPEED_LOW:
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+	case USB_SPEED_SUPER_PLUS:
+		break;
+	default:
+		dev_err(dev, "invalid maximum_speed parameter %d\n",
+			dwc->maximum_speed);
+		/* fall through */
+	case USB_SPEED_UNKNOWN:
+		/* default to superspeed */
+		dwc->maximum_speed = USB_SPEED_SUPER;
+
+		/*
+		 * default to superspeed plus if we are capable.
+		 */
+		if (dwc3_is_usb31(dwc) &&
+		    (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
+		     DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
+			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
+
+		break;
+	}
+
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc, fladj);
 
@@ -1139,6 +1150,11 @@ static int dwc3_suspend(struct device *dev)
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	WARN_ON(phy_power_off(dwc->usb2_generic_phy) < 0);
+	WARN_ON(phy_power_off(dwc->usb3_generic_phy) < 0);
+
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -1152,11 +1168,21 @@ static int dwc3_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+	ret = phy_power_on(dwc->usb2_generic_phy);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_power_on(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err_usb2phy_power;
+
 	usb_phy_init(dwc->usb3_phy);
 	usb_phy_init(dwc->usb2_phy);
 	ret = phy_init(dwc->usb2_generic_phy);
 	if (ret < 0)
-		return ret;
+		goto err_usb3phy_power;
 
 	ret = phy_init(dwc->usb3_generic_phy);
 	if (ret < 0)
@@ -1189,6 +1215,12 @@ static int dwc3_resume(struct device *dev)
 err_usb2phy_init:
 	phy_exit(dwc->usb2_generic_phy);
 
+err_usb3phy_power:
+	phy_power_off(dwc->usb3_generic_phy);
+
+err_usb2phy_power:
+	phy_power_off(dwc->usb2_generic_phy);
+
 	return ret;
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e4f8b90d9627..6254b2ff9080 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -223,7 +223,8 @@
 /* Global HWPARAMS3 Register */
 #define DWC3_GHWPARAMS3_SSPHY_IFC(n)		((n) & 3)
 #define DWC3_GHWPARAMS3_SSPHY_IFC_DIS		0
-#define DWC3_GHWPARAMS3_SSPHY_IFC_ENA		1
+#define DWC3_GHWPARAMS3_SSPHY_IFC_GEN1		1
+#define DWC3_GHWPARAMS3_SSPHY_IFC_GEN2		2 /* DWC_usb31 only */
 #define DWC3_GHWPARAMS3_HSPHY_IFC(n)		(((n) & (3 << 2)) >> 2)
 #define DWC3_GHWPARAMS3_HSPHY_IFC_DIS		0
 #define DWC3_GHWPARAMS3_HSPHY_IFC_UTMI		1
@@ -249,6 +250,7 @@
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
 
 #define DWC3_DCFG_SPEED_MASK	(7 << 0)
+#define DWC3_DCFG_SUPERSPEED_PLUS (5 << 0)  /* DWC_usb31 only */
 #define DWC3_DCFG_SUPERSPEED	(4 << 0)
 #define DWC3_DCFG_HIGHSPEED	(0 << 0)
 #define DWC3_DCFG_FULLSPEED2	(1 << 0)
@@ -339,6 +341,7 @@
 
 #define DWC3_DSTS_CONNECTSPD		(7 << 0)
 
+#define DWC3_DSTS_SUPERSPEED_PLUS	(5 << 0) /* DWC_usb31 only */
 #define DWC3_DSTS_SUPERSPEED		(4 << 0)
 #define DWC3_DSTS_HIGHSPEED		(0 << 0)
 #define DWC3_DSTS_FULLSPEED2		(1 << 0)
@@ -1024,6 +1027,12 @@ struct dwc3_gadget_ep_cmd_params {
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
 
+/* check whether we are on the DWC_usb31 core */
+static inline bool dwc3_is_usb31(struct dwc3 *dwc)
+{
+	return !!(dwc->revision & DWC3_REVISION_IS_DWC31);
+}
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8d6b75c2f53b..eca2e6d8e041 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -356,7 +356,8 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		 */
 		usb_status |= dwc->gadget.is_selfpowered;
 
-		if (dwc->speed == DWC3_DSTS_SUPERSPEED) {
+		if ((dwc->speed == DWC3_DSTS_SUPERSPEED) ||
+		    (dwc->speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 			if (reg & DWC3_DCTL_INITU1ENA)
 				usb_status |= 1 << USB_DEV_STAT_U1_ENABLED;
@@ -426,7 +427,8 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 		case USB_DEVICE_U1_ENABLE:
 			if (state != USB_STATE_CONFIGURED)
 				return -EINVAL;
-			if (dwc->speed != DWC3_DSTS_SUPERSPEED)
+			if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
+			    (dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 				return -EINVAL;
 
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -440,7 +442,8 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 		case USB_DEVICE_U2_ENABLE:
 			if (state != USB_STATE_CONFIGURED)
 				return -EINVAL;
-			if (dwc->speed != DWC3_DSTS_SUPERSPEED)
+			if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
+			    (dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 				return -EINVAL;
 
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2363bad45af8..8e4a1b195e9b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -463,7 +463,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 		| DWC3_DEPCFG_MAX_PACKET_SIZE(usb_endpoint_maxp(desc));
 
 	/* Burst size is only needed in SuperSpeed mode */
-	if (dwc->gadget.speed == USB_SPEED_SUPER) {
+	if (dwc->gadget.speed >= USB_SPEED_SUPER) {
 		u32 burst = dep->endpoint.maxburst - 1;
 
 		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst);
@@ -568,7 +568,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
 		if (!usb_endpoint_xfer_isoc(desc))
-			return 0;
+			goto out;
 
 		/* Link TRB for ISOC. The HWO bit is never reset */
 		trb_st_hw = &dep->trb_pool[0];
@@ -582,9 +582,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
 	}
 
+out:
 	switch (usb_endpoint_type(desc)) {
 	case USB_ENDPOINT_XFER_CONTROL:
-		strlcat(dep->name, "-control", sizeof(dep->name));
+		/* don't change name */
 		break;
 	case USB_ENDPOINT_XFER_ISOC:
 		strlcat(dep->name, "-isoc", sizeof(dep->name));
@@ -1441,7 +1442,8 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 
 	speed = reg & DWC3_DSTS_CONNECTSPD;
-	if (speed == DWC3_DSTS_SUPERSPEED) {
+	if ((speed == DWC3_DSTS_SUPERSPEED) ||
+	    (speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
 		dwc3_trace(trace_dwc3_gadget, "no wakeup on SuperSpeed\n");
 		ret = -EINVAL;
 		goto out;
@@ -1666,10 +1668,16 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 		case USB_SPEED_HIGH:
 			reg |= DWC3_DSTS_HIGHSPEED;
 			break;
-		case USB_SPEED_SUPER:	/* FALLTHROUGH */
-		case USB_SPEED_UNKNOWN:	/* FALTHROUGH */
+		case USB_SPEED_SUPER_PLUS:
+			reg |= DWC3_DSTS_SUPERSPEED_PLUS;
+			break;
 		default:
-			reg |= DWC3_DSTS_SUPERSPEED;
+			dev_err(dwc->dev, "invalid dwc->maximum_speed (%d)\n",
+				dwc->maximum_speed);
+			/* fall through */
+		case USB_SPEED_SUPER:
+			reg |= DWC3_DCFG_SUPERSPEED;
+			break;
 		}
 	}
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
@@ -2340,7 +2348,8 @@ static void dwc3_update_ram_clk_sel(struct dwc3 *dwc, u32 speed)
 	 * this. Maybe it becomes part of the power saving plan.
 	 */
 
-	if (speed != DWC3_DSTS_SUPERSPEED)
+	if ((speed != DWC3_DSTS_SUPERSPEED) &&
+	    (speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return;
 
 	/*
@@ -2369,6 +2378,11 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	dwc3_update_ram_clk_sel(dwc, speed);
 
 	switch (speed) {
+	case DWC3_DCFG_SUPERSPEED_PLUS:
+		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		dwc->gadget.ep0->maxpacket = 512;
+		dwc->gadget.speed = USB_SPEED_SUPER_PLUS;
+		break;
 	case DWC3_DCFG_SUPERSPEED:
 		/*
 		 * WORKAROUND: DWC3 revisions <1.90a have an issue which
@@ -2410,8 +2424,9 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 	/* Enable USB2 LPM Capability */
 
-	if ((dwc->revision > DWC3_REVISION_194A)
-			&& (speed != DWC3_DCFG_SUPERSPEED)) {
+	if ((dwc->revision > DWC3_REVISION_194A) &&
+	    (speed != DWC3_DCFG_SUPERSPEED) &&
+	    (speed != DWC3_DCFG_SUPERSPEED_PLUS)) {
 		reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 		reg |= DWC3_DCFG_LPM_CAP;
 		dwc3_writel(dwc->regs, DWC3_DCFG, reg);
@@ -2473,7 +2488,11 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 	 * implemented.
 	 */
 
-	dwc->gadget_driver->resume(&dwc->gadget);
+	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+		spin_unlock(&dwc->lock);
+		dwc->gadget_driver->resume(&dwc->gadget);
+		spin_lock(&dwc->lock);
+	}
 }
 
 static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
@@ -2917,6 +2936,9 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	if (!dwc->gadget_driver)
+		return 0;
+
 	if (dwc->pullups_connected) {
 		dwc3_gadget_disable_irq(dwc);
 		dwc3_gadget_run_stop(dwc, true, true);
@@ -2935,6 +2957,9 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	struct dwc3_ep		*dep;
 	int			ret;
 
+	if (!dwc->gadget_driver)
+		return 0;
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
-- 
2.53.0

