Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8B2CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD1E848B4;
	Mon,  1 Jun 2026 14:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="VzGFhjck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8794846D3; Mon,  1 Jun 2026 10:04:06 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CC43846F8
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780301043; x=1780560243;
 bh=RlriMSJvuI+r5dz546DpH6fFM05P+qIcBguh1C2X7EI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=VzGFhjckEWSBg9UKAsC4YRODJv20Wk6aSmR3yoPYpG1TW9T2jrt8eIXsvILbWKTTh
 Hhy10x+3QLz2NKY0+JK1sGDcWljy1ZYp9gz9aDT03uMVFB/nviOkICt3AtFJUchhcV
 IXgP0Cml7bU7VsfIQl5xBmKdSDxv9g1JWFVuiLlFwwUug1XCi2YvKJcPLNOCKKZTdq
 ZUUFr0Eutw1KrkyjGwCB8h7pBd2NiqliXCgAX5rx6akr0NmejOd9l0zlaP+N+TncW0
 3EKnW49lGTwCdcSyJTAw8LT1bB3rb/XDrgYwRR89233+Jq61rsw5r260VMWEp7Ngc4
 oQSaVjFBIu0Yg==
Date: Mon, 01 Jun 2026 08:03:55 +0000
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
Subject: [PATCH 03/16] arm: save_prev_bl_data: ARM32 support
Message-ID: <20260601-qcom-armv7-v1-3-c4b7f7aae1eb@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
References: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 27ae613c673c12974225c4172da345880b1f1829
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

The main change here is to make is_addr_accessible() portable, by using
gd->bd->bi_ram rather than the ARMv8 memory map. AFAICT, at the point
that this is running, these two things are 1:1 anyway (see
qcom_configure_bi_dram).

Once that's out of the way, we add ARM32 support by looking at r2 rather
than r0 and using portable pointer types.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/lib/save_prev_bl_data.c | 49 ++++++++++++++++++++++++------------=
----
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_d=
ata.c
index 4357acaef6c..83670541c50 100644
--- a/arch/arm/lib/save_prev_bl_data.c
+++ b/arch/arm/lib/save_prev_bl_data.c
@@ -12,33 +12,41 @@
 #include <fdt.h>
 #include <linux/errno.h>
 #include <asm/system.h>
-#include <asm/armv8/mmu.h>
=20
-static ulong reg0 __section(".data");
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static phys_addr_t prev_bl_fdt_addr __section(".data");
=20
 /**
- * Save x0 register value, assuming previous bootloader set it to
- * point on loaded fdt or (for older linux kernels)atags.
+ * Save the register value used by Linux boot ABI to pass the FDT or ATAGS=
.
  */
-void save_boot_params(ulong r0)
+void save_boot_params(ulong r0, ulong __always_unused r1, ulong r2)
 {
-=09reg0 =3D r0;
+=09if (IS_ENABLED(CONFIG_ARM64))
+=09=09prev_bl_fdt_addr =3D r0;
+=09else
+=09=09prev_bl_fdt_addr =3D r2;
+
 =09save_boot_params_ret();
 }
=20
 bool is_addr_accessible(phys_addr_t addr)
 {
-=09struct mm_region *mem =3D mem_map;
 =09phys_addr_t bank_start;
 =09phys_addr_t bank_end;
=20
-=09while (mem->size) {
-=09=09bank_start =3D mem->phys;
-=09=09bank_end =3D bank_start + mem->size;
-=09=09debug("check if block %pap - %pap includes %pap\n", &bank_start, &ba=
nk_end, &addr);
-=09=09if (addr > bank_start && addr < bank_end)
+=09for (int i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+=09=09if (!gd->bd->bi_dram[i].size)
+=09=09=09continue;
+
+=09=09bank_start =3D gd->bd->bi_dram[i].start;
+=09=09bank_end =3D bank_start + gd->bd->bi_dram[i].size;
+=09=09debug("check if block %pap - %pap includes %pap\n",
+=09=09      &bank_start, &bank_end, &addr);
+=09=09if (addr >=3D bank_start && addr < bank_end)
 =09=09=09return true;
-=09=09mem++;
 =09}
=20
 =09return false;
@@ -46,33 +54,34 @@ bool is_addr_accessible(phys_addr_t addr)
=20
 phys_addr_t get_prev_bl_fdt_addr(void)
 {
-=09return reg0;
+=09return prev_bl_fdt_addr;
 }
=20
 int save_prev_bl_data(void)
 {
 =09struct fdt_header *fdt_blob;
 =09int node;
-=09u64 initrd_start_prop;
+=09phys_addr_t initrd_start_prop;
=20
-=09if (!is_addr_accessible((phys_addr_t)reg0))
+=09if (!is_addr_accessible(prev_bl_fdt_addr))
 =09=09return -ENODATA;
=20
-=09fdt_blob =3D (struct fdt_header *)reg0;
+=09fdt_blob =3D (struct fdt_header *)prev_bl_fdt_addr;
 =09if (!fdt_valid(&fdt_blob)) {
-=09=09pr_warn("%s: address 0x%lx is not a valid fdt\n", __func__, reg0);
+=09=09pr_warn("%s: address 0x%lx is not a valid fdt\n",
+=09=09=09__func__, prev_bl_fdt_addr);
 =09=09return -ENODATA;
 =09}
=20
 =09if (IS_ENABLED(CONFIG_SAVE_PREV_BL_FDT_ADDR))
-=09=09env_set_addr("prevbl_fdt_addr", (void *)reg0);
+=09=09env_set_addr("prevbl_fdt_addr", (const void *)prev_bl_fdt_addr);
 =09if (!IS_ENABLED(CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR))
 =09=09return 0;
=20
 =09node =3D fdt_path_offset(fdt_blob, "/chosen");
 =09if (!node) {
 =09=09pr_warn("%s: chosen node not found in device tree at addr: 0x%lx\n",
-=09=09=09=09=09__func__, reg0);
+=09=09=09=09=09__func__, prev_bl_fdt_addr);
 =09=09return -ENODATA;
 =09}
 =09/*

--=20
2.54.0


