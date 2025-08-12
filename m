Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9FCC87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 10:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F0483257;
	Tue, 12 Aug 2025 12:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W7n31P0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B11883287; Tue, 12 Aug 2025 12:42:27 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF7D383236
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 12:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CAgKZg1874883;
 Tue, 12 Aug 2025 05:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754995340;
 bh=Cv9Wsrc3W3opHMWe1z3/82g+ekdXKyoci2gQg4h/gWM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=W7n31P0jArherrCq0GqD+HBgH+WMxKcqIWigXcbdHQF6tKJ1554jto2pTaPXsjpxr
 96exzTCCEYB57KTzR0DFfKI0m3bPojjrbOx2suRRIkMbWNfWC/JOTtTkqApt6YLaIh
 j6OP082qwcqCcMNLnp+cJHADY8PI2BNarVjkomvk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CAgKpp242583
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 12 Aug 2025 05:42:20 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 05:42:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 05:42:19 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CAgEoj218622;
 Tue, 12 Aug 2025 05:42:15 -0500
Message-ID: <095932d6-f6e0-41db-8d21-8d35ea8a2052@ti.com>
Date: Tue, 12 Aug 2025 16:12:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] binman: Fix FIT image overlap issues for
 testFitSplitElf
To: Aristo Chen <jj251510319013@gmail.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <al.kochet@gmail.com>, <paul.henrys_ext@softathome.com>, <bb@ti.com>,
 <y.moog@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>, <afd@ti.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <ravi@prevas.dk>,
 <carlos.lopezr4096@gmail.com>, Aristo Chen <aristo.chen@canonical.com>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-3-aristo.chen@canonical.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250729125022.4220-3-aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 29/07/25 18:18, Aristo Chen wrote:
> Fix one binman test that has memory region overlap issue, the test case
> needed to be updated to use non-overlapping memory layouts.
> 
> * Tests fixed:
>   - testFitSplitElf
> 
> * Changes made:
>   1. ELF section layouts: added elf_sections_tee.lds with different
>      address for TEE to avoid overlap with ATF address defined in
>      elf_sections.lds
>   2. Makefile to properly build elf_sections_tee binary
>   3. Updat ftest.py to use separate ELF files for TEE vs ATF components
>      in split-elf operations.
> 
> An upcoming commit will validate if the memory region is overlapped
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  tools/binman/ftest.py                  |  2 +-
>  tools/binman/test/Makefile             |  6 ++++-
>  tools/binman/test/elf_sections_tee.c   |  1 +
>  tools/binman/test/elf_sections_tee.lds | 31 ++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 2 deletions(-)
>  create mode 120000 tools/binman/test/elf_sections_tee.c
>  create mode 100644 tools/binman/test/elf_sections_tee.lds
> 
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index a90db3c9351..f0c0487300d 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -252,7 +252,7 @@ class TestFunctional(unittest.TestCase):
>          TestFunctional._MakeInputFile('bl31.elf',
>              tools.read_file(cls.ElfTestFile('elf_sections')))
>          TestFunctional.tee_elf_path = TestFunctional._MakeInputFile('tee.elf',
> -            tools.read_file(cls.ElfTestFile('elf_sections')))
> +            tools.read_file(cls.ElfTestFile('elf_sections_tee')))
>  
>          # Newer OP_TEE file in v1 binary format
>          cls.make_tee_bin('tee.bin')
> diff --git a/tools/binman/test/Makefile b/tools/binman/test/Makefile
> index 4d152eee9c0..66279e0e207 100644
> --- a/tools/binman/test/Makefile
> +++ b/tools/binman/test/Makefile
> @@ -30,12 +30,13 @@ LDS_BINMAN_BAD := -T $(SRC)u_boot_binman_syms_bad.lds
>  LDS_BINMAN_X86 := -T $(SRC)u_boot_binman_syms_x86.lds
>  LDS_BINMAN_EMBED := -T $(SRC)u_boot_binman_embed.lds
>  LDS_EFL_SECTIONS := -T $(SRC)elf_sections.lds
> +LDS_EFL_SECTIONS_TEE := -T $(SRC)elf_sections_tee.lds
>  LDS_BLOB := -T $(SRC)blob_syms.lds
>  
>  TARGETS = u_boot_ucode_ptr u_boot_no_ucode_ptr bss_data bss_data_zero \
>  	u_boot_binman_syms u_boot_binman_syms.bin u_boot_binman_syms_bad \
>  	u_boot_binman_syms_size u_boot_binman_syms_x86 embed_data \
> -	u_boot_binman_embed u_boot_binman_embed_sm elf_sections blob_syms.bin
> +	u_boot_binman_embed u_boot_binman_embed_sm elf_sections elf_sections_tee blob_syms.bin
>  
>  all: $(TARGETS)
>  
> @@ -84,6 +85,9 @@ blob_syms: blob_syms.c
>  elf_sections: CFLAGS += $(LDS_EFL_SECTIONS)
>  elf_sections: elf_sections.c
>  
> +elf_sections_tee: CFLAGS += $(LDS_EFL_SECTIONS_TEE)
> +elf_sections_tee: elf_sections_tee.c
> +
>  clean:
>  	rm -f $(TARGETS)
>  
> diff --git a/tools/binman/test/elf_sections_tee.c b/tools/binman/test/elf_sections_tee.c
> new file mode 120000
> index 00000000000..01b200a365e
> --- /dev/null
> +++ b/tools/binman/test/elf_sections_tee.c
> @@ -0,0 +1 @@
> +elf_sections.c
> \ No newline at end of file
> diff --git a/tools/binman/test/elf_sections_tee.lds b/tools/binman/test/elf_sections_tee.lds
> new file mode 100644
> index 00000000000..501d85a1f68
> --- /dev/null
> +++ b/tools/binman/test/elf_sections_tee.lds
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2016 Google, Inc

Copyright year 2025

> + */
> +
> +OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
> +OUTPUT_ARCH(i386)
> +ENTRY(_start)
> +
> +SECTIONS
> +{
> +	. = 0x00100010;
> +	_start = .;
> +
> +	. = ALIGN(4);
> +	.text :
> +	{
> +		*(.text*)
> +	}
> +
> +	. = 0x00101000;
> +	.sram :
> +	{
> +		*(.sram*)
> +	}
> +
> +	/DISCARD/ : {
> +		*(.comment)
> +		*(.dyn*)
> +	}
> +}

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
