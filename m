Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53E7105F797
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC53842A2;
	Fri, 13 Mar 2026 11:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HYlTg+23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA50C8420D; Fri, 13 Mar 2026 11:42:46 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0466984262
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D1FBEC42701;
 Fri, 13 Mar 2026 10:43:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B3E8260027;
 Fri, 13 Mar 2026 10:42:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F10D10369E9A; Fri, 13 Mar 2026 11:42:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773398563; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=DiZF0f1iw7KLdDNY/mEqmbk2vMSBX3WXTtrhAYBtOrA=;
 b=HYlTg+23mln74bmrqgSplr2Zn+JLnry/hkJ3yjQ9z3nZa6aOEXTXbkwY9FrFojODuyaGE/
 +i6vk+G4HF0CmxcJMFyZS8dieh555kvAIya2CEeMCwkBnFvoELvwFk58DR04j9bxeUIErq
 7BVRQNFuyj1lfRMhh0mWKd7zn06jx+/GFOYCBIlo538JbO7s6Jd91LyCFaddB1y69QlBmH
 ajdcMefgAdKNgPn+nD1Ln0VmF6T0LhX8Nb3d+GEQmAGtj7re4Zh4HnAV915y4RZeBig6He
 dHNrzl9XRsExwYpPIbWEe8MRt/X0tLv9ISy+SEUltFiFRJsvcHxHkxHTzNLxBw==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 2/7] fs/squashfs: sqfs_decompressor: simplify code
Date: Fri, 13 Mar 2026 11:42:24 +0100
Message-ID: <20260313104229.1555236-3-richard.genoud@bootlin.com>
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

Switch to if (CONFIG_IS_ENABLED()) instead of #if when possible and
remove unnecessary cases.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 fs/squashfs/sqfs_decompressor.c | 49 ++++++++-------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/fs/squashfs/sqfs_decompressor.c b/fs/squashfs/sqfs_decompressor.c
index d54f087274c3..a156cfe6f65a 100644
--- a/fs/squashfs/sqfs_decompressor.c
+++ b/fs/squashfs/sqfs_decompressor.c
@@ -33,57 +33,32 @@ int sqfs_decompressor_init(struct squashfs_ctxt *ctxt)
 {
 	u16 comp_type = get_unaligned_le16(&ctxt->sblk->compression);
 
-	switch (comp_type) {
-#if CONFIG_IS_ENABLED(LZO)
-	case SQFS_COMP_LZO:
-		break;
-#endif
-#if CONFIG_IS_ENABLED(ZLIB)
-	case SQFS_COMP_ZLIB:
-		break;
-#endif
-#if CONFIG_IS_ENABLED(LZ4)
-	case SQFS_COMP_LZ4:
-		break;
-#endif
+	if (((CONFIG_IS_ENABLED(LZO) && comp_type == SQFS_COMP_LZO)) ||
+	    ((CONFIG_IS_ENABLED(ZLIB) && comp_type == SQFS_COMP_ZLIB)) ||
+	    ((CONFIG_IS_ENABLED(LZ4) && comp_type == SQFS_COMP_LZ4)))
+		return 0;
+
 #if CONFIG_IS_ENABLED(ZSTD)
-	case SQFS_COMP_ZSTD:
+	if (comp_type == SQFS_COMP_ZSTD) {
 		ctxt->zstd_workspace = malloc(zstd_dctx_workspace_bound());
 		if (!ctxt->zstd_workspace)
 			return -ENOMEM;
-		break;
-#endif
-	default:
-		printf("Error: unknown compression type.\n");
-		return -EINVAL;
+		return 0;
 	}
+#endif
 
-	return 0;
+	printf("Error: unknown compression type.\n");
+	return -EINVAL;
 }
 
 void sqfs_decompressor_cleanup(struct squashfs_ctxt *ctxt)
 {
+#if CONFIG_IS_ENABLED(ZSTD)
 	u16 comp_type = get_unaligned_le16(&ctxt->sblk->compression);
 
-	switch (comp_type) {
-#if CONFIG_IS_ENABLED(LZO)
-	case SQFS_COMP_LZO:
-		break;
-#endif
-#if CONFIG_IS_ENABLED(ZLIB)
-	case SQFS_COMP_ZLIB:
-		break;
-#endif
-#if CONFIG_IS_ENABLED(LZ4)
-	case SQFS_COMP_LZ4:
-		break;
-#endif
-#if CONFIG_IS_ENABLED(ZSTD)
-	case SQFS_COMP_ZSTD:
+	if (comp_type == SQFS_COMP_ZSTD)
 		free(ctxt->zstd_workspace);
-		break;
 #endif
-	}
 }
 
 #if CONFIG_IS_ENABLED(ZLIB)
