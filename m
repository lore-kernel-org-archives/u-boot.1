Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF209C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 15:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83F068796D;
	Tue, 24 Oct 2023 17:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="FxgEWnAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FAF487977; Tue, 24 Oct 2023 17:44:14 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7D908727A
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 17:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFZDp6032389; Tue, 24 Oct 2023 15:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ua1yW6j40rLh55Sk/D86WXaccrzEG/eqN2OvedgMLc4=;
 b=FxgEWnAqM/TtyjRfP5RU9spGLyyRp+VQIZIVMB/MKVThU28g+KvHz7qKID+x942yZ3Ry
 xc8relTeO4pR10WReJZlOTUMf3S8RImzGEXIBBTKSPvLyIDPrv7fvwoVSci9eMztbDSE
 nhECt5v0QGjpdLQJQwKHJTchUHXYAPNrAA2E82asENq59hwEWwQ3E+xQteBkxdfQU/WD
 5wKEzpGcjphCcu4UKEInlneoB5lTEbWZl+QpHZdIpmEpW5T+mxVMxCUd+/VOlljA6tqP
 rPMZBMJ4j2GUTaMZmY+VsHWsLaJolxpHTEx9DkE9etQHNVDYNMHl+xdPucjjNMdRa3l4 Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgpr8gd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:59 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OFZBhK032323;
 Tue, 24 Oct 2023 15:43:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgpr8g9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFJvTO012362; Tue, 24 Oct 2023 15:43:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvup1qyf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:56 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OFhutQ33554922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 15:43:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DA0A58043;
 Tue, 24 Oct 2023 15:43:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07B1F5805D;
 Tue, 24 Oct 2023 15:43:56 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.72.218])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 15:43:55 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v14 5/8] test: Add sandbox TPM boot measurement
Date: Tue, 24 Oct 2023 10:43:51 -0500
Message-Id: <20231024154354.197524-6-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231024154354.197524-1-eajames@linux.ibm.com>
References: <20231024154354.197524-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lJdrLB5OayL_PZFFATGvCiw_1q73IJcr
X-Proofpoint-ORIG-GUID: A_4cECvho9CNtFuGBt912hW0QbI1Q9Uf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240135
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

Use the sandbox TPM driver to measure some boot images in a unit
test case.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v5:
 - Only compile in the measurement u-boot command when
   CONFIG_MEASURED_BOOT is enabled.

 arch/sandbox/dts/sandbox.dtsi | 13 +++++++
 arch/sandbox/dts/test.dts     | 13 +++++++
 configs/sandbox_defconfig     |  1 +
 include/test/suites.h         |  1 +
 test/boot/Makefile            |  1 +
 test/boot/measurement.c       | 66 +++++++++++++++++++++++++++++++++++
 test/cmd_ut.c                 |  4 +++
 7 files changed, 99 insertions(+)
 create mode 100644 test/boot/measurement.c

diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index ff7e5584c5..241f397ba6 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -4,11 +4,23 @@
  * and sandbox64 builds.
  */
 
+#include <config.h>
 #include <dt-bindings/input/input.h>
 
 #define USB_CLASS_HUB			9
 
 / {
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		event_log: tcg_event_log {
+			no-map;
+			reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
+		};
+	};
+
 	binman {
 	};
 
@@ -342,6 +354,7 @@
 
 	tpm2 {
 		compatible = "sandbox,tpm2";
+		memory-region = <&event_log>;
 	};
 
 	triangle {
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index e430347356..67159b3d01 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -9,6 +9,7 @@
 
 /dts-v1/;
 
+#include <config.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/sandbox-gpio.h>
 #include <dt-bindings/input/input.h>
@@ -68,6 +69,17 @@
 		osd0 = "/osd";
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		event_log: tcg_event_log {
+			no-map;
+			reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
+		};
+	};
+
 	binman: binman {
 	};
 
@@ -1423,6 +1435,7 @@
 
 	tpm2 {
 		compatible = "sandbox,tpm2";
+		memory-region = <&event_log>;
 	};
 
 	tpm {
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 47417cb039..757dcac4ca 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -349,3 +349,4 @@ CONFIG_TEST_FDTDEC=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
+CONFIG_MEASURED_BOOT=y
diff --git a/include/test/suites.h b/include/test/suites.h
index 1c7dc65966..48ed549c13 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -45,6 +45,7 @@ int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
+int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/test/boot/Makefile b/test/boot/Makefile
index 52947580ae..068522cb9e 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
 obj-$(CONFIG_FIT) += image.o
+obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
 obj-$(CONFIG_EXPO) += expo.o
 obj-$(CONFIG_CEDIT) += cedit.o
diff --git a/test/boot/measurement.c b/test/boot/measurement.c
new file mode 100644
index 0000000000..9db2ed324c
--- /dev/null
+++ b/test/boot/measurement.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for measured boot functions
+ *
+ * Copyright 2023 IBM Corp.
+ * Written by Eddie James <eajames@linux.ibm.com>
+ */
+
+#include <common.h>
+#include <bootm.h>
+#include <malloc.h>
+#include <test/suites.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <asm/io.h>
+
+#define MEASUREMENT_TEST(_name, _flags)	\
+	UNIT_TEST(_name, _flags, measurement_test)
+
+static int measure(struct unit_test_state *uts)
+{
+	struct bootm_headers images;
+	const size_t size = 1024;
+	u8 *kernel;
+	u8 *initrd;
+	size_t i;
+
+	kernel = malloc(size);
+	initrd = malloc(size);
+
+	images.os.image_start = map_to_sysmem(kernel);
+	images.os.image_len = size;
+
+	images.rd_start = map_to_sysmem(initrd);
+	images.rd_end = images.rd_start + size;
+
+	images.ft_addr = malloc(size);
+	images.ft_len = size;
+
+	env_set("bootargs", "measurement testing");
+
+	for (i = 0; i < size; ++i) {
+		kernel[i] = 0xf0 | (i & 0xf);
+		initrd[i] = (i & 0xf0) | 0xf;
+		images.ft_addr[i] = i & 0xff;
+	}
+
+	ut_assertok(bootm_measure(&images));
+
+	free(images.ft_addr);
+	free(initrd);
+	free(kernel);
+
+	return 0;
+}
+MEASUREMENT_TEST(measure, 0);
+
+int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	struct unit_test *tests = UNIT_TEST_SUITE_START(measurement_test);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(measurement_test);
+
+	return cmd_ut_category("measurement", "measurement_test_", tests,
+			       n_ents, argc, argv);
+}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 477d475952..32d270fc89 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -99,6 +99,10 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #if CONFIG_IS_ENABLED(UT_UNICODE) && !defined(API_BUILD)
 	U_BOOT_CMD_MKENT(unicode, CONFIG_SYS_MAXARGS, 1, do_ut_unicode, "", ""),
 #endif
+#ifdef CONFIG_MEASURED_BOOT
+	U_BOOT_CMD_MKENT(measurement, CONFIG_SYS_MAXARGS, 1, do_ut_measurement,
+			 "", ""),
+#endif
 #ifdef CONFIG_SANDBOX
 	U_BOOT_CMD_MKENT(compression, CONFIG_SYS_MAXARGS, 1, do_ut_compression,
 			 "", ""),
-- 
2.39.3

