Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0455E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36EBF80241;
	Wed, 18 Dec 2024 15:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ODD+8xKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8BD80269; Wed, 18 Dec 2024 15:08:10 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2631B8022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A1885A42088;
 Wed, 18 Dec 2024 14:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A3BC4CECD;
 Wed, 18 Dec 2024 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734530887;
 bh=M/VsDFYGw15F/GDX+qo/c0LKW/pkrzRqjbGGnB78EmY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ODD+8xKZmb/+MNBiRS0Zzea885uzyrUe4o+xBOl+0LYXMC9GB4PZQU5ITBmg2pX81
 PeoaMiLj+L7Ce+7TR6si+mBMyg6YT9khRhrqZYpQo7xh4TMzP0hj2ebQzRTPmoPRJE
 LIW4jSeBiWFMelS+FguB/T6guo1fKydGOacRZtlztk/EWsAlKg+bJJmuavWWwxSE7s
 TsdYfoMO/evd7M7PLzd3FNQvfFmgzH0n7aMaWwagTW9/lqJxiDGmAVaKAp0ay+DuGd
 Z458m4ZOSCl/JPVE7x3TsM+7CEuVRyNd8TsZVzTpWmLpOtD5SMWzeKXsbsrV6gzqd7
 lwC25zf25JUrw==
Message-ID: <ebc7bc88-1545-4a53-8cd0-1c9812723025@kernel.org>
Date: Wed, 18 Dec 2024 16:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] doc: board: document support for USB DFU boot on
 AM62Px SoC
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com,
 mkorpershoek@baylibre.com, afd@ti.com, glaroque@baylibre.com,
 sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-6-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241218124542.3519447-6-s-vadapalli@ti.com>
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



On 18/12/2024 14:45, Siddharth Vadapalli wrote:
> Since USB DFU boot is supported on AM62Px SoC, document the steps
> required to build the image for USB DFU boot along with the steps to
> send images using the "dfu-util" tool.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> This patch has been newly introduced in this series based on the
> discussion at:
> https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.2920799-3-s-vadapalli@ti.com/#3432702
> 
> NOTE: This patch should only be merged if all other patches in this
> series will also be merged, in order to ensure that the feature is
> documented only if it is supported (i.e. all patches in this series
> which are required for the feature to be functional have been merged).
> 
>  doc/board/ti/am62px_sk.rst | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
> index 99bdc034869..75451ad76b5 100644
> --- a/doc/board/ti/am62px_sk.rst
> +++ b/doc/board/ti/am62px_sk.rst
> @@ -124,6 +124,18 @@ Set the variables corresponding to this platform:
>      :start-after: .. k3_rst_include_start_build_steps_spl_r5
>      :end-before: .. k3_rst_include_end_build_steps_spl_r5
>  
> +* 3.1.1 Alternative build of R5 for DFU boot:
> +
> +  As the SPL size can exceed the limit when building it with support for
> +  booting from both local storage *and* DFU, in order to disable the
> +  configs not required for DFU boot, a config fragment should be used
> +  to not only enable configs for DFU boot, but also disabled the unneeded
> +  configs.
> +
> +.. prompt:: bash $
> +
> +   export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} am62x_r5_usbdfu.config"
> +
>  * 3.2 A53:
>  
>  .. include::  ../ti/k3.rst
> @@ -290,6 +302,25 @@ https://www.ti.com/lit/pdf/spruj83 under the `Boot Mode Pins` section.
>  
>  For SW2 and SW1, the switch state in the "ON" position = 1.
>  
> +DFU based boot
> +--------------
> +
> +To boot the board over DFU, set the switches to DFU mode and connect to the
> +USB type C DRD port on the board. After power-on the build artifacts needs to be
> +uploaded one by one with a tool like dfu-util.
> +
> +The initial ROM will have a DFU alt named `bootloader` for the initial R5 spl
> +upload. The next stages as exposed by U-Boot have target alts matching the name
> +of the artifacts, for these a USB reset has to be done after each upload.
> +
> +When using dfu-util the following commands can be used to boot to a U-Boot shell:
> +
> +.. prompt:: bash $
> +
> +  dfu-util -a bootloader -D tiboot3.bin
> +  dfu-util -R -a tispl -D tispl.bin
> +  dfu-util -R -a u-boot.img -D u-boot.img

Is there a known reason why -R was not used for the first command but required in last two?
What about if -R is not used for all 3 commands?

> +
>  Debugging U-Boot
>  ----------------
>  

-- 
cheers,
-roger

