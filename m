Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F28C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE59D80F49;
	Mon, 24 Aug 2026 16:45:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zCi1xa-JNJjJ; Mon, 24 Aug 2026 16:45:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589883;
	bh=23pfFLqJWnB3No+/wCGklZnciLzFWFIzD7FXqwFrMDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TIz+hzf+c/otTsBf+0Xur9CgHbyjPZSXeZSqYhG+EwEe5pQLNGN12PTBUYk4hOLTl
	 T4Jkq46L/2nTkYv3fSK5ZWd2aDkhW5leB6tcVVj2LfP6Lgc6tTzBzlY+tPUNtwCIa5
	 DD+q1UoJGo0m99NC4SsRvbfa3+DkLpjeP+hq/n7aFtmEiwsxBhTaK18DaJ7Edsfr5c
	 UQ3zXs8XW09XOd7CUUcOkRaD7Gnquu/eojlLW0yceQ+ZFJGMwAuvomalj2o+LoCtlR
	 nM5FFKeMGJJSLMXOruxojEwMgvadZA5L9LQx60ntI4Dm4mUR705OomTFSR61JGBXmn
	 re8S1U/NFtY0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21D2780E39;
	Mon, 24 Aug 2026 16:44:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4839A3AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A77A403F6
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_nT7_rDcjfK for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:30:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=vx3nXDEr
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3B64403F4
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:26 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c1676648c1eso25879066b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585424; x=1788190224;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=23pfFLqJWnB3No+/wCGklZnciLzFWFIzD7FXqwFrMDk=;
 b=vx3nXDErRfVl6fgGaMibcraYoj6WRDJHqoJcIOLs60+0oBf1nF9c3UuofbYsO7U2WC
 oC/IpPtRG2dTRSNpT44oDcgdnsSQINn2hRBjT69plby/0/KsWBYnIrCbfEi1CIttV6b9
 68U6lzhgQWH+331pVHpyC0+m+bpZHvIFyuvRLSmrgWSk4gCgYWkXKsTdc41VfuN9xWI9
 NumZyqwE1lZ1GLcKA6eDscw7cpEaCC9D/sL6ALKhlQOaiRKmYep0nIUGHOmIPo717A6d
 t3/nJjs7xbDz2ml4WqRy13pOrjJ9hTZHlAWCXkSypwMKjt0bozdzsa3aYggUFXlRg84T
 eygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585424; x=1788190224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=23pfFLqJWnB3No+/wCGklZnciLzFWFIzD7FXqwFrMDk=;
 b=B70yJT7oUSmTUPXlGcDmPzeVDRMsBRLpZK52yziVRCGZGGKSUo8a7JvJdowpTYsGlU
 cr32+qL8gCxHA+kvjqs4HRNWh15qYvgd0thWeffquQbBOTxOhxYmyu9WB+MHNg/Qi02p
 kVgFMV5ufr6iKzY/1jLEasGdTW9Ut0E8lFBTDGHUx07+W5NP5mhqeRIfV6nlitecQha0
 PM3Hy+5cdJ3xsYHXg9JvgTRgkkYZ6YWewMvmttMPazWe409cNavZHvzvL99VjvHIKAcd
 FP8MLis4IpwopbpJaro+CdfBdu05OHrGQtcwrEsKMiBFKWGzhMHRIYhjYQ3/9xQ9bC5k
 cpOw==
X-Gm-Message-State: AFuF++k44/tlrp6e1AbCOSqQ2CSJOJtiXobN12AI4YaP6RB42cTT6EFP
 jatNXVhag3y28gPo2SOPkpz0mudICBGYo+I7WvmSXIWyMgpEns5cClCJzbxe7x5/lz3+6rImcsV
 PUjaj
X-Gm-Gg: AR+sD13mc1OC4HtUTSR1EPinzJREPL3+D7S5ZfqRWHI4i7a32uZZDJjhuYQTRynw5Hd
 YLbHAGWXKuptRoPNPS6sRaZ7iOAGf9ChSOHhT3qrnI1LFdcdh92HjyYymawyHC8UwD3S1WIKJ+u
 Jg6JyB3drXaO3TAJNhDPcDbUW7On2a/+mSXd/cJcPEMn2bJvO7EquUW2sMDeeUoMB+fNUpwkes9
 sdSNIT1WEh30XUwrI8b5GrI5mhaxWBaR9xCG5fwW4WHiVvXr9TkVm+z8wwFWXpMK1avEnvvaczw
 Yx98Wh459L7qzbFEjATkO6Po7qjMACnqHHm8Y2GCOftL9q6UzO0nhDykciygnxvFzHkSzytAApf
 2qLup2gAN+qiGyu4MEBOLOb4FrUIepT/fU/BT/UguFWhMz5RvHnwKyHZ+S1YhvK13DOjzQ8PNtk
 /SJkDdiRXL8jjag562ZTa60bVBoyGrkCwtgVFZm40mLberGsvAbQqNFRRqKKZw+rTDH/9nJV25v
 sAl7tcpCbI8SZGfLb5SDepyk0U3uJfx
X-Received: by 2002:a17:907:97d1:b0:c12:732a:fe52 with SMTP id
 a640c23a62f3a-c246a6bd74emr1499249566b.4.1787585424161; 
 Mon, 24 Aug 2026 08:30:24 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm1479473666b.18.2026.08.24.08.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:30:23 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 32/63] usb: dwc3: import from kernel v5.7
Date: Mon, 24 Aug 2026 17:27:03 +0200
Message-ID: <20260824152734.159794-33-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.6 to v5.7.

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

List of commits: git log --oneline v5.6..v5.7
Commits imported:
00e21763f2c8 dwc3: Remove check for HWO flag in dwc3_gadget_ep_reclaim_trb_sg()
49e0590e3a60 usb: dwc3: gadget: Fix request completion check
d0550cd20e52 usb: dwc3: gadget: Do link recovery for SS and SSP
d94ea5319813 usb: dwc3: gadget: Properly set maxpacket limit
586f4335700f usb: dwc3: Fix GTXFIFOSIZ.TXFDEP macro name
0227cc84c444 usb: dwc3: core: don't do suspend for device mode if already suspended
4a1d042af420 usb: dwc3: Rework resets initialization to be more flexible
0d3a97083e0c usb: dwc3: Rework clock initialization to be more flexible
98ed256a4dba usb: dwc3: Add support for role-switch-default-mode binding
8a0a13799744 usb: dwc3: Registering a role switch in the DRD code.
7ba6b09fda5e usb: dwc3: core: add support for disabling SS instances in park mode
2dedea035ae8 usb: dwc3: gadget: Wrap around when skip TRBs
a114c4ca64bd usb: dwc3: gadget: Don't clear flags before transfer ended

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
2.53.0

