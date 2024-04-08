Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C3CC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD87C8814A;
	Mon,  8 Apr 2024 20:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="SLuoNGvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463D988059; Mon,  8 Apr 2024 12:16:11 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D00408805B
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 12:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 65F71120020;
 Mon,  8 Apr 2024 13:16:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 65F71120020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1712571368;
 bh=qH/L8bhbnIuWEofqVBBRhl1Hs8UILZK38dQbjue4x/w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=SLuoNGvnhw2IUoUUNFJeR7BmjkWF7syGAGMTClHH3RVsIUzR1+SqYaC50yhSIxFp7
 oT5A2uHYmdfxUd8+i+005Y2Jess3tSywnr7lU3dZEVN397I2QA1/6epQzUICFMg2t7
 yjhFgjAipeckiiPM6nPdpCjmVIwghnI9DVmWRyc6tMrsfTldTHi1yb1WW/Egr+2DBr
 VGegCT9n2EcJtCFx9RyxCz+PQvfNBs/wy7QXL0Ers6vpn5jnvXgw1/O3dkkTPjAg8I
 FSQHXAdailF+rpseBfv/LdADNKPey4BT/OpdGfAj3+UgVJPwlHojD74N0s6oymnU45
 orkNQOE9Mv36g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  8 Apr 2024 13:16:08 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Apr 2024 13:16:07 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <sjg@chromium.org>, <hs@denx.de>, <sean.anderson@seco.com>,
 <dimorinny@google.com>, <mkorpershoek@baylibre.com>,
 <patrick.delaunay@foss.st.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v3 1/1] fastboot: introduce 'oem board' subcommand
Date: Mon, 8 Apr 2024 13:15:52 +0300
Message-ID: <20240408101552.539037-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408101552.539037-1-avromanov@salutedevices.com>
References: <20240408101552.539037-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184617 [Apr 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15
 adb41f89e2951eb37b279104a7abb8e79494a5e7,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/08 06:07:00 #24706059
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 08 Apr 2024 20:35:45 +0200
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
---
 doc/android/fastboot.rst      | 18 ++++++++++++++++++
 drivers/fastboot/Kconfig      |  7 +++++++
 drivers/fastboot/fb_command.c | 30 ++++++++++++++++++++++++++++++
 include/fastboot.h            |  1 +
 4 files changed, 56 insertions(+)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 05d8f77759..2020590657 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -30,6 +30,7 @@ The following OEM commands are supported (if enabled):
 - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure eMMC
 - ``oem run`` - this executes an arbitrary U-Boot command
 - ``oem console`` - this dumps U-Boot console record buffer
+- ``oem board`` - this executes an custom board function which is defined by vendor
 
 Support for both eMMC and NAND devices is included.
 
@@ -246,6 +247,23 @@ including multiple commands (using e.g. ``;`` or ``&&``) and control structures
 (``if``, ``while``, etc.). The exit code of ``fastboot`` will reflect the exit
 code of the command you ran.
 
+Running Custom Vendor Code
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+U-Boot allows you to execute custom fastboot logic, which can be defined
+in board/ files. It can still be used for production devices with verified
+boot, because vendor define logic at compile time by overriding weak
+implementation of fastboot_oem_board() function. The attacker will
+not able to execute his commands / code. For example, this can be useful
+for custom flashing or erasing protocols::
+
+    $ fastboot stage bootloader.img
+    $ fastboot oem board:write_bootloader
+
+In this case, ``cmd_parameter`` argument of the function ``fastboot_oem_board()``
+will contain string "write_bootloader" and ``data`` argument is a pointer to
+fastboot input buffer, which containing the contents of bootloader.img file.
+
 References
 ----------
 
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 5e5855a76c..937a39f54a 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -249,6 +249,13 @@ config FASTBOOT_CMD_OEM_CONSOLE
 	  Add support for the "oem console" command to input and read console
 	  record buffer.
 
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
index f95f4e4ae1..96c27afc60 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -42,6 +42,7 @@ static void oem_format(char *, char *);
 static void oem_partconf(char *, char *);
 static void oem_bootbus(char *, char *);
 static void oem_console(char *, char *);
+static void oem_board(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
 
@@ -113,6 +114,10 @@ static const struct {
 		.command = "oem console",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE, (oem_console), (NULL))
 	},
+	[FASTBOOT_COMMAND_OEM_BOARD] = {
+		.command = "oem board",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
+	},
 	[FASTBOOT_COMMAND_UCMD] = {
 		.command = "UCmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
@@ -542,3 +547,28 @@ static void __maybe_unused oem_console(char *cmd_parameter, char *response)
 	else
 		fastboot_response(FASTBOOT_MULTIRESPONSE_START, response, NULL);
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
index 1e7920eb91..2ca1b907a5 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -48,6 +48,7 @@ enum {
 	FASTBOOT_COMMAND_OEM_BOOTBUS,
 	FASTBOOT_COMMAND_OEM_RUN,
 	FASTBOOT_COMMAND_OEM_CONSOLE,
+	FASTBOOT_COMMAND_OEM_BOARD,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
 	FASTBOOT_COMMAND_COUNT
-- 
2.34.1

