Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D169CF6493
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6C6891E8;
	Tue,  1 Oct 2024 15:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B7MTkcY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89603891B9; Tue,  1 Oct 2024 14:26:01 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F245D891BF
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so42657715e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785558; x=1728390358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hxOeyqszIugqBcozzHBgAXqWb3nc1LWVJ7AghL0R1BA=;
 b=B7MTkcY7sjJzuoFBb9rOhghN1YEJqI4ICsFj8BBTWdPt4tKSosvvY/hPAkCH3jE6FK
 HmTj7ftpJ/YyifTtO+wsiBxLmaorO5AmDDju6hMbP/l6JRDQBkAz9PiGo35pjKGC39jw
 doDF4Rr/fUGbvEZzER6cPLLQyNemR7G6hqE5m9AMhuWTmA4Wm/VsVlqe4vAv6D82m3p7
 0tHVqBJnFusmJMkFeI7cAU5nTO75bJJgjScqtOS67U2pvWXC98if0CRpfmfLYPBTCnLv
 xt8cejldD1+Yssgde4a9oQLN+NP8T45CsKXEZRJDis240g11U5GWQDFZ7ctd6zpC9xC3
 5Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785558; x=1728390358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxOeyqszIugqBcozzHBgAXqWb3nc1LWVJ7AghL0R1BA=;
 b=Jq4tVS+9JAP87+8BSGUABBfBH/yo/bbyrtkmitEhBruPlc3Zv2AdDc55MBFp5PKpfM
 n8cqZGVaVvIpvkkFEAF4rdfpO8liWoaLsDqNaxa51yur84S9BEI4IIJGWildHg7jyHDi
 rm9F4/dl6dz74X/Za3ewhU/s2Lf7UAhrW//P/inWpU1EcKGkSDG4A0DNWda0KJWtsve9
 0AxthHoIJi4jBUwbr2mN4HuRNWZ1PzvxNDVhldsAS5XzLKXs9rpobDbwzeG35+uRJhcl
 7uHn7vACFCyZa1qh1+rAxw41i+j52HfBYXpw1SGmCPU71Oo7TwoWFItMB2FhyLkXrCyQ
 SK6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4ANX9W0loHzQp7LJ81Rdy9wLqgAhSXEf44GZhxBQWJhWMxmm1zTfWlEtjdaCRVever4IM+9I=@lists.denx.de
X-Gm-Message-State: AOJu0YzuBVHoH4h6BeHREroL25ragSAL/XB7M0VtXk4sWFGBdYD1HtnM
 OQcOjzZYYuE22SeqZbIjF6rO4jnuPg1d2Tei7nJ1r6IPPdsHYt4e
X-Google-Smtp-Source: AGHT+IEBNfiTxyY72bvZLyeVOkae+c3PFntEJMwznxY8UiSspcW+tQq2uoSGOcKlW08M378Cvjt4tg==
X-Received: by 2002:a05:6000:c9:b0:37c:ccd1:5d55 with SMTP id
 ffacd0b85a97d-37cd5aa2510mr8887511f8f.25.1727785558214; 
 Tue, 01 Oct 2024 05:25:58 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:25:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v5 07/11] mtd: implement support for LED activity
Date: Tue,  1 Oct 2024 14:24:40 +0200
Message-ID: <20241001122511.8832-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001122511.8832-1-ansuelsmth@gmail.com>
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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
make the defined ACTIVITY LED to signal mtd operations.

LED activity is implemented HERE and not in the subsystem side to limit
any performance degradation in case multiple call to MTD subsystem read/write
are done.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/mtd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 795aaa2b37d..f178d7bea61 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -10,6 +10,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <led.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
 #endif
@@ -558,6 +559,8 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 	while (mtd_block_isbad(mtd, off))
 		off += mtd->erasesize;
 
+	led_activity_blink();
+
 	/* Loop over the pages to do the actual read/write */
 	while (remaining) {
 		/* Skip the block if it is bad */
@@ -585,6 +588,8 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		io_op.oobbuf += io_op.oobretlen;
 	}
 
+	led_activity_off();
+
 	if (!ret && dump)
 		mtd_dump_device_buf(mtd, start_off, buf, len, woob);
 
@@ -652,6 +657,8 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 	erase_op.addr = off;
 	erase_op.len = mtd->erasesize;
 
+	led_activity_blink();
+
 	while (len) {
 		if (!scrub) {
 			ret = mtd_block_isbad(mtd, erase_op.addr);
@@ -680,6 +687,8 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 		erase_op.addr += mtd->erasesize;
 	}
 
+	led_activity_off();
+
 	if (ret && ret != -EIO)
 		ret = CMD_RET_FAILURE;
 	else
-- 
2.45.2

