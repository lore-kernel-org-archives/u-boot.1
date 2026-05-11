Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444BBCD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 19:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1BF183C2B;
	Mon, 11 May 2026 21:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UCL7ZQlG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E840A83E36; Mon, 11 May 2026 21:41:14 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4EC08394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 21:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viCVTH58mkWZICvIU3VOW48t0G3OztaMKHjkQWWHtUfG2KUwmtkxz4lCEHAMrwGg25Cj8aqf+GEyullWUMDzfsS6ZabLhNFKGJbKrYNRD3xsWwvOWplrPaws+dZ2JzCfevpi3b4oUaltC987rX+/mDPufmuxp1xxRlp1egHnQ78VRFE18cm8CSfQ4+v3h6x/OaJidLrHGV6a9L95JfLgzZAwZ38WBk4XX1CJPRFeXuOfWNIqDZ08oBX5ZhsMF3r1hXMB468rwYeWxOxTkWdJUvGajxUCwZOr0/+uTMUKUe1E8VUiUogCCQgYgn6ToXjomUF+6/+yJUKLzlnAagW6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNmwxHAeazXg6ju8RNL/PSxSgu0Kq8Sarl4uuNH6fTU=;
 b=a6P1TNFZAlxkZnoP7DOejyBYZp6MGU2hUCjhyNbNK9rLVD8n3cr1HbIMhh7h9UOEOTATZwa9aR/QwCquSXoKh9fG6gRCJTZg0Fte/Ryd499D8MuZ7VS3MY+r/9JDq2XzuB0YlGPKWWSIiZek7dDr1rb2IxITaPMcgoxjsIX1OXgtgQ/1bipGviUXfBaspjXdKflIgf/J3vzsusqluO2qgoOpnvuQwAb3dNIGAlzRz2E3Jqe6zm9dioLYHbtpskRo9RmWiX4bc5I6aDTmdu5bWdGF+2mBQqp/aPH0P1Ut7bF8RTbi8OroJkr1tE8tI6DVeDx4Rb7iuzJh2FI2naox+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNmwxHAeazXg6ju8RNL/PSxSgu0Kq8Sarl4uuNH6fTU=;
 b=UCL7ZQlGvcMIi1P8g0Hh8xo03pbJLOH9KqrBDu1tMc837fWzCz6VuLdreEz5IiXDIKqKgVsIAzHKOq9iDmwvSij3+QEs4psG3+yJWxlO5rgUyM2dVzaFFXCVPCSMudj+XAnSmf+0IaVZYfmDEfvtRZU7QaxLaddEXIrwQq50/z8=
Received: from BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27)
 by CYYPR10MB7569.namprd10.prod.outlook.com (2603:10b6:930:bb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 19:41:06 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:329:cafe::b8) by BLAPR03CA0082.outlook.office365.com
 (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 19:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Mon, 11 May 2026 19:41:05 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 14:41:02 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 14:41:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 14:41:02 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BJf2Ff4071516;
 Mon, 11 May 2026 14:41:02 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 May 2026 14:41:02 -0500
Message-ID: <DIG3Q08V6K3T.3CISX3G3X19LO@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv6 3/3] memory: reserve from start_addr_sp to
 initial_relocaddr
From: Randolph Sapp <rs@ti.com>
To: Simon Glass <sjg@chromium.org>, <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260508222911.450165-1-rs@ti.com>
 <20260508222911.450165-4-rs@ti.com>
 <CAFLszTjPttabQ-Pqm3JrHmV8vBY77NFJmUKixkwEYYytkshgjA@mail.gmail.com>
In-Reply-To: <CAFLszTjPttabQ-Pqm3JrHmV8vBY77NFJmUKixkwEYYytkshgjA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CYYPR10MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ede05c-95c1-439c-d2eb-08deaf953de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hoFaJRnE3L/zW4Tsd8+VebX5KfeJUJnSaokAvo8tgpz+utMBCNRtneDQTWUDclR0BDEKeqKW/ZC02NVZKo+TXAJ/tuLm2gEcEYWYmch0GtYICMuL84IG3TIBCEhOcWmonIDredMcBEuyl0F4D8dsAGQ6lHgnY9JlKOs5jVbDcirkxC8RuUKVTQYbWBD1nnYlPQueuvYmqhS1uXvV4VaPlOXwGrtN0EUE9njTVKJa5Y6IMmJPKCIYbGCPBTKzI1s6UUBzqxCV2NE+A4HVzdG/xg0lE8L7XvaxsSReAXIjqJZ9+vYs9POT56zZYuAA+JvBmfq65MQMEgXlVl8SZAoc19eJFQI34BXImNL0GMPzilBjYNOTITvnqwU5eemZHyU+xwf9LMgQFvFfXmvf5a1VeO4xxHM43StJDjME/EL66Q3g65O/cnXNM9mojkYl1l/S0KxJWF+Zk729NcbwL9BSGGLV6kVT5G/a854euy8Gn9UM8H3ugQyxIIxIIpatlrFN8WofA+LCJBRRfVSZsudw9XWXEkIhF6WHMMww2IQqu7cb7EQHC+Ed6xIo+/lP5zZRZzzNMohJTZuoe5lMsX2khIk9p9IHCFq8x6tpJE6FJq0Zp7wQjiypnE7QS548aoOqA8+DLZVhJs69KNMkaMZfpSuLgbpx4Xth4wdoUPVo6CPaDmBPVq60wAgiyZ7x+ftsBot/6vMQtGadcl491c+85Z9JzvfCC5Jkt4Cv3CcgscY=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /2G35Lw7iLQxo90meMbUoqVnOX6IHZa/6oF7gV/fDMI03ea8bGNL6/zPVoFXWDT8qqtYr5+q9/E6PQnhpGbw0QN/HZpDymh25OpVusb97QG/+tkKizSUCwIQhWyWhXBrRAGkX0404nWUO5EgFgT9Z4kPpEUIvPGuGVbcjC0IWOR2pP+1OkACYgmxunth5/rlYm7nSmdybMbNutkCCfsyH5Z4cbh4bImLpPWnHrIa28aUW+8UXN97TKFBampsoJxNpZ0dgz5N7QGZgf7ksNQ6kLHv9xw3YXC7Z9Iqd7Go5RvEv1xnx3E8KQugbd9r+S7TPrIuz7AGyXFdv+JmPcEy0ouBRu0wFslwuIt07qao1XNE3dRB/bd6bt8aDlzrVgevh37YV+O9zHVEsujEXN6YH5x6spcqnReC/tgFJu+Q7qyw330IuXHpIFtOsG23L5/i
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 19:41:05.5075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ede05c-95c1-439c-d2eb-08deaf953de0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7569
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

On Mon May 11, 2026 at 1:28 PM CDT, Simon Glass wrote:
> Hi Randolph,
>
> On 2026-05-08T22:29:09, Randolph Sapp <rs@ti.com> wrote:
>> memory: reserve from start_addr_sp to initial_relocaddr
>>
>> Add a new global data struct member called initial_relocaddr. This
>> stores the original value of relocaddr, directly from setup_dest_addr.
>> This is specifically to avoid any adjustments made by other init
>> functions.
>>
>> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
>> gd->initial_relocaddr instead of gd->ram_top. This allows platform
>> specific relocation addresses to work without unnecessarily painting
>> over a large range.
>>
>> Since PRAM comes out of this initial area up to initial_relocaddr, we no
>> longer need to account for it separately.
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>>
>> common/board_f.c                  |  9 ++++++++-
>>  include/asm-generic/global_data.h |  7 +++++++
>>  lib/efi_loader/efi_memory.c       |  2 +-
>>  lib/lmb.c                         | 39 ++++++--------------------------=
-------
>>  4 files changed, 22 insertions(+), 35 deletions(-)
>
> BTW I am missing a change long in this patch, so a bit of guesswork here.

I tend to keep the changelogs for a series in the series cover letter. I as=
sume
tracking per patch is the preference for this list based on this message.

>> diff --git a/common/board_f.c b/common/board_f.c
>> @@ -330,6 +330,8 @@ __weak int arch_setup_dest_addr(void)
>>
>>  static int setup_dest_addr(void)
>>  {
>> +     int ret;
>> +
>>       debug("Monitor len: %08x\n", gd->mon_len);
>>       /*
>>        * Ram is setup, size stored in gd !!
>> @@ -356,7 +358,12 @@ static int setup_dest_addr(void)
>>       gd->relocaddr =3D gd->ram_top;
>>       debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
>>
>> -     return arch_setup_dest_addr();
>> +     ret =3D arch_setup_dest_addr();
>> +     if (ret !=3D 0)
>> +             return ret;
>> +
>> +     gd->initial_relocaddr =3D gd->relocaddr;
>> +     return ret;
>>  }
>
> Please use 'if (ret)' to match U-Boot style. The trailing 'return
> ret;' is misleading since ret is known to be zero - make it 'return
> 0;'.
>
>> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/glo=
bal_data.h
>> @@ -107,6 +107,13 @@ struct global_data {
>>        * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
>>        */
>>       unsigned long relocaddr;
>> +     /**
>> +      * @initial_relocaddr: end of memory currently in use by uboot
>> +      *
>> +      * This should be the original value of relocaddr before any other
>> +      * allocations or reservations shift it.
>> +      */
>> +     unsigned long initial_relocaddr;
>
> The kerneldoc summary is misleading: 'currently in use' suggests live
> state, but this is written once at the end of setup_dest_addr() and
> never updated. Please reword to something like 'initial top of the
> U-Boot reservation' and note that it is set once in setup_dest_addr().
> Also 'uboot' should be 'U-Boot'.
>
>> diff --git a/lib/lmb.c b/lib/lmb.c
>> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_siz=
e_t size, u32 flags)
>>
>>  static void lmb_reserve_uboot_region(void)
>>  {
>> -     int bank;
>> -     ulong end, bank_end;
>> +     ulong size;
>>       phys_addr_t rsv_start;
>> -     ulong pram =3D 0;
>>
>>       rsv_start =3D gd->start_addr_sp - CONFIG_STACK_SIZE;
>> -     end =3D gd->ram_top;
>> +     size =3D gd->initial_relocaddr - rsv_start;
>>
>> -     /*
>> -      * Reserve memory from aligned address below the bottom of U-Boot =
stack
>> -      * until end of RAM area to prevent LMB from overwriting that memo=
ry.
>> -      */
>> -     debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
>> +     debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
>
> Please keep a trimmed version of the explanatory comment - it
> documents the intent of this reservation and is more useful than the
> surrounding context.
>
>> diff --git a/lib/lmb.c b/lib/lmb.c
>> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_siz=
e_t size, u32 flags)
>> -     for (bank =3D 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>> -             if (!gd->bd->bi_dram[bank].size ||
>> -                 rsv_start < gd->bd->bi_dram[bank].start)
>> -                     continue;
>> -             /* Watch out for RAM at end of address space! */
>> -             bank_end =3D gd->bd->bi_dram[bank].start +
>> -                     gd->bd->bi_dram[bank].size - 1;
>> -             if (rsv_start > bank_end)
>> -                     continue;
>> -             if (bank_end > end)
>> -                     bank_end =3D end - 1;
>> +     lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
>
> The old code walked CONFIG_NR_DRAM_BANKS and clamped the reservation
> to the bank containing rsv_start. The new code drops that and just
> reserves [rsv_start, initial_relocaddr). On platforms with
> non-contiguous banks (where U-Boot occupies the top bank and there is
> a hole below it), this can mark a range that is not all RAM. Is that
> intentional? If so the commit message should call it out; if not,
> please re-add a sanity check so we do not reserve across holes.

I had a few thoughts about this in the past week. Initially this bank walki=
ng
behavior seemed more than a little unusual to me. It appears here and in 2 =
other
places. (FDT and kernel image loading, if I recall correctly.)

I was mulling over adding it back in as-is, but this really feels like some=
thing
LMB should be aware of and should handle on it's own during the reservation=
 of
those regions. Something akin to the EFI allocator's conventional memory ov=
erlap
check.

Seems like most of the infrastructure for that is already there. We have a
separate list tracking memory banks already. It was just bothering me that =
there
are quite a few instances where the allocator is blindly receiving external
information instead of taking more agency in the act of reserving that memo=
ry.

Suppose I'll just reinstate that old logic though as this series has drug o=
ut
much longer than I initially intended.

>> diff --git a/lib/lmb.c b/lib/lmb.c
>> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_siz=
e_t size, u32 flags)
>> -#ifdef CFG_PRAM
>> -     pram =3D env_get_ulong('pram', 10, CFG_PRAM);
>> -     pram =3D pram << 10; /* size is in kB */
>> -#endif
>
> PRAM previously sat above the LMB reservation (the old code subtracted
> pram from the size so PRAM was left out of used_mem). With this patch,
> PRAM ends up inside the [rsv_start, initial_relocaddr) range and is
> now marked LMB_NOOVERWRITE - likely this is more correct, but it is a
> behaviour change for boards setting pram at runtime to be larger than
> CFG_PRAM - those bytes used to be available to LMB clients and now are
> not.
>
> Please spell this out in the commit message rather than the brief
> 'PRAM comes out of this initial area' line, so reviewers on PRAM-using
> boards know to look.
>
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> @@ -869,7 +869,7 @@ static void add_u_boot_and_runtime(void)
>>       /* Add U-Boot */
>>       uboot_start =3D ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>>                      uboot_stack_size) & ~EFI_PAGE_MASK;
>> -     uboot_pages =3D ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
>> +     uboot_pages =3D ((uintptr_t)map_sysmem(gd->initial_relocaddr, 0) -
>>                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
>
> Hmmm, the current expression uses ram_top - 1 (inclusive top byte) and
> then rounded up via EFI_PAGE_MASK. The new one passes
> initial_relocaddr without the - 1 - so when initial_relocaddr is
> page-aligned this adds an extra page. What is the intention here?
>
> Regards,
> Simon

This stemmed from the misinterpretation of board_get_usable_ram_top being
exclusive. This is to be adjusted in the next revision.
