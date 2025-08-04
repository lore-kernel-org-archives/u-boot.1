Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653C2C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 13:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E005083F60;
	Mon,  4 Aug 2025 15:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RoxElgdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B0183EC9; Mon,  4 Aug 2025 11:21:46 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D63983DC9
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 11:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFB69431F1;
 Mon,  4 Aug 2025 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1754299303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2n7LXScZVq2nxFhx1UJw1mXK+nL6LO5X8CKefMsuII4=;
 b=RoxElgdU1xnvu5/5B/BVU7mr4/7WbzQ8T56YkzEfPfrLuRJBcjfKifo5HFB33EJC5aKyvq
 D1nW0+tUlSj1uR+SBe6jMA2ncY6tD+3WJ11RWRmUQoTJv5CxQfs1SPH8H9+tErt8KAMBCV
 pm6MZP/n4f7NJQDsKBXbpysgb1LWNh+D9FlJMJBwXJOe60AQIUXCpfNdWZNWxXbq7ciqje
 FJ83ipmZoDvLG4MGcY6/Vhhme8jiCNE/ocx3dbi4xS7UO6qBEU/P4l2iKNB/JxS8fz5Y8y
 UuohJD1rWfK3lXuazCRp639nAZd1dD3xU/KPGlAy6R3daedqSCyeJjfXlJWGgA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Steam Lin <stlin2@winbond.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2] cmd: mtd: Enable speed benchmarking
Date: Mon,  4 Aug 2025 11:21:37 +0200
Message-ID: <20250804092137.404647-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeetfeduleefjeffheevleeggfdtvdduhfdugeeuieejveejiedvhfdugfettdehnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepmhhitghhrggvlhesrghmrghruhhlrghsohhluhhtihhonhhsrdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepgiihphhrohhnrdhglhhpkhesghhmgidruggvpdhrtghpthhtoheprghnshhuvghlshhmthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepu
 hdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepshhtlhhinhdvseifihhnsghonhgurdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Mon, 04 Aug 2025 15:06:58 +0200
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
Changes in v2:
* Use an unsigned long as advised by Michael for accounting time.
---
 cmd/mtd.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index c25997cfb246..2520b89eed2c 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -17,6 +17,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <mtd.h>
+#include <time.h>
 #include <dm/devres.h>
 #include <linux/err.h>
 
@@ -466,8 +467,9 @@ static int mtd_special_write_oob(struct mtd_info *mtd, u64 off,
 static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
-	bool dump, read, raw, woob, write_empty_pages, has_pages = false;
+	bool dump, read, raw, woob, benchmark, write_empty_pages, has_pages = false;
 	u64 start_off, off, len, remaining, default_len;
+	unsigned long bench_start, bench_end;
 	struct mtd_oob_ops io_op = {};
 	uint user_addr = 0, npages;
 	const char *cmd = argv[0];
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
2.50.1

