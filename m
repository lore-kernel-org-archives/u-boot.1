Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95650C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 08:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D1B688B29;
	Wed,  1 May 2024 10:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Fh5xqxfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E256588B2E; Wed,  1 May 2024 10:46:25 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 155128822F
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 10:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1714553183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpW02Ub2ZKIP8N7Ib8xXijqO+43pGOz9XlwQ7nClpEQ=;
 b=Fh5xqxfu+ullMUGTDgBXq+0qjJW+FI4nJ6okOXfWriVXSJG2mr9dvNo6pLs+QyF2NRTFS7
 ZzEpSWGUeo5fEvs5MxvESDbUKeHsfksZeEStPw+AXPwYCx9sNg9KabRCTp89FH1mfXCwwQ
 lN2OuAVjxRPSmIBPnhRlyBs+Sj35xaLij41BXYxgcypnUEAWw1e8TU6H2e9njrPGMNOMo7
 MLodhiNLCQKrWxVCcNVAS/KN0ibE0nUYwRPn6Wsj+FkAq5qkj2G4X3AWBeiUjkopq6cNCM
 vlvgaPmP+bvO+LS43ZYAfY3rFF+Xz1/ltfDflZCd4CxzQ+4AbYym+XyHnuYsLQ==
Date: Wed, 01 May 2024 10:46:23 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 08/18] rockchip: rk3399: Imply support for GbE PHY
In-Reply-To: <20240430153053.308788-9-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-9-jonas@kwiboo.se>
Message-ID: <f7d73995925684bde764436d76c94a29@manjaro.org>
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

On 2024-04-30 17:30, Jonas Karlman wrote:
> Imply support for GbE PHY status parsing and configuration when support
> for onboard ethernet is enabled.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: Collect r-b tags
> ---
>  arch/arm/mach-rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig 
> b/arch/arm/mach-rockchip/Kconfig
> index f580d69ed879..6f1213b1710c 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -271,6 +271,7 @@ config ROCKCHIP_RK3399
>  	imply MISC_INIT_R
>  	imply OF_LIVE
>  	imply PARTITION_TYPE_GUID
> +	imply PHY_GIGE if GMAC_ROCKCHIP
>  	imply PRE_CONSOLE_BUFFER
>  	imply RNG_ROCKCHIP
>  	imply ROCKCHIP_COMMON_BOARD
