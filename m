Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A11CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 11:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C76C86E1C;
	Tue, 17 Oct 2023 13:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MmtoiEee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 982B886E47; Tue, 17 Oct 2023 13:27:43 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5942B86DF5
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 13:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgNGttMMU+kvijqOCdyF5qhJ/b7HDYZJOh/qBBHerWBdkTXZNNiA2B+7WiLEICbzcxpDm12WKbnp+t7tMsDklpxGOl8snjl+gWoqLe7u3q4M1xszlLeg1/b6VmQulcFfbPnNJVj4tBGifjTVGJ7b38Xeu34CgMLwpWJ/txHC6j0WuLicp9Aqo/hVjej7pTj8cLGRYmwI7hyalMA2Q3eTyL3epTY97gNaVLXhqLZQ8zsWeFtlbYrtrhupbmDZOM2yP8GGnqeXJh4didU5BwGi7XG3m7n8IAm2pNCqsnooSLUOkotJ8hVKWTz4ME6P0IOk0rwVSDIUi3IatPPZ75LRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqfEHxlH7NWJm1bm7aAaelTzvgRMQAFrt8hDZtpNRcI=;
 b=eBxLftioPZ7CDtdGldKeuX40ZgzkRc5cQZqdf9O12ZQBvgR6jG6Vlq31Dp8DdXYPwNw7oa0BCP0UM8nAs6sIJUAsWu2iDzcdZbVKTIsgR/MS9ZBw6Sgsb8TQ2ac4AWrIC97UJ7+IK9t/XpJgao7rc/4FyuU5twF9NjBGOmn0lgkql+aYQpQcaufEDOuX+KRbx7JwsuiPOAQ6grYUoHVuS8Dy3fhhy8uDxjPxrk8afP/mwSrdUxVarpPkkZVyjf5BzEO5vdQJBEDJ1PG9y6RTHvvkYf2tFWl6Pa6bDT6dY9yXhGxfeqpVN1YS1LgWAnaIh3MdxfUS6Pzmc8KG8f2yTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqfEHxlH7NWJm1bm7aAaelTzvgRMQAFrt8hDZtpNRcI=;
 b=MmtoiEeenf9HFpFpeZEknBx7l4gozHiie4fW4shm7SoKdGW7FNvrpbslfdFmFKmnOBD7ADitNDPOSFCV53dB7IpdKjy1sUsUnXiRh+MruuSussvk8oWmp6aNXOpwz4psFzncKyFaOX+OfqWdkEh1zTm7Wr+odKRcCtjTCg//ibw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7156.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 11:27:39 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:27:38 +0000
Message-ID: <1eae0688-cda0-4537-a1f7-a11f61a27146@prevas.dk>
Date: Tue, 17 Oct 2023 13:27:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: use which $(DTC) as a dependency
Content-Language: en-US, da
To: Richard Marko <srk@48.io>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20231017104453.2121276-1-srk@48.io>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20231017104453.2121276-1-srk@48.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::26) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: d54bcee0-d8b3-4ea9-6af7-08dbcf0411a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtS89RksKg4QTmlphYpq1ycBjBmMMVmJAm8tHbuHRQoF6Q0Xh7SB03AeP6ydDCerIr3CiAe2Ok+V5x+pcN+LtRUEw7A1qKHMKuvkM6w6XGBqqSV5JeAjkJLzyj9+q1RBgieGDPGR2XxJZKiFzpEe+t9kk3ayskODEYzJp7lf0RtcJ5MPHywPePIJzzTOCWWOx6p80GePKBz6VId3c87LAvXA7oDN7KNGsbFTXuAWS6XAVEXpiaegNx5PPC3UyXD5G/DGZ65aLGIPrfolZFi8vUB5Vpuayza8NhSW3xc/0x7apK8UHZxu8dYmMJGVVydvWYaaJLiqqKacl4X491PiynaOWvfnL3T4jZKEtmk1Zb1KL9HNrVpzLkX9pmFcgdwG5z39oOgrAAaOjN7iq2BRyrkQmd2HulDiCCLXRJMn+BQjxMLTEv68oz0sbREocLerm79f+NbMBQXXHq/lNObdfFRzaBcCBA1JDLRW4M50R1Uo4DxNrb/jgH0+p3GtMNiyMOY3noooxcMY8vVIWn7PIPU+S1TsQCapHhweBAx0koC9x0RgD90hxzT9IuqX+9/CjvgBhTGnnQiHhca7ONbIMHInL+A7D4iXcXnB20yYT/s6nESKKWex/H2rluDXf+fYjyaOkmbe11RBJDnLf/SXqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(39850400004)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6666004)(38100700002)(6506007)(6512007)(2616005)(26005)(478600001)(31686004)(66556008)(66476007)(316002)(8976002)(8936002)(110136005)(41300700001)(8676002)(66946007)(6486002)(2906002)(86362001)(31696002)(5660300002)(44832011)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhwcmxWQTFGY1JPbWl6bTVZRWxxVFFtMVFhZTdPZkVjaWVIZXEwL29lRUhq?=
 =?utf-8?B?UWhhdmlLMFZ3c3ZmdEVEVWYyYTZDeHhHUmJYQm92TlBuQmRzNVpNUFRhR0o2?=
 =?utf-8?B?alVzaTd6dUJmYnhxUjhMeE5kdEliRVV5ODY3U0x0ckRYckQvZEI3KytMZmlU?=
 =?utf-8?B?cXRZZzk0MmZmdWRXMDhTUWh5WEw5a3YydXNLaDlIWHl4cjFMNU5EQ0pXS05u?=
 =?utf-8?B?cjhUaVpWRG9CVnZOVWgzU0twRW5ZMWhvd1dXV2VVQzVGZ0pncExBNEwxbm9s?=
 =?utf-8?B?N3NmazdEYUtYV2lCRTI5bERmcEt4RzdYVldHT0VycVlZUWExSnVqR1BxM28y?=
 =?utf-8?B?blZQOXhHTEdseG9RODFhc1JJTkVHZUU0aEQrc2piOWFxTUFpMkNtYUxoZmg1?=
 =?utf-8?B?aktLTmhod0wrWDlOUnhPREx2WmVmdWlMOEtObk1sYjBjZUhsTGdQR3FoK3lv?=
 =?utf-8?B?UHFwaTZMaHY5L1hodEdoRUg3bURkL1ZIaXNSQnhFQXZodk1ncDdiV3UzRCs2?=
 =?utf-8?B?ZlNNNU5HU04yY2IwMHpBaWRvQjBtR3dlUENHY0NRbVVMcVJjSzJhRm9mb2pV?=
 =?utf-8?B?QmVTcGRBOUFnay9uSTltdEo3YXI5WFdkL3VsMllXbEFJeTlZazZVSUxRNUox?=
 =?utf-8?B?RGhXMkZIUU51SGNGTHZ6dkxiOHFYemRndzZwMytWbEZSaVFFNmU2SmIwZms3?=
 =?utf-8?B?T1RQOWhva2V0WWxnd2NsRGZqRFBqV1hTVDUxZHpBMjZMM2oyaWxibDZXSjVs?=
 =?utf-8?B?cUhGTzVEU3kzeTRjM1YyVWVDTTkxU0pGY3gwSEtNZlFYUlk1UngvbkU0UUQx?=
 =?utf-8?B?VEl6ZitKQ2VkZWpoQzE0akI2eWhEeHBTY0VpVmV4cHJzaDlpWW1QQnRNSUJo?=
 =?utf-8?B?WW5ob3VsdktYR1IvNUR5K1pNUlBtcVIvRHQyNnZpNlhZVFpwTTROK3hlbEUz?=
 =?utf-8?B?cS9vTC83cnFDNk8zMlZyYWtaRFlud3VkbUh4dk9BRnBGSTc5VGdaT3pYdVF6?=
 =?utf-8?B?K3JtSWNIZ09GSlg3T0czbEJMYzQ1ZlBpOVBXWktueE93Nm0yWXFaSDF0VWxI?=
 =?utf-8?B?ZWxiSjd2SkdGcW9ZcXNSYmlnSVdRci9KSU42Zm5HY1haeXJQKzJ3R0tXNVU2?=
 =?utf-8?B?TEl0VlI2TVFFV0ozdjBXQnFyZmp2bXhNcU1uV1A4YTdiNGRISlJjc01SN2Np?=
 =?utf-8?B?b1Y3VGNhQ2ZZWG9oOUk1czZLTGsvemszUEpiVUtFaTkvTGlRVHIyWVdIQWRF?=
 =?utf-8?B?UkhEd0lBZ25iazdyOHhhSWc1NGlmZ3ZtRVpqY2pwenpJOWYxVzFTY3pVWnRC?=
 =?utf-8?B?a1JSTmlUZkpxdkhUWVd6d3NuZ3EzbmFPcHVid2Fxc0xNajMwZkIwd2psalJm?=
 =?utf-8?B?TXZ2bW1CNFptUUxKYkxmOHROSW14WXlGa0hkWFE1eGZMbzZUYm5kTWhaYlBG?=
 =?utf-8?B?ZGc4T3ZUcU9ETXNZdWMyeitFT0djYXdydmp0ZDVrblIveTNWUFhzSm1MVFdO?=
 =?utf-8?B?eGRLVEFBamM3YXludXFQUHV1bDNQL01PUnlEWFJFZjRTeFJqeTJ2SDY4aWtE?=
 =?utf-8?B?MmFGY1FTKzFEQUt5SXkwLzQ0WWNhN2gza0tqNEJ4c3Jkb2dCVXdEdVlGMStX?=
 =?utf-8?B?RS9Ldzk5dlVrTWJyWWVuK0hRWkVmNHZGenY3bXJucG5hQk5RR3NvRng3SXJm?=
 =?utf-8?B?M2VZclJ4Q2Y1ZTZrc1ZxSVRteGJieEUrWmMybUlEdmhLam55Q0FHUUhkTUtn?=
 =?utf-8?B?M25odFJtdWowN0VpZytoR3RCWWVpR21Gb2Z5MGMvUmI2Znh3M1RJSTBxN2lu?=
 =?utf-8?B?NVFCSGhocnJpdFNQY3BqR0RyQVBnY1pib0l5eVVBTk5PVlhoVEFJUk52aExB?=
 =?utf-8?B?dE5OMXN2L2kzek15ZU9veWpLRk5ISkdPNjY3RzlrUGJkeEhwdkVmRGs2TmpX?=
 =?utf-8?B?dmN1L28vV2Eyb0cvWlBZdmk5YVJEMUpsdk1mQUVkdjdDZFU4Tnh6eFB6bXI3?=
 =?utf-8?B?elI1WXpEbEhtNHVuWCttdVR0NUdlVzdtdWtRdUpiOGlRbWEzNG5tdDI3NFJH?=
 =?utf-8?B?aThiOWFTU3c5MHUxVzR0UGd6VWlVT28xQmZPZVZVcWQ2TnFHYzJBS09qanNF?=
 =?utf-8?B?SzdaTXpaSUNTazFvYTMrRzY5TUlVN0F6WDZQVmRtU1pPMm9IR09pUkhra0F1?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d54bcee0-d8b3-4ea9-6af7-08dbcf0411a7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:27:38.7423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEnVBXS5gkTULOjLJmDzhGCcg7X+hY7sqGkWcWEl3FaaaZVqmuJTS5raA9RAvAQJUfq788CPsx0CN3PHgSv/Y/aQway76hN5Sbb931lFuLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7156
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

On 17/10/2023 12.44, Richard Marko wrote:
> If we try to build using external dtc using
> 
>> make DTC=dtc
> 
> we get a confusing error like
> 
>> make[2]: *** No rule to make target 'arch/x86/dts/bayleybay.dtb',
>> needed by 'dtbs'.  Stop.
> 
> Workaround is to use
> 
>> make DTC=$( which dtc )
> 
> which gives make a full path, so the dependency
> is satisfied.
> 
> This was introduced by commit
> d50af66 kbuild: add dtc as dependency on .dtb files
> 
> and we extend it so it calls which automatically
> (similar to scripts/dtc-version.sh)


Let's please not deviate from linux Kbuild unless we absolutely have to.
In this case, passing an absolute path works just fine, and is AFAICT
the only documented way to pass DTC. E.g. doc/build/gcc.rst has

    DTC=/usr/bin/dtc make

as example.

[And if we do this, then at the very least this should also be done for
the .dtbo rule and wherever else $(DTC) is used. But I'm really not a
fan of calling out to $(shell which ...) in the rule itself. Perhaps if
it was done just once, near DTC/DTC_IN_TREE, something like (not real
make syntax I think)

ifneq ($(DTC), $(DTC_IN_TREE))
DTC := $(shell which $(DTC))
endif

But I don't think we should be doing this at all.]

Rasmus

