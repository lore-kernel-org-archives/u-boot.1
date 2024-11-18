Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13163D591AE
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 19:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3EE288E1C;
	Mon, 18 Nov 2024 20:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XJzc6ogV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE45389119; Mon, 18 Nov 2024 20:33:15 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9577588DB6
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 20:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AIJWsim068117;
 Mon, 18 Nov 2024 13:32:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731958374;
 bh=/eP09uBz6qadgoPC9+PAdTnTiP3a2OZENStbDFX96dM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=XJzc6ogVBvZ3lekFOxY+IgfXs5jAs9oA6c0K5SnyVN62GxMtUom2UETdyXXVVHilj
 UbARztIz42PTRIOYplddi2bYA80VeoW7/cw2FidcJvojBoI+u+cIc1gMGI4j6dani9
 gEq6g9Y5BOVf9894JOYIZSjSIILk5jGz2j0xJn9k=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AIJWsJH115253
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 13:32:54 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 13:32:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 13:32:53 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AIJWrPn048304;
 Mon, 18 Nov 2024 13:32:53 -0600
Date: Mon, 18 Nov 2024 13:32:53 -0600
From: Bryan Brattlof <bb@ti.com>
To: Garrett Giordano <ggiordano@phytec.com>
CC: <trini@konsulko.com>, <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <sumit.garg@linaro.org>, <kever.yang@rock-chips.com>, <marex@denx.de>,
 <festevam@denx.de>, <jonas@kwiboo.se>, <Oliver.Gaskell@analog.com>,
 <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>, <n-francis@ti.com>,
 <d-gole@ti.com>, <afd@ti.com>, <sjg@chromium.org>, <nm@ti.com>,
 <d.schultz@phytec.de>, <nmorrisson@phytec.com>,
 <francesco.dolcini@toradex.com>, <vishalm@ti.com>, <vigneshr@ti.com>,
 <y.moog@phytec.de>, <othacehe@gnu.org>, <m-chawdhry@ti.com>,
 <j-humphreys@ti.com>, <j-choudhary@ti.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] board: phytec: am62a7: Add PHYTEC phyCORE-AM62A7 SoM
Message-ID: <20241118193253.sx5yvpcyzjdidhou@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241115195055.3023365-1-ggiordano@phytec.com>
 <20241115195055.3023365-2-ggiordano@phytec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241115195055.3023365-2-ggiordano@phytec.com>
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

On November 15, 2024 thus sayeth Garrett Giordano:
> Add support for PHYTEC phyCORE-AM62A7 SoM.
> 
> Supported features:
>   - 2GB LPDDR4 RAM
>   - eMMC
>   - External SD
>   - Ethernet
>   - debug UART
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>

Looks Good!

Reviewed-by: Bryan Brattlof <bb@ti.com>

...

> diff --git a/arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi 
> b/arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
> new file mode 100644
> index 00000000000..00330b43fed
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
> @@ -0,0 +1,2798 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * This file was generated with the
> + * AM62Ax SysConfig DDR Subsystem Register Configuration Tool v0.09.08
> + * Fri Mar 24 2024 11:56:13 GMT-0700 (Pacific Daylight Time)
> + * DDR Type: LPDDR4
> + * F0 = 50MHz    F1 = NA     F2 = 1866MHz
> + * Density (per channel): 8Gb
> + * Number of Ranks: 1
> + */

You may want to regenerate this config if you guys see any stability 
issues. We've had some improvements in our chip select timings which are 
included in the v0.10.2 EMIF tool's output.

~Bryan
