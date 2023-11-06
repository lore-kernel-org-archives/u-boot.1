Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD6AC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 10:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1A6C86B02;
	Mon,  6 Nov 2023 11:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infraroot.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=infraroot.at header.i=@infraroot.at header.b="HjNJ084u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B89C86FFC; Mon,  6 Nov 2023 11:15:21 +0100 (CET)
Received: from mail.infraroot.at (mail.infraroot.at [54.37.73.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3220D86611
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 11:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infraroot.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=goliath@infraroot.at
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
 by mail.infraroot.at (Postfix) with ESMTPSA id 9BDD441DF3;
 Mon,  6 Nov 2023 11:15:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 9BDD441DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
 s=default; t=1699265717;
 bh=PObjFkFh2lOQP2NqFbBeAPjWF/+jfz3OmrtsjHzDg5M=;
 h=From:To:Cc:Subject:Date:From;
 b=HjNJ084u1btkjkv0F+S9rHqbJyQQXJWcqu8AcugHxWyQTNn0xFKF5gnxaiRKibhHa
 VKh+xKOwhwC9wKUYeNEx6WM7ubi1Y7zskKa7o8YnTfWgltt9m4gCsUnGUJVnwOeMGa
 NtLs5mfGMYX2Uo0k/udoGexemO7zI09ZukHXxoeQ=
From: David Oberhollenzer <goliath@infraroot.at>
To: u-boot@lists.denx.de, jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com
Cc: David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH] fs/squashfs: enable LZ4 compression support
Date: Mon,  6 Nov 2023 11:14:03 +0100
Message-ID: <20231106101403.80409-1-goliath@infraroot.at>
X-Mailer: git-send-email 2.41.0
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

The structure is identical to the existing compressor implementations,
trivially adding lz4 decompression to sqfs_decompress.

The changes were tested using a sandbox build. An LZ4 compressed
squashfs image was bound as a host block device.

Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 fs/squashfs/sqfs_decompressor.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/squashfs/sqfs_decompressor.c b/fs/squashfs/sqfs_decompressor.c
index 6b3e01cdad..cfd1153fd7 100644
--- a/fs/squashfs/sqfs_decompressor.c
+++ b/fs/squashfs/sqfs_decompressor.c
@@ -18,6 +18,10 @@
 #include <u-boot/zlib.h>
 #endif
 
+#if IS_ENABLED(CONFIG_LZ4)
+#include <u-boot/lz4.h>
+#endif
+
 #if IS_ENABLED(CONFIG_ZSTD)
 #include <linux/zstd.h>
 #endif
@@ -38,6 +42,10 @@ int sqfs_decompressor_init(struct squashfs_ctxt *ctxt)
 	case SQFS_COMP_ZLIB:
 		break;
 #endif
+#if IS_ENABLED(CONFIG_LZ4)
+	case SQFS_COMP_LZ4:
+		break;
+#endif
 #if IS_ENABLED(CONFIG_ZSTD)
 	case SQFS_COMP_ZSTD:
 		ctxt->zstd_workspace = malloc(zstd_dctx_workspace_bound());
@@ -66,6 +74,10 @@ void sqfs_decompressor_cleanup(struct squashfs_ctxt *ctxt)
 	case SQFS_COMP_ZLIB:
 		break;
 #endif
+#if IS_ENABLED(CONFIG_LZ4)
+	case SQFS_COMP_LZ4:
+		break;
+#endif
 #if IS_ENABLED(CONFIG_ZSTD)
 	case SQFS_COMP_ZSTD:
 		free(ctxt->zstd_workspace);
@@ -139,6 +151,17 @@ int sqfs_decompress(struct squashfs_ctxt *ctxt, void *dest,
 
 		break;
 #endif
+#if IS_ENABLED(CONFIG_LZ4)
+	case SQFS_COMP_LZ4:
+		ret = LZ4_decompress_safe(source, dest, src_len, *dest_len);
+		if (ret < 0) {
+			printf("LZ4 decompression failed.\n");
+			return -EINVAL;
+		}
+
+		ret = 0;
+		break;
+#endif
 #if IS_ENABLED(CONFIG_ZSTD)
 	case SQFS_COMP_ZSTD:
 		ret = sqfs_zstd_decompress(ctxt, dest, *dest_len, source, src_len);
-- 
2.41.0

