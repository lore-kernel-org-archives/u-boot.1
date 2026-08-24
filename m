Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555F0C5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1209F60678;
	Mon, 24 Aug 2026 16:45:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Iou3PDY4FtT; Mon, 24 Aug 2026 16:45:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589899;
	bh=dc5I1l0DzlmvXXcQQpVSCn/ymPQYd6rLdeH0CJz7IDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PM2U6nmbpKg/5VtwW6VSFWjw87BUDh1EkqP+qEo5yLu1q7BqpSGDkmnIAG+m77miO
	 0GD1f8mcMOKfTTQ5ppXuVNQaDa0lSCRrTExn4ES3zeLdYf4cre72MmiCPsjLmNDWMG
	 NaSEiclFkHZ4Mkn7gTjCqB70aFoHvfKerQtIFRPzzarmfGk2Q3d0sd9u/gzXkjDbrS
	 wHdFF2aRbrS9+SqWCeQGTB66rOHRt3oxCJA/aIEnK4KTM8OgVebJoVZ/fOb0SxA+Pb
	 NhQQyA1w0tyMVbEHRsFqtbzAjxOUSYiokCzmkP5jMMJdGnKG7BbE4UoavVGjRWz+9K
	 iPcOMQZLlsIZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 125BA60687;
	Mon, 24 Aug 2026 16:44:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CB0C42B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83A6D403EB
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j3SDvC2oiD3T for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:31:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=uQONGwK6
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D5CC403F6
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:17 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c2193c18362so46392666b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585476; x=1788190276;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dc5I1l0DzlmvXXcQQpVSCn/ymPQYd6rLdeH0CJz7IDk=;
 b=uQONGwK6P5fIBa2T1ririyRt7+rWtVsXz/Z7Vpkbj317sceiRuyiQFVvQLQA069f0G
 Z5wGXI4uNfj1SvZaM94wZp0qHw6k8nZSt0UpQf/zesqu6GIo2sHSAS9iGG3mCxTExmEI
 6j8IrpuBnoxHOfA/1jX9elXPsFoCubNrTavVVndvD0mtGiD+OoY2D86Fs9nttZhupgeW
 SxvD4DFqb3mWDvG6a4XtTi91bzu9LhYte5wDlijtWREYO8xxVgxQp6JJ5aKWaEfOilt/
 GzxQu4tm9gGnzMj88MoTEnv0chIlIKdWgasPkGuoaFUMfkwFqLLGzbi9e6qsetyP9bbb
 5VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585476; x=1788190276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dc5I1l0DzlmvXXcQQpVSCn/ymPQYd6rLdeH0CJz7IDk=;
 b=hKTwqd1iEqtBx6Awlqhn6M7YmEjKv5OkYe5EPJ43RYrH9hsXqNvbXjdDiFxvWzTJaQ
 B4N/g3w61xQGVwZ04YHBmCPUKO+1+IlEuGPV1hI6JZcF9FvJeKwwQcYQ7prJ4kX59vW2
 apnYzxQvaciqv4H/Yq+zcY9p+Qfi11NX1Dmkl1qleFDYwNzdAmuW+QBJw47FD9L1g8GY
 oEeaR+4S+hxjDqsliaemJ+npB7H42X1ysNbnaeurCXqmO+Y5TSXxy1k4ZKbPj2gjnykT
 JhSMaaUazsj7U8K2JlD8HPFc8OIPjYLjca39FQi22b1y6guZNUl6+k3u0fBWzYPDh+68
 3JAw==
X-Gm-Message-State: AFuF++mEtD3kCu0ZEJKcLQCo+P4pl1DR1ul4oe0JPinng2ZHQyy/GDT7
 7VY4cKxWm/IEShyZunMJ082SnCqNOtQd1bYibXSHnJA0VDxXFOrUp1+eLkbBKSpZ6Uhi86pfjfh
 cuMMU
X-Gm-Gg: AR+sD11gjzRs6dOKl6GQV0n7EaS67Dh4DrMyZRglOpyGua3a1wJMXWjcLvla07EQfe6
 UHsYU+eLrEXmUGlrVBq2f1vIJY0JIoYlw+y3E4UnfCwwXHIcVp6f3XPTd/V5zP2njoWYgLC05Yp
 1Kd5Pj5dqtZbVQgZVDCs0SMJpQKUAQWVi0tBavMQl4wU/yXJth/4Oj9opf8bcfoQHmDHBVEidWh
 kUGumNIbl+yFQfo/FnRDwc6R9NLv3joe/cT7YnMLOJn6dyM5uMyOctmNaSR3MgRZzMGDfnZcOAi
 3u/RRmOcFA4C6lSYYjjcIHbmhIxG1PYmilpESmpTR9lYcvAWJRFmdI0qLxMbWlhP6wb2O8zgQd7
 O4vrvAsCi6uPkaPnTxWjnIQwrewrbtEP6vp+l2GhZBllmR1BxxvzS1Ktv8fQ4YBD4STg56Ev2i4
 SSvaAKP5qFj+u1/ur/y9QHhY9g/waLZeoen1s6rxwR0sAiL8Wi3uvCaoojVbW1OKC+SAwo2xdga
 RRXqZDg+90LrvdyHxGtGQ==
X-Received: by 2002:a17:907:2951:b0:c24:908b:4e2e with SMTP id
 a640c23a62f3a-c24908b53c9mr747043066b.4.1787585475580; 
 Mon, 24 Aug 2026 08:31:15 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm1479917366b.18.2026.08.24.08.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:31:15 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 45/63] usb: dwc3: import from kernel v6.0
Date: Mon, 24 Aug 2026 17:27:16 +0200
Message-ID: <20260824152734.159794-46-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.19 to v6.0.

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

List of commits: git log --oneline v5.19..v6.0
Commits imported:
91062e663b26 usb: dwc3: core: leave default DMA if the controller does not support 64-bit DMA
040f2dbd2010 usb: dwc3: gadget: Avoid duplicate requests to enable Run/Stop
e3fafbd8e365 usb: dwc3: qcom: fix wakeup implementation
d2ac7bef95c9 usb: dwc3: fix PHY disable sequence
07903626d988 usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET during bootup
5e76ee96be8f usb: dwc3: ep0: Properly handle setup_packet_pending scenario in data stage
8affe37c525d usb: dwc3: gadget: fix high speed multiplier setting
23385cec5f35 usb: dwc3: gadget: refactor dwc3_repare_one_trb
babfcd947eba usb: dwc3: gadget: fix a kernel-doc warning
ad44cf402486 usb: dwc3: document async_callbacks field
649f5c842ba3 usb: dwc3: core: Host wake up support from system suspend
afbd04e66e5d usb: dwc3: core: Deprecate GCTL.CORESOFTRESET
fb119dcb97f4 Revert "usb: dwc3: Remove the checks of -ENOSYS"
d1b39dd5819a usb: dwc3: Fix a repeated word checkpatch warning
ca80ca61863f usb: dwc3: Fix bare use of unsigned checkpatch warning
df22ecc41b54 usb: dwc3: Remove the checks of -ENOSYS
3497b9a5c8c3 usb: dwc3: add power down scale setting

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  87 ++++++++++++++++++++++----------
 drivers/usb/dwc3/core.h   |   3 ++
 drivers/usb/dwc3/ep0.c    |   9 +++-
 drivers/usb/dwc3/gadget.c | 101 +++++++++++++++++---------------------
 4 files changed, 119 insertions(+), 81 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 573421984948..d0237b30c9be 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -158,8 +158,13 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
-	/* For DRD host or device mode only */
-	if (dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG) {
+	/*
+	 * When current_dr_role is not set, there's no role switching.
+	 * Only perform GCTL.CoreSoftReset when there's DRD role switching.
+	 */
+	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
+			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
+			dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 		reg |= DWC3_GCTL_CORESOFTRESET;
 		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -426,7 +431,7 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
  * otherwise ERR_PTR(errno).
  */
 static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
-		unsigned length)
+		unsigned int length)
 {
 	struct dwc3_event_buffer	*evt;
 
@@ -469,7 +474,7 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
  * Returns 0 on success otherwise negative errno. In the error case, dwc
  * may contain some buffers allocated but not all which were requested.
  */
-static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
+static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 {
 	struct dwc3_event_buffer *evt;
 
@@ -828,15 +833,16 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 {
 	dwc3_event_buffers_cleanup(dwc);
 
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	phy_power_off(dwc->usb2_generic_phy);
+	phy_power_off(dwc->usb3_generic_phy);
+
 	usb_phy_shutdown(dwc->usb2_phy);
 	usb_phy_shutdown(dwc->usb3_phy);
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
 	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
 }
@@ -1029,6 +1035,37 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
 }
 
+static void dwc3_set_power_down_clk_scale(struct dwc3 *dwc)
+{
+	u32 scale;
+	u32 reg;
+
+	if (!dwc->susp_clk)
+		return;
+
+	/*
+	 * The power down scale field specifies how many suspend_clk
+	 * periods fit into a 16KHz clock period. When performing
+	 * the division, round up the remainder.
+	 *
+	 * The power down scale value is calculated using the fastest
+	 * frequency of the suspend_clk. If it isn't fixed (but within
+	 * the accuracy requirement), the driver may not know the max
+	 * rate of the suspend_clk, so only update the power down scale
+	 * if the default is less than the calculated value from
+	 * clk_get_rate() or if the default is questionably high
+	 * (3x or more) to be within the requirement.
+	 */
+	scale = DIV_ROUND_UP(clk_get_rate(dwc->susp_clk), 16000);
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	if ((reg & DWC3_GCTL_PWRDNSCALE_MASK) < DWC3_GCTL_PWRDNSCALE(scale) ||
+	    (reg & DWC3_GCTL_PWRDNSCALE_MASK) > DWC3_GCTL_PWRDNSCALE(scale*3)) {
+		reg &= ~(DWC3_GCTL_PWRDNSCALE_MASK);
+		reg |= DWC3_GCTL_PWRDNSCALE(scale);
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	}
+}
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -1105,6 +1142,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err1;
 
+	/* Set power down scale of suspend_clk */
+	dwc3_set_power_down_clk_scale(dwc);
+
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc);
 
@@ -1712,12 +1752,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	if (!dwc->sysdev_is_parent) {
-		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
-		if (ret)
-			return ret;
-	}
-
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
@@ -1783,6 +1817,13 @@ static int dwc3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
+	if (!dwc->sysdev_is_parent &&
+	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
+		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+		if (ret)
+			goto disable_clks;
+	}
+
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
@@ -1839,16 +1880,16 @@ err5:
 	dwc3_debugfs_exit(dwc);
 	dwc3_event_buffers_cleanup(dwc);
 
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
-
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
 
+	usb_phy_shutdown(dwc->usb2_phy);
+	usb_phy_shutdown(dwc->usb3_phy);
+	phy_exit(dwc->usb2_generic_phy);
+	phy_exit(dwc->usb3_generic_phy);
+
 	dwc3_ulpi_exit(dwc);
 
 err4:
@@ -1943,7 +1984,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg)) {
+		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
 			dwc3_core_exit(dwc);
 			break;
 		}
@@ -2004,7 +2045,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg)) {
+		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
 			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
@@ -2081,8 +2122,6 @@ static int dwc3_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	device_init_wakeup(dev, true);
-
 	return 0;
 }
 
@@ -2091,8 +2130,6 @@ static int dwc3_runtime_resume(struct device *dev)
 	struct dwc3     *dwc = dev_get_drvdata(dev);
 	int		ret;
 
-	device_init_wakeup(dev, false);
-
 	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
 	if (ret)
 		return ret;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 81c486b3941c..4fe4287dc934 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -231,6 +231,7 @@
 
 /* Global Configuration Register */
 #define DWC3_GCTL_PWRDNSCALE(n)	((n) << 19)
+#define DWC3_GCTL_PWRDNSCALE_MASK	GENMASK(31, 19)
 #define DWC3_GCTL_U2RSTECN	BIT(16)
 #define DWC3_GCTL_RAMCLKSEL(x)	(((x) & DWC3_GCTL_CLK_MASK) << 6)
 #define DWC3_GCTL_CLK_BUS	(0)
@@ -1086,6 +1087,8 @@ struct dwc3_scratchpad_array {
  * @dis_u1_entry_quirk: set if link entering into U1 state needs to be disabled.
  * @dis_u2_entry_quirk: set if link entering into U2 state needs to be disabled.
  * @dis_rxdet_inp3_quirk: set if we disable Rx.Detect in P3
+ * @async_callbacks: if set, indicate that async callbacks will be used.
+ *
  * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists
  *			in GUSB2PHYCFG, specify that USB2 PHY doesn't
  *			provide a free-running PHY clock.
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 5d642660fd15..197af63f8d05 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -239,6 +239,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 		dwc3_gadget_giveback(dep, req, -ECONNRESET);
 	}
 
+	dwc->eps[0]->trb_enqueue = 0;
+	dwc->eps[1]->trb_enqueue = 0;
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc3_ep0_out_start(dwc);
 }
@@ -473,7 +475,7 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 	case USB_DEVICE_REMOTE_WAKEUP:
 		break;
 	/*
-	 * 9.4.1 says only only for SS, in AddressState only for
+	 * 9.4.1 says only for SS, in AddressState only for
 	 * default control pipe
 	 */
 	case USB_DEVICE_U1_ENABLE:
@@ -1140,6 +1142,11 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		if (dwc->ep0_next_event != DWC3_EP0_NRDY_STATUS)
 			return;
 
+		if (dwc->setup_packet_pending) {
+			dwc3_ep0_stall_and_restart(dwc);
+			return;
+		}
+
 		dwc->ep0state = EP0_STATUS_PHASE;
 
 		if (dwc->delayed_status) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0d89dfa6eef5..eca945feeec3 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -657,6 +657,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 /**
  * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
  * @dwc: pointer to the DWC3 context
+ * @mult: multiplier to be used when calculating the fifo_size
  *
  * Calculates the size value based on the equation below:
  *
@@ -1182,17 +1183,49 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 	return trbs_left;
 }
 
-static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
-		dma_addr_t dma, unsigned int length, unsigned int chain,
-		unsigned int node, unsigned int stream_id,
-		unsigned int short_not_ok, unsigned int no_interrupt,
-		unsigned int is_last, bool must_interrupt)
+/**
+ * dwc3_prepare_one_trb - setup one TRB from one request
+ * @dep: endpoint for which this request is prepared
+ * @req: dwc3_request pointer
+ * @trb_length: buffer size of the TRB
+ * @chain: should this TRB be chained to the next?
+ * @node: only for isochronous endpoints. First TRB needs different type.
+ * @use_bounce_buffer: set to use bounce buffer
+ * @must_interrupt: set to interrupt on TRB completion
+ */
+static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
+		struct dwc3_request *req, unsigned int trb_length,
+		unsigned int chain, unsigned int node, bool use_bounce_buffer,
+		bool must_interrupt)
 {
+	struct dwc3_trb		*trb;
+	dma_addr_t		dma;
+	unsigned int		stream_id = req->request.stream_id;
+	unsigned int		short_not_ok = req->request.short_not_ok;
+	unsigned int		no_interrupt = req->request.no_interrupt;
+	unsigned int		is_last = req->request.is_last;
 	struct dwc3		*dwc = dep->dwc;
 	struct usb_gadget	*gadget = dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	trb->size = DWC3_TRB_SIZE_LENGTH(length);
+	if (use_bounce_buffer)
+		dma = dep->dwc->bounce_addr;
+	else if (req->request.num_sgs > 0)
+		dma = sg_dma_address(req->start_sg);
+	else
+		dma = req->request.dma;
+
+	trb = &dep->trb_pool[dep->trb_enqueue];
+
+	if (!req->trb) {
+		dwc3_gadget_move_started_request(req);
+		req->trb = trb;
+		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
+	}
+
+	req->num_trbs++;
+
+	trb->size = DWC3_TRB_SIZE_LENGTH(trb_length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
 
@@ -1232,10 +1265,10 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 				unsigned int mult = 2;
 				unsigned int maxp = usb_endpoint_maxp(ep->desc);
 
-				if (length <= (2 * maxp))
+				if (req->request.length <= (2 * maxp))
 					mult--;
 
-				if (length <= maxp)
+				if (req->request.length <= maxp)
 					mult--;
 
 				trb->size |= DWC3_TRB_SIZE_PCM1(mult);
@@ -1309,50 +1342,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-/**
- * dwc3_prepare_one_trb - setup one TRB from one request
- * @dep: endpoint for which this request is prepared
- * @req: dwc3_request pointer
- * @trb_length: buffer size of the TRB
- * @chain: should this TRB be chained to the next?
- * @node: only for isochronous endpoints. First TRB needs different type.
- * @use_bounce_buffer: set to use bounce buffer
- * @must_interrupt: set to interrupt on TRB completion
- */
-static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
-		struct dwc3_request *req, unsigned int trb_length,
-		unsigned int chain, unsigned int node, bool use_bounce_buffer,
-		bool must_interrupt)
-{
-	struct dwc3_trb		*trb;
-	dma_addr_t		dma;
-	unsigned int		stream_id = req->request.stream_id;
-	unsigned int		short_not_ok = req->request.short_not_ok;
-	unsigned int		no_interrupt = req->request.no_interrupt;
-	unsigned int		is_last = req->request.is_last;
-
-	if (use_bounce_buffer)
-		dma = dep->dwc->bounce_addr;
-	else if (req->request.num_sgs > 0)
-		dma = sg_dma_address(req->start_sg);
-	else
-		dma = req->request.dma;
-
-	trb = &dep->trb_pool[dep->trb_enqueue];
-
-	if (!req->trb) {
-		dwc3_gadget_move_started_request(req);
-		req->trb = trb;
-		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
-	}
-
-	req->num_trbs++;
-
-	__dwc3_prepare_one_trb(dep, trb, dma, trb_length, chain, node,
-			stream_id, short_not_ok, no_interrupt, is_last,
-			must_interrupt);
-}
-
 static bool dwc3_needs_extra_trb(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
@@ -2550,9 +2539,6 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	is_on = !!is_on;
 
-	if (dwc->pullups_connected == is_on)
-		return 0;
-
 	dwc->softconnect = is_on;
 
 	/*
@@ -2577,6 +2563,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
+	if (dwc->pullups_connected == is_on) {
+		pm_runtime_put(dwc->dev);
+		return 0;
+	}
+
 	if (!is_on) {
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	} else {
-- 
2.53.0

