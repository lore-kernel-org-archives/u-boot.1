Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BF8C2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA9588524;
	Thu, 20 Jun 2024 03:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sou5CR6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DB4884C5; Thu, 20 Jun 2024 01:04:18 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28EB8846D
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-421d32fda86so4308805e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838256; x=1719443056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FTNzwr9dxOJ4zY9jqHAKJxe1vUMNFnqS5tp4Lk+OX0s=;
 b=Sou5CR6kOPWZZp8d7aoE0xw83C8IflsAtYDi6agezBv5n/ez2blNNo5wjM0PRqAfs5
 nEA3d56OYAwUIFH0X4R5NyUIfQ+XOu4Z/ahcmIW/q/LoO/h5DxP+3hPjCyTViNF1LmfL
 fLm2hoz5iLmLio45ycZ293qqqk6ls6O0t7OrHti74gTZHcYekjelIXYiI9xL0TQ5O3At
 avd9mk3HXHpHfYkLmYa2MW4QX8tFUYzVZ4PRVX49Auf0dYtw8rWQ2eTGizQKox/q2hAS
 Wdlk+k8xMruJV+7nhyzARNvc09FeaF2D9dg7usaiSQ7bbs5J7fhxetN7CTouF/KahRXr
 HuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838256; x=1719443056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTNzwr9dxOJ4zY9jqHAKJxe1vUMNFnqS5tp4Lk+OX0s=;
 b=q52eAUcWq9CDE3VqB0eLnPoPZ7TNFTkAGatdqBA1/95gaYXV3qOUHgaf5SUxkp+Ujy
 2+09gNivvQmQiXgcuYgHRCPTgH2vNVnH2fIcC/CHaTVMosWbrlMcEloi2Xq4lf0VQFAB
 NyKV9EuHIIKMoKu7LVgmRCK9+2ANpruyHE2TaePfYHZNpuM2vEozCAQCC+VSVxEtzR7c
 E2JCs2e9zv+Ch0CHDiPmGtwjJzWMNs1U+3npr6+IAl3MB815/7zewFOuCudbjVfcZitH
 Gu18cYCTQHp8+0ngrCZh9X3ZId3hzxIEhEWj+gPRWLYgC93ROMGlSwsvjPEn71oQhbYZ
 lemQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD8q9Ycp7eFk2YZkOonNawm4MzBo5ZqRr8f36sYZ6S/ljmEatWj9NS3s15d49inR3sM3EoosRCqa52oNDkg38xbJeFEA==
X-Gm-Message-State: AOJu0Yyv5bNUb3k6Vy/QhGZfykuhPIUoDQqFU1Ep1GNxGOBZOa/4czi6
 4E1HuuaitvSD8wel9Hi/iFIhiYIkfE8+4UvCXmyizkvTieCEcbiZ
X-Google-Smtp-Source: AGHT+IG8iaHjXIpOm4I4wyjmnLqBReehvd4QaCVfycCoDkRMWmuRvr3ZjkdmWOa5GroVV4q55L3LpQ==
X-Received: by 2002:a05:600c:15c5:b0:422:aca:f87e with SMTP id
 5b1f17b1804b1-42475182567mr34737015e9.19.1718838256119; 
 Wed, 19 Jun 2024 16:04:16 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm5410465e9.27.2024.06.19.16.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:04:15 -0700 (PDT)
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
Subject: [PATCH v4 7/9] mtd: implement support for LED status activity
Date: Thu, 20 Jun 2024 01:03:25 +0200
Message-ID: <20240619230400.8459-8-ansuelsmth@gmail.com>
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
make the defined ACTIVITY LED to signal mtd write or erase operations.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/mtd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 795aaa2b37d..d36dff7875c 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -10,6 +10,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <status_led.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
 #endif
@@ -558,6 +559,11 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
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
@@ -585,6 +591,11 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		io_op.oobbuf += io_op.oobretlen;
 	}
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	if (!read)
+		status_led_activity_stop(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
 	if (!ret && dump)
 		mtd_dump_device_buf(mtd, start_off, buf, len, woob);
 
@@ -652,6 +663,10 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 	erase_op.addr = off;
 	erase_op.len = mtd->erasesize;
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_start(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
 	while (len) {
 		if (!scrub) {
 			ret = mtd_block_isbad(mtd, erase_op.addr);
@@ -680,6 +695,10 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
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

