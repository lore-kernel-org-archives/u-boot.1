Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF2AC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 08:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF06A87894;
	Mon, 23 Oct 2023 10:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b630A17E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D2D87890; Mon, 23 Oct 2023 10:21:24 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31D287894
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53ebf429b4fso4577975a12.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698049281; x=1698654081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7K43MftvtNXuVCGGeRqJqAitJr3GgibjiqGMHqCvIDA=;
 b=b630A17E903H6G8N1MNIxgMkHE6ETshDj2suUHMrhHkv5GJ5IZwVcAkuJEiom4Fqml
 ZzC3oenvgIJgpeUqaGLqCCV3PNEgs8VxksAvxaPp3b5zkLW6mVuvZw7wgQetj1XTCwsY
 S431gGAe91MRI6hS+ibjI1AgQjpE29Xb3EyCUKIvqeE/qNELmVdvVMLzamK9w4saSgL8
 wzNTHEDJIxKpIs6wbG8bnL5kxIgwx0W1mCs/liA657CozOa4Q6R4pKEJh9ydR+wcJbwH
 7A34F34us4R5MIFw+zEGYKDNn+SU0I5tz7wAfrc0I9MDND9O61fGnO67ddVIq22rlcAT
 eVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698049281; x=1698654081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7K43MftvtNXuVCGGeRqJqAitJr3GgibjiqGMHqCvIDA=;
 b=h4s78S0vwpFRmlc3QJhNOPLQmlNl7QUwh3P4AzYSCKnr3fnXoYAgskSa+gfB6c88sx
 RQGp4vvBAyyn9T+0kJZFAtm9jOTb1dAQ2RRB5jLBt/GUqids++ARX5/FpAKVGLdWv4Fx
 k7ONFrJHOjNlfnG9zhsKJFueJNQXzSTB0Vm8mUYa58OgYgL1Yze5kXSx3QUve8NWhWsJ
 iRhnVqV8VL9oIrWqvOlDr+vtnj13WaVeMGsiU8ZNAucMC28EP+yKgQbeUrPEsv0zZKYf
 Mv/D1FJfwyJuc1W93wrGwgH+GDLhsFwSjFpxHLCPUqVdLS4TAz8JHNm+p+iy0Vwozipx
 RW6w==
X-Gm-Message-State: AOJu0YyaK7hQTh3iDEC3eUeJ4zyJwekJSV1rUS4mpU1hPWif00RjMQ8T
 Oierln6fa1MKPZQ8OPAHv4A=
X-Google-Smtp-Source: AGHT+IFMAgtel7bpjhYraWT6SEYhezwc9cZe9Aqpu0u1G0dj91fxTPe3BVol7hON4XUEoKfatGTV7Q==
X-Received: by 2002:a17:907:3fa2:b0:9ae:56da:6068 with SMTP id
 hr34-20020a1709073fa200b009ae56da6068mr6676234ejc.57.1698049280843; 
 Mon, 23 Oct 2023 01:21:20 -0700 (PDT)
Received: from localhost.localdomain (80-108-76-242.cable.dynamic.surfer.at.
 [80.108.76.242]) by smtp.gmail.com with ESMTPSA id
 cw23-20020a170906c79700b0099cce6f7d50sm6249235ejb.64.2023.10.23.01.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 01:21:20 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de (open list)
Subject: [PATCH] led: Do not overwrite label
Date: Mon, 23 Oct 2023 10:21:17 +0200
Message-ID: <20231023082117.39290-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.41.0
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

label might have been set by a non device-tree based U-Boot driver already.

In my concrete case there is a PCI driver that uses device_bind_driver(..)
for different class types. The UCLASS_LED specific driver sets label
in its bind function.

Without this change the LEDs exposed by the PCI device are not available.

Fixes: 83c63f0d11 ("led: Move OF "label" property parsing to core")
Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/led/led-uclass.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 68ca3c2970..aebdfdeb95 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -71,9 +71,10 @@ static int led_post_bind(struct udevice *dev)
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
 
-	uc_plat->label = dev_read_string(dev, "label");
 	if (!uc_plat->label)
-		uc_plat->label = ofnode_get_name(dev_ofnode(dev));
+		uc_plat->label = dev_read_string(dev, "label");
+		if (!uc_plat->label)
+			uc_plat->label = ofnode_get_name(dev_ofnode(dev));
 
 	uc_plat->default_state = LEDST_COUNT;
 
-- 
2.41.0

