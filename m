Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1422CC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9F758114D;
	Mon, 24 Aug 2026 16:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YqixviTFnyW0; Mon, 24 Aug 2026 16:46:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589923;
	bh=RlMkc44Iyrnbx2OoDcbaROuw3oDHAg7iCFsic+ZoGYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OP8nyiLwTm89tnljm3I1598/zdatukCgLfy5IrY7U34YlkYN4xEY0avBFzSd/tEsZ
	 Irm3ZRlRYdV1OWn+QaAi2tomdDHGXL4MWzGy0vo+GUN59Mh2uXcOSn2F7cStzOW4SX
	 G1uPeajutNH4ZQ/Hq1hrSz4vKsVjLqYwanry3tzKvS+g04/Gd6vKsr3KNRniMPaM+E
	 z/uAgjzixJHOcdXKWNwV48MttytlwmAyJ8U7gFz3ZmR6WN4+hL1OFqGN6RMfsTtCtP
	 rc7rBojRnluoZx/tPT5GC6f5OUsTH8sPnxkywpwF0fzEshtytTgHeAFFvDdwR8prjf
	 7B+mjiZF0jEcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56EA080ED4;
	Mon, 24 Aug 2026 16:45:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C4AC279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52FDA403F4
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lm3B6m-p4Azc for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:32:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=UouCDyH/
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 175BB403EB
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:44 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c1676648c1eso25918366b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585563; x=1788190363;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RlMkc44Iyrnbx2OoDcbaROuw3oDHAg7iCFsic+ZoGYE=;
 b=UouCDyH/uP0GJtHDVs1Adqxd4RvBLO3dMEfV6zPLgb7NUffrBXisFn+dBNjIdXwuQA
 IGOQrmmL0cMUarhrbT/rAK3GdP2+EvEFCnomNvJQ8JsRGUwEOgCkjQ7bgRJloQX43POb
 WHqXMJaIMBInSSKCtmrg8bNDvvITISN2Hga4H4sQ7/wbcKmTc/NYIVN+DlGqkk5bhOxl
 gnX0kqXceZpxWaglE8/abInZ6r4WKTunOZGHZAmCZ6Dww3IXqOF1xvHv2S+o2Xzo9qy3
 Ns9DjJfgxC44aIDdxZ3tqxHUBi5KWRiokHu5QiZ8FktICvmKZFkCShRy1g+3PheWPplq
 mmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585563; x=1788190363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RlMkc44Iyrnbx2OoDcbaROuw3oDHAg7iCFsic+ZoGYE=;
 b=VuKZ4k3usQ5Lq+ml/CFQyHOEQlBEv9Pc1N19ReJs2Bux+v2SuT5DNE8N5a6Zjx3wa9
 7cE3I99Y7BFh85chB9quJKMCFgJN1W+apMM/ZI4lgiaOcIlyRdncAW3HpW2B2UHrCxnM
 gKWBGVZkJZaZOwfockcpJfiLzebszZ3XIn0ruQ6DyG7cKwuVI0BNLBTELUfPe7hWtaER
 ZCN3YQoS621lWoYI2v2s+yKBLT4h+lDGmc4q3sHZDTlvQIv2CTLM1xWKslgfmLO9uxjh
 1FBmmTVYSfrWM4s34efB7xYq9JPXks+lv/+yLzksQAYA+7peVSKN99pi+h+RJEFyDe68
 m1wg==
X-Gm-Message-State: AFuF++n2mvilIOCXC9YNQD4gMyorKEWjsGcrtQDXF04FzvJlUkNO+jLs
 QKuWBtVuqryGOD4VZMy7Xvdvtfoyy7G4GI83zlgm7VSlwpJML2PL7kW+qpqGM72+8U1C9YxTFhr
 1ZKOk
X-Gm-Gg: AR+sD10U/0Ej2mBsu9LqFEeCZiNnnR+hf4cVLN6C3JUjo4bBLpCv34zQiIFo1jtg3ob
 KKlhgvhMKpsJQwphXB7c/Ia9UCoR+O8KPMKPjY3f7f+V/ebNF6SWjBai4vp6IQYcgrvh32Gz9NM
 5YxEf+MihKtxjYTFG9OjOxdcMWcgxaoemhGCUOARGtv6ibmI1FYdK7zkoaLqpdEC2PNjqHMMK7l
 bcylgnbswZqs4SL9Tl+vuFB/jhlv0MQwiDEzGBpDtHReq7Do4h64frIKlQXGSZ1xjxxLV48ZTDU
 1tvDZ7n5AYj9lSRT4jzT/iEB/UTFohTvkyD05tO7jWcCl6MAEOmalpkjQ5PeM6V274Z4kIXlOqz
 35Hi4v7YaYSseKRQhz703kMa4n9GUmNncvBl7KK4n7c+nDCX8qLdVMkrsyVORFWQr909Z9o5LL3
 wJxFcqI6iw5E/9FrHZoOYEkQR3mhwA/yJwCO1hpFdUw1o27t3NnVA4Wj1WhbsdyVxy7ZcIcoXZ7
 SynL5xKEglEH6nQU+FvYw==
X-Received: by 2002:a17:907:1c26:b0:c21:8555:5f55 with SMTP id
 a640c23a62f3a-c246a65eda7mr1787841466b.2.1787585562767; 
 Mon, 24 Aug 2026 08:32:42 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295627sm1267430166b.15.2026.08.24.08.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:32:42 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 60/63] usb: dwc3: import from kernel v6.15
Date: Mon, 24 Aug 2026 17:27:31 +0200
Message-ID: <20260824152734.159794-61-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.14 to v6.15.

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

List of commits: git log --oneline v6.14..v6.15
Commits imported:
2372f1caeca4 usb: dwc3: gadget: Make gadget_wakeup asynchronous
63ccd26cd1f6 usb: dwc3: gadget: check that event count does not exceed event buffer length
042c3dd1f2d3 usb: dwc3: Don't use %pK through printk
07959ad5775f USB: dwc3: Use syscon_regmap_lookup_by_phandle_args
5425191f85fe usb: dwc3: gadget: Add support for snps,reserved-endpoints property
eafba0205426 usb: dwc3: gadget: Refactor loop to avoid NULL endpoints

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.h      |   4 ++
 drivers/usb/dwc3/dwc3-am62.c |  12 +---
 drivers/usb/dwc3/gadget.c    | 135 +++++++++++++++++++++++------------
 3 files changed, 96 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index aaa39e663f60..27eae4cf223d 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1164,6 +1164,9 @@ struct dwc3_scratchpad_array {
  * @gsbuscfg0_reqinfo: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
  *		       DATWRREQINFO, and DESWRREQINFO value passed from
  *		       glue driver.
+ * @wakeup_pending_funcs: Indicates whether any interface has requested for
+ *			 function wakeup in bitmap format where bit position
+ *			 represents interface_id.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1394,6 +1397,7 @@ struct dwc3 {
 	int			num_ep_resized;
 	struct dentry		*debug_root;
 	u32			gsbuscfg0_reqinfo;
+	u32			wakeup_pending_funcs;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index c158364bc03e..9db8f3ca493d 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -153,11 +153,11 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 {
 	struct device *dev = am62->dev;
 	struct device_node *node = dev->of_node;
-	struct of_phandle_args args;
 	struct regmap *syscon;
 	int ret;
 
-	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-phy-pll-refclk");
+	syscon = syscon_regmap_lookup_by_phandle_args(node, "ti,syscon-phy-pll-refclk",
+						      1, &am62->offset);
 	if (IS_ERR(syscon)) {
 		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
 		return PTR_ERR(syscon);
@@ -165,14 +165,6 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 
 	am62->syscon = syscon;
 
-	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-phy-pll-refclk", 1,
-					       0, &args);
-	if (ret)
-		return ret;
-
-	of_node_put(args.np);
-	am62->offset = args.args[0];
-
 	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
 	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_CORE_VOLTAGE_MASK, 0);
 	if (ret) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89a4dc8ebf94..321361288935 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -276,8 +276,6 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 	return ret;
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
-
 /**
  * dwc3_send_gadget_ep_cmd - issue an endpoint command
  * @dep: the endpoint to which the command is going to be issued
@@ -547,6 +545,7 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
 int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 {
 	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_ep		*dep;
 	u32			cmd;
 	int			i;
 	int			ret;
@@ -563,8 +562,13 @@ int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 		return ret;
 
 	/* Reset resource allocation flags */
-	for (i = resource_index; i < dwc->num_eps && dwc->eps[i]; i++)
-		dwc->eps[i]->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	for (i = resource_index; i < dwc->num_eps; i++) {
+		dep = dwc->eps[i];
+		if (!dep)
+			continue;
+
+		dep->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	}
 
 	return 0;
 }
@@ -751,9 +755,11 @@ void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
 
 	dwc->last_fifo_depth = fifo_depth;
 	/* Clear existing TXFIFO for all IN eps except ep0 */
-	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM);
-	     num += 2) {
+	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM); num += 2) {
 		dep = dwc->eps[num];
+		if (!dep)
+			continue;
+
 		/* Don't change TXFRAMNUM on usb31 version */
 		size = DWC3_IP_IS(DWC3) ? 0 :
 			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
@@ -1971,12 +1977,12 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		return -ESHUTDOWN;
 	}
 
-	if (WARN(req->dep != dep, "request %pK belongs to '%s'\n",
+	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
 				&req->request, req->dep->name))
 		return -EINVAL;
 
 	if (WARN(req->status < DWC3_REQUEST_STATUS_COMPLETED,
-				"%s: request %pK already in flight\n",
+				"%s: request %p already in flight\n",
 				dep->name, &req->request))
 		return -EINVAL;
 
@@ -2165,7 +2171,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		}
 	}
 
-	dev_err(dwc->dev, "request %pK was not queued to %s\n",
+	dev_err(dwc->dev, "request %p was not queued to %s\n",
 		request, ep->name);
 	ret = -EINVAL;
 out:
@@ -2351,10 +2357,8 @@ static int dwc3_gadget_get_frame(struct usb_gadget *g)
 	return __dwc3_gadget_get_frame(dwc);
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 {
-	int			retries;
-
 	int			ret;
 	u32			reg;
 
@@ -2382,8 +2386,7 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
 		return -EINVAL;
 	}
 
-	if (async)
-		dwc3_gadget_enable_linksts_evts(dwc, true);
+	dwc3_gadget_enable_linksts_evts(dwc, true);
 
 	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
 	if (ret < 0) {
@@ -2402,27 +2405,8 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
 
 	/*
 	 * Since link status change events are enabled we will receive
-	 * an U0 event when wakeup is successful. So bail out.
+	 * an U0 event when wakeup is successful.
 	 */
-	if (async)
-		return 0;
-
-	/* poll until Link State changes to ON */
-	retries = 20000;
-
-	while (retries--) {
-		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
-
-		/* in HS, means ON */
-		if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
-			break;
-	}
-
-	if (DWC3_DSTS_USBLNKST(reg) != DWC3_LINK_STATE_U0) {
-		dev_err(dwc->dev, "failed to send remote wakeup\n");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -2443,7 +2427,7 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return -EINVAL;
 	}
-	ret = __dwc3_gadget_wakeup(dwc, true);
+	ret = __dwc3_gadget_wakeup(dwc);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2471,14 +2455,10 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 	 */
 	link_state = dwc3_gadget_get_link_state(dwc);
 	if (link_state == DWC3_LINK_STATE_U3) {
-		ret = __dwc3_gadget_wakeup(dwc, false);
-		if (ret) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return -EINVAL;
-		}
-		dwc3_resume_gadget(dwc);
-		dwc->suspended = false;
-		dwc->link_state = DWC3_LINK_STATE_U0;
+		dwc->wakeup_pending_funcs |= BIT(intf_id);
+		ret = __dwc3_gadget_wakeup(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return ret;
 	}
 
 	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
@@ -3429,14 +3409,53 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	return 0;
 }
 
+static int dwc3_gadget_get_reserved_endpoints(struct dwc3 *dwc, const char *propname,
+					      u8 *eps, u8 num)
+{
+	u8 count;
+	int ret;
+
+	if (!device_property_present(dwc->dev, propname))
+		return 0;
+
+	ret = device_property_count_u8(dwc->dev, propname);
+	if (ret < 0)
+		return ret;
+	count = ret;
+
+	ret = device_property_read_u8_array(dwc->dev, propname, eps, min(num, count));
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
 {
+	const char			*propname = "snps,reserved-endpoints";
 	u8				epnum;
+	u8				reserved_eps[DWC3_ENDPOINTS_NUM];
+	u8				count;
+	u8				num;
+	int				ret;
 
 	INIT_LIST_HEAD(&dwc->gadget->ep_list);
 
+	ret = dwc3_gadget_get_reserved_endpoints(dwc, propname,
+						 reserved_eps, ARRAY_SIZE(reserved_eps));
+	if (ret < 0) {
+		dev_err(dwc->dev, "failed to read %s\n", propname);
+		return ret;
+	}
+	count = ret;
+
 	for (epnum = 0; epnum < total; epnum++) {
-		int			ret;
+		for (num = 0; num < count; num++) {
+			if (epnum == reserved_eps[num])
+				break;
+		}
+		if (num < count)
+			continue;
 
 		ret = dwc3_gadget_init_endpoint(dwc, epnum);
 		if (ret)
@@ -3703,6 +3722,8 @@ out:
 
 		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
 			dep = dwc->eps[i];
+			if (!dep)
+				continue;
 
 			if (!(dep->flags & DWC3_EP_ENABLED))
 				continue;
@@ -3852,6 +3873,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	u8			epnum = event->endpoint_number;
 
 	dep = dwc->eps[epnum];
+	if (!dep) {
+		dev_warn(dwc->dev, "spurious event, endpoint %u is not allocated\n", epnum);
+		return;
+	}
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
 		if ((epnum > 1) && !(dep->flags & DWC3_EP_TRANSFER_STARTED))
@@ -4300,6 +4325,8 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 {
 	enum dwc3_link_state	next = evtinfo & DWC3_LINK_STATE_MASK;
 	unsigned int		pwropt;
+	int			ret;
+	int			intf_id;
 
 	/*
 	 * WORKAROUND: DWC3 < 2.50a have an issue when configured without
@@ -4375,7 +4402,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 
 	switch (next) {
 	case DWC3_LINK_STATE_U0:
-		if (dwc->gadget->wakeup_armed) {
+		if (dwc->gadget->wakeup_armed || dwc->wakeup_pending_funcs) {
 			dwc3_gadget_enable_linksts_evts(dwc, false);
 			dwc3_resume_gadget(dwc);
 			dwc->suspended = false;
@@ -4398,6 +4425,18 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	}
 
 	dwc->link_state = next;
+
+	/* Proceed with func wakeup if any interfaces that has requested */
+	while (dwc->wakeup_pending_funcs && (next == DWC3_LINK_STATE_U0)) {
+		intf_id = ffs(dwc->wakeup_pending_funcs) - 1;
+		ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
+						       DWC3_DGCMDPAR_DN_FUNC_WAKE |
+						       DWC3_DGCMDPAR_INTF_SEL(intf_id));
+		if (ret)
+			dev_err(dwc->dev, "Failed to send DN wake for intf %d\n", intf_id);
+
+		dwc->wakeup_pending_funcs &= ~BIT(intf_id);
+	}
 }
 
 static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
@@ -4564,6 +4603,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+			count, evt->length);
+		return IRQ_NONE;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
-- 
2.53.0

