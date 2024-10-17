Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D4FD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3869D890E9;
	Fri, 18 Oct 2024 01:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tp9azLmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E598914F; Fri, 18 Oct 2024 01:11:56 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25677890F8
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cbd00dd21cso8463906d6.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206712; x=1729811512; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hr03DqarslHGGcbvLurFvMlPbWOGKpQdKAUSK3YMhxY=;
 b=Tp9azLmDMsTpIz8rRByIj7rbCMolyRk0oQlnUwstIUifxe12UIqOtNbS5Unrj+WxR9
 eGFyUfHvCJdsIQxpjDP+juxcsDKYYJuXiGPb9lyStClJqZiQg+6E1G109wGi4NZ+z0TY
 jGXZmegj4uH5sf5cGXEijk4awFfAApzq9zuhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206712; x=1729811512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hr03DqarslHGGcbvLurFvMlPbWOGKpQdKAUSK3YMhxY=;
 b=sggSDkeZeTgT2V9wFtxWQyt+V1/SZFZuXKICTiwNgiROEAc5dEJPdTkAiLzbe9w4r8
 zF++Fznk043nJBNVeak0K2tPx8sDg1SDGJ7gcMgIgErmZaUztvwsNn+kmYZYLq7U+JCM
 xy5YpLm4EaFGugx99Ug4BN60zEp5uh7rIlAPqyi0t4UYe6vdSi1CghGMPtCVTK68zZKu
 C1Op1zr0alXPzGnleDZaYlN2cK5/f6CAhDRP0Qd0/zJxzxxm7Njtw5seT/bP6Ky4XoeU
 vqIB9HjAFZnAj2xcJshYrda91qfI/X8jsR5aWQolSkNyQAjWLR3Bj8pDfb6Q65+ShIZW
 M6Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrn40PbLO3D2JoBPmhV/++tT7E7xzh1LBRXbSkQVusphmYca6gpgukKGTD4TMcTZrUJIJG1HQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwiEAthW/BtwL8AbQTvKCgVAgoj96h8WQDNMCtMXlEkRlyRK2+d
 6UhyGgfA8pStZKYUI/cso+YYN6l4/XIUnEMAYE1ncXvtHjbur2d3wgakEXjmMDm4Iu2JLIrRbAx
 WBxc7paNfJ7VW4ceQPGSOiHXo9eKTxSR84tgw0hccXabXrlk=
X-Google-Smtp-Source: AGHT+IF8fruQE/tqJ0WlTo9/j9YbZid05KTWLLQU1dWQH7jnhJlcDG4Fd9Xrw4a9mWmO+vM/dRnLn2xh1cwGEYGwAao=
X-Received: by 2002:a05:6214:3104:b0:6cc:376f:f3af with SMTP id
 6a1803df08f44-6cde164b152mr4540736d6.50.1729206711834; Thu, 17 Oct 2024
 16:11:51 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:51 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTjsQO6eW0CJCB12X-2pEj_N3UKudcZ9KRkdXBFzF3O8jQ@mail.gmail.com>
References: <CAFLszTjsQO6eW0CJCB12X-2pEj_N3UKudcZ9KRkdXBFzF3O8jQ@mail.gmail.com>
 <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-2-andriy.shevchenko@linux.intel.com>
 <CAFLszTivZ-2fExaAkkc+gK3tq5dYwf4uxUXjkj2dhpkpopJKqw@mail.gmail.com>
 <ZwaN8GRyySFaMJm1@black.fi.intel.com>
Date: Thu, 17 Oct 2024 16:11:51 -0700
X-Google-Sender-Auth: vBRR5Qn2iejhBpty25YcvClaszg
Message-ID: <CAFLszTiOMgnB_sdZz2JM3AOQb4ZkcTYX-4fjAu7LpmiKL4sOTQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] x86: cpu: Use default print_cpuinfo() for all
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Applied to u-boot-dm, thanks!
