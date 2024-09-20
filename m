Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A88CF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F7688861;
	Sat, 21 Sep 2024 04:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q1MSd+my";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D6A387E30; Sat, 21 Sep 2024 00:52:02 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5653A880D8
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso30194285e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872720; x=1727477520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SQDC9j9+SaPI7Iw4qgK3DIz0Ik8w7G7qmKL2qNqPaZg=;
 b=Q1MSd+myO9WJt1//Z2NCzYyzN8O5Vdhv/MniddTzddq3YZwEbwdcJdaWoCV5rTlHSZ
 ABrtovj7idNVbqwFeIQC/UHa2UdERSJa3o2m8aI9+aHEMTIliwmVqljBm4RHNd0zbHFs
 rG5miO2ns2yjxFfgBtINhSSHV8TmLf84mLehA6KWG+cphzxM4EzXwhLao12Ls3AP8lKt
 OVsBhsaIJzuYfQ+1LtAWgSpbahJO+YgZN07s8K8e31aGRaqLxYqImcjiKP+yVrjsUz65
 wuz6Mt8YLSBTJk5Zzx+MaKBXdog4vSl4cBixjFzbHJMubwQ67eZtvs4tMj4/rzcgcusJ
 BedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872720; x=1727477520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQDC9j9+SaPI7Iw4qgK3DIz0Ik8w7G7qmKL2qNqPaZg=;
 b=gKyqVvt6TMb//kwL7zUj3/XNBr/KswGsVRHNpfnv4NZfPeHcMTmv2L8T59IMQOITW/
 LYcB2QR242nXPgV53nil0AWW2DGj7bXd0Wv5RPhFoF6ICJWjbcM6IoPWzvTRekSTJlSI
 gh9NQRcl4V+f7pQ6ktVRbWWB4MZiTBJ9r7koMCMxJwrCANFmNeTmj2Zn/PhwpYVrH1jT
 yT9HDSxYrorNjAumix3PITnZOqyxAtqHP0fnQMpnymhgkNWTQeV6DbopISFq6oo6cWCR
 nrV0NeRPEuilJwQeG87BmUoyYLKoo8NBDgy5BGl4TMBtbB3l2Wwm1xF0tkFOpouZscR6
 Vb4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhAkl7bKHNy+lCawkKWAtnKjsK9j9tu9/niYqfmsklSKIPgwtoGEKBs2JhjF8as7wLOiiFGWI=@lists.denx.de
X-Gm-Message-State: AOJu0YwrQDyT4FiqLWemnka1pWmiXYiuYbXFlac4K1e7/kTcQHGuXc77
 Yr75bmVZBVhjxvw+uLrD6Q0vYKXlNt+b5Rlqqy5Aj31ir6R5HOer
X-Google-Smtp-Source: AGHT+IGnVtIAlPuLwbdWt8hz0NF7l2ZDigSrz5LJAjBqibOGYJr1ETvlVS04zEh//xvXBFPgBe7tCA==
X-Received: by 2002:a05:600c:1d12:b0:42c:c401:6d6f with SMTP id
 5b1f17b1804b1-42e7ac4b294mr45027065e9.16.1726872719579; 
 Fri, 20 Sep 2024 15:51:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:51:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v4 07/11] mtd: implement support for LED activity
Date: Sat, 21 Sep 2024 00:50:00 +0200
Message-ID: <20240920225101.2008-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920225101.2008-1-ansuelsmth@gmail.com>
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:11 +0200
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
 cmd/mtd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 795aaa2b37d..dae90b0e6e4 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -10,6 +10,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <led.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
 #endif
@@ -558,6 +559,9 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 	while (mtd_block_isbad(mtd, off))
 		off += mtd->erasesize;
 
+	if (!read)
+		led_activity_blink();
+
 	/* Loop over the pages to do the actual read/write */
 	while (remaining) {
 		/* Skip the block if it is bad */
@@ -585,6 +589,9 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		io_op.oobbuf += io_op.oobretlen;
 	}
 
+	if (!read)
+		led_activity_off();
+
 	if (!ret && dump)
 		mtd_dump_device_buf(mtd, start_off, buf, len, woob);
 
@@ -652,6 +659,8 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 	erase_op.addr = off;
 	erase_op.len = mtd->erasesize;
 
+	led_activity_blink();
+
 	while (len) {
 		if (!scrub) {
 			ret = mtd_block_isbad(mtd, erase_op.addr);
@@ -680,6 +689,8 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 		erase_op.addr += mtd->erasesize;
 	}
 
+	led_activity_off();
+
 	if (ret && ret != -EIO)
 		ret = CMD_RET_FAILURE;
 	else
-- 
2.45.2

