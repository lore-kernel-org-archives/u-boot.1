Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC0606A330
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xMhnwOCL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=D70ARE3M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E47EA60D53;
	Thu, 12 Nov 2026 11:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QWxQ2E-gJu-N; Thu, 12 Nov 2026 11:59:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B9276081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484757;
	b=gX06dnPYiPYrIZByiw2heawM0A1X/TbpWv0UldNFwJpwR/2R/Tj/DZpNGveJGHPLBDI5
	 yKGj9t47971HUfx7QYRwma7qTw6knkDGe7gDCnBmDo2DeGY95O9HwLsxsJiE7jwNRuDws
	 02ReJLDJCe75D/L2n+DRqvW+hutBxFXO/WkrVyCJOVy3GLpW++eMbhYN+YThwPKnQrUi8
	 1Fxfj0MahHij6h/nUTgI5J6YvxhFJX168QSduOhTZOMp7MeSFBpQeKyhCW4fIE2Bq2hqB
	 IvJw1foOMseZhfh/RXNYh08+3LceuhvEBFw8ytwaHnzUDx1cONiwlP8now+inqFkVzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484757;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OUBaLsD3gbB3H1Rmoe0ly6ETIpomBgbhf+JwAn98AoU=;
	b=b4bW60zQ1IvO21InqkuKsGbUm4I0VueEMz09RcB9ejKfUF8IcRD0vOyNEk/xyBjdgFPE
	 zWY35tYHiMYk3VCvKEueaN8TYR0u2PSe7t2bRC6AbP2syMA8cnPInAzSLJ6aSscdweBPR
	 c4e9h7uhv17uoimAf3G4rZ6Txh9zRl8G0i6zcp0VBrkTZjUoiwm4kFN+IEbHuxwlzHCHE
	 lZDWjbk1gWK4LEVi5QCFsNS+b0EoefRK3eA95WANIChEpIOVBPXGnSIIpJCTxVK81Aeqp
	 kBPNgf+ihHzjbi82RokBmotGpKvazBPErflM/yIzmBAQwPqZ9bmGalHeDj1nu+R9Gvw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484757;
	bh=OUBaLsD3gbB3H1Rmoe0ly6ETIpomBgbhf+JwAn98AoU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xMhnwOCLxWXmZJgz8pTgGGJ4Qaiq1V3HPBKFfouG4jVGtOYiNp0ru1cyF0eCossp5
	 DJWQQAT9v+SDLzCyi9EfvD4TK5PASUBaFQ3IGlDROMx4TkB9sWJoW1zqx5l7Q+WiCx
	 4dCgfTNIpGn0WHSsMu7Ndr3VTM4+nPDe33A9ol7AWN2lXKF1kvT8YiHuPhjxBt5729
	 VnMs9hArALkdkTBDvYutKKVQveIMz4KCFmR+XwycEfe7NHdMiHQeNpibU9RsPczwiO
	 JuUEkNJUVEth4Ihn0uxBpZtyg8r+H2A67CY7cfhkltZifRLZ+3Z3FFx9bafJ3eYC2c
	 YDLTmZu0dYHcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B9276081A;
	Thu, 12 Nov 2026 11:59:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1586628C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12C6440DA8
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EdsnS0t784Fj for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:59:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F1AD240D72
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=D70ARE3M
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1AD240D72
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=D70ARE3MfQMq96Tnu6fZ/rwTQamaHlvLBfcUSrqZoyZwN/F9rEQbHupIQvkI8TG/D7mmPecl6nAcDUXswsw28oEe5aYchrGd06Mjf/XOYDaasCkLjcrd++3Ywm1TKvOqdyTcuJrW8xWL5MKrf+NkiX8+3tCzjlaP1h0XqA7qTWo=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=OUBaLsD3gbB3H1Rmoe0ly6ETIpomBgbhf+JwAn98AoU=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484491696892.2394730734045;
 Thu, 12 Nov 2026 03:54:51 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v7 00/20] LoongArch initial support
Date: Thu, 12 Nov 2026 11:54:18 +0000
Message-ID: <20261112115438.1837663-1-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

LoongArch CI depends on some already-merged dockerfile[1] and buildman[2]
changes to run. With the docker image replaced with one built by myself,
this series passes the Azure CI[3].

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

Link to v5: https://lore.kernel.org/u-boot/20261016065500.137544-1-me@ziyao.cc/
Link to v4: https://lore.kernel.org/u-boot/20260911104604.2910944-1-me@ziyao.cc/
Link to v3: https://lore.kernel.org/u-boot/20260821084219.1703743-1-me@ziyao.cc/
Link to v2: https://lore.kernel.org/u-boot/20260701111808.870705-1-me@ziyao.cc/
Link to v1: https://lore.kernel.org/u-boot/20240522-loongarch-v1-0-1407e0b69678@flygoat.com/

[1]: https://lore.kernel.org/u-boot/20260731120750.2212394-1-me@ziyao.cc/
[2]: https://lore.kernel.org/u-boot/20260806122957.101125-1-me@ziyao.cc/
[3]: https://github.com/u-boot/u-boot/pull/1073
[4]: https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/x86_64-gcc-14.2.0-nolibc-loongarch64-linux.tar.gz

Jiaxun Yang (16):
  lib: fdtdec: Handle multiple memory nodes
  linux/io.h: Use map_physmem to implement ioremap
  image: Take entry point as an output of booti_setup
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

Yao Zi (4):
  board_f: Add LoongArch path of mon_len calculation
  doc: arch: Add documentation for LoongArch
  MAINTAINERS: Add entry for LoongArch
  CI: Wire up qemu-loongarch64

 .azure-pipelines.yml                          |   11 +-
 .gitlab-ci.yml                                |    6 +
 MAINTAINERS                                   |   11 +
 Makefile                                      |    2 +
 arch/Kconfig                                  |   17 +
 arch/arm/lib/image.c                          |    3 +-
 arch/loongarch/Kconfig                        |   64 +
 arch/loongarch/Makefile                       |   21 +
 arch/loongarch/config.mk                      |   27 +
 arch/loongarch/cpu/Makefile                   |    9 +
 arch/loongarch/cpu/cpu.c                      |   17 +
 arch/loongarch/cpu/generic/Kconfig            |   13 +
 arch/loongarch/cpu/generic/Makefile           |    7 +
 arch/loongarch/cpu/generic/cpu.c              |   23 +
 arch/loongarch/cpu/generic/dram.c             |   16 +
 arch/loongarch/cpu/genex.S                    |   21 +
 arch/loongarch/cpu/smp_secondary.S            |   55 +
 arch/loongarch/cpu/start.S                    |  168 ++
 arch/loongarch/cpu/u-boot.lds                 |   85 +
 arch/loongarch/dts/Makefile                   |    6 +
 arch/loongarch/include/asm/acpi_table.h       |    8 +
 arch/loongarch/include/asm/addrspace.h        |   86 +
 .../include/asm/arch-generic/entry-init.h     |   15 +
 arch/loongarch/include/asm/asm.h              |  186 +++
 arch/loongarch/include/asm/atomic.h           |   12 +
 arch/loongarch/include/asm/barrier.h          |  138 ++
 arch/loongarch/include/asm/bitops.h           |  156 ++
 arch/loongarch/include/asm/byteorder.h        |   22 +
 arch/loongarch/include/asm/cache.h            |   35 +
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
 arch/loongarch/lib/Makefile                   |   22 +
 arch/loongarch/lib/asm-offsets.c              |   66 +
 arch/loongarch/lib/boot.c                     |   14 +
 arch/loongarch/lib/bootm.c                    |  129 ++
 arch/loongarch/lib/cache.c                    |  235 +++
 arch/loongarch/lib/crt0_loongarch_efi.S       |  182 ++
 arch/loongarch/lib/elf_loongarch_efi.lds      |   76 +
 arch/loongarch/lib/image.c                    |   77 +
 arch/loongarch/lib/interrupts.c               |  184 +++
 arch/loongarch/lib/reloc_loongarch_efi.c      |  101 ++
 arch/loongarch/lib/reset.c                    |   14 +
 arch/loongarch/lib/setjmp.S                   |   52 +
 arch/riscv/lib/image.c                        |    4 +-
 arch/sandbox/lib/bootm.c                      |    2 +-
 board/emulation/qemu-loongarch/Kconfig        |   68 +
 board/emulation/qemu-loongarch/MAINTAINERS    |    9 +
 board/emulation/qemu-loongarch/Makefile       |    6 +
 .../emulation/qemu-loongarch/qemu-loongarch.c |   67 +
 .../qemu-loongarch/qemu-loongarch.env         |    5 +
 boot/Kconfig                                  |    1 +
 boot/bootm.c                                  |    5 +-
 boot/image.c                                  |    1 +
 cmd/Kconfig                                   |    2 +-
 cmd/booti.c                                   |    5 +-
 common/board_f.c                              |    2 +-
 common/spl/spl.c                              |    9 +-
 configs/qemu-loongarch64_defconfig            |   35 +
 doc/arch/index.rst                            |    1 +
 doc/arch/loongarch.rst                        |   31 +
 doc/board/emulation/index.rst                 |    1 +
 doc/board/emulation/qemu-loongarch.rst        |   39 +
 drivers/cpu/Kconfig                           |    6 +
 drivers/cpu/Makefile                          |    1 +
 drivers/cpu/loongarch_cpu.c                   |  145 ++
 drivers/timer/Kconfig                         |    8 +
 drivers/timer/Makefile                        |    1 +
 drivers/timer/loongarch_timer.c               |  132 ++
 include/asm-generic/global_data.h             |    2 +-
 include/asm-generic/pe.h                      |    2 +
 include/config_distro_bootcmd.h               |    5 +
 include/configs/qemu-loongarch.h              |   17 +
 include/elf.h                                 |    9 +-
 include/host_arch.h                           |    2 +
 include/image.h                               |    8 +-
 include/linux/io.h                            |    3 +-
 include/pe.h                                  |    2 +
 lib/efi_loader/Kconfig                        |    2 +-
 lib/efi_loader/efi_helper.c                   |    7 +
 lib/efi_loader/efi_image_loader.c             |   40 +
 lib/efi_loader/efi_runtime.c                  |    4 +
 .../efi_selftest_miniapp_exception.c          |    3 +
 lib/fdtdec.c                                  |  127 +-
 103 files changed, 5803 insertions(+), 78 deletions(-)
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

-- 
2.56.0

