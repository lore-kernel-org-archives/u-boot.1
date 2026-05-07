Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F353ACD343B
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 14:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614E084A93;
	Thu,  7 May 2026 16:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gkdG8MuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C8D584A9E; Thu,  7 May 2026 16:17:37 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8975684A7D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 16:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv7oIQdYvqAJKp1+YYzq9FUHAj9gbokSDQr+D+fPkgjMXZsA17XqESNhpb7PFQElSYszS8uZOJjSBn0lRz37UCN7WNOL/m3cBV07ccHFbrYxIJa7WLoQ5NDQtDVWFP1W5bC+2K22jqSPG1iroKlZRR/xdeF6dUADT51sU8QlWCtDSURYuM9dWWsiqgROh4wMPUvDAoucgN3Uzjg08FfrmCeJEKcHRCppxtyFh9lyzHv7zhWag20oTZy9ODD3sLspo8Jz37CzKPzpuG4VtbRkv+Rpt0aNnyJ2h/sUosft80JBwmel5uxTcQJLqvKSvi9lN0HmG3HeVF19M+nYgUqmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea1ofdWTBasjb1/hg5m2IZ8BtDjlPHqfZjh1Ajr+wtA=;
 b=mMFa3jSVjncLbbLcQtHetvVB52zczUv7Lex299S4kOmCLth24PpsdkcMdBZnLh/KjDiaYLA1slpvy8z1lrudnkWlBcBuwN9SaiBjerxkcsfmFQ1bQHBQMtdeOGV256pIX0fYuoPZyvuFAsWcC5ISF61cjqsjMlK2CzuV1k+ElBfm4q4ZfzcbXDfOroaeRbOQEVah4XiHFUou8Ux/BGP58LFJPshXnyVLajB3dpTq25fUDjK2NEmKZjjHP2L1f5T1mD6uibldIePH9WNodDj1b01pH5dVGscVVt3PPfcGTdheKINq0e3i/npjaiwbfndnlmuK1iGAZjsEghfaX9nw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea1ofdWTBasjb1/hg5m2IZ8BtDjlPHqfZjh1Ajr+wtA=;
 b=gkdG8MuUmiFvyg5T1/jG22qrZDqhBoOQ+arXVHowAuwiVR2oxfcw1RgE8fpXrHi2NFK6qj3oCpfdWdp2wf0ihZjlY0ShZUPYShNG5SKsmR7fEE2CiXCDxq9wrYs9LDjHP4NWjQTR+ofBw1y9ct/+4xr2PywTzqy6nkToHx31RcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8082.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 14:17:33 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 14:17:33 +0000
Message-ID: <bef4841c-a4c7-4e6b-96cf-d8fae4abf986@cherry.de>
Date: Thu, 7 May 2026 16:17:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: usage: cmd: reset: specify when the -edl option is
 available
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260428-doc-sysreset-qcom-v1-1-964df4ee79f9@cherry.de>
 <ba82cf35-1ee2-4407-8d25-9569577c7a47@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ba82cf35-1ee2-4407-8d25-9569577c7a47@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2aacdd-1794-4794-1591-08deac436155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info: l9Vu6v34w6k6dK0FTWZAFdMDWQhP5Tkn5FObDXMuHkxphVR1xorebZYyBkZnB1ROZ3SR7qiPnTGWGlIUSQba1Vv1lmOOUhO7gxy9DImThIHiwz+jLEQ4t3nglkcH73dhC+FgnLHKUoPZIA+UzRHxZUrtjHj5WeLz+DAfV0G90kU7J2Ua8wwKjN76LwSz8Datndu9/keOy9+KSYdy+aZ/xJhcG5euCDlZ987OxxHarOEH2abscs+/zChGasz4Xe3VWcPuB7gv1HNWD49QwwrsNiUOU6KdOg+ACDvPvDpXDdSOR9gnuPKrz1LR8buf3w9FEg8p7BIR4g36KsHkUw5ECV9R8bz78RquNkXvufQZXYOLehcJQETgR2HdMevlWlQagvWo8LhRLqKm/qXmKGjbLPaa/d+Rc+IbfmOA1Sr6kC7jit8b7OFbpN15w6B4Hecng8aGzU2y3oqN7feTuv0jKNF3GyCRi8+tmYrJVscm3pW4fBaiwwGprCOYQWgTwdi7KZZ8dLXkJFWZkBKeqcMlcVjMEVIXfPtKUHhmPxxxopz0wVDBZi4pnvdGSoF6i+dcN3kSOWyde0t7Nq7+niHe5WYDSVbbJmTaxxO1/dy2ixj0ohnwDzhmLTwtpwv9uja1CGFjHP6eMnNzUbzJBqhsL7Qj/UjlKlLPC6h3k7BRwxgFQI21a+OikFEO6mSlq9wF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T21salo1L1drL1pXRkxUdXA4Z1ZrdmdKaVNEZFo2cDN4NUF4QTFrcm4xWnU2?=
 =?utf-8?B?QzhZeWtTajdKalhlRGVxbUNCWG5aRlRlNEZUQ2xVRTdHSkQxaUZEZVkvMUdv?=
 =?utf-8?B?ZnJHS25xcDk1cUpHSk5qNWlJaHM0dmR6U041azhtQmRJU3lHMmNNNTlPaWpS?=
 =?utf-8?B?QlBkaU5LbVAxbC9VZE1LRzFHNy9VdjU5OFVrQVB0a1ZNYXd0OGNOTjdmTW9k?=
 =?utf-8?B?Z3dGMWhIdU03bjN6VUtUSXcrRlhMb2RDbG11cmF6ZFdQY2lxSDM2amp2MEZj?=
 =?utf-8?B?c1gzVCtnTmRZaUJpc3grSXVTSGdJbytDZTgyY2hjWG9LVmV3WXBMVUsxRnBv?=
 =?utf-8?B?cTAyTERVaXByejNGeWlnMFRYWit5NnNnLzRLa1k2TXpjVGR2RU1nSzhpZ0FP?=
 =?utf-8?B?enl0WHg2TWJDMnc3c3FTTURnSGpKYkdtbnNHdkhreTVXUjNrQ0N2Q1lRWWlt?=
 =?utf-8?B?bnNETk9vdXEzazhORno5KytsU3VHS0o1WlhKWUpkZGNTRElGYWQ2cGY3dXdq?=
 =?utf-8?B?ckNCSjdza3hGRHNQemdGWFN5OURqQXB5RzF5T2J0RzI1RnBwZGdPZVQ3bEJY?=
 =?utf-8?B?ajBjK3oxTHNPbFJRNkROY09CbEZJSlVkL0Q3TE9aTDNYbUJsK2JOcVNzbUdh?=
 =?utf-8?B?a0NpTlJlL0FXQWgvazdXdTRmbFBWZlE1eGp1dndIZVhaMHlZazNHYUM2Smlu?=
 =?utf-8?B?T3ZWM1RTSGFvOVIranJXd2JnMEI3UmZYRS8xVjBNczhVaExUWlJaQnZJRVkz?=
 =?utf-8?B?ZTNVZWlQSWYzRFBKU3lXNTBnVUlqOWJFYys1eUUzaS83TzBWT2JaMVJKdm5z?=
 =?utf-8?B?bDhpb0REbWVLOENwcnR2QWFaZ1ozTEtXczBNaXI4MWNkN2VUczd5Uk5Mc2xl?=
 =?utf-8?B?dGNyM1RZWXhRMzY4TTRrR0ZSazdqNmpBUVFtV3ZhbGFYT3d4b3ZNQW1sRVVX?=
 =?utf-8?B?WnN4d3ZpQ2c1RWcvaTgyRlp1QnNjMHJiSTF4N1NkTnZpOXIxWHhySHhHMmF0?=
 =?utf-8?B?Vk13ZE95TEFLSFNvOHFrK0RVeEFCVEY2dTVrTWJSTVpYTWdBVTZBaFV6RW94?=
 =?utf-8?B?cmRXYVlHOFRUNGZreUVFZGRHN3dYelE0cStiRzhON0xRUGFVYS92ODE1Y1lR?=
 =?utf-8?B?TGtNWi84Zm4xazd3R1VBRGg5M3hiOUZ6VjU2Z1hQUHBKUGk0QkxvcDRlNzVu?=
 =?utf-8?B?TXJUNXg4cFJKU01ITEZWOUUxVC9vUUVBZ1NmMklVaEhCZUNIR0M2U1lJT2VJ?=
 =?utf-8?B?MGdWaGc0Njc5M1NNTmUydm1hRFVmNkxJRG9laWtsbllGdWhmSVZId1M4OWJ6?=
 =?utf-8?B?akRUOEtFcEFmZEFKTEVoN3VzcXlwRTU1Q3JUTXNFdE5reUZFems5R055Wm1m?=
 =?utf-8?B?SFJZNEVsSjVOdmUzV0F5MXJhcjA2anZyaXpUMDNjTEw1eU1DSWN1aENkeTVC?=
 =?utf-8?B?RjljWE1XYVJwTjU3UU4yYm81TWEyQ3NGdGFTUFVzWmFlRWRsenZvRGF1cEI3?=
 =?utf-8?B?VEFobGc1M3E3a1Zyck90SGVVRGgrT29VQWhpTExXT2FqeEJjMHpTQjFjTFJm?=
 =?utf-8?B?cTFPNjhMQ29tbHZoTG54cmF5bWZZRHNJVkxoMFAwL1JzampPYkhwT3NTMGg2?=
 =?utf-8?B?WmhEcmdTUjIvSmYzSjFLdEpDNU9tK2xXN0swK0FCR0kvaHZzOEJTSTlMV2N6?=
 =?utf-8?B?NWE5T0xLY3ViWCtPdXorZDNFUWdJZ0RHMmpCSEpHYUFoaTJNK3AxdlBMTFdu?=
 =?utf-8?B?Qk5Icmt3Y0RzY1RjejZzU01URmVScGJzUVovS3RIUFJQNktkTjYwVHIvRG01?=
 =?utf-8?B?WjJxV2xmMDd2MmV5ZzFOM3I5SzFveWUwRkFiVzA2QXNoRG5GUXpTNHRXd0pD?=
 =?utf-8?B?VkR1OW9SdFdVTTRwY2hCRTd3d0lvWWEwVlFlUnZ1aE5SYVhyWm1BRm5jMWJD?=
 =?utf-8?B?dTViTGI0SEhvQmFwZmwzQlQ2T0V3blEvRWlqNXM4a2pIcC93YmdmYjVjcVJI?=
 =?utf-8?B?OGQ4cmNKUkpGZTNjeFc0Mk5PdHZweFltbXEraDh3K3cxdWZIc3pYVHUzZXg2?=
 =?utf-8?B?ZU5takZrSDhUYkwrZXNXenZkNHlvQnYwNm1NcW5MWVFoSXliS2dRZVpRcU9V?=
 =?utf-8?B?RHV5M28yRWZ1WmlsZkY4emFUZjJpZDVkbFZQb3lKWTc1ZnV0aGZjWUVKbU9s?=
 =?utf-8?B?dU5WM1ZRWHZ2emhCUEttMUErc2xPUi85RXNTVURlQ1cvVW1nQ1g5emxLdm9T?=
 =?utf-8?B?Y3JGdDRDMm13RUdMSHlyQ0ZsUWoxN2lncGRBR25wNVhLRjJ0R2NvNTZlS1dv?=
 =?utf-8?B?MlZIUkZ3bDVyV3o4WHVONjVBQXdacFZSN0hRb3BsT20zT25sV3NCUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2aacdd-1794-4794-1591-08deac436155
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:17:33.0072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F71rdDaBlFeGDT1oxlFjyH9+7YsKIeHcqXPYu46SOraGOd6bQ6dvVyenWKKLeIA8ZaEBYiVsUXKcxsXbjXSK+WiACtNAoKLH1Ju3lBgKn0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8082
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

Hi Heinrich,

On 5/1/26 11:18 AM, Heinrich Schuchardt wrote:
> On 4/28/26 12:26, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> The option is only available when CONFIG_SYSRESET_QCOM_PSCI is enabled,
>> so let's make that explicit in the boot cmd documentation.
>>
>> Fixes: ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command 
>> documentation")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   doc/usage/cmd/reset.rst | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
>> index 366b17eea16..54767fea241 100644
>> --- a/doc/usage/cmd/reset.rst
>> +++ b/doc/usage/cmd/reset.rst
>> @@ -23,7 +23,8 @@ DDR and peripherals, on some boards also resets 
>> external PMIC.
>>       Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.
>>   -edl
> 
> All available arguments need to be specified in the synopsis section.
> 
> The parameters -w and -edl are exclusive as both only work if they are 
> the first argument. So maybe:
> 
>      reset [-w|-edl]
> 

I'll follow the same syntax as in U_BOOT_CMD and have a separate line 
for -edl.

> 
>> -    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
>> +    Boot to Emergency DownLoad mode on supported Qualcomm platforms 
>> and only
>> +    when CONFIG_SYSRESET_QCOM_PSCI=y.
> 
> This information is incomplete. Without CONFIG_SYSRESET_CMD_RESET_ARGS=y 
> the -edl argument will not be parsed. A configuration section to this 
> document might be helpful.
> 

We should probably not make the -edl option available if this isn't set 
either then, no?

> Should we mention that a "PSCI SYSTEM_RESET2 not supported\n" message is 
> shown if the platform is not supported?
> 

I would be wary of documenting strings that may change. However, we can 
say that the command will fail if the device doesn't support it.

> Where will a user learn how he can use the emergency download mode? Can 
> we add a link here? Unfortunately the EDL information seems to be 
> dispersed over multiple documents in the U-Boot documentation:
> 
> doc/board/qualcomm/dragonwing.rst
> doc/board/qualcomm/iq8.rst
> doc/board/qualcomm/rdp.rst
> 
> Do we need a document doc/board/quallcomm/edl.rst?
> 

That would be a question for Varadarajan or Casey, I have never done 
anything with Qualcomm devices.

Cheers,
Quentin
