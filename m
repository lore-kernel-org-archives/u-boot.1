Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443F5E6FE48
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 20:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6637F88CD0;
	Fri,  6 Sep 2024 22:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HvMdeDe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEAB88CD8; Fri,  6 Sep 2024 22:00:30 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6AE188CC4
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 22:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a99fde9f1dso40406885a.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725652826; x=1726257626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f5c9J3QeTNgqA3Jw/HHcZHTjlRONm58cLnDy1MhxWK8=;
 b=HvMdeDe+koMl5qCPLJedTl2WoRkJVH8fhdcSHO8Ak20PeavPLSp01FQa8AhgmY+t8Y
 Y3iDfsYOl9LY5MRYDTjujFyKxEM5BZO/BCwRXFnJtA7JEewofnNOhJd/AdLsSI4NcRI2
 v7iwD7OMGGNUGKqV/CXyzm94oZnnkP146sshw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725652826; x=1726257626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f5c9J3QeTNgqA3Jw/HHcZHTjlRONm58cLnDy1MhxWK8=;
 b=PXofBLye4iUo4X5s//XAXmcD0x4EfgVhA8RhRVdhio7vKw0I83XBkSvITIMtvfJbsW
 G/EGfF6+rZ/PQUXTViHyrt/eux26hLC3MS+wSJ+7u3gid6iSeVnwsAx3BKrYkFFx0Z2U
 KUwiusLR4/t7QrPKrAp6TsCvvDTuKz3852BP6kG8C6cU92YFAmjefSuq14Q49kGutLqn
 CG+wt+OlW+mfazg85SDaQggFbqBcqPfAabQroXccKVWgthdGpLWoMjd40qQEheCfDmp5
 DAfXL7+mxPQe8HY5YTJ/beemWSnmRvVD1OHRVGZU5OJWBALLho4eMgQbHrIhgkaYb6SV
 NV4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO8jirYA3Zz2anJ/cRFmmMtVfwybL2w0l9dUHhP26/+1lfR3Djrwsl8p93qZLjAIe/oHMQGUs=@lists.denx.de
X-Gm-Message-State: AOJu0YzQ+vwwkFbCVNRbTU2uc02PUTy/h8VGXt8QbAKTv0qAeWaXOb70
 pVV2NWzBapT0/R2KflaIJ+ZaXIgkw7O6RLmI78npSrVYMAwml4uDoJqL3BROJgje8b6DfBtIVNT
 DDIou9z9ttJLXpZ+NrRV0e9Vka489Q/6+jSMa
X-Google-Smtp-Source: AGHT+IHqJk8FnX14OR6aIssoj/ENOC6l5YILCJ9eWoHKKk5upQMtqPJ5HG7iFx2OL/3vE4Q9qQHqQKLIriCrvootAaY=
X-Received: by 2002:a05:620a:31a4:b0:7a4:dff8:35e6 with SMTP id
 af79cd13be357-7a9a3969b96mr29118785a.62.1725652826542; Fri, 06 Sep 2024
 13:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-18-sjg@chromium.org>
 <1637be2a-2fa8-4686-8868-077ed430ae8a@linaro.org>
 <CAFLszTjZOjXwY4PXGWkCu-7ehuA_XBCcnjLtmF4hKUC2K-NyNA@mail.gmail.com>
 <20240829165906.GG2479150@bill-the-cat>
 <CAFLszTh4A2NH8d6hocom3pAzYB4ExgVbDRa+6phux7K5P9X4Pg@mail.gmail.com>
 <20240830142620.GS2479150@bill-the-cat>
 <CAFLszTjZmKKQSVTU5rhH_xX-neP1ZWByX96xUNxc-JTOY8R2yA@mail.gmail.com>
 <20240903184805.GK2479150@bill-the-cat>
 <CAFLszTh2kuoxEUuHUkoWY_Yykc8N1gOE+Gc_-15jKreHyYmWtw@mail.gmail.com>
 <20240906184327.GH3879073@bill-the-cat>
In-Reply-To: <20240906184327.GH3879073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Sep 2024 14:00:15 -0600
Message-ID: <CAFLszTi0vwLXMk_kWQps84V=23LJP-j_PP3y+TMNk19hPAJSDg@mail.gmail.com>
Subject: Re: [PATCH v5 17/20] test: Try to shut down the lab console gracefully
To: Tom Rini <trini@konsulko.com>
Cc: neil.armstrong@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 6 Sept 2024 at 12:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Sep 05, 2024 at 06:50:20PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 3 Sept 2024 at 12:48, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Sep 01, 2024 at 02:09:58PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 30 Aug 2024 at 08:26, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Aug 29, 2024 at 07:04:36PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 29 Aug 2024 at 10:59, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Aug 29, 2024 at 09:01:17AM -0600, Simon Glass wrote:
> > > > > > > > Hi Neil,
> > > > > > > >
> > > > > > > > On Thu, 29 Aug 2024 at 08:26, <neil.armstrong@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > On 29/08/2024 00:08, Simon Glass wrote:
> > > > > > > > > > Send the Labgrid quit characters to ask it to exit gracefully. This
> > > > > > > > > > typically allows it to power off the board being used.
> > > > > > > > >
> > > > > > > > > Sending those characters every time could collide with other CI systems,
> > > > > > > > > I don't think it's a good idea.
> > > > > > > >
> > > > > > > > What systems are you thinking about and what sort of collision would occur?
> > > > > > > >
> > > > > > > > What do you suggest instead?
> > > > > > >
> > > > > > > Why do we need this at all? Did I miss where we send picocom the
> > > > > > > disconnect nicely key-combination?
> > > > > >
> > > > > > When labgrid gets a signal, it exits. It doesn't continue its
> > > > > > co-routines and execute the end strategy to power things off, etc. I
> > > > > > suspect it could be made to do that, but I already have 62 Labgrid
> > > > > > patches, so I thought this would be expedient...
> > > > > >
> > > > > > I can make this conditional on the new USE_LABGRID variable.
> > > > >
> > > > > It sounds to me like we need to make generic improvements to our hooks
> > > > > then, if there's not a "now call poweroff" hook.
> > > >
> > > > The thing is, Labgrid has its own internal console, which allows me to
> > > > see all the output from reset. If I use picocom or some other program
> > > > then some of the output is gone by the time I connect, particularly
> > > > when using USB download. Because of that, just killing Labgrid, which
> > > > is what pytest does, is a pretty heavy hammer and leaves things in an
> > > > unknown state. So I added this method to give it a software signal.
> > >
> > > OK, but we shouldn't care? You can have the console available to pytest
> > > and a terminal at the same time, with labgrid. If you need to see before
> > > pytest grabs it, have the terminal be the first console, not pytest?
> >
> > I'm a bit lost at this point...'labgrid-client console' creates a
> > console connection and it keeps running until killed, with that
> > console connection connected between its stdin/stdout. Then pytest
> > uses that.
> >
> > There is only one console.
> >
> > I care because missing output makes it impossible to see what went
> > wrong, if something went wrong.
>
> There's not one console, is what I'm saying. You can connect to the
> console via a terminal while pytest is running from another terminal. So
> if you have a problem and it's in that window where we're just starting
> up, grab the console for you first and then let pytest go second.

This patch is actually about gracefully closing down labgrid-client.

When pytest is running tests on a board, I don't need/want to connect
to it separately.

Note that with labgrid I added an internal terminal, to avoid picocom
(or microcom) losing the initial output. I can't really say it any
other way. It definitely happens and it is definitely a problem,
promise!

This patch is about letting labgrid shut down nicely, rather than
leave things in a strange state, requiring a separate call to power
things down, for example.

>
> > > This gets back again I think to your specific way of making use of
> > > labgrid contrasting with just generally supporting labgrid with however
> > > another physical lab has set it up. Does killing one connection really
> > > reset all of them? Or was it just a conflict with your
> > > auto-acquire/release?
> >
> > Are you talking about the Labgrid exporter, perhaps? This patch is for
> > the client and we have one client process running for each board we
> > connect to. You can see that in the Labgrid version of the
> > u-boot-test-console script which basically runs labgrid-client and
> > let's it do the talking.
>
> It's about the assumptions that are true for your lab (and possibly
> others) that aren't true for my lab (and possibly others).

OK. I'm very happy with my lab at the moment. It permits pytest,
interactive use and gitlab. But, yes, there are many ways to do all this...

Regards,
Simon
