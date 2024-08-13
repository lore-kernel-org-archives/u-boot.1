Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3927C531DC
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B8A8899C;
	Tue, 13 Aug 2024 14:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QQv3MUGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A1E68899D; Tue, 13 Aug 2024 14:48:20 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E75887E30
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DCm4ss008425;
 Tue, 13 Aug 2024 07:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723553284;
 bh=AFYf0szN0DjoYduK/JhNfm44z6ZwBfP2a5Ii+V+9U8U=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=QQv3MUGAnx9+zACfK0/bS0L3D2vOHSGLu62PHgTgV6cqZy36nUrxhrxkmYjIK1Asv
 vQiD7Zhsvq83PvCVmy/GGhgnD8tJ8ybsarMj6X+rsMzM8UR6qCXUZNYGSNoB4FGfK1
 StntGvMpqC8TwGrKmh0razgt+8rP/4s9xG7yBnLE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DCm4Kk097455
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 07:48:04 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 07:48:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 07:48:03 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DCm3GG024589;
 Tue, 13 Aug 2024 07:48:03 -0500
Date: Tue, 13 Aug 2024 07:48:03 -0500
From: Nishanth Menon <nm@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Michal Simek <michal.simek@amd.com>, Marek =?utf-8?B?QmVow7pu?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Neha
 Malcom Francis" <n-francis@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Devarsh Thakkar" <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, "Sumit
 Garg" <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 08/10] configs: am62: Enable configs required for
 Ethboot
Message-ID: <20240813124803.cfafirgpo6ucpe2t@ducky>
References: <20240813105400.4054657-1-c-vankar@ti.com>
 <20240813105400.4054657-9-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240813105400.4054657-9-c-vankar@ti.com>
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

On 16:23-20240813, Chintan Vankar wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Enable config options needed to support Ethernet boot on AM62x SK.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> Link to v4:
> https://lore.kernel.org/r/20240812114922.3844009-1-c-vankar@ti.com/
> 
> Changes from v4 to v5:
> - No Changes.
> 
>  configs/am62x_evm_a53_ethboot_defconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 configs/am62x_evm_a53_ethboot_defconfig
> 
> diff --git a/configs/am62x_evm_a53_ethboot_defconfig b/configs/am62x_evm_a53_ethboot_defconfig
> new file mode 100644
> index 00000000000..9d3c6b889f0
> --- /dev/null
> +++ b/configs/am62x_evm_a53_ethboot_defconfig
> @@ -0,0 +1,17 @@
> +#include <configs/am62x_evm_a53_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_AM625=y
> +CONFIG_TARGET_AM625_A53_EVM=y
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-sk"
> +CONFIG_SPL_STACK_R_ADDR=0x83000000
> +CONFIG_SPL_SIZE_LIMIT=0x80000
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_ETH=y
> +CONFIG_SPL_NET=y
> +CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot A53 SPL"
> +CONFIG_SPL_SYSCON=y
> -- 
> 2.34.1
> 


Where is the documentation for the usage?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
