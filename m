Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490C7109B481
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 15:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D3983DA6;
	Tue, 31 Mar 2026 17:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jrdd/Ke5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCFC583F5B; Tue, 31 Mar 2026 17:03:30 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793EC83A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 17:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xslZaVXcwKRdzcJN4wWQRolWq4EZyurI6FPsNmmRLBt6tGNUMyl5+OiMKSruG/vYNRs30O2k6Oc61ZqEEegv/RgAsOBL3svFuepjINgn2cgPqBvI/yiTWXd1uGtSyhWudnb4qexhuxcFFU06PUkHKsxbUJYgL3zilDt7g2Si42KEDB6FffYnWVc5I8JR7DLVk0fRSxecaqIbxlruqSsxk/Dmo7nvCV8LNftuY4sCgLIxlB40AZP2jFeEJRid0yF4lQRyjcbFBoTsQFOEcRq/Bwd2ZY0j+f9oW3s77av1939DDhetvH60pfYMY409nHXNnS2JiZWrmta/X6ZQbETS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHv8SmDQGg87f1ByYVBLHq9EqRXsxJkC0WJI3NMRqN4=;
 b=bAS7N7HxTmyXuSWlwYueByaq6Fm7PyCUG23/YkxMG8FT77wEoWxEgjrl5b02N8Xd/toGiXnXDrlmJLZEpx0Bi7dy7MKwb9x5FNfLdyNbaOYaqZFF2zpu55Y9tOsASSoxifdoXMxeqgEJdIDwhiF0vtS0RnxdcJkQIGN8kmPA54zKmF7Ne2AKF20+geVjhLIxpyCfhHbin3DdTK1RTpHJZjWV/Ksl9NDXPwSaT3AbBbExHO5eRxFrX38VcVRhESeE9/uN/3OIHrdL/9wv2TyTa/qKWrZ2zypo7e/rEIOpr9GLebDfN/0xqJ2hzXmhbFcGpDFpAJlwQktTOIdC55AJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHv8SmDQGg87f1ByYVBLHq9EqRXsxJkC0WJI3NMRqN4=;
 b=Jrdd/Ke5Z9oOjKzd0bvK1uBC04R7ZLTsiVDU6pXYTkOm6I+gldlK03SbSFQ9uiyOK/AXTVUbvoAG8aSf+UM1kqIfqApwegZQxKTI1ctVYAtHV4HOuXC6AaE3PmYConaNFphb3IbfBOQ/ORHto3z/mmbpqdHEhX5qY3gP49sg8Ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 15:03:20 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 15:03:20 +0000
Message-ID: <5769c248-5d76-4a45-80a7-2deda8a640b4@amd.com>
Date: Tue, 31 Mar 2026 17:03:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] fwu: Call EFI stack initialization after preboot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@amd.com, ilias.apalodimas@linaro.org,
 sjg@chromium.org, Casey Connolly <casey.connolly@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <me@ziyao.cc>
References: <cover.1773840306.git.michal.simek@amd.com>
 <20260331142806.GA1235458@bill-the-cat>
 <13015773-7580-40DB-A865-3B490FDD183A@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <13015773-7580-40DB-A865-3B490FDD183A@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::30) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: c1969ba4-a4f2-4bc4-07d1-08de8f36a56a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: a4cdDijgL9iP+tDzbmnXCN+QC+KDg9gjUm+vkkqxM51AxXAqdRG1F+6Rvu6NqFL/h/NzREBOmdDJtchoMj2YiPThiOOiCDxveENkS4KOLUKdaoVRTr2pEN9gU97YwXGihRkGyUxcnmlsn8442y573C9UhwlzNAOiziMQ3oHy4zOFWaL82rZ9donKbYfiIEFuwLiuGevrUVI2/ktaxUGYz4dz3MwUikXPk2oG3vS4lvMr1vlB4CzXdZ3+cyKIab4EjwNj8YeO89XNJAr5nhXshJHbru1qzyo/ZgSf4aUg05e40Gd8iC5EyGJT4L+NmKOUGXe2njrn7vflNhLY8306yVeWR8CMn1U/2l2d1wiIVZX5hwjBZqmxVdDCrsWTeg7hlw0QB93NBvqalY7czUiLJhdneYZFxDr/YbGPXshNhJbtcUEKURhoBZezUWSaoxfP94duCn/UxJGoRRkJQZ7cx/jcAbof0+quJQxbuniLWIzrRCdp8VmlyREc7l/ZVc9XyPgU3Lg+lDDRCJ3kycN1LifKuDbRqtDTESJxgqUalMKf2c/l8q2jue5teBnAtgD2xgTmIgYeF6ieDWH0ELgvAmNbdCZHRGw3q89hsUKVrfJjqenveGJDywL1mqKGuhO3jawRjh+U9URkbEtCvnnZJEVP7srbO/BRsRjKNKa3uYrLTTRejEeQ+nHjOdj6gkRj2bKlE3Lp4BCf/ed3Mw8nvZo3BB/RdwNgRwnBAxwOUlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZFd20raGpPTWxlNnIrcmxrdVQ2Nk9WVlNjR2swQUxYVmczbm5jNlYvaXNo?=
 =?utf-8?B?WllCa1ZKdXlPcSthRlJucGJYZ2Rja3BvRHEvd0MyUXBRQ05NcEU4Z0xXd2Q5?=
 =?utf-8?B?aVRhRmdPaThMV1NQV3hac3NqT3FIMEplTFNnYUZSeGt6Z0VaQ29BMnpLNDVs?=
 =?utf-8?B?eXg5NHhjM1ZlaGRTMU4wOWVoYWtXMGx3SmNzeXhySXE0MkpTMW9obUJoMUxt?=
 =?utf-8?B?bllsd0JESWNzdlZWenIzTGUvYzhkMVVKZGdWU3RscHdiaGxVNU5mdDI0SGtB?=
 =?utf-8?B?OXEzRWVYUDFxVzhJZ0xkYzJETG9QTmtSNXFYMm0yelY0Skp6OW5NMXlUWHR0?=
 =?utf-8?B?UkE2UTBGMFJSdU9OeHhMNDlTaS96ZTVoZkxMYjBxR1Z5dFQ2a3Zsc0VBMDNv?=
 =?utf-8?B?eVpRKzA0REphM3p2N3pGczhRTnhJUGdJRFBYaGw0d0pia0xaZHFVdXF2UVl2?=
 =?utf-8?B?R2ZhWnpvcEd0eXFvWHVEMkJmUU9KM0FkNy94ekFFUFUzY0tOMlAvUk12Rkhs?=
 =?utf-8?B?VlVTQVJVM0p3TjNlMGVFUUMrMnVxZkFWNndqa1FNc3RjbVMxR2Rtb21GTWxo?=
 =?utf-8?B?QThaSUhrL1hZUEViZ2VYR0wwUEVCbm1UL05ZSzBiVVUvMWw2YWl4ZzU5MG15?=
 =?utf-8?B?d29oTDZhbmNlQkVqc1l0YzRmekU2V3EwTXJSbmJ0WDdIWVFKbnB5ejk2NzJK?=
 =?utf-8?B?eGVwZDZhMHAyUFdkZjdUNndFWVMzQ0M1WW1oVS9OWDRndHFsMmZQOXJxdGxW?=
 =?utf-8?B?UXU2NDNzbmlCWi9CREI3WWtxQjJDbXBib1dHSE5LZWo4KzV1MkV0STBTRjYz?=
 =?utf-8?B?Wm1GaGkxMllIdUwxNFNqNDFCaDkxQitMcDVMRlIzTWlIUndEZS8vOFF3L0Rq?=
 =?utf-8?B?a1ZDaVVJVnZxbkt4Y0kzQlRKTEpsUFowc1VldlM4eHNyejIveVVzcmxzQ0lD?=
 =?utf-8?B?d09FQ1dEOFF0aWhINDc3RkppcWN6LzlTWmk5WldCTm1MWWVMSWVMTWJoVzlm?=
 =?utf-8?B?WGhVTWY4TUxMSkNPVG5GUURGUGYzYktocjh5N3BYV002VzI2U09zQS9JeHBD?=
 =?utf-8?B?UEx5bU5JbEY4V3NsdEt5ekRYMXBxVTZERzJ0eFUxcWU3eXZ5N2lTOWsvR0NW?=
 =?utf-8?B?OW53ckxwNnZNd3FSa0tyTkVyUUl0dEJndERhUjVXZVl1V09hQ1pqcThqTGZB?=
 =?utf-8?B?c3BWQ0Jabi9IdHE2REY0RDluUmxFVkRkYlR4ZTY0L2tPVFNjN3lyTTVUWUJn?=
 =?utf-8?B?UVZoSVJOdFRWTWZyMDZjSUNTcVRKZUVRZDFzbm1RSWVFeHdJQnZndC9zRnd6?=
 =?utf-8?B?WGVYUUhqSDRwcFF5YndTUkFqZ05Iek5zbGw0YWt4WWJaUmZJS1lhK1c0blFk?=
 =?utf-8?B?UzF4RmViRUJDTm5lRmVxSkkxUml0TGZUMGNleE1NWTBEVk1jUU04ZnFGUlZY?=
 =?utf-8?B?bHNXZlNYUFQzTGx2d3lRUStQdWZmZDFwUVJPTEJMT3R0bHBLazZ5cFZzdU0y?=
 =?utf-8?B?UW91RU1OdHhzNkxWVUhEaWIyZmNqOGdWVmpBWjNIMUtKcGFEUHNFZlBBbm1z?=
 =?utf-8?B?d1p5c0lsOEcyaVV0K2p0ZXNxaTUxQno4NlZtVHpiMHdCcHFNOGh1WlR5bXNF?=
 =?utf-8?B?K3dMNXhUV2lsUGtOUWplVmFIUkkzRWdnSzZ1SzZJZVVpcG9mb3VZM2VmU0w1?=
 =?utf-8?B?Ty9STURIakhuOGNYbEdlYU9oK2xtQncxZENvTGVZZHdaWFdIbysyUytRajBp?=
 =?utf-8?B?K0V1T092clE1RnhBWnZMcXA0eU1YVzc2RElXbmZMcHRSZnhvd0hScks1WjJM?=
 =?utf-8?B?ZzdmcFFveWRpVThWYUEvMi9vZTVaTlRUeGR2cE9mTnJjdzZsYzh2RG1pVlpJ?=
 =?utf-8?B?eVlyY3ZtQ3lNcFdKd0ZWYjA4WUJYd3VYQjUwQ1hPV0Q2b2ZWaDg1MGFGaVdE?=
 =?utf-8?B?dytJRkw3UEhMcG1BZm1udkRKcndTNE8zWklvRTdVOUp5eE5tZXZDblYrK3Mx?=
 =?utf-8?B?ckN1aDhicHVySXBzeVVkVEMvdjlSaVlUazB6YnFkd2tnM2VQeXZaNStUN05r?=
 =?utf-8?B?ZkYxTDFzbzQyWU1uZWRHamF4MEdYZzZDTXpjNWtyWWR6Z0QrWE9TYlVocEkr?=
 =?utf-8?B?eTFxNVpTTzN3VlBVTTFjQU9pSC9WSHFjZ2NMdlpnbGZod2lCVkVqa0VQbDUv?=
 =?utf-8?B?TVliOWlmWXJyaTZENFdmWUdLeDk0YjNoS3N0WFZXM1MrNXl3NjVXc0xNMFRX?=
 =?utf-8?B?OWNmQ3VwRXNndWhQQmM2YXE2WFU1c1FXaVorMURiV0xYOGFKenpJYWJPRmpR?=
 =?utf-8?B?USs3LzZHVUVBRk05M2V5SnVmcGVFc0JQNWRBQ0VLSGdubEhMOHo1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1969ba4-a4f2-4bc4-07d1-08de8f36a56a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 15:03:20.1862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XYa2ZTWNZh/rwSrwNIy0xZyuoqjAUARpZ/bB3F6N1djQ1yx7WjEfrZRphEzOHKu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
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



On 3/31/26 17:00, Heinrich Schuchardt wrote:
> Am 31. März 2026 16:28:06 MESZ schrieb Tom Rini <trini@konsulko.com>:
>> On Wed, Mar 18, 2026 at 02:25:08PM +0100, Michal Simek wrote:
>>
>>> Hi,
>>>
>>> the whole series is trying to address issues we have on platforms where usb
>>> and ufs init are not done before efi initialization. This is happenin on
>>> platforms where A/B update is enabled. FWU code is called early and do EFI
>>> initialization before usb and ufs started that's why they are not visible.
>>>
>>> We are workarounding it by starting usb/ufs from board file but this should
>>> be more generic approach.
> 
> If a block device is created after EFI initialization an event handler creates an EFI handle.

But capsules are not automatically taken.

> Do have an example for QEMU to reproduce the issue.

Nope. Only on our HW.

> I am on vacation till April 11th. But maybe Ilias could  look at it.

Enjoy.

M
