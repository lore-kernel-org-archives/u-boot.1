Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D809AE92FD7
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 20:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7BD83F37;
	Mon, 29 Dec 2025 21:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="bBsykTef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9347083EA6; Mon, 29 Dec 2025 20:44:39 +0100 (CET)
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch
 [79.135.106.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2BB283EE3
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 20:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1767037477; x=1767296677;
 bh=Fms5gDVx/A6A75XBZvdWa2V6CGknQ2XuHwC02UspAO8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=bBsykTeflOQu8vYBk3ji1J90yeXwnbUxV/D8DX8hjLrsbPztLcT+BfS3t2LedEIzA
 qEoFSx75C7n6zmg8i3WezGeV8POwkuJWGESgXe/efsgMzVtmlj+qnavfoOC/fcBE7u
 Jp3nMPBRGHNqbdDb+eUPo0TgxfILBQ9TDGDGFRelSlQXAIWByfz8YhNVhgIoET2vwC
 NjrLFGkzIhQ/Fn824pp3lxCd8im8HJSCFqmRVRy4BHmkCDKvig5d3rQv0UfH0K8JuZ
 ZpgyivdEy6C4M3SKT4bAkD4Ofsbr+CxgNuFzPGXkKvXbx8cNAwJI/ZQVv4wDPbq+vi
 m3GQZI8n0qAAg==
Date: Mon, 29 Dec 2025 19:44:33 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH 3/4] fs: prevent integer overflow in sqfs_concat
Message-ID: <20251229194418.69780-4-t.preissl@proton.me>
In-Reply-To: <20251229194418.69780-1-t.preissl@proton.me>
References: <20251229194418.69780-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: 1d0809d0b7a7691d22fc58a4b40e213b16834fbb
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

An integer overflow in length calculation could lead to
under-allocation and buffer overcopy.

Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
---
 fs/squashfs/sqfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 4d3d83b7587..1dc63257fb9 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -254,11 +254,15 @@ static int sqfs_get_tokens_length(char **tokens, int =
count)
 static char *sqfs_concat_tokens(char **token_list, int token_count)
 {
 =09char *result;
-=09int i, length =3D 0, offset =3D 0;
+=09size_t i, length =3D 0, offset =3D 0;
+=09size_t alloc;
=20
 =09length =3D sqfs_get_tokens_length(token_list, token_count);
=20
-=09result =3D malloc(length + 1);
+=09if (__builtin_add_overflow(length, 1, &alloc))
+=09=09return 0;
+
+=09result =3D malloc(alloc);
 =09if (!result)
 =09=09return NULL;
=20
--=20
2.43.0


