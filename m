Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FE1D18138
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A963088C7C;
	Mon, 14 Oct 2024 20:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="FITbISEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DAAB88BB2; Mon, 14 Oct 2024 20:19:26 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4217488D9C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1728929961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1T2w2SmZruzabX6eNkF0yHdhWs7I4mSD28/xtmsIZfw=;
 b=FITbISEnUnBkmwkIFHygY89tirB5YSnlSDNM823XRh+Rq7cozwI1H56J1rbpzbpBLtV69N
 sZXZbz9RLAlG2QKawWWiiXNeG+VxLJELxn2LP8oud5pDhZ0vQLOTw82YCVzWjAlUSNOmi5
 MkB/NQjAvZp5XVtfC/v/ptX7qy/RrZu8lqwMBYiptAqrl/MncBy4MMHY9ammVBIRASTl8S
 tXDKWeVXz5/kKAJq2ioqO7QY5/GeBcsVdYDjbU+/hHCnBCSs+watkVW3UZd+eAYD+H1TKF
 mfbhKj80isVKLKcMo2SKUALnmyCdaqic+Qe0G0avSsRuN4dTWWBHmme/3SxlgA==
Date: Mon, 14 Oct 2024 20:19:20 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Kever
 Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, Philipp
 Tomsich <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz <quentin.schulz@cherry.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
In-Reply-To: <20241014175338.2675136-1-alexthreed@gmail.com>
References: <20241014175338.2675136-1-alexthreed@gmail.com>
Message-ID: <3f4143078e0dc3409c96ea13be5b8317@manjaro.org>
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

Thanks for the v2.  Please see a few comments below.

On 2024-10-14 19:53, Alex Shumsky wrote:
> Modern Linux requires 32 byte seed to initialize random pool, but 
> u-boot
> currently provides only 8 bytes. Increase rng-seed size to make Linux 
> happy and
> initialize rng pool instantly.
> 
> Boot with 8 byte rng-seed:
>     # dmesg | grep crng
>     [   12.089286] random: crng init done
> Boot with 32 byte rng-seed:
>     # dmesg | grep crng
>     [    0.000000] random: crng init done
> 
> https://github.com/torvalds/linux/blob/7234e2ea0edd00bfb6bb2159e55878c19885ce68/drivers/char/random.c#L632
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all
> Rockchip devices")
> ---
> 
> Changes in v2:
> - add env config knob rng_seed_size

Perhaps the emitted warning should also be mentioned here.

> - 12-character commit SHA in Fixes
> 
>  arch/arm/mach-rockchip/board.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/board.c 
> b/arch/arm/mach-rockchip/board.c
> index 3fadf7e412..f9f0d7214c 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -472,9 +472,15 @@ __weak int misc_init_r(void)
>  __weak int board_rng_seed(struct abuf *buf)
>  {
>  	struct udevice *dev;
> -	size_t len = 0x8;
> +	ulong len = env_get_ulong("rng_seed_size", 10, 32);
>  	u64 *data;
> 
> +	if (len < 32) {
> +		// rng_seed_size should be 32 bytes for Linux 5.19+, or 64 for older 
> Linux'es

Shouldn't it be 8 for older kernels?

> +		log_warning("Too small rng_seed_size (%lu). It is likely
> insufficient to init linux crng\n",
> +			    len);

Perhaps this would read better:

   "Value for rng_seed_size too low (%lu) and likely insufficient
   for the Linux RNG initialization"

> +	}
> +
>  	data = malloc(len);
>  	if (!data) {
>  		printf("Out of memory\n");
