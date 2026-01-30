Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A012DD49C8D
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 09:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E4CB8421E;
	Fri, 30 Jan 2026 10:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="P4Lj1zU8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02DC84118; Fri, 30 Jan 2026 10:51:51 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78A268421E
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 10:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLQRIxnT2xdCUKs7bwfhwRxKu34oKbw3poJqQUjIQERJ1F52bs1o3JPIvfE6OOI2ZgEuziRPrYmB784HkjMv7guJu1hmCW9T+Z4EZEjyniZt1iDpob9xHvRXWD/tnYUobHGhiQam8+IHGSusLxMz6I/3uVI0SbwuTX8uc1xGjQSPItJm4bM+ev48zRYxsb2PCBjdYxAF2k6lRANSC0MTm4P3nalYn2NwCXBnFZ3qs/bHCzM1Rpw5asO8e0Etsmyo/vHTKUMfP/L5UOLAM8VMDgfAn6zlFJlQBPS4dYVESVlPDAWnyP3cRtsZPVVW/Iry9hOtuiYmMh5JCb39UFvyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HLnxuvsFV5Rlu4VZKesRjBWwzwXyj5RgCuTcI9K2eM=;
 b=IC9eBM3aMADNH/et1bnYQkF48CmBZX47mUoRvHyXuwwZoWjUDAv1rF4lZLPnUex1iFzIRvpSCXedP0z5O+TxU0njjktZuEwn/4tGLauwYRZxZ6kiZ7I2a5eKMLNz1SlNpnlA5V2Dvq5YI0JN4Iab27Wqal4eBakwwQiO9s8HQ7Gk1wUvuFuxiPx/uUOfpZ6KXO/5s0BoR2SOyCjfBmoOhHEDCeed2Jqe7BSspiMUior3pddlDWU2e0ygxzbe3g6dammn5hqhSo3tLu2DlcAqieV5w1ovyYOdQ7jAce3KTVG0oUvWgfQP8Py4Rtcl/J2BpCxfkpJu3IaneKahqbT/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HLnxuvsFV5Rlu4VZKesRjBWwzwXyj5RgCuTcI9K2eM=;
 b=P4Lj1zU81tF+mjxiYaF9tDEC/E8+3KYjcekhtyibsviN3bFvYP38MYKT1uSaKAdKR6uwMmI0jiSB8cRw/dEI+m11Eg90PDEGXRozQOOPyVRu9C5P1+aQqs36GXiy2rWfFK7CGIOhvaIPhL9P51zewgkLFDf1qQ33jMWTL+YIZFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7347.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 09:51:43 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 09:51:43 +0000
Message-ID: <11f467e2-1059-4edb-81a2-8b970b315882@cherry.de>
Date: Fri, 30 Jan 2026 10:51:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rk3588 MNT Reform2 fails to boot from SD card
To: Vagrant Cascadian <vagrant@debian.org>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
References: <87ikcjc1oc.fsf@wireframe>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87ikcjc1oc.fsf@wireframe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdfc1c2-89ec-4c35-1ee5-08de5fe52c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFlVTW1aWWdidFRGT1czK2h5dUtCSzRFeVpobExBcTFDUkZzRGllZlIzaXpl?=
 =?utf-8?B?UTRYcWRwWUV1RzJmU2ZNWTRLRHVKN092d0tWMzAxRzROTUZFWVpJak0yaU9T?=
 =?utf-8?B?UTZxR1FlcUlnWVdPOWcyTlg3Qlc3ZXhJbTM1cmZKeHFOc0llS2tzNjN4UDcy?=
 =?utf-8?B?VjRGQnZ5U2xNYnJWaVErVGpaeWZiTWdGRGQ2M1d6MHNvUXpuUWdyVlExR1VO?=
 =?utf-8?B?L2NXTXk1eEFmNDl2a1NDMEJLUTA4ZGhFa1l2eXFPNWNGZUpucWVEcWtNclNI?=
 =?utf-8?B?WHUwdVIrQnJmVytNQ21lUXJYN2hvWE5tbkFxQWI3ZElDWm1zbittRUN4UDFB?=
 =?utf-8?B?c2RjR2pGRUM1S3p4REJnZHphUnBCNk91RDltaTVtNWZSZVc2Y3YyMG1uQXZX?=
 =?utf-8?B?UmV5bzNRdmVxNWZmdHlqSDZOamxjQjcvTEh4TDNPNVFtTU9YdFJYWjVHRElD?=
 =?utf-8?B?bnJRQVkvTis2QVJUMHZXNk56dEJVcUhPcHJjNzc0dkhrZjdQaGxWd05VUXhv?=
 =?utf-8?B?MkNDK3JTSEdlWi9zUnJvSW83Z2I2Sm9nTS9xZzVpM3FUc1QwVU03K2pGeXRK?=
 =?utf-8?B?ZHQ3cUZ5bGVJUE5ZV3Mrc1VLeXYwNUJlVkV3MzA1Z0NxcjZpNFRuU2cwdld0?=
 =?utf-8?B?R0IzQXA2YksxUmhtN2tWK3dDT2VoYS8yL3V2MFQrYllXRTVhdG40YjBTMGpO?=
 =?utf-8?B?bDQ2MnR3bWFBc1QrWlZHNUJkemRFQjdydXRKcjV6b1JVSzlRM2Z2WHFLMS9L?=
 =?utf-8?B?aTBYYUNRazBsNmhmeUQ1cGJPQVYxU2xMVUdYUk9kRjV4dEdpOU0xbnlVQTEr?=
 =?utf-8?B?SmtUYmIvN205TU1WZDk4WFdiRUVRMmRKY2MvdXBoNGZGRUpRZzAybS9sOXlt?=
 =?utf-8?B?SDF5Ui9LOEtiMHB0ODZOYTBRZkFKaDNnb3p1MU5DMTlVbEhPZklIdHhFUXBX?=
 =?utf-8?B?dFZaazBHMTBOV1JPZGhmeEZiZ1FvZVUwRGFUd1Z1eFZIRXNoaVBzMStLNkY5?=
 =?utf-8?B?YXpaNU5nc3k3ZGFkVC84MnFsVU5BelByZWNLR3hkNnpDOXNEbVNyZEpiS05s?=
 =?utf-8?B?V09pZDhwVTJmck5vYlNCc2N4aDVodk1NbUJ5ZlBiTUZGVVdtemtDdmtDU05G?=
 =?utf-8?B?TjJZS011UUQ1Yy9QQXJIYmVTTmlkVGI2Z2wxY2prbXh4dG85Q0QzdGtlZ0pF?=
 =?utf-8?B?cTYyaWxUWk1hSTlFWW9scmphN2FGTEdiaHB3SkpvQWJSU2gxTnZoMExmNG41?=
 =?utf-8?B?WG1XSUFTdnl2QUEwYTZVWkhnQ0dncVg4ckd6VmtuM3VpYzRFVHhHWEpQSjNn?=
 =?utf-8?B?U0E1clJpRHJVbUNDejdoSGc5QXRDNjA3bmxUQ3FUV1pUYjdtbkhlYkZQYWFw?=
 =?utf-8?B?Z1E3bUNPZnhaaW5PZWpFdU1oNHJRZXNiZyt3dytYVUQyckJWSDZycDIreGlY?=
 =?utf-8?B?OHliMGhQNzgvS3NlL0w4dnIzV093dmw1MGhHYlVYMXRvaEd2QXZGM2ZLYU5x?=
 =?utf-8?B?RnY2emhtenJXdENpaEFuN3FjMm96NjJhSll4NFN4RGRIMGpkczRSTkxxcUZy?=
 =?utf-8?B?QjYxVEpxaWlyL3VxQ2duVEJ1SHY2U0FOS084a3NQbW5GYUFreHJydDlGOFNp?=
 =?utf-8?B?SHpLMlNHRm5SVHNPZW1DaE9oWU54SXVPNzRBNUFJZENuY0V6WjVCWFlrK2V6?=
 =?utf-8?B?a2RoM2oxekJHYVFQbUJjMEFuVHlBV29UdllMUnI0U2xzZ2lwNVpTYnlKdk9v?=
 =?utf-8?B?QVp1QWkvUzR1NzRCMUREVDFTZFlsNXFmSHJPVU1aa05yd1BxZkxtdVA0Ly9B?=
 =?utf-8?B?eTFUeTF5YlVPMjJUdXFpV2hGR2s5RUM2dDZqUWhZTExnS0pac1ZmTUEwVHZp?=
 =?utf-8?B?UWtGdmxvaFhyMU9Bdmp5MUFWTkZtV3pLZmZTMjNoTUx4T1lhTEUvM250cUY5?=
 =?utf-8?B?RVorZTJFb2hhcGtWa29Scm1WT2U1TCtrQ0VLci92VnZQR2ZGVGJlZXZkUDZo?=
 =?utf-8?B?dzB6aGt3SjNwM3lIN1c2S2EwRFFiYU52ZUd1LzV5YUlWc3Boa2dQQXJaMUhq?=
 =?utf-8?B?VGlwUHF4T0NLQTlRNms5cG14L01nMEtRNEdQa1dXMlBqVUxXWk0rbFVKSk1r?=
 =?utf-8?Q?uZTE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjkyMjVISVVJS0FybFVSUFJ2ajh3VWk0UjhuR3NQVWdLcVMzRUpZNFVEQ0Jq?=
 =?utf-8?B?UTYyK0pIWkZpaERUWnVJQVpXNFZqT2hPUkdPUWZ6clNqT1ptMGJNMHlBN2l1?=
 =?utf-8?B?NkdPWXZwSGZhMGFZNk1HN09CZWtBRk1qRTE3ZFdpL0ZTem5PNFB6cUJ6YkFq?=
 =?utf-8?B?MUhKcVE4a3RxZjFxdi9KVnB2VTFNM0x4KzQwWnozUi9PZHd3YlV4MHFIRTM4?=
 =?utf-8?B?czZRUmVScExKQU0rbVpJeUFqYURPR0p5Y2hwdHdmL3RlRFNOMHEydlJuZnJF?=
 =?utf-8?B?cFhzR1dSaklxN0k0ZW9ON1QvNWc2cnUyamJndVB5YTFRNEZFZFpEMWpINGVo?=
 =?utf-8?B?WkVUd0dMZ2NUWFZ1a3dwS0FUd0cydWF2TklNUnlucWRrZm5odUVoUFh2ZnVQ?=
 =?utf-8?B?NWZEYTQyYlJhVk5oVytBV3lBVWN6YkFGczh0Njk3WmNKam5nWFBrb2U1MFMx?=
 =?utf-8?B?R0FJc2VPMDBzWVc5VXF1V05Ia084VFlVdFlDcjNaTUFnTnhvNzBmYzc5c2d5?=
 =?utf-8?B?T1o1YUE3alhHTkVFZFM1TW5hUWZXYmxKOHJtWDRXSzJWS0oxaG15YmdMVmJ4?=
 =?utf-8?B?WjVWc0ZFRnZTQlhQaVg4QUJ5U3ZDOU81QWtwdzgwa255emJpeExOeGJGWWdK?=
 =?utf-8?B?cmd1MDJFa1dyL2g2UWh3a05sOVNrK3hkMWxIbzhHaitIWkI2VGJyRGtLUXls?=
 =?utf-8?B?ZlZHVElMRjRVemF5V0hzOWdjTitBVHZMNm5mWXJmVUNWZVphbEVyaHZoc09F?=
 =?utf-8?B?akM1TFdFVTFyYzJ1ajk2TUQ3eUppZFhxUEY1TktxdmtKa2lFbFF3ck4yTW1H?=
 =?utf-8?B?RXRMcnZBT2VYOERsc3BkS0h4SlViR3RhNDN4RUpYVTNVK1MrWFhiWmdwQkwy?=
 =?utf-8?B?dXcrb01Ed2FrdUk4Q3RMaXJ5MHdXUzJLTXp0T2VZTVpsTWR1M2l3emhKQ21I?=
 =?utf-8?B?eUl2SGVyd29Dd3FXbkVRNk5ZOHJlZGZKa1VMdzBXSlV2RytGY3d0ZDh1b1Uy?=
 =?utf-8?B?dzA0VlhiMWVDdEFVdU5DSFlrSTVuYm5UZjJVMHU3R2RMVWkvQWJBZDR5Z2Jj?=
 =?utf-8?B?SDg4c1ZyKzlGTGtrUkNJenoxKzAzU3RoQUliZTluV3NUTW5saU95NzRGcWZh?=
 =?utf-8?B?K05OU0xKMHZWbnJ2eVpOUktBb1JDdXE2SlQyK0pLUnZ2ZUhKdENqMU9HZE1T?=
 =?utf-8?B?U3ZVWXJ4MjY5b1hPenEySHFORGhHZHpGcCtuUkJnczBBS2RMT255SHI1ZU9u?=
 =?utf-8?B?QkxVMHh5Q0J3V0wwVUlwNzZRbHlRVTdINFk2ZHYxbm5zTVFRZFhMMDRlVWxm?=
 =?utf-8?B?Ry9ndU9PSmFFZGhiRTRRYWo0WnF5d2JSaWVJdkN3ckVQTXRMV2NoT29hSXlI?=
 =?utf-8?B?NjlTTnNoanRETlZhTDA2NjBKd3FaK1kweFUyRVZ3ZHlONVFpSi9VQVdXUHJo?=
 =?utf-8?B?M1RhUzlvclNPV3k0TWxXajRRdUZadlkvMnFDRkZNZHJtVUh3SjFjR1NqVmwx?=
 =?utf-8?B?bkd2blVLSDhra0FSL0NPdUdabkNuMlBKSmcvaTdJdmtIUzJWYzh3eGF0cjZX?=
 =?utf-8?B?RElBQUtvUFJzdFBUYngxUllJc2Vqc0U3N2VySGlmdFhyR0tSNUJMWmszSWpL?=
 =?utf-8?B?SWNhdnVhRTE4NlZQaFF2YUkyRW5RNllaY2wrajQvTlI1REZuOWEzTytQRXgy?=
 =?utf-8?B?bTdyR1lLZ3pvMTVSb3YzVDVzU3oxWXVSWlY4WEI0L3U5NDhmYXlsTGlWenFU?=
 =?utf-8?B?VnFPZXl6ZnV4N2RUK2dNejR1cmJMVXNLRHJpejVtQ3M0SHVYaUNHSHpNaU1r?=
 =?utf-8?B?UGpveUJEWk5wd2lvTCtSNTRSR0UzSEQycldJT1c3cm9GWmlSS3RBQWIvN2tL?=
 =?utf-8?B?dkdYS3c1WGk1dUpoNkRvSTBMYzhJUU8rRnVmcFBGOXVYczcrbmVTUmNxbjRq?=
 =?utf-8?B?ZGFJVnEyTmwwcVQxYy9FdC8vWWphQlR5bE4wUzVaSzRHRVhrdUpBeEs2VHBs?=
 =?utf-8?B?VHZxeThiWmZUaXRIRVN5ZFpwRS9VWVpCTHJ6Y1JuYzJIZElEc3hIaEdMczFj?=
 =?utf-8?B?L3BBYm02a0QrNFJHeERHV3JWREEvS2ZXVC9lbWJjaVVDQ0NCakVXMWVvT0lu?=
 =?utf-8?B?UkFvMlNsZzJmdFVZN3NhMkVoUnNZcnhiMWRZNXFGYkZ0cTJrT0hHVElnczVh?=
 =?utf-8?B?c3F4N0k1QzFzYkE2ZmtUTFU0LzJaODVzOHVIbXh3TDJ1VjdYdEJ2REQwS1dn?=
 =?utf-8?B?dkhzaitsSFFneThNOHZxYjlqWVk3eDBkYjB2K0FNdUlaZTYwbUh3WDVHQWU4?=
 =?utf-8?B?andTTjZCc2FkNkY3bWdoTUwreGtTTUR6UHVhMW9qYkhBQU16UW9ydz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdfc1c2-89ec-4c35-1ee5-08de5fe52c8b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 09:51:43.3603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6BslDTINtaP8vEeRRp4Dqv8dvH0gP++STDw+sRX4LPnsuiXpQL/oeCOY+EgGrbVbxeZECY2SxwjQqjcXa6L+02EneNU//WDvLjDFoCldaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7347
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

Hi Vagrant,

On 1/30/26 2:46 AM, Vagrant Cascadian wrote:
> Thanks for adding support for rk3588 MNT Reform2!
> 
> I tried using u-boot 2026.01 with the rk3588 MNT Reform2, but it only
> gets as far as SPL, and then fails:
> 
>    U-Boot SPL 2026.01 (Jan 01 1970 - 00:00:01 +0000)
>    Trying to boot from MMC1
>    mmc_load_image_raw_sector: mmc block read error
>    Error: -38
>    SPL: Unsupported Boot Device!
>    SPL: failed to boot from all boot devices
>    ### ERROR ### Please RESET the board ###
> 
> I *think* MMC1 is eMMC, which I currently have blanked, as recovering
> from a failed install on eMMC is trickier.
> 

It's surprising it isn't trying MMC1 twice as that's what it's supposed 
to do due to u-boot,spl-boot-order containing "same-as-spl" and the eMMC 
controller again later in the chain (see the property).

In any case, no support for the SD controller in SPL according to the 
defconfig, can you try with:

"""
diff --git a/configs/mnt-reform2-rk3588_defconfig 
b/configs/mnt-reform2-rk3588_defconfig
index 6adc9e4e60c..982e6c6eb20 100644
--- a/configs/mnt-reform2-rk3588_defconfig
+++ b/configs/mnt-reform2-rk3588_defconfig
@@ -50,6 +50,8 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
  CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
  CONFIG_MMC_HS400_SUPPORT=y
  CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
  CONFIG_MMC_SDHCI=y
  CONFIG_MMC_SDHCI_SDMA=y
  CONFIG_MMC_SDHCI_ROCKCHIP=y
"""

and report if it gets you further? I think you'll be missing support for 
the CD gpio as well in SPL.

So probably you need to enable SPL_GPIO:

"""
diff --git a/configs/mnt-reform2-rk3588_defconfig 
b/configs/mnt-reform2-rk3588_defconfig
index 6adc9e4e60c..7485d03a0cb 100644
--- a/configs/mnt-reform2-rk3588_defconfig
+++ b/configs/mnt-reform2-rk3588_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
  CONFIG_SKIP_LOWLEVEL_INIT=y
  CONFIG_COUNTER_FREQUENCY=24000000
  CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
  CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-mnt-reform2"
  CONFIG_ROCKCHIP_RK3588=y
  CONFIG_SPL_SERIAL=y
@@ -50,6 +51,8 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
  CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
  CONFIG_MMC_HS400_SUPPORT=y
  CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
  CONFIG_MMC_SDHCI=y
  CONFIG_MMC_SDHCI_SDMA=y
  CONFIG_MMC_SDHCI_ROCKCHIP=y
"""

aaaand also enable it in SPL DT:

"""
diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi 
b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
new file mode 100644
index 00000000000..47509f4cb37
--- /dev/null
+++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-u-boot.dtsi"
+
+/* SD CD */
+&gpio0 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
"""

I believe?

Cheers,
Quentin
