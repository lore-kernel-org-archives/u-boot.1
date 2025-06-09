Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5653BC61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 13:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9558982B07;
	Mon,  9 Jun 2025 15:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NUyoZIV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B9D82B07; Mon,  9 Jun 2025 15:07:17 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84E86811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 15:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 757315C63D1;
 Mon,  9 Jun 2025 13:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78144C4CEEB;
 Mon,  9 Jun 2025 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749474433;
 bh=akCI4z5x3d0AGCHOX024zSrTs2mlJ2/jxVMumTvfQ7U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NUyoZIV8y6HESD7G4FY0OkO0UnCedIS799lYfITYk4Kx+WXTQiJEtIF4PTjDNeEhh
 T4WEUD6efkq7r6ahhu9CtJ/0z2QwV9Edb1EuAWXMWKfx5huj34qcO0IcmBlY5V6DG1
 m96gfad+wlnpuZ61wQd2ii4wPyzWfN1O3Y85YQi9OvnyGh2UF2KX2ZgFTVVDCyeXt0
 owbWxLMXwTiRpgk10mxB9bgQsGvMCI0GosvbY8c/ubMF7dfQMmZhM3YOv14x8Kqbjo
 4PQhWcd3WA2foihwa5sb54t7MymDD0qwxy9kJm5f96HBbVWunBZYAS84rVwnFqj44j
 +l4Mv+DCmcToQ==
Date: Mon, 9 Jun 2025 14:07:09 +0100
From: Sumit Garg <sumit.garg@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: [PATCH 1/7] scripts/Makefile.lib: Rework upstream_dtsi_include
 to use find
Message-ID: <aEbcfbPTLl7zZh1G@sumit-X1>
References: <20250528233050.3820722-1-trini@konsulko.com>
 <20250528233050.3820722-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528233050.3820722-2-trini@konsulko.com>
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

Hi Tom,

Apologies for the delayed reply as I was on a vacation followed with a
business travel.

On Wed, May 28, 2025 at 05:27:04PM -0600, Tom Rini wrote:
> A problem with the logic in upstream_dtsi_include currently is that it
> does not list directories such as dts/upstream/src/arm/nxp/imx and so
> will not findi "imx6ul-pinfunc.h" for example as it is normally and
> correctly included without vendor sub-paths.

I can see the problem you are trying to solve here but I fear in future
we might see some header collisions when going too deeper into
sub-vendor paths include. But let's not worry too much about that at
this point until we see a collision as it's atleast provides a way to
drop redundant DT bindings headers. Thanks for working on this.

FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> This becomes a problem if we remove identical header files from
> arch/arm/dts for example and only always use the upstream one.
> 
> Cc: Sumit Garg <sumit.garg@kernel.org>
> ---
>  scripts/Makefile.lib | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index e89a4a51b74d..ac14e4f9dfb2 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -205,8 +205,10 @@ dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
>  # Modified for U-Boot
>  upstream_dtsi_include = $(addprefix -I, $(srctree)/dts/upstream/src/ \
>  	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*))) \
> +	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*/*))) \
>  	$(if (CONFIG_ARM64), \
> -		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*)))))
> +		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*))) \
> +		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*/*)))))
>  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
>  		 $(UBOOTINCLUDE)                                         \
>  		 -I$(dir $<)                                             \
> -- 
> 2.43.0
> 
