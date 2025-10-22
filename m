Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8F5CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 12:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E468323A;
	Wed, 22 Oct 2025 14:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VLEG/Ksd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFA683303; Wed, 22 Oct 2025 14:21:29 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E7F82B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 14:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MCLPOx1412243;
 Wed, 22 Oct 2025 07:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761135685;
 bh=jBZf85gyCahKoJZ06opHQDZfcqekoe9FI8Ymy30WYfk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=VLEG/KsdboJn0nGEoaDP4OYHDzMBxZJ0VSsZR9esUbzkupmdtjGs1r3JMwcFa92vr
 3ot/GhDAEp45SuwIstX9oNT10cRwm6MhhbsXk5Gsi1aXzffyDdJmP+WGJLvAu9EO2i
 ryYvkcOhALV9TTa6jZ9Z9X+jfYlxY/sp3AcoDh+Q=
Received: from DLEE208.ent.ti.com (dlee208.ent.ti.com [157.170.170.97])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MCLPvZ1584459
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Oct 2025 07:21:25 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 07:21:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 07:21:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MCLO7K1185521;
 Wed, 22 Oct 2025 07:21:24 -0500
Date: Wed, 22 Oct 2025 07:21:24 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Beleswar Padhi
 <b-padhi@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 8/8] doc: add documentation for am6254atl SiP
Message-ID: <20251022122124.544koxjimyf73gul@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
 <20251022-62sip_support-v1-8-eed08d15e76d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251022-62sip_support-v1-8-eed08d15e76d@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On October 22, 2025 thus sayeth Anshul Dalal:
> Adds documentation for the newly added am6254atl EVM board along with
> build instructions.
> 
> The content is largely similar to instructions for AM62x with updated
> TFA and OPTEE build args to account for the changes to A53 and OPTEE's
> load address.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  doc/board/ti/am6254atl_sk.rst | 313 ++++++++++++++++++++++++++++++++++++++++++
>  doc/board/ti/k3.rst           |   1 +
>  2 files changed, 314 insertions(+)
> 
> diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..480c0b07cfa85ebae495593b40c6a34692b15cda
> --- /dev/null
> +++ b/doc/board/ti/am6254atl_sk.rst
> @@ -0,0 +1,313 @@
> +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +.. sectionauthor:: Anshul Dalal <anshuld@ti.com>
> +
> +AM6254ATL SIP Platforms
> +=======================
> +
> +Introduction:
> +-------------
> +
> +The AM6254atl SIP (System In Package) provides existing :doc:`am62x_sk` with
> +512MiB of DDR integrated in a single packages.
> +
> +More details can be found in the Technical Reference Manual:
> +https://www.ti.com/lit/pdf/spruiv7
> +
> +Platform information:
> +
> +* https://www.ti.com/tool/SK-AM62-SIP
> +
> +Boot Flow:
> +----------
> +Below is the pictorial representation of boot flow:
> +
> +.. image:: img/boot_diagram_am62.svg
> +  :alt: Boot flow diagram
> +
> +- Here TIFS acts as master and provides all the critical services. R5/A53
> +  requests TIFS to get these services done as shown in the above diagram.
> +
> +Sources:
> +--------
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_boot_sources
> +    :end-before: .. k3_rst_include_end_boot_sources
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_boot_firmwares
> +    :end-before: .. k3_rst_include_end_tifsstub
> +
> +Build procedure:
> +----------------
> +0. Setup the environment variables:
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
> +.. prompt:: bash $
> +
> +  export UBOOT_CFG_CORTEXR=am6254atl_evm_r5_defconfig
> +  export UBOOT_CFG_CORTEXA=am6254atl_evm_a53_defconfig
> +  export TFA_BOARD=lite
> +  export TFA_EXTRA_ARGS="PRELOADED_BL33_BASE=0x81880000 BL32_BASE=0x80080000"
> +  export OPTEE_PLATFORM=k3-am62x
> +  export OPTEE_EXTRA_ARGS="CFG_TZDRAM_START=0x80080000"
> +
> +1. Trusted Firmware-A:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_tfa
> +    :end-before: .. k3_rst_include_end_build_steps_tfa
> +
> +
> +2. OP-TEE:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_optee
> +    :end-before: .. k3_rst_include_end_build_steps_optee
> +
> +3. U-Boot:
> +
> +* 3.1 R5:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
> +
> +* 3.1.1 Alternative build of R5 for DFU boot:
> +
> +As the SPL size can get too big when building with support for booting both
> +from local storage *and* DFU an extra config fragment should be used to enable
> +DFU support (and disable storage support)
> +
> +.. prompt:: bash $
> +
> +  export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} am62x_r5_usbdfu.config"
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
> +
> +* 3.2 A53:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_uboot
> +    :end-before: .. k3_rst_include_end_build_steps_uboot
> +
> +Target Images
> +-------------
> +
> +In order to boot we need tiboot3.bin, tispl.bin and u-boot.img.  Each SoC
> +variant (GP, HS-FS, HS-SE) requires a different source for these files.
> +
> + - GP
> +
> +        * tiboot3-am62x-gp-evm.bin from step 3.1
> +        * tispl.bin_unsigned, u-boot.img_unsigned from step 3.2

I doubt we will sell GP silicon in the SiP layout. It's probably best we 
remove this to avoid any confusion.

~Bryan
