Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CD3C5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70D8A60EC7;
	Fri, 21 Aug 2026 13:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DyRzn4chy362; Fri, 21 Aug 2026 13:14:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317979;
	bh=J3aLEXFX5LZDIODOauS+VXAuyQa9qG0uRrY7YCrZ1LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JNLM0UVvqm54zjKNz41jzNw4cTLmXMU0dQjctDrb8XoWE9Lz/q+X3Y6OdGYkPwOwq
	 532OSp+wiSX4IwmtkzuVW7pBQxrVRK4/VlSnTkQPBG0fX91l2tY6KT5gGRWOwjKbS/
	 hnLHDmBWohO/xeMthH2fU2eAWH2diwd17dqA5bA5p90CakSqZAfjUSkySXda/AQtwn
	 lxM9YTmoGxKsX6fkNmuhRLMNy9eMM1dDbahBQXLdI1PoOXnvUzdZ3RAfqoLcKdvNO4
	 5Z1Jss+vT5BjLpTa5RooKfRVRN6MyIfNfDTxstJ+UrSgw4DOigGQFC7jZ0Jr68NPOP
	 BokijFsJa1uSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E3AB60DD6;
	Fri, 21 Aug 2026 13:12:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 54A564B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46EA56068A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y0vvgMZWbrI9 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=a0MXwrO+
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA4CA6067B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:32 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a18af264f9so185199a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302291; x=1787907091;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J3aLEXFX5LZDIODOauS+VXAuyQa9qG0uRrY7YCrZ1LA=;
 b=a0MXwrO+bEy2NXtFDC0ZZvgaQYN/HqlOeaxwn1x8uziCTsRpfJvuKIrvbRR1Nf8Am6
 rJC/pmEyuKYG26kWB6BU4F0tPXJbdlYkfPX4aj8vwCptsQQYdhY42Dmh5xEWsU2xi10h
 va0mDYbld/FhVV6TfTwXR8Nk0qJ/LIT3FhSpc2xQqUjZTr7rn+IYT9NJffYJ4coMzp8M
 RT/LsLaKxtBOQFHeRmIPNBeU1+0bMBSbo6MOGv2408lBG7WBrVIhFiEWWGWCTa4KN1wF
 0eQdGpUWwKtyr1KHSam6aITe4nOI6pG+P/QPU16SSrREdrSVPHOJqoJ7ezDcIQRK1VeT
 TWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302291; x=1787907091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J3aLEXFX5LZDIODOauS+VXAuyQa9qG0uRrY7YCrZ1LA=;
 b=O1pU+OfFQ0WxHNPm6J6WNEuGWg+4+6G7pUbahHM7vVou1i0JcmYi0vUZ/qX+Cc8SaP
 4El7ttzExSFrKx36ORUu1k6zbrBie1nYznabLe9GwYBY50k4/wVByYlBwwBIPYXeU0a9
 lUqdnZxnDeLhS62nJ9Ko1VSCffF5Ku9zDP/kUSm7JyQrMqeRLreLe92zOyepO5EaQg6K
 A9VpcDAWvdra75/e6VYldaC+6gn4WfX5hVY1gHQazeWq8Q3yaS53DsQo2PvopemcHdfq
 oMIUQIshdslp7SILWcNd34/QEiJJ40n/uSVk+6Vw473FtKoSdAYgnwGrbfqx+pOry1Wh
 IfGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+PFy5MTF2Qg/t7TTSS16vyY8uILAf1sPymKOvBXxZW4Mfrf07QG2GNSED4gaot4wuKeSt6Bs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kUB+mMt2A7C0IfiHOGIXNBjhsBklSo9Zgs9EM+Bm948+zdRQz0
 8BMc7CQowvp5nTBw5Z5sjHH/L69J2h+EdaqLqpQEWk1AYzkgeb583KkLPCJz6BtPP8Y=
X-Gm-Gg: AR+sD118T2DDNxBrjTUer7xZzdkgkXE8vlwuwYdOQjio6E6NPXfCu4AfdludbZysAdF
 YEXv5GxhFDcFZ33Kl0BXhLm/cTV0n4W0YsflPaKIswkjqDmwUFxg55Uqim4OHwc9bFsJb4x/mZv
 1YCWK/k7ih72sJ0vQSuPadGSHvPHuaM7fGFWk7AOhfpJqC6lfAV07nOZiEl6NXh2s8sGlicxT55
 RIzXAR8pWTadNSLlpYT+L2DZ8v/3yR8seRXONV6EpPEa9U8J4KLjXeaJJIAex9DB7HgPKHXmHRC
 qJjTJ4kuyc9Z1sk3za68vL+IWv6OslpFskAIsu/UOncytO7NpUmUL17gxK2RuikAPTEmdMwUleL
 lP1wROjtVNdv6/q1pzZoPQP2pGT7AfQSGukyyJMSqZXTKntpTCDYRAWI7TOe6lD7Has6tU1xFJW
 71C5yIzsAm21fsKM4wUPUwmAkhztci+lFgx/9zDd3389NTv2pEZcWSDWOR1LnJ5iOeq340X0uga
 qL28RyOrqnFqk5jlrA0GWup
X-Received: by 2002:a05:6402:5d0:b0:6a1:d68:338a with SMTP id
 4fb4d7f45d1cf-6a42eeaf432mr2758458a12.0.1787302290452; 
 Fri, 21 Aug 2026 01:51:30 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0c327asm5482378a12.8.2026.08.21.01.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:29 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 28/87] usb: dwc3: import from kernel v5.3
Date: Fri, 21 Aug 2026 10:47:04 +0200
Message-ID: <20260821084829.2070426-29-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.2 to v5.3.

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

List of commits: git log --oneline v5.2..v5.3
Commits imported:
332694f8a4f7 Revert "usb:gadget Separated decoding functions from dwc3 driver."
3db1b636c07e usb:gadget Separated decoding functions from dwc3 driver.
aa23ce847dda usb: dwc3: remove unused @lock member of dwc3_ep struct
729dcffd1ed3 usb: dwc3: gadget: Add support for disabling U1 and U2 entries
dc1b5d9aed17 usb: dwc3: Fix core validation in probe, move after clocks are enabled

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 16 +++++++++++-----
 drivers/usb/dwc3/core.h   |  6 ++++--
 drivers/usb/dwc3/ep0.c    |  9 ++++++++-
 drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++++--
 drivers/usb/dwc3/gadget.h |  6 ++++++
 5 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4aff1d8dbc4f..c9bb93a2c81e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1282,6 +1282,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis_u2_susphy_quirk");
 	dwc->dis_enblslpm_quirk = device_property_read_bool(dev,
 				"snps,dis_enblslpm_quirk");
+	dwc->dis_u1_entry_quirk = device_property_read_bool(dev,
+				"snps,dis-u1-entry-quirk");
+	dwc->dis_u2_entry_quirk = device_property_read_bool(dev,
+				"snps,dis-u2-entry-quirk");
 	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
 				"snps,dis_rxdet_inp3_quirk");
 	dwc->dis_u2_freeclk_exists_quirk = device_property_read_bool(dev,
@@ -1423,11 +1427,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->regs	= regs;
 	dwc->regs_size	= resource_size(&dwc_res);
 
-	if (!dwc3_core_is_valid(dwc)) {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		return -ENODEV;
-	}
-
 	dwc3_get_properties(dwc);
 
 	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
@@ -1460,6 +1459,12 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (ret)
 		goto unprepare_clks;
 
+	if (!dwc3_core_is_valid(dwc)) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		ret = -ENODEV;
+		goto disable_clks;
+	}
+
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
@@ -1525,6 +1530,7 @@ err1:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+disable_clks:
 	clk_bulk_disable(dwc->num_clks, dwc->clks);
 unprepare_clks:
 	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f19cbeb01087..3dd783b889cb 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -649,7 +649,6 @@ struct dwc3_event_buffer {
  * @cancelled_list: list of cancelled requests for this endpoint
  * @pending_list: list of pending requests for this endpoint
  * @started_list: list of started requests on this endpoint
- * @lock: spinlock for endpoint request queue traversal
  * @regs: pointer to first endpoint register
  * @trb_pool: array of transaction buffers
  * @trb_pool_dma: dma address of @trb_pool
@@ -677,7 +676,6 @@ struct dwc3_ep {
 	struct list_head	pending_list;
 	struct list_head	started_list;
 
-	spinlock_t		lock;
 	void __iomem		*regs;
 
 	struct dwc3_trb		*trb_pool;
@@ -1014,6 +1012,8 @@ struct dwc3_scratchpad_array {
  * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
  * @dis_enblslpm_quirk: set if we clear enblslpm in GUSB2PHYCFG,
  *                      disabling the suspend signal to the PHY.
+ * @dis_u1_entry_quirk: set if link entering into U1 state needs to be disabled.
+ * @dis_u2_entry_quirk: set if link entering into U2 state needs to be disabled.
  * @dis_rxdet_inp3_quirk: set if we disable Rx.Detect in P3
  * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists
  *			in GUSB2PHYCFG, specify that USB2 PHY doesn't
@@ -1205,6 +1205,8 @@ struct dwc3 {
 	unsigned		dis_u3_susphy_quirk:1;
 	unsigned		dis_u2_susphy_quirk:1;
 	unsigned		dis_enblslpm_quirk:1;
+	unsigned		dis_u1_entry_quirk:1;
+	unsigned		dis_u2_entry_quirk:1;
 	unsigned		dis_rxdet_inp3_quirk:1;
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8efde178eef4..3996b9c4ff8d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -379,6 +379,8 @@ static int dwc3_ep0_handle_u1(struct dwc3 *dwc, enum usb_device_state state,
 	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
 			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return -EINVAL;
+	if (set && dwc->dis_u1_entry_quirk)
+		return -EINVAL;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (set)
@@ -401,6 +403,8 @@ static int dwc3_ep0_handle_u2(struct dwc3 *dwc, enum usb_device_state state,
 	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
 			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return -EINVAL;
+	if (set && dwc->dis_u2_entry_quirk)
+		return -EINVAL;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (set)
@@ -626,7 +630,10 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			 * nothing is pending from application.
 			 */
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-			reg |= (DWC3_DCTL_ACCEPTU1ENA | DWC3_DCTL_ACCEPTU2ENA);
+			if (!dwc->dis_u1_entry_quirk)
+				reg |= DWC3_DCTL_ACCEPTU1ENA;
+			if (!dwc->dis_u2_entry_quirk)
+				reg |= DWC3_DCTL_ACCEPTU2ENA;
 			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 		}
 		break;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d67655384eb2..173f5329d3d9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2073,6 +2073,25 @@ out:
 	return 0;
 }
 
+static void dwc3_gadget_config_params(struct usb_gadget *g,
+				      struct usb_dcd_config_params *params)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+
+	/* U1 Device exit Latency */
+	if (dwc->dis_u1_entry_quirk)
+		params->bU1devExitLat = 0;
+	else
+		params->bU1devExitLat = DWC3_DEFAULT_U1_DEV_EXIT_LAT;
+
+	/* U2 Device exit Latency */
+	if (dwc->dis_u2_entry_quirk)
+		params->bU2DevExitLat = 0;
+	else
+		params->bU2DevExitLat =
+				cpu_to_le16(DWC3_DEFAULT_U2_DEV_EXIT_LAT);
+}
+
 static void dwc3_gadget_set_speed(struct usb_gadget *g,
 				  enum usb_device_speed speed)
 {
@@ -2142,6 +2161,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_start		= dwc3_gadget_start,
 	.udc_stop		= dwc3_gadget_stop,
 	.udc_set_speed		= dwc3_gadget_set_speed,
+	.get_config_params	= dwc3_gadget_config_params,
 };
 
 /* -------------------------------------------------------------------------- */
@@ -2251,8 +2271,6 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 		dep->endpoint.comp_desc = NULL;
 	}
 
-	spin_lock_init(&dep->lock);
-
 	if (num == 0)
 		ret = dwc3_gadget_init_control_endpoint(dep);
 	else if (direction)
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 3ed738e86ea7..5faf4d1249e0 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -48,6 +48,12 @@ struct dwc3;
 /* DEPXFERCFG parameter 0 */
 #define DWC3_DEPXFERCFG_NUM_XFER_RES(n)	((n) & 0xffff)
 
+/* U1 Device exit Latency */
+#define DWC3_DEFAULT_U1_DEV_EXIT_LAT	0x0A	/* Less then 10 microsec */
+
+/* U2 Device exit Latency */
+#define DWC3_DEFAULT_U2_DEV_EXIT_LAT	0x1FF	/* Less then 511 microsec */
+
 /* -------------------------------------------------------------------------- */
 
 #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, request))
-- 
2.53.0

