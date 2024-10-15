Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A80FD1627F
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 03:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E1CE88B4B;
	Tue, 15 Oct 2024 05:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="OisjVU6Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961D688AC2; Tue, 15 Oct 2024 05:17:25 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B1388B4B
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 05:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1728962241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TE0Sfq2PGz4hTnamgEMjU0fl0nuZnSd3TI+PaMnAb30=;
 b=OisjVU6YQs8sY0f4x+3EXyLR7Xca2M2vt7VcgGlOn4KWUR/UBQFtYjv6UjpEe68jJMlTCR
 KrkJaYTpb9B1K3JkevE4Ai0hypO2IgVlopSeWC3sslvBYyOpon2LuBGhrlJza87SHBXbaz
 GGgGmLPZ0FA6hGJuYEZm5cXvNmte0QQMr5o14T2c32I38nGsgmdJwXTxs4Lp6tSB2KHiGs
 aEIVSwTnDC0gmnhkB27+CtQaYO25LVN+JA4KYQtt/In/tvUbF0JVwZikAK4XW7V9L6n/hQ
 2cpmldFRjQQuy+nMked/hseSYvcH9J+o9wmRHeDSGzUzVtXhMJO9f4i68GvYRw==
Date: Tue, 15 Oct 2024 05:17:20 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Kever
 Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, Peter
 Robinson <pbrobinson@gmail.com>, Philipp Tomsich
 <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz <quentin.schulz@cherry.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v4] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
In-Reply-To: <20241014221523.2912260-1-alexthreed@gmail.com>
References: <20241014221523.2912260-1-alexthreed@gmail.com>
Message-ID: <3fe5ae337570bd2ca4322fcc2c9969ab@manjaro.org>
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

On 2024-10-15 00:15, Alex Shumsky wrote:
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
> ---
> 
> Changes in v4:
> - fix typos and code style

The v4 is looking good, thanks!

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
>  1 file changed, 10 insertions(+), 1 deletion(-)
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
> +			    len);
> +	}
> +
>  	data = malloc(len);
>  	if (!data) {
>  		printf("Out of memory\n");
