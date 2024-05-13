Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02103C25B79
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 23:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E285A88280;
	Tue, 14 May 2024 01:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646A4877AF; Tue, 14 May 2024 01:29:22 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2584687C2D
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 01:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1s6f6X-007JY8-8S;
 Mon, 13 May 2024 23:29:13 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/3 v4] mmc: allow use of hardware partition names for mmc
 partconf
Date: Mon, 13 May 2024 16:29:06 -0700
Message-Id: <20240513232907.2738959-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513232907.2738959-1-tharvey@gateworks.com>
References: <20240513232907.2738959-1-tharvey@gateworks.com>
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

eMMC v4+ devices have hardware partitions that are accessed via the
PARTITION_CONFIG (Extended CSD Register 179) PARTITION_ACCESS
and BOOT_PARTITION_ENABLE fields defined as:
bit 5:3: BOOT_PARTITION_ENABLE
  0x0: Device not boot enabled (default)
  0x1: Boot Area partition 1 enabled for boot
  0x2: Boot Area partition 2 enabled for boot
  0x3-0x6: Reserved
  0x7: User area enabled for boot
bit 2:0 PARTITION_ACCESS
  0x0: No access to boot partition (default)
  0x1: Boot Area partition 1
  0x2: Boot Area partition 2
  0x3: Replay Protected Memory Block (RPMB)
  0x4: Access to General Purpose partition 1
  0x5: Access to General Purpose partition 2
  0x6: Access to General Purpose partition 3
  0x7: Access to General Purpose partition 4

Note that setting PARTITION_ACCESS to 0x0 results in selecting the User
Data Area partition.

Add char arrays to provide names for these values.

Use these names which displaying or setting the PARTITION_CONFIG
register via the 'mmc partconf' command.

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
PARTITION_ACCESS: 0x0 (user)
u-boot=> mmc partconf 2 1 boot1 user && mmc partconf 2
EXT_CSD[179], PARTITION_CONFIG:
BOOT_ACK: 0x1
BOOT_PARTITION_ENABLE: 0x2 (boot1)
PARTITION_ACCESS: 0x0 (user)

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v4:
 - use static arrays so we can use ARRAY_SIZE when evaluating
 - differentiate between PARTITION_CONFIG BOOT_PARTITION_ENABLE and
   PARTITION_ACCESS field values and meanings

v3:
 - define partition names and values in mmc.h/mmc.c for others to use

v2:
 - fix typo in subject
 - add names for gp1..gp4
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 cmd/mmc.c         | 27 +++++++++++++++++++++++----
 drivers/mmc/mmc.c | 35 +++++++++++++++++++++++++++++++++++
 include/mmc.h     |  6 ++++++
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 2d5430a53079..02316796ba4e 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -14,6 +14,7 @@
 #include <part.h>
 #include <sparse_format.h>
 #include <image-sparse.h>
+#include <linux/ctype.h>
 
 static int curr_device = -1;
 
@@ -918,8 +919,9 @@ static int mmc_partconf_print(struct mmc *mmc, const char *varname)
 
 	printf("EXT_CSD[179], PARTITION_CONFIG:\n"
 		"BOOT_ACK: 0x%x\n"
-		"BOOT_PARTITION_ENABLE: 0x%x\n"
-		"PARTITION_ACCESS: 0x%x\n", ack, part, access);
+		"BOOT_PARTITION_ENABLE: 0x%x (%s)\n"
+		"PARTITION_ACCESS: 0x%x (%s)\n", ack, part, emmc_boot_part_names[part],
+		access, emmc_hwpart_names[access]);
 
 	return CMD_RET_SUCCESS;
 }
@@ -948,9 +950,26 @@ static int do_mmc_partconf(struct cmd_tbl *cmdtp, int flag,
 	if (argc == 2 || argc == 3)
 		return mmc_partconf_print(mmc, cmd_arg2(argc, argv));
 
+	/* BOOT_ACK */
 	ack = dectoul(argv[2], NULL);
-	part_num = dectoul(argv[3], NULL);
-	access = dectoul(argv[4], NULL);
+	/* BOOT_PARTITION_ENABLE */
+	if (!isdigit(*argv[3])) {
+		for (part_num = ARRAY_SIZE(emmc_boot_part_names) - 1; part_num > 0; part_num--) {
+			if (!strcmp(argv[3], emmc_boot_part_names[part_num]))
+				break;
+		}
+	} else {
+		part_num = dectoul(argv[3], NULL);
+	}
+	/* PARTITION_ACCESS */
+	if (!isdigit(*argv[4])) {
+		for (access = ARRAY_SIZE(emmc_hwpart_names) - 1; access > 0; access--) {
+			if (!strcmp(argv[4], emmc_hwpart_names[access]))
+				break;
+		}
+	} else {
+		access = dectoul(argv[4], NULL);
+	}
 
 	/* acknowledge to be sent during boot operation */
 	ret = mmc_set_part_conf(mmc, ack, part_num, access);
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 7b068c71ff37..bfbf47a73009 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -29,6 +29,41 @@
 
 #define DEFAULT_CMD6_TIMEOUT_MS  500
 
+/**
+ * names of emmc BOOT_PARTITION_ENABLE values
+ *
+ * Boot Area Partitions - name consistent with Linux
+ */
+const char *emmc_boot_part_names[] = {
+	"default",	/* EMMC_BOOT_PART_DEFAULT */
+	"boot0",	/* EMMC_BOOT_PART_BOOT1 */
+	"boot1",	/* EMMC_BOOT_PART_BOOT2 */
+	"",
+	"",
+	"",
+	"",
+	"user",		/* EMMC_BOOT_PART_USER */
+};
+
+/**
+ * names of emmc 'hardware partitions' consistent with:
+ *  - value used in mmc_switch()
+ *  - value used by PARTITION_CONFIG PARTITION_ACCESS field
+ *
+ * Boot Area Partitions - name consistent with Linux
+ * General Perpose Partitions - name consistent with 'mmc hwpartition' usage
+ */
+const char *emmc_hwpart_names[] = {
+	"user",		/* EMMC_HWPART_DEFAULT */
+	"boot0",	/* EMMC_HWPART_BOOT1 */
+	"boot1",	/* EMMC_HWPART_BOOT2 */
+	"rpmb",		/* EMMC_HWPART_RPMB */
+	"gp1",		/* EMMC_HWPART_GP1 */
+	"gp2",		/* EMMC_HWPART_GP2 */
+	"gp3",		/* EMMC_HWPART_GP3 */
+	"gp4",		/* EMMC_HWPART_GP4 */
+};
+
 static int mmc_set_signal_voltage(struct mmc *mmc, uint signal_voltage);
 
 #if !CONFIG_IS_ENABLED(DM_MMC)
diff --git a/include/mmc.h b/include/mmc.h
index 0f3f1ed6aaa3..2e2f5dd12b8b 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -389,6 +389,9 @@ enum emmc_boot_part {
 	EMMC_BOOT_PART_USER = 7,
 };
 
+/* emmc PARTITION_CONFIG BOOT_PARTITION_ENABLE names */
+extern const char *emmc_boot_part_names[8];
+
 /* emmc PARTITION_CONFIG ACCESS_ENABLE values */
 enum emmc_hwpart {
 	EMMC_HWPART_DEFAULT = 0, /* user */
@@ -401,6 +404,9 @@ enum emmc_hwpart {
 	EMMC_HWPART_GP4 = 7,
 };
 
+/* emmc PARTITION_CONFIG ACCESS_ENABLE names */
+extern const char *emmc_hwpart_names[8];
+
 /* Driver model support */
 
 /**
-- 
2.25.1

