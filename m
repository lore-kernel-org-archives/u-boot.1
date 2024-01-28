Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4648BC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 09:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 525A18811C;
	Sun, 28 Jan 2024 10:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="U8OfZ0+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9753488140; Sun, 28 Jan 2024 10:16:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96846880C3
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 10:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706433368; x=1707038168; i=xypron.glpk@gmx.de;
 bh=rpOlNDZSIIYZ6VC739DW9zYHA03bjZ2TAZrDGw7EZlE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=U8OfZ0+TNAnwOd7eeyOOL6B9TdVGbLxLhaodo35SBQ1bE+0LzXYsDZm2q1tx0ODG
 4PCGE3ROyN2UVVuI1S8uIaaW/T+YtS4rSfX0ZtgYF9IWslZQhpe368hSxmW2pO8dO
 F/D1H+3jbF5NGV7IkkSCxAU5MS9h4icsNmjkr/oHW49fu6lFFOqPHlPRsIaCbVgLf
 Qbkxe6V83YVvMnkcvIN2cjaOeyltotykoZuvC8DF7DIvfgE9ExW+7TdaU+W5unBBY
 biRn5liRqrYw3JvNgFVOiGOvwLYQM4cnB+XruTpxbuQr4DrQgf3nNssPDpCAP1UAu
 hNFY6bZbHWBzKRU5qA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1rX8Bz0IkB-00Wpui; Sun, 28
 Jan 2024 10:16:08 +0100
Message-ID: <2acf8505-315e-486d-a07d-c91fddfe6671@gmx.de>
Date: Sun, 28 Jan 2024 10:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] doc: sophgo: milkv_duo: document Milk-V Duo board
Content-Language: en-US, de-DE
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: Adam Ford <aford173@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Fabio Estevam <festevam@denx.de>, Nishanth Menon <nm@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, Yixun Lan <dlan@gentoo.org>,
 u-boot@lists.denx.de
References: <20240128070614.7702-1-seashell11234455@gmail.com>
 <20240128070614.7702-4-seashell11234455@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240128070614.7702-4-seashell11234455@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5I7fXL8K6aIaXEGw+aJuAjemB6xDPxB+VSoxPDBHkczf+Cq1QyQ
 ++vob4trbOZyA9htqKzggL7+H2M+4hbCjgdbh+hFozu/OBCcOVA6Ir3ZfXTWHmvBVVWplEY
 pA32ppgCCfVwn8sMpODurN5aV7skiRZdHx6HvVpCbf0AdvWJG/lrKR9C/bpQxyYVcLkLUWB
 3hiT0SytetaWoUsQoI8wA==
UI-OutboundReport: notjunk:1;M01:P0:U7s0WT668CE=;cALbD7pHRoDCcvhZ7GxAjLOBA4Z
 rREP04+q64AgCY+FayT/e3UFqG9dPiu+VIb49ZTixldW/6IXre1QvDzFfN9aZibfF06eaxLhK
 ce6EwklCGu5kVjCR28aYopGotodi16rZfe2epZtE0pPxA0DnvwQlKLRZBJGUpnPt0icuaOK/y
 KEdmlBXFgP+nYOrzeRteOcFlgza0UtUZUCjYAB3hv6EEWRgULhqXEsMJAk+uvSuxjWZ3yKXCq
 2zqM0FBaKrtZldLZZukX9mR2wrJtytGsmoRyQqSwGwMi9Pe7ZWTyHOmR2C5agt3XJFV9IX4pT
 ky7C3sFWFAIRqtp9/XdzfO91ZUtnLrkGJgGSIcGNvFv2cYrkzpi5TYpWanvgl1KaCHYykn2jy
 mkdfvoQurB8oqJfSJsDExexCowlztUDMOpKHu0XRN5MxHHJvLxGxm80o4DuDR8p/I6RWybePu
 ydNUBH6PRnk8jrIekcTNrDw4rjVNeZrTIUXddG8G5cN2gmpANFzDqZAk66FcpMkz2Q/UjBZ5x
 SmT4Vh1gLSBavsc3zz7ZVBq85YPA5qWpxFUhwL+5bfgNtkLZv2SQCXR+BfJR3FNu2NyYk3gZK
 cHm6SpvKpX1gSJoF53J/VcxaB47EgA4mxSncKQYWSxWA4unvJn1Kb5lE0SZYYn6EvJfyd/ibv
 UKaLJ3uvKG3NTS81lDg5fQIRVMhqILzLz32rHpVTKUPZVkEkDxTN6cT9hGgUD+f8suzH/lBcA
 YOj/UAf4HtrSMB2GK/wULC7XIN5DHOTPSs6hsiHuTDpCH6qs4dB1lT9IZb0oUKWKv6YQ/LNaF
 RicNej2fPSw3UtFG7LF9XtzBTHlpW7jLPCh492XyMXMB+FmhmmEN4crM2Cw2MADnXoaABh3Jn
 koeMj9gNzREcuyqqf7dCI/EKj4u5+rHd0i7+QURUo9TQ5yFqw8bD7vs8XMg74GsxvJ3v1WGf1
 TtP5mNWdvE1RzqGmtfrAO0VZS7c=
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

On 1/28/24 08:05, Kongyang Liu wrote:
> Add document for Milk-V Duo board which based on Sophgo's CV1800B SoC.
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add brief description of the procedure to run u-boot-dtb.bin
>
>   doc/board/index.rst            |  1 +
>   doc/board/sophgo/index.rst     |  8 +++++
>   doc/board/sophgo/milkv_duo.rst | 64 ++++++++++++++++++++++++++++++++++
>   3 files changed, 73 insertions(+)
>   create mode 100644 doc/board/sophgo/index.rst
>   create mode 100644 doc/board/sophgo/milkv_duo.rst
>
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index c96e5fda28..d0f9f355d2 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -46,6 +46,7 @@ Board-specific doc
>      sifive/index
>      sipeed/index
>      socionext/index
> +   sophgo/index
>      st/index
>      starfive/index
>      ste/index
> diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
> new file mode 100644
> index 0000000000..e097afdac6
> --- /dev/null
> +++ b/doc/board/sophgo/index.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Sophgo
> +=3D=3D=3D=3D=3D=3D
> +.. toctree::
> +   :maxdepth: 1
> +
> +   milkv_duo
> diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo=
.rst
> new file mode 100644
> index 0000000000..cb2ed1ad98
> --- /dev/null
> +++ b/doc/board/sophgo/milkv_duo.rst
> @@ -0,0 +1,64 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Milk-V Duo
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +CV1800B RISC-V SoC
> +------------------
> +The CV1800B is a high-performance, low-power 1+1 64-bit RISC-V SoC from=
 Sophgo.
> +
> +Mainline support
> +----------------
> +The support for following drivers are already enabled:
> +1. ns16550 UART Driver.
> +
> +Building
> +~~~~~~~~
> +1. Add the RISC-V toolchain to your PATH.
> +2. Setup ARCH & cross compilation environment variable:
> +
> +.. code-block:: console
> +
> +   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
> +   cd <U-Boot-dir>
> +   make milkv_duo_defconfig
> +   make
> +
> +This will generate u-boot-dtb.bin
> +
> +Booting
> +~~~~~~~
> +Currently, we rely on vendor FSBL(First Stage Boot Loader) to initializ=
e the
> +clock and load the u-boot image, then bootup from it.
> +
> +Alternatively, to run u-boot-dtb.bin on top of FSBL, follow these steps=
:
> +
> +1. Use the vendor-provided tool to create a unified fip.bin file contai=
ning
> +   FSBL, OpenSBI, and U-Boot.

Hello Kongyang,

thank you for providing a documentation for the board.

Concerning the usage of fip.bin it would be helpful to add more detail:

* From where can the vendor code be downloaded?
* Which are the commands to execute?

Best regards

Heinrich

> +
> +2. Place the generated fip.bin file into the FAT partition of the SD ca=
rd.
> +
> +3. Insert the SD card into the board and power it on.
> +
> +The board will automatically execute the FSBL from the fip.bin file.
> +Subsequently, it will transition to OpenSBI, and finally, OpenSBI will =
invoke
> +U-Boot.
> +
> +
> +Sample boot log from Milk-V Duo board
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +   U-Boot 2024.01-rc5-00010-g51965baa36 (Dec 28 2023 - 13:15:53 +0800)m=
ilkv_duo
> +
> +   DRAM:  63.3 MiB
> +   Core:  10 devices, 8 uclasses, devicetree: separate
> +   Loading Environment from nowhere... OK
> +   In:    serial@4140000
> +   Out:   serial@4140000
> +   Err:   serial@4140000
> +   Net:   No ethernet found.
> +   milkv_duo# cpu detail
> +     0: cpu@0      rv64imafdc
> +      ID =3D 0, freq =3D 0 Hz: L1 cache, MMU
> +   milkv_duo#

