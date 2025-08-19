Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AB2CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EEC680FA1;
	Tue, 19 Aug 2025 11:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JwaF2/hA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD3581FEE; Tue, 19 Aug 2025 11:14:17 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32833802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 11:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZHFycFj7xSHZpOAM+pWlzbgZPk5XqTToi/AuZPysN8terazgqQZb2XGEdITMUdNJ6lpNG0ZZspqI+5BI35WzI6D1SvoEG3q9dSfqjFnm/viZgUOVcgItyrYmAcvBKGs5kM4PvfANVyK/lVxk6pR74tHvGYebea6NA0FnNaW+Q4M+NTROe3tz6BKpmhiDqKvbn2CEZ9rvvx7WNsY/PJ2kfHWlr9MlEFNwrxuaJGde685zMLiikkUmnwxYJxR4ROlAaGfjuLal1hOTfeOrIJgnCAbp1SKJ0zrMMPJTLhPgzxgunC3IPIVRrgC0okD9axd77cuyVme0edeeGjTqkYlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr5Q1l8b1w1CitZG2JP1458j7pO5eNyJI+oeSOrps/E=;
 b=x2eE4jpJg2crrHBJxN4lJOHc8GHXAvuGtI003uSqe8J/tw4ihO08qZ10Qge82DwxL2Zpv7Ls1wh17DCjudDCCF2yHbsfTNvxA0aEUvllAeD0fX5l7tNxRPLFxXLm+ENh1Ki9k6NAKuADsEogDO2Lhk8mhIG8gU2GmLRUuo7M3BD1kUx1Hz6nbzA0Xy2TVa5vkKHL6JAaATptqEckLJjX36k/Xmmv2kRx5EhPps7kdlRGsqlEDTri/5xVIcXZsTtY2yH3qia86pc66U6pKEnEEsKPhCsEgvW1dBpVWcraBxNxwZwuzQixQxuj8EbZlDno+vaaIwWJmSNqA6e5IIY9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr5Q1l8b1w1CitZG2JP1458j7pO5eNyJI+oeSOrps/E=;
 b=JwaF2/hA7lTFcWueduyUKGmaCpdsgZNbA7GYJwqSH1S5RWD4jHjw8QgKKnDYIKbde6p0J2/nP8xxOcAfIX8dSNyo73uMZjWO4PNM1CkUkk+Naok4TibOkAcuxE5VAqE7WyW+fHej2z57OUYxU70WNmQc1TPQ88LTvQ0+q5mimEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB6933.eurprd04.prod.outlook.com (2603:10a6:20b:10d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 09:14:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 09:14:12 +0000
Message-ID: <66deb003-2c4c-4a21-995d-4a1c2e1ee8cc@cherry.de>
Date: Tue, 19 Aug 2025 11:14:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: Remove default prompt from output
To: Tom Rini <trini@konsulko.com>, Daniel Schultz <d.schultz@phytec.de>
Cc: holger.brunck@hitachienergy.com, hs@nabladev.com, sjg@chromium.org,
 jh80.chung@samsung.com, u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20250815160635.3575367-1-d.schultz@phytec.de>
 <20250815161237.GT124814@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250815161237.GT124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa1923d-5cc1-4876-0a5b-08dddf00c310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmJHT3R3U3I4ZG1GVXBtTm5nMXhYb2tXbWlQdDlGZnc1MUNuTXpjS3Z1K2c2?=
 =?utf-8?B?NjZsaW1ScC9BQU9OMXJvVW9lVG5sUHFZMXM0UzFWTkJEWktTZDIyemR0SEZV?=
 =?utf-8?B?UnpTdmdUVDZCMU93YkhwM1BKdncveTBhSnRwZDRsSEIwUmk3TVNUWGNMeVhv?=
 =?utf-8?B?NTF5cDRzRDFDWVhVd3IxSHdWSkdKQUtGc2R4V0xEaG1hUUl3ZDJ6OGNTNFE3?=
 =?utf-8?B?c2x5cnRTalNpV21nL21rRmJvNmpmQVJQcDlLMjBneTFTQ0liU1JjL2Nuc1Vu?=
 =?utf-8?B?M2M2TWlES0s5WjU3amM2Q1gxcmsvZUo2QzlpYnl6NytueEFkNE1GMlMvaWpI?=
 =?utf-8?B?VHpOYUpKSW1qOVk4WklrZ1g1WGpBenNwRFg2WWRwaGFWbEFTNnM3U2VPc1hZ?=
 =?utf-8?B?TmU1L2hOKzlLemFhQXpIWG9ONHpvMzlVOG5nSDB4TDhMMzJwMVJWK082SGZv?=
 =?utf-8?B?S2MvK0tNZ004QVVEekhVdW8xMTUrYUVsd1FMTXMxakhHd3FCTzRGbjFnS2xk?=
 =?utf-8?B?eENaam5VUG9NWWFwUjNQZmpNUkxUY1FDUnNqQzZuY0ZTL3lzSVhKaSsrL0pM?=
 =?utf-8?B?eDJhS1pkQ2NwS1AwL1R6TzByalJuODRKTXM1cWtzVUlVYmpmQUxMMmNhWm1S?=
 =?utf-8?B?c3hxbnpTYUVlYTV2cksyYXBWZ3hMVDkrSFQ4VS8xM1NTZjZhWXBUOGJCbmVJ?=
 =?utf-8?B?QzBWd2p4TjVCeTRlQk9acTMwcnhkcVN6QVRRN0JDRzZLQ3Qvbk9UeW9JQWht?=
 =?utf-8?B?QTVyVEsvN2FWSitNK28rR2Vtd3hSMWxtL3pRZEJDS0xpUFJDZW5kdWdYNEEx?=
 =?utf-8?B?S2sxOWhIT1gwcm92eFczMUV6NmszWjJ6VlVXL0dOWW4xcGVwRDQ2MHdrdUNP?=
 =?utf-8?B?ZWFlK3QwK0VKVmR0cDNEY0JBSCtMWVpQcm55b1ZVbVR5UFkzWWU2YXltaGpY?=
 =?utf-8?B?VXlkV2I3TWpZTkdjOEZRdExGZndZOXlTZ1MzTERVRXBvUDVTOTB6djR6cjVz?=
 =?utf-8?B?WXRCT1d2RE1wbWJYelZEaU9SUmtvckRpOU4wU1FCeEU0Mk40UUJ6RGp1WXlG?=
 =?utf-8?B?ZkJrNDF4c1JydUJyeExiVXBveEhMaGJmbjdVZDF4aGNCL09xR0tBMVptVGd3?=
 =?utf-8?B?Nm81MC80c015RUF6RTBTc2RaZzhPU09rNzRCT1dveDZYZnJzN0hCSTlobURz?=
 =?utf-8?B?N01pMloyemZ5N2V6QWIwVDhXQmZOSDZGTXB0R3gxMXBUM1Axa1RkbkxlZWhR?=
 =?utf-8?B?NGUvcjVtU1lWWFFHUlhTSWFoeDRLUXN0cXlxc3k5NzFrU3BGcXdzSUcxMWVp?=
 =?utf-8?B?WXQwVGdqK09GTnVRMXU2VjJXUzVOZ2srRmcwMnc3WVZ3Q0JZQTBaSEhRNWdP?=
 =?utf-8?B?b1FJbXVDL3BWaHR1NTJqMVo1ZlpEUGJmN2hCemxETzVvcjJ6ZFp4UUF4TkdF?=
 =?utf-8?B?SFlEZVRXa3FOSFJRc2xUMUJ2SjY4cm1adHdlcjExcXB5aU5rQmlYRUVkK2Nv?=
 =?utf-8?B?cUx2SGVNazd4VEZXbC83NmhYSWxnSnRLMTFEaVhjSzd0bjFPdWJVbUFNUTBi?=
 =?utf-8?B?czJidmhnTTBsczBXT05xVkx0NnFqTVZlUVBYWHJDVHJTMy81Q2JHWHp4NjAv?=
 =?utf-8?B?b05OeTRoeGwraFlPYldxMTRXa0poSytMVTZjWklhWHhwaitHcHJGQWJwVzdC?=
 =?utf-8?B?UDJ0S1dlVHltaTVDemR5WCtTbmNscEdQbjZjTkY0elAwWTBaL2dkeFZzNnA3?=
 =?utf-8?B?RW4ycENCcldEMmQrdDdIZFltcnhaOCtva0NqTHp1KzF2MjlRUjlPQUxEb3F5?=
 =?utf-8?Q?NPDvjUDV5mIppUyjOXdPJIrKnOBL/Ui5Clclc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZQbndaM09vQi8rUElNV0ZoNHpXbjg5K211SzdMcE14QzBwOHpJWFl1QXIz?=
 =?utf-8?B?ZEtNY3VFNThRWXc5bkhlUEhmWUgrNlFhVWhqQ2M2U0NyS3ViVGltZ2Q4ZmZ1?=
 =?utf-8?B?OXhzQWhiY3R5cWxQdWtDWG9hS1VXZzJ5MlAxdlVZcldqR1o5enFJUWFBSVlK?=
 =?utf-8?B?ZThzelR4L3VKWFBpbm9VRE1Rek1jb01wbEtKSVZ6T2RvUG1RVWFDMzkzbW5O?=
 =?utf-8?B?VVQ2SUFCaG04U0p3VlV3bCs3VnNKNUhRcXB2amk3SmhSaUF1b000clVWTmJE?=
 =?utf-8?B?WkpiRm1YSlM0Q3BoR04vQmduY2ViWlVRQjJPV3gwWWRPT1MwWW5QMUJNSnlQ?=
 =?utf-8?B?NEhMWjR1Y2FmbUpZTlBhcTg1cm1qbkhLV2lyME8yTkZqOWhvYmZvN01SbUV2?=
 =?utf-8?B?Ukp0VVRQTVhDQnQ5TXZRL0tkOFpnWDBkNGFPckVyUHBMUWhPNS82TjNTRGxx?=
 =?utf-8?B?aW5KZnROY0xxbnh6Nm9yVDhMeXFZZDV6SkNaR3FIVnhuWG4yRzVUTmtWVTdC?=
 =?utf-8?B?Rm1DZXR6UkxFcHRiMThyWFNJdXUvK2g0NkxEWmJaM2o0M3hCZDFkNXpNUlh4?=
 =?utf-8?B?eWJTTXIvYzNtK293Tk5tM2xtMU1adytUMU5SNXplRmtRRVJra3ZvQXRNbUJh?=
 =?utf-8?B?NmxCVGdYSDMwTGxyTXdvdUVDZVlNamxRYTUrVEFaMUs2VmFlM3VaWVVaeU80?=
 =?utf-8?B?ekkrM3BhWFlQMGVIamliemwzelhpbVM3ZnlyVVNTdFNGOUxBakRjSG9RcXFp?=
 =?utf-8?B?aTFyTzhyQXpjNExuUDdzQzVHQi9SM0wxdk9OMFdSU3hBZU9ha1FESjJsVURJ?=
 =?utf-8?B?TW1tT3dpakNEN0V1TjVOSmJGUTdZUzNQRFNGUTM0MFJpOW5OT25QcnRsVk8x?=
 =?utf-8?B?TEwvTk0wd3BYRG9hcngrSzNJVDZXc1h4WE9LUXR4YnYxemMxSnJsR1EvT3Ew?=
 =?utf-8?B?NHE2WkJhMHBxZmJZa25KU0N4WVMzL29TM2REUVhXNGFGV2VQdTBIOUo4Z2lm?=
 =?utf-8?B?RnpwRHdxSlhaRVgyS042WGJYTVJmZVBEQVZyMHI4eXQzYkpBSkpVdzA3ZXFh?=
 =?utf-8?B?b1FyMUFiV1gyZk5WSHFDRFgzNzN2MWI1ZlAvZmZ4eXZZbXRQVGxkZWgyVjBq?=
 =?utf-8?B?U1hQTWExaEJnRmZqczd4V1Y1Nm9NRmowRVpWbWloUTEwRGt6Z2pnWm5CamJo?=
 =?utf-8?B?dStTMjFtTGJCS0ZNSzUxdm1LNUJpZEVVUVBaVzZDb0ZJdjVXOE04UTQ5Vks2?=
 =?utf-8?B?ZTlFZ2RRNkpXR3o4K3hER3N5UTZtQ2ZtSWsxbVVxTjRjSFliazlDMENDSjR5?=
 =?utf-8?B?N0VCWUdZOWs3NW9GditLbGhJZnc0cVo4c08xOGdaa2thanBzTmc4ajIvcVND?=
 =?utf-8?B?TFdaVHByNWt3OEl3b2ZiNXViYzBPUVZ3ekZDZDdzeUMwSVdiVCswUVVIYnQ5?=
 =?utf-8?B?S1Vld3d5cjluZW5kUG9WUGRTS25qRGtvOXE0TVFwN1FsdE5WeFBScGZHNTgw?=
 =?utf-8?B?MURUOWRQS2pmL0l2ZDM3TlBNUmRQbzI2K1puL1NqbGJLcEg1azZNNEVKaWEv?=
 =?utf-8?B?TjNaaS93aDdIYzN4UVRrZ1F1SUJGd1V3Q05wOTVJYW8vSDdTdVFaSmRYa3NE?=
 =?utf-8?B?QkIrckJGczVKRlFxelh5RFg3REo2Tm84WUZlMlFIRTlBdE4wWk5sWFEyKzF4?=
 =?utf-8?B?ZCtOOFFvZWRDZUpnWGt2U3dHMGRDK1Qzb3hSSXJxMUVPWUoxcUNGL1pSWFd3?=
 =?utf-8?B?eWVEQ3Zhb2htMWxUNVg2WllLblRZa3l3UE5nUFFuYWRxQy9aQ3JqRjFVc0t1?=
 =?utf-8?B?ZU1DTjVYdmllUFFVT1YydWh4d3IzQWdJNWVobTdLMWh5L2Nyc1pxY0Z3bzdW?=
 =?utf-8?B?VFJEMlR1RFQrQ05GZGJReWRLVENCbytRRVdkNVdSa1Z2YmtYa1FuVENZeEFu?=
 =?utf-8?B?ajY5RWxQVkZLTG52Ym1ialhXV0crMWVyRldmdlFlUzlkUDZNYjhPTTE1OG1s?=
 =?utf-8?B?OTVBYTRHRDlDWkN3Z2ZBaFRQMU01OFhkNXZDajRRK0pwRnd6YjZzcFRRYVAy?=
 =?utf-8?B?RzhMbldmWVBoYlhyeTNGVEtVVEQyNU0yL0NkakI2MFdHTEtlTnlGTnZocUZn?=
 =?utf-8?B?QnZUWktOQytja1NMazVtQUZSd3VLS0l1d0pyUUc5clZzeUtUQnRWQW9tdm9T?=
 =?utf-8?B?YW1lU2Z5a0FJbFFCa29CQ2xJSXRUbEt6ckdiemhwSnB2UWNMYzdUZXA5ZlNk?=
 =?utf-8?B?UTllUjRQRTJHZ2lYaVRGWE1nRTJ3PT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa1923d-5cc1-4876-0a5b-08dddf00c310
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:14:12.3606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDNckgss7JOJ/gENCwZbhrL6M+LJM8lonLHbprvYA1hczALBRsq0zQBVAni+ChGplSvZ9SGu1aJZWvqkkmtptrwYyxzE5lPj/46o5TuXd/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6933
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

Hi Daniel, Tom,

On 8/15/25 6:12 PM, Tom Rini wrote:
> On Fri, Aug 15, 2025 at 09:06:35AM -0700, Daniel Schultz wrote:
> 
>> Some commands include the U-Boot prompt (=>) in their output,
>> which can interfere with tools like labgrid that rely on prompt
>> detection to determine when a command has completed. This may cause
>> such tools to misinterpret partial output.
>>
>> To avoid this issue, it's better to update the command output itself
>> rather than modifying the actual U-Boot prompt. Changing the prompt
>> is not acceptable in many cases, as some boards have used the default
>> prompt (=>) for years, and altering it - especially just for testing -
>> could lead to inconsistencies or unintended side effects.
>> Instead, replace instances of the prompt that appear within command
>> output (not the real prompt) with an alternative like -> to ensure
>> correct parsing by tools that rely on prompt recognition.
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>   cmd/i2c.c      |  2 +-
>>   cmd/mtdparts.c | 12 ++++++------
>>   common/hash.c  |  6 +++---
>>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> This is two cases, and I'm not sure I like the proposal here, sorry. For
> cmd/mtdparts.c, it's debug statements. We can change them, but are they
> also enabled by default in anything? The other cases, we're changing
> output along the lines of:
> 
>> -	printf ("CRC32 for %08lx ... %08lx ==> ", addr, addr + count - 1);
>> +	printf("CRC32 for %08lx ... %08lx --> ", addr, addr + count - 1);
> 
> In each case, and I'm surprised there's not testing that globs on that
> today. I see the wget case that uses "==>" and we do have a test that
> checks it, today. Is your testing framework not able to handle "=>" in
> the middle of a line? Thanks.
> 

In the case of labgrid, I assume this should be possible.

c.f. https://labgrid.readthedocs.io/en/latest/configuration.html#ubootdriver

Arguments:

         prompt (regex, default=””): U-Boot prompt to match

I assume you just want to be using

UBootDriver:
   prompt: '^=> '

instead of simply using '=> ' ?

While SYS_PROMPT defaults to => for anything but the Zynq architecture, 
it can be set from defconfigs as well and look what we have here:

configs/brcp150_defconfig
63:CONFIG_SYS_PROMPT="-> "

configs/brcp170_defconfig
62:CONFIG_SYS_PROMPT="-> "

configs/brcp1_1r_defconfig
62:CONFIG_SYS_PROMPT="-> "

configs/brcp1_1r_switch_defconfig
62:CONFIG_SYS_PROMPT="-> "

configs/brcp1_2r_defconfig
62:CONFIG_SYS_PROMPT="-> "

configs/brsmarc2_defconfig
62:CONFIG_SYS_PROMPT="-> "

So now we would be breaking those users instead. I'm not sure it's a 
good idea for U-Boot to do this, we'll never find a way to have the 
prompt never repeated in log messages for all supported platforms. You 
can always fix those in your own fork if you want though. But I fear 
this will be the beginning of an endless loop of revert commits because 
it broke one's CI.

Cheers,
Quentin
