Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7915C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 129758187B;
	Tue, 28 Jan 2025 00:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="AJ5WWz08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D269E8191C; Tue, 28 Jan 2025 00:03:16 +0100 (CET)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E54C812BB
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738018993; x=1738278193;
 bh=DlyWc1Jcq41IaL44Ezu+3XGj52FuxKF3kHhFO+6MKqc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=AJ5WWz081L+dbvhPpIkWC1FJi/sf+6cAUsfTooroqeLkvheX0and8OiNx4pCGvLh1
 dXaYR7R7wFfcEX6yJA1qb0Z8Clymi4EjdYNxvdonGBIA+ipJ0dmyK0t4QZLFlCeSuf
 5oGDa7fkXrVo0UKG06ATvpggQgsN/dudEV9mR+K200gsFKhO8RJyFUl33h1aBCUVal
 j6nrkPtYfSiJvz0/kWjSWrsdmoDmuMdU3P/TBEZUR6VmHYTQwB2U0li+fkTRTDfNcw
 TwGogFrOokJ78YpFgp2YILcJWSPvwRyfFfhxM1AaqBx5bTieTo78bbVWR0kSRlRHGh
 Lf6L+q4n7WJ5w==
Date: Mon, 27 Jan 2025 23:03:08 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 3/6] mach-snapdragon: qcom SCM call support
Message-ID: <20250128-msm8916-smp-support-v1-3-39587f18cf0c@samcday.com>
In-Reply-To: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 2650e93b9a64654a9722865c2d4a954eb33ea0bf
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

These calls are a little more complex than a standard SMCCC instruction.
There's 32bit/64bit calling conventions, support for passing more
arguments than can fit in the usual registers (by placing a pointer to
the additional args in x7), and the use of a qcom-specific smccc quirk.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/Makefile   |   1 +
 arch/arm/mach-snapdragon/qcom-scm.c | 145 +++++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-scm.h | 165 ++++++++++++++++++++++++++++++++=
++++
 3 files changed, 311 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/M=
akefile
index 343e825c6fdd05f36e210b138e741b7b7dd606ac..e3b9510d25da040e72aa6166801=
4f4863add6b5a 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -3,5 +3,6 @@
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
=20
 obj-y +=3D board.o
+obj-y +=3D qcom-scm.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) +=3D capsule_update.o
 obj-$(CONFIG_OF_LIVE) +=3D of_fixup.o
diff --git a/arch/arm/mach-snapdragon/qcom-scm.c b/arch/arm/mach-snapdragon=
/qcom-scm.c
new file mode 100644
index 0000000000000000000000000000000000000000..b9ccd1bbb7c1a43d864f2d5f380=
4836a06607b11
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom-scm.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Linaro Ltd. */
+
+/* Much of this code was adapted from Linux kernel */
+/* Copyright (c) 2010-2015,2019 The Linux Foundation.=09 All rights reserv=
ed.
+ */
+
+#include "qcom-scm.h"
+
+#define QCOM_SCM_EBUSY_WAIT_MS 30
+#define QCOM_SCM_EBUSY_MAX_RETRY 20
+
+#define SCM_SMC_N_REG_ARGS=094
+#define SCM_SMC_FIRST_EXT_IDX=09(SCM_SMC_N_REG_ARGS - 1)
+#define SCM_SMC_N_EXT_ARGS=09(MAX_QCOM_SCM_ARGS - SCM_SMC_N_REG_ARGS + 1)
+#define SCM_SMC_FIRST_REG_IDX=092
+#define SCM_SMC_LAST_REG_IDX=09(SCM_SMC_FIRST_REG_IDX + SCM_SMC_N_REG_ARGS=
 - 1)
+
+/**
+ * struct arm_smccc_args
+ * @args:=09The array of values used in registers in smc instruction
+ */
+struct arm_smccc_args {
+=09unsigned long args[8];
+};
+
+static void __scm_smc_do_quirk(const struct arm_smccc_args *smc,
+=09=09=09       struct arm_smccc_res *res)
+{
+=09unsigned long a0 =3D smc->args[0];
+=09struct arm_smccc_quirk quirk =3D { .id =3D ARM_SMCCC_QUIRK_QCOM_A6 };
+
+=09quirk.state.a6 =3D 0;
+
+=09do {
+=09=09arm_smccc_smc_quirk(a0, smc->args[1], smc->args[2],
+=09=09=09=09    smc->args[3], smc->args[4], smc->args[5],
+=09=09=09=09    quirk.state.a6, smc->args[7], res, &quirk);
+
+=09=09if (res->a0 =3D=3D QCOM_SCM_INTERRUPTED)
+=09=09=09a0 =3D res->a0;
+
+=09} while (res->a0 =3D=3D QCOM_SCM_INTERRUPTED);
+}
+
+static int __scm_smc_do(struct arm_smccc_args *smc, struct arm_smccc_res *=
res,
+=09=09=09bool atomic)
+{
+=09int retry_count =3D 0;
+
+=09do {
+=09=09__scm_smc_do_quirk(smc, res);
+
+=09=09if (atomic)
+=09=09=09return 0;
+
+=09=09if (res->a0 =3D=3D QCOM_SCM_V2_EBUSY) {
+=09=09=09if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
+=09=09=09=09break;
+=09=09=09mdelay(QCOM_SCM_EBUSY_WAIT_MS);
+=09=09}
+=09}  while (res->a0 =3D=3D QCOM_SCM_V2_EBUSY);
+
+=09return 0;
+}
+
+int qcom_scm_call(const struct qcom_scm_desc *desc,
+=09=09  enum qcom_scm_convention qcom_convention,
+=09=09  struct qcom_scm_res *res, bool atomic)
+{
+=09int arglen =3D desc->arginfo & 0xf;
+=09void *args =3D NULL;
+=09int i, ret;
+=09struct arm_smccc_args smc =3D {0};
+=09struct arm_smccc_res smc_res;
+=09u32 smccc_call_type =3D atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_STD_CA=
LL;
+=09u32 qcom_smccc_convention =3D (qcom_convention =3D=3D SMC_CONVENTION_AR=
M_32) ?
+=09=09=09=09    ARM_SMCCC_SMC_32 : ARM_SMCCC_SMC_64;
+=09u32 fnid =3D SCM_SMC_FNID(desc->svc, desc->cmd);
+
+=09smc.args[0] =3D ARM_SMCCC_CALL_VAL(smccc_call_type, qcom_smccc_conventi=
on,
+=09=09=09=09=09 desc->owner, fnid);
+=09smc.args[1] =3D desc->arginfo;
+=09for (i =3D 0; i < SCM_SMC_N_REG_ARGS; i++)
+=09=09smc.args[i + SCM_SMC_FIRST_REG_IDX] =3D desc->args[i];
+
+=09if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
+=09=09args =3D malloc_cache_aligned(SCM_SMC_N_EXT_ARGS * sizeof(u64));
+=09=09if (!args)
+=09=09=09return -ENOMEM;
+
+=09=09if (qcom_smccc_convention =3D=3D ARM_SMCCC_SMC_32) {
+=09=09=09__le32 *args32 =3D args;
+
+=09=09=09for (i =3D 0; i < SCM_SMC_N_EXT_ARGS; i++)
+=09=09=09=09args32[i] =3D cpu_to_le32(desc->args[i +
+=09=09=09=09=09=09=09SCM_SMC_FIRST_EXT_IDX]);
+=09=09} else {
+=09=09=09__le64 *args64 =3D args;
+
+=09=09=09for (i =3D 0; i < SCM_SMC_N_EXT_ARGS; i++)
+=09=09=09=09args64[i] =3D cpu_to_le64(desc->args[i +
+=09=09=09=09=09=09=09SCM_SMC_FIRST_EXT_IDX]);
+=09=09}
+
+=09=09smc.args[SCM_SMC_LAST_REG_IDX] =3D (phys_addr_t)args;
+=09=09flush_cache((unsigned long)args, SCM_SMC_N_EXT_ARGS * sizeof(u64));
+=09}
+
+=09ret =3D __scm_smc_do(&smc, &smc_res, atomic);
+
+=09if (args)
+=09=09free(args);
+
+=09if (ret)
+=09=09return ret;
+
+=09if (res) {
+=09=09res->result[0] =3D smc_res.a1;
+=09=09res->result[1] =3D smc_res.a2;
+=09=09res->result[2] =3D smc_res.a3;
+=09}
+
+=09return (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
+}
+
+bool qcom_scm_is_call_available(u32 svc_id, u32 cmd_id,
+=09=09=09=09enum qcom_scm_convention convention)
+{
+=09u32 fnid =3D SCM_SMC_FNID(svc_id, cmd_id);
+=09struct qcom_scm_res scm_ret =3D {0};
+=09struct qcom_scm_desc desc =3D {
+=09=09.svc =3D QCOM_SCM_SVC_INFO,
+=09=09.cmd =3D QCOM_SCM_INFO_IS_CALL_AVAIL,
+=09=09.owner =3D ARM_SMCCC_OWNER_SIP,
+=09=09.arginfo =3D QCOM_SCM_ARGS(1),
+=09=09.args =3D {
+=09=09=09ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, convention,
+=09=09=09=09=09   ARM_SMCCC_OWNER_SIP, fnid)
+=09=09},
+=09};
+=09if (qcom_scm_call(&desc, convention, &scm_ret, false))
+=09=09return false;
+=09return scm_ret.result[0];
+}
diff --git a/arch/arm/mach-snapdragon/qcom-scm.h b/arch/arm/mach-snapdragon=
/qcom-scm.h
new file mode 100644
index 0000000000000000000000000000000000000000..053d8b3c8cd44566f62b129e228=
963a50c678e19
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom-scm.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* This header was adapted from linux/drivers/firmware/qcom/qcom_scm.h */
+/* Copyright (c) 2010-2015,2019 The Linux Foundation. All rights reserved.
+ */
+#ifndef __QCOM_SCM_INT_H
+#define __QCOM_SCM_INT_H
+
+#include <asm/io.h>
+#include <errno.h>
+#include <linux/arm-smccc.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <memalign.h>
+
+enum qcom_scm_convention {
+=09SMC_CONVENTION_UNKNOWN,
+=09SMC_CONVENTION_LEGACY,
+=09SMC_CONVENTION_ARM_32,
+=09SMC_CONVENTION_ARM_64,
+};
+
+extern enum qcom_scm_convention qcom_scm_convention;
+
+#define MAX_QCOM_SCM_ARGS 10
+#define MAX_QCOM_SCM_RETS 3
+
+#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
+=09=09=09   (((a) & 0x3) << 4) | \
+=09=09=09   (((b) & 0x3) << 6) | \
+=09=09=09   (((c) & 0x3) << 8) | \
+=09=09=09   (((d) & 0x3) << 10) | \
+=09=09=09   (((e) & 0x3) << 12) | \
+=09=09=09   (((f) & 0x3) << 14) | \
+=09=09=09   (((g) & 0x3) << 16) | \
+=09=09=09   (((h) & 0x3) << 18) | \
+=09=09=09   (((i) & 0x3) << 20) | \
+=09=09=09   (((j) & 0x3) << 22) | \
+=09=09=09   ((num) & 0xf))
+
+#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, =
0, 0, 0, 0, 0)
+
+/**
+ * struct qcom_scm_desc
+ * @arginfo:=09Metadata describing the arguments in args[]
+ * @args:=09The array of arguments for the secure syscall
+ */
+struct qcom_scm_desc {
+=09u32 svc;
+=09u32 cmd;
+=09u32 arginfo;
+=09u64 args[MAX_QCOM_SCM_ARGS];
+=09u32 owner;
+};
+
+/**
+ * struct qcom_scm_res
+ * @result:=09The values returned by the secure syscall
+ */
+struct qcom_scm_res {
+=09u64 result[MAX_QCOM_SCM_RETS];
+};
+
+#define SCM_SMC_FNID(s, c)=09((((s) & 0xFF) << 8) | ((c) & 0xFF))
+
+#define QCOM_SCM_SVC_BOOT=09=090x01
+#define QCOM_SCM_BOOT_SET_ADDR=09=090x01
+#define QCOM_SCM_BOOT_TERMINATE_PC=090x02
+#define QCOM_SCM_BOOT_SDI_CONFIG=090x09
+#define QCOM_SCM_BOOT_SET_DLOAD_MODE=090x10
+#define QCOM_SCM_BOOT_SET_ADDR_MC=090x11
+#define QCOM_SCM_BOOT_SET_REMOTE_STATE=090x0a
+#define QCOM_SCM_FLUSH_FLAG_MASK=090x3
+#define QCOM_SCM_BOOT_MAX_CPUS=09=094
+#define QCOM_SCM_BOOT_MC_FLAG_AARCH64=09BIT(0)
+#define QCOM_SCM_BOOT_MC_FLAG_COLDBOOT=09BIT(1)
+#define QCOM_SCM_BOOT_MC_FLAG_WARMBOOT=09BIT(2)
+
+#define QCOM_SCM_SVC_PIL=09=090x02
+#define QCOM_SCM_PIL_PAS_INIT_IMAGE=090x01
+#define QCOM_SCM_PIL_PAS_MEM_SETUP=090x02
+#define QCOM_SCM_PIL_PAS_AUTH_AND_RESET=090x05
+#define QCOM_SCM_PIL_PAS_SHUTDOWN=090x06
+#define QCOM_SCM_PIL_PAS_IS_SUPPORTED=090x07
+#define QCOM_SCM_PIL_PAS_MSS_RESET=090x0a
+
+#define QCOM_SCM_SVC_IO=09=09=090x05
+#define QCOM_SCM_IO_READ=09=090x01
+#define QCOM_SCM_IO_WRITE=09=090x02
+
+#define QCOM_SCM_SVC_INFO=09=090x06
+#define QCOM_SCM_INFO_IS_CALL_AVAIL=090x01
+
+#define QCOM_SCM_SVC_MP=09=09=09=090x0c
+#define QCOM_SCM_MP_RESTORE_SEC_CFG=09=090x02
+#define QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE=090x03
+#define QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT=090x04
+#define QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE=090x05
+#define QCOM_SCM_MP_VIDEO_VAR=09=09=090x08
+#define QCOM_SCM_MP_ASSIGN=09=09=090x16
+#define QCOM_SCM_MP_SHM_BRIDGE_ENABLE=09=090x1c
+#define QCOM_SCM_MP_SHM_BRIDGE_DELETE=09=090x1d
+#define QCOM_SCM_MP_SHM_BRIDGE_CREATE=09=090x1e
+
+#define QCOM_SCM_SVC_OCMEM=09=090x0f
+#define QCOM_SCM_OCMEM_LOCK_CMD=09=090x01
+#define QCOM_SCM_OCMEM_UNLOCK_CMD=090x02
+
+#define QCOM_SCM_SVC_ES=09=09=090x10=09/* Enterprise Security */
+#define QCOM_SCM_ES_INVALIDATE_ICE_KEY=090x03
+#define QCOM_SCM_ES_CONFIG_SET_ICE_KEY=090x04
+
+#define QCOM_SCM_SVC_HDCP=09=090x11
+#define QCOM_SCM_HDCP_INVOKE=09=090x01
+
+#define QCOM_SCM_SVC_LMH=09=09=090x13
+#define QCOM_SCM_LMH_LIMIT_PROFILE_CHANGE=090x01
+#define QCOM_SCM_LMH_LIMIT_DCVSH=09=090x10
+
+#define QCOM_SCM_SVC_SMMU_PROGRAM=09=090x15
+#define QCOM_SCM_SMMU_PT_FORMAT=09=09=090x01
+#define QCOM_SCM_SMMU_CONFIG_ERRATA1=09=090x03
+#define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL=090x02
+
+#define QCOM_SCM_SVC_WAITQ=09=09=090x24
+#define QCOM_SCM_WAITQ_RESUME=09=09=090x02
+#define QCOM_SCM_WAITQ_GET_WQ_CTX=09=090x03
+
+#define QCOM_SCM_SVC_GPU=09=09=090x28
+#define QCOM_SCM_SVC_GPU_INIT_REGS=09=090x01
+
+/* common error codes */
+#define QCOM_SCM_V2_EBUSY=09-12
+#define QCOM_SCM_ENOMEM=09=09-5
+#define QCOM_SCM_EOPNOTSUPP=09-4
+#define QCOM_SCM_EINVAL_ADDR=09-3
+#define QCOM_SCM_EINVAL_ARG=09-2
+#define QCOM_SCM_ERROR=09=09-1
+#define QCOM_SCM_INTERRUPTED=091
+
+static inline int qcom_scm_remap_error(int err)
+{
+=09switch (err) {
+=09case QCOM_SCM_ERROR:
+=09=09return -EIO;
+=09case QCOM_SCM_EINVAL_ADDR:
+=09case QCOM_SCM_EINVAL_ARG:
+=09=09return -EINVAL;
+=09case QCOM_SCM_EOPNOTSUPP:
+=09=09return -EOPNOTSUPP;
+=09case QCOM_SCM_ENOMEM:
+=09=09return -ENOMEM;
+=09case QCOM_SCM_V2_EBUSY:
+=09=09return -EBUSY;
+=09}
+=09return -EINVAL;
+}
+
+bool qcom_scm_is_call_available(u32 svc_id, u32 cmd_id,
+=09=09=09=09enum qcom_scm_convention convention);
+
+int qcom_scm_call(const struct qcom_scm_desc *desc,
+=09=09  enum qcom_scm_convention qcom_convention,
+=09=09  struct qcom_scm_res *res, bool atomic);
+
+#endif

--=20
2.47.1


