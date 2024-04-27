Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EC5C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 00:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8536F882DD;
	Sat, 27 Apr 2024 02:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4585D882A6; Sat, 27 Apr 2024 02:12:06 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F3A882F0
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 02:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from [68.189.91.139] (helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1s0Vfb-000O0P-Cb;
 Sat, 27 Apr 2024 00:11:59 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v3] mmc: allow use of hardware partition names for mmc partconf
Date: Fri, 26 Apr 2024 17:11:57 -0700
Message-Id: <20240427001157.1460302-1-tharvey@gateworks.com>
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

Add an enumerated type defining the hardware partition values and an
array of names describing them by name that can be used throughout
U-Boot.

Allow these names to be displayed when reading and used when setting
the mmc PARTITION_CONFIG field via 'mmc partconf'.

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
v3:
 - define partition names and values in mmc.h/mmc.c for others to use

v2:
 - fix typo in subject
 - add names for gp1..gp4
---
 cmd/mmc.c         | 14 +++++++++++---
 drivers/mmc/mmc.c | 11 +++++++++++
 include/mmc.h     | 15 +++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 2d5430a53079..26ab4450816b 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -14,6 +14,7 @@
 #include <part.h>
 #include <sparse_format.h>
 #include <image-sparse.h>
+#include <linux/ctype.h>
 
 static int curr_device = -1;
 
@@ -918,8 +919,8 @@ static int mmc_partconf_print(struct mmc *mmc, const char *varname)
 
 	printf("EXT_CSD[179], PARTITION_CONFIG:\n"
 		"BOOT_ACK: 0x%x\n"
-		"BOOT_PARTITION_ENABLE: 0x%x\n"
-		"PARTITION_ACCESS: 0x%x\n", ack, part, access);
+		"BOOT_PARTITION_ENABLE: 0x%x (%s)\n"
+		"PARTITION_ACCESS: 0x%x\n", ack, part, emmc_hwpart_names[part], access);
 
 	return CMD_RET_SUCCESS;
 }
@@ -949,7 +950,14 @@ static int do_mmc_partconf(struct cmd_tbl *cmdtp, int flag,
 		return mmc_partconf_print(mmc, cmd_arg2(argc, argv));
 
 	ack = dectoul(argv[2], NULL);
-	part_num = dectoul(argv[3], NULL);
+	if (!isdigit(*argv[3])) {
+		for (part_num = 0; part_num <= EMMC_HWPART_USER; part_num++) {
+			if (!strcmp(argv[3], emmc_hwpart_names[part_num]))
+				break;
+		}
+	} else {
+		part_num = dectoul(argv[3], NULL);
+	}
 	access = dectoul(argv[4], NULL);
 
 	/* acknowledge to be sent during boot operation */
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 7b068c71ff37..132afe1b8a29 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -29,6 +29,17 @@
 
 #define DEFAULT_CMD6_TIMEOUT_MS  500
 
+const char *emmc_hwpart_names[] = {
+	"user",
+	"boot0",
+	"boot1",
+	"gp1",
+	"gp2",
+	"gp3",
+	"gp4",
+	"user",
+};
+
 static int mmc_set_signal_voltage(struct mmc *mmc, uint signal_voltage);
 
 #if !CONFIG_IS_ENABLED(DM_MMC)
diff --git a/include/mmc.h b/include/mmc.h
index 4b8327f1f93b..7243bd761202 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -381,6 +381,21 @@ enum mmc_voltage {
 #define MMC_TIMING_MMC_HS200	9
 #define MMC_TIMING_MMC_HS400	10
 
+/* emmc hardware partition values */
+enum emmc_hwpart {
+	EMMC_HWPART_DEFAULT = 0,
+	EMMC_HWPART_BOOT0 = 1,
+	EMMC_HWPART_BOOT1 = 2,
+	EMMC_HWPART_GP1 = 3,
+	EMMC_HWPART_GP2 = 4,
+	EMMC_HWPART_GP3 = 5,
+	EMMC_HWPART_GP4 = 6,
+	EMMC_HWPART_USER = 7,
+};
+
+/* emmc hardware partition names */
+extern const char *emmc_hwpart_names[];
+
 /* Driver model support */
 
 /**
-- 
2.25.1

