Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7782CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 21:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC3A84CE5;
	Fri,  8 May 2026 23:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pKOwoJly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B97A84CEF; Fri,  8 May 2026 23:34:02 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2285684CE4
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 23:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tj/x82Q2WtsNb6OfjswB7/NjjQEwg3mVaX+R6MQX3kQkAA3tVQgxERyzhXDYP4H3RPj5mO9GUesutMfjnBcCLu8VS1uCD9mbt1qegIhYFZhDU/FrafFQGDsct1wGaYJkCLud3N/3BMGw7s6aB5I7LuNQS3wtGUJ8gk7kOGZO/oYY4BVs7ROskFmo3NpeUjkIGkGkJ1Ij/3ChQKpWgw238aNtgTfBy3/H+BnUhxbbTEb1OlEmgBQGXRPtAmuHet8DUy0rUFXrn+dWGOrP5R41iSHtg3gRM0vJgIrxudH5MuzdSyxybeQaqHnv/tVED5nlH8FIm8hzh/2QdfOGTKT6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqRxb/dTnReWAMdq4tiGlPXG7uAhuGAJaCYWs7SpG4Y=;
 b=nGSN9MiIhUSWjXt3yKGHwq4VxrKQSFFQDG2wf3bVocBd0Ds/N7o6vdQXG/qJJtIytlReeRMJmS4pmgZOxuLwCK//Tw+pyvuUtF7uIH4OyT85A1DtzJWbq7sH4+cnxrC3nBrAQn3CkWboe3vrzo/nTcDVjkW6CfUsGhZIqoGIG6jBJmJQo84Z8ySfIWKXoCDoCD003/myUgjKz1X5Ct5C+PL2jQT0TWPYhoGqQ9/+FNEUKrREngMF8CiRXoK/M46fqeUM/8Co30XXqo80j3+CRmL6pnn3qr0lC0L3gdBPeF4dGA3QKZ2tfLS7XNj/vFdzcmw5NtQWt6Sj6yNJoIhjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqRxb/dTnReWAMdq4tiGlPXG7uAhuGAJaCYWs7SpG4Y=;
 b=pKOwoJlyzEOSEMVyFLsX+iUa6VjSQgamf46NWMJ8pLIwiZqQtjQfjKIMJykl7bCFx3pSLQFh95dLXYOLV6XKoVvVzkTgCWry1WaQ4mIxQpju3T9UOuFGtBZATrsHQOKZcoSWHgjhmDxWih1SYXzZVxaSSIJ2ETgend6KJQOpF2I=
Received: from BLAPR03CA0036.namprd03.prod.outlook.com (2603:10b6:208:32d::11)
 by DS0PR10MB7477.namprd10.prod.outlook.com (2603:10b6:8:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 21:33:53 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::16) by BLAPR03CA0036.outlook.office365.com
 (2603:10b6:208:32d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Fri,
 8 May 2026 21:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 21:33:50 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 16:33:50 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 16:33:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 8 May 2026 16:33:49 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 648LXnUI2390617;
 Fri, 8 May 2026 16:33:49 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 8 May 2026 16:33:49 -0500
Message-ID: <DIDM8Q87VEY4.2CP26R5UZ5SUV@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCHv5 6/6] memory: reserve from start_addr_sp to
 initial_relocaddr
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260422170946.3394481-1-rs@ti.com>
 <20260422170946.3394481-7-rs@ti.com>
 <CAC_iWjJBO=8y9A21U84diAma02VTc88Uib-LFiBei-XULK=d6Q@mail.gmail.com>
In-Reply-To: <CAC_iWjJBO=8y9A21U84diAma02VTc88Uib-LFiBei-XULK=d6Q@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS0PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 46170e54-7290-4a88-55fc-08dead497eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: akTHcQgGlndPV+uNx8n8zQvF3ltxTk+4OTIQbLcju19EY9QNQ+os0nWOc3PZI4J6aFKPgl0iwJ7luJXMGseq/RcvMeEfa8rDHcDPZcfNz2+Hck9naxvBFNZg7NhUkK2xaldWH/Rwe8mw+GmKSMSJajtrqIwbgXPQEZz0bK4L9LELuB35iPrfMVCgUu5TtH6IS1lglHdiCcpQDtvXgUfAsyKHRHuxbQ0NSdt/xiuFvVXA1S4kVSEDyKPtad/huy5el32RPR+WJARiBYMLsL88NEzweZXSiwQcLWXbJvkQ7xr8BZgANR2wSgwyBtfMvSdi6lxYqrAZW90NxZi/FyA6PqO0Y6X7XDKWekgvxPqcGo/MBEp7ShLO802WJKd0LjB1Ffkf3zlrPximqfRe/vvNi3zGzYaM6V3KoexhkNhnMJ02ghkOHuioAW+YNT3Yeu/Mn9n9r+PjiZseH8s/TMDN2uB6/aUTqs6gT43YSFrlk9KNk6txMhMBXgqUf36zkbQ5jZtGOV5A2Z7pRlxVIyvxQ9k7K2MGG4zV0Xx2XwMtQkAfTgZzqYd7h1XJg7j3AX+vD46WNbJB8GuO9uZD4MRxu9xLgHUyJ3Rwb2PzW3+v1MbQlCdlbr8IiNW1mSf3298ip17Q9oXJeUyYcvK6PWYfO4sjC6h5AxlKSn4HCra078o7q7OCNuyrIdL+jUksv6Xw
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6TuCw9KRT3xhBVw4ztrjk9ARP34CCjecFPnaItPNCxxzqyn789m1ix15Xb15YyWF6P/ymFo+MdLHMnkOW4bPb5FsueNC3abco4IgLWBXXQzwhUzDRISrAdsbC2926zPXHa5TMndcbNj/wecLYP/6W/AtbEXs+DI1fWL1NFL8df5Ei9P37d3rWOlOr+F1QheHEGCYFeyQDdPNVRXVyVjeVs7hCYNeJa3k1Svb5W9sWKZvHjUbV22XwzB2R8pIhxH4JdRIV5Oh6FFWrwH1jamJ+D8Gd1C8jDyZw/F+a9ae8yHwlZDuUWvWhLKVWV7qxPWRSHUCoSx9UPhqC1VPCWB1JF9QI3MEXntpLc6NpxB8fM3ScYHLIHKKnQ2V4nlSJqYG2vCWmW5FDUche3+0OTHMJtWMZetnSGcJmL4rCVAAWxSEBX209EJpEVfrXsM+w1/d
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 21:33:50.5686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46170e54-7290-4a88-55fc-08dead497eee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7477
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

On Tue May 5, 2026 at 6:24 AM CDT, Ilias Apalodimas wrote:
> Hi Randolph,
>
> On Wed, 22 Apr 2026 at 20:10, <rs@ti.com> wrote:
>>
>> From: Randolph Sapp <rs@ti.com>
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
>
> Several CI tests are complaining with this series.
> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/29989
>
> Can you have a look?
>
> Thanks
> /Ilias
>
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>>  common/board_f.c                  |  9 ++++++-
>>  include/asm-generic/global_data.h |  7 ++++++
>>  lib/efi_loader/efi_memory.c       |  2 +-
>>  lib/lmb.c                         | 39 +++++--------------------------
>>  4 files changed, 22 insertions(+), 35 deletions(-)
>>
>> diff --git a/common/board_f.c b/common/board_f.c
>> index ce87c619e68..31c6eb725fb 100644
>> --- a/common/board_f.c
>> +++ b/common/board_f.c
>> @@ -330,6 +330,8 @@ __weak int arch_setup_dest_addr(void)
>>
>>  static int setup_dest_addr(void)
>>  {
>> +       int ret;
>> +
>>         debug("Monitor len: %08x\n", gd->mon_len);
>>         /*
>>          * Ram is setup, size stored in gd !!
>> @@ -356,7 +358,12 @@ static int setup_dest_addr(void)
>>         gd->relocaddr =3D gd->ram_top;
>>         debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
>>
>> -       return arch_setup_dest_addr();
>> +       ret =3D arch_setup_dest_addr();
>> +       if (ret !=3D 0)
>> +               return ret;
>> +
>> +       gd->initial_relocaddr =3D gd->relocaddr;
>> +       return ret;
>>  }
>>
>>  #ifdef CFG_PRAM
>> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/glo=
bal_data.h
>> index 745d2c3a966..6c60a79c2ab 100644
>> --- a/include/asm-generic/global_data.h
>> +++ b/include/asm-generic/global_data.h
>> @@ -107,6 +107,13 @@ struct global_data {
>>          * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
>>          */
>>         unsigned long relocaddr;
>> +       /**
>> +        * @initial_relocaddr: end of memory currently in use by uboot
>> +        *
>> +        * This should be the original value of relocaddr before any oth=
er
>> +        * allocations or reservations shift it.
>> +        */
>> +       unsigned long initial_relocaddr;
>>         /**
>>          * @irq_sp: IRQ stack pointer
>>          */
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index 046a2bb4641..ece05c142f0 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -869,7 +869,7 @@ static void add_u_boot_and_runtime(void)
>>         /* Add U-Boot */
>>         uboot_start =3D ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>>                        uboot_stack_size) & ~EFI_PAGE_MASK;
>> -       uboot_pages =3D ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
>> +       uboot_pages =3D ((uintptr_t)map_sysmem(gd->initial_relocaddr, 0)=
 -

Ugh, It's specifically when gd->initial_relocaddr =3D=3D gd->ram_top. Somet=
hing
in map_sysmem gets angry. Seems weird to me though. The ram_top value is
supposed to be addressable.

It's ram_size - 1 on physical boards. GDB tells me that is not the case in =
the
sandbox though. Fun.

>>                        uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
>>         efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICE=
S_CODE,
>>                               false, false);
>> diff --git a/lib/lmb.c b/lib/lmb.c
>> index 9a8c70b778a..e5d4d726ab1 100644
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
>> +       size =3D gd->initial_relocaddr - rsv_start;
>>
>> -       /*
>> -        * Reserve memory from aligned address below the bottom of U-Boo=
t stack
>> -        * until end of RAM area to prevent LMB from overwriting that me=
mory.
>> -        */
>> -       debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
>> +       debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
>>
>> -#ifdef CFG_PRAM
>> -       pram =3D env_get_ulong("pram", 10, CFG_PRAM);
>> -       pram =3D pram << 10; /* size is in kB */
>> -#endif
>> -
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
>> +       lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
>>
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
>>  }
>>
>>  static void lmb_reserve_common(void *fdt_blob)
>> --
>> 2.53.0
>>

