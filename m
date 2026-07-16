Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFB1C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A623084CE8;
	Thu, 16 Jul 2026 18:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZARW5l75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E6A84CEE; Thu, 16 Jul 2026 15:43:15 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA5584D02
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c16036356c1so71334966b.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209393; x=1784814193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v2Uumj+qublkiggtj5T7ljCiF48IiijF81rw8r1OL/k=;
 b=ZARW5l75l5vo9vY6MXzvnRMNVV01IufZHH+SAiy49zuBzF7XT8OpiURFI4qC4KJaf+
 B/1RkqckQTUvsvGe0vxdRAsqysqjUL+wOEyR7k3phmZjuPrZfk7PHq4cx9Pzs3BCb0lm
 QBLWFqbHfOnT/pH+i5KU6T4Qz94wSyZa6K1AxFD1JUrcoSj6Lu/BskUlixkiDQFxQGSF
 TZsjRSCYrgv8HhWVh2dGoIV9c2h8dnskBvdoSfQMotuyfP+RZiLoOTWNSwWWvQv8c03Z
 zpNiqMfjm7L1PQXQu/t+tI82tsWpWwP4WTpx9zBDMTjX+cUYaUFrCvCN2vzwpg7xgimK
 fsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209393; x=1784814193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v2Uumj+qublkiggtj5T7ljCiF48IiijF81rw8r1OL/k=;
 b=KaAYGhl/I8AfjomqLKUu3IHzKjH25+i9t201E1qpq4Klgtd2vR9hBe3DAJYT1O61UG
 3V3r9N8OseTw5kpaB2c8m8hs5zqv+9ZH/8ADVw6Xzt6aLB6uP3ELV5VdjiWLXGWMZnfe
 Bi4Fl4zgX58BfnZHvMCZu+6JsyHVa2appaRi8LbYmSZ5Jeq5k1+r7HlMzj4bq+dWut5q
 dw74UZN7Bf4gh2uehfQ990SEjh5N+4U4ea6jHtDP4Z9Jt78V3jYronAotNleOa1GwF7W
 es2XQvCDNhYiSAstEFcWcLxY8O82OHK51sgnWqE9MMRJrbARZY2vtEyi9od+AIBmGpgk
 Q/qQ==
X-Gm-Message-State: AOJu0Yx1HNFQn9wgxxadmORJNp/ruze35xPjQtsgUQ+Gbd2EFNfsNfQE
 wJUGC3t66onz1Xs+W+OzaVW0mAdW/MtbefvjPFO2Jm1zsoroX0inve2eytIfL14qM9+LJnzw9pR
 yU2PZ
X-Gm-Gg: AfdE7clz8e5NUAQGoaO65dZvtlrqj3V3dlS/BOksCj7hhH8fa4roT1nO/7JQm8+qPN5
 zKL3Gir08SR/hRoymB1EawL4QAJAATlcBFRIysYjgggUi7bqmVXaSrXqPS8i9IpSp418OMQ4K7d
 y9NVsxzCDOZNe333Zl83IgPHD23XCR9ZDCmlwowFuOh+hAcR/rQkX0NZKhFNALNnz4659QiaL0K
 IHfZsp8mPk1Srkn+OyIE+3rWc1bpkou/eUEJHApLfuqyVkDrVC1RQRHdVMXavXuibdxijkyIATg
 swzm/aBQq6qOZell7O67f1gfdOdHFj5Q/3sYSHiCeRYSJCZgJSsQmbHxuU04AZOlHP8YCTrLB2/
 pEg+0IC45yRN1MmWcJBsUDRbpwg/v/5891sUpGE0FuHkmjZuyXmZHmeBCVy9W7ec8BLenxMzQn4
 7OJv0abw9E06HUlfvo/yrHxT4CTLn11+ZE13rh0g==
X-Received: by 2002:a17:906:f5a9:b0:c16:688c:87c8 with SMTP id
 a640c23a62f3a-c168dda17e7mr102771966b.6.1784209392576; 
 Thu, 16 Jul 2026 06:43:12 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e545sm224417266b.49.2026.07.16.06.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:11 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 03/75] usb: dwc3: import from kernel v4.0
Date: Thu, 16 Jul 2026 15:41:33 +0200
Message-ID: <20260716134305.614278-4-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v3.19 to v4.0.

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

List of commits: git log --oneline v3.19..v4.0
Commits imported:
96e5d31244c5 usb: dwc3: dwc3-omap: Fix disable IRQ
bcdea50312b2 usb: dwc3: gadget: use common is_selfpowered
5c7b3b02de76 usb: dwc3: gadget: add missing spin_lock()
73815280a5af usb: dwc3: remove reliance on dev_vdbg()
6bac4ff0a522 usb: dwc3: trace: add trace logs for core and gadget
e9f2aa871c73 usb: dwc3: gadget: WARN() in case of unknown IRQ
4cd8f6d05599 usb: dwc3: gadget: avoid variable shadowing
2cd9ddf77e0d usb: dwc3: pci: code cleanup
3b44ed90cdb2 usb: dwc3: pci: rely on default PM callbacks from PCI driver utility
d3fdcc78b2d6 usb: dwc3: pci: remove registration of NOP PHYs
3cd0e29d5e28 usb: dwc3: Remove current_trb as it is unused
110381e11b5f usb: dwc3: gadget: Remove redundant check
dc93b41a1561 usb: dwc3: Fixed a typo in comments

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c   |  2 +-
 drivers/usb/dwc3/core.h   |  5 ---
 drivers/usb/dwc3/ep0.c    |  2 +-
 drivers/usb/dwc3/gadget.c | 82 ++++++++++++++++++++-------------------
 4 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 25ddc39efad8..9f0e209b8f6c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -345,7 +345,7 @@ static void dwc3_core_num_eps(struct dwc3 *dwc)
 	dwc->num_in_eps = DWC3_NUM_IN_EPS(parms);
 	dwc->num_out_eps = DWC3_NUM_EPS(parms) - dwc->num_in_eps;
 
-	dev_vdbg(dwc->dev, "found %d IN and %d OUT endpoints\n",
+	dwc3_trace(trace_dwc3_core, "found %d IN and %d OUT endpoints",
 			dwc->num_in_eps, dwc->num_out_eps);
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4bb9aa696ede..d201910b892f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -431,7 +431,6 @@ struct dwc3_event_buffer {
  * @dwc: pointer to DWC controller
  * @saved_state: ep state saved during hibernation
  * @flags: endpoint flags (wedged, stalled, ...)
- * @current_trb: index of current used trb
  * @number: endpoint number (1 - 15)
  * @type: set to bmAttributes & USB_ENDPOINT_XFERTYPE_MASK
  * @resource_index: Resource transfer index
@@ -464,8 +463,6 @@ struct dwc3_ep {
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN		(1 << 31)
 
-	unsigned		current_trb;
-
 	u8			number;
 	u8			type;
 	u8			resource_index;
@@ -685,7 +682,6 @@ struct dwc3_scratchpad_array {
  * @is_utmi_l1_suspend: the core asserts output signal
  * 	0	- utmi_sleep_n
  * 	1	- utmi_l1_suspend_n
- * @is_selfpowered: true when we are selfpowered
  * @is_fpga: true when we are using the FPGA board
  * @needs_fifo_resize: not all users might want fifo resizing, flag it
  * @pullups_connected: true when Run/Stop bit is set
@@ -809,7 +805,6 @@ struct dwc3 {
 	unsigned		has_hibernation:1;
 	unsigned		has_lpm_erratum:1;
 	unsigned		is_utmi_l1_suspend:1;
-	unsigned		is_selfpowered:1;
 	unsigned		is_fpga:1;
 	unsigned		needs_fifo_resize:1;
 	unsigned		pullups_connected:1;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 1bc77a3b4997..2ef3c8d6a9db 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -344,7 +344,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		/*
 		 * LTM will be set once we know how to set this in HW.
 		 */
-		usb_status |= dwc->is_selfpowered << USB_DEVICE_SELF_POWERED;
+		usb_status |= dwc->gadget.is_selfpowered;
 
 		if (dwc->speed == DWC3_DSTS_SUPERSPEED) {
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8f65ab3a3b92..a03a485205c7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -139,7 +139,8 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 		udelay(5);
 	}
 
-	dev_vdbg(dwc->dev, "link state change request timed out\n");
+	dwc3_trace(trace_dwc3_gadget,
+			"link state change request timed out");
 
 	return -ETIMEDOUT;
 }
@@ -219,7 +220,7 @@ int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc)
 
 		fifo_size |= (last_fifo_depth << 16);
 
-		dev_vdbg(dwc->dev, "%s: Fifo Addr %04x Size %d\n",
+		dwc3_trace(trace_dwc3_gadget, "%s: Fifo Addr %04x Size %d",
 				dep->name, last_fifo_depth, fifo_size & 0xffff);
 
 		dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(num), fifo_size);
@@ -287,7 +288,8 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DGCMD);
 		if (!(reg & DWC3_DGCMD_CMDACT)) {
-			dev_vdbg(dwc->dev, "Command Complete --> %d\n",
+			dwc3_trace(trace_dwc3_gadget,
+					"Command Complete --> %d",
 					DWC3_DGCMD_STATUS(reg));
 			return 0;
 		}
@@ -297,8 +299,11 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 		 * interrupt context.
 		 */
 		timeout--;
-		if (!timeout)
+		if (!timeout) {
+			dwc3_trace(trace_dwc3_gadget,
+					"Command Timed Out");
 			return -ETIMEDOUT;
+		}
 		udelay(1);
 	} while (1);
 }
@@ -320,7 +325,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DEPCMD(ep));
 		if (!(reg & DWC3_DEPCMD_CMDACT)) {
-			dev_vdbg(dwc->dev, "Command Complete --> %d\n",
+			dwc3_trace(trace_dwc3_gadget,
+					"Command Complete --> %d",
 					DWC3_DEPCMD_STATUS(reg));
 			return 0;
 		}
@@ -330,8 +336,11 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		 * interrupt context.
 		 */
 		timeout--;
-		if (!timeout)
+		if (!timeout) {
+			dwc3_trace(trace_dwc3_gadget,
+					"Command Timed Out");
 			return -ETIMEDOUT;
+		}
 
 		udelay(1);
 	} while (1);
@@ -352,9 +361,6 @@ static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 	if (dep->trb_pool)
 		return 0;
 
-	if (dep->number == 0 || dep->number == 1)
-		return 0;
-
 	dep->trb_pool = dma_alloc_coherent(dwc->dev,
 			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
 			&dep->trb_pool_dma, GFP_KERNEL);
@@ -492,7 +498,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 	u32			reg;
 	int			ret;
 
-	dev_vdbg(dwc->dev, "Enabling %s\n", dep->name);
+	dwc3_trace(trace_dwc3_gadget, "Enabling %s", dep->name);
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
 		ret = dwc3_gadget_start_config(dwc, dep);
@@ -729,10 +735,9 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		struct dwc3_request *req, dma_addr_t dma,
 		unsigned length, unsigned last, unsigned chain, unsigned node)
 {
-	struct dwc3		*dwc = dep->dwc;
 	struct dwc3_trb		*trb;
 
-	dev_vdbg(dwc->dev, "%s: req %p dma %08llx length %d%s%s\n",
+	dwc3_trace(trace_dwc3_gadget, "%s: req %p dma %08llx length %d%s%s",
 			dep->name, req, (unsigned long long) dma,
 			length, last ? " last" : "",
 			chain ? " chain" : "");
@@ -934,7 +939,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
 	u32				cmd;
 
 	if (start_new && (dep->flags & DWC3_EP_BUSY)) {
-		dev_vdbg(dwc->dev, "%s: endpoint busy\n", dep->name);
+		dwc3_trace(trace_dwc3_gadget, "%s: endpoint busy", dep->name);
 		return -EBUSY;
 	}
 	dep->flags &= ~DWC3_EP_PENDING_REQUEST;
@@ -1005,8 +1010,9 @@ static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
 	u32 uf;
 
 	if (list_empty(&dep->request_list)) {
-		dev_vdbg(dwc->dev, "ISOC ep %s run out for requests.\n",
-			dep->name);
+		dwc3_trace(trace_dwc3_gadget,
+				"ISOC ep %s run out for requests",
+				dep->name);
 		dep->flags |= DWC3_EP_PENDING_REQUEST;
 		return;
 	}
@@ -1113,15 +1119,10 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 * handled.
 	 */
 	if (dep->stream_capable) {
-		int	ret;
-
 		ret = __dwc3_gadget_kick_transfer(dep, 0, true);
-		if (ret && ret != -EBUSY) {
-			struct dwc3	*dwc = dep->dwc;
-
+		if (ret && ret != -EBUSY)
 			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
 					dep->name);
-		}
 	}
 
 	return 0;
@@ -1152,8 +1153,6 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 		goto out;
 	}
 
-	dev_vdbg(dwc->dev, "queing request %p to %s length %d\n",
-			request, ep->name, request->length);
 	trace_dwc3_ep_queue(req);
 
 	ret = __dwc3_gadget_ep_queue(dep, req);
@@ -1416,7 +1415,7 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 	unsigned long		flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc->is_selfpowered = !!is_selfpowered;
+	g->is_selfpowered = !!is_selfpowered;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
@@ -1468,7 +1467,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 		udelay(1);
 	} while (1);
 
-	dev_vdbg(dwc->dev, "gadget %s data soft-%s\n",
+	dwc3_trace(trace_dwc3_gadget, "gadget %s data soft-%s",
 			dwc->gadget_driver
 			? dwc->gadget_driver->function : "no-function",
 			is_on ? "connect" : "disconnect");
@@ -1688,7 +1687,7 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 
 		dep->endpoint.name = dep->name;
 
-		dev_vdbg(dwc->dev, "initializing %s\n", dep->name);
+		dwc3_trace(trace_dwc3_gadget, "initializing %s", dep->name);
 
 		if (epnum == 0 || epnum == 1) {
 			usb_ep_set_maxpacket_limit(&dep->endpoint, 512);
@@ -1725,13 +1724,15 @@ static int dwc3_gadget_init_endpoints(struct dwc3 *dwc)
 
 	ret = dwc3_gadget_init_hw_endpoints(dwc, dwc->num_out_eps, 0);
 	if (ret < 0) {
-		dev_vdbg(dwc->dev, "failed to allocate OUT endpoints\n");
+		dwc3_trace(trace_dwc3_gadget,
+				"failed to allocate OUT endpoints");
 		return ret;
 	}
 
 	ret = dwc3_gadget_init_hw_endpoints(dwc, dwc->num_in_eps, 1);
 	if (ret < 0) {
-		dev_vdbg(dwc->dev, "failed to allocate IN endpoints\n");
+		dwc3_trace(trace_dwc3_gadget,
+				"failed to allocate IN endpoints");
 		return ret;
 	}
 
@@ -1977,7 +1978,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		} else {
 			int ret;
 
-			dev_vdbg(dwc->dev, "%s: reason %s\n",
+			dwc3_trace(trace_dwc3_gadget, "%s: reason %s",
 					dep->name, event->status &
 					DEPEVT_STATUS_TRANSFER_ACTIVE
 					? "Transfer Active"
@@ -2001,7 +2002,8 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 
 		switch (event->status) {
 		case DEPEVT_STREAMEVT_FOUND:
-			dev_vdbg(dwc->dev, "Stream %d found and started\n",
+			dwc3_trace(trace_dwc3_gadget,
+					"Stream %d found and started",
 					event->parameters);
 
 			break;
@@ -2015,7 +2017,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		dev_dbg(dwc->dev, "%s FIFO Overrun\n", dep->name);
 		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
-		dev_vdbg(dwc->dev, "Endpoint Command Complete\n");
+		dwc3_trace(trace_dwc3_gadget, "Endpoint Command Complete");
 		break;
 	}
 }
@@ -2043,6 +2045,7 @@ static void dwc3_resume_gadget(struct dwc3 *dwc)
 	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->resume(&dwc->gadget);
+		spin_lock(&dwc->lock);
 	}
 }
 
@@ -2079,7 +2082,7 @@ static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
 	 * We have discussed this with the IP Provider and it was
 	 * suggested to giveback all requests here, but give HW some
 	 * extra time to synchronize with the interconnect. We're using
-	 * an arbitraty 100us delay for that.
+	 * an arbitrary 100us delay for that.
 	 *
 	 * Note also that a similar handling was tested by Synopsys
 	 * (thanks a lot Paul) and nothing bad has come out of it.
@@ -2389,7 +2392,8 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 			(pwropt != DWC3_GHWPARAMS1_EN_PWROPT_HIB)) {
 		if ((dwc->link_state == DWC3_LINK_STATE_U3) &&
 				(next == DWC3_LINK_STATE_RESUME)) {
-			dev_vdbg(dwc->dev, "ignoring transition U3 -> Resume\n");
+			dwc3_trace(trace_dwc3_gadget,
+					"ignoring transition U3 -> Resume");
 			return;
 		}
 	}
@@ -2511,22 +2515,22 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_EOPF:
-		dev_vdbg(dwc->dev, "End of Periodic Frame\n");
+		dwc3_trace(trace_dwc3_gadget, "End of Periodic Frame");
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
-		dev_vdbg(dwc->dev, "Start of Periodic Frame\n");
+		dwc3_trace(trace_dwc3_gadget, "Start of Periodic Frame");
 		break;
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
-		dev_vdbg(dwc->dev, "Erratic Error\n");
+		dwc3_trace(trace_dwc3_gadget, "Erratic Error");
 		break;
 	case DWC3_DEVICE_EVENT_CMD_CMPL:
-		dev_vdbg(dwc->dev, "Command Complete\n");
+		dwc3_trace(trace_dwc3_gadget, "Command Complete");
 		break;
 	case DWC3_DEVICE_EVENT_OVERFLOW:
-		dev_vdbg(dwc->dev, "Overflow\n");
+		dwc3_trace(trace_dwc3_gadget, "Overflow");
 		break;
 	default:
-		dev_dbg(dwc->dev, "UNKNOWN IRQ %d\n", event->type);
+		dev_WARN(dwc->dev, "UNKNOWN IRQ %d\n", event->type);
 	}
 }
 
-- 
2.53.0

