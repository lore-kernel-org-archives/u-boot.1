Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1237FCD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 08:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 148C2838BB;
	Wed, 13 May 2026 10:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="txQAQpmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60AA83E36; Wed, 13 May 2026 10:53:05 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72FA58341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjQKA9ADnzZ8G0XVcsbLTyaB14GqaOcLBbqyxcH19APwnzejIx2i4Hun7bH77ACwaEP2ig8erpbJpNnxjQeOMZC+QydvMXmjP/N0TOELSr4Ad/KRq5JUQ1yrnNcK36ftKvklFc3KaKT0K1G1VEHXNEBPvJu63nm3DbdVphpz7/NfyHrfY2K+asALpNLCVTI8h2Ted+bUs6YfW+0fRYM5YtdaG7oacgziMc+ByVtqkTPsiC9ISWhfz6UoHC6LnO0BKtLXoT1LZO37bFjr+pJ5EW+mnQF+t3pvLBgqAnJ8ACyd7dvU48MzZ85U3tnxyCJBaaP+7aDELtTFoR1y68kk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAuIhhlbzAESNryRxcDCJnpZCtI4dFt7I2LlQvLxNWw=;
 b=MlZ3/PFDHxzVoeg65HC6HUjfOYdigN5TCPLsbjy2ZxkOV6JZ/eEDBbYSX73EbAa74rnHCTfRvKq+ZCNuSxWsz0+vLKv6uhNGB6oKJVVKGgUoHrYksdEQyLduIDRU5/fAz5umntnBkxDUOSpa3F/mVd2eqnX8l52Bb3PgLz5GFNMGUq9xMa+qhije3WQtGadg4BnunFu836193XWMqTK3cjI7mVkuqzDGigAO4vEXWWgEFPBeR26bP8/PjY6lSWGuwVsUqtfWQYIpkcqwISR48N4CwLLR31bb5xGcclQnXMg/TvdATxnQdoKdl19VadVdSPqZT8EVXCz80WFpRIHJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAuIhhlbzAESNryRxcDCJnpZCtI4dFt7I2LlQvLxNWw=;
 b=txQAQpmVscZbo3FBF6HO4wTOXrBVb9u/vubu1a6AmT4QnRe5no1VGYSTARAgb05GC/w8v+heH64C8tcky5HDDWTNN+ukO+5BabCRhhaXx1gidA58d+/Wg4t6iTKWIOKCL+XhNOcqyFTZFPRdlP0ZNGa7j/BwROl+jgMkN3ocfc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:52:57 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:52:57 +0000
Message-ID: <cbadd601-4337-4eaf-bf6b-8c98645dc089@amd.com>
Date: Wed, 13 May 2026 10:52:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] reset: Add sandbox tests for reset_reset() and
 reset_reset_bulk()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@amd.com
References: <cover.1777984225.git.michal.simek@amd.com>
 <21c23cc7403153b45a81c958118b8d9f85f73140.1777984225.git.michal.simek@amd.com>
 <CAFLszTiYJU028+L40rzNa=X-qqDYCfbPqYMfGhzpK3Xq2mr8ag@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFLszTiYJU028+L40rzNa=X-qqDYCfbPqYMfGhzpK3Xq2mr8ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH2PEPF00003847.namprd17.prod.outlook.com
 (2603:10b6:518:1::64) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 763a3ee1-1b87-4d75-d248-08deb0cd078c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: czVsSN7F6nv7ZG+w2rgncHTQ54Fq9uPGqtdiXEeg3WBYpYbveMKJTo0eVFojjzLBI9cmmyQZgAuLtHl8ZxnMhY9XK83LR79Xc+QreZvhOZ0DzgkdbgSUhtbs/m35E06Qb7vmOq80wv+J6FJMw8hVX1x8IgJgxtgq5tXTAoGLlBsQjk3NFf74L3J8Xeeo4LZqRNxnHBZCftoKGs8/mkKawDm5N8Zs453S3oRIHaat8H7T67FbS88M7owi2ERmWiUWWt1rm9hoAEf8L/In2GZFfF0zeiJY2DoGCmx3RgF1DBv2Z6KgSNzKZZJ5HOvhV7s1EkXyCoJ6FL9NmpwR6j2exIABoTBwpD9F15AHN5I/MwOp0XM4dURh1E8fbUK6uX9DnBYguC5YW9RhLhy00WVwd4sWE2GvlSBvbTB4P1G5DuWaWMA7APD4OdGyKZv2D4L4DmWvTkOEZAPG1UsgCFqU3/r3A5O/VArXqlSd2kNe2KzalaREBPqMHO15n3uR4iVQErzgyKdmyQ/SZ4wnkxAtisbRrYZHt+r2TuwQNGvo/2SwZIRMKJYy+9tkAZrIAyy+DKSNGn2dE0nX/j66Kml1MgDS7KW1dj7roXVMcNq2mVeOnRmuhXX/NMyavcMLvhZvbJrza72CLbMNLAf+/kfF2We0hnDw4uaQtdQUV2FjEDV73t0XMQbVrVb7FJpK6K/9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ZEcVBuZk9scE5HMVVyaUI5K3UxOFZCSkh1VGt6WUhQQU12ZDFpY25mdmhO?=
 =?utf-8?B?OFBKdEJncDk0WS81R0xXZDNXWUUwelFtQUlEUzJZT0N3Q1E3NW5JYlpwdnlY?=
 =?utf-8?B?WXZ1WW9qVzcrZFlodzNSSTgzVXBlcDlXR0NFZFFaaGtIUDJiRzdiVS90ZDlM?=
 =?utf-8?B?ODJ1dG1PZmNDb3hGVy8yaWVDT2NTS1NyZitqRzdZajUxSi9XUFRnTFJ4VnRz?=
 =?utf-8?B?c3F3ZTcwdklWdGNhVlRRaGIyQTlLTUZxdTlmVm0xaGFGTXV5ZUwyLys4U1Nm?=
 =?utf-8?B?dFUzRXE3TGVJc3FiTktjTlJvSGg0NVoyQzJJT3I1ZXE4WkFHbmY3MDBHaE5P?=
 =?utf-8?B?WWNJS01qaWtIaUtaSmp4bFJLbWtCSkREcHlFM2dmUjJmbVRjRG9VT1JiVUFx?=
 =?utf-8?B?VzlaeVFpWVR3NWpaaDB2TUJiZ2xrR3RmUkw5WEhtRjh0d01RUS93d3NBcFQz?=
 =?utf-8?B?U09aTVArUDFIK3dxUWJTR1AyTnVLcGFXNm42M1YrTEM5bWYvY0ZWK0I0Nmwz?=
 =?utf-8?B?cnh6dFY4OWhmQlFnQ1IvTGNmdVBNMnNsMTY0UVVvS3Q4NEhQOVJ1ZDk5My9O?=
 =?utf-8?B?RWJ6c2l5clNxRGhHV2pmVWpIYityRytHRUZSbktUaWNpNDBBZXFlQXQ3Q1lh?=
 =?utf-8?B?dW5LTy9DS1FUekc0Nmw2ZitBOTY5enpsQ3lyejFsc2JYclFFWTZNTWFHekJi?=
 =?utf-8?B?V3U2REZLK3E0eUtuV1VJODN4bUZVSG0yakdHV3pvYXNGbmxRU3ZHQ2wzSkN2?=
 =?utf-8?B?MXppTnZDLzB5bUpWY3AvVHBaQ1V0WEpsNUJCN0E4ZVhhQVBDeENwVHM0cld5?=
 =?utf-8?B?ZzBTQXoyYW55UFVtUWtEWEpRK3VuY2dVWWIzT0lmSjV4b0hwWXFoeGt0RFU5?=
 =?utf-8?B?Tm85cmRUSDJrSysyTTNKa1pyZmFGVzZxU2Y2NWtpV1d0WlBneDY2TllaYmNU?=
 =?utf-8?B?NStlQVlQSkxRT1BZd3hkOVpyVGRMWllPTEJmMUhOMnhlWlZmMlJzc0NoMDAy?=
 =?utf-8?B?Njd3MFFlKzRwTHVIMUV4SGtFRkRkdnlieGNPdDBKZmZqTk00WkZvRzUvanlk?=
 =?utf-8?B?L2hrMkJMQ1VDQm91Q0VVMmtGNjJjZ0s0WkhFS3FJZDJFSVJzS1lGN3JhU1RG?=
 =?utf-8?B?ckdMZDBCM29ncGFGN3VSVHIwRVdmOXJhWDRrVkhzNHMvSFVsSnBTVEw4SXc2?=
 =?utf-8?B?VHRNUDhSbDdCVEVxNkhBZEJseWM3SHBvRDJaV0k2dzdVRWVteXF2eVRDUGFX?=
 =?utf-8?B?WGFkRkhKd1paREN5RjZHTDZGYU1oRE92bXRjRERHY3l0K1k3eE9mZ1czYUxk?=
 =?utf-8?B?Ri9qT3ZDbUhiUWtkK2szSllITlIwemZXVEpMLy9NOENsRzNJSEpjRjZjTFVy?=
 =?utf-8?B?WmJxSXJlV1VERzBnay94VC9icmEyamVMSTVrVUs4S1BPeDcrTWg0MnVuWGlZ?=
 =?utf-8?B?Nk1USjJWS1I5a05zNkhTdDlueGZidTBISDRIVlBwbmpicjNQQ0g2eU9VTzl3?=
 =?utf-8?B?bDhKV0J1NTVqT2puQXBPSU5YL1hmaUhKNm05RjdHVnpnbzdBSXZpQWluRS9a?=
 =?utf-8?B?eU1sK0VNQnRGMXkzTy85elNvVCs5emRuSERLZE5wNERUbTdCZnVZdUxzdGdR?=
 =?utf-8?B?V1RkNk1wTHJYb3NxN3dHQjdDNWFJa0VMRmtuVXJxWGphTEdWNXJFRmd5Nlht?=
 =?utf-8?B?VkluZWV1clFWa3dOUWFaY1VhODhRRVZGckJXSEJoMEhFTDRnOFVvMGg1OE05?=
 =?utf-8?B?ejBHUnhuUDQvVEFZY0pZNWdIdHlMeFY4eGdoY3BIbVB0SFRxTFpZdWh3V2xJ?=
 =?utf-8?B?ckFCaWtHVEVrWEsvczdMeU5ZMU9lL2JrRExEblppQXdtWEE0UmZjUFVCTUUx?=
 =?utf-8?B?VW8xZm4vZUFueTF5cngrUHhQZjVsMXd0Z283OUg1UTBwa3YwZ0VlUFdCaVlO?=
 =?utf-8?B?NHh1ZWk4V1kwWFJzZmVTa2M2di9LNm81YVRBZnAwaERMeFV4bkNzRkRQdUVs?=
 =?utf-8?B?Y2dtQVlaVUp5bzhZcGllclQ0YWwyd29FU1ZaaGtadCtocWJqdldMNk1IcHJk?=
 =?utf-8?B?eFBKQUVaVm0vZ2Z0RzJ2YUJEWFB6bGp6UXNXUkRnMVZhTjJMK294YW9jYko1?=
 =?utf-8?B?b3JMT0RTU2J5UWtwOXFsMnBMZW1lSUhvcm9ESk1RYWRMa2FJeWFpN3l3Nmpj?=
 =?utf-8?B?VGtZS0hLdFZOOTlmTTIrRkpiRmNFK2VHdzQvcytIbTBTRktQc1haaWltL1pa?=
 =?utf-8?B?Wmp4NWlJcDVyUGN3MzhIeGN1TzBpajFQYytUZ2NhYSt0ZHQ4NTZ4dmdwWnR5?=
 =?utf-8?B?aU1XUlMyTUJ4ZjUvYytMVjN2WFBzOTBEQ2txd2xXaytMNGpENktadz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763a3ee1-1b87-4d75-d248-08deb0cd078c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:52:57.6295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSu4hT8LNb4d3h+m0gimCWDny3x5NEPvn2aYHpU1kXuIxBCWkMn8otH2rRp0L8PG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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



On 5/7/26 23:11, Simon Glass wrote:
> Hi Michal,
> 
> On 2026-05-05T12:30:28, Michal Simek <michal.simek@amd.com> wrote:
>> reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
>>
>> Add DM test coverage for the new reset_reset() and reset_reset_bulk()
>> API functions. The tests exercise the assert + deassert fallback path
>> since the sandbox reset driver does not implement the rst_reset op.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>
>> arch/sandbox/include/asm/reset.h   |  3 ++
>>   drivers/reset/sandbox-reset-test.c | 14 ++++++++
>>   drivers/reset/sandbox-reset.c      | 31 ++++++++++++++++++
>>   test/dm/reset.c                    | 67 ++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 115 insertions(+)
> 
>> diff --git a/drivers/reset/sandbox-reset.c b/drivers/reset/sandbox-reset.c
>> @@ -66,6 +69,21 @@ static int sandbox_reset_deassert(struct reset_ctl *reset_ctl)
>>        return 0;
>>   }
>>
>> +static int sandbox_reset_reset(struct reset_ctl *reset_ctl, ulong delay_us)
>> +{
>> +     struct sandbox_reset *sbr = dev_get_priv(reset_ctl->dev);
>> +
>> +     debug("%s(reset_ctl=%p, delay_us=%lu)\n", __func__, reset_ctl,
>> +           delay_us);
>> +
>> +     sbr->signals[reset_ctl->id].asserted = true;
>> +     udelay(delay_us);
>> +     sbr->signals[reset_ctl->id].asserted = false;
>> +     sbr->signals[reset_ctl->id].reset_count++;
>> +
>> +     return 0;
>> +}
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Some optional nits / thoughts below.
> 
> The commit message says the tests exercise the fallback path since the
> sandbox reset driver doesn't have rst_reset op, this patch adds that
> method below - so the commit message could use an update.

Will update.

> 
> If you want coverage for the fallback you could add a second
> sandbox-reset driver without rst_reset, or hack the rest to clear and
> restart ops->rst_reset,
> 
>> diff --git a/drivers/reset/sandbox-reset-test.c b/drivers/reset/sandbox-reset-test.c
>> @@ -96,6 +96,20 @@ int sandbox_reset_test_deassert_bulk(struct udevice *dev)
>> +int sandbox_reset_test_reset(struct udevice *dev)
>> +{
>> +     struct sandbox_reset_test *sbrt = dev_get_priv(dev);
>> +
>> +     return reset_reset(sbrt->ctlp, 0);
>> +}
>> +
>> +int sandbox_reset_test_reset_bulk(struct udevice *dev)
>> +{
>> +     struct sandbox_reset_test *sbrt = dev_get_priv(dev);
>> +
>> +     return reset_reset_bulk(sbrt->bulkp, 0);
>> +}
> 
> You could pass a non-zero value here if you want to test the delay.

udelay is called and because there is missing check for 0 value it does timer 
reading once. Don't think that make sense to delay tests.

Thanks,
Michal
