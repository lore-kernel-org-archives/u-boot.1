Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87478D1A61A
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 13:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D64684371;
	Fri,  9 Jan 2026 14:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="L8Z21j/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10D184166; Fri,  9 Jan 2026 12:24:58 +0100 (CET)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A3283CB1
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1767957896; x=1768217096;
 bh=oWNxAyBGqOPIDb9QmbBvoU49Rza+CLerLegGJKBtLa0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=L8Z21j/Fuq74t4lARH+xTCZ8zmtl601e37MDVN1hDURwRSLEi95Zg5dtaLtDcjUCf
 hQTv0GjEs5jdFxovQvkB4GtDtKOIxVq7a4AODhPThaBLt+JLNTZAc30XNDBvXyURxN
 pTYQabvxOPb621jjx+cj5JFjpBbrofBjN2aKgMZl+jFZZKp1XBYOMd+TaJo/Zf6nB9
 LoEgCApZx1pq2rT8CsSzFGp4Q75SJGGvOTnZAtPawdX6bQKstFxseeElIr7eolezk2
 zf+H6H6pykN5mYHWqY4hy0WUFAe2qj1rWXJWJvlwt0eXo4W+0Yny1mDFNxGRBG5cA0
 ik03uyY5uXHsw==
Date: Fri, 09 Jan 2026 11:24:51 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH v3 2/4] fs: prevent integer overflow in zfs_nvlist_lookup
Message-ID: <20260109112428.262793-3-t.preissl@proton.me>
In-Reply-To: <20260109112428.262793-1-t.preissl@proton.me>
References: <20260109112428.262793-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: 0d110c9ddf43a100a14d490fd2b4ecffaf51305f
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

An integer overflow in nvlist size calculation could lead
to under-allocation and heap buffer overflow.

Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
---
 fs/zfs/zfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 410a61aa611..c7502c344ff 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -1617,6 +1617,7 @@ zfs_nvlist_lookup_nvlist(char *nvlist, char *name)
 =09char *ret;
 =09size_t size;
 =09int found;
+=09size_t alloc;
=20
 =09found =3D nvlist_find_value(nvlist, name, DATA_TYPE_NVLIST, &nvpair,
 =09=09=09=09=09=09=09  &size, 0);
@@ -1627,7 +1628,10 @@ zfs_nvlist_lookup_nvlist(char *nvlist, char *name)
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


