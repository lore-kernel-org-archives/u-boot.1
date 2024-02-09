Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6585C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 17:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6602887E7C;
	Fri,  9 Feb 2024 18:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="fVyjSj8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4DAF87E7E; Fri,  9 Feb 2024 18:55:09 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD34F87E7C
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 18:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707501306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Nv+sQmS7+nonD8L/8/vFw89WlWJOI1OJEbMGQHYR2o=;
 b=fVyjSj8CugSVCXUjC8WEO8PVdqk9qf6ejdq/5IC1jybhmvp7L0rVMDzpaKp4AgEjLpbX5s
 WOBjdcyimytw2vKaplg3oOrldXrafPIRuH0G/jbpJVM/abuaJA7PyVGE1DNis9ZFczAF95
 mFPlrgSyoHhTvnWx+q/itQn0jnwLetyTy5sz42WBPJU5jlV66gxLzOPWPaZGlxkodvV6sa
 X9oPjTfBxKGMAwrs8ZtI+D7J0Ztu+NqlZDqN5et1xb4o6VxY5ASgo3vdUWHdweUZNnjDNl
 NPF8/hti9gxqqgqKidTcIIciH4hoX1gi4cRPBVokanTOLnis2B8nTha7QdCa6w==
Date: Fri, 09 Feb 2024 18:55:05 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Tom Rini
 <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Peter
 Robinson <pbrobinson@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>, Andy
 Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2 01/20] rockchip: avoid out-of-bounds when computing
 cpuid
In-Reply-To: <20240209-jaguar-v2-1-6c9ffe09b924@theobroma-systems.com>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-1-6c9ffe09b924@theobroma-systems.com>
Message-ID: <4bf8e1bd927b85926b2e0dffadb28c12@manjaro.org>
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

On 2024-02-09 10:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> The expected length of the cpuid, as passed with cpuid_length,
> determines the size of cpuid_str string. Therefore, care should be 
> taken
> to make sure nothing is accessing data out-of-bounds.
> 
> Instead of using hardcoded values, derive them from cpuid_length.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm/mach-rockchip/misc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/misc.c 
> b/arch/arm/mach-rockchip/misc.c
> index 7d03f0c2b67..15397cff009 100644
> --- a/arch/arm/mach-rockchip/misc.c
> +++ b/arch/arm/mach-rockchip/misc.c
> @@ -102,7 +102,7 @@ int rockchip_cpuid_set(const u8 *cpuid, const u32
> cpuid_length)
>  	int i;
> 
>  	memset(cpuid_str, 0, sizeof(cpuid_str));
> -	for (i = 0; i < 16; i++)
> +	for (i = 0; i < cpuid_length; i++)
>  		sprintf(&cpuid_str[i * 2], "%02x", cpuid[i]);
> 
>  	debug("cpuid: %s\n", cpuid_str);
> @@ -111,13 +111,13 @@ int rockchip_cpuid_set(const u8 *cpuid, const
> u32 cpuid_length)
>  	 * Mix the cpuid bytes using the same rules as in
>  	 *   ${linux}/drivers/soc/rockchip/rockchip-cpuinfo.c
>  	 */
> -	for (i = 0; i < 8; i++) {
> +	for (i = 0; i < cpuid_length / 2; i++) {
>  		low[i] = cpuid[1 + (i << 1)];
>  		high[i] = cpuid[i << 1];
>  	}
> 
> -	serialno = crc32_no_comp(0, low, 8);
> -	serialno |= (u64)crc32_no_comp(serialno, high, 8) << 32;
> +	serialno = crc32_no_comp(0, low, cpuid_length / 2);
> +	serialno |= (u64)crc32_no_comp(serialno, high, cpuid_length / 2) << 
> 32;
>  	snprintf(serialno_str, sizeof(serialno_str), "%016llx", serialno);
> 
>  	oldid = env_get("cpuid#");
