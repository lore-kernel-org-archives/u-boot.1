Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A75FCCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F90838DD;
	Wed, 22 Oct 2025 09:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uu306BMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 339DC8334F; Wed, 22 Oct 2025 09:03:37 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5241082E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww7D37bFk5zrQWc/C/KNYVmUBYIruQdovTsqh/XM7vFwNWledIRpjgl1wyRE+2yamb2r+fCNEhkyQwmFRHck9olNwGQGMu0GrXPmV92MZOZbVqdx8aXZLDx67KQIi//xMjoYdas5JPFw/hfVSeQaRSxP0ed/PnmPHgA5VDU+jTerkdlZndcj/siT7hEFbIArQFpdpEC9uJ7DTC32iZfSL7s6cjgAjWccYQ5REwuFW4pLrvKEckfx1Ui/ySwbAx625pSwUifiK3857vtCy3luXOQuwNYqp3UiQ+9qZFTkzzcLgwuD/S/AG4/aonHa3ZyJ1HaKf2MQxOOu1TPt9QkKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENymwWJWg+pNrSAmFN5+D/rSF7jcgzKl685kf4qkbfo=;
 b=ykUY6m8KK5BlDUIYsuxJCXpIz2sruHlee0hWoYkj/Rmou63Ea5jUVO3tcWafSFY9o4lp909euY6WhLll+kB0LwUiZGOCUR6lDuXCBxreXbf+HGkuS+ggSwrLWw1mSq8gRgTtxbBgioYty7PTepesfVsSa1H8g2DR23u1g5uDfKrRYsgBgI6ybkNHnofbdN7fmMQ0wO5KVtyXam/vnFIYRFPYeA08WBNDGq9pwD2V+j/ynREwlt9KbcPiuFhO59gpkXEg2B4DVtA3SXHycLg8xfsvBuX8AAHURmDGVtmc9fCXGtvEfPDADPrvWzD3T0+M94xqsdHI6QjY6eN1bo8Wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENymwWJWg+pNrSAmFN5+D/rSF7jcgzKl685kf4qkbfo=;
 b=uu306BMihFXKu7HRNtMgDJ8NHgU+8UpLQKAOlICFryD2qnWxHd4+D9GkoqlWSF31fstANkUD3Yc6Z1UvyuHQAbFvEmu+xNUZq+GQjT6IWsIK4dfhKfDm+UmktcR4WUuCkqSZVIRZZg/1Ao/wIwhT1GBhH9/VQE4TLFeMlpk1MuOHHyVjJ3zOyNgY06kMYSIpIXpUHSonGM628BiZxyLL1DbBfRCkU8hBZp6ZESk3gYWJmJPxSkofAWxroY+kDEGwj+rECwO6QDdXq8kvR+OlWKYj8Q3/J0MOB8d8gNc0JSpgIbVbvbBVrAJ7F2AQlMJtH1ulnAivmOs/Q9/eHfOrrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6935.eurprd04.prod.outlook.com (2603:10a6:20b:10e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:03:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:03:33 +0000
Date: Wed, 22 Oct 2025 16:15:46 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 2/9] mmc: dw_mmc: do not skip dwmci_setup_bus() for same
 non-zero clock frequency
Message-ID: <20251022081545.GF30163@nxa18884-linux.ap.freescale.net>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
 <20251017-mmc-dw-exynos7870-v1-2-a2c5139d9afe@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-2-a2c5139d9afe@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d674a6-8c49-44c7-eb41-08de11391cfa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?urlNfyT0BL9+32kUXVWqai/9PtMoNr637+bpuXTJ6/Mrc//B4NGx36uVjzbr?=
 =?us-ascii?Q?B6i1eaVOlZeeteISOqloyrY8S6vKzcb7eQxx+tYAjR7IcF0ZPYLfE8uX/B9r?=
 =?us-ascii?Q?JsQR6heeLFgbasgsVDVlrBayfP9iqrKOgcYoSuJu7Nx32UELaJG4Xz5V2xXb?=
 =?us-ascii?Q?V4/2XWttrf5q2jvh7ZTL8OYU0vtk1NYnEYVtBUBKpl5CaQzG6joWWvT/xfEH?=
 =?us-ascii?Q?Z7MiOpMAe1Mlesw+LyTrsNttuF2Rv+cqlwo/wNYntfvBDj8VAYAtqV7Pbc2O?=
 =?us-ascii?Q?SVehOvYuQufXWzU5RhNL9+wHz3tjvw5pY6Zf0T3F5gS2aaCYQsLnx7ghqXyk?=
 =?us-ascii?Q?Hl+QbbtSxDtnf5fx6HPlX2wSQ7V2MKBUFkPbMXLDo3YZZMNBCG9Y9YYF7iwd?=
 =?us-ascii?Q?sGn9T2XJtm+DJNLYUGsvcPfczXcePTOMMmSeS940KQUdeX6uUyXoyo2yG1Am?=
 =?us-ascii?Q?Y7IDDYrjxi1zFJJ9t/dstUdPHt0zT3PJsSLORT2wSU26EVCNNyGlk06CIMjs?=
 =?us-ascii?Q?d351KTzMV8D9PF23eoZGdP6N3KJeOu2D69lrSYOhMGpkjLVOpQc3280NyZiF?=
 =?us-ascii?Q?5ggEAI+Qa2zfCyRje4g+jxZHb3/W7uDYKEUdrNJyXNoMZRQSnoPX0FfftmI+?=
 =?us-ascii?Q?o7TWf+Fz8wdkLsLQwtR1cUWlxFpkEHYvrHe90A15bL+k86y1qIP3dsOJzcBX?=
 =?us-ascii?Q?+7WqNlJ29JIVkPAM6RSeNcdOAjRuZ10D9Jd3rzGqeqcXeiT+xxkJllpeJxyT?=
 =?us-ascii?Q?XUZr+xeTS5izXO+OstCgP8DiRS5jcdotTvWSnU7LPMXfAGRyIv2kM9vfZxTz?=
 =?us-ascii?Q?9uAROpsBfZ4TXQ7VRWRmJgJFeMSvpSdUAbl3VoB0qVrwia80mAwSFciPaMgB?=
 =?us-ascii?Q?pn1PEb5U7+9hUZl468LU8tdlz+gFLs/ExAIllLseCpDoSP5d9e3ljxPTSiBD?=
 =?us-ascii?Q?2OHm+iZlrZsnYHqqn6R7N6xGrZv+CMamdFajvmsJrhbUEOKmo3+mxtAgkOGv?=
 =?us-ascii?Q?njuFucPGPwGHovqS7q2FwWClUpSFn+YiysPfFIW3004VvYRZ4Od/nQ0pJoUu?=
 =?us-ascii?Q?gpSo5T+7MT3VrpuhFCpqQ7MosAqpxzKEyyKYTOYJS0pPogvLbbjuOdqQ8FTj?=
 =?us-ascii?Q?NxnrZNu80xg8QAQgp4J29gyHWrmIGoPndcUry9HFnvEni+bU06e2I564JnOV?=
 =?us-ascii?Q?1tkYSVmN0RsuIpLsn0mhEhv/MaAOq0jAzQHwMcIBY1BQF7Rtl/j7xW8PFOzF?=
 =?us-ascii?Q?XueKari2euIifH85qerYvQNAYN+epB0sE3OdD8dUumIKRWK34JYDxZusUfWE?=
 =?us-ascii?Q?iYa9skde7UIzrujLTF2OMJUtxUnT02OM0qeIctngDUBYpijDJg2QXTg5Xmti?=
 =?us-ascii?Q?dmgNwDbUqLsqMcZUBrJUeX/mN/XoVyYpOMQFjBvPJsSFHqe2g8CtJ7bguUs/?=
 =?us-ascii?Q?q0IqteaDVf/h1RwSTDhrru3FTaMlwj2x/fROx2DzaKbc8yGMPm9+cTwghB4z?=
 =?us-ascii?Q?Pu3zGk09F9912QvYGpLGx+PivK20giE6TtWZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aH/Ue31RixGQrYW3P+JiqVLUTkr9QBKyEyWP09ewm44iG8YGDJDI5CzBeF9F?=
 =?us-ascii?Q?jSubsvznVK0C0DUFrTJ57DYB0udSxZLVKegvNNHkIBBxNBJj8Tn/C5VTORKo?=
 =?us-ascii?Q?+WCPKnN3DqIrW93i5j0ndqpEHVhM5iqSRLN/bd4Rc/bdA4lcwsGNuLd/EmOM?=
 =?us-ascii?Q?EV6MkJV3suTquP5uPyeLebT3qNT0Hf8Cej9WTYpkz2/xd8qdDzsnf9hVrZUp?=
 =?us-ascii?Q?qK/eo87x6ab47eJOc42SRqbaYz7TDV05IGhxuUkk7uM0N2nY1beGQNsBUMBO?=
 =?us-ascii?Q?VqkN7V+ARS46kyT/q/zKGDQxzSw7jaQVP81RLJbVE28nDsJ/huiBoiAFb+8Z?=
 =?us-ascii?Q?pDBnIdka6SiJy/P8jygt6r8RqpoB6eRHN4XzD+Bgk8aZUvleEaTawJJKOP4U?=
 =?us-ascii?Q?BLCfBxf81qO3H+42kzAAeNEqq9OzckPQb+w1bXNiWlk5h2RSBKLNlHvEZXuf?=
 =?us-ascii?Q?0zgCnFCce5361ckxozqbkqJHYci9VySJpzv6SaMzepgCWjU4Pn3CGRk827vU?=
 =?us-ascii?Q?T0ffOeZzmCXytMMizomuHRQuY820UyN6ojE+H35WApEb8ZrGiAYq78TwnfdX?=
 =?us-ascii?Q?ZlJYqc0Gg2HpqHVf4RrXw4UXMj2Vyx8BEXjj7/CthyAiznLMsT+aAkDGEEp2?=
 =?us-ascii?Q?Rzb9+0ZiUdZxacHmnpK1NlArxE8GteclmYsbQSSLOKrRdBIoTX3/VhEPtLFM?=
 =?us-ascii?Q?VzMGKMDf/t+WaOPEoHTkcB+bTlbX+QFzt6kgGxoHitjwnNHbyXBbO/zj05+q?=
 =?us-ascii?Q?Ghk2zKkMVDT1fznaNcL+8CnJZ3ssFzCGPW+vlr5Kw60lsyPYMSOF5Y5LwfnM?=
 =?us-ascii?Q?T+rJCVs2vFq/gX+D0KpCXDx+Y9eWFltF6nBKvzbB7oJ131aJ9m2b2iXp0AZ/?=
 =?us-ascii?Q?aEiBaMrfmf7GRWaic3h64G4hPHH09IHVsL+Va7AHKaCWB5FGrl+cf8mxvX18?=
 =?us-ascii?Q?XeKNSc4xEJc7XREsYxoKy2m6BEXhhyhTaGcT70LZcGYIgaQDUK1zu+c2rHEj?=
 =?us-ascii?Q?Ca4xJhyFlkYI4rK8LbaAmJEOnipBFBE46aShVQIHsmlLNi4h9UK7yWTq/zXb?=
 =?us-ascii?Q?LDo5pCKMvV23R43RjhygmM7yfICSYJbXgy3X51xyAqIzYxJ84L83/iWvA3bm?=
 =?us-ascii?Q?ucnKnVhqYwAZxWOZVnVSDVF+NqU/9ewtjes8WpIh3lCGAcGS3UhPmsMmX1Nj?=
 =?us-ascii?Q?sKBH4dDwECMHF5HYBrmXMCT81iQObMDoXozJUP63kVlpgpS+PrLcKQ/MxoyD?=
 =?us-ascii?Q?xPSFOO/no7FcXbHBfkbjD9jsTtQSJYWJzVY68IlbQT4UB+F7njV+zOFh2VxG?=
 =?us-ascii?Q?TDEa7Ce5yzxZFAml4BTFkvlSQhrBku2oLrpi9B7oARyrOwEyvnUIBjjQDFvo?=
 =?us-ascii?Q?ECD22Q0ox71TdGpSdejvtlnKtJXEbPhZOV9rmBgEUm9stPLXl5JWZuVbT2M1?=
 =?us-ascii?Q?0sRlHLwyyU9WqNAMQJUZe8ZyqoXjROSAZK4AH0gGF/gCLJmKip4VLzfJR+Nw?=
 =?us-ascii?Q?dyEm3qUI6Ei9gaONbyMrrnvYiYSm2djYqiXfr9IRuDGtbpe9NmjXdnYDyjka?=
 =?us-ascii?Q?ENBjS6hhhZFzqW1KjMhOeRZKK/paCJmKHoNZhhv+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d674a6-8c49-44c7-eb41-08de11391cfa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:03:33.1697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA28bh6364BSzb+EvcV6mkhaq9teiOpxjA9jki1/2vX4JJKYieTss+WG1QntLCXUAi6mQWAE8MWKjpJXIT420w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6935
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:54:07PM +0530, Kaustabh Chakraborty wrote:
>In dwmci_setup_bus(), if the requested frequency is equal to the current
>frequency, the function is returned, assuming no changes are required in
>associated registers.
>
>On certain SD cards, skipping in such situations may result in a timeout
>errors during MMC initialization. Due to the lack of documentation, the
>cause is unknown, but removing said check seems to fix the issue.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
