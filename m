Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186FDC001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 11:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61559869C3;
	Wed, 16 Aug 2023 13:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DiHwjDXq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LtNXIQLJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7204D869CA; Wed, 16 Aug 2023 13:13:19 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E79868FC
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 13:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RQlqc26Tbz9sT8;
 Wed, 16 Aug 2023 13:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692184396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuLRHlj1kAtdDfBFiHUEBDhsSVVByOwFmwD/HVm8IJI=;
 b=DiHwjDXqGGBy67E6s0TO/tF2HpJEukM3Kgvav0R2ffaDq6ksU99M8qove9a2aHA9Dfi02o
 yDxQE15zXhg0qBbkwW2guUDqfQ1yb2bzCfOqu4EJp+QE6ZsDRIOtGi41lJQlR7PW2ld/LA
 n+0lkpfY78PslNL0U8bIbsKrfoti6dlYtE6kBkMQvCQBRC1W12TBH1TRO12EITIndyiHzB
 CEbuSlodk+NSfu/WT0idUr4Dm1/ND0UKPz0wjNL5Z6JoHNCNpnQmp4++KClK8XTO5Z5YeJ
 aQKWPIm/4tABYUFip2M3dbgUPGRaDjFMlPS6uWifNvtDVK+9s20ZpDf0O5KVlw==
Message-ID: <e41876d3-7bc2-08f7-9573-0aa7e7a7153a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692184393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuLRHlj1kAtdDfBFiHUEBDhsSVVByOwFmwD/HVm8IJI=;
 b=LtNXIQLJm2tJI/uid2R6CRiEAxiGBywUpgEMp7oUt7AR1LXcfR3cwggYmMRZhRQbnE7Lg0
 7kaYl4nEtXmKlkjorQwOcdMcCXapT5wZuKEqPLeU6muL1izJ/zzHRkbTlWIc0WCadhZyQT
 aEd9FuVgaoTg/RQx+ZiG/XtsZMP8g2nHfocZlEvFnNgOGE1Dt/1AQp3Y8xQ3Rz4QWsSS1c
 WlNmE/4ODw1CFX6GgZzAO95CFFuE6EzZ6OVgdjc60CpZiYHGWm6+k7BMzAs4ZN5phpYz63
 91928Bi5U0/JVc7XG7Y75i7i4gy5eR6qoKzSx4TE/8x+/9peFUZ1lPKr9rMDSw==
Date: Wed, 16 Aug 2023 13:13:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] log: select physical address formatting in a
 generic way
Content-Language: en-US
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, sjg@chromium.org
Cc: marek.vasut+renesas@mailbox.org, nd@arm.com, trini@konsulko.com,
 u-boot@lists.denx.de
References: <CAPnjgZ34z865voaKeShSJpdvWcFLbN0OEWBnus4qt0W_1P4jBw@mail.gmail.com>
 <20230816110551.86930-1-abdellatif.elkhlifi@arm.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230816110551.86930-1-abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b4d41d829bcd159d0ee
X-MBO-RS-META: 99agf3dow34q3whd4kdott9jz53fjxb9
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

On 8/16/23 13:05, Abdellatif El Khlifi wrote:
> sets the log formatting according to the platform (64-bit vs 32-bit)

Use imperative mood please, see
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>   cmd/armffa.c  | 8 --------
>   include/log.h | 9 +++++++++
>   2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/cmd/armffa.c b/cmd/armffa.c
> index 7e6eafc03a..ab0fd54d97 100644
> --- a/cmd/armffa.c
> +++ b/cmd/armffa.c
> @@ -13,14 +13,6 @@
>   #include <stdlib.h>
>   #include <asm/io.h>
>   
> -/* Select the right physical address formatting according to the platform */
> -#ifdef CONFIG_PHYS_64BIT
> -#define PhysAddrLength "ll"
> -#else
> -#define PhysAddrLength ""
> -#endif
> -#define PHYS_ADDR_LN "%" PhysAddrLength "x"

Would it make sense to implement printf '%pa' formatting string instead ?
