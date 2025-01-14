Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF25C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A60E80657;
	Tue, 14 Jan 2025 14:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hAMlITFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB938069D; Tue, 14 Jan 2025 14:45:32 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 440E2805CD
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfnyhBBtp0b1Y2TuVlQa6ArasuzyBBse4GXglV+QInyCEcYm7+tk4mUEjbJX30ifPmXVwrViGbGPrp4gP76++I2VMiUS7hqvIn6t1VdNceVKmgIXFzeEM495RQMvuUTDwawP3h2a4mxR1GGdP17Xk+UEMDVtunv9Gd8z0X2oog0PpfrfJGxB0Jlie+eFNFW+ERU0d2eEdXy1CkDfR61fsR2tMARAzriMQKAAZBSshCx6cgU8fItobcS46XbmoaKW50Ly40JEb3aVPbV2SogBhdZ5tRXvP+L4liovgAG48bEwP3gQ06ezuE2g6mjPPH/Km8DVLXyiY2e0wlnPkQxgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM7UJUPIM2SfdEbUlnmlXPgSsXYhc9hrSEJreQZkCUs=;
 b=R4rUf+G0HW+Ono+ewAkd1UNh2rNGt+3sOWMBpTXt7CQVN5Ke+hqtUnu+v/7V7UV91C+cHwQWOZb54s9SfORtcCVuMxNUDvhGsjPyS9hoWIrajNWqXMo4U0cDIX5ASVY+mV6mromGo8P9zMbiaHsjWHoXu3KstsqFQKsvJ0uQ/N3oIlZgz3uRypreAQnUrrGZUK7yRYbIa5i0EZ8A5t6JY/Y54iNNIVXvDyCHzxfI9MO2n6jzDzBfvBX839EkLE++H+V2QIR2YfPL+6NUnT5AT4/Fp8bZkP1FnvC35Cb8pD7x4MddmHw9zd0b6OPrWuv4hZ5o2I6Wr8qTE1fc/XBzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM7UJUPIM2SfdEbUlnmlXPgSsXYhc9hrSEJreQZkCUs=;
 b=hAMlITFTm1Sw6xmjwjxFFCKioqV75+OQrORBqviGs9LTYULuclE4BaKh8mpFic3JDtr2tE0BWAv+SefyGpLm6/BbQYiNdpRquAHP7NQLQyBjxzOUtPbKJE+nl6sAyA9TYSy5+pMOoytswcMnNWaffpavQAYCSQoC8rn9WkwnI8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:45:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 13:45:26 +0000
Message-ID: <9fbdbdbc-6708-443f-95a8-e04ee67dbd5e@cherry.de>
Date: Tue, 14 Jan 2025 14:45:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] blk: Make block subsystems select BLK
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-5-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241220222612.1757884-5-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b6065f-f6bd-43f2-5d22-08dd34a1b369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTFyVzZGZGhCdDBNOXlRR2wwVTRodTVjTDNoVW1jSFgxUUZYSnYwYnN1dGQy?=
 =?utf-8?B?SVdaMW1sNlZVRXdlNjc0Ump3RmIxeHJLUk9JZ0tUUzhmV2VyaEVOOXF6VU0x?=
 =?utf-8?B?dFY3ck9Lc0JvNmJXdWZ1WUJWM2JsSGhwbVNHVm4rMmt1a3RPUm0wK3ZUakpH?=
 =?utf-8?B?aE9oMUNnVWVXdU5CaGUxenRJc2NuRkFtZ1NTUXVMOXQvWmJoOWxmanBsaTNK?=
 =?utf-8?B?MmNOK3JHR0d5NnhQaFZiUHY5N2xjU0JLWlpwb3VxNm54dlh4Z0VESFNUbDRY?=
 =?utf-8?B?eVhwQ1pERVkyYnNoOGhramNVY2Z5d0M2aDJweXRCMFp1S1BicXhMZW51djlL?=
 =?utf-8?B?VkRNZkwzc2t4MWpqa1d0cTJZcCs2cE1ZWVJYa05mY3FKV0hPWTZXNm9Sektq?=
 =?utf-8?B?T0VBNDhYMzRwWDhCcXVoSnFMTGQ1aVRQZTBucjVFRHY3U2c4SDZjYll4eWRq?=
 =?utf-8?B?YWhydUhEanYvclpJNkRhejRCTWxlSW9ESzhsNzJlaGtLZnBVZnJrQ2xvdEow?=
 =?utf-8?B?NjF3UGNTOVVRdlBSWW5KbUlWcDQzZElheExEdFNnR1NoR1dNRzlmMHpMYnBt?=
 =?utf-8?B?WkgyQXlSODJIa0pNVlZibW1neC9TdkdTVlhZNitWTys5Q2lXZUF0VGs3WE9B?=
 =?utf-8?B?RmJjSjJhYjh6bnRrd2YzU2JINkxOWHJuK0tBZEw3TXJWNGhEOXdVeWIzUHAy?=
 =?utf-8?B?aEcyUkFxQ1F5YmF5NXd3NGV4d0xjRTVjMjRaZ01IT24xdVVHNnZpV3N2N1FN?=
 =?utf-8?B?c25nc2IyUmo4SDBXUHZFY0oxTmxGMWo2eFh2ZFFYVUVvSmxwaWV1eEh6dXFp?=
 =?utf-8?B?Z1JLNnZpY1Y2T3FrMGNGYUtteURlNzhGN09QTDdnbHlwL3cvZFZGN0s3cnVU?=
 =?utf-8?B?ZlhVZVc1d2R2WUEyV2dqdlpsZERtTmdqOVp4R2drdEFYUURaNlFGWmNTL3Ju?=
 =?utf-8?B?cmg4cG5vY2Q3RTF3YTV1RjRKUE4wQWduUWpoQ3FWNDdHZVNWcXVud04xazdO?=
 =?utf-8?B?RTJRY0dwNDhvTVh2VUdyQk9TMDFQSkVQMS8wZGRWL3hXbWJaN082L21YWmJa?=
 =?utf-8?B?S05rMHVMNTgyMmJYcWJNNVdrWkoxYys2RVVQUUxqdUdBL3VONUQwS3VEd0xV?=
 =?utf-8?B?djJXOExOMUxDTlVEV3JmN0plS1ZWQjZVYThtZjA4b21Idno1UkRkL3F6K09z?=
 =?utf-8?B?eWZ1SXZUMHdkRG1pVlF1eEN0VWZMdzgxamQzT0d5ejREUmZXanJzQkNPNVg2?=
 =?utf-8?B?T0pSNkdkeXdLbGRGc2NCcVp5a1lkbTIxZDR2K250ckIvUHNOL2ZJR3lTSG9a?=
 =?utf-8?B?SWV5ak04Z0JTOE56T2MwczU1eWgrMDhQSkZtelFvTmdLZzZMSnQzRFZJVlNt?=
 =?utf-8?B?UEhHT2RyMi90N0t6ZkdJODRkUW0rbTI4Z0ZWMWhMaWNhVWl2RjFYaXBpWm93?=
 =?utf-8?B?bVUxQTZMODNEWHRVR0l5dWdYSzZMRk9pS1hlNldsSzJ4RnVBUmFBT0JBaDZZ?=
 =?utf-8?B?OHY2MmNBQWZwSDdicllmcFRLYlVZVWNRTnAxNmtPdEt1RW9pTVVTb0ZWZ1pF?=
 =?utf-8?B?emc0UUFKc0dWUnkzeUdkNnNDaEFBT09qZUNqOXZoNlNDMzJpaU9KZDJFeW85?=
 =?utf-8?B?b1I2ZElaNTRmNHROSzE5NE1UdEliMUwzcE1vbG9MRWlFcFlnRlgxMlpJMTJZ?=
 =?utf-8?B?N2d6cXBlaGxEREhQam5XV0FrWU1xcXd2TVBxR3drSUZ6RWZSNjA2dG9TUDdr?=
 =?utf-8?B?bWhuWGhEWnVxWmwxVGQ1NWpKTjBsMVlrRmlBbGFCUjRFRnkwelVCOGtSZ1Mz?=
 =?utf-8?B?Y0hmZ0ZwODI5NDlTdWFSUVR0bzBrT1U3S0VmN0VuMy9EeUVrZkdlSGhzd2Vk?=
 =?utf-8?Q?u0tMfNdsCRhFk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGxYbnQ4NndJR29nLzF0SEhvV3hSa0NjelNLd2VIU0hBNzM3QUxzRTBDVWM2?=
 =?utf-8?B?c0RzYmhIV0pkVExCV2crcVpucVlJbUxseUZ2WmlNSUF6OGQ5ZlpaSFo2WUxG?=
 =?utf-8?B?OVNzYm5RRWUrV05JVzlwU1NpMVhMV243amM0Qm1IZlFzZ3dwaThyU3MwVXBs?=
 =?utf-8?B?TnU1M1l0TWZsWjVRanJoTk51aitLdjZyLzFnSElaZWpGRjdORTZqVTN3WGJC?=
 =?utf-8?B?QU1FdTBiYlovZ29QMmN2a1VpRktTU3Vtc3NBODlyKzdFaDE1UnBOUnhVekYv?=
 =?utf-8?B?UTFsc1dQcTBMQlg2SzM4andSRHVSWTRnRXdCRU9hRUg2aXFiYmtMS01mdzBD?=
 =?utf-8?B?NVBhaHF6OGI4OWJKKzNuTGJ5ejBZN2pnTUFsVkhyU1lqU1cwdURmVUx5Z0xy?=
 =?utf-8?B?emozbVZGTGVFd2pXNVY5ZjFtTStCUC9rbHpneis1WTh1eC9ZVzNKMTJFQm5x?=
 =?utf-8?B?VEdzSE5nUWkxY3o1MmNmcE5WWDcxMWxQWWdiVUlDR3ZVNUJqY0tIVEZaejVa?=
 =?utf-8?B?QkJSTUxmTFA2R3VMK09EL05iUklmQUM4TXJJS2VEQ09SQTQxSDY0Z1Rtb3pT?=
 =?utf-8?B?RERMSjlSaTkrYmRHUnpKdTAxQU9ZUXRUa1RMZldvWTFEOERlUHhYWnlTUFlr?=
 =?utf-8?B?cnVsYlh2a0EwZUVZdGFla2RUNDgzV3kyeDk4UkdUblZTTFZqQWFTWHVRd3Qx?=
 =?utf-8?B?OCtwa1Y1OHd6MHY0bENIZnViekxCSlJBeFZaYS9kR0xHbDVreWF6RFFOdWl6?=
 =?utf-8?B?bmRyc1hjWmt2aXJzK0h0bXdtRWhESVZhdGpOakxXaE5MZEJHamxSTlN1TVI1?=
 =?utf-8?B?WEFERlIya2J3L0ZQeE1EWmJxMm9IaVY5aytyOXE1a0QxV3FoZEVJSE5LQlhu?=
 =?utf-8?B?UlNXOC9lOHU3cTM5NXhtQlUySUxKUkExVUtLakxzbE8xekVFdkRPOFg1U2VD?=
 =?utf-8?B?djdoVmlQNmZNanlhdnUwWUNTWWM5Q1hMbTh4VTMxeU1YMmFtanM1cllxeHIz?=
 =?utf-8?B?MDUrMWVPVXBPWGRGbVkzZkRWUWdab2JkZjN5RGNlSkhyd2tBeGw4REtQS0JX?=
 =?utf-8?B?Q1QwMHo0b05TanVUYVF5OXZWSmZBck0rSFRQeFA4QWJLSlZsNTEvUzBFbTBE?=
 =?utf-8?B?TWRPam8yaUgwVkxVN0JsZUNyYldVckljUVhUbHZOQnJva1JNYWFwczVDN3ls?=
 =?utf-8?B?bGpzM1haUFJDbnRHTE1OdHdCREdYbFc4QVhvdFZHYmJmRHFtdWErRTZjbVo2?=
 =?utf-8?B?SzVoTldwNVMvTnJaK1Z6MU45Sm51ZjBuQjBiQjQyNHFaV25TK05uR0hXMk1y?=
 =?utf-8?B?d292V0VZNkdWVm03em1YczFkUHVSaTJQU1RvV0VnTmo2TlplR2ZzWnRqQVFj?=
 =?utf-8?B?NkRxVkU1WVZONlZQcUp1cy95aTZTL0VyZmxSU0MyazZRUFZRTnREUFBjSlZi?=
 =?utf-8?B?RGJFaXMreEIvTXQ3b2plajAzNjNCU3YyZXFSN2t3aldQbmZWVjMxQWh5RnRl?=
 =?utf-8?B?QnhneVoza3pKSjBlNHFoR0pPMkVRd1dmcnJRbWNYdWZ0ZW53TGRtRUhTSzBl?=
 =?utf-8?B?THdqYVlGNHpGRnZJNkRIZTBsdHBYbG5qdTNCWTNZM2xHYW1hbEpQeDNqYXFC?=
 =?utf-8?B?aTZTK0ZDZ1o2cTlJK0xvTWRnei9OZjMyaTNZTTRJOXhxYjRUTjdEenN0cmMx?=
 =?utf-8?B?dXk1emNKc3JqV1ZMQkJUMTdrR2F0eDNncW1GQ0w0bk1WeFkvYk5rTm0yNzNH?=
 =?utf-8?B?Q2w1dGsrSTl5YUhpd1AyYWlSUXNjODRjNHFRczBaWHJvMGRQMCs4ejZtUTdr?=
 =?utf-8?B?ZG5TNmYzbUFhcGx3dThNem5Zc3BGbW56eUZrWjJZZVpITVBSRVkzcVVMaUQ0?=
 =?utf-8?B?WWNJYTB4UUVzc3JNQmh5YjcxUWxvOXdEaGJob1BERCtOT2Frd2x4MjhZWjdN?=
 =?utf-8?B?WjBwKzg1V0dEdDNpcVhUcW1NbHZFRnJKWHhIT05LekZRb3h1Y2tqWDlvY3p4?=
 =?utf-8?B?eFFUbnhJd1RyUHU5bmxPUzQwaEFnY1NJbzV6bGxvZ1djbUhlQWFWSzNEb2FU?=
 =?utf-8?B?L1RYMjI5YS9XaWVmZjNWSjNiUGQwRjlIcEJNREVsMmx0VGdwTjFjZEpsTGZh?=
 =?utf-8?B?OUdkSXQxUGhXT21NektLazBPZGhaMG9IaGhJQlM5czd5dDE1bjRDUHFoYVFu?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b6065f-f6bd-43f2-5d22-08dd34a1b369
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:45:26.2381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQoGHUJ4uiS7fc61DG+/ZJJN8Q0N3A0bzPI4+Jm6h7vjcSpZHEriwnUxgIB1OfS+zMmBICSuJbQkwHJ7uzcIxiqS9SYLrwWRtkxBcruUf4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
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

Hi Tom,

On 12/20/24 11:22 PM, Tom Rini wrote:
> The BLK symbol has a few meanings, one of which is that it controls the
> driver model portion of a "block device". Rather than having this hidden
> symbol be "default y if ..." it should be select'd by the various block
> subsystems.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   drivers/ata/Kconfig    | 2 ++
>   drivers/block/Kconfig  | 7 +++----
>   drivers/mmc/Kconfig    | 1 +
>   drivers/nvme/Kconfig   | 1 +
>   drivers/scsi/Kconfig   | 1 +
>   drivers/usb/Kconfig    | 1 +
>   drivers/virtio/Kconfig | 1 +
>   7 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 4fbb63a148ac..29ceab849c02 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1,6 +1,7 @@
>   config AHCI
>   	bool "Support SATA controllers with driver model"
>   	depends on DM
> +	select BLK
>   	help
>   	  This enables a uclass for disk controllers in U-Boot. Various driver
>   	  types can use this, such as AHCI/SATA. It does not provide any standard
> @@ -9,6 +10,7 @@ config AHCI
>   
>   config SATA
>   	bool "Support SATA controllers"
> +	select BLK
>   	help
>   	  This enables support for SATA (Serial Advanced Technology
>   	  Attachment), a serial bus standard for connecting to hard drives and
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 5283d8981e09..cc75bad02b8c 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -1,8 +1,5 @@
>   config BLK
> -	bool # "Support block devices"
> -	depends on DM
> -	def_bool y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
> -	def_bool y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK

I believe you missed adding a select BLK for the PVBLOCK symbol?

Looks good to me otherwise, I was actually confused as to why we used 
def_bool instead of select (see what it prompted in my comment for patch 
1 :) ).

Cheers,
Quentin
