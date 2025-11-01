Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8958BCCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D91E83C46;
	Sat,  1 Nov 2025 01:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="WWNAlc7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2841A83BEF; Sat,  1 Nov 2025 01:45:37 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 653B783B4F
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFRrwVqzf5lJEmVzxTFPXLwMAwfZ0jHDAVDIbRdthn431V7hyDZFInfSks0ucRMbAQU9ckIw5PckL1RHNvugC0X0jPVBBW43HyNmZigUAUdsiPFZOsLs7C/LiunXeNbCEDfSMwMI4xS3pmmhstJfmaORsyqu8mxqsODdewEJuQmb2XT0sLVJ7qMrjIgurW0RqKkeuua9O+d2aa/Q1FWQKXeekFctyFUSlNWloxcnqaOU4Qdlk00zR80SvuoSWYHQt3JL9ZqiFhIlpIDGJPIJkn1AFanCtnrx3NImXLVlcxPRzWTwEUGSuOjTA/oXXIB36QuaRK+8UKv5aiECEAtqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QAB7bqEqetnya4YNLxB82U5K/m/yDs65nIKDztfEaM=;
 b=IRSENP9fn4gVuFfURRcO1LR1bagnMPUF7d0cbidTH7x32tzmT6QJOg3hZR+IFEV4vWlGixRGU6sDompsl02b7RqDTi+RE1sy5Om4eHaS5m306SBsmE6M2fowS1Kq8/Ja1as8TWj9LDkkfzOSJdKIePuGjynhogHQAo+bqS1xRkFceO1AK/nMdgioSqHH1vfKyaszQ8N2Wenf0QV72kHunkNyfyTwMIaWsG8Omdh2jFj+V7c12pwvO8T+MMqln9xZ9UhABx9LGLhK4OEO/XnrBROkZGS26FTugvtldaa+N2cviiGXb+m/ut9MOkKUrA4u5ED/fUCUotoPdFpZ6nRwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QAB7bqEqetnya4YNLxB82U5K/m/yDs65nIKDztfEaM=;
 b=WWNAlc7CGhkBD1pSKfLG7wc3ZKf+Tenov3PUq5PZN1q1Vs22PGaozOJl3mb1nowDv2d9O+9B4PhJ/4KQmIpVE2Z5NI4TBw5aetucrqhjflI7hH1HqFz2dk+0UeFw73LEKiFYL5c7xruXDvxZYsz8GrQbcR9Sn+5ZTiUIIZ6daQ0XPgsiWoYlMVbOYVgpPIndFCaTw/9CY7J/Ek4eELhxlehp+6P4P8oxG3hTKdU2XHpD7mAQ8wtLMRontshuiRyLGQICtr+yYt9jwcVPTB/IZtNfdARoTvmc+urwH3da2tMYjAwRiV6nQ7eMUf15gKjQCHnQJj2tb82JGKeW6usBJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 19/19] configs: airoha: en7523: enable spinand flashes support
Date: Sat,  1 Nov 2025 03:45:03 +0300
Message-ID: <20251101004503.2379529-20-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc35e95-8cfa-4579-9d29-08de18dff6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UKzOFveub4m42hJHKjiFYQrTZWhaixmQGuXabsVMbsoYpJ7W7FMYKXyIn773?=
 =?us-ascii?Q?uRxBrDmPyFcfdRc3OyJ3rkcVNAtnXftJ0icoZoaOanbLKsemngvb8EEhFG+x?=
 =?us-ascii?Q?PRVfNgtHE88z07bDKdjqI0k2FEUX/uRrLj260H7w/pXAO2/fThXs06uI3XJD?=
 =?us-ascii?Q?fMYTRkSX3eZqBW5OrFqbuS0eCru7mA0qNi+h44CVrfYjhCgi+zyQaJEhzlXq?=
 =?us-ascii?Q?Ry96SCsEVdiT+8OqzPfExtO4XrvYE5ZOrMsMv2PDKREkZ1OtRdFCiWvHZlBS?=
 =?us-ascii?Q?6KNMxCY7jHuDyJ4rj+AlTjWOrEbEKv/rsK6YuaysggqyZLAtFUXOw6vk5RmT?=
 =?us-ascii?Q?Ptk5tVp5OXateWmo9iDF5hx9Lrvlao8ScHbF3rluA9YzE3ubOeCKEnC4/Ju/?=
 =?us-ascii?Q?Z3acjQ2FNKBJprBroWRjsB8fvbOe/Y7nvGmjYGdMBCZWv2BXAMU0UkMFswCD?=
 =?us-ascii?Q?lBojIs2fnoMkABVAk9Q3G1V1n5nIX9SEu26prJtl9rY9GYy0XbCo7vecpr9K?=
 =?us-ascii?Q?d0kIDJecOEOVGmaQnc00QF1rX7+sFbSEGMBn+qEeGutKFfaAzMBZ9IJgF0/a?=
 =?us-ascii?Q?iPM/GKvbSXOlYJv/zg9WQHQ3fcAD54ncy6eiU/dQOIC0erjV1FjhAWaRgPLX?=
 =?us-ascii?Q?5OMPProVKhfFNkDu1p6pxBqucdGZa+NaX7OaZvzDvyhso9qkyqAzY6pGTjhk?=
 =?us-ascii?Q?WAEoX4+fZM1hhnR8AXKy3y9J6k+k+w86hCtMAk7IyZU/Uk99WCIJXEoDxAz0?=
 =?us-ascii?Q?ZJ6WZwgGakmfA9rZp9P+yPnDJpR8Ek58CK+1orDfhJtG7GhWjKRJmPP02Cyq?=
 =?us-ascii?Q?mWkom5D2hsc1id+2BIyXskqljNZr2jIozpsrLCtTDQnAByeQtdlRghem6zlb?=
 =?us-ascii?Q?2DwkkUbxBBSgST8ap/+kqI6jqYCCcQlnpYwr6pYtYjXWvwdDIx13g4cwaZNR?=
 =?us-ascii?Q?p5mewySjUQvPvj9jAAhI/XLyh84bnOaBd1QhB5XDr7E6JhsxeE6sywR32QC7?=
 =?us-ascii?Q?rrM9zp/5KkZlf2TliS7vOHF00c8a7bYNNYRg7tepwtIM8XSyiMymb/ltZKzu?=
 =?us-ascii?Q?/l674G5YEF7uXieAL3N0eDMKrSr/NMq+rM5PtMR3oRZy8AA1j1hOdPXEhiG/?=
 =?us-ascii?Q?xWzy8pPWjWZEWjnaJw+R8HftbRD0Ka/XenNbD4qS7CfxuC0Rr9Xt9sHbd9HD?=
 =?us-ascii?Q?FwOPs6qN4dVrIX+z4UwOLU+Tva1l7Ahynx609TJgCpzkvafOpXDJ5DRZ68wX?=
 =?us-ascii?Q?RSwwlhSQYTsAuwq5PrbTaitj6vDFju1OZ9panMXV/vKcvi6LDsbtGHc12RRi?=
 =?us-ascii?Q?kB1dpr3WYVBtwpWpWnsrGEbrddDDsu8bEJbcfce05R35Dh2ppyYMGKe4pxTW?=
 =?us-ascii?Q?cqcc+ZFroeDk9/7koN7hGw5gta+ZDDKHbHa57aR5NKWJOv9+puuKpJYjVs8V?=
 =?us-ascii?Q?XS99eD4536JDXjYGOg9HTlc66kXuhG7EAZd0D0PhywEUw8u2UcQcH2ZDzymv?=
 =?us-ascii?Q?aC1wD2uWPWLe857Ss+/y+xPyaro/EYMLIRYw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlzqmIDQPzggO4Pos7SDMsA7Bv9+fD/oeyabBvMt3Bb7NJ0Q+RfOwomQR4/N?=
 =?us-ascii?Q?eB2nhy75zbYtYZ3PZSrSlnDeqgttud3XiJj8lgWxKMoGqKQVK7Lzzybsf9UU?=
 =?us-ascii?Q?D2Cu9spbaKnJGa9GVqgXteAB8HPJoc7s8xwz53sEHOma31ZUCTW1VSu4W9Es?=
 =?us-ascii?Q?mKTBamhqCUGaukUsp0MhbXMv+hbuhEvc/q2ipj+/95Cz6uV2GhjZi+vJOlwn?=
 =?us-ascii?Q?YTDxW42jfNjhkJxQBQtO/18PH3LAWffbtNkDXlASjqJUk1FfLOGXJ6PUYZvT?=
 =?us-ascii?Q?jdLJn8FtcooWBHFcO4OpYSskSKYdDAsyxHg38gX3vQtKFqK2cJ8RDOg0Kjtk?=
 =?us-ascii?Q?V8xljs3zbqE+kb0fppIn/oqcv1j0LFRsJQAUdQW4iAwkw9g2BGMosz2TBc1O?=
 =?us-ascii?Q?DwO7O6zWYvfg7idcIC8mbwV8kD76F9qNe98qGPkj88ALVau2YwjARkHFDnnI?=
 =?us-ascii?Q?JEyEI8NaRmYvZ2DbTvwGphXTY6GyqWxhRS30CAHCjud0udoHm0nWQFbYOg85?=
 =?us-ascii?Q?7T690gf1cY2NR6Lgd4ZLG7aC7ViQcsdumWsr+2wfXcja5ByzpLnxLe8vFy2h?=
 =?us-ascii?Q?u2T7/oFKwXmGB9J9BGiKl+OYmQf6JnrL0P2/f8F7ZP155BxYrja6H456qI93?=
 =?us-ascii?Q?Wl/EUi57GzBWBiiBGpgBXl2Mc+5DNMEP/NYV88xrLG1XAFFGkvYTkGJ4vUoP?=
 =?us-ascii?Q?C0DLRSRLG9x57/rtY6LTd6PLCTwjTnUglgw2g0gmwlPppSxk55PUgiRZSirK?=
 =?us-ascii?Q?4wAf2XjOuDZfcMkH76rKEYmuSR8QtogEhIvPIH3s9tOZFq57Mg8a5aEflzBh?=
 =?us-ascii?Q?Ny8RA+z86aRyCRtJjjJ8nJmrw85onr+yBQf0JHjIKpHnICkJV2TXfU9s21ru?=
 =?us-ascii?Q?HTt95oCurNOExa//kHI5/u+F5uPxN9EwJrUi4JjTU12/Z65FsquIVrPwC+3r?=
 =?us-ascii?Q?F56SlBzQol1BhG7DlGbo1m/Xv56ZKmkmeJvirUCMAQD487eLnYSY1bD47tNe?=
 =?us-ascii?Q?/ZCYzfbgsMql6gG9+bzwynf3j2DbxVQSLYEOsyDr+6iwocINABhBNNmmUwdC?=
 =?us-ascii?Q?+zKyxeILQewwXUX+6acgbKx0cx8r1UNg3W+r2dOBq0U8Zt3U2rKn86oIEugT?=
 =?us-ascii?Q?zT5TNA29tDtp52lBROEFPX8Lft7IudvZUh1Hq4tkogOO7e9p1GZ5yKjqODV9?=
 =?us-ascii?Q?aoYIteGHpN2H5SBOJrivdq4OKM47n51EgmsOrF4lrwDevhBtC+6Cr9HXQbVv?=
 =?us-ascii?Q?p4HFVM4BAKjZODKk3fh4cmpRid1Qf/oDYFP3rkq6AYUX3y+r7DWJBiWX8jap?=
 =?us-ascii?Q?0gH1WHpo97lb+7zzJAOvetYbs7Df3DoMgEXf+dwKjTI3TBamgQrmqq6B7QIt?=
 =?us-ascii?Q?QL/y2tWe2wHMWS8M4/nLKi/McyR8yXBtm8ydBYRauXioN0iPlQi1IvL7dBTW?=
 =?us-ascii?Q?tOYfubWTTP1Bx8+cH6gHXekY4hLmjv1oFiRro2z8SW4rLDqxq9AWTEDU3ctN?=
 =?us-ascii?Q?8V5nQOgcr/v1M6qzLa+G3r7tbhusdE+3BR8DakGYfT9i0k9583gbz/D2JHGX?=
 =?us-ascii?Q?cdvN23b2bAKT6ocC8WEvBmiiCr3TNW2rnSYifaC3DgCYVxYO2djs33xH98Wb?=
 =?us-ascii?Q?l+RQYamc/YG39MyZt28HWzg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc35e95-8cfa-4579-9d29-08de18dff6c0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:33.1360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ia0SMyPGxSU0zz1i7eOMswfIZ8hmo5maZ8FbHr/P7twHwoFJfGpd000oEBlPjq1XjmZWp3NjD1/KjeX+dsmZO2xKg/+9cLwRbrkPNnTWtmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7586
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

This patch enable spinand flashes support for en7523 based boards

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/en7523_evb_defconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index 11b7e85f731..76e829a8e99 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -5,6 +5,9 @@ CONFIG_TARGET_EN7523=y
 CONFIG_TEXT_BASE=0x81E00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_MTD_DEV="spi-nand0"
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x7c000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="airoha/en7523-evb"
 CONFIG_SYS_LOAD_ADDR=0x81800000
@@ -36,8 +39,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_NOWHERE=y
-# CONFIG_ENV_IS_IN_MTD is not set
+CONFIG_ENV_IS_IN_MTD=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
@@ -51,6 +53,7 @@ CONFIG_LED_GPIO=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
@@ -58,4 +61,7 @@ CONFIG_PINCONF=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_AIROHA_SNFI_SPI=y
 CONFIG_SHA512=y
-- 
2.51.0

