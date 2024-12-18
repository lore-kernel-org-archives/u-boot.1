Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C905E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE6380269;
	Wed, 18 Dec 2024 15:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gp9sSCdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C13180274; Wed, 18 Dec 2024 15:05:57 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6C708022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 33E8AA41BA2;
 Wed, 18 Dec 2024 14:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0E2C4CECD;
 Wed, 18 Dec 2024 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734530753;
 bh=4cTMeusGZafpAeWjhYYv8kZsKP1NkG3uWFPUU1sAphE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gp9sSCdPOZA8/xa5aby5fdrme39uVYNDdy05g5O3Qyyn5dISuV0OEwZVapS8jwphj
 7O3g77yy418VMoei+nzUbreb3/GPw322JXC4p0qMjC0Rt86J8TmDWVFMZurUi5lr/k
 dXXI4M4lYZwZYwN+z0iR7z2E/M4UT2FxkrakQlD/nQJ/bbfukGkZrqsbHAh8SQDuQ5
 z0CQ3vQt+q3QCD5ED1J9XvEelrAs1CkgRTD4Ypqugg438cso9pORGzuDu6libpOFpF
 qdes5eH1XP3wSeWGR3DnzGVFYyrOmhhaRPxL2T6wfrU3ROKWgeL+Q51zDyKi24Xy0X
 4PS4UvAFux0xg==
Message-ID: <e4b23017-375e-4430-aef2-001c1b6402ca@kernel.org>
Date: Wed, 18 Dec 2024 16:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm: dts: k3-am62p5-sk-u-boot: enable USB0 for USB
 DFU boot
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com,
 mkorpershoek@baylibre.com, afd@ti.com, glaroque@baylibre.com,
 sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-5-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241218124542.3519447-5-s-vadapalli@ti.com>
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

Hi Siddharth,

On 18/12/2024 14:45, Siddharth Vadapalli wrote:
> Enable USB0 instance of the USB controller for USB DFU boot functionality
> which requires the "bootph-all" property in order to have USB enabled at
> all stages of the USB DFU boot.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> v1:
> https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.2920799-5-s-vadapalli@ti.com/
> Changes since v1:
> - Collected Reviewed-by tag.
> 
>  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> index cf087c6e343..c2091fc1a51 100644
> --- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> @@ -16,3 +16,13 @@
>  &dmsc {
>  	bootph-pre-ram;
>  };
> +
> +/* Required for USB DFU boot */
> +&usbss0 {
> +	status = "okay";
> +};

This should come via upstream DT sync?

> +
> +/* Required for USB DFU boot */
> +&usb0 {
> +	bootph-all;
> +};

This as well? But I don't see it upstream. Do you have a patch for upstream DT?

-- 
cheers,
-roger

