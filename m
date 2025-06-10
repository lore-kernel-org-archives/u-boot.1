Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9813DC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 08:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFF382B20;
	Tue, 10 Jun 2025 10:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="BEhR74Pj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C088070C; Tue, 10 Jun 2025 10:02:35 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B322280C83
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 10:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad89333d603so879311166b.2
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1749542553; x=1750147353;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kc4UBqs6mloHfQA782897rpvGt1rGMNv9OswzWdG1LY=;
 b=BEhR74PjtAPz6qcOcBmCAJrT8q+Em/9bILMzX/EnnoE17uSKfPExsmTixBQkV/GMx+
 brKp7NtTNXuUM5W1mMDPLRSXZuakcHMvWLSTukDovgizCXHggIp3Z0jlP++jOQIqLdum
 EsZIpGvLZZ2PjZpjZKCA2c7B/6rQzRNUiHMU/Qqs3mxmQ95rn5kZEJ1P/kcOalY+yrHp
 xrfsoju6y/atn65UTA67l7lEcl7dGXwBvpS+60l4N+tVV/VHREejt4Y+gpV28yqukodx
 RGHGj+XYnAOMuQWOweadNIsyBWEyAEuxmSvAsv/B6/6ymAgqeD+5iMkMqe+TfcBVWwPD
 YPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749542553; x=1750147353;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kc4UBqs6mloHfQA782897rpvGt1rGMNv9OswzWdG1LY=;
 b=bwVPq9KOqZLCAVWa5qRkeb2tvdhZRwoef2wAe6XGNxMBgq3Ep9NEQb3HZmV5liGHjG
 Q9RilNegl0bWu7re0PqKF1aJBHHAsJDdWD/YMYcNZJYyYaNmOyWznHCl+qTKlgX0vJHQ
 SOnWY9vKMp9LJ3lJHFD/9TTxfUEdkmkESEvu3Kba1sJmAN7EFu8zAUc9Mw+5noLP5ayI
 R6FHUkhmS0kViA8eloq6TuW+q5IeXdSyCumOfP/QiaFd7gX9dErB2m49Cekyhj08WIES
 PrIAvIelyPHNS0ZKKadKgSK8XrwuFWUdRhzDTIzExVqzZNl+YUT/m9vXeDpSIWUPjSDT
 jsTw==
X-Gm-Message-State: AOJu0YwxrOaVO2Vc4YqJiS/ZakFsxtwse0KjgyR2WsFfZ9n6QMMmG7n2
 xAnFNy88VUdIEr1aGFt3oh5167nGDV7fIEg70Hdjl6dHd8mGYwljTdczRx3g92BlFMY=
X-Gm-Gg: ASbGncuCggNAiaelPpPn0CrgGt33fScb4JC9jN3ngxIswi8k0HiFuNbi916Gftt94rA
 oZu8kkBKT3NH4AGUyK/j3Saomi16QCutKxXwZvJLd2LEABsXRt3ceEYZfiDoUHi9vq5wGWoS/EI
 XS3dvfl/9OyLKbHR2OhyzaBXcuiJwVfN3bjUJrVwDDDufFNwisl67ln+oEifA94hLWcomWhOWF1
 efS9Kq5UTyXR5uUQR/eVDZ8nGDWTurkJ3H2ZC61hGRyuoI/Fexg3YY94etBQlc4z5uvCZyeFJN5
 xeNugI5g8qwhh/pXoqmTzzAfmfLp0ER34kYy+J2ZgeZoStWnjYtKfONc9BP5c14rRcG2YIk5FFc
 =
X-Google-Smtp-Source: AGHT+IHWiFgIwa7eFsgHIRx7Y06eY69To/N2WlZzkbLqwzM+nrNMoB0ljTZOVosp1R1VD8uhX7YbhQ==
X-Received: by 2002:a17:907:944b:b0:ad8:8529:4f7e with SMTP id
 a640c23a62f3a-ade7ad57bd4mr138713066b.53.1749542553080; 
 Tue, 10 Jun 2025 01:02:33 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade343eeea1sm578233766b.74.2025.06.10.01.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 01:02:32 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 10 Jun 2025 10:02:09 +0200
Subject: [PATCH v3 1/5] usb: onboard-hub: Use the ofnode to check if the
 peer-hub was probed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-usb_onboard_hub_cypress_hx3-v3-1-53f03dbc3017@thaumatec.com>
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

Currently the check in usb_onboard_hub_bind is relying on specific
compatible string for the Michrochip USB5744. Replace this with
more generic approach that will allow to add new types of devices
to the of_match table. Because the driver only needs to bind one
"half" of the hub, the peer-hub node is used to find out if it
was already done. In case peer-hub was bound, -ENODEV is returned.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index d17c85dd6225..7606362a4ee6 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -10,6 +10,7 @@
 #include <asm/gpio.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <dm/uclass-internal.h>
 #include <i2c.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
@@ -179,8 +180,8 @@ err:
 static int usb_onboard_hub_bind(struct udevice *dev)
 {
 	struct ofnode_phandle_args phandle;
-	const void *fdt = gd->fdt_blob;
-	int ret, off;
+	struct udevice *peerdev;
+	int ret;
 
 	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
 	if (ret == -ENOENT) {
@@ -193,10 +194,14 @@ static int usb_onboard_hub_bind(struct udevice *dev)
 		return ret;
 	}
 
-	off = ofnode_to_offset(phandle.node);
-	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
-	if (!ret)
+	ret = uclass_find_device_by_ofnode(UCLASS_USB_HUB, phandle.node, &peerdev);
+	if (ret) {
+		dev_dbg(dev, "binding before peer-hub %s\n",
+			ofnode_get_name(phandle.node));
 		return 0;
+	}
+
+	dev_dbg(dev, "peer-hub %s has been bound\n", peerdev->name);
 
 	return -ENODEV;
 }

-- 
2.43.0

