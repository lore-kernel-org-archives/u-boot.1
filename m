Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DC9E784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 21:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A4083B71;
	Sun, 28 Dec 2025 22:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="BpduOPjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72EBD8392C; Sun, 28 Dec 2025 17:45:28 +0100 (CET)
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D866836D3
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 17:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=3yzg5vsyszc7xjnkes5yqh373e.protonmail; t=1766940325; x=1767199525;
 bh=U7r/eCm22ua0usuEy+r5AxV0iSFMH57WFn+uEwGqgSE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=BpduOPjFMec4IfKts2RHjHFlqAkKyvT8dHJ6vuh888OgN7eUq3ya+g8QLxVfYVx0B
 9Wh2hOvoXqcpWhLLcQCbRWi3KoKIwAPtMmaGqBV93CTjuUIoWgQlvv+mvGfef25lMi
 GCQ1Ex+Bj491neL/CtoONaLKfSrVVqxDXqbwsc8U5Ix5ytywpjUW7YImjh6XKkPXqq
 86JW8D5POsMZI9O2BGcEJIcygpUnw3lRfRcs2bPOgwm2/YrHmlVhuTLKTMHMDvI563
 gKOPNIFGV2fwZN846kb6186oxh3wQNOLVPRFz7uH7yFBIYrEB32IphDKVv1pAJbhGx
 sfL8UsEziZ8Xw==
Date: Sun, 28 Dec 2025 16:45:20 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH 2/4] fs: zfs: prevent integer overflow in
 zfs_nvlist_lookup_nvlist()
Message-ID: <20251228164500.313817-3-t.preissl@proton.me>
In-Reply-To: <20251228164500.313817-1-t.preissl@proton.me>
References: <20251228164500.313817-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: cf45cf46f3f9fd7d81a51648287c327861c1e242
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
 fs/zfs/zfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 410a61aa611..aa6673ea75e 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -1627,9 +1627,12 @@ zfs_nvlist_lookup_nvlist(char *nvlist, char *name)
 =09 * nvlist to hold the encoding method, and two zero uint32's after the
 =09 * nvlist as the NULL terminator.
 =09 */
-=09ret =3D calloc(1, size + 3 * sizeof(uint32_t));
-=09if (!ret)
-=09=09return 0;
+=09if (__builtin_add_overflow(size, 3 * sizeof(uint32_t), &alloc))
+        return 0;
+
+    ret =3D calloc(1, alloc);
+    if (!ret)
+        return 0;
 =09memcpy(ret, nvlist, sizeof(uint32_t));
=20
 =09memcpy(ret + sizeof(uint32_t), nvpair, size);
--=20
2.43.0


