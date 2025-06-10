Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5587DC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 08:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F06582B7C;
	Tue, 10 Jun 2025 10:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="aqDWjXIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E70F82B70; Tue, 10 Jun 2025 10:02:37 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99050805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 10:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ade5a0442dfso326781366b.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 01:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1749542555; x=1750147355;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3+PBw+GyItqe5/sId3XMJdHLEiDofkbcyuZb1BVCvTA=;
 b=aqDWjXIWzcf/jqX6OB3guvZdp03a8fChOyyhZ8dvWfEB5izqbDv7/Q7ajhRH5gAEPc
 qWNBtT3GVqqqT0N3e2waqcH+4HdhiY2muv5wAeytISYFoJPjCIhNpbZLVn5/M3FNNQUb
 rvibnnGH5wAiJnvSq/gZLQEUfRYtlcrKQx8NCzFlBAKvaRJoWzZmREkvLY3vw9gKolcv
 BKFtqpC2Glb7QuLh9dtrnVtMjmbzdgxJDHXcn+xw23ej2wIYrj/VMVRk5tQTRNoRFr3u
 xoG/iBUqdKHBB9IoMAeS9tF9AV5V33Y6zpHhfQkYFEAPYgposywR9ejRVkS2pFDpPjrW
 sylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749542555; x=1750147355;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+PBw+GyItqe5/sId3XMJdHLEiDofkbcyuZb1BVCvTA=;
 b=MWz8fLR8TtMUfP/CecbHaLOUZJALw85dtzV+/Gc/yHXuazTxgJl1hXQi79spVi1wcM
 I/lsP3q9H5odvylPgShrZYpBDZonTk5te5r8gMdlmShpPr1coYTmvmfgQNraynmOhLW+
 J6IEo+3tMZklTthJUdXaLhqHbj5iveXsJVIv8Hv5Ndaq2C4b3WZnxRhviiZSmfh3bNX1
 nvS74xjnmV3dWqfntjtnTULUTrHr7SH/FT7wIRriXxTG80AbRWkcCvSnvLizrL44uhUi
 VbuMFWbz3WNOzG17s+xUjRhoCGIeuGP9yR8n0Jbxdcjb4Y5Aee5d5ERIALVmZpfv8FeJ
 KBDw==
X-Gm-Message-State: AOJu0Yx9qT118BZnIMTjwezC1P9RHnZuXzuPF4niqb8TBnKRhMey4h/V
 EPjr+Lj8BRwCkyrDp1jA9cQd7+GFBYSrRy8o+1rgDWoIpGNoVuW1JWc507q5S20Jp8KiT3rV94f
 f75C8QeU=
X-Gm-Gg: ASbGncvgPB2DDzeTvFtGSFd8LWmz9EjbQ86qugE65vxO0oFgKJK5mTZtakBvs2FU7GT
 Nkw639IfMJhqwqR18jWA0P/AysbKxo62qk0nhuchAhz4LELvNUB6BZBcVYMPuGgdZgJ5WvS3IGc
 iu3JjEUYHyDHXnLe9KNYByXo43n+YIvOEyEhjzB2tCabsAb0lzndcIyNsnST7zqwDP8BIfe4dQc
 fd5b+lVbF5X5S2YYso0S9jOL+INjA8EQuRhZxtHDZl331cyYoZw6i0WmI5dxGp5xUzHuRTgAbiB
 a7vStrxn8rbJjbd0AYGA80Pyax+vDk0yow64dm5hhYDN+ltADPw36SCHuO/B3W7khNuGOdK6Xpo
 =
X-Google-Smtp-Source: AGHT+IFRvppcXyc/SIxoyMlepW0SBXONnONC3ibcrAfhPuq9GA6VntKT6XE9GEKAIv5zut6RH4ivYg==
X-Received: by 2002:a17:906:dcc:b0:ade:3e42:f5db with SMTP id
 a640c23a62f3a-ade3e42fa5dmr815721766b.51.1749542554959; 
 Tue, 10 Jun 2025 01:02:34 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade343eeea1sm578233766b.74.2025.06.10.01.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 01:02:34 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 10 Jun 2025 10:02:11 +0200
Subject: [PATCH v3 3/5] usb: onboard-hub: Set the reset gpio pin before freeing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-usb_onboard_hub_cypress_hx3-v3-3-53f03dbc3017@thaumatec.com>
References: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
In-Reply-To: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
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

To fix this, set the reset gpio to active in usb_onboard_hub_remove,
to put the hub into reset state.
However, in case the hub reset pin is by default held in high
state by HW before U-Boot takes over, in which case the USB hub is
active, then during the first probe it gets reset and we might get
into the same issue of the hub being not enumerated.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index c6379192fe8f..046831d09668 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -211,6 +211,13 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret = 0;
 
+	if (hub->reset_gpio) {
+		ret = dm_gpio_set_value(hub->reset_gpio, 1);
+		if (ret)
+			dev_err(dev, "can't set gpio %s: %d\n", hub->reset_gpio->dev->name,
+				ret);
+	}
+
 	if (hub->vdd) {
 		ret = regulator_set_enable_if_allowed(hub->vdd, false);
 		if (ret)

-- 
2.43.0

