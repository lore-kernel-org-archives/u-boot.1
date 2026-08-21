Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFACC5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39D6C60EAD;
	Fri, 21 Aug 2026 13:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bRSi__LV0g_s; Fri, 21 Aug 2026 13:14:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317974;
	bh=9IfOuTnxRmoXMjpz6FohmWUHdTvRun9o+wM9asDXuoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tdZEgwjLf897ho98oSWVldSI/y5Q/jQN6CY+4atzIrBWIi3eMv70x31w9RRXReDlq
	 x8mB9dnV+eMBVGwVNUjT4OUkXpXR88u1WrmlzZJ+PIdObwhsuF+ThlS9NCp8AICB6e
	 y6N3AQH+KiUzp1kFWR9tf+sZ7OrdbZT03G40Gs9uOfDKs33BbdCtfTF48ZHzicNx4k
	 0nfIXhSLSTec9C7Oermhupk9UBOhd+2tuM3N5yIi1PedoAqZ0haMfHsrtfogJ6RILC
	 4RgOQw7i/DMDd883DQYWeI7NFL5w4lcWUNlypE5Hj1cH6NpMO2etajPvRb4oOThSMA
	 Os0j/SgEYGoXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 724D860DCA;
	Fri, 21 Aug 2026 13:12:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A349DEA3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89223400FD
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0NtLWpdj1oSJ for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=HHPDtexK
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B755B40073
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:29 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15f025146dso6939666b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302287; x=1787907087;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9IfOuTnxRmoXMjpz6FohmWUHdTvRun9o+wM9asDXuoU=;
 b=HHPDtexKokD0ZXvXa39Z6Ua/eSjvX2Cxa8v3M3YQYIKV9QuX2zbgne7RhRSefM4VAs
 NuK1JvVChMCjPNyVSxcTYMEfAnF9ed01DxYLjdAhHeDW2Ot51sZX8aB59R+s1ySJXOLd
 QMhfsirr8JcmzdGwjIo2lZ7jsYq8K54od2Qs5dIDxCzzIrKZVURpdMjoqwyo6lZ3qZ2n
 HPbsFFqsngcLXs1wOPGws3ZWddnLRr3y515LhX3JAKwOUXX2AZTLYo52O6OUk0QAw/MJ
 1V6qc+Tu9GLbya1MQL1BbKI7zbf4yyLvex/VjLSfQOPW5dguRI3JCS9ErzLCMFOh5O0J
 /EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302287; x=1787907087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9IfOuTnxRmoXMjpz6FohmWUHdTvRun9o+wM9asDXuoU=;
 b=mWD3b/3v5/0lBGVWYpf+SVMlB+URp0dw1vdPF9XCmR3c21Ip5ZAH0ZTdylUYIzRTMM
 89Kss0EOuICg0GIqMlNpqVV87mg+p7HWABA5hkJskZMOGFuXbMqpEmUAy+jIXmJJJiN3
 Mt2xErMfywC84jK8SUABC6exy42ffz8PcNj5Mb+vYlSBJbHCUeesg2CDxO/VUAJYs8hb
 NwwNQbXM1MEx5ZY+zdFRdAuicMPMO/SvEbAWp99iDNkw0f53hFdk6EnzKJ67wRfiFThl
 H5LZdKUuqbUlVB24dIGwopgIg3X3nptvoIBp+riEQbHcSx80IybU+xcR9sheC4LRmrrL
 Aqhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLi8cB/LoubyJkEdSDghIKrAQG9G1XuNjM8pFigzDx2oFGhTa2Hfvhbvq7U2YyYQ202kXh5I8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nGu0jOpt9/x9ufiIPbbT1uZBSXdBTYtvq06GuIc5Yia5saseyK
 Ev/uheLiOQ7Bz6BtIs211/QJIs91t/3A7Eu64lIYMJMNCgEEV43EVtrly8VQ9bi8d4A=
X-Gm-Gg: AR+sD10WQE4D5pcUDjE0TG3mClKyj+UzVgSJ7HAetww+ss8okLHgbNfdiZk6RZKGvLF
 NVGvOMhbc4qnbJLx7bfGZ8sDnYqzBEgCZMAg4s+9G99aukPf0pW8XOWX77lr6i7589yhey4ZOXM
 eyFe0n67B0ENRFpt+QoOpNGMZ+tLW2DDxI4WhrNtIrqD32FOIpHPcLr/TIy0ch1HUKvrJ9TeZhW
 zY6SCgCNdE0p9eCuz6SBvpJGtLnA9wLuuvla/pzojs9VenQctTunGo0p9UfgYi1l6v5gNkLMpmW
 5UrzVc+kdyj3dd3QGSMVgUP94dLmZ0KvHOQYo2ahHUcSilGnyFdfbjkPuYciEjOPa0/++C+7wn6
 P3Hqc4vUmhvJkHWL0QxkRmfrPlUX/VTanUbMN0LXHASNpZsTv2+uPDyxLydUpAkzJyKHHb0UCfD
 O/mWBPYZvlbSml2Sh5rPGPuL0Q0rxafJE5LgX5Pxxmc1eSmrvrmEYAjXQlbSgyfZIC1QUwZQ9aC
 Qz+ljNKlQ17N33wPjxgBfhLdUzRXahP5uw=
X-Received: by 2002:a17:907:84e:b0:c20:7897:bc67 with SMTP id
 a640c23a62f3a-c246a6a8e0bmr251016666b.3.1787302287349; 
 Fri, 21 Aug 2026 01:51:27 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b094c4sm388252666b.22.2026.08.21.01.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:26 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 26/87] usb: dwc3: import from kernel v5.1
Date: Fri, 21 Aug 2026 10:47:02 +0200
Message-ID: <20260821084829.2070426-27-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.0 to v5.1.

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

List of commits: git log --oneline v5.0..v5.1
Commits imported:
c7152763f02e usb: dwc3: Reset num_trbs after skipping
c5353b225df9 usb: dwc3: gadget: don't enable interrupt when disabling endpoint
1381a5113caf usb: dwc3: debug: purge usage of strcat
7790b3556fcc usb: dwc3: trace: pass trace buffer size to decoding functions
3aec99154db3 usb: dwc3: gadget: remove DWC3_EP_END_TRANSFER_PENDING
9f45581f5eec usb: dwc3: gadget: early giveback if End Transfer already completed
974a1368c33e usb: dwc3: gadget: don't use resource_index as a flag
acbfa6c26f21 usb: dwc3: gadget: clear DWC3_EP_TRANSFER_STARTED on cmd complete
7c3d7dc89e57 usb: dwc3: gadget: remove req->started flag
b2b6d601365a usb: dwc3: gadget: prevent dwc3_request from being queued twice
a3af5e3ad3f1 usb: dwc3: gadget: add dwc3_request status tracking
169e3b68cadb usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
2.53.0

