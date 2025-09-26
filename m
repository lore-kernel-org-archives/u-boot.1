Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C30CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7980E83666;
	Fri, 26 Sep 2025 17:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BvLyUveF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91B7C83666; Fri, 26 Sep 2025 17:44:51 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903C2835B9
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-634c01ca9dcso963529a12.3
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758901489; x=1759506289; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7DkgV5Au5ifJ9G61xpiLmNEZiF+MBzwTCsNDBHfSXAU=;
 b=BvLyUveFrAQEeFO+KLHg65TVkBm4OM7peq0PPj/U2sqiHcP2ec89uhPOH4lnDfke9T
 I9PhlRGiFuAOXwN8inHWVEz5UgyG+y0jnDXfur2hhyhye1JWUiRxlIg6fJolf8N0pQN1
 pkn2RnoaUfrRpz0oWK6RKwuKh8AWno/iunjHYyG1K/wA1AW+C+e5YuB3coaEoxCHTxq/
 A+2P9fpWu2A6ZruBytkN7ckLvHJTGW2Qui79zLBxghxBq8gJM8vgWPt39QH069LgVITg
 qeoKfARaWQJ7EKRefspAMT9ScGGfVWGAb4PkEtCuTywr96KkDO0VA9UK8/FMtbDQEpKR
 wmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758901489; x=1759506289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7DkgV5Au5ifJ9G61xpiLmNEZiF+MBzwTCsNDBHfSXAU=;
 b=S8oULNToNpI2Ry4dHM9yYIPcGYYaFzqsHjcmNYi9H8FxGvVFmcCJs/07hIa72MTi2H
 M/sn1BVweff9mQbGD16fiyR1Jm5EH5sP8H0+9eLwUB1tjD4b6jGT4g/WhESP+wb8y6RS
 //6Rpqr4xxmvlxhXAjDp/2DALezbpJpi4EBMmrucsynpJbNvXU0TlgG8UM08ViB64Lid
 iaf9ydOKc64NXPJqq68/olgvBWbX/i2T77DlUIo2WDXvl//Boh3ZkCzBuqPCDIAPlSHF
 +KX4aXfHBoU6WSImrNmEtDNvxuHfjdeSRa11iXz0XNf2MEt3wlkO4phUqrE3FPqUDpcy
 fRLw==
X-Gm-Message-State: AOJu0Yz3yyyDzbMiKaeu6fQ09ox44wP/Mm2HvcBfivn5H0AR6qFJdILd
 u9cTbA/dJsplWcPg/PZHlyVHOcsyF3QLYmsabZAse68/v7P8ETLgfUcpYlNt3yf2bRudHRkRFQZ
 bLiZmRL87urCARPhATp3JrsCoP8vbjes=
X-Gm-Gg: ASbGncsXCuln1fs/sHKPbXdOk0I5o4RnOUqbfYO67nDHDJ9P1aQ4LKRtNkFeADYD1BQ
 cGDamVv4WPPuG+KdjaNQ0NtdcKgJxJuZ2/++mPf6+Cl0FcLFkgyL+MVh61bROENEwTE4HYt6JYN
 +DjNyzlYC7SZuC96GBM0cvsBz63wQfS6W6JcVKhUik+sdMRlDMUbmHzQSs8ISOQP/rtyyi7g7az
 P6Yr5c3Jv5uBsHI/L4lxtQHv5T0Hw5fnMeExhlNNPsADIuh5ovX2QOrNfFu5dY30myn3qXPwwW9
 zJi97u2blW38Suy8gUstOYkhNg==
X-Google-Smtp-Source: AGHT+IF0weUcebFruyWEtx+IAxYfZYu9bYUvHHRA3UmEsn8FTJMEfjw9FlfYjz7VqmWJcjTBqULx9Kz3FoIy0F1fxCo=
X-Received: by 2002:a05:6402:14d2:b0:632:d9b:271e with SMTP id
 4fb4d7f45d1cf-6349fa7f9e3mr5771881a12.22.1758901488039; Fri, 26 Sep 2025
 08:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250926153034.3680674-1-trini@konsulko.com>
 <20250926153034.3680674-3-trini@konsulko.com>
In-Reply-To: <20250926153034.3680674-3-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 26 Sep 2025 16:44:36 +0100
X-Gm-Features: AS18NWBMtBfAgPyqa9ssTig57l2EcWUIhJqq2XNwB-x8JIQ_AMzuYYH6nf14G5c
Message-ID: <CALeDE9OKgLg-_qsSDFe4NgM5AD3e0XQQa+y52Ybr0erDbu7NUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] usb: gadget: Tighten the dependency for DWC2 OTG
 support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 26 Sept 2025 at 16:30, Tom Rini <trini@konsulko.com> wrote:
>
> The DWC2 OTG driver depends on an ARM-specific header file to compile,
> so make it depend on ARM.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - None
>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/usb/gadget/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 0121f9872ae6..9065e14768ad 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -109,6 +109,7 @@ config USB_GADGET_AT91
>
>  config USB_GADGET_DWC2_OTG
>         bool "DesignWare USB2.0 HS OTG controller (gadget mode)"
> +       depends on ARM
>         select USB_GADGET_DUALSPEED
>         help
>           The Designware USB2.0 high-speed gadget controller
> --
> 2.43.0
>
