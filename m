Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2A3C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3143F80FBC;
	Fri, 21 Aug 2026 08:42:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id io7Zmbl-_NqO; Fri, 21 Aug 2026 08:42:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301769;
	bh=fEEu6g04zADGih7KyHowb5ggHHv94UivJz/V/dBVRSs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WLKBx+2jsg3W01z6Q5vFnCIaBPnu2fdYotriQTKQrkrvKfT1yhwVsmjj+ztTDwko+
	 en/gzBEXlJb4vqEWdZ0mvHT6EeHdT2aKKWkJun9xzrJOwQiwfWHhCIvlM6oIs8ziZg
	 g/G5oQXL2TFpHZon898gb/lhVa0/v32Bbqdl0XgtueFlxwNa4cxy4TPef5MC+W9tJL
	 N/3UgdO72/5eSPXKzG7iNfiywo6Kgo2fXqZsCMYgSlcbRI2tUSmsK7gbCAyX67c0Ob
	 3fAizAtZIL4ZWcnu+C1AndBpHCGH9tJIKiBaG2ddtAIWkx76oEj2Mgs+24nCwDkK6u
	 f2ZWtYJfyg/Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60D7080F80;
	Fri, 21 Aug 2026 08:42:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F0BF476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50C7440071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id skrbV7Zwz6b0 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:42:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=fNEuHOMD
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BD714006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301755; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AWaxdS4Ps5zSNC+1BpCHclF3gUsiy+eGbfQg20xmzoDfBYC1tus5DF7Bi3z7c6WQ9QOMrDRv656Uzeq/24coxVrLlH7SdMu6+ID1nIz/8w0ezSW0cJQ2kCrF2i/8H3p+62NtOlMgBe7ReeM4lvq8Ke6UX4+nmsLfHKSjmWa3xvk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301755;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fEEu6g04zADGih7KyHowb5ggHHv94UivJz/V/dBVRSs=; 
 b=CTVajJjnv4yFw65Y8AJrAxEnqyYnbZWApJnA1LGoXEaiDXM4kkAG+Rm0ameT8Hk8fNuN1ShMZgqoP5WNfXSDWetVZLEkuAgXR0l7HJoVwI8NwVreE4hq27zVRxNrnoG4hLLGUs0dPFB+hVLTJ0+fKeIDirvl+SDOtbwJIAMOybM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301755; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=fEEu6g04zADGih7KyHowb5ggHHv94UivJz/V/dBVRSs=;
 b=fNEuHOMDDnHZDeETr+3oVRwKat3Jmvcb7PrFPOGcOOFEPfYtrUrPWFnfzwuUr1+e
 SarPtT4lN8sW91NriSV9MFu1LNhUs0sDGSKzw0dADzhHwoD0GGhMepjEJDPCKKOEy1t
 9LX8G/xcYemCXZZ8J0lBTcWTSy5BKMKlf/NCUseM=
Received: by mx.zohomail.com with SMTPS id 1787301752031693.1629277457449;
 Fri, 21 Aug 2026 01:42:32 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 00/19] LoongArch initial support
Date: Fri, 21 Aug 2026 08:42:00 +0000
Message-ID: <20260821084219.1703743-1-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

So far this series has implemented general support for initializing CPU,
exceptions, kernel booting, CPU and timer drivers, QEMU LoongArch virt
machine support and UEFI standard compliant EFI booting support.

LoongArch had defined 3 ISA variants, LA64, LA32 and LA32R (Reduced,
intended for MCUs and education purpose). This is a little-endian only
architecture. Only LA64 is implemented in this series since the hardware
is more widely available, and I'll work on 32bit support later.

This series had passed checkpatch with exceptions on some false alarms
and headers imported elsewhere. I've tested virtio devices, direct
kernel booting, efistub kernel booting, grub, and hello/selftests EFI
app.

LoongArch CI depends on some already-merged dockerfile[2] and buildman[3]
changes to run.

Toolchain can be found at [4] or using upstream one, to build

	make qemu-loongarch64_defconfig
	make

To run in QEMU:

	qemu-system-loongarch64 -nographic -machine virt -bios u-boot.bin

TODOs on the architecture & board:
- loongson,ls7a-rtc driver
 - The only device on QEMU board haven't been supported yet
- LoongArch sandbox host support
- TLB enablement
 - This is required for real CPU to utilize caches
- Possibly EFI-APP support for real machine

Thanks for your time and review!

Link to v2: https://lore.kernel.org/u-boot/20260701111808.870705-1-me@ziyao.cc/
Link to v1: https://lore.kernel.org/u-boot/20240522-loongarch-v1-0-1407e0b69678@flygoat.com/

[1]: https://lore.kernel.org/u-boot/20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com/
[2]: https://lore.kernel.org/u-boot/20260731120750.2212394-1-me@ziyao.cc/
[3]: https://lore.kernel.org/u-boot/20260806122957.101125-1-me@ziyao.cc/
[4]: https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/x86_64-gcc-14.2.0-nolibc-loongarch64-linux.tar.gz

Jiaxun Yang (16):
  lib: fdtdec: Handle multiple memory nodes
  linux/io.h: Use map_physmem to implement ioremap
  image: Take entry point as an output of setup_booti
  elf: Define LoongArch bits
  image: Define IH_ARCH_LOONGARCH
  LoongArch: skeleton and headers
  LoongArch: lib: General routines
  LoongArch: CPU assembly routines
  LoongArch: Exception handling
  LoongArch: Boot Image bits
  LoongArch: Generic platform type
  cpu: Add loongarch_cpu driver
  timer: Add loongarch_timer driver
  board: emulation: Add qemu-loongarch
  efi: LoongArch: Define LoongArch bits everywhere
  efi: LoongArch: Implement everything

Yao Zi (3):
  doc: arch: Add documentation for LoongArch
  MAINTAINERS: Add entry for LoongArch
  CI: Wire up qemu-loongarch64

 .azure-pipelines.yml                          |   11 +-
 .gitlab-ci.yml                                |    6 +
 MAINTAINERS                                   |   11 +
 Makefile                                      |    2 +
 arch/Kconfig                                  |   16 +
 arch/arm/lib/image.c                          |    3 +-
 arch/loongarch/Kconfig                        |   67 +
 arch/loongarch/Makefile                       |   21 +
 arch/loongarch/config.mk                      |   27 +
 arch/loongarch/cpu/Makefile                   |    9 +
 arch/loongarch/cpu/cpu.c                      |   17 +
 arch/loongarch/cpu/generic/Kconfig            |   13 +
 arch/loongarch/cpu/generic/Makefile           |    7 +
 arch/loongarch/cpu/generic/cpu.c              |   22 +
 arch/loongarch/cpu/generic/dram.c             |   16 +
 arch/loongarch/cpu/genex.S                    |   21 +
 arch/loongarch/cpu/smp_secondary.S            |   55 +
 arch/loongarch/cpu/start.S                    |  168 ++
 arch/loongarch/cpu/u-boot.lds                 |   85 +
 arch/loongarch/dts/Makefile                   |    6 +
 arch/loongarch/dts/qemu-loongarch64.dts       |    9 +
 arch/loongarch/include/asm/acpi_table.h       |    8 +
 arch/loongarch/include/asm/addrspace.h        |   86 +
 .../include/asm/arch-generic/entry-init.h     |   15 +
 arch/loongarch/include/asm/asm.h              |  186 +++
 arch/loongarch/include/asm/atomic.h           |   12 +
 arch/loongarch/include/asm/barrier.h          |  138 ++
 arch/loongarch/include/asm/bitops.h           |  156 ++
 arch/loongarch/include/asm/byteorder.h        |   22 +
 arch/loongarch/include/asm/cache.h            |   34 +
 arch/loongarch/include/asm/config.h           |   11 +
 arch/loongarch/include/asm/cpu.h              |  123 ++
 arch/loongarch/include/asm/dma-mapping.h      |   27 +
 arch/loongarch/include/asm/global_data.h      |   50 +
 arch/loongarch/include/asm/gpio.h             |   11 +
 arch/loongarch/include/asm/io.h               |  399 +++++
 arch/loongarch/include/asm/linkage.h          |   11 +
 arch/loongarch/include/asm/loongarch.h        | 1467 +++++++++++++++++
 arch/loongarch/include/asm/posix_types.h      |   87 +
 arch/loongarch/include/asm/processor.h        |   11 +
 arch/loongarch/include/asm/ptrace.h           |   33 +
 arch/loongarch/include/asm/regdef.h           |   42 +
 arch/loongarch/include/asm/sections.h         |    8 +
 arch/loongarch/include/asm/setjmp.h           |   20 +
 arch/loongarch/include/asm/spl.h              |   11 +
 arch/loongarch/include/asm/stackframe.h       |  175 ++
 arch/loongarch/include/asm/string.h           |   11 +
 arch/loongarch/include/asm/system.h           |   72 +
 arch/loongarch/include/asm/types.h            |   37 +
 arch/loongarch/include/asm/u-boot-loongarch.h |   23 +
 arch/loongarch/include/asm/u-boot.h           |   30 +
 arch/loongarch/include/asm/unaligned.h        |   11 +
 arch/loongarch/lib/Makefile                   |   26 +
 arch/loongarch/lib/asm-offsets.c              |   66 +
 arch/loongarch/lib/boot.c                     |   14 +
 arch/loongarch/lib/bootm.c                    |  130 ++
 arch/loongarch/lib/cache.c                    |  243 +++
 arch/loongarch/lib/crt0_loongarch_efi.S       |  182 ++
 arch/loongarch/lib/elf_loongarch_efi.lds      |   76 +
 arch/loongarch/lib/image.c                    |   77 +
 arch/loongarch/lib/interrupts.c               |  192 +++
 arch/loongarch/lib/reloc_loongarch_efi.c      |  102 ++
 arch/loongarch/lib/reset.c                    |   14 +
 arch/loongarch/lib/setjmp.S                   |   52 +
 arch/riscv/lib/image.c                        |    4 +-
 arch/sandbox/lib/bootm.c                      |    2 +-
 board/emulation/qemu-loongarch/Kconfig        |   68 +
 board/emulation/qemu-loongarch/MAINTAINERS    |    9 +
 board/emulation/qemu-loongarch/Makefile       |    6 +
 .../emulation/qemu-loongarch/qemu-loongarch.c |   67 +
 .../qemu-loongarch/qemu-loongarch.env         |    5 +
 boot/bootm.c                                  |    5 +-
 boot/image.c                                  |    1 +
 cmd/Kconfig                                   |    2 +-
 cmd/booti.c                                   |    5 +-
 common/spl/spl.c                              |    9 +-
 configs/qemu-loongarch64_defconfig            |   36 +
 doc/arch/index.rst                            |    1 +
 doc/arch/loongarch.rst                        |   30 +
 doc/board/emulation/index.rst                 |    1 +
 doc/board/emulation/qemu-loongarch.rst        |   39 +
 drivers/cpu/Kconfig                           |    6 +
 drivers/cpu/Makefile                          |    1 +
 drivers/cpu/loongarch_cpu.c                   |  142 ++
 drivers/timer/Kconfig                         |    8 +
 drivers/timer/Makefile                        |    1 +
 drivers/timer/loongarch_timer.c               |  132 ++
 include/asm-generic/global_data.h             |    2 +-
 include/asm-generic/pe.h                      |    2 +
 include/config_distro_bootcmd.h               |    5 +
 include/configs/qemu-loongarch.h              |   17 +
 include/elf.h                                 |    8 +-
 include/host_arch.h                           |    2 +
 include/image.h                               |    8 +-
 include/linux/io.h                            |    3 +-
 include/pe.h                                  |    2 +
 lib/efi_loader/Kconfig                        |    2 +-
 lib/efi_loader/efi_helper.c                   |    7 +
 lib/efi_loader/efi_image_loader.c             |   38 +
 lib/efi_loader/efi_runtime.c                  |    4 +
 .../efi_selftest_miniapp_exception.c          |    3 +
 lib/fdtdec.c                                  |  127 +-
 102 files changed, 5826 insertions(+), 77 deletions(-)
 create mode 100644 arch/loongarch/Kconfig
 create mode 100644 arch/loongarch/Makefile
 create mode 100644 arch/loongarch/config.mk
 create mode 100644 arch/loongarch/cpu/Makefile
 create mode 100644 arch/loongarch/cpu/cpu.c
 create mode 100644 arch/loongarch/cpu/generic/Kconfig
 create mode 100644 arch/loongarch/cpu/generic/Makefile
 create mode 100644 arch/loongarch/cpu/generic/cpu.c
 create mode 100644 arch/loongarch/cpu/generic/dram.c
 create mode 100644 arch/loongarch/cpu/genex.S
 create mode 100644 arch/loongarch/cpu/smp_secondary.S
 create mode 100644 arch/loongarch/cpu/start.S
 create mode 100644 arch/loongarch/cpu/u-boot.lds
 create mode 100644 arch/loongarch/dts/Makefile
 create mode 100644 arch/loongarch/dts/qemu-loongarch64.dts
 create mode 100644 arch/loongarch/include/asm/acpi_table.h
 create mode 100644 arch/loongarch/include/asm/addrspace.h
 create mode 100644 arch/loongarch/include/asm/arch-generic/entry-init.h
 create mode 100644 arch/loongarch/include/asm/asm.h
 create mode 100644 arch/loongarch/include/asm/atomic.h
 create mode 100644 arch/loongarch/include/asm/barrier.h
 create mode 100644 arch/loongarch/include/asm/bitops.h
 create mode 100644 arch/loongarch/include/asm/byteorder.h
 create mode 100644 arch/loongarch/include/asm/cache.h
 create mode 100644 arch/loongarch/include/asm/config.h
 create mode 100644 arch/loongarch/include/asm/cpu.h
 create mode 100644 arch/loongarch/include/asm/dma-mapping.h
 create mode 100644 arch/loongarch/include/asm/global_data.h
 create mode 100644 arch/loongarch/include/asm/gpio.h
 create mode 100644 arch/loongarch/include/asm/io.h
 create mode 100644 arch/loongarch/include/asm/linkage.h
 create mode 100644 arch/loongarch/include/asm/loongarch.h
 create mode 100644 arch/loongarch/include/asm/posix_types.h
 create mode 100644 arch/loongarch/include/asm/processor.h
 create mode 100644 arch/loongarch/include/asm/ptrace.h
 create mode 100644 arch/loongarch/include/asm/regdef.h
 create mode 100644 arch/loongarch/include/asm/sections.h
 create mode 100644 arch/loongarch/include/asm/setjmp.h
 create mode 100644 arch/loongarch/include/asm/spl.h
 create mode 100644 arch/loongarch/include/asm/stackframe.h
 create mode 100644 arch/loongarch/include/asm/string.h
 create mode 100644 arch/loongarch/include/asm/system.h
 create mode 100644 arch/loongarch/include/asm/types.h
 create mode 100644 arch/loongarch/include/asm/u-boot-loongarch.h
 create mode 100644 arch/loongarch/include/asm/u-boot.h
 create mode 100644 arch/loongarch/include/asm/unaligned.h
 create mode 100644 arch/loongarch/lib/Makefile
 create mode 100644 arch/loongarch/lib/asm-offsets.c
 create mode 100644 arch/loongarch/lib/boot.c
 create mode 100644 arch/loongarch/lib/bootm.c
 create mode 100644 arch/loongarch/lib/cache.c
 create mode 100644 arch/loongarch/lib/crt0_loongarch_efi.S
 create mode 100644 arch/loongarch/lib/elf_loongarch_efi.lds
 create mode 100644 arch/loongarch/lib/image.c
 create mode 100644 arch/loongarch/lib/interrupts.c
 create mode 100644 arch/loongarch/lib/reloc_loongarch_efi.c
 create mode 100644 arch/loongarch/lib/reset.c
 create mode 100644 arch/loongarch/lib/setjmp.S
 create mode 100644 board/emulation/qemu-loongarch/Kconfig
 create mode 100644 board/emulation/qemu-loongarch/MAINTAINERS
 create mode 100644 board/emulation/qemu-loongarch/Makefile
 create mode 100644 board/emulation/qemu-loongarch/qemu-loongarch.c
 create mode 100644 board/emulation/qemu-loongarch/qemu-loongarch.env
 create mode 100644 configs/qemu-loongarch64_defconfig
 create mode 100644 doc/arch/loongarch.rst
 create mode 100644 doc/board/emulation/qemu-loongarch.rst
 create mode 100644 drivers/cpu/loongarch_cpu.c
 create mode 100644 drivers/timer/loongarch_timer.c
 create mode 100644 include/configs/qemu-loongarch.h


base-commit: 93d858da82ea0fa551af9aa6d50ef57fa94c5c49
-- 
2.55.0

