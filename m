Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DE7D216A9
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 14:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0420A88001;
	Tue, 15 Oct 2024 16:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AcwPEY4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E42D188278; Tue, 15 Oct 2024 16:15:46 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E820B87F19
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 16:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2I2XpI4s6Xw0sAcnBb5NwGVtgMruGNrs5dMXP97TKrICFiJCT5fEHa3bVvB+IWcZLXm/ioAdIGDNoLbXip+ErKvZ9/Mpvv5I6CG80roiODsjtobOUFyvC9kyX4CwiPeLkID+vJO6SXW3NbYthOF11tiF1tECCAF4rX/S+BXQSn19DGBQH7q+fFBKiWeZ4n1cHlZXZ+SQawVAqgS+wETiFT+DA0S5hMKNimO21bWee/eZC0C8wAwmP+AJj8VZaAqVl1o7zf4MF5RuV10+15iJowqKFt4qj4ceZK0qCBTZ6UDgs4L4BhJni80QAsPwx74iHG4GKKdNZljFDm5Vvux8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izLEXvcpdQf1OfTyq8VrVctCM0Qxx5st+KOAcGvHouE=;
 b=m3eDHqOkL52xzW8pJQlXJt5D62eZn0CnSWdO9m0mh1jpGEs9XQq8QNPWKOS3/yL5D/en9mFg/XRb8rGZPitZH0f3U4YzfHBUyMWOAeNzWNvyejczlvax/1H3Cqp66ZBM4AyBgTz3esauc6Z1xRVIOHUy+Rnd2QUb3pXx06/z6FQFw+uNstzCIhH5TYOUx2J0ht7c2LVLyWzb8ax/4TT8ugKkFQjSPdWOIous5JCh1E+hZlfV+On1C62pOiL+Q6l4uKl/75BtBmSdJv/VOFtr6a5cJjQYLxpnubA8FTH7t/Y3gS6XqX0ndCuVggRkYpGWXwe1soj4+GtaNhIbeI0sVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izLEXvcpdQf1OfTyq8VrVctCM0Qxx5st+KOAcGvHouE=;
 b=AcwPEY4h4Q98V/lkAPZEnGsC/KdPnpVENMMpFHvUroMFhTRmV5J9+J7fEcv5o5ZB5GdS6ibZtxeDcd7A7V+4F0HuCWmt0D6vJ65MZWiGs09GrPcPzlwrNAZcfKS0+ucPL4ajGv6cKftWXeWb6N8JGdVl58nZH+r3hTaG0Fk/7sU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7852.eurprd04.prod.outlook.com (2603:10a6:10:1ee::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 15 Oct
 2024 14:15:42 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 14:15:42 +0000
Message-ID: <40ec686d-3615-4fa6-9b7b-d9c289b9cec3@cherry.de>
Date: Tue, 15 Oct 2024 16:15:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "mmc: dw_mmc: Extract FIFO data transfer into a
 separate routine"
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
References: <20241008191834.2190270-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241008191834.2190270-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 47804d03-6883-4efd-de20-08dced23da6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFpReDdDRVRtSkdLSFhCQUdsZ3Q5TkYxY3BWa3VYWnZTK1NMb3NvV3N6eE9Z?=
 =?utf-8?B?cHJBaUZ6eVo5RWVacTV6ZGhzZkg3aU1nQ3VaM0RUYUtxNjV5Ym1wQlJFTlhz?=
 =?utf-8?B?ZnkydCs5MXVneXhXbyt1aEZtWHZpM0ZCUDJLWCtuUzJjVzl6REJiRjlVUmpr?=
 =?utf-8?B?UlpQY09FWEtHdjlJSlFzdDNxZHRmc3ptRVFwNnF1RE5nd0RhMHIzTC9MRUpY?=
 =?utf-8?B?SG9XMU9UTHg0b3c2ZXowLzd1aXVQZGROd1Z6NUdoUVk2WDJsQjhVV1VGSm9O?=
 =?utf-8?B?enJ2RExQL003ZHdtUkdQakxDN3d2Vm9IdURPR2lMc2lLL2hXdjZFRWo2ZFJh?=
 =?utf-8?B?aUd6Mmw1UEZ6ODQvcWc3eGJaWUIzdEUxOGhqa1pJSnFreURwR29IOEJiRkxx?=
 =?utf-8?B?UWVaeDFiZjZWMlBjRksySkw0QTJUOGJsVFdsZlUxWTl3L1JKMUk0bFpUdXBr?=
 =?utf-8?B?T3lqelhpaEdyeHZTUzBScktFdnd3U1BVK1o1K0MybEJYR1h6QWR0dzI3eG43?=
 =?utf-8?B?empibmdMV3M2RGxPNE56MkdZMWlXNVFDZWZzMWZYOHNzS1pIOG5HUmQ2SGpK?=
 =?utf-8?B?S1V2R3pOLzE4bFFSbGpGeE9yb1Jlb1Jzb1NJSitxWTBHcWt2SnBXcFRhQXhs?=
 =?utf-8?B?K1V1eEY2c2ZlRm5PbWE2a3JidjlkYk81V2FFRHlZQ3JYUGhTeEVZNStlTjJp?=
 =?utf-8?B?ZEZJbWEvWGpJYmNhSUQ4VzJBL2pqSlVIbFpQaWltZVlaUHpUaUFNb2t0ZkNL?=
 =?utf-8?B?YWpLT2lPcnNTTlRxMVVXSENGYlVvSGRJUHJmb1NWR3F1dE03TVIyc1lqYTk2?=
 =?utf-8?B?NHpLM20rTXB5OURFRXJ6d0N1UTdKbGJsekt0YmZIQTFBNlBoSXJxSHBONUJ3?=
 =?utf-8?B?RWZTY3oxWlB0Y1JJaW8vU05yWmlidTFpcEswOXlRaW5qd1c4R2IwSCtrczBO?=
 =?utf-8?B?UHozMkJaaHBhUmZGUnFIVzdXRnQzVlBQRUZKbHNpNzg4bVJ2OFVJTmtBUTJ4?=
 =?utf-8?B?QjdwMW01VHFteHJpZzFWeEh6UldqSUJtMHNHVm5ndGhHSE93NEI4Z1FRZGcz?=
 =?utf-8?B?TVJHdXZkTERVM3FxMGR4NHpXVU9QRDl5OGVjU1dHS1FkK3NsTFhSMUZ2SmdG?=
 =?utf-8?B?VFVpdEl6UkFsZnM5eHF1OCtqNXBaZDc5UTM2WDV0YkpFSzRraHFDNWNUL2Rh?=
 =?utf-8?B?ZllsMW1GSCs5QU1NUU53Y0wxYjBpWTIxU2RmaGFNWXRYL2tNZXIvaVhYTExU?=
 =?utf-8?B?bGVsOG5YVHkwOWxBZkpBcHFnRXloU1VRMXlNUGNJbE1FZjl5UVJ3cEI4czl2?=
 =?utf-8?B?eXF6RWpHdHJaQ01qNkc0UndSbXRvZXQ5Y3gydldzNjl5eDZSSWJQWE9Ma3FH?=
 =?utf-8?B?ZitLSWQwbmFuQjQraGpnYzVVT045YXUwRmpudDVJT1lXcVRYSzVuQjg2U2U2?=
 =?utf-8?B?ZFNyVWJGRjIzaGlVa3NxWlA4TkxoSytQT2w3cTVKWTk4cFNEMFV4MFRSbWY5?=
 =?utf-8?B?aDNOUjBaS0FEemMyZkZvZ3NnY2laUUxCM1RtUU5MM08zYzJ2SGl5T1ZzZVBJ?=
 =?utf-8?B?cVdJMHBvMWhSTTY2ZXVEaVdsREhTZStYSzB1QzlQMVNUekRWMUNES0xDdDh0?=
 =?utf-8?B?a2Y0MTZoWGVXTlNTWVVLWjVNR1BsUlJqc054alpnWnkwVE5qc0FZMG5TdXBu?=
 =?utf-8?B?MkM4MkgxU05kUXRTZ0pzQnJWS2FvdlRvT3BEUG1EZ3lLNkY5ZG9ocXNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZIM0JhTkRmdVB2MWpsdndaVlJicyswSk54MWh3eEM5bitUOGFFTnBleTFr?=
 =?utf-8?B?NVNCMkQ0UlB3NFEzbFRKZDZaOTM4czJBZEU2ditpREF4Y0pUY2RqaVpJV2hi?=
 =?utf-8?B?ZEtrYVJzbEpFdW1VUXovS2RzZHloM1N0ZWZPcmRZYkRGVktGS2ZDYXJCeENC?=
 =?utf-8?B?Nm90MzkrKy96YWllL051Rmt1TlRVRVBhQ0RaZlVEUmYrRjZlVXQzeGV4Tmp4?=
 =?utf-8?B?Ung4NkRBUjVUaTBpaHlueTcyc09TS3p0Qm5OVHZJY1ZmSmVkN1dqaXAzY3hU?=
 =?utf-8?B?T3I3ZmhnTStSZ0tRQXVpZmtNU1p1ZDFyYnd4R1hVOHNobGxiZ2tLZjlhb3Y2?=
 =?utf-8?B?bEhUWmpMVENLd0ZnTnpqemNwVThQNk9wQyt0VUUySDVpTElPU3dZRVB1TWFz?=
 =?utf-8?B?SVFxWVBUelVwUkZuNW0yYTYzbFZyN3lHdHVQZzVSRnVMM28xa3RaaEtqT3lI?=
 =?utf-8?B?MTdSWkY1STdaU2NPb1hsYXFJSERMMktxZ0I2VnU3UStjSGdncHhDRTFnT3BN?=
 =?utf-8?B?ckJNQnhZejFrdldhd1VXMUhvOFp6QWZRQXgyRFhISi9nTGNQWWJMbk9kbUFG?=
 =?utf-8?B?SGYzZlB5TE5hQWhsUUwvU3ZXdzFPVy9CS2VqcDVhcUlaUmRrN1lXS1Q2ZWJ5?=
 =?utf-8?B?eXBVOWhMaUlwQTJuV2JjUlJ2MG9ibW02ajdMRXd5N1FjZzYxNVNCMUJyRmlr?=
 =?utf-8?B?QjFRNEh3OXBWdVNLZU5vV0VRZjBUNlhaeUc0dDRtSnJCT2JjdFFwSlJZRUY2?=
 =?utf-8?B?aHVEblhMcGFsSzlqN0tQMVYxeExxYXJDNkNtQkJudjdQWTdha1NzSE1BUDhv?=
 =?utf-8?B?YVlRNmQ2R0Fsc2pZNzUyeklBTnRkQS9jRy9pWGNWS24rWi9XamdXWWZsTVJV?=
 =?utf-8?B?SmZ1enVvSEtMd01Lb1pPaFBBSDBTdENKVVFZaDBacHlPWDZvWGdTUmNkYm5j?=
 =?utf-8?B?Yld4Q1c1aUVVNUgxalcyRnJpS2FHNGN5YUYrTXJaYVVSby9lQ3ZZVzQyTTlj?=
 =?utf-8?B?UkVKb0xoNjlwa2RSRjJuQURLR09CZkgxU09DaVU2eUIyM0MrekZsZm1pejJG?=
 =?utf-8?B?czZqSUhFQlROMWdkZFB5RTNyaDhybzRpbVdsOUtBMjJpaWhWRktzNlRTZWlM?=
 =?utf-8?B?WXJqZHZDaFo1ZjFTNlVrdHFRaTVlcEhNQ1BjUXhjNHZIT3JNOFdkSEU5aG9B?=
 =?utf-8?B?WDlyZzgzL04ycU5HMUN4Uy9xWWxWWmR3NG15Y3RjMFQ3NkdCeEs5LysrOFdW?=
 =?utf-8?B?dElneXlhWlE4SjdWVkIxRVRZR1lNKzFsMWwvVVFsRko1WEEyeFcvQ2R4YzA2?=
 =?utf-8?B?RXhTMUFDd2VrM2JaaWJTMk1vaC9QeDJNakR0Z3duVXArY1V3dUhmZ29GTzFz?=
 =?utf-8?B?T2ZWenVqUkVSbi8yUUhTaVI3MUQ4TFdYNjdiblNSbTN2WWsxZlJmZTNpbmxR?=
 =?utf-8?B?RGErejZQYVdON1BqRjZ4eUIzYWdwYm5DN2pWUElyOEROVG02RlVSNW9Na0I4?=
 =?utf-8?B?QVhQOHlXM1NiUTRyM3NEcitiUWhxOXE5NjNsUDRYRk5jVmFPbEhITU9aUG9G?=
 =?utf-8?B?ZU0xdlVZLzNLMUJvUzY4NU4zWDROdGNHWGhFaVFYeFIwaVdTNngrYnlMdDdB?=
 =?utf-8?B?dDk1MlNReUdzT09CanluVnBaTG9lZmZqYWtuV001Y3lKa3FKM1JzWXNsRFJp?=
 =?utf-8?B?VlczS25BN1NpcFFGam5HbHBVdnowL3QrTmp5K2RRTFh5dytHR3dsNGFuUW1V?=
 =?utf-8?B?THgwVmgyZDBQbWplN0hPN2FqaVh3TVVTelpEM2VOc2JwVTRjTFlRT2J4cHU2?=
 =?utf-8?B?aEhGWnhqYlVlbE15cG5pWVAyOC9aN2xrSS90SG9pL2pHaytYVmpBSjhFVElF?=
 =?utf-8?B?dlpZZjRPc1MrTDJqS01tRUp3WWNnVDhPS2hkcjQzZS9qT25XdC8yTC90YVNQ?=
 =?utf-8?B?S3ZZY0FXU0QwdTViZFNWeitYYUg1WUV6NGs1Uk5kcWhXU2F4R2NIcnJUQmgw?=
 =?utf-8?B?akV6bTRJcUkvTG1zbnhsUWJZd1NmWU8vZmtGSVMwLzZTbnNhOXNhS2Vld3JH?=
 =?utf-8?B?bnBrb0RaYWVsVkZ2UGRuOTdtMVI0N05YVnBtRzcyNnhNQk0wVFNHRmJrSWVz?=
 =?utf-8?B?N3k5eG9NeXkyV1gvaFFxTXJwSjUwQldYODdXcWJ0VXJ2WmZCQzdYNmYzYzJH?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 47804d03-6883-4efd-de20-08dced23da6b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 14:15:42.7393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g320FDgVgRG3CLNBck8y0W+Y0kXu7gagIHceZ+XZ+bzNNYi1FPLOVsSXdk92fPQn5wmwTaoKfqprKsMwPQsMxcL6lsxghLz8S68vOa6wYXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7852
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

On 10/8/24 9:18 PM, Jonas Karlman wrote:
> The commit 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data transfer into a
> separate routine") unintentionally changed behavior of the FIFO data
> transfer routine.
> 
> When data is read and size reaches 0 the original loop would wait on
> DWMCI_INTMSK_DTO or timeout. The remaining size to read and buf position
> is no longer tracked across dwmci_data_transfer_fifo() calls and because
> of this an extra call to fifo() and dwmci_fifo_ready() may now trigger a
> FIFO underflow timeout error and slows down FIFO reading.
> 
>    Buswidth = 4, clock: 50000000
>    Sending CMD16
>    Sending CMD17
>    dwmci_fifo_ready: FIFO underflow timeout
>    Sending CMD16
>    Sending CMD18
>    dwmci_fifo_ready: FIFO underflow timeout
>    Sending CMD12
>    ## Checking hash(es) for config config-1 ... OK
> 
> This reverts commit 0252924ac6d4af69061bb9589d16b30c5bdb7178 to restore
> the old working behavior.
> 
> Fixes: 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data transfer into a separate routine")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

This is fixing a VERY slow boot time on my RK3588 Tiger, so:

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger

Thanks!
Quentin
