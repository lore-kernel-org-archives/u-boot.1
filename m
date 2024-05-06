Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61CEC25B4F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 15:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8AF088691;
	Mon,  6 May 2024 17:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="piluObOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0D588657; Mon,  6 May 2024 17:18:05 +0200 (CEST)
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch
 [185.70.40.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DEF58801F
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 17:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmoo_dv@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1715008682; x=1715267882;
 bh=4nEbUZBXVPTd8AAqezBkwIBeCU/Sm6SYRNskAKhTdPk=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=piluObOHBg+C4w/xTyI4ZOEfmVXqthZpEhU/DHkXaKhXHIzFmoOw41djlaoFCwS7W
 7kSYIc4GprIoI8i/7fBFAp9e85hrzBL5Y3CCTWJUnsIEc5r255H+gIhBb6i2GhzxlM
 NbNRjErmldgovUr7as0e9Rb6uHUbRzCqgDgkIXfpDJqRHM5JHidObxDhg8mjyzIwqq
 MFft0g/qgNxBDJvx+itoIGDbXYZj4faLik6Q/E5fqQO0a3hi9+sfmZ7fPE7ODzjSDJ
 sFbqBPSaL5p1wboP/zmzBP9urP4c0L5avkJOcoyhJ6ay73zy20VP8wwJR+X1SOQHy9
 n1mOmhkXI7vqg==
Date: Mon, 06 May 2024 15:17:57 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: H Bell <dmoo_dv@protonmail.com>
Subject: [PATCH] board: starfive: support Pine64 Star64 board
Message-ID: <9UKxZxvyW2p7WWu5KwPIVoiFveSPOTEAzCVemUccLIb70r8QO7ch2PAiwVf428TC-7K9HDSO26ShohI0gnI4C671Plwa0M1CuwclJt3xJEc=@protonmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: 16137cb5631239e91d3fe09feeb3fc63fcfe1ad7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 06 May 2024 17:22:47 +0200
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

Similar to the Milk-V Mars, The Star64 board contains few differences to th=
e
VisionFive 2 boards, so can be part of the same U-boot build.

Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
Cc: ycliang@andestech.com
Cc: heinrich.schuchardt@canonical.com
---
 board/starfive/visionfive2/spl.c              | 52 +++++++++++++++++++
 .../visionfive2/starfive_visionfive2.c        |  4 ++
 2 files changed, 56 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/=
spl.c
index ca61b5be22..b8d29a02af 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -226,6 +226,56 @@ void spl_fdt_fixup_version_b(void *fdt)
 =09}
 }
=20
+void spl_fdt_fixup_star64(void *fdt)
+{
+=09static const char compat[] =3D "starfive,star64\0starfive,jh7110";
+=09u32 phandle;
+=09u8 i;
+=09int offset;
+=09int ret;
+
+=09fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeo=
f(compat));
+=09fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
+=09=09=09   "Pine64 Star64");
+
+=09/* gmac0 */
+=09offset =3D fdt_path_offset(fdt, "/soc/clock-controller@17000000");
+=09phandle =3D fdt_get_phandle(fdt, offset);
+=09offset =3D fdt_path_offset(fdt, "/soc/ethernet@16030000");
+
+=09fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
+=09fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_=
TX);
+=09fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
+=09fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
+=09=09=09   JH7110_AONCLK_GMAC0_RMII_RTX);
+
+=09/* gmac1 */
+=09offset =3D fdt_path_offset(fdt, "/soc/clock-controller@13020000");
+=09phandle =3D fdt_get_phandle(fdt, offset);
+=09offset =3D fdt_path_offset(fdt, "/soc/ethernet@16040000");
+
+=09fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
+=09fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_=
TX);
+=09fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
+=09fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
+=09=09=09   JH7110_SYSCLK_GMAC1_RMII_RTX);
+
+=09for (i =3D 0; i < ARRAY_SIZE(starfive_verb); i++) {
+=09=09offset =3D fdt_path_offset(fdt, starfive_verb[i].path);
+
+=09=09if (starfive_verb[i].value)
+=09=09=09ret =3D fdt_setprop_u32(fdt, offset,  starfive_verb[i].name,
+=09=09=09=09=09      dectoul(starfive_verb[i].value, NULL));
+=09=09else
+=09=09=09ret =3D fdt_setprop_empty(fdt, offset, starfive_verb[i].name);
+
+=09=09if (ret) {
+=09=09=09pr_err("%s set prop %s fail.\n", __func__, starfive_verb[i].name)=
;
+=09=09=09=09break;
+=09=09}
+=09}
+}
+
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
 =09u8 version;
@@ -252,6 +302,8 @@ void spl_perform_fixups(struct spl_image_info *spl_imag=
e)
 =09=09=09spl_fdt_fixup_version_b(spl_image->fdt_addr);
 =09=09break;
 =09=09};
+=09} else if (!strncmp(product_id, "STAR64", 6)) {
+=09=09spl_fdt_fixup_star64(spl_image->fdt_addr);
 =09} else {
 =09=09pr_err("Unknown product %s\n", product_id);
 =09};
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/star=
five/visionfive2/starfive_visionfive2.c
index a86bca533b..93bc8b5c55 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -23,6 +23,8 @@ DECLARE_GLOBAL_DATA_PTR;
 =09"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
 #define FDTFILE_VISIONFIVE2_1_3B \
 =09"starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
+#define FDTFILE_PINE64_STAR64 \
+=09"starfive/pine64-star64.dtb"
=20
 /* enable U74-mc hart1~hart4 prefetcher */
 static void enable_prefetcher(void)
@@ -78,6 +80,8 @@ static void set_fdtfile(void)
 =09=09=09fdtfile =3D FDTFILE_VISIONFIVE2_1_3B;
 =09=09=09break;
 =09=09}
+=09} else if (!strncmp(product_id, "STAR64", 6)) {
+=09=09fdtfile =3D FDTFILE_PINE64_STAR64;
 =09} else {
 =09=09log_err("Unknown product\n");
 =09=09return;
--=20
2.44.0

