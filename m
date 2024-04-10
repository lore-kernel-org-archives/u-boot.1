Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C036CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 13:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC9B8819D;
	Wed, 10 Apr 2024 15:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="OLy7UaWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87DBF88122; Wed, 10 Apr 2024 12:58:22 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E20B881A8
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 12:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 17E19100066;
 Wed, 10 Apr 2024 13:58:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 17E19100066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1712746700;
 bh=YqklVJ3ljCK2xpvsgVPq80U/Es/fJ4X+0cYLgdhbQVQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=OLy7UaWDLKPZ3EVLWJHwbyGDJjKwACwEq5Nz0Q192WkWcGYNfq+pfFnOZ4/VEa1c4
 LB+GJmXCWKxEDCiYJoXnN2DPntr5jSNx7CHajnQhaYPSZ/fE/UC/UTWiMAt341+Rze
 ovVJw4K7NhsH0GUHExpN7SjlR4awV2YUZytjJi9TblDEQ5n7Mvn7bNDV3MejvDT047
 1djde7Dccqd1uzBiaoGLxKpgMlz6aWfIUVz9fwZBTEzpGDY+GD5+qc1tYKJHZz/0Wr
 U+l1GH7ItpVoNNIhA/yQAHBa5HRTA7goxmTdkgE3AB0k2FSFJtzYfCXsV6A6C+JWay
 90r8EF0qyRjww==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 10 Apr 2024 13:58:19 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Apr 2024 13:58:18 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <sjg@chromium.org>, <hs@denx.de>, <sean.anderson@seco.com>,
 <dimorinny@google.com>, <mkorpershoek@baylibre.com>,
 <patrick.delaunay@foss.st.com>, <quentin.schulz@theobroma-systems.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v4 1/1] fastboot: introduce 'oem board' subcommand
Date: Wed, 10 Apr 2024 13:58:04 +0300
Message-ID: <20240410105804.22757-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410105804.22757-1-avromanov@salutedevices.com>
References: <20240410105804.22757-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184650 [Apr 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16
 6e64c33514fcbd07e515710c86ba61de7f56194e,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 100.64.160.123:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/10 06:59:00 #24735327
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 10 Apr 2024 15:04:14 +0200
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

Currently, fastboot protocol in U-Boot has no opportunity
to execute vendor custom code with verifed boot. This patch
introduce new fastboot subcommand fastboot oem board:<cmd>,
which allow to run custom oem_board function.

Default implementation is __weak. Vendor must redefine it in
board/ folder with his own logic.

For example, some vendors have their custom nand/emmc partition
flashing or erasing. Here some typical command for such use cases:

- flashing:

  $ fastboot stage bootloader.img
  $ fastboot oem board:write_bootloader

- erasing:

  $ fastboot oem board:erase_env

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 doc/android/fastboot.rst      | 18 ++++++++++++++++++
 drivers/fastboot/Kconfig      |  7 +++++++
 drivers/fastboot/fb_command.c | 30 ++++++++++++++++++++++++++++++
 include/fastboot.h            |  1 +
 4 files changed, 56 insertions(+)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 1ad8a897c8..2a627f9890 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -29,6 +29,7 @@ The following OEM commands are supported (if enabled):
   with <arg> = boot_ack boot_partition
 - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure eMMC
 - ``oem run`` - this executes an arbitrary U-Boot command
+- ``oem board`` - this executes a custom board function which is defined by the vendor
 
 Support for both eMMC and NAND devices is included.
 
@@ -245,6 +246,23 @@ including multiple commands (using e.g. ``;`` or ``&&``) and control structures
 (``if``, ``while``, etc.). The exit code of ``fastboot`` will reflect the exit
 code of the command you ran.
 
+Running Custom Vendor Code
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+U-Boot allows you to execute custom fastboot logic, which can be defined
+in board/ files. It can still be used for production devices with verified
+boot, because the vendor define logic at compile time by implementing
+fastboot_oem_board() function. The attacker will not be able to execute
+custom commands / code. For example, this can be useful for custom flashing
+or erasing protocols::
+
+    $ fastboot stage bootloader.img
+    $ fastboot oem board:write_bootloader
+
+In this case, ``cmd_parameter`` argument of the function ``fastboot_oem_board()``
+will contain string "write_bootloader" and ``data`` argument is a pointer to
+fastboot input buffer, which contains the contents of bootloader.img file.
+
 References
 ----------
 
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index a4313d60a9..4d94391a76 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
 	  this feature if you are using verified boot, as it will allow an
 	  attacker to bypass any restrictions you have in place.
 
+config FASTBOOT_OEM_BOARD
+	bool "Enable the 'oem board' command"
+	help
+	  This extends the fastboot protocol with an "oem board" command. This
+	  command allows running vendor custom code defined in board/ files.
+	  Otherwise, it will do nothing and send fastboot fail.
+
 endif # FASTBOOT
 
 endmenu
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 5fcadcdf50..da29211db1 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -40,6 +40,7 @@ static void reboot_recovery(char *, char *);
 static void oem_format(char *, char *);
 static void oem_partconf(char *, char *);
 static void oem_bootbus(char *, char *);
+static void oem_board(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
 
@@ -107,6 +108,10 @@ static const struct {
 		.command = "oem run",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL))
 	},
+	[FASTBOOT_COMMAND_OEM_BOARD] = {
+		.command = "oem board",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
+	},
 	[FASTBOOT_COMMAND_UCMD] = {
 		.command = "UCmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
@@ -490,3 +495,28 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
 	else
 		fastboot_okay(NULL, response);
 }
+
+/**
+ * fastboot_oem_board() - Execute the OEM board command. This is default
+ * weak implementation, which may be overwritten in board/ files.
+ *
+ * @cmd_parameter: Pointer to command parameter
+ * @data: Pointer to fastboot input buffer
+ * @size: Size of the fastboot input buffer
+ * @response: Pointer to fastboot response buffer
+ */
+void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 size, char *response)
+{
+	fastboot_fail("oem board function not defined", response);
+}
+
+/**
+ * oem_board() - Execute the OEM board command
+ *
+ * @cmd_parameter: Pointer to command parameter
+ * @response: Pointer to fastboot response buffer
+ */
+static void __maybe_unused oem_board(char *cmd_parameter, char *response)
+{
+	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size, response);
+}
diff --git a/include/fastboot.h b/include/fastboot.h
index 296451f89d..06c1f26b6c 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -37,6 +37,7 @@ enum {
 	FASTBOOT_COMMAND_OEM_PARTCONF,
 	FASTBOOT_COMMAND_OEM_BOOTBUS,
 	FASTBOOT_COMMAND_OEM_RUN,
+	FASTBOOT_COMMAND_OEM_BOARD,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
 	FASTBOOT_COMMAND_COUNT
-- 
2.34.1

