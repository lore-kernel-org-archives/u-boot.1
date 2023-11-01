Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20858C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 09:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B2C287676;
	Wed,  1 Nov 2023 10:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A6778767B; Wed,  1 Nov 2023 10:57:23 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 18D4987672
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 10:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB40D2F4;
 Wed,  1 Nov 2023 02:57:59 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DB143F67D;
 Wed,  1 Nov 2023 02:57:17 -0700 (PDT)
Date: Wed, 1 Nov 2023 09:57:14 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] arm: sunxi: Correct warning in board_fit_config_name_match
Message-ID: <20231101095714.715f8a4c@donnerap.manchester.arm.com>
In-Reply-To: <20230717192920.2063953-1-trini@konsulko.com>
References: <20230717192920.2063953-1-trini@konsulko.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 17 Jul 2023 15:29:20 -0400
Tom Rini <trini@konsulko.com> wrote:

Hi Tom,

> When building this with clang, we get a warning about having excess
> parenthesis here, or that we're incorrectly using "==" when we want "=".
> Correct these by using parenthesis around our multiplication of
> constants as this is what was likely intended originally, even if not
> strictly required.

thanks, I will take this with SZ_512M, as Simon suggested.
Will be part of the next PR.

Cheers,
Andre

> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Andre Przywara <andre.przywara@arm.com>
> ---
>  board/sunxi/board.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index f321cd58a6e6..643e8db185b4 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -957,7 +957,7 @@ int board_fit_config_name_match(const char *name)
>  #ifdef CONFIG_PINE64_DT_SELECTION
>  	if (strstr(best_dt_name, "-pine64-plus")) {
>  		/* Differentiate the Pine A64 boards by their DRAM size. */
> -		if ((gd->ram_size == 512 * 1024 * 1024))
> +		if (gd->ram_size == (512 * 1024 * 1024))
>  			best_dt_name = "sun50i-a64-pine64";
>  	}
>  #endif

