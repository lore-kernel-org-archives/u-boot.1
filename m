Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07011CFD37A
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 09:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DDAF83FBD;
	Tue, 25 Nov 2025 10:59:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="maY79ZE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18BA383FCD; Tue, 25 Nov 2025 10:59:26 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1095283FA5
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 10:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeXGyrVF6kqy85Djbd4Z0UtF0nQUCNTH9uzFytAN5R/+xotkxOYw2zSoeB7kaeYCXM9ZeAvY/zHLSYSFjLXRg2CTVvlvSUTthMjx0+lm2lzaAsYq3SLUsCF1V5TqdNi4vSSWm8YNrtApidMLil+o9DUnp2kiM7MpqAeNY2TujCZLX9oxSz4svTJvdcE1aV1IvuPrPsgbIVM9JyRLAAHanxu/tciA9zIrpLZzarslBFa/vQZCreJxw989CLyfsL8/XLy26Z13fAowIa80+ygsnUqkNz0JypHtDN1rMUwlk+Mj9Kii/svShMe4xWFoS31BmJMYk/MM7RFoB8dhqWuJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY/do1poy+IRCK52gDxJ/uvgLpeuksvWWh0fg+20Hss=;
 b=GogXrE8WpyLRDU+VpK+nKzMiPRuh6jzMGGUE7o5HBr+au7IuRr76TE/TCp/X8pvg35bE5Er/R527oM9IAfCZomHwD4OeQFuQx4RSk3i9E8Pcv7avg2Pcj6fVbTpu6ZlnVL828LuO+eTcelBz13Pln2JEIf5w9Aap9gO1S1kUElqhAh+a3VTVdd/jToC3NPFTABk+TQ8K8N9LhHTDgQs4z+3+rtl/y0BpRBK/j4IMw3kDB4LcUdHEyZTYnK1kZhxe8ZjgqlhiZnbBW9Nuegih7e/zfMyKWpVh5GA+/UFq5QsVNMHzwazcsQHK6uHN/Go3taau6cQgf48ZJrmx32aO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY/do1poy+IRCK52gDxJ/uvgLpeuksvWWh0fg+20Hss=;
 b=maY79ZE4k7rv5ZrhSnwL764770ZIl0q8fjo2bJZAy3kc1nu7K9ZldO/vPRgGh5AGK05mpMq2zUNv6p2PHLkPIP+ozNZApnsfoHtOwfKYC0oOpb1qLuAuWSvon9R5u+2Pgg3PSDXfqEzsj4xAzBlM0aHti/PMIGSeIOaOmHLGEmS/G9VMuAD3V7ht/BAuyLKUvu1za0AInGL+h9Uh2RQFdTBg1KtARBgagK7hXefDWIwxOy9pfKKrIn//V/GE1XVbmeak5VgLEXpFMNHpYgJvVOpPw2KA6aM8QIhGoyptoSqdo4sS2F/VE5WaB68Z2tG7NSSF0YEsXOQeZfaLWnN4YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9160.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 09:59:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 09:59:22 +0000
Message-ID: <bf13f555-b1e9-4208-9497-baa3870bc0ed@siemens.com>
Date: Tue, 25 Nov 2025 10:59:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
 <CAN7C2SCEnkiLtRyiRx9ykLWOWJFNkUOh-UNZ+Qaq=bD5wk_a=g@mail.gmail.com>
 <c813c1a0-d224-4e82-8494-1a7d2676b29e@siemens.com>
 <CAN7C2SBtyc_i3inaCMBCUr_x40_d1LqEARtb2iJms=rHt2TtsA@mail.gmail.com>
 <74bf28a9-dbcb-4bf0-8f99-9239018a94a3@siemens.com>
 <CAN7C2SDz08cDgKQXMwJfDf_pVfqhhz2BJhVKHk2WqHP+hhE5Ow@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAN7C2SDz08cDgKQXMwJfDf_pVfqhhz2BJhVKHk2WqHP+hhE5Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6106fb-4561-4d4a-8a6a-08de2c094eec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0NpaThJWkpmVVBGcis5L3pKTVU4dzBRM1FobmcyRmlqdnljTGV0RWxxN3F3?=
 =?utf-8?B?RTJJMTEydU5mRmVZeVBtejRzbUhPMUxtRTRRMXFkWnFURFkyWGI3MFV3bW4w?=
 =?utf-8?B?MTl3ZGE2N2tLNnZ0YVhTM01HY2ErYy9pQmRyTlVqWVpmYXFzZ3FBRHZVVXYz?=
 =?utf-8?B?VjA5R0dMb2pKMGYzNmdDYUFKV0ZhemFYTzZBSzBpTHlzVEMzL21jQnk0TDdi?=
 =?utf-8?B?a0tKOUxWWVlic0hwMEUvQ1V5Sk4yeXZIUFFMOVBKclkzWTBCcWs3SHFUREI0?=
 =?utf-8?B?Q1hKR2tQTGxGaTR2Y0cvN1VMd0plTVNxamM1NElRQjhJQVRlelVSaGZqbHhD?=
 =?utf-8?B?dHRZM1lCTnNweDlvYkJTQjIzbk1xdk9KS0swRTFJMmIzL21CT3k2eFBUM2p3?=
 =?utf-8?B?dXI3UFAyd1k4Ym9ocnZCd29oT24zcTdXczEzR0U3STdWaUFpYno3Lzhlazl3?=
 =?utf-8?B?c0pBQ1EvdE1Da3cxdlNxNDREQU5WSUMwR0o5SXpUd2pLYzUyc0xaejBHYmJh?=
 =?utf-8?B?Vm5NSUZzOXRJNEZkUVZUWGsyTFh5ZnNXWHBiUjl6M1Q4M1RlWlBMcTJocVhH?=
 =?utf-8?B?UHkzRXd3VnVyNENHMmY4SWlaZVlWVUFYWU9RNzVHMitmUnJ5RU1ZUTgybUZC?=
 =?utf-8?B?TlBJMTBzV2EvMHV0Qk9lWnJIek9qd3NJWnd6dXA1bWE4ZTFXbm83L09wL01l?=
 =?utf-8?B?aEpUOGJYRmhYM2R5WTZUQUU5VzF2V1R1bVNuaWs1NTNDTmxpTGlVdlc2dG9y?=
 =?utf-8?B?UzZ4ZzlGenY3ZnhISCtvWXhPUkpObFYxRGZKaG9VU3huR2tXQXVwSHBhYzZa?=
 =?utf-8?B?TVRtTktTS3RLVEZDVjZzeFFWakE0cmtpeEd0TnNwMms1WnArbE9qRHljV0py?=
 =?utf-8?B?TytYM3NKVTVpdVdUWWZmd1dQR2wxb09lOGxZckxneU1WRzEzbGJad25MUnhM?=
 =?utf-8?B?Vk1ScHFTcExRNW9HVlZTaUhvL0lhQjlqYXJhRFhRdUtDbURYOVlaYk5NQ0Ro?=
 =?utf-8?B?ZTFWNkQrM0NwMmZyZHlQVlFrUFhqOEJEQzh6U1N6elNDTWNnTk9RK3ZRd0Yv?=
 =?utf-8?B?Y3EvRDI4WVRmRHRId0tmbm5UTm9hU25zUVFPMStyOXBFc09nZW1TNW1vb2Fx?=
 =?utf-8?B?NTZWTDU1TUR0WDdkVkpyY1NodUJxMTF6MmQyZCtLNVFhQzE5RUdVWkhVbHFy?=
 =?utf-8?B?R2xnOFRlUXdBMDA1M0xVMFdRK0xqSnQ5eWVpS2N6dUtRUVI2SDFIeXN4RjdT?=
 =?utf-8?B?WGVyU1h1WVF6THI2by8vYmtpMGdaNys2SE5DK3M0VGhHWHRjZWQyUktES0tF?=
 =?utf-8?B?R3dEZ3lGcm9hUkl6dEZLZjREdUloVVBUUEluMlJGNkZpeVdUZzVTbDVES0xL?=
 =?utf-8?B?ZVJNYUJuUVBVWUVXbS9CaldpMHdWTkw1TjZTTVJYdWxUTGFzMVh3OFNXMXdw?=
 =?utf-8?B?RExkWjlYbzI4UTJDTlpqQVJscU4zQzNNdlNxSlN3VnJLVHZwekpicnRnMnF2?=
 =?utf-8?B?cmV5OUNIN3dyeVp6M2lWYXlaUTkrOUJzZmZlSGdQby82UGlIeStzSkdCeUgr?=
 =?utf-8?B?UWZHaGlLK0V4bnJ2clNaaHZYNERGSUdHb0EvUS9vRzlkY2xSRXZGK1Q4Skpn?=
 =?utf-8?B?alBHQ0VMdU1kUVZQNEhWdnhpaU9UZS9UNWFhalZ5Q25tK0xKbURPVlFMVGMx?=
 =?utf-8?B?d2pQeHYzV3hOcTFlSnNMSXlQaE9KdTBoVEovdnVtdUxZTFNCT3NOcnNhVUdu?=
 =?utf-8?B?ZU1Rb05BU1BibjVkVmNRend0ejNGVVNZazlSWnVNVXNxUk1zZVFuVFhUQVRY?=
 =?utf-8?B?ZEw5ZGNPcHVYdlAyN0xnMFA5ZUN2V0FsU3RETitDQ2dsbFYxckE2RHJ5blZ2?=
 =?utf-8?B?ZU5FcVBKMnE1UXJCcXJvR1kwVFNlejdqbm9qaXA0SUpBaTcxdDRHOXBmQWtH?=
 =?utf-8?Q?9dVF5SlyY2rCqwdgLoPpTNlFMZw4dckr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBmTWR2SDlmZDVDMStnUllqY25DakhNQnZvVS9lU0kwSHZ0OTE5dnhoN2hy?=
 =?utf-8?B?YWZ1bG13K0xuWm03eElkcHc4d2pXbHlESWVCU1hTTnJyeVR5SnZtbFNleE51?=
 =?utf-8?B?eWJ3U3EzNFlSbVlaMk5NSVdpdW01clhmZGxuUnV6aE9mcG5vTE9yKzFzNDgw?=
 =?utf-8?B?VFVVRjN0RStvbGRvZEdIRFUxNm1YdGc1WjY0UjVOTXhrT0xnY3ZHRVNrQnpy?=
 =?utf-8?B?bVhnZjcwSkJqMXlMR3YwMGhiTklOTitDUWxXbm1CanlsWUQ5cTFacnI1YUEr?=
 =?utf-8?B?NERkOUxIME84N2NFc2lyTlR2R2hRQWgzbTM0bkFFbGFmeUFaMEhINFptZFBC?=
 =?utf-8?B?UmxTcjJJWGF1YmdtaGVlckVnb1JHK01NdzlNZ1B2WVpJcG5zUThreG0yM3VU?=
 =?utf-8?B?VEVnNGQreUJ6SHhOcm1NeVUvcUZTbUxvQTYzZGxORUlnVjN0dGsrMlJqVDZG?=
 =?utf-8?B?ZDFIM3J6Q001TkFEbTRmdkYvMUEvdCsxVDh1KzJPOERUS1haREhiYS9uS3ZZ?=
 =?utf-8?B?Ylg1ekxoeXNDa3pKV1BHVlN1YVNOYmVHV0RQZk5hTEplM3JXQzNqYjVDNHJz?=
 =?utf-8?B?ZCsxWmhNYXlmaVJ4bkNmR3pWKzhLQlVBUUp1blFBNXlJZG9zME5oa1VxU0pT?=
 =?utf-8?B?Znl1RkxOYTRDeTZPanRINmpHSm1jYUFnNGFpV0hXY2J6MmRQeUZRQUhGTnlB?=
 =?utf-8?B?YXI0M3pKbXA5enF6TUh0aXRUZkNXNUpQWHF5c0d3c3lDdUZEY2dWNU1lenhO?=
 =?utf-8?B?L1A2S2pVNUhrUXFzT2ZSazZTVFZES0pVMzEzc0V6allKT1ZUUWl4Y1BNUjFo?=
 =?utf-8?B?bFZWZWZqRWw0R2daSVJySVNyc0FoNTJkbFlJdzBYRnBMVUJGRFByU2lVVW44?=
 =?utf-8?B?TjBhTEtEYW83SGdheVFWelNKMElsSU5JdjlFcTZXZjBMcDZlNTZvNEkvQUR6?=
 =?utf-8?B?c1BZRFBzRFFnbVFpdXhVU1ZXeW5PWFNxakZJZ3hINy8yRzV4c3VXZkdUaDhJ?=
 =?utf-8?B?RUxBVHpoOWx2ZkIwL1UxcnBVWmkvQmdBYSsyTVpxMnNMNzBNRktWaWZjeHJy?=
 =?utf-8?B?N3NZYTBXQ00yUUg2a1paMU1GZjF5R21nVitnSWRiY0I2enBWWXB5Z2lpbitG?=
 =?utf-8?B?ZW1raFhDMXhCbTNWT3VoNlp1WThjM3ZwTEk0RlNlVnhWQzhOcUsyS2l6bE56?=
 =?utf-8?B?cVV0WE5DNHlEN3doUlRLTVJMa3JPcmZ1YWw4VEFjaVliaXgwVmE2WUJXTTgz?=
 =?utf-8?B?K2N1bTlrVHJlT3JVMGdNa1NiWk93SDI2UncwQy9PR0lLKzlVcVBURFRSa2Jq?=
 =?utf-8?B?MGh5WlZsVWl5TzVlQXJaU3NnRm02VTIyWGVhL29ySlRONG91bHk1dGdTYS9v?=
 =?utf-8?B?c2Q3OWgrS2dUL1ZhSEhoM21IeTNpOTA3MUIyYitxRzBGa0g2Yy9zSEVNelEx?=
 =?utf-8?B?ZVlScWNTcFQvSkNwNlBlR3hZdWRRbkdzWFlxdVZ2MXJqRzZwV25JdWZHakp6?=
 =?utf-8?B?bkhvVllaUWw0QWxqbjE0UmVMdWY2aWtxcDJUWGNpT0lLSStpT2NHcVNRS25T?=
 =?utf-8?B?ZG8zckN4azVYNHQ2cE9pQTZBNngvZVF4aHN3U2FSL1QwVFRRYjRCdkVKMG9B?=
 =?utf-8?B?akU3TDRtYWpEVkdFLzJMVGg5OE5MTk5FUG5ZTUYwbDlyV2xTaGFTOU1UeFMv?=
 =?utf-8?B?YWVCdGtxdjdpMFgxUkYzVjNsV2UxenF6MUNRMzlMa1RBOFVKSWt0NllXYkx3?=
 =?utf-8?B?eDdOTnYxOTJJKytwYWNmb2JjaEZRRU5lL0NrWjJMSmNMV1k2Tmhza1V2NzZN?=
 =?utf-8?B?WUk5SHVabi9lem9pa1ovNUpCNk91cElkc2RmaXoyQ3BGQnozYlRyZGx0Tk1h?=
 =?utf-8?B?MnloVWJ6VnRzaExaZHloRkpFZGdDWHpVZ1IrWndPSUI3WEQxeVYyNDdKcEEz?=
 =?utf-8?B?ZEJWVDZzWnl0MWxsdEpiaTh5eXQrdW5TYURqK2RjL2k1YnQvWUNWOUlJYVRx?=
 =?utf-8?B?dHBhR01Nd2liTkg5ZzhsMkJGL055YXVFSk5XWWpPZm0wOHY1TmcxSklLR2dB?=
 =?utf-8?B?M0JDYVJWSGthcGJmbjBCeDB5KzFubmowYkIrcFRzNDZmWUU3MzdtbUdocm4z?=
 =?utf-8?B?WHBHdE15aFU2Q0RBcjd2cmpnZ29DWDJJa2dlSlVBWm5GNFR5VExUUjZoMk8w?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6106fb-4561-4d4a-8a6a-08de2c094eec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:59:22.5001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLLNFPPKog+NXbT48Yu6qTD2wSrScRIMOyPWlShqOsluFlN8yTRENijtzw6rJqBAcH6K1SB4J60kjhNagP3aLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9160
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

On 25.11.25 10:45, Sune Brian wrote:
>> That's because it never used that (intentionally). We always booted from
>> a partition ID, but the old versions had all methods enabled, and that
>> papered over the fact that they were mangled into something that was
>> supposed to use partition ID but used bits from the other paths as well
>> to compensate mistakes.
> 
> Are you using the mainstream or Altera U-Boot trunk from the beginning?

We never used downstream.

> Why does it sound like we are not on the same page?

Different boards.

> 
> It is not even allowed to select two settings since early 2025 major
> changes on the detection of the boot method.
> 
> [*] Use raw reads to locate the next boot phase
>                                            │ │
>   │ │                                                 Method for
> locating next phase of boot (e.g. U-Boot) (MMC raw mode: by partition
> type)  --->                │ │
>   │ │                                           (0xa2) Partition Type
> on the MMC to load U-Boot from
> 
> How can you select two at a time?

I was referred to the time before the cleanup attempts.

> 
>>
>> Just study my series to see all the breakages. It was never clean,
>> though, and that may explain working setups by luck.
> 
> I am using a custom board na socfpga on Cyclone V SoC. There are
> no such things about luck. Either it works or fails.
> 
> Completely lost on your case and the patch.

Your defconfig may compensate the bugs then. I was not lucky in finding
a reasonable way to adjust the de0 config to make things work again.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
