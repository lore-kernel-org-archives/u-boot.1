Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595DBC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17DB460817;
	Mon, 24 Aug 2026 16:46:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G5pWwN7_ksoM; Mon, 24 Aug 2026 16:46:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589965;
	bh=wd4zS0O7UFrVaPErHeZ92aU5x9fYeGsCqQggKa2oues=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O725OByU3pN/9D01SwJ1/sKyVhKg66JIcrlaz448b5zX/1NMOtTP13WIbk5NvoPw2
	 9OX4dXuKHuwGbCEf+tRCfErlQ4uxyLYSZzyhAzfRsfihusPU8Q9N3u+dhbuMqqSWXJ
	 kBBk+YxTUHTaqkyAtUQGiCjkXbFcVxU/wzbKsyu2kPkQ3dn5t+wwIYKqzO73lCL/J8
	 JGmz6umdbN6IMzqgprhUgKBXj1JQyo7sn51Ypz6z6y6IA6XKCHK2RLhHzzkxMeTZBX
	 bJODRBJKpDKrmnufPuyQNSDe6ShkMHrPDbI5Ys7WxTipKfa0dxuyvMAKkH1VQZJUJ5
	 eNRXMFgoFlkwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0F2D6073F;
	Mon, 24 Aug 2026 16:46:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F025118
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39BC54005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hj_03pempj-4 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 16:21:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.29;
 helo=mail-10629.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=jxGC0Uzd
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch
 [79.135.106.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65D3040029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787588471; x=1787847671;
 bh=wd4zS0O7UFrVaPErHeZ92aU5x9fYeGsCqQggKa2oues=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=jxGC0Uzdtr42Ur2jByi4qE81yjGctAO1ZKEzcV8IGuufRdpEcEjShgQVRua3bNDGQ
 rBvZxEP0LJJ/diWc8HPJU5AxQ6F9kML+9mfELfjfQKEFQ6PUidf1riTtM2skGXST9t
 EuO7UMhJ5wMF711kcmSRuJ9HMzGggzsAJP5Ht7X0kw3A8gtEo1+p+f27LLIzJBKDH+
 CFdfTJUfj58rzON/+40sJMt6jL/eFEJthTgvbRaFpX/Uo80f5/pjU7gDfx/LIy3GSa
 tpcJGfxlZNTfTCFaj48z6U/nfbyySsiF5MvgkH7tVc3QQpyJrN0m2zITQYbOALlnyH
 4dJd83JBVrNEA==
Date: Mon, 24 Aug 2026 16:21:07 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3] lib: zstd: update to latest Linux zstd 1.5.7
Message-ID: <8b94e9fbaf45e2ccede0f1a4a6bfdf53f82a6a60.1787561254.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: a6b728487fb1e87a65de306bf7e6081b50195c0e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Update the zstd implementation to match Linux zstd 1.5.7 from commit
65d1f5507ed2 ("zstd: Import upstream v1.5.7").

U-Boot has carried zstd 1.5.2 since commit 4b9b25d943ff ("lib: zstd: update
to latest Linux zstd 1.5.2"), which mirrored Linux commit 2aa14b1ab2c4.
Linux has since moved to 1.5.7, which carries decode robustness and
correctness fixes.

The import is mechanical, so here is what it consists of, for whoever bumps
this next.

Taken from the Linux tree as-is:

  lib/zstd/common/              (whole directory)
  lib/zstd/decompress/          (whole directory)
  lib/zstd/decompress_sources.h
  lib/zstd/zstd_common_module.c
  lib/zstd/zstd_decompress_module.c
  include/linux/zstd.h
  include/linux/zstd_lib.h
  include/linux/zstd_errors.h

Linux lib/zstd/compress/ is not copied at all, since U-Boot only
decompresses and the 1.5.2 import already left it out. lib/zstd/Makefile,
lib/zstd/zstd.c and the Kconfig are U-Boot's own and are not mirrored.

Four adaptations then go back on top, the ones commit 4b9b25d943ff
documented:

- includes that do not translate. In common/mem.h linux/swab.h becomes
  asm/byteorder.h; in common/zstd_deps.h linux/limits.h becomes
  linux/kernel.h; in both module .c files linux/module.h becomes
  linux/compat.h; and the linux/limits.h include in zstd_lib.h is dropped.
- common/mem.h: MEM_STATIC becomes static INLINE_KEYWORD UNUSED_ATTR for
  codesize, which also needs common/compiler.h included there.
- common/debug.h: drop the DEBUGLEVEL>=3D1 block defining assert(), so zstd=
's
  does not fight U-Boot's.
- include/linux/zstd.h: append U-Boot's own zstd_decompress(struct abuf *in=
,
  struct abuf *out) declaration, which has no Linux counterpart.

Two more are new to this bump:

- common/mem.h picks up linux/unaligned.h in 1.5.7, from the Linux rename o=
f
  asm/unaligned.h. U-Boot still provides the asm/ one, so put it back.
- collapse runs of blank lines to one. Commit 2f8c004a5ae5 ("lib: Remove
  duplicate newlines") stripped those tree-wide after the 1.5.2 import, so
  mirroring Linux verbatim would re-add 137 of them.

1.5.7 adds a faster Huffman decode path, and buildman -B shows it is where
nearly all the growth lands, mostly in HUF_decompress4X1_usingDTable_intern=
al,
HUF_readDTableX1_wksp and the new fast_c_loop. Upstream guards that path wi=
th
HUF_DISABLE_FAST_DECODE, so add it to the CONFIG_ZSTD_LIB_MINIFY flags besi=
de
the HUF_FORCE_DECOMPRESS_X1 and DYNAMIC_BMI2=3D0 already there. It recovers=
 1684
bytes on turris_mox. Giving up decode speed for size is what that option is
for.

Tested on sandbox: "ut lib" passes 133 tests with no failures, including
compression_test_zstd and compression_test_bootm_zstd. Also cross-built
for aarch64 (turris_mox with CONFIG_ZSTD=3Dy) with no new warnings.
Size delta with CONFIG_ZSTD_LIB_MINIFY=3Dy is text +1088 bytes on sandbox a=
nd
text +236 bytes on turris_mox, with data and bss unchanged on both. Without
HUF_DISABLE_FAST_DECODE those are +2888 and +1920.

Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
Changes in v3:
- Write the import procedure into the commit message, per Quentin. No code
  change from v2, the diff is identical.

Changes in v2:
- Add HUF_DISABLE_FAST_DECODE to the CONFIG_ZSTD_LIB_MINIFY flags, per Tom.
  turris_mox goes from +1920 to +236 bytes against 1.5.2, sandbox from +288=
8
  to +1088.

checkpatch is loud on this one, but that comes from mirroring the Linux
sources, not from the change itself. checkpatch --file over lib/zstd gives
5127 errors on the 1.5.2 code already in tree and 5283 on 1.5.7, over 28 an=
d
30 files, so the per-line density is flat.

The message now carries the recipe rather than pointing at a script. The
script is 60-odd lines of cp and sed doing what the message lists. If a
future bump wants it in tree, that is its own patch.
 include/linux/zstd.h                          |  253 +++-
 include/linux/zstd_errors.h                   |   31 +-
 include/linux/zstd_lib.h                      | 1114 +++++++++++++----
 lib/zstd/Makefile                             |    1 +
 lib/zstd/common/allocations.h                 |   56 +
 lib/zstd/common/bits.h                        |  150 +++
 lib/zstd/common/bitstream.h                   |  151 ++-
 lib/zstd/common/compiler.h                    |  149 ++-
 lib/zstd/common/cpu.h                         |    3 +-
 lib/zstd/common/debug.c                       |    9 +-
 lib/zstd/common/debug.h                       |   34 +-
 lib/zstd/common/entropy_common.c              |   42 +-
 lib/zstd/common/error_private.c               |   13 +-
 lib/zstd/common/error_private.h               |   84 +-
 lib/zstd/common/fse.h                         |   95 +-
 lib/zstd/common/fse_decompress.c              |  125 +-
 lib/zstd/common/huf.h                         |  235 ++--
 lib/zstd/common/mem.h                         |    5 +-
 lib/zstd/common/portability_macros.h          |   44 +-
 lib/zstd/common/zstd_common.c                 |   36 +-
 lib/zstd/common/zstd_deps.h                   |   10 +-
 lib/zstd/common/zstd_internal.h               |  149 +--
 lib/zstd/decompress/huf_decompress.c          |  878 ++++++++-----
 lib/zstd/decompress/zstd_ddict.c              |    9 +-
 lib/zstd/decompress/zstd_ddict.h              |    3 +-
 lib/zstd/decompress/zstd_decompress.c         |  399 ++++--
 lib/zstd/decompress/zstd_decompress_block.c   |  724 ++++++-----
 lib/zstd/decompress/zstd_decompress_block.h   |   10 +-
 .../decompress/zstd_decompress_internal.h     |   19 +-
 lib/zstd/decompress_sources.h                 |    2 +-
 lib/zstd/zstd_common_module.c                 |    5 +-
 lib/zstd/zstd_decompress_module.c             |   40 +-
 32 files changed, 3137 insertions(+), 1741 deletions(-)
 create mode 100644 lib/zstd/common/allocations.h
 create mode 100644 lib/zstd/common/bits.h

diff --git a/include/linux/zstd.h b/include/linux/zstd.h
index 3cf54d11f75e..0d46db6c77c1 100644
--- a/include/linux/zstd.h
+++ b/include/linux/zstd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -77,6 +77,30 @@ int zstd_min_clevel(void);
  */
 int zstd_max_clevel(void);
=20
+/**
+ * zstd_default_clevel() - default compression level
+ *
+ * Return: Default compression level.
+ */
+int zstd_default_clevel(void);
+
+/**
+ * struct zstd_custom_mem - custom memory allocation
+ */
+typedef ZSTD_customMem zstd_custom_mem;
+
+/**
+ * struct zstd_dict_load_method - Dictionary load method.
+ * See zstd_lib.h.
+ */
+typedef ZSTD_dictLoadMethod_e zstd_dict_load_method;
+
+/**
+ * struct zstd_dict_content_type - Dictionary context type.
+ * See zstd_lib.h.
+ */
+typedef ZSTD_dictContentType_e zstd_dict_content_type;
+
 /* =3D=3D=3D=3D=3D=3D   Parameter Selection   =3D=3D=3D=3D=3D=3D */
=20
 /**
@@ -136,9 +160,32 @@ typedef ZSTD_parameters zstd_parameters;
 zstd_parameters zstd_get_params(int level,
 =09unsigned long long estimated_src_size);
=20
-/* =3D=3D=3D=3D=3D=3D   Single-pass Compression   =3D=3D=3D=3D=3D=3D */
+/**
+ * zstd_get_cparams() - returns zstd_compression_parameters for selected l=
evel
+ * @level:              The compression level
+ * @estimated_src_size: The estimated source size to compress or 0
+ *                      if unknown.
+ * @dict_size:          Dictionary size.
+ *
+ * Return:              The selected zstd_compression_parameters.
+ */
+zstd_compression_parameters zstd_get_cparams(int level,
+=09unsigned long long estimated_src_size, size_t dict_size);
=20
 typedef ZSTD_CCtx zstd_cctx;
+typedef ZSTD_cParameter zstd_cparameter;
+
+/**
+ * zstd_cctx_set_param() - sets a compression parameter
+ * @cctx:         The context. Must have been initialized with zstd_init_c=
ctx().
+ * @param:        The parameter to set.
+ * @value:        The value to set the parameter to.
+ *
+ * Return:        Zero or an error, which can be checked using zstd_is_err=
or().
+ */
+size_t zstd_cctx_set_param(zstd_cctx *cctx, zstd_cparameter param, int val=
ue);
+
+/* =3D=3D=3D=3D=3D=3D   Single-pass Compression   =3D=3D=3D=3D=3D=3D */
=20
 /**
  * zstd_cctx_workspace_bound() - max memory needed to initialize a zstd_cc=
tx
@@ -153,6 +200,20 @@ typedef ZSTD_CCtx zstd_cctx;
  */
 size_t zstd_cctx_workspace_bound(const zstd_compression_parameters *parame=
ters);
=20
+/**
+ * zstd_cctx_workspace_bound_with_ext_seq_prod() - max memory needed to
+ * initialize a zstd_cctx when using the block-level external sequence
+ * producer API.
+ * @parameters: The compression parameters to be used.
+ *
+ * If multiple compression parameters might be used, the caller must call
+ * this function for each set of parameters and use the maximum size.
+ *
+ * Return:      A lower bound on the size of the workspace that is passed =
to
+ *              zstd_init_cctx().
+ */
+size_t zstd_cctx_workspace_bound_with_ext_seq_prod(const zstd_compression_=
parameters *parameters);
+
 /**
  * zstd_init_cctx() - initialize a zstd compression context
  * @workspace:      The workspace to emplace the context into. It must out=
live
@@ -180,6 +241,71 @@ zstd_cctx *zstd_init_cctx(void *workspace, size_t work=
space_size);
 size_t zstd_compress_cctx(zstd_cctx *cctx, void *dst, size_t dst_capacity,
 =09const void *src, size_t src_size, const zstd_parameters *parameters);
=20
+/**
+ * zstd_create_cctx_advanced() - Create compression context
+ * @custom_mem:   Custom allocator.
+ *
+ * Return:        NULL on error, pointer to compression context otherwise.
+ */
+zstd_cctx *zstd_create_cctx_advanced(zstd_custom_mem custom_mem);
+
+/**
+ * zstd_free_cctx() - Free compression context
+ * @cdict:        Pointer to compression context.
+ *
+ * Return:        Always 0.
+ */
+size_t zstd_free_cctx(zstd_cctx* cctx);
+
+/**
+ * struct zstd_cdict - Compression dictionary.
+ * See zstd_lib.h.
+ */
+typedef ZSTD_CDict zstd_cdict;
+
+/**
+ * zstd_create_cdict_byreference() - Create compression dictionary
+ * @dict:              Pointer to dictionary buffer.
+ * @dict_size:         Size of the dictionary buffer.
+ * @dict_load_method:  Dictionary load method.
+ * @dict_content_type: Dictionary content type.
+ * @custom_mem:        Memory allocator.
+ *
+ * Note, this uses @dict by reference (ZSTD_dlm_byRef), so it should be
+ * free before zstd_cdict is destroyed.
+ *
+ * Return:             NULL on error, pointer to compression dictionary
+ *                     otherwise.
+ */
+zstd_cdict *zstd_create_cdict_byreference(const void *dict, size_t dict_si=
ze,
+=09=09=09=09=09  zstd_compression_parameters cparams,
+=09=09=09=09=09  zstd_custom_mem custom_mem);
+
+/**
+ * zstd_free_cdict() - Free compression dictionary
+ * @cdict:        Pointer to compression dictionary.
+ *
+ * Return:        Always 0.
+ */
+size_t zstd_free_cdict(zstd_cdict* cdict);
+
+/**
+ * zstd_compress_using_cdict() - compress src into dst using a dictionary
+ * @cctx:         The context. Must have been initialized with zstd_init_c=
ctx().
+ * @dst:          The buffer to compress src into.
+ * @dst_capacity: The size of the destination buffer. May be any size, but
+ *                ZSTD_compressBound(srcSize) is guaranteed to be large en=
ough.
+ * @src:          The data to compress.
+ * @src_size:     The size of the data to compress.
+ * @cdict:        The dictionary to be used.
+ *
+ * Return:        The compressed size or an error, which can be checked us=
ing
+ *                zstd_is_error().
+ */
+size_t zstd_compress_using_cdict(zstd_cctx *cctx, void *dst,
+=09size_t dst_capacity, const void *src, size_t src_size,
+=09const zstd_cdict *cdict);
+
 /* =3D=3D=3D=3D=3D=3D   Single-pass Decompression   =3D=3D=3D=3D=3D=3D */
=20
 typedef ZSTD_DCtx zstd_dctx;
@@ -220,6 +346,70 @@ zstd_dctx *zstd_init_dctx(void *workspace, size_t work=
space_size);
 size_t zstd_decompress_dctx(zstd_dctx *dctx, void *dst, size_t dst_capacit=
y,
 =09const void *src, size_t src_size);
=20
+/**
+ * struct zstd_ddict - Decompression dictionary.
+ * See zstd_lib.h.
+ */
+typedef ZSTD_DDict zstd_ddict;
+
+/**
+ * zstd_create_ddict_byreference() - Create decompression dictionary
+ * @dict:              Pointer to dictionary buffer.
+ * @dict_size:         Size of the dictionary buffer.
+ * @dict_load_method:  Dictionary load method.
+ * @dict_content_type: Dictionary content type.
+ * @custom_mem:        Memory allocator.
+ *
+ * Note, this uses @dict by reference (ZSTD_dlm_byRef), so it should be
+ * free before zstd_ddict is destroyed.
+ *
+ * Return:             NULL on error, pointer to decompression dictionary
+ *                     otherwise.
+ */
+zstd_ddict *zstd_create_ddict_byreference(const void *dict, size_t dict_si=
ze,
+=09=09=09=09=09  zstd_custom_mem custom_mem);
+/**
+ * zstd_free_ddict() - Free decompression dictionary
+ * @dict:         Pointer to the dictionary.
+ *
+ * Return:        Always 0.
+ */
+size_t zstd_free_ddict(zstd_ddict *ddict);
+
+/**
+ * zstd_create_dctx_advanced() - Create decompression context
+ * @custom_mem:   Custom allocator.
+ *
+ * Return:        NULL on error, pointer to decompression context otherwis=
e.
+ */
+zstd_dctx *zstd_create_dctx_advanced(zstd_custom_mem custom_mem);
+
+/**
+ * zstd_free_dctx() -- Free decompression context
+ * @dctx:         Pointer to decompression context.
+ * Return:        Always 0.
+ */
+size_t zstd_free_dctx(zstd_dctx *dctx);
+
+/**
+ * zstd_decompress_using_ddict() - decompress src into dst using a diction=
ary
+ * @dctx:         The decompression context.
+ * @dst:          The buffer to decompress src into.
+ * @dst_capacity: The size of the destination buffer. Must be at least as =
large
+ *                as the decompressed size. If the caller cannot upper bou=
nd the
+ *                decompressed size, then it's better to use the streaming=
 API.
+ * @src:          The zstd compressed data to decompress. Multiple concate=
nated
+ *                frames and skippable frames are allowed.
+ * @src_size:     The exact size of the data to decompress.
+ * @ddict:        The dictionary to be used.
+ *
+ * Return:        The decompressed size or an error, which can be checked =
using
+ *                zstd_is_error().
+ */
+size_t zstd_decompress_using_ddict(zstd_dctx *dctx,
+=09void *dst, size_t dst_capacity, const void *src, size_t src_size,
+=09const zstd_ddict *ddict);
+
 /* =3D=3D=3D=3D=3D=3D   Streaming Buffers   =3D=3D=3D=3D=3D=3D */
=20
 /**
@@ -257,6 +447,16 @@ typedef ZSTD_CStream zstd_cstream;
  */
 size_t zstd_cstream_workspace_bound(const zstd_compression_parameters *cpa=
rams);
=20
+/**
+ * zstd_cstream_workspace_bound_with_ext_seq_prod() - memory needed to ini=
tialize
+ * a zstd_cstream when using the block-level external sequence producer AP=
I.
+ * @cparams: The compression parameters to be used for compression.
+ *
+ * Return:   A lower bound on the size of the workspace that is passed to
+ *           zstd_init_cstream().
+ */
+size_t zstd_cstream_workspace_bound_with_ext_seq_prod(const zstd_compressi=
on_parameters *cparams);
+
 /**
  * zstd_init_cstream() - initialize a zstd streaming compression context
  * @parameters        The zstd parameters to use for compression.
@@ -416,6 +616,18 @@ size_t zstd_decompress_stream(zstd_dstream *dstream, z=
std_out_buffer *output,
  */
 size_t zstd_find_frame_compressed_size(const void *src, size_t src_size);
=20
+/**
+ * zstd_register_sequence_producer() - exposes the zstd library function
+ * ZSTD_registerSequenceProducer(). This is used for the block-level exter=
nal
+ * sequence producer API. See upstream zstd.h for detailed documentation.
+ */
+typedef ZSTD_sequenceProducer_F zstd_sequence_producer_f;
+void zstd_register_sequence_producer(
+  zstd_cctx *cctx,
+  void* sequence_producer_state,
+  zstd_sequence_producer_f sequence_producer
+);
+
 /**
  * struct zstd_frame_params - zstd frame parameters stored in the frame he=
ader
  * @frameContentSize: The frame content size, or ZSTD_CONTENTSIZE_UNKNOWN =
if not
@@ -429,7 +641,7 @@ size_t zstd_find_frame_compressed_size(const void *src,=
 size_t src_size);
  *
  * See zstd_lib.h.
  */
-typedef ZSTD_frameHeader zstd_frame_header;
+typedef ZSTD_FrameHeader zstd_frame_header;
=20
 /**
  * zstd_get_frame_header() - extracts parameters from a zstd or skippable =
frame
@@ -444,6 +656,39 @@ typedef ZSTD_frameHeader zstd_frame_header;
 size_t zstd_get_frame_header(zstd_frame_header *params, const void *src,
 =09size_t src_size);
=20
+/**
+ * struct zstd_sequence - a sequence of literals or a match
+ *
+ * @offset: The offset of the match
+ * @litLength: The literal length of the sequence
+ * @matchLength: The match length of the sequence
+ * @rep: Represents which repeat offset is used
+ */
+typedef ZSTD_Sequence zstd_sequence;
+
+/**
+ * zstd_compress_sequences_and_literals() - compress an array of zstd_sequ=
ence and literals
+ *
+ * @cctx: The zstd compression context.
+ * @dst: The buffer to compress the data into.
+ * @dst_capacity: The size of the destination buffer.
+ * @in_seqs: The array of zstd_sequence to compress.
+ * @in_seqs_size: The number of sequences in in_seqs.
+ * @literals: The literals associated to the sequences to be compressed.
+ * @lit_size: The size of the literals in the literals buffer.
+ * @lit_capacity: The size of the literals buffer.
+ * @decompressed_size: The size of the input data
+ *
+ * Return: The compressed size or an error, which can be checked using
+ * =09   zstd_is_error().
+ */
+size_t zstd_compress_sequences_and_literals(zstd_cctx *cctx, void* dst, si=
ze_t dst_capacity,
+=09=09=09=09=09    const zstd_sequence *in_seqs, size_t in_seqs_size,
+=09=09=09=09=09    const void* literals, size_t lit_size, size_t lit_capac=
ity,
+=09=09=09=09=09    size_t decompressed_size);
+
+#endif  /* LINUX_ZSTD_H */
+
 struct abuf;
=20
 /**
@@ -454,5 +699,3 @@ struct abuf;
  * Return: size of the decompressed data, or -ve on error
  */
 int zstd_decompress(struct abuf *in, struct abuf *out);
-
-#endif  /* LINUX_ZSTD_H */
diff --git a/include/linux/zstd_errors.h b/include/linux/zstd_errors.h
index edba6e1fab51..6e4040b7fb9d 100644
--- a/include/linux/zstd_errors.h
+++ b/include/linux/zstd_errors.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -11,12 +12,18 @@
 #ifndef ZSTD_ERRORS_H_398273423
 #define ZSTD_ERRORS_H_398273423
=20
-/*=3D=3D=3D=3D=3D dependency =3D=3D=3D=3D=3D*/
-#include <linux/types.h>   /* size_t */
-
 /* =3D=3D=3D=3D=3D   ZSTDERRORLIB_API : control library symbols visibility=
   =3D=3D=3D=3D=3D */
-#define ZSTDERRORLIB_VISIBILITY=20
-#define ZSTDERRORLIB_API ZSTDERRORLIB_VISIBILITY
+#define ZSTDERRORLIB_VISIBLE=20
+
+#ifndef ZSTDERRORLIB_HIDDEN
+#  if (__GNUC__ >=3D 4) && !defined(__MINGW32__)
+#    define ZSTDERRORLIB_HIDDEN __attribute__ ((visibility ("hidden")))
+#  else
+#    define ZSTDERRORLIB_HIDDEN
+#  endif
+#endif
+
+#define ZSTDERRORLIB_API ZSTDERRORLIB_VISIBLE
=20
 /*-*********************************************
  *  Error codes list
@@ -41,14 +48,18 @@ typedef enum {
   ZSTD_error_frameParameter_windowTooLarge =3D 16,
   ZSTD_error_corruption_detected =3D 20,
   ZSTD_error_checksum_wrong      =3D 22,
+  ZSTD_error_literals_headerWrong =3D 24,
   ZSTD_error_dictionary_corrupted      =3D 30,
   ZSTD_error_dictionary_wrong          =3D 32,
   ZSTD_error_dictionaryCreation_failed =3D 34,
   ZSTD_error_parameter_unsupported   =3D 40,
+  ZSTD_error_parameter_combination_unsupported =3D 41,
   ZSTD_error_parameter_outOfBound    =3D 42,
   ZSTD_error_tableLog_tooLarge       =3D 44,
   ZSTD_error_maxSymbolValue_tooLarge =3D 46,
   ZSTD_error_maxSymbolValue_tooSmall =3D 48,
+  ZSTD_error_cannotProduce_uncompressedBlock =3D 49,
+  ZSTD_error_stabilityCondition_notRespected =3D 50,
   ZSTD_error_stage_wrong       =3D 60,
   ZSTD_error_init_missing      =3D 62,
   ZSTD_error_memory_allocation =3D 64,
@@ -56,18 +67,18 @@ typedef enum {
   ZSTD_error_dstSize_tooSmall =3D 70,
   ZSTD_error_srcSize_wrong    =3D 72,
   ZSTD_error_dstBuffer_null   =3D 74,
+  ZSTD_error_noForwardProgress_destFull =3D 80,
+  ZSTD_error_noForwardProgress_inputEmpty =3D 82,
   /* following error codes are __NOT STABLE__, they can be removed or chan=
ged in future versions */
   ZSTD_error_frameIndex_tooLarge =3D 100,
   ZSTD_error_seekableIO          =3D 102,
   ZSTD_error_dstBuffer_wrong     =3D 104,
   ZSTD_error_srcBuffer_wrong     =3D 105,
+  ZSTD_error_sequenceProducer_failed =3D 106,
+  ZSTD_error_externalSequences_invalid =3D 107,
   ZSTD_error_maxCode =3D 120  /* never EVER use this value directly, it ca=
n change in future versions! Use ZSTD_isError() instead */
 } ZSTD_ErrorCode;
=20
-/*! ZSTD_getErrorCode() :
-    convert a `size_t` function result into a `ZSTD_ErrorCode` enum type,
-    which can be used to compare with enum list published above */
-ZSTDERRORLIB_API ZSTD_ErrorCode ZSTD_getErrorCode(size_t functionResult);
 ZSTDERRORLIB_API const char* ZSTD_getErrorString(ZSTD_ErrorCode code);   /=
*< Same as ZSTD_getErrorName, but using a `ZSTD_ErrorCode` enum argument */
=20
 #endif /* ZSTD_ERRORS_H_398273423 */
diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
index a4d559c62a29..fad7f3454930 100644
--- a/include/linux/zstd_lib.h
+++ b/include/linux/zstd_lib.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -11,21 +12,44 @@
 #ifndef ZSTD_H_235446
 #define ZSTD_H_235446
=20
-/* =3D=3D=3D=3D=3D=3D   Dependency   =3D=3D=3D=3D=3D=3D*/
+/* =3D=3D=3D=3D=3D=3D   Dependencies   =3D=3D=3D=3D=3D=3D*/
 #include <linux/types.h>   /* size_t */
=20
+#include <linux/zstd_errors.h> /* list of errors */
+#if !defined(ZSTD_H_ZSTD_STATIC_LINKING_ONLY)
+#endif /* ZSTD_STATIC_LINKING_ONLY */
+
 /* =3D=3D=3D=3D=3D   ZSTDLIB_API : control library symbols visibility   =
=3D=3D=3D=3D=3D */
-#ifndef ZSTDLIB_VISIBLE
+#define ZSTDLIB_VISIBLE=20
+
+#ifndef ZSTDLIB_HIDDEN
 #  if (__GNUC__ >=3D 4) && !defined(__MINGW32__)
-#    define ZSTDLIB_VISIBLE __attribute__ ((visibility ("default")))
 #    define ZSTDLIB_HIDDEN __attribute__ ((visibility ("hidden")))
 #  else
-#    define ZSTDLIB_VISIBLE
 #    define ZSTDLIB_HIDDEN
 #  endif
 #endif
+
 #define ZSTDLIB_API ZSTDLIB_VISIBLE
=20
+/* Deprecation warnings :
+ * Should these warnings be a problem, it is generally possible to disable=
 them,
+ * typically with -Wno-deprecated-declarations for gcc or _CRT_SECURE_NO_W=
ARNINGS in Visual.
+ * Otherwise, it's also possible to define ZSTD_DISABLE_DEPRECATE_WARNINGS=
.
+ */
+#ifdef ZSTD_DISABLE_DEPRECATE_WARNINGS
+#  define ZSTD_DEPRECATED(message) /* disable deprecation warnings */
+#else
+#  if (defined(GNUC) && (GNUC > 4 || (GNUC =3D=3D 4 && GNUC_MINOR >=3D 5))=
) || defined(__clang__) || defined(__IAR_SYSTEMS_ICC__)
+#    define ZSTD_DEPRECATED(message) __attribute__((deprecated(message)))
+#  elif (__GNUC__ >=3D 3)
+#    define ZSTD_DEPRECATED(message) __attribute__((deprecated))
+#  else
+#    pragma message("WARNING: You need to implement ZSTD_DEPRECATED for th=
is compiler")
+#    define ZSTD_DEPRECATED(message)
+#  endif
+#endif /* ZSTD_DISABLE_DEPRECATE_WARNINGS */
+
 /* ***********************************************************************=
******
   Introduction
=20
@@ -62,7 +86,7 @@
 /*------   Version   ------*/
 #define ZSTD_VERSION_MAJOR    1
 #define ZSTD_VERSION_MINOR    5
-#define ZSTD_VERSION_RELEASE  2
+#define ZSTD_VERSION_RELEASE  7
 #define ZSTD_VERSION_NUMBER  (ZSTD_VERSION_MAJOR *100*100 + ZSTD_VERSION_M=
INOR *100 + ZSTD_VERSION_RELEASE)
=20
 /*! ZSTD_versionNumber() :
@@ -99,11 +123,12 @@ ZSTDLIB_API const char* ZSTD_versionString(void);
 #define ZSTD_BLOCKSIZE_MAX     (1<<ZSTD_BLOCKSIZELOG_MAX)
=20
 /* *************************************
-*  Simple API
+*  Simple Core API
 ***************************************/
 /*! ZSTD_compress() :
  *  Compresses `src` content as a single zstd compressed frame into alread=
y allocated `dst`.
- *  Hint : compression runs faster if `dstCapacity` >=3D  `ZSTD_compressBo=
und(srcSize)`.
+ *  NOTE: Providing `dstCapacity >=3D ZSTD_compressBound(srcSize)` guarant=
ees that zstd will have
+ *        enough space to successfully compress the data.
  *  @return : compressed size written into `dst` (<=3D `dstCapacity),
  *            or an error code if it fails (which can be tested using ZSTD=
_isError()). */
 ZSTDLIB_API size_t ZSTD_compress( void* dst, size_t dstCapacity,
@@ -111,47 +136,54 @@ ZSTDLIB_API size_t ZSTD_compress( void* dst, size_t d=
stCapacity,
                                   int compressionLevel);
=20
 /*! ZSTD_decompress() :
- *  `compressedSize` : must be the _exact_ size of some number of compress=
ed and/or skippable frames.
- *  `dstCapacity` is an upper bound of originalSize to regenerate.
- *  If user cannot imply a maximum upper bound, it's better to use streami=
ng mode to decompress data.
- *  @return : the number of bytes decompressed into `dst` (<=3D `dstCapaci=
ty`),
- *            or an errorCode if it fails (which can be tested using ZSTD_=
isError()). */
+ * `compressedSize` : must be the _exact_ size of some number of compresse=
d and/or skippable frames.
+ *  Multiple compressed frames can be decompressed at once with this metho=
d.
+ *  The result will be the concatenation of all decompressed frames, back =
to back.
+ * `dstCapacity` is an upper bound of originalSize to regenerate.
+ *  First frame's decompressed size can be extracted using ZSTD_getFrameCo=
ntentSize().
+ *  If maximum upper bound isn't known, prefer using streaming mode to dec=
ompress data.
+ * @return : the number of bytes decompressed into `dst` (<=3D `dstCapacit=
y`),
+ *           or an errorCode if it fails (which can be tested using ZSTD_i=
sError()). */
 ZSTDLIB_API size_t ZSTD_decompress( void* dst, size_t dstCapacity,
                               const void* src, size_t compressedSize);
=20
+/*=3D=3D=3D=3D=3D=3D  Decompression helper functions  =3D=3D=3D=3D=3D=3D*/
+
 /*! ZSTD_getFrameContentSize() : requires v1.3.0+
- *  `src` should point to the start of a ZSTD encoded frame.
- *  `srcSize` must be at least as large as the frame header.
- *            hint : any size >=3D `ZSTD_frameHeaderSize_max` is large eno=
ugh.
- *  @return : - decompressed size of `src` frame content, if known
- *            - ZSTD_CONTENTSIZE_UNKNOWN if the size cannot be determined
- *            - ZSTD_CONTENTSIZE_ERROR if an error occurred (e.g. invalid =
magic number, srcSize too small)
- *   note 1 : a 0 return value means the frame is valid but "empty".
- *   note 2 : decompressed size is an optional field, it may not be presen=
t, typically in streaming mode.
- *            When `return=3D=3DZSTD_CONTENTSIZE_UNKNOWN`, data to decompr=
ess could be any size.
- *            In which case, it's necessary to use streaming mode to decom=
press data.
- *            Optionally, application can rely on some implicit limit,
- *            as ZSTD_decompress() only needs an upper bound of decompress=
ed size.
- *            (For example, data could be necessarily cut into blocks <=3D=
 16 KB).
- *   note 3 : decompressed size is always present when compression is comp=
leted using single-pass functions,
- *            such as ZSTD_compress(), ZSTD_compressCCtx() ZSTD_compress_u=
singDict() or ZSTD_compress_usingCDict().
- *   note 4 : decompressed size can be very large (64-bits value),
- *            potentially larger than what local system can handle as a si=
ngle memory segment.
- *            In which case, it's necessary to use streaming mode to decom=
press data.
- *   note 5 : If source is untrusted, decompressed size could be wrong or =
intentionally modified.
- *            Always ensure return value fits within application's authori=
zed limits.
- *            Each application can set its own limits.
- *   note 6 : This function replaces ZSTD_getDecompressedSize() */
+ * `src` should point to the start of a ZSTD encoded frame.
+ * `srcSize` must be at least as large as the frame header.
+ *           hint : any size >=3D `ZSTD_frameHeaderSize_max` is large enou=
gh.
+ * @return : - decompressed size of `src` frame content, if known
+ *           - ZSTD_CONTENTSIZE_UNKNOWN if the size cannot be determined
+ *           - ZSTD_CONTENTSIZE_ERROR if an error occurred (e.g. invalid m=
agic number, srcSize too small)
+ *  note 1 : a 0 return value means the frame is valid but "empty".
+ *           When invoking this method on a skippable frame, it will retur=
n 0.
+ *  note 2 : decompressed size is an optional field, it may not be present=
 (typically in streaming mode).
+ *           When `return=3D=3DZSTD_CONTENTSIZE_UNKNOWN`, data to decompre=
ss could be any size.
+ *           In which case, it's necessary to use streaming mode to decomp=
ress data.
+ *           Optionally, application can rely on some implicit limit,
+ *           as ZSTD_decompress() only needs an upper bound of decompresse=
d size.
+ *           (For example, data could be necessarily cut into blocks <=3D =
16 KB).
+ *  note 3 : decompressed size is always present when compression is compl=
eted using single-pass functions,
+ *           such as ZSTD_compress(), ZSTD_compressCCtx() ZSTD_compress_us=
ingDict() or ZSTD_compress_usingCDict().
+ *  note 4 : decompressed size can be very large (64-bits value),
+ *           potentially larger than what local system can handle as a sin=
gle memory segment.
+ *           In which case, it's necessary to use streaming mode to decomp=
ress data.
+ *  note 5 : If source is untrusted, decompressed size could be wrong or i=
ntentionally modified.
+ *           Always ensure return value fits within application's authoriz=
ed limits.
+ *           Each application can set its own limits.
+ *  note 6 : This function replaces ZSTD_getDecompressedSize() */
 #define ZSTD_CONTENTSIZE_UNKNOWN (0ULL - 1)
 #define ZSTD_CONTENTSIZE_ERROR   (0ULL - 2)
 ZSTDLIB_API unsigned long long ZSTD_getFrameContentSize(const void *src, s=
ize_t srcSize);
=20
-/*! ZSTD_getDecompressedSize() :
- *  NOTE: This function is now obsolete, in favor of ZSTD_getFrameContentS=
ize().
+/*! ZSTD_getDecompressedSize() (obsolete):
+ *  This function is now obsolete, in favor of ZSTD_getFrameContentSize().
  *  Both functions work the same way, but ZSTD_getDecompressedSize() blend=
s
  *  "empty", "unknown" and "error" results to the same return value (0),
  *  while ZSTD_getFrameContentSize() gives them separate return values.
  * @return : decompressed size of `src` frame content _if known and not em=
pty_, 0 otherwise. */
+ZSTD_DEPRECATED("Replaced by ZSTD_getFrameContentSize")
 ZSTDLIB_API unsigned long long ZSTD_getDecompressedSize(const void* src, s=
ize_t srcSize);
=20
 /*! ZSTD_findFrameCompressedSize() : Requires v1.4.0+
@@ -159,42 +191,73 @@ ZSTDLIB_API unsigned long long ZSTD_getDecompressedSi=
ze(const void* src, size_t
  * `srcSize` must be >=3D first frame size
  * @return : the compressed size of the first frame starting at `src`,
  *           suitable to pass as `srcSize` to `ZSTD_decompress` or similar=
,
- *        or an error code if input is invalid */
+ *           or an error code if input is invalid
+ *  Note 1: this method is called _find*() because it's not enough to read=
 the header,
+ *          it may have to scan through the frame's content, to reach its =
end.
+ *  Note 2: this method also works with Skippable Frames. In which case,
+ *          it returns the size of the complete skippable frame,
+ *          which is always equal to its content size + 8 bytes for header=
s. */
 ZSTDLIB_API size_t ZSTD_findFrameCompressedSize(const void* src, size_t sr=
cSize);
=20
-/*=3D=3D=3D=3D=3D=3D  Helper functions  =3D=3D=3D=3D=3D=3D*/
-#define ZSTD_COMPRESSBOUND(srcSize)   ((srcSize) + ((srcSize)>>8) + (((src=
Size) < (128<<10)) ? (((128<<10) - (srcSize)) >> 11) /* margin, from 64 to =
0 */ : 0))  /* this formula ensures that bound(A) + bound(B) <=3D bound(A+B=
) as long as A and B >=3D 128 KB */
-ZSTDLIB_API size_t      ZSTD_compressBound(size_t srcSize); /*!< maximum c=
ompressed size in worst case single-pass scenario */
-ZSTDLIB_API unsigned    ZSTD_isError(size_t code);          /*!< tells if =
a `size_t` function result is an error code */
-ZSTDLIB_API const char* ZSTD_getErrorName(size_t code);     /*!< provides =
readable string from an error code */
-ZSTDLIB_API int         ZSTD_minCLevel(void);               /*!< minimum n=
egative compression level allowed, requires v1.4.0+ */
-ZSTDLIB_API int         ZSTD_maxCLevel(void);               /*!< maximum c=
ompression level available */
-ZSTDLIB_API int         ZSTD_defaultCLevel(void);           /*!< default c=
ompression level, specified by ZSTD_CLEVEL_DEFAULT, requires v1.5.0+ */
+/*=3D=3D=3D=3D=3D=3D  Compression helper functions  =3D=3D=3D=3D=3D=3D*/
+
+/*! ZSTD_compressBound() :
+ * maximum compressed size in worst case single-pass scenario.
+ * When invoking `ZSTD_compress()`, or any other one-pass compression func=
tion,
+ * it's recommended to provide @dstCapacity >=3D ZSTD_compressBound(srcSiz=
e)
+ * as it eliminates one potential failure scenario,
+ * aka not enough room in dst buffer to write the compressed frame.
+ * Note : ZSTD_compressBound() itself can fail, if @srcSize >=3D ZSTD_MAX_=
INPUT_SIZE .
+ *        In which case, ZSTD_compressBound() will return an error code
+ *        which can be tested using ZSTD_isError().
+ *
+ * ZSTD_COMPRESSBOUND() :
+ * same as ZSTD_compressBound(), but as a macro.
+ * It can be used to produce constants, which can be useful for static all=
ocation,
+ * for example to size a static array on stack.
+ * Will produce constant value 0 if srcSize is too large.
+ */
+#define ZSTD_MAX_INPUT_SIZE ((sizeof(size_t)=3D=3D8) ? 0xFF00FF00FF00FF00U=
LL : 0xFF00FF00U)
+#define ZSTD_COMPRESSBOUND(srcSize)   (((size_t)(srcSize) >=3D ZSTD_MAX_IN=
PUT_SIZE) ? 0 : (srcSize) + ((srcSize)>>8) + (((srcSize) < (128<<10)) ? (((=
128<<10) - (srcSize)) >> 11) /* margin, from 64 to 0 */ : 0))  /* this form=
ula ensures that bound(A) + bound(B) <=3D bound(A+B) as long as A and B >=
=3D 128 KB */
+ZSTDLIB_API size_t ZSTD_compressBound(size_t srcSize); /*!< maximum compre=
ssed size in worst case single-pass scenario */
+
+/*=3D=3D=3D=3D=3D=3D  Error helper functions  =3D=3D=3D=3D=3D=3D*/
+/* ZSTD_isError() :
+ * Most ZSTD_* functions returning a size_t value can be tested for error,
+ * using ZSTD_isError().
+ * @return 1 if error, 0 otherwise
+ */
+ZSTDLIB_API unsigned     ZSTD_isError(size_t result);      /*!< tells if a=
 `size_t` function result is an error code */
+ZSTDLIB_API ZSTD_ErrorCode ZSTD_getErrorCode(size_t functionResult); /* co=
nvert a result into an error code, which can be compared to error enum list=
 */
+ZSTDLIB_API const char*  ZSTD_getErrorName(size_t result); /*!< provides r=
eadable string from a function result */
+ZSTDLIB_API int          ZSTD_minCLevel(void);             /*!< minimum ne=
gative compression level allowed, requires v1.4.0+ */
+ZSTDLIB_API int          ZSTD_maxCLevel(void);             /*!< maximum co=
mpression level available */
+ZSTDLIB_API int          ZSTD_defaultCLevel(void);         /*!< default co=
mpression level, specified by ZSTD_CLEVEL_DEFAULT, requires v1.5.0+ */
=20
 /* *************************************
 *  Explicit context
 ***************************************/
 /*=3D Compression context
  *  When compressing many times,
- *  it is recommended to allocate a context just once,
- *  and re-use it for each successive compression operation.
- *  This will make workload friendlier for system's memory.
+ *  it is recommended to allocate a compression context just once,
+ *  and reuse it for each successive compression operation.
+ *  This will make the workload easier for system's memory.
  *  Note : re-using context is just a speed / resource optimization.
  *         It doesn't change the compression ratio, which remains identica=
l.
- *  Note 2 : In multi-threaded environments,
- *         use one different context per thread for parallel execution.
+ *  Note 2: For parallel execution in multi-threaded environments,
+ *         use one different context per thread .
  */
 typedef struct ZSTD_CCtx_s ZSTD_CCtx;
 ZSTDLIB_API ZSTD_CCtx* ZSTD_createCCtx(void);
-ZSTDLIB_API size_t     ZSTD_freeCCtx(ZSTD_CCtx* cctx);  /* accept NULL poi=
nter */
+ZSTDLIB_API size_t     ZSTD_freeCCtx(ZSTD_CCtx* cctx);  /* compatible with=
 NULL pointer */
=20
 /*! ZSTD_compressCCtx() :
  *  Same as ZSTD_compress(), using an explicit ZSTD_CCtx.
- *  Important : in order to behave similarly to `ZSTD_compress()`,
- *  this function compresses at requested compression level,
- *  __ignoring any other parameter__ .
+ *  Important : in order to mirror `ZSTD_compress()` behavior,
+ *  this function compresses at the requested compression level,
+ *  __ignoring any other advanced parameter__ .
  *  If any advanced parameter was set using the advanced API,
- *  they will all be reset. Only `compressionLevel` remains.
+ *  they will all be reset. Only @compressionLevel remains.
  */
 ZSTDLIB_API size_t ZSTD_compressCCtx(ZSTD_CCtx* cctx,
                                      void* dst, size_t dstCapacity,
@@ -204,7 +267,7 @@ ZSTDLIB_API size_t ZSTD_compressCCtx(ZSTD_CCtx* cctx,
 /*=3D Decompression context
  *  When decompressing many times,
  *  it is recommended to allocate a context only once,
- *  and re-use it for each successive compression operation.
+ *  and reuse it for each successive compression operation.
  *  This will make workload friendlier for system's memory.
  *  Use one context per thread for parallel execution. */
 typedef struct ZSTD_DCtx_s ZSTD_DCtx;
@@ -214,7 +277,7 @@ ZSTDLIB_API size_t     ZSTD_freeDCtx(ZSTD_DCtx* dctx); =
 /* accept NULL pointer *
 /*! ZSTD_decompressDCtx() :
  *  Same as ZSTD_decompress(),
  *  requires an allocated ZSTD_DCtx.
- *  Compatible with sticky parameters.
+ *  Compatible with sticky parameters (see below).
  */
 ZSTDLIB_API size_t ZSTD_decompressDCtx(ZSTD_DCtx* dctx,
                                        void* dst, size_t dstCapacity,
@@ -229,12 +292,12 @@ ZSTDLIB_API size_t ZSTD_decompressDCtx(ZSTD_DCtx* dct=
x,
  *   using ZSTD_CCtx_set*() functions.
  *   Pushed parameters are sticky : they are valid for next compressed fra=
me, and any subsequent frame.
  *   "sticky" parameters are applicable to `ZSTD_compress2()` and `ZSTD_co=
mpressStream*()` !
- *   __They do not apply to "simple" one-shot variants such as ZSTD_compre=
ssCCtx()__ .
+ *   __They do not apply to one-shot variants such as ZSTD_compressCCtx()_=
_ .
  *
  *   It's possible to reset all parameters to "default" using ZSTD_CCtx_re=
set().
  *
  *   This API supersedes all other "advanced" API entry points in the expe=
rimental section.
- *   In the future, we expect to remove from experimental API entry points=
 which are redundant with this API.
+ *   In the future, we expect to remove API entry points from experimental=
 which are redundant with this API.
  */
=20
 /* Compression strategies, listed from fastest to strongest */
@@ -316,6 +379,19 @@ typedef enum {
                               * The higher the value of selected strategy,=
 the more complex it is,
                               * resulting in stronger and slower compressi=
on.
                               * Special: value 0 means "use default strate=
gy". */
+
+    ZSTD_c_targetCBlockSize=3D130, /* v1.5.6+
+                                  * Attempts to fit compressed block size =
into approximately targetCBlockSize.
+                                  * Bound by ZSTD_TARGETCBLOCKSIZE_MIN and=
 ZSTD_TARGETCBLOCKSIZE_MAX.
+                                  * Note that it's not a guarantee, just a=
 convergence target (default:0).
+                                  * No target when targetCBlockSize =3D=3D=
 0.
+                                  * This is helpful in low bandwidth strea=
ming environments to improve end-to-end latency,
+                                  * when a client can make use of partial =
documents (a prominent example being Chrome).
+                                  * Note: this parameter is stable since v=
1.5.6.
+                                  * It was present as an experimental para=
meter in earlier versions,
+                                  * but it's not recommended using it with=
 earlier library versions
+                                  * due to massive performance regressions=
.
+                                  */
     /* LDM mode parameters */
     ZSTD_c_enableLongDistanceMatching=3D160, /* Enable long distance match=
ing.
                                      * This parameter is designed to impro=
ve compression ratio
@@ -395,15 +471,18 @@ typedef enum {
      * ZSTD_c_forceMaxWindow
      * ZSTD_c_forceAttachDict
      * ZSTD_c_literalCompressionMode
-     * ZSTD_c_targetCBlockSize
      * ZSTD_c_srcSizeHint
      * ZSTD_c_enableDedicatedDictSearch
      * ZSTD_c_stableInBuffer
      * ZSTD_c_stableOutBuffer
      * ZSTD_c_blockDelimiters
      * ZSTD_c_validateSequences
-     * ZSTD_c_useBlockSplitter
+     * ZSTD_c_blockSplitterLevel
+     * ZSTD_c_splitAfterSequences
      * ZSTD_c_useRowMatchFinder
+     * ZSTD_c_prefetchCDictTables
+     * ZSTD_c_enableSeqProducerFallback
+     * ZSTD_c_maxBlockSize
      * Because they are not stable, it's necessary to define ZSTD_STATIC_L=
INKING_ONLY to access them.
      * note : never ever use experimentalParam? names directly;
      *        also, the enums values themselves are unstable and can still=
 change.
@@ -413,7 +492,7 @@ typedef enum {
      ZSTD_c_experimentalParam3=3D1000,
      ZSTD_c_experimentalParam4=3D1001,
      ZSTD_c_experimentalParam5=3D1002,
-     ZSTD_c_experimentalParam6=3D1003,
+     /* was ZSTD_c_experimentalParam6=3D1003; is now ZSTD_c_targetCBlockSi=
ze */
      ZSTD_c_experimentalParam7=3D1004,
      ZSTD_c_experimentalParam8=3D1005,
      ZSTD_c_experimentalParam9=3D1006,
@@ -422,7 +501,12 @@ typedef enum {
      ZSTD_c_experimentalParam12=3D1009,
      ZSTD_c_experimentalParam13=3D1010,
      ZSTD_c_experimentalParam14=3D1011,
-     ZSTD_c_experimentalParam15=3D1012
+     ZSTD_c_experimentalParam15=3D1012,
+     ZSTD_c_experimentalParam16=3D1013,
+     ZSTD_c_experimentalParam17=3D1014,
+     ZSTD_c_experimentalParam18=3D1015,
+     ZSTD_c_experimentalParam19=3D1016,
+     ZSTD_c_experimentalParam20=3D1017
 } ZSTD_cParameter;
=20
 typedef struct {
@@ -485,7 +569,7 @@ typedef enum {
  *                  They will be used to compress next frame.
  *                  Resetting session never fails.
  *  - The parameters : changes all parameters back to "default".
- *                  This removes any reference to any dictionary too.
+ *                  This also removes any reference to any dictionary or e=
xternal sequence producer.
  *                  Parameters can only be changed between 2 sessions (i.e=
. no compression is currently ongoing)
  *                  otherwise the reset fails, and function returns an err=
or value (which can be tested using ZSTD_isError())
  *  - Both : similar to resetting the session, followed by resetting param=
eters.
@@ -494,11 +578,13 @@ ZSTDLIB_API size_t ZSTD_CCtx_reset(ZSTD_CCtx* cctx, Z=
STD_ResetDirective reset);
=20
 /*! ZSTD_compress2() :
  *  Behave the same as ZSTD_compressCCtx(), but compression parameters are=
 set using the advanced API.
+ *  (note that this entry point doesn't even expose a compression level pa=
rameter).
  *  ZSTD_compress2() always starts a new frame.
  *  Should cctx hold data from a previously unfinished frame, everything a=
bout it is forgotten.
  *  - Compression parameters are pushed into CCtx before starting compress=
ion, using ZSTD_CCtx_set*()
  *  - The function is always blocking, returns when compression is complet=
ed.
- *  Hint : compression runs faster if `dstCapacity` >=3D  `ZSTD_compressBo=
und(srcSize)`.
+ *  NOTE: Providing `dstCapacity >=3D ZSTD_compressBound(srcSize)` guarant=
ees that zstd will have
+ *        enough space to successfully compress the data, though it is pos=
sible it fails for other reasons.
  * @return : compressed size written into `dst` (<=3D `dstCapacity),
  *           or an error code if it fails (which can be tested using ZSTD_=
isError()).
  */
@@ -534,13 +620,17 @@ typedef enum {
      * ZSTD_d_stableOutBuffer
      * ZSTD_d_forceIgnoreChecksum
      * ZSTD_d_refMultipleDDicts
+     * ZSTD_d_disableHuffmanAssembly
+     * ZSTD_d_maxBlockSize
      * Because they are not stable, it's necessary to define ZSTD_STATIC_L=
INKING_ONLY to access them.
      * note : never ever use experimentalParam? names directly
      */
      ZSTD_d_experimentalParam1=3D1000,
      ZSTD_d_experimentalParam2=3D1001,
      ZSTD_d_experimentalParam3=3D1002,
-     ZSTD_d_experimentalParam4=3D1003
+     ZSTD_d_experimentalParam4=3D1003,
+     ZSTD_d_experimentalParam5=3D1004,
+     ZSTD_d_experimentalParam6=3D1005
=20
 } ZSTD_dParameter;
=20
@@ -592,14 +682,14 @@ typedef struct ZSTD_outBuffer_s {
 *  A ZSTD_CStream object is required to track streaming operation.
 *  Use ZSTD_createCStream() and ZSTD_freeCStream() to create/release resou=
rces.
 *  ZSTD_CStream objects can be reused multiple times on consecutive compre=
ssion operations.
-*  It is recommended to re-use ZSTD_CStream since it will play nicer with =
system's memory, by re-using already allocated memory.
+*  It is recommended to reuse ZSTD_CStream since it will play nicer with s=
ystem's memory, by re-using already allocated memory.
 *
 *  For parallel execution, use one separate ZSTD_CStream per thread.
 *
 *  note : since v1.3.0, ZSTD_CStream and ZSTD_CCtx are the same thing.
 *
 *  Parameters are sticky : when starting a new compression on the same con=
text,
-*  it will re-use the same sticky parameters as previous compression sessi=
on.
+*  it will reuse the same sticky parameters as previous compression sessio=
n.
 *  When in doubt, it's recommended to fully initialize the context before =
usage.
 *  Use ZSTD_CCtx_reset() to reset the context and ZSTD_CCtx_setParameter()=
,
 *  ZSTD_CCtx_setPledgedSrcSize(), or ZSTD_CCtx_loadDictionary() and friend=
s to
@@ -688,6 +778,11 @@ typedef enum {
  *            only ZSTD_e_end or ZSTD_e_flush operations are allowed.
  *            Before starting a new compression job, or changing compressi=
on parameters,
  *            it is required to fully flush internal buffers.
+ *  - note: if an operation ends with an error, it may leave @cctx in an u=
ndefined state.
+ *          Therefore, it's UB to invoke ZSTD_compressStream2() of ZSTD_co=
mpressStream() on such a state.
+ *          In order to be re-employed after an error, a state must be res=
et,
+ *          which can be done explicitly (ZSTD_CCtx_reset()),
+ *          or is sometimes implied by methods starting a new compression =
job (ZSTD_initCStream(), ZSTD_compressCCtx())
  */
 ZSTDLIB_API size_t ZSTD_compressStream2( ZSTD_CCtx* cctx,
                                          ZSTD_outBuffer* output,
@@ -714,8 +809,6 @@ ZSTDLIB_API size_t ZSTD_CStreamOutSize(void);   /*< rec=
ommended size for output
  * This following is a legacy streaming API, available since v1.0+ .
  * It can be replaced by ZSTD_CCtx_reset() and ZSTD_compressStream2().
  * It is redundant, but remains fully supported.
- * Streaming in combination with advanced parameters and dictionary compre=
ssion
- * can only be used through the new API.
  *************************************************************************=
*****/
=20
 /*!
@@ -724,6 +817,9 @@ ZSTDLIB_API size_t ZSTD_CStreamOutSize(void);   /*< rec=
ommended size for output
  *     ZSTD_CCtx_reset(zcs, ZSTD_reset_session_only);
  *     ZSTD_CCtx_refCDict(zcs, NULL); // clear the dictionary (if any)
  *     ZSTD_CCtx_setParameter(zcs, ZSTD_c_compressionLevel, compressionLev=
el);
+ *
+ * Note that ZSTD_initCStream() clears any previously set dictionary. Use =
the new API
+ * to compress with a dictionary.
  */
 ZSTDLIB_API size_t ZSTD_initCStream(ZSTD_CStream* zcs, int compressionLeve=
l);
 /*!
@@ -743,7 +839,7 @@ ZSTDLIB_API size_t ZSTD_endStream(ZSTD_CStream* zcs, ZS=
TD_outBuffer* output);
 *
 *  A ZSTD_DStream object is required to track streaming operations.
 *  Use ZSTD_createDStream() and ZSTD_freeDStream() to create/release resou=
rces.
-*  ZSTD_DStream objects can be re-used multiple times.
+*  ZSTD_DStream objects can be re-employed multiple times.
 *
 *  Use ZSTD_initDStream() to start a new decompression operation.
 * @return : recommended first input size
@@ -753,16 +849,21 @@ ZSTDLIB_API size_t ZSTD_endStream(ZSTD_CStream* zcs, =
ZSTD_outBuffer* output);
 *  The function will update both `pos` fields.
 *  If `input.pos < input.size`, some input has not been consumed.
 *  It's up to the caller to present again remaining data.
+*
 *  The function tries to flush all data decoded immediately, respecting ou=
tput buffer size.
 *  If `output.pos < output.size`, decoder has flushed everything it could.
-*  But if `output.pos =3D=3D output.size`, there might be some data left w=
ithin internal buffers.,
+*
+*  However, when `output.pos =3D=3D output.size`, it's more difficult to k=
now.
+*  If @return > 0, the frame is not complete, meaning
+*  either there is still some data left to flush within internal buffers,
+*  or there is more input to read to complete the frame (or both).
 *  In which case, call ZSTD_decompressStream() again to flush whatever rem=
ains in the buffer.
 *  Note : with no additional input provided, amount of data flushed is nec=
essarily <=3D ZSTD_BLOCKSIZE_MAX.
 * @return : 0 when a frame is completely decoded and fully flushed,
 *        or an error code, which can be tested using ZSTD_isError(),
 *        or any other value > 0, which means there is still some decoding =
or flushing to do to complete current frame :
 *                                the return value is a suggested next inpu=
t size (just a hint for better latency)
-*                                that will never request more than the rem=
aining frame size.
+*                                that will never request more than the rem=
aining content of the compressed frame.
 * ************************************************************************=
*******/
=20
 typedef ZSTD_DCtx ZSTD_DStream;  /*< DCtx and DStream are now effectively =
same object (>=3D v1.3.0) */
@@ -773,13 +874,38 @@ ZSTDLIB_API size_t ZSTD_freeDStream(ZSTD_DStream* zds=
);  /* accept NULL pointer
=20
 /*=3D=3D=3D=3D=3D Streaming decompression functions =3D=3D=3D=3D=3D*/
=20
-/* This function is redundant with the advanced API and equivalent to:
+/*! ZSTD_initDStream() :
+ * Initialize/reset DStream state for new decompression operation.
+ * Call before new decompression operation using same DStream.
  *
+ * Note : This function is redundant with the advanced API and equivalent =
to:
  *     ZSTD_DCtx_reset(zds, ZSTD_reset_session_only);
  *     ZSTD_DCtx_refDDict(zds, NULL);
  */
 ZSTDLIB_API size_t ZSTD_initDStream(ZSTD_DStream* zds);
=20
+/*! ZSTD_decompressStream() :
+ * Streaming decompression function.
+ * Call repetitively to consume full input updating it as necessary.
+ * Function will update both input and output `pos` fields exposing curren=
t state via these fields:
+ * - `input.pos < input.size`, some input remaining and caller should prov=
ide remaining input
+ *   on the next call.
+ * - `output.pos < output.size`, decoder flushed internal output buffer.
+ * - `output.pos =3D=3D output.size`, unflushed data potentially present i=
n the internal buffers,
+ *   check ZSTD_decompressStream() @return value,
+ *   if > 0, invoke it again to flush remaining data to output.
+ * Note : with no additional input, amount of data flushed <=3D ZSTD_BLOCK=
SIZE_MAX.
+ *
+ * @return : 0 when a frame is completely decoded and fully flushed,
+ *           or an error code, which can be tested using ZSTD_isError(),
+ *           or any other value > 0, which means there is some decoding or=
 flushing to do to complete current frame.
+ *
+ * Note: when an operation returns with an error code, the @zds state may =
be left in undefined state.
+ *       It's UB to invoke `ZSTD_decompressStream()` on such a state.
+ *       In order to re-use such a state, it must be first reset,
+ *       which can be done explicitly (`ZSTD_DCtx_reset()`),
+ *       or is implied for operations starting some new decompression job =
(`ZSTD_initDStream`, `ZSTD_decompressDCtx()`, `ZSTD_decompress_usingDict()`=
)
+ */
 ZSTDLIB_API size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD_outBuffer=
* output, ZSTD_inBuffer* input);
=20
 ZSTDLIB_API size_t ZSTD_DStreamInSize(void);    /*!< recommended size for =
input buffer */
@@ -894,7 +1020,7 @@ ZSTDLIB_API unsigned ZSTD_getDictID_fromDDict(const ZS=
TD_DDict* ddict);
  *  If @return =3D=3D 0, the dictID could not be decoded.
  *  This could for one of the following reasons :
  *  - The frame does not require a dictionary to be decoded (most common c=
ase).
- *  - The frame was built with dictID intentionally removed. Whatever dict=
ionary is necessary is a hidden information.
+ *  - The frame was built with dictID intentionally removed. Whatever dict=
ionary is necessary is a hidden piece of information.
  *    Note : this use case also happens when using a non-conformant dictio=
nary.
  *  - `srcSize` is too small, and as a result, the frame header could not =
be decoded (only possible if `srcSize < ZSTD_FRAMEHEADERSIZE_MAX`).
  *  - This is not a Zstandard frame.
@@ -905,9 +1031,11 @@ ZSTDLIB_API unsigned ZSTD_getDictID_fromFrame(const v=
oid* src, size_t srcSize);
  * Advanced dictionary and prefix API (Requires v1.4.0+)
  *
  * This API allows dictionaries to be used with ZSTD_compress2(),
- * ZSTD_compressStream2(), and ZSTD_decompressDCtx(). Dictionaries are sti=
cky, and
- * only reset with the context is reset with ZSTD_reset_parameters or
- * ZSTD_reset_session_and_parameters. Prefixes are single-use.
+ * ZSTD_compressStream2(), and ZSTD_decompressDCtx().
+ * Dictionaries are sticky, they remain valid when same context is reused,
+ * they only reset when the context is reset
+ * with ZSTD_reset_parameters or ZSTD_reset_session_and_parameters.
+ * In contrast, Prefixes are single-use.
  *************************************************************************=
*****/
=20
 /*! ZSTD_CCtx_loadDictionary() : Requires v1.4.0+
@@ -916,8 +1044,9 @@ ZSTDLIB_API unsigned ZSTD_getDictID_fromFrame(const vo=
id* src, size_t srcSize);
  * @result : 0, or an error code (which can be tested with ZSTD_isError())=
.
  *  Special: Loading a NULL (or 0-size) dictionary invalidates previous di=
ctionary,
  *           meaning "return to no-dictionary mode".
- *  Note 1 : Dictionary is sticky, it will be used for all future compress=
ed frames.
- *           To return to "no-dictionary" situation, load a NULL dictionar=
y (or reset parameters).
+ *  Note 1 : Dictionary is sticky, it will be used for all future compress=
ed frames,
+ *           until parameters are reset, a new dictionary is loaded, or th=
e dictionary
+ *           is explicitly invalidated by loading a NULL dictionary.
  *  Note 2 : Loading a dictionary involves building tables.
  *           It's also a CPU consuming operation, with non-negligible impa=
ct on latency.
  *           Tables are dependent on compression parameters, and for this =
reason,
@@ -926,11 +1055,15 @@ ZSTDLIB_API unsigned ZSTD_getDictID_fromFrame(const =
void* src, size_t srcSize);
  *           Use experimental ZSTD_CCtx_loadDictionary_byReference() to re=
ference content instead.
  *           In such a case, dictionary buffer must outlive its users.
  *  Note 4 : Use ZSTD_CCtx_loadDictionary_advanced()
- *           to precisely select how dictionary content must be interprete=
d. */
+ *           to precisely select how dictionary content must be interprete=
d.
+ *  Note 5 : This method does not benefit from LDM (long distance mode).
+ *           If you want to employ LDM on some large dictionary content,
+ *           prefer employing ZSTD_CCtx_refPrefix() described below.
+ */
 ZSTDLIB_API size_t ZSTD_CCtx_loadDictionary(ZSTD_CCtx* cctx, const void* d=
ict, size_t dictSize);
=20
 /*! ZSTD_CCtx_refCDict() : Requires v1.4.0+
- *  Reference a prepared dictionary, to be used for all next compressed fr=
ames.
+ *  Reference a prepared dictionary, to be used for all future compressed =
frames.
  *  Note that compression parameters are enforced from within CDict,
  *  and supersede any compression parameter previously set within CCtx.
  *  The parameters ignored are labelled as "superseded-by-cdict" in the ZS=
TD_cParameter enum docs.
@@ -949,6 +1082,7 @@ ZSTDLIB_API size_t ZSTD_CCtx_refCDict(ZSTD_CCtx* cctx,=
 const ZSTD_CDict* cdict);
  *  Decompression will need same prefix to properly regenerate data.
  *  Compressing with a prefix is similar in outcome as performing a diff a=
nd compressing it,
  *  but performs much faster, especially during decompression (compression=
 speed is tunable with compression level).
+ *  This method is compatible with LDM (long distance mode).
  * @result : 0, or an error code (which can be tested with ZSTD_isError())=
.
  *  Special: Adding any prefix (including NULL) invalidates any previous p=
refix or dictionary
  *  Note 1 : Prefix buffer is referenced. It **must** outlive compression.
@@ -965,9 +1099,9 @@ ZSTDLIB_API size_t ZSTD_CCtx_refPrefix(ZSTD_CCtx* cctx=
,
                                  const void* prefix, size_t prefixSize);
=20
 /*! ZSTD_DCtx_loadDictionary() : Requires v1.4.0+
- *  Create an internal DDict from dict buffer,
- *  to be used to decompress next frames.
- *  The dictionary remains valid for all future frames, until explicitly i=
nvalidated.
+ *  Create an internal DDict from dict buffer, to be used to decompress al=
l future frames.
+ *  The dictionary remains valid for all future frames, until explicitly i=
nvalidated, or
+ *  a new dictionary is loaded.
  * @result : 0, or an error code (which can be tested with ZSTD_isError())=
.
  *  Special : Adding a NULL (or 0-size) dictionary invalidates any previou=
s dictionary,
  *            meaning "return to no-dictionary mode".
@@ -991,9 +1125,10 @@ ZSTDLIB_API size_t ZSTD_DCtx_loadDictionary(ZSTD_DCtx=
* dctx, const void* dict, s
  *  The memory for the table is allocated on the first call to refDDict, a=
nd can be
  *  freed with ZSTD_freeDCtx().
  *
+ *  If called with ZSTD_d_refMultipleDDicts disabled (the default), only o=
ne dictionary
+ *  will be managed, and referencing a dictionary effectively "discards" a=
ny previous one.
+ *
  * @result : 0, or an error code (which can be tested with ZSTD_isError())=
.
- *  Note 1 : Currently, only one dictionary can be managed.
- *           Referencing a new dictionary effectively "discards" any previ=
ous one.
  *  Special: referencing a NULL DDict means "return to no-dictionary mode"=
.
  *  Note 2 : DDict is just referenced, its lifetime must outlive its usage=
 from DCtx.
  */
@@ -1049,24 +1184,6 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDic=
t* ddict);
 #define ZSTDLIB_STATIC_API ZSTDLIB_VISIBLE
 #endif
=20
-/* Deprecation warnings :
- * Should these warnings be a problem, it is generally possible to disable=
 them,
- * typically with -Wno-deprecated-declarations for gcc or _CRT_SECURE_NO_W=
ARNINGS in Visual.
- * Otherwise, it's also possible to define ZSTD_DISABLE_DEPRECATE_WARNINGS=
.
- */
-#ifdef ZSTD_DISABLE_DEPRECATE_WARNINGS
-#  define ZSTD_DEPRECATED(message) ZSTDLIB_STATIC_API  /* disable deprecat=
ion warnings */
-#else
-#  if (defined(GNUC) && (GNUC > 4 || (GNUC =3D=3D 4 && GNUC_MINOR >=3D 5))=
) || defined(__clang__)
-#    define ZSTD_DEPRECATED(message) ZSTDLIB_STATIC_API __attribute__((dep=
recated(message)))
-#  elif (__GNUC__ >=3D 3)
-#    define ZSTD_DEPRECATED(message) ZSTDLIB_STATIC_API __attribute__((dep=
recated))
-#  else
-#    pragma message("WARNING: You need to implement ZSTD_DEPRECATED for th=
is compiler")
-#    define ZSTD_DEPRECATED(message) ZSTDLIB_STATIC_API
-#  endif
-#endif /* ZSTD_DISABLE_DEPRECATE_WARNINGS */
-
 /* ***********************************************************************=
***************
  *   experimental API (static linking only)
  *************************************************************************=
***************
@@ -1101,6 +1218,7 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDict=
* ddict);
 #define ZSTD_TARGETLENGTH_MIN     0   /* note : comparing this constant to=
 an unsigned results in a tautological test */
 #define ZSTD_STRATEGY_MIN        ZSTD_fast
 #define ZSTD_STRATEGY_MAX        ZSTD_btultra2
+#define ZSTD_BLOCKSIZE_MAX_MIN (1 << 10) /* The minimum valid max blocksiz=
e. Maximum blocksizes smaller than this make compressBound() inaccurate. */
=20
 #define ZSTD_OVERLAPLOG_MIN       0
 #define ZSTD_OVERLAPLOG_MAX       9
@@ -1122,9 +1240,10 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDic=
t* ddict);
 #define ZSTD_LDM_HASHRATELOG_MAX (ZSTD_WINDOWLOG_MAX - ZSTD_HASHLOG_MIN)
=20
 /* Advanced parameter bounds */
-#define ZSTD_TARGETCBLOCKSIZE_MIN   64
+#define ZSTD_TARGETCBLOCKSIZE_MIN   1340 /* suitable to fit into an ethern=
et / wifi / 4G transport frame */
 #define ZSTD_TARGETCBLOCKSIZE_MAX   ZSTD_BLOCKSIZE_MAX
 #define ZSTD_SRCSIZEHINT_MIN        0
+#define ZSTD_SRCSIZEHINT_MAX        INT_MAX
=20
 /* ---  Advanced types  --- */
=20
@@ -1162,7 +1281,7 @@ typedef struct {
                                *
                                * Note: This field is optional. ZSTD_genera=
teSequences() will calculate the value of
                                * 'rep', but repeat offsets do not necessar=
ily need to be calculated from an external
-                               * sequence provider's perspective. For exam=
ple, ZSTD_compressSequences() does not
+                               * sequence provider perspective. For exampl=
e, ZSTD_compressSequences() does not
                                * use this 'rep' field at all (as of now).
                                */
 } ZSTD_Sequence;
@@ -1267,17 +1386,18 @@ typedef enum {
 } ZSTD_literalCompressionMode_e;
=20
 typedef enum {
-  /* Note: This enum controls features which are conditionally beneficial.=
 Zstd typically will make a final
-   * decision on whether or not to enable the feature (ZSTD_ps_auto), but =
setting the switch to ZSTD_ps_enable
-   * or ZSTD_ps_disable allow for a force enable/disable the feature.
+  /* Note: This enum controls features which are conditionally beneficial.
+   * Zstd can take a decision on whether or not to enable the feature (ZST=
D_ps_auto),
+   * but setting the switch to ZSTD_ps_enable or ZSTD_ps_disable force ena=
ble/disable the feature.
    */
   ZSTD_ps_auto =3D 0,         /* Let the library automatically determine w=
hether the feature shall be enabled */
   ZSTD_ps_enable =3D 1,       /* Force-enable the feature */
   ZSTD_ps_disable =3D 2       /* Do not use the feature */
-} ZSTD_paramSwitch_e;
+} ZSTD_ParamSwitch_e;
+#define ZSTD_paramSwitch_e ZSTD_ParamSwitch_e  /* old name */
=20
 /* *************************************
-*  Frame size functions
+*  Frame header and size functions
 ***************************************/
=20
 /*! ZSTD_findDecompressedSize() :
@@ -1319,34 +1439,130 @@ ZSTDLIB_STATIC_API unsigned long long ZSTD_findDec=
ompressedSize(const void* src,
 ZSTDLIB_STATIC_API unsigned long long ZSTD_decompressBound(const void* src=
, size_t srcSize);
=20
 /*! ZSTD_frameHeaderSize() :
- *  srcSize must be >=3D ZSTD_FRAMEHEADERSIZE_PREFIX.
+ *  srcSize must be large enough, aka >=3D ZSTD_FRAMEHEADERSIZE_PREFIX.
  * @return : size of the Frame Header,
  *           or an error code (if srcSize is too small) */
 ZSTDLIB_STATIC_API size_t ZSTD_frameHeaderSize(const void* src, size_t src=
Size);
=20
+typedef enum { ZSTD_frame, ZSTD_skippableFrame } ZSTD_FrameType_e;
+#define ZSTD_frameType_e ZSTD_FrameType_e /* old name */
+typedef struct {
+    unsigned long long frameContentSize; /* if =3D=3D ZSTD_CONTENTSIZE_UNK=
NOWN, it means this field is not available. 0 means "empty" */
+    unsigned long long windowSize;       /* can be very large, up to <=3D =
frameContentSize */
+    unsigned blockSizeMax;
+    ZSTD_FrameType_e frameType;          /* if =3D=3D ZSTD_skippableFrame,=
 frameContentSize is the size of skippable content */
+    unsigned headerSize;
+    unsigned dictID;                     /* for ZSTD_skippableFrame, conta=
ins the skippable magic variant [0-15] */
+    unsigned checksumFlag;
+    unsigned _reserved1;
+    unsigned _reserved2;
+} ZSTD_FrameHeader;
+#define ZSTD_frameHeader ZSTD_FrameHeader /* old name */
+
+/*! ZSTD_getFrameHeader() :
+ *  decode Frame Header into `zfhPtr`, or requires larger `srcSize`.
+ * @return : 0 =3D> header is complete, `zfhPtr` is correctly filled,
+ *          >0 =3D> `srcSize` is too small, @return value is the wanted `s=
rcSize` amount, `zfhPtr` is not filled,
+ *           or an error code, which can be tested using ZSTD_isError() */
+ZSTDLIB_STATIC_API size_t ZSTD_getFrameHeader(ZSTD_FrameHeader* zfhPtr, co=
nst void* src, size_t srcSize);
+/*! ZSTD_getFrameHeader_advanced() :
+ *  same as ZSTD_getFrameHeader(),
+ *  with added capability to select a format (like ZSTD_f_zstd1_magicless)=
 */
+ZSTDLIB_STATIC_API size_t ZSTD_getFrameHeader_advanced(ZSTD_FrameHeader* z=
fhPtr, const void* src, size_t srcSize, ZSTD_format_e format);
+
+/*! ZSTD_decompressionMargin() :
+ * Zstd supports in-place decompression, where the input and output buffer=
s overlap.
+ * In this case, the output buffer must be at least (Margin + Output_Size)=
 bytes large,
+ * and the input buffer must be at the end of the output buffer.
+ *
+ *  _______________________ Output Buffer ________________________
+ * |                                                              |
+ * |                                        ____ Input Buffer ____|
+ * |                                       |                      |
+ * v                                       v                      v
+ * |---------------------------------------|-----------|----------|
+ * ^                                                   ^          ^
+ * |___________________ Output_Size ___________________|_ Margin _|
+ *
+ * NOTE: See also ZSTD_DECOMPRESSION_MARGIN().
+ * NOTE: This applies only to single-pass decompression through ZSTD_decom=
press() or
+ * ZSTD_decompressDCtx().
+ * NOTE: This function supports multi-frame input.
+ *
+ * @param src The compressed frame(s)
+ * @param srcSize The size of the compressed frame(s)
+ * @returns The decompression margin or an error that can be checked with =
ZSTD_isError().
+ */
+ZSTDLIB_STATIC_API size_t ZSTD_decompressionMargin(const void* src, size_t=
 srcSize);
+
+/*! ZSTD_DECOMPRESS_MARGIN() :
+ * Similar to ZSTD_decompressionMargin(), but instead of computing the mar=
gin from
+ * the compressed frame, compute it from the original size and the blockSi=
zeLog.
+ * See ZSTD_decompressionMargin() for details.
+ *
+ * WARNING: This macro does not support multi-frame input, the input must =
be a single
+ * zstd frame. If you need that support use the function, or implement it =
yourself.
+ *
+ * @param originalSize The original uncompressed size of the data.
+ * @param blockSize    The block size =3D=3D MIN(windowSize, ZSTD_BLOCKSIZ=
E_MAX).
+ *                     Unless you explicitly set the windowLog smaller tha=
n
+ *                     ZSTD_BLOCKSIZELOG_MAX you can just use ZSTD_BLOCKSI=
ZE_MAX.
+ */
+#define ZSTD_DECOMPRESSION_MARGIN(originalSize, blockSize) ((size_t)(     =
                                         \
+        ZSTD_FRAMEHEADERSIZE_MAX                                          =
                    /* Frame header */ + \
+        4                                                                 =
                        /* checksum */ + \
+        ((originalSize) =3D=3D 0 ? 0 : 3 * (((originalSize) + (blockSize) =
- 1) / blockSize)) /* 3 bytes per block */ + \
+        (blockSize)                                                       =
             /* One block of margin */   \
+    ))
+
 typedef enum {
-  ZSTD_sf_noBlockDelimiters =3D 0,         /* Representation of ZSTD_Seque=
nce has no block delimiters, sequences only */
-  ZSTD_sf_explicitBlockDelimiters =3D 1    /* Representation of ZSTD_Seque=
nce contains explicit block delimiters */
-} ZSTD_sequenceFormat_e;
+  ZSTD_sf_noBlockDelimiters =3D 0,         /* ZSTD_Sequence[] has no block=
 delimiters, just sequences */
+  ZSTD_sf_explicitBlockDelimiters =3D 1    /* ZSTD_Sequence[] contains exp=
licit block delimiters */
+} ZSTD_SequenceFormat_e;
+#define ZSTD_sequenceFormat_e ZSTD_SequenceFormat_e /* old name */
+
+/*! ZSTD_sequenceBound() :
+ * `srcSize` : size of the input buffer
+ *  @return : upper-bound for the number of sequences that can be generate=
d
+ *            from a buffer of srcSize bytes
+ *
+ *  note : returns number of sequences - to get bytes, multiply by sizeof(=
ZSTD_Sequence).
+ */
+ZSTDLIB_STATIC_API size_t ZSTD_sequenceBound(size_t srcSize);
=20
 /*! ZSTD_generateSequences() :
- * Generate sequences using ZSTD_compress2, given a source buffer.
+ * WARNING: This function is meant for debugging and informational purpose=
s ONLY!
+ * Its implementation is flawed, and it will be deleted in a future versio=
n.
+ * It is not guaranteed to succeed, as there are several cases where it wi=
ll give
+ * up and fail. You should NOT use this function in production code.
+ *
+ * This function is deprecated, and will be removed in a future version.
+ *
+ * Generate sequences using ZSTD_compress2(), given a source buffer.
+ *
+ * @param zc The compression context to be used for ZSTD_compress2(). Set =
any
+ *           compression parameters you need on this context.
+ * @param outSeqs The output sequences buffer of size @p outSeqsSize
+ * @param outSeqsCapacity The size of the output sequences buffer.
+ *                    ZSTD_sequenceBound(srcSize) is an upper bound on the=
 number
+ *                    of sequences that can be generated.
+ * @param src The source buffer to generate sequences from of size @p srcS=
ize.
+ * @param srcSize The size of the source buffer.
  *
  * Each block will end with a dummy sequence
  * with offset =3D=3D 0, matchLength =3D=3D 0, and litLength =3D=3D length=
 of last literals.
  * litLength may be =3D=3D 0, and if so, then the sequence of (of: 0 ml: 0=
 ll: 0)
  * simply acts as a block delimiter.
  *
- * zc can be used to insert custom compression params.
- * This function invokes ZSTD_compress2
- *
- * The output of this function can be fed into ZSTD_compressSequences() wi=
th CCtx
- * setting of ZSTD_c_blockDelimiters as ZSTD_sf_explicitBlockDelimiters
- * @return : number of sequences generated
+ * @returns The number of sequences generated, necessarily less than
+ *          ZSTD_sequenceBound(srcSize), or an error code that can be chec=
ked
+ *          with ZSTD_isError().
  */
-
-ZSTDLIB_STATIC_API size_t ZSTD_generateSequences(ZSTD_CCtx* zc, ZSTD_Seque=
nce* outSeqs,
-                                          size_t outSeqsSize, const void* =
src, size_t srcSize);
+ZSTD_DEPRECATED("For debugging only, will be replaced by ZSTD_extractSeque=
nces()")
+ZSTDLIB_STATIC_API size_t
+ZSTD_generateSequences(ZSTD_CCtx* zc,
+                       ZSTD_Sequence* outSeqs, size_t outSeqsCapacity,
+                       const void* src, size_t srcSize);
=20
 /*! ZSTD_mergeBlockDelimiters() :
  * Given an array of ZSTD_Sequence, remove all sequences that represent bl=
ock delimiters/last literals
@@ -1362,8 +1578,10 @@ ZSTDLIB_STATIC_API size_t ZSTD_generateSequences(ZST=
D_CCtx* zc, ZSTD_Sequence* o
 ZSTDLIB_STATIC_API size_t ZSTD_mergeBlockDelimiters(ZSTD_Sequence* sequenc=
es, size_t seqsSize);
=20
 /*! ZSTD_compressSequences() :
- * Compress an array of ZSTD_Sequence, generated from the original source =
buffer, into dst.
- * If a dictionary is included, then the cctx should reference the dict. (=
see: ZSTD_CCtx_refCDict(), ZSTD_CCtx_loadDictionary(), etc.)
+ * Compress an array of ZSTD_Sequence, associated with @src buffer, into d=
st.
+ * @src contains the entire input (not just the literals).
+ * If @srcSize > sum(sequence.length), the remaining bytes are considered =
all literals
+ * If a dictionary is included, then the cctx should reference the dict (s=
ee: ZSTD_CCtx_refCDict(), ZSTD_CCtx_loadDictionary(), etc.).
  * The entire source is compressed into a single frame.
  *
  * The compression behavior changes based on cctx params. In particular:
@@ -1372,11 +1590,17 @@ ZSTDLIB_STATIC_API size_t ZSTD_mergeBlockDelimiters=
(ZSTD_Sequence* sequences, si
  *    the block size derived from the cctx, and sequences may be split. Th=
is is the default setting.
  *
  *    If ZSTD_c_blockDelimiters =3D=3D ZSTD_sf_explicitBlockDelimiters, th=
e array of ZSTD_Sequence is expected to contain
- *    block delimiters (defined in ZSTD_Sequence). Behavior is undefined i=
f no block delimiters are provided.
+ *    valid block delimiters (defined in ZSTD_Sequence). Behavior is undef=
ined if no block delimiters are provided.
+ *
+ *    When ZSTD_c_blockDelimiters =3D=3D ZSTD_sf_explicitBlockDelimiters, =
it's possible to decide generating repcodes
+ *    using the advanced parameter ZSTD_c_repcodeResolution. Repcodes will=
 improve compression ratio, though the benefit
+ *    can vary greatly depending on Sequences. On the other hand, repcode =
resolution is an expensive operation.
+ *    By default, it's disabled at low (<10) compression levels, and enabl=
ed above the threshold (>=3D10).
+ *    ZSTD_c_repcodeResolution makes it possible to directly manage this p=
rocessing in either direction.
  *
- *    If ZSTD_c_validateSequences =3D=3D 0, this function will blindly acc=
ept the sequences provided. Invalid sequences cause undefined
- *    behavior. If ZSTD_c_validateSequences =3D=3D 1, then if sequence is =
invalid (see doc/zstd_compression_format.md for
- *    specifics regarding offset/matchlength requirements) then the functi=
on will bail out and return an error.
+ *    If ZSTD_c_validateSequences =3D=3D 0, this function blindly accepts =
the Sequences provided. Invalid Sequences cause undefined
+ *    behavior. If ZSTD_c_validateSequences =3D=3D 1, then the function wi=
ll detect invalid Sequences (see doc/zstd_compression_format.md for
+ *    specifics regarding offset/matchlength requirements) and then bail o=
ut and return an error.
  *
  *    In addition to the two adjustable experimental params, there are oth=
er important cctx params.
  *    - ZSTD_c_minMatch MUST be set as less than or equal to the smallest =
match generated by the match finder. It has a minimum value of ZSTD_MINMATC=
H_MIN.
@@ -1384,22 +1608,49 @@ ZSTDLIB_STATIC_API size_t ZSTD_mergeBlockDelimiters=
(ZSTD_Sequence* sequences, si
  *    - ZSTD_c_windowLog affects offset validation: this function will ret=
urn an error at higher debug levels if a provided offset
  *      is larger than what the spec allows for a given window log and dic=
tionary (if present). See: doc/zstd_compression_format.md
  *
- * Note: Repcodes are, as of now, always re-calculated within this functio=
n, so ZSTD_Sequence::rep is unused.
- * Note 2: Once we integrate ability to ingest repcodes, the explicit bloc=
k delims mode must respect those repcodes exactly,
- *         and cannot emit an RLE block that disagrees with the repcode hi=
story
- * @return : final compressed size or a ZSTD error.
- */
-ZSTDLIB_STATIC_API size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, vo=
id* dst, size_t dstSize,
-                                  const ZSTD_Sequence* inSeqs, size_t inSe=
qsSize,
-                                  const void* src, size_t srcSize);
+ * Note: Repcodes are, as of now, always re-calculated within this functio=
n, ZSTD_Sequence.rep is effectively unused.
+ * Dev Note: Once ability to ingest repcodes become available, the explici=
t block delims mode must respect those repcodes exactly,
+ *         and cannot emit an RLE block that disagrees with the repcode hi=
story.
+ * @return : final compressed size, or a ZSTD error code.
+ */
+ZSTDLIB_STATIC_API size_t
+ZSTD_compressSequences(ZSTD_CCtx* cctx,
+                       void* dst, size_t dstCapacity,
+                 const ZSTD_Sequence* inSeqs, size_t inSeqsSize,
+                 const void* src, size_t srcSize);
+
+/*! ZSTD_compressSequencesAndLiterals() :
+ * This is a variant of ZSTD_compressSequences() which,
+ * instead of receiving (src,srcSize) as input parameter, receives (litera=
ls,litSize),
+ * aka all the literals, already extracted and laid out into a single cont=
inuous buffer.
+ * This can be useful if the process generating the sequences also happens=
 to generate the buffer of literals,
+ * thus skipping an extraction + caching stage.
+ * It's a speed optimization, useful when the right conditions are met,
+ * but it also features the following limitations:
+ * - Only supports explicit delimiter mode
+ * - Currently does not support Sequences validation (so input Sequences a=
re trusted)
+ * - Not compatible with frame checksum, which must be disabled
+ * - If any block is incompressible, will fail and return an error
+ * - @litSize must be =3D=3D sum of all @.litLength fields in @inSeqs. Any=
 discrepancy will generate an error.
+ * - @litBufCapacity is the size of the underlying buffer into which liter=
als are written, starting at address @literals.
+ *   @litBufCapacity must be at least 8 bytes larger than @litSize.
+ * - @decompressedSize must be correct, and correspond to the sum of all S=
equences. Any discrepancy will generate an error.
+ * @return : final compressed size, or a ZSTD error code.
+ */
+ZSTDLIB_STATIC_API size_t
+ZSTD_compressSequencesAndLiterals(ZSTD_CCtx* cctx,
+                                  void* dst, size_t dstCapacity,
+                            const ZSTD_Sequence* inSeqs, size_t nbSequence=
s,
+                            const void* literals, size_t litSize, size_t l=
itBufCapacity,
+                            size_t decompressedSize);
=20
 /*! ZSTD_writeSkippableFrame() :
  * Generates a zstd skippable frame containing data given by src, and writ=
es it to dst buffer.
  *
  * Skippable frames begin with a 4-byte magic number. There are 16 possibl=
e choices of magic number,
  * ranging from ZSTD_MAGIC_SKIPPABLE_START to ZSTD_MAGIC_SKIPPABLE_START+1=
5.
- * As such, the parameter magicVariant controls the exact skippable frame =
magic number variant used, so
- * the magic number used will be ZSTD_MAGIC_SKIPPABLE_START + magicVariant=
.
+ * As such, the parameter magicVariant controls the exact skippable frame =
magic number variant used,
+ * so the magic number used will be ZSTD_MAGIC_SKIPPABLE_START + magicVari=
ant.
  *
  * Returns an error if destination buffer is not large enough, if the sour=
ce size is not representable
  * with a 4-byte unsigned int, or if the parameter magicVariant is greater=
 than 15 (and therefore invalid).
@@ -1407,26 +1658,28 @@ ZSTDLIB_STATIC_API size_t ZSTD_compressSequences(ZS=
TD_CCtx* const cctx, void* ds
  * @return : number of bytes written or a ZSTD error.
  */
 ZSTDLIB_STATIC_API size_t ZSTD_writeSkippableFrame(void* dst, size_t dstCa=
pacity,
-                                            const void* src, size_t srcSiz=
e, unsigned magicVariant);
+                                             const void* src, size_t srcSi=
ze,
+                                                   unsigned magicVariant);
=20
 /*! ZSTD_readSkippableFrame() :
- * Retrieves a zstd skippable frame containing data given by src, and writ=
es it to dst buffer.
+ * Retrieves the content of a zstd skippable frame starting at @src, and w=
rites it to @dst buffer.
  *
- * The parameter magicVariant will receive the magicVariant that was suppl=
ied when the frame was written,
- * i.e. magicNumber - ZSTD_MAGIC_SKIPPABLE_START.  This can be NULL if the=
 caller is not interested
- * in the magicVariant.
+ * The parameter @magicVariant will receive the magicVariant that was supp=
lied when the frame was written,
+ * i.e. magicNumber - ZSTD_MAGIC_SKIPPABLE_START.
+ * This can be NULL if the caller is not interested in the magicVariant.
  *
  * Returns an error if destination buffer is not large enough, or if the f=
rame is not skippable.
  *
  * @return : number of bytes written or a ZSTD error.
  */
-ZSTDLIB_API size_t ZSTD_readSkippableFrame(void* dst, size_t dstCapacity, =
unsigned* magicVariant,
-                                            const void* src, size_t srcSiz=
e);
+ZSTDLIB_STATIC_API size_t ZSTD_readSkippableFrame(void* dst, size_t dstCap=
acity,
+                                                  unsigned* magicVariant,
+                                                  const void* src, size_t =
srcSize);
=20
 /*! ZSTD_isSkippableFrame() :
  *  Tells if the content of `buffer` starts with a valid Frame Identifier =
for a skippable frame.
  */
-ZSTDLIB_API unsigned ZSTD_isSkippableFrame(const void* buffer, size_t size=
);
+ZSTDLIB_STATIC_API unsigned ZSTD_isSkippableFrame(const void* buffer, size=
_t size);
=20
 /* *************************************
 *  Memory management
@@ -1435,48 +1688,59 @@ ZSTDLIB_API unsigned ZSTD_isSkippableFrame(const vo=
id* buffer, size_t size);
 /*! ZSTD_estimate*() :
  *  These functions make it possible to estimate memory usage
  *  of a future {D,C}Ctx, before its creation.
+ *  This is useful in combination with ZSTD_initStatic(),
+ *  which makes it possible to employ a static buffer for ZSTD_CCtx* state=
.
  *
  *  ZSTD_estimateCCtxSize() will provide a memory budget large enough
- *  for any compression level up to selected one.
- *  Note : Unlike ZSTD_estimateCStreamSize*(), this estimate
- *         does not include space for a window buffer.
- *         Therefore, the estimation is only guaranteed for single-shot co=
mpressions, not streaming.
+ *  to compress data of any size using one-shot compression ZSTD_compressC=
Ctx() or ZSTD_compress2()
+ *  associated with any compression level up to max specified one.
  *  The estimate will assume the input may be arbitrarily large,
  *  which is the worst case.
  *
+ *  Note that the size estimation is specific for one-shot compression,
+ *  it is not valid for streaming (see ZSTD_estimateCStreamSize*())
+ *  nor other potential ways of using a ZSTD_CCtx* state.
+ *
  *  When srcSize can be bound by a known and rather "small" value,
- *  this fact can be used to provide a tighter estimation
- *  because the CCtx compression context will need less memory.
- *  This tighter estimation can be provided by more advanced functions
+ *  this knowledge can be used to provide a tighter budget estimation
+ *  because the ZSTD_CCtx* state will need less memory for small inputs.
+ *  This tighter estimation can be provided by employing more advanced fun=
ctions
  *  ZSTD_estimateCCtxSize_usingCParams(), which can be used in tandem with=
 ZSTD_getCParams(),
  *  and ZSTD_estimateCCtxSize_usingCCtxParams(), which can be used in tand=
em with ZSTD_CCtxParams_setParameter().
  *  Both can be used to estimate memory using custom compression parameter=
s and arbitrary srcSize limits.
  *
- *  Note 2 : only single-threaded compression is supported.
+ *  Note : only single-threaded compression is supported.
  *  ZSTD_estimateCCtxSize_usingCCtxParams() will return an error code if Z=
STD_c_nbWorkers is >=3D 1.
  */
-ZSTDLIB_STATIC_API size_t ZSTD_estimateCCtxSize(int compressionLevel);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateCCtxSize(int maxCompressionLevel);
 ZSTDLIB_STATIC_API size_t ZSTD_estimateCCtxSize_usingCParams(ZSTD_compress=
ionParameters cParams);
 ZSTDLIB_STATIC_API size_t ZSTD_estimateCCtxSize_usingCCtxParams(const ZSTD=
_CCtx_params* params);
 ZSTDLIB_STATIC_API size_t ZSTD_estimateDCtxSize(void);
=20
 /*! ZSTD_estimateCStreamSize() :
- *  ZSTD_estimateCStreamSize() will provide a budget large enough for any =
compression level up to selected one.
- *  It will also consider src size to be arbitrarily "large", which is wor=
st case.
+ *  ZSTD_estimateCStreamSize() will provide a memory budget large enough f=
or streaming compression
+ *  using any compression level up to the max specified one.
+ *  It will also consider src size to be arbitrarily "large", which is a w=
orst case scenario.
  *  If srcSize is known to always be small, ZSTD_estimateCStreamSize_using=
CParams() can provide a tighter estimation.
  *  ZSTD_estimateCStreamSize_usingCParams() can be used in tandem with ZST=
D_getCParams() to create cParams from compressionLevel.
  *  ZSTD_estimateCStreamSize_usingCCtxParams() can be used in tandem with =
ZSTD_CCtxParams_setParameter(). Only single-threaded compression is support=
ed. This function will return an error code if ZSTD_c_nbWorkers is >=3D 1.
  *  Note : CStream size estimation is only correct for single-threaded com=
pression.
- *  ZSTD_DStream memory budget depends on window Size.
+ *  ZSTD_estimateCStreamSize_usingCCtxParams() will return an error code i=
f ZSTD_c_nbWorkers is >=3D 1.
+ *  Note 2 : ZSTD_estimateCStreamSize* functions are not compatible with t=
he Block-Level Sequence Producer API at this time.
+ *  Size estimates assume that no external sequence producer is registered=
.
+ *
+ *  ZSTD_DStream memory budget depends on frame's window Size.
  *  This information can be passed manually, using ZSTD_estimateDStreamSiz=
e,
  *  or deducted from a valid frame Header, using ZSTD_estimateDStreamSize_=
fromFrame();
+ *  Any frame requesting a window size larger than max specified one will =
be rejected.
  *  Note : if streaming is init with function ZSTD_init?Stream_usingDict()=
,
  *         an internal ?Dict will be created, which additional size is not=
 estimated here.
- *         In this case, get total size by adding ZSTD_estimate?DictSize *=
/
-ZSTDLIB_STATIC_API size_t ZSTD_estimateCStreamSize(int compressionLevel);
+ *         In this case, get total size by adding ZSTD_estimate?DictSize
+ */
+ZSTDLIB_STATIC_API size_t ZSTD_estimateCStreamSize(int maxCompressionLevel=
);
 ZSTDLIB_STATIC_API size_t ZSTD_estimateCStreamSize_usingCParams(ZSTD_compr=
essionParameters cParams);
 ZSTDLIB_STATIC_API size_t ZSTD_estimateCStreamSize_usingCCtxParams(const Z=
STD_CCtx_params* params);
-ZSTDLIB_STATIC_API size_t ZSTD_estimateDStreamSize(size_t windowSize);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateDStreamSize(size_t maxWindowSize);
 ZSTDLIB_STATIC_API size_t ZSTD_estimateDStreamSize_fromFrame(const void* s=
rc, size_t srcSize);
=20
 /*! ZSTD_estimate?DictSize() :
@@ -1538,7 +1802,15 @@ typedef void  (*ZSTD_freeFunction) (void* opaque, vo=
id* address);
 typedef struct { ZSTD_allocFunction customAlloc; ZSTD_freeFunction customF=
ree; void* opaque; } ZSTD_customMem;
 static
 __attribute__((__unused__))
+
+#if defined(__clang__) && __clang_major__ >=3D 5
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wzero-as-null-pointer-constant"
+#endif
 ZSTD_customMem const ZSTD_defaultCMem =3D { NULL, NULL, NULL };  /*< this =
constant defers to stdlib's functions */
+#if defined(__clang__) && __clang_major__ >=3D 5
+#pragma clang diagnostic pop
+#endif
=20
 ZSTDLIB_STATIC_API ZSTD_CCtx*    ZSTD_createCCtx_advanced(ZSTD_customMem c=
ustomMem);
 ZSTDLIB_STATIC_API ZSTD_CStream* ZSTD_createCStream_advanced(ZSTD_customMe=
m customMem);
@@ -1617,22 +1889,45 @@ ZSTDLIB_STATIC_API size_t ZSTD_checkCParams(ZSTD_co=
mpressionParameters params);
  *  This function never fails (wide contract) */
 ZSTDLIB_STATIC_API ZSTD_compressionParameters ZSTD_adjustCParams(ZSTD_comp=
ressionParameters cPar, unsigned long long srcSize, size_t dictSize);
=20
+/*! ZSTD_CCtx_setCParams() :
+ *  Set all parameters provided within @p cparams into the working @p cctx=
.
+ *  Note : if modifying parameters during compression (MT mode only),
+ *         note that changes to the .windowLog parameter will be ignored.
+ * @return 0 on success, or an error code (can be checked with ZSTD_isErro=
r()).
+ *         On failure, no parameters are updated.
+ */
+ZSTDLIB_STATIC_API size_t ZSTD_CCtx_setCParams(ZSTD_CCtx* cctx, ZSTD_compr=
essionParameters cparams);
+
+/*! ZSTD_CCtx_setFParams() :
+ *  Set all parameters provided within @p fparams into the working @p cctx=
.
+ * @return 0 on success, or an error code (can be checked with ZSTD_isErro=
r()).
+ */
+ZSTDLIB_STATIC_API size_t ZSTD_CCtx_setFParams(ZSTD_CCtx* cctx, ZSTD_frame=
Parameters fparams);
+
+/*! ZSTD_CCtx_setParams() :
+ *  Set all parameters provided within @p params into the working @p cctx.
+ * @return 0 on success, or an error code (can be checked with ZSTD_isErro=
r()).
+ */
+ZSTDLIB_STATIC_API size_t ZSTD_CCtx_setParams(ZSTD_CCtx* cctx, ZSTD_parame=
ters params);
+
 /*! ZSTD_compress_advanced() :
  *  Note : this function is now DEPRECATED.
  *         It can be replaced by ZSTD_compress2(), in combination with ZST=
D_CCtx_setParameter() and other parameter setters.
  *  This prototype will generate compilation warnings. */
 ZSTD_DEPRECATED("use ZSTD_compress2")
+ZSTDLIB_STATIC_API
 size_t ZSTD_compress_advanced(ZSTD_CCtx* cctx,
-                                          void* dst, size_t dstCapacity,
-                                    const void* src, size_t srcSize,
-                                    const void* dict,size_t dictSize,
-                                          ZSTD_parameters params);
+                              void* dst, size_t dstCapacity,
+                        const void* src, size_t srcSize,
+                        const void* dict,size_t dictSize,
+                              ZSTD_parameters params);
=20
 /*! ZSTD_compress_usingCDict_advanced() :
  *  Note : this function is now DEPRECATED.
  *         It can be replaced by ZSTD_compress2(), in combination with ZST=
D_CCtx_loadDictionary() and other parameter setters.
  *  This prototype will generate compilation warnings. */
 ZSTD_DEPRECATED("use ZSTD_compress2 with ZSTD_CCtx_loadDictionary")
+ZSTDLIB_STATIC_API
 size_t ZSTD_compress_usingCDict_advanced(ZSTD_CCtx* cctx,
                                               void* dst, size_t dstCapacit=
y,
                                         const void* src, size_t srcSize,
@@ -1692,7 +1987,7 @@ ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refPrefix_advance=
d(ZSTD_CCtx* cctx, const vo
  * See the comments on that enum for an explanation of the feature. */
 #define ZSTD_c_forceAttachDict ZSTD_c_experimentalParam4
=20
-/* Controlled with ZSTD_paramSwitch_e enum.
+/* Controlled with ZSTD_ParamSwitch_e enum.
  * Default is ZSTD_ps_auto.
  * Set to ZSTD_ps_disable to never compress literals.
  * Set to ZSTD_ps_enable to always compress literals. (Note: uncompressed =
literals
@@ -1704,11 +1999,6 @@ ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refPrefix_advanc=
ed(ZSTD_CCtx* cctx, const vo
  */
 #define ZSTD_c_literalCompressionMode ZSTD_c_experimentalParam5
=20
-/* Tries to fit compressed block size to be around targetCBlockSize.
- * No target when targetCBlockSize =3D=3D 0.
- * There is no guarantee on compressed block size (default:0) */
-#define ZSTD_c_targetCBlockSize ZSTD_c_experimentalParam6
-
 /* User's best guess of source size.
  * Hint is not valid when srcSizeHint =3D=3D 0.
  * There is no guarantee that hint is close to actual source size,
@@ -1775,13 +2065,16 @@ ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refPrefix_advan=
ced(ZSTD_CCtx* cctx, const vo
  * Experimental parameter.
  * Default is 0 =3D=3D disabled. Set to 1 to enable.
  *
- * Tells the compressor that the ZSTD_inBuffer will ALWAYS be the same
- * between calls, except for the modifications that zstd makes to pos (the
- * caller must not modify pos). This is checked by the compressor, and
- * compression will fail if it ever changes. This means the only flush
- * mode that makes sense is ZSTD_e_end, so zstd will error if ZSTD_e_end
- * is not used. The data in the ZSTD_inBuffer in the range [src, src + pos=
)
- * MUST not be modified during compression or you will get data corruption=
.
+ * Tells the compressor that input data presented with ZSTD_inBuffer
+ * will ALWAYS be the same between calls.
+ * Technically, the @src pointer must never be changed,
+ * and the @pos field can only be updated by zstd.
+ * However, it's possible to increase the @size field,
+ * allowing scenarios where more data can be appended after compressions s=
tarts.
+ * These conditions are checked by the compressor,
+ * and compression will fail if they are not respected.
+ * Also, data in the ZSTD_inBuffer within the range [src, src + pos)
+ * MUST not be modified during compression or it will result in data corru=
ption.
  *
  * When this flag is enabled zstd won't allocate an input window buffer,
  * because the user guarantees it can reference the ZSTD_inBuffer until
@@ -1789,18 +2082,15 @@ ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refPrefix_advan=
ced(ZSTD_CCtx* cctx, const vo
  * large enough to fit a block (see ZSTD_c_stableOutBuffer). This will als=
o
  * avoid the memcpy() from the input buffer to the input window buffer.
  *
- * NOTE: ZSTD_compressStream2() will error if ZSTD_e_end is not used.
- * That means this flag cannot be used with ZSTD_compressStream().
- *
  * NOTE: So long as the ZSTD_inBuffer always points to valid memory, using
  * this flag is ALWAYS memory safe, and will never access out-of-bounds
- * memory. However, compression WILL fail if you violate the preconditions=
.
+ * memory. However, compression WILL fail if conditions are not respected.
  *
- * WARNING: The data in the ZSTD_inBuffer in the range [dst, dst + pos) MU=
ST
- * not be modified during compression or you will get data corruption. Thi=
s
- * is because zstd needs to reference data in the ZSTD_inBuffer to find
+ * WARNING: The data in the ZSTD_inBuffer in the range [src, src + pos) MU=
ST
+ * not be modified during compression or it will result in data corruption=
.
+ * This is because zstd needs to reference data in the ZSTD_inBuffer to fi=
nd
  * matches. Normally zstd maintains its own window buffer for this purpose=
,
- * but passing this flag tells zstd to use the user provided buffer.
+ * but passing this flag tells zstd to rely on user provided buffer instea=
d.
  */
 #define ZSTD_c_stableInBuffer ZSTD_c_experimentalParam9
=20
@@ -1838,22 +2128,46 @@ ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refPrefix_advan=
ced(ZSTD_CCtx* cctx, const vo
 /* ZSTD_c_validateSequences
  * Default is 0 =3D=3D disabled. Set to 1 to enable sequence validation.
  *
- * For use with sequence compression API: ZSTD_compressSequences().
- * Designates whether or not we validate sequences provided to ZSTD_compre=
ssSequences()
+ * For use with sequence compression API: ZSTD_compressSequences*().
+ * Designates whether or not provided sequences are validated within ZSTD_=
compressSequences*()
  * during function execution.
  *
- * Without validation, providing a sequence that does not conform to the z=
std spec will cause
- * undefined behavior, and may produce a corrupted block.
+ * When Sequence validation is disabled (default), Sequences are compresse=
d as-is,
+ * so they must correct, otherwise it would result in a corruption error.
  *
- * With validation enabled, a if sequence is invalid (see doc/zstd_compres=
sion_format.md for
+ * Sequence validation adds some protection, by ensuring that all values r=
espect boundary conditions.
+ * If a Sequence is detected invalid (see doc/zstd_compression_format.md f=
or
  * specifics regarding offset/matchlength requirements) then the function =
will bail out and
  * return an error.
- *
  */
 #define ZSTD_c_validateSequences ZSTD_c_experimentalParam12
=20
-/* ZSTD_c_useBlockSplitter
- * Controlled with ZSTD_paramSwitch_e enum.
+/* ZSTD_c_blockSplitterLevel
+ * note: this parameter only influences the first splitter stage,
+ *       which is active before producing the sequences.
+ *       ZSTD_c_splitAfterSequences controls the next splitter stage,
+ *       which is active after sequence production.
+ *       Note that both can be combined.
+ * Allowed values are between 0 and ZSTD_BLOCKSPLITTER_LEVEL_MAX included.
+ * 0 means "auto", which will select a value depending on current ZSTD_c_s=
trategy.
+ * 1 means no splitting.
+ * Then, values from 2 to 6 are sorted in increasing cpu load order.
+ *
+ * Note that currently the first block is never split,
+ * to ensure expansion guarantees in presence of incompressible data.
+ */
+#define ZSTD_BLOCKSPLITTER_LEVEL_MAX 6
+#define ZSTD_c_blockSplitterLevel ZSTD_c_experimentalParam20
+
+/* ZSTD_c_splitAfterSequences
+ * This is a stronger splitter algorithm,
+ * based on actual sequences previously produced by the selected parser.
+ * It's also slower, and as a consequence, mostly used for high compressio=
n levels.
+ * While the post-splitter does overlap with the pre-splitter,
+ * both can nonetheless be combined,
+ * notably with ZSTD_c_blockSplitterLevel at ZSTD_BLOCKSPLITTER_LEVEL_MAX,
+ * resulting in higher compression ratio than just one of them.
+ *
  * Default is ZSTD_ps_auto.
  * Set to ZSTD_ps_disable to never use block splitter.
  * Set to ZSTD_ps_enable to always use block splitter.
@@ -1861,10 +2175,10 @@ ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refPrefix_advan=
ced(ZSTD_CCtx* cctx, const vo
  * By default, in ZSTD_ps_auto, the library will decide at runtime whether=
 to use
  * block splitting based on the compression parameters.
  */
-#define ZSTD_c_useBlockSplitter ZSTD_c_experimentalParam13
+#define ZSTD_c_splitAfterSequences ZSTD_c_experimentalParam13
=20
 /* ZSTD_c_useRowMatchFinder
- * Controlled with ZSTD_paramSwitch_e enum.
+ * Controlled with ZSTD_ParamSwitch_e enum.
  * Default is ZSTD_ps_auto.
  * Set to ZSTD_ps_disable to never use row-based matchfinder.
  * Set to ZSTD_ps_enable to force usage of row-based matchfinder.
@@ -1895,6 +2209,79 @@ ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refPrefix_advanc=
ed(ZSTD_CCtx* cctx, const vo
  */
 #define ZSTD_c_deterministicRefPrefix ZSTD_c_experimentalParam15
=20
+/* ZSTD_c_prefetchCDictTables
+ * Controlled with ZSTD_ParamSwitch_e enum. Default is ZSTD_ps_auto.
+ *
+ * In some situations, zstd uses CDict tables in-place rather than copying=
 them
+ * into the working context. (See docs on ZSTD_dictAttachPref_e above for =
details).
+ * In such situations, compression speed is seriously impacted when CDict =
tables are
+ * "cold" (outside CPU cache). This parameter instructs zstd to prefetch C=
Dict tables
+ * when they are used in-place.
+ *
+ * For sufficiently small inputs, the cost of the prefetch will outweigh t=
he benefit.
+ * For sufficiently large inputs, zstd will by default memcpy() CDict tabl=
es
+ * into the working context, so there is no need to prefetch. This paramet=
er is
+ * targeted at a middle range of input sizes, where a prefetch is cheap en=
ough to be
+ * useful but memcpy() is too expensive. The exact range of input sizes wh=
ere this
+ * makes sense is best determined by careful experimentation.
+ *
+ * Note: for this parameter, ZSTD_ps_auto is currently equivalent to ZSTD_=
ps_disable,
+ * but in the future zstd may conditionally enable this feature via an aut=
o-detection
+ * heuristic for cold CDicts.
+ * Use ZSTD_ps_disable to opt out of prefetching under any circumstances.
+ */
+#define ZSTD_c_prefetchCDictTables ZSTD_c_experimentalParam16
+
+/* ZSTD_c_enableSeqProducerFallback
+ * Allowed values are 0 (disable) and 1 (enable). The default setting is 0=
.
+ *
+ * Controls whether zstd will fall back to an internal sequence producer i=
f an
+ * external sequence producer is registered and returns an error code. Thi=
s fallback
+ * is block-by-block: the internal sequence producer will only be called f=
or blocks
+ * where the external sequence producer returns an error code. Fallback pa=
rsing will
+ * follow any other cParam settings, such as compression level, the same a=
s in a
+ * normal (fully-internal) compression operation.
+ *
+ * The user is strongly encouraged to read the full Block-Level Sequence P=
roducer API
+ * documentation (below) before setting this parameter. */
+#define ZSTD_c_enableSeqProducerFallback ZSTD_c_experimentalParam17
+
+/* ZSTD_c_maxBlockSize
+ * Allowed values are between 1KB and ZSTD_BLOCKSIZE_MAX (128KB).
+ * The default is ZSTD_BLOCKSIZE_MAX, and setting to 0 will set to the def=
ault.
+ *
+ * This parameter can be used to set an upper bound on the blocksize
+ * that overrides the default ZSTD_BLOCKSIZE_MAX. It cannot be used to set=
 upper
+ * bounds greater than ZSTD_BLOCKSIZE_MAX or bounds lower than 1KB (will m=
ake
+ * compressBound() inaccurate). Only currently meant to be used for testin=
g.
+ */
+#define ZSTD_c_maxBlockSize ZSTD_c_experimentalParam18
+
+/* ZSTD_c_repcodeResolution
+ * This parameter only has an effect if ZSTD_c_blockDelimiters is
+ * set to ZSTD_sf_explicitBlockDelimiters (may change in the future).
+ *
+ * This parameter affects how zstd parses external sequences,
+ * provided via the ZSTD_compressSequences*() API
+ * or from an external block-level sequence producer.
+ *
+ * If set to ZSTD_ps_enable, the library will check for repeated offsets w=
ithin
+ * external sequences, even if those repcodes are not explicitly indicated=
 in
+ * the "rep" field. Note that this is the only way to exploit repcode matc=
hes
+ * while using compressSequences*() or an external sequence producer, sinc=
e zstd
+ * currently ignores the "rep" field of external sequences.
+ *
+ * If set to ZSTD_ps_disable, the library will not exploit repeated offset=
s in
+ * external sequences, regardless of whether the "rep" field has been set.=
 This
+ * reduces sequence compression overhead by about 25% while sacrificing so=
me
+ * compression ratio.
+ *
+ * The default value is ZSTD_ps_auto, for which the library will enable/di=
sable
+ * based on compression level (currently: level<10 disables, level>=3D10 e=
nables).
+ */
+#define ZSTD_c_repcodeResolution ZSTD_c_experimentalParam19
+#define ZSTD_c_searchForExternalRepcodes ZSTD_c_experimentalParam19 /* old=
er name */
+
 /*! ZSTD_CCtx_getParameter() :
  *  Get the requested compression parameter value, selected by enum ZSTD_c=
Parameter,
  *  and store it into int* value.
@@ -2049,7 +2436,7 @@ ZSTDLIB_STATIC_API size_t ZSTD_DCtx_getParameter(ZSTD=
_DCtx* dctx, ZSTD_dParamete
  * in the range [dst, dst + pos) MUST not be modified during decompression
  * or you will get data corruption.
  *
- * When this flags is enabled zstd won't allocate an output buffer, becaus=
e
+ * When this flag is enabled zstd won't allocate an output buffer, because
  * it can write directly to the ZSTD_outBuffer, but it will still allocate
  * an input buffer large enough to fit any compressed block. This will als=
o
  * avoid the memcpy() from the internal output buffer to the ZSTD_outBuffe=
r.
@@ -2102,6 +2489,33 @@ ZSTDLIB_STATIC_API size_t ZSTD_DCtx_getParameter(ZST=
D_DCtx* dctx, ZSTD_dParamete
  */
 #define ZSTD_d_refMultipleDDicts ZSTD_d_experimentalParam4
=20
+/* ZSTD_d_disableHuffmanAssembly
+ * Set to 1 to disable the Huffman assembly implementation.
+ * The default value is 0, which allows zstd to use the Huffman assembly
+ * implementation if available.
+ *
+ * This parameter can be used to disable Huffman assembly at runtime.
+ * If you want to disable it at compile time you can define the macro
+ * ZSTD_DISABLE_ASM.
+ */
+#define ZSTD_d_disableHuffmanAssembly ZSTD_d_experimentalParam5
+
+/* ZSTD_d_maxBlockSize
+ * Allowed values are between 1KB and ZSTD_BLOCKSIZE_MAX (128KB).
+ * The default is ZSTD_BLOCKSIZE_MAX, and setting to 0 will set to the def=
ault.
+ *
+ * Forces the decompressor to reject blocks whose content size is
+ * larger than the configured maxBlockSize. When maxBlockSize is
+ * larger than the windowSize, the windowSize is used instead.
+ * This saves memory on the decoder when you know all blocks are small.
+ *
+ * This option is typically used in conjunction with ZSTD_c_maxBlockSize.
+ *
+ * WARNING: This causes the decoder to reject otherwise valid frames
+ * that have block sizes larger than the configured maxBlockSize.
+ */
+#define ZSTD_d_maxBlockSize ZSTD_d_experimentalParam6
+
 /*! ZSTD_DCtx_setFormat() :
  *  This function is REDUNDANT. Prefer ZSTD_DCtx_setParameter().
  *  Instruct the decoder context about what kind of data to decode next.
@@ -2109,6 +2523,7 @@ ZSTDLIB_STATIC_API size_t ZSTD_DCtx_getParameter(ZSTD=
_DCtx* dctx, ZSTD_dParamete
  *  such ZSTD_f_zstd1_magicless for example.
  * @return : 0, or an error code (which can be tested using ZSTD_isError()=
). */
 ZSTD_DEPRECATED("use ZSTD_DCtx_setParameter() instead")
+ZSTDLIB_STATIC_API
 size_t ZSTD_DCtx_setFormat(ZSTD_DCtx* dctx, ZSTD_format_e format);
=20
 /*! ZSTD_decompressStream_simpleArgs() :
@@ -2144,6 +2559,7 @@ ZSTDLIB_STATIC_API size_t ZSTD_decompressStream_simpl=
eArgs (
  * This prototype will generate compilation warnings.
  */
 ZSTD_DEPRECATED("use ZSTD_CCtx_reset, see zstd.h for detailed instructions=
")
+ZSTDLIB_STATIC_API
 size_t ZSTD_initCStream_srcSize(ZSTD_CStream* zcs,
                          int compressionLevel,
                          unsigned long long pledgedSrcSize);
@@ -2161,17 +2577,15 @@ size_t ZSTD_initCStream_srcSize(ZSTD_CStream* zcs,
  * This prototype will generate compilation warnings.
  */
 ZSTD_DEPRECATED("use ZSTD_CCtx_reset, see zstd.h for detailed instructions=
")
+ZSTDLIB_STATIC_API
 size_t ZSTD_initCStream_usingDict(ZSTD_CStream* zcs,
                      const void* dict, size_t dictSize,
                            int compressionLevel);
=20
 /*! ZSTD_initCStream_advanced() :
- * This function is DEPRECATED, and is approximately equivalent to:
+ * This function is DEPRECATED, and is equivalent to:
  *     ZSTD_CCtx_reset(zcs, ZSTD_reset_session_only);
- *     // Pseudocode: Set each zstd parameter and leave the rest as-is.
- *     for ((param, value) : params) {
- *         ZSTD_CCtx_setParameter(zcs, param, value);
- *     }
+ *     ZSTD_CCtx_setParams(zcs, params);
  *     ZSTD_CCtx_setPledgedSrcSize(zcs, pledgedSrcSize);
  *     ZSTD_CCtx_loadDictionary(zcs, dict, dictSize);
  *
@@ -2181,6 +2595,7 @@ size_t ZSTD_initCStream_usingDict(ZSTD_CStream* zcs,
  * This prototype will generate compilation warnings.
  */
 ZSTD_DEPRECATED("use ZSTD_CCtx_reset, see zstd.h for detailed instructions=
")
+ZSTDLIB_STATIC_API
 size_t ZSTD_initCStream_advanced(ZSTD_CStream* zcs,
                     const void* dict, size_t dictSize,
                           ZSTD_parameters params,
@@ -2195,15 +2610,13 @@ size_t ZSTD_initCStream_advanced(ZSTD_CStream* zcs,
  * This prototype will generate compilation warnings.
  */
 ZSTD_DEPRECATED("use ZSTD_CCtx_reset and ZSTD_CCtx_refCDict, see zstd.h fo=
r detailed instructions")
+ZSTDLIB_STATIC_API
 size_t ZSTD_initCStream_usingCDict(ZSTD_CStream* zcs, const ZSTD_CDict* cd=
ict);
=20
 /*! ZSTD_initCStream_usingCDict_advanced() :
- *   This function is DEPRECATED, and is approximately equivalent to:
+ *   This function is DEPRECATED, and is equivalent to:
  *     ZSTD_CCtx_reset(zcs, ZSTD_reset_session_only);
- *     // Pseudocode: Set each zstd frame parameter and leave the rest as-=
is.
- *     for ((fParam, value) : fParams) {
- *         ZSTD_CCtx_setParameter(zcs, fParam, value);
- *     }
+ *     ZSTD_CCtx_setFParams(zcs, fParams);
  *     ZSTD_CCtx_setPledgedSrcSize(zcs, pledgedSrcSize);
  *     ZSTD_CCtx_refCDict(zcs, cdict);
  *
@@ -2213,6 +2626,7 @@ size_t ZSTD_initCStream_usingCDict(ZSTD_CStream* zcs,=
 const ZSTD_CDict* cdict);
  * This prototype will generate compilation warnings.
  */
 ZSTD_DEPRECATED("use ZSTD_CCtx_reset and ZSTD_CCtx_refCDict, see zstd.h fo=
r detailed instructions")
+ZSTDLIB_STATIC_API
 size_t ZSTD_initCStream_usingCDict_advanced(ZSTD_CStream* zcs,
                                const ZSTD_CDict* cdict,
                                      ZSTD_frameParameters fParams,
@@ -2227,7 +2641,7 @@ size_t ZSTD_initCStream_usingCDict_advanced(ZSTD_CStr=
eam* zcs,
  *       explicitly specified.
  *
  *  start a new frame, using same parameters from previous frame.
- *  This is typically useful to skip dictionary loading stage, since it wi=
ll re-use it in-place.
+ *  This is typically useful to skip dictionary loading stage, since it wi=
ll reuse it in-place.
  *  Note that zcs must be init at least once before using ZSTD_resetCStrea=
m().
  *  If pledgedSrcSize is not known at reset time, use macro ZSTD_CONTENTSI=
ZE_UNKNOWN.
  *  If pledgedSrcSize > 0, its value must be correct, as it will be writte=
n in header, and controlled at the end.
@@ -2237,6 +2651,7 @@ size_t ZSTD_initCStream_usingCDict_advanced(ZSTD_CStr=
eam* zcs,
  *  This prototype will generate compilation warnings.
  */
 ZSTD_DEPRECATED("use ZSTD_CCtx_reset, see zstd.h for detailed instructions=
")
+ZSTDLIB_STATIC_API
 size_t ZSTD_resetCStream(ZSTD_CStream* zcs, unsigned long long pledgedSrcS=
ize);
=20
 typedef struct {
@@ -2280,8 +2695,8 @@ ZSTDLIB_STATIC_API size_t ZSTD_toFlushNow(ZSTD_CCtx* =
cctx);
  *     ZSTD_DCtx_loadDictionary(zds, dict, dictSize);
  *
  * note: no dictionary will be used if dict =3D=3D NULL or dictSize < 8
- * Note : this prototype will be marked as deprecated and generate compila=
tion warnings on reaching v1.5.x
  */
+ZSTD_DEPRECATED("use ZSTD_DCtx_reset + ZSTD_DCtx_loadDictionary, see zstd.=
h for detailed instructions")
 ZSTDLIB_STATIC_API size_t ZSTD_initDStream_usingDict(ZSTD_DStream* zds, co=
nst void* dict, size_t dictSize);
=20
 /*!
@@ -2291,8 +2706,8 @@ ZSTDLIB_STATIC_API size_t ZSTD_initDStream_usingDict(=
ZSTD_DStream* zds, const vo
  *     ZSTD_DCtx_refDDict(zds, ddict);
  *
  * note : ddict is referenced, it must outlive decompression session
- * Note : this prototype will be marked as deprecated and generate compila=
tion warnings on reaching v1.5.x
  */
+ZSTD_DEPRECATED("use ZSTD_DCtx_reset + ZSTD_DCtx_refDDict, see zstd.h for =
detailed instructions")
 ZSTDLIB_STATIC_API size_t ZSTD_initDStream_usingDDict(ZSTD_DStream* zds, c=
onst ZSTD_DDict* ddict);
=20
 /*!
@@ -2300,17 +2715,200 @@ ZSTDLIB_STATIC_API size_t ZSTD_initDStream_usingDD=
ict(ZSTD_DStream* zds, const Z
  *
  *     ZSTD_DCtx_reset(zds, ZSTD_reset_session_only);
  *
- * re-use decompression parameters from previous init; saves dictionary lo=
ading
- * Note : this prototype will be marked as deprecated and generate compila=
tion warnings on reaching v1.5.x
+ * reuse decompression parameters from previous init; saves dictionary loa=
ding
  */
+ZSTD_DEPRECATED("use ZSTD_DCtx_reset, see zstd.h for detailed instructions=
")
 ZSTDLIB_STATIC_API size_t ZSTD_resetDStream(ZSTD_DStream* zds);
=20
+/* ********************* BLOCK-LEVEL SEQUENCE PRODUCER API ***************=
******
+ *
+ * *** OVERVIEW ***
+ * The Block-Level Sequence Producer API allows users to provide their own=
 custom
+ * sequence producer which libzstd invokes to process each block. The prod=
uced list
+ * of sequences (literals and matches) is then post-processed by libzstd t=
o produce
+ * valid compressed blocks.
+ *
+ * This block-level offload API is a more granular complement of the exist=
ing
+ * frame-level offload API compressSequences() (introduced in v1.5.1). It =
offers
+ * an easier migration story for applications already integrated with libz=
std: the
+ * user application continues to invoke the same compression functions
+ * ZSTD_compress2() or ZSTD_compressStream2() as usual, and transparently =
benefits
+ * from the specific advantages of the external sequence producer. For exa=
mple,
+ * the sequence producer could be tuned to take advantage of known charact=
eristics
+ * of the input, to offer better speed / ratio, or could leverage hardware
+ * acceleration not available within libzstd itself.
+ *
+ * See contrib/externalSequenceProducer for an example program employing t=
he
+ * Block-Level Sequence Producer API.
+ *
+ * *** USAGE ***
+ * The user is responsible for implementing a function of type
+ * ZSTD_sequenceProducer_F. For each block, zstd will pass the following
+ * arguments to the user-provided function:
+ *
+ *   - sequenceProducerState: a pointer to a user-managed state for the se=
quence
+ *     producer.
+ *
+ *   - outSeqs, outSeqsCapacity: an output buffer for the sequence produce=
r.
+ *     outSeqsCapacity is guaranteed >=3D ZSTD_sequenceBound(srcSize). The=
 memory
+ *     backing outSeqs is managed by the CCtx.
+ *
+ *   - src, srcSize: an input buffer for the sequence producer to parse.
+ *     srcSize is guaranteed to be <=3D ZSTD_BLOCKSIZE_MAX.
+ *
+ *   - dict, dictSize: a history buffer, which may be empty, which the seq=
uence
+ *     producer may reference as it parses the src buffer. Currently, zstd=
 will
+ *     always pass dictSize =3D=3D 0 into external sequence producers, but=
 this will
+ *     change in the future.
+ *
+ *   - compressionLevel: a signed integer representing the zstd compressio=
n level
+ *     set by the user for the current operation. The sequence producer ma=
y choose
+ *     to use this information to change its compression strategy and spee=
d/ratio
+ *     tradeoff. Note: the compression level does not reflect zstd paramet=
ers set
+ *     through the advanced API.
+ *
+ *   - windowSize: a size_t representing the maximum allowed offset for ex=
ternal
+ *     sequences. Note that sequence offsets are sometimes allowed to exce=
ed the
+ *     windowSize if a dictionary is present, see doc/zstd_compression_for=
mat.md
+ *     for details.
+ *
+ * The user-provided function shall return a size_t representing the numbe=
r of
+ * sequences written to outSeqs. This return value will be treated as an e=
rror
+ * code if it is greater than outSeqsCapacity. The return value must be no=
n-zero
+ * if srcSize is non-zero. The ZSTD_SEQUENCE_PRODUCER_ERROR macro is provi=
ded
+ * for convenience, but any value greater than outSeqsCapacity will be tre=
ated as
+ * an error code.
+ *
+ * If the user-provided function does not return an error code, the sequen=
ces
+ * written to outSeqs must be a valid parse of the src buffer. Data corrup=
tion may
+ * occur if the parse is not valid. A parse is defined to be valid if the
+ * following conditions hold:
+ *   - The sum of matchLengths and literalLengths must equal srcSize.
+ *   - All sequences in the parse, except for the final sequence, must hav=
e
+ *     matchLength >=3D ZSTD_MINMATCH_MIN. The final sequence must have
+ *     matchLength >=3D ZSTD_MINMATCH_MIN or matchLength =3D=3D 0.
+ *   - All offsets must respect the windowSize parameter as specified in
+ *     doc/zstd_compression_format.md.
+ *   - If the final sequence has matchLength =3D=3D 0, it must also have o=
ffset =3D=3D 0.
+ *
+ * zstd will only validate these conditions (and fail compression if they =
do not
+ * hold) if the ZSTD_c_validateSequences cParam is enabled. Note that sequ=
ence
+ * validation has a performance cost.
+ *
+ * If the user-provided function returns an error, zstd will either fall b=
ack
+ * to an internal sequence producer or fail the compression operation. The=
 user can
+ * choose between the two behaviors by setting the ZSTD_c_enableSeqProduce=
rFallback
+ * cParam. Fallback compression will follow any other cParam settings, suc=
h as
+ * compression level, the same as in a normal compression operation.
+ *
+ * The user shall instruct zstd to use a particular ZSTD_sequenceProducer_=
F
+ * function by calling
+ *         ZSTD_registerSequenceProducer(cctx,
+ *                                       sequenceProducerState,
+ *                                       sequenceProducer)
+ * This setting will persist until the next parameter reset of the CCtx.
+ *
+ * The sequenceProducerState must be initialized by the user before callin=
g
+ * ZSTD_registerSequenceProducer(). The user is responsible for destroying=
 the
+ * sequenceProducerState.
+ *
+ * *** LIMITATIONS ***
+ * This API is compatible with all zstd compression APIs which respect adv=
anced parameters.
+ * However, there are three limitations:
+ *
+ * First, the ZSTD_c_enableLongDistanceMatching cParam is not currently su=
pported.
+ * COMPRESSION WILL FAIL if it is enabled and the user tries to compress w=
ith a block-level
+ * external sequence producer.
+ *   - Note that ZSTD_c_enableLongDistanceMatching is auto-enabled by defa=
ult in some
+ *     cases (see its documentation for details). Users must explicitly se=
t
+ *     ZSTD_c_enableLongDistanceMatching to ZSTD_ps_disable in such cases =
if an external
+ *     sequence producer is registered.
+ *   - As of this writing, ZSTD_c_enableLongDistanceMatching is disabled b=
y default
+ *     whenever ZSTD_c_windowLog < 128MB, but that's subject to change. Us=
ers should
+ *     check the docs on ZSTD_c_enableLongDistanceMatching whenever the Bl=
ock-Level Sequence
+ *     Producer API is used in conjunction with advanced settings (like ZS=
TD_c_windowLog).
+ *
+ * Second, history buffers are not currently supported. Concretely, zstd w=
ill always pass
+ * dictSize =3D=3D 0 to the external sequence producer (for now). This has=
 two implications:
+ *   - Dictionaries are not currently supported. Compression will *not* fa=
il if the user
+ *     references a dictionary, but the dictionary won't have any effect.
+ *   - Stream history is not currently supported. All advanced compression=
 APIs, including
+ *     streaming APIs, work with external sequence producers, but each blo=
ck is treated as
+ *     an independent chunk without history from previous blocks.
+ *
+ * Third, multi-threading within a single compression is not currently sup=
ported. In other words,
+ * COMPRESSION WILL FAIL if ZSTD_c_nbWorkers > 0 and an external sequence =
producer is registered.
+ * Multi-threading across compressions is fine: simply create one CCtx per=
 thread.
+ *
+ * Long-term, we plan to overcome all three limitations. There is no techn=
ical blocker to
+ * overcoming them. It is purely a question of engineering effort.
+ */
+
+#define ZSTD_SEQUENCE_PRODUCER_ERROR ((size_t)(-1))
+
+typedef size_t (*ZSTD_sequenceProducer_F) (
+  void* sequenceProducerState,
+  ZSTD_Sequence* outSeqs, size_t outSeqsCapacity,
+  const void* src, size_t srcSize,
+  const void* dict, size_t dictSize,
+  int compressionLevel,
+  size_t windowSize
+);
+
+/*! ZSTD_registerSequenceProducer() :
+ * Instruct zstd to use a block-level external sequence producer function.
+ *
+ * The sequenceProducerState must be initialized by the caller, and the ca=
ller is
+ * responsible for managing its lifetime. This parameter is sticky across
+ * compressions. It will remain set until the user explicitly resets compr=
ession
+ * parameters.
+ *
+ * Sequence producer registration is considered to be an "advanced paramet=
er",
+ * part of the "advanced API". This means it will only have an effect on c=
ompression
+ * APIs which respect advanced parameters, such as compress2() and compres=
sStream2().
+ * Older compression APIs such as compressCCtx(), which predate the introd=
uction of
+ * "advanced parameters", will ignore any external sequence producer setti=
ng.
+ *
+ * The sequence producer can be "cleared" by registering a NULL function p=
ointer. This
+ * removes all limitations described above in the "LIMITATIONS" section of=
 the API docs.
+ *
+ * The user is strongly encouraged to read the full API documentation (abo=
ve) before
+ * calling this function. */
+ZSTDLIB_STATIC_API void
+ZSTD_registerSequenceProducer(
+  ZSTD_CCtx* cctx,
+  void* sequenceProducerState,
+  ZSTD_sequenceProducer_F sequenceProducer
+);
+
+/*! ZSTD_CCtxParams_registerSequenceProducer() :
+ * Same as ZSTD_registerSequenceProducer(), but operates on ZSTD_CCtx_para=
ms.
+ * This is used for accurate size estimation with ZSTD_estimateCCtxSize_us=
ingCCtxParams(),
+ * which is needed when creating a ZSTD_CCtx with ZSTD_initStaticCCtx().
+ *
+ * If you are using the external sequence producer API in a scenario where=
 ZSTD_initStaticCCtx()
+ * is required, then this function is for you. Otherwise, you probably don=
't need it.
+ *
+ * See tests/zstreamtest.c for example usage. */
+ZSTDLIB_STATIC_API void
+ZSTD_CCtxParams_registerSequenceProducer(
+  ZSTD_CCtx_params* params,
+  void* sequenceProducerState,
+  ZSTD_sequenceProducer_F sequenceProducer
+);
+
 /* *******************************************************************
-*  Buffer-less and synchronous inner streaming functions
+*  Buffer-less and synchronous inner streaming functions (DEPRECATED)
+*
+*  This API is deprecated, and will be removed in a future version.
+*  It allows streaming (de)compression with user allocated buffers.
+*  However, it is hard to use, and not as well tested as the rest of
+*  our API.
 *
-*  This is an advanced API, giving full control over buffer management, fo=
r users which need direct control over memory.
-*  But it's also a complex one, with several restrictions, documented belo=
w.
-*  Prefer normal streaming API for an easier experience.
+*  Please use the normal streaming API instead: ZSTD_compressStream2,
+*  and ZSTD_decompressStream.
+*  If there is functionality that you need, but it doesn't provide,
+*  please open an issue on our GitHub.
 ********************************************************************* */
=20
 /*
@@ -2318,11 +2916,10 @@ ZSTDLIB_STATIC_API size_t ZSTD_resetDStream(ZSTD_DS=
tream* zds);
=20
   A ZSTD_CCtx object is required to track streaming operations.
   Use ZSTD_createCCtx() / ZSTD_freeCCtx() to manage resource.
-  ZSTD_CCtx object can be re-used multiple times within successive compres=
sion operations.
+  ZSTD_CCtx object can be reused multiple times within successive compress=
ion operations.
=20
   Start by initializing a context.
   Use ZSTD_compressBegin(), or ZSTD_compressBegin_usingDict() for dictiona=
ry compression.
-  It's also possible to duplicate a reference context which has already be=
en initialized, using ZSTD_copyCCtx()
=20
   Then, consume your input using ZSTD_compressContinue().
   There are some important considerations to keep in mind when using this =
advanced function :
@@ -2340,39 +2937,49 @@ ZSTDLIB_STATIC_API size_t ZSTD_resetDStream(ZSTD_DS=
tream* zds);
   It's possible to use srcSize=3D=3D0, in which case, it will write a fina=
l empty block to end the frame.
   Without last block mark, frames are considered unfinished (hence corrupt=
ed) by compliant decoders.
=20
-  `ZSTD_CCtx` object can be re-used (ZSTD_compressBegin()) to compress aga=
in.
+  `ZSTD_CCtx` object can be reused (ZSTD_compressBegin()) to compress agai=
n.
 */
=20
 /*=3D=3D=3D=3D=3D   Buffer-less streaming compression functions  =3D=3D=3D=
=3D=3D*/
+ZSTD_DEPRECATED("The buffer-less API is deprecated in favor of the normal =
streaming API. See docs.")
 ZSTDLIB_STATIC_API size_t ZSTD_compressBegin(ZSTD_CCtx* cctx, int compress=
ionLevel);
+ZSTD_DEPRECATED("The buffer-less API is deprecated in favor of the normal =
streaming API. See docs.")
 ZSTDLIB_STATIC_API size_t ZSTD_compressBegin_usingDict(ZSTD_CCtx* cctx, co=
nst void* dict, size_t dictSize, int compressionLevel);
+ZSTD_DEPRECATED("The buffer-less API is deprecated in favor of the normal =
streaming API. See docs.")
 ZSTDLIB_STATIC_API size_t ZSTD_compressBegin_usingCDict(ZSTD_CCtx* cctx, c=
onst ZSTD_CDict* cdict); /*< note: fails if cdict=3D=3DNULL */
-ZSTDLIB_STATIC_API size_t ZSTD_copyCCtx(ZSTD_CCtx* cctx, const ZSTD_CCtx* =
preparedCCtx, unsigned long long pledgedSrcSize); /*<  note: if pledgedSrcS=
ize is not known, use ZSTD_CONTENTSIZE_UNKNOWN */
=20
+ZSTD_DEPRECATED("This function will likely be removed in a future release.=
 It is misleading and has very limited utility.")
+ZSTDLIB_STATIC_API
+size_t ZSTD_copyCCtx(ZSTD_CCtx* cctx, const ZSTD_CCtx* preparedCCtx, unsig=
ned long long pledgedSrcSize); /*<  note: if pledgedSrcSize is not known, u=
se ZSTD_CONTENTSIZE_UNKNOWN */
+
+ZSTD_DEPRECATED("The buffer-less API is deprecated in favor of the normal =
streaming API. See docs.")
 ZSTDLIB_STATIC_API size_t ZSTD_compressContinue(ZSTD_CCtx* cctx, void* dst=
, size_t dstCapacity, const void* src, size_t srcSize);
+ZSTD_DEPRECATED("The buffer-less API is deprecated in favor of the normal =
streaming API. See docs.")
 ZSTDLIB_STATIC_API size_t ZSTD_compressEnd(ZSTD_CCtx* cctx, void* dst, siz=
e_t dstCapacity, const void* src, size_t srcSize);
=20
 /* The ZSTD_compressBegin_advanced() and ZSTD_compressBegin_usingCDict_adv=
anced() are now DEPRECATED and will generate a compiler warning */
 ZSTD_DEPRECATED("use advanced API to access custom parameters")
+ZSTDLIB_STATIC_API
 size_t ZSTD_compressBegin_advanced(ZSTD_CCtx* cctx, const void* dict, size=
_t dictSize, ZSTD_parameters params, unsigned long long pledgedSrcSize); /*=
< pledgedSrcSize : If srcSize is not known at init time, use ZSTD_CONTENTSI=
ZE_UNKNOWN */
 ZSTD_DEPRECATED("use advanced API to access custom parameters")
+ZSTDLIB_STATIC_API
 size_t ZSTD_compressBegin_usingCDict_advanced(ZSTD_CCtx* const cctx, const=
 ZSTD_CDict* const cdict, ZSTD_frameParameters const fParams, unsigned long=
 long const pledgedSrcSize);   /* compression parameters are already set wi=
thin cdict. pledgedSrcSize must be correct. If srcSize is not known, use ma=
cro ZSTD_CONTENTSIZE_UNKNOWN */
 /*
   Buffer-less streaming decompression (synchronous mode)
=20
   A ZSTD_DCtx object is required to track streaming operations.
   Use ZSTD_createDCtx() / ZSTD_freeDCtx() to manage it.
-  A ZSTD_DCtx object can be re-used multiple times.
+  A ZSTD_DCtx object can be reused multiple times.
=20
   First typical operation is to retrieve frame parameters, using ZSTD_getF=
rameHeader().
   Frame header is extracted from the beginning of compressed frame, so pro=
viding only the frame's beginning is enough.
   Data fragment must be large enough to ensure successful decoding.
  `ZSTD_frameHeaderSize_max` bytes is guaranteed to always be large enough.
-  @result : 0 : successful decoding, the `ZSTD_frameHeader` structure is c=
orrectly filled.
-           >0 : `srcSize` is too small, please provide at least @result by=
tes on next attempt.
+  result  : 0 : successful decoding, the `ZSTD_frameHeader` structure is c=
orrectly filled.
+           >0 : `srcSize` is too small, please provide at least result byt=
es on next attempt.
            errorCode, which can be tested using ZSTD_isError().
=20
-  It fills a ZSTD_frameHeader structure with important information to corr=
ectly decode the frame,
+  It fills a ZSTD_FrameHeader structure with important information to corr=
ectly decode the frame,
   such as the dictionary ID, content size, or maximum back-reference dista=
nce (`windowSize`).
   Note that these values could be wrong, either because of data corruption=
, or because a 3rd party deliberately spoofs false information.
   As a consequence, check that values remain within valid application rang=
e.
@@ -2388,7 +2995,7 @@ size_t ZSTD_compressBegin_usingCDict_advanced(ZSTD_CC=
tx* const cctx, const ZSTD_
=20
   The most memory efficient way is to use a round buffer of sufficient siz=
e.
   Sufficient size is determined by invoking ZSTD_decodingBufferSize_min(),
-  which can @return an error code if required value is too large for curre=
nt system (in 32-bits mode).
+  which can return an error code if required value is too large for curren=
t system (in 32-bits mode).
   In a round buffer methodology, ZSTD_decompressContinue() decompresses ea=
ch block next to previous one,
   up to the moment there is not enough room left in the buffer to guarante=
e decoding another full block,
   which maximum size is provided in `ZSTD_frameHeader` structure, field `b=
lockSizeMax`.
@@ -2408,7 +3015,7 @@ size_t ZSTD_compressBegin_usingCDict_advanced(ZSTD_CC=
tx* const cctx, const ZSTD_
   ZSTD_nextSrcSizeToDecompress() tells how many bytes to provide as 'srcSi=
ze' to ZSTD_decompressContinue().
   ZSTD_decompressContinue() requires this _exact_ amount of bytes, or it w=
ill fail.
=20
- @result of ZSTD_decompressContinue() is the number of bytes regenerated w=
ithin 'dst' (necessarily <=3D dstCapacity).
+  result of ZSTD_decompressContinue() is the number of bytes regenerated w=
ithin 'dst' (necessarily <=3D dstCapacity).
   It can be zero : it just means ZSTD_decompressContinue() has decoded som=
e metadata item.
   It can also be an error code, which can be tested with ZSTD_isError().
=20
@@ -2431,27 +3038,7 @@ size_t ZSTD_compressBegin_usingCDict_advanced(ZSTD_C=
Ctx* const cctx, const ZSTD_
 */
=20
 /*=3D=3D=3D=3D=3D   Buffer-less streaming decompression functions  =3D=3D=
=3D=3D=3D*/
-typedef enum { ZSTD_frame, ZSTD_skippableFrame } ZSTD_frameType_e;
-typedef struct {
-    unsigned long long frameContentSize; /* if =3D=3D ZSTD_CONTENTSIZE_UNK=
NOWN, it means this field is not available. 0 means "empty" */
-    unsigned long long windowSize;       /* can be very large, up to <=3D =
frameContentSize */
-    unsigned blockSizeMax;
-    ZSTD_frameType_e frameType;          /* if =3D=3D ZSTD_skippableFrame,=
 frameContentSize is the size of skippable content */
-    unsigned headerSize;
-    unsigned dictID;
-    unsigned checksumFlag;
-} ZSTD_frameHeader;
=20
-/*! ZSTD_getFrameHeader() :
- *  decode Frame Header, or requires larger `srcSize`.
- * @return : 0, `zfhPtr` is correctly filled,
- *          >0, `srcSize` is too small, value is wanted `srcSize` amount,
- *           or an error code, which can be tested using ZSTD_isError() */
-ZSTDLIB_STATIC_API size_t ZSTD_getFrameHeader(ZSTD_frameHeader* zfhPtr, co=
nst void* src, size_t srcSize);   /*< doesn't consume input */
-/*! ZSTD_getFrameHeader_advanced() :
- *  same as ZSTD_getFrameHeader(),
- *  with added capability to select a format (like ZSTD_f_zstd1_magicless)=
 */
-ZSTDLIB_STATIC_API size_t ZSTD_getFrameHeader_advanced(ZSTD_frameHeader* z=
fhPtr, const void* src, size_t srcSize, ZSTD_format_e format);
 ZSTDLIB_STATIC_API size_t ZSTD_decodingBufferSize_min(unsigned long long w=
indowSize, unsigned long long frameContentSize);  /*< when frame content si=
ze is not known, pass in frameContentSize =3D=3D ZSTD_CONTENTSIZE_UNKNOWN *=
/
=20
 ZSTDLIB_STATIC_API size_t ZSTD_decompressBegin(ZSTD_DCtx* dctx);
@@ -2462,15 +3049,28 @@ ZSTDLIB_STATIC_API size_t ZSTD_nextSrcSizeToDecompr=
ess(ZSTD_DCtx* dctx);
 ZSTDLIB_STATIC_API size_t ZSTD_decompressContinue(ZSTD_DCtx* dctx, void* d=
st, size_t dstCapacity, const void* src, size_t srcSize);
=20
 /* misc */
+ZSTD_DEPRECATED("This function will likely be removed in the next minor re=
lease. It is misleading and has very limited utility.")
 ZSTDLIB_STATIC_API void   ZSTD_copyDCtx(ZSTD_DCtx* dctx, const ZSTD_DCtx* =
preparedDCtx);
 typedef enum { ZSTDnit_frameHeader, ZSTDnit_blockHeader, ZSTDnit_block, ZS=
TDnit_lastBlock, ZSTDnit_checksum, ZSTDnit_skippableFrame } ZSTD_nextInputT=
ype_e;
 ZSTDLIB_STATIC_API ZSTD_nextInputType_e ZSTD_nextInputType(ZSTD_DCtx* dctx=
);
=20
-/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D */
-/*       Block level API       */
-/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D */
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+/*       Block level API (DEPRECATED)       */
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
=20
 /*!
+
+    This API is deprecated in favor of the regular compression API.
+    You can get the frame header down to 2 bytes by setting:
+      - ZSTD_c_format =3D ZSTD_f_zstd1_magicless
+      - ZSTD_c_contentSizeFlag =3D 0
+      - ZSTD_c_checksumFlag =3D 0
+      - ZSTD_c_dictIDFlag =3D 0
+
+    This API is not as well tested as our normal API, so we recommend not =
using it.
+    We will be removing it in a future version. If the normal API doesn't =
provide
+    the functionality you need, please open a GitHub issue.
+
     Block functions produce and decode raw zstd blocks, without frame meta=
data.
     Frame metadata cost is typically ~12 bytes, which can be non-negligibl=
e for very small blocks (< 100 bytes).
     But users will have to take in charge needed metadata to regenerate da=
ta, such as compressed and content sizes.
@@ -2481,7 +3081,6 @@ ZSTDLIB_STATIC_API ZSTD_nextInputType_e ZSTD_nextInpu=
tType(ZSTD_DCtx* dctx);
     - It is necessary to init context before starting
       + compression : any ZSTD_compressBegin*() variant, including with di=
ctionary
       + decompression : any ZSTD_decompressBegin*() variant, including wit=
h dictionary
-      + copyCCtx() and copyDCtx() can be used too
     - Block size is limited, it must be <=3D ZSTD_getBlockSize() <=3D ZSTD=
_BLOCKSIZE_MAX =3D=3D 128 KB
       + If input is larger than a block size, it's necessary to split inpu=
t data into multiple blocks
       + For inputs larger than a single block, consider using regular ZSTD=
_compress() instead.
@@ -2498,10 +3097,13 @@ ZSTDLIB_STATIC_API ZSTD_nextInputType_e ZSTD_nextIn=
putType(ZSTD_DCtx* dctx);
 */
=20
 /*=3D=3D=3D=3D=3D   Raw zstd block functions  =3D=3D=3D=3D=3D*/
+ZSTD_DEPRECATED("The block API is deprecated in favor of the normal compre=
ssion API. See docs.")
 ZSTDLIB_STATIC_API size_t ZSTD_getBlockSize   (const ZSTD_CCtx* cctx);
+ZSTD_DEPRECATED("The block API is deprecated in favor of the normal compre=
ssion API. See docs.")
 ZSTDLIB_STATIC_API size_t ZSTD_compressBlock  (ZSTD_CCtx* cctx, void* dst,=
 size_t dstCapacity, const void* src, size_t srcSize);
+ZSTD_DEPRECATED("The block API is deprecated in favor of the normal compre=
ssion API. See docs.")
 ZSTDLIB_STATIC_API size_t ZSTD_decompressBlock(ZSTD_DCtx* dctx, void* dst,=
 size_t dstCapacity, const void* src, size_t srcSize);
+ZSTD_DEPRECATED("The block API is deprecated in favor of the normal compre=
ssion API. See docs.")
 ZSTDLIB_STATIC_API size_t ZSTD_insertBlock    (ZSTD_DCtx* dctx, const void=
* blockStart, size_t blockSize);  /*< insert uncompressed block into `dctx`=
 history. Useful for multi-blocks decompression. */
=20
 #endif   /* ZSTD_H_ZSTD_STATIC_LINKING_ONLY */
-
diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index 2003e1842588..c9a7dfe405b4 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -17,6 +17,7 @@ ccflags-y +=3D -DZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
 ccflags-y +=3D -DZSTD_NO_INLINE
 ccflags-y +=3D -DZSTD_STRIP_ERROR_STRINGS
 ccflags-y +=3D -DDYNAMIC_BMI2=3D0
+ccflags-y +=3D -DHUF_DISABLE_FAST_DECODE
 endif
=20
 zstd_decompress-y :=3D \
diff --git a/lib/zstd/common/allocations.h b/lib/zstd/common/allocations.h
new file mode 100644
index 000000000000..16c3d08e8d1a
--- /dev/null
+++ b/lib/zstd/common/allocations.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
+/*
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
+ * All rights reserved.
+ *
+ * This source code is licensed under both the BSD-style license (found in=
 the
+ * LICENSE file in the root directory of this source tree) and the GPLv2 (=
found
+ * in the COPYING file in the root directory of this source tree).
+ * You may select, at your option, one of the above-listed licenses.
+ */
+
+/* This file provides custom allocation primitives
+ */
+
+#define ZSTD_DEPS_NEED_MALLOC
+#include "zstd_deps.h"   /* ZSTD_malloc, ZSTD_calloc, ZSTD_free, ZSTD_mems=
et */
+
+#include "compiler.h" /* MEM_STATIC */
+#define ZSTD_STATIC_LINKING_ONLY
+#include <linux/zstd.h> /* ZSTD_customMem */
+
+#ifndef ZSTD_ALLOCATIONS_H
+#define ZSTD_ALLOCATIONS_H
+
+/* custom memory allocation functions */
+
+MEM_STATIC void* ZSTD_customMalloc(size_t size, ZSTD_customMem customMem)
+{
+    if (customMem.customAlloc)
+        return customMem.customAlloc(customMem.opaque, size);
+    return ZSTD_malloc(size);
+}
+
+MEM_STATIC void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
+{
+    if (customMem.customAlloc) {
+        /* calloc implemented as malloc+memset;
+         * not as efficient as calloc, but next best guess for custom mall=
oc */
+        void* const ptr =3D customMem.customAlloc(customMem.opaque, size);
+        ZSTD_memset(ptr, 0, size);
+        return ptr;
+    }
+    return ZSTD_calloc(1, size);
+}
+
+MEM_STATIC void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
+{
+    if (ptr!=3DNULL) {
+        if (customMem.customFree)
+            customMem.customFree(customMem.opaque, ptr);
+        else
+            ZSTD_free(ptr);
+    }
+}
+
+#endif /* ZSTD_ALLOCATIONS_H */
diff --git a/lib/zstd/common/bits.h b/lib/zstd/common/bits.h
new file mode 100644
index 000000000000..c5faaa3d7b08
--- /dev/null
+++ b/lib/zstd/common/bits.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
+/*
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
+ * All rights reserved.
+ *
+ * This source code is licensed under both the BSD-style license (found in=
 the
+ * LICENSE file in the root directory of this source tree) and the GPLv2 (=
found
+ * in the COPYING file in the root directory of this source tree).
+ * You may select, at your option, one of the above-listed licenses.
+ */
+
+#ifndef ZSTD_BITS_H
+#define ZSTD_BITS_H
+
+#include "mem.h"
+
+MEM_STATIC unsigned ZSTD_countTrailingZeros32_fallback(U32 val)
+{
+    assert(val !=3D 0);
+    {
+        static const U32 DeBruijnBytePos[32] =3D {0, 1, 28, 2, 29, 14, 24,=
 3,
+                                                30, 22, 20, 15, 25, 17, 4,=
 8,
+                                                31, 27, 13, 23, 21, 19, 16=
, 7,
+                                                26, 12, 18, 6, 11, 5, 10, =
9};
+        return DeBruijnBytePos[((U32) ((val & -(S32) val) * 0x077CB531U)) =
>> 27];
+    }
+}
+
+MEM_STATIC unsigned ZSTD_countTrailingZeros32(U32 val)
+{
+    assert(val !=3D 0);
+#if (__GNUC__ >=3D 4)
+    return (unsigned)__builtin_ctz(val);
+#else
+    return ZSTD_countTrailingZeros32_fallback(val);
+#endif
+}
+
+MEM_STATIC unsigned ZSTD_countLeadingZeros32_fallback(U32 val)
+{
+    assert(val !=3D 0);
+    {
+        static const U32 DeBruijnClz[32] =3D {0, 9, 1, 10, 13, 21, 2, 29,
+                                            11, 14, 16, 18, 22, 25, 3, 30,
+                                            8, 12, 20, 28, 15, 17, 24, 7,
+                                            19, 27, 23, 6, 26, 5, 4, 31};
+        val |=3D val >> 1;
+        val |=3D val >> 2;
+        val |=3D val >> 4;
+        val |=3D val >> 8;
+        val |=3D val >> 16;
+        return 31 - DeBruijnClz[(val * 0x07C4ACDDU) >> 27];
+    }
+}
+
+MEM_STATIC unsigned ZSTD_countLeadingZeros32(U32 val)
+{
+    assert(val !=3D 0);
+#if (__GNUC__ >=3D 4)
+    return (unsigned)__builtin_clz(val);
+#else
+    return ZSTD_countLeadingZeros32_fallback(val);
+#endif
+}
+
+MEM_STATIC unsigned ZSTD_countTrailingZeros64(U64 val)
+{
+    assert(val !=3D 0);
+#if (__GNUC__ >=3D 4) && defined(__LP64__)
+    return (unsigned)__builtin_ctzll(val);
+#else
+    {
+        U32 mostSignificantWord =3D (U32)(val >> 32);
+        U32 leastSignificantWord =3D (U32)val;
+        if (leastSignificantWord =3D=3D 0) {
+            return 32 + ZSTD_countTrailingZeros32(mostSignificantWord);
+        } else {
+            return ZSTD_countTrailingZeros32(leastSignificantWord);
+        }
+    }
+#endif
+}
+
+MEM_STATIC unsigned ZSTD_countLeadingZeros64(U64 val)
+{
+    assert(val !=3D 0);
+#if (__GNUC__ >=3D 4)
+    return (unsigned)(__builtin_clzll(val));
+#else
+    {
+        U32 mostSignificantWord =3D (U32)(val >> 32);
+        U32 leastSignificantWord =3D (U32)val;
+        if (mostSignificantWord =3D=3D 0) {
+            return 32 + ZSTD_countLeadingZeros32(leastSignificantWord);
+        } else {
+            return ZSTD_countLeadingZeros32(mostSignificantWord);
+        }
+    }
+#endif
+}
+
+MEM_STATIC unsigned ZSTD_NbCommonBytes(size_t val)
+{
+    if (MEM_isLittleEndian()) {
+        if (MEM_64bits()) {
+            return ZSTD_countTrailingZeros64((U64)val) >> 3;
+        } else {
+            return ZSTD_countTrailingZeros32((U32)val) >> 3;
+        }
+    } else {  /* Big Endian CPU */
+        if (MEM_64bits()) {
+            return ZSTD_countLeadingZeros64((U64)val) >> 3;
+        } else {
+            return ZSTD_countLeadingZeros32((U32)val) >> 3;
+        }
+    }
+}
+
+MEM_STATIC unsigned ZSTD_highbit32(U32 val)   /* compress, dictBuilder, de=
codeCorpus */
+{
+    assert(val !=3D 0);
+    return 31 - ZSTD_countLeadingZeros32(val);
+}
+
+/* ZSTD_rotateRight_*():
+ * Rotates a bitfield to the right by "count" bits.
+ * https://en.wikipedia.org/w/index.php?title=3DCircular_shift&oldid=3D991=
635599#Implementing_circular_shifts
+ */
+MEM_STATIC
+U64 ZSTD_rotateRight_U64(U64 const value, U32 count) {
+    assert(count < 64);
+    count &=3D 0x3F; /* for fickle pattern recognition */
+    return (value >> count) | (U64)(value << ((0U - count) & 0x3F));
+}
+
+MEM_STATIC
+U32 ZSTD_rotateRight_U32(U32 const value, U32 count) {
+    assert(count < 32);
+    count &=3D 0x1F; /* for fickle pattern recognition */
+    return (value >> count) | (U32)(value << ((0U - count) & 0x1F));
+}
+
+MEM_STATIC
+U16 ZSTD_rotateRight_U16(U16 const value, U32 count) {
+    assert(count < 16);
+    count &=3D 0x0F; /* for fickle pattern recognition */
+    return (value >> count) | (U16)(value << ((0U - count) & 0x0F));
+}
+
+#endif /* ZSTD_BITS_H */
diff --git a/lib/zstd/common/bitstream.h b/lib/zstd/common/bitstream.h
index ee36de1cd1a1..8778a1658bd4 100644
--- a/lib/zstd/common/bitstream.h
+++ b/lib/zstd/common/bitstream.h
@@ -1,7 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /* ******************************************************************
  * bitstream
  * Part of FSE library
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  *
  * You can contact the author at :
  * - Source repository : https://github.com/Cyan4973/FiniteStateEntropy
@@ -27,6 +28,7 @@
 #include "compiler.h"       /* UNLIKELY() */
 #include "debug.h"          /* assert(), DEBUGLOG(), RAWLOG() */
 #include "error_private.h"  /* error codes and messages */
+#include "bits.h"           /* ZSTD_highbit32 */
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 *  Target specific
@@ -39,12 +41,13 @@
 /*-******************************************
 *  bitStream encoding API (write forward)
 ********************************************/
+typedef size_t BitContainerType;
 /* bitStream can mix input from multiple sources.
  * A critical property of these streams is that they encode and decode in =
**reverse** direction.
  * So the first bit sequence you add will be the last to be read, like a L=
IFO stack.
  */
 typedef struct {
-    size_t bitContainer;
+    BitContainerType bitContainer;
     unsigned bitPos;
     char*  startPtr;
     char*  ptr;
@@ -52,7 +55,7 @@ typedef struct {
 } BIT_CStream_t;
=20
 MEM_STATIC size_t BIT_initCStream(BIT_CStream_t* bitC, void* dstBuffer, si=
ze_t dstCapacity);
-MEM_STATIC void   BIT_addBits(BIT_CStream_t* bitC, size_t value, unsigned =
nbBits);
+MEM_STATIC void   BIT_addBits(BIT_CStream_t* bitC, BitContainerType value,=
 unsigned nbBits);
 MEM_STATIC void   BIT_flushBits(BIT_CStream_t* bitC);
 MEM_STATIC size_t BIT_closeCStream(BIT_CStream_t* bitC);
=20
@@ -61,7 +64,7 @@ MEM_STATIC size_t BIT_closeCStream(BIT_CStream_t* bitC);
 *  `dstCapacity` must be >=3D sizeof(bitD->bitContainer), otherwise @retur=
n will be an error code.
 *
 *  bits are first added to a local register.
-*  Local register is size_t, hence 64-bits on 64-bits systems, or 32-bits =
on 32-bits systems.
+*  Local register is BitContainerType, 64-bits on 64-bits systems, or 32-b=
its on 32-bits systems.
 *  Writing data into memory is an explicit operation, performed by the flu=
shBits function.
 *  Hence keep track how many bits are potentially stored into local regist=
er to avoid register overflow.
 *  After a flushBits, a maximum of 7 bits might still be stored into local=
 register.
@@ -77,27 +80,27 @@ MEM_STATIC size_t BIT_closeCStream(BIT_CStream_t* bitC)=
;
 *  bitStream decoding API (read backward)
 **********************************************/
 typedef struct {
-    size_t   bitContainer;
+    BitContainerType bitContainer;
     unsigned bitsConsumed;
     const char* ptr;
     const char* start;
     const char* limitPtr;
 } BIT_DStream_t;
=20
-typedef enum { BIT_DStream_unfinished =3D 0,
-               BIT_DStream_endOfBuffer =3D 1,
-               BIT_DStream_completed =3D 2,
-               BIT_DStream_overflow =3D 3 } BIT_DStream_status;  /* result=
 of BIT_reloadDStream() */
-               /* 1,2,4,8 would be better for bitmap combinations, but slo=
ws down performance a bit ... :( */
+typedef enum { BIT_DStream_unfinished =3D 0,  /* fully refilled */
+               BIT_DStream_endOfBuffer =3D 1, /* still some bits left in b=
itstream */
+               BIT_DStream_completed =3D 2,   /* bitstream entirely consum=
ed, bit-exact */
+               BIT_DStream_overflow =3D 3     /* user requested more bits =
than present in bitstream */
+    } BIT_DStream_status;  /* result of BIT_reloadDStream() */
=20
 MEM_STATIC size_t   BIT_initDStream(BIT_DStream_t* bitD, const void* srcBu=
ffer, size_t srcSize);
-MEM_STATIC size_t   BIT_readBits(BIT_DStream_t* bitD, unsigned nbBits);
+MEM_STATIC BitContainerType BIT_readBits(BIT_DStream_t* bitD, unsigned nbB=
its);
 MEM_STATIC BIT_DStream_status BIT_reloadDStream(BIT_DStream_t* bitD);
 MEM_STATIC unsigned BIT_endOfDStream(const BIT_DStream_t* bitD);
=20
 /* Start by invoking BIT_initDStream().
 *  A chunk of the bitStream is then stored into a local register.
-*  Local register size is 64-bits on 64-bits systems, 32-bits on 32-bits s=
ystems (size_t).
+*  Local register size is 64-bits on 64-bits systems, 32-bits on 32-bits s=
ystems (BitContainerType).
 *  You can then retrieve bitFields stored into the local register, **in re=
verse order**.
 *  Local register is explicitly reloaded from memory by the BIT_reloadDStr=
eam() method.
 *  A reload guarantee a minimum of ((8*sizeof(bitD->bitContainer))-7) bits=
 when its result is BIT_DStream_unfinished.
@@ -108,7 +111,7 @@ MEM_STATIC unsigned BIT_endOfDStream(const BIT_DStream_=
t* bitD);
 /*-****************************************
 *  unsafe API
 ******************************************/
-MEM_STATIC void BIT_addBitsFast(BIT_CStream_t* bitC, size_t value, unsigne=
d nbBits);
+MEM_STATIC void BIT_addBitsFast(BIT_CStream_t* bitC, BitContainerType valu=
e, unsigned nbBits);
 /* faster, but works only if value is "clean", meaning all high bits above=
 nbBits are 0 */
=20
 MEM_STATIC void BIT_flushBitsFast(BIT_CStream_t* bitC);
@@ -117,31 +120,6 @@ MEM_STATIC void BIT_flushBitsFast(BIT_CStream_t* bitC)=
;
 MEM_STATIC size_t BIT_readBitsFast(BIT_DStream_t* bitD, unsigned nbBits);
 /* faster, but works only if nbBits >=3D 1 */
=20
-/*-**************************************************************
-*  Internal functions
-****************************************************************/
-MEM_STATIC unsigned BIT_highbit32 (U32 val)
-{
-    assert(val !=3D 0);
-    {
-#   if (__GNUC__ >=3D 3)   /* Use GCC Intrinsic */
-        return __builtin_clz (val) ^ 31;
-#   else   /* Software version */
-        static const unsigned DeBruijnClz[32] =3D { 0,  9,  1, 10, 13, 21,=
  2, 29,
-                                                 11, 14, 16, 18, 22, 25,  =
3, 30,
-                                                  8, 12, 20, 28, 15, 17, 2=
4,  7,
-                                                 19, 27, 23,  6, 26,  5,  =
4, 31 };
-        U32 v =3D val;
-        v |=3D v >> 1;
-        v |=3D v >> 2;
-        v |=3D v >> 4;
-        v |=3D v >> 8;
-        v |=3D v >> 16;
-        return DeBruijnClz[ (U32) (v * 0x07C4ACDDU) >> 27];
-#   endif
-    }
-}
-
 /*=3D=3D=3D=3D=3D    Local Constants   =3D=3D=3D=3D=3D*/
 static const unsigned BIT_mask[] =3D {
     0,          1,         3,         7,         0xF,       0x1F,
@@ -171,16 +149,22 @@ MEM_STATIC size_t BIT_initCStream(BIT_CStream_t* bitC=
,
     return 0;
 }
=20
+FORCE_INLINE_TEMPLATE BitContainerType BIT_getLowerBits(BitContainerType b=
itContainer, U32 const nbBits)
+{
+    assert(nbBits < BIT_MASK_SIZE);
+    return bitContainer & BIT_mask[nbBits];
+}
+
 /*! BIT_addBits() :
  *  can add up to 31 bits into `bitC`.
  *  Note : does not check for register overflow ! */
 MEM_STATIC void BIT_addBits(BIT_CStream_t* bitC,
-                            size_t value, unsigned nbBits)
+                            BitContainerType value, unsigned nbBits)
 {
     DEBUG_STATIC_ASSERT(BIT_MASK_SIZE =3D=3D 32);
     assert(nbBits < BIT_MASK_SIZE);
     assert(nbBits + bitC->bitPos < sizeof(bitC->bitContainer) * 8);
-    bitC->bitContainer |=3D (value & BIT_mask[nbBits]) << bitC->bitPos;
+    bitC->bitContainer |=3D BIT_getLowerBits(value, nbBits) << bitC->bitPo=
s;
     bitC->bitPos +=3D nbBits;
 }
=20
@@ -188,7 +172,7 @@ MEM_STATIC void BIT_addBits(BIT_CStream_t* bitC,
  *  works only if `value` is _clean_,
  *  meaning all high bits above nbBits are 0 */
 MEM_STATIC void BIT_addBitsFast(BIT_CStream_t* bitC,
-                                size_t value, unsigned nbBits)
+                                BitContainerType value, unsigned nbBits)
 {
     assert((value>>nbBits) =3D=3D 0);
     assert(nbBits + bitC->bitPos < sizeof(bitC->bitContainer) * 8);
@@ -235,7 +219,7 @@ MEM_STATIC size_t BIT_closeCStream(BIT_CStream_t* bitC)
     BIT_addBitsFast(bitC, 1, 1);   /* endMark */
     BIT_flushBits(bitC);
     if (bitC->ptr >=3D bitC->endPtr) return 0; /* overflow detected */
-    return (bitC->ptr - bitC->startPtr) + (bitC->bitPos > 0);
+    return (size_t)(bitC->ptr - bitC->startPtr) + (bitC->bitPos > 0);
 }
=20
 /*-********************************************************
@@ -258,35 +242,35 @@ MEM_STATIC size_t BIT_initDStream(BIT_DStream_t* bitD=
, const void* srcBuffer, si
         bitD->ptr   =3D (const char*)srcBuffer + srcSize - sizeof(bitD->bi=
tContainer);
         bitD->bitContainer =3D MEM_readLEST(bitD->ptr);
         { BYTE const lastByte =3D ((const BYTE*)srcBuffer)[srcSize-1];
-          bitD->bitsConsumed =3D lastByte ? 8 - BIT_highbit32(lastByte) : =
0;  /* ensures bitsConsumed is always set */
+          bitD->bitsConsumed =3D lastByte ? 8 - ZSTD_highbit32(lastByte) :=
 0;  /* ensures bitsConsumed is always set */
           if (lastByte =3D=3D 0) return ERROR(GENERIC); /* endMark not pre=
sent */ }
     } else {
         bitD->ptr   =3D bitD->start;
         bitD->bitContainer =3D *(const BYTE*)(bitD->start);
         switch(srcSize)
         {
-        case 7: bitD->bitContainer +=3D (size_t)(((const BYTE*)(srcBuffer)=
)[6]) << (sizeof(bitD->bitContainer)*8 - 16);
+        case 7: bitD->bitContainer +=3D (BitContainerType)(((const BYTE*)(=
srcBuffer))[6]) << (sizeof(bitD->bitContainer)*8 - 16);
                 ZSTD_FALLTHROUGH;
=20
-        case 6: bitD->bitContainer +=3D (size_t)(((const BYTE*)(srcBuffer)=
)[5]) << (sizeof(bitD->bitContainer)*8 - 24);
+        case 6: bitD->bitContainer +=3D (BitContainerType)(((const BYTE*)(=
srcBuffer))[5]) << (sizeof(bitD->bitContainer)*8 - 24);
                 ZSTD_FALLTHROUGH;
=20
-        case 5: bitD->bitContainer +=3D (size_t)(((const BYTE*)(srcBuffer)=
)[4]) << (sizeof(bitD->bitContainer)*8 - 32);
+        case 5: bitD->bitContainer +=3D (BitContainerType)(((const BYTE*)(=
srcBuffer))[4]) << (sizeof(bitD->bitContainer)*8 - 32);
                 ZSTD_FALLTHROUGH;
=20
-        case 4: bitD->bitContainer +=3D (size_t)(((const BYTE*)(srcBuffer)=
)[3]) << 24;
+        case 4: bitD->bitContainer +=3D (BitContainerType)(((const BYTE*)(=
srcBuffer))[3]) << 24;
                 ZSTD_FALLTHROUGH;
=20
-        case 3: bitD->bitContainer +=3D (size_t)(((const BYTE*)(srcBuffer)=
)[2]) << 16;
+        case 3: bitD->bitContainer +=3D (BitContainerType)(((const BYTE*)(=
srcBuffer))[2]) << 16;
                 ZSTD_FALLTHROUGH;
=20
-        case 2: bitD->bitContainer +=3D (size_t)(((const BYTE*)(srcBuffer)=
)[1]) <<  8;
+        case 2: bitD->bitContainer +=3D (BitContainerType)(((const BYTE*)(=
srcBuffer))[1]) <<  8;
                 ZSTD_FALLTHROUGH;
=20
         default: break;
         }
         {   BYTE const lastByte =3D ((const BYTE*)srcBuffer)[srcSize-1];
-            bitD->bitsConsumed =3D lastByte ? 8 - BIT_highbit32(lastByte) =
: 0;
+            bitD->bitsConsumed =3D lastByte ? 8 - ZSTD_highbit32(lastByte)=
 : 0;
             if (lastByte =3D=3D 0) return ERROR(corruption_detected);  /* =
endMark not present */
         }
         bitD->bitsConsumed +=3D (U32)(sizeof(bitD->bitContainer) - srcSize=
)*8;
@@ -295,12 +279,12 @@ MEM_STATIC size_t BIT_initDStream(BIT_DStream_t* bitD=
, const void* srcBuffer, si
     return srcSize;
 }
=20
-MEM_STATIC FORCE_INLINE_ATTR size_t BIT_getUpperBits(size_t bitContainer, =
U32 const start)
+FORCE_INLINE_TEMPLATE BitContainerType BIT_getUpperBits(BitContainerType b=
itContainer, U32 const start)
 {
     return bitContainer >> start;
 }
=20
-MEM_STATIC FORCE_INLINE_ATTR size_t BIT_getMiddleBits(size_t bitContainer,=
 U32 const start, U32 const nbBits)
+FORCE_INLINE_TEMPLATE BitContainerType BIT_getMiddleBits(BitContainerType =
bitContainer, U32 const start, U32 const nbBits)
 {
     U32 const regMask =3D sizeof(bitContainer)*8 - 1;
     /* if start > regMask, bitstream is corrupted, and result is undefined=
 */
@@ -310,26 +294,20 @@ MEM_STATIC FORCE_INLINE_ATTR size_t BIT_getMiddleBits=
(size_t bitContainer, U32 c
      * such cpus old (pre-Haswell, 2013) and their performance is not of t=
hat
      * importance.
      */
-#if defined(__x86_64__) || defined(_M_X86)
+#if defined(__x86_64__) || defined(_M_X64)
     return (bitContainer >> (start & regMask)) & ((((U64)1) << nbBits) - 1=
);
 #else
     return (bitContainer >> (start & regMask)) & BIT_mask[nbBits];
 #endif
 }
=20
-MEM_STATIC FORCE_INLINE_ATTR size_t BIT_getLowerBits(size_t bitContainer, =
U32 const nbBits)
-{
-    assert(nbBits < BIT_MASK_SIZE);
-    return bitContainer & BIT_mask[nbBits];
-}
-
 /*! BIT_lookBits() :
  *  Provides next n bits from local register.
  *  local register is not modified.
  *  On 32-bits, maxNbBits=3D=3D24.
  *  On 64-bits, maxNbBits=3D=3D56.
  * @return : value extracted */
-MEM_STATIC  FORCE_INLINE_ATTR size_t BIT_lookBits(const BIT_DStream_t*  bi=
tD, U32 nbBits)
+FORCE_INLINE_TEMPLATE BitContainerType BIT_lookBits(const BIT_DStream_t*  =
bitD, U32 nbBits)
 {
     /* arbitrate between double-shift and shift+mask */
 #if 1
@@ -345,14 +323,14 @@ MEM_STATIC  FORCE_INLINE_ATTR size_t BIT_lookBits(con=
st BIT_DStream_t*  bitD, U3
=20
 /*! BIT_lookBitsFast() :
  *  unsafe version; only works if nbBits >=3D 1 */
-MEM_STATIC size_t BIT_lookBitsFast(const BIT_DStream_t* bitD, U32 nbBits)
+MEM_STATIC BitContainerType BIT_lookBitsFast(const BIT_DStream_t* bitD, U3=
2 nbBits)
 {
     U32 const regMask =3D sizeof(bitD->bitContainer)*8 - 1;
     assert(nbBits >=3D 1);
     return (bitD->bitContainer << (bitD->bitsConsumed & regMask)) >> (((re=
gMask+1)-nbBits) & regMask);
 }
=20
-MEM_STATIC FORCE_INLINE_ATTR void BIT_skipBits(BIT_DStream_t* bitD, U32 nb=
Bits)
+FORCE_INLINE_TEMPLATE void BIT_skipBits(BIT_DStream_t* bitD, U32 nbBits)
 {
     bitD->bitsConsumed +=3D nbBits;
 }
@@ -361,23 +339,38 @@ MEM_STATIC FORCE_INLINE_ATTR void BIT_skipBits(BIT_DS=
tream_t* bitD, U32 nbBits)
  *  Read (consume) next n bits from local register and update.
  *  Pay attention to not read more than nbBits contained into local regist=
er.
  * @return : extracted value. */
-MEM_STATIC FORCE_INLINE_ATTR size_t BIT_readBits(BIT_DStream_t* bitD, unsi=
gned nbBits)
+FORCE_INLINE_TEMPLATE BitContainerType BIT_readBits(BIT_DStream_t* bitD, u=
nsigned nbBits)
 {
-    size_t const value =3D BIT_lookBits(bitD, nbBits);
+    BitContainerType const value =3D BIT_lookBits(bitD, nbBits);
     BIT_skipBits(bitD, nbBits);
     return value;
 }
=20
 /*! BIT_readBitsFast() :
- *  unsafe version; only works only if nbBits >=3D 1 */
-MEM_STATIC size_t BIT_readBitsFast(BIT_DStream_t* bitD, unsigned nbBits)
+ *  unsafe version; only works if nbBits >=3D 1 */
+MEM_STATIC BitContainerType BIT_readBitsFast(BIT_DStream_t* bitD, unsigned=
 nbBits)
 {
-    size_t const value =3D BIT_lookBitsFast(bitD, nbBits);
+    BitContainerType const value =3D BIT_lookBitsFast(bitD, nbBits);
     assert(nbBits >=3D 1);
     BIT_skipBits(bitD, nbBits);
     return value;
 }
=20
+/*! BIT_reloadDStream_internal() :
+ *  Simple variant of BIT_reloadDStream(), with two conditions:
+ *  1. bitstream is valid : bitsConsumed <=3D sizeof(bitD->bitContainer)*8
+ *  2. look window is valid after shifted down : bitD->ptr >=3D bitD->star=
t
+ */
+MEM_STATIC BIT_DStream_status BIT_reloadDStream_internal(BIT_DStream_t* bi=
tD)
+{
+    assert(bitD->bitsConsumed <=3D sizeof(bitD->bitContainer)*8);
+    bitD->ptr -=3D bitD->bitsConsumed >> 3;
+    assert(bitD->ptr >=3D bitD->start);
+    bitD->bitsConsumed &=3D 7;
+    bitD->bitContainer =3D MEM_readLEST(bitD->ptr);
+    return BIT_DStream_unfinished;
+}
+
 /*! BIT_reloadDStreamFast() :
  *  Similar to BIT_reloadDStream(), but with two differences:
  *  1. bitsConsumed <=3D sizeof(bitD->bitContainer)*8 must hold!
@@ -388,31 +381,35 @@ MEM_STATIC BIT_DStream_status BIT_reloadDStreamFast(B=
IT_DStream_t* bitD)
 {
     if (UNLIKELY(bitD->ptr < bitD->limitPtr))
         return BIT_DStream_overflow;
-    assert(bitD->bitsConsumed <=3D sizeof(bitD->bitContainer)*8);
-    bitD->ptr -=3D bitD->bitsConsumed >> 3;
-    bitD->bitsConsumed &=3D 7;
-    bitD->bitContainer =3D MEM_readLEST(bitD->ptr);
-    return BIT_DStream_unfinished;
+    return BIT_reloadDStream_internal(bitD);
 }
=20
 /*! BIT_reloadDStream() :
  *  Refill `bitD` from buffer previously set in BIT_initDStream() .
- *  This function is safe, it guarantees it will not read beyond src buffe=
r.
+ *  This function is safe, it guarantees it will not never beyond src buff=
er.
  * @return : status of `BIT_DStream_t` internal register.
  *           when status =3D=3D BIT_DStream_unfinished, internal register =
is filled with at least 25 or 57 bits */
-MEM_STATIC BIT_DStream_status BIT_reloadDStream(BIT_DStream_t* bitD)
+FORCE_INLINE_TEMPLATE BIT_DStream_status BIT_reloadDStream(BIT_DStream_t* =
bitD)
 {
-    if (bitD->bitsConsumed > (sizeof(bitD->bitContainer)*8))  /* overflow =
detected, like end of stream */
+    /* note : once in overflow mode, a bitstream remains in this mode unti=
l it's reset */
+    if (UNLIKELY(bitD->bitsConsumed > (sizeof(bitD->bitContainer)*8))) {
+        static const BitContainerType zeroFilled =3D 0;
+        bitD->ptr =3D (const char*)&zeroFilled; /* aliasing is allowed for=
 char */
+        /* overflow detected, erroneous scenario or end of stream: no upda=
te */
         return BIT_DStream_overflow;
+    }
+
+    assert(bitD->ptr >=3D bitD->start);
=20
     if (bitD->ptr >=3D bitD->limitPtr) {
-        return BIT_reloadDStreamFast(bitD);
+        return BIT_reloadDStream_internal(bitD);
     }
     if (bitD->ptr =3D=3D bitD->start) {
+        /* reached end of bitStream =3D> no update */
         if (bitD->bitsConsumed < sizeof(bitD->bitContainer)*8) return BIT_=
DStream_endOfBuffer;
         return BIT_DStream_completed;
     }
-    /* start < ptr < limitPtr */
+    /* start < ptr < limitPtr =3D> cautious update */
     {   U32 nbBytes =3D bitD->bitsConsumed >> 3;
         BIT_DStream_status result =3D BIT_DStream_unfinished;
         if (bitD->ptr - nbBytes < bitD->start) {
diff --git a/lib/zstd/common/compiler.h b/lib/zstd/common/compiler.h
index a7345658602d..a9ba88daca97 100644
--- a/lib/zstd/common/compiler.h
+++ b/lib/zstd/common/compiler.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -11,6 +12,8 @@
 #ifndef ZSTD_COMPILER_H
 #define ZSTD_COMPILER_H
=20
+#include <linux/types.h>
+
 #include "portability_macros.h"
=20
 /*-*******************************************************
@@ -41,12 +44,15 @@
 */
 #define WIN_CDECL
=20
+/* UNUSED_ATTR tells the compiler it is okay if the function is unused. */
+#define UNUSED_ATTR __attribute__((unused))
+
 /*
  * FORCE_INLINE_TEMPLATE is used to define C "templates", which take const=
ant
  * parameters. They must be inlined for the compiler to eliminate the cons=
tant
  * branches.
  */
-#define FORCE_INLINE_TEMPLATE static INLINE_KEYWORD FORCE_INLINE_ATTR
+#define FORCE_INLINE_TEMPLATE static INLINE_KEYWORD FORCE_INLINE_ATTR UNUS=
ED_ATTR
 /*
  * HINT_INLINE is used to help the compiler generate better code. It is *n=
ot*
  * used for "templates", so it can be tweaked based on the compilers
@@ -61,11 +67,21 @@
 #if !defined(__clang__) && defined(__GNUC__) && __GNUC__ >=3D 4 && __GNUC_=
MINOR__ >=3D 8 && __GNUC__ < 5
 #  define HINT_INLINE static INLINE_KEYWORD
 #else
-#  define HINT_INLINE static INLINE_KEYWORD FORCE_INLINE_ATTR
+#  define HINT_INLINE FORCE_INLINE_TEMPLATE
 #endif
=20
-/* UNUSED_ATTR tells the compiler it is okay if the function is unused. */
-#define UNUSED_ATTR __attribute__((unused))
+/* "soft" inline :
+ * The compiler is free to select if it's a good idea to inline or not.
+ * The main objective is to silence compiler warnings
+ * when a defined function in included but not used.
+ *
+ * Note : this macro is prefixed `MEM_` because it used to be provided by =
`mem.h` unit.
+ * Updating the prefix is probably preferable, but requires a fairly large=
 codemod,
+ * since this name is used everywhere.
+ */
+#ifndef MEM_STATIC  /* already defined in Linux Kernel mem.h */
+#define MEM_STATIC static __inline UNUSED_ATTR
+#endif
=20
 /* force no inlining */
 #define FORCE_NOINLINE static __attribute__((__noinline__))
@@ -85,23 +101,24 @@
 #  define PREFETCH_L1(ptr)  __builtin_prefetch((ptr), 0 /* rw=3D=3Dread */=
, 3 /* locality */)
 #  define PREFETCH_L2(ptr)  __builtin_prefetch((ptr), 0 /* rw=3D=3Dread */=
, 2 /* locality */)
 #elif defined(__aarch64__)
-#  define PREFETCH_L1(ptr)  __asm__ __volatile__("prfm pldl1keep, %0" ::"Q=
"(*(ptr)))
-#  define PREFETCH_L2(ptr)  __asm__ __volatile__("prfm pldl2keep, %0" ::"Q=
"(*(ptr)))
+#  define PREFETCH_L1(ptr)  do { __asm__ __volatile__("prfm pldl1keep, %0"=
 ::"Q"(*(ptr))); } while (0)
+#  define PREFETCH_L2(ptr)  do { __asm__ __volatile__("prfm pldl2keep, %0"=
 ::"Q"(*(ptr))); } while (0)
 #else
-#  define PREFETCH_L1(ptr) (void)(ptr)  /* disabled */
-#  define PREFETCH_L2(ptr) (void)(ptr)  /* disabled */
+#  define PREFETCH_L1(ptr) do { (void)(ptr); } while (0)  /* disabled */
+#  define PREFETCH_L2(ptr) do { (void)(ptr); } while (0)  /* disabled */
 #endif  /* NO_PREFETCH */
=20
 #define CACHELINE_SIZE 64
=20
-#define PREFETCH_AREA(p, s)  {            \
-    const char* const _ptr =3D (const char*)(p);  \
-    size_t const _size =3D (size_t)(s);     \
-    size_t _pos;                          \
-    for (_pos=3D0; _pos<_size; _pos+=3DCACHELINE_SIZE) {  \
-        PREFETCH_L2(_ptr + _pos);         \
-    }                                     \
-}
+#define PREFETCH_AREA(p, s)                              \
+    do {                                                 \
+        const char* const _ptr =3D (const char*)(p);       \
+        size_t const _size =3D (size_t)(s);                \
+        size_t _pos;                                     \
+        for (_pos=3D0; _pos<_size; _pos+=3DCACHELINE_SIZE) { \
+            PREFETCH_L2(_ptr + _pos);                    \
+        }                                                \
+    } while (0)
=20
 /* vectorization
  * older GCC (pre gcc-4.3 picked as the cutoff) uses a different syntax,
@@ -125,15 +142,13 @@
 #define UNLIKELY(x) (__builtin_expect((x), 0))
=20
 #if __has_builtin(__builtin_unreachable) || (defined(__GNUC__) && (__GNUC_=
_ > 4 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=3D 5)))
-#  define ZSTD_UNREACHABLE { assert(0), __builtin_unreachable(); }
+#  define ZSTD_UNREACHABLE do { assert(0), __builtin_unreachable(); } whil=
e (0)
 #else
-#  define ZSTD_UNREACHABLE { assert(0); }
+#  define ZSTD_UNREACHABLE do { assert(0); } while (0)
 #endif
=20
 /* disable warnings */
=20
-/*Like DYNAMIC_BMI2 but for compile time determination of BMI2 support*/
-
 /* compile time determination of SIMD support */
=20
 /* C-language Attributes are added in C23. */
@@ -156,9 +171,15 @@
 #define ZSTD_FALLTHROUGH fallthrough
=20
 /*-**************************************************************
-*  Alignment check
+*  Alignment
 *****************************************************************/
=20
+/* @return 1 if @u is a 2^n value, 0 otherwise
+ * useful to check a value is valid for alignment restrictions */
+MEM_STATIC int ZSTD_isPower2(size_t u) {
+    return (u & (u-1)) =3D=3D 0;
+}
+
 /* this test was initially positioned in mem.h,
  * but this file is removed (or replaced) for linux kernel
  * so it's now hosted in compiler.h,
@@ -173,8 +194,92 @@
=20
 #endif /* ZSTD_ALIGNOF */
=20
+#ifndef ZSTD_ALIGNED
+/* C90-compatible alignment macro (GCC/Clang). Adjust for other compilers =
if needed. */
+#define ZSTD_ALIGNED(a) __attribute__((aligned(a)))
+#endif /* ZSTD_ALIGNED */
+
 /*-**************************************************************
 *  Sanitizer
 *****************************************************************/
=20
+/*
+ * Zstd relies on pointer overflow in its decompressor.
+ * We add this attribute to functions that rely on pointer overflow.
+ */
+#ifndef ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
+#  if __has_attribute(no_sanitize)
+#    if !defined(__clang__) && defined(__GNUC__) && __GNUC__ < 8
+       /* gcc < 8 only has signed-integer-overlow which triggers on pointe=
r overflow */
+#      define ZSTD_ALLOW_POINTER_OVERFLOW_ATTR __attribute__((no_sanitize(=
"signed-integer-overflow")))
+#    else
+       /* older versions of clang [3.7, 5.0) will warn that pointer-overfl=
ow is ignored. */
+#      define ZSTD_ALLOW_POINTER_OVERFLOW_ATTR __attribute__((no_sanitize(=
"pointer-overflow")))
+#    endif
+#  else
+#    define ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
+#  endif
+#endif
+
+/*
+ * Helper function to perform a wrapped pointer difference without trigger=
ing
+ * UBSAN.
+ *
+ * @returns lhs - rhs with wrapping
+ */
+MEM_STATIC
+ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
+ptrdiff_t ZSTD_wrappedPtrDiff(unsigned char const* lhs, unsigned char cons=
t* rhs)
+{
+    return lhs - rhs;
+}
+
+/*
+ * Helper function to perform a wrapped pointer add without triggering UBS=
AN.
+ *
+ * @return ptr + add with wrapping
+ */
+MEM_STATIC
+ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
+unsigned char const* ZSTD_wrappedPtrAdd(unsigned char const* ptr, ptrdiff_=
t add)
+{
+    return ptr + add;
+}
+
+/*
+ * Helper function to perform a wrapped pointer subtraction without trigge=
ring
+ * UBSAN.
+ *
+ * @return ptr - sub with wrapping
+ */
+MEM_STATIC
+ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
+unsigned char const* ZSTD_wrappedPtrSub(unsigned char const* ptr, ptrdiff_=
t sub)
+{
+    return ptr - sub;
+}
+
+/*
+ * Helper function to add to a pointer that works around C's undefined beh=
avior
+ * of adding 0 to NULL.
+ *
+ * @returns `ptr + add` except it defines `NULL + 0 =3D=3D NULL`.
+ */
+MEM_STATIC
+unsigned char* ZSTD_maybeNullPtrAdd(unsigned char* ptr, ptrdiff_t add)
+{
+    return add > 0 ? ptr + add : ptr;
+}
+
+/* Issue #3240 reports an ASAN failure on an llvm-mingw build. Out of an
+ * abundance of caution, disable our custom poisoning on mingw. */
+#ifdef __MINGW32__
+#ifndef ZSTD_ASAN_DONT_POISON_WORKSPACE
+#define ZSTD_ASAN_DONT_POISON_WORKSPACE 1
+#endif
+#ifndef ZSTD_MSAN_DONT_POISON_WORKSPACE
+#define ZSTD_MSAN_DONT_POISON_WORKSPACE 1
+#endif
+#endif
+
 #endif /* ZSTD_COMPILER_H */
diff --git a/lib/zstd/common/cpu.h b/lib/zstd/common/cpu.h
index becf832a95aa..c5b4f942e09f 100644
--- a/lib/zstd/common/cpu.h
+++ b/lib/zstd/common/cpu.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
diff --git a/lib/zstd/common/debug.c b/lib/zstd/common/debug.c
index 49254cc67223..7044652f65fe 100644
--- a/lib/zstd/common/debug.c
+++ b/lib/zstd/common/debug.c
@@ -1,7 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /* ******************************************************************
  * debug
  * Part of FSE library
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  *
  * You can contact the author at :
  * - Source repository : https://github.com/Cyan4973/FiniteStateEntropy
@@ -20,4 +21,10 @@
=20
 #include "debug.h"
=20
+#if (DEBUGLEVEL>=3D2)
+/* We only use this when DEBUGLEVEL>=3D2, but we get -Werror=3Dpedantic er=
rors if a
+ * translation unit is empty. So remove this from Linux kernel builds, but
+ * otherwise just leave it in.
+ */
 int g_debuglevel =3D DEBUGLEVEL;
+#endif
diff --git a/lib/zstd/common/debug.h b/lib/zstd/common/debug.h
index ad6e60d609e5..72350e012a34 100644
--- a/lib/zstd/common/debug.h
+++ b/lib/zstd/common/debug.h
@@ -1,7 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /* ******************************************************************
  * debug
  * Part of FSE library
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  *
  * You can contact the author at :
  * - Source repository : https://github.com/Cyan4973/FiniteStateEntropy
@@ -68,18 +69,27 @@ extern int g_debuglevel; /* the variable is only declar=
ed,
                             It's useful when enabling very verbose levels
                             on selective conditions (such as position in s=
rc) */
=20
-#  define RAWLOG(l, ...) {                                       \
-                if (l<=3Dg_debuglevel) {                           \
-                    ZSTD_DEBUG_PRINT(__VA_ARGS__);               \
-            }   }
-#  define DEBUGLOG(l, ...) {                                     \
-                if (l<=3Dg_debuglevel) {                           \
-                    ZSTD_DEBUG_PRINT(__FILE__ ": " __VA_ARGS__); \
-                    ZSTD_DEBUG_PRINT(" \n");                     \
-            }   }
+#  define RAWLOG(l, ...)                   \
+    do {                                   \
+        if (l<=3Dg_debuglevel) {             \
+            ZSTD_DEBUG_PRINT(__VA_ARGS__); \
+        }                                  \
+    } while (0)
+
+#define STRINGIFY(x) #x
+#define TOSTRING(x) STRINGIFY(x)
+#define LINE_AS_STRING TOSTRING(__LINE__)
+
+#  define DEBUGLOG(l, ...)                               \
+    do {                                                 \
+        if (l<=3Dg_debuglevel) {                           \
+            ZSTD_DEBUG_PRINT(__FILE__ ":" LINE_AS_STRING ": " __VA_ARGS__)=
; \
+            ZSTD_DEBUG_PRINT(" \n");                     \
+        }                                                \
+    } while (0)
 #else
-#  define RAWLOG(l, ...)      {}    /* disabled */
-#  define DEBUGLOG(l, ...)    {}    /* disabled */
+#  define RAWLOG(l, ...)   do { } while (0)    /* disabled */
+#  define DEBUGLOG(l, ...) do { } while (0)    /* disabled */
 #endif
=20
 #endif /* DEBUG_H_12987983217 */
diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_com=
mon.c
index 0f421839ed41..e67ec813daa7 100644
--- a/lib/zstd/common/entropy_common.c
+++ b/lib/zstd/common/entropy_common.c
@@ -1,6 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /* ******************************************************************
  * Common functions of New Generation Entropy library
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  *
  *  You can contact the author at :
  *  - FSE+HUF source repository : https://github.com/Cyan4973/FiniteStateE=
ntropy
@@ -19,8 +20,8 @@
 #include "error_private.h"       /* ERR_*, ERROR */
 #define FSE_STATIC_LINKING_ONLY  /* FSE_MIN_TABLELOG */
 #include "fse.h"
-#define HUF_STATIC_LINKING_ONLY  /* HUF_TABLELOG_ABSOLUTEMAX */
 #include "huf.h"
+#include "bits.h"                /* ZSDT_highbit32, ZSTD_countTrailingZero=
s32 */
=20
 /*=3D=3D=3D   Version   =3D=3D=3D*/
 unsigned FSE_versionNumber(void) { return FSE_VERSION_NUMBER; }
@@ -35,23 +36,6 @@ const char* HUF_getErrorName(size_t code) { return ERR_g=
etErrorName(code); }
 /*-**************************************************************
 *  FSE NCount encoding-decoding
 ****************************************************************/
-static U32 FSE_ctz(U32 val)
-{
-    assert(val !=3D 0);
-    {
-#   if (__GNUC__ >=3D 3)   /* GCC Intrinsic */
-        return __builtin_ctz(val);
-#   else   /* Software version */
-        U32 count =3D 0;
-        while ((val & 1) =3D=3D 0) {
-            val >>=3D 1;
-            ++count;
-        }
-        return count;
-#   endif
-    }
-}
-
 FORCE_INLINE_TEMPLATE
 size_t FSE_readNCount_body(short* normalizedCounter, unsigned* maxSVPtr, u=
nsigned* tableLogPtr,
                            const void* headerBuffer, size_t hbSize)
@@ -99,7 +83,7 @@ size_t FSE_readNCount_body(short* normalizedCounter, unsi=
gned* maxSVPtr, unsigne
              * repeat.
              * Avoid UB by setting the high bit to 1.
              */
-            int repeats =3D FSE_ctz(~bitStream | 0x80000000) >> 1;
+            int repeats =3D ZSTD_countTrailingZeros32(~bitStream | 0x80000=
000) >> 1;
             while (repeats >=3D 12) {
                 charnum +=3D 3 * 12;
                 if (LIKELY(ip <=3D iend-7)) {
@@ -110,7 +94,7 @@ size_t FSE_readNCount_body(short* normalizedCounter, uns=
igned* maxSVPtr, unsigne
                     ip =3D iend - 4;
                 }
                 bitStream =3D MEM_readLE32(ip) >> bitCount;
-                repeats =3D FSE_ctz(~bitStream | 0x80000000) >> 1;
+                repeats =3D ZSTD_countTrailingZeros32(~bitStream | 0x80000=
000) >> 1;
             }
             charnum +=3D 3 * repeats;
             bitStream >>=3D 2 * repeats;
@@ -175,7 +159,7 @@ size_t FSE_readNCount_body(short* normalizedCounter, un=
signed* maxSVPtr, unsigne
                  * know that threshold > 1.
                  */
                 if (remaining <=3D 1) break;
-                nbBits =3D BIT_highbit32(remaining) + 1;
+                nbBits =3D ZSTD_highbit32(remaining) + 1;
                 threshold =3D 1 << (nbBits - 1);
             }
             if (charnum >=3D maxSV1) break;
@@ -249,7 +233,7 @@ size_t HUF_readStats(BYTE* huffWeight, size_t hwSize, U=
32* rankStats,
                      const void* src, size_t srcSize)
 {
     U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
-    return HUF_readStats_wksp(huffWeight, hwSize, rankStats, nbSymbolsPtr,=
 tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2 */ 0);
+    return HUF_readStats_wksp(huffWeight, hwSize, rankStats, nbSymbolsPtr,=
 tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* flags */ 0);
 }
=20
 FORCE_INLINE_TEMPLATE size_t
@@ -297,14 +281,14 @@ HUF_readStats_body(BYTE* huffWeight, size_t hwSize, U=
32* rankStats,
     if (weightTotal =3D=3D 0) return ERROR(corruption_detected);
=20
     /* get last non-null symbol weight (implied, total must be 2^n) */
-    {   U32 const tableLog =3D BIT_highbit32(weightTotal) + 1;
+    {   U32 const tableLog =3D ZSTD_highbit32(weightTotal) + 1;
         if (tableLog > HUF_TABLELOG_MAX) return ERROR(corruption_detected)=
;
         *tableLogPtr =3D tableLog;
         /* determine last weight */
         {   U32 const total =3D 1 << tableLog;
             U32 const rest =3D total - weightTotal;
-            U32 const verif =3D 1 << BIT_highbit32(rest);
-            U32 const lastWeight =3D BIT_highbit32(rest) + 1;
+            U32 const verif =3D 1 << ZSTD_highbit32(rest);
+            U32 const lastWeight =3D ZSTD_highbit32(rest) + 1;
             if (verif !=3D rest) return ERROR(corruption_detected);    /* =
last value must be a clean power of 2 */
             huffWeight[oSize] =3D (BYTE)lastWeight;
             rankStats[lastWeight]++;
@@ -341,13 +325,13 @@ size_t HUF_readStats_wksp(BYTE* huffWeight, size_t hw=
Size, U32* rankStats,
                      U32* nbSymbolsPtr, U32* tableLogPtr,
                      const void* src, size_t srcSize,
                      void* workSpace, size_t wkspSize,
-                     int bmi2)
+                     int flags)
 {
 #if DYNAMIC_BMI2
-    if (bmi2) {
+    if (flags & HUF_flags_bmi2) {
         return HUF_readStats_body_bmi2(huffWeight, hwSize, rankStats, nbSy=
mbolsPtr, tableLogPtr, src, srcSize, workSpace, wkspSize);
     }
 #endif
-    (void)bmi2;
+    (void)flags;
     return HUF_readStats_body_default(huffWeight, hwSize, rankStats, nbSym=
bolsPtr, tableLogPtr, src, srcSize, workSpace, wkspSize);
 }
diff --git a/lib/zstd/common/error_private.c b/lib/zstd/common/error_privat=
e.c
index 6d1135f8c373..6c3dbad838b6 100644
--- a/lib/zstd/common/error_private.c
+++ b/lib/zstd/common/error_private.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -27,9 +28,11 @@ const char* ERR_getErrorString(ERR_enum code)
     case PREFIX(version_unsupported): return "Version not supported";
     case PREFIX(frameParameter_unsupported): return "Unsupported frame par=
ameter";
     case PREFIX(frameParameter_windowTooLarge): return "Frame requires too=
 much memory for decoding";
-    case PREFIX(corruption_detected): return "Corrupted block detected";
+    case PREFIX(corruption_detected): return "Data corruption detected";
     case PREFIX(checksum_wrong): return "Restored data doesn't match check=
sum";
+    case PREFIX(literals_headerWrong): return "Header of Literals' block d=
oesn't respect format specification";
     case PREFIX(parameter_unsupported): return "Unsupported parameter";
+    case PREFIX(parameter_combination_unsupported): return "Unsupported co=
mbination of parameters";
     case PREFIX(parameter_outOfBound): return "Parameter is out of bound";
     case PREFIX(init_missing): return "Context should be init first";
     case PREFIX(memory_allocation): return "Allocation error : not enough =
memory";
@@ -38,17 +41,23 @@ const char* ERR_getErrorString(ERR_enum code)
     case PREFIX(tableLog_tooLarge): return "tableLog requires too much mem=
ory : unsupported";
     case PREFIX(maxSymbolValue_tooLarge): return "Unsupported max Symbol V=
alue : too large";
     case PREFIX(maxSymbolValue_tooSmall): return "Specified maxSymbolValue=
 is too small";
+    case PREFIX(cannotProduce_uncompressedBlock): return "This mode cannot=
 generate an uncompressed block";
+    case PREFIX(stabilityCondition_notRespected): return "pledged buffer s=
tability condition is not respected";
     case PREFIX(dictionary_corrupted): return "Dictionary is corrupted";
     case PREFIX(dictionary_wrong): return "Dictionary mismatch";
     case PREFIX(dictionaryCreation_failed): return "Cannot create Dictiona=
ry from provided samples";
     case PREFIX(dstSize_tooSmall): return "Destination buffer is too small=
";
     case PREFIX(srcSize_wrong): return "Src size is incorrect";
     case PREFIX(dstBuffer_null): return "Operation on NULL destination buf=
fer";
+    case PREFIX(noForwardProgress_destFull): return "Operation made no pro=
gress over multiple calls, due to output buffer being full";
+    case PREFIX(noForwardProgress_inputEmpty): return "Operation made no p=
rogress over multiple calls, due to input being empty";
         /* following error codes are not stable and may be removed or chan=
ged in a future version */
     case PREFIX(frameIndex_tooLarge): return "Frame index is too large";
     case PREFIX(seekableIO): return "An I/O error occurred when reading/se=
eking";
     case PREFIX(dstBuffer_wrong): return "Destination buffer is wrong";
     case PREFIX(srcBuffer_wrong): return "Source buffer is wrong";
+    case PREFIX(sequenceProducer_failed): return "Block-level external seq=
uence producer returned an error code";
+    case PREFIX(externalSequences_invalid): return "External sequences are=
 not valid";
     case PREFIX(maxCode):
     default: return notErrorCode;
     }
diff --git a/lib/zstd/common/error_private.h b/lib/zstd/common/error_privat=
e.h
index 886d2757df48..8033cc2b74dd 100644
--- a/lib/zstd/common/error_private.h
+++ b/lib/zstd/common/error_private.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -44,8 +45,13 @@ ERR_STATIC unsigned ERR_isError(size_t code) { return (c=
ode > ERROR(maxCode)); }
 ERR_STATIC ERR_enum ERR_getErrorCode(size_t code) { if (!ERR_isError(code)=
) return (ERR_enum)0; return (ERR_enum) (0-code); }
=20
 /* check and forward error code */
-#define CHECK_V_F(e, f) size_t const e =3D f; if (ERR_isError(e)) return e
-#define CHECK_F(f)   { CHECK_V_F(_var_err__, f); }
+#define CHECK_V_F(e, f)     \
+    size_t const e =3D f;     \
+    do {                    \
+        if (ERR_isError(e)) \
+            return e;       \
+    } while (0)
+#define CHECK_F(f)   do { CHECK_V_F(_var_err__, f); } while (0)
=20
 /*-****************************************
 *  Error Strings
@@ -78,10 +84,12 @@ void _force_has_format_string(const char *format, ...) =
{
  * We want to force this function invocation to be syntactically correct, =
but
  * we don't want to force runtime evaluation of its arguments.
  */
-#define _FORCE_HAS_FORMAT_STRING(...) \
-  if (0) { \
-    _force_has_format_string(__VA_ARGS__); \
-  }
+#define _FORCE_HAS_FORMAT_STRING(...)              \
+    do {                                           \
+        if (0) {                                   \
+            _force_has_format_string(__VA_ARGS__); \
+        }                                          \
+    } while (0)
=20
 #define ERR_QUOTE(str) #str
=20
@@ -92,47 +100,49 @@ void _force_has_format_string(const char *format, ...)=
 {
  * In order to do that (particularly, printing the conditional that failed=
),
  * this can't just wrap RETURN_ERROR().
  */
-#define RETURN_ERROR_IF(cond, err, ...) \
-  if (cond) { \
-    RAWLOG(3, "%s:%d: ERROR!: check %s failed, returning %s", \
-           __FILE__, __LINE__, ERR_QUOTE(cond), ERR_QUOTE(ERROR(err))); \
-    _FORCE_HAS_FORMAT_STRING(__VA_ARGS__); \
-    RAWLOG(3, ": " __VA_ARGS__); \
-    RAWLOG(3, "\n"); \
-    return ERROR(err); \
-  }
+#define RETURN_ERROR_IF(cond, err, ...)                                   =
     \
+    do {                                                                  =
     \
+        if (cond) {                                                       =
     \
+            RAWLOG(3, "%s:%d: ERROR!: check %s failed, returning %s",     =
     \
+                  __FILE__, __LINE__, ERR_QUOTE(cond), ERR_QUOTE(ERROR(err=
))); \
+            _FORCE_HAS_FORMAT_STRING(__VA_ARGS__);                        =
     \
+            RAWLOG(3, ": " __VA_ARGS__);                                  =
     \
+            RAWLOG(3, "\n");                                              =
     \
+            return ERROR(err);                                            =
     \
+        }                                                                 =
     \
+    } while (0)
=20
 /*
  * Unconditionally return the specified error.
  *
  * In debug modes, prints additional information.
  */
-#define RETURN_ERROR(err, ...) \
-  do { \
-    RAWLOG(3, "%s:%d: ERROR!: unconditional check failed, returning %s", \
-           __FILE__, __LINE__, ERR_QUOTE(ERROR(err))); \
-    _FORCE_HAS_FORMAT_STRING(__VA_ARGS__); \
-    RAWLOG(3, ": " __VA_ARGS__); \
-    RAWLOG(3, "\n"); \
-    return ERROR(err); \
-  } while(0);
+#define RETURN_ERROR(err, ...)                                            =
   \
+    do {                                                                  =
   \
+        RAWLOG(3, "%s:%d: ERROR!: unconditional check failed, returning %s=
", \
+              __FILE__, __LINE__, ERR_QUOTE(ERROR(err)));                 =
   \
+        _FORCE_HAS_FORMAT_STRING(__VA_ARGS__);                            =
   \
+        RAWLOG(3, ": " __VA_ARGS__);                                      =
   \
+        RAWLOG(3, "\n");                                                  =
   \
+        return ERROR(err);                                                =
   \
+    } while(0)
=20
 /*
  * If the provided expression evaluates to an error code, returns that err=
or code.
  *
  * In debug modes, prints additional information.
  */
-#define FORWARD_IF_ERROR(err, ...) \
-  do { \
-    size_t const err_code =3D (err); \
-    if (ERR_isError(err_code)) { \
-      RAWLOG(3, "%s:%d: ERROR!: forwarding error in %s: %s", \
-             __FILE__, __LINE__, ERR_QUOTE(err), ERR_getErrorName(err_code=
)); \
-      _FORCE_HAS_FORMAT_STRING(__VA_ARGS__); \
-      RAWLOG(3, ": " __VA_ARGS__); \
-      RAWLOG(3, "\n"); \
-      return err_code; \
-    } \
-  } while(0);
+#define FORWARD_IF_ERROR(err, ...)                                        =
         \
+    do {                                                                  =
         \
+        size_t const err_code =3D (err);                                  =
           \
+        if (ERR_isError(err_code)) {                                      =
         \
+            RAWLOG(3, "%s:%d: ERROR!: forwarding error in %s: %s",        =
         \
+                  __FILE__, __LINE__, ERR_QUOTE(err), ERR_getErrorName(err=
_code)); \
+            _FORCE_HAS_FORMAT_STRING(__VA_ARGS__);                        =
         \
+            RAWLOG(3, ": " __VA_ARGS__);                                  =
         \
+            RAWLOG(3, "\n");                                              =
         \
+            return err_code;                                              =
         \
+        }                                                                 =
         \
+    } while(0)
=20
 #endif /* ERROR_H_MODULE */
diff --git a/lib/zstd/common/fse.h b/lib/zstd/common/fse.h
index 78b3ff14b93f..9b8fb9cec974 100644
--- a/lib/zstd/common/fse.h
+++ b/lib/zstd/common/fse.h
@@ -1,7 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /* ******************************************************************
  * FSE : Finite State Entropy codec
  * Public Prototypes declaration
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  *
  * You can contact the author at :
  * - Source repository : https://github.com/Cyan4973/FiniteStateEntropy
@@ -11,7 +12,6 @@
  * in the COPYING file in the root directory of this source tree).
  * You may select, at your option, one of the above-listed licenses.
 ****************************************************************** */
-
 #ifndef FSE_H
 #define FSE_H
=20
@@ -46,33 +46,6 @@
 #define FSE_VERSION_NUMBER  (FSE_VERSION_MAJOR *100*100 + FSE_VERSION_MINO=
R *100 + FSE_VERSION_RELEASE)
 FSE_PUBLIC_API unsigned FSE_versionNumber(void);   /*< library version num=
ber; to be used when checking dll version */
=20
-/*-****************************************
-*  FSE simple functions
-******************************************/
-/*! FSE_compress() :
-    Compress content of buffer 'src', of size 'srcSize', into destination =
buffer 'dst'.
-    'dst' buffer must be already allocated. Compression runs faster is dst=
Capacity >=3D FSE_compressBound(srcSize).
-    @return : size of compressed data (<=3D dstCapacity).
-    Special values : if return =3D=3D 0, srcData is not compressible =3D> =
Nothing is stored within dst !!!
-                     if return =3D=3D 1, srcData is a single byte symbol *=
 srcSize times. Use RLE compression instead.
-                     if FSE_isError(return), compression failed (more deta=
ils using FSE_getErrorName())
-*/
-FSE_PUBLIC_API size_t FSE_compress(void* dst, size_t dstCapacity,
-                             const void* src, size_t srcSize);
-
-/*! FSE_decompress():
-    Decompress FSE data from buffer 'cSrc', of size 'cSrcSize',
-    into already allocated destination buffer 'dst', of size 'dstCapacity'=
.
-    @return : size of regenerated data (<=3D maxDstSize),
-              or an error code, which can be tested using FSE_isError() .
-
-    ** Important ** : FSE_decompress() does not decompress non-compressibl=
e nor RLE data !!!
-    Why ? : making this distinction requires a header.
-    Header management is intentionally delegated to the user layer, which =
can better manage special cases.
-*/
-FSE_PUBLIC_API size_t FSE_decompress(void* dst,  size_t dstCapacity,
-                               const void* cSrc, size_t cSrcSize);
-
 /*-*****************************************
 *  Tool functions
 ******************************************/
@@ -82,19 +55,6 @@ FSE_PUBLIC_API size_t FSE_compressBound(size_t size);   =
    /* maximum compresse
 FSE_PUBLIC_API unsigned    FSE_isError(size_t code);        /* tells if a =
return value is an error code */
 FSE_PUBLIC_API const char* FSE_getErrorName(size_t code);   /* provides er=
ror code string (useful for debugging) */
=20
-/*-*****************************************
-*  FSE advanced functions
-******************************************/
-/*! FSE_compress2() :
-    Same as FSE_compress(), but allows the selection of 'maxSymbolValue' a=
nd 'tableLog'
-    Both parameters can be defined as '0' to mean : use default value
-    @return : size of compressed data
-    Special values : if return =3D=3D 0, srcData is not compressible =3D> =
Nothing is stored within cSrc !!!
-                     if return =3D=3D 1, srcData is a single byte symbol *=
 srcSize times. Use RLE compression.
-                     if FSE_isError(return), it's an error code.
-*/
-FSE_PUBLIC_API size_t FSE_compress2 (void* dst, size_t dstSize, const void=
* src, size_t srcSize, unsigned maxSymbolValue, unsigned tableLog);
-
 /*-*****************************************
 *  FSE detailed API
 ******************************************/
@@ -154,8 +114,6 @@ FSE_PUBLIC_API size_t FSE_writeNCount (void* buffer, si=
ze_t bufferSize,
 /*! Constructor and Destructor of FSE_CTable.
     Note that FSE_CTable size depends on 'tableLog' and 'maxSymbolValue' *=
/
 typedef unsigned FSE_CTable;   /* don't allocate that. It's only meant to =
be more restrictive than void* */
-FSE_PUBLIC_API FSE_CTable* FSE_createCTable (unsigned maxSymbolValue, unsi=
gned tableLog);
-FSE_PUBLIC_API void        FSE_freeCTable (FSE_CTable* ct);
=20
 /*! FSE_buildCTable():
     Builds `ct`, which must be already allocated, using FSE_createCTable()=
.
@@ -230,23 +188,7 @@ FSE_PUBLIC_API size_t FSE_readNCount_bmi2(short* norma=
lizedCounter,
                            unsigned* maxSymbolValuePtr, unsigned* tableLog=
Ptr,
                            const void* rBuffer, size_t rBuffSize, int bmi2=
);
=20
-/*! Constructor and Destructor of FSE_DTable.
-    Note that its size depends on 'tableLog' */
 typedef unsigned FSE_DTable;   /* don't allocate that. It's just a way to =
be more restrictive than void* */
-FSE_PUBLIC_API FSE_DTable* FSE_createDTable(unsigned tableLog);
-FSE_PUBLIC_API void        FSE_freeDTable(FSE_DTable* dt);
-
-/*! FSE_buildDTable():
-    Builds 'dt', which must be already allocated, using FSE_createDTable()=
.
-    return : 0, or an errorCode, which can be tested using FSE_isError() *=
/
-FSE_PUBLIC_API size_t FSE_buildDTable (FSE_DTable* dt, const short* normal=
izedCounter, unsigned maxSymbolValue, unsigned tableLog);
-
-/*! FSE_decompress_usingDTable():
-    Decompress compressed source `cSrc` of size `cSrcSize` using `dt`
-    into `dst` which must be already allocated.
-    @return : size of regenerated data (necessarily <=3D `dstCapacity`),
-              or an errorCode, which can be tested using FSE_isError() */
-FSE_PUBLIC_API size_t FSE_decompress_usingDTable(void* dst, size_t dstCapa=
city, const void* cSrc, size_t cSrcSize, const FSE_DTable* dt);
=20
 /*!
 Tutorial :
@@ -280,8 +222,6 @@ If there is an error, the function will return an error=
 code, which can be teste
=20
 #if !defined(FSE_H_FSE_STATIC_LINKING_ONLY)
 #define FSE_H_FSE_STATIC_LINKING_ONLY
-
-/* *** Dependency *** */
 #include "bitstream.h"
=20
 /* *****************************************
@@ -307,16 +247,6 @@ If there is an error, the function will return an erro=
r code, which can be teste
 unsigned FSE_optimalTableLog_internal(unsigned maxTableLog, size_t srcSize=
, unsigned maxSymbolValue, unsigned minus);
 /*< same as FSE_optimalTableLog(), which used `minus=3D=3D2` */
=20
-/* FSE_compress_wksp() :
- * Same as FSE_compress2(), but using an externally allocated scratch buff=
er (`workSpace`).
- * FSE_COMPRESS_WKSP_SIZE_U32() provides the minimum size required for `wo=
rkSpace` as a table of FSE_CTable.
- */
-#define FSE_COMPRESS_WKSP_SIZE_U32(maxTableLog, maxSymbolValue)   ( FSE_CT=
ABLE_SIZE_U32(maxTableLog, maxSymbolValue) + ((maxTableLog > 12) ? (1 << (m=
axTableLog - 2)) : 1024) )
-size_t FSE_compress_wksp (void* dst, size_t dstSize, const void* src, size=
_t srcSize, unsigned maxSymbolValue, unsigned tableLog, void* workSpace, si=
ze_t wkspSize);
-
-size_t FSE_buildCTable_raw (FSE_CTable* ct, unsigned nbBits);
-/*< build a fake FSE_CTable, designed for a flat distribution, where each =
symbol uses nbBits */
-
 size_t FSE_buildCTable_rle (FSE_CTable* ct, unsigned char symbolValue);
 /*< build a fake FSE_CTable, designed to compress always the same symbolVa=
lue */
=20
@@ -334,19 +264,11 @@ size_t FSE_buildCTable_wksp(FSE_CTable* ct, const sho=
rt* normalizedCounter, unsi
 FSE_PUBLIC_API size_t FSE_buildDTable_wksp(FSE_DTable* dt, const short* no=
rmalizedCounter, unsigned maxSymbolValue, unsigned tableLog, void* workSpac=
e, size_t wkspSize);
 /*< Same as FSE_buildDTable(), using an externally allocated `workspace` p=
roduced with `FSE_BUILD_DTABLE_WKSP_SIZE_U32(maxSymbolValue)` */
=20
-size_t FSE_buildDTable_raw (FSE_DTable* dt, unsigned nbBits);
-/*< build a fake FSE_DTable, designed to read a flat distribution where ea=
ch symbol uses nbBits */
-
-size_t FSE_buildDTable_rle (FSE_DTable* dt, unsigned char symbolValue);
-/*< build a fake FSE_DTable, designed to always generate the same symbolVa=
lue */
-
-#define FSE_DECOMPRESS_WKSP_SIZE_U32(maxTableLog, maxSymbolValue) (FSE_DTA=
BLE_SIZE_U32(maxTableLog) + FSE_BUILD_DTABLE_WKSP_SIZE_U32(maxTableLog, max=
SymbolValue) + (FSE_MAX_SYMBOL_VALUE + 1) / 2 + 1)
+#define FSE_DECOMPRESS_WKSP_SIZE_U32(maxTableLog, maxSymbolValue) (FSE_DTA=
BLE_SIZE_U32(maxTableLog) + 1 + FSE_BUILD_DTABLE_WKSP_SIZE_U32(maxTableLog,=
 maxSymbolValue) + (FSE_MAX_SYMBOL_VALUE + 1) / 2 + 1)
 #define FSE_DECOMPRESS_WKSP_SIZE(maxTableLog, maxSymbolValue) (FSE_DECOMPR=
ESS_WKSP_SIZE_U32(maxTableLog, maxSymbolValue) * sizeof(unsigned))
-size_t FSE_decompress_wksp(void* dst, size_t dstCapacity, const void* cSrc=
, size_t cSrcSize, unsigned maxLog, void* workSpace, size_t wkspSize);
-/*< same as FSE_decompress(), using an externally allocated `workSpace` pr=
oduced with `FSE_DECOMPRESS_WKSP_SIZE_U32(maxLog, maxSymbolValue)` */
-
 size_t FSE_decompress_wksp_bmi2(void* dst, size_t dstCapacity, const void*=
 cSrc, size_t cSrcSize, unsigned maxLog, void* workSpace, size_t wkspSize, =
int bmi2);
-/*< Same as FSE_decompress_wksp() but with dynamic BMI2 support. Pass 1 if=
 your CPU supports BMI2 or 0 if it doesn't. */
+/*< same as FSE_decompress(), using an externally allocated `workSpace` pr=
oduced with `FSE_DECOMPRESS_WKSP_SIZE_U32(maxLog, maxSymbolValue)`.
+ * Set bmi2 to 1 if your CPU supports BMI2 or 0 if it doesn't */
=20
 typedef enum {
    FSE_repeat_none,  /*< Cannot use the previous table */
@@ -523,19 +445,19 @@ MEM_STATIC void FSE_encodeSymbol(BIT_CStream_t* bitC,=
 FSE_CState_t* statePtr, un
     FSE_symbolCompressionTransform const symbolTT =3D ((const FSE_symbolCo=
mpressionTransform*)(statePtr->symbolTT))[symbol];
     const U16* const stateTable =3D (const U16*)(statePtr->stateTable);
     U32 const nbBitsOut  =3D (U32)((statePtr->value + symbolTT.deltaNbBits=
) >> 16);
-    BIT_addBits(bitC, statePtr->value, nbBitsOut);
+    BIT_addBits(bitC, (BitContainerType)statePtr->value, nbBitsOut);
     statePtr->value =3D stateTable[ (statePtr->value >> nbBitsOut) + symbo=
lTT.deltaFindState];
 }
=20
 MEM_STATIC void FSE_flushCState(BIT_CStream_t* bitC, const FSE_CState_t* s=
tatePtr)
 {
-    BIT_addBits(bitC, statePtr->value, statePtr->stateLog);
+    BIT_addBits(bitC, (BitContainerType)statePtr->value, statePtr->stateLo=
g);
     BIT_flushBits(bitC);
 }
=20
 /* FSE_getMaxNbBits() :
  * Approximate maximum cost of a symbol, in bits.
- * Fractional get rounded up (i.e : a symbol with a normalized frequency o=
f 3 gives the same result as a frequency of 2)
+ * Fractional get rounded up (i.e. a symbol with a normalized frequency of=
 3 gives the same result as a frequency of 2)
  * note 1 : assume symbolValue is valid (<=3D maxSymbolValue)
  * note 2 : if freq[symbolValue]=3D=3D0, @return a fake cost of tableLog+1=
 bits */
 MEM_STATIC U32 FSE_getMaxNbBits(const void* symbolTTPtr, U32 symbolValue)
@@ -684,4 +606,3 @@ MEM_STATIC unsigned FSE_endOfDState(const FSE_DState_t*=
 DStatePtr)
 #define FSE_TABLESTEP(tableSize) (((tableSize)>>1) + ((tableSize)>>3) + 3)
=20
 #endif /* FSE_STATIC_LINKING_ONLY */
-
diff --git a/lib/zstd/common/fse_decompress.c b/lib/zstd/common/fse_decompr=
ess.c
index 5aa75db413a0..6136e1add5df 100644
--- a/lib/zstd/common/fse_decompress.c
+++ b/lib/zstd/common/fse_decompress.c
@@ -1,6 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /* ******************************************************************
  * FSE : Finite State Entropy decoder
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  *
  *  You can contact the author at :
  *  - FSE source repository : https://github.com/Cyan4973/FiniteStateEntro=
py
@@ -21,8 +22,8 @@
 #define FSE_STATIC_LINKING_ONLY
 #include "fse.h"
 #include "error_private.h"
-#define ZSTD_DEPS_NEED_MALLOC
-#include "zstd_deps.h"
+#include "zstd_deps.h"  /* ZSTD_memcpy */
+#include "bits.h"       /* ZSTD_highbit32 */
=20
 /* **************************************************************
 *  Error Management
@@ -52,18 +53,6 @@
 #define FSE_FUNCTION_NAME(X,Y) FSE_CAT(X,Y)
 #define FSE_TYPE_NAME(X,Y) FSE_CAT(X,Y)
=20
-/* Function templates */
-FSE_DTable* FSE_createDTable (unsigned tableLog)
-{
-    if (tableLog > FSE_TABLELOG_ABSOLUTE_MAX) tableLog =3D FSE_TABLELOG_AB=
SOLUTE_MAX;
-    return (FSE_DTable*)ZSTD_malloc( FSE_DTABLE_SIZE_U32(tableLog) * sizeo=
f (U32) );
-}
-
-void FSE_freeDTable (FSE_DTable* dt)
-{
-    ZSTD_free(dt);
-}
-
 static size_t FSE_buildDTable_internal(FSE_DTable* dt, const short* normal=
izedCounter, unsigned maxSymbolValue, unsigned tableLog, void* workSpace, s=
ize_t wkspSize)
 {
     void* const tdPtr =3D dt+1;   /* because *dt is unsigned, 32-bits alig=
ned on 32-bits */
@@ -92,7 +81,7 @@ static size_t FSE_buildDTable_internal(FSE_DTable* dt, co=
nst short* normalizedCo
                     symbolNext[s] =3D 1;
                 } else {
                     if (normalizedCounter[s] >=3D largeLimit) DTableH.fast=
Mode=3D0;
-                    symbolNext[s] =3D normalizedCounter[s];
+                    symbolNext[s] =3D (U16)normalizedCounter[s];
         }   }   }
         ZSTD_memcpy(dt, &DTableH, sizeof(DTableH));
     }
@@ -107,8 +96,7 @@ static size_t FSE_buildDTable_internal(FSE_DTable* dt, c=
onst short* normalizedCo
          * all symbols have counts <=3D 8. We ensure we have 8 bytes at th=
e end of
          * our buffer to handle the over-write.
          */
-        {
-            U64 const add =3D 0x0101010101010101ull;
+        {   U64 const add =3D 0x0101010101010101ull;
             size_t pos =3D 0;
             U64 sv =3D 0;
             U32 s;
@@ -119,14 +107,13 @@ static size_t FSE_buildDTable_internal(FSE_DTable* dt=
, const short* normalizedCo
                 for (i =3D 8; i < n; i +=3D 8) {
                     MEM_write64(spread + pos + i, sv);
                 }
-                pos +=3D n;
-            }
-        }
+                pos +=3D (size_t)n;
+        }   }
         /* Now we spread those positions across the table.
-         * The benefit of doing it in two stages is that we avoid the the
+         * The benefit of doing it in two stages is that we avoid the
          * variable size inner loop, which caused lots of branch misses.
          * Now we can run through all the positions without any branch mis=
ses.
-         * We unroll the loop twice, since that is what emperically worked=
 best.
+         * We unroll the loop twice, since that is what empirically worked=
 best.
          */
         {
             size_t position =3D 0;
@@ -162,7 +149,7 @@ static size_t FSE_buildDTable_internal(FSE_DTable* dt, =
const short* normalizedCo
         for (u=3D0; u<tableSize; u++) {
             FSE_FUNCTION_TYPE const symbol =3D (FSE_FUNCTION_TYPE)(tableDe=
code[u].symbol);
             U32 const nextState =3D symbolNext[symbol]++;
-            tableDecode[u].nbBits =3D (BYTE) (tableLog - BIT_highbit32(nex=
tState) );
+            tableDecode[u].nbBits =3D (BYTE) (tableLog - ZSTD_highbit32(ne=
xtState) );
             tableDecode[u].newState =3D (U16) ( (nextState << tableDecode[=
u].nbBits) - tableSize);
     }   }
=20
@@ -179,48 +166,6 @@ size_t FSE_buildDTable_wksp(FSE_DTable* dt, const shor=
t* normalizedCounter, unsi
 /*-*******************************************************
 *  Decompression (Byte symbols)
 *********************************************************/
-size_t FSE_buildDTable_rle (FSE_DTable* dt, BYTE symbolValue)
-{
-    void* ptr =3D dt;
-    FSE_DTableHeader* const DTableH =3D (FSE_DTableHeader*)ptr;
-    void* dPtr =3D dt + 1;
-    FSE_decode_t* const cell =3D (FSE_decode_t*)dPtr;
-
-    DTableH->tableLog =3D 0;
-    DTableH->fastMode =3D 0;
-
-    cell->newState =3D 0;
-    cell->symbol =3D symbolValue;
-    cell->nbBits =3D 0;
-
-    return 0;
-}
-
-size_t FSE_buildDTable_raw (FSE_DTable* dt, unsigned nbBits)
-{
-    void* ptr =3D dt;
-    FSE_DTableHeader* const DTableH =3D (FSE_DTableHeader*)ptr;
-    void* dPtr =3D dt + 1;
-    FSE_decode_t* const dinfo =3D (FSE_decode_t*)dPtr;
-    const unsigned tableSize =3D 1 << nbBits;
-    const unsigned tableMask =3D tableSize - 1;
-    const unsigned maxSV1 =3D tableMask+1;
-    unsigned s;
-
-    /* Sanity checks */
-    if (nbBits < 1) return ERROR(GENERIC);         /* min size */
-
-    /* Build Decoding Table */
-    DTableH->tableLog =3D (U16)nbBits;
-    DTableH->fastMode =3D 1;
-    for (s=3D0; s<maxSV1; s++) {
-        dinfo[s].newState =3D 0;
-        dinfo[s].symbol =3D (BYTE)s;
-        dinfo[s].nbBits =3D (BYTE)nbBits;
-    }
-
-    return 0;
-}
=20
 FORCE_INLINE_TEMPLATE size_t FSE_decompress_usingDTable_generic(
           void* dst, size_t maxDstSize,
@@ -242,6 +187,8 @@ FORCE_INLINE_TEMPLATE size_t FSE_decompress_usingDTable=
_generic(
     FSE_initDState(&state1, &bitD, dt);
     FSE_initDState(&state2, &bitD, dt);
=20
+    RETURN_ERROR_IF(BIT_reloadDStream(&bitD)=3D=3DBIT_DStream_overflow, co=
rruption_detected, "");
+
 #define FSE_GETSYMBOL(statePtr) fast ? FSE_decodeSymbolFast(statePtr, &bit=
D) : FSE_decodeSymbol(statePtr, &bitD)
=20
     /* 4 symbols per loop */
@@ -281,30 +228,12 @@ FORCE_INLINE_TEMPLATE size_t FSE_decompress_usingDTab=
le_generic(
             break;
     }   }
=20
-    return op-ostart;
-}
-
-size_t FSE_decompress_usingDTable(void* dst, size_t originalSize,
-                            const void* cSrc, size_t cSrcSize,
-                            const FSE_DTable* dt)
-{
-    const void* ptr =3D dt;
-    const FSE_DTableHeader* DTableH =3D (const FSE_DTableHeader*)ptr;
-    const U32 fastMode =3D DTableH->fastMode;
-
-    /* select fast mode (static) */
-    if (fastMode) return FSE_decompress_usingDTable_generic(dst, originalS=
ize, cSrc, cSrcSize, dt, 1);
-    return FSE_decompress_usingDTable_generic(dst, originalSize, cSrc, cSr=
cSize, dt, 0);
-}
-
-size_t FSE_decompress_wksp(void* dst, size_t dstCapacity, const void* cSrc=
, size_t cSrcSize, unsigned maxLog, void* workSpace, size_t wkspSize)
-{
-    return FSE_decompress_wksp_bmi2(dst, dstCapacity, cSrc, cSrcSize, maxL=
og, workSpace, wkspSize, /* bmi2 */ 0);
+    assert(op >=3D ostart);
+    return (size_t)(op-ostart);
 }
=20
 typedef struct {
     short ncount[FSE_MAX_SYMBOL_VALUE + 1];
-    FSE_DTable dtable[1]; /* Dynamically sized */
 } FSE_DecompressWksp;
=20
 FORCE_INLINE_TEMPLATE size_t FSE_decompress_wksp_body(
@@ -318,13 +247,18 @@ FORCE_INLINE_TEMPLATE size_t FSE_decompress_wksp_body=
(
     unsigned tableLog;
     unsigned maxSymbolValue =3D FSE_MAX_SYMBOL_VALUE;
     FSE_DecompressWksp* const wksp =3D (FSE_DecompressWksp*)workSpace;
+    size_t const dtablePos =3D sizeof(FSE_DecompressWksp) / sizeof(FSE_DTa=
ble);
+    FSE_DTable* const dtable =3D (FSE_DTable*)workSpace + dtablePos;
=20
-    DEBUG_STATIC_ASSERT((FSE_MAX_SYMBOL_VALUE + 1) % 2 =3D=3D 0);
+    FSE_STATIC_ASSERT((FSE_MAX_SYMBOL_VALUE + 1) % 2 =3D=3D 0);
     if (wkspSize < sizeof(*wksp)) return ERROR(GENERIC);
=20
+    /* correct offset to dtable depends on this property */
+    FSE_STATIC_ASSERT(sizeof(FSE_DecompressWksp) % sizeof(FSE_DTable) =3D=
=3D 0);
+
     /* normal FSE decoding mode */
-    {
-        size_t const NCountLength =3D FSE_readNCount_bmi2(wksp->ncount, &m=
axSymbolValue, &tableLog, istart, cSrcSize, bmi2);
+    {   size_t const NCountLength =3D
+            FSE_readNCount_bmi2(wksp->ncount, &maxSymbolValue, &tableLog, =
istart, cSrcSize, bmi2);
         if (FSE_isError(NCountLength)) return NCountLength;
         if (tableLog > maxLog) return ERROR(tableLog_tooLarge);
         assert(NCountLength <=3D cSrcSize);
@@ -333,19 +267,20 @@ FORCE_INLINE_TEMPLATE size_t FSE_decompress_wksp_body=
(
     }
=20
     if (FSE_DECOMPRESS_WKSP_SIZE(tableLog, maxSymbolValue) > wkspSize) ret=
urn ERROR(tableLog_tooLarge);
-    workSpace =3D wksp->dtable + FSE_DTABLE_SIZE_U32(tableLog);
+    assert(sizeof(*wksp) + FSE_DTABLE_SIZE(tableLog) <=3D wkspSize);
+    workSpace =3D (BYTE*)workSpace + sizeof(*wksp) + FSE_DTABLE_SIZE(table=
Log);
     wkspSize -=3D sizeof(*wksp) + FSE_DTABLE_SIZE(tableLog);
=20
-    CHECK_F( FSE_buildDTable_internal(wksp->dtable, wksp->ncount, maxSymbo=
lValue, tableLog, workSpace, wkspSize) );
+    CHECK_F( FSE_buildDTable_internal(dtable, wksp->ncount, maxSymbolValue=
, tableLog, workSpace, wkspSize) );
=20
     {
-        const void* ptr =3D wksp->dtable;
+        const void* ptr =3D dtable;
         const FSE_DTableHeader* DTableH =3D (const FSE_DTableHeader*)ptr;
         const U32 fastMode =3D DTableH->fastMode;
=20
         /* select fast mode (static) */
-        if (fastMode) return FSE_decompress_usingDTable_generic(dst, dstCa=
pacity, ip, cSrcSize, wksp->dtable, 1);
-        return FSE_decompress_usingDTable_generic(dst, dstCapacity, ip, cS=
rcSize, wksp->dtable, 0);
+        if (fastMode) return FSE_decompress_usingDTable_generic(dst, dstCa=
pacity, ip, cSrcSize, dtable, 1);
+        return FSE_decompress_usingDTable_generic(dst, dstCapacity, ip, cS=
rcSize, dtable, 0);
     }
 }
=20
@@ -373,6 +308,4 @@ size_t FSE_decompress_wksp_bmi2(void* dst, size_t dstCa=
pacity, const void* cSrc,
     return FSE_decompress_wksp_body_default(dst, dstCapacity, cSrc, cSrcSi=
ze, maxLog, workSpace, wkspSize);
 }
=20
-typedef FSE_DTable DTable_max_t[FSE_DTABLE_SIZE_U32(FSE_MAX_TABLELOG)];
-
 #endif   /* FSE_COMMONDEFS_ONLY */
diff --git a/lib/zstd/common/huf.h b/lib/zstd/common/huf.h
index b2678b8153e3..d23cd05c4352 100644
--- a/lib/zstd/common/huf.h
+++ b/lib/zstd/common/huf.h
@@ -1,7 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /* ******************************************************************
  * huff0 huffman codec,
  * part of Finite State Entropy library
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  *
  * You can contact the author at :
  * - Source repository : https://github.com/Cyan4973/FiniteStateEntropy
@@ -17,94 +18,20 @@
=20
 /* *** Dependencies *** */
 #include "zstd_deps.h"    /* size_t */
-
-/* *** library symbols visibility *** */
-/* Note : when linking with -fvisibility=3Dhidden on gcc, or by default on=
 Visual,
- *        HUF symbols remain "private" (internal symbols for library only)=
.
- *        Set macro FSE_DLL_EXPORT to 1 if you want HUF symbols visible on=
 DLL interface */
-#if defined(FSE_DLL_EXPORT) && (FSE_DLL_EXPORT=3D=3D1) && defined(__GNUC__=
) && (__GNUC__ >=3D 4)
-#  define HUF_PUBLIC_API __attribute__ ((visibility ("default")))
-#elif defined(FSE_DLL_EXPORT) && (FSE_DLL_EXPORT=3D=3D1)   /* Visual expec=
ted */
-#  define HUF_PUBLIC_API __declspec(dllexport)
-#elif defined(FSE_DLL_IMPORT) && (FSE_DLL_IMPORT=3D=3D1)
-#  define HUF_PUBLIC_API __declspec(dllimport)  /* not required, just to g=
enerate faster code (saves a function pointer load from IAT and an indirect=
 jump) */
-#else
-#  define HUF_PUBLIC_API
-#endif
-
-/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D */
-/* ***  simple functions  *** */
-/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D */
-
-/* HUF_compress() :
- *  Compress content from buffer 'src', of size 'srcSize', into buffer 'ds=
t'.
- * 'dst' buffer must be already allocated.
- *  Compression runs faster if `dstCapacity` >=3D HUF_compressBound(srcSiz=
e).
- * `srcSize` must be <=3D `HUF_BLOCKSIZE_MAX` =3D=3D 128 KB.
- * @return : size of compressed data (<=3D `dstCapacity`).
- *  Special values : if return =3D=3D 0, srcData is not compressible =3D> =
Nothing is stored within dst !!!
- *                   if HUF_isError(return), compression failed (more deta=
ils using HUF_getErrorName())
- */
-HUF_PUBLIC_API size_t HUF_compress(void* dst, size_t dstCapacity,
-                             const void* src, size_t srcSize);
-
-/* HUF_decompress() :
- *  Decompress HUF data from buffer 'cSrc', of size 'cSrcSize',
- *  into already allocated buffer 'dst', of minimum size 'dstSize'.
- * `originalSize` : **must** be the ***exact*** size of original (uncompre=
ssed) data.
- *  Note : in contrast with FSE, HUF_decompress can regenerate
- *         RLE (cSrcSize=3D=3D1) and uncompressed (cSrcSize=3D=3DdstSize) =
data,
- *         because it knows size to regenerate (originalSize).
- * @return : size of regenerated data (=3D=3D originalSize),
- *           or an error code, which can be tested using HUF_isError()
- */
-HUF_PUBLIC_API size_t HUF_decompress(void* dst,  size_t originalSize,
-                               const void* cSrc, size_t cSrcSize);
+#include "mem.h"          /* U32 */
+#define FSE_STATIC_LINKING_ONLY
+#include "fse.h"
=20
 /* ***   Tool functions *** */
-#define HUF_BLOCKSIZE_MAX (128 * 1024)                  /*< maximum input =
size for a single block compressed with HUF_compress */
-HUF_PUBLIC_API size_t HUF_compressBound(size_t size);   /*< maximum compre=
ssed size (worst case) */
+#define HUF_BLOCKSIZE_MAX (128 * 1024)   /*< maximum input size for a sing=
le block compressed with HUF_compress */
+size_t HUF_compressBound(size_t size);   /*< maximum compressed size (wors=
t case) */
=20
 /* Error Management */
-HUF_PUBLIC_API unsigned    HUF_isError(size_t code);       /*< tells if a =
return value is an error code */
-HUF_PUBLIC_API const char* HUF_getErrorName(size_t code);  /*< provides er=
ror code string (useful for debugging) */
-
-/* ***   Advanced function   *** */
-
-/* HUF_compress2() :
- *  Same as HUF_compress(), but offers control over `maxSymbolValue` and `=
tableLog`.
- * `maxSymbolValue` must be <=3D HUF_SYMBOLVALUE_MAX .
- * `tableLog` must be `<=3D HUF_TABLELOG_MAX` . */
-HUF_PUBLIC_API size_t HUF_compress2 (void* dst, size_t dstCapacity,
-                               const void* src, size_t srcSize,
-                               unsigned maxSymbolValue, unsigned tableLog)=
;
+unsigned    HUF_isError(size_t code);       /*< tells if a return value is=
 an error code */
+const char* HUF_getErrorName(size_t code);  /*< provides error code string=
 (useful for debugging) */
=20
-/* HUF_compress4X_wksp() :
- *  Same as HUF_compress2(), but uses externally allocated `workSpace`.
- * `workspace` must be at least as large as HUF_WORKSPACE_SIZE */
 #define HUF_WORKSPACE_SIZE ((8 << 10) + 512 /* sorting scratch space */)
 #define HUF_WORKSPACE_SIZE_U64 (HUF_WORKSPACE_SIZE / sizeof(U64))
-HUF_PUBLIC_API size_t HUF_compress4X_wksp (void* dst, size_t dstCapacity,
-                                     const void* src, size_t srcSize,
-                                     unsigned maxSymbolValue, unsigned tab=
leLog,
-                                     void* workSpace, size_t wkspSize);
-
-#endif   /* HUF_H_298734234 */
-
-/* ******************************************************************
- *  WARNING !!
- *  The following section contains advanced and experimental definitions
- *  which shall never be used in the context of a dynamic library,
- *  because they are not guaranteed to remain stable in the future.
- *  Only consider them in association with static linking.
- * *****************************************************************/
-#if !defined(HUF_H_HUF_STATIC_LINKING_ONLY)
-#define HUF_H_HUF_STATIC_LINKING_ONLY
-
-/* *** Dependencies *** */
-#include "mem.h"   /* U32 */
-#define FSE_STATIC_LINKING_ONLY
-#include "fse.h"
=20
 /* *** Constants *** */
 #define HUF_TABLELOG_MAX      12      /* max runtime value of tableLog (du=
e to static allocation); can be modified up to HUF_TABLELOG_ABSOLUTEMAX */
@@ -143,24 +70,48 @@ typedef U32 HUF_DTable;
 /* ****************************************
 *  Advanced decompression functions
 ******************************************/
-size_t HUF_decompress4X1 (void* dst, size_t dstSize, const void* cSrc, siz=
e_t cSrcSize);   /*< single-symbol decoder */
-#ifndef HUF_FORCE_DECOMPRESS_X1
-size_t HUF_decompress4X2 (void* dst, size_t dstSize, const void* cSrc, siz=
e_t cSrcSize);   /*< double-symbols decoder */
-#endif
=20
-size_t HUF_decompress4X_DCtx (HUF_DTable* dctx, void* dst, size_t dstSize,=
 const void* cSrc, size_t cSrcSize);   /*< decodes RLE and uncompressed */
-size_t HUF_decompress4X_hufOnly(HUF_DTable* dctx, void* dst, size_t dstSiz=
e, const void* cSrc, size_t cSrcSize); /*< considers RLE and uncompressed a=
s errors */
-size_t HUF_decompress4X_hufOnly_wksp(HUF_DTable* dctx, void* dst, size_t d=
stSize, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize=
); /*< considers RLE and uncompressed as errors */
-size_t HUF_decompress4X1_DCtx(HUF_DTable* dctx, void* dst, size_t dstSize,=
 const void* cSrc, size_t cSrcSize);   /*< single-symbol decoder */
-size_t HUF_decompress4X1_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dst=
Size, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize);=
   /*< single-symbol decoder */
-#ifndef HUF_FORCE_DECOMPRESS_X1
-size_t HUF_decompress4X2_DCtx(HUF_DTable* dctx, void* dst, size_t dstSize,=
 const void* cSrc, size_t cSrcSize);   /*< double-symbols decoder */
-size_t HUF_decompress4X2_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dst=
Size, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize);=
   /*< double-symbols decoder */
-#endif
+/*
+ * Huffman flags bitset.
+ * For all flags, 0 is the default value.
+ */
+typedef enum {
+    /*
+     * If compiled with DYNAMIC_BMI2: Set flag only if the CPU supports BM=
I2 at runtime.
+     * Otherwise: Ignored.
+     */
+    HUF_flags_bmi2 =3D (1 << 0),
+    /*
+     * If set: Test possible table depths to find the one that produces th=
e smallest header + encoded size.
+     * If unset: Use heuristic to find the table depth.
+     */
+    HUF_flags_optimalDepth =3D (1 << 1),
+    /*
+     * If set: If the previous table can encode the input, always reuse th=
e previous table.
+     * If unset: If the previous table can encode the input, reuse the pre=
vious table if it results in a smaller output.
+     */
+    HUF_flags_preferRepeat =3D (1 << 2),
+    /*
+     * If set: Sample the input and check if the sample is uncompressible,=
 if it is then don't attempt to compress.
+     * If unset: Always histogram the entire input.
+     */
+    HUF_flags_suspectUncompressible =3D (1 << 3),
+    /*
+     * If set: Don't use assembly implementations
+     * If unset: Allow using assembly implementations
+     */
+    HUF_flags_disableAsm =3D (1 << 4),
+    /*
+     * If set: Don't use the fast decoding loop, always use the fallback d=
ecoding loop.
+     * If unset: Use the fast decoding loop when possible.
+     */
+    HUF_flags_disableFast =3D (1 << 5)
+} HUF_flags_e;
=20
 /* ****************************************
  *  HUF detailed API
  * ****************************************/
+#define HUF_OPTIMAL_DEPTH_THRESHOLD ZSTD_btultra
=20
 /*! HUF_compress() does the following:
  *  1. count symbol occurrence from source[] into table count[] using FSE_=
count() (exposed within "fse.h")
@@ -173,12 +124,12 @@ size_t HUF_decompress4X2_DCtx_wksp(HUF_DTable* dctx, =
void* dst, size_t dstSize,
  *  For example, it's possible to compress several blocks using the same '=
CTable',
  *  or to save and regenerate 'CTable' using external methods.
  */
-unsigned HUF_optimalTableLog(unsigned maxTableLog, size_t srcSize, unsigne=
d maxSymbolValue);
-size_t HUF_buildCTable (HUF_CElt* CTable, const unsigned* count, unsigned =
maxSymbolValue, unsigned maxNbBits);   /* @return : maxNbBits; CTable and c=
ount can overlap. In which case, CTable will overwrite count content */
-size_t HUF_writeCTable (void* dst, size_t maxDstSize, const HUF_CElt* CTab=
le, unsigned maxSymbolValue, unsigned huffLog);
+unsigned HUF_minTableLog(unsigned symbolCardinality);
+unsigned HUF_cardinality(const unsigned* count, unsigned maxSymbolValue);
+unsigned HUF_optimalTableLog(unsigned maxTableLog, size_t srcSize, unsigne=
d maxSymbolValue, void* workSpace,
+ size_t wkspSize, HUF_CElt* table, const unsigned* count, int flags); /* t=
able is used as scratch space for building and testing tables, not a return=
 value */
 size_t HUF_writeCTable_wksp(void* dst, size_t maxDstSize, const HUF_CElt* =
CTable, unsigned maxSymbolValue, unsigned huffLog, void* workspace, size_t =
workspaceSize);
-size_t HUF_compress4X_usingCTable(void* dst, size_t dstSize, const void* s=
rc, size_t srcSize, const HUF_CElt* CTable);
-size_t HUF_compress4X_usingCTable_bmi2(void* dst, size_t dstSize, const vo=
id* src, size_t srcSize, const HUF_CElt* CTable, int bmi2);
+size_t HUF_compress4X_usingCTable(void* dst, size_t dstSize, const void* s=
rc, size_t srcSize, const HUF_CElt* CTable, int flags);
 size_t HUF_estimateCompressedSize(const HUF_CElt* CTable, const unsigned* =
count, unsigned maxSymbolValue);
 int HUF_validateCTable(const HUF_CElt* CTable, const unsigned* count, unsi=
gned maxSymbolValue);
=20
@@ -187,6 +138,7 @@ typedef enum {
    HUF_repeat_check, /*< Can use the previous table but it must be checked=
. Note : The previous table must have been constructed by HUF_compress{1, 4=
}X_repeat */
    HUF_repeat_valid  /*< Can use the previous table and it is assumed to b=
e valid */
  } HUF_repeat;
+
 /* HUF_compress4X_repeat() :
  *  Same as HUF_compress4X_wksp(), but considers using hufTable if *repeat=
 !=3D HUF_repeat_none.
  *  If it uses hufTable it does not modify hufTable or repeat.
@@ -197,13 +149,13 @@ size_t HUF_compress4X_repeat(void* dst, size_t dstSiz=
e,
                        const void* src, size_t srcSize,
                        unsigned maxSymbolValue, unsigned tableLog,
                        void* workSpace, size_t wkspSize,    /*< `workSpace=
` must be aligned on 4-bytes boundaries, `wkspSize` must be >=3D HUF_WORKSP=
ACE_SIZE */
-                       HUF_CElt* hufTable, HUF_repeat* repeat, int preferR=
epeat, int bmi2, unsigned suspectUncompressible);
+                       HUF_CElt* hufTable, HUF_repeat* repeat, int flags);
=20
 /* HUF_buildCTable_wksp() :
  *  Same as HUF_buildCTable(), but using externally allocated scratch buff=
er.
  * `workSpace` must be aligned on 4-bytes boundaries, and its size must be=
 >=3D HUF_CTABLE_WORKSPACE_SIZE.
  */
-#define HUF_CTABLE_WORKSPACE_SIZE_U32 (2*HUF_SYMBOLVALUE_MAX +1 +1)
+#define HUF_CTABLE_WORKSPACE_SIZE_U32 ((4 * (HUF_SYMBOLVALUE_MAX + 1)) + 1=
92)
 #define HUF_CTABLE_WORKSPACE_SIZE (HUF_CTABLE_WORKSPACE_SIZE_U32 * sizeof(=
unsigned))
 size_t HUF_buildCTable_wksp (HUF_CElt* tree,
                        const unsigned* count, U32 maxSymbolValue, U32 maxN=
bBits,
@@ -229,7 +181,7 @@ size_t HUF_readStats_wksp(BYTE* huffWeight, size_t hwSi=
ze,
                           U32* rankStats, U32* nbSymbolsPtr, U32* tableLog=
Ptr,
                           const void* src, size_t srcSize,
                           void* workspace, size_t wkspSize,
-                          int bmi2);
+                          int flags);
=20
 /* HUF_readCTable() :
  *  Loading a CTable saved with HUF_writeCTable() */
@@ -237,9 +189,22 @@ size_t HUF_readCTable (HUF_CElt* CTable, unsigned* max=
SymbolValuePtr, const void
=20
 /* HUF_getNbBitsFromCTable() :
  *  Read nbBits from CTable symbolTable, for symbol `symbolValue` presumed=
 <=3D HUF_SYMBOLVALUE_MAX
- *  Note 1 : is not inlined, as HUF_CElt definition is private */
+ *  Note 1 : If symbolValue > HUF_readCTableHeader(symbolTable).maxSymbolV=
alue, returns 0
+ *  Note 2 : is not inlined, as HUF_CElt definition is private
+ */
 U32 HUF_getNbBitsFromCTable(const HUF_CElt* symbolTable, U32 symbolValue);
=20
+typedef struct {
+    BYTE tableLog;
+    BYTE maxSymbolValue;
+    BYTE unused[sizeof(size_t) - 2];
+} HUF_CTableHeader;
+
+/* HUF_readCTableHeader() :
+ *  @returns The header from the CTable specifying the tableLog and the ma=
xSymbolValue.
+ */
+HUF_CTableHeader HUF_readCTableHeader(HUF_CElt const* ctable);
+
 /*
  * HUF_decompress() does the following:
  * 1. select the decompression algorithm (X1, X2) based on pre-computed he=
uristics
@@ -267,31 +232,11 @@ U32 HUF_selectDecoder (size_t dstSize, size_t cSrcSiz=
e);
 #define HUF_DECOMPRESS_WORKSPACE_SIZE ((2 << 10) + (1 << 9))
 #define HUF_DECOMPRESS_WORKSPACE_SIZE_U32 (HUF_DECOMPRESS_WORKSPACE_SIZE /=
 sizeof(U32))
=20
-#ifndef HUF_FORCE_DECOMPRESS_X2
-size_t HUF_readDTableX1 (HUF_DTable* DTable, const void* src, size_t srcSi=
ze);
-size_t HUF_readDTableX1_wksp (HUF_DTable* DTable, const void* src, size_t =
srcSize, void* workSpace, size_t wkspSize);
-#endif
-#ifndef HUF_FORCE_DECOMPRESS_X1
-size_t HUF_readDTableX2 (HUF_DTable* DTable, const void* src, size_t srcSi=
ze);
-size_t HUF_readDTableX2_wksp (HUF_DTable* DTable, const void* src, size_t =
srcSize, void* workSpace, size_t wkspSize);
-#endif
-
-size_t HUF_decompress4X_usingDTable(void* dst, size_t maxDstSize, const vo=
id* cSrc, size_t cSrcSize, const HUF_DTable* DTable);
-#ifndef HUF_FORCE_DECOMPRESS_X2
-size_t HUF_decompress4X1_usingDTable(void* dst, size_t maxDstSize, const v=
oid* cSrc, size_t cSrcSize, const HUF_DTable* DTable);
-#endif
-#ifndef HUF_FORCE_DECOMPRESS_X1
-size_t HUF_decompress4X2_usingDTable(void* dst, size_t maxDstSize, const v=
oid* cSrc, size_t cSrcSize, const HUF_DTable* DTable);
-#endif
-
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
 /* single stream variants */
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
=20
-size_t HUF_compress1X (void* dst, size_t dstSize, const void* src, size_t =
srcSize, unsigned maxSymbolValue, unsigned tableLog);
-size_t HUF_compress1X_wksp (void* dst, size_t dstSize, const void* src, si=
ze_t srcSize, unsigned maxSymbolValue, unsigned tableLog, void* workSpace, =
size_t wkspSize);  /*< `workSpace` must be a table of at least HUF_WORKSPAC=
E_SIZE_U64 U64 */
-size_t HUF_compress1X_usingCTable(void* dst, size_t dstSize, const void* s=
rc, size_t srcSize, const HUF_CElt* CTable);
-size_t HUF_compress1X_usingCTable_bmi2(void* dst, size_t dstSize, const vo=
id* src, size_t srcSize, const HUF_CElt* CTable, int bmi2);
+size_t HUF_compress1X_usingCTable(void* dst, size_t dstSize, const void* s=
rc, size_t srcSize, const HUF_CElt* CTable, int flags);
 /* HUF_compress1X_repeat() :
  *  Same as HUF_compress1X_wksp(), but considers using hufTable if *repeat=
 !=3D HUF_repeat_none.
  *  If it uses hufTable it does not modify hufTable or repeat.
@@ -302,47 +247,27 @@ size_t HUF_compress1X_repeat(void* dst, size_t dstSiz=
e,
                        const void* src, size_t srcSize,
                        unsigned maxSymbolValue, unsigned tableLog,
                        void* workSpace, size_t wkspSize,   /*< `workSpace`=
 must be aligned on 4-bytes boundaries, `wkspSize` must be >=3D HUF_WORKSPA=
CE_SIZE */
-                       HUF_CElt* hufTable, HUF_repeat* repeat, int preferR=
epeat, int bmi2, unsigned suspectUncompressible);
+                       HUF_CElt* hufTable, HUF_repeat* repeat, int flags);
=20
-size_t HUF_decompress1X1 (void* dst, size_t dstSize, const void* cSrc, siz=
e_t cSrcSize);   /* single-symbol decoder */
+size_t HUF_decompress1X_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dstS=
ize, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize, i=
nt flags);
 #ifndef HUF_FORCE_DECOMPRESS_X1
-size_t HUF_decompress1X2 (void* dst, size_t dstSize, const void* cSrc, siz=
e_t cSrcSize);   /* double-symbol decoder */
-#endif
-
-size_t HUF_decompress1X_DCtx (HUF_DTable* dctx, void* dst, size_t dstSize,=
 const void* cSrc, size_t cSrcSize);
-size_t HUF_decompress1X_DCtx_wksp (HUF_DTable* dctx, void* dst, size_t dst=
Size, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize);
-#ifndef HUF_FORCE_DECOMPRESS_X2
-size_t HUF_decompress1X1_DCtx(HUF_DTable* dctx, void* dst, size_t dstSize,=
 const void* cSrc, size_t cSrcSize);   /*< single-symbol decoder */
-size_t HUF_decompress1X1_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dst=
Size, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize);=
   /*< single-symbol decoder */
-#endif
-#ifndef HUF_FORCE_DECOMPRESS_X1
-size_t HUF_decompress1X2_DCtx(HUF_DTable* dctx, void* dst, size_t dstSize,=
 const void* cSrc, size_t cSrcSize);   /*< double-symbols decoder */
-size_t HUF_decompress1X2_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dst=
Size, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize);=
   /*< double-symbols decoder */
-#endif
-
-size_t HUF_decompress1X_usingDTable(void* dst, size_t maxDstSize, const vo=
id* cSrc, size_t cSrcSize, const HUF_DTable* DTable);   /*< automatic selec=
tion of sing or double symbol decoder, based on DTable */
-#ifndef HUF_FORCE_DECOMPRESS_X2
-size_t HUF_decompress1X1_usingDTable(void* dst, size_t maxDstSize, const v=
oid* cSrc, size_t cSrcSize, const HUF_DTable* DTable);
-#endif
-#ifndef HUF_FORCE_DECOMPRESS_X1
-size_t HUF_decompress1X2_usingDTable(void* dst, size_t maxDstSize, const v=
oid* cSrc, size_t cSrcSize, const HUF_DTable* DTable);
+size_t HUF_decompress1X2_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dst=
Size, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize, =
int flags);   /*< double-symbols decoder */
 #endif
=20
 /* BMI2 variants.
  * If the CPU has BMI2 support, pass bmi2=3D1, otherwise pass bmi2=3D0.
  */
-size_t HUF_decompress1X_usingDTable_bmi2(void* dst, size_t maxDstSize, con=
st void* cSrc, size_t cSrcSize, const HUF_DTable* DTable, int bmi2);
+size_t HUF_decompress1X_usingDTable(void* dst, size_t maxDstSize, const vo=
id* cSrc, size_t cSrcSize, const HUF_DTable* DTable, int flags);
 #ifndef HUF_FORCE_DECOMPRESS_X2
-size_t HUF_decompress1X1_DCtx_wksp_bmi2(HUF_DTable* dctx, void* dst, size_=
t dstSize, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspS=
ize, int bmi2);
+size_t HUF_decompress1X1_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dst=
Size, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize, =
int flags);
 #endif
-size_t HUF_decompress4X_usingDTable_bmi2(void* dst, size_t maxDstSize, con=
st void* cSrc, size_t cSrcSize, const HUF_DTable* DTable, int bmi2);
-size_t HUF_decompress4X_hufOnly_wksp_bmi2(HUF_DTable* dctx, void* dst, siz=
e_t dstSize, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wks=
pSize, int bmi2);
+size_t HUF_decompress4X_usingDTable(void* dst, size_t maxDstSize, const vo=
id* cSrc, size_t cSrcSize, const HUF_DTable* DTable, int flags);
+size_t HUF_decompress4X_hufOnly_wksp(HUF_DTable* dctx, void* dst, size_t d=
stSize, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize=
, int flags);
 #ifndef HUF_FORCE_DECOMPRESS_X2
-size_t HUF_readDTableX1_wksp_bmi2(HUF_DTable* DTable, const void* src, siz=
e_t srcSize, void* workSpace, size_t wkspSize, int bmi2);
+size_t HUF_readDTableX1_wksp(HUF_DTable* DTable, const void* src, size_t s=
rcSize, void* workSpace, size_t wkspSize, int flags);
 #endif
 #ifndef HUF_FORCE_DECOMPRESS_X1
-size_t HUF_readDTableX2_wksp_bmi2(HUF_DTable* DTable, const void* src, siz=
e_t srcSize, void* workSpace, size_t wkspSize, int bmi2);
+size_t HUF_readDTableX2_wksp(HUF_DTable* DTable, const void* src, size_t s=
rcSize, void* workSpace, size_t wkspSize, int flags);
 #endif
=20
-#endif /* HUF_STATIC_LINKING_ONLY */
-
+#endif   /* HUF_H_298734234 */
diff --git a/lib/zstd/common/mem.h b/lib/zstd/common/mem.h
index 9794296285b9..5a3a35701e98 100644
--- a/lib/zstd/common/mem.h
+++ b/lib/zstd/common/mem.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -18,13 +18,14 @@
 #include <asm/unaligned.h>  /* get_unaligned, put_unaligned* */
 #include <linux/compiler.h>  /* inline */
 #include <asm/byteorder.h>  /* swab32, swab64 */
+#include "compiler.h"  /* INLINE_KEYWORD, UNUSED_ATTR */
 #include <linux/types.h>  /* size_t, ptrdiff_t */
 #include "debug.h"  /* DEBUG_STATIC_ASSERT */
-#include "compiler.h"  /* INLINE_KEYWORD, UNUSED_ATTR */
=20
 /*-****************************************
 *  Compiler specifics
 ******************************************/
+#undef MEM_STATIC /* may be already defined from common/compiler.h */
 #define MEM_STATIC static INLINE_KEYWORD UNUSED_ATTR
=20
 /*-**************************************************************
diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/portabi=
lity_macros.h
index b1cb945f275c..2c08632ae92b 100644
--- a/lib/zstd/common/portability_macros.h
+++ b/lib/zstd/common/portability_macros.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -12,7 +13,7 @@
 #define ZSTD_PORTABILITY_MACROS_H
=20
 /*
- * This header file contains macro defintions to support portability.
+ * This header file contains macro definitions to support portability.
  * This header is shared between C and ASM code, so it MUST only
  * contain macro definitions. It MUST not contain any C code.
  *
@@ -44,30 +45,34 @@
 /* Mark the internal assembly functions as hidden  */
 #ifdef __ELF__
 # define ZSTD_HIDE_ASM_FUNCTION(func) .hidden func
+#elif defined(__APPLE__)
+# define ZSTD_HIDE_ASM_FUNCTION(func) .private_extern func
 #else
 # define ZSTD_HIDE_ASM_FUNCTION(func)
 #endif
=20
+/* Compile time determination of BMI2 support */
+
 /* Enable runtime BMI2 dispatch based on the CPU.
  * Enabled for clang & gcc >=3D4.8 on x86 when BMI2 isn't enabled by defau=
lt.
  */
 #ifndef DYNAMIC_BMI2
-  #if ((defined(__clang__) && __has_attribute(__target__)) \
+#  if ((defined(__clang__) && __has_attribute(__target__)) \
       || (defined(__GNUC__) \
           && (__GNUC__ >=3D 5 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=3D=
 8)))) \
-      && (defined(__x86_64__) || defined(_M_X64)) \
+      && (defined(__i386__) || defined(__x86_64__) || defined(_M_IX86) || =
defined(_M_X64)) \
       && !defined(__BMI2__)
-  #  define DYNAMIC_BMI2 1
-  #else
-  #  define DYNAMIC_BMI2 0
-  #endif
+#    define DYNAMIC_BMI2 1
+#  else
+#    define DYNAMIC_BMI2 0
+#  endif
 #endif
=20
 /*
- * Only enable assembly for GNUC comptabile compilers,
+ * Only enable assembly for GNU C compatible compilers,
  * because other platforms may not support GAS assembly syntax.
  *
- * Only enable assembly for Linux / MacOS, other platforms may
+ * Only enable assembly for Linux / MacOS / Win32, other platforms may
  * work, but they haven't been tested. This could likely be
  * extended to BSD systems.
  *
@@ -89,4 +94,23 @@
  */
 #define ZSTD_ENABLE_ASM_X86_64_BMI2 0
=20
+/*
+ * For x86 ELF targets, add .note.gnu.property section for Intel CET in
+ * assembly sources when CET is enabled.
+ *
+ * Additionally, any function that may be called indirectly must begin
+ * with ZSTD_CET_ENDBRANCH.
+ */
+#if defined(__ELF__) && (defined(__x86_64__) || defined(__i386__)) \
+    && defined(__has_include)
+# if __has_include(<cet.h>)
+#  include <cet.h>
+#  define ZSTD_CET_ENDBRANCH _CET_ENDBR
+# endif
+#endif
+
+#ifndef ZSTD_CET_ENDBRANCH
+# define ZSTD_CET_ENDBRANCH
+#endif
+
 #endif /* ZSTD_PORTABILITY_MACROS_H */
diff --git a/lib/zstd/common/zstd_common.c b/lib/zstd/common/zstd_common.c
index 17df097dcd5d..23a89bdb7aaf 100644
--- a/lib/zstd/common/zstd_common.c
+++ b/lib/zstd/common/zstd_common.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -12,7 +13,6 @@
 *  Dependencies
 ***************************************/
 #define ZSTD_DEPS_NEED_MALLOC
-#include "zstd_deps.h"   /* ZSTD_malloc, ZSTD_calloc, ZSTD_free, ZSTD_mems=
et */
 #include "error_private.h"
 #include "zstd_internal.h"
=20
@@ -43,35 +43,3 @@ ZSTD_ErrorCode ZSTD_getErrorCode(size_t code) { return E=
RR_getErrorCode(code); }
 /*! ZSTD_getErrorString() :
  *  provides error code string from enum */
 const char* ZSTD_getErrorString(ZSTD_ErrorCode code) { return ERR_getError=
String(code); }
-
-/*=3D**************************************************************
-*  Custom allocator
-****************************************************************/
-void* ZSTD_customMalloc(size_t size, ZSTD_customMem customMem)
-{
-    if (customMem.customAlloc)
-        return customMem.customAlloc(customMem.opaque, size);
-    return ZSTD_malloc(size);
-}
-
-void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
-{
-    if (customMem.customAlloc) {
-        /* calloc implemented as malloc+memset;
-         * not as efficient as calloc, but next best guess for custom mall=
oc */
-        void* const ptr =3D customMem.customAlloc(customMem.opaque, size);
-        ZSTD_memset(ptr, 0, size);
-        return ptr;
-    }
-    return ZSTD_calloc(1, size);
-}
-
-void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
-{
-    if (ptr!=3DNULL) {
-        if (customMem.customFree)
-            customMem.customFree(customMem.opaque, ptr);
-        else
-            ZSTD_free(ptr);
-    }
-}
diff --git a/lib/zstd/common/zstd_deps.h b/lib/zstd/common/zstd_deps.h
index e45ec5668319..00289d82e8f0 100644
--- a/lib/zstd/common/zstd_deps.h
+++ b/lib/zstd/common/zstd_deps.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -84,7 +84,7 @@ static uint64_t ZSTD_div64(uint64_t dividend, uint32_t di=
visor) {
=20
 #include <linux/kernel.h>
=20
-#define assert(x) WARN_ON((x))
+#define assert(x) WARN_ON(!(x))
=20
 #endif /* ZSTD_DEPS_ASSERT */
 #endif /* ZSTD_DEPS_NEED_ASSERT */
@@ -115,11 +115,7 @@ static uint64_t ZSTD_div64(uint64_t dividend, uint32_t=
 divisor) {
 #ifndef ZSTD_DEPS_STDINT
 #define ZSTD_DEPS_STDINT
=20
-/*
- * The Linux Kernel doesn't provide intptr_t, only uintptr_t, which
- * is an unsigned long.
- */
-typedef long intptr_t;
+/* intptr_t already provided by ZSTD_DEPS_COMMON */
=20
 #endif /* ZSTD_DEPS_STDINT */
 #endif /* ZSTD_DEPS_NEED_STDINT */
diff --git a/lib/zstd/common/zstd_internal.h b/lib/zstd/common/zstd_interna=
l.h
index c575c1fe8f47..e6ffb6e83826 100644
--- a/lib/zstd/common/zstd_internal.h
+++ b/lib/zstd/common/zstd_internal.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -28,7 +29,6 @@
 #include <linux/zstd.h>
 #define FSE_STATIC_LINKING_ONLY
 #include "fse.h"
-#define HUF_STATIC_LINKING_ONLY
 #include "huf.h"
 #include <linux/xxhash.h>                /* XXH_reset, update, digest */
 #define ZSTD_TRACE 0
@@ -80,16 +80,17 @@ typedef enum { bt_raw, bt_rle, bt_compressed, bt_reserv=
ed } blockType_e;
 #define ZSTD_FRAMECHECKSUMSIZE 4
=20
 #define MIN_SEQUENCES_SIZE 1 /* nbSeq=3D=3D0 */
-#define MIN_CBLOCK_SIZE (1 /*litCSize*/ + 1 /* RLE or RAW */ + MIN_SEQUENC=
ES_SIZE /* nbSeq=3D=3D0 */)   /* for a non-null block */
+#define MIN_CBLOCK_SIZE (1 /*litCSize*/ + 1 /* RLE or RAW */)   /* for a n=
on-null block */
+#define MIN_LITERALS_FOR_4_STREAMS 6
=20
-#define HufLog 12
-typedef enum { set_basic, set_rle, set_compressed, set_repeat } symbolEnco=
dingType_e;
+typedef enum { set_basic, set_rle, set_compressed, set_repeat } SymbolEnco=
dingType_e;
=20
 #define LONGNBSEQ 0x7F00
=20
 #define MINMATCH 3
=20
 #define Litbits  8
+#define LitHufLog 11
 #define MaxLit ((1<<Litbits) - 1)
 #define MaxML   52
 #define MaxLL   35
@@ -100,6 +101,8 @@ typedef enum { set_basic, set_rle, set_compressed, set_=
repeat } symbolEncodingTy
 #define LLFSELog    9
 #define OffFSELog   8
 #define MaxFSELog  MAX(MAX(MLFSELog, LLFSELog), OffFSELog)
+#define MaxMLBits 16
+#define MaxLLBits 16
=20
 #define ZSTD_MAX_HUF_HEADER_SIZE 128 /* header + <=3D 127 byte tree descri=
ption */
 /* Each table cannot take more than #symbols * FSELog bits */
@@ -162,7 +165,7 @@ static void ZSTD_copy8(void* dst, const void* src) {
     ZSTD_memcpy(dst, src, 8);
 #endif
 }
-#define COPY8(d,s) { ZSTD_copy8(d,s); d+=3D8; s+=3D8; }
+#define COPY8(d,s) do { ZSTD_copy8(d,s); d+=3D8; s+=3D8; } while (0)
=20
 /* Need to use memmove here since the literal buffer can now be located wi=
thin
    the dst buffer. In circumstances where the op "catches up" to where the
@@ -182,7 +185,7 @@ static void ZSTD_copy16(void* dst, const void* src) {
     ZSTD_memcpy(dst, copy16_buf, 16);
 #endif
 }
-#define COPY16(d,s) { ZSTD_copy16(d,s); d+=3D16; s+=3D16; }
+#define COPY16(d,s) do { ZSTD_copy16(d,s); d+=3D16; s+=3D16; } while (0)
=20
 #define WILDCOPY_OVERLENGTH 32
 #define WILDCOPY_VECLEN 16
@@ -211,7 +214,7 @@ void ZSTD_wildcopy(void* dst, const void* src, ptrdiff_=
t length, ZSTD_overlap_e
     if (ovtype =3D=3D ZSTD_overlap_src_before_dst && diff < WILDCOPY_VECLE=
N) {
         /* Handle short offset copies. */
         do {
-            COPY8(op, ip)
+            COPY8(op, ip);
         } while (op < oend);
     } else {
         assert(diff >=3D WILDCOPY_VECLEN || diff <=3D -WILDCOPY_VECLEN);
@@ -221,12 +224,6 @@ void ZSTD_wildcopy(void* dst, const void* src, ptrdiff=
_t length, ZSTD_overlap_e
          * one COPY16() in the first call. Then, do two calls per loop sin=
ce
          * at that point it is more likely to have a high trip count.
          */
-#ifdef __aarch64__
-        do {
-            COPY16(op, ip);
-        }
-        while (op < oend);
-#else
         ZSTD_copy16(op, ip);
         if (16 >=3D length) return;
         op +=3D 16;
@@ -236,7 +233,6 @@ void ZSTD_wildcopy(void* dst, const void* src, ptrdiff_=
t length, ZSTD_overlap_e
             COPY16(op, ip);
         }
         while (op < oend);
-#endif
     }
 }
=20
@@ -268,62 +264,6 @@ typedef enum {
 /*-*******************************************
 *  Private declarations
 *********************************************/
-typedef struct seqDef_s {
-    U32 offBase;   /* offBase =3D=3D Offset + ZSTD_REP_NUM, or repcode 1,2=
,3 */
-    U16 litLength;
-    U16 mlBase;    /* mlBase =3D=3D matchLength - MINMATCH */
-} seqDef;
-
-/* Controls whether seqStore has a single "long" litLength or matchLength.=
 See seqStore_t. */
-typedef enum {
-    ZSTD_llt_none =3D 0,             /* no longLengthType */
-    ZSTD_llt_literalLength =3D 1,    /* represents a long literal */
-    ZSTD_llt_matchLength =3D 2       /* represents a long match */
-} ZSTD_longLengthType_e;
-
-typedef struct {
-    seqDef* sequencesStart;
-    seqDef* sequences;      /* ptr to end of sequences */
-    BYTE* litStart;
-    BYTE* lit;              /* ptr to end of literals */
-    BYTE* llCode;
-    BYTE* mlCode;
-    BYTE* ofCode;
-    size_t maxNbSeq;
-    size_t maxNbLit;
-
-    /* longLengthPos and longLengthType to allow us to represent either a =
single litLength or matchLength
-     * in the seqStore that has a value larger than U16 (if it exists). To=
 do so, we increment
-     * the existing value of the litLength or matchLength by 0x10000.
-     */
-    ZSTD_longLengthType_e   longLengthType;
-    U32                     longLengthPos;  /* Index of the sequence to ap=
ply long length modification to */
-} seqStore_t;
-
-typedef struct {
-    U32 litLength;
-    U32 matchLength;
-} ZSTD_sequenceLength;
-
-/*
- * Returns the ZSTD_sequenceLength for the given sequences. It handles the=
 decoding of long sequences
- * indicated by longLengthPos and longLengthType, and adds MINMATCH back t=
o matchLength.
- */
-MEM_STATIC ZSTD_sequenceLength ZSTD_getSequenceLength(seqStore_t const* se=
qStore, seqDef const* seq)
-{
-    ZSTD_sequenceLength seqLen;
-    seqLen.litLength =3D seq->litLength;
-    seqLen.matchLength =3D seq->mlBase + MINMATCH;
-    if (seqStore->longLengthPos =3D=3D (U32)(seq - seqStore->sequencesStar=
t)) {
-        if (seqStore->longLengthType =3D=3D ZSTD_llt_literalLength) {
-            seqLen.litLength +=3D 0xFFFF;
-        }
-        if (seqStore->longLengthType =3D=3D ZSTD_llt_matchLength) {
-            seqLen.matchLength +=3D 0xFFFF;
-        }
-    }
-    return seqLen;
-}
=20
 /*
  * Contains the compressed frame size and an upper-bound for the decompres=
sed frame size.
@@ -332,72 +272,11 @@ MEM_STATIC ZSTD_sequenceLength ZSTD_getSequenceLength=
(seqStore_t const* seqStore
  *          `decompressedBound !=3D ZSTD_CONTENTSIZE_ERROR`
  */
 typedef struct {
+    size_t nbBlocks;
     size_t compressedSize;
     unsigned long long decompressedBound;
 } ZSTD_frameSizeInfo;   /* decompress & legacy */
=20
-const seqStore_t* ZSTD_getSeqStore(const ZSTD_CCtx* ctx);   /* compress & =
dictBuilder */
-void ZSTD_seqToCodes(const seqStore_t* seqStorePtr);   /* compress, dictBu=
ilder, decodeCorpus (shouldn't get its definition from here) */
-
-/* custom memory allocation functions */
-void* ZSTD_customMalloc(size_t size, ZSTD_customMem customMem);
-void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem);
-void ZSTD_customFree(void* ptr, ZSTD_customMem customMem);
-
-MEM_STATIC U32 ZSTD_highbit32(U32 val)   /* compress, dictBuilder, decodeC=
orpus */
-{
-    assert(val !=3D 0);
-    {
-#   if (__GNUC__ >=3D 3)   /* GCC Intrinsic */
-        return __builtin_clz (val) ^ 31;
-#   else   /* Software version */
-        static const U32 DeBruijnClz[32] =3D { 0, 9, 1, 10, 13, 21, 2, 29,=
 11, 14, 16, 18, 22, 25, 3, 30, 8, 12, 20, 28, 15, 17, 24, 7, 19, 27, 23, 6=
, 26, 5, 4, 31 };
-        U32 v =3D val;
-        v |=3D v >> 1;
-        v |=3D v >> 2;
-        v |=3D v >> 4;
-        v |=3D v >> 8;
-        v |=3D v >> 16;
-        return DeBruijnClz[(v * 0x07C4ACDDU) >> 27];
-#   endif
-    }
-}
-
-/*
- * Counts the number of trailing zeros of a `size_t`.
- * Most compilers should support CTZ as a builtin. A backup
- * implementation is provided if the builtin isn't supported, but
- * it may not be terribly efficient.
- */
-MEM_STATIC unsigned ZSTD_countTrailingZeros(size_t val)
-{
-    if (MEM_64bits()) {
-#       if (__GNUC__ >=3D 4)
-            return __builtin_ctzll((U64)val);
-#       else
-            static const int DeBruijnBytePos[64] =3D {  0,  1,  2,  7,  3,=
 13,  8, 19,
-                                                      4, 25, 14, 28,  9, 3=
4, 20, 56,
-                                                      5, 17, 26, 54, 15, 4=
1, 29, 43,
-                                                      10, 31, 38, 35, 21, =
45, 49, 57,
-                                                      63,  6, 12, 18, 24, =
27, 33, 55,
-                                                      16, 53, 40, 42, 30, =
37, 44, 48,
-                                                      62, 11, 23, 32, 52, =
39, 36, 47,
-                                                      61, 22, 51, 46, 60, =
50, 59, 58 };
-            return DeBruijnBytePos[((U64)((val & -(long long)val) * 0x0218=
A392CDABBD3FULL)) >> 58];
-#       endif
-    } else { /* 32 bits */
-#       if (__GNUC__ >=3D 3)
-            return __builtin_ctz((U32)val);
-#       else
-            static const int DeBruijnBytePos[32] =3D {  0,  1, 28,  2, 29,=
 14, 24,  3,
-                                                     30, 22, 20, 15, 25, 1=
7,  4,  8,
-                                                     31, 27, 13, 23, 21, 1=
9, 16,  7,
-                                                     26, 12, 18,  6, 11,  =
5, 10,  9 };
-            return DeBruijnBytePos[((U32)((val & -(S32)val) * 0x077CB531U)=
) >> 27];
-#       endif
-    }
-}
-
 /* ZSTD_invalidateRepCodes() :
  * ensures next compression will not use repcodes from previous block.
  * Note : only works with regular variant;
@@ -412,13 +291,13 @@ typedef struct {
=20
 /*! ZSTD_getcBlockSize() :
  *  Provides the size of compressed block from block header `src` */
-/* Used by: decompress, fullbench (does not get its definition from here) =
*/
+/*  Used by: decompress, fullbench */
 size_t ZSTD_getcBlockSize(const void* src, size_t srcSize,
                           blockProperties_t* bpPtr);
=20
 /*! ZSTD_decodeSeqHeaders() :
  *  decode sequence header from src */
-/* Used by: decompress, fullbench (does not get its definition from here) =
*/
+/*  Used by: zstd_decompress_block, fullbench */
 size_t ZSTD_decodeSeqHeaders(ZSTD_DCtx* dctx, int* nbSeqPtr,
                        const void* src, size_t srcSize);
=20
diff --git a/lib/zstd/decompress/huf_decompress.c b/lib/zstd/decompress/huf=
_decompress.c
index e2d473ad4e86..cfaa6e9eff70 100644
--- a/lib/zstd/decompress/huf_decompress.c
+++ b/lib/zstd/decompress/huf_decompress.c
@@ -1,7 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /* ******************************************************************
  * huff0 huffman decoder,
  * part of Finite State Entropy library
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  *
  *  You can contact the author at :
  *  - FSE+HUF source repository : https://github.com/Cyan4973/FiniteStateE=
ntropy
@@ -19,10 +20,10 @@
 #include "../common/compiler.h"
 #include "../common/bitstream.h"  /* BIT_* */
 #include "../common/fse.h"        /* to compress headers */
-#define HUF_STATIC_LINKING_ONLY
 #include "../common/huf.h"
 #include "../common/error_private.h"
 #include "../common/zstd_internal.h"
+#include "../common/bits.h"       /* ZSTD_highbit32, ZSTD_countTrailingZer=
os64 */
=20
 /* **************************************************************
 *  Constants
@@ -34,6 +35,12 @@
 *  Macros
 ****************************************************************/
=20
+#ifdef HUF_DISABLE_FAST_DECODE
+# define HUF_ENABLE_FAST_DECODE 0
+#else
+# define HUF_ENABLE_FAST_DECODE 1
+#endif
+
 /* These two optional macros force the use one way or another of the two
  * Huffman decompression implementations. You can't force in both directio=
ns
  * at the same time.
@@ -43,27 +50,25 @@
 #error "Cannot force the use of the X1 and X2 decoders at the same time!"
 #endif
=20
-#if ZSTD_ENABLE_ASM_X86_64_BMI2 && DYNAMIC_BMI2
-# define HUF_ASM_X86_64_BMI2_ATTRS BMI2_TARGET_ATTRIBUTE
+/* When DYNAMIC_BMI2 is enabled, fast decoders are only called when bmi2 i=
s
+ * supported at runtime, so we can add the BMI2 target attribute.
+ * When it is disabled, we will still get BMI2 if it is enabled statically=
.
+ */
+#if DYNAMIC_BMI2
+# define HUF_FAST_BMI2_ATTRS BMI2_TARGET_ATTRIBUTE
 #else
-# define HUF_ASM_X86_64_BMI2_ATTRS
+# define HUF_FAST_BMI2_ATTRS
 #endif
=20
 #define HUF_EXTERN_C
 #define HUF_ASM_DECL HUF_EXTERN_C
=20
-#if DYNAMIC_BMI2 || (ZSTD_ENABLE_ASM_X86_64_BMI2 && defined(__BMI2__))
+#if DYNAMIC_BMI2
 # define HUF_NEED_BMI2_FUNCTION 1
 #else
 # define HUF_NEED_BMI2_FUNCTION 0
 #endif
=20
-#if !(ZSTD_ENABLE_ASM_X86_64_BMI2 && defined(__BMI2__))
-# define HUF_NEED_DEFAULT_FUNCTION 1
-#else
-# define HUF_NEED_DEFAULT_FUNCTION 0
-#endif
-
 /* **************************************************************
 *  Error Management
 ****************************************************************/
@@ -78,6 +83,11 @@
 /* **************************************************************
 *  BMI2 Variant Wrappers
 ****************************************************************/
+typedef size_t (*HUF_DecompressUsingDTableFn)(void *dst, size_t dstSize,
+                                              const void *cSrc,
+                                              size_t cSrcSize,
+                                              const HUF_DTable *DTable);
+
 #if DYNAMIC_BMI2
=20
 #define HUF_DGEN(fn)                                                      =
  \
@@ -99,9 +109,9 @@
     }                                                                     =
  \
                                                                           =
  \
     static size_t fn(void* dst, size_t dstSize, void const* cSrc,         =
  \
-                     size_t cSrcSize, HUF_DTable const* DTable, int bmi2) =
  \
+                     size_t cSrcSize, HUF_DTable const* DTable, int flags)=
  \
     {                                                                     =
  \
-        if (bmi2) {                                                       =
  \
+        if (flags & HUF_flags_bmi2) {                                     =
  \
             return fn##_bmi2(dst, dstSize, cSrc, cSrcSize, DTable);       =
  \
         }                                                                 =
  \
         return fn##_default(dst, dstSize, cSrc, cSrcSize, DTable);        =
  \
@@ -111,9 +121,9 @@
=20
 #define HUF_DGEN(fn)                                                      =
  \
     static size_t fn(void* dst, size_t dstSize, void const* cSrc,         =
  \
-                     size_t cSrcSize, HUF_DTable const* DTable, int bmi2) =
  \
+                     size_t cSrcSize, HUF_DTable const* DTable, int flags)=
  \
     {                                                                     =
  \
-        (void)bmi2;                                                       =
  \
+        (void)flags;                                                      =
  \
         return fn##_body(dst, dstSize, cSrc, cSrcSize, DTable);           =
  \
     }
=20
@@ -131,43 +141,65 @@ static DTableDesc HUF_getDTableDesc(const HUF_DTable*=
 table)
     return dtd;
 }
=20
-#if ZSTD_ENABLE_ASM_X86_64_BMI2
-
-static size_t HUF_initDStream(BYTE const* ip) {
+static size_t HUF_initFastDStream(BYTE const* ip) {
     BYTE const lastByte =3D ip[7];
-    size_t const bitsConsumed =3D lastByte ? 8 - BIT_highbit32(lastByte) :=
 0;
+    size_t const bitsConsumed =3D lastByte ? 8 - ZSTD_highbit32(lastByte) =
: 0;
     size_t const value =3D MEM_readLEST(ip) | 1;
     assert(bitsConsumed <=3D 8);
+    assert(sizeof(size_t) =3D=3D 8);
     return value << bitsConsumed;
 }
+
+/*
+ * The input/output arguments to the Huffman fast decoding loop:
+ *
+ * ip [in/out] - The input pointers, must be updated to reflect what is co=
nsumed.
+ * op [in/out] - The output pointers, must be updated to reflect what is w=
ritten.
+ * bits [in/out] - The bitstream containers, must be updated to reflect th=
e current state.
+ * dt [in] - The decoding table.
+ * ilowest [in] - The beginning of the valid range of the input. Decoders =
may read
+ *                down to this pointer. It may be below iend[0].
+ * oend [in] - The end of the output stream. op[3] must not cross oend.
+ * iend [in] - The end of each input stream. ip[i] may cross iend[i],
+ *             as long as it is above ilowest, but that indicates corrupti=
on.
+ */
 typedef struct {
     BYTE const* ip[4];
     BYTE* op[4];
     U64 bits[4];
     void const* dt;
-    BYTE const* ilimit;
+    BYTE const* ilowest;
     BYTE* oend;
     BYTE const* iend[4];
-} HUF_DecompressAsmArgs;
+} HUF_DecompressFastArgs;
+
+typedef void (*HUF_DecompressFastLoopFn)(HUF_DecompressFastArgs*);
=20
 /*
- * Initializes args for the asm decoding loop.
- * @returns 0 on success
- *          1 if the fallback implementation should be used.
+ * Initializes args for the fast decoding loop.
+ * @returns 1 on success
+ *          0 if the fallback implementation should be used.
  *          Or an error code on failure.
  */
-static size_t HUF_DecompressAsmArgs_init(HUF_DecompressAsmArgs* args, void=
* dst, size_t dstSize, void const* src, size_t srcSize, const HUF_DTable* D=
Table)
+static size_t HUF_DecompressFastArgs_init(HUF_DecompressFastArgs* args, vo=
id* dst, size_t dstSize, void const* src, size_t srcSize, const HUF_DTable*=
 DTable)
 {
     void const* dt =3D DTable + 1;
     U32 const dtLog =3D HUF_getDTableDesc(DTable).tableLog;
=20
-    const BYTE* const ilimit =3D (const BYTE*)src + 6 + 8;
+    const BYTE* const istart =3D (const BYTE*)src;
=20
-    BYTE* const oend =3D (BYTE*)dst + dstSize;
+    BYTE* const oend =3D ZSTD_maybeNullPtrAdd((BYTE*)dst, dstSize);
=20
-    /* The following condition is false on x32 platform,
-     * but HUF_asm is not compatible with this ABI */
-    if (!(MEM_isLittleEndian() && !MEM_32bits())) return 1;
+    /* The fast decoding loop assumes 64-bit little-endian.
+     * This condition is false on x32.
+     */
+    if (!MEM_isLittleEndian() || MEM_32bits())
+        return 0;
+
+    /* Avoid nullptr addition */
+    if (dstSize =3D=3D 0)
+        return 0;
+    assert(dst !=3D NULL);
=20
     /* strict minimum : jump table + 1 byte per stream */
     if (srcSize < 10)
@@ -178,11 +210,10 @@ static size_t HUF_DecompressAsmArgs_init(HUF_Decompre=
ssAsmArgs* args, void* dst,
      * On small inputs we don't have enough data to trigger the fast loop,=
 so use the old decoder.
      */
     if (dtLog !=3D HUF_DECODER_FAST_TABLELOG)
-        return 1;
+        return 0;
=20
     /* Read the jump table. */
     {
-        const BYTE* const istart =3D (const BYTE*)src;
         size_t const length1 =3D MEM_readLE16(istart);
         size_t const length2 =3D MEM_readLE16(istart+2);
         size_t const length3 =3D MEM_readLE16(istart+4);
@@ -192,13 +223,11 @@ static size_t HUF_DecompressAsmArgs_init(HUF_Decompre=
ssAsmArgs* args, void* dst,
         args->iend[2] =3D args->iend[1] + length2;
         args->iend[3] =3D args->iend[2] + length3;
=20
-        /* HUF_initDStream() requires this, and this small of an input
+        /* HUF_initFastDStream() requires this, and this small of an input
          * won't benefit from the ASM loop anyways.
-         * length1 must be >=3D 16 so that ip[0] >=3D ilimit before the lo=
op
-         * starts.
          */
-        if (length1 < 16 || length2 < 8 || length3 < 8 || length4 < 8)
-            return 1;
+        if (length1 < 8 || length2 < 8 || length3 < 8 || length4 < 8)
+            return 0;
         if (length4 > srcSize) return ERROR(corruption_detected);   /* ove=
rflow */
     }
     /* ip[] contains the position that is currently loaded into bits[]. */
@@ -215,7 +244,7 @@ static size_t HUF_DecompressAsmArgs_init(HUF_Decompress=
AsmArgs* args, void* dst,
=20
     /* No point to call the ASM loop for tiny outputs. */
     if (args->op[3] >=3D oend)
-        return 1;
+        return 0;
=20
     /* bits[] is the bit container.
         * It is read from the MSB down to the LSB.
@@ -224,24 +253,25 @@ static size_t HUF_DecompressAsmArgs_init(HUF_Decompre=
ssAsmArgs* args, void* dst,
         * set, so that CountTrailingZeros(bits[]) can be used
         * to count how many bits we've consumed.
         */
-    args->bits[0] =3D HUF_initDStream(args->ip[0]);
-    args->bits[1] =3D HUF_initDStream(args->ip[1]);
-    args->bits[2] =3D HUF_initDStream(args->ip[2]);
-    args->bits[3] =3D HUF_initDStream(args->ip[3]);
-
-    /* If ip[] >=3D ilimit, it is guaranteed to be safe to
-        * reload bits[]. It may be beyond its section, but is
-        * guaranteed to be valid (>=3D istart).
-        */
-    args->ilimit =3D ilimit;
+    args->bits[0] =3D HUF_initFastDStream(args->ip[0]);
+    args->bits[1] =3D HUF_initFastDStream(args->ip[1]);
+    args->bits[2] =3D HUF_initFastDStream(args->ip[2]);
+    args->bits[3] =3D HUF_initFastDStream(args->ip[3]);
+
+    /* The decoders must be sure to never read beyond ilowest.
+     * This is lower than iend[0], but allowing decoders to read
+     * down to ilowest can allow an extra iteration or two in the
+     * fast loop.
+     */
+    args->ilowest =3D istart;
=20
     args->oend =3D oend;
     args->dt =3D dt;
=20
-    return 0;
+    return 1;
 }
=20
-static size_t HUF_initRemainingDStream(BIT_DStream_t* bit, HUF_DecompressA=
smArgs const* args, int stream, BYTE* segmentEnd)
+static size_t HUF_initRemainingDStream(BIT_DStream_t* bit, HUF_DecompressF=
astArgs const* args, int stream, BYTE* segmentEnd)
 {
     /* Validate that we haven't overwritten. */
     if (args->op[stream] > segmentEnd)
@@ -255,15 +285,33 @@ static size_t HUF_initRemainingDStream(BIT_DStream_t*=
 bit, HUF_DecompressAsmArgs
         return ERROR(corruption_detected);
=20
     /* Construct the BIT_DStream_t. */
-    bit->bitContainer =3D MEM_readLE64(args->ip[stream]);
-    bit->bitsConsumed =3D ZSTD_countTrailingZeros((size_t)args->bits[strea=
m]);
-    bit->start =3D (const char*)args->iend[0];
+    assert(sizeof(size_t) =3D=3D 8);
+    bit->bitContainer =3D MEM_readLEST(args->ip[stream]);
+    bit->bitsConsumed =3D ZSTD_countTrailingZeros64(args->bits[stream]);
+    bit->start =3D (const char*)args->ilowest;
     bit->limitPtr =3D bit->start + sizeof(size_t);
     bit->ptr =3D (const char*)args->ip[stream];
=20
     return 0;
 }
-#endif
+
+/* Calls X(N) for each stream 0, 1, 2, 3. */
+#define HUF_4X_FOR_EACH_STREAM(X) \
+    do {                          \
+        X(0);                     \
+        X(1);                     \
+        X(2);                     \
+        X(3);                     \
+    } while (0)
+
+/* Calls X(N, var) for each stream 0, 1, 2, 3. */
+#define HUF_4X_FOR_EACH_STREAM_WITH_VAR(X, var) \
+    do {                                        \
+        X(0, (var));                            \
+        X(1, (var));                            \
+        X(2, (var));                            \
+        X(3, (var));                            \
+    } while (0)
=20
 #ifndef HUF_FORCE_DECOMPRESS_X2
=20
@@ -279,10 +327,11 @@ typedef struct { BYTE nbBits; BYTE byte; } HUF_DEltX1=
;   /* single-symbol decodi
 static U64 HUF_DEltX1_set4(BYTE symbol, BYTE nbBits) {
     U64 D4;
     if (MEM_isLittleEndian()) {
-        D4 =3D (symbol << 8) + nbBits;
+        D4 =3D (U64)((symbol << 8) + nbBits);
     } else {
-        D4 =3D symbol + (nbBits << 8);
+        D4 =3D (U64)(symbol + (nbBits << 8));
     }
+    assert(D4 < (1U << 16));
     D4 *=3D 0x0001000100010001ULL;
     return D4;
 }
@@ -325,12 +374,7 @@ typedef struct {
         BYTE huffWeight[HUF_SYMBOLVALUE_MAX + 1];
 } HUF_ReadDTableX1_Workspace;
=20
-size_t HUF_readDTableX1_wksp(HUF_DTable* DTable, const void* src, size_t s=
rcSize, void* workSpace, size_t wkspSize)
-{
-    return HUF_readDTableX1_wksp_bmi2(DTable, src, srcSize, workSpace, wks=
pSize, /* bmi2 */ 0);
-}
-
-size_t HUF_readDTableX1_wksp_bmi2(HUF_DTable* DTable, const void* src, siz=
e_t srcSize, void* workSpace, size_t wkspSize, int bmi2)
+size_t HUF_readDTableX1_wksp(HUF_DTable* DTable, const void* src, size_t s=
rcSize, void* workSpace, size_t wkspSize, int flags)
 {
     U32 tableLog =3D 0;
     U32 nbSymbols =3D 0;
@@ -345,7 +389,7 @@ size_t HUF_readDTableX1_wksp_bmi2(HUF_DTable* DTable, c=
onst void* src, size_t sr
     DEBUG_STATIC_ASSERT(sizeof(DTableDesc) =3D=3D sizeof(HUF_DTable));
     /* ZSTD_memset(huffWeight, 0, sizeof(huffWeight)); */   /* is not nece=
ssary, even though some analyzer complain ... */
=20
-    iSize =3D HUF_readStats_wksp(wksp->huffWeight, HUF_SYMBOLVALUE_MAX + 1=
, wksp->rankVal, &nbSymbols, &tableLog, src, srcSize, wksp->statsWksp, size=
of(wksp->statsWksp), bmi2);
+    iSize =3D HUF_readStats_wksp(wksp->huffWeight, HUF_SYMBOLVALUE_MAX + 1=
, wksp->rankVal, &nbSymbols, &tableLog, src, srcSize, wksp->statsWksp, size=
of(wksp->statsWksp), flags);
     if (HUF_isError(iSize)) return iSize;
=20
     /* Table header */
@@ -371,9 +415,8 @@ size_t HUF_readDTableX1_wksp_bmi2(HUF_DTable* DTable, c=
onst void* src, size_t sr
      * rankStart[0] is not filled because there are no entries in the tabl=
e for
      * weight 0.
      */
-    {
-        int n;
-        int nextRankStart =3D 0;
+    {   int n;
+        U32 nextRankStart =3D 0;
         int const unroll =3D 4;
         int const nLimit =3D (int)nbSymbols - unroll + 1;
         for (n=3D0; n<(int)tableLog+1; n++) {
@@ -400,10 +443,9 @@ size_t HUF_readDTableX1_wksp_bmi2(HUF_DTable* DTable, =
const void* src, size_t sr
      * We can switch based on the length to a different inner loop which i=
s
      * optimized for that particular case.
      */
-    {
-        U32 w;
-        int symbol=3Dwksp->rankVal[0];
-        int rankStart=3D0;
+    {   U32 w;
+        int symbol =3D wksp->rankVal[0];
+        int rankStart =3D 0;
         for (w=3D1; w<tableLog+1; ++w) {
             int const symbolCount =3D wksp->rankVal[w];
             int const length =3D (1 << w) >> 1;
@@ -477,15 +519,19 @@ HUF_decodeSymbolX1(BIT_DStream_t* Dstream, const HUF_=
DEltX1* dt, const U32 dtLog
 }
=20
 #define HUF_DECODE_SYMBOLX1_0(ptr, DStreamPtr) \
-    *ptr++ =3D HUF_decodeSymbolX1(DStreamPtr, dt, dtLog)
+    do { *ptr++ =3D HUF_decodeSymbolX1(DStreamPtr, dt, dtLog); } while (0)
=20
-#define HUF_DECODE_SYMBOLX1_1(ptr, DStreamPtr)  \
-    if (MEM_64bits() || (HUF_TABLELOG_MAX<=3D12)) \
-        HUF_DECODE_SYMBOLX1_0(ptr, DStreamPtr)
+#define HUF_DECODE_SYMBOLX1_1(ptr, DStreamPtr)      \
+    do {                                            \
+        if (MEM_64bits() || (HUF_TABLELOG_MAX<=3D12)) \
+            HUF_DECODE_SYMBOLX1_0(ptr, DStreamPtr); \
+    } while (0)
=20
-#define HUF_DECODE_SYMBOLX1_2(ptr, DStreamPtr) \
-    if (MEM_64bits()) \
-        HUF_DECODE_SYMBOLX1_0(ptr, DStreamPtr)
+#define HUF_DECODE_SYMBOLX1_2(ptr, DStreamPtr)      \
+    do {                                            \
+        if (MEM_64bits())                           \
+            HUF_DECODE_SYMBOLX1_0(ptr, DStreamPtr); \
+    } while (0)
=20
 HINT_INLINE size_t
 HUF_decodeStreamX1(BYTE* p, BIT_DStream_t* const bitDPtr, BYTE* const pEnd=
, const HUF_DEltX1* const dt, const U32 dtLog)
@@ -513,7 +559,7 @@ HUF_decodeStreamX1(BYTE* p, BIT_DStream_t* const bitDPt=
r, BYTE* const pEnd, cons
     while (p < pEnd)
         HUF_DECODE_SYMBOLX1_0(p, bitDPtr);
=20
-    return pEnd-pStart;
+    return (size_t)(pEnd-pStart);
 }
=20
 FORCE_INLINE_TEMPLATE size_t
@@ -523,7 +569,7 @@ HUF_decompress1X1_usingDTable_internal_body(
     const HUF_DTable* DTable)
 {
     BYTE* op =3D (BYTE*)dst;
-    BYTE* const oend =3D op + dstSize;
+    BYTE* const oend =3D ZSTD_maybeNullPtrAdd(op, dstSize);
     const void* dtPtr =3D DTable + 1;
     const HUF_DEltX1* const dt =3D (const HUF_DEltX1*)dtPtr;
     BIT_DStream_t bitD;
@@ -539,6 +585,10 @@ HUF_decompress1X1_usingDTable_internal_body(
     return dstSize;
 }
=20
+/* HUF_decompress4X1_usingDTable_internal_body():
+ * Conditions :
+ * @dstSize >=3D 6
+ */
 FORCE_INLINE_TEMPLATE size_t
 HUF_decompress4X1_usingDTable_internal_body(
           void* dst,  size_t dstSize,
@@ -547,6 +597,7 @@ HUF_decompress4X1_usingDTable_internal_body(
 {
     /* Check */
     if (cSrcSize < 10) return ERROR(corruption_detected);  /* strict minim=
um : jump table + 1 byte per stream */
+    if (dstSize < 6) return ERROR(corruption_detected);         /* stream =
4-split doesn't work */
=20
     {   const BYTE* const istart =3D (const BYTE*) cSrc;
         BYTE* const ostart =3D (BYTE*) dst;
@@ -582,6 +633,7 @@ HUF_decompress4X1_usingDTable_internal_body(
=20
         if (length4 > cSrcSize) return ERROR(corruption_detected);   /* ov=
erflow */
         if (opStart4 > oend) return ERROR(corruption_detected);      /* ov=
erflow */
+        assert(dstSize >=3D 6); /* validated above */
         CHECK_F( BIT_initDStream(&bitD1, istart1, length1) );
         CHECK_F( BIT_initDStream(&bitD2, istart2, length2) );
         CHECK_F( BIT_initDStream(&bitD3, istart3, length3) );
@@ -644,52 +696,173 @@ size_t HUF_decompress4X1_usingDTable_internal_bmi2(v=
oid* dst, size_t dstSize, vo
 }
 #endif
=20
-#if HUF_NEED_DEFAULT_FUNCTION
 static
 size_t HUF_decompress4X1_usingDTable_internal_default(void* dst, size_t ds=
tSize, void const* cSrc,
                     size_t cSrcSize, HUF_DTable const* DTable) {
     return HUF_decompress4X1_usingDTable_internal_body(dst, dstSize, cSrc,=
 cSrcSize, DTable);
 }
-#endif
=20
 #if ZSTD_ENABLE_ASM_X86_64_BMI2
=20
-HUF_ASM_DECL void HUF_decompress4X1_usingDTable_internal_bmi2_asm_loop(HUF=
_DecompressAsmArgs* args) ZSTDLIB_HIDDEN;
+HUF_ASM_DECL void HUF_decompress4X1_usingDTable_internal_fast_asm_loop(HUF=
_DecompressFastArgs* args) ZSTDLIB_HIDDEN;
+
+#endif
+
+static HUF_FAST_BMI2_ATTRS
+void HUF_decompress4X1_usingDTable_internal_fast_c_loop(HUF_DecompressFast=
Args* args)
+{
+    U64 bits[4];
+    BYTE const* ip[4];
+    BYTE* op[4];
+    U16 const* const dtable =3D (U16 const*)args->dt;
+    BYTE* const oend =3D args->oend;
+    BYTE const* const ilowest =3D args->ilowest;
+
+    /* Copy the arguments to local variables */
+    ZSTD_memcpy(&bits, &args->bits, sizeof(bits));
+    ZSTD_memcpy((void*)(&ip), &args->ip, sizeof(ip));
+    ZSTD_memcpy(&op, &args->op, sizeof(op));
+
+    assert(MEM_isLittleEndian());
+    assert(!MEM_32bits());
+
+    for (;;) {
+        BYTE* olimit;
+        int stream;
+
+        /* Assert loop preconditions */
+#ifndef NDEBUG
+        for (stream =3D 0; stream < 4; ++stream) {
+            assert(op[stream] <=3D (stream =3D=3D 3 ? oend : op[stream + 1=
]));
+            assert(ip[stream] >=3D ilowest);
+        }
+#endif
+        /* Compute olimit */
+        {
+            /* Each iteration produces 5 output symbols per stream */
+            size_t const oiters =3D (size_t)(oend - op[3]) / 5;
+            /* Each iteration consumes up to 11 bits * 5 =3D 55 bits < 7 b=
ytes
+             * per stream.
+             */
+            size_t const iiters =3D (size_t)(ip[0] - ilowest) / 7;
+            /* We can safely run iters iterations before running bounds ch=
ecks */
+            size_t const iters =3D MIN(oiters, iiters);
+            size_t const symbols =3D iters * 5;
+
+            /* We can simply check that op[3] < olimit, instead of checkin=
g all
+             * of our bounds, since we can't hit the other bounds until we=
've run
+             * iters iterations, which only happens when op[3] =3D=3D olim=
it.
+             */
+            olimit =3D op[3] + symbols;
+
+            /* Exit fast decoding loop once we reach the end. */
+            if (op[3] =3D=3D olimit)
+                break;
+
+            /* Exit the decoding loop if any input pointer has crossed the
+             * previous one. This indicates corruption, and a precondition
+             * to our loop is that ip[i] >=3D ip[0].
+             */
+            for (stream =3D 1; stream < 4; ++stream) {
+                if (ip[stream] < ip[stream - 1])
+                    goto _out;
+            }
+        }
+
+#ifndef NDEBUG
+        for (stream =3D 1; stream < 4; ++stream) {
+            assert(ip[stream] >=3D ip[stream - 1]);
+        }
+#endif
+
+#define HUF_4X1_DECODE_SYMBOL(_stream, _symbol)                 \
+    do {                                                        \
+        int const index =3D (int)(bits[(_stream)] >> 53);         \
+        int const entry =3D (int)dtable[index];                   \
+        bits[(_stream)] <<=3D (entry & 0x3F);                     \
+        op[(_stream)][(_symbol)] =3D (BYTE)((entry >> 8) & 0xFF); \
+    } while (0)
+
+#define HUF_4X1_RELOAD_STREAM(_stream)                              \
+    do {                                                            \
+        int const ctz =3D ZSTD_countTrailingZeros64(bits[(_stream)]); \
+        int const nbBits =3D ctz & 7;                                 \
+        int const nbBytes =3D ctz >> 3;                               \
+        op[(_stream)] +=3D 5;                                         \
+        ip[(_stream)] -=3D nbBytes;                                   \
+        bits[(_stream)] =3D MEM_read64(ip[(_stream)]) | 1;            \
+        bits[(_stream)] <<=3D nbBits;                                 \
+    } while (0)
+
+        /* Manually unroll the loop because compilers don't consistently
+         * unroll the inner loops, which destroys performance.
+         */
+        do {
+            /* Decode 5 symbols in each of the 4 streams */
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X1_DECODE_SYMBOL, 0);
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X1_DECODE_SYMBOL, 1);
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X1_DECODE_SYMBOL, 2);
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X1_DECODE_SYMBOL, 3);
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X1_DECODE_SYMBOL, 4);
+
+            /* Reload each of the 4 the bitstreams */
+            HUF_4X_FOR_EACH_STREAM(HUF_4X1_RELOAD_STREAM);
+        } while (op[3] < olimit);
+
+#undef HUF_4X1_DECODE_SYMBOL
+#undef HUF_4X1_RELOAD_STREAM
+    }
=20
-static HUF_ASM_X86_64_BMI2_ATTRS
+_out:
+
+    /* Save the final values of each of the state variables back to args. =
*/
+    ZSTD_memcpy(&args->bits, &bits, sizeof(bits));
+    ZSTD_memcpy((void*)(&args->ip), &ip, sizeof(ip));
+    ZSTD_memcpy(&args->op, &op, sizeof(op));
+}
+
+/*
+ * @returns @p dstSize on success (>=3D 6)
+ *          0 if the fallback implementation should be used
+ *          An error if an error occurred
+ */
+static HUF_FAST_BMI2_ATTRS
 size_t
-HUF_decompress4X1_usingDTable_internal_bmi2_asm(
+HUF_decompress4X1_usingDTable_internal_fast(
           void* dst,  size_t dstSize,
     const void* cSrc, size_t cSrcSize,
-    const HUF_DTable* DTable)
+    const HUF_DTable* DTable,
+    HUF_DecompressFastLoopFn loopFn)
 {
     void const* dt =3D DTable + 1;
-    const BYTE* const iend =3D (const BYTE*)cSrc + 6;
-    BYTE* const oend =3D (BYTE*)dst + dstSize;
-    HUF_DecompressAsmArgs args;
-    {
-        size_t const ret =3D HUF_DecompressAsmArgs_init(&args, dst, dstSiz=
e, cSrc, cSrcSize, DTable);
-        FORWARD_IF_ERROR(ret, "Failed to init asm args");
-        if (ret !=3D 0)
-            return HUF_decompress4X1_usingDTable_internal_bmi2(dst, dstSiz=
e, cSrc, cSrcSize, DTable);
+    BYTE const* const ilowest =3D (BYTE const*)cSrc;
+    BYTE* const oend =3D ZSTD_maybeNullPtrAdd((BYTE*)dst, dstSize);
+    HUF_DecompressFastArgs args;
+    {   size_t const ret =3D HUF_DecompressFastArgs_init(&args, dst, dstSi=
ze, cSrc, cSrcSize, DTable);
+        FORWARD_IF_ERROR(ret, "Failed to init fast loop args");
+        if (ret =3D=3D 0)
+            return 0;
     }
=20
-    assert(args.ip[0] >=3D args.ilimit);
-    HUF_decompress4X1_usingDTable_internal_bmi2_asm_loop(&args);
+    assert(args.ip[0] >=3D args.ilowest);
+    loopFn(&args);
=20
-    /* Our loop guarantees that ip[] >=3D ilimit and that we haven't
+    /* Our loop guarantees that ip[] >=3D ilowest and that we haven't
     * overwritten any op[].
     */
-    assert(args.ip[0] >=3D iend);
-    assert(args.ip[1] >=3D iend);
-    assert(args.ip[2] >=3D iend);
-    assert(args.ip[3] >=3D iend);
+    assert(args.ip[0] >=3D ilowest);
+    assert(args.ip[0] >=3D ilowest);
+    assert(args.ip[1] >=3D ilowest);
+    assert(args.ip[2] >=3D ilowest);
+    assert(args.ip[3] >=3D ilowest);
     assert(args.op[3] <=3D oend);
-    (void)iend;
+
+    assert(ilowest =3D=3D args.ilowest);
+    assert(ilowest + 6 =3D=3D args.iend[0]);
+    (void)ilowest;
=20
     /* finish bit streams one by one. */
-    {
-        size_t const segmentSize =3D (dstSize+3) / 4;
+    {   size_t const segmentSize =3D (dstSize+3) / 4;
         BYTE* segmentEnd =3D (BYTE*)dst;
         int i;
         for (i =3D 0; i < 4; ++i) {
@@ -706,92 +879,57 @@ HUF_decompress4X1_usingDTable_internal_bmi2_asm(
     }
=20
     /* decoded size */
+    assert(dstSize !=3D 0);
     return dstSize;
 }
-#endif /* ZSTD_ENABLE_ASM_X86_64_BMI2 */
-
-typedef size_t (*HUF_decompress_usingDTable_t)(void *dst, size_t dstSize,
-                                               const void *cSrc,
-                                               size_t cSrcSize,
-                                               const HUF_DTable *DTable);
=20
 HUF_DGEN(HUF_decompress1X1_usingDTable_internal)
=20
 static size_t HUF_decompress4X1_usingDTable_internal(void* dst, size_t dst=
Size, void const* cSrc,
-                    size_t cSrcSize, HUF_DTable const* DTable, int bmi2)
+                    size_t cSrcSize, HUF_DTable const* DTable, int flags)
 {
+    HUF_DecompressUsingDTableFn fallbackFn =3D HUF_decompress4X1_usingDTab=
le_internal_default;
+    HUF_DecompressFastLoopFn loopFn =3D HUF_decompress4X1_usingDTable_inte=
rnal_fast_c_loop;
+
 #if DYNAMIC_BMI2
-    if (bmi2) {
+    if (flags & HUF_flags_bmi2) {
+        fallbackFn =3D HUF_decompress4X1_usingDTable_internal_bmi2;
 # if ZSTD_ENABLE_ASM_X86_64_BMI2
-        return HUF_decompress4X1_usingDTable_internal_bmi2_asm(dst, dstSiz=
e, cSrc, cSrcSize, DTable);
-# else
-        return HUF_decompress4X1_usingDTable_internal_bmi2(dst, dstSize, c=
Src, cSrcSize, DTable);
+        if (!(flags & HUF_flags_disableAsm)) {
+            loopFn =3D HUF_decompress4X1_usingDTable_internal_fast_asm_loo=
p;
+        }
 # endif
+    } else {
+        return fallbackFn(dst, dstSize, cSrc, cSrcSize, DTable);
     }
-#else
-    (void)bmi2;
 #endif
=20
 #if ZSTD_ENABLE_ASM_X86_64_BMI2 && defined(__BMI2__)
-    return HUF_decompress4X1_usingDTable_internal_bmi2_asm(dst, dstSize, c=
Src, cSrcSize, DTable);
-#else
-    return HUF_decompress4X1_usingDTable_internal_default(dst, dstSize, cS=
rc, cSrcSize, DTable);
+    if (!(flags & HUF_flags_disableAsm)) {
+        loopFn =3D HUF_decompress4X1_usingDTable_internal_fast_asm_loop;
+    }
 #endif
-}
-
-size_t HUF_decompress1X1_usingDTable(
-          void* dst,  size_t dstSize,
-    const void* cSrc, size_t cSrcSize,
-    const HUF_DTable* DTable)
-{
-    DTableDesc dtd =3D HUF_getDTableDesc(DTable);
-    if (dtd.tableType !=3D 0) return ERROR(GENERIC);
-    return HUF_decompress1X1_usingDTable_internal(dst, dstSize, cSrc, cSrc=
Size, DTable, /* bmi2 */ 0);
-}
=20
-size_t HUF_decompress1X1_DCtx_wksp(HUF_DTable* DCtx, void* dst, size_t dst=
Size,
-                                   const void* cSrc, size_t cSrcSize,
-                                   void* workSpace, size_t wkspSize)
-{
-    const BYTE* ip =3D (const BYTE*) cSrc;
-
-    size_t const hSize =3D HUF_readDTableX1_wksp(DCtx, cSrc, cSrcSize, wor=
kSpace, wkspSize);
-    if (HUF_isError(hSize)) return hSize;
-    if (hSize >=3D cSrcSize) return ERROR(srcSize_wrong);
-    ip +=3D hSize; cSrcSize -=3D hSize;
-
-    return HUF_decompress1X1_usingDTable_internal(dst, dstSize, ip, cSrcSi=
ze, DCtx, /* bmi2 */ 0);
-}
-
-size_t HUF_decompress4X1_usingDTable(
-          void* dst,  size_t dstSize,
-    const void* cSrc, size_t cSrcSize,
-    const HUF_DTable* DTable)
-{
-    DTableDesc dtd =3D HUF_getDTableDesc(DTable);
-    if (dtd.tableType !=3D 0) return ERROR(GENERIC);
-    return HUF_decompress4X1_usingDTable_internal(dst, dstSize, cSrc, cSrc=
Size, DTable, /* bmi2 */ 0);
+    if (HUF_ENABLE_FAST_DECODE && !(flags & HUF_flags_disableFast)) {
+        size_t const ret =3D HUF_decompress4X1_usingDTable_internal_fast(d=
st, dstSize, cSrc, cSrcSize, DTable, loopFn);
+        if (ret !=3D 0)
+            return ret;
+    }
+    return fallbackFn(dst, dstSize, cSrc, cSrcSize, DTable);
 }
=20
-static size_t HUF_decompress4X1_DCtx_wksp_bmi2(HUF_DTable* dctx, void* dst=
, size_t dstSize,
+static size_t HUF_decompress4X1_DCtx_wksp(HUF_DTable* dctx, void* dst, siz=
e_t dstSize,
                                    const void* cSrc, size_t cSrcSize,
-                                   void* workSpace, size_t wkspSize, int b=
mi2)
+                                   void* workSpace, size_t wkspSize, int f=
lags)
 {
     const BYTE* ip =3D (const BYTE*) cSrc;
=20
-    size_t const hSize =3D HUF_readDTableX1_wksp_bmi2(dctx, cSrc, cSrcSize=
, workSpace, wkspSize, bmi2);
+    size_t const hSize =3D HUF_readDTableX1_wksp(dctx, cSrc, cSrcSize, wor=
kSpace, wkspSize, flags);
     if (HUF_isError(hSize)) return hSize;
     if (hSize >=3D cSrcSize) return ERROR(srcSize_wrong);
     ip +=3D hSize; cSrcSize -=3D hSize;
=20
-    return HUF_decompress4X1_usingDTable_internal(dst, dstSize, ip, cSrcSi=
ze, dctx, bmi2);
-}
-
-size_t HUF_decompress4X1_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dst=
Size,
-                                   const void* cSrc, size_t cSrcSize,
-                                   void* workSpace, size_t wkspSize)
-{
-    return HUF_decompress4X1_DCtx_wksp_bmi2(dctx, dst, dstSize, cSrc, cSrc=
Size, workSpace, wkspSize, 0);
+    return HUF_decompress4X1_usingDTable_internal(dst, dstSize, ip, cSrcSi=
ze, dctx, flags);
 }
=20
 #endif /* HUF_FORCE_DECOMPRESS_X2 */
@@ -975,7 +1113,7 @@ static void HUF_fillDTableX2Level2(HUF_DEltX2* DTable,=
 U32 targetLog, const U32
=20
 static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
                            const sortedSymbol_t* sortedList,
-                           const U32* rankStart, rankVal_t rankValOrigin, =
const U32 maxWeight,
+                           const U32* rankStart, rankValCol_t* rankValOrig=
in, const U32 maxWeight,
                            const U32 nbBitsBaseline)
 {
     U32* const rankVal =3D rankValOrigin[0];
@@ -1030,14 +1168,7 @@ typedef struct {
=20
 size_t HUF_readDTableX2_wksp(HUF_DTable* DTable,
                        const void* src, size_t srcSize,
-                             void* workSpace, size_t wkspSize)
-{
-    return HUF_readDTableX2_wksp_bmi2(DTable, src, srcSize, workSpace, wks=
pSize, /* bmi2 */ 0);
-}
-
-size_t HUF_readDTableX2_wksp_bmi2(HUF_DTable* DTable,
-                       const void* src, size_t srcSize,
-                             void* workSpace, size_t wkspSize, int bmi2)
+                             void* workSpace, size_t wkspSize, int flags)
 {
     U32 tableLog, maxW, nbSymbols;
     DTableDesc dtd =3D HUF_getDTableDesc(DTable);
@@ -1059,7 +1190,7 @@ size_t HUF_readDTableX2_wksp_bmi2(HUF_DTable* DTable,
     if (maxTableLog > HUF_TABLELOG_MAX) return ERROR(tableLog_tooLarge);
     /* ZSTD_memset(weightList, 0, sizeof(weightList)); */  /* is not neces=
sary, even though some analyzer complain ... */
=20
-    iSize =3D HUF_readStats_wksp(wksp->weightList, HUF_SYMBOLVALUE_MAX + 1=
, wksp->rankStats, &nbSymbols, &tableLog, src, srcSize, wksp->calleeWksp, s=
izeof(wksp->calleeWksp), bmi2);
+    iSize =3D HUF_readStats_wksp(wksp->weightList, HUF_SYMBOLVALUE_MAX + 1=
, wksp->rankStats, &nbSymbols, &tableLog, src, srcSize, wksp->calleeWksp, s=
izeof(wksp->calleeWksp), flags);
     if (HUF_isError(iSize)) return iSize;
=20
     /* check result */
@@ -1148,15 +1279,19 @@ HUF_decodeLastSymbolX2(void* op, BIT_DStream_t* DSt=
ream, const HUF_DEltX2* dt, c
 }
=20
 #define HUF_DECODE_SYMBOLX2_0(ptr, DStreamPtr) \
-    ptr +=3D HUF_decodeSymbolX2(ptr, DStreamPtr, dt, dtLog)
+    do { ptr +=3D HUF_decodeSymbolX2(ptr, DStreamPtr, dt, dtLog); } while =
(0)
=20
-#define HUF_DECODE_SYMBOLX2_1(ptr, DStreamPtr) \
-    if (MEM_64bits() || (HUF_TABLELOG_MAX<=3D12)) \
-        ptr +=3D HUF_decodeSymbolX2(ptr, DStreamPtr, dt, dtLog)
+#define HUF_DECODE_SYMBOLX2_1(ptr, DStreamPtr)                     \
+    do {                                                           \
+        if (MEM_64bits() || (HUF_TABLELOG_MAX<=3D12))                \
+            ptr +=3D HUF_decodeSymbolX2(ptr, DStreamPtr, dt, dtLog); \
+    } while (0)
=20
-#define HUF_DECODE_SYMBOLX2_2(ptr, DStreamPtr) \
-    if (MEM_64bits()) \
-        ptr +=3D HUF_decodeSymbolX2(ptr, DStreamPtr, dt, dtLog)
+#define HUF_DECODE_SYMBOLX2_2(ptr, DStreamPtr)                     \
+    do {                                                           \
+        if (MEM_64bits())                                          \
+            ptr +=3D HUF_decodeSymbolX2(ptr, DStreamPtr, dt, dtLog); \
+    } while (0)
=20
 HINT_INLINE size_t
 HUF_decodeStreamX2(BYTE* p, BIT_DStream_t* bitDPtr, BYTE* const pEnd,
@@ -1216,7 +1351,7 @@ HUF_decompress1X2_usingDTable_internal_body(
=20
     /* decode */
     {   BYTE* const ostart =3D (BYTE*) dst;
-        BYTE* const oend =3D ostart + dstSize;
+        BYTE* const oend =3D ZSTD_maybeNullPtrAdd(ostart, dstSize);
         const void* const dtPtr =3D DTable+1;   /* force compiler to not u=
se strict-aliasing */
         const HUF_DEltX2* const dt =3D (const HUF_DEltX2*)dtPtr;
         DTableDesc const dtd =3D HUF_getDTableDesc(DTable);
@@ -1229,6 +1364,11 @@ HUF_decompress1X2_usingDTable_internal_body(
     /* decoded size */
     return dstSize;
 }
+
+/* HUF_decompress4X2_usingDTable_internal_body():
+ * Conditions:
+ * @dstSize >=3D 6
+ */
 FORCE_INLINE_TEMPLATE size_t
 HUF_decompress4X2_usingDTable_internal_body(
           void* dst,  size_t dstSize,
@@ -1236,6 +1376,7 @@ HUF_decompress4X2_usingDTable_internal_body(
     const HUF_DTable* DTable)
 {
     if (cSrcSize < 10) return ERROR(corruption_detected);   /* strict mini=
mum : jump table + 1 byte per stream */
+    if (dstSize < 6) return ERROR(corruption_detected);         /* stream =
4-split doesn't work */
=20
     {   const BYTE* const istart =3D (const BYTE*) cSrc;
         BYTE* const ostart =3D (BYTE*) dst;
@@ -1269,8 +1410,9 @@ HUF_decompress4X2_usingDTable_internal_body(
         DTableDesc const dtd =3D HUF_getDTableDesc(DTable);
         U32 const dtLog =3D dtd.tableLog;
=20
-        if (length4 > cSrcSize) return ERROR(corruption_detected);   /* ov=
erflow */
-        if (opStart4 > oend) return ERROR(corruption_detected);      /* ov=
erflow */
+        if (length4 > cSrcSize) return ERROR(corruption_detected);  /* ove=
rflow */
+        if (opStart4 > oend) return ERROR(corruption_detected);     /* ove=
rflow */
+        assert(dstSize >=3D 6 /* validated above */);
         CHECK_F( BIT_initDStream(&bitD1, istart1, length1) );
         CHECK_F( BIT_initDStream(&bitD2, istart2, length2) );
         CHECK_F( BIT_initDStream(&bitD3, istart3, length3) );
@@ -1355,44 +1497,190 @@ size_t HUF_decompress4X2_usingDTable_internal_bmi2=
(void* dst, size_t dstSize, vo
 }
 #endif
=20
-#if HUF_NEED_DEFAULT_FUNCTION
 static
 size_t HUF_decompress4X2_usingDTable_internal_default(void* dst, size_t ds=
tSize, void const* cSrc,
                     size_t cSrcSize, HUF_DTable const* DTable) {
     return HUF_decompress4X2_usingDTable_internal_body(dst, dstSize, cSrc,=
 cSrcSize, DTable);
 }
-#endif
=20
 #if ZSTD_ENABLE_ASM_X86_64_BMI2
=20
-HUF_ASM_DECL void HUF_decompress4X2_usingDTable_internal_bmi2_asm_loop(HUF=
_DecompressAsmArgs* args) ZSTDLIB_HIDDEN;
+HUF_ASM_DECL void HUF_decompress4X2_usingDTable_internal_fast_asm_loop(HUF=
_DecompressFastArgs* args) ZSTDLIB_HIDDEN;
+
+#endif
+
+static HUF_FAST_BMI2_ATTRS
+void HUF_decompress4X2_usingDTable_internal_fast_c_loop(HUF_DecompressFast=
Args* args)
+{
+    U64 bits[4];
+    BYTE const* ip[4];
+    BYTE* op[4];
+    BYTE* oend[4];
+    HUF_DEltX2 const* const dtable =3D (HUF_DEltX2 const*)args->dt;
+    BYTE const* const ilowest =3D args->ilowest;
+
+    /* Copy the arguments to local registers. */
+    ZSTD_memcpy(&bits, &args->bits, sizeof(bits));
+    ZSTD_memcpy((void*)(&ip), &args->ip, sizeof(ip));
+    ZSTD_memcpy(&op, &args->op, sizeof(op));
+
+    oend[0] =3D op[1];
+    oend[1] =3D op[2];
+    oend[2] =3D op[3];
+    oend[3] =3D args->oend;
+
+    assert(MEM_isLittleEndian());
+    assert(!MEM_32bits());
+
+    for (;;) {
+        BYTE* olimit;
+        int stream;
+
+        /* Assert loop preconditions */
+#ifndef NDEBUG
+        for (stream =3D 0; stream < 4; ++stream) {
+            assert(op[stream] <=3D oend[stream]);
+            assert(ip[stream] >=3D ilowest);
+        }
+#endif
+        /* Compute olimit */
+        {
+            /* Each loop does 5 table lookups for each of the 4 streams.
+             * Each table lookup consumes up to 11 bits of input, and prod=
uces
+             * up to 2 bytes of output.
+             */
+            /* We can consume up to 7 bytes of input per iteration per str=
eam.
+             * We also know that each input pointer is >=3D ip[0]. So we c=
an run
+             * iters loops before running out of input.
+             */
+            size_t iters =3D (size_t)(ip[0] - ilowest) / 7;
+            /* Each iteration can produce up to 10 bytes of output per str=
eam.
+             * Each output stream my advance at different rates. So take t=
he
+             * minimum number of safe iterations among all the output stre=
ams.
+             */
+            for (stream =3D 0; stream < 4; ++stream) {
+                size_t const oiters =3D (size_t)(oend[stream] - op[stream]=
) / 10;
+                iters =3D MIN(iters, oiters);
+            }
+
+            /* Each iteration produces at least 5 output symbols. So until
+             * op[3] crosses olimit, we know we haven't executed iters
+             * iterations yet. This saves us maintaining an iters counter,
+             * at the expense of computing the remaining # of iterations
+             * more frequently.
+             */
+            olimit =3D op[3] + (iters * 5);
+
+            /* Exit the fast decoding loop once we reach the end. */
+            if (op[3] =3D=3D olimit)
+                break;
+
+            /* Exit the decoding loop if any input pointer has crossed the
+             * previous one. This indicates corruption, and a precondition
+             * to our loop is that ip[i] >=3D ip[0].
+             */
+            for (stream =3D 1; stream < 4; ++stream) {
+                if (ip[stream] < ip[stream - 1])
+                    goto _out;
+            }
+        }
+
+#ifndef NDEBUG
+        for (stream =3D 1; stream < 4; ++stream) {
+            assert(ip[stream] >=3D ip[stream - 1]);
+        }
+#endif
+
+#define HUF_4X2_DECODE_SYMBOL(_stream, _decode3)                      \
+    do {                                                              \
+        if ((_decode3) || (_stream) !=3D 3) {                           \
+            int const index =3D (int)(bits[(_stream)] >> 53);           \
+            HUF_DEltX2 const entry =3D dtable[index];                   \
+            MEM_write16(op[(_stream)], entry.sequence); \
+            bits[(_stream)] <<=3D (entry.nbBits) & 0x3F;                \
+            op[(_stream)] +=3D (entry.length);                          \
+        }                                                             \
+    } while (0)
+
+#define HUF_4X2_RELOAD_STREAM(_stream)                                  \
+    do {                                                                \
+        HUF_4X2_DECODE_SYMBOL(3, 1);                                    \
+        {                                                               \
+            int const ctz =3D ZSTD_countTrailingZeros64(bits[(_stream)]); =
\
+            int const nbBits =3D ctz & 7;                                 =
\
+            int const nbBytes =3D ctz >> 3;                               =
\
+            ip[(_stream)] -=3D nbBytes;                                   =
\
+            bits[(_stream)] =3D MEM_read64(ip[(_stream)]) | 1;            =
\
+            bits[(_stream)] <<=3D nbBits;                                 =
\
+        }                                                               \
+    } while (0)
+
+        /* Manually unroll the loop because compilers don't consistently
+         * unroll the inner loops, which destroys performance.
+         */
+        do {
+            /* Decode 5 symbols from each of the first 3 streams.
+             * The final stream will be decoded during the reload phase
+             * to reduce register pressure.
+             */
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X2_DECODE_SYMBOL, 0);
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X2_DECODE_SYMBOL, 0);
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X2_DECODE_SYMBOL, 0);
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X2_DECODE_SYMBOL, 0);
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X2_DECODE_SYMBOL, 0);
+
+            /* Decode one symbol from the final stream */
+            HUF_4X2_DECODE_SYMBOL(3, 1);
+
+            /* Decode 4 symbols from the final stream & reload bitstreams.
+             * The final stream is reloaded last, meaning that all 5 symbo=
ls
+             * are decoded from the final stream before it is reloaded.
+             */
+            HUF_4X_FOR_EACH_STREAM(HUF_4X2_RELOAD_STREAM);
+        } while (op[3] < olimit);
+    }
+
+#undef HUF_4X2_DECODE_SYMBOL
+#undef HUF_4X2_RELOAD_STREAM
=20
-static HUF_ASM_X86_64_BMI2_ATTRS size_t
-HUF_decompress4X2_usingDTable_internal_bmi2_asm(
+_out:
+
+    /* Save the final values of each of the state variables back to args. =
*/
+    ZSTD_memcpy(&args->bits, &bits, sizeof(bits));
+    ZSTD_memcpy((void*)(&args->ip), &ip, sizeof(ip));
+    ZSTD_memcpy(&args->op, &op, sizeof(op));
+}
+
+static HUF_FAST_BMI2_ATTRS size_t
+HUF_decompress4X2_usingDTable_internal_fast(
           void* dst,  size_t dstSize,
     const void* cSrc, size_t cSrcSize,
-    const HUF_DTable* DTable) {
+    const HUF_DTable* DTable,
+    HUF_DecompressFastLoopFn loopFn) {
     void const* dt =3D DTable + 1;
-    const BYTE* const iend =3D (const BYTE*)cSrc + 6;
-    BYTE* const oend =3D (BYTE*)dst + dstSize;
-    HUF_DecompressAsmArgs args;
+    const BYTE* const ilowest =3D (const BYTE*)cSrc;
+    BYTE* const oend =3D ZSTD_maybeNullPtrAdd((BYTE*)dst, dstSize);
+    HUF_DecompressFastArgs args;
     {
-        size_t const ret =3D HUF_DecompressAsmArgs_init(&args, dst, dstSiz=
e, cSrc, cSrcSize, DTable);
+        size_t const ret =3D HUF_DecompressFastArgs_init(&args, dst, dstSi=
ze, cSrc, cSrcSize, DTable);
         FORWARD_IF_ERROR(ret, "Failed to init asm args");
-        if (ret !=3D 0)
-            return HUF_decompress4X2_usingDTable_internal_bmi2(dst, dstSiz=
e, cSrc, cSrcSize, DTable);
+        if (ret =3D=3D 0)
+            return 0;
     }
=20
-    assert(args.ip[0] >=3D args.ilimit);
-    HUF_decompress4X2_usingDTable_internal_bmi2_asm_loop(&args);
+    assert(args.ip[0] >=3D args.ilowest);
+    loopFn(&args);
=20
     /* note : op4 already verified within main loop */
-    assert(args.ip[0] >=3D iend);
-    assert(args.ip[1] >=3D iend);
-    assert(args.ip[2] >=3D iend);
-    assert(args.ip[3] >=3D iend);
+    assert(args.ip[0] >=3D ilowest);
+    assert(args.ip[1] >=3D ilowest);
+    assert(args.ip[2] >=3D ilowest);
+    assert(args.ip[3] >=3D ilowest);
     assert(args.op[3] <=3D oend);
-    (void)iend;
+
+    assert(ilowest =3D=3D args.ilowest);
+    assert(ilowest + 6 =3D=3D args.iend[0]);
+    (void)ilowest;
=20
     /* finish bitStreams one by one */
     {
@@ -1415,87 +1703,70 @@ HUF_decompress4X2_usingDTable_internal_bmi2_asm(
     /* decoded size */
     return dstSize;
 }
-#endif /* ZSTD_ENABLE_ASM_X86_64_BMI2 */
=20
 static size_t HUF_decompress4X2_usingDTable_internal(void* dst, size_t dst=
Size, void const* cSrc,
-                    size_t cSrcSize, HUF_DTable const* DTable, int bmi2)
+                    size_t cSrcSize, HUF_DTable const* DTable, int flags)
 {
+    HUF_DecompressUsingDTableFn fallbackFn =3D HUF_decompress4X2_usingDTab=
le_internal_default;
+    HUF_DecompressFastLoopFn loopFn =3D HUF_decompress4X2_usingDTable_inte=
rnal_fast_c_loop;
+
 #if DYNAMIC_BMI2
-    if (bmi2) {
+    if (flags & HUF_flags_bmi2) {
+        fallbackFn =3D HUF_decompress4X2_usingDTable_internal_bmi2;
 # if ZSTD_ENABLE_ASM_X86_64_BMI2
-        return HUF_decompress4X2_usingDTable_internal_bmi2_asm(dst, dstSiz=
e, cSrc, cSrcSize, DTable);
-# else
-        return HUF_decompress4X2_usingDTable_internal_bmi2(dst, dstSize, c=
Src, cSrcSize, DTable);
+        if (!(flags & HUF_flags_disableAsm)) {
+            loopFn =3D HUF_decompress4X2_usingDTable_internal_fast_asm_loo=
p;
+        }
 # endif
+    } else {
+        return fallbackFn(dst, dstSize, cSrc, cSrcSize, DTable);
     }
-#else
-    (void)bmi2;
 #endif
=20
 #if ZSTD_ENABLE_ASM_X86_64_BMI2 && defined(__BMI2__)
-    return HUF_decompress4X2_usingDTable_internal_bmi2_asm(dst, dstSize, c=
Src, cSrcSize, DTable);
-#else
-    return HUF_decompress4X2_usingDTable_internal_default(dst, dstSize, cS=
rc, cSrcSize, DTable);
+    if (!(flags & HUF_flags_disableAsm)) {
+        loopFn =3D HUF_decompress4X2_usingDTable_internal_fast_asm_loop;
+    }
 #endif
+
+    if (HUF_ENABLE_FAST_DECODE && !(flags & HUF_flags_disableFast)) {
+        size_t const ret =3D HUF_decompress4X2_usingDTable_internal_fast(d=
st, dstSize, cSrc, cSrcSize, DTable, loopFn);
+        if (ret !=3D 0)
+            return ret;
+    }
+    return fallbackFn(dst, dstSize, cSrc, cSrcSize, DTable);
 }
=20
 HUF_DGEN(HUF_decompress1X2_usingDTable_internal)
=20
-size_t HUF_decompress1X2_usingDTable(
-          void* dst,  size_t dstSize,
-    const void* cSrc, size_t cSrcSize,
-    const HUF_DTable* DTable)
-{
-    DTableDesc dtd =3D HUF_getDTableDesc(DTable);
-    if (dtd.tableType !=3D 1) return ERROR(GENERIC);
-    return HUF_decompress1X2_usingDTable_internal(dst, dstSize, cSrc, cSrc=
Size, DTable, /* bmi2 */ 0);
-}
-
 size_t HUF_decompress1X2_DCtx_wksp(HUF_DTable* DCtx, void* dst, size_t dst=
Size,
                                    const void* cSrc, size_t cSrcSize,
-                                   void* workSpace, size_t wkspSize)
+                                   void* workSpace, size_t wkspSize, int f=
lags)
 {
     const BYTE* ip =3D (const BYTE*) cSrc;
=20
     size_t const hSize =3D HUF_readDTableX2_wksp(DCtx, cSrc, cSrcSize,
-                                               workSpace, wkspSize);
+                                               workSpace, wkspSize, flags)=
;
     if (HUF_isError(hSize)) return hSize;
     if (hSize >=3D cSrcSize) return ERROR(srcSize_wrong);
     ip +=3D hSize; cSrcSize -=3D hSize;
=20
-    return HUF_decompress1X2_usingDTable_internal(dst, dstSize, ip, cSrcSi=
ze, DCtx, /* bmi2 */ 0);
-}
-
-size_t HUF_decompress4X2_usingDTable(
-          void* dst,  size_t dstSize,
-    const void* cSrc, size_t cSrcSize,
-    const HUF_DTable* DTable)
-{
-    DTableDesc dtd =3D HUF_getDTableDesc(DTable);
-    if (dtd.tableType !=3D 1) return ERROR(GENERIC);
-    return HUF_decompress4X2_usingDTable_internal(dst, dstSize, cSrc, cSrc=
Size, DTable, /* bmi2 */ 0);
+    return HUF_decompress1X2_usingDTable_internal(dst, dstSize, ip, cSrcSi=
ze, DCtx, flags);
 }
=20
-static size_t HUF_decompress4X2_DCtx_wksp_bmi2(HUF_DTable* dctx, void* dst=
, size_t dstSize,
+static size_t HUF_decompress4X2_DCtx_wksp(HUF_DTable* dctx, void* dst, siz=
e_t dstSize,
                                    const void* cSrc, size_t cSrcSize,
-                                   void* workSpace, size_t wkspSize, int b=
mi2)
+                                   void* workSpace, size_t wkspSize, int f=
lags)
 {
     const BYTE* ip =3D (const BYTE*) cSrc;
=20
     size_t hSize =3D HUF_readDTableX2_wksp(dctx, cSrc, cSrcSize,
-                                         workSpace, wkspSize);
+                                         workSpace, wkspSize, flags);
     if (HUF_isError(hSize)) return hSize;
     if (hSize >=3D cSrcSize) return ERROR(srcSize_wrong);
     ip +=3D hSize; cSrcSize -=3D hSize;
=20
-    return HUF_decompress4X2_usingDTable_internal(dst, dstSize, ip, cSrcSi=
ze, dctx, bmi2);
-}
-
-size_t HUF_decompress4X2_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dst=
Size,
-                                   const void* cSrc, size_t cSrcSize,
-                                   void* workSpace, size_t wkspSize)
-{
-    return HUF_decompress4X2_DCtx_wksp_bmi2(dctx, dst, dstSize, cSrc, cSrc=
Size, workSpace, wkspSize, /* bmi2 */ 0);
+    return HUF_decompress4X2_usingDTable_internal(dst, dstSize, ip, cSrcSi=
ze, dctx, flags);
 }
=20
 #endif /* HUF_FORCE_DECOMPRESS_X1 */
@@ -1504,44 +1775,6 @@ size_t HUF_decompress4X2_DCtx_wksp(HUF_DTable* dctx,=
 void* dst, size_t dstSize,
 /* Universal decompression selectors */
 /* ***********************************/
=20
-size_t HUF_decompress1X_usingDTable(void* dst, size_t maxDstSize,
-                                    const void* cSrc, size_t cSrcSize,
-                                    const HUF_DTable* DTable)
-{
-    DTableDesc const dtd =3D HUF_getDTableDesc(DTable);
-#if defined(HUF_FORCE_DECOMPRESS_X1)
-    (void)dtd;
-    assert(dtd.tableType =3D=3D 0);
-    return HUF_decompress1X1_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, /* bmi2 */ 0);
-#elif defined(HUF_FORCE_DECOMPRESS_X2)
-    (void)dtd;
-    assert(dtd.tableType =3D=3D 1);
-    return HUF_decompress1X2_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, /* bmi2 */ 0);
-#else
-    return dtd.tableType ? HUF_decompress1X2_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, /* bmi2 */ 0) :
-                           HUF_decompress1X1_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, /* bmi2 */ 0);
-#endif
-}
-
-size_t HUF_decompress4X_usingDTable(void* dst, size_t maxDstSize,
-                                    const void* cSrc, size_t cSrcSize,
-                                    const HUF_DTable* DTable)
-{
-    DTableDesc const dtd =3D HUF_getDTableDesc(DTable);
-#if defined(HUF_FORCE_DECOMPRESS_X1)
-    (void)dtd;
-    assert(dtd.tableType =3D=3D 0);
-    return HUF_decompress4X1_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, /* bmi2 */ 0);
-#elif defined(HUF_FORCE_DECOMPRESS_X2)
-    (void)dtd;
-    assert(dtd.tableType =3D=3D 1);
-    return HUF_decompress4X2_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, /* bmi2 */ 0);
-#else
-    return dtd.tableType ? HUF_decompress4X2_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, /* bmi2 */ 0) :
-                           HUF_decompress4X1_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, /* bmi2 */ 0);
-#endif
-}
-
 #if !defined(HUF_FORCE_DECOMPRESS_X1) && !defined(HUF_FORCE_DECOMPRESS_X2)
 typedef struct { U32 tableTime; U32 decode256Time; } algo_time_t;
 static const algo_time_t algoTime[16 /* Quantization */][2 /* single, doub=
le */] =3D
@@ -1595,35 +1828,9 @@ U32 HUF_selectDecoder (size_t dstSize, size_t cSrcSi=
ze)
 #endif
 }
=20
-size_t HUF_decompress4X_hufOnly_wksp(HUF_DTable* dctx, void* dst,
-                                     size_t dstSize, const void* cSrc,
-                                     size_t cSrcSize, void* workSpace,
-                                     size_t wkspSize)
-{
-    /* validation checks */
-    if (dstSize =3D=3D 0) return ERROR(dstSize_tooSmall);
-    if (cSrcSize =3D=3D 0) return ERROR(corruption_detected);
-
-    {   U32 const algoNb =3D HUF_selectDecoder(dstSize, cSrcSize);
-#if defined(HUF_FORCE_DECOMPRESS_X1)
-        (void)algoNb;
-        assert(algoNb =3D=3D 0);
-        return HUF_decompress4X1_DCtx_wksp(dctx, dst, dstSize, cSrc, cSrcS=
ize, workSpace, wkspSize);
-#elif defined(HUF_FORCE_DECOMPRESS_X2)
-        (void)algoNb;
-        assert(algoNb =3D=3D 1);
-        return HUF_decompress4X2_DCtx_wksp(dctx, dst, dstSize, cSrc, cSrcS=
ize, workSpace, wkspSize);
-#else
-        return algoNb ? HUF_decompress4X2_DCtx_wksp(dctx, dst, dstSize, cS=
rc,
-                            cSrcSize, workSpace, wkspSize):
-                        HUF_decompress4X1_DCtx_wksp(dctx, dst, dstSize, cS=
rc, cSrcSize, workSpace, wkspSize);
-#endif
-    }
-}
-
 size_t HUF_decompress1X_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dstS=
ize,
                                   const void* cSrc, size_t cSrcSize,
-                                  void* workSpace, size_t wkspSize)
+                                  void* workSpace, size_t wkspSize, int fl=
ags)
 {
     /* validation checks */
     if (dstSize =3D=3D 0) return ERROR(dstSize_tooSmall);
@@ -1636,70 +1843,70 @@ size_t HUF_decompress1X_DCtx_wksp(HUF_DTable* dctx,=
 void* dst, size_t dstSize,
         (void)algoNb;
         assert(algoNb =3D=3D 0);
         return HUF_decompress1X1_DCtx_wksp(dctx, dst, dstSize, cSrc,
-                                cSrcSize, workSpace, wkspSize);
+                                cSrcSize, workSpace, wkspSize, flags);
 #elif defined(HUF_FORCE_DECOMPRESS_X2)
         (void)algoNb;
         assert(algoNb =3D=3D 1);
         return HUF_decompress1X2_DCtx_wksp(dctx, dst, dstSize, cSrc,
-                                cSrcSize, workSpace, wkspSize);
+                                cSrcSize, workSpace, wkspSize, flags);
 #else
         return algoNb ? HUF_decompress1X2_DCtx_wksp(dctx, dst, dstSize, cS=
rc,
-                                cSrcSize, workSpace, wkspSize):
+                                cSrcSize, workSpace, wkspSize, flags):
                         HUF_decompress1X1_DCtx_wksp(dctx, dst, dstSize, cS=
rc,
-                                cSrcSize, workSpace, wkspSize);
+                                cSrcSize, workSpace, wkspSize, flags);
 #endif
     }
 }
=20
-size_t HUF_decompress1X_usingDTable_bmi2(void* dst, size_t maxDstSize, con=
st void* cSrc, size_t cSrcSize, const HUF_DTable* DTable, int bmi2)
+size_t HUF_decompress1X_usingDTable(void* dst, size_t maxDstSize, const vo=
id* cSrc, size_t cSrcSize, const HUF_DTable* DTable, int flags)
 {
     DTableDesc const dtd =3D HUF_getDTableDesc(DTable);
 #if defined(HUF_FORCE_DECOMPRESS_X1)
     (void)dtd;
     assert(dtd.tableType =3D=3D 0);
-    return HUF_decompress1X1_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, bmi2);
+    return HUF_decompress1X1_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, flags);
 #elif defined(HUF_FORCE_DECOMPRESS_X2)
     (void)dtd;
     assert(dtd.tableType =3D=3D 1);
-    return HUF_decompress1X2_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, bmi2);
+    return HUF_decompress1X2_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, flags);
 #else
-    return dtd.tableType ? HUF_decompress1X2_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, bmi2) :
-                           HUF_decompress1X1_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, bmi2);
+    return dtd.tableType ? HUF_decompress1X2_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, flags) :
+                           HUF_decompress1X1_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, flags);
 #endif
 }
=20
 #ifndef HUF_FORCE_DECOMPRESS_X2
-size_t HUF_decompress1X1_DCtx_wksp_bmi2(HUF_DTable* dctx, void* dst, size_=
t dstSize, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspS=
ize, int bmi2)
+size_t HUF_decompress1X1_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dst=
Size, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize, =
int flags)
 {
     const BYTE* ip =3D (const BYTE*) cSrc;
=20
-    size_t const hSize =3D HUF_readDTableX1_wksp_bmi2(dctx, cSrc, cSrcSize=
, workSpace, wkspSize, bmi2);
+    size_t const hSize =3D HUF_readDTableX1_wksp(dctx, cSrc, cSrcSize, wor=
kSpace, wkspSize, flags);
     if (HUF_isError(hSize)) return hSize;
     if (hSize >=3D cSrcSize) return ERROR(srcSize_wrong);
     ip +=3D hSize; cSrcSize -=3D hSize;
=20
-    return HUF_decompress1X1_usingDTable_internal(dst, dstSize, ip, cSrcSi=
ze, dctx, bmi2);
+    return HUF_decompress1X1_usingDTable_internal(dst, dstSize, ip, cSrcSi=
ze, dctx, flags);
 }
 #endif
=20
-size_t HUF_decompress4X_usingDTable_bmi2(void* dst, size_t maxDstSize, con=
st void* cSrc, size_t cSrcSize, const HUF_DTable* DTable, int bmi2)
+size_t HUF_decompress4X_usingDTable(void* dst, size_t maxDstSize, const vo=
id* cSrc, size_t cSrcSize, const HUF_DTable* DTable, int flags)
 {
     DTableDesc const dtd =3D HUF_getDTableDesc(DTable);
 #if defined(HUF_FORCE_DECOMPRESS_X1)
     (void)dtd;
     assert(dtd.tableType =3D=3D 0);
-    return HUF_decompress4X1_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, bmi2);
+    return HUF_decompress4X1_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, flags);
 #elif defined(HUF_FORCE_DECOMPRESS_X2)
     (void)dtd;
     assert(dtd.tableType =3D=3D 1);
-    return HUF_decompress4X2_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, bmi2);
+    return HUF_decompress4X2_usingDTable_internal(dst, maxDstSize, cSrc, c=
SrcSize, DTable, flags);
 #else
-    return dtd.tableType ? HUF_decompress4X2_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, bmi2) :
-                           HUF_decompress4X1_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, bmi2);
+    return dtd.tableType ? HUF_decompress4X2_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, flags) :
+                           HUF_decompress4X1_usingDTable_internal(dst, max=
DstSize, cSrc, cSrcSize, DTable, flags);
 #endif
 }
=20
-size_t HUF_decompress4X_hufOnly_wksp_bmi2(HUF_DTable* dctx, void* dst, siz=
e_t dstSize, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wks=
pSize, int bmi2)
+size_t HUF_decompress4X_hufOnly_wksp(HUF_DTable* dctx, void* dst, size_t d=
stSize, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize=
, int flags)
 {
     /* validation checks */
     if (dstSize =3D=3D 0) return ERROR(dstSize_tooSmall);
@@ -1709,15 +1916,14 @@ size_t HUF_decompress4X_hufOnly_wksp_bmi2(HUF_DTabl=
e* dctx, void* dst, size_t ds
 #if defined(HUF_FORCE_DECOMPRESS_X1)
         (void)algoNb;
         assert(algoNb =3D=3D 0);
-        return HUF_decompress4X1_DCtx_wksp_bmi2(dctx, dst, dstSize, cSrc, =
cSrcSize, workSpace, wkspSize, bmi2);
+        return HUF_decompress4X1_DCtx_wksp(dctx, dst, dstSize, cSrc, cSrcS=
ize, workSpace, wkspSize, flags);
 #elif defined(HUF_FORCE_DECOMPRESS_X2)
         (void)algoNb;
         assert(algoNb =3D=3D 1);
-        return HUF_decompress4X2_DCtx_wksp_bmi2(dctx, dst, dstSize, cSrc, =
cSrcSize, workSpace, wkspSize, bmi2);
+        return HUF_decompress4X2_DCtx_wksp(dctx, dst, dstSize, cSrc, cSrcS=
ize, workSpace, wkspSize, flags);
 #else
-        return algoNb ? HUF_decompress4X2_DCtx_wksp_bmi2(dctx, dst, dstSiz=
e, cSrc, cSrcSize, workSpace, wkspSize, bmi2) :
-                        HUF_decompress4X1_DCtx_wksp_bmi2(dctx, dst, dstSiz=
e, cSrc, cSrcSize, workSpace, wkspSize, bmi2);
+        return algoNb ? HUF_decompress4X2_DCtx_wksp(dctx, dst, dstSize, cS=
rc, cSrcSize, workSpace, wkspSize, flags) :
+                        HUF_decompress4X1_DCtx_wksp(dctx, dst, dstSize, cS=
rc, cSrcSize, workSpace, wkspSize, flags);
 #endif
     }
 }
-
diff --git a/lib/zstd/decompress/zstd_ddict.c b/lib/zstd/decompress/zstd_dd=
ict.c
index db6aa722966f..cac91cdc0f40 100644
--- a/lib/zstd/decompress/zstd_ddict.c
+++ b/lib/zstd/decompress/zstd_ddict.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -14,12 +15,12 @@
 /*-*******************************************************
 *  Dependencies
 *********************************************************/
+#include "../common/allocations.h"  /* ZSTD_customMalloc, ZSTD_customFree =
*/
 #include "../common/zstd_deps.h"   /* ZSTD_memcpy, ZSTD_memmove, ZSTD_mems=
et */
 #include "../common/cpu.h"         /* bmi2 */
 #include "../common/mem.h"         /* low level memory routines */
 #define FSE_STATIC_LINKING_ONLY
 #include "../common/fse.h"
-#define HUF_STATIC_LINKING_ONLY
 #include "../common/huf.h"
 #include "zstd_decompress_internal.h"
 #include "zstd_ddict.h"
@@ -126,7 +127,7 @@ static size_t ZSTD_initDDict_internal(ZSTD_DDict* ddict=
,
         ZSTD_memcpy(internalBuffer, dict, dictSize);
     }
     ddict->dictSize =3D dictSize;
-    ddict->entropy.hufTable[0] =3D (HUF_DTable)((HufLog)*0x1000001);  /* c=
over both little and big endian */
+    ddict->entropy.hufTable[0] =3D (HUF_DTable)((ZSTD_HUFFDTABLE_CAPACITY_=
LOG)*0x1000001);  /* cover both little and big endian */
=20
     /* parse dictionary content */
     FORWARD_IF_ERROR( ZSTD_loadEntropy_intoDDict(ddict, dictContentType) ,=
 "");
@@ -230,5 +231,5 @@ size_t ZSTD_sizeof_DDict(const ZSTD_DDict* ddict)
 unsigned ZSTD_getDictID_fromDDict(const ZSTD_DDict* ddict)
 {
     if (ddict=3D=3DNULL) return 0;
-    return ZSTD_getDictID_fromDict(ddict->dictContent, ddict->dictSize);
+    return ddict->dictID;
 }
diff --git a/lib/zstd/decompress/zstd_ddict.h b/lib/zstd/decompress/zstd_dd=
ict.h
index 2ad60da2c4f2..03b36f8aa959 100644
--- a/lib/zstd/decompress/zstd_ddict.h
+++ b/lib/zstd/decompress/zstd_ddict.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
diff --git a/lib/zstd/decompress/zstd_decompress.c b/lib/zstd/decompress/zs=
td_decompress.c
index 6537824629c3..171c0e10b939 100644
--- a/lib/zstd/decompress/zstd_decompress.c
+++ b/lib/zstd/decompress/zstd_decompress.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -51,13 +52,15 @@
 *  Dependencies
 *********************************************************/
 #include "../common/zstd_deps.h"   /* ZSTD_memcpy, ZSTD_memmove, ZSTD_mems=
et */
+#include "../common/allocations.h"  /* ZSTD_customMalloc, ZSTD_customCallo=
c, ZSTD_customFree */
+#include "../common/error_private.h"
+#include "../common/zstd_internal.h"  /* blockProperties_t */
 #include "../common/mem.h"         /* low level memory routines */
+#include "../common/bits.h"  /* ZSTD_highbit32 */
 #define FSE_STATIC_LINKING_ONLY
 #include "../common/fse.h"
-#define HUF_STATIC_LINKING_ONLY
 #include "../common/huf.h"
 #include <linux/xxhash.h> /* xxh64_reset, xxh64_update, xxh64_digest, XXH6=
4 */
-#include "../common/zstd_internal.h"  /* blockProperties_t */
 #include "zstd_decompress_internal.h"   /* ZSTD_DCtx */
 #include "zstd_ddict.h"  /* ZSTD_DDictDictContent */
 #include "zstd_decompress_block.h"   /* ZSTD_decompressBlock_internal */
@@ -67,11 +70,11 @@
  *************************************/
=20
 #define DDICT_HASHSET_MAX_LOAD_FACTOR_COUNT_MULT 4
-#define DDICT_HASHSET_MAX_LOAD_FACTOR_SIZE_MULT 3   /* These two constants=
 represent SIZE_MULT/COUNT_MULT load factor without using a float.
-                                                     * Currently, that mea=
ns a 0.75 load factor.
-                                                     * So, if count * COUN=
T_MULT / size * SIZE_MULT !=3D 0, then we've exceeded
-                                                     * the load factor of =
the ddict hash set.
-                                                     */
+#define DDICT_HASHSET_MAX_LOAD_FACTOR_SIZE_MULT 3  /* These two constants =
represent SIZE_MULT/COUNT_MULT load factor without using a float.
+                                                    * Currently, that mean=
s a 0.75 load factor.
+                                                    * So, if count * COUNT=
_MULT / size * SIZE_MULT !=3D 0, then we've exceeded
+                                                    * the load factor of t=
he ddict hash set.
+                                                    */
=20
 #define DDICT_HASHSET_TABLE_BASE_SIZE 64
 #define DDICT_HASHSET_RESIZE_FACTOR 2
@@ -231,6 +234,8 @@ static void ZSTD_DCtx_resetParameters(ZSTD_DCtx* dctx)
     dctx->outBufferMode =3D ZSTD_bm_buffered;
     dctx->forceIgnoreChecksum =3D ZSTD_d_validateChecksum;
     dctx->refMultipleDDicts =3D ZSTD_rmd_refSingleDDict;
+    dctx->disableHufAsm =3D 0;
+    dctx->maxBlockSizeParam =3D 0;
 }
=20
 static void ZSTD_initDCtx_internal(ZSTD_DCtx* dctx)
@@ -247,6 +252,7 @@ static void ZSTD_initDCtx_internal(ZSTD_DCtx* dctx)
     dctx->streamStage =3D zdss_init;
     dctx->noForwardProgress =3D 0;
     dctx->oversizedDuration =3D 0;
+    dctx->isFrameDecompression =3D 1;
 #if DYNAMIC_BMI2
     dctx->bmi2 =3D ZSTD_cpuSupportsBmi2();
 #endif
@@ -413,16 +419,40 @@ size_t ZSTD_frameHeaderSize(const void* src, size_t s=
rcSize)
  *  note : only works for formats ZSTD_f_zstd1 and ZSTD_f_zstd1_magicless
  * @return : 0, `zfhPtr` is correctly filled,
  *          >0, `srcSize` is too small, value is wanted `srcSize` amount,
- *           or an error code, which can be tested using ZSTD_isError() */
-size_t ZSTD_getFrameHeader_advanced(ZSTD_frameHeader* zfhPtr, const void* =
src, size_t srcSize, ZSTD_format_e format)
+**           or an error code, which can be tested using ZSTD_isError() */
+size_t ZSTD_getFrameHeader_advanced(ZSTD_FrameHeader* zfhPtr, const void* =
src, size_t srcSize, ZSTD_format_e format)
 {
     const BYTE* ip =3D (const BYTE*)src;
     size_t const minInputSize =3D ZSTD_startingInputLength(format);
=20
-    ZSTD_memset(zfhPtr, 0, sizeof(*zfhPtr));   /* not strictly necessary, =
but static analyzer do not understand that zfhPtr is only going to be read =
only if return value is zero, since they are 2 different signals */
-    if (srcSize < minInputSize) return minInputSize;
-    RETURN_ERROR_IF(src=3D=3DNULL, GENERIC, "invalid parameter");
+    DEBUGLOG(5, "ZSTD_getFrameHeader_advanced: minInputSize =3D %zu, srcSi=
ze =3D %zu", minInputSize, srcSize);
=20
+    if (srcSize > 0) {
+        /* note : technically could be considered an assert(), since it's =
an invalid entry */
+        RETURN_ERROR_IF(src=3D=3DNULL, GENERIC, "invalid parameter : src=
=3D=3DNULL, but srcSize>0");
+    }
+    if (srcSize < minInputSize) {
+        if (srcSize > 0 && format !=3D ZSTD_f_zstd1_magicless) {
+            /* when receiving less than @minInputSize bytes,
+             * control these bytes at least correspond to a supported magi=
c number
+             * in order to error out early if they don't.
+            **/
+            size_t const toCopy =3D MIN(4, srcSize);
+            unsigned char hbuf[4]; MEM_writeLE32(hbuf, ZSTD_MAGICNUMBER);
+            assert(src !=3D NULL);
+            ZSTD_memcpy(hbuf, src, toCopy);
+            if ( MEM_readLE32(hbuf) !=3D ZSTD_MAGICNUMBER ) {
+                /* not a zstd frame : let's check if it's a skippable fram=
e */
+                MEM_writeLE32(hbuf, ZSTD_MAGIC_SKIPPABLE_START);
+                ZSTD_memcpy(hbuf, src, toCopy);
+                if ((MEM_readLE32(hbuf) & ZSTD_MAGIC_SKIPPABLE_MASK) !=3D =
ZSTD_MAGIC_SKIPPABLE_START) {
+                    RETURN_ERROR(prefix_unknown,
+                                "first bytes don't correspond to any suppo=
rted magic number");
+        }   }   }
+        return minInputSize;
+    }
+
+    ZSTD_memset(zfhPtr, 0, sizeof(*zfhPtr));   /* not strictly necessary, =
but static analyzers may not understand that zfhPtr will be read only if re=
turn value is zero, since they are 2 different signals */
     if ( (format !=3D ZSTD_f_zstd1_magicless)
       && (MEM_readLE32(src) !=3D ZSTD_MAGICNUMBER) ) {
         if ((MEM_readLE32(src) & ZSTD_MAGIC_SKIPPABLE_MASK) =3D=3D ZSTD_MA=
GIC_SKIPPABLE_START) {
@@ -430,8 +460,10 @@ size_t ZSTD_getFrameHeader_advanced(ZSTD_frameHeader* =
zfhPtr, const void* src, s
             if (srcSize < ZSTD_SKIPPABLEHEADERSIZE)
                 return ZSTD_SKIPPABLEHEADERSIZE; /* magic number + frame l=
ength */
             ZSTD_memset(zfhPtr, 0, sizeof(*zfhPtr));
-            zfhPtr->frameContentSize =3D MEM_readLE32((const char *)src + =
ZSTD_FRAMEIDSIZE);
             zfhPtr->frameType =3D ZSTD_skippableFrame;
+            zfhPtr->dictID =3D MEM_readLE32(src) - ZSTD_MAGIC_SKIPPABLE_ST=
ART;
+            zfhPtr->headerSize =3D ZSTD_SKIPPABLEHEADERSIZE;
+            zfhPtr->frameContentSize =3D MEM_readLE32((const char *)src + =
ZSTD_FRAMEIDSIZE);
             return 0;
         }
         RETURN_ERROR(prefix_unknown, "");
@@ -500,7 +532,7 @@ size_t ZSTD_getFrameHeader_advanced(ZSTD_frameHeader* z=
fhPtr, const void* src, s
  * @return : 0, `zfhPtr` is correctly filled,
  *          >0, `srcSize` is too small, value is wanted `srcSize` amount,
  *           or an error code, which can be tested using ZSTD_isError() */
-size_t ZSTD_getFrameHeader(ZSTD_frameHeader* zfhPtr, const void* src, size=
_t srcSize)
+size_t ZSTD_getFrameHeader(ZSTD_FrameHeader* zfhPtr, const void* src, size=
_t srcSize)
 {
     return ZSTD_getFrameHeader_advanced(zfhPtr, src, srcSize, ZSTD_f_zstd1=
);
 }
@@ -512,7 +544,7 @@ size_t ZSTD_getFrameHeader(ZSTD_frameHeader* zfhPtr, co=
nst void* src, size_t src
  *         - ZSTD_CONTENTSIZE_ERROR if an error occurred (e.g. invalid mag=
ic number, srcSize too small) */
 unsigned long long ZSTD_getFrameContentSize(const void *src, size_t srcSiz=
e)
 {
-    {   ZSTD_frameHeader zfh;
+    {   ZSTD_FrameHeader zfh;
         if (ZSTD_getFrameHeader(&zfh, src, srcSize) !=3D 0)
             return ZSTD_CONTENTSIZE_ERROR;
         if (zfh.frameType =3D=3D ZSTD_skippableFrame) {
@@ -532,49 +564,52 @@ static size_t readSkippableFrameSize(void const* src,=
 size_t srcSize)
     sizeU32 =3D MEM_readLE32((BYTE const*)src + ZSTD_FRAMEIDSIZE);
     RETURN_ERROR_IF((U32)(sizeU32 + ZSTD_SKIPPABLEHEADERSIZE) < sizeU32,
                     frameParameter_unsupported, "");
-    {
-        size_t const skippableSize =3D skippableHeaderSize + sizeU32;
+    {   size_t const skippableSize =3D skippableHeaderSize + sizeU32;
         RETURN_ERROR_IF(skippableSize > srcSize, srcSize_wrong, "");
         return skippableSize;
     }
 }
=20
 /*! ZSTD_readSkippableFrame() :
- * Retrieves a zstd skippable frame containing data given by src, and writ=
es it to dst buffer.
+ * Retrieves content of a skippable frame, and writes it to dst buffer.
  *
  * The parameter magicVariant will receive the magicVariant that was suppl=
ied when the frame was written,
  * i.e. magicNumber - ZSTD_MAGIC_SKIPPABLE_START.  This can be NULL if the=
 caller is not interested
  * in the magicVariant.
  *
- * Returns an error if destination buffer is not large enough, or if the f=
rame is not skippable.
+ * Returns an error if destination buffer is not large enough, or if this =
is not a valid skippable frame.
  *
  * @return : number of bytes written or a ZSTD error.
  */
-ZSTDLIB_API size_t ZSTD_readSkippableFrame(void* dst, size_t dstCapacity, =
unsigned* magicVariant,
-                                            const void* src, size_t srcSiz=
e)
+size_t ZSTD_readSkippableFrame(void* dst, size_t dstCapacity,
+                               unsigned* magicVariant,  /* optional, can b=
e NULL */
+                         const void* src, size_t srcSize)
 {
-    U32 const magicNumber =3D MEM_readLE32(src);
-    size_t skippableFrameSize =3D readSkippableFrameSize(src, srcSize);
-    size_t skippableContentSize =3D skippableFrameSize - ZSTD_SKIPPABLEHEA=
DERSIZE;
-
-    /* check input validity */
-    RETURN_ERROR_IF(!ZSTD_isSkippableFrame(src, srcSize), frameParameter_u=
nsupported, "");
-    RETURN_ERROR_IF(skippableFrameSize < ZSTD_SKIPPABLEHEADERSIZE || skipp=
ableFrameSize > srcSize, srcSize_wrong, "");
-    RETURN_ERROR_IF(skippableContentSize > dstCapacity, dstSize_tooSmall, =
"");
+    RETURN_ERROR_IF(srcSize < ZSTD_SKIPPABLEHEADERSIZE, srcSize_wrong, "")=
;
=20
-    /* deliver payload */
-    if (skippableContentSize > 0  && dst !=3D NULL)
-        ZSTD_memcpy(dst, (const BYTE *)src + ZSTD_SKIPPABLEHEADERSIZE, ski=
ppableContentSize);
-    if (magicVariant !=3D NULL)
-        *magicVariant =3D magicNumber - ZSTD_MAGIC_SKIPPABLE_START;
-    return skippableContentSize;
+    {   U32 const magicNumber =3D MEM_readLE32(src);
+        size_t skippableFrameSize =3D readSkippableFrameSize(src, srcSize)=
;
+        size_t skippableContentSize =3D skippableFrameSize - ZSTD_SKIPPABL=
EHEADERSIZE;
+
+        /* check input validity */
+        RETURN_ERROR_IF(!ZSTD_isSkippableFrame(src, srcSize), frameParamet=
er_unsupported, "");
+        RETURN_ERROR_IF(skippableFrameSize < ZSTD_SKIPPABLEHEADERSIZE || s=
kippableFrameSize > srcSize, srcSize_wrong, "");
+        RETURN_ERROR_IF(skippableContentSize > dstCapacity, dstSize_tooSma=
ll, "");
+
+        /* deliver payload */
+        if (skippableContentSize > 0  && dst !=3D NULL)
+            ZSTD_memcpy(dst, (const BYTE *)src + ZSTD_SKIPPABLEHEADERSIZE,=
 skippableContentSize);
+        if (magicVariant !=3D NULL)
+            *magicVariant =3D magicNumber - ZSTD_MAGIC_SKIPPABLE_START;
+        return skippableContentSize;
+    }
 }
=20
 /* ZSTD_findDecompressedSize() :
- *  compatible with legacy mode
  *  `srcSize` must be the exact length of some number of ZSTD compressed a=
nd/or
  *      skippable frames
- *  @return : decompressed size of the frames contained */
+ *  note: compatible with legacy mode
+ * @return : decompressed size of the frames contained */
 unsigned long long ZSTD_findDecompressedSize(const void* src, size_t srcSi=
ze)
 {
     unsigned long long totalDstSize =3D 0;
@@ -584,9 +619,7 @@ unsigned long long ZSTD_findDecompressedSize(const void=
* src, size_t srcSize)
=20
         if ((magicNumber & ZSTD_MAGIC_SKIPPABLE_MASK) =3D=3D ZSTD_MAGIC_SK=
IPPABLE_START) {
             size_t const skippableSize =3D readSkippableFrameSize(src, src=
Size);
-            if (ZSTD_isError(skippableSize)) {
-                return ZSTD_CONTENTSIZE_ERROR;
-            }
+            if (ZSTD_isError(skippableSize)) return ZSTD_CONTENTSIZE_ERROR=
;
             assert(skippableSize <=3D srcSize);
=20
             src =3D (const BYTE *)src + skippableSize;
@@ -594,17 +627,17 @@ unsigned long long ZSTD_findDecompressedSize(const vo=
id* src, size_t srcSize)
             continue;
         }
=20
-        {   unsigned long long const ret =3D ZSTD_getFrameContentSize(src,=
 srcSize);
-            if (ret >=3D ZSTD_CONTENTSIZE_ERROR) return ret;
+        {   unsigned long long const fcs =3D ZSTD_getFrameContentSize(src,=
 srcSize);
+            if (fcs >=3D ZSTD_CONTENTSIZE_ERROR) return fcs;
=20
-            /* check for overflow */
-            if (totalDstSize + ret < totalDstSize) return ZSTD_CONTENTSIZE=
_ERROR;
-            totalDstSize +=3D ret;
+            if (totalDstSize + fcs < totalDstSize)
+                return ZSTD_CONTENTSIZE_ERROR; /* check for overflow */
+            totalDstSize +=3D fcs;
         }
+        /* skip to next frame */
         {   size_t const frameSrcSize =3D ZSTD_findFrameCompressedSize(src=
, srcSize);
-            if (ZSTD_isError(frameSrcSize)) {
-                return ZSTD_CONTENTSIZE_ERROR;
-            }
+            if (ZSTD_isError(frameSrcSize)) return ZSTD_CONTENTSIZE_ERROR;
+            assert(frameSrcSize <=3D srcSize);
=20
             src =3D (const BYTE *)src + frameSrcSize;
             srcSize -=3D frameSrcSize;
@@ -667,12 +700,12 @@ static ZSTD_frameSizeInfo ZSTD_errorFrameSizeInfo(siz=
e_t ret)
     return frameSizeInfo;
 }
=20
-static ZSTD_frameSizeInfo ZSTD_findFrameSizeInfo(const void* src, size_t s=
rcSize)
+static ZSTD_frameSizeInfo ZSTD_findFrameSizeInfo(const void* src, size_t s=
rcSize, ZSTD_format_e format)
 {
     ZSTD_frameSizeInfo frameSizeInfo;
     ZSTD_memset(&frameSizeInfo, 0, sizeof(ZSTD_frameSizeInfo));
=20
-    if ((srcSize >=3D ZSTD_SKIPPABLEHEADERSIZE)
+    if (format =3D=3D ZSTD_f_zstd1 && (srcSize >=3D ZSTD_SKIPPABLEHEADERSI=
ZE)
         && (MEM_readLE32(src) & ZSTD_MAGIC_SKIPPABLE_MASK) =3D=3D ZSTD_MAG=
IC_SKIPPABLE_START) {
         frameSizeInfo.compressedSize =3D readSkippableFrameSize(src, srcSi=
ze);
         assert(ZSTD_isError(frameSizeInfo.compressedSize) ||
@@ -683,10 +716,10 @@ static ZSTD_frameSizeInfo ZSTD_findFrameSizeInfo(cons=
t void* src, size_t srcSize
         const BYTE* const ipstart =3D ip;
         size_t remainingSize =3D srcSize;
         size_t nbBlocks =3D 0;
-        ZSTD_frameHeader zfh;
+        ZSTD_FrameHeader zfh;
=20
         /* Extract Frame Header */
-        {   size_t const ret =3D ZSTD_getFrameHeader(&zfh, src, srcSize);
+        {   size_t const ret =3D ZSTD_getFrameHeader_advanced(&zfh, src, s=
rcSize, format);
             if (ZSTD_isError(ret))
                 return ZSTD_errorFrameSizeInfo(ret);
             if (ret > 0)
@@ -720,28 +753,31 @@ static ZSTD_frameSizeInfo ZSTD_findFrameSizeInfo(cons=
t void* src, size_t srcSize
             ip +=3D 4;
         }
=20
+        frameSizeInfo.nbBlocks =3D nbBlocks;
         frameSizeInfo.compressedSize =3D (size_t)(ip - ipstart);
         frameSizeInfo.decompressedBound =3D (zfh.frameContentSize !=3D ZST=
D_CONTENTSIZE_UNKNOWN)
                                         ? zfh.frameContentSize
-                                        : nbBlocks * zfh.blockSizeMax;
+                                        : (unsigned long long)nbBlocks * z=
fh.blockSizeMax;
         return frameSizeInfo;
     }
 }
=20
+static size_t ZSTD_findFrameCompressedSize_advanced(const void *src, size_=
t srcSize, ZSTD_format_e format) {
+    ZSTD_frameSizeInfo const frameSizeInfo =3D ZSTD_findFrameSizeInfo(src,=
 srcSize, format);
+    return frameSizeInfo.compressedSize;
+}
+
 /* ZSTD_findFrameCompressedSize() :
- *  compatible with legacy mode
- *  `src` must point to the start of a ZSTD frame, ZSTD legacy frame, or s=
kippable frame
- *  `srcSize` must be at least as large as the frame contained
- *  @return : the compressed size of the frame starting at `src` */
+ * See docs in zstd.h
+ * Note: compatible with legacy mode */
 size_t ZSTD_findFrameCompressedSize(const void *src, size_t srcSize)
 {
-    ZSTD_frameSizeInfo const frameSizeInfo =3D ZSTD_findFrameSizeInfo(src,=
 srcSize);
-    return frameSizeInfo.compressedSize;
+    return ZSTD_findFrameCompressedSize_advanced(src, srcSize, ZSTD_f_zstd=
1);
 }
=20
 /* ZSTD_decompressBound() :
  *  compatible with legacy mode
- *  `src` must point to the start of a ZSTD frame or a skippeable frame
+ *  `src` must point to the start of a ZSTD frame or a skippable frame
  *  `srcSize` must be at least as large as the frame contained
  *  @return : the maximum decompressed size of the compressed source
  */
@@ -750,7 +786,7 @@ unsigned long long ZSTD_decompressBound(const void* src=
, size_t srcSize)
     unsigned long long bound =3D 0;
     /* Iterate over each frame */
     while (srcSize > 0) {
-        ZSTD_frameSizeInfo const frameSizeInfo =3D ZSTD_findFrameSizeInfo(=
src, srcSize);
+        ZSTD_frameSizeInfo const frameSizeInfo =3D ZSTD_findFrameSizeInfo(=
src, srcSize, ZSTD_f_zstd1);
         size_t const compressedSize =3D frameSizeInfo.compressedSize;
         unsigned long long const decompressedBound =3D frameSizeInfo.decom=
pressedBound;
         if (ZSTD_isError(compressedSize) || decompressedBound =3D=3D ZSTD_=
CONTENTSIZE_ERROR)
@@ -763,6 +799,49 @@ unsigned long long ZSTD_decompressBound(const void* sr=
c, size_t srcSize)
     return bound;
 }
=20
+size_t ZSTD_decompressionMargin(void const* src, size_t srcSize)
+{
+    size_t margin =3D 0;
+    unsigned maxBlockSize =3D 0;
+
+    /* Iterate over each frame */
+    while (srcSize > 0) {
+        ZSTD_frameSizeInfo const frameSizeInfo =3D ZSTD_findFrameSizeInfo(=
src, srcSize, ZSTD_f_zstd1);
+        size_t const compressedSize =3D frameSizeInfo.compressedSize;
+        unsigned long long const decompressedBound =3D frameSizeInfo.decom=
pressedBound;
+        ZSTD_FrameHeader zfh;
+
+        FORWARD_IF_ERROR(ZSTD_getFrameHeader(&zfh, src, srcSize), "");
+        if (ZSTD_isError(compressedSize) || decompressedBound =3D=3D ZSTD_=
CONTENTSIZE_ERROR)
+            return ERROR(corruption_detected);
+
+        if (zfh.frameType =3D=3D ZSTD_frame) {
+            /* Add the frame header to our margin */
+            margin +=3D zfh.headerSize;
+            /* Add the checksum to our margin */
+            margin +=3D zfh.checksumFlag ? 4 : 0;
+            /* Add 3 bytes per block */
+            margin +=3D 3 * frameSizeInfo.nbBlocks;
+
+            /* Compute the max block size */
+            maxBlockSize =3D MAX(maxBlockSize, zfh.blockSizeMax);
+        } else {
+            assert(zfh.frameType =3D=3D ZSTD_skippableFrame);
+            /* Add the entire skippable frame size to our margin. */
+            margin +=3D compressedSize;
+        }
+
+        assert(srcSize >=3D compressedSize);
+        src =3D (const BYTE*)src + compressedSize;
+        srcSize -=3D compressedSize;
+    }
+
+    /* Add the max block size back to the margin. */
+    margin +=3D maxBlockSize;
+
+    return margin;
+}
+
 /*-*************************************************************
  *   Frame decoding
  ***************************************************************/
@@ -786,7 +865,7 @@ static size_t ZSTD_copyRawBlock(void* dst, size_t dstCa=
pacity,
         if (srcSize =3D=3D 0) return 0;
         RETURN_ERROR(dstBuffer_null, "");
     }
-    ZSTD_memcpy(dst, src, srcSize);
+    ZSTD_memmove(dst, src, srcSize);
     return srcSize;
 }
=20
@@ -803,7 +882,7 @@ static size_t ZSTD_setRleBlock(void* dst, size_t dstCap=
acity,
     return regenSize;
 }
=20
-static void ZSTD_DCtx_trace_end(ZSTD_DCtx const* dctx, U64 uncompressedSiz=
e, U64 compressedSize, unsigned streaming)
+static void ZSTD_DCtx_trace_end(ZSTD_DCtx const* dctx, U64 uncompressedSiz=
e, U64 compressedSize, int streaming)
 {
     (void)dctx;
     (void)uncompressedSize;
@@ -843,8 +922,13 @@ static size_t ZSTD_decompressFrame(ZSTD_DCtx* dctx,
         ip +=3D frameHeaderSize; remainingSrcSize -=3D frameHeaderSize;
     }
=20
+    /* Shrink the blockSizeMax if enabled */
+    if (dctx->maxBlockSizeParam !=3D 0)
+        dctx->fParams.blockSizeMax =3D MIN(dctx->fParams.blockSizeMax, (un=
signed)dctx->maxBlockSizeParam);
+
     /* Loop on each block */
     while (1) {
+        BYTE* oBlockEnd =3D oend;
         size_t decodedSize;
         blockProperties_t blockProperties;
         size_t const cBlockSize =3D ZSTD_getcBlockSize(ip, remainingSrcSiz=
e, &blockProperties);
@@ -854,27 +938,48 @@ static size_t ZSTD_decompressFrame(ZSTD_DCtx* dctx,
         remainingSrcSize -=3D ZSTD_blockHeaderSize;
         RETURN_ERROR_IF(cBlockSize > remainingSrcSize, srcSize_wrong, "");
=20
+        if (ip >=3D op && ip < oBlockEnd) {
+            /* We are decompressing in-place. Limit the output pointer so =
that we
+             * don't overwrite the block that we are currently reading. Th=
is will
+             * fail decompression if the input & output pointers aren't sp=
aced
+             * far enough apart.
+             *
+             * This is important to set, even when the pointers are far en=
ough
+             * apart, because ZSTD_decompressBlock_internal() can decide t=
o store
+             * literals in the output buffer, after the block it is decomp=
ressing.
+             * Since we don't want anything to overwrite our input, we hav=
e to tell
+             * ZSTD_decompressBlock_internal to never write past ip.
+             *
+             * See ZSTD_allocateLiteralsBuffer() for reference.
+             */
+            oBlockEnd =3D op + (ip - op);
+        }
+
         switch(blockProperties.blockType)
         {
         case bt_compressed:
-            decodedSize =3D ZSTD_decompressBlock_internal(dctx, op, (size_=
t)(oend-op), ip, cBlockSize, /* frame */ 1, not_streaming);
+            assert(dctx->isFrameDecompression =3D=3D 1);
+            decodedSize =3D ZSTD_decompressBlock_internal(dctx, op, (size_=
t)(oBlockEnd-op), ip, cBlockSize, not_streaming);
             break;
         case bt_raw :
+            /* Use oend instead of oBlockEnd because this function is safe=
 to overlap. It uses memmove. */
             decodedSize =3D ZSTD_copyRawBlock(op, (size_t)(oend-op), ip, c=
BlockSize);
             break;
         case bt_rle :
-            decodedSize =3D ZSTD_setRleBlock(op, (size_t)(oend-op), *ip, b=
lockProperties.origSize);
+            decodedSize =3D ZSTD_setRleBlock(op, (size_t)(oBlockEnd-op), *=
ip, blockProperties.origSize);
             break;
         case bt_reserved :
         default:
             RETURN_ERROR(corruption_detected, "invalid block type");
         }
-
-        if (ZSTD_isError(decodedSize)) return decodedSize;
-        if (dctx->validateChecksum)
+        FORWARD_IF_ERROR(decodedSize, "Block decompression failure");
+        DEBUGLOG(5, "Decompressed block of dSize =3D %u", (unsigned)decode=
dSize);
+        if (dctx->validateChecksum) {
             xxh64_update(&dctx->xxhState, op, decodedSize);
-        if (decodedSize !=3D 0)
+        }
+        if (decodedSize) /* support dst =3D NULL,0 */ {
             op +=3D decodedSize;
+        }
         assert(ip !=3D NULL);
         ip +=3D cBlockSize;
         remainingSrcSize -=3D cBlockSize;
@@ -898,12 +1003,15 @@ static size_t ZSTD_decompressFrame(ZSTD_DCtx* dctx,
     }
     ZSTD_DCtx_trace_end(dctx, (U64)(op-ostart), (U64)(ip-istart), /* strea=
ming */ 0);
     /* Allow caller to get size read */
+    DEBUGLOG(4, "ZSTD_decompressFrame: decompressed frame of size %i, cons=
uming %i bytes of input", (int)(op-ostart), (int)(ip - (const BYTE*)*srcPtr=
));
     *srcPtr =3D ip;
     *srcSizePtr =3D remainingSrcSize;
     return (size_t)(op-ostart);
 }
=20
-static size_t ZSTD_decompressMultiFrame(ZSTD_DCtx* dctx,
+static
+ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
+size_t ZSTD_decompressMultiFrame(ZSTD_DCtx* dctx,
                                         void* dst, size_t dstCapacity,
                                   const void* src, size_t srcSize,
                                   const void* dict, size_t dictSize,
@@ -922,17 +1030,18 @@ static size_t ZSTD_decompressMultiFrame(ZSTD_DCtx* d=
ctx,
=20
     while (srcSize >=3D ZSTD_startingInputLength(dctx->format)) {
=20
-        {   U32 const magicNumber =3D MEM_readLE32(src);
-            DEBUGLOG(4, "reading magic number %08X (expecting %08X)",
-                        (unsigned)magicNumber, ZSTD_MAGICNUMBER);
+        if (dctx->format =3D=3D ZSTD_f_zstd1 && srcSize >=3D 4) {
+            U32 const magicNumber =3D MEM_readLE32(src);
+            DEBUGLOG(5, "reading magic number %08X", (unsigned)magicNumber=
);
             if ((magicNumber & ZSTD_MAGIC_SKIPPABLE_MASK) =3D=3D ZSTD_MAGI=
C_SKIPPABLE_START) {
+                /* skippable frame detected : skip it */
                 size_t const skippableSize =3D readSkippableFrameSize(src,=
 srcSize);
-                FORWARD_IF_ERROR(skippableSize, "readSkippableFrameSize fa=
iled");
+                FORWARD_IF_ERROR(skippableSize, "invalid skippable frame")=
;
                 assert(skippableSize <=3D srcSize);
=20
                 src =3D (const BYTE *)src + skippableSize;
                 srcSize -=3D skippableSize;
-                continue;
+                continue; /* check next frame */
         }   }
=20
         if (ddict) {
@@ -1025,8 +1134,8 @@ size_t ZSTD_decompress(void* dst, size_t dstCapacity,=
 const void* src, size_t sr
 size_t ZSTD_nextSrcSizeToDecompress(ZSTD_DCtx* dctx) { return dctx->expect=
ed; }
=20
 /*
- * Similar to ZSTD_nextSrcSizeToDecompress(), but when a block input can b=
e streamed,
- * we allow taking a partial block as the input. Currently only raw uncomp=
ressed blocks can
+ * Similar to ZSTD_nextSrcSizeToDecompress(), but when a block input can b=
e streamed, we
+ * allow taking a partial block as the input. Currently only raw uncompres=
sed blocks can
  * be streamed.
  *
  * For blocks that can be streamed, this allows us to reduce the latency u=
ntil we produce
@@ -1145,7 +1254,8 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx* dctx, void*=
 dst, size_t dstCapacity, c
             {
             case bt_compressed:
                 DEBUGLOG(5, "ZSTD_decompressContinue: case bt_compressed")=
;
-                rSize =3D ZSTD_decompressBlock_internal(dctx, dst, dstCapa=
city, src, srcSize, /* frame */ 1, is_streaming);
+                assert(dctx->isFrameDecompression =3D=3D 1);
+                rSize =3D ZSTD_decompressBlock_internal(dctx, dst, dstCapa=
city, src, srcSize, is_streaming);
                 dctx->expected =3D 0;  /* Streaming not supported */
                 break;
             case bt_raw :
@@ -1214,6 +1324,7 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx* dctx, void*=
 dst, size_t dstCapacity, c
     case ZSTDds_decodeSkippableHeader:
         assert(src !=3D NULL);
         assert(srcSize <=3D ZSTD_SKIPPABLEHEADERSIZE);
+        assert(dctx->format !=3D ZSTD_f_zstd1_magicless);
         ZSTD_memcpy(dctx->headerBuffer + (ZSTD_SKIPPABLEHEADERSIZE - srcSi=
ze), src, srcSize);   /* complete skippable header */
         dctx->expected =3D MEM_readLE32(dctx->headerBuffer + ZSTD_FRAMEIDS=
IZE);   /* note : dctx->expected can grow seriously large, beyond local buf=
fer size */
         dctx->stage =3D ZSTDds_skipFrame;
@@ -1226,7 +1337,7 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx* dctx, void*=
 dst, size_t dstCapacity, c
=20
     default:
         assert(0);   /* impossible */
-        RETURN_ERROR(GENERIC, "impossible to reach");   /* some compiler r=
equire default to do something */
+        RETURN_ERROR(GENERIC, "impossible to reach");   /* some compilers =
require default to do something */
     }
 }
=20
@@ -1266,11 +1377,11 @@ ZSTD_loadDEntropy(ZSTD_entropyDTables_t* entropy,
         /* in minimal huffman, we always use X1 variants */
         size_t const hSize =3D HUF_readDTableX1_wksp(entropy->hufTable,
                                                 dictPtr, dictEnd - dictPtr=
,
-                                                workspace, workspaceSize);
+                                                workspace, workspaceSize, =
/* flags */ 0);
 #else
         size_t const hSize =3D HUF_readDTableX2_wksp(entropy->hufTable,
                                                 dictPtr, (size_t)(dictEnd =
- dictPtr),
-                                                workspace, workspaceSize);
+                                                workspace, workspaceSize, =
/* flags */ 0);
 #endif
         RETURN_ERROR_IF(HUF_isError(hSize), dictionary_corrupted, "");
         dictPtr +=3D hSize;
@@ -1366,10 +1477,11 @@ size_t ZSTD_decompressBegin(ZSTD_DCtx* dctx)
     dctx->prefixStart =3D NULL;
     dctx->virtualStart =3D NULL;
     dctx->dictEnd =3D NULL;
-    dctx->entropy.hufTable[0] =3D (HUF_DTable)((HufLog)*0x1000001);  /* co=
ver both little and big endian */
+    dctx->entropy.hufTable[0] =3D (HUF_DTable)((ZSTD_HUFFDTABLE_CAPACITY_L=
OG)*0x1000001);  /* cover both little and big endian */
     dctx->litEntropy =3D dctx->fseEntropy =3D 0;
     dctx->dictID =3D 0;
     dctx->bType =3D bt_reserved;
+    dctx->isFrameDecompression =3D 1;
     ZSTD_STATIC_ASSERT(sizeof(dctx->entropy.rep) =3D=3D sizeof(repStartVal=
ue));
     ZSTD_memcpy(dctx->entropy.rep, repStartValue, sizeof(repStartValue)); =
 /* initial repcodes */
     dctx->LLTptr =3D dctx->entropy.LLTable;
@@ -1427,7 +1539,7 @@ unsigned ZSTD_getDictID_fromDict(const void* dict, si=
ze_t dictSize)
  *  This could for one of the following reasons :
  *  - The frame does not require a dictionary (most common case).
  *  - The frame was built with dictID intentionally removed.
- *    Needed dictionary is a hidden information.
+ *    Needed dictionary is a hidden piece of information.
  *    Note : this use case also happens when using a non-conformant dictio=
nary.
  *  - `srcSize` is too small, and as a result, frame header could not be d=
ecoded.
  *    Note : possible if `srcSize < ZSTD_FRAMEHEADERSIZE_MAX`.
@@ -1436,7 +1548,7 @@ unsigned ZSTD_getDictID_fromDict(const void* dict, si=
ze_t dictSize)
  *  ZSTD_getFrameHeader(), which will provide a more precise error code. *=
/
 unsigned ZSTD_getDictID_fromFrame(const void* src, size_t srcSize)
 {
-    ZSTD_frameHeader zfp =3D { 0, 0, 0, ZSTD_frame, 0, 0, 0 };
+    ZSTD_FrameHeader zfp =3D { 0, 0, 0, ZSTD_frame, 0, 0, 0, 0, 0 };
     size_t const hError =3D ZSTD_getFrameHeader(&zfp, src, srcSize);
     if (ZSTD_isError(hError)) return 0;
     return zfp.dictID;
@@ -1539,7 +1651,9 @@ size_t ZSTD_initDStream_usingDict(ZSTD_DStream* zds, =
const void* dict, size_t di
 size_t ZSTD_initDStream(ZSTD_DStream* zds)
 {
     DEBUGLOG(4, "ZSTD_initDStream");
-    return ZSTD_initDStream_usingDDict(zds, NULL);
+    FORWARD_IF_ERROR(ZSTD_DCtx_reset(zds, ZSTD_reset_session_only), "");
+    FORWARD_IF_ERROR(ZSTD_DCtx_refDDict(zds, NULL), "");
+    return ZSTD_startingInputLength(zds->format);
 }
=20
 /* ZSTD_initDStream_usingDDict() :
@@ -1547,6 +1661,7 @@ size_t ZSTD_initDStream(ZSTD_DStream* zds)
  * this function cannot fail */
 size_t ZSTD_initDStream_usingDDict(ZSTD_DStream* dctx, const ZSTD_DDict* d=
dict)
 {
+    DEBUGLOG(4, "ZSTD_initDStream_usingDDict");
     FORWARD_IF_ERROR( ZSTD_DCtx_reset(dctx, ZSTD_reset_session_only) , "")=
;
     FORWARD_IF_ERROR( ZSTD_DCtx_refDDict(dctx, ddict) , "");
     return ZSTD_startingInputLength(dctx->format);
@@ -1557,6 +1672,7 @@ size_t ZSTD_initDStream_usingDDict(ZSTD_DStream* dctx=
, const ZSTD_DDict* ddict)
  * this function cannot fail */
 size_t ZSTD_resetDStream(ZSTD_DStream* dctx)
 {
+    DEBUGLOG(4, "ZSTD_resetDStream");
     FORWARD_IF_ERROR(ZSTD_DCtx_reset(dctx, ZSTD_reset_session_only), "");
     return ZSTD_startingInputLength(dctx->format);
 }
@@ -1627,6 +1743,15 @@ ZSTD_bounds ZSTD_dParam_getBounds(ZSTD_dParameter dP=
aram)
             bounds.lowerBound =3D (int)ZSTD_rmd_refSingleDDict;
             bounds.upperBound =3D (int)ZSTD_rmd_refMultipleDDicts;
             return bounds;
+        case ZSTD_d_disableHuffmanAssembly:
+            bounds.lowerBound =3D 0;
+            bounds.upperBound =3D 1;
+            return bounds;
+        case ZSTD_d_maxBlockSize:
+            bounds.lowerBound =3D ZSTD_BLOCKSIZE_MAX_MIN;
+            bounds.upperBound =3D ZSTD_BLOCKSIZE_MAX;
+            return bounds;
+
         default:;
     }
     bounds.error =3D ERROR(parameter_unsupported);
@@ -1667,6 +1792,12 @@ size_t ZSTD_DCtx_getParameter(ZSTD_DCtx* dctx, ZSTD_=
dParameter param, int* value
         case ZSTD_d_refMultipleDDicts:
             *value =3D (int)dctx->refMultipleDDicts;
             return 0;
+        case ZSTD_d_disableHuffmanAssembly:
+            *value =3D (int)dctx->disableHufAsm;
+            return 0;
+        case ZSTD_d_maxBlockSize:
+            *value =3D dctx->maxBlockSizeParam;
+            return 0;
         default:;
     }
     RETURN_ERROR(parameter_unsupported, "");
@@ -1700,6 +1831,14 @@ size_t ZSTD_DCtx_setParameter(ZSTD_DCtx* dctx, ZSTD_=
dParameter dParam, int value
             }
             dctx->refMultipleDDicts =3D (ZSTD_refMultipleDDicts_e)value;
             return 0;
+        case ZSTD_d_disableHuffmanAssembly:
+            CHECK_DBOUNDS(ZSTD_d_disableHuffmanAssembly, value);
+            dctx->disableHufAsm =3D value !=3D 0;
+            return 0;
+        case ZSTD_d_maxBlockSize:
+            if (value !=3D 0) CHECK_DBOUNDS(ZSTD_d_maxBlockSize, value);
+            dctx->maxBlockSizeParam =3D value;
+            return 0;
         default:;
     }
     RETURN_ERROR(parameter_unsupported, "");
@@ -1711,6 +1850,7 @@ size_t ZSTD_DCtx_reset(ZSTD_DCtx* dctx, ZSTD_ResetDir=
ective reset)
       || (reset =3D=3D ZSTD_reset_session_and_parameters) ) {
         dctx->streamStage =3D zdss_init;
         dctx->noForwardProgress =3D 0;
+        dctx->isFrameDecompression =3D 1;
     }
     if ( (reset =3D=3D ZSTD_reset_parameters)
       || (reset =3D=3D ZSTD_reset_session_and_parameters) ) {
@@ -1726,11 +1866,17 @@ size_t ZSTD_sizeof_DStream(const ZSTD_DStream* dctx=
)
     return ZSTD_sizeof_DCtx(dctx);
 }
=20
-size_t ZSTD_decodingBufferSize_min(unsigned long long windowSize, unsigned=
 long long frameContentSize)
+static size_t ZSTD_decodingBufferSize_internal(unsigned long long windowSi=
ze, unsigned long long frameContentSize, size_t blockSizeMax)
 {
-    size_t const blockSize =3D (size_t) MIN(windowSize, ZSTD_BLOCKSIZE_MAX=
);
-    /* space is needed to store the litbuffer after the output of a given =
block without stomping the extDict of a previous run, as well as to cover b=
oth windows against wildcopy*/
-    unsigned long long const neededRBSize =3D windowSize + blockSize + ZST=
D_BLOCKSIZE_MAX + (WILDCOPY_OVERLENGTH * 2);
+    size_t const blockSize =3D MIN((size_t)MIN(windowSize, ZSTD_BLOCKSIZE_=
MAX), blockSizeMax);
+    /* We need blockSize + WILDCOPY_OVERLENGTH worth of buffer so that if =
a block
+     * ends at windowSize + WILDCOPY_OVERLENGTH + 1 bytes, we can start wr=
iting
+     * the block at the beginning of the output buffer, and maintain a ful=
l window.
+     *
+     * We need another blockSize worth of buffer so that we can store spli=
t
+     * literals at the end of the block without overwriting the extDict wi=
ndow.
+     */
+    unsigned long long const neededRBSize =3D windowSize + (blockSize * 2)=
 + (WILDCOPY_OVERLENGTH * 2);
     unsigned long long const neededSize =3D MIN(frameContentSize, neededRB=
Size);
     size_t const minRBSize =3D (size_t) neededSize;
     RETURN_ERROR_IF((unsigned long long)minRBSize !=3D neededSize,
@@ -1738,6 +1884,11 @@ size_t ZSTD_decodingBufferSize_min(unsigned long lon=
g windowSize, unsigned long
     return minRBSize;
 }
=20
+size_t ZSTD_decodingBufferSize_min(unsigned long long windowSize, unsigned=
 long long frameContentSize)
+{
+    return ZSTD_decodingBufferSize_internal(windowSize, frameContentSize, =
ZSTD_BLOCKSIZE_MAX);
+}
+
 size_t ZSTD_estimateDStreamSize(size_t windowSize)
 {
     size_t const blockSize =3D MIN(windowSize, ZSTD_BLOCKSIZE_MAX);
@@ -1749,7 +1900,7 @@ size_t ZSTD_estimateDStreamSize(size_t windowSize)
 size_t ZSTD_estimateDStreamSize_fromFrame(const void* src, size_t srcSize)
 {
     U32 const windowSizeMax =3D 1U << ZSTD_WINDOWLOG_MAX;   /* note : shou=
ld be user-selectable, but requires an additional parameter (or a dctx) */
-    ZSTD_frameHeader zfh;
+    ZSTD_FrameHeader zfh;
     size_t const err =3D ZSTD_getFrameHeader(&zfh, src, srcSize);
     if (ZSTD_isError(err)) return err;
     RETURN_ERROR_IF(err>0, srcSize_wrong, "");
@@ -1843,6 +1994,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD_=
outBuffer* output, ZSTD_inB
     U32 someMoreWork =3D 1;
=20
     DEBUGLOG(5, "ZSTD_decompressStream");
+    assert(zds !=3D NULL);
     RETURN_ERROR_IF(
         input->pos > input->size,
         srcSize_wrong,
@@ -1873,7 +2025,6 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD_=
outBuffer* output, ZSTD_inB
                 if (zds->refMultipleDDicts && zds->ddictSet) {
                     ZSTD_DCtx_selectFrameDDict(zds);
                 }
-                DEBUGLOG(5, "header size : %u", (U32)hSize);
                 if (ZSTD_isError(hSize)) {
                     return hSize;   /* error */
                 }
@@ -1887,6 +2038,11 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD=
_outBuffer* output, ZSTD_inB
                             zds->lhSize +=3D remainingInput;
                         }
                         input->pos =3D input->size;
+                        /* check first few bytes */
+                        FORWARD_IF_ERROR(
+                            ZSTD_getFrameHeader_advanced(&zds->fParams, zd=
s->headerBuffer, zds->lhSize, zds->format),
+                            "First few bytes detected incorrect" );
+                        /* return hint input size */
                         return (MAX((size_t)ZSTD_FRAMEHEADERSIZE_MIN(zds->=
format), hSize) - zds->lhSize) + ZSTD_blockHeaderSize;   /* remaining heade=
r bytes + next block header */
                     }
                     assert(ip !=3D NULL);
@@ -1898,14 +2054,15 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZST=
D_outBuffer* output, ZSTD_inB
             if (zds->fParams.frameContentSize !=3D ZSTD_CONTENTSIZE_UNKNOW=
N
                 && zds->fParams.frameType !=3D ZSTD_skippableFrame
                 && (U64)(size_t)(oend-op) >=3D zds->fParams.frameContentSi=
ze) {
-                size_t const cSize =3D ZSTD_findFrameCompressedSize(istart=
, (size_t)(iend-istart));
+                size_t const cSize =3D ZSTD_findFrameCompressedSize_advanc=
ed(istart, (size_t)(iend-istart), zds->format);
                 if (cSize <=3D (size_t)(iend-istart)) {
                     /* shortcut : using single-pass mode */
                     size_t const decompressedSize =3D ZSTD_decompress_usin=
gDDict(zds, op, (size_t)(oend-op), istart, cSize, ZSTD_getDDict(zds));
                     if (ZSTD_isError(decompressedSize)) return decompresse=
dSize;
-                    DEBUGLOG(4, "shortcut to single-pass ZSTD_decompress_u=
singDDict()")
+                    DEBUGLOG(4, "shortcut to single-pass ZSTD_decompress_u=
singDDict()");
+                    assert(istart !=3D NULL);
                     ip =3D istart + cSize;
-                    op +=3D decompressedSize;
+                    op =3D op ? op + decompressedSize : op; /* can occur i=
f frameContentSize =3D 0 (empty frame) */
                     zds->expected =3D 0;
                     zds->streamStage =3D zdss_init;
                     someMoreWork =3D 0;
@@ -1924,7 +2081,8 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD_=
outBuffer* output, ZSTD_inB
             DEBUGLOG(4, "Consume header");
             FORWARD_IF_ERROR(ZSTD_decompressBegin_usingDDict(zds, ZSTD_get=
DDict(zds)), "");
=20
-            if ((MEM_readLE32(zds->headerBuffer) & ZSTD_MAGIC_SKIPPABLE_MA=
SK) =3D=3D ZSTD_MAGIC_SKIPPABLE_START) {  /* skippable frame */
+            if (zds->format =3D=3D ZSTD_f_zstd1
+                && (MEM_readLE32(zds->headerBuffer) & ZSTD_MAGIC_SKIPPABLE=
_MASK) =3D=3D ZSTD_MAGIC_SKIPPABLE_START) {  /* skippable frame */
                 zds->expected =3D MEM_readLE32(zds->headerBuffer + ZSTD_FR=
AMEIDSIZE);
                 zds->stage =3D ZSTDds_skipFrame;
             } else {
@@ -1940,11 +2098,13 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZST=
D_outBuffer* output, ZSTD_inB
             zds->fParams.windowSize =3D MAX(zds->fParams.windowSize, 1U <<=
 ZSTD_WINDOWLOG_ABSOLUTEMIN);
             RETURN_ERROR_IF(zds->fParams.windowSize > zds->maxWindowSize,
                             frameParameter_windowTooLarge, "");
+            if (zds->maxBlockSizeParam !=3D 0)
+                zds->fParams.blockSizeMax =3D MIN(zds->fParams.blockSizeMa=
x, (unsigned)zds->maxBlockSizeParam);
=20
             /* Adapt buffer sizes to frame header instructions */
             {   size_t const neededInBuffSize =3D MAX(zds->fParams.blockSi=
zeMax, 4 /* frame checksum */);
                 size_t const neededOutBuffSize =3D zds->outBufferMode =3D=
=3D ZSTD_bm_buffered
-                        ? ZSTD_decodingBufferSize_min(zds->fParams.windowS=
ize, zds->fParams.frameContentSize)
+                        ? ZSTD_decodingBufferSize_internal(zds->fParams.wi=
ndowSize, zds->fParams.frameContentSize, zds->fParams.blockSizeMax)
                         : 0;
=20
                 ZSTD_DCtx_updateOversizedDuration(zds, neededInBuffSize, n=
eededOutBuffSize);
@@ -1989,6 +2149,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD_=
outBuffer* output, ZSTD_inB
                 }
                 if ((size_t)(iend-ip) >=3D neededInSize) {  /* decode dire=
ctly from src */
                     FORWARD_IF_ERROR(ZSTD_decompressContinueStream(zds, &o=
p, oend, ip, neededInSize), "");
+                    assert(ip !=3D NULL);
                     ip +=3D neededInSize;
                     /* Function modifies the stage so we must break */
                     break;
@@ -2003,7 +2164,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD_=
outBuffer* output, ZSTD_inB
                 int const isSkipFrame =3D ZSTD_isSkipFrame(zds);
                 size_t loadedSize;
                 /* At this point we shouldn't be decompressing a block tha=
t we can stream. */
-                assert(neededInSize =3D=3D ZSTD_nextSrcSizeToDecompressWit=
hInputSize(zds, iend - ip));
+                assert(neededInSize =3D=3D ZSTD_nextSrcSizeToDecompressWit=
hInputSize(zds, (size_t)(iend - ip)));
                 if (isSkipFrame) {
                     loadedSize =3D MIN(toLoad, (size_t)(iend-ip));
                 } else {
@@ -2012,8 +2173,11 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD=
_outBuffer* output, ZSTD_inB
                                     "should never happen");
                     loadedSize =3D ZSTD_limitCopy(zds->inBuff + zds->inPos=
, toLoad, ip, (size_t)(iend-ip));
                 }
-                ip +=3D loadedSize;
-                zds->inPos +=3D loadedSize;
+                if (loadedSize !=3D 0) {
+                    /* ip may be NULL */
+                    ip +=3D loadedSize;
+                    zds->inPos +=3D loadedSize;
+                }
                 if (loadedSize < toLoad) { someMoreWork =3D 0; break; }   =
/* not enough input, wait for more */
=20
                 /* decode loaded input */
@@ -2023,14 +2187,17 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZST=
D_outBuffer* output, ZSTD_inB
                 break;
             }
         case zdss_flush:
-            {   size_t const toFlushSize =3D zds->outEnd - zds->outStart;
+            {
+                size_t const toFlushSize =3D zds->outEnd - zds->outStart;
                 size_t const flushedSize =3D ZSTD_limitCopy(op, (size_t)(o=
end-op), zds->outBuff + zds->outStart, toFlushSize);
-                op +=3D flushedSize;
+
+                op =3D op ? op + flushedSize : op;
+
                 zds->outStart +=3D flushedSize;
                 if (flushedSize =3D=3D toFlushSize) {  /* flush completed =
*/
                     zds->streamStage =3D zdss_read;
                     if ( (zds->outBuffSize < zds->fParams.frameContentSize=
)
-                      && (zds->outStart + zds->fParams.blockSizeMax > zds-=
>outBuffSize) ) {
+                        && (zds->outStart + zds->fParams.blockSizeMax > zd=
s->outBuffSize) ) {
                         DEBUGLOG(5, "restart filling outBuff from beginnin=
g (left:%i, needed:%u)",
                                 (int)(zds->outBuffSize - zds->outStart),
                                 (U32)zds->fParams.blockSizeMax);
@@ -2044,7 +2211,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD_=
outBuffer* output, ZSTD_inB
=20
         default:
             assert(0);    /* impossible */
-            RETURN_ERROR(GENERIC, "impossible to reach");   /* some compil=
er require default to do something */
+            RETURN_ERROR(GENERIC, "impossible to reach");   /* some compil=
ers require default to do something */
     }   }
=20
     /* result */
@@ -2057,8 +2224,8 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD_=
outBuffer* output, ZSTD_inB
     if ((ip=3D=3Distart) && (op=3D=3Dostart)) {  /* no forward progress */
         zds->noForwardProgress ++;
         if (zds->noForwardProgress >=3D ZSTD_NO_FORWARD_PROGRESS_MAX) {
-            RETURN_ERROR_IF(op=3D=3Doend, dstSize_tooSmall, "");
-            RETURN_ERROR_IF(ip=3D=3Diend, srcSize_wrong, "");
+            RETURN_ERROR_IF(op=3D=3Doend, noForwardProgress_destFull, "");
+            RETURN_ERROR_IF(ip=3D=3Diend, noForwardProgress_inputEmpty, ""=
);
             assert(0);
         }
     } else {
@@ -2095,11 +2262,17 @@ size_t ZSTD_decompressStream_simpleArgs (
                             void* dst, size_t dstCapacity, size_t* dstPos,
                       const void* src, size_t srcSize, size_t* srcPos)
 {
-    ZSTD_outBuffer output =3D { dst, dstCapacity, *dstPos };
-    ZSTD_inBuffer  input  =3D { src, srcSize, *srcPos };
-    /* ZSTD_compress_generic() will check validity of dstPos and srcPos */
-    size_t const cErr =3D ZSTD_decompressStream(dctx, &output, &input);
-    *dstPos =3D output.pos;
-    *srcPos =3D input.pos;
-    return cErr;
+    ZSTD_outBuffer output;
+    ZSTD_inBuffer  input;
+    output.dst =3D dst;
+    output.size =3D dstCapacity;
+    output.pos =3D *dstPos;
+    input.src =3D src;
+    input.size =3D srcSize;
+    input.pos =3D *srcPos;
+    {   size_t const cErr =3D ZSTD_decompressStream(dctx, &output, &input)=
;
+        *dstPos =3D output.pos;
+        *srcPos =3D input.pos;
+        return cErr;
+    }
 }
diff --git a/lib/zstd/decompress/zstd_decompress_block.c b/lib/zstd/decompr=
ess/zstd_decompress_block.c
index 6e46a1bc5242..bc20330cfa1d 100644
--- a/lib/zstd/decompress/zstd_decompress_block.c
+++ b/lib/zstd/decompress/zstd_decompress_block.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -20,12 +21,12 @@
 #include "../common/mem.h"         /* low level memory routines */
 #define FSE_STATIC_LINKING_ONLY
 #include "../common/fse.h"
-#define HUF_STATIC_LINKING_ONLY
 #include "../common/huf.h"
 #include "../common/zstd_internal.h"
 #include "zstd_decompress_internal.h"   /* ZSTD_DCtx */
 #include "zstd_ddict.h"  /* ZSTD_DDictDictContent */
 #include "zstd_decompress_block.h"
+#include "../common/bits.h"  /* ZSTD_highbit32 */
=20
 /*_*******************************************************
 *  Macros
@@ -49,6 +50,13 @@ static void ZSTD_copy4(void* dst, const void* src) { ZST=
D_memcpy(dst, src, 4); }
  *   Block decoding
  ***************************************************************/
=20
+static size_t ZSTD_blockSizeMax(ZSTD_DCtx const* dctx)
+{
+    size_t const blockSizeMax =3D dctx->isFrameDecompression ? dctx->fPara=
ms.blockSizeMax : ZSTD_BLOCKSIZE_MAX;
+    assert(blockSizeMax <=3D ZSTD_BLOCKSIZE_MAX);
+    return blockSizeMax;
+}
+
 /*! ZSTD_getcBlockSize() :
  *  Provides the size of compressed block from block header `src` */
 size_t ZSTD_getcBlockSize(const void* src, size_t srcSize,
@@ -71,41 +79,49 @@ size_t ZSTD_getcBlockSize(const void* src, size_t srcSi=
ze,
 static void ZSTD_allocateLiteralsBuffer(ZSTD_DCtx* dctx, void* const dst, =
const size_t dstCapacity, const size_t litSize,
     const streaming_operation streaming, const size_t expectedWriteSize, c=
onst unsigned splitImmediately)
 {
-    if (streaming =3D=3D not_streaming && dstCapacity > ZSTD_BLOCKSIZE_MAX=
 + WILDCOPY_OVERLENGTH + litSize + WILDCOPY_OVERLENGTH)
-    {
-        /* room for litbuffer to fit without read faulting */
-        dctx->litBuffer =3D (BYTE*)dst + ZSTD_BLOCKSIZE_MAX + WILDCOPY_OVE=
RLENGTH;
+    size_t const blockSizeMax =3D ZSTD_blockSizeMax(dctx);
+    assert(litSize <=3D blockSizeMax);
+    assert(dctx->isFrameDecompression || streaming =3D=3D not_streaming);
+    assert(expectedWriteSize <=3D blockSizeMax);
+    if (streaming =3D=3D not_streaming && dstCapacity > blockSizeMax + WIL=
DCOPY_OVERLENGTH + litSize + WILDCOPY_OVERLENGTH) {
+        /* If we aren't streaming, we can just put the literals after the =
output
+         * of the current block. We don't need to worry about overwriting =
the
+         * extDict of our window, because it doesn't exist.
+         * So if we have space after the end of the block, just put it the=
re.
+         */
+        dctx->litBuffer =3D (BYTE*)dst + blockSizeMax + WILDCOPY_OVERLENGT=
H;
         dctx->litBufferEnd =3D dctx->litBuffer + litSize;
         dctx->litBufferLocation =3D ZSTD_in_dst;
-    }
-    else if (litSize > ZSTD_LITBUFFEREXTRASIZE)
-    {
-        /* won't fit in litExtraBuffer, so it will be split between end of=
 dst and extra buffer */
+    } else if (litSize <=3D ZSTD_LITBUFFEREXTRASIZE) {
+        /* Literals fit entirely within the extra buffer, put them there t=
o avoid
+         * having to split the literals.
+         */
+        dctx->litBuffer =3D dctx->litExtraBuffer;
+        dctx->litBufferEnd =3D dctx->litBuffer + litSize;
+        dctx->litBufferLocation =3D ZSTD_not_in_dst;
+    } else {
+        assert(blockSizeMax > ZSTD_LITBUFFEREXTRASIZE);
+        /* Literals must be split between the output block and the extra l=
it
+         * buffer. We fill the extra lit buffer with the tail of the liter=
als,
+         * and put the rest of the literals at the end of the block, with
+         * WILDCOPY_OVERLENGTH of buffer room to allow for overreads.
+         * This MUST not write more than our maxBlockSize beyond dst, beca=
use in
+         * streaming mode, that could overwrite part of our extDict window=
.
+         */
         if (splitImmediately) {
             /* won't fit in litExtraBuffer, so it will be split between en=
d of dst and extra buffer */
             dctx->litBuffer =3D (BYTE*)dst + expectedWriteSize - litSize +=
 ZSTD_LITBUFFEREXTRASIZE - WILDCOPY_OVERLENGTH;
             dctx->litBufferEnd =3D dctx->litBuffer + litSize - ZSTD_LITBUF=
FEREXTRASIZE;
-        }
-        else {
-            /* initially this will be stored entirely in dst during huffma=
n decoding, it will partially shifted to litExtraBuffer after */
+        } else {
+            /* initially this will be stored entirely in dst during huffma=
n decoding, it will partially be shifted to litExtraBuffer after */
             dctx->litBuffer =3D (BYTE*)dst + expectedWriteSize - litSize;
             dctx->litBufferEnd =3D (BYTE*)dst + expectedWriteSize;
         }
         dctx->litBufferLocation =3D ZSTD_split;
-    }
-    else
-    {
-        /* fits entirely within litExtraBuffer, so no split is necessary *=
/
-        dctx->litBuffer =3D dctx->litExtraBuffer;
-        dctx->litBufferEnd =3D dctx->litBuffer + litSize;
-        dctx->litBufferLocation =3D ZSTD_not_in_dst;
+        assert(dctx->litBufferEnd <=3D (BYTE*)dst + expectedWriteSize);
     }
 }
=20
-/* Hidden declaration for fullbench */
-size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
-                          const void* src, size_t srcSize,
-                          void* dst, size_t dstCapacity, const streaming_o=
peration streaming);
 /*! ZSTD_decodeLiteralsBlock() :
  * Where it is possible to do so without being stomped by the output durin=
g decompression, the literals block will be stored
  * in the dstBuffer.  If there is room to do so, it will be stored in full=
 in the excess dst space after where the current
@@ -114,7 +130,7 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
  *
  * @return : nb of bytes read from src (< srcSize )
  *  note : symbol not declared but exposed for fullbench */
-size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
+static size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                           const void* src, size_t srcSize,   /* note : src=
Size < BLOCKSIZE */
                           void* dst, size_t dstCapacity, const streaming_o=
peration streaming)
 {
@@ -122,7 +138,8 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
     RETURN_ERROR_IF(srcSize < MIN_CBLOCK_SIZE, corruption_detected, "");
=20
     {   const BYTE* const istart =3D (const BYTE*) src;
-        symbolEncodingType_e const litEncType =3D (symbolEncodingType_e)(i=
start[0] & 3);
+        SymbolEncodingType_e const litEncType =3D (SymbolEncodingType_e)(i=
start[0] & 3);
+        size_t const blockSizeMax =3D ZSTD_blockSizeMax(dctx);
=20
         switch(litEncType)
         {
@@ -132,13 +149,16 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
             ZSTD_FALLTHROUGH;
=20
         case set_compressed:
-            RETURN_ERROR_IF(srcSize < 5, corruption_detected, "srcSize >=
=3D MIN_CBLOCK_SIZE =3D=3D 3; here we need up to 5 for case 3");
+            RETURN_ERROR_IF(srcSize < 5, corruption_detected, "srcSize >=
=3D MIN_CBLOCK_SIZE =3D=3D 2; here we need up to 5 for case 3");
             {   size_t lhSize, litSize, litCSize;
                 U32 singleStream=3D0;
                 U32 const lhlCode =3D (istart[0] >> 2) & 3;
                 U32 const lhc =3D MEM_readLE32(istart);
                 size_t hufSuccess;
-                size_t expectedWriteSize =3D MIN(ZSTD_BLOCKSIZE_MAX, dstCa=
pacity);
+                size_t expectedWriteSize =3D MIN(blockSizeMax, dstCapacity=
);
+                int const flags =3D 0
+                    | (ZSTD_DCtx_get_bmi2(dctx) ? HUF_flags_bmi2 : 0)
+                    | (dctx->disableHufAsm ? HUF_flags_disableAsm : 0);
                 switch(lhlCode)
                 {
                 case 0: case 1: default:   /* note : default is impossible=
, since lhlCode into [0..3] */
@@ -162,7 +182,11 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                     break;
                 }
                 RETURN_ERROR_IF(litSize > 0 && dst =3D=3D NULL, dstSize_to=
oSmall, "NULL not handled");
-                RETURN_ERROR_IF(litSize > ZSTD_BLOCKSIZE_MAX, corruption_d=
etected, "");
+                RETURN_ERROR_IF(litSize > blockSizeMax, corruption_detecte=
d, "");
+                if (!singleStream)
+                    RETURN_ERROR_IF(litSize < MIN_LITERALS_FOR_4_STREAMS, =
literals_headerWrong,
+                        "Not enough literals (%zu) for the 4-streams mode =
(min %u)",
+                        litSize, MIN_LITERALS_FOR_4_STREAMS);
                 RETURN_ERROR_IF(litCSize + lhSize > srcSize, corruption_de=
tected, "");
                 RETURN_ERROR_IF(expectedWriteSize < litSize , dstSize_tooS=
mall, "");
                 ZSTD_allocateLiteralsBuffer(dctx, dst, dstCapacity, litSiz=
e, streaming, expectedWriteSize, 0);
@@ -174,13 +198,14 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
=20
                 if (litEncType=3D=3Dset_repeat) {
                     if (singleStream) {
-                        hufSuccess =3D HUF_decompress1X_usingDTable_bmi2(
+                        hufSuccess =3D HUF_decompress1X_usingDTable(
                             dctx->litBuffer, litSize, istart+lhSize, litCS=
ize,
-                            dctx->HUFptr, ZSTD_DCtx_get_bmi2(dctx));
+                            dctx->HUFptr, flags);
                     } else {
-                        hufSuccess =3D HUF_decompress4X_usingDTable_bmi2(
+                        assert(litSize >=3D MIN_LITERALS_FOR_4_STREAMS);
+                        hufSuccess =3D HUF_decompress4X_usingDTable(
                             dctx->litBuffer, litSize, istart+lhSize, litCS=
ize,
-                            dctx->HUFptr, ZSTD_DCtx_get_bmi2(dctx));
+                            dctx->HUFptr, flags);
                     }
                 } else {
                     if (singleStream) {
@@ -188,26 +213,28 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                         hufSuccess =3D HUF_decompress1X_DCtx_wksp(
                             dctx->entropy.hufTable, dctx->litBuffer, litSi=
ze,
                             istart+lhSize, litCSize, dctx->workspace,
-                            sizeof(dctx->workspace));
+                            sizeof(dctx->workspace), flags);
 #else
-                        hufSuccess =3D HUF_decompress1X1_DCtx_wksp_bmi2(
+                        hufSuccess =3D HUF_decompress1X1_DCtx_wksp(
                             dctx->entropy.hufTable, dctx->litBuffer, litSi=
ze,
                             istart+lhSize, litCSize, dctx->workspace,
-                            sizeof(dctx->workspace), ZSTD_DCtx_get_bmi2(dc=
tx));
+                            sizeof(dctx->workspace), flags);
 #endif
                     } else {
-                        hufSuccess =3D HUF_decompress4X_hufOnly_wksp_bmi2(
+                        hufSuccess =3D HUF_decompress4X_hufOnly_wksp(
                             dctx->entropy.hufTable, dctx->litBuffer, litSi=
ze,
                             istart+lhSize, litCSize, dctx->workspace,
-                            sizeof(dctx->workspace), ZSTD_DCtx_get_bmi2(dc=
tx));
+                            sizeof(dctx->workspace), flags);
                     }
                 }
                 if (dctx->litBufferLocation =3D=3D ZSTD_split)
                 {
+                    assert(litSize > ZSTD_LITBUFFEREXTRASIZE);
                     ZSTD_memcpy(dctx->litExtraBuffer, dctx->litBufferEnd -=
 ZSTD_LITBUFFEREXTRASIZE, ZSTD_LITBUFFEREXTRASIZE);
                     ZSTD_memmove(dctx->litBuffer + ZSTD_LITBUFFEREXTRASIZE=
 - WILDCOPY_OVERLENGTH, dctx->litBuffer, litSize - ZSTD_LITBUFFEREXTRASIZE)=
;
                     dctx->litBuffer +=3D ZSTD_LITBUFFEREXTRASIZE - WILDCOP=
Y_OVERLENGTH;
                     dctx->litBufferEnd -=3D WILDCOPY_OVERLENGTH;
+                    assert(dctx->litBufferEnd <=3D (BYTE*)dst + blockSizeM=
ax);
                 }
=20
                 RETURN_ERROR_IF(HUF_isError(hufSuccess), corruption_detect=
ed, "");
@@ -222,7 +249,7 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
         case set_basic:
             {   size_t litSize, lhSize;
                 U32 const lhlCode =3D ((istart[0]) >> 2) & 3;
-                size_t expectedWriteSize =3D MIN(ZSTD_BLOCKSIZE_MAX, dstCa=
pacity);
+                size_t expectedWriteSize =3D MIN(blockSizeMax, dstCapacity=
);
                 switch(lhlCode)
                 {
                 case 0: case 2: default:   /* note : default is impossible=
, since lhlCode into [0..3] */
@@ -235,11 +262,13 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                     break;
                 case 3:
                     lhSize =3D 3;
+                    RETURN_ERROR_IF(srcSize<3, corruption_detected, "srcSi=
ze >=3D MIN_CBLOCK_SIZE =3D=3D 2; here we need lhSize =3D 3");
                     litSize =3D MEM_readLE24(istart) >> 4;
                     break;
                 }
=20
                 RETURN_ERROR_IF(litSize > 0 && dst =3D=3D NULL, dstSize_to=
oSmall, "NULL not handled");
+                RETURN_ERROR_IF(litSize > blockSizeMax, corruption_detecte=
d, "");
                 RETURN_ERROR_IF(expectedWriteSize < litSize, dstSize_tooSm=
all, "");
                 ZSTD_allocateLiteralsBuffer(dctx, dst, dstCapacity, litSiz=
e, streaming, expectedWriteSize, 1);
                 if (lhSize+litSize+WILDCOPY_OVERLENGTH > srcSize) {  /* ri=
sk reading beyond src buffer with wildcopy */
@@ -268,7 +297,7 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
         case set_rle:
             {   U32 const lhlCode =3D ((istart[0]) >> 2) & 3;
                 size_t litSize, lhSize;
-                size_t expectedWriteSize =3D MIN(ZSTD_BLOCKSIZE_MAX, dstCa=
pacity);
+                size_t expectedWriteSize =3D MIN(blockSizeMax, dstCapacity=
);
                 switch(lhlCode)
                 {
                 case 0: case 2: default:   /* note : default is impossible=
, since lhlCode into [0..3] */
@@ -277,16 +306,17 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                     break;
                 case 1:
                     lhSize =3D 2;
+                    RETURN_ERROR_IF(srcSize<3, corruption_detected, "srcSi=
ze >=3D MIN_CBLOCK_SIZE =3D=3D 2; here we need lhSize+1 =3D 3");
                     litSize =3D MEM_readLE16(istart) >> 4;
                     break;
                 case 3:
                     lhSize =3D 3;
+                    RETURN_ERROR_IF(srcSize<4, corruption_detected, "srcSi=
ze >=3D MIN_CBLOCK_SIZE =3D=3D 2; here we need lhSize+1 =3D 4");
                     litSize =3D MEM_readLE24(istart) >> 4;
-                    RETURN_ERROR_IF(srcSize<4, corruption_detected, "srcSi=
ze >=3D MIN_CBLOCK_SIZE =3D=3D 3; here we need lhSize+1 =3D 4");
                     break;
                 }
                 RETURN_ERROR_IF(litSize > 0 && dst =3D=3D NULL, dstSize_to=
oSmall, "NULL not handled");
-                RETURN_ERROR_IF(litSize > ZSTD_BLOCKSIZE_MAX, corruption_d=
etected, "");
+                RETURN_ERROR_IF(litSize > blockSizeMax, corruption_detecte=
d, "");
                 RETURN_ERROR_IF(expectedWriteSize < litSize, dstSize_tooSm=
all, "");
                 ZSTD_allocateLiteralsBuffer(dctx, dst, dstCapacity, litSiz=
e, streaming, expectedWriteSize, 1);
                 if (dctx->litBufferLocation =3D=3D ZSTD_split)
@@ -308,6 +338,18 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
     }
 }
=20
+/* Hidden declaration for fullbench */
+size_t ZSTD_decodeLiteralsBlock_wrapper(ZSTD_DCtx* dctx,
+                          const void* src, size_t srcSize,
+                          void* dst, size_t dstCapacity);
+size_t ZSTD_decodeLiteralsBlock_wrapper(ZSTD_DCtx* dctx,
+                          const void* src, size_t srcSize,
+                          void* dst, size_t dstCapacity)
+{
+    dctx->isFrameDecompression =3D 0;
+    return ZSTD_decodeLiteralsBlock(dctx, src, srcSize, dst, dstCapacity, =
not_streaming);
+}
+
 /* Default FSE distribution tables.
  * These are pre-calculated FSE decoding tables using default distribution=
s as defined in specification :
  * https://github.com/facebook/zstd/blob/release/doc/zstd_compression_form=
at.md#default-distributions
@@ -315,7 +357,7 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
  * - start from default distributions, present in /lib/common/zstd_interna=
l.h
  * - generate tables normally, using ZSTD_buildFSETable()
  * - printout the content of tables
- * - pretify output, report below, test with fuzzer to ensure it's correct=
 */
+ * - prettify output, report below, test with fuzzer to ensure it's correc=
t */
=20
 /* Default FSE distribution table for Literal Lengths */
 static const ZSTD_seqSymbol LL_defaultDTable[(1<<LL_DEFAULTNORMLOG)+1] =3D=
 {
@@ -500,14 +542,15 @@ void ZSTD_buildFSETable_body(ZSTD_seqSymbol* dt,
                 for (i =3D 8; i < n; i +=3D 8) {
                     MEM_write64(spread + pos + i, sv);
                 }
-                pos +=3D n;
+                assert(n>=3D0);
+                pos +=3D (size_t)n;
             }
         }
         /* Now we spread those positions across the table.
-         * The benefit of doing it in two stages is that we avoid the the
+         * The benefit of doing it in two stages is that we avoid the
          * variable size inner loop, which caused lots of branch misses.
          * Now we can run through all the positions without any branch mis=
ses.
-         * We unroll the loop twice, since that is what emperically worked=
 best.
+         * We unroll the loop twice, since that is what empirically worked=
 best.
          */
         {
             size_t position =3D 0;
@@ -534,7 +577,7 @@ void ZSTD_buildFSETable_body(ZSTD_seqSymbol* dt,
             for (i=3D0; i<n; i++) {
                 tableDecode[position].baseValue =3D s;
                 position =3D (position + step) & tableMask;
-                while (position > highThreshold) position =3D (position + =
step) & tableMask;   /* lowprob area */
+                while (UNLIKELY(position > highThreshold)) position =3D (p=
osition + step) & tableMask;   /* lowprob area */
         }   }
         assert(position =3D=3D 0); /* position must reach all cells once, =
otherwise normalizedCounter is incorrect */
     }
@@ -545,7 +588,7 @@ void ZSTD_buildFSETable_body(ZSTD_seqSymbol* dt,
         for (u=3D0; u<tableSize; u++) {
             U32 const symbol =3D tableDecode[u].baseValue;
             U32 const nextState =3D symbolNext[symbol]++;
-            tableDecode[u].nbBits =3D (BYTE) (tableLog - BIT_highbit32(nex=
tState) );
+            tableDecode[u].nbBits =3D (BYTE) (tableLog - ZSTD_highbit32(ne=
xtState) );
             tableDecode[u].nextState =3D (U16) ( (nextState << tableDecode=
[u].nbBits) - tableSize);
             assert(nbAdditionalBits[symbol] < 255);
             tableDecode[u].nbAdditionalBits =3D nbAdditionalBits[symbol];
@@ -596,7 +639,7 @@ void ZSTD_buildFSETable(ZSTD_seqSymbol* dt,
  * @return : nb bytes read from src,
  *           or an error code if it fails */
 static size_t ZSTD_buildSeqTable(ZSTD_seqSymbol* DTableSpace, const ZSTD_s=
eqSymbol** DTablePtr,
-                                 symbolEncodingType_e type, unsigned max, =
U32 maxLog,
+                                 SymbolEncodingType_e type, unsigned max, =
U32 maxLog,
                                  const void* src, size_t srcSize,
                                  const U32* baseValue, const U8* nbAdditio=
nalBits,
                                  const ZSTD_seqSymbol* defaultTable, U32 f=
lagRepeatTable,
@@ -657,11 +700,6 @@ size_t ZSTD_decodeSeqHeaders(ZSTD_DCtx* dctx, int* nbS=
eqPtr,
=20
     /* SeqHead */
     nbSeq =3D *ip++;
-    if (!nbSeq) {
-        *nbSeqPtr=3D0;
-        RETURN_ERROR_IF(srcSize !=3D 1, srcSize_wrong, "");
-        return 1;
-    }
     if (nbSeq > 0x7F) {
         if (nbSeq =3D=3D 0xFF) {
             RETURN_ERROR_IF(ip+2 > iend, srcSize_wrong, "");
@@ -674,11 +712,19 @@ size_t ZSTD_decodeSeqHeaders(ZSTD_DCtx* dctx, int* nb=
SeqPtr,
     }
     *nbSeqPtr =3D nbSeq;
=20
+    if (nbSeq =3D=3D 0) {
+        /* No sequence : section ends immediately */
+        RETURN_ERROR_IF(ip !=3D iend, corruption_detected,
+            "extraneous data present in the Sequences section");
+        return (size_t)(ip - istart);
+    }
+
     /* FSE table descriptors */
     RETURN_ERROR_IF(ip+1 > iend, srcSize_wrong, ""); /* minimum possible s=
ize: 1 byte for symbol encoding types */
-    {   symbolEncodingType_e const LLtype =3D (symbolEncodingType_e)(*ip >=
> 6);
-        symbolEncodingType_e const OFtype =3D (symbolEncodingType_e)((*ip =
>> 4) & 3);
-        symbolEncodingType_e const MLtype =3D (symbolEncodingType_e)((*ip =
>> 2) & 3);
+    RETURN_ERROR_IF(*ip & 3, corruption_detected, ""); /* The last field, =
Reserved, must be all-zeroes. */
+    {   SymbolEncodingType_e const LLtype =3D (SymbolEncodingType_e)(*ip >=
> 6);
+        SymbolEncodingType_e const OFtype =3D (SymbolEncodingType_e)((*ip =
>> 4) & 3);
+        SymbolEncodingType_e const MLtype =3D (SymbolEncodingType_e)((*ip =
>> 2) & 3);
         ip++;
=20
         /* Build DTables */
@@ -821,7 +867,7 @@ static void ZSTD_safecopy(BYTE* op, const BYTE* const o=
end_w, BYTE const* ip, pt
 /* ZSTD_safecopyDstBeforeSrc():
  * This version allows overlap with dst before src, or handles the non-ove=
rlap case with dst after src
  * Kept separate from more common ZSTD_safecopy case to avoid performance =
impact to the safecopy common case */
-static void ZSTD_safecopyDstBeforeSrc(BYTE* op, BYTE const* ip, ptrdiff_t =
length) {
+static void ZSTD_safecopyDstBeforeSrc(BYTE* op, const BYTE* ip, ptrdiff_t =
length) {
     ptrdiff_t const diff =3D op - ip;
     BYTE* const oend =3D op + length;
=20
@@ -850,6 +896,7 @@ static void ZSTD_safecopyDstBeforeSrc(BYTE* op, BYTE co=
nst* ip, ptrdiff_t length
  * to be optimized for many small sequences, since those fall into ZSTD_ex=
ecSequence().
  */
 FORCE_NOINLINE
+ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
 size_t ZSTD_execSequenceEnd(BYTE* op,
     BYTE* const oend, seq_t sequence,
     const BYTE** litPtr, const BYTE* const litLimit,
@@ -897,6 +944,7 @@ size_t ZSTD_execSequenceEnd(BYTE* op,
  * This version is intended to be used during instances where the litBuffe=
r is still split.  It is kept separate to avoid performance impact for the =
good case.
  */
 FORCE_NOINLINE
+ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
 size_t ZSTD_execSequenceEndSplitLitBuffer(BYTE* op,
     BYTE* const oend, const BYTE* const oend_w, seq_t sequence,
     const BYTE** litPtr, const BYTE* const litLimit,
@@ -941,6 +989,7 @@ size_t ZSTD_execSequenceEndSplitLitBuffer(BYTE* op,
 }
=20
 HINT_INLINE
+ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
 size_t ZSTD_execSequence(BYTE* op,
     BYTE* const oend, seq_t sequence,
     const BYTE** litPtr, const BYTE* const litLimit,
@@ -955,6 +1004,11 @@ size_t ZSTD_execSequence(BYTE* op,
=20
     assert(op !=3D NULL /* Precondition */);
     assert(oend_w < oend /* No underflow */);
+
+#if defined(__aarch64__)
+    /* prefetch sequence starting from match that will be used for copy la=
ter */
+    PREFETCH_L1(match);
+#endif
     /* Handle edge cases in a slow path:
      *   - Read beyond end of literals
      *   - Match end is within WILDCOPY_OVERLIMIT of oend
@@ -1034,6 +1088,7 @@ size_t ZSTD_execSequence(BYTE* op,
 }
=20
 HINT_INLINE
+ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
 size_t ZSTD_execSequenceSplitLitBuffer(BYTE* op,
     BYTE* const oend, const BYTE* const oend_w, seq_t sequence,
     const BYTE** litPtr, const BYTE* const litLimit,
@@ -1144,7 +1199,7 @@ ZSTD_updateFseStateWithDInfo(ZSTD_fseState* DStatePtr=
, BIT_DStream_t* bitD, U16
 }
=20
 /* We need to add at most (ZSTD_WINDOWLOG_MAX_32 - 1) bits to read the max=
imum
- * offset bits. But we can only read at most (STREAM_ACCUMULATOR_MIN_32 - =
1)
+ * offset bits. But we can only read at most STREAM_ACCUMULATOR_MIN_32
  * bits before reloading. This value is the maximum number of bytes we rea=
d
  * after reloading when we are decoding long offsets.
  */
@@ -1155,13 +1210,37 @@ ZSTD_updateFseStateWithDInfo(ZSTD_fseState* DStateP=
tr, BIT_DStream_t* bitD, U16
=20
 typedef enum { ZSTD_lo_isRegularOffset, ZSTD_lo_isLongOffset=3D1 } ZSTD_lo=
ngOffset_e;
=20
+/*
+ * ZSTD_decodeSequence():
+ * @p longOffsets : tells the decoder to reload more bit while decoding la=
rge offsets
+ *                  only used in 32-bit mode
+ * @return : Sequence (litL + matchL + offset)
+ */
 FORCE_INLINE_TEMPLATE seq_t
-ZSTD_decodeSequence(seqState_t* seqState, const ZSTD_longOffset_e longOffs=
ets)
+ZSTD_decodeSequence(seqState_t* seqState, const ZSTD_longOffset_e longOffs=
ets, const int isLastSeq)
 {
     seq_t seq;
+    /*
+     * ZSTD_seqSymbol is a 64 bits wide structure.
+     * It can be loaded in one operation
+     * and its fields extracted by simply shifting or bit-extracting on aa=
rch64.
+     * GCC doesn't recognize this and generates more unnecessary ldr/ldrb/=
ldrh
+     * operations that cause performance drop. This can be avoided by usin=
g this
+     * ZSTD_memcpy hack.
+     */
+#if defined(__aarch64__) && (defined(__GNUC__) && !defined(__clang__))
+    ZSTD_seqSymbol llDInfoS, mlDInfoS, ofDInfoS;
+    ZSTD_seqSymbol* const llDInfo =3D &llDInfoS;
+    ZSTD_seqSymbol* const mlDInfo =3D &mlDInfoS;
+    ZSTD_seqSymbol* const ofDInfo =3D &ofDInfoS;
+    ZSTD_memcpy(llDInfo, seqState->stateLL.table + seqState->stateLL.state=
, sizeof(ZSTD_seqSymbol));
+    ZSTD_memcpy(mlDInfo, seqState->stateML.table + seqState->stateML.state=
, sizeof(ZSTD_seqSymbol));
+    ZSTD_memcpy(ofDInfo, seqState->stateOffb.table + seqState->stateOffb.s=
tate, sizeof(ZSTD_seqSymbol));
+#else
     const ZSTD_seqSymbol* const llDInfo =3D seqState->stateLL.table + seqS=
tate->stateLL.state;
     const ZSTD_seqSymbol* const mlDInfo =3D seqState->stateML.table + seqS=
tate->stateML.state;
     const ZSTD_seqSymbol* const ofDInfo =3D seqState->stateOffb.table + se=
qState->stateOffb.state;
+#endif
     seq.matchLength =3D mlDInfo->baseValue;
     seq.litLength =3D llDInfo->baseValue;
     {   U32 const ofBase =3D ofDInfo->baseValue;
@@ -1176,28 +1255,31 @@ ZSTD_decodeSequence(seqState_t* seqState, const ZST=
D_longOffset_e longOffsets)
         U32 const llnbBits =3D llDInfo->nbBits;
         U32 const mlnbBits =3D mlDInfo->nbBits;
         U32 const ofnbBits =3D ofDInfo->nbBits;
+
+        assert(llBits <=3D MaxLLBits);
+        assert(mlBits <=3D MaxMLBits);
+        assert(ofBits <=3D MaxOff);
         /*
          * As gcc has better branch and block analyzers, sometimes it is o=
nly
-         * valuable to mark likelyness for clang, it gives around 3-4% of
+         * valuable to mark likeliness for clang, it gives around 3-4% of
          * performance.
          */
=20
         /* sequence */
         {   size_t offset;
-    #if defined(__clang__)
-            if (LIKELY(ofBits > 1)) {
-    #else
             if (ofBits > 1) {
-    #endif
                 ZSTD_STATIC_ASSERT(ZSTD_lo_isLongOffset =3D=3D 1);
                 ZSTD_STATIC_ASSERT(LONG_OFFSETS_MAX_EXTRA_BITS_32 =3D=3D 5=
);
-                assert(ofBits <=3D MaxOff);
+                ZSTD_STATIC_ASSERT(STREAM_ACCUMULATOR_MIN_32 > LONG_OFFSET=
S_MAX_EXTRA_BITS_32);
+                ZSTD_STATIC_ASSERT(STREAM_ACCUMULATOR_MIN_32 - LONG_OFFSET=
S_MAX_EXTRA_BITS_32 >=3D MaxMLBits);
                 if (MEM_32bits() && longOffsets && (ofBits >=3D STREAM_ACC=
UMULATOR_MIN_32)) {
-                    U32 const extraBits =3D ofBits - MIN(ofBits, 32 - seqS=
tate->DStream.bitsConsumed);
+                    /* Always read extra bits, this keeps the logic simple=
,
+                     * avoids branches, and avoids accidentally reading 0 =
bits.
+                     */
+                    U32 const extraBits =3D LONG_OFFSETS_MAX_EXTRA_BITS_32=
;
                     offset =3D ofBase + (BIT_readBitsFast(&seqState->DStre=
am, ofBits - extraBits) << extraBits);
                     BIT_reloadDStream(&seqState->DStream);
-                    if (extraBits) offset +=3D BIT_readBitsFast(&seqState-=
>DStream, extraBits);
-                    assert(extraBits <=3D LONG_OFFSETS_MAX_EXTRA_BITS_32);=
   /* to avoid another reload */
+                    offset +=3D BIT_readBitsFast(&seqState->DStream, extra=
Bits);
                 } else {
                     offset =3D ofBase + BIT_readBitsFast(&seqState->DStrea=
m, ofBits/*>0*/);   /* <=3D  (ZSTD_WINDOWLOG_MAX-1) bits */
                     if (MEM_32bits()) BIT_reloadDStream(&seqState->DStream=
);
@@ -1214,7 +1296,7 @@ ZSTD_decodeSequence(seqState_t* seqState, const ZSTD_=
longOffset_e longOffsets)
                 } else {
                     offset =3D ofBase + ll0 + BIT_readBitsFast(&seqState->=
DStream, 1);
                     {   size_t temp =3D (offset=3D=3D3) ? seqState->prevOf=
fset[0] - 1 : seqState->prevOffset[offset];
-                        temp +=3D !temp;   /* 0 is not valid; input is cor=
rupted; force offset to 1 */
+                        temp -=3D !temp; /* 0 is not valid: input corrupte=
d =3D> force offset to -1 =3D> corruption detected at execSequence */
                         if (offset !=3D 1) seqState->prevOffset[2] =3D seq=
State->prevOffset[1];
                         seqState->prevOffset[1] =3D seqState->prevOffset[0=
];
                         seqState->prevOffset[0] =3D offset =3D temp;
@@ -1222,11 +1304,7 @@ ZSTD_decodeSequence(seqState_t* seqState, const ZSTD=
_longOffset_e longOffsets)
             seq.offset =3D offset;
         }
=20
-    #if defined(__clang__)
-        if (UNLIKELY(mlBits > 0))
-    #else
         if (mlBits > 0)
-    #endif
             seq.matchLength +=3D BIT_readBitsFast(&seqState->DStream, mlBi=
ts/*>0*/);
=20
         if (MEM_32bits() && (mlBits+llBits >=3D STREAM_ACCUMULATOR_MIN_32-=
LONG_OFFSETS_MAX_EXTRA_BITS_32))
@@ -1236,11 +1314,7 @@ ZSTD_decodeSequence(seqState_t* seqState, const ZSTD=
_longOffset_e longOffsets)
         /* Ensure there are enough bits to read the rest of data in 64-bit=
 mode. */
         ZSTD_STATIC_ASSERT(16+LLFSELog+MLFSELog+OffFSELog < STREAM_ACCUMUL=
ATOR_MIN_64);
=20
-    #if defined(__clang__)
-        if (UNLIKELY(llBits > 0))
-    #else
         if (llBits > 0)
-    #endif
             seq.litLength +=3D BIT_readBitsFast(&seqState->DStream, llBits=
/*>0*/);
=20
         if (MEM_32bits())
@@ -1249,17 +1323,22 @@ ZSTD_decodeSequence(seqState_t* seqState, const ZST=
D_longOffset_e longOffsets)
         DEBUGLOG(6, "seq: litL=3D%u, matchL=3D%u, offset=3D%u",
                     (U32)seq.litLength, (U32)seq.matchLength, (U32)seq.off=
set);
=20
-        ZSTD_updateFseStateWithDInfo(&seqState->stateLL, &seqState->DStrea=
m, llNext, llnbBits);    /* <=3D  9 bits */
-        ZSTD_updateFseStateWithDInfo(&seqState->stateML, &seqState->DStrea=
m, mlNext, mlnbBits);    /* <=3D  9 bits */
-        if (MEM_32bits()) BIT_reloadDStream(&seqState->DStream);    /* <=
=3D 18 bits */
-        ZSTD_updateFseStateWithDInfo(&seqState->stateOffb, &seqState->DStr=
eam, ofNext, ofnbBits);  /* <=3D  8 bits */
+        if (!isLastSeq) {
+            /* don't update FSE state for last Sequence */
+            ZSTD_updateFseStateWithDInfo(&seqState->stateLL, &seqState->DS=
tream, llNext, llnbBits);    /* <=3D  9 bits */
+            ZSTD_updateFseStateWithDInfo(&seqState->stateML, &seqState->DS=
tream, mlNext, mlnbBits);    /* <=3D  9 bits */
+            if (MEM_32bits()) BIT_reloadDStream(&seqState->DStream);    /*=
 <=3D 18 bits */
+            ZSTD_updateFseStateWithDInfo(&seqState->stateOffb, &seqState->=
DStream, ofNext, ofnbBits);  /* <=3D  8 bits */
+            BIT_reloadDStream(&seqState->DStream);
+        }
     }
=20
     return seq;
 }
=20
-#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
-MEM_STATIC int ZSTD_dictionaryIsActive(ZSTD_DCtx const* dctx, BYTE const* =
prefixStart, BYTE const* oLitEnd)
+#if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_A=
SSERT_VALID_SEQUENCE)
+#if DEBUGLEVEL >=3D 1
+static int ZSTD_dictionaryIsActive(ZSTD_DCtx const* dctx, BYTE const* pref=
ixStart, BYTE const* oLitEnd)
 {
     size_t const windowSize =3D dctx->fParams.windowSize;
     /* No dictionary used. */
@@ -1273,30 +1352,33 @@ MEM_STATIC int ZSTD_dictionaryIsActive(ZSTD_DCtx co=
nst* dctx, BYTE const* prefix
     /* Dictionary is active. */
     return 1;
 }
+#endif
=20
-MEM_STATIC void ZSTD_assertValidSequence(
+static void ZSTD_assertValidSequence(
         ZSTD_DCtx const* dctx,
         BYTE const* op, BYTE const* oend,
         seq_t const seq,
         BYTE const* prefixStart, BYTE const* virtualStart)
 {
 #if DEBUGLEVEL >=3D 1
-    size_t const windowSize =3D dctx->fParams.windowSize;
-    size_t const sequenceSize =3D seq.litLength + seq.matchLength;
-    BYTE const* const oLitEnd =3D op + seq.litLength;
-    DEBUGLOG(6, "Checking sequence: litL=3D%u matchL=3D%u offset=3D%u",
-            (U32)seq.litLength, (U32)seq.matchLength, (U32)seq.offset);
-    assert(op <=3D oend);
-    assert((size_t)(oend - op) >=3D sequenceSize);
-    assert(sequenceSize <=3D ZSTD_BLOCKSIZE_MAX);
-    if (ZSTD_dictionaryIsActive(dctx, prefixStart, oLitEnd)) {
-        size_t const dictSize =3D (size_t)((char const*)dctx->dictContentE=
ndForFuzzing - (char const*)dctx->dictContentBeginForFuzzing);
-        /* Offset must be within the dictionary. */
-        assert(seq.offset <=3D (size_t)(oLitEnd - virtualStart));
-        assert(seq.offset <=3D windowSize + dictSize);
-    } else {
-        /* Offset must be within our window. */
-        assert(seq.offset <=3D windowSize);
+    if (dctx->isFrameDecompression) {
+        size_t const windowSize =3D dctx->fParams.windowSize;
+        size_t const sequenceSize =3D seq.litLength + seq.matchLength;
+        BYTE const* const oLitEnd =3D op + seq.litLength;
+        DEBUGLOG(6, "Checking sequence: litL=3D%u matchL=3D%u offset=3D%u"=
,
+                (U32)seq.litLength, (U32)seq.matchLength, (U32)seq.offset)=
;
+        assert(op <=3D oend);
+        assert((size_t)(oend - op) >=3D sequenceSize);
+        assert(sequenceSize <=3D ZSTD_blockSizeMax(dctx));
+        if (ZSTD_dictionaryIsActive(dctx, prefixStart, oLitEnd)) {
+            size_t const dictSize =3D (size_t)((char const*)dctx->dictCont=
entEndForFuzzing - (char const*)dctx->dictContentBeginForFuzzing);
+            /* Offset must be within the dictionary. */
+            assert(seq.offset <=3D (size_t)(oLitEnd - virtualStart));
+            assert(seq.offset <=3D windowSize + dictSize);
+        } else {
+            /* Offset must be within our window. */
+            assert(seq.offset <=3D windowSize);
+        }
     }
 #else
     (void)dctx, (void)op, (void)oend, (void)seq, (void)prefixStart, (void)=
virtualStart;
@@ -1311,23 +1393,21 @@ DONT_VECTORIZE
 ZSTD_decompressSequences_bodySplitLitBuffer( ZSTD_DCtx* dctx,
                                void* dst, size_t maxDstSize,
                          const void* seqStart, size_t seqSize, int nbSeq,
-                         const ZSTD_longOffset_e isLongOffset,
-                         const int frame)
+                         const ZSTD_longOffset_e isLongOffset)
 {
     const BYTE* ip =3D (const BYTE*)seqStart;
     const BYTE* const iend =3D ip + seqSize;
     BYTE* const ostart =3D (BYTE*)dst;
-    BYTE* const oend =3D ostart + maxDstSize;
+    BYTE* const oend =3D ZSTD_maybeNullPtrAdd(ostart, maxDstSize);
     BYTE* op =3D ostart;
     const BYTE* litPtr =3D dctx->litPtr;
     const BYTE* litBufferEnd =3D dctx->litBufferEnd;
     const BYTE* const prefixStart =3D (const BYTE*) (dctx->prefixStart);
     const BYTE* const vBase =3D (const BYTE*) (dctx->virtualStart);
     const BYTE* const dictEnd =3D (const BYTE*) (dctx->dictEnd);
-    DEBUGLOG(5, "ZSTD_decompressSequences_bodySplitLitBuffer");
-    (void)frame;
+    DEBUGLOG(5, "ZSTD_decompressSequences_bodySplitLitBuffer (%i seqs)", n=
bSeq);
=20
-    /* Regen sequences */
+    /* Literals are split between internal buffer & output buffer */
     if (nbSeq) {
         seqState_t seqState;
         dctx->fseEntropy =3D 1;
@@ -1346,8 +1426,7 @@ ZSTD_decompressSequences_bodySplitLitBuffer( ZSTD_DCt=
x* dctx,
                 BIT_DStream_completed < BIT_DStream_overflow);
=20
         /* decompress without overrunning litPtr begins */
-        {
-            seq_t sequence =3D ZSTD_decodeSequence(&seqState, isLongOffset=
);
+        {   seq_t sequence =3D {0,0,0};  /* some static analyzer believe t=
hat @sequence is not initialized (it necessarily is, since for(;;) loop as =
at least one iteration) */
             /* Align the decompression loop to 32 + 16 bytes.
                 *
                 * zstd compiled with gcc-9 on an Intel i9-9900k shows 10% =
decompression
@@ -1409,27 +1488,26 @@ ZSTD_decompressSequences_bodySplitLitBuffer( ZSTD_D=
Ctx* dctx,
 #endif
=20
             /* Handle the initial state where litBuffer is currently split=
 between dst and litExtraBuffer */
-            for (; litPtr + sequence.litLength <=3D dctx->litBufferEnd; ) =
{
-                size_t const oneSeqSize =3D ZSTD_execSequenceSplitLitBuffe=
r(op, oend, litPtr + sequence.litLength - WILDCOPY_OVERLENGTH, sequence, &l=
itPtr, litBufferEnd, prefixStart, vBase, dictEnd);
+            for ( ; nbSeq; nbSeq--) {
+                sequence =3D ZSTD_decodeSequence(&seqState, isLongOffset, =
nbSeq=3D=3D1);
+                if (litPtr + sequence.litLength > dctx->litBufferEnd) brea=
k;
+                {   size_t const oneSeqSize =3D ZSTD_execSequenceSplitLitB=
uffer(op, oend, litPtr + sequence.litLength - WILDCOPY_OVERLENGTH, sequence=
, &litPtr, litBufferEnd, prefixStart, vBase, dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_A=
SSERT_VALID_SEQUENCE)
-                assert(!ZSTD_isError(oneSeqSize));
-                if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequen=
ce, prefixStart, vBase);
+                    assert(!ZSTD_isError(oneSeqSize));
+                    ZSTD_assertValidSequence(dctx, op, oend, sequence, pre=
fixStart, vBase);
 #endif
-                if (UNLIKELY(ZSTD_isError(oneSeqSize)))
-                    return oneSeqSize;
-                DEBUGLOG(6, "regenerated sequence size : %u", (U32)oneSeqS=
ize);
-                op +=3D oneSeqSize;
-                if (UNLIKELY(!--nbSeq))
-                    break;
-                BIT_reloadDStream(&(seqState.DStream));
-                sequence =3D ZSTD_decodeSequence(&seqState, isLongOffset);
-            }
+                    if (UNLIKELY(ZSTD_isError(oneSeqSize)))
+                        return oneSeqSize;
+                    DEBUGLOG(6, "regenerated sequence size : %u", (U32)one=
SeqSize);
+                    op +=3D oneSeqSize;
+            }   }
+            DEBUGLOG(6, "reached: (litPtr + sequence.litLength > dctx->lit=
BufferEnd)");
=20
             /* If there are more sequences, they will need to read literal=
s from litExtraBuffer; copy over the remainder from dst and update litPtr a=
nd litEnd */
             if (nbSeq > 0) {
                 const size_t leftoverLit =3D dctx->litBufferEnd - litPtr;
-                if (leftoverLit)
-                {
+                DEBUGLOG(6, "There are %i sequences left, and %zu/%zu lite=
rals left in buffer", nbSeq, leftoverLit, sequence.litLength);
+                if (leftoverLit) {
                     RETURN_ERROR_IF(leftoverLit > (size_t)(oend - op), dst=
Size_tooSmall, "remaining lit must fit within dstBuffer");
                     ZSTD_safecopyDstBeforeSrc(op, litPtr, leftoverLit);
                     sequence.litLength -=3D leftoverLit;
@@ -1438,24 +1516,22 @@ ZSTD_decompressSequences_bodySplitLitBuffer( ZSTD_D=
Ctx* dctx,
                 litPtr =3D dctx->litExtraBuffer;
                 litBufferEnd =3D dctx->litExtraBuffer + ZSTD_LITBUFFEREXTR=
ASIZE;
                 dctx->litBufferLocation =3D ZSTD_not_in_dst;
-                {
-                    size_t const oneSeqSize =3D ZSTD_execSequence(op, oend=
, sequence, &litPtr, litBufferEnd, prefixStart, vBase, dictEnd);
+                {   size_t const oneSeqSize =3D ZSTD_execSequence(op, oend=
, sequence, &litPtr, litBufferEnd, prefixStart, vBase, dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_A=
SSERT_VALID_SEQUENCE)
                     assert(!ZSTD_isError(oneSeqSize));
-                    if (frame) ZSTD_assertValidSequence(dctx, op, oend, se=
quence, prefixStart, vBase);
+                    ZSTD_assertValidSequence(dctx, op, oend, sequence, pre=
fixStart, vBase);
 #endif
                     if (UNLIKELY(ZSTD_isError(oneSeqSize)))
                         return oneSeqSize;
                     DEBUGLOG(6, "regenerated sequence size : %u", (U32)one=
SeqSize);
                     op +=3D oneSeqSize;
-                    if (--nbSeq)
-                        BIT_reloadDStream(&(seqState.DStream));
                 }
+                nbSeq--;
             }
         }
=20
-        if (nbSeq > 0) /* there is remaining lit from extra buffer */
-        {
+        if (nbSeq > 0) {
+            /* there is remaining lit from extra buffer */
=20
 #if defined(__x86_64__)
             __asm__(".p2align 6");
@@ -1474,35 +1550,34 @@ ZSTD_decompressSequences_bodySplitLitBuffer( ZSTD_D=
Ctx* dctx,
 #  endif
 #endif
=20
-            for (; ; ) {
-                seq_t const sequence =3D ZSTD_decodeSequence(&seqState, is=
LongOffset);
+            for ( ; nbSeq ; nbSeq--) {
+                seq_t const sequence =3D ZSTD_decodeSequence(&seqState, is=
LongOffset, nbSeq=3D=3D1);
                 size_t const oneSeqSize =3D ZSTD_execSequence(op, oend, se=
quence, &litPtr, litBufferEnd, prefixStart, vBase, dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_A=
SSERT_VALID_SEQUENCE)
                 assert(!ZSTD_isError(oneSeqSize));
-                if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequen=
ce, prefixStart, vBase);
+                ZSTD_assertValidSequence(dctx, op, oend, sequence, prefixS=
tart, vBase);
 #endif
                 if (UNLIKELY(ZSTD_isError(oneSeqSize)))
                     return oneSeqSize;
                 DEBUGLOG(6, "regenerated sequence size : %u", (U32)oneSeqS=
ize);
                 op +=3D oneSeqSize;
-                if (UNLIKELY(!--nbSeq))
-                    break;
-                BIT_reloadDStream(&(seqState.DStream));
             }
         }
=20
         /* check if reached exact end */
         DEBUGLOG(5, "ZSTD_decompressSequences_bodySplitLitBuffer: after de=
code loop, remaining nbSeq : %i", nbSeq);
         RETURN_ERROR_IF(nbSeq, corruption_detected, "");
-        RETURN_ERROR_IF(BIT_reloadDStream(&seqState.DStream) < BIT_DStream=
_completed, corruption_detected, "");
+        DEBUGLOG(5, "bitStream : start=3D%p, ptr=3D%p, bitsConsumed=3D%u",=
 seqState.DStream.start, seqState.DStream.ptr, seqState.DStream.bitsConsume=
d);
+        RETURN_ERROR_IF(!BIT_endOfDStream(&seqState.DStream), corruption_d=
etected, "");
         /* save reps for next block */
         { U32 i; for (i=3D0; i<ZSTD_REP_NUM; i++) dctx->entropy.rep[i] =3D=
 (U32)(seqState.prevOffset[i]); }
     }
=20
     /* last literal segment */
-    if (dctx->litBufferLocation =3D=3D ZSTD_split)  /* split hasn't been r=
eached yet, first get dst then copy litExtraBuffer */
-    {
-        size_t const lastLLSize =3D litBufferEnd - litPtr;
+    if (dctx->litBufferLocation =3D=3D ZSTD_split) {
+        /* split hasn't been reached yet, first get dst then copy litExtra=
Buffer */
+        size_t const lastLLSize =3D (size_t)(litBufferEnd - litPtr);
+        DEBUGLOG(6, "copy last literals from segment : %u", (U32)lastLLSiz=
e);
         RETURN_ERROR_IF(lastLLSize > (size_t)(oend - op), dstSize_tooSmall=
, "");
         if (op !=3D NULL) {
             ZSTD_memmove(op, litPtr, lastLLSize);
@@ -1512,15 +1587,17 @@ ZSTD_decompressSequences_bodySplitLitBuffer( ZSTD_D=
Ctx* dctx,
         litBufferEnd =3D dctx->litExtraBuffer + ZSTD_LITBUFFEREXTRASIZE;
         dctx->litBufferLocation =3D ZSTD_not_in_dst;
     }
-    {   size_t const lastLLSize =3D litBufferEnd - litPtr;
+    /* copy last literals from internal buffer */
+    {   size_t const lastLLSize =3D (size_t)(litBufferEnd - litPtr);
+        DEBUGLOG(6, "copy last literals from internal buffer : %u", (U32)l=
astLLSize);
         RETURN_ERROR_IF(lastLLSize > (size_t)(oend-op), dstSize_tooSmall, =
"");
         if (op !=3D NULL) {
             ZSTD_memcpy(op, litPtr, lastLLSize);
             op +=3D lastLLSize;
-        }
-    }
+    }   }
=20
-    return op-ostart;
+    DEBUGLOG(6, "decoded block of size %u bytes", (U32)(op - ostart));
+    return (size_t)(op - ostart);
 }
=20
 FORCE_INLINE_TEMPLATE size_t
@@ -1528,21 +1605,19 @@ DONT_VECTORIZE
 ZSTD_decompressSequences_body(ZSTD_DCtx* dctx,
     void* dst, size_t maxDstSize,
     const void* seqStart, size_t seqSize, int nbSeq,
-    const ZSTD_longOffset_e isLongOffset,
-    const int frame)
+    const ZSTD_longOffset_e isLongOffset)
 {
     const BYTE* ip =3D (const BYTE*)seqStart;
     const BYTE* const iend =3D ip + seqSize;
     BYTE* const ostart =3D (BYTE*)dst;
-    BYTE* const oend =3D dctx->litBufferLocation =3D=3D ZSTD_not_in_dst ? =
ostart + maxDstSize : dctx->litBuffer;
+    BYTE* const oend =3D dctx->litBufferLocation =3D=3D ZSTD_not_in_dst ? =
ZSTD_maybeNullPtrAdd(ostart, maxDstSize) : dctx->litBuffer;
     BYTE* op =3D ostart;
     const BYTE* litPtr =3D dctx->litPtr;
     const BYTE* const litEnd =3D litPtr + dctx->litSize;
     const BYTE* const prefixStart =3D (const BYTE*)(dctx->prefixStart);
     const BYTE* const vBase =3D (const BYTE*)(dctx->virtualStart);
     const BYTE* const dictEnd =3D (const BYTE*)(dctx->dictEnd);
-    DEBUGLOG(5, "ZSTD_decompressSequences_body");
-    (void)frame;
+    DEBUGLOG(5, "ZSTD_decompressSequences_body: nbSeq =3D %d", nbSeq);
=20
     /* Regen sequences */
     if (nbSeq) {
@@ -1557,11 +1632,6 @@ ZSTD_decompressSequences_body(ZSTD_DCtx* dctx,
         ZSTD_initFseState(&seqState.stateML, &seqState.DStream, dctx->MLTp=
tr);
         assert(dst !=3D NULL);
=20
-        ZSTD_STATIC_ASSERT(
-            BIT_DStream_unfinished < BIT_DStream_completed &&
-            BIT_DStream_endOfBuffer < BIT_DStream_completed &&
-            BIT_DStream_completed < BIT_DStream_overflow);
-
 #if defined(__x86_64__)
             __asm__(".p2align 6");
             __asm__("nop");
@@ -1576,73 +1646,70 @@ ZSTD_decompressSequences_body(ZSTD_DCtx* dctx,
 #  endif
 #endif
=20
-        for ( ; ; ) {
-            seq_t const sequence =3D ZSTD_decodeSequence(&seqState, isLong=
Offset);
+        for ( ; nbSeq ; nbSeq--) {
+            seq_t const sequence =3D ZSTD_decodeSequence(&seqState, isLong=
Offset, nbSeq=3D=3D1);
             size_t const oneSeqSize =3D ZSTD_execSequence(op, oend, sequen=
ce, &litPtr, litEnd, prefixStart, vBase, dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_A=
SSERT_VALID_SEQUENCE)
             assert(!ZSTD_isError(oneSeqSize));
-            if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequence, =
prefixStart, vBase);
+            ZSTD_assertValidSequence(dctx, op, oend, sequence, prefixStart=
, vBase);
 #endif
             if (UNLIKELY(ZSTD_isError(oneSeqSize)))
                 return oneSeqSize;
             DEBUGLOG(6, "regenerated sequence size : %u", (U32)oneSeqSize)=
;
             op +=3D oneSeqSize;
-            if (UNLIKELY(!--nbSeq))
-                break;
-            BIT_reloadDStream(&(seqState.DStream));
         }
=20
         /* check if reached exact end */
-        DEBUGLOG(5, "ZSTD_decompressSequences_body: after decode loop, rem=
aining nbSeq : %i", nbSeq);
-        RETURN_ERROR_IF(nbSeq, corruption_detected, "");
-        RETURN_ERROR_IF(BIT_reloadDStream(&seqState.DStream) < BIT_DStream=
_completed, corruption_detected, "");
+        assert(nbSeq =3D=3D 0);
+        RETURN_ERROR_IF(!BIT_endOfDStream(&seqState.DStream), corruption_d=
etected, "");
         /* save reps for next block */
         { U32 i; for (i=3D0; i<ZSTD_REP_NUM; i++) dctx->entropy.rep[i] =3D=
 (U32)(seqState.prevOffset[i]); }
     }
=20
     /* last literal segment */
-    {   size_t const lastLLSize =3D litEnd - litPtr;
+    {   size_t const lastLLSize =3D (size_t)(litEnd - litPtr);
+        DEBUGLOG(6, "copy last literals : %u", (U32)lastLLSize);
         RETURN_ERROR_IF(lastLLSize > (size_t)(oend-op), dstSize_tooSmall, =
"");
         if (op !=3D NULL) {
             ZSTD_memcpy(op, litPtr, lastLLSize);
             op +=3D lastLLSize;
-        }
-    }
+    }   }
=20
-    return op-ostart;
+    DEBUGLOG(6, "decoded block of size %u bytes", (U32)(op - ostart));
+    return (size_t)(op - ostart);
 }
=20
 static size_t
 ZSTD_decompressSequences_default(ZSTD_DCtx* dctx,
                                  void* dst, size_t maxDstSize,
                            const void* seqStart, size_t seqSize, int nbSeq=
,
-                           const ZSTD_longOffset_e isLongOffset,
-                           const int frame)
+                           const ZSTD_longOffset_e isLongOffset)
 {
-    return ZSTD_decompressSequences_body(dctx, dst, maxDstSize, seqStart, =
seqSize, nbSeq, isLongOffset, frame);
+    return ZSTD_decompressSequences_body(dctx, dst, maxDstSize, seqStart, =
seqSize, nbSeq, isLongOffset);
 }
=20
 static size_t
 ZSTD_decompressSequencesSplitLitBuffer_default(ZSTD_DCtx* dctx,
                                                void* dst, size_t maxDstSiz=
e,
                                          const void* seqStart, size_t seqS=
ize, int nbSeq,
-                                         const ZSTD_longOffset_e isLongOff=
set,
-                                         const int frame)
+                                         const ZSTD_longOffset_e isLongOff=
set)
 {
-    return ZSTD_decompressSequences_bodySplitLitBuffer(dctx, dst, maxDstSi=
ze, seqStart, seqSize, nbSeq, isLongOffset, frame);
+    return ZSTD_decompressSequences_bodySplitLitBuffer(dctx, dst, maxDstSi=
ze, seqStart, seqSize, nbSeq, isLongOffset);
 }
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG */
=20
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
=20
-FORCE_INLINE_TEMPLATE size_t
-ZSTD_prefetchMatch(size_t prefetchPos, seq_t const sequence,
+FORCE_INLINE_TEMPLATE
+
+size_t ZSTD_prefetchMatch(size_t prefetchPos, seq_t const sequence,
                    const BYTE* const prefixStart, const BYTE* const dictEn=
d)
 {
     prefetchPos +=3D sequence.litLength;
     {   const BYTE* const matchBase =3D (sequence.offset > prefetchPos) ? =
dictEnd : prefixStart;
-        const BYTE* const match =3D matchBase + prefetchPos - sequence.off=
set; /* note : this operation can overflow when seq.offset is really too la=
rge, which can only happen when input is corrupted.
-                                                                          =
    * No consequence though : memory address is only used for prefetching, =
not for dereferencing */
+        /* note : this operation can overflow when seq.offset is really to=
o large, which can only happen when input is corrupted.
+         * No consequence though : memory address is only used for prefetc=
hing, not for dereferencing */
+        const BYTE* const match =3D ZSTD_wrappedPtrSub(ZSTD_wrappedPtrAdd(=
matchBase, prefetchPos), sequence.offset);
         PREFETCH_L1(match); PREFETCH_L1(match+CACHELINE_SIZE);   /* note :=
 it's safe to invoke PREFETCH() on any memory address, including invalid on=
es */
     }
     return prefetchPos + sequence.matchLength;
@@ -1657,20 +1724,18 @@ ZSTD_decompressSequencesLong_body(
                                ZSTD_DCtx* dctx,
                                void* dst, size_t maxDstSize,
                          const void* seqStart, size_t seqSize, int nbSeq,
-                         const ZSTD_longOffset_e isLongOffset,
-                         const int frame)
+                         const ZSTD_longOffset_e isLongOffset)
 {
     const BYTE* ip =3D (const BYTE*)seqStart;
     const BYTE* const iend =3D ip + seqSize;
     BYTE* const ostart =3D (BYTE*)dst;
-    BYTE* const oend =3D dctx->litBufferLocation =3D=3D ZSTD_in_dst ? dctx=
->litBuffer : ostart + maxDstSize;
+    BYTE* const oend =3D dctx->litBufferLocation =3D=3D ZSTD_in_dst ? dctx=
->litBuffer : ZSTD_maybeNullPtrAdd(ostart, maxDstSize);
     BYTE* op =3D ostart;
     const BYTE* litPtr =3D dctx->litPtr;
     const BYTE* litBufferEnd =3D dctx->litBufferEnd;
     const BYTE* const prefixStart =3D (const BYTE*) (dctx->prefixStart);
     const BYTE* const dictStart =3D (const BYTE*) (dctx->virtualStart);
     const BYTE* const dictEnd =3D (const BYTE*) (dctx->dictEnd);
-    (void)frame;
=20
     /* Regen sequences */
     if (nbSeq) {
@@ -1695,20 +1760,17 @@ ZSTD_decompressSequencesLong_body(
         ZSTD_initFseState(&seqState.stateML, &seqState.DStream, dctx->MLTp=
tr);
=20
         /* prepare in advance */
-        for (seqNb=3D0; (BIT_reloadDStream(&seqState.DStream) <=3D BIT_DSt=
ream_completed) && (seqNb<seqAdvance); seqNb++) {
-            seq_t const sequence =3D ZSTD_decodeSequence(&seqState, isLong=
Offset);
+        for (seqNb=3D0; seqNb<seqAdvance; seqNb++) {
+            seq_t const sequence =3D ZSTD_decodeSequence(&seqState, isLong=
Offset, seqNb =3D=3D nbSeq-1);
             prefetchPos =3D ZSTD_prefetchMatch(prefetchPos, sequence, pref=
ixStart, dictEnd);
             sequences[seqNb] =3D sequence;
         }
-        RETURN_ERROR_IF(seqNb<seqAdvance, corruption_detected, "");
=20
         /* decompress without stomping litBuffer */
-        for (; (BIT_reloadDStream(&(seqState.DStream)) <=3D BIT_DStream_co=
mpleted) && (seqNb < nbSeq); seqNb++) {
-            seq_t sequence =3D ZSTD_decodeSequence(&seqState, isLongOffset=
);
-            size_t oneSeqSize;
+        for (; seqNb < nbSeq; seqNb++) {
+            seq_t sequence =3D ZSTD_decodeSequence(&seqState, isLongOffset=
, seqNb =3D=3D nbSeq-1);
=20
-            if (dctx->litBufferLocation =3D=3D ZSTD_split && litPtr + sequ=
ences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK].litLength > dctx->litBuff=
erEnd)
-            {
+            if (dctx->litBufferLocation =3D=3D ZSTD_split && litPtr + sequ=
ences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK].litLength > dctx->litBuff=
erEnd) {
                 /* lit buffer is reaching split point, empty out the first=
 buffer and transition to litExtraBuffer */
                 const size_t leftoverLit =3D dctx->litBufferEnd - litPtr;
                 if (leftoverLit)
@@ -1721,26 +1783,26 @@ ZSTD_decompressSequencesLong_body(
                 litPtr =3D dctx->litExtraBuffer;
                 litBufferEnd =3D dctx->litExtraBuffer + ZSTD_LITBUFFEREXTR=
ASIZE;
                 dctx->litBufferLocation =3D ZSTD_not_in_dst;
-                oneSeqSize =3D ZSTD_execSequence(op, oend, sequences[(seqN=
b - ADVANCED_SEQS) & STORED_SEQS_MASK], &litPtr, litBufferEnd, prefixStart,=
 dictStart, dictEnd);
+                {   size_t const oneSeqSize =3D ZSTD_execSequence(op, oend=
, sequences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK], &litPtr, litBuffer=
End, prefixStart, dictStart, dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_A=
SSERT_VALID_SEQUENCE)
-                assert(!ZSTD_isError(oneSeqSize));
-                if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequen=
ces[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK], prefixStart, dictStart);
+                    assert(!ZSTD_isError(oneSeqSize));
+                    ZSTD_assertValidSequence(dctx, op, oend, sequences[(se=
qNb - ADVANCED_SEQS) & STORED_SEQS_MASK], prefixStart, dictStart);
 #endif
-                if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
+                    if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
=20
-                prefetchPos =3D ZSTD_prefetchMatch(prefetchPos, sequence, =
prefixStart, dictEnd);
-                sequences[seqNb & STORED_SEQS_MASK] =3D sequence;
-                op +=3D oneSeqSize;
-            }
+                    prefetchPos =3D ZSTD_prefetchMatch(prefetchPos, sequen=
ce, prefixStart, dictEnd);
+                    sequences[seqNb & STORED_SEQS_MASK] =3D sequence;
+                    op +=3D oneSeqSize;
+            }   }
             else
             {
                 /* lit buffer is either wholly contained in first or secon=
d split, or not split at all*/
-                oneSeqSize =3D dctx->litBufferLocation =3D=3D ZSTD_split ?
+                size_t const oneSeqSize =3D dctx->litBufferLocation =3D=3D=
 ZSTD_split ?
                     ZSTD_execSequenceSplitLitBuffer(op, oend, litPtr + seq=
uences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK].litLength - WILDCOPY_OVE=
RLENGTH, sequences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK], &litPtr, li=
tBufferEnd, prefixStart, dictStart, dictEnd) :
                     ZSTD_execSequence(op, oend, sequences[(seqNb - ADVANCE=
D_SEQS) & STORED_SEQS_MASK], &litPtr, litBufferEnd, prefixStart, dictStart,=
 dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_A=
SSERT_VALID_SEQUENCE)
                 assert(!ZSTD_isError(oneSeqSize));
-                if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequen=
ces[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK], prefixStart, dictStart);
+                ZSTD_assertValidSequence(dctx, op, oend, sequences[(seqNb =
- ADVANCED_SEQS) & STORED_SEQS_MASK], prefixStart, dictStart);
 #endif
                 if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
=20
@@ -1749,17 +1811,15 @@ ZSTD_decompressSequencesLong_body(
                 op +=3D oneSeqSize;
             }
         }
-        RETURN_ERROR_IF(seqNb<nbSeq, corruption_detected, "");
+        RETURN_ERROR_IF(!BIT_endOfDStream(&seqState.DStream), corruption_d=
etected, "");
=20
         /* finish queue */
         seqNb -=3D seqAdvance;
         for ( ; seqNb<nbSeq ; seqNb++) {
             seq_t *sequence =3D &(sequences[seqNb&STORED_SEQS_MASK]);
-            if (dctx->litBufferLocation =3D=3D ZSTD_split && litPtr + sequ=
ence->litLength > dctx->litBufferEnd)
-            {
+            if (dctx->litBufferLocation =3D=3D ZSTD_split && litPtr + sequ=
ence->litLength > dctx->litBufferEnd) {
                 const size_t leftoverLit =3D dctx->litBufferEnd - litPtr;
-                if (leftoverLit)
-                {
+                if (leftoverLit) {
                     RETURN_ERROR_IF(leftoverLit > (size_t)(oend - op), dst=
Size_tooSmall, "remaining lit must fit within dstBuffer");
                     ZSTD_safecopyDstBeforeSrc(op, litPtr, leftoverLit);
                     sequence->litLength -=3D leftoverLit;
@@ -1768,11 +1828,10 @@ ZSTD_decompressSequencesLong_body(
                 litPtr =3D dctx->litExtraBuffer;
                 litBufferEnd =3D dctx->litExtraBuffer + ZSTD_LITBUFFEREXTR=
ASIZE;
                 dctx->litBufferLocation =3D ZSTD_not_in_dst;
-                {
-                    size_t const oneSeqSize =3D ZSTD_execSequence(op, oend=
, *sequence, &litPtr, litBufferEnd, prefixStart, dictStart, dictEnd);
+                {   size_t const oneSeqSize =3D ZSTD_execSequence(op, oend=
, *sequence, &litPtr, litBufferEnd, prefixStart, dictStart, dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_A=
SSERT_VALID_SEQUENCE)
                     assert(!ZSTD_isError(oneSeqSize));
-                    if (frame) ZSTD_assertValidSequence(dctx, op, oend, se=
quences[seqNb&STORED_SEQS_MASK], prefixStart, dictStart);
+                    ZSTD_assertValidSequence(dctx, op, oend, sequences[seq=
Nb&STORED_SEQS_MASK], prefixStart, dictStart);
 #endif
                     if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
                     op +=3D oneSeqSize;
@@ -1785,7 +1844,7 @@ ZSTD_decompressSequencesLong_body(
                     ZSTD_execSequence(op, oend, *sequence, &litPtr, litBuf=
ferEnd, prefixStart, dictStart, dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_A=
SSERT_VALID_SEQUENCE)
                 assert(!ZSTD_isError(oneSeqSize));
-                if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequen=
ces[seqNb&STORED_SEQS_MASK], prefixStart, dictStart);
+                ZSTD_assertValidSequence(dctx, op, oend, sequences[seqNb&S=
TORED_SEQS_MASK], prefixStart, dictStart);
 #endif
                 if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
                 op +=3D oneSeqSize;
@@ -1797,8 +1856,7 @@ ZSTD_decompressSequencesLong_body(
     }
=20
     /* last literal segment */
-    if (dctx->litBufferLocation =3D=3D ZSTD_split)  /* first deplete liter=
al buffer in dst, then copy litExtraBuffer */
-    {
+    if (dctx->litBufferLocation =3D=3D ZSTD_split) { /* first deplete lite=
ral buffer in dst, then copy litExtraBuffer */
         size_t const lastLLSize =3D litBufferEnd - litPtr;
         RETURN_ERROR_IF(lastLLSize > (size_t)(oend - op), dstSize_tooSmall=
, "");
         if (op !=3D NULL) {
@@ -1816,17 +1874,16 @@ ZSTD_decompressSequencesLong_body(
         }
     }
=20
-    return op-ostart;
+    return (size_t)(op - ostart);
 }
=20
 static size_t
 ZSTD_decompressSequencesLong_default(ZSTD_DCtx* dctx,
                                  void* dst, size_t maxDstSize,
                            const void* seqStart, size_t seqSize, int nbSeq=
,
-                           const ZSTD_longOffset_e isLongOffset,
-                           const int frame)
+                           const ZSTD_longOffset_e isLongOffset)
 {
-    return ZSTD_decompressSequencesLong_body(dctx, dst, maxDstSize, seqSta=
rt, seqSize, nbSeq, isLongOffset, frame);
+    return ZSTD_decompressSequencesLong_body(dctx, dst, maxDstSize, seqSta=
rt, seqSize, nbSeq, isLongOffset);
 }
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT */
=20
@@ -1838,20 +1895,18 @@ DONT_VECTORIZE
 ZSTD_decompressSequences_bmi2(ZSTD_DCtx* dctx,
                                  void* dst, size_t maxDstSize,
                            const void* seqStart, size_t seqSize, int nbSeq=
,
-                           const ZSTD_longOffset_e isLongOffset,
-                           const int frame)
+                           const ZSTD_longOffset_e isLongOffset)
 {
-    return ZSTD_decompressSequences_body(dctx, dst, maxDstSize, seqStart, =
seqSize, nbSeq, isLongOffset, frame);
+    return ZSTD_decompressSequences_body(dctx, dst, maxDstSize, seqStart, =
seqSize, nbSeq, isLongOffset);
 }
 static BMI2_TARGET_ATTRIBUTE size_t
 DONT_VECTORIZE
 ZSTD_decompressSequencesSplitLitBuffer_bmi2(ZSTD_DCtx* dctx,
                                  void* dst, size_t maxDstSize,
                            const void* seqStart, size_t seqSize, int nbSeq=
,
-                           const ZSTD_longOffset_e isLongOffset,
-                           const int frame)
+                           const ZSTD_longOffset_e isLongOffset)
 {
-    return ZSTD_decompressSequences_bodySplitLitBuffer(dctx, dst, maxDstSi=
ze, seqStart, seqSize, nbSeq, isLongOffset, frame);
+    return ZSTD_decompressSequences_bodySplitLitBuffer(dctx, dst, maxDstSi=
ze, seqStart, seqSize, nbSeq, isLongOffset);
 }
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG */
=20
@@ -1860,50 +1915,40 @@ static BMI2_TARGET_ATTRIBUTE size_t
 ZSTD_decompressSequencesLong_bmi2(ZSTD_DCtx* dctx,
                                  void* dst, size_t maxDstSize,
                            const void* seqStart, size_t seqSize, int nbSeq=
,
-                           const ZSTD_longOffset_e isLongOffset,
-                           const int frame)
+                           const ZSTD_longOffset_e isLongOffset)
 {
-    return ZSTD_decompressSequencesLong_body(dctx, dst, maxDstSize, seqSta=
rt, seqSize, nbSeq, isLongOffset, frame);
+    return ZSTD_decompressSequencesLong_body(dctx, dst, maxDstSize, seqSta=
rt, seqSize, nbSeq, isLongOffset);
 }
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT */
=20
 #endif /* DYNAMIC_BMI2 */
=20
-typedef size_t (*ZSTD_decompressSequences_t)(
-                            ZSTD_DCtx* dctx,
-                            void* dst, size_t maxDstSize,
-                            const void* seqStart, size_t seqSize, int nbSe=
q,
-                            const ZSTD_longOffset_e isLongOffset,
-                            const int frame);
-
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG
 static size_t
 ZSTD_decompressSequences(ZSTD_DCtx* dctx, void* dst, size_t maxDstSize,
                    const void* seqStart, size_t seqSize, int nbSeq,
-                   const ZSTD_longOffset_e isLongOffset,
-                   const int frame)
+                   const ZSTD_longOffset_e isLongOffset)
 {
     DEBUGLOG(5, "ZSTD_decompressSequences");
 #if DYNAMIC_BMI2
     if (ZSTD_DCtx_get_bmi2(dctx)) {
-        return ZSTD_decompressSequences_bmi2(dctx, dst, maxDstSize, seqSta=
rt, seqSize, nbSeq, isLongOffset, frame);
+        return ZSTD_decompressSequences_bmi2(dctx, dst, maxDstSize, seqSta=
rt, seqSize, nbSeq, isLongOffset);
     }
 #endif
-    return ZSTD_decompressSequences_default(dctx, dst, maxDstSize, seqStar=
t, seqSize, nbSeq, isLongOffset, frame);
+    return ZSTD_decompressSequences_default(dctx, dst, maxDstSize, seqStar=
t, seqSize, nbSeq, isLongOffset);
 }
 static size_t
 ZSTD_decompressSequencesSplitLitBuffer(ZSTD_DCtx* dctx, void* dst, size_t =
maxDstSize,
                                  const void* seqStart, size_t seqSize, int=
 nbSeq,
-                                 const ZSTD_longOffset_e isLongOffset,
-                                 const int frame)
+                                 const ZSTD_longOffset_e isLongOffset)
 {
     DEBUGLOG(5, "ZSTD_decompressSequencesSplitLitBuffer");
 #if DYNAMIC_BMI2
     if (ZSTD_DCtx_get_bmi2(dctx)) {
-        return ZSTD_decompressSequencesSplitLitBuffer_bmi2(dctx, dst, maxD=
stSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
+        return ZSTD_decompressSequencesSplitLitBuffer_bmi2(dctx, dst, maxD=
stSize, seqStart, seqSize, nbSeq, isLongOffset);
     }
 #endif
-    return ZSTD_decompressSequencesSplitLitBuffer_default(dctx, dst, maxDs=
tSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
+    return ZSTD_decompressSequencesSplitLitBuffer_default(dctx, dst, maxDs=
tSize, seqStart, seqSize, nbSeq, isLongOffset);
 }
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG */
=20
@@ -1917,67 +1962,113 @@ static size_t
 ZSTD_decompressSequencesLong(ZSTD_DCtx* dctx,
                              void* dst, size_t maxDstSize,
                              const void* seqStart, size_t seqSize, int nbS=
eq,
-                             const ZSTD_longOffset_e isLongOffset,
-                             const int frame)
+                             const ZSTD_longOffset_e isLongOffset)
 {
     DEBUGLOG(5, "ZSTD_decompressSequencesLong");
 #if DYNAMIC_BMI2
     if (ZSTD_DCtx_get_bmi2(dctx)) {
-        return ZSTD_decompressSequencesLong_bmi2(dctx, dst, maxDstSize, se=
qStart, seqSize, nbSeq, isLongOffset, frame);
+        return ZSTD_decompressSequencesLong_bmi2(dctx, dst, maxDstSize, se=
qStart, seqSize, nbSeq, isLongOffset);
     }
 #endif
-  return ZSTD_decompressSequencesLong_default(dctx, dst, maxDstSize, seqSt=
art, seqSize, nbSeq, isLongOffset, frame);
+  return ZSTD_decompressSequencesLong_default(dctx, dst, maxDstSize, seqSt=
art, seqSize, nbSeq, isLongOffset);
 }
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT */
=20
-#if !defined(ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT) && \
-    !defined(ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG)
-/* ZSTD_getLongOffsetsShare() :
+/*
+ * @returns The total size of the history referenceable by zstd, including
+ * both the prefix and the extDict. At @p op any offset larger than this
+ * is invalid.
+ */
+static size_t ZSTD_totalHistorySize(BYTE* op, BYTE const* virtualStart)
+{
+    return (size_t)(op - virtualStart);
+}
+
+typedef struct {
+    unsigned longOffsetShare;
+    unsigned maxNbAdditionalBits;
+} ZSTD_OffsetInfo;
+
+/* ZSTD_getOffsetInfo() :
  * condition : offTable must be valid
  * @return : "share" of long offsets (arbitrarily defined as > (1<<23))
- *           compared to maximum possible of (1<<OffFSELog) */
-static unsigned
-ZSTD_getLongOffsetsShare(const ZSTD_seqSymbol* offTable)
+ *           compared to maximum possible of (1<<OffFSELog),
+ *           as well as the maximum number additional bits required.
+ */
+static ZSTD_OffsetInfo
+ZSTD_getOffsetInfo(const ZSTD_seqSymbol* offTable, int nbSeq)
 {
-    const void* ptr =3D offTable;
-    U32 const tableLog =3D ((const ZSTD_seqSymbol_header*)ptr)[0].tableLog=
;
-    const ZSTD_seqSymbol* table =3D offTable + 1;
-    U32 const max =3D 1 << tableLog;
-    U32 u, total =3D 0;
-    DEBUGLOG(5, "ZSTD_getLongOffsetsShare: (tableLog=3D%u)", tableLog);
-
-    assert(max <=3D (1 << OffFSELog));  /* max not too large */
-    for (u=3D0; u<max; u++) {
-        if (table[u].nbAdditionalBits > 22) total +=3D 1;
+    ZSTD_OffsetInfo info =3D {0, 0};
+    /* If nbSeq =3D=3D 0, then the offTable is uninitialized, but we have
+     * no sequences, so both values should be 0.
+     */
+    if (nbSeq !=3D 0) {
+        const void* ptr =3D offTable;
+        U32 const tableLog =3D ((const ZSTD_seqSymbol_header*)ptr)[0].tabl=
eLog;
+        const ZSTD_seqSymbol* table =3D offTable + 1;
+        U32 const max =3D 1 << tableLog;
+        U32 u;
+        DEBUGLOG(5, "ZSTD_getLongOffsetsShare: (tableLog=3D%u)", tableLog)=
;
+
+        assert(max <=3D (1 << OffFSELog));  /* max not too large */
+        for (u=3D0; u<max; u++) {
+            info.maxNbAdditionalBits =3D MAX(info.maxNbAdditionalBits, tab=
le[u].nbAdditionalBits);
+            if (table[u].nbAdditionalBits > 22) info.longOffsetShare +=3D =
1;
+        }
+
+        assert(tableLog <=3D OffFSELog);
+        info.longOffsetShare <<=3D (OffFSELog - tableLog);  /* scale to Of=
fFSELog */
     }
=20
-    assert(tableLog <=3D OffFSELog);
-    total <<=3D (OffFSELog - tableLog);  /* scale to OffFSELog */
+    return info;
+}
=20
-    return total;
+/*
+ * @returns The maximum offset we can decode in one read of our bitstream,=
 without
+ * reloading more bits in the middle of the offset bits read. Any offsets =
larger
+ * than this must use the long offset decoder.
+ */
+static size_t ZSTD_maxShortOffset(void)
+{
+    if (MEM_64bits()) {
+        /* We can decode any offset without reloading bits.
+         * This might change if the max window size grows.
+         */
+        ZSTD_STATIC_ASSERT(ZSTD_WINDOWLOG_MAX <=3D 31);
+        return (size_t)-1;
+    } else {
+        /* The maximum offBase is (1 << (STREAM_ACCUMULATOR_MIN + 1)) - 1.
+         * This offBase would require STREAM_ACCUMULATOR_MIN extra bits.
+         * Then we have to subtract ZSTD_REP_NUM to get the maximum possib=
le offset.
+         */
+        size_t const maxOffbase =3D ((size_t)1 << (STREAM_ACCUMULATOR_MIN =
+ 1)) - 1;
+        size_t const maxOffset =3D maxOffbase - ZSTD_REP_NUM;
+        assert(ZSTD_highbit32((U32)maxOffbase) =3D=3D STREAM_ACCUMULATOR_M=
IN);
+        return maxOffset;
+    }
 }
-#endif
=20
 size_t
 ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
                               void* dst, size_t dstCapacity,
-                        const void* src, size_t srcSize, const int frame, =
const streaming_operation streaming)
+                        const void* src, size_t srcSize, const streaming_o=
peration streaming)
 {   /* blockType =3D=3D blockCompressed */
     const BYTE* ip =3D (const BYTE*)src;
-    /* isLongOffset must be true if there are long offsets.
-     * Offsets are long if they are larger than 2^STREAM_ACCUMULATOR_MIN.
-     * We don't expect that to be the case in 64-bit mode.
-     * In block mode, window size is not known, so we have to be conservat=
ive.
-     * (note: but it could be evaluated from current-lowLimit)
-     */
-    ZSTD_longOffset_e const isLongOffset =3D (ZSTD_longOffset_e)(MEM_32bit=
s() && (!frame || (dctx->fParams.windowSize > (1ULL << STREAM_ACCUMULATOR_M=
IN))));
-    DEBUGLOG(5, "ZSTD_decompressBlock_internal (size : %u)", (U32)srcSize)=
;
-
-    RETURN_ERROR_IF(srcSize >=3D ZSTD_BLOCKSIZE_MAX, srcSize_wrong, "");
+    DEBUGLOG(5, "ZSTD_decompressBlock_internal (cSize : %u)", (unsigned)sr=
cSize);
+
+    /* Note : the wording of the specification
+     * allows compressed block to be sized exactly ZSTD_blockSizeMax(dctx)=
.
+     * This generally does not happen, as it makes little sense,
+     * since an uncompressed block would feature same size and have no dec=
ompression cost.
+     * Also, note that decoder from reference libzstd before < v1.5.4
+     * would consider this edge case as an error.
+     * As a consequence, avoid generating compressed blocks of size ZSTD_b=
lockSizeMax(dctx)
+     * for broader compatibility with the deployed ecosystem of zstd decod=
ers */
+    RETURN_ERROR_IF(srcSize > ZSTD_blockSizeMax(dctx), srcSize_wrong, "");
=20
     /* Decode literals section */
     {   size_t const litCSize =3D ZSTD_decodeLiteralsBlock(dctx, src, srcS=
ize, dst, dstCapacity, streaming);
-        DEBUGLOG(5, "ZSTD_decodeLiteralsBlock : %u", (U32)litCSize);
+        DEBUGLOG(5, "ZSTD_decodeLiteralsBlock : cSize=3D%u, nbLiterals=3D%=
zu", (U32)litCSize, dctx->litSize);
         if (ZSTD_isError(litCSize)) return litCSize;
         ip +=3D litCSize;
         srcSize -=3D litCSize;
@@ -1985,6 +2076,23 @@ ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
=20
     /* Build Decoding Tables */
     {
+        /* Compute the maximum block size, which must also work when !fram=
e and fParams are unset.
+         * Additionally, take the min with dstCapacity to ensure that the =
totalHistorySize fits in a size_t.
+         */
+        size_t const blockSizeMax =3D MIN(dstCapacity, ZSTD_blockSizeMax(d=
ctx));
+        size_t const totalHistorySize =3D ZSTD_totalHistorySize(ZSTD_maybe=
NullPtrAdd((BYTE*)dst, blockSizeMax), (BYTE const*)dctx->virtualStart);
+        /* isLongOffset must be true if there are long offsets.
+         * Offsets are long if they are larger than ZSTD_maxShortOffset().
+         * We don't expect that to be the case in 64-bit mode.
+         *
+         * We check here to see if our history is large enough to allow lo=
ng offsets.
+         * If it isn't, then we can't possible have (valid) long offsets. =
If the offset
+         * is invalid, then it is okay to read it incorrectly.
+         *
+         * If isLongOffsets is true, then we will later check our decoding=
 table to see
+         * if it is even possible to generate long offsets.
+         */
+        ZSTD_longOffset_e isLongOffset =3D (ZSTD_longOffset_e)(MEM_32bits(=
) && (totalHistorySize > ZSTD_maxShortOffset()));
         /* These macros control at build-time which decompressor implement=
ation
          * we use. If neither is defined, we do some inspection and dispat=
ch at
          * runtime.
@@ -1992,6 +2100,11 @@ ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
 #if !defined(ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT) && \
     !defined(ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG)
         int usePrefetchDecoder =3D dctx->ddictIsCold;
+#else
+        /* Set to 1 to avoid computing offset info if we don't need to.
+         * Otherwise this value is ignored.
+         */
+        int usePrefetchDecoder =3D 1;
 #endif
         int nbSeq;
         size_t const seqHSize =3D ZSTD_decodeSeqHeaders(dctx, &nbSeq, ip, =
srcSize);
@@ -1999,39 +2112,54 @@ ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
         ip +=3D seqHSize;
         srcSize -=3D seqHSize;
=20
-        RETURN_ERROR_IF(dst =3D=3D NULL && nbSeq > 0, dstSize_tooSmall, "N=
ULL not handled");
+        RETURN_ERROR_IF((dst =3D=3D NULL || dstCapacity =3D=3D 0) && nbSeq=
 > 0, dstSize_tooSmall, "NULL not handled");
+        RETURN_ERROR_IF(MEM_64bits() && sizeof(size_t) =3D=3D sizeof(void*=
) && (size_t)(-1) - (size_t)dst < (size_t)(1 << 20), dstSize_tooSmall,
+                "invalid dst");
=20
-#if !defined(ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT) && \
-    !defined(ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG)
-        if ( !usePrefetchDecoder
-          && (!frame || (dctx->fParams.windowSize > (1<<24)))
-          && (nbSeq>ADVANCED_SEQS) ) {  /* could probably use a larger nbS=
eq limit */
-            U32 const shareLongOffsets =3D ZSTD_getLongOffsetsShare(dctx->=
OFTptr);
-            U32 const minShare =3D MEM_64bits() ? 7 : 20; /* heuristic val=
ues, correspond to 2.73% and 7.81% */
-            usePrefetchDecoder =3D (shareLongOffsets >=3D minShare);
+        /* If we could potentially have long offsets, or we might want to =
use the prefetch decoder,
+         * compute information about the share of long offsets, and the ma=
ximum nbAdditionalBits.
+         * NOTE: could probably use a larger nbSeq limit
+         */
+        if (isLongOffset || (!usePrefetchDecoder && (totalHistorySize > (1=
u << 24)) && (nbSeq > 8))) {
+            ZSTD_OffsetInfo const info =3D ZSTD_getOffsetInfo(dctx->OFTptr=
, nbSeq);
+            if (isLongOffset && info.maxNbAdditionalBits <=3D STREAM_ACCUM=
ULATOR_MIN) {
+                /* If isLongOffset, but the maximum number of additional b=
its that we see in our table is small
+                 * enough, then we know it is impossible to have too long =
an offset in this block, so we can
+                 * use the regular offset decoder.
+                 */
+                isLongOffset =3D ZSTD_lo_isRegularOffset;
+            }
+            if (!usePrefetchDecoder) {
+                U32 const minShare =3D MEM_64bits() ? 7 : 20; /* heuristic=
 values, correspond to 2.73% and 7.81% */
+                usePrefetchDecoder =3D (info.longOffsetShare >=3D minShare=
);
+            }
         }
-#endif
=20
         dctx->ddictIsCold =3D 0;
=20
 #if !defined(ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT) && \
     !defined(ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG)
-        if (usePrefetchDecoder)
+        if (usePrefetchDecoder) {
+#else
+        (void)usePrefetchDecoder;
+        {
 #endif
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
-            return ZSTD_decompressSequencesLong(dctx, dst, dstCapacity, ip=
, srcSize, nbSeq, isLongOffset, frame);
+            return ZSTD_decompressSequencesLong(dctx, dst, dstCapacity, ip=
, srcSize, nbSeq, isLongOffset);
 #endif
+        }
=20
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG
         /* else */
         if (dctx->litBufferLocation =3D=3D ZSTD_split)
-            return ZSTD_decompressSequencesSplitLitBuffer(dctx, dst, dstCa=
pacity, ip, srcSize, nbSeq, isLongOffset, frame);
+            return ZSTD_decompressSequencesSplitLitBuffer(dctx, dst, dstCa=
pacity, ip, srcSize, nbSeq, isLongOffset);
         else
-            return ZSTD_decompressSequences(dctx, dst, dstCapacity, ip, sr=
cSize, nbSeq, isLongOffset, frame);
+            return ZSTD_decompressSequences(dctx, dst, dstCapacity, ip, sr=
cSize, nbSeq, isLongOffset);
 #endif
     }
 }
=20
+ZSTD_ALLOW_POINTER_OVERFLOW_ATTR
 void ZSTD_checkContinuity(ZSTD_DCtx* dctx, const void* dst, size_t dstSize=
)
 {
     if (dst !=3D dctx->previousDstEnd && dstSize > 0) {   /* not contiguou=
s */
@@ -2042,13 +2170,23 @@ void ZSTD_checkContinuity(ZSTD_DCtx* dctx, const vo=
id* dst, size_t dstSize)
     }
 }
=20
-size_t ZSTD_decompressBlock(ZSTD_DCtx* dctx,
-                            void* dst, size_t dstCapacity,
-                      const void* src, size_t srcSize)
+size_t ZSTD_decompressBlock_deprecated(ZSTD_DCtx* dctx,
+                                       void* dst, size_t dstCapacity,
+                                 const void* src, size_t srcSize)
 {
     size_t dSize;
+    dctx->isFrameDecompression =3D 0;
     ZSTD_checkContinuity(dctx, dst, dstCapacity);
-    dSize =3D ZSTD_decompressBlock_internal(dctx, dst, dstCapacity, src, s=
rcSize, /* frame */ 0, not_streaming);
+    dSize =3D ZSTD_decompressBlock_internal(dctx, dst, dstCapacity, src, s=
rcSize, not_streaming);
+    FORWARD_IF_ERROR(dSize, "");
     dctx->previousDstEnd =3D (char*)dst + dSize;
     return dSize;
 }
+
+/* NOTE: Must just wrap ZSTD_decompressBlock_deprecated() */
+size_t ZSTD_decompressBlock(ZSTD_DCtx* dctx,
+                            void* dst, size_t dstCapacity,
+                      const void* src, size_t srcSize)
+{
+    return ZSTD_decompressBlock_deprecated(dctx, dst, dstCapacity, src, sr=
cSize);
+}
diff --git a/lib/zstd/decompress/zstd_decompress_block.h b/lib/zstd/decompr=
ess/zstd_decompress_block.h
index b8e912c6fd85..ffb145688b18 100644
--- a/lib/zstd/decompress/zstd_decompress_block.h
+++ b/lib/zstd/decompress/zstd_decompress_block.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -44,7 +45,7 @@ typedef enum {
  */
 size_t ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
                                void* dst, size_t dstCapacity,
-                         const void* src, size_t srcSize, const int frame,=
 const streaming_operation streaming);
+                         const void* src, size_t srcSize, const streaming_=
operation streaming);
=20
 /* ZSTD_buildFSETable() :
  * generate FSE decoding table for one symbol (ll, ml or off)
@@ -61,4 +62,9 @@ void ZSTD_buildFSETable(ZSTD_seqSymbol* dt,
                    unsigned tableLog, void* wksp, size_t wkspSize,
                    int bmi2);
=20
+/* Internal definition of ZSTD_decompressBlock() to avoid deprecation warn=
ings. */
+size_t ZSTD_decompressBlock_deprecated(ZSTD_DCtx* dctx,
+                            void* dst, size_t dstCapacity,
+                      const void* src, size_t srcSize);
+
 #endif /* ZSTD_DEC_BLOCK_H */
diff --git a/lib/zstd/decompress/zstd_decompress_internal.h b/lib/zstd/deco=
mpress/zstd_decompress_internal.h
index e165cbe9f59f..268915d66960 100644
--- a/lib/zstd/decompress/zstd_decompress_internal.h
+++ b/lib/zstd/decompress/zstd_decompress_internal.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Yann Collet, Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -70,12 +71,13 @@ static UNUSED_ATTR const U32 ML_base[MaxML+1] =3D {
=20
 #define ZSTD_BUILD_FSE_TABLE_WKSP_SIZE (sizeof(S16) * (MaxSeq + 1) + (1u <=
< MaxFSELog) + sizeof(U64))
 #define ZSTD_BUILD_FSE_TABLE_WKSP_SIZE_U32 ((ZSTD_BUILD_FSE_TABLE_WKSP_SIZ=
E + sizeof(U32) - 1) / sizeof(U32))
+#define ZSTD_HUFFDTABLE_CAPACITY_LOG 12
=20
 typedef struct {
     ZSTD_seqSymbol LLTable[SEQSYMBOL_TABLE_SIZE(LLFSELog)];    /* Note : S=
pace reserved for FSE Tables */
     ZSTD_seqSymbol OFTable[SEQSYMBOL_TABLE_SIZE(OffFSELog)];   /* is also =
used as temporary workspace while building hufTable during DDict creation *=
/
     ZSTD_seqSymbol MLTable[SEQSYMBOL_TABLE_SIZE(MLFSELog)];    /* and ther=
efore must be at least HUF_DECOMPRESS_WORKSPACE_SIZE large */
-    HUF_DTable hufTable[HUF_DTABLE_SIZE(HufLog)];  /* can accommodate HUF_=
decompress4X */
+    HUF_DTable hufTable[HUF_DTABLE_SIZE(ZSTD_HUFFDTABLE_CAPACITY_LOG)];  /=
* can accommodate HUF_decompress4X */
     U32 rep[ZSTD_REP_NUM];
     U32 workspace[ZSTD_BUILD_FSE_TABLE_WKSP_SIZE_U32];
 } ZSTD_entropyDTables_t;
@@ -130,7 +132,7 @@ struct ZSTD_DCtx_s
     const void* virtualStart;     /* virtual start of previous segment if =
it was just before current one */
     const void* dictEnd;          /* end of previous segment */
     size_t expected;
-    ZSTD_frameHeader fParams;
+    ZSTD_FrameHeader fParams;
     U64 processedCSize;
     U64 decodedSize;
     blockType_e bType;            /* used in ZSTD_decompressContinue(), st=
ore blockType between block header decoding and block decompression stages =
*/
@@ -147,7 +149,8 @@ struct ZSTD_DCtx_s
     size_t litSize;
     size_t rleSize;
     size_t staticSize;
-#if DYNAMIC_BMI2 !=3D 0
+    int isFrameDecompression;
+#if DYNAMIC_BMI2
     int bmi2;                     /* =3D=3D 1 if the CPU supports BMI2 and=
 0 otherwise. CPU support is determined dynamically once per context lifeti=
me. */
 #endif
=20
@@ -159,6 +162,8 @@ struct ZSTD_DCtx_s
     ZSTD_dictUses_e dictUses;
     ZSTD_DDictHashSet* ddictSet;                    /* Hash set for multip=
le ddicts */
     ZSTD_refMultipleDDicts_e refMultipleDDicts;     /* User specified: if =
=3D=3D 1, will allow references to multiple DDicts. Default =3D=3D 0 (disab=
led) */
+    int disableHufAsm;
+    int maxBlockSizeParam;
=20
     /* streaming */
     ZSTD_dStreamStage streamStage;
@@ -194,11 +199,11 @@ struct ZSTD_DCtx_s
 };  /* typedef'd to ZSTD_DCtx within "zstd.h" */
=20
 MEM_STATIC int ZSTD_DCtx_get_bmi2(const struct ZSTD_DCtx_s *dctx) {
-#if DYNAMIC_BMI2 !=3D 0
-=09return dctx->bmi2;
+#if DYNAMIC_BMI2
+    return dctx->bmi2;
 #else
     (void)dctx;
-=09return 0;
+    return 0;
 #endif
 }
=20
diff --git a/lib/zstd/decompress_sources.h b/lib/zstd/decompress_sources.h
index a06ca187aab5..8a47eb2a4514 100644
--- a/lib/zstd/decompress_sources.h
+++ b/lib/zstd/decompress_sources.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- * Copyright (c) Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
diff --git a/lib/zstd/zstd_common_module.c b/lib/zstd/zstd_common_module.c
index 73b97c2778c7..660b2d75a8e3 100644
--- a/lib/zstd/zstd_common_module.c
+++ b/lib/zstd/zstd_common_module.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /*
- * Copyright (c) Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -24,9 +24,6 @@ EXPORT_SYMBOL_GPL(HUF_readStats_wksp);
 EXPORT_SYMBOL_GPL(ZSTD_isError);
 EXPORT_SYMBOL_GPL(ZSTD_getErrorName);
 EXPORT_SYMBOL_GPL(ZSTD_getErrorCode);
-EXPORT_SYMBOL_GPL(ZSTD_customMalloc);
-EXPORT_SYMBOL_GPL(ZSTD_customCalloc);
-EXPORT_SYMBOL_GPL(ZSTD_customFree);
=20
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Zstd Common");
diff --git a/lib/zstd/zstd_decompress_module.c b/lib/zstd/zstd_decompress_m=
odule.c
index 06cf3e43bcaa..ab458a5a004a 100644
--- a/lib/zstd/zstd_decompress_module.c
+++ b/lib/zstd/zstd_decompress_module.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /*
- * Copyright (c) Facebook, Inc.
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
  * All rights reserved.
  *
  * This source code is licensed under both the BSD-style license (found in=
 the
@@ -44,6 +44,33 @@ size_t zstd_dctx_workspace_bound(void)
 }
 EXPORT_SYMBOL(zstd_dctx_workspace_bound);
=20
+zstd_dctx *zstd_create_dctx_advanced(zstd_custom_mem custom_mem)
+{
+=09return ZSTD_createDCtx_advanced(custom_mem);
+}
+EXPORT_SYMBOL(zstd_create_dctx_advanced);
+
+size_t zstd_free_dctx(zstd_dctx *dctx)
+{
+=09return ZSTD_freeDCtx(dctx);
+}
+EXPORT_SYMBOL(zstd_free_dctx);
+
+zstd_ddict *zstd_create_ddict_byreference(const void *dict, size_t dict_si=
ze,
+=09=09=09=09=09  zstd_custom_mem custom_mem)
+{
+=09return ZSTD_createDDict_advanced(dict, dict_size, ZSTD_dlm_byRef,
+=09=09=09=09=09 ZSTD_dct_auto, custom_mem);
+
+}
+EXPORT_SYMBOL(zstd_create_ddict_byreference);
+
+size_t zstd_free_ddict(zstd_ddict *ddict)
+{
+=09return ZSTD_freeDDict(ddict);
+}
+EXPORT_SYMBOL(zstd_free_ddict);
+
 zstd_dctx *zstd_init_dctx(void *workspace, size_t workspace_size)
 {
 =09if (workspace =3D=3D NULL)
@@ -59,6 +86,15 @@ size_t zstd_decompress_dctx(zstd_dctx *dctx, void *dst, =
size_t dst_capacity,
 }
 EXPORT_SYMBOL(zstd_decompress_dctx);
=20
+size_t zstd_decompress_using_ddict(zstd_dctx *dctx,
+=09void *dst, size_t dst_capacity, const void* src, size_t src_size,
+=09const zstd_ddict* ddict)
+{
+=09return ZSTD_decompress_usingDDict(dctx, dst, dst_capacity, src,
+=09=09=09=09=09  src_size, ddict);
+}
+EXPORT_SYMBOL(zstd_decompress_using_ddict);
+
 size_t zstd_dstream_workspace_bound(size_t max_window_size)
 {
 =09return ZSTD_estimateDStreamSize(max_window_size);
@@ -77,7 +113,7 @@ EXPORT_SYMBOL(zstd_init_dstream);
=20
 size_t zstd_reset_dstream(zstd_dstream *dstream)
 {
-=09return ZSTD_resetDStream(dstream);
+=09return ZSTD_DCtx_reset(dstream, ZSTD_reset_session_only);
 }
 EXPORT_SYMBOL(zstd_reset_dstream);
=20
--=20
2.55.0


