Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA5BCCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D07C83C01;
	Sat,  1 Nov 2025 01:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="l7e3IDuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8253683BE6; Sat,  1 Nov 2025 01:45:31 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA94A83B5D
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGJRkm8B6OFdoK5omUA7jiR3QNikH3+8sMRhXmp+Hz2VPAtzLiwP+eE94e5wYekHD/zjkEqbJ4YBll/A1cnl63ru+ph5fi6d/JWvZYxZoFxCb1I7/huUwteTq1kdN9iJmgarOQPRmC4TVGM1HYZ/b9fdIbEhAeOoKy+UWqWe8PdBvqQHbHdmCeeD+0tmZ8WqstyotsXqDeVybaCk/R+eDJR1B2/xtLxTvyj026ToNwIX6QS53XPqP3dcjec8KjAZFvXqzMY/fgUQNhj/uHb2vFyU38/LKn61ZZ/T3vKHj2sxuJ6YgFc/bVqJTpNl/18/EHqNjPB0RPEPvmDPOlJ8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O35kR3os+idoZTYCrBOcIFlrnk/uYwrhOWBuFpbEeIQ=;
 b=LIvLMIH2wonvqFzjSjsuq0EKzu9q91MBzD8QFsUYSiFnb6rSZRvCCrWzLbAWC5HQJ+hboERNm2SBaUnSgxb/QaVYYRbmpby7ePKGroia4c/HlK6hc3Ov62ar6OhiUQ1KDTwZBgzi81f/sn1HiuaQf2pjAVUHOkd7MEaC6RqwVeTTI7nQWV+Out5A5hpqpnfbdELq7tqjJvVDG8nbMdGo/JU6UodSAdhlcvIR2rvT2Kl2xVT2/ufubowMPYzKs/IrRjrqvJ/L3Yzeda7VFcIfFptSlrikxmsBLB624e12AieST4PLJwMhf0b4nXUZN+sUHUDhEZ7bXkKLFzLXqwb4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O35kR3os+idoZTYCrBOcIFlrnk/uYwrhOWBuFpbEeIQ=;
 b=l7e3IDuCufGA9LkT0j1MsYXnCdjLnZOXso4BwTNLffAQQBay9Kz3rQIXGgndUYkfm1mQeH5Y1WOYcLqg3bH8GOGe+BSNjRhRIsnP3gTG12LopN13hglLHjjTnTI2npINYN6Bjw9Eu6NNtBtmDaKkkuDeG3M26gF8ROcUpnFeWJkxEY02lHfr1SGv0fvn2ULCRxzl/qptSIUeV3CKKc02YPS51SvX0AIreJG4Kf+w1RsM43zl8GJfjlkzzs5a0tEa5I/AVItBaSAuRCHOqOyjbqo91jNsGVPeaPANGKcqhctZWiMC1vBcF69JHkSWKgZJUpxET4+CC7fxtiUeBIujVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 13/19] configs: airoha: en7523: enable reset controller support
Date: Sat,  1 Nov 2025 03:44:57 +0300
Message-ID: <20251101004503.2379529-14-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: c145046b-19c9-4727-fe2c-08de18dff2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pxn5dapL8NadmIFB10zO8ellAq6/r5N6lwIqbZ/LCZ2TUjMIGBstKOzL5S4B?=
 =?us-ascii?Q?nNj+gdPtw93ZPRRFAki+4VZlDQsi5mAaOjL3+SfntwRN7Qrbtz1zL1Dv+8y/?=
 =?us-ascii?Q?Li4iCw0/TuvJh9TP1SuPsJNDQF7pToGmkEH+lHLXICeiCSbUi0lHfq0V/QKM?=
 =?us-ascii?Q?8MznqNPclfbgX7wlH7yjdpkYmjiOGY5/Wcs1tz8YJwW3qRS40bRW6L6yDSdA?=
 =?us-ascii?Q?Bb6cosW2+o0JKKNyc9inXQ2P9gmTKSILXPxZK2yIv/AaJOzg87fN7ZnTENqI?=
 =?us-ascii?Q?Z1Lemjemg1TzkPb/WYDGXVktpf8CTSQ8fGMp1ObLf7dqUqVqTeezLXWinGol?=
 =?us-ascii?Q?wHsKMudhox/mjYkp3Xwbf5wbD+aKupnMP6IH+Sw54Gyc/py3np0BXOj/AT8/?=
 =?us-ascii?Q?T+FzSVTxZrHsgfRQ3ccxDqJFO8tNw2NtauAmdZXWBJ0j0bvtL8Hg/3HmcjIx?=
 =?us-ascii?Q?dEOJU5fKrJ3HQOqleFIOFrEh9qFe9erZb0nk3eRwDZ0YE0kCbSzlyBXeJunj?=
 =?us-ascii?Q?1AZw5l5WOt7wXBi0HPNlzaYdyNZEadMo2yC4DFNl981x5YZStDHX+SPQM4gt?=
 =?us-ascii?Q?d/zjuTZ9BRPT0pZlXwZ1XfwB/cosi5PZ06cJLO8Mb23FNJBXZtOD60Lifeny?=
 =?us-ascii?Q?tTfQIOrjDoOIJm7H6jgHoAy03IXWg3xlHEgb9RrgRl1GKlASi5EdkDlVgvcM?=
 =?us-ascii?Q?/eMxIIBc8zWxD/bzSMddqWIrP99z1z2iQOfIeAcj9UZIEDLmbZA62Cq51K3/?=
 =?us-ascii?Q?l56tuaTu9YeqV6lYztJhc6NM1DhiLglH7ggssUfPYHRGv4RnbYHl2yGVNT7X?=
 =?us-ascii?Q?pDvAh1KI7FghLE/PifU26u5BHH+Qlw1UCE4q6erJjaTOuL7FmuKsl4De6RAC?=
 =?us-ascii?Q?Qp68/yZi2vlK6bCqBHyl30r2PSoJO2innqfdUCn67kP/515g6NDQT5nrBh4Q?=
 =?us-ascii?Q?59ClBuuEXO8FVS68UUg2sC1UVNlRMLabYIdeiS3xalg5t4Xmm483gXLOcUF7?=
 =?us-ascii?Q?lcR1QqKLEwe5riF4WzhP3r9TFA0XrlpmGKWqKp3QGWWZnRUXOuGgH1tiil6k?=
 =?us-ascii?Q?ETSNHHaES/ToF8NWkJ70TxPNKw1WvG+peNtZXoCXdOD6TcVnDFZxooXhJeDa?=
 =?us-ascii?Q?N2rueiSKw/XKj1MfouNtnq0V7+NdkEK5Rr6RTijI6WF9WqG4QeOOZN3oFbC0?=
 =?us-ascii?Q?caJaCHb6zgegecVQVoAvD/WZG/XSv6dIgarb1g8jpySOqBQHJZm7b6e3k5wh?=
 =?us-ascii?Q?KKjWvLbx84f9iyWpbswHXwKgqhJBUER7Rt2CNd7tcKCFVJcfZw+TauhftUuu?=
 =?us-ascii?Q?D/sZiynye45YfEKu7TZepr7ihfk8caEEiRrQMJHST7mCUjln69SDj7/eMLsb?=
 =?us-ascii?Q?kpc3kHJEIly9gIVJRdNt0Z6y6jhWOTRjFr+yw8GLwnSF6vXxN4VmSgq2Mr/z?=
 =?us-ascii?Q?yGk3TCmdeBcaRGdgFZTuW3+ZspAjheD+sWOrqXOWWOvjcfQGQ91yveXSEiYU?=
 =?us-ascii?Q?+cc9OduexjDTkuS7b7x8egVSY15R+Lh9adPS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C7C1RWFdhHrV2O2EwgsFNv55X/T+a7IY88vo7eOKYWJ2cbIebA2PymSYPljM?=
 =?us-ascii?Q?ftmCphErvq3mdYiDpusJKi2bUDjmOW5+wOuZhoYPuly28mEkPR05AIYlGa4Q?=
 =?us-ascii?Q?89hsTHsRKtyEnXVIJVkHNqKrH9dynC1O20KMrB3ZcAC9Lm6jJnRpA3gnAz9M?=
 =?us-ascii?Q?oy62S/CeyDWiP9stauDXf/FD8v2U+VIk/gCqvyHjIkRSypqdx3sowpAEAMxx?=
 =?us-ascii?Q?9UE4Ly6yeXTcaZJWhHV5IN7XFmYygS3kwuYiu/kXfp+cvzvDIrIr75GmqcUb?=
 =?us-ascii?Q?5rZ7OHKxu9u3ngfdA6/K1WAPivGj+auYV8/4u3p27ceTjrS3ClnJOHEvprNf?=
 =?us-ascii?Q?kz+KEFGDj1LqsPnzefWls8XdZl5kMiJXFpAarnb3WmX2lQ49eMU16AVcuPBq?=
 =?us-ascii?Q?6EK7DbiX85c9K7KW9n7gfqmYtTKfXtov3spvi5/EmiDabrnVEGNukGxZBlOt?=
 =?us-ascii?Q?/JOw9ZIfpAxhAuYaUY2Mnqy1KggZZPlhEJB8R9kItAXnsx9BLKJ1/3RqmzeF?=
 =?us-ascii?Q?XdYO2od1/3UPLD6YIQZR//BtELyXS6a3LUwmxP3s7Yq+yKWK9606OA3r65Kd?=
 =?us-ascii?Q?LioQarFoQ4H7Yo7MEhosQEOxWtYPFtQmYq9bWyl2ZP79uoMQDJpJWf3gMcNT?=
 =?us-ascii?Q?5I5Vil/i8mGT8tBLY3cMHBAFSfoASBAEkkjixd+fM/dcILHu0xxos64g51TQ?=
 =?us-ascii?Q?YVQ1H33SQ7lfk5hHLm1Y2uZTZsR7AvLzBXcfiCkYki4+xdiJerzssjyhnoEO?=
 =?us-ascii?Q?yt4Qd6ZXXvDDFOnuZW39xLBovQ6KTR4wF1IWeq3Ni7mt/EJfbsKcnJUtO+wG?=
 =?us-ascii?Q?I/A5yRENx3y8rVNUQfvnUkPrd4NyUykIHUF3iOw+geLavqAmLlnVN0b78wRy?=
 =?us-ascii?Q?x+vroqSgf9rmU4lVcblXlYInpjZt9RntJpbYQosL6jQJiTBU4U0vt+eDioN4?=
 =?us-ascii?Q?Vx4n52yZTOnDAMayMqKT3IHf3wgCg8uLgXVwt146SV7ozl2pziGBSlhkG5d4?=
 =?us-ascii?Q?kvuIVjDiybFanNjM5USJNFx0gQrW5wYqAVaSkk2Txwj0qWfvoGDEwiH+z/7T?=
 =?us-ascii?Q?dr/L57MzuWKW7f5G9LNpO1ounSet27i3lWprbdWzftVcGNNueA1a/yq9Yzix?=
 =?us-ascii?Q?mw2WO2Cl/cwDqeYuqLHYlAaSCy5G06swTdCiu1+m6H6ov2hC0j8+pFO+8MwJ?=
 =?us-ascii?Q?+8b0js/eey57P5aoS+KhIMp7EIbIhMPXipB9yqqfzuyWuG4cbF+jTBsWMsLl?=
 =?us-ascii?Q?3BFpEoqae6VPTqUOSkz8i1Lt6eeBYz0/y4sxDXvMqiHRWPTv9NlzzZpc5uPt?=
 =?us-ascii?Q?nvFLT9JU9hBcC0yrgfXPshHa/S4NZw3YnBkMe9mE9WbovS1BkHTmrjWDPogy?=
 =?us-ascii?Q?SxlSVHZdYRGBipylgqWnenD9naQBuJgcgRSPjezNL2ouOMH9NSDdBTvC834P?=
 =?us-ascii?Q?5Mqmo1TfzkUICBfEt341awW6/hJZAlrExT633HgxraPZDnwcrw/PPFdbxhBJ?=
 =?us-ascii?Q?yuYcG41cQzdKjYv8XThd2G1hedu517WZZg5+vENPVV+cJii2rnoIO8UL2khK?=
 =?us-ascii?Q?ZL5Z4asZIw7HrFbdqClb7nJ0FIy2fwJNl0BpKN8HGM8E0JrGX6HAwNHG2b6k?=
 =?us-ascii?Q?AZ4lbI+quNCSguJN77ShClw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c145046b-19c9-4727-fe2c-08de18dff2b6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:26.3977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qA5PGEpcW53Mpg3WGFbC8klsvaAKAI3xzn31vw9VLBQZf+hif+7PoVgG0YiEjYGr/Ukuq/xP1kk6pNClj1H46mv1TPmmMyU/no19n1ueyv4=
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

This patch activates reset controller support for en7523 based boards

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/en7523_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index b7675d822b0..2a57f50e851 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -44,6 +44,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_REGMAP=y
 CONFIG_CLK=y
+CONFIG_DM_RESET=y
 CONFIG_DMA=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-- 
2.51.0

