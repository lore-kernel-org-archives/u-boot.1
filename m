Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26895C25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D01548870F;
	Tue, 21 May 2024 09:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MV4MZL/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DC78870B; Tue, 21 May 2024 09:13:55 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1887488720
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E5FD861FF2;
 Tue, 21 May 2024 07:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5A5C4AF07;
 Tue, 21 May 2024 07:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275631;
 bh=24IoUxTaqgkiNJOTFPqB/d7BBeJxM5Hwmylm9R59qLs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MV4MZL/FxPucIkSffQmLhjsHgzeaQtQ9CCSYVZ5P7llHPoghuRobSxbI0pdWlVl70
 aFNGweNM1gOWYkkTet5bBD+O+xt5NKE11W2VXFQ1Ovxfsk2ArYLVUFaQfU+WIRClSc
 6MLYMnPEtY0n558UAvWvKKOGTfqNEomPjNDcCdHzaidWTco6Xgf8nTRbu1IXp+WPFk
 0XZGWxg9CN6hbwnXi+U9yANJM/indxv7B/1PrD1Rj+ypHoQugIu8RVmekSWt3ugekS
 IqA+El5sU1ET+yOACAx2DuD2cevmOrM/sQBrmS1ETsTSYeW2QJajQMDaEuplwb5wKq
 AFlhpk7/6M6Sw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 06/11] cmd: eeprom: Hide eeprom layout versioning behind a
 Kconfig option
Date: Tue, 21 May 2024 09:13:30 +0200
Message-ID: <20240521071335.4193-7-kabel@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240521071335.4193-1-kabel@kernel.org>
References: <20240521071335.4193-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a new Kconfig option EEPROM_LAYOUT_VERSIONS, and hide eeprom
layout versionsing code behind it. Only print the relevant help in
'eeprom' command usage if this option is enabled.

Enable this new option for cm_fx6_defconfig and cm_t43_defconfig.
These are the only boards using EEPROM layout versioning.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 cmd/Kconfig              |  9 ++++++++-
 cmd/eeprom.c             | 20 +++++++++++++++-----
 configs/cm_fx6_defconfig |  1 +
 configs/cm_t43_defconfig |  1 +
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b026439c77..8c370993f6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -803,9 +803,16 @@ config CMD_EEPROM_LAYOUT
 			types of eeprom fields. Can be used for defining
 			custom layouts.
 
+config EEPROM_LAYOUT_VERSIONS
+	bool "Support specifying eeprom layout version"
+	depends on CMD_EEPROM_LAYOUT
+	help
+	  Support specifying eeprom layout version in the 'eeprom' command
+	  via the -l option.
+
 config EEPROM_LAYOUT_HELP_STRING
 	  string "Tells user what layout names are supported"
-	  depends on CMD_EEPROM_LAYOUT
+	  depends on EEPROM_LAYOUT_VERSIONS
 	  default "<not defined>"
 	  help
 	    Help printed with the LAYOUT VERSIONS part of the 'eeprom'
diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index 0d604832e4..d610dc9931 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -252,10 +252,12 @@ static int parse_i2c_bus_addr(int *i2c_bus, ulong *i2c_addr, int argc,
 
 #ifdef CONFIG_CMD_EEPROM_LAYOUT
 
+#ifdef CONFIG_EEPROM_LAYOUT_VERSIONS
 __weak int eeprom_parse_layout_version(char *str)
 {
 	return LAYOUT_VERSION_UNRECOGNIZED;
 }
+#endif
 
 static unsigned char eeprom_buf[CONFIG_SYS_EEPROM_SIZE];
 
@@ -359,7 +361,7 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (action == EEPROM_ACTION_INVALID)
 		return CMD_RET_USAGE;
 
-#ifdef CONFIG_CMD_EEPROM_LAYOUT
+#ifdef CONFIG_EEPROM_LAYOUT_VERSIONS
 	if (action == EEPROM_PRINT || action == EEPROM_UPDATE) {
 		if (!strcmp(argv[index], "-l")) {
 			NEXT_PARAM(argc, index);
@@ -415,6 +417,12 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 				      field_name, field_value, addr, off, cnt);
 }
 
+#ifdef CONFIG_EEPROM_LAYOUT_VERSIONS
+#define EEPROM_LAYOUT_SPEC	"[-l <layout_version>] "
+#else
+#define EEPROM_LAYOUT_SPEC	""
+#endif
+
 U_BOOT_CMD(
 	eeprom,	8,	1,	do_eeprom,
 	"EEPROM sub-system",
@@ -423,16 +431,18 @@ U_BOOT_CMD(
 	"       - read/write `cnt' bytes from `devaddr` EEPROM at offset `off'"
 #ifdef CONFIG_CMD_EEPROM_LAYOUT
 	"\n"
-	"eeprom print [-l <layout_version>] [[bus] devaddr]\n"
+	"eeprom print " EEPROM_LAYOUT_SPEC "[[bus] devaddr]\n"
 	"       - Print layout fields and their data in human readable format\n"
-	"eeprom update [-l <layout_version>] [[bus] devaddr] field_name field_value\n"
+	"eeprom update " EEPROM_LAYOUT_SPEC "[[bus] devaddr] field_name field_value\n"
 	"       - Update a specific eeprom field with new data.\n"
-	"         The new data must be written in the same human readable format as shown by the print command.\n"
-	"\n"
+	"         The new data must be written in the same human readable format as shown by the print command."
+#ifdef CONFIG_EEPROM_LAYOUT_VERSIONS
+	"\n\n"
 	"LAYOUT VERSIONS\n"
 	"The -l option can be used to force the command to interpret the EEPROM data using the chosen layout.\n"
 	"If the -l option is omitted, the command will auto detect the layout based on the data in the EEPROM.\n"
 	"The values which can be provided with the -l option are:\n"
 	CONFIG_EEPROM_LAYOUT_HELP_STRING"\n"
 #endif
+#endif
 );
diff --git a/configs/cm_fx6_defconfig b/configs/cm_fx6_defconfig
index a4d5f91b35..386616cc42 100644
--- a/configs/cm_fx6_defconfig
+++ b/configs/cm_fx6_defconfig
@@ -46,6 +46,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_EEPROM=y
 CONFIG_CMD_EEPROM_LAYOUT=y
+CONFIG_EEPROM_LAYOUT_VERSIONS=y
 CONFIG_EEPROM_LAYOUT_HELP_STRING="v2, v3"
 CONFIG_SYS_I2C_EEPROM_BUS=2
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
diff --git a/configs/cm_t43_defconfig b/configs/cm_t43_defconfig
index 93e667292c..32f126a517 100644
--- a/configs/cm_t43_defconfig
+++ b/configs/cm_t43_defconfig
@@ -50,6 +50,7 @@ CONFIG_SYS_PROMPT="CM-T43 # "
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_EEPROM=y
 CONFIG_CMD_EEPROM_LAYOUT=y
+CONFIG_EEPROM_LAYOUT_VERSIONS=y
 CONFIG_EEPROM_LAYOUT_HELP_STRING="v2, v3"
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
-- 
2.44.1

