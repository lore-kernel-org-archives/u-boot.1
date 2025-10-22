Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8C3CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 12:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB8A8323A;
	Wed, 22 Oct 2025 14:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fLzRfkkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBFC83303; Wed, 22 Oct 2025 14:40:17 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD4C82B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 14:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MCeD7w1404300;
 Wed, 22 Oct 2025 07:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761136813;
 bh=UtqiQu0sr0tFozJrIurpnlKI05ksLg7U3HkWdlRKj1s=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fLzRfkkIqtJz7/t3VYCNB2W31HySI1gmytTtJTcLqu1+eW49/7k/geuvykN9pf/69
 4DwuKogHIrTg3a+kKpyaVPX3uo3A85b/qLocuRvmBByKU8GULeJzOJqC1u7HyC7N7d
 j5Ob/egsFqE6n1QARgY/aPXLoETIMN7IgoVDJj8g=
Received: from DLEE210.ent.ti.com (dlee210.ent.ti.com [157.170.170.112])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MCeDec2348595
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Oct 2025 07:40:13 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 07:40:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 07:40:12 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MCeCCu1206254;
 Wed, 22 Oct 2025 07:40:12 -0500
Date: Wed, 22 Oct 2025 07:40:12 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Beleswar Padhi
 <b-padhi@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 7/8] board: am62x: add env file for am6254atl
Message-ID: <20251022124012.4gljbxpvall2yf4o@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
 <20251022-62sip_support-v1-7-eed08d15e76d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251022-62sip_support-v1-7-eed08d15e76d@ti.com>
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
> Add the env file for am6254atl with the following changes from
> am62x.env:
> 
> 1. splashimage address updated from 0x80200000 to 0x81a00000
> 2. DFU addresses updated to reflect updated TEXT_BASE for spl and u-boot
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  board/ti/am62x/am6254atl.env        | 37 +++++++++++++++++++++++++++++++++++++
>  configs/am6254atl_evm_a53_defconfig |  1 +
>  configs/am6254atl_evm_r5_defconfig  |  1 +
>  3 files changed, 39 insertions(+)
> 
> diff --git a/board/ti/am62x/am6254atl.env b/board/ti/am62x/am6254atl.env
> new file mode 100644
> index 0000000000000000000000000000000000000000..e2b0b102bfe12dba38271d42d54962849cff21d1
> --- /dev/null
> +++ b/board/ti/am62x/am6254atl.env
> @@ -0,0 +1,37 @@
> +#include <env/ti/ti_common.env>
> +#include <env/ti/mmc.env>
> +#include <env/ti/k3_dfu.env>
> +
> +
> +#if CONFIG_CMD_REMOTEPROC
> +#include <env/ti/k3_rproc.env>
> +#endif
> +
> +rproc_fw_binaries= 0 /lib/firmware/am62-mcu-m4f0_0-fw
> +
> +name_kern=Image
> +console=ttyS2,115200n8
> +args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
> +	${mtdparts}
> +run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
> +
> +boot_targets=mmc1 mmc0 usb pxe dhcp
> +boot=mmc
> +mmcdev=1
> +bootpart=1:2
> +bootdir=/boot
> +rd_spec=-
> +
> +splashfile=ti_logo_414x97_32bpp.bmp.gz
> +splashimage=0x82180000
> +splashpos=m,m
> +splashsource=sf
> +
> +dfu_alt_info_ram=
> +	tispl.bin ram 0x82000000 0x200000;
> +	u-boot.img ram 0x82f80000 0x400000
> +
> +#if CONFIG_BOOTMETH_ANDROID
> +#include <env/ti/android.env>
> +adtb_idx=0
> +#endif
> \ No newline at end of file

Oops. ;)

~Bryan
