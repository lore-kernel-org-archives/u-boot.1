Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C91EE6432
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 13:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD158407F;
	Wed, 31 Dec 2025 14:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="K0jCODSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E2368401F; Wed, 31 Dec 2025 11:09:00 +0100 (CET)
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56EA483F36
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1767175737; x=1767434937;
 bh=3Mdnlnlx9smVlETvC/5wWn90n9OpIxzJjcTdw2O0U/c=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=K0jCODSyXJwn++ru32Qio8gdkl7X+DizwW5TGma9UkCbxDG8jIfd4zNAJaAhz9qNc
 QosUoxVpl2l+A5KOTUv4bnttaIEfLBiDnnHQS4aPVwmNRKqr/dMdp79zcZaZ8gDugL
 kb+F2uqJKFGfqJ2Drs/5g3Gdj2KZJYRzwiT4Dpdb/b12Zm7RhHRu2BQnfXL5I64i9u
 Z8c/AViWhln48eow2z1ShJ8/3PH6Ts5FVP2J2vM/PLOI1Z+e3w8a8rHxGlOiB026sX
 KsVcvN1XE4ass7R1kzq30RqOdhD7+z8wi3SRIQqWsbkpx1NnUOEnSYbuWDq/2lrODd
 BR7cF/En9xQGg==
Date: Wed, 31 Dec 2025 10:08:55 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH v2 2/4] fs: prevent integer overflow in zfs_nvlist_lookup
Message-ID: <20251231100831.119142-3-t.preissl@proton.me>
In-Reply-To: <20251231100831.119142-1-t.preissl@proton.me>
References: <20251231100831.119142-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: 166f62bc51e977cbcb38d968708e8fd6a4fe1639
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 31 Dec 2025 14:17:47 +0100
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

An integer overflow in nvlist size calculation could lead
to under-allocation and heap buffer overflow.

Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
---
 fs/zfs/zfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 410a61aa611..624f4e48cc8 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -1627,7 +1627,10 @@ zfs_nvlist_lookup_nvlist(char *nvlist, char *name)
 =09 * nvlist to hold the encoding method, and two zero uint32's after the
 =09 * nvlist as the NULL terminator.
 =09 */
-=09ret =3D calloc(1, size + 3 * sizeof(uint32_t));
+=09if (__builtin_add_overflow(size, 3 * sizeof(uint32_t), &alloc))
+=09=09return 0;
+
+=09ret =3D calloc(1, alloc);
 =09if (!ret)
 =09=09return 0;
 =09memcpy(ret, nvlist, sizeof(uint32_t));
--=20
2.43.0


