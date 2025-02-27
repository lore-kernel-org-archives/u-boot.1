Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4C1C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 10:43:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3CC28118A;
	Thu, 27 Feb 2025 11:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KIxdlZ71";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137808118B; Thu, 27 Feb 2025 11:43:06 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04::f03c:95ff:fe5e:7468])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5026380F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AD1ED6114B;
 Thu, 27 Feb 2025 10:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3F8C4CEDD;
 Thu, 27 Feb 2025 10:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740652981;
 bh=G/PbeT0m7OYYmmUALigrQqxR5ZMJfVkhV2JuscjfoGI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KIxdlZ71jYNsyn7QDBzCHIyjbekusU5C7gTYaAZIT9Xorq8sOln1b4zEyzfxK3k/B
 yM4ykXkUsi0l87AzL7Xho9D816L5D8g2Pz/nefmcWVDKKYDjb6fhDGCxXMfxRyZuLA
 WGX60fgeA3mPdmxT+Mg+BoOe+No5NYXrUFyuxw7UTjjVqNA3zTiFA+LilMp04Y7SI3
 NCsku/S7inR1v/UXOYsI+86fP3Q/4BLqigvcWs5AFC3yHTDVhe9A/08LROiJ3RmjJP
 yD8OelogrpJQDTnUtGM80zHeOkpbgBlnlg2ZT0smdpIV5oPUzYR7cE4hdCCmHjl2ZA
 WIQDgXPYiYYeg==
Message-ID: <6c5070ae-15b1-48f3-8737-8d09fc41afa5@kernel.org>
Date: Thu, 27 Feb 2025 12:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] arm: mach-k3: am62x: am625_init: Remove explicit
 probing of CPSW driver
To: Chintan Vankar <c-vankar@ti.com>, Michael Walle <mwalle@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 MD Danish Anwar <danishanwar@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Andrew Davis <afd@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
Cc: s-vadapalli@ti.com, u-boot@lists.denx.de
References: <20250225114903.2080616-1-c-vankar@ti.com>
 <20250225114903.2080616-3-c-vankar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250225114903.2080616-3-c-vankar@ti.com>
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



On 25/02/2025 13:48, Chintan Vankar wrote:
> Bind method of am65_cpsw_nuss driver will ensure binding of it's child
> driver am65_cpsw_nuss_ports, and there is no need to call CPSW driver
> explicitly. Remove explicit probing of CPSW driver for AM62x.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

You should just revert commit 35bddf889652 ("arm: mach-k3: am62x: am625_init: Probe AM65 CPSW NUSS")

> ---
> 
> Link to v2:
> https://lore.kernel.org/r/20250219104831.2315464-4-c-vankar@ti.com/
> 
> Changes from v2 to v3:
> - Updated commit subject and commit message.
> 
>  arch/arm/mach-k3/am62x/am625_init.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
> index 595fc391ac5..72a752d38e8 100644
> --- a/arch/arm/mach-k3/am62x/am625_init.c
> +++ b/arch/arm/mach-k3/am62x/am625_init.c
> @@ -282,15 +282,6 @@ void board_init_f(ulong dummy)
>  	}
>  	spl_enable_cache();
>  
> -	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
> -	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {
> -		struct udevice *cpswdev;
> -
> -		if (uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
> -						&cpswdev))
> -			printf("Failed to probe am65_cpsw_nuss driver\n");
> -	}
> -
>  	fixup_a53_cpu_freq_by_speed_grade();
>  }
>  

what about mach-k3/am64x/am642_init.c?
Please revert the relevant commit there as well.

and the same thing done in mach-k3/common.c?
Please revert the relevant commit there too.

It would be OK if you squash all 3 reverts into one patch.

As a separate patch you will also have to remove the part where cpsw_port2 node is
disabled in various k3-*-u-boot.dtsi files [1]. That is no longer needed as now we should
be able to support multiple ethernet ports.

[1] -
k3-am625-beagleplay-u-boot.dtsi:&cpsw_port2 {
k3-am625-phyboard-lyra-rdk-u-boot.dtsi:&cpsw_port2 {
k3-am625-sk-u-boot.dtsi:&cpsw_port2 {
k3-am642-evm-u-boot.dtsi:&cpsw_port2 {
k3-am642-sk-u-boot.dtsi:&cpsw_port2 {

-- 
cheers,
-roger

