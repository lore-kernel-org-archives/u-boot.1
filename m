Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA28CF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B807389068;
	Wed,  9 Oct 2024 03:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dyOq5xtp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F59F8906D; Wed,  9 Oct 2024 03:52:45 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6D88909B
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71df04d3cd1so3706352b3a.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438761; x=1729043561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mlGUWbysQ1so5cKCJcTlzHyvsr5lW7kei8Ey+5ge9Jg=;
 b=dyOq5xtpLvRbKvOQyeDLMzxX5+USkIT4i7dP+vX8Hleg+c0loC1pluIXx50nRg8ac5
 hCnKGHI9Uu+vSPkR1Zu8mVG2CBhIFabhAUdCVPclnOVjShQfObNucnEq12giYRl2iv/A
 Uw1Ofb+bKJko0ixg2dPCWQiSLf2npY30Wl2+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438761; x=1729043561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mlGUWbysQ1so5cKCJcTlzHyvsr5lW7kei8Ey+5ge9Jg=;
 b=GpC4wgOeDqcm62ggV+vk96w4DhKIW4R7/Xv8WSwUDSVVQnAq4GFA5TLftLRwegpi6B
 wbBxiXRQEMWLSRDoYcbqY3R00J7NBH1CwLomjglujubzMClsT6Etfqld90hKrGEkegiM
 04AUkRRQ6pa0DthXDWOAG5NVQbtgDHVH9wYb+Mvsa83YUuw9yhaKLOFduCr0WclWPM6i
 7Y731RkntqXDAt1B2ynDJxAIXLvS5bnaqgU8+5ZueKf7/xBVNNb72OLKvmZTflBJl+Dq
 jLzzZUG+pQohR1z6b1QVKKFR8jV4w0BhbKuAgvb8fA20+/jJub0lumcy5QovGtIMJUAf
 nncg==
X-Gm-Message-State: AOJu0YwygvsZK7nxKckUm1ldyZxD2Oj6xKmP7Rgzc6AFU/7HjVlYOcuQ
 DI1bkmDSDfc+9Yy0F81AFD7cv/eaaAtxZt7mFdMxDWz+1iWB/+pHCizs+x2EATe6ATV2z3w/YRu
 G1dsszXgGZlXEFTxy09YCf/eK2ppb3ehXHHbAF0Y61g8ghHnEQw==
X-Google-Smtp-Source: AGHT+IGFt+jI5N0CbomgDsAiAhvuONY6aTndoEcuCrKvQtL6Q4WRZEGtPmJpaCCseTCRsPZUxeovuL+IqJrGQCGjGGo=
X-Received: by 2002:a05:6a00:2191:b0:710:9d5d:f532 with SMTP id
 d2e1a72fcca58-71e1dbc2093mr1509116b3a.19.1728438761174; Tue, 08 Oct 2024
 18:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-12-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-12-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:28 -0600
Message-ID: <CAFLszTivMbY9bddngxBANiXGcRzBK+VcTx0TfCP99q6GMPJs5Q@mail.gmail.com>
Subject: Re: [PATCH 11/13] ddr: altera: include u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 15:30, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> These TUs currently rely on getting a declaration of schedule()
> through some nested include. Include the proper header directly.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  drivers/ddr/altera/sdram_n5x.c   | 1 +
>  drivers/ddr/altera/sdram_soc64.c | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>



>
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index db09986f64b..d1fc93b6bdd 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -22,6 +22,7 @@
>  #include <asm/io.h>
>  #include <linux/err.h>
>  #include <linux/sizes.h>
> +#include <u-boot/schedule.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
> index 9e57c2ecfa4..10a8e64af3d 100644
> --- a/drivers/ddr/altera/sdram_soc64.c
> +++ b/drivers/ddr/altera/sdram_soc64.c
> @@ -24,6 +24,7 @@
>  #include <asm/io.h>
>  #include <dm/device_compat.h>
>  #include <linux/sizes.h>
> +#include <u-boot/schedule.h>
>
>  #define PGTABLE_OFF    0x4000
>
> --
> 2.46.2
>
