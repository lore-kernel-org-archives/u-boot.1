Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8861AC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09D187AB4;
	Thu, 28 Dec 2023 16:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="pZ70jzQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1691A87AB5; Thu, 28 Dec 2023 16:25:32 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1822787AB0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 50E37100038;
 Thu, 28 Dec 2023 18:25:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 50E37100038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703777129;
 bh=BbdXeHUmteLSIo+EnxJzS/NXqz+OQalMaUeOAY3BNnY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=pZ70jzQLATopWZdjEnSNe8kJJGhRyfTj3K1rk+S1B0mrm3mMP072LEtQr69TRA22a
 BXOnS2p45wdvTExDuy+OHaZectmAltsoyud7g+u5Xhcs8SX7qPbiS6D4Q7Qj3lpl8i
 dm6/0J5VAu/xzNr1rUVpEJ/6E4q4UIGnBdwAOsgqkgDZ87N1QpV6tgNF+qNhXhTfIJ
 3Ew0N9ief2ZPoH3i5umyxhqJzFIAA9wJITSEPpPHQArImEjdl6dIgFSXIUTaHa1xlf
 DORTNsQzULwuWP+kKjS2v6ba5Dkh6/VSc2zzIoEqZpr3DVVldUXhPEkU0KXvK4nJyA
 xAYvt5mJPU3dQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 28 Dec 2023 18:25:29 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:25:28 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <sjg@chromium.org>, <hs@denx.de>, <sean.anderson@seco.com>,
 <dimorinny@google.com>, <mkorpershoek@baylibre.com>,
 <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1] fastboot: introduce 'oem board' subcommand
Date: Thu, 28 Dec 2023 18:25:20 +0300
Message-ID: <20231228152522.83291-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182415 [Dec 28 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/28 11:18:00 #22863388
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 28 Dec 2023 16:40:43 +0100
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
 drivers/fastboot/Kconfig      |  7 +++++++
 drivers/fastboot/fb_command.c | 15 +++++++++++++++
 include/fastboot.h            |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 3cfeea4837..4c955cabab 100644
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
index 71cfaec6e9..4d2b451f46 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -39,6 +39,7 @@ static void reboot_recovery(char *, char *);
 static void oem_format(char *, char *);
 static void oem_partconf(char *, char *);
 static void oem_bootbus(char *, char *);
+static void oem_board(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
 
@@ -106,6 +107,10 @@ static const struct {
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
@@ -489,3 +494,13 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
 	else
 		fastboot_okay(NULL, response);
 }
+
+void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 size, char *response)
+{
+	fastboot_fail("oem board function not defined", response);
+}
+
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
2.30.1

