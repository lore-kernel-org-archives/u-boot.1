Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3E1E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 08:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B4F801F5;
	Wed, 11 Dec 2024 09:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="2GKxyW2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 922F080200; Wed, 11 Dec 2024 09:35:59 +0100 (CET)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979C3801CE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 09:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1733906122; x=1734510922; i=marcel@ziswiler.com;
 bh=j4RcTbX8t1G6ACyo9die8TKTpX8DcXh30kL9F/abvj4=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=2GKxyW2GgMvakLOqWjJ9AwzAbCFJt91pVZTbN6Ni/Btf8mEN4Fbe8ysGTcbPwRLA
 PvzkIo8099ssHN4JIOj8eHe19g905Rg3leMWmpnYa9zgzvpx9fSvQh7U99BL0tQTp
 afKB8m0lMKlxjs6l0/Nll391NhxptmIEzFzxc9VrLkVR6FmDbhyzS8NHuK57JYshN
 sLb8C5tadMjHD+3F/ZuH6gNuGLEhjEJze+oxhbHBxQpGifBoobza3VLrl9glMW4kJ
 ySzhecaqvYrhVO8Dhh1isVDn75VvWpww99NuP9Vb2n/BI330bJo8TJ3Ity2yohJ8Z
 4Qef96ROnfwOE6ZAFQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.10.1.166] ([194.230.241.203]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Levc1-1tyEv049Nf-00mFjI; 
 Wed, 11 Dec 2024 09:35:22 +0100
Message-ID: <b7b51f70e6271ea38fe2257b8424c41bb3e6114e.camel@ziswiler.com>
Subject: Re: [PATCH v4 2/2] doc: spacemit: bananapi_f3: document Banana Pi
 F3 board
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Huan Zhou <pericycle.cc@gmail.com>
Cc: Yixun Lan <dlan@gentoo.org>, u-boot@lists.denx.de, Ben Dooks	
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
Date: Wed, 11 Dec 2024 09:35:12 +0100
In-Reply-To: <20241208065157.wd7jr4ltjtvbytld@per1cycle.per1cycle>
References: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
 <20241129-pickup-bpif3-v4-2-e99fabf66e33@gmail.com>
 <ad100a4f673759559a6047083713d379847894cb.camel@ziswiler.com>
 <20241204005808-GYA559515@gentoo>
 <cdf417bfba7bf57379d18eb114822195610ad99d.camel@ziswiler.com>
 <20241208065157.wd7jr4ltjtvbytld@per1cycle.per1cycle>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:qmX6uOWaQkKKDxSZT7KLMyhXBmTToTnEFodB+BVeJFHENoTGsd+
 lvNcKf5OsVNxwVr5am/Xarf1r1i9a1Ptd2Fad8Yjv9kOvPlORJ+EOp7qFq8Ba2CTtKMkzCp
 x+519kkmy9U56VXAOPvnKs/0/IVksXQoAFMAVdoVj0yyRiMAJ03kGU7nG7+pG+TkQhgc80d
 mhJ/tHChxnlFmx6aJ68tw==
UI-OutboundReport: notjunk:1;M01:P0:2lV7R+C61VY=;oIFfqztG8+x2guDdNc3C6Xt1t8/
 5PQAZPrQSvoTK7UFS8uiZsZJZ2pQbaIzShQkhv0KZWXMrfih3Pl1oe7hlPmOLYwekk8Av7gHa
 6bjJJ4MW1vUdBpr+w9kR6QU7aNdnxnK4/Qh07AZd0e2vVdqoNbS9rye0QlfMRAmMSv7gFACIz
 XOo+b2UX3R4qdi7A53HwQMWOSktzq9us1VrDEfl3s1EHKylsKnDMziw579wwv1YOec3Wx1uVb
 6veDm0HaZTWL2pZU5JujMZNBYn5CTSAxvsNv+cetbir1Fd/7KlOnGCr5n+L0tpFy/tQuvPAWl
 LwqvxO2Zg5GVmzm6skD0zIyIn+JIfsojvvYidkzPBqhT8eji6anK9jswACiiUpnUIapIcvQd4
 HJLzyvqIsyaw2uaY8qwd6jqk6y9n2xUbjPFF0Uy6+IiyNnpPecaAxb+/kMVjUywC76ArPhcIr
 G1KFtGsALLpy313fXfZGRKiRtaGcok7Dls6CrtnWKcUBbTWH8xi/Rr9kOoFtrPb5oHkhE/2EJ
 qneAO21xV0ZbppHZSuk34fMsWcQQSDUS+nPRiA2g2Qko2PMf3+miHrZCWBoNaoVx0uYtL0FRc
 7PY1eai3F10Qrh337GsvUmvII3xdGwS36Pv3P5iWX2qmppUMM1KUEVJysMOUo/VNjXolOSHig
 4ADsBVRGBHsK5KhiKlYMuAmrObir8VpJKdt3Yf2Kr17JiWvrTk9AjlHqLNkcw1UVSibfqKpV8
 Q0Dc4oLnRcAOTFxf0P+t+j/uG7CyENkIojOrsocpG0Q/JZ3fhvUT1z15qMlo28Vkd5xOcm4X2
 e8PiY0tLJ74ngz8TuwjqIxk2PrG6rJABtzs68HRvihVWBeR+ihPCr8+itTMPHeaTvU1NU1xVT
 Uc1UbuGfKEhRCxtIK409JwE3VOwwAOze2Q/yUIn6nQbOBris2DmSDcDJ44Asdp070DFCVqupQ
 0OIGVh4ysVG1IyQBIwooCeiFx4YReNMASxcoyGPLcoIVjGfBNMjWpg/ooORX+lBdtdzLt0a/F
 dKbU2WnVpadLjP2mmJCYqtBdWLGk3x0ZH4XIIuSUIszmtgjRjW+Gxsn9Shvw8uVxAZfCWLAtC
 DRSEQi1d0=
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

Hi Huan

On Sun, 2024-12-08 at 14:51 +0800, Huan Zhou wrote:
> On Wed, Dec 04, 2024 at 09:52:09AM +0100, Marcel Ziswiler wrote:
> > Hi Yixun Lan
> >=20
> > On Wed, 2024-12-04 at 08:58 +0800, Yixun Lan wrote:
> > > Hi Marcel, Huan
> > >=20
> > > On 18:52 Tue 03 Dec=C2=A0=C2=A0=C2=A0=C2=A0 , Marcel Ziswiler wrote:
> > > > Hi Huan Zhou=20
> > > >=20
> > > > On Fri, 2024-11-29 at 13:37 +0800, Huan Zhou wrote:
> > > > > From: Kongyang Liu <seashell11234455@gmail.com>
> > > > >=20
> > > > > Add document for Banana Pi F3 board which based on SpacemiT's K1 =
SoC.
> > > > >=20
> > > > > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > > > > Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> > > > > ---
> > > > > =C2=A0doc/board/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > > =C2=A0doc/board/spacemit/bananapi-f3.rst | 86 +++++++++++++++++++=
+++++++++++++++++++
> > > > > =C2=A0doc/board/spacemit/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 8 ++++
> > > > > =C2=A03 files changed, 95 insertions(+)
> > > > >=20
> > > > > diff --git a/doc/board/index.rst b/doc/board/index.rst
> > > > > index 417c128c7af6ad2267ef1bc743c7f10ae70b6de7..367da2d62316d4cab=
25ecc53f852ef742eba13dd 100644
> > > > > --- a/doc/board/index.rst
> > > > > +++ b/doc/board/index.rst
> > > > > @@ -51,6 +51,7 @@ Board-specific doc
> > > > > =C2=A0=C2=A0=C2=A0 sipeed/index
> > > > > =C2=A0=C2=A0=C2=A0 socionext/index
> > > > > =C2=A0=C2=A0=C2=A0 sophgo/index
> > > > > +=C2=A0=C2=A0 spacemit/index
> > > > > =C2=A0=C2=A0=C2=A0 st/index
> > > > > =C2=A0=C2=A0=C2=A0 starfive/index
> > > > > =C2=A0=C2=A0=C2=A0 ste/index
> > > > > diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/space=
mit/bananapi-f3.rst
> > > > > new file mode 100644
> > > > > index 0000000000000000000000000000000000000000..1e6d6ef19be7e2568=
4966bd4a727bd21b147330a
> > > > > --- /dev/null
> > > > > +++ b/doc/board/spacemit/bananapi-f3.rst
> > > > > @@ -0,0 +1,86 @@
> > > > > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +
> > > > > +Banana Pi F3
> > > >=20
> > > > Officially they call it Banana Pi BPI-F3.
> > > >=20
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +
> > > > > +Building
> > > > > +~~~~~~~~
> > > > > +1. Install the spacemit riscv cross compile toolchain_, or skip =
it if riscv toolchain is installed.
> > > >=20
> > > > I would not use a specific such toolchain but rather a regular RISC=
-V one e.g.
> > > >=20
> > > > https://github.com/riscv-collab/riscv-gnu-toolchain
> > > >=20
> > >=20
> > > I think any riscv toolchain should work fine here, as I'm using Gento=
o specific riscv toolchain..
> > > so consider it's merely an example provided to demonstrate whole proc=
ess working
> >=20
> > Okay.
> >=20
> > > > > +
> > > > > +.. _toolchain: https://archive.spacemit.com/toolchain/
> > > > > +
> > > > > +2. Setup cross compilation environment variable:
> > > > > +
> > > > > +.. code-block:: console
> > > > > +
> > > > > +=C2=A0=C2=A0 export CROSS_COMPILE=3D<riscv64 toolchain prefix, e=
.g /opt/spacemit/bin/riscv64-unknown-linux-gnu->
> > > > > +
> > > > > +3. Before building U-Boot, OpenSBI should be built first. OpenSB=
I can be
> > > > > +built for SpacemiT K1 SoC as below:
> > > > > +
> > > > > +.. code-block:: console
> > > > > +
> > > > > +=C2=A0=C2=A0 git clone https://github.com/cyyself/opensbi=C2=A0-=
b k1-opensbi
> > > > > +=C2=A0=C2=A0 cd opensbi
> > > > > +=C2=A0=C2=A0 make PLATFORM=3Dgeneric
> > > >=20
> > > > What speaks against using regular master opensbi?
> > > >=20
> > > no idea if master of opensbi would work here, we can certainly try..
> >=20
> > I tried and it seems to work fine, resp. the only difference I could sp=
ot is that instead of 'crc32+ OK' it
> > prints some random ASCII characters in the last line before any U-Boot =
output:
> do you mean the extra '\n'?

No, it literally printed some random chars, but now it seems fine. Probably=
 some unrelated glitch maybe UART
related.

Actually, one out of five to ten boots it prints such random chars: =EF=BF=
=BD,=EF=BF=BD=EF=BF=BD&=EF=BF=BD%Hj=EF=BF=BDH=EF=BF=BD

I tried cyyself opensbi again and after 10 boots it also printed similar ra=
ndom chars. Actually, it even always
prints the exact same ones when it happens. I guess, sooner than later, som=
ebody might need to debug into what
exactly is happening there (;-p).

[   0.579] ## Checking hash(es) for Image opensbi ...=EF=BF=BD,=EF=BF=BD=EF=
=BF=BD&=EF=BF=BD%Hj=EF=BF=BDH=EF=BF=BD

Anyway, regular upstream opensbi seems to work just fine, good.

> > [=C2=A0=C2=A0 0.490] ## Checking hash(es) for Image opensbi ... crc32+ =
OK
> >=20
> > > but I think it's another story, as we are focusing on mainlining uboo=
t
> >=20
> > Yes, exactly. I am just curious if it needs combining with some obscure=
 vendor stuff.
> the spl phase need some obscure vendor stuff.

Sure, but I hope we can still upstream it after this first part landed.

> > > FWIK, this branch is generally same version as vendor opensbi, but sl=
ightly
> > > =C2=A0rebase to more recent opensbi version
> > >=20
> > > > > +
> > > > > +4. Then build U-Boot as following:
> > > > > +
> > > > > +.. code-block:: console
> > > > > +
> > > > > +=C2=A0=C2=A0 cd <U-Boot-dir>
> > > > > +=C2=A0=C2=A0 make bananapi-f3_defconfig
> > > > > +=C2=A0=C2=A0 make OPENSBI=3D<OpenSBI-dir>/build/platform/generic=
/firmware/fw_dynamic.bin
> > > > > +
> > > > > +This will generate u-boot.itb
> > > > > +
> > > > > +Booting
> > > > > +~~~~~~~
> > > > > +Actually, we can replace the uboot part from bianbu linux which =
is the bsp_ to validate this patch,
> > > > > +use `balena etcher` to burn the bianbu-minimal.img to the sd car=
d,=20
> > > >=20
> > > > trailing whitespace
> > > >=20
> > > > > +and replace the /dev/sdx4 where places the uboot_ with the `u-bo=
ot.itb` generated from this patch.
> > > > > +
> > > > > +.. _bsp: https://archive.spacemit.com/image/k1/version/bianbu/v2=
.0/
> > > > > +.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-f=
irmware-layout
> > > > > +
> > > > > +Sample boot log from Banana Pi F3 board
> > > >=20
> > > > BPI-F3
> > > >=20
> > > > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > +.. code-block:: none
> > > > > +
> > > > > +=C2=A0=C2=A0 try sd...
> > > > > +=C2=A0=C2=A0 bm:3
> > > > > +=C2=A0=C2=A0 j...
> > > > > +
> > > > > +=C2=A0=C2=A0 U-Boot SPL 2022.10spacemit-dirty (Oct 21 2024 - 09:=
01:13 +0000)
> > > > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.279] DDR type LPDDR4X
> > > > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.292] lpddr4_silicon_init consume 13=
ms
> > > > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.293] Change DDR data rate to 2400MT=
/s
> > > > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.430] ## Checking hash(es) for confi=
g conf-1 ... OK
> > > > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.432] ## Checking hash(es) for Image=
 opensbi ... OK
> > > > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.437] ## Checking hash(es) for Image=
 uboot ... OK
> > > > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.443] ## Checking hash(es) for Image=
 fdt-1 ... OK
> > > > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.488] ## Checking hash(es) for confi=
g config_1 ... OK
> > > > > +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.490] ## Checking hash(es) for Image=
 opensbi ... crc32+ OK
> > > > > +
> > > > > +
> > > > > +=C2=A0=C2=A0 U-Boot 2024.10-rc4-00462-g5b138cfcc587-dirty (Nov 2=
8 2024 - 14:56:49 +0800)
> > > > > +
> > > > > +=C2=A0=C2=A0 DRAM:=C2=A0 4 GiB
> > > >=20
> > > > I guess it does not yet detect the amount of RAM available.
> > > >=20
> > > I would be fine with this, as currently the memory size is hardcoded,
> > > we should work on follow-up patch to auto probe DDR size, and corret =
it
> >=20
> > Yes, I agree.
> >=20
> > > > > +=C2=A0=C2=A0 Core:=C2=A0 19 devices, 8 uclasses, devicetree: sep=
arate
> > > > > +=C2=A0=C2=A0 Loading Environment from nowhere... OK
> > > > > +=C2=A0=C2=A0 In:=C2=A0=C2=A0=C2=A0 serial@d4017000
> > > > > +=C2=A0=C2=A0 Out:=C2=A0=C2=A0 serial@d4017000
> > > > > +=C2=A0=C2=A0 Err:=C2=A0=C2=A0 serial@d4017000
> > > > > +=C2=A0=C2=A0 Net:=C2=A0=C2=A0 No ethernet found.
> > > > > +=C2=A0=C2=A0 =3D> cpu list
> > > > > +=C2=A0=C2=A0 0: cpu@0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > > > +=C2=A0=C2=A0 1: cpu@1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > > > +=C2=A0=C2=A0 2: cpu@2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > > > +=C2=A0=C2=A0 3: cpu@3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > > > +=C2=A0=C2=A0 4: cpu@4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > > > +=C2=A0=C2=A0 5: cpu@5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > > > +=C2=A0=C2=A0 6: cpu@6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > > > +=C2=A0=C2=A0 7: cpu@7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> > > > > +=C2=A0=C2=A0 =3D> test
> > > > > +=C2=A0=C2=A0 =3D>=20
> > > >=20
> > > > trailing whitespace
> > > >=20
> > > > > +
> > > > > diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/in=
dex.rst
> > > > > new file mode 100644
> > > > > index 0000000000000000000000000000000000000000..3fb7d804ac8fc8dd4=
c7ee67ffc877f9ad323162d
> > > > > --- /dev/null
> > > > > +++ b/doc/board/spacemit/index.rst
> > > > > @@ -0,0 +1,8 @@
> > > > > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +
> > > > > +SpacemiT
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +.. toctree::
> > > > > +=C2=A0=C2=A0 :maxdepth: 1
> > > > > +
> > > > > +=C2=A0=C2=A0 bananapi-f3
> > > > >=20
> > > >=20
> > > > new blank line at EOF
> fixed.

Thanks!

Cheers

Marcel
--=20
Marcel Ziswiler         | mailto:marcel@ziswiler.com
Ch=C3=A4ppelirain 4          | https://www.ziswiler.net
CH-6018 Buttisholz      | mobile: +41 (76) 338-0382
Switzerland             | phone: +41 (41) 928-0509
