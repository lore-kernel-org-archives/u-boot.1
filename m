Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921B0C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C57D805C2;
	Mon, 10 Feb 2025 12:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JRKaZpqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30CA0807D6; Mon, 10 Feb 2025 12:28:04 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE7D803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABRlQk3399399
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2025 05:27:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739186867;
 bh=vr4WxLADSaMsTPBdy2GMHdAzUS5XLZsE+rmtP91cEQo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=JRKaZpqUzzu+Ya7W6ocptdUslSOQJrI+4Xzna+64xElw9l4xwii8rTfEMM3JXyUJy
 LmyWdZQvE9tys7DihA4ROGpnTZ3jxDzfeLc/KU9EL90dZA6KgvmzfsN8p0s+BKJ8p6
 5zZVKnW821L42TnCrgxRYBgfkTrM8cpmaIhM7jB0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABRlkm008528
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2025 05:27:47 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 05:27:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 05:27:46 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ABRj46051918;
 Mon, 10 Feb 2025 05:27:46 -0600
Date: Mon, 10 Feb 2025 16:57:45 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <lukma@denx.de>,
 <n-francis@ti.com>, <mkorpershoek@baylibre.com>, <afd@ti.com>,
 <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 0/3] Add support for USB DFU boot on AM62Px
Message-ID: <kc7oqcm3g4elblzauscdm37k4wmay5c5w2zx2zbyxtezppyfif@wtb4iefw3td4>
References: <20241221025229.361625-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241221025229.361625-1-s-vadapalli@ti.com>
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

On Sat, Dec 21, 2024 at 08:22:20AM +0530, Siddharth Vadapalli wrote:
> Hello,
> 
> This series add support for USB DFU boot on TI's AM62Px SoC which has
> two instances of USB Controllers, of which the USB0 instance of USB
> which is a DWC3 USB Controller is used for USB DFU Boot:
> ROM => tiboot3.bin => tispl.bin => u-boot.img

The v4 of this series with other related patches has been posted at:
https://patchwork.ozlabs.org/project/uboot/cover/20250210112239.2639009-1-s-vadapalli@ti.com/

Regards,
Siddharth.

> 
> v2 of this series is at:
> https://patchwork.ozlabs.org/project/uboot/cover/20241218124542.3519447-1-s-vadapalli@ti.com/
> Changes since v2:
> - Collected Reviewed-by tags.
> - Dropped patches 4/5 and 5/5 of the v2 series.
> 
> v1 of this series is at:
> https://patchwork.ozlabs.org/project/uboot/cover/20241217131658.2920799-1-s-vadapalli@ti.com/
> Changes since v1:
> - Dropped the first patch of the v1 series since its equivalent has been
>   posted by Jonathan Humphreys <j-humphreys@ti.com> at:
>   https://patchwork.ozlabs.org/project/uboot/patch/20241217204835.3312765-1-j-humphreys@ti.com/
> - Based on the feedback from Mattijs Korpershoek on the second patch of
>   the v1 series, the patches in this series have been updated. More
>   details regarding the changes have been described below the tearline
>   of the respective patches.
> - Collected Reviewed-by tags.
> 
> Series is based on commit
> e7d7d3307c6 tools: binman: etype: fit: Append DTB directory to the list of input directories
> of the next branch of U-Boot.
> 
> NOTE: Series *depends* on:
>   https://patchwork.ozlabs.org/project/uboot/patch/20241217204835.3312765-1-j-humphreys@ti.com/
>   for functionality in addition to patches 4/5 and 5/5 of the v2 series at:
>   https://patchwork.ozlabs.org/project/uboot/cover/20241218124542.3519447-1-s-vadapalli@ti.com/
> 
> The USB DFU config fragments for AM62x are to be re-used for enabling
> USB DFU boot on AM62Px as follows:
> R5  => am62px_evm_r5_defconfig + am62x_r5_usbdfu.config
> A53 => am62px_evm_a53_defconfig + am62x_a53_usbdfu.config
> 
> Regards,
> Siddharth.
> 
> Siddharth Vadapalli (3):
>   board: ti: am62px: env: include environment for DFU Boot
>   configs: am62x_r5_usbdfu: extend for AM62Px
>   configs: am62px_evm_a53_defconfig: enable USB DFU support
> 
>  board/ti/am62px/am62px.env       |  5 +++--
>  configs/am62px_evm_a53_defconfig | 24 +-----------------------
>  configs/am62x_r5_usbdfu.config   |  3 +++
>  3 files changed, 7 insertions(+), 25 deletions(-)
> 
> -- 
> 2.43.0
> 
