Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52300CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 06:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A0DF83B9B;
	Fri, 28 Nov 2025 07:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linenoise.info
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linenoise.info header.i=@linenoise.info header.b="Loei2rK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41E70842BF; Fri, 28 Nov 2025 07:42:34 +0100 (CET)
Received: from ibeerc.linenoise.info (ibeerc.linenoise.info [130.61.186.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEADF83B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 07:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linenoise.info
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alvaro@linenoise.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linenoise.info;
 s=ibeerc; t=1764312147;
 bh=NQgpBrwz13vfsBE+5HlrNcwPeQ3hDJ63XzUerUgcN2Q=;
 h=Subject:From:To:Date:In-Reply-To:References:From;
 b=Loei2rK8NUbzKWmReNfWY3JdJjwv5eWNpMR6t0x5gqu851nBfCcl+tMtvyywe1gLH
 kDTAeYyQjsuAOdpy0Sh8PgNaOOM4N+4WsOgwvMn4bd5h0k+WJ+yKX8Ee52UYFwnz3i
 zouyQ2lilbD2I5CQjtZSpbqIUf/N2m28PH2KJDV8CW6LzllZAEgBd9f4fGy/KHq39E
 nJUwWqxe9Sbiu7MFpaZDAft54YIjY+o1sgY4H4HP3otb+6vlqaLhv9vJpZbeAAgokL
 WZFTYNvkpO8FlN/88utcTh29HOhnlYqDgN2KfjXbMjUjmVkvQKz/msV4qRcgedal/V
 nOPYvctk5kQYw==
Received: from [192.168.2.3] (unknown [109.227.150.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ibeerc.linenoise.info (Postfix) with ESMTPSA id 9C86E2023B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 07:42:27 +0100 (CET)
Message-ID: <139d4052ed5e16f7de90ad681d032282f0bc74ad.camel@linenoise.info>
Subject: Re: How to boot u-boot from embedded ELF file in Microblaze core
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro@linenoise.info>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Date: Fri, 28 Nov 2025 07:42:27 +0100
In-Reply-To: <34fcf068f421f6d95d41271ef52400d7464d080e.camel@linenoise.info>
References: <34fcf068f421f6d95d41271ef52400d7464d080e.camel@linenoise.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-7 
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

Hi all,

I've been working a bit on this and now I have more doubts than before...

On Fri, 2025-11-14 at 11:30 +0100, =C3=81lvaro G. M. wrote:
>=20
> [...]
> I can load this via xsdb and u-boot works and is capable of booting Linux
> kernel. However, there are a couple of things I don't understand.
>=20
> First off, if I set CONFIG_TEXT_BASE=3D0x80000000 (the exact beginning of=
 RAM), it
> won't boot, not even early debug message will appear. Why is that?
>=20

I still haven't been able to solve this. Why is this value invalid? And whi=
ch
value should I put there to embed u-boot.elf into the microblaze boot memor=
y?

> And the second thing, my endgame is to embed u-boot.elf into Microblaze i=
tself,
> so it acts as FSBL. I reduced the size to the maximum and I got a quite s=
mall
> binary, even smaller than my current bootloader (the one from Xilinx that=
 loads
> an SREC image from flash), so there shouldn't be any issue from that part=
. To do
> this, I set CONFIG_TEXT_BASE=3D0x0, but again, no early boot debug messag=
e
> appears.
>=20
> I've tried different values for CONFIG_TEXT_BASE in this case, but none o=
f them
> will work. Also, in either case, I'm not sure why, but I can't debug step=
 by
> step via xsdb, I won't see what ASM or C code matches with current PC add=
ress.
> However, SPL will let me run it step by step via xsdb.
>=20

I've discovered that I can launch u-boot file with xsdb and debug step by s=
tep
via xsdb. But this file won't boot up properly, because somehow it seems to=
 be
missing the DT? But the file is bigger than u-boot.elf. If I load u-boot.el=
f, I
get uboot console and am able to use sf probe and sf read to launch the ker=
nel.
But this file is smaller and I can't debug it step by step. So I don't real=
ly
understand anything.

$ ls -al u-boot{,.elf}
-rwxr-xr-x 1 sslayer sslayer 1882032 Nov 27 10:06 u-boot
-rwxr-xr-x 1 sslayer sslayer  215224 Nov 27 10:06 u-boot.elf

$ file u-boot{,.elf}
u-boot:     ELF 32-bit LSB executable, Xilinx MicroBlaze 32-bit RISC, versi=
on 1
(SYSV), static-pie linked, with debug_info, not stripped
u-boot.elf: ELF 32-bit LSB executable, Xilinx MicroBlaze 32-bit RISC, versi=
on 1
(SYSV), statically linked, not stripped


So, loading u-boot
xsdb% rst; dow u-boot ; con
Downloading Program -- uboot-2025.10/u-boot
	section, .text: 0x80100000 - 0x80122e7f
	section, .plt: 0x80122e80 - 0x80122e7f
	section, .rodata: 0x80122e80 - 0x801286c7
	section, .dynstr: 0x801286c8 - 0x8012891a
	section, .hash: 0x8012891c - 0x80128aaf
	section, .gnu.hash: 0x80128ab0 - 0x80128c6f
	section, .dtb.init.rodata: 0x80128c70 - 0x8012c9ef
	section, .data: 0x8012c9f0 - 0x8012e5bb
	section, .dynamic: 0x8012e5bc - 0x8012e653
	section, .got: 0x8012e654 - 0x8012f04f
	section, __u_boot_list: 0x8012f050 - 0x8012f737
	section, .dynsym: 0x80133344 - 0x80133723
	section, .bss: 0x80133724 - 0x8013675f
	section, .dynbss: 0x80136760 - 0x8013675f
	section, .rela.dyn: 0x8012f738 - 0x80133343
100%    0MB   0.2MB/s  00:01   =20
Setting PC to Program Start Address 0x80100000

Gets me this on the console:
<debug_uart>
No valid device tree binary found at 00000000
initcall_run_f(): initcall fdtdec_setup() failed
### ERROR ### Please RESET the board ###


But loading u-boot.elf; con
Downloading Program -- uboot-2025.10/u-boot.elf
	section, .data: 0x80100000 - 0x80133723
100%    0MB   0.2MB/s  00:01   =20
Setting PC to Program Start Address 0x80100000
Successfully downloaded /home/sslayer/Proyectos/ART/ESA/build/DRVM-software=
-
upgrade-buildroot/DRVM/output/build/uboot-2025.10/u-boot.elf
Info: MicroBlaze #0 (target 3) Stopped at 0x80100004 (Step)

Gets me this:

<debug_uart>


U-Boot 2025.10 (Nov 27 2025 - 10:06:43 +0100)

Model: Xilinx MicroBlaze
DRAM:  248 MiB
Core:  7 devices, 6 uclasses, devicetree: embed
Flash: ## Unknown flash on Bank 1 - Size =3D 0x00000000 =3D 0 MB
0 Bytes
Loading Environment from <NULL>... OK
In:    serial
Out:   serial
Err:   serial
Model: Xilinx MicroBlaze
Unknown command 'echo' - try 'help'
Unknown command 'echo' - try 'help'
U-Boot-mONStR>=20

Any pointers I could get on these would be greatly appreciated

Thanks,
