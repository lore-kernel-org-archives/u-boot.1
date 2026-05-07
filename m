Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6B0CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC40884AD7;
	Thu,  7 May 2026 11:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u1ffgDoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9986584AD9; Thu,  7 May 2026 11:30:24 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1225884AD5
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5a887ebb416so537226e87.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146220; x=1778751020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tii5XPuo3tp6MsjHtKpUQV9ZWQMyOWOwOCghHozjgjY=;
 b=u1ffgDoUdTa3V0RgXOCcgyVUsNjZSOEr1yJbgbTXBUQ1d73Y2sF2D6kYJgiDHGprN7
 AxHI8ifnExyboxALzLIlZksXSvNuLSjbSrGs1CqMobzggbbYFmfxCTSKcH8pNJVuohR9
 z4VM1zdsBp3waZUzygu9umAOeCMf+0XkDPwuLnUz4rIbun1rQtMrAIzI2c9MgMc9ubHJ
 SiYhVXMEP12qH5IDrkhaD64AGNuBBUX9mCGAlZInmdRKXSbEjYGBXHo7dDB/bT8qDuNc
 fhtl8wW15AljodJDARGbi6z3oJsHeLiMPDdV4HUT9BvFOI+ukEGYwyTjPFaP+QF0SfwU
 coRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146220; x=1778751020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tii5XPuo3tp6MsjHtKpUQV9ZWQMyOWOwOCghHozjgjY=;
 b=X3gAo6zar2XEdoq9JDJ1k4rBl1+FHX1irj1zBzTMAH8/C908lRTIWNuBDVqiL2pQMg
 Zl/IaBtBjFSdmquHFqdEGSjtr93QMEG0Pq/7+HFlu6DyS5pfRghaldJKWYKVH3ZF11xW
 dGXPjT7zRRqIok0jd4BUq2dDesjVwvGg0MEsfjq4ycIfixTvo0oEcy09BeyX2+RPByLb
 IVN8C4NgUhtD+rTfFLPIW/zRoTAGobZoyKR3iZ8wEbxqwVEquGofX8sq9+BeIOtq0ZO1
 jG+CYNfC5pYUcM/iaomhjvcgnFPG4bq/a9OmK4rV+KSRK2veNGg/aPnZXRB9+pOlsdZr
 qOuw==
X-Gm-Message-State: AOJu0YwJyt0Fq0muYb2Xjf1aXIaeRh0I+087V+yBB007mMoZTXLz0gTk
 Y2flbES41dxvBdiFX8NvOtRpcqA3n/JV5/RlY8EQqFuMs0NlPBAM6zgx34/LYMsy5bjPMuNusul
 lRofyHaDLhg==
X-Gm-Gg: AeBDiev9Ln/TNbF7c+k/VFrxhkUfremJrFpYFEB9i2Yz9UorZgZ5OcmN3m7ZAZlR33i
 Z/1qf/nFi18AFmFq4lTUD6UqTMBRNLKxXiUnLfHrbjPrb8zS8odnl/zA0y1w2NlqTPpayDEC7QN
 oKDuG1Hf1YfkBAPnwmYus/Coro194xIq/LFu8vhKjPo4zY/6xHgGJAAJNmBuZgfjBPw6a0XJLYF
 lnTJ664acsR+xHXr4XQnvd79CIDV5a0TJkSS9J5gSm5lIdFrEvAV7tpUf3DVPa0zx7KhHI6532f
 ddUhb/YzsWa1ZZgFvbQLovXPCAWJ4Cm15ZkGAV3Mt3PDzq9vax2VI7sNhdjjmPb/tau4UAyERN2
 B1N2mrbD7jwmMwToVabpsNidKIu1x0epkQUUc5DwnSnXySyuQaLqiTjjBqfk/DZJliQ6x4d5oja
 yv3xBxqHLoA3f2Y8shxR0MJpqjFqjmQZEPimdS0U/EESUNFse3h4GDgdqJYrfqvhBroesdJg/+d
 IAheJFq5J/LSsxiBpu9+9eQ2duEHb3t22hkdUydwA==
X-Received: by 2002:a05:6512:6d2:b0:5a8:8de0:4570 with SMTP id
 2adb3069b0e04-5a88de04650mr1759627e87.21.1778146219395; 
 Thu, 07 May 2026 02:30:19 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:30:18 -0700 (PDT)
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
Subject: [RFC PATCH v2 31/64] usb: dwc3: import from kernel v5.7
Date: Thu,  7 May 2026 11:27:38 +0200
Message-ID: <20260507092843.358908-32-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.6 to v5.7.

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

List of commits: git log --oneline v5.6..v5.7
Commits imported:
4748d396399a usb: dwc3: select USB_ROLE_SWITCH
066c09593454 usb: dwc3: pci: Enable extcon driver for Intel Merrifield
00e21763f2c8 dwc3: Remove check for HWO flag in dwc3_gadget_ep_reclaim_trb_sg()
49e0590e3a60 usb: dwc3: gadget: Fix request completion check
d0550cd20e52 usb: dwc3: gadget: Do link recovery for SS and SSP
d94ea5319813 usb: dwc3: gadget: Properly set maxpacket limit
586f4335700f usb: dwc3: Fix GTXFIFOSIZ.TXFDEP macro name
0339f7fbc82e usb: dwc3: fix up for role switch API change
a8ab3e76297e Merge tag 'usb-for-v5.7' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
201c26c08db4 usb: dwc3: qcom: Replace <linux/clk-provider.h> by <linux/of_clk.h>
0227cc84c444 usb: dwc3: core: don't do suspend for device mode if already suspended
4a1d042af420 usb: dwc3: Rework resets initialization to be more flexible
0d3a97083e0c usb: dwc3: Rework clock initialization to be more flexible
98ed256a4dba usb: dwc3: Add support for role-switch-default-mode binding
8a0a13799744 usb: dwc3: Registering a role switch in the DRD code.
7ba6b09fda5e usb: dwc3: core: add support for disabling SS instances in park mode
2dedea035ae8 usb: dwc3: gadget: Wrap around when skip TRBs
a114c4ca64bd usb: dwc3: gadget: Don't clear flags before transfer ended
a33e5d639c9b usb: dwc3: Remove kernel doc annotation where it's not needed
11c39809070f usb: dwc3: Add ACPI support for xHCI ports
07f6842341ab usb: dwc3: exynos: Add support for Exynos5422 suspend clk
238d76021654 usb: dwc3: meson-g12a: Don't use ret uninitialized in dwc3_meson_g12a_otg_init
1e355f21d3fb usb: dwc3: Add Amlogic A1 DWC3 glue
30ad6273adad usb: dwc3: trace: print enqueue/dequeue pointers too
8e567ed9e244 Merge 5.6-rc5 into usb-next
bce3052f0c16 usb: roles: Provide the switch drivers handle to the switch in the API
24e6aea4801b Merge 5.6-rc3 into usb-next
882f7a4dae1d usb: dwc3: qcom: Replace <linux/clk-provider.h> by <linux/of_clk.h>

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   | 29 ++++++-------
 drivers/usb/dwc3/core.h   | 18 ++++++++-
 drivers/usb/dwc3/gadget.c | 85 ++++++++++++++++++++++-----------------
 3 files changed, 78 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1d85c42b9c67..edc17155cb2b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -289,12 +289,6 @@ done:
 	return 0;
 }
 
-static const struct clk_bulk_data dwc3_core_clks[] = {
-	{ .id = "ref" },
-	{ .id = "bus_early" },
-	{ .id = "suspend" },
-};
-
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
@@ -1029,6 +1023,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->dis_tx_ipgap_linecheck_quirk)
 			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
 
+		if (dwc->parkmode_disable_ss_quirk)
+			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
+
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
@@ -1342,6 +1339,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-del-phy-power-chg-quirk");
 	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
 				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
+				"snps,parkmode-disable-ss-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
@@ -1441,11 +1440,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (!dwc)
 		return -ENOMEM;
 
-	dwc->clks = devm_kmemdup(dev, dwc3_core_clks, sizeof(dwc3_core_clks),
-				 GFP_KERNEL);
-	if (!dwc->clks)
-		return -ENOMEM;
-
 	dwc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1476,22 +1470,23 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
+	dwc->reset = devm_reset_control_array_get(dev, true, true);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
 
 	if (dev->of_node) {
-		dwc->num_clks = ARRAY_SIZE(dwc3_core_clks);
-
-		ret = devm_clk_bulk_get(dev, dwc->num_clks, dwc->clks);
+		ret = devm_clk_bulk_get_all(dev, &dwc->clks);
 		if (ret == -EPROBE_DEFER)
 			return ret;
 		/*
 		 * Clocks are optional, but new DT platforms should support all
 		 * clocks as required by the DT-binding.
 		 */
-		if (ret)
+		if (ret < 0)
 			dwc->num_clks = 0;
+		else
+			dwc->num_clks = ret;
+
 	}
 
 	ret = reset_control_deassert(dwc->reset);
@@ -1637,6 +1632,8 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
+		if (pm_runtime_suspended(dwc->dev))
+			break;
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 77c4a9abe365..4c171a8e215f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -25,6 +25,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 #include <linux/ulpi/interface.h>
 
 #include <linux/phy/phy.h>
@@ -249,6 +250,7 @@
 #define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
 
 /* Global User Control 1 Register */
+#define DWC3_GUCTL1_PARKMODE_DISABLE_SS	BIT(17)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
@@ -305,10 +307,14 @@
 
 /* Global TX Fifo Size Register */
 #define DWC31_GTXFIFOSIZ_TXFRAMNUM	BIT(15)		/* DWC_usb31 only */
-#define DWC31_GTXFIFOSIZ_TXFDEF(n)	((n) & 0x7fff)	/* DWC_usb31 only */
-#define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
+#define DWC31_GTXFIFOSIZ_TXFDEP(n)	((n) & 0x7fff)	/* DWC_usb31 only */
+#define DWC3_GTXFIFOSIZ_TXFDEP(n)	((n) & 0xffff)
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
+/* Global RX Fifo Size Register */
+#define DWC31_GRXFIFOSIZ_RXFDEP(n)	((n) & 0x7fff)	/* DWC_usb31 only */
+#define DWC3_GRXFIFOSIZ_RXFDEP(n)	((n) & 0xffff)
+
 /* Global Event Size Registers */
 #define DWC3_GEVNTSIZ_INTMASK		BIT(31)
 #define DWC3_GEVNTSIZ_SIZE(n)		((n) & 0xffff)
@@ -953,6 +959,9 @@ struct dwc3_scratchpad_array {
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
+ * @role_sw: usb_role_switch handle
+ * @role_switch_default_mode: default operation mode of controller while
+ *			usb role is USB_ROLE_NONE.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1024,6 +1033,8 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
+ * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
+ *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  * 	0	- -6dB de-emphasis
@@ -1086,6 +1097,8 @@ struct dwc3 {
 	struct extcon_dev	*edev;
 	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
+	struct usb_role_switch	*role_sw;
+	enum usb_dr_mode	role_switch_default_mode;
 
 	u32			fladj;
 	u32			irq_gadget;
@@ -1215,6 +1228,7 @@ struct dwc3 {
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
+	unsigned		parkmode_disable_ss_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1e00bf2d65a2..585cb3deea7a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1521,7 +1521,7 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
 	for (i = 0; i < req->num_trbs; i++) {
 		struct dwc3_trb *trb;
 
-		trb = req->trb + i;
+		trb = &dep->trb_pool[dep->trb_dequeue];
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		dwc3_ep_inc_deq(dep);
 	}
@@ -1728,7 +1728,6 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	u32			reg;
 
 	u8			link_state;
-	u8			speed;
 
 	/*
 	 * According to the Databook Remote wakeup request should
@@ -1738,16 +1737,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	 */
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 
-	speed = reg & DWC3_DSTS_CONNECTSPD;
-	if ((speed == DWC3_DSTS_SUPERSPEED) ||
-	    (speed == DWC3_DSTS_SUPERSPEED_PLUS))
-		return 0;
-
 	link_state = DWC3_DSTS_USBLNKST(reg);
 
 	switch (link_state) {
+	case DWC3_LINK_STATE_RESET:
 	case DWC3_LINK_STATE_RX_DET:	/* in HS, means Early Suspend */
 	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
+	case DWC3_LINK_STATE_RESUME:
 		break;
 	default:
 		return -EINVAL;
@@ -2227,7 +2223,6 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
 	int mdwidth;
-	int kbytes;
 	int size;
 
 	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
@@ -2236,24 +2231,24 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 
 	size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1));
 	if (dwc3_is_usb31(dwc))
-		size = DWC31_GTXFIFOSIZ_TXFDEF(size);
+		size = DWC31_GTXFIFOSIZ_TXFDEP(size);
 	else
-		size = DWC3_GTXFIFOSIZ_TXFDEF(size);
+		size = DWC3_GTXFIFOSIZ_TXFDEP(size);
 
 	/* FIFO Depth is in MDWDITH bytes. Multiply */
 	size *= mdwidth;
 
-	kbytes = size / 1024;
-	if (kbytes == 0)
-		kbytes = 1;
-
 	/*
-	 * FIFO sizes account an extra MDWIDTH * (kbytes + 1) bytes for
-	 * internal overhead. We don't really know how these are used,
-	 * but documentation say it exists.
+	 * To meet performance requirement, a minimum TxFIFO size of 3x
+	 * MaxPacketSize is recommended for endpoints that support burst and a
+	 * minimum TxFIFO size of 2x MaxPacketSize for endpoints that don't
+	 * support burst. Use those numbers and we can calculate the max packet
+	 * limit as below.
 	 */
-	size -= mdwidth * (kbytes + 1);
-	size /= kbytes;
+	if (dwc->maximum_speed >= USB_SPEED_SUPER)
+		size /= 3;
+	else
+		size /= 2;
 
 	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 
@@ -2271,8 +2266,39 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
+	int mdwidth;
+	int size;
+
+	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
 
-	usb_ep_set_maxpacket_limit(&dep->endpoint, 1024);
+	/* MDWIDTH is represented in bits, convert to bytes */
+	mdwidth /= 8;
+
+	/* All OUT endpoints share a single RxFIFO space */
+	size = dwc3_readl(dwc->regs, DWC3_GRXFIFOSIZ(0));
+	if (dwc3_is_usb31(dwc))
+		size = DWC31_GRXFIFOSIZ_RXFDEP(size);
+	else
+		size = DWC3_GRXFIFOSIZ_RXFDEP(size);
+
+	/* FIFO depth is in MDWDITH bytes */
+	size *= mdwidth;
+
+	/*
+	 * To meet performance requirement, a minimum recommended RxFIFO size
+	 * is defined as follow:
+	 * RxFIFO size >= (3 x MaxPacketSize) +
+	 * (3 x 8 bytes setup packets size) + (16 bytes clock crossing margin)
+	 *
+	 * Then calculate the max packet limit as below.
+	 */
+	size -= (3 * 8) + 16;
+	if (size < 0)
+		size = 0;
+	else
+		size /= 3;
+
+	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 	dep->endpoint.max_streams = 15;
 	dep->endpoint.ops = &dwc3_gadget_ep_ops;
 	list_add_tail(&dep->endpoint.ep_list,
@@ -2457,9 +2483,6 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 	for_each_sg(sg, s, pending, i) {
 		trb = &dep->trb_pool[dep->trb_dequeue];
 
-		if (trb->ctrl & DWC3_TRB_CTRL_HWO)
-			break;
-
 		req->sg = sg_next(s);
 		req->num_pending_sgs--;
 
@@ -2484,14 +2507,7 @@ static int dwc3_gadget_ep_reclaim_trb_linear(struct dwc3_ep *dep,
 
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
-	/*
-	 * For OUT direction, host may send less than the setup
-	 * length. Return true for all OUT requests.
-	 */
-	if (!req->direction)
-		return true;
-
-	return req->request.actual == req->request.length;
+	return req->num_pending_sgs == 0;
 }
 
 static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
@@ -2515,8 +2531,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 
 	req->request.actual = req->request.length - req->remaining;
 
-	if (!dwc3_gadget_ep_request_completed(req) ||
-			req->num_pending_sgs) {
+	if (!dwc3_gadget_ep_request_completed(req)) {
 		__dwc3_gadget_kick_transfer(dep);
 		goto out;
 	}
@@ -2570,10 +2585,8 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
-	if (stop) {
+	if (stop)
 		dwc3_stop_active_transfer(dep, true, true);
-		dep->flags = DWC3_EP_ENABLED;
-	}
 
 	/*
 	 * WORKAROUND: This is the 2nd half of U1/U2 -> U0 workaround.
-- 
2.43.0

