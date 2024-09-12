Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FE9EEE266
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 21:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C971A890E1;
	Thu, 12 Sep 2024 23:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="AvzhABFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C18890E4; Thu, 12 Sep 2024 23:11:22 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5867E89006
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 23:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1726175459; x=1726780259; i=marcel@ziswiler.com;
 bh=ukCNT3RNrwvUHJMB+J4xLutaKyufoNaDFn549S+y3jU=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AvzhABFKTaexL4vX3XDgiy+XZ27z281xXKmmnw5RD58jYGCDlh0k1bhKlz1qUYlH
 RUKwJjdWS2x+rF7wUkEYKa5ldYeU8epeHOuYIQUDgIPtiEUiFXcf8/jdz+fBbyOQS
 5kJCnFnWMBpo9KfVuMxOowBH+d3RxuNX6Ql5AHZZJRxxTOkMLYggemyTEh/DMiG8a
 20rYercZXPFsp0TLMVyyIF0iUNoxuPFXPqnjwMwnHVpKwxYM1L6GNfwdgrVaGMTq7
 M9Dkw/ZSkO0Py/RevCZ3cQfvsyFPP+diUIA6MWdZTse1Q+uhOohlQ9/CztTJoDYrZ
 VwPS9rgOHEBRFpK3GQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.10.1.123] ([84.227.224.111]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LnyM2-1sMMu31QXw-00ndXN; 
 Thu, 12 Sep 2024 23:10:59 +0200
Message-ID: <091ba8023814d2e721da9a29014ecab991f459af.camel@ziswiler.com>
Subject: Re: [PATCH v2 2/2] doc: spacemit: bananapi_f3: document Banana Pi
 F3 board
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, Jonas
 =?ISO-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>, Kever Yang
 <kever.yang@rock-chips.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Nishanth Menon <nm@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Date: Thu, 12 Sep 2024 23:10:53 +0200
In-Reply-To: <20240718043329.1500-3-seashell11234455@gmail.com>
References: <20240718043329.1500-1-seashell11234455@gmail.com>
 <20240718043329.1500-3-seashell11234455@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:c0FQN+FqCHgykljWgBtUaKMOQuNGT/X1D+wr/ageCJYuyd9RHAZ
 4ncMWSA6G1MSS/GX4Hl0qXVYAEG7ju1KeXGvlKq8n1iaWiHCxe+TJSvS4eRF42OnDI9vEhh
 0Js+qmwj1SExfA6gsWXoUkYpKzAgaCf7WDGTZpEOE1S/fHY2gbWlkgM+h3thJIm1m13Dl0y
 ExfEx+r0FpPQGq11WHa2w==
UI-OutboundReport: notjunk:1;M01:P0:UrY+dCP6WDw=;pON/0vEWTbooY2CZy1RjjTKpaSt
 qKmZCVODFG6RjqiU7exp7zIynrBvCVrVH9yTDkBWusP1niXcH8atOPJjrJQOZ4QWzXoaHbhaP
 J3yKdxqplRGaxgFZ7XSuDvZ1XylBkFUQqq5ZOsTfsN71vqhGJTE3cxBB5BpUDVRSYl24S5/NP
 rFw3Q1lYUo1Zi0m7w4uwglzWRc8mAaG0dK8DmnpE7naXvoTrgGBS1HVMh1JNlHDRy0qMPV4KL
 1MauJiOe7EGp7LKYhyVN6tzQSx3BZwK87h7hEht5I0rpf4r/+y1Zn1YnknQ768X7MvYGAzbcg
 uosoDDl6053C3sF4q74BY5oDSryOvMnwPt9wY5u99jDOywJvhLxhkXUPS7ggUymbsJohQCX1R
 ZGRc+LWmkR0TBqF0ZZqJUsPFVmVTdYzDBXaHjMa1hxaf3eGXg0+otBFxO2N+BAKXAxTUUzXu1
 ++KWkJAABdNcX4zzJfVwCIlmRh4Hgh4BlsWdl9bVpADOsrQMNpywTYbIJCQZFuddBfTC5PIF9
 AbJutvxaDkrjOKGs0IBtOnDxcy5C9P3M71DwNtO+tHDrMMjHDc2SL23bcN9OC/9tjSW7DLMS6
 ynrNUi/84FEUkl68hcKj4Nkd987ohT6W6IYrtuOCuH3pVKAOUDIm4ghVN2wuuffzYEWWGQ5x0
 U2gLHQN0Dblnmh7qBIys6nB8H+HM/UvCX1OgLMz9Zwd3G04XPJVeW/VE1B1DexYCY0b+TKftF
 uH1/bnySNK3aaijjGIViScz4mFewu2Tkg==
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

On Thu, 2024-07-18 at 12:33 +0800, Kongyang Liu wrote:
> Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
>=20
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
>=20
> (no changes since v1)
>=20
> =C2=A0doc/board/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0doc/board/spacemit/bananapi_f3.rst | 78 +++++++++++++++++++++++++++=
+++
> =C2=A0doc/board/spacemit/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 8 +++
> =C2=A03 files changed, 87 insertions(+)
> =C2=A0create mode 100644 doc/board/spacemit/bananapi_f3.rst
> =C2=A0create mode 100644 doc/board/spacemit/index.rst
>=20
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index 417c128c7a..367da2d623 100644
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
> diff --git a/doc/board/spacemit/bananapi_f3.rst b/doc/board/spacemit/bana=
napi_f3.rst
> new file mode 100644
> index 0000000000..cf3041085f
> --- /dev/null
> +++ b/doc/board/spacemit/bananapi_f3.rst
> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Banana Pi F3
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +About This
> +----------
> +Banana Pi F3 board is a industrial grade RISC-V development board, it
> +design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> +computing power. 4G DDR and 16G eMMC onboard.2x GbE Ethernet prot, 4x US=
B

do. missing space before 2x and port rather than prot

> +3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
> +
> +Building
> +~~~~~~~~
> +1. Add the RISC-V toolchain to your PATH.
> +2. Setup ARCH & cross compilation environment variable:
> +
> +.. code-block:: console
> +
> +=C2=A0=C2=A0 export CROSS_COMPILE=3D<riscv64 toolchain prefix>
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
> +
> +4. Then build U-Boot as following:
> +
> +.. code-block:: console
> +
> +=C2=A0=C2=A0 cd <U-Boot-dir>
> +=C2=A0=C2=A0 make bananapi_f3_defconfig
> +=C2=A0=C2=A0 make OPENSBI=3D<OpenSBI-dir>/build/platform/generic/firmwar=
e/fw_dynamic.bin
> +
> +This will generate u-boot.itb
> +
> +Booting
> +~~~~~~~
> +Currently, we use a modified vendor's U-Boot SPL to load a FIT image tha=
t
> +includes OpenSBI and U-Boot. Fully describing how to boot into U-Boot is=
 a
> +challenging task. And the booting method will be added after the SPL
> +support is available.

Hm, would be great if one could at least test it somehow on real hardware. =
We do have boards available BTW (;-
p).

> +
> +Sample boot log from Banana Pi F3 board
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +=C2=A0=C2=A0 U-Boot 2024.07-00686-g608f2d51760c (Jul 08 2024 - 14:53:51 =
+0800)
> +
> +=C2=A0=C2=A0 DRAM:=C2=A0 4 GiB
> +=C2=A0=C2=A0 Core:=C2=A0 18 devices, 7 uclasses, devicetree: separate
> +=C2=A0=C2=A0 Loading Environment from nowhere... OK
> +=C2=A0=C2=A0 In:=C2=A0=C2=A0=C2=A0 serial@d4017000
> +=C2=A0=C2=A0 Out:=C2=A0=C2=A0 serial@d4017000
> +=C2=A0=C2=A0 Err:=C2=A0=C2=A0 serial@d4017000
> +=C2=A0=C2=A0 Net:=C2=A0=C2=A0 No ethernet found.
> +=C2=A0=C2=A0 bananapi_f3# cpu detail
> +=C2=A0=C2=A0=C2=A0=C2=A0 0: cpu@0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit=
,x60
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID =3D 0, freq =3D 0 Hz: MMU
> +=C2=A0=C2=A0=C2=A0=C2=A0 1: cpu@1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit=
,x60
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID =3D 1, freq =3D 0 Hz: MMU
> +=C2=A0=C2=A0=C2=A0=C2=A0 2: cpu@2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit=
,x60
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID =3D 2, freq =3D 0 Hz: MMU
> +=C2=A0=C2=A0=C2=A0=C2=A0 3: cpu@3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit=
,x60
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID =3D 3, freq =3D 0 Hz: MMU
> +=C2=A0=C2=A0=C2=A0=C2=A0 4: cpu@4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit=
,x60
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID =3D 4, freq =3D 0 Hz: MMU
> +=C2=A0=C2=A0=C2=A0=C2=A0 5: cpu@5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit=
,x60
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID =3D 5, freq =3D 0 Hz: MMU
> +=C2=A0=C2=A0=C2=A0=C2=A0 6: cpu@6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit=
,x60
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID =3D 6, freq =3D 0 Hz: MMU
> +=C2=A0=C2=A0=C2=A0=C2=A0 7: cpu@7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spacemit=
,x60
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID =3D 7, freq =3D 0 Hz: MMU
> +=C2=A0=C2=A0 bananapi_f3#
> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> new file mode 100644
> index 0000000000..78081a47ff
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
> +=C2=A0=C2=A0 bananapi_f3

do.
