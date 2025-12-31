Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CB4EE642F
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 13:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B656F84071;
	Wed, 31 Dec 2025 14:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="K/NYKFab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094528401F; Wed, 31 Dec 2025 11:08:55 +0100 (CET)
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C2BF83F36
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1767175732; x=1767434932;
 bh=bhqZCajeYwyuiUv/RvSL8RsYb4fYLbCI8O0x0PeWSo8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=K/NYKFabyc/D12EOECrc3TWuy0BXsIFoT8QpFYcSQP5h1U8uaLLO749/y0hsYH8T3
 wK6dwcSWa013wMPkn8i/Tcwk5lRQBr4j6u4vXI7kxTKM64d0QSBu7P/6ueWL0Useq9
 0ienmj40urCsM38ezZWlnvCqqUa5oXKzjptay78QcYyruKDlXV9cNLa+cbobhSmFVN
 G0mmud3liRajmZ561pz/wlpvwVJouazv1aX6sDRToDyFO/poooCCXgRuB0xA9mwDtz
 uUi6f2M0q2P3Zag8TVQO+kf9mszeLbsq2PH1GJFwaVDw3nN81iN3HJ1SQNF7ZiRzsZ
 NF60CArXwMSSQ==
Date: Wed, 31 Dec 2025 10:08:48 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH v2 1/4] fs: prevent integer overflow in fs.c do_mv
Message-ID: <20251231100831.119142-2-t.preissl@proton.me>
In-Reply-To: <20251231100831.119142-1-t.preissl@proton.me>
References: <20251231100831.119142-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: 0d7a0ebd05a3a0d401ff7db904ffe2e606dbf2d1
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

An integer overflow in size calculations could lead to
under-allocation and potential heap buffer overflow.

Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
---
 fs/fs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index c7706d9af85..319c55c440a 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -1059,15 +1059,25 @@ int do_mv(struct cmd_tbl *cmdtp, int flag, int argc=
, char *const argv[],
 =09 */
 =09if (dirs) {
 =09=09char *src_name =3D strrchr(src, '/');
-=09=09int dst_len;
=20
 =09=09if (src_name)
 =09=09=09src_name +=3D 1;
 =09=09else
 =09=09=09src_name =3D src;
=20
-=09=09dst_len =3D strlen(dst);
-=09=09new_dst =3D calloc(1, dst_len + strlen(src_name) + 2);
+=09=09size_t dst_len =3D strlen(dst);
+=09=09size_t src_len =3D strlen(src_name);
+=09=09size_t total;
+
+=09=09if (__builtin_add_overflow(dst_len, src_len, &total) ||
+=09=09    __builtin_add_overflow(total, 2, &total)) {
+=09=09=09return 0;
+=09=09}
+
+=09=09new_dst =3D calloc(1, total);
+=09=09if (!new_dst)
+=09=09=09return 0;
+
 =09=09strcpy(new_dst, dst);
=20
 =09=09/* If there is already a trailing slash, don't add another */
--=20
2.43.0


