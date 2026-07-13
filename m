Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C43EC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 17:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C59C84C6B;
	Mon, 13 Jul 2026 19:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mn5VHdf4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0690D84C6C; Mon, 13 Jul 2026 19:51:25 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75DFB84C69
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 19:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNkhZ+yxbI/35t6Cd9iWRTA7T6EZ0CeHHFXLO6gq0MRyFvU+efvdtdVN6dfp5A59Jg8vl+RKzohbfxjWFXTFt4juFeWuof7RAUoNx++5bYpuPgCA4pxzui9UmMY/0AVrv2HMB+xzQCTpDWWKGE8eV+H68bJq1RiDOpk462/7wlGHdorzOn+x6zT8wf7DtV9qtZDMFhKKmOqA8xlr17CrHE1BZjMpDIfAhLSuaaKrZfB3Yy22n3hMmpqHN8yb6Fae7MgNnYnr4KcBB3G15w3foY2ky9CZAERbTB04Rd4cAvLvdaalWN4Fgl5VaaXDEWG153cKLoKsxxuIWEWWDYdA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wrO8jbpUG3MCP1UndvwDVKA4v1EDAjhSrMJ42w4H1g=;
 b=i3HJmmXTxW6IBGfglIRK6SigMC2GR5BdX6kAI9+sbqrNb12c9uhX5dshO6SqYA4HERLUzmwK2h/ReIK3hb8I6ZCYOMYrCETULfEXo/bLpVeIg3sUvrhiWC6El8kqskP9yHqsT7k1781nOPNM0ZrxE13dHqYXpdb2R4y5Bve9aMQOomzp5eSsaQMDSf3TLtjnahbR1cFlGh384UERcki8bGZ80A4mw9z8EIhDZwBL4ZTuJcd3ucp6VP1RrcQGtKgBbv4zVYhJdaCBjiYM0GY9bLi+hGKVboI8RaGa3Nd04BTjDNEtHzABA6+V03EOy8YXQZ4AFbMl45Z/CrjOB/EjaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wrO8jbpUG3MCP1UndvwDVKA4v1EDAjhSrMJ42w4H1g=;
 b=mn5VHdf4x41jic9JiN5YiOdS7o7HDhsHZNYnDuFpCzRWRKfjF/vR6qU7pQRJaa1eMuoWaE+ar63S6oIinRaq9siBak5mt/Jx5tLkfiPwPrhQ4aPtUL7OXLaAtzuTee1mwMA62MI8QnwjUhB6WdZrBW+p6TRuRobrhl8ILZIyD1VbD7aW7lL93ds3WwV0h1N3bYN3Qzce9ZyzgkUHNpdUoQO7p6vrn2QipgN9O9g7Z0g9FtaG8hj/ktOpVWtXX2pBwpL/PvcYOdur2EPAtr02bsYOmXoSKaWCojWB4Nfsm7Cl+RgqsVmkCkhGA9CDU/WEFXKXA81SYM0y7ABxGdQevw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV4PR03MB8259.namprd03.prod.outlook.com (2603:10b6:408:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Mon, 13 Jul
 2026 17:51:18 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 17:51:17 +0000
Message-ID: <f37902b5-84fb-4ab8-9ea4-9cfd6b7ffdca@altera.com>
Date: Mon, 13 Jul 2026 23:21:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mmc: fix mmc_deinit regression when card is at
 1.8V signaling
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Yanir Levin <yanir.levin@tandemg.com>, Eran Moshe
 <emoshe@gsitechnology.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>,
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>,
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, Peng Fan <peng.fan@nxp.com>
References: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
 <20260713-mmc-fix-v2-5-b0ba3b4a8d97@nxp.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260713-mmc-fix-v2-5-b0ba3b4a8d97@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0234.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::9) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV4PR03MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: a4734d46-6c95-4805-b102-08dee10756d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: uk2OK2oXq0wq4ivthe34Qi2jXTHWSm5QnqRsR6ytenDTXPkBa5pnSAc3ezxPaGLw9YYQtYtSab+tw++wKg4/ur5s7Y1gOqPbpgX78iG8L2P5e8LN+i99XNP5bNNL67GVhurwr4cqLggVb73ZI3U2pla1rFJFfOPiGZXbCpzvjR4zxQ7Bf7w93NiXSPYPHwsaJyCMQYs+ICEZAXlY3sOTrDTE2ZAqrnfy7k9Npf29b67XWBr60PF0l80KI/6sK6k/sORfbcER7CAfuARWszckOlKML4u/QAuJWMae4vaHPaP+fwuJafdzbO5VHeG2lDZ2UFGp6h3XJMAr5xSoWqBcw9rRUs4UqrawT40Hei1ynZFHxw+gK4ZAVMjA7B7v7z1yhBtgqhYtBrMpCoALfSUsDbMM6XAgh/gEbdygNEwH4ugyqxKY/9JW+PMaFcoTpjmIiNQq8z5zW3l67HMMwiWp1EIZ1WafRqNVDGc48RptrOAAgWDwSg+jjoiDXHcVsQAgZriIAwYvI1P5lrQMdLs5h9aXvKVwPiL34m1hRildmNCz9QqhN12kQ0iNXSX1AcsimTgcbc+AUa2ob553E8GdCLQ069rdnKtNrNd12jFDTSdIUvlBIRHdc8AyrgslpZA6JKiHnRf4AvbdD1HVt2qhjTBO10/QvrygugHNwaojUFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk9QakVXcWpPRUdCL29oN2xrWXovT0FJK3ZBU1Z3bDNUN3FxeWhwSkl3ZmZJ?=
 =?utf-8?B?Zks1SXVLMFk1d2Z4dE1kYWErUjNTQnZNaENiRmY0dTFpZTVzdGZIVU83SHNE?=
 =?utf-8?B?Yyt3VHRQZXBkME1lY0srMHhXVEUwUUZ1ZnN5OEF5MHJZS3BldXNiOElFOU5v?=
 =?utf-8?B?YVdDaVlqTUtuQnZYZVcvTUFzb05zbDhlaXhzcndGS21Dc2FDaTRuN24xUTFZ?=
 =?utf-8?B?Y29TQ0dTcXJRWlFUNHhaWmI4QVJwUWVKbXpkdFhtaU51cFN3cWVyN2RWSFlj?=
 =?utf-8?B?Tk1OLzBMZHdHSlNheXVZNmU0UDBONDhBbkpoN1phdTVYVzIyYktLSW9sa1Qy?=
 =?utf-8?B?SWVvdTAxYW9KV2ZQY1NiSXlaamtxU3BIK08yRjBSU3VrWHlGV3NQZ0RONU5i?=
 =?utf-8?B?ZGVpRS9hV0NoRFYvWlFyV2x6M3BEbm8yRlNkbHozQ0Z6cUljRWZRdDNyR3hv?=
 =?utf-8?B?N3Z2akRjbnp0dW8vanlXYTdpVFF3dEhiNEhPdHpKZlRxUDhCdktzbDJJVWU3?=
 =?utf-8?B?NXE1ZkdtZ2pSSkZIeTJPRnlSSnlhOHFSWmNkQnlyU1UvcldyUEo4R3VMMGFx?=
 =?utf-8?B?aFRneldLTXJqVHdhaUVwNmdDekl2QWx0TFplbUVLTnlyai9va2xLRXdmcFlk?=
 =?utf-8?B?U2ZxUk9vUGpXOGVQK3hJbjJRaUx0aUw5VndEYU9LQXFvT1Z0YWQ5Z05JK0tK?=
 =?utf-8?B?R1FzbDdDNjNVRXhRQWU2dVVZUTZlcWdod1p5V3krRVhnNXp4TFdYVWpMc3BS?=
 =?utf-8?B?NjV5alNMam1SZFFscjVWbEtyVFRkdDNKNHhMVENTdEtQYUUwZVFVdmExUHJP?=
 =?utf-8?B?V0VzKzFSNmN6akRUQXIwMWN5VE0xaUoxdG9Uby82Nmx3TG1vblF1RGVQMDBQ?=
 =?utf-8?B?RjljcXVOdWNXTTByUlRNRGNzNStWTlRmbkZxcTd1aXlpaFNkU3NDQjM2dFdY?=
 =?utf-8?B?MWhNdkRNZi8rWUI2aEFpNWprU0ptMWVkVkVPNm4xRHBnWUhpQ0tLdVUxUmkr?=
 =?utf-8?B?NENSYVRvYVJBZG9SbEdycmhDUFhERDR3am1seWhJaDdmU0tJZXY5STB4Rldi?=
 =?utf-8?B?cEFiK2hiN0RJZnVGOGx4dDJSOWtFaEV6UGdBMkxKSzhPdG40bWVGS3hKR1Jw?=
 =?utf-8?B?T1kzNjJsbjZlc3dsNTBwRlZwVkFGV2pFWmtUTnc1d2Q0UXJuN1F4WGZRR0lS?=
 =?utf-8?B?S2dNV2loSkpOU3c0ekhWcUR6RitXNnRWaFRLR2N0c0cvWlFiZ2Y4cnRrVVdU?=
 =?utf-8?B?WXJiLzIra2x6ZTg0aWhEcWNxTkpKbzVzN0t2WmtoQ1FOWlpjNG5ya2NzLy9v?=
 =?utf-8?B?MUx6Yy9KaC91SytWanFPYmtidjV2R1MrbUFpN1RLQ01WbGRPMzhhU1kzd0tY?=
 =?utf-8?B?bjNwMXRra2xRdW1ZS0NZbTJWRVlucUZMcHZtbEE4UEVyanFUcGF5cVVsTDBv?=
 =?utf-8?B?cmhEV0tVLzVUdzJUTURpYnZRWWN6NUduUzBpU25nK0x5cDB5ZGN3NnZLUTY0?=
 =?utf-8?B?T0EwUm5BQ20xM3JtaEN6MFZVNVZBT0VsVHZ0Q0FMR3E0QSt6bnNGRGtpVGxq?=
 =?utf-8?B?akR2RzkwU1pjeWdFSTNCRzcvc2g4NlNrbWIrRXRDMW5SK1Q3WURtTVNEaXc5?=
 =?utf-8?B?VFBLODBQZzdERzRVdXRRbHMwK1h1d0xWK2VTYlhKMkFjVUFFUkQxZlI1SVJJ?=
 =?utf-8?B?OVlkelhLMHpDUzk0ZU1UWHlHYUsxTFBOMENxMUplRUNqWm8rY2xKUFhGelRl?=
 =?utf-8?B?Q0xUVXgzT1FxN2NDOGc0S3VFZlR4OUNvT3lUOHZra083QWhvRmVTM01RNzhP?=
 =?utf-8?B?K2tXaE1UQk0zWXZJV1V1NGlMS3F6N3h6dkFoanBzUElvL0RTajFtT21VUU1K?=
 =?utf-8?B?Um9xNTNKbnNSRFpheDBlMkVhT3ozUmM2QlhxY1U1emRZOUR3S2tsQ1k3dkdy?=
 =?utf-8?B?dzErOHM5ZFRRVCswZ1hFS0YwRkJMOG5FK2liS0pSUWhhU3lTWlhNNFJCSy9s?=
 =?utf-8?B?cE84Q253MzhKOHk2Y3d4MzE4TEVka2xIMmJOVE1UaUloc2JLaVgrK08yWElx?=
 =?utf-8?B?aFZhVys2K2lJditkNC9rT1J0YlpWQjFQUTVRU3NwenZ2cWE4S21ZUTJRdVcr?=
 =?utf-8?B?SWZlMS9KZy9mK1pBM0Mza0hFZ2d1RVJUbk9uTmt2NUpoRnBHYUMwYkRaWURn?=
 =?utf-8?B?Z2tFRnM3ckpWSUxOZXluRXFOVmlKUFg5V2d3QkVHaFd0OVNZcUh1V0F3aXpq?=
 =?utf-8?B?MWtxRlZhLzBZRUxtZGx0S2FtbVJaenIvTzJFRVJSNlpCWmFtVGowcDN1Vllq?=
 =?utf-8?B?WXAvSGRHTUZzUEVmLzBSRWlhWmNwQ25KYlNRWFk2SFVrQzVudVllZzkxWDlN?=
 =?utf-8?Q?ksDc61eoya1cobFU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4734d46-6c95-4805-b102-08dee10756d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:51:17.4212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yi7P//HcLtpLeouv76OuGHiWa6Gkc+UpyPpR7Nzh0k09xAx3q7Gb7ugklSSMcVwnPh66owoOX3J5S8xr0inIieU8i5ZFCE/IoPXRkBkXIPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8259
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

Hi Peng,

Thanks for making the changes.

On 7/13/2026 7:02 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Commit 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without
> power cycle") added detection of cards already operating at 1.8V
> signaling via mmc_sd_card_using_v18(). This correctly handles the
> warm-reboot scenario in mmc_startup().
>
> However, mmc_deinit() strips ALL UHS capabilities from the card caps
> and calls sd_select_mode_and_width() to downgrade the card before
> kernel handoff. For a card that has switched to 1.8V, uhs_en is
> already true (via OCR_S18R in mmc->ocr), so sd_select_mode_and_width()
> attempts UHS mode selection -- but no UHS modes remain in the filtered
> caps. The non-UHS fallbacks (SD_HS, MMC_LEGACY) are 3.3V speed modes
> which, when selected while signaling at 1.8V, leave the card in an
> inconsistent state it cannot recover from without a power cycle.
>
> Per SD Physical Layer Specification: "Once the card enters 1.8V
> signaling mode, the card cannot be switched to 3.3V signaling without
> power cycle. If the card receives CMD0, card returns to Idle state but
> still works with SDR12 timing."
>
> Fix by using a UHS capability mask that preserves UHS_SDR12 when the
> card is operating at 1.8V. SDR12 is the minimum valid UHS-I mode and
> is always available at 1.8V signaling per the SD specification, so the
> card is left in a consistent (1.8V) state at a low, safe speed.
>
> Fixes: 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without power cycle")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Signed-off-by: Tanmay Kathpalia<tanmay.kathpalia@altera.com>

