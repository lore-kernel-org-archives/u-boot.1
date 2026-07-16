Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59863C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96CB184ECB;
	Thu, 16 Jul 2026 18:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zkVe0zzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B88F84CC4; Thu, 16 Jul 2026 15:44:09 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19DE784C3F
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15e62c695cso54123166b.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209446; x=1784814246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SN1dBm1c1Sx6v/dHlwKjb1oS64oT0Nls1+3R6BSqFOw=;
 b=zkVe0zzQ8CFdsXFLIIUQqkUJA+GIgexmrctBUyWzmyBdddpH3cYS2sR2V5Ums4UpQI
 Vhmk4D1a2l4QJCG3TuiiudKKHvsjyIG9nBe3Xq4dBrcUyjldGlGHHbttI5cpgYrGnu6m
 WuIiTFODWqtr2jPPGuF9IyJnzUZnESkloR/Ss2nAvkuj4hV2ZzRAPUJzIovscmWYe+VU
 Agr7G3Mrdxn/STleSmU8Dos5gF3oNBlvSofYjEPKw+hz4HmYRi2n6dvqIdZQ9liwJbqg
 hbNASmkCBxEmUPrS/Cq11370fK6j+lbn9wmOWd5ucsI7eR49V5H9qTADkdX6zFW1kBMS
 Zj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209446; x=1784814246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SN1dBm1c1Sx6v/dHlwKjb1oS64oT0Nls1+3R6BSqFOw=;
 b=P6KUf7VbqLBqTPhiH/m6JwRGRZAyndcPyf7XGguakMUqYexfv4bAXIEW6MD6HYTgd2
 gQuZJBjNe9OLyxB40ScwBLazViLD6B02SiABOD9ba10xa9Kh98pQre3BCzgmnKlg/pFs
 sTRoJUiyXBOHTVzBJrrXRdNjOb7EA2oprzQWKy8PIOE1wqm+yxmT9r9Fbb4vrsm3uT06
 MEvTB9kOoxW2fVCHmo6bsjPS+RFruStm2hxHd71L0jbQx57E5twEHenMt9A6wjiHTV8o
 Lf5j/ky4OtpuzB1MVknmiwdoJ0eMbLAOR/Promlq2QBYkstn0xEhLu98pKS/p7SGsQ4j
 98og==
X-Gm-Message-State: AOJu0Yz78dwJOOoQiKyNttVRyCCYiEL382JnZrEcq0SOrMFN54x56YGN
 b4cMH6+SZOKLejNCw7T4jfX8X55NDD6Nr7iocry8bXcU9WctGLS3NOHaUzfS7uiI8BXwcM/bVrE
 ZOQ3B
X-Gm-Gg: AfdE7cn4MvkE2Sor9hFn7MzY0FGEW308fooGcLkjpcpsve1y8GSR2eZT+tYco4vVEh6
 xlMCEL/QownXge3CgcfxWJNC4Sj7w27rTbSy1fZMWq66UCL2hN2+OKbz32q1YFEUrVHvg9IDxKM
 BWcf8aMZovY53Plis8jyGB0h9CYkWR7QurC/KsgAv4cTgIrEchkHFKCcWomQ9bTmpqtsNKtsNeh
 m4hAyAzkZPi/X/B2pq1aiRmOyEt0lS6dzUTzLHbj7x+fJoPWBMXyQL1fzumK4hPUtCYlUVC5jtk
 CFKqbMZokkniPp+TGJide25nl+nSbQAcmsX3Xgj449Q+FECezJHP8MFfFl5Mdmbqi0N9EmJC63Y
 gzeHsdBbsNwrdk2jGwCiPCfpZRj1tueJcISZ2HDygHmTEAQPm0llxA8/p3FLbLDG2r2hOmrWQgr
 vsh+i2+dsKHAC5DTyEe/8E3hjJgZ80XoEtzDuPhg==
X-Received: by 2002:a17:906:6a28:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c161de22dbemr669222466b.0.1784209446318; 
 Thu, 16 Jul 2026 06:44:06 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1687172f01sm214016766b.24.2026.07.16.06.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:05 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 38/75] usb: dwc3: import from kernel v5.14
Date: Thu, 16 Jul 2026 15:42:08 +0200
Message-ID: <20260716134305.614278-39-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.13 to v5.14.

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

List of commits: git log --oneline v5.13..v5.14
Commits imported:
4a1e25c0a029 usb: dwc3: gadget: Stop EP0 transfers during pullup disable
51f1954ad853 usb: dwc3: gadget: Fix dwc3_calc_trbs_left()
664cc971fb25 Revert "usb: dwc3: gadget: Use list_replace_init() before traversing lists"
cb10f68ad815 usb: dwc3: gadget: Avoid runtime resume if disabling pullup
d25d85061bd8 usb: dwc3: gadget: Use list_replace_init() before traversing lists
40edb52298df usb: dwc3: avoid NULL access of usb_gadget_driver
84524d1232ec usb: dwc3: Fix debugfs creation flow
8562d5bfc0fc USB: dwc3: remove debugfs root dentry storage
45d39448b4d0 usb: dwc3: support 64 bit DMA in platform driver
2a042767814b usb: dwc3: core: fix kernel panic when do reboot
5ff90af9da8f usb: dwc3: debugfs: Add and remove endpoint dirs dynamically
ab00a41e73dc usb: dwc3: trace: Remove unused fields in dwc3_log_trb
457d22850b27 usb: dwc3: pci: Fix DEFINE for Intel Elkhart Lake
374ac7448caa usb: dwc3: remove repeated setting of current_dr_role

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c   |  7 ++++-
 drivers/usb/dwc3/core.h   |  3 +-
 drivers/usb/dwc3/ep0.c    | 10 ++++---
 drivers/usb/dwc3/gadget.c | 59 +++++++++++++++++++++++++++------------
 4 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4ac397e43e19..ba74ad7f6995 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1545,6 +1545,10 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
@@ -1616,17 +1620,18 @@ static int dwc3_probe(struct platform_device *pdev)
 	}
 
 	dwc3_check_params(dwc);
+	dwc3_debugfs_init(dwc);
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
 		goto err5;
 
-	dwc3_debugfs_init(dwc);
 	pm_runtime_put(dev);
 
 	return 0;
 
 err5:
+	dwc3_debugfs_exit(dwc);
 	dwc3_event_buffers_cleanup(dwc);
 
 	usb_phy_shutdown(dwc->usb2_phy);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c5d5760cdf53..5991766239ba 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1013,7 +1013,6 @@ struct dwc3_scratchpad_array {
  * @link_state: link state
  * @speed: device speed (super, high, full, low)
  * @hwparams: copy of hwparams registers
- * @root: debugfs root folder pointer
  * @regset: debugfs pointer to regdump file
  * @dbg_lsp_select: current debug lsp mux register selection
  * @test_mode: true when we're entering a USB test mode
@@ -1222,7 +1221,6 @@ struct dwc3 {
 	u8			num_eps;
 
 	struct dwc3_hwparams	hwparams;
-	struct dentry		*root;
 	struct debugfs_regset32	*regset;
 
 	u32			dbg_lsp_select;
@@ -1281,6 +1279,7 @@ struct dwc3 {
 	unsigned		dis_metastability_quirk:1;
 
 	unsigned		dis_split_quirk:1;
+	unsigned		async_callbacks:1;
 
 	u16			imod_interval;
 };
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 3cd294264372..2f9e45eed228 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -597,11 +597,13 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	int ret;
+	int ret = -EINVAL;
 
-	spin_unlock(&dwc->lock);
-	ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
-	spin_lock(&dwc->lock);
+	if (dwc->async_callbacks) {
+		spin_unlock(&dwc->lock);
+		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
+		spin_lock(&dwc->lock);
+	}
 	return ret;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f14c2aa83759..ccb68fe6202e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -940,19 +940,19 @@ static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
 
 static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 {
-	struct dwc3_trb		*tmp;
 	u8			trbs_left;
 
 	/*
-	 * If enqueue & dequeue are equal than it is either full or empty.
-	 *
-	 * One way to know for sure is if the TRB right before us has HWO bit
-	 * set or not. If it has, then we're definitely full and can't fit any
-	 * more transfers in our ring.
+	 * If the enqueue & dequeue are equal then the TRB ring is either full
+	 * or empty. It's considered full when there are DWC3_TRB_NUM-1 of TRBs
+	 * pending to be processed by the driver.
 	 */
 	if (dep->trb_enqueue == dep->trb_dequeue) {
-		tmp = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
-		if (tmp->ctrl & DWC3_TRB_CTRL_HWO)
+		/*
+		 * If there is any request remained in the started_list at
+		 * this point, that means there is no TRB available.
+		 */
+		if (!list_empty(&dep->started_list))
 			return 0;
 
 		return DWC3_TRB_NUM - 1;
@@ -2243,10 +2243,19 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
 				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
-		if (ret == 0) {
-			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
-			return -ETIMEDOUT;
-		}
+		if (ret == 0)
+			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");
+	}
+
+	/*
+	 * Avoid issuing a runtime resume if the device is already in the
+	 * suspended state during gadget disconnect.  DWC3 gadget was already
+	 * halted/stopped during runtime suspend.
+	 */
+	if (!is_on) {
+		pm_runtime_barrier(dwc->dev);
+		if (pm_runtime_suspended(dwc->dev))
+			return 0;
 	}
 
 	/*
@@ -2447,6 +2456,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
+	dwc->delayed_status = false;
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
@@ -2585,6 +2595,16 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 	return ret;
 }
 
+static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->async_callbacks = enable;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
@@ -2596,6 +2616,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_set_ssp_rate	= dwc3_gadget_set_ssp_rate,
 	.get_config_params	= dwc3_gadget_config_params,
 	.vbus_draw		= dwc3_gadget_vbus_draw,
+	.udc_async_callbacks	= dwc3_gadget_async_callbacks,
 };
 
 /* -------------------------------------------------------------------------- */
@@ -2798,7 +2819,9 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
-		debugfs_remove_recursive(debugfs_lookup(dep->name, dwc->root));
+		debugfs_remove_recursive(debugfs_lookup(dep->name,
+				debugfs_lookup(dev_name(dep->dwc->dev),
+					       usb_debug_root)));
 		kfree(dep);
 	}
 }
@@ -3229,7 +3252,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 
 static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->disconnect) {
+	if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->disconnect(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3238,7 +3261,7 @@ static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 
 static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->suspend) {
+	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->suspend(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3247,7 +3270,7 @@ static void dwc3_suspend_gadget(struct dwc3 *dwc)
 
 static void dwc3_resume_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3259,7 +3282,7 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return;
 
-	if (dwc->gadget->speed != USB_SPEED_UNKNOWN) {
+	if (dwc->async_callbacks && dwc->gadget->speed != USB_SPEED_UNKNOWN) {
 		spin_unlock(&dwc->lock);
 		usb_gadget_udc_reset(dwc->gadget, dwc->gadget_driver);
 		spin_lock(&dwc->lock);
@@ -3583,7 +3606,7 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 	 * implemented.
 	 */
 
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
-- 
2.53.0

