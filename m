Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE07CCCD183
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 07:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F8EB83C2B;
	Sat, 11 Oct 2025 09:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XYoa958X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622A283C94; Sat, 11 Oct 2025 09:20:08 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB3BD83C16
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 09:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6318855a83fso5997613a12.2
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760167205; x=1760772005; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qP4K7Po352FmS3vKvQ+DRm9Jc7GCb6nfPYRgFURbWDc=;
 b=XYoa958XYO5iKZzUm++lYjoCkLcftLe0zCf/6txo22Sx7ZNEa2VR70sP+JGwZFesKe
 +kQGA4wznWAj6PKf0q6nXXz/W5PEy/3DpSDDAAYgXA47nak4jQNw/RaQpnAcsSujZQ7j
 pTtIMaPvqPR8lytCZkInBO54tonXzdKVWWBtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760167205; x=1760772005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qP4K7Po352FmS3vKvQ+DRm9Jc7GCb6nfPYRgFURbWDc=;
 b=bzZg5tZZd1vuaiVDDTzH90EogCqONCy5uT25KH+LuhcPfQMnYdnBAwVOF0kTm546vv
 oPto1q+Ag+7xg0Cz+tQHzs0/sHy2FcMcG8egs6uLfAi1ErvckSCk1u/+cndDwZ2Zh5Nv
 3m4oULnAutcEXJsu0WcOWh2o7EP44tBNmRJkoVA6eveGHRLSJc2U1dzTl3ecfOSsGkd0
 s4YueUhid9WM/d0Rhbzud+pWtQ4NHrI3wln6CJn/fnWSfXkHbiw1CCKz0qbvV1zGeBHp
 RUikOxUU3uLpq4MWBjdb6GcaoJzM347cAAkLejPkLAjCA/RZN8gW6Z1JgQTKiJLmQlCw
 LIZQ==
X-Gm-Message-State: AOJu0YzP7M+CLUuW5zEu+nYIBHnkgHxPKJxcURVoc+uJkz+cmjNfKVj1
 vBjDrJfMg1MTLTN8J4tw5sTPJOJxgbDv/OTAAHh+fj0ACcsItioz33XDVJHDKsbOAagh90JnJLa
 /QY2G3YMlUpE7Hyh2Wd9S9Vpuc9/pn12uDKqhu0m2
X-Gm-Gg: ASbGncssLjSwF2+wGBmekKIa3pUEu9lY9X+KUdxPwamPrWHn3ifYkuWk2TqpRggXA3J
 xiQfLtBhvpA+XWmXXX6oX/fOVMnHAOW0vXJWKiWdnpBxySMXCoB0NF+PUMcAT5ZS0Us/67z2jOx
 rRIic2FO+Jg6aq7akfhkHXys3zl6iq+qKbBwK72u4LLpGtiQD1gPSl0u8f/mOPIq8A9pI0LFYu6
 ylIjFWLO3Ltzl7LOJIhshzuLA==
X-Google-Smtp-Source: AGHT+IH8w2Dlgq3IGLwrq8X6jx2DAx2VOBbn68/ii3hlcJ4Dq11a5H3nur1v5FtlIk4xExIkQBJpEvzzbc0Y0z0IcIE=
X-Received: by 2002:a05:6402:23c9:b0:634:c03f:c605 with SMTP id
 4fb4d7f45d1cf-639d5c75dbfmr12453548a12.36.1760167205176; Sat, 11 Oct 2025
 00:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-4-sjg@chromium.org>
 <20251009173052.GQ298503@bill-the-cat>
 <CAFLszTi2HuZLmebJB+kUsL3_J+aqVdCdP5XFSEoY1Dy5C3E2wA@mail.gmail.com>
 <20251010143528.GZ298503@bill-the-cat>
In-Reply-To: <20251010143528.GZ298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Oct 2025 08:19:53 +0100
X-Gm-Features: AS18NWCMDJAqZp998El2FUlHgW7PK8osRcCM7OtBI5VyPVW8UyZuoA_NMkjpm_k
Message-ID: <CAFLszTh+K2Yr0OtZ_cNk9YrrGxg3KAv2SEppK=a-g1sw=hncLg@mail.gmail.com>
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

On Fri, 10 Oct 2025 at 15:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 10, 2025 at 11:36:10AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 9 Oct 2025 at 18:30, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Oct 09, 2025 at 03:29:54AM -0600, Simon Glass wrote:
> > >
> > > > This function is the core of the bootstd iteration. Add some debugging
> > > > for the decisions it makes along the way, to make it easier to track
> > > > what is going on.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  boot/bootflow.c | 23 +++++++++++++++++++----
> > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > > index 78df09f369d..de69e27bec7 100644
> > > > --- a/boot/bootflow.c
> > > > +++ b/boot/bootflow.c
> > > > @@ -193,8 +193,10 @@ static int iter_incr(struct bootflow_iter *iter)
> > > >       log_debug("entry: err=%d\n", iter->err);
> > > >       global = iter->doing_global;
> > > >
> > > > -     if (iter->err == BF_NO_MORE_DEVICES)
> > > > +     if (iter->err == BF_NO_MORE_DEVICES) {
> > > > +             log_debug("-> err: no more devices1\n");
> > > >               return BF_NO_MORE_DEVICES;
> > > > +     }
> > >
> > > Thinking more about what I said in the previous iteration about git
> > > blame history, ones like this should be log_msg_ret (the history on
> > > "when did the test for == BF_NO_MORE_DEVICES come from is unchanged, but
> > > now you can have debug statements when enabled).
> >
> > Yes we can add that as well, but I still want to have the log_debug()
> > as this doesn't require enabling CONFIG_LOG_ERROR_RETURN. That feature
> > produces a lot of output even in normal operation since it shows
> > errors dealt with by higher level code. It is really only designed to
> > find the source of a particular error when you are stuck.
> >
> > >
> > > [snip]
> > > > @@ -228,11 +234,15 @@ static int iter_incr(struct bootflow_iter *iter)
> > > >
> > > >       if (iter->err != BF_NO_MORE_PARTS) {
> > > >               /* ...select next partition  */
> > > > -             if (++iter->part <= iter->max_part)
> > > > +             if (++iter->part <= iter->max_part) {
> > > > +                     log_debug("-> next partition %d max %d\n", iter->part,
> > > > +                               iter->max_part);
> > > >                       return 0;
> > > > +             }
> > >
> > > Shouldn't this be a debug message instead in the caller?
> >
> > I am trying to log_debug() every exit from this function...so you can
> > see the entry and then which path it took.
> >
> > >
> > > [snip]
> > > > @@ -326,8 +336,13 @@ static int iter_incr(struct bootflow_iter *iter)
> > > >       }
> > > >
> > > >       /* if there are no more bootdevs, give up */
> > > > -     if (ret)
> > > > +     if (ret) {
> > > > +             log_debug("-> no more bootdevs\n");
> > > >               return log_msg_ret("incr", BF_NO_MORE_DEVICES);
> > > > +     }
> > >
> > > Then do we actually need both a log_debug and a log_msg_ret?
> >
> > Please see above.
>
> I guess my question is, but why? Is this something that's going to be
> debugged frequently? Why doesn't every function have meaningful text
> string log_debug messages, just in case? And then why bother with
> log_msg_ret at all?

I have found myself in this function quite a few times, trying to work
out what it is up to, so I decided to add more debugging.

Anyway, would you like to just drop this patch, or something else?

Regards,
Simon
