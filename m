Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8829CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5AC86E42;
	Tue, 12 Sep 2023 11:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JzLBIcL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2829C86E69; Tue, 12 Sep 2023 11:47:41 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 713EF86E46
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id C4467212BC1A;
 Tue, 12 Sep 2023 02:47:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C4467212BC1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694512052;
 bh=hTUCQ2YcfYdRt391q4RvhxRkdCTAgZJ+oV2hrjSi81k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JzLBIcL3gxrhrVM46dMgmd4PMG1+Wf3NMUxiM2tcCtdoh3MQeObVeOpdACfVk6v3q
 psyDbRZ0jaQt3z1d91eHLnDqjJn4uXmaQDzeqVR9tquzGGfJN4mTIYUUGz8ugCRshv
 /YxHdKbashfjptVhd/zZQu205C86HtlNi5FbeETQ=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, stcarlso@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH 5/8] dm: test: Add a test for rollback driver
Date: Tue, 12 Sep 2023 02:47:28 -0700
Message-Id: <20230912094731.51413-6-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sean Edmond <seanedmond@microsoft.com>

Adds a test for a sandbox and TPM backed rollback driver.

Allows for testing of anti-rollback version number get/set API using the
rollback driver.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 arch/sandbox/dts/test.dts |  9 +++++
 configs/sandbox_defconfig |  3 ++
 test/dm/Makefile          |  1 +
 test/dm/rollback.c        | 78 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 test/dm/rollback.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index f351d5cb84..1226bad6a6 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1263,6 +1263,10 @@
 		backlight = <&backlight 0 100>;
 	};
 
+	rollback@0 {
+		compatible = "sandbox,rollback";
+	};
+
 	scsi {
 		compatible = "sandbox,scsi";
 		sandbox,filepath = "scsi.img";
@@ -1376,6 +1380,11 @@
 
 	tpm2 {
 		compatible = "sandbox,tpm2";
+
+		rollback@1 {
+			compatible = "tpm,rollback";
+			rollback-nv-index = <0x1001007>;
+		};
 	};
 
 	tpm {
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 1cd1c2ed7c..f2bd10fbf0 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -346,3 +346,6 @@ CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
 CONFIG_ARM_FFA_TRANSPORT=y
+CONFIG_DM_ROLLBACK=y
+CONFIG_ROLLBACK_SANDBOX=y
+CONFIG_ROLLBACK_TPM=y
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 7ed00733c1..3875ec4f4b 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_DM_RNG) += rng.o
 obj-$(CONFIG_DM_RTC) += rtc.o
 obj-$(CONFIG_SCMI_FIRMWARE) += scmi.o
 obj-$(CONFIG_SCSI) += scsi.o
+obj-$(CONFIG_DM_ROLLBACK) += security.o
 obj-$(CONFIG_DM_SERIAL) += serial.o
 obj-$(CONFIG_DM_SPI_FLASH) += sf.o
 obj-$(CONFIG_SIMPLE_BUS) += simple-bus.o
diff --git a/test/dm/rollback.c b/test/dm/rollback.c
new file mode 100644
index 0000000000..a2984797f9
--- /dev/null
+++ b/test/dm/rollback.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 Microsoft Corporation
+ * Written by Sean Edmond <seanedmond@microsoft.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <rollback.h>
+#include <log.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/*
+ * get_rollback() - Get a rollback driver of a given driver name
+ *
+ * @devp: Returns the rollback device
+ * @driver_name: Driver name to find
+ * Returns: 0 if OK, -ENODEV if not found
+ */
+static int get_rollback(struct udevice **devp, char *driver_name)
+{
+	struct udevice *dev;
+
+	uclass_foreach_dev_probe(UCLASS_ROLLBACK, dev) {
+		if (strcmp(dev->driver->name, driver_name) == 0) {
+			*devp = dev;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+/* Basic test of rollback driver Anti rollback version number read/write */
+static int test_rollback_idx(struct unit_test_state *uts, char *driver_name)
+{
+	struct udevice *dev;
+	u64 rollback_idx;
+
+	/* get the rollback driver */
+	ut_assertok(get_rollback(&dev, driver_name));
+
+	/* ensure initial value is 0 */
+	rollback_idx_get(dev, &rollback_idx);
+	ut_asserteq(0, rollback_idx);
+
+	/* write 1 and ensure it's read back */
+	rollback_idx_set(dev, 1);
+	rollback_idx_get(dev, &rollback_idx);
+	ut_asserteq(1, rollback_idx);
+
+	/* write all ones and ensure it's read back */
+	rollback_idx_set(dev, 0xffffffffffffffffULL);
+	rollback_idx_get(dev, &rollback_idx);
+	ut_asserteq(0xffffffffffffffffULL, rollback_idx);
+
+	return 0;
+}
+
+static int dm_test_rollback_sandbox(struct unit_test_state *uts)
+{
+	ut_assertok(test_rollback_idx(uts, "rollback_sandbox"));
+
+	return 0;
+}
+
+DM_TEST(dm_test_rollback_sandbox, UT_TESTF_SCAN_FDT);
+
+static int dm_test_rollback_tpm(struct unit_test_state *uts)
+{
+	ut_assertok(test_rollback_idx(uts, "rollback_tpm"));
+
+	return 0;
+}
+
+DM_TEST(dm_test_rollback_tpm, UT_TESTF_SCAN_FDT);
-- 
2.40.0

