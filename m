Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9595C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 09:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03664880AE;
	Fri, 21 Jun 2024 11:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T6eHDDo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A125F884B2; Fri, 21 Jun 2024 11:46:19 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DDF88013
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 11:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robimarko@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42179dafd6bso17630795e9.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718963177; x=1719567977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hhoJKgY7shKcy5YRKXGm5QRZcpFiWezUbDb7uQGDpUw=;
 b=T6eHDDo3G/c9cqIqqieZeMyZSCpgOOLlPwW25LyGwpkv/jX9lJiIXg3lMtPoi4o53S
 ZXU5AHK/9pVDh4XWU7LocglpTp8Du0vEcRVKIyke7bOW2KLg8I6+5edjnU63bB51xOW/
 umK62Nd8P2zqRmnw+s6OU/Ccxeo6ZgNQuomm7LqxKP57V9cFr8g9YCj1OXwTOMKYLNEm
 lYKEpeuzB6isJIoaHPPvvQmJNc6l6dg6Uu8ZrQxRiJSqPh7hJuGJFx2H3xQ3FTtbicWd
 jCCxzADVargH+SjjmDFtBNg8D0WlBFnA7n6cz020cY3gWMcRBLEgQW2wPgWK40IzExm4
 KfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718963177; x=1719567977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hhoJKgY7shKcy5YRKXGm5QRZcpFiWezUbDb7uQGDpUw=;
 b=srpt1xhGunqFPs26Wd8PIPLQemN/QFEJoMXdKrrvC/M7Fv5lLJIL6iGhyo4KoNxve6
 BJ9tRq8bZY4b7qYKFHVA2XpVCrG59xXQ4h0xlj7hVkjzPWRpg2TGuWAT76kb8JV8NZl3
 2TeEJv9Q1IQRlid2WOAIOSODuv4yLLS32NEyhKClJjHbn1fEqHMzEGcVXC1bliLHeZ1u
 4YUUhBC9b+oqeIKsGHQs03tPjgtL/D92anTizbX9PfKWyA74eewvIXj+UgWkQct87RQa
 1bYfTrpN8MCIHg4FDkbpveLIFBTmyVC1VGeBTv4cRgYuhfhXtLnNmPE4SYikmAypMPml
 xmpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK16a7jWrHEacap53OYaHPyrJVwyTbyt1jn2rT+UL9+PAY31wFntrlKs6UoTGfsS1uk4YiqWId85A2o+j+JzwoY48kUQ==
X-Gm-Message-State: AOJu0YxpHlRQSupuRCdTYratjRt8WSgEL/v+jm7LGS/352ZziLyt57yM
 tPRkfM2ck3wkYRhPtjXfoCOPRYhgnt2FCeK4Hf8eQ7Y3q8iwiIX8
X-Google-Smtp-Source: AGHT+IGxCsEKq6mhGUTYlPbIvyOmx7HJgqFGbGP3+5qBjg00+0Vs9Tjyq5k4sX2wOSU9lzHe2l9PYQ==
X-Received: by 2002:a05:600c:35cb:b0:422:1def:e1ac with SMTP id
 5b1f17b1804b1-4246f5dbe8dmr89847875e9.20.1718963176887; 
 Fri, 21 Jun 2024 02:46:16 -0700 (PDT)
Received: from fedora.. (d-zg2-226.globalnet.hr. [213.149.37.226])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-366389b8ad2sm1222084f8f.33.2024.06.21.02.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 02:46:16 -0700 (PDT)
From: Robert Marko <robimarko@gmail.com>
To: sr@denx.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH] mvebu: armada-8k: respect CONFIG_DISTRO_DEFAULTS
Date: Fri, 21 Jun 2024 11:46:02 +0200
Message-ID: <20240621094613.1438806-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.45.2
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

Currently, Armada 8k config header is setting boot devices and including
<config_distro_bootcmd.h> regardless of the CONFIG_DISTRO_DEFAULTS being
enabled or not, thus populating the environment for distro boot even on
devices that have no need for it.

So, lets simply respect the value of CONFIG_DISTRO_DEFAULTS.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 include/configs/mvebu_armada-8k.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/configs/mvebu_armada-8k.h b/include/configs/mvebu_armada-8k.h
index 239a09763a..6fedbe9ee3 100644
--- a/include/configs/mvebu_armada-8k.h
+++ b/include/configs/mvebu_armada-8k.h
@@ -30,7 +30,7 @@
 /*
  * PCI configuration
  */
-
+#ifdef CONFIG_DISTRO_DEFAULTS
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 1) \
 	func(MMC, mmc, 0) \
@@ -40,6 +40,9 @@
 	func(DHCP, dhcp, na)
 
 #include <config_distro_bootcmd.h>
+#else
+#define BOOTENV
+#endif
 
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"scriptaddr=0x6d00000\0"	\
-- 
2.45.2

