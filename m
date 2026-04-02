Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A850D6AB05
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 19:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC0983D8A;
	Thu,  2 Apr 2026 21:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YEE2xkxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57AF83D8A; Thu,  2 Apr 2026 21:58:38 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439D780212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 21:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhhHPUvJEl6WiVvxDcgv2WNOmHS7Qdi+noe2udOCfrPOnZ5vfyQHsW9WjWmzweRjOX2G9ejrjh/+E/+H6MT1RUcBVsXTf8tBrA5uHV5qwjb7f2+FH+jGWp+FPPtC+aGydcQGNxvwJ1q9hk/uOs1jDSYE+Nz0wZTM60g6PDCrASDU22HmWTq8yfj+5t3BYSsMX+Ydy6C1f1WMqk3BErTT5zOy8JtOxOV93jgIMuWuidbOyScWBl3WjkK4JjFIS7aJ+lGjHWaPyOMW3iNMtc7ApSX1dbjn8YuSlTHmdDZfp4jksiZMRcPaDck04rk695FSRBXV/srhO4J3GSHKe7iRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1+oReORULVU5IOCI0ijvE8qWWM29QFz6M34n94B0ps=;
 b=ag76FmvyLTtXLcfa/lAiRryvG3Zy7Y02paW4QUEWQM9tQML/lcRVNd3BimHSrs0meTZlA8lrD1jRYYTiSBOXzez5DpKsFcKvcDn7OjGTOTwZ6meUA7ha4w94Cj9jR8R0jfIEELbehzDKzA5Qh1KrS49eEgM3YRSpwr3xgRE5J2TuH+YjshSwYGLBFsLpX7kKwla2s8KqYWiooGIFqBcWHI/0FUilL8gplhc/Gz5Ax1a6PbCXypZeupE8tMob2SA1JFuU5NRI+dhqG2f9CPUd6biTZnUyfaJqMGOK9TzqeuuABaPM0UcHyPZqNsEmPLWKqbUgKrRBX3chTHQtd80UeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1+oReORULVU5IOCI0ijvE8qWWM29QFz6M34n94B0ps=;
 b=YEE2xkxosbACVVIqUTrpMaw7ISlvg+WDKqrOkcSIU4UqjariMHStnmAjK3FCNVa0ZXJEUqTprVbMB94D/70nIQn7HikvOXB5Fstk0nDItbsq4bhMo1TwaF9rXneUgbsWea5PAhMw98n1+2dea3XCB0YEH4rME96mpSoPVIffmZ8=
Received: from PH8PR07CA0041.namprd07.prod.outlook.com (2603:10b6:510:2cf::29)
 by CH5PR10MB997695.namprd10.prod.outlook.com (2603:10b6:610:2ee::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 19:58:32 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::22) by PH8PR07CA0041.outlook.office365.com
 (2603:10b6:510:2cf::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 19:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 19:58:29 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 14:58:26 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 14:58:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 14:58:26 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632JwQFr3089208;
 Thu, 2 Apr 2026 14:58:26 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 2 Apr 2026 14:58:26 -0500
Message-ID: <DHIXO2TK649C.JAGU2F3IZ91S@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/6] efi_memory: backfill EFI_CONVENTIONAL_MEMORY
From: Randolph Sapp <rs@ti.com>
To: Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-6-rs@ti.com>
 <CAC_iWjKbeph+3M=GDy3_KeprSaUTVd3375O3Ny9GPV14XNBUgg@mail.gmail.com>
 <DHIUKA2JVA4H.V11Z7EF0I1A1@ti.com>
In-Reply-To: <DHIUKA2JVA4H.V11Z7EF0I1A1@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CH5PR10MB997695:EE_
X-MS-Office365-Filtering-Correlation-Id: e6609dcd-daa7-4717-d4a5-08de90f235c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Bx2vsVW7N5it6Kz9sqHusQLb/Xdxl9KhmLqzkHplNdm4aQoGdoqv+g3QicasQQHl1lfrbODrFKNxnmntUnmSA0Vc86u3NzkROBbw22vgXE/zAfjBi+5pC/KIgIiEGGly0T4jKZIMFyH9MpFUswTwqLihjL76BYzeSd8hFwA0e+jjBEYbhrt+Of0gvPqdXYfO89PMOvLagrJPwT8YAsblAEmufW7LsLXRS5QmDXYYOUGn+++aL2PR6wmtGoTKRTgISb9Gglukutebd4KDSSW1JgM52HPgxDW2srXhptg6m27IF5ro8pmMMZOwNFwVQr0I6Tz8bFixWHdtPeb+5YV3zdNXWmRPIi46w6KL2bOwCZAli0yV1Njjf5+YktmqSbWR7GqJrXk1nJspJqG7ol4wyJParChE4ppqsa8r9NnIwJF90wRZAOk8nfjz9biu3sttV2bOQgbsThg1+ftWgLnpUmnIl3GZWHXUpqoRQUjSbf0J+nmIHKFtYSULdKq0Snp3PT4ltWzYdmUr5GOVUL0gCM//C+yGaALAZHHwYlbTiNBY9nxwsWnXiWPKvpeIzzmnv5NiuQDAKwnsjqLWFjB/z+gZ2RjPYOOlJE0NgFmhqd5WOFgkF3DBVkpEsXyRT+wbwRNyzOvYrDuqh27lIaBOSSZEoQH0KqfK509eaKcSzA9L7y/NHG9OpH5dasGZ6VI1muvlenvBq7psxg7UwnTFXpdHtGZn6fwdtiyE+xzpElkXCJ/Z3+59RafvFUEgGInLdvVIrSxtA+aqlgGKmlXdqQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gsxKnxXxYGJ0XVCZO9PW4DAahiQSyKS6/QA7rvvXq4IQsvQrCdCKwazzUyY/WWm6BQUku4jx/810D+NylWxQ7bhtze9IN1G8W/XkJbzLGyuFGY9KlJ13Mz2APM+PPHC3omEfPJswqClL6amHU1OMjWggFJ56tb4yv1wBAbBsAKo0xWIFyBEONhYAisnAfRN1au9uANYKT1JHQEciNExoKP3tliT3fAx3l1A4BLsbE2p1T7IXvdK2m5DedSiJe4R3uTufWV8yfnKlNvpelmboD4FHP9/HYRGP4rFxfWv1oiduTfJXEoX0yBDg9QlxC9CWqlCmJic7eNT51c9JEdawv/CQVkzIT21LPgkrwR5mOaH3dAQ+gsaRcFlrvkKvAWXrSmPgX+NKVd3wn0wTziuiOmNMVZYksgFm2ivpm1eFlrom1TVxGoWtQBtuXIM/wo4y
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:58:29.1203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6609dcd-daa7-4717-d4a5-08de90f235c8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997695
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

On Thu Apr 2, 2026 at 12:32 PM CDT, Randolph Sapp wrote:
> On Thu Apr 2, 2026 at 3:53 AM CDT, Ilias Apalodimas wrote:
>> Hi Randolph
>>
>> On Thu, 2 Apr 2026 at 03:14, <rs@ti.com> wrote:
>>>
>>> From: Randolph Sapp <rs@ti.com>
>>>
>>> Backfill any fragmented EFI_CONVENTIONAL_MEMORY when LMB allocations
>>> start to fail. This may be a low memory environment, or maybe LMB is
>>> running up against a tricky reserved region.
>>>
>>> Signed-off-by: Randolph Sapp <rs@ti.com>
>>> ---
>>>  lib/efi_loader/efi_memory.c | 35 +++++++++++++++++++++++++++++++++--
>>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>>> index 882366a9f8a..f07cc39b157 100644
>>> --- a/lib/efi_loader/efi_memory.c
>>> +++ b/lib/efi_loader/efi_memory.c
>>> @@ -441,6 +441,27 @@ static efi_status_t efi_check_allocated(u64 addr, =
bool must_be_allocated)
>>>         return EFI_NOT_FOUND;
>>>  }
>>>
>>> +/**
>>> + * efi_get_conventional_start - find the highest conventional region s=
tart
>>> + *                              address with at least the specified nu=
mber of
>>> + *                              pages
>>> + *
>>> + * @pages:                      number of pages required to be in that=
 carveout
>>> + * Return:                      starting address of the give carveout
>>> + */
>>> +static u64 efi_get_conventional_start(u64 pages)
>>> +{
>>> +       struct efi_mem_list *item;
>>> +
>>> +       list_for_each_entry(item, &efi_mem, link) {
>>> +               if (item->desc.type !=3D EFI_CONVENTIONAL_MEMORY)
>>> +                       continue;
>>> +               if (item->desc.num_pages >=3D pages)
>>> +                       return item->desc.physical_start;
>>> +       }
>>> +       return 0;
>>
>> We've been bitten by this in the past and although unlikely 0 is a
>> valid address for some hardware. Can we return something different if
>> we don't find a match? UINT64_MAX perhaps?
>>
>>> +}
>>> +
>>>  /**
>>>   * efi_allocate_pages - allocate memory pages
>>>   *
>>> @@ -507,10 +528,20 @@ efi_status_t efi_allocate_pages(enum efi_allocate=
_type type,
>>>         /* Reserve that map in our memory maps */
>>>         ret =3D efi_update_memory_map(efi_addr, pages, memory_type, tru=
e, false);
>>
>> In theory the lmb and the EFI maps are in sync. I haven't checked
>> close enough yet, but do you have cases where lmb_alloc worked and
>> updating the efi memory map failed?
>
> Fair point. Now that I've fixed the FDT warning I should probably check i=
f I can
> actually reproduce the issue that actually required this.

Yeah, this patch isn't necessary anymore. I suppose it should be dropped as=
 it
would potentially mask any discrepancies between the two maps.

Out of curiosity, is there any plan to merge the EFI and LMB allocators mor=
e in
the future, or is the current layering scheme the furthest we want to go?

>>>         if (ret !=3D EFI_SUCCESS) {
>>> -               /* Map would overlap, bail out */
>>> +               /* Map would overlap, try something else */
>>>                 lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
>>>                 unmap_sysmem((void *)(uintptr_t)efi_addr);
>>> -               return  EFI_OUT_OF_RESOURCES;
>>> +
>>> +               /* See if there is any EFI_CONVENTIONAL_MEMORY allocati=
ons */
>>> +               if (type !=3D EFI_ALLOCATE_ADDRESS) {
>>
>> Can you please inverse this. It's going to reduce the identation.
>> if (type =3D=3D EFI_ALLOCATE_ADDRESS)
>>> +                       *memory =3D efi_get_conventional_start(pages);
>>> +                       if (*memory !=3D 0)
>>
>> Same here
>>
>>> +                               return efi_allocate_pages(EFI_ALLOCATE_=
ADDRESS,
>>> +                                                         memory_type, =
pages,
>>> +                                                         memory);
>>> +               }
>>> +
>>> +               return EFI_OUT_OF_RESOURCES;
>>>         }
>>>
>>>         *memory =3D efi_addr;
>>> --
>>> 2.53.0
>>>
>>
>> Thanks
>> /Ilias

