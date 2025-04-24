Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE3EC369D7
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 20:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3CD0809D4;
	Thu, 24 Apr 2025 22:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330F180BA8; Thu, 24 Apr 2025 22:26:33 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC1E8056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 22:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.25.173])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id BFBDFB4C1B1C;
 Thu, 24 Apr 2025 22:26:27 +0200 (CEST)
Message-ID: <e5e68920-cfa4-48f0-ba3a-301cf30c5eef@freeshell.de>
Date: Thu, 24 Apr 2025 13:26:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] doc: add DeepComputing FML13V01 documentation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
 <20250424121315.144549-6-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250424121315.144549-6-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Overall I think this patch is acceptable as-is and I'll be willing to
make a later series with my suggestions; it's documentation so it is
never really completed, I think, and I spend an hour or two editing then
decide that what I want to do is its own other series. None of the what
I'd like to suggest here should delay a PR for this series.

On 4/24/25 05:13, Heinrich Schuchardt wrote:
> Describe building U-Boot for the board and booting.
> 
> Carve out common information for JH7110 boards into an include.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
> 	Correct the description of booting JH7110 boards from eMMC
> v3:
> 	rebased
> v2:
> 	carve out common information for JH7110 boards into an include
> ---
>  doc/board/starfive/deepcomputing_fml13v01.rst | 80 +++++++++++++++++
>  doc/board/starfive/index.rst                  |  1 +
>  doc/board/starfive/jh7110_common.rst          | 89 +++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
>  create mode 100644 doc/board/starfive/jh7110_common.rst
> 
> diff --git a/doc/board/starfive/deepcomputing_fml13v01.rst b/doc/board/starfive/deepcomputing_fml13v01.rst
> new file mode 100644
> index 00000000000..5d9612483b4
> --- /dev/null
> +++ b/doc/board/starfive/deepcomputing_fml13v01.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +DeepComputing Framework Motherboard (FLM13V01)
> +==============================================
> +
> +The DeepComputing Framework motherboard (FLM13V01) can be combined with a
> +13 inch Framework laptop chassis to provide a complete laptop.
> +
> +U-Boot for the board uses the same binaries as the VisionFive 2 board.
> +Currently only serial console output is supported by mainline U-Boot.
> +
> +Building
> +--------
> +
> +Setup the cross compilation environment variable:
> +
> +.. code-block:: bash
> +
> +   export CROSS_COMPILE=riscv64-linux-gnu-
> +
> +The M-mode software OpenSBI provides the supervisor binary interface (SBI) and
> +is responsible for the switch to S-Mode. It is a prerequisite for building
> +U-Boot. Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended
> +to use a current release.
> +
> +.. code-block:: bash
> +
> +    git clone https://github.com/riscv/opensbi.git
> +    cd opensbi
> +    make PLATFORM=generic FW_TEXT_START=0x40000000 FW_OPTIONS=0
> +    export OPENSBI="$(pwd)/build/platform/generic/firmware/fw_dynamic.bin"
> +
> +Now build U-Boot SPL and main U-Boot.
> +
> +.. code-block:: bash
> +
> +    cd <U-Boot-dir>
> +    make starfive_visionfive2_defconfig
> +    make
> +
> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
> +as the FIT image (u-boot.itb) with OpenSBI, U-Boot, and device-trees.
> +
> +Device-tree selection
> +---------------------
> +
> +The product ID stored in the board EEPROM is used by U-Boot SPL to select the
> +right configuration and device-tree from the u-boot.itb FIT image.
> +
> +Furthermore if variable $fdtfile has not been saved in the environment it is
> +set based on the product ID to *starfive/jh7110-deepcomputing-fml13v01.dtb*.
> +
> +To overrule this default the variable can be set manually and saved in the
> +environment
> +
> +.. code-block:: console
> +
> +    setenv fdtfile my_device-tree.dtb
> +    env save
> +
> +Power switch
> +------------
> +
> +A tiny power switch is located in right upper corner of the board.
> +
> +Open case detection
> +-------------------
> +
> +The board has an open case detection switch. Red lights will flash and the
> +board will not boot if the switch is not held down.
> +
> +UART
> +----
> +
> +UART 0 is exposed via the side channel contacts SBU1 and SBU2 of the lower,
> +right USB C connector. A USB C cable and a breakout board are needed for
> +physical access. It depends on the cable orientation on which of SBU1 and SBU2
> +you will find RX and TX. The signal voltage is 3.3 V. The baud rate is 115200.
> +
> +.. include:: jh7110_common.rst
> diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
> index 2cba1b6dc56..66abc6f9d98 100644
> --- a/doc/board/starfive/index.rst
> +++ b/doc/board/starfive/index.rst
> @@ -6,6 +6,7 @@ StarFive
>  .. toctree::
>     :maxdepth: 1
>  
> +   deepcomputing_fml13v01
>     milk-v_mars
>     pine64_star64
>     visionfive2
> diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
> new file mode 100644
> index 00000000000..fb8d87a1551
> --- /dev/null
> +++ b/doc/board/starfive/jh7110_common.rst
> @@ -0,0 +1,89 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Boot source selection
> +---------------------
> +
> +The board provides DIP switches to select the device for loading the boot
> +firmware.
> +
> +=========== === ===
> +Boot source SW1 SW2
> +=========== === ===
> +UART        OFF OFF
> +SD-card     ON  OFF
> +eMMC        OFF ON
> +SPI flash   ON  ON
> +=========== === ===
> +
> +Flashing a new U-Boot version
> +-----------------------------
> +
> +U-Boot SPL is provided as file spl/u-boot-spl.bin.normal.out. Main U-Boot is
> +in file u-boot.itb.
> +
> +Assuming your new U-Boot version is on partition 1 of an SD-card you could
> +install it to the SPI flash with:
> +
> +.. code-block:: console
> +
> +    sf probe
> +    load mmc 1:1 $kernel_addr_r u-boot-spl.bin.normal.out
> +    sf update $kernel_addr_r 0 $filesize
> +    load mmc 1:1 $kernel_addr_r u-boot.itb
> +    sf update $kernel_addr_r 0x100000 $filesize
> +
> +For loading the files from a TFTP server refer to the dhcp and tftpboot
> +commands.
> +
> +After updating U-Boot you may want to erase a saved environment and reboot.
> +
> +.. code-block:: console
> +
> +    env erase
> +    reset
> +
> +Booting from SD-Card
> +--------------------
> +
> +The device boot ROM loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
> +partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
> +to choose any partition number.
> +
> +With the default configuration U-Boot SPL loads the U-Boot FIT image
> +(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
> +When formatting it is recommended to use GUID
> +BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
> +
> +Booting from eMMC
> +-----------------
> +
> +The device boot ROM tries to load U-Boot SPL (u-boot-spl.bin.normal.out) from
> +sector 0 of the eMMC's main hardware partition. But this conflicts with GPT
> +partitioning. Fortunately eMMC can alternatively load U-Boot SPL from a backup
> +position.
> +
> +For U-Boot SPL (u-boot-spl.bin.normal.out) starting at sector 2048 (position
> +0x100000) write the following bytes to the eMMC device after GPT partitioning:
> +
> +======= ========================
> +Address Bytes
> +======= ========================
> +0x0000  40 02 00 00  00 00 10 00
> +0x0290  40 02 00 00  00 00 10 00
> +======= ========================
> +
> +With the default configuration U-Boot SPL loads the U-Boot FIT image
> +(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
> +When formatting it is recommended to use GUID
> +BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
> +
> +Booting from UART
> +-----------------
> +
> +The boot ROM supports the X-modem protocol to upload
> +spl/u-boot-spl.bin.normal.out. U-Boot SPL support loading the FIT image
> +u-boot.itb via the Y-modem protocol.
> +
> +Due to restrictions of the boot ROM not all X-modem implementations are
> +compatible. The package tio (https://github.com/tio/tio) has been found to be
> +usable.

JH7110 Boot User Guide says "Since document release 1.2, boot from SD
Card or eMMC is no longer recommended. But to maintain the code
structure, the following SD/eMMC boot address allocations are modified
as "reserved". Be aware of this change when designing your device based
on JH7110." [1]

1:https://doc-en.rvspace.org/VisionFive2/Developer_Guide/JH7110_Boot_UG.pdf

So this is important we preserve documentation how SD-card and eMMC Boot
source modes can be prepared that are since dropped from official
documentation. Yet on my patch for bootph-pre-ram device-tree hints to
LKML there is Hal (StarFive) and some other people that want this
functionality of SD-card and eMMC boot to remain working in U-Boot even
though it's recommended against and dropped from official StarFive
documentation.

I don't know, which is it? This appears to be an academic exercise to
make those deprecated boot modes working. It certainly belongs in
jh7110_common.rst as something interesting the hardware may be capable
of, but not as the recommended standard operating procedure.

@ Hal can you describe what the JH7110 boot code is doing for SD-card
and eMMC Boot modes? What magic numbers and logic is this process? If
you want these boot modes to be functional then please help with the
documentation here that is now deleted from StarFive officially.

With that,

Reviewed-by: E Shattow <e@freeshell.de>
