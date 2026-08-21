Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5461C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B9E460F46;
	Fri, 21 Aug 2026 13:15:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Or3VOOQNQlum; Fri, 21 Aug 2026 13:15:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318007;
	bh=AGvjrOKtqBLnGGb10xg9yAGwXxGwzg5MgTlcsQKTa+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QLiKZzbvF/1tkENnkImz+YXVHDRcJjiTwrelnZpJ5X0rUngMz927IDNQolKupZhFM
	 m7Jyxmpakw0VmAw9MMJKaTRcelo1Edo+yq/a9VCvQ7wTutGmnQyf8SM2gu8KLDP4/C
	 gX4JVOyzMmQET3Q6DkxpC8McfrsLbM/lJgimCKLRfddXfTVEPj9ENx/9lMk4SnAbh2
	 2UTnOR1R/wYz/fn1mhSLgVA44bmWXX63VRdWfSzB2AE+wKFSimZ7EAc4fMSv4G+Ppq
	 aoM/UFsWDReVMP6GZPz2CJNqvyZRtd/vVBY3Vd3j2CrmSvAXDc5VlBJgLQj9iq611d
	 Q3q5GwgaDCVgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3730260AB2;
	Fri, 21 Aug 2026 13:13:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D11854B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C32A2408BC
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rlDLgnmR4Pq9 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Vb4BKRN/
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F129408AD
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:48 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a10d6f455dso136031a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302306; x=1787907106;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AGvjrOKtqBLnGGb10xg9yAGwXxGwzg5MgTlcsQKTa+A=;
 b=Vb4BKRN/Bzf8AWg0aSN1Btn+TLPOonplQ+/hhIGFHLkTpS4qz0PWYuiu+OX19HU1ls
 w/lOPLe3C4xHkc6lDxxlGdv34OQIbYKayrVKOPwWCELzvy0SbHQaKugt8vwlngBIqIRV
 KgfKq+GpbeIxar5AY3PSSWCKyhCwEAEcr0mz54FtMWdVxUQsNeQsWKvWDG+9ptDKeQ1X
 IL5cntyIOa0+TZh5SwZT94hcvmtDRtBta2N0xj3lMrOUpWKlbEadYZiGteDki1dbNrPs
 5EAbCNhJrEG9ji6kc8Tor8vfIqQCFNCeB6IElD/OFzVhqVAkcGouoMFjlG4rHWQUegsW
 YTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302306; x=1787907106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AGvjrOKtqBLnGGb10xg9yAGwXxGwzg5MgTlcsQKTa+A=;
 b=g11K65ACNKTF3h6wDlcq7n6TEIACQl9JJfCf97YbonylY0COefoCpv+p73QA6lPcZc
 clTkKBXQdiSem+IOTyufX9hC2U906i+U2kcaa0H3FJi+BRCSxBjfVTbmm18Jwy/n3XUy
 dlQ15ZbBAiix9Xt/bp7cAY2sXw1C5dwmVDf6KxeV4Kcqul61EcqP5lUF0/QrSoOrM8Xl
 TGNFuOn+5V90ao9V8HrOjODiVsyfIg5KZZM/wnmmQ/eBcrif63FProq5ZOnhEgtWDZ5r
 MpJ/l26tZMa9GnFH6gn4vZKLSZWGZeTgMfX2it60VXs482lZvNmtXA8ZfenZLemW3OkE
 ij1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTqXJMB0nZHymcAg51iUiDvBIetqg0Om2OWch+6OOgEgsBes4nJZna1IGoJx+CQdazRSKLiow=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kBRnrneXXRa+bNGaGvuNSBNsIFB8EgHy2hZFFLsa4cLzZAzKLS
 ASHodYOtfz2USxUp8fejVE2Q8mwd9XEZ7GA+QnaeYKMSApq/tMheMuS1qqufZNDN4YwjHQwQNOX
 58gRI
X-Gm-Gg: AR+sD1319DQ19Nq/uRaRzjxdAZfQDKR0LAZ1oBmCnsfS6kF1hr6a4+oy3TA27syviFa
 IG4IVpxqMwVBPBFnoUu82wX8ORXzaQ+RDpBaYkPLLBE6N5lS3UZu2he/hxNPGvL5H7kwMMhlv0v
 qMJGG6Cd5tSPP7n5Xvydn1TyLLnX0hOgwQSbYlJs7GV7SFbr2cPJ/SMIv7vHT/UdoCrzb9Pxxz/
 pLLDi500Z168rPPLcJ2PF9THYojCTc8MoQAAMj0GbgQYATvUpJtHzzz5TmCJkCXhvQDi8PfmR8L
 GSpp2tZda64SFzv2sb8IFOfN5AuUX/623WsFuat+E5tSD3Ba1wC4b5cNHBwL43tVngnkjvQuOAD
 MVvAosHrjUyHjD0eunpWMD5KskFyVvXD013vToGNhaE2VSuJzv7Nt45Rkb83ALw6fGss3VqaQNA
 iKIq/1PeiAmps56dIY31Wyg2RlbrvE2EOjnu8RUV1fBG3P26LfQiwIewt/ZazebCqOM3VapVNCa
 u4dvJrswqOrhYHMWzpU8c+T
X-Received: by 2002:a17:907:d0e:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c246a65fe29mr242743466b.4.1787302306255; 
 Fri, 21 Aug 2026 01:51:46 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e04b5sm378705266b.5.2026.08.21.01.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:45 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 39/87] usb: dwc3: import from kernel v5.14
Date: Fri, 21 Aug 2026 10:47:15 +0200
Message-ID: <20260821084829.2070426-40-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.13 to v5.14.

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

List of commits: git log --oneline v5.13..v5.14
Commits imported:
4a1e25c0a029 usb: dwc3: gadget: Stop EP0 transfers during pullup disable
51f1954ad853 usb: dwc3: gadget: Fix dwc3_calc_trbs_left()
664cc971fb25 Revert "usb: dwc3: gadget: Use list_replace_init() before traversing lists"
cb10f68ad815 usb: dwc3: gadget: Avoid runtime resume if disabling pullup
d25d85061bd8 usb: dwc3: gadget: Use list_replace_init() before traversing lists
40edb52298df usb: dwc3: avoid NULL access of usb_gadget_driver
84524d1232ec usb: dwc3: Fix debugfs creation flow
8562d5bfc0fc USB: dwc3: remove debugfs root dentry storage
45d39448b4d0 usb: dwc3: support 64 bit DMA in platform driver
2a042767814b usb: dwc3: core: fix kernel panic when do reboot
5ff90af9da8f usb: dwc3: debugfs: Add and remove endpoint dirs dynamically

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  7 ++++-
 drivers/usb/dwc3/core.h   |  3 +-
 drivers/usb/dwc3/ep0.c    | 10 ++++---
 drivers/usb/dwc3/gadget.c | 59 +++++++++++++++++++++++++++------------
 4 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4ac397e43e19..ba74ad7f6995 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1545,6 +1545,10 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
@@ -1616,17 +1620,18 @@ static int dwc3_probe(struct platform_device *pdev)
 	}
 
 	dwc3_check_params(dwc);
+	dwc3_debugfs_init(dwc);
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
 		goto err5;
 
-	dwc3_debugfs_init(dwc);
 	pm_runtime_put(dev);
 
 	return 0;
 
 err5:
+	dwc3_debugfs_exit(dwc);
 	dwc3_event_buffers_cleanup(dwc);
 
 	usb_phy_shutdown(dwc->usb2_phy);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c5d5760cdf53..5991766239ba 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1013,7 +1013,6 @@ struct dwc3_scratchpad_array {
  * @link_state: link state
  * @speed: device speed (super, high, full, low)
  * @hwparams: copy of hwparams registers
- * @root: debugfs root folder pointer
  * @regset: debugfs pointer to regdump file
  * @dbg_lsp_select: current debug lsp mux register selection
  * @test_mode: true when we're entering a USB test mode
@@ -1222,7 +1221,6 @@ struct dwc3 {
 	u8			num_eps;
 
 	struct dwc3_hwparams	hwparams;
-	struct dentry		*root;
 	struct debugfs_regset32	*regset;
 
 	u32			dbg_lsp_select;
@@ -1281,6 +1279,7 @@ struct dwc3 {
 	unsigned		dis_metastability_quirk:1;
 
 	unsigned		dis_split_quirk:1;
+	unsigned		async_callbacks:1;
 
 	u16			imod_interval;
 };
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 3cd294264372..2f9e45eed228 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -597,11 +597,13 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	int ret;
+	int ret = -EINVAL;
 
-	spin_unlock(&dwc->lock);
-	ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
-	spin_lock(&dwc->lock);
+	if (dwc->async_callbacks) {
+		spin_unlock(&dwc->lock);
+		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
+		spin_lock(&dwc->lock);
+	}
 	return ret;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f14c2aa83759..ccb68fe6202e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -940,19 +940,19 @@ static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
 
 static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 {
-	struct dwc3_trb		*tmp;
 	u8			trbs_left;
 
 	/*
-	 * If enqueue & dequeue are equal than it is either full or empty.
-	 *
-	 * One way to know for sure is if the TRB right before us has HWO bit
-	 * set or not. If it has, then we're definitely full and can't fit any
-	 * more transfers in our ring.
+	 * If the enqueue & dequeue are equal then the TRB ring is either full
+	 * or empty. It's considered full when there are DWC3_TRB_NUM-1 of TRBs
+	 * pending to be processed by the driver.
 	 */
 	if (dep->trb_enqueue == dep->trb_dequeue) {
-		tmp = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
-		if (tmp->ctrl & DWC3_TRB_CTRL_HWO)
+		/*
+		 * If there is any request remained in the started_list at
+		 * this point, that means there is no TRB available.
+		 */
+		if (!list_empty(&dep->started_list))
 			return 0;
 
 		return DWC3_TRB_NUM - 1;
@@ -2243,10 +2243,19 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
 				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
-		if (ret == 0) {
-			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
-			return -ETIMEDOUT;
-		}
+		if (ret == 0)
+			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");
+	}
+
+	/*
+	 * Avoid issuing a runtime resume if the device is already in the
+	 * suspended state during gadget disconnect.  DWC3 gadget was already
+	 * halted/stopped during runtime suspend.
+	 */
+	if (!is_on) {
+		pm_runtime_barrier(dwc->dev);
+		if (pm_runtime_suspended(dwc->dev))
+			return 0;
 	}
 
 	/*
@@ -2447,6 +2456,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
+	dwc->delayed_status = false;
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
@@ -2585,6 +2595,16 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 	return ret;
 }
 
+static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->async_callbacks = enable;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
@@ -2596,6 +2616,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_set_ssp_rate	= dwc3_gadget_set_ssp_rate,
 	.get_config_params	= dwc3_gadget_config_params,
 	.vbus_draw		= dwc3_gadget_vbus_draw,
+	.udc_async_callbacks	= dwc3_gadget_async_callbacks,
 };
 
 /* -------------------------------------------------------------------------- */
@@ -2798,7 +2819,9 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
-		debugfs_remove_recursive(debugfs_lookup(dep->name, dwc->root));
+		debugfs_remove_recursive(debugfs_lookup(dep->name,
+				debugfs_lookup(dev_name(dep->dwc->dev),
+					       usb_debug_root)));
 		kfree(dep);
 	}
 }
@@ -3229,7 +3252,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 
 static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->disconnect) {
+	if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->disconnect(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3238,7 +3261,7 @@ static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 
 static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->suspend) {
+	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->suspend(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3247,7 +3270,7 @@ static void dwc3_suspend_gadget(struct dwc3 *dwc)
 
 static void dwc3_resume_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3259,7 +3282,7 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return;
 
-	if (dwc->gadget->speed != USB_SPEED_UNKNOWN) {
+	if (dwc->async_callbacks && dwc->gadget->speed != USB_SPEED_UNKNOWN) {
 		spin_unlock(&dwc->lock);
 		usb_gadget_udc_reset(dwc->gadget, dwc->gadget_driver);
 		spin_lock(&dwc->lock);
@@ -3583,7 +3606,7 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 	 * implemented.
 	 */
 
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
-- 
2.53.0

