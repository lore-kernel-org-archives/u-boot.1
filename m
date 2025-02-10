Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D65C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 22:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E878043C;
	Mon, 10 Feb 2025 23:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ROL22QjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7136780548; Mon, 10 Feb 2025 23:11:24 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916B9803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 23:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbf1=VC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739225480;
 bh=IzwQMzc6EtDsWg98YIKEAf8PB3wWHd2iH6GVUdvn2ME=;
 b=ROL22QjEt7RG06oqSdNCQxxhKEITWLs+esL3ALPc8YthyU3X08DTpTy1D3GyhNCygGO3Cn5n3
 sSzBCPWWzPuIcy5pTzUaXdnSEW1p2Ki4hsD3KTTRcx8Kb+hFFM1z3jRcipOpHJsoTk4WSzPJ7wg
 hx6hJYr8U0NGEIu0hQ+Zqhdx/y887vUMVkOdGlyZV/XsOlnY3WSazn9L1qb69rboJ+Svwp/5kPH
 GgNKeYLyR4F8qj7QwMUkB5YQgFj6fLsG5iqwNylGmEqEjgUbeN9eVEvUZxTOoYJGh8cSsgZB/lJ
 H8zoaJH5LinDykncNVaG1l/WUDqkFKZx4ypBj/fOa2Sw==
X-Forward-Email-ID: 67aa7985e0c507d2fc8fc017
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <020e69f7-4428-4bcd-8a78-4af819d5d0fe@kwiboo.se>
Date: Mon, 10 Feb 2025 23:11:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/35] rockchip: dts: Use the new binman template for
 the SPI image too
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 FUKAUMI Naoki <naoki@radxa.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-15-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-15-sjg@chromium.org>
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

Hi Simon,

On 2025-02-09 22:14, Simon Glass wrote:
> At present simple-bin-spi relies on the u-boot.itb file created by the
> simple-bin image. Use the template to avoid this, since Binman may
> change to process images in parallel in the future.
> 
> Drop the filename to prevent another image being created which uses the
> u-boot.itb file.

As mentioned in "rockchip: dts: Create a template for the FIT",
we should keep the u-boot.itb file a few more releases.

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 281119a53d3..79f4188b76b 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -41,7 +41,6 @@
>  #endif
>  		#address-cells = <1>;
>  		fit,fdt-list = "of-list";
> -		filename = "u-boot.itb";
>  		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
>  		fit,align = <512>;
>  		images {
> @@ -208,8 +207,7 @@
>  
>  #if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)

As mentioned in "rockchip: dts: Create a template for the FIT", this
should be changed to "#ifdef HAS_FIT".

>  		fit {
> -			type = "blob";
> -			filename = "u-boot.itb";
> +			insert-template = <&common_part>;
>  #else
>  		u-boot-img {
>  #endif

Please also update u-boot.rom in rk3399-u-boot.dtsi to use this template.

With that included this is,

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>


I also strongly recommend you break out following rockchip-u-boot.dtsi
related patches into its own separate series:
- rockchip: dts: Correct the OS for U-Boot
- rockchip: dts: Factor out arch and compression
- rockchip: dts: Add an fdtmap
- rockchip: dts: Create a template for the FIT
- rockchip: dts: Un-indent the FIT template
- rockchip: dts: Use the new binman template for the SPI image too

Those patches stand on their own and help solve the "Entry 'u-boot-any'
not found in list"-issue in "rockchip: Fix binman error" [1].

[1] https://patchwork.ozlabs.org/patch/2040246/

Regards,
Jonas
