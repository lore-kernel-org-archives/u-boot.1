Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CDDC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E772E8885E;
	Sun, 11 Aug 2024 16:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cZ5zZ0q+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C53CD88808; Sun, 11 Aug 2024 16:50:20 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC6ED88100
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db14339fb0so2170427b6e.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387817; x=1723992617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IAX0k3rP2+4TjB6je6KPxxr3shcAEmyfxTKCtJIGtWw=;
 b=cZ5zZ0q+leD6tcOMz0CPQN5qb88sGFshIH9xzRxknvnqf4LXwMFTnIV5og59ahWZZY
 RsDNx/eL08AW0Fee1tBTkf/MhaFuhk5zZbh1S84hsI3f2nDmq00TZtSYvZIJ0nX/ug9X
 66Mpg3+6X1vCXZAvsaVgkHEFfrNH5imo/UirA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387817; x=1723992617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IAX0k3rP2+4TjB6je6KPxxr3shcAEmyfxTKCtJIGtWw=;
 b=UMs1M0hoL5tosRFI6yEykZRdeGWUBIAIJ8eTl3jxGTniFwG0SP/+rRoCQMWNORo2WC
 kUt//FhvbvLXuf5teXq5xRxbP/ixQRQrQ8NaE8QldQ8qJHxJ28VrEFtklbLyq7skVzep
 JwFLupKILhEzAgcpHJPyx0H74ftBjMzu8XUn0ERXvyX7KAksn/qLOVd5zliXSosRRqGL
 ZOgJR+OjjUQ/cInJ1XaQXDUMWn+5ydvahaRkUZ+2S7v+uZi6ayCBNrpC7QkmadN3jukI
 Ml3Pt+bl9gzrYLnab/Slf9BEE3+WN9/gJ1cndt1oylHu9dM70Ligqgr1fhXoDPrjdt7w
 Fj6Q==
X-Gm-Message-State: AOJu0YzP3+ZoLG7XBkXNGpBjD8Xnv9qvXGkw9hAV2rkCCwY+yMrK1Ife
 vv7ghnPg6gRy0t0VUDPDc2D0ziMwoPdS5xBNncT9xHQPCpCqwO9J1R507cb8uoof5P5HyKh4aWN
 giBcIgSV0Sr9cSEbnFtBv1twMBFNs9qh4C8Gn
X-Google-Smtp-Source: AGHT+IGV8+gqkKHR5Knh4FKy6CgbJ5pOKXd6nLkthug9uefLXrb9juOQeCXOxf10ASH8AF2LhUs2b20RFWdaRrJuWGA=
X-Received: by 2002:a05:6358:33a3:b0:1a6:72f2:4d03 with SMTP id
 e5c5f4694b2df-1b176f1c082mr806122055d.9.1723387817488; Sun, 11 Aug 2024
 07:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240807224739.3858517-1-sjg@chromium.org>
 <172331433904.2030825.13281690460193478199.b4-ty@konsulko.com>
In-Reply-To: <172331433904.2030825.13281690460193478199.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:07 -0600
Message-ID: <CAFLszTjDvr9bGa5ioQEYFJAmTV676W8210kVT_fThbSoLRMTvA@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] Universal Payload initial series
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>
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

On Sat, 10 Aug 2024 at 12:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, 07 Aug 2024 16:47:18 -0600, Simon Glass wrote:
>
> > Universal Payload (UPL) is an Industry Standard for firmware
> > components[1]. UPL is designed to improve interoperability within the
> > firmware industry, allowing mixing and matching of projects with less
> > friction and fewer project-specific implementations. UPL is
> > cross-platform, supporting ARM, x86 and RISC-V initially.
> >
> > This series provides some initial support for this, targeting 0.9.1 and
> > sandbox only.
> >
> > [...]
>
> Applied to u-boot/next, thanks!

Thank you for getting this in!

I'll take a look at what else is needed.

Regards,
Simon
