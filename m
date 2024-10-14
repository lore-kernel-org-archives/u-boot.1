Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED65AD18153
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DDE088E36;
	Mon, 14 Oct 2024 23:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728941714;
	bh=LtOlV/bGFNMlCZH2dKERGt72Ybm8NvEFWHcbBjdwA00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NfWYwBO1NBFVazOnjLmhmfa315+8+KjGQxaxUKddApywhimHf4hZ2Qem3K9kWbIhl
	 o9+b/Ygz0lobU4eNojx+hhxEvYfUxkkrkXZCE8SYTfxTjOtG/3hfY5Re5y8tZfxF+M
	 HeoJgyhBKkoFzNLpSBRZZm2WRFu+5MKjRIswcELHDgwZs7/DENvB2Q+ixw9QJ2WVTw
	 zHplq1aFA9/OeyABlxpLyIbucPyVXwSx5a0f0ks08MLpcH2yFDRRhrq3QUZGrPppHv
	 /A2TtsxZlfMUiVD2Lqqde+OPqTR/yV6ecGY9gltmCWVLqg18sH2O806bXoMpl+ugIt
	 UrcU5ZF8AisPA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E753E87DC7;
 Mon, 14 Oct 2024 23:35:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728941713;
 bh=LtOlV/bGFNMlCZH2dKERGt72Ybm8NvEFWHcbBjdwA00=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BQm3GLOUgGxucJ71gAGvGBy/8tvTb9griaUQf4Ebt/dkzlE/2YPsgMJXnVHNP7YHj
 sHZjdTejCOVw/vhbXO2k8aX77GgWMbU7C5KgOdenO3544S53E/vR77Fdn/6kwe5t5c
 wk1w9ioD3I1NVqdExLXfsKWMpTUblnmvHJ1XZpRa0/phHwG46qBXrCmk0El0xdiEV8
 dBOOgBz+cYRP7JP12H7k3mFZhMmdU0IidtzuiFV4aYPjelaVSRKxYCjZq/PjjE/Iy6
 CmMnQEP+dDEkmgpZUUUIt29lTxzBg4/kpWGscwHl+wAjpx4LGsuirxZP8W2MCh/kal
 472diOKv2QT2g==
Message-ID: <31f823bd-0e55-46f0-960d-c5f361a86ce0@denx.de>
Date: Mon, 14 Oct 2024 23:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241014202605.2799040-1-alexthreed@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241014202605.2799040-1-alexthreed@gmail.com>
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

On 10/14/24 10:26 PM, Alex Shumsky wrote:
> Increase rng-seed size to make Linux happy and initialize rng pool instantly.
> Linux 5.19+ requires 32 bytes of entropy to initialize random pool, but u-boot
> currently provides only 8 bytes.
> Linux 5.18 and probably some vesrions before it used to require 64 bytes.

"versions", typo

> Bump min value to 64 bytes to be on a safe side.
> 
> Boot with 8 byte rng-seed (Linux 6.11):
>      # dmesg | grep crng
>      [   12.089286] random: crng init done
> Boot with 32 byte rng-seed (Linux 6.11):
>      # dmesg | grep crng
>      [    0.000000] random: crng init done
> 
> Linux source references:
> https://github.com/torvalds/linux/blob/7234e2ea0edd00bfb6bb2159e55878c19885ce68/drivers/char/random.c#L632
> https://elixir.bootlin.com/linux/v5.18/source/drivers/char/random.c#L236
> https://elixir.bootlin.com/linux/v5.19/source/drivers/char/random.c#L551

Please use https://git.kernel.org torvalds repo , not some random 
downstream webpages.

> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all Rockchip devices")
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
>   arch/arm/mach-rockchip/board.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 3fadf7e412..9ff1567fb1 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -472,9 +472,16 @@ __weak int misc_init_r(void)
>   __weak int board_rng_seed(struct abuf *buf)
>   {
>   	struct udevice *dev;
> -	size_t len = 0x8;
> +	ulong len = env_get_ulong("rng_seed_size", 10, 64);
>   	u64 *data;
>   
> +	if (len < 64) {
> +		// rng_seed_size should be at least 32 bytes for Linux 5.19+, or 64 for
> +		// older Linux'es

/*
  * Please use C style
  * multi-line
  * comment.
  */

(also, s!Linux.es!Linux kernel versions! while you're fixing it )

> +		log_warning("Value for rng_seed_size too low (%lu) and likely insufficient for the Linux RNG initialization\n",
> +			    len);
> +	}
> +
>   	data = malloc(len);
>   	if (!data) {
>   		printf("Out of memory\n");

Thanks !
