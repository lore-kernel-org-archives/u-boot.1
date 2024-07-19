Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91004C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1965988BB9;
	Fri, 19 Jul 2024 12:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HBbCmrSM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HBbCmrSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3880F88BB9; Fri, 19 Jul 2024 12:50:25 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6323088B49
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRKC17Xzz9tXk;
 Fri, 19 Jul 2024 12:50:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uk4DzoNArApLWn/IrTaFP2AJz1WSxaySSjyuEWTS5A=;
 b=HBbCmrSM8fyxsY+c3AajtROz5xphZoDZtObqD+Ks2EiWoCjvWJungQNaHFo7/XO0gGRX2o
 61j2MwCEcX0DOoISgqF6KEvgzvFmZaJUYDk8yiCx6pE+YOQ7X0//rGz/+7u6cl89xgz6K6
 sS/bV7VepBr4AtHKQDr2Jj+6+i/dRlrTXtFf//5r7Ulc3YnWHPEejKflVhyTgvB/ndqg8m
 a15GI0nzOS+QqPlwBt1bQQ38X/3IUhGySdY7NjsRXChN4IcFGcU2WdUtF60GMpayKyYZrA
 Sd3K53qU1gGGAtklEQGsMSRcUUnmI3qwJ8b9rfuVieSv/ykXXq0Yl1uYVqw/IQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uk4DzoNArApLWn/IrTaFP2AJz1WSxaySSjyuEWTS5A=;
 b=HBbCmrSM8fyxsY+c3AajtROz5xphZoDZtObqD+Ks2EiWoCjvWJungQNaHFo7/XO0gGRX2o
 61j2MwCEcX0DOoISgqF6KEvgzvFmZaJUYDk8yiCx6pE+YOQ7X0//rGz/+7u6cl89xgz6K6
 sS/bV7VepBr4AtHKQDr2Jj+6+i/dRlrTXtFf//5r7Ulc3YnWHPEejKflVhyTgvB/ndqg8m
 a15GI0nzOS+QqPlwBt1bQQ38X/3IUhGySdY7NjsRXChN4IcFGcU2WdUtF60GMpayKyYZrA
 Sd3K53qU1gGGAtklEQGsMSRcUUnmI3qwJ8b9rfuVieSv/ykXXq0Yl1uYVqw/IQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/37] board: cobra5272: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:44 +0200
Message-ID: <20240719104948.323791-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4abx9xhp86ximrx7y4139kmtm3shy1x1
X-MBO-RS-ID: 89de03838332cade85c
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
 board/cobra5272/flash.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/board/cobra5272/flash.c b/board/cobra5272/flash.c
index 157b71da85e..616842e62f4 100644
--- a/board/cobra5272/flash.c
+++ b/board/cobra5272/flash.c
@@ -61,7 +61,6 @@ Done:
 	return;
 }
 
-
 unsigned long flash_init(void)
 {
 	int i, j;
@@ -112,7 +111,6 @@ unsigned long flash_init(void)
 	return size;
 }
 
-
 #define CMD_READ_ARRAY		0x00F0
 #define CMD_UNLOCK1		0x00AA
 #define CMD_UNLOCK2		0x0055
@@ -133,7 +131,6 @@ unsigned long flash_init(void)
 #define ERR   2
 #define TMO   4
 
-
 int flash_erase(flash_info_t *info, int s_first, int s_last)
 {
 	ulong result;
@@ -267,7 +264,6 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	if ((result & data) != data)
 		return ERR_NOT_ERASED;
 
-
 	/*
 	 * Disable interrupts which might cause a timeout
 	 * here. Remember that our exception vectors are
@@ -317,7 +313,6 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	return rc;
 }
 
-
 int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 {
 	ulong wp, data;
-- 
2.43.0

