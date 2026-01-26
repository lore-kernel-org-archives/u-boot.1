Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF17E63CB7
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B925883DFA;
	Mon, 26 Jan 2026 02:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gfPiSPO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A5B83E0F; Mon, 26 Jan 2026 02:29:56 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF3B83DDD
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVomhz0XlwycmzqVshPTQf84P/EvpscWbkB7VX9qmRTqXiDoYkFi+92xYg6zsaTCPEC8+isZ8rZxKY7GwaaXSyAR0U/+gKI2COy7/vKqrDGf4+LcdG5jEdQXaxBw5C0SwsRN1UdESm+jwlcYzMjZabg3V+o/xhPdZHt78QO8Z6LMfprDbNwmvJIp9oBG5CUxNyjcNuBwK9ZiOMVXiG33RJ5xVsBFdjg4muskiyE5eT36Dx339Q1LTVmi3Pw+TK5wsrWzkzk53gW/rQeT0s4Ueh9QPm/SVVlcDG78ezjCKoZKRKmvPJ6yJ+qwAFrwGW3f2TumkLxcYNk95+VZp7L6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TATmIWg8FTf8LL7MgJSRWBnsTzK7czwPG+6G5NkBiRw=;
 b=pPK6zTVk3zVNCzDoxbessXXBg66LcnQF8+oqnfKJNTQu1chCqFHLq3oB30Usnm7BhqUIEbF14FE/VDmn3xqI2hAsfykh93ndya+eUKd7cTT43x+bYg1mgthe0RxO3HoHb3cgYi+hspiPimfg/h4fSqkVHDTa4XUrBmdhbxHlB4394q4OTKXXFW4tRbZ9e8j91U6H7YUBnzAjY9zzRo/54H0Y0IheyMSRRHnXwfV6hpVi7qOW98CrQZ+hxcFQpCklyWiScYcnNDNiuWO8ZxLp3FnmTdpR8B/NDkYlwUsfEnhTcc8KRxByLQfmCIsEQlL59SERTmD2qK8dyTltXetNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TATmIWg8FTf8LL7MgJSRWBnsTzK7czwPG+6G5NkBiRw=;
 b=gfPiSPO/40nljBZqvUZaTmTcKxLTnHTLu124Ib7epEnamgnwCw/vpSCh8LGzWkC5/GDrJyF4Tmka7oatghHT+kVZ/+qiyTYXG8fnu/CxE52nEgay9sERG90rbhmi0+TC6/qBlYIrIRMHvEZDH7P+1RPx8fRIlefiQ+WlvCjxWfl00TCvgrD0g+O4LfQz9PWPXRQ4AvtEWbJ+EK+iZe35gYUxdnKBuHxh2hfSY467J15MFNCtpokf5h9+0jR+lQhq19e4nsanNclONaida8PaoGIoTa7L66lKJ9Jj1QO43mfnZf2ifVZGAfOZ8ZFGxNI+g7PFsPKHoPRXve4V1DEp5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB10540.eurprd04.prod.outlook.com (2603:10a6:150:218::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:29:51 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:29:51 +0000
Date: Mon, 26 Jan 2026 09:29:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 07/11] siemens: capricorn: add logic to U-Boot to
 avoid zig-zag boot
Message-ID: <aXbDjGfIgPGIc439@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-8-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-8-hs@nabladev.com>
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GVXPR04MB10540:EE_
X-MS-Office365-Filtering-Correlation-Id: f039a651-5cbb-4d73-f50d-08de5c7a66bd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3xqBCY8u+coTckm3uOXVyZJcS02NpiDr9FouQl8wmJ/kitV9KETU1LwwwNus?=
 =?us-ascii?Q?F61YztkXmQj2FJAemX0Wpku8g/fi/hLg5uGkHQAudiLxTcKGiJKit8873iJR?=
 =?us-ascii?Q?f09qdAuK4885EXRY3ENIWS19nS3cSi/vt05PFQCfLluarv2lStOC0tu4V8oC?=
 =?us-ascii?Q?b0NEiUj7gEUcagCghoFrBCHoOcIfpBnoPUORUxzcN1kbjHDJL6aoyDmns9g6?=
 =?us-ascii?Q?+J6A4ZMw104QzfJ0h8FpkQFmYk70Pzge8wJY2n87nrzJZF5LuqdffC9keOp/?=
 =?us-ascii?Q?YCe3lyIIlGYmsHxNRlbBqM6VuuyIXuzolDwGqc8c3U79cs+4c3JgI399CtoR?=
 =?us-ascii?Q?apwVKoqJw0C3C4rzGERJk2qEc3NYZvJSPb7VjB0DJaboRpFWMHZ6kuWcXKPn?=
 =?us-ascii?Q?19kLngsVIRfrI+fddbT8498D/P0SV0wliSjkMXfuV2xU+J3Mb82f85DaGYjX?=
 =?us-ascii?Q?n73VeTTo3y1ZRyaxTRWcUHLdX7bVMmdgE2irIE58GK8P40zi22MObgilyU9N?=
 =?us-ascii?Q?T5fIpxHn1P7Vu8zc52LMry3M1etoSJw1vwnYaTzi/eOQ6CzwRdznRJmvT6nu?=
 =?us-ascii?Q?6Yj+K/ZGrwT0YuxkAzwRwR0/2I2wSieU6EXhrKuyEWjWmVfLXM4OQCax6Yp6?=
 =?us-ascii?Q?0J2y8kxZKMzJC28xAKw5SAcrDX0+CD67QVqPuEVrNn9l/+7VMNgnSNulbTqQ?=
 =?us-ascii?Q?//ZxECq4Ar7DRcqF2m9iL+e6aogabqW56QYzDuvzDk5d97sdZWogw4b7De55?=
 =?us-ascii?Q?SuY4gpmjsZxu0tCPkkjJd9JURKFcUUEtD9JjHtZdwcyFlfalFxUB/lhl6WW2?=
 =?us-ascii?Q?qGaRUFOSugzzPK/C8R4FspgsXrAcPvHrVOGe4W+bJM8Nd95ePIZI44H4ysCe?=
 =?us-ascii?Q?4pO1SfMiuWiT4MbCd6Mj+GFGXbNo5HB5ug8mTsTJeF2gAx813BMZLHGAUR5F?=
 =?us-ascii?Q?ccSJktEMdOeom4HGcXCGYwDjV/SgVTkm9hG+vLutQ0XtqnLeZ+zpWtgsLYZO?=
 =?us-ascii?Q?xg/L9Fr4EYI2aIgtQ5fJE0c0pUk/gNe7hQyYPUqwMcM8gwC8Gyxx1Y+CZvaN?=
 =?us-ascii?Q?u6Cw2XAW/S8NpKPPJ6qSCm3mm1ZWWGJ+CHkLnQvQD2NTOsSZr9vGfCgPmRB7?=
 =?us-ascii?Q?jU6eWdhxGZkgtvM11L5hlBAlAF1byRhB4qcyc+RZT2BK2yL+5PgqpTaReRXS?=
 =?us-ascii?Q?2PE9UrBzA1o3XoH2vkjuhnEG/RrqWl+KoEK23X1L2c8mp6v6+dv7/2DWGyZE?=
 =?us-ascii?Q?KYxxOu5a+5kgmsE62ajPi2nxsb1XikJnrmI+G3X/D8nj72E+k7ZyWNoxvtlp?=
 =?us-ascii?Q?8sIeYOwWa0m4SqZ5v0wZ7dfwAnN2OazUzMo1dwPwykTXHwshpfGD/ZMP63fe?=
 =?us-ascii?Q?dCaFU+Mp7+JvfEkJukuYDLN8+a11wY0gyu0o7L6dEv+j9jT0gpXcT/kyjNHG?=
 =?us-ascii?Q?fBjt+2Zi6eutT2/9DG7RG7yIO2Gi8oUEbfNo5eNSmka+2vElw7FLp5edm1po?=
 =?us-ascii?Q?Ti7p61SG3jxPdrbBC0nHEPvmW6v8/P9bMJD6nbtPYen4W9FyVm/lDJHXV6fT?=
 =?us-ascii?Q?GBcxjN8Pn9f9y6d4C13hT/9XI1AkhotEYp8oWGTvBCLgAIhMWp7/4z/i8EDA?=
 =?us-ascii?Q?s+tSu7K43BYVh8PGs1Rqg0A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBeAVQDZ2AA2pQdFeQ61OtHHlrryd5GyAT6JscgRc5Sj48k4eFCusVGMAwbx?=
 =?us-ascii?Q?csQvhYp9xTdOwp83I2BXtoaaEgExOIk1d2bQAkjuVO8n81iRDow+9BAcYaOT?=
 =?us-ascii?Q?J6iY2K0/2nlMJSlx5Ch4K0nx6POBylG7jcvwfavXNQTahcd0X0Oj/lY2TfXL?=
 =?us-ascii?Q?LrZ4Ap5xtgYaR66A7KgZ/aVVLavxDSrwAKrqcxJcv4iFmOkMPAEZJshgSL1c?=
 =?us-ascii?Q?wOMXS/R09GhcMA+92S7HA4Px6W7HRtiG98lBKQCu/tG7I026O/r5COT7XJN1?=
 =?us-ascii?Q?llyPp+MMrVZirJr6vcIyxJTatGWlkcAO9v+KMJDZ9n4PajkUVIovZ1y5l3xb?=
 =?us-ascii?Q?tXhYa2O1YUhzGJH7O6XWX26ciRKQZdr21aG19DDEU16ja4WBpW9QPYs8xvUI?=
 =?us-ascii?Q?b0+yvO7GyONqBYh2SfrkczOTyxF6PqfQmRlTlAhWZsWMa3ttvo/XfhUGQw6Y?=
 =?us-ascii?Q?zDGT5fPG++UzXoXkH0bOp/nDdpfUbWCc9m3t7q52Ttcv/WQ7fYGt9FEyHRpU?=
 =?us-ascii?Q?RO3Q8FxXBP6FBuJ8PZZmNF1v3AmnxmwW7BjO7XUpUn/bG8IxOanIP2cvz8y+?=
 =?us-ascii?Q?+RrsV/Os5b/USFp/NfJl6RBHHf9TcgTjsdwYYsuDvDKrKRr8d5U3IvYSyiu8?=
 =?us-ascii?Q?Xv5OuD8IsmZslgmxoDmBoK0F10iN9l4Iu2d3gc1IG31rmmhvpLqD2LHCeSvA?=
 =?us-ascii?Q?b7Jr9oXn1ktTvhwTnqr2uARXmckw1UphRYLKFeyeXwRwkcU3Ns1u2cSqPn9b?=
 =?us-ascii?Q?jU+sppsYrlK9JY93uWTVNpz4vU9E9ztWm394ABI79DyE2AeiSltX7FzWmXIF?=
 =?us-ascii?Q?yTTvzAJRk6DHE42OfizzpaeOOhQQXfPpD9zTVCkjFle0ghOlTE/a2ZqSIgNr?=
 =?us-ascii?Q?k9mZZx/fUmeDg09JfbZGfy06pHGDAQH3K2q2JENHekWn8ZlDM6w7vXyTqcfk?=
 =?us-ascii?Q?EdT0MLwuTYE0eU2tRWWM8kMA8BfNl6vA7fgiEm2ygA1T7Ca2J/LjIE3CVc7h?=
 =?us-ascii?Q?PT7bnls6Sk95p3YrK/EbPk6zIz8qTh1+ltAT3HrcCo9bIumWQD2RnBwW1ACB?=
 =?us-ascii?Q?0rRGLE3ztvXqr40+6/NufEYDgcb67sQymbpavRULNDGW6O9hP3di38eIbgKU?=
 =?us-ascii?Q?veWL3bZHEtYQ0pM4MWl0r8SE58LEvAmIfyW1ZKy2f0ItkIzSJsklGJhm99dM?=
 =?us-ascii?Q?SKcBP6UtkIIDdXMn6NIhDgv8a1iE0K0EjfOoxxQCMOFX/9KNnIB0mNJmxRwV?=
 =?us-ascii?Q?Jh7yeqErxLW093c3bGy9pqeE10w33o4xUuvUJVuKalq/WUpQaXtHVQx93Mhz?=
 =?us-ascii?Q?+K4mlriuZnJhHpiGYVZPUlw1QIgqT70tQoyJ0iIrHK7TqcjR3WQ6m/yKeUr2?=
 =?us-ascii?Q?yS34PgIoHVwUgv0QBcxmaIek4/wVrw3VCn2hCbf6JS5gsTe/+H/rhHMPagdp?=
 =?us-ascii?Q?LkCisol6Lq4FDgtkNJUlixmIoVLyw0mHseW+HBH9t2RE5Dt52eOKWt/Db1JT?=
 =?us-ascii?Q?48I54GoQMr1dONK0xf9edc31TqIjmLcg5RC/RVqC47FeLSj7u/845R9bBPCj?=
 =?us-ascii?Q?pwevHOUTYkqLrRo+mdMfut9hSwRrazUlZGWmhp0qQ2L9RKn2yKFRKv5uT9WA?=
 =?us-ascii?Q?liNORNisJApHmz5yccvq3PbSKjwixLj6yRhU+N5olXdSF+1QRTXxHAtNipE0?=
 =?us-ascii?Q?kj2pTLNec2gqM2QPHiNJGKrNDgJSSZDnZWKr4pJKsVPBrRijPMIYjWl5qii0?=
 =?us-ascii?Q?RS8ATx6f4Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f039a651-5cbb-4d73-f50d-08de5c7a66bd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:29:51.5417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buJZs0JrT4/JqukiZFAWHLQ37IVbCAYeiNSKePEWEri4csj//XWVwqQ5Zncmure+ym0ghNJuqwSsaXvAQYaBSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10540
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

On Sat, Jan 24, 2026 at 06:54:48AM +0100, Heiko Schocher wrote:
>add logic in board code for detecting the real boot
>partition and set a local hush shell variable fallback
>which can be used later in boot variables for detecting
>a ROMbootloader fallback case.

Typo: ROM bootloader

>
>We use the local hush shell variable, as we do not want
>to save in any case the fallback variable in U-Boot
>Environment, as the default Environment is may saved

Typo: maybe

>in boards, which are downgraded to older U-Boot versions.
>
>And than the board code does not run, and fallback never
>gets the correct value.
>
>Introduce also hush shell variable envvers to value "v2_"
>so we can use them in Environment for running different
>versions of variables between new and old U-Boot images.
>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>
>Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
>---
>
> board/siemens/capricorn/Kconfig |  2 ++
> board/siemens/capricorn/board.c | 43 +++++++++++++++++++++++++++------
> 2 files changed, 37 insertions(+), 8 deletions(-)
>
>diff --git a/board/siemens/capricorn/Kconfig b/board/siemens/capricorn/Kconfig
>index fe230971e97..d6d1aad75b2 100644
>--- a/board/siemens/capricorn/Kconfig
>+++ b/board/siemens/capricorn/Kconfig
>@@ -1,5 +1,7 @@
> if TARGET_CAPRICORN
> 
>+config HUSH_INIT_VAR
>+	def_bool y
> 
> config SYS_BOARD
> 	default "capricorn"
>diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
>index 390a7b0d841..d4f26b6ff7f 100644
>--- a/board/siemens/capricorn/board.c
>+++ b/board/siemens/capricorn/board.c
>@@ -5,6 +5,7 @@
>  * Copyright 2019 Siemens AG
>  *
>  */
>+#include <cli_hush.h>
> #include <command.h>
> #include <dm.h>
> #include <env.h>
>@@ -29,6 +30,7 @@
> #include "../common/board.h"
> #include "../common/eeprom.h"
> #include "../common/factoryset.h"
>+#include <firmware/imx/sci/sci.h>
> 
> #define GPIO_PAD_CTRL \
> 		((SC_PAD_CONFIG_NORMAL << PADRING_CONFIG_SHIFT) | \
>@@ -373,23 +375,48 @@ __weak int mmc_map_to_kernel_blk(int dev_no)
> 
> void board_late_mmc_env_init(void)
> {
>-	char cmd[32];
>-	char mmcblk[32];
> 	u32 dev_no = mmc_get_env_dev();
> 
> 	if (!check_mmc_autodetect())
> 		return;
> 
> 	env_set_ulong("mmcdev", dev_no);
>+}
>+
>+#if defined(CONFIG_HUSH_INIT_VAR)
>+int hush_init_var(void)
>+{
>+	sc_misc_bt_t boot_type;
> 
>-	/* Set mmcblk env */
>-	sprintf(mmcblk, "/dev/mmcblk%dp2 rootwait rw",
>-		mmc_map_to_kernel_blk(dev_no));
>-	env_set("mmcroot", mmcblk);
>+	if (sc_misc_get_boot_type(-1, &boot_type) != 0) {
>+		puts("boottype cannot be retrieved\n");
>+		return 0;
>+	}
>+
>+	/*
>+	 * Set here explicitly a hush shell variable, so if a saveenv
>+	 * happens, this variable is *not* saved in U-Boot environment.
>+	 *
>+	 * This is for devices which are already in the field essential,
>+	 * as if such a device breaks, the cutsomer gets a new device
>+	 * with a new U-Boot version (and so a new U-Boot environment).
>+	 *
>+	 * But the customer makes a downgrade to an older U-bootversion,

Typo: U-Boot version.


Otherwise: 

Reviewed-by: Peng Fan <peng.fan@nxp.com>
