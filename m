Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5172C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 00:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0974890AA;
	Fri, 26 Apr 2024 02:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECC38909F; Fri, 26 Apr 2024 02:14:29 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5522A890AD
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 02:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from [68.189.91.139] (helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1s09EM-005zBS-DX;
 Fri, 26 Apr 2024 00:14:22 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Subject: [PATCH] cmd: mmc: allow use of hardware parittion names for mmc
 partconf
Date: Thu, 25 Apr 2024 17:14:19 -0700
Message-Id: <20240426001419.1210364-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

eMMC devices have hardware partitions such as user, boot0, and boot1.
Allow these names to be displayed when reading the mmc PARTITION_CONFIG
field via 'mmc partconf'. Additionally allow a name to be specified when
setting the PARTITION_CONFIG.

Before:
u-boot=> mmc partconf 2 1 1 0 && mmc partconf 2
EXT_CSD[179], PARTITION_CONFIG:
BOOT_ACK: 0x1
BOOT_PARTITION_ENABLE: 0x2
PARTITION_ACCESS: 0x0

After:
u-boot=> mmc partconf 2 1 1 0 && mmc partconf 2
EXT_CSD[179], PARTITION_CONFIG:
BOOT_ACK: 0x1
BOOT_PARTITION_ENABLE: 0x1 (boot0)
PARTITION_ACCESS: 0x0
u-boot=> mmc partconf 2 1 boot1 0 && mmc partconf 2
EXT_CSD[179], PARTITION_CONFIG:
BOOT_ACK: 0x1
BOOT_PARTITION_ENABLE: 0x2 (boot1)
PARTITION_ACCESS: 0x0

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 cmd/mmc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 2d5430a53079..26692a8e349b 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -14,6 +14,18 @@
 #include <part.h>
 #include <sparse_format.h>
 #include <image-sparse.h>
+#include <linux/ctype.h>
+
+static const char *mmc_partnames[] = {
+	"user",
+	"boot0",
+	"boot1",
+	"",
+	"",
+	"",
+	"",
+	"user",
+};
 
 static int curr_device = -1;
 
@@ -918,8 +930,8 @@ static int mmc_partconf_print(struct mmc *mmc, const char *varname)
 
 	printf("EXT_CSD[179], PARTITION_CONFIG:\n"
 		"BOOT_ACK: 0x%x\n"
-		"BOOT_PARTITION_ENABLE: 0x%x\n"
-		"PARTITION_ACCESS: 0x%x\n", ack, part, access);
+		"BOOT_PARTITION_ENABLE: 0x%x (%s)\n"
+		"PARTITION_ACCESS: 0x%x\n", ack, part, mmc_partnames[part], access);
 
 	return CMD_RET_SUCCESS;
 }
@@ -949,7 +961,14 @@ static int do_mmc_partconf(struct cmd_tbl *cmdtp, int flag,
 		return mmc_partconf_print(mmc, cmd_arg2(argc, argv));
 
 	ack = dectoul(argv[2], NULL);
-	part_num = dectoul(argv[3], NULL);
+	if (!isdigit(*argv[3])) {
+		for (part_num = 0; part_num < ARRAY_SIZE(mmc_partnames); part_num++) {
+			if (!strcmp(argv[3], mmc_partnames[part_num]))
+				break;
+		}
+	} else {
+		part_num = dectoul(argv[3], NULL);
+	}
 	access = dectoul(argv[4], NULL);
 
 	/* acknowledge to be sent during boot operation */
-- 
2.25.1

