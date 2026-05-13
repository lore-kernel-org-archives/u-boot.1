Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95505CD4F35
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B27F8466F;
	Wed, 13 May 2026 12:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZnzYk1Dc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E70278341A; Wed, 13 May 2026 12:01:25 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26DBD846B1
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJGqcVPDxWwF8c2bx+jCb6y7Ih7gGvo9DtXQM0Jj3srqc3ip/yHGPOajlVjr0+aJ4iEDybjvaiKR0wEBd+DuYNF1wcYjryFKHbF6ZdXvPo4Lo4TdyAagCxVUY+jUjzrWPsshGe4RCkkE9MQ/30VDiKXoMeLHL/Ut7EJQayDsJtklSa3KoGsYcfCaHdOGl6L9pjI0zr2eofhdQGIr9SGcrrxpQeUAO7Gdgfh8+qPUreYSIBjEkw6ephoOYus4NSrnMdrJ1KP+h7zxdNTSXtsOBK2XLa8zGMIlYMQe0Ju6pJmIFRfTuJxyRz1HCYwWmgwc2DBb2EEyP9ME7LP4e5rJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+r90hn8g3q6y+1t4q+PHaG/7/MftHaqOWyfWxOKy0zY=;
 b=T9dapRKsLc/nQ4nT5aI82U6tJseo49JMHKJsJuyeuwZK3O3YWetN24dTzz6wuPTRd5ADrLa3YcrCU61H6Pu3hNzrzqNfm1hDMpU9CwbhA22ZYql3lWRYSg+dXF3HL+xU8Xbv0zLWq6aTdOipmp4Ku/1z9SBF9d6/qnYkLSDUOoKWm14dt04KVrAe+dJ5TVlOxs5pt9VI9WpQ2BCTN/7htFKaHXglr5p0Uh2TERFvPuwV964RHhBVH7L7aEifaKWk9bPIfxDOIJfI95vn/ClOfKJfuJulS5DiOVj6eA1fguQGgfqDN/7FvBn2JWsJ3ZrumJ6DwpLkg9p+iB0hxF9trA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r90hn8g3q6y+1t4q+PHaG/7/MftHaqOWyfWxOKy0zY=;
 b=ZnzYk1DcjYh/sbPusWphIx6EXi3+xQpm5iKHrFisP+yGFIdywb9f/qhdKbOnEmbrmIr8UXoUfUC0fv7yJhceZwG9satTStKXT6yMRSC8nBkABUgL5O3Ipog1ZE7M4DfozGXY2mb8lqVFiAmSnCLRs+DxCR9zHYP4au288o1gFowCUH0W26W4Xj+py6BgykQldnXADEiXuBg1R0qQxbkD3xs7/BfqL85QwV1C0NNP37u44Kz0qJSKRh/jcP1aB9tIM0WKapVc7x17A52jy5bhiKika5RTOhlQ++tVPji6V4xmdN+dkhZfrBzrU+M/yDk0KKHOzwS4WykJdFyfH2G9NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB7928.eurprd04.prod.outlook.com (2603:10a6:20b:2af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:01:22 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:01:22 +0000
Date: Wed, 13 May 2026 18:04:11 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Michal Simek <michal.simek@amd.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Peng Fan <peng.fan@nxp.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH 14/14] power: domain: zynqmp: Staticize and constify
 driver ops
Message-ID: <agRMm8exGAkLq2hG@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-14-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-14-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA0P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 52338ef1-4257-4eff-66b6-08deb0d69624
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|22082099003|56012099003|18002099003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info: szSAU7SVgCs8BU+e9w88tX+ghpg/YUOYdqkGbRajVIggr/PzlUiHZ60PqL/he1/39tPSi//xf5V6kz6MiBoJrxSZe6Q07opbstCByRDccpZ1EfrcsGXIzM+qAaoo9Sp0d+mLUt5Q7CZ039NB776tpeC+YD+A3SjoMuv1Sddcva+oJYKPANFZpw1uP/tKhhmvluFPxo6lP3dOaUWFo2J7E0ZHpXSmhOJDskk6zs+/MNEOldG7wU1O/58nrYIdw9evDjqILJJ6UuCUBclSUThO98TW7nsVhr+Ql6+WRKv2GOzX9fos4XTWMTnwm/fu2XS0NB8jULM98s+b9lxwv7n9YTMjzDxY8SrxlWdTdg8TBO/96VaHkH/0j/jdQ5WqCuD7qi7zAZaWQB3NuLbXPN5UrK1Kdfazeqx/Z9a5TZ0ZvXryx+GtWeFF45OnjlsnsoUJBKE4jCGF7pgGvAtYvoW9ZKWV598QjCqo0yN35Rk5RPYuuT+CZuW8CJu7X72zgbVXau8PvsVMkajpwZUpgHtCBeCG16uWVjmMvg/6De9E8W0KlA6MGn7NSnjXWr6cpK8J/F1dvsTFuGJU2F+B5uwwznEAxOLvEi7P/lOC3tpmqPfu39tJCKTrIbnJTBZYnXO1xZDQ10QedNaFMbJ9X6ywR6WlR+oHvA+UCZWNBXpZNSLVDDuN+JangX84uUnBjOssBYkhwng4W0cfBL1DR+udVF/bcCRShJY3FOHy5gCDJ8nJQkhsNkvtGJcJlsYKmK22
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(22082099003)(56012099003)(18002099003)(11063799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z01RavenvWHQxwaRufUOuo/FLC6tgOTsYbznUC6SdFBfJ1LZWpMbsFGfQmWf?=
 =?us-ascii?Q?Xu75z2CYYUkDAvCfb2fUnsIyZyCmmDVSy+4YWbpsejwi+O255p4eT2G5XULx?=
 =?us-ascii?Q?hyFdt14XN9bkOmaCrFZJQis3tctKffq7aMg7SrcQl5UuT+Fj8RJnZSDPpiy7?=
 =?us-ascii?Q?ZUFBPm23JhnP8ObsJdY3eIK5ECc1Dt7t3dk8RkEiCF3mUYDrfeLk4mfp78fH?=
 =?us-ascii?Q?dwS0zTIwu2XPKvdw9rHalFxwDVZwmJn0VZY5lvjwGJIbxHJ2yXICJZosVoRL?=
 =?us-ascii?Q?CzYsuqdmxvNwpXcfe5BKVFUtiP850WGIN/SwhSmAA0TEkOuX+sI6dTxuzFIg?=
 =?us-ascii?Q?IGuTfDK0aRz304piwAz0Cq0Ozs0leqeYdU/H5cG/cLmFqg7gDP0jYTuG53rP?=
 =?us-ascii?Q?8TWJQSt2huQTZx4UwW+aigLJd5qeoLA9iv6gzc+pFJW+cBXj/HWTfRPnDkvz?=
 =?us-ascii?Q?EJt+/KLlVSYKKYTZG6nqOf93Uxbj2Pq2D7kgHt7j0lZaRJMN7A2P3c/EGf07?=
 =?us-ascii?Q?PMPHKKVwy/HdJ1jPxpadZFoBkWwuAXBy4kRa6a17TBDWfN7lZqF2Gmx/Zxx9?=
 =?us-ascii?Q?e8QMrrhLqt+IQs0a18sTkiVQqydEn1TI53SOnP7CkQ9KBx9Lv+Xe0mhzqBdk?=
 =?us-ascii?Q?oBp1BQt/NuIXuRcCB/f8vfcL6I3KZgpVqN/yi5W9DFuWpkhakHNnmGD5h0pR?=
 =?us-ascii?Q?A1ozPpl9qeBkQ5hzPRxTNGfQFsjc1+LNu4ZCNY0QZbizS7Qri7I9J7Gu4BBR?=
 =?us-ascii?Q?OH6e7LS3A/3k6jiXREIq55RblRymgQfsLuSPRC7s2yYTALp2mmeiMHdGOLF8?=
 =?us-ascii?Q?1+Jto1aFy1MqX8FzN8BiHDdBJOGRsaxWuYHPnv8JhAqXfrffLcCWsQbG17Df?=
 =?us-ascii?Q?aLB4Zbg9E0pgHFOAD8IQC6wmk+K2o6ur6xqLxXS8OSdCwTYRex78geDU5obp?=
 =?us-ascii?Q?MJ0jrKajqdwx55H+0540rW4U0tURTZ3uMr+gJ6vC/RWQfnX1IfvVS9EQ0s1f?=
 =?us-ascii?Q?mdcSlOZ7AtXe2ftCmENCUjRFu2znl4GhTGMtLnveKbjV6riyljEsekF5pM3C?=
 =?us-ascii?Q?ifyboa1yKQSgNVSccmrXfT26d4Vx34HOnFkBSi6aXCRSzComXsrESPfAHRjH?=
 =?us-ascii?Q?I71Ajeie8xm3k7Z9cVh9S7+3JAeaCzdG5zYu99GyekKvXOYHNzSmFGQaeoxN?=
 =?us-ascii?Q?Ceq5PzaZOCAnxBg79oPpvhszLNK9qkxUOcDAk9/0augyo0Hsq1NYHF0rpFR2?=
 =?us-ascii?Q?CyfgJPWcO/maat9D6fQy+s9NhpCPivcVR8JmvzvSlVj3brBxByQXhd7TS7JI?=
 =?us-ascii?Q?eSFmYegtw3d5Y6ApY+kfXM2ikd0I1pbiYQZuZlyzeUwRDKeEzpv5u4dTdtR4?=
 =?us-ascii?Q?LFbVDmbBw36+xFxbrP+DJBjB4zcmiUdeUIMhnsI0WZR0RpFaUNR6ojUvGvhL?=
 =?us-ascii?Q?weAm0FsesD4cyP/pFLKvo+nmPUit5JSNNl+YCKB/4VxVgftUgIK51HQ6WI/W?=
 =?us-ascii?Q?xsWtz0L3hF44ZoJjhALQts3MS81vFy6sOyzj20ldZvnNtYqLrBELk9RtPriw?=
 =?us-ascii?Q?hgRC50LwNzxDg/RNzxD2+gm/w/jKSEk9iHkpBy0APxk5dIdCLlWfQkTP79uz?=
 =?us-ascii?Q?gCyP5rdnfPyb8DMbuLjvpperrr9TtXs6WGGYpZLd6hlqxust6kAV6fVTL3OU?=
 =?us-ascii?Q?drPbCSuqbFcNOmud0oQi2H0RTl95kW/x1Vy0xF6YEJrYbMAywcxlFrF7tN9s?=
 =?us-ascii?Q?dx72sF+OPQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52338ef1-4257-4eff-66b6-08deb0d69624
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:01:22.2613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuagNEz1MEx2xJJLucTaXRZ4PgMcmS9H9zpvAvjmzuaF6doTEL1e0Y7opRUdOPcyM0D0Tetv1X/07iDPfLgF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7928
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

On Fri, May 08, 2026 at 02:22:14PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
