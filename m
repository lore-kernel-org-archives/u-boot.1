Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670D0C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03320884D1;
	Thu,  6 Jun 2024 18:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JqMQisCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01628842A; Thu,  6 Jun 2024 16:30:48 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0C9F87D9B
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35dc984b3d2so750246f8f.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717684246; x=1718289046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m1ahcJL+QZVoz+jmkvnn70yF6uGU5cp9PXqRqWEqUY0=;
 b=JqMQisCtHhd8WxHrsirwEMwTiLwgfr0je+2Gm/Mi/OmuLQOnlcZpS07FzklUXAllK3
 dI64ZVNUC8HEXo2xpDV6b3rROltcslDNMmRL9htTdZMVOcjCpUTvr1BomouUsL2ETh/u
 n05UaT3+nBVr1TGOXLTqdoPukatweIe7B+8YZxAmenebNzYcs+nf2j/QIX0YEJ2mo8mk
 hfRinpAOPfrZGRLw0KYgdw0sJFvX7azsmJaOvXtnacmWGTimtUmP+0Z+uVdOa61nSabY
 UeSAF+Nb4U5YYll42LkhZVuKN6dysS29gzBmYGp5KEs32DIUoDugTtRmVQilWOEFu8NX
 Isag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717684246; x=1718289046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m1ahcJL+QZVoz+jmkvnn70yF6uGU5cp9PXqRqWEqUY0=;
 b=CiQYAOvC9vvfhukvae8DxvYL1G9X4IzEffLUtDGD78cWg3/gG62Yow4k1j++tNW1/E
 QVZ2OOO2tEttvtYEbUmKXUteQ/ofXCuSFrN07FuZudMtTLFNw1M6AZI4tOkSiX0AA8RC
 S073MR+bt3v2UAgJLryTNghwEpeyiSNa2ErpV1yjPQOIyWMe/4tnizzIQgsh8TJlIGjG
 R950zUYJ+D3o8tFbeGrcPgMPDgFbS5wV/4hTNT7vu828XQG5ILfKddOk7gKlpkyivS3G
 ceSB1zhUi+U3cjkK3ufoMV0393ViaLMppOXaWRrqNq+l4+TsXZHdeGIGnYKuJXkTLVxb
 JF+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcIfUDM13j/OL87zN51/hbsu1Lu6k887EhJ8E31jNzjqRPDsc1cHSe+keVVkHcu9WFALyOhHOU6l38/aSBQE7VAD8e8Q==
X-Gm-Message-State: AOJu0YwAjDJopiNtU4eFpoMnrkXLCXXxs8y8Q3MLEeoVVq+MPFsH+DP6
 g2yK8YYChGbQyexsrAzGzFrA52XKMxCRBuIAUd9o+8od7fRk4cLp
X-Google-Smtp-Source: AGHT+IEcDaQMOG/pEO06gRZgkh8PtpjdaLJhpwnC2bDzFj5zuKBMeTsE+4Jp8rNyxQcNr8ib+2Y8eg==
X-Received: by 2002:a05:6000:363:b0:35e:60f8:7ed8 with SMTP id
 ffacd0b85a97d-35e840688dcmr4666648f8f.11.1717684246207; 
 Thu, 06 Jun 2024 07:30:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e989b3sm1718060f8f.71.2024.06.06.07.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:30:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Stefan Bosch <stefan_b@posteo.net>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v2 6/8] mtd: implement support for LED status activity
Date: Thu,  6 Jun 2024 16:29:27 +0200
Message-ID: <20240606143024.20024-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606143024.20024-1-ansuelsmth@gmail.com>
References: <20240606143024.20024-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Jun 2024 18:33:44 +0200
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

