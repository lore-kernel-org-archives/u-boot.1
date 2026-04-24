Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E2DFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77A0844C1;
	Sat, 25 Apr 2026 20:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="oe4R9f/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5AD5842BF; Sat, 25 Apr 2026 19:01:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A70C384394
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D42435A8;
 Fri, 24 Apr 2026 10:32:45 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.64.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45B413F7B4;
 Fri, 24 Apr 2026 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777051970; bh=0biRjWPtYnfTV7eWpIXIzANLRhwUOI+ST0UERPiKYy4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oe4R9f/b9hEhA97psgGXHY88d/TmaOmoSDqxWqJ+fe57yFEo3+q6kTrpe17WQpTMM
 /lgU3MgyHmxVdveXfkb3p+0tQljV5W4hSWPP66vwV9Uijz1HEZDBeJ2uhOnjeO/gjy
 Gmwxb/MzWgp6oKD6SYJPR/RWduoHNQAD1jlNE8Po=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH 08/12] test: dm: add sandbox FF-A runtime transport tests
Date: Fri, 24 Apr 2026 18:31:47 +0100
Message-Id: <20260424173151.371134-9-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

Add driver-model unit tests that exercise the FF-A runtime helpers on
sandbox. The new tests reuse the sandbox emulator to validate both the
positive direct-request flow and failure handling, priming the emulator
state so the runtime path can be executed.

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 arch/sandbox/include/asm/sandbox_arm_ffa.h | 16 ++++-
 test/dm/Makefile                           |  3 +-
 test/dm/ffa_runtime.c                      | 82 ++++++++++++++++++++++
 3 files changed, 99 insertions(+), 2 deletions(-)
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
 
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 771b703b737..ee1298ba572 100644
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
@@ -96,6 +96,7 @@ obj-$(CONFIG_ACPI_PMC) += pmc.o
 obj-$(CONFIG_DM_PMIC) += pmic.o
 obj-$(CONFIG_DM_PWM) += pwm.o
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += ffa.o
+obj-$(CONFIG_ARM_FFA_TRANSPORT) += ffa_runtime.o
 obj-$(CONFIG_QFW) += qfw.o
 obj-$(CONFIG_RAM) += ram.o
 obj-y += regmap.o
diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
new file mode 100644
index 00000000000..4ba859fa314
--- /dev/null
+++ b/test/dm/ffa_runtime.c
@@ -0,0 +1,82 @@
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
+static int ffa_runtime_get_sp_id(struct unit_test_state *uts, u16 *sp_id)
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
+	*sp_id = descs[0].info.id;
+	return 0;
+}
+
+static int dm_test_ffa_runtime_ack(struct unit_test_state *uts)
+{
+	struct ffa_send_direct_data msg = {0};
+	u16 sp_id;
+	u8 cnt;
+
+	ut_assertok(ffa_runtime_get_sp_id(uts, &sp_id));
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
+	/* Validate FF-A error to errno translation helpers */
+	ut_asserteq(-EINVAL, ffa_to_std_errno(-INVALID_PARAMETERS));
+	ut_asserteq(-EOPNOTSUPP, ffa_to_std_errno(-NOT_SUPPORTED));
+
+	return 0;
+}
+DM_TEST(dm_test_ffa_runtime_ack, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int dm_test_ffa_runtime_nack(struct unit_test_state *uts)
+{
+	struct ffa_send_direct_data msg = {0};
+	u16 sp_id;
+
+	ut_assertok(ffa_runtime_get_sp_id(uts, &sp_id));
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
+	return 0;
+}
+DM_TEST(dm_test_ffa_runtime_nack, UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.34.1

