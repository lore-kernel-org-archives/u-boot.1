Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9359FCCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9BD683979;
	Mon, 13 Oct 2025 09:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QEH9a9Wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF0DC8384E; Mon, 13 Oct 2025 09:00:26 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC5D58381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 09:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k41tSZkfm66kMA3MrrQUtfuJEVqFnjkPfiNSE3RoLfsSQW9MenxCJCtWBYUpvtR3oy9kh9kjYS8vXO4rETfYlkxIbPZHfcB+Cw2GqMPPXiRN40CIRBj+hOnSjSCGvgkukgE8lky/0rJ+9+Owr6G/zv2IhE33FvHvThRC50a/jHVbWnuGmQVeI9MK7rXfJDj3ZnNY/pZS9KerTcaE4GP9W4ENUqCD22IGcq9pFqTybZqB+bggYc3+IaryLGW05WJqhICM8tKPb2PTM73exbhGh+FLFt3RdasjlOgnBZNBJv4ekVw5BTeTghNkSH+BqYcIe0bTpfie75oVyty4+LkUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V3UKnAh3lDB+5Xyq2KiHED8BiEGcPkrFaQ/yLlzUP0=;
 b=toy2dT2RNCDF3g7y0R1sIcx8h3uZdBmRT6V6xhL401YYIY/Tigtg3sqcDTeoJn0+CzNysg3RdXKIzJS5YxCrZZI+HnNLFeHfCMDk3oapyfqGrk9NmKPBP3FDQ5vXiI0MglZpmkdDKA8DVXO8YDQuXMt7res5qF8xDRqxg2sawErq7afUu67eGJIeN0Oz8/yyQDIAGWhvNJlXwBvcHBL3LsyF00rqri/bcuarlxmosZuAyiBQmd85+glfQFKdr/+pYkGZnQhq4V9VXM011SqVRg3NWKqk/snqKDMbJm4SYWlzJ6H7Rp/kLZc5s+eey6bVsGcma5TvTparW0/T/iJ8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V3UKnAh3lDB+5Xyq2KiHED8BiEGcPkrFaQ/yLlzUP0=;
 b=QEH9a9WbZQKAq//LDURcP+5GqTRMyz5JAVv/X7/51PfKkWc/jI1/jm4dCzUkCU4TakULvduWQ/XWlcnIfg9uzhzFAGg7pZkZo8fsIhF2RMIahqI/ksrmLEXQpAN3ZR9B1D9xQ+EeciS0OzqqWWNbNTlFG3K6rJCuJay69GVKrzEx+D6T2S2BgrRbZU5HAd3lX79Q1KyWNuCPAU760qiiwoI6FUW97lBxSu1TtGCtfpU5PGsj3wTiMJMEvD2NMlc0y4JF6nwQJtdFUnXXRdN9aQ70MsMil2fLSi9E2G2nL9OuK+UxyMGEJ5PfwRp47yiKmj6cIFiCovU2qa6zDhciiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 07:00:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:00:22 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Oct 2025 14:58:48 +0800
Subject: [PATCH v3 07/10] imx943_evk: Add support for booting from USB SDP
 on USB3.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx943usb-v1-7-293e79d4bc12@nxp.com>
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
In-Reply-To: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba8c781-efb5-4b01-1182-08de0a262da0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXp6MHNaaXJ3ellTSHlScEtFUVNzN21DUTczRkFYbXFCRHJ5M1BzeFVYU1VJ?=
 =?utf-8?B?SzQxUXVVQnVtb2VlSWxpNC95OUV5RnRqMTNZYkNkYzN5WHNYS0hmZjRhL3hK?=
 =?utf-8?B?Y0JFTDFPR2QxMTFERUl4b2FuSU1hT1NwK1ExVnNUakVoekVQdmE5VThmdU5Y?=
 =?utf-8?B?ZVNJaUJhKzVmSm4xUlZheWpkMlJnakdNWjVsMURoRTlOYXJWTi9RN21GNVZD?=
 =?utf-8?B?akVKaTB5Y3BIeHpWc056UFc4N0d4dGNidDFrMDNzYUlWRFpWZzBUSUpnYnoy?=
 =?utf-8?B?RGpBYy9TdGtlL1crUWxBRGF6V0ZrT2d2ZlJxTDluWXZ2V0R4VkZxdmZ5blJk?=
 =?utf-8?B?MUc4OU5vcEdYeGV6QnJ1RWcyOXNlU1FsUlhGbFdBRVJxOXJlVUk4UEQxK3pV?=
 =?utf-8?B?dGVmcnZXRjZvUTV0bjNSbVllcEM0a0tpUzVmc2lOb0pKOTYxdnZ2bTd2b3pG?=
 =?utf-8?B?eEFEMEJLTnBDSWtjWGRaY3RDbHJtMllaTTBjU3pmTjl2MSsvbUcyNDAzUVVO?=
 =?utf-8?B?bTZ2S09lem5scnR5Q1NkZlJMdHd6dUlJWWRudWQ3U1p2RXBFOGhLYXIyczFJ?=
 =?utf-8?B?aVFrbEhlNThiSEg5MnpWMXZESFhxMEUwWEZpQ1ZTZkFCajFxaFE4bnF1Q2p2?=
 =?utf-8?B?YmRtNXh2SzNJWVAyM09TU0dZV29Bamx6T0hnSWVyUHZsTUFaUmJjdS9xS0tE?=
 =?utf-8?B?TDF0TWpSRlR4bWpMK0tCNGJaVUw3YUlyeFNJaGpkUk1WNlc4K0s3V3dUbXUx?=
 =?utf-8?B?K2VQQjJETHp5NjFjRjdWU1dBR2h2SzhzMWdPVEE1eHZ6TmlwN0tmV29KSGQ5?=
 =?utf-8?B?aUF5RW56VGRGYlA1bVA0Y0FNSFFxc2RRYm81Ynh5QWw0ZmFFeEZVUFJ2YTdE?=
 =?utf-8?B?MWduWnlFMzhGeHErMU5NQnN4Q3h6UENadG9DM2JIMG1mWUwvZHZsWGlWdE5Y?=
 =?utf-8?B?aGhJWEFKdWtSOVQwTUZBZVpEbU1lMk5yUG83WjJ5cFIzY0VIV0J0YkxMU0lT?=
 =?utf-8?B?TUUvaFUvbW5pd3lqUzNMSWNFSFY5Ymt4NUNzVVZWMzBXWm5SSFk3UXF4S214?=
 =?utf-8?B?dlY4RHhabjhMOXFWMnNybWg4emErMzhLRlZWcUhXaTVuRTVJeWJZZnVsbnlG?=
 =?utf-8?B?V25RbmFYaDZXR09ZRU5LOEJhNHo0ZDN2bE9yN3pmZXlyQWEyTmlsSjNsUHlq?=
 =?utf-8?B?NUZ1TTFKSmNsZUFkaFYvUGwxSlFnd0o5ekNKemVSVkdzcVFydGtOZ1VNcVBs?=
 =?utf-8?B?T1RTbklHSlhlWXNDUkhWa2Y1WFRGaG5ZN0VDcjhoUHRZcXVteUhCTGdYV2F3?=
 =?utf-8?B?ZXpwcVBncTZ0MTlqRDhvRFN2dEVTRkRqK2Y3OXdDeG5ndCs4elJMUUlwSUxX?=
 =?utf-8?B?NENaSnJnTmVhdUdhSGZnRDlVa09lNVFoZWEveHZVNUp5ekdraU5KQm9RN2k4?=
 =?utf-8?B?ZmhSVzU0NFFSbGN6M0pqdk5nYTh2T3R6T3lWc2xmSFdKSFNZUUNIcnBObHph?=
 =?utf-8?B?WW8wREY3ZzVyZFZPZmN4a0doOHU5WXAvMnB1RzRicm5ET29xU1FqTmc5Qzgy?=
 =?utf-8?B?SDlVdExYNkJMR0hkVVpmTHVpLzNtNW1TQVd2cVpYVWZmSHlyZERPNzRRNmpN?=
 =?utf-8?B?OHRvQmIwZ09ya3hGU2drekl0dmtjZ2FkR0pCOGp3QmtCb0djYWdQSGNmcG9w?=
 =?utf-8?B?Z3M1bmJWU1ZGSUM0WDRLMTFoVEgwUFVkQm9lTnkrU3gyM2NXc1ZZVWtkWWVD?=
 =?utf-8?B?d0pKY1Z5UG85b2RzRmgvblgvTmRiMWs5di9nVmxSclB5M1FLbEhqSWl4YnJR?=
 =?utf-8?B?UnNZaDFrY2tyY2RXTEFoM21Ka0NPRGtHUFdSekxUSzhMNDVOcTN0bzRWMzl1?=
 =?utf-8?B?T1p2NWtpS1NHK1V6NGlOYUEwRHh2dis4QjdFakFuNWxZMERVZ01BUEt1RFBv?=
 =?utf-8?B?VXBvOFYwYnVza3FnbHpkeEIrdmdHaEgxRC9NMG5kR0ZrWk5DbXpSbWMzTTRR?=
 =?utf-8?B?ZndzYUFIUmZSajlCVWdoVkNzNEJ4SVdmZkVUSGh4Q1h3Rndha1hZUkxjSkFx?=
 =?utf-8?Q?ct+HM6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9vc1VoLzZYSzJ1cm4waHhUcTEyV2t4ZW5Xb29DaXRYN2d4U1VnSWRoVE5j?=
 =?utf-8?B?NTJSUnR6U2kzbHliSnpyYlpoZlZjaE5jMzFSWmZGWXZFaHRZenlGV2kvTmxB?=
 =?utf-8?B?NUI1eTJuRFBEaUN4RDIrTzBMMEdoZ0F0Y3NBWE42aXFKOFVKeFRCZmNqKzJ5?=
 =?utf-8?B?L2J6ZDJ2M000WGF2b3UvbnB1OWN3NkZ2ajBJRkw2YlJwdkkwTWQxeVE2QXhs?=
 =?utf-8?B?TVdEWkJvZWZTSnIvSTVkKy84dEJ0NDEzbGhRWC8vM0ZVZG1ydE9BVGpKbUVt?=
 =?utf-8?B?aDc0OVBvTXJJTklwTm1vNkZyOU5BQzFvelh1dGpUZm5uSFQ3eHAwZHBpdkZM?=
 =?utf-8?B?TXZlS3RBcUNxVTV1L3RjMm1IKzBwWk9xeXRYMXczSDhZZlRIUHZVRk5mbFpX?=
 =?utf-8?B?SzZaRUV5K3Y2ejR6eklNSXgveHNtMGZIZXlOamxDdmdhVnhxalFZZDF6d2Uw?=
 =?utf-8?B?emxYbnNSRTJDVTZSWVZuZ3dMMW1qMFg3UmFCNzBOTlcxZ2pEci9MTmxmZURj?=
 =?utf-8?B?QzloNC9FODk4cWtNa0locE5Mb0c0RHJDWXlnRzgwUW9BWDVaVnlvVXRVNjF6?=
 =?utf-8?B?ZXdTK0krL2szeVoxU1lnaEY3NmFlTUd5c3JLazJ5THZsN2hTVGwxVHRvVDEw?=
 =?utf-8?B?MHRVRFgxSEt3UXJQVjBSVkQ0NDJQTDU2c05ROEhRVjc0OGlzMFRHVlhieWhM?=
 =?utf-8?B?cXRucVpSRk1uS1B6NXlkUGJkcTJFSEFuNk9td1pOOUgwNkVHNlhaWXVvT3dL?=
 =?utf-8?B?RWRqaW9sZ2VWaW9uUzNTaUo0UCtQVVN6L1J0QjUwQmxIK1p3aWRjNXl0VzAy?=
 =?utf-8?B?S2lmaHNCOHQ1S3RqdzdYMmlBRlJDRk1wOCtyZ1hZSWFGS1ppMkVRekUvUVpq?=
 =?utf-8?B?Wk5NK1Y4cldGZit2YnNWZEp5TERJcFJzM2VsekI4NDVaWk5xNlgwdFBUQzVW?=
 =?utf-8?B?MUJQTXFWMnVYLzc2K3dSMmZxS05zNkkxT01EWThtTGV6cktDRFl3NUkralU3?=
 =?utf-8?B?OU5oQ1k1MVN4R3pyNnNVcEJDTzI3c0RrSm9qQnJQSVliVmpVelNLYkI3WWRP?=
 =?utf-8?B?L1RGS3hCVjBGeEROUFVDcitna1o5YzFYWGVIdm4xcENYY0pKM0hvZVUweWoy?=
 =?utf-8?B?dXVwTGthL012eWExODdSWXNYRWVFN0hvaGN2OGZSYUhxOVhROGZOTFVKYzFJ?=
 =?utf-8?B?UXp5QTROekxHSEpxVzY4RGxVQStEY2xyTGNVc3NiSWtDMkRnamlvSThGaGdw?=
 =?utf-8?B?LzlmSmhjWmJxakYzWUxIbDR4aGhGM200UVpnSTZSYXRtQXRtT1dvTzZLYVo5?=
 =?utf-8?B?UW5ta3JKOXFUUSs4RlFSR0hjRVRDTkd3bWlZVnM0ZGRNYlpiRFMvSmJObzRM?=
 =?utf-8?B?MEh4MjlvQjVZNTdUV3JVOG1HMHhPeEpCWFRRSFpSZGxvSDkrQXhDOFBLMlZU?=
 =?utf-8?B?YXRkQ0NrdCtENlJCejdsV0VrVHVlU3h5MjE2N1ZhdUtoSWxuVXgvQ2FJelhL?=
 =?utf-8?B?UloyNGZVdU4zQ29tcTRWaFlDMzZWZlNGd3V4SjV2RS9TV3RCcGNrSDJMRVRy?=
 =?utf-8?B?MUF6bzV2azR0dUZ4RnROKzl3TitmWE91RXo3RytwMzZKczNaNXJSSmsvc2Fw?=
 =?utf-8?B?aUVFeVRwemVNcWFwVm03WFB2VURqcTd2Q0M5RGY4VmRWNE9pWkllSE5DT1lQ?=
 =?utf-8?B?czIzZ0k1SzNkb1VySjhsczNIcHlWbWFYeVphdWc2ODE4Nmw3ZzVVNE80WFRu?=
 =?utf-8?B?eG1WN1VVVnRjc1dOSkJHbGhINTdzUVoxSkJvREthek5zWjhtNFdEWjM4THBM?=
 =?utf-8?B?YXV2S3JCbUJseFNnTkl1NFc4bFl5ZUdlZG5Mb0VXRjAvdG1PUDR2cGtTMUFl?=
 =?utf-8?B?cys5d2k3ZVZBMjlFWkIzZDRuTmkyQjJ0U0swQXA1TWFBOUlWMU84aUFVYmZK?=
 =?utf-8?B?b2p1bVgzdFM1TUhBK202YThZZGRKYkRycFdLMkJocE5mMCtZSkhXRUgyRjFi?=
 =?utf-8?B?STZFZjlVQm9IUjNyK24vMVR5RWdBT2UvdlB0eGRoZ0ZMR0FKb1dESmNod3Bp?=
 =?utf-8?B?SGI4V05Eby81ZkV0djlzM3F5N2UvK0dEKzRJSHhWVnFYL1VXOW1sa3hLbHFQ?=
 =?utf-8?Q?BrGIlAOoAudw4A9c/iyQKFwng?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba8c781-efb5-4b01-1182-08de0a262da0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:00:22.7405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YokYx92XINQ4nu7iOFCHzZrQuE8+HvUboWrRJmCd7f1YgxtvL+Xb5R8T84zrI5Z0mhlLuxb9nCOwj3ZuicNTJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
X-Mailman-Approved-At: Mon, 13 Oct 2025 09:18:15 +0200
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

This patch is used to enable USB Gadget in SPL to make i.MX943 evk board
can use SDP on USB3.0 interface.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 24 ++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 40 +++++++++++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        | 14 +++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index e6abe7ed2e0..3995176f090 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -22,6 +22,30 @@
 	status = "okay";
 };
 
+&usb3 {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	bootph-pre-ram;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	role-switch-default-mode = "peripheral";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+	status = "okay";
+};
+
+&usb3_phy {
+	bootph-pre-ram;
+	orientation-switch;
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 9b2c1072366..8c89b8be04b 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -199,6 +199,46 @@
 &{/soc} {
 	bootph-all;
 
+	usb3: usb@4c010010 {
+		compatible = "fsl,imx95-dwc3", "fsl,imx8mp-dwc3";
+		reg = <0x0 0x4c010010 0x0 0x04>,
+		      <0x0 0x4c1f0000 0x0 0x20>;
+		ranges;
+		interrupts = <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>,
+			 <&scmi_clk IMX94_CLK_32K>;
+		clock-names = "hsio", "suspend";
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		status = "disabled";
+
+		usb3_dwc3: usb@4c100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x4c100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_24M>,
+				 <&scmi_clk IMX94_CLK_32K>;
+			clock-names = "bus_early", "ref", "suspend";
+			phys = <&usb3_phy>, <&usb3_phy>;
+			phy-names = "usb2-phy", "usb3-phy";
+			snps,gfladj-refclk-lpm-sel-quirk;
+			snps,parkmode-disable-ss-quirk;
+		};
+	};
+
+	usb3_phy: phy@4c1f0040 {
+		compatible = "fsl,imx95-usb-phy", "fsl,imx8mp-usb-phy";
+		reg = <0x0 0x4c1f0040 0x0 0x40>,
+		      <0x0 0x4c1fc000 0x0 0x100>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>;
+		clock-names = "phy";
+		#phy-cells = <0>;
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		status = "disabled";
+	};
+
 	usb2: usb@4c200000 {
 		compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 		reg = <0x0 0x4c200000 0x0 0x200>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index d308d29a1a5..e4fcf2eb576 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -100,6 +100,8 @@ CONFIG_IMX_RGPIO2P=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX_SCMI=y
@@ -114,5 +116,17 @@ CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
 CONFIG_USB=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

