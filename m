Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A944DC4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 12:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43EFD8767F;
	Wed,  8 Nov 2023 13:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="2NJ0knJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E11A08767F; Wed,  8 Nov 2023 13:13:07 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED955876D1
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 13:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oix32RX4wMhPA7bvcVrj/4hIW3FTW39q+6KUjLaIFILbL7P8dAhJFtRtguHkhht9XrtHqa+SksP1J0Yo9CjeME3gambU1Nisslj5rwcnEv975bWBS9u2krYAZm86MGPnsMNVOlB5ll2Dj7Fmypu8hLD3x02DaRotxBFPwXngs0h6EqHuLVqT/LlfxVR84iwy9cOF78d2QGcA0IYvJCKZhz4J91jT4Qn0LSxwQNnc6Yc/AR0yBGP7bVwf2zAz8tCdrm8tTOWYm5I0kzYIh03PR1pGphUlI7GlUfFzpRaNjBISDTsfiulFyPuu6fex2JjQQdAfV6R/UU0P3oDPmDClYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkBRhJ0hPYhI0BZlwk3gbAT89b5LRnJ7AlyzxFRzS9Y=;
 b=b1UhVMKZEeYMSufYVzQiN3cNDzDwAVwdVWSM6/4aRL7aBG76KfpRisbKThjQUiXFbmiTZqjMXHPlU9G/fnSa9ZWcyD5EODHnRNNvWo4hSyCIJNiBpUZ4MAXidXqEWi1P3TlBthZE3lQrkNKHm3Ae3wVlEEW68D7/g2X+rLWV2OQPsKyNSPppGVq0Jbngl9Qvi0q7rwfXA+5N1tEw08cOdsYB/RmQeyfjnLiVdOoCHcAPJml9mYr6uBn8S5iVKT7wkTGkBUFk91xYdqwEjl1X/2gjhqhRA8/0KJsPRq4Wcj3i85ztaHbflA81gdnYBKMI/Vhu2GOXpy9DONizti3w6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkBRhJ0hPYhI0BZlwk3gbAT89b5LRnJ7AlyzxFRzS9Y=;
 b=2NJ0knJcTcrXy9C0ZIWXVXxIOcDRIsugD9opXNGy2aQ3z9FsCRgpYePaRiBS1lZt1VVEB6gH3Eba6wps0uT/YcaKUZ4d+dXrhV1f6ZVYl18zN2ObtMxwQaZzO7fUQ+45AH8FTIP3qsgrVwBXf9+SfKCgFrAe27473s/9l6GovZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by DB8PR08MB5386.eurprd08.prod.outlook.com (2603:10a6:10:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 12:13:03 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::512e:4ffe:2678:395f]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::512e:4ffe:2678:395f%4]) with mapi id 15.20.6933.029; Wed, 8 Nov 2023
 12:13:02 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v1 2/2] fs: fat: calculate FAT type based on cluster count
Date: Wed,  8 Nov 2023 13:12:39 +0100
Message-Id: <20231108121239.26737-3-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108121239.26737-1-christian.taedcke-oss@weidmueller.com>
References: <20231108121239.26737-1-christian.taedcke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::17) To AM0PR08MB4946.eurprd08.prod.outlook.com
 (2603:10a6:208:165::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4946:EE_|DB8PR08MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 112ce44e-26a3-4073-7658-08dbe0540e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wm8XiJVGLi+Z5p0KzfnK0pEXjNkH7nMX8fV3e7SUBZXenkMk4eMG9do6zzL5wUfmpfHD6LkCb+54XbPL18teeEGtrNn9jIkhlAxJcQ11aVfhzuKAT4mqV+/PY5fR3336B/hgZ8+7S77m0d9LW42gszp7TobckBqMrzTQH8oRMQGGvJc1rXrkQJEYWlR/dYdmcnGNNjSsy17XdDBxHy4E8gSMNCg4wmVmZ/tQnAG+yLFA64Ju6KQnwFOxKzfIftwNcCgJ/Smok2MSs59q8nGXZUuCZP2WpX+wl4fq6piUsTnuWtD6vDJNoSU7k2wLhbEEzHw94z5Kj1l8A8GWM4RpaQYj2jdUPWsLVvUSgnkiodUmFPm0VD0iv1T/2xDZhI/zcOff/TPLetioCut1xGh9RKgvQfF6wAdlis41SXfWCzhOgoyxk5zA8eIAS4y8U5xAwstOo6AD4+5lV/GLP8/NIYqtOrRMg9J4MCsq8SoGdyn+5cxvoRcbLDYBh1rGlzrcy4/IA2ZSx5WNd0E9KcXft/RT0D49yambxHBZhMHNtiTzCY/zxFhifgKCpejWdn5A6F7pzoR9IVJayfxzBZ8azISa0ooYYB4zF9IgKOzU8OY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(1076003)(2616005)(6486002)(478600001)(966005)(6666004)(66556008)(66476007)(54906003)(6916009)(6506007)(52116002)(66946007)(316002)(6512007)(9686003)(8676002)(4326008)(8936002)(41300700001)(26005)(2906002)(5660300002)(36756003)(83380400001)(86362001)(38350700005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tk0Jrlch4/vRF9q8zUnhLUFwKbbzJpQX9t4uMWhNo1YG4T4AA9dN4KC+WVTi?=
 =?us-ascii?Q?OPOboX6J5MCrWwGmbSJSw8kPgXEyypvds6wPubyYINSusEbUBA+5tFvmuQ6c?=
 =?us-ascii?Q?tsdEfDZIJv/hU/NAUoT8MkXeZSnnCT92SI7DrQ3SmCWzgKCQaPks3DIjnlw8?=
 =?us-ascii?Q?nvAzGl3kznHFRvbJ0HnQk7MUQMfsXXXkKcg6/fJuYoLVLFv1vdFluntHQ+V5?=
 =?us-ascii?Q?ZUO1ytF51buNLAJgPeinra48JRWWkeVSoAMb9hErRE6lLmdS9SYM5AmMayWi?=
 =?us-ascii?Q?F4WVEIxH1SJJooGc8AycgMogC6LhqyK+m99cnZNMunbdfa5EI5rcHSll9+v3?=
 =?us-ascii?Q?E3KlOjIVEi2F1KNcV9o0tFabry/npNvcDH3QQRkdySkfLF6ep0mOp+brdueD?=
 =?us-ascii?Q?1WU+BnGkdmgGVIfqxI0rznxNJzowCTFWSqdKfhqzBmrHV/+G4m9RSKcOYdz5?=
 =?us-ascii?Q?OCr2dwenWbD7AeQEazgqXn8REcphrq5YKs0e2BRtK6D9uwfcXHPc4iZUFJCy?=
 =?us-ascii?Q?Nc3fZ2X6GsSJlApMtAHS0kAP6Ji8zJt6M9B+tP//YALPYKf9kVJvU1JmqlCl?=
 =?us-ascii?Q?KEIB3KQqmo1AwK9EKtr1MWXfG/TmaLiCLKXeTUMoCfbUNdizp9dRrrV2150G?=
 =?us-ascii?Q?LCnl6TKvWBFmAWEMFAGFXpKG9lEDJcDiuchwmPofNu75hlOiZGlkjseI8+BJ?=
 =?us-ascii?Q?i5wJn7FabF/LUt4jxFuP6uJ6X8zAneGqaibxIYskdcsH4yIsFiaQMKQIpLcQ?=
 =?us-ascii?Q?zad1vFBTpKcrNRqO8F2ImVTfSvMVdTSx40MiuE7KbaDajmNSzdbmjEY27GG+?=
 =?us-ascii?Q?jmetpvRiaKCZIjnsJSOATcvPB8aRujPsN4W/Jc4TonzSVLRj98QZdA+K/tK8?=
 =?us-ascii?Q?y6m8FK55q+u4mc4XUMmXi+C40pjra7Ct+/72zXX2ffbm3C6/2f7yFLolkiTk?=
 =?us-ascii?Q?ESr3BXbMguLOiKC0h2qtM0pPBEJeo+yaA+C2Y+YzbNme8x3ysW/fKI5AaH/q?=
 =?us-ascii?Q?+CD7xS3vAVlYBMLQ8ArerHwJ9e3N6d8nEc/TWVdO387/jCNUqSpJC+W8BNeQ?=
 =?us-ascii?Q?52t/8E6Nk4goNTcBwFUb2b2HVjCgrPGNQz8BLkrdTgwtqiEznnP/h88YRULL?=
 =?us-ascii?Q?2ldli3Cy8zVzbz+aTUpvCBmq/+Aqz7QPY5qLN2PvD3d62rjA8uWAV+iJ2lS+?=
 =?us-ascii?Q?OvxIl1VVyTekq2qWvOWzps8JubyM5ldvCBOjzLs3W5awf0GFlGh+59AWFesO?=
 =?us-ascii?Q?XhO3YqRB/ShCDqGJCDZdg4UV0jrHS/XLhePCU4VmO+8NbcmU3A7X/XKOhEWT?=
 =?us-ascii?Q?X0f8rISGJjYvvm4DHbtkyAjfkTmTFnNs5z93EglhE5jYxL+1bStiETVDSizC?=
 =?us-ascii?Q?8pfwc30giGP7aMwO4Uw3CADRX4lBFrzDlF03BW27OlhlfFIBaRs099kGCFo4?=
 =?us-ascii?Q?2aIwvWBthab8O0KZTiGoddvtrfqDIwwVln+f/hwBbcfHlEpEnfgeQSHWe9Cp?=
 =?us-ascii?Q?NL5xGn+immrrmrPE1hVNhRXmGl6fcfFKPxi8VkGO7BvyocGIPZryeng95dS/?=
 =?us-ascii?Q?zFZjHXEj4ZYKu86QWnSD1aHpD2ifVjhClK+BnyHcC/kr1sVxN6Vk62V0L6Ek?=
 =?us-ascii?Q?whZGR6W7mWLc/nxtv1bXPjuAIUE2PFz1EtHq+5ynhevg?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112ce44e-26a3-4073-7658-08dbe0540e75
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:13:02.9128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Xl2GwrupRdw8aJlqI0oMpd1eoOZtNYMboIDwredrhvVVJ9njIBPZKphH9ZvdxCp+zIsEi6t1J/Qp6TisS61pCn/J4GPBY4H4zaUpQF5V0YbC8ibg+nbk89JBXwQEnUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5386
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

From: Christian Taedcke <christian.taedcke@weidmueller.com>

This fixes an issue where the FAT type (FAT12, FAT16) is not
correctly detected, e.g. when the BPB field BS_FilSysType contains the
valid value "FAT     ".

According to the FAT spec the field BS_FilSysType has only
informational character and does not determine the FAT type.

The logic of this code is based on the linux kernel implementation
from the file fs/fat/inode.c function fat_fill_super().

For details about FAT see http://elm-chan.org/docs/fat_e.html

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

 fs/fat/fat.c             | 58 +++++++++++++++++++++++-----------------
 include/fat.h            |  6 -----
 test/image/spl_load_fs.c |  2 +-
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 8a0f4e4e6c..9179257ff2 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -27,6 +27,9 @@
 
 #define FATU8ARRAY2CPU16(x) (((x)[1] << 8) + (x)[0])
 
+/* maximum number of clusters for FAT12 */
+#define MAX_FAT12	0xFF4
+
 /*
  * Convert a string to lowercase.  Converts at most 'len' characters,
  * 'len' may be larger than the length of 'str' if 'str' is NULL
@@ -485,6 +488,32 @@ static __u8 mkcksum(struct nameext *nameext)
 	return ret;
 }
 
+/*
+ * Determine the FAT type
+ *
+ * Based on fat_fill_super() from the Linux kernel's fs/fat/inode.c
+ */
+static int
+determine_fat_bits(const boot_sector *bs)
+{
+	if (!bs->fat_length && bs->fat32_length) {
+		return 32;
+	} else {
+		u16 fat_start = bs->reserved;
+		u32 dir_start = fat_start + bs->fats * bs->fat_length;
+		u32 rootdir_sectors = FATU8ARRAY2CPU16(bs->dir_entries) *
+				      sizeof(dir_entry) /
+				      FATU8ARRAY2CPU16(bs->sector_size);
+		u32 data_start = dir_start + rootdir_sectors;
+		u16 sectors = FATU8ARRAY2CPU16(bs->sectors);
+		u32 total_sectors = sectors ? sectors : bs->total_sect;
+		u32 total_clusters = (total_sectors - data_start) /
+				     bs->cluster_size;
+
+		return (total_clusters > MAX_FAT12) ? 16 : 12;
+	}
+}
+
 /*
  * Read boot sector and volume info from a FAT filesystem
  */
@@ -493,7 +522,6 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 {
 	__u8 *block;
 	volume_info *vistart;
-	int ret = 0;
 
 	if (cur_dev == NULL) {
 		debug("Error: no device selected\n");
@@ -508,7 +536,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 
 	if (disk_read(0, 1, block) < 0) {
 		debug("Error: reading block\n");
-		goto fail;
+		free(block);
+		return -1;
 	}
 
 	memcpy(bs, block, sizeof(boot_sector));
@@ -527,33 +556,15 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 		bs->info_sector = FAT2CPU16(bs->info_sector);
 		bs->backup_boot = FAT2CPU16(bs->backup_boot);
 		vistart = (volume_info *)(block + sizeof(boot_sector));
-		*fatsize = 32;
 	} else {
 		vistart = (volume_info *)&(bs->fat32_length);
-		*fatsize = 0;
 	}
 	memcpy(volinfo, vistart, sizeof(volume_info));
 
-	if (*fatsize == 32) {
-		if (strncmp(FAT32_SIGN, vistart->fs_type, SIGNLEN) == 0)
-			goto exit;
-	} else {
-		if (strncmp(FAT12_SIGN, vistart->fs_type, SIGNLEN) == 0) {
-			*fatsize = 12;
-			goto exit;
-		}
-		if (strncmp(FAT16_SIGN, vistart->fs_type, SIGNLEN) == 0) {
-			*fatsize = 16;
-			goto exit;
-		}
-	}
+	*fatsize = determine_fat_bits(bs);
 
-	debug("Error: broken fs_type sign\n");
-fail:
-	ret = -1;
-exit:
 	free(block);
-	return ret;
+	return 0;
 }
 
 static int get_fs_info(fsdata *mydata)
@@ -1158,9 +1169,8 @@ int file_fat_detectfs(void)
 
 	memcpy(vol_label, volinfo.volume_label, 11);
 	vol_label[11] = '\0';
-	volinfo.fs_type[5] = '\0';
 
-	printf("Filesystem: %s \"%s\"\n", volinfo.fs_type, vol_label);
+	printf("Filesystem: FAT%d \"%s\"\n", fatsize, vol_label);
 
 	return 0;
 }
diff --git a/include/fat.h b/include/fat.h
index a9756fb4cd..3dce99a23c 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -34,12 +34,6 @@ struct disk_partition;
 /* Maximum number of entry for long file name according to spec */
 #define MAX_LFN_SLOT	20
 
-/* Filesystem identifiers */
-#define FAT12_SIGN	"FAT12   "
-#define FAT16_SIGN	"FAT16   "
-#define FAT32_SIGN	"FAT32   "
-#define SIGNLEN		8
-
 /* File attributes */
 #define ATTR_RO	1
 #define ATTR_HIDDEN	2
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index 297ab08a82..90e640b5de 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -220,7 +220,7 @@ static size_t create_fat(void *dst, size_t size, const char *filename,
 	bs->root_cluster = cpu_to_le32(root_sector);
 
 	vi->ext_boot_sign = 0x29;
-	memcpy(vi->fs_type, FAT32_SIGN, sizeof(vi->fs_type));
+	memcpy(vi->fs_type, "FAT32   ", sizeof(vi->fs_type));
 
 	memcpy(dst + 0x1fe, "\x55\xAA", 2);
 
-- 
2.34.1

