Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C37BD358F2
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2FA83CBD;
	Thu, 29 Jan 2026 11:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="m2Qb3hHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A6883D17; Thu, 29 Jan 2026 11:01:40 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1311383C8C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 1D1061F94E;
 Thu, 29 Jan 2026 11:01:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1769680897;
 bh=pdciehPB/jKEjuuhBwhxjvdDW3TkYcouHo9XwlWD4VU=; h=From:To:Subject;
 b=m2Qb3hHUrnQic6SvpRsUVpORGyvGMgPlXciTBpXx2ZivfznV/EyoBZNeHj18UAhH+
 Bx9fTPi5R+7Yz7c3tZjAh9SALn3x2nHLjHxwCYvlbfBZAQT1mOb1iTUPvk/WcpjFQW
 mT6KIcaS9qG4VkDYYCzodIrKnpwg/A2WPA7swz1NLxtVo35lJW0kcWT02NMb2bC6+h
 Rmuj2UlkQMBVlqVNhie/JHTXBFZblBl1/IfrBJKlHufLz/59VvAhw4XwZ73814XoX2
 JPJiM96B9sEAnYfYuPgnkED724qz0+iT3ENgeid3jHzZH91L26tSm/zEm+Ek/qordi
 b8agBwpXWnReQ==
Date: Thu, 29 Jan 2026 11:01:33 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/4] imx9: Kconfig: Enable remoteproc for i.MX95 EVK
Message-ID: <20260129100133.GA30853@francesco-nb>
References: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
 <20260129-imx95-rproc-v1-4-035b2dbf3e57@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129-imx95-rproc-v1-4-035b2dbf3e57@nxp.com>
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

Hello Peng,

On Thu, Jan 29, 2026 at 06:25:00PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Select remoteproc related configs for i.MX95 EVK to support manage CM7
> using 'rproc' cmd with steps as below:
> 
> load mmc 1:2 ${loadaddr} imx95-15x15-evk_m7_TCM_rpmsg_lite_str_echo_rtos.elf
> rproc load 0 ${loadaddr} ${filesize}
> rproc start 0
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/mach-imx/imx9/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index d9f97e4328c..7051e086072 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -134,6 +134,12 @@ config TARGET_IMX95_19X19_EVK
>  	imply BOOTSTD_BOOTCOMMAND
>  	imply BOOTSTD_FULL
>  	imply OF_UPSTREAM
> +	select CMD_REMOTEPROC
> +	select REMOTEPROC_IMX
> +	select REGMAP
> +	select SYSCON
> +	select IMX_SM_LMM
> +	select IMX_SM_CPU

Why doing this with a select in the Kconfig?

I would expect either
 - you enable what you need in the defconfig
 - you add the select to the imx95 soc

Francesco

