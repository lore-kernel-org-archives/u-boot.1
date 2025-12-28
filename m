Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA827E784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 21:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E89C83B97;
	Sun, 28 Dec 2025 22:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="CUf/zR9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D6083A57; Sun, 28 Dec 2025 17:45:43 +0100 (CET)
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CDCA83885
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 17:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1766940340; x=1767199540;
 bh=nlc2VCuaB0CuLfJ9/tR9+I5VNv53o92wkdrXSg4YwN4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=CUf/zR9npUzxZkQ6EvSH0K8TfH8cL3hDPJUE87qx88LsV1hTJ1bM1uraWS/0bVrfU
 DOMOw341wfSjhh2bqFFFOsioXdYtKypEnOLWHjJui2iOll/e3vP/mlkiqoIfaOGtjE
 ld7ZPn7tGikdFJQP9tBN8DLFhE4KO7drssW71/GwlGSWSGZPoTDKeYYnSSqtNtcu9i
 jGm384OsdlcK9x9Bj1jDPgWe+h0fs2ldOld3q2cjWu++U3XMdjx+Y/XowYEpH/Q9GG
 D/ZiDn7zpbPC+rjzCnIS1s1ODgbAGW/H9Qy1wwpRhRJ1GT21KlRcn7yMfU/X+afLkN
 +BlBv3wGYFydg==
Date: Sun, 28 Dec 2025 16:45:34 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH 4/4] fs: ext4: preventing integer overflow in
 ext4fs_get_bgdtable()
Message-ID: <20251228164500.313817-5-t.preissl@proton.me>
In-Reply-To: <20251228164500.313817-1-t.preissl@proton.me>
References: <20251228164500.313817-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: bd5effd3999b81434f536910c56f649aa03b675e
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
 fs/ext4/ext4_write.c | 7 ++++++-
 fs/fs.c              | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 5b290f0d80d..02cf9cf0cc3 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -108,7 +108,12 @@ int ext4fs_get_bgdtable(void)
 {
 =09int status;
 =09struct ext_filesystem *fs =3D get_fs();
-=09int gdsize_total =3D ROUND(fs->no_blkgrp * fs->gdsize, fs->blksz);
+=09size_t alloc;
+
+=09if (__builtin_mul_overflow(fs->no_blkgrp ,fs->gdsize, &alloc))
+=09=09return -1;
+
+=09size_t gdsize_total =3D ROUND(alloc, fs->blksz);
 =09fs->no_blk_pergdt =3D gdsize_total / fs->blksz;
=20
 =09/* allocate memory for gdtable */
diff --git a/fs/fs.c b/fs/fs.c
index efcf94caa1b..f22b75573b9 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -1071,7 +1071,7 @@ int do_mv(struct cmd_tbl *cmdtp, int flag, int argc, =
char *const argv[],
=20
 =09=09if (__builtin_add_overflow(dst_len, src_len, &total) ||
    =09=09=09__builtin_add_overflow(total, 2, &total)) {
-  =09  =09return 0;
+  =09  =09=09return 0;
 =09=09}
=20
 =09=09new_dst =3D calloc(1, total);
--=20
2.43.0


