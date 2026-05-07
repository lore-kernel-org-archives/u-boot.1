Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790BDCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B9B84A78;
	Thu,  7 May 2026 11:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iZXfdG40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4CCC84A8E; Thu,  7 May 2026 11:58:07 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314FF8394E
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY0PO+HDQlHiN9/SEcMcOAUhU+zVdrnHz2idlOUoD3a3CEWBpYKV1KxQwLhBiBngITPY2Zxop3GcD3LcUX3wRiepShSTDwTzKKIsur6gS3AOxLrYy62U52JyUnXoz3Qj0dVYfgDdFkCpYJG1u3e40+zEyF0Q1julbbLeaXGJDwudjBAX0B/4UgheeemOl+WEvreKeNmodSDSUBdkbP8erwW5Wh+J3oVU8k/oRdcSia8Ft5cWKODkOyJB2PzgctOrmKRjwxKCFCyggitkQcturfmLgHrBhQjcyoW0wnF/5YcLrnDvOzSqiq570TDf9chu6v8Y63qVETGUpTPTJVdXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dTW693sqNW0E2QmFi6tuJFWjKB2hxYy8zP2gWuoNDU=;
 b=hCL1ubLTKexKC1M1yZ/BLVAFmQhmzq3An8oaTe8RbcZ/cy5CeV/L97LaCPwprUCp6hQYGfzu9hEfSqM5QXYM7uPEffAzUZR3fYC58Eq5faYehCJnnRxqOmNCTLP6BD3O2r4yh4S9HHpmgQ+eJbPCGDm5pmyMnOpuGCHXpuHnyVKfjnE9ciu2FkrRkP8cBdk8Ztq8ZmXbQ7I5l8M9wSJCvU8TnyU4aSphCtLyYMkH9H2OfeWILCcKYLNDAZfFWCBHQhtlPDhchsB+CS0m+zNzhO3rJa4fNA7JEY7CrgHvwYpOu1Imub2VTDYu7MhUPDPuCB4ki/kU2pbIxW537NCJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dTW693sqNW0E2QmFi6tuJFWjKB2hxYy8zP2gWuoNDU=;
 b=iZXfdG40jrlmex0e2UtH205AtSYKAAzha2Gu/MWIbCbeB/8ORIpeRQPKyQi+9/nwEzL8Q9XCbfGSf0KkM79Rw8WgldMbrnOPjr/wz/C5QAd+b/rCtgTRRgHiMJLuhYGfb/RIUSJkLl+chmRHlpo/ZTy4oIVeKxwxww5sFVbcEq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DBBPR04MB7594.eurprd04.prod.outlook.com (2603:10a6:10:203::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:58:02 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 09:58:02 +0000
Message-ID: <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
Date: Thu, 7 May 2026 11:58:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: v2026.04 crashing on Marvell Armada 3720
To: Ben Schneider <ben@bens.haus>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::6) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DBBPR04MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: be1fac60-60d9-4aae-1d74-08deac1f20c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info: XOFIirlwdfivG1b8eBSMyNivdy0u2wMf882rq5EW65GQQfDhMmTp5TO20uAuSh8DYtPgPOAMrXgIq+HvVq5fRK8iZL8tnYNzhU58WuNPb+O6pT51/6o+SQECLU5p+57+cYA84JN79D7ADfcWCrWhMEh2d6On2Pj4/ae2VKMETT6ndKl49iby4jrldQp69EoLBH6jsIWHfOfhSCArniCt67KtfHbcs1vc67aIBm+uGIpScl4idsl4ySuah31AG3SC6O2dXfcdIFCvYhn+6HeF0UPl8621hePXpukwhRzvIpJAKQkhpEjijaAg8qFzWA8i1DXWFrp90qxHgLmnNL7eOFNMMWamLc3mkJkNxTABhWR58Jgerph0grc6mJPH8+Hhkif0I/D0P2IBGGqqOkYyOmNys85migXc4WdJRfxhuNfPDE1ERJDN7HeUNtQdvuCbeuWFk6mke+iKBZMB1K2W+hCcIbHolVQhV+0PZDT3AfU3SFy4gOsJ9BHLvd/n2aTuiYY1/D9jr90BfrC+Fkt9XMT/FLSSbT6WGZnASwdh/GbgPty9SKFisGeR7hf4u/FACNNh7K13hj/6LgJwPL0U7skreYzqegXA3rDRWBZsOTBxSBFEQYDrEy9tCrNVNFZmPG5AlNV0Jv78XUQ/OB70W5XCDkY2o4P1hA0/hSQcv+cMupCXJMOVf4FZDRYfVm77
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVQzNkVRSUR6SXk3aDRXeWVzM3REK2FqT0VCbzMvZGFVeU1CQ1hpdXA1dVpU?=
 =?utf-8?B?NE12d0ZjYUJ4RGhqM3hyU0lqVHl2YzFoY2xjR2NTbEV2Nmg1b3hZS1RiL0xV?=
 =?utf-8?B?NnEzNDZ5S29pZDR5YlF4Vlh0WGxpWGtTMmtpZEJ2TW8wdVhVTm5UOFBVVmc4?=
 =?utf-8?B?Tm9TTUFLM3hQTlBuSjdyOVFVNUFZekRpR2VrSk4xMHhXd0J1L01sNWRqM0xn?=
 =?utf-8?B?a0NZYWUwNjRvdU4yaWdvQzlxcjVPckd2dWUxWWJtby9lTnE0VW1jZXRFUEFp?=
 =?utf-8?B?RUJlenVNVmZpMUZQL3ZDQmhPSnlWSXlqc1dEcnIrT1dnT2tzVkpPOGFTdzJv?=
 =?utf-8?B?anFlR3U5TE16dHNWa3RMZUgxT0Ric1ByZmh5VUFVSVVlcWg0Q3ZkZVZ0SURq?=
 =?utf-8?B?YXpHUG1qdlJRWDQ3bmV1VmlxbzhRVEpaVjE2bDZqZFBkaVRxUDA3cVVILzg4?=
 =?utf-8?B?d2dSbjMxSnQ0OFUvMzUzcGZNWWdyK2I3ZVlQVUpPMk9tQjU0bnZHMzA5eXhT?=
 =?utf-8?B?WXByMktLWTJrZ2lZTjBJM1o3TWl0SGtVenZsbGlnU3JqSEJGRkVyVVVNcDNN?=
 =?utf-8?B?Mi85MXJzK1JXVmVnY1hwK3BDUDBxOG5RcGFwTERJRi90cmFuODVDdkZ1SVgv?=
 =?utf-8?B?RUdMdTRzeVhKeUd2blJpckFxSEtSZ29ZMTdvMGl6OUprdnI4TDZ6SllnNERT?=
 =?utf-8?B?U0JNR0M1ZDdSNy9vY1Q0OUtvdVRyMWtadkpxbXVlSTlEci9nZVY4TjdhRzNK?=
 =?utf-8?B?aGw5Q1hTNk8ra0g5L3lvZXVEblZhVXNhdjF0eENiMkZMKzVGbEc3aW9RQ0JT?=
 =?utf-8?B?L1ZMUnc2K1o1QURXdG5STGJnMXJkbTNRcmlHZGFrSlUveFZvekxxdkYwUmJS?=
 =?utf-8?B?d0NyMkM2U0JCWWZaeGVWY1ZkaWxZUkw2N2sxM2hReUJEWTd5Ui9Fc1RxMHdw?=
 =?utf-8?B?NHhoOEx6cVRLWWZLMmtZRXZabHhCUEtpOVpmam00RUVETGFWOGlRM1ZZOW9k?=
 =?utf-8?B?cVFrdXNDNXlhMUlCQ0NYdWRBWWQrSFdQRGFiZmE2TytQVlZDMi9wb2J4d3Y3?=
 =?utf-8?B?WHRzYmp0YmM5RHp1VUxienphRERMdDVaQUtGSkVBVE5GQ25lYm1CYjdjTDhG?=
 =?utf-8?B?cjd5R09ldWNkT1h3NmQwSW9SVHd6WFFMbjNLZER6K0hDY0p2NENqcGJUd2Qr?=
 =?utf-8?B?K2hPcUp0MUdLZVNJU3JsaXFkMS9wR1dMQzM5UXc5dzRGRmJUK2Npdm5Qd2dU?=
 =?utf-8?B?ZllJa3dpcGwrL1VjWm9JZnJDOExOOTk3QVJSUzBsT2p5ZzN5RjhleHFSTUd0?=
 =?utf-8?B?bGkrallHaFY1ZVd2Qk92TSsxNFNtM2pCdE9BNkhWR0dMTWFzNzBuSlVkMjhr?=
 =?utf-8?B?c2JZckVMYzJvOVlzSkl3SDVlQ2RzNHRQWis4UjQrQ0Y1K2FHbEhHR0ZoYThk?=
 =?utf-8?B?WndrUkR3RkNLZDRoSzZubldYZWd0UTF1OWdpekg5M2VUMHZnS1F0SG90eGt4?=
 =?utf-8?B?aFBTRi9JUCtzQ3ZHbDVrRVRnVVdxaHMvU0NNaVhLV3dsVktqbWZkeWwrVlFy?=
 =?utf-8?B?UDR5UEdPaXZ3c1NDb1RyMXllbGVKYjFmNjJ1L05aYzFiYUdVOFR1SGxQTXdP?=
 =?utf-8?B?R0NLSWJLUWZVOTdVaC9BKys3N2pkTllmQUJPNW5GM05mY3lMZitFZG5sS2k3?=
 =?utf-8?B?dVAvUUhZT1ZPVXJtVEJlV1hmZE05SjJ5TjR4Z0UwSVlBc2xHN3pKTkNkaWxh?=
 =?utf-8?B?OFBuYTNBVkdSTjc4WnpyYm0wODVmT0F5UVRERHBJZUlFSk9sTHgwV08rajB4?=
 =?utf-8?B?SjI0K1UzNWU5ajZicThIMStkMzBjZTdhdVFaZzJXMk4xTE1STjNoT0t2Mnpi?=
 =?utf-8?B?RlRTY3g2MDNHNFdnd1kveUZ1ZnpQajNicTArSHgwYVFMNjN0NjJZb0p0dTha?=
 =?utf-8?B?ZE0xMDlheWtKb1pIaUtGMnJtSUZPTGR4WFR5VXdLbHRoSUZmNXFwdUhCUTZt?=
 =?utf-8?B?SUhLWnlkY2NYZUp3eVFwcHdjZUx0MHROb1NsdnJrRWJnUjBweGpHMVowYWxw?=
 =?utf-8?B?R25VbTF6SmNSb2JaZU1Qb0RGajdtbHNmVjFmT2RML0k2NTRXaDdyTGVOZVp1?=
 =?utf-8?B?QTNuU3FQWStSV28rRTZkYzR4UGNjeSszQ3RrTE1NaFhBMzFKSzZTSUVaejVH?=
 =?utf-8?B?VFF6NVZiSzZMQnkxeU9sSGFvK0l1Rm9CdGJtaXpQSmFqY3h4alFtSi9GNnp6?=
 =?utf-8?B?QzlwbnFKRTUwaXZKbjFOV3NaaUxxOEVmM21qckxUUjZXeVFiY3NnbzBRbUtS?=
 =?utf-8?B?c0VVY1JzaTYyeEt6ZlVzdENmL21QdDA4bmE4di84ZkdtRFZYQndNdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: be1fac60-60d9-4aae-1d74-08deac1f20c3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:58:02.8019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7NNAVSxQ2MNN188jIJOMRuI0dSeFA1U+Nh274OYYF2mf8+9TWZuFt9DhKJRs84MyDNvsmBf8RZzbWc+hJbEjjXIHwNZHTxgdyDycVDxQtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7594
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

Hi Ben,

On 4/28/26 11:45 PM, Ben Schneider wrote:
> [You don't often get email from ben@bens.haus. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi, with v2026.04 my device crashes on boot (v2026.01 works fine). It is an ARMv8 device (Marvell Armada 3720). The config I use is mvebu_espressobin_ultra-88f3720_defconfig. v2026.07-rc1 is also crashing. The crash dump output when trying to boot v2026.07-rc1 is:
> 
> "Synchronous Abort" handler, esr 0x96000044, far 0xd5380000aa1e03fd
> elr: 00000000000369d0 lr : 0000000000036a2c (reloc)
> elr: 000000003ff4a9d0 lr : 000000003ff4aa2c
> x0 : 0000000000000098 x1 : d5380000aa1e03fd
> x2 : 0000000000000000 x3 : 0000000000000000
> x4 : 000000003fb07b00 x5 : 0000000000000000
> x6 : 0000000000000000 x7 : 000000003fb07b20
> x8 : 000000003faff62c x9 : 000000003fb00014
> x10: 0000000000000000 x11: 0000000000000600
> x12: 000000003faff6ec x13: 000000003faff990
> x14: 000000003faff990 x15: 000000003faff3e0
> x16: 0000000000000000 x17: 0000000000000000
> x18: 000000003fb03e10 x19: 0000000000000000
> x20: 000000003fb07780 x21: 000000003fb077a0
> x22: 0000000000000000 x23: 0000000000000000
> x24: 0000000000000000 x25: 0000000000000000
> x26: 0000000000000000 x27: 0000000000000000
> x28: 0000000000000000 x29: 000000003faff780
> 
> Code: f9405261 f9005274 f81e02a0 f9000681 (f9000034)
> 
> All code
> ========
>     0: f9405261 ldr x1, [x19, #160]
>     4: f9005274 str x20, [x19, #160]
>     8: f81e02a0 stur x0, [x21, #-32]
>     c: f9000681 str x1, [x20, #8]
>    10:* f9000034 str x20, [x1] <-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>     0: f9000034 str x20, [x1]
> 
> 
> I tried to look up 00000000000369d0 in u-boot.map, but it was not there for some reason. Any guidance would be appreciated.
> 

It'd be super helpful if you can pinpoint which commit between v2026.01 
and v2026.04 releases is the culprit.

git bisect v2026.04 v2026.01

should help with that I believe.

Thanks!
Quentin
