Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C89CFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 11:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1846083015;
	Tue,  2 Dec 2025 12:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linenoise.info
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linenoise.info header.i=@linenoise.info header.b="g/LodLaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 181E983AB8; Tue,  2 Dec 2025 12:07:11 +0100 (CET)
Received: from ibeerc.linenoise.info (ibeerc.linenoise.info [130.61.186.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BE0800AD
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 12:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linenoise.info
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alvaro@linenoise.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linenoise.info;
 s=ibeerc; t=1764673624;
 bh=s5N2gSSu9ko6dcRB0DX8NzZUQllgL+iLhpl+kSHJ6KI=;
 h=Subject:From:To:Date:In-Reply-To:References:From;
 b=g/LodLaFgx4DrfUP6YMZ+eU8X0qDgoH4pmh+v5G43LottesKmpiXTigNNvWhrLgtC
 NlNQDWk7deOYGwwd8mw8RihNBYLGUrBebHI6CIDMNPnQvUdb12iEQExPzFYvoxswjP
 RaplFQeJwdj8FQFIfZpwnZuMB72xPu+yAfEUW42HuMCX9XJzkx1DbIoV8Ke1D2mZNp
 5yYPIzLmLm9DQGHdhpC9isv3GqgkUXUvh8VaPgBbZ3F9OXI/ninL7WCiuFhdVEOQWI
 tSGsu2XUkxIUwFwPpBSn2al5aFxT0giDjB/so8iDDwYSM9c4LGCA4iK8xuhmgC+fVR
 M8KeLlx/GK/RA==
Received: from [192.168.2.3] (unknown [109.227.150.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ibeerc.linenoise.info (Postfix) with ESMTPSA id D737D2009C;
 Tue, 02 Dec 2025 12:07:04 +0100 (CET)
Message-ID: <5e9c5be65bf1d40e749ae0e88e69ca786681865b.camel@linenoise.info>
Subject: Re: How to boot u-boot from embedded ELF file in Microblaze core
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro@linenoise.info>
To: Michal Simek <monstr@monstr.eu>, U-Boot Mailing List <u-boot@lists.denx.de>
Date: Tue, 02 Dec 2025 12:07:04 +0100
In-Reply-To: <52b477fa-6d3f-486e-ab77-9b2d682973df@monstr.eu>
References: <34fcf068f421f6d95d41271ef52400d7464d080e.camel@linenoise.info>
 <139d4052ed5e16f7de90ad681d032282f0bc74ad.camel@linenoise.info>
 <52b477fa-6d3f-486e-ab77-9b2d682973df@monstr.eu>
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

Hi

On Fri, 2025-11-28 at 08:23 +0100, Michal Simek wrote:
> >=20
> > I still haven't been able to solve this. Why is this value invalid? And=
 which
> > value should I put there to embed u-boot.elf into the microblaze boot m=
emory?
>=20
> Because you need early stack pointer which is allocated in front of u-boo=
t=20
> itself at start. It means you need at least small space there.
> U-Boot is going to be relocated to the end of memory anyway that's why it=
=20
> shouldn't really matter that TEXT base is not aligned with DDR start.

Right, so if I were to run this from embedded BRAM, should I set
CONFIG_TEXT_BASE to something slightly above 0 as well?


> This is recreated file from binary. The best is to run make V=3D1 u-boot.=
elf
>=20
> Then you will see
>    microblazeel-xilinx-linux-gnu-objcopy --gap-fill=3D0xff  -O binary   u=
-boot=20
> u-boot-nodtb.bin && {  echo '  tools/relocate-rela  '; tools/relocate-rel=
a=20
> u-boot-nodtb.bin u-boot; } || { rm -f u-boot-nodtb.bin; false; }
>    tools/relocate-rela
>    cp u-boot-nodtb.bin u-boot.bin
> microblazeel-xilinx-linux-gnu-objcopy -I binary -B microblaze  -O=20
> elf32-microblaze u-boot.bin u-boot-elf.o
>    microblazeel-xilinx-linux-gnu-ld u-boot-elf.o -o u-boot.elf -EB -T=20
> u-boot-elf.lds --defsym=3D"_start"=3D0x29000000 -Ttext=3D0x29000000
>=20
> Which is showing you what files are used.
>=20
> For you the best option is to use CONFIG_OF_EMBED=3Dy which includes DTB =
directly=20
> in binary that you don't need to deal with it.

That's what I did, but as I understand from those lines above, original bin=
ary
does not include the DTS, right? That's why I get the fdtdec_setup() failed
message.


> Regarding sizes and location. I didn't try to put u-boot to BRAM but I ca=
n't see=20
> any reason why you can't do it.
> Overall binary size is all the time question what exactly you want to do =
with it.
> SPL is another option but I didn't try it for a while but should be enabl=
ed.

Yeah, it looks like the u-boot.elf code region is bigger than my current
bootloader (one based on the s-rec example), so it seems like it won't fit =
on my
design. I will try SPL, which I'm sure will open a different can of worms  =
:)

> Keep in your mind that full relocation is enabled that's why you u-boot i=
tself=20
> is finding out where it runs and then update sections. Based on your load=
ing=20
> address you can in xsdb remap symbols to see them by:
>=20
> memmap -file u-boot -reloc $reloc_addr
>=20
> Keep in mind that Microblaze is pretty much EOL and for new designs you s=
hould=20
> focus on Microblaze V(risc-v compatible version).
>=20

Yes, thank you. I'm trying to upgrade an old design from 2016 because we've=
 just
built a new version of the board with a new mtd (mt25ql02g replacing mt25ql=
128),
but it seems like Linux leaves the MTD configured in a mode our current
bootloader (the s-record based one) isn't able to work with, so resetting t=
he
board leaves it unable to reload Linux kernel from flash. u-boot however is=
 able
to sf read data from the flash regardless of the status Linux left it with,=
 so
that's why I wanted to port u-boot to this semi-old design.

I'm facing however other problems related with this flash, as it seems that
Linux is unable to write to it. But also, Vivado 2025.1 isn't quite capable=
 of
writing to my old mt25ql128, which I was able to do so with Vivado versions=
 2016
through 2018 (I just posted about this on AMD/Vivado forums), so we are
considering undoing this MTD change because it was intended as future-proof=
ing
for bigger software designs, but it seem like it isn't worth the effort for=
 us
right now.

Sorry about the non u-boot rambling!

Thanks!
