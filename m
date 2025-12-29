Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BB7E92FD9
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 20:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A90C83F4D;
	Mon, 29 Dec 2025 21:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="IiTq7WKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC3AC83EA6; Mon, 29 Dec 2025 20:44:43 +0100 (CET)
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch
 [79.135.106.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21D283EF5
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 20:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1767037481; x=1767296681;
 bh=zu7/NbeXBxY5YFw9w3SXHKGJUQFxvf5pf7a3V4dXJjQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=IiTq7WKdLZcaWGAx43v9lYOZqOEVHaOR1eJ9uMq4J/+OfqFNSlFFpT/6prWYULwQm
 1SFydeembUnpeo0OekQ9DIQfuAOqVmwFoejePmFLN/8wY67TAh/e1Wtbane6g9lxb9
 q3liuJMznCLUfOdyh0Dpa1/hawWYGa1BwVjn8vp0G5rk/WOeIUA1RsGcfilZUZoeZH
 K0+Z10YCbIr24cb9KpDVUeP1nOzY7G+PE8nxzMBNlhfRySEWS6EQyJyK9HR2qG7HyP
 85BCMcvrD327xjEIlRUTTSiWUOtMVIoFTWfeu4XTPS52j44jD9U3Y4t1zfwVRQNWFJ
 QP7QwrMnIXNmg==
Date: Mon, 29 Dec 2025 19:44:36 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH 4/4] fs: prevent integer overflow in ext4fs_get_bgdtable
Message-ID: <20251229194418.69780-5-t.preissl@proton.me>
In-Reply-To: <20251229194418.69780-1-t.preissl@proton.me>
References: <20251229194418.69780-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: b6895ff2bb7e6b09a1e8cba852e7ecc3b2741315
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 29 Dec 2025 21:36:43 +0100
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

An integer overflow in gdsize_total calculation could lead
to under-allocation and heap buffer overflow.

Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
---
 fs/ext4/ext4_write.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 5b290f0d80d..b826a8807c5 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -108,7 +108,12 @@ int ext4fs_get_bgdtable(void)
 {
 =09int status;
 =09struct ext_filesystem *fs =3D get_fs();
-=09int gdsize_total =3D ROUND(fs->no_blkgrp * fs->gdsize, fs->blksz);
+=09size_t alloc;
+
+=09if (__builtin_mul_overflow(fs->no_blkgrp, fs->gdsize, &alloc))
+=09=09return -1;
+
+=09size_t gdsize_total =3D ROUND(alloc, fs->blksz);
 =09fs->no_blk_pergdt =3D gdsize_total / fs->blksz;
=20
 =09/* allocate memory for gdtable */
--=20
2.43.0


