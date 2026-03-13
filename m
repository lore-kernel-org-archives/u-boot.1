Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACEA105F797
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3249D84262;
	Fri, 13 Mar 2026 11:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0QaVEcfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3AB28428C; Fri, 13 Mar 2026 11:42:46 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5ED78420D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B22A81A2DF4
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 10:42:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7E60760027;
 Fri, 13 Mar 2026 10:42:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9AA6210369E77; Fri, 13 Mar 2026 11:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773398562; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=kTyNjtVmdxpiV/HgerPZlAOVpg/Iq3l1AJXoFC3/Eho=;
 b=0QaVEcfTYIeASR9s3nDo3W1yloHsl9ytrXn0vMYf7g1ytdL0Gd4kSPawe7ndYCtjrX+sS5
 JZEjsUlBxy7smoctJlxiAZfYBhpQ8sIbC9YgT6HcrB08SVNTnphdb3cAVJoKNNbAdUD0UK
 kJOuc7BhdcVNMiyAidjMpNIovnNIBsfhiTXCaLUbT7XaBlaXeLfbxfNwM+WXC2pl5EyHmU
 m/ha031/iJ6kXmChj/0gijhE0b3tdKXlJL+mCJAFtTgOLWehn/BpoljLh4z6xspovHa91M
 Uas9SzcFBjk95wbt5hCL4rqWmntd5Pmm/g4x/UdtVLiy3X7kF5A3OdRpldZJeg==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 1/7] fs/squashfs: fix sqfs_decompressor.c build in SPL
Date: Fri, 13 Mar 2026 11:42:23 +0100
Message-ID: <20260313104229.1555236-2-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313104229.1555236-1-richard.genoud@bootlin.com>
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

CONFIG_IS_ENABLED() must be used in place of IS_ENABLED() for config
options that have a _SPL_ counterpart.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 fs/squashfs/sqfs_decompressor.c | 36 ++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/squashfs/sqfs_decompressor.c b/fs/squashfs/sqfs_decompressor.c
index cfd1153fd74a..d54f087274c3 100644
--- a/fs/squashfs/sqfs_decompressor.c
+++ b/fs/squashfs/sqfs_decompressor.c
@@ -10,19 +10,19 @@
 #include <stdio.h>
 #include <stdlib.h>
 
-#if IS_ENABLED(CONFIG_LZO)
+#if CONFIG_IS_ENABLED(LZO)
 #include <linux/lzo.h>
 #endif
 
-#if IS_ENABLED(CONFIG_ZLIB)
+#if CONFIG_IS_ENABLED(ZLIB)
 #include <u-boot/zlib.h>
 #endif
 
-#if IS_ENABLED(CONFIG_LZ4)
+#if CONFIG_IS_ENABLED(LZ4)
 #include <u-boot/lz4.h>
 #endif
 
-#if IS_ENABLED(CONFIG_ZSTD)
+#if CONFIG_IS_ENABLED(ZSTD)
 #include <linux/zstd.h>
 #endif
 
@@ -34,19 +34,19 @@ int sqfs_decompressor_init(struct squashfs_ctxt *ctxt)
 	u16 comp_type = get_unaligned_le16(&ctxt->sblk->compression);
 
 	switch (comp_type) {
-#if IS_ENABLED(CONFIG_LZO)
+#if CONFIG_IS_ENABLED(LZO)
 	case SQFS_COMP_LZO:
 		break;
 #endif
-#if IS_ENABLED(CONFIG_ZLIB)
+#if CONFIG_IS_ENABLED(ZLIB)
 	case SQFS_COMP_ZLIB:
 		break;
 #endif
-#if IS_ENABLED(CONFIG_LZ4)
+#if CONFIG_IS_ENABLED(LZ4)
 	case SQFS_COMP_LZ4:
 		break;
 #endif
-#if IS_ENABLED(CONFIG_ZSTD)
+#if CONFIG_IS_ENABLED(ZSTD)
 	case SQFS_COMP_ZSTD:
 		ctxt->zstd_workspace = malloc(zstd_dctx_workspace_bound());
 		if (!ctxt->zstd_workspace)
@@ -66,19 +66,19 @@ void sqfs_decompressor_cleanup(struct squashfs_ctxt *ctxt)
 	u16 comp_type = get_unaligned_le16(&ctxt->sblk->compression);
 
 	switch (comp_type) {
-#if IS_ENABLED(CONFIG_LZO)
+#if CONFIG_IS_ENABLED(LZO)
 	case SQFS_COMP_LZO:
 		break;
 #endif
-#if IS_ENABLED(CONFIG_ZLIB)
+#if CONFIG_IS_ENABLED(ZLIB)
 	case SQFS_COMP_ZLIB:
 		break;
 #endif
-#if IS_ENABLED(CONFIG_LZ4)
+#if CONFIG_IS_ENABLED(LZ4)
 	case SQFS_COMP_LZ4:
 		break;
 #endif
-#if IS_ENABLED(CONFIG_ZSTD)
+#if CONFIG_IS_ENABLED(ZSTD)
 	case SQFS_COMP_ZSTD:
 		free(ctxt->zstd_workspace);
 		break;
@@ -86,7 +86,7 @@ void sqfs_decompressor_cleanup(struct squashfs_ctxt *ctxt)
 	}
 }
 
-#if IS_ENABLED(CONFIG_ZLIB)
+#if CONFIG_IS_ENABLED(ZLIB)
 static void zlib_decompression_status(int ret)
 {
 	switch (ret) {
@@ -103,7 +103,7 @@ static void zlib_decompression_status(int ret)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_ZSTD)
+#if CONFIG_IS_ENABLED(ZSTD)
 static int sqfs_zstd_decompress(struct squashfs_ctxt *ctxt, void *dest,
 				unsigned long dest_len, void *source, u32 src_len)
 {
@@ -129,7 +129,7 @@ int sqfs_decompress(struct squashfs_ctxt *ctxt, void *dest,
 	int ret = 0;
 
 	switch (comp_type) {
-#if IS_ENABLED(CONFIG_LZO)
+#if CONFIG_IS_ENABLED(LZO)
 	case SQFS_COMP_LZO: {
 		size_t lzo_dest_len = *dest_len;
 		ret = lzo1x_decompress_safe(source, src_len, dest, &lzo_dest_len);
@@ -141,7 +141,7 @@ int sqfs_decompress(struct squashfs_ctxt *ctxt, void *dest,
 		break;
 	}
 #endif
-#if IS_ENABLED(CONFIG_ZLIB)
+#if CONFIG_IS_ENABLED(ZLIB)
 	case SQFS_COMP_ZLIB:
 		ret = uncompress(dest, dest_len, source, src_len);
 		if (ret) {
@@ -151,7 +151,7 @@ int sqfs_decompress(struct squashfs_ctxt *ctxt, void *dest,
 
 		break;
 #endif
-#if IS_ENABLED(CONFIG_LZ4)
+#if CONFIG_IS_ENABLED(LZ4)
 	case SQFS_COMP_LZ4:
 		ret = LZ4_decompress_safe(source, dest, src_len, *dest_len);
 		if (ret < 0) {
@@ -162,7 +162,7 @@ int sqfs_decompress(struct squashfs_ctxt *ctxt, void *dest,
 		ret = 0;
 		break;
 #endif
-#if IS_ENABLED(CONFIG_ZSTD)
+#if CONFIG_IS_ENABLED(ZSTD)
 	case SQFS_COMP_ZSTD:
 		ret = sqfs_zstd_decompress(ctxt, dest, *dest_len, source, src_len);
 		if (ret) {
