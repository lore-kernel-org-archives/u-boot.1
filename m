Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E24CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 12:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD9FB8323A;
	Wed, 22 Oct 2025 14:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d0KEatM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F224832BC; Wed, 22 Oct 2025 14:16:37 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CDF982B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 14:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MCGXFq1400108;
 Wed, 22 Oct 2025 07:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761135393;
 bh=Cwffi+BnS/dc3xVkgAfoMXUWTGxszudPJrL7VLIjCgQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=d0KEatM+j4hlvYt4JKMSq/+PE82XowU0ByOP44Yj3Tsg+LKVT80ldAXa1ZSNAIFo/
 9ecJcx/jzcjkIUvD/0NwUtGjngRztJWmiNIgAtQX8Oq9vWPabCJLhs8ffA/mi2MFvY
 GfebZHE4Xb7xnqA4MUL6XTPpXibhthfTvruGoh+Q=
Received: from DLEE212.ent.ti.com (dlee212.ent.ti.com [157.170.170.114])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MCGXx62001422
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Oct 2025 07:16:33 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 07:16:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 07:16:32 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MCGWZN1165462;
 Wed, 22 Oct 2025 07:16:32 -0500
Date: Wed, 22 Oct 2025 07:16:32 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Beleswar Padhi
 <b-padhi@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 6/8] configs: add defconfigs for am6254atl
Message-ID: <20251022121632.vsjulhgztd7m4s4l@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
 <20251022-62sip_support-v1-6-eed08d15e76d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251022-62sip_support-v1-6-eed08d15e76d@ti.com>
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
> OP-TEE for current K3 devices resides from 0x9e800000 to 0xa0000000
> which needs to be moved to 0x80080000 to free up space at end of DDR in
> systems with 512MiB of memory. This is required to allow U-Boot to
> relocate to end of DDR before booting to the kernel.
> 
> Therefore defconfigs for AM6254atl include the respective existing AM62x
> configs with updated dt for r5 and modified memory map for a53 SPL to
> account for the new OP-TEE address.
> 
> Also make Bryan Brattlof and Tom Rini the maintainers for AM6254atl SIP.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  board/ti/am62x/MAINTAINERS          |  2 ++
>  configs/am6254atl_evm_a53_defconfig | 15 +++++++++++++++
>  configs/am6254atl_evm_r5_defconfig  |  9 +++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/board/ti/am62x/MAINTAINERS b/board/ti/am62x/MAINTAINERS
> index d7dfefffe751b5f3a1292ef8cc9e2926f09c77ae..ca269fae880357eb9f62232a3a32bbafa8b3d29d 100644
> --- a/board/ti/am62x/MAINTAINERS
> +++ b/board/ti/am62x/MAINTAINERS
> @@ -10,3 +10,5 @@ F:	configs/am62x_evm_r5_ethboot_defconfig
>  F:	configs/am62x_evm_a53_ethboot_defconfig
>  F:	configs/am62x_lpsk_r5_defconfig
>  F:	configs/am62x_lpsk_a53_defconfig
> +F:	configs/am6254atl_evm_r5_defconfig
> +F:	configs/am6254atl_evm_a53_defconfig
> diff --git a/configs/am6254atl_evm_a53_defconfig b/configs/am6254atl_evm_a53_defconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..fdf6be7068e7b2fe4e48f1f322703f6838729497
> --- /dev/null
> +++ b/configs/am6254atl_evm_a53_defconfig
> @@ -0,0 +1,15 @@
> +#include <configs/am62x_evm_a53_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_AM625=y
> +CONFIG_TARGET_AM625_A53_EVM=y
> +CONFIG_TEXT_BASE=0x82f80000
> +CONFIG_BLOBLIST_ADDR=0x82c80000

I think this may have been leftover from some experimentation.
Do we still need the bloblist stuff?

~Bryan
