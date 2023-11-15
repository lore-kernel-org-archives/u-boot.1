Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13756C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552ED87230;
	Wed, 15 Nov 2023 13:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="g9JFvLZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A0F287160; Wed, 15 Nov 2023 13:44:40 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C51871C6
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdG2r+x+PrxPVxe908fjy8Wviw1k2RlnuAD4TrV+Z1MjNI4ORLeJRR7kB+/lN7/TWoUwtmjL3g5bEPBdi5JX1JX/oByKDDPa7VGgZRnQRlZ64uCMJQR4o++qahdlFjNAegHgjY+B3a10oFLDlHocskd56y84TYwTAsE9k7XWEQEyX2/EDZ6Z3fMbdDNgOiBaj5/T43Fe9KkMSfSa8AAE5p7UpxHJMBb4wHqpWDm5KFxe/2xWSrK8fiMWSH1sXuAFbVPsj82m0hOLmN/HlbUF0CmBWzDruzLXLGhve8eseDYsOQ4+iPOmM53J68vqGiPCSK+zyznKbe5VocqEyOveYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oCfaMoZC2F+L6vODr6ALaGQ7XhCYDjrZVLKBDbnx7w=;
 b=ZQC5azfocnSD2K44tkUROiB26eCuTAAw5RLv24zVFUn9wmtxjyxKMT/ekTPzF8bqjHEWGNInLPYrSKTYgmR1UVQ0rETZEGNao2y4MkR8+UMp0CgPwtLVLTzywrkKG8QR9hfEny+9lRL8bU7azObX8pStvf3xfuJSwfcBUDlRaq1sE4g8gKS40G+vQmvfyAoViPJVjUhlTcPmvC43pfvWx5PkJEEpt+1YLUiFaWWSj7eqD4ibvrRuZFH9aXhXPQ1pmnXzNO3uDBy+KpCpV4NwgevTw9XyVHSEp9vaB5bGwYidysMFVd7t9oKORHSsRbrasGhzawF3jVCWcRUo2vvqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oCfaMoZC2F+L6vODr6ALaGQ7XhCYDjrZVLKBDbnx7w=;
 b=g9JFvLZn2fmcWq4C1pxPvUC+a7af0mJEiGhrbMbvmC3llmHzwVV2Ae12b5gYgApVY6RjtTxYJJm3FLD/341wsf4TRlg/5LCNzVQxTkHJFyJxtawiZJfIJnQxao3WApMDjjTKBzInEYBPKrE/NnWq3AAr/cUJ7REyKeHnJF9eevU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by AS8PR08MB5911.eurprd08.prod.outlook.com (2603:10a6:20b:292::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:44:36 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:44:36 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 5/9] fs: fat: add bootsector validity check
Date: Wed, 15 Nov 2023 13:44:20 +0100
Message-Id: <20231115124424.125823-6-christian.taedcke-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7143c0bd-4071-4b32-558a-08dbe5d89fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObRj8tlB/Fc9tAlyD88YGwIp+gHLzMNYPIy8uan4OyoKqi4fJnQDX2QYvpsqPaHlNxg8DiSmiNblIp0/dhDel2V1q8NY19p1vmSY8rI0wAySNoix+KFHEU3lItFiIZf0/1+6jXF0VQ6Si6HTpBV4fM+Y4Fwjuj49ZKTN4bJp3ugWHJUfBxeoE8hBl6/MoeUXp5rehb0R9HfeDZLZx2Uh+PeXhI3KrV0oVnpc7ssJoyXmMA13AyAccYy1lnlPO9pxkRUfW+MaN3WT3l8QeLtIONkxvbRB8KDDAVdKrxvjNJmme1LrZd0/kAJNJr/wVEzgcmYKWifranU6oibU9yhN4ZGRVVyhr2YfngFcCI+v16WTYMLOAMA1fTmFnJ6Fg0jCWp8OAz9uvGVLkMBClBBeQMzu81ASUagAn+F1x+lDohCTs0QOASCuyRzcwTV/iNd14k5guysrToU6vOGTYFWYF+hDGaWAPjTsD93/sS+QURYzcuHAMAUWtUf9otg0/xQPF3wIXaePc118CX+UkD6m1UNNY9buwY9jytgk6UTbM5fXx9Y0EjJ5CVmp42Qyi52lz+Xklk7uIT4M7pMeP1SqGpMVT1lAQ1fZKMWTp7r+empqbcnRIhL6I9BeKIMmMTq5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(66476007)(54906003)(66556008)(6916009)(38100700002)(316002)(66946007)(36756003)(86362001)(6512007)(83380400001)(9686003)(26005)(6666004)(6506007)(2616005)(52116002)(478600001)(2906002)(6486002)(5660300002)(41300700001)(8676002)(1076003)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VI7PXsDQjdUBhe7LSuf0xZG5/FNU/PHajrP2r7p81JBoF3vq5lv719U+FAWk?=
 =?us-ascii?Q?W5jYrvbcC5tPQj35yUd0RbTaNicUWre2Hcmbu/SP1ngigfSD64tNy5cY5XL/?=
 =?us-ascii?Q?XK/hlkNov2WBm4K/mCggf0lkSyu9EGTIEMBYKN53l8LwaGJodkuI/mB2mCxl?=
 =?us-ascii?Q?CBSxVe5K/9AdJy5DbITAefpoioj+9qJ7zpd2kKgqNPOAglVcF1UNiNpSbA9p?=
 =?us-ascii?Q?HSN4u5rAkP4lwCB6wMbKh45I1vtrZynY8XUD93a+PQQ6JWU54V9+2aM6Mkd8?=
 =?us-ascii?Q?5HD5Qj+57JBRcWy5EDOn9Wk31GF61MTJw9VUUVxIbZBUZeXhePZZkeIpLVMD?=
 =?us-ascii?Q?xCJvo7i9jIKQcnpwOhwKA8SA4bGc6ihH5DyDRkbxYYQVNxIhQ3vmg7SsWhqM?=
 =?us-ascii?Q?Jr5apHp6E567lSI2mig1B53b1P37CGWV5VvE5junI4O306/y4HA+OvQIfnrz?=
 =?us-ascii?Q?kO8d2uoBp64lZxDaBbOWuoSKxNwbfOV8q9/J0zDPtRL3RwkX+c7tvGioB2bf?=
 =?us-ascii?Q?y/qvotXOVBr5g/u7AdUHmlaGUliK3mnYQmQuNHrJh2IFCGmsnO5tSat/4gl4?=
 =?us-ascii?Q?LTktHz+EDWGiB0Gs3aTnePFVWNK9bTyjL/Eeqej6Ttxa/8dndLuLMALwpYI9?=
 =?us-ascii?Q?gj7tT4DutoZ0k85FUvrWE82l4JLJKSH5EmtJhyOKTDxNNuxaue94xa8v/XYc?=
 =?us-ascii?Q?iFqIKyx5WiEaFc0rXk+Ish0Zn55R014bUOQTJ9vGUXO4SzqJOSOmG1L+Jb87?=
 =?us-ascii?Q?NsTLN9tDu32nNcoSBHho8GNcHlMJD4XD/XH5YzKwZWnIUaBR/oOUYQSAV3+L?=
 =?us-ascii?Q?BLziJ9Ohu3YbOYYpHYeijAAgB9f926CC0wlttMvW26dSvtPamG7fa8oi88qG?=
 =?us-ascii?Q?0D7FwU2bL0yZc094DFgL3BK/fjuH0zUifC/M499LbXm6rI8xWpQQstz92YBn?=
 =?us-ascii?Q?z0nbgc0vDyUDDR+j/ph1kZTUF0KBGOW2q1B0slozhudmXhgNcUc3C7/po2WX?=
 =?us-ascii?Q?GMdlWD6nShglsHwFhTAMsf04tQhcZUOB3ZvpVYMtRrssHz/Jwmid4LVVkB5y?=
 =?us-ascii?Q?BR1BzFIXHi9Ywo9A7H1cibWm3TZnONa6pYg0q15AhgaYTctoriDvc4jagu2r?=
 =?us-ascii?Q?OnGoCwYSalPoRDJtMrD9R8zBunF083pBxD84RJfDxe1fQUGCQN6DFotv2sYH?=
 =?us-ascii?Q?Im9CG2pouxVeXuOF6Dc0CflWIHx5WlHn7kotLdV+L/lnjNKCUhh2IhRcnMq6?=
 =?us-ascii?Q?1A8ugnEth/doPdEm/dwNTzqDZpA64lAVhGd1ZIsnKBsbjo7LnbGbzpvyFdNd?=
 =?us-ascii?Q?ExPLW4Y3WC1hH3rQkfmy2N71IkOx1t4oE6LGqOW0jQkMmP4ihO3gPN098bD+?=
 =?us-ascii?Q?LiG6eptqCM1qdh6bW7NLpvAsxFV2DncAZwXaQ77Jmt47ueXaE/G04jHtBpNT?=
 =?us-ascii?Q?QUNsfyBVylLjF9f/80HhCEqydOGctCfq8PwZoVnlB09S4PqWkMNIZ3DWgBc5?=
 =?us-ascii?Q?E9vSX7Hks1yO9banilnSjhW3mbVfz+WUZ1nZuGNmtHFl184pGMr3yRrcyChh?=
 =?us-ascii?Q?EJwveswt84EFoOKGd/A+Ox07NEMFw9qFUJnMvZffd+pPu1rl9PZ3Cpa3B+Bt?=
 =?us-ascii?Q?KfD9dUQ75Y+JPj2p4uxtsgeIFZ5wDCTymHMTD3zk4/Mb?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7143c0bd-4071-4b32-558a-08dbe5d89fc8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:44:36.0485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu9WGF1f6cU1PEt9VVMApPnwfsmlwGvI6Uo3s8iDCGdDoJkM/PqxLbWUT88ytBNOgI/aQq371ZAjmoNXmueUZ+zKE+p4y2Les4WW37pNdwjZHIhS/AsTLh2fhuK/D5rR
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

The performed checks are similar to the checks performed by the Linux
kernel in the function fat_read_bpb() in the file fs/fat/inode.c.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

(no changes since v2)

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

