Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D65F33809
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 07:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84FDE84132;
	Tue, 17 Mar 2026 08:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FdbGuFh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA3084137; Tue, 17 Mar 2026 08:53:16 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2415084129
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0z2cgPe4gImJW9R69pBViuBXnItXB8Cok4AY2kv2oPXyY6ay686XB5nYLu3ew6RD9iHODhpFLmQAxhAAI8t5PGPaKLYDnHAIaDQaqvkpUbMR2tdz839z4bfoRjDOMDNy7Pkg5mRn7pLy8RP0wiXvbDHzK1YfEh6g1zFhhmb5/GGmFnRKCFnt6KLVmEJAiB54usuAlpTtNXxhlQ1CK7s0cGFxH3lbepzwhGh4d1M5upe9e0gA54BqSU0DuC9d0oPpRYh1xvHqccgnHvR8nlna2f/tA2EcUZFhJ9DZ3LMSbF0HTzddtV1whIi1833Z7YlrtUWWsd8YZaHm2xzG0mW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhgQgbITnLlML3JdZ0X4iyZydQ1Mqnw+bMdXJwLI1LM=;
 b=jwDT8IP8cd6o48ufhBAYlzBHQLs30aoMNs9V2dwxwoA9a2vDNJd2zd/rz98D+j/vG6HFWSjN++LByreeCvmv/BU8w2Qy1EHpd9cOdze3oA+61HcSF6cglYvaxmPyLOJle3aZceVo1wGCd42cMzKsIRPJiJU/HcghF0k67EBkOvQLRNQXVTAO0gvqXmHSAbv60YWbMMyO6SMdrlzmvDwbYJvHp0lPC+UEhOkhXqPf+oDTei8NVrj9qLKN9qiXXSPd7ACwq7gODAgePz2SQrmGxOqejxT/hstFaZCDP/hjdZ+W1vI4kRprgZGLGL51Ho27RRbko93RMJcgBSFE63usdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhgQgbITnLlML3JdZ0X4iyZydQ1Mqnw+bMdXJwLI1LM=;
 b=FdbGuFh1w4MoH482obFf1aZI+NbEJuzI3973Gsrd3CqHDyo/dpLP69n6aXv9+6I/31M1iI6jkVTrA+Q4JPW0r7SJEZC2djsQVoZARYknyEN8v3G4qyKC7/qQlmv3zoewIvzu2QjqMCl0HYMmAjETUgct+hwGmH2pZV8rATCzb0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 07:53:03 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 07:53:03 +0000
Message-ID: <db251edc-8001-4c71-8187-8ca9c72a350c@amd.com>
Date: Tue, 17 Mar 2026 08:52:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Allow disabling ANSI console queries via env
 variable
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, git@amd.com, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
References: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
 <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
 <CALeDE9NrGF22D=3pA_JDFxmxZ8EiDbmbng9zd0Jr-k+JPx1dPw@mail.gmail.com>
 <d0f0d10b-6d44-427d-9e55-103d5fd0e107@amd.com>
 <CAFLszTgdogHiTDpuwCiu3k1yA=x2-z3GxeMgj69qbpJK-s18Wg@mail.gmail.com>
 <65bb681d-b66e-42e0-b848-fa132e6255d3@amd.com>
 <CAC_iWj+c0xSeGXdB7gCXcZneF+nbORPV3i_i6S_FeUvw=PFK0w@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWj+c0xSeGXdB7gCXcZneF+nbORPV3i_i6S_FeUvw=PFK0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 78672b3a-134d-4257-b8b9-08de83fa379c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: GIbgr2dcY5hwvCVKQZY1c+4Elk2V3/lWNAVmNvY0lQLqW2UyeMlTFYAHCt7oZ587HCtUey5NzL2MB310+WFfzQAmA+VSUQzAG3fH0QhEHDo6JMdXHPqsCMYzluMebUm8n+K9Urmfnlj+u3tKdqQkzuzhiGCKMOZGUnU30JNWgCqjxaUIJgJn9zW1WV68h8gfqyUp5bihUT53Paa2/pnUqdNzVFR3rj7Ur80caCW+o9xRHBQUz1O0g9//QWNrqnJXGR5XJu2yDBJ9zRHMFgw230tTq8gRQb4I6UZtpAb7UkeVWHj665/q9nSLggmdLDCd8VVVH5NX5twyCFcHo2SWcxBb9LR4fNdukUdoUznxRCaFQxfwN5YrQLMbQ3M30s5TOi47kNtVOCekK1/mAVAaZd9jawZ74cJyalRq+i1RzP296znx84PWzwSaCLEg6v3xCy2xRexoaWJYhDr/2ZDMssOgha/SxO2Uw23KL4TScX2M91npwLBobUISvbR/+OBoBgBLyfqOc+yo0x5q+7kFA5/c1Ht/72cOvXxq8khTEoIfa+8DDRyLNghl+ofE8mO7UpvV6M81nde+CvGX+/hpxZuxOX96Kh2Kqy2khomeRc+Md2m00FYjwH1jSqfuTCrdymSXzqi6KmHgojOMB/ubaJioCdDo39TbHSCPXGkvDzs1cQcZW3K3QPa/dAmqFRjhwynhZEjPUB8o8EdYTTuaR1G+xw0I8D41OWQfPHXlxBHT/mUR5rPGCb6hyCtC5kTn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y09RM2ZaNkJjZ2haTitsb3M3ZnlaVkZvYVJVVisrbnZuMFNoZGhzS1UxcUdw?=
 =?utf-8?B?eEhYMTlqTG55TElIN3UwUThQU1h4Ym92cVJjRXNTWVNXZHlGNEhCS2VOUUxF?=
 =?utf-8?B?Z28rZERsemRVSFIxcy81NExHSkVSYTZLZTJGTURwYXFScVE4RXVpWC9ZRWRZ?=
 =?utf-8?B?b01LYS9qeXBvcjUwMEdoN1dITG85MG43TXdEaWhWTk43b0dEc25ESUxMQjBX?=
 =?utf-8?B?VWRlZVRxbmFjdmh1YWJrYjAwdm5RN2hvUWtPamNGWGJpTTRQb0s5WkhpdlZj?=
 =?utf-8?B?bDJtS1JCRElqV0dYSnBuS0d1UXFZUmY0d1pBZ0hjQnpITjZNRmhiUW1yd2lp?=
 =?utf-8?B?SGNmbjM2NUliR2p6eEVjeUxJcElBL1hUSkFuam1iTXU4MURFMlR1d1JKbU50?=
 =?utf-8?B?UlI0NTlPQTFIYkZubERTOUFySUQxejJLQVdPTkg5eDNqa1hvNTllTTMra0E2?=
 =?utf-8?B?dTJyUEdlRDNCcTdHZVgxcDVSckNxZ3FHT1lRam44TFU1a2VjQlh3amxEdmZQ?=
 =?utf-8?B?ZDZkUWFDRkVMWWlLRVhNOU9obEkrNmNjS1hoQmMxSWMxMmtsUEtvQ0U5QkQx?=
 =?utf-8?B?TGtmV0ZMWmpWM1BqanRKSlBjRkoySUNDbndEMEVNM3hmNHdTQ1ZwUW8yNHUx?=
 =?utf-8?B?aDJMSE1JcS92aGkzamc2OTkyNUlVdWZDd0loUGNtSFhRc2VEdmx3MFhHTjJn?=
 =?utf-8?B?bW1UbXhOZ2N5RERJa2xqcCtTZmVGbWZoaG54NkgvWms1QlpYRE1CdXFjMDZ2?=
 =?utf-8?B?M2x4UDNsdmZsKzZpRzJEamFDYVhJMlhtT21jeVNMODVuQXV1YkFYZDlmZFRi?=
 =?utf-8?B?U0gwNjdCM1l4YUZhdStFeTZxbWIxRnJvWEQ3SFlyUUhNZkNNcnFYdzVoZStM?=
 =?utf-8?B?Ymh4bEZDMUVkV2FsM3l2V1pqSkZIY3JDMXVvU3E4SFlWUWh3ZUF5QVFpSkNq?=
 =?utf-8?B?bGREdkNMc21BazZvUXYwU3FHN3NYTWp4eEt2dHJqWWhUNDVhUktjRnA4Z3Yy?=
 =?utf-8?B?eW9SS29CbDBiVkdEcDJQSFZnamVpQ3Nqd1ppa2gwaUhRS3ZKb3hsV3RhZEJv?=
 =?utf-8?B?NDRuSjFPcUlSTmRZY2lEcENaL1B4TmxBdVNkMTBycUxUeVNzcVBnTzkrUnlZ?=
 =?utf-8?B?Y2JmNWxhR1Bxd2dMSG1WMkVLcHI3VjRUK1VHSDM5a1RmM0hLc2VvajA3c0th?=
 =?utf-8?B?RUZRb2IrZ0NXWC9XOGYzSDhXV0phUHJLaTc1T2g5RklJVkRKQ21FeXVrWFNk?=
 =?utf-8?B?NWhuMHBWd1V3eWNCbVJRTGRxdlg5ak94UGJhQW54ZEoxdWRxR0QvMDhRd0Za?=
 =?utf-8?B?NENBa2lrRWozR0pVejJOU2ZMZjdmalJVdXNzbTZPYWgrcjAvNDRuSTM5aVNI?=
 =?utf-8?B?ZzlZUkxxOC9RaVpVSk9lZnIvSW9NN3YyVkVOU0FETXRWL3gxNDBkRTJUUjE5?=
 =?utf-8?B?RlVMbkJVVE5sNmVjU0lOMlM2djVWaWlGV0FtNkkwVXpRS3dMS1UwcG1TVUxl?=
 =?utf-8?B?SkFUYnhkMmJuMk1GMC9vcVFDNmFsSkNiWU1jalRKOFB6SU1WMmlOa2RqM1lT?=
 =?utf-8?B?a05PRkk3VWRXa0xnNGVzVzltSGErbDRhTnN1WVNmbm9rZ0VEYU9nK1NXQ2li?=
 =?utf-8?B?eTdNdU9QNi9vQ1lqa0YzNWd6RVd5V3FWcUJSc2FuN256bHdSREtCR0gwRjRt?=
 =?utf-8?B?SUozT3BRV3JJN2hBcEtmbzNmc3Q1RWJXeE1qRXd1aTg2SWVic1czQ3lyWTZ1?=
 =?utf-8?B?Tnc5am9ubkRxaXBOZGdGU085QjV2cExkY0lqVTU1amhJeFhWQXpmYjJwQ3lC?=
 =?utf-8?B?RFlqYWl5S2drbU5sOWxjeEVVYVEyUGFXY1ZPYU1UY1RnSzUzVC9DUCtGS0ZM?=
 =?utf-8?B?Q2hRSkd4WnF4U3pMd24rdGRzMVNya1RqZ21NZkNSNGR4bVVxQVJuZU5KYTdt?=
 =?utf-8?B?WDZGM0czUG9FUUhpektqai9CWHlNYWlNN1hzSTA0aXdBbG51UU1WaHl1NVVl?=
 =?utf-8?B?LytNZnRWRUgxYWd4QzlZcS9GaWx3T1RoUDRQQ1ZLb3hpbGNibXI0WWJLRlIx?=
 =?utf-8?B?VjNJYmQrekp0ck9pNHR3TkxxZVNqRHBMRU11eTUyVWJ1bFp5bWxuVW9Xcksw?=
 =?utf-8?B?WW9uOXRGaUtOS0lRemIzOGJsUzA0ZWQ2b0NSd3pBQ2RSMzZrUkFSU3NGaDQw?=
 =?utf-8?B?eTM3ODFyTHpBditJdWliZExLQTE0NjVxUkJDcnBScExHM054UTNUb0txbUhk?=
 =?utf-8?B?dk12UzdaRmVNY1h0M0pZQXFEYU1EdnpOYTFibVpVdlhRYzExUkVYMXlncGZw?=
 =?utf-8?B?WnZOY0k2OWw3bGhWdUlvcXd4MCtXN1lKM3VnOWlIKzFYbk1Xbm1qZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78672b3a-134d-4257-b8b9-08de83fa379c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:53:03.2460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmGU8VQWRYK7U61L2O5nPl+g4th9o6YOV4DKMi9dW1MEEwslqV/FyqHMGkIBnRhB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479
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



On 3/17/26 08:43, Ilias Apalodimas wrote:
> Hi Michal
> 
> On Mon, 16 Mar 2026 at 09:45, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Hi Heinrich and Ilias,
>>
>> On 3/16/26 03:43, Simon Glass wrote:
>>> Hi,
>>>
>>> On Fri, 13 Mar 2026 at 09:50, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/13/26 16:47, Peter Robinson wrote:
>>>>> On Fri, 13 Mar 2026 at 12:55, Ilias Apalodimas
>>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>>
>>>>>> Hi Michal
>>>>>>
>>>>>> On Tue, 10 Mar 2026 at 15:50, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>
>>>>>>> Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
>>>>>>> introduced efi_console_set_ansi() to suppress ANSI escape sequences
>>>>>>> during unit tests. Extend this mechanism to be runtime-configurable via
>>>>>>> the 'no_ansi' U-Boot environment variable.
>>>>>>>
>>>>>>> When 'no_ansi' is set to 'yes', efi_console_set_ansi(false) is called
>>>>>>> at the start of efi_setup_console_size(). This prevents
>>>>>>> query_console_serial() from sending ANSI escape sequences to the
>>>>>>> terminal, using default 25x80 dimensions instead. This is useful for
>>>>>>> platforms where the serial console cannot handle ANSI queries.
>>>>>>
>>>>>> I am fine with the patch, but the no_ansi is a bit misleading reading the code.
>>>>>> It really means don't use ANSI queries to detect the console.  So
>>>>>> before creating an ABI to the cmd line should we really call it
>>>>>> "no_ansi" or perhaps "no_detect" and in the future clean up the
>>>>>> variable names as well?
>>>>>
>>>>> I wonder whether this should be a Kconfig option too, a maker of a
>>>>> device likely knows when this is an issue on their device and
>>>>> explicitly enabling it via a config as opposed to an environment
>>>>> variable would likely be useful when there's a menu enabled and the
>>>>> shell possibly disabled?
>>>>
>>>> There are a lot of Kconfig options and variable which can aligned it.
>>>> It means we can create Kconfig option for it but likely we should also have
>>>> variable way as common way in uboot.
>>>>
>>>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>
>>> It might also be worth reconsidering this old patch:
>>>
>>> https://patchwork.ozlabs.org/project/uboot/patch/20231121113557.800353-5-sjg@chromium.org/
>>> https://patchwork.ozlabs.org/project/uboot/patch/20240815202424.766778-11-sjg@chromium.org/
>>> https://patchwork.ozlabs.org/project/uboot/patch/20240902011825.746421-11-sjg@chromium.org/
>>
>> We have met with this problem on real HW last year and based on it we created
>> this internal patch.
>> https://github.com/Xilinx/u-boot-xlnx/commit/29b1330570543056188e5c065f1ea1be064b3a4b
>>
>> And we also send it out
>> https://lore.kernel.org/all/SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com/
>>
>> That's why I would like to get clear guidance which way you want to go and how
>> things should be changed. If you are fine with having variable/Kconfig symbol to
>> disable it, then I am happy to create a patch for it.
> 
> Ok thinking about it again I think Peter has a point. Having a runtime
> option would make sense if the feature would work at some point. Is
> there a case that you would want to enable ANSI sequences? Otherwise
> we can just turn this into a Kconfig.

I just want to have a way to disable it. I don't have a need to change it at run 
time.

Thanks,
Michal
