Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0BFC2D0CD
	for <u-boot@archiver.kernel.org>; Sat, 17 May 2025 22:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 226A3828BC;
	Sun, 18 May 2025 00:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="sSA1LoVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3DC8205B; Sat, 17 May 2025 23:28:08 +0200 (CEST)
Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch
 [109.224.244.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B498004F
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 23:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=omapbsf@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1747517285; x=1747776485;
 bh=3XslgXbjB+qfz8RnbaxrzsmdsoBfLy+5gIi6AF0+glk=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=sSA1LoVnS0lo/wHE7jX3j0wpqKf2yYsspY/jHjPRi60M2lZVhqzSp39c7IkeJRkhA
 pl6e6fQ633xKVfh/1m3ZV40p7Dm2MJIHOmoYK9GmGcqJ6LeNS3VNJvIX/EH/qGiyAQ
 3mqi4lfUT19yseOGZ7zfKdXu2UHD09dKxuMuaBpcP/CBpGkibFp6nDjOVkXxfwsivq
 luTGYqCFU0jy9ry0QQeC+Sduh4WJVh4BdGmr7m6k65flQo/LZecOUN+J0ZdG/m94Ue
 96h75PiIp/6pAYoGEgcfQer1mkQRDuo2/ZiGZzQWUQxZlGu4gUITRXz0+1eMylgwbp
 kq1t9nXS+AKVA==
Date: Sat, 17 May 2025 21:28:01 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: OMAP at BSF <omapbsf@protonmail.com>
Subject: [PATCH v4 2/2] BeagleBoard: Fix memory detection error.
Message-ID: <mE_4mhVOMZGRGr8pC62KHcBcDzi9omdv8D2PHs9wPgUcSz60ltpSb0TYKx_M-b_SUarVQhSXSMhdfmUuQOGBIsWfjFLqEOr8TtekJqnsdpQ=@protonmail.com>
Feedback-ID: 36988183:user:proton
X-Pm-Message-ID: 1f69ddea4a24f6c7657a3d954f09e2a0d2ea0669
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 18 May 2025 00:52:04 +0200
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

GPIOs are read to determine which BeagleBoard variant we are running
on. It also affects the memory timings for LPDDR. The GPIO lines are
not valid for SPL until we are attempting the first boot device. The
GPIO lines need to be checked again in U-Boot because they were not
valid early on in SPL. The board and LPDDR timings are now correct.

Signed-off-by: Steven Hill <omapbsf@protonmail.com>
---
v2: No change.
v3: No change.
v4: No change.

---
 arch/arm/mach-omap2/omap3/Makefile |  2 --
 arch/arm/mach-omap2/omap3/sdrc.c   | 18 +++++-----
 board/beagle/beagle/beagle.c       | 56 ++++++++++++++----------------
 3 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3/Makefile b/arch/arm/mach-omap2/omap3=
/Makefile
index 159633e7f6d..cf0f7100353 100644
--- a/arch/arm/mach-omap2/omap3/Makefile
+++ b/arch/arm/mach-omap2/omap3/Makefile
@@ -15,9 +15,7 @@ obj-y=09+=3D clock.o
 obj-y=09+=3D sys_info.o
 obj-y=09+=3D prcm-regs.o
 obj-y=09+=3D hw_data.o
-ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_OMAP3_ID_NAND)=09+=3D spl_id_nand.o
-endif
=20
 obj-$(CONFIG_DRIVER_TI_EMAC)=09+=3D emac.o
 obj-$(CONFIG_EMIF4)=09+=3D emif4.o
diff --git a/arch/arm/mach-omap2/omap3/sdrc.c b/arch/arm/mach-omap2/omap3/s=
drc.c
index 24fae484369..a3aef01d641 100644
--- a/arch/arm/mach-omap2/omap3/sdrc.c
+++ b/arch/arm/mach-omap2/omap3/sdrc.c
@@ -146,10 +146,10 @@ static void do_sdrc_init(u32 cs, u32 early)
 =09 * then set cs_cfg to the appropriate value then try and
 =09 * setup CS1.
 =09 */
-#ifdef CONFIG_XPL_BUILD
+
 =09/* set/modify board-specific timings */
 =09get_board_mem_timings(&timings);
-#endif
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 =09if (early) {
 =09=09/* reset sdrc controller */
 =09=09writel(SOFTRESET, &sdrc_base->sysconfig);
@@ -166,14 +166,13 @@ static void do_sdrc_init(u32 cs, u32 early)
=20
 =09=09writel(ENADLL | DLLPHASE_90, &sdrc_base->dlla_ctrl);
 =09=09sdelay(0x20000);
-#ifdef CONFIG_XPL_BUILD
-=09=09write_sdrc_timings(CS0, sdrc_actim_base0, &timings);
-=09=09make_cs1_contiguous();
-=09=09write_sdrc_timings(CS1, sdrc_actim_base1, &timings);
-#endif
-
 =09}
+#endif
+=09write_sdrc_timings(CS0, sdrc_actim_base0, &timings);
+=09make_cs1_contiguous();
+=09write_sdrc_timings(CS1, sdrc_actim_base1, &timings);
=20
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 =09/*
 =09 * If we aren't using SPL we have been loaded by some
 =09 * other means which may not have correctly initialized
@@ -188,6 +187,7 @@ static void do_sdrc_init(u32 cs, u32 early)
 =09=09timings.mr =3D readl(&sdrc_base->cs[CS0].mr);
 =09=09write_sdrc_timings(cs, sdrc_actim_base1, &timings);
 =09}
+#endif
 }
=20
 /*
@@ -230,6 +230,7 @@ int dram_init_banksize(void)
 =09return 0;
 }
=20
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 /*
  * omap3_mem_init -
  *  - Init the sdrc chip,
@@ -240,3 +241,4 @@ void omap3_mem_init(void)
 =09/* only init up first bank here */
 =09do_sdrc_init(CS0, EARLY_INIT);
 }
+#endif
diff --git a/board/beagle/beagle/beagle.c b/board/beagle/beagle/beagle.c
index 660a50afd0d..a5c9073d8c1 100644
--- a/board/beagle/beagle/beagle.c
+++ b/board/beagle/beagle/beagle.c
@@ -24,7 +24,9 @@
 #endif
 #include <twl4030.h>
 #include <asm/global_data.h>
+#if (IS_ENABLED(CONFIG_MTD_RAW_NAND))
 #include <linux/mtd/rawnand.h>
+#endif
 #include <asm/io.h>
 #include <asm/arch/mmc_host_def.h>
 #include <i2c.h>
@@ -70,6 +72,11 @@ static struct {
 =09char env_setting[64];
 } expansion_config;
=20
+#if (IS_ENABLED(CONFIG_SPL_OMAP3_ID_NAND))
+static int mfr_id;
+static int pop_id;
+#endif
+
 /*
  * Routine: board_init
  * Description: Early hardware init.
@@ -135,7 +142,6 @@ static int get_board_revision(void)
 =09return revision;
 }
=20
-#if (IS_ENABLED(CONFIG_SPL_BUILD))
 /*
  * Routine: get_board_mem_timings
  * Description: If we use SPL then there is no x-loader nor config header
@@ -143,55 +149,46 @@ static int get_board_revision(void)
  */
 void get_board_mem_timings(struct board_sdrc_timings *timings)
 {
-=09int pop_mfr, pop_id;
-
-=09/*
-=09 * We need to identify what PoP memory is on the board so that
-=09 * we know what timings to use.  If we can't identify it then
-=09 * we know it's an xM.  To map the ID values please see nand_ids.c
-=09 */
-=09identify_nand_chip(&pop_mfr, &pop_id);
-
 =09timings->mr =3D MICRON_V_MR_165;
 =09switch (get_board_revision()) {
 =09case REVISION_C4:
-=09=09if (pop_mfr =3D=3D NAND_MFR_STMICRO && pop_id =3D=3D 0xba) {
+#if (IS_ENABLED(CONFIG_SPL_OMAP3_ID_NAND))
+=09=09/*
+=09=09 * We need to identify what PoP memory is on the board to know
+=09=09 * what timings to use. To map the ID values please see nand_ids.c
+=09=09 */
+=09=09identify_nand_chip(&mfr_id, &pop_id);
+
+=09=09if (mfr_id =3D=3D NAND_MFR_STMICRO && pop_id =3D=3D 0xba) {
 =09=09=09/* 512MB DDR */
 =09=09=09timings->mcfg =3D NUMONYX_V_MCFG_165(512 << 20);
 =09=09=09timings->ctrla =3D NUMONYX_V_ACTIMA_165;
 =09=09=09timings->ctrlb =3D NUMONYX_V_ACTIMB_165;
 =09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
-=09=09=09break;
-=09=09} else if (pop_mfr =3D=3D NAND_MFR_MICRON && pop_id =3D=3D 0xba) {
+=09=09}
+=09=09if (mfr_id =3D=3D NAND_MFR_MICRON && pop_id =3D=3D 0xba) {
 =09=09=09/* Beagleboard Rev C4, 512MB Nand/256MB DDR*/
 =09=09=09timings->mcfg =3D MICRON_V_MCFG_165(128 << 20);
 =09=09=09timings->ctrla =3D MICRON_V_ACTIMA_165;
 =09=09=09timings->ctrlb =3D MICRON_V_ACTIMB_165;
 =09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
-=09=09=09break;
-=09=09} else if (pop_mfr =3D=3D NAND_MFR_MICRON && pop_id =3D=3D 0xbc) {
+=09=09}
+=09=09if (mfr_id =3D=3D NAND_MFR_MICRON && pop_id =3D=3D 0xbc) {
 =09=09=09/* Beagleboard Rev C5, 256MB DDR */
 =09=09=09timings->mcfg =3D MICRON_V_MCFG_200(256 << 20);
 =09=09=09timings->ctrla =3D MICRON_V_ACTIMA_200;
 =09=09=09timings->ctrlb =3D MICRON_V_ACTIMB_200;
 =09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHZ;
-=09=09=09break;
 =09=09}
+=09=09break;
+#endif
 =09case REVISION_XM_AB:
 =09case REVISION_XM_C:
-=09=09if (pop_mfr =3D=3D 0) {
-=09=09=09/* 256MB DDR */
-=09=09=09timings->mcfg =3D MICRON_V_MCFG_200(256 << 20);
-=09=09=09timings->ctrla =3D MICRON_V_ACTIMA_200;
-=09=09=09timings->ctrlb =3D MICRON_V_ACTIMB_200;
-=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHZ;
-=09=09} else {
-=09=09=09/* 512MB DDR */
-=09=09=09timings->mcfg =3D NUMONYX_V_MCFG_165(512 << 20);
-=09=09=09timings->ctrla =3D NUMONYX_V_ACTIMA_165;
-=09=09=09timings->ctrlb =3D NUMONYX_V_ACTIMB_165;
-=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
-=09=09}
+=09=09/* 512MB DDR */
+=09=09timings->mcfg =3D MICRON_V_MCFG_200(256 << 20);
+=09=09timings->ctrla =3D MICRON_V_ACTIMA_200;
+=09=09timings->ctrlb =3D MICRON_V_ACTIMB_200;
+=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHZ;
 =09=09break;
 =09default:
 =09=09/* Assume 128MB and Micron/165MHz timings to be safe */
@@ -201,7 +198,6 @@ void get_board_mem_timings(struct board_sdrc_timings *t=
imings)
 =09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
 =09}
 }
-#endif
=20
 /*
  * Routine: get_expansion_id
--=20
2.43.0


