Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132ACC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 16:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58854878ED;
	Sat, 22 Jun 2024 18:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uqCOvzlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07083879AF; Sat, 22 Jun 2024 18:58:12 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88BC487873
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 18:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-706738c209bso90982b3a.3
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719075488; x=1719680288; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SBApqmpt0SR+bPsx/U1JA70j9RRiFVcPmC7A1aiPhY4=;
 b=uqCOvzlKAgbQfVrlWlhwTVPZ0tlNgIQRFHBcfd7gPNNo/RTIBmiAfztOzj/saz9xov
 X2xZgHQH/lYJdcJoBEMcprNo6ybI0AsnzhuBtpWpbtfwkR9ywUxe1mOU2VwuB72X5yI9
 MWuCZn3GxaiOJW9ObcoHIS7+J5BaiDRy9F0KOEdUA8GKCHoPisnOtS67EPYxbynH8CfL
 teMNhFHclOayQGyyqY+pNRoXHQ3U+aAMel5A2x6ZCunMFhFwZMVkgrr+D+Q+YfjjXZIz
 QSh7WOPcktMPMATYHVlEVDFN0Pfrb0QYU0BYxarVPUsOIJkNWjJNfaaheyCFFje7pVcZ
 2Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719075488; x=1719680288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SBApqmpt0SR+bPsx/U1JA70j9RRiFVcPmC7A1aiPhY4=;
 b=HNFDcDX8ZPbrZ1smZ1Qz57CBfeqGTRH6MAhWRgNDXTsQkLRdbynTOlGfPIh+eoEHr1
 yeG8lnI/HXIPfQQ5N/4YGYdPiAH3Z09NoqRBo22OHO6q3XfGhZyxGdlpNvJ5uG1OCF7M
 DJHWPC4n8EvQoi/OrUJh7jgRLZwuLLJX57ScJGgKRlMSy8UajAaaNtfStzgwuMpm08BA
 7s7TQNMzjwlgMkEZhmAUmRP7JsXRzOj/nwkeFtOYriWPPqxi12YjCWnt/lWO+fT5Oq0h
 uS8zY4uxTRHvIDajE0rHxqKBi8PH49Jg2yCftpp7TlYfbAoKbcXOC9RxUbONqcSbGBCL
 TRDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8RlIs1c1t26wRap+tlgp4wFiPG4t+nrwDoZPtXOJB9Yd+yN6vb3Jy43c92UY9HNJdycnPOHfdYexETJiz28M4u3lJ2g==
X-Gm-Message-State: AOJu0Yx0+3kN6GjjIEdOvujY1XhZylGbL6ZUknSof89MrkbUWM9SApMz
 kBywXWjifD7XFdVDFh7LkGTsLUXAWiUMICB0/9cmX50lS/GlBl6n5kZcWkSqEzZpYjaiDI62ftd
 HoBgutmPL1OToJLAlTiVyrF1IO/5exDLCN/eKzQ==
X-Google-Smtp-Source: AGHT+IEWX+gGaYMo35St7YUzmYToUycWpcfSON6Oy9cfTj6+rApdKnMJzp1sv9830I23CN0GLrLA1l/9OWtHuuCrH1U=
X-Received: by 2002:a05:6a20:c512:b0:1b7:cc4e:eb6 with SMTP id
 adf61e73a8af0-1bcf7e366a7mr255150637.8.1719075487658; Sat, 22 Jun 2024
 09:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-5-ilias.apalodimas@linaro.org>
 <02965f5b-d824-48ee-a2dc-f4e5883ef26e@gmx.de>
 <CAC_iWjLo6fA4vUPunU1tfbShesmHp7F0bMJm-O=CXteOJBsjgQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLo6fA4vUPunU1tfbShesmHp7F0bMJm-O=CXteOJBsjgQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 22 Jun 2024 19:57:31 +0300
Message-ID: <CAC_iWj+QFpNcDeThwR6WnMQ-g+vfDYnAphoHDQsiwkB3NQkGSw@mail.gmail.com>
Subject: Re: [PATCH 4/7] tpm: Move TCG into a separate library
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

On Sat, 22 Jun 2024 at 19:36, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi
>
> again many thanks for the quick review
>
> On Sat, 22 Jun 2024 at 19:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 22.06.24 16:35, Ilias Apalodimas wrote:
> > > commit 97707f12fdab ("tpm: Support boot measurements") moved out code
> > > from the EFI subsystem into the TPM one to support measurements when
> > > booting with !EFI.
> > >
> > > Those were moved directly into the TPM subsystem and in the tpm-v2.c
> > > library. In hindsight, it would have been better to move it in new
> > > files since the TCG2 is governed by its own spec and it's cleaner
> > > when we want to enable certian parts of the TPM functionality.
> >
> > Nits:
> >
> > %s/certian/certain/
> >
> > >
> > > So let's create a header file and another library and move the TCG
> > > specific bits there.
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >   boot/bootm.c       |   1 +
> > >   include/efi_tcg2.h |   1 +
> > >   include/tpm-v2.h   | 474 +++++-------------------------
> > >   include/tpm_tcg2.h | 336 ++++++++++++++++++++++
> > >   lib/Makefile       |   2 +
> > >   lib/tpm-v2.c       | 676 +------------------------------------------
> > >   lib/tpm_tcg2.c     | 696 +++++++++++++++++++++++++++++++++++++++++++++
> >
> > The patch series were easier to review if moving header definitions were
> > separated from moving implementations.

So, I can't do that because I'll need an intermediate commit to
include tpm_tcg2.h to tpm-v2.h which I'd rather avoid.

I can make the diff smaller though. Are you ok with that ?

Thanks
/Ilias
> >
> > This patch contains changes that are not described in the commit
> > message, e.g.
> >
> >                 if (elog->log_size) {
> >                         if (log.found) {
> >                                 if (elog->log_size < log.log_position)
> > -                                      return -ENOBUFS;
> > +                                      return -ENOSPC;
>
> And this is a great catch. this changed in patch#1 and the correct
> return is -ENOBUFS. I started working on 2 trees and obviously messed
> up this rebase... Thanks!
>
> >
> > I guess you wanted to put this into patch 1.
> >
> > Please, separate the patches adequately.
>
> Fair enough. I thought it was going to be hard not breaking
> compilation hence the big patch. I'll try splitting it
>
> >
> > + * Copyright (c) 2020 Linaro
> > + * Copyright (c) 2023 Linaro Limited
> >
> > The copyright lines look inconsistent. Linaro Limited exists under this
> > name since April 13th, 2010. Is the 2020 copyright for a different company?
> >
>
> I'll keep the older one, same company
>
> [...]
>
> > > +}
> > > +
> > > +__weak void tcg2_platform_startup_error(struct udevice *dev, int rc) {}
> > > +
> >
> > git warning: "new blank line at EOF".
> >
> > Otherwise looks good.
> >
> > Best regards
> >
> > Heinrich
>
> Thanks
> /Ilias
