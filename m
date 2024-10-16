Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21D3D2068A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 01:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 383EE889CA;
	Wed, 16 Oct 2024 03:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="WvlAtafH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0B288B39; Wed, 16 Oct 2024 03:22:10 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F31788A9D
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1729041726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItQjLwwZzStq4glFFYJ8b1gYUvEUWwB9Pa9FMtEe+hM=;
 b=WvlAtafHj9vPHGl6fHJHSo/1rPGFH06i0K9tPC+y2/kqwsgA/9IOpwsXaz+7F9ZiZG8iWz
 KdK7F4IKlYaBgV+XMWGUVzgMEaNHZJxgY2Hsg6cZ2us04IUJZWRI8znfvHgNrQqByfJoA5
 Od5D5/bXSlchfUPSa+jgFDWKFI22IpuaMIcGCuUGDgiXe614TCpd5APlOdp3x74SNPcGLm
 D11dQH5ERYTST++WpqrGa4B6ynZFapjXp6ZoSOe388LpLQm65W+6ZiTxwjyFU7ywxovvt2
 dmabtZ2/fQ0oMcXtIN5NcJKlfPFTaBdhYWLymk5vjEk7m3YPv+OwNg+zFWnujw==
Date: Wed, 16 Oct 2024 03:22:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, Ben Wolsieffer
 <benwolsieffer@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, Chris
 Morgan <macromorgan@hotmail.com>, Devarsh Thakkar <devarsht@ti.com>, Jagan
 Teki <jagan@amarulasolutions.com>, Janne Grunau <j@jannau.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, Joshua Watt
 <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Nikhil M Jain <n-jain1@ti.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefan Roese <sr@denx.de>, Tim Harvey
 <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v5] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
In-Reply-To: <20241015212831.61229-1-alexthreed@gmail.com>
References: <20241015212831.61229-1-alexthreed@gmail.com>
Message-ID: <2aaf029095b1ee30d0b40f60787e1a8c@manjaro.org>
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

Hello Alex,

Thanks for the v5.  Please see a few comments below.

On 2024-10-15 23:28, Alex Shumsky wrote:
> Increase rng-seed size to make Linux happy and initialize rng pool 
> instantly.
> Linux 5.19+ requires 32 bytes of entropy to initialize random pool, but 
> u-boot
> currently provides only 8 bytes.
> Linux 5.18 and probably some versions before it used to require 64 
> bytes.
> Bump min value to 64 bytes to be on a safe side.
> 
> Boot with 8 byte rng-seed (Linux 6.11):
>     # dmesg | grep crng
>     [   12.089286] random: crng init done
> Boot with 32 byte rng-seed (Linux 6.11):
>     # dmesg | grep crng
>     [    0.000000] random: crng init done
> 
> Linux source references:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.19#n551
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.18#n236
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all
> Rockchip devices")
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
> 
> Changes in v5:
> - add docs
> 
> Changes in v4:
> - fix typos and code style
> 
> Changes in v3:
> - reword warning
> - increase default rng_seed_size to support older linux as well
> - reword commit message
> 
> Changes in v2:
> - add env config knob rng_seed_size
> - add warning for small rng_seed_size
> - 12-character commit SHA in Fixes
> 
>  arch/arm/mach-rockchip/board.c | 11 ++++++++++-
>  common/Kconfig                 |  3 +++
>  doc/usage/environment.rst      |  5 +++++
>  include/fdt_support.h          |  3 ++-
>  4 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/board.c 
> b/arch/arm/mach-rockchip/board.c
> index 3fadf7e412..ca6404776f 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -472,9 +472,18 @@ __weak int misc_init_r(void)
>  __weak int board_rng_seed(struct abuf *buf)
>  {
>  	struct udevice *dev;
> -	size_t len = 0x8;
> +	ulong len = env_get_ulong("rng_seed_size", 10, 64);
>  	u64 *data;
> 
> +	if (len < 64) {
> +		/*
> +		 * rng_seed_size should be at least 32 bytes for Linux 5.19+,
> +		 * or 64 for older Linux kernel versions
> +		 */
> +		log_warning("Value for rng_seed_size too low (%lu) and likely
> insufficient for the Linux RNG initialization\n",

Please consider changing the message to:

   "Value for rng_seed_size (%lu) too low, Linux kernel RNG
   may fail to initialize early\n"

It's more compact, which is always good, and should be a bit
more precise that way.

> +			    len);
> +	}
> +
>  	data = malloc(len);
>  	if (!data) {
>  		printf("Out of memory\n");
> diff --git a/common/Kconfig b/common/Kconfig
> index 957de0c5c0..c1d06f5045 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -927,6 +927,9 @@ config BOARD_RNG_SEED
>  	  new seed for use on subsequent boots, and whether or not the
>  	  kernel should account any entropy from the given seed.
> 
> +	  Default seed size (64 bytes) can be overridden by a decimal 
> environment
> +	  variable rng_seed_size.

Maybe reflow a bit to follow the column width above.

> +
>  endmenu
> 
>  menu "Update support"
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index cc33d3ec0f..253b25a002 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -323,6 +323,11 @@ netretry
>      Useful on scripts which control the retry operation
>      themselves.
> 
> +rng_seed_size
> +    Size of random value added to device tree-node /chosen/rng-seed.
> +    This variable is given as a hexadecimal number.

We've come to a conclusion it's a decimal number, right? :)
So, please s/hexadecimal/decimal/

> +    If unset, 64 bytes is used as the default.
> +
>  silent_linux
>      If set then Linux will be told to boot silently, by
>      adding 'console=' to its command line. If "yes" it will be
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index 741e2360c2..02561eab15 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -202,7 +202,8 @@ int ft_board_setup(void *blob, struct bd_info *bd);
>   *
>   * This function is called if CONFIG_BOARD_RNG_SEED is set, and must
>   * be provided by the board. It should return, via @buf, some suitable
> - * seed value to pass to the kernel.
> + * seed value to pass to the kernel. Seed size could be set in a 
> decimal
> + * environment variable rng_seed_size and defaulted to 64 bytes.

s/defaulted/it defaults/

>   *
>   * @param buf         A struct abuf for returning the seed and its 
> size.
>   * @return            0 if ok, negative on error.
