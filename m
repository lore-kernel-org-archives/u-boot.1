Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5595606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U4W07k9W;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=pLlBI8zH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E9C94073D;
	Thu, 29 Oct 2026 05:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PDM9oE1TO_Y5; Thu, 29 Oct 2026 05:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 58B9140713
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250507;
	b=kEOvwZG/4KteqLkqq4fiNE42r/GQxG3vdflJB0ZMgTCjUJjT+YIP38kNI7gJ3eY9WuBN
	 2wUv61kHaDb9soIzUKs0sG9odqe5e9+A/0ZS+fIPXhuuKIg82d8pBEZyFM2F1tBk+iHvN
	 IhdTJ8yAyp7xBAmRIe4Cb4uxtukUl3X4WtdcD3cqv62yxAuJEUrcI3Qp3HJYZA8viCWx0
	 8Tbq3ujUSb3wvZ9NA7okxKIJel0qgB2M2wI7EBLREr7rKfgI678Su0sbxn0D3MfSeJZhC
	 8+nepmA8fOXVUMI0mpUGMQ6rU/EAwZUxbE/o/sFxc2j1H6xjPiBCleEixhDm4Zr654A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sPTztpdo2ZHGadBKLMLDtJ/3i3FGv/CyD5cTlR9lbz8=;
	b=EhcyRrNm2T3uWTEfBPnM1uFUhZlfXGqaxzTCcdnJfQoZBO7BBZXjUMsUvmlLSezeOqO7
	 gVSBy6TxZoyG0i+5H1TgU35/s4/Fd/FZ9gODCewuAhonDgaayYVxoCita8bhs2oEvhwpF
	 ZXSstrMpP6l4b7JkeaRRTqFzVyDImDZUBoDQ/EkmTpVnDiDqeJysgXXHq9l4bnXHNmS8i
	 vBdqsdpn/3Vl4MBth5FtmV8j+AnzDBPnVvoxCfQW8qHr2tvmQX67WCMNsNc0piaptdRss
	 /R9SQfhipBHnPwuVNQk5UJ0L6hZF9HwmEDcw7eQFmCYh7EbrfaHYKUs4zwrbBSBnfKg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250507;
	bh=sPTztpdo2ZHGadBKLMLDtJ/3i3FGv/CyD5cTlR9lbz8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U4W07k9WriNeefINyxCRVLfVUN5ojawep5TJUwRFtBzyOuREU22MxiNtcyUa0wwpd
	 fvevEoQpdptjjhi9ZDdon9IGzk6G28V8oVs5OJLYPA6buEhceZrVlbWe233i/btttQ
	 pzJJ78S820LW6yIRJjdjj0PeC74LwAjQB6wtOO5kNzGknG9BkB4nBTCdHzAd/Yw7dU
	 8Xz+Fy+t3mUP8QaUgk0arEeF4zN4f4SGRJvTwFocBbUQ8Zv7m8E+kZzDQRQJn45xzh
	 tl/+9bU3GrJkwNWoaVt4KYvN1R5OyLcRpoFtVnSN1uDnrZuoWYojj95DdOe0suNC8N
	 HmKyfcfiRyjNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58B9140713;
	Thu, 29 Oct 2026 05:08:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C6862E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E28C606BD
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYYXHVOAPGKR for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 166716069F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250502;
 b=XRyjcl+FRdEGR492CCXH8tL7MFQZCYWhTCr2kZr8KOzGMQmhzfiN5uPL6vIwKC85mJF0
 fGqiXYyOfMF4zTAB9nDjVzesKbg/rYu6HBCmXOsASFpg7kC3XhVlaIFI9elhT8gxDXYNa
 qqDkmaZMoBgJvaNIAD2OZRwt8aebaI0P7Sp2SDaugbOt3MgJci8UPZWX37lYclf2vkGLV
 bhQ/cnSwHOWyqBcdIRZku22DzWLwDkdK834Q2T3y+X72qQaLzcii4noGQjYMz8urS1/zP
 WOJ8C3s/+tbXfaYaPyKGLYoe3oJwJwYGAaIjDeUm2kt7aB85s+bG86hWcKlCLyRjj0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250502;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-ZohoMailClient;
 bh=sPTztpdo2ZHGadBKLMLDtJ/3i3FGv/CyD5cTlR9lbz8=;
 b=CPZ3CTLbrSFv3ZC/93z8kg/+KAalq+pI4An8A1CUpz/exVaKr2Jqtzt6FewcBmPXnWVc
 DzpQYBv8y9659Egeqo51f0v0M8ZpQ0TsLNKq7Ku/EL7IPfHLYXCM9vJ25XFtUR2l25xMj
 9N9FMT66l1u8LJ0voKTXkhaekxBK87jNBjQavQWI69t3LRz79sIRtwlU3f/wceCqSMp/e
 pzjpwmobQdSf65dqlvtAUxsqxpi45a1R9bFyLXfrFVfORRnPrZDew6VlRqVjX+6sqM9Ox
 qJ6eovBHSlnN7L+9s0TGFPzLaOBn7aadcJowTNAlz5Slp065YoOooAfnYUQdAln0PJw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=pLlBI8zH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=pLlBI8zH
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 166716069F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250493; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AsE299HKqHBBBUvg6N0ZETdYWQNtGtcxre28rP+26ISJTUeOLS8ePcyueQhYhUwDCzEeY1Rq75kZ9putKkAGAXMO+SejYriKvrt2Kx2KG7jB1UWjoRhC2Hh9M0zhfbHgJwlo6gFL762YAT0/JXKqdVrHfTI4gtZQ1+UMssb0PWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250493;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sPTztpdo2ZHGadBKLMLDtJ/3i3FGv/CyD5cTlR9lbz8=; 
 b=I79I9ya0pfUqbewtZcnSY5zHGmsXipCIrVS40VExX/pULictCC0hsAC6hSjgj6LC565HLX2SEtYsp8lSbg2SiNWEktKyI/K+dDwttqj2HTMDzapmVaEfJYu1bEC0DddP2WrmjuHK+vhMK4QhwX/4gR4pj2glKU201Mfn9+L3LX4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=pLlBI8zHZADe4RmiCnw6zGi2f4D6zq/seSD5bKBfZGj/7gulvFAZb29WSFVN97XFnv0SpDkNh2Ch7bIzcoJMB4PWpvTwXpXyQ+A23DuUnBrtgU28ho8Wz0Jtel9fYm6J/3aFnCCO0T6LZPfmlmzVSiXI0DdjILnTOYozgfdWlJI=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=sPTztpdo2ZHGadBKLMLDtJ/3i3FGv/CyD5cTlR9lbz8=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250487412147.33288803321443; 
 Wed, 28 Oct 2026 22:08:07 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: [PATCH v6 00/20] LoongArch initial support
Date: Thu, 29 Oct 2026 05:07:17 +0000
Message-ID: <20261029050738.1107663-1-me@ziyao.cc>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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
[3]: https://github.com/u-boot/u-boot/pull/1059
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
 arch/loongarch/lib/Makefile                   |   22 +
 arch/loongarch/lib/asm-offsets.c              |   66 +
 arch/loongarch/lib/boot.c                     |   14 +
 arch/loongarch/lib/bootm.c                    |  129 ++
 arch/loongarch/lib/cache.c                    |  235 +++
 arch/loongarch/lib/crt0_loongarch_efi.S       |  182 ++
 arch/loongarch/lib/elf_loongarch_efi.lds      |   76 +
 arch/loongarch/lib/image.c                    |   77 +
 arch/loongarch/lib/interrupts.c               |  185 +++
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
 103 files changed, 5802 insertions(+), 78 deletions(-)
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


base-commit: 903c9578eeb36d72f087082da494c605ddaed3b2
-- 
2.56.0

