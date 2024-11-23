Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE42DE6ADD5
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 09:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450B9892B5;
	Sat, 23 Nov 2024 10:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ncBQq6RU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 039AE8934C; Sat, 23 Nov 2024 10:04:11 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F40CA890C6
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 10:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 62B0E3FE79; 
 Sat, 23 Nov 2024 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732352648;
 bh=Z93Zi7scafQCBld+1btTRkWNFnV/D4OTZf6NSoc6A0g=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ncBQq6RU2SjniQaCynY/ECW1GW/NeNKO2Kb5uOgSL2Jx+H7Slb9NBee6gx+IXMvST
 G1q83LJO5bUxhH9HC4RZidVXni63M4rxeNWd8/b/iHw9gHR0pwLoYuBihXtYy4ahEL
 SYwSpk0aPPkRiaqz8fSCFQMnPhzWBJv85eDLU1XRqsmemjbWhMkOBmZWzo6V2T9Zzy
 sazwl3gDjNp9tdJF1x3jU8fb7VLKvBDaLFUYK7t7MqzxcSZ/aLRQwN6I6hExkpac6F
 sMWWpp5ZVhVM+Jw2lAKmjedf8hJmY3+xshaOJHQyg+n3L5U0x31D9Vj27KQsIcYWXo
 eac9BWVK/f2bg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: bootmenu typo 'read'
Date: Sat, 23 Nov 2024 10:04:03 +0100
Message-ID: <20241123090403.72548-1-heinrich.schuchardt@canonical.com>
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

%s/read/reads/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/bootmenu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index ffa63a4628d..b633aedf011 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -239,7 +239,7 @@ static int prepare_bootmenu_entry(struct bootmenu_data *menu,
 /**
  * prepare_uefi_bootorder_entry() - generate the uefi bootmenu entries
  *
- * This function read the "BootOrder" UEFI variable
+ * This function reads the "BootOrder" UEFI variable
  * and generate the bootmenu entries in the order of "BootOrder".
  *
  * @menu:	pointer to the bootmenu structure
-- 
2.45.2

