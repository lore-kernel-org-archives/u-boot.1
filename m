Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DA4D18145
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 20:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3806D88EC0;
	Mon, 14 Oct 2024 22:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="MA3T5Fnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41E988EB9; Mon, 14 Oct 2024 22:37:19 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B327E89018
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 22:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1728938237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/MxnjJmobhccQF52BDZkAZvUWNYMPUfTrp74lX9ngo=;
 b=MA3T5Fnf9A7WiPkgCi4ln/Zeuu+0fdZyixN9HA02GaHeuZKcvp8UU1BhZPfRMRn4VwQyuX
 NTK2LHHlRYOOon225yG/4uZutPnR9FZl9HNSlYwJozN0CAZQgzurKn0C6EaCfDxuBPGk+g
 fbZAHXmytJnwEobEMuMd5HTmjSeNs0HIrTi1R7L9GMlc9V592yf1FzAE4HQosR/MJIZX8/
 GwywDdloOJ362xhnpPce0acB/CwqJktHJRY+Q8Lz4BbgwnVz7sTHrEJsvbfyY/O7MQORdw
 HYCWbowXLsrIic2rsxPfZ0+oSGWxE5BM6WJApcbbZOhqHRs8LyhEdTaR6ES6Rw==
Date: Mon, 14 Oct 2024 22:37:16 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Kever
 Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, Philipp
 Tomsich <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz <quentin.schulz@cherry.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
In-Reply-To: <20241014202605.2799040-1-alexthreed@gmail.com>
References: <20241014202605.2799040-1-alexthreed@gmail.com>
Message-ID: <90a23734b538e60d0d42e1de899d46fd@manjaro.org>
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

On 2024-10-14 22:26, Alex Shumsky wrote:
> Increase rng-seed size to make Linux happy and initialize rng pool 
> instantly.
> Linux 5.19+ requires 32 bytes of entropy to initialize random pool, but 
> u-boot
> currently provides only 8 bytes.
> Linux 5.18 and probably some vesrions before it used to require 64 
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
> https://github.com/torvalds/linux/blob/7234e2ea0edd00bfb6bb2159e55878c19885ce68/drivers/char/random.c#L632
> https://elixir.bootlin.com/linux/v5.18/source/drivers/char/random.c#L236
> https://elixir.bootlin.com/linux/v5.19/source/drivers/char/random.c#L551
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all
> Rockchip devices")

Looking good to me, with some additional remarks below.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
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
>  arch/arm/mach-rockchip/board.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/board.c 
> b/arch/arm/mach-rockchip/board.c
> index 3fadf7e412..9ff1567fb1 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -472,9 +472,16 @@ __weak int misc_init_r(void)
>  __weak int board_rng_seed(struct abuf *buf)
>  {
>  	struct udevice *dev;
> -	size_t len = 0x8;
> +	ulong len = env_get_ulong("rng_seed_size", 10, 64);
>  	u64 *data;
> 
> +	if (len < 64) {
> +		// rng_seed_size should be at least 32 bytes for Linux 5.19+, or 64 
> for
> +		// older Linux'es

s/Linux'es/Linux kernel versions/
or s/Linux'es/Linux versions/

... and possibly break the comment after the comma, for
improved readability.

> +		log_warning("Value for rng_seed_size too low (%lu) and likely
> insufficient for the Linux RNG initialization\n",
> +			    len);
> +	}
> +
>  	data = malloc(len);
>  	if (!data) {
>  		printf("Out of memory\n");
