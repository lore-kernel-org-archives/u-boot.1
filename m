Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117BBC55171
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 03:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5C9040774;
	Sat,  1 Aug 2026 03:42:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tr9WXl6K5c_p; Sat,  1 Aug 2026 03:42:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9203240769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785555753;
	bh=eq+db2Zwmc4KnZuPcPVApX+FMCVlDyt8KVTso/aPnk0=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6rk5rxrEHVUhVt9uvvMuQjHa/KOV782+hn2z50khVniDNfpnGOgiizn6eKkA1/fC
	 zZTWzlCM6yVmyWDC0s8GAuwtW5v3SSXt0n7cqtQHBLlec37S+IPkKrxoARHUcJjXBV
	 vjlqVLqQeMValpDfGaFUDDecrAOvhFrWSLqusAJsNG0VMDt+p0Ax+/zMkTOZpFGoRB
	 6OG6Pt0Wkj0PGc/jh/H7YO+RYmcTu+tGpRqNJmKHH9OE0vV3bwgBCImGQzJv8YddL5
	 wLJI3HRgwh+TT3hUg07Zfp1B1dfax3xB7syn9ybrc12gCEQVEG7QYrey7f+HueYKzp
	 SgcUk8IzYFjVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9203240769;
	Sat,  1 Aug 2026 03:42:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DD993B6
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 22:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FC2740DD8
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 22:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p2Q5CjVgZx_j for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 22:26:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=munzzyy1@proton.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D542740DA1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D542740DA1
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D542740DA1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 22:26:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C5784A0F; Sat,  1 Aug 2026 00:26:17 +0200 (CEST)
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82DD805D7
 for <u-boot@lists.denx.de>; Sat,  1 Aug 2026 00:26:14 +0200 (CEST)
Date: Fri, 31 Jul 2026 22:26:11 +0000
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
From: Cole Munz <Munzzyy1@proton.me>
Cc: =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: fix zstd decompression of sector-padded extents
Message-ID: <-pmHXWS0jQjmnEICAo6l7i5Q5tFivBJ1Mm162qdIm_69a1gcfU0tBo4C-bfELAT1lCrGHRKlYr3_EcKwLFRX18SHErryHV_TCdz93esbQ30=@proton.me>
In-Reply-To: <3659c07e-7f73-460c-8391-e2b8508e2bd4@gmx.com>
References: <9acf406b5e73fa83001e1951e883143e2afb8b2d.1785528314.git.Munzzyy1@proton.me>
 <3659c07e-7f73-460c-8391-e2b8508e2bd4@gmx.com>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 89e3bc73d3d641e170826cb58333f5d3a006a382
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sat, 01 Aug 2026 03:42:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=proton.me; 
 s=protonmail; t=1785536774; x=1785795974;
 bh=eq+db2Zwmc4KnZuPcPVApX+FMCVlDyt8KVTso/aPnk0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dYO2bMwgjmtNHsEnSFMJK6a1BTFSgh5dQA2ndjjhv/gMh71piUMNpYXBMSykto/oA
 E0dGOXiOq6hPxEWomCD6xVwQjr+JOaXfBkMkuIdivkbNFM3VyMDuCHzFAq2PPAuOyP
 BtdiIh3vIuhzHjVJuX7GVsiFCCqEMmDEN/X6yYkT/bG2Q6ZjjGXUK0sgSAT0pgoMfz
 jdD1cGgjLXB9L8basjGbhQ4hvu53nSpm1i3vJ6DRsXUw/ZmCQQRbTupU7i7/DSrgn+
 yp+HuQqDJ7x42Mldc+NA+ez/Qylw+q2wNxRxxuNKcot2DXEgpyEMx1j3kJhjNoBPaV
 5Ey1YskBfJNbw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=dYO2bMwg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Munzzyy1@proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=proton.me header.i=@proton.me header.b="dYO2bMwg"; 
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

Hi Qu,

> The ram_bytes described the decompressed size of a compressed extent,
> except inlined extents, the ram_bytes should always be fs block aligned.
>
> I didn't see how things can go "larger than the extent's ram_bytes".

You're right, and the commit message overstates it. For regular extents
ram_bytes is block aligned and matches the frame's content size, exactly as
you describe. The case that actually fails is the one you carved out:
compressed inline extents.

For the inline path, current mainline compresses the whole first block:

  run_delalloc_inline():
    cb =3D btrfs_compress_bio(inode, 0, blocksize, compress_type, ...);

so the page is zero-padded past EOF and the resulting zstd frame declares
frameContentSize =3D blocksize. But the extent item gets the unaligned size=
:

  __cow_file_range_inline(inode, i_size, compressed_size, ...) ->
    insert_inline_extent() -> btrfs_set_file_extent_ram_bytes(leaf, ei, siz=
e);

So a 1900-byte file stored as a compressed inline extent has ram_bytes 1900
while the frame decodes to 4096. The kernel side never notices because
fs/btrfs/zstd.c zstd_decompress() streams into out_buf and copies out at mo=
st
destlen. U-Boot's decompress_zstd() is the one-shot zstd_decompress_dctx(),
and btrfs_read_extent_inline() sizes the destination with
dsize =3D btrfs_file_extent_ram_bytes(), so the frame fails the whole-frame
capacity check with dstSize_tooSmall - error code 70, which matches the
"failed to decompress: 70" in the Armbian reports.

One data point from testing while chasing this: an image built with
mkfs.btrfs --rootdir --compress zstd (btrfs-progs 7.1) does NOT reproduce.
For a 1900-byte file, progs writes an inline extent with ram_bytes 1900 who=
se
frame also decodes to exactly 1900:

  item 8 key (257 EXTENT_DATA 0) itemoff 15316 itemsize 423
      generation 6 type 0 (inline)
      inline extent data size 402 ram_bytes 1900 compression 3 (zstd)

so mkfs-built images boot fine, and the failure only shows up on files
(re)written at runtime through the kernel - which fits the Armbian pattern =
of
/boot scripts and overlays breaking after a package update touched them.

I'll send a v2 with the commit message rewritten to name compressed inline
extents as the failing case instead of the hand-wave about sector padding. =
If
you'd like the on-disk evidence too, I can loop-mount a scratch fs with
compress=3Dzstd, write an unaligned file, and include the dump-tree output =
plus
the frame header read from the leaf in the v2 cover.

The fix itself stays in btrfs's decompress_zstd() rather than lib/zstd
because for FIT/ximg/ubifs an undersized destination really does mean corru=
pt
input; only btrfs hands the decompressor a destination smaller than the fra=
me
on purpose. If you'd rather see it shaped differently - say, only engaging
the bounce path for inline extents - happy to do that in v2 as well.

Thanks,
Cole

