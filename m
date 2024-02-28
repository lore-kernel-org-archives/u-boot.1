Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A60C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 05:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6661187E88;
	Wed, 28 Feb 2024 06:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h8fvsBT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D3E987E88; Wed, 28 Feb 2024 06:45:54 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F5087D7E
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 06:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S5jmmg018062;
 Tue, 27 Feb 2024 23:45:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709099148;
 bh=RmfdWwVtsm/OWz7yxemgNKjsoiqfQNglStiH/uV+hyg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=h8fvsBT8/svNSylqAXzBn7bj5CChUctLukH8puclJVmb8l3itpcGaFh+7jTQ70r5K
 nuWeUM6q4fCZulIWMqTKGfr5jDaXM5m1SnVCf6AdXRuXMyXveRWcGKsM7rg11WJara
 7FPr/gaV1pWYVFY0BePnoT52ZBfsQKBRaqlvQbsI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S5jmgq082561
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Feb 2024 23:45:48 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 23:45:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 23:45:47 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41S5jkaG033103;
 Tue, 27 Feb 2024 23:45:47 -0600
Date: Wed, 28 Feb 2024 11:15:46 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <trini@konsulko.com>,
 <upstream@lists.phytec.de>
Subject: Re: [PATCH v2 2/2] doc: board: phytec: Add phyCORE-AM64x
Message-ID: <20240228054546.42zbsojdpmwbeyky@dhruva>
References: <20240226122341.3638748-1-w.egorov@phytec.de>
 <20240226122341.3638748-3-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240226122341.3638748-3-w.egorov@phytec.de>
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

On Feb 26, 2024 at 13:23:41 +0100, Wadim Egorov wrote:
> Add documentation for PHYTEC phyCORE-AM64x SoM.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  doc/board/phytec/index.rst         |   1 +
>  doc/board/phytec/phycore-am64x.rst | 159 +++++++++++++++++++++++++++++
>  2 files changed, 160 insertions(+)
>  create mode 100644 doc/board/phytec/phycore-am64x.rst
> 
> diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
> index fea0b07620..99848a9e95 100644
> --- a/doc/board/phytec/index.rst
> +++ b/doc/board/phytec/index.rst
> @@ -9,5 +9,6 @@ PHYTEC
>     imx8mm-phygate-tauri-l
>     imx93-phyboard-segin
>     phycore-am62x
> +   phycore-am64x
>     phycore-imx8mm
>     phycore-imx8mp
> diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
> new file mode 100644
> index 0000000000..202b756dc4
> --- /dev/null
> +++ b/doc/board/phytec/phycore-am64x.rst
> @@ -0,0 +1,159 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Wadim Egorov <w.egorov@phytec.de>
> +
> +phyCORE-AM64x
> +=============
> +
> +The `phyCORE-AM64x <https://www.phytec.com/product/phycore-am64x>`_ is a
> +SoM (System on Module) featuring TI's AM64x SoC. It can be used in combination
> +with different carrier boards. This module can come with different sizes and
> +models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM64x family.
> +
> +A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am64x>`_
> +is used as a carrier board reference design around the AM64x SoM.
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
> + $ export UBOOT_CFG_CORTEXR=phycore_am64x_r5_defconfig
> + $ export UBOOT_CFG_CORTEXA=phycore_am64x_a53_defconfig
> + $ export TFA_BOARD=lite
> + $ # we don't use any extra TFA parameters
> + $ unset TFA_EXTRA_ARGS
> + $ export OPTEE_PLATFORM=k3-am64x
> + # we don't use any extra OPTEE parameters
> + unset OPTEE_EXTRA_ARGS
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
> +To boot from a micro SD card on a HSFS device simply copy the following
> +artifacts to the FAT partition:
> +
> +* tiboot3.bin from R5 build as tiboot3.bin
> +* tispl.bin_unsigned from Cortex-A build as tispl.bin
> +* u-boot.img_unsigned from Cortex-A build as u-boot.img

Is the _unsigned really required? I guess the regular tispl and
u-boot.img should also work right? It will just skip auth I guess.

[...]

Mostly looks good, thanks!
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
