Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A219AF8D762
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 19:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B87F84262;
	Thu, 16 Apr 2026 21:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oIodWqdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F004D8426C; Thu, 16 Apr 2026 21:01:30 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1742084214
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yv0/TcgyViK2o+zoSf8SN3pVwo+QlLd1zn+ugZBX7J5QZy+BNQfILgMfMiPJzytdYhv/nb9/j9xPn0WXAbaiQ5fkJmRtkh4ndQXnruWbdpxgy4RqK8uAeEZmRensqCtaERpJ/5PRBwmMPk0YPFooCA27xKCfp+/iUG4tt6K8RyX1IiYSGO8mx3shmoB0lPKQDT8+HanORipxRfCcik7oGL4oDkGeaXzz6v7vgNbNvGN0XNdKrziIegOtM2oRooxy+P5idLFqwuqNQFqQMYezj1yP6nuoZ3Yise5eGksxnEjD6bf5QQWNl2blgRXWnJXt50nLmNMNS1tT54EazTN4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP0INy0aBwNMIR7npuFRCIE3agIVUi3VJTE3Xamr5zI=;
 b=afI/WlRD9MkciJbRnQ6lvnCxHOuS1tFsjcFDbeNiU+TfwoggtbgF2XPdV4hR+Ik6x6AQ50B+TYKzM3PyxnyG4fHY7TzIVFoJxw8WzcmLlMlNqGMvgWedeqy7PtRRS24/NUQ5JhRo9B42L0hKw4g2QyBdobsmDw2/xUArG2CAAVukinD04URinnQgdM1V4eiDNnaRnUxvwoZ0v5Uu66LPJ/CWPATcTRDALXvgKoIeC+9QaaJGMjB+A2CGnVV8kD1t3Cop8hCbootObnpAqrCNVylh10JXAourHLE9A1oQaQYbbz1RnAnRjZ5EUHlonUElNW8zVOQ8w0u8th5SZzcLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP0INy0aBwNMIR7npuFRCIE3agIVUi3VJTE3Xamr5zI=;
 b=oIodWqdIHXMOgbtAodgAkcdQJo8L4h69hsbmBKXIdgKxTVA8A0z0xQmuT4LjP64k6AGQtijC5Q0yyJc1mEyBYtI5sbDrTRrLdVZ1nXu6jmSBZ51FCdUjTLtkWdoS0935i2oZu2XWDnOpjmxtmQDGWOgwJFy4qWnlFTpDxa9Q+LM=
Received: from SJ0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:a03:3a0::20)
 by DS7PR10MB5071.namprd10.prod.outlook.com (2603:10b6:5:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 19:01:24 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::44) by SJ0PR03CA0255.outlook.office365.com
 (2603:10b6:a03:3a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 19:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 19:01:22 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 14:01:16 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 14:01:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 14:01:16 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63GJ1G7m327669;
 Thu, 16 Apr 2026 14:01:16 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Apr 2026 14:01:16 -0500
Message-ID: <DHUT7XN85MRK.18B9QGYDHEPIB@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 6/6] memory: reserve from start_addr_sp to end_addr_sp
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-7-rs@ti.com>
 <CAC_iWj+2=ajV0cXFT6a5Y2oqtTwcaPRcpkYqTbu4o+jbFmX+5w@mail.gmail.com>
In-Reply-To: <CAC_iWj+2=ajV0cXFT6a5Y2oqtTwcaPRcpkYqTbu4o+jbFmX+5w@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|DS7PR10MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: 866cef8e-a831-4af3-1e6f-08de9bea8d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vRo9a7wrjr+ECieMOgLNbNEUCKJ37q5KUTm7Fn61v6LWVVa1c50hb48D5sAq9685s6smkUlsdJ9likPonmORKtHX7TVNShBdnmAOkWADATKhITY8DOSBB4zA3eJEUugPBvcxXtnSpi9DnSy2VTrkhrzNaEu3Vp/KKQ8cLQKVDYqjAbG+PwsHTt/oTmCYMWmJA63QR9eb2WXnWz7ZwgscMx/JcfKZqCb4LT559SJl37fEOb+Gx/drB2fWHy+q1IKvRrZiTU97wm/7e8G/jxz5JswKHfVn9u5OUDROqFklVcpHPyb6hnZEUzUWkGmQAWe+cB2XglSRB3dsFsFIwQDAFXF+UUIpOibkfqo7LvokFYoSbK+FAQ9fSFsRvt60psjKSMI4PQSesP4m195aA16rpFhsvgCJEgp5JlLmSatTFL16GRDjJ8VBaTSgJmab5jYQYM7vh/7rQEOyjxGu58udkFawFzUQdBMHGLA+qjAiMjCGO0SQGje+xgdWJyy39NHegxZi6tKWUgj1t+iaz7PGk7RJlNstfJMFw6xPGPE211WBMG+czfTIJqic/Hz3s3VEWVFGwQxVfTuegKO8tA9oIBEHZ5FgrVHpKgPs4AA9KQUGGFnbVrAXOYlDbgz3/4N1JBvpxqEyqsGwJNdebariete7QZH+Hqu1W4Tj2KLvooDAE7bJ6FqyV5n/VSeWavaVhHijiNhzfrEcU7WvLqvpms5OE7Kyc5aowuV0OKkThfkxwWGqtDv+h1pzn1hKFn8swrr77PwugnN66iI+bK1Myw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V8F5xk5VWsP78DYg6aE7DXKrvI86+JtNeYhswvYFJXmZcxop72iPX7+0cqKCpZcdiLDvB2kCFrjeiW1+jd1CJJCR8xpvOpYQ7jbjatixEL34pUSPco6sSXrLNRo/uPqBKMs3LfD3Z0OhdvB/PNOI8/hAHP1/N+9Z9+NaNYq9qAToEA1XeVweJ9w+hZYIZCe7EjBCgRD03yb4t299poT9lGacMPjoWMm771qk3SVNpqVjjt3eraw4yEEgapT8wJ7GaJjSUg+kAV1iH4aR5PjbPpp1qqcZeNBtDjA5dWQc2P4COy6blyVCSUHdqbRh6mYQUzPbEXOgo9BJZyjTeQBb+72/kEeoFuvnV5A0q1+S3HNMW/UvM6dwCe9Knen5kWKUk1Kp0O3wDxgr71m3MWtQOhiWIPi1tadYRzX4c7uPSsV9II51pKpt/ENc0lpUZBhE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 19:01:22.2982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866cef8e-a831-4af3-1e6f-08de9bea8d0e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5071
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

On Thu Apr 16, 2026 at 9:37 AM CDT, Ilias Apalodimas wrote:
> Hi Randolph,
>
>
> On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>>
>> From: Randolph Sapp <rs@ti.com>
>>
>> Add a new global data struct member called end_addr_sp. This stores the
>> original value of relocaddr, directly from setup_dest_addr. This is
>> specifically to avoid any adjustments made by other init functions.
>>
>> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
>> gd->end_addr_sp instead of gd->ram_top. This allows platform specific
>> relocation addresses to work without unnecessarily painting over a large
>> range.
>>
>
> Is there a platform we can test the changes? Running the in QEMU had
> no differences.

Not yet. This is a mandatory requirement for pocketbeagle2, but otherwise t=
he
default behavior is the same as it ever was.

You can change the relocation address in the function you snipped out below=
 to
an arbitrary value for testing.

>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>
> [...]
>
>>  #ifdef CFG_PRAM
>> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/glo=
bal_data.h
>> index 745d2c3a966..2f3ef26a17c 100644
>> --- a/include/asm-generic/global_data.h
>> +++ b/include/asm-generic/global_data.h
>> @@ -115,6 +115,12 @@ struct global_data {
>>          * @start_addr_sp: initial stack pointer address
>>          */
>>         unsigned long start_addr_sp;
>> +       /**
>> +        * @end_addr_sp: the end of memory currently in use by uboot,
>> +        *               should be the original value of the relocaddr b=
efore
>> +        *               any other allocations shift it
>> +        */
>> +       unsigned long end_addr_sp;
>>         /**
>>          * @reloc_off: relocation offset
>>          */
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index b3b292ebf56..bd0d875a8cd 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -870,8 +870,8 @@ static void add_u_boot_and_runtime(void)
>>         /* Add U-Boot */
>>         uboot_start =3D ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>>                        uboot_stack_size) & ~EFI_PAGE_MASK;
>> -       uboot_pages =3D ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
>> -                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
>> +       uboot_pages =3D ((gd->end_addr_sp - uboot_start) + EFI_PAGE_MASK=
) >>
>> +                     EFI_PAGE_SHIFT;
>
> The map_sysmem dance is still needed here for sandbox.
>

Why? We're not using that address directly. We're just trying to figure out=
 how
large the carveout region is.

There's not anything funky going on with the global data structure for sand=
box
functionality is there? LMB definitely didn't do anything to account for th=
at.

>>         efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICE=
S_CODE,
>>                               false, false);
>>  #if defined(__aarch64__)
>> diff --git a/lib/lmb.c b/lib/lmb.c
>> index 7ecc548d831..da61b005154 100644
>> --- a/lib/lmb.c
>> +++ b/lib/lmb.c
>> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_siz=
e_t size, u32 flags)
>>
>>  static void lmb_reserve_uboot_region(void)
>>  {
>> -       int bank;
>> -       ulong end, bank_end;
>> +       ulong size;
>>         phys_addr_t rsv_start;
>> -       ulong pram =3D 0;
>>
>>         rsv_start =3D gd->start_addr_sp - CONFIG_STACK_SIZE;
>> -       end =3D gd->ram_top;
>> +       size =3D gd->end_addr_sp - rsv_start;
>>
>> -       /*
>> -        * Reserve memory from aligned address below the bottom of U-Boo=
t stack
>> -        * until end of RAM area to prevent LMB from overwriting that me=
mory.
>> -        */
>> -       debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
>> -
>> -#ifdef CFG_PRAM
>> -       pram =3D env_get_ulong("pram", 10, CFG_PRAM);
>> -       pram =3D pram << 10; /* size is in kB */
>> -#endif
>
> This functionality is removed, but we still have boards defining CFG_PRAM

The PRAM allocation occurs before this, and it is carved out of the region
covered by start_addr_sp through end_addr_sp. It's actually part of the rea=
son I
needed to add end_addr_sp, as it moves the relocation address pointer. We d=
on't
need to account for it separately now.

>> +       debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
>>
>> -       for (bank =3D 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>> -               if (!gd->bd->bi_dram[bank].size ||
>> -                   rsv_start < gd->bd->bi_dram[bank].start)
>> -                       continue;
>> -               /* Watch out for RAM at end of address space! */
>> -               bank_end =3D gd->bd->bi_dram[bank].start +
>> -                       gd->bd->bi_dram[bank].size - 1;
>> -               if (rsv_start > bank_end)
>> -                       continue;
>> -               if (bank_end > end)
>> -                       bank_end =3D end - 1;
>> -
>> -               lmb_reserve(rsv_start, bank_end - rsv_start - pram + 1,
>> +       if (gd->flags & GD_FLG_SKIP_RELOC)
>> +               lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len,
>>                             LMB_NOOVERWRITE);
>> -
>> -               if (gd->flags & GD_FLG_SKIP_RELOC)
>> -                       lmb_reserve((phys_addr_t)(uintptr_t)_start,
>> -                                   gd->mon_len, LMB_NOOVERWRITE);
>> -
>> -               break;
>> -       }
>> +       else
>> +               lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
>>  }
>>
>>  static void lmb_reserve_common(void *fdt_blob)
>> --
>> 2.53.0
>>
>
> Thanks
> /Ilias

