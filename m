Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D771C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 12:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C87C80243;
	Thu, 23 Jan 2025 13:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="N7eaG6N5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBEE780214; Thu, 23 Jan 2025 13:12:22 +0100 (CET)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 640E080137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 13:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737634339; x=1737893539;
 bh=pTrZXwXaV3Tk4dHa36JA2TwXWlKZSAl8fCWBNa+z57o=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=N7eaG6N5EeDdoLrN8d3CqBGhp6Z+2x4q4kX11KBSba+kwsOCzmp63xfqmUxxQ6pgD
 PcAv7I0yw20orwy4kN16YUPMKb0FF8AAYvaMUUQ2QNyLszUrR8YgN+OXOwdaLsvatY
 4EKLhPw/KgGbGnx2cS8s/C48RWA5ytt/ca1Na51wO23/K8CDNac9p22p6qOL/NmLzb
 miimteaX4T21x3dk8hm2mByx2U6tW9+f7Jvwy5EoNoLVysHX6E++xhdC1p/N/B28v5
 JdVkhaBEkH15n+z+vgk9yoEJkDfiJrC9tojdsSTJotA8PiNBvM1Z1SjL/aRn9i3FI7
 jmJG/tmu4/N8g==
Date: Thu, 23 Jan 2025 12:12:14 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH v3] mach-snapdragon: support parsing memory info from external
 FDT
Message-ID: <20250123-qcom-parse-memory-updates-v3-1-c5332b81ea9f@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 19ce46eb7aef08c76a5f878a45ebd54696c7e36d
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

qcom_parse_memory is updated to return a -ENODATA error if the passed
FDT does not contain a /memory node, or that node is incomplete (size=3D0)

board_fdt_blob_setup first tries to call qcom_parse_memory with the
internal FDT (if present+valid). If that fails, it tries again with the
external FDT (again, if present+valid).

When booting with an internal FDT from upstream, it's likely that this
change results in a slight performance hit, since virtually all upstream
qcom DTs lack a fully specified memory node. The impact should be
negligible, though.

qcom_parse_memory was given a detailed docstring adapted from Caleb's
original commit message that introduced the function.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Sam Day <me@samcday.com>
---
Changes in v3:
- Dropped first patch as it's already been pulled into upstream
- Changed -ENODATA check in qcom_parse_memory per Caleb's advice in v2
- Link to v2: https://lore.kernel.org/r/20250122-qcom-parse-memory-updates-=
v2-0-98dfcac821d7@samcday.com

Changes in v2:
- Update qcom_parse_memory to return -ENODATA if provided FDT lacks
  valid /memory node
- Reworked board_fdt_blob_setup logic to always try qcom_parse_memory on
  internal FDT, falling back to external if needed
- Link to v1: https://lore.kernel.org/r/20250120-qcom-parse-memory-updates-=
v1-0-54a7f0550cff@samcday.com
---
 arch/arm/mach-snapdragon/board.c | 93 +++++++++++++++++++++++++++---------=
----
 1 file changed, 63 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index 2ef936aab757c7045729a2dd91944f4f9bff917e..e87551784b8d7afb4186533d43b=
8bddacba9faec 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -88,7 +88,29 @@ int dram_init_banksize(void)
 =09return 0;
 }
=20
-static void qcom_parse_memory(const void *fdt)
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
+ * @fdt: FDT blob to parse /memory node from
+ *
+ * Return: 0 on success or -ENODATA if /memory node is missing or incomple=
te
+ */
+static int qcom_parse_memory(const void *fdt)
 {
 =09int offset;
 =09const fdt64_t *memory;
@@ -97,16 +119,12 @@ static void qcom_parse_memory(const void *fdt)
 =09int i, j, banks;
=20
 =09offset =3D fdt_path_offset(fdt, "/memory");
-=09if (offset < 0) {
-=09=09log_err("No memory node found in device tree!\n");
-=09=09return;
-=09}
+=09if (offset < 0)
+=09=09return -ENODATA;
=20
 =09memory =3D fdt_getprop(fdt, offset, "reg", &memsize);
-=09if (!memory) {
-=09=09log_err("No memory configuration was provided by the previous bootlo=
ader!\n");
-=09=09return;
-=09}
+=09if (!memory)
+=09=09return -ENODATA;
=20
 =09banks =3D min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS)=
;
=20
@@ -119,7 +137,6 @@ static void qcom_parse_memory(const void *fdt)
 =09for (i =3D 0, j =3D 0; i < banks * 2; i +=3D 2, j++) {
 =09=09prevbl_ddr_banks[j].start =3D get_unaligned_be64(&memory[i]);
 =09=09prevbl_ddr_banks[j].size =3D get_unaligned_be64(&memory[i + 1]);
-=09=09/* SM8650 boards sometimes have empty regions! */
 =09=09if (!prevbl_ddr_banks[j].size) {
 =09=09=09j--;
 =09=09=09continue;
@@ -127,13 +144,16 @@ static void qcom_parse_memory(const void *fdt)
 =09=09ram_end =3D max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_bank=
s[j].size);
 =09}
=20
+=09if (!banks || !prevbl_ddr_banks[0].size)
+=09=09return -ENODATA;
+
 =09/* Sort our RAM banks -_- */
 =09qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cm=
p);
=20
 =09gd->ram_base =3D prevbl_ddr_banks[0].start;
 =09gd->ram_size =3D ram_end - gd->ram_base;
-=09debug("ram_base =3D %#011lx, ram_size =3D %#011llx, ram_end =3D %#011ll=
x\n",
-=09      gd->ram_base, gd->ram_size, ram_end);
+
+=09return 0;
 }
=20
 static void show_psci_version(void)
@@ -153,13 +173,14 @@ static void show_psci_version(void)
  */
 int board_fdt_blob_setup(void **fdtp)
 {
-=09struct fdt_header *fdt;
+=09struct fdt_header *external_fdt, *internal_fdt;
 =09bool internal_valid, external_valid;
-=09int ret =3D 0;
+=09int ret =3D -ENODATA;
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
@@ -167,24 +188,36 @@ int board_fdt_blob_setup(void **fdtp)
 =09 */
 =09if (!internal_valid && !external_valid)
 =09=09panic("Internal FDT is invalid and no external FDT was provided! (fd=
t=3D%#llx)\n",
-=09=09      (phys_addr_t)fdt);
+=09=09      (phys_addr_t)external_fdt);
+
+=09/* Prefer memory information from internal DT if it's present */
+=09if (internal_valid)
+=09=09ret =3D qcom_parse_memory(internal_fdt);
+
+=09if (ret < 0 && external_valid) {
+=09=09/* No internal FDT or it lacks a proper /memory node.
+=09=09 * The previous bootloader handed us something, let's try that.
+=09=09 */
+=09=09if (internal_valid)
+=09=09=09debug("No memory info in internal FDT, falling back to external\n=
");
+
+=09=09ret =3D qcom_parse_memory(external_fdt);
+=09}
+
+=09if (ret < 0)
+=09=09panic("No valid memory ranges found!\n");
+
+=09debug("ram_base =3D %#011lx, ram_size =3D %#011llx\n",
+=09      gd->ram_base, gd->ram_size);
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

---
base-commit: 2eed5a1ff36217372e19f7513bd07077fc76718a
change-id: 20250120-qcom-parse-memory-updates-96ffe248cdf1

Best regards,
--=20
Sam Day <me@samcday.com>


