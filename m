Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74765F99C60
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 20:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE7484214;
	Fri, 17 Apr 2026 22:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g+gmMNjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 488D98422D; Fri, 17 Apr 2026 22:47:48 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C34C8420C
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 22:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AikNLoaozuF02RNASsGI8AxyusKSziv7JQrWPy8YmbvOqAhOhEseap3UB6triUwR/HTiyzq+urXb29N2HCEMFe+g6vDA3vRkacD7yW9wxLphVu8fA9IvienYacolUhGYfp25+Zwem3uUnHIgDPHi9vqzz2cqmsyumfH9233Gj5ww1SWMW9M7BLYfSq7AY7/wF4RGAAlMd2JEk8xPCS7nejr368xGD/RRl9FKHVKPYZI7ddNtUGE18jVW4bNXpTDlVMCfzk3IoISu+HUwJtCj/C4NdNu9KCtPUs+G/d5BemmAmW0rPK2b77ln8VDZFPTPR6sw8I0RIsB1/dUegMaX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY7A6sZe4tBJAIR2zqs8oy9tUKSAiIUT9vop5kzcbX0=;
 b=dHWDgcn0Rn63H4/6J4OuoEnsLfISqB1LaLO0kBvWCrQ6GVizMIx1D71gzF6it11nGf0OKOSfAmvZRQbQZIP/TnAysbvSKcJ63JAghAJFdfQfhn8uo8GedrziZ0PDXoy5ft4SbDngb9ye1V5/+n7qI0+QiV24aNNF7AADao+N1FUYudzY03Tyk80pNaCLy6akEzYSXE99yR967CVCzDBLav0s5/bbZAgZrHPiSaU6H0R9Edlg3hMbARGUR+egVxlWDM7R7FIYDkcOLqOqX1catLuCdHcG5KD8bYwD1OXfKZjS8EmNBtooNqPtdB9aXV1RUjdMmXX6fpkClmZbQWMEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY7A6sZe4tBJAIR2zqs8oy9tUKSAiIUT9vop5kzcbX0=;
 b=g+gmMNjxRCQ6kyGiujVD6J0t7U8MT+lVBseamVEjSmategGL9TupYfnIO0ifgcJvubhUEtqb2ZoyQ6/cy0bvDof/vozjXWVSijziKCrlFLzFqz1/oUJ3QegBvbY1AQzmW+60PGe0+IWnm3H7MjGtdGP0WmSVRP0bStw+PQ90d5M=
Received: from SJ0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:33a::8)
 by MW5PR10MB5715.namprd10.prod.outlook.com (2603:10b6:303:19c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:47:41 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::97) by SJ0PR03CA0003.outlook.office365.com
 (2603:10b6:a03:33a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 20:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 20:47:40 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 15:47:40 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 15:47:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Apr 2026 15:47:39 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63HKldF72378879;
 Fri, 17 Apr 2026 15:47:39 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Apr 2026 15:47:39 -0500
Message-ID: <DHVQ3XX4U4OG.3T8QXYV5OHWFO@ti.com>
Subject: Re: [PATCHv3 6/6] memory: reserve from start_addr_sp to end_addr_sp
From: Randolph Sapp <rs@ti.com>
To: Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-7-rs@ti.com>
 <CAC_iWj+2=ajV0cXFT6a5Y2oqtTwcaPRcpkYqTbu4o+jbFmX+5w@mail.gmail.com>
 <DHUT7XN85MRK.18B9QGYDHEPIB@ti.com>
In-Reply-To: <DHUT7XN85MRK.18B9QGYDHEPIB@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|MW5PR10MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8c91c6-f8d6-463b-696a-08de9cc29155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XMZfSy4Lkz1jYB4eT0CL1CWhe8SY6twQEXU6Mj/JBB77uKXEYYwtaanZkh3Pz4BSjFjjDkzRNv5MKHyvDjV5Q2IpPbojqVub4bZSee5tY8fVrr7lmElu/G78NKqthGTCBXn4kEqo/76J9bCWVnNq9ZrtyAtze4I4Ad+Jcq5l54rTN5Lz6DZ7Hxb8u0cuVAdnKh5mGLvV6k+GFGjNPY+BVd/hsPgWQmhK07O3oJYXc/GQIZ54eJLLD5mGIkNn4IH8ZqF7R36STa3FlAoh8f73w/gUHvg1AZNW06yCowH6wfRM3gIKeJqzGSBDGrNk5V5i1njOnKOBmi4NeuEZA4ieX9V6Uhw3dJy3W+CpKmwJDVE4Z0vVum64z5FJYWQRL1p1ISunqd3HqaXi57fvmCOzwPao/507t2ZqrRu6a8PFtFsLjHamNbaw8DLenmAvBrlw1tPcrP+EdqUYeGLTi7d2tPOB2/Ptc98Kr6ncw9i47ShX2kMUIR45GcNoeqkTNYkrWk0SsWf/nstIbp97WK7AF+CJmBIlY/uT5DvsiiW8w+Po5PdbgOVWUEjHHSd3ZDn9Kxll1Vk62ysJP2p5BIRGuUivGzdAR+aV2IS2iQG4yXeJqY/Aa9drAGyyMmOl2sughM6Iu3+fvejwgvI9HYXuGlJhcYU2vEMgnrkl0m7CH8MrXEkuqALfPhPObYGpB5gTfZBcH6yMfG0Ndg3FO9rxtG4+RRx5ubYfW4fZ0xGI2qd03tK2vg5pYUJHGuSHhyKIepNZclBEIDjKOgUrolU9vw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: izIaO+Q3eLex71oj8U6CF+o1vi4RXEzlbcfHB1ISUmhZZDvzzomoY7O3dfdMnLP+04XlV5oe+g8nXmEMv0592WxhaQuGrpLGYz2DTzFz0FoldhApp/CgktjMSXW5zGjfZJ/FE/tB8/GEH9IcZKxk03l07c2/HUEcsRwWA1NUPKXlqNqziFTkY/8e6A7iO5O7rDTuXwaqHG3oeyZs34f+UQmFhoT181g2toaJZnVablIcl+HmbqkDHHdWEKutQLzhYUAGN4Hqf931ayCirWrxuhHAWTazi1TtjMbc9DAqZWaPm8kK9vwy0ZCPh/U0MoURvvX6URYpQoaobAcmBNGM3fAFzePor3nISsEZRgXbLdiMFRqsjRyHTydx5eXsszTV7xsNYmIM1C0EZv9YvL6irsqIEzvH9Ki/fiTzkxVWdSzHzEzp8ledlKpxLreQaqmB
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:47:40.7680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8c91c6-f8d6-463b-696a-08de9cc29155
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5715
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

On Thu Apr 16, 2026 at 2:01 PM CDT, Randolph Sapp wrote:
> On Thu Apr 16, 2026 at 9:37 AM CDT, Ilias Apalodimas wrote:
>> Hi Randolph,
>>
>>
>> On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>>>
>>> From: Randolph Sapp <rs@ti.com>
>>>
>>> Add a new global data struct member called end_addr_sp. This stores the
>>> original value of relocaddr, directly from setup_dest_addr. This is
>>> specifically to avoid any adjustments made by other init functions.
>>>
>>> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
>>> gd->end_addr_sp instead of gd->ram_top. This allows platform specific
>>> relocation addresses to work without unnecessarily painting over a larg=
e
>>> range.
>>>
>>
>> Is there a platform we can test the changes? Running the in QEMU had
>> no differences.
>
> Not yet. This is a mandatory requirement for pocketbeagle2, but otherwise=
 the
> default behavior is the same as it ever was.
>
> You can change the relocation address in the function you snipped out bel=
ow to
> an arbitrary value for testing.
>
>>> Signed-off-by: Randolph Sapp <rs@ti.com>
>>> ---
>>
>> [...]
>>
>>>  #ifdef CFG_PRAM
>>> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/gl=
obal_data.h
>>> index 745d2c3a966..2f3ef26a17c 100644
>>> --- a/include/asm-generic/global_data.h
>>> +++ b/include/asm-generic/global_data.h
>>> @@ -115,6 +115,12 @@ struct global_data {
>>>          * @start_addr_sp: initial stack pointer address
>>>          */
>>>         unsigned long start_addr_sp;
>>> +       /**
>>> +        * @end_addr_sp: the end of memory currently in use by uboot,
>>> +        *               should be the original value of the relocaddr =
before
>>> +        *               any other allocations shift it
>>> +        */
>>> +       unsigned long end_addr_sp;
>>>         /**
>>>          * @reloc_off: relocation offset
>>>          */
>>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>>> index b3b292ebf56..bd0d875a8cd 100644
>>> --- a/lib/efi_loader/efi_memory.c
>>> +++ b/lib/efi_loader/efi_memory.c
>>> @@ -870,8 +870,8 @@ static void add_u_boot_and_runtime(void)
>>>         /* Add U-Boot */
>>>         uboot_start =3D ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>>>                        uboot_stack_size) & ~EFI_PAGE_MASK;
>>> -       uboot_pages =3D ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
>>> -                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
>>> +       uboot_pages =3D ((gd->end_addr_sp - uboot_start) + EFI_PAGE_MAS=
K) >>
>>> +                     EFI_PAGE_SHIFT;
>>
>> The map_sysmem dance is still needed here for sandbox.
>>
>
> Why? We're not using that address directly. We're just trying to figure o=
ut how
> large the carveout region is.
>
> There's not anything funky going on with the global data structure for sa=
ndbox
> functionality is there? LMB definitely didn't do anything to account for =
that.

Ah. Symmetry, to answer my own question. We *may* get a virtual address.

That does bring up another issue though. What good does reserving a virtual
region that simply maps to a physical region do? Shouldn't we reserve the
physical region outright? Isn't that what LMB is tracking?

Suppose I need to read up on this sandbox and architecture dependent virtua=
l
addressing scheme.

>>>         efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVIC=
ES_CODE,
>>>                               false, false);
>>>  #if defined(__aarch64__)
>>> diff --git a/lib/lmb.c b/lib/lmb.c
>>> index 7ecc548d831..da61b005154 100644
>>> --- a/lib/lmb.c
>>> +++ b/lib/lmb.c
>>> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_si=
ze_t size, u32 flags)
>>>
>>>  static void lmb_reserve_uboot_region(void)
>>>  {
>>> -       int bank;
>>> -       ulong end, bank_end;
>>> +       ulong size;
>>>         phys_addr_t rsv_start;
>>> -       ulong pram =3D 0;
>>>
>>>         rsv_start =3D gd->start_addr_sp - CONFIG_STACK_SIZE;
>>> -       end =3D gd->ram_top;
>>> +       size =3D gd->end_addr_sp - rsv_start;
>>>
>>> -       /*
>>> -        * Reserve memory from aligned address below the bottom of U-Bo=
ot stack
>>> -        * until end of RAM area to prevent LMB from overwriting that m=
emory.
>>> -        */
>>> -       debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
>>> -
>>> -#ifdef CFG_PRAM
>>> -       pram =3D env_get_ulong("pram", 10, CFG_PRAM);
>>> -       pram =3D pram << 10; /* size is in kB */
>>> -#endif
>>
>> This functionality is removed, but we still have boards defining CFG_PRA=
M
>
> The PRAM allocation occurs before this, and it is carved out of the regio=
n
> covered by start_addr_sp through end_addr_sp. It's actually part of the r=
eason I
> needed to add end_addr_sp, as it moves the relocation address pointer. We=
 don't
> need to account for it separately now.
>
>>> +       debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
>>>
>>> -       for (bank =3D 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>>> -               if (!gd->bd->bi_dram[bank].size ||
>>> -                   rsv_start < gd->bd->bi_dram[bank].start)
>>> -                       continue;
>>> -               /* Watch out for RAM at end of address space! */
>>> -               bank_end =3D gd->bd->bi_dram[bank].start +
>>> -                       gd->bd->bi_dram[bank].size - 1;
>>> -               if (rsv_start > bank_end)
>>> -                       continue;
>>> -               if (bank_end > end)
>>> -                       bank_end =3D end - 1;
>>> -
>>> -               lmb_reserve(rsv_start, bank_end - rsv_start - pram + 1,
>>> +       if (gd->flags & GD_FLG_SKIP_RELOC)
>>> +               lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len=
,
>>>                             LMB_NOOVERWRITE);
>>> -
>>> -               if (gd->flags & GD_FLG_SKIP_RELOC)
>>> -                       lmb_reserve((phys_addr_t)(uintptr_t)_start,
>>> -                                   gd->mon_len, LMB_NOOVERWRITE);
>>> -
>>> -               break;
>>> -       }
>>> +       else
>>> +               lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
>>>  }
>>>
>>>  static void lmb_reserve_common(void *fdt_blob)
>>> --
>>> 2.53.0
>>>
>>
>> Thanks
>> /Ilias

