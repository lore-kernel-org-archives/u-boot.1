Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1B8C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB1484B2C;
	Mon, 29 Jun 2026 10:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eUJsSCoZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E307784B2B; Mon, 29 Jun 2026 10:48:00 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B91D84B0C
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-39b093b42b4so6667651fa.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722878; x=1783327678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6G73VqcjCCrTrH99BmssfYmL+ynWpTgV0z/wb98gU0Q=;
 b=eUJsSCoZ+dNTRHD8TDu7k//lxUr/EPs4fjntTOnUvdj3HeJ6o6QgZyl81dDn9iF3Sx
 TApR+NvvMG2uAfasdBZ84wjGa9waemTjZ85w1yPnAuLSXRNzA7lWHJqUduXR8U4EcOE+
 OVowPM4cwsUExqGJtHPAgmZoWXNOU2xaCQLP19WxJ3IarkoSmsjB2bTbirQTVHa+hsEQ
 nMOy3cuIzqPlGqMl0c4sJuxreP0a8iaeGZw4Kl33vR54ouHlws3JhH64jzjsHz1fkxXY
 FpDNyRLX1xjcruFyjU/zSaNs6eipsp3HisBr1GalV+3/0ZX/+KAFt3KUPtWWxg+1pq3J
 FsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722878; x=1783327678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6G73VqcjCCrTrH99BmssfYmL+ynWpTgV0z/wb98gU0Q=;
 b=q34EL1RA/XPYZUEbZKgfV36komFHGu6PQxf0lLUOKYSkrH5oYLA+QqrScLj6fJPV9L
 75V8QbB/oF5hQQAuag0pbMG8KSzOXH15DEqh9DHD7ac1uKjXxRixHKPU1dibmsWWYPcK
 NqAwZHjoRv5OsuYb5CHY1wMG5rub8XmIaKupxBjnaFlE2UfcaleUQBeQGn2sQ2R94SSR
 CIxx/PILTYD1I9iMIcbH6+c1OxldM+ak/etjwUIB4vq/ILA7WbFV7Mgr5KIzhpz+cSdN
 059YPJSg5nEnZMvcmH78+CbdB6nsGvGMbBlxhGjiPXKPDmMZ/cIbQbFwRGGDXMu0NNkb
 VJ5g==
X-Gm-Message-State: AOJu0Yw/oJo++BCNL/0kdWONbLzeoFDgUU39gNismWqmm452mwAQCoIw
 BF+i4B3/Z42fsbxHKHnaNs5qMks5F4ZV5lKK2yfEwDFKfwUVR1X1Yt8XQLfVyQvPOJSlpgCKl+I
 15O1cK3M=
X-Gm-Gg: AfdE7cn6aZOkw3NM398s1jE2NIj2uLSlfeUu+EX8sbLj7J94qqPHNyzb7L8w5NLiX7R
 1hTC80ddcY3Ua3ha+S6uJD1+U8I3sruH/1oG2K1Wj5+JAXOAXkq5zvS2d2vIvmskhjbfdTT3WjV
 a8M7C6jMOCyWf9PsGdvT4PylmksKXwvTzOhCr60L9wB+AO7u4vh9i2DoYQMUabdtzD94aaUTQku
 /oFz/5xp37JeCDonwK/NcFrzAbhkOASx20SYO/9NWDxXDUJF3+NfK5uJtfNy6keFjVpfWebhd8x
 emFKJUHdOyZrpn1IDSx7wCdJ2x5plZMDcDcGzDoDrkEwz3iivh6myhOJkcbM1act3BQi5Oxoyid
 JcnBnNCYcMZmNW1ePvQwdm456BwWO4jmzKosCu2lbZ5GSAgSTIH9xQ1GlzPH6RYasco2JrdzUgh
 9K3d7Mj9vS4+Izu7Quo/feP8TEFjgr+ySZrZiTpLO+oCTRhx6uVEK++at5aZ9ED20OHfMr8xjfb
 RN0GhJvb3tgVmNJzckF
X-Received: by 2002:a05:651c:210b:b0:39a:fc8e:84e2 with SMTP id
 38308e7fff4ca-39afc8e88e9mr11352571fa.7.1782722877761; 
 Mon, 29 Jun 2026 01:47:57 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:47:55 -0700 (PDT)
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
Subject: [PATCH v4 59/64] usb: dwc3: import from kernel v6.15
Date: Mon, 29 Jun 2026 10:44:35 +0200
Message-ID: <20260629084507.3254232-60-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.14 to v6.15.

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

List of commits: git log --oneline v6.14..v6.15
Commits imported:
2372f1caeca4 usb: dwc3: gadget: Make gadget_wakeup asynchronous
63ccd26cd1f6 usb: dwc3: gadget: check that event count does not exceed event buffer length
38d6e60b6f3a usb: dwc3: xilinx: Prevent spike in reset signal
042c3dd1f2d3 usb: dwc3: Don't use %pK through printk
525b139fb403 Merge v6.14-rc6 into usb-next
811d22141369 usb: dwc3: exynos: add support for exynos7870
f8da37e46253 Merge 6.14-rc3 into usb-next
07959ad5775f USB: dwc3: Use syscon_regmap_lookup_by_phandle_args
461f24bff868 usb: dwc3: gadget: Avoid using reserved endpoints on Intel Merrifield
5425191f85fe usb: dwc3: gadget: Add support for snps,reserved-endpoints property
eafba0205426 usb: dwc3: gadget: Refactor loop to avoid NULL endpoints

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
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
2.43.0

