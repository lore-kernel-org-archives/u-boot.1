Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E1BC61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 10:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E0EF80F36;
	Wed,  2 Sep 2026 10:32:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIZSVIlrAjaw; Wed,  2 Sep 2026 10:32:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788345120;
	bh=Y5knPBndHCtxwGoOg3uPg9SKCG/tyNKf5AwtIVyfaAk=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o1xFzYmRmjKVafn13hfh7zSS8tNiqGnFqdpWcFplgtAVsQZiw5ViEy7JIoS+meySh
	 8X6wuhYLYIKgkNr9oh112PC88Di2KAj0zcuGAaZ5Wioa0KslTqdbwkRv8Jf6+E6l9O
	 PFJcmufbrW219L+UzN7gk5BXhGWKOx1oKPYCyi9tnzfFbfbDwImgQy0N6xDG5DFvpe
	 9+N6X3qkHBVbEYSlR0aywnmyRlH1b0uneFMKD+DeidT6IWoP4p95mUlct7CGxt2j3Z
	 2MdUTszWwClnsIDyA2cnBxcrX0PSII6ywbftLDdf11b1MxLAeAF9xsAkc2sX/fgB8f
	 PmvgyYhTPredA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53A5680742;
	Wed,  2 Sep 2026 10:32:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E862B2FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFBF140807
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:39:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qiYQ3luIXGHF for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:39:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.116;
 helo=mail-244116.protonmail.ch; envelope-from=mcpratt@pm.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256
 header.s=protonmail3 header.b=rrvyzIJK
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch
 [109.224.244.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF6B840802
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1788338347; x=1788597547;
 bh=Y5knPBndHCtxwGoOg3uPg9SKCG/tyNKf5AwtIVyfaAk=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=rrvyzIJKa4DFQ4sV/41+qRahRpUoPUY3wrmVMixRq3qcSRzDEj6vNWnI1kAEJZKra
 p02lKZ4/RhNhChlq/0lI+cYwdFnxPA0XHPFV11YRcs28jPKz+WwWPzyFj23PazrpKv
 Pm0OX4u+aut4FIpnu+1ie70MdKh43wd3ebanfETqCOe0vYhttXZ1lt0v+TmUAKWgU0
 rrk05nsPq7II5Sd5jkBvB8GCK/pw9IhihGFFRM9rAaZEIa8fTiY+hxWnZrTrCLg8Zc
 R3GTPde46lCnihngh0awAF1xFiCJMWbBxhUmJrIZCCrscm/hm/7Fqqnx5mszR1avHi
 AuFQBItZYoZVQ==
Date: Wed, 02 Sep 2026 08:38:59 +0000
To: u-boot@lists.u-boot-project.org
From: "Michael C. Pratt" <mcpratt@pm.me>
Cc: "Michael C. Pratt" <mcpratt@pm.me>, Tom Rini <trini@konsulko.com>,
 =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] fw_env: use env-size property for nvmem layout device
 detection
Message-ID: <20260902083839.22154-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: a7b78524b62e1d5f4042de6eb02de2d9ad79a0eb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 02 Sep 2026 10:31:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Since Linux commit 5b2f8c133d98 ("nvmem: layouts: u-boot-env:
add optional "env-size" property"), there is support for providing the size
of the u-boot environment used by the bootloader to the layout NVMEM driver
in order to calculate the CRC if the range is less than the partition size
in a similar fashion that it would be provided in a fw_env.config file.

The value is stored in binary in the same endianness as the system,
so no endianness translation is necessary, simply copy to a new variable.

Reuse the buffer that holds the path for opening the compatible sysfs file
for parsing this env-size property, and possibly more in the future,
as soon as the correct device is identified with the compatible property.

Signed-off-by: Michael C. Pratt <mcpratt@pm.me>
---
 tools/env/fw_env.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index 8810b0e94dc..c6ac91cd80c 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -1714,6 +1714,7 @@ static int find_nvmem_device(void)
 =09char comp[256];
 =09char buf[32];
 =09int bytes;
+=09ulong layout_size =3D 0;
 =09DIR *dir;
=20
 =09dir =3D opendir(path);
@@ -1775,10 +1776,14 @@ next:
 =09=09fclose(fp);
 =09}
=20
+=09/* Remember the nvmem device path for parsing other properties. */
+=09bytes =3D snprintf(comp, sizeof(comp), "%s/%s", path, dent->d_name);
 =09closedir(dir);
=20
 =09if (nvmem) {
 =09=09struct stat s;
+=09=09FILE *fp;
+=09=09size_t size;
=20
 =09=09stat(nvmem, &s);
=20
@@ -1786,6 +1791,20 @@ next:
 =09=09DEVOFFSET(0) =3D 0;
 =09=09ENVSIZE(0) =3D s.st_size;
=20
+=09=09if (bytes > 0 && bytes !=3D sizeof(comp)) {
+=09=09=09strcat(comp, "/of_node/nvmem-layout/env-size");
+=09=09=09fp =3D fopen(comp, "rb");
+=09=09=09if (fp) {
+=09=09=09=09fstat(fileno(fp), &s);
+=09=09=09=09size =3D fread(&layout_size, s.st_size, 1, fp);
+=09=09=09=09if (size =3D=3D 1)
+=09=09=09=09=09ENVSIZE(0) =3D layout_size;
+=09=09=09=09fclose(fp);
+=09=09=09}
+
+=09=09=09comp[bytes] =3D '\0';
+=09=09}
+
 =09=09return 0;
 =09}
=20
--=20
2.30.2


