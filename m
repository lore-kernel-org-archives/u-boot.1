Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9DACC6B2A
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A03C7608BA;
	Sat, 17 Oct 2026 04:07:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qx22442IcQ4Q; Sat, 17 Oct 2026 04:07:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E77D7607BB
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792210064;
	bh=xmtQXoMI5oV13FJnE0rTzUa/Y0JCn77P5wrlcVJ8Ox8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P67iDpin8RzEXWrWAwihXEYxANpXlemdqjuPnI1X8CaYTgWFwLjF8Tx3F0BEu99l9
	 b9j6SPzknZGRVT0yMJ79llZVXhB60XBBUJf4JpRwCxsMB6+5uIqvJdhSXQ6CYERnUu
	 cbl86BIvmtQ0eooCfLKoWtl+hfboUNn8JpxBX+L4Z/JhRk60G6f9Fc9OagzzrEAn/B
	 N8JRFsn/nid7HwJL93X4sa2GyUNDhb47qcg2uRaGnsjSqJv4KhCfwyb6p9DglMzsGA
	 qm6t+TNOCnxdTmF4vLFwbv7TzXTHTnlYipjuGGygmYO6xsSB4Di1sjE/ijPnBoxmbU
	 /+ciYlUkWsy7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E77D7607BB;
	Sat, 17 Oct 2026 04:07:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9A15362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 04:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B5FD409E4
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 04:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BuGudFdwQqTq for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 04:07:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DA6DF405BF
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792210060;
 b=j1jU5NIxK9pqOn0fCT+/tw+x5vYvANbsMmbWQSE6gAddB8ee2W5ro0+p//NAHGTW+Xv0
 XfTz6qJ3oO9ssozm921z98XSnXXr6IEWufuesTR5xm4Ii6gFUhxk8rF7G3rxciSjMxmHw
 57QlXKQG3/IzBph6v7ZMMI2WCaahqzK580Z8ghDdaxXlDDCg/XknUxhUNllwXqc64gFmR
 J5DwoyJuvDGqTXUJ5L/g4zvRNUh5Bg73KcE4V+goZRC23at7km3uP4LusKX7oTZaZfP9e
 L0IHb7TeAvnSkIM1uvl7Lil8MYO7csBVK+7YLPyCPk/OoHfW/H5IzmiRrG8o8PYtjJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792210060;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=xmtQXoMI5oV13FJnE0rTzUa/Y0JCn77P5wrlcVJ8Ox8=;
 b=guc4YPrpDre+FXhNpH4qx3a7lzKUNjn3hpN8iBy2IwHGhe0ccX+4azSOB/VswR5VGr6G
 D2bXDTzHtMbpL5TpBvxzOsF5Oyb5k72XY4UklVbNocJ+S309d1VvEJTNa6/bqnDY9Hp98
 QZnrx8O0DS9fZOA/A2JqwcBLXSYkIMnbs3J4Ri80hNDldr8+uZ5BTQ7r0yu6JzsWRU3Y/
 igH41t2fpVRNJllgxd5N6w7Eh0++Q8d0OuXBfSsv6c7IHO1pmdFghtb0GXsgjuLLclfQ2
 DUlQd5Ba3fm2n5HXJJxelzD64ON9PcLYrxNzoMHnm3cVz+B6lfJhKvJhjVfQ5Jd0B3g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=fail reason="signature verification failed" header.d=ziyao.cc
 header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=LNw3b4Jy; 
 arc=fail smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=LNw3b4Jy
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA6DF405BF
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 04:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792210039; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lq+vK+4wh3T2bBLuYdydHRSRq8MZLtNpZ61dj9CmY1MTEM0XvXhwGG6g4GpYasoo+zVFRoK8NL1ISycqbtbgr0dVGoGZ8GrGM148tzwmhR/HMlwdc83by/mJ39vdTcNPN/M12r/9KlMmbLI1FjnclvFMaaopNUNk4J3hD9e7/4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792210039;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yvWM13DCkohlRlT5Y2aeyjRi5axBm4nMr+OtDLFmPuQ=; 
 b=evXztq2xKQhuvLopXM3R4ePKGeMPjvN8MXK4AtxmUjSVDRkRjblVwkbabGRxEqv/8PH79VPfwvBOQG6TFf9giRrBt614hgLM0ZD7ElbDUERWneonT0tVtSfqRvfLl6nHgEU4J2sYVxj2NTK3TRvEPdua7PiCramhvS3caUHBh1M=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792210039; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=yvWM13DCkohlRlT5Y2aeyjRi5axBm4nMr+OtDLFmPuQ=;
 b=LNw3b4JyF/I9z0pkM0S+thO/4XuhFI7iIgiijcibz7aRgD37JkTQ4n0MJYcZdQfQ
 JsERGna3Hju2CyPoemqukyuEvDFVZVLSRTLIdWhsQ3vCiE7pjI9Lw39C8vnPAwlqRVh
 jm9WivxJK0p+wmIBOOwSoevamg68geUoERmkc4rY=
Received: by smtp.zohomail.com with SMTPS id 1792210036213907.7447331447846;
 Fri, 16 Oct 2026 21:07:16 -0700 (PDT)
Date: Sat, 17 Oct 2026 04:07:02 +0000
From: Yao Zi <me@ziyao.cc>
To: E Shattow <e@freeshell.de>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>,
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>,
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Michal Simek <michal.simek@amd.com>, Yixun Lan <dlan@kernel.org>,
 Andrei Lalaev <andrey.lalaev@gmail.com>
Subject: Re: [PATCH 4/4] board: sophgo: Add support for Milk-V Duo S
Message-ID: <atL0ZiK90D-tzC67@pie>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
 <20261016-upstream-v1-milk-duo-s-v1-4-e4bf386eea2d@gmail.com>
 <d61a5f4a-f7eb-496f-86b9-70aedcfe2e66@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d61a5f4a-f7eb-496f-86b9-70aedcfe2e66@freeshell.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.192.81
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, Oct 16, 2026 at 04:51:34PM -0700, E Shattow wrote:
> Hi João Paulo,
> 
> On 10/16/26 12:52, João Paulo Gonçalves wrote:
> > Add support for the Milk-V Duo S, a development board based on the
> > Sophgo SG2000 SoC with 512 MiB of RAM.
> > 
> > The SG2000 differs from the CV1800B used on the Milk-V Duo 64M and the
> > SG2002 used on the Milk-V Duo 256M, but these SoCs share most of their
> > IP blocks, including the CPU core, so the existing CV1800B support can
> > be reused.
> > 
> > Add a separate board directory, target and defconfig for the Duo S,
> > based on the Milk-V Duo 256M ones. Like the Duo 256M, it reuses the
> > common Milk-V Duo board code. The defconfig uses the upstream devicetree
> > via OF_UPSTREAM.
> > 
> > Link: https://milkv.io/docs/duo/getting-started/duos
> > Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> > Acked-by: Andrei Lalaev <andrey.lalaev@gmail.com>
> > Acked-by: Hiago De Franco <hfranco@baylibre.com>
> > ---
> >  arch/riscv/Kconfig                       |  4 ++
> >  board/sophgo/milkv_duo_s/Kconfig         | 30 +++++++++++
> >  board/sophgo/milkv_duo_s/MAINTAINERS     |  8 +++
> >  board/sophgo/milkv_duo_s/Makefile        |  6 +++
> >  board/sophgo/milkv_duo_s/milkv_duo_s.env |  8 +++
> >  configs/milkv_duo_s_defconfig            | 43 ++++++++++++++++
> >  doc/board/sophgo/index.rst               |  1 +
> >  doc/board/sophgo/milkv_duo_s.rst         | 86 ++++++++++++++++++++++++++++++++
> >  include/configs/milkv_duo_s.h            | 12 +++++
> >  9 files changed, 198 insertions(+)

...

> > diff --git a/board/sophgo/milkv_duo_s/milkv_duo_s.env b/board/sophgo/milkv_duo_s/milkv_duo_s.env
> > new file mode 100644
> > index 000000000000..4c9f53d08118
> > --- /dev/null
> > +++ b/board/sophgo/milkv_duo_s/milkv_duo_s.env
> > @@ -0,0 +1,8 @@
> > +fdt_addr_r=0x84000000
> > +fdtfile=DEFAULT_DEVICE_TREE.dtb
> 
> Sorry I do not understand, what is "DEFAULT_DEVICE_TREE.dtb" where is
> this file actually?

It would be expanded to the value of CONFIG_DEFAULT_DEVICE_TREE, with
quotes stripped. See usage/environment.rst, and Makefile:2166.

...

> > diff --git a/doc/board/sophgo/milkv_duo_s.rst b/doc/board/sophgo/milkv_duo_s.rst
> > new file mode 100644
> > index 000000000000..2ae749a08215
> > --- /dev/null
> > +++ b/doc/board/sophgo/milkv_duo_s.rst
> > @@ -0,0 +1,86 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Milk-V Duo S
> > +============
> > +
> > +SG2000 RISC-V SoC
> > +-----------------
> > +The SG2000 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
> > +
> > +Mainline support
> > +----------------
> > +Support for the following drivers is already enabled:
> > +
> > +1. ns16550 UART Driver.
> > +2. Synopsys Designware MSHC Driver.
> > +3. Synopsys Designware Ethernet Controller.
> > +
> > +Building
> > +~~~~~~~~
> > +1. Add the RISC-V toolchain to your PATH.
> > +2. Setup ARCH & cross compilation environment variable:
> > +
> > +.. code-block:: console
> > +
> > +   export CROSS_COMPILE=<riscv64 toolchain prefix>
> > +   cd <U-Boot-dir>> +   make milkv_duo_s_defconfig
> > +   make
> 
> Consider this variation:
> 
> export CROSS_COMPILE=<riscv64 toolchain prefix>
> make -C u-boot.git O=../u-boot milkv_duo_s_defconfig
> make -C u-boot.git O=../u-boot

I don't think this improves things much, let's stop being nitpicking
here.

> > +
> > +This will generate u-boot.bin
> > +
> > +Booting
> > +~~~~~~~
> > +Currently, we rely on vendor FSBL (First Stage Boot Loader) to initialize the
> > +clock and load OpenSBI and the u-boot image, then bootup from it.
> > +
> > +To run u-boot.bin on top of FSBL, follow these steps:
> > +
> > +1. Generate a compatible u-boot.bin using U-Boot with the Milk-V Duo S
> > +   default configuration.
> > +
> > +2. Use mainline OpenSBI with a newer version than 1.5 to generate fw_dynamic.
> 
> Suspicious statement, I think it is wrong here.
> 
> Is this in regard to mainline OpenSBI commit f7a92f6b ("lib: utils/fdt:
> Add support for parsing riscv,isa-extensions") ?   If so, a short
> statement e.g. "Use OpenSBI for generic platform with support for
> parsing riscv,isa-extensions, introduced in mainline OpenSBI v1.6
> release" or simply "Use mainline OpenSBI v1.6+" because you don't tell
> us anyways why it is important that the needed change happens between
> v1.5 and v1.6 OpenSBI version.

I think it's likely related to 2bed4c1c57a7 ("platform: generic: thead:
add Sophgo CV18XX/SG200X series"), which applies a PMU-related quirk to
SG2002. But anyway, yes, an explanation of the version requirement would
be helpful, though I doubt it's SoC-specific instead of board-specific,
thus better put in a separate file.

> > +   Use FW_FDT_PATH to point to sg2000-milkv-duo-s.dtb device tree file while
> > +   compiling fw_dynamic. Example:
> > +
> > +.. code-block:: console
> > +
> > +   cd open-sbi
> > +   PLATFORM=generic FW_FDT_PATH=../u-boot/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dtb make
> 
> See above comment about setting the O= make variable. Consider this again:
> 
> make -C opensbi.git O=../opensbi clean
> make -C opensbi.git O=../opensbi PLATFORM=generic
> FW_FDT_PATH=../u-boot/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dtb
> 
> An explicit invocation of clean target before generic platform build
> should be listed because of a well-known OpenSBI build problem:
> 
> https://lore.kernel.org/opensbi/0d6bf7c7-7605-4ad6-a35c-54efc5230fb8@sifive.com/

This sounds like an OpenSBI bug, and I'm not sure whether we should pay
for it to maintain it in the documentation.

Furthermore, anyone building OpenSBI would be affected by the issue,
which makes it sound more unnatural to emphasize this in a board-level
documentation (e.g., should we modify all other RISC-V ports to mention
this?).

To me, the board/SoC-level documentation is only responsible for
describing the board/SoC-specific stuff. It's necessary to mention how
to build related firmware, but I don't think we should get too deep
here.

> > +
> > +This will generate build/platform/generic/firmware/fw_dynamic.bin.
> > +
> > +3. Use the vendor-provided tool [1] to create a unified fip.bin file containing
> 
> I think this description is correct but it just sounds strange to me
> with the word "unified" for a mix of libre open source software into
> third-party proprietary tools and proprietary executable code blob.

Sophgo FSBL had been source-available for a long time, and Sophgo has
recently explicitly licensed it. Thus it doesn't sound correct to call
them "proprietary" and "blob".

> Consider "Use the vendor-provided fiptool [1] to prepare FSBL containing..."

This is incorrect. In the context of CV18xx/SG200x bootflow, FSBL refers
to the bootloader preceeding U-Boot (whether it's the vendor one or not),
and fip.bin is combined from FSBL, OpenSBI, and U-Boot.

> > +   FSBL, OpenSBI, and U-Boot.
> 
> "SPL, OpenSBI with initial device tree and U-Boot payload"
> 
> > +   Note that you will have to use the file cv181x.bin as the FSBL.
> 
> Naming what we would want from U-Boot SPL to be known as "SPL" and then
> wrapped with mkimage action to become "FSBL" is more easily
> understandable. We do not have this yet, but think about a future where
> there is U-Boot SPL and mkimage support here, how would you describe
> this? Use that and apply it to the third party vendor workflow now.

Sorry for not getting you points, but I couldn't understand what
cannot be described...

> If cv181x.bin is ready-to-go rename as "fip.bin" and SoC BootROM loader
> functionality accepts this (no fiptool) then yes it is also true to
> describe as "FSBL".
> 
> In fact the terminology FSBL and SPL may be equivalent but we can make
> this arbitrary distinction in documentation to make it clearer what is
> the compiled executable code SPL and what is the SPL image formed with
> additional preparation.

This sounds reasonable. However, I don't think it should belong to this
series adding support for another board.

In case that you don't know, CV1800B, SG2000, and SG2002 have the same
bootflow, and we already have CV1800B (milkv_duo) and SG2002
(milkv_duo_256m) support available in mainline U-Boot, without
explaining these terms. So I don't think we should put such burden on
one adding a new board.

It'll be nice if Joao could add some related documentation, but I don't
think it's a blocker for merging this series.

> > +
> > +4. Place the generated fip.bin file into the FAT partition of the SD card.
> 
> Consider "Place the prepared fip.bin file" or better "Copy the prepared
> FSBL as fip.bin file into the FAT partition of the SD card."
> 
> I like "prepared" word to describe wrapping up one or many data sources
> in a header expected by the SoC BootROM loader functionality.

I think this is a little too nitpicking. This is probably copied from
documentation of other CV18xx/SG200x boards, and I don't think there's a
strong difference among the three versions...

...

> > diff --git a/include/configs/milkv_duo_s.h b/include/configs/milkv_duo_s.h
> > new file mode 100644
> > index 000000000000..f60aa23fc181
> > --- /dev/null
> > +++ b/include/configs/milkv_duo_s.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (c) 2026, João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> > + *
> > + */
> > +
> > +#ifndef __CONFIG_H
> > +#define __CONFIG_H
> > +
> > +#define CFG_SYS_SDRAM_BASE	0x80000000
> > +
> > +#endif /* __CONFIG_H */
> > 
> 
> If able, please reverse-engineer / port support for the Milk-V Duo S
> FSBL image format to U-Boot mkimage tool. Also look more closely at
> fully-relocatable OpenSBI fw_dynamic.bin support.

Nice point, but this won't be a blocker for the series, either :)

> -E Shattow

Best regards,
Yao Zi
