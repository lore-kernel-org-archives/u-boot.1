Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF723C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA63A40C3E;
	Fri, 21 Aug 2026 13:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XWlCxv22E6t; Fri, 21 Aug 2026 13:15:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318101;
	bh=9Yhe84Vlg/9d4n5x5x0RQqTZ8TeiWxB8ioVv3/MYi+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W+zUriy2H6IVuS1lg9qmaWaWUJXbGddKcTp0O+EK6fxqPqZuPmq+WvSdT1DmIq3kw
	 RPYjB8WAJufeI039ADkc1tXd39GJ2SypEzL3v5prJFxmPnjmXHZR5FjgsSn3+DLO6W
	 Jt34fkqg1giieyqQz0xkjSZwWfKKEkHDbk6KcTlEVpQ2+EktTZWqtTlbJ2aPJue6/R
	 RtnlLUp30rYgWD/72kA/32pb6kPkkLK91+pzZwo5J925y7wzjt2Pp8cBsL1yUYQnxY
	 6TdIobDiulva1k9JpRMlCP0tIR38olAeosF2BXuLo2xk0hWBAxc5YjXIiQTGOANPAN
	 2rnjWRwDAiFYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A510240D55;
	Fri, 21 Aug 2026 13:15:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0229476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9248940071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WCYxFeZ487x0 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=wqdvBipB
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DD814006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:16 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a3ec9ef8d4so145544a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302334; x=1787907134;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Yhe84Vlg/9d4n5x5x0RQqTZ8TeiWxB8ioVv3/MYi+4=;
 b=wqdvBipBj0HGCWo8FTet9dZ/lSXAxVPwEg0sQGs8Qsgi5Bq6PP1PUHxBitFn0pKlEq
 bKAwiAPRcAMSBDe7+K4Fy5dzySUFT94ZA4CNUW8anDNg9YTDQxFSAA/LE5/onRo+REM0
 EX+MO77bm5aYq9tXNr3yFiaLWCOaI/+toahZZMvAA65UHA1O4lwfWrII41+2mlyRZkIA
 Wf/zxgzOnTIr28OqrGY7eDaneG3xGeVRCpkRElQghySZh+EMpb/cd4xV/InaqNJLWlKp
 s2GIGzw/3mPMqQ/CDOMEN0Rpnck47hxzZRjRX36udpJMNHJi0b8nVDbHphIpXEMQMAOj
 NGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302334; x=1787907134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Yhe84Vlg/9d4n5x5x0RQqTZ8TeiWxB8ioVv3/MYi+4=;
 b=buRKhXj97JSYN0yEk2darITYnbYll6+bZnb+vmHJoCwmuxW3ggoeusmiu3ldG9n8i5
 o9KavxOZfyefNRqJMN8xGsJrL6/V7sOafJrHMfIxKsF4qpluvStbqrP9tFK8UujD02i6
 HhLxXgZGuEycqjIfTfuspLt+qIZjKbTxkXBrVHZ2Zv4nHtxZGcaOC9aA+J7vRpNyx0RY
 de0F3vX+oSTVeKBsBfZoWNqe6duI0l90xZ+494gLp7Jga2U+T2N1ulvj4apLmfsfBRVd
 lNLqSpdWdCP9kEYiI79eSolEjGdAZWhTlaZnYwrIUTovNqbSprlFAqdo+xieintaS+Kj
 4XlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXgZOBcPUKnEZfu518i3r6LT2PupPH6SDp89x8ERrh1FAlgiRzj0gIVTHurIEKjC7AputfMAw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lmThSDJ4Qx71bXHR7olMio89NQT2UKGBYLnP/tlJTdVExE0slo
 JkRbhN8IidEcqoA9KFfuRo5m5/53wQMMSMPkzBjyILMGTaGy4YdQVm8xoW2NswdDI38=
X-Gm-Gg: AR+sD10Vshkqaxgb4NOpVfLBfB6pHngci6ucCLRjuos1nQ3DWUZ8glMKKPS/xxrDjBu
 fK+NvifbKD+YODPsumumPllIJO5sxfq1IIMg3DHiPbwgLn0Mor7saueJkslqsZl4grTsvnjg0Cm
 uSfrnASoxb+o3RZDwuAZ8ZEqeJVdN6O0Pxmthz3TNHjbB2S9TnUWqcx47YyuVk4DOnicomvLFGh
 GrtCHw3wf8pQJHbLF026JsyXHUqp3OiqhIiBQdRpFJ+/6bBHrQ940p/bVT6Wb9AG88Je5nTtqbF
 AqBY1M0bi2KOxfwuinLarn/DReNAmBMSKs0Ft7qa1xJT4CFIqBLta9YFSYf3FKahAOlyeRq1CZt
 8DumjkLaKPo1uSn68iXOikuyTq+hq4+TFPo8rrJ7qOKceuGv9awV4IDmuRjrOfxzwteQoj4JhhY
 LKw+h5nyRVimkZLYenMTIFqzHQDPU4y4Tomai91hRjjil7BE7G4zFTeJE0+xFc2q+QdIWKi69sj
 gItRrTvevaEhoDmV9mx5dxG
X-Received: by 2002:a05:6402:249c:b0:6a2:9c3:6926 with SMTP id
 4fb4d7f45d1cf-6a42f1bcc81mr2545499a12.1.1787302333886; 
 Fri, 21 Aug 2026 01:52:13 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff170601sm5260257a12.25.2026.08.21.01.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:13 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 59/87] usb: dwc3: import from kernel v6.14
Date: Fri, 21 Aug 2026 10:47:35 +0200
Message-ID: <20260821084829.2070426-60-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.13 to v6.14.

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

List of commits: git log --oneline v6.13..v6.14
Commits imported:
cc5bfc4e16fc usb: dwc3: Set SUSPENDENABLE soon after phy init
69c58deec196 usb: dwc3: gadget: Prevent irq storm when TH re-executes
d3a8c28426fc usb: dwc3: Fix timeout issue during controller enter/exit from halt state
1ed3af5a2aae usb: dwc3: Document nostream_work
66e0ea341a2a usb: dwc3: core: Defer the probe until USB power supply ready
dcfe437492e2 usb: dwc3: gadget: Reinitiate stream for all host NoStream behavior
a266462b937b usb: dwc3-am62: Fix an OF node leak in phy_syscon_pll_refclk()
e3a9bd247cdd usb: dwc3: Skip resume if pm_runtime_set_active() fails
1ff24d40b3c3 usb: dwc3: gadget: Fix incorrect UDC state after manual deconfiguration
31d500c2d0d4 usb: dwc3: dwc3-am62: Re-initialize controller if lost power in PM suspend
04d5b4c23f3b usb: dwc3: core: Disable USB2 retry for DWC_usb31 1.80a and prior
686d4a2c26b4 usb: dwc3: remove unused sg struct member

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c      | 140 ++++++++++++++++++++-----------
 drivers/usb/dwc3/core.h      |   8 +-
 drivers/usb/dwc3/dwc3-am62.c |  83 +++++++++++++------
 drivers/usb/dwc3/gadget.c    | 155 ++++++++++++++++++++++-------------
 4 files changed, 254 insertions(+), 132 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f219c82e9619..66a08b527165 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -131,11 +131,24 @@ void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 	}
 }
 
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
 {
+	unsigned int hw_mode;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+
+	 /*
+	  * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE and
+	  * GUSB2PHYCFG.SUSPHY should be cleared during mode switching,
+	  * and they can be set after core initialization.
+	  */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD && !ignore_susphy) {
+		if (DWC3_GCTL_PRTCAP(reg) != mode)
+			dwc3_enable_susphy(dwc, false);
+	}
+
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -216,7 +229,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	dwc3_set_prtcap(dwc, desired_dr_role);
+	dwc3_set_prtcap(dwc, desired_dr_role, false);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -658,16 +671,7 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 	 */
 	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
 
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
-	 * cleared after power-on reset, and it can be set after core
-	 * initialization.
-	 */
+	/* Ensure the GUSB3PIPECTL.SUSPENDENABLE is cleared prior to phy init. */
 	reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	if (dwc->u2ss_inp3_quirk)
@@ -747,15 +751,7 @@ static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
 		break;
 	}
 
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
-	 * after power-on reset, and it can be set after core initialization.
-	 */
+	/* Ensure the GUSB2PHYCFG.SUSPHY is cleared prior to phy init. */
 	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	if (dwc->dis_enblslpm_quirk)
@@ -830,6 +826,25 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 			goto err_exit_usb3_phy;
 	}
 
+	/*
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY to '0' during
+	 * coreConsultant configuration. So default value will be '0' when the
+	 * core is reset. Application needs to set it to '1' after the core
+	 * initialization is completed.
+	 *
+	 * Certain phy requires to be in P0 power state during initialization.
+	 * Make sure GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY are clear
+	 * prior to phy init to maintain in the P0 state.
+	 *
+	 * After phy initialization, some phy operations can only be executed
+	 * while in lower P states. Ensure GUSB3PIPECTL.SUSPENDENABLE and
+	 * GUSB2PHYCFG.SUSPHY are set soon after initialization to avoid
+	 * blocking phy ops.
+	 */
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
+		dwc3_enable_susphy(dwc, true);
+
 	return 0;
 
 err_exit_usb3_phy:
@@ -1479,6 +1494,26 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		}
 	}
 
+	/*
+	 * STAR 9001346572: This issue affects DWC_usb31 versions 1.80a and
+	 * prior. When an active endpoint not currently cached in the host
+	 * controller is chosen to be cached to the same index as an endpoint
+	 * receiving NAKs, the endpoint receiving NAKs enters continuous
+	 * retry mode. This prevents it from being evicted from the host
+	 * controller cache, blocking the new endpoint from being cached and
+	 * serviced.
+	 *
+	 * To resolve this, for controller versions 1.70a and 1.80a, set the
+	 * GUCTL3 bit[16] (USB2.0 Internal Retry Disable) to 1. This bit
+	 * disables the USB2.0 internal retry feature. The GUCTL3[16] register
+	 * function is available only from version 1.70a.
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC31, 170A, 180A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+		reg |= DWC3_GUCTL3_USB20_RETRY_DISABLE;
+		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+	}
+
 	return 0;
 
 err_power_off_phy:
@@ -1568,7 +1603,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
@@ -1580,7 +1615,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 			return dev_err_probe(dev, ret, "failed to initialize gadget\n");
 		break;
 	case USB_DR_MODE_HOST:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
@@ -1625,7 +1660,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	}
 
 	/* de-assert DRVVBUS for HOST and OTG mode */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
 static void dwc3_get_software_properties(struct dwc3 *dwc)
@@ -1664,8 +1699,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_thr_num_pkt_prd = 0;
 	u8			tx_max_burst_prd = 0;
 	u8			tx_fifo_resize_max_num;
-	const char		*usb_psy_name;
-	int			ret;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xf;
@@ -1700,13 +1733,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
 
-	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
-	if (ret >= 0) {
-		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
-		if (!dwc->usb_psy)
-			dev_err(dev, "couldn't get usb power supply\n");
-	}
-
 	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
 	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
@@ -1824,8 +1850,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
 	dwc->tx_max_burst_prd = tx_max_burst_prd;
 
-	dwc->imod_interval = 0;
-
 	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
 }
 
@@ -1843,21 +1867,19 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	unsigned int hwparam_gen =
 		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
 
-	/* Check for proper value of imod_interval */
-	if (dwc->imod_interval && !dwc3_has_imod(dwc)) {
-		dev_warn(dwc->dev, "Interrupt moderation not supported\n");
-		dwc->imod_interval = 0;
-	}
-
 	/*
+	 * Enable IMOD for all supporting controllers.
+	 *
+	 * Particularly, DWC_usb3 v3.00a must enable this feature for
+	 * the following reason:
+	 *
 	 * Workaround for STAR 9000961433 which affects only version
 	 * 3.00a of the DWC_usb3 core. This prevents the controller
 	 * interrupt from being masked while handling events. IMOD
 	 * allows us to work around this issue. Enable it for the
 	 * affected version.
 	 */
-	if (!dwc->imod_interval &&
-	    DWC3_VER_IS(DWC3, 300A))
+	if (dwc3_has_imod((dwc)))
 		dwc->imod_interval = 1;
 
 	/* Check the maximum_speed parameter */
@@ -2109,6 +2131,23 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 	return 0;
 }
 
+static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
+{
+	struct power_supply *usb_psy;
+	const char *usb_psy_name;
+	int ret;
+
+	ret = device_property_read_string(dwc->dev, "usb-psy-name", &usb_psy_name);
+	if (ret < 0)
+		return NULL;
+
+	usb_psy = power_supply_get_by_name(usb_psy_name);
+	if (!usb_psy)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return usb_psy;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -2165,6 +2204,10 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_software_properties(dwc);
 
+	dwc->usb_psy = dwc3_get_usb_power_supply(dwc);
+	if (IS_ERR(dwc->usb_psy))
+		return dev_err_probe(dev, PTR_ERR(dwc->usb_psy), "couldn't get usb power supply\n");
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
@@ -2425,7 +2468,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (ret)
 			return ret;
 
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 		dwc3_gadget_resume(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -2433,7 +2476,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, true);
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
@@ -2462,7 +2505,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (ret)
 			return ret;
 
-		dwc3_set_prtcap(dwc, dwc->current_dr_role);
+		dwc3_set_prtcap(dwc, dwc->current_dr_role, true);
 
 		dwc3_otg_init(dwc);
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
@@ -2589,12 +2632,15 @@ static int dwc3_resume(struct device *dev)
 	pinctrl_pm_select_default_state(dev);
 
 	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		goto out;
 
 	ret = dwc3_resume_common(dwc, PMSG_RESUME);
 	if (ret)
 		pm_runtime_set_suspended(dev);
 
+out:
 	pm_runtime_enable(dev);
 
 	return ret;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f11570c8ffd0..aaa39e663f60 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -425,6 +425,7 @@
 
 /* Global User Control Register 3 */
 #define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
+#define DWC3_GUCTL3_USB20_RETRY_DISABLE		BIT(16)
 
 /* Device Configuration Register */
 #define DWC3_DCFG_NUMLANES(n)	(((n) & 0x3) << 30) /* DWC_usb32 only */
@@ -716,6 +717,7 @@ struct dwc3_event_buffer {
 /**
  * struct dwc3_ep - device side endpoint representation
  * @endpoint: usb endpoint
+ * @nostream_work: work for handling bulk NoStream
  * @cancelled_list: list of cancelled requests for this endpoint
  * @pending_list: list of pending requests for this endpoint
  * @started_list: list of started requests on this endpoint
@@ -742,6 +744,7 @@ struct dwc3_event_buffer {
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
+	struct delayed_work	nostream_work;
 	struct list_head	cancelled_list;
 	struct list_head	pending_list;
 	struct list_head	started_list;
@@ -764,7 +767,7 @@ struct dwc3_ep {
 #define DWC3_EP_WAIT_TRANSFER_COMPLETE	BIT(7)
 #define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
 #define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
-#define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
+#define DWC3_EP_STREAM_PRIMED		BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
 #define DWC3_EP_DELAY_STOP             BIT(13)
@@ -957,7 +960,6 @@ struct dwc3_request {
 	struct usb_request	request;
 	struct list_head	list;
 	struct dwc3_ep		*dep;
-	struct scatterlist	*sg;
 	struct scatterlist	*start_sg;
 
 	unsigned int		num_pending_sgs;
@@ -1556,7 +1558,7 @@ struct dwc3_gadget_ep_cmd_params {
 #define DWC3_HAS_OTG			BIT(3)
 
 /* prototypes */
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 7d43da5f2897..c158364bc03e 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -108,6 +108,9 @@
 
 #define DWC3_AM62_AUTOSUSPEND_DELAY	100
 
+#define USBSS_DEBUG_CFG_OFF		0x0
+#define USBSS_DEBUG_CFG_DISABLED	0x7
+
 struct dwc3_am62 {
 	struct device *dev;
 	void __iomem *usbss;
@@ -117,6 +120,7 @@ struct dwc3_am62 {
 	unsigned int offset;
 	unsigned int vbus_divider;
 	u32 wakeup_stat;
+	void __iomem *phy_regs;
 };
 
 static const int dwc3_ti_rate_table[] = {	/* in KHZ */
@@ -166,6 +170,7 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 	if (ret)
 		return ret;
 
+	of_node_put(args.np);
 	am62->offset = args.args[0];
 
 	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
@@ -184,15 +189,47 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 	return 0;
 }
 
+static int dwc3_ti_init(struct dwc3_am62 *am62)
+{
+	int ret;
+	u32 reg;
+
+	/* Read the syscon property and set the rate code */
+	ret = phy_syscon_pll_refclk(am62);
+	if (ret)
+		return ret;
+
+	/* Workaround Errata i2409 */
+	if (am62->phy_regs) {
+		reg = readl(am62->phy_regs + USB_PHY_PLL_REG12);
+		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
+		writel(reg, am62->phy_regs + USB_PHY_PLL_REG12);
+	}
+
+	/* VBUS divider select */
+	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
+	if (am62->vbus_divider)
+		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
+
+	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
+
+	clk_prepare_enable(am62->usb2_refclk);
+
+	/* Set mode valid bit to indicate role is valid */
+	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
+	reg |= USBSS_MODE_VALID;
+	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
+
+	return 0;
+}
+
 static int dwc3_ti_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
 	struct dwc3_am62 *am62;
 	unsigned long rate;
-	void __iomem *phy;
 	int i, ret;
-	u32 reg;
 
 	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
 	if (!am62)
@@ -228,29 +265,17 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 
 	am62->rate_code = i;
 
-	/* Read the syscon property and set the rate code */
-	ret = phy_syscon_pll_refclk(am62);
-	if (ret)
-		return ret;
-
-	/* Workaround Errata i2409 */
-	phy = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(phy)) {
+	am62->phy_regs = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(am62->phy_regs)) {
 		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
-		phy = NULL;
-	} else {
-		reg = readl(phy + USB_PHY_PLL_REG12);
-		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
-		writel(reg, phy + USB_PHY_PLL_REG12);
+		am62->phy_regs = NULL;
 	}
 
-	/* VBUS divider select */
 	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
-	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
-	if (am62->vbus_divider)
-		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
 
-	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
+	ret = dwc3_ti_init(am62);
+	if (ret)
+		return ret;
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -258,7 +283,6 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	 * Don't ignore its dependencies with its children
 	 */
 	pm_suspend_ignore_children(dev, false);
-	clk_prepare_enable(am62->usb2_refclk);
 	pm_runtime_get_noresume(dev);
 
 	ret = of_platform_populate(node, NULL, NULL, dev);
@@ -267,11 +291,6 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	/* Set mode valid bit to indicate role is valid */
-	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
-	reg |= USBSS_MODE_VALID;
-	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
-
 	/* Device has capability to wakeup system from sleep */
 	device_set_wakeup_capable(dev, true);
 	ret = device_wakeup_enable(dev);
@@ -339,6 +358,9 @@ static int dwc3_ti_suspend_common(struct device *dev)
 		dwc3_ti_writel(am62, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
 	}
 
+	/* just to track if module resets on suspend */
+	dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_DISABLED);
+
 	clk_disable_unprepare(am62->usb2_refclk);
 
 	return 0;
@@ -349,7 +371,14 @@ static int dwc3_ti_resume_common(struct device *dev)
 	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
 	u32 reg;
 
-	clk_prepare_enable(am62->usb2_refclk);
+	reg = dwc3_ti_readl(am62, USBSS_DEBUG_CFG);
+	if (reg != USBSS_DEBUG_CFG_DISABLED) {
+		/* lost power/context */
+		dwc3_ti_init(am62);
+	} else {
+		dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_OFF);
+		clk_prepare_enable(am62->usb2_refclk);
+	}
 
 	if (device_may_wakeup(dev)) {
 		/* Clear wakeup config enable bits */
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 31a654c6f15b..89a4dc8ebf94 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -996,8 +996,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 
 			/*
 			 * All stream eps will reinitiate stream on NoStream
-			 * rejection until we can determine that the host can
-			 * prime after the first transfer.
+			 * rejection.
 			 *
 			 * However, if the controller is capable of
 			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
@@ -2630,10 +2629,38 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 2000;
+	u32			saved_config = 0;
 
 	if (pm_runtime_suspended(dwc->dev))
 		return 0;
 
+	/*
+	 * When operating in USB 2.0 speeds (HS/FS), ensure that
+	 * GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY are cleared before starting
+	 * or stopping the controller. This resolves timeout issues that occur
+	 * during frequent role switches between host and device modes.
+	 *
+	 * Save and clear these settings, then restore them after completing the
+	 * controller start or stop sequence.
+	 *
+	 * This solution was discovered through experimentation as it is not
+	 * mentioned in the dwc3 programming guide. It has been tested on an
+	 * Exynos platforms.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (reg & DWC3_GUSB2PHYCFG_SUSPHY) {
+		saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	}
+
+	if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
+		saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
+		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+	}
+
+	if (saved_config)
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
 		if (DWC3_VER_IS_WITHIN(DWC3, ANY, 187A)) {
@@ -2661,6 +2688,12 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 		reg &= DWC3_DSTS_DEVCTRLHLT;
 	} while (--timeout && !(!is_on ^ !reg));
 
+	if (saved_config) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		reg |= saved_config;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	}
+
 	if (!timeout)
 		return -ETIMEDOUT;
 
@@ -2740,6 +2773,8 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
+
 	return ret;
 }
 
@@ -3298,6 +3333,50 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 	return dwc3_alloc_trb_pool(dep);
 }
 
+#define nostream_work_to_dep(w) (container_of(to_delayed_work(w), struct dwc3_ep, nostream_work))
+static void dwc3_nostream_work(struct work_struct *work)
+{
+	struct dwc3_ep	*dep = nostream_work_to_dep(work);
+	struct dwc3	*dwc = dep->dwc;
+	unsigned long   flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (dep->flags & DWC3_EP_STREAM_PRIMED)
+		goto out;
+
+	if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
+	    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
+	     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
+		goto out;
+	/*
+	 * If the host rejects a stream due to no active stream, by the
+	 * USB and xHCI spec, the endpoint will be put back to idle
+	 * state. When the host is ready (buffer added/updated), it will
+	 * prime the endpoint to inform the usb device controller. This
+	 * triggers the device controller to issue ERDY to restart the
+	 * stream. However, some hosts don't follow this and keep the
+	 * endpoint in the idle state. No prime will come despite host
+	 * streams are updated, and the device controller will not be
+	 * triggered to generate ERDY to move the next stream data. To
+	 * workaround this and maintain compatibility with various
+	 * hosts, force to reinitiate the stream until the host is ready
+	 * instead of waiting for the host to prime the endpoint.
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
+		unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
+
+		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
+	} else {
+		dep->flags |= DWC3_EP_DELAY_START;
+		dwc3_stop_active_transfer(dep, true, true);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return;
+	}
+out:
+	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 {
 	struct dwc3_ep			*dep;
@@ -3343,6 +3422,7 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	INIT_LIST_HEAD(&dep->pending_list);
 	INIT_LIST_HEAD(&dep->started_list);
 	INIT_LIST_HEAD(&dep->cancelled_list);
+	INIT_DELAYED_WORK(&dep->nostream_work, dwc3_nostream_work);
 
 	dwc3_debugfs_create_endpoint_dir(dep);
 
@@ -3742,66 +3822,27 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
-	struct dwc3 *dwc = dep->dwc;
-
 	if (event->status == DEPEVT_STREAMEVT_FOUND) {
-		dep->flags |= DWC3_EP_FIRST_STREAM_PRIMED;
-		goto out;
+		cancel_delayed_work(&dep->nostream_work);
+		dep->flags |= DWC3_EP_STREAM_PRIMED;
+		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+		return;
 	}
 
 	/* Note: NoStream rejection event param value is 0 and not 0xFFFF */
 	switch (event->parameters) {
 	case DEPEVT_STREAM_PRIME:
-		/*
-		 * If the host can properly transition the endpoint state from
-		 * idle to prime after a NoStream rejection, there's no need to
-		 * force restarting the endpoint to reinitiate the stream. To
-		 * simplify the check, assume the host follows the USB spec if
-		 * it primed the endpoint more than once.
-		 */
-		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM) {
-			if (dep->flags & DWC3_EP_FIRST_STREAM_PRIMED)
-				dep->flags &= ~DWC3_EP_FORCE_RESTART_STREAM;
-			else
-				dep->flags |= DWC3_EP_FIRST_STREAM_PRIMED;
-		}
-
+		cancel_delayed_work(&dep->nostream_work);
+		dep->flags |= DWC3_EP_STREAM_PRIMED;
+		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
 		break;
 	case DEPEVT_STREAM_NOSTREAM:
-		if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
-		    !(dep->flags & DWC3_EP_FORCE_RESTART_STREAM) ||
-		    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
-		     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
-			break;
-
-		/*
-		 * If the host rejects a stream due to no active stream, by the
-		 * USB and xHCI spec, the endpoint will be put back to idle
-		 * state. When the host is ready (buffer added/updated), it will
-		 * prime the endpoint to inform the usb device controller. This
-		 * triggers the device controller to issue ERDY to restart the
-		 * stream. However, some hosts don't follow this and keep the
-		 * endpoint in the idle state. No prime will come despite host
-		 * streams are updated, and the device controller will not be
-		 * triggered to generate ERDY to move the next stream data. To
-		 * workaround this and maintain compatibility with various
-		 * hosts, force to reinitiate the stream until the host is ready
-		 * instead of waiting for the host to prime the endpoint.
-		 */
-		if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
-			unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
-
-			dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
-		} else {
-			dep->flags |= DWC3_EP_DELAY_START;
-			dwc3_stop_active_transfer(dep, true, true);
-			return;
-		}
+		dep->flags &= ~DWC3_EP_STREAM_PRIMED;
+		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM)
+			queue_delayed_work(system_wq, &dep->nostream_work,
+					   msecs_to_jiffies(100));
 		break;
 	}
-
-out:
-	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
 }
 
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
@@ -4460,14 +4501,18 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 		    DWC3_GEVNTSIZ_SIZE(evt->length));
 
+	evt->flags &= ~DWC3_EVENT_PENDING;
+	/*
+	 * Add an explicit write memory barrier to make sure that the update of
+	 * clearing DWC3_EVENT_PENDING is observed in dwc3_check_event_buf()
+	 */
+	wmb();
+
 	if (dwc->imod_interval) {
 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
 		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
 	}
 
-	/* Keep the clearing of DWC3_EVENT_PENDING at the end */
-	evt->flags &= ~DWC3_EVENT_PENDING;
-
 	return ret;
 }
 
-- 
2.53.0

