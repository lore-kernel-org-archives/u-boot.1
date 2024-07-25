Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F634C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2916882EF;
	Thu, 25 Jul 2024 19:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="o0ni4b/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84FFF88373; Thu, 25 Jul 2024 17:32:31 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81179881C1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-368584f9e36so577427f8f.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721921547; x=1722526347;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrDxins3VDmxPZcKIt3PdZF7NEcD2PQek2ITkWTBqKE=;
 b=o0ni4b/gmRGHXCZNrqxSCW2WBKKYNaocwXZFOsmiAqhRxYiieTNtIihltLAy+Js0h1
 VWzY9APItqfY+shlbFikBCpMu1WCb7/22CfZB/sKtaUQOICkN9WUEjZkjuh6b2qvcnb6
 xxEb8GambikphKCfFuqnmX8NLwC2zdal0QL401ecbX4DpGDDA+Zp3FElKpG2dCMZrFsb
 ADtZLkUtKWxEdqeI1UbZ5F0z3lCifPnrwkkHq51t8HBwllxOc+wQZdc5DS/5c40/KTS4
 PN1w81CktyYXQTGBcW/iqivRC9g7Qlo/ulWFxxlI7zr6XBSevYuCgzDkRrLAA6k96Xq5
 k93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721921547; x=1722526347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QrDxins3VDmxPZcKIt3PdZF7NEcD2PQek2ITkWTBqKE=;
 b=HpfBVdBwkAZg0wBk5RiORN1pJR1B+hhWx0Cymw09SFqRR0xxqI9viwCWCBPz4j+h61
 zlrBawx6lPY3ozX7RleXjtClXTpUOwL0ud8Sul/HbCxumU7ODu1Bt/PQJ0Y4uRGMAlkg
 tY5z6ZRbZqmEVdsK7eFpCfXB4jUSCIgGVuSzgqce8olMzRpXzOyUDPjpqKYolNMd90Lr
 Mw9DUMxdNkqIvNC34QSiq58x073i8VVPW+19s8ZQ8HKvDzG/C6dTKKrq2BVrLKWzVENL
 7iwsx2Q0hVnZH5yfkQKHQAlr4oeTOttIB3CNNzw6yiPPfEbuRE78cOnlrOtX3XEDflBk
 ojCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Zmhjxy1lMdsUW92jTTO5Fta9/HEszBMrvPtTx8HSldZJ1VFZIe9z4oKYVIas4h5Okg5KoGM08HBoErD8nMukA552HQ==
X-Gm-Message-State: AOJu0Yx9gxKW/cF3RC6gr0eMsXb/ki4vJlaa5WeLuT4SInZLM9SSlvFy
 zaJJgJv9a1wyjg3o1jXve0SahDs52STjWuZvyK8TvBWlb4xjfOs+MnaEV8rSjX8=
X-Google-Smtp-Source: AGHT+IF7getc6/gQecEvLC2O0ORU8hf3sHu4PqFvFnTLvxCC+Gi649evJMk0VHgxKrPHaG1hAOH1bw==
X-Received: by 2002:adf:f18b:0:b0:366:e991:b9b7 with SMTP id
 ffacd0b85a97d-36b363a2c7bmr1937418f8f.30.1721921547098; 
 Thu, 25 Jul 2024 08:32:27 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b54sm2530805f8f.95.2024.07.25.08.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 08:32:26 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH v4 3/7] usb: gadget: atmel: Fix typo in usb gadget driver
 register and unregister
Date: Thu, 25 Jul 2024 17:31:57 +0200
Message-ID: <20240725153204.358925-4-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725153204.358925-1-admin@hifiphile.com>
References: <20240725153204.358925-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jul 2024 19:14:03 +0200
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

Replace "paramter" by "parameter".

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 4641638412..2e3d8f36a2 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1204,7 +1204,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	int ret;
 
 	if (!driver || !driver->bind || !driver->setup) {
-		log_err("bad paramter\n");
+		log_err("bad parameter\n");
 		return -EINVAL;
 	}
 
@@ -1231,7 +1231,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	struct usba_udc *udc = &controller;
 
 	if (!driver || !driver->unbind || !driver->disconnect) {
-		log_err("bad paramter\n");
+		log_err("bad parameter\n");
 		return -EINVAL;
 	}
 
-- 
2.45.2

