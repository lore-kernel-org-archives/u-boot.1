Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6FDE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BB5801E8;
	Tue,  7 Jan 2025 15:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YM019vJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB49801FD; Tue,  7 Jan 2025 15:33:57 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A3A8007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E20035C5D42;
 Tue,  7 Jan 2025 14:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F33BC4CEDD;
 Tue,  7 Jan 2025 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736260430;
 bh=kLlLoB6Od04arkNSaMU6mCnEK23HuELrWlRwj29+HCY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YM019vJshG2fcAqogS3LXNi3mccZ7VUSJCEQmWy1kURvmbPt3W/km2gBzjXsGY6mr
 tN2MZye1GVGopKeP/Pb1P7WQtQxDDz4oSP1Y1uuzBMwiidIUVQ5bayEufK4UcKdWDb
 82di7lE3iNRzeqyHjP9CLuaU4W56iQUSBFIOA1b9YLU2hmpenBgrQASR5h9miXIBOD
 b/vgWkHr8DHdsnSOzEyu0+4kMkzLu7lAqVDAGea+FWlji2O1EI9aVjcleuNXsLQvoz
 aL2rOrLn5GeWH29sah/EgtGpVTdhS5gcATrHOB2re2/Uts6gxRgG2r4sskKaJ2+5US
 hqO2cH0dngmzg==
Message-ID: <d2c8cde1-891f-470a-abd9-598847a9078f@kernel.org>
Date: Tue, 7 Jan 2025 16:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] arm: mach-k3: j721s2_init: Probe AM65 CPSW NUSS for
 R5/A72 SPL
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
 <20250107093840.2211381-5-c-vankar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250107093840.2211381-5-c-vankar@ti.com>
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
> To support Ethernet boot on AM68-SK, probe AM65 CPSW NUSS driver in
> board_init_f().
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  arch/arm/mach-k3/j721s2/j721s2_init.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
> index 6ce3eb87efb..7208bee5785 100644
> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
> @@ -329,6 +329,16 @@ void board_init_f(ulong dummy)
>  
>  	setup_qos();
>  
> +	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
> +	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {
> +		struct udevice *cpswdev;
> +
> +		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
> +						  &cpswdev);
> +		if (ret)
> +			printf("Failed to probe am65_cpsw_nuss driver..\n");
> +	}
> +

This looks like a hack. Please find out why the Ethernet driver is not being
probed when SPL tries to load image over net.

We have the following defined at the am65-cpsw-nuss driver.

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

It looks like am65_cpsw_probe_nuss() is not being invoked for you.

Can you please check if am65_cpsw_port_probe() was invoked?
If yes but am65_cpsw_probe_nuss() was not then we need to fix the
DM hierarchy for AM65_CPSW?

>  	if (IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_AVS0)) {
>  		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
>  						  &dev);

-- 
cheers,
-roger

