Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F00CF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D95D48880F;
	Fri, 20 Sep 2024 18:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="UNaxoHY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA4F08884F; Fri, 20 Sep 2024 18:11:26 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787A48852D
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infinera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Joakim.Tjernlund@infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSah1tocyHE3cIg3BbIVjaVbZWMASaDYN+peMitIjoVwiTI0mnGMfaTiiH2+iLy/vc6LSLjciEkXEX5khAHBw2bsQrfHNK7rMtcyEtCnAHCCAU7JXZ2FXiBZwkojIZ1DB/2UI4AWUJs97K5RKsYIUB3bJB8O0I8nbFzrEL69S5R8L/ynXkHoRK3NEeD54Q/I9RAnSM3vikOrZ3KybmtpwujxRrP3zBzPOfSIizZCXOm1cV6lvgkta7g8D8+FBtKFZorJirk9AyGwHrDV+IClxPM4nYwpNAnlmUvtozexbiJq0y/Y6GvfkpANyLAJNRUJ/1MKBHIrD2Hg5Fk2QaicfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zidr86wTp7U86DIliEs0SpLZbJIDwCIqLABS3k54ClA=;
 b=c43HmZ1N1Bwjp2EMvt0DRMyvdBMkxkWOjjHS1v+nS1Q8vPNdZB8zrCXIG9BZ+1kC9o2ACISd41K/C81ZtGdkQYQnAqzK3S/jp7vFpStSlxlb2OspvApBrXcz+1cSiDT3Fuu3mL3WEYthr6Aac7G3Meq9Gl9liM52caC/EA9mSwjCW3jxNZZAK/QeD5+y4vA9/Xzo/a9Bvkt/m8PLIfyGS4+BU8BD/5oFCV/JVV7T4SCLhIShMuaJQp2OZ3q0N3pFeQtPaTVWjuNhKC88fvVAhXs9ZoWUYKtz1Sv8J1XNxY9t1tzmsXt2Y2FpkRKDdwaC/ijtr1lFGR2d+Auir+hTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zidr86wTp7U86DIliEs0SpLZbJIDwCIqLABS3k54ClA=;
 b=UNaxoHY/sFlk25N74e6kwGaKOyaYW4zucBFZwIPDNqEQjj+YI/UBVfBKjAqw1/58tFSoafnb80qjjTUS35p7//tsXXBTSxTl0jFrtyvZTqdSN4TXLUNwG2xmsd/QzLA1N9MgYaQjl8do8OK8Tn51UmzShHMkZpvwNC+8OuW4wJLXsBmu0RrB0WM9CgB13nsn/NExCNYFbj6eWJH4iL5sfaURnaSaD/Wm8lCYS3mIxyE8aJm5+rTOCnR5LWJtwQb1cyeevvkqGApkmHWFJ90jdgKefP/5UyGYqHI4pBCRKhdcTYe4ULLK3wanNNtsnYr/7J0+RTENFu3CYivpCcRBNg==
Received: from BN9PR03CA0490.namprd03.prod.outlook.com (2603:10b6:408:130::15)
 by SA0PR10MB6426.namprd10.prod.outlook.com (2603:10b6:806:2c0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Fri, 20 Sep
 2024 16:11:20 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::f4) by BN9PR03CA0490.outlook.office365.com
 (2603:10b6:408:130::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Fri, 20 Sep 2024 16:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com; 
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 16:11:20 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 09:11:18 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 09:11:18 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by
 sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697); 
 Fri, 20 Sep 2024 09:11:17 -0700
Received: from se-jocke-lx.infinera.com (se-jocke-lx.infinera.com
 [10.210.73.28])
 by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 50F70F40077;
 Fri, 20 Sep 2024 18:11:17 +0200 (CEST)
Received: by se-jocke-lx.infinera.com (Postfix, from userid 1001)
 id 470F74D3ED9C; Fri, 20 Sep 2024 18:11:17 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
CC: Mykyta Iziumtsev <miziumtsev@infinera.com>
Subject: [PATCH] ICEXMSW-2822: Add mkimage secp521r1 ECDSA curve support
Date: Fri, 20 Sep 2024 18:10:18 +0200
Message-ID: <20240920161114.916381-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <CAFLszTj0HNbEy7VSaDA=Vd05+EWT1rxcDOBxu6e=BY1aQ54ZPg@mail.gmail.com>
References: <CAFLszTj0HNbEy7VSaDA=Vd05+EWT1rxcDOBxu6e=BY1aQ54ZPg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Sep 2024 16:11:18.0280 (UTC)
 FILETIME=[B9BDD080:01DB0B77]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|SA0PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: c34804cb-3d3a-4704-7611-08dcd98edd89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aMCoYMAssqtp32V1hLk8EngbipCchDGXtAtk/rF4xUlU8hjEzyW50iRIyqjb?=
 =?us-ascii?Q?1IMjuf56G6q6r72tWLMdx8IRoYVCurXiwGpMp5ZNjdOk8je4IcQQu9S2gwqt?=
 =?us-ascii?Q?TYPjotnwYL4p7moX8AtNP3SNj0boDVsqLOEzxHEI+hCCIibm1zGn98iCWLoB?=
 =?us-ascii?Q?V3L2XTy/MmXWuqebUv4KDvPK+g05VzimkvptogVwVtMZepDSO5lxQYq2y0RK?=
 =?us-ascii?Q?hu1oYd3NTXKPEzPtDYjgJPszv/qIYrf9sBsj5qMIMKyFiqN53ZhafLV1sjgM?=
 =?us-ascii?Q?c6xDmoiVvzR0EwSEcRS1DW7xR2I1ZBrjpELyfpDagflkjKrN/QOlvL0M0ttH?=
 =?us-ascii?Q?2R159LZhdT7Z6tLvEkc+kFX0HwS5cKEuRk+aXQyMWy3R8mrySWxwhWoGkRB/?=
 =?us-ascii?Q?RKPXelrUKdfjuhRM7mnvE4ge4Yk7RAv5vZtgJC0aARig3lopctaV573V9csq?=
 =?us-ascii?Q?0xmlQcEZW7imB4lCe9Bt4h/0+nu9pzQpBtHjPEt6CXcIwpdjXb6EpQKFwITm?=
 =?us-ascii?Q?IBwjJQwuSAMlPX6HSR+GpRFK0SkEWN6YqrrJp9b2vjrV6g24HNhj5AXZwjhg?=
 =?us-ascii?Q?mfHaIhyG50W0z+8bIfRpOvYBJk17V9c6kNlor3wqxk0+RmGQjYL80+Ut7+4W?=
 =?us-ascii?Q?rkAY4fZ9aPkHQbl4EdSYggDT/g3rXlviF2BhLaaHVtLBfvJciVj40mpOI3wd?=
 =?us-ascii?Q?4YvKgs5anGN+wXl6sqyBlxb27LvW5DNCIL/mgwxaVkz3brpq01GvJEFC5QrX?=
 =?us-ascii?Q?9/e7OmcfuXIdDXj13BQnsv+sbokTnGkaIXSiaTWOobux52xAasHFMEfKtMoZ?=
 =?us-ascii?Q?3+/7oWxR1gqgVNh1T9HIlmVsdIZf/KK7OfZgM6doFc80Zy1nO8YA3Wl9nudz?=
 =?us-ascii?Q?TT6eEEEzFp9kmn/vEeHds+0S+X7YvHfUD91wGgkRjG6CVO2gF2455rFffWzp?=
 =?us-ascii?Q?b1FOdVW03od1r5efjALocC17Sm0qTyb7tnmG0v/zHGntzw6VJFC4MD0SrRH+?=
 =?us-ascii?Q?JhRgpjhcXxrEty6xwL4LhaQDq0GCEt0wcUJhDjdckzt7BtPwlWvUzlikE1mY?=
 =?us-ascii?Q?gk/wHg/2CNsUTfH22nf8ic7HEydweozW7Jm/04VTaz3msBfVunJ1AED7ij0p?=
 =?us-ascii?Q?ae8LfPClfvHe72oU7SO6xw7BZbl/y/ov8N+EgC4qySVEMB6m1KxMycPyJO0d?=
 =?us-ascii?Q?wDAE3ZOy170jZExdTb9IKZE1GYDVzdHTn5KpjF5yUdFsBWrvB2FYiAE+1PZB?=
 =?us-ascii?Q?p8iZNHs2kFPBn8f85whJbhrqURQ8l52VeTU/Xw5DfdCH2hJLs+zT/gbNmDOB?=
 =?us-ascii?Q?xA1glfO6jHcxKTPEpRymME3Veq5UF6UUzFrrqOIJFCjx/1PdWW17Uk6frdoQ?=
 =?us-ascii?Q?EnM0crgD57OUxe51j7t4ltgk8X8SHJ4HJr/txNQ+pnJ1Ycm8xUaWrQWIB9F4?=
 =?us-ascii?Q?XhfPilnIs/5IEiQNYbsYUDjXpFQarC5W?=
X-Forefront-Antispam-Report: CIP:8.4.225.30; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:owa.infinera.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 16:11:20.3562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34804cb-3d3a-4704-7611-08dcd98edd89
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77; Ip=[8.4.225.30];
 Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6426
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

From: Mykyta Iziumtsev <miziumtsev@infinera.com>

Adds support for secp521r1 ECDSA in mkimgage
---
 include/u-boot/ecdsa.h      | 1 +
 lib/ecdsa/ecdsa-libcrypto.c | 2 +-
 tools/image-sig-host.c      | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
index 6e0269e3ae..ea37217d86 100644
--- a/include/u-boot/ecdsa.h
+++ b/include/u-boot/ecdsa.h
@@ -66,5 +66,6 @@ int ecdsa_verify(struct image_sign_info *info,
 /** @} */
 
 #define ECDSA256_BYTES	(256 / 8)
+#define ECDSA521_BYTES	((521 + 7) / 8)
 
 #endif
diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index d5939af2c5..6cbbdb6680 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -108,7 +108,7 @@ static size_t ecdsa_key_size_bytes(const EC_KEY *key)
 	const EC_GROUP *group;
 
 	group = EC_KEY_get0_group(key);
-	return EC_GROUP_order_bits(group) / 8;
+	return (EC_GROUP_order_bits(group) + 7) / 8;
 }
 
 static int read_key(struct signer *ctx, const char *key_name)
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index d0133aec4c..21b4fa5d39 100644
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

