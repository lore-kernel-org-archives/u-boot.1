Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82522C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D539A88D54;
	Wed,  7 Aug 2024 21:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J883HRlO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89F688D74; Wed,  7 Aug 2024 21:54:39 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DE1A889D4
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso1869365e9.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723060475; x=1723665275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YDsR5hsQOVbKzYtajp2w9J7akkZ2dMTxwqymOi6BTj4=;
 b=J883HRlOvkc/WflQVanaTl9UucUz63NH+60dmigl89pn5KK4URlANIwteLQvb7VYwv
 pzFDf9zBULY8Xt1We5EKV5VI2YuRK/yhV5IF513GfZGsIKWV8idUYqLE9/4lRlTBWB79
 6TP+2pJFsa65qD9JLRlReK0ArO5nAGxO+nEOORDWkLx8vyw7H/Da0xZ+GBP474+B3fQL
 ih2Zq3Lyw9BcO7qPZBAapCXQ/lBaq/MnBPttiHedes+/fvTVzzdbiWYI0wVlQwwSYEJs
 PURkQQjA8fzy5qvLf+1d7TT9egBizaXwn7z6LzRV1myGt8jFJTG174DLMTqoUpqn/bae
 lPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060475; x=1723665275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDsR5hsQOVbKzYtajp2w9J7akkZ2dMTxwqymOi6BTj4=;
 b=mGXR3es9CKGhf47oRIzmEvi+RqFajqVtEzrT5SthXxERxR3eAkDU9FHhusZMIofB2v
 vbVdfz0lgGMkq/9YLkAQBLtFcJvWtvQ26tyz6c5xhEmN4i8G426ki86v0hA9T2hfuYz9
 qSl03zm/kmq1d6Q+GMBJj1Ck7MQ8oMIwqC7hM1ugrxMmo3VtEg2aXhy+nn0Lsk3DPjCn
 TbuRSs4E1IqwU6p68aCpqqpKiY8r7vjQlKBC0gKD1mVRk7Uggpe8IQINSQP37JhG//OK
 /tu8COeLuGQh7zq9zfg4SMl+WRBdKo2C46IpQW7tQSt2H71Qg9WBHxRC+CKOwDEUTxtj
 BZMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUavFUwQ5sik5e46TGLnX1UFkf4y/JAZ2SkefQZOO8NFU6nFBroeJaiNheh9WFcpXvyivLT6HIaSiEZfCkpJT9zBY7+oA==
X-Gm-Message-State: AOJu0YzWi6J+0Ghu9B1uHE6s9e/8zUy+XGcGglJIp159qoXZbCcgPrvf
 fOpmaBSeSW1IpB9QKmoIeboKNGdAMebi5RwCxoULGem4Agc/mS/E
X-Google-Smtp-Source: AGHT+IGf5hmqQjKQZ/pr9DDpE/vVfuHBNeRwGpH7Zv6kx2c1sEvi8VorYnEvDqWVQbs2gb9xVXgUtw==
X-Received: by 2002:a05:600c:1d10:b0:426:67dd:e9e9 with SMTP id
 5b1f17b1804b1-428e6aebc2bmr128412405e9.3.1723060474973; 
 Wed, 07 Aug 2024 12:54:34 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429057a8802sm44383765e9.21.2024.08.07.12.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:54:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v2 7/9] mtd: implement support for LED activity
Date: Wed,  7 Aug 2024 21:54:10 +0200
Message-ID: <20240807195413.30456-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807195413.30456-1-ansuelsmth@gmail.com>
References: <20240807195413.30456-1-ansuelsmth@gmail.com>
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

Implement support for LED activity. If the feature is enabled,
make the defined ACTIVITY LED to signal mtd write or erase operations.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/mtd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 795aaa2b37d..ba5ee0d4d71 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -10,6 +10,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <led.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
 #endif
@@ -558,6 +559,11 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 	while (mtd_block_isbad(mtd, off))
 		off += mtd->erasesize;
 
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	if (!read)
+		led_activity_blink();
+#endif
+
 	/* Loop over the pages to do the actual read/write */
 	while (remaining) {
 		/* Skip the block if it is bad */
@@ -585,6 +591,11 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		io_op.oobbuf += io_op.oobretlen;
 	}
 
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	if (!read)
+		led_activity_off();
+#endif
+
 	if (!ret && dump)
 		mtd_dump_device_buf(mtd, start_off, buf, len, woob);
 
@@ -652,6 +663,10 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 	erase_op.addr = off;
 	erase_op.len = mtd->erasesize;
 
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_blink();
+#endif
+
 	while (len) {
 		if (!scrub) {
 			ret = mtd_block_isbad(mtd, erase_op.addr);
@@ -680,6 +695,10 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 		erase_op.addr += mtd->erasesize;
 	}
 
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_off();
+#endif
+
 	if (ret && ret != -EIO)
 		ret = CMD_RET_FAILURE;
 	else
-- 
2.45.2

