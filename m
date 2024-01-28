Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6269FC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 15:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E29187E48;
	Sun, 28 Jan 2024 16:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B9B87E81; Sun, 28 Jan 2024 16:05:24 +0100 (CET)
Received: from smtp.gentoo.org (dev.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89E787DED
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 16:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Date: Sun, 28 Jan 2024 15:05:09 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kongyang Liu <seashell11234455@gmail.com>, Adam Ford <aford173@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Fabio Estevam <festevam@denx.de>, Nishanth Menon <nm@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 3/3] doc: sophgo: milkv_duo: document Milk-V Duo board
Message-ID: <20240128150509.GA3546240@ofsar>
References: <20240128070614.7702-1-seashell11234455@gmail.com>
 <20240128070614.7702-4-seashell11234455@gmail.com>
 <2acf8505-315e-486d-a07d-c91fddfe6671@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acf8505-315e-486d-a07d-c91fddfe6671@gmx.de>
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

Hi Heinrich S


On 10:16 Sun 28 Jan     , Heinrich Schuchardt wrote:
> On 1/28/24 08:05, Kongyang Liu wrote:
> > Add document for Milk-V Duo board which based on Sophgo's CV1800B SoC.
> >
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> >
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - Add brief description of the procedure to run u-boot-dtb.bin
> >
> >   doc/board/index.rst            |  1 +
> >   doc/board/sophgo/index.rst     |  8 +++++
> >   doc/board/sophgo/milkv_duo.rst | 64 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 73 insertions(+)
> >   create mode 100644 doc/board/sophgo/index.rst
> >   create mode 100644 doc/board/sophgo/milkv_duo.rst
> >
> > diff --git a/doc/board/index.rst b/doc/board/index.rst
> > index c96e5fda28..d0f9f355d2 100644
> > --- a/doc/board/index.rst
> > +++ b/doc/board/index.rst
> > @@ -46,6 +46,7 @@ Board-specific doc
> >      sifive/index
> >      sipeed/index
> >      socionext/index
> > +   sophgo/index
> >      st/index
> >      starfive/index
> >      ste/index
> > diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
> > new file mode 100644
> > index 0000000000..e097afdac6
> > --- /dev/null
> > +++ b/doc/board/sophgo/index.rst
> > @@ -0,0 +1,8 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Sophgo
> > +======
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   milkv_duo
> > diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo.rst
> > new file mode 100644
> > index 0000000000..cb2ed1ad98
> > --- /dev/null
> > +++ b/doc/board/sophgo/milkv_duo.rst
> > @@ -0,0 +1,64 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Milk-V Duo
> > +==========
> > +
> > +CV1800B RISC-V SoC
> > +------------------
> > +The CV1800B is a high-performance, low-power 1+1 64-bit RISC-V SoC from Sophgo.
> > +
> > +Mainline support
> > +----------------
> > +The support for following drivers are already enabled:
> > +1. ns16550 UART Driver.
> > +
> > +Building
> > +~~~~~~~~
> > +1. Add the RISC-V toolchain to your PATH.
> > +2. Setup ARCH & cross compilation environment variable:
> > +
> > +.. code-block:: console
> > +
> > +   export CROSS_COMPILE=<riscv64 toolchain prefix>
> > +   cd <U-Boot-dir>
> > +   make milkv_duo_defconfig
> > +   make
> > +
> > +This will generate u-boot-dtb.bin
> > +
> > +Booting
> > +~~~~~~~
> > +Currently, we rely on vendor FSBL(First Stage Boot Loader) to initialize the
> > +clock and load the u-boot image, then bootup from it.
> > +
> > +Alternatively, to run u-boot-dtb.bin on top of FSBL, follow these steps:
> > +
> > +1. Use the vendor-provided tool to create a unified fip.bin file containing
> > +   FSBL, OpenSBI, and U-Boot.
> 
> Hello Kongyang,
> 
> thank you for providing a documentation for the board.
> 
> Concerning the usage of fip.bin it would be helpful to add more detail:
> 
> * From where can the vendor code be downloaded?
..

> * Which are the commands to execute?
for fip.bin, which is located inside the first vfat partition of SD card, it will
be parsed & loaded & excuted by ROM after power on (haven't looked too deep into this)

also the fip.bin image is a combination of FSBL+DDR param+ATF?/OpenSBI+U-boot
please see the link below if you're interested
 https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/fsbl/plat/cv180x/fiptool.py#L201

> 
> Best regards
> 
> Heinrich
> 
> > +
> > +2. Place the generated fip.bin file into the FAT partition of the SD card.
> > +
> > +3. Insert the SD card into the board and power it on.
> > +
> > +The board will automatically execute the FSBL from the fip.bin file.
> > +Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
> > +U-Boot.
> > +
> > +
> > +Sample boot log from Milk-V Duo board
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +.. code-block:: none
> > +
> > +   U-Boot 2024.01-rc5-00010-g51965baa36 (Dec 28 2023 - 13:15:53 +0800)milkv_duo
> > +
> > +   DRAM:  63.3 MiB
> > +   Core:  10 devices, 8 uclasses, devicetree: separate
> > +   Loading Environment from nowhere... OK
> > +   In:    serial@4140000
> > +   Out:   serial@4140000
> > +   Err:   serial@4140000
> > +   Net:   No ethernet found.
> > +   milkv_duo# cpu detail
> > +     0: cpu@0      rv64imafdc
> > +      ID = 0, freq = 0 Hz: L1 cache, MMU
> > +   milkv_duo#

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
