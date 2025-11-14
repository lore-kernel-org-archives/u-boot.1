Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ADACE7AA3
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 10:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 759FA83EF9;
	Fri, 14 Nov 2025 11:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linenoise.info
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linenoise.info header.i=@linenoise.info header.b="K6knNWUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 981E083E83; Fri, 14 Nov 2025 11:30:57 +0100 (CET)
Received: from ibeerc.linenoise.info (ibeerc.linenoise.info [130.61.186.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C9783F1F
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 11:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linenoise.info
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alvaro@linenoise.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linenoise.info;
 s=ibeerc; t=1763116251;
 bh=6uRYa6iVKPkgK3Uh2RtHH2mRsG3mql+vKUuUxGIdanU=;
 h=Subject:From:To:Date:From;
 b=K6knNWUKoc5OEBtTsNGuXgcp8AB58KYkwf+77Sj6eC8GFqO5/XxtHkVYyoikkBQ7T
 5N13/x0t/jdiTVjGAXoOGZF6b4DvZXuNVP21GI5fp+GIvfbT9xfsGrggOvb60x6wyy
 iswwuDoK3PkaDybkHNUEijaQCoMHk+ZwOCsQNoBR2Ap0YlYKRec76ewBdpH1fWwFwz
 kEhQfD+pkoX6ZyNtKYZ/gLrGaBACBRNgQXQWMiN4lyjy53GTvMvHiL1YlZzubBxQOm
 tIqa/xK7pJM5BMkNmelyEYqUoGuVhE7P2iKTs/Tu/wOwW5+rOZMOuIu8JcwPkb4OZ3
 qXRNeqAvwF+7Q==
Received: from [192.168.2.3] (unknown [109.227.150.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ibeerc.linenoise.info (Postfix) with ESMTPSA id 87360202CA
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 11:30:51 +0100 (CET)
Message-ID: <34fcf068f421f6d95d41271ef52400d7464d080e.camel@linenoise.info>
Subject: How to boot u-boot from embedded ELF file in Microblaze core
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro@linenoise.info>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Date: Fri, 14 Nov 2025 11:30:51 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
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

Hi,

I've built u-boot proper for microblaze with:

CONFIG_MICROBLAZE=3Dy
CONFIG_TEXT_BASE=3D0x80100000
CONFIG_SYS_MALLOC_LEN=3D0xc0000
CONFIG_SYS_MALLOC_F_LEN=3D0x400
CONFIG_NR_DRAM_BANKS=3D1
CONFIG_ENV_SIZE=3D0x20000
CONFIG_DEFAULT_DEVICE_TREE=3D"system"
CONFIG_SYS_LOAD_ADDR=3D0x0
CONFIG_DEBUG_UART_BASE=3D0x40600000
CONFIG_DEBUG_UART_CLOCK=3D83250000
CONFIG_TARGET_MICROBLAZE_GENERIC=3Dy
CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=3D1
CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR=3D1
CONFIG_XILINX_MICROBLAZE0_USE_BARREL=3D1
CONFIG_XILINX_MICROBLAZE0_USE_DIV=3D1
CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL=3D2
CONFIG_XILINX_MICROBLAZE0_HW_VER=3D"11.0"
CONFIG_XILINX_MICROBLAZE0_FPGA_FAMILY=3D"artix7"
CONFIG_DEBUG_UART=3Dy
CONFIG_SYS_LITTLE_ENDIAN=3Dy
CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy


I can load this via xsdb and u-boot works and is capable of booting Linux
kernel. However, there are a couple of things I don't understand.

First off, if I set CONFIG_TEXT_BASE=3D0x80000000 (the exact beginning of R=
AM), it
won't boot, not even early debug message will appear. Why is that?

And the second thing, my endgame is to embed u-boot.elf into Microblaze its=
elf,
so it acts as FSBL. I reduced the size to the maximum and I got a quite sma=
ll
binary, even smaller than my current bootloader (the one from Xilinx that l=
oads
an SREC image from flash), so there shouldn't be any issue from that part. =
To do
this, I set CONFIG_TEXT_BASE=3D0x0, but again, no early boot debug message
appears.

I've tried different values for CONFIG_TEXT_BASE in this case, but none of =
them
will work. Also, in either case, I'm not sure why, but I can't debug step b=
y
step via xsdb, I won't see what ASM or C code matches with current PC addre=
ss.
However, SPL will let me run it step by step via xsdb.

I'd appreciate any help regarding this.

Best regards, thank you

--=20
=C3=81lvaro G. M.
