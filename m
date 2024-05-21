Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E920DC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291DE8874D;
	Tue, 21 May 2024 09:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bf5wkxTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 067C988732; Tue, 21 May 2024 09:14:03 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787268871D
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3A637CE0E92;
 Tue, 21 May 2024 07:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01254C4AF07;
 Tue, 21 May 2024 07:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275635;
 bh=j3mJD9f/KOQL+aQUAJ22YabGGTNvDNXNdxB8R/VfL/Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bf5wkxTgASSYCcp0Khet3iM8sazHr618uMQ2YaMuYnqHFLDZvwLhnqDC99djx0fU1
 OcTmYukSxPoOnLq5Eyo1qsglCqcgCw/QebH54ERYmqHXZh/VJ1K2EdEe6FGpWGvIgm
 KSRhKeBktuvelwKUuWwQTwuWNLWJig60e8gaqGOr6xuniitUvVEJPcBTLeVB9UMM8j
 Ns25osHm7VQ6DYbFWYyJv0tVRUkBjzYzw08KiaNp/7PZyyum7HB8Cc3Oxb2GAAz9A3
 oNQxipACLM76vIKtrAPv7npemqeEf+KxaTIqfKVsw3Bi4Ox13Z0PfaFRslftUfi9eZ
 nSX8wsP2IsHNQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 08/11] cmd: eeprom: Refactor eeprom device specifier parsing
Date: Tue, 21 May 2024 09:13:32 +0200
Message-ID: <20240521071335.4193-9-kabel@kernel.org>
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

In preparation for allowing to access eeprom by driver-model device
name, refactor the eeprom device specifier parsing. Instead of filling
two parameters (i2c_bus, i2c_addr), the parsing function now fills one
parameter of type struct eeprom_dev_spec.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 cmd/eeprom.c | 77 ++++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index 12902e812e..e29639780d 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -208,41 +208,42 @@ static long parse_numeric_param(char *str)
 	return (*endptr != '\0') ? -1 : value;
 }
 
+struct eeprom_dev_spec {
+	int i2c_bus;
+	ulong i2c_addr;
+};
+
 /**
- * parse_i2c_bus_addr - parse the i2c bus and i2c devaddr parameters
+ * parse_eeprom_dev_spec - parse the eeprom device specifier
  *
- * @i2c_bus:	address to store the i2c bus
- * @i2c_addr:	address to store the device i2c address
- * @argc:	count of command line arguments left to parse
+ * @dev:	pointer to eeprom device specifier
+ * @argc:	count of command line arguments that can be used to parse
+ *		the device specifier
  * @argv:	command line arguments left to parse
- * @argc_no_bus_addr:	argc value we expect to see when bus & addr aren't given
  *
  * @returns:	number of arguments parsed or CMD_RET_USAGE if error
  */
-static int parse_i2c_bus_addr(int *i2c_bus, ulong *i2c_addr, int argc,
-			      char *const argv[], int argc_no_bus_addr)
+static int parse_eeprom_dev_spec(struct eeprom_dev_spec *dev, int argc,
+				 char *const argv[])
 {
-	int argc_no_bus = argc_no_bus_addr + 1;
-	int argc_bus_addr = argc_no_bus_addr + 2;
-
 #ifdef CONFIG_SYS_I2C_EEPROM_ADDR
-	if (argc == argc_no_bus_addr) {
-		*i2c_bus = -1;
-		*i2c_addr = CONFIG_SYS_I2C_EEPROM_ADDR;
+	if (argc == 0) {
+		dev->i2c_bus = -1;
+		dev->i2c_addr = CONFIG_SYS_I2C_EEPROM_ADDR;
 
 		return 0;
 	}
 #endif
-	if (argc == argc_no_bus) {
-		*i2c_bus = -1;
-		*i2c_addr = parse_numeric_param(argv[0]);
+	if (argc == 1) {
+		dev->i2c_bus = -1;
+		dev->i2c_addr = parse_numeric_param(argv[0]);
 
 		return 1;
 	}
 
-	if (argc == argc_bus_addr) {
-		*i2c_bus = parse_numeric_param(argv[0]);
-		*i2c_addr = parse_numeric_param(argv[1]);
+	if (argc == 2) {
+		dev->i2c_bus = parse_numeric_param(argv[0]);
+		dev->i2c_addr = parse_numeric_param(argv[1]);
 
 		return 2;
 	}
@@ -287,9 +288,10 @@ static enum eeprom_action parse_action(char *cmd)
 	return EEPROM_ACTION_INVALID;
 }
 
-static int eeprom_execute_command(enum eeprom_action action, int i2c_bus,
-				  ulong i2c_addr, int layout_ver, char *key,
-				  char *value, ulong addr, ulong off, ulong cnt)
+static int eeprom_execute_command(enum eeprom_action action,
+				  struct eeprom_dev_spec *dev,
+				  int layout_ver, char *key, char *value,
+				  ulong addr, ulong off, ulong cnt)
 {
 	int rcode = 0;
 	const char *const fmt =
@@ -301,25 +303,26 @@ static int eeprom_execute_command(enum eeprom_action action, int i2c_bus,
 	if (action == EEPROM_ACTION_INVALID)
 		return CMD_RET_USAGE;
 
-	eeprom_init(i2c_bus);
+	eeprom_init(dev->i2c_bus);
 	if (action == EEPROM_READ) {
-		printf(fmt, i2c_addr, "read", addr, off, cnt);
+		printf(fmt, dev->i2c_addr, "read", addr, off, cnt);
 
-		rcode = eeprom_read(i2c_addr, off, (uchar *)addr, cnt);
+		rcode = eeprom_read(dev->i2c_addr, off, (uchar *)addr, cnt);
 
 		puts("done\n");
 		return rcode;
 	} else if (action == EEPROM_WRITE) {
-		printf(fmt, i2c_addr, "write", addr, off, cnt);
+		printf(fmt, dev->i2c_addr, "write", addr, off, cnt);
 
-		rcode = eeprom_write(i2c_addr, off, (uchar *)addr, cnt);
+		rcode = eeprom_write(dev->i2c_addr, off, (uchar *)addr, cnt);
 
 		puts("done\n");
 		return rcode;
 	}
 
 #ifdef CONFIG_CMD_EEPROM_LAYOUT
-	rcode = eeprom_read(i2c_addr, 0, eeprom_buf, CONFIG_SYS_EEPROM_SIZE);
+	rcode = eeprom_read(dev->i2c_addr, 0, eeprom_buf,
+			    CONFIG_SYS_EEPROM_SIZE);
 	if (rcode < 0)
 		return rcode;
 
@@ -333,7 +336,8 @@ static int eeprom_execute_command(enum eeprom_action action, int i2c_bus,
 
 	layout.update(&layout, key, value);
 
-	rcode = eeprom_write(i2c_addr, 0, layout.data, CONFIG_SYS_EEPROM_SIZE);
+	rcode = eeprom_write(dev->i2c_addr, 0, layout.data,
+			     CONFIG_SYS_EEPROM_SIZE);
 #endif
 
 	return rcode;
@@ -359,9 +363,9 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int layout_ver = LAYOUT_VERSION_AUTODETECT;
 	enum eeprom_action action = EEPROM_ACTION_INVALID;
-	int i2c_bus = -1, index = 0;
-	ulong i2c_addr = -1, addr = 0, cnt = 0, off = 0;
-	int ret;
+	struct eeprom_dev_spec dev;
+	ulong addr = 0, cnt = 0, off = 0;
+	int ret, index = 0;
 	char *field_name = "";
 	char *field_value = "";
 
@@ -386,8 +390,9 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 #endif
 
-	ret = parse_i2c_bus_addr(&i2c_bus, &i2c_addr, argc, argv + index,
-				 eeprom_action_expected_argc(action));
+	ret = parse_eeprom_dev_spec(&dev,
+				    argc - eeprom_action_expected_argc(action),
+				    argv + index);
 	if (ret == CMD_RET_USAGE)
 		return ret;
 
@@ -411,8 +416,8 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 #endif
 
-	return eeprom_execute_command(action, i2c_bus, i2c_addr, layout_ver,
-				      field_name, field_value, addr, off, cnt);
+	return eeprom_execute_command(action, &dev, layout_ver, field_name,
+				      field_value, addr, off, cnt);
 }
 
 #ifdef CONFIG_EEPROM_LAYOUT_VERSIONS
-- 
2.44.1

