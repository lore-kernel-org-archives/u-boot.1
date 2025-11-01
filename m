Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1A9CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE62983BAD;
	Sat,  1 Nov 2025 01:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="T4a9bU9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED3583B8A; Sat,  1 Nov 2025 01:45:24 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A24C83B5D
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWt+CFgccKfoIZrzOloYVx+tHRXH9QF7iEFhsi58N3Ta1tE7IkHvT5Z1C/rs60QGghsEyyTC3VW21ib7IVcj2KIQjDI4l1Q+LhKCTAjtPNVBci7AqTAtAry4zshdKCX1vYDNBuQhliqSnPF1DolAMUm8s8G54RicHbQKU4oi9PfMXMHj+w4xH8fChIn53ZXiaqzAFq4iF0bu5MU9rGdA9COJLmjZynFc4HwDo0IPpRP5efhaVDHPXQyS4JeTW2E6ufrfZ8HDIKaq9GqH/ajStypWAd+rvLnE3UHTAj0EQAqbTDy89i5GZB9NMR5qkv+mSAvRZv+Z8Kdgu84pjnDC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDDFcoHNJXp1pckZGH25k9NP5p8jZgdPUKMjTM3NQvI=;
 b=kMuicRfkWuxiAkaZLbA4yJOBbxGFWw4gvg9aUdVbG6jJRS//3BGrtpHSVG4zt+er2oUusYzm3WmHWh+hrDfzNMoW7jRrUEU3CQ/R6ScVMegU4AVvk0YYDPADouM5u8fO2ihM0XhMe6v/uQwH0mFH4WK85nh3IJptJeVXvBVvLyNcL45sCbMW2PNEAvRLnM/l62grs+/obsq4Q2lzAC/KWTR0huYmTdszSTO7MDuxYkZ/6DG1XNSXpCwZ8jg0dWGsjCBtGSS20IffEg4d23ogjghz28L93kOGZ8b34P3g9YDO+PKFY4Pm9nmNo6ryC4yVZyufUQ5Hg8wKtBnK4fIAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDDFcoHNJXp1pckZGH25k9NP5p8jZgdPUKMjTM3NQvI=;
 b=T4a9bU9KLFvcZ7yYSQwAPW+GhP/WgyrMeclGG43SS87Xfq4gpCD6jDg+MzVC/sUW6pQ+xF5FJv5v9+bvcJ3AY2ComuJ/QjOXyDZj/dlu9HFyvisw8bJAqTuDav8rsKsFtU/vqavT2lQRMZZjEALP4glIMP3dcVOawmTBpABLM6G9SF6nVsPd0w+8muYvTtOeGOIYOc7OWCjvmaKmoHibvzxebV/VGzakVU4Tx58m5fhvxxsVE4oc98GofQ0SvHKzNMWTEza2VDFt+tmIebMm2K+utSrbtsb5JSUjqGZsRNhNUwMNbZB3gU7yWhGuELqLn0+A85+tfuXm5NzKN0KqgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 07/19] configs: airoha: en7523: enable clk support
Date: Sat,  1 Nov 2025 03:44:51 +0300
Message-ID: <20251101004503.2379529-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6e6939-5f8a-4c3b-67d7-08de18dfeed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i8vuCm0ACrxdzs6RXIQSD71CWjXI3aFs8emZ7Z+b1sbfAAINtzYJssPG5uTM?=
 =?us-ascii?Q?89Bz5m7PLWH+isvaYz/OBKjQjeQ4O3sjRe+ZC+EkQsjUZImo294UTd39aP/q?=
 =?us-ascii?Q?dxQ+ryS/mt1rpl/mh9SpQH7REeFkAFHL7chi/SUZy6ZP7WdBnHb3sGDpmixh?=
 =?us-ascii?Q?uIYxp2y96aSPdkgiE81l5yo0/Yry8WI/94M9auFfvcVUGogy5l7A0Kv2xAei?=
 =?us-ascii?Q?ZCkeLfSMxL/3dghgp2jdAsI29OSKU2XZbZ07zcK/qL1OrfbfZglbt9hIwerW?=
 =?us-ascii?Q?E9UfvsgJrG3PBFG+u3AkED2iSNtYF2Lk98jmYIEDAu/hdNAaFSb8RnWSzfhd?=
 =?us-ascii?Q?Fvf8FYZco6lnn5sp0YlZH3ihsYhLCSvcmeBqOYKpluTms2rP/5ST8IhR1IQG?=
 =?us-ascii?Q?Y9qLN4cEPw+0hT+VmnMbc0hZqSqP5WBxnYmSA9GIM08DFoCwatXRolqMevTI?=
 =?us-ascii?Q?F4I4JsUTDrSoaMvPL3BWFcw9E4KtPIHU72IoTCimVFAbiH7Dq0Ce5sCizPfc?=
 =?us-ascii?Q?lqmUq75rcf15mpRnkwVbIpNyJ0FVcSX38AmGcTCGJs4HQoLkfEPxe9A8BoIy?=
 =?us-ascii?Q?YRQRB+uWHZ9ts2xUxnK6+x1x0SVimr6WBWcNNbGDXUE5u0X+xOXfA9KzsGpi?=
 =?us-ascii?Q?l000RToZzwmD1ZJo1/l5WkGw9h2skMInoTrFdMzX6QTIDh9Bg49ll6/q1/d9?=
 =?us-ascii?Q?JgERPcKiZaU/Lj9Olzh1Svz0yUQFkpwo43pOAVHPh85EdYAHGjpR80EOL6fR?=
 =?us-ascii?Q?+tm86eGYZAJ6JmOWGZOsm+hacdOfm+4rgubuVHBCQrMuiTHB0HHu5WE1ZLED?=
 =?us-ascii?Q?/tCIMDoDLeODAZ5mIDO+zi49Hsy2nITHsHxIxS93TM2Gf43Wrs+kKhsW783z?=
 =?us-ascii?Q?Rg1jlWQF0JD0WbDX2NbMrjBAtmH6f3hXGz7gykZVlMNg/77jDPYXbrwFi7f7?=
 =?us-ascii?Q?/TOsA5IqWwhzjMD8QF2BE0oGESLb9IAQpapP2CrPaWZCsz2k0xJ+Pw+jsdso?=
 =?us-ascii?Q?zu1E+1IX6JMNvgk8xwl/E9NOba0OoZrxEVOWj92WbbJAtW16sFsVZasEAJqI?=
 =?us-ascii?Q?2AgEwaBKwQ8+QsAGQOce+EbhgKYbboWeyzv1bTj5oLJvrLYd/2MPrbg0EVHw?=
 =?us-ascii?Q?UsBf7vY5busTBnQIyREzXykVYMtl8xSWaGcGDOsiDf2IzKU3Lhep9Z5c30mi?=
 =?us-ascii?Q?MNiPV8g20F/ELNd+pXddKn4rNBZSVR7rQxTDDZJLd5q79/Q4TcMh/W2v5O7Y?=
 =?us-ascii?Q?VhsMSqpyRD8+Ar/E4QxkG/CZt2dmMi9IDscIa3JsTK8XSUshy0wi0rdXGD2x?=
 =?us-ascii?Q?8Rl3phGjiO8qV+GeL8qrcV2ZI+SEF6+W+s5uQGSjH358SgPUur4kdtmQ6L8d?=
 =?us-ascii?Q?A0YPKaoecC401xyhhVGNkIfaH0du/sbaQYsNrXp2uNgPCBoRwwMIvT6Rrvvv?=
 =?us-ascii?Q?sMf//ux4LtemZxRMECEGs1Pvf2Bu5l8AK0dRJ5LQVBUJlPIjFoDOalsq+GNZ?=
 =?us-ascii?Q?DdmMJywOtG1Cq8xBenBKrLIHdiiq9KORKwam?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eHwasflWk1UMRaZkEWe/sy9SwN29VpNqD1plytYeKP4Zf9/GPV87Pruatoh1?=
 =?us-ascii?Q?ZAsubFGreE/y0DkcG69xt4x1QWqN2XniohIc9R7Ui0gBOkl98l9xnd4w+d33?=
 =?us-ascii?Q?sXDp1GlhaXJv7ZsxYwgnz91oW4eio6hh0nLIHfo+38XZ07TM/HDxYzZpkXQs?=
 =?us-ascii?Q?84Zj7X4/Te4st8vrpjEHnOnUmPpckM0tLwNoE+DJVZIv5KdCuRj4XLxzDMm0?=
 =?us-ascii?Q?SkWzwxXVVbklcFKAc0zjavwHyi1vwbQ4Ma/hR+rcAE8r9KsIW9nw+teEerSZ?=
 =?us-ascii?Q?xRkcX/gbgDvAOxP6GwVCwOL+VajJrr/mTskYYiz+lLkTVualPEqDNs6PMMQb?=
 =?us-ascii?Q?x0KA8d+JU+DhlGWiAwotAa87Wcl6Wm07+qzCFNeheP4CWdMTRVeU39hU8s87?=
 =?us-ascii?Q?/MElxINDOegjFHAZmVnlW1ZNV5wwTvSdgEeaugHt8n+y6Z13U7y4oE42gb16?=
 =?us-ascii?Q?Mmh9S52tpARtui9vznrMEXBXqRITVaPBBgq9iLfBBJLqrsIaysY7da2cCA5r?=
 =?us-ascii?Q?f8JuCO5FG9s4UpOZjrWUIXFXyEOQ2RKEqubyxCAnJpSGuMVTRmxn/Jzcq4ld?=
 =?us-ascii?Q?GrSuQRAeJ8ZWKNJS8wW+pFNrwZjxm/xE1IBn7ze6+EsqtJ91B3ODHyrQdsg2?=
 =?us-ascii?Q?9dO/SsPvX4TaicF73AByhSyJgenA34kSF3NYqJp0HuWTBfNajyL+8zJrPUBc?=
 =?us-ascii?Q?uRuOKuF6crcyBOY/yhX+ZsM6O6NyR63EC/Hm9YVbDOYMdWH+qKAWm5MO14RT?=
 =?us-ascii?Q?qK7ZeOnb/8rZYuns5wgLUPcoHyfAeWB7aZGRM0P4Tc9CTjG2SpJUp8cCS5c+?=
 =?us-ascii?Q?PxyJHtr4EiAHbVAKO0Fpi6/yJAF2gdhQny63al2hWsNuaaxyBsyEKxjlHPfD?=
 =?us-ascii?Q?wgNKZ2HNAQjuBaSRuerfFMBw9quZBLeAUTp1rGitmAQ7xwir+j7CoWE1t7Xn?=
 =?us-ascii?Q?Y/VubpmkPfvGqrU3Pge7/Frd+VTpK+fzyASN8deMriyKloJLaK2GPZEhGxZz?=
 =?us-ascii?Q?vGGnAEDXXhWrdrLFXl/Fm4hghUBodoUqgsODRK4VW2jp0qdBBOkdbpGAmbvB?=
 =?us-ascii?Q?87KcbjKfvdKyzn+ehBf4qJYaz07tUWWcfztrOkTMSM5JZY4Gk+d+e8gB9mMT?=
 =?us-ascii?Q?bV8r0atIdNyfbcVj08iP8W9UFBu80qX7X75ybP380ehswn8MBoi2cuLUJZjN?=
 =?us-ascii?Q?0WYduPdsy3gN+QaNbY+IkCvHNh2GIZ0F+xSeiYOK3J9w4zflPlN86YoLm5wu?=
 =?us-ascii?Q?4BGJS75SYhJzHly0VfL4UJl1ynit+q8l6s1chDXjez6RNNE3FcZZtB1ux6F0?=
 =?us-ascii?Q?rDaBc6pk3tVvWpzhbrdAqa6T8jj2JodCPTwkLp1LjpfrBW8kxfuhNQDq0JTa?=
 =?us-ascii?Q?WqPnHBNFqdEpV5WZjgZusypb8R/Sh6NGaWosxhYIXwt8wpO4ZLt+iYTB/Z2D?=
 =?us-ascii?Q?yqQ6uKZ6vggUfjNUN6YBn5TQBYVxQgeT20J2kHeWTFJfIu9878keaJY+EN4B?=
 =?us-ascii?Q?pdovg8QCpGHDvV+/Clc0B4SYTe+JPy22j7w0sDybn29jNt0oKqOZzTVl8l4V?=
 =?us-ascii?Q?vBpdbYEhxJ7ux/brchNIJdJzseZTBoa7D7C+PhY/UbiptYq1mhrTwwc5Jrho?=
 =?us-ascii?Q?sQFOVQN72BenhgireOMgY5o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6e6939-5f8a-4c3b-67d7-08de18dfeed5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:19.8865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5CFAD0eSPmkVqjtz8uPZ+6cKzgppZQFLjFzF3nXV5IbKWrn2jpbZxiH89oR/1bwhxjYR7wmoZvLuZ8/vn/h35r3pBxeOjZBH5nU6xOzfM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

This patch activates clk support for en7523 based boards

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/en7523_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index 0730136b041..b7675d822b0 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -43,6 +43,7 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_REGMAP=y
+CONFIG_CLK=y
 CONFIG_DMA=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-- 
2.51.0

