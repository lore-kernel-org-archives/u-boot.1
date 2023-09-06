Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB07EB8FAF
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 12:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 879FB86682;
	Wed,  6 Sep 2023 14:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="baLJt2OI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCB4866EC; Wed,  6 Sep 2023 14:25:25 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE0A886568
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 14:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 14C273F5DE; 
 Wed,  6 Sep 2023 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694003122;
 bh=NPPBtc7S0JdUzbKRuyoEpDPpi9Z7fkLIj33P13/yq1c=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=baLJt2OIa+qsRzFtHbFq7vPtCLfkGT+w3aF7EW5VfczL7WCuo8CnOtANT9lcKb7n/
 aUGwMawDKY4oOQ88kB5pdSjzFvgVYZ9X1MHRBBdFibUoAdhu9VmyVF88O9QMCBWGZn
 43Ig8aURI6BhCL84FyTcA7amGW9NYK527yDkZYFl4xTBqlLHi3LSQtoipER6+bAAXs
 xzexWjiMNHPtgXUCwFZHr2sD1i/rYkfilkybrRIof4urxIV8dNnZwq+KwNUX0HSaet
 SODxjW+DUr+U7AykBh8MjYtGGkbVIxyGoozAwq4Rlk6nky+F9wvjjZNLxkDGydr8BE
 wXf0iK0NcH0hQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Sean Anderson <sean.anderson@seco.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] spl: undefined return value in spl_blk_load_image
Date: Wed,  6 Sep 2023 14:25:11 +0200
Message-Id: <20230906122511.96787-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

spl_blk_load_image() should not return an uninitialized value if
blk_get_devnum_by_uclass_id() fails.

Fixes: 8ce6a2e17577 ("spl: blk: Support loading images from fs")
Reported-by: Xavier Drudis Ferran <xdrudis@tinet.cat>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/spl/spl_blk_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index eb6f526689..ea5d1a51d9 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -53,7 +53,7 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 	blk_desc = blk_get_devnum_by_uclass_id(uclass_id, devnum);
 	if (!blk_desc) {
 		printf("blk desc for %d %d not found\n", uclass_id, devnum);
-		goto out;
+		return -ENODEV;
 	}
 
 	blk_show_device(uclass_id, devnum);
-- 
2.40.1

