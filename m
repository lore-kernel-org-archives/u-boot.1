Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E4CCF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF9788CED;
	Fri, 20 Sep 2024 18:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SspqEAC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C4E88CED; Fri, 20 Sep 2024 18:04:27 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A13688D6A
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71971d20ad9so1588164b3a.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848256; x=1727453056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wsLhQEY1zMw6PbYBYPTVi3zYZf/HKnDbqjBUk03XZvg=;
 b=SspqEAC3HdtAydpOB0Kx4oK57XG9VKClnJnvMhWqESRU2F8PT/OOAsLggPRhdjsCzZ
 4JIpxqAJ7GVo6n329n/iOHwJdvmgwFFBLisdYsrX4a6B+wQtFhOl0iU5tiVuIfEX/sXa
 stL49h34R3P14F8qm8sPnQD8uxCANSq6h9ryw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848256; x=1727453056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wsLhQEY1zMw6PbYBYPTVi3zYZf/HKnDbqjBUk03XZvg=;
 b=XwurRUYLae0YquAa3sDeT+UF546CkzLOEUC5ZFa/LcvVrMhpEG3DOamDG3kg0jRxSD
 8B+tD9d8u8N4W0v4dANUZIQnf6SUVkRNZXZDYT22EDj0GShecoMST+AmYuwtyuRvCoLu
 HJhlFsbAdCa1AMWS+TvfiCfxFbY6G/AjLvK4NO2N5/AXrPAxSeBpBE839U3ewLwDHCQa
 MZtfT/GpN1UwNjj5ghpS/UGzR3Z9X8Swvm04ss6up51hYZIH4bgZeHY4WCrXTSRI1dJc
 rQmCGd6cf5id59vOR/Cd+6IKg9gmese0/1G9Abg3FHbjFyJEuXjYrggNVRc4kLyRh+MB
 +img==
X-Gm-Message-State: AOJu0Ywg5uBOvecAxCnA2LIqdKr+e4Zjc4ZYx+bDko8OILZok72g/D5+
 UwGHtxM60ohk7jHIB8n1C1j+3F7a1J+KL6hnGW53fo3WLlL3wQAk2zYlS2bTo8E7aEPeMldqQNg
 LdhHPJrftjEzuDwXmKUyLnuyF5CHZc+btgFtgz+9XKnp/jq76gDLc
X-Google-Smtp-Source: AGHT+IFTnVfyxFDTe9PgR7T7dOokJ/YyeQjqIJnpTVQr5V0ejjM4FS0mYB6l7xgFVsbMB2Cmw8683IzfowSzPumXwng=
X-Received: by 2002:a05:6a00:2da7:b0:714:2069:d917 with SMTP id
 d2e1a72fcca58-7199cab1965mr4785151b3a.25.1726848256594; Fri, 20 Sep 2024
 09:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-7-sjg@chromium.org>
 <20240829172626.GK2479150@bill-the-cat>
 <CAFLszThacdwBNMP8Rq3uEXd=MT-8NpVXHOjhcMrdvLR-KrNPXg@mail.gmail.com>
 <20240920145942.GC4252@bill-the-cat>
In-Reply-To: <20240920145942.GC4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:04:01 +0200
Message-ID: <CAFLszThSLXLOxMVQBCwpuLEOm6CPx0N-p2taz9Z6NEw1-P86Gg@mail.gmail.com>
Subject: Re: [PATCH 06/19] malloc: Show amount of used space when memory runs
 out
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 20 Sept 2024 at 16:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 20, 2024 at 09:25:44AM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 29 Aug 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Aug 29, 2024 at 08:57:49AM -0600, Simon Glass wrote:
> > > > Show a bit more information when malloc() space is exhausted and
> > > > debugging is enabled.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  common/malloc_simple.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/common/malloc_simple.c b/common/malloc_simple.c
> > > > index 5a8ec538f8f..f2b3dc53689 100644
> > > > --- a/common/malloc_simple.c
> > > > +++ b/common/malloc_simple.c
> > > > @@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int align)
> > > >       log_debug("size=%lx, ptr=%lx, limit=%x: ", (ulong)bytes, new_ptr,
> > > >                 gd->malloc_limit);
> > > >       if (new_ptr > gd->malloc_limit) {
> > > > -             log_err("alloc space exhausted\n");
> > > > +             log_err("alloc space exhausted %lx %x\n", new_ptr,
> > > > +                     gd->malloc_limit);
> > > >               return NULL;
> > > >       }
> > >
> > > Since debugging is enabled you should update the error message to say
> > > what the values mean...
> >
> > OK, will do. This message is shown without debugging enabled, so I do
> > want to keep it short.
>
> The commit message says "and debugging is enabled", so is that the case
> or not?

Oh, I see. It should say 'not' :-) I will send a new patch.


- Simon
