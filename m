Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6776AC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 10:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D15D38760A;
	Fri,  1 Dec 2023 11:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J1rKBtDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB62A8760A; Fri,  1 Dec 2023 11:10:30 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 184BC876A3
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 11:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1AALHX107322;
 Fri, 1 Dec 2023 04:10:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701425421;
 bh=8G7ZC2aYV9cZeanNuiFwSH4cSiS+lX7dtwSBcHXvPrI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=J1rKBtDtmTCM2CsBoWBq3rLUnyKuFmFy+E/RSDfo29WulP7afGYGC2qrkRpBohkdz
 FfbmVL6m9X0fFcNcn1vqSufUSHWigYYtIpxc8dmq6DTWlLmLtu2SV0ttEW1eEe9AXw
 e4bJ8J1SEQx4f7BJfVUKlBwqaNMzpGITNt0IuPpk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1AALHS083466
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Dec 2023 04:10:21 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 04:10:21 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 04:10:21 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1AAKIB059670;
 Fri, 1 Dec 2023 04:10:21 -0600
Date: Fri, 1 Dec 2023 15:40:20 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 2/2] doc: board: phytec: Add phyCORE-AM62x
Message-ID: <20231201101020.uguepgy754fkzntk@dhruva>
References: <20231130115607.2150349-1-w.egorov@phytec.de>
 <20231130115607.2150349-3-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231130115607.2150349-3-w.egorov@phytec.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi,

On Nov 30, 2023 at 12:56:07 +0100, Wadim Egorov wrote:
> Add documentation for PHYTEC phyCORE-AM62x SoM.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
> v2: Rebased on top of -next
> 

Please CC Tom Rini <trini@konsulko.com> on the series.

> ---
>  doc/board/phytec/index.rst         |   1 +
>  doc/board/phytec/phycore-am62x.rst | 125 +++++++++++++++++++++++++++++
>  doc/board/ti/k3.rst                |   1 +
>  3 files changed, 127 insertions(+)
>  create mode 100644 doc/board/phytec/phycore-am62x.rst
> 
> diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
> index a5b442045e..b914cc3fbd 100644
> --- a/doc/board/phytec/index.rst
> +++ b/doc/board/phytec/index.rst
> @@ -6,5 +6,6 @@ PHYTEC
>  .. toctree::
>     :maxdepth: 2
>  
> +   phycore-am62x
>     phycore-imx8mm
>     phycore-imx8mp
> diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
> new file mode 100644
> index 0000000000..46312a73bc
> --- /dev/null
> +++ b/doc/board/phytec/phycore-am62x.rst
> @@ -0,0 +1,125 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Wadim Egorov <w.egorov@phytec.de>
> +
> +phyCORE-AM62x
> +=============
> +
> +The `phyCORE-AM62x <https://www.phytec.com/product/phycore-am62x>`_ is a
> +SoM (System on Module) featuring TI's AM62x SoC. It can be used in combination
> +with different carrier boards. This module can come with different sizes and
> +models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM62x family.
> +
> +A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am62x>`_
> +is used as a carrier board reference design around the AM62x SoM.
> +
> +Quickstart
> +----------
> +
> +* Download sources and TI firmware blobs
> +* Build Trusted Firmware-A
> +* Build OP-TEE
> +* Build U-Boot for the R5
> +* Build U-Boot for the A53
> +* Create bootable uSD Card
> +* Boot
> +
> +Sources
> +-------
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_boot_sources
> +    :end-before: .. k3_rst_include_end_boot_sources
> +
> +Build procedure
> +---------------
> +
> +Setup the environment variables:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_desc
> +    :end-before: .. k3_rst_include_end_common_env_vars_desc
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_board_env_vars_desc
> +    :end-before: .. k3_rst_include_end_board_env_vars_desc
> +
> +Set the variables corresponding to this platform:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_defn
> +    :end-before: .. k3_rst_include_end_common_env_vars_defn
> +.. code-block:: bash
> +
> + $ export UBOOT_CFG_CORTEXR=phycore_am62x_r5_defconfig
> + $ export UBOOT_CFG_CORTEXA=phycore_am62x_a53_defconfig
> + $ export TFA_BOARD=lite
> + $ # we don't use any extra TFA parameters
> + $ unset TFA_EXTRA_ARGS
> + $ export OPTEE_PLATFORM=k3-am62x
> + $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"

Does this need to be the case? If it's just copied from AM62x then I
think I need to fix that documentation, not sure if we necessarily need
SW_RNG and thus disable HW_RNG upstream.

The context here was we were enabling SW_RNG a while back due to a crash
after suspend resume on AM62x, however that issue no longer seems to
cause any lock ups/ crash.

> +
> +.. include::  ../ti/am62x_sk.rst
> +    :start-after: .. am62x_evm_rst_include_start_build_steps
> +    :end-before: .. am62x_evm_rst_include_end_build_steps
> +
> +uSD Card creation
> +-----------------
> +
> +Use fdisk to partition the uSD card. The layout should look similar to:
> +
> +.. code-block:: bash
> +
> + $ sudo fdisk -l /dev/mmcblk0
> + Disk /dev/mmcblk0: 7.56 GiB, 8120172544 bytes, 15859712 sectors
> + Units: sectors of 1 * 512 = 512 bytes
> + Sector size (logical/physical): 512 bytes / 512 bytes
> + I/O size (minimum/optimal): 512 bytes / 512 bytes
> + Disklabel type: dos
> + Disk identifier: 0x6583d9a3
> +
> + Device         Boot  Start     End Sectors   Size Id Type
> + /dev/mmcblk0p1 *      2048  264191  262144   128M  c W95 FAT32 (LBA)
> + /dev/mmcblk0p2      264192 1934953 1670762 815.8M 83 Linux
> +
> +
> +Once partitioned, the boot partition has to be formatted with a FAT filesystem.
> +Assuming the uSD card is `/dev/mmcblk0`:
> +
> +.. code-block:: bash
> +
> + $ mkfs.vfat /dev/mmcblk0p1
> +
> +To boot from an uSD on a GP device simply copy the following artifacts to the

nit: "a" micro SD card not an


Are most of the SoM's GP devices? Otherwise thinking if we should make
the documentation for HSFS as a default and GP as an exception?

Or else just say copy tiboot3.bin as is on the SD card for HSFS devices
and for GP.... (as you have done below)

> +FAT partition:
> +
> +* tiboot3-am62x-gp-phycore-som.bin from R5 build as tiboot3.bin
> +* tispl.bin_unsigned from Cortex-A build as tispl.bin
> +* u-boot.img_unsigned from Cortex-A build as u-boot.img
> +
> +Boot
> +----
> +
> +Put the uSD card in the slot on the board and apply power. Check the serial
> +console for output.
> +
> +Flash to SPI NOR
> +----------------
> +
> +Below commands can be used to flash the SPI NOR flash; assuming
> +tiboot3.bin, tispl.bin and u-boot.img are stored on the uSD card.
> +
> +.. code-block:: bash
> +
> +  sf probe
> +  fatload mmc 1 ${loadaddr} tiboot3.bin
> +  sf update $loadaddr 0x0 $filesize
> +  fatload mmc 1 ${loadaddr} tispl.bin
> +  sf update $loadaddr 0x80000 $filesize
> +  fatload mmc 1 ${loadaddr} u-boot.img
> +  sf update $loadaddr 0x280000 $filesize
> +

Want to add some documentation on Boot Modes? Something like [0]?


> +Further Information
> +-------------------
> +
> +Please see :doc:`../ti/am62x_sk` chapter for further AM62 SoC related documentation
> +and https://docs.phytec.com/phycore-am62x for vendor documentation.
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index a127215ce5..435c72a428 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -33,6 +33,7 @@ K3 Based SoCs
>     am62ax_sk
>     am62x_sk
>     ../beagle/am62x_beagleplay
> +   ../phytec/phycore-am62x
>     ../toradex/verdin-am62
>     am64x_evm

Rest looks good, so with the above suggestions,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

[0] https://docs.u-boot.org/en/v2023.07.02/board/ti/am62x_sk.html

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
