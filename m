Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A30CF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 14:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E73A88F1B;
	Sun, 13 Oct 2024 16:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OG93h7jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E183388F3C; Sun, 13 Oct 2024 16:58:45 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38EB988F16
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99ea294480so143163166b.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728831523; x=1729436323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwUflC0jVyk4n8jNusZlEY+NxNJAD2bW6m5y44f/T5c=;
 b=OG93h7jdFlk1sKMgmc248FF2iks3czuP3PJrVrnlE0iYD+EQZ14MSwv17Uchng8DZv
 7GErzBpVlrd1qAU17+XgS2rQ/uQ6s95KSDtI12rLRaafSS9d0POv5fu75U65vfvzewNV
 tz4NqeNW/OHxwtoo3ekTImNY3zuFpU/wyyf2KTcdZ9sRhNmoRu6+5Cx34MO2Be5PCXr5
 dCC7CFuPzuklvksQlIYDReqXuakitGTxxB3hXN0lnUJO4X83fN/QtsHJjpOfDb98b9xH
 INCn6WMq/9K93Y48L1LzQ9r8cU5Qy1pGzO9ATuraVG2DFreZK4leBBS3aqiWVhzdb2Cp
 Y2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728831523; x=1729436323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jwUflC0jVyk4n8jNusZlEY+NxNJAD2bW6m5y44f/T5c=;
 b=WbSrqniNQSRn85kTZdpGl+TMKsTTS12+pjTS1l446npuKxj6lJhfB81bYMZB7OTXo2
 obSeWRguWXw5SvwLvo+ZZYh5O+tqm9FePULgYkheIiWkp1FqHMdmcKQirYVAEPbDaX6A
 qm5xtcTqTtNeF9pjipQJGpL4ub3/OOqnqiF3DYHYDhY2PXoHG/FNpHFc3fLH0cHcxVqf
 0OR5B2pGecwKl9MXq+A3xbVvPjsrxN51tHCQ2tblV5gMeQilkWONwEZ6qU0hUqQq22+C
 va86HW135yutY22uppg9WUrzsuHJ4sOGnUWsDxjqjTl7qQwjuIMYfWzKYVC2d0D/b4mY
 wcUA==
X-Gm-Message-State: AOJu0YygZc4N/N1ToUvRK9KnAxkxXlkgFTDq/iXoLlHWzx6gH6qvEswD
 oz/x8SFGGLNd391xCtgg5xUgglSkVYGKn6EC7VFIOJTmpoLX0LcX
X-Google-Smtp-Source: AGHT+IGIILszCF3Q7NZG9ktITlYiEjhubqbdK/jHry3/CcZWlUDrz85zYDbgsU+CQyx9JUtQ1xLZiw==
X-Received: by 2002:a05:6402:4142:b0:5c9:58d3:646b with SMTP id
 4fb4d7f45d1cf-5c95ac62643mr9369722a12.29.1728831522313; 
 Sun, 13 Oct 2024 07:58:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c93711ad23sm3836877a12.25.2024.10.13.07.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:58:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Holesch <simon@holesch.de>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when setting
 address
Date: Sun, 13 Oct 2024 17:58:20 +0300
Message-ID: <20241013145820.85426-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013145820.85426-1-clamor95@gmail.com>
References: <20241013145820.85426-1-clamor95@gmail.com>
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

