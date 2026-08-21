Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AADC5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70A4860A9A;
	Fri, 21 Aug 2026 13:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSSwFEzWlRs3; Fri, 21 Aug 2026 13:11:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317909;
	bh=vBYZtatKzkkrmKQ08bgHOJGsWnMoslJwpJ9HI646vRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sHBj2JhobuW3JdNUSd9WJvBW0k/qPaNJ7dECYQAsxhQb0Yi99ADFbA1clIWYKiOj2
	 9SoD2SspvgmQkxk2UDS/Pbdn6ZJoZWpqMLwqDxTIrkgCJiuImigtv9PYFnIyu+M1oa
	 1OgBZ2+08JjiT7SAXpNKuhW7CsZ0ED3nSDmslWGu//lYjyz4ZUq9OePrEwm2aKmiI+
	 litTBg31MvGJimLwaJ9xuVIsvdedW5lPauJWspTdgp9v6qYDMembSYn1GznL/nlvxq
	 yYwlsnUhJBISGoZm7wyxz20BeEpibbEhknayjbTBs9MD/zh5+D4n7ttVYtayBkvjKp
	 8+mHiAvC0teWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22D6360A92;
	Fri, 21 Aug 2026 13:11:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A0E85476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 92DC06067B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TBH1fNfv4vQN for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:50:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=h6BXBqAu
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3329460661
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:54 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15f025146dso6929966b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302253; x=1787907053;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vBYZtatKzkkrmKQ08bgHOJGsWnMoslJwpJ9HI646vRc=;
 b=h6BXBqAu1isnqqv4/lhbQAYCIifpl03o2aCBIbyksZiIyjlJ7Ntr4BdssMdZdKORrI
 Jdt4ZlfnFcBxP5N6dT48+41x4mWBoIIY6aEzYSrrbgYZUStPIav+BKg/UpG8iBSDsq+s
 4hU29axsay+zAUAd96DV/FPA57u1WBjYQJfyUxeFgh3tlT9+Xq9y7E8eG2jTZGhjFtAX
 25HBMS8oifSQ8+nHn5GXd0ZMR34I6gU60vwf6iMqdT1UVaHY9Q08iXCizKwgbIh2dRLN
 pACMWtVcESwlURj+MpEIRFlROQLn5VjQL6wn71jAw4zdRb90amvaGwoy48btQjRxD6Zg
 iaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302253; x=1787907053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vBYZtatKzkkrmKQ08bgHOJGsWnMoslJwpJ9HI646vRc=;
 b=sot6/SW270JEaMLj6LcELiVfKjodDiotblOhbdK3zXoRRMr1hw3QCR1LTEvzKwQJmt
 oQ7QtXRJb68QJTgobHlXKD8kgh0AYv0523dyZMfebto0qqFhzKP7ns/myFxPYEpyQ3hU
 KJETt/W7DamJtBJ450YhfJy9TcLol6cNMeOCzpoZAUaB1UTqA7oNCqAeGzdZ7WeWkBbW
 ykFzn3XzbrnvFlz/AdKzB8EsCt81qqNvwqxVF4yIdX/iyedLerczvNEDHcc8AhizMp86
 ZjgZY4xnyjJgDLqEWzjr3e4QYUIItJfgSxeweFsBPp/kA7JFgkQDqa6T3d/P6j/45EPa
 90oA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpwzkkkyx7wUVYc3hg7tsrz7dAKazBx5bKNmK4F7A0cUZJL5YFmE6qqEeUayj16Wr1h7rVDNS4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nwMBxKKf2ESVdSxZGL6kO5Lc50vnSeueOd4utwW463dMUrvzKv
 DbdS2vwompkfXH6+5BG8r1fpz+FM/48QRY1HveJwEM6zN/Q2wf+YbewWr1sg+uyINHQ=
X-Gm-Gg: AR+sD121DI6ojtyMuPgbgLpZImieTxn1EQHsEqyfwtzqev5uh1Hr8oZr83CCHyknuWl
 LoFQF+ZLI9lJSj+JEAFWUanJZ1wW06Ht0qfeBPl5sOWXaVi0RaQvbozhBXl0cOJqb2RcpsVk7Z4
 IhhbGWS97+U8aelQaHvqi0p/CUrWvV9rtS8z15ics7AVprH63huDlC7T8/keBrc8yWD6jRypYo7
 7ERTto0TIE1n+2EevzZ/KnX2c/H7serxVcmRaev1LsQuuY/1NHaGuuLanDMbIlgEjmYfrxJs2R7
 JLvxpfl8Gm8cCLM1PbcC+fc4HsIDVKltIR2Sf4IlOVEK9WNg6oV2sM3MDs6aOmmsNgbPEHTpgZF
 5R/D2tbq30BDsz6FKDNR4CpKCPqrVyN4JlH3jpgjulZ7hgwprJT8IYeIcZRU+fyDyiKcezkELeY
 p/QZIcOuT7GBhYW2JFt6zYYL5VJZrLawdD/ld9Kv3yK7ZUXEGaRWG/ywykRHc3CLj81vf5lyBwP
 jwj/8ZAdNEEaqWj2d0Sn9t4AxnDQTihWYY=
X-Received: by 2002:a17:907:1b03:b0:c21:71b0:308 with SMTP id
 a640c23a62f3a-c2469f9a125mr253386366b.0.1787302252719; 
 Fri, 21 Aug 2026 01:50:52 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b09349sm360134366b.19.2026.08.21.01.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:50:52 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 04/87] usb: dwc3: import from kernel v4.0
Date: Fri, 21 Aug 2026 10:46:40 +0200
Message-ID: <20260821084829.2070426-5-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:39 +0000
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

Sync Linux kernel dwc3 changes from v3.19 to v4.0.

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

List of commits: git log --oneline v3.19..v4.0
Commits imported:
bcdea50312b2 usb: dwc3: gadget: use common is_selfpowered
5c7b3b02de76 usb: dwc3: gadget: add missing spin_lock()
73815280a5af usb: dwc3: remove reliance on dev_vdbg()
e9f2aa871c73 usb: dwc3: gadget: WARN() in case of unknown IRQ
4cd8f6d05599 usb: dwc3: gadget: avoid variable shadowing
3cd0e29d5e28 usb: dwc3: Remove current_trb as it is unused
110381e11b5f usb: dwc3: gadget: Remove redundant check
dc93b41a1561 usb: dwc3: Fixed a typo in comments

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

