Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA139CA1010
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 01:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C188C834E5;
	Thu,  4 Sep 2025 03:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RQWWbpO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35392835C1; Thu,  4 Sep 2025 03:25:11 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B76A834AD
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 03:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6188b5ae1e8so549641a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 18:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756949109; x=1757553909; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LW2vq5VxPEy105nUdsGTdf+L4Kb/liTAP1QuEUIQ0Qg=;
 b=RQWWbpO5jPDM+Xh1uhxJKpkfVg+3hvIoFs/UHhbn7owF0sUaraVFpEqbGdkA42GQsu
 zs59mtKGpyPW9ARQ59Pvv7aea7gpdlbSNTzKYQPZ8v9If7AUke6oSgPfZ5JJB7KAVP54
 tEWHo0GOTjsjRj6aT1DssjUcsJnijMyZrt61HDTvtAUHYT2V+U+9lS1zAm58oBLsu6er
 uvbv2uUzLVrcn7JdFcBqUyHLM7nFcuEXIyA5ALesR+GT9DVMAz5MWkXTgN4yEk4pnZzc
 JgQY/x5I56g8FWBfM3JoAB3a5r68dFVZ7XVdONqDxCQ7K252Tg80pLednS9m9NWFFPvM
 EntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756949109; x=1757553909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LW2vq5VxPEy105nUdsGTdf+L4Kb/liTAP1QuEUIQ0Qg=;
 b=vA7les9/V4r14bab4kRMt7sb6QjAa1hYmvn6RGaaRnLjeCX+MAbvHtrKHJ4/F5TIzB
 WOBX/XYHF3jkKxPTQwy2hVYu5jyCF4pQpLnC2hOPYGxpju2Gh/+vyF3O6WdeERBQyh6u
 EUPetzRTw2cs1U+raeSWyxOM+s+eYCjXuSsEIe7lMK/4rmFEbohgydGmRMpoXHY0s7AT
 MJbYImm/eYsogpFux/VBCaJggawvvQEeON5uknE+s0zWE5/sY5HOf2YGgEsf3gNaX9gt
 0HUrjGlm+FyPbmZf12WW+N1u3jqMhNiJpy74aFjpztIgtkr4bQ4pMUdy1baL83y0R/62
 KzvA==
X-Gm-Message-State: AOJu0YxAObshKkOWoLXzkeKAUOXWOIug2Z7BN3epXue8FI3N7IsVKjiU
 VFqXN5/DyLSJcdvUTL0eW9jY/nh5bT7ACTBRYeaflZRdaLrUjbSMC1+AgK7KgmFeshcYI4i1uNE
 xW+wScypX2KXpS4sHAHGbt/uCZnPqkLM=
X-Gm-Gg: ASbGncsaAkbwqRVIW0TxRu3ox32xWX8qRwT8XiIAJbOKGtK0UDNokJ688CY3VL/w6em
 VcmE2z9ETw5GRxqQWyzGfSOG3qzKRRD+lXTFDfNmWQE7DklTJMaNoGaoYZdyluH3rzZjD3PoRTW
 9iz+uWOKo1xs9lC7+z7eYAjxulRtK5JzduppquyNjrehd/sr4axkqnKYl3SBaR2OC13IjSIiAPp
 VuSk5+o9fw+Vt1clKv8UklZUiw+tqWG7Rx9SA==
X-Google-Smtp-Source: AGHT+IEI11tW8ZVoiaAJkh2JMODwpBQ4/CkHVA9TLe0n6uAVYypJaHvfRqrtuQCj4uLRgcoG9tJK2F/GFgvoYbfQaHU=
X-Received: by 2002:a05:6402:51c8:b0:61e:94a0:f5fb with SMTP id
 4fb4d7f45d1cf-61e94a0ffe4mr11141189a12.32.1756949108516; Wed, 03 Sep 2025
 18:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
 <20250825230044.GB124814@bill-the-cat>
 <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
 <20250827002317.GF124814@bill-the-cat>
 <CACAHuLB0uwUjnR58qgeoOcHO-PC5geYFuBKF4Mw+=UFjT9urRQ@mail.gmail.com>
 <CACAHuLDZzgF1a7wG8fwNZ1YnUruPgyd9MifY2COS1kQFsqXsTw@mail.gmail.com>
In-Reply-To: <CACAHuLDZzgF1a7wG8fwNZ1YnUruPgyd9MifY2COS1kQFsqXsTw@mail.gmail.com>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Thu, 4 Sep 2025 02:24:57 +0100
X-Gm-Features: Ac12FXyzsy5_3kmzgipCGrVOexwz2xO4USHEkfMNjYJuF051gswehhg1vlh43Zo
Message-ID: <CACAHuLDp5COeBue8jt8U3s59UsTnzjFH33ThXVFXk7-XLCF1BQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
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

On Wed, 3 Sept 2025 at 02:14, Adriano Carvalho
<adrianocarvalho.pt@gmail.com> wrote:
> [...]
> So, in principle, we "only" need to replace all ".. image" with "..
> kernel-image" (65 occurrences / 17 files). However, I did that, and
> got:
>
> sphinx.errors.ExtensionError: Handler <bound method
> ImageCollector.process_doc of
> <sphinx.environment.collectors.asset.ImageCollector object at
> 0x79380051bbe0>> for event 'doctree-read' threw an exception
> (exception: 'uri')
> [...]

Actually, the right approach is to use ".. kernel-figure" not "..
kernel-image". The latter is never used in the kernel.

Using ".. kernel-figure" it works fine. The remaining patches are
still required though.

So, if you intend to remain aligned with Linux in the way the
Documentation is built, instead of this patch a new one is required
that replaces all instances of ".. image" with ".. kernel-image" (65
ccurrences / 17 files).

Please let me know how you'd like me to proceed.

Moreover, the infrastructure to build the Documentation is a bit
behind that of Linux. Not a lot but quite a few changes. Should I try
to issue a patch series to place U-Boot as in sync as possible with
Linux?

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
