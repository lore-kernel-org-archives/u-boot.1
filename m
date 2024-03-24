Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28068C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 16:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA3687D45;
	Sun, 24 Mar 2024 17:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="n29Vxor0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6FBF87D6F; Sun, 24 Mar 2024 17:52:58 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E244787D1E
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 17:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1711299176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvBRSxIVeXQEmTwfqcr4Yz07hbSou2Q8kvrm2+TMzS0=;
 b=n29Vxor0kd5N+1I7nISaxhmd7u4Racs1Y4kLXhyJ8wlCtBDKlqm9RWQZjUuA/3pBUGkr4b
 +Q2LtxFgEe9XWYPYIuzi2/uqiv/ccF8g+G5Axi9Fr7gVrbfH/FTs0D+DYJ/+/vkuETHVU3
 3QgqxLXNF5lMVBNY4e5Rz5jOeIke0gpmDCSbDgbAizo0vSQ9Jwddc7tpQBAmWrWS43TJBi
 9YSPNaC7cOJhOK5Bp84RUue//MNWqe3mUpgGEh/Eq/FjmhLX9GbnkWKWWBYaC1XaeYHxOt
 6z1THYBpZB/T0fYnA0frR+pLwT7aZlM6CHlqmwDQJtqHKYa3+fmI+k3Ly4mWyg==
Date: Sun, 24 Mar 2024 17:52:55 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Christopher Obbard <chris.obbard@collabora.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] rockchip: spl: Add SPI NOR flash to boot_devices
 array
In-Reply-To: <20240322205027.3860170-4-jonas@kwiboo.se>
References: <20240322205027.3860170-1-jonas@kwiboo.se>
 <20240322205027.3860170-4-jonas@kwiboo.se>
Message-ID: <69ac8183dcf1cc54f51d21b823c1abfa@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Jonas,

Please see my comments below.

On 2024-03-22 21:50, Jonas Karlman wrote:
> Add missing boot source id <-> device tree node path mapping for SPI 
> NOR
> flash on PX30, RK3288, RK3308, RK3368 and RV1126.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2:
> - New patch
> ---
>  arch/arm/mach-rockchip/px30/px30.c     | 1 +
>  arch/arm/mach-rockchip/rk3288/rk3288.c | 1 +
>  arch/arm/mach-rockchip/rk3308/rk3308.c | 1 +
>  arch/arm/mach-rockchip/rk3368/rk3368.c | 1 +
>  arch/arm/mach-rockchip/rv1126/rv1126.c | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/px30/px30.c
> b/arch/arm/mach-rockchip/px30/px30.c
> index b4f655fa4b3e..2ec3289d75b7 100644
> --- a/arch/arm/mach-rockchip/px30/px30.c
> +++ b/arch/arm/mach-rockchip/px30/px30.c
> @@ -19,6 +19,7 @@
> 
>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff390000",
> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff3a0000/flash@0",

AFAICT, no PX30-based board contains an SPI chip, but making this
future-proof perhaps shouldn't hurt.

>  	[BROM_BOOTSOURCE_SD] = "/mmc@ff370000",
>  };
> 
> diff --git a/arch/arm/mach-rockchip/rk3288/rk3288.c
> b/arch/arm/mach-rockchip/rk3288/rk3288.c
> index c77c56c1dab5..70cf50029121 100644
> --- a/arch/arm/mach-rockchip/rk3288/rk3288.c
> +++ b/arch/arm/mach-rockchip/rk3288/rk3288.c
> @@ -28,6 +28,7 @@ DECLARE_GLOBAL_DATA_PTR;
> 
>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff0f0000",
> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff130000/flash@0",

Using spi2 for a flash chip applies to some RK3288-based boards, but 
AFAICT
not to all of them.  For example, arch/arm/dts/rk3288-evb.dtsi uses spi0
for a flash chip, which in turn translates to /spi@ff110000/flash@0.  
The
same also applies to arch/arm/dts/rk3288-firefly.dtsi, for example.

>  	[BROM_BOOTSOURCE_SD] = "/mmc@ff0c0000",
>  };
> 
> diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c
> b/arch/arm/mach-rockchip/rk3308/rk3308.c
> index 27a748327e31..b3ffabc5449a 100644
> --- a/arch/arm/mach-rockchip/rk3308/rk3308.c
> +++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
> @@ -141,6 +141,7 @@ enum {
> 
>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff490000",
> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff4c0000/flash@0",

AFAICT, no RK3308-based board contains an SPI chip, and I'm not really
sure where does /spi@ff4c0000/flash@0 come from.

>  	[BROM_BOOTSOURCE_SD] = "/mmc@ff480000",
>  };
> 
> diff --git a/arch/arm/mach-rockchip/rk3368/rk3368.c
> b/arch/arm/mach-rockchip/rk3368/rk3368.c
> index 651ba1090206..8f5ca1dfa7c9 100644
> --- a/arch/arm/mach-rockchip/rk3368/rk3368.c
> +++ b/arch/arm/mach-rockchip/rk3368/rk3368.c
> @@ -55,6 +55,7 @@ struct mm_region *mem_map = rk3368_mem_map;
> 
>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff0f0000",
> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff120000/flash@0",

This is fine.

>  	[BROM_BOOTSOURCE_SD] = "/mmc@ff0c0000",
>  };
> 
> diff --git a/arch/arm/mach-rockchip/rv1126/rv1126.c
> b/arch/arm/mach-rockchip/rv1126/rv1126.c
> index 8589c46f10aa..40eb9eb7b196 100644
> --- a/arch/arm/mach-rockchip/rv1126/rv1126.c
> +++ b/arch/arm/mach-rockchip/rv1126/rv1126.c
> @@ -15,6 +15,7 @@
> 
>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ffc50000",
> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ffc90000/flash@0",

This is also fine.

>  	[BROM_BOOTSOURCE_SD] = "/mmc@ffc60000",
>  };
