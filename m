Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8942C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BEC3409A0;
	Fri, 21 Aug 2026 13:12:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B7s4xbEjLyW2; Fri, 21 Aug 2026 13:12:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317956;
	bh=eIYH8Qp4+7HtWquJXaPRoZK1lq59woUmNkEcdi2hZLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b/fiBS8iCXo90VoCdmqt3uNm1ibOHD7k45qKUMjY4jiNB/9Ktfz4O+8IIEi17BkxK
	 +lPyaYGn5FkIvZxEmOroYkCGCwnjzEqbo4pYE3aF3zv2oYnyjqbwIVZsK7EqzuhmUw
	 +RU/r9AUAUsXZRg3BmHu87dEmO3ZfZ/Wt1zCaVKCxKXqAm/yVo6CWOgSHIb5UYFJhK
	 7OPIpchfnwUuMEf7VH255JK0WlZ1FXTNQA1hrSAhrByHuv7Ko9vQweyHWicKrE1op5
	 bhAM+Znemd90j1wB9xOFcr3wIFRsAajJoTRxSAXBGLlsYQCPXSs2uv68u7XjjTiH3I
	 rmd/j76ABvcaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96AD940A09;
	Fri, 21 Aug 2026 13:12:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E24D62B2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D425240090
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K22Uclaq_iPV for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Lv6MIqgG
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E1274006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:20 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c1676497000so7265466b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302278; x=1787907078;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eIYH8Qp4+7HtWquJXaPRoZK1lq59woUmNkEcdi2hZLo=;
 b=Lv6MIqgG+jb2cXVmFCN59acofaEgRv+TppPdBMTDX+Nn5UB2TaCnfYC4pwEH+g3nej
 vtX1xkzGq2V9M+xCPE2B6Vy1N4sAIKeghUbPfo+AUe1KB0+NazEnxSPQkWwNpvMZh3TG
 Dw1kuEDY1ug09jFmmLnw6kyjU/cj72tea8dHFnRoUkJIDnt7oSTXBVgr/aO4sPjXKRZ8
 kQA10JFhvq0X7jRu60RSUNMtRqgvcWDTHC3BYKC7OUOAcdQ/ulT70EMcGsTIQUQZ8Cws
 b35hEPaq2oFA2FwkFI8pTf9rI7MFDnN/2COt1dkLX/GtVk8+EhTLlOrf1BY4oaQ2Dt7f
 +/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302278; x=1787907078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eIYH8Qp4+7HtWquJXaPRoZK1lq59woUmNkEcdi2hZLo=;
 b=jFEtriWUD/SiQmBoTY3rqJYH30E2ZStNeBMoQDu2mZERPL8ZHOWoD6vI9yTprSuEuC
 sympwWrOmlNAZY+qQWdAQfmrbUTBgcxuX9U8yEHur5V+/favllMh6x+yjjoA4Zyasp07
 U4EDf4jJ/pXPzom7K5eQyH4dle+Q0NBjoX3cn3JxEeYf+hCdHx8/MLashp0H1Y+7sWz9
 mMtTkSIkSBi5xC7nTeW+TQ9qR2Y8mhzto9lWzmlnTl/JrJHBztvxstA9Sd7P72Gl4kIX
 qcgx7RU4L8F0+eugPwQeCilePGII8JdUtNXSBZNyz16aJim1NRVAhDfmtTfRyQEQlAvS
 51zA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqhe8veY5n61ptS5gJ7QJ9rqAbNo/2u3Lq65r+WxXtrsyndBXWyYB+VVst4hBkolPMqY4RpPcs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m/iL/C3RDsL85lYXc/t1X/OC35t2Exp4RJTkXM9cNA+L8PsWpb
 n72vkMRw4eqMbfnSVh5rGfwMNNudUqShFT20GFEd6n2YZfYk9Mzs6SxDzq3eYjRKMiA=
X-Gm-Gg: AR+sD121rbiDDpOQuFY53AyxrM0P11yItlghZYt3tQkZ6AHL60qio2ZbHpgKBk9I9Eb
 6D+Xo8jB49Hz7yHAIn/fOjc+1SXMp3oc1INN9tYqe2nTr9K58ndR/oumwBes6DYAr+qf+QwFhp0
 1q18TqkhSEtjXC125MHHGxG02rgttcoHVRiDeXzYDkHhDMKf2lnsk4ENfskARxlSFVyd9hIeOJ1
 lxc+l/BnI1avJxAJbImqEADBym2fGbM5XS4OzuCpn4y8YBAbO9vMMqLVKXIEkg9hhYZ7oWsOSxR
 9FGtGIRJiDhnXvrTLj7hz61YEI/cZucPoKf8TrNO0739hBr9okIwxmrCbOtLrTyomfNgl692CP4
 3HEg2jB7z/zkpMUp6pVpLxLbJs2iumxZwNlpuMG5lgVpOwEgCfDyaeYkecESvQzwIke2lGpaZ9Q
 TRQ/hq91uJqv+1grAfsnFMftEpiCvDSsQCRbW/L/LmNePQ2NVzIhneE/xFIRp5H/QKCIj0O3pRb
 gUaHNtChvD4iSGumyLCHur1
X-Received: by 2002:a17:907:84e:b0:c20:7897:bc67 with SMTP id
 a640c23a62f3a-c246a6a8e0bmr250983966b.3.1787302278153; 
 Fri, 21 Aug 2026 01:51:18 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591df448sm351930166b.43.2026.08.21.01.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:17 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 20/87] usb: dwc3: import from kernel v4.16
Date: Fri, 21 Aug 2026 10:46:56 +0200
Message-ID: <20260821084829.2070426-21-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

Sync Linux kernel dwc3 changes from v4.15 to v4.16.

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

List of commits: git log --oneline v4.15..v4.16
Commits imported:
084a804e0120 usb: dwc3: Fix lock-up on ID change during system suspend/resume
98112041bcca usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init during suspend/resume
b16ea8b9492e usb: dwc3: Fix GDBGFIFOSPACE_TYPE values
c4a5153e87fd usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode
00b42170c86f usb: dwc3: Undo PHY init if soft reset fails
f035d139ffec usb: dwc3: ep0: Reset TRB counter for ep0 IN
6180026341e8 usb: dwc3: gadget: Set maxpacket size for ep0 IN
d8c80bb3b55b phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800
42bf02ec6e42 usb: dwc3: Allow disabling of metastability workaround
19e0b203bfbd usb: dwc3: ep0: use gadget->isoch_delay for isoch_delay value
0c5d2954f690 usb: dwc3: debug: decode a few more features

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 93 ++++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/core.h   | 26 +++++++----
 drivers/usb/dwc3/debug.h  |  9 ++++
 drivers/usb/dwc3/ep0.c    | 13 +++---
 drivers/usb/dwc3/gadget.c |  8 +++-
 5 files changed, 106 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 07832509584f..e94bf91cc58a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -100,6 +100,8 @@ static void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	dwc->current_dr_role = mode;
 }
 
 static void __dwc3_set_mode(struct work_struct *work)
@@ -133,8 +135,6 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
 
-	dwc->current_dr_role = dwc->desired_dr_role;
-
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	switch (dwc->desired_dr_role) {
@@ -147,6 +147,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
 			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+			phy_calibrate(dwc->usb2_generic_phy);
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -174,7 +175,7 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 	dwc->desired_dr_role = mode;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	queue_work(system_power_efficient_wq, &dwc->drd_work);
+	queue_work(system_freezable_wq, &dwc->drd_work);
 }
 
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
@@ -218,7 +219,7 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	 * XHCI driver will reset the host block. If dwc3 was configured for
 	 * host-only mode, then we can return early.
 	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST)
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -233,6 +234,9 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 		udelay(1);
 	} while (--retries);
 
+	phy_exit(dwc->usb3_generic_phy);
+	phy_exit(dwc->usb2_generic_phy);
+
 	return -ETIMEDOUT;
 }
 
@@ -482,6 +486,22 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 	parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
 }
 
+static int dwc3_core_ulpi_init(struct dwc3 *dwc)
+{
+	int intf;
+	int ret = 0;
+
+	intf = DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3);
+
+	if (intf == DWC3_GHWPARAMS3_HSPHY_IFC_ULPI ||
+	    (intf == DWC3_GHWPARAMS3_HSPHY_IFC_UTMI_ULPI &&
+	     dwc->hsphy_interface &&
+	     !strncmp(dwc->hsphy_interface, "ulpi", 4)))
+		ret = dwc3_ulpi_init(dwc);
+
+	return ret;
+}
+
 /**
  * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -493,7 +513,6 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
 	u32 reg;
-	int ret;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
@@ -564,9 +583,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		}
 		/* FALLTHROUGH */
 	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
-		ret = dwc3_ulpi_init(dwc);
-		if (ret)
-			return ret;
 		/* FALLTHROUGH */
 	default:
 		break;
@@ -723,6 +739,7 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 }
 
 static int dwc3_core_get_phy(struct dwc3 *dwc);
+static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
@@ -754,17 +771,27 @@ static int dwc3_core_init(struct dwc3 *dwc)
 			dwc->maximum_speed = USB_SPEED_HIGH;
 	}
 
-	ret = dwc3_core_get_phy(dwc);
+	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		goto err0;
 
-	ret = dwc3_core_soft_reset(dwc);
-	if (ret)
-		goto err0;
+	if (!dwc->ulpi_ready) {
+		ret = dwc3_core_ulpi_init(dwc);
+		if (ret)
+			goto err0;
+		dwc->ulpi_ready = true;
+	}
 
-	ret = dwc3_phy_setup(dwc);
+	if (!dwc->phys_ready) {
+		ret = dwc3_core_get_phy(dwc);
+		if (ret)
+			goto err0a;
+		dwc->phys_ready = true;
+	}
+
+	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
-		goto err0;
+		goto err0a;
 
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
@@ -837,6 +864,9 @@ err1:
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
+err0a:
+	dwc3_ulpi_exit(dwc);
+
 err0:
 	return ret;
 }
@@ -915,7 +945,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc->current_dr_role = DWC3_GCTL_PRTCAP_DEVICE;
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 
 		if (dwc->usb2_phy)
@@ -931,7 +960,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_HOST:
-		dwc->current_dr_role = DWC3_GCTL_PRTCAP_HOST;
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
 
 		if (dwc->usb2_phy)
@@ -945,6 +973,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 				dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
+		phy_calibrate(dwc->usb2_generic_phy);
 		break;
 	case USB_DR_MODE_OTG:
 		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
@@ -1062,6 +1091,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
 				 &dwc->fladj);
 
+	dwc->dis_metastability_quirk = device_property_read_bool(dev,
+				"snps,dis_metastability_quirk");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -1229,7 +1261,6 @@ err4:
 
 err3:
 	dwc3_free_event_buffers(dwc);
-	dwc3_ulpi_exit(dwc);
 
 err2:
 	pm_runtime_allow(&pdev->dev);
@@ -1279,7 +1310,7 @@ static int dwc3_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int dwc3_suspend_common(struct dwc3 *dwc)
+static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 
@@ -1291,6 +1322,10 @@ static int dwc3_suspend_common(struct dwc3 *dwc)
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
+		/* do nothing during host runtime_suspend */
+		if (!PMSG_IS_AUTO(msg))
+			dwc3_core_exit(dwc);
+		break;
 	default:
 		/* do nothing */
 		break;
@@ -1299,7 +1334,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc)
 	return 0;
 }
 
-static int dwc3_resume_common(struct dwc3 *dwc)
+static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 	int		ret;
@@ -1315,6 +1350,13 @@ static int dwc3_resume_common(struct dwc3 *dwc)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
+		/* nothing to do on host runtime_resume */
+		if (!PMSG_IS_AUTO(msg)) {
+			ret = dwc3_core_init(dwc);
+			if (ret)
+				return ret;
+		}
+		break;
 	default:
 		/* do nothing */
 		break;
@@ -1326,12 +1368,11 @@ static int dwc3_resume_common(struct dwc3 *dwc)
 static int dwc3_runtime_checks(struct dwc3 *dwc)
 {
 	switch (dwc->current_dr_role) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
+	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (dwc->connected)
 			return -EBUSY;
 		break;
-	case USB_DR_MODE_HOST:
+	case DWC3_GCTL_PRTCAP_HOST:
 	default:
 		/* do nothing */
 		break;
@@ -1348,7 +1389,7 @@ static int dwc3_runtime_suspend(struct device *dev)
 	if (dwc3_runtime_checks(dwc))
 		return -EBUSY;
 
-	ret = dwc3_suspend_common(dwc);
+	ret = dwc3_suspend_common(dwc, PMSG_AUTO_SUSPEND);
 	if (ret)
 		return ret;
 
@@ -1364,7 +1405,7 @@ static int dwc3_runtime_resume(struct device *dev)
 
 	device_init_wakeup(dev, false);
 
-	ret = dwc3_resume_common(dwc);
+	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
 	if (ret)
 		return ret;
 
@@ -1411,7 +1452,7 @@ static int dwc3_suspend(struct device *dev)
 	struct dwc3	*dwc = dev_get_drvdata(dev);
 	int		ret;
 
-	ret = dwc3_suspend_common(dwc);
+	ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
 	if (ret)
 		return ret;
 
@@ -1427,7 +1468,7 @@ static int dwc3_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = dwc3_resume_common(dwc);
+	ret = dwc3_resume_common(dwc, PMSG_RESUME);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4a4a4c98508c..860d2bc184d1 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -158,13 +158,15 @@
 #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
 #define DWC3_GDBGFIFOSPACE_SPACE_AVAILABLE(n) (((n) >> 16) & 0xffff)
 
-#define DWC3_TXFIFOQ		1
-#define DWC3_RXFIFOQ		3
-#define DWC3_TXREQQ		5
-#define DWC3_RXREQQ		7
-#define DWC3_RXINFOQ		9
-#define DWC3_DESCFETCHQ		13
-#define DWC3_EVENTQ		15
+#define DWC3_TXFIFOQ		0
+#define DWC3_RXFIFOQ		1
+#define DWC3_TXREQQ		2
+#define DWC3_RXREQQ		3
+#define DWC3_RXINFOQ		4
+#define DWC3_PSTATQ		5
+#define DWC3_DESCFETCHQ		6
+#define DWC3_EVENTQ		7
+#define DWC3_AUXEVENTQ		8
 
 /* Global RX Threshold Configuration Register */
 #define DWC3_GRXTHRCFG_MAXRXBURSTSIZE(n) (((n) & 0x1f) << 19)
@@ -795,8 +797,9 @@ struct dwc3_scratchpad_array {
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
+ * @phys_ready: flag to indicate that PHYs are ready
  * @ulpi: pointer to ulpi interface
- * @isoch_delay: wValue from Set Isochronous Delay request;
+ * @ulpi_ready: flag to indicate that ULPI is initialized
  * @u2sel: parameter from Set SEL request.
  * @u2pel: parameter from Set SEL request.
  * @u1sel: parameter from Set SEL request.
@@ -857,6 +860,7 @@ struct dwc3_scratchpad_array {
  * 	1	- -3.5dB de-emphasis
  * 	2	- No de-emphasis
  * 	3	- Reserved
+ * @dis_metastability_quirk: set to disable metastability quirk.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *                 increments or 0 to disable.
  */
@@ -893,7 +897,10 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	bool			phys_ready;
+
 	struct ulpi		*ulpi;
+	bool			ulpi_ready;
 
 	void __iomem		*regs;
 	size_t			regs_size;
@@ -955,7 +962,6 @@ struct dwc3 {
 	enum dwc3_ep0_state	ep0state;
 	enum dwc3_link_state	link_state;
 
-	u16			isoch_delay;
 	u16			u2sel;
 	u16			u2pel;
 	u8			u1sel;
@@ -1010,6 +1016,8 @@ struct dwc3 {
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
 
+	unsigned		dis_metastability_quirk:1;
+
 	u16			imod_interval;
 };
 
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 368f8e59219a..bfb90c52d8fc 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -247,6 +247,15 @@ static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,
 				case USB_DEVICE_TEST_MODE:
 					s = "Test Mode";
 					break;
+				case USB_DEVICE_U1_ENABLE:
+					s = "U1 Enable";
+					break;
+				case USB_DEVICE_U2_ENABLE:
+					s = "U2 Enable";
+					break;
+				case USB_DEVICE_LTM_ENABLE:
+					s = "LTM Enable";
+					break;
 				default:
 					s = "UNKNOWN";
 				} s; }),
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index fd3e7ad2eb0e..18be31d5743a 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -736,11 +736,7 @@ static int dwc3_ep0_set_isoch_delay(struct dwc3 *dwc, struct usb_ctrlrequest *ct
 	if (wIndex || wLength)
 		return -EINVAL;
 
-	/*
-	 * REVISIT It's unclear from Databook what to do with this
-	 * value. For now, just cache it.
-	 */
-	dwc->isoch_delay = wValue;
+	dwc->gadget.isoch_delay = wValue;
 
 	return 0;
 }
@@ -858,7 +854,12 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 		trb++;
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		trace_dwc3_complete_trb(ep0, trb);
-		ep0->trb_enqueue = 0;
+
+		if (r->direction)
+			dwc->eps[1]->trb_enqueue = 0;
+		else
+			dwc->eps[0]->trb_enqueue = 0;
+
 		dwc->ep0_bounced = false;
 	}
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 639dd1b163a0..2bda4eb1e9ac 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2005,7 +2005,8 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
 	 * STAR#9000525659: Clock Domain Crossing on DCTL in
 	 * USB 2.0 Mode
 	 */
-	if (dwc->revision < DWC3_REVISION_220A) {
+	if (dwc->revision < DWC3_REVISION_220A &&
+	    !dwc->dis_metastability_quirk) {
 		reg |= DWC3_DCFG_SUPERSPEED;
 	} else {
 		switch (speed) {
@@ -2744,6 +2745,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		break;
 	}
 
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget.ep0->maxpacket;
+
 	/* Enable USB2 LPM Capability */
 
 	if ((dwc->revision > DWC3_REVISION_194A) &&
@@ -3224,7 +3227,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	 * is less than super speed because we don't have means, yet, to tell
 	 * composite.c that we are USB 2.0 + LPM ECN.
 	 */
-	if (dwc->revision < DWC3_REVISION_220A)
+	if (dwc->revision < DWC3_REVISION_220A &&
+	    !dwc->dis_metastability_quirk)
 		dev_info(dwc->dev, "changing max_speed on rev %08x\n",
 				dwc->revision);
 
-- 
2.53.0

