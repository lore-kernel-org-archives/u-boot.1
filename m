Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34601F8D763
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 17:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F80E8423D;
	Thu, 16 Apr 2026 19:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N5pYVbBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76FD18423F; Thu, 16 Apr 2026 19:42:48 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E21F841C8
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 19:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9910707d82so1063564666b.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776361365; cv=none;
 d=google.com; s=arc-20240605;
 b=XjTrzvoq3E52pSeYunXoJmy9WXLM74Yf2uP/k/FBsu1cnao/AXXvXSvI2Wdk9vKj/a
 HLKdNe5LzcjEaTtRjrIycKDONumce7LnstJvEM/NTF278NKbjnnpt88a4IZUUaz1t/9x
 P/pi6pUWaY6kYJfjj8CwGOu3oy7t7bPYv3pGpOK7nDwWpUIe+8rUgV8ba2Dfc4ieKm7a
 +cxdafUbIPptzA6KrWc2FrQBZbqshOfxFFnKvrR6m4PIFzJkZYESflH+eDiV9AZ7SzgD
 j4nUPsFk1WIbJhseY+ky2bkEtDn2cjHVwLzmp1WiWWPk9bv0/q0fGzYF/qHjvxCDwJUd
 UZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=abioz4ddlVx6lcq3OscoPrzTeiri1nooeHkXWS33Rp8=;
 fh=x8CHnSGD4cRa4Gb5OxW3DEd7ozMoYZsI49tbFC7/xcM=;
 b=IhZB5T7TdM5t3mSk1QUbxaOOna1zKjIJj0qa8mwVn0o+1WF+1qWSpw/9fiqOSxVaGW
 Vir5NsGgwlY1mMgLZ3eu9rmJw6bsEElE3/Czd0mJGddmQogt5rFJVdJuBQ4201ltVwSq
 4ipAA6bbG5mgj+VltiPi6jiIGXXJpAHnwEH1Q/kHTCCc4FkE8pknjXgX80LEvkKrNFgZ
 QkCZEell72kdCQYkX5MPRqwpAuA853sfJekHJuFG8fXatHqM/B8uARXmd14QpgoOMf3q
 on3cSAn0nAWPZGGtPMYUSXgxS5erj5/tarc9nwxmrQm7FTRBtZAk2y18Ys4NRQHzOYzG
 dUJA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776361365; x=1776966165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=abioz4ddlVx6lcq3OscoPrzTeiri1nooeHkXWS33Rp8=;
 b=N5pYVbBWyNqxABh+aOloNh9y39Rfp2pXRkzF7Tg/xInW/u3VjJko175/kA4ZOOlYnu
 ss4LeumeV73MXEss6tUaNgyyyGEfMvHm7SsC9yyFAjHvYV5KyDtJvK16fBWOmY7dFEge
 1dfOVwJ5z2i8Af/lJNMq1R0wxyKqSlZPBWRkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776361365; x=1776966165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abioz4ddlVx6lcq3OscoPrzTeiri1nooeHkXWS33Rp8=;
 b=aAOlVsdlbxTI0CMkJnwH4m0bbOrzVbgKGmXdq+jzJcCA0oKFJ9yKOkGOI1KUSkrsU3
 C34r1fHeVn3YPAatWiTi/OARLu79kO3u+xtqJqxNpewp8wUh1oJk/rNiDkhmGwEdxDoo
 Vxxpnebn5y67UNIX82loS4TCMUGZlrIlyr4cQjdiNB/35+2JhYn9fzdgZiKUMi3gZsDF
 WJWd9rFjzNMpre8ve3O1ipATIrPx3n2n0eBlzGjAQHfVN1UP4xumouRZ06qLvzR7tsIV
 FACPC2sMgye7PGCSg6evTGfKNxR80yL11pvVjiveBvO5sUCqKp1h253+S63omwF3eLCr
 iLFg==
X-Gm-Message-State: AOJu0YxFkRnrECC78rvywUlupf/XD7RJ1G2lF0NcB0xxtuJ509w4NLw0
 JDub6OUPooPzKJ/sph+LO0oFQvIbWBw0/lMI7y+PnQzofTanIr5c6eTZXF7X+trVyCLkfY1nR3p
 UgpeAEwarsyIZ8L76tP69iM4vFCelXjxWcTZ5QAH5
X-Gm-Gg: AeBDies9n8Q61Xz8jMnp5QlxGN2Mkq1rs4FfVKiQL0js2sjDCKAbYaK+7n5zo3kw8MA
 ZmQUPWOpxs/IzaOc4eAkNzHb82ADBwEMslY4K7+NdrBL1R+X1a2ZioThZFhIHSjjtjNgz5RPpfk
 esLwqd9Ooekaev/pKRxAOGDCnNBc+H7liLlqafkl2KyQl53G3Rs5Df5nUozIgVBwxvIbSOymQPf
 C1Ew56MnLRfYawyrPnx6L8S5+Kdxb/eM9dMmFtPFp1VP2vHy4RhmlVq0hVZljhYdJGZAZH+erzh
 V714GMPy3dv5vAkRvS9+
X-Received: by 2002:a17:907:619b:b0:ba3:55bb:c380 with SMTP id
 a640c23a62f3a-ba3dc1a0c10mr17602766b.37.1776361365200; Thu, 16 Apr 2026
 10:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260412111958.943933-1-sjg@chromium.org>
 <20260413201344.GF41863@bill-the-cat>
In-Reply-To: <20260413201344.GF41863@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 05:42:32 +1200
X-Gm-Features: AQROBzAO8ALD39Q2JA5racSLgdbfNMXmRe3kxRjTdDYLPrqUF9rCsn_U4XO7yhM
Message-ID: <CAFLszTg5kA7fee0t_w93Xt9cR89V-8VWQ-_2eKLz1M4rjaqA2Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] test: Add support for passing arguments to C
 unit tests
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>
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

On Mon, 13 Apr 2026 at 14:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Apr 12, 2026 at 05:19:37AM -0600, Simon Glass wrote:
> > Some tests have two parts: a Python test which handles setup, such as
> > creating filesystem images or configuring the environment, and a C
> > test which does the bulk of the work including assertions. At present
> > there is no way to pass information between these two parts, so
> > things like paths and device names must be hard-coded in the C test.
> >
> > This tends to make people write tests in Python, but this is not ideal
> > for several reasons:
>
> You still need to work on explaining your changes in a positive manner.
>
> > - Python lacks access to things like return codes and has to scan the
> >   console output to figure out what happened
>
> Pro: Python exercises things the way users exercise them and so exposes
> deficiencies in our user interface as well, when applicable.
>
> > - Python lacks access to internal state, so it cannot directly check
> >   the result of an operation
>
> It's unclear when that is, or is not a problem and when tests that do
> check intermediate state are providing value.
>
> > - Python is ~100x slower due to console interaction, etc.
>
> Again, maybe you should go back to your suggestion of several years ago
> to see about addressing that, as the tests themselves are not slow, it's
> the pipe? Our brave new AI powered world runs on Python handing stuff
> off and getting it back super quickly.
>
> > - C tests can be stepped through in gdb, which is much harder with
> >   Python driving the console
> > - C tests can exercise internal APIs directly (e.g. fs_read(),
> >   fs_size()) rather than going through the command layer, so they
> >   test more precisely what they intend to
>
> All things that may or may not be problems for other people, or are
> intentional choices as they again test the system the way it's used.
> Using gdb attached to u-boot in the other terminal where you're running
> breaking things sounds like a reasonable debug path to me. And having
> unit tests calling in to functions is why today we have a lot of things
> not marked as "static" and so not being optimized as well as they could
> by the compiler, which is its own set of trade-offs and not an automatic
> good thing and design win.
>
> [snip]
> >  16 files changed, 1437 insertions(+), 279 deletions(-)
>
> All of which is to say, you need to explain yourself in a positive, not
> negative or oppositional way. Otherwise this reads like "I don't like
> what we do now, here's a bunch of change to what I like instead".

Just to check, is this a discussion and you would like me to reply
with more details about the benefits of C over Python in particular
circumstances? Or are you wanting the cover-letter rewritten. Or is
this just a NAK?

I did some work on using a socket to talk to sandbox (it is faster and
also avoids some of the confusion as to what state sandbox is in
without having to rely on looking at console output). But I never
quite finished it. The other option (which we briefly discussed years
ago) would be to build U-Boot as a Python module. I haven't tried that
at all, but it's an idea.

I am well aware of the tradeoffs between Python and C, so I am not
advocating one over the other in all cases. I use gdb a lot with the
pytests - e.g. hunting down memory leaks recent. Really I just want
them to coexist better - i.e. improving the sandbox pattern where
Python sets something up and then C runs it.

- Simon
