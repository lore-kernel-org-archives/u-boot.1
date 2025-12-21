Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F10E66886
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 14:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656F2840C3;
	Sun, 21 Dec 2025 15:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="ST78gvuE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921D883EE4; Sun, 21 Dec 2025 14:49:18 +0100 (CET)
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2640F83E69
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 14:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1766324955; x=1766584155;
 bh=fhu08+5wIkIOSwPztC5GyuV/+RvJHsl2Nyl0K85OdIY=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ST78gvuESNPbdwDDUPYjcnFyfpXaiEyVn6AjCigEPjIL20i9lQ88UnwQ3PiKxzKRv
 7jYmSeV5gj/4T4hYzJtoeNO5BqhFo2j/BSx0Znshipweeri2N0HszoTtG9Qm5Pd23I
 Q4vw/FpeC76TXANuAEs8VefVf7N/hQjAb9Xn4WMJKS3x+tHs5uUBV2veWimxQpWvgR
 OIFgMwFO7M3QeysOcnUYsCy1m9ycUcRJn+31RnGRP9Cpy4Jn4vu8h/TU8eCQ7In+8l
 8GWCJB4Y4sfeOE2Kdeo60M974NQb/KInBdK4ei7IprXDCa6hce64fFWXJX/6o2SEpq
 8jzKao062HFsw==
Date: Sun, 21 Dec 2025 13:49:09 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH] fs/zfs/zfs.c: prevent integer overflow in
 zfs_nvlist_lookup_nvlist
Message-ID: <20251221134818.1581786-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: e0eea3e61e7f2066fb1164bc21b248c87cc1fc16
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 21 Dec 2025 15:25:43 +0100
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

Prevent integer overflow when allocating memory for NVList data,
which could otherwise lead to heap corruption when parsing
malformed ZFS metadata.

Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
---
 fs/zfs/zfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 410a61aa611..ee47f222a57 100644
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
@@ -1627,7 +1628,13 @@ zfs_nvlist_lookup_nvlist(char *nvlist, char *name)
 =09 * nvlist to hold the encoding method, and two zero uint32's after the
 =09 * nvlist as the NULL terminator.
 =09 */
-=09ret =3D calloc(1, size + 3 * sizeof(uint32_t));
+
+
+=09if (__builtin_add_overflow(size, 3 * sizeof(uint32_t), &alloc))
+=09=09return 0;
+
+=09ret =3D calloc(1, alloc)
+
 =09if (!ret)
 =09=09return 0;
 =09memcpy(ret, nvlist, sizeof(uint32_t));
--=20
2.43.0


