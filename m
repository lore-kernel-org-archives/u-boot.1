Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053C2C54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 16:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181F187F3A;
	Mon, 25 Mar 2024 17:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="k+DPBnnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FEDD87F06; Mon, 25 Mar 2024 17:33:43 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16338870D2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 17:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E82CF1FA1B;
 Mon, 25 Mar 2024 17:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1711384420;
 bh=eJM39iScw/02IYPEvM0rK3ALTz/ND41M9j+7q9hFWVc=; h=From:To:Subject;
 b=k+DPBnnZ2LSPjfSyY+vFdjCu4gUHBREopwnAywUuU878ZCoRiVr5zZ+lJY0lw5c5Z
 AQE4tvGbYQ6Y5jgXQ4cBLj6o07DUOcurJOdzf1+OGAij4JqFCoeU/+mCIH4dPEcFfT
 12z0fIxc36QH6RBO4JqrCEJzFF2RY9nCKEilxzDZG+I8D2sH36Hf0KM3Cudx7Rx3g4
 Qsg0E4r/2zAS8D/4N3twgBAGQDl/CBbp/N7hY33LM6XjcuLqJ4zaPvGWZgfuAkUHdJ
 BxHqQ5sccGlWpN+J92BIBYPeX4TDU/GoeU/l0GIKChEI0Ylgain8jVX1Vv/Qnbt/8F
 u5vXtYDYG6S1Q==
Date: Mon, 25 Mar 2024 17:33:35 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Sjoerd Simons <sjoerd@collabora.com>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, vitor.soares@toradex.com
Subject: Re: bugs with EFI "reserved" memory and LMB?
Message-ID: <20240325163335.GA155351@francesco-nb>
References: <fe9431c5-6806-1b7a-f9f4-dbe97ee13bba@toradex.com>
 <7d982879-5d8f-f850-20ab-6c9b7e4c9a9c@gmx.de>
 <20ea2123-d191-fcc2-bc0d-236ff1900c16@toradex.com>
 <7d9c1f63-5ede-56c4-60bb-76a258bc65fc@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d9c1f63-5ede-56c4-60bb-76a258bc65fc@gmx.de>
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

Hello all,
re-opening this old email thread ...

On Sat, Aug 12, 2023 at 08:23:32AM +0200, Heinrich Schuchardt wrote:
> On 7/27/23 14:14, Emanuele Ghidoli wrote:
> > On 27/07/2023 13:21, Heinrich Schuchardt wrote:
> > > On 27.07.23 13:08, Emanuele Ghidoli wrote:
> > > > Efi loader module have its own memory management that flags as reserved the
> > > > area between ram_top to ram_end (currently where dt reserved-memory is
> > > > falling).  uboot lmb updates reserved-memory by adding these
> > > > efi loader module areas (see lmb_reserve_common->efi_lmb_reserve).
> > > > 
> > > > 
> > > > On our system (AM62xx SoC, 512MB RAM) we have some reserved-memory specified in
> > > > the device tree (used for comunication with other microcontroller on the SoC,
> > > > OPTEE, ...) falling in the DDR range between 456 and 512 MB.
> > > > 
> > > > Normally U-Boot relocate itself at the end of DDR so it overlap this
> > > > reserved-memory and this of course does not work [1].
> > > > 
> > > > In this case U-Boot prints the following errors:
> > > > 
> > > >     ERROR: reserving fdt memory region failed (addr=9c800000 size=300000)
> > > >     ERROR: reserving fdt memory region failed (addr=9cb00000 size=100000)
> > > >     ...
> > > >     ERROR: reserving fdt memory region failed (addr=9e800000 size=1800000)
> > > > 
> > > > because U-Boot reserved area (lmb_flag LMB_NONE) overlaps with the FDT reserve
> > > > memories (lmb_flag LMB_NOMAP).
> > > > 
> > > > 
> > > > To fix this I moved the U-Boot relocation address, implementing
> > > > board_get_usable_ram_top() and therefore setting gd->ram_top to a lower value
> > > > with no overlap (448 MB).
> > > > 
> > > > 
> > > > The memory map is:
> > > > +---------------+ 512 MB
> > > > |DT reserved-mem|
> > > > +---------------+ 456 MB
> > > > |free space     |
> > > > +---------------+ 448 MB (ram_top)
> > > > |               |
> > > > |uboot          |
> > > > |               |
> > > > +---------------+ 0 MB
> > > > 
> > > > This is working fine (the board is able to boot, no memory overlaps) ...
> > > > 
> > > > however, in this configuration U-Boot we still have some errors prints while
> > > > loading linux dtb:
> > > > 
> > > >     ERROR: reserving fdt memory region failed (addr=9cb00000 size=100000 flags=4)
> > > >     ERROR: reserving fdt memory region failed (addr=9cc00000 size=e00000 flags=4)
> > > >     ERROR: reserving fdt memory region failed (addr=9da00000 size=100000 flags=4)
> > > >     ERROR: reserving fdt memory region failed (addr=9db00000 size=c00000 flags=4)
> > > >     ERROR: reserving fdt memory region failed (addr=9e780000 size=80000 flags=4)
> > > >     ERROR: reserving fdt memory region failed (addr=9e800000 size=1800000 flags=4)
> > > > 
> > > > And the reason of these error is complete different: The efi loader lmb memory
> > > > reservation (lib/lmb.c:efi_lmb_reserve()) is wrongly reserving some area.
> > > > 
> > > > 
> > > > 1) lib/lmb.c:lmb_reserve_common() reserve these memories:
> > > >     ~415M - 448M u-boot reserved area (lmb_flag LMB_NONE)
> > > >      456M - 512M fdt reserved-memory (lmb_flag LMB_NOMAP)
> > > > 
> > > > 2) lib/lmb.c:efi_lmb_reserve() reserve a region just before u-boot reserved
> > > > area. This is not coalesced/merged with the u-boot reserved area because it is
> > > > not contiguous.
> > > > 
> > > > This is the reserved-memory array at this point:
> > > >     ~414M - ~414M efi loader reserved area (lmb_flag LMB_NONE)
> > > >     ~415M - 448M u-boot reserved area (lmb_flag LMB_NONE)
> > > >      456M - 512M fdt reserved-memory (lmb_flag LMB_NOMAP)
> > > > 
> > > > 3) lib/lmb.c:efi_lmb_reserve() reserve some more areas.
> > > > In the last two steps efi loader add some reserved area that overlap u-boot and fdt
> > > > reserved area BUT they are also contiguous to the "efi loader reserved area".
> > > > The very last step reserve also area between ram_top (448M) to ram_end (512M)
> > > > 
> > > > We fall in this condition (where we have overlapping areas!):
> > > >     ~414M - 512M efi loader reserved area (lmb_flag LMB_NONE)
> > > >     ~415M - 448M u-boot reserved area (lmb_flag LMB_NONE)
> > > >      456M - 512M fdt reserved-memory (lmb_flag LMB_NOMAP)
> > > > 
> > > > 4) Now, while loading the linux fdt the reserved-memory areas are checked
> > > > toward efi loader reserved area, they overlap, BUT they have different
> > > > lmb_flag. So we get the ERROR print.
> > > > 
> > > > Hopefully this is clear, I undestand is not that obvious ...
> > > 
> > >     efidebug memmap
> > Verdin AM62 # efidebug memmap
> > MMC: no card present
> > No EFI system partition
> > No EFI system partition
> > Failed to persist EFI variables
> > Type             Start            End              Attributes
> > ================ ================ ================ ==========
> > CONVENTIONAL     0000000080000000-0000000098eec000 WB
> > BOOT DATA        0000000098eec000-0000000098eee000 WB
> > RUNTIME DATA     0000000098eee000-0000000098eef000 WB|RT
> > BOOT DATA        0000000098eef000-0000000098ef2000 WB
> > RUNTIME DATA     0000000098ef2000-0000000098ef3000 WB|RT
> > BOOT DATA        0000000098ef3000-0000000098ef4000 WB
> > RUNTIME DATA     0000000098ef4000-0000000098ef6000 WB|RT
> > BOOT DATA        0000000098ef6000-0000000098ef7000 WB
> > RUNTIME DATA     0000000098ef7000-0000000098f07000 WB|RT
> > BOOT DATA        0000000098f07000-0000000098f10000 WB
> > BOOT CODE        0000000098f10000-000000009bf20000 WB
> > RUNTIME CODE     000000009bf20000-000000009bf30000 WB|RT
> > BOOT CODE        000000009bf30000-000000009c000000 WB
> > BOOT DATA        000000009c000000-00000000a0000000 WB
> > > 
> > > and of
> > > 
> > >     bdinfo
> > With this "debug" patch I hope giving you a better picture:
> > 
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index b2c233edb64e..1feb7189936e 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -197,6 +197,9 @@ static void lmb_reserve_common(struct lmb *lmb, void *fdt_blob)
> >          if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
> >                  boot_fdt_add_mem_rsv_regions(lmb, fdt_blob);
> > 
> > +       printf("%s. Calling lmb_dump_all_force between boot_fdt_add_mem_rsv_regions and efi_lmb_reserve\n", __func__);
> > +       lmb_dump_all_force(lmb);
> > +
> >          if (CONFIG_IS_ENABLED(EFI_LOADER))
> >                  efi_lmb_reserve(lmb);
> >   }
> > 
> > Verdin AM62 # bdinfo
> > boot_params = 0x0000000000000000
> > DRAM bank   = 0x0000000000000000
> > -> start    = 0x0000000080000000
> > -> size     = 0x0000000020000000
> > flashstart  = 0x0000000000000000
> > flashsize   = 0x0000000000000000
> > flashoffset = 0x0000000000000000
> > baudrate    = 115200 bps
> > relocaddr   = 0x000000009bf22000
> > reloc off   = 0x000000001b722000
> > Build       = 64-bit
> > current eth = ethernet@8000000port@1
> > ethaddr     = 00:14:2d:e5:73:c1
> > IP addr     = <NULL>
> > fdt_blob    = 0x0000000099f10890
> > new_fdt     = 0x0000000099f10890
> > fdt_size    = 0x000000000000f4e0
> > multi_dtb_fit= 0x0000000000000000
> > lmb_reserve_common. Calling lmb_dump_all_force between boot_fdt_add_mem_rsv_regions and efi_lmb_reserve
> > lmb_dump_all:
> >   memory.cnt = 0x1 / max = 0x10
> >   memory[0]      [0x80000000-0x9fffffff], 0x20000000 bytes flags: 0
> >   reserved.cnt = 0x3 / max = 0x10
> >   reserved[0]    [0x99f0c280-0x9bffffff], 0x020f3d80 bytes flags: 0
> >   reserved[1]    [0x9db00000-0x9e6fffff], 0x00c00000 bytes flags: 4
> >   reserved[2]    [0x9e780000-0x9fffffff], 0x01880000 bytes flags: 4
> > lmb_dump_all:
> >   memory.cnt = 0x1 / max = 0x10
> >   memory[0]      [0x80000000-0x9fffffff], 0x20000000 bytes flags: 0
> >   reserved.cnt = 0x4 / max = 0x10
> >   reserved[0]    [0x98f06000-0x9fffffff], 0x070fa000 bytes flags: 0
> >   reserved[1]    [0x99f0c280-0x9bffffff], 0x020f3d80 bytes flags: 0
> >   reserved[2]    [0x9db00000-0x9e6fffff], 0x00c00000 bytes flags: 4
> >   reserved[3]    [0x9e780000-0x9fffffff], 0x01880000 bytes flags: 4
> > devicetree  = separate
> > serial addr = 0x0000000002800000
> >   width      = 0x0000000000000000
> >   shift      = 0x0000000000000002
> >   offset     = 0x0000000000000000
> >   clock      = 0x0000000002dc6c00
> > arch_number = 0x0000000000000000
> > TLB addr    = 0x000000009bff0000
> > irq_sp      = 0x0000000099f10880
> > sp start    = 0x0000000099f10880
> > Early malloc usage: 2a88 / 8000
> > > > IMO we have two different bugs:
> > > >    - there is nothing that prevent that coalesced area may overlap other areas
> > > >      (while lmb module expect that there aren't overlapping areas)
> > > >    - efi loader (correctly) reserve between ram_top and ram_end BUT this area is
> > > >      reserved by fdt.
> > > > 
> > > > One potential solution could be to override efi_add_known_memory() and set
> > > > ram_top = ram_end, e.g.
> > > > 
> > > > -           efi_add_conventional_memory_map(ram_start, ram_end, ram_top);
> > > > +           efi_add_conventional_memory_map(ram_start, ram_end, ram_end);
> > > > 
> > > > 
> > > > but this does not really seems like something that should ve overridden at the
> > > > board level.
> 
> I am able to reproduce the issue on a Pine A64 LTS with this tree:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/tree/top_reserved

Patrice send this patch https://lore.kernel.org/all/20240308101230.2595220-1-patrice.chotard@foss.st.com/
to fix what it looks like the same issue on STM32MP1.

Should we have a similar patch for TI K3? What do you think?

Francesco

