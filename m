Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53428606A743
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0FqIUzaP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AWmYU91v
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 176AD8176A;
	Tue, 10 Nov 2026 13:07:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ne4CtTKmiwk; Tue, 10 Nov 2026 13:07:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5E4281334
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316019;
	b=VnTMHbD1lVV3FA9MZ05wL+kUcXVEO2j5NAy4N34gGBylGeg6lwRUBic6fdGNz7pvHTy1
	 Y7At1BKxacSkMvxfYeYF4zZ2D8/fNDp+wzrqNqaXcn6tKto+mvbDMIdzSuSrT3b3CEcQK
	 f6dlgitauGzDUr2mgKVce/XmQ+U6kZZGMFODMRUzVEl3SBAI+Upb66F3ZGiSmcyq3fsBN
	 3k1CaAlSjyimSj8OdjC8V+vep76JaPJ56l0qS8h4ZI9WCvunzItRygqBvdeCf+AKptyFd
	 nap4fgXmkWKwarJ+4b9bctwOX6FDJghyPQWiiHhlzqBV3mtbvAPQen/bqRzW5swH8Qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=auIrnNI0xFLRmoOB0bgMVNaQE6B8ubnDnSpBhrb8LfY=;
	b=UzwX0medL32cS8FZon2cax4qh5Q0ujJmz0fzdCMGOOdbbXygSx0+GsZJFVVX51GKBc4f
	 9CgPR/hf9XPR1gJc7n3tE6AR5VTM/5quQ221qmujBcH6aSIYIn8+vfHk2jVUs8tCvV5uF
	 BeHC2cKgPsFDFLQ2KRxtI+GnrYeW+E3hXH4gAUaMIxkCp+2ImNcnTV6XfCUSqtB/pa9lO
	 DbCHvgXfv4wcgiaWYHBqwoC3BEK/91ZJqU8xhL4EWiS7wkB2P03y/IsaMGbkldAXbTi3S
	 wLVLCV1/AKqW/oqXEfvJ9j3hKUhDiIr86hLzJpQpnpHE04sUSn99wsqSu7wCa6Rqw6w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794316019;
	bh=auIrnNI0xFLRmoOB0bgMVNaQE6B8ubnDnSpBhrb8LfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0FqIUzaP6mIc7YqV/zmtFoLDIeBez72vDRlE6awNgNXmZ4+s7g6an6Z4bnkYjatH1
	 AwEoKqHGvP0HEF6ygMlPwdJ9hzON1Hv0HWpxgynag6LYF8sk9x8aKtTcYh1d6MfVui
	 w6/LlyH71IQHha0oHaADvqY/zLl5U3/Db5cjr0Dd040d29Agxz3eM4orTdiEBLe3FK
	 cR+82f/PigVr+UHyWYza+uJIheBte+l/uXFYUptXeCEAWyXDRVCHO8k3ghu63Wb3VM
	 USFc2hRkq9WaOCvKAI9FslQ1HCAsI7pT8miUENzrxjRc52mBZX+DayR45bYPHckuyV
	 hX5Iy7lJdrs7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5E4281334;
	Tue, 10 Nov 2026 13:06:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE45D2FE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4C8E40347
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FpbwpMxzX0bf for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BE53740346
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=AWmYU91v
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE53740346
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE2E81516;
 Tue, 10 Nov 2026 01:58:38 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A14AA3F632;
 Tue, 10 Nov 2026 01:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304721; bh=UoO4LuSVzS+SA4EFSl1lqwZyiKQcMSpoQWqUCfVB62c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AWmYU91vJE6hRnagIC+PuJkOqF1CqEHlX39W1EoDDbZPJRYVJciFNLT+oK6RmjUfH
 2TK+OiBROufV//daf0nQfu9eg9i7SAIOc1fEBC4bGm+AAMtY1Mp8ODgsb4LohDf09u
 Hxl7Hledtaj9uymrwxZk0jJv5fgPxxWG8F63qGn0=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 20/22] test: dm: add sandbox FF-A runtime transport tests
Date: Tue, 10 Nov 2026 09:58:01 +0000
Message-ID: <80e2bc5e54c1edc80b6f7d8c1e3ae10f47f96873.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changelog:
===============

v3:

Simon:

- Drop (void)uts; from dm_test_ffa_to_std_errno()
- Refactor the repeated runtime setup/reset flow into shared helpers
- Use 0xffff in the nack test to hit the intended invalid-SP path
- Remove the stray blank line in the sandbox partition table

v2:

Simon:

- Drop unused `sp_id` handling from the negative-path test
- Add no-context `-EPERM` coverage
- Reset the FF-A runtime context between tests
- Split errno-mapping checks into a dedicated DM test
- Add invalid-input boundary coverage
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
index 1b3a20aa932..45b0424062c 100644
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
@@ -119,6 +119,7 @@ obj-$(CONFIG_CMD_PMBUS) += pmbus.o
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
2.43.0

