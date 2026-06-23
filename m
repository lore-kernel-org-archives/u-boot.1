Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92EBCDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1BB84A77;
	Tue, 23 Jun 2026 08:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RTjXw1Uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A43A849E4; Tue, 23 Jun 2026 04:02:59 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E27A849D2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufbAC5MxjbAnRXK9cfhB6wll163e5HF/ytszmZ1CKIWFRQX2fFIjo8JTH/1uKzwCqsoSI6niXxqycTXV7rEQaQGYb5OzZPxiA92ZxOaj0SNJDDzszgts1sQ54oYccTb0NOzGGW2OBGmezSr3WcZIg2zJhNAWmN6WBveShuoNAG4D5fS5FgMpraehyMUXe7cyRIoL8r8+AFYNvxbXvvgETB/aN5Ua8H9P60x28Q9TLVvfQCbNNA+l5uF2PKmMkGIiE9NzyAyFbuU65a1iq0SN3sto1QDNwAF28Eu0uKTB2R5gSixI2U4gABz6dE68EAoiGnfD+W5QL3Ulw3G4zRqshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnOIdjZzcgM42p2bGKyRHlnA/ZCS7sy3h4HSPWl8RRM=;
 b=zJttZLRmdgjlvLWLaYfP7g+2vhrnFDBAPG6AoMxC/nur6rjQp9qqT6zji3I69cctzo7zpS9CInzTZo9U4eAlnqeaoRmd8EI4dBMDXf+/QeWo/+W2tFf42KSUbEYU2sjY/AyGt7c4GoVEmQcFL55pnpTTOWDbk0ezikZrpFKOf/LnfTwK07dPa14h1ZLj68We3PwrA5n7Jjh98B8TZutaj+5XVHg63ns/Wd3EshQZ9zCjw8+dbd4rhucJEpEmDW19VXsekWGmXIk5kjfgj94BBJXt/0izvIhy0HSTiW6tvICQPLrTgKiEmGFr4EnDlEKZTWe9kGIzv5/K/C3MJLPkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnOIdjZzcgM42p2bGKyRHlnA/ZCS7sy3h4HSPWl8RRM=;
 b=RTjXw1UclCHnMymWQK3BBIGJkGS/lwNv6aSCnKDogTE78HTT9sSsl8Jk5CnlwHPbV7NUrL1xp08G6g7ZcrZt2Ysdt42AUaYGmqn+Lwh8cYSdUl9euF0JXqyb4+/AGFWxpvXWWS72FyPZs6YqZJyK41jdHV3gn+doaS9LT8LO0q0AZvhasPiTTHnF8UIE60UiGjBKl5VTbZ1i8rgZIbqiKdb+QF5Z+ioczEEUIrQhUGkeeWBClfaGtOr1ZjAWEfKaxGvJT4/J0BzCC592a5wrbNeU8FOZ6cfvZwOyZ7xlurkMbIc3pHeWLO8bt+HZLDuzYyAIbJ64l0x32FumCm+n4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CH4PR03MB7627.namprd03.prod.outlook.com (2603:10b6:610:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:02:54 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:02:54 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v4 3/7] configs: socfpga: n5x: enable CMD_MTD
Date: Tue, 23 Jun 2026 10:02:17 +0800
Message-ID: <20260623020221.32362-4-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260623020221.32362-1-chen.huei.lok@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|CH4PR03MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f1176f-9bae-444c-6705-08ded0cb89f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: JJvKDcnZe5oE8FQHe3HkzcZ7hfivLLq1SPZN6Zl7ZD51QLYBz/RsOsSYCSVHBCi0k0cf4K17tJeoRqMC+Ca2MOyMnFzc4W4Qk3seVT4l6n9RNvmCDhUR6KIUHUr14JZEoiBf2gcesnyNVxL/UirdlJruOxV173v9vk731pferbaDHdBTMV9LnfgYZ03lOdxx9u4c0u7YS7sgfIIlABCxffZuUKXParAx83WsSTCexZZevGjQdZcv+EyJM8vkuwt5zQe1zBi72zQvJaj4O+hEEXoszM4q87K+2J980XYBQdsFR1wnhOfGxV594eHVII0At7hnLUkbpmm3MOBvmJ3xrsGq+Isz6MT9tuaBLKhXxwNuQGCgO+XsZaf4RGwVi9/h90yQI91X0mbRcAOjQyiCUQWNnkEtjxyzXzrJeShtbMilyGGEcaoBWQxgwAilTWDxeX+y2XqM1a3/UXIU4rCxVYusCTJapa3nGxrKj2N5sd9KVHcZI95DUcR/p91Xs7n3UaTham/Fos7jHLdFYVv81IPAMT8u1zL1G0+3KYtqEK+27npnp6u9/bozYdfaQzJ/l/W2UojC2dIcRosaDcAjRK9+ZQCtw7NSaMLl+0YVqfBRBbkB2ey98OLeAXShb3GA4u5lb4T+J4tUb+PeQPSAgHNd6wpsUU5MoJqJHxnGSXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UrqzWYfG6+Cg4YyUlXNnNWpRf/AIXADg8ItZITSkUorKTf33qT42+rLAT/La?=
 =?us-ascii?Q?t8OHAAjEXVjEWeVzeksuXxdWMcq3Q/05KN6WujqmlJb3fnusc0dEAxAVF9zu?=
 =?us-ascii?Q?CkwxnBWEua3YM4Uyz6V9t3qXpPn3rdeRRdekWyPVF18hrmuTkeadHIgIZCPG?=
 =?us-ascii?Q?rI8Yl3BMxe0+RurjhpKNL5vPGxYmIOCvXfYaDTOLieYXy/FJ50P/Kkl44h+M?=
 =?us-ascii?Q?XQK8czTuZMlHPpULB3ZQvsSpz2XLKvqskSya+dCMUdEJfCE58tTTsi4J8zAD?=
 =?us-ascii?Q?2l4m9Y+gmL/TaBKdgGzUbtmQd9ShmkL7vApBwQNINoQSbPup4XK5cPD/54XS?=
 =?us-ascii?Q?7ydNw+UJtgkxFL7mMqtPIFVwLSjubIZelFKRjnQ1JkfnRFGJqfz5pLQ7jyiM?=
 =?us-ascii?Q?YXxBnHcnZhh5Oa3Uho9dRVRIVrOvRdHh/WdQuS2WdwBqzdZqSk0hSX5EbHAN?=
 =?us-ascii?Q?dAd0bdq/hRQv6qAgTJ4EsPRs977pLycP94XGxFk2PcrRwi/5xEjg+pkLFVYo?=
 =?us-ascii?Q?YxWxpb/6XFMFcvAkjUbcOH6w6Q5zJt1PCpmWH7xKsJkfntDAHyR34ZjgcIGQ?=
 =?us-ascii?Q?Iy5NW4FMIbSzzqFNujEesGdFjUMZ5dIShcvo87cRBahLDOVWBfooa5tkl218?=
 =?us-ascii?Q?DypJV7VQbhWwqR5S+R1h5TaEnS68/h1jPjXwcwmzRFLoUVSsXE5p00svWYI1?=
 =?us-ascii?Q?AuWkHa+AiFHcSU6V7c1ZQYv31UTvqRmyY//Dv6FXyh4x+MQMzHUtiTR2kMwj?=
 =?us-ascii?Q?g3tCckgSevwDmTW6RnrgxcxNz5Izsv/RwkR4ztR/lMHp5Z/8IjPopFgXNj7n?=
 =?us-ascii?Q?4t8cyU2YmdjrXeF9S7x0bcCIhWskpNDq7zNPg2Vu5e4n5x3Ugu1oMIWJgluI?=
 =?us-ascii?Q?CmHwy1Le9Jxdm5w0w3yGzwJF8EmTW3Zzi+z7pCNpkdWOPyT+DUfaKkGJPfKH?=
 =?us-ascii?Q?x/JekMGzj7jIYS72+n17tDQmwXbchV/BsxIfIge2XE+skRezgk+FN5ICliqZ?=
 =?us-ascii?Q?AYSU6kgv9t4aaNnuloDMOGWLULM6SE5iXxVxY5i1M3QKVDDTL/14rPUPnae/?=
 =?us-ascii?Q?qIzumziIi2lCOCYNcIc5ydyxr3qD7YO2Kfth4/UxXEYa/I8127p4SuVwizDF?=
 =?us-ascii?Q?THza2FaRW8zWR0SKIC6CUpd8XGJ2t5YnXTnhLXL6kTuv/KkQnI+qOKeGIDbv?=
 =?us-ascii?Q?pNIHTGDy2wzzY/6eWEEVAVPdGm140z6OFT8ThnnGCfCmMHQuRl682f9az3f8?=
 =?us-ascii?Q?SNCPbeklVqf2DSMFietpM3eoRSMQsvGJmrRxhz+JhIIVJ5T5wToVH52cqExZ?=
 =?us-ascii?Q?Kcd+j9VLz2GLtdETS+/5Fi/3T86FOA1eOiMCtVI456JHVDjzYupiUIDlowTL?=
 =?us-ascii?Q?NKB3CZbjMHGodvJ4uBa2W1lQjli5Z475acltCG3rVv2xnurtIXjYwiGcVYFr?=
 =?us-ascii?Q?xODgI2qeiXS6j21T9zqqE5uJZexiYurZZ4T8gaYg1yd3y4kwvFvI65RhBIa/?=
 =?us-ascii?Q?FqHyrja1EPaqMm5qQ6mXGTReUFKm2JCUbL8Zj3NI8nAShI7lqI67GJTmnv2d?=
 =?us-ascii?Q?U2o5oXaMnMw0uEtUlpH42mRbyGGD/mESPiS0lF6l6118ykwzs6jQstszjcNN?=
 =?us-ascii?Q?J+a7y0IjfQ9hpV59aScaScXEaJOG96aC/pzXuA0ecDip7hOZrZMmGvtMiEh6?=
 =?us-ascii?Q?aeaVQQGKPQ3X52iUqCeepRC4PVbuEkqsyp7vW3cnfAIxeluzxEJokxkwwq4E?=
 =?us-ascii?Q?xwWpXWMtoKmPD3nMgefz2LWIfKivcys=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f1176f-9bae-444c-6705-08ded0cb89f5
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:02:54.7629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJahUe2XEaiU/dVVLg1e3GSoHipAK2JpUpWHgKZcJEoVnwc+UTshMz7gfewc5AjZCXUC2vlPhHSljqDRYYy3oG6rLyXr8ASCtr1ZshFeg2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7627
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

Enable MTD command support for the N5X platform.
- Enable CONFIG_CMD_MTD to allow MTD operations from the U-Boot shell

This option aligns N5X configuration with other SoCFPGA platforms
that use the same MTD framework.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---

Changes in v3:
- Drop CONFIG_SPL_ALTERA_SDRAM: auto-selected by Kconfig for N5X, no
  explicit defconfig entry needed
- Fix CONFIG_CMD_MTD position: correctly placed between CONFIG_CMD_MMC
  and CONFIG_CMD_SPI per canonical savedefconfig ordering (was
  misplaced after CONFIG_CMD_WDT in v2)
- Rename commit from "enable CMD_MTD and SPL SDRAM support" to
  "enable CMD_MTD" to reflect actual change

 configs/socfpga_n5x_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 97c90656e7d..9159fa0c859 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -52,6 +52,7 @@ CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
-- 
2.43.7

