Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF92C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 15:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A49F680077;
	Thu, 20 Feb 2025 16:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ni/rmb0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0F0801BE; Thu, 20 Feb 2025 16:34:24 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB7E8001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 16:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjVflZb4KziL63GO/Z8+SwmZcO6WVv84GCQSR0Jynn4/Y6/ybnngRReJnFWN30TavfjK1a8ksibvjtzNtAgSzxFEPmXuIN1q/l34QgpLDeF7RqC9v8wnGy0/0LD4vbZphlMZmXXeKelRg7fNo3VzcRFSxFY0XX26SUBE0cEvjckMdrR3aiJOWo2D08n+v3ChXPyK7ZviPXgSsS+k2d4lMhDRRO0pW0lfQDq9JeT4lsEnyxY1r2wKrsT8b9+mW1hLDQlr+tSEGKbX7ebMNEFjogxSnqcr4GE5aLnDcHR8X5gyVdxOQ9iFIaxw/wJqfcmr4usQiO2pMDECoHPwgwgQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEtnKAxxe5IGt1HsMnxi3pQac6Fa+9w7JfLg72ZOfz0=;
 b=co1Tg7LQYaZDudE0hAZyw1pRGmYPbnfWP62cnQeADEfY1sVLP5oYuzX2fEgP7XfrQRbydzFOUpbFbGSC+qt9OX3RKhc+NtUTiDTXRk4ADoFPM2HivcS7luSMeKw9+x+50ToEM4nM5//I3WaW+OTm8FEx0d2wLwBB+mShrh7qr6EZKJ90bhW2i/3cf51elyBSKGtCrcya6rjTrqfJJrnbBeBOnmK4F2zJoSLZSjLwVkh70NP8EEdBE0XBMtP5vsQzIkILCLMREVCCmd3hxoCBKP3ODHrH2YdLU2IT1ki4Tr1pNzUh9dpOn2rZJj7inzcL3a9OTThGlj9BOzWTDCkdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEtnKAxxe5IGt1HsMnxi3pQac6Fa+9w7JfLg72ZOfz0=;
 b=ni/rmb0CMiKT7wGpRn/WowYl7bbyfcNtHSHHPztOO579G7TWdvl8L9ZF10nu0/l6GoV9ntGPan2jurme/PQWaGcrQvtwLNcoHqJ3yMrSBiCXfuWBOELf4G3cDPHc7DT8c0/D6XH0ZfhIrqM1mLq41hEFonkwjY+ikC0XNe0Zj4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9024.eurprd04.prod.outlook.com (2603:10a6:102:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 20 Feb
 2025 15:34:19 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 15:34:19 +0000
Message-ID: <91a9b871-62b9-4774-843a-b92164e451f4@cherry.de>
Date: Thu, 20 Feb 2025 16:34:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] rockchip: remove u-boot.rom generation and use
 binaries from simple-bin in simple-bin-image
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <CAFLszTic+bPv-JjsZ4JVz1RXQ247rmjPbGYzQhi5Z8=PC1728w@mail.gmail.com>
 <CAFLszTgunKAxdNwd9sO5=0bH1zrJkhMLackQ1gOfQqyApm91Jw@mail.gmail.com>
 <0c83fc06-6f7b-45b5-b8eb-2373222f8de4@cherry.de>
 <CAFLszTh73-QZMEReKVCEDgVsBeG1=ofmATBsO3X+r2C7iN8s1A@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTh73-QZMEReKVCEDgVsBeG1=ofmATBsO3X+r2C7iN8s1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 3949aa7d-9798-4e03-8868-08dd51c40aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTVKRG1ja0Y4K2s5ZGRSM2RselB1R2ltZlIvL1VxdGdJcEdKcFJtT1EzdUxt?=
 =?utf-8?B?ZXBRTVk5aFNVcWdSZ2Y3QUI5MWlmL1hZS3lIZVNJRkMxZXFJUVpuYkh2MlNE?=
 =?utf-8?B?R1hLY1pyVHVMY1k5M2tqSVRiN2x2bzFDbFZRZzhIL2xuL25ONXhWV2JvV05m?=
 =?utf-8?B?TnNtT21LSE9vbW1QK2dkOS9zS1ZLRHVPb2drdDA1TzNrNGY0S2pOM21aUWZF?=
 =?utf-8?B?cXpHZERLbys4aVd2Njl1RXF4aGFHTmZxdHJaY2JHNXJMVVRXZ1dJbDhqcWJM?=
 =?utf-8?B?akF3eUZRS0JDWHZVdUVodFhzL2hUMU9rMTFtU09rTGdqSTY4ZUxIUHRUY2dr?=
 =?utf-8?B?Q2tOSndEY2ZOTytPL01rV0p0TENRTFRrbjdUNmNNTlpvWlhTN0RxTEZSVFhD?=
 =?utf-8?B?bzYzckdheTREOC9GNktWV3BiVmxRMWFjTHhoaldtNWN0TEZDRkhPQlVGMTlO?=
 =?utf-8?B?Q05FZHJsbTdjalIwaUdxdG5TazMzWnNrbGcvNEtid0RrSTRCMERMZUQ4dk1u?=
 =?utf-8?B?OFBzTFpoU2srOTBRNXl6N25qakc5QzBHL0JucWZrWG1QYnFvYktmYkZTRGJ4?=
 =?utf-8?B?MVNtd1hVblJac0R2eDlHZk1IK1VkNXNacGR1NzVoRVdBRE9NOGxhWmJ1L2dN?=
 =?utf-8?B?RlR3M1pzMWVEMmhhdFFCT0tQMzE1M3BkZnI3V3ZxUEdoQTEveE5ZWCtSN2hU?=
 =?utf-8?B?dlVEdXpsZUhYTEg0Y1BTOUVUeHNVZzNOempjdTkwYkF5bEN0VDh1NzBvM3JD?=
 =?utf-8?B?UU9YRVZVWkRQay84TGYyM1Jsd01oMUJaa2w1Q0kwMjhtOUt0K3diMUtMUity?=
 =?utf-8?B?a3BDU05GQzI2U0lranc0RTJqNlVMOFA4WnlPMFBYRkVUQUlDbTVRM2NXMEVD?=
 =?utf-8?B?ajEzMWxJOStXZ3RrcVZQMlFmazRlMGNQd0g1Skk1VWQ4M0FjTzU1UU5xaW1R?=
 =?utf-8?B?QkVSVk55Q1JjNVBEa20yWFlzc3czN0RVNkkxMU5ZSWx6UXJMRnRmU3ZELy8x?=
 =?utf-8?B?U1MrVzRiWkxZMWQwb1ppaE9Hb0NkRWRHQnNmWHF2Y3IrWlV4dlRDWkJxcktZ?=
 =?utf-8?B?d05aWnhmYldrWnpoMnRWNHNBLzVMTk9DNXZHT3pqd1VwSmE2bm52VUFZOWJn?=
 =?utf-8?B?WTZzNHZIQXNZeGJ0MTl0bTJiaFVQSG9tL0I0SEhEdEkvZlh1QUJzOGw4dFRn?=
 =?utf-8?B?K25Sdlg1UkdvZ2N4MnFjNENnSXRGN3p1WklyalZEU0NVVWRUZGVreTBFeWhv?=
 =?utf-8?B?bnJNa0hud2FOc2RGTjdjZUxNTnNJTTJPZjFMVDQ5MW45SjZGZXN6QU0yMUNn?=
 =?utf-8?B?OEdWQzF2ODZGOWJUZGhRWGUvTjY4dUFqWUpnbmlPMWM3Ykw3U3BzaUVkeGJF?=
 =?utf-8?B?alNoVHhCTXBndjh6dGtNYTN2M0x2ZWVtdFRMK21QVzFHSlJmWktJK2RBSTQv?=
 =?utf-8?B?YUJETGVpaW1oSjlPaFZwYXhsK3FVWDNSMTBrTS9Tb1FDK01XRzM3NmpJN05w?=
 =?utf-8?B?NnRlcTZ4ZXV3blNtWEN3dXdCVmw5c2R1UVFybHliWEJ1UTBZRFQ1SC9JS01J?=
 =?utf-8?B?UzlHMFg0SER4Z256dmp0clBnVFR1QTJ1bFRpWmR5K25CaVlVZ05rMXQ4REpY?=
 =?utf-8?B?ZjBHdFk4L1plK3dSREYyNFpRZ2JYMnliUmFSMW0yZDA3ZURxc0RqWTR5OXYv?=
 =?utf-8?B?bGZwMC9XWnlVNUJjVGNWNFNSR0hzclZ5a0haTTNQdDVrSWxNL1hneWRuM2RH?=
 =?utf-8?B?K1dtbC9nNVFLVm1PVDB6Y3lZV3I0V3lQbnh1Mmh2ZVJXNmVhVk10YTFxOFdK?=
 =?utf-8?B?akduTWRsM0NtUGx5dUJMeU5KS0VaR1NTZ2NnMkhINzlkNm95eWJ5dmRxRDA3?=
 =?utf-8?Q?Cak06oE37hiEL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmlqUmQrbzQ1MW8yUC9mNW1wRzlRdm5qYzhtNWZNbkdQQVBnRm9tQXN6R1Ir?=
 =?utf-8?B?WTVTdnVXVkNhYklYZ1BodTNEV21rV0hmYjNlaU5IN1pvN3B2cXNUeEQwM2Js?=
 =?utf-8?B?MXZXY0Q4NWhtbGMwcnVZT0pxNzJpSVcrc1NyQkxEVHRxQ3lpWjNNcTlNYkIx?=
 =?utf-8?B?UXdYZCtSOXpRcGsyU2xLVkh2WlNhcEFtcHZ6YUxLR0dZUDNFYm5wVTZKY2xk?=
 =?utf-8?B?WXYxSEd4aHlvSS9OSnlNQy9xVGpRSlF2c0ltMVlyaGhLR2tEaC9Kb0IvQlU2?=
 =?utf-8?B?aldHZjBidzRHSnQ2MG15Wm8xSWg2bHBlUnZsN0NMRTdWSFVoMDNzQ1NFZWJl?=
 =?utf-8?B?TGd4MEZ4RGdWcllYT2I2SERIMnozNHk2ODVyOEw4Y3FVTXJXdFo3YnZOaW4z?=
 =?utf-8?B?SE44U2d4b0NxbHAyTUQ2TkNWN09Venk3M1V2cW5RUW05QytQUVQ3a2NSalBM?=
 =?utf-8?B?bmEySGZ5TWJYRGU5bHJ3NDVGSy9OWCtEcGkwT0lYdlNEUFBVZU9pWWkxRUFm?=
 =?utf-8?B?WVR5RGNFV0JvcXlrK0d5VSt1WjRoRVZ0SWN2UHl3dC9EMzNLQUNXZFZRV1NL?=
 =?utf-8?B?QTQwL0h5UnBuSFBoVGpKejI5aVUvVytMQTd6MTAzY3hoUlpNSzNhdVNPa2ZT?=
 =?utf-8?B?cXlOT3pTNjR1R0htbWFrakVUcW54QlVuUkdudTBKOE93Nzl3M1dQeXJnbk5a?=
 =?utf-8?B?TEtJUFFsWS9YeURXWGVFUFNTMEJXTVhodWFWakhXdVBWV3lSR3k0QVVySGxk?=
 =?utf-8?B?Z0dqemEvR2xkY2ROU1ZqNmhLZ3RPeWVzWjUvc2hqakZqaS9aZDVuUlEzR2pv?=
 =?utf-8?B?RGN2WmU4OFdYaUNTRi9XTHQyb3J6NitOYktWb1dwZnZCL0RjdTBqa1FZM3FB?=
 =?utf-8?B?bFRRVGVaYzZzVkdCN3RIZVZHQXI4SXNWZ2ZFdjNKZUhBeEJsVkh3N2dKdUFt?=
 =?utf-8?B?U3VNN2VpTE02bVBTNTdLdFlIeHZBYzZ2QVNyYVFEWktxeE5xYk1MU01zWVE2?=
 =?utf-8?B?Rzg4bnRKNHFhZ1VqSC9MMStwSzdUdmdRZkZJRitBZGEwMzRaUWM5ZTZ5QVVE?=
 =?utf-8?B?bUtvUE95NXpRaFY3cUFKK3VNMkczeng3aW9oa1FCREVzdFUzV05GYk9FTERZ?=
 =?utf-8?B?NThycDhhc1pQWUx3cGRRT2pEbldYOHFsNG1YZ3VFRzE1Y3paTVFxNzhQSVBm?=
 =?utf-8?B?VnZsWDVIUkd3YUJVYlpiMzBzQ2VGVTZyeEJIdEoxdExmZkxLNEswZlBTRm4z?=
 =?utf-8?B?cG9nVHozMGI0Y3FBY3dzcXNHOTFvbExnVThJM1VSeTdRT1lmdjZrVVhPQzgr?=
 =?utf-8?B?b2pNdVBrTjlqM09BbHBtTTRvOEIrYWpHemxtRnhkOEVldnpaTHhlSnpnNkpx?=
 =?utf-8?B?R3doVmd3YjVqVjJ6SkxvM3R1cG5uQkxlTDRkUFFFM0FLTHM4Ty96cnB3anZO?=
 =?utf-8?B?NUx4WTRRYk9hUHV1MlVkRS8reUZaSHRiM2tTK1VYeUlHNHFWQkhNbVZ3VElo?=
 =?utf-8?B?SUZqWHp1MTlnbGxzb3hmUzFPejB4NitJcnBDalZGbzUrRGJPMXRpUmtrMHJy?=
 =?utf-8?B?VmVFUUt4amkvd3dmdG1XcEZ2STdrNDA3SGw3Y3BDQjQxTE9KUVF6MmZtZFVP?=
 =?utf-8?B?Q0ZRaW5LYUZiNTBaQkcwelFIbTlqUzJSTWp4Sld4am03MlhieDdTM0lERTYw?=
 =?utf-8?B?S1haTi9maGdtM084dUNDN0NYMmcyU2ZlaE12Ukt5ditwZGJtdnlPckVEUU90?=
 =?utf-8?B?anFtYXcrNmZHM3BUaWUxZnlxWjBZSk5yc2JZaGdhdG4zYmxUVmJsSDhkUFBa?=
 =?utf-8?B?YUV1eVBLUnZnNjBtTFB6VXhpVFVNclJrZ0k1T2RnT2J3cElabTJNNy84a3lx?=
 =?utf-8?B?TXErcGY0SzBGM2lId3hrOS9aempJQmYrM0doWTNLMTE2V2ZQWVlhYzVBYWtw?=
 =?utf-8?B?a05zMStjUExyOXdKOGV0SjR0ZG5QdXYxVkE2NWxBaU5LVllFcGJKbW56Q3ds?=
 =?utf-8?B?dFpUYzJkYitTQWZNTmxRaHF5WUhUc2FqZnArY0N1SXhTZEd6OUkzU2pZQW5J?=
 =?utf-8?B?QlVhd1VSNUhJVzNBOEY2dEdPVDgveU1sbU1seFFETWxEUEk1WkRvMGtJVHk4?=
 =?utf-8?B?elFuTkZsclJ3TytwNkhjQWpsZTdBS0tlY21ZQVlJSlppNUNqZnErZUg0b2Qx?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3949aa7d-9798-4e03-8868-08dd51c40aaf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:34:19.2644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDor69fygDB5bZfLJSaYQM1/AmsmmcAXVFROt+JnKYNjm7Jo3/gUnI9fBcTXQ0VcfBnYKzSoH929PGwsRONuoPfKY/rX5UzxxhflK0beqSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9024
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

Hi Simon,

On 2/17/25 4:37 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Mon, 17 Feb 2025 at 08:37, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 2/15/25 2:17 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Thu, 13 Feb 2025 at 06:54, Simon Glass <sjg@chromium.org> wrote:
>>>>
>>>> Hi Quentin,
>>>>
>>>> On Tue, 11 Feb 2025 at 03:29, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>>>>
>>>>> This gets rid of u-boot.rom generation as that was used only on Rockchip
>>>>> Chromebooks and their maintainer (Simon) seems to agree[1] that
>>>>> u-boot-rockchip-spi.bin should do the job now so we don't need to
>>>>> generate it anymore. This was agreed for RK3399 Chromebooks, I'm
>>>>> attempting to do the same for RK3288 Chromebooks as well so we don't
>>>>> have anything requiring that u-boot.rom anymore.
>>>>>
>>>>> Since HAS_ROM is only guarding this u-boot.rom generation, they are
>>>>> removed too from the individual configs.
>>>>>
>>>>> Finally, this also fixes an issue reported by Naoki[2] where binman
>>>>> would try to find symbols from proper to install in xPL binary only for
>>>>> it to not find it as we do not generate (on Aarch64) the proper binary
>>>>> in simple-bin-spi image node, only in simple-bin, so it cannot have
>>>>> access to the symbol. As to why this triggered only when some seemingly
>>>>> unrelated symbols are enabled, I do not know.
>>>>>
>>>>> The first two commits are cleanups. If they are controversial, they can
>>>>> be dropped and I'll apply the same fixes for rockchip-u-boot.dtsi to
>>>>> {rk3288,rk3399}-u-boot.dtsi binman nodes.
>>>>>
>>>>> Note that none of the patches were tested outside of a simple build
>>>>> test.
>>>>
>>>> Are you able to run them through my lab?
>>>>
>>>>>
>>>>> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com
>>>>> [2] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
>>>>>
>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>>> ---
>>>>> Quentin Schulz (3):
>>>>>         rockchip: rk3399: do not generate u-boot.rom anymore
>>>>>         rockchip: rk3288: do not generate u-boot.rom anymore
>>>>>         rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.bin
>>>>>
>>>>>    arch/arm/dts/rk3288-u-boot.dtsi       | 24 ------------------------
>>>>>    arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
>>>>>    arch/arm/dts/rockchip-u-boot.dtsi     | 10 ++++++++++
>>>>>    arch/arm/mach-rockchip/rk3288/Kconfig |  5 -----
>>>>>    arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
>>>>>    5 files changed, 10 insertions(+), 66 deletions(-)
>>>>> ---
>>>>> base-commit: 636fcc96c3d7e2b00c843e6da78ed3e9e3bdf4de
>>>>> change-id: 20250211-has_rom-u-boot-rockchip-spi-bin-df31b06ad2f3
>>>>>
>>>>> Best regards,
>>>>> --
>>>>> Quentin Schulz <quentin.schulz@cherry.de>
>>>>>
>>>>
>>>
>>> I'm not sure if you have tried this yet.
>>>
>>
>> No I haven't.
>>
>>> This series produces a SPI file but the size is not the right size
>>> (4MB). How could we solve that?
>>>
>>
>> Which board(s) do you have an issue with? What is supposed to be the
>> right size?
> 
> kevin and bob, both 4MB - see CONFIG_ROM_SIZE
> 

CONFIG_ROM_SIZE is x86-specific and is empty for me.

Why does it need to be 4MiB? Should we really care if it's less (it's 
currently 2.1MiB)?

Also, I believe it should be 8MiB? c.f. /binman/rom/size property in 
arch/arm/dts/rk3399-gru-u-boot.dtsi (which I forgot to remove).

So I guess the answer to "how could we solve that" is to add 
/binman/simple-bin-spi/size property to all Chromebooks, so in 
arch/arm/dts/rk3399-gru-u-boot.dtsi and 
arch/arm/dts/rk3288-veyron-u-boot.dtsi).

Cheers,
Quentin
