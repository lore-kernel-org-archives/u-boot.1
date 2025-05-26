Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2792DC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 08:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB5482C96;
	Mon, 26 May 2025 10:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WceyAlyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D0F82C57; Mon, 26 May 2025 10:36:13 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D3FC82B2F
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 10:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-604e2a2f200so257251a12.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 01:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748248571; x=1748853371; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+wGCGOptPSvL1raGgPp8vrxJf7yjzNjXKi7KcDmsszw=;
 b=WceyAlyDpYlZnlF37SejvpVcnhzsKc/j8KERRA5pLsF+BJClcc4ho0ZUtWXprdgwzV
 cNXW2AhJ6ztE+M01Y3qW2TdOgE07eyiWzbELhgJLKohcOqBWHP8BmUwzX9HXkR8lVxJX
 XeUXf674/7hGAVIB/XnVctpD8U3ko/f/2EaME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748248571; x=1748853371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wGCGOptPSvL1raGgPp8vrxJf7yjzNjXKi7KcDmsszw=;
 b=VzLKjHXcOa+/5TlvzpNLghidsGCBeP+o1KcozVmcu40ChugrauckXA52M4BN+C5U6s
 NnsoOn6sspWqBDqCiXMvT2mtcxZP/EsC84xpnJdwbXs/H1dkbFmuD9BfJ0C5xOEVlHTe
 X6JcN7wrGwtZMY+kia4Okyc+lB1kwqTVfc7ouZAHjm3oinhPe8NWMpTu+ZeiH0zihU4s
 E2pMsbSgKjvoT5pLDk99WNgMYqtJaI9SAnwFHEzB3zhpHGJZOVBGKTbdUj/2EeGDjQNQ
 f2Mo20gjEvObocNqOy21E5qaVUZau9YgNjuSKrNVjpUVD0mX+RmYUzsjLMXn2prZYPN2
 kwjg==
X-Gm-Message-State: AOJu0YzA1fIjXNbDM22DwgyotsEzf+jxdW+5CZ9QSyzcqmGD1dsWJ7/p
 /9itxB1z8xOH28+JiHXiXlcteIPZctLZkAQT1/mTSA0VF/noqGQcKxCYRJS8mrRgOzEZeiy6omz
 fAd++UMExcBBdexhOZHRRxl3SuBPMCicMSQkdZk4K
X-Gm-Gg: ASbGncvjBK9d1vX+pxRnrDbm+QynW6pS6rDCtxnZG8HiQzRF3Y4Pb1pq3m+CrG6fTqT
 5UzCw4BBFvlnS+ZQ3Wg8URkXLdZONqVwqH2HZcRoCAVXDu9ScLA2ai3U45Vz8Y7EYJoJkJ3Lqfg
 osxJEfjtbHjmVUpWx08aXCuyNczeGlgVw=
X-Google-Smtp-Source: AGHT+IGGL7U35xiIP/GWqHsScd9rnUepVD5TDGH+zW/aCXtPA55IHoJr1oQEpOeDMUHQifEkF6GWyGsyXxwIiMsSOQU=
X-Received: by 2002:a17:907:2d26:b0:ad2:4e43:efcf with SMTP id
 a640c23a62f3a-ad85b318f0bmr651572366b.50.1748248570948; Mon, 26 May 2025
 01:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250524054245.409399-1-sjg@chromium.org>
 <97e69b7e-0ecb-4d30-945c-d2c32438149f@cherry.de>
In-Reply-To: <97e69b7e-0ecb-4d30-945c-d2c32438149f@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 May 2025 09:35:59 +0100
X-Gm-Features: AX0GCFtcPnme7Ccb-SOZcQrEXUDGA840Zd1sukUh2x5N2vsSHyexUYxM-TpmVvE
Message-ID: <CAFLszTgKawD=zj3tC2fWJsCv0Hpjv9eNaLcO7XVjn6SA8iFi-g@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Use -c flag with bootdev order
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Mon, 26 May 2025 at 08:48, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 5/24/25 7:42 AM, Simon Glass wrote:
> > Update this command to use a -c flag rather than a special 'clear'
> > argument.
> >
>
> I don't see the commit which adds the clear command to either master or
> next branch, so maybe just fix that in the original commit before
> sending a pull request instead of via fixups?

Tom rejected that series (or 'changes requested' to be specific). I
added it to my tree in merge-request 68:

d93f42d6e3d bootstd: Provide a command to select the bootdev order

>
> Did I miss something instead maybe?

I didn't send out my 'applied' emails for this series, so it was
silently applied to my tree, so far as the mailing list was concerned.
Tom wants me to operate my tree silently so I don't always send the
emails...

Regards,
Simon
