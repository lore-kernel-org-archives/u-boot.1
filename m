Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930ACCD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 05:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E5DC8493E;
	Tue, 16 Jun 2026 07:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NuzxeBCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86EF98494B; Tue, 16 Jun 2026 07:31:40 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A62D3846CF
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy7lcA0TxzX8M7o0urKjoH1xQREx4O8uIh0r9gl2m2m2CVgj3nMovvbvesL2/g6DGpB7bDzJxXJXhmUWSXixbiD/aUjjYZZpZyLWP2ogzGq2Zhze2Eui9D7YtVNlyIT40/moBG+l/kGVZrctb2IKUkNbkwaG/cBWX5QCrzhv+22GVLVfk634eKriCULgD8bBMdFGGzSHPeYVY8RnchKGR1EawiDjL9yqVpIQWzQfOs/t1Py5ohtWyWW2B4ccnnSASoHoHEySs1Gl57090KM/10u9nJcVPUPYXV1MN5zReTsj9aeFyevLOpB2H+gNRhIj6aKfyUpioiyiCuGgPmSqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=NUAnLOVibJ6tDkp9ne/eTl+DuoRt+4HsRdps/NhHMSWLWjp4UXlYCYckk+ZdtNMUR3+ffcG+u/AakmmS5xNqW/oVux/tfgVJDL1VIVv4TSTihZ9Kd4RrQjWcG/mO67xV6JmKzgfKvyoJk39H+iTzSFjJ+a1+PsKwz0+fpfE20QIew5vKTUZlflqhIDSu4/TBKD9y1OOjP2GnujCku3hiCHUiCHrY8N91AVoDh5QeqnKO4/lwYylZjGTUgx11vf1EvqtEgiNXEoN4NF5FgGrWPXkbIW04JIi0dNQ2VmVLtH3p9m9sLicjl0P2nzS6MpQkupp0V1Q6u2SUmd8/2BL4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=NuzxeBCjYHUqsSzguqMCu71rBKORFebOiaDarVe8oeTN7+9V98UwObkwOE8K4xmyVaytb1+fWXMmNmczBCxGTJESX3LlFazHkpAGipngMn3cRGd6NXNISQV6OdyWgRRep7TkK3hhgynnM9SOi+89g9HerF572EP3EmxoRrZe4X7me9vHZm3XIXfwxsDLR6AWE9qPvDNp6oQNGM256A5iOdVC7iyDNJhM/ofo2/dwGe956bQtkyNTooosTSt0+TrPF/HqGaGH6oxcs2ExSdLgXaBx7YoCQ69i7souehmGomEShrcxD7/tjtOuj1pakQOCoBddCuddKR7kAxcyurH/KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU2PR08MB10160.eurprd08.prod.outlook.com (2603:10a6:10:496::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 05:31:36 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:31:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v12 11/12] configs: airoha: en7523: enable pinctrl/gpio support
Date: Tue, 16 Jun 2026 08:31:05 +0300
Message-ID: <20260616053106.2623475-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU2PR08MB10160:EE_
X-MS-Office365-Filtering-Correlation-Id: 0854656c-91ae-42a8-7bf7-08decb688876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|7416014|52116014|22082099003|18002099003|38350700014|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3qFX+FTwcLyInIHRhXSbLiY/B9fukui1nQ3JA2jEbMwVNcb+3lLfki+ZavqsAU8rAXuODpkTNQr4m4viCb7L/rPdKCnQiofbKylmRB3LDwAn/vmFgfevchthPxgdN6gVIEMn1sGq3h2viarFJg9wdIFZoJAncH3toq+ZG7pT6Sr+R1NCmto6sVC66lORtQJiC6JIlyfzFRLa8smH9BOH3usNFJBn/hEWAB6UW7JwFBKzHk3NLiJpAzPuysHrY2i1SoWizC+C6oG0RlTbq7zab1lV71MJRhrfPqgCYAf4eHWgltylW7M343IiFe1MjsN17JvUEM9nahV6RX+KlrsfuA/rBrdsyRCXTKsAO7dUBtr1ANqxTImyXoaAXcwsOMZyOGeUtd0m+7JOYUFhZEAUYkaXWn2/zQ3fDTV+o20U8oPADzASA3ou18oxpXtgAmV+43Ji3lYwRIV0IbT2PQgTtIaKT1NjA1kGcbss23gsMJVzF65UDmETkdZgrg0Uedzpvf0Etp9nrzcRJvXMQ4qy0QnCi/5hOd6d3roj/d4MeGRgxHtUdzN5txPNVn/aTbjJDzlUCDVWaZar2NQuxsogGioURvWcv//1LTeOCL3c3lLoROCCD4AUEWh9GScRFbwh6eHP5iw9f9FRvuTYYNMcik9Pug+EGGRrtXCEiPUMznByqz75UkrgiiT1HLxzskKke4q/IZfcEyAJewzp6SGE4i/aVc7/M2G88dA+o4O2c9zRDCofT6dBxcx1G7JCH55NgBy7elckNMwH3I2zn6X1Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(52116014)(22082099003)(18002099003)(38350700014)(921020)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D/nYSHBIH47q1OKHTLdUHXtdLyRdDhX5qjfa+xiRZd5wtJukhS73gfYZPWCK?=
 =?us-ascii?Q?eSEWfxqy1lDX4czI35OclONQnFs1luqKbmPGyforrRWsTHntGO3kXO7C0V0G?=
 =?us-ascii?Q?NKgMsvQFRx5QnGUN0/XF36CHvNg2V+sbtp4BUMvL/yVstPuYHFfGqSanoIJF?=
 =?us-ascii?Q?P5xnjEioMOA+SGczwsNFltzw2zTRIzQhif7QzvNoNpjHqp1rFm03dgHsqD1I?=
 =?us-ascii?Q?tGOgBKWixVBi0D9LbHs+nMVUrNiBp+AoENlxkWBL/HeCMR74DSroqeiyZyWi?=
 =?us-ascii?Q?+q7lHs1Rz/5zK+fFeKfJnQhjcy2e+zH+QkCz8mTzwXgJUQv4zGY2FJhPJ+VX?=
 =?us-ascii?Q?uJPVjLmMF3+N+gBK59topzJ20zGGmgeOg5iZN/yKOC8PaVZjvfO4kSkcKw0r?=
 =?us-ascii?Q?Z8IRwl/Ee9mSgEm6YyfU7rD79jn3QL0nrDUFw3GgOIurpKQ9xb0TAHxtXN/O?=
 =?us-ascii?Q?WywEe9nW62soZfXxER/Ok5ABOd+sZnDAFKOHDAL3Xy4BFR/4IesymER7t+nH?=
 =?us-ascii?Q?nlwjubRsnLss9ntfLEIhxXCCdC/iRLJderm5xf+00brclYQ3DSsJoY6qYDT9?=
 =?us-ascii?Q?RWDXhHMB+ZH3cmG2M/Z8piMbSq8/qZd5UzfDFwDxIKaR8dyjR+dvCvrvW5Gb?=
 =?us-ascii?Q?z04tHpv5c+aMG/OORPts+ehoWBL9LT2OyWQESwVyqG6gyZPK5KXE033/YJLr?=
 =?us-ascii?Q?6IWWb27xXUCcJikMmKbDBeVNBmaetmEUwQDG6lXUSGT0YcsoLzvIn8VdXXTB?=
 =?us-ascii?Q?pkJ1j6XE09sELJQEToHW2UP6Uv1lDj+m2RxqATsJ/kbl5LuHqrakvvPxtFCv?=
 =?us-ascii?Q?3RbLEYobDH8bjXgYdmM4palxmhN0xCBcxw9uR4+m0RPxBbKCDEL5bteZtWsF?=
 =?us-ascii?Q?2fnMj0mHK43MmK9G82zDnZGjxaw63mlLwjGFZJUKHtK7EMLnbSWyACucOV3B?=
 =?us-ascii?Q?Ebc4dyQAsWlarLd83PpumFde+lGg5YtbyDc5Twlq+53f1rTCvbW6xRQQPtl0?=
 =?us-ascii?Q?ppZCF5JlwbV8BBfoSIrB0bcJMojG4e4kylFbohaqVPa3BJ3EYuxcoK8WifcI?=
 =?us-ascii?Q?rnAA6OVcKNsRPcA1hQOQkvlwL7eKoDp/eFJeLbtSJDQNdHe+XJzpphMJ9HMS?=
 =?us-ascii?Q?If0AjNPLP64fvTEQZdCzsgqPcPU02+yzE5ZGZ0dQwsxNGFHx85t0bfk/hUp0?=
 =?us-ascii?Q?r3tyY0JcwqeqSaE7ju8e6Do3prog6/1Um051uKW9c+Uz3ncxzdSlXAYK4kz6?=
 =?us-ascii?Q?QhtKVh3d4XoiXkXfj2Lt61k4yK86qn2cdUGgrTL6YC15elkAKbM8nQ5xPHL8?=
 =?us-ascii?Q?7Q7HVZLCXz9rxPIS7+RwdVG3FVeX401eoIKztRR5DWLS6QvQvDfaDn/c/Hc9?=
 =?us-ascii?Q?RlacdewJO76GDaKsVebNMvKvQEM74bX9eXwCFvmTnGDVDm+j4A1KUtgMKiPR?=
 =?us-ascii?Q?t5lC3rwVh0J5VHY4/pny6PYBoWg7Soz1sHrxYBc9jLs8h16v9zsga0zQrDcR?=
 =?us-ascii?Q?CyRa4I38Y7Ce7NoSTOq/YPTfTSGH0pP0oYYFfpnrynbmpP8Mlhqf8rp06Jzz?=
 =?us-ascii?Q?npVQKzwYU7V2ibRYN75oatkC3GoNQqeS01bc1hvi4OydJ7X8iGtAtOg7nmtn?=
 =?us-ascii?Q?t8c8Dnb3jnIzxc6JGLfsr6gBa+jO5m0pApjrzri89rfQkQ1UwArEAZT/AUa7?=
 =?us-ascii?Q?6WyYXSkr1Gouj7lXC8FPTT7gaAxuSek8S9ELPJA2TVvAUQd9vJecNpk269y5?=
 =?us-ascii?Q?7LwDTJZW5QlZDgwiusrRgcjSctiOTHU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0854656c-91ae-42a8-7bf7-08decb688876
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:31:36.1630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uk2BDHFyTiEB5wNCkMcS8LYz/aW+W7uVM88mdXxGsQmRkcJhoTFu6JoBDcW4JAgT20tQGkXQpxwaLyfyt4rbkUK/UDDmU5x9UYZerjDibwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10160
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

This enables EN7523 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 configs/en7523_evb_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index d3137a0ae44..8b1f3c71e9b 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -54,7 +54,7 @@ CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_EN7523=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.53.0

