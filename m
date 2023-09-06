Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7807AEE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1828486998;
	Wed,  6 Sep 2023 23:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="v/UoRNhX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xMTdAR4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90ED9869A0; Wed,  6 Sep 2023 23:30:47 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC7C869A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RgwXN02bKz9sjN;
 Wed,  6 Sep 2023 23:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNvKj4CUZ/gO0qfu0wcIAYT9+yMOEf+ABmLbCG1eE2U=;
 b=v/UoRNhX4TwFVkzgPtHKlKrS+i9bbdcmxMTfsa3T/Ms+2zd9TrJgYOhqTlpXIzj+v8hiK8
 +vAcidzRbX8XjLJzISjz6QsIf0uwzrZAbNLqsz0ylRJhQVjSN1CAlmTBxj1LqjE4jKtx+D
 GU9OZSyN8usEhqGFd+n/hTZt8UMdZ6d6z00LqP1m5oiOPpzr+LzThRPHmZ3XZY4zIbsJfG
 gTXVxLD/Atmxycv/1Dj/Nr6rkoi/yf635zdKYnsknJM14FIXCwwAS/Actpp6okOfpWcheg
 7ALbXSBHHtXOJnSmnPdGSF6HS6q5TGXFWZmBhAudorG5/Z2VX1r9NpjGYVpHPA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNvKj4CUZ/gO0qfu0wcIAYT9+yMOEf+ABmLbCG1eE2U=;
 b=xMTdAR4Ckc7bIMibm3yYTQrlLLAl02bct8RhHabOa8+s1yV7YsZqTxG/PnvGz7AMi8+xBC
 5eBpPaGuXrWIuHrL0xmq4Udv9hWVInfwNWB5LioXjIMjYZveCyMCFzhf4jw7GEKHQ0TgU4
 2JMpb0GrwJaEGNIzo178ogpL5ibBaDBDGRFBnkqgaS6ayt284mPF10uDBy6AaTdBpTtt3g
 eVBgWlb2n0XZZy1w0OCfv/YPRHdPbss17FCmfLV7V8dn7AsrWGi2QpY0U1GYSY3QAG7YZ/
 R5lWKKntvAYXAdzCm799KG9Q9xjB4EFql+u2tjuSULs6Gpnql8DgIDBUiYZBIw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 06/35] common: malloc: Remove unused NEEDS_MANUAL_RELOC code
 bits
Date: Wed,  6 Sep 2023 23:29:46 +0200
Message-Id: <20230906213015.203437-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4hjy13due494jm8rxe5k6pn1kgs775i4
X-MBO-RS-ID: 0210d69280749094a0b
X-Rspamd-Queue-Id: 4RgwXN02bKz9sjN
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 common/dlmalloc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 0f9b7262d51..ebf0f27e165 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -575,19 +575,6 @@ static mbinptr av_[NAV * 2 + 2] = {
  IAV(120), IAV(121), IAV(122), IAV(123), IAV(124), IAV(125), IAV(126), IAV(127)
 };
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-static void malloc_bin_reloc(void)
-{
-	mbinptr *p = &av_[2];
-	size_t i;
-
-	for (i = 2; i < ARRAY_SIZE(av_); ++i, ++p)
-		*p = (mbinptr)((ulong)*p + gd->reloc_off);
-}
-#else
-static inline void malloc_bin_reloc(void) {}
-#endif
-
 #ifdef CONFIG_SYS_MALLOC_DEFAULT_TO_INIT
 static void malloc_init(void);
 #endif
@@ -634,7 +621,6 @@ void mem_malloc_init(ulong start, ulong size)
 #ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
 	memset((void *)mem_malloc_start, 0x0, size);
 #endif
-	malloc_bin_reloc();
 }
 
 /* field-extraction macros */
-- 
2.40.1

