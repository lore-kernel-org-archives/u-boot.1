Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2933ECD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 04:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13BA84825;
	Thu, 11 Jun 2026 06:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LiHOR/U5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0778486B; Thu, 11 Jun 2026 06:12:08 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFC280086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tU9MutRF+1yn1uPBMZ8Twa0zZbb/Na77aXqo3XdqNKdqsBn6GSsdf12I2gSDU1zd47NAwAZKJKNNKf9JDDDhtpppsPMGmAaVh2+hMQdv7YvLJoC0qlVMdVAStYA8nUQYRF5drkufvkK3zipctK3FD4CIpzlYy+N61U0g4KwlCsjwzcu9nuRySK8SUV8SnLNmJhfZs2i/yjMdngAx4AXoDw5uWxkaMNXPHxn5pOAKktwErNjsOA0FUOEn0EQhDXsmqZZGk0aHzilKFRfE8JtPJblfGcBNDcE9DBNNic0klcXoxQoBUEBTN6LbGo9MvtkXn/B2yfpndPupYalqgI6gaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIHoXmTV28VgnQdz/E+LzEMehcF2X/pKSwdXJLaLohE=;
 b=K4A5jAAcJdFf+xFxW41yXMN52wo/2pFuTz1xAl146jQDqC8RODe1Gjy0o/ZQrgCIU5n3iQ7bLlIIzKmiu1mTr1LP7H6ZKTrjS/XQ1poaIeWqNELxU+ooKDCnwfqqacBtpVUOMpMv+w1Rl0+56ei45ho/R9U4+1rNRZkzkOyN5HIwug2kPnIHGYmNCn++j5XE0whN/Vt24tUp+FWjffC4qLx2H2rEt4LN0WHp7iVQ2mfHfkxEro9q6uNt7XqAnG6bbROrzSnbWeJInRKER7x7IcprOlV0Sp5CY7nfK1TSGRL+Akeg5k1iIHcekkhYyXwlsccOzq+RsGgvY102tGYjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIHoXmTV28VgnQdz/E+LzEMehcF2X/pKSwdXJLaLohE=;
 b=LiHOR/U5wK3tqHV7GPClk0BEi25hBbOPAJ/HPwEByqo9mA51Hxap8x+6KBb+Qa2sRFzfBtChbnqqYO+BHBYTfe34Nvt8vNGSbtot+Nk3UApts+uT4+OJ9S03MoQIPZmRfqnnt0DVPJmxNDTf7MRgnHaJZRnl3WTdq7TTZub6oM+PKcnNKVjTDOOiIe8/0UqS7y3VRhXW4niD9Q4zO6PkedDbJpaOXhnQYsqeGFpQMIzdoNEZSN7W4BwQi1I0XbO4tgeXvVnH+LIyyvXpxtFvScR0nn3cfllxOV664mG4MsXnE6kMqYQZx0icQd29NmodWZZNyeUEVkpKbbBblYgLwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 04:12:04 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 04:12:04 +0000
Date: Thu, 11 Jun 2026 12:15:16 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v1 2/3] mx6ullevk: Move environment variables to .env file
Message-ID: <aio2VE81YCeaiwVR@shlinux89>
References: <20260610133336.15999-1-aristo.chen@canonical.com>
 <20260610133336.15999-3-aristo.chen@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610133336.15999-3-aristo.chen@canonical.com>
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e977acf-97fb-4fda-525e-08dec76f9870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|19092799006|4143699003|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: bFJ5KUF15Vrdc8q7mKp2NcWL3e9f6lc7GkrneCepS98N2Ac4vU6X0Bb2PAGW6HIAsEMrVher+xEY3dRNKI4w9j+AMaKwkk/5BqtuPMrIjOaE1nO/msEfgMf0fBaTMg3BmeYitIyCHF2S8VBkpnXI1d+19ivCGGzCBMAA9GCxt8hVn42uzojDkNpT5NAKkV3tKLdn8i2uQyRoqBSuFvA9VhAk16vzg0tNquqQWsmLXxKam9U6nJvN8Y43c8tD3HRHyyavHEkgkLum/V4kR/1gSdWNenVTukIK4THjJof444jVe6q/WMaCyeb5PggbcxPKCyKvRr7B31m4X0hyCVHqc7uiWW4QOoVvfEn22F6zKfAJo89oEt5CysKTyaU8JaySTHsTRSHhIS5x/yQsWYe9qnXoL6PM5OU+if2GDwxYPxDZh3amUffstLtqu0roaEQdu68D2ReRxPe9lZ+Px8jpG/b+Zb4h4nisO2OMQqpLxDhhB8aKeBKP4Tvhifk4sdUHETOmEOEFsP6GHCiuf1cm/bwszG99I3tMHVU4ubOBlHudoAr8KkXO0nzTNhw9lTuxDXrUMXPsaGnjmoMLRYrpbcxd0Wd0xsQcfjAYXntnxFyHCYix8MYi+q7o1qZpdGpmRBVXXjZhWmQf+0XJhmEDws1lDk8ySn4sALknHylOX/EGzgQBPqgKl1ZZCANY9lGk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(19092799006)(4143699003)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUPL2+frdk6F/8rw3cxd71gUfcgwZXpkZ4I9rCmzUEgaDMontlkaVyxLV8V/?=
 =?us-ascii?Q?mz4UpzcrZCb2UeJAUt+7Huuo+UHzr1AMW8VNK971E5yBpdeUIR4L1sieClBY?=
 =?us-ascii?Q?LnNguAytEu8TCtVZy/ibS4Oen3VbyRZU75JOpmwVvvVcLYz9/jYI1fzqINQs?=
 =?us-ascii?Q?AOFVmgCDGOEDKOkp6yA7wUcOo+Ken6xhzUsr8l6o0pz0g9KJ5Gkx3LoFlR7O?=
 =?us-ascii?Q?NvuRib6Q7flENSrvNRUOpRLwjJbgNxwup59XAzsR+5XQcSC3L6jEzC0WuOW9?=
 =?us-ascii?Q?0UqpBm+5Ytq64D6XkYjtrT4jHkV6z3077CznLm3O4XOvC5pqnn/xPtcpsWDn?=
 =?us-ascii?Q?ARAkl+r+tENn4GG6UwH4BPI1sC0JZHXIizPjd2wah7bfRq0ayDOUn/SHeII/?=
 =?us-ascii?Q?FGeifQmmi4ypNhHrIGQVACz+N8xM9EmhjbV/wczfNvBUEmnQAFsNr9RiaRHa?=
 =?us-ascii?Q?B0gl+RWcvsy8eXqni23nzZSIeeL9hQTdQZ2BThdKaXYostTH5risY3IOZXiN?=
 =?us-ascii?Q?pjVLNVsWEvW9i5GIMYMpDsa2XzO9qSRWz83A1U7SLpxrypcYJS3VRDFknBx6?=
 =?us-ascii?Q?VUjGj23dd83nXPTR83nE1lpwAK0StP18AjfqdSYgzK7QQ86qnh6KxBVT0G1R?=
 =?us-ascii?Q?VugxjvISEJ7g1Mxp8vYcRDVJIhe/wWYc9flfo69BVadTzs8f484gB8iyT7+7?=
 =?us-ascii?Q?cXcFbBReGaPCf5i3MwdVQg8FWtV6NAihZmgCZ2PJxqbW6V0YDfOTKXODMIAX?=
 =?us-ascii?Q?eRceMLcONpsSwKA4P4vPjgOdOsZzJwUiYkoOUGY0rY8gLzPA0VRn1njcLl+G?=
 =?us-ascii?Q?FcrubY2g4Wix+qVz2c/p3YkIRGtTwiwd1yexCevzZ1+smTIC0WsHOXU/MDwG?=
 =?us-ascii?Q?tFF3rg7riVFvwb0IfE8yTmGeWppGDinNH2OxBD7Gj7Tz3hM8//y87H3YFkAD?=
 =?us-ascii?Q?GgeTtqeuYRIoSkmC8K920XK+Pa5a9/ivmcmci9ThCgURP9J/Vlfx63Izvgxz?=
 =?us-ascii?Q?2yq53TsxmyYDNZYaoFCfyDe561XrYbNLDVNQqfLCn19uUp5NyDMm1EJVGH32?=
 =?us-ascii?Q?h+Gy3SlRsApyxgANe15PD15Kyh6Z9KEYyVVa7GUrvVbiNvqo49CEWqkF/v9n?=
 =?us-ascii?Q?bUTPpiu9nfTCB/lfNUoJcur8v3AmotayNRV57fYWpXxFS1TJa2Cd7W04QTCs?=
 =?us-ascii?Q?eYf4h2Jacu4x8HVIIQKAqzZGRhQlVRiTy/91jnhpWJavuj1AZ+7s7WfpG+wy?=
 =?us-ascii?Q?YL1Gu6lgsSUJ6mYYhRKYPgpIAIpKyBZH+H2Zm9VaQNYQIBPu6N5UsIy3OtBU?=
 =?us-ascii?Q?PcaN8NM1hizzBi3UQDRjKALUtlYV+Vk6BzozErRtiNfrfv6t9psgjFvboRGS?=
 =?us-ascii?Q?CWwdEHE8NvIRrONH/gtjestNStjRgBRqX7Ihg+E0R+MB8TFOn49OMIZLQ+SC?=
 =?us-ascii?Q?iCoX2yLTydFyoIQHkmep9fSBfnYIXDNs9T5v76+kElLY8Lz4If8JuThEEx/w?=
 =?us-ascii?Q?93y5u1F5fhokRFRgRtL6Lvkt37OnzSeLxeefGhNZT4mPYl6MblijInlxuI6w?=
 =?us-ascii?Q?P+2rfdvSKGpu06+RTMmaCual+knufMcrErRgKDCP2aLHYAC2yfnuHkt8wGTI?=
 =?us-ascii?Q?fCSZMoO9F4TJUrGKzQQQr35PrjEZsWA0jiAOYHsjl/n1ecTGDnxuvzKfgFcV?=
 =?us-ascii?Q?ypO++VSPeA6pleE3u9nWS0lw4JwF9rPGzHAaXmNe92rG3Cr6cbi05oCMVUdZ?=
 =?us-ascii?Q?XqN+yk/T2UbQg8qqWLAkdpxTWW6Jq0NmANE6zpXnDuJDeSCZcqrk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e977acf-97fb-4fda-525e-08dec76f9870
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 04:12:04.7460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCY2e31i9dv+HRvak92DJiZwbjoi2fVkn//q8B6c66wrubffPsr+74T8u789bR/76wQVpNeDR4OsWqN+vPLbsTWcbNhdTyF74Mhyzx82cgbdE53DBMo5ncdTSzJEAsPo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223
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

On Wed, Jun 10, 2026 at 01:24:23PM +0000, Aristo Chen wrote:
>Move the board environment from CFG_EXTRA_ENV_SETTINGS in the config
>header to board/nxp/mx6ullevk/mx6ullevk.env for better maintainability.
>The file is named after CONFIG_SYS_BOARD so it is selected automatically
>without setting CONFIG_ENV_SOURCE_FILE. Drop the now unused
>linux/stringify.h include.
>
>The generated default environment is unchanged. This was verified by
>comparing the output of scripts/get_default_envs.sh before and after the
>change, which produced identical results.
>
>Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
