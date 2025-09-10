Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19B8CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 04:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED8EB830B4;
	Wed, 10 Sep 2025 06:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oe143fO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC1AD8318E; Wed, 10 Sep 2025 06:38:54 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A68A7830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 06:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58A4coCh4176635
 for <u-boot@lists.denx.de>; Tue, 9 Sep 2025 23:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757479130;
 bh=tQcSdbf/yYyVa6hr70i/HKzjGnNTNHa9i2Q0VmFHgqk=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=oe143fO3X83w9Os0hx3kQ/e2I3xRLLqV83qa0Us+z6CDOihKKBPTuhD2Txy5Mwyj2
 mN4DOFL3WO/SWyMRlx++eWVCK15rCpiw4SY0jq+ppt+0OZue1TkEoRkci0igphXcvd
 ZDVvGPnYr6UBiJ9YEdlhXfwt6vx08ZPWsYzq6VSI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58A4co5O883958
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 9 Sep 2025 23:38:50 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 23:38:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Sep 2025 23:38:49 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58A4cmEU4108392;
 Tue, 9 Sep 2025 23:38:48 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Sep 2025 10:08:47 +0530
Message-ID: <DCOUCTBZ6JGI.QNZEO4LYIKR6@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <afd@ti.com>
Subject: Re: [RFC PATCH v2 4/5] arm: dts: Introduce AM62D2-EVM dtbs
From: Anshul Dalal <anshuld@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <nm@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250909053429.444854-1-p-bhagat@ti.com>
 <20250909053429.444854-5-p-bhagat@ti.com>
In-Reply-To: <20250909053429.444854-5-p-bhagat@ti.com>
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



On Tue Sep 9, 2025 at 11:04 AM IST, Paresh Bhagat wrote:
> Introduce the base dts files needed for u-boot or to augment the linux
> dtbs for use in the u-boot-spl and u-boot binaries. Support added for
> HS-SE and HS-FS boot binaries for AM62dx via binman.
>
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>  arch/arm/dts/Makefile                        |    2 +
>  arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi | 2802 ++++++++++++++++++
>  arch/arm/dts/k3-am62d-evm-binman.dtsi        |  262 ++
>  arch/arm/dts/k3-am62d2-evm-u-boot.dtsi       |   14 +
>  arch/arm/dts/k3-am62d2-r5-evm.dts            |   82 +
>  5 files changed, 3162 insertions(+)
>  create mode 100644 arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi
>  create mode 100644 arch/arm/dts/k3-am62d-evm-binman.dtsi
>  create mode 100644 arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-am62d2-r5-evm.dts
>
[snip]
> diff --git a/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi b/arch/arm/dts/k3-am6=
2d2-evm-u-boot.dtsi
> new file mode 100644
> index 00000000000..d1b17e8f83f
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common AM62D EVM dts file for SPLs
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.co=
m/
> + */
> +
> +#include "k3-am62d-evm-binman.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path =3D "serial2:115200n8";
> +		tick-timer =3D &main_timer0;
> +	};
> +};

The chosen node is already part of the kernel dt for the AM62d, why not
move this addition to the kernel dt directly?

Regards,
Anshul
