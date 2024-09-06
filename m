Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72720EB64C5
	for <u-boot@archiver.kernel.org>; Sat,  7 Sep 2024 13:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDBC288847;
	Sat,  7 Sep 2024 15:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eR+n5oA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB13D88D5B; Fri,  6 Sep 2024 23:25:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F7F288966
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 23:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725657913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zv0MANpsoWotmc6+bVL4GFrlRSKDQuQYPlrpKkksRss=;
 b=eR+n5oA8/TaGWoonvC9QD5MyM3zpkPq54KALErXKLiK7mZ61qwW7v9VqeF2fA5Gjwmg665
 J0pqUtdhSrMm2wcElLvsUiy9rW5i+gWosihMC/tKTXIpxooKaq0UegBHtYbwtmwDMKoCJv
 CNF7B3hqYeKmnDZuBTW4ndXjkQukCnw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Pl1d5bQkMyiX04gj6Cbz0g-1; Fri, 06 Sep 2024 17:25:12 -0400
X-MC-Unique: Pl1d5bQkMyiX04gj6Cbz0g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c358223647so33970806d6.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 14:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725657912; x=1726262712;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zv0MANpsoWotmc6+bVL4GFrlRSKDQuQYPlrpKkksRss=;
 b=IZX0DttG9Cac6bzd9j2PlTniCNWoeOtUrHAQCjvhhbVUXaVliJwvOvlkkVlk1oP/UP
 naVN+nyjuOdVezm+ijtSBIK1jtMoaLRbXgYNUfhzpXiQe3DvGmIgEJPr6DY7VFnaekwC
 5jNo+AYKQ24D0HyOnMfdXmuI9wBn9IjSpmCJ5RaS7ryM2fgKimGoH0ClMYlbQLl6yoAP
 tVjiIJCAF+Py9jSxmM6jPnlXI7VQceZRW18t8LVrzizMRQzQkIn/eVO0+6q9Xr1Q1wR9
 5BLWK186Sv1sbCgtaiNvKoJFofALEUUFFuewohV6Lpf0/u1usvWXBOQmv4cjrCgBfLQs
 PmGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv5RdKyZFrbb5O4mIn0qv9vu6POgWsloNWIJO2o/B9QNPI73CV9VEXkSNUvwsRKVoUJEszPFk=@lists.denx.de
X-Gm-Message-State: AOJu0YwaPolEbtVs33y/CbxJ6a5CdgXY+76ZUzvSuJkqEOfxjCFU7CKx
 rxW5g7hWxPGTfvsLFivAjuErNXKzRIuZCSaiV0MtDyU2zxjOSCfXPaFwRWy6EoWMXi2Z6q2rXOZ
 IhuAbO3GMS7ztiYcwdJjD05OcBiN3nWEhY23q2Tbw+PAi2dXncaQ=
X-Received: by 2002:a0c:e588:0:b0:6c5:32a5:567a with SMTP id
 6a1803df08f44-6c532a55718mr4787566d6.1.1725657911715; 
 Fri, 06 Sep 2024 14:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC58TCfUFiokGDMclf8DCBmt6xXIruEUMSOa/48Wev3+oKhGGPfSp8HZ2GUQsbQu2nLtXYrQ==
X-Received: by 2002:a0c:e588:0:b0:6c5:32a5:567a with SMTP id
 6a1803df08f44-6c532a55718mr4787216d6.1.1725657911227; 
 Fri, 06 Sep 2024 14:25:11 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5203148f8sm19967006d6.86.2024.09.06.14.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 14:25:10 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Fri, 06 Sep 2024 16:24:52 -0500
Subject: [PATCH RFC/RFT 2/3] board: ti: j784s4: Initialize the ESM & PMIC ESM
MIME-Version: 1.0
Message-Id: <20240906-j784s4-esm-enable-v1-2-b83b17d5a744@redhat.com>
References: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
In-Reply-To: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
To: Apurva Nandan <a-nandan@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
 Udit Kumar <u-kumar1@ti.com>, j-humphreys@ti.com, 
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 07 Sep 2024 15:02:07 +0200
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

From: Keerthy <j-keerthy@ti.com>

Initialize the ESM & PMIC ESM. This allows things like
the watchdog to reset the board when tripped.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Link: https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/board/ti/j784s4/evm.c?h=ti-u-boot-2024.04&id=9d8b40958ce792808bc571d828197dbc2e7978d6
[halaney: add a line to the commit message, include header]
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 board/ti/j784s4/evm.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 548dbd5925d..a0ef3a44536 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <dm.h>
 #include <efi_loader.h>
 #include <init.h>
 #include <spl.h>
@@ -72,4 +73,31 @@ int board_late_init(void)
 
 void spl_board_init(void)
 {
+	struct udevice *dev;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_ESM_K3)) {
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@700000",
+						&dev);
+		if (ret)
+			printf("MISC init for esm@700000 failed: %d\n", ret);
+
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@40800000",
+						&dev);
+		if (ret)
+			printf("MISC init for esm@40800000 failed: %d\n", ret);
+
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@42080000",
+						&dev);
+		if (ret)
+			printf("MISC init for esm@42080000 failed: %d\n", ret);
+	}
+
+	if (IS_ENABLED(CONFIG_ESM_PMIC)) {
+		ret = uclass_get_device_by_driver(UCLASS_MISC,
+						  DM_DRIVER_GET(pmic_esm),
+						  &dev);
+		if (ret)
+			printf("ESM PMIC init failed: %d\n", ret);
+	}
 }

-- 
2.46.0

