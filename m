Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D523EDEC04
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC1AF83FC0;
	Wed,  4 Mar 2026 05:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AgjG4gDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD5883F75; Wed,  4 Mar 2026 04:53:26 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9138883E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x59iN6S68HbPZvvN2hu45m/q8JReVjeguULIyMiTfj6h8evBfpz20XA+50aN05tvs98VhJ80Dwy+Nql/kyGfI5cgdkSLvDOnD8p44r8QXSWJZCBBifSmSaAYjrHuj8kOyCqMKcOWU9zqErsceCo87Z/zbbdDrTazDkuLgfBtibb/RkvjIOWCiWgaBOqByEImJBmxFBhjyEDj7rt6ILPm1qbFiV19OfPghkCsMBlMEm1K2uTflss/XyDisifA2Nwpy/TtW+l6WDyBa9Evp5Xrn7inRGDArJOtNDRXjoerBhwaQW3rPbZOV0aq3H9pSOuD5gCODZnctgluMFWzy8EhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjEs6IvzS6flNGozdkNqAkO9SLGzt9fW7IiJNJVU97U=;
 b=UeCUlP/9gJIE0O4W70voWly9WtNDvONo8TwSnfPXy2p/dbNQc4znn3kF/dSRBNZE8hADJ56qOB/COhvh56Z6nqdfwmQtWUIwAzcMkoZ3CfresZdUTygW6VzSzUTx++6hn4B8NNn0VmFDrN12NwSZDAY/M1ouCp6+eUXDh/YcffEfswbv9q9fuuv6ZJy0dGHeNZeO1ZnaZsJwovTID2EwoGu95E80uDYVo5mPgQAjI1Q6FmquVX/+fAYHyEd1Gl+bZxaX+ozw9nWjuMl+7l63PelK/donJBBU2PSqesbbau2ZJYHAl4lbH4BTBbbYbv2ix4KCJBGCua67dgRk0KHJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjEs6IvzS6flNGozdkNqAkO9SLGzt9fW7IiJNJVU97U=;
 b=AgjG4gDX0+5SCNxGt4FiHLO/hqP0Pd/aVpEWIhgVmOBjAf7z9RIMzDWQCXoauS+BvF33A6NmR5UJ1oUW4vETeP7ozCSysesfboqJZOcV87KDA5A2DaUs5kvHObXaAw4O3WMeglY6xsM3cgfa7QriwgpF+DC8aI+mWNwAuPPiw4R0rcphdUDTvuXxDRrdaAko0pBZ8Te5q2VvXmdIv7HREUHYjjcsPeE0tS+IUBExCXiqeDZeywdbHftt0fnCGWtieaaKajHH3AuW7bLkqyGmWnmcfmkpUQpSvd1xifT5sA7hRH0/wJhdMwe5UzZyJU+rtGPX5rNjB5TZBtsfQWh9lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY1PR03MB7286.namprd03.prod.outlook.com (2603:10b6:a03:524::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:53:19 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:53:19 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Chin-Liang See <clsee@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH] configs: socfpga: arria10: Disable CONFIG_USE_TINY_PRINTF
Date: Wed,  4 Mar 2026 11:53:07 +0800
Message-ID: <20260304035307.16125-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY1PR03MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 60847a9b-1fe7-4da6-2d5c-08de79a19287
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: ZXyhB0JVt/GpXZR/prrQGfboHZ3JyjXrmNxscuMYSPZj6WKZZIJi+ZAvjUcNyrSWMV7eqYxyH5f4k0Zl5loCXujKBTfXTv6JG74XHAgLD0oBujtK4Dsa7sMWAth3zwnBwTjtyrvpR3TkVp41iXEEx1rgwSOzJU647Ldl6VfAdQuY79G0XlLYNz4caTaKtYewSTAFMZASly+7htw2MTDQ6HNrFtH7G9xpcNfaJPt6r1gsagLBwqcm+NLHsk0jeswt+TzMlNfm1xUrQnHvOI9lkhdJv0mmX2QX43YkQZY9DtpuciClRE2vFQp4W4Yj95/Dqb5hV7YL9PP/8SA72wN+dh+ZyFrZqBs+/zFwOxEKPRwdMQLSdd1ETEKJ0OJ5FzVIVIHVjhteD24IbnQdjDuOEbwQDkUMwnZa8t2BNk5CZg+YUMeO0AzVlzIC1O6N/UCjndMqSlarzn7BdPeXg13e2hQTHSBfs/26Opv6vJe+d5y5ucW/G1frvoocAe8TXPfgHn3cxmb0BeIqHm5uSZzM8wqcLFQ9txKoCs04CCEhkj1Zaw+xYRQtFeM5ezpZ0GyWTRN+UO6hxiwMJFLRZP50Wrxbbtyt0O+yU/pWaEAqrjJRxskar5NDlMY27pf0Ui3ad3BO29h9jTBls2Hies0h1fawW1fRrF8SJHSIAOr5KDmEdgXxXEElBObM1IX2k92OBh9RJ2bKTd8at16xVgMTO5B5wjGdosjKQ20U11uIVSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OcALeKsDbINkW57/3Pv3XJph5Ektg+pQWBs7ADBubIMhonx+HE80l+vI8RrK?=
 =?us-ascii?Q?18e7mg9EObnnZA7tgBDNd1v+wWLEeS8YXcqVXw+MDeoaS21+ftXEGtXxR5XX?=
 =?us-ascii?Q?wHEYD1hIrmIUTbOu90uU4G+dWldnqeYDCvwDCVMrLYYK/hhD1+Obi3LAyT2O?=
 =?us-ascii?Q?FEfmG8IgQ18oRYLoAQuLyDCCYufJF3d27ASMNDBq90fN8/4ah80FZcIKtjIk?=
 =?us-ascii?Q?1OXN5lAvZ4bu8bLkaaqIEx+NPdekyT20XGrQW3WiDFwIguPKzO4d9XJBvjnM?=
 =?us-ascii?Q?M8dVrJ+c74luIgAbGkfq1wfKdzF8cKmAJx6aAiX81DWXPiVNx8xrVR2LZqnc?=
 =?us-ascii?Q?6+NUOZBZe8vG6JLITngHtc1qr/v5aaV6ekX02tcK9NVtJD9KpbOQn1C8QDSd?=
 =?us-ascii?Q?lRdVX0OBgYGfsNFLilID+vdhusHo/T0EY0anp/hrZZLsh6vQ0h2lnBFluNuX?=
 =?us-ascii?Q?BajsC2GKsgrNNrV5L+7JOBvpqTjO6MCh/jgxOVcY5O8cU8eDg8lGRBHLTCNG?=
 =?us-ascii?Q?hfZNOYHZH8a87C8VD/eJOllMXfTmJLGm7uP1b50RuB+ziUuK8Txeyd88HaXG?=
 =?us-ascii?Q?6dkJaYh1PTFL+zu9B3tFFJi2UCu4bIvOKuqaW80fE9ZCYONIkVdLKmZ03I/b?=
 =?us-ascii?Q?tvi5TWij8KGNJcMd6q5m4GthvEEljEueGM1wt40Wv0apU9wSoJicsZYUv7ck?=
 =?us-ascii?Q?XXAozrk7jiortDmPhgsU5f2mj+IEksAkaeO4gwqExFsabGbLew6WFCvCNmiD?=
 =?us-ascii?Q?MF5Rn2jZMujIIpDiJAw3ELmeKhrv6hde+zFHY9f/S7NspTc+6Q7GhkjO+ojs?=
 =?us-ascii?Q?gsPiiE4IVm7ZZdR8IfQYPlpj0mnhNpZVpBv/VdPSTBh/yOkMJKMHmUTX1+fP?=
 =?us-ascii?Q?msZVGLT4gap18AaR1O4WuF7Kp5QYw8DN0SuOxKNS0gM5qDgkJB7awIj2W32M?=
 =?us-ascii?Q?ug5dudXkB0JQBCDorW1VtdI0S3aCZJ69FysBBkMDf6twCd961ZrdQ1GPdZaK?=
 =?us-ascii?Q?ZS5qoCRRcPRKQOelVWs/2kPKaaze1ALloyn5tvx7OhhWSMSHXyiYyOvR4wUk?=
 =?us-ascii?Q?OfexlN4DlKrmHibCdXVuH5YGKjntJo56ab+aWwvNreOt8QVWashiSPUR+/Pt?=
 =?us-ascii?Q?9n9uhDdfRaA/G2wZ2x1eCdz2gYEmd3GiQNMJYg+0dxO0dRRwrT1aISer13d2?=
 =?us-ascii?Q?+Izv6geUbBZdVpQNeR55NgoibT6NQQhMIezsG+js/HhEaDLILs5Bos5Uoscv?=
 =?us-ascii?Q?p8yXNqRKFy+NRYYCxZ6Yx0flrLuIlz2kV2vbflGVzfLd8P3ExfP/MMvA+Ww/?=
 =?us-ascii?Q?C79qm/ZuPB/fQO4iV1hZpCRMDxg+zFXw7qGQWgLSXqb92KP3IqPyANDSJJ8I?=
 =?us-ascii?Q?slsjZWtE78zJy+6WUIEA822p1mJZxcr8TU2fxMgzD5t+9R5utl20/5jhtJGR?=
 =?us-ascii?Q?UOCRGw09fXbiC56aJXgbylSP4iXp72zzN8hCWxntZTD1XATAr9bsjnFoeszf?=
 =?us-ascii?Q?WuTCcYEsjeX6Si5c6UvS0LWxiTrBJaVwiYAZF2dg9t/xqkp665P7sebkCkHq?=
 =?us-ascii?Q?r/Eypb3I8GrpPzmSUKMsctJOh9HrL86SnV8Qjd+c9XMoQjvKEzjOm6GH8IBm?=
 =?us-ascii?Q?Nxm2CRyKCnW2ucD/ymfOsAeZtMqE+gWh9S9H6amc7SPn+pHj8EnvtwcpAJWV?=
 =?us-ascii?Q?pT4bOHdEU1BqVLNaGh20h/KiJST4YWzk7eQjV+aj+L1w27zRGLJKLwAzVqK+?=
 =?us-ascii?Q?ynwOyrNpS1DdQeUS5Ldr66sfLjeMorg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60847a9b-1fe7-4da6-2d5c-08de79a19287
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:53:19.1541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yieYjX4v9aeCLcxHrV2AqohfQxsw3MEZjgrUWGeUavSAYJ6JdibAE5VAoYHCzggQjniXgPUQPdzzp6a/DnScOHjAbcmwu7pIB36uZsoZjBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7286
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

CONFIG_USE_TINY_PRINTF is enabled by default, disable it.
Arria 10 has 256KB of onchip ram and it is enough to support full printf.
Full printf allows us to have more complex format printing, example %ll.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/Kconfig     | 1 -
 configs/socfpga_arria10_defconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..ba01ec08be2 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -101,7 +101,6 @@ config TARGET_SOCFPGA_ARRIA10
 	select SPL_SYSCON if SPL
 	select ETH_DESIGNWARE_SOCFPGA
 	imply FPGA_SOCFPGA
-	imply SPL_USE_TINY_PRINTF
 
 config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
 	bool "Always reprogram Arria 10 FPGA"
diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index b32f40ae408..d5feabe5ce0 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -69,3 +69,4 @@ CONFIG_USB=y
 CONFIG_USB_DWC2=y
 # CONFIG_SPL_WDT is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+# CONFIG_USE_TINY_PRINTF is not set
-- 
2.43.7

