Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63453C55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 13:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A848160688;
	Sun,  2 Aug 2026 13:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FNI8sW_9FZM7; Sun,  2 Aug 2026 13:27:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 451C5606C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785677266;
	bh=Uw5vADoxt00Q/MX8WufiOyFzbjySXLXWveX0Ge32eM8=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yQ/tcQPUAoGybclQW4UlH3kVimyWXIW7o5VNuJnwaRRI3mygdgkvxRzTdwZV9k2X8
	 dpdPHY3RfDHuCntlqHgtWT/qAY53eoicUe/wqBh/Im56LyBUCEWCmFRRhxRsJEEK4Q
	 /XPIq6JuB9xOR/W4LjeeNPJqW0qJBqfiz4zNy25xpU408YYvcj65OR2p8YwnZJf1pB
	 ftbUgAYWzvOaiWfzKZv7x8KLqZmUQsBR4Kfl2RlIsF2upVZqNxQcNNb5byqaQp9k+u
	 HjN6RLqDB9Ol8PiQ5egluhPV9gFs2a+AMAEG11CpL+W3NQygVk6+TsuzTEt01ArUOw
	 RtRR2IZazfFnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 451C5606C1;
	Sun,  2 Aug 2026 13:27:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B723D350
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9884405CE
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvRlpsy4HFIj for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 09:35:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=munzzyy1@proton.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2E1484061E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E1484061E
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E1484061E
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8367F84671; Sun,  2 Aug 2026 11:35:24 +0200 (CEST)
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE7780117
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 11:35:22 +0200 (CEST)
Date: Sun, 02 Aug 2026 09:35:16 +0000
To: u-boot@lists.denx.de
From: Cole Munz <Munzzyy1@proton.me>
Cc: Alexey Charkov <alchark@flipper.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Marek Behun <kabel@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/3] fs: btrfs: report file sizes from readdir
Message-ID: <cover.1785660029.git.Munzzyy1@proton.me>
In-Reply-To: <d95529ec-3da5-443b-8c05-776309f06ada@gmx.com>
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
 <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
 <7bcd492f-7e1e-4fd9-970d-857ca5460ddd@gmx.com>
 <hTFbDtB7gXE4tGU0EwriHsWY9lutwDK1ehYABepLafBuF5IDEY1rjTUVvCFq0HOsdgpfpFHvayOonotnzsuHWxs-FnRFFsnKUKmvGSkQAHI=@proton.me>
 <d95529ec-3da5-443b-8c05-776309f06ada@gmx.com>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: e5705b2609cfde47c0e9bdc305c582400e3fb011
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 02 Aug 2026 13:27:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=proton.me; 
 s=zukvd5xdjndjldmzkxrfzlnn4i.protonmail; t=1785663320; x=1785922520;
 bh=Uw5vADoxt00Q/MX8WufiOyFzbjySXLXWveX0Ge32eM8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=aakeoy+z/UnwL4UCfTLJFzgxf4NDZ4ErWwdzlCWzg3/p49D2T7wxUhux+iF/6TI2R
 v3B/aEWMz9MbCgXDp4QhQAHPeAYZj4ngy4D5InSQ9+CpGM+ne4tpxI8Xu6fUSdFeES
 dvozvcY5P6aglp7CYENkUg3ThgnPqonrhPZ06FQh7uEzX6VsMnURIi85f1mX3AMPzf
 tr2UHr9uOhpQ+MD7ZZprHiEX0aIf5/g341B/jiWDWvv7Q2cLFVZ9HeE1h9Pf8CxgKG
 mH4lTih/SBN/jPr7gnblk3wTRhHvGbw+hCJfW0wu+coOlju/xghobSsuCiUqqnB9z2
 GeMl55EYwu63Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=zukvd5xdjndjldmzkxrfzlnn4i.protonmail header.b=aakeoy+z
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Munzzyy1@proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=proton.me header.i=@proton.me header.b="aakeoy+z"; 
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

As agreed on the v1 thread, the fix and the cleanups are now separate
patches:

- patch 1 is the fix in the v1 shape
- patch 2 makes btrfs_search_slot() release the path on error like
  the kernel version does. That is where the btrfs_size() leak came
  from. Suggested by Qu.
- patch 3 is the dedup Alexey asked about. One helper shared by
  btrfs_readdir() and btrfs_size().

The pending btrfs test suite still passes on top of the readdir
series: 5 passed.

Changes in v3: split the fix from the cleanups. The release moved
into btrfs_search_slot() itself.
Changes in v2: helper shared with btrfs_size() plus the leak fix in
one patch.

Cole Munz (3):
  fs: btrfs: report file sizes from readdir
  fs: btrfs: release the path when btrfs_search_slot() fails
  fs: btrfs: deduplicate the inode size lookup

 fs/btrfs/btrfs.c    | 77 +++++++++++++++++++++++++++++++--------------
 fs/btrfs/ctree.c    | 16 +++++++---
 fs/btrfs/ctree.h    |  3 +-
 fs/btrfs/dir-item.c |  7 ++++-
 4 files changed, 74 insertions(+), 29 deletions(-)

--=20
2.55.0


