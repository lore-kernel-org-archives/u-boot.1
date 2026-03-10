Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4974FD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C638407B;
	Tue, 10 Mar 2026 14:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fCDsxvhg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B947D83F9B; Tue, 10 Mar 2026 10:14:19 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33BD83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPnb4Vy7yUuRmlCr7ZagGza3oRXq8lJXN3uhk+fp7zrsGBoYnGAYgVUJou6YrEOGzIGJhBIvTtCMC5pTuuq4qUhuKMdkd5lYwZBjrWEX0WzY8p/y4zfCyfI/T13a8A6dlZk2ApqG8XVhFGEpAakmGwHFnqYjnC7N6efluh7sLyE8JKN6Y60AFfa6AIwRMMczoisa6uUJ2vmoVhCcb+cJpXfjLGPDd4CQOrIMVMZxLPbVpZJWzVxRUbOyU9xRqvEhh31dtEA6YE8mFnKGI6XwmFs49jLuhzEZ+uu4YkQiSk3mGVxy5jyuDI7MKBdx22B/Xgr668BzpZgsa8nTVNcHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km7Yg+hhihZH3Qcwk88NlYhFReXiMYNhGwY/zLhbQNw=;
 b=JY2qgqgk3WiUC3C+8B+Z3pydIR4wPAUSFAG0XEM6Nu5bMc/YQRD1+F4k0vIgWsJ/8badVwAj+9Iu47TE0ZsHzXxydf7qDgyvlHrUQmlF+0hOTaf9Weh/RvPJEvQVvYgcKxSbucPROdyzaUyamCJfCMbgE47XwFpO1oNRQlFpnuxTXwxQOrtlMbcvHz47UpmXvTctu9hA75exKoLPSZDcHSx/0lEoM2FzgfD7KTUkjwDnRaaE35xKDovE8+vsqLxq8Lfl9cW4E/ZKvPcT8zutz1fXvoQNhUFj4HsAWJRcG6/qyH5PAJAa9lF0iYlTLu7oAAoEcD+/XN3AlIiqZB9cOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km7Yg+hhihZH3Qcwk88NlYhFReXiMYNhGwY/zLhbQNw=;
 b=fCDsxvhgMCrxrHSDPLFlT7Ct14voTcLzNER8eX4j5oNvGF3vFEBCzmnWTZjvuKFo7emjL6N0fx7wvjJVmC7090PS3Vl42su2G449aXV6if/IcZd/oa4d/mFdjrjbLv8J52rB3Dd+1VyT/ooqHvk7zCrzQX5TRvGcNzl+qjMPY0hNvdtGy7elJckmnjEp/V0RpTRGdYixdFlIJnKoGygb0SDj4iYrLMW0h+kNoY/o6z2MxMFJTBGuRTBW5Et8xGyLHWLWgud8YsMaKnUW0Jh4cbcmN7gX7NKNrXgHKl/vZqwYMEvdUe6uuXTxvkAD6sl3tokvSaIJ97vLKt8U/e+PRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:14:12 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:14:12 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 10 Mar 2026 15:53:37 +0800
Subject: [PATCH v1 03/10] imx: soc: Get watchdog base addresses from device
 tree
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-wdog-v1-3-2ee21e890634@nxp.com>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
In-Reply-To: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fddce7-270a-4a87-07bb-08de7e8564e7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: Y5jDyLAJ5Yk/wNX1yCXmnRf4gjoe8r6rDs9vBsMxMe8z8xnWF10dV0d36TRWF77Foi+i6juWQeUCFQG2ByWRATDu+8JXFs7Sn6SbtqfkDRK7YRRgWxBjjui7hXuTe/7JxUbHwFz2zs+EQNgs5h++GvFZyDWlCkactt4+wQvp9RU/+qgN/jlNWz/F7n/2PuX0rXIZVXqGT7yntu55vEerbQC+15ivpidvXAe4DI3FY3GHy84cF154h94mVfbSsU3NWsOAt+1ypNowd7yYmmAZ5Er4MfZQMoEazS5rbR1tYoCI1EuqZ+3HQRpMsAmUlFqzBAbMcLY6U70ywM/t+P/ysoaYNPdkwrG8rLcOQKQZoOimn8iB/ox0+mLUD9b+e23IeQfJlZ1Dy0kEmZ9WV4CNW+WrXomnhTtRpiZH91OPLMCGf9W9RSxEdvw4w7xhBx+D6z7ITsZxhIeBUaVSx4M6YTCpdBzuA5+lrqUoTJMM17p1+CVjpdC3IMcsGmIRNzkMYUhiB+0dpcOXwVm892tDCMvo+XDj0Qt2AbSSNgWzk3rO47X6LgFwxgZWY/GYiVay8/wn8IX1815MZ9O0UcsCzWcR5dEXPRecYbhZX4TPqwtLXt8G07qIQFLylBRaynPyUBq7N2F25Rsxr5Y2sMvqbCk6CJiktxeXF3ZefZ7BLf1e7kiLE4uf3YuYDw+0QFzzc1LBiVVOP5hYweF33bhMars/6KebLAK5qnvXVJB9iMfPGcEXN0VO5nsdrDH37RWeUYz6gWYt6Dc6VARTqwXVmGFB/WM2NLqfEYoUnGct7g0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnMyaUZqS1k3ZDFGc0FHOS9KNVFhUUxLTkxrMzRZVXdGbHh6eGlReXZzWG1m?=
 =?utf-8?B?UE1wQUZEdWo1MExXS29GcmZ5dUZzaEVCclpMbDVQZkNUY2YrQXBDUlhTN2pI?=
 =?utf-8?B?NndXUFVwTkp2NXJLM1hMRlloZnJabzNPVkZ5eTdLOTJhRWE3UlVMb1FiejYx?=
 =?utf-8?B?VHhBSDBoZEpQSlN1TjIyeVd6SUlzTVhUemZuazdoalJnMkIrSWE2b3JjTThs?=
 =?utf-8?B?bnRSaXRZVlRyT1hielBXOVZlSVcrR0tUWFpSc1NDUVVKZ3ZTZzdxa1hYREpK?=
 =?utf-8?B?OGxSRXRac3RsVld6UkpZOUtHUG1WQkZWcWNzNU5FcVpoQnZsbnMwMjJGVDBa?=
 =?utf-8?B?YmJTYmFIMDllM3hjeFNhR1JReVIwWE9uOFBteTQ2bzRZcFhOYmZNdG1iRE5F?=
 =?utf-8?B?L1Q4dncwOTdFL0dNalkvOU12V2lNYit4QXBDQTludkNIeVVKNUdCSHB1WHpP?=
 =?utf-8?B?eDNBcENLM3RRMGN5M0lzcDFISkRVNDNZQ1kzYnpqMmlIeXlwZUx2Y1pJb05I?=
 =?utf-8?B?VHdPUjJzRzlZUlU1cmRWNjdZM0xPU1pmNk9XMk9rbVdWMktLSGdrTldEai9R?=
 =?utf-8?B?WDBEWXZ6cUNmRG1oZm9FaHE5dFBzTDVUM1Y5ZlAxTzNiNmRPNTFzVkwwUkd1?=
 =?utf-8?B?cmtSTldTcmVNeTJTNXhVZmlEZ0NkUE55ODJWclg0SW5rRFZaS1ovMnkyZEsx?=
 =?utf-8?B?em0wSjhpUTh2MjNtdGNJYm9PcllldElJa093Vk1qMVN2NWhBa1MwTGJtd1A1?=
 =?utf-8?B?ZXdUdmJQbnllbGhjcGsra2tZME5WRngwS0xIaTh6M1ZIZm5pYmtnY0tsa0pN?=
 =?utf-8?B?SGRFS3lVZW5qdzdBc1FieXVNdmc5ZSt6L2liMWZmQmU1Rk4zUWdRQlhJOUZO?=
 =?utf-8?B?MVBQYjVVRmY4dFlzbGowK3BNbFhUNHpudFppY3dsTmNnVjFpT0VhWXVrZ1lT?=
 =?utf-8?B?UjR1aWZMTjE0aEJ2RUYrSFFrbUpQT1NZOTc0bVBQbDlwVVVpYmxWZ1dlZjRY?=
 =?utf-8?B?TVRrcjZZK1Y4aTRONzdzZW5EM1pzSFowOG5vR3UxWmU3NU53MDZsN2pPK3Np?=
 =?utf-8?B?dldHWXU5SThNclFNR1FsYVV2Y2pKTGZBYno0K2thbFNOREdkeFkwVTR3cGZH?=
 =?utf-8?B?OTdKbXJIQTMwWDVTeVgvQUFuZzZJK0NReDVQZ1hoYk5mTHRVMmpaRDd6Z09U?=
 =?utf-8?B?L242YjdUK3dKRVI3Zk04RjU1ZHFHN0p3RkFaMkJpYnVkbFBuZG9nSHUzMk1q?=
 =?utf-8?B?c21wbnE4UUVPeTFUQitoUjh6WVRrTklqcUpUN0krVmhhVnM0Q3JZNnFvVytn?=
 =?utf-8?B?RmxqUnhjYlcrdk9iajZTMURqRFBpUGorY3UyaDZLeHBnSVFub1pHR21sS2dC?=
 =?utf-8?B?NGNHYmpyVTJseFB6WkdhbEFrN3U4QS9UZmlSNGZiSWxETWNBVFpISUR6OUNs?=
 =?utf-8?B?TkpLVCtLRW1zRzlMSDJOMEVLZ0pTVTFjQy9XUEtHaHA1ZDBYWU5LZmpFOG40?=
 =?utf-8?B?bTNYSGRIVENIbGNhcjQ3c0F3cnZWQ3V6cnlSRUlmem0xN1RYcUpScmtmMlgz?=
 =?utf-8?B?bzJ0Mk1tTVZVUkd1QmEzQlR3UlJEMDgwYTNvUzBnQVR2K1NmN2UzaENnWERO?=
 =?utf-8?B?WC9TVWFnQmg4RlRYUGkzQUU4VmZna2Rwc2NDa2Q4Ulc0OXRyc0xxUm8rT1Vh?=
 =?utf-8?B?YTZCeUEwSW5ZSFNUcjdwWk1kRnlQWCtkUC81bllBSEpyWDc5YmRpaUxkamxr?=
 =?utf-8?B?bVVHSC9sbEpFamk2ZUl0M05jeVZiWXNPM1RNTEJKblNmbmNyZDFONjlXMFVD?=
 =?utf-8?B?dThMMkpCL3JlVkNDd3FzU2dyWmVjRnZ0ZW5RQmpJcnE2M2tKM1VxaWR6VzZl?=
 =?utf-8?B?aVMySEJoQW52TXZmYzRRVzU2cEFnalhsT0hZdVZYVVBqODRZNFdYTHFaVENO?=
 =?utf-8?B?SG1WajBUMmsxNU1jU1FxbG5OcEhFSEdEcFFySThWaTQwUklaK3J5NzdMZmNS?=
 =?utf-8?B?bmthYzZmdktoaG5tY2w0bmIzQS9heUdjUmUvd1cvY2hqaElSWlU2OWxIcE04?=
 =?utf-8?B?Nk96NWhYUEZUNm1QNWtrcEY3cXdZN2NCWGJsU3ZjVWtyRFIvQlFYUVYyMFRB?=
 =?utf-8?B?NTdyN25SelUyMXpha1R5eXpZalBNV3BBdmFBL1IvNVc0d0hhbFp4ZUVXV1N6?=
 =?utf-8?B?b3RqTUJoTlVNUkNuUGJQY0YrbkJrU3E5b3F1ZlZWbXFnaDk4Uk84TVdoNC9p?=
 =?utf-8?B?Zm5ySzlwY3k3M2NVSW8wUE1mS0lmSTR4MXRhMUtGNHE4bTVuYnBZVzBseElJ?=
 =?utf-8?B?ZUxQUENPY1BXUW10dWp5TENqUUttTVduTnBaUzRKSEF3OFNVZjJhUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fddce7-270a-4a87-07bb-08de7e8564e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:14:12.3656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YLjXQtIiKjfhsr1IrL4GbI+fZ6a0meWLz7f5ZX/T6kWnJqteYuI9Ku3FHpNxUXGwAjWNyjGSS3n8mLU2PErPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

From: Alice Guo <alice.guo@nxp.com>

Replace hardcoded watchdog base addresses with dynamic address lookup
from device tree.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/soc.c   | 15 ++++++++++++++-
 arch/arm/mach-imx/imx9/scmi/soc.c | 16 ++++++++++++++--
 arch/arm/mach-imx/imx9/soc.c      | 17 ++++++++++++++---
 arch/arm/mach-imx/mx7ulp/soc.c    | 16 ++++++++++++++--
 4 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index 1ee483065e8..081ba9d60b6 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -341,9 +341,22 @@ static void disable_wdog(void __iomem *wdog_base)
 		;
 }
 
+static char *wdog_list[] = {"wdog3"};
+
 void init_wdog(void)
 {
-	disable_wdog((void __iomem *)WDG3_RBASE);
+	fdt_addr_t addr;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wdog_list); i++) {
+		addr = imx_wdog_alias_to_addr(wdog_list[i], false);
+		if (addr == FDT_ADDR_T_NONE) {
+			debug("watchdog alias %s not found\n", wdog_list[i]);
+			continue;
+		}
+
+		disable_wdog((void __iomem *)addr);
+	}
 }
 
 static struct mm_region imx8ulp_arm64_mem_map[] = {
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index c1458ccca3c..692c6743418 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -734,11 +734,23 @@ static void gpio_reset(ulong gpio_base)
 	writel(0, gpio_base + 0x1c);
 }
 
+static char *wdog_list[] = {"wdog3", "wdog4"};
+
 int arch_cpu_init(void)
 {
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
-		disable_wdog((void __iomem *)WDG3_BASE_ADDR);
-		disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+		fdt_addr_t addr;
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(wdog_list); i++) {
+			addr = imx_wdog_alias_to_addr(wdog_list[i], false);
+			if (addr == FDT_ADDR_T_NONE) {
+				debug("watchdog alias %s not found\n", wdog_list[i]);
+				continue;
+			}
+
+			disable_wdog((void __iomem *)addr);
+		}
 
 		gpio_reset(GPIO2_BASE_ADDR);
 		gpio_reset(GPIO3_BASE_ADDR);
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 583c3a5a464..031226ec97f 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -279,11 +279,22 @@ static void disable_wdog(void __iomem *wdog_base)
 		;
 }
 
+static char *wdog_list[] = {"wdog3", "wdog4", "wdog5"};
+
 void init_wdog(void)
 {
-	disable_wdog((void __iomem *)WDG3_BASE_ADDR);
-	disable_wdog((void __iomem *)WDG4_BASE_ADDR);
-	disable_wdog((void __iomem *)WDG5_BASE_ADDR);
+	fdt_addr_t addr;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wdog_list); i++) {
+		addr = imx_wdog_alias_to_addr(wdog_list[i], false);
+		if (addr == FDT_ADDR_T_NONE) {
+			debug("watchdog alias %s not found\n", wdog_list[i]);
+			continue;
+		}
+
+		disable_wdog((void __iomem *)addr);
+	}
 }
 
 static struct mm_region imx93_mem_map[] = {
diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index 5306e76223f..27ba8a37162 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -146,6 +146,8 @@ static void disable_wdog(u32 wdog_base)
 	while (!(readl(wdog_base + 0x00) & 0x400));
 }
 
+static char *wdog_list[] = {"wdog1", "wdog2"};
+
 void init_wdog(void)
 {
 	/*
@@ -161,8 +163,18 @@ void init_wdog(void)
 	 * In this function, we will disable both WDOG1 and WDOG2,
 	 * and set update bit for both. So that kernel can reconfigure them.
 	 */
-	disable_wdog(WDG1_RBASE);
-	disable_wdog(WDG2_RBASE);
+	fdt_addr_t addr;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wdog_list); i++) {
+		addr = imx_wdog_alias_to_addr(wdog_list[i], false);
+		if (addr == FDT_ADDR_T_NONE) {
+			debug("watchdog alias %s not found\n", wdog_list[i]);
+			continue;
+		}
+
+		disable_wdog((u32)addr);
+	}
 }
 
 static bool ldo_mode_is_enabled(void)

-- 
2.43.0

