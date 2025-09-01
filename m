Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41E2CA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 03:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4142E833E9;
	Mon,  1 Sep 2025 05:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E15833AD; Mon,  1 Sep 2025 05:40:25 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15BC831C2
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 05:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 882F7B220074;
 Mon,  1 Sep 2025 05:40:22 +0200 (CEST)
Message-ID: <ba55e271-b913-4bf8-8b73-793ada8d6ab5@freeshell.de>
Date: Sun, 31 Aug 2025 20:40:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] [v1] scripts/Makefile.lib: increase detail for dtsi
 debug output
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250828065159.486850-1-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250828065159.486850-1-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8
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


On 8/27/25 23:51, E Shattow wrote:
> Detailed dtsi automatic selection debug output when DEVICE_TREE_DEBUG=1
>   - Indicate when key is undefined and skip undefined search pattern
>   - Indicate when search pattern is found or not found, and the pattern
>   - Show values of defined keys
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  scripts/Makefile.lib | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5db2fbc418a..3cbb20e6b9d 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -203,13 +203,36 @@ u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $
>  	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
>  	$(wildcard $(u_boot_dtsi_loc)u-boot.dtsi))
>  
> -u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
> +u_boot_dtsi_options_raw = $(warning Automatic inclusion \
> +	$(or $(u_boot_dtsi_options),(undefined)) from search order: \
> +	$$<=$(if \
> +	$(<),$(<) $(if $(wildcard \
>  	$(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
> +	),,not) found @ \
> +	$(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
> +	,(undefined)) || \
> +	$$CONFIG_SYS_SOC=$(if \
> +	$(CONFIG_SYS_SOC),$(CONFIG_SYS_SOC) $(if $(wildcard \
> +	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> +	),,not) found @ \
>  	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> +	,(undefined)) || \
> +	$$CONFIG_SYS_CPU=$(if \
> +	$(CONFIG_SYS_CPU),$(CONFIG_SYS_CPU) $(if $(wildcard \
>  	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> +	),,not) found @ \
> +	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> +	,(undefined)) || \
> +	$$CONFIG_SYS_VENDOR=$(if \
> +	$(CONFIG_SYS_VENDOR),$(CONFIG_SYS_VENDOR) $(if $(wildcard \
> +	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> +	),,not) found @ \
>  	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> -	$(u_boot_dtsi_loc)u-boot.dtsi ... \
> -	found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
> +	,(undefined)) || \
> +	"u-boot.dtsi" $(if $(wildcard \
> +	$(u_boot_dtsi_loc)u-boot.dtsi \
> +	),,not) found @ \
> +	$(u_boot_dtsi_loc)u-boot.dtsi)
>  
>  # Uncomment for debugging
>  # This shows all the files that were considered and the one that we chose.
> 
> base-commit: 3dc5e9a0108bb114175b6362f9cb22367402f624

Postscript, this patch does what I want, but is worse to mantain.

I think I have something easier to understand with foreach(). Will send
soon.

-E
