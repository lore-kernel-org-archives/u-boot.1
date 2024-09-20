Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320EACF58F4
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA35893A3;
	Fri, 20 Sep 2024 11:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AIvpZgfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB8C893B7; Fri, 20 Sep 2024 11:06:18 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 482B78939D
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 11:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5365d3f9d34so1886833e87.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726823175; x=1727427975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCNjvsD2ieHNLA/E+D0J6i5ZklvAC50CwRb7svyQduk=;
 b=AIvpZgfscI0IwzoO+FSsNGrozBBLhkqg3s3BiqkgGZcM5zJMfBG4hvK3rQFisgVYBN
 8tLldglzU3u0eXS/XOD40PK2UFKtK3Y2iT5HMPVeMa9uJxTqhfK/pxqUpnCEvf07Vw60
 jnI80RqAxARimoqVw5TI/qXS72naebDiuMJHA3wFr09qf47GM0z3cRaNqQ/0LwSrKqTc
 8BUk53Ky+lKctJ0PUoXEm+WcH+Ol319B+4G6xT4XX+LTjPoPxKsvscnTkpIPLNDM+XMZ
 fxbx026hsJPBeh/i4MdNqqveq+qt/RWmuyhyXciS/WBq/BXP8aujSeXrK991qVq1yJ7b
 rgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726823175; x=1727427975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCNjvsD2ieHNLA/E+D0J6i5ZklvAC50CwRb7svyQduk=;
 b=qcWLN2CT9eT+0L/uTF5Q8GLhfQjXpatAkXUcxxuvWgck3RHfjOFSebGGq+JXlelM1/
 elSCeNSDq2TtuEcqtgy4Q3LIgprvJNnnlspMy7+OMvBgZ+ImVyu8lDBb+2Gf5auvU5FO
 jegDADVedvWT6RD2eHeOIpD/hLZSx5AJ690Ahl8bLyYnTvoBF2pu7r91Bgi63Apjpk6S
 nqoYLgFmFtLtC2Qung9L3xBMOHOUVVmQNNIFPRQKBQjxDt4ppO3Gayjriy9uatXWriDJ
 vHNh8Zpg0LE2HUWRFhCvpxkTC5HJHtH4PfS7DC+/If+QvK8V3DJAEg+/FE6AqUnxcYHO
 FJJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzWc08iM6Uh3YvPpnxhFyVtx8pkFePdrQfHsXsubOZ1T0ciORtV7AqWbLW/rCliIx7e9H/9xQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0vRyT4aF7Tt9WGVer3fa9ZMfEhMWTtBwfgBe1TS9VqiFK3E/G
 Mn1lDfJ8ai5pQv0VldkAxaGT1Yr1LGjH8cPb7b3NLzwO/4irtkM7
X-Google-Smtp-Source: AGHT+IHIZWfyp5S2o2U1oUNm9jHeRLv4USPPZAsbVq53uO4gM6zhTuFJO5hWepD+bak0gdENfnr50g==
X-Received: by 2002:a05:6512:683:b0:533:4620:ebfb with SMTP id
 2adb3069b0e04-536ac2e5ae8mr1066918e87.21.1726823175320; 
 Fri, 20 Sep 2024 02:06:15 -0700 (PDT)
Received: from wpc.. (host-95-152-62-174.dsl.sura.ru. [95.152.62.174])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-536870a88cbsm2088682e87.222.2024.09.20.02.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 02:06:14 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v1 1/2] gpio: dw: Add ngpios DT-property support
Date: Fri, 20 Sep 2024 12:05:23 +0300
Message-ID: <20240920090532.280504-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920090532.280504-1-bigunclemax@gmail.com>
References: <20240920090532.280504-1-bigunclemax@gmail.com>
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Starting with Linux commit 7569486d79ae ("gpio: dwapb: Add ngpios
DT-property support") the "snps,nr-gpios" property was marked
as deprecated.

And since all newly added dw-apb-gpio nodes are described using generic
"ngpios" property, it's time to add support for it.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/gpio/dwapb_gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/dwapb_gpio.c b/drivers/gpio/dwapb_gpio.c
index 7a6eae9ba1..04639a4cb6 100644
--- a/drivers/gpio/dwapb_gpio.c
+++ b/drivers/gpio/dwapb_gpio.c
@@ -177,7 +177,9 @@ static int gpio_dwapb_bind(struct udevice *dev)
 
 		plat->base = (void *)base;
 		plat->bank = bank;
-		plat->pins = ofnode_read_u32_default(node, "snps,nr-gpios", 0);
+
+		if (ofnode_read_u32(node, "ngpios", &plat->pins))
+			plat->pins = ofnode_read_u32_default(node, "snps,nr-gpios", 0);
 
 		if (ofnode_read_string_index(node, "bank-name", 0,
 					     &plat->name)) {
-- 
2.45.2

