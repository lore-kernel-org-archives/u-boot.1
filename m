Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F45C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 19:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD7B83A84;
	Fri,  1 Aug 2025 21:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kc+tIGyY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qxRUmHi/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87C683A8D; Fri,  1 Aug 2025 21:32:05 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C3C483A1C
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 21:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4btx0g1k3wz9swD;
 Fri,  1 Aug 2025 21:32:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754076723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9u0Au1vqmAUK+flIjJqfFDbj5kxUTA6/fv84KUVIi/E=;
 b=kc+tIGyYqyyjhAJ+XLDeuUK6JR+LwflpvgAGCGjVO6s82i8g5o/YS5YCbeWAi8TbUD0Ddf
 YTLcCi3kCtNY7z3aIXe05oF9N9YLEPGVr0kbwj/bho9fUjM5sobNPQmOSBxJN5PB6SP0U6
 Bk0TDPKAIAuoSqsPs5yEob6JC/JacVkgpBJkkEhoWEUImlUn2x1EJdXfHl2FCe9R0v/2vB
 ZZHOn3vcqC0QzYWwmhR0oF2hc7jVec1qhUCGOLh3tW3NYbhPP+Z/O/fLM0avZsTo/BT5Mj
 zXzLpxQQx1nL0QF3L6AZ/XQ9tGUirGgVJw6PKjx5TvJD9qZTGLyTX76ftY/s7Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="qxRUmHi/";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <0aa5523b-d384-48c2-b156-e7a8a91da29c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754076721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9u0Au1vqmAUK+flIjJqfFDbj5kxUTA6/fv84KUVIi/E=;
 b=qxRUmHi/5CTQFK4tPDCgvPHFCoP9wybJswv25K6htTY7qugtJyywof+vqpC0buoDi1/BTF
 8BB5sFcMFqCdx7u/fV63ElqG4m4SwdoaVPuRZnKeGPBPVgqvCxWjupxFh2MSD3dp8o/MXw
 0xG8uKSkDvvwX9BVa5HvyM2XH02WZRt49lUmjCFBsZWIKlAT7LlUxw2CVfaMU7MlPLBtvY
 WhUlCUucuEH5gQrTpraVI5VcK1yjiV1B+j4jQR/XHiq+NkZ3ZoF3PuBK/K6xGtzFe90xcA
 puM7aJ9aUSIGL/VJ7vhEmZf8UATetI+PjqiZkG0hrG0R9lttX0gQChUgaX26RQ==
Date: Fri, 1 Aug 2025 21:31:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] imx95_evk: Restore support for i.MX95 A0 silicon
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, tharvey@gateworks.com,
 sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, peng.fan@nxp.com, ye.li@nxp.com, alice.guo@nxp.com,
 sumit.garg@oss.qualcomm.com, marek.vasut+renesas@mailbox.org,
 aford173@gmail.com, sjg@chromium.org, Zhiqiang.Hou@nxp.com
Cc: u-boot@lists.denx.de
References: <20250722204709.2075421-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250722204709.2075421-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ee4b6a9af056477c9af
X-MBO-RS-META: ort5cabyppgwab558sf6nt4t5znrz7f6
X-Rspamd-Queue-Id: 4btx0g1k3wz9swD
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

On 7/22/25 10:47 PM, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> This patch is used to restore support for i.MX95 A0 silicon. The usage
> is updated in imx95_evk.rst.
> 
> Fixes: 9936724aa9b ("imx95_evk: Add i.MX95 B0 support")
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   arch/arm/mach-imx/imx9/Kconfig            |   5 +-
>   arch/arm/mach-imx/imx9/scmi/container.cfg |   2 +
>   arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  11 ++
>   configs/imx95_a0_19x19_evk_defconfig      | 153 ++++++++++++++++++++++
>   doc/board/nxp/imx95_evk.rst               |  41 +++++-
>   5 files changed, 207 insertions(+), 5 deletions(-)
>   create mode 100644 configs/imx95_a0_19x19_evk_defconfig
> 
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index 4e0e194690b..a306203b111 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -25,6 +25,9 @@ config IMX91
>   	select ARCH_MISC_INIT
>   	select ARMV8_SPL_EXCEPTION_VECTORS
>   
> +config IMX95_A0
> +	bool "Choice i.MX95 A0"
> +
>   config IMX95
>   	bool
>   	select ARCH_MISC_INIT
> @@ -33,7 +36,7 @@ config IMX95
>   	select DM_MAILBOX
>   	select SCMI_FIRMWARE
>   	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
> -	select IMX_PQC_SUPPORT
> +	select IMX_PQC_SUPPORT if !IMX95_A0
>   
>   config SYS_SOC
>   	default "imx9"
> diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
> index b25f3b726c5..bc10cdb227b 100644
> --- a/arch/arm/mach-imx/imx9/scmi/container.cfg
> +++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
> @@ -3,7 +3,9 @@
>    * Copyright 2025 NXP
>    */
>   
> +#ifndef CONFIG_IMX95_A0
>   CNTR_VERSION 2
> +#endif
>   BOOT_FROM SD
>   SOC_TYPE IMX9
>   CONTAINER
Generate this whole file using binman, and then specify the SoC variant 
in control DT, as yet another binman image etype property .
