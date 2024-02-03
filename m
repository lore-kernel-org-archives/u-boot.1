Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342A4C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 13:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF18876D3;
	Sat,  3 Feb 2024 14:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="RgDJSYZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF2138746C; Sat,  3 Feb 2024 14:16:37 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F339187527
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 14:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1706966194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3XG5chiJgitLf+hFMLtxBr1OkkeBoRpu361XjlNDDY=;
 b=RgDJSYZRRFO9Fg1MvVXnKLZrc9NgD1I9mZF5O9fyBG2UCTq0/aBhGCE2x20ElXrZKElwBx
 +iSuFJkSIok+jOXjdax9QF2RMoHECfPQLZJkLicqgfOpfe6U9DjBgGTFb6qXV1zYRN4AUr
 0cKhHiTQDWazlj8QqUHIvfwgfU8wneNaI3GkjpZm2oqNKx5mTbFb1NSIRnxVT8CwrWLlWz
 3x7hugNyW3nmsmYgeigQRP6XcWj5z5c4uc73u81UCzvMQ/O28DXG8UdyA6GiYbs3jvATTE
 5bHkeieZRolwBbKRl+e2dkckNVvwoiniEVhFDT5lYcClarVa2in/1cCruFZCzA==
Date: Sat, 03 Feb 2024 14:16:30 +0100
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
 <agust@denx.de>, heiko@sntech.de, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 04/18] rockchip: add weak function symbol called at the
 beginning of misc_init_r
In-Reply-To: <20240123-jaguar-v1-4-1eec1c34953c@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-4-1eec1c34953c@theobroma-systems.com>
Message-ID: <d9c47caef288860c8a40e8b7eec609e3@manjaro.org>
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

Hello Quentin,

This patch looks good to me, avoiding unnecessary code duplication
is always welcome.  My "Reviewed-by" is included below.

However, I've got some more comments,  which I'll send separately
for the other patches in this series.


On 2024-01-23 15:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Most Rockchip boards who override misc_init_r do it only to call 
> another
> function and keep the rest unchanged. Therefore to allow for less
> duplication, let's just add a weak function symbol that is called 
> inside
> misc_init_r.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm/mach-rockchip/board.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/board.c 
> b/arch/arm/mach-rockchip/board.c
> index 2620530e03f..d5cb59c10fa 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -297,6 +297,11 @@ int fastboot_set_reboot_flag(enum
> fastboot_reboot_reason reason)
>  #endif
> 
>  #ifdef CONFIG_MISC_INIT_R
> +__weak int rockchip_early_misc_init_r(void)
> +{
> +	return 0;
> +}
> +
>  __weak int misc_init_r(void)
>  {
>  	const u32 cpuid_offset = CFG_CPUID_OFFSET;
> @@ -304,6 +309,10 @@ __weak int misc_init_r(void)
>  	u8 cpuid[cpuid_length];
>  	int ret;
> 
> +	ret = rockchip_early_misc_init_r();
> +	if (ret)
> +		return ret;
> +
>  	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
>  	if (ret)
>  		return ret;
