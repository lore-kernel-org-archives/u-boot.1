Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9B4CCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 15:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3980B838D7;
	Mon, 13 Oct 2025 17:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DnnWZPl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E01D8382A; Mon, 13 Oct 2025 17:12:21 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C216838D7
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 17:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-637e9f9f9fbso8368083a12.0
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760368339; x=1760973139; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qqv9V++8+3noaS09ndlWfdz9SEc2GpjApA8wKp1sr5U=;
 b=DnnWZPl02qRIY/qv/Mf8EZav21YmA2FOHJ0qIlmI8W4JYcQ3Ff9MuGvjBt6SSVKsqq
 rLPVRlYveA+Op+LWFDvLN1qBfLVZkiRVz0y8ZNNqQ/w8Zcg80ec2AH4PTCzSDu4SKDq6
 oXIuCn7qQICe1ESPoz7ed/DHeAirqDPAb+RPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760368339; x=1760973139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qqv9V++8+3noaS09ndlWfdz9SEc2GpjApA8wKp1sr5U=;
 b=SVVW+77FYfvnL6GxQcKCEW77YECCwhHU3o++PT9I27ztHPEcnxZkfb95eRX//izXgr
 duT+36lWlgaIeCmsKvU7FVVXgDkUfmZW6sjV9Br/7m+a4yGWA3b1eEp7uYkkvHEQahS2
 Wu486yZZtI8mh6njmo+P27LcpOg9Nm23ZKHLIC/Rdwk2posgtEDOTyywBrt9hwnvleqT
 00KV/UZ1SOJaBknSEe3F1Cw6FQFH2ylTXuSPyUg/Gvb07RJ2J66/z7BIl0KG5iYb8dWE
 ZRYR/9mBsCbIrNWOH1CYDGxQf0tiwGQMO6B539qLxZ2va0ZyAW+xdGngX+CAfosZLpT2
 yt8A==
X-Gm-Message-State: AOJu0YzwF+5KWvxuwdZyO50lnXm4gv32TgKXS6Pj7PHX+YbmEr55IhFH
 v39q7SGEefDAuSBQgvdQMBjLzP1LE51efCgmxzrtYXf6fQ/C+4z1tBvGccNO4lU3j5zBncE/gc2
 Rc+TQ/QiT9wIv/rGGXvOPaNw5PuZlokTgC7Ty8BOJ
X-Gm-Gg: ASbGnctN/NBStHAqh8I831hEoMNgxI5FCjrZK1aScehfVD8q2N0FwrOylIL6QgKhJqY
 Kc3v4acQyxUk2H22v6+XmEsQrHfPZ2XHWkFaft5RhEsApDIW4YmiC16v6etwOAZrKLYArKZhko/
 txzW9By/s1burwb28UfMYByn3z43VW5FnoTV44SacsBhmbAbBkDMdoHTqbgDdoOqoHZI1Tr0unV
 DQOPdc6dPE6ZT045B484BXYtM9kDovurR8+bJHfrz0ETmJt3qLmZa2xTdR+HS/TKlrM/w==
X-Google-Smtp-Source: AGHT+IHlkuoKYScKngQKzdr9LWb13K8EkojvFechA1Lzo0f94eo2aPnehDSdIq/tpiuWrXqIXUDsWIj90daKAw/MOfg=
X-Received: by 2002:a05:6402:278f:b0:637:e022:5280 with SMTP id
 4fb4d7f45d1cf-639d5b577a9mr19083918a12.5.1760368338522; Mon, 13 Oct 2025
 08:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-4-sjg@chromium.org>
 <20251009173052.GQ298503@bill-the-cat>
 <CAFLszTi2HuZLmebJB+kUsL3_J+aqVdCdP5XFSEoY1Dy5C3E2wA@mail.gmail.com>
 <20251010143528.GZ298503@bill-the-cat>
 <CAFLszTh+K2Yr0OtZ_cNk9YrrGxg3KAv2SEppK=a-g1sw=hncLg@mail.gmail.com>
 <20251013141544.GD6113@bill-the-cat>
In-Reply-To: <20251013141544.GD6113@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Oct 2025 16:12:03 +0100
X-Gm-Features: AS18NWBuiptx8QkbLdy3-2Srvnq5Yus8mdaHi0plq7735B2LAklzx1yYiN2rVfs
Message-ID: <CAFLszTiOrWfEboYV+=xf0t1wdqeEhbo-SdjAquNCncMRxTur6A@mail.gmail.com>
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

On Mon, 13 Oct 2025 at 15:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 11, 2025 at 08:19:53AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 10 Oct 2025 at 15:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Oct 10, 2025 at 11:36:10AM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 9 Oct 2025 at 18:30, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Oct 09, 2025 at 03:29:54AM -0600, Simon Glass wrote:
> > > > >
> > > > > > This function is the core of the bootstd iteration. Add some debugging
> > > > > > for the decisions it makes along the way, to make it easier to track
> > > > > > what is going on.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  boot/bootflow.c | 23 +++++++++++++++++++----
> > > > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > > > > index 78df09f369d..de69e27bec7 100644
> > > > > > --- a/boot/bootflow.c
> > > > > > +++ b/boot/bootflow.c
> > > > > > @@ -193,8 +193,10 @@ static int iter_incr(struct bootflow_iter *iter)
> > > > > >       log_debug("entry: err=%d\n", iter->err);
> > > > > >       global = iter->doing_global;
> > > > > >
> > > > > > -     if (iter->err == BF_NO_MORE_DEVICES)
> > > > > > +     if (iter->err == BF_NO_MORE_DEVICES) {
> > > > > > +             log_debug("-> err: no more devices1\n");
> > > > > >               return BF_NO_MORE_DEVICES;
> > > > > > +     }
> > > > >
> > > > > Thinking more about what I said in the previous iteration about git
> > > > > blame history, ones like this should be log_msg_ret (the history on
> > > > > "when did the test for == BF_NO_MORE_DEVICES come from is unchanged, but
> > > > > now you can have debug statements when enabled).
> > > >
> > > > Yes we can add that as well, but I still want to have the log_debug()
> > > > as this doesn't require enabling CONFIG_LOG_ERROR_RETURN. That feature
> > > > produces a lot of output even in normal operation since it shows
> > > > errors dealt with by higher level code. It is really only designed to
> > > > find the source of a particular error when you are stuck.
> > > >
> > > > >
> > > > > [snip]
> > > > > > @@ -228,11 +234,15 @@ static int iter_incr(struct bootflow_iter *iter)
> > > > > >
> > > > > >       if (iter->err != BF_NO_MORE_PARTS) {
> > > > > >               /* ...select next partition  */
> > > > > > -             if (++iter->part <= iter->max_part)
> > > > > > +             if (++iter->part <= iter->max_part) {
> > > > > > +                     log_debug("-> next partition %d max %d\n", iter->part,
> > > > > > +                               iter->max_part);
> > > > > >                       return 0;
> > > > > > +             }
> > > > >
> > > > > Shouldn't this be a debug message instead in the caller?
> > > >
> > > > I am trying to log_debug() every exit from this function...so you can
> > > > see the entry and then which path it took.
> > > >
> > > > >
> > > > > [snip]
> > > > > > @@ -326,8 +336,13 @@ static int iter_incr(struct bootflow_iter *iter)
> > > > > >       }
> > > > > >
> > > > > >       /* if there are no more bootdevs, give up */
> > > > > > -     if (ret)
> > > > > > +     if (ret) {
> > > > > > +             log_debug("-> no more bootdevs\n");
> > > > > >               return log_msg_ret("incr", BF_NO_MORE_DEVICES);
> > > > > > +     }
> > > > >
> > > > > Then do we actually need both a log_debug and a log_msg_ret?
> > > >
> > > > Please see above.
> > >
> > > I guess my question is, but why? Is this something that's going to be
> > > debugged frequently? Why doesn't every function have meaningful text
> > > string log_debug messages, just in case? And then why bother with
> > > log_msg_ret at all?
> >
> > I have found myself in this function quite a few times, trying to work
> > out what it is up to, so I decided to add more debugging.
> >
> > Anyway, would you like to just drop this patch, or something else?
>
> I'd like to fix the underlying problem so that we don't have a similar
> discussion on your next series. As yes, I think in general all of these
> patches to add more detailed logging on top of log_msg_ret logging are
> too much. And I gather you're debugging these problems on real hardware
> where using some source level debugger with sandbox isn't an option?

What is the underlying problem?

The debugging was useful with the EFI app where it is sort-of possible
to use a debugger, but is a bit painful. I ended up comparing logs to
figure it out. Debuggers are not easy when the function being debugged
is called dozens of times.

I can imagine it being useful when someone reports a problem with the
iteration...we could just turn on the option and the person could post
a dump.

Anyway, I'm happy to drop this patch.

Regards,
Simon
