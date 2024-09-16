Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2ACC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 06:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0DA688E5C;
	Mon, 16 Sep 2024 08:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FE4/kQ1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B28B188E5F; Mon, 16 Sep 2024 08:04:32 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46DCB88815
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vaishnav.a@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48G648Rd102326;
 Mon, 16 Sep 2024 01:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726466648;
 bh=GSckGKxSgo39pZFmtVPaiyHsougQFps4laZbvCxLgwc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=FE4/kQ1UClMbxg63NpTpcvIBAxGJoBG29qqn1gpe1hayopavJ0n4ZL83d1P9PJ2dv
 7E+ZHjkV0kkTP0klKaPJMWYPRUrmtubpdYdjA5qA8cI9jneeBK8oXdWLByjQXbMEzA
 zIYIIRFmLJKK9DYO6cPFwFBIzeqWl6BO4S/wRs2M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48G6483r130180
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Sep 2024 01:04:08 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Sep 2024 01:04:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Sep 2024 01:04:08 -0500
Received: from [10.24.69.142] ([10.24.69.142])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48G643WG091151;
 Mon, 16 Sep 2024 01:04:04 -0500
Message-ID: <7c94a278-e7a1-4c82-9135-6cfedba1143b@ti.com>
Date: Mon, 16 Sep 2024 11:34:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/27] lmb: make LMB memory map persistent and global
To: Sughosh Ganu <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, Mark Kettenis
 <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, Patrick
 DELAUNAY <patrick.delaunay@foss.st.com>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, "Kumar, Udit"
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-6-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240826115940.3233167-6-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Sughosh

On 26/08/24 17:29, Sughosh Ganu wrote:
> The current LMB API's for allocating and reserving memory use a
> per-caller based memory view. Memory allocated by a caller can then be
> overwritten by another caller. Make these allocations and reservations
> persistent using the alloced list data structure.
> 
> Two alloced lists are declared -- one for the available(free) memory,
> and one for the used memory. Once full, the list can then be extended
> at runtime.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> [sjg: Optimise the logic to add a region in lmb_add_region_flags()]
> [sjg: Use a stack to store pointer of lmb struct when running lmb tests]
> ---
> Changes since V3:
> * Fix checkpatch warnings of spaces between function name and
>    open parantheses.
> * s/uint64_t/u64 as suggested by checkpatch.
> * Remove unneccessary parantheses in lmb.c as suggested by checkpatch.
> * Fix alignment in test/cmd/bdinfo.c as suggested by checkpatch.
> 
>   arch/arc/lib/cache.c                 |   4 +-
>   arch/arm/lib/stack.c                 |   4 +-
>   arch/arm/mach-apple/board.c          |  17 +-
>   arch/arm/mach-snapdragon/board.c     |  17 +-
>   arch/arm/mach-stm32mp/dram_init.c    |   8 +-
>   arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
>   arch/m68k/lib/bootm.c                |   7 +-
>   arch/microblaze/lib/bootm.c          |   4 +-
>   arch/mips/lib/bootm.c                |  11 +-
>   arch/nios2/lib/bootm.c               |   4 +-
>   arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
>   arch/powerpc/include/asm/mp.h        |   4 +-
>   arch/powerpc/lib/bootm.c             |  14 +-
>   arch/riscv/lib/bootm.c               |   4 +-
>   arch/sh/lib/bootm.c                  |   4 +-
>   arch/x86/lib/bootm.c                 |   4 +-
>   arch/xtensa/lib/bootm.c              |   4 +-
>   board/xilinx/common/board.c          |   8 +-
>   boot/bootm.c                         |  26 +-
>   boot/bootm_os.c                      |   5 +-
>   boot/image-board.c                   |  34 +-
>   boot/image-fdt.c                     |  35 +-
>   cmd/bdinfo.c                         |   6 +-
>   cmd/booti.c                          |   2 +-
>   cmd/bootz.c                          |   2 +-
>   cmd/elf.c                            |   2 +-
>   cmd/load.c                           |   7 +-
>   drivers/iommu/apple_dart.c           |   8 +-
>   drivers/iommu/sandbox_iommu.c        |  16 +-
>   fs/fs.c                              |   7 +-

In fs the reserved region is not being freed after read, while
other loaders free them (cmd/load.c), this patch uncovers the issue
since now other loaders cannot use the same memory location for load.
For example now someone cannot do:

mmc load .. $loadaddr ...
<do something with above contents>
tftp $loadaddr ..

where this worked previously since it was not global, I have sent a
fix for this :
https://lore.kernel.org/all/20240916054038.2125910-1-vaishnav.a@ti.com/

Thanks and Regards,
Vaishnav

>   include/image.h                      |  28 +-
>   include/lmb.h                        | 111 ++----
>   lib/efi_loader/efi_dt_fixup.c        |   2 +-
>   lib/efi_loader/efi_helper.c          |   2 +-
>   lib/lmb.c                            | 446 +++++++++++++---------
>   net/tftp.c                           |   5 +-
>   net/wget.c                           |   5 +-
>   test/cmd/bdinfo.c                    |  41 +-
>   test/lib/lmb.c                       | 542 +++++++++++++--------------
>   39 files changed, 714 insertions(+), 746 deletions(-)
> 

