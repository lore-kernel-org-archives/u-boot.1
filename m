Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76407E66882
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A267D89440;
	Sat, 23 Nov 2024 22:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18177893AA; Sat, 23 Nov 2024 20:58:07 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F21C891B4
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 20:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: from fedora.. (23-93-16-71.fiber.dynamic.sonic.net [23.93.16.71])
 by cavan.codon.org.uk (Postfix) with ESMTPSA id B41D0407DD;
 Sat, 23 Nov 2024 19:57:42 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: u-boot@lists.denx.de
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/10] Add command to set an environment variable to an EFI
 variable
Date: Sat, 23 Nov 2024 11:55:09 -0800
Message-ID: <20241123195616.305687-11-mjg59@srcf.ucam.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241123195616.305687-1-mjg59@srcf.ucam.org>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 23 Nov 2024 22:49:00 +0100
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

From: Matthew Garrett <mgarrett@aurora.tech>

We may want to make things conditional on EFI variable state

Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
---

 cmd/Kconfig     |   4 ++
 cmd/Makefile    |   1 +
 cmd/efigetenv.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 cmd/efigetenv.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 33bf3d1ad39..118fb721081 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -752,6 +752,10 @@ config CMD_NVEDIT_SELECT
 	help
 	  Select the compiled-in persistent storage of environment variables.
 
+config CMD_EFI_GET_ENV
+	bool "efi get env"
+	help
+	  Set an environment variable to the contents of an EFI variable
 endmenu
 
 menu "Memory commands"
diff --git a/cmd/Makefile b/cmd/Makefile
index 38cb7a4aea5..0507c204c0e 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_CMD_EEPROM) += eeprom.o
 obj-$(CONFIG_EFI) += efi.o efi_common.o
 obj-$(CONFIG_CMD_EFIDEBUG) += efidebug.o efi_common.o
 obj-$(CONFIG_CMD_EFICONFIG) += eficonfig.o
+obj-$(CONFIG_CMD_EFI_GET_ENV) += efigetenv.o
 ifdef CONFIG_CMD_EFICONFIG
 ifdef CONFIG_EFI_MM_COMM_TEE
 obj-$(CONFIG_EFI_SECURE_BOOT) += eficonfig_sbkey.o
diff --git a/cmd/efigetenv.c b/cmd/efigetenv.c
new file mode 100644
index 00000000000..5284ee92d6c
--- /dev/null
+++ b/cmd/efigetenv.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <charset.h>
+#include <command.h>
+#include <efi_loader.h>
+#include <efi_variable.h>
+#include <env.h>
+#include <hexdump.h>
+#include <malloc.h>
+#include <uuid.h>
+
+/* Set a U-Boot environment variable to the contents of a UEFI variable */
+int do_efi_get_env(struct cmd_tbl *cmdtb, int flat, int argc, char *const argv[])
+{
+	u16 *var_name = NULL;
+	char *strdata = NULL;
+	efi_uintn_t size = 0;
+	bool var_content_is_utf16_string = false;
+	efi_status_t ret;
+	efi_guid_t guid;
+	u8 *data = NULL;
+	u32 attributes;
+	size_t len;
+	u64 time;
+	u16 *p;
+
+	ret = efi_init_obj_list();
+	if (ret != EFI_SUCCESS) {
+		printf("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+		       ret & ~EFI_ERROR_MASK);
+		return CMD_RET_FAILURE;
+	}
+
+	argv++;
+	argc--;
+
+	if (argc != 3 && argc != 4)
+		return CMD_RET_USAGE;
+
+	if (argc == 4) {
+		if (strcmp(argv[0], "-s"))
+			return CMD_RET_USAGE;
+		var_content_is_utf16_string = true;
+		argv++;
+		argc--;
+	}
+
+	len = utf8_utf16_strnlen(argv[0], strlen(argv[0]));
+	var_name = malloc((len + 1) * 2);
+	if (!var_name) {
+		printf("## Out of memory\n");
+		return CMD_RET_FAILURE;
+	}
+	p = var_name;
+	utf8_utf16_strncpy(&p, argv[0], len + 1);
+
+	if (uuid_str_to_bin(argv[1], guid.b, UUID_STR_FORMAT_GUID)) {
+		ret = CMD_RET_USAGE;
+		goto out;
+	}
+
+	ret = efi_get_variable_int(var_name, &guid, &attributes, &size, data,
+				   &time);
+	if (ret == EFI_BUFFER_TOO_SMALL) {
+		data = malloc(size);
+		if (!data) {
+			printf("## Out of memory\n");
+			ret = CMD_RET_FAILURE;
+			goto out;
+		}
+		ret = efi_get_variable_int(var_name, &guid, &attributes,
+					   &size, data, &time);
+	}
+
+	if (ret == EFI_NOT_FOUND) {
+		printf("Error: \"%ls\" not defined\n", var_name);
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	if (ret != EFI_SUCCESS) {
+		printf("Error: Cannot read variable, r = %lu\n",
+		       ret & ~EFI_ERROR_MASK);
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	if (var_content_is_utf16_string) {
+		char *p;
+
+		len = utf16_utf8_strnlen((u16 *)data, size / 2);
+		strdata = malloc(len + 1);
+		if (!strdata) {
+			printf("## Out of memory\n");
+			ret = CMD_RET_FAILURE;
+			goto out;
+		}
+		p = strdata;
+		utf16_utf8_strncpy(&p, (u16 *)data, size / 2);
+	} else {
+		len = size * 2;
+		strdata = malloc(len + 1);
+		if (!strdata) {
+			printf("## Out of memory\n");
+			ret = CMD_RET_FAILURE;
+			goto out;
+		}
+		bin2hex(strdata, data, size);
+	}
+
+	strdata[len] = '\0';
+
+	ret = env_set(argv[2], strdata);
+	if (ret) {
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	ret = CMD_RET_SUCCESS;
+out:
+	free(strdata);
+	free(data);
+	free(var_name);
+
+	return ret;
+}
+
+U_BOOT_CMD(
+	efigetenv, 5, 4, do_efi_get_env,
+	"set environment variable to content of EFI variable",
+	"[-s] name guid envvar\n"
+	"    - set environment variable 'envvar' to the EFI variable 'name'-'guid'\n"
+	"      \"-s\": Interpret the EFI variable value as a UTF-16 string\n"
+);
-- 
2.47.0

