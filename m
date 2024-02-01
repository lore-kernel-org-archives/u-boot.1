Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A70C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 12:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 877DE87C8E;
	Thu,  1 Feb 2024 13:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="f2cBnN24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F92187BEE; Thu,  1 Feb 2024 10:20:46 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACEF87C34
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 10:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id BC0E110000E;
 Thu,  1 Feb 2024 12:20:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BC0E110000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1706779241;
 bh=ptrrtwc1rdJIF6eOFzhZS7LnEHgkpzkC6A4MmdrzLs0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=f2cBnN24psfx7BfwB9pcmOHgiVhnEKzqDZFBZi6L21TxUbK8+n0LAL99sW8xFgQQm
 LVNRaT47hedxArvr5+2MeZqu/WnXwqBdsiXNcfSWTesUlOYOlkqi0JQVEBloxeFJ3V
 52TzKn0/kKqLrRfQ5x1kd2IsJpZ/pg9gQLo75y7Y8XB/YAmlPMgJ0oNaUG7k/Xoxqp
 no7Kn93I/50wmptnLVVIyycA1fVNRGgxxUC1FZf8v4nYYfz18MNuChKFbPYlIvWhw/
 1i74+jY24TasKmCTKDMZd4aCAfp3g+d3+tgH8hCpbnV5oDs+kiLK98THzJqCdZ3u30
 TdPJsL60SOGpg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  1 Feb 2024 12:20:41 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 12:20:41 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <sjg@chromium.org>, <hs@denx.de>, <sean.anderson@seco.com>,
 <dimorinny@google.com>, <mkorpershoek@baylibre.com>,
 <patrick.delaunay@foss.st.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [RFC PATCH v2 2/2] board: ad401: example of fastboot oem board
 realization
Date: Thu, 1 Feb 2024 12:20:27 +0300
Message-ID: <20240201092027.6258-3-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240201092027.6258-1-avromanov@salutedevices.com>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183104 [Feb 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/01 05:28:00 #23344271
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 01 Feb 2024 13:25:59 +0100
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

An example of how we use fastboot oeam board subcommand
for Sean Anderson.

1 - OEM_BOARD_WRITE_BOOTLOADER_CMD:

We use it for custom Amlogic bootloader + tpl
flashing protocol.

2 - OEM_BOARD_ERASE_CMD:

Custom logic for erasing the env-emulated partition,
which isn't in the mtd markup map.

Example of the script which completely flashes the device:

  $ fastboot erase bootloader
  $ fastboot stage u-boot.bin
  $ fastboot oem board:write_bootloader
  $ fastboot reboot-bootloader
  $ fastboot oem board:erase_env
  $ fastboot erase misc
  $ fastboot erase super
  $ fastboot flash super rootfs
  $ fastboot reboot

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 board/amlogic/ad401/fastboot.c | 222 +++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)
 create mode 100644 board/amlogic/ad401/fastboot.c

diff --git a/board/amlogic/ad401/fastboot.c b/board/amlogic/ad401/fastboot.c
new file mode 100644
index 0000000000..01da8efa5b
--- /dev/null
+++ b/board/amlogic/ad401/fastboot.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SaluteDevices, Inc.
+ */
+
+#include <common.h>
+#include <env.h>
+#include <fastboot.h>
+#include <nand.h>
+#include <asm/arch/nand.h>
+#include <jffs2/load_kernel.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+#include <linux/mtd/mtd.h>
+
+enum {
+	OEM_BOARD_ERASE_CMD,
+	OEM_BOARD_WRITE_BOOTLOADER_CMD,
+};
+
+struct defenv {
+	char *name;
+	char value[256];
+};
+
+static void save_defenv(struct defenv *e, size_t cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++) {
+		const char *env_val = env_get(e[i].name);
+
+		if (env_val)
+			strlcpy(e[i].value, env_val, sizeof(e[i].value));
+		else
+			e[i].value[0] = '\0';
+	}
+}
+
+static void set_defenv(struct defenv *e, size_t cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++)
+		env_set(e[i].name, e[i].value);
+}
+
+static int fastboot_erase_env(void)
+{
+	char *const defenv_names[] = { "lock", "mtdparts", "mtdids" };
+	struct defenv env[ARRAY_SIZE(defenv_names)];
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(env); i++)
+		env[i].name = defenv_names[i];
+
+	printf("ENV is being erased...\n");
+
+	/*
+	 * Reset environment to the default, excluding 'lock' variable,
+	 * because it reflects the fastboot's state after execution of
+	 * 'flashing unlock' command, hence it must survive the env-erasing.
+	 * Otherwise, further erase commands will fail on check_lock().
+	 *
+	 * Also, we have to save 'mtdparts' and 'mtdids' variables
+	 * because they are necessary to obtain partition map.
+	 */
+
+	save_defenv(env, ARRAY_SIZE(env));
+	env_set_default(NULL, 0);
+	set_defenv(env, ARRAY_SIZE(env));
+
+	err = env_save();
+	if (err) {
+		pr_err("Can't overwrite ENV-partition\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int fastboot_nand_write_tpl(struct mtd_info *mtd, void *buffer,
+				   u32 offset, size_t size, int flags)
+{
+	int boot_cpy_num = meson_bootloader_copy_num(BOOT_TPL);
+	u64 size_per_copy = meson_bootloader_copy_size(mtd, BOOT_TPL);
+	int i;
+
+	for (i = 0; i < boot_cpy_num; i++) {
+		size_t retlen, len = size;
+		int ret;
+
+		ret = nand_write_skip_bad(mtd, offset + (i * size_per_copy),
+					  &len, &retlen, offset + size_per_copy,
+					  buffer, flags);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int fastboot_nand_write_bl2(struct mtd_info *mtd, void *buffer,
+				   u32 offset, size_t size, int flags)
+{
+	int boot_cpy_num = meson_bootloader_copy_num(BOOT_BL2);
+	u64 size_per_copy = meson_bootloader_copy_size(mtd, BOOT_BL2);
+	int i;
+
+	for (i = 0; i < boot_cpy_num; i++) {
+		int ret;
+
+		ret = meson_bootloader_write_bl2(mtd, buffer,
+						 offset + (i * size_per_copy),
+					         size, flags);
+		if (ret)
+			return ret;
+	}
+
+	return meson_bootloader_write_info_pages();
+}
+
+static int fastboot_nand_write_bootloader(void *buffer, u32 size)
+{
+	struct part_info *part;
+	struct mtd_info *mtd = NULL;
+	struct mtd_device *dev;
+	u8 pnum;
+	int ret;
+
+	if (size < BL2_SIZE)
+		return 0;
+
+	if (!buffer)
+		return -EINVAL;
+
+	ret = mtdparts_init();
+	if (ret) {
+		pr_err("Cannot initialize MTD partitions\n");
+		return ret;
+	}
+
+	ret = find_dev_and_part("bootloader", &dev, &pnum, &part);
+	if (ret) {
+		pr_err("cannot find 'bootloader' partition\n");
+		return ret;
+	}
+
+	mtd = get_nand_dev_by_index(dev->id->num);
+	if (!mtd)
+		return -EINVAL;
+
+	ret = fastboot_nand_write_bl2(mtd, buffer, part->offset,
+				      BL2_SIZE, WITH_WR_VERIFY);
+	if (ret) {
+		pr_err("fastboot: failed to write BL2\n");
+		return ret;
+	}
+
+	ret = find_dev_and_part("tpl", &dev, &pnum, &part);
+	if (ret) {
+		pr_err("cannot find 'bootloader' partition\n");
+		return ret;
+	}
+
+	mtd = get_nand_dev_by_index(dev->id->num);
+	if (!mtd)
+		return -EINVAL;
+
+	ret = fastboot_nand_write_tpl(mtd, buffer + BL2_SIZE, part->offset,
+				      size - BL2_SIZE, WITH_WR_VERIFY);
+	if (ret) {
+		pr_err("fastboot: failed to write TPL\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int get_oem_board_command(const char *cmd)
+{
+	const char *oem_commands[] = {
+		[OEM_BOARD_ERASE_CMD] = "erase_env",
+		[OEM_BOARD_WRITE_BOOTLOADER_CMD] = "write_bootloader",
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(oem_commands); i++)
+		if (!strcmp(cmd, oem_commands[i]))
+			return i;
+
+	return -EINVAL;
+}
+
+void fastboot_oem_board(const char *cmd_parameter, void *data, u32 size,
+			char *response)
+{
+	char buf[128] = { 0 };
+	int ret, cmd;
+
+	cmd = get_oem_board_command(cmd_parameter);
+
+	switch (cmd) {
+		case OEM_BOARD_ERASE_CMD:
+			ret = fastboot_erase_env();
+			break;
+		case OEM_BOARD_WRITE_BOOTLOADER_CMD:
+			ret = fastboot_nand_write_bootloader(data, size);
+			break;
+		default:
+			snprintf(buf, sizeof(buf),
+				 "Command 'oem board %s' not supported",
+				 cmd_parameter);
+			fastboot_fail(buf, response);
+			return;
+	}
+
+	if (ret < 0)
+		fastboot_fail("Failed to erase env partition", response);
+	else
+		fastboot_okay(NULL, response);
+}
-- 
2.30.1

