Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16065E784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 21:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9022683B4E;
	Sun, 28 Dec 2025 22:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="U9EaJFbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27647836D3; Sun, 28 Dec 2025 17:45:20 +0100 (CET)
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch
 [79.135.106.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490C883885
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 17:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1766940317; x=1767199517;
 bh=TBt9Jl6a58LdaL/okwbBVv2J26OXvx2FHUn27SWeNc4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=U9EaJFbOc6IUDZnW/hpXQdYZMy4kVVHRoXFrrGEg4if5nU6U2TKWP9ucdh6l9paiw
 V0/dSpMkqwxHGs+dPJKHno4McvwNkvtUnRE3nIHlR6DbTBB8m52ebp+P1EAKB9t7XK
 2M47HcieuWPtYiAYcVXZqY3SUBl3oeRflTsk0/34o8+98tFYoa36YFUl5Tu7dYA2iY
 SEtwLPPN7eDZuwIIxo4RP7WhP2S+rde0ccO838ONB5H2t3wAhopLfSyWe0CCWAHgS3
 7JxdrgvIj8jm2b+STA9+JqCW+JtamR+5bWeygEiajZxZjrtDa4z11L7ONbSzdYPlbF
 KcApCQ7jk/5fA==
Date: Sun, 28 Dec 2025 16:45:13 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH 1/4] fs: prevent integer overflow in fs.c do_mv()
Message-ID: <20251228164500.313817-2-t.preissl@proton.me>
In-Reply-To: <20251228164500.313817-1-t.preissl@proton.me>
References: <20251228164500.313817-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: b54347d13983de78e85e324bc5fbf56ae1ee80a6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 28 Dec 2025 22:40:09 +0100
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

Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
---
 fs/fs.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index c7706d9af85..efcf94caa1b 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -1059,15 +1059,25 @@ int do_mv(struct cmd_tbl *cmdtp, int flag, int argc=
, char *const argv[],
 =09 */
 =09if (dirs) {
 =09=09char *src_name =3D strrchr(src, '/');
-=09=09int dst_len;
-
+=09
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
+   =09=09=09__builtin_add_overflow(total, 2, &total)) {
+  =09  =09return 0;
+=09=09}
+
+=09=09new_dst =3D calloc(1, total);
+=09=09if (!new_dst) {
+    =09=09return 0;
+=09=09}
 =09=09strcpy(new_dst, dst);
=20
 =09=09/* If there is already a trailing slash, don't add another */
--=20
2.43.0


