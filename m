Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B02CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E05BC84B5D;
	Thu,  7 May 2026 11:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N+0cLb4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5E084A6D; Thu,  7 May 2026 11:31:32 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B856E84B59
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5a87edf88b3so461354e87.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146284; x=1778751084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkVe8ECwEYx7A49cse/jszsqmpNKq1TXWE7QPgUG8Pk=;
 b=N+0cLb4th0p8V0Gn0zyuBcaH6VTcJ2OdCaULsPsDVYPfkF8hJ5kIROGYO6BSGYRs/c
 6/SORKBjH12kzYfWnQRd1wJ1U/XUiJanzC65oYbyxSlLavC3dY+bBWlKAS2+cZUQmt5o
 3Maca8g5em79jRl9mpHy8cXFd9vZPyI7e81Er0Q3J4CYnu7EwVKIr3sgXgU81qFl60Lu
 kJLhEdAQHMJcQ8fkwxZtfiGs73xbKFaN4+Zgy8jr5kZKkkbF7cwqzKbNazaVc3sT+5dm
 +pbE2Cbwd/yyLq9bHT9145thFKbDwfQjx5YjLbhGGAQln3CyhxzUoXkBHz7JHJceWhjP
 cmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146284; x=1778751084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XkVe8ECwEYx7A49cse/jszsqmpNKq1TXWE7QPgUG8Pk=;
 b=Dricp0GhacKIRRhpJu8edMqYbRRRFCgQ2azEsK0kkYIabUf05Efr4OyAyg6b//4YDE
 YQR6fX98ie8nbez/jUV4S7M1bncuEzi8/SvQCERF+SLqNV3T6PCePH0vcs78vgOP4lnj
 /PFaQ8jSYQl1FcMk68rvbO3y0KP0LQsZVlrF4Quk1w2Wsr58q+kcdBDECSW7PIng5kHD
 I5cTCxrrzH9ptgIyW3SNuCEmmW7a3yWz2HHq4uoRgf8FoD/QBLRV4NBYlZfyxbbjdB71
 y/kBcAJbiHPxp0YOJ39nai9iXWDe0/PuZ0BdkI5TJ10uoBAnijV+cyRceXrTlLoKJxz/
 i+Lw==
X-Gm-Message-State: AOJu0YwzI1ivRwd7A+1kXTdgpccXA7CSeirq1McnxznehwcpgSmcZGnr
 mEmCB/XlcPE1nPJcjpUAik5BqTOvUAKGML4qLEMDwmcr6vwNWlmo+1Il1KLu4f9sQWnxJY6354K
 K/6Iqv7ScHg==
X-Gm-Gg: AeBDieu7Easq9XnnVbCL/xEoZK07EH238fpCckS/bZTX40um3go4sTcj3hlhf0FR28F
 zu9mNQMROaF05unNCqJ7eZAn361LorBQd7L00OOEEA84V0VQ/TygkfI2nbnD59OE4gJqnAW3y/w
 6Kwl2nmzovGGZpM6CloG0gZEseDIV09siK17BZEMh5JFLKVgyEzPU5EPmAjQrY1AWE56uDlgval
 +zk2Uh6P2S/xdzgSTDKTfBrRsWjUoh7pyz+f//LltjO/e1iQeFcdJUkESyPigJlpDokVK9yXYut
 zxh8tdhv+MvtjSuJBxsREDPZvrz24L+P5nJmR1NuyH301+VKfOS88Irf9tnXhvSf6NByh5clV3I
 3BEomCPkZFHcxz4mWlYkkvGkoz852mEZyxQ9lGfqA6l2XjV3fJ8OndCBrynSUEyx1QXpLkwmZWI
 VaidYWe4LIx38o10u+Dqxj07JMdBLqPi4IzeAv+j24mVgd/g/3lYqbqaUcFJA4/fcw3bD1MKqJC
 KMTgxMzQFLrwSaa4E40lqNtRtjkKApIn6YdLSy4dBV0NoGLJpZi
X-Received: by 2002:a05:6512:33c2:b0:5a8:928b:8996 with SMTP id
 2adb3069b0e04-5a8928b9e73mr1153458e87.30.1778146283078; 
 Thu, 07 May 2026 02:31:23 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:31:21 -0700 (PDT)
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
Subject: [RFC PATCH v2 55/64] usb: dwc3: import from kernel v6.11
Date: Thu,  7 May 2026 11:28:02 +0200
Message-ID: <20260507092843.358908-56-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.10 to v6.11.

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

List of commits: git log --oneline v6.10..v6.11
Commits imported:
9149c9b0c7e0 usb: dwc3: core: update LC timer as per USB Spec V3.2
00dcf2fa449f usb: dwc3: Avoid waking up gadget during startxfer
cd4897bfd14f usb: dwc3: st: add missing depopulate in probe error path
ddfcfeba8910 usb: dwc3: st: fix probed platform device ref count on probe error path
72fca8371f20 usb: dwc3: ep0: Don't reset resource alloc flag (including ep0)
16f2a21d9d7e usb: dwc3: xilinx: add missing depopulate in probe error path
2aa765a43817 usb: dwc3: omap: add missing depopulate in probe error path
14e497183df2 usb: dwc3: core: Prevent USB core invalid event buffer address access
04d17331ca33 Merge tag 'usb-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
d504bfa6cfd1 usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller
179264157bba usb: dwc3: core: Check all ports when set phy suspend
f7697db8b1b3 Merge 6.10-rc6 into usb-next
b7ec7fd63256 usb: dwc3: Support quirk for writing high-low order

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
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
2.43.0

