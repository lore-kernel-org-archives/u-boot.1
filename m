Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70401C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 07:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1CEC8885D;
	Mon,  5 Aug 2024 09:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dt5Le2p8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 670488886A; Mon,  5 Aug 2024 09:19:43 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB2088327
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 09:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usUIcCb3gT8rCderWEZDeN2fgokAKfYYMSwZch6EoZF4kH0dOekNpH/8iNUMmUgXjtdeRAiH5zB/GRIrQqSn9Jo2104HCNc4F2Oxt1uPZDYVMMCqwDibDwBqiXo1VKMrGQfRM2tybSKZaD2zxILM4Exybh/CxHz4vNUUgi8/hoaqgY9q2qWuIzrwuh+70AO2OMkqV4KWJRPWzwwRszG2ZmfvPHwM5JhUKdrHjiieqEoc9GcmfrR7uQlB9BW8C2TzAZpS89VdrmRqt7Kh9GNsiOuDiM0kxyJTB0OyTbHW+2FI+MuqfJeAmsggPluFIMOM5XqFhfjVWNf1SvH3iLHKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj18pXMp5eN9hzxBDAFipiK2+TYdFWaNxm7Ryrp+4H4=;
 b=RV3FaaXsH7sOxcelA70tp43MVX/s8WiNnAPCtkN4jcb6oW1PSHxiI6hNc/ivtzrThlfvFbqVldiQhOGho15WX3E4Z1Qhh8Q1ZwB14BhafL0fn45/1ivib2e1yEsYkLdDGSQC6MHdYxfCaA8ZwGPQW0k8QydoeiWcJ3awL0QT8OT/gb4U3YqHUJmIaGMsDuPMPVHaHUG7wFeGZj+dar8MJiCR08nclW3xHKeRPoZQUmHrTokiOIP+b92QqZVribn7fcupVpRuT93fG0IwQMfdbGT0BwZSZ170pUZL98Rn5e/uTnvWxkUmSMbYa9PSygPgUl+EurZ+Z9hguoxhF/5QTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj18pXMp5eN9hzxBDAFipiK2+TYdFWaNxm7Ryrp+4H4=;
 b=dt5Le2p8JchZVBARon+WHFXjIVNXhOlLOEmty/euKy+N6GAAkPrGu9E+VmU7UFjicceasS2JK8aJD7tiDxnogk0lSVljXRqZnin4yoGv99zbbjzhSI1Fk+H1ZB3S2JrTUuPDq/77reNndubIdqy3zRd/60QcVWVglk5WnIEh3EA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Mon, 5 Aug
 2024 07:19:37 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7784.020; Mon, 5 Aug 2024
 07:19:37 +0000
Message-ID: <b96a6544-05a9-46a0-8be0-379835a9c175@cherry.de>
Date: Mon, 5 Aug 2024 09:19:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: ns16550: Try get serial clock rate from DT before
 CLK
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240804150955.3521296-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240804150955.3521296-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: 42887a9d-1b70-41d9-edbc-08dcb51ef69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHB4MVZKUkR0MDUraUd6NTNCUHJtaXJDOHoxVTMrdWlkV2J6bmQyNEw1bVE2?=
 =?utf-8?B?WWI5WHliVFc1Q25tM1VxSDJFQkpyaGRKTzR0azVLS0dVQXFVMXh6S1lSS1BX?=
 =?utf-8?B?dUtUVyttbkVhbkdndHRzZHNCTjBQeUpjWHh6Tzd5QTFGcWhlNExuUGZDQUor?=
 =?utf-8?B?UDNnY1lIdFNGY0RUWXo4MUx5azNQM0FFODg3UUR4MkVDVWYySlBoUWVFazE4?=
 =?utf-8?B?dkUrci9OK1JoNXpOWm0yNzJ6ZUlkNFh0Wmx1Uk0ycFJFeVpleEF4MG5STDVM?=
 =?utf-8?B?RUplZ3J6UUdJd1lueVVHWEpnZXo1Tk1sNVRBOE1LbWdXK0hkOGE0UXkyUnVC?=
 =?utf-8?B?T1BqZ3ptd0FGZjN1ZG9CdFdXRGdjWU5RRkE1ZktRYVBrdFB5NWZBQ04ya25Y?=
 =?utf-8?B?b2JrbW9aSjVMRm9GSi9odW1ldjhIOUJXeXAxT25OcDcvNm00N0Fpb3dDdWxx?=
 =?utf-8?B?UzNvQTJYNlk1QkthcmhzYmxtdDR4amFmc3VTL0ZHV1A5NVMxQUVJNFdTOHUv?=
 =?utf-8?B?Zyt4bnVSc2lJUFBaQk1XcXRUMEJYMHRFK0xKYkQ4ckNONTNPSi9PaTJLcVRX?=
 =?utf-8?B?SE5VbXBwTjlBMzlqWWdEc25aSDVNV2o0ck1mSUs0eHlZUWkvY0hua0ZpZXNo?=
 =?utf-8?B?MFBhei9kR0UzTWJJRkpaYWdUbHU5OEpLdk9wNkpud1hPemRHQkxjZytkVlhQ?=
 =?utf-8?B?WU1TaWM1QTl0NURvR2VDNURXZlB4cDVGZis2YUFFakIzVDExMnNLTjVIVkVV?=
 =?utf-8?B?WlczOTZjK0MvQzFuVkhPU1VjVldBSnAvZTgxS0RGdmxDRlNQSVNxdzdwN05S?=
 =?utf-8?B?ZG5SY1Z3VXZwajRsK25zWVlJd2FyTVZqaStSRXVDUWVaeEJjWHl0MUloV1Bl?=
 =?utf-8?B?SGZNN2UyZHh0NktEVHY4SnpvdzZ5NW9rNTJnT1MxUzR3WHFrTGxVdDFZUk1r?=
 =?utf-8?B?WVd2YmVuVWtsUk9RWnhPYVZiL1kvbkJaTWg3TVRzRGNmOUJManNqQjQ2UXJz?=
 =?utf-8?B?MU41eVgyQ2srL0YrQlQ1Tit1eWxqQUJOa2JGVGhWTGI4bzc3Tzc5SDE2OERB?=
 =?utf-8?B?OUdBQTQ0ajM1RGlFNHRpV1c1VWExY1N2YU9lNHZQY25JVC85ZGJVdE5IS3hL?=
 =?utf-8?B?TUwzL1NwYXp0UjRrUzRwcXpLLzJLMHZKa0x5WHhLNElLL09Jc3IvTXdvQUlz?=
 =?utf-8?B?VWJEa1VITStxUW5ZOU10SzZVYzZVSjd3czdvMDhMazVaRWZvL0l3TUhnTEJ3?=
 =?utf-8?B?Z3RoNm5heWlZL2RtNmI3dFF1UW40VjA5aWNpV2wyL1NycHJ2TWdtYmJHVVFZ?=
 =?utf-8?B?OVJrZGw5MGkxZTNnamNoTDlqOEJURHNUZTBIakxBNi8yUFRzSE92SDdNbmRB?=
 =?utf-8?B?Z0tzcjNlOHV5dUxUVnB4T2FrYXRTSVNLSWROMit3QUFkSDhkYTFDam1VTDV1?=
 =?utf-8?B?YUZWME0rblV0ZmFZUklPbklmMjR4RGN1MGNUbTVjK0Y4MTBieXFsMXhYd3Q4?=
 =?utf-8?B?L21QSUJ6OWJWcnI1ZGNWTUpyamJyM0VDMjdsMEpMb2cxR21FWG9qQ2NvSGt2?=
 =?utf-8?B?SzF1NUFPc1RMK3lYRmF4enhUcy9BbDcwWGJlNVAxVkhOWkk5dmEwSnFQTWRC?=
 =?utf-8?B?WHVBNWlBYlhRWGtlcWZReXlZdVhIeDdxM0pyeWJ5UlhWNG1LVlNaY1NpdnZB?=
 =?utf-8?B?VU53WHdmY3BkTGc1VUJ6WjM2bVdFTTA4dk45OTdMQmJsNFhvT3ZGVm1XYnVG?=
 =?utf-8?B?cGt0dHBqeXJuVXFrbUNOUW1NWVhhR2ZyRGlFMG5NRmdjWVYwSU9vZGlic1Ir?=
 =?utf-8?B?a0NnVXNTWnJMcUg3dXdZZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDdvN3BYMVlsazhyeVhiRFBkenJDRGNlZk9oc2ZtMTBsaE5ZVC82YnZ0Z0ZI?=
 =?utf-8?B?amtxOG4vVTgzZEhRaGpGbkN2K0I2eXFxc1dXeE5ZbGJacGhDK21uZWpKSTg2?=
 =?utf-8?B?cDZXYVBUdmZtbmNxWjdHVWxtWm1EUi92RGhuL1UvTXQ0WGNESVY5SjJhUHYr?=
 =?utf-8?B?YVdOMVFkc0p0dmxrY2tZM3p0c2Y0THJDWjRkNm81ZWNhV0JMWFVxNm1sZ1dz?=
 =?utf-8?B?UVl1blVEVXRBLzhOTzJUdExCVmZOWDRUQjNCUU9aTzd1K2dyS3BTb3BqRTF4?=
 =?utf-8?B?Nk52QTNOM0ZxSnRkZ1hsdnl6VkhhclVZbW5kanhLZlNiOGRkTFpNUHBMSTFW?=
 =?utf-8?B?SldMSlVuRmRWV1djTlljMXZ6aENsZ2dSZjBlYmVGMUFsYS9INWZFMzE2ZFEr?=
 =?utf-8?B?NjhhSFdFNVErMU8zMGdWY0ppcDZYTTMrRWxMZEh6YU1tL00zS3NLSklxeHJl?=
 =?utf-8?B?OGdMd2F0L2Z6dmpaNHJySG5kcjhUSFBhKzlhd1dLdStiOVUxSGUxblNqU2RQ?=
 =?utf-8?B?cmJGTkk2Q0hYdU1PZExLQkJPVFozWUNMekEzTDdadDZ5NnNoZTRjZlZVeE9K?=
 =?utf-8?B?MHhIc2Z5dk0rTnArdXEraE5qMWZTRWVJQnlJNHZ6eE1Wb1pRenZPYW12VFFF?=
 =?utf-8?B?OGt0SlZ0ajlMdGdvM2NjWlFTaWFYSHEwdGNSbWpIbE5QZmxmdFV1a0JsaVRP?=
 =?utf-8?B?SklBd3o3R3Vvbnp3OHUxNTJxd3lic0huN0NmWG1aTFRDSHp3bjNRRXFNNHR4?=
 =?utf-8?B?Mkp3cERBdjg5TlFIcWlVUHF3RW1uMXkzMU9WOVZscG03TG5CRVBONWRhUHhX?=
 =?utf-8?B?SUNOY00ySWdkMFNEMHB3Wmc2ZnpGc25LOE82UHdYUTZBSkVHdFcvZ3dFK2tT?=
 =?utf-8?B?a0x5d3NtVTl1eGc3ZWNGTDdKcVdnT1ZjVGp2a2pVMk9reGwreEsreHU1T2lU?=
 =?utf-8?B?T0N6SFJ4bzJFT005WVZHbkJ0S3o2SEF3OE4rSjZ2d2xLS3UxeVhnQ1VYcjll?=
 =?utf-8?B?a1RqRUUzZ1F2WU9VcHF0Y1YwMTJkb1NHSmhMdjhXTDg2TFU2aDJ4TnFIQzFx?=
 =?utf-8?B?QTV1eGRncTY0Y3VOQ0lxQU41UGxPdG5OcHMrRm5vbzlWUnpmekNiOGM2aFBJ?=
 =?utf-8?B?ckE1T245dlIyOW5ZNGFvRjltTHlMeURoZkpqWlZwZUcwQmQva01tNzQ1NW9W?=
 =?utf-8?B?OGZMVndXZ2pzd3ZvRkplUjFUSTBuTU9LMUMvaXEwUmEyYjllay9LY0JWN3M5?=
 =?utf-8?B?a2d2cG01YkhVMGdXak9ydUdwWHc0bk5SU0dQdkNhTGRpcjFmVTBOUFdabmRQ?=
 =?utf-8?B?UkttUDk0ZU1RdmxXTlFFbW9pVWRhSkh0b01PdVRXQ3BiVmtNamNWdjR1SzQ1?=
 =?utf-8?B?Q2wrZ0N4bG9hUDZvWll5bXdOLytKd3g3WWhXbnVJcHc5WXF1ZEhhNjR4MFFh?=
 =?utf-8?B?U2RWTk9XeENnSzRiMWdPWGtKNWMzTmdJRWhJNXdpUEFTd1FtZ3NGNWpNUUtl?=
 =?utf-8?B?eURzeXRaZTVydzZXY0dNeFgyNDJyVExLLy9xVG5ldVBveXRrSlNlOHhqUTRa?=
 =?utf-8?B?cFhFYi9WcFJZMkxMdTNWeFBFcEtOeFYvRFh1V0FrbmFhdGFNNkJab1lJYWxP?=
 =?utf-8?B?Vm5hckU4aEF3WEVCWWlhU3BWV0JOQmFlMHl0c1ZRVnprUFBOeHlOUmdMM1kz?=
 =?utf-8?B?TE9ETkF3YjRWN3dLR0dqNHhoUi9kYVhFdVlxU1FGZ216R3JTdHdBMmhCZWNk?=
 =?utf-8?B?NGhpQU45eWpZTXZXeC82Y3BvZFZQWlBRL01KZ0lMeEpJbHdhUW13dUhuTXNW?=
 =?utf-8?B?SWJ3WEV3UU9ueWl4dnA4U2VJM3Z1YXZ0VkMyZHFCYzJ3VjRVU3k4aUZ1ZGZ2?=
 =?utf-8?B?UmdCT1BsMDRRMWVxV0Vjam1OVWttbmxUQUI0Qzgrc0JRWkpJa3pybEtaREhD?=
 =?utf-8?B?bksxU01jdS8xTXRHNURQbm53OUZWNk53VTZaOUF6cW9FUFQzUXNsTTFueXov?=
 =?utf-8?B?dkxOKzNpSzVVOGFTOFFnZVdxa0dxUlNHVEZaN3FTelZaUEhxUzhHeTcvQnc5?=
 =?utf-8?B?SkpFbDhseWk2V3VrakhnVFZZYWNsRGg2L2ZrOUowWE9LVHdCTmI2dWhFU3lj?=
 =?utf-8?B?SENRcGQ3d3Fad0J0NVZZSjRZNXcydFhUZW9VUVFRMDdsQWc4NVhFY0hNd3VG?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 42887a9d-1b70-41d9-edbc-08dcb51ef69f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 07:19:37.2436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjZhf/vlU9xcnrGJTpmwSJncdZTmuzFMT/85iJrOarjHIvFQisZ7QtVYgTYbtLj5cklxBvQy+9A4rJH/mdZBxEHgDIodBnLUxHx8f1GGc4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8789
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

On 8/4/24 5:09 PM, Jonas Karlman wrote:
> Initializing a clock driver to read a known static clock rate can take
> some time at U-Boot proper pre-reloc phase.
> 
> Change to first try and read clock rate from DT to speed up boot time,
> fall back to getting the clock rate from clock driver.
> 
> This help reduce boot time by around:
> - ~35ms on a Radxa ROCK Pi 4 (RK3399)
> - ~15ms on a Radxa ZERO 3W (RK3566)
> Time that is wasted getting a static rate known at compile time.
> 

I guess this also makes some board perform worse as well, the ones 
without a clock-frequency set?

The change seems sound to me, therefore
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
