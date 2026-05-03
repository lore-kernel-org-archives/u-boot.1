Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE88CD3424
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 12:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 738F783FEC;
	Sun,  3 May 2026 14:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wIrvCVFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC8484255; Sun,  3 May 2026 14:23:01 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C49883EF9
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 14:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g7kSb2jW1z9try;
 Sun,  3 May 2026 14:22:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777810975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8zievvHAd96O3k8y4tLV4GqIOaUBcomy6r0jgKD1c4=;
 b=wIrvCVFW6mMxjUOhihk/FZ3Pv9DyEhYk3sI97GylATXHJDyAzthk9kxaltllLMn7lf5FUc
 YoSsZL+WvpZe8YXK64plQe81Zm9Lr2rh3w87nc3EP91sf+IOc0YCj7qAR+8RMTinJ+7gXr
 ScWoLLVEznzFRgaU5huVWZL7qwzqg9LdD36lFA0lN1Firu9bP+myrlGrdxMbD9jGxFS/vi
 AdRkyhbxL6vRVSmUoBMrEY9zbFP2UlIcov2EVGqL08ZaGu1LVXZsjrgRw4tdlrTtSqaoVn
 6MyMx/xIyNcZXbpM1tAB4odvFX6Eqisb6Xm8gM5r34Dh0qteHDxIlJgfWvtFGg==
Message-ID: <39578a88-0ac2-4d8a-b333-c94b241fff0f@mailbox.org>
Date: Sun, 3 May 2026 14:22:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: apple: Add "apple,t8103-wdt" compatible
To: Janne Grunau <j@jannau.net>, u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
References: <20260430-apple-compat-watchdog-v1-1-dbb6da4cec6a@jannau.net>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260430-apple-compat-watchdog-v1-1-dbb6da4cec6a@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: edqoexn43ju6rm45q87tsn3gqcs6mrbt
X-MBO-RS-ID: 284c76dc482b61f285c
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

On 4/30/26 23:34, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,wdt" anymore [1]. Use
> "apple,t8103-wdt" as base compatible as it is the SoC driver and
> bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,wdt".
> 
> Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
> Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/watchdog/apple_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
> index c7307f41cb7..9e998994216 100644
> --- a/drivers/watchdog/apple_wdt.c
> +++ b/drivers/watchdog/apple_wdt.c
> @@ -78,6 +78,7 @@ static const struct wdt_ops apple_wdt_ops = {
>   };
>   
>   static const struct udevice_id apple_wdt_ids[] = {
> +	{ .compatible = "apple,t8103-wdt" },
>   	{ .compatible = "apple,wdt" },
>   	{ /* sentinel */ }
>   };
> 
> ---
> base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
> change-id: 20260430-apple-compat-watchdog-3de8a1053b88
> 
> Best regards,

