Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06467C5516F
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 03:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C5E760678;
	Sat,  1 Aug 2026 03:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Y-OVQkrA0um; Sat,  1 Aug 2026 03:42:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DBAD60688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785555754;
	bh=pkHMFKmNJnJUddebBPqPaq+HQK9yaG/nhCavMmztCvs=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jafR752NW/wtnhrf4K9aYNZUt+IxMuXIsRDkgdI+5uQvaXko3xTtfs8mZUcykAxnH
	 s3a/UjdJ9JPOosyWpkIk8791e5xcHWX3mdML1hnO189qQ/iM2XiDHQNi12jI+Ts2oY
	 xoiKVXTINyCztRVmhNuIAYyqLVOb0dkDthA1l/aJPuZFMpXmCvQ6wE5vP3nFbAUNrc
	 GiR2tNBUn8hgTRoDJiv+M/Og559hO+2sSNb//Jl/zshy2ofkSdab/ZnFLbEdc2nZ/1
	 RdFXlUqKRXyWtLFLAEzI3sogP2Og4bi+H1atUdvfzM+gNbQlEZUX/SmuFfydRzd9Wp
	 NmR9el4M1Pn3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DBAD60688;
	Sat,  1 Aug 2026 03:42:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 134FB26F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 00:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED48A4011D
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 00:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zAiWJf3jzDlW for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 00:55:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=munzzyy1@proton.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8160040119
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8160040119
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8160040119
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 00:55:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A140844F6; Sat,  1 Aug 2026 02:55:27 +0200 (CEST)
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F70780117
 for <u-boot@lists.denx.de>; Sat,  1 Aug 2026 02:55:24 +0200 (CEST)
Date: Sat, 01 Aug 2026 00:55:20 +0000
To: kabel@kernel.org, trini@konsulko.com
From: Cole Munz <Munzzyy1@proton.me>
Cc: quwenruo.btrfs@gmx.com, sjg@chromium.org, u-boot@lists.denx.de,
 linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fs: btrfs: fix zstd decompression of compressed inline
 extents
Message-ID: <f6ac2bbdb9b559041cb0c82efccf89ea7262cb43.1785545440.git.Munzzyy1@proton.me>
In-Reply-To: <9acf406b5e73fa83001e1951e883143e2afb8b2d.1785528314.git.Munzzyy1@proton.me>
References: <9acf406b5e73fa83001e1951e883143e2afb8b2d.1785528314.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 35b1dcb1d958db46f6d16eb7b27bedfbc33e538f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sat, 01 Aug 2026 03:42:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=proton.me; 
 s=protonmail; t=1785545723; x=1785804923;
 bh=pkHMFKmNJnJUddebBPqPaq+HQK9yaG/nhCavMmztCvs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=AcTjr2za/pchPvTnAnocdjJkpO2ec7IRsPaMG64qwRCWFvz8+II4C0FBrcX4Wjhd6
 WnvjOkFveWnszm23wbmsB5RLxFo5SEuoOHQC51PgZWrfTRuee6oir+a/u1p/L+KLJI
 k90bLRzwSYWOzpl7a+dBv+V6LFJTOWdFDdq/361BHKMGDdWnj36S4kx8VSw8DDcHYZ
 gUtF9CD6pJhE4DaqMZVJOHfs/nFyIlCL2yC4eGqsOrsG2Je8YxXZ75vCor893UYZfS
 G+F7FbQADF2cpLQ7Djp3vjrL8lrKd04mF3Ep5KMiFZ4cbGKhTxXvY3d7TpPRMakcCy
 dDr9U+frJnpAA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=proton.me
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=AcTjr2za
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Munzzyy1@proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=proton.me header.i=@proton.me header.b="AcTjr2za"; 
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

The kernel compresses an inline extent as a whole block:
run_delalloc_inline() calls btrfs_compress_bio(inode, 0, blocksize, ...),
so the data is zero-filled past EOF and the resulting zstd frame declares
a content size of one block. The extent item records the unaligned file
size though - __cow_file_range_inline() passes i_size down to
insert_inline_extent(), which stores it as ram_bytes.

btrfs_read_extent_inline() sizes its decompression buffer from ram_bytes,
so for a 1900-byte file the destination is 1900 bytes while the frame
decodes to 4096. Since commit 918adf8e0733 ("btrfs: Use U-Boot API for
decompression") btrfs decompresses through the common U-Boot helper,
which uses the one-shot zstd_decompress_dctx(). That API requires the
destination to cover the whole frame and fails with dstSize_tooSmall,
error 70, otherwise. The streaming ZSTD_decompressStream() path it
replaced stopped once the output buffer was full, so it never hit this.

The kernel side does not notice because fs/btrfs/zstd.c streams into its
own buffer and copies out at most destlen.

Allocate a full block for the decompression buffer and copy only
ram_bytes back to the caller. An inline extent never spans more than one
block, which bounds the allocation.

This shows up on RK3399 and ODROID-N2 as "zstd_decompress: failed to
decompress: 70" (armbian/build#9651, #10208), where it breaks fdt apply
on zstd-compressed overlays. Images built with mkfs.btrfs --rootdir
--compress zstd do not reproduce it, since btrfs-progs writes a frame
whose content size already equals ram_bytes. Only files written at
runtime through the kernel trip it.

Fixes: 918adf8e0733 ("btrfs: Use U-Boot API for decompression")
Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
v2:
 - Move the fix into btrfs_read_extent_inline() and size the decompression
   buffer to a full block, as Qu suggested. decompress_zstd() is left alone=
.
 - Rewrite the commit message. The failing case is compressed inline
   extents, not sector-padded regular extents: Qu pointed out that
   ram_bytes is always block aligned for regular extents.
 - Drop the zstd_find_frame_compressed_size() input trimming from v1. The
   inline item length is already exact, so it was doing nothing.

v1: https://lore.kernel.org/u-boot/9acf406b5e73fa83001e1951e883143e2afb8b2d=
.1785528314.git.Munzzyy1@proton.me/

 fs/btrfs/inode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3998ffc2c819..53f1059e1ef8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -362,9 +362,11 @@ int btrfs_read_extent_inline(struct btrfs_path *path,
 =09=09=09     struct btrfs_file_extent_item *fi, char *dest)
 {
 =09struct extent_buffer *leaf =3D path->nodes[0];
+=09struct btrfs_fs_info *fs_info =3D leaf->fs_info;
 =09int slot =3D path->slots[0];
 =09char *cbuf =3D NULL;
 =09char *dbuf =3D NULL;
+=09u32 dbuf_size;
 =09u32 csize;
 =09u32 dsize;
 =09int ret;
@@ -380,8 +382,17 @@ int btrfs_read_extent_inline(struct btrfs_path *path,
=20
 =09/* Compressed extent, prepare the compressed and data buffer */
 =09dsize =3D btrfs_file_extent_ram_bytes(leaf, fi);
+=09/*
+=09 * The kernel compresses an inline extent as a whole block, zero-fillin=
g
+=09 * the tail past EOF, so the stream can decompress to more than
+=09 * ram_bytes.  zstd's one-shot API rejects a destination that cannot
+=09 * hold the entire frame, so give the decompressor a full block and cop=
y
+=09 * only ram_bytes back out.  An inline extent never spans more than one
+=09 * block, which bounds the allocation.
+=09 */
+=09dbuf_size =3D max_t(u32, dsize, fs_info->sectorsize);
 =09cbuf =3D malloc(csize);
-=09dbuf =3D malloc(dsize);
+=09dbuf =3D malloc(dbuf_size);
 =09if (!cbuf || !dbuf) {
 =09=09ret =3D -ENOMEM;
 =09=09goto out;
@@ -389,7 +400,7 @@ int btrfs_read_extent_inline(struct btrfs_path *path,
 =09read_extent_buffer(leaf, cbuf, btrfs_file_extent_inline_start(fi),
 =09=09=09   csize);
 =09ret =3D btrfs_decompress(btrfs_file_extent_compression(leaf, fi),
-=09=09=09       cbuf, csize, dbuf, dsize);
+=09=09=09       cbuf, csize, dbuf, dbuf_size);
 =09if (ret < 0) {
 =09=09ret =3D -EIO;
 =09=09goto out;
--=20
2.55.0


