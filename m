Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E3FC5AD55
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 05:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3C7360669;
	Sun,  9 Aug 2026 05:15:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AVnV7cFzJm8S; Sun,  9 Aug 2026 05:15:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 729E060606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786252535;
	bh=SOsXGJUyAoC2tUedSyqSfyeB47Tn6fELmgtXhqfHhSg=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QpPsNNtdB6gt9PngsBuW0AFj6ZSL+anwupqnmY+KdEmEAiLUwdL+y86zdEWLrWw5l
	 uvPzsIwS+8Z/4wKQpA2C8BnunLCMQOSQinP6c2R5t5j9FX36jNDe7frwIHZBgLRHAa
	 iMsHUOAk65vWNFlY6dojSFeXPowK2J8lHKB+qoQA+K2Ig2kbecjqYGlnWnqkCYl1Lp
	 mgWElERHHbbYPD7a51WZrpbWNZ23TtgwBUT+E9KjGBMJOueKDfru8avkZ7KJOaD6N+
	 UKDeIML77xLJSIPm+AjykT1rxEPbTeSi/Rw3mJFnL8P21oTvkRLS4gr/bq5ig+cEU6
	 rGZacg5D+N83w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 729E060606;
	Sun,  9 Aug 2026 05:15:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C9EB296
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 788CE80D3D
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:27:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VAbBXb_ArmKm for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 04:27:26 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AD1380A7A
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5AD1380A7A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AD1380A7A
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 327B23F60D
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:23:54 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbe9733fbf6so616165a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 21:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786249432; x=1786854232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SOsXGJUyAoC2tUedSyqSfyeB47Tn6fELmgtXhqfHhSg=;
 b=XE+K2kkf7DWQxhz5PRlRPsjB9gjsy9ahJcPh0a2Y5pakq7RehsA46FeOAagEUPI67S
 sQyi4IgGZCROcBQs+z2IZAP1P+8wI06RCNpRLC3nxdA1jVmyuaSiSUYCsRtav/EzHuOr
 lLgExWTWI8tXDaZUkgtqCph9o5brs5XV8g8qLkRRvKEcWuaGqbnNOCVMAJKV4Sg0XDcv
 2oFA2uP5djsVIG4l923Kv9ZyWkOz7SbjQZUU6odTvzLLD3RiXkXsDiCdDcUz7SrugIrP
 ngGLS1Bg5jNAfzx3jZtpQaiUkuqjgIUrgDft6X69AvUjqc+r8p/XAHAFBEdf+9if5BTK
 9PBw==
X-Gm-Message-State: AOJu0YzQ8T23zDdHpq1HSJuWsVP4OmiJsUy+iq+gqj01fPfQrEE+QTvx
 a25tQVtmHB+VYLr1f6dcS71bl8x5fbwtQYJqaDuGQZlLrIppnwnHad2ZjMpuOTDQ27etBR6dnim
 mCVgxaTraGBP7GPo3/w8m67tc2LxrnlQYRsb83jiwk2bvHdcSNPxxUDzGzt9hznCoqs7T/1GJsC
 ofui9r7Elm++9g/G+ddQ==
X-Gm-Gg: AR+sD12BASYPE4pvUeXlCr+V6YgdadyLNAh/7nkWzMrH5KSftXmh9U8BwQIVpONgwsd
 9E7kGMHYK9awNS06YLqDDCm6UO2KhZG0Nb/gmoXgbAHXZSiiOk0xWej9QMNIamr0oAGj0SVQrWs
 xbX+0PulNRo8qW1PKYPDQYz+FmIqbY3zQ/Bjd0ch+tE85mJMLOq98ynPgNpg31g6UMbydRgr88R
 PsHULY30QiFgwPnH9TREID2u3aM3r2I+1LxgagafUKls2JZGO3tWMusqXCdq3nnrAol+ezGNWT9
 snMtkP4LTcVI0kDLqE2KwCMbDMfXS3fB+u4sQTGJma7627qSOmzF1w98xd7QlXiWxMn2RTbfNV/
 nP4Inh8ZfrCCjh0gd2QxXXgACkfYMfSpiqjARscEiGPa1qDE5kVJ+JUxuZc0SZ7R8ILiZyA==
X-Received: by 2002:a05:6a21:329c:b0:3c3:8315:80b7 with SMTP id
 adf61e73a8af0-3cb85e9757amr39069135637.9.1786249432617; 
 Sat, 08 Aug 2026 21:23:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:329c:b0:3c3:8315:80b7 with SMTP id
 adf61e73a8af0-3cb85e9757amr39069098637.9.1786249432194; 
 Sat, 08 Aug 2026 21:23:52 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f35bc75sm2314583a12.19.2026.08.08.21.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 21:23:51 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>
Subject: [PATCH 1/3] bootm: size the noload decompression buffer from the
 compressor header
Date: Sun,  9 Aug 2026 04:23:27 +0000
Message-ID: <20260809042338.63397-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809042338.63397-1-aristo.chen@canonical.com>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 09 Aug 2026 05:15:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786249434;
 bh=SOsXGJUyAoC2tUedSyqSfyeB47Tn6fELmgtXhqfHhSg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nE205FxfndE3TufEmDaqQ5Cqy5wDyDtzhH8vmAxE3pQnMzBE7hcL+gBHyRys59BgO
 /V+gE6BYZPNAZIlohwgZhWQRu5fwdJikUpw1aUiYM4GNWOVyqOaizWxlep8Esm+nQH
 wNg8pHFJdVX+g6UjrUpRXUy2ddzXINj1vnlLiQ9k+3D9hecAuaD54NGqHPb/IqUaMc
 Qq0k5reW92L2cHDZOmCjpseLFB+Zskb1/ItM81Ofv4Vq6JHHMg7+x5mdyDawS2WuWk
 uAAO5YljVUFtfwlRLgvJlrU76Osw17vRB35WOJHMWhLh+J4702Rn2idZukaNo6x/By
 qRhDFq11pqmWa4c/ony6+hdAYlpkAtXGQnsCw5MyV0Own4tQ5Z/Y8J2B4ViNE008iq
 J8gCR3YLMG5IPzV2d32pnI4yHy7Yyed5JSzXltiATl86Uz8+DMqR7r3RlxhaIPw91o
 t+bGeSbbKWPhXn8046vOWCXJR8Qa92R9zCTRsNv3K+5JQXEPz4ng1iD08dbrpTFDiG
 C21uZRrXtSDGZeLsAw2HzltXubfc3E2Qyys9mVqrFWjJBpldVzZy2weJtEuwZB0dL1
 rNxMZUM1NPmwiWENpeLpCxVAtdiASGvHk1d6cP+vZ1ktZXsVvFCFctiL7r7xypcAat
 hdVi+5L0ZlWjIGqKHLFtMp44=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; spf=pass
 smtp.mailfrom=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=nE205Fxf
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

For a compressed kernel_noload image, bootm_load_os() allocates a
per-image decompression buffer of ALIGN(image_len * 8, SZ_1M). The 8x
multiplier is a heuristic: it comfortably covers what zstd and xz
achieve on real kernels, but any well-compressed payload (say, a big
run of zeros) can exceed it and fail decompression, and no fixed
multiplier is safe against arbitrarily compressible input.

Read the real uncompressed size from the compressor header instead.
Add a small helper image_decomp_get_uncompressed_size() that returns
the uncompressed size when the format carries one: gzip ISIZE, lzma
header uncompressed size, lz4 frame Content_Size when the FLG bit is
set, and zstd Frame_Content_Size. Other formats return -EOPNOTSUPP.
Bootm uses it to size the buffer to ALIGN(hdr_size, SZ_1M), capped at
CONFIG_SYS_BOOTM_LEN because the value is attacker-controlled, and
falls back to the 8x heuristic for formats without a size field
(bzip2, lzo, xz) or when the header lacks the size (some lzma or lz4
streams).

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c    | 20 +++++++++----
 boot/image.c    | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/image.h | 25 ++++++++++++++++
 3 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 3bce8586834..6ce98485889 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -654,17 +654,28 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	void *load_buf, *image_buf;
 	int err;
 
+	image_buf = map_sysmem(os.image_start, image_len);
+
 	/*
 	 * For a "noload" compressed kernel we need to allocate a buffer large
 	 * enough to decompress in to and use that as the load address now.
-	 * Allow up to 8x compression: this comfortably covers what zstd and xz
-	 * achieve on real kernels, with headroom for well-compressed payloads.
-	 * Use an alignment of 2MB since this might help arm64
+	 * Prefer the uncompressed size the compressor header carries (gzip,
+	 * lzma, lz4-with-content-size, zstd); the value is attacker-controlled
+	 * so cap it at CONFIG_SYS_BOOTM_LEN. Otherwise fall back to an 8x
+	 * multiplier, which comfortably covers what zstd and xz achieve on
+	 * real kernels with headroom for well-compressed payloads. Align to
+	 * 2MB since this might help arm64.
 	 */
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
 		phys_addr_t addr;
+		ulong hdr_size = 0;
 
-		decomp_len = ALIGN(image_len * 8, SZ_1M);
+		if (!image_decomp_get_uncompressed_size(os.comp, image_buf,
+							image_len, &hdr_size) &&
+		    hdr_size && hdr_size <= CONFIG_SYS_BOOTM_LEN)
+			decomp_len = ALIGN(hdr_size, SZ_1M);
+		else
+			decomp_len = ALIGN(image_len * 8, SZ_1M);
 		decomp_limit = BOOTM_DECOMP_LIMIT_PER_IMAGE;
 		err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr,
 				    decomp_len, LMB_NONE);
@@ -679,7 +690,6 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	}
 
 	load_buf = map_sysmem(load, 0);
-	image_buf = map_sysmem(os.image_start, image_len);
 	err = image_decomp(os.comp, load, os.image_start, os.type,
 			   load_buf, image_buf, image_len,
 			   decomp_len, &load_end);
diff --git a/boot/image.c b/boot/image.c
index 185d52ba492..5476c81bb6f 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -22,6 +22,7 @@
 
 #include <linux/errno.h>
 #include <asm/io.h>
+#include <asm/unaligned.h>
 
 /* Set this if we have less than 4 MB of malloc() space */
 #if CONFIG_SYS_MALLOC_LEN < (4096 * 1024)
@@ -442,6 +443,84 @@ int image_decomp_type(const unsigned char *buf, ulong len)
 	return cmagic->comp_id;
 }
 
+#ifndef USE_HOSTCC
+int image_decomp_get_uncompressed_size(int comp, const void *src, ulong len,
+				       ulong *sizep)
+{
+	const u8 *bytes = src;
+
+	switch (comp) {
+	case IH_COMP_GZIP: {
+		u32 isize;
+
+		/* Minimum gzip: 10-byte header + 2-byte deflate + 8-byte trailer */
+		if (len < 20)
+			return -EINVAL;
+		if (bytes[0] != 0x1f || bytes[1] != 0x8b)
+			return -EINVAL;
+		isize = get_unaligned_le32(bytes + len - 4);
+		*sizep = isize;
+		return 0;
+	}
+	case IH_COMP_LZMA:
+		if (CONFIG_IS_ENABLED(LZMA)) {
+			u64 usize;
+
+			/* LZMA header: 5-byte props + 8-byte uncompressed size */
+			if (len < LZMA_PROPS_SIZE + 8)
+				return -EINVAL;
+			usize = get_unaligned_le64(bytes + LZMA_PROPS_SIZE);
+			/* All-ones means "unknown", per the LZMA reference */
+			if (usize == U64_MAX)
+				return -EOPNOTSUPP;
+			if (usize > ULONG_MAX)
+				return -EINVAL;
+			*sizep = (ulong)usize;
+			return 0;
+		}
+		return -EOPNOTSUPP;
+	case IH_COMP_LZ4:
+		if (CONFIG_IS_ENABLED(LZ4)) {
+			u8 flg;
+
+			/* LZ4 frame: 4-byte magic + FLG + BD + optional 8-byte size */
+			if (len < 6)
+				return -EINVAL;
+			if (get_unaligned_le32(bytes) != LZ4F_MAGIC)
+				return -EINVAL;
+			flg = bytes[4];
+			/* Content-size flag (FLG bit 3): 8 bytes follow BD */
+			if (!(flg & 0x08))
+				return -EOPNOTSUPP;
+			if (len < 14)
+				return -EINVAL;
+			*sizep = get_unaligned_le64(bytes + 6);
+			return 0;
+		}
+		return -EOPNOTSUPP;
+	case IH_COMP_ZSTD:
+		if (CONFIG_IS_ENABLED(ZSTD)) {
+			zstd_frame_header hdr;
+			size_t ret;
+
+			ret = zstd_get_frame_header(&hdr, src, len);
+			if (zstd_is_error(ret) || ret > 0)
+				return -EINVAL;
+			if (hdr.frameContentSize == ZSTD_CONTENTSIZE_UNKNOWN)
+				return -EOPNOTSUPP;
+			if (hdr.frameContentSize == ZSTD_CONTENTSIZE_ERROR ||
+			    hdr.frameContentSize > ULONG_MAX)
+				return -EINVAL;
+			*sizep = (ulong)hdr.frameContentSize;
+			return 0;
+		}
+		return -EOPNOTSUPP;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+#endif /* !USE_HOSTCC */
+
 int image_decomp(int comp, ulong load, ulong image_start, int type,
 		 void *load_buf, void *image_buf, ulong image_len,
 		 uint unc_len, ulong *load_end)
diff --git a/include/image.h b/include/image.h
index 4149ebbcce9..5d590916208 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1092,6 +1092,31 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 		 void *load_buf, void *image_buf, ulong image_len,
 		 uint unc_len, ulong *load_end);
 
+/**
+ * image_decomp_get_uncompressed_size() - Read the uncompressed size from a
+ *                                        compressed stream's header
+ *
+ * Peeks at a compressed image and returns the uncompressed size where the
+ * format carries one: gzip ISIZE, lzma header uncompressed size, lz4 frame
+ * Content_Size (only when the FLG bit is set), zstd Frame_Content_Size. The
+ * value is attacker-controlled, so callers must sanity-check against an
+ * upper bound before using it as an allocation size.
+ *
+ * gzip's ISIZE is the original size modulo 2^32, so this API is only useful
+ * for images up to 4 GiB. That is more than enough for a kernel_noload
+ * decompression hint.
+ *
+ * @comp:	Compression type (IH_COMP_...)
+ * @src:	Compressed data
+ * @len:	Length of @src
+ * @sizep:	Set to the uncompressed size on success
+ * Return: 0 on success, -EOPNOTSUPP if @comp does not carry an uncompressed
+ *         size (or is not enabled in this build), -EINVAL on a malformed or
+ *         truncated header
+ */
+int image_decomp_get_uncompressed_size(int comp, const void *src, ulong len,
+				       ulong *sizep);
+
 /**
  * Set up properties in the FDT
  *
-- 
2.43.0

