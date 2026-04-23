Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4203FFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF8178452C;
	Sat, 25 Apr 2026 20:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NMYgcrxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C51B843C5; Sat, 25 Apr 2026 19:55:34 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E87684399
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a2c500750dso10002826e87.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777139731; x=1777744531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZJsF/SIXHryU4KwjexawA+A5CVrR5oF8K0fLNxx3HA=;
 b=NMYgcrxaIdTlR/+JLl1mfHgOnfaJY/eh9qz/LtTW7xZ3Fjbi484XciciYadlWA7Azk
 1KiNu9Jsz1kiJNgZHUxvCSsuaMcKmmbzW0jcy4ASR81TFU52mSVN2e5z4zDNX6WXcHGd
 fQxBAMrloOGqS2wqq/IfuMJNi8zhVThK2TxYb3P0/Mpnac08P7pXRVe1vR8OKRArpPah
 LRCVDte2Z4rliCwInX9wkBKnrQJRpiGiV9VxaS47P5/iO1Xyk+IQVq3bkI9ic5dUEhaD
 XMDm2AknmZiG5F5cNz/BEn4PqGZUrUWXVJII1I5GK8ZtqX3HvpP2pbsQ6z7AzhGw7yqZ
 TM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777139731; x=1777744531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wZJsF/SIXHryU4KwjexawA+A5CVrR5oF8K0fLNxx3HA=;
 b=qgY61p3QvSxpj1RZ08uktl0zie7MqjYhuvfodlSohmR5bz/uOj5UW7gH2yILf7Yy/d
 39LC4PQu4MQV4R/ySBLeZzVvt9C0xdql0BugIkMmh3kKdve2YczmhPfYpRI3RMJd+idr
 tS+hZzHiT25Wh8OsIxmzAHNllrILqyE30YESizDeWfQj4vFjN5d1/iY1E5jPHMkwYINT
 kqmZUSPf119yhSk8+vSKhBVbpSSR3j/ikanpKnSOfoOTe5C6W/xaUoFQpD1fbpNuFKRg
 uBRJS9Kfi/YKD9YRUT+DsbhLzD2hcUk1l9kY7/k2Se8P4+3hJZN/5WU2vY0LdSvrM3Yn
 KVmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CGNVX5SakPsi8cGO8qXn5rPRzCTMrv2si+CCm4sXoOQseuuidVPSjvOEPPU5U9TfU0GUySgg=@lists.denx.de
X-Gm-Message-State: AOJu0YyFMn4EmJxL5+QGItuw6j6llf+ILQvz5vXomJ452niB+ejWQ3u0
 p2q9R87wN+xx7pv9ZztXfqS6NYSXYQzewWIfxajkanGnJoCKLaYAVa7DEr9naQ==
X-Gm-Gg: AeBDiesJR6+YFfTjXC6BoQ6eeSHGq26iGAQq1ruVp+bQMWgfdHTGmCb2/QhyR4Rr8kF
 NgoB3BxNsDeR+HNXHt4VDZun+9500ZADe9rd5xVAUM9PVhTvCWEsL9ILi71Yq+JYaY0w+8vDeKY
 Q2OEyPFRvjy2GlbZJSqzOdkLxsP9HseWgkK7eqvCb5SXZEdz+lATzlDCFE/vyEbRl2UBirJZoHc
 5fxyR2n2NqNKQEC8MQwl14pubyK8tfjMJA4ZUN9c/au6JP5mNb8VsMJavmiNTDJzfOYh1ZJkwdl
 Dmc2bRefq3Erdu+esWuNQmV8n9THavrrxEZtBU7Whu9ONCD8UneCcJWuABz3+B4rD7nhwSQft+5
 hZRa1ptsPRT9zNzhoS9L2Tr0F9ekosT7GnYWgSYA55pSsN1p+MCM8IIRky0JRhcFzS3EcVC6Ogk
 l2pb9mW0fSP80YTi2MXRs51wtlIkE8DZu2Lejdnod73gF02IQQ8Kc=
X-Received: by 2002:a05:600c:c085:b0:486:fbdb:b718 with SMTP id
 5b1f17b1804b1-488fb784948mr296260545e9.25.1776949424934; 
 Thu, 23 Apr 2026 06:03:44 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm549381425e9.2.2026.04.23.06.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:03:44 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v5 1/3] usb: gadget: rcar: Fix gadget registration lifecycle
 in remove
Date: Thu, 23 Apr 2026 15:03:21 +0200
Message-Id: <20260423130323.32533-2-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423130323.32533-1-micbis.openwrt@gmail.com>
References: <20260423130323.32533-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:03:18 +0200
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

The driver currently fails to unregister the USB gadget when the
device is removed or the driver is unbound. This leads to dangling
pointers in the UDC core and potential memory corruption.

Add a call to usb_del_gadget_udc() in the remove path to ensure
a clean teardown of the gadget interface.

Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
---
 drivers/usb/gadget/rcar/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
index 2ba022a3f2c..d40d6736a54 100644
--- a/drivers/usb/gadget/rcar/common.c
+++ b/drivers/usb/gadget/rcar/common.c
@@ -447,8 +447,11 @@ err_clk:
 static int usbhs_udc_otg_remove(struct udevice *dev)
 {
 	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
+	struct usb_gadget *gadget;
 
 	usbhs_rcar3_power_ctrl(&priv->usbhs_priv, false);
+	gadget = usbhsg_get_gadget(&priv->usbhs_priv);
+	usb_del_gadget_udc(gadget);
 	usbhs_mod_remove(&priv->usbhs_priv);
 	usbhs_fifo_remove(&priv->usbhs_priv);
 	usbhs_pipe_remove(&priv->usbhs_priv);
-- 
2.34.1

