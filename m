Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8085DC52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 01:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF58188C65;
	Thu, 22 Aug 2024 03:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="zgUUk3QW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6111988E35; Wed, 21 Aug 2024 23:22:41 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4826788E5F
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 23:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4280b3a7efaso769955e9.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 14:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1724275358; x=1724880158;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2QDFjLqYdLFSth8AIn+Is69pZ61EuZduIhCAJKHzmIE=;
 b=zgUUk3QW0YZ93xETmexWcHXcudGXsPANwBhBSmZQkJWF5lSZ0kguRLTLKNi3bc19w4
 FMU6n6dAXxGv6rh2wihXA1Ck8lmT3YWcBwcwLPwMfapPsO81cRMVJSZGC2+qaFy/MWL7
 nMxo23NiJ/8bSmuypJj38dGQPEAU/xKNyRUfh8Qe4YZBz8dS9of8VIGWdsEgmIzPdBxD
 SGA9lCf68XDxpMmfDNcD/Hlz2gCxTBZtby6HPH2BAiKlXca+fQk8hNRuZctQO57DLAEZ
 hYI5X1VWp+0nfmfNfJ17Z29awqk6VJG6Jt/MLxafM/ein4RgbyMRHN5DmzvR3IGwJy4j
 wI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724275358; x=1724880158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2QDFjLqYdLFSth8AIn+Is69pZ61EuZduIhCAJKHzmIE=;
 b=YEIYP5OJiMNlSYt1Ai/Xj/fHG6eiCLxN1e768p0q1i43nYFA9yY21rLOxd6LPaYKhw
 mpmF+o/VpcFEADwoLRvRI7U2VexrszLBhA/n3nHJd+riM+ZqLGHmJLRGF/fIj5ZAY8KE
 azpaZyGLRRvH3dXcQrPeg48JNaG+vouYQu6IbxTJh/JaHnrRl6+MN3Ekd9gO7eSQ12jo
 qcoCbttoVBWzKEiiYdvn+4QAGRQFOjKfTo/jrVQxGWWFG07DVzo1cNv4YFIiHH6O9QXW
 /QOj6CSAaH7cLhz5LPzPUI2VoLw397+tciD67B62QK2xG5pA3Z2YLYtE1lp16DBy3wlu
 qIFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMXrRNXfi5ueAyMT8hUhs3r6+kl7hmfyMbYYr7/O0TORaPp93zQ/8iOIx9uBsBvwgvSuAN2uk=@lists.denx.de
X-Gm-Message-State: AOJu0YwUf7qpLZ6cLh+FOBipsw44PyAOVRvWWbHz1fq4vBrlBRsC3egp
 UpTkULkPMqIoMywMuoAhp/wimvmxv1HPJrJngdGiIBlLQpZwjtOvt1I3LS6di3kgYB4uP1G+Jg3
 uq/8=
X-Google-Smtp-Source: AGHT+IEWPfqYSPX9Bq9nvDQ18+oaaEDMFUAt9E8XTvZV3uhIvMQuzZge9ZTyfZdr3I6xiaSBwvS93w==
X-Received: by 2002:a05:600c:35c2:b0:426:5dd0:a1e4 with SMTP id
 5b1f17b1804b1-42abd111aa5mr26812035e9.8.1724275357360; 
 Wed, 21 Aug 2024 14:22:37 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42abee86d5esm37481805e9.15.2024.08.21.14.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:22:36 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
Date: Wed, 21 Aug 2024 23:22:16 +0200
Message-ID: <20240821212218.2092540-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Aug 2024 03:15:59 +0200
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

usb_gadget_register_driver() called by probe will initialize the USB
controller which enters ready to connect state with pull-up resistor
enabled.

From the host's point of view, a device is ready to be enumerated.
However, since dm_usb_gadget_handle_interrupts() is only called when
ethernet function is started, at this stage USB events are not managed,
host's enumeration attempts will fail and resulting error like:
    usb 1-1: new high-speed USB device number 50 using xhci_hcd
    usb 1-1: device descriptor read/64, error -110
    usb 1-1: device descriptor read/64, error -110
    usb usb1-port1: attempt power cycle

Disable USB pullup to prevent unwanted enumeration attempt.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/ether.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 7973927e8a..c864beeaa7 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -2459,6 +2459,8 @@ static int usb_eth_probe(struct udevice *dev)
 {
 	struct ether_priv *priv = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct eth_dev *ethdev = &priv->ethdev;
+	int ret;

 	priv->netdev = dev;
 	l_priv = priv;
@@ -2499,7 +2501,14 @@ static int usb_eth_probe(struct udevice *dev)
 	priv->eth_driver.disconnect	= eth_disconnect;
 	priv->eth_driver.suspend	= eth_suspend;
 	priv->eth_driver.resume		= eth_resume;
-	return usb_gadget_register_driver(&priv->eth_driver);
+
+	ret = usb_gadget_register_driver(&priv->eth_driver);
+	if (ret)
+		return ret;
+
+	/* Keep pullup disabled until interrupt is available */
+	usb_gadget_disconnect(ethdev->gadget);
+	return 0;
 }

 static int usb_eth_remove(struct udevice *dev)
--
2.45.2

