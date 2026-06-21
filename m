Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FC2CD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 07:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 522CF84844;
	Sun, 21 Jun 2026 09:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XoecaI1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9289584874; Sun, 21 Jun 2026 09:38:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA1583FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 09:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782027498; x=1782632298; i=xypron.glpk@gmx.de;
 bh=Rq/4nW1tcoIK/05CO7XK1TRfT/PCuwDK/jisFZAAA80=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XoecaI1sc6aNxs0RmXA5/MG6pBpcs3k9O4TNmDrOpgobBoWqOqW0QI1OHdTlvehn
 nNuJtoEMn6RUCdMGxuj0IqVwWyceoYjNk4hJ1kp29ZWDUsPjiBpbuh4i0GSfRLQAl
 4M43PVHePamdmwo36lZOzKYUWR1hUdFVYmUV+Tqcest2lahLhl0MDhE3muDC6y+MG
 3h5jXj2XYHHlUM07r0Utvod7b93W0JJ23LLtonoLEWq7C3LShp1VGmAvqOpCiLjuw
 e0wOH9rSK/UDtxPqQpZP1u5HaqQOuexivndnCUm47x8JhqoHcQpQNn77JN3DgMd6L
 N3AGVTk+jXeuGOO7hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1we2Q81QXO-00NFGB; Sun, 21
 Jun 2026 09:38:18 +0200
Message-ID: <e8c31620-be0c-418a-8703-14c38a3f4d4f@gmx.de>
Date: Sun, 21 Jun 2026 09:38:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] doc: board: renesas: Document SH/Aarch32/Aarch64
 toolchain setup
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
 <20260616231933.44392-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260616231933.44392-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kLcbjpl2HwrRHFKSpFADQz8ILuTGMHWZrCHFSM0YYB57oMUbfZD
 d3CZxl87dz3Iwt9Et5Ofzmai2xMMbR3yzNKNglM/xVCz2wAU+1+OBR8+UUnNbwOvXyouiF7
 lBsW097USIExfXUYg7nwAtAHWRV6dFV3E45/0bHgx77xm5g0yu78VdqkMvEe/2XuV61CzI9
 T09M7CO6A8vRRYFw9VrxQ==
UI-OutboundReport: notjunk:1;M01:P0:cKw/4lKU8eQ=;dyi4a0p+8NOknSX185mTaCBbODQ
 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
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

On 6/17/26 01:18, Marek Vasut wrote:
> Add documents which briefly outline how to set up the SH4/Aarch32/Aarch6=
4
> toolchains, for future use in Renesas documentation. Reference all these
> documents in the renesas list of boards "Arch" column.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   doc/board/renesas/build-env-aarch32.rst | 24 +++++++
>   doc/board/renesas/build-env-aarch64.rst | 24 +++++++
>   doc/board/renesas/build-env-sh.rst      | 24 +++++++
>   doc/board/renesas/index.rst             |  3 +
>   doc/board/renesas/renesas.rst           | 86 ++++++++++++-------------
>   5 files changed, 118 insertions(+), 43 deletions(-)
>   create mode 100644 doc/board/renesas/build-env-aarch32.rst
>   create mode 100644 doc/board/renesas/build-env-aarch64.rst
>   create mode 100644 doc/board/renesas/build-env-sh.rst
>=20
> diff --git a/doc/board/renesas/build-env-aarch32.rst b/doc/board/renesas=
/build-env-aarch32.rst
> new file mode 100644
> index 00000000000..787c563c097
> --- /dev/null
> +++ b/doc/board/renesas/build-env-aarch32.rst
> @@ -0,0 +1,24 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Renesas 32-bit ARM SoC build environment setup
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In order to cross-compile U-Boot for ARM 32-bit target, it is necessary

%s/for ARM/for the ARM/

> +to install suitable toolchain. The toolchain is available in various

%s /install suitable/install a suitable/

> +distribution repositories as ``arm-linux-gnueabi-*`` or similar package=
.

Please, add empty line.

> +Debian example:
> +
> +.. code-block:: console
> +
> +    $ apt install binutils-arm-linux-gnueabi cpp-arm-linux-gnueabi gcc-=
arm-linux-gnueabi
> +
> +Alternatively, it is possible to download prebuilt toolchain from
> +kernel.org cross-development toolchains page
> +https://www.kernel.org/pub/tools/crosstool/ .
> +
> +Once the toolchain is installed, add toolchain into ``PATH`` variable:
> +
> +.. code-block:: console
> +
> +    $ export PATH=3D$PATH:<path/to/arm32/toolchain/bin/>
> +    $ export CROSS_COMPILE=3Darm-linux-gnueabi-
> diff --git a/doc/board/renesas/build-env-aarch64.rst b/doc/board/renesas=
/build-env-aarch64.rst
> new file mode 100644
> index 00000000000..eddfbaf0d39
> --- /dev/null
> +++ b/doc/board/renesas/build-env-aarch64.rst
> @@ -0,0 +1,24 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Renesas 64-bit ARM SoC build environment setup
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In order to cross-compile U-Boot for aarch64 target, it is necessary

%s/for aarch64/for the aarch64/


> +to install suitable toolchain. The toolchain is available in various

%s /install suitable/install a suitable/

> +distribution repositories as ``aarch64-linux-gnu-*`` or similar package=
.

Please, add empty line.

The same applies for the boards below too.

Best regards

Heinrich

> +Debian example:
> +
> +.. code-block:: console
> +
> +    $ apt install binutils-aarch64-linux-gnu cpp-aarch64-linux-gnu gcc-=
aarch64-linux-gnu
> +
> +Alternatively, it is possible to download prebuilt toolchain from
> +kernel.org cross-development toolchains page
> +https://www.kernel.org/pub/tools/crosstool/ .
> +
> +Once the toolchain is installed, add toolchain into ``PATH`` variable:
> +
> +.. code-block:: console
> +
> +    $ export PATH=3D$PATH:<path/to/arm64/toolchain/bin/>
> +    $ export CROSS_COMPILE=3Daarch64-linux-gnu-
> diff --git a/doc/board/renesas/build-env-sh.rst b/doc/board/renesas/buil=
d-env-sh.rst
> new file mode 100644
> index 00000000000..dce8a735269
> --- /dev/null
> +++ b/doc/board/renesas/build-env-sh.rst
> @@ -0,0 +1,24 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Renesas 32-bit SH4 SoC build environment setup
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In order to cross-compile U-Boot for SH3 32-bit target, it is necessary
> +to install suitable toolchain. The toolchain is available in various
> +distribution repositories as ``sh4-linux-gnu-*`` or similar package.
> +Debian example:
> +
> +.. code-block:: console
> +
> +    $ apt install binutils-sh4-linux-gnu cpp-sh4-linux-gnu gcc-sh4-linu=
x-gnu
> +
> +Alternatively, it is possible to download prebuilt toolchain from
> +kernel.org cross-development toolchains page
> +https://www.kernel.org/pub/tools/crosstool/ .
> +
> +Once the toolchain is installed, add toolchain into ``PATH`` variable:
> +
> +.. code-block:: console
> +
> +    $ export PATH=3D$PATH:<path/to/sh4/toolchain/bin/>
> +    $ export CROSS_COMPILE=3Dsh4-linux-gnu-
> diff --git a/doc/board/renesas/index.rst b/doc/board/renesas/index.rst
> index fb6558ec11b..ef2b856a77c 100644
> --- a/doc/board/renesas/index.rst
> +++ b/doc/board/renesas/index.rst
> @@ -7,4 +7,7 @@ Renesas
>      :maxdepth: 2
>  =20
>      renesas
> +   build-env-sh
> +   build-env-aarch32
> +   build-env-aarch64
>      rzn1
> diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.r=
st
> index fcfd51aa19c..132605b0c33 100644
> --- a/doc/board/renesas/renesas.rst
> +++ b/doc/board/renesas/renesas.rst
> @@ -27,241 +27,241 @@ Renesas is a SoC solutions provider for automotive=
 and industrial applications.
>      * - R2D
>        - R2D-PLUS
>        - SH7751
> -     - sh
> +     - :doc:`sh <build-env-sh>`
>        - r2dplus_defconfig
>  =20
>      * - RZ/A1
>        - GR-PEACH
>        - R7S72100 (RZ/A1H)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - grpeach_defconfig
>  =20
>      * - R-Car Gen2
>        - Lager
>        - R8A7790 (H2)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - lager_defconfig
>  =20
>      * -
>        - Stout
>        - R8A7790 (H2)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - stout_defconfig
>  =20
>      * -
>        - Koelsch
>        - R8A7791 (M2-W)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - koelsch_defconfig
>  =20
>      * -
>        - Porter
>        - R8A7791 (M2-W)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - porter_defconfig
>  =20
>      * -
>        - Blanche
>        - R8A7792 (V2H)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - blanche_defconfig
>  =20
>      * -
>        - Gose
>        - R8A7793 (M2-N)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - gose_defconfig
>  =20
>      * -
>        - Alt
>        - R8A7794 (E2)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - alt_defconfig
>  =20
>      * -
>        - Silk
>        - R8A7794 (E2)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - silk_defconfig
>  =20
>      * - R-Car Gen3
> -     - Salvator-X(S)
> +     - :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`
>        - R8A77951 (H3)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - rcar3_salvator-x_defconfig
>  =20
>      * -
>        - ULCB
>        - R8A77951 (H3)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - rcar3_ulcb_defconfig
>  =20
>      * -
> -     - Salvator-X(S)
> +     - :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`
>        - R8A77960 (M3-W)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - rcar3_salvator-x_defconfig
>  =20
>      * -
>        - ULCB
>        - R8A77960 (M3-W)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - rcar3_ulcb_defconfig
>  =20
>      * -
> -     - Salvator-X(S)
> +     - :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`
>        - R8A77965 (M3-N)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - rcar3_salvator-x_defconfig
>  =20
>      * -
>        - ULCB
>        - R8A77965 (M3-N)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - rcar3_ulcb_defconfig
>  =20
>      * -
>        - Geist
>        - R8A779MD (M3Le)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a779md_geist_defconfig
>  =20
>      * -
>        - Eagle
>        - R8A77970 (V3M)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a77970_eagle_defconfig
>  =20
>      * -
>        - V3MSK
>        - R8A77970 (V3M)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a77970_v3msk_defconfig
>  =20
>      * -
>        - Condor
>        - R8A77980 (V3H)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a77980_condor_defconfig
>  =20
>      * -
>        - V3HSK
>        - R8A77980 (V3H)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a77980_v3hsk_defconfig
>  =20
>      * -
>        - Ebisu
>        - R8A77990 (E3)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a77990_ebisu_defconfig
>  =20
>      * -
>        - Draak
>        - R8A77995 (D3)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a77995_draak_defconfig
>  =20
>      * - R-Car Gen4
>        - Falcon
>        - R8A779A0 (V3U)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a779a0_falcon_defconfig
>  =20
>      * -
>        - Spider
>        - R8A779F0 (S4)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a779f0_spider_defconfig
>  =20
>      * -
>        - S4SK
>        - R8A779F4 (S4)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a779f4_s4sk_defconfig
>  =20
>      * -
>        - White Hawk
>        - R8A779G0 (V4H)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a779g0_whitehawk_defconfig
>  =20
>      * -
>        - Sparrow Hawk
>        - R8A779G3 (V4H)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a779g3_sparrowhawk_defconfig
>  =20
>      * -
>        - Gray Hawk
>        - R8A779H0 (V4M)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a779h0_grayhawk_defconfig
>  =20
>      * - R-Car Gen5
>        - Ironhide (Cortex-A720AE application core)
>        - R8A78000 (X5H)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a78000_ironhide_defconfig
>  =20
>      * -
>        - Ironhide (Cortex-M33 RSIP boot core)
>        - R8A78000 (X5H)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - r8a78000_ironhide_cm33_defconfig
>  =20
>      * - RZ/G2 Family
>        - Beacon EmbeddedWorks RZ/G2M SoM
>        - R8A774A1 (RZ/G2M)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - rzg2_beacon_defconfig
>  =20
>      * -
>        - HopeRun HiHope RZ/G2M
>        - R8A774A1 (RZ/G2M)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - hihope_rzg2_defconfig
>  =20
>      * -
>        - Beacon EmbeddedWorks RZ/G2N SoM
>        - R8A774B1 (RZ/G2N)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - rzg2_beacon_defconfig
>  =20
>      * -
>        - HopeRun HiHope RZ/G2N
>        - R8A774B1 (RZ/G2N)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - hihope_rzg2_defconfig
>  =20
>      * -
>        - Silicon Linux RZ/G2E evaluation kit (EK874)
>        - R8A774C0 (RZ/G2E)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - silinux_ek874_defconfig
>  =20
>      * -
>        - Beacon EmbeddedWorks RZ/G2H SoM
>        - R8A774E1 (RZ/G2H)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - rzg2_beacon_defconfig
>  =20
>      * -
>        - HopeRun HiHope RZ/G2H
>        - R8A774E1 (RZ/G2H)
> -     - arm64
> +     - :doc:`arm64 <build-env-aarch64>`
>        - hihope_rzg2_defconfig
>  =20
>      * - :doc:`RZ/N1 Family <rzn1>`
>        - Schneider RZ/N1D board
>        - R9A06G032 (RZ/N1D)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - rzn1_snarc_defconfig
>  =20
>      * -
>        - Schneider RZ/N1S board
>        - R9A06G033 (RZ/N1S)
> -     - arm
> +     - :doc:`arm <build-env-aarch32>`
>        - rzn1_snarc_defconfig
>  =20
>   Build

