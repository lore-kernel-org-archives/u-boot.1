Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B429EF5A8BC
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A49844FF;
	Tue, 21 Apr 2026 00:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LPXWoKCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80120844FF; Tue, 21 Apr 2026 00:15:07 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 352D8801A9
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbd801138eso2211546a34.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776723303; x=1777328103;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=en4sgSQAk+py8v0pNMYgluj7M8GwojkdYx+UQVSMgBQ=;
 b=LPXWoKCLTo2Chd/Dc2O9oOvmXdMrLYc7/os/0/8HoOSToCylaa3wzACIG7ZgD1MnYG
 9fOX3oOAbfbQMvXs5h3LMxPYODrepM0uVxSHyMuBVRkMj3T4kLgF2s/puxIp3xpykDh5
 qFpjpmqKD+0i+Y3EzE06ALDDTC+6aFtjeEpZyvte/xHtpx18ju8ipO8PZmkkawf6A7kM
 xN3hz3qq26bHxunUvq2diyvqCFIUVQ6AVvlvrUJtjWn37NKNFDuyYNJ+8eLTliPNDajg
 5mqd1J60oUu03xM1JCmKMWW7zqIrZgFlmy+/PAM0XUP0OQ7DI6Oj2l6Ui8dLnJ4eGyOe
 qtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776723303; x=1777328103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=en4sgSQAk+py8v0pNMYgluj7M8GwojkdYx+UQVSMgBQ=;
 b=ZI7oLLGWT5RRAvN7Fj4kXikEuBYZYXjQ1xhgOoPHtsA0EuqigsXafhGatCJFnUOWkS
 ZeeIxRfawdn8CSMewiVbUC4Riq+iPv/ET1Jz0vroaO15ySSfZz7bYLTAYv/gNPhqPsnR
 NTyISQNcVIS3EeMk3STprHKxyaWg4DwO9hJAcQzAqO6lpReRzi+bU0cKQvsK3x+FhhZY
 5ViuHeSaA6E9QVC4PxQQREUOJVVIiFy30AMQpOLspKdzbCkTJCxM12ve0Ow+1AED5LaT
 CDUpXEHtVpE/8bTqIkuSMXk3bqRKGeYasVcFAYp1dIsXfmDglyMsJiEU6BBcardb5SWn
 xfKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ygRs8yU8poFVO5t19uPoUFkq2fHIY74SaUxVAH3tvBDNllPaJw18O7S9X85kJat8ZELAxpQM=@lists.denx.de
X-Gm-Message-State: AOJu0YyscLXu32zbZjdIxxreurM20gOwyblNTyUdDP77AL9+L7ct3Pr6
 YzhXvx3LkCdKY3ybhWWQuWDOVXf9pf1DDk3io47nLRtZWQs+tvH4vrhPX3djkrC8LkA=
X-Gm-Gg: AeBDietapTCpae1OrZP+/AlP6kxL4PqGflBuUlVOgZwPTBaF8i8QvuXoojIWBfzwhAL
 v3+LO83JSVecm/ZEqOMcUdjY32GinAWOW7URZvMzgH3qc2Rea8cgz1kgzVA6PyLxQGCH3Ve4zm2
 o8wW/rfGHrb/nADpBawTtNetWzdHWuhZHtkp56Yr4aHQAV3JBbbVWFvcx9Jy9TnLDvKm+pBKy70
 eWwJ80pRzMXwog9qngdXzcd44dcotjja45iQRUayeKBGDTrxJE6f6TC5kuEqLk0g64uyAgUAKNd
 lsVOT7Atzfav4HwhxHzlwb3ewyq3fOjePlM/qbFBeFf0KCk5NFJGg5KSx/6WvUdagyrixRCDWRv
 IOoZ2i3QR9rOOlfkE+/9HUUW/7wozYwyW7gzmh7XynLwl2pMVXsN25sQGh6PGCOu4hZVuzyS0fX
 hlMHVJbigW3ku7tMS2MCMUqOFIEFS/IBqJJtd0orkIwZRvcQzZsCtiW66b5pBLh8L6hXEWCmUkY
 GMkxpQR0egKY3iwD8xKpmM=
X-Received: by 2002:a05:6820:f09:b0:67c:28d6:430e with SMTP id
 006d021491bc7-6946385f12emr7168804eaf.28.1776723302710; 
 Mon, 20 Apr 2026 15:15:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:49fb:b337:a968:94e7?
 ([2600:8803:e7e4:500:49fb:b337:a968:94e7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-694984114f5sm33315eaf.7.2026.04.20.15.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 15:15:02 -0700 (PDT)
Message-ID: <61daa047-74f0-4a76-a61f-de54ca4b716e@baylibre.com>
Date: Mon, 20 Apr 2026 17:15:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: mkeficapsule: Add disable pkcs11 menu option
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Franz Schnyder <fra.schnyder@gmail.com>,
 trini@konsulko.com, "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>,
 Francesco Dolcini <francesco@dolcini.it>
References: <20260420083850.8504-1-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260420083850.8504-1-Wojciech.Dubowik@mt.com>
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

On 4/20/26 3:38 AM, Wojciech Dubowik wrote:
> Some distros are using gnutls library without pkcs11 support
> and linking of mkeficapsule will fail. Add disable pkcs11
> option with default set to no so distros can control this
> feature with config option.
> 
> Suggested-by: Tom Rini <trini@konsulko.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
> Changes in v2:
> - make use of stderr more consistent
> - add missing ifndef around pkcs11 deinit functions
> ---
>  tools/Kconfig        |  8 ++++++++
>  tools/Makefile       |  3 +++
>  tools/mkeficapsule.c | 17 ++++++++++++++++-
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/Kconfig b/tools/Kconfig
> index ef33295b8ecd..ccc878595d3b 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -114,6 +114,14 @@ config TOOLS_MKEFICAPSULE
>  	  optionally sign that file. If you want to enable UEFI capsule
>  	  update feature on your target, you certainly need this.
>  
> +config MKEFICAPSULE_DISABLE_PKCS11

Options that disable something instead of enabling it are confusing.
Can we make this MKEFICAPSULE_PKCS11 instead and invert the logic?

> +	bool "Disable pkcs11 support"
> +	depends on TOOLS_MKEFICAPSULE
> +	default n

I think it would be more convenient if we did not require PKS11 by
default. Otherwise, everyone using Open Embedded that doesn't have
the "p11-kit" PACKAGECONFIG option set for GnuTLS set (which is the
default) is going to get a build failure and have to research this
and find the option and modify their config to fix the build.

It seems like it would be better to make people who actually need
PKCS11 possibly get an error by default instead and enable the
option. This is pure speculation on my part, but it seems like
this would be the smaller group.

> +	help
> +	  Disable pkcs11 support. Can be used in cases when host GnuTLS
> +	  library doesn't support it.
> +
>  menuconfig FSPI_CONF_HEADER
>  	bool "FlexSPI Header Configuration"
>  	help
