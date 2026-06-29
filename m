Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E24AC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC44684B0E;
	Mon, 29 Jun 2026 10:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j1JMHbs6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2D684B04; Mon, 29 Jun 2026 10:47:52 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337C1849D2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-39b030e889aso7827481fa.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722869; x=1783327669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hijCBN+zUvaqPpJo8PiYLE9m/EyjbMtLvohqbvtRdw=;
 b=j1JMHbs6RhMu6L4bq9edXBkCjxRbmvezbZw3tXpAliCc2P+xUIsc7pGkefm7ebdDmX
 vEy07OyVYzIgyt3Y7F2mrirh2Y1FmaPQHgVc91wiwVyg060wfmAe76cuIjr3x8raw1q8
 ZkImLVk77G4c3cOHNSjMEFzs8Gxsl08IsEOdUx/cf/joq8W1/NfbqtfSL+u8HCNnHPO0
 7x2HWnNp3AkgKyW1cYkLyrkG2Xm3enpLIoQOnqeTsfCRFLfy46mNXRim2ax2JDxoxPjp
 9bNcqX/x4u2J1JHn9wFF7zJmPPsuSukMEGm6WKvKF1rhv7pcAY/Ewk0Y6sJPZVDEVCOc
 Uf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722869; x=1783327669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+hijCBN+zUvaqPpJo8PiYLE9m/EyjbMtLvohqbvtRdw=;
 b=OY2GbkOEz03yzupyVLbFa7rAwlhwCFlhGxqVV1f0qTBYLOTxN0egptkxRAZqGR9out
 e+GTLL24XtZ2sK9cHhj6V7dDr5euxfJNirlKESF6h/+IOmP4ZhYT89Rx4jidTxOtgT5x
 A7NpDr+RDG/gOmc69tLUqApDVaJ7ybNgX7bXMLnn+yqVMwCIylFITKSZ/5oXqAz0E+5N
 GUIJuTgq6XrUR43YxrIcMHHG/4LmusjtSu+RtF/GkVt8/yC0IgXDz8J6W4iy+HTtlSjQ
 CAY3eWmFSkQWrjXCVQgv85P47zOCDRsnDfLYxkgAajI/6OrojYqcLePdgHFuHmfe3xgk
 VGWw==
X-Gm-Message-State: AOJu0YyIg4yFSx1g6IHuFD7MS9frFLodyh+8qBJ/PU4m/glYnBHGTZid
 y0eyCJzZum4vTS1VNrs/1Q4hQS0WTzTgJWxu3nehfvkAeKtcGXy0XnEen/nwlKMbZ33l1Taylk/
 NRLyw76I=
X-Gm-Gg: AfdE7ckCr/v+DUb95WZKNPHIVhQACKTleiQuM6IrBhI/X81ubUwL4DJ8YcH29yd7dBh
 bP2bHYzPdJlAa2B4J/cYwop1wa9BgO6te1C25F4QoyI+uiIMjDr6QtsbPxqLW1KG52TkPz/aQv0
 z37G51AL1ETMHaZfW/gdj71ed9fI4+rtRZSDaXcaWG1PXfc8YLAuBtdLeHBhJDN/rNcXLbVr64d
 W+SyOEA6awnLtoMY/a2kkXCwsb6RcuhrHE63p5UleFpAVqnha9y/MrI0vrCdj3pH0vjUqM0hy87
 48YHF0Sz7EeTHgIcjQmS128acvNkmyG+kpErujMikPeP2XXjKVfXl5E5LzpoKC6xpL7BYdP3QhH
 rLma31AO5+K5DsQeEbKNroXCOVaM8NrpHe/Q72Nb05PaxgRnDzvuNgOZvEARidnnoE8bkMMfpBs
 qRXV1Es2lHLXgDybte1fq6P1zCIpSC+ChwCoEljpb/WebxmqRX4uDw4qtPQaNSMIcc/P2atBdZQ
 Yek6o1Xca32zPAEQPcxJ0mmVy5aRHQ=
X-Received: by 2002:a05:651c:19a4:b0:39a:f67a:de2b with SMTP id
 38308e7fff4ca-39af67ae291mr13022361fa.38.1782722869297; 
 Mon, 29 Jun 2026 01:47:49 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:47:47 -0700 (PDT)
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
Subject: [PATCH v4 56/64] usb: dwc3: import from kernel v6.12
Date: Mon, 29 Jun 2026 10:44:32 +0200
Message-ID: <20260629084507.3254232-57-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.11 to v6.12.

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

List of commits: git log --oneline v6.11..v6.12
Commits imported:
9cfb31e4c89d usb: dwc3: fix fault at system suspend if device was already runtime suspended
705e3ce37bcc usb: dwc3: core: Fix system suspend on TI AM62 platforms
c96e31252110 usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG
0d410e8913f5 usb: dwc3: core: Stop processing of pending events if controller is halted
897e13a8f9a2 usb: dwc3: re-enable runtime PM after failed resume
e8afd5ace118 usb: dwc3: rtk: Clean up error code in __get_dwc3_maximum_speed()
4664b73859dc usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep
a9400f1979a0 usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode
f299cd11f753 Merge 6.11-rc7 into usb-next
e23593ee41fa usb: dwc3: xilinx: simplify with dev_err_probe
819c0c31a78e usb: dwc3: rtk: return directly and simplify with devm_platform_ioremap_resource
f93e96c544ca usb: dwc3: rtk: use scoped device node handling to simplify error paths
17d206a3687e usb: dwc3: qcom: simplify with devm_platform_ioremap_resource
a85f13d50925 usb: dwc3: qcom: use scoped device node handling to simplify error paths
34e8df2fb2de usb: dwc3: imx8mp: use scoped device node handling to simplify error paths
81d905b10220 usb: dwc3: imx8mp: simplify with dev_err_probe
3fdfebc58e0d usb: dwc3: imx8mp: simplify with devm_clk_get_enabled
fcc78cce2f96 usb: dwc3: st: simplify pdev->dev usage
a93c3ad6a9b2 usb: dwc3: st: simplify with dev_err_probe
bde053252c02 usb: dwc3: st: use scoped device node handling to simplify error paths
35f4a629641b Merge 6.11-rc6 into usb-next
f35860242548 usb: dwc3: Use of_property_read_variable_u32_array() to read "power"
89b7539123bf usb: dwc3: imx8mp: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.c   | 48 ++++++++++++++++++++++++++++++++-------
 drivers/usb/dwc3/core.h   |  7 +++---
 drivers/usb/dwc3/gadget.c | 21 +++++------------
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9eb085f359ce..98114c2827c0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -544,6 +544,7 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
 	if (!dwc->ev_buf)
 		return 0;
@@ -556,8 +557,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 			upper_32_bits(evt->dma));
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 			DWC3_GEVNTSIZ_SIZE(evt->length));
-	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
 
+	/* Clear any stale event */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
 	return 0;
 }
 
@@ -584,7 +587,10 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0), 0);
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), DWC3_GEVNTSIZ_INTMASK
 			| DWC3_GEVNTSIZ_SIZE(0));
-	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
+
+	/* Clear any stale event */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
 }
 
 static void dwc3_core_num_eps(struct dwc3 *dwc)
@@ -2336,6 +2342,19 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	u32 reg;
 	int i;
 
+	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
+		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
+				    DWC3_GUSB2PHYCFG_SUSPHY) ||
+				    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
+				    DWC3_GUSB3PIPECTL_SUSPHY);
+		/*
+		 * TI AM62 platform requires SUSPHY to be
+		 * enabled for system suspend to work.
+		 */
+		if (!dwc->susphy_state)
+			dwc3_enable_susphy(dwc, true);
+	}
+
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
@@ -2454,6 +2473,11 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		/* restore SUSPHY state to that before system suspend. */
+		dwc3_enable_susphy(dwc, dwc->susphy_state);
+	}
+
 	return 0;
 }
 
@@ -2499,7 +2523,11 @@ static int dwc3_runtime_resume(struct device *dev)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		dwc3_gadget_process_pending_events(dwc);
+		if (dwc->pending_events) {
+			pm_runtime_put(dwc->dev);
+			dwc->pending_events = false;
+			enable_irq(dwc->irq_gadget);
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 	default:
@@ -2552,7 +2580,7 @@ static int dwc3_suspend(struct device *dev)
 static int dwc3_resume(struct device *dev)
 {
 	struct dwc3	*dwc = dev_get_drvdata(dev);
-	int		ret;
+	int		ret = 0;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -2560,14 +2588,12 @@ static int dwc3_resume(struct device *dev)
 	pm_runtime_set_active(dev);
 
 	ret = dwc3_resume_common(dwc, PMSG_RESUME);
-	if (ret) {
+	if (ret)
 		pm_runtime_set_suspended(dev);
-		return ret;
-	}
 
 	pm_runtime_enable(dev);
 
-	return 0;
+	return ret;
 }
 
 static void dwc3_complete(struct device *dev)
@@ -2589,6 +2615,12 @@ static void dwc3_complete(struct device *dev)
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
 	.complete = dwc3_complete,
+
+	/*
+	 * Runtime suspend halts the controller on disconnection. It relies on
+	 * platforms with custom connection notification to start the controller
+	 * again.
+	 */
 	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
 			dwc3_runtime_idle)
 };
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c71240e8f7c7..eab81dfdcc35 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1150,6 +1150,8 @@ struct dwc3_scratchpad_array {
  * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
+ * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY + DWC3_GUSB3PIPECTL_SUSPHY
+ *		  before PM suspend.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1382,6 +1384,7 @@ struct dwc3 {
 	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
 	unsigned		suspended:1;
+	unsigned		susphy_state:1;
 
 	u16			imod_interval;
 
@@ -1675,7 +1678,6 @@ static inline void dwc3_otg_host_init(struct dwc3 *dwc)
 #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
 int dwc3_gadget_suspend(struct dwc3 *dwc);
 int dwc3_gadget_resume(struct dwc3 *dwc);
-void dwc3_gadget_process_pending_events(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
@@ -1687,9 +1689,6 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
 	return 0;
 }
 
-static inline void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-{
-}
 #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
 
 #if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 291bc549935b..4959c26d3b71 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -438,6 +438,10 @@ skip_status:
 			dwc3_gadget_ep_get_transfer_index(dep);
 	}
 
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
+	    !(cmd & DWC3_DEPCMD_CMDIOC))
+		mdelay(1);
+
 	if (saved_config) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		reg |= saved_config;
@@ -1715,12 +1719,10 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	if (!interrupt) {
-		mdelay(1);
+	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	} else if (!ret) {
+	else if (!ret)
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-	}
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
@@ -4728,14 +4730,3 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 
 	return dwc3_gadget_soft_connect(dwc);
 }
-
-void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-{
-	if (dwc->pending_events) {
-		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
-		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
-		pm_runtime_put(dwc->dev);
-		dwc->pending_events = false;
-		enable_irq(dwc->irq_gadget);
-	}
-}
-- 
2.43.0

