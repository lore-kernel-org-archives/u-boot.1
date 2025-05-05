Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A8CC369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 06:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1CC680BAE;
	Mon,  5 May 2025 08:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746427624;
	bh=RHxpXrGRLfuuHVnC7l2ivb8B8DIwrFionSqEqxK4KtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XnYaBxZYoy6QCj+hdFMEYFjTGur//ppkC7FOPIbCcc0k84Mrv8qkCLe/1IgtD622r
	 ARnlifuxac3x/CJWX4msk9wb3gmrHECvJfCIWl0GIw+ZaW8GTV5Pbf+GUmCYgwx6al
	 UYz922QWsmv2lhEWygeQ4jp8/lObots8X5J/RqzrDuDBMu7+T9iCPbu/6NjE3p+ti3
	 oYgytg105UPdMcUuVeUVXpyYURM6zR3zimVJKHkpKLXMJrv9prlmekgoqzomG3Njke
	 9bOVraUuHvya5/woKYkMK0kpQ/QHJ3jqZa5yYszAz0YdA5Jw/rpveaGQJIP0bSfsEE
	 PAgvq3Sx0dLmA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A576480F03; Mon,  5 May 2025 08:47:03 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF4E805D7
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 08:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZrXBW3Fb4z9shq;
 Mon,  5 May 2025 08:46:59 +0200 (CEST)
Message-ID: <5cffc4b6-d671-498d-938c-96db3adffe03@denx.de>
Date: Mon, 5 May 2025 08:46:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/6] arm: at91: wdt: Remove at91_wdt struct
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
 <20250428-wdt-v4-1-bb7d1c7c051a@hifiphile.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250428-wdt-v4-1-bb7d1c7c051a@hifiphile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 28.04.25 11:16, Zixun LI wrote:
> at91_wdt struct is only used by spl, remove this reference and the struct
> itself.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/arm/mach-at91/include/mach/at91_wdt.h | 6 ------
>   arch/arm/mach-at91/spl.c                   | 4 +---
>   2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
> index 8ef8e007d7767308a5b46be46b02c51073723a41..78ad0453fd9eb3e42674d10cb11ce3da820cdc6a 100644
> --- a/arch/arm/mach-at91/include/mach/at91_wdt.h
> +++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
> @@ -19,12 +19,6 @@
>   
>   #else
>   
> -typedef struct at91_wdt {
> -	u32	cr;
> -	u32	mr;
> -	u32	sr;
> -} at91_wdt_t;
> -
>   struct at91_wdt_priv {
>   	void __iomem *regs;
>   	u32 regval;
> diff --git a/arch/arm/mach-at91/spl.c b/arch/arm/mach-at91/spl.c
> index 5feb8f735511a45dd37ee04bb3742f57d8f2e067..a814973242a723c47af210bd76db9210db061063 100644
> --- a/arch/arm/mach-at91/spl.c
> +++ b/arch/arm/mach-at91/spl.c
> @@ -14,9 +14,7 @@
>   #if !defined(CONFIG_WDT_AT91)
>   void at91_disable_wdt(void)
>   {
> -	struct at91_wdt *wdt = (struct at91_wdt *)ATMEL_BASE_WDT;
> -
> -	writel(AT91_WDT_MR_WDDIS, &wdt->mr);
> +	writel(AT91_WDT_MR_WDDIS, ATMEL_BASE_WDT + AT91_WDT_MR);
>   }
>   #endif
>   
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

