Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038FA1093187
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 08:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A810083FA4;
	Fri, 20 Mar 2026 09:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eJQewh+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7110D83FDB; Fri, 20 Mar 2026 09:32:02 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FE083F8A
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 09:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOkli+RKU7ZbFSDZJOiLrWWepeg2Tr6PkQ75qisGpZSSOJroGPs2eTvGuf5DZcqPYXSzNZRbynxGb2gCTI3jXuo6aUgEtUN7h78uH9o5BVnPYNlOVcELE4Zi8BO6l5sXZD1h1W4CWFN+f9nv4ehGY1Amcxac8+HXDKNxshGJKlgbDEP4VKRLToov5IAsTg8GLruSYgSLlQMKfuHwfAf/RH4dqJllexupsxxUDKAAm7y+MVQubyZaE66qr9ldNzTxg8WFejft65Qsd3rb4LNjl7NrogUQlh8P4w6wJjMxqgReYtoduCcH9InJpJCYxXcT3KzTxtIBYSp6f+IrpXiFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqb3Rl5ZzMWNMc48feRpZMXZOIQSKamWp6URv43aHvU=;
 b=AmP5a8jLszXu+QBGr1/WV9LHbs98BURhsPeZI0sVt9vZLv+D1ePApxLGldwLSudj9+ifLSZGi9Aakd8pUzupb1vvlMi8dnnJIbpMCdip2OL8UWjDSkJ7RqXuGKCTfBPGWj+5CqFjS0MqJv2NtXLxs+W5wXyjAD8Y4mvsMgbCitSyHtDbBCHF5HHljZ8zUYIvxDg9zFES94Hkj2ZEH6xaLYCn7xGog+5tgGplT+sefR+ktOBWKF9/2zID/G1PwSY2QJeWL5GLSVppfwJIESqO36H2IkMX65rdqozNkwYUMdkFe5O9m9u9b8kB9vUKu1d+aCQSt6SZcdG4K3CCnL5kMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqb3Rl5ZzMWNMc48feRpZMXZOIQSKamWp6URv43aHvU=;
 b=eJQewh+U4Vbfh3nJDS4YGYWD5R6C9yU7kx4B7FspfJlPjAuDvzEFQu2xtZeJvHjoVgwwYASoob1XT/CcHAbxuAicP0jtfHnHAUOKP8khdcwNbX9jq81JePoCc+14IUsKhRDMYMbgJxVDQOMLyZYVPsqL5bWrxUdRF/VQYPLUWao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 08:31:51 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 08:31:50 +0000
Message-ID: <7ab5a2b5-79b1-4521-b4d5-0ac1e0f8d683@amd.com>
Date: Fri, 20 Mar 2026 09:31:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] fwu: Call EFI stack initialization after preboot
To: Casey Connolly <kcxt@postmarketos.org>, u-boot@lists.denx.de,
 git@amd.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>
References: <cover.1773840306.git.michal.simek@amd.com>
 <bb3d0a9a-d1d6-4dc7-a583-205602181572@postmarketos.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <bb3d0a9a-d1d6-4dc7-a583-205602181572@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0071.namprd08.prod.outlook.com
 (2603:10b6:a03:117::48) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cfdbac-b29e-4c3a-e746-08de865b2237
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: jWlLjdMKemi6qbPmpgyAiy0fjTF6Zqdvqzzld7ERQgQPWlw4CmEOgWUa8baRhHpF178dOIICelTRVL7pXDK1RecD9cMWjLsfQbEjNPKJTjxIaUbvUw1+HUqK26IICPaVHhEWcD4Jq/fPqIh1a0yciK1FcfKmm0YSv1Es/xEA9e8OE5OIqia4hZeak8B/spUopfPECNC/A0Ygpy6oIgk8EHxvGtiE8ajF+knFetqOn0JfYBGiyYzs1p2sZTtFloMz0N6pTq75OyIKN26KBdo5CS9KlSqKtbA2KhtdX9ad51eiVwUVo1H2clVuOx9pZDygz+mE7GlrU/dab9VMcHD0Z8/XtT45uyclKOFAIpwhH1SsRNFmP+7HHA6YVrt1TT9DMaw3Soeh8gYMpo9QO9mJzvIS/PhGZDiG3vspsgf1VD4DmF6gALgivCUTYspMxs0GeIxyMHdBcHkE1McjIQK33DeRIbsv0TGdct96jxHIi1jVezdTYLku/4NYtUlI+oceURlH/H6ofequo1qZLwpY4e+/uE+Mq0ixZQrJolzgFTzAAUj6EBSwe2uaF1NbqVTVkDi5qVBrazmckfOvISXsfPF1HVA58LrIMgnfnmHVHzCdNn6o23FN/qg8ap6yGbKxBH8ER6vKHM4E0J8QsB4cZ2ZcHegCc3OIhOMKIMfIBmTb5fbT8YlOZpYtXgFC4zSq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGd3TXNTNWZCQ1JXSU45RVpYYTc5bnpLaGJnSkFYdUpVNFF3dGFwMDBwa1RL?=
 =?utf-8?B?SlRYQ0FNVXUvNTNDYkU4bGtRaUVJbTd4aTBVS1B2WXJIL2syN21Na2xmN1dj?=
 =?utf-8?B?SzJrR28xMnNDQTJtaTJ0Q2dRT2theWxyNmI3YVNRK0UzTHpxYjQ3Rkh3ZSsr?=
 =?utf-8?B?VkxVbmpKWncvTHUwRlVEL0wrODRWdXBMcnVXVEpHc2tiS0h3Q3IyYXM0cFg2?=
 =?utf-8?B?UkVUbjJ5UzgzK2N4MHlveUhKU3NvN1o3TDR2UEJLUFp5VDhiSVk1YjVUV2dR?=
 =?utf-8?B?Ym9zMkl2ZkhoSnZwSTBqSzExVy94MjlWZmYreks5T1dqSEJndXQraXdJdVc2?=
 =?utf-8?B?dGU3ZjNrbG9HSnNRTzdxTkZPekEzU2I4UFFQMjJydHhqakd3Z0YwbnhzMVNj?=
 =?utf-8?B?RThXVyt5RkYxbnVYTWNFQWUzVlNCaDN1cEVQT3pENWxaTTNvQVh4UjBNK0x1?=
 =?utf-8?B?aWxLNjEzdjUxa3JlQXB3UUdKaFRKc2dGUDNoVGZHR3NXTnViK1UrYzNIRXVx?=
 =?utf-8?B?M3BHbHBjSXJKVFJ5dDkzcGZIRVpjeEU0eU5vZHVzRUZxaGJIWjJkVlh1eHVu?=
 =?utf-8?B?OEZScjltK3JlalFsN2ZPbXcrL05XVncvVkp6TzQ0OWFBNGxmdWFBcUthNk1y?=
 =?utf-8?B?Q3JGUjMwRFhodmVoQllJWmhFWmVmUTlKdWcrZkdlUEhWY1ZQNkFBNDlVT3RR?=
 =?utf-8?B?OGlvSytOcERnRHhiMFZkOTRhZmFPZjk1TWpkcmlRdDEwb3hFR1MvMlRSU2Fu?=
 =?utf-8?B?bVVWSVZ0azhmbjZJTEU0b0greXlCamJHQnhJdUdDVm1vVER5Y2hzUmFPK2NY?=
 =?utf-8?B?NkU4aTBPd25EYVJFNWVESVkxZ2tTaWVHaTUyNGdIVkk3Y2lha0tjTW83S21E?=
 =?utf-8?B?RTZpVGt3T2hNQVQ1bGlFTTJuandWVEFjcVNpMkIzbmZyeWc0elFkZk03Umsw?=
 =?utf-8?B?LzQzcW1pT0xQb1dEU2xqSEg1eGNuRXFhMUxuejJvSkFWblNVanNjREVVdEFC?=
 =?utf-8?B?dERoQkhSVTZDeStGTS9LSWlZVTdUSXgwcmJDektmaHpFTHFhbEFRNnB4YzMy?=
 =?utf-8?B?M3FmbXFmZ3llclBUM0JadHMxRVVLRXROQXdaUmkxbVZKMjR1Q2NVSkVSOGQ0?=
 =?utf-8?B?N0YvMUFwSTZsdEY4U0ZqYm53cEVYRm1kd2R6NTRwUzlabmdMem5yaCswcXJs?=
 =?utf-8?B?N2xIZGdhY0VrNFM0MnVDUmZ4WTdJeGJoUHVLL2dkOTc3dU45b0I0cFlTRjhl?=
 =?utf-8?B?TkhBZmlLZTNPSzhNTnhoKzB0cDNrY2VBUTMveGtaTjgzRFNDdzFWL3h1VVR2?=
 =?utf-8?B?YmFhMDFpMkhCTVBaMHRTcVl3aTRHYnlQR2VTTVZoWG5oY0lKVkVRV2dobllV?=
 =?utf-8?B?T1V5OVI3d0FiZUdEQ0tadVFKSlIvSDRrSDFtSlk2T1J4ZUZmQ2w1UlVQUnN1?=
 =?utf-8?B?WFE4NE8zbytMNmxWSE41V1llQkJKMFBrT3FHSEo0R2FXQVhPUkpWYTNxN3VF?=
 =?utf-8?B?S3Y5ekdzenVSRTRpeE5CQ1pKWWJTUjc0aXYxdWplTm9YMjl0MVB2MzBBRGl1?=
 =?utf-8?B?cjhwaFcwQ0Z5dTl3dGtieUVLRVZsVUpUL1hvSk1hWDY3aVFpNjAyZ3JDT3F1?=
 =?utf-8?B?Ukl0N09FWEI4ejl4VHA3ZkpRa085ODJyRmw4QzUzYnBUdlFWazVJdU9vb09Z?=
 =?utf-8?B?ZmJoK01sMHVxbTVnVDd0THk2MEgrdENjZnkzRk1RUExSSjZZU2hGTll5bWlD?=
 =?utf-8?B?MngxZk50bU5Ua0t2N0tEWndBYkFSczM0bkd3YVlGZU9BcGRjMGJpWWhtQU5X?=
 =?utf-8?B?SUQ1Q2lmZmlvWXh2MzBRakY5NG9EZUFQN0pKTklvZDV6ZzdvTGxvNSs0OWJD?=
 =?utf-8?B?a0hLd3FSMUg1VnZnTHFnUWtyNjNFY0hLTnMwNWxOWnJZa0Z2bktMTWtxY1Jl?=
 =?utf-8?B?Wm14bHVaUDZhYWx2RHRrM0dVK3hLeHRManFWVFJ0YlNMU0VpWEVSdk5HWk5r?=
 =?utf-8?B?Y2NBc0R1YWZIY2M5QTB4cENNSFAxcDV4eitMLzBrWCt3VTF4TnpJVzhlanBM?=
 =?utf-8?B?SUxadThvV3h6WEV2TmwyQkkxWjNDUGc1bWlzc3Bha05ta0prMnhxbDNFc0tr?=
 =?utf-8?B?eWZscjVHelpqZEZ0Q0JRSXNIUDZ2NzJkck9GWWFzOVNWenBTS1paSTRKNzYv?=
 =?utf-8?B?VnZuTmM0TWptZXNVMmRNa1lsK3pyL3ExcHJFL1lKM0VLOFlCZDd0RGt6ck81?=
 =?utf-8?B?cnFtOGNWTVd3VXdHd0pUR1cyMHkyd201MzVtNmNLV1Y1RUVtbXdpckVFZENT?=
 =?utf-8?B?WndtcnQxY2RCK1ZkdU5ZQUtLZjd6YzJJdkI2WTFXMWgyS3Y2bGEydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cfdbac-b29e-4c3a-e746-08de865b2237
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:31:50.8375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bs9e0Ilv5vq8dCS4C6NbxRwr7K1gvGf7NLKYm5CsodsJF3VSIprKIRQ13VIvnspp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587
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



On 3/20/26 00:56, Casey Connolly wrote:
> Hi Michal,
> 
> On 18/03/2026 14:25, Michal Simek wrote:
>> Hi,
>>
>> the whole series is trying to address issues we have on platforms where usb
>> and ufs init are not done before efi initialization. This is happenin on
>> platforms where A/B update is enabled. FWU code is called early and do EFI
>> initialization before usb and ufs started that's why they are not visible.
> 
> I guess I'm missing something here (but I'd very much appreciate an
> explanation!) but isn't it actually necessary to set up the EFI
> subsystem /before/ register block devices?
> 
> Since EFI sets up an event listener to react to new UCLASS_BLK devices
> and create EFI device handles to represent them, it doesn't create
> device handles for block devices that existed before the EFI subsystem
> is up.

This is solving different problem. This is related to FWU code/update capsule 
itself.

There are two options for automatic capsule applying.
The first one is in main_loop()


  62         if (IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK_EARLY)) {
  63                 /* efi_init_early() already called */
  64                 if (efi_init_obj_list() == EFI_SUCCESS)
  65                         efi_launch_capsules();
  66         }

And second is in efi_init_obj_list()

385         /* Execute capsules after reboot */
386         if (IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK) &&
387             !IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK_EARLY))
388                 ret = efi_launch_capsules();


And because everything passed on the first run when efi_init_obj_list() is 
called again it never calls efi_launch_capsules().

240         /* Initialize only once, but start every time if correctly initialized*/
241         if (efi_obj_list_initialized == OBJ_LIST_INITIALIZED)
242                 return efi_start_obj_list();

It means when you plug things later capsule update is never automatically called 
again.

These 3 patches happened based on my discussion with Ilias where we agreed that 
there is actually no reason to call FWU (which calls efi_init_obj_list() first) 
that early.
Calling it later postpone efi initialization which give us a room to do 
additional steps via preboot.


> I ran into this issue when I wrote this patch:
> https://gitlab.com/LinaroLtd/qcom-eco/u-boot/-/commit/e3616009a441358bf96bd2885d77fd46df710a9a

Then please send this patch out and your patch is likely solving different problem.

Thanks,
Michal


