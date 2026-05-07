Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04EDCD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D445E84A7B;
	Thu,  7 May 2026 11:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KFkT5nXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09CDF84AA0; Thu,  7 May 2026 11:30:08 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E651184AC0
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5a87782588cso860074e87.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146199; x=1778750999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqsT49nZFxlzofNyURpqsf8ukpLq2jEAVOH2wgTLWYg=;
 b=KFkT5nXOeiuq87mW1mdjPEX3hAkt344x9izmMBLki2TnmKgG3ywSUrW5Kj6XvYp+BC
 lY0NRTSvpxMbIynN0EwS++lf7M1GHe7OCzdFJl3AtQrJ8c6yUkM0VZNeE/r3PrRi6Kwt
 2H1JtECP6x9xfw72Zf+aOfUZQdeFqdOCjGHLPb4xEZmvXKKpKhv8UpO9SpRLqcN30a1h
 MIvVyMg903SYuVKMrADxpRewlqzO68jU3WNZS6BSd4f1wFbT/2d8Q7tEJ5Hq22MnJJGl
 mTTGfNphGPGFZacgYdgVXg9firaG5m43AoS6iaPlu00gD/LWeY6u7visBu5qxnMlr3ck
 Atnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146199; x=1778750999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CqsT49nZFxlzofNyURpqsf8ukpLq2jEAVOH2wgTLWYg=;
 b=ikasw3uk0xmp5TyUfmUh/6Qp/mLjR2aSwruigaCyAi7w//7kSL5um7bI9M2Ka+X5bD
 RVJlCk5HtUHoN4GC0L8HffyCYQO1Jkq/ib2auOhe82GnbEviWjzUhqVkfGhJp/hYbi9v
 uJ5nsM+20u1mm1HG4BUrrBVshV6lLiY0DNc4Vj40dkFDpbgoSdIn0d75gOAxCYNWBXu2
 O0DJmQSSTULUpYJrncul0EOPurx+ZjDFnrbyl/xm2zSX/vhsfPIWEhcGUPGgFYWoKeRD
 /UpBmimZ+2SJuHtGCu0skeDJDrgitxWyCqR8m6ON2aFb7F1IZyuSIU/RHCQfS739OlPu
 9aWg==
X-Gm-Message-State: AOJu0Yz0ie+LXxKcTtRNnYbzkycFZSYRPuH0LBxvPftf3kB0Dk4QGGxv
 R2pb2t1kZetTSnlfD9uHomM4s1fRkZwRBao1ZmAHvNzaFGPHV9QxEzuMghv53tYxZlFcrcduhSi
 HSmB3hsAGeA==
X-Gm-Gg: AeBDietaG5KYzZqSurALUKUMUNTOEtAIFvdmwgo5Zgpl/tWXxIs1nHArGyi0Cqi95lL
 77sEUzhs8hhGfRtnNNc4QKCO0eTVSVi3CFFDu+oMNUBXpjSfQ0KReMZNB27H36jsQkBCkxX75wx
 aPR8M4e4Mx/VFycK/TPUznPHjKMlHbgH8uAWpYujp/inahQqKDy0Ne+khVGz+hq1qALOHdBeAYC
 xWueGOrx8trZm7UkqGoCAXpVScbZWGANL3of+P6OEqckFa51E1w66XuLQ/rICOZqi4X3S70htnB
 VFWwgYoGBfo7FQXdH30+4n0NT8SEQoVThGQoS93nwRcVOe6IcJtYWa+JcuGFX/d2itU69Pa9T5R
 xl9bjdimwTnUIldHtNEW4sVF4W8KkqEWnpH3OjEP6lAiv/oOiOPMympb/FfrMR8Es3Z3SCFcwgr
 ReEpU+fS+fem2oQIP6P7f3VjnhlQ7HUWsQEAedrUmKxCJ9Uu52ARMoQ2Ll24tynT49snsJv2HsB
 xJyOzXj28cCzwxJfgClDfRH+uuYmVVH38VTUUPKl0rxQacvKeDO
X-Received: by 2002:ac2:4c53:0:b0:5a3:feed:31cc with SMTP id
 2adb3069b0e04-5a887ce5df6mr2369227e87.24.1778146198927; 
 Thu, 07 May 2026 02:29:58 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:58 -0700 (PDT)
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
Subject: [RFC PATCH v2 25/64] usb: dwc3: import from kernel v5.1
Date: Thu,  7 May 2026 11:27:32 +0200
Message-ID: <20260507092843.358908-26-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.0 to v5.1.

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

List of commits: git log --oneline v5.0..v5.1
Commits imported:
7ae622c978db usb: dwc3: pci: add support for Comet Lake PCH ID
98bba546e82d usb: dwc3: drd: Defer probe if extcon device is not found
dc8b2a691dc8 Merge tag 'usb-for-v5.1' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
c7152763f02e usb: dwc3: Reset num_trbs after skipping
c5353b225df9 usb: dwc3: gadget: don't enable interrupt when disabling endpoint
15e99b13b44b Merge 5.0-rc6 into usb-next
9c7ebc99b382 usb: dwc3: haps: Workaround matching VID PID
1381a5113caf usb: dwc3: debug: purge usage of strcat
7790b3556fcc usb: dwc3: trace: pass trace buffer size to decoding functions
3aec99154db3 usb: dwc3: gadget: remove DWC3_EP_END_TRANSFER_PENDING
9f45581f5eec usb: dwc3: gadget: early giveback if End Transfer already completed
974a1368c33e usb: dwc3: gadget: don't use resource_index as a flag
acbfa6c26f21 usb: dwc3: gadget: clear DWC3_EP_TRANSFER_STARTED on cmd complete
7c3d7dc89e57 usb: dwc3: gadget: remove req->started flag
b2b6d601365a usb: dwc3: gadget: prevent dwc3_request from being queued twice
a3af5e3ad3f1 usb: dwc3: gadget: add dwc3_request status tracking
eca6b49430c6 usb: dwc3: keystone: Add support for ti,am654-dwc3
169e3b68cadb usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded
54c9da1bcec4 usb: dwc3: qcom: Add support for MSM8998
c9381e185fdc Merge 5.0-rc4 into usb-next
cae8dc3b685f USB: add missing SPDX lines to Kconfig and Makefiles

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.h   |  12 ++-
 drivers/usb/dwc3/debug.h  | 156 +++++++++++++++++++++-----------------
 drivers/usb/dwc3/gadget.c |  65 ++++++++--------
 drivers/usb/dwc3/gadget.h |   4 +-
 4 files changed, 130 insertions(+), 107 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index df876418cb78..1528d395b156 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -692,7 +692,6 @@ struct dwc3_ep {
 #define DWC3_EP_WEDGE		BIT(2)
 #define DWC3_EP_TRANSFER_STARTED BIT(3)
 #define DWC3_EP_PENDING_REQUEST	BIT(5)
-#define DWC3_EP_END_TRANSFER_PENDING	BIT(7)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN		BIT(31)
@@ -863,6 +862,7 @@ struct dwc3_hwparams {
  * @num_pending_sgs: counter to pending sgs
  * @num_queued_sgs: counter to the number of sgs which already got queued
  * @remaining: amount of data remaining
+ * @status: internal dwc3 request status tracking
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
  * @trb_dma: DMA address of @trb
@@ -871,7 +871,6 @@ struct dwc3_hwparams {
  *	or unaligned OUT)
  * @direction: IN or OUT direction flag
  * @mapped: true when request has been dma-mapped
- * @started: request is started
  */
 struct dwc3_request {
 	struct usb_request	request;
@@ -883,6 +882,14 @@ struct dwc3_request {
 	unsigned		num_pending_sgs;
 	unsigned int		num_queued_sgs;
 	unsigned		remaining;
+
+	unsigned int		status;
+#define DWC3_REQUEST_STATUS_QUEUED	0
+#define DWC3_REQUEST_STATUS_STARTED	1
+#define DWC3_REQUEST_STATUS_CANCELLED	2
+#define DWC3_REQUEST_STATUS_COMPLETED	3
+#define DWC3_REQUEST_STATUS_UNKNOWN	-1
+
 	u8			epnum;
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
@@ -892,7 +899,6 @@ struct dwc3_request {
 	unsigned		needs_extra_trb:1;
 	unsigned		direction:1;
 	unsigned		mapped:1;
-	unsigned		started:1;
 };
 
 /*
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 4f75ab3505b7..6759a7efd8d5 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -193,65 +193,69 @@ static inline const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
  * dwc3_gadget_event_string - returns event name
  * @event: the event code
  */
-static inline const char *
-dwc3_gadget_event_string(char *str, const struct dwc3_event_devt *event)
+static inline const char *dwc3_gadget_event_string(char *str, size_t size,
+		const struct dwc3_event_devt *event)
 {
 	enum dwc3_link_state state = event->event_info & DWC3_LINK_STATE_MASK;
 
 	switch (event->type) {
 	case DWC3_DEVICE_EVENT_DISCONNECT:
-		sprintf(str, "Disconnect: [%s]",
+		snprintf(str, size, "Disconnect: [%s]",
 				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_RESET:
-		sprintf(str, "Reset [%s]", dwc3_gadget_link_string(state));
+		snprintf(str, size, "Reset [%s]",
+				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_CONNECT_DONE:
-		sprintf(str, "Connection Done [%s]",
+		snprintf(str, size, "Connection Done [%s]",
 				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
-		sprintf(str, "Link Change [%s]",
+		snprintf(str, size, "Link Change [%s]",
 				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_WAKEUP:
-		sprintf(str, "WakeUp [%s]", dwc3_gadget_link_string(state));
+		snprintf(str, size, "WakeUp [%s]",
+				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_EOPF:
-		sprintf(str, "End-Of-Frame [%s]",
+		snprintf(str, size, "End-Of-Frame [%s]",
 				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
-		sprintf(str, "Start-Of-Frame [%s]",
+		snprintf(str, size, "Start-Of-Frame [%s]",
 				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
-		sprintf(str, "Erratic Error [%s]",
+		snprintf(str, size, "Erratic Error [%s]",
 				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_CMD_CMPL:
-		sprintf(str, "Command Complete [%s]",
+		snprintf(str, size, "Command Complete [%s]",
 				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_OVERFLOW:
-		sprintf(str, "Overflow [%s]", dwc3_gadget_link_string(state));
+		snprintf(str, size, "Overflow [%s]",
+				dwc3_gadget_link_string(state));
 		break;
 	default:
-		sprintf(str, "UNKNOWN");
+		snprintf(str, size, "UNKNOWN");
 	}
 
 	return str;
 }
 
-static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str)
+static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str,
+		size_t size)
 {
 	switch (t & USB_RECIP_MASK) {
 	case USB_RECIP_INTERFACE:
-		sprintf(str, "Get Interface Status(Intf = %d, Length = %d)",
-			i, l);
+		snprintf(str, size, "Get Interface Status(Intf = %d, Length = %d)",
+				i, l);
 		break;
 	case USB_RECIP_ENDPOINT:
-		sprintf(str, "Get Endpoint Status(ep%d%s)",
+		snprintf(str, size, "Get Endpoint Status(ep%d%s)",
 			i & ~USB_DIR_IN,
 			i & USB_DIR_IN ? "in" : "out");
 		break;
@@ -259,11 +263,11 @@ static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str)
 }
 
 static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,
-						 __u16 i, char *str)
+		__u16 i, char *str, size_t size)
 {
 	switch (t & USB_RECIP_MASK) {
 	case USB_RECIP_DEVICE:
-		sprintf(str, "%s Device Feature(%s%s)",
+		snprintf(str, size, "%s Device Feature(%s%s)",
 			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
 			({char *s;
 				switch (v) {
@@ -311,13 +315,13 @@ static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,
 				} s; }) : "");
 		break;
 	case USB_RECIP_INTERFACE:
-		sprintf(str, "%s Interface Feature(%s)",
+		snprintf(str, size, "%s Interface Feature(%s)",
 			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
 			v == USB_INTRF_FUNC_SUSPEND ?
 			"Function Suspend" : "UNKNOWN");
 		break;
 	case USB_RECIP_ENDPOINT:
-		sprintf(str, "%s Endpoint Feature(%s ep%d%s)",
+		snprintf(str, size, "%s Endpoint Feature(%s ep%d%s)",
 			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
 			v == USB_ENDPOINT_HALT ? "Halt" : "UNKNOWN",
 			i & ~USB_DIR_IN,
@@ -326,15 +330,15 @@ static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,
 	}
 }
 
-static inline void dwc3_decode_set_address(__u16 v, char *str)
+static inline void dwc3_decode_set_address(__u16 v, char *str, size_t size)
 {
-	sprintf(str, "Set Address(Addr = %02x)", v);
+	snprintf(str, size, "Set Address(Addr = %02x)", v);
 }
 
 static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v,
-						  __u16 i, __u16 l, char *str)
+		__u16 i, __u16 l, char *str, size_t size)
 {
-	sprintf(str, "%s %s Descriptor(Index = %d, Length = %d)",
+	snprintf(str, size, "%s %s Descriptor(Index = %d, Length = %d)",
 		b == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
 		({ char *s;
 			switch (v >> 8) {
@@ -393,87 +397,92 @@ static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v,
 }
 
 
-static inline void dwc3_decode_get_configuration(__u16 l, char *str)
+static inline void dwc3_decode_get_configuration(__u16 l, char *str,
+		size_t size)
 {
-	sprintf(str, "Get Configuration(Length = %d)", l);
+	snprintf(str, size, "Get Configuration(Length = %d)", l);
 }
 
-static inline void dwc3_decode_set_configuration(__u8 v, char *str)
+static inline void dwc3_decode_set_configuration(__u8 v, char *str, size_t size)
 {
-	sprintf(str, "Set Configuration(Config = %d)", v);
+	snprintf(str, size, "Set Configuration(Config = %d)", v);
 }
 
-static inline void dwc3_decode_get_intf(__u16 i, __u16 l, char *str)
+static inline void dwc3_decode_get_intf(__u16 i, __u16 l, char *str,
+		size_t size)
 {
-	sprintf(str, "Get Interface(Intf = %d, Length = %d)", i, l);
+	snprintf(str, size, "Get Interface(Intf = %d, Length = %d)", i, l);
 }
 
-static inline void dwc3_decode_set_intf(__u8 v, __u16 i, char *str)
+static inline void dwc3_decode_set_intf(__u8 v, __u16 i, char *str, size_t size)
 {
-	sprintf(str, "Set Interface(Intf = %d, Alt.Setting = %d)", i, v);
+	snprintf(str, size, "Set Interface(Intf = %d, Alt.Setting = %d)", i, v);
 }
 
-static inline void dwc3_decode_synch_frame(__u16 i, __u16 l, char *str)
+static inline void dwc3_decode_synch_frame(__u16 i, __u16 l, char *str,
+		size_t size)
 {
-	sprintf(str, "Synch Frame(Endpoint = %d, Length = %d)", i, l);
+	snprintf(str, size, "Synch Frame(Endpoint = %d, Length = %d)", i, l);
 }
 
-static inline void dwc3_decode_set_sel(__u16 l, char *str)
+static inline void dwc3_decode_set_sel(__u16 l, char *str, size_t size)
 {
-	sprintf(str, "Set SEL(Length = %d)", l);
+	snprintf(str, size, "Set SEL(Length = %d)", l);
 }
 
-static inline void dwc3_decode_set_isoch_delay(__u8 v, char *str)
+static inline void dwc3_decode_set_isoch_delay(__u8 v, char *str, size_t size)
 {
-	sprintf(str, "Set Isochronous Delay(Delay = %d ns)", v);
+	snprintf(str, size, "Set Isochronous Delay(Delay = %d ns)", v);
 }
 
 /**
  * dwc3_decode_ctrl - returns a string represetion of ctrl request
  */
-static inline const char *dwc3_decode_ctrl(char *str, __u8 bRequestType,
-		__u8 bRequest, __u16 wValue, __u16 wIndex, __u16 wLength)
+static inline const char *dwc3_decode_ctrl(char *str, size_t size,
+		__u8 bRequestType, __u8 bRequest, __u16 wValue, __u16 wIndex,
+		__u16 wLength)
 {
 	switch (bRequest) {
 	case USB_REQ_GET_STATUS:
-		dwc3_decode_get_status(bRequestType, wIndex, wLength, str);
+		dwc3_decode_get_status(bRequestType, wIndex, wLength, str,
+				size);
 		break;
 	case USB_REQ_CLEAR_FEATURE:
 	case USB_REQ_SET_FEATURE:
 		dwc3_decode_set_clear_feature(bRequestType, bRequest, wValue,
-					      wIndex, str);
+				wIndex, str, size);
 		break;
 	case USB_REQ_SET_ADDRESS:
-		dwc3_decode_set_address(wValue, str);
+		dwc3_decode_set_address(wValue, str, size);
 		break;
 	case USB_REQ_GET_DESCRIPTOR:
 	case USB_REQ_SET_DESCRIPTOR:
 		dwc3_decode_get_set_descriptor(bRequestType, bRequest, wValue,
-					       wIndex, wLength, str);
+				wIndex, wLength, str, size);
 		break;
 	case USB_REQ_GET_CONFIGURATION:
-		dwc3_decode_get_configuration(wLength, str);
+		dwc3_decode_get_configuration(wLength, str, size);
 		break;
 	case USB_REQ_SET_CONFIGURATION:
-		dwc3_decode_set_configuration(wValue, str);
+		dwc3_decode_set_configuration(wValue, str, size);
 		break;
 	case USB_REQ_GET_INTERFACE:
-		dwc3_decode_get_intf(wIndex, wLength, str);
+		dwc3_decode_get_intf(wIndex, wLength, str, size);
 		break;
 	case USB_REQ_SET_INTERFACE:
-		dwc3_decode_set_intf(wValue, wIndex, str);
+		dwc3_decode_set_intf(wValue, wIndex, str, size);
 		break;
 	case USB_REQ_SYNCH_FRAME:
-		dwc3_decode_synch_frame(wIndex, wLength, str);
+		dwc3_decode_synch_frame(wIndex, wLength, str, size);
 		break;
 	case USB_REQ_SET_SEL:
-		dwc3_decode_set_sel(wLength, str);
+		dwc3_decode_set_sel(wLength, str, size);
 		break;
 	case USB_REQ_SET_ISOCH_DELAY:
-		dwc3_decode_set_isoch_delay(wValue, str);
+		dwc3_decode_set_isoch_delay(wValue, str, size);
 		break;
 	default:
-		sprintf(str, "%02x %02x %02x %02x %02x %02x %02x %02x",
+		snprintf(str, size, "%02x %02x %02x %02x %02x %02x %02x %02x",
 			bRequestType, bRequest,
 			cpu_to_le16(wValue) & 0xff,
 			cpu_to_le16(wValue) >> 8,
@@ -490,16 +499,15 @@ static inline const char *dwc3_decode_ctrl(char *str, __u8 bRequestType,
  * dwc3_ep_event_string - returns event name
  * @event: then event code
  */
-static inline const char *
-dwc3_ep_event_string(char *str, const struct dwc3_event_depevt *event,
-		     u32 ep0state)
+static inline const char *dwc3_ep_event_string(char *str, size_t size,
+		const struct dwc3_event_depevt *event, u32 ep0state)
 {
 	u8 epnum = event->endpoint_number;
 	size_t len;
 	int status;
 	int ret;
 
-	ret = sprintf(str, "ep%d%s: ", epnum >> 1,
+	ret = snprintf(str, size, "ep%d%s: ", epnum >> 1,
 			(epnum & 1) ? "in" : "out");
 	if (ret < 0)
 		return "UNKNOWN";
@@ -509,7 +517,7 @@ dwc3_ep_event_string(char *str, const struct dwc3_event_depevt *event,
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
 		len = strlen(str);
-		sprintf(str + len, "Transfer Complete (%c%c%c)",
+		snprintf(str + len, size - len, "Transfer Complete (%c%c%c)",
 				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
 				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
 				status & DEPEVT_STATUS_LST ? 'L' : 'l');
@@ -517,12 +525,13 @@ dwc3_ep_event_string(char *str, const struct dwc3_event_depevt *event,
 		len = strlen(str);
 
 		if (epnum <= 1)
-			sprintf(str + len, " [%s]", dwc3_ep0_state_string(ep0state));
+			snprintf(str + len, size - len, " [%s]",
+					dwc3_ep0_state_string(ep0state));
 		break;
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		len = strlen(str);
 
-		sprintf(str + len, "Transfer In Progress [%d] (%c%c%c)",
+		snprintf(str + len, size - len, "Transfer In Progress [%d] (%c%c%c)",
 				event->parameters,
 				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
 				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
@@ -531,47 +540,51 @@ dwc3_ep_event_string(char *str, const struct dwc3_event_depevt *event,
 	case DWC3_DEPEVT_XFERNOTREADY:
 		len = strlen(str);
 
-		sprintf(str + len, "Transfer Not Ready [%d]%s",
+		snprintf(str + len, size - len, "Transfer Not Ready [%d]%s",
 				event->parameters,
 				status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
 				" (Active)" : " (Not Active)");
 
+		len = strlen(str);
+
 		/* Control Endpoints */
 		if (epnum <= 1) {
 			int phase = DEPEVT_STATUS_CONTROL_PHASE(event->status);
 
 			switch (phase) {
 			case DEPEVT_STATUS_CONTROL_DATA:
-				strcat(str, " [Data Phase]");
+				snprintf(str + ret, size - ret,
+						" [Data Phase]");
 				break;
 			case DEPEVT_STATUS_CONTROL_STATUS:
-				strcat(str, " [Status Phase]");
+				snprintf(str + ret, size - ret,
+						" [Status Phase]");
 			}
 		}
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
-		strcat(str, "FIFO");
+		snprintf(str + ret, size - ret, "FIFO");
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
 		status = event->status;
 
 		switch (status) {
 		case DEPEVT_STREAMEVT_FOUND:
-			sprintf(str + ret, " Stream %d Found",
+			snprintf(str + ret, size - ret, " Stream %d Found",
 					event->parameters);
 			break;
 		case DEPEVT_STREAMEVT_NOTFOUND:
 		default:
-			strcat(str, " Stream Not Found");
+			snprintf(str + ret, size - ret, " Stream Not Found");
 			break;
 		}
 
 		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
-		strcat(str, "Endpoint Command Complete");
+		snprintf(str + ret, size - ret, "Endpoint Command Complete");
 		break;
 	default:
-		sprintf(str, "UNKNOWN");
+		snprintf(str, size, "UNKNOWN");
 	}
 
 	return str;
@@ -611,14 +624,15 @@ static inline const char *dwc3_gadget_event_type_string(u8 event)
 	}
 }
 
-static inline const char *dwc3_decode_event(char *str, u32 event, u32 ep0state)
+static inline const char *dwc3_decode_event(char *str, size_t size, u32 event,
+		u32 ep0state)
 {
 	const union dwc3_event evt = (union dwc3_event) event;
 
 	if (evt.type.is_devspec)
-		return dwc3_gadget_event_string(str, &evt.devt);
+		return dwc3_gadget_event_string(str, size, &evt.devt);
 	else
-		return dwc3_ep_event_string(str, &evt.depevt, ep0state);
+		return dwc3_ep_event_string(str, size, &evt.depevt, ep0state);
 }
 
 static inline const char *dwc3_ep_cmd_status_string(int status)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6c9b76bcc2e1..e293400cc6e9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -174,7 +174,6 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 {
 	struct dwc3			*dwc = dep->dwc;
 
-	req->started = false;
 	list_del(&req->list);
 	req->remaining = 0;
 	req->needs_extra_trb = false;
@@ -209,6 +208,7 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	struct dwc3			*dwc = dep->dwc;
 
 	dwc3_gadget_del_and_unmap_request(dep, req, status);
+	req->status = DWC3_REQUEST_STATUS_COMPLETED;
 
 	spin_unlock(&dwc->lock);
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
@@ -384,19 +384,9 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 
 	trace_dwc3_gadget_ep_cmd(dep, cmd, params, cmd_status);
 
-	if (ret == 0) {
-		switch (DWC3_DEPCMD_CMD(cmd)) {
-		case DWC3_DEPCMD_STARTTRANSFER:
-			dep->flags |= DWC3_EP_TRANSFER_STARTED;
-			dwc3_gadget_ep_get_transfer_index(dep);
-			break;
-		case DWC3_DEPCMD_ENDTRANSFER:
-			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-			break;
-		default:
-			/* nothing */
-			break;
-		}
+	if (ret == 0 && DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
+		dep->flags |= DWC3_EP_TRANSFER_STARTED;
+		dwc3_gadget_ep_get_transfer_index(dep);
 	}
 
 	if (saved_config) {
@@ -642,7 +632,6 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 
 		dep->type = usb_endpoint_type(desc);
 		dep->flags |= DWC3_EP_ENABLED;
-		dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 
 		reg = dwc3_readl(dwc->regs, DWC3_DALEPENA);
 		reg |= DWC3_DALEPENA_EP(dep->number);
@@ -698,12 +687,13 @@ out:
 	return 0;
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force);
+static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+		bool interrupt);
 static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
 
-	dwc3_stop_active_transfer(dep, true);
+	dwc3_stop_active_transfer(dep, true, false);
 
 	/* - giveback all requests to gadget driver */
 	while (!list_empty(&dep->started_list)) {
@@ -748,7 +738,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	dep->stream_capable = false;
 	dep->type = 0;
-	dep->flags &= DWC3_EP_END_TRANSFER_PENDING;
+	dep->flags = 0;
 
 	/* Clear out the ep descriptors for non-ep0 */
 	if (dep->number > 1) {
@@ -847,6 +837,7 @@ static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
 	req->direction	= dep->direction;
 	req->epnum	= dep->number;
 	req->dep	= dep;
+	req->status	= DWC3_REQUEST_STATUS_UNKNOWN;
 
 	trace_dwc3_alloc_request(req);
 
@@ -1360,7 +1351,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 		 * to wait for the next XferNotReady to test the command again
 		 */
 		if (cmd_status == 0) {
-			dwc3_stop_active_transfer(dep, true);
+			dwc3_stop_active_transfer(dep, true, true);
 			return 0;
 		}
 	}
@@ -1435,6 +1426,11 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 				&req->request, req->dep->name))
 		return -EINVAL;
 
+	if (WARN(req->status < DWC3_REQUEST_STATUS_COMPLETED,
+				"%s: request %pK already in flight\n",
+				dep->name, &req->request))
+		return -EINVAL;
+
 	pm_runtime_get(dwc->dev);
 
 	req->request.actual	= 0;
@@ -1443,6 +1439,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	trace_dwc3_ep_queue(req);
 
 	list_add_tail(&req->list, &dep->pending_list);
+	req->status = DWC3_REQUEST_STATUS_QUEUED;
 
 	/*
 	 * NOTICE: Isochronous endpoints should NEVER be prestarted. We must
@@ -1506,6 +1503,8 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		dwc3_ep_inc_deq(dep);
 	}
+
+	req->num_trbs = 0;
 }
 
 static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
@@ -1547,13 +1546,16 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		}
 		if (r == req) {
 			/* wait until it is processed */
-			dwc3_stop_active_transfer(dep, true);
+			dwc3_stop_active_transfer(dep, true, true);
 
 			if (!r->trb)
 				goto out0;
 
 			dwc3_gadget_move_cancelled_request(req);
-			goto out0;
+			if (dep->flags & DWC3_EP_TRANSFER_STARTED)
+				goto out0;
+			else
+				goto out1;
 		}
 		dev_err(dwc->dev, "request %pK was not queued to %s\n",
 				request, ep->name);
@@ -1561,6 +1563,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		goto out0;
 	}
 
+out1:
 	dwc3_gadget_giveback(dep, req, -ECONNRESET);
 
 out0:
@@ -2500,7 +2503,7 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (stop) {
-		dwc3_stop_active_transfer(dep, true);
+		dwc3_stop_active_transfer(dep, true, true);
 		dep->flags = DWC3_EP_ENABLED;
 	}
 
@@ -2547,7 +2550,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	dep = dwc->eps[epnum];
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
-		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
+		if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
 			return;
 
 		/* Handle only EPCMDCMPLT when EP disabled */
@@ -2571,7 +2574,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
 
 		if (cmd == DWC3_DEPCMD_ENDTRANSFER) {
-			dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
+			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
 		}
 		break;
@@ -2621,15 +2624,15 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	}
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force)
+static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+	bool interrupt)
 {
 	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
 
-	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
-	    !dep->resource_index)
+	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
 		return;
 
 	/*
@@ -2665,17 +2668,15 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force)
 
 	cmd = DWC3_DEPCMD_ENDTRANSFER;
 	cmd |= force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
-	cmd |= DWC3_DEPCMD_CMDIOC;
+	cmd |= interrupt ? DWC3_DEPCMD_CMDIOC : 0;
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A) {
-		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
 		udelay(100);
-	}
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
@@ -3339,6 +3340,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
+	dwc3_gadget_set_speed(&dwc->gadget, dwc->maximum_speed);
+
 	return 0;
 
 err4:
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 023a473648eb..3ed738e86ea7 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -75,7 +75,7 @@ static inline void dwc3_gadget_move_started_request(struct dwc3_request *req)
 {
 	struct dwc3_ep		*dep = req->dep;
 
-	req->started = true;
+	req->status = DWC3_REQUEST_STATUS_STARTED;
 	list_move_tail(&req->list, &dep->started_list);
 }
 
@@ -90,7 +90,7 @@ static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req)
 {
 	struct dwc3_ep		*dep = req->dep;
 
-	req->started = false;
+	req->status = DWC3_REQUEST_STATUS_CANCELLED;
 	list_move_tail(&req->list, &dep->cancelled_list);
 }
 
-- 
2.43.0

