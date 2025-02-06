Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0420FC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C27980805;
	Thu,  6 Feb 2025 13:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wo7vgVnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D3D88081E; Thu,  6 Feb 2025 13:23:25 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD7E807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab74ecfdae4so125133166b.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738844602; x=1739449402; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nZY1c91SleG7SoS6UuQ8aKhY3/WzHIXywYO67Wu9PoA=;
 b=Wo7vgVnqjXQBRi/ggiSbY7GTyW+daNESRpIOC0zWqg05njnPnkfCw8Ljnw59O4oSXL
 WLfFAqVuOZ0HEPqSjh7boWltGCI3TY4gwlf0BM7kHEIHSnIwEG0mjyFcmXoRlpdIIiwR
 YD9PbtBtFRLke8WZGc9ne0RUmoQeTt4Nq/ads=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738844602; x=1739449402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZY1c91SleG7SoS6UuQ8aKhY3/WzHIXywYO67Wu9PoA=;
 b=uTxNGNu9y81MeJP8MfRPWl7rvFZU3fRUEWM9DKNKSiOQKtygpXoe0LNiL7+h4kaYGB
 Jy2tm0axLb9XQV8PnRDFM5ErlxEsnl3sGl9k8S4TAFYtsLUq+q2RDZ275EFtw4kDGH36
 A3EV9AKb7Abr1PZyLWVL0wvZ94kk9QrqCgK96wxVqncMdYCx0rCD+5gN1b5uPEPz7o/n
 ATbWbQuZmso2yObF6xli+ohFrZO5uGAcNnQMevgOKA+7enTRP07E5BzAkv4mO7LP2QmJ
 ygJzu1sTwF5yKIqblFonRSmW2oee63jj/V68A+/lACzz7JlMJOdx4GJXPJx0LH1C2Yfm
 UrFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQQoUvvqECsdP5rVt7mY/2OaIH3F2HXLMiZwkFRtRBxi/2qs5RXKblYZeSORbH2DosmYlQnfA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5edROTzAPcil1GYVmxhG/SbsD0lX/5gyMgtBNFYkhu/fP/+uj
 TK/WcW5SDIIibt600e9HaaAfQVXvj6TRkZvxQqcoFGJQWmQ3krisdB5zFxQ/hlcwnlxzt7fghj8
 9LYqxXOLW07e94Hou/mKj5MXoO3WDD/gG6Omv
X-Gm-Gg: ASbGnctjxn72VAPj2bpaunRq8yB6RnqK9ckaijFImdVefF+KrDeIiV1KXI1OHpMlIbX
 NHU+1XKaNp0atjRAKvAL0kXLaOYE/BtegWozmbTkjbEspmhYcOwbEch9kIKqtMOYQ4RmV9Joxdw
 ==
X-Google-Smtp-Source: AGHT+IH2cN+ysORWyD5SfuL+9MSjXPFycBGqxyKeA9784Gv4P4sOsS/NrB40pcELcztZ3RSBxEjVgOEgpY6MWmR6//4=
X-Received: by 2002:a17:907:8689:b0:aae:ef24:888d with SMTP id
 a640c23a62f3a-ab75e34075dmr654074866b.55.1738844601740; Thu, 06 Feb 2025
 04:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20250205025652.5171-1-hal.feng@starfivetech.com>
 <20250205135818.GQ1233568@bill-the-cat>
In-Reply-To: <20250205135818.GQ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:23:09 -0700
X-Gm-Features: AWEUYZkdsdxxBBsv60gvo9tOpLZ_YEgmLTfQszGAzV26TsieFDOknZSbulsD8UU
Message-ID: <CAFLszTiNPT3oFLgNKack4ZQ_gfHCBeVHCV7Lh44pk6ODTxiHaw@mail.gmail.com>
Subject: Re: [PATCH v2] board: starfive: Update the maintainer file for
 VisionFive 2 board
To: Tom Rini <trini@konsulko.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

Hi,

On Wed, 5 Feb 2025 at 06:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 05, 2025 at 10:56:52AM +0800, Hal Feng wrote:
>
> > Update the maintainer file and mark jh7110 related files with N: pattern.
> >
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >
> > Changes since v1:
> > - Mark jh7110 related files with N: pattern.
> >
> > History:
> > v1: https://lore.kernel.org/all/20250127083814.67839-1-hal.feng@starfivetech.com/
> >
> > ---
> >  board/starfive/visionfive2/MAINTAINERS | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
> > index d7f638f9b41..87589553150 100644
> > --- a/board/starfive/visionfive2/MAINTAINERS
> > +++ b/board/starfive/visionfive2/MAINTAINERS
> > @@ -1,8 +1,10 @@
> >  STARFIVE JH7110 VISIONFIVE2 BOARD
> >  M:   Minda Chen <minda.chen@starfivetech.com>
> > +M:   Hal Feng <hal.feng@starfivetech.com>
> >  S:   Maintained
> > -F:   arch/riscv/include/asm/arch-jh7110/
> >  F:   board/starfive/visionfive2/
> > +F:   doc/board/starfive/visionfive2.rst
> >  F:   include/configs/starfive-visionfive2.h
> >  F:   configs/starfive_visionfive2_defconfig
> > -F:   drivers/pci/pcie_starfive_jh7110.c
> > +F:   drivers/ram/starfive/
> > +N:   jh7110
>
> Might as well use N for visionfive2 as well (and maybe add an entry for
> general starfive files and N that too). Thanks!

As a new maintainer, would it be possible to take a look at the
failing test? [1]

Regards,
Simon

[1] https://ci.u-boot.org/u-boot/u-boot/-/jobs/25452
