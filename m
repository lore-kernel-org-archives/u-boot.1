Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CACDC55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 13:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCB7760748;
	Sun,  2 Aug 2026 13:27:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pZs--wh5QouP; Sun,  2 Aug 2026 13:27:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47FF6606E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785677270;
	bh=wpm3i8qtwCu7o6/4/dq71yDUSFjNwyAh7/bTp2v+G14=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=glAGkmktIEn6axddxmXNQI6R2DZkEQpy0v5dl2QHNAB5AaEZ9KwEJduaFZl4bQ7HC
	 bKuPJfcf5xe4BYViFPaZSmpPsj9Nfo04dBMKyettwBePG/A2y//P5Ahi/faEXaoiuO
	 BCdnbuaBJRay1rFGR86ZShr5R68PNhxdaTFpy8bu7GCBzmxGJ3l1Ie8NsZ0qwHm8Rq
	 BksUGzjHaHqGgv4UikvDtFQonGJa4HmFRO27ur30VeqpJCyolxUOCg7hD/3cf5ndxf
	 2DkWHd0bNk6waS322CYcbzODDXYQKCR00HqHlljBVZP12fAml/TSL1RHDq0rqO1pBM
	 6hBoXbeA2ntHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47FF6606E5;
	Sun,  2 Aug 2026 13:27:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0285A2CE
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD08840650
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 73R3Z0qn6Ex9 for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 09:35:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=munzzyy1@proton.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5A18E40635
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A18E40635
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A18E40635
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8AA80117; Sun,  2 Aug 2026 11:35:29 +0200 (CEST)
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0A4D805D7
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 11:35:27 +0200 (CEST)
Date: Sun, 02 Aug 2026 09:35:22 +0000
To: u-boot@lists.denx.de
From: Cole Munz <Munzzyy1@proton.me>
Cc: Alexey Charkov <alchark@flipper.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Marek Behun <kabel@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/3] fs: btrfs: release the path when btrfs_search_slot()
 fails
Message-ID: <029949953a54514c74303f9a2211e10b6ccb2f8f.1785660029.git.Munzzyy1@proton.me>
In-Reply-To: <cover.1785660029.git.Munzzyy1@proton.me>
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
 <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
 <7bcd492f-7e1e-4fd9-970d-857ca5460ddd@gmx.com>
 <hTFbDtB7gXE4tGU0EwriHsWY9lutwDK1ehYABepLafBuF5IDEY1rjTUVvCFq0HOsdgpfpFHvayOonotnzsuHWxs-FnRFFsnKUKmvGSkQAHI=@proton.me>
 <d95529ec-3da5-443b-8c05-776309f06ada@gmx.com>
 <cover.1785660029.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 28da5bef252b7d45cf1dc9af22f2f33ab02775f5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 02 Aug 2026 13:27:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=proton.me; 
 s=protonmail; t=1785663327; x=1785922527;
 bh=wpm3i8qtwCu7o6/4/dq71yDUSFjNwyAh7/bTp2v+G14=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=AUQ9OPlMAitJ5asr1uuGF0hsw++8i+r1c/xQ8Fb6rJU9gskwv75k2bvZ3KXT5mWQW
 pBQPTorVFfGVWfPfW/T6MefYUdAIAJ3wjiN4ImG9nLtspY2WSkhOJZ4+ik1J0DX2Eg
 H+wMY3Gq+sDjbmKZSp2hMTiLCy7aNry02obOKsURLw6zWOXGh8A7O2H6cY/x3Ja5JR
 WZ/K5sfsLSHqV6zeZUh7vUR0/esvm+i2MDgNDkPtInhvVawfRXtqdngSHfJ2Pnz3j1
 AvMVCbPpsEwaDQd3c8F4QPTYnF7PURXmjUt/y5TPUr51ikU6BmU2ws2Wk3hb0QSnRi
 Vh3Q0avwppS0g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=AUQ9OPlM
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Munzzyy1@proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=proton.me header.i=@proton.me header.b="AUQ9OPlM"; 
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

The U-Boot copy of btrfs_search_slot() returns on error with the nodes
it has descended through still attached to the path. The kernel one
releases the path on any error unless p->skip_release_on_error is set,
and callers written against that convention treat a failed search as
owning nothing. btrfs_size() is one: it returns straight away on a
search error and never reaches its btrfs_release_path() call, so the
attached extent buffer references leak.

Route both error exits through a release of the path. The error
returns of read_node_slot() carry no extra reference, so the path is
the only thing to clean up.

Suggested-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
 fs/btrfs/ctree.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8e932adc425d..48c50e556b16 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -425,8 +425,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans=
,
 =09=09level =3D btrfs_header_level(b);
 =09=09p->nodes[level] =3D b;
 =09=09ret =3D check_block(fs_info, p, level);
-=09=09if (ret)
-=09=09=09return -1;
+=09=09if (ret) {
+=09=09=09ret =3D -1;
+=09=09=09goto err;
+=09=09}
 =09=09ret =3D btrfs_bin_search(b, key, &slot);
 =09=09if (level !=3D 0) {
 =09=09=09if (ret && slot > 0)
@@ -461,8 +463,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans=
,
 =09=09=09=09break;
=20
 =09=09=09b =3D read_node_slot(fs_info, b, slot);
-=09=09=09if (!extent_buffer_uptodate(b))
-=09=09=09=09return -EIO;
+=09=09=09if (!extent_buffer_uptodate(b)) {
+=09=09=09=09ret =3D -EIO;
+=09=09=09=09goto err;
+=09=09=09}
 =09=09} else {
 =09=09=09p->slots[level] =3D slot;
 =09=09=09/*
@@ -479,6 +483,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans=
,
 =09=09}
 =09}
 =09return 1;
+
+err:
+=09btrfs_release_path(p);
+=09return ret;
 }
=20
 /*
--=20
2.55.0


