Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D543C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6713888753;
	Sat, 20 Jul 2024 14:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XNengH95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A947C88671; Sat, 20 Jul 2024 14:36:16 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC1088675
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b7b28442f9so16634676d6.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478971; x=1722083771; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kx4sIdQtnF+NDuKlAsvjEkLUJZ0MKnt6UwVpTz1DmQI=;
 b=XNengH95ePOSUlLpucyI17JfZyvqFqn3uzc9o7K+i4fgSuqYhPbbZdo/zvIVLm4qOk
 djhCBJcnYVD+eipKENnbNojBfULd0a3ELZo5sy4TWYbcE0lej1eVvtXeTPzFzANyELLX
 S5Q56f/1lOglbQT3ivGNSIlleJjSIXvXg39u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478971; x=1722083771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kx4sIdQtnF+NDuKlAsvjEkLUJZ0MKnt6UwVpTz1DmQI=;
 b=ZWUxyXc3+sJKPC4ZAy3pE7sJM7rk/2d9DA6u/t0+ps0ubSbLujonb31SJ0x99dpDYU
 GS1jcCAnIdghjrpCWi5riRJGTHW76SYlQN6PZlfI2yLROn2erFT2i8EAKg8nivlAap9G
 3NGRRTuVDx5/82Crre4wos0XLNNkmL5HSTr9mzuOq9Lrxf0l2L5wQhfBSMztoLOlUAMS
 R51Uci2M7A5SG/hQbitek1MHiEyNRWKRx83tiisAper7xPKMe9H9ytCQ/bYPRqP7Qqy3
 x0o8nP81QouRuLLtaJKOd2tloXh8LN10dRLVv0w9pVn0OLeUHdcKprig//1yzgyB9Z/B
 e2lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgO/KEMmxUpOH45Pee3PnRwc/5TmCA3kaKrQdzsNJmXlo4/p+GedLKf9V3bu0CAsAVGEht6pxERVesOQs/U2ZdtZwDUg==
X-Gm-Message-State: AOJu0Yz8QFJNEDdzpPKhNOjL0rqruX7aO5DQlomZlNN5wtzri4BGbnzl
 yCKGb0d8DGflixchfAUMmHG9oNqbk9p78DxFTKd6wZk5IEvdp41ATmvXiStc2M2MEqiPgm91Sdu
 jOz2jKXJMt4K35dwNYlG69/MJM6eXxFviFtWz
X-Google-Smtp-Source: AGHT+IE2PrM3yAhE8gfr6cfdwqBLrE8VxoBXY/DkB4zN6KyXDvt5iaXuJddiuo7/J3FIAAUSS1qN2HepVK/FtyKqQjA=
X-Received: by 2002:a05:6214:202a:b0:6b2:da3d:999f with SMTP id
 6a1803df08f44-6b9610f04aamr23290126d6.41.1721478971666; Sat, 20 Jul 2024
 05:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240719212326.42901-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240719212326.42901-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:00 +0100
Message-ID: <CAFLszTgD6rq8oioLkT9+Yi6FF7jTwPmkxEZdGVakmQy-wYAaTQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: define html_context in conf.py
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de
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

On Fri, 19 Jul 2024 at 22:23, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The dictionary html_context is not passed into conf.py but must be created
> there. See
> https://dev.readthedocs.io/en/latest/design/theme-context.html#customizing-the-context
>
> Fixes: df86796028df ("doc: enable ReadTheDocs addon management")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/conf.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/doc/conf.py b/doc/conf.py
> index e79134cc3d7..ced3a6723fc 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -26,7 +26,9 @@ html_baseurl = os.environ.get("READTHEDOCS_CANONICAL_URL", "")
>
>  # Tell Jinja2 templates the build is running on Read the Docs
>  if os.environ.get("READTHEDOCS", "") == "True":
> -    html_context["READTHEDOCS"] = True
> +    html_context = {
> +        'READTHEDOCS' : True,
> +    }
>
>  # If extensions (or modules to document with autodoc) are in another directory,
>  # add these directories to sys.path here. If the directory is relative to the
> --
> 2.45.2
>
