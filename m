Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6579ACC6B2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E8FA40858;
	Wed, 14 Oct 2026 20:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kPR8mNH0gWf9; Wed, 14 Oct 2026 20:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C67F240817
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008240;
	b=jRISOwzeEweEa6ZR2KNkkEL2IEJHWBJuKw4OpiepOTRYIFyHG4njotzEXPHc+J+PWffH
	 YRu3r4LM3EyV9tiJguATTenhiLsMzeS7doqoMl7mYvqoakHAFDZS9m0DHdvuwlaBYIfkI
	 vYBIBl5St2diXupD1RBmthGLAk//3xvXH11AnX+LYIXeOOGNG4iunvx5J0++yt07obTmd
	 Iy3GdEabKgwz6OawePYZLUVJoee6EV/Jv8wqirJB/vQomXkdXOKGlqAF5GeJ+J9rZmdS8
	 u34SFk8gTft9HbS6uH4lCAUu4X5ymyH8Y73U1CWTv2zdDEWEP9SbKuW0yOapXz1uxIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QhmNVB4XK1Z4Iu+I5OtEANaSQgXBz1GFGoeuL2Dn3XI=;
	b=k1w4tE7o7IhbXdMxAEDM7SkiksmEKykdgs4DEDoveXSzbn8fSrQEMFuRzSUoc6Ge7AgF
	 B4JZI1p2C0CXMXBHBtRXoq0w9xitCc4bk/1UTbbgF+f+cKeHk2dWRaupvnH0tou7RkNVk
	 XHn94fGBZ3QiSP514XOhtGPxoX1sdIPr0GRTEzG+OMQ473jHoUSEgL5eqK8nW3//0/FJC
	 eZGdHCt4tfk2H9nh1zeC+uyCXcBJg6+FMTykAB9JRZansue9pFlySYgCi0KDpV2CchBxS
	 3GnDiscb8r4AeQ1Da8RQJVR+T83WUVUsMXtuQ1JgIOjMNV2TES9YB+B7eTyUKbZvDdA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008239;
	bh=QhmNVB4XK1Z4Iu+I5OtEANaSQgXBz1GFGoeuL2Dn3XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uBJH8Rzgx9uZi9pTeKRD20qaNIEpoX0MiEp/RTD/hGWcf0werERNYenC0sqhKzP/B
	 armfhdbsJL8wn9ykr5F27arGThxwMpOemBrqRskNkZU+pB9kwYq/3/6gIrpoPBDIdz
	 HXQHY2CmiJMlYUuyMP+FKqVARfBnBf488FCR49JoEPXUP5e8C9uozxhvSDJTDj7VLu
	 h/e4szYPz1wi7/L+Ig0Cnlk+zhLdm4Koky7gYqW1Ic6AT09587ETpYEV343neHLE1/
	 FbsKtZlvMBiubNefyM/9cn4aB1k2mhjPhCNCYQm+QDcgo8LgewvKUadjevuMnUktcU
	 P0NWOIzaU0fXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C67F240817;
	Wed, 14 Oct 2026 20:03:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AF781DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D1D360840
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n2uTh9rVheyo for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A2EA607DE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002224;
 b=iW/GkgP7+mkMPnYFcbxzWhA0Dn44GcM7wMm91v/giPIYWd/89N9Iyc40JBl/ZXqia5Df
 XNtm86KU894Kjsud5my0SRbFRWuuzmxoetd4DO6RIgSvcLap+KFcBAYiGXNHvDxRuHbGE
 Z2WAvyuopQ4ZvbrstR5ysGu/FCHOt4FMTOX5/gKLFFoOyRNXJJlpP+gqW5eFdIHrwlsef
 EIZEuDmf2DGbttujwBMl3TKMggHNbmCFVKclNNnUaIo8++Z6VKx6oEtrbzKHfSXE6JIYM
 ajSyC4jOWHsemY8j3FLlmg6y67Q7xoqOW7BTfMtZ5GDi82wxF88/T05OMl6QdxcNoTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002224;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=QhmNVB4XK1Z4Iu+I5OtEANaSQgXBz1GFGoeuL2Dn3XI=;
 b=W3dLz08ALvH/7LByibKAIeFZ2Keh9mgj17azAPWdHS572O0uaQz4je17USDT9OpZ2TFB
 NLUO18AAcb/9I1/1+xH7iRcTfBTR34PYMjx5IRspxsPd78TIxiWExc4srH/V86mKWirHK
 h/9l6eAn9cXRQDp6Y0yBh18LGv6x2aOQR61pisuhxKU2TJ3Ony3YUTIoovDsUZN4GOK2F
 870D3plvo4y1/AGfFF+ZPP0Rk4kr2yw9cT3knnZy1gPTUNZuxxrhDb9wg416SHK5PToY9
 Xo1ryGMHvjKApk0djE2hA+evgQebF9TYG4+GzbVweilFAX60DE0+9Gfyf96TIX0iJOA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=ANmti9ai; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=ANmti9ai
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A2EA607DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F23153B;
 Wed, 14 Oct 2026 11:23:40 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6B703F871;
 Wed, 14 Oct 2026 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002224; bh=Yv6YMqRnaAeg7R9jejLPimiNpMWowv5/epWO0N2FPqA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ANmti9aivImdLvIclX6whg+FvQjSEyfW10wJdrT8cEBZW487VpQWFs27ZPuayO5VR
 ieUHYL2QcC1SnwaMNWatC4/BDX4YuTQ5aR+9Wm2rS2SzoW7ptpNWibbUpkYx0XkrUS
 ECpp9Qec4OL07oL1yhlD1p+vCRbbWrmoAiNLqL6A=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 20/22] test: dm: add sandbox FF-A runtime transport tests
Date: Wed, 14 Oct 2026 19:23:00 +0100
Message-ID: <bdf27e78fa9e32b047658b93d7d2e88110c4f475.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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
index 76aa1fff9ba..2c213c95a09 100644
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
@@ -99,6 +99,7 @@ obj-$(CONFIG_CMD_PMBUS) += pmbus.o
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

