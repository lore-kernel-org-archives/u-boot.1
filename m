Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD0FD875F
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D115A842E6;
	Tue, 17 Mar 2026 13:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fW5Dqj6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5833C842E7; Tue, 17 Mar 2026 13:43:42 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003D9842DB
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuc6kGx0zkRKEg75VWw0F7w+tuR7KjgxJh4C9OVIV72ncC7p0wXiwZ2ADL3NKNtctF/vp1361dorrQuzr81mMapH/S04ticR4g2GQKl718ac2wutAkKmtLXWI4iGT1NWMsqI3cEr9Lhpy/gRRQ5AyJAosJElZXG61r3Pz6ugjUoDfRrKo3zoXQPqen+7QZiJ0DliZvvwmoBFC/+LvdITT15c5RpzN6nROMu/keF+0WXmouY9FiZJEqefGJjYmAU/BFIMLD643WXWDsiDfr2lfF3WsLl9gMw7sIp+HkZQKUE6CZ7Yceulm/1R2CllmMyt1F9sBNz6RaFhQY+yPDgx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGiz7HJTJNDhVgeDB2xFyXQEHt3OLUBcUQHVbetxD/U=;
 b=VdJe1GKxSDcqammT8nXh86h8N81xtokpETGTyOpyehAHaZWmNeOC9Fug+/0tVMle5aaUEJzAJyKffgvIQ3lRIA0cE6/QNZvV3jIp0h1PF71vWA7Q+WwLZIoyaTmkuHjEF2btS49DvLqJNzhGQ/jthRIGwUcq+2/LRDO4a65GztYfr8vhM46dbiAjJZUyyKjcRuTFQlog5FEc3383X2oDzgumKeCQecXl74pu0IhY4h0zxqykP1MmWbJVMg8EXoyC0+jPZvyqXK1PICcjp110dHYkrGMhfpICB2MR57iTAN0mkJcjFDiTsP7r+2F5nmfpLFIIwuObvLuxWTTtfFeotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGiz7HJTJNDhVgeDB2xFyXQEHt3OLUBcUQHVbetxD/U=;
 b=fW5Dqj6K50YHhGEX3+dxO71kwjEcR7Swyi67kAI6xPOQ90sO8uchi8j+DiB+BIhcD/PS/ECKAfaJ8DzFW1K7OfxV/dwiZs6ouu4gcTvYqS7YSeAb77uZL+LVBs0D58C80NOCmo+okh41lTA4S/tYJLFPaxdXyK39MZbwTj5kSJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 12:43:35 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 12:43:34 +0000
Message-ID: <2df69237-7ba7-47fa-8980-35bb5aed75fb@amd.com>
Date: Tue, 17 Mar 2026 13:43:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] event: Introduce EVT_POST_PREBOOT event
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, Casey Connolly <casey.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <cover.1773154765.git.michal.simek@amd.com>
 <af02d5e56fa0fe48548da2a52d08710f3d7d5213.1773154765.git.michal.simek@amd.com>
 <CAFLszTju9o3O23vYBEx1R529b6iBdJL7PB0okd4p4L8m1pZzVQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFLszTju9o3O23vYBEx1R529b6iBdJL7PB0okd4p4L8m1pZzVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0006.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1e04e7-4037-47dc-70c2-08de8422cd40
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: SO6AHPFGesX0jFDsIxIX2Np8QIz8B3DF6spAyh2klwefZR7lbcx3/7srZnnXvVJv9ir1Pd1Y38gRa18tGUlKeb0a17FCOK13lRfFfGOS408YUQ0uqcjsZsfWZISyetaKNtjszeMMwdqPyJfYfO4+0z0jJXh980Bk6qNWPjnd2aSHuXdcUzIu6GcpnpJTklhBF7k0IzbSrLWIC8deQsLNhFy6uZfLoBYQOPZqAZ4ket4zzVP66a721iubBNEVvXcLRiJW9lmWNC5n/BoKWbUyI0w+QYrKSpU9jaKfJFQaa+VnZU12g/gdOYngcVGfMD6z1PYT/DJx26bYWXK+MzdbR2UFPGQ2zlRCmMKZUezXYIULgL6Yhv27/wenXpvl2TsGhUR9Hv71jz74tMfgYXIeGQYqNCNXxoj7VHpb3JcORie49I+9lSkZ5QJyQAbJcIH3lNWynd3pLR7ZZgn25n2aCKoFrjJSy7CEWfLiF+8BJ7CbUgMt5JyuObg6zoI7Nr582cWtf2xMrfGfusl0B9Xm+2KuVW8+amf+rQEx2lRVlEKnMdmbcav7TG+VLlB1ZyVMFkC3pBTPrLYa8FfiCBXw4dfgSLAuyvKpKcelCgGV47a5nC/irHMdulUX6Xo0cJIPeuvjqhLArvx85UK0R74e4Ytm1QsltBXG2GTeRodsyQ8lmmON6UHxDgQh366E5w/2kpitKH6rG4juzxRRp9H/76sqFpyc7lRYHBbqengHecU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGFzdjZiODN5S0Yrd0FNZWVkR2phWmE4MlZLdEhhN3J5a3VVS3k4ajZTMlZX?=
 =?utf-8?B?SDZUUjc1eG41RkdhY0lmMTl0TFFpYzc3bmgvYWg4S3V0OE9LeXNyWUN5ZWx6?=
 =?utf-8?B?MnNuaHhBY2RVeHpJa0Yrclc3WGxnQWNPNDFQNHpWN29VQkN4V2NuVWh3TGg1?=
 =?utf-8?B?WmFmUS9sWVFackF0YUZabGExZlRnUW9KTGhERTRjREJ1TWc5OFNpYjB3VEpi?=
 =?utf-8?B?SmM2WEphemcvNzFKcDBkTS9pZldaZjN5OFpvdEZGQ2lKUWtLVXpodHJudDlH?=
 =?utf-8?B?RE1VYTJYZ3ZROTRDckw3UVZPZGZNMGRaTFl3MUtOQ1VWVFZqV1QvU2pNbDNk?=
 =?utf-8?B?a04zWlZkeExkUmxFdUlZVmlqbWdkV0p1ZXFFSXpZRTRXZXU2QjdHdnlHZVJu?=
 =?utf-8?B?Wm5jMnREMExVMnNPcmpBQVEvRDVpb29JT2RFMmhNQzh3a3B3TkVKc3FjaTN3?=
 =?utf-8?B?ZmNTU1U5bVVJSVh2emVqejJKaWhJUUNCcDV0UFpwSFZONnpJOVZJazhMV2pC?=
 =?utf-8?B?UitEWUE1dUNVNTlpQmJBM3RxYS9lZFkvOE4vMkoxcDVRVXZQTWdIQ0Y3RnZZ?=
 =?utf-8?B?cmZsZEZoSkU1TVV5VDk1NThPT2RVWS92Y1RmeFhMd2Zvdjh6QldOMWVZdEk3?=
 =?utf-8?B?YW9ONjNXSU9kZlN5cTY1b3RZUmF4K0FnR0pYUWlkOFdPYllmK1V2UHpSa0dT?=
 =?utf-8?B?dDN0Qk5OelBrOWYvVmlhLy8wbzdvRFB2ZkxCNkJ5aENFREpCbWNFeDVrQnFN?=
 =?utf-8?B?ajhDMmt2Vk1uQVBFd3N3Y05maU1lSysrQXhXZlVOaWtTNmJWclN6L3NBR0d0?=
 =?utf-8?B?Y1pBUFozM2FUNFFMTEpoNFFLczRKVnovd2g4L1A3cHNIbWRMZ2Q2cW5GU0xy?=
 =?utf-8?B?WGs5S0E0d29rZWxlTUE3ZkFFVTdOL1EweHBHQXBEeForL3BicHV2VzMyTzR3?=
 =?utf-8?B?TE14V2h2aXpjZVdpbHJGVCtZME1kcGc0VFloeExBWDI4MHNDSE9RWCtDZ0Q1?=
 =?utf-8?B?VXIrRmtlY2x5djgrcHFMbjg2ejlpN0FRZEMvZ1R0SGR1bHlHOWJQbGdvcEJ3?=
 =?utf-8?B?YkY1ajlJR3c1dEtMcHhrRlBya29TZFBoeldvTlN0c0NYV3FKTGdTdG9zNEg2?=
 =?utf-8?B?c1lNYkg2a28xQlZNR2tDUlhMMVMwNThSQTMrT0xOZjRuMGMvZHNPTFBOWG9n?=
 =?utf-8?B?V1JMN2dkbEhTY3V1dzEyeGZOUXZHRERwOTk5K3hYNkdxeGRVS2IwYXlQMCtk?=
 =?utf-8?B?RUlMTm5GaWsvSTlkTTdpL0hQS0NITVkwaEV1NmppOFljTEpjQ2srRVBoV2Nz?=
 =?utf-8?B?aUtZSGU0aGFqYll2R1lGWjBoMWY3ZFNLUFpQU3RPZStVRHFXS2E4eW5uQkd4?=
 =?utf-8?B?VVJxVTVvUzA5SThPRjRNbUUwRVVqakdkRWdSaDlBSWhEK1BmdGxkWjVDVVcv?=
 =?utf-8?B?b3VTSkVOR3ZOVUNXTCt4elN3blBDcWtKb2cxZUw2YkdLanBJQ1hWRzF5ZlNP?=
 =?utf-8?B?Vmk4N3FZdUNQR3hqMGNGbm1BekduVUtYbzEwa0JmZEdIdVgrbHliU2FLUURr?=
 =?utf-8?B?SEtzaXM4M0htNXZadGdHeUFxb2dmK0tiR1d1RVBCVjYwWGNldzYwWXA5ejg4?=
 =?utf-8?B?bGg2c21sTEQrdC9uVTN5VGVDNUhMUUVDYlFBMHRlVFRTd0V4d1VERVVXYUgv?=
 =?utf-8?B?WUlYQzFUakxpV2RIRzl5cGMzRVJVc0w3OE5ZZndGeWNuWEQ4N0R6dFV4Nmw2?=
 =?utf-8?B?cnNuSWlyYng1SjNVelBOeVFmU0ZCaFJFaXNNY3FqZDBDQzQ3bm9CRldwdkdu?=
 =?utf-8?B?Vm9TSDJldG5RUm4vOEpVTEdOaWUybzdqdU1lOE5UV3ovZ3RoWXNQOUtTRmx0?=
 =?utf-8?B?cENCRVRQMVZMSWRZcGdNWVpFM2pIdzJtRFN6ZUVmaHBBOU5oc2diNXdMbkl1?=
 =?utf-8?B?K1FLRjJ2Rkh2UmJwcnZJMFo5TzJtK0I5MG9FZDlQUThsSmU0WnFabkNzaVlp?=
 =?utf-8?B?S29iTC9FdFpqdjhVZXNlckE3RkhabEd4emtSUnpNKy8rLzFtSzkyQ2xaSXo3?=
 =?utf-8?B?M2hheFhuaUVSRTkvVW1zSm41YnlPRVZMNU5ZdFRsVjM2RzNZUUpHeUNkU1M4?=
 =?utf-8?B?dlRoYkV5Y0lGdkt3QTRFU1YxOUlEZzRTUjJCaGFTaURZV0FDeXBnQ0lWRllk?=
 =?utf-8?B?VkZkY09QKzRZNTFHbDBJL0NQdFlwZzk2YVkyNWZXZnhkaDBiUjhYUEJETlNQ?=
 =?utf-8?B?RE9pd0tiVXYwVmQrNktXdU9kTnNsRUhWT0tFQkRJaHRTdkoyelJwVzNWcHBW?=
 =?utf-8?B?aVl2MDB0ZUxLQi9xdnNEU1ZLaTdxUEhuSDNhTUpMTnc3SU44WlBHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1e04e7-4037-47dc-70c2-08de8422cd40
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:43:34.2370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqMklrqtNh8zfVNoqEgh0b+qtbnZIRoQonjI3fcgli+PDANe8CfwNUbx4bqTDxRX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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



On 3/17/26 13:29, Simon Glass wrote:
> Hi Michal,
> 
> On Tue, 10 Mar 2026 at 08:59, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Add a new EVT_POST_PREBOOT event type which is fired in main_loop()
>> after the preboot command has been executed.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   common/main.c   | 3 +++
>>   include/event.h | 9 +++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/common/main.c b/common/main.c
>> index b0b6e74f5d3d..e8b23f3ff293 100644
>> --- a/common/main.c
>> +++ b/common/main.c
>> @@ -19,6 +19,7 @@
>>   #include <net.h>
>>   #include <version_string.h>
>>   #include <efi_loader.h>
>> +#include <event.h>
>>
>>   static void run_preboot_environment_command(void)
>>   {
>> @@ -53,6 +54,8 @@ void main_loop(void)
>>          if (IS_ENABLED(CONFIG_USE_PREBOOT))
>>                  run_preboot_environment_command();
>>
>> +       event_notify_null(EVT_POST_PREBOOT);
> 
> This needs error checking if you wish to honour your comment below
> (which I agree with).

ok. I will also fix this one which should check it too.

event_notify_null(EVT_MAIN_LOOP);

M
