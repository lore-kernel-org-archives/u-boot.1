Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6714DE7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 08:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B20C896B3;
	Wed,  4 Dec 2024 09:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="SPPgqQjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DFA8896B5; Wed,  4 Dec 2024 09:53:02 +0100 (CET)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41472896B2
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 09:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1733302340; x=1733907140; i=marcel@ziswiler.com;
 bh=B3BYW5l3ndXW2wJrbTFyhVkVVidNonp2b5Q09MBtvDY=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=SPPgqQjJ8pZdt8cHIA7hsFfvJG2sCzZNhYUNTqcBFG6bZF67lDdYAXRozQXIt7F/
 U93lJ92vT3UYZbmjbqKkSNa8fg3mEsBtip0bFrRc8RRA214AxpXLMZ63IDUnJHkVF
 dZ10oad/m5WcC2ew/GAcZuWvbPE5Jux88BJOuTNmd8l3ucdg27zJ9dNm0IrRbIsLj
 1V4iYfF1sFnovDpW2XGJ8BdPR0I2a9GqE+PslLLIaRRXog7DMguWoRTfZMUXFO6Wk
 kWV6ldkE0H4+3h1zbym5Wgnr7jywQ090SgC1eAt+bUWoYzKKaJnr+SseUc5ftrjoA
 sNs/qVWbMnH57q3nAg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.10.1.195] ([194.230.241.203]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N7AIq-1tiHEd3noq-0136Hd; 
 Wed, 04 Dec 2024 09:52:20 +0100
Message-ID: <cdf417bfba7bf57379d18eb114822195610ad99d.camel@ziswiler.com>
Subject: Re: [PATCH v4 2/2] doc: spacemit: bananapi_f3: document Banana Pi
 F3 board
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Huan Zhou <pericycle.cc@gmail.com>, u-boot@lists.denx.de, Ben Dooks	
 <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>, Dan Carpenter	
 <dan.carpenter@linaro.org>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt	 <xypron.glpk@gmx.de>, Jonas Schw?bel
 <jonasschwoebel@yahoo.de>, Kever Yang	 <kever.yang@rock-chips.com>, Leo
 <ycliang@andestech.com>, Michal Simek	 <michal.simek@amd.com>, Nishanth
 Menon <nm@ti.com>, Padmarao Begari	 <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,  Randolph
 <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Samuel Holland	
 <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin	
 <peterlin@andestech.com>, Kongyang Liu <seashell11234455@gmail.com>
Date: Wed, 04 Dec 2024 09:52:09 +0100
In-Reply-To: <20241204005808-GYA559515@gentoo>
References: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
 <20241129-pickup-bpif3-v4-2-e99fabf66e33@gmail.com>
 <ad100a4f673759559a6047083713d379847894cb.camel@ziswiler.com>
 <20241204005808-GYA559515@gentoo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:YAPCxZOOvXtAeIvPOP6AuQtWXGS5KLr4iPtQtVAshfTCEJUf/TI
 nY0sDbEG/vAg89tYrlhS7THVPwZ4Q+w+37LNKZ20SJr0SMUxgC0ZeqffB384ld9Q3C3dIuS
 Mbl3zvB24gKxkXE2oKWI3Gd6guuUjKU03+sKKsrnTTV/ehYe7za/GsYXxcJZT2flg15LAc9
 LYBso5llkd0UH4HwZ+QBg==
UI-OutboundReport: notjunk:1;M01:P0:ViHKn/HRVDs=;WwNk3iedYTxL31OWQttKMRd9K+4
 anreKPVaosX4CqKkxzXGTDkKq7sfxw4YJWtahMyhdTfhwmgYV3drbAi4pLysi886ZEZ4hrjoZ
 kvn0TMA0VN+potN8GOPWwA+G5gtQctINnEPi0RCr9nV0PpAiJzMxik5sCQ6vvnGjwwOZ3F3UT
 wSEGo21iLWS3USbV1+JEezXrlByVt7PKuAjGTOm+V/oXwHfajkT1ZITsPEnDDW3vCF2XG+tGA
 B0Rx6r38HF+dz7OwlhPfP3H8BWQ42lR2iOaGaYOllsqAWyv3dIRjodTqdrxY1A+zTe4BNS3+p
 KQMN8m8/odVPqQA97MzRM1c/EsuDalTlIdtl0M7FwjNJtKNrESCIS2UCPfdjmAkcMnsZiEPmU
 1r6tfZrr8Q2s0VZSU17xcqnVVS7t6IBfCuu1Q/BSVozcUQoW6O1q2c1r0plibpn2rPZJaVGBw
 3T//hP8dZ9eET5L0te9DkvvzwZl7ar3Tv2hyykc3UulmWjmtrYWRh5e1RIouyvz5QY9FZn8RV
 CFtyVNiWdP105T6acn07xS1tiuChj+2AyO+au89fV+NJv1UIa0/pc0bVGZ7vDzJ/FOMlctvzm
 +KBGI3hjalwFlmx5BELqwb8JZvoVdDST93Ht3XfvAth+ZB+GdghvzOfMJPmpBFXmhM+WJ2eWM
 UFVBA/ExwnPBnP5ImX9WDl+WxnFtgGJQi2vmlrNonVFXxHAcvRdRlDfXWGTGBqOyNdcaZ8Ov8
 hLiWk5YufdqpgbNkl4gGIPTPsmuYS4DVU2fcghL3SBA+vic4CxVwdYLC+WGhIEZRyv34up1q8
 A6Sq07n6SHRfc+hvXebMDmOW4u1pfaP062Vpe9Ps5qJQrwfM6Meb5n8UJ4XeRmaY00ruxrZRw
 A9qrEJZRo2muGHDWzAX4xiVpYeuSgJ4f8Th3X4PSHmkFAC5P8zJ/K0Q6Ley6EcCiw6sgFKL5m
 ICGrU01XMvg64os2Wo6cCoFvjxuybi2Lv968i5jiQz1iuJe+XqqZ1g+8Tt6Y1QyZKEUnqlwiK
 +mkCcFBuGPeSKv2yB67YOmzNxanm3k2MqTX2Aj5
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

Hi Yixun Lan

On Wed, 2024-12-04 at 08:58 +0800, Yixun Lan wrote:
> Hi Marcel, Huan
>=20
> On 18:52 Tue 03 Dec=C2=A0=C2=A0=C2=A0=C2=A0 , Marcel Ziswiler wrote:
> > Hi Huan Zhou=20
> >=20
> > On Fri, 2024-11-29 at 13:37 +0800, Huan Zhou wrote:
> > > From: Kongyang Liu <seashell11234455@gmail.com>
> > >=20
> > > Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
> > >=20
> > > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > > Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> > > ---
> > > =C2=A0doc/board/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > =C2=A0doc/board/spacemit/bananapi-f3.rst | 86 +++++++++++++++++++++++=
+++++++++++++++
> > > =C2=A0doc/board/spacemit/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 8 ++++
> > > =C2=A03 files changed, 95 insertions(+)
> > >=20
> > > diff --git a/doc/board/index.rst b/doc/board/index.rst
> > > index 417c128c7af6ad2267ef1bc743c7f10ae70b6de7..367da2d62316d4cab25ec=
c53f852ef742eba13dd 100644
> > > --- a/doc/board/index.rst
> > > +++ b/doc/board/index.rst
> > > @@ -51,6 +51,7 @@ Board-specific doc
> > > =C2=A0=C2=A0=C2=A0 sipeed/index
> > > =C2=A0=C2=A0=C2=A0 socionext/index
> > > =C2=A0=C2=A0=C2=A0 sophgo/index
> > > +=C2=A0=C2=A0 spacemit/index
> > > =C2=A0=C2=A0=C2=A0 st/index
> > > =C2=A0=C2=A0=C2=A0 starfive/index
> > > =C2=A0=C2=A0=C2=A0 ste/index
> > > diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/=
bananapi-f3.rst
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..1e6d6ef19be7e25684966=
bd4a727bd21b147330a
> > > --- /dev/null
> > > +++ b/doc/board/spacemit/bananapi-f3.rst
> > > @@ -0,0 +1,86 @@
> > > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > > +
> > > +Banana Pi F3
> >=20
> > Officially they call it Banana Pi BPI-F3.
> >=20
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Building
> > > +~~~~~~~~
> > > +1. Install the spacemit riscv cross compile toolchain_, or skip it i=
f riscv toolchain is installed.
> >=20
> > I would not use a specific such toolchain but rather a regular RISC-V o=
ne e.g.
> >=20
> > https://github.com/riscv-collab/riscv-gnu-toolchain
> >=20
>=20
> I think any riscv toolchain should work fine here, as I'm using Gentoo sp=
ecific riscv toolchain..
> so consider it's merely an example provided to demonstrate whole process =
working

Okay.

> > > +
> > > +.. _toolchain: https://archive.spacemit.com/toolchain/
> > > +
> > > +2. Setup cross compilation environment variable:
> > > +
> > > +.. code-block:: console
> > > +
> > > +=C2=A0=C2=A0 export CROSS_COMPILE=3D<riscv64 toolchain prefix, e.g /=
opt/spacemit/bin/riscv64-unknown-linux-gnu->
> > > +
> > > +3. Before building U-Boot, OpenSBI should be built first. OpenSBI ca=
n be
> > > +built for SpacemiT K1 SoC as below:
> > > +
> > > +.. code-block:: console
> > > +
> > > +=C2=A0=C2=A0 git clone https://github.com/cyyself/opensbi=C2=A0-b k1=
-opensbi
> > > +=C2=A0=C2=A0 cd opensbi
> > > +=C2=A0=C2=A0 make PLATFORM=3Dgeneric
> >=20
> > What speaks against using regular master opensbi?
> >=20
> no idea if master of opensbi would work here, we can certainly try..

I tried and it seems to work fine, resp. the only difference I could spot i=
s that instead of 'crc32+ OK' it
prints some random ASCII characters in the last line before any U-Boot outp=
ut:

[   0.490] ## Checking hash(es) for Image opensbi ... crc32+ OK

> but I think it's another story, as we are focusing on mainlining uboot

Yes, exactly. I am just curious if it needs combining with some obscure ven=
dor stuff.

> FWIK, this branch is generally same version as vendor opensbi, but slight=
ly
> =C2=A0rebase to more recent opensbi version
>=20
> > > +
> > > +4. Then build U-Boot as following:
> > > +
> > > +.. code-block:: console
> > > +
> > > +=C2=A0=C2=A0 cd <U-Boot-dir>
> > > +=C2=A0=C2=A0 make bananapi-f3_defconfig
> > > +=C2=A0=C2=A0 make OPENSBI=3D<OpenSBI-dir>/build/platform/generic/fir=
mware/fw_dynamic.bin
> > > +
> > > +This will generate u-boot.itb
> > > +
> > > +Booting
> > > +~~~~~~~
> > > +Actually, we can replace the uboot part from bianbu linux which is t=
he bsp_ to validate this patch,
> > > +use `balena etcher` to burn the bianbu-minimal.img to the sd card,=
=20
> >=20
> > trailing whitespace
> >=20
> > > +and replace the /dev/sdx4 where places the uboot_ with the `u-boot.i=
tb` generated from this patch.
> > > +
> > > +.. _bsp: https://archive.spacemit.com/image/k1/version/bianbu/v2.0/
> > > +.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmw=
are-layout
> > > +
> > > +Sample boot log from Banana Pi F3 board
> >=20
> > BPI-F3
> >=20
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +.. code-block:: none
> > > +
> > > +=C2=A0=C2=A0 try sd...
> > > +=C2=A0=C2=A0 bm:3
> > > +=C2=A0=C2=A0 j...
> > > +
> > > +=C2=A0=C2=A0 U-Boot SPL 2022.10spacemit-dirty (Oct 21 2024 - 09:01:1=
3 +0000)
> > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.279] DDR type LPDDR4X
> > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.292] lpddr4_silicon_init consume 13ms
> > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.293] Change DDR data rate to 2400MT/s
> > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.430] ## Checking hash(es) for config co=
nf-1 ... OK
> > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.432] ## Checking hash(es) for Image ope=
nsbi ... OK
> > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.437] ## Checking hash(es) for Image ubo=
ot ... OK
> > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.443] ## Checking hash(es) for Image fdt=
-1 ... OK
> > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.488] ## Checking hash(es) for config co=
nfig_1 ... OK
> > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.490] ## Checking hash(es) for Image ope=
nsbi ... crc32+ OK
> > > +
> > > +
> > > +=C2=A0=C2=A0 U-Boot 2024.10-rc4-00462-g5b138cfcc587-dirty (Nov 28 20=
24 - 14:56:49 +0800)
> > > +
> > > +=C2=A0=C2=A0 DRAM:=C2=A0 4 GiB
> >=20
> > I guess it does not yet detect the amount of RAM available.
> >=20
> I would be fine with this, as currently the memory size is hardcoded,
> we should work on follow-up patch to auto probe DDR size, and corret it

Yes, I agree.

> > > +=C2=A0=C2=A0 Core:=C2=A0 19 devices, 8 uclasses, devicetree: separat=
e
> > > +=C2=A0=C2=A0 Loading Environment from nowhere... OK
> > > +=C2=A0=C2=A0 In:=C2=A0=C2=A0=C2=A0 serial@d4017000
> > > +=C2=A0=C2=A0 Out:=C2=A0=C2=A0 serial@d4017000
> > > +=C2=A0=C2=A0 Err:=C2=A0=C2=A0 serial@d4017000
> > > +=C2=A0=C2=A0 Net:=C2=A0=C2=A0 No ethernet found.
> > > +=C2=A0=C2=A0 =3D> cpu list
> > > +=C2=A0=C2=A0 0: cpu@0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > +=C2=A0=C2=A0 1: cpu@1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > +=C2=A0=C2=A0 2: cpu@2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > +=C2=A0=C2=A0 3: cpu@3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > +=C2=A0=C2=A0 4: cpu@4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > +=C2=A0=C2=A0 5: cpu@5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > +=C2=A0=C2=A0 6: cpu@6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > +=C2=A0=C2=A0 7: cpu@7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > +=C2=A0=C2=A0 =3D> test
> > > +=C2=A0=C2=A0 =3D>=20
> >=20
> > trailing whitespace
> >=20
> > > +
> > > diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.=
rst
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..3fb7d804ac8fc8dd4c7ee=
67ffc877f9ad323162d
> > > --- /dev/null
> > > +++ b/doc/board/spacemit/index.rst
> > > @@ -0,0 +1,8 @@
> > > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > > +
> > > +SpacemiT
> > > +=3D=3D=3D=3D=3D=3D=3D=3D
> > > +.. toctree::
> > > +=C2=A0=C2=A0 :maxdepth: 1
> > > +
> > > +=C2=A0=C2=A0 bananapi-f3
> > >=20
> >=20
> > new blank line at EOF

Thanks!

Cheers

Marcel
>=20
