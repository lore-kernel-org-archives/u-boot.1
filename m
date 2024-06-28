Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FA6C3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 04:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5789D881C1;
	Fri, 28 Jun 2024 06:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="p01HI54e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 760F48857C; Fri, 28 Jun 2024 06:31:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E161C8803E
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 06:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719549070; x=1720153870; i=xypron.glpk@gmx.de;
 bh=4wLdl+84a3xtDm8CjlWfh7ElgQEXd+xhYIOrV8DbrDs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=p01HI54egoEJtpBkGTmXdScNlkSpTD7lbE+6xeZkIjoG3ggNTFjibABQCyj1LRPq
 HdyItm51kdsXfVrA90dD9xksPACVRQ9LAPDWNr8Lvfef8GKQX+Tzn90JdZyE2jy2f
 6kIwx9UzG/HxXE85BRGx5DTziHoO1mnhbYJQPKIXOZ0uBWevxlzQ72YPFwfXqdpKu
 tk0MA1+qol2ydlK6F0V4rqxxnxUYwkFiOgzJ1GAW7cs1lmifrG6Sjt7UGE/ZE9D+z
 MdZ+9+AkRySpS4Kb49v4cv8wmzuYpHCmumOIlqcxd1Mct4/UdBEVnAr1wXUObZSEU
 zAfHPQa9brgh/qlg+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.37] ([213.179.142.81]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1sKqL00WZE-0012vk; Fri, 28
 Jun 2024 06:31:10 +0200
Message-ID: <0f171888-d80a-429e-ae56-377dd42425a8@gmx.de>
Date: Fri, 28 Jun 2024 06:30:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] doc: develop: Add a general section on gdb usage
To: Alexander Dahl <ada@thorsis.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20240626104718.74965-1-ada@thorsis.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240626104718.74965-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rKZgNxhDV47ugwksUxbkigYP9vm5fh0ArGK9OrwtygIzFMwI9Ou
 froc/Mpz8ZPIiPq/6tqaIPjlA8f0F+jvBO2lJCsoek3W7J8IS4wFMR2E9ullVc3KqHqLPjJ
 02WkBgblODYAtoI+gvUaPhNgWCHCvsWi/aZ0bqyasII+O7163X01otS5bkOhoD0vfVaV1Qk
 Fx996QhD53k0ITZeuSMQA==
UI-OutboundReport: notjunk:1;M01:P0:Eq1WfzKaPos=;XnGvggirh0lnPsVgewKn1lDYD01
 BCZQxbxYFmCCimaH+Wj4EukEr21K0+VEsKxj6IPe/zRKQU/l048nBtUe9w5AO3VChXYKuRRbm
 eeeB/6ZBE8DKRbb7yM5mzYHUj3EgSSDFZPtndPIiFFeO/6TuQVo0gxh/pd4krKmdtnI1iw++n
 EVOP49fKQyyz49PqR3YkrWlIkSITap+2Mgiz0GjXNrIgJWQ8f7I2sQ2YtTn9U0yBuHeM00wXR
 RUJxBHEOM07HG921eBmxzwwQkwHGHxWFeh0tK99ws6oUTAZQ8FyQXcylaTo8M36NKCvUbXel0
 R6MAPjcEdgjlBSx5AAFuuDhCOQyWk0Q5E3DTagy0xNuSE4B4mD/GH7tNd766NTMNs1BM8fu5C
 mkGz81BQqxOEcLfkKMtg5o1G4KHybvOZDT+x6GKRBUNMN3hZuIjN2GnzlgCdp6StB/Dbw7qoQ
 4PglVJ7oYt2X4xWzLrv3E9ErQmoe+39iSfk3kZyRzHr5n3Yie7EyXunREto/qsx6d6+q8pd3i
 osrsRjHDy4QCbVi5sSjbS1IHcJ6FX8/HGG+jBKd1GVH9Yk/oCVUg9utWFnvJAV6UOtJeaDAUD
 J8u30qB03x5Urw+wo5WXt3Pez7icYYihMYa4NnKNyqDG1a78b8q7JxR7Go7IaMuZz1+6lcNrU
 Nca3DTJ0753NzW3564u4L0laZCJO8dMDdUwcgjTzR4fyoB5CBLjqatXvAVrm/tnP0kRQo82D8
 AJi2Ohr6B1KhkTlJ309YLBxtvn+sh8AOd8rAVnmNxb4aKWpKVymAuxtItVLImZv+CrwGLd6M/
 Qw7hgKoIgGn3QvlPBbDpD7m2TgZ2A8Rnbrb3Xl2N1t4bk=
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

On 6/26/24 12:47, Alexander Dahl wrote:
> Mashed up from different sources linked below, including the now gone
> Wiki and doc/README.arm-relocation file.  Tested on a custom board with
> AT91 SAMA5D2 SoC and Segger J-Link Base adapter.  This is only generic
> advice here, the usage is not board specific.  Some board docs have more
> specific instructions on using gdb with a particular board.
>
> Link: https://www.slideshare.net/slideshow/embedded-recipes-2019-introdu=
ction-to-jtag-debugging/177511981
> Link: https://boundarydevices.com/debugging-using-segger-j-link-jtag/
> Link: https://web.archive.org/web/20141224200032/http://www.denx.de/wiki=
/view/DULG/DebuggingUBoot
> Link: https://web.archive.org/web/20141206064148/http://www.denx.de/wiki=
/view/DULG/GDBScripts1
> Suggested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>   doc/develop/gdb.rst   | 154 ++++++++++++++++++++++++++++++++++++++++++
>   doc/develop/index.rst |   1 +
>   2 files changed, 155 insertions(+)
>   create mode 100644 doc/develop/gdb.rst
>
> diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
> new file mode 100644
> index 00000000000..18d97857ce1
> --- /dev/null
> +++ b/doc/develop/gdb.rst
> @@ -0,0 +1,154 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright (c) 2024 Alexander Dahl
> +
> +Debugging U-Boot with gdb
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Using a JTAG adapter it is possible to debug a running U-Boot with gdb.
> +A common way is to connect a debug adapter to the JTAG connector of you=
r
> +board, run gdbserver, connect gdb to gdbserver, and use gdb as usual.
> +
> +Preparing build
> +---------------
> +
> +Building U-Boot with debug symbols and without optimizations is
> +recommended for easier debugging::
> +
> +    CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy
> +
> +Otherwise build, install, and run U-Boot as usual.
> +
> +Using OpenOCD as GDB server
> +---------------------------
> +
> +[OpenOCD]_ is a FOSS tool supporting hardware debug probes, and
> +providing a GDB interface.
> +It is readily available in major Linux distributions or you can build i=
t
> +from source.
> +Example for starting OpenOCD from Debian with a J-Link adapter and a
> +board using an AT91 SAMA5D2 SoC:
> +
> +.. code-block:: console
> +
> +    % openocd -f interface/jlink.cfg -f target/at91sama5d2.cfg -c 'adap=
ter speed 4000'
> +    Open On-Chip Debugger 0.12.0
> +    Licensed under GNU GPL v2
> +    For bug reports, read
> +            http://openocd.org/doc/doxygen/bugs.html
> +    Info : auto-selecting first available session transport "jtag". To =
override use 'transport select <transport>'.
> +    adapter speed: 4000 kHz
> +
> +    Info : Listening on port 6666 for tcl connections
> +    Info : Listening on port 4444 for telnet connections
> +    Info : J-Link V10 compiled Jan 30 2023 11:28:07
> +    Info : Hardware version: 10.10
> +    Info : VTarget =3D 3.244 V
> +    Info : clock speed 4000 kHz
> +    Info : JTAG tap: at91sama5d2.cpu tap/device found: 0x5ba00477 (mfg:=
 0x23b (ARM Ltd), part: 0xba00, ver: 0x5)
> +    Info : at91sama5d2.cpu_a5.0: hardware has 3 breakpoints, 2 watchpoi=
nts
> +    Info : at91sama5d2.cpu_a5.0: MPIDR level2 0, cluster 0, core 0, mon=
o core, no SMT
> +    Info : starting gdb server for at91sama5d2.cpu_a5.0 on 3333
> +    Info : Listening on port 3333 for gdb connections
> +
> +Notice the port 3333 the OpenOCD server is listening on for gdb
> +connections.
> +
> +Running a gdb session
> +----------------------
> +
> +You need a gdb suited for your target.
> +This can be gdb coming with your toolchain or *gdb-multiarch* available
> +in your Linux distribution.
> +
> +.. code-block:: console
> +
> +    % gdb-multiarch u-boot
> +    GNU gdb (Debian 13.1-3) 13.1
> +    Copyright (C) 2023 Free Software Foundation, Inc.
> +    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses=
/gpl.html>
> +    This is free software: you are free to change and redistribute it.
> +    There is NO WARRANTY, to the extent permitted by law.
> +    Type "show copying" and "show warranty" for details.
> +    This GDB was configured as "x86_64-linux-gnu".
> +    Type "show configuration" for configuration details.
> +    For bug reporting instructions, please see:
> +    <https://www.gnu.org/software/gdb/bugs/>.
> +    Find the GDB manual and other documentation resources online at:
> +        <http://www.gnu.org/software/gdb/documentation/>.
> +
> +    For help, type "help".
> +    Type "apropos word" to search for commands related to "word"...
> +    Reading symbols from u-boot...
> +    (gdb)
> +
> +Notice in the above command-line *u-boot* is the binary file from your
> +build folder, for which you might need to adapt the path when calling
> +gdb.
> +
> +Connect to the gdb server then:

Thank you for this helpful document.

Please add:

.. code-block:: bash

     gdb-multiarch u-boot -ex 'target remote localhost:3333'

Please, mention that the same debug port can be exposed on QEMU with
parameter '-gdb tcp::3333', e.g.

     qemu-system-riscv64 -M virt -nographic -gdb tcp::3333 -kernel u-boot

> +
> +.. code-block:: console
> +
> +    (gdb) target extended-remote :3333
> +    Remote debugging using :3333
> +    0x27fa9ac6 in ?? ()
> +    (gdb)
> +
> +This is fine for running before U-Boot relocates itself.
> +For debugging U-Boot after relocation you need to tell gdb.
> +You can get the relocation address from U-Boot shell with the command
> +*bdinfo* like this:
Please, consider that often users want to debug drivers after relocation
but before reaching the command line.

On most architectures (not sandbox, x86) gd is stored in a fixed
register. See arch/*/include/asm/global_data.h.

arc: r25
arm: r9
arm64: x18
m68k: d7
microblaze: r31
mips: k0
nios2: gp
powerpc: r2
riscv: gp
sh: r13

You can use (on RISC-V)

.. code-block:: console

     (gdb) p/x (*(struct global_data*)$gp)->relocaddr
     $1 =3D 0x8771e000

to show the relocation address.

Best regards

Heinrich

> +
> +.. code-block:: console
> +
> +    U-Boot> bdinfo
> +    boot_params =3D 0x20000100
> +    DRAM bank   =3D 0x00000000
> +    -> start    =3D 0x20000000
> +    -> size     =3D 0x08000000
> +    flashstart  =3D 0x00000000
> +    flashsize   =3D 0x00000000
> +    flashoffset =3D 0x00000000
> +    baudrate    =3D 115200 bps
> +    relocaddr   =3D 0x27f7a000
> +    reloc off   =3D 0x0607a000
> +    Build       =3D 32-bit
> +    current eth =3D ethernet@f8008000
> +    ethaddr     =3D 00:50:c2:31:58:d4
> +    IP addr     =3D <NULL>
> +    fdt_blob    =3D 0x27b36060
> +    new_fdt     =3D 0x27b36060
> +    fdt_size    =3D 0x00003e40
> +    lmb_dump_all:
> +     memory.cnt =3D 0x1 / max =3D 0x10
> +     memory[0]      [0x20000000-0x27ffffff], 0x08000000 bytes flags: 0
> +     reserved.cnt =3D 0x1 / max =3D 0x10
> +     reserved[0]    [0x27b31d00-0x27ffffff], 0x004ce300 bytes flags: 0
> +    devicetree  =3D separate
> +    arch_number =3D 0x00000000
> +    TLB addr    =3D 0x27ff0000
> +    irq_sp      =3D 0x27b36050
> +    sp start    =3D 0x27b36040
> +    Early malloc usage: cd8 / 2000
> +
> +Look out for the line starting with *relocaddr* which has the address
> +you need, ``0x27f7a000`` in this case.
> +In gdb shell discard the previously loaded symbol file and add it once
> +again with that relocation address like this:
> +
> +.. code-block:: console
> +
> +    (gdb) symbol-file
> +    Discard symbol table from `/home/adahl/build/u-boot/v2024.04.x/u-bo=
ot'? (y or n) y
> +    No symbol file now.
> +    (gdb) add-symbol-file u-boot 0x27f7a000
> +    add symbol table from file "u-boot" at
> +            .text_addr =3D 0x27f7a000
> +    (y or n) y
> +    Reading symbols from u-boot...
> +    (gdb)
> +
> +You can now use gdb as usual, setting breakpoints, printing backtraces,
> +inspecting variables, stepping through the code, etc.
> +
> +.. [OpenOCD] https://openocd.org/
> diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> index f82e148b101..f9c4bf839ee 100644
> --- a/doc/develop/index.rst
> +++ b/doc/develop/index.rst
> @@ -60,6 +60,7 @@ Debugging
>      :maxdepth: 1
>
>      crash_dumps
> +   gdb
>      trace
>
>   Packaging
>
> base-commit: a7eada24327a40f7ef6c55c220e119839c9d4227

