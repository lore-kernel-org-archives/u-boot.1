Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A30606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V/ljRGXx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Mq56X2SN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70EF980C0F;
	Fri,  6 Nov 2026 23:17:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70dGzKS6Il9x; Fri,  6 Nov 2026 23:17:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2E8980BDB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794007072;
	b=H5QYkmWctI8coAJ/MDlKC/RvUIDSlza7XUu8xp0Miyydpr9ASmIS5opvTe8Q0aJ53QF8
	 WFfjle6SyV2vgVhWQOv5hkV6s5MgV21vvEq2FoajZ1otxVohdFESpM6+9y5YMA/wo6aiX
	 NL6iD4kGSzgCGdGaTdSi5x1s48lfTb2M0Kp9fgonZq0apqFpp7boMLP2PoBW8aku3TPTK
	 ElYuuVSYGCz8qyfK1W434sefCGAomMm46HVXRxSPaJWxpGrrJO/DHsoK+yijJhSo1G8qT
	 au+WJcpP66tvO4/J3DC5uzcHh1i5+gLoZ3bkKfYFy0kmHxPMDh5tPcKWzqrqsVneuuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NSS5Fvysn34v09V5/F9vHVSu07QmgWO/FrdhaLyru/E=;
	b=GXvsvvCp4xsAaveIMSzWtorcnSS60BassEZKlY7Iqxbael7VQW5O22VLz7qfFV1Kw+dp
	 bAGShf89Xq+4JoJULb2pppqYme/CSzFIQiJSPgZtg+ms4VqJ/GjHw/xg2sW0+Rv7Sg4o8
	 5tb+5qZoUgc+u9h8La8OcbFAumB8b5oyP/uTU6KG9qcbET+90JQjqHygWBp14lAt4As2r
	 G0RZgGSsfAzGkxRG065IiZqsiN/TA96PYh8Ehe7OFP9nrZekRgpOMGDkoMDJsGu+Dy7Kr
	 kkIgBtl1MRJGjOGCYFHBX+2sRMKcMJG+i40eHPjOh/BlRzmbH4KbWJ1t1xlIHoareww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794007071;
	bh=NSS5Fvysn34v09V5/F9vHVSu07QmgWO/FrdhaLyru/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V/ljRGXx6wVofLYCGg3Vsd1Y0taciQT9A7y9wj+NO/hlyvd3g1EyuHUCWpH7HCIzO
	 Zpt2KAyIYhzkiZ7Pu80du01oVGcVleP6BCiUbXQRGeV9oUHgVkPz98QR2HjKUQX5NO
	 02w1B/oY5/JsPULRW+cD+AU5D5FVABdDKR9IsK2yspb5+N72RWGr9jpnpxq2qLcmQS
	 JEeT15vBHjjfrWVOEc2BFAhmwapo8AGBLlEp6IVuYy9EWGNFx+55vkZlWbSdIb5c2l
	 LEB9ySLqyuiEJ4Zb+6DBg80qoKPWiAldelaZGH7CQwrmj0UNhRZ6fZ3xVuwfcDmrRA
	 aHAqwHq3ZfASg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2E8980BDB;
	Fri,  6 Nov 2026 23:17:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E6972E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 23:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E829A40407
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 23:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHTcoCgU-PxG for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 23:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 60D1C40403
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=Mq56X2SN
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60D1C40403
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 23:17:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7BB91650;
 Fri,  6 Nov 2026 15:17:42 -0800 (PST)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98AC93F632;
 Fri,  6 Nov 2026 15:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794007065; bh=P95fEWAAC1L5xQVSLkIp7JwPFQ1XlYgBcmhGiRxWsZo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Mq56X2SNUGWi7kVUe4dDFc3GW11ivmaWkNcXm3NnuimcRU9K9i3xcwYimCi4AwrcY
 M0IEwNxSQnMJA5sE2Kh+9nKPYmoAn6euV5qsTQHu6xce4YTms1ixuXR/3RT9WcBbF4
 WU1lK4A3NhLz0EX4e+qOuWlitFwG9Hl+uZdkF4LA=
Date: Sat, 7 Nov 2026 00:17:35 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Indrek Kruusa <indrek.kruusa@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>, Leo
 Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski
 <lukma@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>, Samuel
 Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 00/10] riscv: sun20i: add support for the Allwinner
 D1/D1s(F133) SoCs and boards
Message-ID: <20261107001735.66ef37d6@ryzen.lan>
In-Reply-To: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun,  1 Nov 2026 23:04:39 +0200
Indrek Kruusa <indrek.kruusa@gmail.com> wrote:

Hi Indrek,

thanks for sending this out.
This looks surprisingly simple on a first glance.
I haven't had a detailed look, but wanted to reply with some general
thoughts.

> Building upon the work of Samuel Holland [1], this series introduces support

I guess you took quite some patches from Samuel? I don't see him being
the author of any patch, that doesn't sound likely. Please try to
attribute his work, by keeping this authorship.

> for the Allwinner D1/D1s(F133) RISC-V SoCs and two development boards:
> 
> - Sipeed Lichee RV Dock (D1 SoC)
> - MangoPi MQ (RISC-V version with D1s/F133-A SoC)
> 
> The main difference from Samuel's work is how the boards are wired into the

I think Samuel also used DM_SPL (which I heavily oppose), looks like
this is gone as well? I like that, but it seems to be a major
difference worth mentioning.

> tree. The original design aimed at one cross-architecture configuration which
> covers ARM sun8i and RISC-V sun20i parts from Allwinner. This series does not
> do that. The D1/D1s get their own configuration instead:
> 
>   - arch/riscv/cpu/sun20i/ and board/sun20i/ hold the RISC-V side
>   - SUN20I is a SoC-family symbol, TARGET_SUN20I the board target
>   - the shared sunxi drivers accept SUN20I next to ARCH_SUNXI, so they are
>     shared as before -- only the Kconfig condition changes
> 
> Keeping the two sides apart has a cost: a few things exist twice.

Mmmh, I need to have a closer look, but am wondering if we can avoid
those double definitions and integrate both architectures better.
arch/arm vs. arm/riscv should separate itself naturally, and the
drivers shouldn't care about the architecture.
That's just a hunch, though, I will have a closer look in the next
weeks, as I am busy with other things.

Thanks,
Andre

> SUNXI_GEN_NCAT2 is declared in both arch trees, because the shared drivers
> test it and no Kconfig file is sourced by both. clock_get_pll6() is a C
> function for ARM (clock_sun50i_h6.c) and an inline for RISC-V
> (arch-sun20i/clock.h), decoding the same NCAT2 registers. The MMC mod-clock
> bits, the CCU offsets and parts of board/sunxi/board.c are repeated the same
> way.
> 
> For the sake of simplicity the image names stay "sunxi"
> (u-boot-sunxi-with-spl.bin, inner sunxi-spl.bin) because that is the shared
> Allwinner eGON boot format.
> 
> Both defconfigs build, and both boards boot from the SD card to a userspace
> login. The images were built with custom Buildroot configuration, using
> gcc 16.2.0, binutils 2.46.1 and Linux 7.3.0.
> 
> One caveat -- reboot does not work yet; it needs fixes outside U-Boot, on the
> firmware/OS side.
> 
> AI/LLM tools were used as development assistants throughout this work.
> Their use included debugging DRAM initialization and probing issues,
> assisting with code development, reviewing code, helping with testing and
> validation, and reviewing and refining commit messages.
> 
> PS. The boards use CONFIG_NS16550_CLK_ENABLE, which comes from a patch
> originally posted by khaliforce <kforce@gmail.com> and merged as commit
> 70f51e1e2ea5 ("serial: ns16550: make probe clock enabling optional") by
> Samuel Holland; v2027.01-rc1 already contains it.
> 
> [1] https://github.com/smaeul/u-boot/tree/d1-wip
> 
> 
> The patches (on tag v2027.01-rc1)
> ---------------------------------
> 
> 1/10 riscv: cpu: add Allwinner D1/D1s(F133) CPU support
>      Add the C906 support for the D1/D1s(F133) SoCs:
> 
>      - T-Head cache operations from the custom cache instructions
>      - harts_early_init() programming MXSTATUS, MHCR and MHINT
>      - cleanup_before_linux() disabling interrupts and flushing the caches
>      - dram_init() from the device tree memory nodes
>      - the T-Head CSR, CCU clock and memory map headers
>      - SUN20I Kconfig (cache line size, T-Head CMO support)
> 
> 2/10 sunxi: allow the sunxi drivers to be built for sun20i
>      Accept SUN20I next to ARCH_SUNXI for the RAM, clock, pinctrl, GPIO, MMC,
>      reset and watchdog drivers, and keep WATCHDOG_AUTOSTART off for it.
> 
>      Declare SUNXI_GEN_NCAT2 here as well - the ARM sunxi Kconfig is not read
>      by a RISC-V build - and add the MMC base addresses to arch-sun20i/cpu.h
>      so sunxi_mmc.c builds.
> 
> 3/10 board: sun20i: add common support for the D1/D1s boards
>      Add the board code used by all D1/D1s(F133) boards:
> 
>      - TARGET_SUN20I, board init and CPU probing
>      - sunxi eGON/TOC0 SPL header: boot source, FEL mode, SPL size
>      - SPL DRAM probing and the /memory fixup
>      - FIT DT name matching
>      - environment placement for MMC/SPI boot media
>      - the u-boot-sunxi-with-spl.bin image
>      - a MAINTAINERS section for the new board and CPU files
> 
>      CONFIG_ARCH_SUNXI is never set on these RISC-V parts, so extend the SPL
>      image rule in scripts/Makefile.xpl to match TARGET_SUN20I as well.
> 
>      The board code, the devicetree overlay and include/configs/sun20i.h come
>      from Samuel Holland's d1-wip tree [1]. The board code in turn derives from
>      the ARM sunxi board code, so its copyright notices are kept.
> 
>      [1] https://github.com/smaeul/u-boot/tree/d1-wip
> 
> 4/10 sunxi: dram: fix integer-pointer conversions in the D1 DRAM driver
>      Fix readl()/writel() address types for GCC 15+
> 
>      Use typed base address macros and cast remaining register addresses
>      to void __iomem * to satisfy GCC 15's stricter type checking.
> 
>      No functional change.
> 
> 5/10 sunxi: dram: count the banks on address bit 11, not A22
>      The bank test looks for the BA2 alias at address bit 22, but in the mode
>      the probe programs BA2 is bit 11. A four bank part therefore always
>      reports eight banks, turning 64MB into 128MB.
> 
>      On a MangoPi MQ with F133-A the probe now reports 4 banks, 13 rows and 2KB
>      pages - the vendor's dram_para1 = 0xd2. Boot tested on a Lichee RV Dock
>      too, where a D1 with external 512MB DDR3 is detected correctly.
> 
> 6/10 sunxi: dram: no AC remapping on the co-packaged DRAM parts
>      The PHY AC remapping tables compensate for the drive strength of the
>      DRAM chips connected to the SoC. This compensation must be skipped
>      when the DRAM is integrated on-die.
> 
> 7/10 sunxi: dram: let the board set the MR1 mode register
>      The DRAM mode register 1 value belongs to the DRAM part, and the parts in
>      use differ: 0x02 for the DDR2 die co-packaged with the D1s and F133-A,
>      against the 0x42 that the boards with external DDR3 have booted with so
>      far.
> 
>      Expose it next to the other vendor DRAM settings, keeping 0x42 as the
>      default so nothing changes for the existing users.
> 
> 8/10 sunxi: mmc: handle D1 PLL6 clock rate correctly
>      Apply the existing MMC clock /2 compensation to SUN20I,
>      as already done for SUN8I_R528.
> 
> 9/10 configs: add the Lichee RV Dock defconfig
>      Sipeed Lichee RV Dock: D1, 512 MB DDR3.
> 
> 10/10 configs: add the MangoPi MQ D1s(F133) defconfig
>      MangoPi MQ D1s(F133), 64 MB co-packaged DDR2.
> 
> 
>  MAINTAINERS                                   |  10 +
>  arch/riscv/Kconfig                            |  14 +
>  arch/riscv/cpu/sun20i/Kconfig                 |  17 +
>  arch/riscv/cpu/sun20i/Makefile                |   5 +
>  arch/riscv/cpu/sun20i/cache.c                 |  88 ++++
>  arch/riscv/cpu/sun20i/cpu.c                   |  44 ++
>  arch/riscv/cpu/sun20i/dram.c                  |  21 +
>  arch/riscv/dts/sun20i-u-boot.dtsi             |  86 ++++
>  arch/riscv/include/asm/arch-sun20i/clock.h    |  71 +++
>  arch/riscv/include/asm/arch-sun20i/cpu.h      |  22 +
>  .../riscv/include/asm/arch-sun20i/thead_csr.h |  29 ++
>  board/sun20i/Kconfig                          | 173 ++++++++
>  board/sun20i/Makefile                         |   4 +
>  board/sun20i/board.c                          | 309 +++++++++++++
>  board/sun20i/spl.c                            | 142 ++++++
>  configs/lichee_rv_dock_defconfig              |  14 +
>  configs/mangopi_mq_d1s_defconfig              |  20 +
>  drivers/clk/sunxi/Kconfig                     |   2 +-
>  drivers/gpio/Kconfig                          |   2 +-
>  drivers/mmc/Kconfig                           |   2 +-
>  drivers/mmc/sunxi_mmc.c                       |   3 +-
>  drivers/pinctrl/sunxi/Kconfig                 |   2 +-
>  drivers/ram/sunxi/Kconfig                     |   8 +-
>  drivers/ram/sunxi/dram_sun20i_d1.c            | 417 ++++++++++--------
>  drivers/reset/Kconfig                         |   2 +-
>  drivers/watchdog/Kconfig                      |   3 +-
>  include/configs/sun20i.h                      |  11 +
>  scripts/Makefile.xpl                          |   2 +-
>  28 files changed, 1329 insertions(+), 194 deletions(-)
>  create mode 100644 arch/riscv/cpu/sun20i/Kconfig
>  create mode 100644 arch/riscv/cpu/sun20i/Makefile
>  create mode 100644 arch/riscv/cpu/sun20i/cache.c
>  create mode 100644 arch/riscv/cpu/sun20i/cpu.c
>  create mode 100644 arch/riscv/cpu/sun20i/dram.c
>  create mode 100644 arch/riscv/dts/sun20i-u-boot.dtsi
>  create mode 100644 arch/riscv/include/asm/arch-sun20i/clock.h
>  create mode 100644 arch/riscv/include/asm/arch-sun20i/cpu.h
>  create mode 100644 arch/riscv/include/asm/arch-sun20i/thead_csr.h
>  create mode 100644 board/sun20i/Kconfig
>  create mode 100644 board/sun20i/Makefile
>  create mode 100644 board/sun20i/board.c
>  create mode 100644 board/sun20i/spl.c
>  create mode 100644 configs/lichee_rv_dock_defconfig
>  create mode 100644 configs/mangopi_mq_d1s_defconfig
>  create mode 100644 include/configs/sun20i.h
> 
> Cc
> --
> 
>   Tom Rini <trini@konsulko.com>               (U-Boot maintainer)
>   Andre Przywara <andre.przywara@arm.com>     (sunxi custodian)
>   Tim Ouyang <tim609@andestech.com>           (RISC-V)
>   Leo Liang <leo.liang@sifive.com>            (RISC-V)
>   Yao Zi <me@ziyao.cc>                        (RISC-V reviewer)
>   Peng Fan <peng.fan@nxp.com>                 (MMC)
>   Jaehoon Chung <jh80.chung@samsung.com>      (MMC)
>   Lukasz Majewski <lukma@nabladev.com>        (CLOCK)
>   Stefan Roese <stefan.roese@mailbox.org>     (WATCHDOG)
>   Samuel Holland <samuel@sholland.org>        (original d1-wip author)
> 

