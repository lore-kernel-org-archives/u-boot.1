Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13917CD1284
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 02:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 000E388054;
	Sun,  7 Apr 2024 04:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mailtundra.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailtundra.com header.i=@mailtundra.com header.b="nBs+fxRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB8587FF2; Sun,  7 Apr 2024 03:47:53 +0200 (CEST)
Received: from mail-40112.protonmail.ch (mail-40112.protonmail.ch
 [185.70.40.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D50C87FBF
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 03:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mailtundra.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwleeds@mailtundra.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailtundra.com;
 s=protonmail2; t=1712454471; x=1712713671;
 bh=0LfasKg04Wh2dI+RfGLB6Hazyg/2+3J0ts5VIM9RzJ0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=nBs+fxREEZwqNJgWSsLub6NUQNP9a6bn8ugJSXCr922YWEC6YHwaWMHP5n9ffmtRw
 cQVp/K8Bfx5Tgh/utlWgMa5WRKPUJ+ttNVQj8gWw98egvmw7eyoPHhT71cxXDOsmiv
 5fmmEF5hVXbqD69lvnjbQm+IofrZNm2bw68HOtDUID3MjP8YQfVWmpHXhSNohj6zHD
 7EV49LB3PhP6faGgF/bBr2EQfc1paes9OWHsNP1kglMWSVsYQ+NA2HPgylE0Mij1f4
 GkBKUljo1a3o4RQ0SM86i5+Gt/H0Yt8eeR5DW7kdq2eneZqu2UNlaVtO4N8QpHXFZs
 2/himLtqEDT+g==
X-Pm-Submission-Id: 4VBw8k04PWz4wwdQ
From: mwleeds@mailtundra.com
To: u-boot@lists.denx.de
Cc: Phaedrus Leeds <mwleeds@mailtundra.com>
Subject: [PATCH 4/5] zfs: Fix return value of fs_devread()
Date: Sat,  6 Apr 2024 18:47:28 -0700
Message-ID: <20240407014743.13872-5-mwleeds@mailtundra.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240407014743.13872-1-mwleeds@mailtundra.com>
References: <20240407014743.13872-1-mwleeds@mailtundra.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Apr 2024 04:00:03 +0200
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

As evidenced by how other filesystems handle it, a return value of 0
from fs_devread() means failure; nonzero means success. The opposite
assumption was being made in zfs.c for the use of zfs_devread() so fix
the confusion by making zfs_devread() return 0 on success.

It probably doesn't make sense to change the handling of zfs_devread()
in zfs.c instead, because as it is it matches the semantics of the other
functions there.

Signed-off-by: Phaedrus Leeds <mwleeds@mailtundra.com>
Tested-by: Phaedrus Leeds <mwleeds@mailtundra.com>
---
 fs/zfs/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zfs/dev.c b/fs/zfs/dev.c
index 251e7d1f74..fcd9893b3a 100644
--- a/fs/zfs/dev.c
+++ b/fs/zfs/dev.c
@@ -19,12 +19,12 @@ static struct disk_partition *part_info;
 void zfs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
 {
 	zfs_blk_desc = rbdd;
 	part_info = info;
 }
 
 /* err */
 int zfs_devread(int sector, int byte_offset, int byte_len, char *buf)
 {
 	return fs_devread(zfs_blk_desc, part_info, sector, byte_offset,
-			  byte_len, buf);
+			  byte_len, buf) ? 0 : 1;
 }
-- 
2.44.0

