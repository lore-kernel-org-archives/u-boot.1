Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57FBCCF9E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A1EA88BD2;
	Wed, 25 Sep 2024 19:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727283917;
	bh=ofNyExE8wol+kLc8Go9ZHb5OOSjsGpp6Dc3F1ls4nBI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CDEfJBzWGtZdOM4xZTWVEv5+boO9bn+nUPkm8Wv7jE8L2lEmWIdvbkFvexETpprwG
	 2fvrENgAHt25P9iJttsGPVhWLtmJOGa9tDQRiBo2GxCJMRcSd9PMnGaFm+B934qXcZ
	 YJ5NB2MrdoDHQtE5XJwm60SLzp+Vzp+yK0NnYZwcc9eZtZNoTKoEiC1sB6WS4af8VA
	 f+oP7iCz+QC0qkmwcdn9dy+lU948Yl7tKjZilUnX8JwvMPWiNdovoRSQUTR3h1Ozc4
	 iOrFXxr/spfLsYKMalscdlrgfK7SLdN735FZj6pfnl/zGGEiGKHa/GRV3mzkk+GApp
	 IaVCuD/Aqb1rg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 644DF88216;
 Wed, 25 Sep 2024 19:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727283911;
 bh=ofNyExE8wol+kLc8Go9ZHb5OOSjsGpp6Dc3F1ls4nBI=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=i04lrvrT9NgP/Ny1y2kdVEvlwGVSfj7qfMyh5L0SphPCU15lm0JFM+UnwK3qtkhUJ
 RsTVFb+ISAyilQGpGx2ce7X/jWlZ79FBks6Tjlf9tm2lMrgi1tvPHPsI9MAkbgmvND
 jKfoDtUZyNMKOwXqBW473+nxS0uA6AT2d7o0tD3RNRnqOZLISdao07sU0492M72aFk
 sQ1GI6lOaCTguC1yBtQz71CoQ88ABU/hZuygwS9f9bRMEODWX4+dq0JskxorY9tTyF
 TTSltXnPxEdzZwpJWLOP+nFKyx2+58wavrJ7X34Q4ujEA8I8BTYqGHqzW3lo97NaZF
 jtSE4Xkid7TfA==
Message-ID: <05eaecb5-4c5b-4220-b1d1-51c938b6705b@denx.de>
Date: Wed, 25 Sep 2024 19:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ARM: stm32: Fix secure_waitbits() mask check
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com
References: <20240708114344.18354-1-marex@denx.de>
Content-Language: en-US
In-Reply-To: <20240708114344.18354-1-marex@denx.de>
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

On 7/8/24 1:43 PM, Marek Vasut wrote:
> Do not apply bitwise AND to register value and expected value, only
> apply bitwise AND to register value and mask, and only then compare
> the result with expected value that the function polls for.
> 
> Fixes: b49105320a5b ("stm32mp: psci: Implement PSCI system suspend and DRAM SSR")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>   arch/arm/mach-stm32mp/stm32mp1/psci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/psci.c b/arch/arm/mach-stm32mp/stm32mp1/psci.c
> index e99103910d9..ffdafea464d 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/psci.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/psci.c
> @@ -393,8 +393,7 @@ static int __secure secure_waitbits(u32 reg, u32 mask, u32 val)
>   	asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (start));
>   	for (;;) {
>   		tmp = readl(reg);
> -		tmp &= mask;
> -		if ((tmp & val) == val)
> +		if ((tmp & mask) == val)
>   			return 0;
>   		asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (end));
>   		if ((end - start) > delay)

I hope this bugfix will make it into 2024.10 , can you prepare a bugfix 
PR for 2024.10 ?
