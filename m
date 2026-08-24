Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3078DC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3D2160788;
	Mon, 24 Aug 2026 16:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DolW1dFzkCnG; Mon, 24 Aug 2026 16:45:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589916;
	bh=nM5bY1ZfJVqY3TBpEZPLy0Pbz02Wk3i27SowhRb7xqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i955RgGpupajJI3LrClhhbKunZj5aA1Y657pM0XBMJ3pm4TERuo2+IZHw7SbDdGKp
	 tLn7flF7LCuYyVjtJn66V4tpgooWdJ/yF7//d1CUeHPGdvgyh0yCKcMkG+WYuVWEvm
	 OUMwiGS0jaMU79EnIS0gsLgrwFilpzEIPpZZdTEC109vGlLdyxlUX8IZJ2FGMNaEQx
	 9xd0Ay9W/7XLbf4D+9ocVQfzaKDddRDmRGDmsoSiKRVfeNdVIIvrc5/hPnPjmQ2VPT
	 oFI1RknbYLFAUL3K6V/CCuoFiRTpj2d63QkkAh/jNoKGMhYyrRs4vshuVhU/grxi6M
	 D4FVZuX/JXtuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D817D6075F;
	Mon, 24 Aug 2026 16:45:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AE723AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 413B580944
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D3wDLol0V2Ml for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:32:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=zk/O06Rg
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAA0A808C1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:06 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c20e4487bdaso29583566b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585525; x=1788190325;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nM5bY1ZfJVqY3TBpEZPLy0Pbz02Wk3i27SowhRb7xqU=;
 b=zk/O06Rg5f4EJ6+7ot1nG/6NzVKtApHu4LwtrIV2QiEABp8wiZxmwOfdazaSvkJxy5
 WX3SKSZ5107/Rsmd9uTyjbk3f8sqwDOV3laJxi6oN9o/5BHgG1U//uEYcr5cQ6DLxxfN
 CtOCkWeAaBzFyeYQV07wz3vwf+aJVi4Z3ltGrrqT/vX+bQJ9QdLX26I7PPCC+JuD1Qtv
 3r3dpzwS6mBXTPaTfIb5BJovodREvi72rnxmeUfNmK1XCYnplzD9jrkRQaiHNeSOTbQo
 LmaA/pFSeJP6ep+jDL/CzVPPf6kT1rCjRApFAfYPIiBBCQeFFOEcMJ+TTV9u9lUOKgcz
 62yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585525; x=1788190325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nM5bY1ZfJVqY3TBpEZPLy0Pbz02Wk3i27SowhRb7xqU=;
 b=sZcHl59ifv6DOzpjk9wCzjyD5AOe54vgXtwUUYwl0ee9+ydDAyLIgJj/lojLIYyjaT
 3wf3s/GIcXG7qPkV2Akh93kvud7bQYQ2+b/vJRNV+ufs1M3xpTyri/pOSujYu27J0Ovv
 Ntwh3JfHw6dslwPp8FOKqOV5HmZ7cUO32Jf2qsFr9u158PkFBUCdbQZXPFyVqiSOtyyv
 jeMI3Hc9hl48BHbtbwK/2P5fCtWWKlNx9bytA4BZFOPEPMC+v5aN9i0x6MlFYt9sf4ix
 48G0mJoLIp3EmuyhvGoDiuU6ix2xv1gZWFKpiMOEnL9hW+lDt5easp7otNzFGquWkus7
 /Osw==
X-Gm-Message-State: AFuF++k81o6kE+JSqIiEL/9+S+YKSUiDQrEw7WPDOQroV34Flq1+H1Sl
 dHA1zdaXKAJVWBLAsAYoqEXpjh6X0JEJJtXxtK+b5qBgYSavVtH9rdGRiVNNnH8ogGGyQGg2f1Z
 oEda2
X-Gm-Gg: AR+sD10gLx2dhsO9WX2NKuNtsENsECX7G4C0pgaSxnNE6aASdLZXDt4eSTYLOAD6i0t
 +RR1DsgH4I9sKsfp/KNFxMiZSevY3386jkch4liThbq2j3J561bGi4vga9apBgOPDcf414iLINf
 dlgtB+DHnsJUM8sLBLxYb09adSyyEcKnawcSKZY6aLUiHLT1NHkIuUoPEL+H65eK6cbNg3uj1lK
 0+Tq5xSf+YczUKhudbLK7Bp5cX7lmj2rgj4zOXf4Rr/pIwjh4smXH9Ik0KOQNGZ6vqA3ncMTdBn
 l9FwM75b1BxCExkNqR4BuussMX+W/5fM7V3uzK6i2c+spFEKTKGs9CStIk9BssOrXqCfHyTRenM
 aaG5oN0zg9f1QG26Q8Snq0aohT/fikAsWLSkB7zRZY+E7S0VTT9AQ+I9n6L28j/0P74Fd7GI1gN
 KbrLlQGMJlh9J0XVpd730JXdDRx7LJYrUE+HfvrqKYBHduXttqfoIjmf7oVm7GLEkOFHnN4nrCg
 afIvL8sGkMkrrWDO3iz0w==
X-Received: by 2002:a17:907:f497:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c246a61c431mr1523157366b.3.1787585524797; 
 Mon, 24 Aug 2026 08:32:04 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b208sm1233541266b.10.2026.08.24.08.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:32:04 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 57/63] usb: dwc3: import from kernel v6.12
Date: Mon, 24 Aug 2026 17:27:28 +0200
Message-ID: <20260824152734.159794-58-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.11 to v6.12.

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

List of commits: git log --oneline v6.11..v6.12
Commits imported:
9cfb31e4c89d usb: dwc3: fix fault at system suspend if device was already runtime suspended
705e3ce37bcc usb: dwc3: core: Fix system suspend on TI AM62 platforms
c96e31252110 usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG
0d410e8913f5 usb: dwc3: core: Stop processing of pending events if controller is halted
897e13a8f9a2 usb: dwc3: re-enable runtime PM after failed resume

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

