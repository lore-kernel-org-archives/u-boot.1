Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E273CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A21D784B38;
	Thu,  7 May 2026 11:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aS18SEF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF5684B1E; Thu,  7 May 2026 11:31:12 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF2C584A3E
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5a860667fabso523017e87.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146265; x=1778751065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFHR/woUVVr/Sa9/O+O015Dq5ZP/78aEwq7BRNqZkYY=;
 b=aS18SEF1yVB6JE1XDJ4ci3WaNzcAB6yCRLbLi+uy6NJWqGNYdtW9o0vy9EoZkDxN/z
 aFX1ygWVSkuuL60w2xwtIGTD8D/rlefJbuh2kfFe630TILKOiRSRyMypjGayp2Llh8nx
 wEl1Ne2qJkw2DPInwGyw7N4cPxI3S3r3Wq6qd7IziXchbXWI4/SNOUgTWkqkpeKWYNUB
 2gYXAUmOehOlwchHMaxc7YJdpZmjcSu0O+v3LeMkIputnDy17TlidX7XZiAQCyxEle3t
 TzZxG916gVlAARPxgrEUI9R0MaBih3uISdUoKNKHuP22/4UdCSSwlzFaWVZ8OOodtiYW
 rUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146265; x=1778751065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LFHR/woUVVr/Sa9/O+O015Dq5ZP/78aEwq7BRNqZkYY=;
 b=mL1B10p7IDPqoStjaneN7px+IB34sXVkjkj5n0Crc+6ADBLLJWeV0bLFVTSzPI3Ge3
 2RWP3MU41eDnl7DHOhf5nszyOyfzd5Zd2hI/pwm69EBHU5V5UXW/XMNEQtTuC+gDKZ3V
 Q28iKe5JoDEWJ5FiuP0fbmaXEfS3wA73kIPhkkPafL2dz44yqE3POcUBdAniZlmcJ1SJ
 1flTqKcwKEPLD0d1J/XqvesCwJ+4pqKt3TANoZnmn4uZBS6CPZaTn+xHrBOnXvaMAC/l
 DpTn71CyZiSHwE/bFzDBIdYPoury/gzi7BXcSBcFrxn2xLZkhYYfl88YkzhFZMmGITRj
 CHIg==
X-Gm-Message-State: AOJu0Ywb5shcz0QXUH0s1SUQygl/lXeMjDT3UuZ0kJsrPQdDDx1lEMDz
 LmyXpMaW5ZFcGOYecDloxMh3fXJVvO30J9PDZ3Irr4BjTK+n+ujWbeAfW+lkC6gA7PwTmil42ST
 wivabX1yrbQ==
X-Gm-Gg: AeBDiesJPK0LooRkJyEMufPKROqu+Ea4/wtEnGsJkRVBlmybreL4YPGAMK9Dubb80XV
 +PoTCe8s2zyl8mL1rxLNDfETFiY9T6egy6Pp8VszNn6FFCsjeM+RXLd4ZjgwV50/y7SENK05SYX
 s/QuvK8SYEKVeaobgIeTMzWk6oOHagfDzdRMe3W5A3P6MbtCx7UbIMDvMl5Z+0hEfbIwSObrFLz
 lQIHxookOvION5wjmxIx2QyaVmMnQfKOWszlicN73+1GyBMFyX5EAQn29rKWK10WgEBztNrByec
 NpZQsjkoim+fqU4vLsk+nfOL5wn8JSnpxdS3iT/SlYEZNpxgKKKgq2N72t8oBXWnMLqwVDa1GpN
 T5yqnvA1ZnPuFQxV9fjzf5TgMj93SR4QwIC//lSJAZRl609/UM6nfe5HXd/U+rv9HEVcRgObMzK
 e3D8rvCN6N0IrwDebmkcx7A/HG3lXHAWA/RotMAFZGYgrymMjILsAd09687OGsyUqDeDYyJ6hd8
 YvM/MryKmLLt8O/wdbbRVIAtHqYruFbJDuKWw30A0lkipEmN8Ra
X-Received: by 2002:a05:6512:1149:b0:5a8:918d:5926 with SMTP id
 2adb3069b0e04-5a8918d5f41mr1743896e87.18.1778146264636; 
 Thu, 07 May 2026 02:31:04 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:31:03 -0700 (PDT)
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
Subject: [RFC PATCH v2 48/64] usb: dwc3: import from kernel v6.4
Date: Thu,  7 May 2026 11:27:55 +0200
Message-ID: <20260507092843.358908-49-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.3 to v6.4.

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

List of commits: git log --oneline v6.3..v6.4
Commits imported:
e3dbb6575715 USB: dwc3: fix use-after-free on core driver unbind
d2d69354226d USB: dwc3: qcom: fix NULL-deref on suspend
00f8205ffcf1 usb: dwc3: gadget: Reset num TRBs before giving back the request
8018018d9c56 usb: dwc3: fix a test for error in dwc3_core_init()
614ce6a2ea50 usb: dwc3: debugfs: Resume dwc3 before accessing registers
4e8ef34e36f2 usb: dwc3: fix gadget mode suspend interrupt handler issue
c8540870af4c usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()
8f40fc080813 usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate API
39674be56fba usb: dwc3: gadget: Execute gadget stop after halting the controller
02435a739b81 usb: dwc3: gadget: Stall and restart EP0 if host is unresponsive
d21a797a3eeb usb: dwc3: core: add support for disabling High-speed park mode
9a4d7dd19903 USB: dwc3: clean up probe declarations
bd82857424d3 USB: dwc3: refactor clock lookups
1d72fab47656 USB: dwc3: refactor phy handling
d2f197822d58 USB: dwc3: clean up core init error handling
c8e9eccf6ed2 USB: dwc3: clean up phy init error handling
fe296046c721 USB: dwc3: clean up probe error labels
f56d0d29b018 USB: dwc3: drop dead hibernation code
bdb19d01026a USB: dwc3: gadget: drop dead hibernation code
6b3b2402ca5b USB: dwc3: disable autosuspend on unbind
44d257e9012e USB: dwc3: fix runtime pm imbalance on unbind
9a8ad10c9f2e USB: dwc3: fix runtime pm imbalance on probe errors
091b813d3d10 usb: Add explicit of.h of_platform.h include
8e86652e3e71 Merge 6.3-rc6 into usb-next
917dc99b6591 usb: dwc3: pci: Change PCI device macros
92c08a84b53e usb: dwc3: Add function suspend and function wakeup support
047161686b81 usb: dwc3: Add remote wakeup handling
2926c5275028 usb: dwc3-am62: Fix up wake-up configuration and spurious wake up
db2c2b161d4a usb: dwc3: host: remove dead code in dwc3_host_get_irq()
97318d6427f6 Merge 6.3-rc4 into usb-next
8c4853c48d6c usb: dwc3: add several registers dump for debugfs
4e3972b589da usb: dwc3-am62: Enable as a wakeup source by default
84364a00b264 usb: dwc3-am62: Add support for system wakeup based on USB events
4fa1387261e7 usb: remove dead code in dwc3_gadget_get_irq
f09d24aa463c usb: dwc3: change some trace event __dynamic_array() to __get_buf()
4decf4060ecf usb: dwc3: gadget: Change condition for processing suspend event
b84ba26c922a usb: dwc3: core: add external vBus supply support for ulpi phy

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c      | 448 ++++++++++++++++-------------------
 drivers/usb/dwc3/core.h      |  23 +-
 drivers/usb/dwc3/debug.h     |   2 +
 drivers/usb/dwc3/dwc3-am62.c |  52 +++-
 drivers/usb/dwc3/ep0.c       |  19 +-
 drivers/usb/dwc3/gadget.c    | 353 ++++++++++++++++-----------
 6 files changed, 497 insertions(+), 400 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 476b63618511..d68958e151a7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -534,90 +534,6 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
 }
 
-static int dwc3_alloc_scratch_buffers(struct dwc3 *dwc)
-{
-	if (!dwc->has_hibernation)
-		return 0;
-
-	if (!dwc->nr_scratch)
-		return 0;
-
-	dwc->scratchbuf = kmalloc_array(dwc->nr_scratch,
-			DWC3_SCRATCHBUF_SIZE, GFP_KERNEL);
-	if (!dwc->scratchbuf)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static int dwc3_setup_scratch_buffers(struct dwc3 *dwc)
-{
-	dma_addr_t scratch_addr;
-	u32 param;
-	int ret;
-
-	if (!dwc->has_hibernation)
-		return 0;
-
-	if (!dwc->nr_scratch)
-		return 0;
-
-	 /* should never fall here */
-	if (!WARN_ON(dwc->scratchbuf))
-		return 0;
-
-	scratch_addr = dma_map_single(dwc->sysdev, dwc->scratchbuf,
-			dwc->nr_scratch * DWC3_SCRATCHBUF_SIZE,
-			DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dwc->sysdev, scratch_addr)) {
-		dev_err(dwc->sysdev, "failed to map scratch buffer\n");
-		ret = -EFAULT;
-		goto err0;
-	}
-
-	dwc->scratch_addr = scratch_addr;
-
-	param = lower_32_bits(scratch_addr);
-
-	ret = dwc3_send_gadget_generic_command(dwc,
-			DWC3_DGCMD_SET_SCRATCHPAD_ADDR_LO, param);
-	if (ret < 0)
-		goto err1;
-
-	param = upper_32_bits(scratch_addr);
-
-	ret = dwc3_send_gadget_generic_command(dwc,
-			DWC3_DGCMD_SET_SCRATCHPAD_ADDR_HI, param);
-	if (ret < 0)
-		goto err1;
-
-	return 0;
-
-err1:
-	dma_unmap_single(dwc->sysdev, dwc->scratch_addr, dwc->nr_scratch *
-			DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
-
-err0:
-	return ret;
-}
-
-static void dwc3_free_scratch_buffers(struct dwc3 *dwc)
-{
-	if (!dwc->has_hibernation)
-		return;
-
-	if (!dwc->nr_scratch)
-		return;
-
-	 /* should never fall here */
-	if (!WARN_ON(dwc->scratchbuf))
-		return;
-
-	dma_unmap_single(dwc->sysdev, dwc->scratch_addr, dwc->nr_scratch *
-			DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
-	kfree(dwc->scratchbuf);
-}
-
 static void dwc3_core_num_eps(struct dwc3 *dwc)
 {
 	struct dwc3_hwparams	*parms = &dwc->hwparams;
@@ -800,11 +716,91 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_u2_freeclk_exists_quirk || dwc->gfladj_refclk_lpm_sel)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
+	/*
+	 * Some ULPI USB PHY does not support internal VBUS supply, to drive
+	 * the CPEN pin requires the configuration of the ULPI DRVVBUSEXTERNAL
+	 * bit of OTG_CTRL register. Controller configures the USB2 PHY
+	 * ULPIEXTVBUSDRV bit[17] of the GUSB2PHYCFG register to drive vBus
+	 * with an external supply.
+	 */
+	if (dwc->ulpi_ext_vbus_drv)
+		reg |= DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
 	return 0;
 }
 
+static int dwc3_phy_init(struct dwc3 *dwc)
+{
+	int ret;
+
+	usb_phy_init(dwc->usb2_phy);
+	usb_phy_init(dwc->usb3_phy);
+
+	ret = phy_init(dwc->usb2_generic_phy);
+	if (ret < 0)
+		goto err_shutdown_usb3_phy;
+
+	ret = phy_init(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err_exit_usb2_phy;
+
+	return 0;
+
+err_exit_usb2_phy:
+	phy_exit(dwc->usb2_generic_phy);
+err_shutdown_usb3_phy:
+	usb_phy_shutdown(dwc->usb3_phy);
+	usb_phy_shutdown(dwc->usb2_phy);
+
+	return ret;
+}
+
+static void dwc3_phy_exit(struct dwc3 *dwc)
+{
+	phy_exit(dwc->usb3_generic_phy);
+	phy_exit(dwc->usb2_generic_phy);
+
+	usb_phy_shutdown(dwc->usb3_phy);
+	usb_phy_shutdown(dwc->usb2_phy);
+}
+
+static int dwc3_phy_power_on(struct dwc3 *dwc)
+{
+	int ret;
+
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+
+	ret = phy_power_on(dwc->usb2_generic_phy);
+	if (ret < 0)
+		goto err_suspend_usb3_phy;
+
+	ret = phy_power_on(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err_power_off_usb2_phy;
+
+	return 0;
+
+err_power_off_usb2_phy:
+	phy_power_off(dwc->usb2_generic_phy);
+err_suspend_usb3_phy:
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+
+	return ret;
+}
+
+static void dwc3_phy_power_off(struct dwc3 *dwc)
+{
+	phy_power_off(dwc->usb3_generic_phy);
+	phy_power_off(dwc->usb2_generic_phy);
+
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+}
+
 static int dwc3_clk_enable(struct dwc3 *dwc)
 {
 	int ret;
@@ -840,17 +836,8 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
 	dwc3_event_buffers_cleanup(dwc);
-
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
-
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
-
+	dwc3_phy_power_off(dwc);
+	dwc3_phy_exit(dwc);
 	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
 }
@@ -877,7 +864,6 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
 
 static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 {
-	u32 hwparams4 = dwc->hwparams.hwparams4;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
@@ -905,9 +891,6 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 			reg &= ~DWC3_GCTL_DSBLCLKGTNG;
 		break;
 	case DWC3_GHWPARAMS1_EN_PWROPT_HIB:
-		/* enable hibernation here */
-		dwc->nr_scratch = DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(hwparams4);
-
 		/*
 		 * REVISIT Enabling this bit so that host-mode hibernation
 		 * will work. Device-mode hibernation is not yet implemented.
@@ -1096,7 +1079,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
-		goto err0;
+		return ret;
 
 	if (!dwc->ulpi_ready) {
 		ret = dwc3_core_ulpi_init(dwc);
@@ -1105,7 +1088,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 				dwc3_core_soft_reset(dwc);
 				ret = -EPROBE_DEFER;
 			}
-			goto err0;
+			return ret;
 		}
 		dwc->ulpi_ready = true;
 	}
@@ -1113,25 +1096,17 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (!dwc->phys_ready) {
 		ret = dwc3_core_get_phy(dwc);
 		if (ret)
-			goto err0a;
+			goto err_exit_ulpi;
 		dwc->phys_ready = true;
 	}
 
-	usb_phy_init(dwc->usb2_phy);
-	usb_phy_init(dwc->usb3_phy);
-	ret = phy_init(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err0a;
-
-	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0) {
-		phy_exit(dwc->usb2_generic_phy);
-		goto err0a;
-	}
+	ret = dwc3_phy_init(dwc);
+	if (ret)
+		goto err_exit_ulpi;
 
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
-		goto err1;
+		goto err_exit_phy;
 
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
 	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
@@ -1151,10 +1126,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
-	ret = dwc3_setup_scratch_buffers(dwc);
-	if (ret)
-		goto err1;
-
 	/* Set power down scale of suspend_clk */
 	dwc3_set_power_down_clk_scale(dwc);
 
@@ -1166,20 +1137,14 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
-	usb_phy_set_suspend(dwc->usb2_phy, 0);
-	usb_phy_set_suspend(dwc->usb3_phy, 0);
-	ret = phy_power_on(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err2;
-
-	ret = phy_power_on(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err3;
+	ret = dwc3_phy_power_on(dwc);
+	if (ret)
+		goto err_exit_phy;
 
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
 		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err4;
+		goto err_power_off_phy;
 	}
 
 	/*
@@ -1233,6 +1198,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->parkmode_disable_ss_quirk)
 			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
 
+		if (dwc->parkmode_disable_hs_quirk)
+			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_HS;
+
 		if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY) &&
 		    (dwc->maximum_speed == USB_SPEED_HIGH ||
 		     dwc->maximum_speed == USB_SPEED_FULL))
@@ -1296,26 +1264,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	return 0;
 
-err4:
-	phy_power_off(dwc->usb3_generic_phy);
-
-err3:
-	phy_power_off(dwc->usb2_generic_phy);
-
-err2:
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-
-err1:
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
-
-err0a:
+err_power_off_phy:
+	dwc3_phy_power_off(dwc);
+err_exit_phy:
+	dwc3_phy_exit(dwc);
+err_exit_ulpi:
 	dwc3_ulpi_exit(dwc);
 
-err0:
 	return ret;
 }
 
@@ -1553,8 +1508,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-tx-ipgap-linecheck-quirk");
 	dwc->resume_hs_terminations = device_property_read_bool(dev,
 				"snps,resume-hs-terminations");
+	dwc->ulpi_ext_vbus_drv = device_property_read_bool(dev,
+				"snps,ulpi-ext-vbus-drv");
 	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
 				"snps,parkmode-disable-ss-quirk");
+	dwc->parkmode_disable_hs_quirk = device_property_read_bool(dev,
+				"snps,parkmode-disable-hs-quirk");
 	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
 				"snps,gfladj-refclk-lpm-sel-quirk");
 
@@ -1750,16 +1709,72 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	return edev;
 }
 
+static int dwc3_get_clocks(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+
+	if (!dev->of_node)
+		return 0;
+
+	/*
+	 * Clocks are optional, but new DT platforms should support all clocks
+	 * as required by the DT-binding.
+	 * Some devices have different clock names in legacy device trees,
+	 * check for them to retain backwards compatibility.
+	 */
+	dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
+	if (IS_ERR(dwc->bus_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+				"could not get bus clock\n");
+	}
+
+	if (dwc->bus_clk == NULL) {
+		dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
+		if (IS_ERR(dwc->bus_clk)) {
+			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+					"could not get bus clock\n");
+		}
+	}
+
+	dwc->ref_clk = devm_clk_get_optional(dev, "ref");
+	if (IS_ERR(dwc->ref_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+				"could not get ref clock\n");
+	}
+
+	if (dwc->ref_clk == NULL) {
+		dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
+		if (IS_ERR(dwc->ref_clk)) {
+			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+					"could not get ref clock\n");
+		}
+	}
+
+	dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
+	if (IS_ERR(dwc->susp_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+				"could not get suspend clock\n");
+	}
+
+	if (dwc->susp_clk == NULL) {
+		dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
+		if (IS_ERR(dwc->susp_clk)) {
+			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+					"could not get suspend clock\n");
+		}
+	}
+
+	return 0;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
 	struct resource		*res, dwc_res;
+	void __iomem		*regs;
 	struct dwc3		*dwc;
-
 	int			ret;
 
-	void __iomem		*regs;
-
 	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
 	if (!dwc)
 		return -ENOMEM;
@@ -1797,77 +1812,25 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
-		goto put_usb_psy;
+		goto err_put_psy;
 	}
 
-	if (dev->of_node) {
-		/*
-		 * Clocks are optional, but new DT platforms should support all
-		 * clocks as required by the DT-binding.
-		 * Some devices have different clock names in legacy device trees,
-		 * check for them to retain backwards compatibility.
-		 */
-		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
-		if (IS_ERR(dwc->bus_clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-					    "could not get bus clock\n");
-			goto put_usb_psy;
-		}
-
-		if (dwc->bus_clk == NULL) {
-			dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
-			if (IS_ERR(dwc->bus_clk)) {
-				ret = dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-						    "could not get bus clock\n");
-				goto put_usb_psy;
-			}
-		}
-
-		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
-		if (IS_ERR(dwc->ref_clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-					    "could not get ref clock\n");
-			goto put_usb_psy;
-		}
-
-		if (dwc->ref_clk == NULL) {
-			dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
-			if (IS_ERR(dwc->ref_clk)) {
-				ret = dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-						    "could not get ref clock\n");
-				goto put_usb_psy;
-			}
-		}
-
-		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
-		if (IS_ERR(dwc->susp_clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-					    "could not get suspend clock\n");
-			goto put_usb_psy;
-		}
-
-		if (dwc->susp_clk == NULL) {
-			dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
-			if (IS_ERR(dwc->susp_clk)) {
-				ret = dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-						    "could not get suspend clock\n");
-				goto put_usb_psy;
-			}
-		}
-	}
+	ret = dwc3_get_clocks(dwc);
+	if (ret)
+		goto err_put_psy;
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
-		goto put_usb_psy;
+		goto err_put_psy;
 
 	ret = dwc3_clk_enable(dwc);
 	if (ret)
-		goto assert_reset;
+		goto err_assert_reset;
 
 	if (!dwc3_core_is_valid(dwc)) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
-		goto disable_clks;
+		goto err_disable_clks;
 	}
 
 	platform_set_drvdata(pdev, dwc);
@@ -1877,19 +1840,17 @@ static int dwc3_probe(struct platform_device *pdev)
 	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
 		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
 		if (ret)
-			goto disable_clks;
+			goto err_disable_clks;
 	}
 
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
+	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		goto err1;
 
 	pm_runtime_forbid(dev);
 
@@ -1897,27 +1858,23 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
 		ret = -ENOMEM;
-		goto err2;
+		goto err_allow_rpm;
 	}
 
 	dwc->edev = dwc3_get_extcon(dwc);
 	if (IS_ERR(dwc->edev)) {
 		ret = dev_err_probe(dwc->dev, PTR_ERR(dwc->edev), "failed to get extcon\n");
-		goto err3;
+		goto err_free_event_buffers;
 	}
 
 	ret = dwc3_get_dr_mode(dwc);
 	if (ret)
-		goto err3;
-
-	ret = dwc3_alloc_scratch_buffers(dwc);
-	if (ret)
-		goto err3;
+		goto err_free_event_buffers;
 
 	ret = dwc3_core_init(dwc);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to initialize core\n");
-		goto err4;
+		goto err_free_event_buffers;
 	}
 
 	dwc3_check_params(dwc);
@@ -1925,46 +1882,31 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
-		goto err5;
+		goto err_exit_debugfs;
 
 	pm_runtime_put(dev);
 
 	return 0;
 
-err5:
+err_exit_debugfs:
 	dwc3_debugfs_exit(dwc);
 	dwc3_event_buffers_cleanup(dwc);
-
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
-
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
-
+	dwc3_phy_power_off(dwc);
+	dwc3_phy_exit(dwc);
 	dwc3_ulpi_exit(dwc);
-
-err4:
-	dwc3_free_scratch_buffers(dwc);
-
-err3:
+err_free_event_buffers:
 	dwc3_free_event_buffers(dwc);
-
-err2:
-	pm_runtime_allow(&pdev->dev);
-
-err1:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-
-disable_clks:
+err_allow_rpm:
+	pm_runtime_allow(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+err_disable_clks:
 	dwc3_clk_disable(dwc);
-assert_reset:
+err_assert_reset:
 	reset_control_assert(dwc->reset);
-put_usb_psy:
+err_put_psy:
 	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
 
@@ -1983,12 +1925,18 @@ static int dwc3_remove(struct platform_device *pdev)
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
+	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+	/*
+	 * HACK: Clear the driver data, which is currently accessed by parent
+	 * glue drivers, before allowing the parent to suspend.
+	 */
+	platform_set_drvdata(pdev, NULL);
 	pm_runtime_set_suspended(&pdev->dev);
 
 	dwc3_free_event_buffers(dwc);
-	dwc3_free_scratch_buffers(dwc);
 
 	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4743e918dcaf..1f043c31a096 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -263,6 +263,7 @@
 #define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
+#define DWC3_GUCTL1_PARKMODE_DISABLE_HS		BIT(16)
 #define DWC3_GUCTL1_RESUME_OPMODE_HS_HOST	BIT(10)
 
 /* Global Status Register */
@@ -280,6 +281,7 @@
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	BIT(31)
 #define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	BIT(30)
+#define DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV	BIT(17)
 #define DWC3_GUSB2PHYCFG_SUSPHY		BIT(6)
 #define DWC3_GUSB2PHYCFG_ULPI_UTMI	BIT(4)
 #define DWC3_GUSB2PHYCFG_ENBLSLPM	BIT(8)
@@ -526,6 +528,7 @@
 #define DWC3_DGCMD_SET_ENDPOINT_NRDY	0x0c
 #define DWC3_DGCMD_SET_ENDPOINT_PRIME	0x0d
 #define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
+#define DWC3_DGCMD_DEV_NOTIFICATION	0x07
 
 #define DWC3_DGCMD_STATUS(n)		(((n) >> 12) & 0x0F)
 #define DWC3_DGCMD_CMDACT		BIT(10)
@@ -538,6 +541,8 @@
 #define DWC3_DGCMDPAR_TX_FIFO			BIT(5)
 #define DWC3_DGCMDPAR_LOOPBACK_DIS		(0 << 0)
 #define DWC3_DGCMDPAR_LOOPBACK_ENA		BIT(0)
+#define DWC3_DGCMDPAR_DN_FUNC_WAKE		BIT(0)
+#define DWC3_DGCMDPAR_INTF_SEL(n)		((n) << 4)
 
 /* Device Endpoint Command Register */
 #define DWC3_DEPCMD_PARAM_SHIFT		16
@@ -969,12 +974,10 @@ struct dwc3_scratchpad_array {
  * @drd_work: workqueue used for role swapping
  * @ep0_trb: trb which is used for the ctrl_req
  * @bounce: address of bounce buffer
- * @scratchbuf: address of scratch buffer
  * @setup_buf: used while precessing STD USB requests
  * @ep0_trb_addr: dma address of @ep0_trb
  * @bounce_addr: dma address of @bounce
  * @ep0_usb_req: dummy req used while handling STD USB requests
- * @scratch_addr: dma address of scratchbuf
  * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
  * @mutex: for mode switching
@@ -999,7 +1002,6 @@ struct dwc3_scratchpad_array {
  * @current_otg_role: current role of operation while using the OTG block
  * @desired_otg_role: desired role of operation while using the OTG block
  * @otg_restart_host: flag that OTG controller needs to restart host
- * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @max_ssp_rate: SuperSpeed Plus maximum signaling rate and lane count
@@ -1056,7 +1058,6 @@ struct dwc3_scratchpad_array {
  * @delayed_status: true when gadget driver asks for delayed status
  * @ep0_bounced: true when we used bounce buffer
  * @ep0_expect_in: true when we expect a DATA IN transfer
- * @has_hibernation: true when dwc3 was configured with Hibernation
  * @sysdev_is_parent: true when dwc3 device has a parent driver
  * @has_lpm_erratum: true when core was configured with LPM Erratum. Note that
  *			there's now way for software to detect this in runtime.
@@ -1100,8 +1101,12 @@ struct dwc3_scratchpad_array {
  *			check during HS transmit.
  * @resume_hs_terminations: Set if we enable quirk for fixing improper crc
  *			generation after resume from suspend.
+ * @ulpi_ext_vbus_drv: Set to confiure the upli chip to drives CPEN pin
+ *			VBUS with an external supply.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
+ * @parkmode_disable_hs_quirk: set if we need to disable all HishSpeed
+ *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  *	0	- -6dB de-emphasis
@@ -1110,6 +1115,8 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @wakeup_configured: set if the device is configured for remote wakeup.
+ * @suspended: set to track suspend event due to U3/L2.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1123,11 +1130,9 @@ struct dwc3 {
 	struct work_struct	drd_work;
 	struct dwc3_trb		*ep0_trb;
 	void			*bounce;
-	void			*scratchbuf;
 	u8			*setup_buf;
 	dma_addr_t		ep0_trb_addr;
 	dma_addr_t		bounce_addr;
-	dma_addr_t		scratch_addr;
 	struct dwc3_request	ep0_usb_req;
 	struct completion	ep0_in_setup;
 
@@ -1187,7 +1192,6 @@ struct dwc3 {
 	u32			current_otg_role;
 	u32			desired_otg_role;
 	bool			otg_restart_host;
-	u32			nr_scratch;
 	u32			u1u2;
 	u32			maximum_speed;
 	u32			gadget_max_speed;
@@ -1284,7 +1288,6 @@ struct dwc3 {
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
-	unsigned		has_hibernation:1;
 	unsigned		sysdev_is_parent:1;
 	unsigned		has_lpm_erratum:1;
 	unsigned		is_utmi_l1_suspend:1;
@@ -1317,7 +1320,9 @@ struct dwc3 {
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
 	unsigned		resume_hs_terminations:1;
+	unsigned		ulpi_ext_vbus_drv:1;
 	unsigned		parkmode_disable_ss_quirk:1;
+	unsigned		parkmode_disable_hs_quirk:1;
 	unsigned		gfladj_refclk_lpm_sel:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
@@ -1327,6 +1332,8 @@ struct dwc3 {
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
+	unsigned		wakeup_configured:1;
+	unsigned		suspended:1;
 
 	u16			imod_interval;
 
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 8bb2c9e3b9ac..09d703852a92 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -72,6 +72,8 @@ dwc3_gadget_generic_cmd_string(u8 cmd)
 		return "Set Endpoint Prime";
 	case DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK:
 		return "Run SoC Bus Loopback Test";
+	case DWC3_DGCMD_DEV_NOTIFICATION:
+		return "Device Notification";
 	default:
 		return "UNKNOWN";
 	}
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 173cf3579c55..cda9458c809b 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -11,12 +11,14 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/pinctrl/consumer.h>
 
+#include "core.h"
+
 /* USB WRAPPER register offsets */
 #define USBSS_PID			0x0
 #define USBSS_OVERCURRENT_CTRL		0x4
@@ -45,6 +47,10 @@
 #define USBSS_PHY_VBUS_SEL_SHIFT	1
 #define USBSS_PHY_LANE_REVERSE		BIT(0)
 
+/* CORE STAT register bits */
+#define USBSS_CORE_OPERATIONAL_MODE_MASK	GENMASK(13, 12)
+#define USBSS_CORE_OPERATIONAL_MODE_SHIFT	12
+
 /* MODE CONTROL register bits */
 #define USBSS_MODE_VALID	BIT(0)
 
@@ -54,6 +60,13 @@
 #define USBSS_WAKEUP_CFG_SESSVALID_EN	BIT(1)
 #define USBSS_WAKEUP_CFG_VBUSVALID_EN	BIT(0)
 
+#define USBSS_WAKEUP_CFG_ALL	(USBSS_WAKEUP_CFG_VBUSVALID_EN | \
+				 USBSS_WAKEUP_CFG_SESSVALID_EN | \
+				 USBSS_WAKEUP_CFG_LINESTATE_EN | \
+				 USBSS_WAKEUP_CFG_OVERCURRENT_EN)
+
+#define USBSS_WAKEUP_CFG_NONE	0
+
 /* WAKEUP STAT register bits */
 #define USBSS_WAKEUP_STAT_OVERCURRENT	BIT(4)
 #define USBSS_WAKEUP_STAT_LINESTATE	BIT(3)
@@ -97,6 +110,7 @@ struct dwc3_data {
 	struct regmap *syscon;
 	unsigned int offset;
 	unsigned int vbus_divider;
+	u32 wakeup_stat;
 };
 
 static const int dwc3_ti_rate_table[] = {	/* in KHZ */
@@ -233,6 +247,12 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	reg |= USBSS_MODE_VALID;
 	dwc3_ti_writel(data, USBSS_MODE_CONTROL, reg);
 
+	/* Device has capability to wakeup system from sleep */
+	device_set_wakeup_capable(dev, true);
+	ret = device_wakeup_enable(dev);
+	if (ret)
+		dev_err(dev, "couldn't enable device as a wakeup source: %d\n", ret);
+
 	/* Setting up autosuspend */
 	pm_runtime_set_autosuspend_delay(dev, DWC3_AM62_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(dev);
@@ -281,6 +301,27 @@ static int dwc3_ti_remove(struct platform_device *pdev)
 static int dwc3_ti_suspend_common(struct device *dev)
 {
 	struct dwc3_data *data = dev_get_drvdata(dev);
+	u32 reg, current_prtcap_dir;
+
+	if (device_may_wakeup(dev)) {
+		reg = dwc3_ti_readl(data, USBSS_CORE_STAT);
+		current_prtcap_dir = (reg & USBSS_CORE_OPERATIONAL_MODE_MASK)
+				     >> USBSS_CORE_OPERATIONAL_MODE_SHIFT;
+		/* Set wakeup config enable bits */
+		reg = dwc3_ti_readl(data, USBSS_WAKEUP_CONFIG);
+		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
+			reg = USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
+		} else {
+			reg = USBSS_WAKEUP_CFG_VBUSVALID_EN | USBSS_WAKEUP_CFG_SESSVALID_EN;
+			/*
+			 * Enable LINESTATE wake up only if connected to bus
+			 * and in U2/L3 state else it causes spurious wake-up.
+			 */
+		}
+		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, reg);
+		/* clear wakeup status so we know what caused the wake up */
+		dwc3_ti_writel(data, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
+	}
 
 	clk_disable_unprepare(data->usb2_refclk);
 
@@ -290,9 +331,18 @@ static int dwc3_ti_suspend_common(struct device *dev)
 static int dwc3_ti_resume_common(struct device *dev)
 {
 	struct dwc3_data *data = dev_get_drvdata(dev);
+	u32 reg;
 
 	clk_prepare_enable(data->usb2_refclk);
 
+	if (device_may_wakeup(dev)) {
+		/* Clear wakeup config enable bits */
+		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
+	}
+
+	reg = dwc3_ti_readl(data, USBSS_WAKEUP_STAT);
+	data->wakeup_stat = reg;
+
 	return 0;
 }
 
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 61de693461da..953b752a5052 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -30,6 +30,8 @@
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep);
 static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		struct dwc3_ep *dep, struct dwc3_request *req);
+static int dwc3_ep0_delegate_req(struct dwc3 *dwc,
+				 struct usb_ctrlrequest *ctrl);
 
 static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
 		dma_addr_t buf_dma, u32 len, u32 type, bool chain)
@@ -356,6 +358,9 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 				usb_status |= 1 << USB_DEV_STAT_U1_ENABLED;
 			if (reg & DWC3_DCTL_INITU2ENA)
 				usb_status |= 1 << USB_DEV_STAT_U2_ENABLED;
+		} else {
+			usb_status |= dwc->gadget->wakeup_armed <<
+					USB_DEVICE_REMOTE_WAKEUP;
 		}
 
 		break;
@@ -365,7 +370,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		 * Function Remote Wake Capable	D0
 		 * Function Remote Wakeup	D1
 		 */
-		break;
+		return dwc3_ep0_delegate_req(dwc, ctrl);
 
 	case USB_RECIP_ENDPOINT:
 		dep = dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
@@ -476,6 +481,10 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 
 	switch (wValue) {
 	case USB_DEVICE_REMOTE_WAKEUP:
+		if (dwc->wakeup_configured)
+			dwc->gadget->wakeup_armed = set;
+		else
+			ret = -EINVAL;
 		break;
 	/*
 	 * 9.4.1 says only for SS, in AddressState only for
@@ -510,13 +519,7 @@ static int dwc3_ep0_handle_intf(struct dwc3 *dwc,
 
 	switch (wValue) {
 	case USB_INTRF_FUNC_SUSPEND:
-		/*
-		 * REVISIT: Ideally we would enable some low power mode here,
-		 * however it's unclear what we should be doing here.
-		 *
-		 * For now, we're not doing anything, just making sure we return
-		 * 0 so USB Command Verifier tests pass without any errors.
-		 */
+		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index cf5b4f49c3ed..b78599dd705c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -139,6 +139,24 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	return -ETIMEDOUT;
 }
 
+static void dwc3_ep0_reset_state(struct dwc3 *dwc)
+{
+	unsigned int	dir;
+
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		dir = !!dwc->ep0_expect_in;
+		if (dwc->ep0state == EP0_DATA_PHASE)
+			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
+		else
+			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
+
+		dwc->eps[0]->trb_enqueue = 0;
+		dwc->eps[1]->trb_enqueue = 0;
+
+		dwc3_ep0_stall_and_restart(dwc);
+	}
+}
+
 /**
  * dwc3_ep_inc_trb - increment a trb index.
  * @index: Pointer to the TRB index to increment.
@@ -180,6 +198,7 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 	list_del(&req->list);
 	req->remaining = 0;
 	req->needs_extra_trb = false;
+	req->num_trbs = 0;
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
@@ -258,7 +277,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 	return ret;
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
 
 /**
  * dwc3_send_gadget_ep_cmd - issue an endpoint command
@@ -325,7 +344,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 
 			fallthrough;
 		case DWC3_LINK_STATE_U3:
-			ret = __dwc3_gadget_wakeup(dwc);
+			ret = __dwc3_gadget_wakeup(dwc, false);
 			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
 					ret);
 			break;
@@ -2273,6 +2292,22 @@ static const struct usb_ep_ops dwc3_gadget_ep_ops = {
 
 /* -------------------------------------------------------------------------- */
 
+static void dwc3_gadget_enable_linksts_evts(struct dwc3 *dwc, bool set)
+{
+	u32 reg;
+
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
+		return;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DEVTEN);
+	if (set)
+		reg |= DWC3_DEVTEN_ULSTCNGEN;
+	else
+		reg &= ~DWC3_DEVTEN_ULSTCNGEN;
+
+	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
+}
+
 static int dwc3_gadget_get_frame(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -2280,7 +2315,7 @@ static int dwc3_gadget_get_frame(struct usb_gadget *g)
 	return __dwc3_gadget_get_frame(dwc);
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
 {
 	int			retries;
 
@@ -2311,9 +2346,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 		return -EINVAL;
 	}
 
+	if (async)
+		dwc3_gadget_enable_linksts_evts(dwc, true);
+
 	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
 	if (ret < 0) {
 		dev_err(dwc->dev, "failed to put link in Recovery\n");
+		dwc3_gadget_enable_linksts_evts(dwc, false);
 		return ret;
 	}
 
@@ -2325,6 +2364,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	}
 
+	/*
+	 * Since link status change events are enabled we will receive
+	 * an U0 event when wakeup is successful. So bail out.
+	 */
+	if (async)
+		return 0;
+
 	/* poll until Link State changes to ON */
 	retries = 20000;
 
@@ -2350,13 +2396,78 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	unsigned long		flags;
 	int			ret;
 
+	if (!dwc->wakeup_configured) {
+		dev_err(dwc->dev, "remote wakeup not configured\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (!dwc->gadget->wakeup_armed) {
+		dev_err(dwc->dev, "not armed for remote wakeup\n");
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -EINVAL;
+	}
+	ret = __dwc3_gadget_wakeup(dwc, true);
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static void dwc3_resume_gadget(struct dwc3 *dwc);
+
+static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
+{
+	struct  dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+	int			ret;
+	int			link_state;
+
+	if (!dwc->wakeup_configured) {
+		dev_err(dwc->dev, "remote wakeup not configured\n");
+		return -EINVAL;
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_wakeup(dwc);
+	/*
+	 * If the link is in U3, signal for remote wakeup and wait for the
+	 * link to transition to U0 before sending device notification.
+	 */
+	link_state = dwc3_gadget_get_link_state(dwc);
+	if (link_state == DWC3_LINK_STATE_U3) {
+		ret = __dwc3_gadget_wakeup(dwc, false);
+		if (ret) {
+			spin_unlock_irqrestore(&dwc->lock, flags);
+			return -EINVAL;
+		}
+		dwc3_resume_gadget(dwc);
+		dwc->suspended = false;
+		dwc->link_state = DWC3_LINK_STATE_U0;
+	}
+
+	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
+					       DWC3_DGCMDPAR_DN_FUNC_WAKE |
+					       DWC3_DGCMDPAR_INTF_SEL(intf_id));
+	if (ret)
+		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
+
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
 }
 
+static int dwc3_gadget_set_remote_wakeup(struct usb_gadget *g, int set)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->wakeup_configured = !!set;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
+}
+
 static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 		int is_selfpowered)
 {
@@ -2478,7 +2589,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 }
 
-static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
+static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 2000;
@@ -2497,17 +2608,11 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 			reg &= ~DWC3_DCTL_KEEP_CONNECT;
 		reg |= DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation)
-			reg |= DWC3_DCTL_KEEP_CONNECT;
-
 		__dwc3_gadget_set_speed(dwc);
 		dwc->pullups_connected = true;
 	} else {
 		reg &= ~DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation && !suspend)
-			reg &= ~DWC3_DCTL_KEEP_CONNECT;
-
 		dwc->pullups_connected = false;
 	}
 
@@ -2532,29 +2637,17 @@ static int __dwc3_gadget_start(struct dwc3 *dwc);
 static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->connected = false;
 
 	/*
-	 * Per databook, when we want to stop the gadget, if a control transfer
-	 * is still in process, complete it and get the core into setup phase.
+	 * Attempt to end pending SETUP status phase, and not wait for the
+	 * function to do so.
 	 */
-	if (dwc->ep0state != EP0_SETUP_PHASE) {
-		int ret;
-
-		if (dwc->delayed_status)
-			dwc3_ep0_send_delayed_status(dwc);
-
-		reinit_completion(&dwc->ep0_in_setup);
-
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
-				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
-		spin_lock_irqsave(&dwc->lock, flags);
-		if (ret == 0)
-			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");
-	}
+	if (dwc->delayed_status)
+		dwc3_ep0_send_delayed_status(dwc);
 
 	/*
 	 * In the Synopsys DesignWare Cores USB3 Databook Rev. 3.30a
@@ -2564,9 +2657,28 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * bit.
 	 */
 	dwc3_stop_active_transfers(dwc);
-	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	/*
+	 * Per databook, when we want to stop the gadget, if a control transfer
+	 * is still in process, complete it and get the core into setup phase.
+	 * In case the host is unresponsive to a SETUP transaction, forcefully
+	 * stall the transfer, and move back to the SETUP phase, so that any
+	 * pending endxfers can be executed.
+	 */
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		reinit_completion(&dwc->ep0_in_setup);
+
+		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
+				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
+		if (ret == 0) {
+			dev_warn(dwc->dev, "wait for SETUP phase timed out\n");
+			spin_lock_irqsave(&dwc->lock, flags);
+			dwc3_ep0_reset_state(dwc);
+			spin_unlock_irqrestore(&dwc->lock, flags);
+		}
+	}
+
 	/*
 	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
 	 * driver needs to acknowledge them before the controller can halt.
@@ -2574,7 +2686,34 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * remaining event generated by the controller while polling for
 	 * DSTS.DEVCTLHLT.
 	 */
-	return dwc3_gadget_run_stop(dwc, false, false);
+	ret = dwc3_gadget_run_stop(dwc, false);
+
+	/*
+	 * Stop the gadget after controller is halted, so that if needed, the
+	 * events to update EP0 state can still occur while the run/stop
+	 * routine polls for the halted state.  DEVTEN is cleared as part of
+	 * gadget stop.
+	 */
+	spin_lock_irqsave(&dwc->lock, flags);
+	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
+{
+	/*
+	 * In the Synopsys DWC_usb31 1.90a programming guide section
+	 * 4.1.9, it specifies that for a reconnect after a
+	 * device-initiated disconnect requires a core soft reset
+	 * (DCTL.CSftRst) before enabling the run/stop bit.
+	 */
+	dwc3_core_soft_reset(dwc);
+
+	dwc3_event_buffers_setup(dwc);
+	__dwc3_gadget_start(dwc);
+	return dwc3_gadget_run_stop(dwc, true);
 }
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
@@ -2615,21 +2754,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	synchronize_irq(dwc->irq_gadget);
 
-	if (!is_on) {
+	if (!is_on)
 		ret = dwc3_gadget_soft_disconnect(dwc);
-	} else {
-		/*
-		 * In the Synopsys DWC_usb31 1.90a programming guide section
-		 * 4.1.9, it specifies that for a reconnect after a
-		 * device-initiated disconnect requires a core soft reset
-		 * (DCTL.CSftRst) before enabling the run/stop bit.
-		 */
-		dwc3_core_soft_reset(dwc);
-
-		dwc3_event_buffers_setup(dwc);
-		__dwc3_gadget_start(dwc);
-		ret = dwc3_gadget_run_stop(dwc, true, false);
-	}
+	else
+		ret = dwc3_gadget_soft_connect(dwc);
 
 	pm_runtime_put(dwc->dev);
 
@@ -2982,6 +3110,8 @@ static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
+	.func_wakeup		= dwc3_gadget_func_wakeup,
+	.set_remote_wakeup	= dwc3_gadget_set_remote_wakeup,
 	.set_selfpowered	= dwc3_gadget_set_selfpowered,
 	.pullup			= dwc3_gadget_pullup,
 	.udc_start		= dwc3_gadget_start,
@@ -3814,6 +3944,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 {
 	int			reg;
 
+	dwc->suspended = false;
+
 	dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RX_DET);
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -3827,24 +3959,19 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 
 	dwc->gadget->speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
+	dwc->gadget->wakeup_armed = false;
+	dwc3_gadget_enable_linksts_evts(dwc, false);
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
-	if (dwc->ep0state != EP0_SETUP_PHASE) {
-		unsigned int    dir;
-
-		dir = !!dwc->ep0_expect_in;
-		if (dwc->ep0state == EP0_DATA_PHASE)
-			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
-		else
-			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
-		dwc3_ep0_stall_and_restart(dwc);
-	}
+	dwc3_ep0_reset_state(dwc);
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 {
 	u32			reg;
 
+	dwc->suspended = false;
+
 	/*
 	 * Ideally, dwc3_reset_gadget() would trigger the function
 	 * drivers to stop any active transfers through ep disable.
@@ -3892,20 +4019,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	 * phase. So ensure that EP0 is in setup phase by issuing a stall
 	 * and restart if EP0 is not in setup phase.
 	 */
-	if (dwc->ep0state != EP0_SETUP_PHASE) {
-		unsigned int	dir;
-
-		dir = !!dwc->ep0_expect_in;
-		if (dwc->ep0state == EP0_DATA_PHASE)
-			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
-		else
-			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
-
-		dwc->eps[0]->trb_enqueue = 0;
-		dwc->eps[1]->trb_enqueue = 0;
-
-		dwc3_ep0_stall_and_restart(dwc);
-	}
+	dwc3_ep0_reset_state(dwc);
 
 	/*
 	 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
@@ -3920,6 +4034,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 	dwc->test_mode = false;
+	dwc->gadget->wakeup_armed = false;
+	dwc3_gadget_enable_linksts_evts(dwc, false);
 	dwc3_clear_stall_all_ep(dwc);
 
 	/* Reset device address to zero */
@@ -4072,8 +4188,10 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	 */
 }
 
-static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
+static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
 {
+	dwc->suspended = false;
+
 	/*
 	 * TODO take core out of low power mode when that's
 	 * implemented.
@@ -4084,6 +4202,8 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
+
+	dwc->link_state = evtinfo & DWC3_LINK_STATE_MASK;
 }
 
 static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
@@ -4165,6 +4285,13 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (next) {
+	case DWC3_LINK_STATE_U0:
+		if (dwc->gadget->wakeup_armed) {
+			dwc3_gadget_enable_linksts_evts(dwc, false);
+			dwc3_resume_gadget(dwc);
+			dwc->suspended = false;
+		}
+		break;
 	case DWC3_LINK_STATE_U1:
 		if (dwc->speed == USB_SPEED_SUPER)
 			dwc3_suspend_gadget(dwc);
@@ -4189,36 +4316,14 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 {
 	enum dwc3_link_state next = evtinfo & DWC3_LINK_STATE_MASK;
 
-	if (dwc->link_state != next && next == DWC3_LINK_STATE_U3)
+	if (!dwc->suspended && next == DWC3_LINK_STATE_U3) {
+		dwc->suspended = true;
 		dwc3_suspend_gadget(dwc);
+	}
 
 	dwc->link_state = next;
 }
 
-static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
-		unsigned int evtinfo)
-{
-	unsigned int is_ss = evtinfo & BIT(4);
-
-	/*
-	 * WORKAROUND: DWC3 revision 2.20a with hibernation support
-	 * have a known issue which can cause USB CV TD.9.23 to fail
-	 * randomly.
-	 *
-	 * Because of this issue, core could generate bogus hibernation
-	 * events which SW needs to ignore.
-	 *
-	 * Refers to:
-	 *
-	 * STAR#9000546576: Device Mode Hibernation: Issue in USB 2.0
-	 * Device Fallback from SuperSpeed
-	 */
-	if (is_ss ^ (dwc->speed == USB_SPEED_SUPER))
-		return;
-
-	/* enter hibernation here */
-}
-
 static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_devt *event)
 {
@@ -4233,29 +4338,18 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_conndone_interrupt(dwc);
 		break;
 	case DWC3_DEVICE_EVENT_WAKEUP:
-		dwc3_gadget_wakeup_interrupt(dwc);
+		dwc3_gadget_wakeup_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
-		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
-					"unexpected hibernation event\n"))
-			break;
-
-		dwc3_gadget_hibernation_interrupt(dwc, event->event_info);
+		dev_WARN_ONCE(dwc->dev, true, "unexpected hibernation event\n");
 		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_SUSPEND:
 		/* It changed to be suspend event for version 2.30a and above */
-		if (!DWC3_VER_IS_PRIOR(DWC3, 230A)) {
-			/*
-			 * Ignore suspend event until the gadget enters into
-			 * USB_STATE_CONFIGURED state.
-			 */
-			if (dwc->gadget->state >= USB_STATE_CONFIGURED)
-				dwc3_gadget_suspend_interrupt(dwc,
-						event->event_info);
-		}
+		if (!DWC3_VER_IS_PRIOR(DWC3, 230A))
+			dwc3_gadget_suspend_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
@@ -4417,11 +4511,6 @@ static int dwc3_gadget_get_irq(struct dwc3 *dwc)
 		goto out;
 
 	irq = platform_get_irq(dwc3_pdev, 0);
-	if (irq > 0)
-		goto out;
-
-	if (!irq)
-		irq = -EINVAL;
 
 out:
 	return irq;
@@ -4493,6 +4582,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget->sg_supported	= true;
 	dwc->gadget->name		= "dwc3-gadget";
 	dwc->gadget->lpm_capable	= !dwc->usb2_gadget_lpm_disable;
+	dwc->gadget->wakeup_capable	= true;
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -4580,42 +4670,39 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int ret;
 
 	if (!dwc->gadget_driver)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false, false);
+	ret = dwc3_gadget_soft_disconnect(dwc);
+	if (ret)
+		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
-	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
+
+err:
+	/*
+	 * Attempt to reset the controller's state. Likely no
+	 * communication can be established until the host
+	 * performs a port reset.
+	 */
+	if (dwc->softconnect)
+		dwc3_gadget_soft_connect(dwc);
+
+	return ret;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
 {
-	int			ret;
-
 	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
-	ret = __dwc3_gadget_start(dwc);
-	if (ret < 0)
-		goto err0;
-
-	ret = dwc3_gadget_run_stop(dwc, true, false);
-	if (ret < 0)
-		goto err1;
-
-	return 0;
-
-err1:
-	__dwc3_gadget_stop(dwc);
-
-err0:
-	return ret;
+	return dwc3_gadget_soft_connect(dwc);
 }
 
 void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-- 
2.43.0

