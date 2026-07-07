Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1805C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 10:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C37848EB;
	Tue,  7 Jul 2026 12:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRSAFk+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBDCC84942; Tue,  7 Jul 2026 12:56:12 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F67846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 12:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XamJjhavs+sjDq9qBT6YaGiBkbYCNMTj8FCuqHddsZ/u4H2pGPK0KDMC7uZA1NBLc01lUxLTgW+KCZec/ihhsMGKQaImIxnPV8GoqQweRlhlTdc1K5e6sRveU7hquaMRhkydAWhybwxrH+oPftAtEFnue7aq9ldYf6MYegDX3/vhhEke3d/tt+i1tFDqXmNRhGFOfMnT7/k+Lpxk2ZQauTxYThdwYthgdksyKdbdJf6xgQk9LzFI85gCnganqJ3LSKQ1IJtY7tzCyKgzSD92Vj4uZ/OQcQjynRQo187z4f4cDL/LpSEAB5CC13PtBZlhlVjDvNVzvmaPNCw6OwsseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdxCrsgTlEwQEcvo4jZMLSJMCx4yRzPk3bS8KABx9Q8=;
 b=YEBWPtlSLC+MTUz7n/uPHl5LEGMRcOMzVYRj7n5xqcHMRhlE0ilkXCU18+ON7hfnoMOpaKMD9hCeefwwA9f9EkHc53N0f4tecnDSQX2jw6JHsQQyXnR3MoUwHwk93ip9+33dWUPsvgkz40cZLZJcpgdjfVWGYQDbupVOfJlgWxLUGF++oH/LNZKwMFvIzjffkyTjgIIJcvA0IUJBPaBE9+hjRLk81L++0Fekmcd3IUd9PTjt8TNHXJGwSjvxNWYQreAF6t1QMTS3BaPK61NNmnSJ5jx1L5DigPuewdOXi655PsTuOgstWmVoboa035dnRO0woJ8JVao3Gycy/mIS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdxCrsgTlEwQEcvo4jZMLSJMCx4yRzPk3bS8KABx9Q8=;
 b=MRSAFk+WI8OIiAOz1/PeyWQtt8A0X6fqXf8t+x2ZpupIlvylnobZw1d5AETuvdymqbAPHUfZunqc8HAhWsU6W9otFb74BIdWku/TcDSfq7RbLR8e4Ve/XS+G8WTI8R6Vh/zVqv+7qwUo+/W07aHHBc4KNpZo+cEZ79qb5NYqcrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Tue, 7 Jul 2026 10:56:03 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 10:56:03 +0000
Message-ID: <879e6b36-29b4-4a14-9c28-6371bcd09d71@amd.com>
Date: Tue, 7 Jul 2026 12:55:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
 <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
 <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
 <08e98c15-80a0-40d8-bc7c-8d8edfbf3f99@amd.com>
 <CAC_iWjKH89ibj3KNvJW9HHXbQ4MhDLb2qWaYytU0S9Q_3xqkgw@mail.gmail.com>
 <fa17c2ff-866b-40ec-ae10-847f2ff84572@amd.com>
 <CAC_iWj+VqjpWPDRVGvCYpWMg4hmjeS1YzPBZiMvvQqvRRLe+Vg@mail.gmail.com>
 <a9285398-9e71-4767-a34e-2dc767c11538@amd.com>
 <CAC_iWjJiqU8KavYyHEavj+pszLxN-oq9EoucBi=bsjRuVqNMmw@mail.gmail.com>
 <207fe44d-e18e-4983-b152-be820d720275@amd.com>
 <CAC_iWjJ2z2TCZT63U5ve53LL80GnZ6PsuR1hOG4EMtizq3+LwA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjJ2z2TCZT63U5ve53LL80GnZ6PsuR1hOG4EMtizq3+LwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b688ff-7f5c-4583-5234-08dedc165669
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|4143699003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: OAcbYS/a0hoa0sPgVR8rQV06pGaa5F40zPAewCyWH73RvaJG7+G9H0ObjXzATy9t3UHRBWpgen2pJhFvjTlY3bnhE4CQHXhXPm9DKBBuUCcttRVQ5yb/lME9Eq8GX5d9u5al9n2ZdYmr+Kb5djhSz9pmQI0JK4w2xk55989wkREhNjron22ACKruh31WFXiu4XgwgSQQbMhWANOYQu0RwIAeiBKQWFzNdt7OgaeXtbabcycQm5l/nM8579Yy5K2nEnqiADvDM4JfxO0qRYkXe7A7vjVN0N6emMDpu/H78bxa6Pl3M00dUUGt9eXAz0UdeHgP9MFi42DP6tuw6JYsZNzWJAA99tPUiqFlW6AM8asW1i0bNYBKYHatERTt1hJ1rw1Ohxd0CD0HyudYWgF6STZraa9ipSXcnn6Eu7VajOBot5N8WzvdhTydM5/USRI7GorGB1PPf0tvllKU1EYY24jQywOoK5PjvtvPxAQYmVZReuOxuWZw+XlEiijmRlgvQDhL40JPKWmlrU0kFyrHmvPYNq96GCiCVCPldLBypx1m3p0IkNMe3xoWFQJCl8jVNRDl/OqilgtiaoD6djue5gRbZBmz6HtWV43qgsmpEojgeZkM4vF4a8BQVahBQjNEr5J3/izGwe/iGFPPH8FgFsSDOq/1FGdAoMtcFtlPKcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFg2cnVxQnNaUDVuMEpiYXFETTlscVZPSUwxOTNQSHkxZndEdC90bWZkOGVQ?=
 =?utf-8?B?eHZPMDFwbEJubnF0d0RQd24zSGdSL0RQVE50Q0lQdzRJUFFzQXJFbVBBbTV1?=
 =?utf-8?B?anFPSnpPKzBROTVXcUE0UkVZdTY2V05uaEg4RU91Vm1qelIwUlRwdks5cGcx?=
 =?utf-8?B?bTRGQ3JFOUJIaEZ4Y1pEc0NWanUvY2dFbUJZTXNrRThvVDQrclJRclROUzZN?=
 =?utf-8?B?QXZKd3dSMU4wYVJZL3BtcUtidGhsMzExc25ZR1FyekFqVjdiL1dXRERqY2w1?=
 =?utf-8?B?TFhpcW5WZnJSd2owc2pqUkZ5Q21EdjM1cUJHVXRSOTIrMDVxZHR0OG9nVUx2?=
 =?utf-8?B?OUNZRXZ2dnNXakZhTkM4eWJ3eW9MLzBqNjFudWJYdWtXN2ZCRmZqTmtLWmhw?=
 =?utf-8?B?Y2d6S3B6MXBxY3RTbzJTMDkyVjhGTStjbzBNYk5kOEYraktLSnRFQ29FTmtL?=
 =?utf-8?B?elkzdEpydW9jcVMvcGhSUHBBSlhLTWwwTjI5dTltUmFMN1ZpamQyTk16M3dl?=
 =?utf-8?B?aUtXV2ZjQVZvdEd3VTdlUWlDdjlRZm5IeXU5ZVJROWVHNnRRSHJyakRMb1Jv?=
 =?utf-8?B?c2hwTEFZZ0N1dUI0clkrQW9SY2FLY3VyOGdCSWpBYXRPQ0VQb3daY3FkOTNm?=
 =?utf-8?B?dWEvbG9hTkJPWG9Ma0RURVZjcklkc2NFWW1DWk5JeWdkWGJmVUlvYktyVWV4?=
 =?utf-8?B?SFd2YUFBc01mci9RdzdrVlVTTkYxNHQ3OVY3TTNMVk1hOGZ3VXlRNWJqRFE5?=
 =?utf-8?B?MkpVZWtRcnNTME5QZUJRbVIwMGlRODl5b3NXSTJUam5WRFpwNDh4WGRIVDhu?=
 =?utf-8?B?TmlRUWJMVUhUZG56OTR6WFZzVWdTWkRLRkFqVjhBNDBVbWRKN2JOVFdFWnoy?=
 =?utf-8?B?d2Z6enh5YXhpTDlWMnRhY3JORnBqUFV4Q2tNeFJYSTZHZk1NRHlYWmFzL09a?=
 =?utf-8?B?d21uRUNVQ1ZKcmdyVm5sTnFkRDB4NGtzVjdrS1RqdzdPTVJ5Q2gxNUluVG5a?=
 =?utf-8?B?dnprSm5iSldrNkhrQi9KbndRZHVyZWltZFpEcmVQNHJ6NVNJZFoyNEhUclUz?=
 =?utf-8?B?Wkp6REVVSm9HTWVON3FHdzR0YWx1ZWlVZW1uSEVxSW44d3EzbXVDMXhPbXQ4?=
 =?utf-8?B?N1MvRDhIbXlMWHhoSXlmOGtiSGprV1pHbjFQb1hoaHFXVG1UTXVRejNaNFdL?=
 =?utf-8?B?L2s5bU80aUFieXliOUp6VDNHNGRsSzd0WFgxbXRlZllTY1lxMGlORjFhblpi?=
 =?utf-8?B?ZUtTQStUamtRZjZoT3dkOG9od3VGMWc1NHBWYjVrYnU0dXF2MG1IZTQwbzlv?=
 =?utf-8?B?N01KaUpiUkZYdXpoQ3g3SkZialUwa1A2RW80RFRKMEt1UG42cndLU1JlVUJU?=
 =?utf-8?B?d2M2WFJNMFhKYUk4OFhLL3U1dGJRNmlBSHcwcWJaYUNTZVJiSlpuWGYzYzAx?=
 =?utf-8?B?K3ZNMng3cWhyeldNcjNsMjBMQ2hWTzQyREU0T3YzL1RCMk1VWDJqS1JGKzE3?=
 =?utf-8?B?TEw4c1NmQk1zcWJjakpHYm9OaWx5N3F4azROek9YVE9MVU14Z21LWnZtRzFC?=
 =?utf-8?B?NjRLTXR6MVhMTWp2TlpHRTNQVXRWOGE3Si9aUGpnVEpaNFkyUWhIZUJNMW8w?=
 =?utf-8?B?RkJVOE5YUVVQNVRDT2xKNDZaNFFYdEwvQjRKRjVZU2hndWVXWjM3NEF2aXVI?=
 =?utf-8?B?SEV2djNnMWlxWTI4WlhMQTk3ei9tZGdleWdIZGttZWlmTndpRXI5enExUnR1?=
 =?utf-8?B?YmNOT2tHSXh0UUsrU09weXgxRlMwdzlVNXA2NHlvS1lIYmg4NG5yT25hcEEx?=
 =?utf-8?B?aU1QdHpCYTlrZ1Z0R2pnMlgxUDJHSkFrNjN2M3p3L0tNam0zU25QVTU0MFd0?=
 =?utf-8?B?ZzBPcnhXSU5jZVJTRUNkWlVycElxajVqNmRacEpOKzJLYmdmb3p3T2xZbjY3?=
 =?utf-8?B?V3VYV3dhVUN2Z1RpTDZ6a0MyTU02UzFkQTQ0aXp5bVhnOVlNNTFYdTl4QVRS?=
 =?utf-8?B?WUc5U2FMUmEvTzdJYTVzNHBqUFNkTWtjMmY0Q0FDTCtKRllCNyswbWtrZ1dP?=
 =?utf-8?B?NUZ5L09UZE9FRG9xRTVIc0pYN0pjMEtDaDlvVzhPSnRmZ3ArdVNGYlhIbTBz?=
 =?utf-8?B?ZE03bGtWMEt1Z0hsS3AxVkdOVEpqbTEzdTBlWlZhOTN1R0IxbzhKcExKaVYr?=
 =?utf-8?B?ZEFXRU9zYnpiUGt3UytpNlFEZTlZRWRFYzFVaW1vV0ZiTHhvUHkvQWhXdUM3?=
 =?utf-8?B?Q0d1dnJxbTU0SlIzY1QwV3ZwaGFxUGppcy81SDgvOFdndmg2OUsxckg5d0NL?=
 =?utf-8?B?VUlicGx6ckNhc21wMlg4aHdBRlFnTkdibHE4QW9XSHhvUEgrVi9JUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b688ff-7f5c-4583-5234-08dedc165669
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:56:03.1634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MA3UAB6xy903r2sT4JNW/em8NBkxY0zgh9zxV8fd9i3n63l72uP3CxxUCqawKHCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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



On 7/2/26 15:07, Ilias Apalodimas wrote:
> On Thu, 2 Jul 2026 at 15:40, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 7/2/26 14:24, Ilias Apalodimas wrote:
>>> Hi Michal,
>>>
>>> [...]
>>>
>>>>>>>
>>>>>>> The prints below are just from fwu and efidebug for the ESRT table.
>>>>>>> Those will work.
>>>>>>> But what happens if you try to run a capsule update?
>>>>>>> Eg. efi_capsule_update_firmware() will call
>>>>>>> fwu_plat_get_update_index() which will fail,. no ?
>>>>>>
>>>>>> it fails on fwu_update_checks_pass() before fwu_plat_get_update_index().
>>>>>>
>>>>>> versal2> efidebug capsule update -v 0x40000000
>>>>>> Capsule guid: 6dcbd5ed-e82d-4c44-bda1-7194199ad92a
>>>>>> Capsule flags: 0x18000
>>>>>> Capsule header size: 0x1c
>>>>>> Capsule image size: 0x41434
>>>>>> FWU checks failed. Cannot start update
>>>>>> Cannot handle a capsule at 0000000040000000
>>>>>
>>>>> Ah yes, that ret 0; will never update boottime_check properly.
>>>>
>>>> I think the question is if this is acceptable or not.
>>>> Because none checked error code before
>>>> 583efb504058 ("event: Check return value from event_notify_null()")
>>>> and then
>>>> 353166279c32 ("fwu: Move boottime checks to EVT_POST_PREBOOT")
>>>> it checks it too.
>>>> It means in past fwu code error out but u-boot continue to work with above
>>>> behavior.
>>>
>>> That's also a bug imho then.
>>>
>>>>
>>>> Pretty much this patch is bringing back old behavior before these two patches
>>>> have been applied to the repo.
>>>
>>> It doesn't make sense to update to or run a firmware that won't be
>>> able to use capsule updates ever again.
>>
>> It means that can be consider as misconfiguration. Which ends up today in
>> forever loop (1/2 will at least tell now what it is happening).
>>
>> , eth1: ethernet@ed920000
>> Cannot find fwu device
>> Cannot find fwu device
>> Cannot find fwu device
>> Cannot find fwu device
>> Cannot find fwu device
>> Cannot find fwu device
>> Cannot find fwu device
>> Cannot find fwu device
>> Cannot find fwu device
>> Cannot find fwu device
>>
>> But shouldn't be there different action? Go back to second image or reset for
>> example?
> 
> At this point, either your metadata is gone, in which case you can
> either try to recreate them and hope for the best or an update broke
> the fwu mechanism indeed.
> In theory the board will automatically revert to the secondary
> partition after X reboots since no one is providing an acceptance
> capsule (or variable) so reseting should be fine.

It just means that I should drop this patch right?

Thanks,
Michal
