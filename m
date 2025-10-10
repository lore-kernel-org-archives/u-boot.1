Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED06CAC5BB
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 10:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B645083F85;
	Fri, 10 Oct 2025 12:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JibRvWVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0CB383FC1; Fri, 10 Oct 2025 12:36:24 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 014F383F69
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b4736e043f9so278214766b.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760092582; x=1760697382; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KG2b5ritEn6q8Vt3s0FdM1VFI52V55W+i+RTods0SSs=;
 b=JibRvWVu5gj3ZsOXKjGhl+gY2LUEGnY/US4XE3LhvudPEa3FHvNPrVtmlZdWG090IO
 a3+5kNBK9zsSOGwCFDcyv67jCuNkeoS8HyFeeHFDeFKJHZzLWRuUCh3Ub6cgDXJhlXTr
 /8dNCZlAwliOdwt/4WLtKg6AE4Zsk9+kJhNks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760092582; x=1760697382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KG2b5ritEn6q8Vt3s0FdM1VFI52V55W+i+RTods0SSs=;
 b=np3/7XJEQPUWP81/W6Wb3aJCav0HvTAg3wuGpi+ZVRU2XavWd59AgyVIWt7DSr33lZ
 nwwhhLtum3EqmtAaf00GJWDU3eS6XPrj9ud9zbd5iwB2aCDhJiJqw6Gl66QDnVvyrHk0
 C75OJdZQpWWjlshJQDFkW8GntKODxf/eBlNpzJhjVDF3X99GclrHX0TB4/ZuKlzl+3Me
 nYeU83iExet3J/a6QCzaykicAEpee4O6L3C65IUvYQqInPJOOjvucMeG+QWbK65sOY8A
 nvkmqSF6yp4fT+F4wWxAsluBAazzCq8j5fBuHQoCQnTNOAifLmINk30Sm4kUK3IudF0t
 VGUw==
X-Gm-Message-State: AOJu0YzumwdxHd+0OQu/B5NOhBr8mt7jN8y0Qbf66Ew/5uzOLm7pUKqc
 AI3Sdf12VL7qsDD4gSuVpRKxnb+apsqox/gXvFd7h1586vYNtz8tvsyzqk5+peJ6TvOMKXqJ54i
 8nnSIo2vJT9YxcCjaIcRgUeQe2zzVH8KGlEGvYaj3
X-Gm-Gg: ASbGncseqeo2rR4luokRfWwt9wlGmUz4zqXA8LcfeeYPAYN3eyId3X8l5NG5jvDhfIE
 SbxsV55usVJkyRXYnOhNLPS1V1XheRjCKcNbPul5E4YqlLZaifqPuWu4+Eq9/Ghhw1bAK9tH4vt
 GgBQgEyfT+d5Z7C3Gud1H16I3+SI+UaRf2YhF8gK38K66TdLqjuOXkjFVrqQ3fBNQqRQw98Y5aT
 5jmnPtpQWbhqEP61NSI2F8NqpBjIP5C
X-Google-Smtp-Source: AGHT+IFScPvmeDvJtCZVvh5vnV4KfwphU5SNN7AKrXgqaiFV5XabHv9Lm6lJ0X5zOZ21goOXLXk2ja8ffIeRfXbz/lI=
X-Received: by 2002:a17:907:6e88:b0:b31:ec30:c678 with SMTP id
 a640c23a62f3a-b50aca11be1mr1367693866b.57.1760092582468; Fri, 10 Oct 2025
 03:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-4-sjg@chromium.org>
 <20251009173052.GQ298503@bill-the-cat>
In-Reply-To: <20251009173052.GQ298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 11:36:10 +0100
X-Gm-Features: AS18NWB-Db9dwT5dOD-2mp14sH58f4NzslytYjj4DU-yCWX_EH9LO_ttKQbUIV0
Message-ID: <CAFLszTi2HuZLmebJB+kUsL3_J+aqVdCdP5XFSEoY1Dy5C3E2wA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] boot: Add more debugging to iter_incr()
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
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

On Thu, 9 Oct 2025 at 18:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 09, 2025 at 03:29:54AM -0600, Simon Glass wrote:
>
> > This function is the core of the bootstd iteration. Add some debugging
> > for the decisions it makes along the way, to make it easier to track
> > what is going on.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  boot/bootflow.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > index 78df09f369d..de69e27bec7 100644
> > --- a/boot/bootflow.c
> > +++ b/boot/bootflow.c
> > @@ -193,8 +193,10 @@ static int iter_incr(struct bootflow_iter *iter)
> >       log_debug("entry: err=%d\n", iter->err);
> >       global = iter->doing_global;
> >
> > -     if (iter->err == BF_NO_MORE_DEVICES)
> > +     if (iter->err == BF_NO_MORE_DEVICES) {
> > +             log_debug("-> err: no more devices1\n");
> >               return BF_NO_MORE_DEVICES;
> > +     }
>
> Thinking more about what I said in the previous iteration about git
> blame history, ones like this should be log_msg_ret (the history on
> "when did the test for == BF_NO_MORE_DEVICES come from is unchanged, but
> now you can have debug statements when enabled).

Yes we can add that as well, but I still want to have the log_debug()
as this doesn't require enabling CONFIG_LOG_ERROR_RETURN. That feature
produces a lot of output even in normal operation since it shows
errors dealt with by higher level code. It is really only designed to
find the source of a particular error when you are stuck.

>
> [snip]
> > @@ -228,11 +234,15 @@ static int iter_incr(struct bootflow_iter *iter)
> >
> >       if (iter->err != BF_NO_MORE_PARTS) {
> >               /* ...select next partition  */
> > -             if (++iter->part <= iter->max_part)
> > +             if (++iter->part <= iter->max_part) {
> > +                     log_debug("-> next partition %d max %d\n", iter->part,
> > +                               iter->max_part);
> >                       return 0;
> > +             }
>
> Shouldn't this be a debug message instead in the caller?

I am trying to log_debug() every exit from this function...so you can
see the entry and then which path it took.

>
> [snip]
> > @@ -326,8 +336,13 @@ static int iter_incr(struct bootflow_iter *iter)
> >       }
> >
> >       /* if there are no more bootdevs, give up */
> > -     if (ret)
> > +     if (ret) {
> > +             log_debug("-> no more bootdevs\n");
> >               return log_msg_ret("incr", BF_NO_MORE_DEVICES);
> > +     }
>
> Then do we actually need both a log_debug and a log_msg_ret?

Please see above.

Regards,
