Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27037C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA73581727;
	Tue, 28 Jan 2025 00:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="t05JNbIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4B5812BB; Tue, 28 Jan 2025 00:03:35 +0100 (CET)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E448819D9
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738019010; x=1738278210;
 bh=I/95xGIbEbJ3qB8ss428Pv0V2dLfQgul3vM2d5Re+y8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=t05JNbIoxkaGZXLajN04edjQbX/b7zvYdc+2dgyreOT3/CnZXEr7ex0bBQKevLm1m
 JOTcWR9YQ1shyGMYje7xo93mf+5XQfv0W9N/ULZvXdWGhV0IFi5uShyErcA79jHTOZ
 s3Bhr43wMuxfDxbOZR8d/UIYRg15CVa44xZAi1GZoUWtZpJWUrvHqGTKjg6lnba/x0
 hK2kJGVJc8++F1bRN2FDOZ1XhWSwt/zhzW+EUZofRwpRvxxabffYKO4VsjauZFuDKL
 qAdL+rwx5nVnt6MZRXf7irsPNtCPQ9a6cMffqXCsh7fx2K5tS524BO+pPq8+Cfl6av
 RGfs3/6xplZcw==
Date: Mon, 27 Jan 2025 23:03:23 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 5/6] mach-snapdragon: MSM8916 spin-table CPU boot support
Message-ID: <20250128-msm8916-smp-support-v1-5-39587f18cf0c@samcday.com>
In-Reply-To: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 3522eb6fd7e8dc184d03e25ebfc10b85a09657ae
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

Most MSM8916 devices lack PSCI support, instead they're brought online
with a qcom SCM call to set the boot address, and some register poking
of the APCS register block.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/Makefile      |   1 +
 arch/arm/mach-snapdragon/msm8916-smp.c | 135 +++++++++++++++++++++++++++++=
++++
 2 files changed, 136 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/M=
akefile
index e3b9510d25da040e72aa61668014f4863add6b5a..b5122946229afb57d14e20360de=
12650a5343df7 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -6,3 +6,4 @@ obj-y +=3D board.o
 obj-y +=3D qcom-scm.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) +=3D capsule_update.o
 obj-$(CONFIG_OF_LIVE) +=3D of_fixup.o
+obj-$(CONFIG_ARMV8_SPIN_TABLE) +=3D msm8916-smp.o
diff --git a/arch/arm/mach-snapdragon/msm8916-smp.c b/arch/arm/mach-snapdra=
gon/msm8916-smp.c
new file mode 100644
index 0000000000000000000000000000000000000000..fb044a4df9203783ecaa195a027=
f037e6e28f6ed
--- /dev/null
+++ b/arch/arm/mach-snapdragon/msm8916-smp.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * On MSM8916 devices that lack a PSCI implementation, firing up the secon=
dary
+ * cores requires a call to TZ to set the boot address, and some poking of=
 ACPS
+ * register block.
+ *
+ * Copyright (c) 2025 Linaro Ltd.
+ */
+
+#include <asm/spin_table.h>
+#include <cpu_func.h>
+#include <dm/ofnode.h>
+#include "qcom-scm.h"
+
+#define APCS_CPU_PWR_CTL=090x04
+#define CORE_PWRD_UP=09=09BIT(7)
+#define COREPOR_RST=09=09BIT(5)
+#define CORE_RST=09=09BIT(4)
+#define CORE_MEM_HS=09=09BIT(3)
+#define CORE_MEM_CLAMP=09=09BIT(1)
+#define CLAMP=09=09=09BIT(0)
+
+#define APC_PWR_GATE_CTL=090x14
+#define GDHS_CNT_SHIFT=09=0924
+#define GDHS_EN=09=09=09BIT(0)
+
+static void qcom_boot_cortex_a53(phys_addr_t acc_base)
+{
+=09u32 reg_val;
+
+=09/* Put the CPU into reset. */
+=09reg_val =3D CORE_RST | COREPOR_RST | CLAMP | CORE_MEM_CLAMP;
+=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
+
+=09/* Turn on the GDHS and set the GDHS_CNT to 16 XO clock cycles */
+=09writel(GDHS_EN | (0x10 << GDHS_CNT_SHIFT), acc_base + APC_PWR_GATE_CTL)=
;
+=09/* Wait for the GDHS to settle */
+=09udelay(2);
+
+=09reg_val &=3D ~CORE_MEM_CLAMP;
+=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
+=09reg_val |=3D CORE_MEM_HS;
+=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
+=09udelay(2);
+
+=09reg_val &=3D ~CLAMP;
+=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
+=09udelay(2);
+
+=09/* Release CPU out of reset and bring it to life. */
+=09reg_val &=3D ~(CORE_RST | COREPOR_RST);
+=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
+=09reg_val |=3D CORE_PWRD_UP;
+=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
+}
+
+int qcom_scm_set_boot_addr_mc(void *entry, unsigned int flags)
+{
+=09struct qcom_scm_desc desc =3D {
+=09=09.svc =3D QCOM_SCM_SVC_BOOT,
+=09=09.cmd =3D QCOM_SCM_BOOT_SET_ADDR_MC,
+=09=09.owner =3D ARM_SMCCC_OWNER_SIP,
+=09=09.arginfo =3D QCOM_SCM_ARGS(6),
+=09=09.args =3D {
+=09=09=09(u64)entry,
+=09=09=09/* Apply to all CPUs in all affinity levels */
+=09=09=09~0ULL, ~0ULL, ~0ULL, ~0ULL,
+=09=09=09flags,
+=09=09},
+=09};
+
+=09return qcom_scm_call(&desc, SMC_CONVENTION_ARM_32, NULL, false);
+}
+
+static bool boot_addr_set;
+
+int spin_table_boot_cpu(void *fdt, int cpu_offset)
+{
+=09struct fdtdec_phandle_args acc;
+=09u32 mpidr_aff, acc_base, reg;
+=09int ret;
+
+=09reg =3D fdtdec_get_uint(fdt, cpu_offset, "reg", 0);
+
+=09if (fdt_node_check_compatible(fdt, cpu_offset, "arm,cortex-a53")) {
+=09=09log_warning("CPU%d is not arm,cortex-a53 compatible\n", reg);
+=09=09return -EINVAL;
+=09}
+
+=09if (!boot_addr_set) {
+=09=09if (!qcom_scm_is_call_available(QCOM_SCM_SVC_BOOT,
+=09=09=09=09=09=09QCOM_SCM_BOOT_SET_ADDR_MC,
+=09=09=09=09=09=09SMC_CONVENTION_ARM_32)) {
+=09=09=09log_warning("BOOT_SET_ADDR_MC unavailable\n");
+=09=09=09return -EPERM;
+=09=09}
+
+=09=09debug("Setting CPU boot address to 0x%llx\n",
+=09=09      (phys_addr_t)&spin_table_reserve_begin);
+=09=09ret =3D qcom_scm_set_boot_addr_mc(&spin_table_reserve_begin,
+=09=09=09=09=09=09QCOM_SCM_BOOT_MC_FLAG_AARCH64 |
+=09=09=09=09=09=09QCOM_SCM_BOOT_MC_FLAG_COLDBOOT);
+=09=09if (ret) {
+=09=09=09log_err("Failed to set CPU boot addr: %d\n", ret);
+=09=09=09return ret;
+=09=09}
+
+=09=09boot_addr_set =3D true;
+=09}
+
+=09mpidr_aff =3D read_mpidr() & 0xffffff;
+
+=09if (reg =3D=3D mpidr_aff) {
+=09=09debug("Skipping boot of current CPU%d\n", reg);
+=09=09return 0;
+=09}
+
+=09ret =3D fdtdec_parse_phandle_with_args(fdt, cpu_offset, "qcom,acc",
+=09=09=09=09=09     NULL, 0, 0, &acc);
+=09if (ret) {
+=09=09log_err("Failed to parse qcom,acc phandle: %d\n", reg);
+=09=09return ret;
+=09}
+
+=09acc_base =3D fdtdec_get_addr_size_auto_noparent(fdt, acc.node, "reg", 0=
,
+=09=09=09=09=09=09      NULL, true);
+=09if (!acc_base) {
+=09=09log_err("Failed to parse qcom,acc regbase\n");
+=09=09return -EINVAL;
+=09}
+
+=09log_info("Booting CPU%d @ 0x%x\n", reg, acc_base);
+=09qcom_boot_cortex_a53(acc_base);
+=09return 0;
+}

--=20
2.47.1


