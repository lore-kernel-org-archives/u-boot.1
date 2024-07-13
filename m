Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6D3C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26DA088913;
	Sat, 13 Jul 2024 15:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LzaTIdbR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ypLB+nHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47E3888EE; Sat, 13 Jul 2024 15:21:48 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 064C7888FA
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyf5h7jz9sZF;
 Sat, 13 Jul 2024 15:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFrleFeD2Cqp7p1+my/K56Jr4ZaV/Y97wEvdakthUL0=;
 b=LzaTIdbR9lF4GckhbXwLqtp8+5NBl466LFZikn/MspxgyKxFqhAFqXj4s2W5xiV3jSUdPd
 QDCvZhE/40SAxP0SV5x6YfTmm48ScQPiOa8wXcY6lwpmJB5aLP9xqOs77gtkTVuIFrSsEm
 tXi4z5wIeskmeNLuDsjiQ/NiOzN1PgL2dGTM/drnvMUiaEoJpP3Yjl2WRxe5EUiJkZ+HPV
 l0xN3BqUqkLJepdSv2cA5AqF+KKdFheZXy6Ah+3i0HGJnjDTZTpl6hwyHFXj91YQcaFjbJ
 lecjeBwigrj94ImnhkrlqGqsYGqNC3HyqwX0bkOP4Z3U3vEZ0cigYoDFnPALCw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFrleFeD2Cqp7p1+my/K56Jr4ZaV/Y97wEvdakthUL0=;
 b=ypLB+nHfZj1ORQa9RiguXmp08QPzwIHfx1HIvbz9EGg4CQlDk0i44FKe3Mj2ICeCoa2jag
 dTryrv0yshHkj7pD+kYaE0eDiQD7WtHSw+JV5a9PIkdcCXGr30xdKH24jw7qQnTkWLKm03
 VCvd7HC0nqAPhEVGtuTOUi2R5Rg/7NlWIN3Vr9eAMGpACGuCGUh2iySDm9rQKCEKQMYkIl
 nXR8JhMNlyIGoo6eApMCCraSdBb9su7K6g+IYj2traInSZtRwH+kqgU7ecHigU7yNlA0iP
 bDxfXtkVP0jsIdnEIZYEtLl+bdaCnAQ72XB18GF2t7oxqY9EdjN/1ZidSe7odA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 37/45] post: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:28 +0200
Message-ID: <20240713132021.57650-37-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 665492e44de751f98fd
X-MBO-RS-META: d5cs9c3wbex1xhr5nszj6s4p16gqhp86
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
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 post/drivers/flash.c       | 1 -
 post/drivers/memory.c      | 2 --
 post/lib_powerpc/cpu_asm.h | 1 -
 post/tests.c               | 1 -
 4 files changed, 5 deletions(-)

diff --git a/post/drivers/flash.c b/post/drivers/flash.c
index 21e2f940fe9..7638a99f2eb 100644
--- a/post/drivers/flash.c
+++ b/post/drivers/flash.c
@@ -12,7 +12,6 @@
 #include <post.h>
 #include <flash.h>
 
-
 /*
  * This code will walk over the declared sectors erasing them,
  * then programming them, then verifying the written contents.
diff --git a/post/drivers/memory.c b/post/drivers/memory.c
index 8d4ae6fc6f1..2e41c4619e0 100644
--- a/post/drivers/memory.c
+++ b/post/drivers/memory.c
@@ -157,7 +157,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #warning "Injecting address line errors for testing purposes"
 #endif
 
-
 /*
  * This function performs a double word move from the data at
  * the source pointer to the location at the destination pointer.
@@ -199,7 +198,6 @@ const static unsigned long long pattern[] = {
 };
 const unsigned long long otherpattern = 0x0123456789abcdefULL;
 
-
 static int memory_post_dataline(unsigned long long * pmem)
 {
 	unsigned long long temp64 = 0;
diff --git a/post/lib_powerpc/cpu_asm.h b/post/lib_powerpc/cpu_asm.h
index 75cf71b6370..d1e3f68faa7 100644
--- a/post/lib_powerpc/cpu_asm.h
+++ b/post/lib_powerpc/cpu_asm.h
@@ -203,5 +203,4 @@
 #define ASM_STSWI(rd, rs, simm)		ASM_11IF(OP_STSWI, rd, rs, simm)
 #define ASM_STSWX(rd, rs1, rs2)		ASM_12(OP_STSWX, rd, rs1, rs2)
 
-
 #endif /* _CPU_ASM_H */
diff --git a/post/tests.c b/post/tests.c
index 208710a48ba..cdd088a32f2 100644
--- a/post/tests.c
+++ b/post/tests.c
@@ -43,7 +43,6 @@ extern int sysmon_init_f (void);
 
 extern void sysmon_reloc (void);
 
-
 struct post_test post_list[] =
 {
 #if CFG_POST & CFG_SYS_POST_OCM
-- 
2.43.0

