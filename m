Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A55C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9C2280DF6;
	Mon, 24 Aug 2026 16:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WnXHN2ImmWMg; Mon, 24 Aug 2026 16:44:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589850;
	bh=gTm56oQp0wNSHR1dxjaWdyMZQ00IWHSwXauafIMjGMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v5G3jGucbVo0rQ0wGMg+21F2/LlFe2850kr1o/oWO7PzCJaMNUvAcS0QwCQ4XhxyH
	 BSjsaR/zT0z5WOSuuD8pgdT/27SFBivpkxP+nbyPbuCMhnMIWjY31TiulakssOazXL
	 +sGL/t1JD0ZC6nBjRZLEb2vs4OIf602YyqFp2J7JzPrzcY82Jo7p9qcAur6i+gcFUc
	 czak0Njh+4UdWgBLeBFGPcHo/0LUOYLttJ0H71BI96ByRml1Ej8jBZX2VAdl4+5hOf
	 SpuihIrSAyT5G9oTeQUPbxzAh4QsOPFc+UWnPLu16hlA02TwUTUBbtN1p1ZHPstJ8s
	 Z80u2sB3KHikw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC8A080D50;
	Mon, 24 Aug 2026 16:44:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B9760279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F88C60626
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Txk3ufKKXiAc for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:28:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Z6PE98ct
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43E3F60624
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:09 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69a33fb0031so579199a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585288; x=1788190088;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gTm56oQp0wNSHR1dxjaWdyMZQ00IWHSwXauafIMjGMY=;
 b=Z6PE98ct4pLyeCJNFhVdkdFS0qUFOS8thIW78ON0ysDkL7a7jPq4+wfUe345x/Cbqk
 L1IQDtpKfTV1EbMBOglAvh5vE8/VFqZ754WWieUuBNOtuD5A7fudoAMUlF3zj4XlLoqO
 N3rHj7VXq3XXB9GsXGrFOFZ2ePk08lsU3v9i/j2P8aX1N98+KtLpnqEbMLgeXCV3QDjb
 cytbE0gtloFajRba8v71vQZfyVkqiDzbnACLl3CM9rPkjRjrF4kDSCwvfXl9WCBQNWwH
 4yr5rkpQ0X9Vx++I5QrW0ddph0z8gDk2u7XWNnJuXFj3ptz1PDE2/P5HtT78r8VM+Bnb
 yU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585288; x=1788190088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gTm56oQp0wNSHR1dxjaWdyMZQ00IWHSwXauafIMjGMY=;
 b=RzgzEuJg7eRm52LFLCkaRKG7XgYqohr7z915FstCCv6AjQFbkyWIKjxYsGpLd5eMmq
 cVeUDlifWqDekp8gJbep1VLV1ov3MiE87vcoDGZeutwHxQw4DylSUZjFgwuPqhJzD22e
 QXl8UgnY6woL/eWGMxGZTH6V8VOLmn67sl4aWKrzrseQGfGaAe1TyqALN9UUfPSDtcEb
 YT28lV//tNHyQK/NwNrF5wYj5QSyNw1HE1VCyMfO7Xpkl2lsTVFUoRT8xTe0jRxqByuh
 CzutnE9chxWhn7Wxk3aMkWVd5IvWqMlusQ+MY6y+rZe/ZOOgjNPOgcyXcAGw8qj1E4Xx
 5AeQ==
X-Gm-Message-State: AFuF++l/j+Hbe42MWNf28rZwd2pvHZENseAbvq/6sdMocym5GRBBxOig
 O1in7qMW2qX8lVhkjGrmfFuVQ15w0+dvCpsKw8g6lENmMvpMczRje3eFxzznaCsz+VYzgNIhDbi
 XUItB
X-Gm-Gg: AR+sD13YYmqioV7uyRtGZI9VEmPMNvTgBPrADa02FT3NGh9nOdTFd4Naec7EFSdrpgM
 DeY7O/wEwx21Eq4nHm0acmMVbFoGrN0amJ4aBk9HLIuLDFqcOZjcJ/1fPiGFtS8XYFemGAsfeiR
 tezkN8TCTuk8e8GR8XlDbXe3V648H33fz32PCVhd/wmkhHoFtrDH1nNqZrvF+0E9QmbawPTXa2B
 oPatfir9WtLpcGYkl3jXwMuEFmy5x9aLI8RR1nmrdVxXjhtjCNUckjrKxza7uajTawKt5PAehUe
 UVZmZYZleBPwUE2WwcKf9YdwgI6FVN+1bb9dPW+tlPoPmB21FoUFGuSFAOQKoOoPyjGzmO3mVGZ
 e9/kfJMkokwvZlZLtMo9fiXXw1NPkQXOz+yaBSD6+v+SKinvK4kjK68FRRwhfulnBrrUfWoUFxK
 Y6YJUpFm1CBjvu+AXJeMPq+aK6XPFZIX6zg/wFoEl6y9gSBVWX5ziREfccB7zTdqxMo5k09st90
 vkrfm9baR9rEMxXoO0zrw==
X-Received: by 2002:a17:906:6a25:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c246a396b8amr1735055866b.1.1787585287908; 
 Mon, 24 Aug 2026 08:28:07 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa1dsm1247744766b.56.2026.08.24.08.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:28:07 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 07/63] usb: dwc3: import from kernel v4.3
Date: Mon, 24 Aug 2026 17:26:38 +0200
Message-ID: <20260824152734.159794-8-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.2 to v4.3.

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

List of commits: git log --oneline v4.2..v4.3
Commits imported:
a66c275b3d5d usb: dwc3: gadget: Fix BUG in RT config
a474d3b73ba7 usb: dwc3: gadget: add ep capabilities support
c0bd5456a470 usb: dwc3: ep0: handle non maxpacket aligned transfers > 512
2abd9d5fa60f usb: dwc3: ep0: Add chained TRB support
368ca113ca0a usb: dwc3; ep0: Modify _dwc3_ep0_start_trans_ API to take 'chain' parameter
8a3442205630 usb: dwc3: ep0: preparation for handling non maxpacket aligned transfers > 512
2e5464da4e7d usb: dwc3: ep0: use _roundup_ to calculate the transfer size
b2fb5b1a0f50 usb: dwc3: ep0: Fix mem corruption on OUT transfers of more than 512 bytes
aa7399744dd0 usb: dwc3: gadget: defer endpoint name change
7eaeac5c0e44 usb: dwc3: gadget: add a trace when disabling EPs
d9972f470bcb usb: dwc3: core: remove unnecessary dev_warn()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  2 -
 drivers/usb/dwc3/ep0.c    | 92 ++++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/gadget.c | 61 +++++++++++++++-----------
 3 files changed, 101 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ff5773c66b84..064123e44566 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -455,8 +455,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
 			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 		} else {
-			dev_warn(dwc->dev, "HSPHY Interface not defined\n");
-
 			/* Relying on default value. */
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
 				break;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 69e769c35cf5..5320e939e090 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -56,7 +56,7 @@ static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
 }
 
 static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
-		u32 len, u32 type)
+		u32 len, u32 type, bool chain)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_trb			*trb;
@@ -70,7 +70,10 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 		return 0;
 	}
 
-	trb = dwc->ep0_trb;
+	trb = &dwc->ep0_trb[dep->free_slot];
+
+	if (chain)
+		dep->free_slot++;
 
 	trb->bpl = lower_32_bits(buf_dma);
 	trb->bph = upper_32_bits(buf_dma);
@@ -78,10 +81,17 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 	trb->ctrl = type;
 
 	trb->ctrl |= (DWC3_TRB_CTRL_HWO
-			| DWC3_TRB_CTRL_LST
-			| DWC3_TRB_CTRL_IOC
 			| DWC3_TRB_CTRL_ISP_IMI);
 
+	if (chain)
+		trb->ctrl |= DWC3_TRB_CTRL_CHN;
+	else
+		trb->ctrl |= (DWC3_TRB_CTRL_IOC
+				| DWC3_TRB_CTRL_LST);
+
+	if (chain)
+		return 0;
+
 	memset(&params, 0, sizeof(params));
 	params.param0 = upper_32_bits(dwc->ep0_trb_addr);
 	params.param1 = lower_32_bits(dwc->ep0_trb_addr);
@@ -302,7 +312,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	int				ret;
 
 	ret = dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8,
-			DWC3_TRBCTL_CONTROL_SETUP);
+			DWC3_TRBCTL_CONTROL_SETUP, false);
 	WARN_ON(ret < 0);
 }
 
@@ -783,7 +793,11 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	u32			transferred;
+	unsigned		transfer_size = 0;
+	unsigned		maxp;
+	unsigned		remaining_ur_length;
+	void			*buf;
+	u32			transferred = 0;
 	u32			status;
 	u32			length;
 	u8			epnum;
@@ -812,17 +826,37 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	}
 
 	ur = &r->request;
+	buf = ur->buf;
+	remaining_ur_length = ur->length;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
 
+	maxp = ep0->endpoint.maxpacket;
+
 	if (dwc->ep0_bounced) {
-		unsigned transfer_size = ur->length;
-		unsigned maxp = ep0->endpoint.maxpacket;
+		/*
+		 * Handle the first TRB before handling the bounce buffer if
+		 * the request length is greater than the bounce buffer size
+		 */
+		if (ur->length > DWC3_EP0_BOUNCE_SIZE) {
+			transfer_size = ALIGN(ur->length - maxp, maxp);
+			transferred = transfer_size - length;
+			buf = (u8 *)buf + transferred;
+			ur->actual += transferred;
+			remaining_ur_length -= transferred;
+
+			trb++;
+			length = trb->size & DWC3_TRB_SIZE_MASK;
 
-		transfer_size += (maxp - (transfer_size % maxp));
-		transferred = min_t(u32, ur->length,
-				transfer_size - length);
-		memcpy(ur->buf, dwc->ep0_bounce, transferred);
+			ep0->free_slot = 0;
+		}
+
+		transfer_size = roundup((ur->length - transfer_size),
+					maxp);
+
+		transferred = min_t(u32, remaining_ur_length,
+				    transfer_size - length);
+		memcpy(buf, dwc->ep0_bounce, transferred);
 	} else {
 		transferred = ur->length - length;
 	}
@@ -844,7 +878,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 			ret = dwc3_ep0_start_trans(dwc, epnum,
 					dwc->ctrl_req_addr, 0,
-					DWC3_TRBCTL_CONTROL_DATA);
+					DWC3_TRBCTL_CONTROL_DATA, false);
 			WARN_ON(ret < 0);
 		}
 	}
@@ -928,10 +962,10 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 	if (req->request.length == 0) {
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ctrl_req_addr, 0,
-				DWC3_TRBCTL_CONTROL_DATA);
+				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
 			&& (dep->number == 0)) {
-		u32	transfer_size;
+		u32	transfer_size = 0;
 		u32	maxpacket;
 
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
@@ -941,21 +975,26 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			return;
 		}
 
-		WARN_ON(req->request.length > DWC3_EP0_BOUNCE_SIZE);
-
 		maxpacket = dep->endpoint.maxpacket;
-		transfer_size = roundup(req->request.length, maxpacket);
+
+		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
+			transfer_size = ALIGN(req->request.length - maxpacket,
+					      maxpacket);
+			ret = dwc3_ep0_start_trans(dwc, dep->number,
+						   req->request.dma,
+						   transfer_size,
+						   DWC3_TRBCTL_CONTROL_DATA,
+						   true);
+		}
+
+		transfer_size = roundup((req->request.length - transfer_size),
+					maxpacket);
 
 		dwc->ep0_bounced = true;
 
-		/*
-		 * REVISIT in case request length is bigger than
-		 * DWC3_EP0_BOUNCE_SIZE we will need two chained
-		 * TRBs to handle the transfer.
-		 */
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ep0_bounce_addr, transfer_size,
-				DWC3_TRBCTL_CONTROL_DATA);
+				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else {
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
@@ -965,7 +1004,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		}
 
 		ret = dwc3_ep0_start_trans(dwc, dep->number, req->request.dma,
-				req->request.length, DWC3_TRBCTL_CONTROL_DATA);
+				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
+				false);
 	}
 
 	WARN_ON(ret < 0);
@@ -980,7 +1020,7 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 		: DWC3_TRBCTL_CONTROL_STATUS2;
 
 	return dwc3_ep0_start_trans(dwc, dep->number,
-			dwc->ctrl_req_addr, 0, type);
+			dwc->ctrl_req_addr, 0, type, false);
 }
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 333a7c0078fc..1e8bdf817811 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -547,6 +547,23 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
 	}
 
+	switch (usb_endpoint_type(desc)) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		strlcat(dep->name, "-control", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_ISOC:
+		strlcat(dep->name, "-isoc", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		strlcat(dep->name, "-bulk", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		strlcat(dep->name, "-int", sizeof(dep->name));
+		break;
+	default:
+		dev_err(dwc->dev, "invalid endpoint transfer type\n");
+	}
+
 	return 0;
 }
 
@@ -586,6 +603,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	struct dwc3		*dwc = dep->dwc;
 	u32			reg;
 
+	dwc3_trace(trace_dwc3_gadget, "Disabling %s", dep->name);
+
 	dwc3_remove_requests(dwc, dep);
 
 	/* make sure HW endpoint isn't stalled */
@@ -602,6 +621,10 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	dep->type = 0;
 	dep->flags = 0;
 
+	snprintf(dep->name, sizeof(dep->name), "ep%d%s",
+			dep->number >> 1,
+			(dep->number & 1) ? "in" : "out");
+
 	return 0;
 }
 
@@ -647,23 +670,6 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 		return 0;
 	}
 
-	switch (usb_endpoint_type(desc)) {
-	case USB_ENDPOINT_XFER_CONTROL:
-		strlcat(dep->name, "-control", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_ISOC:
-		strlcat(dep->name, "-isoc", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_BULK:
-		strlcat(dep->name, "-bulk", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_INT:
-		strlcat(dep->name, "-int", sizeof(dep->name));
-		break;
-	default:
-		dev_err(dwc->dev, "invalid endpoint transfer type\n");
-	}
-
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_enable(dep, desc, ep->comp_desc, false, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -692,10 +698,6 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 		return 0;
 	}
 
-	snprintf(dep->name, sizeof(dep->name), "ep%d%s",
-			dep->number >> 1,
-			(dep->number & 1) ? "in" : "out");
-
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_disable(dep);
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -1713,6 +1715,17 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 				return ret;
 		}
 
+		if (epnum == 0 || epnum == 1) {
+			dep->endpoint.caps.type_control = true;
+		} else {
+			dep->endpoint.caps.type_iso = true;
+			dep->endpoint.caps.type_bulk = true;
+			dep->endpoint.caps.type_int = true;
+		}
+
+		dep->endpoint.caps.dir_in = !!direction;
+		dep->endpoint.caps.dir_out = !direction;
+
 		INIT_LIST_HEAD(&dep->request_list);
 		INIT_LIST_HEAD(&dep->req_queued);
 	}
@@ -2652,8 +2665,6 @@ static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
 	int				i;
 	irqreturn_t			ret = IRQ_NONE;
 
-	spin_lock(&dwc->lock);
-
 	for (i = 0; i < dwc->num_event_buffers; i++) {
 		irqreturn_t status;
 
@@ -2662,8 +2673,6 @@ static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
 			ret = status;
 	}
 
-	spin_unlock(&dwc->lock);
-
 	return ret;
 }
 
@@ -2685,7 +2694,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err0;
 	}
 
-	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
 			&dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
-- 
2.53.0

