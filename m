Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19C1C25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E61D38871D;
	Tue, 21 May 2024 09:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ld96Ri2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185D78870B; Tue, 21 May 2024 09:14:05 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD9D3886FF
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9A9F061FF2;
 Tue, 21 May 2024 07:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C797AC32782;
 Tue, 21 May 2024 07:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275641;
 bh=fb6Jd6DcoKyRKD7Wzx7N3VP+d2adhb7lwjg1YjcS5SM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ld96Ri2DYuMTSD2TpQ6DMo1aJY8bHZuaSEo9aurf5zwxFslYSEfZBCxIL+GjQ9IrY
 Y+O5z20ZA7UWcd/11L52gsAJAWzXo5RNjcCY8ZjvocGH/rZ8+0MdW9xcpy5db70vda
 16Zrd3aA8znn/USNhC6ddp9vdWon7kgfhv4AyYOMbDx11TYn/RIFtaEkP27YZM/tYC
 zLJukV5RuvuJJICu5MLw8niP1rt8k301YKs2GcbS0xr+na1WxXDUPo6LaYrER1Bsow
 pYdVnDHtyU9G8OYbaxfiOzHXF02hO48J6Tu9DexjFRXdyPcPxqQPgWBXLO9SEzgE5U
 suMw1nZhE6T8Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 11/11] cmd: eeprom: Extend to EEPROMs probed via driver model
Date: Tue, 21 May 2024 09:13:35 +0200
Message-ID: <20240521071335.4193-12-kabel@kernel.org>
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

Extend the 'eeprom' command to allow accessing EEPROMs probed via
driver model, uclass UCLASS_I2C_EEPROM.

When the CONFIG_I2C_EEPROM config option is enabled (and so the
i2c-eeprom driver is built), the 'eeprom' command now accepts driver
model device name as EEPROM specifier for the 'eeprom' command, in
addition to the legacy [[bus] devaddr] specifier.

Moreover if no device specifier is given, then the first
UCLASS_I2C_EEPROM device is used, if found.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 cmd/eeprom.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 112 insertions(+), 10 deletions(-)

diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index 9c4af88738..a39fc5ffdc 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -22,8 +22,10 @@
 #include <common.h>
 #include <config.h>
 #include <command.h>
+#include <dm.h>
 #include <eeprom.h>
 #include <i2c.h>
+#include <i2c_eeprom.h>
 #include <eeprom_layout.h>
 #include <linux/delay.h>
 
@@ -209,10 +211,41 @@ static long parse_numeric_param(char *str)
 }
 
 struct eeprom_dev_spec {
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+	struct udevice *dev;
+#endif
 	int i2c_bus;
 	ulong i2c_addr;
 };
 
+static void eeprom_dev_spec_init(struct eeprom_dev_spec *dev)
+{
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+	if (!dev->dev)
+#endif
+		eeprom_init(dev->i2c_bus);
+}
+
+static int eeprom_dev_spec_read(struct eeprom_dev_spec *dev,
+				unsigned offset, uchar *buffer, unsigned cnt)
+{
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+	if (dev->dev)
+		return i2c_eeprom_read(dev->dev, offset, buffer, cnt);
+#endif
+	return eeprom_read(dev->i2c_addr, offset, buffer, cnt);
+}
+
+static int eeprom_dev_spec_write(struct eeprom_dev_spec *dev,
+				 unsigned offset, uchar *buffer, unsigned cnt)
+{
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+	if (dev->dev)
+		return i2c_eeprom_write(dev->dev, offset, buffer, cnt);
+#endif
+	return eeprom_write(dev->i2c_addr, offset, buffer, cnt);
+}
+
 /**
  * parse_eeprom_dev_spec - parse the eeprom device specifier
  *
@@ -226,6 +259,28 @@ struct eeprom_dev_spec {
 static int parse_eeprom_dev_spec(struct eeprom_dev_spec *dev, int argc,
 				 char *const argv[])
 {
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+	if (argc == 0) {
+		if (!uclass_first_device_err(UCLASS_I2C_EEPROM, &dev->dev))
+			return 0;
+	}
+
+	if (argc == 1) {
+		if (!uclass_get_device_by_name(UCLASS_I2C_EEPROM, argv[0],
+					       &dev->dev))
+			return 1;
+
+		/*
+		 * If we could not find the device by name and the parameter is
+		 * not numeric (and so won't be handled later), fail.
+		 */
+		if (parse_numeric_param(argv[0]) == -1) {
+			printf("Can't get eeprom device: %s\n", argv[0]);
+			return CMD_RET_USAGE;
+		}
+	}
+#endif
+
 #ifdef CONFIG_SYS_I2C_EEPROM_ADDR
 	if (argc == 0) {
 		dev->i2c_bus = -1;
@@ -265,6 +320,7 @@ static unsigned char eeprom_buf[CONFIG_SYS_EEPROM_SIZE];
 #endif
 
 enum eeprom_action {
+	EEPROM_LIST,
 	EEPROM_READ,
 	EEPROM_WRITE,
 	EEPROM_PRINT,
@@ -274,6 +330,10 @@ enum eeprom_action {
 
 static enum eeprom_action parse_action(char *cmd)
 {
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+	if (!strncmp(cmd, "list", 4))
+		return EEPROM_LIST;
+#endif
 	if (!strncmp(cmd, "read", 4))
 		return EEPROM_READ;
 	if (!strncmp(cmd, "write", 5))
@@ -288,6 +348,24 @@ static enum eeprom_action parse_action(char *cmd)
 	return EEPROM_ACTION_INVALID;
 }
 
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+static int do_eeprom_list(void)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+	int err;
+
+	err = uclass_get(UCLASS_I2C_EEPROM, &uc);
+	if (err)
+		return CMD_RET_FAILURE;
+
+	uclass_foreach_dev(dev, uc)
+		printf("%s (%s)\n", dev->name, dev->driver->name);
+
+	return CMD_RET_SUCCESS;
+}
+#endif
+
 static int do_eeprom_rw(struct eeprom_dev_spec *dev, bool read,
 			ulong addr, ulong off, ulong cnt)
 {
@@ -298,9 +376,9 @@ static int do_eeprom_rw(struct eeprom_dev_spec *dev, bool read,
 
 	printf(fmt, dev->i2c_addr, read ? "read" : "write", addr, off, cnt);
 	if (read)
-		ret = eeprom_read(dev->i2c_addr, off, memloc, cnt);
+		ret = eeprom_dev_spec_read(dev, off, memloc, cnt);
 	else
-		ret = eeprom_write(dev->i2c_addr, off, memloc, cnt);
+		ret = eeprom_dev_spec_write(dev, off, memloc, cnt);
 	puts("done\n");
 
 	return ret;
@@ -314,7 +392,7 @@ static int do_eeprom_layout(struct eeprom_dev_spec *dev, int layout_ver,
 	eeprom_layout_setup(layout, eeprom_buf, CONFIG_SYS_EEPROM_SIZE,
 			    layout_ver);
 
-	return eeprom_read(dev->i2c_addr, 0, eeprom_buf, layout->data_size);
+	return eeprom_dev_spec_read(dev, 0, eeprom_buf, layout->data_size);
 }
 
 static int do_eeprom_print(struct eeprom_dev_spec *dev, int layout_ver)
@@ -345,7 +423,7 @@ static int do_eeprom_update(struct eeprom_dev_spec *dev, int layout_ver,
 	if (ret)
 		return CMD_RET_FAILURE;
 
-	return eeprom_write(dev->i2c_addr, 0, layout.data, layout.data_size);
+	return eeprom_dev_spec_write(dev, 0, layout.data, layout.data_size);
 }
 
 #endif
@@ -353,6 +431,8 @@ static int do_eeprom_update(struct eeprom_dev_spec *dev, int layout_ver,
 static int eeprom_action_expected_argc(enum eeprom_action action)
 {
 	switch (action) {
+	case EEPROM_LIST:
+		return 0;
 	case EEPROM_READ:
 	case EEPROM_WRITE:
 		return 3;
@@ -389,6 +469,11 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (action == EEPROM_ACTION_INVALID)
 		return CMD_RET_USAGE;
 
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+	if (action == EEPROM_LIST)
+		return do_eeprom_list();
+#endif
+
 #ifdef CONFIG_EEPROM_LAYOUT_VERSIONS
 	if (action == EEPROM_PRINT || action == EEPROM_UPDATE) {
 		if (!strcmp(argv[index], "-l")) {
@@ -425,7 +510,7 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 #endif
 
-	eeprom_init(dev.i2c_bus);
+	eeprom_dev_spec_init(&dev);
 
 	switch (action) {
 	case EEPROM_READ:
@@ -450,19 +535,37 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 #define EEPROM_LAYOUT_SPEC	""
 #endif
 
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+# define EEPROM_DEV_SPEC	"[device_specifier]"
+#else
+# define EEPROM_DEV_SPEC	"[[bus] devaddr]"
+#endif
+
 U_BOOT_CMD(
 	eeprom,	8,	1,	do_eeprom,
 	"EEPROM sub-system",
-	"read  [[bus] devaddr] addr off cnt\n"
-	"eeprom write [[bus] devaddr] addr off cnt\n"
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+	"list\n"
+	"eeprom "
+#endif
+	"read  " EEPROM_DEV_SPEC " addr off cnt\n"
+	"eeprom write " EEPROM_DEV_SPEC " addr off cnt\n"
 	"       - read/write `cnt' bytes from `devaddr` EEPROM at offset `off'"
 #ifdef CONFIG_CMD_EEPROM_LAYOUT
 	"\n"
-	"eeprom print " EEPROM_LAYOUT_SPEC "[[bus] devaddr]\n"
+	"eeprom print " EEPROM_LAYOUT_SPEC EEPROM_DEV_SPEC "\n"
 	"       - Print layout fields and their data in human readable format\n"
-	"eeprom update " EEPROM_LAYOUT_SPEC "[[bus] devaddr] field_name field_value\n"
+	"eeprom update " EEPROM_LAYOUT_SPEC EEPROM_DEV_SPEC " field_name field_value\n"
 	"       - Update a specific eeprom field with new data.\n"
 	"         The new data must be written in the same human readable format as shown by the print command."
+#endif
+#if CONFIG_IS_ENABLED(I2C_EEPROM)
+	"\n\n"
+	"DEVICE SPECIFIER - the eeprom device can be specified\n"
+	"  [dev_name] - by device name (devices can listed with the eeprom list command)\n"
+	"  [[bus] devaddr] - or by I2C bus and I2C device address\n"
+	"If no device specifier is given, the first driver-model found device is used."
+#endif
 #ifdef CONFIG_EEPROM_LAYOUT_VERSIONS
 	"\n\n"
 	"LAYOUT VERSIONS\n"
@@ -471,5 +574,4 @@ U_BOOT_CMD(
 	"The values which can be provided with the -l option are:\n"
 	CONFIG_EEPROM_LAYOUT_HELP_STRING"\n"
 #endif
-#endif
 );
-- 
2.44.1

