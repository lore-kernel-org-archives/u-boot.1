Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3878E7718B
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 00:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCCE58036D;
	Sat, 28 Dec 2024 01:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="PA4MlBkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE2B8036E; Sat, 28 Dec 2024 01:39:52 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC2F80362
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 01:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e3a0acba5feso7382504276.2
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 16:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1735346388; x=1735951188; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFfwD964vipMuq8qgeKF0QfYqYfcmOwlrqh5FQ8Djp4=;
 b=PA4MlBkI/RksmIMwsup+Ptw15GWYNsIZJxpCOJE+xFTNV2J1MOxYW0xhkqRAYRHRK+
 60peKYAnJwrnNKtpo+SD7it0l5VgQP99lDTXdvHkWzgeqpbW8R7EtRSeJKzMGxiTwlip
 ZmAwNFuAC2tCGObs3RTJ3tR3HYfBj215akI7Z1Pis4S4fcKNgXCiaP3M1cseYRTdq8wK
 h2NChdeBRPyZkDapIwH7eQG2casvKIKuyNPrEgvARMa0ckvOV8oMBOC2023y5nCxLQUv
 b7UVHmTMdoi5Bp62AQ5e1Ahg8DrYZIHIKGoZBnIo95WDUzaWD+vn2uNXY608iUSuvBga
 O4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735346388; x=1735951188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rFfwD964vipMuq8qgeKF0QfYqYfcmOwlrqh5FQ8Djp4=;
 b=GToDLKyrU2J0wypLj/fe2iNmxVUhAucEn9bRVj7CXTJeGuTPWS/VZ8ECznbInzBcOc
 wQzvz0GcE3ZNDJUlSXID8k1PDtEqgWe3ctrVIUJgrvU1vDHcRvVuaBI2cJMHnazk5r/N
 4OtdaHtHFHQ+qNnVfalWRIkQChaD+JCSNrNcpNAeWBRUfebCbh8BcleqqlWtybw5h8OA
 0GylqrvLmYWH8mQ+HzfIYVXxTiY/ZjtRJl/+TjzjxaQmdFAF6VJ1Xt1HHqrPeU2S164k
 uYTcZCI7oaCdgavP8D9KBj0zr00G8bI/hhF5ZHLOR4ZId1tcSVywthjs9ozdh/FvFMMr
 Ynww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZRrXZGsWo6/nf6KVu1DvAZOxVTeiT42md/vO3L+vmnaKu+bVDXHrWDHe1nOYdtTNhVTku3fE=@lists.denx.de
X-Gm-Message-State: AOJu0YzbZp7lC3JHYsZSsJbufXcc3/iOkwRpsxlQPs+ooBmQG+zkdqRH
 CmsrgYgB45R8e/8Zm++cWF7jPjBWV/Pz7Yh3WE54rbWg7/7IP3teb7XyHhfg72xgctMCUYC7lQb
 MZv6qymwcY6D93MFXT5tw40CKKbBjmFBeS17U1g==
X-Gm-Gg: ASbGncsw1/recUjngpes5UDrwCa9L5loHK+jyHp9z+91WKyE6Zb7d6XDBfhiojImjcw
 3F7ytyzl18VOXrm0OECYIvAtzw7W3TxxHqas0Fw==
X-Google-Smtp-Source: AGHT+IEAd7ZK4VamAzYe/PUUCuqfKCty4pjIyd/WhjbW4sjnmi/TotB42G12EdZERoOM7Ahs2nhj91PBOxyB09kykGg=
X-Received: by 2002:a05:690c:c8e:b0:6ef:6ec2:ac62 with SMTP id
 00721157ae682-6f3f8116a99mr209819037b3.15.1735346387909; Fri, 27 Dec 2024
 16:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 27 Dec 2024 16:39:36 -0800
Message-ID: <CAJ+vNU16T8Chsdy0+tHy7tCcfKfVGVFUr9baTCH7U4X9v6dFRg@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de,
 marex@denx.de, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Dec 19, 2024 at 6:57=E2=80=AFPM Alice Guo <alice.guo@oss.nxp.com> w=
rote:
>
> From: Ye Li <ye.li@nxp.com>
>
> This patch adds i.MX95 19x19 EVK board basic support.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      | 224 ++++++++++++++++++++=
++++++
>  arch/arm/mach-imx/imx9/Kconfig                |   6 +
>  arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
>  arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 ++
>  arch/arm/mach-imx/imx9/scmi/soc.c             |   1 +
>  board/freescale/imx95_evk/Kconfig             |  12 ++
>  board/freescale/imx95_evk/MAINTAINERS         |   6 +
>  board/freescale/imx95_evk/Makefile            |  11 ++
>  board/freescale/imx95_evk/imx95_19x19_evk.env |  95 +++++++++++
>  board/freescale/imx95_evk/imx95_evk.c         |  54 +++++++
>  board/freescale/imx95_evk/spl.c               | 117 ++++++++++++++
>  configs/imx95_19x19_evk_defconfig             | 178 ++++++++++++++++++++
>  doc/board/nxp/imx95_evk.rst                   | 109 +++++++++++++
>  doc/board/nxp/index.rst                       |   1 +
>  include/configs/imx95_evk.h                   |  36 +++++
>  15 files changed, 875 insertions(+)
>
<snip>
> diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..c2be474aa71f0f8d934f956c8=
840d330fbee98df
> --- /dev/null
> +++ b/doc/board/nxp/imx95_evk.rst
> @@ -0,0 +1,109 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +imx95_evk
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +U-Boot for the NXP i.MX95 19x19 EVK board
> +
> +Quick Start
> +-----------
> +
> +- Get ahab-container.img
> +- Get the DDR PHY Firmware Images
> +- Get and Build OEI Images
> +- Get and Build System Manager Image
> +- Get and Build the ARM Trusted Firmware
> +- Build the Bootloader Image
> +- Boot
> +
> +Get ahab-container.img
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3=
.0-17945fc.bin
> +   $ chmod +x firmware-ele-imx-1.3.0-17945fc.bin
> +   $ ./firmware-ele-imx-1.3.0-17945fc.bin
> +   $ cp firmware-ele-imx-1.3.0-17945fc.bin/mx95a0-ahab-container.img $(s=
rctree)

Hi Alice,

typo here in the path. Should be:
cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctree)

> +
> +Get the DDR PHY Firmware Images
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.26-d4=
c33ab.bin
> +   $ chmod +x firmware-imx-8.26-d4c33ab.bin
> +   $ ./firmware-imx-8.26-d4c33ab.bin
> +   $ cp firmware-imx-8.26-d4c33ab/firmware/ddr/synopsys/lpddr5*v202311.b=
in $(srctree)
> +
> +Get and Build OEI Images
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get OEI from: https://github.com/nxp-imx/imx-oei
> +branch: master

how about just adding a 'git clone https://github.com/nxp-imx/imx-oei
-b master' in your instructions below and update the make/cp to use
imx-oei path?

> +
> +.. code-block:: bash
> +
> +   $ sudo apt -y install make gcc g++-multilib srecord
> +   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel=
1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ export TOOLS=3D$PWD
> +   $ make board=3Dmx95lp5 oei=3Dddr DEBUG=3D1
> +   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
> +
> +   $ make board=3Dmx95lp5 oei=3Dtcm DEBUG=3D1
> +   $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
> +
> +Get and Build System Manager Image
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get System Manager from: https://github.com/nxp-imx/imx-sm
> +branch: master

how about just adding a 'git clone https://github.com/nxp-imx/imx-sm
-b master' in your instructions below and update make/cp to use imx-sm
path?

> +
> +.. code-block:: bash
> +
> +   $ sudo apt -y install make gcc g++-multilib srecord
> +   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel=
1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ export TOOLS=3D$PWD
> +   $ make config=3Dmx95evk all
> +   $ cp build/mx95evk/m33_image.bin $(srctree)
> +
> +Get and Build the ARM Trusted Firmware
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get ATF from: https://github.com/nxp-imx/imx-atf/
> +branch: lf_v2.10

how about just adding a 'git clone https://github.com/nxp-imx/imx-atf
-b lf_v2.10' in your instructions below and update make/cp to use
imx-atf path?

> +
> +.. code-block:: bash
> +
> +   $ unset LDFLAGS

why? where was LDFLAGS set?

> +   $ make PLAT=3Dimx95 bl31

You need to export CROSS_COMPILE before building here

> +   $ cp build/imx95/release/bl31.bin $(srctree)
> +
> +Build the Bootloader Image
> +------------
> +
> +.. code-block:: bash
> +
> +   $ export CROSS_COMPILE=3Daarch64-poky-linux-
> +   $ make imx95_19x19_evk_defconfig
> +   $ make
> +
> +Copy imx-boot-imx95.bin to the MicroSD card:
> +
> +.. code-block:: bash
> +
> +   $ sudo dd if=3Dimx-boot-imx95.bin of=3D/dev/sdb bs=3D1k seek=3D32 con=
v=3Dfsync
> +
> +Boot
> +----
> +
> +Set i.MX95 boot device to MicroSD card

I gave this series a go on top of 5cfbf8c364 origin/next on an EVK I
have here and I saw no u-boot proper output after the ATF.

Here is what I saw on UART2:
U-Boot SPL 2025.01-rc5-00393-g9b292f7d347f (Dec 27 2024 - 16:12:20 -0800)
DDRMIX is powered UP
Normal Boot
Trying to boot from MMC2
Primary set selected
Load image from MMC/SD 0xdec00
NOTICE:  BL31: v2.10.0  (release):lf-6.6.52-2.2.0
NOTICE:  BL31: Built : 16:06:15, Dec 27 2024

U-Boot SPL 2025.01-rc5-00393-g9b292f7d347f (Dec 27 2024 - 16:12:20 -0800)
DDRMIX is powered UP
Normal Boot
Trying to boot from MMC2
Primary set selected
Load image from MMC/SD 0xdec00
NOTICE:  BL31: v2.10.0  (release):lf-6.6.52-2.2.0
NOTICE:  BL31: Built : 16:06:15, Dec 27 2024
^^^ nothing after this

Any thoughts on what is wrong here?

Best Regards,

Tim
