Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8AEC5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ECF440C89;
	Fri, 21 Aug 2026 13:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EliAwaMtYsOF; Fri, 21 Aug 2026 13:13:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318014;
	bh=DVzKi6aMWqLuHZ3eJsv9V0Jj2utiO5NTM8DRjoAD4Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=clxzqrqMXNqo23VmU4aK1O4+h0DlHps8dlKJqDpv4Y3rahVXp9+HFgfOqz32/Ktcm
	 Td4F0E2VYoWE8Dt6kXALSe8/pgmjKljDAKrdIFNt4vRqHKL8+z/w5ScPvEbaHxr/uG
	 MSoPoxqUCurMUJXyqBBLiQIN54P6q9Cqbb3PvuSsxNXXEWWx3yMe49IgvX1GykOdGz
	 t5Q3x6QvlBHzAM1TiS94wt3U++m8DdZtt0M5EL9tIe5fyFtVwaY7m1iYj70wBQ/yfV
	 Qv+sHoQZadlsBeOrrBhqkVE1p7RtW+itrkQMvSVXzlzEPdF1Wk43pGBQVSqcJnPc5V
	 p73zpAovUPCYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3474D40C1E;
	Fri, 21 Aug 2026 13:13:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D6D0263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 839EE80FF9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jSE6f8UnrAQ1 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Lcp6U/mj
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 327D381005
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:50 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a18b91fb1fso166293a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302309; x=1787907109;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DVzKi6aMWqLuHZ3eJsv9V0Jj2utiO5NTM8DRjoAD4Ps=;
 b=Lcp6U/mjlqlI7F/pOnywlbJ8NkwEIMFzNxcD0fzrTEgN3AKKQUm8gnQMQCNSEnroV4
 VcYOutvFacBJMrhUV9hcOFARJmlWlNu6rA5IQ33SDTFSvAugd/jyisok1ezT3L5oOVhV
 M0sXg2EWWxNAGYdOCIkQ+wWis54ajtEYDacZbL6lFSzn07WvdV/wDy4h4ruET1DkNomU
 C/GSC0UCUQvzDWTbxwi1DLGvcnlzBB1edeXML5WZirtcT02JyvgCY0XQPLT6J2Cai4gY
 Fx5gzN9NMMJ+uit21u1bxCFU3q22unGXxYYJvObH44FSiaO713jGUZ6+JeQ4bRJ4H0gN
 3aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302309; x=1787907109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DVzKi6aMWqLuHZ3eJsv9V0Jj2utiO5NTM8DRjoAD4Ps=;
 b=M2STKXUdKlDnzuuuTgjfJq/l7UmfCss+2ZQWsjbQcdfYP4+vYgOsXct9ELaXOY12O2
 WDdDf0i9L9ixmaE20XBQtBGwgzGc5FAKt1P39XbhWjJp94yaRmPsURDWZjVo9vr5FXPv
 PsXerYUfX5auOMOiWAdfd9MyNn2XtOEqfVaVzqZcFBfivkNDbIohsX9enFUn2ap3jGDs
 xzCLqlE6kJ1OMkieogh64DlsqoZHuWwtjbWjZvd578avse64hJ5FJldFCFq7v5pqUPFG
 41DJqO+foMn2uW7YqjpnEDq3Cmcx+zvjcT690jSWtvKXYOmBqq6l4/eYyNZg5Z4LjSkk
 GOHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRDQ1AXIfj5dk34NU8/vtmf1n6UGjKrfFVrfnZPA+7TrS8pOHgEgnAP67YXzcKmiiEGwfF8rk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kRtKkN2DLBLRqHZJOyUBaDBf2anaK3XGQqy+LafD6yV+HcOI6U
 dD02Re2eHK/Xw6tPWkEPrR5R3BGNWbW/6LT+6vS5lncnH3ef3q9PcU+X2SNR7sQ1PPw=
X-Gm-Gg: AR+sD126Jf44sz8EAYrg0xjsnYMxmvEKInsPX+tDlwP5nsRArsT7g/CbQUdcaYCb4c6
 l5IlMLNXT6HRKpMKDWNPCO3S16CcQprXkm7qmU+oymnl56wV7UGXveN3UPgrP6Th+a1nxgkRrnl
 wn7VBvZI773TNmDISp0w31rYQvdpQodw+oDscruWi2o+rKa6UHsB1faX9pHt/apMwGLuQJzaQ6z
 m6bo0ynQD9PaAc1FmCHknhsNGJStyXGA9eNZYdVQvak+qCgvJtxW187iaql1nNiXC4sUdvCLFqI
 5lXby6pzVDU///dH+NFS3D2hPnsiWFiDUdIxRTqD/sBLI+8bB4b23+egYZPJm5s1SvdGw+TiyI6
 5B+rmZmcccalkFsqGI4EbX/zzHnxgPNuW6vQVtUfqIx7Hj8bt6bsI2DaBxqrYkydPKsil0Q27by
 TbIKFMYPu7ZmEaPkuYjLkvNwfkr+KpgWnzpTinuR853qF4K/JP/D+iH7yVlMzIqY3TlFRhiEXII
 mQA9nAb50S6B5jJjyhv1bFY
X-Received: by 2002:a05:6402:1ed0:b0:6a0:cbef:884c with SMTP id
 4fb4d7f45d1cf-6a42ee56d00mr2622187a12.0.1787302308859; 
 Fri, 21 Aug 2026 01:51:48 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff177859sm5238261a12.27.2026.08.21.01.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:48 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 41/87] usb: dwc3: import from kernel v5.16
Date: Fri, 21 Aug 2026 10:47:17 +0200
Message-ID: <20260821084829.2070426-42-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

Sync Linux kernel dwc3 changes from v5.15 to v5.16.

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

List of commits: git log --oneline v5.15..v5.16
Commits imported:
47ce45906ca9 usb: dwc3: leave default DMA for PCI devices
26288448120b usb: dwc3: gadget: Fix null pointer exception
63c4c320ccf7 usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer
d74dc3e9f58c usb: dwc3: gadget: Ignore NoStream after End Transfer
250fdabec6ff usb: dwc3: core: Revise GHWPARAMS9 offset
d1a4683747fe usb: dwc3: Align DWC3_EP_* flag macros
876a75cb520f usb: dwc3: gadget: Skip resizing EP's TX FIFO if already resized
b851f7c7b8fd usb: dwc3: gadget: Change to dev_dbg() when queuing to inactive gadget/ep
8217f07a5023 usb: dwc3: gadget: Avoid starting DWC3 gadget during UDC unbind
7bee31883889 usb: dwc3: reference clock period configuration

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
2.53.0

