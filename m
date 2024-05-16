Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8DEC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 10:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF86D8803A;
	Thu, 16 May 2024 12:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RjVnAa4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B551F88258; Thu, 16 May 2024 12:43:24 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4805187F65
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 12:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2ANu4HT9vYtShqmV4ZyUeYrAtXK1YqUjeOZPPomfzuky2DOBvusYs4LG/CT/QrC1e4w2XKVOEqWwpsuvTHLOSBpB982Zl/LZ5qyBOe3nMLt8Z+oNFPHxSLw7WgjV2z0GdcYc2lhTL77HmCIXOyh5JQ3QxVhqJYBcBiEwg/aETZXlfUszcheW7zbJH8qQ6QrHJWtbsvTx1nfpLHTXL0254JvugpsFD/5aogDluRAqK+muI5We3h2YH91DtUI67re1EzSQPyGygJplX+r8pAFj3KUS0oQjwHwIJx3yTqgTWsNZx3U8E9h9YlR2Ptsc+mwO9gnZa5hqljbE3Q64uGpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYWhrbcongXiUDUQX0hLClzYwRKDBhpBpqrfte8va0c=;
 b=jW7kvakoZBfrezaCr/s3XxDKa3dT8UYCxzmN6sbMOgxXhQ4Tko0kWHYoLF50wxOz/x2dhd3dQqDTVpjM//nh0LwUp0XjhoGuBjfJwBUCNRnMJ49I7Ucp++rnWHuFHwz9kNmeuEHWA84nVDS9vrJ1Av3+wJbGnBBVBcgopGm5vyP6aOskSoZfPH5ZowD0lxqekp92UrLv1x4XV20GBlAWnfMTVssDLj5JAwVI55rW5e4zkN5NLzwTeNS0iG4GISug+123ztlHxt/OLxtbJyRydfufT/qv27yvU50Ddv2X6CoDBchiKtkcv3XJHOkDnlQjPXdix5chAjb2ypPkQaePfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYWhrbcongXiUDUQX0hLClzYwRKDBhpBpqrfte8va0c=;
 b=RjVnAa4RqOFgQwjnkXO10I2I3vEKFgksYoQIzIJ/M3n/7wsGXK7lfYPirQDAkVk8ull2DRB9ZzkkiZW0DwKaJY5o95eMcPY/ACVCoi1ctCsI5GEPffQbwUsc1xdT/sDtfX37Un3+eDcnMxSsgG5gbt9eP2Wz3FKdlAiKtAFFNc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by PAXPR04MB8127.eurprd04.prod.outlook.com (2603:10a6:102:1c5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 10:43:19 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 10:43:19 +0000
Message-ID: <1529741c-f09f-42c4-9bd2-e59b1c2828c2@cherry.de>
Date: Thu, 16 May 2024 12:43:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] rockchip: RK3588: Enable display cpuinfo support
 on all boards
To: Anand Moon <linux.amoon@gmail.com>
Cc: Anand Moon <anand@edgeble.ai>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, John Clark <inindev@gmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>,
 u-boot@lists.denx.de
References: <20240516090031.2373-1-anand@edgeble.ai>
 <20240516090031.2373-10-anand@edgeble.ai>
 <1c5c0be5-eb49-4af9-be29-e4ab95e9f8be@cherry.de>
 <CANAwSgS3Fd91FqQkfKHxVBYJ8-2LSdY4z4Tmx31UY7Bhd9K37g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANAwSgS3Fd91FqQkfKHxVBYJ8-2LSdY4z4Tmx31UY7Bhd9K37g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA2P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::12) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|PAXPR04MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 504ec010-f988-46f7-1bbb-08dc7594ffde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVJNMTJXVjRsc284V0wyM2huSW1rUk0rWHYrT2tRNnBqR0g1WTN1SUxJUnFS?=
 =?utf-8?B?c3dFb2NvU0NTSzVkenhQNFlsSUFuWWlRSzI3MWVsSXJDcTRmcXNXVnNNRi81?=
 =?utf-8?B?OGdnc3cxVlFiQ3QvNVdXVkQ5WUdRMXVmUGpEODNIVm1CM3YzTDRkem1ldXJO?=
 =?utf-8?B?WHIzMEF4cCtwejFkU2NpZzlnL0dvNmh5VTA5MExwbk9WQzkzRVorM3c1U3ZX?=
 =?utf-8?B?RlBQUFZVVjUvWXY5MmZKVWRlRlNRSitySzJzV0trSW1yUjNZdzVFL1RGQjhn?=
 =?utf-8?B?c2FuenBJRFpILy95K05FellxUGJHQlFnNDJSNEM1K0RoMGlsWmVFYXRhSHBl?=
 =?utf-8?B?a0YrWFJNWDVCbUJVd2JzL1Fsd3ErdlVYVDhoVW5ack9ZcTl0bmtyMnQ4M2E3?=
 =?utf-8?B?M3RlV2o3dGlpbHM4WENBRVI5NjRJM0FrMUZYZ24wRnpKbU1vTndTdFBmOVA1?=
 =?utf-8?B?UEk0VGJISlpxemphdDF3cjdQODkrWTdFRDFJWFVadGwrM3g1SG80NHlaZTNY?=
 =?utf-8?B?dUJUUVRvcmlvSThGY3doNGpudTljQWU5RERMMjMyeCtiMGt2MEI5bTFkMzFk?=
 =?utf-8?B?cmxranp5M0l0ZVo1RkF3Zit5aEtyQUNsckdSOVZIZmFtRDdPQVl6b2pTOE9L?=
 =?utf-8?B?aHJBaUxhTTNSSzIyTStGT0ltdVFHbWtLa3Q5Ui9LamdOUWJCcWR1b09oRjRV?=
 =?utf-8?B?ak1td3drMmk3VCs4SVpIVS8vNUpnWVJMV0dEQjFEVWZYUEtPZXY0aTArdFpi?=
 =?utf-8?B?d0dEYWdCWUY4VDFyQ0JTa2RQNnFPZ2FDU1VzdkUySXhReFhmdHk4UnpyeENS?=
 =?utf-8?B?Z2dTUFJ5aGVweThETFhWRTNLbERWUW5nSzgrRTE0Z2Yya0dmZUQxaEVCdXcv?=
 =?utf-8?B?TmJtMDBJSjF2MjFaNG9rU082WXpxTllkM1dPNUx6djRTaVIyd2hQczdYMWFJ?=
 =?utf-8?B?TjMwRkZ0MlUxOEZqaE4zRG1oY0prRmhKaUU3MXJSUlQ1aXJjVnBOWTZxdnpH?=
 =?utf-8?B?WTJJM0VYSWMvQjJyWVBCMGpEMWhleGlLRld4REdzaDQ3WHd1SDh4eEVBV1lm?=
 =?utf-8?B?c3Y5MU5YWjNsYXgrWHRXZTA4U1RMVEQ5M0IzdHpiSFpRVjdKK2ZKL3JhNTBW?=
 =?utf-8?B?SnpjVUlnODJza1dCM2pnWmRlMEV5M0tramdoWXpISGowMGp2T1hVWHU5dUM3?=
 =?utf-8?B?MGp1eW1wZjMzK1NuQXhYM3BhRGVMeVVMa1k4S2V3OUEzSFVmUHZmVTBUNldC?=
 =?utf-8?B?b1NGTnYvcWxEQmJtNmd5d09CRC9sSXM1a0dCL210elFsK3NFTnh5QTJxYU1h?=
 =?utf-8?B?eW01a0s3dkw5V2xrUm1DTVpsYXhNZkdoVlY3aDJZUHlFSGk0cGREMlgzU3da?=
 =?utf-8?B?dVBXZjVWV2ZJYUJjUC9mNVVIK3BsSFJpbzB0YUJ1UHlJTURsQ2tKdkRsOWFs?=
 =?utf-8?B?bXdydFN4WnV2NUk3eVdFcGRGQnkvRmRlNEhnVG9TS0ZzTU1JMlhBM0VLZCt6?=
 =?utf-8?B?YTZFU2xsWWxOSDFySzdqVndSUzgwQlNHOFRxWVRNV1lUaFljaDE0OVVaRmpo?=
 =?utf-8?B?RzhtYlV5eElVU1NBbmlDNHpHTzZHczB0QjlKQmYrU1B0YTJDY0Z2Y21DVmxX?=
 =?utf-8?B?QUhKOWNRbkl2NWtacFZVZXZBYUdtRlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmlSN0FlTUZzNnAwY1VzZG5FWUdtemlzNlJjVUptbXo2dFQ1MTJnTEpPaGNU?=
 =?utf-8?B?UFk4eHg4cjVKdGdvMEEyWHpOcWtsYnBpNmg1Q1g0UWxua3lobWNSa01adHpO?=
 =?utf-8?B?NDlVMlNTRnZJVlRkakJpQXVvY3N5N2JJanBHVEtVVURERzlyU0Q4QmRxOHlr?=
 =?utf-8?B?bE0rd2tEZDhSTStpUU1NZ3N1Mk05SUZ3ZWxFTUMxRG82UzVPSXpkVWx4cXV0?=
 =?utf-8?B?cjk2VzM0T0pvWjNZeWVaK0hVYXlEOVFEdzMwTnBmRkI3ZUlHWlpWcVppWEEr?=
 =?utf-8?B?V0dybjQ1TXZRdHNycHBhVG1ORVBFMGxZN29yako5S1RrcmkxU0U0RVlpa1NG?=
 =?utf-8?B?TFBReG1qd0h0S3VpWDdQdHczdGxGVzB0bTRNa0dyRG04V080dTdZTS93U3ZV?=
 =?utf-8?B?VS9QeTJveFJFV0UwZm5LMHJXZDY0bFNDVlpQdnR0VHhDUitBYm83NTB3Wi9B?=
 =?utf-8?B?LzA3QUVCRTYwUE1QSzllU3I0bm4yUUthWTY3bU5zbnRjdUh1aEUwN1htSkF6?=
 =?utf-8?B?eUp6OXZ0M1lmSnFldXNCT0ZTampobWRsUW5PK2ZNNVJFMWhyWE1jTWNrRklM?=
 =?utf-8?B?MWRqQ1djRTA2d2dqUHVGSm5sTEh5THdJWlA1L3FuRk9EbG5DTlNvWFMwK3l3?=
 =?utf-8?B?NXdhajdJamowdlBoQms0ZEoyRVNHUDc3SHpTWjRMSHMxRWFFMkNhQXFLemdP?=
 =?utf-8?B?QngvVUZVeklBYUNaNnNRdFVIQXpqRHNEL3cxQm9ncnBGTlFMb1pma2xYaFA2?=
 =?utf-8?B?ZE9IUlZxd3IydDNvMlF0S3NEUGZiclJocGZlNHQ3RytFUU5KS3RsWVd1Q1hK?=
 =?utf-8?B?LzFUZlNua0FxYlBsTGZrdVRNSWw0ZnVNeE0zVzlCaGM5OHh5bEdzQUM1MFdX?=
 =?utf-8?B?WE1sdzhtRVhFRi9UMm45SjN3NFNkc0dqWFZXZ08vUEdIbnkyMTdFWnJpK3o4?=
 =?utf-8?B?SnJhaEFrOVlhM1JMNGZ2QjBuSkxIRXQ5VWxwRGYxMmh3c3lhWFd1Z1hTclRw?=
 =?utf-8?B?Q0NIL1ora1FQZWZiTlVJL2NRcE5NcU5HVVQ1em9jam5JaEQ1ZHh3ZDBsYVVW?=
 =?utf-8?B?Rm1INEhYanRwMmxpU0ZyQXltNzc1bm93aE1vSjU4Y0dzMkQxamY3dmUvS3U2?=
 =?utf-8?B?WlA1MCt5bm92MHJ2UlNZSC9paVVJYktBWktyZEpwT2ZoUGNsWmNPUVBvemh4?=
 =?utf-8?B?OS9YN2VrT0hDNHIvZVV1bXkvVVNTSHR2OUI4OEs1QzVRaTZxb1Y0RUxVTlBh?=
 =?utf-8?B?TDhEdkxjbkY3S1RjeWplWFZjVVJ1Q3ZNcHArMENPdlFpQkF6RnJ5cnROWDlM?=
 =?utf-8?B?bDd0MERwaGw3SWV5SGlPOFBGdE1OZkJVcEx4WEFqNndjQjVDaFdPRzRlQkNi?=
 =?utf-8?B?R3ZQUFQxalVad0svdlVNQU1WSWgyYTVzcWl4VXRkTDZFeUNMb2JsWEpteGZJ?=
 =?utf-8?B?eEI3RVQ1WEtZSkVNV0xkWG9keGdzWk5EK0NtKzdqRy9NQzB2RHFocU5LZU52?=
 =?utf-8?B?K1FwNjlPZld3K25FaThDNVZkbUxYUDVmajYyRFFka21naUVXNGk3SGdRM3RZ?=
 =?utf-8?B?ZEQvSkRiaksybjNTY1hZUzZnMzFia0g4NVpZSnhRUk4zRyswU1ZGUzZmVTdZ?=
 =?utf-8?B?U3pFQ281STBGN0xUMllFeGxnWjJPbGszZXgwKzRVWWJlamEvamFUcmhjNFNQ?=
 =?utf-8?B?VExSQWtTS1k0QWdxSDg2MjNsZk9lcThJOTdPZFhISjdNVUFMZDZYSlYxbjlV?=
 =?utf-8?B?OE5KYU41WCtUMlllSEREaGRIQis3TDBmRlFNNHBvS3dIWnM4MlFlOHROTXF4?=
 =?utf-8?B?WGE5RjlTc0hKYWphNVkzTjVaYVRtNWlSRTdvZDB4QVFKWmpNdW0zSjR1dTRZ?=
 =?utf-8?B?WExzS2xuelBEblJZQytDWnhDUk54TUM0TDJUSUFBdm9Ub2dBc1ZNSzZJY3hT?=
 =?utf-8?B?cG1kL3BvSDlqb2toNmhqZnRUWHppa1JCSzNvS3FpM05sM3pSZWJFZ1laYm00?=
 =?utf-8?B?Z1gxR09sRWlQUDFhV1dwMFZZVzFBMjJ2L2F6QjRLVERhQ1hnQW9RQlh2NDRz?=
 =?utf-8?B?U3dZZmphS0ltZXA1a1lOcGJpTVNkTlRBR1NkNE5PWlZHWEQzTFo2dDF5L0JG?=
 =?utf-8?B?cGszL0NSL3ZYSnBnUDdiNHQ0OEg2SmwwLzlsNjBnUlJzZ2d1V25DbjBjVlJ4?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 504ec010-f988-46f7-1bbb-08dc7594ffde
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 10:43:19.0643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58pRPXcoHUkfhtzhYe93yCWlufcz6MWlDlDpW52xd/M4JJ29XXEodAEn/dun1Gqj3tZVtkFFNuREpqLYJgvNSgPTe5NdjLEi7UhYrqL5X4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8127
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

Hi Anand,

On 5/16/24 12:12 PM, Anand Moon wrote:
> Hi Quentin
> 
> On Thu, 16 May 2024 at 14:52, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Anand,
>>
>> This is patch 9/9 but somehow I didn't receive any other patch, nor did
>> the mailing list? c.f.
>> https://lists.denx.de/pipermail/u-boot/2024-May/thread.html and
>> https://lore.kernel.org/u-boot/. Are you registered on the ML?
>>
> 
> Thanks for your  review comments.
> 
> Something went wrong with git sendmail,
> Your message have not reached my email client (gmail)
> 

A mail server rejected the mail to edgeble.ai domain (both you and 
Jagan) /me shrugs.

>> On 5/16/24 10:59 AM, Anand Moon wrote:
>>> Imply DISPLAY_CPUINFO Kconfig options to support on all RK3588s and
>>> RK3588 boards, Its used to determine the reset cause of the board.
>>>
>>> Cc: Jagan Teki <jagan@edgeble.ai>
>>> Signed-off-by: Anand Moon <anand@edgeble.ai>
>>> ---
>>>    arch/arm/mach-rockchip/Kconfig           | 1 +
>>>    configs/coolpi-4b-rk3588s_defconfig      | 1 -
>>>    configs/coolpi-cm5-evb-rk3588_defconfig  | 1 -
>>>    configs/evb-rk3588_defconfig             | 1 -
>>>    configs/generic-rk3588_defconfig         | 1 -
>>>    configs/jaguar-rk3588_defconfig          | 1 -
>>>    configs/nanopc-t6-rk3588_defconfig       | 1 -
>>>    configs/neu6a-io-rk3588_defconfig        | 1 -
>>>    configs/neu6b-io-rk3588_defconfig        | 1 -
>>>    configs/orangepi-5-plus-rk3588_defconfig | 1 -
>>>    configs/orangepi-5-rk3588s_defconfig     | 1 -
>>>    configs/quartzpro64-rk3588_defconfig     | 1 -
>>>    configs/rock5a-rk3588s_defconfig         | 1 -
>>>    configs/rock5b-rk3588_defconfig          | 1 -
>>>    configs/toybrick-rk3588_defconfig        | 1 -
>>>    configs/turing-rk1-rk3588_defconfig      | 1 -
>>>    16 files changed, 1 insertion(+), 15 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>>> index 2e9c71138e..1b5cc34f99 100644
>>> --- a/arch/arm/mach-rockchip/Kconfig
>>> +++ b/arch/arm/mach-rockchip/Kconfig
>>> @@ -366,6 +366,7 @@ config ROCKCHIP_RK3588
>>>        imply SCMI_FIRMWARE
>>>        imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
>>>        imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
>>> +     imply DISPLAY_CPUINFO
>>
>> This is unnecessary, it's already defaulting to y if building for ARM
>> boards: https://elixir.bootlin.com/u-boot/latest/source/common/Kconfig#L596
>>
> See below...
>> I also don't think this is SO useful that we need to enable it on all
>> rk3588 boards? But also, doesn't hurt, so... whatever I guess :) ?
>>
>> While looking at the code, I think we can remove the ifdef in
>> https://elixir.bootlin.com/u-boot/latest/source/arch/arm/mach-rockchip/cpu-info.c#L47
>> because this file is anyway only compiled when CONFIG_DISPLAY_CPUINFO is
>> set, c.f.
> 
> Oops I missed this changes, my bad
> I will dop my changes over here.
> 
>> https://elixir.bootlin.com/u-boot/latest/source/arch/arm/mach-rockchip/Makefile#L30
>>
> On Rockchip SoC CONFIG_DISPLAY_CPUINFO is been disable on most of the
> configs files.
> 
> -# CONFIG_DISPLAY_CPUINFO is not set
> 
> My changes are related to determine the reset cause of the board and
> display the results.
> its only enable on selected SoC hence I have to used this logic.
> 

It's enabled for all Aarch64/Aarch32 SoCs by default. People explicitly 
disabled them in their own defconfig, either because the first person 
who added a board based on rk3588 didn't know or didn't care and 
everybody just copied it as a base, or because they don't care about 
it/don't want it.

In any case, you only need to change the defconfigs, nothing else.

> U-Boot 2024.07-rc2-00397-g0370324feb-dirty (May 16 2024 - 13:11:14 +0530)
> 
> SoC: Rockchip rk3568
> Reset cause: POR         <-----------
> Model: Radxa ROCK3 Model A
> DRAM:  8 GiB (effective 7.7 GiB)
> PMIC:  RK8090 (on=0x40, off=0x00)
> Core:  344 devices, 31 uclasses,
>  >> which also means...
>>
>> https://elixir.bootlin.com/u-boot/latest/source/arch/arm/include/asm/arch-rockchip/cru.h#L35
>> should probably be ifdef'ed
>>
>> which means...
>>
>> https://elixir.bootlin.com/u-boot/latest/source/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c#L64
>> should probably also be ifdef'ed (but the config is enabled already
>> (well... it wouldn't compile otherwsie), so I guess this is fine?).
> 
> This code changes will not affect this feature by default its enable
> on RK3399 boards.
> 

Yes, but if you disable it, it won't compile anymore. (I'm not asking 
you to fix anything I've reported here though).

Cheers,
Quentin
