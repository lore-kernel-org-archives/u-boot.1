Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F4ECA1009
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 09:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158E28319C;
	Wed,  3 Sep 2025 11:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B26831BE; Wed,  3 Sep 2025 11:17:39 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C02283164
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 11:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7F2ADB220244;
 Wed,  3 Sep 2025 11:17:36 +0200 (CEST)
Message-ID: <78b6d346-de80-4644-b4df-c56a86926091@freeshell.de>
Date: Wed, 3 Sep 2025 02:17:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/Makefile.lib: increase detail for dtsi debug
 output
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250901094506.647427-1-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250901094506.647427-1-e@freeshell.de>
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


On 9/1/25 02:44, E Shattow wrote:
> Skip automatic dtsi selection if ARCH is not defined and introduce
> u_boot_dtsi_search for use with foreach method to implement the automatic
> dtsi inclusion. Increase code re-use and detail for debug output.
> 
> Detailed dtsi automatic selection debug output when DEVICE_TREE_DEBUG=1
>   - Indicate when key is undefined and skip undefined search pattern
>   - Indicate when search pattern is found or not found, and the pattern
>   - Show values of defined keys
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  scripts/Makefile.lib | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5db2fbc418a..0d70868a339 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -195,21 +195,33 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
>  ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
>  

>  # Try these files in order to find the U-Boot-specific .dtsi include file
> +ifneq ($(strip $(ARCH)),)

I think this guarding for non-empty $(ARCH) could be changed to become:

ifneq ($(filter $(obj),dts/upstream/src/$(ARCH) arch/$(ARCH)/dts),)

it could be $(obj) or $(src) I am not sure if either is correct, but
they do seem to compile for OF_UPSTREAM and non-OF_UPSTREAM target. This
avoids the work and debug output unless actually compiling in the dts
target directory. Am I missing any detail here?

> +
>  u_boot_dtsi_loc = $(srctree)/arch/$(ARCH)/dts/
>  
> -u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi) \
> -	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> -	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> -	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> +u_boot_dtsi_search = $(<) \
> +	$(CONFIG_SYS_SOC) $(CONFIG_SYS_CPU) $(CONFIG_SYS_VENDOR)
> +
> +u_boot_dtsi_pattern = $(eval x=$$(patsubst "%",%,$(i)))$(strip \
> +	$(and $(x),$(wildcard \
> +	$(u_boot_dtsi_loc)$(basename $(notdir $(x)))-u-boot.dtsi)))
> +
> +u_boot_dtsi_options = $(strip \
> +	$(foreach i,$(value u_boot_dtsi_search),$(u_boot_dtsi_pattern)) \
>  	$(wildcard $(u_boot_dtsi_loc)u-boot.dtsi))
>  
> -u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
> -	$(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
> -	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> -	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> -	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> -	$(u_boot_dtsi_loc)u-boot.dtsi ... \
> -	found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
> +u_boot_dtsi_pattern_raw = $(eval x=$$(patsubst "%",%,$(i))) \
> +	$(i)=$(if $(x),$(and $(x),$(x) $(if $(u_boot_dtsi_pattern),,not) \
> +	found @ $(u_boot_dtsi_loc)$(basename $(notdir $(x)))-u-boot.dtsi),(undefined)) ||
> +
> +u_boot_dtsi_options_raw = $(strip \
> +	Automatic inclusion \
> +	$(or $(u_boot_dtsi_options),(undefined)) from search: \
> +	$(foreach i,$(value u_boot_dtsi_search),$(u_boot_dtsi_pattern_raw)) \
> +	u-boot.dtsi $(if $(wildcard $(u_boot_dtsi_loc)u-boot.dtsi),,not) \
> +	found @ $(u_boot_dtsi_loc)u-boot.dtsi)
> +

> +endif

And move this endif later down to insert above the 'dtc_cpp_flags  ='...
line, to encompass debugging and avoid adding dtc_cpp_flags with an
invalid generated path.

>  
>  # Uncomment for debugging
>  # This shows all the files that were considered and the one that we chose.
> 
> base-commit: e4c8b32d03d7ecffd586b7d33336603ad639d7c0

Tested at least with starfive_visionfive2_defconfig from v2025.01
(before OF_UPSTREAM) and v2025.07 (adopted OF_UPSTREAM).

-E
