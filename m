Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3ABE77160
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 00:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E42B8940F;
	Wed,  4 Dec 2024 01:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AEF389420; Wed,  4 Dec 2024 01:58:24 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 165FA88FAF
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 01:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Date: Wed, 4 Dec 2024 08:58:08 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, u-boot@lists.denx.de,
 Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?utf-8?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH v4 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3
 board
Message-ID: <20241204005808-GYA559515@gentoo>
References: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
 <20241129-pickup-bpif3-v4-2-e99fabf66e33@gmail.com>
 <ad100a4f673759559a6047083713d379847894cb.camel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad100a4f673759559a6047083713d379847894cb.camel@ziswiler.com>
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

Hi Marcel, Huan

On 18:52 Tue 03 Dec     , Marcel Ziswiler wrote:
> Hi Huan Zhou 
> 
> On Fri, 2024-11-29 at 13:37 +0800, Huan Zhou wrote:
> > From: Kongyang Liu <seashell11234455@gmail.com>
> > 
> > Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
> > 
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> > ---
> >  doc/board/index.rst                |  1 +
> >  doc/board/spacemit/bananapi-f3.rst | 86 ++++++++++++++++++++++++++++++++++++++
> >  doc/board/spacemit/index.rst       |  8 ++++
> >  3 files changed, 95 insertions(+)
> > 
> > diff --git a/doc/board/index.rst b/doc/board/index.rst
> > index 417c128c7af6ad2267ef1bc743c7f10ae70b6de7..367da2d62316d4cab25ecc53f852ef742eba13dd 100644
> > --- a/doc/board/index.rst
> > +++ b/doc/board/index.rst
> > @@ -51,6 +51,7 @@ Board-specific doc
> >     sipeed/index
> >     socionext/index
> >     sophgo/index
> > +   spacemit/index
> >     st/index
> >     starfive/index
> >     ste/index
> > diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bananapi-f3.rst
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1e6d6ef19be7e25684966bd4a727bd21b147330a
> > --- /dev/null
> > +++ b/doc/board/spacemit/bananapi-f3.rst
> > @@ -0,0 +1,86 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +Banana Pi F3
> 
> Officially they call it Banana Pi BPI-F3.
> 
> > +============
> > +
> > +Building
> > +~~~~~~~~
> > +1. Install the spacemit riscv cross compile toolchain_, or skip it if riscv toolchain is installed.
> 
> I would not use a specific such toolchain but rather a regular RISC-V one e.g.
> 
> https://github.com/riscv-collab/riscv-gnu-toolchain
> 

I think any riscv toolchain should work fine here, as I'm using Gentoo specific riscv toolchain..
so consider it's merely an example provided to demonstrate whole process working

> > +
> > +.. _toolchain: https://archive.spacemit.com/toolchain/
> > +
> > +2. Setup cross compilation environment variable:
> > +
> > +.. code-block:: console
> > +
> > +   export CROSS_COMPILE=<riscv64 toolchain prefix, e.g /opt/spacemit/bin/riscv64-unknown-linux-gnu->
> > +
> > +3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
> > +built for SpacemiT K1 SoC as below:
> > +
> > +.. code-block:: console
> > +
> > +   git clone https://github.com/cyyself/opensbi -b k1-opensbi
> > +   cd opensbi
> > +   make PLATFORM=generic
> 
> What speaks against using regular master opensbi?
> 
no idea if master of opensbi would work here, we can certainly try..
but I think it's another story, as we are focusing on mainlining uboot

FWIK, this branch is generally same version as vendor opensbi, but slightly
 rebase to more recent opensbi version

> > +
> > +4. Then build U-Boot as following:
> > +
> > +.. code-block:: console
> > +
> > +   cd <U-Boot-dir>
> > +   make bananapi-f3_defconfig
> > +   make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
> > +
> > +This will generate u-boot.itb
> > +
> > +Booting
> > +~~~~~~~
> > +Actually, we can replace the uboot part from bianbu linux which is the bsp_ to validate this patch,
> > +use `balena etcher` to burn the bianbu-minimal.img to the sd card, 
> 
> trailing whitespace
> 
> > +and replace the /dev/sdx4 where places the uboot_ with the `u-boot.itb` generated from this patch.
> > +
> > +.. _bsp: https://archive.spacemit.com/image/k1/version/bianbu/v2.0/
> > +.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
> > +
> > +Sample boot log from Banana Pi F3 board
> 
> BPI-F3
> 
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +.. code-block:: none
> > +
> > +   try sd...
> > +   bm:3
> > +   j...
> > +
> > +   U-Boot SPL 2022.10spacemit-dirty (Oct 21 2024 - 09:01:13 +0000)
> > +   [   0.279] DDR type LPDDR4X
> > +   [   0.292] lpddr4_silicon_init consume 13ms
> > +   [   0.293] Change DDR data rate to 2400MT/s
> > +   [   0.430] ## Checking hash(es) for config conf-1 ... OK
> > +   [   0.432] ## Checking hash(es) for Image opensbi ... OK
> > +   [   0.437] ## Checking hash(es) for Image uboot ... OK
> > +   [   0.443] ## Checking hash(es) for Image fdt-1 ... OK
> > +   [   0.488] ## Checking hash(es) for config config_1 ... OK
> > +   [   0.490] ## Checking hash(es) for Image opensbi ... crc32+ OK
> > +
> > +
> > +   U-Boot 2024.10-rc4-00462-g5b138cfcc587-dirty (Nov 28 2024 - 14:56:49 +0800)
> > +
> > +   DRAM:  4 GiB
> 
> I guess it does not yet detect the amount of RAM available.
> 
I would be fine with this, as currently the memory size is hardcoded,
we should work on follow-up patch to auto probe DDR size, and corret it

> > +   Core:  19 devices, 8 uclasses, devicetree: separate
> > +   Loading Environment from nowhere... OK
> > +   In:    serial@d4017000
> > +   Out:   serial@d4017000
> > +   Err:   serial@d4017000
> > +   Net:   No ethernet found.
> > +   => cpu list
> > +   0: cpu@0      spacemit,x60
> > +   1: cpu@1      spacemit,x60
> > +   2: cpu@2      spacemit,x60
> > +   3: cpu@3      spacemit,x60
> > +   4: cpu@4      spacemit,x60
> > +   5: cpu@5      spacemit,x60
> > +   6: cpu@6      spacemit,x60
> > +   7: cpu@7      spacemit,x60
> > +   => test
> > +   => 
> 
> trailing whitespace
> 
> > +
> > diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..3fb7d804ac8fc8dd4c7ee67ffc877f9ad323162d
> > --- /dev/null
> > +++ b/doc/board/spacemit/index.rst
> > @@ -0,0 +1,8 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +SpacemiT
> > +========
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   bananapi-f3
> > 
> 
> new blank line at EOF
> 
> Cheers
> 
> Marcel

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
