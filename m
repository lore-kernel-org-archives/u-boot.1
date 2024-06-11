Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30367C27C79
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 02:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9906887E3;
	Wed, 12 Jun 2024 04:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YuHxC+bb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BD087B30; Wed, 12 Jun 2024 01:15:00 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848A18878D
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 01:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35f0aeff7a8so1332938f8f.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718147698; x=1718752498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m1ahcJL+QZVoz+jmkvnn70yF6uGU5cp9PXqRqWEqUY0=;
 b=YuHxC+bbNH5C0tlcRbfudXjNQwK7wqczP7cGZpqcM3dQM/95tIDOEHiEVQjAeHLmsJ
 S1lTPtxKoDMDYitJiGJ2DcfVpdRROjxQbNM/N2kWM7gSCleBGTkk1bea5XQonsWN2pfH
 AO/zQZnj9kAR1ldWSAMqWJInMCcWIFTYMFxbotq01JVcrThtaQWk3o5cmedfhRnGPKXO
 IGL1DUMtb7HQvChgUWTmSn+zmB7TB/gBdr+Xp1mDWPsjoUer7k4frVYbF7exHT92/lCj
 zY5SKhD5USXvw9V4B7J2l41Brq/lIQlSTpObasI5RPFR/gwBp3C1ayyfMtb1ooJNs+ra
 KCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718147698; x=1718752498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m1ahcJL+QZVoz+jmkvnn70yF6uGU5cp9PXqRqWEqUY0=;
 b=SpsJjma23u3UMq5Vrwd1nOxmNKaCPGMHd7HZ99NqQ90jDI23yjdo1svz0ZG119Vt2D
 fklOGcvnPeab6dDFKVSvjKlsX5VSbmxXpNA4fWl1Y6GhxSFSniQzRdEto6zkvoI7U2rj
 ou7IDAZxHDViM/+7tY+w39awnUIga9ErpeON+CLfVQuA9DLz8HamemXJPNa3NSRGZ48X
 GuBqOzYfPg0aMMD81wCe2ZGQcR1Jmzi6cm3jx9sXZYLGZSo4kmbUDSAMI10jaNdpOeim
 +atxVyzSSEFcwvvzIu2A3wZ4kfPWHX5A+bYjapV4un6b78vbcOZ1YSNJT6u7p06cGYft
 vD4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwTTwao/7vs7Ggn+X+g9ac3NaLYnX+T/Jbj4r5cG1A1Rcyl0IOi++8+hcOvgHB/eKR0CIguLKXfh2g7pJqYJ3FGuT7yw==
X-Gm-Message-State: AOJu0Yx1S4idPKT/b3pm84ws0DstJAqZvzAkfnUnHyLtXbmsxdAhlYXR
 EjmjIAz0u6lmWT2UY9MiRYgmpmWd0usyfBaGUvzQiY0Fud7b7Fuu
X-Google-Smtp-Source: AGHT+IHy+yrkBGgZgpeYkrVywIHyre7Pi9CS0M+zlZP7ksRQ8yBUcl3Dq9OrnmXqu91rRyYPBoYnRA==
X-Received: by 2002:adf:ab07:0:b0:356:84b7:e5d1 with SMTP id
 ffacd0b85a97d-35fdf7a9695mr120893f8f.42.1718147697960; 
 Tue, 11 Jun 2024 16:14:57 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35f231d5761sm7052096f8f.35.2024.06.11.16.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 16:14:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Bosch <stefan_b@posteo.net>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v3 7/9] mtd: implement support for LED status activity
Date: Wed, 12 Jun 2024 01:14:22 +0200
Message-ID: <20240611231435.10366-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611231435.10366-1-ansuelsmth@gmail.com>
References: <20240611231435.10366-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jun 2024 04:33:23 +0200
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
make the defined ACTIVITY LED to signal mtd write or erase operations.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/mtd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 9189f45cabd..a10805d05a5 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <common.h>
 #include <console.h>
+#include <status_led.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
 #endif
@@ -559,6 +560,11 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 	while (mtd_block_isbad(mtd, off))
 		off += mtd->erasesize;
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	if (!read)
+		status_led_activity_start(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
 	/* Loop over the pages to do the actual read/write */
 	while (remaining) {
 		/* Skip the block if it is bad */
@@ -586,6 +592,11 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		io_op.oobbuf += io_op.oobretlen;
 	}
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	if (!read)
+		status_led_activity_stop(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
 	if (!ret && dump)
 		mtd_dump_device_buf(mtd, start_off, buf, len, woob);
 
@@ -653,6 +664,10 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 	erase_op.addr = off;
 	erase_op.len = mtd->erasesize;
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_start(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
 	while (len) {
 		if (!scrub) {
 			ret = mtd_block_isbad(mtd, erase_op.addr);
@@ -681,6 +696,10 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 		erase_op.addr += mtd->erasesize;
 	}
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_stop(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
 	if (ret && ret != -EIO)
 		ret = CMD_RET_FAILURE;
 	else
-- 
2.43.0

