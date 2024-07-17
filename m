Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C21CC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 09:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C966D8818B;
	Wed, 17 Jul 2024 11:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YHCYBID7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61CD4886E5; Wed, 17 Jul 2024 11:03:28 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D9588113
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 11:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b5da2730efso40221056d6.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721207005; x=1721811805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r8Yk7Yku/xpsB4qZgyiiI4mFEPEmNzQzvdBC2uKo/2k=;
 b=YHCYBID7bB1KKE39/Zeo0JNpib7KiKzt0cSjpj+koqyHeRtjGa0CnL3we4Fq0f58vI
 aDdKyiZ1uw2XOsKczL54ADFk1SoX2rSp6A9H/9lL6FMaU4nzzwTe/NWoy1tdOeMa8+ki
 bm+ID5K822mfG0ErdJW1PwJWbB534pOUyFyT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721207005; x=1721811805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r8Yk7Yku/xpsB4qZgyiiI4mFEPEmNzQzvdBC2uKo/2k=;
 b=NuPzxJLbJxIECGxic5L2A7mtvND1/lKVxVmwP3wd15r6PZBJy3cFxvp5GY15Katvy4
 FXJABNrrbpGVQE/TgVIl6ReznuR/6iQe/YRFyXJt7eV5koXM4rIIXLcQAoTJxs01DjXE
 FkKVV0ok8SzGZ/dcBjZgc08JYw1OikYmWdN/3wqGI5cAeIeseUC/Y2InPZ0OmCI9021D
 ADYD+at53b5Z42xe2YdVCSDpriqI5KKuDFXy7oCtS73b/VifHKKDcyVZXpUf8KSRv5xL
 5UVcubGxotvV3mkkRmA41n8yFIexlwAoC2mcxfhXuTY+ph8jgLFK6KposP2uBzkr2hPo
 5mEg==
X-Gm-Message-State: AOJu0YywYyshOFevtyJXfD9uIR5I8reh0zTUeM1jMLLsazaKx/ftJI9P
 WtXlykCtAtMAe6qVi2yVvf/rpRNToV7US6NVvz9iG1l+Nw4e/NK7JEk+K95crUpCGsQQWTLkKdF
 f/8mqDmHT1eQSvjoN/+JMuvxS3Ijir/cvIaY+d0dvhOZFhdA=
X-Google-Smtp-Source: AGHT+IEwU9UEGdf3DoJXzhF4BPOkT7JHnoZjkvAg9zdbACzxxellBgkUwJd3TozeRwEQl3XdnArddDt9Qa2nIrl4eHI=
X-Received: by 2002:a05:6214:2525:b0:6b5:4e07:2a55 with SMTP id
 6a1803df08f44-6b78cab48c0mr14435436d6.29.1721207005129; Wed, 17 Jul 2024
 02:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240715193555.564528-1-trini@konsulko.com>
In-Reply-To: <20240715193555.564528-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 17 Jul 2024 10:03:14 +0100
Message-ID: <CAFLszTj7hpSBCraYMR1sZ3F6aZ6q5iYvj47ceT8dsp9zZTiZHw@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm: Remove omap4_panda board
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Mon, 15 Jul 2024 at 20:36, Tom Rini <trini@konsulko.com> wrote:
>
> This board has not been converted to CONFIG_DM_I2C by the deadline.
> Remove it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/dts/Makefile                |   4 -
>  arch/arm/dts/omap4-panda-common.dtsi | 573 ---------------------------
>  arch/arm/dts/omap4-panda-es.dts      |  82 ----
>  arch/arm/dts/omap4-panda.dts         |  13 -
>  arch/arm/mach-omap2/omap4/Kconfig    |   4 -
>  board/ti/panda/Kconfig               |  14 -
>  board/ti/panda/MAINTAINERS           |   6 -
>  board/ti/panda/Makefile              |   6 -
>  board/ti/panda/panda.c               | 322 ---------------
>  board/ti/panda/panda_mux_data.h      |  86 ----
>  configs/omap4_panda_defconfig        |  54 ---
>  include/configs/omap4_panda.h        |  16 -
>  12 files changed, 1180 deletions(-)
>  delete mode 100644 arch/arm/dts/omap4-panda-common.dtsi
>  delete mode 100644 arch/arm/dts/omap4-panda-es.dts
>  delete mode 100644 arch/arm/dts/omap4-panda.dts
>  delete mode 100644 board/ti/panda/Kconfig
>  delete mode 100644 board/ti/panda/MAINTAINERS
>  delete mode 100644 board/ti/panda/Makefile
>  delete mode 100644 board/ti/panda/panda.c
>  delete mode 100644 board/ti/panda/panda_mux_data.h
>  delete mode 100644 configs/omap4_panda_defconfig
>  delete mode 100644 include/configs/omap4_panda.h

I'm very pleased to see this.

I happened to be looking at i2c deprecation (yet again!) the other
day. I found the generation *before* the legacy SYS_I2C feature.

I will see if I can get it building, then send a series.

For SPL, I am thinking we may need a 'tiny' i2c a bit like the tiny
mmc, e.g. supporting a single controller and simple read/write. I have
never really looked at it in any detail as there is too much cruft in
there.

Regards,
Simon
