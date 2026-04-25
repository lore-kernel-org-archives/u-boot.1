Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D265FFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF82984277;
	Sat, 25 Apr 2026 18:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VH3NQFEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BEFD84105; Sat, 25 Apr 2026 18:12:38 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C30841D7
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from VI0PR04MB11842.eurprd04.prod.outlook.com
 (2603:10a6:800:2ef::10) by DB9PR04MB9356.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Sat, 25 Apr
 2026 10:50:31 +0000
Received: from VI2PR04MB10221.eurprd04.prod.outlook.com (2603:10a6:800:22b::6)
 by VI0PR04MB11842.eurprd04.prod.outlook.com (2603:10a6:800:2ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:32:42 +0000
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by VI2PR04MB10221.eurprd04.prod.outlook.com (2603:10a6:800:22b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLzAmOSnNjvd2XE+dV9iaVNFBeEKEpZCMj5bX5ouYjdhXzNFIS0+9+eHSMUiCBbqmxfgneSNdgbE+oeyUSMMCJmoXe76kYALAgmvADYg7Uk6Tvu1ypXgy5ywXIv9SRTXJ2HLf6RjKIdRgbJgPd73c0UvZXiA9JZ2ZBtcZO8EiiA7b8Hb7neHDGKoG/giekoEwbkk8B1Mxe9aX+IUPXrmTukqV/uj8ObEpgAQoOZXzRVY98MTkI0CtRJm+ywrrd8bODhEk0wMhrgMUcpcQsXtlTJFFyhPYI0eGYS7E34AEU8jyThhAlwh6zhqBKunqrw52NFAbI7l7PAhN0Z/q+yRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkJStm7y0AWRz0Qu+wkbg2daBYvtnnkc5tIen+37odI=;
 b=aCESC8UCnmOVnMcS5yW0gd2zYfcmJb4mLX5sGYSFM0aaUTRefhm52n/RkI8Zz0AM+Pm5yCQS1i9B4SHf+2sD71T/ZPF86xH8HpaxAUX7GPAgx3RLVk08R1lF5JYnkng7sMDuxYs447m3Mc4tPiWIC5r4Srw3Tl3ll8HihTqYhRnB3SiNyAYdPe2SisAaPz7Fb0PmB/jkyDIPjGBQJTzKBrTWPbsXFqUCfIwfMVunsC18YmEhaYNvwXHZBeql9qUtXfnX9pPmyR304lmai6mo3HLaWXvxMtKTSld2TuXJOtt5gw0Du+vMBXQhB26OLJAb6R/qoUmgpf5ADj3c6pPANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkJStm7y0AWRz0Qu+wkbg2daBYvtnnkc5tIen+37odI=;
 b=VH3NQFEfU2lgMMQj3pod2gOjmwWq9JogyWFwsjYm609guCTidZyBF2p4a6Hvmc/0ZCO0wSoAih5krNhAk+FHWAK8VuJ4H6WmxVXrcODxgp0mNJsS4G9AHUDD9Dnhqy7/cA/FScxruxGwkngCWVKgC/b6JmTsoyCV2blpAAAhJ6YmAmCXa99pZZjLjO+VxH5e39r7jILA/6K1YiMJW96q+P6vAf3xxw9mTBx/IXWbGgFaj/Anydnx+39wdpdCiW+gzbjSnJUHoChCJeMCpM1jmJ0qy0Jx4Mrc8YH0clQJaTRgk331lHGmNbZk0pM0/HS40IkQS+JbTBd3ZJb3UXEsLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:21:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:21:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:37:02 +0800
Subject: [PATCH 10/13] imx8mm: icore-mx8mm: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-10-07527be92e5d@nxp.com>
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|VI2PR04MB10221:EE_|VI0PR04MB11842:EE_|DB9PR04MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: c07ee783-d9bb-4d35-3702-08dea2583418
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: yWmqcERcmvEG6BDK73B0c7D5523e4U4FuiQuMB12rUwRMX8M8Gey2D0wbwjI5oQECmooWj6wux07Sr9lWFGZBrsIH8ncE4Prcb7cIZj05cUJjT/LJWo/lvifbduhU6ZDLhLg7QsAXxRzv3NUObTybo6CWXAaTEUOIz/IBcLa4OEdP/Csvue2gLIhWBPehTewzx7bKyaOLAt0ovIRY80EV6MMeyIBMbKNECxM+DtI/k7SjFY2DWe/gpQqfLWTo18Ib8QwQSVNALPNnVGYOVZoVVnR/tsAdDjOsINEebvFmUdbtnYF6qOwK6qQZmS0ZUFvNjUSuxSbptpd3pDE/R3cCfTHjWF2oxthM2lX9lmeD5hsQY9r+wAaOXrHUm9/GIo7+/bR5bZnGuBjTcp0ImtIk8QcSXyZ9Yq/YKCVaZ34iOuyDQd/qdtB4HQfpXEV7utEKuvSjypR97DvuWJoDKtipXoYJAyGESvgjkcN1Q6C7nxr5h+GbiGaNhVVeiYPjfZUtEmW+s4BgwWAOSBMudAbZ6iUQfyLgzVWCuSoKLJ8udz7C6KiWoPHlQZii0y9uzcZxQ/g02KHIyh4rj2WoliXdfxaAdOCJOlyBO9xF87dqsCkxfK2s+7LRHuBH5KeYI+FVxEyWQzIjURxkQTG8ycpcvdh1Bqm76g4vzd7EXm7vhC4Y+RtHwWEp/U2vCn8Yd3vlerK2EzApM1rM6ZAGna8V9zmJ/v+J5MF2R5kLbwf5GmpVdIU9kVjyYkP36b89dM/bR4sY5Im4UAABb6easFYQMHPm869h+cItzboeD5SijE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXRSNzlOajFlTDRxNTlOMkdTdWFidGJQc1lrZGI0Mk1jNmV5WlhlRVpURk0r?=
 =?utf-8?B?QUtweU1wSFlxTE1WRURSclIxVnVHZXE2ZjcyWmlXcHZodnAwME5vTXZzY2JL?=
 =?utf-8?B?YUpva0tGTEE0VURzcER0MC9USTk5N2pML1R1c0lEOEN1KzZFdEt6VjB4VFhv?=
 =?utf-8?B?TkxHZ1dIRU8rL0E2OWRkanRYeHhsR0VUUzJiSkM2RHcwZ3pNd0xoS2djZXVN?=
 =?utf-8?B?MWg2QnBrYzFpTzlXeExQckc5SlFOV29HbGNBNm5Yei9Mb0htUDc0NWVHNDRk?=
 =?utf-8?B?UEt0bjBBcDgwS1I3VXF3TFQ4MHlmRjlmN3NGdXJxZGNpSW9oV3dwc1dXb2Nh?=
 =?utf-8?B?U1cwbUQ2YzZSTmM1d21HUWFPdEdTdkdoaFpYZ0QwRDVqaWFLcDVmdG13a0hC?=
 =?utf-8?B?ZlFFLzZGdjdHM3FUMk1xOFFkU1loUDQwMnN0ZzVrcGpVdEg4QWRjZDRoNDlI?=
 =?utf-8?B?Q2tNaENLZjJ4Vy9SQUtKOG4vZWhrME5EajNGV2dtbXMvdTBxMk4vUzhSZkh5?=
 =?utf-8?B?bFRqNmg0WWNKdjhNVlkweHNmbzZkM1V0a0VEeXQxcytNWHMyWjl1cDVPbDln?=
 =?utf-8?B?SWVZWnErWlVFZDhPUzNkQndtbEJadVUwdXlpRWFWWExzay8rdmZ2b3Zsc3ZN?=
 =?utf-8?B?NnJTUHNabTlSbzBpLzJiVGV2VVJVSWt6SXJFc1lqZTB6QVBJZHNvT1lpZHlN?=
 =?utf-8?B?RVMxRFc5WWIwdWo1MkNUaWNNMG1HKzlFcnlhZ3ZCdmowdjYvWDJxMmpReXpN?=
 =?utf-8?B?L1dna3Uwb0pBZ3VHMTNQMWx0R0tXS3FZUFBRUGdSOTBHV2d0VVRpWEg4ZjA0?=
 =?utf-8?B?MEpTNVNwcDVTd0JUMUZtdnhwOGNuTGpnamFQVVZINzNnQXlTR1FCNkNkL3lx?=
 =?utf-8?B?cnVhWlZocVlxUUJJdm56c25UUGYzUU1UaUZFQ05IV3JtVVlvbjVrOWFPQVJU?=
 =?utf-8?B?MWZSMWdHRHRuTXJJSVFGUnc1OXdDL0wxS2lGZ1BlYVRxdVZOSzV6V0VoNHd0?=
 =?utf-8?B?ZEJNREFxdFR3YjBiQTZKT1FlWFpLeHJtdFFsODQrbkMrZU9md0paSnhqVmJI?=
 =?utf-8?B?TzI4V2pOQmhoeGZwY21nZGJXemRaeDViUlBhZDdvU1ZMZUtVR1NXV0FabklM?=
 =?utf-8?B?bGtnLyswRVByZllDR3RpUmxrdEFZQk8yTXMyUHoxODAwR1FJbm9HTmJhRnpn?=
 =?utf-8?B?RUpoQWVHaWFzTWM0TlpXYTdEYXZaYnVlclBZaks5bDFEdzVyT0VoUXZ0cVIz?=
 =?utf-8?B?bXRsV3o0d0w2eEw3eWFvNVRENzZWa0JvRjkrOTdqWEVDU2Vpd1VlWkNRYnV3?=
 =?utf-8?B?eTNhOWhMTzM2eCtvSWNkVndzS1dIK2QvdnNydkY3amxWMlN5R3FFM2x0ZXVq?=
 =?utf-8?B?aDJsVWUxblpqRU1mSHlXMFBycDJPT2J3RFVEUVlsMDZaY1owYVQ2QWJJY2J3?=
 =?utf-8?B?WVFMQU5GY09sMGhZZjM4aTNFTXVDZk5pRkgxY0JaM0FmM1dBYnFCWC9UZXZL?=
 =?utf-8?B?V0FvOFZLZDFKMjUvcHV1b1BuSDR4cStISFRQQlNhb2l5cUlnV1V2YWNzcFdS?=
 =?utf-8?B?ZENoMDduUVhZOXlFWi8rR1dGUDIrZlF1dFNUbDBVb1o0NFlxaWVod1Z1R1p2?=
 =?utf-8?B?TlVKR0ZFNnEwMjdpdTY1RmJMSkU0SE1qN3AybmowMGNqSHpIQUkyTEJnZk1p?=
 =?utf-8?B?bmlKTDdHOFV0WHZJRmRRbXNIUzNwRFV0NG5sRk9EWitvMjZXQWxxSkFVVTUz?=
 =?utf-8?B?YVdhZlM1a3g2UHhYUWtTblJhckh2OXBMdE8vWVdMUnBuV29xaUw2c2ZuQklB?=
 =?utf-8?B?MWY5bHpBbVNnWENSTGV4ekZEbFF5dERCNmVJQVRJM21CcVZxKy9lYTVNMFdU?=
 =?utf-8?B?NXh1b3hieG12YUJtYXdOTlU5V0s2d2tNck5aVzdmcDhNMlEzbXhnUFI0Vmwr?=
 =?utf-8?B?NXhVVUxYWHR2MERMemFab0ZFOEdlUHZ1cnVzbTk2WU1PcHMrZG03V1A0UXRY?=
 =?utf-8?B?SngrVGVMWThVVlMweEFLbEh6bWVqMVEzMmNsaTdTWkYvbjh1S1dtS1V3Vkpj?=
 =?utf-8?B?aEovN2dwNHNXUnNNVFd2cVFqQXd6KzlJS2RwM21xYnpHaHJWd0lPNS9NNTJZ?=
 =?utf-8?B?cXBzaVFyUkVFcmxlUW5ScGR2VW5MOEN4cVUvVFZWbUNNOTI2ZVBIV3B5TEdD?=
 =?utf-8?B?YUpuaUZnVTQyQkxnV1NBMEc5NURoemVzSDNaeHpFTUNZV0pGZWtyWnYvLzc1?=
 =?utf-8?B?K05yQUsvTThaOEJUL0ZRckVJd3M0eFcvWmZONVA5YTdBL1RaVnBZQm5BWnRG?=
 =?utf-8?B?ZG84eklQWWxIc2JSQnJGQW5mcE0xK1phVVk5OXBqc05INyt0UDZEUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c07ee783-d9bb-4d35-3702-08dea2583418
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:21:24.9192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8++8BKDEDypZhsUk4ZdQVsTBKqx2QYRaGW+maGWHAf5vpQ5BiHTlkXihe+dVLHrL7Hb836w9nt5pE8ewc+IMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-OriginatorOrg: oss.nxp.com
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

arch/arm/dts[imx8mm-icore-mx8mm-ctouch2.dts,imx8mm-icore-mx8mm-edimm2.2.dts]
are same as the one in dts/upstream, so drop the copy and switch to
OF_UPSTREAM by updating config and selecting OF_UPSTREAM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                         |   2 -
 arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts   |  96 -----------
 arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts  |  96 -----------
 arch/arm/dts/imx8mm-icore-mx8mm.dtsi          | 232 --------------------------
 arch/arm/mach-imx/imx8m/Kconfig               |   1 +
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |   2 +-
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |   2 +-
 7 files changed, 3 insertions(+), 428 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 8656100fea2..aa9437ecb43 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -873,8 +873,6 @@ dtb-$(CONFIG_ARCH_IMX8) += \
 	imx8-capricorn-cxg3.dtb \
 
 dtb-$(CONFIG_ARCH_IMX8M) += \
-	imx8mm-icore-mx8mm-ctouch2.dtb \
-	imx8mm-icore-mx8mm-edimm2.2.dtb \
 	imx8mm-phg.dtb \
 	imx8mq-cm.dtb \
 	imx8mp-data-modul-edm-sbc.dtb \
diff --git a/arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts b/arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts
deleted file mode 100644
index 50274540284..00000000000
--- a/arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 NXP
- * Copyright (c) 2019 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/dts-v1/;
-#include "imx8mm.dtsi"
-#include "imx8mm-icore-mx8mm.dtsi"
-
-/ {
-	model = "Engicam i.Core MX8M Mini C.TOUCH 2.0";
-	compatible = "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm",
-		     "fsl,imx8mm";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-};
-
-&fec1 {
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-};
-
-&i2c4 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usdhc1_gpio: usdhc1gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x41
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
-			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
-			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
-			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
-			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
-		>;
-	};
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-/* SD */
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
-	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
-	max-frequency = <50000000>;
-	bus-width = <4>;
-	no-1-8-v;
-	keep-power-in-suspend;
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts b/arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts
deleted file mode 100644
index ddac8bc7ae6..00000000000
--- a/arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 NXP
- * Copyright (c) 2019 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/dts-v1/;
-#include "imx8mm.dtsi"
-#include "imx8mm-icore-mx8mm.dtsi"
-
-/ {
-	model = "Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit";
-	compatible = "engicam,icore-mx8mm-edimm2.2", "engicam,icore-mx8mm",
-		     "fsl,imx8mm";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-};
-
-&fec1 {
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-};
-
-&i2c4 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usdhc1_gpio: usdhc1gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x41
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
-			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
-			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
-			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
-			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
-		>;
-	};
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-/* SD */
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
-	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
-	max-frequency = <50000000>;
-	bus-width = <4>;
-	no-1-8-v;
-	keep-power-in-suspend;
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx8mm-icore-mx8mm.dtsi b/arch/arm/dts/imx8mm-icore-mx8mm.dtsi
deleted file mode 100644
index def7bb5d37c..00000000000
--- a/arch/arm/dts/imx8mm-icore-mx8mm.dtsi
+++ /dev/null
@@ -1,232 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2018 NXP
- * Copyright (c) 2019 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/ {
-	compatible = "engicam,icore-mx8mm", "fsl,imx8mm";
-};
-
-&A53_0 {
-	cpu-supply = <&reg_buck4>;
-};
-
-&A53_1 {
-	cpu-supply = <&reg_buck4>;
-};
-
-&A53_2 {
-	cpu-supply = <&reg_buck4>;
-};
-
-&A53_3 {
-	cpu-supply = <&reg_buck4>;
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy>;
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy: ethernet-phy@3 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <3>;
-			reset-gpios = <&gpio3 7 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic@8 {
-		compatible = "nxp,pf8121a";
-		reg = <0x08>;
-
-		regulators {
-			reg_ldo1: ldo1 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <5000000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_ldo2: ldo2 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <5000000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_ldo3: ldo3 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <5000000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_ldo4: ldo4 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <5000000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck1: buck1 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck2: buck2 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck3: buck3 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck4: buck4 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck5: buck5 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck6: buck6 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck7: buck7 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_vsnvs: vsnvs {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-		};
-	};
-};
-
-&iomuxc {
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
-			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MM_IOMUXC_NAND_DATA01_GPIO3_IO7		0x19
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x190
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d0
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d0
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d0
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d0
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d0
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d0
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d0
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d0
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d0
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d0
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x194
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d4
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d4
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d4
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d4
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d4
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d4
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d4
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d4
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d4
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x196
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d6
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d6
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d6
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d6
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d6
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d6
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d6
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d6
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d6
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x196
-		>;
-	};
-};
-
-/* eMMC */
-&usdhc3 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index db138a8da34..00b5963b30e 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -115,6 +115,7 @@ config TARGET_IMX8MM_ICORE_MX8MM
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 	help
 	  i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM.
 
diff --git a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
index 544fcbf5d68..537eb496a3e 100644
--- a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-icore-mx8mm-ctouch2"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-icore-mx8mm-ctouch2"
 CONFIG_TARGET_IMX8MM_ICORE_MX8MM=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
diff --git a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
index c27bdaa15d1..db90657c2bd 100644
--- a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-icore-mx8mm-edimm2.2"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-icore-mx8mm-edimm2.2"
 CONFIG_TARGET_IMX8MM_ICORE_MX8MM=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y

-- 
2.51.0

