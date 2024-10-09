Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3AFCEE350
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 21:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13ABC88D8D;
	Wed,  9 Oct 2024 23:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e84iMb9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 136F288C98; Wed,  9 Oct 2024 23:14:15 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD4F88CAE
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 23:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbbe3f6931so2315516d6.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728508452; x=1729113252; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRjDGTeDFom6zJdZM/0NtXZT5MteViaXfsPYstgQwts=;
 b=e84iMb9IL9aNhW1vaqwYXEGexjEo/sAxlz+Gug9ttlF8cNq6W/OYANRvBpSvWQfodn
 eMp+xv70UzP7vygkSy8s5iDC52XIO7bUUK2L0D3hL5g4PysFso0Jr4p2BsQqEqZURy+x
 6IFbqIdjOq6IJYEa+WuQ6TWgNmWh8MGwcja+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728508452; x=1729113252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRjDGTeDFom6zJdZM/0NtXZT5MteViaXfsPYstgQwts=;
 b=LxxrZIRcGYetVHAcWf+H3t8LqQKjRvn3ht9Qa8zcgO/VZtHr8XySawaBuUF3leAOfY
 FGTWH/03HR9y9OrVw0sc2eu9qLvXMpLCUaFScaUItarn4hVZftzGSQwc7IpEcnslA2H3
 2/AZ5Qq1vtcPdn/9FzKBlNNe0cSi6Ra61MNYJn/E+vG98m73aiPYsQGWr/a0axTDvy86
 T2dhglZk5mBjOCQV8UwETwGzq6cnkgiyJy9iBbpVIZwbklIGcHQO20o8NSCjQsKmCZ00
 2ZSU2t4TLN8ys64lJT4qaa0ea6SvQFWmRWJCNXgBXTHVD6/XQAn6Wduwpx1VmLTCRci7
 QOJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkI0juRxQRO8M8W+fa/AZaZ5lvpJfeuXJ15Ufy+RG2JHOJUbRO547iqfOQpxNFXlj2S/CncTE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx34kB+QuwbdrPKrmUiqsnUSISeSQojoT8KriXPRugHrKDBWuL8
 ii87QwEh8TYiLxxcApAnMkb+Y/krcpkvCOOPC2JGh10M+s6/t7mSqGupXOBzAbFWuDacdlLqXsx
 jrBbDRzlls+xnlRDk3vE0Hddd0YHbDNbLOIHc
X-Google-Smtp-Source: AGHT+IGKJArfi72/mTQU8PMoPHEjhm3/2XKkacZEG9+QgWP9SwJUkGn2lYOrSoHZBtvvaAYzW1WqtTXrP4FiHlJua1c=
X-Received: by 2002:a05:6214:4387:b0:6cb:4e11:d9b9 with SMTP id
 6a1803df08f44-6cbc955e7c7mr57750966d6.35.1728508451948; Wed, 09 Oct 2024
 14:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-2-andriy.shevchenko@linux.intel.com>
 <CAFLszTivZ-2fExaAkkc+gK3tq5dYwf4uxUXjkj2dhpkpopJKqw@mail.gmail.com>
 <ZwaN8GRyySFaMJm1@black.fi.intel.com>
In-Reply-To: <ZwaN8GRyySFaMJm1@black.fi.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Oct 2024 15:14:01 -0600
Message-ID: <CAFLszTjsQO6eW0CJCB12X-2pEj_N3UKudcZ9KRkdXBFzF3O8jQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] x86: cpu: Use default print_cpuinfo() for all
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

On Wed, 9 Oct 2024 at 08:06, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 08, 2024 at 07:56:43PM -0600, Simon Glass wrote:
> > On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Most of the copies of the print_cpuinfo() call the default method.
> > > Remove all of those in order to have only the default one when
> > > no `cpu` command is compiled.
> > >
> > > This also helps avoiding compiler warning, e.g.:
> > >
> > >   arch/x86/cpu/tangier/tangier.c:23:5: warning: no previous prototype=
 for =E2=80=98print_cpuinfo=E2=80=99 [-Wmissing-prototypes]
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  arch/x86/cpu/broadwell/cpu.c                 | 12 ------------
> > >  arch/x86/cpu/coreboot/coreboot.c             |  5 -----
> > >  arch/x86/cpu/cpu.c                           |  6 +++++-
> > >  arch/x86/cpu/efi/app.c                       |  5 -----
> > >  arch/x86/cpu/efi/payload.c                   |  5 -----
> > >  arch/x86/cpu/ivybridge/cpu.c                 | 14 --------------
> > >  arch/x86/cpu/qemu/qemu.c                     |  6 ------
> > >  arch/x86/cpu/quark/quark.c                   |  6 ------
> > >  arch/x86/cpu/slimbootloader/slimbootloader.c |  5 -----
> > >  arch/x86/cpu/tangier/tangier.c               |  5 -----
> > >  arch/x86/cpu/x86_64/misc.c                   |  5 -----
> > >  arch/x86/include/asm/u-boot-x86.h            |  1 -
> > >  arch/x86/lib/fsp/fsp_common.c                |  6 ------
> > >  13 files changed, 5 insertions(+), 76 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Thanks!
>
> > BTW, this function is deprecated...since with CONFIG_CPU it is shown
> > by the CPU driver.
>
> Is it docemented somewhere? In any case this patch I think is good on
> its own as it drastically reduces the possible churn in the future.

Documentation for uclasses is generally in the code. But there is
nothing much here. In this case the code is print_cpuinfo() in
board_f.c

Regards,
Simon
