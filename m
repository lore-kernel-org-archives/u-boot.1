Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A537CF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16EF188902;
	Fri, 20 Sep 2024 18:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="lsNXYTnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 869B288965; Fri, 20 Sep 2024 18:15:32 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F76D8888F
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infinera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Joakim.Tjernlund@infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/wmbfARwvdH45Ga6War90RcZP+eBwenNPW8+jbd5iSTh4eZ0aI6FRoQR6XeMwoUh/+QhWonpxJe/ezgy7y94iq5I0zfrKe62p3WQ0XwzpXZyNanhcx7ztdmVVUgl1DTHHLdyAMenuUnC3x2Ng5MfpV3SyPD8syWGjPM5W/VlbRia8QLm/Z9xHXRBHVppP6lGWfuFSx7E3AqP3Q4HMqqKLYXFK97IVzo3Dr+cdHy1xYgHXADcR9RirLazC29Npnq6RDmNC34Wht5BceD0izu/C7ARTvVy+5kFSrAY8F7oqxayFUsdokEFizAv8KIdGX6DxCtbeObFvzTXGMB7fCEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SatAa9hhOk8UySM1Hhg9uJcjuP/j4PfpgwGQt3pzS3w=;
 b=j8uCO2BFrHv65xFUaofwRY30Gxd3l3uKuz8On2oHCDX9IhBz67NP3sghwRq6v7jn+zbcHJIDKxDzz+2+Qs3WWdLEXlx7bocDi+h7YLwoNMwTbsjLMZokYOcqz2fXAOeT1kPRw0Setnblxv5TNnJ1Tw4YQCH7mq0PXSq0nLRxqVYgrZCtCYpjdtpUfnAnoqbdQ5Y7RhuFZe0GRH4t73AafH62/aI2FUkTTeKUw7NhE/wBjvwwK2eazj5cx9JMmvgtUqqy2aiJ4nowzKpvBwaxl5vFzyoo5gR1hr6034ZWvbVGqczB2nDcEQOPqgM/ixMiyA7e05nbfxvec5sd/kPSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SatAa9hhOk8UySM1Hhg9uJcjuP/j4PfpgwGQt3pzS3w=;
 b=lsNXYTnUVUZl8ElbVDZ68iJDNo0zMb/cVjhINx2U4jcsvjhZeW6oCOh1EW+TblD4kZFovSQjut0/jErzaMIR/z99sKupVAJ1H918NWswJiPiRIDkRQZEumIKHPMgjC8PlvV4bX+XehLAArxp+Uyc+gD7JhnyS2fmk55Ptjqp4UhLZa/FVK4UcDRpmutM8XTFkTwKIRU0hDuXbEI4xS+2+c/2++IOdZHXfXoxZarIU7hb6GXjNLj0hdKPOaKrv7Q3J89w91yNKbxxx9sqMUN9DGHuMls1uu/2wL8RG8ogaYn8S736tWWLReIpnyFoG/oq+xu4Yevyl5Bh7dvA/yG1eQ==
Received: from BN7PR02CA0031.namprd02.prod.outlook.com (2603:10b6:408:20::44)
 by BL3PR10MB6212.namprd10.prod.outlook.com (2603:10b6:208:38c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 16:15:27 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::ee) by BN7PR02CA0031.outlook.office365.com
 (2603:10b6:408:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Fri, 20 Sep 2024 16:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com; 
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 16:15:25 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 09:15:24 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 09:15:24 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by
 sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697); 
 Fri, 20 Sep 2024 09:15:24 -0700
Received: from se-jocke-lx.infinera.com (se-jocke-lx.infinera.com
 [10.210.73.28])
 by se-metroit-prd1.infinera.com (Postfix) with ESMTP id B9B51F40077;
 Fri, 20 Sep 2024 18:15:23 +0200 (CEST)
Received: by se-jocke-lx.infinera.com (Postfix, from userid 1001)
 id B319F4D3ED9C; Fri, 20 Sep 2024 18:15:23 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH] Add mkimage secp521r1 ECDSA curve support
Date: Fri, 20 Sep 2024 18:14:35 +0200
Message-ID: <20240920161521.917955-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <CAFLszTj0HNbEy7VSaDA=Vd05+EWT1rxcDOBxu6e=BY1aQ54ZPg@mail.gmail.com>
References: <CAFLszTj0HNbEy7VSaDA=Vd05+EWT1rxcDOBxu6e=BY1aQ54ZPg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Sep 2024 16:15:24.0769 (UTC)
 FILETIME=[4CA90D10:01DB0B78]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|BL3PR10MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 47db67a5-f640-452c-13d0-08dcd98f6fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w6oG/UxBBfTNWm5CtfGzvpmXOI81iszo+3yVNph3KeqodKYL7MGdjba8YvHP?=
 =?us-ascii?Q?vhJgoAu13rQ9eruktyRJg9HbBTmrKqdwjTn+QRO838ppSlZ5wDn+yseyDBBs?=
 =?us-ascii?Q?bt+zBOW96hLatF3blBZLEW0BqjDJ1uPeLN54LFczCAtnCcn9oAcqXMX5WH4W?=
 =?us-ascii?Q?PEhS3BobpfISnpItiWhempcZMZltdiQ3+xrd2Jo8LlztvMkBAcTSfLo6FbXG?=
 =?us-ascii?Q?2X7BtresXAxYKPaT1Jan7XIxcOVdxV6Sg+8WO0ruqbjjVP1eHaFzoEW5Qmhb?=
 =?us-ascii?Q?OtxebJ4F0zS2VXjNgiPJMwgoYcSjk3WGlyB7RF5+/bGbb6xgfzuLm9gdZsok?=
 =?us-ascii?Q?2o66XwCuwdmNehAb2sp13e9HM0CmmftYM6ntQU+ex63aZ3GmnKYypt9isSKz?=
 =?us-ascii?Q?0yhf+7vn2gAih2mbJNFdnALC/lDguCAIblbSe4uWiEsWEZJKIxx/hH5GompU?=
 =?us-ascii?Q?GVMdP9/pAOfHODC2vZx3MLnuG2uPC6UbzpF/rBsoaGKFqoRlifTWG9t5LLNh?=
 =?us-ascii?Q?O5EJJv/zeBKFnfy75cVaB8yVL5fM0WadfKegm3bslEvHh6duAiGK7MxJt6JY?=
 =?us-ascii?Q?UJ6IT7BPmOC/kJVAfimx4W4fgaMKnpu1Pzzddyo04j8YBqvkUdk5hfecE+yO?=
 =?us-ascii?Q?Pay8GcNtNXKBB/aITFS2ZOaAmafJlChLcZOLXtiYN69aLvtJJGPItQTttOmw?=
 =?us-ascii?Q?VzVCQC8/NC28RiaFe13HZkP7o+OYTUyDyNl/y+hbtF00tQSPWukywRlHl7lc?=
 =?us-ascii?Q?y1IP4pt4Yo5wKuvPtwT3aUAQ/q/MOexzoTxttrFLyyr/J+tzGNoQjQrXlIsC?=
 =?us-ascii?Q?QAoBnkdFRNgCjQH/vkIrvdES1xM4lJSN5DH/LMQNuyeg5k36QlOJzEVHgVrq?=
 =?us-ascii?Q?+nFkG20OlkRcnxDTEtSw75xsVCgSGEVqYP+Bvgd8UJY/HCHK9tthgSB94IMq?=
 =?us-ascii?Q?NTM26afh63ytFOPyk+WesFMJ/pkfd0AP6IjP1DyKt+Aof2hM5nhfdz1ysy3O?=
 =?us-ascii?Q?p89XEa3euiwoaYBw77yYWbrGEc4BwcC1CyFbFkDucPYG7bj6l9WCB53sGg2Z?=
 =?us-ascii?Q?yq4igx39lmcaVZR3zTLaL4HRe3TcPPBRKV9hRWCpLziIOpOZcaUdSzRbyhUm?=
 =?us-ascii?Q?dGNsVUkzRcNhl8iEY45qcFe/Ciewufa+JdOZsBYRmj4DYLM/l0CkV40tQ/Nh?=
 =?us-ascii?Q?aRV+o8WmaiYMUXqai/wQw89f8gjn7tF590MkkUXp8Yq+hY38gVXnhmkvGwpf?=
 =?us-ascii?Q?LV7cmatkwRj3Ng51mRwX0hWLDOyVsLpet4IBX27106biXcIo6DEca45nrvV0?=
 =?us-ascii?Q?lnCrvTmRdHFdVchvNvOaaS0CeGKeNaha7QbeVl2TZpr46Aqmohsp2BOZbxMT?=
 =?us-ascii?Q?jL/Yet5eQBwkNJZlntOynftdOtUoG+nzOafn1MHurHtS6pky2COJ34yme14i?=
 =?us-ascii?Q?syXxzISbzksyKZ/TJgYlpaNC5vzZfCnM?=
X-Forefront-Antispam-Report: CIP:8.4.225.30; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:owa.infinera.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 16:15:25.6287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47db67a5-f640-452c-13d0-08dcd98f6fbb
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77; Ip=[8.4.225.30];
 Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6212
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

Adds support for secp521r1 ECDSA in mkimage

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

