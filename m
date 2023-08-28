Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C8AC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 16:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B34864DD;
	Mon, 28 Aug 2023 18:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IYMoTxnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 160938651E; Mon, 28 Aug 2023 18:24:14 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7EF805C9
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 18:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SGO5KI065202;
 Mon, 28 Aug 2023 11:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693239845;
 bh=IWfJB50l1A1Hul4a4H4RQC28qPuOYUwTx5Dd/VdSaIA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=IYMoTxnfM0DhHkPmi04/p0Ul6dm8fiy/FRo2QnDVnshQGO4i8kSMF358L3cE11Z6b
 B4Q4VXzzYe+zD7u8aN6o95OVoQ8pBGZRgBK68UJjR+14teflbzEW/7mwW3LCev6Nyh
 DYh5tSD7t5fArwBiC/GdZP7LX4djjQXnJL0mlkGM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SGO5sp002342
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 11:24:05 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 11:24:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 11:24:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SGO5lQ124397;
 Mon, 28 Aug 2023 11:24:05 -0500
Date: Mon, 28 Aug 2023 11:24:05 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 4/6] k3-am68: Sync from Linux tag v6.5-rc1
Message-ID: <20230828162405.nwa3u5n5t4t3ey2c@glimmer>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-4-a5f141be40bc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-4-a5f141be40bc@ti.com>
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

On 16:47-20230825, Manorit Chawdhry wrote:
> The following commit syncs the device tree from Linux tag
> v6.5-rc1 to U-boot and fixes the following to be compatible with
> the future syncs -
> 
[..]

> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  69 ++---
>  arch/arm/dts/k3-am68-sk-base-board.dts         | 389 +++++++++++++++----------
>  arch/arm/dts/k3-am68-sk-r5-base-board.dts      | 143 ++-------
>  arch/arm/dts/k3-am68-sk-som.dtsi               | 112 ++-----

These files don't have maintainer entries?

>  4 files changed, 300 insertions(+), 413 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
> index 79faa1b5737d..b05a2245b6da 100644
> --- a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
> +
[...]

> +&usb0 {
> +	dr_mode = "peripheral";

There is a bit of a debate ongoing on this.
https://lore.kernel.org/u-boot/20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com/

But I don't see why we need to hold off for that resolution.

>  	bootph-pre-ram;
>  };
> diff --git a/arch/arm/dts/k3-am68-sk-r5-base-board.dts b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> index a64baba14986..bb49e866aa2c 100644
> --- a/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> +++ b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> @@ -1,19 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  /dts-v1/;
>  
> -#include "k3-am68-sk-som.dtsi"
> +#include "k3-am68-sk-base-board.dts"
>  #include "k3-j721s2-ddr-evm-lp4-4266.dtsi"
>  #include "k3-j721s2-ddr.dtsi"
> +#include "k3-am68-sk-base-board-u-boot.dtsi"
>  
>  / {
>  	chosen {
> -		firmware-loader = &fs_loader0;
>  		stdout-path = &main_uart8;

Does'nt this come from board.dts?

[...]

>  &mcu_ringacc {
> @@ -191,4 +85,3 @@
>  	ti,sci = <&dm_tifs>;
>  };
>  
	There is an extra EoL here.
> -#include "k3-am68-sk-base-board-u-boot.dtsi"
[...]
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
