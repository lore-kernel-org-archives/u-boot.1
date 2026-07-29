Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D70FC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D93A9812EC;
	Wed, 29 Jul 2026 12:28:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oODVOB1ugvIK; Wed, 29 Jul 2026 12:28:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD7BF81353
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328128;
	bh=3BnpfMjZ327g3KwHR2ESLOsl5/hCfIRv62Sn55WBWDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Upa+i3groYaH/Xxi5Eq7nRVTDzITQRAHT2oL5aAj62WnmdDuJzyouH9XRlM49W/EW
	 SCs97A/LBB/4McYotUEwQOGE5nAzfKa4nY4XFwCUgp+dzEd97etRkQmnkz7buo9col
	 Byap0JkbWTYkgZb+IQFwPCDJiHCiwwqcZg+1I0fyPCQQYprYiggsopd8no0pIK/Ife
	 MpCtOmTsRKunmB0fo3+wVGaJowvnM4G3PQ+nkwzJ1Zk/87wuRw4fuBw3vRgOaRpFJF
	 lukwqYGqVX7GRbl7u42dmxNcYKuZcnvs6/kRoCCM4l7ooEsFdVKMgO3iHH264kbskQ
	 mW6TpjW2yqx/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD7BF81353;
	Wed, 29 Jul 2026 12:28:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 19ACC26C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BC8D80FDD
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oY-k7ziglG7m for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 363C980F78
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 363C980F78
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 363C980F78
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C9C8849EB; Wed, 29 Jul 2026 10:52:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 39C588498B
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:20 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B25B169C;
 Wed, 29 Jul 2026 01:52:15 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CA713F66F;
 Wed, 29 Jul 2026 01:52:17 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 20/22] test: dm: add sandbox FF-A runtime transport tests
Date: Wed, 29 Jul 2026 09:51:22 +0100
Message-Id: <20260729085124.2618817-21-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785315139; bh=l0pNU5B+Ue9b8ihNoIQGQw/s0pjQKGm8MMeXJn8l3uk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RCEGJ67uiFUkAxggO4n7HoRGf/0Jv2UI8leKiAU4Dmi6oU71mlVGxfl39PAlmdS2L
 jkq7zRTCpaoFf/YnaNWuSDe7k2hvMiiRNAdsGhVu229gjQ30CCdiLN5FmOcAct+tN6
 unwyLKClUxOVN8I78l9Ccjo7mjfGxkUD4UgyuDO0=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=RCEGJ67u
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="RCEGJ67u"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Exercise FF-A runtime helpers via sandbox DM tests

Test the successful runtime direct-message round trip and the invalid
destination-partition case, using the shared FF-A prepare step so the
sandbox emulator has initialized partition state before exercising the
runtime-only messaging helpers.
Add a dedicated no-context test that calls
ffa_sync_send_receive_runtime() before enabling the runtime context and
checks that it returns -EPERM. Reset the resident FF-A runtime context
around the transport tests so the runtime flag and private data do not
leak across test cases.
Split the ffa_to_std_errno() checks into a separate DM test so
error-mapping regressions are reported independently from transport
failures. Cover both the valid mappings and the boundary inputs that
must return -EINVAL.

Replace the hard-coded synthetic partition execution-context and
property values in ffa-emul-uclass.c with the shared
SANDBOX_SP*_EXEC_CTXT and SANDBOX_SP*_PROPERTIES macros. This lets the
sandbox emulator and tests reuse a single definition of the synthetic
partition metadata.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 arch/sandbox/include/asm/sandbox_arm_ffa.h |  16 ++-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c |  37 +++++--
 test/dm/Makefile                           |   3 +-
 test/dm/ffa_runtime.c                      | 123 +++++++++++++++++++++
 4 files changed, 166 insertions(+), 13 deletions(-)
 create mode 100644 test/dm/ffa_runtime.c

diff --git a/arch/sandbox/include/asm/sandbox_arm_ffa.h b/arch/sandbox/include/asm/sandbox_arm_ffa.h
index be2790f4960..a20eb159b73 100644
--- a/arch/sandbox/include/asm/sandbox_arm_ffa.h
+++ b/arch/sandbox/include/asm/sandbox_arm_ffa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -26,6 +26,20 @@
 #define SANDBOX_SP3_ID 0x6452
 #define SANDBOX_SP4_ID 0x7814
 
+/*
+ * The sandbox FF-A emulator uses fixed, synthetic execution-context counts and
+ * property bitfields for each partition.
+ */
+#define SANDBOX_SP1_EXEC_CTXT 0x5687
+#define SANDBOX_SP2_EXEC_CTXT 0x9587
+#define SANDBOX_SP3_EXEC_CTXT 0x7687
+#define SANDBOX_SP4_EXEC_CTXT 0x1487
+
+#define SANDBOX_SP1_PROPERTIES 0x89325621
+#define SANDBOX_SP2_PROPERTIES 0x45325621
+#define SANDBOX_SP3_PROPERTIES 0x23325621
+#define SANDBOX_SP4_PROPERTIES 0x70325621
+
 /* Invalid service UUID (no matching SP) */
 #define SANDBOX_SERVICE3_UUID	"55d532ed-0942-e699-722d-c09ca798d9cd"
 
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index d270f7b614e..3351d2e2edd 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -19,42 +19,57 @@
 /* The partitions (SPs) table */
 static struct ffa_partition_desc sandbox_partitions[SANDBOX_PARTITIONS_CNT] = {
 	{
-		.info = { .id = SANDBOX_SP1_ID, .exec_ctxt = 0x5687, .properties = 0x89325621 },
+		.info = {
+			.id = SANDBOX_SP1_ID,
+			.exec_ctxt = SANDBOX_SP1_EXEC_CTXT,
+			.properties = SANDBOX_SP1_PROPERTIES,
+		},
 		.sp_uuid = {
 			.a1 = SANDBOX_SERVICE1_UUID_A1,
 			.a2 = SANDBOX_SERVICE1_UUID_A2,
 			.a3 = SANDBOX_SERVICE1_UUID_A3,
 			.a4 = SANDBOX_SERVICE1_UUID_A4,
-		}
+		},
 	},
 	{
-		.info = { .id = SANDBOX_SP3_ID, .exec_ctxt = 0x7687, .properties = 0x23325621 },
+		.info = {
+			.id = SANDBOX_SP3_ID,
+			.exec_ctxt = SANDBOX_SP3_EXEC_CTXT,
+			.properties = SANDBOX_SP3_PROPERTIES,
+		},
 		.sp_uuid = {
 			.a1 = SANDBOX_SERVICE2_UUID_A1,
 			.a2 = SANDBOX_SERVICE2_UUID_A2,
 			.a3 = SANDBOX_SERVICE2_UUID_A3,
 			.a4 = SANDBOX_SERVICE2_UUID_A4,
-		}
+		},
 	},
 	{
-		.info = { .id = SANDBOX_SP2_ID, .exec_ctxt = 0x9587, .properties = 0x45325621 },
+		.info = {
+			.id = SANDBOX_SP2_ID,
+			.exec_ctxt = SANDBOX_SP2_EXEC_CTXT,
+			.properties = SANDBOX_SP2_PROPERTIES,
+		},
 		.sp_uuid = {
 			.a1 = SANDBOX_SERVICE1_UUID_A1,
 			.a2 = SANDBOX_SERVICE1_UUID_A2,
 			.a3 = SANDBOX_SERVICE1_UUID_A3,
 			.a4 = SANDBOX_SERVICE1_UUID_A4,
-		}
+		},
 	},
 	{
-		.info = { .id = SANDBOX_SP4_ID, .exec_ctxt = 0x1487, .properties = 0x70325621 },
+		.info = {
+			.id = SANDBOX_SP4_ID,
+			.exec_ctxt = SANDBOX_SP4_EXEC_CTXT,
+			.properties = SANDBOX_SP4_PROPERTIES,
+		},
 		.sp_uuid = {
 			.a1 = SANDBOX_SERVICE2_UUID_A1,
 			.a2 = SANDBOX_SERVICE2_UUID_A2,
 			.a3 = SANDBOX_SERVICE2_UUID_A3,
 			.a4 = SANDBOX_SERVICE2_UUID_A4,
-		}
-	}
-
+		},
+	},
 };
 
 /* The emulator functions */
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 0e3c63568dd..102b1e98284 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Copyright (c) 2013 Google, Inc
-# Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+# Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
 
 # Tests for particular subsystems - when enabling driver model for a new
 # subsystem you must add sandbox tests here.
@@ -98,6 +98,7 @@ obj-$(CONFIG_ACPI_PMC) += pmc.o
 obj-$(CONFIG_DM_PMIC) += pmic.o
 obj-$(CONFIG_DM_PWM) += pwm.o
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += ffa.o
+obj-$(CONFIG_ARM_FFA_TRANSPORT) += ffa_runtime.o
 obj-$(CONFIG_QFW) += qfw.o
 obj-$(CONFIG_RAM) += ram.o
 obj-y += regmap.o
diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
new file mode 100644
index 00000000000..3820628f86b
--- /dev/null
+++ b/test/dm/ffa_runtime.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Functional tests for FF-A runtime helpers
+ *
+ * Copyright 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *      Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
+ */
+
+#include <dm.h>
+#include <dm/test.h>
+#include <asm/sandbox_arm_ffa.h>
+#include <asm/sandbox_arm_ffa_priv.h>
+#include <arm_ffa_runtime.h>
+#include <test/ut.h>
+
+static int ffa_runtime_prepare(struct unit_test_state *uts, u16 *sp_id)
+{
+	struct ffa_partition_desc *descs;
+	u32 count;
+	struct udevice *dev;
+	const char *svc_uuid = SANDBOX_SERVICE1_UUID;
+
+	ut_assertok(uclass_first_device_err(UCLASS_FFA, &dev));
+	ut_assertok(ffa_partition_info_get(dev, svc_uuid, &count, &descs));
+	ut_assert(count > 0);
+
+	if (sp_id)
+		*sp_id = descs[0].info.id;
+
+	return 0;
+}
+
+static void ffa_runtime_teardown(void)
+{
+	ffa_runtime_context_reset();
+}
+
+static int ffa_runtime_setup(struct unit_test_state *uts, u16 *sp_id)
+{
+	ffa_runtime_teardown();
+	ut_assert(!ffa_runtime_context_ready());
+	ut_assertok(ffa_runtime_prepare(uts, sp_id));
+
+	ffa_copy_runtime_priv(&(struct ffa_priv_runtime){
+		.id = NS_PHYS_ENDPOINT_ID,
+	});
+	ffa_runtime_context_enable();
+
+	/* Ensure runtime context is available before attempting runtime-only paths */
+	ut_assert(ffa_runtime_context_ready());
+
+	return 0;
+}
+
+static int dm_test_ffa_runtime_no_context(struct unit_test_state *uts)
+{
+	struct ffa_send_direct_data msg = {0};
+	u16 sp_id;
+
+	ffa_runtime_teardown();
+	ut_assert(!ffa_runtime_context_ready());
+
+	ut_assertok(ffa_runtime_prepare(uts, &sp_id));
+
+	/* Runtime messaging must fail until the runtime context is enabled */
+	ut_asserteq(-EPERM, ffa_sync_send_receive_runtime(sp_id, &msg, true));
+
+	ffa_runtime_teardown();
+	return 0;
+}
+
+DM_TEST(dm_test_ffa_runtime_no_context, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int dm_test_ffa_to_std_errno(struct unit_test_state *uts)
+{
+	ut_asserteq(-EINVAL, ffa_to_std_errno(0));
+	ut_asserteq(-EINVAL, ffa_to_std_errno(MAX_NUMBER_FFA_ERR));
+	ut_asserteq(-EINVAL, ffa_to_std_errno(-MAX_NUMBER_FFA_ERR));
+	ut_asserteq(-EINVAL, ffa_to_std_errno(-(MAX_NUMBER_FFA_ERR + 1)));
+
+	ut_asserteq(-EINVAL, ffa_to_std_errno(-INVALID_PARAMETERS));
+	ut_asserteq(-EOPNOTSUPP, ffa_to_std_errno(-NOT_SUPPORTED));
+
+	return 0;
+}
+
+DM_TEST(dm_test_ffa_to_std_errno, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int dm_test_ffa_runtime_ack(struct unit_test_state *uts)
+{
+	struct ffa_send_direct_data msg = {0};
+	u16 sp_id;
+	u8 cnt;
+
+	ut_assertok(ffa_runtime_setup(uts, &sp_id));
+
+	/* Runtime messaging should reuse the sandbox emulator and return 0xff pattern */
+	ut_assertok(ffa_sync_send_receive_runtime(sp_id, &msg, true));
+	for (cnt = 0; cnt < sizeof(struct ffa_send_direct_data) / sizeof(u64); cnt++)
+		ut_asserteq_64(-1UL, ((u64 *)&msg)[cnt]);
+
+	ffa_runtime_teardown();
+	return 0;
+}
+
+DM_TEST(dm_test_ffa_runtime_ack, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int dm_test_ffa_runtime_nack(struct unit_test_state *uts)
+{
+	struct ffa_send_direct_data msg = {0};
+
+	ut_assertok(ffa_runtime_setup(uts, NULL));
+
+	/* Invalid partition IDs must be rejected and mapped to -EINVAL */
+	ut_asserteq(-EINVAL, ffa_sync_send_receive_runtime(0xffff, &msg, true));
+
+	ffa_runtime_teardown();
+	return 0;
+}
+
+DM_TEST(dm_test_ffa_runtime_nack, UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.34.1

