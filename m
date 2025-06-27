Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453F0C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 14:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764FF82E9A;
	Fri, 27 Jun 2025 16:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA6B82EA2; Fri, 27 Jun 2025 16:04:47 +0200 (CEST)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8faa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 218A281F66
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 16:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTHP44Yr8zkVg;
 Fri, 27 Jun 2025 16:04:40 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bTHP36WJfz25s; Fri, 27 Jun 2025 16:04:39 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 27 Jun 2025 16:04:29 +0200
Subject: [PATCH] env: mmc: specify that the address is a block address when
 erasing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-env-mmc-erase-blk-v1-1-d4b8fa90f68b@cherry.de>
X-B4-Tracking: v=1; b=H4sIAOykXmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyNz3dS8Mt3c3GTd1KLE4lTdpJxsXfNEE7NE41Qz42RzCyWgvoKi1LT
 MCrCZ0bG1tQCP/Uv9YwAAAA==
X-Change-ID: 20250627-env-mmc-erase-blk-7a46a3e63c78
To: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

I got very confused by the address printed when erasing the environment
because I clearly didn't remember setting it at that location.

It turns out, it's the block offset and not the byte offset that is
reported, so let's make this a bit more obvious to the user.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Another option would be to report the byte offset by multiplying
blk_start by desc->blksz I guess. The result needs to be stored in a u64
though instead of uint otherwise we'll be limited to 4GiB offset (which
should be fine in most cases but eh).
---
 env/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/mmc.c b/env/mmc.c
index 8848371eb4f5df58da2be5398f159fdd0a00da21..f16926dc74c594b15f0bc82301aa89e1d4456d59 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -383,7 +383,7 @@ static inline int erase_env(struct mmc *mmc, unsigned long size,
 	blk_cnt = ALIGN(size, erase_size) / desc->blksz;
 
 	n = blk_derase(desc, blk_start, blk_cnt);
-	printf("%d blocks erased at 0x%x: %s\n", n, blk_start,
+	printf("%d blocks erased starting from block at 0x%x: %s\n", n, blk_start,
 	       (n == blk_cnt) ? "OK" : "ERROR");
 
 	return (n == blk_cnt) ? 0 : 1;

---
base-commit: 359e3012921f2fc2d43f3c4e320a752173f82b82
change-id: 20250627-env-mmc-erase-blk-7a46a3e63c78

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

