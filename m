Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2794E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893D387288;
	Mon,  2 Oct 2023 03:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DrDN+VSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AB988723F; Mon,  2 Oct 2023 03:18:48 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB9DD87284
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79faba5fe12so472568439f.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209395; x=1696814195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYOC1FFMdjyk6Uj2eBLK1Yq3rLn+SE5HQU037SnuMLg=;
 b=DrDN+VSAVF7/40cA1GiAO/Az7CLo4A55c6GgEGJ084AFyza02gKQvh+F2/tSb+VhkR
 Cq+TXWueKKcDY9diqo5+wZIW2q9NngGnU1cVXnclmeYV9J58ulUIBWW9Owg8cp32xLFO
 4v7LFggZ0tQm6FpVpJAZ3btlh7z+c8q9vFD0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209395; x=1696814195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UYOC1FFMdjyk6Uj2eBLK1Yq3rLn+SE5HQU037SnuMLg=;
 b=mTPdUA2R+0CIUedNwZEsbAaKohu/pbMT5H7Rag0uwjbNEJyYePlwt75RhkaN1wo1a9
 eg1HQt1dp11PqrHEoUi/4SGqcLodhVCmCedfa68gGn2mcFbiGlSYqybnhaUPzTYvMfOZ
 LAIuqioH+svbJMsDDIvv6X8jdZz7wJr8T1D4dIMFZVzs4w45P8kJcWqPna0Y8lL4dbvH
 FjO3Le8phjcpzVoKkcakXkOaKctt5Jq9z080W+DIUYLwSK8Rpems5RLtX+sgiBNPw7CC
 vv5s4vej9NwCnZFSN4UyovX5r60ZupFEInDDTwRhueuP0b5q3dsIdm0giw3ibTacjE6l
 fYjg==
X-Gm-Message-State: AOJu0Yw/T/21zBzIhD2UAyKLXY/Mkie6zWW6bdic1kHtc7AXFWBvlrV+
 bhrsfr1HZQ8rb06BhtMb9eJLxxsMnlvcE/nwZGA=
X-Google-Smtp-Source: AGHT+IG/rxs0M/49qIAg2JsdvJOhiUucUr7YDGOv64etM0L2D8whEJjHcQZ5SmuQrwInO0e0/kz7tw==
X-Received: by 2002:a05:6e02:1107:b0:351:2227:28d1 with SMTP id
 u7-20020a056e02110700b00351222728d1mr10982557ilk.17.1696209395275; 
 Sun, 01 Oct 2023 18:16:35 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 32/34] x86: coreboot: Add a command to check and update CMOS
 RAM
Date: Sun,  1 Oct 2023 19:15:42 -0600
Message-ID: <20231002011553.463514-33-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Coreboot tables provide information about the CMOS-RAM checksum. Add a
command which can check and update this.

With this it is possible to adjust CMOS-RAM settings and tidy up the
checksum afterwards.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig              |  11 +++
 cmd/x86/Makefile         |   1 +
 cmd/x86/cbcmos.c         | 141 +++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/cbcmos.rst |  42 ++++++++++++
 doc/usage/index.rst      |   1 +
 test/cmd/coreboot.c      |  42 ++++++++++++
 6 files changed, 238 insertions(+)
 create mode 100644 cmd/x86/cbcmos.c
 create mode 100644 doc/usage/cmd/cbcmos.rst

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 987f7d8cf623..e6977dc91bb2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2742,6 +2742,17 @@ config CMD_CBSYSINFO
 	  memory by coreboot before jumping to U-Boot. It can be useful for
 	  debugging the beaaviour of coreboot or U-Boot.
 
+config CMD_CBCMOS
+	bool "cbcmos"
+	depends on X86
+	default y if SYS_COREBOOT
+	help
+	  This provides information options to check the CMOS RAM checksum,
+	  if present, as well as to update it.
+
+	  It is useful when coreboot CMOS-RAM settings must be examined or
+	  updated.
+
 config CMD_CYCLIC
 	bool "cyclic - Show information about cyclic functions"
 	depends on CYCLIC
diff --git a/cmd/x86/Makefile b/cmd/x86/Makefile
index 5f82204c87e6..565e20776755 100644
--- a/cmd/x86/Makefile
+++ b/cmd/x86/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
+obj-$(CONFIG_CMD_CBCMOS) += cbcmos.o
 obj-y += mtrr.o
 obj-$(CONFIG_CMD_EXCEPTION) += exception.o
 obj-$(CONFIG_USE_HOB) += hob.o
diff --git a/cmd/x86/cbcmos.c b/cmd/x86/cbcmos.c
new file mode 100644
index 000000000000..8d2f85fd0ec6
--- /dev/null
+++ b/cmd/x86/cbcmos.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Support for booting from coreboot
+ *
+ * Copyright 2021 Google LLC
+ */
+
+#define LOG_CATEGORY	UCLASS_RTC
+
+#include <common.h>
+#include <command.h>
+#include <dm.h>
+#include <rtc.h>
+#include <asm/cb_sysinfo.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+const struct sysinfo_t *get_table(void)
+{
+	if (!gd->arch.coreboot_table) {
+		printf("No coreboot sysinfo table found\n");
+		return NULL;
+	}
+
+	return &lib_sysinfo;
+}
+
+static int calc_sum(struct udevice *dev, uint start_bit, uint bit_count)
+{
+	uint start_byte = start_bit / 8;
+	uint byte_count = bit_count / 8;
+	int ret, i;
+	uint sum;
+
+	log_debug("Calc sum from %x: %x bytes\n", start_byte, byte_count);
+	sum = 0;
+	for (i = 0; i < bit_count / 8; i++) {
+		ret = rtc_read8(dev, start_bit / 8 + i);
+		if (ret < 0)
+			return ret;
+		sum += ret;
+	}
+
+	return (sum & 0xff) << 8 | (sum & 0xff00) >> 8;
+}
+
+/**
+ * prep_cbcmos() - Prepare for a CMOS-RAM command
+ *
+ * @tab: coreboot table
+ * @devnum: RTC device name to use, or NULL for the first one
+ * @dep: Returns RTC device on success
+ * Return: calculated checksum for CMOS RAM or -ve on error
+ */
+static int prep_cbcmos(const struct sysinfo_t *tab, const char *devname,
+		       struct udevice **devp)
+{
+	struct udevice *dev;
+	int ret;
+
+	if (!tab)
+		return CMD_RET_FAILURE;
+	if (devname)
+		ret = uclass_get_device_by_name(UCLASS_RTC, devname, &dev);
+	else
+		ret = uclass_first_device_err(UCLASS_RTC, &dev);
+	if (ret) {
+		printf("Failed to get RTC device: %dE\n", ret);
+		return ret;
+	}
+
+	ret = calc_sum(dev, tab->cmos_range_start,
+		       tab->cmos_range_end + 1 - tab->cmos_range_start);
+	if (ret < 0) {
+		printf("Failed to read RTC device: %dE\n", ret);
+		return ret;
+	}
+	*devp = dev;
+
+	return ret;
+}
+
+static int do_cbcmos_check(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	const struct sysinfo_t *tab = get_table();
+	struct udevice *dev;
+	u16 cur, sum;
+	int ret;
+
+	ret = prep_cbcmos(tab, argv[1], &dev);
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+	sum = ret;
+
+	ret = rtc_read16(dev, tab->cmos_checksum_location / 8, &cur);
+	if (ret < 0) {
+		printf("Failed to read RTC device: %dE\n", ret);
+		return CMD_RET_FAILURE;
+	}
+	if (sum != cur) {
+		printf("Checksum %04x error: calculated %04x\n", cur, sum);
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
+static int do_cbcmos_update(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	const struct sysinfo_t *tab = get_table();
+	struct udevice *dev;
+	u16 sum;
+	int ret;
+
+	ret = prep_cbcmos(tab, argv[1], &dev);
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+	sum = ret;
+
+	ret = rtc_write16(dev, tab->cmos_checksum_location / 8, sum);
+	if (ret < 0) {
+		printf("Failed to read RTC device: %dE\n", ret);
+		return CMD_RET_FAILURE;
+	}
+	printf("Checksum %04x written\n", sum);
+
+	return 0;
+}
+
+#ifdef CONFIG_SYS_LONGHELP
+static char cbcmos_help_text[] =
+	"check     - check CMOS RAM\n"
+	"cbcmos update    - Update CMOS-RAM checksum";
+#endif /* CONFIG_SYS_LONGHELP */
+
+U_BOOT_CMD_WITH_SUBCMDS(cbcmos, "coreboot CMOS RAM", cbcmos_help_text,
+	U_BOOT_SUBCMD_MKENT(check, 2, 1, do_cbcmos_check),
+	U_BOOT_SUBCMD_MKENT(update, 2, 1, do_cbcmos_update));
diff --git a/doc/usage/cmd/cbcmos.rst b/doc/usage/cmd/cbcmos.rst
new file mode 100644
index 000000000000..156521dd02b9
--- /dev/null
+++ b/doc/usage/cmd/cbcmos.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+cbcmos
+======
+
+Synopis
+-------
+
+::
+
+    cbcmos check [<dev>]
+    cbcmos update [<dev>]
+
+
+Description
+-----------
+
+This checks or updates the CMOS-RAM checksum value against the CMOS-RAM
+contents. It is used with coreboot, which provides information about where to
+find the checksum and what part of the CMOS RAM it covers.
+
+If `<dev>` is provided then the named real-time clock (RTC) device is used.
+Otherwise the default RTC is used.
+
+Example
+-------
+
+This shows checking and updating a checksum across bytes 38 and 39 of the
+CMOS RAM::
+
+    => rtc read 38 2
+    00000038: 71 00                                            q.
+    => cbc check
+    => rtc write 38 66
+    => rtc read 38 2
+    00000038: 66 00                                            f.
+    => cbc check
+    Checksum 7100 error: calculated 6600
+    => cbc update
+    Checksum 6600 written
+    => cbc check
+    =>
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 98b4719c4088..ae908e92327a 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -40,6 +40,7 @@ Shell commands
    cmd/button
    cmd/bootz
    cmd/cat
+   cmd/cbcmos
    cmd/cbsysinfo
    cmd/cedit
    cmd/cls
diff --git a/test/cmd/coreboot.c b/test/cmd/coreboot.c
index eb3d8905986d..0c49aca9f58a 100644
--- a/test/cmd/coreboot.c
+++ b/test/cmd/coreboot.c
@@ -8,10 +8,16 @@
 
 #include <common.h>
 #include <command.h>
+#include <dm.h>
+#include <rtc.h>
 #include <test/cmd.h>
 #include <test/test.h>
 #include <test/ut.h>
 
+enum {
+	CSUM_LOC	= 0x3f0 / 8,
+};
+
 /**
  * test_cmd_cbsysinfo() - test the cbsysinfo command produces expected output
  *
@@ -42,3 +48,39 @@ static int test_cmd_cbsysinfo(struct unit_test_state *uts)
 	return 0;
 }
 CMD_TEST(test_cmd_cbsysinfo, UT_TESTF_CONSOLE_REC);
+
+/* test cbcmos command */
+static int test_cmd_cbcmos(struct unit_test_state *uts)
+{
+	u16 old_csum, new_csum;
+	struct udevice *dev;
+
+	/* initially the checksum should be correct */
+	ut_assertok(run_command("cbcmos check", 0));
+	ut_assert_console_end();
+
+	/* make a change to the checksum */
+	ut_assertok(uclass_first_device_err(UCLASS_RTC, &dev));
+	ut_assertok(rtc_read16(dev, CSUM_LOC, &old_csum));
+	ut_assertok(rtc_write16(dev, CSUM_LOC, old_csum + 1));
+
+	/* now the command should fail */
+	ut_asserteq(1, run_command("cbcmos check", 0));
+	ut_assert_nextline("Checksum %04x error: calculated %04x",
+			   old_csum + 1, old_csum);
+	ut_assert_console_end();
+
+	/* now get it to fix the checksum */
+	ut_assertok(run_command("cbcmos update", 0));
+	ut_assert_nextline("Checksum %04x written", old_csum);
+	ut_assert_console_end();
+
+	/* check the RTC looks right */
+	ut_assertok(rtc_read16(dev, CSUM_LOC, &new_csum));
+	ut_asserteq(old_csum, new_csum);
+	ut_assert_console_end();
+
+	return 0;
+}
+CMD_TEST(test_cmd_cbcmos, UT_TESTF_CONSOLE_REC);
+
-- 
2.42.0.582.g8ccd20d70d-goog

