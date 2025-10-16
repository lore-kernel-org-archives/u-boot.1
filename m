Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FF1CCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 12:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C85E836C8;
	Thu, 16 Oct 2025 14:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pZZUF8re";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8966836D1; Thu, 16 Oct 2025 14:34:18 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C426283655
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 14:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cnS7V6Xz8z9tVG;
 Thu, 16 Oct 2025 14:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760618054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1wLry67WQimTHzrCOof9rYcZP8WVHaYxdq5CCqC8iKg=;
 b=pZZUF8rexHj7Q97EFnhRZfawiBGjmq5YR40PeMh7Bnf1EaxYdG6SJCPZsNQcBL+e46KpCw
 l6zCQ8XpG1+5EPNVnIvz8kAxAS0a+qNvgW+3rwcZTI8xGL7T0V/XnGNGIZKvCWeS49J/ie
 tvpB4V5eNvrbwOCnW1GVjKpLbR9C1lMrn2XQWaky4jOd4jm/J5VhYUssVtd/rc2C+P0zOc
 +lNptDLaJMzd8OE2JRYKm+zgTgBZUti1NUrEpkbeSTlCUBDFz3xHVw7NvuUO220PRcz0mb
 qJE3Vy9A27FaGb/dCYedZPBHYy1OqJBNRUDb2AeyGLQAKB7h+S7yjkbzPmzNfw==
Message-ID: <84440566-5758-4d76-be25-02f40528b18f@mailbox.org>
Date: Thu, 16 Oct 2025 14:34:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: Tighten dependencies on WDT_DAVINCI
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Andrew Davis <afd@ti.com>, David Lechner <david@lechnology.com>,
 Adam Ford <aford173@gmail.com>
References: <20251001203039.2828278-1-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20251001203039.2828278-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1397f9d6c368193465b
X-MBO-RS-META: taujn88wdca8rxgrdfpatsua9fsphxn8
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

On 10/1/25 22:30, Tom Rini wrote:
> The WDT_DAVINCI driver is not safe to compile on 64bit platforms such as
> allyesconfig on a 64bit host. Tighten the dependencies here to the
> platforms which could use it today.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Note that today no platforms enable it, but based on the compatible
> string a number of platforms could, so I'm cc'ing platform maintainers
> that may want to enable it.
> 
> Cc: Andrew Davis <afd@ti.com>
> Cc: David Lechner <david@lechnology.com>
> Cc: Adam Ford <aford173@gmail.com>

Applied to u-boot-watchdog/master

Thanks,
Stefan

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f646b35eff84..309f9cd4829b 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -190,7 +190,7 @@ config WDT_DA9063
>   
>   config WDT_DAVINCI
>   	bool "DaVinci watchdog timer support"
> -	depends on WDT
> +	depends on WDT && (ARCH_DAVINCI || ARCH_KEYSTONE)
>   	help
>   	  Select this to enable the watchdog timer for DaVinci SoCs such as the
>   	  OMAP-L138.

