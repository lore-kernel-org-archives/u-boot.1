Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8DFC3DA49
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 15:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D6387EFA;
	Sun, 14 Jul 2024 17:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Klk+M489";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C08F87FA7; Sun, 14 Jul 2024 17:19:18 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E31187B30
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 17:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720970344; x=1721575144; i=xypron.glpk@gmx.de;
 bh=/JYHwD85Ojqk9KCjBl08A9knxCik98EQksb92ihf47w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Klk+M489BQMl6lUeV/koitK5kB4HIQtMcR56+9wyt4ARH3gQmlzz9prYHdRYSWlO
 bm+ZMlmAzdryiaFW5HZC6zdOm/5n523mXnMKNdIpHtFc+Kigy+GilCb44n86/mbL1
 gSb9YE/gE/12/wbLTyztP8b+UyaGYV2VJW3BcR3EB/JuCkT4QRAJetd43mGxpGthj
 U2qUQ2JQxIi7N8B/HaSWb0yFNYGgcKBYzkx3etATfFxGKol4THw7BSTzGRBPt1j+E
 ZbAFhxKH7wQr+gL/ZyPR6WIu/JLqcdSgD8g2RVD5/d58oiSX3qZpex9OTLF3vhRtC
 LM+DRAUbU+yaCPVg4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1sXwgI2AXW-006bA8; Sun, 14
 Jul 2024 17:19:04 +0200
Message-ID: <50e8f905-5845-4faa-9e75-8d7ea1051a74@gmx.de>
Date: Sun, 14 Jul 2024 17:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3
 board
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240714150828.736-1-seashell11234455@gmail.com>
 <20240714150828.736-3-seashell11234455@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240714150828.736-3-seashell11234455@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OxmU4YJGKkNxHt71GiovLx9CXYNL26jElBE/kj/PWxO3p7IME1l
 PJCiRz2mDT8dC1sxtrLJAjZxUOWENMqeaQrD/2PFf5AExL8IS+Wi0oPyJDSRfE7pNCaf4P8
 2fh+hwx9pJTO+YNW+OL3X3mUs1gjbTSSc9NtBO4eVW9SvaIFsrQ03CrNOtn4Qg2Jq9iaJQq
 4XeKzcA+zMaxkqXhCK0Wg==
UI-OutboundReport: notjunk:1;M01:P0:Ufk0CCGxaa0=;JoSyIpFbzJQf9X9qpK7Y1oMJ8Di
 ArrLrVptV97UJ/bJplwQDBIVNUMvHn8DXeG02L0166Z7Trt1+UOJuj1Iy11iI7rWaHTeCMZfx
 TDm0WV+oyJMwf3GY7+WR26Sq857CUrtT68s0SKoBP0te/HSl/lbHlIjWZ9TGBopdMt9ggT3V5
 IQwRvG04GHre9MqyqErQr/ltaWyQSX8idSo8aQFRghRbWflYTDOqfSCatdI+viyKeoAqIa7Iv
 e8eacRfE2312Sa6CniOOwii3RURzOg1RQJ1+rLQIr5uaKTEUOuK379TpCagqkGMKk0DBmvryZ
 ys1ohHnzYee0Iki1gplXqRNh25BHaOSYWvsb3p+JFSa/THlO/X3AoN5ShWbhRxsHXYoukPkEZ
 EmXdlY5+MmhrmKZWCUhoWcRuNQb/buwN3hsq51kUWBizF27KPuOYl2t8BbBBcp0henrxU10G2
 U1JlMoro9uaI8Mg/lnzfB7zRKshN+MWTXJR4tQ96Q/PLbA9oqBI/KtQx3uRz1CzLI1cYD3UF9
 lRXmJL6t3tjwK62cbESl/kgxipK3lECjw4FAfkthjWFXqCUXpx/loUHj6jRalWME5Ks6VMphu
 Azj4tXIyC5xkXg2ME003JMWJfeefjZgJCxXsd5HBkYO8EgqmNfrLkHtlce8FmTZ4Kb/+mSdiM
 2ydo5+X1P8Vts0RbSqQs5wQh36WTa6+UL8z/Q1tR5zU+hVLPPeCgJFbcGFjp52vOd92VMSlVb
 cDLyzs5/1iYXNrzHOkdy1Jz7KvxQuCsP/iu9ySkWsBJq9je5mzRJSE95ZZlDIvE1iRUYEm27y
 xuhGw0q8MJAHfKTo4MbPwb+Q==
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

On 7/14/24 17:08, Kongyang Liu wrote:
> Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
>
>   doc/board/index.rst                |  1 +
>   doc/board/spacemit/bananapi_f3.rst | 78 ++++++++++++++++++++++++++++++
>   doc/board/spacemit/index.rst       |  8 +++
>   3 files changed, 87 insertions(+)
>   create mode 100644 doc/board/spacemit/bananapi_f3.rst
>   create mode 100644 doc/board/spacemit/index.rst
>
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index 417c128c7a..367da2d623 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -51,6 +51,7 @@ Board-specific doc
>      sipeed/index
>      socionext/index
>      sophgo/index
> +   spacemit/index
>      st/index
>      starfive/index
>      ste/index
> diff --git a/doc/board/spacemit/bananapi_f3.rst b/doc/board/spacemit/ban=
anapi_f3.rst
> new file mode 100644
> index 0000000000..465040b94f
> --- /dev/null
> +++ b/doc/board/spacemit/bananapi_f3.rst
> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Banana Pi F3
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +About This
> +----------
> +Banana Pi F3 board is a industrial grade RISC-V development board, it
> +design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> +computing power. 4G DDR and 16G eMMC onboard.2x GbE Ethernet prot, 4x U=
SB
> +3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
> +
> +Building
> +~~~~~~~~
> +1. Add the RISC-V toolchain to your PATH.
> +2. Setup ARCH & cross compilation environment variable:
> +
> +.. code-block:: console
> +
> +   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
> +
> +3. Before building U-Boot, OpenSBI should be built first. OpenSBI can b=
e
> +built for SpacemiT K1 SoC as below:
> +
> +.. code-block:: console
> +
> +   git clone https://github.com/cyyself/opensbi -b k1-opensbi
> +   cd opensbi
> +   make PLATFORM=3Dgeneric
> +
> +4. Then build U-Boot as following:
> +
> +.. code-block:: console
> +
> +   cd <U-Boot-dir>
> +   make bananapi_f3_defconfig
> +   make OPENSBI=3D<OpenSBI-dir>/build/platform/generic/firmware/fw_dyna=
mic.bin
> +
> +This will generate u-boot.itb

Thanks a lot for the board documentation.

Could you, please, describe how to install the u-boot.itb.

To where should it be copied?
Does it need to be signed to be accepted by the vendor SPL?

Best regards

Heinrich

> +
> +Booting
> +~~~~~~~
> +Currently, we use a modified vendor's U-Boot SPL to load a FIT image th=
at
> +includes OpenSBI and U-Boot. Fully describing how to boot into U-Boot i=
s a
> +challenging task. And the booting method will be added after the SPL
> +support is available.
> +
> +Sample boot log from Banana Pi F3 board
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +   U-Boot 2024.07-00686-g608f2d51760c (Jul 08 2024 - 14:53:51 +0800)
> +
> +   DRAM:  4 GiB
> +   Core:  18 devices, 7 uclasses, devicetree: separate
> +   Loading Environment from nowhere... OK
> +   In:    serial@d4017000
> +   Out:   serial@d4017000
> +   Err:   serial@d4017000
> +   Net:   No ethernet found.
> +   bananapi_f3# cpu detail
> +     0: cpu@0      spacemit,x60
> +      ID =3D 0, freq =3D 0 Hz: MMU
> +     1: cpu@1      spacemit,x60
> +      ID =3D 1, freq =3D 0 Hz: MMU
> +     2: cpu@2      spacemit,x60
> +      ID =3D 2, freq =3D 0 Hz: MMU
> +     3: cpu@3      spacemit,x60
> +      ID =3D 3, freq =3D 0 Hz: MMU
> +     4: cpu@4      spacemit,x60
> +      ID =3D 4, freq =3D 0 Hz: MMU
> +     5: cpu@5      spacemit,x60
> +      ID =3D 5, freq =3D 0 Hz: MMU
> +     6: cpu@6      spacemit,x60
> +      ID =3D 6, freq =3D 0 Hz: MMU
> +     7: cpu@7      spacemit,x60
> +      ID =3D 7, freq =3D 0 Hz: MMU
> +   bananapi_f3#
> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> new file mode 100644
> index 0000000000..cc2bd6ab0a
> --- /dev/null
> +++ b/doc/board/spacemit/index.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +SpacemiT
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +.. toctree::
> +   :maxdepth: 1
> +
> +   bananapi_f3

