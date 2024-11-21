Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C6D75BBB
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D98896BD;
	Thu, 21 Nov 2024 06:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166785;
	bh=Ms/tNQ8u2x1HQWho6Vn6v+8ePrA+9+gmWrNSAmJVT2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AG+mP5kwkz7OrTy1pWPTmwuk+zfflEGIWm6Idu6cRr0U8ZYbAMmRWLokNlMw1q3NR
	 Tn+BKXDocuoAFMl6I2L9pgWE+nBWAMxvMXOnVLJ6ckzKilkZI/8Lp3K4cvEETK1u1o
	 wtVnmaJ2fDMGbxT0MbTRvQjlLxP1QIAeEeDm4fI3zadLEmlX22E8cnkzJwKR1lNBmU
	 RztPZ74SaXUeShXt6KRH96ae1dBt6wLwFRs6RnO0bW49DzzgQjZpUTVxK7rEX4TVz5
	 5mAcpg+dq/ApUSvZDyhZyLSLm5f44s+ZKi8OKHneBQaeg4aHMhFxZHUQHz6VcM4PkS
	 Or4a7HH4Jdjhg==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B3DC789681;
 Thu, 21 Nov 2024 06:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166782;
 bh=Ms/tNQ8u2x1HQWho6Vn6v+8ePrA+9+gmWrNSAmJVT2Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pc8E4h17o/dryHPRs6wUk/1FDpqM+sC+6ccb9CBmBSrPJH3jxsVs/AyRzWowhtLji
 BKCR9UHNhZOozRuDi/atJeHnIxQgTrsq38hk0+4SFyEwYw9xSVMBD50/qbdx9qgXD2
 a5+4/3YFA9j21heBqFn5CoKMWctMffi21J028eRiqjo1lvuV+VWTWKK+nSm0IGDRAA
 rZoKVWMp0CQVCoZfIp85285RKnAb19gxAQe/+8Wmw3PzlM7kbqKQjKXfRMzBp+zd8d
 XxwQ6Tk6Z8ZuRCVTFu1oFFopgcfaUHXi+8AADDhvHY2lXm7DlN1aJvFjU/8DnQaTX7
 YTWDrhv+E/IWQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alessandro Zini <alessandro.zini@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 15/20] siemens: capricorn: add HW version information to
 boot log
Date: Thu, 21 Nov 2024 06:25:56 +0100
Message-Id: <20241121052601.72880-16-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

From: Alessandro Zini <alessandro.zini@siemens.com>

Add the HW version read directly from EEPROM.

EEPROM chip data structure is now in a .h file common to draco
and capricorn.

Therefore move out the definitions in draco board to siemens
common place.

From: Alessandro Zini <alessandro.zini@siemens.com>
Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
Signed-off-by: Heiko Schocher <hs@denx.de>

---

(no changes since v2)

Changes in v2:
- add comment from Fabio
  add From line, as patch is from Alessandro
  fix typo in commit description: drace -> draco
- remove CONFIG_XPL_BUILD in board_init as
  board_init is not called from SPL.

 board/siemens/capricorn/board.c | 21 ++++++++++++++++
 board/siemens/common/board.h    | 44 +++++++++++++++++++++++++++++++++
 board/siemens/draco/board.h     | 10 ++------
 3 files changed, 67 insertions(+), 8 deletions(-)
 create mode 100644 board/siemens/common/board.h

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index bf04f12c75b..decac63db3b 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -26,6 +26,7 @@
 #include <asm/arch-imx8/clock.h>
 #endif
 #include <linux/delay.h>
+#include "../common/board.h"
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
 
@@ -278,6 +279,26 @@ int checkboard(void)
 
 int board_init(void)
 {
+	struct chip_data eeprom_data = {};
+	int ret;
+
+	ret = siemens_ee_setup();
+	if (ret) {
+		printf("'siemens_ee_setup' failed, ret: %d\n", ret);
+		goto skip;
+	}
+
+	ret = siemens_ee_read_data(SIEMENS_EE_ADDR_CHIP,
+				   (uchar *)&eeprom_data,
+				   sizeof(eeprom_data));
+	if (ret) {
+		printf("'siemens_ee_read_data' failed, ret: %d\n", ret);
+		goto skip;
+	}
+
+	printf("HW Version: %s\n", eeprom_data.shwver);
+skip:
+
 	setup_fec();
 	return 0;
 }
diff --git a/board/siemens/common/board.h b/board/siemens/common/board.h
new file mode 100644
index 00000000000..db34bc78711
--- /dev/null
+++ b/board/siemens/common/board.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Common board functions for siemens based boards
+ * (C) Copyright 2022 Siemens Schweiz AG
+ */
+
+#ifndef __COMMON_BOARD_H
+#define __COMMON_BOARD_H
+
+/*
+ * Chip data
+ * Offset in EEPROM: 0x120 - 0x14F
+ *
+ * -----------------------------------------------------------------------------------
+ * | Address range |                          Content                                |
+ * -----------------------------------------------------------------------------------
+ * | 0x120 - 0x123 |  Magic Number - 0x43484950 (4 byte)                             |
+ * -----------------------------------------------------------------------------------
+ * | 0x124 - 0x133 |  Device Nomenclature (15 + 1 byte)                              |
+ * -----------------------------------------------------------------------------------
+ * | 0x134 - 0x13A |  HW Version of the form "v00.00" (6 + 1 byte)                 |
+ * |               |   - First 2 digits: Layout revision (starting from 1)           |
+ * |               |   - Last 2 digits: Assembly variant revision (starting from 1)  |
+ * -----------------------------------------------------------------------------------
+ * | 0x13B - 0x13F |  Flash Size in Gibit (4 + 1 byte)                               |
+ * -----------------------------------------------------------------------------------
+ * | 0x140 - 0x144 |  Ram Size in Gibit (4 + 1 byte)                                 |
+ * -----------------------------------------------------------------------------------
+ * | 0x145 - 0x14F |  Sequence number, equals DMC-code (10 + 1 byte) [OBSOLETE]      |
+ * -----------------------------------------------------------------------------------
+ */
+
+#define MAGIC_CHIP		0x50494843
+#define EEPROM_CHIP_OFFSET	0x120
+
+struct chip_data {
+	unsigned int magic;
+	char sdevname[16];
+	char shwver[7];
+	char flash_size[5];
+	char ram_size[5];
+};
+
+#endif /* __COMMON_BOARD_H */
diff --git a/board/siemens/draco/board.h b/board/siemens/draco/board.h
index 935f340a8f2..77f35a6ab7b 100644
--- a/board/siemens/draco/board.h
+++ b/board/siemens/draco/board.h
@@ -11,6 +11,8 @@
 #ifndef _BOARD_DRACO_H_
 #define _BOARD_DRACO_H_
 
+#include "../common/board.h"
+
 #define PARGS(x)	#x , /* Parameter Name */ \
 			settings.ddr3.x, /* EEPROM Value */ \
 			ddr3_default.x, /* Default Value */ \
@@ -18,8 +20,6 @@
 
 #define PRINTARGS(y)	printf("%-20s, %8x, %8x, %4d\n", PARGS(y))
 
-#define MAGIC_CHIP	0x50494843
-
 /* Automatic generated definition */
 /* Wed, 16 Apr 2014 16:50:41 +0200 */
 /* From file: draco/ddr3-data-universal-default@303MHz-i0-ES3.txt */
@@ -43,12 +43,6 @@ struct ddr3_data {
 	char manu_marking[32];			/* "default \0" */
 };
 
-struct chip_data {
-	unsigned int  magic;
-	char sdevname[16];
-	char shwver[7];
-};
-
 struct draco_baseboard_id {
 	struct ddr3_data ddr3;
 	struct chip_data chip;
-- 
2.20.1

