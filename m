Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CEFE92FD7
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 20:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8200E83F2E;
	Mon, 29 Dec 2025 21:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="FK8l+Kzv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3828283F01; Mon, 29 Dec 2025 20:44:38 +0100 (CET)
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch
 [185.70.43.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3279883EF9
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 20:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=qotweefh7fe3rawhjtpkdpaoui.protonmail; t=1767037475; x=1767296675;
 bh=3Mdnlnlx9smVlETvC/5wWn90n9OpIxzJjcTdw2O0U/c=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FK8l+KzvmHq+n4LfUcHWlrX7SD/YkF0maIN0Nzyyw28FJ0u38Prt+CUI6WfSzhNdU
 US1hpSwjGokumV0s/U/Ea8R6NilZEqneDeQ4Gdu92BWzugo8H+hyXrfrjdtymlUA2k
 L+wZ/SQyzAVntR2ITaBOVa1FPWiKfw9xr8CgdC/bo7b6dzOQbJffNTDI3QMBJVArw0
 JyCB4xWPO2fiSADoNIke1kzGQP60xn0qJJmkLu3JM3//mZA6Xi+HgfY3id8eapy5vE
 0ull9r17AizwPsstMvLuVGk4d2nFGEzqi14bCC6novLbkllfBAwv6qWnywagE/P5RM
 1LMxzzs+kfMqw==
Date: Mon, 29 Dec 2025 19:44:31 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH 2/4] fs: prevent integer overflow in zfs_nvlist_lookup
Message-ID: <20251229194418.69780-3-t.preissl@proton.me>
In-Reply-To: <20251229194418.69780-1-t.preissl@proton.me>
References: <20251229194418.69780-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: 2645732f806b95a99624ec3fad18c3009115ca76
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


