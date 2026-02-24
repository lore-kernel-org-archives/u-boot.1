Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49498F4BB6F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 18:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956CE83981;
	Tue, 24 Feb 2026 19:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iJ9smdSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9D783D8A; Tue, 24 Feb 2026 19:38:07 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BFAD82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 19:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5suP2s3mRyX14iVbUmArr5MAuFIcqoHWY3aFJq7q/yLyWm27XjRPgdPMu5aR5k4/yJgdSBj5iXJnrsX1Gg7G9GzxBXHO7lNPIVEhu3UeKssV+G5uxT9pefP6xLipG79+CG8hUDF9DezUmAMw+Asu/Sb8Y0d/Znyq1Ew4u3Pp4nVj1BwDKCejRNeRwkSWc26KEvCDz/4J/Oq0gESI6AIREVoFyJvcOVGFcwTQQ/EhlZkZsFLr1ti9XDCBr8gHQP2KWKASkr8rLXju1FdOTYZYeWyYXVDhRw3BA//3tLl76LcR1cujbe9EVhpPjFAETx+r72IvfrfX/mhGnjjwDzHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kisWOBAXBDFtwVi7MfdKLL+H5rx4Ls1UA5B74yzslw=;
 b=KA3Dmgv6kZtoJe0dioPbSuG/vF4afUfZl75QsbRTNr0aSKFTxsl1CsQiAu0gnX8yEpNgs4oeFWxv0Ni6jiU1VadnKUZDdLoAEQzsFsS9poNVcE5DQmcLaDwPxpRWhtcMgH1pqLGrWSFFkSbzxj3hz+5zii/HspiQzR2bGYB6+ixZJMi0LXiGrN/C5WCDaQTEfc/cq4eJxBpy/YthItR9Sfn/pcwSfmxzN/Z6Guz0hYToelYkcxrMcjbCXCZa8gFWJTGLgpeFkfaglFCMekrO2r2oWP08KWGM0bgykOikoTtnE2DDuW6I8+HXxIBb8TzfnVqJZWt+bu91tqSnBfIDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kisWOBAXBDFtwVi7MfdKLL+H5rx4Ls1UA5B74yzslw=;
 b=iJ9smdShA+NL0ILOPsU0Csw3q2tpUHGp7tNoGWNxTY+s+2kQcaH/fVovwCN3Iq6uZWPQQvjL4yVwboy9UovoCudfPMlndQE8QZ4kcHT7A35YY3g9XeECj5/1Wnx96fcXRj55MW5asIebxwNMwIPev6lq9o3Kfjy0N1dJd32c5bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB7717.eurprd04.prod.outlook.com (2603:10a6:20b:292::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 18:38:02 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 18:38:01 +0000
Message-ID: <e1e3d74a-8bd6-4883-9730-941a6fafe842@cherry.de>
Date: Tue, 24 Feb 2026 19:37:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3576: Allow pmu sram access for
 non-secure masters
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de
References: <20260108133234.4001390-1-jonas@kwiboo.se>
 <20260108133234.4001390-2-jonas@kwiboo.se>
 <fcb352fc-5fe1-4443-8c3a-153c182d6774@cherry.de>
 <353ab2a2-f866-4f52-a355-e6641588848b@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <353ab2a2-f866-4f52-a355-e6641588848b@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 797f1620-7f70-4d3f-84f2-08de73d3d6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHhSSWxVdWdIQ1VEU0RsWjV2ZXBzZWIzL05RNW1UN0RvUkoydERseGVnSnU1?=
 =?utf-8?B?US9zcVFpRHFiQzArWjFudWpiNGYyTE1YSHI3VCtOLzgxbmNhSXd4eGxTME50?=
 =?utf-8?B?YnplMy9JekRlQTdwS0lJSUNXYXE0Uzh4aHFxMWlHY2RmY3loZFJNSHdPVzA0?=
 =?utf-8?B?dGxIMkorMnJxa2VlQTNlUFl3VUo3RjU0VnEwYVFYT0ZKN1N6T1BuamV2Szk3?=
 =?utf-8?B?RFJudURQWlhpTGNnWG1zeWVFeHVGWWZHVjZORUxsckt2dEFKTHhuT3c2MlhY?=
 =?utf-8?B?S05NRTNBWkdIRWM3c2tud2p0NzhRb1FqUUVKR2pzRm9WUDdQRFArem95SGlO?=
 =?utf-8?B?VEV3YTJHeVpGZjRFdjlWQkQ5STZ6eXlobEdxcVV6VmxlaHFYbEw4aWluYU9W?=
 =?utf-8?B?NlJ3OGtuSkE3NnJwcHBRK1Z6TGZSenQzWlZLeCs4ZGp1aVZnTnowa2xNdFhU?=
 =?utf-8?B?RnBIaFZoVnBiS2dwci9yL2hkMTBQRmNFZWo4eFdZNlpzdXhIUTgrU05KbjJ3?=
 =?utf-8?B?eVhnSE1aUVg0cjRBTzI3Y2dSNW0vN21MS3hoVldvcFlxRTJadUVUZjNTM3dJ?=
 =?utf-8?B?TXAyVkxMMWY3b0ZFeVBuZlcvV2NwQWVHQUF0L2FxanlzbkR0enl1b1ROb2ty?=
 =?utf-8?B?ZFRETXRtUWE5K0Ryd2EvZTJYb3B1Z3VZWDJIbDF4Unp1c2YzSXNRejBVelNH?=
 =?utf-8?B?Mjc0TXRlQzhGam5wanlPbFgwUzdqOUh4WVR5UGMyaFVsTE1XYUhoUGtvMFBo?=
 =?utf-8?B?UXluc0c2YitYQ1Ywb3p3ZWprelhmaEFtSm5LR2pLeFZHNHFMcTlrSU9VUnJR?=
 =?utf-8?B?VFJEVEdWZzVsQ2RGN1kwOFlLNW16MERueGpicFIyU3MvV1ZYZ1ByNHNqblBT?=
 =?utf-8?B?ZlhxSmxzajJGTDZmZ3FzTG9SaFRGOFJSMU5XUXJOc2RMa0p2dXVHazV4RUxk?=
 =?utf-8?B?MHpwSTlaSG5nUUNzTDExLzg5Y1V4bXZYRlljNHBoZEoxNk9jS0J5WUZJNTgw?=
 =?utf-8?B?Q2swK2ttc3JWQWcwTExzN0VYaEljYXNRVjhXTXUwMm80TVFRUGRLUlkwRjBW?=
 =?utf-8?B?OTBoY0xkMXJGYmcvK0k4K09GampJSWVQbnlMRGRuUEovd0FQajZhRm95YkVK?=
 =?utf-8?B?bm90TXJjRS8zK2hydDBSTzFGMDRLSkF3YlRody9vczdMOWVxRHpEN1pDbzlO?=
 =?utf-8?B?MkVXTWpseGwvRVR0blhoaXQyTllzNzFNMHBabnJTdkxWUkxLVHhiZHptMEg4?=
 =?utf-8?B?d3JzbHJ5NWlOMERaNHdnc0d4WFhsSnFEZVdrWmpRWFhwL0Jtbmx3WWwzdkJ3?=
 =?utf-8?B?TXNrOVBTNEFqOVhIUnNIT2duakpNYXJjSm5GTHBKSjl2WjhOTE45YnRKdHc4?=
 =?utf-8?B?aHBYM2ZpS3NvTWd5Rkt2RnA2UVdNRVp4azRSY3I3TS8xemVrLzVTQjFVWFRM?=
 =?utf-8?B?YjNiOHZ2bkY4c2x2cmZyUElBN1lSUkdBK2xObnA4bW03ek11bDdTTHV4SjM2?=
 =?utf-8?B?L2txcnUwQWQrdWFaMHFFZzYxUkI0VlJ1bHNJVEZ0d2w5anAyMC8vVTB0bGpP?=
 =?utf-8?B?dkNvdDVlRXZPR0h0Ym43clhJaHNCYlpER3JvY2JxMjBoMEhoeXpPWktMdUNY?=
 =?utf-8?B?Vk5mSTJFNGZ2Y1FwdG95OFF4bld1M2dSc21RWEw4clk5U2VUcW1GZmFES2ND?=
 =?utf-8?B?MnlDZ1VleXdwV2lOaFBKb1ZqSnpFeUYveGJBaXJsUGhoS28rTXRBMkM1eHJp?=
 =?utf-8?B?YlVOcTFpWmd0TzFUcVVZSmFrbTJERS9OdjU1V0FSczJEYUlhOVJkam5TWWtk?=
 =?utf-8?B?akRmS1l2RVdPeklsTmVYL1RhVlBaMGxqZjVMRktCN2xBL0VFT1NMaEo3eWZK?=
 =?utf-8?B?SnF0S0Rnei9EUjZTbnN2N2x6WlNHWEpLRldLRG05UEU1WTA1L3VjQ1lFVVB4?=
 =?utf-8?B?endiSm1qODE0YXFZc3B6Tzh3UlFGVHh6MWVmbG8rV1ZWVzhjckRYaHVEcTV3?=
 =?utf-8?B?ODgzdWZieEZDTVZRUnEzTlljMFk2clc4c1NtNWQxRlpXSnhEU2JoS3NVWGly?=
 =?utf-8?B?a2xPZUdKb29sRExoTENrMlhRdWFVU3BEUFhEeEpHakU2Z1RrTGVNeGNsNWU0?=
 =?utf-8?Q?aC1Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0s0YnVRZGlOb1dISC95cWZmdThrU1J1dVIzUE5GRFdDVXB2cDBhdXVwdCtl?=
 =?utf-8?B?ZkN0aTZ0NkVhWkdZZE9Rd2RmT2ZGSzdzRXZ0cmNabEYxQml5T0RubWpFTHhz?=
 =?utf-8?B?QzVqbmxoNXpaNEVIUmRZSGYxeDJXcS8veFk4ejc5YjFDQmMwUVNOQXZ6V3Fu?=
 =?utf-8?B?M2h3V2F1eWVSSDdsRmF3SkhZR1dVR0J3aXd3dHQ1b3JUa1ExbTRvdDFaYjFN?=
 =?utf-8?B?anBmUlNQVWw5dlJaaVhPcG9UR0F0WkpFVDRBaGhmN1ZheCtSZFlVV0dkazUy?=
 =?utf-8?B?bklWWit6VnA4T0lVazJacEFCbnJiUGlaYlpMN201YXdvdHgzSDNKcXZSRlJx?=
 =?utf-8?B?L0RjcEw2N2VKUitLM2VPd3BscmVhR09iaGFmck1sMFFNOStxcUdIUjBpaGNF?=
 =?utf-8?B?d2hMZE5mdUVTTjU0NExZenAvNWpwL3N5UnRVeGw2cXdaYmoxdlYzT0cxS1M1?=
 =?utf-8?B?YXovMms2RlJKNEtGVWNzQ282aWpCSUVKL1NxZ1hCZm96VUd1UFE1bk5ZWVR0?=
 =?utf-8?B?eFBsYXRkVVBQWlloNmpkeWl4elFpdnQ5QktKR0k1Nzl0Vlh5M1VUUCtEU1Av?=
 =?utf-8?B?SkdWMEdZYnh3U1JFS0tTVmFZaXc2YWpyRXN2dktiejQrNGtMNUE5T1QydkpX?=
 =?utf-8?B?ak9mTGdpNzY1VHFpaEVMaFhPOWFkalg0SGtKQ0hnTmxQTG82QW40Zy9menlP?=
 =?utf-8?B?ODFLVE9mR2dHS2xCZmRza1JIYTVublVhaEdUVXUwMWE5dXdjM1k4NVNLQ3ph?=
 =?utf-8?B?K0JxTUNGNHFsU3drQWExaUx1VHBESU1ENHlkRzNJS2RlUUo5WmpSTG8rUFBJ?=
 =?utf-8?B?bFFqdWNJNjVzVWV4TzYzMEFneEdrcnZpRjJvVk5tdytSbmRjRzAvUEdpL0Zt?=
 =?utf-8?B?eUVLb2lzZDZRM29Xa2l5TEJJUWw4RDIwcHYrTWZoLzJCQWJrUXRLL3l1VmFI?=
 =?utf-8?B?Vmh4V1A4SHR4cEl2MUxyak54SVZmOGRGU2tscE9paEF0ZkNKNUlVclBUOFc2?=
 =?utf-8?B?MXE4SG5US1BNTlFabzVkNnZjMmdEWDlYZ3lEKzNTZjZyNHIvNkcva3d0bzN1?=
 =?utf-8?B?NG5laVdLcGlmT202cDlxNVlxMVJocnU0bXhONFcyTjFtY1ppc0hja1k1RDdP?=
 =?utf-8?B?UERlTVNCVDM1VDRRQ2VQVUVwK2VEcFgveUYyaHZGcVdaRDZHM0g4M3B3VExq?=
 =?utf-8?B?bHJVS09pczg5VThkYVZsUy9CM1VPTkYwbHpTblFJb2hmNDkvMXZiYlN6N0Ix?=
 =?utf-8?B?VVV2eitWUGI2d0lEZEVsZytSMjBQMjFxcCsxTGxPckVhaTJaRXFIM1ptYWxO?=
 =?utf-8?B?QjNKYkVSdWF4Mm1md3k1WUFubEVHZTFYOWtyd0RpNTNyS1pGS29XeWhXdURJ?=
 =?utf-8?B?OVhLZGxVZktGQ2J1OWw5cEVFSG1pdk4xLzRXK25wcUxmR2xTdEhkMUd4NnN5?=
 =?utf-8?B?K0Z1Smt1RU5YSERLS3JkWHV0eENIeCtEM2dqTnBCb0kvQ044ZUQxZzVGd3hD?=
 =?utf-8?B?VGdDb3VObElCZ1pmVzdMSnVENGt3c0xZVmhya0RLekw1Y0J1eFQwanNGSW1m?=
 =?utf-8?B?VFk0ZUFLcjJXemUxc1V0WDJIOXY0c3dlUUh2SVF0Ui9nSXBRRWU5aCtMUFcx?=
 =?utf-8?B?eHBJcHZ0Z0dSNGdhWDFHa1IxZXdzVjlPQ1pKNGFWYU1WcUs2aEFzcTNmc1FV?=
 =?utf-8?B?QjBScWZ6MDdHR2F0NmhXenpBQkthWWJnUFBmL0xOTTU0b0RUZVRzaUZIT0ts?=
 =?utf-8?B?VFpSVUZoYVB4MUhBY0xJUFdGcEhxR2dUYklaVmJiOEowVVlOaDdxczk0MEor?=
 =?utf-8?B?cHdKREpGaXE4ZnljZVNia0ZMcHFhdEZlL1NpcjdEUTRxaUtpcUtSRlA0UlFZ?=
 =?utf-8?B?WmMyci9LQUVjcGZ4Y3dTeFpXT284UEVUa253UUM5b1g0MCtWczdCWHliT2xw?=
 =?utf-8?B?UDFOc0RuektjUXg1d2lSRk5NYnNhWE8rNVRlaUdNNE5nQllack5UNmVyZmRz?=
 =?utf-8?B?RXlnVzJYME5sM0ZydlFXVXd3UnBHWjV3OW9HRXZxckppZ3FHOFNtQytJbUNE?=
 =?utf-8?B?ZWJDS2RDUnArWVphOW4vK2hnNlk2bnQ3djIzOWxSbTBGRlZhY0tad2d5RzdI?=
 =?utf-8?B?dVhZNUJpZEZiOVpoRlBicVFmOEdGVldYQXFMYzJ0aTA3NUhOaEpmMmJzWldp?=
 =?utf-8?B?SGZYUW0raENhSC9SdU9SY1A1RWVDaFhjZXRsZmRLSzBVTEozYjhhL1d3TGtK?=
 =?utf-8?B?VG5QMlIrRDEwdzY0SDJrSjlqL3VLeHVubVhGNGFFS3RhTlBwOGJGYkZqdkhj?=
 =?utf-8?B?b0FDcC95OHErY2FUeU13ZWxDVkxJcGhMVXdNc2JleUs3NGxWNm9NaDFyMjZx?=
 =?utf-8?Q?9Nj0AKIq7OTs47tG2n74f0/bzSfErlxDlM41u?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 797f1620-7f70-4d3f-84f2-08de73d3d6f1
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 18:38:01.6316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HSvaimi1ieVTgU3nI/LQKKkCgGbTNr8Osc6ENjctXcbmyn5z9J+IJM0YRwQCzHYK9xm7zA7IpNPcrDOlU/I2BseJGrTLwD40wGj9N/xi54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7717
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

Hi Jonas,

On 1/14/26 6:27 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 1/14/2026 5:27 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/8/26 2:32 PM, Jonas Karlman wrote:
>>> The firewall block access to pmu sram for non-secure masters by default
>>> after reset (0xffffbfff).
>>>
>>> Change the pmu lookup configuration to match the default lookup config
>>> for ddr and system sram (0xffff3fff) to allow loading TF-A using DMA.
>>>
>>
>> What is this "default" lookup config and where does it come from? You
>> say it's 0xffffbfff after reset and it's set to something different
>> after a TF-A has configured the firewall... Is it after a cold boot?
>> That somehow is different than a warm reset maybe?
> 
> 0xffffbfff was the value the PMU_SGRF_SLV_LOOKUP0 reg had out of cold
> boot, when read out at top of arch_cpu_init() in SPL using ramboot.
> 
> As implied by the cover letter any naming and technical details may be
> wrong and has only been deduced from firewall.c/h in TF-A source and
> printing out below content of a few FW regs.
> 
>    SGRF_MST_DOMAIN_CON0: 00000770
>    SGRF_MST_DOMAIN_CON1: 00007007
>    SGRF_MST_DOMAIN_CON2: 00000007
>    SGRF_MST_DOMAIN_CON3: 00000000
>    SGRF_MST_DOMAIN_CON4: 00000000
>    SGRF_MST_DOMAIN_CON5: 00000700
>    SGRF_MST_DOMAIN_CON6: 00007777
>    SGRF_MST_DOMAIN_CON7: 00000007
> 
>    SGRF_DDR_RGN0: 84000000
>    SGRF_DDR_RGN1: 00000000
>    [...]
>    SGRF_DDR_RGN15: 00000000
>    SGRF_DDR_LOOKUP0: ffff3fff
>    SGRF_DDR_LOOKUP1: ffffffff
>    [...]
>    SGRF_DDR_LOOKUP7: ffffffff
>    SGRF_DDR_CON: 00010001
> 
>    SGRF_SYSMEM_RGN0: 00007f00
>    SGRF_SYSMEM_RGN1: 00000000
>    SGRF_SYSMEM_RGN2: 00000000
>    SGRF_SYSMEM_RGN3: 00000000
>    SGRF_SYSMEM_LOOKUP0: ffff3fff
>    SGRF_SYSMEM_LOOKUP1: ffffffff
>    SGRF_SYSMEM_CON: 00000001
> 
>    PMU_SGRF_SLV_LOOKUP0: ffffbfff
>    PMU_SGRF_SLV_LOOKUP1: ffffffff
>    PMU_SGRF_SLV_LOOKUP2: ffffffff
>    PMU_SGRF_SLV_LOOKUP3: ffffffff
>    PMU_SGRF_DOMAIN_CON: 00000000
> 
> Looking at the above patterns and with some details from TF-A source I
> could deduce that PMU_SGRF_SLV_LOOKUP0 possible have something in common
> with SGRF_DDR_LOOKUP0 and SGRF_SYSMEM_LOOKUP0 regs, describing what
> domains can access DDR and SYSTEM SRAM regions, and after a quick test I
> could confirm that changing 'b' (10) to '3' (00) seemed to allow DMA
> write access from sdmmc, sdhci and fspi to PMU SRAM.
> 
>    Access rights between domains and groups are as follows:
> 
>    00: NS access,     S access
>    01: NS access,     S not access
>    10: NS not access, S access
>    11: NS not access, S not access
> 
> My deduced guess is that PMU_SGRF_SLV_LOOKUP0[15:14] describe access to
> PMU SRAM for domain 7, similar to SGRF_DDR/SYSMEM_LOOKUP0[15:14], and
> changing it from only secure access (10) to both non-secure and secure
> access (00) allows us to use DMA from the masters re-assign to domain 7.
> 

This is really the kind of information I like to have when reading 
commit logs, especially for future reference if it turns out the 
assumptions were incorrect, would you mind making this explanation part 
of the commit log in a v2 maybe?

I'm also wondering if it isn't something similar we need to do for the 
other Rockchip SoCs to be able to remove u-boot,spl-fifo-mode; on the 
various storage medium nodes?

Cheers,
Quentin
