Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B53CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DE6848BF;
	Mon,  1 Jun 2026 14:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="U1+jZg4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069DF846FA; Mon,  1 Jun 2026 10:04:19 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1829C846D3
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780301056; x=1780560256;
 bh=js+a1RSGeQHCfNx+nASVHh8kCyfIh01U0XQp6nKs+gI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=U1+jZg4vdQ+O9yJ7IKcs/aejN93Av4hrj4OCmr67dhjBFeT0F7jYTGkNYeuiBwkLt
 QEbZdt8ABVcWeq3X61lifa4t+/YZR0x7Zw5+em1wFSE361U3ntqjynFvWe2OdNN4q/
 MyKvTzube+OYu3C9Q4GaJnv6fgwNSCOxS48/44PPAYJ40k3xQkGPs1gRJXh8KBW6f2
 6j/n1oYCrCyFqSnfpaKKU4SaIisniXnxbiU1haFoQ+N6xzE3+OcEC1UpHQ9phWukP+
 JZVl3qWvwSOmJUQ10OPahfUPmu2Vy99Xna/QHuQHTnqkw7Xp/nQ0+Q3utG7BDduVH7
 tPAb/WBAJs9Bg==
Date: Mon, 01 Jun 2026 08:04:06 +0000
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>, David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
Subject: [PATCH 04/16] mach-snapdragon: qcom_parse_memory 32-bit support
Message-ID: <20260601-qcom-armv7-v1-4-c4b7f7aae1eb@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
References: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 3b6e3806fd87f4d23ae83e3ac0e9e0c21bf80ad5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

qcom_parse_memory is updated to handle varying address/size cell counts,
rather than assuming a count of 2 (64 bit). This means it can now parse
/memory nodes in both arm64 and arm32 devicetrees.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/board.c | 42 ++++++++++++++++++++++++++----------=
----
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index 829a0109ac7..56e943058ed 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -115,8 +115,9 @@ int dram_init_banksize(void)
 static int qcom_parse_memory(const void *fdt)
 {
 =09int offset;
-=09const fdt64_t *memory;
+=09const fdt32_t *memory;
 =09int memsize;
+=09int parent, addr_cells, size_cells, entry_cells;
 =09phys_addr_t ram_end =3D 0;
 =09int i, j, banks;
=20
@@ -124,33 +125,46 @@ static int qcom_parse_memory(const void *fdt)
 =09if (offset < 0)
 =09=09return -ENODATA;
=20
+=09parent =3D fdt_parent_offset(fdt, offset);
+=09if (parent < 0)
+=09=09return -ENODATA;
+
+=09addr_cells =3D fdt_address_cells(fdt, parent);
+=09size_cells =3D fdt_size_cells(fdt, parent);
+=09entry_cells =3D addr_cells + size_cells;
+=09if (addr_cells <=3D 0 || size_cells <=3D 0)
+=09=09return -ENODATA;
+
 =09memory =3D fdt_getprop(fdt, offset, "reg", &memsize);
 =09if (!memory)
 =09=09return -ENODATA;
=20
-=09banks =3D min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS)=
;
-
-=09if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
-=09=09log_err("Provided more than the max of %d memory banks\n", CONFIG_NR=
_DRAM_BANKS);
+=09banks =3D min(memsize / (entry_cells * (int)sizeof(fdt32_t)),
+=09=09    (int)CONFIG_NR_DRAM_BANKS);
=20
 =09if (banks > CONFIG_NR_DRAM_BANKS)
 =09=09log_err("Provided more memory banks than we can handle\n");
=20
-=09for (i =3D 0, j =3D 0; i < banks * 2; i +=3D 2, j++) {
-=09=09prevbl_ddr_banks[j].start =3D get_unaligned_be64(&memory[i]);
-=09=09prevbl_ddr_banks[j].size =3D get_unaligned_be64(&memory[i + 1]);
-=09=09if (!prevbl_ddr_banks[j].size) {
-=09=09=09j--;
+=09for (i =3D 0, j =3D 0; i < banks; i++) {
+=09=09phys_addr_t start =3D fdt_read_number(memory, addr_cells);
+=09=09phys_size_t size =3D fdt_read_number(memory + addr_cells,
+=09=09=09=09=09=09   size_cells);
+
+=09=09memory +=3D entry_cells;
+=09=09if (!size)
 =09=09=09continue;
-=09=09}
-=09=09ram_end =3D max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_bank=
s[j].size);
+
+=09=09prevbl_ddr_banks[j].start =3D start;
+=09=09prevbl_ddr_banks[j].size =3D size;
+=09=09ram_end =3D max(ram_end, start + size);
+=09=09j++;
 =09}
=20
-=09if (!banks || !prevbl_ddr_banks[0].size)
+=09if (!j)
 =09=09return -ENODATA;
=20
 =09/* Sort our RAM banks -_- */
-=09qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cm=
p);
+=09qsort(prevbl_ddr_banks, j, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
=20
 =09gd->ram_base =3D prevbl_ddr_banks[0].start;
 =09gd->ram_size =3D ram_end - gd->ram_base;

--=20
2.54.0


