Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3ADC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 23:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D21807A8;
	Tue, 21 Jan 2025 00:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="RsO2PeXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3186D801F5; Mon, 20 Jan 2025 20:43:27 +0100 (CET)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18004800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737402203; x=1737661403;
 bh=xpFVjuzTJzaspz19albYcWw/JpyrkHze+FSX8jUt5SM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=RsO2PeXksZB5s0Rwtnx36M0XCGXR6fiN/I0HZZpAZEkxNba6w11f0ApJXeO9jN92w
 XPm9T6/8xLX1q7DJxvVQ9x5NQIcjMhVy21AU33h2WanDL9ADZo3ASiTofCUCwvLbFR
 /ek2lYmG0SjcJujpWI3iOXKrfu4ZEbNF2WkaH8VoNCwqGOybmmPFkb+141x4jDZPdS
 Y7HCmZ76xkLodYOjOlcVoYahUIuhmBMsR6EJZEy4d/6gpM2o8pcGL8i37+Nb4ukHiB
 mm3awzCo9Q2LAn+OT4H4wtZdu9wYV0/Be6QprmuvbYaeUsLlobqBklKG7AgUrTfIuP
 N21bSq3N5JpWg==
Date: Mon, 20 Jan 2025 19:43:17 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 2/2] mach-snapdragon: support parsing memory info from
 external FDT
Message-ID: <20250120-qcom-parse-memory-updates-v1-2-54a7f0550cff@samcday.com>
In-Reply-To: <20250120-qcom-parse-memory-updates-v1-0-54a7f0550cff@samcday.com>
References: <20250120-qcom-parse-memory-updates-v1-0-54a7f0550cff@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 1d93a1c64b4da5e338d506db4994e7a155c5a378
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Jan 2025 00:25:40 +0100
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

Prior to this commit, board_fdt_blob_setup would decide which FDT to
use, either the external one from the previous bootloader, or the
internal one that was compiled into the binary.

This commit expands that behaviour a bit further, and introduces a
(default-enabled) option to always parse the /memory node from the
external FDT (if it's present and valid), even if we're going to
continue the boot with an internal one.

The rationale here is that many (all?) of the upstream DTs for the
msm8916 + sdm845 (and likely others) socs do not fully specify the /memory
node(s), since it's typically expected that the bootloader has selected
one of these from an Android boot.img and then filled in the memory
info.

Caleb's original explanation in the commit that introduced
qcom_parse_memory was dropped into a comment above that function, since
this part of the early initialization is getting quite nuanced. We don't
want uninitiated folks to see that code and run away screaming or give
away all their possessions and move to a monastery or something.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/Kconfig | 13 +++++++++
 arch/arm/mach-snapdragon/board.c | 57 +++++++++++++++++++++++++++---------=
----
 2 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kc=
onfig
index 976c0e35fcef29bafecbbd6ea04459de852df275..0feb65a916459160a4da9947a6d=
7224930d507b4 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -45,4 +45,17 @@ config SYS_CONFIG_NAME
 =09  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h heade=
r
 =09  will be used for board configuration.
=20
+config SYS_MEMORY_FROM_EXTERNAL_FDT
+=09bool "Always parse /memory from external device tree, if it's provided"
+=09default y
+=09help
+=09  When booting with an internal DT, we'll always use that since it's
+=09  expected to be more accurate + up-to-date than whatever the previous
+=09  bootloader hands us.
+
+=09  The notable exception here is the /memory node. With this config opti=
on
+=09  enabled, we'll initialize memory based on the information provided in=
 the
+=09  external DT from the previous bootloader, even if we use the internal=
 DT
+=09  for everything else.
+
 endif
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index 2ef936aab757c7045729a2dd91944f4f9bff917e..f637bce18546fb3a9fe389e07f4=
57346ad5f95c8 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -88,6 +88,29 @@ int dram_init_banksize(void)
 =09return 0;
 }
=20
+/**
+ * The generic memory parsing code in U-Boot lacks a few things that we
+ * need on Qualcomm:
+ *
+ * 1. It sets gd->ram_size and gd->ram_base to represent a single memory b=
lock
+ * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the=
 end
+ *    of that first memory block.
+ *
+ * This results in all memory beyond U-Boot being unusable in Linux when b=
ooting
+ * with EFI.
+ *
+ * Since the ranges in the memory node may be out of order, the only way f=
or us
+ * to correctly determine the relocation address for U-Boot is to parse al=
l
+ * memory regions and find the highest valid address.
+ *
+ * We can't use fdtdec_setup_memory_banksize() since it stores the result =
in
+ * gd->bd, which is not yet allocated.
+ *
+ * This function requires a pointer to the specific FDT that we should par=
se
+ * for its /memory block. This is because when SYS_MEMORY_FROM_EXTERNAL_FD=
T is
+ * enabled, we might be looking at the FDT provided by the previous bootlo=
ader,
+ * rather than our internal (gd->fdt_blob) one.
+ */
 static void qcom_parse_memory(const void *fdt)
 {
 =09int offset;
@@ -153,13 +176,13 @@ static void show_psci_version(void)
  */
 int board_fdt_blob_setup(void **fdtp)
 {
-=09struct fdt_header *fdt;
+=09struct fdt_header *external_fdt, *internal_fdt;
 =09bool internal_valid, external_valid;
-=09int ret =3D 0;
=20
-=09fdt =3D (struct fdt_header *)get_prev_bl_fdt_addr();
-=09external_valid =3D fdt && !fdt_check_header(fdt);
-=09internal_valid =3D !fdt_check_header(*fdtp);
+=09internal_fdt =3D (struct fdt_header *)*fdtp;
+=09external_fdt =3D (struct fdt_header *)get_prev_bl_fdt_addr();
+=09external_valid =3D external_fdt && !fdt_check_header(external_fdt);
+=09internal_valid =3D !fdt_check_header(internal_fdt);
=20
 =09/*
 =09 * There is no point returning an error here, U-Boot can't do anything =
useful in this situation.
@@ -167,24 +190,22 @@ int board_fdt_blob_setup(void **fdtp)
 =09 */
 =09if (!internal_valid && !external_valid)
 =09=09panic("Internal FDT is invalid and no external FDT was provided! (fd=
t=3D%#llx)\n",
-=09=09      (phys_addr_t)fdt);
+=09=09      (phys_addr_t)external_fdt);
+
+=09if (IS_ENABLED(CONFIG_SYS_MEMORY_FROM_EXTERNAL_FDT) && external_valid)
+=09=09/* Explicitly use the external FDT to configure memory */
+=09=09qcom_parse_memory(external_fdt);
+=09else
+=09=09qcom_parse_memory(internal_fdt);
=20
 =09if (internal_valid) {
 =09=09debug("Using built in FDT\n");
-=09=09ret =3D -EEXIST;
-=09} else {
-=09=09debug("Using external FDT\n");
-=09=09/* So we can use it before returning */
-=09=09*fdtp =3D fdt;
+=09=09return -EEXIST;
 =09}
=20
-=09/*
-=09 * Parse the /memory node while we're here,
-=09 * this makes it easy to do other things early.
-=09 */
-=09qcom_parse_memory(*fdtp);
-
-=09return ret;
+=09debug("Using external FDT\n");
+=09*fdtp =3D external_fdt;
+=09return 0;
 }
=20
 void reset_cpu(void)

--=20
2.47.1


