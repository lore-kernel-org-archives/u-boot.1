Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C16DE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D24801E8;
	Tue,  7 Jan 2025 15:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UWd5ew9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3227A801FD; Tue,  7 Jan 2025 15:18:24 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26F508007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 938FD5C54D6;
 Tue,  7 Jan 2025 14:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C7BC4CED6;
 Tue,  7 Jan 2025 14:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736259498;
 bh=heqLxP7GXvkj8lKIRYbZluMmuDGMJzAJ9NWoRmCn+bo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UWd5ew9zz8x9aKl0kSGu7WCvwp7tjuQw4pUBvGPpIV0KcCwZicFvKAnUgEc6J9R6O
 i/Ohd+q0LtMVLP7Ao6GUvF+kzzN37uGHEqfffpoRyDxIbArxlMGd86EB6cMGcXzWba
 aQNHNjXRupUSWKXpFGX4lF7ZoBwUjydqy5Cm30mfSMzsByobhUdPqw53zfb0qkTohw
 V8Y0qxEL4WfBRecp8L4TeZR+TtAmePxXE6GpjtHPtKvT5OI3QfIt+fzPgwZ1VIX+Vz
 7jTvMm1CeLxUaXC98BOrZTLDnDek2B3FtnqLlQku9i6sElqmjY48W513M2X/25R69z
 L2plL+Qs09muA==
Message-ID: <c8e651fa-f9e3-4901-8475-15e9bbfee0ab@kernel.org>
Date: Tue, 7 Jan 2025 16:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] arm: mach-k3: am62p5_init: Probe AM65 CPSW NUSS for
 R5/A53 SPL
To: Chintan Vankar <c-vankar@ti.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: srk@ti.com, s-vadapalli@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-10-c-vankar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250107093840.2211381-10-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 07/01/2025 11:38, Chintan Vankar wrote:
> In order to support Ethernet boot on AM62p, probe AM65 CPSW NUSS
> driver in board_init_f().
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  arch/arm/mach-k3/am62px/am62p5_init.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
> index 34ed01cd78c..f8e98b09402 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> @@ -159,6 +159,16 @@ void board_init_f(ulong dummy)
>  	}
>  
>  	spl_enable_cache();
> +
> +	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
> +	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {
> +		struct udevice *cpswdev;
> +
> +		if (uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
> +						&cpswdev))
> +			printf("Failed to probe am65_cpsw_nuss driver\n");
> +	}
> +

Why do you need to do this?

from drivers/net/ti/am65-cpsw-nuss.c

U_BOOT_DRIVER(am65_cpsw_nuss) = {
        .name   = "am65_cpsw_nuss",
        .id     = UCLASS_MISC,
        .of_match = am65_cpsw_nuss_ids,
        .probe  = am65_cpsw_probe_nuss,
        .priv_auto = sizeof(struct am65_cpsw_common),
};

U_BOOT_DRIVER(am65_cpsw_nuss_port) = {
        .name   = "am65_cpsw_nuss_port",
        .id     = UCLASS_ETH,
        .probe  = am65_cpsw_port_probe,
        .ops    = &am65_cpsw_ops,
        .priv_auto      = sizeof(struct am65_cpsw_priv),
        .plat_auto      = sizeof(struct eth_pdata),
        .flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
};

Isn't am65_cpsw_port_probe() and am65_cpsw_probe_nuss() getting called?
If not, you need to identify why and fix it the proper way. Not by hacking
it like you do now.

>  	debug("am62px_init: %s done\n", __func__);
>  }
>  

-- 
cheers,
-roger

