Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C11C02199
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAADF80934;
	Fri,  7 Feb 2025 15:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="BkvV3kgN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D26AD801DE; Fri,  7 Feb 2025 14:06:50 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34E180786
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 14:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPhgbz9nINSUz9bdCi0CCx+fFFYmuSOIIfa9F7qtGs2PxRX2CJN1auZtIYb+LosAla3+EF/j6UvdECo6D9+x4T4Wp41zD+i6CKXkMaR+pwpnfAJyKcjOaVGvqU+IFjS0W99fCfS/Fp2YH13jehgWtP2vM2so3J6+A9E+j+3/M+cvpm08E0ZoJBLtFTyqOtCG8kSx+LZmwCma0nF/T0cJ7EF3fcQu0FI7iDS9nSRotfSKR61uX+IXJHiNZUAr/xTcvgd9hhaTgMU6+hVEtpEP7S11qScHsfs0WKaoYpI7kP+ccWABd7ceMUvbj33eftDOiC/AAjHHfst5GUuiOuRGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xorVNEfvcaBa9vS1Z82G4Pq/SJN9cOg6HqfiU9kxka4=;
 b=nun8i/3L1o60E6BhLzO5OFgydGTk09/RCq3tmoistegqRhZQxz+KpYFxUGynxBB+7vgg/sc10b4FfJJnM3V4tMVp9XLn5KqeUf29d6HPch5Y4Fn7q6cw4R+ypjBsRySDl3VXeTtkk5Bh8LRht8W1OobKx6WFztTr9JVpmfdk7O5nQi6/E0pIot6AwFRH7LW2iMEVLxQpC/FDXSxeWey0UpZaLYij3OmZmwEQHMwntBY55YZ1TclJLFgVA0SdTwBlgrmaCHOqaddEThngbLVbkxtR4xY5yeTXXexQgZE+oddzaGvM9iCv68bFs7dqgEaG2ADXnRhfg662UzekU74VAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xorVNEfvcaBa9vS1Z82G4Pq/SJN9cOg6HqfiU9kxka4=;
 b=BkvV3kgN+r66MsqcaW0X6K0oYhw1xqJ0su+MiYdS6s9CXtkG5HJAZM0TfiSsG6N2KYQ6UUpMS+Eq5to9tQL4KuiQzqtf/A++6d6WemEC++nDOCMpVsg0Vp0+SIRQCJjSKRRGu3YWsQPllpXTvgEZnk72HNt2TcseUZ6F+GiNe5+ydZrmP29q/YOdpek8M+VvF3LgPp1eH0xSBeCClQYm7kP9h2WQm4/oBxskdLBwAqVjfk7AEd6fUKOSNXkRvU11n/SziWe2gI2PKCqVMyoVpwAEERYHGAAw0+UxE/yeYucuduLPP7lJ2Er5dQx4tmO0Fa6B/2W313ySrPJjKyjcLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by DU0PR03MB8462.eurprd03.prod.outlook.com (2603:10a6:10:3b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Fri, 7 Feb
 2025 13:06:45 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 13:06:45 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Daniel Venzin <Daniel.Venzin@mt.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/6] fs: fat: Refactor delete_dentry_long interface
Date: Fri,  7 Feb 2025 13:45:20 +0100
Message-Id: <20250207124523.85026-4-Daniel.Venzin@mt.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124523.85026-1-Daniel.Venzin@mt.com>
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DBBPR03MB5352.eurprd03.prod.outlook.com
 (2603:10a6:10:d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5352:EE_|DU0PR03MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: cc01a157-d3f6-4aca-431b-08dd477845ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pLk6RdgqbremPcFI3Gfvf5eWhEokL4dyh9p5D2tCHVKPdRp735l4ZIgOLEhR?=
 =?us-ascii?Q?DxO5QsXG5fQFbgdCdcvlyqljl0v5xt6YHxQIf9tqNfQ2SmfhAEWlEVVpheTo?=
 =?us-ascii?Q?KSr6oIriXUSwiIpwUOBZYjvLb3EkliEMDbXxpiZJqu1Owk3yiLTLpavCR04b?=
 =?us-ascii?Q?KE+JWrXXtFT3mm+HSZxN9TrJ2PU0Afyd5NP/qxpa59GM1LpkbCgu+m2mH88s?=
 =?us-ascii?Q?wY70TMN2gQd59wuAdGtsX31+yNX0CKFF1qNUNCIHJfRSwwUKrRla8PLQ0Aq5?=
 =?us-ascii?Q?1VHCvP29Olqp3urOOjwHp20M6jd6jKen1QdHzbFrOyo65pyz7jPbTrq/b51t?=
 =?us-ascii?Q?xOJwSVL3+vzcR4Ogk6A+AAQdr67IqThmdeK2D4zDHVhOkjqf4zTI+D/dvRar?=
 =?us-ascii?Q?OnUooxGjnNH9HBWUhlR2e0cAA/e6EM6OKDTkF2f6Zzs+5RY57PWnygulmqc2?=
 =?us-ascii?Q?EGbJ2+k1gb52xeRAswoSQied/7h/I88DR0H2wwXecqrxtQNE5NKuofWfceJI?=
 =?us-ascii?Q?vmbzngxnLOLmeKJ4fyKokPqA3Cs6ouZH9DF3ZAwKwfAM4bR/GsycZvGXRP9I?=
 =?us-ascii?Q?5RVwCgOZDXQ7Xo3XsTp67ihMB0MoXaoTo1hYk62zl0TlG3yeVX5xqNErT/dz?=
 =?us-ascii?Q?0a2xiEAJywIlGLpQ+xfL35dVqgKyCz+CMvz1YgVh0d/hr9qsNOq4ZY1IdlBA?=
 =?us-ascii?Q?0HA+DYT8AnGVMmMovyKqcwrXcCQEJ1l3xc7YLCrMFI3iKtkhaaNWwviQYEHY?=
 =?us-ascii?Q?w+azkCg+FANd7KJ2Ismj6BBEoWFMGwnXi8XBJHn7Sn4rsMR+EnZMPnnAXct4?=
 =?us-ascii?Q?g7pwbCIRUc/08dY/Qlmc2aM2vDCO3xIO3yY5rajw6LK9714DX2IQtVXkNBe8?=
 =?us-ascii?Q?XxSO8OV1HykDIz9mfxmKfrPHuiE0L81y/5A3qWZYMXDxsnbAIfD5Ft7fAFKo?=
 =?us-ascii?Q?X1OvcYtkvwSilTjrhkVOF/VwEAqTsFdEPNh92X72iaGZ2P1xCfFL4wWppRfX?=
 =?us-ascii?Q?1h2PMxolgdp5F09NIMi6b/w5mpbnIt4I44IWqGCR23O6Lyhr/loLTw+92cmL?=
 =?us-ascii?Q?ceN/BqhNopXouvnVURPrZIPB97biRIPtbm+kUiEk8yZJl0wQ8LvbeHuHTHrX?=
 =?us-ascii?Q?IamdtC+LP9zfBOJkodbwNnN/5ASgMJYo+exniNKcFczAQGIp+ZVKPZ2V7/OS?=
 =?us-ascii?Q?7qGRqpiA+qBk93Xy1v7bPdwjPShBo4SIB2FO4A3jKjM3Yl2DtzAC8nUt6sMH?=
 =?us-ascii?Q?yhDRUBtU+/HtHAcML6iI6+cCsV4brMtiVguO+UxkV2HvfvXhIXGXnkOv4Aol?=
 =?us-ascii?Q?LEOGQnfN5Y/YpVdOUMQ9HyhAgEWMKCsV2FsbE8PTDfUEqQ9Iexthb0WaPQQZ?=
 =?us-ascii?Q?MxvGGf8B2K+Pv5qiHC4e0p9nF5DMSiUbEGEu+ErCH30Ey4QUz7hELS+shU3B?=
 =?us-ascii?Q?ecR5xCp6lxXj8BLrdwU/YZcge/oEAjva?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U1/68Gxi0fvdZn+Qlvl+8BkqikcKL5IBZulaIFQVL7dOS9Op3SvzSmNVjrhh?=
 =?us-ascii?Q?pWx8dpNB5iYByZkyFonAi3CLhDpZnkbjdVqYk2stl2lEsEcA6kv4c9JnZUri?=
 =?us-ascii?Q?Le96FPcbfLP6RCv+OY4tRKppf00ebg8VWIDhnJz/uuNlPigYl1UWUBQru7DB?=
 =?us-ascii?Q?vKzDLk0KpU1FCpgYPVmrPiVMser1ONT8Gpp01jDv1sGx+W/1z7WEo52ewSmB?=
 =?us-ascii?Q?1gNKb51wEItsY6A4w4uuMsK8AFx3m/HoyRiJfqIE0vDGrZ4FU1qd+gq5N6F7?=
 =?us-ascii?Q?9QaiUF0/i3TSSVAjwxbVIaANYNQe35L71xwWAMNLyJSghKlFZImlooW8R2yg?=
 =?us-ascii?Q?380/BHOatmNtupWqaVyZBN2KIpzRZI0VS7AYavvfpUw9jO6hCR0Gu94W+A+e?=
 =?us-ascii?Q?IlnFJuuxkfChp62Q+7kHPUEYLYLL0obTmSE+kuH9PTOcKlPTJJnT0MjOlTl0?=
 =?us-ascii?Q?Ve+Y47ih1i5qG0PYcWeKJvm6DRtXf4JJaOeftw0aXrrTu3FeLGUGYZtyXIed?=
 =?us-ascii?Q?56Z3U8sBGKfVIF4Y5iFDBYk98/tlAkGRbEUiJInGZLhYxZ356PoUmBHRNxxD?=
 =?us-ascii?Q?qoRdeW2mR8uI7QXCPHChTdexJbe+igWM7OaKnCDTlzUS9+ulj76RYPHrhGCi?=
 =?us-ascii?Q?IRmgCt5oexiIeonhZ0AU6/LPPAYwkE5RBhchr3DBNAzAAD+Gcv5nwRmQUEif?=
 =?us-ascii?Q?seXvVI/mEYEfHzCi/PTp9FVlewMzvDtR6WGVO/+B7r6tfDHqIWN2Cy2ahF8B?=
 =?us-ascii?Q?U66KS9E2JZXOh9kZBVkINVRgYCWckHEM06W008RBp4HdoZLC+SqjAYbKr8DD?=
 =?us-ascii?Q?kWhpAOZN56JpcXhbWFrNgoDNc6TUPBVAScxpP0xx3Rut7EeyY124ltXByEt5?=
 =?us-ascii?Q?TFz0bNPlnGIxdzhq7aHScPCuMj+1710oohAOckvTNShvvyVIrAKG5xlDHssQ?=
 =?us-ascii?Q?PtCHIDLlWEpdMGaIvRnvzvcBGYnSCrwtR79BK/5RvA65yOXwKG6/uWGQh0Bj?=
 =?us-ascii?Q?SBpWsMcp0ZfjQdXQNamXt7NABNgTPmTt29fg1ju+ltuIJNkbL1h3NWYh5I3R?=
 =?us-ascii?Q?YMB8dCXXXMGnHXOmsXRBs0YBUf/2dImCUkB/IJnDmF7frGC9fmkBcprIWMpi?=
 =?us-ascii?Q?EzNOZBhH3cXGhMX4+TUHNPmZckZqelogo1od4cctU++Z+wUCcfoiRMp/CW/+?=
 =?us-ascii?Q?g4Seir1EqWiVle+OWl06xjNxXfwURPhnRQcvamfxpnsFJPvG1muNlcQAsvhs?=
 =?us-ascii?Q?6ySVX8VDtMLtaNElRfjt5Xvs8ijxc52AZhcvuZG5538HMBEgV6vlhpnvWXqn?=
 =?us-ascii?Q?CAJ2BrOl0+RcziyupalcDHvNUsZPKYOKlx6KrExerVx+aHxKCN1Rmy8ZTzdk?=
 =?us-ascii?Q?zrLr10xFz0cvjZbUu8bTWsBJ14oRlSQ733MltL3JNoEBMTLSU/Mdqk88wc7A?=
 =?us-ascii?Q?m9judfhHEwQAG5+moOId2QluCSjeMU8YfiTW5XMQo019X5BrvTVOgVyCWJOU?=
 =?us-ascii?Q?PTjISfqHUqCqrnzg+LUtDgJpzXXIBGVjERs/xtSJqsoTvbXEUzQcnkJhH6oB?=
 =?us-ascii?Q?kbxvppV0S3W1OGLcjqx8u8Z2yQEyvF0u4nGCYCQF?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc01a157-d3f6-4aca-431b-08dd477845ec
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:06:45.2441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2uNRUljdIVWGUmxh7uq4C+Rh9Bkr8t15dQ/YneJ0LxyBV/KC3cLKS2x7710A67rOx8Vamc99UwmwECjA1TQ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8462
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:27:24 +0100
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

Directory entries cannot be deleted without also removing their
corresponding FAT entries. This refactor allows for individual
selection of deleting the directory entry and the FAT entry,
facilitating better reuse of existing functionality.

Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>

---

(no changes since v2)

Changes in v2:
- Refactor delete_dentry_long for improved reusability

 fs/fat/fat_write.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index ea877ee9171..c78b80e0b7a 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -31,6 +31,10 @@ static const char LONG_ONLY_CHARS[] = "+,;=[]";
 /* Combined size of the name and ext fields in the directory entry */
 #define SHORT_NAME_SIZE 11
 
+/* Flags to control the behavior of the delete_dentry_long(..) */
+#define FATENT_CLEAR_SKIP	0
+#define FATENT_CLEAR	1
+
 /**
  * str2fat() - convert string to valid FAT name characters
  *
@@ -1568,19 +1572,23 @@ static int delete_long_name(fat_itr *itr)
  * delete_dentry_long() - remove directory entry
  *
  * @itr:	directory iterator
+ * @fatent:	flag indicating whether to delete the FAT entry
  * Return:	0 for success
  */
-static int delete_dentry_long(fat_itr *itr)
+static int delete_dentry_long(fat_itr *itr, int fatent)
 {
-	fsdata *mydata = itr->fsdata;
 	dir_entry *dent = itr->dent;
 
-	/* free cluster blocks */
-	clear_fatent(mydata, START(dent));
-	if (flush_dirty_fat_buffer(mydata) < 0) {
-		printf("Error: flush fat buffer\n");
-		return -EIO;
+	if (fatent) {
+		fsdata *mydata = itr->fsdata;
+		/* free cluster blocks */
+		clear_fatent(mydata, START(dent));
+		if (flush_dirty_fat_buffer(mydata) < 0) {
+			printf("Error: flush fat buffer\n");
+			return -EIO;
+		}
 	}
+
 	/* Position to first directory entry for long name */
 	if (itr->clust != itr->dent_clust) {
 		int ret;
@@ -1661,7 +1669,7 @@ int fat_unlink(const char *filename)
 		}
 	}
 
-	ret = delete_dentry_long(itr);
+	ret = delete_dentry_long(itr, FATENT_CLEAR);
 
 exit:
 	free(fsdata.fatbuf);
-- 
2.39.5

