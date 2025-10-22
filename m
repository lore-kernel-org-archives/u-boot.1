Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EC0CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 14:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965F08323A;
	Wed, 22 Oct 2025 16:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BVesTwSW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E87832BC; Wed, 22 Oct 2025 16:25:04 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4BE82B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 16:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxCrVQg+RrxtxtyOlpQohUtYNviQwEDpwm19eAvcI66uHPHDh2zfQ8z7hVQy7N9yTImu9W54l40u83L4A05yOIIsYTM8KO/pkIbG4jN7S1TU1qaAlWOptGcMbbvIjImC2S0t7/2sU1pAx/1kxslHv4GF179Fxsy1OWSVVQl3jBANwOPqoTMF0SoLxZLYnto/tQALsgz5Q6XsAFERL5EgFF5+cTad5ozTK+M/SZ2TZFaz39nDHBGxLGuDOubSqg29rx3hRB11doMyJlio17KPn4U/gOnZH7WVm2HnUjt0AITS9Uq3olwe3Raj28+5q2uLohI1vPxzXT77dmTp4AcNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwZLIbeVtJ4x9GtdM3473PlBhF4AjFK2nM/EdVh65Kg=;
 b=FyUv34OwmdCkSoC6EPrX0TRVoXvIqkY3xujxUDINqOWFFc7BOtw1OHe/lVcnKrgVDx3GQFXECcfaIrAl6GdXJPc4h3Pbdr4Swbw/fU5UgT5m8x9YCuoN3BMcCxxwOtWcXBEp+6yjs5e65zUZZMtSqqeCKGvr5gijUDXI9MsJ5R9TRH1srmpkdOW/ZYICAPG/xZzGBo2FKvMCFpbHscfu0WpQE3cFISoXRTacz6kEbDfd0jxzkEF7tCgCtvppjNGAqoT3r7D6sXNBUnPp6Ow45GaltbZRBabnu2vQ5e6JO9O0gzY+eY+DiyH0TSs8Dru+29LheCmCEk4d5blrmhYZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwZLIbeVtJ4x9GtdM3473PlBhF4AjFK2nM/EdVh65Kg=;
 b=BVesTwSWzhPUssQcDIf/2HjBrF/CaNQISi6yUmWFsodhENmArYyt6coZuU/flgD92fJF8EZwFAFB5+84TRCy8cJ9pLAq8mkULiWYUi8p3VJP/8rA8ve+UIa5We86d3DAICpQpEVvOz/a1Fn53+yuY2TX62mHe6BbkmhNArcOb3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10766.eurprd04.prod.outlook.com (2603:10a6:10:587::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:24:59 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:24:59 +0000
Message-ID: <dcd6ca62-af8f-4602-aa47-9c63c5518c5f@cherry.de>
Date: Wed, 22 Oct 2025 16:24:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] doc: usage: Add general rule for `$?`
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251021202820.1272414-1-trini@konsulko.com>
 <20251021202820.1272414-2-trini@konsulko.com>
 <3a453e3c-9ed0-41a1-858e-84f7cad7b50c@cherry.de>
 <20251022135401.GJ6688@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251022135401.GJ6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10766:EE_
X-MS-Office365-Filtering-Correlation-Id: cca6fcce-9b33-4707-50b6-08de1176c7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzRpTHVub3MwU0lPTWZRaWdsZ01rQkl2RklFbWgwOTBGcmJlWUZqRWtCTkVw?=
 =?utf-8?B?MXY2b1d1blhvZWwzY3lFOFNSeWRETGZScVpzQ2VDT29YTlZRYS9xWEFBOEV4?=
 =?utf-8?B?dEIxZ20zU25MNEw1clhFN0xhSThIVkRvM3dqcTQvUUdpdkdxOXpjZUJyU2Jw?=
 =?utf-8?B?Mm0ydXpZOUluRFBvbjFIRjlRVnd4RkdxRGNKYnU5MGVPTWxreG5pVFdrR1ZQ?=
 =?utf-8?B?VHVFOGl2QjNOQ3hYbFpEeW1FMkN2bWZzcWdsclg0eUV6ZDQ3WU1ra1FmQ0lk?=
 =?utf-8?B?MkpJQnJwZVdPQldvNmVvYjgyc2lRdGJVNnZudWIxVGp5V0lZOWI2ejN2VDhs?=
 =?utf-8?B?UGlJNnJYZXl3bmN5SUZ5OTZ3YUNqdlI3NXNSaFcvZzJFNEtuVnVQYUtJaURs?=
 =?utf-8?B?RXpqeUw3Vk9WdGFyRXN5RWJDZHlJem1pTVZBWUtEaGZKYmVhN1J2dHJMRkRt?=
 =?utf-8?B?OFAxVHJhbUh6VTZHL290VWlkbGpNbW43VGxqekZhaVBDSng3MjdhbEFyaVlr?=
 =?utf-8?B?cnF3UVVxTUdrWGxMZ1ZLSmo0ZCtaU3EyckZYbW41U0tuZWp1djM2eDM0T1Ji?=
 =?utf-8?B?SHNOMTM2bU9XOXRERXNVbHVIWFdPL2k3SHVBTzd5bHZFTGpZejFIT09xZVo3?=
 =?utf-8?B?aVhvdUdFQTRscGN5cGtweWRIa1BVYnNJK3AvaHNISmFvV0ZiZGF4WXBjdE5a?=
 =?utf-8?B?UkVxOEtQcFc2dDZ4cnBvM0tiVDdWbmlVY094V1poS0NpVlBVK2FsN0VrOHEv?=
 =?utf-8?B?Z09pd0M3d0ZFZlRBNGVVNW9EVTdOQ2s4R01Na1ZLc3oxZlI0c0F1NUlPZzB0?=
 =?utf-8?B?RzM0WHN0R283MnRiUFZvMU56SnJzeDFWMjRIa3hKYk43UFdwNlNmMlB3Uk1t?=
 =?utf-8?B?TUV1aTVIejZuRDN1V2xsMG1ZdzFZWUtCOXJzU2w1WmxCWmRJSWNab2o1ZGNQ?=
 =?utf-8?B?Nm8wbWdtZ2gxNEt4QVcyWlU0THAxTWdkVC9paUpqWjhKRjUzT3c4TzMyT3Jx?=
 =?utf-8?B?MENBUnBRemFyS1hxTWRzN2tQRE1PSERJY2haTktISzZ6cDVQNU5KbmZMMy9B?=
 =?utf-8?B?ZDIvTnYrYlRWRklKbmUreXd3UVZ2ZC9BdEhyRTgzSXMzYnd0VURRRk5xeHp3?=
 =?utf-8?B?bnExY1VkM1g1VFpTS3hoalE5UkNRSGJybTRWWkxpWktNTk1TZ1BEam5adm9h?=
 =?utf-8?B?ekl5N0F6Tkw3U3AwbEFTc2pJRUJyMlVCeHpqcmE0OU43YTlJVDFyRlF4K3hx?=
 =?utf-8?B?Si9nVG12d2NoMDlCUkhsOU1EaXh6SVVXN1BSVnVGeFdrbnpMRE5qTzFzbk1S?=
 =?utf-8?B?ZzByeVhQVmZINXh6bWpIVVB0M2d5N3l3dkRsbWMrRk14ZjFuWW5nSjFyK1N0?=
 =?utf-8?B?ampjV2pzUkoraHV5M3RaMHcrUjZVSUNqWGw3ek0rWmFXOU9pcWoza2VRa0Zw?=
 =?utf-8?B?NXczUDB3NWpnQmdCTmtHQ1lqajN2OFY0MTdrVktoVDZxZlhvcUxCZTRQLzJI?=
 =?utf-8?B?ZlFCMWhKZHBrcUJhWTQzY2JVV3RwTGl3RDNvWDdXQ2MwSzQyUmpCbXBLdkwz?=
 =?utf-8?B?bWJQMGFHSWZZWVExcGE4OExZVS81ZmwwZ0NhanJ3ZCtiR3U3OVJabWR0eHZt?=
 =?utf-8?B?cS9wb0c0K09BVUlHZVB0QzdXckRVR2tyRlZnMmROV3lodk56YlR1WjlYYmti?=
 =?utf-8?B?bmppQUFpOGg3VlhrU3NHcjBSeWhYc2ZJYVJWYUR0TUhVUzNOdTIybVl4c1Iz?=
 =?utf-8?B?WXM0T3B2elNNdzN6TFl0a2pUbTJrSHdtVVFLRWZVZUwxcUkxSTJiWWlHMVo0?=
 =?utf-8?B?bEVoelBzTFU4ODRqeHFYdnNJRWdKUDFQNTlRbkxFRzVhdWdYVTBObVp3Zm01?=
 =?utf-8?B?YklZVHB0THJ1MUJGUTFCMzZEeHlrdWF6ZGVtRkNEeGVzMlo2S1JGTXZrdVZQ?=
 =?utf-8?Q?/o94hKrYFyGlu+cvmjHhfjmIRDO27lae?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R21GaDZGRFpaaWtxRk9JMEFZR3hXME01VFVDZ2t5Tm40NWVranptVU85WWFK?=
 =?utf-8?B?MCtDc09raDdhMlFuaXpNL3NCU0sxV2xhQTk1cWwrSDFNenBxOTU1TXhYb1dN?=
 =?utf-8?B?dFVDRHArc2xSOXFDYXNuT2tFOHpLQ0xVK2dkRmxLaUhJeXcybWlyZG85Z1BB?=
 =?utf-8?B?YU9lZWx4VDRNTWVoVWJSOHFTc2EwQWluN0YzNUZkckpNVnpuSG1wWGlJbTd4?=
 =?utf-8?B?cXFKcStMZzVqYTAyQjdvSVhaejJZWG93OGRqM2VJaWZ6cDQrcFV4MFk3TzVU?=
 =?utf-8?B?dHhwN1pTQURuZDBZZ2hFcnczRWxKWThIUTNVcHFyN3Q5ZTgra0IrVWoyQlln?=
 =?utf-8?B?UVprbDVza1F3Wm5QQU4yZTZWN2NBZVlseW10Sk83M3hWTFpuUjA1c2w2bnFR?=
 =?utf-8?B?WGhJcGJyU3hZdW1lQXgycWttRFRJekM1ZzJQNUo0MlVKU2xLZjVoQkRPdFM1?=
 =?utf-8?B?dStNTFJjcm8rMWNBSktaNXhWRVFtVTAzOHhxeVpjVHRoWGJLM3l2SFExbnZP?=
 =?utf-8?B?UVk2UHBzY2c4cjhpZkxteE4xaXZBcEdVZWJRNzhRUHF4VVptS0pjK3Zxd05w?=
 =?utf-8?B?RWtyMG52T0hpcXhGdkF3S2JsSWFYRnpvRGVtQVo0dGFIQVpJY1p0dVFIK0pE?=
 =?utf-8?B?V1BCaFBVSkpVQWc3ZHhOWGxNU09TT0dXZm9yOFVGSE43Wm5hNWlGYTRLSndK?=
 =?utf-8?B?Tm1CSU1nOEVlMUgvZ3RvWS94R0xuazJtU2Y5K1ZnOE1YUzREeFIyV0prNG1Z?=
 =?utf-8?B?dFZwR0JtSDJybTRmNm9Pc1I3NmNaTUNmTjM3UjVHOUJidDYyWkJvT1RETEt6?=
 =?utf-8?B?UWZKTjAzV3JmcFh4S1pQSFZCZjdOaHlVamthbllJeUZyR2gvOERhMUJwSGo1?=
 =?utf-8?B?OVBRMk00WE5LcU93aXRKWGRlNkNzOHQ1MFFNMDlNQnQzUVFsS1RxSlM5N3hT?=
 =?utf-8?B?cm11SXVPaEJxSDc5OGpUUTM2WjcvRWR6dG5ocnA4Um0rL1k0aVpFOWtFK1A5?=
 =?utf-8?B?eHpKVlRtSEdRbGkyUDY3WUJ5TXJodnFqYXdSVVgvTWdDamJKQ2h0U3hTVzlo?=
 =?utf-8?B?cVZqRE5tZUFGTk1xTXFjdU1XMjl6SksyTGV4SmFOYXFrS0tkdHZlNUFsbWZK?=
 =?utf-8?B?Wk1KOTFrWjMyMEZQMFNsR3NGMGV4WVFRS01nUTcrY0c5UlM2c05LUHdCRmYv?=
 =?utf-8?B?MVZBRUF5c05lRDJvUzhwZmpQYzJSVzlXRFg0am9RdHN4eDJYbFhPeTRORnhQ?=
 =?utf-8?B?WTI4S3RNK3lOOHV3K1hZMFY3Y2dIb3RwUC8rR3I2YXprSEdMak5lQitKYkcz?=
 =?utf-8?B?cUx6SVNHaTIxeXJWb2RxeGZrOGZmRC9aSC9TOG9TemtuVWtKYnJVRldkMXNx?=
 =?utf-8?B?SmVNL1BId1dnOGVSRU9oNGtQUCtTOElBK1ZsNGMvMXRtNStxdkc3dmNGd3A5?=
 =?utf-8?B?RzNtQ2wvZGRNZXF2clJ2R0Z2NzdFd1dOVjlwMU5PK1BsSzR2d3VRUmd3VTZV?=
 =?utf-8?B?UmlOTzliR29kZ3ZYUFY1aUc0amtqSW9jUzJRZGNUZHE4SW41a2hwajBmMVlI?=
 =?utf-8?B?WVFLRzQ4MUJCRDNiVU9oWE81dGkrTXQxL2sxTmZPTGJ0SmVJZGJLcnV1Tklr?=
 =?utf-8?B?T3ZBeHZCZS9tbTl6Yk1xRzBMN1BnK1Y3N1BpR3VmQ0I5OGMwdG1pQmRxRWk3?=
 =?utf-8?B?VytVc1lCeGttQTFUcUpvcFNpa3BSZmtsTnd2OG81M3BGeTFtVjFQWjZHWVds?=
 =?utf-8?B?S21qektORmdoOSs5NHVXNit1eEc3cEtyRHRGYmlhMy9hb2hkcnJBdTlWZDdt?=
 =?utf-8?B?Z2RTN3NvdDk4eWFFcmdjL2dlNkQ2RnVlRVE0Z0hMaXpENW1rR05nYUNOVUd3?=
 =?utf-8?B?Uk5Rb2RCNzJkOTVkTm9xRzlmU1ZKVFdGcjYzaEtsc2NvWVlzNEN6MEZVdmk3?=
 =?utf-8?B?SEFKM3FZUFRpOFVxbTBCYUUxUmJiaytROERyZ0RES015eURBbXNkYy9yUHQ4?=
 =?utf-8?B?V0FXOXdZN3dqaGVybitSRE9JK1RqSTFrL0tGVjBzTXc1ZnBQeFB2bDF0VVp0?=
 =?utf-8?B?YWxaU1djK3UyUE9ob0pUTjFCTU1SQ1V5RDNPYUsyMTRKYURqTWZ4dnV2SE1J?=
 =?utf-8?B?M2grUFRFWjVQV0NaWkdKcE14UWFKcWlxTmduVXFkVzEzU1RzQlhnWDJURVhm?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cca6fcce-9b33-4707-50b6-08de1176c7c2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:24:58.9730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyDKg28R+kjH+XVwmeR3wWc1pQ+w8V2eCVTnc3GypuP01CQ6uQyz4VQjjvnuqTxTJedcsNYyI5QY89iwRpYDRxh6bL7G0pIiOgZ9c2W8Hys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10766
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

On 10/22/25 3:54 PM, Tom Rini wrote:
> On Wed, Oct 22, 2025 at 11:19:21AM +0200, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 10/21/25 10:25 PM, Tom Rini wrote:
>>> diff --git a/doc/usage/cmdline.rst b/doc/usage/cmdline.rst
[...]
>>> +   values are 0 on success, -1 on a usage related errors, i. e. invalid syntax
[...]
>> I would also add a comma after "syntax".
> 
> Is that oxford comma or no?
> 

I don't believe so?

"Values are 0 on success, -1 on usage related errors and 1 on any other 
error."

With Oxford comma:
"Values are 0 on success, -1 on usage related errors, and 1 on any other 
error."

Here it's simply to "close" an example/clarification/extension:

"I found an apple, an orange, next to a kiwi and a potato."
"I found an apple, an orange, next to a kiwi, and a potato."

In the second sentence *I* (so to take with a grain of salt as I'm not a 
native speaker :) ), I know the potato is not necessarily next to the 
kiwi, it's just that I found one. In the first sentence, it's implied 
because otherwise the sentence would be "odd" (removing "useless" info 
would mean the sentence is now "I found an apple, an orange.").

I could even see

"I found an apple, an orange (next to a kiwi) and a potato."

so

values are 0 on success, -1 on a usage related errors (i.e. invalid 
syntax) and 1 on any other error.

Anyway, nothing important (nor necessarily proper English).

>>
>> Should i.e. be e.g.? c.f. https://en.wiktionary.org/wiki/i.e.
>>

This one "it depends", if the only possible usage related error is a 
syntax error, "i.e." is fine, otherwise not.

>>> +   and 1 on any other error. Any exceptions to this are documented by the
>>> +   specific command, i. e. :doc:`cmd/for` sets this based on the last command
>>
>> s/i. e./e.g./
> 
> Maybe? In both cases I'm following the example in the previous rule here
> that's quoted for context.
> 

That's for sure not an "i.e." that should be here. Replace "i.e." with 
"that is" or "in other words" and if it doesn't work, it's likely "e.g." 
(to be replaced with "for example").

Cheers,
Quentin
