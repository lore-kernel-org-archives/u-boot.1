Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9DDC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B68B180F46;
	Mon, 24 Aug 2026 16:46:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KfvVYrUgPg2I; Mon, 24 Aug 2026 16:46:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589917;
	bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fDCzUJUwzNTsG0WtV1otWe+I1BmziKYij7ysa7fcA+SbnKOhoWKCB6Q7uDYEAnD7k
	 wL07bDYN6hpDOA9csqq/FcvAAmwyMUmCqo8fCUFkYPhX+QtIDqMkwF9zyrNnCs9MEE
	 fGMZxJwavK1q/8brpAcqLpFuxmr12YdGTRaFY/LZ0cr+i9kGf3NRi2KnKBGbzwiqTO
	 +XvifOiHM2ptYmX4XtXCTWCAUziYHBkALYaSme8+qwdGI98gW642epK2At/OcO2l+d
	 D1NrR+tqlg7GZUIs+Gn5neRto6M0t0vTKLzLF1ucJFEX5//gegVK6FA3zGGOgYh3ka
	 aINbuhbNZOt+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9300680EDD;
	Mon, 24 Aug 2026 16:45:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A66653AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CC4340068
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nmJoB6RPrV_w for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:32:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WQtEEO4t
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 93F8F40029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:06 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c20e4487bdaso29583766b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585525; x=1788190325;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
 b=WQtEEO4tpvZuUNzvMFqQwYSjHvZ/brfrPRWh1y5YGGcdqYZx1C8K3kAitC59ReQCj+
 wwhNCo5EObyYuHIPz/Xv59w/rh1M1I9KXDBB2EWvFKU64J4TMgCyuJ0FCimFiNXIuS47
 HIjdjfPRqoEa+cFnV31kYnBiwbfHfOQCfkUgTlzG1BAvAPnYzDJdIR7ebHmAGkOu/9R1
 0b26M0ANGsuyuTyDzdJFzxyhXqtzZ65zRAU2YoAdSehZloIIJTgawfNDqwgYrZYSmY8Y
 II625Ar0FHc03/mQCynWbuBYEE5bulxSkME32psu4dLNlj6rIhTnAZUw9FlW9qU7KrpS
 /sJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585525; x=1788190325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
 b=o9NxHVU2CA3WO3NNKLpqOzeaOF3iAOuzluGP3oZrIpXX+yIMEd4Ts8lMZIcSxD6ltQ
 4FJBBnFT1wV1d4pmiHEyatJ33fkIcsuQFVLdL1Sh+Vh8Vdic8/OQoqXitjzJbxWBGCiN
 xPay/5cliX7KPUXUbHxXLzVybpaU8VJv30qmO+c1H1dz/iPGY5y0YPwUyu2vDgR2ANA4
 tzKEthpefF0cHwYkngAW5Y36BBBAfHyK2RtZYvXl3zJUuXCyyFi8c6AEnuXrlp/KTc56
 lxSB6gFZar8bcGCvUVE1EjXO3UEgXxR6hB4cA4MS/SihyL11jpeoK5WC3ZE1hjRdTq/D
 oWBw==
X-Gm-Message-State: AFuF++ndsLk+FjNZG772LCG1srEF4TnYeIZWpHxHVGf+zf3NV7W0dE3t
 GpxeeoXdHJammXZTn1M1HX9Q5HVADPNYoF3PuKCJbI8JuUgUFAkF0FH6JpBXF0WM/mni2NxzJ03
 i2buw
X-Gm-Gg: AR+sD10vrggU9uvhhRXP52iDSgPieEswtK5YaZ/MDvhdW2IP8j5qWQtcQuJKlQGXtCk
 ySII82BK9LuA7QOXS0WYkTT3tkZLgo7NAFJRKOPQwmn6Wdr5q9nk2apxQvW4xrM2YV46I7zSRq/
 YL4bJE8MMBqOWjeyQUPDXWctX2e8hIrxR9nEX+zVgTT1xM95K6k6PdJHVXATKVGZQrWgY/VoTG/
 /pz9i0dbeAx9zTbpweZXM9FaKvITNaGz1t7ktuoqb2WXwc0kp82yNnklgG+dM67H/N/HwvKZpN5
 4dW+dU2E1iYSQYxfPUhYluhzXdbvtvS+Rl6Ky1c832iX3t/pjxRzBtKU49SkjiTyZMA8cRuJHzD
 02cvFS5Glox1aMRJeroaq/L1oqZhXRjRY9I4HVdVXt/8a2vk1Jxl2AS+WSPWE/uGnV46zLBa9lw
 APeahsTmWO6TmLUKFzxbihEzDF1cJS75sMvJlcHX+1f/U9aayocwPFdzBNrBNkiNT5ASCcjtVyB
 IfSkbAnD9cM3wvSKSzNfg==
X-Received: by 2002:a17:906:9c82:b0:c21:960c:ec22 with SMTP id
 a640c23a62f3a-c246a5f7cadmr1629928666b.2.1787585523616; 
 Mon, 24 Aug 2026 08:32:03 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b208sm1233541266b.10.2026.08.24.08.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:32:02 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 56/63] usb: dwc3: import from kernel v6.11
Date: Mon, 24 Aug 2026 17:27:27 +0200
Message-ID: <20260824152734.159794-57-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.10 to v6.11.

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

List of commits: git log --oneline v6.10..v6.11
Commits imported:
9149c9b0c7e0 usb: dwc3: core: update LC timer as per USB Spec V3.2
00dcf2fa449f usb: dwc3: Avoid waking up gadget during startxfer
72fca8371f20 usb: dwc3: ep0: Don't reset resource alloc flag (including ep0)
14e497183df2 usb: dwc3: core: Prevent USB core invalid event buffer address access
d504bfa6cfd1 usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller
179264157bba usb: dwc3: core: Check all ports when set phy suspend

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 89 +++++++++++++++++++++++++++++++++------
 drivers/usb/dwc3/core.h   | 10 +++++
 drivers/usb/dwc3/ep0.c    |  3 +-
 drivers/usb/dwc3/gadget.c | 41 ++++++++----------
 4 files changed, 106 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index cb82557678dd..9eb085f359ce 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -108,22 +108,27 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 {
 	u32 reg;
+	int i;
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	if (enable && !dwc->dis_u3_susphy_quirk)
-		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-	else
-		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+	for (i = 0; i < dwc->num_usb3_ports; i++) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
+		if (enable && !dwc->dis_u3_susphy_quirk)
+			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+		else
+			reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
+	}
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	if (enable && !dwc->dis_u2_susphy_quirk)
-		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-	else
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+		if (enable && !dwc->dis_u2_susphy_quirk)
+			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+		else
+			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+	}
 }
 
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
@@ -559,9 +564,17 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
 	if (!dwc->ev_buf)
 		return;
+	/*
+	 * Exynos platforms may not be able to access event buffer if the
+	 * controller failed to halt on dwc3_core_exit().
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	if (!(reg & DWC3_DSTS_DEVCTRLHLT))
+		return;
 
 	evt = dwc->ev_buf;
 
@@ -599,6 +612,18 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
+static void dwc3_config_soc_bus(struct dwc3 *dwc)
+{
+	if (dwc->gsbuscfg0_reqinfo != DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED) {
+		u32 reg;
+
+		reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+		reg &= ~DWC3_GSBUSCFG0_REQINFO(~0);
+		reg |= DWC3_GSBUSCFG0_REQINFO(dwc->gsbuscfg0_reqinfo);
+		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
+	}
+}
+
 static int dwc3_core_ulpi_init(struct dwc3 *dwc)
 {
 	int intf;
@@ -1338,6 +1363,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
+	dwc3_config_soc_bus(dwc);
+
 	ret = dwc3_phy_power_on(dwc);
 	if (ret)
 		goto err_exit_phy;
@@ -1359,6 +1386,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * STAR 9001285599: This issue affects DWC_usb3 version 3.20a
+	 * only. If the PM TIMER ECM is enabled through GUCTL2[19], the
+	 * link compliance test (TD7.21) may fail. If the ECN is not
+	 * enabled (GUCTL2[19] = 0), the controller will use the old timer
+	 * value (5us), which is still acceptable for the link compliance
+	 * test. Therefore, do not enable PM TIMER ECM in 3.20a by
+	 * setting GUCTL2[19] by default; instead, use GUCTL2[19] = 0.
+	 */
+	if (DWC3_VER_IS(DWC3, 320A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
+		reg &= ~DWC3_GUCTL2_LC_TIMER;
+		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
+	}
+
 	/*
 	 * When configured in HOST mode, after issuing U3/L2 exit controller
 	 * fails to send proper CRC checksum in CRC5 feild. Because of this
@@ -1576,6 +1618,27 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 }
 
+static void dwc3_get_software_properties(struct dwc3 *dwc)
+{
+	struct device *tmpdev;
+	u16 gsbuscfg0_reqinfo;
+	int ret;
+
+	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
+
+	/*
+	 * Iterate over all parent nodes for finding swnode properties
+	 * and non-DT (non-ABI) properties.
+	 */
+	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
+		ret = device_property_read_u16(tmpdev,
+					       "snps,gsbuscfg0-reqinfo",
+					       &gsbuscfg0_reqinfo);
+		if (!ret)
+			dwc->gsbuscfg0_reqinfo = gsbuscfg0_reqinfo;
+	}
+}
+
 static void dwc3_get_properties(struct dwc3 *dwc)
 {
 	struct device		*dev = dwc->dev;
@@ -2090,6 +2153,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	dwc3_get_software_properties(dwc);
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3781c736c1a1..c71240e8f7c7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -194,6 +194,10 @@
 #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
 #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
 
+/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
+#define DWC3_GSBUSCFG0_REQINFO(n)	(((n) & 0xffff) << 16)
+#define DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED	0xffffffff
+
 /* Global Debug LSP MUX Select */
 #define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only */
 #define DWC3_GDBGLSPMUX_HOSTSELECT(n)	((n) & 0x3fff)
@@ -417,6 +421,7 @@
 
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
+#define DWC3_GUCTL2_LC_TIMER			BIT(19)
 
 /* Global User Control Register 3 */
 #define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
@@ -1153,6 +1158,9 @@ struct dwc3_scratchpad_array {
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
  * @debug_root: root debugfs directory for this device to put its files in.
+ * @gsbuscfg0_reqinfo: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
+ *		       DATWRREQINFO, and DESWRREQINFO value passed from
+ *		       glue driver.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1262,6 +1270,7 @@ struct dwc3 {
 #define DWC3_REVISION_290A	0x5533290a
 #define DWC3_REVISION_300A	0x5533300a
 #define DWC3_REVISION_310A	0x5533310a
+#define DWC3_REVISION_320A	0x5533320a
 #define DWC3_REVISION_330A	0x5533330a
 
 #define DWC31_REVISION_ANY	0x0
@@ -1380,6 +1389,7 @@ struct dwc3 {
 	int			last_fifo_depth;
 	int			num_ep_resized;
 	struct dentry		*debug_root;
+	u32			gsbuscfg0_reqinfo;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index d96ffbe52039..c9533a99e47c 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -232,7 +232,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags = DWC3_EP_ENABLED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags |= DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 
 	if (!list_empty(&dep->pending_list)) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..291bc549935b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -287,6 +287,23 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
  *
  * Caller should handle locking. This function will issue @cmd with given
  * @params to @dep and wait for its completion.
+ *
+ * According to the programming guide, if the link state is in L1/L2/U3,
+ * then sending the Start Transfer command may not complete. The
+ * programming guide suggested to bring the link state back to ON/U0 by
+ * performing remote wakeup prior to sending the command. However, don't
+ * initiate remote wakeup when the user/function does not send wakeup
+ * request via wakeup ops. Send the command when it's allowed.
+ *
+ * Notes:
+ * For L1 link state, issuing a command requires the clearing of
+ * GUSB2PHYCFG.SUSPENDUSB2, which turns on the signal required to complete
+ * the given command (usually within 50us). This should happen within the
+ * command timeout set by driver. No additional step is needed.
+ *
+ * For L2 or U3 link state, the gadget is in USB suspend. Care should be
+ * taken when sending Start Transfer command to ensure that it's done after
+ * USB resume.
  */
 int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params)
@@ -327,30 +344,6 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
-	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
-		int link_state;
-
-		/*
-		 * Initiate remote wakeup if the link state is in U3 when
-		 * operating in SS/SSP or L1/L2 when operating in HS/FS. If the
-		 * link state is in U1/U2, no remote wakeup is needed. The Start
-		 * Transfer command will initiate the link recovery.
-		 */
-		link_state = dwc3_gadget_get_link_state(dwc);
-		switch (link_state) {
-		case DWC3_LINK_STATE_U2:
-			if (dwc->gadget->speed >= USB_SPEED_SUPER)
-				break;
-
-			fallthrough;
-		case DWC3_LINK_STATE_U3:
-			ret = __dwc3_gadget_wakeup(dwc, false);
-			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
-					ret);
-			break;
-		}
-	}
-
 	/*
 	 * For some commands such as Update Transfer command, DEPCMDPARn
 	 * registers are reserved. Since the driver often sends Update Transfer
-- 
2.53.0

