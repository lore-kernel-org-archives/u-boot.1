Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B62C55172
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 21:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C55DC411C1;
	Fri, 31 Jul 2026 21:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xWiqvdgz7FVg; Fri, 31 Jul 2026 21:49:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0CD6A410E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785534547;
	bh=5deJwqeZ/boejxKg2KpO7perGULhpFRPmq9bPZmnqiU=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xr4iWy20AaRydwgyqJYjQDsGFeRqbouxaMzXKTnsJadN//iAm3J0TLvLju6+MtFuq
	 axMs0vdnes5n9UctvLEqYSbUH7ZGaNc7YmjG9D39dEif8xxPWAFFyiMtI0wsz9CRMO
	 vf6YWbkOE2rcFKBvpRv2Yl+Cw6NeA3RCL3DEJB42LqejwZ0ubHBl0O/rbtNpCjzVUc
	 ot3X6LHvtym5XXObvmEvlk/WFAVwgiEis2I3wo/0WLHaacue4k+/8gAUIJJJvct5fs
	 ImD3AySds++zt1de2mafGwk1DQhTFhuK0Lnbqd5dMQicOgsTUcOCSlI+xYARN4KQcs
	 cif2j39OvOBlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CD6A410E9;
	Fri, 31 Jul 2026 21:49:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AC4037F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6CCB360641
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pCGx2kyH8FBt for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 20:08:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=munzzyy1@proton.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C41E26064E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C41E26064E
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C41E26064E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:08:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392DE844F6; Fri, 31 Jul 2026 22:08:06 +0200 (CEST)
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D66B680117
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 22:08:03 +0200 (CEST)
Date: Fri, 31 Jul 2026 20:07:59 +0000
To: =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>
From: Cole Munz <Munzzyy1@proton.me>
Cc: Qu Wenruo <wqu@suse.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
Subject: [PATCH] fs: btrfs: fix zstd decompression of sector-padded extents
Message-ID: <9acf406b5e73fa83001e1951e883143e2afb8b2d.1785528314.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 489277cc8b32bd96ba4b078068c52bf3d942620d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Jul 2026 21:49:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=proton.me; 
 s=protonmail; t=1785528483; x=1785787683;
 bh=5deJwqeZ/boejxKg2KpO7perGULhpFRPmq9bPZmnqiU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=GyfG8V9OkubsMTZU1Ekp/c/6HS8n760JchZmtjoHqRbTWk+wVaYaqNBjUbN0uB9IZ
 LR7BpddHA+smnm2Oe6oOyqjbAkcvUxusWltId1KvaS43AecK38td15EQWIhtUoCHyF
 32lIORnhZpiJxS75V68YG2yHBCjYTrAPX1MXFYHHU45C7UJ7JkJAv4FaxzWnVNZ8Am
 /1Wi/5PhGCAaR3Hrtu4Xt3jCBkKgm5LnOn+xc6dd2j9D54b7he+gvFDDJFhjBo6sXC
 OW01TPM0mhK4zFDagwPPd6QWJsp6hhs+LKrrlwZYeJLZWjOw01B8MwodSV2uBj4tia
 66UM6KJkjihJA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=proton.me
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=GyfG8V9O
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Munzzyy1@proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=proton.me header.i=@proton.me header.b="GyfG8V9O"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Btrfs pads compressed extents up to a sector boundary, so a file whose
size isn't sector-aligned still gets compressed as a frame whose
declared content size is the sector-rounded length, larger than the
extent's ram_bytes. zstd_decompress_dctx()'s one-shot API requires the
destination buffer to cover the whole frame and fails with
ZSTD_error_dstSize_tooSmall otherwise, even though
btrfs_read_extent_reg() and btrfs_read_extent_inline() already
zero-fill any short tail. The file then reads back truncated or the
read fails outright, which is what breaks fdt apply on zstd-compressed
overlays.

Decompress into a bounce buffer sized to the frame when the declared
content size exceeds ram_bytes, and copy out only what the caller
asked for. Also trim the input with zstd_find_frame_compressed_size()
first, since the on-disk extent may carry trailing sector padding
after the frame.

The fix lives here rather than in the shared lib/zstd/zstd.c wrapper
on purpose: for FIT images, ximg and ubifs an undersized destination
really does mean a corrupt input and should keep failing hard. Armbian
carries the same caller-side fix for this exact failure on RK3399 and
ODROID-N2 boards (armbian/build#9651, #10208), where it showed up as
"zstd_decompress: failed to decompress: 70".

Fixes: 918adf8e0733 ("btrfs: Use U-Boot API for decompression")
Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
 fs/btrfs/compression.c | 76 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c69524d38ecc..017e61242a68 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -6,7 +6,7 @@
  */
=20
 #include "btrfs.h"
-#include <abuf.h>
+#include <limits.h>
 #include <log.h>
 #include <malloc.h>
 #include <linux/lzo.h>
@@ -137,12 +137,78 @@ static u32 decompress_zlib(const u8 *_cbuf, u32 clen,=
 u8 *dbuf, u32 dlen)
=20
 static u32 decompress_zstd(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
 {
-=09struct abuf in, out;
+=09zstd_dctx *ctx;
+=09zstd_frame_header fh;
+=09size_t wsize, len, dst_capacity =3D dlen;
+=09void *workspace;
+=09u8 *dst =3D dbuf, *bounce =3D NULL;
+=09u32 ret;
+
+=09wsize =3D zstd_dctx_workspace_bound();
+=09workspace =3D malloc(wsize);
+=09if (!workspace)
+=09=09return -1;
+
+=09ctx =3D zstd_init_dctx(workspace, wsize);
+=09if (!ctx) {
+=09=09ret =3D -1;
+=09=09goto out;
+=09}
=20
-=09abuf_init_set(&in, (u8 *)cbuf, clen);
-=09abuf_init_set(&out, dbuf, dlen);
+=09/*
+=09 * Compressed extents are padded up to a sector boundary, so clen may
+=09 * include trailing junk after the actual zstd frame.
+=09 */
+=09len =3D zstd_find_frame_compressed_size(cbuf, clen);
+=09if (zstd_is_error(len)) {
+=09=09ret =3D -1;
+=09=09goto out;
+=09}
=20
-=09return zstd_decompress(&in, &out);
+=09/*
+=09 * Btrfs compresses whole sectors, so a file whose size is not a
+=09 * multiple of the sector size still yields a frame whose content
+=09 * size is the sector-rounded length, which can be larger than dlen
+=09 * (ram_bytes from the extent item). zstd_decompress_dctx() requires
+=09 * its output buffer to cover the whole frame and would otherwise
+=09 * fail with ZSTD_error_dstSize_tooSmall, even though the extra bytes
+=09 * are just padding the caller is going to discard: both
+=09 * btrfs_read_extent_reg() and btrfs_read_extent_inline() already
+=09 * zero-fill any tail beyond what we return here. Decompress into a
+=09 * bounce buffer sized to the frame when that happens.
+=09 */
+=09if (!zstd_get_frame_header(&fh, cbuf, len) &&
+=09    fh.frameContentSize !=3D ZSTD_CONTENTSIZE_UNKNOWN &&
+=09    fh.frameContentSize > dlen) {
+=09=09if (fh.frameContentSize > SIZE_MAX) {
+=09=09=09ret =3D -1;
+=09=09=09goto out;
+=09=09}
+=09=09bounce =3D malloc(fh.frameContentSize);
+=09=09if (!bounce) {
+=09=09=09ret =3D -1;
+=09=09=09goto out;
+=09=09}
+=09=09dst =3D bounce;
+=09=09dst_capacity =3D fh.frameContentSize;
+=09}
+
+=09len =3D zstd_decompress_dctx(ctx, dst, dst_capacity, cbuf, len);
+=09if (zstd_is_error(len)) {
+=09=09ret =3D -1;
+=09=09goto out;
+=09}
+
+=09if (bounce) {
+=09=09memcpy(dbuf, bounce, dlen);
+=09=09ret =3D dlen;
+=09} else {
+=09=09ret =3D len;
+=09}
+out:
+=09free(bounce);
+=09free(workspace);
+=09return ret;
 }
=20
 u32 btrfs_decompress(u8 type, const char *c, u32 clen, char *d, u32 dlen)
--=20
2.55.0


