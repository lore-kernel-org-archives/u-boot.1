Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA773D35E5D
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 10:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0226588EC6;
	Thu,  7 Nov 2024 11:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="une35li8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EECD88EE3; Thu,  7 Nov 2024 11:14:51 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B869388606
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 11:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 47C623F1E9; 
 Thu,  7 Nov 2024 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730974487;
 bh=71csY/YlzZiBuo/Ai1aFm1aZJLhnZsSF26zclcHvzJk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=une35li8FrGWiIp4gxbgWcK2TREkOKoknEc/gTyxfMcwSju8UjZ6G/TtWpXEg4EGZ
 kiorXt4YAEqdQc3S+OdkIVTrMhOTaGS+9JdN4V4gBsDBS71nhnkInRCyqpXWOH7fB7
 JtWB+0gg3/pxqgkOhlFvd+AYIDdBTbHQzULZ9vAA0uHcFJkzm23g7z3UbzUSFn8rer
 DeNQtH2hGtk/6My21+PWBRNjAkggbhTpyCkyFYj+1PeHaaFGm0mXpkXLYmCZZrgdA5
 aE/nFURpDVimiarSBFzHoLojEVglgkBlQUgua20WzLewM03Kzbd5PhOV/21lYxiI12
 0B2G4WzNFVNew==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] lmb.c: add missing comma in lmb_dump_region()
Date: Thu,  7 Nov 2024 11:14:42 +0100
Message-ID: <20241107101443.45176-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In the message string " %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: "
a comma is missing before flags.

To avoid increasing the code size replace '0x%' by '%#'.

Printing the size with leading zeros but not the addresses does not really
make sense. Remove the leading zeros from the size output.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Remove leading zeros from size field.
---
 lib/lmb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 8b306e4de8e..48682f98b3a 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -90,7 +90,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 	enum lmb_flags flags;
 	int i;
 
-	printf(" %s.count = 0x%x\n", name, lmb_rgn_lst->count);
+	printf(" %s.count = %#x\n", name, lmb_rgn_lst->count);
 
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		base = rgn[i].base;
@@ -98,7 +98,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 		end = base + size - 1;
 		flags = rgn[i].flags;
 
-		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
+		printf(" %s[%d]\t[%#llx-%#llx], %#llx bytes, flags: ",
 		       name, i, base, end, size);
 		lmb_print_region_flags(flags);
 	}
-- 
2.45.2

