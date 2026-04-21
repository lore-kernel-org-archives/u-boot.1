Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E521F8FA8C
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74DB83BC4;
	Tue, 21 Apr 2026 17:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4JJ219Go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C7C840D8; Tue, 21 Apr 2026 17:24:28 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197E583A91
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwL5YtgGEJD5t11jcRCogvLw6jJ38+voF7PEkAPWpbmyPufPKelltyMXXTG6gybp42BGO+kaELF92W3HpNIWnRehfyq60EmwELZVu7hBNOEfqX+paj7G9rNMiBnOJvX1Q8UHPZynSq3xS7JzMizqOzogFpa8/Cii+HlY8Y2B5d8C57GbOfR/VRzLo+AJwniFocwDD+7C6k17EYwHlEfK05g415y4hTgZFk1Q6EbUerZtTzONchtqyg2MWTMazdRtX/2tQrEpDREnhassR93LkcpexGMvvOEqRbPuGFz0qFiWmDGXt7s1lhRJloCZx2zW61ltYanu8Cs4jH7cZO0FxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsLKn/6vHvvy2HUZz9AKiWEwq8ODa6qZXk0tU4Qcoi0=;
 b=byv5mg5DJUzaIOSGx7mBgXmkN05RHIsG5UTshx3Q7Q9GULVv9X8DmtVCW30uPbNjXdIUCSDIL6qZMdBhxc/fxpRnyWSqwA++gs+q9g593pMhDfC/NhnBlc9f5ObD5z7ACJdev6iOFIK3/zVYAY6IgZG2EsCZcPoxVE8yAuhD1UW8tmWSPrI5MISrnzLEuKwpSsKSWMiOcT313zWtgmiOYsXtzxeNzKAKP1i1CiaTsPhcYvREYiH64ylICCDpEJA9jwzQf9YAxhmlSlwC7isQObbn/ijXcE2Ff09+r00rMeXl1mHHeyl2kfXpHLRpqfWRqSWBJXeyqvdEfp5sjCaFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsLKn/6vHvvy2HUZz9AKiWEwq8ODa6qZXk0tU4Qcoi0=;
 b=4JJ219GomOfjT7YKhhTR6JqsRkhrPvbixwO0NQHkf3KvYidi7lYCIZPHtN33HUxCGKzKbKM3VdhODTowFDQ6pvdTu+ws4qTbg7zxR55u/6/aNVQyGfNLYM2WqOrlFektDXLUe5xKPd1pHU+zrkOqCmVK0bGwJ5LOh8aDC80aNzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 21 Apr
 2026 15:24:17 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9846.011; Tue, 21 Apr 2026
 15:24:17 +0000
Message-ID: <16666a0b-e5e6-496a-ac60-32cc3423a819@amd.com>
Date: Tue, 21 Apr 2026 17:24:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Add support for DT overlays handoff
To: Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, venkatesh.abbarapu@amd.com,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
 <696b7f4d-e192-44e4-8652-e8db7f980507@gmail.com>
 <1a1f881c-bd6d-4677-af87-1c73bcac3dca@amd.com>
 <CAMDkj5z7xKkuSpnn45Uvcb0j68wqXt92eQu4FPCC2FARcQu4pw@mail.gmail.com>
 <20260421150313.GA3036003@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260421150313.GA3036003@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::40) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4e3e99-ff20-4bf5-bd9a-08de9fba0d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: TCEVRGwByExN6X/82nlZp3jUikm7X1qiLR0/xuvlxlxr/JwWm3+S4SQ22An36VQpfJY8TBZ9PTrumzaVmrnoK1Cv7ln6oECRj135C01IQSNhd60iLOMgCm1ajdXa1rUsEEPn6PQuymOfXJ2nrJy4a7tqHY5NpgHrWjtTKorQ2xYtEqhfrLGTDwTHixTQo+s+IQJ95GBZnZKnY9tQ2zq5ca3m86+4w07HnpIoiiutpItokx39ImqB8usgkLTqJZ9hq2/GhQnimPFaNiSChZ/HznPX/ro0LK96j0fGAlh9Xut6kpXiSQF/NJUfp+2GvX6k2W9YCKkCAUI8CebhEUy3GDhQSv9u09wvDZKvhWu+KeuOFEN2dJn0kjWETUHdZaYgb1/9m0ibDiiP9twbCzHJg45NQUEoa0/c9Wh02qhyPpYijYhPETPgZelMzmzATloTgxanfZeGUZDtyYQOTV9IstRYqze10VscjL1j2KrSJnfnI7eXDp/MUqZdg9hy/wcalfJLsKuXwAQ6mhf5aWYO9+I+sLptHA6c9TRBxC5P3qu3Yfe5jaVNN6jy3/UGCUl42dQI/l/xd7PoKsFdypSTGTrsr4gKw2vxCvwX+h8yJ9m20ccE3zi+B66QBHARZaE7/7HiJbR7pbvADuJHxoVFw7DwSMLzOZ7FcdUtEsnTXTaIoepxy7V83rKtuwCWcaWjeeoV0cxwHcJ9Id1WlVt7k8MciJO1jspuX0ja/vbDtVNFN6he/Kf5cX2pvaVm7eoO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0xrUk55MGw2WUhWczZSVU1MQW0xbEM0NWRyWEZIT0FaZlNWUWUwMFkwZXNL?=
 =?utf-8?B?TThaLzJ4Tno0cW5yVUVPVldJNVNPcWJ1MFVHZlNGZjdmQnpxazRVVU1BQi9v?=
 =?utf-8?B?Z3IzQlFvNy9FVGNESmZ3a1dmcEYrRXRLVGZlZkg1SGFwRk1EQTlSdXNPQ0ZW?=
 =?utf-8?B?NUc2cFFETlhZYzZROXN5SFZ0YzNpaDMxYnJtMXMrTlVnZ2g0Ky9YT1NmWjls?=
 =?utf-8?B?QmNOcUFTWHFkbXBydEc4WmZ4ZFRIV3BYdzB4NnFyT3k3OXJVNnZjcGJjMFFt?=
 =?utf-8?B?dFB0ZmtDRHFqOTFRWCtaY050SzZYM0JnWnM5cDRQMGQwbkJVamtha0dNT3Bi?=
 =?utf-8?B?bC9nR0FMU0xOUC9WNHpJZUZQNWx1TkppVXR1VGRBZU1NbFpVZ2l4Z3E4eGVH?=
 =?utf-8?B?cWQxTUhyRlBrdWg2YXozRUlMMyt4UTlpYXdkZlN3aVNKZ1ZRK2lidEhoSUU5?=
 =?utf-8?B?V1ErRW5YR2lDK2RTWUZMR2RhQkNQYUxvbFBselIxVVloeVNBOXIxWSt1K2hK?=
 =?utf-8?B?UHc4ZUhHaXRUSUpJRVUrM2tQeUhWUEVCaHFKU1paQk03QUJicjhqUmw2eHdU?=
 =?utf-8?B?SEdiREdQSHpHSm5qRE1UaW50STRzSGtWcGJnb3FEb3hWQ1FyZmpOQ1dGK3pa?=
 =?utf-8?B?cytHNEphV1ZOaXRhdE0rc0FRbEFDR2h4Y3A1SjU3SFE0NkVGZmFFZWZ6TTdm?=
 =?utf-8?B?Um9wdXhvbDJXS2ZDejZKTGsxZlFub0sydXk3NGNSWVdEWUJGanVNeFR0ekJq?=
 =?utf-8?B?blZUNGdmNWlQbVJSSnNIYkVVRnA5OWZoaCtCcWhTQ2hjZXJvMjU5NFl2R1lj?=
 =?utf-8?B?emRzMjhYWWcwK0lEd25yL1pYd2lRWE9DdUpyVkZnSFZ3bTU0cWZkVE5YVHRJ?=
 =?utf-8?B?eFlBcm1sUXVxNXNrQkd5ajdybnl2R0hKZmZ1V28xTjdFWHFnTzRwZWM3QmE5?=
 =?utf-8?B?NUVsWW55cEs2aXA5cmlVcUR5UGlpamYvZzIrdEZuRlZZRUs4TWFLZ0lLdG5L?=
 =?utf-8?B?NVNuNEZOb2VndDI4dlFKc1NkblhobHMyT1ZQa3BMK1lmOE1HQmxzT1VpcVZP?=
 =?utf-8?B?Q2R4MnEyVldRZ0hKRFA3dHlLdHRLbGVPTGNSUFQ0cFNkVERzUkJnQjR4dHRx?=
 =?utf-8?B?MGIzeTZBdklRaU9LVmVhaytBYVZ5dldaL0cwangzRWtGSjU1eGZTMnZqbXhn?=
 =?utf-8?B?STcwYWZRTmM4ZU0yOEVocTYybmFsSWNLOW1zaVd6NTRkS1JtY0ZuaVdScnls?=
 =?utf-8?B?M241RXRIOWhld1Z0eTY2T3JvaW4xRTZ3RTJRTGtLa2UyWFhrUHEzNGFJcnRU?=
 =?utf-8?B?eEZ2dnZRVXBoQzF5U0ErYlprYzVzQVp4V1Z6ZUc0bnp6MVhRRDd0aWx4ZU1U?=
 =?utf-8?B?UURwNDFEZGxzVGlYczNObjA0OVY0UmJ4UXVFanRpeElqTEdTTFVyRU85aU9t?=
 =?utf-8?B?SS9sdk9lTUk1VkJETkRyUlNqUGhsTkRRWkVzdzF4VFlFNnh1WS9EZWE4b1Ju?=
 =?utf-8?B?ZGlYSXJlUC9QUlpBWXRlMG5ZL3JrMHg5RVd1UnUzQUtLWmgzSU1DNTkxSXRH?=
 =?utf-8?B?d0tSTXhuQXZPK1R4Qi9jMlFpblZYQlBlK1lURkM2MndSQ0FNd2srRE01OEV5?=
 =?utf-8?B?Z2Y4dWJRSVpVNEFoQ3ZvYXFPNnBGSVBRdmU4STAySWpycmVRWDdXcS9ObnI0?=
 =?utf-8?B?NFkzSUdRRlJvMUNwTGZYcFBraDBwY1BtaVJUMk9COXcydWtlZ2NkemQ1YVJQ?=
 =?utf-8?B?SlJlUzFKQ0lGSGR2NEEwOFB5cUNZdWJ4dkFPbVdkelVlUU11NlNJUEFsRjhk?=
 =?utf-8?B?Ulg5RXYxd282UTc5MmZmcHNrWEtJdTZteSs4ZUVQSGx1L2Qwb2sySkpVYSt2?=
 =?utf-8?B?UGJ1aTBGWHJIYThXN1ZXVU9hQklPTjhKUGtITFFVbHU3OExmang0RFpPWU1q?=
 =?utf-8?B?djJJT0NRcDZhS1BrTkRlMkNFZzRlRG1KM2xDT2NPeUpRZGt1NWJpVnB2L1E0?=
 =?utf-8?B?aDQzRzkyRUw3RFhYS21LenNIT1JpamN4QWdDZEpTLzkxcWZNNEMxclExNG1v?=
 =?utf-8?B?R0NqbzVMaVJWNUVSaDA2VGpENFpuQmVUSllTdXh3U3ZYMEdHS3JkR0l4Q3Nv?=
 =?utf-8?B?TSt1OEhWVTZnZC84ODlXeldFUlNUNDBZeUtUUU93NlNjOVB6bU5nM1dRSFRr?=
 =?utf-8?B?WFQraGtSVG10bVU1ZDV6VVlJeEdWVUN3bkdZQVdnaERXV1pjU0QvRXo3eWVI?=
 =?utf-8?B?T01ucytQaU9IcWwra0R6cmlXRmpmMVhIREh0UmY2NVlNWXZieVlrTWplaXRB?=
 =?utf-8?B?SVNaY0VwMjY3cUljOStyaFRYYUtyWU8vRE01Z2pOa3RuNGlka1JPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4e3e99-ff20-4bf5-bd9a-08de9fba0d80
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:24:17.4507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhijoryhsQgvtZxKKfDI+aJOfEpnsy762xDyyZYztcE2vlESYW7BdsYF20oldqb0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF
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



On 4/21/26 17:03, Tom Rini wrote:
> On Mon, Apr 20, 2026 at 09:40:10AM -0400, Raymond Mao wrote:
>> Hi Michal,
>>
>> On Mon, Apr 20, 2026 at 3:06 AM Michal Simek <michal.simek@amd.com> wrote:
>>>
>>> Hi,
>>>
>>> On 4/17/26 22:39, Raymond Mao wrote:
>>>> Hi,
>>>>
>>>> The Firmware Handoff spec changes required for this series is already accepted
>>>> and merged at [1].
>>>>
>>>> Please review and merge this series.
>>>>
>>>> [1] Add Transfer Entry for Devicetree Overlay
>>>> https://github.com/FirmwareHandoff/firmware_handoff/pull/74
>>>>
>>>
>>> Yes. We are using this series. Once retested we will provide our tags.
>>>
>>> Raymond: If there is a need for any change are you going to send another
>>> version? Just asking to double check it.
>>>
>>
>> No plan for another version unless I get more comments. I have rebased
>> and tested this on upstream/next and looks all good.
> 
> Looks fine to me, I'll wait for some tested-by tags to show up before
> applying.

Actually my colleague tested it already on our board.

In 5/6 there is fdtdec_match_dto_compatible() which is enabled by default.
This behavior was discussed in TL PR but didn't end in spec itself. It means I 
expect this part is optional and it should be up to every board to decide which 
DT overlays are allowed or not allowed.
Anyway this can be fixed on the top that's why feel free to add my

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
