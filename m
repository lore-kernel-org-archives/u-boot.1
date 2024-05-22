Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4EAC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B218882C;
	Wed, 22 May 2024 17:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="oKiOouvf";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="gWultuyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B4D8882C; Wed, 22 May 2024 17:35:07 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B0F18857E
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id 0889318000CA;
 Wed, 22 May 2024 11:35:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 22 May 2024 11:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1716392102; x=1716478502; bh=x4
 cdIz3ZDZBX2d0RtvmV3du2yNC9i5tLVTibf2JP6bw=; b=oKiOouvfTg1sVEEA49
 93osJwIl/EgPFNL1Jjjui0Fhoves9QDwpiGg0pGFYScpnur9YfLsOZ5IP1DdxSWm
 awQelMZYvR4aH6heKq/EhytrdzBRKrkEc4il8aCiMyvUcnw5UYfcad495zmKvlH+
 yXqV+x34h05hXrzFJGH4z2C5wLLQjfXHdJ4fpuos7J7dlO5xNU26ozzS2htZ0Xna
 vnDnjgMY7tpQZqVjOrdt4gnYsZmQJ18mpPgH0ZTHSe8sXCpwpe1BM1/CfQkcs4kf
 O1eGJ70jXzchj2IweVIzw4mV6ZQyUjsf7wnC0Ydt65FbImOZCrVxmtwBd5YZNjQ9
 Hzpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1716392102; x=1716478502; bh=x4cdIz3ZDZBX2
 d0RtvmV3du2yNC9i5tLVTibf2JP6bw=; b=gWultuyOBd/WtcY6RZl1fvH5j82gy
 sUE1V21JzuSx55EPghwBiKuermE9YynvWVxljAJDlXL0qPduXSeEQmshi8LkigeF
 cNk2HGkxFBxhzofi4iqG3awx8Dehvz9QCUmHSEdlzqn/4vwKR/WqBp6ujrX8SuLa
 cWJ4UHgUtDZhCUk7EHSYi/xAZwyAIj7AE4ppMJSKtolYxdHZhQUOw0PmQFdNd5Mj
 gY+NtMdSsurEM6I+OLnd1i5lYvmZVkFu/ankyAQloSbKt5URLj9EKmre3cIHGJ/0
 hem5izplBs0BoY+u1vAtHzAKNMR5984YzlK6JJidSo5CH9/MoHQEuo5SQ==
X-ME-Sender: <xms:phBOZkKPrVSdB3FM7fgUUvK1OV0BLE1i5CZaVHIOb-Qqj-8PJG8LqQ>
 <xme:phBOZkJnaZFxRlZ21MpeTCKf6MGfv7X1pNcPnzTi041ucGiB1Y4ZOcm-WX4rc_Wkr
 jjM2qgZfyVwf4TW1Bg>
X-ME-Received: <xmr:phBOZkub3gAFtC9RV6NQ_nbfYsADuauzWqD-MArD-qLUeOKezZ4dZno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepkeejgfdtteeljeeuvdeiteegheefleehgeevuefgfeevhfevheeh
 hfefieegvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:phBOZhbtVNbCuHYHhkhfMRtY5sdnOO3I-gWhWaFSvVW-iDQnrIWkLw>
 <xmx:phBOZrZ6tm8NlLHkkqxpa8TxdEIXSRbw_FMVXRXxlZTi5zaORZqP4A>
 <xmx:phBOZtBfoPeuU-Bm-FxwhshnYERdBVXRSN_I52IEqzVGvB2OKLU7iQ>
 <xmx:phBOZhY9u6sGx-GtzB2xO9Usc2FZtb7uncD4mEjvZ1jP9uhz0omGlA>
 <xmx:phBOZgNJhTDaS8p-z_qUMgL2Rnat1_KE-5ehho21mSpt2HzCKDnXilO4>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:01 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 00/16] LoongArch initial support
Date: Wed, 22 May 2024 16:34:43 +0100
Message-Id: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJMQTmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyMj3Zz8/Lz0xKLkDF2LRAOTZMNUY5NEE3MloPqCotS0zAqwWdGxtbU
 A7/FKJlsAAAA=
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8939;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=y+Vg6Bi/Lff+U2JeDHPrOathbniY6OLzAIIBmgfx5FA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geU/+IIsy0r28YQ7HD5pbXAiiPMZyx/ljAcmftO/2
 ST8b3fqKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIkclGRk+J9j9GlZzf9dsVve
 HdZ5V96VY7rA6WOX0EaOn00tnJtrPzH801sV90rJZpYjT2NA0GqL4I0eHllHzOsq/k+9c7gtyl+
 dEwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Sorry for flooding the mailing list recently, yet another huge RFC series ahead.

So after working on MIPS, arm64be and Xtensa I'm now on LoongArch, as suggested
by Heinrich.

So far this series has implemented general support for initializing CPU,
exceptions, kernel booting, CPU and timer drivers, QEMU LoongArch virt machine
support and UEFI standard compliant EFI booting support.

LoongArch had defined 3 ISA variants, LA64, LA32 and LA32R (Reduced, intended
for MCUs). Currently, only LA64 is implemented as 32bit support in open sourc
 world is not mature yet. However, most of the code is written with 32 bit
support in mind, so it should be trivial to add 32 bit support in the future. 

It is a little endian only architecture.

This series had passed checkpatch with exceptions on some false alarms and
headers imported elsewhere.

I had tested virtio devices, qfw direct kernel booting, efistub kernel
booting and grub.

Toolchain can be found at [1] or using upstream one, I had also discovered a
couple of issues in kernel and QEMU in the porting process, patches
at [2] and [3].

To build:
```
make qemu-loongarch64_defconfig
make
``

To run in QEMU (patched):
```
qemu-system-loongarch64 -nographic -machine virt -bios u-boot.bin
```

TODOs for me on this series:
- Documents
	- I'll write board level document for QEMU,
	  what should I write at architecture level?
- MAINTAINERS entries
	- I'm not sure what I should add here, please suggest!
- Further clean-ups

TODOs on the architecture & board:
- loongson,ls7a-rtc driver
	- The only device on QEMU board haven't been supported yet
- LoongArch sandbox host support
- Implement LoongArch's PE relocations
	- No application is using it so far,
	  pe-format spec is not really clear.
- TLB enablement
	- This is required for real CPU to utilize caches
- Possibly EFI-APP support for real machine

Porting to real SoCs is out of my scope as a hobbyist, I'll try to
convince Loongson people or other hobbyists to work on that.
I intended to use U-Boot as an OVMF replacement and second stage BL.

Any comments are much appreciated!

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (16):
      lib: fdtdec: Handle multiple memory nodes
      linux/io.h: Use map_physmem to implement ioremap
      image: Take entry point as an output of setup_booti
      elf.h Define LoongArch bits
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

 arch/Kconfig                                       |   15 +
 arch/arm/lib/image.c                               |    3 +-
 arch/loongarch/Kconfig                             |   49 +
 arch/loongarch/Makefile                            |   19 +
 arch/loongarch/config.mk                           |   27 +
 arch/loongarch/cpu/Makefile                        |    9 +
 arch/loongarch/cpu/cpu.c                           |   28 +
 arch/loongarch/cpu/generic/Kconfig                 |   13 +
 arch/loongarch/cpu/generic/Makefile                |    7 +
 arch/loongarch/cpu/generic/cpu.c                   |   22 +
 arch/loongarch/cpu/generic/dram.c                  |   21 +
 arch/loongarch/cpu/genex.S                         |   21 +
 arch/loongarch/cpu/smp_secondary.S                 |   55 +
 arch/loongarch/cpu/start.S                         |  169 +++
 arch/loongarch/cpu/u-boot.lds                      |   85 ++
 arch/loongarch/dts/Makefile                        |   13 +
 arch/loongarch/dts/qemu-loongarch64.dts            |    9 +
 arch/loongarch/include/asm/acpi_table.h            |    8 +
 arch/loongarch/include/asm/addrspace.h             |   87 ++
 .../include/asm/arch-generic/entry-init.h          |   15 +
 arch/loongarch/include/asm/asm.h                   |  186 +++
 arch/loongarch/include/asm/atomic.h                |   12 +
 arch/loongarch/include/asm/barrier.h               |  138 ++
 arch/loongarch/include/asm/bitops.h                |  156 +++
 arch/loongarch/include/asm/byteorder.h             |   22 +
 arch/loongarch/include/asm/cache.h                 |   24 +
 arch/loongarch/include/asm/config.h                |   11 +
 arch/loongarch/include/asm/cpu.h                   |  123 ++
 arch/loongarch/include/asm/dma-mapping.h           |   27 +
 arch/loongarch/include/asm/global_data.h           |   43 +
 arch/loongarch/include/asm/gpio.h                  |   11 +
 arch/loongarch/include/asm/io.h                    |  399 ++++++
 arch/loongarch/include/asm/linkage.h               |   11 +
 arch/loongarch/include/asm/loongarch.h             | 1468 ++++++++++++++++++++
 arch/loongarch/include/asm/posix_types.h           |   87 ++
 arch/loongarch/include/asm/processor.h             |   11 +
 arch/loongarch/include/asm/ptrace.h                |   33 +
 arch/loongarch/include/asm/regdef.h                |   42 +
 arch/loongarch/include/asm/sections.h              |    8 +
 arch/loongarch/include/asm/setjmp.h                |   25 +
 arch/loongarch/include/asm/spl.h                   |   11 +
 arch/loongarch/include/asm/stackframe.h            |  175 +++
 arch/loongarch/include/asm/string.h                |   11 +
 arch/loongarch/include/asm/system.h                |   74 +
 arch/loongarch/include/asm/types.h                 |   37 +
 arch/loongarch/include/asm/u-boot-loongarch.h      |   23 +
 arch/loongarch/include/asm/u-boot.h                |   30 +
 arch/loongarch/include/asm/unaligned.h             |   11 +
 arch/loongarch/lib/Makefile                        |   26 +
 arch/loongarch/lib/asm-offsets.c                   |   66 +
 arch/loongarch/lib/boot.c                          |   14 +
 arch/loongarch/lib/bootm.c                         |  177 +++
 arch/loongarch/lib/cache.c                         |   73 +
 arch/loongarch/lib/crt0_loongarch_efi.S            |  182 +++
 arch/loongarch/lib/elf_loongarch_efi.lds           |   76 +
 arch/loongarch/lib/image.c                         |   66 +
 arch/loongarch/lib/interrupts.c                    |  189 +++
 arch/loongarch/lib/reloc_loongarch_efi.c           |  107 ++
 arch/loongarch/lib/reset.c                         |   14 +
 arch/loongarch/lib/setjmp.S                        |   52 +
 arch/riscv/lib/image.c                             |    4 +-
 arch/sandbox/lib/bootm.c                           |    2 +-
 board/emulation/qemu-loongarch/Kconfig             |   68 +
 board/emulation/qemu-loongarch/MAINTAINERS         |    7 +
 board/emulation/qemu-loongarch/Makefile            |    6 +
 board/emulation/qemu-loongarch/qemu-loongarch.c    |   84 ++
 board/emulation/qemu-loongarch/qemu-loongarch.env  |    6 +
 boot/bootm.c                                       |    5 +-
 boot/bootmeth_efi.c                                |    2 +
 boot/image.c                                       |    1 +
 cmd/Kconfig                                        |    2 +-
 cmd/booti.c                                        |    5 +-
 common/spl/spl.c                                   |    9 +-
 configs/qemu-loongarch64_defconfig                 |   36 +
 drivers/cpu/Kconfig                                |    6 +
 drivers/cpu/Makefile                               |    1 +
 drivers/cpu/loongarch_cpu.c                        |  148 ++
 drivers/timer/Kconfig                              |    8 +
 drivers/timer/Makefile                             |    1 +
 drivers/timer/loongarch_timer.c                    |  112 ++
 include/asm-generic/pe.h                           |    2 +
 include/config_distro_bootcmd.h                    |    5 +
 include/configs/qemu-loongarch.h                   |   13 +
 include/efi_default_filename.h                     |    2 +
 include/elf.h                                      |    9 +-
 include/image.h                                    |    4 +-
 include/linux/io.h                                 |    3 +-
 lib/efi_loader/Kconfig                             |    2 +-
 lib/efi_loader/efi_image_loader.c                  |    7 +
 lib/efi_loader/efi_runtime.c                       |    4 +
 lib/efi_selftest/efi_selftest_miniapp_exception.c  |    2 +
 lib/fdtdec.c                                       |  137 +-
 92 files changed, 5559 insertions(+), 70 deletions(-)
---
base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
change-id: 20240522-loongarch-8a04c1e34a47

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

