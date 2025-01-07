Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0870CE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E70801FD;
	Tue,  7 Jan 2025 15:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GTfHKlvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB6D8036B; Tue,  7 Jan 2025 15:12:54 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C86801E8
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 507ECZC1084477;
 Tue, 7 Jan 2025 08:12:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736259155;
 bh=2dIlLqwcbtoXa7wb6BzWrHLv28/YUIYf3D+Lxxt4Ojw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=GTfHKlvuymdJXa9bcg9gEV90iSSLecjwityuA8c6N8L6oKl+f/IeDM2lxrdMzKxOX
 nKvoDuh/gAYktsDsHG8DQBoptFEAK6qrYmIMDn4BQyhZugKcsWHd9XZeaJE2XDyK+V
 HeWbfcGXi7D/TsOPE/wpKDKuBhSyZHykPgm5S2/8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 507ECZXB120333
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Jan 2025 08:12:35 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 08:12:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 08:12:34 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 507ECY9E070039;
 Tue, 7 Jan 2025 08:12:34 -0600
Date: Tue, 7 Jan 2025 08:12:34 -0600
From: Bryan Brattlof <bb@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: AKASHI Takahiro <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Simon Glass
 <sjg@chromium.org>, Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom
 Rini <trini@konsulko.com>,
 <srk@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 12/13] configs: am62p: Enable configs required for Ethboot
Message-ID: <20250107141234.3rpr65lvn7mufd4t@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-13-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250107093840.2211381-13-c-vankar@ti.com>
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

On January  7, 2025 thus sayeth Chintan Vankar:
> Enable config options needed to support Ethernet boot on AM62p SK.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  configs/am62px_evm_a53_ethboot_defconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 configs/am62px_evm_a53_ethboot_defconfig
> 
> diff --git a/configs/am62px_evm_a53_ethboot_defconfig b/configs/am62px_evm_a53_ethboot_defconfig
> new file mode 100644
> index 00000000000..8f9b0c4b755
> --- /dev/null
> +++ b/configs/am62px_evm_a53_ethboot_defconfig
> @@ -0,0 +1,17 @@
> +#include <configs/am62px_evm_a53_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_AM62P5=y
> +CONFIG_TARGET_AM62P5_A53_EVM=y
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62p5-sk"
> +CONFIG_SPL_STACK_R_ADDR=0x83000000
> +CONFIG_SPL_DRIVERS_MISC=y
> +#CONFIG_SPL_BOARD_INIT=y

Are we trying to turn this off?

~Bryan
