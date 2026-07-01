Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB010C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 15:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC6984BC8;
	Wed,  1 Jul 2026 17:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="ucdi8TBS";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ekr0TG1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4629084BC9; Wed,  1 Jul 2026 17:54:18 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C1784BB2
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 17:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CE69C140013C;
 Wed,  1 Jul 2026 11:54:11 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
 by phl-compute-03.internal (MEProxy); Wed, 01 Jul 2026 11:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1782921251;
 x=1783007651; bh=+2Ic4ISJ01kaDw00hJEIuWoOSFRESFd7KFEzzdW/0lo=; b=
 ucdi8TBSi2BZHOB1pw/xnviLwqcbAVEF+cLk6tgCpz5IzZLmvJ2Dfs01JyZjLGlJ
 davgV3U7nTXjH/AeI/bYSJgrxKLrQRRPGHpeJcytW/bhrche7z/FmDAE7MaQxvXf
 KuAxP/oSuivFzTALrSM8Ceu2xVout9a1yPzZzGNjjqricClA/xOkGTOK2axn81C+
 Sunl0db2RT8wnLFNnJaVsxtB4eqtpuph8MDLMj/rJ4riUwpIanOdmjdTZQgNPl9L
 WFQEWmHUYXK/mssIHRyFB0trEhFf01yNEqD0vzLyahA2nRED+7R/ykyhgoYbCpTl
 yKyvQzF0puEyKECDNeJVmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782921251; x=
 1783007651; bh=+2Ic4ISJ01kaDw00hJEIuWoOSFRESFd7KFEzzdW/0lo=; b=e
 kr0TG1S+JSQYa4Ga+mu9p+voITzeVOL49rLdAENqebupBrU+emncsem7r+oID3Rw
 GGfPB0F6co2EoVXTc3888MCavVuFXIdF/qMIPKUZNTCi0/8kdrp7Q6mhMoWNRRNi
 m8RFZfyUDGrE6wZ2IG4oFNxSfXOlVwwPYUaz5Xb1MKOwraiqZtm7w+trnnxmm1HY
 6MK/qZUF83Ufjvwb+ZelKTpsw84918tceGbZctRxbIX0DpemEWhCzxe5eUlK9Tda
 KCwQq9YQWuB854OWisA4S/e624DIFBTxGXUslTX5TkgKxoY9LEApKUTdDihkd7qG
 pEomNxXeXdONrp0606eqA==
X-ME-Sender: <xms:IzhFaqlx1OlPm8mIujCdeITk6J67UAJCIQBmGfDksCR1jGwYtP_yiA>
 <xme:IzhFasoO7Z7K0tEaZTtSV8W9iKcHS1fKcMti8psnxa97SA_pNJjdk5o2PJVxlBeMZ
 UHmrgRBPiGdhbioKAT7GqEqKPoQFfJC16HLIvbhVVhlem6Di68QNOoa>
X-ME-Proxy-Cause: dmFkZTEI/ePZ0MsUQEsgqllioQ2Lfq+A7XxWD1cT+Ojd2TXH45w1DaoT43tyU+zPLlqfC9
 6C1T1w49icOn6MCI1fRn51qYuvTnGCdRKdOulRJIu6bhma1XgKoADlflfWgWfREkIDRN/a
 y6TcQWIkt0SbmIpoe8ZuDfB6HD9huyEDLIyIdtvPWLXt9c0/pK3ydjBsYN1ytrJeeb7S5q
 Cw383uLzYCfaHqel49va94QONqYnjlEkFTCk5n6s1P3YA/3UgaQO3dWNEt4AnV/8zCkoR9
 jBmJy8+tKLf0bqGTITHvdUo0l+ar9vDCIWt5gfL+QPfzpUWppxgt0O1lqZqzeotLB9bAjv
 0QF8VxYcByAhZ2KGnIBbXQIsvur2dkIQICaj23QGP87Gj1zRTmHKI5bQ35SRq+vcLp4CTd
 jDLUqpQXv64uPpy/iLk382+94TZj5pxls/TEFeMiEdZer29vMzeH6exrNyfHumJzD2Unz/
 g7pGS591nVjxI0PQMv1vLeIMEnd+QX4VPtuYElzI8J5nTp5B7Ukz8P0w43VSz3JjbGLw9o
 g8zr5uLRQ5FUxzjNuRrnTcli6YC7neEVHTT4PWxrAccMfOTXPjLbvZ/m1tloeNm73P+Eqs
 d+Acl9fwATNPQxb/kEF1f6GJpmP8Wc3H9yb8gBpdyQOg8ubBWDkLx7bc4rBw
X-ME-Proxy: <xmx:IzhFaiIxU111eQuFeajKTs1kMkG9PPEX9HqbZvsUythbibWiY1jpog>
 <xmx:IzhFarqhicc5tOsLQJPyuMJijMepS2EMPsrZ5_HxQNnoNmo4JHobAw>
 <xmx:IzhFaiy1dDUiGRv-K0cq4IxRl5unIs9p8T337jy5P4Rgv5mvM8YI4Q>
 <xmx:IzhFanMFA84iQV-wEDdyNLGzot9AAoa04ACroBPhsuRJi8ffJyHPMQ>
 <xmx:IzhFaqOlXIh0r4L_i_XFFlqkjGkcG4B_VFbIb_vX7FVQ6of-ISO189o5>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 8381218E006C; Wed,  1 Jul 2026 11:54:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AJicp9H0D08c
Date: Wed, 01 Jul 2026 16:53:51 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Yao Zi" <me@ziyao.cc>, "Tom Rini" <trini@konsulko.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
Message-Id: <79301bba-da97-4805-8395-675f579923c1@app.fastmail.com>
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
References: <20260701111808.870705-1-me@ziyao.cc>
Subject: Re: [PATCH v2 00/16] LoongArch initial support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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



On Wed, 1 Jul 2026, at 12:17 PM, Yao Zi wrote:
> Hi all,
>
> After talking to Jiaxun privately, I decided to take over the series.

Many thanks for continuing this work!

I'd like to add that Yao have addressed most of the comments I received
for v1. 

I'm always happy to coordinate on next steps for LoongArch port. I'm
also happy to co-maintain the port with Ziyao if we made it into upstream.

Thanks
Jiaxun

>
> So far this series has implemented general support for initializing CPU,
> exceptions, kernel booting, CPU and timer drivers, QEMU LoongArch virt
> machine support and UEFI standard compliant EFI booting support.
>
> LoongArch had defined 3 ISA variants, LA64, LA32 and LA32R (Reduced,
> intended for MCUs and education purpose). This is a little-endian only
> architecture. Only LA64 is implemented in this series since the hardware
> is more widely available, and I'll work on 32bit support later.
>
> This series had passed checkpatch with exceptions on some false alarms
> and headers imported elsewhere. I've tested virtio devices, direct
> kernel booting, efistub kernel booting and grub. For loongarch64 CI, I
> would continue to work on Jiaxun's another series[1] soon.
>
> Toolchain can be found at [2] or using upstream one, to build
>
> 	make qemu-loongarch64_defconfig
> 	make
>
> To run in QEMU:
>
> 	qemu-system-loongarch64 -nographic -machine virt -bios u-boot.bin
>
> TODOs on the architecture & board:
> - loongson,ls7a-rtc driver
>  - The only device on QEMU board haven't been supported yet
> - LoongArch sandbox host support
> - TLB enablement
>  - This is required for real CPU to utilize caches
> - Possibly EFI-APP support for real machine
>
> I have one question regarding the process: I've decided to
> coordinate with Jiaxun to maintain the loongarch port, and AFAIK we
> would need a custodian tree on U-Boot's GitLab instance in order to run
> CI. If this true, what's the process of creating a tree?
>
> Thanks for your time and review!
>
> Link to v1: 
> https://lore.kernel.org/u-boot/20240522-loongarch-v1-0-1407e0b69678@flygoat.com/
>
> [1]: 
> https://lore.kernel.org/u-boot/20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com/
> [2]: 
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/x86_64-gcc-14.2.0-nolibc-loongarch64-linux.tar.gz
>
> Jiaxun Yang (16):
>   lib: fdtdec: Handle multiple memory nodes
>   linux/io.h: Use map_physmem to implement ioremap
>   image: Take entry point as an output of setup_booti
>   elf: Define LoongArch bits
>   image: Define IH_ARCH_LOONGARCH
>   LoongArch: skeleton and headers
>   LoongArch: lib: General routines
>   LoongArch: CPU assembly routines
>   LoongArch: Exception handling
>   LoongArch: Boot Image bits
>   LoongArch: Generic CPU type
>   cpu: Add loongarch_cpu driver
>   timer: Add loongarch_timer driver
>   board: emulation: Add qemu-loongarch
>   efi: LoongArch: Define LoongArch bits everywhere
>   efi: LoongArch: Implement everything
>
>  Makefile                                      |    2 +
>  arch/Kconfig                                  |   15 +
>  arch/arm/lib/image.c                          |    3 +-
>  arch/loongarch/Kconfig                        |   49 +
>  arch/loongarch/Makefile                       |   19 +
>  arch/loongarch/config.mk                      |   27 +
>  arch/loongarch/cpu/Makefile                   |    9 +
>  arch/loongarch/cpu/cpu.c                      |   27 +
>  arch/loongarch/cpu/generic/Kconfig            |   13 +
>  arch/loongarch/cpu/generic/Makefile           |    7 +
>  arch/loongarch/cpu/generic/cpu.c              |   22 +
>  arch/loongarch/cpu/generic/dram.c             |   21 +
>  arch/loongarch/cpu/genex.S                    |   21 +
>  arch/loongarch/cpu/smp_secondary.S            |   55 +
>  arch/loongarch/cpu/start.S                    |  170 ++
>  arch/loongarch/cpu/u-boot.lds                 |   85 +
>  arch/loongarch/dts/Makefile                   |    6 +
>  arch/loongarch/dts/qemu-loongarch64.dts       |    9 +
>  arch/loongarch/include/asm/acpi_table.h       |    8 +
>  arch/loongarch/include/asm/addrspace.h        |   86 +
>  .../include/asm/arch-generic/entry-init.h     |   15 +
>  arch/loongarch/include/asm/asm.h              |  186 +++
>  arch/loongarch/include/asm/atomic.h           |   12 +
>  arch/loongarch/include/asm/barrier.h          |  138 ++
>  arch/loongarch/include/asm/bitops.h           |  156 ++
>  arch/loongarch/include/asm/byteorder.h        |   22 +
>  arch/loongarch/include/asm/cache.h            |   34 +
>  arch/loongarch/include/asm/config.h           |   11 +
>  arch/loongarch/include/asm/cpu.h              |  123 ++
>  arch/loongarch/include/asm/dma-mapping.h      |   27 +
>  arch/loongarch/include/asm/global_data.h      |   50 +
>  arch/loongarch/include/asm/gpio.h             |   11 +
>  arch/loongarch/include/asm/io.h               |  399 +++++
>  arch/loongarch/include/asm/linkage.h          |   11 +
>  arch/loongarch/include/asm/loongarch.h        | 1467 +++++++++++++++++
>  arch/loongarch/include/asm/posix_types.h      |   87 +
>  arch/loongarch/include/asm/processor.h        |   11 +
>  arch/loongarch/include/asm/ptrace.h           |   33 +
>  arch/loongarch/include/asm/regdef.h           |   42 +
>  arch/loongarch/include/asm/sections.h         |    8 +
>  arch/loongarch/include/asm/setjmp.h           |   25 +
>  arch/loongarch/include/asm/spl.h              |   11 +
>  arch/loongarch/include/asm/stackframe.h       |  175 ++
>  arch/loongarch/include/asm/string.h           |   11 +
>  arch/loongarch/include/asm/system.h           |   74 +
>  arch/loongarch/include/asm/types.h            |   37 +
>  arch/loongarch/include/asm/u-boot-loongarch.h |   23 +
>  arch/loongarch/include/asm/u-boot.h           |   30 +
>  arch/loongarch/include/asm/unaligned.h        |   11 +
>  arch/loongarch/lib/Makefile                   |   26 +
>  arch/loongarch/lib/asm-offsets.c              |   66 +
>  arch/loongarch/lib/boot.c                     |   14 +
>  arch/loongarch/lib/bootm.c                    |  163 ++
>  arch/loongarch/lib/cache.c                    |  213 +++
>  arch/loongarch/lib/crt0_loongarch_efi.S       |  182 ++
>  arch/loongarch/lib/elf_loongarch_efi.lds      |   76 +
>  arch/loongarch/lib/image.c                    |   66 +
>  arch/loongarch/lib/interrupts.c               |  189 +++
>  arch/loongarch/lib/reloc_loongarch_efi.c      |  107 ++
>  arch/loongarch/lib/reset.c                    |   14 +
>  arch/loongarch/lib/setjmp.S                   |   52 +
>  arch/riscv/lib/image.c                        |    4 +-
>  arch/sandbox/lib/bootm.c                      |    2 +-
>  board/emulation/qemu-loongarch/Kconfig        |   68 +
>  board/emulation/qemu-loongarch/MAINTAINERS    |    7 +
>  board/emulation/qemu-loongarch/Makefile       |    6 +
>  .../emulation/qemu-loongarch/qemu-loongarch.c |   67 +
>  .../qemu-loongarch/qemu-loongarch.env         |    6 +
>  boot/bootm.c                                  |    5 +-
>  boot/image.c                                  |    1 +
>  cmd/Kconfig                                   |    2 +-
>  cmd/booti.c                                   |    5 +-
>  common/spl/spl.c                              |    9 +-
>  configs/qemu-loongarch64_defconfig            |   36 +
>  drivers/cpu/Kconfig                           |    6 +
>  drivers/cpu/Makefile                          |    1 +
>  drivers/cpu/loongarch_cpu.c                   |  148 ++
>  drivers/timer/Kconfig                         |    8 +
>  drivers/timer/Makefile                        |    1 +
>  drivers/timer/loongarch_timer.c               |  112 ++
>  include/asm-generic/global_data.h             |    2 +-
>  include/asm-generic/pe.h                      |    2 +
>  include/config_distro_bootcmd.h               |    5 +
>  include/configs/qemu-loongarch.h              |   13 +
>  include/elf.h                                 |    9 +-
>  include/host_arch.h                           |    2 +
>  include/image.h                               |    4 +-
>  include/linux/io.h                            |    3 +-
>  include/pe.h                                  |    1 +
>  lib/efi_loader/Kconfig                        |    2 +-
>  lib/efi_loader/efi_helper.c                   |    7 +
>  lib/efi_loader/efi_image_loader.c             |   33 +
>  lib/efi_loader/efi_runtime.c                  |    4 +
>  .../efi_selftest_miniapp_exception.c          |    3 +
>  lib/fdtdec.c                                  |  129 +-
>  95 files changed, 5704 insertions(+), 71 deletions(-)
>  create mode 100644 arch/loongarch/Kconfig
>  create mode 100644 arch/loongarch/Makefile
>  create mode 100644 arch/loongarch/config.mk
>  create mode 100644 arch/loongarch/cpu/Makefile
>  create mode 100644 arch/loongarch/cpu/cpu.c
>  create mode 100644 arch/loongarch/cpu/generic/Kconfig
>  create mode 100644 arch/loongarch/cpu/generic/Makefile
>  create mode 100644 arch/loongarch/cpu/generic/cpu.c
>  create mode 100644 arch/loongarch/cpu/generic/dram.c
>  create mode 100644 arch/loongarch/cpu/genex.S
>  create mode 100644 arch/loongarch/cpu/smp_secondary.S
>  create mode 100644 arch/loongarch/cpu/start.S
>  create mode 100644 arch/loongarch/cpu/u-boot.lds
>  create mode 100644 arch/loongarch/dts/Makefile
>  create mode 100644 arch/loongarch/dts/qemu-loongarch64.dts
>  create mode 100644 arch/loongarch/include/asm/acpi_table.h
>  create mode 100644 arch/loongarch/include/asm/addrspace.h
>  create mode 100644 arch/loongarch/include/asm/arch-generic/entry-init.h
>  create mode 100644 arch/loongarch/include/asm/asm.h
>  create mode 100644 arch/loongarch/include/asm/atomic.h
>  create mode 100644 arch/loongarch/include/asm/barrier.h
>  create mode 100644 arch/loongarch/include/asm/bitops.h
>  create mode 100644 arch/loongarch/include/asm/byteorder.h
>  create mode 100644 arch/loongarch/include/asm/cache.h
>  create mode 100644 arch/loongarch/include/asm/config.h
>  create mode 100644 arch/loongarch/include/asm/cpu.h
>  create mode 100644 arch/loongarch/include/asm/dma-mapping.h
>  create mode 100644 arch/loongarch/include/asm/global_data.h
>  create mode 100644 arch/loongarch/include/asm/gpio.h
>  create mode 100644 arch/loongarch/include/asm/io.h
>  create mode 100644 arch/loongarch/include/asm/linkage.h
>  create mode 100644 arch/loongarch/include/asm/loongarch.h
>  create mode 100644 arch/loongarch/include/asm/posix_types.h
>  create mode 100644 arch/loongarch/include/asm/processor.h
>  create mode 100644 arch/loongarch/include/asm/ptrace.h
>  create mode 100644 arch/loongarch/include/asm/regdef.h
>  create mode 100644 arch/loongarch/include/asm/sections.h
>  create mode 100644 arch/loongarch/include/asm/setjmp.h
>  create mode 100644 arch/loongarch/include/asm/spl.h
>  create mode 100644 arch/loongarch/include/asm/stackframe.h
>  create mode 100644 arch/loongarch/include/asm/string.h
>  create mode 100644 arch/loongarch/include/asm/system.h
>  create mode 100644 arch/loongarch/include/asm/types.h
>  create mode 100644 arch/loongarch/include/asm/u-boot-loongarch.h
>  create mode 100644 arch/loongarch/include/asm/u-boot.h
>  create mode 100644 arch/loongarch/include/asm/unaligned.h
>  create mode 100644 arch/loongarch/lib/Makefile
>  create mode 100644 arch/loongarch/lib/asm-offsets.c
>  create mode 100644 arch/loongarch/lib/boot.c
>  create mode 100644 arch/loongarch/lib/bootm.c
>  create mode 100644 arch/loongarch/lib/cache.c
>  create mode 100644 arch/loongarch/lib/crt0_loongarch_efi.S
>  create mode 100644 arch/loongarch/lib/elf_loongarch_efi.lds
>  create mode 100644 arch/loongarch/lib/image.c
>  create mode 100644 arch/loongarch/lib/interrupts.c
>  create mode 100644 arch/loongarch/lib/reloc_loongarch_efi.c
>  create mode 100644 arch/loongarch/lib/reset.c
>  create mode 100644 arch/loongarch/lib/setjmp.S
>  create mode 100644 board/emulation/qemu-loongarch/Kconfig
>  create mode 100644 board/emulation/qemu-loongarch/MAINTAINERS
>  create mode 100644 board/emulation/qemu-loongarch/Makefile
>  create mode 100644 board/emulation/qemu-loongarch/qemu-loongarch.c
>  create mode 100644 board/emulation/qemu-loongarch/qemu-loongarch.env
>  create mode 100644 configs/qemu-loongarch64_defconfig
>  create mode 100644 drivers/cpu/loongarch_cpu.c
>  create mode 100644 drivers/timer/loongarch_timer.c
>  create mode 100644 include/configs/qemu-loongarch.h
>
>
> base-commit: 0d8e33717d7e5b2a4034cc88f18bf233f77801e7
> -- 
> 2.54.0

-- 
- Jiaxun
