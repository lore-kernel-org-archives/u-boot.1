Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAF3C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4467F883DE;
	Mon, 24 Jun 2024 23:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f6ML0wso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF32883AD; Mon, 24 Jun 2024 23:46:46 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4848388568
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57cc30eaf0aso2787007a12.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719265604; x=1719870404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cp4QGkKRJQZKBYprVTIXWZslmqe9jjml8oA/1n4BPRU=;
 b=f6ML0wsoQ2fGgszCHr+XPVkklQDTJCVjARJ7kJgiZG5wdYnXgedI+SUwDsYGexKsdS
 DQVzqYHFqZW7bTNEGyVB+RMeO6KlY0ZucZbxjupJ8h2oMBNbU5SIFkCIILsOBxwR2I5b
 BaV+qY5NtoajqoRmLOxFCElxUQZx/NOWn7dHeH5u3PFELuIMTBwWbbCEum7kasoqiqRP
 alWRcdsG6/+ZkSW5H3eIHSD0oY5Zx/CUC65+E3FWzoMR2xXhqU71uAPOW9QStU4l5seo
 EPxnZSFc7ocwlg3wmzZtyftzIVa2tZ3vHxjDCOnaC6a3pisqGNl3eHOeb2XOF9EhRO88
 +GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719265604; x=1719870404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cp4QGkKRJQZKBYprVTIXWZslmqe9jjml8oA/1n4BPRU=;
 b=wX+/MT8tEXMfoSYZvKdvg9DseZjgDsRcdMsX/YBGUOXmD00PpL4JrMmeQXKDRghOMt
 QL++uPFcv0dDgHJ1laGgP9WrBz7zLnnrAKpwqiG4XMMbkCyO6GfXIHnGdu6fvF/rCgGQ
 WZTb2HEAiNIB9AMG03+E8+OzYBzQgYVRxymXkYxwxCbTmlawpymccpPcEuOs362kEhcn
 rGT4zDuuhr61D89MKQgyw10YoxpMEefaljtktbaeg1VkHh3ZT0HkH36hMUS13IWeD/pJ
 bhrO0+e+hBYN5CPrlkKn7Yye8L6lU0a3gdnKNC27Tonssbox1Wq8fDhYaLVu+cEkHuoY
 OjVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj4CtLmNwNYMS9cD4cNxRMsgyzxrxBisLjbhpnkvJd++DPqTUw9MW0scEcOIt/CRHs9kZTsAbw2ocCn98ukhJSAS1z4g==
X-Gm-Message-State: AOJu0YxFx5oLZYAvA+ZdelveMsryqbDZlMGcdIPt7ePdmjJrz1/8J01M
 0nzJandpAccJY0LrlQJ4NON2AO+RaRogm6HvvyYru2RCL7iPpGcP
X-Google-Smtp-Source: AGHT+IHBGuFlOJNKUphRiwWZLAHQ44eqm2RGewrf0BArtpJG/mvRI96r0swiM6Y0LOO1qFFVwaNpcw==
X-Received: by 2002:a50:d55b:0:b0:57d:669:caf2 with SMTP id
 4fb4d7f45d1cf-57d4bd9705amr4128259a12.25.1719265603653; 
 Mon, 24 Jun 2024 14:46:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d7b1bsm5100588a12.11.2024.06.24.14.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:46:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 7/9] mtd: implement support for LED activity
Date: Mon, 24 Jun 2024 23:46:17 +0200
Message-ID: <20240624214626.24336-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624214626.24336-1-ansuelsmth@gmail.com>
References: <20240624214626.24336-1-ansuelsmth@gmail.com>
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
2.45.1

