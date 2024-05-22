Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E3CC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 19:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A5A87FF7;
	Wed, 22 May 2024 21:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="vQZwvsKz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E3888287; Wed, 22 May 2024 21:12:56 +0200 (CEST)
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch
 [185.70.40.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C6287F8E
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 21:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmoo_dv@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1716405172; x=1716664372;
 bh=wTQOUe4/j+tMT7aF4JRdWDWeEbmFVkGeEpTW/Ttekt8=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=vQZwvsKzb4VVyz6CeHzeb99+XYkg1y/hQq1KfIvDuP2uvnhG4dhv7swYrlGUDFMd1
 6NT1B6Lf4wwpk6Nro/gGJCYIcuGFgSAQq1Exa0QBFrYqvqcSjdWw4vi73/vMfmvGJE
 KZgYvNwjZnsb3wlCcCOK5JlfkLSfHjGc4/3NmMX47CJEJ4g18x5eG2J9YrGU1EPitQ
 adkNHAMk4qt8AuaSPh6/AtEsxSIbaUa2XFORjweBIxXWj4WwCVrjNCrazzhYOER30R
 P9oLFtaKKVNsLcimnLN3SVHiCxPAeTCT+hz/MAo5rbu3iAkifnBV0V7owl2EpALj4i
 /yRMgvy9VQRQg==
Date: Wed, 22 May 2024 19:12:48 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: H Bell <dmoo_dv@protonmail.com>
Subject: [PATCH 1/2 v5] board: starfive: support Pine64 Star64 board
Message-ID: <dcEaD5-kc_SzXGz7v_bxIV4C3Rqg0b0x2bWGjCclG5pS_sL_tWoxtWu7VQqu_2SOx0LN3h9bHcaqsa_l-PiOQAMkZpiJ9G4SQta-kfPDuJw=@protonmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: 77fd52007df6306a3cb863917615c4bae8df211a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Changes since v1

- Fix typos on naming
- Create pine64_star64 struct to be populated with PHY values once confirme=
d

Changes since v2

- Set delays to 0
- Add missing 10/100/1000 clocks across the two devices
- Set all uA values to 2910

Changes since v3

- Rebase against d678a59d2d

Changes since v4

- Fix up delay values
---
 board/starfive/visionfive2/spl.c              | 89 +++++++++++++++++++
 .../visionfive2/starfive_visionfive2.c        |  4 +
 2 files changed, 93 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/=
spl.c
index b555189556..b794b73b6b 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -86,6 +86,43 @@ static const struct starfive_vf2_pro starfive_verb[] =3D=
 {
 =09=09"tx-internal-delay-ps", "0"},
 };
=20
+static const struct starfive_vf2_pro star64_pine64[] =3D {
+=09{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
+=09{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
+
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"motorcomm,tx-clk-adj-enabled", NULL},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"motorcomm,tx-clk-10-inverted", NULL},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"motorcomm,tx-clk-100-inverted", NULL},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"motorcomm,tx-clk-1000-inverted", NULL},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"motorcomm,rx-clk-drv-microamp", "2910"},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"motorcomm,rx-data-drv-microamp", "2910"},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"rx-internal-delay-ps", "1900"},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"tx-internal-delay-ps", "1500"},
+
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"motorcomm,tx-clk-adj-enabled", NULL},
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"motorcomm,tx-clk-10-inverted", NULL},
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"motorcomm,tx-clk-100-inverted", NULL},
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"motorcomm,rx-clk-drv-microamp", "2910"},
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"motorcomm,rx-data-drv-microamp", "2910"},
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"rx-internal-delay-ps", "0"},
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"tx-internal-delay-ps", "300"},
+};
+
 void spl_fdt_fixup_mars(void *fdt)
 {
 =09static const char compat[] =3D "milkv,mars\0starfive,jh7110";
@@ -250,6 +287,56 @@ void spl_fdt_fixup_version_b(void *fdt)
 =09}
 }
=20
+void spl_fdt_fixup_star64(void *fdt)
+{
+=09static const char compat[] =3D "pine64,star64\0starfive,jh7110";
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
+=09for (i =3D 0; i < ARRAY_SIZE(star64_pine64); i++) {
+=09=09offset =3D fdt_path_offset(fdt, star64_pine64[i].path);
+
+=09=09if (star64_pine64[i].value)
+=09=09=09ret =3D fdt_setprop_u32(fdt, offset,  star64_pine64[i].name,
+=09=09=09=09=09      dectoul(star64_pine64[i].value, NULL));
+=09=09else
+=09=09=09ret =3D fdt_setprop_empty(fdt, offset, star64_pine64[i].name);
+
+=09=09if (ret) {
+=09=09=09pr_err("%s set prop %s fail.\n", __func__, star64_pine64[i].name)=
;
+=09=09=09=09break;
+=09=09}
+=09}
+}
+
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
 =09u8 version;
@@ -278,6 +365,8 @@ void spl_perform_fixups(struct spl_image_info *spl_imag=
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
index 6be5348962..f6114602f8 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -27,6 +27,8 @@ DECLARE_GLOBAL_DATA_PTR;
 =09"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
 #define FDTFILE_VISIONFIVE2_1_3B \
 =09"starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
+#define FDTFILE_PINE64_STAR64 \
+=09"starfive/jh7110-pine64-star64.dtb"
=20
 /* enable U74-mc hart1~hart4 prefetcher */
 static void enable_prefetcher(void)
@@ -87,6 +89,8 @@ static void set_fdtfile(void)
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


