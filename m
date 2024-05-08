Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD02AC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 04:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09DB788445;
	Thu,  9 May 2024 06:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="fpE01VoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EB4E8823D; Wed,  8 May 2024 22:33:11 +0200 (CEST)
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch
 [185.70.40.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B9687D43
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 22:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmoo_dv@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1715200387; x=1715459587;
 bh=ZgYGIH/a5JtGKtCkdg25mnJycF0lrj4sl0J0tuS7a48=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fpE01VoNj5ytSW0mc84sqILxDa01nJIkCwR7URZ8T0mTSiA4v4+E2hynVtECVzomi
 sv/8UQcwq7yi+0DncS2OPq3JdJbtcydI5os6ffdzmWjKufkc04+BhNIGH1g5TYO6Vw
 sQibuZod/jTd9GXfpVaWSsr/mMKLhZSfZgjn/PUSAe928tZkPTNtFOjR0jmSIeo19/
 VPEEhBKCYU9Z2WwIR++WgxpDmlT2+lb0Cow1KDDYOV5CuIpICqSS3usFpjw8/lK20s
 DP1s0VOIcm9/zuOUtk1YEqKjLZ46ZHRIXYZGG9o1CaZ17VPGUTq7HTKCtS92AAo0jg
 oon1h/rVgmXYA==
Date: Wed, 08 May 2024 20:33:04 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: H Bell <dmoo_dv@protonmail.com>
Subject: [PATCH 1/2 v2] board: starfive: support Pine64 Star64 board
Message-ID: <2Wf_X25fjiTRU7BZzFK3Mxj8Bgte4ggnq0BjYcxn2AR0FFfZi0jwedw-hokUad4ow2wxy6lhNW5gC0CEVbeCNo_qq1CM74FBrwlopiFYcp0=@protonmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: 64a4bba41c986436fd9b8683f0852a90318bce4e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 09 May 2024 06:59:07 +0200
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
---
 board/starfive/visionfive2/spl.c              | 85 +++++++++++++++++++
 .../visionfive2/starfive_visionfive2.c        |  4 +
 2 files changed, 89 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/=
spl.c
index ca61b5be22..248c6ba01d 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -86,6 +86,39 @@ static const struct starfive_vf2_pro starfive_verb[] =3D=
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
+=09=09"motorcomm,tx-clk-100-inverted", NULL},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"motorcomm,tx-clk-1000-inverted", NULL},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"motorcomm,rx-clk-drv-microamp", "3970"},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"motorcomm,rx-data-drv-microamp", "2910"},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"rx-internal-delay-ps", "1900"},
+=09{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+=09=09"tx-internal-delay-ps", "1500"},
+
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"motorcomm,tx-clk-adj-enabled", NULL},
+=09{ "/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"motorcomm,tx-clk-100-inverted", NULL},
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"motorcomm,rx-clk-drv-microamp", "3970"},
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"motorcomm,rx-data-drv-microamp", "2910"},
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"rx-internal-delay-ps", "0"},
+=09{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+=09=09"tx-internal-delay-ps", "0"},
+};
+
 void spl_fdt_fixup_mars(void *fdt)
 {
 =09static const char compat[] =3D "milkv,mars\0starfive,jh7110";
@@ -226,6 +259,56 @@ void spl_fdt_fixup_version_b(void *fdt)
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
@@ -252,6 +335,8 @@ void spl_perform_fixups(struct spl_image_info *spl_imag=
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
index a86bca533b..1e7c41f01b 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -23,6 +23,8 @@ DECLARE_GLOBAL_DATA_PTR;
 =09"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
 #define FDTFILE_VISIONFIVE2_1_3B \
 =09"starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
+#define FDTFILE_PINE64_STAR64 \
+=09"starfive/jh7110-pine64-star64.dtb"
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


