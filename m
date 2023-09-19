Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC85CD5492
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C1F86ACA;
	Tue, 19 Sep 2023 09:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BTTDnkJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D8586AD8; Tue, 19 Sep 2023 09:46:27 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE8B08603A
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bcb50e194dso84642511fa.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695109585; x=1695714385; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLLNwwYWrxBP5fqwkWTk/4T6CgfKiVUrj8bh9+2dh1c=;
 b=BTTDnkJ3Yu6ohsC93I0R+zREuAuOuXfxTBe31xW75zmz0J/+smW02wAwvIbImfBr3I
 Q40+WqRrLno0niJuAz0X3SY9jgrg5ID3yLRN3C7wF9vB5gp3FYgdZSqzX02Iwy/gVfJR
 Lzwa1QO9fHP0XRxOdOrXtUBq/qM5yc4M31jzvgt08+1TFGV4xIp0xFQZcc9XsZDvirgF
 0JMwaNnaNKr3TQl+3RUNo6zF+C9L2pXuhB0o8uNCS0+BS75F2R6O747yPh6PaAcIoInU
 VPv44Hs+/yk6JwAUQE/RQwtEMyv0gV/IHEom2eBPjAStpl5tOPnIqEXKopr9JNdAiMxn
 WhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695109585; x=1695714385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLLNwwYWrxBP5fqwkWTk/4T6CgfKiVUrj8bh9+2dh1c=;
 b=gySRTZ8SPu7bgGzfoKE80Whwt6DyvAFB+xpFLicEl+4D/a+IoUP5t1RYVfZSaW8ySN
 J4yM2QIZLUwZcBI9G5WyhSmnV2wCW05DPAknVd/qt0/OaX2Rw2YktCA7E10XebjZPS5W
 Oi0TFW0g4+N2cFRbuuVtebNqll/fBCa1DY5QNyIQzD873P6t2IdSy1TAwbuwt1eg3f98
 F9V2iq0EXplVhCS0uglJ+Nz6lDWJY7GbMnsYFhGVChxf2RzNo14drskuKh89OPPhrkv1
 LC5fg+aU1GCtGUttetv/TbaiyBXHLPfjMy3EFB6ySvJd7fpLFyZ7EodH+gk9REsYUVlF
 Df5w==
X-Gm-Message-State: AOJu0YyTNf38vef1ayaoxae59a1gEYsxbDWVwCpDXYD2nM0fErqATWN0
 1a9PMB2OimCv4sPFFutuSt+z5hg1F4IVLiRRVq4=
X-Google-Smtp-Source: AGHT+IGFi81j7pafZZpeVwPwkcBFnzghLnq1oLmfPvjr4ZfYXMS5Pe6cxYX+T/iLGD333f4hoybLKIhLGrijFkTgGx4=
X-Received: by 2002:a2e:8855:0:b0:2bf:ff53:556e with SMTP id
 z21-20020a2e8855000000b002bfff53556emr5721161ljj.23.1695109584892; Tue, 19
 Sep 2023 00:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230831112051.1.I3fe7ac62de70902fd1be093bcda7c53acd43daf8@changeid>
 <20230831174805.GM3101304@bill-the-cat>
 <CAPnjgZ2q=EjqnguGakVjtr-5d=tQEgrk8UXF+9kc-h6cLJbKiw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2q=EjqnguGakVjtr-5d=tQEgrk8UXF+9kc-h6cLJbKiw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:46:13 +0800
Message-ID: <CAEUhbmWa-ofA+M6SGpd1ZmBfUDiq9ZCqByjqH2nK1A0UYvx8jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Allow Python packages to be dropped
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mike Frysinger <vapier@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Sep 1, 2023 at 3:13=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Tom,
>
> On Thu, 31 Aug 2023 at 11:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 31, 2023 at 11:20:52AM -0600, Simon Glass wrote:
> >
> > > When building in a portage chroot, we do not have the environment nee=
ded
> > > to build pylibfdt. It is instead build as a separate package.
> > >
> > > Provide a build option to tell U-Boot to skip this part of the build.=
 We
> > > still need it to use binman, etc. but don't need it to build its
> > > dependencies.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Reviewed-by: Mike Frysinger <vapier@chromium.org>
> > > ---
> > >
> > >  Makefile             | 8 ++++++++
> >
> > Can we do this via Kconfig instead? It looks like we don't need to do
> > this part of the build for coreboot, yes?  And so if we can drop it fro=
m
> > other builds as well that might help speed up CI.
>
> Yes it could. But I really don't like changing the board config on the
> fly - we have things like 'select BINMAN' now and it just gets messy.
> In the normal course of events we want to build the python things and
> the build won't work without it (e.g. binman will fail). But where the
> build environment has installed binman separate, it knows better.
>
> So I don't think this is a board config thing,
>
> >
> > [snip]
> > > +The tools-only build bytes pylibfdt by default. To disable this, use=
 the
> >
> > "build bytes" should probably be "builds" I suspect.
>
> Yes, thanks.
>

Corrected "build bytes" to "builds bytes", and

series applied to u-boot-x86/next, thanks!

Regards,
Bin
