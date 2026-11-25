Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1D606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d45np3Wl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O1l2+TQ3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DAA860725;
	Wed, 25 Nov 2026 15:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o8oNnDqI2I3C; Wed, 25 Nov 2026 15:45:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E6A560755
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795621521;
	b=nb5A7aOW6tbpYkpDBlrB4a4YX7FgQIWGSVnPb9UVEmTrVghoP6fzeQewq0a+l2+yUaf/
	 cdLmCrCqovQDZN7iN/8oD9k7ikHrNfLaT/RGUyNhKZ/aXWqlafa1q0gEHHVRPgdoT62ku
	 QY7JKN9fxyQJwR3UDzhEktIwNsqnjGEKKbNaW1Bv8BPR99kUQ0sUEPzQp0U2VCuEumH4S
	 hE6AA5lHfqok9v+5w7GyYL6lJcH95RcCwFM7/tkNQnFNRIVdwk5u8iN5eU0sSzaxrdEYQ
	 3hu5qClWBT2d46JSIXg7Kd/WQv1RdPd8to/FFUuPZYwsErS8byi5EKYTWQOFT08dS9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795621521;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/wgFsQ8VZzfnUKt55TQ4jfOIehlKTbCtB33ysIu8c3k=;
	b=VN32f0snJwI7iSp4PMnR+T6MbXYtgbEWM6z8IOOQWr3V5Z66wWOQgDuhux3SpjNO0xXx
	 fAB2T1Ezjo/oEIRc0dI56zumkZs/LS6z8e19eoaUSV+rFsoDdYV6vay0XJl8iK+cfSRFS
	 yVVgLczmigpANb8eHdp/UuYRGvyEZCsexmIlNFyjIP0tMXWHUrX8Ks03VN3qzqMx9+ulF
	 ZDsUbgFClashw8GZeWBdbbxyevDNbzYHPGkwytOKtEoHcpp9bw5MF5AaXdd41j002XE88
	 INaYi1h/OaI5mtx0fc0zj7jjGh3UtqKqFmyeFO1SuiMVZ3IPemLWtzZ/FU5G1Hfxszw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O1l2+TQ3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795621521;
	bh=/wgFsQ8VZzfnUKt55TQ4jfOIehlKTbCtB33ysIu8c3k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d45np3WlSCfS5HKR4sPU9gj/F08srADwBgXCrpzK/1nnHva2QDG/Olc7XIbTSQC1g
	 uhW9DrGChqgsZ1SdMnnNtONhJ2JGw5wIFtiruRl3gTT0LHBEy/k6OVaq00nvxdULjm
	 qIIJ13MrX4POFc0p0ebAEopq1/+qx8HSi4uG05WH5tYE4M9MXpqdaC/ioo8Ns8fWfO
	 AOpq8A5JN0EDiiS8dOl7ObEwvTGED6Md0OiMG4jpVCt5z8qLuvZFWuVPdK/cD2W4Up
	 LMnSIMDbbwZDLirw1VaGViay5WxlDek/TgM46uyEFpvQZff2vP1UssblAYRzfGVkrY
	 M689G/fhbaLQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E6A560755;
	Wed, 25 Nov 2026 15:45:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40CDA43
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32A4E60755
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oO2i0z_DtGKt for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 15:45:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 84AC460725
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:41d0:1004:224b::17"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::17; helo=mta0.migadu.com;
 envelope-from=bradley.morgan@linux.dev; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=O1l2+TQ3
Received: from mta0.migadu.com (out-23.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84AC460725
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:45:17 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=Aimq25gfVfgFiA8dFOiaOK/Gd0rXqrMjK4/YGHcF11w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795621515; v=1; x=1796226315;
 b=O1l2+TQ3WURtehs5MlOQame8NfM38+GKUzzwQt7xj57hg8S42nb8n3ZJOkUBXxPT230l+j/H
 ytg7zCrDyw49I2QJkJQB20H5biwhHI/lqQwyEv0s7DCd4fqAg/oEDOmp+xfkdOo3klqv7iNGnZo
 WukI6ikABMNndtsYlv9Ku540=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 3d909e1a88b2d1e6;
 Wed, 25 Nov 2026 15:45:14 +0000
X-Mizu-Trace-ID: 3d909e1a88b2d1e6
X-Migadu-Flow: FLOW_OUT
Date: Wed, 25 Nov 2026 15:45:12 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>,
 u-boot@lists.u-boot-project.org
CC: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-btrfs@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/6=5D_Avoid_64-bit_division?=
 =?US-ASCII?Q?s_that_need_=5F=5Fudivdi3=28=29_or_=5F=5Fumoddi3=28=29?=
In-Reply-To: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
Message-ID: <5D58F095-45B7-4BA0-A25E-2D65AF893947@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25 November 2026 12:42:53 GMT, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>U-Boot's private libgcc does not provide __udivdi3() and __umoddi3().
>v3 of the mpc85xx LTO series links mpc85xx LTO builds with it and added
>both routines [1]. Christophe Leroy asked why the callers do not avoid
>'/' and '%' on 64-bit operands instead, and Tom Rini asked to update
>the common code [2].
>
>Patches 1-4 avoid the divisions that make the mpc85xx LTO builds call
>__udivdi3() or __umoddi3(), in btrfs, squashfs, mmc_berase() and
>get_win_cnt() of the mpc8xxx PAMU code. They do not depend on each
>other. Patch 5 removes fs/btrfs/dev.c, which nothing uses and which
>holds another 64-bit modulo. Patch 6 converts the remaining divisions
>in btrfs. U-Boot never runs them, but builds without LTO still link the
>ones in the RAID5/6 code. My reply in that thread announced these
>conversions for v4 of the LTO series. They are sent on their own
>instead.
>
>Patch 2 and my big-endian fix for squashfs [3] conflict in
>sqfs_read_nest(). I will rebase whichever of them goes in second.
>
>Build tested with a buildman world build on a fork's CI, and sandbox
>test.py gives the same results as before. Run tested on qemu-ppce500
>(btrfs) and qemu_arm (btrfs, squashfs, mmc erase), and on a Turris 1.1
>with the mpc85xx LTO patches on top, which boots from an SD card and
>loads files from btrfs. The PAMU change is build tested only.
>
>[1]
>https://lore.kernel.org/u-boot/20261119133310.22732-5-pepe.schlehofer@gmail.com/
>[2] https://lore.kernel.org/u-boot/20261119200924.GB3176972@bill-the-cat/
>[3]
>https://lore.kernel.org/u-boot/20261125095537.37979-1-pepe.schlehofer@gmail.com/


Thanks,  after review, who will merge? Me? Or anyone else up to?

>
>Josef Schlehofer (6):
>  fs: btrfs: Avoid a 64-bit modulo in __btrfs_devread()
>  fs/squashfs: Avoid 64-bit divisions
>  mmc: Use div_u64() in mmc_berase()
>  powerpc: mpc8xxx: Avoid a 64-bit division in get_win_cnt()
>  fs: btrfs: Remove the unused dev.c
>  fs: btrfs: Avoid the remaining 64-bit divisions
>
> arch/powerpc/cpu/mpc8xxx/fsl_pamu.c |  2 +-
> drivers/mmc/mmc_write.c             |  2 +-
> fs/btrfs/Makefile                   |  2 +-
> fs/btrfs/compat.h                   |  8 ++------
> fs/btrfs/dev.c                      | 25 -------------------------
> fs/btrfs/volumes.c                  | 19 +++++++++++--------
> fs/btrfs/volumes.h                  |  9 +++++----
> fs/squashfs/sqfs.c                  | 21 +++++++++++----------
> fs/squashfs/sqfs_inode.c            |  5 +++--
> 9 files changed, 35 insertions(+), 58 deletions(-)
> delete mode 100644 fs/btrfs/dev.c
>
>
>base-commit: 79497816056122c49b3b135e14cbac59374e636c
>

--- Thanks!
