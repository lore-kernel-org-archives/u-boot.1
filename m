Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C74C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 09:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E3DF87808;
	Fri, 10 Nov 2023 10:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="eRjyXbfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02CAC877FA; Fri, 10 Nov 2023 10:42:34 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC13C877F2
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcwIv5FMC/nDgapF//rbBsBER+Vd4Xn+ktl/j6l86Y+lD1NPcTc2HrxvVbmDuCNryQDvjbWsH/w1+GwgQB4boWbxoQlE47Rmk/vhVvzsc+7gfrRgPC8KWKwrOglubODIr7JAEb2HPIW9m9nBjr/9slvcK3/hVgrRucrDcvCmaLb1UHmAOd0bHwOEHokmNH9lcEZk4biqLzewyJD5Nab84MgfBSDzsYsdqdwxPvCD8rCHwVGPHxVR1fEUMZTCkUSvtyXV0/ixhzpFxwQigR4t1+/53+rofle95cB4z0Y0hMvVa8iqLijBaMTcXlfmDk6I9qYgbnvVoSD+p4St8ARngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFgKMxmWhUvoaBCt/osovz9aW4NHUnTtlu5a8yEIjXs=;
 b=gJ33s1oi6YVCg+j93YBZXlmWD1QLzOavLjAFV6swlrFCeBQbAdhBySVaW2mNffTlXFpeU7KY5Q4nnbKCy4x8yNkWQ45/3XAv6WrJqn0DGaXXKnCeepsMT3MGU7llLKFnsTiFFIXqfhvu1whyAz08H+781JWJRaJciqVzzwiwp3AqGjBvvv2YvI5oP2TNXqLxGUp3pWBRt1Adk8r0+oyYsToJEUqiVbegPZrx5UXUTGOcjcb/VfdArA1fYsM/EL/0oppoaBtjdZnmhTap9DdHD/Dr8vxfHDMxz7rIvB7Crrwn7h+awRusAdvXBSbwMvvTiEhTsQCKmumhEs287voKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFgKMxmWhUvoaBCt/osovz9aW4NHUnTtlu5a8yEIjXs=;
 b=eRjyXbfSs2lh1nF43/j3H6JtMT5vtdxoPe+2Teg4sgOkDoaUoSlU2opiCXyBv4SCUdzgtf4n9lTWlUjG5PSn0rApeqf5Y6030/DCE4A+U2la0yaP5qVv1G6uf1bCbWZoQ+PCGIPDfgoqhjex/zPEsecU8ZGOfFExGHpyFJ+sPus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com (2603:10a6:803:110::20)
 by AS8PR08MB7910.eurprd08.prod.outlook.com (2603:10a6:20b:50b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 09:42:29 +0000
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0]) by VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0%6]) with mapi id 15.20.6933.029; Fri, 10 Nov 2023
 09:42:29 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/5] fs: fat: calculate FAT type based on cluster count
Date: Fri, 10 Nov 2023 10:42:13 +0100
Message-Id: <20231110094216.50696-4-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110094216.50696-1-christian.taedcke-oss@weidmueller.com>
References: <20231110094216.50696-1-christian.taedcke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To VE1PR08MB4959.eurprd08.prod.outlook.com
 (2603:10a6:803:110::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4959:EE_|AS8PR08MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf0817e-fa06-4320-62e5-08dbe1d15b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUZ+jU3pzJuywAkD/twVO8kkjBV5RpmeORAJB1T8Nchwhojdl9tehOzseY+6i9k3gyynL8IcxMBxZ1XsgLLmIWAO3/2xlITSjkTgfiEAdAhmya+1lbXuY+U3AzkACGw94dxwpyiEI0UveNv78kpDBKezAjnznWubNwGqRFb0qGOJEPixrTcUFSVMJE2Z200OFz5Q2L2bkA5rljWNSCLgfuCp44rEoB5lq4okOx+7hi7IRTylFb+whEzcrMiUEQnFzLUZIZ1hlBmkTGJiGkY7AZ6FLn/3TlVFur+po5YQveQKWi+105RuySbJ0M+IXUUnub+7rfSGslKLWYGV6Itv/nPVrCbsJnWMj4DcH3PuUTddAXKUaQsxQSNkD1rGnIiou8J021q3smjOAjm9aXCuJuuN/ynV4pERTzXeIWHesWNQlYdv1TK7x38vJKvozSE4aqbnhV7j7k1HtycZXAz01g4z2xQO8oqM9FGjckAhyw8gdD/oohBTwd2VvueHr7kk65BUK3HRLSb2BlDWenbyvkQ+RbOv0hWIB/CV/terdJ5eUwLWdNQqNJfIm5zmwP9ip9ugaN+Kp6ZKJtKmogWflwssd+DcrL9UY+vIpVhizzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB4959.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(966005)(26005)(2616005)(9686003)(1076003)(6486002)(478600001)(36756003)(54906003)(66556008)(66946007)(6916009)(316002)(66476007)(6506007)(38350700005)(6666004)(52116002)(8676002)(2906002)(38100700002)(4326008)(8936002)(83380400001)(41300700001)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sOTvKgNSDhPU5LhBaMr4wQrP7jnqKBhJwStuVkt90m8duMqzs7yGVo3neg+X?=
 =?us-ascii?Q?v7yOgScXHcVuGVWUva+28XpzTC9PKDUllBJwRkweZJgEj3yi67Py+AkJdZeF?=
 =?us-ascii?Q?NDmdVYyiAORgh/dIL3sQORhxSUExPkuaYvRLHOYAEqJevXMVKulxSTja3Z6w?=
 =?us-ascii?Q?vx4LS6lqgG81h7ieja1ZQZn4vnqttww/KYm1njJxxf+jM9CMfU7xDHECgA8n?=
 =?us-ascii?Q?ZHcNMFYo9hejpatfv+HRnecDz+11guzWf/5Y9zxZ51RZ+RTzOo5Tdamtw/lv?=
 =?us-ascii?Q?88w85KYFR1Ei+29stLwSw40cAVkPoU+55PYJyxsuRQFdnIhlwG2VPZ3hFpfz?=
 =?us-ascii?Q?I++dm8uk0qNZDDqo2KKLARNrch3vnMyQRTQ3sLFGi9QbYnITYnooYDYxD7eN?=
 =?us-ascii?Q?YAYaMD9Tg1X66hAsBfV5ACoeMNLJ+0ARCgzijb9JyBrlp3ek4x6XY722OmN1?=
 =?us-ascii?Q?HvwFVMuWvf/PRIzl4PgrVG0IfstvordmD1pJvytjAGtCduEEFQXc1DRME+jN?=
 =?us-ascii?Q?wirt5CY2tiLkVvMkb3OVswUmF+1kxTkd0DMJzLkR32B0OPrEmFspSbSTQ+qz?=
 =?us-ascii?Q?Y8z9ZBQ8GGibE1ZNxUeuQpVOhYJTv1MA3tNTxNY3D7Mb7bFgkH6gQfnBvFwU?=
 =?us-ascii?Q?PtCPlgmfi5PZeuUrFa6q5hNW5Qjwhk0KXLvAKFeuhlUOJ/WXCeitZdCwcCt8?=
 =?us-ascii?Q?ZpIUXHTupAnqLf6hJCc9Jny/eakodxar0PxoV/K6qRSo6LI+H3aXWdNVqtJS?=
 =?us-ascii?Q?5tNeh0+Bp65IsHemGKkQFN2ucSbE6FZou14H4sf64FQ4+62Dsmz9+xitU5DA?=
 =?us-ascii?Q?45O5Ey8nO7oyHKU7X0pkioapoImLlEOyEdFomKVnZQS88iZkRRZpgz+wanNM?=
 =?us-ascii?Q?lr+70lqdkn1hTpxixVOgyVh1FdcLosL+gUHDWZLMyXD6QRpbtACioGbFLAeo?=
 =?us-ascii?Q?4Xw2bFJvT45Z98azn9kftNdId0G9nkHdQpXRmssseAHOgzpulKptPIV3BrNv?=
 =?us-ascii?Q?cRnXtWE6XGi0asjLgBrY95GEzavXNFpTbAlehj1kQDX6KAJaJHL9vHw+i6en?=
 =?us-ascii?Q?bgmxpzyhYz9+nEz51qh2a8LnfE9CU09rjMBmYhZNNmZlza5EfJeTcXjMwz+r?=
 =?us-ascii?Q?WdV5DoBLqaiQfWyeNfljXhaZnI69/DnOqpwubWaz26vIXaS8aOmWuPvnvmjd?=
 =?us-ascii?Q?tGEBrbg1SaSR04gE6BJYXxO+LulFoj32CJOTOYOuG16srZ0xwRKnJ0aHQ8hm?=
 =?us-ascii?Q?qZTUBFrm/aW39e60+R1f4FeyPt3xVT5eDh2nt3IGa31edVA3uRX/k0sgF+5U?=
 =?us-ascii?Q?aDR+1yY96hrx2S7jygPkvC9yO+KGmOAl7ZOJscXMNUzjM0knky+E+E7I0DlA?=
 =?us-ascii?Q?tonZaIrfKh0CY8cBBAFM7MKc/kYkKVD5yMpEQyemQn7FfYqMLQNWh6mqwAjx?=
 =?us-ascii?Q?8PtVpQzqyz0K+G+yTCX98WTq9IP0xd9MhFStiYxsaUyFyxfVgB86Aiw9k9bd?=
 =?us-ascii?Q?nvSxrDQVIhfMXiX7UXa8UmlyyKqR66CedkhJRO6/TsFVXqBfJpLo/SR8vrAY?=
 =?us-ascii?Q?8kidyzpctRxwOCkMXn1Ubf50v4EBXcjxl/OUa6fKLkTq+wEpEBwqiZF1fbDt?=
 =?us-ascii?Q?uPhqWs9eGYtdznlwE+3n1diH+7qRMk4ARNSH1pspNO83?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf0817e-fa06-4320-62e5-08dbe1d15b16
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4959.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:42:29.7500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxlBfdQjlYSziGMpxvHgwh5krKIJfB/IGkbDrP4dr+3nBTPCRUwjDgdxJPCnF91ICefq8Bb6W0PPdWpbDXmqLB12lLmat0cV5Y5bB3cWwn5euvXueqEii8wVAxKHFVwA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7910
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

