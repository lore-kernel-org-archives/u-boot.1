Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A52606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vCd/sfJu;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=EnEptxXG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA60C80E31;
	Wed, 25 Nov 2026 14:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6npXbqaAfHv; Wed, 25 Nov 2026 14:28:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17B6F80E36
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795616884;
	b=Y6X4jsjTrIdZ+TuIaOagbTV9Li8rfqyM6xjzDExz4l493WBrKZGlLO0p6mFp4Ui45ATs
	 ofIj7hrosGXDDsWqsinYcZmelv1NQnuXoItqGOYxySC3NWTrKC8U9u+JsnOFQCrtKVmf2
	 9rU0n4uqp7ZPJG9UefFrwjNhZWuSI7sUqzfOzlk4JrAydRYV8Kx39goOGoAwMLa6gF0bO
	 bbqi1x374cxOfeDOz06DhmPPKtDoRKpzJku+pwDd71xoFo913ALBtFZ0BfHWI3a5HeDWL
	 d6/1j0LULjJUxYW+riwdQwnzYqYjCQ4fDNiQ1yMv4n3uEMSV5QgZGXOjY8T6Mlzwxbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795616884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XYdn6i7glIgRUUU/EUPN+JbwJwbTjXrrL9cIeKOvUas=;
	b=JzYFIaDYJnCGk9pPEo6mbQrc2INoY1xAgc4ZV+OZE9EG7sx+hhBj9SOTboG9pa5eu8wi
	 pnzkkqEiaDON4NXPF6O9rEsKAoQ3rHWvwFWyVIuyhNKnZCwd6k8HHO6v/IpcZyy16kxbJ
	 vteHos24m9tVvphUV6D7H4IpIHannvfVt0hIY8x1dhOViRoeB9Qkb14yLxakl7lvDs7rY
	 64IFA7LocyWh3rg8qDRjUsXsz5J3C5entqxMlYlE6DY8n9rRUIYs1VBn6NNvzxbce2/RD
	 ARhxsBjyqjGCYpoUD7qtyZxu2xH3Bzp1SQaDBIJPzLCCK0k9F5aZCGTdshfn2pIx6ZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795616884;
	bh=XYdn6i7glIgRUUU/EUPN+JbwJwbTjXrrL9cIeKOvUas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vCd/sfJuWONVunb+RlMj05Ci9wMGO4t2sPOeEKk5Wg2XJT0+jQAIKA8neqO+JyD9S
	 01jYsf1N7xwdnSTomvaZUpmx1+QhnEgbRwLU1c5JKZIxWKdlNqFQ7oEpBBlvRICTHN
	 xfCa1prqrSPMPSDSq6rZ3HAxmqFoODTP4c6yUTiMxr2Ov3406PDxoG8p7Ihvp2ykMg
	 p6SDisywaHn/w3WRTQFbGSZMwTGNA0LIeI5NjW2Ren1MmaoWqhPzYZI8wykLc7fnKA
	 n0NVFXgyoGwbgnMG1vzHZco4+yAFociCvXYjzpTw/T4NzXx/EtlVvaQvrjH6ejeKkT
	 fekXWsVRIXW5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17B6F80E36;
	Wed, 25 Nov 2026 14:28:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0317343
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0068F40568
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:28:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kmQ-FW95agYm for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 14:28:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C13C4055A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=EnEptxXG
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C13C4055A
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795616825;
 bh=XYdn6i7glIgRUUU/EUPN+JbwJwbTjXrrL9cIeKOvUas=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EnEptxXGTVqLv6GwsD5O//4wnbmdlEcipMpYlJvuFGmyLgPHzE/m8OQ754oUBTBGN
 M9if1O5gZx05i+IicLaFNRoUjT7gvtO2t6k8MW8EIchQ6ucfoIH2O/5Cr1XasD1/vS
 C9cQ+z01+9y1NzHOG261G27qAoe/Mmx1JL/maZKiqkjkey6J/cDdAppX19Gh7tIHKU
 6MOOpsjGdto1oSPpgyrDY2QsAsav+aShVm7BAqecua7LgEcCul6UJgrX/Qh77gghbJ
 o3y5rKwFEMmZWgRf0K9K7cRFw8Pj5eIiZaiYMHuPDka4KV1CmAdt+lxP33LcF2GO+/
 2iFLKk8HSFY2A==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 585AFB22053D;
 Wed, 25 Nov 2026 15:27:02 +0100 (CET)
Message-ID: <243508ce-c342-489f-99b6-11996824e20a@freeshell.de>
Date: Wed, 25 Nov 2026 06:26:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] board: sophgo: Add Milk-V Duo S documentation
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>,
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>,
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>,
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>
References: <20261125-upstream-v1-milk-duo-s-v3-0-9ed94b63cbbe@gmail.com>
 <20261125-upstream-v1-milk-duo-s-v3-3-9ed94b63cbbe@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261125-upstream-v1-milk-duo-s-v3-3-9ed94b63cbbe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 04:20, João Paulo Gonçalves wrote:
> Add documentation for the Milk-V Duo S board, describing how to build
> U-Boot, the boot flow (FSBL, OpenSBI and U-Boot) and how to generate
> the fip.bin image.
> 
> Milk-V builds the Sophgo FSBL as part of its SDK, with the T-Head
> toolchain and the Sophgo U-Boot fork, which does not support a standard
> GCC toolchain or a mainline u-boot.bin. The FSBL build steps are therefore
> based on the community-maintained meta-riscv layer, which provides the
> board memory map and the FSBL patches needed for both.
> 
> Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> ---
>  board/sophgo/milkv_duo_s/MAINTAINERS |   1 +
>  doc/board/sophgo/index.rst           |   1 +
>  doc/board/sophgo/milkv_duo_s.rst     | 142 +++++++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+)
> 
> diff --git a/board/sophgo/milkv_duo_s/MAINTAINERS b/board/sophgo/milkv_duo_s/MAINTAINERS
> index 435d4827fdea..86533c03fd9a 100644
> --- a/board/sophgo/milkv_duo_s/MAINTAINERS
> +++ b/board/sophgo/milkv_duo_s/MAINTAINERS
> @@ -4,4 +4,5 @@ M:	Hiago De Franco <hfranco@baylibre.com>
>  S:	Maintained
>  F:	board/sophgo/milkv_duo_s/
>  F:	configs/milkv_duo_s_defconfig
> +F:	doc/board/sophgo/milkv_duo_s.rst
>  F:	include/configs/milkv_duo_s.h
> diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
> index 19c9a19b1d4b..61aceafceea3 100644
> --- a/doc/board/sophgo/index.rst
> +++ b/doc/board/sophgo/index.rst
> @@ -7,4 +7,5 @@ Sophgo
>  
>     milkv_duo
>     milkv_duo_256m
> +   milkv_duo_s
>     licheerv_nano
> diff --git a/doc/board/sophgo/milkv_duo_s.rst b/doc/board/sophgo/milkv_duo_s.rst
> new file mode 100644
> index 000000000000..e4c201de2c4c
> --- /dev/null
> +++ b/doc/board/sophgo/milkv_duo_s.rst
> @@ -0,0 +1,142 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Milk-V Duo S
> +============
> +
> +SG2000 RISC-V SoC
> +-----------------
> +The SG2000 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
> +
> +Mainline support
> +----------------
> +Support for the following drivers is already enabled:
> +
> +1. ns16550 UART Driver.
> +2. Synopsys DesignWare MSHC Driver.
> +3. Synopsys DesignWare Ethernet Controller.
> +
> +Building U-Boot
> +~~~~~~~~~~~~~~~
> +1. Add the RISC-V toolchain to your PATH.
> +2. Set up the cross-compilation environment variable:
> +
> +.. code-block:: console
> +
> +   export CROSS_COMPILE=<riscv64 toolchain prefix>
> +   cd <U-Boot-dir>
> +   make milkv_duo_s_defconfig
> +   make
> +
> +This will generate u-boot.bin.
> +
> +Boot flow
> +~~~~~~~~~
> +The board boots from a FIP image, fip.bin, which contains the following
> +binaries:
> +
> +- FSBL (First Stage Boot Loader): the Sophgo (SoC vendor) bootloader [1]. It
> +  serves the same purpose as U-Boot SPL, but U-Boot does not support SPL for
> +  this SoC yet, so the Sophgo FSBL is required.
> +- OpenSBI (fw_dynamic.bin), built with the board devicetree.
> +- U-Boot (u-boot.bin).
> +
> +The boot flow is:
> +
> +1. The boot ROM loads fip.bin from the FAT partition of the SD card and runs
> +   the FSBL.
> +2. The FSBL initializes the clocks and DRAM, starts the coprocessor firmware
> +   on the C906L if present, and loads OpenSBI and U-Boot into DRAM.
> +3. The FSBL jumps to OpenSBI, which runs in M-mode.
> +4. OpenSBI starts U-Boot in S-mode.
> +
> +The fip.bin image is generated by the FSBL build, using the fiptool.py script
> +from the FSBL source code.
> +
> +Booting
> +~~~~~~~
> +To run u-boot.bin on top of the FSBL, follow these steps:
> +
> +1. Generate a compatible u-boot.bin using U-Boot with the Milk-V Duo S
> +   default configuration.
> +
> +2. Use mainline OpenSBI v1.5+ (v1.5 is the first release supporting the SG2000
> +   [2]). Use FW_FDT_PATH to point to the sg2000-milkv-duo-s.dtb device tree
> +   file while compiling fw_dynamic. Example:
> +
> +.. code-block:: console
> +
> +   cd <OpenSBI-dir>
> +   make PLATFORM=generic FW_FDT_PATH=<U-Boot-dir>/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dtb
> +

I think FW_FDT_PATH is not usually specified for fully-relocatable
generic platform build of opensbi to use in U-Boot. The text "Use
FW_FDT_PATH to point to the sg2000-milkv-duo-s.dtb device tree file
while compiling fw_dynamic" explains what it does, but not why this is
needed?

> +This will generate build/platform/generic/firmware/fw_dynamic.bin.
> +

Yes, if I understand correctly then U-Boot main app is build with some
dtb which is passed on to OpenSBI M-Mode which provides a lever for
S-Mode and run U-Boot Main app;  is that not how it works for this SoC here?

> +3. Build the FSBL [1] and generate fip.bin. Milk-V (the board vendor) builds
> +   the Sophgo FSBL as part of its SDK [4], together with the T-Head toolchain
> +   and the Sophgo U-Boot fork. That build does not support a standard GCC
> +   toolchain or a mainline u-boot.bin. The steps below are therefore based on
> +   the community-maintained meta-riscv layer [3], which provides the board
> +   memory map and patches the FSBL to compile with a standard GCC toolchain and
> +   pack a mainline u-boot.bin.
> +
> +   Mainline U-Boot lacks the 32-byte loader header of the Sophgo U-Boot fork,
> +   so fiptool.py prepends one, loaded at LOADER_2ND_BASE. LOADER_2ND_BASE must
> +   therefore be CONFIG_TEXT_BASE - 0x20 (0x80200000).
> +
> +   The FSBL also needs the board memory map header, cvi_board_memmap.h,
> +   generated from memmap.py with mmap_conv.py. Example:
> +
> +.. code-block:: console
> +
> +   git clone https://github.com/riscv/meta-riscv.git
> +   git clone -b sg200x-dev https://github.com/sophgo/fsbl.git
> +   cd fsbl
> +   git am ../meta-riscv/recipes-bsp/milkv-duo-fsbl/milkv-duo-fsbl/*.patch
> +   python3 ../meta-riscv/recipes-bsp/milkv-duo-fsbl/milkv-duo-fsbl/mmap_conv.py \
> +       --type h \
> +       ../meta-riscv/recipes-bsp/milkv-duo-fsbl/milkv-duo-fsbl/milkv-duos/memmap.py \
> +       plat/cv181x/include/cvi_board_memmap.h
> +   make CROSS_COMPILE=<riscv64 toolchain prefix> \
> +       ARCH=riscv BOOT_CPU=riscv CHIP_ARCH=cv181x DDR_CFG=ddr3_1866_x16 \
> +       LDFLAGS=--no-warn-rwx-segments \
> +       MONITOR_PATH=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin \
> +       LOADER_2ND_PATH=<U-Boot-dir>/u-boot.bin \
> +       LOADER_2ND_BASE=0x80200000
> +
> +This will generate build/cv181x/fip.bin.
> +
> +4. Place the generated fip.bin file into the FAT partition of the SD card.
> +
> +5. Set the board's boot core selection switch to the RV (RISC-V) position.
> +
> +6. Insert the SD card into the board and power it on.
> +
> +The board will automatically execute the FSBL from the fip.bin file.
> +Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
> +U-Boot.
> +
> +[1]: https://github.com/sophgo/fsbl
> +
> +[2]: https://github.com/riscv-software-src/opensbi/releases/tag/v1.5
> +
> +[3]: https://github.com/riscv/meta-riscv/tree/master/recipes-bsp/milkv-duo-fsbl
> +
> +[4]: https://github.com/milkv-duo/duo-buildroot-sdk-v2
> +

The above build guide is clear and easy to follow, nice effort with this
as documentation :-)

> +Sample boot log from Milk-V Duo S board
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +  U-Boot 2027.01-rc2 (Nov 25 2026 - 09:07:47 -0300) milkv_duo_s
> +
> +  DRAM:  512 MiB
> +  Core:  30 devices, 14 uclasses, devicetree: separate
> +  MMC:   mmc@4310000: 0, mmc@4320000: 2, mmc@4300000: 1
> +  Loading Environment from nowhere... OK
> +  In:    serial@4140000
> +  Out:   serial@4140000
> +  Err:   serial@4140000
> +  Net:
> +  Warning: ethernet@4070000 (eth0) using random MAC address - 4e:bb:60:96:fc:e1
> +  eth0: ethernet@4070000
> +  Hit any key to stop autoboot: 0
> +  milkv_duo_s#
> 

Looks good, I'm not sure about passing one specific dtb to OpenSBI build
because I am not familiar with why this is needed. If you want to add
more contextual information about what is S-Mode or M-mode and the order
of the software chain (which thing is loading some other target, and
again, and again) I don't think most users will care but it might be
clearer to do so for technical users.

-E
