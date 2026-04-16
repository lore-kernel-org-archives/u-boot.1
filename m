Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9726BF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EC7B8445A;
	Fri, 17 Apr 2026 14:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PtZjFjWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E14FD8423D; Thu, 16 Apr 2026 17:20:20 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC591840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-899a5db525cso63212716d6.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352817; x=1776957617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHAkMTmekNWYDlx47qWSJ15HH9sRN6KSWiRhITbcCRA=;
 b=PtZjFjWUGiE/U88g9el8yKgcWIyHGIDyPqsgrthKYRwV6RYTw3G9V3j+Lx0luSNrLH
 sWvTLveDtMxxjb/xmUrao1tt86HpBhCvkuF+BWi6MuDKVqkNw7dW/dSoYNIJ6ESyoUqc
 Y/CDFSeHyAroKhg9Rcs8kjCrlsqiDocNLz8BNEVXJ0U2FcEAcpMErenL0V5FcmHInJls
 KUk1TWPQlIYjkbcqQ+ndZCxr3YnJti+2/wrZNapahJYL/zjB6rRVO7vTLzhirx0YnB4p
 XoVIRhyVK+xJhduyW3+KNswcdgkxilRKJ/14VoPcNTbKaayXXpRp/6GidSKQiKtEHDj2
 fsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352817; x=1776957617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lHAkMTmekNWYDlx47qWSJ15HH9sRN6KSWiRhITbcCRA=;
 b=fKWhZuPR/6By2qNq9PPLQEktD9bBVe20JaO8GV50v8MmOAKr+hbvSKS0yNA7ivV1UH
 L31uYzH67YtO7JttmS8li5fh0pOYp1P9lOTtPykhLEJOMUDnAT9zzbzUJLjFzUXVYl43
 9xj35iZDydBo+wWX0oF5K4a3C/8lgvHaQ9qqi2qgtPDbaGh9h406TskRXiOzFzVW5hls
 TnF0Rqad8luWmaZ/2a5DF5PYZF+aQ85dyp3AArkZQ2hU0NznYo3t94Xop3xXJPa7elEl
 W2cwfW3wbchl8qLR2LYbZ2f4Q+VbIq9ewXHnnmrS8Wz6hQfmf26xfieZQ3nV0h32LXpf
 CrTQ==
X-Gm-Message-State: AOJu0YyI3+6SVHf0vT+W2/BNb/haqHTDo/7nHo1xRewCTR9KghfqNs0n
 2GyVYbGz8rJCa5/NjSqxZPewh/VC0EtI/BBDj4JGTuAzvv5rCrC3w4/jaTP+UM6O
X-Gm-Gg: AeBDietSFCznSQIYmN9UKb4f2WvkbuNKJeI9WqmZdjlmbv7arIKYdz8VSC/Zzb01o5a
 sKxb4Qdhb7oN2ZPAyr3gw9qlb0Soz5yjv+1gNHkDKrrBaJAvXvryxB04ZC42g7yXyoCcDkKqC0d
 CQia41aaG8L5UhSiUSrh5AvAxPFYJmuizaNm62FvTyYXXYt1nlIouVo9xn/M0aGA/hZQY3DpjUz
 2oZSEQWc+pevRqST86Tp/n365IM8ApA1kqmqOpSE10FUrlnbISsdXYTl+G0GsQZvl178nNJW2qA
 i9XvRgtioQ3MqfAD1t8oenbAlmUdOCDOg8XuzbG8d6FxUueorCpY1cCvp6cqKGJwxB/3+nvzqqI
 Ni3G5GXlxee8cXfHD3+JwHUicSCrcykO0S7ERxZf+WbrIN6WdFvcYdFgxlDMqviYQfx4qK7oGs3
 6UOujWHekbgfjKbuhbjfZrKys625TK2T0RTYeHyMfzP8sI
X-Received: by 2002:a05:6214:1948:b0:8ac:b053:2b38 with SMTP id
 6a1803df08f44-8acb053337fmr281870186d6.31.1776352817490; 
 Thu, 16 Apr 2026 08:20:17 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:17 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 05/14] mach-sc5xx: Add USB boot command
Date: Thu, 16 Apr 2026 11:19:40 -0400
Message-Id: <6564b0f416cb7581aee5d7a3ffaca62a2109c32b.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Add the USB boot command to the environments
of the boards that support it.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezkit/sc573-ezkit.env         | 1 +
 board/adi/sc589-ezkit/sc589-ezkit.env         | 1 +
 board/adi/sc589-mini/sc589-mini.env           | 1 +
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env | 1 +
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env | 1 +
 include/env/adi/adi_boot.env                  | 7 +++++++
 6 files changed, 12 insertions(+)

diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezkit/sc573-ezkit.env
index 51157ff36aa..36bd207f410 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -11,5 +11,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_SPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index d068b44573f..a4a686158ca 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -11,5 +11,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_RAM
 #define USE_MMC
 #define USE_SPI
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 3827cf4e9a5..2a322bc6761 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -11,5 +11,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_RAM
 #define USE_SPI
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 69d2ec3ba03..a4c72f2e9c7 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -12,5 +12,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index b6f477c8402..754dcece976 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -12,5 +12,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index eb098dd2256..d6caa95325e 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -68,3 +68,10 @@ ramboot= wget ${loadaddr} ${serverip}:/fitImage;
 	run ramargs;
 	bootm ${loadaddr}
 #endif
+
+#if defined(USE_USB)
+usbargs=setenv bootargs root=/dev/sda2 rw rootfstype=ext4 rootwait ${adi_bootargs}
+usbboot=usb start;
+	ext4load usb 0:1 ${loadaddr} /fitImage; run usbargs;
+	bootm ${loadaddr}
+#endif
-- 
2.34.1

