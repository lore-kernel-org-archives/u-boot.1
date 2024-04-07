Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2517C67861
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 02:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C7287FCD;
	Sun,  7 Apr 2024 04:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mailtundra.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailtundra.com header.i=@mailtundra.com header.b="hoxDdxoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F7287FEE; Sun,  7 Apr 2024 03:47:49 +0200 (CEST)
Received: from mail-4328.protonmail.ch (mail-4328.protonmail.ch [185.70.43.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC22787FC8
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 03:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mailtundra.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwleeds@mailtundra.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailtundra.com;
 s=protonmail2; t=1712454467; x=1712713667;
 bh=aO1Q0eZ3IpX5itggLG4t14PfZ7rYhYDfn3+UvDMkX7I=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=hoxDdxoSHXVJy7ZIuYAt+fzuQpXuPwWjuopxRhCtqXgvv8qf5Jl0mp7eidUY+Zgia
 borOoGERDuK2PraobTApVg17ROzdiXVsnERoJXSdYTuh46W+Q/I5c+8YeT5uCy6V0b
 3Oj5O+EBwymLeGxKT4mevov8iiRdpsz+cRmD7C3SLW8tkDIcI+j8wET3OhL0X9hKDn
 rm8kdtwUXSxxGQLTUsrEfqQFLu91MAdiQAJeQDOWbodVeo4KbWz/FyE5NmIdGi/I9q
 u2F9p+oXcmiRwsDjO7Wtfe4+ZwK/S+3ATiVaxocaT61J9XpU6MlK4Xh3P5qf0WfMsH
 mI+5wOctLTObQ==
X-Pm-Submission-Id: 4VBw8f0fkBz4wwdQ
From: mwleeds@mailtundra.com
To: u-boot@lists.denx.de
Cc: Phaedrus Leeds <mwleeds@mailtundra.com>
Subject: [PATCH 1/5] zfs: Fix malloc() success check
Date: Sat,  6 Apr 2024 18:47:25 -0700
Message-ID: <20240407014743.13872-2-mwleeds@mailtundra.com>
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

This code was hitting the error code path whenever malloc() succeeded
rather than when it failed, so presumably this part of the code hasn't
been tested. I had to apply this fix (and others) to get U-Boot to boot
from ZFS on an Nvidia Jetson TX2 NX SoM (an aarch64 computer).

Signed-off-by: Phaedrus Leeds <mwleeds@mailtundra.com>
Tested-by: Phaedrus Leeds <mwleeds@mailtundra.com>
---
 fs/zfs/zfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 1fec96cd5c..14779dee32 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -648,21 +648,21 @@ dmu_read(dnode_end_t *dn, uint64_t blkid, void **buf,
 		if (bp_array != dn->dn.dn_blkptr) {
 			free(bp_array);
 			bp_array = 0;
 		}
 
 		if (BP_IS_HOLE(bp)) {
 			size_t size = zfs_to_cpu16(dn->dn.dn_datablkszsec,
 											dn->endian)
 				<< SPA_MINBLOCKSHIFT;
 			*buf = malloc(size);
-			if (*buf) {
+			if (!*buf) {
 				err = ZFS_ERR_OUT_OF_MEMORY;
 				break;
 			}
 			memset(*buf, 0, size);
 			endian = (zfs_to_cpu64(bp->blk_prop, endian) >> 63) & 1;
 			break;
 		}
 		if (level == 0) {
 			err = zio_read(bp, endian, buf, 0, data);
 			endian = (zfs_to_cpu64(bp->blk_prop, endian) >> 63) & 1;
-- 
2.44.0

