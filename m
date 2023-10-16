Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4A8CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 06:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7263386484;
	Mon, 16 Oct 2023 08:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697438663;
	bh=nlRK67rlJsRx/PgYhZ4MDTxPqEHcA1n/1I8GXENxDLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LATWlQZcM/4KuAhGaq+nVVHVc1eE7p6uK6tF/B2X8Se0jzYilI1DfKTc1/ZqeZEm+
	 vOTJdDN//KJTnsRXntfUt2z4CH+F9agQgF2/QMMKfaqdJcuTjg9Zqv8MzikmagkZzP
	 FdUojHwpk8rCeFrxI0pstCcnw6gouy6FcRhFn6ybFoWM0XfcMx0LwyDHL5SIRCRGsT
	 nV3B0i6eEtcPpGu0YsMPG6NmBhHuA1LJ6PnZptPRnkKku494p+c8fJhR1HisjRZXOv
	 p3QJ5P0zrHqAwabhWq+KTKRC+nD3BWXLh5vyOtvUjWHjLClSzp8/DlNBPiHtUMUIg6
	 i/YFDKWLCXBRQ==
Received: from [IPV6:2001:a61:606e:f301:e05a:af60:e9cd:8baa] (unknown
 [IPv6:2001:a61:606e:f301:e05a:af60:e9cd:8baa])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0290086479;
 Mon, 16 Oct 2023 08:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697438661;
 bh=nlRK67rlJsRx/PgYhZ4MDTxPqEHcA1n/1I8GXENxDLU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=i32XAsbror6+z5TTfMsjdvwbw3K7eiaA0yQE6SEbjBTlk7Eg4BkTBWQleSXpDYqt4
 +hXV82Yp7bGrWoJOJ+juMPeJudLgYHZTgai48lJr54UhAKUOHAjhvZPz9LKx/LQM9y
 UyvJL38g+toukmFCBOPDOz3KCNKWog89gp57lxq03zmixXbgv3HXpl0KaEZ7JBDKdn
 g1UKxCokQMpSZatQTOCVpbGZr2lruby4IDfPC5rbOFwV8Gqlktp2r9ShwlCkUarxF3
 WnATFkMdgulPpkL8WgZ2+0wUMY/WqIjgn7SGPsea/S+RoKJV5T6nukqAOUV1iKccFl
 TnVVMTpuMAtBA==
Message-ID: <f0e2bb0e-a1e6-45ce-81f1-1a026f125068@denx.de>
Date: Mon, 16 Oct 2023 08:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: imx: Add support for detecting primary/secondary
 bmode on MX8M
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>
References: <20230729150946.214878-1-marex@denx.de>
 <20230729150946.214878-3-marex@denx.de>
Content-Language: en-US
From: Stefano Babic <sbabic@denx.de>
In-Reply-To: <20230729150946.214878-3-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Fedor, Marek,

On 29.07.23 17:09, Marek Vasut wrote:
> From: Fedor Ross <fedor.ross@ifm.com>
> 
> Implement the 'getprisec' subcommand of 'bmode' command for i.MX8M by
> reading out the ROM log events. This event is set by the BootROM if it
> switched to the secondary copy due to primary copy being corrupted.
> 
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Stefano Babic <sbabic@denx.de>
> ---
>   arch/arm/mach-imx/Kconfig     | 2 +-
>   arch/arm/mach-imx/imx8m/soc.c | 5 +++++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index d94b5828d0d..982d542b1c8 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -70,7 +70,7 @@ config CSF_SIZE
>   config CMD_BMODE
>   	bool "Support the 'bmode' command"
>   	default y
> -	depends on ARCH_MX7 || ARCH_MX6 || ARCH_MX5
> +	depends on ARCH_IMX8M || ARCH_MX7 || ARCH_MX6 || ARCH_MX5
>   	help
>   	  This enables the 'bmode' (bootmode) command for forcing
>   	  a boot from specific media.
> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
> index 2234ef947a1..10e5aeb48a2 100644
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -726,6 +726,11 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
>   
>   	return part;
>   }
> +
> +int boot_mode_getprisec(void)
> +{
> +	return !!imx8m_detect_secondary_image_boot();
> +}
>   #endif
>   
>   #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)


This breaks several board, I bisected imx8mm-cl-iot-gate because those 
boards don't define boot_mode_apply:

+arch/arm/mach-imx/cmd_bmode.c:86: undefined reference to `boot_mode_apply'
+make[1]: *** [Makefile:1765: u-boot] Error 139

I cannot apply this, please check and repost, thanks.

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
