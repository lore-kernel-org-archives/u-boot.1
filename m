Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F4ACD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFC784BBF;
	Thu,  7 May 2026 18:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="b8/pgDXH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90C284BC5; Thu,  7 May 2026 18:53:27 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D7584BBE
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0wBqhY8gHoMBMEjq0UB6mIJjJCwRSAUAjarQ6Hs/4OaJ00rUFMVE94gzU2l6UmXhs+kBnPxHm5fLco4D11IYeW3kEcRrWONZC77qcN3cqII5PA/UDvkjPsp/eVbY17kOC+G9QKSoqyXKBTRmslXSQsMkta8lEz/UngRuzTrfNUIlrh4mhDNGWAnBaBn7Qnhni4q20zD6jhhlyE58GuVvmlzhQMKp5mRhckAE24X9Able3IfNkz+lHcI5/IuGVJJfXDi6UE/O6ZBJv9yv9vfBxH3zQFm/7adjFAaBhFtP6qg8/M0WxWegb9HshSrAjt4QxEXdnR/dyJTVv0IipOLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9Vy9umtx1hauAwcHCllqpi2B4tebvflXruU1q7lufk=;
 b=dEDlE6oKTc0fpKw10Bh5HS1dQZ0kMaMibAWfpbkUL3RN9LGqVxyFBiGr26vsjNjzroBBMZaGo662KQSh8iYKitnOphfhAu2VUup8PvFtLDKisQZXw178RQ1AfAgsRIyviC740h5JcXV+pOyVjnfKIMPK6gRN9RkluPAa08NEFumW+bI+xwsYGLUdpcE+DTSLyWlA3/LdurrYIvphVNg2IPN9WCsj8PNs0045Kl/Qumm3oToiSReQCXYTgT8GXsycEDrKb7kape7DRO35kt8SUQRM3effqU1ISFv6gBopwiucdYYyaYVDjY0lQWYVzT6FxyFMEfOf3TarvDswwiZ3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9Vy9umtx1hauAwcHCllqpi2B4tebvflXruU1q7lufk=;
 b=b8/pgDXHfjhsVWK2d5I7uxtxNmPYDe7ttIc6Vm/tD7U2c2wvxiyslY32tJKgsAdT5On9gvtaIxtND4NPiTyKpzPG8Kf3/olrSNAG3CrVX34hNremjUWa3c5L/9RJvVlnyxruWi75qJe0tRdD7gUNVgjyWDkMbW+n+I5sgztYYJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB12110.eurprd04.prod.outlook.com (2603:10a6:10:63f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 16:53:23 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:53:23 +0000
Message-ID: <1762aa65-b2a6-455b-9431-2f4433d07788@cherry.de>
Date: Thu, 7 May 2026 18:53:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: Correct dependencies for MCP230xx
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Charles Perry <charles.perry@microchip.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Eoin Dickson <eoin.dickson@microchip.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <20260505133427.2647028-1-charles.perry@microchip.com>
 <aaab90be-cef8-4ef7-a355-62557f8459ea@cherry.de>
Content-Language: en-US
In-Reply-To: <aaab90be-cef8-4ef7-a355-62557f8459ea@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB12110:EE_
X-MS-Office365-Filtering-Correlation-Id: f54f2e24-4077-487a-614f-08deac5926ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 02lcJX3+RZP/9MDJncb3fbZHNOCu3CdBM9Evqe36XTD6iiOPwRW0ATegAZcIYXGfPR6fJmk+m1LCCEBBf9II0C5SuHbhJ3oWK0JAxP4OhIFntlaCFxGsx9yfP5s8Dg8VOw8F0oGee1w2CaLu3hFqRQ5ZPsqnQw3jidQNsYXPUZ5HnCHEBUiMX3VqDVULFelrf+mF2ZCa0f8DjTb2TAXxtwqqKp8mhg0N4O2MK2FvvxFRkEAhewXw+hrb0o5cDQWGB7RMgrb2pPRNqZZdhi6Jvc4meHGvkbqh+LR4gnKwFhiGX6IWktCILujPQD6bXO5Sotw2LpmoYD+qulffxB2QSJPB5VAr1cVVfHGAZy7NZJKSMVXNSkt0g3k1Hc0cxBkZbymZveyn63GoWXqXrmV2mfn9FwvToxjOQykcKcPgS1y33O5S7xkqk5QUf8hVsrBEbYcsV/eXasjFQ7Nm36US09fIHp+BfaPLNECOZyD5lvgIsCH+JpPSsNnAYB+3OXY5TjLYP3Wzpiz45Nks3z1pCLPN+4/mXv0134yxSEKMKXDrYin6TGQexJVo2wfmcqdRMtdssb/mhcz8dft4GobpF/GoQq0fCk3NENEUGclB1maU8SMhiEONlx1jOA+fBKbvegtV894dYcQbUqX3ZXSQoqz0GSMWzKyPB7n/OyqBCrAoXqWn6vGA9ZvajM5inYzs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS83WTQrSmRFRjF4ZUlJOE5KZjNvRUxMSkFGKzVtbmhHa005ZkFWQ2ZVS3k2?=
 =?utf-8?B?Vk5CSDg2WDJuYnVwUkt0NHhCVHdqRWxjcWdnTEJpWEZGY1ZNeVJLMDhOS01O?=
 =?utf-8?B?dWtxa2QxaEJPc2NpUW9ZN1lRUkMvSkVuSUNBNUZ5N0R5cERMWHpDci8zVmZ6?=
 =?utf-8?B?TzlLZDRsaWNFSi9EOG13Ynh0czJvTDNsZVJ6cFFkKzZXVXFFb09LcXlWQi81?=
 =?utf-8?B?d1cybHJEQVBTSjM4VG01Y0ZvUk8xK2hUbFFpd28wY0xIT1FRSWtHZ2IrNmdQ?=
 =?utf-8?B?R0txS3Z3dDRqU1k3dDN5Qk93Sy93U1k4UEVsWjh0MHFoQXcxNVRwVEVNb1lP?=
 =?utf-8?B?OWYwajA2RWhRQWRVVUhYWGVzaXhyUXhON2l5OTFITG1HeWh3MVlOREZzWDFY?=
 =?utf-8?B?NGJZVW10azRPcy9HRy82Wm5UYXdYaHkvVURhY2l6N3czZjJvMElubVAxemtC?=
 =?utf-8?B?MVF5RFUzNUNUWFB0RXNKVXFWUzN1UjAzQzQwVjZ5TDJjM0RpTVlJdzIxTUs2?=
 =?utf-8?B?NXkwdlhmbmo0SEdxZlFJRGYza1piZXpTZ3VXcEZrd2FFem5ETmJlYUc0dTht?=
 =?utf-8?B?ck1vNGlhZS9DdytreGhVN0Y2aEx6V2QvZFhKUmlxbm9zdzFMUnJJbG9wM3VS?=
 =?utf-8?B?UnMxZng5Q0xYN1Z5WkZCeWpZdW1jRnh0emZxaXQwS3YrYUt5Z1FQMVJVdzRE?=
 =?utf-8?B?MGpXZkhINWNuZ0t0VGR4bUQ5VFovSk1ZRVlQS3puTzRNTnVGaExYL2paQVpq?=
 =?utf-8?B?K2JjUFlXTkFhOGZKcHdjTnlGRjNGWHB5bG1xL2ZjVVkrNE5BK2p3Mjd0Mk4w?=
 =?utf-8?B?WU1Xd0prOXBlUzhtSlNUZ3FXZEh6Rm1wVENjbnJPK0g1dnhodWRxdEw2MlRq?=
 =?utf-8?B?cEdaa3RJVUJEdDRiTnJBczNUUzlwRGg0R1ZHeDV5L005Vk5ZYkFhN2ZTNGZu?=
 =?utf-8?B?QnRQZTN1Q012KzZsSzZxY3YrODI0MGIvdm5VOWpXVE1uK21uQWRxSnUvbm5H?=
 =?utf-8?B?MXI1UzZicUNaY0FjL2N4eVJxMThoWmtkOEZGMUVzb0ZlRElvUGlJTlk2K0Jm?=
 =?utf-8?B?YmRSak03N1hESHdXTmdQRzJOVzc4LzhBUFFWN2Evc2FWVWlZb0hLS0xnZ24r?=
 =?utf-8?B?b0F3eTJ2b2Q1K1V5SDl2ZEYxL1cvOG10dmpxcUc5c0dVY0RldjFvNnN4eDhh?=
 =?utf-8?B?MGE4WGFSNWxUQzZEMGtXck1uc1lWL2VlK3dHQUZEQWgydHlsZmlydDNYWVJQ?=
 =?utf-8?B?UnRpMU9Dc08vVHh0VEJUTE0xTVJwbUxXWDZJWDJlWFFGc2QwZ1RDZEJYbkpB?=
 =?utf-8?B?WFExNk1oZTBHNEF2c2N3c1VKM3NRWXpPNmZZeU94TGZtUXJSQUNwV0I2MlY3?=
 =?utf-8?B?UVNaNDhjQkRHSnlrcFBTWVNpM0kxK2lpc0hsVHdvNVY2TTVzMUFpSVhXTjhi?=
 =?utf-8?B?dEJVR3V2elNmY1YvTW1VZzAwRElIQ05DTm12N1VVdE1zeUZKUVZDVWVUYi83?=
 =?utf-8?B?aXc5RkY3U3pTVXZyNkdJVEF2eUU1aDZYNVZCZjJ1ai9pUmtLZnoxeEkzT25T?=
 =?utf-8?B?Z1hLT0JsL01CMWNRMWR2WFFja3V4YXJmTWRVcVY5VDNRMTBxMWRENk1NN2pW?=
 =?utf-8?B?SzVkaUNRbzIvYjRLRitYa25jYVk1RzJ2czM2TkZXTm1zMEsyY3NFZUhBVzh3?=
 =?utf-8?B?bTZ3WGgrMFNMRFVoQ01HVy82eVQzSXk5Mk1XNnYwOTd0WjVqUEVESUhkQUhu?=
 =?utf-8?B?UlNHMTFtWDNJbFl5VVBFVWRGY1pIbHVJMW0wa0FpUFJVei9hSHVBQ1pwSFRw?=
 =?utf-8?B?OStOYTBOSGIyWUJBYnNlRStlR3JIbks5K0gycEk4Y3J4eExRL0Jzdlh1ek5i?=
 =?utf-8?B?V09wdUI3Qk1iS1pnM1BSeHRQNEdaclI0dWVUZ0FoYlEwUy9HaDZIcU91ZDVD?=
 =?utf-8?B?ZVFZWHZsWE9UMytoSGR0a2FZUXZNVUxKQ1F0MGk1ZzAzdlRKRTVBTlg2UC9s?=
 =?utf-8?B?aUdjZ1JFeDc0d0s0NVluVjFJd3JwdXg5K1FlM1JONys3WDRnWTdLZmlIRkVP?=
 =?utf-8?B?azhlaXJXV0daU0NBSWJWR1ViS1dUUDJPditrZkhWbmJ5SDJjSjQ3WTBJdFQ0?=
 =?utf-8?B?ZjhvZFQ4TGRSY3pGaGI1VnJOYU9tSXZzdDZoaVF6Q0ZWbU1RVVZIYytGVWVY?=
 =?utf-8?B?NWIzWDlDdlhYcmJDRm4wZlBrYURoWkZOVitRUVdKemtSdzlXaG80bnd0OWhn?=
 =?utf-8?B?b0crWW56TUl4V3FTWGp4Tm1MU3YrcEVFVk9zNmp0cHhaSDFmcGNudzg0Q1Mx?=
 =?utf-8?B?YzRXZzhkTDRuWU8yaG9YU3h1VWtZMHZQejR2QXREUjZpY2QrRm9pZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f54f2e24-4077-487a-614f-08deac5926ae
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:53:23.5121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lPyTOnk106adXD4xP8cUQjj5M+48MUJl7fBiQIundbFfj2kHb35mlm4jAodruM2mIcSAT+gc6pa4iipKti1533vSJe4ANJwarBQJBBa5mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12110
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

On 5/7/26 6:51 PM, Quentin Schulz wrote:
> Hi Charles,
> 
> On 5/5/26 3:34 PM, Charles Perry wrote:
>> [You don't often get email from charles.perry@microchip.com. Learn why 
>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> This driver depends on DM_I2C and DM_SPI, add it.
>>
> 
> Wondering if we shouldn't split that driver in two symbols, one for I2C 
> and one for SPI such that you don't need both if you only have a device 
> over I2C/SPI.
> 

Just want to clarify that this is "it would be nice if we could do X", 
this is not a requirement though. The immediate issue is you cannot 
build this driver without DM_I2C or DM_SPI not set, so this patch is 
fine with the small change requested below.

>> Signed-off-by: Charles Perry <charles.perry@microchip.com>
>> ---
>>   drivers/gpio/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index 37cb672697c0..3ced3fb32f24 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -309,7 +309,7 @@ config MAX77663_GPIO
>>
>>   config MCP230XX_GPIO
>>          bool "MCP230XX GPIO driver"
>> -       depends on DM
>> +       depends on DM && DM_I2C && DM_SPI
>>          help
>>            Support for Microchip's MCP230XX I2C connected GPIO devices.
> 
> Can you update the help text to say this supports SPI-connected GPIO 
> devices as well (the SPI-connected devices are listed below, outside the 
> git context but if someone doesn't know better, it'll be difficult to 
> figure this out)?
> 
> With that,
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

