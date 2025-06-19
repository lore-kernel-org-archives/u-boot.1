Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9254C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 09:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E7282D21;
	Thu, 19 Jun 2025 11:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JS2wyE+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03EA82D18; Thu, 19 Jun 2025 11:13:21 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B0782CFA
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 11:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hfz4F2IY4MyQu5Qz0X6lAptxu00MAuUYqch2YFGYQmQgH8R3emaE5byqXBYL8dJUlRmjOYlZfr4ktd7HXxkuIdbytu7Nb8HVXB74arsFQyU7xj9Aa8RjbMnWDtJNUT7JcqepWVGRizJ0ypusJx1DeP5AZGfY8YUHbMC6245HDXfh098FYj8xS1c9TLmJioH2MyoyssOj9gK7Ti0wjxHcxA5ol1b+5eEnm/uViLzIbqbfw7rmd9a7Lwx6xcW8hGrytMTYS7AtmWwA+jwYop3B2C/xcGd5BrUAxOwSTmOKOQXs8P1X21pB+U9nTSCElxVHzQuyl21LciDqt30OJ6o+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjylFzP2+9cHS/nCDY8NOVm/AJGYhkoVU0NQKsouEM8=;
 b=HCgYhE/i0Z91xmNudcUUXoGx75zCCAXQQBjaQAsXQH/7x9Qzqr4itvqJFGh15dyrHaiN2TgbeeaNjO6bN5YcCeHHDSvZV7Ga9hq1SY/bXKfzsbaDV8WCAav7o+9wUDmqM4e8krAbkpR65wF1d+lAaaYzI/XO8MZhjFj55Cr8isi4XXbEKiWJKOS5bzHNsuGVFepT3spnIWebersqIhY8uZE0K+haE3ZJRGAf1hC/17TyTpN6/vszra9opYIajmzpttn9OWRi6thElei56YzEvANPjuUTBQce7kc0r8lnX96MhqwwQdZ37oIxSth7PeVckki6gQ8NQ3o+0m+FZygpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjylFzP2+9cHS/nCDY8NOVm/AJGYhkoVU0NQKsouEM8=;
 b=JS2wyE+a5+BUIeB7iUuusu7Di2sr9WBCCa/kOE3YLHTwRI+dgS0+83AgF5L+KYNMBrRZodjMwsXeoWyKjuaqiV5tUHh/uG6pkPFVNY662Bt7z8s1r9eEqIOGOQNJSXmb73OFQE+ju23r12JhX9DfksZTddr52eOOI6+qFgtvQWGSks5YoPnOjSi8Ei5xw5MeYwIqvKc+O+iW2G0l/G2a7Cn9POVZDGaGGqvvE24lujr/1bx2WfjZevbQrHR5BOPLf/LcwJUphSqnT7lpk9ElH3+1udRdtS+AbeQmw0bQ7eN+lvO57JRdRTpwQ6SuVO8f9uSkFsUHCm/r4+52ciT/og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10888.eurprd04.prod.outlook.com (2603:10a6:10:585::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 09:13:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 09:13:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Jun 2025 18:23:36 +0800
Subject: [PATCH 2/5] imx8mm: evk: Add support for capsule update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-sr-v1-2-631100a113a5@nxp.com>
References: <20250619-sr-v1-0-631100a113a5@nxp.com>
In-Reply-To: <20250619-sr-v1-0-631100a113a5@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10888:EE_
X-MS-Office365-Filtering-Correlation-Id: 6279296c-6269-4482-8a69-08ddaf118765
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGIyMXBHYlZlenJTRGY5dkVvL21PSHJHWFpJaUQrQ1Z5eVdKcG95UTFkdk45?=
 =?utf-8?B?Z2pyNmVSN1ZpOGJpOHpDenphcDlHb0s0Z0VmNFFLSE93SGtXNnZNQWZNd3ls?=
 =?utf-8?B?SkljTVJBbnZHUlNrd0I3a1BUYnVYVG5rZC9DRkZIUmlTeW1rbVpoRnhKKzRs?=
 =?utf-8?B?YTFiL3hwZ3phZERTd013R3JPK3ZMVmNBcm12REhIM2dOZGVvdUNLckt0WkpF?=
 =?utf-8?B?ZGRlbjk3Y25KdDE0bXFKMHVISmJxYU1nQ1lHWkJjclFWcHF6bTQ4YndlVTlq?=
 =?utf-8?B?RWdhVGdoMGpxYm84VzFlNnZFSzZVb2hGNWt0V2Y5T3RVSi9TWkFkTHVmMlcw?=
 =?utf-8?B?SU1LMGY4azYxYU5xWkN1Qk13YVlNNGNRbWVVTE5ITWNndzVqT0VuMTVEVjdN?=
 =?utf-8?B?bUcxYkZ6QkhvZWE4eCtHTUp6d24zZzVqVmt3OFpGZDlUck94aHFzdSsySU1N?=
 =?utf-8?B?ZTJ0MmlDWENlUndEVTZMc3ZQM201UWI4YkpLYlJaa1A5aTdwSXRPU2VGTTd2?=
 =?utf-8?B?WDhzU2lmOWk3Vk5hRXNZbHhuZC9lak44R3Vjbmx4VDBIU1V4UzQ2OTRydDNq?=
 =?utf-8?B?anpCZkEvc2F2bmVZVXJKY1oxOVFLcFNwcktVSFptZlRhZTV2aS8yTVhIVUM4?=
 =?utf-8?B?VnUwbGRpWVNJZHAxclNuQUFpV0ppbE41KzZqbDBaaGkvUG5Odyt3SVUrTG9Y?=
 =?utf-8?B?YTVFUnJDaVVhWU5BZGxjZlpVRUxSUlpQVmV5bXVWdXk3dkwxYm1CaWJVbHgx?=
 =?utf-8?B?eHFYMXozVVJYUFFRODBBQXQ2RnVLSFpjcUVXS0h0TzNheU9NODVZdEJ4MmxF?=
 =?utf-8?B?WGhZeE9BYk5ZSS9GYUszbUpHSzBWYnQrZENvbldWNUJSd0lqWXVTZXdBTzlo?=
 =?utf-8?B?bEI1WllwT1NXc0dMVnJZSjJ6azVzNHRwdXJxTXpqYXhlKyt2bThudzhobUVQ?=
 =?utf-8?B?eEdpaDlaK0lnWFp4NlVOTDJDUXpNWnlVRC8wQVY2eElWR1c3VTdoSFVRLzhq?=
 =?utf-8?B?ZEh2QlRtVGYwY3NCQXFBU3ZWV0pLTlVyVWcvcGtEMll1R3B6RW5vdFRLTWtF?=
 =?utf-8?B?Q3B4ZWUrNXl4WndHM01kZ0dwNXovdThuRDQ2cWZvVENFOFY5ZHJxd2FRb3Nh?=
 =?utf-8?B?bzlHamF4d2RTMFFBRVZQK0lKSHk2RjJaNURYR21pZTZFYzdYeWxrNVhRelJL?=
 =?utf-8?B?U2Fic1JJRDRRMzZyeTM0bW4zKytIemlxQ1lDeFVjL3RNVkpRMEhJa3F4bHdk?=
 =?utf-8?B?c0ZaWTVTcFM0MEMrVGcvc05ZbjhzSVk3VmpUQ005MDE3djdLWWR1bGlLZmpw?=
 =?utf-8?B?bGpsMUhCcDFSc2JVa0VQNGFveFlyeWUwbzlkOVBvdDN5dG9DSFhMZzRvZ20x?=
 =?utf-8?B?cWE3SGFmWFlvMEttc0ZFYldsWE5nMzJkeUE0RVRyamd0aGRzakwwQTg3Y1dG?=
 =?utf-8?B?MnlBRkNqOU96cXVvaDJmOGFsNFFrQlB4a2RSdTJIWjdheTl3bjVKRWlzTHhn?=
 =?utf-8?B?dWVRTEg0LzQyMUlZWHJDN2t2N2tScTU2bStVWTJOVkp4cHVxc3RWeDcrVTNT?=
 =?utf-8?B?d0dNSW9obHBzbG1ZN3F6cjkzVjJ2VENHSGVJOG1LVUNsdkVtQVFhUnN0ZEx2?=
 =?utf-8?B?TS85cTdhMUc4NFk5SFRXK0VyMzNqUDA4K1l5MXZOM0trdWhrV1hqbWRMR0pS?=
 =?utf-8?B?bDIxVEczd250Q2htMEFOdy8wV05vT2Q1a3RwMDNkeW9JQlN2M1lvVGxkNEwz?=
 =?utf-8?B?TlZyWUhDUXRZU3pGZ2ZtLzVvMEMvN3l0V1A4cWlWaXp6SUttWFRrdEZFblZv?=
 =?utf-8?B?UHlKcXgyb1RHVDlwVzlYbVp6U01JcVdRYVRBeDFkTGh5YTFhZnBkaHZYYTNX?=
 =?utf-8?B?YjBmOVc0TlFYdy9zOU40UDZKQ29naWYzQUlydFRHMTZkZ1djWDU1WG1UYzhz?=
 =?utf-8?B?dkNRTW5XdlNvdU0zRFZib1NmSWdYSVd6RnE4S3M4RjUvQTI4em9xd2FnZHlH?=
 =?utf-8?B?ckgzWTFWYWJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHVrbFh4VnRXOHV5dHdtamNadEg4TVVubmE2Q3Y4dkR3TmgxMlladDJpZFM5?=
 =?utf-8?B?b09wMitCR21SK2twUFl2MVN0ZEgvTU1nQ29yVFd5VWNuVCtXaWF6K2ZhYWVo?=
 =?utf-8?B?SFZhUm9mVW9jOElOZzJ1YlArN0w4V1pCSzhKN0VMK3c1Q1R5Sm1oRjdSZDkw?=
 =?utf-8?B?dFRQS0swa3pBaXRSOWJhN3NEVWZIWkdXSTdXaHRIVm5MeURUZEt5U0NyWkQr?=
 =?utf-8?B?bzJHY2JYL0VoS2dJMzdoK1k1Zktmay8rQUZrSUMyZDVkTjZaemVUQ3V6c295?=
 =?utf-8?B?Q0RQazJUZE1jcU45U3VRWEFOcDV0K3h1MXdnV0Ztdms5d2hPbXl6MlJDZWoz?=
 =?utf-8?B?VmFOeURCVTBGWUM4UUxOdWF5Z2dwbDZ4VkRFZWUvME5CQ1N0cGhacmRrdnRy?=
 =?utf-8?B?KzdoNVhEdjlzbGR2OUdqc0ora2l2SGFac2JSazdmTTRlM2JBYXg4TW1kLzI4?=
 =?utf-8?B?S2ZuZTRGSGxtcU5aOWY1cDVUSmNUenUrWTJ5T2hQdm80ODRiUEhIa0Z3NVh6?=
 =?utf-8?B?US96bitHZ3RMWERzL25BUCtHRUdVU3VmaURYM05TL2x6UVFvbTIxemxHSHRD?=
 =?utf-8?B?bEEvaU5FOHdWM1N1b0RHb3BJVzhVbFVFTnVRMklqY2Q0bXA2blU1ZTY0bGp1?=
 =?utf-8?B?clpObVJHVHptcUNHZmxLSExJeVRUbk5hUGJ1dGxKSXVqRzVob2ltZXJMNGFS?=
 =?utf-8?B?V0I3Ly96MmtnTnliK3JyRGJoWU5acUFlbThlT3RnWnpONDkrR3pZeHFIN0dE?=
 =?utf-8?B?SHppRGUwa1Z1VGQ3T1ptTmpxZkROVXJZOWJIckdXQkRkREs0UmFKWWJlYmZv?=
 =?utf-8?B?cktFczNjd3NSV09ESmh5cFg1MU5EMm1UKzl0QVN0cmd6RXRZUEpjWFc0SFZT?=
 =?utf-8?B?Rkl4Yk82Z2hwdGlMRXowYlFJdUMvc1d6Sm5YbmtwMTN6UVRKZzREUXl1R3lP?=
 =?utf-8?B?VnU1cEJlaDZJbEpucmZzSkxQanVMRFVHWGtCdlNYaDl1dWJWK2g2RkVZME9m?=
 =?utf-8?B?dlovU2J5SEZBVXgxZTZFNlJrQ0RqSHFvTS83dEZwSi90aE5KeEd0S2l1dzZj?=
 =?utf-8?B?SUJoWEJJRmpkcWFGOThDbjZCblBPaStwbFpQVDU5ODFoVVA0ejlDNk95OEpU?=
 =?utf-8?B?bE5LQTRaMnlIMW5QckxkR2szRENEWkc3VE9iYTZkNWZPcWVhMVFGTENFNCtQ?=
 =?utf-8?B?UWtVWDU0TWducVFLYkJicit4eEw5U21DT1U4U005SHVzUTd3OUhjVkdkN2h2?=
 =?utf-8?B?QmJtY21XaFFwSXBlanlOUWF5b1ZUMngwNlpUek5wZXlzR2dzbEJpYzNCcXpu?=
 =?utf-8?B?VHNqT1o2YVlrSTl6RW9rNWk3cTFBRTVjZk43U1YzOTN6UEw0ZjNiTGdpU1Ro?=
 =?utf-8?B?UUFiamdvbTRka0hqRktwMVFGOHRyUnBqYmJyWDd5TVM3VEQwMTEreHZuM1Av?=
 =?utf-8?B?SUV0SXJsbDFQNVlVN1dQOU5DRWpRQUltM2I3OUE5SVNEc1ZCMVB0SUFROHJC?=
 =?utf-8?B?NHlYZkNhRGV6SnU0L0lNcEVOcUUxaDRaWnNNQTg1WktZNTNUc1h6QWc2UjZl?=
 =?utf-8?B?UnlJd0sxMEMza28wS1RaY3pVcjZieTIxdVR5QU9VMlpibm1SUndPZ0UyZ0Ni?=
 =?utf-8?B?ZmE0SW5uQWQzQWtpNzJtMkNrSVYrcjMya205Wm1BNndId3dCc0FRVHoyc0Nr?=
 =?utf-8?B?ZmlvL3p5Snljejl4Sk9VK3lHcEhWa285VzVhUTQzanhPSFJYTFlhWVJCbHVD?=
 =?utf-8?B?UkFjc2FFcW1ZeWcxbm9Kdm9jOU50aWp0VEFvTWFuNUYxbzJzZ2ZaVTlNOUg2?=
 =?utf-8?B?SElwNXdwSHFzYTEvWWtndUVDc2RhQU1HTUVra1ZkdWxzNlpGUHVmNUpZOWFR?=
 =?utf-8?B?SDBkeEVTb3cxNEZoWlJlZjBNVWl4TDFmNlJaOXRuVGtJL1pOeVlnNTdRdTgz?=
 =?utf-8?B?Z1lkcklLeFVRTDJLNkZINFh3RlYwTjFlTWg3RDVBUUNFSFFJS2ZGTEVLZlN6?=
 =?utf-8?B?RCtEWUl1VGQ3UHlRSmRodmZYQ0t6cmtGdFc3ejNpV0MrbDAzVzBQelZtMlBv?=
 =?utf-8?B?YXFlMStaQ2JqTnpyRkl5SUtHekl0SEhFWWVDTk9pazhqTm1PbEJHSW53dkxX?=
 =?utf-8?Q?DCAe2QFlaYqx8ECq3M84p4oBN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6279296c-6269-4482-8a69-08ddaf118765
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:13:17.8694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yumblyJck5XJ4BnuUMQnF+TUkh4SB+wMyyOdh7mbDDpS7aqSZWuDPyEQw+cnIWPHPS9xUVKyT8Cv4eT1RYCKKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10888
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

From: Peng Fan <peng.fan@nxp.com>

Define image array and GUID
Select configs for EFI Capsule update

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mm_evk/imx8mm_evk.c | 22 ++++++++++++++++++++++
 configs/imx8mm_evk_defconfig            | 19 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.c b/board/freescale/imx8mm_evk/imx8mm_evk.c
index d41db8d31d81b44b86a7aab5fa57d97d99e41a05..ecc20768cb5bc1e32c9c9f274eaa7f589c3ba6b1 100644
--- a/board/freescale/imx8mm_evk/imx8mm_evk.c
+++ b/board/freescale/imx8mm_evk/imx8mm_evk.c
@@ -3,6 +3,8 @@
  * Copyright 2018 NXP
  */
 
+#include <config.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <init.h>
 #include <miiphy.h>
@@ -15,6 +17,26 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0xead2005e, 0x7780, 0x400b, 0x93, 0x48, \
+		 0xa2, 0x82, 0xeb, 0x85, 0x8b, 0x6b)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX8MM-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 2=flash-bin raw 0x42 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 #if IS_ENABLED(CONFIG_FEC_MXC)
 static int setup_fec(void)
 {
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 5230f7327db6bb34b6ff84c0564816d0cc45f8fd..aba3772649cb278d4ae2654ffbf9de43198c3aac 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -21,6 +21,11 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SPL=y
+CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -46,16 +51,25 @@ CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_CMD_CPU=y
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_CMD_OPTEE=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
@@ -70,8 +84,10 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_DFU_MMC=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
+CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
@@ -103,6 +119,8 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
@@ -118,3 +136,4 @@ CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_SHA384=y

-- 
2.35.3

