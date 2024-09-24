Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D4ACF9C71
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 09:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA56F88210;
	Tue, 24 Sep 2024 11:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WC4d4GAm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE96885F5; Tue, 24 Sep 2024 11:20:00 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B340488005
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 11:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+8MrusaQQeJrJZwFDxFIZ3Cu2VFeIOw4/AW+1lU+NeEZvXCZ5luErqTL+iPEyzO3bK706C48EnTPmvM+VyMggZLyQNNMHSA8xiDkq3AdqUs7qhyYegq0m60ovRVQhwEtriOwLamDmMHKIaoqD36JNu//OnogjlGY+bMLhUBtoadLfzk5qFpbedv/GK9EpEJjpry2kygNf+LeriUTGa6jBoTNCV0hMUzkhU3V/w1w1dBTwtB2qXc2U0xEACFD1zm0seB6kYWNgUDc2Q7JtoyBD6CLLd4S25i2Tf49fDws3loD+bM5htajAWaCezVxQY55qWaF+UimY+Veayvqcl/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KRyeDNzCIzrRusZg5CDfTfdwSMnFAFGLM/hfFotrVI=;
 b=O988XORxOwnAsDpfTDTMbSRAByOMUw/aQx3maVHOf7RqGy0cayP5k+sd7E9mZ1SD2ao7J/Q6btVMJUtBtiHWpb/rDmnlvwRRegzLCZMUSuSaWjf4BuBgmCFXN+q8PTrtiaSKmAporeajaPF62ePu5mxaKm4bcxTmO+5VDXQlg/6JA6nUzI73baWKOZV5tXCyyqqRpMD4Rf2cA7/XF1P6FIMW0T474rtjo4PZSBBB5Cdfgf2TUuw0XoRlbGUIT1IY8aLPaEtl1Gr9eR3kGBIe4kXuXiVMgsCd9xXjIXxqH+ZNsDeDNKqL0VWhT/e8XJK/xDhiNaBUSf1DfKdC+G2mNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KRyeDNzCIzrRusZg5CDfTfdwSMnFAFGLM/hfFotrVI=;
 b=WC4d4GAmToQfxV8gM4hXP+SQm3o+67Dl3dWCXk8Eq20DXsPjfySn9rGRjX6wbkv7JrvtlV3UDdVFS7Y5MqkNdjHcwhvQZRm/3sZgB9G+dRr+G4DotrVVhuta+0qzi+PVLZ87RcE9eEEMusVP08MjcOLFmsduWviu1H5DM20CYOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GV1PR04MB10380.eurprd04.prod.outlook.com (2603:10a6:150:1cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 09:19:50 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Tue, 24 Sep 2024
 09:19:50 +0000
Message-ID: <dc3b71ba-2993-4c5a-82cd-4f66f90b86cf@cherry.de>
Date: Tue, 24 Sep 2024 11:19:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/4] board: rockchip: Enable PD_VO before driver access
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org
References: <20240919140022.511067-1-macroalpha82@gmail.com>
 <20240919140022.511067-5-macroalpha82@gmail.com>
 <da41ca54-871e-4e40-b7c8-626a3c4a3f1a@cherry.de>
 <MN2PR16MB2941B5324EEF8193605018F1A56F2@MN2PR16MB2941.namprd16.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <MN2PR16MB2941B5324EEF8193605018F1A56F2@MN2PR16MB2941.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::14) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GV1PR04MB10380:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a22ad4-2ee6-4141-9e70-08dcdc7a0ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2VPWWpTRnl5c05kVU5taUsxZXArZFBRVkJjWkxDeGpDNDg0enhURFhzY0lx?=
 =?utf-8?B?dDlGNlIvdDhISUFzaGRJMzYrZnl1YldhWGhWdURReFJiVndsZ2Vnc1UvYkd5?=
 =?utf-8?B?ZFFoOW9CekpUbjhJdTluQS9IdHBneDVIaXhvY1lUbWxlSnVickppeXBNazlJ?=
 =?utf-8?B?TFhUcEppajNWd2ZmSER4TGpLT244d0YvMW51S0NXWXhqcVJJSVc0dTl4K3lT?=
 =?utf-8?B?eThCUXFTaUZjOFBRMzlVQWZuWXZ6SEs1Zi83M0hwU1FzYVdvT3ZpSFJoL3E4?=
 =?utf-8?B?eWpGN0RQdVhVZml5RTJoN3dlaDZudThiWGYrazFLT2M4S2R4S0tYdTM5ekxv?=
 =?utf-8?B?L2prdW9ibWtrNlc0dy9FRWpoUkNiQTluMHF6M3poNnEyczF0dGdva2FQc1lv?=
 =?utf-8?B?empPMGc4TW12Yk1yTUxFeC9mL2tDUk1USTdkWVZvQnhDTmE4WW9aZG9NSHpO?=
 =?utf-8?B?TkluWHd2OHBESlBldWZHUHdyZW9pMFhkb01EMkNtM0twTDRZd1JjWlpwbGFw?=
 =?utf-8?B?bWg2eldtdStlY2tCOENGMEJ1QVRORkZWS3NNOGxvczYwNSt3MjBvQXhpTmlL?=
 =?utf-8?B?Sm9Nd0VMSmZzR2pjZTQxOVVGWGZFaUVzdXBsc1paU2psclA2MzZFOHIvcGJQ?=
 =?utf-8?B?QVF1UWkxTm9vemhheVJaMVI4Z2RDSm1BTThvUmd0YnJ3V3J4aFM4VkVwRU1C?=
 =?utf-8?B?VEJDV1lFT2dIZTY4RTdDTzJYZHF6dmtLU2FmS0MwbjQzaHprYXlYckd3aUlM?=
 =?utf-8?B?WFN0SzBhR2tFT0FjQWowK0prYnB4ZVBjQS9uR1MwSFFVUG80cjVkeTlWQmlE?=
 =?utf-8?B?UXFWUHNFMzVIQjMrRkhDVm9CZ29oeUlVelB1UTI5QzRTdVU4VGk1LzNLdlNM?=
 =?utf-8?B?QUhxMWJQdkpkNFJ5OExKdWhVM0RmV2pUZk4vWTNBSnRXa0RiNVFnL2FUVFNu?=
 =?utf-8?B?RU05SWpabjRpRnQ3dVJGYkwvK1NmdU14SHM4dlJKUzNCMTdIRS9PVnVTekFv?=
 =?utf-8?B?U05WZno2UTBFWERqVFZaTzQ0Wk9oVGR0M0hTRGYvVlZURksyUzVPWEh2WnVO?=
 =?utf-8?B?WUx5NGwvbnZDRjhSWmZBNW1rLzV6bmlPKy9QYzR1SlRuQVpVM0swQUpIYmZp?=
 =?utf-8?B?ejJxcWtLWFkzbm9qdlNxWkZRNjRBblorNUZsUi81NHRvdzBTcFpFNllJbGxK?=
 =?utf-8?B?cGVCVFMza3k0azhYOGlnNVc5QWI1WkpNNTJMcVNsR2FVbnJwUThiQ2tCNFNT?=
 =?utf-8?B?YXBBV01IOXAxQlNZVEhzN0Q0VjZIOEo2bW9LQ29BRDVvMjkrbjZoNStLZTFy?=
 =?utf-8?B?aXNvU2tWZFc1WTlaTGQydzlnUWoxbG1IWEVLVEZiZ2JENnFzTDkrMWY5NC9Q?=
 =?utf-8?B?NDBFNTNOTGtoS3dFOWtTK0NBM1VaTCtwejIvcEpIWm5wT0dNcHU2RWtHTHVz?=
 =?utf-8?B?RlAyekVLS0xmUWJpN0RQWkZLYXlFQVVxRWdnMklmWlJkUVhqem9jK0RhaU9u?=
 =?utf-8?B?dEQ1S2p5WHBlSk5IVG54eVY3Z1RXUkw0bElRVG8rY3VSVHVjdHZCMEJvc0VE?=
 =?utf-8?B?SHkvSy9yUVNDSVdoSTFZODYwbHlwa0VhOEg1amdKM3ZtaGV2V211bzFIWlVF?=
 =?utf-8?B?VE1ycDdZZ2VzYkNJVUdxMUh6M0E4cDY1RjZidm1HUEhyVlhpQ2x3WjNESjg0?=
 =?utf-8?B?NEMyUjd5T3FKc0NaTEtCWXl6bnJLZCtjR3dmQmROUXl1NkdXOHFUWE9uYmpS?=
 =?utf-8?B?Vmhzcm9yekVWbGE5QjFQNUxYSXcwNE1ZOE1Wems4M1krOHhvaC9URkhNZS9h?=
 =?utf-8?B?S0Z3R3lpMmZ0M0ZiSVEzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhTWGllaTlxemZJWlY4TWdFRnBNS01RWUJkaCs2K09rRVEvSmpRNHR6cXZn?=
 =?utf-8?B?di9nRDVQMzhyaWRTVllFbTNwYmVnVHYxNW05UVBpdnBmTStzbnAvSUJvTFF0?=
 =?utf-8?B?QXFEKzR4UE5UdldxOEhzZm5SRjhyS2RvOTNXUjRUckVuVzliczRGKzQxMTFS?=
 =?utf-8?B?TWcvaHRtY0NZeFlyODYvcnFINEVIUkdaRjNnZUw4YWpaL0dnaUl0QTRMUjVX?=
 =?utf-8?B?Z0tYd2hXZ3F6RGdURXpMN1BCR2xlNTVXODRrZS8wbzFTbURQTVdoS2RTR3Vu?=
 =?utf-8?B?c2hRQkZUSXRxM3RlcE1tblhHcEljY0o3VmlmeUdPdW1mYTdvZmlvZGZ1Zm9x?=
 =?utf-8?B?cU9PV1U4RGtYcTQwZUZGcVdleUR1TnZjck5xa2hsZXZOTUxRVWV1VDZtQUkz?=
 =?utf-8?B?dzRFNGxoMjJuNU1TU0R1d09iVTkyajdUQytKQ2ZZZ29XakYvVEt4YTBLWXZK?=
 =?utf-8?B?Y1h1d1drOUVXY0hXL0ZVVXNqZ2RQTWR1WWkrUG9KaTl6dzVITHZkV1FjNWpo?=
 =?utf-8?B?ZWt3UjFZVFBuZE45RjN4ZlJpK2NQSHFjY1paWjVXb3J6ZU5yY0JKWXJDa2tu?=
 =?utf-8?B?WmZ3Y09lTXlPaENNYnJVSzFWY0VNTFpNdTdPbXZSUk5jb0h4SkdsSktJa1FY?=
 =?utf-8?B?TCt0SjEwRGVsaFMxVjdCYmxMdVdWeEdPSGtmZGlaK0FpOE5wdlVSdloxcUp6?=
 =?utf-8?B?UWpreFhzQkpkVkI1Z3Y2OHEvSzdKSHBsRGtzTjQ1cWJqRElUTnNWWmF6MTk1?=
 =?utf-8?B?K3ptVDlRM25GVGUzUmhtUFNhUWZjNnQveDgxd2JISHljRlNsOVhtSDBoZkgy?=
 =?utf-8?B?NXN0dmNDNmtoZlFSQ2dVUWQvT2xHRXBJVHBzZUwraGVoN09qdU1pdHQ3Yndi?=
 =?utf-8?B?bEhFSHBxei9vRFZtSUZNeHh2TSsrUy9HL09jZlcza3JsQm8xY3RiNWlQRmht?=
 =?utf-8?B?MTZadS9PTGlkOWF5b2NlR3A4RzJsWm1QcmVuZVZmakZmZXVYTk1RU2ZCdElM?=
 =?utf-8?B?d2EvM0Z4Nzh0N2RXUVhiTzNWZy9XV05FUTk5TGhCdS8wOWxBNFlXQlAvU0dq?=
 =?utf-8?B?TkpGZFYzcmp5ZEw5aWFFS0wrZ2hkaHpyNENEWS9LakpENjRUUlhuRmNZeHVt?=
 =?utf-8?B?QnNIazBValRKZW1oODJLTHo1UUJqUnBpeXNHUjQzdFVqMHcxTWdqMjBabUZ3?=
 =?utf-8?B?MXhGTFRJTUhDUEpFQ3Awcm1heThqbWVPMGZNdkxORGhyVStKWXNBdWhSeW9Y?=
 =?utf-8?B?VktkWFJLaUVOUzRKbFY0UHVtVDVRVnN0V1BrODZnUUk0bVg0TmtKWVExbWl2?=
 =?utf-8?B?YVdDZ2VnUFZialhObGxoQmpzeUdpOEdLVGFCNGtmRWczOXliK1lCNTNBY2VC?=
 =?utf-8?B?OHpBNWhRd0o1eVN4cldyMFFCSTBtcG5JaCtYV0plbklVc3pqU0drWDRmdWpO?=
 =?utf-8?B?aERLUjFyVlFTKzB0ajBFK1ZqWlZuTG9OM2pMYm4raGdYWVBRWXdGTW5vWldo?=
 =?utf-8?B?SThWUkNmOCs5bitBa3l3TFc0RUNCckp6RzB5QjVVaHFXLy82R0N6emtuTTQv?=
 =?utf-8?B?bFAxak5WOVVuTHdtUWxSTWFYT0VSNWwyNld2WW14N3RDL21lU2Z5dGNWMDRy?=
 =?utf-8?B?RG9PVittT2Zaa2RYeUsrU1M3SjErR0FFK0dJM0Q3TkM5VzlzZFJyN25MT3pC?=
 =?utf-8?B?VUgzVXJ0ekF3RllZSHM0c0ozVzJjSFhvaVkxRXIzWTZ5QW04TGNSZENsRExI?=
 =?utf-8?B?OGEvYVJ2c2c5ODBrSjhQZHQxQnE5dFBTbW5ET1ZjN3JtdlZFaTF2L0lweVR0?=
 =?utf-8?B?WE1lUnN0RTVXRGo1d2EvemZ4bCtaazRuNGdNZ1N2YVBVeU5tengxQXdtQVoz?=
 =?utf-8?B?c0RObzFORFAvSU5sbVZiVk43b3ZlRTBLMDFCYkpWaUlXODR5eDFJaHdrb09H?=
 =?utf-8?B?NktiZ3htTzZlcStUTGxpMjJVa29ta2dRcTMydzBKUWZtQTE1alNRSTIzcC9D?=
 =?utf-8?B?KzdoVTJSWTgycFExVll4OFB6SVJUOHdqSjhjNEdtWXIzamtQQndtZXdpS092?=
 =?utf-8?B?MzdIRXNJME9pUm56U2pFa3ppL2NXQjBIRUs3aFpwakJ6Z04ybmROUVhBS2lG?=
 =?utf-8?B?ZWgrcWNFRWxlUkZiRFFmWnc1U3NaT3A2cjBrWms0Wm9IcUtWNkJiNDY2YW5l?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a22ad4-2ee6-4141-9e70-08dcdc7a0ab7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:19:50.4993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CV4MKhNWgX1IN17f5+UzjP+4qiii9pwlavV5mpmEd6TG178TbhMkwxSrWwQUQCERBy2YYu1Me2LwVNTav5N/35KPvqXQTveK8TPxJJKQjAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10380
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

Hi Chris,

On 9/23/24 7:38 PM, Chris Morgan wrote:
> On Mon, Sep 23, 2024 at 01:24:34PM +0200, Quentin Schulz wrote:
>> Hi Chris,
>>
>> On 9/19/24 4:00 PM, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Enable the PD_VO power domain before driver access on the rk3568 SoC.
>>>
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>> ---
>>>    arch/arm/mach-rockchip/rk3568/rk3568.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
>>> index 1b3e40074e3..d5742b68d68 100644
>>> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
>>> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
>>> @@ -26,6 +26,8 @@
>>>    #define PMU_BASE_ADDR		0xfdd90000
>>>    #define PMU_NOC_AUTO_CON0	(0x70)
>>>    #define PMU_NOC_AUTO_CON1	(0x74)
>>> +#define PMU_PWR_GATE_SFTCON	(0xa0)
>>> +#define PMU_PD_VO_DWN_ENA	BIT(7)
>>>    #define EDP_PHY_GRF_BASE	0xfdcb0000
>>>    #define EDP_PHY_GRF_CON0	(EDP_PHY_GRF_BASE + 0x00)
>>>    #define EDP_PHY_GRF_CON10	(EDP_PHY_GRF_BASE + 0x28)
>>> @@ -130,6 +132,10 @@ int arch_cpu_init(void)
>>>    	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_1);
>>>    	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_2);
>>>    	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_3);
>>> +
>>> +	/* Enable VO power domain for display */
>>> +	writel((PMU_PD_VO_DWN_ENA << 16),
>>> +	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
>>
>> Maybe we want to guard this with a symbol for video stuff in U-Boot? I
>> assume Linux is capable of handling this just fine without U-Boot's
>> intervention?
>>
>> At the very least have #if CONFIG_IS_ENABLED(VIDEO) ?
>>
>> What do you think?
> 
> I'm game if you are. To me this just brings back the default behavior
> of the binary A-TF from Rockchip where the PD_VO was enabled, but if
> we want to guard this I'm okay.
> 

Just to be sure I understand correctly...

Would a device without this power domain enabled by U-Boot still have 
working video in Linux with upstream TF-A?

Cheers,
Quentin
