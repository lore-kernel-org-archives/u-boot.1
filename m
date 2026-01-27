Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE77D2FEF4
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 23:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B45841DA;
	Wed, 28 Jan 2026 00:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WeNgzxb5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vslWY0d5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBBB841DD; Wed, 28 Jan 2026 00:49:45 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE382841D7
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 00:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f12FL3ZpFz9tgh;
 Wed, 28 Jan 2026 00:49:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769557782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tPCENax83oJ+8sivhqdtEuZV1CB8jfiEOWkwYLj8fXs=;
 b=WeNgzxb5YDdK20AlrYjY+Lg8XrYu/iqtT2efC8q5GSTODMDpZelg51F/lkV0A/JyfKnokm
 VBSJeBW4bZoRFqS0VV4nNBhowFdbEbskSm9GUm3LASTrWNryXuJppUjdf1aOYu13nkKP31
 V1rkDKsN6NyunaIqhoVVH1oFuigCXE9vZk47ekFDW5prNZyQViMnmw1ZrGe/0uhGjDwu1v
 /2GCIFQtT0xjaIttePJV8LjYKgqtvWKYPyLtyPIDrTUrzABDciBnhJx/rLBrxxUqTPPxI3
 IXM7ICDAl5V+otXxIqbf5ldsj3AMk5VJ2eb3TCBsjOTwSllnoYKZnEJsOVS7ag==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vslWY0d5;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769557780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tPCENax83oJ+8sivhqdtEuZV1CB8jfiEOWkwYLj8fXs=;
 b=vslWY0d5QP8Lsa7LZ55p1rSD2RBe0enlPvQC7Zq02l5rRDFhT+TYB9VzOdnuW/c5CnYUMC
 ZGGBb5jkN8UdV4UtNEJ2snPjbCD6gI1L6xGbPmZ4WOC98uBoEtZGL4Te02HoEjoYlSDtFI
 EkVFCMOZwUxrs6oQBGICJAe7eK+0czGdsF0PaZwtbjoP4d7BvEBOcoM6D9sip8vzLjbC7x
 St9KU4zyF/ennx5RXd4rMeoVqThAc5PGifrC4hR747Dm3FKcLgjCMYkZYH3E2F2+Muy5VM
 9ZJto3K9Uzs28HRJubCriSd8DiCubTWsX4mBtKXZAFJWUvExM5JuhhfeQUmtpA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] lmb: Reinstate access to memory above ram_top
Date: Wed, 28 Jan 2026 00:48:40 +0100
Message-ID: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: epya5j39f7ajrfpm9munk6ngksbgksbk
X-MBO-RS-ID: e437d0b28e0a96bfc63
X-Rspamd-Queue-Id: 4f12FL3ZpFz9tgh
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

Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
same bank"). These are based on incorrect premise of the first commit, that
"U-Boot does not use memory above ram_top". While U-Boot itself indeed does
not and should not use memory above ram_top, user can perfectly well use
that memory from the U-Boot shell, for example to load content in there.

Currently, attempt to use that memory to load large image using TFTP ends
with "TFTP error: trying to overwrite reserved memory...". With this change
in place, the memory can be used again.

Fixes: eb052cbb896f ("lmb: add and reserve memory above ram_top")
Fixes: 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
Reported-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
Cc: Mark Kettenis <kettenis@openbsd.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 lib/lmb.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index e2d9fe86c14..8f12c6ad8e5 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -611,7 +611,6 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 static void lmb_add_memory(void)
 {
 	int i;
-	phys_addr_t bank_end;
 	phys_size_t size;
 	u64 ram_top = gd->ram_top;
 	struct bd_info *bd = gd->bd;
@@ -625,23 +624,9 @@ static void lmb_add_memory(void)
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		size = bd->bi_dram[i].size;
-		bank_end = bd->bi_dram[i].start + size;
 
-		if (size) {
+		if (size)
 			lmb_add(bd->bi_dram[i].start, size);
-
-			/*
-			 * Reserve memory above ram_top as
-			 * no-overwrite so that it cannot be
-			 * allocated
-			 */
-			if (bd->bi_dram[i].start >= ram_top)
-				lmb_reserve(bd->bi_dram[i].start, size,
-					    LMB_NOOVERWRITE);
-			else if (bank_end > ram_top)
-				lmb_reserve(ram_top, bank_end - ram_top,
-					    LMB_NOOVERWRITE);
-		}
 	}
 }
 
-- 
2.51.0

