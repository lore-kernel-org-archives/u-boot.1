Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DC0C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 09:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BEA38780C;
	Fri, 10 Nov 2023 10:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="1Zr0SbSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C1BD877F5; Fri, 10 Nov 2023 10:42:34 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 166B1877BC
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtePPzeptxPbwWSyv5rprLbJtS7/xkNiK+dBICoBjyGnJgJkg688n2K/OTuCCQ4SFsg4dIATj25mLXtv/o8sbSrBCkilx7FwfqQNwVidEIXI7o/S4KY9Qw+v12/RDw9kyV228Wyie7d++RNMLU1VUKjtzufhWN5Lor63CGkgwL7Df1wKYva0xW+D09xOUbrG4dZzL4BWhA5UW5/dNDBQyeD0ziMIRIXPTEyAkH4XieXFnDsUxsgwFLJg3jI8a1Uhwuv+UGTsOalH4FtFYyQNA5JxOAcHx9yfNk3bSh+Ny12uhVTBQAvYes/Bj42+2LQ0BHFwWi+tYMokzBieBS8RVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8ZZQWhuZLIQwlPCy4XGwVSzXVnqmEuSdTjtxjEs+Vc=;
 b=XvromEINhgBwNl/d4u9F5UK8PaHA5ioFhYuAyAuy3TQkAzQzgz3Vw7Lv5oVuY/N3aDCGVaNkZCVEZOE26ji8kuJfgSUSej7oCPQR9rAFuagr7DCRb5OrzMjmuC0HkfDESCC+RBKY314E8cYZD5fZtRMFOUT9C0aNNZlq/oemzC5c1iQzOLAA/wrlT7hJZWl6AT3nbf/DEenMVN/OaV6y4uljox7JtYSVFp3xZmMFvMLurCO4ym7xNJuXsSk5yPPRoTM3PeQIgWeFqt4Dh9qkpxvKm12W6+b1mRpizmryJ1mhbF7VFXD4yxK/qDnoAhYdtvrlvFY8N+6CfUv1uZSpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8ZZQWhuZLIQwlPCy4XGwVSzXVnqmEuSdTjtxjEs+Vc=;
 b=1Zr0SbSu8VJYSYYT517wOHnu1vp0FayrGGam8dRd/Ks66bSk1ieycMkGIK9HzeSPfdDuIyTSEiqVO9Hvel6IqQ9xHoKUs3bVQez3unGARElhSkBRhCWhrv+y9zYh0GvGkflCwTN+3YbLFic+6I1tMeMZwN5TxR64HDEcQMbz7PA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com (2603:10a6:803:110::20)
 by AS8PR08MB7910.eurprd08.prod.outlook.com (2603:10a6:20b:50b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 09:42:30 +0000
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0]) by VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0%6]) with mapi id 15.20.6933.029; Fri, 10 Nov 2023
 09:42:30 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/5] fs: fat: add bootsector validity check
Date: Fri, 10 Nov 2023 10:42:15 +0100
Message-Id: <20231110094216.50696-6-christian.taedcke-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 166045ea-74b5-497d-6eaf-08dbe1d15bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eN7HFCg19K6WmI/5+/UZTFWEQY4LH5/quwncMd22bXFnJQ0vz35rc0nhmMgLlzqbfsggG+/aHwCa3UEssQO5vAQ11+pogoH4wS0hSPY0chINHNfPOyIufbj0JrwyuTCewy2mTfcyuPbEcjXDcgncbtu9LK2JL/UkNhQ2RQPfWewx8Vjvp21x3EVByr3YrYRiYehPuQ4TWByTE3FYKqXTg1HeISR+G28vGr42knCQwixXqsMboClQrvFwaDRnZWca9ny2g/8NDSyCW6ocpYsz4lzGgB9zskm2jUzxZLno5Dw8UqHtWAQApnq+v4GliklZ4oegGGAGGHUu8qErBeHuqkyDPTCGn7PA/2fCvNcM7yraIb2yUq7PCt4K4J9FXY2zPHg/QriCrBxB6twzCzm4MZendSxqy2A2NlaMD6W12qlUcxoBpMR2FgchSKM0EEnjko49MsNP4ZcBjKgo2pWfgxc+vGoyT7UsAB7Z3umar91ROKiej6+OfmwChItfeiUBDL2gZmtLYnz+Gt/Hd9FrvxvYDj442JVRiHn23Se4Pn5SkByp9EONHxT9R1rW8rgVUlJfj1ruRIfOtS4OJVKdvj10byWT8bXgGnxBokIqZuw1qZfE5O5zXFkNXs/n8jHU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB4959.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(26005)(2616005)(9686003)(1076003)(6486002)(478600001)(36756003)(54906003)(66556008)(66946007)(6916009)(316002)(66476007)(6506007)(38350700005)(6666004)(52116002)(8676002)(2906002)(38100700002)(4326008)(8936002)(83380400001)(41300700001)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GRbY7XP/8JOSNRKv1b6AR56X6KvRI9OJkkxpx1CYj2B5bqjqIfLkcIDf3eQs?=
 =?us-ascii?Q?XOjjWjtkiBEnBRsINsFmTcqV+xt0IALg6ODoIcHnH8/iZhypuCnUiUY+sn6h?=
 =?us-ascii?Q?rNq3Qyb8yUhkYVQvuQNbuxNAGDLpHu0HbS83FuqhXTPfGXNVHRtPHJHqZqI/?=
 =?us-ascii?Q?zxa2SdbmHBDcucCJpUi+WkHuATnFNnNMfORLgrBV9hNUn1UETtnp6rvaAKKG?=
 =?us-ascii?Q?EAF59zhYIt9S77VwoWxPSr6W3nq+aXfTAdLBDNBrgQQOU88rvRv1+QvFtbHP?=
 =?us-ascii?Q?wZ9J+hWimRbNPmkPQlrhfiQssdsxcKwDckr74JgFkWQjVeVdqakAs3umXLp4?=
 =?us-ascii?Q?AqgznfY8htJOgM/MgIIZyGv2MsLQAVRo3Y3MRb9uPtMsgiqqBmhGg4VDQ2sq?=
 =?us-ascii?Q?4jlXR8GG6wJn+QWQA/iBINqA7zk8jc+EdYIt+K5eerS+GvKAyhjHnkVYo/dy?=
 =?us-ascii?Q?2ICkyL1gR2XazBgQ5TcXg0xoBt6zEPQ7GVdEJ5rwfZpiQUF7ocNqnHp1ooPW?=
 =?us-ascii?Q?QzH/pGquYH9DPn5Gp8RPLmYqnU4FTPGRC/7COY7nzgOmW4m+gLrRzN0IUWiD?=
 =?us-ascii?Q?2EQl+JUK1aeAiP/QTaQ7tX/ntCAnmy8vcAWJ9k/f694MvebiB3PuNB1O2JjF?=
 =?us-ascii?Q?03LbTgbQa3Cv6GzIf+1TCvpU0/tZ1eu+TNIPVRVYiRDbWndGltZMTueI+zAK?=
 =?us-ascii?Q?f30qcntbnpO7f822zTNSpksDtXTk3elIUuYxw361A3tRVDVgsbANWzLAKAmI?=
 =?us-ascii?Q?T3HsriYHkgkKercT/OtDLlIzk7/MbruiheeQrvGPJlFd4ssE1OhSZqCK+tgV?=
 =?us-ascii?Q?a+wW0p8lE096DojbC+pHLA8MqdIDp8v8hdpLW1hb/VZIVGu9ORrlDMaSDX0O?=
 =?us-ascii?Q?o5Wsj/j5mecud2T1mTAlvROLtj21hinUVsuLV4x7Hq/3zl6GX72LNEIJZunu?=
 =?us-ascii?Q?/67adl94287OU7bpSDMx9/auaeprjVWLzbtrCYFUn5USWt2XKTB4eFkNWppP?=
 =?us-ascii?Q?uxYEMuiGX4omT5zJ7kb5JS7t9tqvELIqkKn4XHF/ppiXAcMSRiOIolA1QG8O?=
 =?us-ascii?Q?zAHdmyTut5Qvr3KeDddTGlYcOsvCIKKQV/hgGu1GZdgLqYwmcoQYVrAO5zD5?=
 =?us-ascii?Q?l+i/TdxWPL0ZA77j4u5/wajAXG6wyk6lS8oQ7OYCk9ajuRxFsBvIIBOyct8L?=
 =?us-ascii?Q?vQpfQ11iQBfURJ/j/KhvNQRT2ZDf/l8c/9Ez0VXklGwUKMS6hSZiAzkm4+v3?=
 =?us-ascii?Q?0+mSexGDzvYLRxclNFzwHLp0RiBBzsYFhUrTYsjlUuipYtdzXrCJmzpqcXgS?=
 =?us-ascii?Q?W9o54nxsuKGiPLXnN5kuexIUOf+b2OGviPbBdrvMhSbF3WVd1qKDs4m7Y4Ib?=
 =?us-ascii?Q?nMnbrq3lMIgDhwRlsJ7FfvBI7Wl/i32QoxAkMaBGAZiA1Q4gXGhiTg7UiO9b?=
 =?us-ascii?Q?LcTE3r8KABW+mZzTpeIQpo3jqq+avT9nJnCa6Em3K2rFu42hEsrFBLnw05YX?=
 =?us-ascii?Q?n2DWzXUSUG/hvabW3p1PUaQ+ZsrDJNbfIbQXnWX2Ad0XoLcepZxO2WTysG3U?=
 =?us-ascii?Q?pM8yBy63Q27MJf8I16ancHDSOLv7t+bBuRwRDsRZew85chEblqRkSTl7c77Y?=
 =?us-ascii?Q?UuvnPyUJ+WD1P9EROvVmS67rN/MwrKW3V1p2lDoQf4ID?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166045ea-74b5-497d-6eaf-08dbe1d15bc4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4959.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:42:30.8594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xlTyfeZJeMlYXTuH2C6lhgqWQFXEIkTzHN9Zlc04yIGFjgbME7kwjOtZQVzy9zITkc+MfM0AwLzvZnJcQxGG6c09475hz6dPd2lruEyWH6Zl1YqBxiDSuqfVlwfA+0G
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

The performed checks are similar to the checks performed by the Linux
kernel in the function fat_read_bpb() in the file fs/fat/inode.c.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

Changes in v2:
- Add validity checks for boot sector

 fs/fat/fat.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 77f225ccd8..14e53cf2d5 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -25,6 +25,7 @@
 #include <asm/cache.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
+#include <linux/log2.h>
 
 /* maximum number of clusters for FAT12 */
 #define MAX_FAT12	0xFF4
@@ -508,6 +509,52 @@ static int determine_legacy_fat_bits(const boot_sector *bs)
 	return (total_clusters > MAX_FAT12) ? 16 : 12;
 }
 
+/*
+ * Determines if the boot sector's media field is valid
+ *
+ * Based on fat_valid_media() from Linux kernel's include/linux/msdos_fs.h
+ */
+static int fat_valid_media(u8 media)
+{
+	return media >= 0xf8 || media == 0xf0;
+}
+
+/*
+ * Determines if the given boot sector is valid
+ *
+ * Based on fat_read_bpb() from the Linux kernel's fs/fat/inode.c
+ */
+static int is_bootsector_valid(const boot_sector *bs)
+{
+	u16 sector_size = get_unaligned_le16(bs->sector_size);
+	u16 dir_per_block = sector_size / sizeof(dir_entry);
+
+	if (!bs->reserved)
+		return 0;
+
+	if (!bs->fats)
+		return 0;
+
+	if (!fat_valid_media(bs->media))
+		return 0;
+
+	if (!is_power_of_2(sector_size) ||
+	    sector_size < 512 ||
+	    sector_size > 4096)
+		return 0;
+
+	if (!is_power_of_2(bs->cluster_size))
+		return 0;
+
+	if (!bs->fat_length && !bs->fat32_length)
+		return 0;
+
+	if (get_unaligned_le16(bs->dir_entries) & (dir_per_block - 1))
+		return 0;
+
+	return 1;
+}
+
 /*
  * Read boot sector and volume info from a FAT filesystem
  */
@@ -542,6 +589,12 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 	bs->heads = FAT2CPU16(bs->heads);
 	bs->total_sect = FAT2CPU32(bs->total_sect);
 
+	if (!is_bootsector_valid(bs)) {
+		debug("Error: bootsector is invalid\n");
+		ret = -1;
+		goto out_free;
+	}
+
 	/* FAT32 entries */
 	if (!bs->fat_length && bs->fat32_length) {
 		/* Assume FAT32 */
-- 
2.34.1

