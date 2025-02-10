Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D7AC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961D0805C2;
	Mon, 10 Feb 2025 12:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P2QwTyWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E55780AE1; Mon, 10 Feb 2025 12:29:37 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B78803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABTWP5032929
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2025 05:29:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739186972;
 bh=dC8E3Q13vNlA7OF98oVcta5E/9iuxoIfOuIKZrEy+I8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=P2QwTyWfpV5cpgEYMu3GoU6QnnnMK3+I9uKoLTPlB9OthN5UagwViWWtmXRirwpk8
 BqdErv2t11pxS7M3Z2M/K6i4WExOlS+RhBRb/5zemkpSI8GfHJdMxSLBbFAYbo0TJs
 PALVqogm4ECO77GODxCyRAxeAoQRYKQuDXDbPAfw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABTW8V028690
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2025 05:29:32 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 05:29:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 05:29:31 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ABTUYF053327;
 Mon, 10 Feb 2025 05:29:31 -0600
Date: Mon, 10 Feb 2025 16:59:30 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <jm@ti.com>,
 <nm@ti.com>, <n-francis@ti.com>, <sjg@chromium.org>, <hnagalla@ti.com>,
 <afd@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] configs: am62ax_evm_a53_defconfig: enable USB DFU support
Message-ID: <twkljfbd4ko2hjtlghiwqo7lbbcutqv2tekuey47th4dbc2gl2@u6diodhe7izl>
References: <20250122121338.1055249-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122121338.1055249-1-s-vadapalli@ti.com>
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

On Wed, Jan 22, 2025 at 05:43:36PM +0530, Siddharth Vadapalli wrote:
> The config fragment "am62x_a53_usbdfu.config" which adds USB DFU support
> for AM62x SoC is applicable to the AM62Ax SoC as well. Hence, include it
> in "am62ax_evm_a53_defconfig" in order to enable support for USB DFU flash
> and boot.

The v2 of this patch is now a part of a v4 series of other related patches and
has been posted at:
https://patchwork.ozlabs.org/project/uboot/patch/20250210112239.2639009-2-s-vadapalli@ti.com/

Regards,
Siddharth.

> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 82d262ae162 Merge patch series "MediaTek MT7629 OF_UPSTREAM migration (v2)"
> of the master branch of Mainline U-Boot.
> 
> Patch has been tested for SD Boot on AM62A7-SK to ensure that the
> change to am62ax_evm_a53_defconfig in this patch doesn't introduce a
> regression. Logs:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/c8879ebb33417458cc39e262c98ff959
> 
> Regards,
> Siddharth.
> 
>  configs/am62ax_evm_a53_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
> index bf6e9639901..a2f6d904df4 100644
> --- a/configs/am62ax_evm_a53_defconfig
> +++ b/configs/am62ax_evm_a53_defconfig
> @@ -107,3 +107,5 @@ CONFIG_SYSRESET=y
>  CONFIG_SPL_SYSRESET=y
>  CONFIG_SYSRESET_TI_SCI=y
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> +
> +#include <configs/am62x_a53_usbdfu.config>
> -- 
> 2.43.0
> 
