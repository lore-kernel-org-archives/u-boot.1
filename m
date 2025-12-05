Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20F7D2F7E4
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 11:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8D5584062;
	Fri,  5 Dec 2025 12:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linenoise.info
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linenoise.info header.i=@linenoise.info header.b="fPbyOZZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F81841BC; Fri,  5 Dec 2025 12:42:59 +0100 (CET)
Received: from ibeerc.linenoise.info (ibeerc.linenoise.info [130.61.186.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8252E8388D
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 12:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linenoise.info
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alvaro@linenoise.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linenoise.info;
 s=ibeerc; t=1764934974;
 bh=w/DCTjFNraNoHt0llphFHYal0lUe1wptNeWU3KaC45U=;
 h=Subject:From:To:Date:In-Reply-To:References:From;
 b=fPbyOZZu/7H25kczGrq4gGgONJN1guABo9oxpayO822eAkDyzQVVOLct4HhQrEfFA
 IYVegfw2NiCV7fmS/xXAAagxcZ66X51W2+e2JETteshZQkWgCX3h+VWXOpPMWLWfoK
 l0X8tAhWmxWICqgS1ssNdMijx3ftNIpNtUT68DZ2w63+LyGkCt3oSMsoQc2Dm5S79X
 lInAIPXCn2Q8AezyuNfiLswrz8JSiMSfJwmHbB5nMorz7mQV1X0eayts34xfzC3SUY
 EyuTjOaw6UiFGseEf4G5cx5P+5V0aYGM8U/HJzXtcClapn2ASqF/XW/1yLVFlxMhnb
 ve+mFF39Fm97A==
Received: from [192.168.2.3] (unknown [109.227.150.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ibeerc.linenoise.info (Postfix) with ESMTPSA id F05B720021;
 Fri, 05 Dec 2025 12:42:53 +0100 (CET)
Message-ID: <50dbfd8c45dcd891d444470d6ffe4f0bee07d3c4.camel@linenoise.info>
Subject: Re: How to boot u-boot from embedded ELF file in Microblaze core
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro@linenoise.info>
To: Michal Simek <monstr@monstr.eu>, U-Boot Mailing List <u-boot@lists.denx.de>
Date: Fri, 05 Dec 2025 12:42:53 +0100
In-Reply-To: <a0a0f3cd-2e13-416a-915d-12586b5556ee@monstr.eu>
References: <34fcf068f421f6d95d41271ef52400d7464d080e.camel@linenoise.info>
 <139d4052ed5e16f7de90ad681d032282f0bc74ad.camel@linenoise.info>
 <52b477fa-6d3f-486e-ab77-9b2d682973df@monstr.eu>
 <5e9c5be65bf1d40e749ae0e88e69ca786681865b.camel@linenoise.info>
 <a0a0f3cd-2e13-416a-915d-12586b5556ee@monstr.eu>
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

On Tue, 2025-12-02 at 14:35 +0100, Michal Simek wrote:
>=20
> On 12/2/25 12:07, =C3=81lvaro G. M. wrote:
> > Hi
> >=20
> > On Fri, 2025-11-28 at 08:23 +0100, Michal Simek wrote:
> > > >=20
> > > > I still haven't been able to solve this. Why is this value invalid?=
 And which
> > > > value should I put there to embed u-boot.elf into the microblaze bo=
ot memory?
> > >=20
> > > Because you need early stack pointer which is allocated in front of u=
-boot
> > > itself at start. It means you need at least small space there.
> > > U-Boot is going to be relocated to the end of memory anyway that's wh=
y it
> > > shouldn't really matter that TEXT base is not aligned with DDR start.
> >=20
> > Right, so if I were to run this from embedded BRAM, should I set
> > CONFIG_TEXT_BASE to something slightly above 0 as well?
> >=20
>=20
> How big is your bram?
>=20
> Obviously never thought to have full u-boot in bram because bram sizes we=
re=20
> small that's why never really wanted to allocated bram just for bootloade=
r itself.
> Another thing is that normally MB has reset address at 0 where reset vect=
ors are.
> And full u-boot is also setting up these vectors that's why you even don'=
t want=20
> to have full u-boot to start from 0 but from any offset to have location =
for=20
> reset vectors.

Yeah, I see. My current BRAM is 65536 and I wouldn't want to increase it. I=
n
fact, once I leave the embedded bootloader and run u-boot or linux, does th=
is
bram even get used? Because I was thinking of making it even smaller.

So I should try to use SPL and have this load full u-boot, or maybe go the
falcon mode, right?



> >=20
> > I'm facing however other problems related with this flash, as it seems =
that
> > Linux is unable to write to it. But also, Vivado 2025.1 isn't quite cap=
able of
> > writing to my old mt25ql128, which I was able to do so with Vivado vers=
ions 2016
> > through 2018 (I just posted about this on AMD/Vivado forums), so we are
> > considering undoing this MTD change because it was intended as future-p=
roofing
> > for bigger software designs, but it seem like it isn't worth the effort=
 for us
> > right now.
>=20
> I haven't really spent my time on SPI to help you on this. But you are us=
ing axi=20
> spi/qspi which shouldn't be that problematic. Lowering frequency or mode=
=20
> limitation can solve the problem.

I don't know exactly what's going on, and due to timing constraints (of min=
e,
not of the FPGA), we've decided to go back to the old 128Mbit flash, so eve=
n
though I'm gonna try to have the SPL working, we won't be using the new big=
ger
flash, so I won't be spending any more time on diagnosing this. I'm a bit
frustrated because I had it working once, but I haven't been able to replic=
ate
the conditions under which it worked, it was just one of a dozen of tests a=
nd I
wasn't disciplined enough to document and save each test separately, so, th=
at's
my penance.

Thanks!
