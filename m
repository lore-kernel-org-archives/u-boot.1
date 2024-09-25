Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536BFC369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF6688C1C;
	Wed, 25 Sep 2024 14:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HiBI72LN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B98988C24; Wed, 25 Sep 2024 14:50:36 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B646588B6D
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5e5b57127e6so1272330eaf.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268614; x=1727873414; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0fPmAatSQuYm8pzIayvGGkgTSEpvF5nX+SAxmUaYCGQ=;
 b=HiBI72LNXJ4QdcbmwvwbiMHzLND+fAml8iYOhT4zvtcI23osFu0x8oLE3OyesDssJa
 Vw/V1Z5iYvHekWWjSmbX/JD2WYbf6Fs6NXhX/rlpZMOTqvjNWipTycRI9eJhy0H9qY+i
 0q+4XWD+qVast9W7v2bLTuR4HZgzOVRytkXsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268614; x=1727873414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0fPmAatSQuYm8pzIayvGGkgTSEpvF5nX+SAxmUaYCGQ=;
 b=wosbCS1v6yj6WePLDQ7hyUEIxq2JE0lZzTP6QqrunppNIuUqueLbWw7OI1EY7+txqK
 sRp6yHn+4eD7AVFYEg9jOE9XV/ncWMw2WyjVQeRmGFEgFbyoABRRT3sBRHlicUdHLFmY
 Vd+26itE3q3j0Ouxkm93n/totBG+gjAtQdDkiWmDNCJnzYVBmRjAPJ9oAo5D5Qhq3gE4
 Bckh7MfNNNAHf1UVsuwWHku6N+CrcXblL3/c7mptztHC5k6NQvHIVHLvvIVS6usu79oy
 P6qJt9N6pnLcbMKp0ggNllTNewB32UbeDz7crELe4MADrp1aRPz03wXJ3JbLNjEqku9W
 +gCw==
X-Gm-Message-State: AOJu0YwHT0yUZothl2048WG/7OWjGVHZ3yJEY+I9OmpneJVdSAMyROu+
 Hv2FvGZeBsDTKzXkZWOd4wBtd1LWrBsGRr5r5Y12gfWWtysB+jaaNGML2jLoLKAjFjXPf2oeoSK
 y3GIjUoYdpfQelYqR+ukypE9E2/OuULkazHBAz7jMT5NdosW72g==
X-Google-Smtp-Source: AGHT+IG5fwUx3rhNui83BPQKxsfY8wCif623ocsDYFOm3ZLdjSuOAuJ9yNvCra/uwYWjrzuNYKyaN+3ffaZUYU9nA9g=
X-Received: by 2002:a05:6358:78c:b0:1ba:455d:e5a1 with SMTP id
 e5c5f4694b2df-1bea862a700mr145183555d.22.1727268614496; Wed, 25 Sep 2024
 05:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-5-sjg@chromium.org>
 <20240923203528.GS4252@bill-the-cat>
In-Reply-To: <20240923203528.GS4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:50:01 +0200
Message-ID: <CAFLszTig=StMBjcz-ouWF_HiTJSc3y5x-e6Zexq1n41DP_FttA@mail.gmail.com>
Subject: Re: [PATCH v6 04/19] test: Allow connecting to a running board
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Mon, 23 Sept 2024 at 22:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 20, 2024 at 08:01:39AM +0200, Simon Glass wrote:
>
> > Sometimes we know that the board is already running the right software,
> > so provide an option to allow running of tests directly, without first
> > resetting the board.
> >
> > This saves time when re-running a test where only the Python code is
> > changing.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  test/py/conftest.py                   |  3 +++
> >  test/py/u_boot_console_base.py        | 14 ++++++++++----
> >  test/py/u_boot_console_exec_attach.py | 21 ++++++++++++---------
> >  3 files changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > index fc9dd3a83f8..ca66b9d9e61 100644
> > --- a/test/py/conftest.py
> > +++ b/test/py/conftest.py
> > @@ -79,6 +79,8 @@ def pytest_addoption(parser):
> >      parser.addoption('--gdbserver', default=None,
> >          help='Run sandbox under gdbserver. The argument is the channel '+
> >          'over which gdbserver should communicate, e.g. localhost:1234')
> > +    parser.addoption('--no-prompt-wait', default=False, action='store_true',
> > +        help="Assume that U-Boot is ready and don't wait for a prompt")
>
> I don't think this is the right name for what the commit message says we
> have? Maybe something like --use-running-system or otherwise make it
> clear we're using the board as it's already up and ready to go?

OK, I can change it. The name I have chosen refers to the behaviour
rather than the effect, but switching to a flag which describes the
effect is fine with me.

Regards,
Simon
