Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA59D3B7E5
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 21:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AEAF83B87;
	Sun, 28 Dec 2025 22:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="bqwey98m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9131F8392C; Sun, 28 Dec 2025 17:45:36 +0100 (CET)
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch
 [79.135.106.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2398836D3
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 17:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1766940332; x=1767199532;
 bh=kBS+89FlTcZI5Vz9awRwBD8FvprZfk02jgNyRfvs0Mo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=bqwey98m9T5Okiy3g9oH4A4RVrmRqRRF/RtmAX93SM7EimTMrrCKwbN25JPMxpnTr
 g61narZu3f8MJVCrf07cPbL0fl4RbuXp3okq2CgUqbsaumTt81BBjSvGP0ZCL26AXk
 /q0SQOmoo9px3EmWqus/IElsjOFFzIWPa8YxKl9gQalJ5IOCa14aeuNCTJs1kAVpZ1
 PUQBtJP2Bd0sBdRmxk/Dfvt41iQNkhfbKtmqtOfnJO/dnQdu4DW5sB0c5wO2KRQY50
 lRMjJv/tst4M6DQDoyBGW5f02JdhFbYd9Bxy65QN98WBW62483zmRXKWANHKkOnvcs
 WQZKyxAB6Dm1Q==
Date: Sun, 28 Dec 2025 16:45:27 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH 3/4] fs: squashfs: prevent integer overflow in
 sqfs_concat_tokens()
Message-ID: <20251228164500.313817-4-t.preissl@proton.me>
In-Reply-To: <20251228164500.313817-1-t.preissl@proton.me>
References: <20251228164500.313817-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: fcf2079c164e5945726bfbf4a3e14c6deae34137
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
 fs/squashfs/sqfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 4d3d83b7587..e6a3e0fa9f2 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -254,11 +254,16 @@ static int sqfs_get_tokens_length(char **tokens, int =
count)
 static char *sqfs_concat_tokens(char **token_list, int token_count)
 {
 =09char *result;
-=09int i, length =3D 0, offset =3D 0;
+=09size_t i, length =3D 0, offset =3D 0;
+=09size_t alloc;
=20
 =09length =3D sqfs_get_tokens_length(token_list, token_count);
+=09
+=09if (__builtin_add_overflow(length, 1 , &alloc))
+        return 0;
=20
-=09result =3D malloc(length + 1);
+
+=09result =3D malloc(alloc);
 =09if (!result)
 =09=09return NULL;
=20
--=20
2.43.0


