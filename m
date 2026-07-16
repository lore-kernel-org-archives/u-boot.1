Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9E5C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9386C84E74;
	Thu, 16 Jul 2026 18:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nhghkv+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D5284CC4; Thu, 16 Jul 2026 15:44:35 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933A284CF1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15de30790bso60040966b.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209473; x=1784814273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5dOhO1ScEWoawMhki3UqeCMIzJRJEkS18bTxB/IIPcA=;
 b=nhghkv+0v4ifLUvRNU9vDWCGRqBC22pn8bOwhm/DYwBHnxcxcr70jRWtFL3MRYN97k
 xupsB+d3br1Mzal369e7AbVNMDWRy0K5Ok/L4sJ33RREGdPrMw3T3zx2IL1eaCxz9BdW
 QukiosMrmR58nMOZyNLj3pEdtl2j5fUjDjmLfEVOFF8S0ljFC6g9Vpik7JJrQ6jPoG15
 4d6NQTPfGa00o84Y4hkIibCVs2aIyNnKQ3RRKFnMYT4RNzJ1YP3ieCHOMIsAb7ZJQvz/
 e1MIL2JveVBXcTRA5DVlPAZLnmyBy3CrFOU7+4JO1ltjUcFS1JCirlPq8nfBHiqjvUvt
 128A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209473; x=1784814273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5dOhO1ScEWoawMhki3UqeCMIzJRJEkS18bTxB/IIPcA=;
 b=SMAUx72k1NTwjwJCEn+l9vun/r8KTZe1khdtl5e7ymoVwl9zAsj7TdVQbb0i03EyrJ
 nce+UiXKh4NlPB8sFbTFvk9Ck04FWAgY28d/1G148AlE/TWXiDftD8K9swdAE76XKNv/
 PdEcVVUxzBkOuNREQbVbfBLvZFsMHbqHDyHItbB+43wjP4xtrTn/kCeAhwhpAc0vLyL1
 n573Y//flLrlYbKAIgFnRGgc6Ku9zdnGuhQbDdIkY+88EyNd5s++2V/zDtA3moJQXBEP
 l8cd6qq8TjKZfQ1CC5IXWNN3jjbH+quZx6D2D+Qxgo+nYisEKxPsjuHpUOPF03UNztVE
 j7mQ==
X-Gm-Message-State: AOJu0YyqKtLEMeLAZCmKBuhr9SgHwdv2keSa6yWQ92FQgJJvDeSILpxT
 v9czp/mo24yB63QzwaDVnPxq1h7dV8GfOaKabBB2Sgl40fPHnNA5pyPgbNdirgT+jI44/UD/mb/
 l2XiK
X-Gm-Gg: AfdE7cnuSXbS5I1hbNZFHsXh2PVBFsRylWld4EggGQsJm4CEIdmvhmBuf2Mn70aWZY7
 x5mxMHmmD3xeBKUEQQdsWBTbPiVOJzifSBPLH321cS3zNXW7+Hk5u3bwXjb33DXPDD/rYHphbwi
 /IuSnkd76oGW0LTzprdJ51bszq4/4W9f4QCJ/9xxo5vn6ImxjLOR4iRmKl5J/M931XlVe7kV0HL
 5y4wrlVJ9J7PUf1beJTfHpqYSDH2QNx/bV/dEX20vIDo3G866Mex26R6WyTUaWVUt3sk5hNvTqU
 a7pUfmunVdmG8Svc+ulsR8feF/5FkRqy03SMWTyMKPs7PYb2v0bgmSgpzi2PdkrX/BQmIoD5zKT
 dCXP2HPqeDf7+wmUw/0Eh7Gdukynk+sYkQZTPjU7I3abP0hJwF55t7cfoodH7TifPjGiAl8xDSq
 LHPvMje8MKqPjXSVRNKkNytsftJCpJEuuuzF0vNw==
X-Received: by 2002:a17:906:f5a1:b0:beb:967f:1ca8 with SMTP id
 a640c23a62f3a-c161e923281mr688898666b.2.1784209472772; 
 Thu, 16 Jul 2026 06:44:32 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1687125f2asm219630266b.10.2026.07.16.06.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:32 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 56/75] usb: dwc3: import from kernel v6.12
Date: Thu, 16 Jul 2026 15:42:26 +0200
Message-ID: <20260716134305.614278-57-anders.roxell@linaro.org>
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
f35860242548 usb: dwc3: Use of_property_read_variable_u32_array() to read "power"
89b7539123bf usb: dwc3: imx8mp: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
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
2.53.0

