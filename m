Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774F7CD8CA4
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 15:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5663C86B1D;
	Tue, 10 Oct 2023 17:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AmSyxH6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9986F86BAC; Tue, 10 Oct 2023 17:15:12 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C559280834
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 17:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5333fb34be3so9815438a12.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696950907; x=1697555707; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Xe7UQCfvkQfbpgGoi7fQQw25hy2I2MRYk82Ii0g/bc=;
 b=AmSyxH6l/RWq+JlO7IyK6PHvLgp+FuVHxRKIb1+RpPQtVfTCVwCgHS9TSCzVDApD1E
 EtjHcUPuQs+Z9H+CzeF9J7mGSkX58AfbDXXzTIgcS+MZonzB8mZy9VaeD7rvsHI8yevL
 S+X4gYgdyShPo9EON36w4vKp1S7uVyfLCoZ7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696950907; x=1697555707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Xe7UQCfvkQfbpgGoi7fQQw25hy2I2MRYk82Ii0g/bc=;
 b=XT2AKiKglRfVq0Rfaa2Q2AkM9pmu7P2lhEpTF4FvETvxIrnrframWdGkWqHCq1Dh+8
 dNW7sWNFne/INQ9/IknnSbMjjJHhjycSfHWWgjFXbUBXx9aWNkJB1EQ0hXaysZsuBXYd
 IdQCsBmF1bdwIclbkneBwODv7KFddnWgWra/14YH8aI/LwjEP+cvEgMXqBz9/h+nQ8yY
 EURYk6SzkFYc4P25p5OnJh9dDKKxcPIzx8ecG6BtXSWXk0v1fBZmPv1O2dksHPgHzkUM
 qcn2aQFwPDwGAiK8t7PhnZvScCdUsWKzTju1qyuI+upaWghDYplenw+/ixKR8NNTJRn2
 MaQg==
X-Gm-Message-State: AOJu0Yxqod9Nprl3R5Kk5GdWPu97v2k18/C6cKR7KViHLAHB8Ybo4YMA
 fx5GOZnpVctO9R3WT6vM7LFb2+GHaXCZEyITSgBDqw==
X-Google-Smtp-Source: AGHT+IFgYIJQzzsoSWUnp3Y5WKcCBK4HthMt6zHHQH/lZFmpNLcwbadcjc68NnQMVrrP2WcRsa/CbJY0Io1Ky3RhcH0=
X-Received: by 2002:a17:906:10d4:b0:9ae:375f:bf00 with SMTP id
 v20-20020a17090610d400b009ae375fbf00mr15505856ejv.62.1696950907050; Tue, 10
 Oct 2023 08:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-4-sughosh.ganu@linaro.org>
 <CAPnjgZ0_8FqJEarNvE6RN218PJWUGu1W0_f3iVjzBTibpQ1KFg@mail.gmail.com>
 <CADg8p97Xpc6MVs+oviNZ1NnKq4cvAuntb1HpO4K0PnJ7DULj9Q@mail.gmail.com>
 <CAPnjgZ0HocWeW9eNtXXjVPAyL1bu4YU=CE=iSKsXN5hg7u8Ysw@mail.gmail.com>
 <CADg8p97YLcGQk50aBwgpRnKc4GzM-rtY=2DzWZYGy9qx95r5hw@mail.gmail.com>
 <CAPnjgZ2z6Z4Y6FdspH3ap57B044s=BRr72vV8poG53VauP2_mw@mail.gmail.com>
 <CADg8p95dOdqtonZuOkcz_+xJByS=gPK+uSbjSEYF=jLbq8mvNA@mail.gmail.com>
In-Reply-To: <CADg8p95dOdqtonZuOkcz_+xJByS=gPK+uSbjSEYF=jLbq8mvNA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Oct 2023 09:14:55 -0600
Message-ID: <CAPnjgZ3vo2hENdhqsHZoiLkdeSv-oc80P2L9Jq=0Qo9dkd+rbQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] binman: capsule: Use dumped capsule header contents
 for verification
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Tue, 10 Oct 2023 at 09:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Tue, 10 Oct 2023 at 20:27, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Mon, 9 Oct 2023 at 13:41, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > hi Simon,
> > >
> > > On Mon, 9 Oct 2023 at 23:27, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Mon, 9 Oct 2023 at 01:46, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > hi Simon,
> > > > >
> > > > > On Sun, 8 Oct 2023 at 04:41, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Sughosh,
> > > > > >
> > > > > > On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > >
> > > > > > > The various fields of a generated capsule are currently verified
> > > > > > > through hard-coded offsets. Use the dump-capsule feature for dumping
> > > > > > > the capsule header contents and use those for capsule verification.
> > > > > > >
> > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > ---
> > > > > > >  tools/binman/ftest.py | 95 ++++++++++++++++++++++++-------------------
> > > > > > >  1 file changed, 54 insertions(+), 41 deletions(-)
> > > > > >
> > > > > > This looks good apart from a few nits below. However, the tests fail for me.
> > > > >
> > > > > Can you please specify which tests fail, and the way to reproduce the
> > > > > failures? I ran the tests before sending the patches, and they ran
> > > > > fine, including the coverage which is 100%. Ci too did not complain.
> > > >
> > > > Sure, for example:
> > > >
> > > > $ binman test testCapsuleGen
> > > > ======================== Running binman tests ========================
> > > > /usr/lib/python3.10/os.py:1030: RuntimeWarning: line buffering (buffering=1) isn't supported in binary mode, the default buffer size will be used
> > > >   return io.open(fd, mode, buffering, encoding, *args, **kwargs)
> > > > /usr/lib/python3.10/os.py:1030: RuntimeWarning: line buffering (buffering=1) isn't supported in binary mode, the default buffer size will be used
> > > >   return io.open(fd, mode, buffering, encoding, *args, **kwargs)
> > > > F
> > > > ======================================================================
> > > > FAIL: binman.ftest.TestFunctional.testCapsuleGen (subunit.RemotedTestCase)
> > > > binman.ftest.TestFunctional.testCapsuleGen
> > > > ----------------------------------------------------------------------
> > > > testtools.testresult.real._StringException: Traceback (most recent call last):
> > > > AssertionError: '6DCBD5ED-E82D-4C44-BDA1-7194199AD92A' != []
> > > >
> > > >
> > > > ----------------------------------------------------------------------
> > > > Ran 1 test in 0.147s
> > > >
> > > > FAILED (failures=1)
> > >
> > > That is interesting. When I run the tests, they run just fine. I had
> > > tested them before sending the patches. For e.g.
> > >
> > > ./tools/binman/binman test testCapsuleGen
> > > ======================== Running binman tests ========================
> > > .
> > > ----------------------------------------------------------------------
> > > Ran 1 test in 0.375s
> > >
> > > OK
> >
> > Yes, I'm not sure what that is. Perhaps you have a required tool in your path? But in that case I would expect to get some sort of error.
>
> I don't have any special tool in my path. Just that I build tools
> before invoking the tests, since the mkeficapsule tool needs to have
> been present. Moreover, the tests are also passing in the CI run. So
> it seems to be something specific in your setup I guess.
>

Yes, I suppose so...I'll try the new version and try to figure it out.

Regards,
Simon
