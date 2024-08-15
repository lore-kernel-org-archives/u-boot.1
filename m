Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0687DC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D012388C2E;
	Thu, 15 Aug 2024 22:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BMVvLInM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9617488BFC; Thu, 15 Aug 2024 22:33:23 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC9188C30
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2cb5789297eso985443a91.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753998; x=1724358798; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zz6Uhq7I+1JRUqcYE+10xoQ03zRFKwk0AHHbUznAb7g=;
 b=BMVvLInMBCJvzdEn+GYLIXReBbbozO9sf9JWp7b5IqnrnWkHiKkEEtiyRbesaWQ7+M
 uv7e1nY6Axeuk3tINVlQbPe5I3ClNWK9MYDGhbrUvTynX3RDkdZ/u9F/3d6ZUOsMXXPn
 lkV9uN7jJJV9XomI3jCxz1+3Z4cSrtkrzrCKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753998; x=1724358798;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zz6Uhq7I+1JRUqcYE+10xoQ03zRFKwk0AHHbUznAb7g=;
 b=cPtzt5u/v8US0BbWjMQbC3iz6d+VG8kOzbwRr4oQSfkUNffDc3YjiHbdPpZ9RcOnmF
 7uKHuXKC7CF+G7s7hkWiWyKZ7SjkJjOE4YfSkYpfeo26a0OxmgKwP0jvw1G8szUTQDhJ
 0vIPGLRw2aWngO/zB/w+NRreQ1Ry1997Efsb45zpIqTpve0nauQeXN31ZChiyZTUVLD+
 KVoGMyEpEsfOReyP6ZxBPDSM37/OGPU9398Rn2UBQhgj2WQzRr3YDfJm4wR6XLNwxJZX
 4yA8OuaIl/dW+UdVWiMrN1d8U91kfRI6elH+bkeLYIMtz/4Q/5gtW5roDv5mxbg06mkl
 ro4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd7fpBnOT0ekGeosOEWT8vJ65UlixIWrdG2aeOAwVPl4CPeUBJhqLq4KqGmF+93KWMWORUfEgW/8N2flpa19MxXPkTNw==
X-Gm-Message-State: AOJu0Yy1pRx+OX0BhQPITkJpDClyc44AwicT0UJbewFGPk/Mnpmffbji
 ZsQYpalGQlwPC0pisA5MLV9OoQy3QLipsKpAdzCmAKybg9fgR8H7ZZ/HSq57JqPxIYP5CUlmL13
 isuPfArHFKRJ9VsbG20jJDH3xG10Wc/ytm7pZ
X-Google-Smtp-Source: AGHT+IEF7m/mxpFz4auULnY+dmhBIHoSU2rxTgTbEq6gX4dl9nvZXHansSzRyFTUv73jUY1AIVdPZb/JXv9q4k8/ui8=
X-Received: by 2002:a17:90a:ca89:b0:2d3:cd22:e67b with SMTP id
 98e67ed59e1d1-2d3dfc37c7dmr975642a91.6.1723753997646; Thu, 15 Aug 2024
 13:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240814134518.82692-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240814134518.82692-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:33:05 +0100
Message-ID: <CAFLszTjrBL-GonZKqp3Ab5vQPMZ+BZu8V21y4z0qBCGuH64uJw@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: clean up the efi configuration status
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Anton.Antonov@arm.com, Tom Rini <trini@konsulko.com>, 
 Ian Roberts <ian.roberts@timesys.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Shengyu Qu <wiagn233@outlook.com>, Jesse Taube <mr.bossman075@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Anand Moon <linux.amoon@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de
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

Hi Ilias,

On Wed, 14 Aug 2024 at 07:45, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> The EFI_LOADER and EFI config options are randomly scattered under lib/
> making it cumbersome to navigate and enable options, unless you really
> know what you are doing. On top of that the existing options are in
> random order instead of a logical one.
>
> So let's move things around a bit and present two enties for the

entries

> EFI_LOADER and EFI options in the main config screen.
> While at it add menus for Capsules, Protocols, and Services in the
> EFI_LOADER so people can find their way around easier
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  Kconfig                |   4 +
>  lib/Kconfig            |   2 -
>  lib/efi/Kconfig        |   5 +
>  lib/efi_loader/Kconfig | 202 +++++++++++++++++++++++------------------
>  4 files changed, 123 insertions(+), 90 deletions(-)
>
> diff --git a/Kconfig b/Kconfig
> index 82df59f176ec..62c5441e3576 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -756,3 +756,7 @@ source "lib/Kconfig"
>  source "test/Kconfig"
>
>  source "tools/Kconfig"
> +
> +source "lib/efi_loader/Kconfig"
> +

This should be included from boot/Kconfig as it relates to booting.

The EFI app thing should perhaps be under there too...I'm not sure.

Regards,
Simon
