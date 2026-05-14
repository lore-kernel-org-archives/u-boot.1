Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC94CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 14:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 687B7846CF;
	Thu, 14 May 2026 16:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Cz7dvr1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83848467B; Thu, 14 May 2026 14:50:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BDB7783AA9
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5C033501;
 Thu, 14 May 2026 05:50:03 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6FC3F7B4;
 Thu, 14 May 2026 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778763009; bh=lrv7h9KWZueY+xhJrToDWW9VCPDh4Bl37eiJsW5CAEY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cz7dvr1hzdGMUrQqt0jEPU7ujw40sNu2A/EqvmZLZR3bt9oTJh4mniVBbJJlaOOPE
 MHaRZjbVfKimWE89bBTLkcUM2t1gHPO3XnmeW8Vj2BuhGCJWeXBdK6xWEwfojCmpA7
 WwTmaF4wFd/1zOIcM4MggQB0krgwIR6PLqrIGtTM=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 hugues.kambampiana@arm.com, sjg@chromium.org,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v2 09/11] test: dm: add sandbox FF-A runtime transport tests
Date: Thu, 14 May 2026 13:49:22 +0100
Message-Id: <20260514124924.1804332-10-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 16:49:29 +0200
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

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---

Changelog:
===============

v2:

Simon:

- Drop unused `sp_id` handling from the negative-path test
- Add no-context `-EPERM` coverage
- Reset the FF-A runtime context between tests
- Split errno-mapping checks into a dedicated DM test
- Add invalid-input boundary coverage

 arch/sandbox/include/asm/sandbox_arm_ffa.h |  16 ++-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c |  36 ++++--
 test/dm/Makefile                           |   3 +-
 test/dm/ffa_runtime.c                      | 129 +++++++++++++++++++++
 4 files changed, 172 insertions(+), 12 deletions(-)
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
index d270f7b614e..a8c6d3010eb 100644
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
@@ -19,41 +19,57 @@
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
+		},
+	},
 
 };
 
diff --git a/test/dm/Makefile b/test/dm/Makefile
index d69b0e08d66..383cec13666 100644
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
@@ -97,6 +97,7 @@ obj-$(CONFIG_ACPI_PMC) += pmc.o
 obj-$(CONFIG_DM_PMIC) += pmic.o
 obj-$(CONFIG_DM_PWM) += pwm.o
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += ffa.o
+obj-$(CONFIG_ARM_FFA_TRANSPORT) += ffa_runtime.o
 obj-$(CONFIG_QFW) += qfw.o
 obj-$(CONFIG_RAM) += ram.o
 obj-y += regmap.o
diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
new file mode 100644
index 00000000000..b48a6b363af
--- /dev/null
+++ b/test/dm/ffa_runtime.c
@@ -0,0 +1,129 @@
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
+static int dm_test_ffa_runtime_no_context(struct unit_test_state *uts)
+{
+	struct ffa_send_direct_data msg = {0};
+	u16 sp_id;
+
+	ffa_reset_runtime_context();
+	ut_assert(!ffa_get_status_runtime_context());
+
+	ut_assertok(ffa_runtime_prepare(uts, &sp_id));
+
+	/* Runtime messaging must fail until the runtime context is enabled */
+	ut_asserteq(-EPERM, ffa_sync_send_receive_runtime(sp_id, &msg, true));
+
+	ffa_reset_runtime_context();
+	return 0;
+}
+
+DM_TEST(dm_test_ffa_runtime_no_context, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int dm_test_ffa_to_std_errno(struct unit_test_state *uts)
+{
+	(void)uts;
+
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
+	ffa_reset_runtime_context();
+	ut_assert(!ffa_get_status_runtime_context());
+
+	ut_assertok(ffa_runtime_prepare(uts, &sp_id));
+
+	ffa_copy_runtime_priv(&(struct ffa_priv_runtime){
+		.id = NS_PHYS_ENDPOINT_ID,
+	});
+	ffa_enable_runtime_context();
+
+	/* Ensure runtime context is available before attempting runtime-only paths */
+	ut_assert(ffa_get_status_runtime_context());
+
+	/* Runtime messaging should reuse the sandbox emulator and return 0xff pattern */
+	ut_assertok(ffa_sync_send_receive_runtime(sp_id, &msg, true));
+	for (cnt = 0; cnt < sizeof(struct ffa_send_direct_data) / sizeof(u64); cnt++)
+		ut_asserteq_64(-1UL, ((u64 *)&msg)[cnt]);
+
+	ffa_reset_runtime_context();
+	return 0;
+}
+
+DM_TEST(dm_test_ffa_runtime_ack, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int dm_test_ffa_runtime_nack(struct unit_test_state *uts)
+{
+	struct ffa_send_direct_data msg = {0};
+
+	ffa_reset_runtime_context();
+	ut_assert(!ffa_get_status_runtime_context());
+
+	/*
+	 * Prime the sandbox partition table so the invalid-ID path reaches
+	 * the emulator's validation logic with initialized partition state.
+	 */
+	ut_assertok(ffa_runtime_prepare(uts, NULL));
+
+	ffa_copy_runtime_priv(&(struct ffa_priv_runtime){
+		.id = NS_PHYS_ENDPOINT_ID,
+	});
+	ffa_enable_runtime_context();
+
+	/* Ensure runtime context is available before attempting runtime-only paths */
+	ut_assert(ffa_get_status_runtime_context());
+
+	/* Invalid partition IDs must be rejected and mapped to -EINVAL */
+	ut_asserteq(-EINVAL, ffa_sync_send_receive_runtime(0, &msg, true));
+
+	ffa_reset_runtime_context();
+	return 0;
+}
+
+DM_TEST(dm_test_ffa_runtime_nack, UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.34.1

