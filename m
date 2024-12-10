Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E555E7717D
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 02:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D584289723;
	Tue, 10 Dec 2024 03:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEE4A897A0; Tue, 10 Dec 2024 03:30:37 +0100 (CET)
Received: from smtp.gentoo.org (smtp.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0093189723
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 03:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Date: Tue, 10 Dec 2024 10:30:28 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Huan Zhou <pericycle.cc@gmail.com>
Cc: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH v5 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3
 board
Message-ID: <20241210023028-GYB1905152@gentoo>
References: <20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com>
 <20241209-pickup-bpif3-v5-2-92f801b7c6c1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-pickup-bpif3-v5-2-92f801b7c6c1@gmail.com>
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

Hi Huan:

On 10:00 Mon 09 Dec     , Huan Zhou wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
> 
> Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> ---
>  doc/board/index.rst                |  1 +
>  doc/board/spacemit/bananapi-f3.rst | 86 ++++++++++++++++++++++++++++++++++++++
>  doc/board/spacemit/index.rst       |  9 ++++
>  3 files changed, 96 insertions(+)
> 
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index 417c128c7af6ad2267ef1bc743c7f10ae70b6de7..367da2d62316d4cab25ecc53f852ef742eba13dd 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -51,6 +51,7 @@ Board-specific doc
>     sipeed/index
>     socionext/index
>     sophgo/index
> +   spacemit/index
>     st/index
>     starfive/index
>     ste/index
> diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bananapi-f3.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..98a1b1d91daa897508762267e8363e7d98a0c5d0
> --- /dev/null
> +++ b/doc/board/spacemit/bananapi-f3.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Banana Pi BPI-F3
> +============
> +
> +Building
> +~~~~~~~~
> +1. Install the spacemit riscv cross compile toolchain_, or skip it if riscv toolchain is installed.
> +
> +.. _toolchain: https://archive.spacemit.com/toolchain/
> +
> +2. Setup cross compilation environment variable:
> +
> +.. code-block:: console
> +
> +   export CROSS_COMPILE=<riscv64 toolchain prefix, e.g /opt/spacemit/bin/riscv64-unknown-linux-gnu->
> +
> +3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
> +built for SpacemiT K1 SoC as below:
> +
> +.. code-block:: console
> +
> +   git clone https://github.com/cyyself/opensbi -b k1-opensbi
> +   cd opensbi
> +   make PLATFORM=generic
> +
> +4. Then build U-Boot as following:
> +
> +.. code-block:: console
> +
> +   cd <U-Boot-dir>
> +   make bananapi-f3_defconfig
> +   make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
> +
> +This will generate u-boot.itb
> +
> +Booting
replace it with "Burning" or "Flashing"? which document how we burn the
uboot image into storage media
> +~~~~~~~
> +Actually, we can replace the uboot part from bianbu linux which is the bsp_ to validate this patch,
> +use `balena etcher` to burn the bianbu-minimal.img to the sd card,
> +and replace the /dev/sdx4 where places the uboot_ with the `u-boot.itb` generated from this patch.
> +
> +.. _bsp: https://archive.spacemit.com/image/k1/version/bianbu/v2.0/
> +.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
the procedure above is too complicated and obscure.. I would suggest to use fastboot,
here is what I've tested on milkv jupitor board which burn the fw to spi nor flash,
it can be flashed to emmc/sd card, and should be smiliar on BPI F3 board.

collect FSBL.bin, u-boot.itb,  partition_2M.json, bootinfo_spinor.bin
u-boot-env-default.bin, fw_dynamic.itb from vendor sdk

fastboot stage FSBL.bin
fastboot continue
fastboot stage u-boot.itb-vendor # the itb from vendor uboot
fastboot continue

fastboot flash mtd partition_2M.json
fastboot flash bootinfo bootinfo_spinor.bin
fastboot flash fsbl FSBL.bin
fastboot flash env u-boot-env-default.bin
fastboot flash opensbi fw_dynamic.itb

fastboot flash uboot u-boot.itb-mainline # the itb from mainline uboot


> +
move "Booting:" here
> +Sample boot log from Banana Pi BPI-F3 board
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +   try sd...
> +   bm:3
> +   j...
> +
> +   U-Boot SPL 2022.10spacemit-dirty (Oct 21 2024 - 09:01:13 +0000)
> +   [   0.279] DDR type LPDDR4X
> +   [   0.292] lpddr4_silicon_init consume 13ms
> +   [   0.293] Change DDR data rate to 2400MT/s
> +   [   0.430] ## Checking hash(es) for config conf-1 ... OK
> +   [   0.432] ## Checking hash(es) for Image opensbi ... OK
> +   [   0.437] ## Checking hash(es) for Image uboot ... OK
> +   [   0.443] ## Checking hash(es) for Image fdt-1 ... OK
> +   [   0.488] ## Checking hash(es) for config config_1 ... OK
> +   [   0.490] ## Checking hash(es) for Image opensbi ... crc32+ OK
> +
> +
> +   U-Boot 2024.10-rc4-00462-g5b138cfcc587-dirty (Nov 28 2024 - 14:56:49 +0800)
> +
> +   DRAM:  4 GiB
> +   Core:  19 devices, 8 uclasses, devicetree: separate
> +   Loading Environment from nowhere... OK
> +   In:    serial@d4017000
> +   Out:   serial@d4017000
> +   Err:   serial@d4017000
> +   Net:   No ethernet found.
> +   => cpu list
> +   0: cpu@0      spacemit,x60
> +   1: cpu@1      spacemit,x60
> +   2: cpu@2      spacemit,x60
> +   3: cpu@3      spacemit,x60
> +   4: cpu@4      spacemit,x60
> +   5: cpu@5      spacemit,x60
> +   6: cpu@6      spacemit,x60
> +   7: cpu@7      spacemit,x60
> +   => test
> +   =>
> +
> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..e7d3d94e4599fbeb8da16c8a837e777a0be06227
> --- /dev/null
> +++ b/doc/board/spacemit/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +SpacemiT
> +========
> +.. toctree::
> +   :maxdepth: 1
> +
> +   bananapi-f3
> +
> 
> -- 
> 2.39.5
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
