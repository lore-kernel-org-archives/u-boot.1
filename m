Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018B6C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7713284AC0;
	Mon, 29 Jun 2026 10:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yn9cuoMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C87F84AAE; Mon, 29 Jun 2026 10:47:15 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B69F984105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-39b030e889aso7821911fa.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722832; x=1783327632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3sFUABq2FnUtTDNkimzwPH4G5fxKPJj31e9Kvf8/6g=;
 b=Yn9cuoMKhley1OouoA/s0Fuv15ANOGPcy35rig7NEOf7MkfOM4PncJIZAdqj2NZUsQ
 8HRZ3/rFxgo7hEhWsKzioDLMMACBo7qKFdqe/2iefu91n8aVwtg6tMnLnj9Y72XYMnIo
 Khtjot92Kf369A59RU1s+iDs0xzMErdVX56Y/t+C1WbBW3zkyD4Rsy0jmN1we/3zFZUp
 q79B4fKElpkEn2JUewvlZfZUdFBgc7OdqDQAH05Jc8b634yYmp0tO/tpz9HkTxOM9r5g
 6lQhk6CK8l0++1O3hk/422pmBL3qmRBemWSUkXn8ohPv6rd4jnIGJZCGSV07LCjbpcd9
 9pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722832; x=1783327632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3sFUABq2FnUtTDNkimzwPH4G5fxKPJj31e9Kvf8/6g=;
 b=RUWsdcDPDqGAcaLO52q0uw6NiqsMZ+A+rafVQfipm3VNDGZ6PrXTI0pKMoDIreEXre
 RUomSXpZctnB8GElb+a2xKXFBbP2lNyCzqWWj1sJKXdCs5tGSTp/S3dxhgwqiuY36v9J
 nqkGTYjHWeeA84q+XAmNsikBlOjgJLrvqP1RKJ3AjY47cRPKhXznrS/ezUVa8o59yC+A
 MQRS9OY9DiJ+U2i5neGWbdSgVKkE90KzqKXSECI2fdqXG+kFNrmTslO0t+S2hQl5CY30
 cC6sJHdkMkDJKJUXCtZdI7r/SUWxbfHCrN6QKRbCp3VQWF3Agoi4HURBUcieIAbhDIMn
 N05A==
X-Gm-Message-State: AOJu0Ywz42CY6hp+deiSL/aFIuQPB3+13V4iXT1Yduqxv5slUtdFSETn
 VsnHVW3x8pTRVA3wk46paH+qWRtXaEmuoX6hgrC7mCbvN8BbIeEH2amTzyD49fUiiyBeBXcU5MR
 XqZ8e5vk=
X-Gm-Gg: AfdE7cnSPXWvtuYib5wF/8F7nyX/d5riojrwQRmrNNObip8WJdAJxrwACAvpWfFf3kK
 N0q5vWEgedQXVul6rIYsXSidXKILTZKdiIR3csSB4u0AeBWNM88DmKtQcZ7jhbYK2OKQgt821L5
 /l8iVdqr1D//I+yVESbqB+IkHjwNnFf/V1M1+cEcmqy3nXCi+gBB3WsQmtRFLFrT4hR6LlfOVdq
 bX07ZmyJ2C5bOHLxVGT0h18BwWuadInHPn5GMZTbGIJWZZD4F1NXL1pKLedNYI0CZ6OPY0jWhkJ
 LMixPvzNoJmcKVU7CvF4LaS/gB6bS/tLjzfMXB8txUagikIM1UCV7yljg/PHgwvPjjab0fbnse/
 MaLMIBQKxV/I4jo1Fw3TXHoAe47xRcRdhZTBH4uF82sIcjR8+SvWopvGHqofM4jNPFl+y4rdM50
 GsNWosCsH8zxq81EjyJ/4Jmu66qr6OaAfKr5SjU+njlXMvGKf6SN9xANEloHTEmutBWemGbNaGa
 cgcizL05yKbq+LFCI4j
X-Received: by 2002:a05:651c:2209:b0:39a:fc4b:ac15 with SMTP id
 38308e7fff4ca-39afc4bc89amr11668601fa.26.1782722831785; 
 Mon, 29 Jun 2026 01:47:11 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:47:10 -0700 (PDT)
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
Subject: [PATCH v4 40/64] usb: dwc3: import from kernel v5.16
Date: Mon, 29 Jun 2026 10:44:16 +0200
Message-ID: <20260629084507.3254232-41-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.15 to v5.16.

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

List of commits: git log --oneline v5.15..v5.16
Commits imported:
6a97cee39d8f Revert "usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default"
47ce45906ca9 usb: dwc3: leave default DMA for PCI devices
26288448120b usb: dwc3: gadget: Fix null pointer exception
63c4c320ccf7 usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer
d74dc3e9f58c usb: dwc3: gadget: Ignore NoStream after End Transfer
250fdabec6ff usb: dwc3: core: Revise GHWPARAMS9 offset
d1a4683747fe usb: dwc3: Align DWC3_EP_* flag macros
876a75cb520f usb: dwc3: gadget: Skip resizing EP's TX FIFO if already resized
b851f7c7b8fd usb: dwc3: gadget: Change to dev_dbg() when queuing to inactive gadget/ep
620b74d01b9d Merge 5.15-rc5 into usb-next
2abc865706c9 usb: exynos: describe driver in KConfig
ae9a6149884e Merge 5.15-rc3 into usb-next
8217f07a5023 usb: dwc3: gadget: Avoid starting DWC3 gadget during UDC unbind
7bee31883889 usb: dwc3: reference clock period configuration

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.c   | 37 ++++++++++++++++++++++++---
 drivers/usb/dwc3/core.h   | 27 +++++++++++++-------
 drivers/usb/dwc3/gadget.c | 53 ++++++++++++++++++++++++++++-----------
 3 files changed, 90 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0104a80b185e..f4c09951b517 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -26,6 +26,7 @@
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
+#include <linux/bitfield.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -335,6 +336,29 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 	}
 }
 
+/**
+ * dwc3_ref_clk_period - Reference clock period configuration
+ *		Default reference clock period depends on hardware
+ *		configuration. For systems with reference clock that differs
+ *		from the default, this will set clock period in DWC3_GUCTL
+ *		register.
+ * @dwc: Pointer to our controller context structure
+ * @ref_clk_per: reference clock period in ns
+ */
+static void dwc3_ref_clk_period(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	if (dwc->ref_clk_per == 0)
+		return;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
+	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, dwc->ref_clk_per);
+	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+}
+
+
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
@@ -1007,6 +1031,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc);
 
+	/* Adjust Reference Clock Period */
+	dwc3_ref_clk_period(dwc);
+
 	dwc3_set_incr_burst_type(dwc);
 
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
@@ -1389,6 +1416,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				    &dwc->hsphy_interface);
 	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
 				 &dwc->fladj);
+	device_property_read_u32(dev, "snps,ref-clock-period-ns",
+				 &dwc->ref_clk_per);
 
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
@@ -1565,9 +1594,11 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
-	if (ret)
-		return ret;
+	if (!dwc->sysdev_is_parent) {
+		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+		if (ret)
+			return ret;
+	}
 
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5612bfdf37da..5c491d0a19d7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -143,7 +143,7 @@
 #define DWC3_GHWPARAMS8		0xc600
 #define DWC3_GUCTL3		0xc60c
 #define DWC3_GFLADJ		0xc630
-#define DWC3_GHWPARAMS9		0xc680
+#define DWC3_GHWPARAMS9		0xc6e0
 
 /* Device Registers */
 #define DWC3_DCFG		0xc700
@@ -387,6 +387,10 @@
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 
+/* Global User Control Register*/
+#define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
+#define DWC3_GUCTL_REFCLKPER_SEL		22
+
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
@@ -711,21 +715,22 @@ struct dwc3_ep {
 
 	u32			saved_state;
 	unsigned int		flags;
-#define DWC3_EP_ENABLED		BIT(0)
-#define DWC3_EP_STALL		BIT(1)
-#define DWC3_EP_WEDGE		BIT(2)
-#define DWC3_EP_TRANSFER_STARTED BIT(3)
-#define DWC3_EP_END_TRANSFER_PENDING BIT(4)
-#define DWC3_EP_PENDING_REQUEST	BIT(5)
-#define DWC3_EP_DELAY_START	BIT(6)
+#define DWC3_EP_ENABLED			BIT(0)
+#define DWC3_EP_STALL			BIT(1)
+#define DWC3_EP_WEDGE			BIT(2)
+#define DWC3_EP_TRANSFER_STARTED	BIT(3)
+#define DWC3_EP_END_TRANSFER_PENDING	BIT(4)
+#define DWC3_EP_PENDING_REQUEST		BIT(5)
+#define DWC3_EP_DELAY_START		BIT(6)
 #define DWC3_EP_WAIT_TRANSFER_COMPLETE	BIT(7)
 #define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
 #define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
 #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
+#define DWC3_EP_TXFIFO_RESIZED		BIT(12)
 
 	/* This last one is specific to EP0 */
-#define DWC3_EP0_DIR_IN		BIT(31)
+#define DWC3_EP0_DIR_IN			BIT(31)
 
 	/*
 	 * IMPORTANT: we *know* we have 256 TRBs in our @trb_pool, so we will
@@ -970,6 +975,7 @@ struct dwc3_scratchpad_array {
  * @regs: base address for our registers
  * @regs_size: address space size
  * @fladj: frame length adjustment
+ * @ref_clk_per: reference clock period configuration
  * @irq_gadget: peripheral controller's IRQ number
  * @otg_irq: IRQ number for OTG IRQs
  * @current_otg_role: current role of operation while using the OTG block
@@ -1027,6 +1033,7 @@ struct dwc3_scratchpad_array {
  * @tx_fifo_resize_max_num: max number of fifos allocated during txfifo resize
  * @hsphy_interface: "utmi" or "ulpi"
  * @connected: true when we're connected to a host, false otherwise
+ * @softconnect: true when gadget connect is called, false when disconnect runs
  * @delayed_status: true when gadget driver asks for delayed status
  * @ep0_bounced: true when we used bounce buffer
  * @ep0_expect_in: true when we expect a DATA IN transfer
@@ -1149,6 +1156,7 @@ struct dwc3 {
 	struct power_supply	*usb_psy;
 
 	u32			fladj;
+	u32			ref_clk_per;
 	u32			irq_gadget;
 	u32			otg_irq;
 	u32			current_otg_role;
@@ -1246,6 +1254,7 @@ struct dwc3 {
 	const char		*hsphy_interface;
 
 	unsigned		connected:1;
+	unsigned		softconnect:1;
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4519d06c9ca2..7e3db00e9759 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -310,13 +310,24 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
 		int link_state;
 
+		/*
+		 * Initiate remote wakeup if the link state is in U3 when
+		 * operating in SS/SSP or L1/L2 when operating in HS/FS. If the
+		 * link state is in U1/U2, no remote wakeup is needed. The Start
+		 * Transfer command will initiate the link recovery.
+		 */
 		link_state = dwc3_gadget_get_link_state(dwc);
-		if (link_state == DWC3_LINK_STATE_U1 ||
-		    link_state == DWC3_LINK_STATE_U2 ||
-		    link_state == DWC3_LINK_STATE_U3) {
+		switch (link_state) {
+		case DWC3_LINK_STATE_U2:
+			if (dwc->gadget->speed >= USB_SPEED_SUPER)
+				break;
+
+			fallthrough;
+		case DWC3_LINK_STATE_U3:
 			ret = __dwc3_gadget_wakeup(dwc);
 			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
 					ret);
+			break;
 		}
 	}
 
@@ -702,6 +713,7 @@ void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
 				   DWC31_GTXFIFOSIZ_TXFRAMNUM;
 
 		dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1), size);
+		dep->flags &= ~DWC3_EP_TXFIFO_RESIZED;
 	}
 	dwc->num_ep_resized = 0;
 }
@@ -747,6 +759,10 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	if (!usb_endpoint_dir_in(dep->endpoint.desc) || dep->number <= 1)
 		return 0;
 
+	/* bail if already resized */
+	if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
+		return 0;
+
 	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
 
 	if ((dep->endpoint.maxburst > 1 &&
@@ -807,6 +823,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	}
 
 	dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1), fifo_size);
+	dep->flags |= DWC3_EP_TXFIFO_RESIZED;
 	dwc->num_ep_resized++;
 
 	return 0;
@@ -995,7 +1012,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	dep->stream_capable = false;
 	dep->type = 0;
-	dep->flags = 0;
+	dep->flags &= DWC3_EP_TXFIFO_RESIZED;
 
 	return 0;
 }
@@ -1813,7 +1830,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	struct dwc3		*dwc = dep->dwc;
 
 	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
-		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
+		dev_dbg(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		return -ESHUTDOWN;
 	}
@@ -2418,7 +2435,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	int			ret;
 
 	is_on = !!is_on;
-
+	dwc->softconnect = is_on;
 	/*
 	 * Per databook, when we want to stop the gadget, if a control transfer
 	 * is still in process, complete it and get the core into setup phase.
@@ -3246,6 +3263,9 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	struct dwc3		*dwc = dep->dwc;
 	bool			no_started_trb = true;
 
+	if (!dep->endpoint.desc)
+		return no_started_trb;
+
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
@@ -3293,6 +3313,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 {
 	int status = 0;
 
+	if (!dep->endpoint.desc)
+		return;
+
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 		dwc3_gadget_endpoint_frame_from_event(dep, event);
 
@@ -3346,6 +3369,14 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 	if (cmd != DWC3_DEPCMD_ENDTRANSFER)
 		return;
 
+	/*
+	 * The END_TRANSFER command will cause the controller to generate a
+	 * NoStream Event, and it's not due to the host DP NoStream rejection.
+	 * Ignore the next NoStream event.
+	 */
+	if (dep->stream_capable)
+		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
+
 	dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	dwc3_gadget_ep_cleanup_cancelled_requests(dep);
@@ -3568,14 +3599,6 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	/*
-	 * The END_TRANSFER command will cause the controller to generate a
-	 * NoStream Event, and it's not due to the host DP NoStream rejection.
-	 * Ignore the next NoStream event.
-	 */
-	if (dep->stream_capable)
-		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
-
 	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	else
@@ -4352,7 +4375,7 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 {
 	int			ret;
 
-	if (!dwc->gadget_driver)
+	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
 	ret = __dwc3_gadget_start(dwc);
-- 
2.43.0

