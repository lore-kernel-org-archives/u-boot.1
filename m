Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA17D18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D25B3891E2;
	Tue, 15 Oct 2024 00:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hAl3EU2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A92891E2; Tue, 15 Oct 2024 00:32:39 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 273EB89248
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a3a309154aso16669895ab.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945153; x=1729549953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBpyfrMvM3+2KW+ClisdBm7vrKe8JXJEQMRroCcpewk=;
 b=hAl3EU2CNlePtwdAE6qeU1PeSAoUr0SvTVyJ3CyRkF+otWejPi6B8ZfEXtDMV7SAsu
 OdlRkgFd05PuphywnTCmtIRgNwkmVg/u158LoCLVCl1aB6CTaQVYQ7YJT8Gyv7Au90IZ
 h73g7R2tyTUvjFZ2RUs5JsEvszDEsNJLTF6Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945153; x=1729549953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBpyfrMvM3+2KW+ClisdBm7vrKe8JXJEQMRroCcpewk=;
 b=b/VouSxGSthDwtS5miOHc2lB4P4Rnv9T8v1L+ctC4U1mXmct0H8F5gUUCEjslt+o+t
 Bfk5vgyBV+hIUKIzFnFx/weaDqbJctO0eOw+R9G/bmkkOL+F4P+phcBrceB9E7vTOxov
 6iLHBNXn20qzVGFfYPPryEhIYlGjETuKDFNRLnkzHF+nSVZlq/iYVkQlh5v93wrqy8w0
 6Hio875CVd0V90p4k2PkXL60B9jikcIXPfAAP8C9v40N5WSidcsa+qqhYDRrpq1tl+Hx
 AoR1hDu6HEbSr3Ny/qnXeWx8ObO0QfQHtZmhcaWphrD/fflLj4fYafYeegUVeKZPXRa5
 AdlQ==
X-Gm-Message-State: AOJu0YzVmpa3zXlrT2+i5xF2n+Mkl5TV3d94LmobSMpg5pkT1ctw0IkG
 Ossf5K0u2Gu5T5we8559Am+/lJAIhHrQ6LHAxPoLAcXxgIEOobJGbSKxSTojIc0zw1sSsioIGqM
 pAg==
X-Google-Smtp-Source: AGHT+IEzHnI3IjV+urdjWZQyQ9Hw0/tYHrdD7nkvxi02yfej2gJYXna3pPs93HmntWbsEXcrykZpoA==
X-Received: by 2002:a05:6e02:1a0b:b0:3a0:aa15:3497 with SMTP id
 e9e14a558f8ab-3a3b5f23e86mr116201655ab.1.1728945152672; 
 Mon, 14 Oct 2024 15:32:32 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v3 18/20] x86: coreboot: Add a command to check and update
 CMOS RAM
Date: Mon, 14 Oct 2024 16:32:10 -0600
Message-Id: <20241014223212.2212442-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Avoid using common.h

 cmd/Kconfig              |  11 ++++
 cmd/x86/Makefile         |   1 +
 cmd/x86/cbcmos.c         | 139 +++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/cbcmos.rst |  42 ++++++++++++
 doc/usage/index.rst      |   1 +
 test/cmd/coreboot.c      |  41 ++++++++++++
 6 files changed, 235 insertions(+)
 create mode 100644 cmd/x86/cbcmos.c
 create mode 100644 doc/usage/cmd/cbcmos.rst

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 37894eb80d6..031a4f5e9bf 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2846,6 +2846,17 @@ config CMD_CBSYSINFO
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
index b1f39d3bfde..68029e6cad2 100644
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
index 00000000000..fe5582fbf51
--- /dev/null
+++ b/cmd/x86/cbcmos.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Support for booting from coreboot
+ *
+ * Copyright 2021 Google LLC
+ */
+
+#define LOG_CATEGORY	UCLASS_RTC
+
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
+U_BOOT_LONGHELP(cbcmos,
+	"check     - check CMOS RAM\n"
+	"cbcmos update    - Update CMOS-RAM checksum";
+);
+
+U_BOOT_CMD_WITH_SUBCMDS(cbcmos, "coreboot CMOS RAM", cbcmos_help_text,
+	U_BOOT_SUBCMD_MKENT(check, 2, 1, do_cbcmos_check),
+	U_BOOT_SUBCMD_MKENT(update, 2, 1, do_cbcmos_update));
diff --git a/doc/usage/cmd/cbcmos.rst b/doc/usage/cmd/cbcmos.rst
new file mode 100644
index 00000000000..156521dd02b
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
index 70563374899..d6c58f3dec2 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -43,6 +43,7 @@ Shell commands
    cmd/bootz
    cmd/button
    cmd/cat
+   cmd/cbcmos
    cmd/cbsysinfo
    cmd/cedit
    cmd/cli
diff --git a/test/cmd/coreboot.c b/test/cmd/coreboot.c
index 0fcf66ac71b..e1acf8697e8 100644
--- a/test/cmd/coreboot.c
+++ b/test/cmd/coreboot.c
@@ -7,10 +7,16 @@
  */
 
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
@@ -41,3 +47,38 @@ static int test_cmd_cbsysinfo(struct unit_test_state *uts)
 	return 0;
 }
 CMD_TEST(test_cmd_cbsysinfo, UTF_CONSOLE);
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
+CMD_TEST(test_cmd_cbcmos, UTF_CONSOLE);
-- 
2.34.1

