Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD29C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F1884BB9;
	Wed,  1 Jul 2026 13:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="GP46FsAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BDC84BA0; Wed,  1 Jul 2026 13:18:32 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07DDD84B53
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904703; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=f5FVjkWCqbzpBLSuXEVIDZr4LwDP3ZHVqXnk3Ao8hv5uNL+lY0HMN/+XcyoqN/lYjNA4+RTGhIdvhulWjjDIer26yRu+ceA6V3trHR0zlBKWzmH0vjeYzVPzMdqE0HmdRp8BzSJE8mBoQjKjsFiZAfHxuikEWX4JJqK5TtaVhsM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904703;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tVne75z7X2Rv64u0JBiug1VQvOHoAE4Ze34FN5JwCWM=; 
 b=ZOKqeUNm5PSqJcGYsTn380nWp0o5cuXf1hxQHCdj2S/9dCXKE4i9V83d1x9aQoKjjaXEDUw3N2L1CLQeaxlabxEFqCTlZcB8fJuQks+l/X4BBctq6QSRgNgeuwb9lMpNtcFW3h6xWNodlKMd/NsUQFTuzB178E04tkKQXP2V7xo=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904703; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=tVne75z7X2Rv64u0JBiug1VQvOHoAE4Ze34FN5JwCWM=;
 b=GP46FsAY7MAFJk4GN5Ee47S2USDnAgOHubmThKyNZsfGPppAtcevwUCutA+XyZLw
 uJoCWeAhlLgxwhnu5Fh5fudVTtNSa3kmppsUhS/0sR1KH8eCxrGHFE/LGiNoj0PQVlr
 3picvSnNZ4Ly4PTg4m3YzNqGLv7oVB65nUp3XytE=
Received: by mx.zohomail.com with SMTPS id 1782904699918747.737826746678;
 Wed, 1 Jul 2026 04:18:19 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 00/16] LoongArch initial support
Date: Wed,  1 Jul 2026 11:17:52 +0000
Message-ID: <20260701111808.870705-1-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Hi all,

After talking to Jiaxun privately, I decided to take over the series.

So far this series has implemented general support for initializing CPU,
exceptions, kernel booting, CPU and timer drivers, QEMU LoongArch virt
machine support and UEFI standard compliant EFI booting support.

LoongArch had defined 3 ISA variants, LA64, LA32 and LA32R (Reduced,
intended for MCUs and education purpose). This is a little-endian only
architecture. Only LA64 is implemented in this series since the hardware
is more widely available, and I'll work on 32bit support later.

This series had passed checkpatch with exceptions on some false alarms
and headers imported elsewhere. I've tested virtio devices, direct
kernel booting, efistub kernel booting and grub. For loongarch64 CI, I
would continue to work on Jiaxun's another series[1] soon.

Toolchain can be found at [2] or using upstream one, to build

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

I have one question regarding the process: I've decided to
coordinate with Jiaxun to maintain the loongarch port, and AFAIK we
would need a custodian tree on U-Boot's GitLab instance in order to run
CI. If this true, what's the process of creating a tree?

Thanks for your time and review!

Link to v1: https://lore.kernel.org/u-boot/20240522-loongarch-v1-0-1407e0b69678@flygoat.com/

[1]: https://lore.kernel.org/u-boot/20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com/
[2]: https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/x86_64-gcc-14.2.0-nolibc-loongarch64-linux.tar.gz

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
  LoongArch: Generic CPU type
  cpu: Add loongarch_cpu driver
  timer: Add loongarch_timer driver
  board: emulation: Add qemu-loongarch
  efi: LoongArch: Define LoongArch bits everywhere
  efi: LoongArch: Implement everything

 Makefile                                      |    2 +
 arch/Kconfig                                  |   15 +
 arch/arm/lib/image.c                          |    3 +-
 arch/loongarch/Kconfig                        |   49 +
 arch/loongarch/Makefile                       |   19 +
 arch/loongarch/config.mk                      |   27 +
 arch/loongarch/cpu/Makefile                   |    9 +
 arch/loongarch/cpu/cpu.c                      |   27 +
 arch/loongarch/cpu/generic/Kconfig            |   13 +
 arch/loongarch/cpu/generic/Makefile           |    7 +
 arch/loongarch/cpu/generic/cpu.c              |   22 +
 arch/loongarch/cpu/generic/dram.c             |   21 +
 arch/loongarch/cpu/genex.S                    |   21 +
 arch/loongarch/cpu/smp_secondary.S            |   55 +
 arch/loongarch/cpu/start.S                    |  170 ++
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
 arch/loongarch/include/asm/setjmp.h           |   25 +
 arch/loongarch/include/asm/spl.h              |   11 +
 arch/loongarch/include/asm/stackframe.h       |  175 ++
 arch/loongarch/include/asm/string.h           |   11 +
 arch/loongarch/include/asm/system.h           |   74 +
 arch/loongarch/include/asm/types.h            |   37 +
 arch/loongarch/include/asm/u-boot-loongarch.h |   23 +
 arch/loongarch/include/asm/u-boot.h           |   30 +
 arch/loongarch/include/asm/unaligned.h        |   11 +
 arch/loongarch/lib/Makefile                   |   26 +
 arch/loongarch/lib/asm-offsets.c              |   66 +
 arch/loongarch/lib/boot.c                     |   14 +
 arch/loongarch/lib/bootm.c                    |  163 ++
 arch/loongarch/lib/cache.c                    |  213 +++
 arch/loongarch/lib/crt0_loongarch_efi.S       |  182 ++
 arch/loongarch/lib/elf_loongarch_efi.lds      |   76 +
 arch/loongarch/lib/image.c                    |   66 +
 arch/loongarch/lib/interrupts.c               |  189 +++
 arch/loongarch/lib/reloc_loongarch_efi.c      |  107 ++
 arch/loongarch/lib/reset.c                    |   14 +
 arch/loongarch/lib/setjmp.S                   |   52 +
 arch/riscv/lib/image.c                        |    4 +-
 arch/sandbox/lib/bootm.c                      |    2 +-
 board/emulation/qemu-loongarch/Kconfig        |   68 +
 board/emulation/qemu-loongarch/MAINTAINERS    |    7 +
 board/emulation/qemu-loongarch/Makefile       |    6 +
 .../emulation/qemu-loongarch/qemu-loongarch.c |   67 +
 .../qemu-loongarch/qemu-loongarch.env         |    6 +
 boot/bootm.c                                  |    5 +-
 boot/image.c                                  |    1 +
 cmd/Kconfig                                   |    2 +-
 cmd/booti.c                                   |    5 +-
 common/spl/spl.c                              |    9 +-
 configs/qemu-loongarch64_defconfig            |   36 +
 drivers/cpu/Kconfig                           |    6 +
 drivers/cpu/Makefile                          |    1 +
 drivers/cpu/loongarch_cpu.c                   |  148 ++
 drivers/timer/Kconfig                         |    8 +
 drivers/timer/Makefile                        |    1 +
 drivers/timer/loongarch_timer.c               |  112 ++
 include/asm-generic/global_data.h             |    2 +-
 include/asm-generic/pe.h                      |    2 +
 include/config_distro_bootcmd.h               |    5 +
 include/configs/qemu-loongarch.h              |   13 +
 include/elf.h                                 |    9 +-
 include/host_arch.h                           |    2 +
 include/image.h                               |    4 +-
 include/linux/io.h                            |    3 +-
 include/pe.h                                  |    1 +
 lib/efi_loader/Kconfig                        |    2 +-
 lib/efi_loader/efi_helper.c                   |    7 +
 lib/efi_loader/efi_image_loader.c             |   33 +
 lib/efi_loader/efi_runtime.c                  |    4 +
 .../efi_selftest_miniapp_exception.c          |    3 +
 lib/fdtdec.c                                  |  129 +-
 95 files changed, 5704 insertions(+), 71 deletions(-)
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
 create mode 100644 drivers/cpu/loongarch_cpu.c
 create mode 100644 drivers/timer/loongarch_timer.c
 create mode 100644 include/configs/qemu-loongarch.h


base-commit: 0d8e33717d7e5b2a4034cc88f18bf233f77801e7
-- 
2.54.0

