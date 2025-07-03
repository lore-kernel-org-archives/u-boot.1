Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A237C83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 19:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C028091A;
	Thu,  3 Jul 2025 21:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YE/m8xxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90BDA82063; Thu,  3 Jul 2025 18:58:55 +0200 (CEST)
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E9A78091A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 18:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1DE47449D4;
 Thu,  3 Jul 2025 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1751561931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bndcyvbdw4q2yY/ILQ1UPGF2Jv5TWs0VfaWiPQCcEZs=;
 b=YE/m8xxiQl3ICSgODUA4dX0xwGaSnKtf+3G9BYPDg2++G8ythrDa0FV/kzlJf7O1Ltw6Re
 vWY7dNX/PdALwyD+CufX+NN7OwI+tlsa9aj9tuVqa0BbSgzC/Shh2U9XKjTcgi7vhSNM9J
 gtY77B4Y2LrWUOVJPAtP6AHrwhyBfDRkP7s+OyJVC3IOeZlbNPingND7kydXcM0HHtuQUE
 wfxGzEKBP8/npUpMMp6upkiPubr/9rYO6DVytbfhi4DC3SGxs94OAaIDCdMuKADhxlep9p
 oivch7Bctx5QtloftgSs3xQJkJeZfhC73YXBnwKfyOzSOojvmMoOku77LzWTMw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] cmd: mtd: Enable speed benchmarking
Date: Thu,  3 Jul 2025 18:58:41 +0200
Message-ID: <20250703165841.1230515-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegteefudelfeejffehveelgefgtddvudfhudegueeijeevjeeivdfhudfgtedtheenucfkphepledvrddukeegrdelkedrudefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdelkedrudefpdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtoheprghnshhuvghlshhmthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhitghhrggvlhesrghmrghruhhlrghsohhluhhtihhonhhsrdgtohhmpdhrtghpthhtohepgiihphhrohhnrdhglhhpkhesghhmgidruggvpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvp
 dhrtghpthhtohepshhtlhhinhdvseifihhnsghonhgurdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomh
X-Mailman-Approved-At: Thu, 03 Jul 2025 21:54:13 +0200
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

Linux features a flash_speed speed test from the mtd-utils suite, U-Boot
does not. Benchmarks are useful for speed improvement developments as
well as troubleshooting or regression testing sometimes.

Enable a benchmark option to enable this feature.

Example of output on a Nuvoton platform:

MA35D1> mtd read nor0 0x81000000 0 0x10000
Reading 65536 byte(s) at offset 0x00000000
MA35D1> mtd read.benchmark nor0 0x81000000 0 0x10000
Reading 65536 byte(s) at offset 0x00000000
Read speed: 3752kiB/s

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/mtd.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index c25997cfb246..d5843db663d7 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -17,6 +17,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <mtd.h>
+#include <time.h>
 #include <dm/devres.h>
 #include <linux/err.h>
 
@@ -466,10 +467,11 @@ static int mtd_special_write_oob(struct mtd_info *mtd, u64 off,
 static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
-	bool dump, read, raw, woob, write_empty_pages, has_pages = false;
+	bool dump, read, raw, woob, benchmark, write_empty_pages, has_pages = false;
 	u64 start_off, off, len, remaining, default_len;
 	struct mtd_oob_ops io_op = {};
 	uint user_addr = 0, npages;
+	u32 bench_start, bench_end;
 	const char *cmd = argv[0];
 	struct mtd_info *mtd;
 	u32 oob_len;
@@ -490,6 +492,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 	read = dump || !strncmp(cmd, "read", 4);
 	raw = strstr(cmd, ".raw");
 	woob = strstr(cmd, ".oob");
+	benchmark = strstr(cmd, ".benchmark");
 	write_empty_pages = !has_pages || strstr(cmd, ".dontskipff");
 
 	argc -= 2;
@@ -559,6 +562,9 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	led_activity_blink();
 
+	if (benchmark)
+		bench_start = timer_get_us();
+
 	/* Loop over the pages to do the actual read/write */
 	while (remaining) {
 		/* Skip the block if it is bad */
@@ -586,6 +592,13 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		io_op.oobbuf += io_op.oobretlen;
 	}
 
+	if (benchmark && bench_start) {
+		bench_end = timer_get_us();
+		printf("%s speed: %lukiB/s\n",
+		       read ? "Read" : "Write",
+		       ((io_op.len * 1000000) / (bench_end - bench_start)) / 1024);
+	}
+
 	led_activity_off();
 
 	if (!ret && dump)
-- 
2.49.0

