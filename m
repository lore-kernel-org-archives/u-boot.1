Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246D8106B533
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 13:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F888352B;
	Wed, 25 Mar 2026 14:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PhbcsUiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71332838BB; Wed, 25 Mar 2026 06:45:44 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A6581E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 06:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOXpVvgM+B0huTzZerU8KTivMrdcDNMT8NpxElDbaC5zo4Di1Dgicbn0xd+t+ItS28QBP4mle2v+zJCTElk7aAoG2PecW+KO8B9Z1YDZSXNNZHcRKzighhxTqhKPsTFzM2WQ6JvwmkV9gAnkp2mTRNt7N04RbX+izipdXy/JbcmCGjRGBxneemhfJp4Fnor9iq/bMT0ZPKOVO3p+XNoMEIHawJqJNp7OmOa7WWVmgnzC6kktUokZ/S93uIeEuy/o6cmOK0E5S9RzpCcn9D3Wkc8mFBS1gkaWUTbnD8nCS2xtB7nunqcEvnZPaQ5PC0iSktxjqltCwYK72TnxgSRmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxkWNybJsUmHpO4fPetJeptlPslveno/ONdLqPt85Cc=;
 b=mWHWlBzuNta0EkTCV4s8XWTNoKDJHtzWUNkx7vCJGuEILGHNuQe1jKW0KoMoG5LI590QXkgNk6AEzXaXTa30am/UK/GqwgjxpfhiGVgl72PvWHwFmkfP0RI1FqyCQFJzrtO6jeCAeSoqGGjKdWCm1zjq2NG+rkU2SGQEmOB2m1whekSXd9pupeMmvLlQVwdombMimOPYmbmOCedoq4gHdht1EYgXlC6+viJWKWJxR5j41bh4CXG0bMCbRgkkcMFTqp6YlFpeGESLw7koiuJ2ZOYvKWwwRQqjz66WgmLHDDfGdvGOsQQdTZg65dERo3yJD/xKTn2semI1zoFR9n4ypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxkWNybJsUmHpO4fPetJeptlPslveno/ONdLqPt85Cc=;
 b=PhbcsUiRi19/0ArS3upRfB4iGX3iuSAKOHfh+6w1ADruWs0C0+xLMGe6/gN7aOPpJnLpoQ09KYTByWaXokxJkig2S5QEOg6f7DhlsATDzbLJk0Yzd5T+JmrThRLaRkPoVVShh4/8ADrWvT0MUDAqnGqBSGu2AUSuZWudZPZ5F+5Bn7tG/Jlme+z3X4sReUMGRq7Zqqd3tTWSNcit9b8sFy68H1USkL6sv3OgMkR88yeLcOpoU+mvPieVHJszUDDbHjkx/LdUmksokR0iMqSDSoKhggN8CHOTW0ELPjIVW8rRT1WL2HNuc5GliWwRPndhd5HuGZV2bX6FuO3KRYXj1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH0PR03MB5956.namprd03.prod.outlook.com (2603:10b6:610:e3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 05:44:58 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 05:44:57 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH] arm: socfpga: Setting the image magic value to romcode
 initswstate register
Date: Wed, 25 Mar 2026 13:44:11 +0800
Message-ID: <20260325054411.13071-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH0PR03MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: db3916d5-c70d-45b2-1c07-08de8a31a5b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|55112099003|18002099003; 
X-Microsoft-Antispam-Message-Info: V51e4T/L6hgsiWlktmCVup7oV1LTJOnm+yL6FIflp7VwPHaITJdboJv1o3XSdPrLmBvTDS35NL20IfTFFly160A4bb8EDIFoS+HcVnHyFoYRHOI+nTtI85ONpeKIZg0QxHkfRWIjLo3qqouSCeyDqm56Bcw63dUM/NJTdOrL9UxxdW1pTNtbX4t6UkzKnelM+CD9KiriMSYvMUJqOPSBo4KSfGuDUfITrgqpq8LF5f/A2cS9YloTQEhPaB2/tbI85t5RIzWjrkdc7b0WPoazFykxwHxEKSboKTP0ZqIT6qiGasW+ZwZHa8wK2cXO4hHAJcMOzJXSI+c6O+hdqpHPCiFmvcbSmSwzZHrCo4dmwxoIm+wWKnjDKvbO/ZKVDBpfX3sX21gcYhZj2pKkOLv1ROMfwPb8CAbWpGSOwr9orU+p74QRpDZS5GKKvHKcrvoGKd+8gyH3Aqtt0XtkPYT3Ly0UQch9cuVepfctxvrhwATEpPlf3tRswpVz8gGDvoapRKvQ1q5xs4EnXniqFelLkfxd+vIO3o8AAArw7EThtXgXA4DVEb68mg9Ynb3kdk+gEexAmaWXgjH2nGnQapBtH55jTkDOWUHE5YZN8RFL5NeAkLCz/t6ChksRrcehULHnlP2qb+x4ePaiccwB102+v97qmOW9PISOqggbCauU9znTTXNOeegfaCgO7JZEqIlz7q5rovPyxCnv1yiZe8qHYy6Sj0PES+KPhIMHXvOipDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OQE4qPn7S7/oHjzT1iQmiWz/clXYS8SXhNa7r7HehimhDWv821ElC7k75421?=
 =?us-ascii?Q?Gt7wrc6Eyb55bXYDwMRS7fhP5foDeeVHbgnZSpkn0kfCY3lxaKQtl/REX4pb?=
 =?us-ascii?Q?936GGN+Dxcpk8bLyb4xtiLhwT1SlPl5neIDCCqPUeQBfUzv9laxs7uWPRdBa?=
 =?us-ascii?Q?vujhzs6OpJ16Wa4AHmhRR3v12h7R2+Z/FFyWXHbP5qgY8rPOAWOkKMHIILDU?=
 =?us-ascii?Q?EVqE5lH5DQu6fVaJoYTHOJ9oH4dppZk5sgUs+nfqjNf7BsAQaF3mnoDSxeWK?=
 =?us-ascii?Q?ty7GFO6r0UzmhsRRWavh6K2nfBv2nZa+DbBE7FthWF0Qc6Vr0gloTaSlieve?=
 =?us-ascii?Q?zGAL6muXDH3cyztQuZwiugyikkVnQkf00XiomTDUK4GbVfN3VClSSyt3EiR8?=
 =?us-ascii?Q?r4vYq7TUfL57D+KA9z+LdDCb25sn86yBdVNNuLp8KWjGwPCHyEHNUAdMwgt+?=
 =?us-ascii?Q?iNPsWO8XMt4Ltc/LYtMqLlVTFIPcFsWDunhJZyWiKd5aMvbkRvgRoqehth6t?=
 =?us-ascii?Q?Un/4JGs3XkfxjWcXD1mtIK0mx0QCLORdB3/G24bJkxaypc1w81fsidyi95T0?=
 =?us-ascii?Q?jT5Uqy1ATdBLfPildj24/xs4wrU2tBL3g0oMKsGtHlg37zL4/bdIN1P0VYyB?=
 =?us-ascii?Q?TDf4/PxQPlObd2k1sYjdcednE+xwVGo8SbLzF6+GURpxQOg9GZS+YNvJu7s3?=
 =?us-ascii?Q?uToFM2pH5u7EvKnWpTfXPZtcO6SCtOaV5RsMhf77KAK1FzZ8YHrH4K9z9eVs?=
 =?us-ascii?Q?lhpDPcD3scaSzANhgBIK02Hx+7m0W1+emRDzskZ6tJMB4rMy50MlWz5HIpiR?=
 =?us-ascii?Q?Jtvm02cIn1EYEsnekZR+6ZZHV6p8vWGEy+TNVIANGdBkFFi35yoDWVq+UO81?=
 =?us-ascii?Q?dpGAROvxomQe1i0kj4mS1FdyvuILL59FMl8DYO+7c0xaAzOxyrvOleu+kbSq?=
 =?us-ascii?Q?dBUfw5lHsRAK2Gn8oxLrE7vizFAtvwL0Bnry6gDHM9g4+gVIugnslGR4zik8?=
 =?us-ascii?Q?RnCEVktxpvjnE60aX0z2Z+XoYm9J15YWtO29e8jvwjvHly0iaZ2ndy6Vi6JN?=
 =?us-ascii?Q?slY4V8PfrFpvmM3p5FJLhvcmU5LaNKY3whHuszouPEent+/X9gsB/95XKz20?=
 =?us-ascii?Q?2A8mVBJL5sTGGHW9MmkOl7VNitiQsdMxsfNM39DsvSmtLBoff+7PPqPjZOA8?=
 =?us-ascii?Q?55bk8OLCgqjydrGR0KcpFPnuBRzaYJ0ZI8M3OxHGfKT+jk5zXdX+udABHjqp?=
 =?us-ascii?Q?tx0Sd5anTDXo1GI6Xqw53XblJZL4zSuHpiZMjMPjYdBok1j0Ak7pAEXB5fF1?=
 =?us-ascii?Q?GE7jyDjoZHJMc/0/ADQdKnu40KnD2A20P2s59tNWQ186/r1EtH9P9ZBqByhl?=
 =?us-ascii?Q?7omJ9LyYLxipGhXhZW+v8WbjP4dT7ARxZJhdNsIRdvIeahy1F84FVsRqM8g6?=
 =?us-ascii?Q?A7MPf9AMLBVJtvPOnSYzKWRzjmpRQIaEkMbbUNT8cviFVB2AiqHMxIysace1?=
 =?us-ascii?Q?VBUtdH9YVFsAIxCbC5W2cWS7TFYw/wf+R496HwvBr5+IyV5IH+uqlj450h5x?=
 =?us-ascii?Q?vizBuR1PFIOaT4ff09tT31yebfS5nc7rYrI43UiINtJKwrslH4jqGz5pWLxM?=
 =?us-ascii?Q?DCGUcOiZ+Ybv5PtaGUF1WNtM5jYQHvGSbHUwUAHrLTlxbyVDbZrb4nWNyjrW?=
 =?us-ascii?Q?df64t4E57Tt6Mfiucn+z/n7IdIPW4UtHKIcLcE0oJhPoSUgKlu+MqQeMR3X+?=
 =?us-ascii?Q?mKzDH5OFuUqasd+y/X9L8mgyyicuXdU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3916d5-c70d-45b2-1c07-08de8a31a5b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 05:44:57.6565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBKBaCrHqrG2qbIIYRXTGjRD/jNe+US6ETgZkPCm7hnV4emctipBiXovuT1hNu98t+ku4E6jlKluzjia/cU7KZvF6meGMdZc2dXjT6z2ZUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5956
X-Mailman-Approved-At: Wed, 25 Mar 2026 14:25:38 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

The romcode_initswstate register need to be set with FSBL_IMAGE_IS_VALID
value if the current FSBL image is found valid, otherwise BootROM will
look for next subsequent valid FSBL image when warm reset is triggered.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/include/mach/system_manager_arria10.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h b/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
index 0afe63e647e..346db78aff2 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
@@ -37,6 +37,8 @@
 #define SYSMGR_A10_ISW_HANDOFF_BASE		0x230
 #define SYSMGR_A10_ISW_HANDOFF_7		0x1c
 
+#define SYSMGR_A10_ROMCODE_INITSWSTATE		0x20C
+
 #define SYSMGR_SDMMC				SYSMGR_A10_SDMMC
 
 #define SYSMGR_SDMMC_SMPLSEL_SHIFT	4
-- 
2.43.7

