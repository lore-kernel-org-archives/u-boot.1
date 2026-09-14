Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A4EC88E75
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1B4E6074F;
	Mon, 14 Sep 2026 14:18:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SPYle2L8J34g; Mon, 14 Sep 2026 14:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A35A360702
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395489;
	b=Ohrxe4riflAwg7W8nA+DKQtb2ObOfBXF6BRhAla4Kd5hlcCsTsrKqGhsVG6XLdhnouOM
	 IepaEqs7lrzU7LS/xI03ryw6AWFkElolBwP+ShLtnwi7s6o+s7R0WvT1dCvtDCXxcnCIv
	 MLW9+aHhfqMO36f6Tf0TCh5NCYVwBWfvP93MYR9rf1IsGA36lDNPKdaQMNpoy5ptx2B2q
	 z8FMdsCW6pCqqgQoNzR7/VKVRpyNSMqTYgYVT82IwjVa01RcfyPFkZyNXcmYUEjoDC4OC
	 TIUGBPoXUTa4ykmp+skF1fu7GTDsJ3IzMRt7OJHeUDDrWSVQ/bnEBf3OH/O8HGgDILw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395489;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ul2qNMz3vChvvKo1otzkxwqYsstVw3k+HneFNsy97lk=;
	b=QxfjZn7yvfQ0zqDaHHZhM7XfUT/0CyX+NNBCiuFr+BjcP/ias/8y3G0eCzmWrerIzh/9
	 gw9sBRYZAGuedwLr4GsaCXX36pTkGLyMg1uprbVRtZwB7gb1QEx9iEpk8qi5xJpWZluSO
	 yjZ4Lb1N8uS/I2aG7xkkp2BtDsg9YXhHt6zzXqJK6PeE9zE/2PJXTQlh31itIxsq0f9t+
	 GtM410tCv0ppnNAXoqTHDomqFM4e0fZOPlZIyP16q0GGgruoBA5rvHWziUXj6Fgzr0rs3
	 oYCgVMveJ0x5CrtpWe/MLGX9CAsQlCzLzO6WPTz/w1zs9lsvXyY905PT3n+9uhLC8Wg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NRGNe7cI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395489;
	bh=Ul2qNMz3vChvvKo1otzkxwqYsstVw3k+HneFNsy97lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HWmPigPvbfC5mHlBWVfRexRxCXcsUiAUV4u5nuBlRt/qmixA97fZGdQ0KuyohVaQq
	 hJCA814GjxYbUcX1R1s7VBzXI639Q9vypAS7t+gmHPpxLhXG8ZInvnm8SArunPojLG
	 eLyFMjssM0waRqpJiA1Z9b0RF7/lu+m47bqTbcEB5bojmXPR5K9UXyxDvdU/blkLut
	 yJRQocP5HTMtPsHbWdElwrxVZOLzmro7uiVuIps1hNZJlH8iPrnkPE2rP81oKDk9M7
	 JxP7qxWWbp38vg7gHG0l+nUxdCIf6kUsp96u9IBEq7k/AzMPlv+UV2VMoGF6jncjJf
	 D9y57m7CHK7Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A35A360702;
	Mon, 14 Sep 2026 14:18:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E92EE49D
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CEEF4605EF
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Sg7vbHAxEz7 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 595056068C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=RgMFBiOi/dnJjExAYhKQWJ3vQwIcN/VjN33TfZEMeJE6D7dioHJ3uneD02bNQylrSNN2
 FQrQjdlPBEx//oyQddqFjqiMiczJeotO41KOwRmPO6CvSDZ/ctonAcGAkX5QBACF91hBD
 +ihAtBuUEJhn0UMpma+NGF0H5xYllvUnHHIGdj8zg/22tJnZDzCcw1uvnAB0WCbCLbdUd
 KeAjzNGSlUIKuMFx6Oj82j0pn9cnLwVpOHjiVoU3vwOqHNyodymjkiFYLaFcyd2AnHbAy
 JBHqa8R0/oW/kGS44kc7I0XKUmJJPBWuXfSB4uZhxj0IjTfexSRzxzB4LyYk0iUO+Qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Ul2qNMz3vChvvKo1otzkxwqYsstVw3k+HneFNsy97lk=;
 b=QZxA6DE/nmsPL6PRoPdpW3ZisLEJ4BLimdLW5wywEEMmmZ1eECg2GzwRMQqJrhM0F0k+
 Y6dRUVkRj4vG5b1R2URgs0VMugWTwiU4JuW/ADXqgixbRFoYtiadA0Cgk5vrgbwaP2f0g
 CKGyD7/x3scnfwuoOxeAXALzOK1JxdHnQx8iy27amwitXbuD169/fCV+DzOcZr8/5M0p6
 99y+vLq5ESuey85Gp9+tF/Vgc2a823Xrihn+B9/kzwToGP0y5e6I0sPZNS2EgmOFEmxyI
 gjRGS9uvIQQNOuxU3u9ZJn+3q8DJoBzn9w3uHvPdri2v/cxQPO7SsCOek8bcIyol93Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=NRGNe7cI; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=NRGNe7cI
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 595056068C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D2362C27;
 Mon, 14 Sep 2026 04:02:00 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66BCD3F86F;
 Mon, 14 Sep 2026 04:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383724; bh=r7zSDZ7Ue7o1LSQq1GwGxqI6eGch3Yt+8RtG0SPrKt0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NRGNe7cI0uMk0A4RbNftsv86xhS92wZMDYrDci4Uo5GEnVRLfs+Y4ZW14DpO1k2CE
 ofoXf2hlfNMWJgbW3R+PQoBm3OdhVyxf7CZ9aW3G8gGz7N8qgnIV32uv+mBRTHsBV/
 8uIdK0sMo7+pwEHP2hA5s8IKHOP1Gn5bbR9eAQ5w=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 20/22] test: dm: add sandbox FF-A runtime transport tests
Date: Mon, 14 Sep 2026 12:01:04 +0100
Message-Id: <20260914110106.1974894-21-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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
2.34.1

