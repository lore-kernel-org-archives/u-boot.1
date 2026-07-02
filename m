Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA171C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 12:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 717D48496E;
	Thu,  2 Jul 2026 14:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hgC2Anc3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26D1F84994; Thu,  2 Jul 2026 14:09:44 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31ED8407E
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 14:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGbbej1lllNHy5jiRogi6bfxPop0rTKkpO9RaJuDA2cu1LEgRcnw89D3XVQzaymdTr/eOkpBU8yOcuwPpKLsx5FpoNY9pv15Oocd+Kvy+TLci5SntShh4bwWvk5RVVdsYgAlAdr04GCxeZH2KfDzlyMo5rjWN28rPgJCLhp9Qir1p+MSZreUTiPGaJjSYflEOA1boJDKezQU6KXBZ8Ex71YNjNon6p0tZ5IoXAW37fexk6C3zQfBwryVtpYetTAktjDYUpVY0YdjW0KkR7Z7vCEVxnrKJT5VWOJRA98cQ9YGbzvfaFvkP0uH/FBHVGfgf33MndHYJuRxxhP6VQWQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqBZvYXBpmE2rUrdf1CdHTsio7fkjFbbPiGrnXv4WM4=;
 b=LRv21m7s4f8MMFHHktRSh8nZthS7DuiPRAPE+7F2NCcqpzTctriSrQxE4nqH4grt6TLbmBwEoEC4TQk0/HOfNYI8d/3Y2Nk7Pj6qZxVUXiRwK76oOYu/chLpkjYs3hZUjHy97JXujBhg3aKyEh1l3+c4ahKbaIBNyjYj3N14nywYH5k7vL+cGqGKgFZU7ohxJxqSfYaGH5T1HlZPRDmrgscwZA+JVbrAkUbbAsgVMIJu1O7Ijt3uVa0ftrnp3JJrnh+FmOcXHWBKAMhljRs4o9ONRx46QY3CGd3MITtqx6qN4DQOa8cV5MbOyRG2bPt33C+7Z8W0fHZY64nTgTeBBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqBZvYXBpmE2rUrdf1CdHTsio7fkjFbbPiGrnXv4WM4=;
 b=hgC2Anc3q7DuupQQqTPjQBaOcOkwzOEpQwECaZDTYeEwPhgHd0tgC2JStplzUTSRpWE8ih9EbGAigPjkI/Q+rhio6a0ut65bYcPXfalrqiBeGEJNza/qcHYNfnMwChzMDrlBFkkC5WBCB+7ZEjsgRpAlRNGUTuilZIfP8VGfhhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 12:09:31 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 12:09:31 +0000
Message-ID: <a9285398-9e71-4767-a34e-2dc767c11538@amd.com>
Date: Thu, 2 Jul 2026 14:09:21 +0200
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
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWj+VqjpWPDRVGvCYpWMg4hmjeS1YzPBZiMvvQqvRRLe+Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0057.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::46) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 567ec733-916c-4b77-4c29-08ded832c5c7
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: IsQfxeKqYFdxGt0kq6psMAG+DU+IxUpZCQI6xF36UI/bVB0h+KA864IYMpmK7AAnXEYOuxDdhzh3iCBRnwexX1SkaZN2Lk+3tGmJ1y2y4zPdV7efvXB7bICFp5ROjdTHXZ1qr2PvhLtTFRo59i9rr5180h9zgVo54YwCtjdeCmSvOeM+cqQfOr6eDkROPh+apRw/QeyXIZdyTz1/f1U4bO4VYb81ykwekBeQeDkc0pFYNI4RWav5hAcQ+aFKie9+ds/hTkU4lP5/Bx4Bn4uZf5owLdbQUg6/C0JfykVayG+hdEN5e8gRPl623MUu6LYczz+siqPv8mt7H06ZagKCh/XFaG0vZbJBoj7uk6TbmKSb/gMK5A52NmtfrcbsiFyguUmRpQXMepf2BA3sAm03clgxtRx57zkS9bwEnj22M7iJW3j2+tlS1TT2Th047m5tT04Uvqx4Gb1NhQ4h+RL91lOIAZOrzjtdFemRVw4IVL63i+wJ5lZ8hZqA9MHqN+16HRR/WCZEM1KPcztSVQ83nsDKLB/SwXFaIPSawjNTyIr2E/Z7UDElRdsDSUe3sqFr3Gp5Q0uayKk+S4l31tLM//XZcYDO5ZzZDueWEMMUCWl33vm+VS1614H8R8NBi/KYFoGU7wBWLn6YAjJErt21N7jaZXlZqs9GH7maTHgf2gg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXF6MTJ2VGI1WldoRnJVNXMwS0Z0U0k3dndCVEt4TVRCa3NMOUE4aFBMU053?=
 =?utf-8?B?L3BSMzJidlBVWjc5TjVFTkxtbVA3V01lYS9ZcnlqMWQwUjA4SjljSG9PUkZO?=
 =?utf-8?B?VU9OK3BsQ05XUFREQmVyMnREKzFtcDRpWWduczNIM1BNbjVTS2hGQzlnaHRo?=
 =?utf-8?B?LzZPaFBlY1RseDZlMVV0VWx5a1J1bEhJcWRKc2hnOHVUZzd5WW9Gc1VuMWNN?=
 =?utf-8?B?VGdKQUlkUHlQVXFtQmVuVUFuWkNlYlFoTUFna1ozTURLb0tlRi9NTWZqTWRL?=
 =?utf-8?B?T1pEaktZY0tPZHRzaHRzK3FoZGUxZzBXNnlMNy9ndjQ1ZnpLSGRCU1BJYWtU?=
 =?utf-8?B?ckxnOWQweThyOGRQMDUvdld3WlJyWm0yd2tQUlNSZVA2OXRCclRjYzdETjNJ?=
 =?utf-8?B?enlRdWlPZlJVSGtLZHNHUHBTaWJCM1NuNEIrTlROUWpPTHM5c3pEMXFXVU9V?=
 =?utf-8?B?ZmprZVoyOGo3RmRzTVFyZExEQk4zaGdXNXRYMzRxZFQ2MG4ycGU0UEhCLyty?=
 =?utf-8?B?OGQ2YmIwaHV5WjZsRzlycGJMZXRya2ZlMUFhcnFXOEt6bmtOeW4wdjQyWnAw?=
 =?utf-8?B?N2dXazFLRTZ2NEVSb2lmcnJ5RnN2NkIrb0dicVZPMzM1cklDcUthQTg1aFc5?=
 =?utf-8?B?KytITmZSdVJGYkxvR2wyWGxIdTYxZ0VnZzU3bGU3OTh0TUFLeG5NMDdQQXN6?=
 =?utf-8?B?emt1VWdMa3JzY0RWSjRDd3Jra0VwV0grVnlQdVhPaXhuUndnKzNsVXA0RWxz?=
 =?utf-8?B?Y00yN1VKUVhpWlA2QzZkWVhRRmhsRGJYUng5OXdXNDlSU1lZSG5ySkNyV1pV?=
 =?utf-8?B?cEFlYjBDR2graEExWk5mU1NvKzc0ZENsZmlIUDFKVVdYTXFGdFd0ZGpzK3Nz?=
 =?utf-8?B?NFI1STRGSzhsMEtWd2hTTkE1UUp4U3Y5NEl3VTB4S1pZeklRN0lNaXdneGp6?=
 =?utf-8?B?MlJ0bk1XdUJ6d0JXMFo5eUlrK21KUlR4K2pMMmdHMEFDOEtjWjAza3ZUNkxF?=
 =?utf-8?B?Y3lkQ09ORkcwSDdUSWQ2N1RuSlJsY1lDay9MN05OT3cxRnVZMEhZTUNONnk1?=
 =?utf-8?B?TGt5UTlKem5vL2JyTk0xK0h3R0thTU9QcHVuZm9yNEJ1MVVBdjdZMEtIUE5w?=
 =?utf-8?B?ZjJTKzdIZjBWb0dHTHh2elpFSWt5RVk2Z3lqeHBpalZKeU11UU4vcG1hNGNU?=
 =?utf-8?B?VXIrZ3BSdFVWUHpteDdQVkZ2aFNJMW5zcUxyUlJJM2FlNUZaY3FyVnFZOTVj?=
 =?utf-8?B?bHJkRlBKMTlEUVp3cVBLaXExTGxZTUpMWlpFZEZROGRYcXNiQ0RLMUNPc3Ro?=
 =?utf-8?B?UG15Tm94VUdBMGtQL1JNZkIxSzVjVitpUFJzMmR3YmFINzdBZG14UDFra0Jz?=
 =?utf-8?B?TTNLSmoyQlA2MGVRelNXckdMYlZscW9hYWxtT3dUWmpFeEU5Qk5DOFkvVEJQ?=
 =?utf-8?B?QXd4LzUxeUlPQTE4WklUM1R1T1lCTzZXY1kvQTlxQnNxelpLN05PYWlKY1Fw?=
 =?utf-8?B?ZTl5cHJuT3FjRk9pQzZzR2VPYytQeXFvTkZmTVlpU1ZxMjJrZGhjZ3NkeUQv?=
 =?utf-8?B?bGxQbFRZN280VXlnSmNRSk5xcU1CQXRBMllUL29xS21aelFWb3dJeDYwOWtY?=
 =?utf-8?B?dExDSmRjdXlUK3JXb2FiNW43OTAxSHZyN0xuWDJRTlZWeU16K2FtUWtHck80?=
 =?utf-8?B?bXV0ZlY2aWxFYXdXNnpQNVdETUpOdDk0WGtNVVJDdDFnOVh2cmU5YlJxdTBi?=
 =?utf-8?B?WXZieTRwbnI2VElCelg0MFduU0o1eGFCVFFydWllS3dPWElWQ3NMWHZVdVNK?=
 =?utf-8?B?MHNHd0RPT1N0TGlpNUJXbjVya2MrSUY2UnJxVEhKdmdmajFKaUppNTlZaXR5?=
 =?utf-8?B?UE94UTc1clVaOW1ncjNWT3NrMEhvcldpSEk3SnBvU0ljaVBmY28xaHhZcTE2?=
 =?utf-8?B?Q0I0L2hyczI4RTkrWjIvajFxTXV2RFE3SzZnZFEyVkhUenp0SFVEY2F4bjdL?=
 =?utf-8?B?VWw2dWN4amhwNWhFMWsxWEJObzN5MlVGVy8vQzVxK3N6anlTZGNFYTByWWQv?=
 =?utf-8?B?L3JIR0NPb2VLT2xZRnB2bVNtdmJUSUg2UHZMV0JRVDgxQlV2d2dveVpwSHNV?=
 =?utf-8?B?UmFKd2tYalY0T2IrRmxTblpqWmtseTZDOGhoUUxRTUxYUU5OWmFtTkdjZDRl?=
 =?utf-8?B?T2dKaXZtU3h2SS9sU1FKNVN3UENOUUJmRllPS2NaWEVQVmxvd2JXMVU3RTVK?=
 =?utf-8?B?U3pzWjJGcDVxY0JEajdLaTlyRXQxOC9idVhZMkhDYVJTZVhJeWRMVHhhU2Q3?=
 =?utf-8?B?Zk1pZTZ4QmFQYkRFb1J1dzNBMTJKUjhNK1NYOGNTRnZoRkFkMlVtdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567ec733-916c-4b77-4c29-08ded832c5c7
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 12:09:31.3089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBMTsGoLM5VY+P4guGIhBuiYPsRNpRERgkv+5JM+BBZmGmVf47x8TvXSx+mbvZ+v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134
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



On 7/2/26 14:00, Ilias Apalodimas wrote:
> On Thu, 2 Jul 2026 at 14:55, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 7/2/26 12:07, Ilias Apalodimas wrote:
>>> Hi Michal
>>>
>>> On Thu, 2 Jul 2026 at 12:10, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/2/26 10:03, Ilias Apalodimas wrote:
>>>>> On Thu, 2 Jul 2026 at 10:49, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 7/2/26 09:41, Ilias Apalodimas wrote:
>>>>>>> Hi Michal,
>>>>>>>
>>>>>>> On Tue, 30 Jun 2026 at 16:18, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>
>>>>>>>> On systems with FWU enabled but without the required DT changes the FWU
>>>>>>>> metadata device is not found and fwu_boottime_checks() returns an error.
>>>>>>>> Being an initcall, that non-zero return aborts the boot flow
>>>>>>>>
>>>>>>>> Return 0 instead so the boot continues. The preceding log_err() still
>>>>>>>> tells the user that the FWU device could not be found.
>>>>>>>
>>>>>>> Won't that affect the board later on? E.g When you do capsule updates,
>>>>>>> updating the metadata will fail
>>>>>>
>>>>>> Do you mean on systems without mdata?
>>>>>
>>>>> Yes. if the config is enabled it will make the capsule update code
>>>>> searching and updating metadata.
>>>>
>>>> fwu mdata backend is not enabled hence not used. fwu just returns 0 in dump.
>>>> Updating metadata will never call any backend.
>>>
>>> The prints below are just from fwu and efidebug for the ESRT table.
>>> Those will work.
>>> But what happens if you try to run a capsule update?
>>> Eg. efi_capsule_update_firmware() will call
>>> fwu_plat_get_update_index() which will fail,. no ?
>>
>> it fails on fwu_update_checks_pass() before fwu_plat_get_update_index().
>>
>> versal2> efidebug capsule update -v 0x40000000
>> Capsule guid: 6dcbd5ed-e82d-4c44-bda1-7194199ad92a
>> Capsule flags: 0x18000
>> Capsule header size: 0x1c
>> Capsule image size: 0x41434
>> FWU checks failed. Cannot start update
>> Cannot handle a capsule at 0000000040000000
> 
> Ah yes, that ret 0; will never update boottime_check properly.

I think the question is if this is acceptable or not.
Because none checked error code before
583efb504058 ("event: Check return value from event_notify_null()")
and then
353166279c32 ("fwu: Move boottime checks to EVT_POST_PREBOOT")
it checks it too.
It means in past fwu code error out but u-boot continue to work with above 
behavior.

Pretty much this patch is bringing back old behavior before these two patches 
have been applied to the repo.

Thanks,
Michal

