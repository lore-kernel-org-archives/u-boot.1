Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0980AC27C53
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13ADB884D4;
	Thu, 20 Jun 2024 03:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZWWJleF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F78884CC; Thu, 20 Jun 2024 01:04:19 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE3888427
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42249a4f9e4so2311975e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838257; x=1719443057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vpk7Y89IwPKGsYMfO3IDA913TgBD4Hl0+Lmy6nIGugY=;
 b=ZWWJleF5hl3Bo36LFSrYF/fJx2Ywg2uE0xyz4xAp+JNrENZKW0H9gMvDrAvyP/IKqQ
 L5Seb1ruXWYn/yApi76qkacJ87p5S0OEHUWHmXVqr+G2/iAdQCdEBf74BztBIjpyaPrq
 PMUqTVp6YTMUF5aGU7y7ONCLHFzmUMNk1UOu2a/zTll2PLc4Dp3M6en0gMx3k2lZYI6H
 wnbfrni/4vykjrfE8dKLNdIhHKC/Z21W6n6G+ydy5otsmdP7UuQ4bgFvcc+ZTI6OW8zb
 tIvbTLPVUQ/vnuJYpEO4JPZDi6jh1eFqUex8dLs0PN8B8+DkucjKlBLvjp3ItdS3iTZc
 8HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838257; x=1719443057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vpk7Y89IwPKGsYMfO3IDA913TgBD4Hl0+Lmy6nIGugY=;
 b=hZdedncZvARP4I+OfJFiPbx3+GULC3teyXP+tTsmskkq+5HtfPHNxgMaZ6JtIYHpmr
 Pw4WP7RYsQ9UliXOrCXa/0QlZqfSVmlpTj4LsaxYDew0/e3IeBEWoajmLLUGEJEYGwnq
 VEEdLJGxxQzZVePPakQsosnpdFadEBJ8YxqHziulF4owm6xa9ghqKIoQ4/Jgs7I3Si1R
 H1PZIxA02yD/Zqyi9N+XsmZ6L8xOpOUMOUcOomoTzqSMP2UvL8JTRdCEVVw1elbirMuK
 ye/lsOggCX/9QeCJ4GMr9BOK4GVX7lGAkBlScRxn8sXBokH8kl5swVcAX2Ja9KV/VsPX
 F6Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhdXHt6BjAYFcwWm68qSaAOU4qr24ExbRK3Gys1a9hb3miQWljYllJECBDWbOuvnfHHkQK5+1xko6p31c2bcBt6JtkRw==
X-Gm-Message-State: AOJu0Yzh6B1JV+vZMGLfCuD9nondeP7fHnXsvsAWRvpZ3lEPJ3UAHfpK
 A+EOxBLXXTsUGCJ9XKq/JEmpARqlur5+hDOiZYAmibFb6wlZbJ68
X-Google-Smtp-Source: AGHT+IE50uPX6/dsOm08GkWzu94yAfjMsAnMI1xcI1X3xPpLcHmeyNTtO5r9UujrnmnMgmXxZgqypg==
X-Received: by 2002:a05:600c:3b16:b0:424:7c14:d184 with SMTP id
 5b1f17b1804b1-4247c14d33cmr5247105e9.15.1718838257339; 
 Wed, 19 Jun 2024 16:04:17 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm5410465e9.27.2024.06.19.16.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:04:17 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Dmitry Dunaev <dunaev@tecon.ru>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v4 8/9] ubi: implement support for LED status activity
Date: Thu, 20 Jun 2024 01:03:26 +0200
Message-ID: <20240619230400.8459-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619230400.8459-1-ansuelsmth@gmail.com>
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Jun 2024 03:31:55 +0200
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

Implement support for LED status activity. If the feature is enabled,
make the defined ACTIVITY LED to signal ubi write operation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/ubi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 8c1b5df0572..cfc26d53d65 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -19,6 +19,7 @@
 #include <mtd.h>
 #include <nand.h>
 #include <onenand_uboot.h>
+#include <status_led.h>
 #include <dm/devres.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -416,7 +417,19 @@ int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 
 int ubi_volume_write(char *volume, void *buf, size_t size)
 {
-	return ubi_volume_begin_write(volume, buf, size, size);
+	int ret;
+
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_start(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
+	ret = ubi_volume_begin_write(volume, buf, size, size);
+
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_stop(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
+	return ret;
 }
 
 int ubi_volume_read(char *volume, char *buf, size_t size)
-- 
2.43.0

