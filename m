Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A27CC369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F0982063;
	Fri, 25 Apr 2025 12:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="vBaGdeNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D533B81F7E; Fri, 25 Apr 2025 12:56:41 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE4A582063
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f5bef591d6so4032796a12.1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1745578599; x=1746183399;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JzaKZtAXJj5Xdes9Q49yn3f0//9brsAJNnMgo3Z19C0=;
 b=vBaGdeNzrZRn3YfLJohK5v9hj/0vrRgbpWbT/kAvbubvJkKxL5/UETElhmnVEsiwkF
 BTNtunbkq0Imcdn0v2S+YQtPyLHzx4TYNcWIngLGlIYYzBOxoO1nW9N5CyRjEg6Cduwb
 3Q2/dj971Za+qUjBK2V3VMdCo4ngNIImh4JKKESHOOb0ClEdxVDSrKVExVjS25bqc7SH
 s+ciD4plMboJM+UVHA6W7JC9xTCr1Jz4gFgR5TpXYSennusGNn49dvWVO0JEqisFSnrb
 pXoHuzSFg27PEFiosVptiVrL778qyqicBN+Lea9MyhWPsFjgkRLu015WhCqqUwXEstb9
 bh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578599; x=1746183399;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzaKZtAXJj5Xdes9Q49yn3f0//9brsAJNnMgo3Z19C0=;
 b=vYPZpGWxCRKxHGT+8xwop+kg0dofG+uYpOrO74LFEMNiwt3a65F26ArJHJp0NV64ju
 8tOadA2hxrmVt2Tsovyz53Ovrn6IqoMr7ZrdGFbgVa023kQWGOEvgd4fhGIPQ29tJh/5
 QnTD1p8NUKAWHO/zYAV01qvh+D5NxqjvPlDhnkROsoCl/am4v0pS+zmkSeWXKfUgf+pw
 J28+ra29i/6rR0ITLWqTyysigIhhZTiekEMHvMfEdGx6zQGSxvHfvxtI6JZqM5YVkQFx
 QLucjqdSpAN1B8lrUwZIwZx1w9vi2GDE3Orbx6U2BKhM59oV8FWdHAXI511NiUgVuf7j
 QCsw==
X-Gm-Message-State: AOJu0Yxu6P/mdbVQatmoxP4LKVUw8WJv2rzsw9xVOdiYg1s9vkufI3un
 +/AEZo//JArMuwkK80J8HxxN78nXQLV+LlKccAsHAJK1ZFD15cR9O/O/bupAcpSm2M98JyEN3sN
 K
X-Gm-Gg: ASbGncvO08+C1lIeI+dwloJsl16Ykj4ELThJFdFIiV1spJYheiMzP3M21O7p5Ssd1ap
 so/x0TO1E0lBO6TseyUUKJ/VY3HNwekoKdfQgTnf07c5zFj5etMyNxM2toScnVjqjSECsacPusO
 6i8Makv4oWykrsmUfQf74HzuC93Xgn29qPIdZoh6IaVcbXAJQhoLn4fNFG6kUfPbKV7Nh9tXplV
 YSf7fLIkiLF4ERb11QavTY1KwpBMHVsZ6y3kQUxulb3KEjwWowmzA73I4dZB/1QyFvSH9CyPmUp
 JDnV7AW9NqPj3XtKBxNpRbRhjcnDM/tUq9HG+YPBFNWdICCVxVgM/KIZgw==
X-Google-Smtp-Source: AGHT+IFt782MaLsVYbuSucsZ9GlW5xxzNiAohrB4eSE+8Px0JeJm7DgFK2sPwFQn5omHD6XEF3jPAQ==
X-Received: by 2002:a17:907:26c7:b0:aca:a35e:59fe with SMTP id
 a640c23a62f3a-ace739dce06mr148576666b.1.1745578598867; 
 Fri, 25 Apr 2025 03:56:38 -0700 (PDT)
Received: from [127.0.1.1] ([185.164.142.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ecf8978sm116839566b.98.2025.04.25.03.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 03:56:38 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Fri, 25 Apr 2025 12:56:33 +0200
Subject: [PATCH 2/4] usb: onboard-hub: Set the reset gpio pin before
 freeing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-usb_onboard_hub_cypress_hx3-v1-2-3cc5a06087cf@thaumatec.com>
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
In-Reply-To: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

In the usb_onboard_hub_remove, the reset gpio, if available, is
freed. The pin state however, remains unchanged, as set in the
usb_onboard_hub_reset. The hub is then left enabled.

During second onboard hub probing, the hub is initially enabled
(reset pin in state "0"), and then it is being reset by the reset
function (transition to "1" and then to "0"). Because of this,
the hub first disconnects from root hub, and then it connects again.

When the devices are being discovered in the usb_scan_port in the
usb_hub driver, initially there is the USB_PORT_STAT_CONNECTION bit
not set in portstatus, but USB_PORT_STAT_C_CONNECTION set in
portchange data (which is because disconnect event occurred first).
In this condition, the driver does not wait for devices to appear.
This can cause the hub (and all child devices) to be not enumerated
when rescanning on "usb reset" command.

To fix this, set the reset gpio to active before freeing, to put
the hub into reset state.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 9f8c1a304cdf..325c274ed952 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -211,8 +211,10 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
-	if (hub->reset_gpio)
+	if (hub->reset_gpio) {
+		ret = dm_gpio_set_value(hub->reset_gpio, 1);
 		dm_gpio_free(hub->reset_gpio->dev, hub->reset_gpio);
+	}
 
 	ret = regulator_set_enable_if_allowed(hub->vdd, false);
 	if (ret)

-- 
2.43.0

