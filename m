Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614DAD1A618
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 13:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D727D84366;
	Fri,  9 Jan 2026 14:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="SJBNQ+59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4742384166; Fri,  9 Jan 2026 12:24:51 +0100 (CET)
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch
 [79.135.106.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C38083CB1
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=texnhysh7ndkhfy4b7vozvcdwe.protonmail; t=1767957888; x=1768217088;
 bh=aSm8Gh0y8RGQuHoqB95MIV2XrxCBc3nzQouvfDddMGU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=SJBNQ+5985zrNy7v4k0siVjjm5AFQL3/ksvx8IbczGiEJvRbIgU6j9z9gq2GLOfc0
 /HtYg269PQVd0+bEy7W7/46cDvxotTtHCtfobcusC4+Ehlp6TkMW7u55QB34Y+dJEZ
 fZzorHSuh1T1PA8hc4qtZizriF4ZFJlwOv0BQeV8Ea2l8rojdZnYbKHldOhXWae76d
 D+S5ABr9O2qyXlYALKNUTCpU9RlLZ10yzUPXLbRwzbHOwIut+11lvDldLMZaVfLqaE
 VBfPcxOj8/7Pl7e+sLnBEMz55kNtp4hRKJDur4CUlo2J6iGVJxKrJay3zuMkAfD7gu
 cX9rvhxytLY2g==
Date: Fri, 09 Jan 2026 11:24:45 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>,
 Simon Glass <simon.glass@canonical.com>
Subject: [PATCH v3 1/4] fs: prevent integer overflow in fs.c do_mv
Message-ID: <20260109112428.262793-2-t.preissl@proton.me>
In-Reply-To: <20260109112428.262793-1-t.preissl@proton.me>
References: <20260109112428.262793-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: 83a310dbb325aed43d54264faa54934d3c681280
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

An integer overflow in size calculations could lead to
under-allocation and potential heap buffer overflow.

Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
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


