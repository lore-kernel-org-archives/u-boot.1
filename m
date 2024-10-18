Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4BAD30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C07891CE;
	Fri, 18 Oct 2024 16:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PUvNoHtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D8188C4D; Fri, 18 Oct 2024 16:55:14 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16134891DC
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbd1ae26a6so14204696d6.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263311; x=1729868111; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcBBBx31T903nO2GnfF77c/7TCvTYZzsvhHJMsf8DBw=;
 b=PUvNoHtgjGF5jspjeRjB2HHp/q+oQKxqX5erGSINDvfUAXelxK8m05JpuVUmAMox4Y
 OsLDEAy6z5wZyhI2AIS8+L7bExMJ9zW5G/k/vMU+oMXj0GCD+oEWKQMwX26bZbT3Xmmn
 /mx+Iw8ah5mAdeKF1emPygQgAbvm+ZllEIokA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263311; x=1729868111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YcBBBx31T903nO2GnfF77c/7TCvTYZzsvhHJMsf8DBw=;
 b=ekkabHdOwJQx91KM+gmZk3Uw9OadK0haCzx3rmUud8bGff3i4DlFWhWZ/pLpcyKQq5
 +B9uNxzgU601mVFg3ewFFYFZaHSEy625hVewxQA6H8iqPnBpvoBYDjXYMnItSEEsK2Y+
 qto8dtwj7MEQ8xYyIX/lqGiO2S9LsgjUKNvfoh9SJ83Eh2CfTQZwoFzDBHERSyAuRk0i
 Hf9u/3XP4VEsw1mRciX4OSDKEw6ep/utC+QJP+62RAGhK199qPSubXHJF6L0u7N+o/fz
 EYYVgbOxe1p2HnX1veogZgX6ZJKyXA/hxNK9GpP7wVdv3cbM4/ZEWAkx5/KZz9LuW8v4
 G5Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrFtI1JToaiQZy1xUxcxwtxQGvQ8Tsqo6SYBKGCIKP7Kw002brfd7A/YCSnRjpn/TT++yxo5g=@lists.denx.de
X-Gm-Message-State: AOJu0YyFCnkxHNiRfgBUAxtuzsHCppIbDcwLOE9m3ejJ3AhrJ6MGovF/
 UENPM5XHQA95g3lPJnTgcZ0KI0UnABwuoXZPmfk72cs3zOGy5OQUo9JSshOcbh4jTt5wyHFf+dt
 uYqB2EKFnxyLo/COh5dsA0cwlexIpeXj6S1+6NK/7sRt5tE8=
X-Google-Smtp-Source: AGHT+IHAjasBODsTawns5fPPoNs7EPlQDR6kTf746X/7yla6WxRll0fZiOUyzaNPhNKOh2S1NBFhBW/TGrEhSQdc/8U=
X-Received: by 2002:a05:6214:3bc6:b0:6cb:f87f:f2da with SMTP id
 6a1803df08f44-6cde1539b3dmr48913916d6.26.1729263310997; Fri, 18 Oct 2024
 07:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThN1GbLJerc_4GST7iLORCK1E+jLR9kBRhpXGak_f-q2Q@mail.gmail.com>
 <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-4-andriy.shevchenko@linux.intel.com>
 <CAFLszTjff52keqouqR3WK=cM=PX+EiTJQqz+YWBbDe3dSTYY8g@mail.gmail.com>
 <ZwaOPy9NTV4PmY5E@black.fi.intel.com>
 <CAFLszTiL8uA7tRkeK3+KTnVD1uTs32cx0kMWfamZBhd5LoBQdQ@mail.gmail.com>
 <ZxJJ6tXYV7tEPfy3@smile.fi.intel.com>
In-Reply-To: <ZxJJ6tXYV7tEPfy3@smile.fi.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:55:00 -0600
Message-ID: <CAFLszTjPNafOL+Qmbq8JCjJ0tY7GiC-1TycVZZxy+6aY4pZLNQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] x86: cpu: Add a few prototypes to the header file
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>
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

Hi Andy,

On Fri, 18 Oct 2024 at 05:43, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 17, 2024 at 04:11:48PM -0700, Simon Glass wrote:
> > On Wed, 9 Oct 2024 at 08:08, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Oct 08, 2024 at 07:55:33PM -0600, Simon Glass wrote:
> > > > On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > The compiler is not happy to have no prototypes for the functions=
 that
> > > > > are not defined static. Add them. This helps avoiding the compile=
r warnings:
> > > > >
> > > > >   arch/x86/cpu/cpu.c:197:13: warning: no previous prototype for =
=E2=80=98board_final_init=E2=80=99 [-Wmissing-prototypes]
> > > > >   arch/x86/cpu/cpu.c:205:13: warning: no previous prototype for =
=E2=80=98board_final_cleanup=E2=80=99 [-Wmissing-prototypes]
> > > > >   arch/x86/cpu/cpu.c:307:5: warning: no previous prototype for =
=E2=80=98reserve_arch=E2=80=99 [-Wmissing-prototypes]
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > Thanks!
> > >
> > > > OK, but could you add proper comments for these?
> > >
> > > Any proposed texts for them? The comments were out of scope of my pat=
ch,
> > > but I may add anything that is provided as a template.
> >
> > I found some comments in one of the files, so you could use these as a
> > base. Whenever you change code, you should make sure it has function
> > comments, follows style, etc. That way things slowly get better.
> >
> > /*
> >  * Implement a weak default function for boards that need to do some fi=
nal init
> >  * before the system is ready.
> >  */
> > __weak void board_final_init(void)
> > {
> > }
> >
> > /*
> >  * Implement a weak default function for boards that need to do some fi=
nal
> >  * processing before booting the OS.
> >  */
> > __weak void board_final_cleanup(void)
> > {
> > }
> >
> > Applied to u-boot-dm, thanks!
>
> Thanks, but what does it mean to me? Should I send an update to add the c=
omments?

Yes, please. I'm just tidying up some x86 patches while Bin is away.

Regards,
Simon
