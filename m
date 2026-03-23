Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4630BF46115
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 13:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8EDC84159;
	Mon, 23 Mar 2026 14:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OsYwVLrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BEDD84114; Mon, 23 Mar 2026 14:43:15 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E3688412F
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 14:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CCE041A0E;
 Mon, 23 Mar 2026 13:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B669BC2BCB1;
 Mon, 23 Mar 2026 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774273391;
 bh=yDPVfTxI35j0hA1l166oAbje8y9DRqGM1ZF+anP+BR0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OsYwVLrjy4YpA2iKRxf2qjRkuKc+rrmCQtG2hcQ7xCCyzhL7lwX3orRKUmFw0YWR7
 wJXLwOKmtWK1SjLCRuQ5mT8Gu+pj7Qh/Q24sIXAL2JR6LVxS2vdU2oTqpW+jq9SWnd
 t6H4keIF1cAnJgn+iosz0lS1OV9y+Q2uq+GKnIl6+XHWeXlQvO4jaqr3sAUoUR7qDo
 RCc/rBFHyBjQG4yYN1dzTqzZygZqARgjaGUECGILHxxRFkWBpJYDFUzzpa4kn5+O/b
 p9yeGcWwROkmP8s9bCCCHQMwVxFfQ+h+uXc7jcPW2p+CcExFS0Cdfz4MTooN5pTicP
 YVvep24zM5z/w==
From: Michael Walle <mwalle@kernel.org>
To: Huang Jianan <jnhuang95@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/4] fs/erofs: align the malloc'ed data
Date: Mon, 23 Mar 2026 14:42:17 +0100
Message-ID: <20260323134305.2675822-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323134305.2675822-1-mwalle@kernel.org>
References: <20260323134305.2675822-1-mwalle@kernel.org>
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

The data buffers are used to transfer from or to hardware peripherals.
Often, there are restrictions on addresses, i.e. they have to be aligned
at a certain size. Thus, allocate the data on the heap instead of the
stack (at a random address alignment). Use malloc_cache_aligned() to get
an aligned buffer.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 fs/erofs/data.c     | 11 ++++-------
 fs/erofs/internal.h |  1 +
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index b58ec6fcc66..61dbae51a9a 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -319,15 +319,13 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		}
 
 		if (map.m_plen > bufsize) {
-			char *tmp;
-
 			bufsize = map.m_plen;
-			tmp = realloc(raw, bufsize);
-			if (!tmp) {
+			free(raw);
+			raw = malloc_cache_aligned(bufsize);
+			if (!raw) {
 				ret = -ENOMEM;
 				break;
 			}
-			raw = tmp;
 		}
 
 		ret = z_erofs_read_one_data(inode, &map, raw,
@@ -336,8 +334,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret < 0)
 			break;
 	}
-	if (raw)
-		free(raw);
+	free(raw);
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1875f37fcd2..13c862325a6 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -11,6 +11,7 @@
 #include <linux/printk.h>
 #include <linux/log2.h>
 #include <inttypes.h>
+#include <memalign.h>
 #include "erofs_fs.h"
 
 #define erofs_err(fmt, ...)	\
-- 
2.47.3

