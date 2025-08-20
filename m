Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF9ECA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 10:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C3180FA1;
	Wed, 20 Aug 2025 12:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="fuzplRlO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769128211F; Wed, 20 Aug 2025 12:04:09 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67F38003E
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 12:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vladimir.oltean@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0BQJb0iWhnIL3UMvOYuWIdPcdIrfKp9XWpupaAPU0W7lSRXnc1wjefY/0NnhlDWwRxBeAZNHubJiSoatuqA5XYFBuAgBFhVAe3YFY+KGSAJRbZcc0GM/kR1XaKt/yYaivaOe/l9n3czIQyAEbQheWL5OEPMb2tEHjRreW7YluHwrkX6gNUGKD5m2DSzb8ojRzR/+wNwQ8YiCXc6xTjl93x68jRl1LR8EEVNJ+6fORFiRW2cQotcmOy3fNXsX/mHvzY4ZyAQaoLJJe23x0pLr3ohlGlsgR0zbVcA9YPOouWWKShhMmFzHAWtvp/5GE3vqKdFPtOq+YvQzAttaSVRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBknXclNSLSqr1VrMEhWopvmVkw1AvKBxRng3cFbr20=;
 b=J7BfmtANxiQptiG6O1yC5GCOl1UZpjy/qRbtOEsS288gBBDwhlUhk1fZ71a2STU5VEJ+PFOdvm8RrxGAVyPmDpyhbM6QioydXEJTlulUTWjpOqG+aJVBtt7VQnau6/dWAcdacT348D93PbcAheEVeIQ6ECce42/tE8quQ4eilnSq+T+Ql2w9CBbrwQo81B7t5PczgklACnKA4YShEY3vsAKjQUgkS0zfQ77PBLV2AWpd6HcLJ0rF2MXWs+jJwXp1kfqhilkeHNBEM3Yk7W9Av1NH8EmJB8smodaVM+s0RnYjVpLNnoRt5Iq+VBrh1r5RMronN8xx+QzSSipyMyCp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBknXclNSLSqr1VrMEhWopvmVkw1AvKBxRng3cFbr20=;
 b=fuzplRlOLuI5L+97B0FaJMDDG6yCXAIf9myTI50OvjmBdj1TFTacHYf3Sw25qDL2VovhKsBNfnkdyJiuNnbrvVEI/puk3qQPB4x8OQwmruy9FnqA+Jc2p19sGc5FrK+AZYSGQG0yCmjJu34d535/c+rBEwA/wR+OPSwB8dEayeTLB+cq3nGCEKJAnc+q3/Z1f1s7PS9e9qQqPUxIBOX7TC9XReSlINdfgoUDBVkF0bleZnOhEgRkmfpbrrQaY/2TVmAO9edM2bM7ClvBPZLYpL7oFs+u70NwGV64FkcBamunSMCB4QKx/8j8W9NZdvj4PMQBYiaGTeuD/+J9INFaVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 10:04:02 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 10:04:02 +0000
Date: Wed, 20 Aug 2025 13:03:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH] fsl_dspi: set scaler values for CS-SCK and SCK-CS delays
Message-ID: <20250820100359.n3ujbqlkdm2z5xuq@skbuf>
References: <20250820081719.2351982-1-tomas.alvarez-vanoli@hitachienergy.com>
 <20250820081719.2351982-1-tomas.alvarez-vanoli@hitachienergy.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820081719.2351982-1-tomas.alvarez-vanoli@hitachienergy.com>
 <20250820081719.2351982-1-tomas.alvarez-vanoli@hitachienergy.com>
X-ClientProxiedBy: VI1PR06CA0185.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2e5673-0d6f-4944-e6d9-08dddfd0e382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|19092799006|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UKCt2RhPUEtL8TTwSW0o+5b5AaSQnUXFN9KMzvHwAsU8dAVX81OLvIiI1sAI?=
 =?us-ascii?Q?Atx4DHYQO+lmUp/SHEBpu8hF/dWho46vJ99EdU/Fe3UlXaAiCLt/x6Zxcx/B?=
 =?us-ascii?Q?ged0YP76wjmeAprin7+k9i4+H/HYLU5pft8/s+sa0KKYJS6sm7CuErG2Bk0i?=
 =?us-ascii?Q?ty0/SB5d5C65t1qnTLDOcUYH3AxRbycT4v/t83iRY/Ha9Wk19eFXQpo9ucyi?=
 =?us-ascii?Q?uRn76LY2I1egt40NPber9StO+3AMxF1SAogSkf0s3sv99JwZbHLMaBMXmF6d?=
 =?us-ascii?Q?yOvv0KKayvihTOGMK5YTI5m7aoGMb/JZWHcqti6ifdrqJs3ile4SJcGoErHo?=
 =?us-ascii?Q?bC8vfPEQ+NOsJR+C9ytNHIt8ebAWjc9unnnei6fKuyDnKtEnKml9d0OjPxd+?=
 =?us-ascii?Q?6C8LHC39ZLhEboS/HJCjgJNcaMkBKeVFI7kKehiw0CmXK2wQLpxBWrf13HqF?=
 =?us-ascii?Q?gq3NMloga2yK9ZA5BDOMj1Bit2qVJNup5+dQl2Svrqfk/XVS+rqJ6F0dh5kt?=
 =?us-ascii?Q?tc87ygGQT1hshqBuJYqOWi9g57k7/uw1ydh6qEhdG2CuAFUgLYObRlYlaP9T?=
 =?us-ascii?Q?6bS8God5Rp7HaB5YEGH9oIIRKfwuLSa6KiibYDtb6Fi7F7aWH2AA0UZUf0Ii?=
 =?us-ascii?Q?xkXRkzgLCv0iptrZpCWGYNx9g8JpJ2DQqSqSeYq5ZKQxod7fILIwnRehbJYu?=
 =?us-ascii?Q?f+JGccqCQ7RzYxgJQgX+W5wgR8jkZqXhltpbSzWs7c997m5rvwmBjT1wkESC?=
 =?us-ascii?Q?Ka/INDb5+Hk2cnf41o3x6bgd9sPMkjilJPK5f/+F7CACnK0vxnilqr5vH+k9?=
 =?us-ascii?Q?dkJbeIPbGzFbkb76KknLUVrOfrvXjfONcTTENqZcEsxodKeRBqDDTwYLruQX?=
 =?us-ascii?Q?XMPKkvSgwBl1O/S6J1GKAcTmg66+J+GffeU6FLxaeqr8oTPIePi701dyMgrz?=
 =?us-ascii?Q?WmRDld/mW+FPia2skCmkVC9GFfYDkQBzYyb7VIuje4BRBnLCNKNCC6xnN3sx?=
 =?us-ascii?Q?4bOX0o5IyGZyLJk/5mLOb1B9SGUSCdc/Vdf6PYKszoPtLe+3xEOElCsana1L?=
 =?us-ascii?Q?2CxvBgejRs9G1kQDpnMCfCH6tbpM6y4OPJJr8RhMsXi0TVeovf26F2dQj5PA?=
 =?us-ascii?Q?PR3R8mEfpgJcC0O0lUecGqgGtURt/tVQMPV78VJaVwqfshbjeN8G1+F92V/A?=
 =?us-ascii?Q?Gz/b9hww330E1roJyyoaoPWvgpwzE0++nsmqYF1mpCTcltYcEKGHZevSBktg?=
 =?us-ascii?Q?OcNiP7h71v9Kdqmpj9QtFHl1StDU46vfcsjzWdGyJdVdfIKP5iLP5fhx2D53?=
 =?us-ascii?Q?xwZMr+TOeRXItzMhhbGR1tF0Uakro9hbGQRyhD6fQWGndkbkzhEE8Sl7XGZN?=
 =?us-ascii?Q?s6iMTRc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7779.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(19092799006)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W5fSNg9k3hfUKQpciW93fUtTkCuHUwQ4V6LOz8wHh7468V9aA4XxACz5q+cO?=
 =?us-ascii?Q?/kXGULgG4K3iRupjc70UDzcsbBE6tsfdp9XG0Dnh5OvOPyHdTFHgsuEIbBFw?=
 =?us-ascii?Q?O/zq0bz8HPed1LAqBY0YLPgde2Zm9JOQQ+aqZesUBcrpHiWLMuVOdgLODQm3?=
 =?us-ascii?Q?IdqBo+RpY18xSBoccOJZXUv2zKUiavWXB9e8YTMXdy3jJTCP5NBSJ1V7jMb6?=
 =?us-ascii?Q?yGjVasaCOUj934dOlefoBJTJAcSU8oswO1fzkW7TpAL/1zsh+3ig5Ztb9GuB?=
 =?us-ascii?Q?0iU105999DMMfH1pizBvP/d9HnGKyvNorPYrkp4av6VRR1qV6XFZD4sQcENB?=
 =?us-ascii?Q?L8B3OXfHJDs5pz79MKFCwGAs6lx/0UrIRaYKbtaPC1oaSnxZ5elugbim1NUi?=
 =?us-ascii?Q?umUidhVOSs7E/JJrAoX7qqMjz+RlpvZxf26hnq0NdnPWe0db0Zoi4ZjmhUjQ?=
 =?us-ascii?Q?mrKxXtBCCWM/uj3fZ2efYnb8xVqo+LjohwTpMCv4PWqQ0ynX3j2RBcMlaqAd?=
 =?us-ascii?Q?Jc4gLkNCEqRtEUVbc81WODrnItvXBKbmDPfxdhVAtykaOZJNw/AzWPheCL80?=
 =?us-ascii?Q?JH+N1ON0PZUZt9W3XVF74tCDcPMwp73wenb5sq0deShyKR6V+tL7MeJpLtda?=
 =?us-ascii?Q?eOvgbwOt5wsNnReKJ0AHmL+PH3XhAXF/xI7Vu6N+K215tQ+k16j3F0gg1gEu?=
 =?us-ascii?Q?vcdQjnF0q8uYEjyG+H+rpsPjtu+X76cidgSSjGTX0rdNbkYk+JjwWhAVSeYg?=
 =?us-ascii?Q?aehBXnBccRoFEi+54ggGr6sR+89mFqOOB/Yo3tazhgT1xpi/9zi/e8YA6Inh?=
 =?us-ascii?Q?5IA18bihp4LGXgxRz3xSnOARLldqF3kWeOnHYCaUtsNZ5MYVNnG0pZkQkbOt?=
 =?us-ascii?Q?6JR/l+xGGHAertY13p07/c0M/hCwPxueGR7vJD/DG0su+7IM9r+1C+XGii0C?=
 =?us-ascii?Q?5SPRltkUku6WM76uQPi4x8+TwxIbtkMDfn4G4th20ST0medhUn2wRjUXCfsT?=
 =?us-ascii?Q?b/CAEIleX+S72Pb7mQdm/Py3icTdxwP291GAqKPDvsuXX2Vb+4UomRijUtU1?=
 =?us-ascii?Q?tbcUB4MMmosxyIpjq459ONUlapX6UvNTwoDO9QGHF8E2zYm70cIyYRshEGP5?=
 =?us-ascii?Q?5PxlFigH1ZiDPjEXwn34nWO9LXm0Wg9iCoqDTzHN/rVI4BisNf0hX7en8+jl?=
 =?us-ascii?Q?e0ywm7bWFlM8ThxAEC45hi3z/uSAEqm+96lwOXM53HS7/Fqlp6QOE5y0SgV8?=
 =?us-ascii?Q?QvTt4+4LCj9fJNaq8VyA7onHVueNrw2R5p+syY1R1cLrHBX/j0g2s4xnIEjg?=
 =?us-ascii?Q?hj2sUAF3/hxUflhP+o1tfh83Af3z+BwtgBf7F4uKKaP/whAIXi5bhv5caaK/?=
 =?us-ascii?Q?QUcXc3m+vBgr5xjDvY3FFI7jxYvOJRhQnLYQyKEHDk03vLBGEuzf7JbgTTgq?=
 =?us-ascii?Q?OINKtmbFlejr1skN3vQWry+L7W+sCcDuejv25/PnGBi2cstCnUKkD651QUyA?=
 =?us-ascii?Q?HIgjx7EyJXqofw0rTaJ8F1wVnb/Cl2r3yZyHqm6pQv/afVpkGqBMTlh0aP8p?=
 =?us-ascii?Q?FVw6KJyNdPtvGBgCwWk+MeSlsVeWzKCgpOJ8udQ8AZYZ7jYyPHYHVbXxp5sU?=
 =?us-ascii?Q?0pCcFduCSSv6YkQqaOVE6cSFkcHrrrVmue2JuUdZw0QYAgBQe1ArkPVy6y68?=
 =?us-ascii?Q?xicGVw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2e5673-0d6f-4944-e6d9-08dddfd0e382
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 10:04:02.1379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4n0IdbSzmuEsJqVf+aZVXZbBWD6ke8ZOqck2lFe/BMIxP/jlVvqB4LU9+Qu9/0Yet5YIj/k1jGt+F5rZ1OYgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061
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

On Wed, Aug 20, 2025 at 10:17:19AM +0200, Tomas Alvarez Vanoli wrote:
> These values were calculated but not set.
> They are required for the calculation of the delays, as stated in the
> "QorIQ LS1043A Reference Manual, Rev. 6, 07/2020" page 2172.
> 
> The delays are calculated as (1/freq)*PCSSCK*CSSCK and
> (1/freq)*PASC*ASC.
> 
> Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

You might also be interested in this related change:
https://github.com/torvalds/linux/commit/c5c31fb71f16ba75bad4ade208abbae225305b65
