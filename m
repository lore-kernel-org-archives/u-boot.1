Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D52BC44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E87584E35;
	Thu, 16 Jul 2026 18:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fg486nxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E12384CCF; Thu, 16 Jul 2026 15:44:17 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2455884C3F
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15de30790bso60035166b.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209454; x=1784814254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K3Ka70721/8grXtQhN134ICUorzwy1yWztt8B+vaYOE=;
 b=fg486nxrTeJgRNQy5io8C0fjOibZgjr9nGZ6ilJd4nqV/KroX7Cpj2ue7Mq24eKiBT
 wgkEY5wbPi4afQYsWtnw73NDukjIlbq53TxKoUfTIEXkeg7qSKWHz/AP+FakRotyKTQi
 q/UdnUYmPQfvR7Uato5qT21dGEFczIRoogfFL+uuK/l9YnLSUOYByJdkib4xRs2GeAe6
 +BAeZn3I8OFgVT8jl9b5N9+T6DtiaMuMf+/TgEVyphCJdRylsIq0ykO3vosKCHlr0rNv
 WvG9d/DFHFmlrxqV09Jpvibh1bvvOMEdtenNuh+aFlqBUu0pnKnAIoSN3fnp4htCngQh
 ecYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209454; x=1784814254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K3Ka70721/8grXtQhN134ICUorzwy1yWztt8B+vaYOE=;
 b=MewZJUhyn7EsshSHa4wnEbTKQZn51heikERXaBFM4/HhWtieFlkxKiTVplAu9b3weB
 GDDOHhO9yNUEqJSzkorEpgAwpE0xIB/VVpSbrKm+xPbNF1hLLzF3L+4kUbzBVQS/H+jE
 iM/Fp77gqZ8/HiSYG5C2S2tN7g5/RYcM/uYb0o1HGSV/lJqmFDPQuYD6ayOBRsUX92lX
 /xZGulQd9rDVnLuQwQh3pfuKM87DqoEGwgTlLijeJyfnkF9Wkr7p1siiQdXFBqvdzk7P
 qPk8kWzdAbzGSKJ+lEN/UCf2X3HJusZEsKqM4QCuSQ2B2zg3rba93b7SiRm87Cp6lufF
 +CKA==
X-Gm-Message-State: AOJu0Yzk+Giy3RIBpgEtfH13xzNU+0Y/OYHKnM3W/ygLnVBUmhTLQCEx
 Wg8mxU3Hq+OjWefwOSDkxcv5+jWjeQEXJBxmZxnaKNNvI1neGImiUsR5i2zKav37T3TzED622Bk
 jvU+l
X-Gm-Gg: AfdE7clSMD4Snk/aqFTvITe3UJbEYH+ICgZcamUHVgieWOADDAngKO4Yw+0eIDhIHfk
 H9M2ZEpRh2OnuadpkpYyDEU9QtGOdPwTaWVHYuPRywifvzcp9CyWoykM4jSgYVcWb3ljL3Rq+2n
 Vx3gO1c3plN1sOcADsxtZxjXqBKEsYGReSJLWw2rutNlEKvlzd04Gh3CSz1fehz4TWMV/winUys
 FDmqewfjmS9wvy10K2XcwImk+JHvlsxCZmE6RfN88i5LX6dav7Lv9n29JYHhqWqy3pN1Xm8/vEV
 xHBv6Qb3zTwi9D3ztrinXUt0EvCo0BWp/ATyiMMDdiwEJtalQIRtG7uiUHP7F0x2GYhJ1dz8j0C
 6i5ZCRsH8FNbUpca2K8kx7vo7Xt+YtpZIbPTDLsXi+wefkI2UBc1pKreewEpVzoOIGalpBNhVcy
 lAHLejEIjrLb9cOfFgC7pAuZ2DUZhPznBHmZXIIg==
X-Received: by 2002:a17:907:3f0c:b0:c15:f373:47b6 with SMTP id
 a640c23a62f3a-c161f3bb457mr742550566b.3.1784209454469; 
 Thu, 16 Jul 2026 06:44:14 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1687316edasm215518766b.29.2026.07.16.06.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:13 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 44/75] usb: dwc3: import from kernel v6.0
Date: Thu, 16 Jul 2026 15:42:14 +0200
Message-ID: <20260716134305.614278-45-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.19 to v6.0.

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

List of commits: git log --oneline v5.19..v6.0
Commits imported:
f5c5936d6b4d usb: dwc3: st: Fix node's child name
91062e663b26 usb: dwc3: core: leave default DMA if the controller does not support 64-bit DMA
6000b8d900cd usb: dwc3: disable USB core PHY management
e41a88f38d87 usb: dwc3: qcom: suppress unused-variable warning
040f2dbd2010 usb: dwc3: gadget: Avoid duplicate requests to enable Run/Stop
bad0d1d726ac usb: dwc3: pci: Add support for Intel Raptor Lake
ac6928f83f8d usb: dwc3: qcom: clean up suspend callbacks
e3fafbd8e365 usb: dwc3: qcom: fix wakeup implementation
c5f14abeb52b usb: dwc3: qcom: fix peripheral and OTG suspend
6498a96c8c9c usb: dwc3: qcom: fix runtime PM wakeup
a872ab303d5d usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup
c06795f114a6 usb: dwc3: qcom: fix gadget-only builds
762e744922b5 Revert "usb: dwc3: qcom: Keep power domain on to retain controller status"
d2ac7bef95c9 usb: dwc3: fix PHY disable sequence
69bb3520db7c usb: dwc3: qcom: fix missing optional irq warnings
07903626d988 usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET during bootup
5e76ee96be8f usb: dwc3: ep0: Properly handle setup_packet_pending scenario in data stage
8affe37c525d usb: dwc3: gadget: fix high speed multiplier setting
23385cec5f35 usb: dwc3: gadget: refactor dwc3_repare_one_trb
babfcd947eba usb: dwc3: gadget: fix a kernel-doc warning
ad44cf402486 usb: dwc3: document async_callbacks field
d9be8d5c5b03 usb: dwc3: qcom: Keep power domain on to retain controller status
6895ea55c385 usb: dwc3: qcom: Configure wakeup interrupts during suspend
360e8230516d usb: dwc3: qcom: Add helper functions to enable,disable wake irqs
649f5c842ba3 usb: dwc3: core: Host wake up support from system suspend
afbd04e66e5d usb: dwc3: core: Deprecate GCTL.CORESOFTRESET
fb119dcb97f4 Revert "usb: dwc3: Remove the checks of -ENOSYS"
3085d1bd47f2 usb: dwc3: Fix typos in Kconfig
d1b39dd5819a usb: dwc3: Fix a repeated word checkpatch warning
ca80ca61863f usb: dwc3: Fix bare use of unsigned checkpatch warning
df22ecc41b54 usb: dwc3: Remove the checks of -ENOSYS
3497b9a5c8c3 usb: dwc3: add power down scale setting

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
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

