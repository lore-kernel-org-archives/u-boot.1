Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E966606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Fs2Or1qd;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=kzfY3RwF;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=jauhmPYR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDC1C4065E;
	Sat,  7 Nov 2026 21:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fyo8tSf-VyVp; Sat,  7 Nov 2026 21:49:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 385E840642
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794088157;
	b=O+JvbutMtJw48VPm/K0HX7ngdQuxz091bXmvHpwv1l5/dxq4oUNhw9xPk/NaddJVGSL+
	 tLFxI+52tqrArhPgUjR7K0zuEn3a/YVw7XTgoB3vhs+1uTRX1XKnjUeLDrisvKeY9+29M
	 dx9WV79ERsHKEPmoGjqwOXb79HTmWsXYsBSYtGXsnp/9YUaRb49Ne3kRwzi6teMLiIS26
	 yivaPmE8XM+KSbZpj9qLiZvQ8ozTsxrw8nysKA7uPTdaiaSsLVCwEBxDgTY8lRFApHJzK
	 RR0rYMqlT2ygpFdGpCXSRPKH5Q79EW3lEoWs86m9qEWErApBuQWpQmJxZCsIGivFH/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794088157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s0EC0GcHcG7LqZgEwqSzUqsx3Ee4LLX+wq/IUykFqK4=;
	b=EUVnCUaiZSdVcTtHUUWjxb9v1j6ArGbM8H3VwycLVp8vDG6mw1h6cPTWfnO22xGn/QB2
	 XSpBbGAV5iOSU4yzb+ytRt7h05oEkAGp8tCjAwiTzZ+oqb5EuEkOWuuD287cWONAFKjWG
	 mpFRxW3mDCqswMGB8Einp1BmHVgV2ZIA67JHTmwXVxSh9/lC6bAgjkz8u/1gUIaBonZxg
	 0s+17+dNpMFNtOT8pNivmZobhAS+vjke/qWEOSO1eSnSsMzQtjqRzoqjP/q8O8kgHCtG/
	 MlOVaPIM10fDhkDu8AIGwWCnJq5kwH6w9ytR9QPHtSlkAk1u9XdmIAVH4DksUYe9UkA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794088157;
	bh=s0EC0GcHcG7LqZgEwqSzUqsx3Ee4LLX+wq/IUykFqK4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fs2Or1qdqJh9aqebI3AL/dA4SguvfYIo1J0kpcjtb/oMT2XF2uTyd6qYgmZGc5hhV
	 r5Ra95JlQp8Wfll+0A9KBbBvUB6f+F5/r4NlHuL+ZHTAG39bDZSawMOT/jySbScJnC
	 J08eWahP1Mnm0aWYdOpNajxZIjaA++tjSKngneGSpDC7+TzHETjT8+zERyGGoNdILu
	 dsoMSTjoqCvDjbooBlyxQ/r+HLaIpFJsljbYlvGcyVYsp7nAjfjOBO94KgrlP6UI4A
	 p7c5iF1ums5OkdFzt+BCmysw7WAY85LmNUtO47Anpka6h1GaRU8vZeOAOOjUnkt8YW
	 RD/aW8HpEmCHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 385E840642;
	Sat,  7 Nov 2026 21:49:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D1466317
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 21:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE5F5400A9
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 21:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MssNWVxLXq0J for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 21:49:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A0F7940053
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=kzfY3RwF; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=jauhmPYR
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0F7940053
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 21:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1794088133; bh=s0EC0GcHcG7LqZgEwqSzUqs
 x3Ee4LLX+wq/IUykFqK4=; b=kzfY3RwFLbCltJvfQDaZBbeP9bAkXLAIVUEr6OE7iS0cuicHwF
 stQmpd7dIIPF1eIb0Ui7SFnJ+OiJ4904o3fEEy67+4JSIj1/tg2f28M4J9Mlc6WsvaS3xq/xiRb
 lo/WgphkjlJo6S6IuZhFQWVz2K5JORvx1QTFaj8mT+TzwfxVh0b9FjziXirrdp/PM2b1AJDVDHI
 SVNEHL1h20OwACP7L77x3CTZnRBZ+WZL/xq2OmvBtoc7raxI4cTAHel07Y+f4Op/PakIIEQtwHy
 WmhR6W5bXjYtMByEoHiU9Y63eNMhpNZEzxJ7oVSdK6jwvpzLkj2Wk7MFQB5LYUPKrFQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1794088133; bh=s0EC0GcHcG7LqZgEwqSzUqs
 x3Ee4LLX+wq/IUykFqK4=; b=jauhmPYRwZxpHbjpMl8Vr2ot/QEFdAIjP9EpYl6yeI4ThUuBsj
 Yln9MR0hqgJFr9grROtEne51wx6FYVYpFvAA==;
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tomas.alvarez-vanoli@hitachienergy.com,
 Bradley Morgan <brads@mainlining.org>
Subject: [PATCH] powerpc: time: Prevent overflow in usec2ticks()
Date: Sat,  7 Nov 2026 21:48:50 +0000
Message-ID: <20261107214850.3208042-1-brads@mainlining.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In usec2ticks(), the author of this file indicated
that this was only intended for "short delays"
for example, it would have overflowed at 10 seconds
at 400 MHz, which is quite a hack.

To fix this, use lldiv() and 64 bit math in order to
compute the tick count without the overflow, then
clamp the output to ULONG_MAX so it does not break
32 bit PowerPC boards

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/lib/time.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/lib/time.c b/arch/powerpc/lib/time.c
index 0a0e75e726b..120f1fcd0d7 100644
--- a/arch/powerpc/lib/time.c
+++ b/arch/powerpc/lib/time.c
@@ -6,27 +6,21 @@
 
 #include <init.h>
 #include <time.h>
+#include <div64.h>
+#include <linux/kernel.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 
 /* ------------------------------------------------------------------------- */
 
 /*
- * This function is intended for SHORT delays only.
- * It will overflow at around 10 seconds @ 400MHz,
- * or 20 seconds @ 200MHz.
+ * Convert microseconds to timebase ticks without overflow.
  */
 unsigned long usec2ticks(unsigned long usec)
 {
-	ulong ticks;
+	u64 ticks = lldiv((u64)usec * get_tbclk() + 500000, 1000000);
 
-	if (usec < 1000) {
-		ticks = ((usec * (get_tbclk()/1000)) + 500) / 1000;
-	} else {
-		ticks = ((usec / 10) * (get_tbclk() / 100000));
-	}
-
-	return (ticks);
+	return ticks > ULONG_MAX ? ULONG_MAX : ticks;
 }
 
 /* ------------------------------------------------------------------------- */
-- 
2.53.0

