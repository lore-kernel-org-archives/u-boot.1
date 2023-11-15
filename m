Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E65AC07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D788F87208;
	Wed, 15 Nov 2023 13:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="VjmLQlWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D39187160; Wed, 15 Nov 2023 13:44:40 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80435871A6
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk6/twQHA/8Kd3ru+QoloqPCGftTXEAqLje/dOtEe7t1MKiq/flahEVqa7IkAjyxmnHVauhIBVtaR3CLdFgQ3IDWmv2CvOP5HkszbiVjPv9CHbVj2CwpuYj0sfiXDnoZDCgcc6F6J265ltdNxU4+qMAvdG6Ck9SYUVu/S2sSUdriGosFhgwnx6fCqQxJKdq5StfYzT/mZ282qUez06733u1ig7in62QW4bdMnLBJlV7jQeqSVBAv2pC74AltsSfylcocQtYjbMrSvQh6M5ATZ2Pjy5cs3ThpAjDxMjIoBVPzAFB341lZoIJzNUEQ4IroNGAutFoU9/8GBzICOhcUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkDbHcu2XzzhXhsT6ZX79W1rj03OXni3DzwEdYQ1yQ0=;
 b=SA2pdkLduO5aQqeWBQrSWTPl3jUMgwuddlzuc2PKPZ4mrqnN88EnymKQwMu58HGnOvfrCsQbpiuvlAr3ZsgnJcwvYwsOLI383zq6ORiJjKBxN6qI8moTPAeY9OjeZveMLU/hpN2H8L8TDNm6Quw5W3pwA2kSuAqdVhAXCW6fJVqXWYDU10s9mfM8t1YDBTHGi3ZyudV+D72iwH3OW20mKf0H2ZA1TAifQBB5V5F6mvzJTompIkjk4UJarzTEjmwDzEx23enDmVcwGAZl6hZXYvb+bx/39f9XCioxMvoAJ6zWFrQYy2M3icAMGrIBuz9r2VpkpVNV7+ylJF+hMTwU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkDbHcu2XzzhXhsT6ZX79W1rj03OXni3DzwEdYQ1yQ0=;
 b=VjmLQlWwPnVevwSLIN1EbnLQNQYmPe5vUK8e4l+KqlVoOne1n7r+2sTy0gdZEpgJ7a8KA9eg81oxi4bAFH9cxaSVJwPFO28BxitJWtShVLRofraPxU8D4ONag23cEWL+Ch1JU2h5DPyayda7mF3+9aVi9y4nIDx6DC1yq0jwxcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by AS8PR08MB5911.eurprd08.prod.outlook.com (2603:10a6:20b:292::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:44:35 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:44:35 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 3/9] fs: fat: calculate FAT type based on cluster count
Date: Wed, 15 Nov 2023 13:44:18 +0100
Message-Id: <20231115124424.125823-4-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
References: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AM0PR08MB4946.eurprd08.prod.outlook.com
 (2603:10a6:208:165::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4946:EE_|AS8PR08MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 96492b8b-7742-4f8d-5b6b-08dbe5d89f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bie7pz8nfCDb673rjaA7uRIAfM3rLSX0l3DHE2vtlals1a8n8uRvhsGeKXxBptoBllXzwEyhu2fA7tk70/W6DcpGJsr4WE0TslOAx+ObF6DSEm2GM4aiVJVXoHs+jkY4HFRrYhqR+Zn/uiBT7C+oTBh/md1FVMM3424LbgbcmW2Yd8RHltTIqLlW3V0QLuVK0LHDsQY+/r0UTx6Q5jeTuadMjI+zlIVFzZKGcTCCFZGCCFVHIxBzaVT2X2fLYNeKZV0giFjbuzt6USFWZtlMA9BrFk2UjfAdbC2chtooXp1C8peDcvnMzz8+3DmzSDfwbUR3W7wjLb1Vy1cy/qMFlE0S3547rq9yUrmcG9SF4L1tjNnDMqqLS0dpeahd9Q6QkJ33NF2VCjCaXjZvB4wHmI1E9NlO3wfuGB4wvd7HtkARzUn9cQPb9InzCb1N0LzAI/BSlEnALy6PWiSgk6qgnIqJjezKBalaOsJ7J1XYCHETE+ahr8MKaMKML+uxSf8zEz3ipd4zGLJabL99xXFF1nP+mwRGwY4zAMwMWa6Ru2Vs5v9D8SAz9cxAMaVUOt7vD7pDK8eBhBECU1bKnrYRCs8OkICY6OyCCJSPodZYIk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(66476007)(54906003)(66556008)(6916009)(38100700002)(316002)(66946007)(36756003)(86362001)(6512007)(83380400001)(9686003)(26005)(6666004)(6506007)(2616005)(52116002)(478600001)(2906002)(966005)(6486002)(5660300002)(41300700001)(8676002)(1076003)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MbRMwYZU2Aysxmg/9WOXjxHeY7kZKLJwS5VLFV+WiyKeH50O0M8PVZ+hi9+Q?=
 =?us-ascii?Q?laxLMHCRJZrKgNyaypkdAIozbn0Wlq/AZFnGF+4IfULjd77wfwtSdcylSbBK?=
 =?us-ascii?Q?r8E3D5ti757M/eDtWeFZfrlpIssqgt78hgjwni+Ur2tZPfkgYanaYTISQw4f?=
 =?us-ascii?Q?apgoTum0wZCpTcF6JNff1jdUsTqsVJRHBizg3jguTalMrZuPEUGF3q8pMSJq?=
 =?us-ascii?Q?EImHFVyWn61rgaN0FBUovu5mlTpXLwdlAASz1OiGFKRhV7q7KNXy6ZITtjgm?=
 =?us-ascii?Q?3U/4cK76dj+mnLusZyq+AYQlOB1Onvdja9WhJ31+9rp9t8aV610htHGNYkLl?=
 =?us-ascii?Q?J6TmHnAVM3F9Qa04oo5GzHveq8FeKiHqdKf06pSUF8IkAWe+XuGkM6SY6vnj?=
 =?us-ascii?Q?s7umEAnJGKP6WfrKwIb/vzeJNrxKr9h0yv7xJTEZ90qsXp/Zk0Ty8GJHUtSv?=
 =?us-ascii?Q?3O/6s3/rQt3sIocCtIu4EpH++C4qirVlLA6gHD1xKbs0MPt9v0Fcc4GEmKZL?=
 =?us-ascii?Q?HgrEF1qZfChUw5197eH30KY6V7hBKsCBNhHDJBiY2OChsl6Iti7FKeDROhNp?=
 =?us-ascii?Q?MQzetgcV+sYTO5XX9VGrR0PvAkcmwqdg9jfRWXOLhn741/w5nRxzrYoAjOiM?=
 =?us-ascii?Q?7wXu7dS1K9wxd7skUvR8vKib/wN7bqmGP8EpKv7KHVoOHMzSBkpsrRQaUw7C?=
 =?us-ascii?Q?wMW5xZC1toIkEc3JAanPJy42zwwLhxaRz/L2Ssks/q3OM5F2xR8Fz1tlZjNK?=
 =?us-ascii?Q?/HQJXpEvYeFA4i5+ttxK5CnXSL8R7JGYI9I48MBTcqnlXPAbrDxLUJPTdM67?=
 =?us-ascii?Q?RPrU1HwZB2XykHc56pOVnduIAJ3Tjf+eyjtqiqRl2qXHjTHOz+5+94sI+MYE?=
 =?us-ascii?Q?dUziGmUiGkMMaynE5+DLx+e+SbxXeYGjZ3OytTtF+3Gxb9yLj5PdJzvtlP/7?=
 =?us-ascii?Q?Fv5I4aOMDLnzMNHJZkHoCkSHMdJQrKXINASFrzCaJCA2FbctwoobC31PuXnK?=
 =?us-ascii?Q?NolTLMweiPcD7kV5mnx/idZUW83IbAfc59fOOkTfTpd3QSRTv8TmKzjzyRnM?=
 =?us-ascii?Q?QTRW/65sx0Wz8HeW9INGSW7c0L9IYEzryPjAhvkXKS7Yf7TRWN35hfZGyl6E?=
 =?us-ascii?Q?T9iGz149bpUIJYc3ta4cLV8kZA4+hUxCn5yxiVOOXHn6cdlxRnnY5X/B1nvq?=
 =?us-ascii?Q?uGqYrJR3T4XMTtX3JaBkYsUDs+MzJt5/XkXNtYISkE4GtP1p76xAzww3h8la?=
 =?us-ascii?Q?p4Y67lH9q6GqMVUWemjUvK7e9SV8THUEnvYoQTbqSH9ENASXnuYh1AguWeeF?=
 =?us-ascii?Q?Y2Qn7UTWR0qmt6WBHmrwCneW526vBqFlUES23W2RdO7DvLsf928IoVNYdggF?=
 =?us-ascii?Q?5DFxROqU8c1ReSAZNPKA7WsI+M9p6yQvP6syZEjC/TyQizs13MthEx+gOjyy?=
 =?us-ascii?Q?YYPllnE7UOM7e7tQ5M2XJMVJwXxUBY9/qThIRIwgxW5/orpxrhFsx6otSbnF?=
 =?us-ascii?Q?Nwzn8SF/Yr+a6gzMV0I4Ci42svl00/wbR7rr12UZ5FP5FNgXBIwa+5rKjM7M?=
 =?us-ascii?Q?1d48tNTrAi96M0vMOPRNinMb3YKBKYjBY9aw4SF5BAPbNBgx6vjlA8PSSTDy?=
 =?us-ascii?Q?20CM3SceYdWX5vkrfIWtJW+R1PYKhcmuoUZkOlAlHqVL?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96492b8b-7742-4f8d-5b6b-08dbe5d89f4c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:44:35.2179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FNMOXijiqsbLMV1dWkFUMP0uTscjgHpAvKnEeaC6bE6PTjYLCn2SHj036o2jpxqgNeKvQh0SWf5JaBURuNCfMpB7QSVUZqG54djPxlBgqBPtj4hA09s2PNJj42UHaVw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5911
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

(no changes since v2)

Changes in v2:
- Use get_unaligned_le16 instead of custom macro
- Extract FAT32 logic from determine_fat_bits() into
  read_bootsectandvi()
- Rename determine_fat_bits() to determine_legacy_fat_bits()

 fs/fat/fat.c  | 48 ++++++++++++++++++++++++++++--------------------
 include/fat.h |  6 ------
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index a3522340ef..c368c3b076 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -26,6 +26,9 @@
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 
+/* maximum number of clusters for FAT12 */
+#define MAX_FAT12	0xFF4
+
 /*
  * Convert a string to lowercase.  Converts at most 'len' characters,
  * 'len' may be larger than the length of 'str' if 'str' is NULL
@@ -484,6 +487,27 @@ static __u8 mkcksum(struct nameext *nameext)
 	return ret;
 }
 
+/*
+ * Determine if the FAT type is FAT12 or FAT16
+ *
+ * Based on fat_fill_super() from the Linux kernel's fs/fat/inode.c
+ */
+static int determine_legacy_fat_bits(const boot_sector *bs)
+{
+	u16 fat_start = bs->reserved;
+	u32 dir_start = fat_start + bs->fats * bs->fat_length;
+	u32 rootdir_sectors = get_unaligned_le16(bs->dir_entries) *
+			      sizeof(dir_entry) /
+			      get_unaligned_le16(bs->sector_size);
+	u32 data_start = dir_start + rootdir_sectors;
+	u16 sectors = get_unaligned_le16(bs->sectors);
+	u32 total_sectors = sectors ? sectors : bs->total_sect;
+	u32 total_clusters = (total_sectors - data_start) /
+			     bs->cluster_size;
+
+	return (total_clusters > MAX_FAT12) ? 16 : 12;
+}
+
 /*
  * Read boot sector and volume info from a FAT filesystem
  */
@@ -518,7 +542,7 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 	bs->total_sect = FAT2CPU32(bs->total_sect);
 
 	/* FAT32 entries */
-	if (bs->fat_length == 0) {
+	if (!bs->fat_length && bs->fat32_length) {
 		/* Assume FAT32 */
 		bs->fat32_length = FAT2CPU32(bs->fat32_length);
 		bs->flags = FAT2CPU16(bs->flags);
@@ -529,25 +553,10 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 		*fatsize = 32;
 	} else {
 		vistart = (volume_info *)&(bs->fat32_length);
-		*fatsize = 0;
+		*fatsize = determine_legacy_fat_bits(bs);
 	}
 	memcpy(volinfo, vistart, sizeof(volume_info));
-
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
-
-	debug("Error: broken fs_type sign\n");
+	goto exit;
 fail:
 	ret = -1;
 exit:
@@ -1157,9 +1166,8 @@ int file_fat_detectfs(void)
 
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
-- 
2.34.1

