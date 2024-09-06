Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EE8CE7AA6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 00:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D361A88ABE;
	Fri,  6 Sep 2024 02:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l8yPQWtW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A0BC88CC2; Fri,  6 Sep 2024 02:50:34 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3AAD88440
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 02:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e1a8e305da0so1613806276.3
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 17:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725583831; x=1726188631; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gv4FjIFtyP9+LnDGHzu+HoUplrqVNUl4Zr3+eQFNTf4=;
 b=l8yPQWtWSYBL7tWXYJEGdX70l9NgWgOrn2DnP4es7ua1ZiPGgz4GlK4vlxt8qa6ykP
 qYt9kUPiBmHnbcBbeB2ESL6ppeeQ5BldVs9p8H+m9lDQkJvlJ9Cfh8ur7/Qk7jxKPb5+
 4mPkFIr5knZIPoOVX6u9jBF9uIlfFLZHY8D64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725583831; x=1726188631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gv4FjIFtyP9+LnDGHzu+HoUplrqVNUl4Zr3+eQFNTf4=;
 b=GhIMmDnjgIKPpILTp6T7H8ykMk811aju/GLroWCs7OvCIcsTUwLV34kzmUpoqKXSIK
 mF6okXtjgE5UspGvd/gxQlU0Z2aKRbsRl6ArQYKirH/7aeu3vIYSasyoik+YxNnU8KJ+
 I3HKnEhc9Bc7dP83KmWOlGeLbkJ/XQe8adeXgLQIzzm2g/z0sBDmR8OrCnWcZm2NRWEP
 pHpl71uYkJsyvyTOmfUPrePCH2/FEX0a3OKlX8Lj9gEtWYS6LU4ACpkoqJNNcPCP2L/p
 GzOU/zwkEiuohpxkdAFJFdX+AVmj2lwAGPhgGQXCIHdcA9MN77zY97xDjTxIypuqI3GW
 wTvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8dcOUpuojpZUju9Mh5ctH5oAehTocb3U88rn1+2wkj3AF8Y5g8l4Dp0dVLxAurrd20UyhgLI=@lists.denx.de
X-Gm-Message-State: AOJu0YwlC4H7LJDArq8tQItaWewMX1qJuCrznTG/T1y48aPLLULMaVbd
 qijsT9xA/TkKbp5ary58liqIPk+Z1m/ZUEPcUGGGT9OZTwHCboeNipklUxlBCle6j4jZjPtJaDH
 TAoOQXzb2xSBsyilrOjllqOsgGtlAiuyGiYUa
X-Google-Smtp-Source: AGHT+IFJne9Fvw24vvL+ukJiCgepAFSL7PFi1bYxQHVfllrmuCJ9u0AT1MYJmCkz5HoKDMLykgaE/M3bsSt4cwLlKgE=
X-Received: by 2002:a05:6902:218c:b0:e11:58ef:de63 with SMTP id
 3f1490d57ef6-e1d34a38089mr1186780276.41.1725583830750; Thu, 05 Sep 2024
 17:50:30 -0700 (PDT)
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
In-Reply-To: <20240903184805.GK2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Sep 2024 18:50:20 -0600
Message-ID: <CAFLszTh2kuoxEUuHUkoWY_Yykc8N1gOE+Gc_-15jKreHyYmWtw@mail.gmail.com>
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

On Tue, 3 Sept 2024 at 12:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 01, 2024 at 02:09:58PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 30 Aug 2024 at 08:26, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Aug 29, 2024 at 07:04:36PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 29 Aug 2024 at 10:59, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Aug 29, 2024 at 09:01:17AM -0600, Simon Glass wrote:
> > > > > > Hi Neil,
> > > > > >
> > > > > > On Thu, 29 Aug 2024 at 08:26, <neil.armstrong@linaro.org> wrote:
> > > > > > >
> > > > > > > On 29/08/2024 00:08, Simon Glass wrote:
> > > > > > > > Send the Labgrid quit characters to ask it to exit gracefully. This
> > > > > > > > typically allows it to power off the board being used.
> > > > > > >
> > > > > > > Sending those characters every time could collide with other CI systems,
> > > > > > > I don't think it's a good idea.
> > > > > >
> > > > > > What systems are you thinking about and what sort of collision would occur?
> > > > > >
> > > > > > What do you suggest instead?
> > > > >
> > > > > Why do we need this at all? Did I miss where we send picocom the
> > > > > disconnect nicely key-combination?
> > > >
> > > > When labgrid gets a signal, it exits. It doesn't continue its
> > > > co-routines and execute the end strategy to power things off, etc. I
> > > > suspect it could be made to do that, but I already have 62 Labgrid
> > > > patches, so I thought this would be expedient...
> > > >
> > > > I can make this conditional on the new USE_LABGRID variable.
> > >
> > > It sounds to me like we need to make generic improvements to our hooks
> > > then, if there's not a "now call poweroff" hook.
> >
> > The thing is, Labgrid has its own internal console, which allows me to
> > see all the output from reset. If I use picocom or some other program
> > then some of the output is gone by the time I connect, particularly
> > when using USB download. Because of that, just killing Labgrid, which
> > is what pytest does, is a pretty heavy hammer and leaves things in an
> > unknown state. So I added this method to give it a software signal.
>
> OK, but we shouldn't care? You can have the console available to pytest
> and a terminal at the same time, with labgrid. If you need to see before
> pytest grabs it, have the terminal be the first console, not pytest?

I'm a bit lost at this point...'labgrid-client console' creates a
console connection and it keeps running until killed, with that
console connection connected between its stdin/stdout. Then pytest
uses that.

There is only one console.

I care because missing output makes it impossible to see what went
wrong, if something went wrong.

> This gets back again I think to your specific way of making use of
> labgrid contrasting with just generally supporting labgrid with however
> another physical lab has set it up. Does killing one connection really
> reset all of them? Or was it just a conflict with your
> auto-acquire/release?

Are you talking about the Labgrid exporter, perhaps? This patch is for
the client and we have one client process running for each board we
connect to. You can see that in the Labgrid version of the
u-boot-test-console script which basically runs labgrid-client and
let's it do the talking.

Regards,
Simon
