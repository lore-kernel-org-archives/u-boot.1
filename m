Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6F2D5A6EB
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 07:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A29889C22;
	Tue, 26 Nov 2024 08:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYYS57uj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD1389165; Tue, 26 Nov 2024 08:30:27 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F37B589C25
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53dd59a2bc1so4352215e87.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 23:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732606223; x=1733211023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrJyzW/D2iITtZneUeeA5UlkhsYOH0iRryDRUnShO6U=;
 b=AYYS57ujELLzDjYaOBK1EEoZmdjyuWzlcBu7/QsJds+D02aessqOIVQcS9XgB9g5wx
 K4b170ob3RhvpPvWYI9hhdox4InD0ybQNZejenP3nRgxRDmrZUPYjo+q7yZKsZhhgiVI
 ixGLOHyziuxogcSmVI1kykTIQnoPMhR7A746Iu8ulselCX2jN/AC13r7+IxdKS2jbYBB
 SiJRLb5mapCRYC7vHdWKeeAjuX9fZ598538n7Sw9S7n/PkYknCTJuh0cTItpyuhDMBZo
 Ek2bSdYsuN2ktfVuGve7oTRIiteY2Zsw3ootT+t1Wi4EkUci3VLyEHY7hWRHkAetlQoP
 OhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732606223; x=1733211023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hrJyzW/D2iITtZneUeeA5UlkhsYOH0iRryDRUnShO6U=;
 b=JR07SMiEP0fMH30V7d/UmUEebjNJ8+BCa72g1Frc159p0zvzSgov2cHPcusy/jE8Yy
 mjbVh+du7Cr6kAAqDTBE1bYGCCR5EHHtFCtviUKW4yPc591Xn6Upu+e4U+H0US7rKeO+
 b4zedZ5bJ9jnSUwkj7C0ETvBGbVfjfhzjrRtEbUgBLounzP60CT7z2ZB5EmC47PFZKCA
 rYSZQGEAfyxoAATcyrElEhT9JKuuR1zY1t1MEXQcEbm19jIEZyYGWqfjJBkEQ/9jNphY
 KW2vhvfFC7TX4DVROenlvEc6VKguIZSJRsFH+lOpy93fXrXemk2UxXOTf/Z6Ov+lvAWY
 UeLg==
X-Gm-Message-State: AOJu0YzSraf1Jqnkk3K7o0aTysKhvqpIZUvtbrYPJmmuFEBXWBagqUlB
 S2yOl+pHmJzYxVr7HWSa8jQ2cK3WeQvAQHRs66K5Pq/+ROsaxUaR
X-Gm-Gg: ASbGncv1+mY7oehChoqVEwShiTMZDSV9nYqSTFgBZO8ezZUuGHKbH+axXv2RBv2vSwZ
 BO3Y1TfIGNr/OcHzxFJ5Vd14TeIq9rM7JNHVlruA0m614Uhh4dSbP/oikfx7mhm04Qkvpm6HGjF
 hj5ZU57sf1i97zPzJf4DctQ6m26gpryyDi9W77Zi/xnCwoeGbGNlueMV7qJBkeKy6VqWT7X32db
 plEhwy+f13mgWmC+dwpR8CjGsrZO6+gyEf41/nuKg==
X-Google-Smtp-Source: AGHT+IEYNfcqz+DX6VNiJ/MJtYK52ebHQlCvnv+ctaLmr4Htm8g/lzNfMjzuAa+aNwjJm4nRZOnXgA==
X-Received: by 2002:a05:6512:2314:b0:53d:a24b:db0f with SMTP id
 2adb3069b0e04-53dd39b5396mr7523324e87.57.1732606222970; 
 Mon, 25 Nov 2024 23:30:22 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dd2497df2sm1898216e87.245.2024.11.25.23.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 23:30:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Holesch <simon@holesch.de>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] usb: ci_udc: don't use "advance" feature when setting
 address
Date: Tue, 26 Nov 2024 09:29:56 +0200
Message-ID: <20241126072956.64778-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241126072956.64778-1-clamor95@gmail.com>
References: <20241126072956.64778-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

In the older USB controllers like for example in ChipIdea controller
used by the Tegra 2 the "USBADRA: Device Address Advance" bitflag
does not exist, so the new device address set during SET_ADDRESS
can't be deferred by hardware, which causes the host to not recognize
the device and give an error.

Instead store it until ep completes to apply the change into the hw
register as Linux kernel does. This should fix regression on old and
and be compatible with newer controllers.

Inspired by: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef15e5490edc7edf808d3477ab32e0e320792f65

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/usb/gadget/ci_udc.c | 24 +++++++++++++++++++++++-
 drivers/usb/gadget/ci_udc.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index bbe03cfff1f..4bff75da759 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
 	}
 }
 
+/*
+ * This function explicitly sets the address, without the "USBADRA" (advance)
+ * feature, which is not supported by older versions of the controller.
+ */
+static void ci_set_address(struct ci_udc *udc, u8 address)
+{
+	DBG("%s %x\n", __func__, address);
+	writel(address << 25, &udc->devaddr);
+}
+
 static void handle_ep_complete(struct ci_ep *ci_ep)
 {
 	struct ept_queue_item *item, *next_td;
 	int num, in, len, j;
 	struct ci_req *ci_req;
 
+	/* Set the device address that was previously sent by SET_ADDRESS */
+	if (controller.next_device_address != 0) {
+		struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
+
+		ci_set_address(udc, controller.next_device_address);
+		controller.next_device_address = 0;
+	}
+
 	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
 	item = ci_get_qtd(num, in);
@@ -783,7 +801,7 @@ static void handle_setup(void)
 		 * write address delayed (will take effect
 		 * after the next IN txn)
 		 */
-		writel((r.wValue << 25) | (1 << 24), &udc->devaddr);
+		controller.next_device_address = r.wValue;
 		req->length = 0;
 		usb_ep_queue(controller.gadget.ep0, req, 0);
 		return;
@@ -814,6 +832,9 @@ static void stop_activity(void)
 	int i, num, in;
 	struct ept_queue_head *head;
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
+
+	ci_set_address(udc, 0);
+
 	writel(readl(&udc->epcomp), &udc->epcomp);
 #ifdef CONFIG_CI_UDC_HAS_HOSTPC
 	writel(readl(&udc->epsetupstat), &udc->epsetupstat);
@@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget *gadget, int is_on)
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
 	if (is_on) {
 		/* RESET */
+		controller.next_device_address = 0;
 		writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST, &udc->usbcmd);
 		udelay(200);
 
diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_udc.h
index bea2f9f3fe3..807f2084c1e 100644
--- a/drivers/usb/gadget/ci_udc.h
+++ b/drivers/usb/gadget/ci_udc.h
@@ -105,6 +105,7 @@ struct ci_drv {
 	struct ept_queue_head		*epts;
 	uint8_t				*items_mem;
 	struct ci_ep			ep[NUM_ENDPOINTS];
+	u8				next_device_address;
 };
 
 struct ept_queue_head {
-- 
2.43.0

