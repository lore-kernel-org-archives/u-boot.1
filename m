Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C520AD41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A98E83D90;
	Thu, 11 Dec 2025 11:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k8DvLvDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754DA83655; Thu, 11 Dec 2025 09:56:45 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96ACC8352B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGOgNDmUbAjpYbp21Gul8k2AJ8UkfZfAc5KT0o7VPpRSPjZAsYu+c12rDyPh7b5dujMWt8edsguJ1z+oRNOulTEBGkMZXGG3202I+HMW8oSXuB4s1Od3sF1nz+jFa+YGmeCKy/83QjEv2a59mYJV0VeZl4VMEQ8B5Rgkwgk9gVsD3R8UOYccBoFT8M1ulpyCyLZ/765a//i2aiAbNQgMl1LEvNhCbWBJW0zWZLhs03oOy4zkh4ptWGNUDPiH49+6+8hX1k8wYwXXrs/4cdoGvQQgOgc0FD7EvaW1aJyuQsbQH7Sais75QkF34Y9pc/t/eMKYLfDfDWCltReLqRISsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZ+84wApvEN6xwXMRQO4ytG/gXGcmSoIapuZBBkqgtA=;
 b=MgJVBGyR0GHlcUhTbRPbB2Gh/zUPyzXf7ufQ5ry9kCtshJpZokM4ABFbehlu1wGjH/p2QWCr/eFfSV+xpHDi+q7nb0U65cW/U95UyvlR2eT8Cqfr0eXz8xl+epqUXFwl6HDeTH+yuqKBKKm5/ueDn5Irvxu4SpkZm7biiGxfa2WdMlC2JZWJAJfbVgbMc69Lj79k6Jdo/n4uL5ZO0Gj+lEMYlMENRSv2n0N/pCesijvIpvkTl+qu/dS9P/wT8prjwXQEFNn5IZSd4/pVn+jY7oo0w5xPzaLBeQQUftbRgRhjwJ6rhSi063+uTFuk1Z93Sf01z4WfkD0bJ6ZqkM92gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZ+84wApvEN6xwXMRQO4ytG/gXGcmSoIapuZBBkqgtA=;
 b=k8DvLvDt12lxzOo6xtJeNz5FiT8ZUV98nN/2I68t6vtSv5CK94Mw2SeZbB15/Ej5L2nnkby3AjtZ6skn3etgq9nsbE5aXq80TZMxOpIASQ6WBLEg6dwajLBVANBW+hKRQlgq410M0kPtDi2rv0Cq+gidTGGD/TVlBDyzqnCioBZ8/2+0oRc54GMDBlB4MXNDMwRaO5fR61oV1oZx48QUFXId3x/7PUY6tg132cMXx2FvA7QmgITvOWnBg+3nc8/pLR8AglJKjRSEwKJLuqbxC5FxkaLATlPoRrNPmm1h4ZBdvHWgnyFEx38YiizoNbMfCGypR+dMXWAWk7kYq9C9zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7306.eurprd04.prod.outlook.com (2603:10a6:102:81::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 08:56:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 08:56:41 +0000
Date: Thu, 11 Dec 2025 18:10:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH v2 2/9] mmc: mmc-uclass: Use max-frequency from device
 tree with default handling
Message-ID: <aTqYhRvbj0OnquxX@nxa18884-linux.ap.freescale.net>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
 <4fbb3f32b70e30cc57c85083d24a00a423e48b82.1764760325.git.tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbb3f32b70e30cc57c85083d24a00a423e48b82.1764760325.git.tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: b56339a4-67ce-4e33-73e8-08de389333e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eht8s9wOt+hod0grmMIopUxb0cY1VeddJKVlN3Ap/GdEJriWk7/JZJmPY/gL?=
 =?us-ascii?Q?TSe7qPe6Cka86efVdZPthE4iJADbdMPn3Rprnkbd7zjrWGfQCkuN/61vBTbk?=
 =?us-ascii?Q?55M5ykWpKS6Wh30SSHSPzAA0cfDg8C3lPjz8nUdtHN2xXu0zuRF0qjC304BV?=
 =?us-ascii?Q?gStyJDQ2MtQ3N/794mDW55G4+6vgLId8CluKOUXEUqGBkWbtMZogQemW3QtA?=
 =?us-ascii?Q?NlnOVVVmZXm30iUml/iq74izRs93DbLzfYRW6wNh0LZn23mQhrZa9a71oq65?=
 =?us-ascii?Q?N8DQGOKT9/s9s899dnp7IN0kNf9loAwUh+sclDIEW9ARZB6lfeE2uCcg4Jd0?=
 =?us-ascii?Q?4XU58jTHwB26W6t4hkr8TWKo4ACLp2VPsSONHo7XBibEpKcIuQ27kZzo2/pu?=
 =?us-ascii?Q?xM4PBXZWxpX8KYbko/5ZZ5rx12kv+XqI84h+Thth3iyS3Wr70NFRVyK3wUQv?=
 =?us-ascii?Q?G9uIphh8NCgXZOQwbWXfVE53T+9MNE+tx9hcjb/Ej4SMKTKbJ+2/Om39fJfU?=
 =?us-ascii?Q?lufCi1dgWO8/WLPopHcDN2h6VQCbN8VuUc7JCEmcPGp6d1VYalRkEgViFIbM?=
 =?us-ascii?Q?QgCKMd9aNpmOMRnJG99pUzdx8fYgEzYlj1oaOuGAMuQhG5lHKi25nGOUVb/4?=
 =?us-ascii?Q?b5eS1IPWzkz40b51Hlv0OYMa4sA5ELThatFAGBLx7S+GIS5frE24ZHFfZ1ph?=
 =?us-ascii?Q?NqS7kZOoMK44INMQYp9p0EdrNdxsXLX9SVJar3f2fyU4rCDJETecbX9elhuu?=
 =?us-ascii?Q?jzeohXuaPfyoemumpw9Rsm93jNGsajeUC/JW/k4gGxF4pAlJzMvhUQbGP1TY?=
 =?us-ascii?Q?t4L2RsMtWaGcKoIOeyVsisclnNh1P/NZa7B/tIVOsjTBEEdAG7T1fyTPukq4?=
 =?us-ascii?Q?qXc5C+UIDg9lMcpQC61ZduTLVPZRPvbDNzEFLk87CroKmKlRmem1Ee+LbxYI?=
 =?us-ascii?Q?gq063xBPjf0i62pNpB13I9s8Jv/vZ1R8/uLtDzwIhLW25iGQ5Ne9JbQ5p0PU?=
 =?us-ascii?Q?JIsZaJ3vgtTkOIVDAC8zzwOPcUzYe1D2sj7pbgIbkEv8B+HMg1RrcxaYeGs0?=
 =?us-ascii?Q?jHFG31wKujVJ0HvNg1+r6nSbgBvgG/tEpdttF8u1bSOWJMrjmJC+BWf5B/m2?=
 =?us-ascii?Q?IuOg3+WqWGjGYvaLfb9oZomevvLngaOgyiIT0B08RHJJvx8QST0qttR9nJn9?=
 =?us-ascii?Q?VUNo6xrubi9yBE0SliZwrUOXHDhkIZJlmIjkxUnG6N/enATJ54ZfedoJ3hau?=
 =?us-ascii?Q?Tj0la4IgdAxv0qGKfIfc8puMWtWDJolgGQwayWJgJXb83xUDB9J7kx1TGlvM?=
 =?us-ascii?Q?QrETzStZgEMbx3r6feATymioG602Tvx9DEpPXlTfJY7Vyp1wefN8sIaTuW9n?=
 =?us-ascii?Q?/6AisTl3uxENfMvC8sAy7im/zGG8GbOAS3nDj5+OPAAIK/eiAhvpHAZkVRkV?=
 =?us-ascii?Q?hRoVufSELTjVwsK6GQOxMKfeJ6DsoyynP0oJ7wogpXXLv9nmw32+5VP7t+NZ?=
 =?us-ascii?Q?C26ZRN6Z101WLuqcAeTlGtJ0VzJ0SaHGTVrN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mm0fTEM3ITfkMfrx658y7JLyguRzjTrPZxVRH5SLdXSl7JOYuRTTy56+9s4M?=
 =?us-ascii?Q?WxzXgpnx/ZoMx9zK1vR9f3/WJMQFiwfLUkJtJ6qGSpGt5flnAKrVrTK+TRle?=
 =?us-ascii?Q?LJFzHYjqpLJVxFEHr2+0hOI/7GxoJpV1KDWQNz4bgK9gJdW5/+qsJlDgwgO+?=
 =?us-ascii?Q?kFgR+zpo3+ICjFU6uWDmy6SDeq++KOJ7cqPvBjH7L/0U3fZOypYMNmXK6oJe?=
 =?us-ascii?Q?zZauPvCUBRMZCt8Zj+gMGcoD/JiPCGU8eo1FOQIlo3LiguSfP+Ds64Nss4cd?=
 =?us-ascii?Q?vsRh4tKx4B2Oscne0DKc3DTfKK9WOu4rR1inQJroCiHnlQqtVh62LBppZpqz?=
 =?us-ascii?Q?FjOB+ovCu0BqvECcbFGuYueEVoPhwnSd3sfcc2mM0fPlvH7cyOsI4b1mcmBy?=
 =?us-ascii?Q?NyFzD6v33ywdUbR79QnFjJXzX0hYwMCdIqoBjhFS2HrZ9nxyHty7TkQpagn4?=
 =?us-ascii?Q?dRxeZl1LKJYs+zRstL1HnLtCG2jzTP9OeYuJvimli1cvijeEoxZBx8a418OD?=
 =?us-ascii?Q?KafifcXCnCcGQlZvqPgOteCXhO61C/YCS5WtaC4CNiKNLLwcaCYhRkk2PG1v?=
 =?us-ascii?Q?JuBTpIEunYipSai2xD977yDe/3b/XK6I+Gpx44qwckVSuVOcswShYw5PsrX5?=
 =?us-ascii?Q?9miqEjxRiktjqaDzZwfacJDvzwN47XPGR4tMcFkb3x35t/C6K+nSmC+n2ihI?=
 =?us-ascii?Q?1B+7S0g70xq2DaH4vCuw0GFLvumCi49+rLiBZLRG29aqitW/o8SpG5/Z19D5?=
 =?us-ascii?Q?qKbH8Azeig2DTY2i/V4ik0OMAiLHpu/RhUwb/BMvT+7rxDU0KsehjkaJIXQ0?=
 =?us-ascii?Q?v7PZdSRwmO+eQryEoMG/afXk4EDCy7X1JXq1AmiYhaP1EtgDEXvHG003vZl5?=
 =?us-ascii?Q?SfF/N48QU/yegzkMQRm9Au1dEaEmP/Z7MaFu9eTZnlwNi8jMV/mARp3zJgXb?=
 =?us-ascii?Q?D7AFJQSuEUy8cBx97Vnh7kvN2spW2ktiUGll+IPuBv1R2SZqiyAQlaWk/VcF?=
 =?us-ascii?Q?s9hTUjN5OQj0vOTJDlA/tD7jYbv6GPcDjZ8wcMirk7WcqHDlXCivw60VFaM0?=
 =?us-ascii?Q?JuaBdMZbN0MpEKl9CZ1Xd995c9BncyNOY176iBMUDDMZOijMCXEPjXTlTQMm?=
 =?us-ascii?Q?2K7PMkOnxpC8DLvlb8jTLh4xNFyr0Y4C9/MaltG/zwpZIB3k0f+xYYJ4q3bZ?=
 =?us-ascii?Q?amKhV9bQrj0kT4Bc+5gdzacR67+ymTyNPJ5tBd36zS1Pmdoy80tGPx72f21C?=
 =?us-ascii?Q?2AKZ+8LIIUgS1Mw47BYDoQePwL9IYGv7+cnVhJbDY1hNkzygmiX0pPPoqgud?=
 =?us-ascii?Q?omXkH5diEypb6tbGIuJ5n3Q2ez3cWCYiV0xIMxZjGgA0cP+VOmWBaxQE7RtE?=
 =?us-ascii?Q?lGNWFgP6gLrcAECF2hJwaaCJKFyT5IP4+RFC+cPYHiZVzMkTqY1GQacpfqaZ?=
 =?us-ascii?Q?Tr+x7lc59s0Gr7g/Ey+fYEf8zIsTYcj0gERO2uPPjAtIQBHnS/cBQcEUrNWL?=
 =?us-ascii?Q?VMkKeaRqcofuRCbv0KABYlclwZD6+goI0zI/dzd/UZqnmNZMxqyaC8CgMh1R?=
 =?us-ascii?Q?JbXgDIv+ANCJg8wyZyWN7oZcGYMVpfgZ0gJ6vgMW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56339a4-67ce-4e33-73e8-08de389333e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:56:41.5876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOc4QVdtIM4kyA7GBXPebBhpoKOW6OCpzKKdekYQNyTrMDbSzNK91tnZxICQBshebHfS9GqkW8TKtmnRi9Hz+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7306
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

On Wed, Dec 03, 2025 at 04:21:32AM -0800, Tanmay Kathpalia wrote:
>When the max-frequency property is not specified in the device tree,
>the function now explicitly defaults to 0 instead of leaving cfg->f_max
>uninitialized. This allows sdhci_setup_cfg() to properly detect the
>absence of a device tree specified frequency and fall back to using
>the host controller's maximum base clock frequency from the capabilities
>register.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
