Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83B5CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8969F40983;
	Fri, 16 Oct 2026 06:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xtytUjBxrDCz; Fri, 16 Oct 2026 06:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 75F404097B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133727;
	b=lYAGgoQMEB1Ovsos/uxxpzMnHhXXDWpbhfSFtq7mZNi5QTRwCyIrOHm3pB50QDC9iQAg
	 Y7cncLc7VB5nsZxBws+HZU6QiFwcrwBV7Cz1/gzT+vC2mrPiD9W2Ody3rGXCAvRT5XGGw
	 H01siVmO6x0A+/hhhUFu4/eHN7L0kroLM4WbSgscess1tpRGUarzLgV3HgMLUr/KpXFVW
	 ScC2rLdUzuTd3a/ep6FMG24Dx1nm2A+hrlOdBwF1x8p7ebU3O4Ph0L5nN49BmJrWwFrQZ
	 eVDxpaD6IXfMU/yLap4szopNu/ncZpqgs/JyPPlhVVsQwjsbFgYOEoshefVxKStVu+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133727;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/0snWQcS6BIGCMdDuOlbr2MRp+UIhct8/ucFmU7u4/s=;
	b=Nnqni0NrTyZRQNWkk811Jwui64Nojv93FtYKDqUfNf9HZHZvs/5u4zrOJqG4bA6lzwlV
	 Oq2OifH8+e9+lUoy+3G5lTrIgP01kYx39yHIzCF1gykNuqJn892kG0/2IAxz2BrMjXAMp
	 iGU95/q9zOhaG0B/RIRUxsmiTi49Yb5vQEHmJGKKpXSnpVAyAZwG1DGIAvS2eZEn9Z+mb
	 rNBp2gfIqL8V2m2jmmtex1UngYaktYVM1U9WrGIC4wYqsDtFphhCUZsZr45qhQonqa52g
	 1/vXMbWVEUOxwFH0QX07EULJQdUQo8dEmQ86JVRJ5/EFeTpPcM9huC8+KWpy0xCWfxg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=juGi4xyY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133727;
	bh=/0snWQcS6BIGCMdDuOlbr2MRp+UIhct8/ucFmU7u4/s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wxc66LYUwac4sgQ8aTPrs7WzyyixevK2OOMZJaHB/K5zfCAqfQqRJ1QSuvv5TcNM5
	 DUnV9S5u9u4fgKeFBaiQhOAJ//2cCvmu3PmxQLMAPxQ8FJot8jicdAYLc4HfxsDAl3
	 MZ5JC52d8wkjpZR809N3aDwDy0z6Wc/+JY3OEXJJYEH3D4rBs6mdC3IXRfbZHGbXlw
	 tFFxH5ndExYCeXI+2TRxb/AysQeFv2l2tSeNYMtFWJztnOIjTYeKm8fMgamSjAGWO3
	 CL2pk1bpsb1wYsacE25k1XwjRmDCHaYbvjO1jjnU3f4xWn1M6X5mTK6lUymsxnTuNC
	 TbDmo51usvu+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75F404097B;
	Fri, 16 Oct 2026 06:55:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8ED0079D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 749C940969
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qDkqlRgTjaPY for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:55:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 14B7740960
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133721;
 b=qkXGuJWoS1btvF4NzQquxuvZqjYtLOReoteMVFA4MRXlQ4CZCWJ70sMmjKqHgOd0r4EI
 PaSXbeQs10tyMEPWJwomtKhH0uwrRUMVe4TEgcetfZS/tTyutSrWdRodjTPDug0M9kEUE
 F8C+FiqYoZxs3gigflK6Y3CsUUoySSllCiucoGv+vegqys3/JZFz2mN6ad84edooS7Tl3
 bUJh4lgX0hlGwBWsuwB4gRzvTobkFeZAc/I3UN3rnT7PmORREgpCTC6RZKO4Fmn6kyLWF
 9NVObm8XsAc/LqL2XnwQnMeO0bx5rpE3iU8PBHtj8I3SgyG87Rh5qQ6p+gDbXeI5I0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133721;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-ZohoMailClient;
 bh=/0snWQcS6BIGCMdDuOlbr2MRp+UIhct8/ucFmU7u4/s=;
 b=bvg2zIRMWIqpVEHHxFY0M3tBkKZNIHSuvbFQj3h8060lkvDDiLctA1lOA/fBsGdjDNo5
 I4sJ4WLbkH0HoDaiVzSfuIp7M8hT80vK2Y39KlJxP6OFsgbhTmh2dUO5a8oegKsSBlPRC
 sDTa0wuFCby5N4/8iggq+ZevQ6pRG4FVE5DqP56W4sB77mV7c9Dyo2h8Mi5CFuPMyporO
 nHUxkaLgXOkcIi3TxUsDfhMLM02oCiWskeFHT0+evOfL2064W7VntVtGfKgR73ffQAu2w
 l6ecsa8dKbkrt6rZbJ+nIdf+IW6Osi7zi2FWFKrWytdrqSn+OyOS5YCoV1x5EWi9BOQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=juGi4xyY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=juGi4xyY
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14B7740960
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133713; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iUyo8QKN5+bOzwUdKUI0LpBIz4Okg94tYo0uyK7bBwWkTjVn4PLH/J+7KC0VrEEUG0AHhpeM30yUn897zs0dVnAp8ubDuOCCTUdwI/kKsjw9XU70oce5SOawlZZmyh+G/pwpNh0yhdlCvDbTDPh0hRmKoS0a2IOwsRdNSN5QBvQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133713;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/0snWQcS6BIGCMdDuOlbr2MRp+UIhct8/ucFmU7u4/s=; 
 b=igOyMXTYVTG3BARyROk7oe8oD+5uWQDfWDvlgiGlwpmeUALfIzs0KDmNQodpSns1TDOcWX03GymzoNKGvy8jImt9OtU6ubFGdA0vTPIo4KLKF3mQoAbWmS5tXkqbc+rRUyAv9WO8fZp90xK2W7psHSygwQQFpm+Mt/vnEtYspXI=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133713; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=/0snWQcS6BIGCMdDuOlbr2MRp+UIhct8/ucFmU7u4/s=;
 b=juGi4xyYVXKhinKNQFH3/Nh3+ETisQnk6qExau7Cdt7Z6Dw77W9lvDd3uZkir3mT
 Gb4J+fo2queb66/nO5hmDuPj079oYvXjBdI3pWXv1/3BhQhZ7v2/XNwkOmK7Mhen028
 geqvf0ScdK3+5TyFbEGVKImgCM5+pYjFTLPo07rg=
Received: by smtp.zohomail.com with SMTPS id 1792133710993564.7615181379838;
 Thu, 15 Oct 2026 23:55:10 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 00/20] LoongArch initial support
Date: Fri, 16 Oct 2026 06:54:40 +0000
Message-ID: <20261016065500.137544-1-me@ziyao.cc>
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

Link to v4: https://lore.kernel.org/u-boot/20260911104604.2910944-1-me@ziyao.cc/
Link to v3: https://lore.kernel.org/u-boot/20260821084219.1703743-1-me@ziyao.cc/
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
 arch/loongarch/include/asm/cache.h            |   33 +
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
 arch/loongarch/lib/bootm.c                    |  129 ++
 arch/loongarch/lib/cache.c                    |  235 +++
 arch/loongarch/lib/crt0_loongarch_efi.S       |  182 ++
 arch/loongarch/lib/elf_loongarch_efi.lds      |   76 +
 arch/loongarch/lib/image.c                    |   77 +
 arch/loongarch/lib/interrupts.c               |  185 +++
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
 boot/Kconfig                                  |    1 +
 boot/bootm.c                                  |    5 +-
 boot/image.c                                  |    1 +
 cmd/Kconfig                                   |    2 +-
 cmd/booti.c                                   |    5 +-
 common/board_f.c                              |    2 +-
 common/spl/spl.c                              |    9 +-
 configs/qemu-loongarch64_defconfig            |   35 +
 doc/arch/index.rst                            |    1 +
 doc/arch/loongarch.rst                        |   30 +
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
 lib/efi_loader/efi_image_loader.c             |   38 +
 lib/efi_loader/efi_runtime.c                  |    4 +
 .../efi_selftest_miniapp_exception.c          |    3 +
 lib/fdtdec.c                                  |  127 +-
 103 files changed, 5804 insertions(+), 78 deletions(-)
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


base-commit: 65a7532545336e4b73e049a69436e255da7df961
-- 
2.55.0

