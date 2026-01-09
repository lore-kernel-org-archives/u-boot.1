Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEB3D1A61B
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 13:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACABB8437E;
	Fri,  9 Jan 2026 14:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="LAn2t1Ao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9640584166; Fri,  9 Jan 2026 12:25:16 +0100 (CET)
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch
 [185.70.43.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A7C83CB1
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:25:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1767957912; x=1768217112;
 bh=XihP2wkvG0XlPHH8YZXz4xsGxsvO2xUlgVWKBa2DDdc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LAn2t1Aoa51zA0AvmS9kfS49a3C1OB8FEuqZad3Q8I7sJ4cLxqnRjqeZlpriUpXFy
 V8syc/3gYcXMZ2mwsJxOuHm2+4MOWjuG6Yiz7IKB3uzlEHTRlfF20bpDrY4K9F6Nts
 d95UvskxaQgSzYL3zOcmPzC8pvSLjrZ2RC0RGQr/MXB4Ux8/4gf43f82P7Op6gPzGH
 aTBjCRMIJ/fNR8NMHSGybznYd0gz+MDlcq4SbHHfli+HD44y7A3W1ZwNLYoFITyUgy
 xN83c5Mo1nEbX2Dlbs8plphZpGGrLy0yfBeEKBfs0wH4VlT8/9bLrXBEGH9hXWjN2L
 nXi2Ph7aopp5A==
Date: Fri, 09 Jan 2026 11:25:07 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>,
 Simon Glass <simon.glass@canonical.com>
Subject: [PATCH v3 4/4] fs: prevent integer overflow in ext4fs_get_bgdtable
Message-ID: <20260109112428.262793-5-t.preissl@proton.me>
In-Reply-To: <20260109112428.262793-1-t.preissl@proton.me>
References: <20260109112428.262793-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: 5f8bc89ec270a9e319d507b4cea51fb3a295617d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 09 Jan 2026 14:07:59 +0100
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
Reviewed-by: Simon Glass <simon.glass@canonical.com>
---
 fs/ext4/ext4_write.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 5b290f0d80d..1483e9955c0 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -108,7 +108,13 @@ int ext4fs_get_bgdtable(void)
 {
 =09int status;
 =09struct ext_filesystem *fs =3D get_fs();
-=09int gdsize_total =3D ROUND(fs->no_blkgrp * fs->gdsize, fs->blksz);
+=09size_t alloc;
+=09size_t gdsize_total;
+
+=09if (__builtin_mul_overflow(fs->no_blkgrp, fs->gdsize, &alloc))
+=09=09return -1;
+
+=09gdsize_total =3D ROUND(alloc, fs->blksz);
 =09fs->no_blk_pergdt =3D gdsize_total / fs->blksz;
=20
 =09/* allocate memory for gdtable */
--=20
2.43.0


