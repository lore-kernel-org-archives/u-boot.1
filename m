Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A44D44D5C
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 13:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181B088CA2;
	Wed,  6 Nov 2024 14:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oAQSxCBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F928909B; Wed,  6 Nov 2024 14:49:07 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E94388009
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBmM+0kNSCRGb0cgyxFLS86VHwtaiRHXeHmfXJIJu/BKpL9aygn+x56rjFOsZ3nVrBa13578ULIOawxYT441TZt3wpgWh42GMH2lQVUmVIrPDrbXAKLOnoWPSKNWk3j25iG8KoYgToy2AokVBg7VEjwm1XMIq5idfo/LMRorfvd1tAILQQsfJcQBKXUUxFDkg5HXAtMoShVeNNHvnB4TRD1APjvObpSYsoipzlvPnV+A4C1C3O7fuR0WCDFsT91c+aO/3nIW26D68jbJTuiJ7665GiyAX+D3ruazkMg/GrMMyDumyEckRfqiOkIbx5s18vSuTn5jaG7v+jqZupwEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxCrJVgpE23vPOFacU4TdlDGsjXZE38sVAu29JzHFJE=;
 b=s5ER8d5QKdxDWa80JBzAsWUtseloRD/Im0PCS7JOf+fauFF18gY924YMqydt8rF0iw+VKCBdoIk9398my18UC/Wy3tXzrW7PCHaW6HLOPcHHuLsQ+7KByLNkR6HwgTRdFbtH/5yY02Ei5ZebJPDmcqFdA1yog84EyavKu+djETlCfJzljtgIz/R0mlImf5/EHlKhWhDSF7lVkRKhRjdHUNIOuqBCc4o6yVyz+I16WYO/aeDBe/CGedvS89cjHlK37sCRZF/nnTGNhDLo+2CFgx/zRRf8h5FFePcyIkKbPgGC5v2LYWZY4p1Bv02n9GsupPwkrAfPHGWh6NT7FpEevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxCrJVgpE23vPOFacU4TdlDGsjXZE38sVAu29JzHFJE=;
 b=oAQSxCBrRnZzKj8q+qN5uhDqZEGIQ4Ec3kBodYY0RGCVdeUEcQPBYYFjfzTGeOXLJbaCu8xraO610w0mnXwiH7bEBaszTX8JP7wC2qQjPiiQSIj2NPbdYhoDb4N8bjX7p3VG1HnUwmL4NwYbnKSRRrxaGrZGnfyzxXfm23XQwJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAWPR04MB9814.eurprd04.prod.outlook.com (2603:10a6:102:37f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 13:49:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 13:49:02 +0000
Message-ID: <ef7ac63b-0792-402b-8dfd-d15ccf427cd7@cherry.de>
Date: Wed, 6 Nov 2024 14:49:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3308: Drop unused rk_board_init()
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
References: <20241102204516.3633375-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241102204516.3633375-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAWPR04MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c3d679-3e0a-4136-b473-08dcfe69c5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWdPRDZLOGFOMU4xU2wzQ3JEeU5iU3ErdFlyS0FoRFVxRnhTYW9YTjZTQXlU?=
 =?utf-8?B?eGNmVXdYOGR0a3FkNXFUcStQNHJmM3hmL0NtVjRFdU82VWVUVVp3QWRMVTNa?=
 =?utf-8?B?QWhaS0RSVFVDMjBlcmgyZ1k5Z3RIMWI1VWpoc2RpMDE4ZFUzNlQvWDJ6cklW?=
 =?utf-8?B?RjR3VytDR25zQzBlOUdvQVZkQXlSWlQrWXcvQUZCNHRaWFVHOCtFdlRkTGhU?=
 =?utf-8?B?S2RKWWg5Sm15ZGVaYjl2SEpwdUNLc1Q2bVlWSkJOZXM1WkJSc2VjblQwOFI3?=
 =?utf-8?B?RURoN3NMUytuanVoWmtBSXFqaUw5UDhha3VzWFFaSmJCQ1BXVzVFenNUNFlE?=
 =?utf-8?B?RUNtdG9tUFp4Vk0xWkIyNEhyNkJZd056R2xLS1NlRjB2dHJYRzVTcWpWUGg5?=
 =?utf-8?B?R1UyN0duUjJubkprV0xxSFpKMWtsZCtRL0tYam4zS0NkemJleUhjZ1h2WGdp?=
 =?utf-8?B?T1NWaDF1L1d1cjcrNG93dVpoQVNFRldKMThlbGh4UGZZZTBvZHhkYjh5bU8y?=
 =?utf-8?B?bmZLWkV5aWdVMHF3bDQzQVYrZ1RmcmM5OHg2eUl4UnRrbmkwblcwUzhvMVNu?=
 =?utf-8?B?dTd5V3VlWFVkQTFjZlZPUTZmOXF1WWlDeVB6WXlON2JhK0R2a0xjdzdRdGFt?=
 =?utf-8?B?M1JQYmMrOEFtbHlEaURraTRSR0RzSWhQd2VrbTR5MEtyZlhOWEI1MDVaMjhT?=
 =?utf-8?B?cm5Wb3QzS3NSR2pvL1ZxMWFFZjNXTUxLakRiYWFOdTQ1SnAydDU0WENJWFVV?=
 =?utf-8?B?VStsNXVVendneFBlZk1RbDAvRmRHV28vUFJMeW9UZkZUWVFkMWcrRHhJcmcw?=
 =?utf-8?B?VFFTcXRVNVI0Vy9Ma01DVzFidklCQVBYaEg4Y1cyVHVsdmxsZ0RieEFRSlJn?=
 =?utf-8?B?dVpHK3pyWDdCejJndlZBY0luY3FYVEhYNkRxNnl2dUQzMjB0T2VPRWEzQTRP?=
 =?utf-8?B?SWJBemNiQzAvQkhNRlM2UEJKZW50amtoQnFoZ2U3OGdVL1FBZ1AyRTk1eUNy?=
 =?utf-8?B?bk5GR2VSb29RSGV4bzcyaVpIekhkaG1pV1hJeFo2RTg4WElpT1NrRDlSKzlO?=
 =?utf-8?B?QlpMeFJraXEwMCswaHhoRnlUSXpEQVl6TVpNMi81RmtEdzlDLzNpTWtOZC9Y?=
 =?utf-8?B?SVRGNUhOYTh3K2VPWGhvVDdRbndINVo0N3ZSQTdJYVFrTldpZzVrMFJodjJD?=
 =?utf-8?B?cTQyT24wV0g1VTl1NmNxd3V3YVI1dzlyWklHaGZkT25oYTJpd0NqL21OWWJu?=
 =?utf-8?B?alVsSVdMdHhvNmVKYzJNZkRuUmNiZnRjVHZCTFFiKzRNdDFxb0kySlZIQXk3?=
 =?utf-8?B?VUJydkNod0lDZGthMW9vK0R0WWRkV3EwazB1ZFd5V1ZXcU0yL0VRYXZCVHZk?=
 =?utf-8?B?aE1QeHlKbWlMeTRMZ3ZOMnd1VU9iOVpiZFVtNCtEMzd0Q2hmVFlER1dKN2cy?=
 =?utf-8?B?SExOYlBXL0xRcHMwamVTMjNRcEs3QW5UQlFlUkJRd3ZDMFpiZEZHQkREMEl3?=
 =?utf-8?B?djByKzRNYnBsK213MDVTdFVNL2xVYWVYT0JOL25nYmlXNzhJZm5Eb0U0UDBB?=
 =?utf-8?B?S2FkZmdncVBvdDNRNlF1TWV4bkZ3NXUzbkU3akhrdGpxZUJKYXFyVC9oeXRC?=
 =?utf-8?B?OGxEVWwyMmp0OVU0K3I0ZWd4WjYvUG5VcGEzRGlWclhnYmJDS0VIcE5ZcmRE?=
 =?utf-8?B?ZkpHVEYxRVE0YzRNbmxCWmhZaHhrS1Z2Mkx3T3pqcm9RZmh4bEdYazgvRUZ2?=
 =?utf-8?Q?NSL9+BPF7j4IYtUuFbr+7WLncyI7lhBNcHldnsU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDFUOXlBUks0MUNUMTRxamxVMWRzQ0hSWTRDNndiZmprYnF5R3dNRjFNSkMw?=
 =?utf-8?B?M2tEdFBQYUtmQmlKWVZ6WGNXaHFKc05jazlHTWZvVGk4eDVmdTJIT3E4VUs5?=
 =?utf-8?B?UHJ0dVl4SkxsZFUvQ1JDUHEydHNwVVBpT1E2YUQvWTh4djRVai9JN0tmM3RX?=
 =?utf-8?B?M0xlbytWanZSeUFKK3VWRGNkbDZxU0R6RG9UTUtHYUlDZjhzVFRyOXFWQkhq?=
 =?utf-8?B?Mk15K1NENDVCNzFleC9WNUhKbERuUjYvU1RiRk52eC9ib0M5QXNURDJmOVo4?=
 =?utf-8?B?YVlhYk1NaWZ0eEhha0d2YTFSOVpOUWVpMHcrZ0RWNWZKK1dWS3ZibTEyYUVQ?=
 =?utf-8?B?SG9kMzRhVTZhQWZuclVqNWJVVnFuZ0VzM0ZsWUJSNmFXdDVia2l5aVdjUm9J?=
 =?utf-8?B?M2xaOXV4cCtRL1FrME5GcGZKWXVyRjRMN2Yxb3VQaFRFM2pUL0w0NGpnU1I0?=
 =?utf-8?B?aFprcUUyb0dQUy9jSlBwcm5RWW5lNnc1SGVMRlBNZVQwT0txejY0M3Z3Vmlh?=
 =?utf-8?B?aGFPOW5HOUtnTU5GVUtzYXRpaElNUWx0aStiVWllYUZ1VmZNVHdOdnRsQVpK?=
 =?utf-8?B?QitSTkM5bjFqWVk1Tmt3dGpHM1phM3Q0dWNnRGZGa1lhZWYyT3VHU2RreWdq?=
 =?utf-8?B?S0hBZ296QVArNVJVejF2R0owUlFLaGt1ZTlPYnJCdlRLQjF1Rkc5L0t5OC9N?=
 =?utf-8?B?Z2pmZ0JEcXM0RnhBNTRWcnRXVFNEUXdnYlQwV1krSU9kN2ovUEs4Y2JTMUpL?=
 =?utf-8?B?SG5mcDl3RlhoYVJiNUg4WmNaeUExSEdtUTNHVS9uL2xCbHlWQkVhMlA1cDdJ?=
 =?utf-8?B?YjdScmJjR2tXTURJVDlBMUNHRGtia1RjTjRzS3prYk43dERYeXR5QzFpSXNx?=
 =?utf-8?B?ckNmQ1ZBay9tQmxNRFVSQnNaVkM5OTBrMWJlSkgvRFpLb0FZNkxhQzlrVldr?=
 =?utf-8?B?R1RaQkRRWksra3FzWHFuOEkzSkpSaWNWWVljOTNMVUJJTkgwSUZSVldjbGlJ?=
 =?utf-8?B?R0s0VHF2UG9pVGdxQ0tGaEpCUk5xSW0yeUxSRHpqY1dKeVNwV1h5WHM3d1ZY?=
 =?utf-8?B?M1grSFBlMGhFNEhQcnpQZFZ5OEl3WGRUUDhLZllnWlJ3bHFmTlU3djlmMnpR?=
 =?utf-8?B?UndLaU1TcHpvQ2FnOXE1cWg1aUJnM2VHSmFrTkN4R3Mrb3M3YWQvbHpwYnRE?=
 =?utf-8?B?eWdOSTNad0tOSUdBdXNIeEE0cjhKc2Zyd0RDa1VTdGc1OVdiZ3hLemZmM0dE?=
 =?utf-8?B?SFFrMlczdDlmYjFXeHUyQ3V1Z1Vxa3hWemt4aUdMVFhmd3Y3WTByNUorTk53?=
 =?utf-8?B?cDNzS1hUQTlwL3RxU3BQTUdTNzZiTFFDSm93UjJiRksvY1dMWXVPUDAxOVVJ?=
 =?utf-8?B?MEJVd1V0VWI1bTEyMW1URHNiZUhRMW9kWTZuVVlwUmpMd3N1WkdhaFpxT01q?=
 =?utf-8?B?V0NOeDUxUisvaTFUR1BxNnBTSENLQzdyUHY1anRHT3JvT21KOHowSGpKajZo?=
 =?utf-8?B?SkdycDJoazhhR2JHMU5NcnZOdlRZRVJMU0pnTnM1SENCT2dRNStiNGxWTWZN?=
 =?utf-8?B?L0d6b2lOL0d2enlVMUlKOE9XWjNMejJ1aC9wT1loSGdoblJvVVJOSEhDV25j?=
 =?utf-8?B?TFYyNmRrK0tsb082akJ2TE15RGNQU1l4cldoU3EzY1Z5aVlHcDVqY1NnYVZC?=
 =?utf-8?B?MDZkV1V4VFV2VlgwVWJwMGYwY2YzbHZtOWZyZjhIdDRiU0tnaG5wQ0wwamVx?=
 =?utf-8?B?OUVjSjJGNDRJYlZGNTRyQS9OSGRGbG9UeHd6MTdBYjJGZlFqUDBDM0pmb2RB?=
 =?utf-8?B?c3l5QUVLSzNIVk8yVFFuVGFCOXJBRHZkeSthMFkrUzB5RXNoeU0zeG1kNDJa?=
 =?utf-8?B?UytVQ0hldGNwUmhRMU91dGFZTHR2QkFyeW9VNy9wUTV0b1NtZlJTbFNEanNF?=
 =?utf-8?B?Z2hKNkQ5MUc3SkltYkwwYS9YNFkrNnBJSUVIVWdjNXZ2elB6Z0FYRUJaTCtD?=
 =?utf-8?B?WXFPVGdiN3M0SjJLM2lWei9maG4rS01ZREFKa3Rvd1Z0enc5ZTBrTm1kQnZ0?=
 =?utf-8?B?UHBBUlNZUVFVVlk0NzI5N2tzRGZFZkQrZlA1K2sxd213VUlWK1dWYk1GWkM4?=
 =?utf-8?B?OG1zd3NrNlJCRkZyeU40NUhuYjJSei9JbUZWbENnb0JRNmhQT050K2h3NFh1?=
 =?utf-8?Q?nWzhypr44X4+bHlCnvmRHXg=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c3d679-3e0a-4136-b473-08dcfe69c5f1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 13:49:02.7711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOxLXYwD8/A06yG6v+WthntMu65f9fqLeD8opIBvQww0kim4uGXT5ocGeJ3/TLFYCbYBTJW348QA0GrF+cebtedIwke+d922IJML07cBwz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9814
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

On 11/2/24 9:45 PM, Jonas Karlman wrote:
> Nothing is calling the function rk_board_init() and the io-domain driver
> can handle the functions intended purpose based on information from DT.
> 
> Cleanup by removing the unused rk_board_init() function and re-sort
> included headers.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

git log -p -S rk_board_init

only returns one match and it's the introducing commit in which this 
function seemingly is never called.

I'm really wondering why this wasn't shown as a warning by GCC?

Since this is the IO domain for storage medium on RK3308, shouldn't we 
make sure the IO domain is enabled in SPL for fallback mechanism (i.e. 
proper isn't found on the same storage medium as the one used for 
loading SPL)?

The IODOMAIN isn't even enabled in proper for the EVB and the ROC-CC 
board. And there isn't an IODOMAIN symbol for SPL in Kconfig AFAICT?

Not that this commit would change anything, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
