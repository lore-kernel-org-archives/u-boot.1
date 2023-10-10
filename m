Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142E4CD8C99
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF5285DEA;
	Tue, 10 Oct 2023 16:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I4N2BkIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31C186604; Tue, 10 Oct 2023 16:57:37 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89AE82BBF
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so983984666b.3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696949855; x=1697554655; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OiL7FFIOD3ezaN9KHiv/IaGgYD5flYccB3kviqT3CPI=;
 b=I4N2BkIEVSmPvYzOq4kfoS2oHOh0bb6lsk00sJCdoPi7RkFKnZv2niJUpAklMJRcJn
 yIbZflqgEAtCbKkKOA1fvwFRIdyq89e+lLDZzPuxJ7ZF7e4EhOu5a8xp2Jf23uLxCjQF
 HPtr28neTpzJTxQTGSxmi6YLUFBl1BP4csMVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696949855; x=1697554655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OiL7FFIOD3ezaN9KHiv/IaGgYD5flYccB3kviqT3CPI=;
 b=CFsD9aj8O0tan1NoHq+gsPqSYS3b4/6Xf4W6BwjtvAAkC/h+NjdyfzhErM6DuNzmji
 K8j8BDtFeVtirDXvkHvpcwuvl4XjAykOhK7rsqI2PyX6uZzYACeu1qJ3wY2ghifAHzon
 1xYbFgOTl6VHqT6PGjfFqsoVpsDYUB4XbSN216oagh/za0FLa7ERwO5hFT8x1+rFb2NQ
 CZX3f5rwD6ifLUz1d9D2Mth7NSuWsGz/+/HFkxZaC/inkZwvYNhhIpQLjtbjaB4RgiiT
 SdixqZUFM75I3JweYVSmYdM9eul40x3+imY/T/g5JH2gCheUoL8ulPCPJ7G9yLewqrS3
 XxSw==
X-Gm-Message-State: AOJu0Yzsc97DkNm7lFRZHWYkrsJM31Nyh/c/HbWMTuwtc8c4h7Zp+DDK
 wUwsbLPxk8dQVXmKaZXiJESVjHs0LVMgR/ljxaSkVg==
X-Google-Smtp-Source: AGHT+IEKgEEksO42ybWryvM1PRRxQUt8WI7m1DFHj27RXFJLbxVdgLZl4Mm3tv/BTTxims2KUY6/EyvGLkIy6HPEgVY=
X-Received: by 2002:a17:907:7897:b0:9ae:3c6c:6ecd with SMTP id
 ku23-20020a170907789700b009ae3c6c6ecdmr17519051ejc.19.1696949854946; Tue, 10
 Oct 2023 07:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-4-sughosh.ganu@linaro.org>
 <CAPnjgZ0_8FqJEarNvE6RN218PJWUGu1W0_f3iVjzBTibpQ1KFg@mail.gmail.com>
 <CADg8p97Xpc6MVs+oviNZ1NnKq4cvAuntb1HpO4K0PnJ7DULj9Q@mail.gmail.com>
 <CAPnjgZ0HocWeW9eNtXXjVPAyL1bu4YU=CE=iSKsXN5hg7u8Ysw@mail.gmail.com>
 <CADg8p97YLcGQk50aBwgpRnKc4GzM-rtY=2DzWZYGy9qx95r5hw@mail.gmail.com>
In-Reply-To: <CADg8p97YLcGQk50aBwgpRnKc4GzM-rtY=2DzWZYGy9qx95r5hw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Oct 2023 08:57:23 -0600
Message-ID: <CAPnjgZ2z6Z4Y6FdspH3ap57B044s=BRr72vV8poG53VauP2_mw@mail.gmail.com>
Subject: Re: [PATCH 3/5] binman: capsule: Use dumped capsule header contents
 for verification
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Sughosh,

On Mon, 9 Oct 2023 at 13:41, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Mon, 9 Oct 2023 at 23:27, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Mon, 9 Oct 2023 at 01:46, Sughosh Ganu <sughosh.ganu@linaro.org>
wrote:
> > >
> > > hi Simon,
> > >
> > > On Sun, 8 Oct 2023 at 04:41, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org>
wrote:
> > > > >
> > > > > The various fields of a generated capsule are currently verified
> > > > > through hard-coded offsets. Use the dump-capsule feature for
dumping
> > > > > the capsule header contents and use those for capsule
verification.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > >  tools/binman/ftest.py | 95
++++++++++++++++++++++++-------------------
> > > > >  1 file changed, 54 insertions(+), 41 deletions(-)
> > > >
> > > > This looks good apart from a few nits below. However, the tests
fail for me.
> > >
> > > Can you please specify which tests fail, and the way to reproduce the
> > > failures? I ran the tests before sending the patches, and they ran
> > > fine, including the coverage which is 100%. Ci too did not complain.
> >
> > Sure, for example:
> >
> > $ binman test testCapsuleGen
> > ======================== Running binman tests ========================
> > /usr/lib/python3.10/os.py:1030: RuntimeWarning: line buffering
(buffering=1) isn't supported in binary mode, the default buffer size will
be used
> >   return io.open(fd, mode, buffering, encoding, *args, **kwargs)
> > /usr/lib/python3.10/os.py:1030: RuntimeWarning: line buffering
(buffering=1) isn't supported in binary mode, the default buffer size will
be used
> >   return io.open(fd, mode, buffering, encoding, *args, **kwargs)
> > F
> > ======================================================================
> > FAIL: binman.ftest.TestFunctional.testCapsuleGen
(subunit.RemotedTestCase)
> > binman.ftest.TestFunctional.testCapsuleGen
> > ----------------------------------------------------------------------
> > testtools.testresult.real._StringException: Traceback (most recent call
last):
> > AssertionError: '6DCBD5ED-E82D-4C44-BDA1-7194199AD92A' != []
> >
> >
> > ----------------------------------------------------------------------
> > Ran 1 test in 0.147s
> >
> > FAILED (failures=1)
>
> That is interesting. When I run the tests, they run just fine. I had
> tested them before sending the patches. For e.g.
>
> ./tools/binman/binman test testCapsuleGen
> ======================== Running binman tests ========================
> .
> ----------------------------------------------------------------------
> Ran 1 test in 0.375s
>
> OK

Yes, I'm not sure what that is. Perhaps you have a required tool in your
path? But in that case I would expect to get some sort of error.

[..]

Regards,
Simon
