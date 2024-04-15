Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BA1C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 693A68811D;
	Mon, 15 Apr 2024 08:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="hT/x99sq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C33F8799C; Mon, 15 Apr 2024 08:47:26 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF4F8814A
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713163644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0I3SN+jsUjJm1OUCfpacPVh+w4kEs1RYHfd2OwJeB+g=;
 b=hT/x99sqgSXkOIu9ghAAnYZYGvhgfQu0AbVyhCvpu+uYsqwT5G8kUfC3qSbGfZ3wt9DH6W
 yq+AHFH1uQf8H3eQnb84pTmhV2iN1B1XV9hcjRBaw5xSEWCtcHY0eUw0h1r6E8KCbFXfyj
 +LT4d1s6oM0YjHIbxSucIIjJ1PIo/KxRpqsBMPvKl3go0t2gRKH5PYstu6dpiBD39cKgq/
 3aMvxX6s19OwgAanDf7nRuBqg2/Pq30cA7hQN4KPZ5QTDF40f98RUKpqwDnl5axkH5K7Zc
 9O+p+dd25Mk/9hnfTPOKpcTkxEHKYE3vrIbplE9bq7j+EbXr4owHeTHULvoiXg==
Date: Mon, 15 Apr 2024 08:47:23 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andy Yan <andyshrk@163.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 14/23] rockchip: rk3588-coolpi: Add boards to
 documentation
In-Reply-To: <20240413181425.1384357-15-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-15-jonas@kwiboo.se>
Message-ID: <c0990cc8e132400eb8542bc048520961@manjaro.org>
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

On 2024-04-13 20:13, Jonas Karlman wrote:
> Add the CoolPi 4 Model B and CoolPi CM5 EVB board to the documentation.
> Also fix .dtb-file entries in Makefile.

Perhaps the patch subject could be improved a bit to also mention
fixing of the Makefile, but only if there will be v3.

> Fixes: 3e15dee38d45 ("board: rockchip: Add support for rk3588 based
> Cool Pi CM5 EVB")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: No change
> ---
>  arch/arm/dts/Makefile           | 4 ++--
>  doc/board/rockchip/rockchip.rst | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 08dfbdd557b7..38d259a7035c 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -167,8 +167,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>  	rk3568-rock-3a.dtb
> 
>  dtb-$(CONFIG_ROCKCHIP_RK3588) += \
> -	rk3588s-coolpi-4b.dts \
> -	rk3588-coolpi-cm5-evb.dts \
> +	rk3588s-coolpi-4b.dtb \
> +	rk3588-coolpi-cm5-evb.dtb \
>  	rk3588-edgeble-neu6a-io.dtb \
>  	rk3588-edgeble-neu6b-io.dtb \
>  	rk3588-evb1-v10.dtb \
> diff --git a/doc/board/rockchip/rockchip.rst 
> b/doc/board/rockchip/rockchip.rst
> index 5dd5ea7f1e29..9a726e9cde63 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -131,6 +131,8 @@ List of mainline supported Rockchip boards:
>       - Turing Machines RK1 (turing-rk1-rk3588)
>       - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
>       - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
> +     - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
> +     - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
> 
>  * rv1108
>       - Rockchip Evb-rv1108 (evb-rv1108)
