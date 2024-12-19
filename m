Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A66E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273FE8022B;
	Thu, 19 Dec 2024 16:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WqP6hipC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4F3880328; Thu, 19 Dec 2024 16:07:37 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC038021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so156870566b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734620855; x=1735225655; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0cY6t8HM5qMscrZ/w5/f7Lx8xt47p0V1/ST5W1iybhw=;
 b=WqP6hipC4iFh2uHUw6wrwYgzcR/js2aQNSEpTecC6pPCNNMJe2vGgeLKHW94nUT79q
 RtQo8Esa0jS4HLUiO5OmhLO2A4VKNB1pKTt1M2zjf230o4x85uYUBaOK9WQtqxFMMksV
 JrhpGF0K4zsUMtqHwwQJQd1knee0bzcuMagL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734620855; x=1735225655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0cY6t8HM5qMscrZ/w5/f7Lx8xt47p0V1/ST5W1iybhw=;
 b=U08CTeidx1Xl26kfOcARm/s1AdhDCh9zFJ05fGVferA0FlfJ3rkXp5igcw1krZ2MYp
 sg1c/gizFuX25Hz4fErQ4HCI6F7Lbj2vmh+8shsohSorwEfSCYBiKTpx7GjLeRvZw7Zc
 6oWWULbO1PSDHmDeTqGhZKXUtL8aHsoywWNZ33JQFFir+iWWGVHvCQmJNeKZcifJjTab
 7DxHqyFdrE8jyTbGfts7/+ZlyH8H9w6/Zb+IgiMumeJ/VQ+R4t3KI0c75XBzuHpXk+iI
 USHRv7BmsjaDiiW3seZvRq2MmSYVzLcHTVDdvQmD1IYBV0/0vI2GeB7HAjTkw+iN3y6f
 Eb7w==
X-Gm-Message-State: AOJu0YwLWL/QRVinPdcJ56lg6xiyo4t6QhRcr3OJZXQl1QnjcJtpFlkc
 zGYhWi1iqJUaGzXc4Mk37AnH5dDVFMoSA1qh7+qVzXNCkFpfEyRLxs72SCkvfjvuhrEDIwIzxh4
 l8blOoF7j8yIFGqXAJlee4vhB9oh9uLeTbkbfpfoivsfvcMs=
X-Gm-Gg: ASbGnctO5UncbJHEnZyiwBXOk2OFboj3TkS8vhYz6S2CYuXvElFPXhgqviE+cXDEr3t
 4Oauuj8M2RTUiQSY2L2835tQx8v1w+MX73wmztsY=
X-Google-Smtp-Source: AGHT+IHbAmWAUMPkBW10fhrKbzE8IMB7BDKecqhTrCPyfrJVzDbLOcEBuby2dmcK8zqJsiYEPOogYhkRqEtpuolL0us=
X-Received: by 2002:a17:907:9715:b0:aa6:8676:3b33 with SMTP id
 a640c23a62f3a-aabf490854amr611423666b.47.1734620853809; Thu, 19 Dec 2024
 07:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20241217132616.3708573-1-sjg@chromium.org>
 <20241217142016.GK1505244@bill-the-cat>
 <CAFLszTjfxxseCJUvUXPgZQWQYNrL+yT3u8qZ9OieJHxaC=dfDg@mail.gmail.com>
 <20241217195348.GQ1505244@bill-the-cat>
 <CAFLszTgaLn-xO104gw2meFTHBfVdWjPu+AiSXkYcSLM=uYWdrA@mail.gmail.com>
 <20241217235411.GV1505244@bill-the-cat>
In-Reply-To: <20241217235411.GV1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Dec 2024 08:07:22 -0700
Message-ID: <CAFLszTgyScyRrV0pNksMYB5r1RxGN1dnJFO-96XaLtn=NLZu+g@mail.gmail.com>
Subject: Re: [PATCH] buildman: Add a way to build a particular target
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>
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

On Tue, 17 Dec 2024 at 16:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 17, 2024 at 04:42:30PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 17 Dec 2024 at 12:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 17, 2024 at 12:45:29PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 17 Dec 2024 at 07:20, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Dec 17, 2024 at 06:26:16AM -0700, Simon Glass wrote:
> > > > >
> > > > > > At present buildman only supports building the default target. Generally
> > > > > > this is what is wanted, but in some cases boards erroneously have a
> > > > > > different target for product extra files.
> > > > > >
> > > > > > Add a --target option to help. Also add a comment indicating which
> > > > > > letters are free for new options.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > How do you use this? It would be nice to be able to do "--target
> > > > > u-boot-initial-env" for example for converting and verifying the
> > > > > conversion of boards to plain text environment. Except the list of
> > > > > artifacts that are kept isn't updated with that string as well. And
> > > > > FWIW, is this for a case not solved by CONFIG_BUILD_TARGET?
> > > >
> > > > It's related to the problem where colibri-imx8 doesn't actually build
> > > > an image with the default boot target.
> > >
> > > I don't recall if there's a good reason for imx8 not setting
> > > CONFIG_BUILD_TARGET to something, but that sounds like how to solve this
> > > problem. "make all" should work, normally.
> >
> > Even if it did, the build fails the first time. It just needs to be fixed/
>
> Yes, there's both the problem of CONFIG_BUILD_TARGET not being set and
> then whatever issues there are with configuring access to the blobs
> especially when they exist and aren't faked via BINMAN_ALLOW_MISSING.
> IIRC Toradex does weekly builds of top of tree, via OpenEmbedded / Yocto
> so there's not some bitrot here to be fixed, just smoothing out
> integration.

To me, BUILD_TARGET is a pre-Binman construction and we should just
use binman to make sure that the default target builds a bootable
image.

It's good to hear that Toradex has CI going, but it looks like there
is a workaround in there.

>
> > > > But yes, we could add more things to buildman, e.g. it could output
> > > > the initial env as a file for later parsing.
> > >
> > > Well, your patch supports that, if I read it right. It just doesn't save it.
> >
> > Yes, it would be pretty easy to provide a flag that builds that
> > target, runs the executable and puts the environment in a file.
>
> Er, "make u-boot-initial-env" does that. So "--target
> u-boot-initial-env" should suffice, if that was also saved.

Oh, yes. Either I didn't know that or I forgot...

Regards,
Simon
