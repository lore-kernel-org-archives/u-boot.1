Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAE4C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 05:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A505E805D7;
	Wed, 12 Mar 2025 06:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AHVrcKc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB431807D9; Wed, 12 Mar 2025 06:39:10 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2374F801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 06:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFmGjLZZeUjWqw9AqeY3JqcvSetL9ceHcxRCxP3A9RDB+22hs4ZCqT/zjRCOfZvZ+dF0hjY+NFua3EyAF3JDW5XXiSJ543uK7h4MjAnZbPegvzuKYPQ+CyD3SScRZRVirh0GYhs7CwhcxK2tfY/uP7ANyWpSyCdGf1Xsw1fJTaf67TF4YEr1BTF39JdO4O8up7RsyjJ3KZXoKRrWvYw8F8fM9vk/yGIFP38HvaSPu8svGbW+TEpJ9PlZuvioRZ8WltOQGkiv35RXxESv7RSBpl4OWoeX+FTUJ/gDR7j3+uz12i5grUPXDXxQvW/MKYkT5+HgBXaj2R80hpHX8vaz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyigIKotok6uBJX7zCcaqeh7T3mPCsj/of9i6H5JNtU=;
 b=f9DvuBLRxAaH5q9S8znwqxUCCVs4DIKrsUvFtIeCAwgYBbYk9EAjLofwM2aeOtJj6OEu4oOmIrtZh0EwZ4rOHmhkk6J6Zz3xlSsU8sBs17elyYvSFYyq2OpNqPtpxOVdkw2jrM6pX6+5mECpAi3aB2ezaL7Njssof89QOyDykOo8PJ1QZLcP38d5kcQ7yPNxshEndLDZeqU5RYj3kWk2brx0HakhRL8HNxWEge+R/suTonGsmgm2SqUq9ZHmD6gK/9z4n9xFpx3M3/Un4jNrXRlaNpawNMmna5DUbJzI9K5Tq1f7AzlB7dc1FAv6TDWBoZ089KLNDBDeqQ3Xb9Ev1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyigIKotok6uBJX7zCcaqeh7T3mPCsj/of9i6H5JNtU=;
 b=AHVrcKc1cfvGBqOWKVHqYBeo9PD/umsR3/EimT8wstiwue0oDm9milnjfLyMegYjtkogsbxkikYZLrvMvx+NiAuODdPBk/XMDHz07FuO+oJAr4a7NyX9xP7ZtMuY+tErU+1fyX7xYkvKoK4MOm5SXebDw7cjrXZMbxbxZ+g8E0U9fhuwHKgrOYeYUkX9dQsYIfxUQhdBDxY5a9b+BpumI0GPEA7f3hN43QAB0LfpkXYEcX02Ro31ZVuXZqLyOss0UTvLxj54DDjsoW6UhI6/+J4AW9bFunt3uft9EW6Sy9Eg0jy6y2+NMZPpQ9jZCtmLvquQXJIMXeC82TYixkpBOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10939.eurprd04.prod.outlook.com (2603:10a6:102:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:39:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:39:04 +0000
Date: Wed, 12 Mar 2025 14:46:42 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH V2 08/10] clk: imx: select SPL_CLK_COMPOSITE_CCF when
 SPL_CLK_IMX8MP
Message-ID: <20250312064642.GG11991@nxa18884-linux>
References: <20250312003041.110023-1-aford173@gmail.com>
 <20250312003041.110023-9-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312003041.110023-9-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10939:EE_
X-MS-Office365-Filtering-Correlation-Id: b743a18b-c321-43aa-32c1-08dd612832f9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?loqrxqEXTkRigc2EmhAkGKNmIoalJwyaueH8P8RKmyfP5HIULIIvmvj+Xxz/?=
 =?us-ascii?Q?vFz6uenKuJ+yAl7rz1FxJ677B7ges/TdQ2IYva66kM3KZiZcPC49SyWW8W0p?=
 =?us-ascii?Q?n/L3/65fYkNVYJn0AjvARlBcpr1PreNTWxSD8LWq9zJNvc7GK1EkIkETyaPA?=
 =?us-ascii?Q?oTVUjIu/qh2BS3DIYg1YVptmDNWtQkG4/MRh5tENpIpYKhFdVcpIOjcVxebA?=
 =?us-ascii?Q?uQdBb/acZVTPEyvvVTGFZpT+npTgGJ1yY6sG3WHdVN5B6OmBlOLoeRsfR4qT?=
 =?us-ascii?Q?rYWrIXUwFjm24X6XpvUbUcXcEl28uKs3oWhEedBmdVeiPASOZZ1Xm39IrGsj?=
 =?us-ascii?Q?hqtJb/pygIX+BeUrPdPTSXuBp+Icy0WP46zMc7S1Rg6Oeosl0TubcejHXqP2?=
 =?us-ascii?Q?egsUKpn9uBUMBXyEhf+gU/zRZWgFjp/yMFDQpouZlqu8bwDSgDyKou6fn8Z/?=
 =?us-ascii?Q?aW/mg/SXPsxI/dA9eFUuqQcXCw4NYkDMo1NypsbFiZ6BLcbWYqC5jis3/hVQ?=
 =?us-ascii?Q?Lehw/KeD+WvQXA34UMjPbHMMPQLPAisym1bVb44W1pPXvesrKJ5w+9gQ2t4l?=
 =?us-ascii?Q?8qA7xNtuzuve5obItPibHNDhIEsXJrOCb1O937m/caFEitsycosbZvSttmEC?=
 =?us-ascii?Q?ReRV+ivcsNW49OZriresn4AJXykq8Np/Fuxbhk7mhfVT8BtvOLMFwf5mNwN8?=
 =?us-ascii?Q?NCuZhzkdBRN3MzJf9IBT/qwQYk3xTB9GuPvlWvMd4w7oZQbHipX+opiSj80O?=
 =?us-ascii?Q?knHAbIevHWhgxxiWchV1OGMiK2K5FaOWADxHqOjrkPyyqOcgu7DietxZggKP?=
 =?us-ascii?Q?nCPHRPrf4WvKsHVMpniqRW4tVtpxSm7FNgRgyuqwHZ5rWFr6urjqy3zrgzFi?=
 =?us-ascii?Q?PGQhQhvoHY1OHH1EAXZhg04s9W6uA97m0xYDFa2o7Il7eDjh4AUvSRev/u4D?=
 =?us-ascii?Q?Wi04zuL0ZqHWxJvFgRk3ZLFznDWLpjYQMePRXNKMQunTbqn7WGug5UL9++c3?=
 =?us-ascii?Q?k0HKfhNGir1I8F58YTJyQycenqfwxjN+4g9IMaFdibQNAArZqZinMaoG8sL8?=
 =?us-ascii?Q?UgMgWj6VlTzlVfrZxnDGN1AqdfhRjSGGHRmfGWUkA1wPVMauNUTXxQvdVeRE?=
 =?us-ascii?Q?iwrW2wfRgR23i9Zzg+8DIsDjSkWO8+1GK64bTPxkHBsSAL9C6BCnTGUEL7YG?=
 =?us-ascii?Q?TXAn2413KuVHnLtSZtmjTbhhWdCFx4pI38s48D3eITq79x4NKMJTb9yB8S2W?=
 =?us-ascii?Q?LCEsBo+MxRyr890/LJNF/RrE/5fS+Uja3PGcxws34aiypq6I/jQiTl7+7KXv?=
 =?us-ascii?Q?5fBrbHF5ZM4Nvnf7XNIo0G1fM/MJwuUwRfFRwW6OBKWMw3v4kMTlTW4Rms05?=
 =?us-ascii?Q?E5wtCCSX8koqxacJpre+wKDdzDxS3AHs4vYDrwNxoWJr4hB8GD//F2WK0zoA?=
 =?us-ascii?Q?v3fE86NPeuS88tg1WrJCEakYtgLaD3VH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6WEnEQaP2aLnKJDZhWBWjpVHwJgQBN0rzH48ZH4EfIbcOGnlChE0DtiVDr+X?=
 =?us-ascii?Q?uKBVM6Cid9IEWhuAitc9pKqptRdPCKV28cghjwOJpgYYBJ3t9B7xze0t8hFZ?=
 =?us-ascii?Q?WdpI08R7jG9IJ488uNKdOguLhwv6RQmhs/V/LK7SdTpRtHK91syjWhbnqBS+?=
 =?us-ascii?Q?+SVJf3if+IH7MCsLYxyl8Hl+XSUjuau1Rn9+gNrkRMbLFIngf5vSxwk6fenp?=
 =?us-ascii?Q?u7pVlHQWe2J9l16DYqcnjV3HWkrXEqDy6/b2Q7gMI2fHMa2XJ3DaYx5nW2Yo?=
 =?us-ascii?Q?8i90/2n1w9pb6llIYJUYECIvxXQLLDPfFMEGtVB+TjETrr8cx6xV+pe9pGSJ?=
 =?us-ascii?Q?7d+bUPFq3Bj7JuFI7mfBRsQE78o5DtZz0YQWDuTI2B2iEVvOGd0fDMGv8cXH?=
 =?us-ascii?Q?mPnv3XsqnP3BF+ufgxF0ui88y/FMv86Lgx4j542KGTqGW/9CCNG9Gn7rp3Lg?=
 =?us-ascii?Q?fqQ64oPletiG/VZu2/xBcuMoSFkfGDZ6SJF8IwOuGqqVAJkkvQrxmCiF7QTC?=
 =?us-ascii?Q?okkQwWFaX4q9ZmebPa0PAdYMjBBJ5lSkqC6dgfxc8WOvKKlEg0DF9DrGUQKc?=
 =?us-ascii?Q?yTo8nEsBgNZwOlsi3kFINMmDXdBAC7/USbAcFI/ZI8G0NT2C+2t5dCTxy2QM?=
 =?us-ascii?Q?YBMY5/Py7bsdI/6+aMT1h9bQeZX+Us8TLUcHH2i4BQIWEWBvDyMvE10QPr4T?=
 =?us-ascii?Q?C8b3Dqk3zhXR3kbLtDbyYBsCNImH8cFklZ/uBDsyuLNtpSWCOdaEOIj02hQ9?=
 =?us-ascii?Q?OX4uWa6OQktPsQZ5JCMCUp+0cYHnpzPdxv0T6jtd8vItEDrLsjmy7YJ7gmrG?=
 =?us-ascii?Q?LYuooYbKkQye4mS9SgpCqpgZqirXXgFhkx/5UR5dQl4n3bja2ed5rkw4G8BV?=
 =?us-ascii?Q?NM3kLCQjL/W5ZH862R1rcgFn7TMDhie6+YcjiRIj7yMcqoi0WFznfLGfAK6B?=
 =?us-ascii?Q?gAMJVnHB2dXPBWnecjqhilwnZkgPt22HQhpCPDkXV9KSjhhzx84G62ZClsWR?=
 =?us-ascii?Q?e4+oGaryRCJTkYSkxciCIwIe6s5+HZKqXyxgIlGuIDxVonyhDvksZqrU/Jpd?=
 =?us-ascii?Q?OGWT56Q0mYHSJaAJtBGx2shv5yS6SOOXl7JAMrIn9n5fhFb2MLmc3ZAGxGoI?=
 =?us-ascii?Q?mq73FHg0uAMIBtbCDMl7EEkbhBuAhh6QMwebc6WEZZqWn73dtZLpHe8rdqib?=
 =?us-ascii?Q?tmjchJF9H0WJMzO+pqey6XD50M1mVj8qCv3QdAcOT6TUzAxEpryaqUrWHA2r?=
 =?us-ascii?Q?x947eN1u7yJUtNK6EzQEGh8KWcs7FE2ER/tNkauN/Dp/GdIgcoWxyfV4UcLm?=
 =?us-ascii?Q?+cMhB20IFOC/mRBlbPiFwfIyO5Ak0IKdaGZDqcNhQhdzsSlRphrLcnSQO45R?=
 =?us-ascii?Q?1jaNmT/fqFGi54nbalyG61ZSY4P+dK9KNsodYx4uQvHINqDw+OsMs3CIxmHK?=
 =?us-ascii?Q?VGVaFJiisnQyDcx3CWaJG+RevUtWIHCb67UUUfqWR7VBUXc8O5oS/fahtvXu?=
 =?us-ascii?Q?xYBxjPWRaKKqU2XMZV2r4+RZOeJIlWj88dV/jybnRYnyv9++TdYNLhP9g8eH?=
 =?us-ascii?Q?zJBcSw9+/HGzJ1PVVLiROFgamVeDJpJxY/B9zQci?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b743a18b-c321-43aa-32c1-08dd612832f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:39:04.0317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zsg7XfDbOIaDlwzvdLXqtSyquW7ykrfIgJffXn2PbQclRHfkfrDIEBfUjCSZ25KMyUkfwhgSJN1Zfgntjw4Gfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10939
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

On Tue, Mar 11, 2025 at 07:30:28PM -0500, Adam Ford wrote:
>If SPL_CLK_IMX8MP is selected alone, it causes a build error.
>The clock composite is required when using the clock framework, so
>select it when SPL_CLK_IMX8MP is enabled.  This is already being
>done outside of SPL.
>
>Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
