Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2346FC88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A27CA8126C;
	Fri, 11 Sep 2026 10:46:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hg9aGkfO8ADI; Fri, 11 Sep 2026 10:46:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 15BC881277
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123599;
	b=Vp/Jz1fPtVSNJxhgpuh5b7q126/fWXAgOI4vEq8j8yhGL4Bzu/LV+eYohcI+HF6uQAKB
	 g9WHWY9Bn5swvPDiLvhGUmJ4T88w0SsnIszTzu31CnpT0ZT0E1Ux8J6a78H5Pp9OpJfYE
	 TKW23jFXvEv409YJlY3FoFlFSPgC6r+GNld3lndktqhPAgjAewBAVK2nr+5IUHIOh0D0T
	 iI5pmlrAzBETQflxmKmmaw0sF09ue9SiBdp337Wf0ZHh16nM81/sFDMnx5jR+KC2VGZ0O
	 CiPKaruZKGBhSKafrf1VuyEoaHBa2nLScASswt98XmwewghAQB/Y0pG4DjcdhWOCNZw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5K8OXU1uFDkw2cmFjniBVHO6cNy81kv/3xInwOi1ooE=;
	b=kRi/N3pV2U0fxAH5EYIMyK3IQukEWeu+VyczlmIf9pIszaOorY9zrLO4Qa7AtsyjUph/
	 HameLcmcm3wMa1ms2scLPQDDs8yVuyNE1m33okwwpJ/gZjW37Gp8uEf29rj2n90vYKi6P
	 3V/nRIcdhwhqlUONDUMa6VPd/t7mE3drBBbxdQNgMcXK7gqzo9XuSsHVITMmFPkdnHqSx
	 Q5+8GITUTdngAEA0n9TGbB/gkZrOBNqcyRqEz/jZceNA9GvsaGAn/nr3p570HFdduVoDS
	 ZWDy/ozMQISoRjdA9qYIJCOIwDSq6HCbeEZqSbGndVfnRzr2Ad5F4g0HCw9FGb389vA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=UubhmzZd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123599;
	bh=5K8OXU1uFDkw2cmFjniBVHO6cNy81kv/3xInwOi1ooE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ygqk86UNbN03ZhVFrvFgo580x/+6vamFvGgCxZ+l057dUO6KpKNcEqBJ7mll/k9sL
	 xYXjbxdkCfxwG2Z93iVPZB73Rnsh1tttTX7cb6y2gj/33LRJ58qL5ommS6jIVg82ly
	 Aptma3Ccw1jKbWsF/2ZRNQAL313ZLeoEfPE2cRzFD4zxDzXnKm1BRv0FXGMJvsbFcy
	 cAlVJs0NXbRq+sN2CagwXj+5vAB6HI7bMCZ+AObSAqw1VhcPtVcGxVIfUruGlEcEbe
	 YrLQWwFP6JOYaFPy04/dc4QAnkKHV0xxTXx9ZVHtk5YfVDQ2QZR8C9mp3Jcmq/pjqm
	 tlSu+LlSpJM9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15BC881277;
	Fri, 11 Sep 2026 10:46:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 59DF314C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BDFC81249
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9O1zqTDjamaf for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:46:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0A21C811FD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123595;
 b=a5/oYcaeRsxxnGIpzt4/Kn8ymCYkO2DI4eRAWTqP4s5ELdmKyndK9HhWfSguEBoyxD25
 QPGu6ErWN1a1EQYgiAdgjePPEEVlBnd+awoBqZG5TjYDbhAfb5KFuxRFsqogkGEfqFnoL
 1G7GSJpNZA5gKrCxyQayBMjnklHl5jVxmUXT7Y/SccE4jzRaoOTPOuP9rCaY3W/sPG7C8
 4lA240CKdtwWn3Gp5KzQSdF7e3/9/+8JR4IkuGiP/qy8HDmWgxjX6UU5KEeyU7JNsU28F
 br6CVBMCGzmFvlgdUb6GS7GKSOBTKOeiWa02/A7FPCR9YZPH7HKUIfNc9r+r9aUgCdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123595;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-ZohoMailClient;
 bh=5K8OXU1uFDkw2cmFjniBVHO6cNy81kv/3xInwOi1ooE=;
 b=B64eTOELbfvvasYk6hqGbliR8MGNDHLXOgTQk1cMhNAWT14kCI2FWxK6eJKkHzSKiNLR
 b7VJAsEUtsRV+qzUCPebIrmVb/JMO6z8QJVepcOdRfGKWgFZnuusY5YAQFxnrPUvKKQIr
 TBpTuoKoA4rRp/Gl02iX8h6eKPmzukci4Tt61Uo8TtSY6h66CVW1vWs2S7g8MncIQf2nS
 ChxxjcEyY9SKigEh3JMbJte2lJH/wBrGwb2K7B8sZ/9xuT6Az88twjzCC0rIQy8+aWnuz
 EwPOIL+7tJ6LGwiegCNWHvimJEJwDhRUOhBebtl2J+sW0wqNQzzpY10q5OSvD3nxhWA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=UubhmzZd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=UubhmzZd
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A21C811FD
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123585; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jOzgWhZvzVyJrKVPN7IW9dyqNfIFpMf8NV7l87nf0xzVVgrketEXHmGTYBTkc0pXxbMnT1mr4cyIDKVsFwkcDey8lRO1Iq0EYAU/5doVIDivbV9iFQO5y5B6oU6+HLa9bb4tpJ/V8+ttgMZu/BhnQ3bEQPMO7nxrx0S/VKPJGUU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123585;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5K8OXU1uFDkw2cmFjniBVHO6cNy81kv/3xInwOi1ooE=; 
 b=aw8HiGn/FHe2Cp0Sw25WLuV7wJZq2/+aotH6OWaZQ1rNLGOOF+Bb8cjjDNmjm6w1iLdVPFF17ZL8MKbgdZTlZzpwjHtPm6jUllcG31WtHEDXN1lvWAfPYjTseVr8LQEBlCW88YOAEtTHacp0J9ibERvzt5tPu/8pbKHkRZyKCxU=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123585; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=5K8OXU1uFDkw2cmFjniBVHO6cNy81kv/3xInwOi1ooE=;
 b=UubhmzZdxF2utoqlH6w8WTT8hlcVpup+tJWtr2wqdebaIjTx/ZzkPr7QvvYBLvo3
 gC0fKCPE09lXQm+FSLBiVoCa2ny3kSiXf39cjTjr2AvxIpFlYhFG+XQzzWdgMykixi1
 ZiLWYIAFGG7tdonmrrJBVKvsBe+7LtfHMsBASRG0=
Received: by mx.zohomail.com with SMTPS id 1789123583308225.5406801598781;
 Fri, 11 Sep 2026 03:46:23 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 00/19] LoongArch initial support
Date: Fri, 11 Sep 2026 10:45:45 +0000
Message-ID: <20260911104604.2910944-1-me@ziyao.cc>
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
 arch/loongarch/Kconfig                        |   64 +
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
 arch/loongarch/lib/bootm.c                    |  129 ++
 arch/loongarch/lib/cache.c                    |  246 +++
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
 common/spl/spl.c                              |    9 +-
 configs/qemu-loongarch64_defconfig            |   35 +
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
 102 files changed, 5809 insertions(+), 77 deletions(-)
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


base-commit: d4152edb50356338af994d1c0483f65b717b4c15
-- 
2.55.0

