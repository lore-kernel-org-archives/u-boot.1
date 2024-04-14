Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A13EC4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 15:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528F087F84;
	Sun, 14 Apr 2024 17:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZMRmTauY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EA4588059; Sun, 14 Apr 2024 17:04:25 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D244B87F84
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 17:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jnhuang95@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e4f341330fso19497845ad.0
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713107061; x=1713711861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ei4iDtfs2+46V/SfaK93I/3fA+TH2IC2IYfC2Hvk8U=;
 b=ZMRmTauYRNEtXfJlTZO21D9m0UoStYCEI07d48uzwo+4QlAn4yOZjKgPJzuC9q/tXS
 tI6qsc0XCunUDQ+i69K/NMGR3y3e2qcJ5qX4Dti5sLxr3rhgrmvWmfCI6gxC03B+HaGs
 IOe2Z8VDzrBiwo7xtPExDLwUWQOScPNt9SkZonGbdnk/dDGcRNaD8+Wr3xjpY/jrMJt7
 rTCtAsM0BBJ+9F7K+1F2M4LkalwPVmRLopn5iElFXqIIpqYSVn9szoj62Oyku3lhBvfC
 R+h44ESLwCYphoSYtiMoNqyIRHiNGBdxaxvHcpjFaOVnJ2z3zRrS67gal5aTreOiOxEp
 M0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713107061; x=1713711861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ei4iDtfs2+46V/SfaK93I/3fA+TH2IC2IYfC2Hvk8U=;
 b=SSu+hlxqJX1j70moPrAT/axZwmkrs/fS1yIFBFzxAnADtqKINiLLj2FIRRuFLS0vI5
 7jWa/MNHEQtsE4WVM8fAc9noFhqS7KOLRfbNw1HilPRDkiiG4wGS7SDIpnsKqdy5ylJb
 vGeD7egSjhTbMj+WFvfWSG3xUgb1CKMYKVK0jbTIHZSSygSfpcp7uEjaHBgndqnjb/aS
 FWZD0qPfXk/ROpitbkDS7CwiM6MbqDOVQ/AXK6P5k+DqFaqkLtVyHJq22hSyTLlm3aew
 eRfLQR9N9A8xEEWLoV8OWeN40jA5r/s7g7Ut2u7ZR0Pa0zPgssfBCXR3mQfOqBHCYHw0
 11FQ==
X-Gm-Message-State: AOJu0YzS6K9gvRpMjrK1Mg4cMPHbhO27PbHm8lgwVtQvIFEfwGfrJGF6
 UGbcP3Zk7EIHBsp6YdYeh6G+oMJnrbSAhdcbJKNy6HfBxUXW4J32dIm3u12PPMM=
X-Google-Smtp-Source: AGHT+IHOjM5907Qv5NFSUOo1Zunk+qQN1c9ZSdwaRambCzLaRTo7oTABJYtvP+586MGoO0pmcZsHng==
X-Received: by 2002:a17:902:eacd:b0:1e2:23b9:eb24 with SMTP id
 p13-20020a170902eacd00b001e223b9eb24mr6159226pld.33.1713107061157; 
 Sun, 14 Apr 2024 08:04:21 -0700 (PDT)
Received: from server.. ([5.44.249.114]) by smtp.gmail.com with ESMTPSA id
 k18-20020a170902f29200b001e0da190a07sm6130612plc.167.2024.04.14.08.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 08:04:20 -0700 (PDT)
From: Jianan Huang <jnhuang95@gmail.com>
To: u-boot@lists.denx.de
Cc: linux-erofs@lists.ozlabs.org,
	Jianan Huang <jnhuang95@gmail.com>
Subject: [PATCH] fs/erofs: add DEFLATE algorithm support
Date: Sun, 14 Apr 2024 23:04:14 +0800
Message-Id: <20240414150414.231027-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch adds DEFLATE compression algorithm support. It's a good choice
to trade off between compression ratios and performance compared to LZ4.
Alternatively, DEFLATE could be used for some specific files since EROFS
supports multiple compression algorithms in one image.

Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
---
 fs/erofs/Kconfig      | 15 ++++++++
 fs/erofs/decompress.c | 83 +++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h   |  1 +
 3 files changed, 99 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index ee4e777c5c..c8463357ca 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -19,3 +19,18 @@ config FS_EROFS_ZIP
 	help
 	  Enable fixed-sized output compression for EROFS.
 	  If you don't want to enable compression feature, say N.
+
+config FS_EROFS_ZIP_DEFLATE
+	bool "EROFS DEFLATE compressed data support"
+	depends on FS_EROFS_ZIP
+	select ZLIB
+	help
+	  Saying Y here includes support for reading EROFS file systems
+	  containing DEFLATE compressed data.  It gives better compression
+	  ratios than the default LZ4 format, while it costs more CPU
+	  overhead.
+
+	  DEFLATE support is an experimental feature for now and so most
+	  file systems will be readable without selecting this option.
+
+	  If unsure, say N.
diff --git a/fs/erofs/decompress.c b/fs/erofs/decompress.c
index e04e5c34a8..ec74816534 100644
--- a/fs/erofs/decompress.c
+++ b/fs/erofs/decompress.c
@@ -1,6 +1,85 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include "decompress.h"
 
+#if IS_ENABLED(CONFIG_ZLIB)
+#include <u-boot/zlib.h>
+
+/* report a zlib or i/o error */
+static int zerr(int ret)
+{
+	switch (ret) {
+	case Z_STREAM_ERROR:
+		return -EINVAL;
+	case Z_DATA_ERROR:
+		return -EIO;
+	case Z_MEM_ERROR:
+		return -ENOMEM;
+	case Z_ERRNO:
+	default:
+		return -EFAULT;
+	}
+}
+
+static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
+{
+	u8 *dest = (u8 *)rq->out;
+	u8 *src = (u8 *)rq->in;
+	u8 *buff = NULL;
+	unsigned int inputmargin = 0;
+	z_stream strm;
+	int ret;
+
+	while (!src[inputmargin & (erofs_blksiz() - 1)])
+		if (!(++inputmargin & (erofs_blksiz() - 1)))
+			break;
+
+	if (inputmargin >= rq->inputsize)
+		return -EFSCORRUPTED;
+
+	if (rq->decodedskip) {
+		buff = malloc(rq->decodedlength);
+		if (!buff)
+			return -ENOMEM;
+		dest = buff;
+	}
+
+	/* allocate inflate state */
+	strm.zalloc = Z_NULL;
+	strm.zfree = Z_NULL;
+	strm.opaque = Z_NULL;
+	strm.avail_in = 0;
+	strm.next_in = Z_NULL;
+	ret = inflateInit2(&strm, -15);
+	if (ret != Z_OK) {
+		free(buff);
+		return zerr(ret);
+	}
+
+	strm.next_in = src + inputmargin;
+	strm.avail_in = rq->inputsize - inputmargin;
+	strm.next_out = dest;
+	strm.avail_out = rq->decodedlength;
+
+	ret = inflate(&strm, rq->partial_decoding ? Z_SYNC_FLUSH : Z_FINISH);
+	if (ret != Z_STREAM_END || strm.total_out != rq->decodedlength) {
+		if (ret != Z_OK || !rq->partial_decoding) {
+			ret = zerr(ret);
+			goto out_inflate_end;
+		}
+	}
+
+	if (rq->decodedskip)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+
+out_inflate_end:
+	inflateEnd(&strm);
+	if (buff)
+		free(buff);
+	return ret;
+}
+#endif
+
 #if IS_ENABLED(CONFIG_LZ4)
 #include <u-boot/lz4.h>
 static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
@@ -93,6 +172,10 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 #if IS_ENABLED(CONFIG_LZ4)
 	if (rq->alg == Z_EROFS_COMPRESSION_LZ4)
 		return z_erofs_decompress_lz4(rq);
+#endif
+#if IS_ENABLED(CONFIG_ZLIB)
+	if (rq->alg == Z_EROFS_COMPRESSION_DEFLATE)
+		return z_erofs_decompress_deflate(rq);
 #endif
 	return -EOPNOTSUPP;
 }
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 158e2c68a1..5bac4fe1a1 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -304,6 +304,7 @@ enum {
 enum {
 	Z_EROFS_COMPRESSION_LZ4		= 0,
 	Z_EROFS_COMPRESSION_LZMA	= 1,
+	Z_EROFS_COMPRESSION_DEFLATE	= 2,
 	Z_EROFS_COMPRESSION_MAX
 };
 
-- 
2.34.1

