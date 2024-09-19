Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7651FCF3942
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 13:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72E789171;
	Thu, 19 Sep 2024 15:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="Fnqnc7UG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB7D89178; Thu, 19 Sep 2024 15:48:47 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03DA189175
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infinera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Joakim.Tjernlund@infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDXsfZwF7qdbroyQBHLfxfJ0iEDBomLJw7vbmhnPxYlfreBAaUqgHLuNKp+AaB1YYUYf3I7wIGo8TjLIXZk0I5S3HUuB6tfS/sNybnG2jkX1Qcc27Ja+++idfk1wTt2PXccMPHRzZ8Q4wYBIWHaAtqAmT+3399HBmKmdVv9i6wm5oXRP1UJ8bhVXxaPkpUaCIMqpJO02izfcCd0D3F3ev/PV/41jZJT3qu4NqvT9CQlIq+fTl36qInTD9+S87/qGTHERGCypSSk4wpcytyefbtuJACc1o3rwatZZLE96HPyoncwiNPUMo57auP7D9wLBdLIEX3hStrmgQ0+pYyvWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FkWU76eGsX86muAg0xOiDdBZH3osPGAyP/Up7dD4xo=;
 b=rDiwPvWPELx1D+Fos5TyTMk8REjnSZgW+4x0jsI0VWcVZxppFWJw0wWYfvkJUKAO+K/9UhppZmw5GtlIQ1CNzFxVXfBFHbxxwXNE+wpxqNolmYwfYzoiwQImNLxQWrpxl8+1I3QMxXZ9qSfY8ZMxbco0hsTNYIXNLULxJ/wVY9rmhjg7gnqEzP5puLuJYF6e9pJ9nRjSbRZtFBpJ8Gqc7zjBggGSufdPtmOfoYOepev3fo5OzuPsauYIdHUR/nOSt12ngEwNM4gae6B0LfLH3IZy5DiBumKjpePBM4TTNz34pewTT7PlBf1xgRh2eB+3WIZ+s+4kFnXke54JNR6H5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FkWU76eGsX86muAg0xOiDdBZH3osPGAyP/Up7dD4xo=;
 b=Fnqnc7UGY0B58twQZCkrcBcTsSeM/M1T4VdtkuK9jid0ZkgEApdj3X1aSZkEBxaXXFOQrKbjC6eYZmhyiHouU94o3EZHFV5uxhmt7P+FG630H1KFK1jBZKqpcfFY8Lqs8dupDvP6rdpxAUv6E0TAXBzDJcq7sAiKK3paDFyRvQq5wyyANl+j51s0fKV7pJ3gA6HE+mUQaprFxody1Ov5Z116p9kyTq9E/gC8528oovthWYdrCa4jLfb3A4R4Ncd5vv6wLyB9JkO9ELXxC8eMBz6P8g4GI6dEVcFUBshF8aZUNGDm7IdgZbbesCaMLy6QLKaIOoOHcNbGpWBK2ODejw==
Received: from BYAPR21CA0024.namprd21.prod.outlook.com (2603:10b6:a03:114::34)
 by SJ2PR10MB7619.namprd10.prod.outlook.com (2603:10b6:a03:549::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Thu, 19 Sep
 2024 13:48:41 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::f) by BYAPR21CA0024.outlook.office365.com
 (2603:10b6:a03:114::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.5 via Frontend
 Transport; Thu, 19 Sep 2024 13:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com; 
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 13:48:40 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 06:48:40 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 06:48:40 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by
 sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697); 
 Thu, 19 Sep 2024 06:48:40 -0700
Received: from se-jocke-lx.infinera.com (se-jocke-lx.infinera.com
 [10.210.73.28])
 by se-metroit-prd1.infinera.com (Postfix) with ESMTP id ADAAFF402C4
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:48:39 +0200 (CEST)
Received: by se-jocke-lx.infinera.com (Postfix, from userid 1001)
 id A3DD74012B1B; Thu, 19 Sep 2024 15:48:39 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <u-boot@lists.denx.de>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH] Add mkimage secp521r1 ECDSA curve support
Date: Thu, 19 Sep 2024 15:48:22 +0200
Message-ID: <20240919134835.377572-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Sep 2024 13:48:40.0712 (UTC)
 FILETIME=[A29ED080:01DB0A9A]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SJ2PR10MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: abcc027e-8326-428c-998b-08dcd8b1c53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I2UgcRVXspXNw5yO/PZ0Nh4nOKE2W8UZrEs6pAaGy45Pk7j2eYV3KQoTTR3V?=
 =?us-ascii?Q?E3bdR8NGbeg3KzR+EakfuuJgGbNC/Vkos/IF5kR4obfdqnpLQ5z8BbcuXLRi?=
 =?us-ascii?Q?O6AHfLRnplXscnMpeESlDJGUIabt2GXM4QC1Q/1gJABOw55CS4s51l/4oCnb?=
 =?us-ascii?Q?4fdR+pVPUGLKmEQPL4OeKDtGhPk+jpDwghl+qk6esrZsbUzS/beA2Tc4CQOH?=
 =?us-ascii?Q?DtAl2mi3UgUTMKCiQMAosRCNXKr94+apmaB1YGxkMdkQNe8zJt0ve+PNwuhQ?=
 =?us-ascii?Q?NEMCsvJJ0R/yOR+zOryg5GhkoHicgS0KvUmHg8k0fy0M9duqWHwGzZMJ/qLR?=
 =?us-ascii?Q?5b3m24Hq8E+J3uX40u++5JX9Y5Ik9p0JGb0AYQ+Vh7SS6dtopu2MornCunLy?=
 =?us-ascii?Q?RXY7PpX2Bucwis3meBTrW6bNrHJrp9nNDwSwjsAP2iBtYCJe5X6duu2I6Bax?=
 =?us-ascii?Q?zPMjS1NY591VGJLOivueU803tKMZx/dxKph9mlOZG1LUxBNJ4qGjqqzejVqQ?=
 =?us-ascii?Q?cpv9dKAQwsA/xizJ86bSjmuUH0ClYfGwf3dIzi/+XwrZHoKBkBAy3eu7MBJS?=
 =?us-ascii?Q?hme1CHF3cao8dz34MSIB9yFSnx+rZO6F4+6LQVbyts0HG4qCvz5yP+byBbhC?=
 =?us-ascii?Q?mXCMioPAS/kzyuZKvnQ1sq40544fLv/zG94Wir3dxe4yzsvxzMjsRtzqKups?=
 =?us-ascii?Q?50+7x8OG/ms5FmGVECChiW5zlc6VJINJQHyf+YzJqGxXqJAifC2zGSPOQvdZ?=
 =?us-ascii?Q?mkgd9rrJK3INM6bPMXq5fBYJUT6n+Zf/24xR9uOByid+b+xMoSVE0gRD0dDv?=
 =?us-ascii?Q?WFI88ZFUFzdrxw1LIK+ofFoTzYKPdyrXqrpVXpLQTfp9gEI+ZizwvnBIRVVT?=
 =?us-ascii?Q?qc2w2pz7LQLbTNxFImpCp/dldc80wzsyYC7lBaZewV311PvrwwcmCgpZTj3A?=
 =?us-ascii?Q?C0C9tY3bp8O93JA3V4KcuP/SALn2M+43YVXn7MK8ktuSqSC0gxROy5dZWrV1?=
 =?us-ascii?Q?R4qOlPGul7uV1Lpa/fqpOvAkV7bo1A9cbJTgMc4cKbYT99ymuYE53tH8ZGL7?=
 =?us-ascii?Q?/pcOps6ibNEelaB1yOjSJuiO3K+CEsQTUSpU/ytYhIZUTwc1mKHf96TU3axF?=
 =?us-ascii?Q?gqrZZJZjItaDIycXhwu9HJUnuu/rg0ul9xr+1WoYPkjSfJwxpBUegZvHOaun?=
 =?us-ascii?Q?zX0iM+ck4rUYqLqLjfUfkSbRTZH5JY3fO/Gx3EKgtm9QgMA6B7hG8JF1BLbe?=
 =?us-ascii?Q?zM1KAfEAZ4JHxWxTkOChC0HfJCSKBqS+Pq5+efLC53WN8E9LGxBvJL8zpVqX?=
 =?us-ascii?Q?jEixBn11Du2DRi2I3wKCG4iglH0sWzfOJXh0zMPSrV5uUROc1EU2iv5K1WcX?=
 =?us-ascii?Q?39ujLmPULh4eTusbnlfVZD0Hmx/cRm4DqUNM6xJGoI2IUkfs2+405C435oKn?=
 =?us-ascii?Q?NS1kkfcqPca4hEMOydcFJbUuTEfzP+Om?=
X-Forefront-Antispam-Report: CIP:8.4.225.30; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:owa.infinera.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 13:48:40.9505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abcc027e-8326-428c-998b-08dcd8b1c53c
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77; Ip=[8.4.225.30];
 Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7619
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

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 include/u-boot/ecdsa.h      | 1 +
 lib/ecdsa/ecdsa-libcrypto.c | 2 +-
 tools/image-sig-host.c      | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
index 53490c6b287..8f9f5e7d6e7 100644
--- a/include/u-boot/ecdsa.h
+++ b/include/u-boot/ecdsa.h
@@ -65,5 +65,6 @@ int ecdsa_verify(struct image_sign_info *info,
 /** @} */
 
 #define ECDSA256_BYTES	(256 / 8)
+#define ECDSA521_BYTES	((521 + 7) / 8)
 
 #endif
diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 5fa9be10b4b..403dfe0b97c 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -108,7 +108,7 @@ static size_t ecdsa_key_size_bytes(const EC_KEY *key)
 	const EC_GROUP *group;
 
 	group = EC_KEY_get0_group(key);
-	return EC_GROUP_order_bits(group) / 8;
+	return (EC_GROUP_order_bits(group) + 7) / 8;
 }
 
 static int default_password(char *buf, int size, int rwflag, void *u)
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index d0133aec4c8..21b4fa5d39d 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -76,6 +76,13 @@ struct crypto_algo crypto_algos[] = {
 		.add_verify_data = ecdsa_add_verify_data,
 		.verify = ecdsa_verify,
 	},
+	{
+		.name = "secp521r1",
+		.key_len = ECDSA521_BYTES,
+		.sign = ecdsa_sign,
+		.add_verify_data = ecdsa_add_verify_data,
+		.verify = ecdsa_verify,
+	},
 };
 
 struct padding_algo padding_algos[] = {
-- 
2.44.2

