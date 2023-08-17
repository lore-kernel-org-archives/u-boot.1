Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42334EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 07:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DC986A30;
	Thu, 17 Aug 2023 09:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ahuepS1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B7986903; Thu, 17 Aug 2023 09:01:17 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6904086A4B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 09:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A6E9B3F213; 
 Thu, 17 Aug 2023 07:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692255673;
 bh=ZdFV02Z7zTTpGdVtPSIKn1KnXrSIWH+DhPdbHzB5M4U=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=ahuepS1bzx0+HnubDq0tq4PiBCtIjEIF4b2yPl+Ql4GgS8/4FL+NDAmbz0JGaYBa5
 A8SO19y0DvlEM5OBuaYofqebcP5sp0hZyqfVVRuSbGJsGEg1vyAbJXic7dNfqcw0Dk
 L/qbhk1ituCOVUL9vyrxHvwedpoQqy0Els07DrBpfimf201h1FEdjUnK5/1XR+wudz
 l/dmxexYV8XQzGeHorFVvfq9p82fAldYNK1f0WpZobejhanZBTK6kG2r+WDy46GBd1
 SUjgPWCNSjWNSiQy2aDI/udYU9HmfjEIRMzUjeHcts8E97ImH84/TUDFMQlRftuSrN
 I/1wy6y9QR8yg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Huang Jianan <jnhuang95@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] fs/erofs: avoid noisy messages
Date: Thu, 17 Aug 2023 09:01:38 +0200
Message-Id: <20230817070138.44258-1-heinrich.schuchardt@canonical.com>
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

The erofs file system creates noisy messages when it is not used:

    => host bind 0 disk.img
    => part list host 0
    cannot find valid erofs superblock
    cannot find valid erofs superblock

    Partition Map for HOST device 0  --   Partition Type: EFI

If there is not erofs file system, this only deserves a debug message.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d33926281b..d405d488fd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -68,14 +68,14 @@ int erofs_read_superblock(void)
 
 	ret = erofs_blk_read(data, 0, erofs_blknr(sizeof(data)));
 	if (ret < 0) {
-		erofs_err("cannot read erofs superblock: %d", ret);
+		erofs_dbg("cannot read erofs superblock: %d", ret);
 		return -EIO;
 	}
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
-		erofs_err("cannot find valid erofs superblock");
+		erofs_dbg("cannot find valid erofs superblock");
 		return ret;
 	}
 
-- 
2.40.1

