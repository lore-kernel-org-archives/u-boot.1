Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F6CD3445
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB8184B01;
	Thu,  7 May 2026 11:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GhJsY/Yl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D02284B01; Thu,  7 May 2026 11:30:47 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCFF084A81
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5a283c44478so820517e87.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146241; x=1778751041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/RxlEWj2zOgHDHbzOiBainZeZ+vSDj6cwk4KyZ6lgY=;
 b=GhJsY/Yl59OUo0p1RXp6MrsxjDgmlysylgnxVpX13GQMkGCOcfqAfnbOnSbAxXVc3r
 M43t+8HGGQqDIXwlEcd2FL5m+o3urRT9tXAJgZlMe8XOeB4gO23xv01dB7yZUPiUt2UJ
 PWjfAjxOis2BP2P+Os7+X32/nDFO37USzWlUWfd0K45F9wC42wXcCPitGVDWOA6HC0Ff
 iNxS+sH636Mosh2ZE3xS388t8Rp4kxHQbaqekxg0LGKEb9w7Z/N+O2mgWORdBKj0Dm4F
 6T5JfFBdlRRwrg2dyerwoZk2ZpQUi20lM8EE8eg9qALdjWGnv2VNNYTL5CY0rH4CJBGQ
 F85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146241; x=1778751041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U/RxlEWj2zOgHDHbzOiBainZeZ+vSDj6cwk4KyZ6lgY=;
 b=Sk6vTSPhf+aZftbmQ/QBuLbafU3lh8XPGIMbVF68+TGkJzRN5ZJP+LE5gxwmtlNWtt
 8HGOG5wZMPyU4ioRhetFUcu+7m/gGXjSGCytyfzn4+Psi0m+2qNOVD8JBAV8r3ymzSXh
 MPN0WIpix8CgvmbDybLquMqtbp7YhPgHbFgBu38VjqOAXhFNPX15rskKfNBR1+0ovdte
 nSfZdsJrqbUX6WXVBH5+EEULvmpj+DpvlojSuO++CNU+9weIzBuPqK9iJAY83uNkaNW0
 kBGxp6zrG012jyGiaVBXfHprpF8fi33NJ3TFEb3c1skcSzMET8ipd2QFwzwaptdXJuEo
 8y4Q==
X-Gm-Message-State: AOJu0YzHOgrus9sRfnxtQ7DdAsvegYYXk/MEw9h+/SmqRHkjQb7GYRg5
 H3uw0OtcC2FRLZb2ytZXf+/rClGP6vaRtC+gbSopA87NB95trWayihqd/p7rCi6Xn+xdp+nnauD
 sUrjT77sSJw==
X-Gm-Gg: AeBDieuuL8VPKtR0vCtJQhqVn++7Fg7pixSqCBFU546yE/mCaK3/aWJGO+apq7aQ/0i
 ITWhnfpHaxGU/9vv0QwumearBDYlw7cPrQsyRnQGVy7szIQZSbVNJzhtoDrWnsUI4OiSmSWa92k
 Yg30ljUOu5LhN75R+SEG+AongFG4SjFXUNeyFx6ROc02J2HVseszdTDAN5r9iNugZgN59zGVuM2
 8Hhogq7FR7JwP7gpmOLEoO3C3ZqJ9Neo3I5Ax5H7g4E6oXz719AHgE3RO+cJ+H8AiPfwamOqYRM
 LBkQRNnoHbDYrhEHvRl/sXsS3aAczVAHQnbQE9IgHkcP/3DOM2e/Jc1Xgz7g1sC61pyg5zy55i7
 NmL+1e6PGeRw2k36/5+JI+FGSfRYyE0iuQKfKnqXB1GZ61aiavhDoUq9WXHT106Hj5t+IEIvBdb
 w0aNinswQdm0/B0dqGkXVp8yzcO3Yo68vX9YxR1+U9zawb/+ty00kQzOU0uL64r0erxnF1aHxT+
 jjlwM9F3r6MMY/Q1MxCzvSbBhNEKuWHj5co5KrOBQ==
X-Received: by 2002:a05:6512:3a8e:b0:5a4:301:b92 with SMTP id
 2adb3069b0e04-5a887ce64d7mr2386766e87.33.1778146241071; 
 Thu, 07 May 2026 02:30:41 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:30:40 -0700 (PDT)
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
Subject: [RFC PATCH v2 39/64] usb: dwc3: import from kernel v5.15
Date: Thu,  7 May 2026 11:27:46 +0200
Message-ID: <20260507092843.358908-40-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.14 to v5.15.

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

List of commits: git log --oneline v5.14..v5.15
Commits imported:
268bbde716e3 usb: dwc3: gadget: Revert "set gadgets parent to the right controller"
8cfac9a6744f usb: dwc3: core: balance phy init and exit
07281a257a68 Merge tag 'usb-5.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
1abade64563e usb: dwc3: pci: add support for AMD's newer generation platform.
6a48d0ae01a6 usb: dwc3: imx8mp: request irq after initializing dwc3
843714bb37d9 usb: dwc3: Decouple USB 2.0 L1 & L2 events
2dec48c32a34 Merge 5.14-rc6 into usb-next
175006956740 usb: dwc3: qcom: add IRQ check
baa2986bda3f usb: dwc3: meson-g12a: add IRQ check
73e19de7b79a Merge 5.14-rc5 into usb-next
0132bf6f3958 drivers: usb: dwc3-qcom: Add sdm660 compatible
c6e23b89a95d usb: dwc3: gadget: set gadgets parent to the right controller
26f94fe8e739 usb: dwc3: drd: use helper to get role-switch-default-mode
d842bc6c0579 Merge v5.14-rc3 into usb-next
8e6cb5d27e82 usb: dwc3: dwc3-qcom: Fix typo in the dwc3 vbus override API
cefdd52fa045 usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default
9f607a309fbe usb: dwc3: Resize TX FIFOs to meet EP bursting requirements

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   |  54 ++++++---
 drivers/usb/dwc3/core.h   |  21 +++-
 drivers/usb/dwc3/ep0.c    |   2 +
 drivers/usb/dwc3/gadget.c | 232 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ba74ad7f6995..0104a80b185e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -264,19 +264,6 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
 	int		retries = 1000;
-	int		ret;
-
-	usb_phy_init(dwc->usb2_phy);
-	usb_phy_init(dwc->usb3_phy);
-	ret = phy_init(dwc->usb2_generic_phy);
-	if (ret < 0)
-		return ret;
-
-	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0) {
-		phy_exit(dwc->usb2_generic_phy);
-		return ret;
-	}
 
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
@@ -310,9 +297,6 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 			udelay(1);
 	} while (--retries);
 
-	phy_exit(dwc->usb3_generic_phy);
-	phy_exit(dwc->usb2_generic_phy);
-
 	return -ETIMEDOUT;
 
 done:
@@ -982,9 +966,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->phys_ready = true;
 	}
 
+	usb_phy_init(dwc->usb2_phy);
+	usb_phy_init(dwc->usb3_phy);
+	ret = phy_init(dwc->usb2_generic_phy);
+	if (ret < 0)
+		goto err0a;
+
+	ret = phy_init(dwc->usb3_generic_phy);
+	if (ret < 0) {
+		phy_exit(dwc->usb2_generic_phy);
+		goto err0a;
+	}
+
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
-		goto err0a;
+		goto err1;
 
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
 	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
@@ -1050,6 +1046,15 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (!DWC3_VER_IS_PRIOR(DWC3, 290A))
 			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
 
+		/*
+		 * Decouple USB 2.0 L1 & L2 events which will allow for
+		 * gadget driver to only receive U3/L2 suspend & wakeup
+		 * events and prevent the more frequent L1 LPM transitions
+		 * from interrupting the driver.
+		 */
+		if (!DWC3_VER_IS_PRIOR(DWC3, 300A))
+			reg |= DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT;
+
 		if (dwc->dis_tx_ipgap_linecheck_quirk)
 			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
 
@@ -1267,6 +1272,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			rx_max_burst_prd;
 	u8			tx_thr_num_pkt_prd;
 	u8			tx_max_burst_prd;
+	u8			tx_fifo_resize_max_num;
 	const char		*usb_psy_name;
 	int			ret;
 
@@ -1282,6 +1288,13 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	 */
 	hird_threshold = 12;
 
+	/*
+	 * default to a TXFIFO size large enough to fit 6 max packets.  This
+	 * allows for systems with larger bus latencies to have some headroom
+	 * for endpoints that have a large bMaxBurst value.
+	 */
+	tx_fifo_resize_max_num = 6;
+
 	dwc->maximum_speed = usb_get_maximum_speed(dev);
 	dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
 	dwc->dr_mode = usb_get_dr_mode(dev);
@@ -1325,6 +1338,11 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				&tx_thr_num_pkt_prd);
 	device_property_read_u8(dev, "snps,tx-max-burst-prd",
 				&tx_max_burst_prd);
+	dwc->do_fifo_resize = device_property_read_bool(dev,
+							"tx-fifo-resize");
+	if (dwc->do_fifo_resize)
+		device_property_read_u8(dev, "tx-fifo-max-num",
+					&tx_fifo_resize_max_num);
 
 	dwc->disable_scramble_quirk = device_property_read_bool(dev,
 				"snps,disable_scramble_quirk");
@@ -1390,6 +1408,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->tx_max_burst_prd = tx_max_burst_prd;
 
 	dwc->imod_interval = 0;
+
+	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
 }
 
 /* check whether the core supports IMOD */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5991766239ba..5612bfdf37da 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -256,9 +256,10 @@
 #define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
 
 /* Global User Control 1 Register */
-#define DWC3_GUCTL1_PARKMODE_DISABLE_SS	BIT(17)
+#define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
-#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
+#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
+#define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
 
 /* Global Status Register */
 #define DWC3_GSTS_OTG_IP	BIT(10)
@@ -1023,6 +1024,7 @@ struct dwc3_scratchpad_array {
  * @rx_max_burst_prd: max periodic ESS receive burst size
  * @tx_thr_num_pkt_prd: periodic ESS transmit packet count
  * @tx_max_burst_prd: max periodic ESS transmit burst size
+ * @tx_fifo_resize_max_num: max number of fifos allocated during txfifo resize
  * @hsphy_interface: "utmi" or "ulpi"
  * @connected: true when we're connected to a host, false otherwise
  * @delayed_status: true when gadget driver asks for delayed status
@@ -1037,6 +1039,7 @@ struct dwc3_scratchpad_array {
  *	1	- utmi_l1_suspend_n
  * @is_fpga: true when we are using the FPGA board
  * @pending_events: true when we have pending IRQs to be handled
+ * @do_fifo_resize: true when txfifo resizing is enabled for dwc3 endpoints
  * @pullups_connected: true when Run/Stop bit is set
  * @setup_packet_pending: true when there's a Setup Packet in FIFO. Workaround
  * @three_stage_setup: set if we perform a three phase setup
@@ -1079,6 +1082,11 @@ struct dwc3_scratchpad_array {
  * @dis_split_quirk: set to disable split boundary.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
+ * @max_cfg_eps: current max number of IN eps used across all USB configs.
+ * @last_fifo_depth: last fifo depth used to determine next fifo ram start
+ *		     address.
+ * @num_ep_resized: carries the current number endpoints which have had its tx
+ *		    fifo resized.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1233,6 +1241,7 @@ struct dwc3 {
 	u8			rx_max_burst_prd;
 	u8			tx_thr_num_pkt_prd;
 	u8			tx_max_burst_prd;
+	u8			tx_fifo_resize_max_num;
 
 	const char		*hsphy_interface;
 
@@ -1246,6 +1255,7 @@ struct dwc3 {
 	unsigned		is_utmi_l1_suspend:1;
 	unsigned		is_fpga:1;
 	unsigned		pending_events:1;
+	unsigned		do_fifo_resize:1;
 	unsigned		pullups_connected:1;
 	unsigned		setup_packet_pending:1;
 	unsigned		three_stage_setup:1;
@@ -1282,6 +1292,10 @@ struct dwc3 {
 	unsigned		async_callbacks:1;
 
 	u16			imod_interval;
+
+	int			max_cfg_eps;
+	int			last_fifo_depth;
+	int			num_ep_resized;
 };
 
 #define INCRX_BURST_MODE 0
@@ -1513,6 +1527,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params);
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		u32 param);
+void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
@@ -1532,6 +1547,8 @@ static inline int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 		int cmd, u32 param)
 { return 0; }
+static inline void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
+{ }
 #endif
 
 #if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 2f9e45eed228..658739410992 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -621,6 +621,8 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 		return -EINVAL;
 
 	case USB_STATE_ADDRESS:
+		dwc3_gadget_clear_tx_fifos(dwc);
+
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		/* if the cfg matches and the cfg is non zero */
 		if (cfg && (!ret || (ret == USB_GADGET_DELAYED_STATUS))) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ccb68fe6202e..4519d06c9ca2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -631,6 +631,187 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 		bool interrupt);
 
+/**
+ * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
+ * @dwc: pointer to the DWC3 context
+ * @nfifos: number of fifos to calculate for
+ *
+ * Calculates the size value based on the equation below:
+ *
+ * DWC3 revision 280A and prior:
+ * fifo_size = mult * (max_packet / mdwidth) + 1;
+ *
+ * DWC3 revision 290A and onwards:
+ * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
+ *
+ * The max packet size is set to 1024, as the txfifo requirements mainly apply
+ * to super speed USB use cases.  However, it is safe to overestimate the fifo
+ * allocations for other scenarios, i.e. high speed USB.
+ */
+static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
+{
+	int max_packet = 1024;
+	int fifo_size;
+	int mdwidth;
+
+	mdwidth = dwc3_mdwidth(dwc);
+
+	/* MDWIDTH is represented in bits, we need it in bytes */
+	mdwidth >>= 3;
+
+	if (DWC3_VER_IS_PRIOR(DWC3, 290A))
+		fifo_size = mult * (max_packet / mdwidth) + 1;
+	else
+		fifo_size = mult * ((max_packet + mdwidth) / mdwidth) + 1;
+	return fifo_size;
+}
+
+/**
+ * dwc3_gadget_clear_tx_fifo_size - Clears txfifo allocation
+ * @dwc: pointer to the DWC3 context
+ *
+ * Iterates through all the endpoint registers and clears the previous txfifo
+ * allocations.
+ */
+void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
+{
+	struct dwc3_ep *dep;
+	int fifo_depth;
+	int size;
+	int num;
+
+	if (!dwc->do_fifo_resize)
+		return;
+
+	/* Read ep0IN related TXFIFO size */
+	dep = dwc->eps[1];
+	size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+	if (DWC3_IP_IS(DWC3))
+		fifo_depth = DWC3_GTXFIFOSIZ_TXFDEP(size);
+	else
+		fifo_depth = DWC31_GTXFIFOSIZ_TXFDEP(size);
+
+	dwc->last_fifo_depth = fifo_depth;
+	/* Clear existing TXFIFO for all IN eps except ep0 */
+	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM);
+	     num += 2) {
+		dep = dwc->eps[num];
+		/* Don't change TXFRAMNUM on usb31 version */
+		size = DWC3_IP_IS(DWC3) ? 0 :
+			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
+				   DWC31_GTXFIFOSIZ_TXFRAMNUM;
+
+		dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1), size);
+	}
+	dwc->num_ep_resized = 0;
+}
+
+/*
+ * dwc3_gadget_resize_tx_fifos - reallocate fifo spaces for current use-case
+ * @dwc: pointer to our context structure
+ *
+ * This function will a best effort FIFO allocation in order
+ * to improve FIFO usage and throughput, while still allowing
+ * us to enable as many endpoints as possible.
+ *
+ * Keep in mind that this operation will be highly dependent
+ * on the configured size for RAM1 - which contains TxFifo -,
+ * the amount of endpoints enabled on coreConsultant tool, and
+ * the width of the Master Bus.
+ *
+ * In general, FIFO depths are represented with the following equation:
+ *
+ * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
+ *
+ * In conjunction with dwc3_gadget_check_config(), this resizing logic will
+ * ensure that all endpoints will have enough internal memory for one max
+ * packet per endpoint.
+ */
+static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
+	int fifo_0_start;
+	int ram1_depth;
+	int fifo_size;
+	int min_depth;
+	int num_in_ep;
+	int remaining;
+	int num_fifos = 1;
+	int fifo;
+	int tmp;
+
+	if (!dwc->do_fifo_resize)
+		return 0;
+
+	/* resize IN endpoints except ep0 */
+	if (!usb_endpoint_dir_in(dep->endpoint.desc) || dep->number <= 1)
+		return 0;
+
+	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+
+	if ((dep->endpoint.maxburst > 1 &&
+	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
+	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		num_fifos = 3;
+
+	if (dep->endpoint.maxburst > 6 &&
+	    usb_endpoint_xfer_bulk(dep->endpoint.desc) && DWC3_IP_IS(DWC31))
+		num_fifos = dwc->tx_fifo_resize_max_num;
+
+	/* FIFO size for a single buffer */
+	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
+
+	/* Calculate the number of remaining EPs w/o any FIFO */
+	num_in_ep = dwc->max_cfg_eps;
+	num_in_ep -= dwc->num_ep_resized;
+
+	/* Reserve at least one FIFO for the number of IN EPs */
+	min_depth = num_in_ep * (fifo + 1);
+	remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
+	remaining = max_t(int, 0, remaining);
+	/*
+	 * We've already reserved 1 FIFO per EP, so check what we can fit in
+	 * addition to it.  If there is not enough remaining space, allocate
+	 * all the remaining space to the EP.
+	 */
+	fifo_size = (num_fifos - 1) * fifo;
+	if (remaining < fifo_size)
+		fifo_size = remaining;
+
+	fifo_size += fifo;
+	/* Last increment according to the TX FIFO size equation */
+	fifo_size++;
+
+	/* Check if TXFIFOs start at non-zero addr */
+	tmp = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+	fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(tmp);
+
+	fifo_size |= (fifo_0_start + (dwc->last_fifo_depth << 16));
+	if (DWC3_IP_IS(DWC3))
+		dwc->last_fifo_depth += DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
+	else
+		dwc->last_fifo_depth += DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
+
+	/* Check fifo size allocation doesn't exceed available RAM size. */
+	if (dwc->last_fifo_depth >= ram1_depth) {
+		dev_err(dwc->dev, "Fifosize(%d) > RAM size(%d) %s depth:%d\n",
+			dwc->last_fifo_depth, ram1_depth,
+			dep->endpoint.name, fifo_size);
+		if (DWC3_IP_IS(DWC3))
+			fifo_size = DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
+		else
+			fifo_size = DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
+
+		dwc->last_fifo_depth -= fifo_size;
+		return -ENOMEM;
+	}
+
+	dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1), fifo_size);
+	dwc->num_ep_resized++;
+
+	return 0;
+}
+
 /**
  * __dwc3_gadget_ep_enable - initializes a hw endpoint
  * @dep: endpoint to be initialized
@@ -648,6 +829,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	int			ret;
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
+		ret = dwc3_gadget_resize_tx_fifos(dep);
+		if (ret)
+			return ret;
+
 		ret = dwc3_gadget_start_config(dep);
 		if (ret)
 			return ret;
@@ -2508,6 +2693,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= NULL;
+	dwc->max_cfg_eps = 0;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	free_irq(dwc->irq_gadget, dwc->ev_buf);
@@ -2595,6 +2781,51 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 	return ret;
 }
 
+/**
+ * dwc3_gadget_check_config - ensure dwc3 can support the USB configuration
+ * @g: pointer to the USB gadget
+ *
+ * Used to record the maximum number of endpoints being used in a USB composite
+ * device. (across all configurations)  This is to be used in the calculation
+ * of the TXFIFO sizes when resizing internal memory for individual endpoints.
+ * It will help ensured that the resizing logic reserves enough space for at
+ * least one max packet.
+ */
+static int dwc3_gadget_check_config(struct usb_gadget *g)
+{
+	struct dwc3 *dwc = gadget_to_dwc(g);
+	struct usb_ep *ep;
+	int fifo_size = 0;
+	int ram1_depth;
+	int ep_num = 0;
+
+	if (!dwc->do_fifo_resize)
+		return 0;
+
+	list_for_each_entry(ep, &g->ep_list, ep_list) {
+		/* Only interested in the IN endpoints */
+		if (ep->claimed && (ep->address & USB_DIR_IN))
+			ep_num++;
+	}
+
+	if (ep_num <= dwc->max_cfg_eps)
+		return 0;
+
+	/* Update the max number of eps in the composition */
+	dwc->max_cfg_eps = ep_num;
+
+	fifo_size = dwc3_gadget_calc_tx_fifo_size(dwc, dwc->max_cfg_eps);
+	/* Based on the equation, increment by one for every ep */
+	fifo_size += dwc->max_cfg_eps;
+
+	/* Check if we can fit a single fifo per endpoint */
+	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+	if (fifo_size > ram1_depth)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -2616,6 +2847,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_set_ssp_rate	= dwc3_gadget_set_ssp_rate,
 	.get_config_params	= dwc3_gadget_config_params,
 	.vbus_draw		= dwc3_gadget_vbus_draw,
+	.check_config		= dwc3_gadget_check_config,
 	.udc_async_callbacks	= dwc3_gadget_async_callbacks,
 };
 
-- 
2.43.0

