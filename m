Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2E0CFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE86883F9D;
	Tue, 25 Nov 2025 09:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RSG5n09u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2878D83F72; Tue, 25 Nov 2025 09:13:38 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD6CC83F85
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuoTMcYGwE7Jk3vaDCO16FZmIMYwMnILop3P+InMzVhLtfMP6wpKPHcb9CWlvh1R17FO9/t+ZR4yJ51yBwPOLpxeqKQaWhnzJqTWgAZl2SIrZfsy7Ih+3s5OdOC8sBfzymye2uOfqIPwzzlCCZFsLfFtRhz4B31wpnZLoZE2OPd1foDSyvQjR8G3XjXP092+T+eKrnG9ch86leZHTOnm/XVU/ybfRf9BjE8TTwGD670w1F1g/nf9u7tITaekAOnFJllyMN1u8RvT1q5wc+xyh6j2wV34ekqT1D95ThqtHPRaq58tD7NSTtVqi+J/lWAa6CRmG/dPFduTKX+NFOmzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/OuUwlq0xxHWmR7k5ITQc9INNbCuq2aAhjGtDAhtvs=;
 b=Anh3R0myQUv16hYlYiRYghFhd272X4ETmtP4rlQHsZrNXTNVYOTbftXgMsXIu1BoqUfd1dbBf7bv58H673ctGeuv7McVt9Ym1sh5zhiPj4eViLv9iVeWm12Y6QYfnbJfdeavHHoTToi0CTnuH4iyS3s3ysb5dK6gQYcB9s+H+cmnVT9Qd5xB1myAQRxZaoD0Zdu24ktcFGjtKx5jiE1NMv41WMg0rU4tWuGXK9TiPkBZIAaoXGBmM4ennt47OSyYUgeNmY5CwrNwx9eWP66qAu+4YaPso7bapG3MJYP+2OS0B5c10CIJpAxQyxXsRNhsmuUjtUMrSxp8KetsZ7n8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/OuUwlq0xxHWmR7k5ITQc9INNbCuq2aAhjGtDAhtvs=;
 b=RSG5n09uyZQEzHs2zMMgET4P4KmfBV3p/TP3oictmA6gaI07BfOX/exWUszRfaxDlGsxnDk7dAyNkK6jk9R9wPbMErib+ialWyLu6bqpLE9emdaqUQ6qEQkE8qzzjZymUwfrY53w6XGawHqnvZB/iOVKiEcOShutBfukwoDha9JU9ljNX0oB16xH7lWtFzbqSmizUpb9/x7MrW6b7JowGDmAiGMgGDOq2CcTzk4Wbq4hgXc7mSxoTT0ODLhX9ihANb4kD5qNx/4DJZWXoL5uQK2kxOdwqbs+f0rEA1F6/CRQl71khYflV4QYdE1qepgMvDWLXynmXOsuiizhH0ZT2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS7PR03MB5447.namprd03.prod.outlook.com (2603:10b6:5:2c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:13:30 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:13:30 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 5/8] spl: Remove ARCH_SOCFPGA from MMC raw mode enablement
Date: Tue, 25 Nov 2025 00:13:13 -0800
Message-ID: <20251125081316.17329-6-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|DS7PR03MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cb14e7-b578-4abe-9972-08de2bfa8471
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h9HuURcSP0c5x/FUABJFFqdxK7VwBtB8BLCsvpdTzXQ3zok5RSeEXAOih2x0?=
 =?us-ascii?Q?AIUnXjtnOl4sTeBJT/kmQj4ym6cU8W4UHEfYsj5x2xm9CFtgrAC6HJ2+OVz7?=
 =?us-ascii?Q?rVAIr8bjnJyZjHzLRYmU+6vpbiRvNThlImeYX4iuVDU9JeQ3hLYxNKL9awQN?=
 =?us-ascii?Q?8VbnUEr5s4JRfweZWn3gLXKjdJjjiwioxBafniwFU5nhlBYQZo3dkYk8KmoC?=
 =?us-ascii?Q?VEvCwBYC9YtSjC3+jTz9cmAoBKd1LEjcM5X4zfHXs3hsOnu8dnd6GttQspkV?=
 =?us-ascii?Q?nkov8fefde3bWKKdFaBfWEk+R/MB7QIdU1mg5zJ4/LVizJ9DYKVk4JQ4Txih?=
 =?us-ascii?Q?RY+LJfpEnjIUIg/SpTtMCw10jtOj+ot9jeX5PJ6Sdc8DSTsvp6sZ0VnA04xk?=
 =?us-ascii?Q?osaNeHZpNLR+4s+k50KykBF/fjUkjpe1z6tbk73vMcMZZ6sXq8yIiEAMrE5S?=
 =?us-ascii?Q?Rg+Ees6O7/tZ0c5AFqfqkJ6GqU0uu9YkKl6uCYWjhbZ2W4s5pNPGsCStoUqU?=
 =?us-ascii?Q?ao36zNONKLFPTxwgT8Zj5v4DuO1/lldgu3UIEDwq3n08drjy0IFh/+QgKjjj?=
 =?us-ascii?Q?vN4dzkLUvaHMgq6qeBbk9eXCAvDfI7EeKJRJao1ch7w4lP23LYEThFwIqA1n?=
 =?us-ascii?Q?fA/dgOJuIJbTvKTI+SWjNAU7tiCjfLe+XjJgjEo0F0et3j//PGr8IjF77Bn9?=
 =?us-ascii?Q?f/gOLN0EESeMe3uF07SD7c6ttZk8qlPogI5BLpPjgHO1lLbrVyipHnryUf52?=
 =?us-ascii?Q?tQSxi+8nXT8KCA4K13FU2HcqovOyl18mFG/xUvTZP0tOJ52VR12JWyxdHXCX?=
 =?us-ascii?Q?+bEx8QYxWphmQpoNhVwZslfF7bRCluJ0k0Pg7pSOTaxBWnitQEumQwSkPdVZ?=
 =?us-ascii?Q?QXFQzGSGl1N/zwoIsOhXg6uolBCyamcZs05lIVKJdZ1TOVB8bheVRNOgNvRV?=
 =?us-ascii?Q?Zdo8t04ERLyJ9MDBvZ4D2aE51Q2tX7qOlWEbulEKrl+BOu4XcsN+YnZgLz7m?=
 =?us-ascii?Q?BqVPhbnCLMHalFMna8gFh4+j7gHiBTEfpesaVBN4lrlPU+g7qUUBnPCHUjEO?=
 =?us-ascii?Q?kfSgIhTfzu4qwnknaKrV4kaGMxClUj0NFoheMvElzBOWbx1aX4IZ2QIfWrtb?=
 =?us-ascii?Q?jlDXdNzzta/U/TBgPIn2Ai+KABgW1omin2IcnAjwFrtIzKQ265znl6DVZtYf?=
 =?us-ascii?Q?IR2LNUXHlsfljruzMy/H0Xaj5VCpnPIE95Wuir9zemiEX8LD/Momx/+jZq29?=
 =?us-ascii?Q?k5pvOtdc9GPjahfzxScdNPJjJVlX7JZ3vJB0HE0SN6rAdNKBBI/m4GF5w7OF?=
 =?us-ascii?Q?cfqTl/diXGF/zuxseHRopF4kdOoqndb09rcdkHsdfnSIzI56xiL9WO1ptu2m?=
 =?us-ascii?Q?hIuAhVn3qULg4Nn8SqNB/ojHK1ZZImLRPhRGABA/DUM7No9I615xgHEXjuR+?=
 =?us-ascii?Q?uN9+kqv2M2pKg6x1cw9v1FbBhby9GGF5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SpbX/+QHdOrwJgA64otvRkhw0Qx5q64NZVX4Swnf6Rj1XJHbLqPk9C7vEcJQ?=
 =?us-ascii?Q?7K3Y1D4LZcf8LRluVckO//dmigyA8xkkZSYRNefU6MZXv+asmkpRCplrvb78?=
 =?us-ascii?Q?xKw55IVzmAmR/JpIHNff+zY2y/PhnOI0nCroyHgH2ScaZ/6NYwALjOe/I+ly?=
 =?us-ascii?Q?iyK0vk4xKisid+VC4HksIDa5L2+8U0I+K0X97bKk0OfknwtDo7wdWdg03pT7?=
 =?us-ascii?Q?cxK/Rnu9xxLu6Z8zmHlmSI8hm6a9erSuLfSVvgM67f6vFigKWrbc7gnVd1OG?=
 =?us-ascii?Q?Iers83kXrwjvjt1voXXQ2UWEjz9GSFK3rvNjmLIoA7lVf+41nBOhPLfL6Tc5?=
 =?us-ascii?Q?vfGdxA5W5WnGW4nzKv+/c+zr+33XPAzn/ECSPU5/8osEEgPYX9Um7JuhbVAh?=
 =?us-ascii?Q?v19YXuU9oUTtG/GOkyxFL2VrUIBTA8BLBywg6BeBfOBSmhx+PjFNNQKZgGq4?=
 =?us-ascii?Q?px1f4ggBxEIfFjJwayia5KjHjsCryNd1ag5HUe9EsPdo7QMA6JxCcu/K3wTU?=
 =?us-ascii?Q?oj5KNeSsuzUoqqLdG46+oLn3/jMTJ8ShsCAaA+SUFwmsnOJqiTIoyDS1hMWB?=
 =?us-ascii?Q?0juBkcFuDBsLgTuwkyrA859OwxCudQ2RucpW+0PWBF4IESWM3vBPfL9CuL2F?=
 =?us-ascii?Q?R/ejdMJx+Vh+Ix9lZuze8M0txqqp0fI5qm6CaNNBl8jORmTWcCJMiAxGGKwp?=
 =?us-ascii?Q?+Ufc3fw8uDj1zpx04ypzLA555xrHDic2fSGufQ4J/4l2vWMSjPlzahKuXeye?=
 =?us-ascii?Q?rtUW9NTardy8Ouqxq02pnAEGDd5wm3zGuxjqmmCdS1PB1xheikyw0QTGBmNs?=
 =?us-ascii?Q?BwT/ECK0WGnX4f7GEvF7IwsKiPNQbswKlHG9KxZBgweC7oxHHN1q559Bake5?=
 =?us-ascii?Q?i+G2qI/WgT1biPuSASZds/f1ThzDSq0OF0o1Br9MJUDep4X9uuhsniUbB2FA?=
 =?us-ascii?Q?0eMVzHct1ir310mwWRHrSRZKORCWZejCuQvC015gsP7uwHFf85zEdSfVHpT+?=
 =?us-ascii?Q?DXPWfoaMiqtr8eaty1Nlv3a6BcjF1ECVgpWdlQLq7rmHRuFISZNN2LVgvR9G?=
 =?us-ascii?Q?fHe147Ho/cajMJRNEkEbp5K8IvwIkQb3ubQm0oGfOyFjhrGZitoIzh0xec+/?=
 =?us-ascii?Q?At5TwMHNvu3iBO2gVN6csnbuSU1C7JQXmohGjecfHKOz2pB7L346nScWiz/j?=
 =?us-ascii?Q?GJ0kgIk12dOTvQc/UPZOcG3sitWqkx7OMVcAixaFYi6ndxkj03HpJu8zBwig?=
 =?us-ascii?Q?rOtI3vYF3pHeQT6HnvjDymo7BN1e+qho5U1+SQbzBGVDyS0J7CJ97xuFvjoX?=
 =?us-ascii?Q?2h8VMdketHFQBgLn40Cy/7mWYnv78sbMb5wr4h7lWKqjmDzEo/F5ZGnmJZ4U?=
 =?us-ascii?Q?iuTE6YADHqUownxaSEbwqrFwhA5BWb+QTzReJaCdq9W4//JtBgaF82mxpCVz?=
 =?us-ascii?Q?XtTa/kkR2wpS0ayYWJETTgLwbBHNLlJxAhdvlgXkrwxfM14fv4t1cpcF9JjY?=
 =?us-ascii?Q?6zdJuLE66iN9wv8kScwsR3/Uf7pY7Dzg+Huzs5zh6+z0so7SS3fB8EMjzilE?=
 =?us-ascii?Q?CUDtY29FLNVlxSTIVTrPynCNGXW8u9Cddi4vMHJM7GFWDEsHbaG8i8p0yiO3?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cb14e7-b578-4abe-9972-08de2bfa8471
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:13:29.7784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6H45IZdQfc5+LGBoYbmcHwju6dzBV+S8TgD7ANqAMs2g2CXU4/JeuLwAi0pTfNd2QLfJQPm98m3ink2fJCMJCSnxtbwljyA+X03lBlprRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5447
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

We no longer use raw mode to boot from MMC for our devices in favor
of FAT filesystem.

Maintaining this config for legacy gen5 devices as to not risk breaking
any configurations still utilizing raw mode.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 common/spl/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index d24466b0c66..142cdb34cd5 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -545,7 +545,7 @@ config SPL_SYS_MMCSD_RAW_MODE
 	depends on SPL_DM_MMC || SPL_MMC
 	default y if ARCH_SUNXI || ARCH_DAVINCI || ARCH_UNIPHIER || \
 		     ARCH_MX6 || ARCH_MX7 || \
-		     ARCH_ROCKCHIP || ARCH_MVEBU ||  ARCH_SOCFPGA || \
+		     ARCH_ROCKCHIP || ARCH_MVEBU || TARGET_SOCFPGA_GEN5 || \
 		     ARCH_AT91 || ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
 		     OMAP54XX || AM33XX || AM43XX || \
 		     TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
@@ -590,7 +590,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 	default 0x8a if ARCH_MX6 || ARCH_MX7
 	default 0x100 if ARCH_UNIPHIER
 	default 0x0 if ARCH_MVEBU
-	default 0x200 if ARCH_SOCFPGA || ARCH_AT91
+	default 0x200 if TARGET_SOCFPGA_GEN5 || ARCH_AT91
 	default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
 		         OMAP54XX || AM33XX || AM43XX || ARCH_K3
 	default 0x4000 if ARCH_ROCKCHIP
-- 
2.43.7

