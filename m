Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D744E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 17:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBBD8895CE;
	Tue,  3 Dec 2024 18:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="mR+Uhy6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EDCF895F3; Tue,  3 Dec 2024 18:53:38 +0100 (CET)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4206889398
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 18:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1733248385; x=1733853185; i=marcel@ziswiler.com;
 bh=ryjRQKVU04gCeXlesjnl4MJN1GRmArU/Lv3YslA9jnU=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mR+Uhy6T9w1U8bOgGMmgGzUT7Wx8IoAdMjwZmAvLfCogNq+mij+heCPjYyZzLf67
 OCbYY4vgQYD6YB9LUHjvAHBviXNXBTn5OsCUIMd07X7lQrYABKEmM9IMQFnUL4xUv
 RD331hllQba8WTvEIAtR+tIKTE6FZBzH+tWpJBYq8N0jdvuWEqj73zlBTllldkz31
 FDKd8L3fHy2J9Xc1Amg43VT2V2xVFi8giIbbnh1+1A1U0Ckt4c/+RR5jrl8koWZQe
 frgK87Hh08vV54gzlrASs4xs6b+R0PaeGCSlnruy53uX/fyNWnWdCu36mAPSnsUrx
 mMsH0LbnJOZUqmoStQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.10.1.195] ([194.230.241.203]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MBmSX-1tPRFH2EfH-00FNeU; 
 Tue, 03 Dec 2024 18:53:05 +0100
Message-ID: <ad100a4f673759559a6047083713d379847894cb.camel@ziswiler.com>
Subject: Re: [PATCH v4 2/2] doc: spacemit: bananapi_f3: document Banana Pi
 F3 board
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Huan Zhou <pericycle.cc@gmail.com>, u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?ISO-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>, Kever Yang
 <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, Michal Simek	
 <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, Padmarao Begari	
 <padmarao.begari@microchip.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Samuel
 Holland	 <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel	 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Yu
 Chien Peter Lin	 <peterlin@andestech.com>, Kongyang Liu
 <seashell11234455@gmail.com>
Date: Tue, 03 Dec 2024 18:52:57 +0100
In-Reply-To: <20241129-pickup-bpif3-v4-2-e99fabf66e33@gmail.com>
References: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
 <20241129-pickup-bpif3-v4-2-e99fabf66e33@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:g3EBIp0BN3If7kPmV8H1iBdNUyTB8wz+oCJgDrsmBlotmsEwelx
 542TOvO1svURTGeybQefsw/NmvuMzF/O1RrUx78qebcqIFaeV7+nKhNutZXos7C8reGCIjq
 3zIxIxUxvyezTeJ6Y7QJ/JizqlL688Nx4LRvd8OmBwOCk3oipbHthBIYUsncdKoGXQbnSTQ
 sbmSkj9J7iNXMpQOG7bag==
UI-OutboundReport: notjunk:1;M01:P0:cvjsC425TY0=;yNDJi2/y9WPV8QLPJl1QO+FvBIm
 Q7obOqTUqOpzq5Lb1a6NMhO/GIF3nqHInfdcKBot4RDv+GEsTgWurVST26g6BKTnR178JxoUD
 jHmoBO4meSujqJn3yV+dx4gYKYMtoAYiNIRBhVObpaMSjHtgRhX21sYRtbp30CVr+LglL/tcA
 TD++qsM0IJB7IvaayK6gZBkWFB2fCRLikjpHWdkFTGVqTBYRllLhNfomJt2BcgYtZtSBQdqll
 mzQt7fZan3gHyAy69aGC8BS940OVJS/LQiTbKBVitVyeojgMNGSVXFMiAZYg49cQLR/yGcXcX
 1bHnE55DW0xWCqetSeBN3FU8XobP33OGmz9rPscWUOsERn+Gwj0Q0ZnbklBdbiKYjSJYs/2DW
 4xUcKaJK+YIX370yH0SOfBMRca4NppRUBYQP2PIRKhAYAW7s+NqHqDvj17dBxKu85uGsvEKyQ
 ZZsZEA4cTGeCnoQe5dCx0jm7fa8BIUMTIWSskO8w+WEBFxKWzXrPS9NBrNHlgJ0b4ctYvxIVP
 Uw5tLRkRv+J6QXav6Us6sxHhOoGWL5fxU7N9C50sDvLPHtzBosTw8LBD1Kq2JcIbTFP5+eOxx
 eqerW4cCo1f95NcnRaZjcs/zmw5py5X2rBaokS0X3ORGS9Qbs1NmhQ/tmnl8K2f/ZHsWeGucH
 NKmf6TGz8HqnU1mte9ktj+qGpdnaCLEnkcSwYzmHbjkCHHnTZ7hpio4tIwKH5KzKkTC+KF0WK
 86BDUTBidtC7xzW1u0fa8DKR/Q/EGtCLShRx1QVUFe0kq9+yThIQOe1ayuGS5mPQYLi0lniL9
 tpmfe6qCc7KtVR0vc73ddnTwZVK1MlXcGeqdBRSvUvvoNrQ0bleyCuGrMjMdfZTE4gMfVfEnt
 aUWscc6fUTZRuNznaTIjihZEicTUtF+50ZNsK2sWiq5lmM4EQaxLtOKopRHBCAX+/PVGhXVuX
 5P6aqr+kujniwZJo2dn8ZY8awvdXRWhz5LcOpNe0z6NUxEw6v2uWOGNX1oBSNdtVz7Yk+ac89
 gW6oeWvApJz0w2ji4HS2y+2AQ3F3vzmXhIHA19x
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

Hi Huan Zhou=20

On Fri, 2024-11-29 at 13:37 +0800, Huan Zhou wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
>=20
> Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
>=20
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> ---
> =C2=A0doc/board/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0doc/board/spacemit/bananapi-f3.rst | 86 +++++++++++++++++++++++++++=
+++++++++++
> =C2=A0doc/board/spacemit/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 8 ++++
> =C2=A03 files changed, 95 insertions(+)
>=20
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index 417c128c7af6ad2267ef1bc743c7f10ae70b6de7..367da2d62316d4cab25ecc53f=
852ef742eba13dd 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -51,6 +51,7 @@ Board-specific doc
> =C2=A0=C2=A0=C2=A0 sipeed/index
> =C2=A0=C2=A0=C2=A0 socionext/index
> =C2=A0=C2=A0=C2=A0 sophgo/index
> +=C2=A0=C2=A0 spacemit/index
> =C2=A0=C2=A0=C2=A0 st/index
> =C2=A0=C2=A0=C2=A0 starfive/index
> =C2=A0=C2=A0=C2=A0 ste/index
> diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bana=
napi-f3.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..1e6d6ef19be7e25684966bd4a=
727bd21b147330a
> --- /dev/null
> +++ b/doc/board/spacemit/bananapi-f3.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Banana Pi F3

Officially they call it Banana Pi BPI-F3.

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Building
> +~~~~~~~~
> +1. Install the spacemit riscv cross compile toolchain_, or skip it if ri=
scv toolchain is installed.

I would not use a specific such toolchain but rather a regular RISC-V one e=
.g.

https://github.com/riscv-collab/riscv-gnu-toolchain

> +
> +.. _toolchain: https://archive.spacemit.com/toolchain/
> +
> +2. Setup cross compilation environment variable:
> +
> +.. code-block:: console
> +
> +=C2=A0=C2=A0 export CROSS_COMPILE=3D<riscv64 toolchain prefix, e.g /opt/=
spacemit/bin/riscv64-unknown-linux-gnu->
> +
> +3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
> +built for SpacemiT K1 SoC as below:
> +
> +.. code-block:: console
> +
> +=C2=A0=C2=A0 git clone https://github.com/cyyself/opensbi=C2=A0-b k1-ope=
nsbi
> +=C2=A0=C2=A0 cd opensbi
> +=C2=A0=C2=A0 make PLATFORM=3Dgeneric

What speaks against using regular master opensbi?

> +
> +4. Then build U-Boot as following:
> +
> +.. code-block:: console
> +
> +=C2=A0=C2=A0 cd <U-Boot-dir>
> +=C2=A0=C2=A0 make bananapi-f3_defconfig
> +=C2=A0=C2=A0 make OPENSBI=3D<OpenSBI-dir>/build/platform/generic/firmwar=
e/fw_dynamic.bin
> +
> +This will generate u-boot.itb
> +
> +Booting
> +~~~~~~~
> +Actually, we can replace the uboot part from bianbu linux which is the b=
sp_ to validate this patch,
> +use `balena etcher` to burn the bianbu-minimal.img to the sd card,=20

trailing whitespace

> +and replace the /dev/sdx4 where places the uboot_ with the `u-boot.itb` =
generated from this patch.
> +
> +.. _bsp: https://archive.spacemit.com/image/k1/version/bianbu/v2.0/
> +.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-=
layout
> +
> +Sample boot log from Banana Pi F3 board

BPI-F3

> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +=C2=A0=C2=A0 try sd...
> +=C2=A0=C2=A0 bm:3
> +=C2=A0=C2=A0 j...
> +
> +=C2=A0=C2=A0 U-Boot SPL 2022.10spacemit-dirty (Oct 21 2024 - 09:01:13 +0=
000)
> +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.279] DDR type LPDDR4X
> +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.292] lpddr4_silicon_init consume 13ms
> +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.293] Change DDR data rate to 2400MT/s
> +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.430] ## Checking hash(es) for config conf-1=
 ... OK
> +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.432] ## Checking hash(es) for Image opensbi=
 ... OK
> +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.437] ## Checking hash(es) for Image uboot .=
.. OK
> +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.443] ## Checking hash(es) for Image fdt-1 .=
.. OK
> +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.488] ## Checking hash(es) for config config=
_1 ... OK
> +=C2=A0=C2=A0 [=C2=A0=C2=A0 0.490] ## Checking hash(es) for Image opensbi=
 ... crc32+ OK
> +
> +
> +=C2=A0=C2=A0 U-Boot 2024.10-rc4-00462-g5b138cfcc587-dirty (Nov 28 2024 -=
 14:56:49 +0800)
> +
> +=C2=A0=C2=A0 DRAM:=C2=A0 4 GiB

I guess it does not yet detect the amount of RAM available.

> +=C2=A0=C2=A0 Core:=C2=A0 19 devices, 8 uclasses, devicetree: separate
> +=C2=A0=C2=A0 Loading Environment from nowhere... OK
> +=C2=A0=C2=A0 In:=C2=A0=C2=A0=C2=A0 serial@d4017000
> +=C2=A0=C2=A0 Out:=C2=A0=C2=A0 serial@d4017000
> +=C2=A0=C2=A0 Err:=C2=A0=C2=A0 serial@d4017000
> +=C2=A0=C2=A0 Net:=C2=A0=C2=A0 No ethernet found.
> +=C2=A0=C2=A0 =3D> cpu list
> +=C2=A0=C2=A0 0: cpu@0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> +=C2=A0=C2=A0 1: cpu@1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> +=C2=A0=C2=A0 2: cpu@2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> +=C2=A0=C2=A0 3: cpu@3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> +=C2=A0=C2=A0 4: cpu@4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> +=C2=A0=C2=A0 5: cpu@5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> +=C2=A0=C2=A0 6: cpu@6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> +=C2=A0=C2=A0 7: cpu@7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit,x60
> +=C2=A0=C2=A0 =3D> test
> +=C2=A0=C2=A0 =3D>=20

trailing whitespace

> +
> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..3fb7d804ac8fc8dd4c7ee67ff=
c877f9ad323162d
> --- /dev/null
> +++ b/doc/board/spacemit/index.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +SpacemiT
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +.. toctree::
> +=C2=A0=C2=A0 :maxdepth: 1
> +
> +=C2=A0=C2=A0 bananapi-f3
>=20

new blank line at EOF

Cheers

Marcel
