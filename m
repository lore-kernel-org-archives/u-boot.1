Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F38FC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 08:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 609E98357D;
	Wed,  9 Apr 2025 10:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p+J2nyje";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF4F98359F; Wed,  9 Apr 2025 10:34:08 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6249383577
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 10:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so5637306f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 01:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744187646; x=1744792446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9feLyxdtwxyOYx86lojlAuQxrUmz2a/sOPuFUkdiqLs=;
 b=p+J2nyjehWkYBrroyL5yTH3bfBPzFXH47/Mc44wsQEyiQ3d1ylqYqqiPM2QNFLjQFO
 S1qhn0tIUylYxpWpMSOgg9tdL7QB8u0TKysQIz9yI7Azh1riI0bl/vAbcNHuyZCIy8dn
 o1hkvJEwm3NsOSznqMlfwJPcxIkG73JxYECvZZmaP9ez99lMGMT36J+ItrmTuDAQlBOv
 H+SbGe9b97qIqfsZLRNjx2En8PHD5thMyKnz437j6hnbIj5A1DwpSLcRPL1dj1Jyj9wv
 YgCvEONVAWpV0je2IDnfNQBtiNLpnKs4lKRNKlHkXI0bb9sUxcqFMM4HNmjKVzrzFPke
 ZvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744187646; x=1744792446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9feLyxdtwxyOYx86lojlAuQxrUmz2a/sOPuFUkdiqLs=;
 b=kUKcJhMBHzkR8xRIDc9D3uD6+LszA5jzfn9dUkOD2lJsaKkM4W3k1tYarNdPQVUiBC
 ligDH86ePOprmrGpHFVCd0BxXcdbXkjhK/qh3XlxyhVxeFegeIgSxpNbpO3dDwmMxcIE
 L12ssmkdqlI5dZNMwhmBiSDboUZ6SSWnzvDaKGk3Hii0boKz48A4IfDOOz4dNlBcXpf8
 IH0pa44FRbnIBj9lqzVFATVeq/LRTUpr1SwLMtu7KNqU807NeM3afJJZYzAtzfj7hw1G
 0MI8PfLSiiUyF0t1JH7h9V3jwDVv6ZtSIGvRoP7bPmwTuHH+x0bVrJeox3QSrjBGht1A
 uS0Q==
X-Gm-Message-State: AOJu0YybvqJ/TcQxnBtu/U213+Li2Da4XT6K6xJuX+0uw781ZlxzB/Fm
 N5rxBEM4ci73KiCNL28kGEpFl0ONrxtujo8xXIcRXmzLJJ0hCvEmJ694Rhwt7cM6R0xN9heuIug
 /ZuZz1sWXf6VEZqnYyEzQgG6GjUUe/H8cSSMctA==
X-Gm-Gg: ASbGnctZG2ey/rfIXkgU/Dx5eyA/WXN+qgcpM6oA509536XzQZsox0e6cbvgrRIixhQ
 uAlPgYkZcEFTPciYOj57X1WGlr5CoslAhkyKtZwLeSloaMGl/StGgIagNYuMyT8KMkoEUYTVTyv
 YKczuzC13BRbtFKQvtDD/UnW/c16BClXjdxzknaoS15tbGg3pXFDBAhiE=
X-Google-Smtp-Source: AGHT+IF6wXyqePY5R/7e/1XiXc1fP++ZcjvQKQBGAWVC/TMufSRzExYUMxJoBp8yy346FUeao5b+YpyCLDXqRu+34J0=
X-Received: by 2002:a05:6000:2289:b0:39b:f12c:385e with SMTP id
 ffacd0b85a97d-39d87ab3086mr1909030f8f.20.1744187645689; Wed, 09 Apr 2025
 01:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOeqweT0o1-bFHNaoDURGYKGvx4OvqsgRpXwdWArdeGmBrnJyg@mail.gmail.com>
In-Reply-To: <CAOeqweT0o1-bFHNaoDURGYKGvx4OvqsgRpXwdWArdeGmBrnJyg@mail.gmail.com>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Wed, 9 Apr 2025 09:33:54 +0100
X-Gm-Features: ATxdqUHOFhgDb3RBCBHrfWvHrKrmk8-RxHxyWQiRKlzenGdrmUHu8Fj4sx8w5NA
Message-ID: <CACr-zFBPZ6VZCQzHKW-AJDyUUpcLLJS=wSNVejnWTsT9tg9SNg@mail.gmail.com>
Subject: Re: Issue with booting FIT image using Yocto with raspberry pi cm4
To: Andreas Enbacka <aenbacka@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

Hi Andreas,

Can you please try with this series from Simon?
https://lore.kernel.org/u-boot/20241220003447.2913443-1-sjg@chromium.org/
It solved booting mainline kernel on CM4 for me (albeit not with FIT images).


Thanks,

Chris

On Tue, 8 Apr 2025 at 19:23, Andreas Enbacka <aenbacka@gmail.com> wrote:
>
> Hello everyone,
>
> I am working on building a custom image targeting the raspberry pi cm4
> using Yocto / meta-raspberrypi (scarthgap release) and u-boot.
>
> The kernel and rootfs booted without issues before switching to using fit
> image. I build the yocto image with kernel type / class set to fitImage.
> For building u-boot I have specified e.g., CONFIG_FIT=y and similar
> parameters.
>
> When booting the board, u-boot loads the fitImage (around 10MB in size) and
> shows the kernel / device tree blob info (kernel is gzip compressed).
> However, the process fails when u-boot executes "Uncompressing kernel..",
> with Error: inflate() returned -3. This leads to a boot loop.
>
> I tried manually executing
> 'load mmc 0:1 ${kernel_addr_r} fitImage; bootm
> ${kernel_addr_r}#conf-bcm-2711-rpi-4-b.dtb', but it results in same error.
>
> The kernel_addr_r is set as 0x00080000.
>
> Any information about this would be greatly appreciated.
>
> Best regards,
> Andreas Enbacka
