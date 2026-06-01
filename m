Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8F5CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35BC6848CF;
	Mon,  1 Jun 2026 14:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="QKXGuOiB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE80B846FA; Mon,  1 Jun 2026 10:04:28 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D920846D3
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780301063; x=1780560263;
 bh=/JGguW6QGPezPE83ks20EHqyjUffhOxtLOT5bWWgMf8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=QKXGuOiBZ4FaszkskjJd4xQvBRtwDvPSVEne00PAqNhIjeZfboi+7mZVi2FSZZSJN
 ZkFH9IptEaH15YKo52YfEufsg88hreqqUHgfplnzC4XvwLQKHWGSFyZA84k17Yam5K
 v0UwgDclBoDsH0WaFdg4FKrCxPCvwDH4dkQZZClaMmeslmxKg00AAjC+QRFnHXyzw1
 8q0QztPOWSWMXPsbC2qCQXLx84iK7F4B31exOVfWI9aCIZfvYvL2wiME+cxnge4H9W
 gU6RxoggIwrpx0X6SiHkfs0k3DJUfSOJoyQZJgslwqBVzZYMzNKmtRZqbY+5vD2cGl
 NjSrDfS3ti2TA==
Date: Mon, 01 Jun 2026 08:04:16 +0000
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
Subject: [PATCH 05/16] mach-snapdragon: gate ARM64 features
Message-ID: <20260601-qcom-armv7-v1-5-c4b7f7aae1eb@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
References: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 806a2baaff01f501ed8fe116fb1ac0db631855f3
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

With some strategic (and minimal) #ifdef ARM64 gating, we can ensure
that mach-snapdragon board code compiles cleanly on arm32 toolchains.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/board.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index 56e943058ed..627b566d178 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -9,10 +9,8 @@
 #define LOG_CATEGORY LOGC_BOARD
 #define pr_fmt(fmt) "QCOM: " fmt
=20
-#include <asm/armv8/mmu.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
-#include <asm/psci.h>
 #include <asm/system.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
@@ -22,9 +20,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <init.h>
-#include <linux/arm-smccc.h>
 #include <linux/bug.h>
-#include <linux/psci.h>
 #include <linux/sizes.h>
 #include <lmb.h>
 #include <malloc.h>
@@ -35,13 +31,20 @@
=20
 #include "qcom-priv.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
-enum qcom_boot_source qcom_boot_source __section(".data") =3D 0;
+#ifdef CONFIG_ARM64
+#include <asm/armv8/mmu.h>
+#include <asm/psci.h>
+#include <linux/arm-smccc.h>
+#include <linux/psci.h>
=20
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] =3D { { 0 } =
};
=20
 struct mm_region *mem_map =3D rbx_mem_map;
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+enum qcom_boot_source qcom_boot_source __section(".data") =3D 0;
=20
 static struct {
 =09phys_addr_t start;
@@ -174,6 +177,7 @@ static int qcom_parse_memory(const void *fdt)
=20
 static void show_psci_version(void)
 {
+#ifdef CONFIG_ARM64
 =09struct arm_smccc_res res;
=20
 =09arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
@@ -185,6 +189,7 @@ static void show_psci_version(void)
 =09debug("PSCI:  v%ld.%ld\n",
 =09      PSCI_VERSION_MAJOR(res.a0),
 =09      PSCI_VERSION_MINOR(res.a0));
+#endif
 }
=20
 /**
@@ -196,6 +201,7 @@ static void show_psci_version(void)
  */
 static void qcom_psci_fixup(void *fdt)
 {
+#ifdef CONFIG_ARM64
 =09int offset, ret;
 =09struct arm_smccc_res res;
=20
@@ -212,6 +218,7 @@ static void qcom_psci_fixup(void *fdt)
 =09ret =3D fdt_del_node(fdt, offset);
 =09if (ret)
 =09=09log_err("Failed to delete /psci node: %d\n", ret);
+#endif
 }
=20
 /* We support booting U-Boot with an internal DT when running as a first-s=
tage bootloader
@@ -234,8 +241,8 @@ int board_fdt_blob_setup(void **fdtp)
 =09 * Bail out while we can still print a useful error message.
 =09 */
 =09if (!internal_valid && !external_valid)
-=09=09panic("Internal FDT is invalid and no external FDT was provided! (fd=
t=3D%#llx)\n",
-=09=09      (phys_addr_t)external_fdt);
+=09=09panic("Internal FDT is invalid and no external FDT was provided! (fd=
t=3D%p)\n",
+=09=09      external_fdt);
=20
 =09/* Prefer memory information from internal DT if it's present */
 =09if (internal_valid)
@@ -261,7 +268,7 @@ int board_fdt_blob_setup(void **fdtp)
 =09=09qcom_boot_source =3D QCOM_BOOT_SOURCE_XBL;
=20
 =09debug("ram_base =3D %#011lx, ram_size =3D %#011llx\n",
-=09      gd->ram_base, gd->ram_size);
+=09      gd->ram_base, (unsigned long long)gd->ram_size);
=20
 =09if (internal_valid) {
 =09=09debug("Using built in FDT\n");
@@ -595,6 +602,7 @@ int board_late_init(void)
 =09return 0;
 }
=20
+#ifdef CONFIG_ARM64
 static void build_mem_map(void)
 {
 =09int i, j;
@@ -768,3 +776,4 @@ void enable_caches(void)
 =09}
 =09dcache_enable();
 }
+#endif

--=20
2.54.0


