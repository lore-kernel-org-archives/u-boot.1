Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30619C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC62B88C11;
	Fri, 19 Jul 2024 12:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XXF+Wd+H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rJFCx+r3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003FD88C27; Fri, 19 Jul 2024 12:50:46 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A61F88C08
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKc6HVsz9sss;
 Fri, 19 Jul 2024 12:50:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOUyfBiVGmtJrYt3tFPjfh+3WQg4ZAf43XwkwyXJ1rU=;
 b=XXF+Wd+Hw12dSGnyppS1bC+RrKhatBvD7+SnraO8DczOZLUa6/QHoscP91ju7rHhojKJqp
 FdfHN4NDGbr29EVAS9i/NyFCRSDGOEFZVPPFqzF3L/DqYO401GiH1LLwGjCP/uZFqgTBKr
 3UsvsNtY4Igf7DKFF/qpizcx54zb5KGXrQMZNeoFy5rkPGvwPixugKtSZmvdwMddKg7w4L
 CYnT+p/v+lrQdl6DOyuZID0RkWpR2xm0/0g02I6X4HeM9Z2HiNda6qFz+pFthpmaHO6K4N
 mC++wS0siBXJ0TtEDTL9FGhWXnknnBx5Js2asTuFg7Vg3nw5bpssciAIY5YBAQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOUyfBiVGmtJrYt3tFPjfh+3WQg4ZAf43XwkwyXJ1rU=;
 b=rJFCx+r3SZjKIznpYSk8MfcvHV9Qf+Gl5ywRwiFiI/4NgIKoBRiFtKrvhcHd2FUoKAK/T6
 5fmaA4Dla0GkyRjCztCtMGuNT8QXYcMwdJ23lGbju00/z6uCufgtfvO8awSRkM+/QerLpW
 Kwa7a7Obdm+e0otVWQTbSVqJFQOkIhyn281ko/uwqxJhsbrRUG8nvFMTHs3eYTo2AKQ1/F
 Tw/RlcIxmxXMCXNX4KlKGbDuTNtZu2D3AIQ1GlDPZMyt48dch4Ef7uYegDz2Gd/bzCfGR/
 S+CMhJbWvLk0Rm+x98od2fGezyPqvdMpYgAOgLXV0KdPgWYGmW/WXx39GksFng==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 27/37] board: socrates: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:04 +0200
Message-ID: <20240719104948.323791-27-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 95a68580d04cea32a7a
X-MBO-RS-META: 3apx5ejw31fquuw68js1ogqmeuya84fc
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/socrates/ddr.c   | 1 -
 board/socrates/nand.c  | 1 -
 board/socrates/sdram.c | 1 -
 board/socrates/tlb.c   | 1 -
 4 files changed, 4 deletions(-)

diff --git a/board/socrates/ddr.c b/board/socrates/ddr.c
index bf4894eff67..317c6b0a9f5 100644
--- a/board/socrates/ddr.c
+++ b/board/socrates/ddr.c
@@ -3,7 +3,6 @@
  * Copyright 2008 Freescale Semiconductor, Inc.
  */
 
-
 #include <fsl_ddr_sdram.h>
 #include <fsl_ddr_dimm_params.h>
 
diff --git a/board/socrates/nand.c b/board/socrates/nand.c
index 517a4a0af6a..b8e6e2cd76e 100644
--- a/board/socrates/nand.c
+++ b/board/socrates/nand.c
@@ -56,7 +56,6 @@ static void sc_nand_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
 	}
 }
 
-
 /**
  * sc_nand_read_byte -  read one byte from the chip
  * @mtd:	MTD device structure
diff --git a/board/socrates/sdram.c b/board/socrates/sdram.c
index d0415d26ce7..00a3f2b31e7 100644
--- a/board/socrates/sdram.c
+++ b/board/socrates/sdram.c
@@ -14,7 +14,6 @@
 #include <spd_sdram.h>
 #include <linux/delay.h>
 
-
 #if !defined(CONFIG_SPD_EEPROM)
 /*
  * Autodetect onboard DDR SDRAM on 85xx platforms
diff --git a/board/socrates/tlb.c b/board/socrates/tlb.c
index 0cc675781d1..b4ddb1b1739 100644
--- a/board/socrates/tlb.c
+++ b/board/socrates/tlb.c
@@ -28,7 +28,6 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
 		      0, 0, BOOKE_PAGESZ_4K, 0),
 
-
 	/*
 	 * TLB 1:	64M	Non-cacheable, guarded
 	 * 0xfc000000	64M	FLASH
-- 
2.43.0

