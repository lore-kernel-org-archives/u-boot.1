Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD69C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF8788570;
	Fri, 26 Jul 2024 14:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="Ufvo37Fz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458F987CF8; Fri, 26 Jul 2024 10:31:10 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B13B884BE
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42797bcfc77so13408545e9.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721982667; x=1722587467;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=diiYQo7g+/VLJCSjU79AFhIlsJp+7o2DkE35etww5As=;
 b=Ufvo37FzqV+50ZX5co8tG7dQZ5UAJOLt3N0h0ZPdCoRVHrnvf7T9kfPUy9OUxnrcnE
 Oox/EJXqH9NEYt6zDigG5RPk6AXQCpz3TlvEFY/swI4NyBv9FWWY871SeTizqBG2x6FB
 WP3T35FHgAR2PtDsIsnPiV8fGKcvkWKCWQttPYad+d35HJGtlot5h59ciIWlAbmlEQb4
 6ggEdw+qMfArXcBFRMQUE/mGlxHGUTMOIHdPt3X0JPJvQ2dfD54LQw3+eCrYT8xyp9w4
 W5nL5Z9rnbnzVriElW4nTdTE3Zu/VgXnJ3REpImVu+bEOqrK/dFUFos05hcgM50wMU8i
 V14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721982667; x=1722587467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=diiYQo7g+/VLJCSjU79AFhIlsJp+7o2DkE35etww5As=;
 b=YbM5kkGgRec8I2rpOAPBjekIWn8X8yIGei7ELRHAEEjFxMSF/STysvlY62ZoSRo39W
 0CISvvg1q7buOGrTZ/9sQVOnG/sFXBX8FcQ3XSVTVZ+63CIPi4jG/1+itt8j2Gj9jcg8
 0Mhiw+IhPQRiJmW7jYvpN303dJQpk7WHFRBv2qvLEDIboEz5V9hcAo9sdfhKHd2iqW/0
 f7yr8pfx+OnIikX9xYf5XfQnMHYOv64YySGav/wRwIvXosTms6g4vPd4YQagFDbE2Kx8
 mAjpXcYPmCWd0hKssu5ns9kghgrpsmAelaXoT5BPz/+smPfzmjbTPCh3r6DZRCBk9csj
 rC1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXUxudbZq77dpliZY9mdDX+jXNFtdnxN1G3iUzyVIDYCTC2qWJWgqlqToBMik1zIUc+7isJlMaQxjvxE44F5OGpx8Tsw==
X-Gm-Message-State: AOJu0Yx9vohLHgHTlRM5QSyx+GFXeHz6cli9pvpo9tvi2xEcZovqgsxk
 FdGVHxfzu/U2IuzeAi9BUDoFICHWQ1Xr+43KlHODPrQMAv2UFbE1ScnmLpOfMPQ=
X-Google-Smtp-Source: AGHT+IGyb7vQNBwJoVofer3LDPC8YdUd4Zy2bX4xsPnF8CiRhzpBN8mrwMZPJreClF+cKOO7SbRysg==
X-Received: by 2002:a05:600c:1c12:b0:427:9dad:17df with SMTP id
 5b1f17b1804b1-4280548c8efmr30539025e9.12.1721982666670; 
 Fri, 26 Jul 2024 01:31:06 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-427f93e605esm111598845e9.34.2024.07.26.01.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 01:31:06 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH] usb: gadget: ether: Handle gadget driver registration in
 start and stop
Date: Fri, 26 Jul 2024 10:31:00 +0200
Message-ID: <20240726083102.380719-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jul 2024 14:43:57 +0200
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

Revert part of 718f1d41 to move
 usb_gadget_register_driver()/usb_gadget_unregister_driver()
back to usb_eth_start()/usb_eth_stop().

usb_gadget_register_driver() will initialize the USB controller which
enters ready to connect state with pull-up resistor enabled.

From the host's point of view, a device is ready to be enumerated.
However, since dm_usb_gadget_handle_interrupts() is only called when
ethernet function is started, at this stage USB events are not managed,
host's enumeration attempts will fail and resulting error like:
    usb 1-1: new high-speed USB device number 50 using xhci_hcd
    usb 1-1: device descriptor read/64, error -110
    usb 1-1: device descriptor read/64, error -110
    usb usb1-port1: attempt power cycle

With this patch the USB controller will only be initialized when ethernet
function is used, in which case USB controller events are handled, so the
host won't see an unresponsive device.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/ether.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index b7b7bacb00..ed55f12662 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -2277,6 +2277,9 @@ static int usb_eth_start(struct udevice *udev)
 	packet_received = 0;
 	packet_sent = 0;

+	if (usb_gadget_register_driver(&priv->eth_driver) < 0)
+		goto fail;
+
 	gadget = dev->gadget;
 	usb_gadget_connect(gadget);

@@ -2398,6 +2401,8 @@ static void usb_eth_stop(struct udevice *udev)
 		dm_usb_gadget_handle_interrupts(udev->parent);
 		dev->network_started = 0;
 	}
+
+	usb_gadget_unregister_driver(&priv->eth_driver);
 }

 static int usb_eth_recv(struct udevice *dev, int flags, uchar **packetp)
@@ -2503,15 +2508,6 @@ static int usb_eth_probe(struct udevice *dev)
 	priv->eth_driver.disconnect	= eth_disconnect;
 	priv->eth_driver.suspend	= eth_suspend;
 	priv->eth_driver.resume		= eth_resume;
-	return usb_gadget_register_driver(&priv->eth_driver);
-}
-
-static int usb_eth_remove(struct udevice *dev)
-{
-	struct ether_priv *priv = dev_get_priv(dev);
-
-	usb_gadget_unregister_driver(&priv->eth_driver);
-
 	return 0;
 }

@@ -2526,7 +2522,6 @@ U_BOOT_DRIVER(eth_usb) = {
 	.name	= "usb_ether",
 	.id	= UCLASS_ETH,
 	.probe	= usb_eth_probe,
-	.remove	= usb_eth_remove,
 	.unbind	= usb_eth_unbind,
 	.ops	= &usb_eth_ops,
 	.priv_auto	= sizeof(struct ether_priv),
--
2.45.2

