Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7B5CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF01584AFC;
	Thu,  7 May 2026 11:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qzs47OxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F23984AF2; Thu,  7 May 2026 11:30:42 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B72D484A81
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a0ff30b240so823179e87.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146236; x=1778751036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJ6l5sCJ/Ee2tug297xuaz7MHKT34sNa3U5qm3+1Uag=;
 b=qzs47OxIuREBVJZnpuyfQukpkfmqyNMTrIK3fBegC0kVEJKOIA5M7W3+XfAy3CfDoV
 KUTa7d0Swh9hr3FG/bDhXfJAfRi7lZAKs2Mx8q++Wt8HRO4CLzzFr59ZpJFIX+lu6/Uk
 vtPA4z3Np2vT4PrR5DYi1MBTuz3kqTk3Gwwt9eb9AdPadNv8GlrC3q0rz/zIZdf9THbY
 Teyht4sWq1m3JuMO0QL/s/8v7fVIM0LJWeuTjGYQZcnH7yRRAsxNC2EvR10GV5YF7rU0
 UYbKg5YWdvuigQglWiP5taDvPsJfHYUennmorp/DoOAsSyOgWGRGFNPaSPEftf4rSUO0
 +LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146236; x=1778751036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wJ6l5sCJ/Ee2tug297xuaz7MHKT34sNa3U5qm3+1Uag=;
 b=D+precxEniDXrZ9hTrfm0eGi1Y757gykhYunNL4/u83zuOAdMZW5x7KIqUdq1vGNi5
 zzf7L9dPWqkMeQPOwbm6mOfyswQcfel05AeaojSDgQLIxpmNHkxpWL0v3i8Ofi27qpkA
 dTKZIZbwCSUdVWzjVwMKcg3ZIcsutcMf6U73yZTSkxFJOfD51kQc9TFDB+aZHwFKg7Dn
 ACHpHQBe/CmqeiSLI5sdiofN19ukpuGfzhk1mAOlwV0Tya/TcDZz7ZMNtel5wTe6GZYY
 Ot0XpYbtE3bz+J7VE2rW0VfXg1JTAx/0bi87mPUOeyO1qIRAjxzY68jJsBGd1FX9RKWa
 6QYg==
X-Gm-Message-State: AOJu0YxZmA6FSMoYEpboo4Yf5JRtA2PsEGnWHuY2KzZ7pUJh2A81cMiO
 o20xMwofVDwrzDzRM8KIdXKwMbvY1YNl5hg+z9KjsswuuAH6F6i8qNLERFZtKxys4uHivjuHLdt
 dr2Wm0n7vYA==
X-Gm-Gg: AeBDietNqjKt4uxQNTXuFpjX7GGtWAePr9AuL67TD1fg4/1R2TwD6M31RRSa7/eazd5
 IUiX2WYSnMovjSb2gznqFstwk0YrdyF5HofLE+I2JtUpdG25b/ESZgC+warIpAHxdxegz0VgkE/
 vn9lSI7jGuWPf2ZYxYa9Eg4dQYE7lPbzKer4NMBgie+zsrGLfCe0xUuuOXx7AZqoDQSL1Ak9u6S
 zQ6a6hUP7T3WexPu26+qdjPtV3TL7rV5naTJKAUMFo2LzajK7Kp26fOavpL+QUCL8GyLKd3VQ9H
 wUaqq1xVITEGd+ec0vH6xdnWbk7ZG6zGotALDid46GeL69OJdLPc1oKgzB9/bwWRHtW1cSawjRy
 tb4N976RV3SHlS7DndgYN7nWNRm1cxJBfFcBK83nTy6KoGyAhe95xn/3SGgGPf8ajag34sKQYY3
 HHqglRRMHdlCf4V8K51u4mLpCb6yb6s6uXW2fIh2CF85MPkqB3wtXDYS/8d5nW2jEo4xL7BaWSe
 oh2Eltt3ykEfvE4gDJOhpLkPez9pWiwCKWQc4QdBw==
X-Received: by 2002:a05:6512:238e:b0:5a2:be43:c57d with SMTP id
 2adb3069b0e04-5a887ae187dmr2989854e87.12.1778146236078; 
 Thu, 07 May 2026 02:30:36 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:30:34 -0700 (PDT)
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
Subject: [RFC PATCH v2 37/64] usb: dwc3: import from kernel v5.13
Date: Thu,  7 May 2026 11:27:44 +0200
Message-ID: <20260507092843.358908-38-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.12 to v5.13.

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

List of commits: git log --oneline v5.12..v5.13
Commits imported:
4bf584a03eec usb: dwc3: core: fix kernel panic when do reboot
d00889080ab6 usb: dwc3: ep0: fix NULL pointer exception
4d2aa178d2ad usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled
1d0d3d818eaf usb: dwc3: meson-g12a: Disable the regulator in the error handling path of the probe
8f11fe7e4068 Revert "usb: dwc3: core: Add shutdown callback for dwc3"
8d396bb0a5b6 usb: dwc3: debugfs: Add and remove endpoint dirs dynamically
03715ea2e3db usb: dwc3: gadget: Bail from dwc3_gadget_exit() if dwc->gadget is NULL
8212937305f8 usb: dwc3: gadget: Disable gadget IRQ during pullup disable
25dda9fc56bd usb: dwc3: gadget: Properly track pending and queued SG
e17b02d49709 usb: dwc3: omap: improve extcon initialization
0b2b149e918f usb: dwc3: imx8mp: fix error return code in dwc3_imx8mp_probe()
b96992081fde usb: dwc3: imx8mp: detect dwc3 core node via compatible string
18ffa988dbae usb: dwc3: gadget: Return success always for kick transfer in ep queue
bb9c74a5bd14 usb: dwc3: gadget: Free gadget structure only after freeing endpoints
6f26ebb79a84 usb: dwc3: gadget: Rename EOPF event macros to Suspend
d1d90dd27254 usb: dwc3: gadget: Enable suspend events
9cbc7eb17cdf usb: dwc3: core: Add missing GHWPARAMS9 doc
04357fafea9c usb: dwc3: pci: Enable usb2-gadget-lpm-disable for Intel Merrifield
ddae7979cdd5 usb: dwc3: gadget: Handle DEV_TXF_FLUSH_BYPASS capability
16710380d3aa usb: dwc3: Capture new capability register GHWPARAMS9
f88359e1588b usb: dwc3: core: Do core softreset when switch mode
3232a3ce55ed usb: dwc3: gadget: Remove FS bInterval_m1 limitation
c560e76319a9 usb: dwc3: gadget: Fix START_TRANSFER link state check
475e8be53d04 usb: dwc3: gadget: Check for disabled LPM quirk
568262bf5492 usb: dwc3: core: Add shutdown callback for dwc3
e66bbfb0fbbe usb: dwc3: gadget: Ignore Packet Pending bit
3db53374405f usb: dwc3: qcom: Detect DWC3 DT-nodes using compatible string
dc1e7e9a27e0 usb: dwc3: qcom: Remove redundant dev_err call in dwc3_qcom_probe()
124b11cc4f62 usb: dwc3: xilinx: Remove the extra freeing of clocks
3a2a68ecb25e usb: dwc3: Resolve kernel-doc warning for Xilinx DWC3 driver
782de5e7190d usb: dwc3: pci: add support for the Intel Alder Lake-M
de800f290dfa Merge 5.12-rc6 into usb-next
04dd6e76b228 usb: dwc3: add cancelled reasons for dwc3 requests
048b14e1f28b usb: dwc3: exynos: fix incorrect kernel-doc comment syntax
27088e00b623 usb: dwc3: fix incorrect kernel-doc comment syntax in files
c9714d65eac8 usb: dwc3: st: fix incorrect kernel-doc comment syntax in file
ed577c325b64 usb: dwc3: imx8mp: fix incorrect kernel-doc comment syntax
d00be779cc50 usb: dwc3: Create helper function getting MDWIDTH
8a5b5c3c1634 usb: dwc3: gadget: modify the scale in vbus_draw callback
3fc63d0724bb usb: dwc3: trace: Print register read and write offset
71ca43f30df9 usb: dwc3: gadget: Ignore EP queue requests during bus reset
02fa4b980245 usb: dwc3: gadget: Avoid continuing preparing TRBs during teardown
84770f028fab usb: dwc3: Add driver for Xilinx platforms
0c59f678fcfc usb: dwc3: gadget: Remove invalid low-speed setting
f85142af3641 Merge 5.12-rc4 into usb-next
064ece8d7ca7 drivers: usb: Fix a typo in dwc3-qcom.c
aa403f257e99 Merge 5.12-rc3 into usb-next
0f3edf99c239 usb: dwc3: document usb_psy in struct dwc3
b0bf77cd389d usb: dwc3: Fix dereferencing of null dwc->usb_psy
99288de36020 usb: dwc3: add an alternate path in vbus_draw callback
6f0764b5adea usb: dwc3: add a power supply for current control

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   |  50 ++++++++++-
 drivers/usb/dwc3/core.h   |  60 +++++++++++---
 drivers/usb/dwc3/debug.h  |  13 +--
 drivers/usb/dwc3/ep0.c    |   3 +
 drivers/usb/dwc3/gadget.c | 169 ++++++++++++++++++++++++++------------
 drivers/usb/dwc3/gadget.h |   6 +-
 drivers/usb/dwc3/io.h     |   2 +-
 7 files changed, 229 insertions(+), 74 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f2448d0a9d39..4ac397e43e19 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -114,6 +114,8 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	dwc->current_dr_role = mode;
 }
 
+static int dwc3_core_soft_reset(struct dwc3 *dwc);
+
 static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
@@ -121,6 +123,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 	int ret;
 	u32 reg;
 
+	mutex_lock(&dwc->mutex);
+
 	pm_runtime_get_sync(dwc->dev);
 
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
@@ -154,6 +158,25 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
+	/* For DRD host or device mode only */
+	if (dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+		reg |= DWC3_GCTL_CORESOFTRESET;
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+		/*
+		 * Wait for internal clocks to synchronized. DWC_usb31 and
+		 * DWC_usb32 may need at least 50ms (less for DWC_usb3). To
+		 * keep it consistent across different IPs, let's wait up to
+		 * 100ms before clearing GCTL.CORESOFTRESET.
+		 */
+		msleep(100);
+
+		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+		reg &= ~DWC3_GCTL_CORESOFTRESET;
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
 
 	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
@@ -178,6 +201,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
+		dwc3_core_soft_reset(dwc);
+
 		dwc3_event_buffers_setup(dwc);
 
 		if (dwc->usb2_phy)
@@ -200,6 +225,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 out:
 	pm_runtime_mark_last_busy(dwc->dev);
 	pm_runtime_put_autosuspend(dwc->dev);
+	mutex_unlock(&dwc->mutex);
 }
 
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
@@ -544,6 +570,9 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 	parms->hwparams6 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
 	parms->hwparams7 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
 	parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
+
+	if (DWC3_IP_IS(DWC32))
+		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
 static int dwc3_core_ulpi_init(struct dwc3 *dwc)
@@ -1238,6 +1267,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			rx_max_burst_prd;
 	u8			tx_thr_num_pkt_prd;
 	u8			tx_max_burst_prd;
+	const char		*usb_psy_name;
+	int			ret;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xf;
@@ -1263,6 +1294,13 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	else
 		dwc->sysdev = dwc->dev;
 
+	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
+	if (ret >= 0) {
+		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
+		if (!dwc->usb_psy)
+			dev_err(dev, "couldn't get usb power supply\n");
+	}
+
 	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
 	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
@@ -1277,6 +1315,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,usb3_lpm_capable");
 	dwc->usb2_lpm_disable = device_property_read_bool(dev,
 				"snps,usb2-lpm-disable");
+	dwc->usb2_gadget_lpm_disable = device_property_read_bool(dev,
+				"snps,usb2-gadget-lpm-disable");
 	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
 				&rx_thr_num_pkt_prd);
 	device_property_read_u8(dev, "snps,rx-max-burst-prd",
@@ -1385,7 +1425,6 @@ static void dwc3_check_params(struct dwc3 *dwc)
 
 	/* Check the maximum_speed parameter */
 	switch (dwc->maximum_speed) {
-	case USB_SPEED_LOW:
 	case USB_SPEED_FULL:
 	case USB_SPEED_HIGH:
 		break;
@@ -1543,6 +1582,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_cache_hwparams(dwc);
 
 	spin_lock_init(&dwc->lock);
+	mutex_init(&dwc->mutex);
 
 	pm_runtime_set_active(dev);
 	pm_runtime_use_autosuspend(dev);
@@ -1619,6 +1659,9 @@ disable_clks:
 assert_reset:
 	reset_control_assert(dwc->reset);
 
+	if (dwc->usb_psy)
+		power_supply_put(dwc->usb_psy);
+
 	return ret;
 }
 
@@ -1628,8 +1671,8 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
-	dwc3_debugfs_exit(dwc);
 	dwc3_core_exit_mode(dwc);
+	dwc3_debugfs_exit(dwc);
 
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
@@ -1641,6 +1684,9 @@ static int dwc3_remove(struct platform_device *pdev)
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
 
+	if (dwc->usb_psy)
+		power_supply_put(dwc->usb_psy);
+
 	return 0;
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 052b20d52651..c5d5760cdf53 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -13,6 +13,7 @@
 
 #include <linux/device.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/bitops.h>
@@ -30,6 +31,8 @@
 
 #include <linux/phy/phy.h>
 
+#include <linux/power_supply.h>
+
 #define DWC3_MSG_MAX	500
 
 /* Global constants */
@@ -54,7 +57,7 @@
 #define DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE	3
 #define DWC3_DEVICE_EVENT_WAKEUP		4
 #define DWC3_DEVICE_EVENT_HIBER_REQ		5
-#define DWC3_DEVICE_EVENT_EOPF			6
+#define DWC3_DEVICE_EVENT_SUSPEND		6
 #define DWC3_DEVICE_EVENT_SOF			7
 #define DWC3_DEVICE_EVENT_ERRATIC_ERROR		9
 #define DWC3_DEVICE_EVENT_CMD_CMPL		10
@@ -140,6 +143,7 @@
 #define DWC3_GHWPARAMS8		0xc600
 #define DWC3_GUCTL3		0xc60c
 #define DWC3_GFLADJ		0xc630
+#define DWC3_GHWPARAMS9		0xc680
 
 /* Device Registers */
 #define DWC3_DCFG		0xc700
@@ -375,6 +379,9 @@
 #define DWC3_GHWPARAMS7_RAM1_DEPTH(n)	((n) & 0xffff)
 #define DWC3_GHWPARAMS7_RAM2_DEPTH(n)	(((n) >> 16) & 0xffff)
 
+/* Global HWPARAMS9 Register */
+#define DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS	BIT(0)
+
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
@@ -396,12 +403,12 @@
 #define DWC3_DCFG_SUPERSPEED	(4 << 0)
 #define DWC3_DCFG_HIGHSPEED	(0 << 0)
 #define DWC3_DCFG_FULLSPEED	BIT(0)
-#define DWC3_DCFG_LOWSPEED	(2 << 0)
 
 #define DWC3_DCFG_NUMP_SHIFT	17
 #define DWC3_DCFG_NUMP(n)	(((n) >> DWC3_DCFG_NUMP_SHIFT) & 0x1f)
 #define DWC3_DCFG_NUMP_MASK	(0x1f << DWC3_DCFG_NUMP_SHIFT)
 #define DWC3_DCFG_LPM_CAP	BIT(22)
+#define DWC3_DCFG_IGNSTRMPP	BIT(23)
 
 /* Device Control Register */
 #define DWC3_DCTL_RUN_STOP	BIT(31)
@@ -453,7 +460,7 @@
 #define DWC3_DEVTEN_CMDCMPLTEN		BIT(10)
 #define DWC3_DEVTEN_ERRTICERREN		BIT(9)
 #define DWC3_DEVTEN_SOFEN		BIT(7)
-#define DWC3_DEVTEN_EOPFEN		BIT(6)
+#define DWC3_DEVTEN_U3L2L1SUSPEN	BIT(6)
 #define DWC3_DEVTEN_HIBERNATIONREQEVTEN	BIT(5)
 #define DWC3_DEVTEN_WKUPEVTEN		BIT(4)
 #define DWC3_DEVTEN_ULSTCNGEN		BIT(3)
@@ -490,7 +497,6 @@
 #define DWC3_DSTS_SUPERSPEED		(4 << 0)
 #define DWC3_DSTS_HIGHSPEED		(0 << 0)
 #define DWC3_DSTS_FULLSPEED		BIT(0)
-#define DWC3_DSTS_LOWSPEED		(2 << 0)
 
 /* Device Generic Command Register */
 #define DWC3_DGCMD_SET_LMP		0x01
@@ -844,6 +850,7 @@ struct dwc3_trb {
  * @hwparams6: GHWPARAMS6
  * @hwparams7: GHWPARAMS7
  * @hwparams8: GHWPARAMS8
+ * @hwparams9: GHWPARAMS9
  */
 struct dwc3_hwparams {
 	u32	hwparams0;
@@ -855,13 +862,12 @@ struct dwc3_hwparams {
 	u32	hwparams6;
 	u32	hwparams7;
 	u32	hwparams8;
+	u32	hwparams9;
 };
 
 /* HWPARAMS0 */
 #define DWC3_MODE(n)		((n) & 0x7)
 
-#define DWC3_MDWIDTH(n)		(((n) & 0xff00) >> 8)
-
 /* HWPARAMS1 */
 #define DWC3_NUM_INT(n)		(((n) & (0x3f << 15)) >> 15)
 
@@ -908,11 +914,13 @@ struct dwc3_request {
 	unsigned int		remaining;
 
 	unsigned int		status;
-#define DWC3_REQUEST_STATUS_QUEUED	0
-#define DWC3_REQUEST_STATUS_STARTED	1
-#define DWC3_REQUEST_STATUS_CANCELLED	2
-#define DWC3_REQUEST_STATUS_COMPLETED	3
-#define DWC3_REQUEST_STATUS_UNKNOWN	-1
+#define DWC3_REQUEST_STATUS_QUEUED		0
+#define DWC3_REQUEST_STATUS_STARTED		1
+#define DWC3_REQUEST_STATUS_DISCONNECTED	2
+#define DWC3_REQUEST_STATUS_DEQUEUED		3
+#define DWC3_REQUEST_STATUS_STALLED		4
+#define DWC3_REQUEST_STATUS_COMPLETED		5
+#define DWC3_REQUEST_STATUS_UNKNOWN		-1
 
 	u8			epnum;
 	struct dwc3_trb		*trb;
@@ -946,6 +954,7 @@ struct dwc3_scratchpad_array {
  * @scratch_addr: dma address of scratchbuf
  * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
+ * @mutex: for mode switching
  * @dev: pointer to our struct device
  * @sysdev: pointer to the DMA-capable device
  * @xhci: pointer to our xHCI child
@@ -986,6 +995,7 @@ struct dwc3_scratchpad_array {
  * @role_sw: usb_role_switch handle
  * @role_switch_default_mode: default operation mode of controller while
  *			usb role is USB_ROLE_NONE.
+ * @usb_psy: pointer to power supply interface.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1034,7 +1044,8 @@ struct dwc3_scratchpad_array {
  * @dis_start_transfer_quirk: set if start_transfer failure SW workaround is
  *			not needed for DWC_usb31 version 1.70a-ea06 and below
  * @usb3_lpm_capable: set if hadrware supports Link Power Management
- * @usb2_lpm_disable: set to disable usb2 lpm
+ * @usb2_lpm_disable: set to disable usb2 lpm for host
+ * @usb2_gadget_lpm_disable: set to disable usb2 lpm for gadget
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
  * @u2exit_lfps_quirk: set if we enable u2exit lfps quirk
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
@@ -1085,6 +1096,9 @@ struct dwc3 {
 	/* device lock */
 	spinlock_t		lock;
 
+	/* mode switching lock */
+	struct mutex		mutex;
+
 	struct device		*dev;
 	struct device		*sysdev;
 
@@ -1125,6 +1139,8 @@ struct dwc3 {
 	struct usb_role_switch	*role_sw;
 	enum usb_dr_mode	role_switch_default_mode;
 
+	struct power_supply	*usb_psy;
+
 	u32			fladj;
 	u32			irq_gadget;
 	u32			otg_irq;
@@ -1238,6 +1254,7 @@ struct dwc3 {
 	unsigned		dis_start_transfer_quirk:1;
 	unsigned		usb3_lpm_capable:1;
 	unsigned		usb2_lpm_disable:1;
+	unsigned		usb2_gadget_lpm_disable:1;
 
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
@@ -1358,7 +1375,7 @@ struct dwc3_event_depevt {
  *	3	- ULStChng
  *	4	- WkUpEvt
  *	5	- Reserved
- *	6	- EOPF
+ *	6	- Suspend (EOPF on revisions 2.10a and prior)
  *	7	- SOF
  *	8	- Reserved
  *	9	- ErrticErr
@@ -1455,6 +1472,23 @@ u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 	 (!(_ip##_VERSIONTYPE_##_to) ||					\
 	  dwc->version_type <= _ip##_VERSIONTYPE_##_to))
 
+/**
+ * dwc3_mdwidth - get MDWIDTH value in bits
+ * @dwc: pointer to our context structure
+ *
+ * Return MDWIDTH configuration value in bits.
+ */
+static inline u32 dwc3_mdwidth(struct dwc3 *dwc)
+{
+	u32 mdwidth;
+
+	mdwidth = DWC3_GHWPARAMS0_MDWIDTH(dwc->hwparams.hwparams0);
+	if (DWC3_IP_IS(DWC32))
+		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
+
+	return mdwidth;
+}
+
 bool dwc3_has_imod(struct dwc3 *dwc);
 
 int dwc3_event_buffers_setup(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 8ab394942360..d223c54115f4 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * debug.h - DesignWare USB3 DRD Controller Debug Header
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
@@ -221,8 +221,8 @@ static inline const char *dwc3_gadget_event_string(char *str, size_t size,
 		snprintf(str, size, "WakeUp [%s]",
 				dwc3_gadget_link_string(state));
 		break;
-	case DWC3_DEVICE_EVENT_EOPF:
-		snprintf(str, size, "End-Of-Frame [%s]",
+	case DWC3_DEVICE_EVENT_SUSPEND:
+		snprintf(str, size, "Suspend [%s]",
 				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
@@ -353,8 +353,8 @@ static inline const char *dwc3_gadget_event_type_string(u8 event)
 		return "Wake-Up";
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
 		return "Hibernation";
-	case DWC3_DEVICE_EVENT_EOPF:
-		return "End of Periodic Frame";
+	case DWC3_DEVICE_EVENT_SUSPEND:
+		return "Suspend";
 	case DWC3_DEVICE_EVENT_SOF:
 		return "Start of Frame";
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
@@ -413,9 +413,12 @@ static inline const char *dwc3_gadget_generic_cmd_status_string(int status)
 
 
 #ifdef CONFIG_DEBUG_FS
+extern void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep);
 extern void dwc3_debugfs_init(struct dwc3 *d);
 extern void dwc3_debugfs_exit(struct dwc3 *d);
 #else
+static inline void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
+{  }
 static inline void dwc3_debugfs_init(struct dwc3 *d)
 {  }
 static inline void dwc3_debugfs_exit(struct dwc3 *d)
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8b668ef46f7f..3cd294264372 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -292,6 +292,9 @@ static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
 		epnum |= 1;
 
 	dep = dwc->eps[epnum];
+	if (dep == NULL)
+		return NULL;
+
 	if (dep->flags & DWC3_EP_ENABLED)
 		return dep;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c7ef218e7a8c..f14c2aa83759 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -308,13 +308,12 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	}
 
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
-		int		needs_wakeup;
+		int link_state;
 
-		needs_wakeup = (dwc->link_state == DWC3_LINK_STATE_U1 ||
-				dwc->link_state == DWC3_LINK_STATE_U2 ||
-				dwc->link_state == DWC3_LINK_STATE_U3);
-
-		if (unlikely(needs_wakeup)) {
+		link_state = dwc3_gadget_get_link_state(dwc);
+		if (link_state == DWC3_LINK_STATE_U1 ||
+		    link_state == DWC3_LINK_STATE_U2 ||
+		    link_state == DWC3_LINK_STATE_U3) {
 			ret = __dwc3_gadget_wakeup(dwc);
 			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
 					ret);
@@ -608,12 +607,14 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 		u8 bInterval_m1;
 
 		/*
-		 * Valid range for DEPCFG.bInterval_m1 is from 0 to 13, and it
-		 * must be set to 0 when the controller operates in full-speed.
+		 * Valid range for DEPCFG.bInterval_m1 is from 0 to 13.
+		 *
+		 * NOTE: The programming guide incorrectly stated bInterval_m1
+		 * must be set to 0 when operating in fullspeed. Internally the
+		 * controller does not have this limitation. See DWC_usb3x
+		 * programming guide section 3.2.2.1.
 		 */
 		bInterval_m1 = min_t(u8, desc->bInterval - 1, 13);
-		if (dwc->gadget->speed == USB_SPEED_FULL)
-			bInterval_m1 = 0;
 
 		if (usb_endpoint_type(desc) == USB_ENDPOINT_XFER_INT &&
 		    dwc->gadget->speed == USB_SPEED_FULL)
@@ -729,8 +730,16 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 			 * All stream eps will reinitiate stream on NoStream
 			 * rejection until we can determine that the host can
 			 * prime after the first transfer.
+			 *
+			 * However, if the controller is capable of
+			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
+			 * automatically restart the stream without the driver
+			 * initiation.
 			 */
-			dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
+			if (!dep->direction ||
+			    !(dwc->hwparams.hwparams9 &
+			      DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
+				dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
 		}
 	}
 
@@ -1235,6 +1244,7 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 			req->start_sg = sg_next(s);
 
 		req->num_queued_sgs++;
+		req->num_pending_sgs--;
 
 		/*
 		 * The number of pending SG entries may not correspond to the
@@ -1242,7 +1252,7 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 		 * don't include unused SG entries.
 		 */
 		if (length == 0) {
-			req->num_pending_sgs -= req->request.num_mapped_sgs - req->num_queued_sgs;
+			req->num_pending_sgs = 0;
 			break;
 		}
 
@@ -1402,7 +1412,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		dwc3_stop_active_transfer(dep, true, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
-			dwc3_gadget_move_cancelled_request(req);
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
 
 		/* If ep isn't started, then there's no end transfer pending */
 		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
@@ -1675,7 +1685,9 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		}
 	}
 
-	return __dwc3_gadget_kick_transfer(dep);
+	__dwc3_gadget_kick_transfer(dep);
+
+	return 0;
 }
 
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
@@ -1729,10 +1741,25 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
 	struct dwc3_request		*tmp;
+	struct dwc3			*dwc = dep->dwc;
 
 	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
 		dwc3_gadget_ep_skip_trbs(dep, req);
-		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+		switch (req->status) {
+		case DWC3_REQUEST_STATUS_DISCONNECTED:
+			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+			break;
+		case DWC3_REQUEST_STATUS_DEQUEUED:
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			break;
+		case DWC3_REQUEST_STATUS_STALLED:
+			dwc3_gadget_giveback(dep, req, -EPIPE);
+			break;
+		default:
+			dev_err(dwc->dev, "request cancelled with wrong reason:%d\n", req->status);
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			break;
+		}
 	}
 }
 
@@ -1776,7 +1803,8 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			 * cancelled.
 			 */
 			list_for_each_entry_safe(r, t, &dep->started_list, list)
-				dwc3_gadget_move_cancelled_request(r);
+				dwc3_gadget_move_cancelled_request(r,
+						DWC3_REQUEST_STATUS_DEQUEUED);
 
 			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
 
@@ -1848,7 +1876,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		dwc3_stop_active_transfer(dep, true, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
-			dwc3_gadget_move_cancelled_request(req);
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
 
 		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
@@ -1973,6 +2001,8 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	case DWC3_LINK_STATE_RESET:
 	case DWC3_LINK_STATE_RX_DET:	/* in HS, means Early Suspend */
 	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
+	case DWC3_LINK_STATE_U2:	/* in HS, means Sleep (L1) */
+	case DWC3_LINK_STATE_U1:
 	case DWC3_LINK_STATE_RESUME:
 		break;
 	default:
@@ -2113,9 +2143,6 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 		reg |= DWC3_DCFG_SUPERSPEED;
 	} else {
 		switch (speed) {
-		case USB_SPEED_LOW:
-			reg |= DWC3_DCFG_LOWSPEED;
-			break;
 		case USB_SPEED_FULL:
 			reg |= DWC3_DCFG_FULLSPEED;
 			break;
@@ -2234,13 +2261,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	}
 
 	/*
-	 * Synchronize any pending event handling before executing the controller
-	 * halt routine.
+	 * Synchronize and disable any further event handling while controller
+	 * is being enabled/disabled.
 	 */
-	if (!is_on) {
-		dwc3_gadget_disable_irq(dwc);
-		synchronize_irq(dwc->irq_gadget);
-	}
+	disable_irq(dwc->irq_gadget);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
@@ -2278,6 +2302,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	enable_irq(dwc->irq_gadget);
+
 	pm_runtime_put(dwc->dev);
 
 	return ret;
@@ -2299,6 +2325,10 @@ static void dwc3_gadget_enable_irq(struct dwc3 *dwc)
 	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
 		reg |= DWC3_DEVTEN_ULSTCNGEN;
 
+	/* On 2.30a and above this bit enables U3/L2-L1 Suspend Events */
+	if (!DWC3_VER_IS_PRIOR(DWC3, 230A))
+		reg |= DWC3_DEVTEN_U3L2L1SUSPEN;
+
 	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
 }
 
@@ -2340,9 +2370,7 @@ static void dwc3_gadget_setup_nump(struct dwc3 *dwc)
 	u32 reg;
 
 	ram2_depth = DWC3_GHWPARAMS7_RAM2_DEPTH(dwc->hwparams.hwparams7);
-	mdwidth = DWC3_GHWPARAMS0_MDWIDTH(dwc->hwparams.hwparams0);
-	if (DWC3_IP_IS(DWC32))
-		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
+	mdwidth = dwc3_mdwidth(dwc);
 
 	nump = ((ram2_depth * mdwidth / 8) - 24 - 16) / 1024;
 	nump = min_t(u32, nump, 16);
@@ -2388,6 +2416,17 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 
 	dwc3_gadget_setup_nump(dwc);
 
+	/*
+	 * Currently the controller handles single stream only. So, Ignore
+	 * Packet Pending bit for stream selection and don't search for another
+	 * stream if the host sends Data Packet with PP=0 (for OUT direction) or
+	 * ACK with NumP=0 and PP=0 (for IN direction). This slightly improves
+	 * the stream performance.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg |= DWC3_DCFG_IGNSTRMPP;
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
@@ -2531,11 +2570,19 @@ static void dwc3_gadget_set_ssp_rate(struct usb_gadget *g,
 static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
+	union power_supply_propval	val = {0};
+	int				ret;
 
 	if (dwc->usb2_phy)
 		return usb_phy_set_power(dwc->usb2_phy, mA);
 
-	return 0;
+	if (!dwc->usb_psy)
+		return -EOPNOTSUPP;
+
+	val.intval = 1000 * mA;
+	ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
+
+	return ret;
 }
 
 static const struct usb_gadget_ops dwc3_gadget_ops = {
@@ -2571,12 +2618,10 @@ static int dwc3_gadget_init_control_endpoint(struct dwc3_ep *dep)
 static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
-	int mdwidth;
+	u32 mdwidth;
 	int size;
 
-	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
-	if (DWC3_IP_IS(DWC32))
-		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
+	mdwidth = dwc3_mdwidth(dwc);
 
 	/* MDWIDTH is represented in bits, we need it in bytes */
 	mdwidth /= 8;
@@ -2618,12 +2663,10 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
-	int mdwidth;
+	u32 mdwidth;
 	int size;
 
-	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
-	if (DWC3_IP_IS(DWC32))
-		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
+	mdwidth = dwc3_mdwidth(dwc);
 
 	/* MDWIDTH is represented in bits, convert to bytes */
 	mdwidth /= 8;
@@ -2710,6 +2753,8 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	INIT_LIST_HEAD(&dep->started_list);
 	INIT_LIST_HEAD(&dep->cancelled_list);
 
+	dwc3_debugfs_create_endpoint_dir(dep);
+
 	return 0;
 }
 
@@ -2753,6 +2798,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
+		debugfs_remove_recursive(debugfs_lookup(dep->name, dwc->root));
 		kfree(dep);
 	}
 }
@@ -2830,15 +2876,15 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 	struct dwc3_trb *trb = &dep->trb_pool[dep->trb_dequeue];
 	struct scatterlist *sg = req->sg;
 	struct scatterlist *s;
-	unsigned int pending = req->num_pending_sgs;
+	unsigned int num_queued = req->num_queued_sgs;
 	unsigned int i;
 	int ret = 0;
 
-	for_each_sg(sg, s, pending, i) {
+	for_each_sg(sg, s, num_queued, i) {
 		trb = &dep->trb_pool[dep->trb_dequeue];
 
 		req->sg = sg_next(s);
-		req->num_pending_sgs--;
+		req->num_queued_sgs--;
 
 		ret = dwc3_gadget_ep_reclaim_completed_trb(dep, req,
 				trb, event, status, true);
@@ -2861,7 +2907,7 @@ static int dwc3_gadget_ep_reclaim_trb_linear(struct dwc3_ep *dep,
 
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
-	return req->num_pending_sgs == 0;
+	return req->num_pending_sgs == 0 && req->num_queued_sgs == 0;
 }
 
 static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
@@ -2870,7 +2916,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 {
 	int ret;
 
-	if (req->num_pending_sgs)
+	if (req->request.num_mapped_sgs)
 		ret = dwc3_gadget_ep_reclaim_trb_sg(dep, req, event,
 				status);
 	else
@@ -2913,6 +2959,11 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
 static bool dwc3_gadget_ep_should_continue(struct dwc3_ep *dep)
 {
 	struct dwc3_request	*req;
+	struct dwc3		*dwc = dep->dwc;
+
+	if (!dep->endpoint.desc || !dwc->pullups_connected ||
+	    !dwc->connected)
+		return false;
 
 	if (!list_empty(&dep->pending_list))
 		return true;
@@ -3322,6 +3373,15 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 {
 	u32			reg;
 
+	/*
+	 * Ideally, dwc3_reset_gadget() would trigger the function
+	 * drivers to stop any active transfers through ep disable.
+	 * However, for functions which defer ep disable, such as mass
+	 * storage, we will need to rely on the call to stop active
+	 * transfers here, and avoid allowing of request queuing.
+	 */
+	dwc->connected = false;
+
 	/*
 	 * WORKAROUND: DWC3 revisions <1.88a have an issue which
 	 * would cause a missing Disconnect Event if there's a
@@ -3448,11 +3508,6 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		dwc->gadget->ep0->maxpacket = 64;
 		dwc->gadget->speed = USB_SPEED_FULL;
 		break;
-	case DWC3_DSTS_LOWSPEED:
-		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(8);
-		dwc->gadget->ep0->maxpacket = 8;
-		dwc->gadget->speed = USB_SPEED_LOW;
-		break;
 	}
 
 	dwc->eps[1]->endpoint.maxpacket = dwc->gadget->ep0->maxpacket;
@@ -3460,6 +3515,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	/* Enable USB2 LPM Capability */
 
 	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A) &&
+	    !dwc->usb2_gadget_lpm_disable &&
 	    (speed != DWC3_DSTS_SUPERSPEED) &&
 	    (speed != DWC3_DSTS_SUPERSPEED_PLUS)) {
 		reg = dwc3_readl(dwc->regs, DWC3_DCFG);
@@ -3486,6 +3542,12 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {
+		if (dwc->usb2_gadget_lpm_disable) {
+			reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+			reg &= ~DWC3_DCFG_LPM_CAP;
+			dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+		}
+
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~DWC3_DCTL_HIRD_THRES_MASK;
 		dwc3_gadget_dctl_write_safe(dwc, reg);
@@ -3687,7 +3749,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
 		break;
-	case DWC3_DEVICE_EVENT_EOPF:
+	case DWC3_DEVICE_EVENT_SUSPEND:
 		/* It changed to be suspend event for version 2.30a and above */
 		if (!DWC3_VER_IS_PRIOR(DWC3, 230A)) {
 			/*
@@ -3934,7 +3996,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget->ssp_rate		= USB_SSP_GEN_UNKNOWN;
 	dwc->gadget->sg_supported	= true;
 	dwc->gadget->name		= "dwc3-gadget";
-	dwc->gadget->lpm_capable	= true;
+	dwc->gadget->lpm_capable	= !dwc->usb2_gadget_lpm_disable;
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -3986,6 +4048,7 @@ err5:
 	dwc3_gadget_free_endpoints(dwc);
 err4:
 	usb_put_gadget(dwc->gadget);
+	dwc->gadget = NULL;
 err3:
 	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
 			dwc->bounce_addr);
@@ -4005,8 +4068,12 @@ err0:
 
 void dwc3_gadget_exit(struct dwc3 *dwc)
 {
-	usb_del_gadget_udc(dwc->gadget);
+	if (!dwc->gadget)
+		return;
+
+	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
+	usb_put_gadget(dwc->gadget);
 	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
 			  dwc->bounce_addr);
 	kfree(dwc->setup_buf);
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 0cd281949970..77df4b6d6c13 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -90,15 +90,17 @@ static inline void dwc3_gadget_move_started_request(struct dwc3_request *req)
 /**
  * dwc3_gadget_move_cancelled_request - move @req to the cancelled_list
  * @req: the request to be moved
+ * @reason: cancelled reason for the dwc3 request
  *
  * Caller should take care of locking. This function will move @req from its
  * current list to the endpoint's cancelled_list.
  */
-static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req)
+static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req,
+		unsigned int reason)
 {
 	struct dwc3_ep		*dep = req->dep;
 
-	req->status = DWC3_REQUEST_STATUS_CANCELLED;
+	req->status = reason;
 	list_move_tail(&req->list, &dep->cancelled_list);
 }
 
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 76b73b116862..1e96ea339d48 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * io.h - DesignWare USB3 DRD IO Header
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
-- 
2.43.0

