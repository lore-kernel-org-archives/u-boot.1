Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D3FD5E12D
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5382D89247;
	Fri,  8 Nov 2024 06:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043329;
	bh=OC7gFYr6szj0eArttgcY/UXRlVXw9aL29PoKrBwhdMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDqAAjiV7VXpdd+TQj1A8IaMjbqHluKMGPjRd+aSjBX7R4oUwi05VfrKp7SP3VHOX
	 KsYLv0+yTvtAF2r9hKbUCGMyx+iDuTSVUh/84rE06peEZFAHNDV9qWD7w0u9XSbI3F
	 oSQeQnAJZ75FnY99VZsCU8KLukyuRdE8GvpB8QNDLOvzdlkMzFwED00o3kmdkraYUW
	 GpCA1nwC/COTSn8kE3WflIngRXq0ge5ZXttTJrK53kjXwZNvZRk5sc1mIs6JecPtus
	 rYEVl7QmIC597XldeQUKj8o4sfDal8BMdIP3q9tMAadN/6Gz1phIB3r3u8aVIoau8R
	 gSC1pPJ2zownQ==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2A9BA89209;
 Fri,  8 Nov 2024 06:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043326;
 bh=OC7gFYr6szj0eArttgcY/UXRlVXw9aL29PoKrBwhdMA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WGtXJc4Y1WCgU34H/WzQnzOMkmEIQJW2DrBbb0jp+W1Ls+nT7GNTEOMPg9nZGFNgL
 HQSXptett9hQsNbNmQzfzqg1L8yjGHlxGcd4Vqt1Dx6l6r4yf2RQf0+E0mgKgRYQj9
 wF//JG7ZKtX/HsQbTUIG8rbdRTWRq+88QtFbg8hOAPq+/dB4P3T2h/bVgNgRjvzK6f
 Cge+9pX47lrVzn4KCgbHsQMKyeh529k0xU3IJxWD5wieA23qf4UNA4MozKWgRJ428e
 v8CkmgXlosf5qE6igp9qGFSJ/vNut5Tg4UzfZ00+/XAligpVtyPwDUmSdftrLElHq1
 ECVFQB5l/D25A==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Michal Simek <michal.simek@amd.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 17/22] siemens: capricorn: add HW version information to
 boot log
Date: Fri,  8 Nov 2024 06:21:38 +0100
Message-Id: <20241108052143.26874-18-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

Add the HW version read directly from EEPROM.

EEPROM chip data structure is now in a .h file common to draco
and capricorn.

Therefore move out the definitions in drace board to siemens
common place.

Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

 board/siemens/capricorn/board.c | 24 ++++++++++++++++++
 board/siemens/common/board.h    | 44 +++++++++++++++++++++++++++++++++
 board/siemens/draco/board.h     | 10 ++------
 3 files changed, 70 insertions(+), 8 deletions(-)
 create mode 100644 board/siemens/common/board.h

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index 99681d68c3f..74856aaf8f6 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -26,6 +26,7 @@
 #include <asm/arch-imx8/clock.h>
 #endif
 #include <linux/delay.h>
+#include "../common/board.h"
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
 
@@ -282,6 +283,29 @@ int checkboard(void)
 
 int board_init(void)
 {
+#ifndef CONFIG_XPL_BUILD
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
+
+skip:
+#endif
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

