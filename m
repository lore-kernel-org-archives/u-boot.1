Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1943AC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E01F84EF0;
	Thu, 16 Jul 2026 18:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PfdsLS0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C7B80433; Thu, 16 Jul 2026 15:45:03 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367F884C3F
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15c1f1be0bso85288066b.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209501; x=1784814301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uhstW2eBgtDAcJyRahbvY0I77s+zPklo2mV5bKc69mw=;
 b=PfdsLS0TRhnpbCi7ASQhClEffAM+Yg5m2FNYzQuqezcwO/laPCjvMbhI37nFxapqSp
 y9/vDTycHL41P2zOFfZpLb5/5gfV2ts26dtp0grZw5BykCbW3eiyAHIL0fh7M38M6R0u
 +hw78ZBxxUKncFqEZRoHP4Y2b/bJECCVpCKFHlhdnKHIQQXr9kSWq9jFuFW6/QJQP7gG
 dgymTmng+f98PkOPTwCkH5i4fAmS4oOKbGiNAgir8kycX/a4Z4PCOk/U6LgGQ5++HiTO
 u1PH3AP/GrBJpaGzrczejyFyxXEU9j7hC+DsOWogE+e3PkMu9Hat4IMz9/Cy9gxfV+cu
 ptew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209501; x=1784814301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uhstW2eBgtDAcJyRahbvY0I77s+zPklo2mV5bKc69mw=;
 b=hY3FF3AKKyKbZHIqTd77ND8/5VumuCVDXBGJJ+2SW0WsugHLyO66WMqFeLj/TdALTQ
 2NkO9qleAV2MY/WIYHZCLAelTQjx9LpvcKDxjH2k3QhOfIx4eu1smG2ttvHCKE0UP2zH
 YJz0HUMYGEx2jHIdnBhvTRJmxgYVg+yA67jHajn4WbINHh9EVxm441PwHGd236OtfAYh
 lE3G5Jvx0KQ+01fBT1uLhYf8JJfG2/tVIkonmkEvdZgTZDdAlr9kc9RO3hv7cKPdyGF6
 lnax1IOWcuArUw4Drjs7+js83oxbJOZy/yfwMhlRMy56uXzmfR6hTdpXm1DQ56wG1hJ1
 ioXw==
X-Gm-Message-State: AOJu0YzT+uTK5XVHpnmABOBqJ1/rxHYiwXTTiZpR3E4Yh2n5WGQa6dZf
 cyBIZ6uFYW545xS1djjroLrYzqe8V+S4kSVXKKkFBAkFvEIagGOs+IODpeEi7wnkSdCqvQhrzvf
 GttHLf7M=
X-Gm-Gg: AfdE7clPk2JGmUmH5JikxtZm0sxBRj/84Jn+A3Lwx7/SaQ/fKBd7wUuAr/r6hvJVPYu
 qyb9XOKKCtLwBIbcp9Q3AqDlI20Xny6NSmdI5mcryxx9/uo7U11i6PfL6nHSmQN/3eBkBtlrOXD
 kxk7JBvQdzE9h2gBbcKKywOBRFb3Cao1EBYQNUhvO/b5afFI9YNP6uH9bIlXmrPYua1zK56/Q3Q
 BkXeCy76/+hlZViMCcy4CKrpZk8wu//tGxWVJRaALg2Pd5s6eNX2M7ROkW8Cl2uSQWIoSiDueL4
 U8qQZHlOq3HF5vkTY/PMUU+CH+w1yQCXcXv6hg9GfzkZ2UarD/B1/tZb/tkPyWWfo3di/LKcFDO
 dIoOgRCeOpp/0kvXmOlfPs4GRWzQ/PKpq7BMDuABZvMvCuBFjjiMuppO24iTgL8nsTpq664oNdP
 Uryxl+VqAWbQurFssYdzl677OYjrX0GsyqpjRLwg==
X-Received: by 2002:a17:906:7314:b0:c15:f656:d582 with SMTP id
 a640c23a62f3a-c161ea5f5ddmr696835166b.6.1784209500585; 
 Thu, 16 Jul 2026 06:45:00 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168731879esm216000266b.32.2026.07.16.06.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:59 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: [PATCH v5 74/75] usb: fix up musb-new and mtu3 after the resync
Date: Thu, 16 Jul 2026 15:42:44 +0200
Message-ID: <20260716134305.614278-75-anders.roxell@linaro.org>
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

Adapt the musb-new and mtu3 gadget code to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c     | 16 +++++------
 drivers/usb/musb-new/musb_gadget_ep0.c | 24 ++++++----------
 drivers/usb/musb-new/musb_uboot.c      | 39 --------------------------
 3 files changed, 16 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 4b0bc5f02d10..07775d23d508 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -300,20 +300,20 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 	u32 value = 0;
 
 	switch (le16_to_cpu(setup->wIndex) >> 8) {
-	case TEST_J:
-		dev_dbg(mtu->dev, "TEST_J\n");
+	case USB_TEST_J:
+		dev_dbg(mtu->dev, "USB_TEST_J\n");
 		mtu->test_mode_nr = TEST_J_MODE;
 		break;
-	case TEST_K:
-		dev_dbg(mtu->dev, "TEST_K\n");
+	case USB_TEST_K:
+		dev_dbg(mtu->dev, "USB_TEST_K\n");
 		mtu->test_mode_nr = TEST_K_MODE;
 		break;
-	case TEST_SE0_NAK:
-		dev_dbg(mtu->dev, "TEST_SE0_NAK\n");
+	case USB_TEST_SE0_NAK:
+		dev_dbg(mtu->dev, "USB_TEST_SE0_NAK\n");
 		mtu->test_mode_nr = TEST_SE0_NAK_MODE;
 		break;
-	case TEST_PACKET:
-		dev_dbg(mtu->dev, "TEST_PACKET\n");
+	case USB_TEST_PACKET:
+		dev_dbg(mtu->dev, "USB_TEST_PACKET\n");
 		mtu->test_mode_nr = TEST_PACKET_MODE;
 		break;
 	default:
diff --git a/drivers/usb/musb-new/musb_gadget_ep0.c b/drivers/usb/musb-new/musb_gadget_ep0.c
index 25b1de6e58f9..726864aa7979 100644
--- a/drivers/usb/musb-new/musb_gadget_ep0.c
+++ b/drivers/usb/musb-new/musb_gadget_ep0.c
@@ -320,51 +320,43 @@ __acquires(musb->lock)
 						goto stall;
 
 					switch (ctrlrequest->wIndex >> 8) {
-					case 1:
-						pr_debug("TEST_J\n");
-						/* TEST_J */
+					case USB_TEST_J:
+						pr_debug("USB_TEST_J\n");
 						musb->test_mode_nr =
 							MUSB_TEST_J;
 						break;
-					case 2:
-						/* TEST_K */
-						pr_debug("TEST_K\n");
+					case USB_TEST_K:
+						pr_debug("USB_TEST_K\n");
 						musb->test_mode_nr =
 							MUSB_TEST_K;
 						break;
-					case 3:
-						/* TEST_SE0_NAK */
-						pr_debug("TEST_SE0_NAK\n");
+					case USB_TEST_SE0_NAK:
+						pr_debug("USB_TEST_SE0_NAK\n");
 						musb->test_mode_nr =
 							MUSB_TEST_SE0_NAK;
 						break;
-					case 4:
-						/* TEST_PACKET */
-						pr_debug("TEST_PACKET\n");
+					case USB_TEST_PACKET:
+						pr_debug("USB_TEST_PACKET\n");
 						musb->test_mode_nr =
 							MUSB_TEST_PACKET;
 						break;
 
 					case 0xc0:
-						/* TEST_FORCE_HS */
 						pr_debug("TEST_FORCE_HS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_HS;
 						break;
 					case 0xc1:
-						/* TEST_FORCE_FS */
 						pr_debug("TEST_FORCE_FS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_FS;
 						break;
 					case 0xc2:
-						/* TEST_FIFO_ACCESS */
 						pr_debug("TEST_FIFO_ACCESS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FIFO_ACCESS;
 						break;
 					case 0xc3:
-						/* TEST_FORCE_HOST */
 						pr_debug("TEST_FORCE_HOST\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_HOST;
diff --git a/drivers/usb/musb-new/musb_uboot.c b/drivers/usb/musb-new/musb_uboot.c
index 43ab3245e5c3..16907c4681bc 100644
--- a/drivers/usb/musb-new/musb_uboot.c
+++ b/drivers/usb/musb-new/musb_uboot.c
@@ -383,45 +383,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 
 	return gadget->isr(0, gadget);
 }
-
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	int ret;
-
-	if (!driver || driver->speed < USB_SPEED_FULL || !driver->bind ||
-	    !driver->setup) {
-		printf("bad parameter.\n");
-		return -EINVAL;
-	}
-
-	if (!gadget) {
-		printf("Controller uninitialized\n");
-		return -ENXIO;
-	}
-
-	ret = musb_gadget_start(&gadget->g, driver);
-	if (ret < 0) {
-		printf("gadget_start failed with %d\n", ret);
-		return ret;
-	}
-
-	ret = driver->bind(&gadget->g);
-	if (ret < 0) {
-		printf("bind failed with %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	if (driver->disconnect)
-		driver->disconnect(&gadget->g);
-	if (driver->unbind)
-		driver->unbind(&gadget->g);
-	return 0;
-}
 #endif /* CONFIG_USB_MUSB_GADGET */
 
 struct musb *musb_register(struct musb_hdrc_platform_data *plat, void *bdata,
-- 
2.53.0

