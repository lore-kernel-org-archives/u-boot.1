Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C7CC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42FA58885E;
	Mon, 12 Aug 2024 12:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VR7JgAgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3452887D6B; Mon, 12 Aug 2024 12:33:17 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46AB088806
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso28623385e9.0
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723458795; x=1724063595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YDsR5hsQOVbKzYtajp2w9J7akkZ2dMTxwqymOi6BTj4=;
 b=VR7JgAgsF18SHI1Q+XduLtaReADRXbofm9qxPk3PELC1sSPVtrU6SQZU/EX+u+iubT
 sOhLcp5Ry4cXdvaAI7u00fRJg2Pmi2LQeqb30C1KKczb+mlpFkCy4mThtu481DmHjLdT
 g++qzFNrTA9nmqAJr+8nCcuuXzNqsh5zmv3LnI7f+lbD1lyPRxwyRtBJmds6K3NmtMDr
 /Mx7tIVt9Fsua6DSmy5HP4iDm7Vw00AmahDh+Fzq8czXrz+3uIUWc0hZMy2Y2S/JgPYA
 2OC4QUkd1MC3V2Y1fiB8UAZoz0VrA180+J23VbvrWza1CSUmdEb74twoyLM3RLc78nkk
 NrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458795; x=1724063595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDsR5hsQOVbKzYtajp2w9J7akkZ2dMTxwqymOi6BTj4=;
 b=ksJ9aMbuGxHvv/kVty/8f1IYR90/Mn2CzlII6MaWBMshy7exCnCLkMRsc5oO3HY63Y
 JJ/zHjd9d2+3xgAnNgsKZLTfQgpwOoiEA+JfUZ/bqp5XgJ2555GFLPT0mtGDhY8sI2W1
 lDXHZScS/VbEzi93QgM9RiblxvecwQNe4dqGQGVDMqB7g61wdSkNjguhkR9/qnDZi0AJ
 ImPDkQAJSza2oIBfiH06ZdFuzs/TRyfe9zbX5W7iZJOpvTkB4XUomHTELmimDM48jO4D
 5BjwjPog3YF/0lSlq5CrUjiBZCTP/AJ9inrEu7TvvpJtJhRSnG+QAzhR9e9cWdATBOGf
 f2jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjdGsPaOhJ17eHBPhntSBxf9PCcfvyqbm3DqUFs6mG0MQ9DuyCE8FaS2xj2yP39rmu7WhdHQrUiu7hE9JLLmVYZVsLdg==
X-Gm-Message-State: AOJu0Yz0FpsPQBYhDVMxW7hYPPg+8kUVYptG2PC0KGsMj4eHl0T7HFUU
 jnYlasnSn0+gwWO0bo/xezC6OnAWs5djVh0SGh4v9DKMOqU1WTwr
X-Google-Smtp-Source: AGHT+IFoypDNh3563g0OEyAHjXiPt4MOLTYCsQWAaLl7kjEPEGGiPMZ25FMUGCnhiycRLBoMdJr1og==
X-Received: by 2002:a05:600c:4fc6:b0:426:62c6:4341 with SMTP id
 5b1f17b1804b1-429c3a29a48mr69993275e9.20.1723458794576; 
 Mon, 12 Aug 2024 03:33:14 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm186016425e9.37.2024.08.12.03.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 03:33:14 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v3 7/9] mtd: implement support for LED activity
Date: Mon, 12 Aug 2024 12:32:49 +0200
Message-ID: <20240812103254.26972-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812103254.26972-1-ansuelsmth@gmail.com>
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
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

