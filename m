Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F10CE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 08:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CECC086B82;
	Mon, 25 Sep 2023 10:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MD32amDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061D086B9E; Mon, 25 Sep 2023 10:54:15 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0728.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2649786B10
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8L6Ttw+seBBMgHIEGsp8uinS7Cry/x4id8YlbXP8Y+NTZxiUjWHM6cwAnv1T3aXSKcXFqIpA8yBdM986/nisNUeaHOxunyA0OzHVJDdXS3LdBs299auKWqAm8jxggUzBlVkIJQPsgf/XBXbT6fPf2WBdsB7VfDiSqqEo0/49dDyjvjXdaSJdVOV6VcDlj5Xh4PESKNkN0H5GBcWEtw8TUGxoSBB/L9zrMseONM+R8yOyrJv8Y8mfxlbd0RPX+f2ZHh5E6ZPuiNYNaH7jBltK3Kz9FtdEvkwCLiHJftdMbbH1PVLLip41bMGlraLWRXR4qVZxrnU3xLUPX0gZApWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Tv8cLzXHov4GYw10SbmMIt90thQ8aaGtu6xyEOPNUo=;
 b=TXgvkRRFGXcz29BzZ28e4iKWVr4/KAnWfypRiVek0iTsXkc+KY/HrLUvaWmwDeyQYGqM6N3DZ/UB+uCTBK5gyNDo4twxttiuwbFb+eZYfJbaew7SWNdaz3jnF4KyVpEIo7k00t9pldbp/7YlVVIEBn/XjR+jMKJRYSQm368I1v/IXxFpyDPC+vrT2Ni6rsF7gl3dSyJyUfIZJzgGGqJRirmgWbL1PnjRGpEevPjl0fiurdwxYeCpTf7PiDcdP88bziRsGkFL6UvNCJOQ7AipGe0TnwrqoX1XT5RNqnOhGFjBCPb3MENGsusVj4IfanOuc1/7y4Ov15ViT4T52HehmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tv8cLzXHov4GYw10SbmMIt90thQ8aaGtu6xyEOPNUo=;
 b=MD32amDkksdVcrdZ+wpDyUU3qMKBew/m3HpDMWCY6dBkBf6x35hYKUTs+9oof4g4cdghx0mU70FvnMqgh433EQovitZQgm4J0nSMuaVkFWxs18GTBWtO+VqO6h2POzsGRuvly38NB3cq+brkuaG0zXazzaXjPyYhKJA2iua3bgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAXPR10MB7926.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:54:11 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:54:10 +0000
Message-ID: <5aa005dc-1767-707c-f40c-61e95602c13d@prevas.dk>
Date: Mon, 25 Sep 2023 10:54:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] make CONFIG_SPL_SYS_MALLOC_SIMPLE &&
 CONFIG_SYS_SPL_MALLOC actually work
Content-Language: en-US, da
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
References: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
 <CAPnjgZ2NzoYi9vVWxnnCNU0yudbVCnN2qMRm_gq1zVW-=SuUCg@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAPnjgZ2NzoYi9vVWxnnCNU0yudbVCnN2qMRm_gq1zVW-=SuUCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAXPR10MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fbe0b0-6f9c-49d8-3f57-08dbbda4fc31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0vBeVeXhUsTX7NQwr2V1C9NOxohlSE1YnCXli2KY4sR0OgKGMQeR4kFDcQMTQMJwsQ29ZF70DRz0NKGfgpMGkE2QFbAEUxp6CWNWJ5Asf+waTF3Doy+n5aLXALv4jcTgfdZjvlW4SUR42hwgWIZuY8MW4z+20AK09t9NcF8AWRXEFwRkpFm5+m8IoB2Kc63w7qI4LQHgdmvZXgwwvmIf3ROYbuGMTMYEWJixpGKF/JB6FG/L/D1uI9TDCh5Pboj68mMAKiqON722VcBdHyJgA+wDzFf1qsSqkoHw4oF4fV0iYv7GN7t+B3O6X7PoYoU2hMjF/SHDoEIJeHWOQnOSnP20FwZywJi2ehHF1EjJIROUNe2AnxL842XDb+R8pAVFpKebZz+BK2tNV0qi9MtsIKcBotwNP8G9/F1CptI4ONM93ttho+2p/5J5guMkGFgYdekCkkNsHlKkqjZqy0+dmlEOnEzcPJ6CD+JjU+sYWAE//b7CXAKSbdwL0K7T+Bq+ld3m+Th/U+t7AvUnkRpP6otrss6HpRWtsQv9n4ibxYCumZXa0OuEFukq2R1emuUujcYQ+NXxkSwkHoxObce/KCog1GLuqZ/9gtxgye8Oxm+tUiWez6wRwq8dmGiMiNO2MmLZwxrAGz/Rww19ibbjchmQXXTMZ5FhdJnW0gEsuCY//fZ11XJlxvEGpz3dEpc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(346002)(39850400004)(366004)(230922051799003)(1800799009)(186009)(451199024)(26005)(36756003)(2616005)(6506007)(52116002)(6512007)(8676002)(4326008)(41300700001)(8976002)(8936002)(44832011)(5660300002)(66476007)(66946007)(4744005)(66556008)(316002)(2906002)(54906003)(6916009)(86362001)(38100700002)(31696002)(6486002)(38350700002)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWxFU1lzM3F2L1BqbnNYd29NczF0NjdyaUQxVkRtU2dtR1F6R3M0cG4yU1hl?=
 =?utf-8?B?YjNJZTJoV2tnUHE5emR3bFZTbU9HZE5FVHFsSnVIU1gwWWJMWlRzNldrT2pM?=
 =?utf-8?B?RG1oNG9udmg0UWRZcGxzdGFZQ0hpR3d2aExmWFBmK0ZieCs3dFl1OWYxK1Qy?=
 =?utf-8?B?eWlZaDhLeUY1TG0zZzRBclFiOG9GMHorTC84NzJNZmRhaUt1bE5CUW9IMzlu?=
 =?utf-8?B?ekl2RFdiaURhcFFBOG40N3ppMWVGY21tanBGcTVnVVZHd0NDU2VKcWdwV2RD?=
 =?utf-8?B?SWJyc1RTOFhZNFI4akFiVEZac25vbWNBREJCejgzUWdBUnV3cktXSkwxRk9L?=
 =?utf-8?B?dnpmcnhIMktQZXN0cEpsYU9manhXWml3NER5MURhQTNIQTE4M0RRVUZXUmtC?=
 =?utf-8?B?SDR1TjQ4MHBndmR5SENhTDNqaWI5eE9ncDJZbTBNYXRPdGtqT0lqRnQ1SjBW?=
 =?utf-8?B?dm9JMGRBR1o5d2FPN2U2WFp6Mkg5WEN2Q3Z0QzdCMk1DR0F2REZDcmhUSjlv?=
 =?utf-8?B?c0JOYUFldnZOTEpwTlAzWDJQT1VXZmk4TEVXOG5tb01KSWhDd2JEK2Uyb25I?=
 =?utf-8?B?c1gxWHZnRmdQUE5DV1drV3NGZi9SQlVZRGcvckUyc1dFeTJlZ1ZQdE03OVY0?=
 =?utf-8?B?YmpHZTh5OCtNOWtSdnNUU1lGWVZnSWl3aks4Zm04aHpWa04yeVJ2N08yODA1?=
 =?utf-8?B?alMxN1JZZUJIdXJhTWg2aVA2Y2VUaVNjdGQzZm4xMW14ay92ekFpV3Ivb0sy?=
 =?utf-8?B?UHdvZklZTTZLM1ZZVEVOa1h6Wnk3S1JqbDJmY1hkT3JCNTBEeGluODFPOWs1?=
 =?utf-8?B?Tk9HdUgyZ0tsTHUwUktWRUpISVZVZnpJMW8zUmJiZnBEbndzQ2RvYVNSR1J0?=
 =?utf-8?B?WnpQMTVHczZyd2xSMUcyc3lUNFNISUQybysxQ0tJZ2hRbUFwVkJXeEJ6Z2lx?=
 =?utf-8?B?QWpJT3RoeGhIUFhrVXU5YitSaytZMDRHTURpQ1FoNC93WjNLZU9LdVdjWXM0?=
 =?utf-8?B?aDYzSldobUFIcGh5TmpPT2FEb2JxTUFXMEtlb3pFVDdlS2Urcm9ZMjlCNmZu?=
 =?utf-8?B?L3hRN1RNWFowMWNrUnloK2R1d1N6RG42b1BxNmJ1M3REWTRoVHdaallkeVdx?=
 =?utf-8?B?R0RHU0drZnlRaTdVSlJvbnUwc1BHWStiaTNydXU5WlkvVVA2aStWdEdqd0Jr?=
 =?utf-8?B?V3o2cURyczI1WkRubTRQU1BrRTN3T1VWQXRKOXkvSEMxdlZFeVByd3FuMWZY?=
 =?utf-8?B?VDltQktVQVc1eUFybU9rL0p4VkZUTXdnRUpycmxJT0lZZUlZN1VCUjgydXUr?=
 =?utf-8?B?UEFXM3lwL2FPNVVhQ2VsUVd1M1UvQ1I4b3ZQcWdTYWwrbDV6L2xLbi9jTDVs?=
 =?utf-8?B?VEJETWNGdURzTUREWER4THduK0lHQjNTaGsvNk40emtuNnJUdUtwdGlXbWt6?=
 =?utf-8?B?VXNJT2pmakFKb0Z5d09DRTY3Y2RHMDNiUHpTTU5CaEpaNUZESENYcCswSzJM?=
 =?utf-8?B?OVh5SlVYUHNudVZFNWloZUpRRkQyUjNEK3BxNEJJVlMwOXBxa0tTTGxLd0J2?=
 =?utf-8?B?OGQ3T3M5UU9TVmFVQVhEL2lMTFM2MmkyVE81Ylh6SU1aRjh1S0dhUmtERkJJ?=
 =?utf-8?B?K0V3V2dnOC9CWU1xeHRyY0FQU3dGRFJWMzIyTUdVQi9ham5TMnRBR3hHS1Zr?=
 =?utf-8?B?bDhVb1IxbEpuM3RCSy9iakcwek04NXNRS25oVWxuZ3N3d0xKTUlhTzkvYU1F?=
 =?utf-8?B?RGllb2MycU14UWQyMVZVUjhnTUh4UGhoZEw1VzdVOFpDMVEyV1ozOVVMUklh?=
 =?utf-8?B?djE1UTNEV0NVVHI5VHczcVRGck5xYkJzVENnaDJWWkJHaHhCRS9OZ0hYZ0ZD?=
 =?utf-8?B?NHlYZ3h5M1dMcVRiZ3pLS1RSbXU5eVl2V3BHaHM5V3piS2xGbjRSZHEyU0V4?=
 =?utf-8?B?b1cvU2JFZXphMndwT3FNR3NvV3k3b2grS3RuUlQ0eW81Rm9Ld0Z3bEo4S24v?=
 =?utf-8?B?ZWZXUVFWRWpmeGQvNUZJeUltMHBmQ0x1K0xlNVE0aU9kdjdXdkhmWkQ5RE93?=
 =?utf-8?B?SzBITE1NR3BtVzY3eUtZeEhDWmpEOHNVQzZoYmw3N3JPdWRiQ2cxYVBtZVRJ?=
 =?utf-8?B?dVE3Y0NmODU2dTFzUEd6QUVGSXNrQWpqQXhhOEw3YXppY2NQaVF6dHZ1aFU4?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fbe0b0-6f9c-49d8-3f57-08dbbda4fc31
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:54:10.7657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1ARLqk5QyXucRTKfsjN0gR2TKVw9KbjYBHVndpup3OA72WUE/hRXt8oReN9Gt/VCeMlTSo6Ah7vv/MgOA0KhP64ssxyt1TsNU1lP5siV58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7926
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

On 21/09/2023 03.02, Simon Glass wrote:
> Hi Rasmus,
> 
> On Fri, 15 Sept 2023 at 11:51, Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
>>
>> Currently, setting both CONFIG_SPL_SYS_MALLOC_SIMPLE and
>> CONFIG_SYS_SPL_MALLOC (but not CONFIG_SPL_STACK_R) doesn't work as
>> expected: The SIMPLE option means that all malloc etc. calls are
>> directed at build-time to the implementation in malloc_simple.c, but
> 
> Sort-of. It is control by both a CONFIG and GD_FLG_FULL_MALLOC_INIT.
> 

Eh, no? The CONFIG option completely preempts any run-time gd flag checking

#if CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE)
#define malloc malloc_simple
#define realloc realloc_simple
#define memalign memalign_simple

Yes, _without_ that CONFIG option, the "real" malloc() functions do
check that gd flag and if not set fall back to the _simple variants. But
what I wrote is not merely "sort-of" correct.

Rasmus

