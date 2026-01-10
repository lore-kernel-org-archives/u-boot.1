Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E73D277C1
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 00:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C2F843E8;
	Sat, 10 Jan 2026 01:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85164843FB; Sat, 10 Jan 2026 01:24:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EFEF0843E6
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 01:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 017AEFEC;
 Fri,  9 Jan 2026 16:24:10 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79E853F5A1;
 Fri,  9 Jan 2026 16:24:14 -0800 (PST)
Date: Sat, 10 Jan 2026 01:23:13 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "J. =?UTF-8?B?TmV1c2Now6RmZXI=?= via B4 Relay"
 <devnull+j.ne.posteo.net@kernel.org>
Cc: j.ne@posteo.net, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Peter Geis <pgwipeout@gmail.com>, Lukasz Majewski
 <lukma@denx.de>, Junhui Liu <junhui.liu@pigmoral.tech>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, linux-sunxi <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH next v2] board: amediatech: Add X96Q support
Message-ID: <20260110012313.6fa04c9e@minigeek.lan>
In-Reply-To: <20260110-x96q-v2-1-1d6a725eb825@posteo.net>
References: <20260110-x96q-v2-1-1d6a725eb825@posteo.net>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sat, 10 Jan 2026 00:10:32 +0100
J. Neusch=C3=A4fer via B4 Relay <devnull+j.ne.posteo.net@kernel.org> wrote:

Hi,

many thanks for sending this!
CC:ing the sunxi list for better visibility.
New board support is mostly a matter for the people interested in the
SoC family, less so for the general U-Boot audience.

> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
>=20
> The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> output, and infrared input.
>=20
>   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
>=20
> This commit adds a defconfig and some documentation. The devicetree is
> already in dts/upstream.
>=20
> The CONFIG_DRAM_SUNXI_* settings are chosen such that the register
> values in the DRAM PHY's MMIO space are as close as possible to those
> observed when booting with the preinstalled vendor U-Boot. The DRAM
> clock frequency of 600 MHz was reported in the vendor U-Boot's output.
>=20
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
> ---
> Changes in v2:
> - Add missing Signed-off-by
> - Re-generate x96q_defconfig with 'make savedefconfig'
> - Move DRAM frequency comment to commit message
> - Use GPL-2.0-or-later instead of deprecated GPL-2.0+
> - Link to v1: https://lore.kernel.org/r/20251231-x96q-v1-1-316d703b8f03@p=
osteo.net
> ---
>  configs/x96q_defconfig         | 31 +++++++++++++++++++++++
>  doc/board/amediatech/index.rst |  9 +++++++
>  doc/board/amediatech/x96q.rst  | 57 ++++++++++++++++++++++++++++++++++++=
++++++
>  doc/board/index.rst            |  1 +
>  4 files changed, 98 insertions(+)
>=20
> diff --git a/configs/x96q_defconfig b/configs/x96q_defconfig
> new file mode 100644
> index 00000000000..b74a1b61f3c
> --- /dev/null
> +++ b/configs/x96q_defconfig
> @@ -0,0 +1,31 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_SUNXI=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"allwinner/sun50i-h313-x96q"
> +CONFIG_DRAM_CLK=3D600
> +CONFIG_SPL=3Dy
> +CONFIG_DRAM_SUNXI_DX_ODT=3D0x03030303
> +CONFIG_DRAM_SUNXI_DX_DRI=3D0x0e0e0e0e
> +CONFIG_DRAM_SUNXI_CA_DRI=3D0x1f12
> +CONFIG_DRAM_SUNXI_TPR0=3D0xc0001002
> +CONFIG_DRAM_SUNXI_TPR2=3D0x00000100
> +CONFIG_DRAM_SUNXI_TPR10=3D0x002f0107
> +CONFIG_DRAM_SUNXI_TPR11=3D0xddddcccc
> +CONFIG_DRAM_SUNXI_TPR12=3D0xeddc7665
> +CONFIG_MACH_SUN50I_H616=3Dy
> +CONFIG_SUNXI_DRAM_H616_DDR3_1333=3Dy
> +CONFIG_R_I2C_ENABLE=3Dy
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_FIT_BEST_MATCH=3Dy

What is this for, exactly?

> +CONFIG_SPL_I2C=3Dy
> +CONFIG_CMD_UFETCH=3Dy
> +CONFIG_CMD_CAT=3Dy

Can you please drop those two commands? A defconfig is meant to provide
some low level common configuration, enabling the features that are
needed to boot. Command support should only be selected in the
defconfig if it has a special meaning or requirement for this
board.

> +CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> +CONFIG_SYS_I2C_MVTWSI=3Dy
> +CONFIG_SYS_I2C_SLAVE=3D0x7f
> +CONFIG_SYS_I2C_SPEED=3D400000
> +CONFIG_SUPPORT_EMMC_BOOT=3Dy
> +CONFIG_SUN8I_EMAC=3Dy
> +CONFIG_AXP305_POWER=3Dy
> +CONFIG_USB_EHCI_HCD=3Dy
> +CONFIG_USB_OHCI_HCD=3Dy
> +CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT=3Dy

What is this needed for?

> diff --git a/doc/board/amediatech/index.rst b/doc/board/amediatech/index.=
rst

What does this file add on top of doc/board/allwinner/sunxi.rst?
In general we do not use board/<vendor> directories for Allwinner
boards, not for code, and not for documentation.
So can you please just drop this file and the amediatech entry below?

But you would need to add an entry into board/sunxi/MAINTAINERS,
otherwise the U-Boot CI will fail.

Cheers,
Andre

> new file mode 100644
> index 00000000000..fd0241e3459
> --- /dev/null
> +++ b/doc/board/amediatech/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Amediatech
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   x96q
> diff --git a/doc/board/amediatech/x96q.rst b/doc/board/amediatech/x96q.rst
> new file mode 100644
> index 00000000000..f220b7005b2
> --- /dev/null
> +++ b/doc/board/amediatech/x96q.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +U-Boot for the Amediatech X96Q set-top box
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Quick Start
> +-----------
> +
> +- Get and Build the ARM Trusted Firmware (TF-A)
> +- Build U-Boot
> +- Write U-Boot to a microSD card
> +- Boot
> +
> +Get and Build the ARM Trusted Firmware (TF-A)
> +---------------------------------------------
> +
> +.. code-block:: bash
> +
> +    $ echo "Downloading and building TF-A..."
> +    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.=
git
> +    $ cd trusted-firmware-a
> +
> +Then build TF-A:
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=3Daarch64-linux-gnu-
> +    $ make PLAT=3Dsun50i_h616 bl31
> +    $ cp build/sun50i_h616/release/bl31.bin ../
> +
> +Build U-Boot
> +------------
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=3Daarch64-none-elf-
> +    $ make x96q_defconfig
> +    $ make
> +
> +After the build succeeds, you will obtain the final ``u-boot-sunxi-with-=
spl.bin``
> +image, which you can then write to a microSD card.
> +
> +Write U-Boot to a microSD card
> +------------------------------
> +
> +You can then flash U-Boot to the microSD card (replace ``/dev/sdX`` with=
 the
> +card's device file):
> +
> +.. code-block:: bash
> +
> +    $ dd if=3Du-boot-sunxi-with-spl.bin of=3D/dev/sdX bs=3D8k seek=3D1
> +
> +Boot
> +----
> +
> +When the X96Q is booted with the prepared microSD card inserted, it shou=
ld boot
> +into the freshly installed U-Boot.
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index 7870f1bc246..767e1831912 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -9,6 +9,7 @@ Board-specific doc
>     acer/index
>     actions/index
>     advantech/index
> +   amediatech/index
>     andestech/index
>     allwinner/index
>     amlogic/index
>=20
> ---
> base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> change-id: 20251231-x96q-998c1376ebbf
>=20
> Best regards,

