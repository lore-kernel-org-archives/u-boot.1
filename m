Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B40DD6AAF5
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 17:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1B784020;
	Thu,  2 Apr 2026 19:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jkVDk4Iv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6ED384056; Thu,  2 Apr 2026 19:32:33 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5865983F7D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 19:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBMzN9mqxa8ZPqJBgnaLUmNPrzAjpzhmM9sSag8ov7p8QkOPBK3hsm234WDBwpPseVw6XO38Hte6KhbQYvtltFQs0I9bcHLlNRN8slh4S4e5BNeNkJzukmSViavS06vHTgaFWjrqwMPisj75gy3nt0maSeeAGMZmIp9R3JqNUA/kTskZBqeRR8vzJ3hVb8O4GW338P5ui4fISFNJU+UNjGEiK7lPZ2V7xmweKaSkUWZ7rtbgUwgyov+DRP5LL+McjmxNwtGJqb6n8Y5rtJjcac1aMcrprul/HOD8xdN3sTrLYrwrQ6HecdVCWhXS7Mla5u07RA/t29mmvgvIYNn5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AldNSiHT1xIauL47sHGbA4vBegvlXSPdM9aUfuE2lxg=;
 b=D6d5jPvc/Yjr2UhA3PeTX0r4u6RLUEadm21yBup8/fBSBUkEq5uq3FL84+NFQ1HmEk1f8/e3yAlaJuC/wxv3rfUex0b+Ao4rV/4hDtgPj++j7P52Pd5WwH1yLXF11Guch29fw2fHUQmH0161BWawyL/88sLzKYyf393l4jAbNUNaaP4bHn3csp/sS6gvnbhNgp5cUSeUJ1BgtewALUh+0Tf2W9p9utGAK+uRTJIHxDfvD/fsvlsYR1yU5disBw5iHJ3d29vWa70nOWU8/GWUs07RIG6MOs9LORLPTXbCj5eQCv0Xsp5ToWEF0SXxcUiQIpQ7xfJwd2Oq76Mq/hSNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AldNSiHT1xIauL47sHGbA4vBegvlXSPdM9aUfuE2lxg=;
 b=jkVDk4IvO8u98RrWJeO4PvW/xcGoEiHP++MDyYpkSLl8iu7Nh+I3oKDBwQDxvqsbs20jx0OBvPEATbMMuTNscBteSeMiefEKdZxWLQpp+rzucyqya9YZxKGFjwmsxcx/DaBGFa0lHTUm36yq4LOAHWWfXoxgi39Nla0EPsd2SaI=
Received: from CY8PR10CA0006.namprd10.prod.outlook.com (2603:10b6:930:4f::29)
 by SJ2PR10MB7656.namprd10.prod.outlook.com (2603:10b6:a03:53e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 17:32:27 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:930:4f:cafe::10) by CY8PR10CA0006.outlook.office365.com
 (2603:10b6:930:4f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 17:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 17:32:25 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 12:32:25 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 12:32:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 12:32:25 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632HWPmL2424703;
 Thu, 2 Apr 2026 12:32:25 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 2 Apr 2026 12:32:25 -0500
Message-ID: <DHIUKA2JVA4H.V11Z7EF0I1A1@ti.com>
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/6] efi_memory: backfill EFI_CONVENTIONAL_MEMORY
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-6-rs@ti.com>
 <CAC_iWjKbeph+3M=GDy3_KeprSaUTVd3375O3Ny9GPV14XNBUgg@mail.gmail.com>
In-Reply-To: <CAC_iWjKbeph+3M=GDy3_KeprSaUTVd3375O3Ny9GPV14XNBUgg@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|SJ2PR10MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc79e4f-c6a0-45f7-6189-08de90ddce7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5gz9xjRIjEcQhl8pA3NbacjDZ0928iF3OG7FIlZ2dtByEAD264DhCC4wz0kd0ucXUHOy7UApgv+0unaknHWdfI3KAxzI1J+0Lyo6gmGTNiZEvip2AcXZpTLqywPVUcLLGW8U8kOQvxu7CqY2PR77rBavuadrsWLf8HDc+xcRMhjfVEHjRiknBBeWg+VYH92Gl0CmgHjfVVVR2dWIoGfZ/g9vSCRShcWMXU1KRc4o5ZdCxxXvA4kQlGa+bhcbxzu9gWQqJWSwXWyM4DUMAk2vOHfFVRnnlfogW8NYcThCenRREvUJ7sFWiv3Lv9bIuALP4eTv8wNCMHpSk67QOV9mG+dIR3rVTZnBv4Qv2162g7tXdf3WKEpd0yUznxj0dNVj6x4xztQIPeJESU1ElpdjNNCzXbTp6BwG9PeB94kOGkfs4UGpF+tZYi9QPVlW2rH+0ckSvdCMOxP0dBIL0eZ+f/xyDwwJSfgKl7jmM8M2BDQxCZesN/aSLu7WM0qYH4WYNTdP3U0Nylgl+G3iRFKSH38hwSNj8MTkThnzv9hkS/lt8P/IFudMTzYK7FzNg3e45XWbRkeTHYFFqgSVbOvJLufJVP+4rZmetJUWdL4AzLBKFn07EkhkmkYu2tSJztlDfqhyZaYPyHAoLWV+fXn/Mdb3cosfes8As6434PXyxZslIl/PHxRUwnjYpX/vT8NHL5C9fe/6cR+Hi1VQz1P0tKqCJFxSVc+FQs4KKwURdcnN0khaXAj7JxIjWLSHgzDK3TwVpEP9As+ziVmiOKa++g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PjU+5RmEoEUQrBttmN58Vbrc4+oszj+zExzvcXU3NJOur+eOO43rlLmverF+Zk4mhrDLwLAZGOHmfMa9oZtyhSO/TmsaseTeAdlw+XujFtH8cTS1Ee1Fjg67uYwghj1Py5nrghMJxpXh/r9JuIEeaVuDUAu/4GAMnJkLXMmNorkALy86ROYaiHVCX3SZuaZ9IMM0cGEmhn24b75MuYxccxx/knYg8tQrsClqp0ukzO/8N0UVYdUorP9DOH+hJXKvTEQqJNQx2LzHL7zj8z3rTouCmjeMa1U8ao5mEQUFx+4TvChmZSMkm9kkHfUbLYj9y5U995fgTbdn90YGGnHsn7IdKB0BJnCVdy4+f8dGPPTiYF1Q/JT57HBSXubbjuNZG6R/86iv0KNAsmsmOUmFNiDFbXN77SVS7PtxIPekP9nAHGSMt8dkCzKG0BlkTOUK
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 17:32:25.8716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc79e4f-c6a0-45f7-6189-08de90ddce7d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7656
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

On Thu Apr 2, 2026 at 3:53 AM CDT, Ilias Apalodimas wrote:
> Hi Randolph
>
> On Thu, 2 Apr 2026 at 03:14, <rs@ti.com> wrote:
>>
>> From: Randolph Sapp <rs@ti.com>
>>
>> Backfill any fragmented EFI_CONVENTIONAL_MEMORY when LMB allocations
>> start to fail. This may be a low memory environment, or maybe LMB is
>> running up against a tricky reserved region.
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>>  lib/efi_loader/efi_memory.c | 35 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index 882366a9f8a..f07cc39b157 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -441,6 +441,27 @@ static efi_status_t efi_check_allocated(u64 addr, b=
ool must_be_allocated)
>>         return EFI_NOT_FOUND;
>>  }
>>
>> +/**
>> + * efi_get_conventional_start - find the highest conventional region st=
art
>> + *                              address with at least the specified num=
ber of
>> + *                              pages
>> + *
>> + * @pages:                      number of pages required to be in that =
carveout
>> + * Return:                      starting address of the give carveout
>> + */
>> +static u64 efi_get_conventional_start(u64 pages)
>> +{
>> +       struct efi_mem_list *item;
>> +
>> +       list_for_each_entry(item, &efi_mem, link) {
>> +               if (item->desc.type !=3D EFI_CONVENTIONAL_MEMORY)
>> +                       continue;
>> +               if (item->desc.num_pages >=3D pages)
>> +                       return item->desc.physical_start;
>> +       }
>> +       return 0;
>
> We've been bitten by this in the past and although unlikely 0 is a
> valid address for some hardware. Can we return something different if
> we don't find a match? UINT64_MAX perhaps?
>
>> +}
>> +
>>  /**
>>   * efi_allocate_pages - allocate memory pages
>>   *
>> @@ -507,10 +528,20 @@ efi_status_t efi_allocate_pages(enum efi_allocate_=
type type,
>>         /* Reserve that map in our memory maps */
>>         ret =3D efi_update_memory_map(efi_addr, pages, memory_type, true=
, false);
>
> In theory the lmb and the EFI maps are in sync. I haven't checked
> close enough yet, but do you have cases where lmb_alloc worked and
> updating the efi memory map failed?

Fair point. Now that I've fixed the FDT warning I should probably check if =
I can
actually reproduce the issue that actually required this.

>>         if (ret !=3D EFI_SUCCESS) {
>> -               /* Map would overlap, bail out */
>> +               /* Map would overlap, try something else */
>>                 lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
>>                 unmap_sysmem((void *)(uintptr_t)efi_addr);
>> -               return  EFI_OUT_OF_RESOURCES;
>> +
>> +               /* See if there is any EFI_CONVENTIONAL_MEMORY allocatio=
ns */
>> +               if (type !=3D EFI_ALLOCATE_ADDRESS) {
>
> Can you please inverse this. It's going to reduce the identation.
> if (type =3D=3D EFI_ALLOCATE_ADDRESS)
>> +                       *memory =3D efi_get_conventional_start(pages);
>> +                       if (*memory !=3D 0)
>
> Same here
>
>> +                               return efi_allocate_pages(EFI_ALLOCATE_A=
DDRESS,
>> +                                                         memory_type, p=
ages,
>> +                                                         memory);
>> +               }
>> +
>> +               return EFI_OUT_OF_RESOURCES;
>>         }
>>
>>         *memory =3D efi_addr;
>> --
>> 2.53.0
>>
>
> Thanks
> /Ilias

