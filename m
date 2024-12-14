Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446E0E77180
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 22:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2591800B2;
	Sat, 14 Dec 2024 23:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RCcqpySs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Sd+6BtqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0651800AB; Sat, 14 Dec 2024 23:44:07 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE668006C
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 23:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Y9h8P2W4jz9sqS;
 Sat, 14 Dec 2024 23:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XADJky6D7CjAqoaD6cm65mRib2uVuQ076qyy+wv5lc=;
 b=RCcqpySs1HEprl3sOJOhemvapd+WjiCO2yw2fdzpbqAQ5DUPkzPA3SPp4oMRj8FAJYca62
 hBixtHFLKro8coMnY7FBw++yDNkz52Ivg94fUp/BWwwRAXz/VYmSIddogGqUdfP1xawxMH
 NfJm+9e7BbaU7h2A3UFHkCHYBwBxd9nFcpo1nFLNYziiI+yDqaxNMk68wnzCDptJjcFeB5
 /BTNyxlj0jwbiyWG/etnjw3vdH0008E6Gg1WAlsyrYi5raDug7e5nJbdgQEYPZoFIDoG8t
 A266QRR+q6cRQBlp8Kwvq2ECqNqY9yGS5sxq8+SD5+xpycgiPp7Hq6gjjswu6g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XADJky6D7CjAqoaD6cm65mRib2uVuQ076qyy+wv5lc=;
 b=Sd+6BtqMifX1Y91tb5aZAvZ8M/C821/z8mzNTD4xdsn7NAzAxyNFhPEtpnNircrAyF8akZ
 t69HD0/KEWsIvGojnG5s84wJKcVaZCF1jiRqCl3upN8bs4zgN/ih8EmuLUUAk7H8v6WmB5
 g1a5bOdyygYIx/kjOAsKciu5fJPltfsS3fBhbNTNKsonkr5K5CmGGIoU1bTGoSInE9/fyH
 q19FDF+3NcOaDMQgP+BfU1EGGMwPn8zDfA3PrExm6JEDVjgQF1b5E66U6VW58HFfLRVRpP
 AzTqxZ616oqyJmCgZTDFQ4Iodni9kbVxxkX8DVRW7y5FsvGyQX+mrwGVlWI23A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm64: renesas: Convert boards over to is_cortex_a()
 functions
Date: Sat, 14 Dec 2024 23:42:48 +0100
Message-ID: <20241214224344.303452-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
References: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dpz9nfar1q188dicag4otmmtx6ceq7sp
X-MBO-RS-ID: 4ff2603d76792ff2720
X-Rspamd-Queue-Id: 4Y9h8P2W4jz9sqS
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

Use generic is_cortex_a() functions instead of open-coded midr_el1 read.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Chris Paterson <chris.paterson2@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/hoperun/hihope-rzg2/hihope-rzg2.c |  8 ++------
 board/renesas/rcar-common/common.c      | 10 +++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/board/hoperun/hihope-rzg2/hihope-rzg2.c b/board/hoperun/hihope-rzg2/hihope-rzg2.c
index 8b635ef71ac..d2c5aaacf66 100644
--- a/board/hoperun/hihope-rzg2/hihope-rzg2.c
+++ b/board/hoperun/hihope-rzg2/hihope-rzg2.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2021 Renesas Electronics Corporation
  */
 
+#include <asm/armv8/cpu.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -66,12 +67,7 @@ int board_init(void)
 
 void reset_cpu(void)
 {
-	unsigned long midr, cputype;
-
-	asm volatile("mrs %0, midr_el1" : "=r" (midr));
-	cputype = (midr >> 4) & 0xfff;
-
-	if (cputype == 0xd03)
+	if (is_cortex_a53())
 		writel(RST_CA53_CODE, RST_CA53RESCNT);
 	else
 		writel(RST_CA57_CODE, RST_CA57RESCNT);
diff --git a/board/renesas/rcar-common/common.c b/board/renesas/rcar-common/common.c
index 499c31408f6..75f9aab9163 100644
--- a/board/renesas/rcar-common/common.c
+++ b/board/renesas/rcar-common/common.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2015 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
+#include <asm/armv8/cpu.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <hang.h>
@@ -68,14 +69,9 @@ int __weak board_init(void)
 
 void __weak reset_cpu(void)
 {
-	unsigned long midr, cputype;
-
-	asm volatile("mrs %0, midr_el1" : "=r" (midr));
-	cputype = (midr >> 4) & 0xfff;
-
-	if (cputype == 0xd03)
+	if (is_cortex_a53())
 		writel(RST_CA53_CODE, RST_CA53RESCNT);
-	else if (cputype == 0xd07)
+	else if (is_cortex_a57())
 		writel(RST_CA57_CODE, RST_CA57RESCNT);
 	else
 		hang();
-- 
2.45.2

