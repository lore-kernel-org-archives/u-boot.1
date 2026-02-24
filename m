Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3691F3C99E
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5487D83642;
	Tue, 24 Feb 2026 16:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YrTJgJM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D55D683DAE; Tue, 24 Feb 2026 16:45:09 +0100 (CET)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D3F82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-6769719821dso1935206eaf.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771947906; x=1772552706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OIt/Db4tua0B4lVkqiapGa9O66cQOHLNsixtY1Nta+I=;
 b=YrTJgJM7NeB+Ekj1C3OZrTkwIyPR6JqKfZ2S/N4KaZOKgV3wOchI7nLv7+dBtjUJ0q
 IP0BffbQbUdutt261RLqnZzDovTj/82mUH9EYjdwoREMoDw30JXxlBaKqIpp05P00SQF
 alMRSN/F34vX7My3QB7Kj0jqy3DLf0mvSIkH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771947906; x=1772552706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIt/Db4tua0B4lVkqiapGa9O66cQOHLNsixtY1Nta+I=;
 b=duUkNhuE5ZRpeQ8EEqNcKzvQQnLepmbgSHkHCq+GnEYflUCtVQ2W6/8Kag331ECefG
 WgOVnOeVY0sLl9pTEmXF26eQe3RqK/TLReav4qJ9bCGjLr4gCKUTArjEBKBxEraX0VIa
 C2yioT1l7xJ9zbZntlcU+6fCilmMmv82BREAckq/BDeJTFTc9nMvJ0wby3/UfKBSE2HN
 GQS1PWWUZZO70M3CizDYl72WwogEuYgXP6u0CJzJbuIPuPdqRsi8K0qImwvU9hf47I/c
 LtPWIr1ed0YNnQ/qg0z1Or/1BwpWwevZRUh1PPlsPY/H95fCIuzVxy4BXiwJZ/K6weq4
 dIPQ==
X-Gm-Message-State: AOJu0YyQguMmWWWgnynCRWDWvBrknC1sG3QegSO+N3DUgYIIG1vU+McU
 CgBVY0TMpKKKcuXsG2xdazykNeFaPTX76P3EnrnCSHW5kLqrdhiSi1Jkna9s5NekuwM0XhDdkVy
 KTdN/2LA=
X-Gm-Gg: ATEYQzxpua6WNurCd7/TzGgO0SiBBXTIrqMQmguPcvVuYm8lyS4KlQCANyCk62Up7Ur
 C+61aghZ7aTj4Hnbc2v8ty5qU0gp97MmMPEdyMPl7EbCd/xpOcbxekAproWQyp6P1RsE0s0oobb
 RPokFVubr6Wpta6kryobmSCEGO8vp65hqm5G1ExToTV9TqWWvRjZDBfcwSDiXjoK8j06YnpEvcw
 1BtLXfgKynXKK8D9bPMRSMvVx92Ls1pn7b0+9gMIOdjZ8Qd2uNwdv+2cV0X9QWMplPOtgyR+1B0
 fTyiQSaLelMm7R9NSPFnkDd4sON/IeGqBFFqx7vGqv7dzCAHZlazCWWnZ/wZJDRt2Vkk4gh+6Op
 ify8OO03dnazymwHiznZ3lH/Vayn8duQraIBB5kvcgS0HNripIN/uICtn8qdacpdzb2BRElWE2n
 AChkNNJW60hpIaXVwXI/CeyBkVT8LYau7A2ap8xAsDzbwze+xXuF7Pj8ZAMrigKqByuMScMBGvF
 r2HubBmBzFdgG7noUATHnm93HTTyMSutqe9dYfElXRMCco2u7SZ1Q==
X-Received: by 2002:a05:6870:3263:b0:3ec:3dbd:d4cc with SMTP id
 586e51a60fabf-4157abde249mr5653856fac.8.1771947906293; 
 Tue, 24 Feb 2026 07:45:06 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d3a24bdsm10202864fac.18.2026.02.24.07.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:45:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: [PATCH] usb: gadget: Mark udc_disconnect as static
Date: Tue, 24 Feb 2026 09:45:04 -0600
Message-ID: <20260224154504.85301-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

With the last external callers of udc_disconnect long removed, mark this
function as static now and remove it from headers.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/bootm.h | 2 --
 drivers/usb/gadget/ci_udc.c  | 2 +-
 include/usb.h                | 9 ---------
 include/usb/udc.h            | 1 -
 4 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/bootm.h b/arch/arm/include/asm/bootm.h
index 439e43c2d017..762f00e69004 100644
--- a/arch/arm/include/asm/bootm.h
+++ b/arch/arm/include/asm/bootm.h
@@ -8,8 +8,6 @@
 #ifndef ARM_BOOTM_H
 #define ARM_BOOTM_H
 
-extern void udc_disconnect(void);
-
 #ifdef CONFIG_SUPPORT_PASSING_ATAGS
 # define BOOTM_ENABLE_TAGS		1
 #else
diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 046bb335ecb5..4729570c5257 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -990,7 +990,7 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 	return value;
 }
 
-void udc_disconnect(void)
+static void udc_disconnect(void)
 {
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
 	/* disable pullup */
diff --git a/include/usb.h b/include/usb.h
index be37ed272e15..dab23753f0c0 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -208,15 +208,6 @@ void *poll_int_queue(struct usb_device *dev, struct int_queue *queue);
 #define USB_UHCI_VEND_ID	0x8086
 #define USB_UHCI_DEV_ID		0x7112
 
-/*
- * PXA25x can only act as USB device. There are drivers
- * which works with USB CDC gadgets implementations.
- * Some of them have common routines which can be used
- * in boards init functions e.g. udc_disconnect() used for
- * forced device disconnection from host.
- */
-extern void udc_disconnect(void);
-
 /*
  * board-specific hardware initialization, called by
  * usb drivers and u-boot commands
diff --git a/include/usb/udc.h b/include/usb/udc.h
index 749b3a3f0156..c5e431813be7 100644
--- a/include/usb/udc.h
+++ b/include/usb/udc.h
@@ -39,7 +39,6 @@ int udc_endpoint_write(struct usb_endpoint_instance *endpoint);
 void udc_setup_ep(struct usb_device_instance *device, unsigned int ep,
 		  struct usb_endpoint_instance *endpoint);
 void udc_connect(void);
-void udc_disconnect(void);
 void udc_enable(struct usb_device_instance *device);
 void udc_disable(void);
 void udc_startup_events(struct usb_device_instance *device);
-- 
2.43.0

