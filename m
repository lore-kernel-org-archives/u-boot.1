Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49318CD8CA3
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 15:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BE4386B79;
	Tue, 10 Oct 2023 17:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y7RRGCHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D372E86BA1; Tue, 10 Oct 2023 17:01:05 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6254A82BBF
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 17:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso9004479a12.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696950061; x=1697554861; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K8LgCfYIFvr9WsP8VkZMmeGK++MG7aWtztONdwBkPDU=;
 b=Y7RRGCHUidZvMgU35l2U8GM5lm74Owk7yabmDYDUcG3Eco8t+nAjClUc6Mbc0EWqt6
 NBcsDXAQZECzO3JFclaqJthxfoPmo8ADt5GavCjKX2JVYlRLlVDnu/iHFqMUCKyrovyd
 pCCDFih0vFGcwNWf42UA14+LStHdGhpAf0/AqbRetTvuK1cHlU5pDgRHQ+cZ4qJ2+h0p
 0SQ/3yUfJvkarmCzvwPWO3xiz0nTslk6rhx7mg5c+5wRKENZ9IyL7SzfGZFKvkoxG7d1
 5VT3bAJEMLPT7d5C/mbXVLOlATKqB8ihAAJ/320x51WEPmyKNLhTk2vv/cyp8jj1ED/Q
 jgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696950061; x=1697554861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K8LgCfYIFvr9WsP8VkZMmeGK++MG7aWtztONdwBkPDU=;
 b=HO4dANUwHlC82R+JWJYL81sZx5+OrtG2wJ7xOq0+IumgabaFbhdDKAYFQV0inKUlPQ
 L1UUbmQiLT4u+/WdhTx4RylE0oBOY8D3ys2B5MwxaTOnjGpe1yZvP17JB2u0VXun1vzv
 ZKa1cHteeDF3rHWFxl8TzinQWKhdCy6ypwhm6FyAciyq0a1NyTINM8waRRs/ITpfnoVC
 kQFOb3BDYqyj3CUheOOt5OdPpV7G3No8nBQD4mMp1Q+FN4rGfbrU5T5GH99NwcjFcwoI
 hDP+doZsGzRpFWtU9PlJZPppIU9h9nbvBH6mux76krQ75nIVY+SIZOxHv6Cja6C3Uuyk
 Pf2A==
X-Gm-Message-State: AOJu0YyfC+eXkDnLfNKLuPVN/PuJV81P3/cBFxGmXuI8JC0o3WRn4bKr
 3IcpUU7KXSC4Y8ro+Q23yyeSYgBYTZUf2tKFIil5Rg==
X-Google-Smtp-Source: AGHT+IECfRHOV5g/BJFDJzIT/ynDt+zZ7KDDYshNQ2AJbPWfGoetvrwmcroS6/m1x/8c+59AlxOm3rCOiYAi1brQPwI=
X-Received: by 2002:a05:6402:4405:b0:536:169a:4ac3 with SMTP id
 y5-20020a056402440500b00536169a4ac3mr14856840eda.8.1696950061576; Tue, 10 Oct
 2023 08:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-4-sughosh.ganu@linaro.org>
 <CAPnjgZ0_8FqJEarNvE6RN218PJWUGu1W0_f3iVjzBTibpQ1KFg@mail.gmail.com>
 <CADg8p97Xpc6MVs+oviNZ1NnKq4cvAuntb1HpO4K0PnJ7DULj9Q@mail.gmail.com>
 <CAPnjgZ0HocWeW9eNtXXjVPAyL1bu4YU=CE=iSKsXN5hg7u8Ysw@mail.gmail.com>
 <CADg8p97YLcGQk50aBwgpRnKc4GzM-rtY=2DzWZYGy9qx95r5hw@mail.gmail.com>
 <CAPnjgZ2z6Z4Y6FdspH3ap57B044s=BRr72vV8poG53VauP2_mw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2z6Z4Y6FdspH3ap57B044s=BRr72vV8poG53VauP2_mw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 10 Oct 2023 20:30:50 +0530
Message-ID: <CADg8p95dOdqtonZuOkcz_+xJByS=gPK+uSbjSEYF=jLbq8mvNA@mail.gmail.com>
Subject: Re: [PATCH 3/5] binman: capsule: Use dumped capsule header contents
 for verification
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

hi Simon,

On Tue, 10 Oct 2023 at 20:27, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 9 Oct 2023 at 13:41, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > hi Simon,
> >
> > On Mon, 9 Oct 2023 at 23:27, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Mon, 9 Oct 2023 at 01:46, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > hi Simon,
> > > >
> > > > On Sun, 8 Oct 2023 at 04:41, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > The various fields of a generated capsule are currently verified
> > > > > > through hard-coded offsets. Use the dump-capsule feature for dumping
> > > > > > the capsule header contents and use those for capsule verification.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > >  tools/binman/ftest.py | 95 ++++++++++++++++++++++++-------------------
> > > > > >  1 file changed, 54 insertions(+), 41 deletions(-)
> > > > >
> > > > > This looks good apart from a few nits below. However, the tests fail for me.
> > > >
> > > > Can you please specify which tests fail, and the way to reproduce the
> > > > failures? I ran the tests before sending the patches, and they ran
> > > > fine, including the coverage which is 100%. Ci too did not complain.
> > >
> > > Sure, for example:
> > >
> > > $ binman test testCapsuleGen
> > > ======================== Running binman tests ========================
> > > /usr/lib/python3.10/os.py:1030: RuntimeWarning: line buffering (buffering=1) isn't supported in binary mode, the default buffer size will be used
> > >   return io.open(fd, mode, buffering, encoding, *args, **kwargs)
> > > /usr/lib/python3.10/os.py:1030: RuntimeWarning: line buffering (buffering=1) isn't supported in binary mode, the default buffer size will be used
> > >   return io.open(fd, mode, buffering, encoding, *args, **kwargs)
> > > F
> > > ======================================================================
> > > FAIL: binman.ftest.TestFunctional.testCapsuleGen (subunit.RemotedTestCase)
> > > binman.ftest.TestFunctional.testCapsuleGen
> > > ----------------------------------------------------------------------
> > > testtools.testresult.real._StringException: Traceback (most recent call last):
> > > AssertionError: '6DCBD5ED-E82D-4C44-BDA1-7194199AD92A' != []
> > >
> > >
> > > ----------------------------------------------------------------------
> > > Ran 1 test in 0.147s
> > >
> > > FAILED (failures=1)
> >
> > That is interesting. When I run the tests, they run just fine. I had
> > tested them before sending the patches. For e.g.
> >
> > ./tools/binman/binman test testCapsuleGen
> > ======================== Running binman tests ========================
> > .
> > ----------------------------------------------------------------------
> > Ran 1 test in 0.375s
> >
> > OK
>
> Yes, I'm not sure what that is. Perhaps you have a required tool in your path? But in that case I would expect to get some sort of error.

I don't have any special tool in my path. Just that I build tools
before invoking the tests, since the mkeficapsule tool needs to have
been present. Moreover, the tests are also passing in the CI run. So
it seems to be something specific in your setup I guess.

-sughosh
