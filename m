Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DCACD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C384B84B18;
	Thu,  7 May 2026 11:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eDte7ItU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FFFF84B14; Thu,  7 May 2026 11:30:55 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2951784B0E
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5a887ebb416so537738e87.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146249; x=1778751049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7g0Jr/ryvKWWLng0tjnFL+vdmlYbPhL3SgRQL5VW5J0=;
 b=eDte7ItUbCZyHJS8yUGthN+QdHH/94bNFEAT2gDlqTByHfs7C558iVhqK28Qt2ABE7
 PcpxoPFAgWsM/3dMPq/A1PvzWu2BfDNDRm1yDSfYHldOOCMP6QXtbzgp0h+0DPfitBJk
 RyPz97j6toURuv5YS0yUlbpLoWLhy3L+69Km8Yna6xwiovpJ5dPrn5aKh4jW/duuivvA
 LHiOHiR4q0/TN8xxh3447Y0ka7jVWB3E/yXkbynLZVOTjS5PfGKxOkPSPtj0JKIt0u6X
 e1uqWgFwQWjXRX5zW/6L6drUNYWx4DBqUHxy64u43WDGVoXtx+3Ov38CZwJOt+bp2Rcv
 gPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146249; x=1778751049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7g0Jr/ryvKWWLng0tjnFL+vdmlYbPhL3SgRQL5VW5J0=;
 b=E92pxGRBeeLUbbGSzt71bNCRQVZXELQX4BDs5u/RWuWTyQB5RgYhUC1TN1uPQ7hn+n
 yqlD6MAdbbXOtKgKdqquYrrJzVbTo2LzsjcDVL1s7JTs5KrCvMw1stRqbWMZVrBO2V96
 zlHBmUIZAxx1X28RLn1ME/CAd/a+mXMK6FrT5IeCbd2h20YDfpsNeYXVHdPHxCyZVSub
 RSW6P6jVB8TqYRACO5/I86ONarr1LY073t/AE+yZnBYzpvPAvbyz8q0X8aFeIYq9xesN
 1giWB3qbbTr21rCNyPCVqjSaXLICykuGBp587NuloOdqUKtXYNeC7+/tuHMxM9Z55Mca
 sIDw==
X-Gm-Message-State: AOJu0YzD5x/c2ffK8CnzZ6sYPk4cxcnE7odbOwzgMLBkjITtd2XfQ+HW
 ooZkG4K95Vo/fiSvcA0M6wJscLL/5AYyxdw8tu5VmVLSsz5TPG3tD4iXzvF6nYbH/xAeLhmgIpN
 xE4zLM2BE1g==
X-Gm-Gg: AeBDieuQlZl8L0KLpHzA1+XKgGWG9vJVz3xmbsEI5XPeB2UjfuUfwWNh4yR6Nd22xZC
 Yg/5tmOGotwJB9ik2c/FxCL05DMoZOoOZToQFop+Ku+caaeidynVAae6CEHhd7N2OuWHCbCgdp5
 7gNCd1ALrfrLGbKSjvqQ9kgov2wW21y0gI1FBHciY5OTbwyTqOJ10WxV8T2hpqwsEx39jvMbEkm
 V6O2rFgoBM2GZmO+ob3UdycFom8IyYgk7rV98kyuF/Lh/qkvBviJrsbYtuBhUDlUSBl6liTzO6m
 YnBiKotusZKjk+oBwQ68AatdobehUQ8V5DMDNQHqVWgJLPBp7vbyiy3XAbPLGTxqCUvZqFRkkuD
 z/prQkmgePthiHvVYsUr+pPajCp2OzhzcTUK+kJIPCpqMPAigmJ+da+B823iMrXiCJxTRbTDAYv
 wMnomVyEAz9A0uqtPyK6LI4pmodyNDMLRi9gnJpCn0Owd65nUXcSg8j1Uu9Ndpzf17MVt7aBhxB
 uujcnSDsGdO8dCcSbO6a8vgt5CQju26cQK/5CA3Dw==
X-Received: by 2002:a05:6512:1095:b0:5a4:4ea:9977 with SMTP id
 2adb3069b0e04-5a887adac13mr3034625e87.8.1778146248675; 
 Thu, 07 May 2026 02:30:48 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:30:46 -0700 (PDT)
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
Subject: [RFC PATCH v2 42/64] usb: dwc3: import from kernel v5.18
Date: Thu,  7 May 2026 11:27:49 +0200
Message-ID: <20260507092843.358908-43-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.17 to v5.18.

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

List of commits: git log --oneline v5.17..v5.18
Commits imported:
c7428dbddcf4 usb: dwc3: gadget: Return proper request status
973e0f7a847e usb: dwc3: pci: add support for the Intel Meteor Lake-P
f4fd84ae0765 usb: dwc3: core: Only handle soft-reset in DCTL
ab7aa2866d29 usb: dwc3: Try usb-role-switch first in dwc3_drd_init
f28ad9069363 usb: dwc3: core: Fix tx/rx threshold settings
4e64cd7763ca usb: dwc3: fix backwards compat with rockchip devices
0066472de157 usb: dwc3: Issue core soft reset before enabling run/stop
e4cf6580ac74 usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue
e192cc7b5239 usb: dwc3: gadget: move cmd_endtransfer to extra function
26d27a1080a7 usb: dwc3: gadget: ep_queue simplify isoc start condition
ecb0a2f1e9e2 usb: dwc3: pci: Add support for Intel Alder Lake
ac01df343e5a usb: dwc3: omap: fix "unbalanced disables for smps10_out1" on omap5evm
aa6812be1feb usb: dwc3: gadget: Give some time to schedule isoc
62b20e6e0dde usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode
9d52107185b6 usb: dwc3: imx8mp: Add support for setting SOC specific flags
81915384b5d1 usb: dwc3: imx8mp: rename iomem base pointer
850ebb27aed8 usb: dwc3-meson-g12a: constify drvdata structs
ca9400ef7f67 Merge 5.17-rc6 into usb-next
a5d847b0afd3 usb: dwc3: pci: Also apply Bay Trail GPIO mappings to ulpi-device
582ab24e096f usb: dwc3: pci: Set "linux,phy_charger_detect" property on some Bay Trail boards
e285cb403994 usb: dwc3: pci: Set the swnode from inside dwc3_pci_quirks()
e51879d85a4d usb: dwc3: drd: Don't check against CONFIG_OF
fbd533e90d23 Merge 5.17-rc4 into usb-next
596c87856e08 usb: dwc3: Program GFLADJ
5114c3ee2487 usb: dwc3: Calculate REFCLKPER based on reference clock
33fb697ec7e5 usb: dwc3: Get clocks individually
60c250a98d4c Merge tag 'v5.17-rc2' into usb-next
a102f07e4edf usb: dwc3: drd: Add support for usb-conn-gpio based usb-role-switch

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   | 158 ++++++++++++++++++++++++++++++++------
 drivers/usb/dwc3/core.h   |  17 +++-
 drivers/usb/dwc3/ep0.c    |  14 ++++
 drivers/usb/dwc3/gadget.c | 149 ++++++++++++++++++++++++-----------
 drivers/usb/dwc3/gadget.h |   1 +
 5 files changed, 267 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f4c09951b517..d28cd1a6709b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -115,8 +115,6 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	dwc->current_dr_role = mode;
 }
 
-static int dwc3_core_soft_reset(struct dwc3 *dwc);
-
 static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
@@ -261,7 +259,7 @@ u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
  * dwc3_core_soft_reset - Issues core soft reset and PHY reset
  * @dwc: pointer to our context structure
  */
-static int dwc3_core_soft_reset(struct dwc3 *dwc)
+int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
 	int		retries = 1000;
@@ -276,7 +274,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	reg &= ~DWC3_DCTL_RUN_STOP;
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	/*
 	 * For DWC_usb31 controller 1.90a and later, the DCTL.CSFRST bit
@@ -347,17 +346,64 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
  */
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
+	unsigned long period;
+	unsigned long fladj;
+	unsigned long decr;
+	unsigned long rate;
 	u32 reg;
 
-	if (dwc->ref_clk_per == 0)
+	if (dwc->ref_clk) {
+		rate = clk_get_rate(dwc->ref_clk);
+		if (!rate)
+			return;
+		period = NSEC_PER_SEC / rate;
+	} else if (dwc->ref_clk_per) {
+		period = dwc->ref_clk_per;
+		rate = NSEC_PER_SEC / period;
+	} else {
 		return;
+	}
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
 	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
-	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, dwc->ref_clk_per);
+	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
 	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-}
 
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
+		return;
+
+	/*
+	 * The calculation below is
+	 *
+	 * 125000 * (NSEC_PER_SEC / (rate * period) - 1)
+	 *
+	 * but rearranged for fixed-point arithmetic. The division must be
+	 * 64-bit because 125000 * NSEC_PER_SEC doesn't fit in 32 bits (and
+	 * neither does rate * period).
+	 *
+	 * Note that rate * period ~= NSEC_PER_SECOND, minus the number of
+	 * nanoseconds of error caused by the truncation which happened during
+	 * the division when calculating rate or period (whichever one was
+	 * derived from the other). We first calculate the relative error, then
+	 * scale it to units of 8 ppm.
+	 */
+	fladj = div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period);
+	fladj -= 125000;
+
+	/*
+	 * The documented 240MHz constant is scaled by 2 to get PLS1 as well.
+	 */
+	decr = 480000000 / rate;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
+	reg &= ~DWC3_GFLADJ_REFCLK_FLADJ_MASK
+	    &  ~DWC3_GFLADJ_240MHZDECR
+	    &  ~DWC3_GFLADJ_240MHZDECR_PLS1;
+	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
+	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
+	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
+	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
+}
 
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
@@ -745,6 +791,38 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_clk_enable(struct dwc3 *dwc)
+{
+	int ret;
+
+	ret = clk_prepare_enable(dwc->bus_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dwc->ref_clk);
+	if (ret)
+		goto disable_bus_clk;
+
+	ret = clk_prepare_enable(dwc->susp_clk);
+	if (ret)
+		goto disable_ref_clk;
+
+	return 0;
+
+disable_ref_clk:
+	clk_disable_unprepare(dwc->ref_clk);
+disable_bus_clk:
+	clk_disable_unprepare(dwc->bus_clk);
+	return ret;
+}
+
+static void dwc3_clk_disable(struct dwc3 *dwc)
+{
+	clk_disable_unprepare(dwc->susp_clk);
+	clk_disable_unprepare(dwc->ref_clk);
+	clk_disable_unprepare(dwc->bus_clk);
+}
+
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
 	dwc3_event_buffers_cleanup(dwc);
@@ -758,7 +836,7 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
 }
 
@@ -1088,6 +1166,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->parkmode_disable_ss_quirk)
 			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
 
+		if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY) &&
+		    (dwc->maximum_speed == USB_SPEED_HIGH ||
+		     dwc->maximum_speed == USB_SPEED_FULL))
+			reg |= DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
+
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
@@ -1295,10 +1378,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
-	u8			rx_thr_num_pkt_prd;
-	u8			rx_max_burst_prd;
-	u8			tx_thr_num_pkt_prd;
-	u8			tx_max_burst_prd;
+	u8			rx_thr_num_pkt_prd = 0;
+	u8			rx_max_burst_prd = 0;
+	u8			tx_thr_num_pkt_prd = 0;
+	u8			tx_max_burst_prd = 0;
 	u8			tx_fifo_resize_max_num;
 	const char		*usb_psy_name;
 	int			ret;
@@ -1605,25 +1688,54 @@ static int dwc3_probe(struct platform_device *pdev)
 		return PTR_ERR(dwc->reset);
 
 	if (dev->of_node) {
-		ret = devm_clk_bulk_get_all(dev, &dwc->clks);
-		if (ret == -EPROBE_DEFER)
-			return ret;
 		/*
 		 * Clocks are optional, but new DT platforms should support all
 		 * clocks as required by the DT-binding.
+		 * Some devices have different clock names in legacy device trees,
+		 * check for them to retain backwards compatibility.
 		 */
-		if (ret < 0)
-			dwc->num_clks = 0;
-		else
-			dwc->num_clks = ret;
+		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
+		if (IS_ERR(dwc->bus_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+					     "could not get bus clock\n");
+
+		if (dwc->bus_clk == NULL) {
+			dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
+			if (IS_ERR(dwc->bus_clk))
+				return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+						     "could not get bus clock\n");
+		}
 
+		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
+		if (IS_ERR(dwc->ref_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+					     "could not get ref clock\n");
+
+		if (dwc->ref_clk == NULL) {
+			dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
+			if (IS_ERR(dwc->ref_clk))
+				return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+						     "could not get ref clock\n");
+		}
+
+		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
+		if (IS_ERR(dwc->susp_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+					     "could not get suspend clock\n");
+
+		if (dwc->susp_clk == NULL) {
+			dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
+			if (IS_ERR(dwc->susp_clk))
+				return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+						     "could not get suspend clock\n");
+		}
 	}
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
+	ret = dwc3_clk_enable(dwc);
 	if (ret)
 		goto assert_reset;
 
@@ -1711,7 +1823,7 @@ err1:
 	pm_runtime_disable(&pdev->dev);
 
 disable_clks:
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
@@ -1755,7 +1867,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
+	ret = dwc3_clk_enable(dwc);
 	if (ret)
 		goto assert_reset;
 
@@ -1766,7 +1878,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	return 0;
 
 disable_clks:
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e1cc3f7398fb..5c9d467195a6 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -259,6 +259,7 @@
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
+#define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
 
@@ -388,6 +389,9 @@
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
+#define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
+#define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
+#define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
 
 /* Global User Control Register*/
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
@@ -733,6 +737,7 @@ struct dwc3_ep {
 #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
+#define DWC3_EP_DELAY_STOP             BIT(13)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN			BIT(31)
@@ -978,8 +983,9 @@ struct dwc3_scratchpad_array {
  * @eps: endpoint array
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
- * @clks: array of clocks
- * @num_clks: number of clocks
+ * @bus_clk: clock for accessing the registers
+ * @ref_clk: reference clock
+ * @susp_clk: clock used when the SS phy is in low power (S3) state
  * @reset: reset control
  * @regs: base address for our registers
  * @regs_size: address space size
@@ -1134,8 +1140,9 @@ struct dwc3 {
 	struct usb_gadget	*gadget;
 	struct usb_gadget_driver *gadget_driver;
 
-	struct clk_bulk_data	*clks;
-	int			num_clks;
+	struct clk		*bus_clk;
+	struct clk		*ref_clk;
+	struct clk		*susp_clk;
 
 	struct reset_control	*reset;
 
@@ -1525,6 +1532,8 @@ bool dwc3_has_imod(struct dwc3 *dwc);
 int dwc3_event_buffers_setup(struct dwc3 *dwc);
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
 
+int dwc3_core_soft_reset(struct dwc3 *dwc);
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 658739410992..1064be5518f6 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -271,6 +271,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 {
 	struct dwc3_ep			*dep;
 	int				ret;
+	int                             i;
 
 	complete(&dwc->ep0_in_setup);
 
@@ -279,6 +280,19 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 			DWC3_TRBCTL_CONTROL_SETUP, false);
 	ret = dwc3_ep0_start_trans(dep);
 	WARN_ON(ret < 0);
+	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
+		struct dwc3_ep *dwc3_ep;
+
+		dwc3_ep = dwc->eps[i];
+		if (!dwc3_ep)
+			continue;
+
+		if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
+			continue;
+
+		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
+		dwc3_stop_active_transfer(dwc3_ep, true, true);
+	}
 }
 
 static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a0c883f19a41..0b9c2493844a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -654,9 +654,6 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
-		bool interrupt);
-
 /**
  * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
  * @dwc: pointer to the DWC3 context
@@ -1673,6 +1670,40 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
 	return DWC3_DSTS_SOFFN(reg);
 }
 
+/**
+ * __dwc3_stop_active_transfer - stop the current active transfer
+ * @dep: isoc endpoint
+ * @force: set forcerm bit in the command
+ * @interrupt: command complete interrupt after End Transfer command
+ *
+ * When setting force, the ForceRM bit will be set. In that case
+ * the controller won't update the TRB progress on command
+ * completion. It also won't clear the HWO bit in the TRB.
+ * The command will also not complete immediately in that case.
+ */
+static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	u32 cmd;
+	int ret;
+
+	cmd = DWC3_DEPCMD_ENDTRANSFER;
+	cmd |= force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
+	cmd |= interrupt ? DWC3_DEPCMD_CMDIOC : 0;
+	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
+	memset(&params, 0, sizeof(params));
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	WARN_ON_ONCE(ret);
+	dep->resource_index = 0;
+
+	if (!interrupt)
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+	else if (!ret)
+		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+
+	return ret;
+}
+
 /**
  * dwc3_gadget_start_isoc_quirk - workaround invalid frame number
  * @dep: isoc endpoint
@@ -1830,7 +1861,13 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 	}
 
 	for (i = 0; i < DWC3_ISOC_MAX_RETRIES; i++) {
-		dep->frame_number = DWC3_ALIGN_FRAME(dep, i + 1);
+		int future_interval = i + 1;
+
+		/* Give the controller at least 500us to schedule transfers */
+		if (desc->bInterval < 3)
+			future_interval += 3 - desc->bInterval;
+
+		dep->frame_number = DWC3_ALIGN_FRAME(dep, future_interval);
 
 		ret = __dwc3_gadget_kick_transfer(dep);
 		if (ret != -EAGAIN)
@@ -1842,21 +1879,8 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 	 * status, issue END_TRANSFER command and retry on the next XferNotReady
 	 * event.
 	 */
-	if (ret == -EAGAIN) {
-		struct dwc3_gadget_ep_cmd_params params;
-		u32 cmd;
-
-		cmd = DWC3_DEPCMD_ENDTRANSFER |
-			DWC3_DEPCMD_CMDIOC |
-			DWC3_DEPCMD_PARAM(dep->resource_index);
-
-		dep->resource_index = 0;
-		memset(&params, 0, sizeof(params));
-
-		ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-		if (!ret)
-			dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-	}
+	if (ret == -EAGAIN)
+		ret = __dwc3_stop_active_transfer(dep, false, true);
 
 	return ret;
 }
@@ -1899,6 +1923,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 */
 	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
 	    (dep->flags & DWC3_EP_WEDGE) ||
+	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_STALL)) {
 		dep->flags |= DWC3_EP_DELAY_START;
 		return 0;
@@ -1913,13 +1938,11 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 * errors which will force us issue EndTransfer command.
 	 */
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-		if (!(dep->flags & DWC3_EP_PENDING_REQUEST) &&
-				!(dep->flags & DWC3_EP_TRANSFER_STARTED))
-			return 0;
-
-		if ((dep->flags & DWC3_EP_PENDING_REQUEST)) {
-			if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
+		if (!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
+			if ((dep->flags & DWC3_EP_PENDING_REQUEST))
 				return __dwc3_gadget_start_isoc(dep);
+
+			return 0;
 		}
 	}
 
@@ -2033,6 +2056,16 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		if (r == req) {
 			struct dwc3_request *t;
 
+			/*
+			 * If a Setup packet is received but yet to DMA out, the controller will
+			 * not process the End Transfer command of any endpoint. Polling of its
+			 * DEPCMD.CmdAct may block setting up TRB for Setup packet, causing a
+			 * timeout. Delay issuing the End Transfer command until the Setup TRB is
+			 * prepared.
+			 */
+			if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status)
+				dep->flags |= DWC3_EP_DELAY_STOP;
+
 			/* wait until it is processed */
 			dwc3_stop_active_transfer(dep, true, true);
 
@@ -2116,7 +2149,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
 
-		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
+		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
+		    (dep->flags & DWC3_EP_DELAY_STOP)) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
 			return 0;
 		}
@@ -2544,6 +2578,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 						dwc->ev_buf->length;
 		}
 	} else {
+		/*
+		 * In the Synopsys DWC_usb31 1.90a programming guide section
+		 * 4.1.9, it specifies that for a reconnect after a
+		 * device-initiated disconnect requires a core soft reset
+		 * (DCTL.CSftRst) before enabling the run/stop bit.
+		 */
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_core_soft_reset(dwc);
+		spin_lock_irqsave(&dwc->lock, flags);
+
+		dwc3_event_buffers_setup(dwc);
 		__dwc3_gadget_start(dwc);
 	}
 
@@ -3229,6 +3274,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event,
 		struct dwc3_request *req, int status)
 {
+	int request_status;
 	int ret;
 
 	if (req->request.num_mapped_sgs)
@@ -3249,7 +3295,35 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 		req->needs_extra_trb = false;
 	}
 
-	dwc3_gadget_giveback(dep, req, status);
+	/*
+	 * The event status only reflects the status of the TRB with IOC set.
+	 * For the requests that don't set interrupt on completion, the driver
+	 * needs to check and return the status of the completed TRBs associated
+	 * with the request. Use the status of the last TRB of the request.
+	 */
+	if (req->request.no_interrupt) {
+		struct dwc3_trb *trb;
+
+		trb = dwc3_ep_prev_trb(dep, dep->trb_dequeue);
+		switch (DWC3_TRB_SIZE_TRBSTS(trb->size)) {
+		case DWC3_TRBSTS_MISSED_ISOC:
+			/* Isoc endpoint only */
+			request_status = -EXDEV;
+			break;
+		case DWC3_TRB_STS_XFER_IN_PROG:
+			/* Applicable when End Transfer with ForceRM=0 */
+		case DWC3_TRBSTS_SETUP_PENDING:
+			/* Control endpoint only */
+		case DWC3_TRBSTS_OK:
+		default:
+			request_status = 0;
+			break;
+		}
+	} else {
+		request_status = status;
+	}
+
+	dwc3_gadget_giveback(dep, req, request_status);
 
 out:
 	return ret;
@@ -3596,14 +3670,11 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	}
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	bool interrupt)
 {
-	struct dwc3_gadget_ep_cmd_params params;
-	u32 cmd;
-	int ret;
-
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
+	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
@@ -3634,19 +3705,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * This mode is NOT available on the DWC_usb31 IP.
 	 */
 
-	cmd = DWC3_DEPCMD_ENDTRANSFER;
-	cmd |= force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
-	cmd |= interrupt ? DWC3_DEPCMD_CMDIOC : 0;
-	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
-	memset(&params, 0, sizeof(params));
-	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-	WARN_ON_ONCE(ret);
-	dep->resource_index = 0;
-
-	if (!interrupt)
-		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else
-		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	__dwc3_stop_active_transfer(dep, force, interrupt);
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 77df4b6d6c13..f763380e672e 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -116,6 +116,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 		gfp_t gfp_flags);
 int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
 void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
-- 
2.43.0

