Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD6CC61DCB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 09:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D24983A41;
	Sat, 21 Feb 2026 10:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YDdcYlo2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DBE483A5E; Sat, 21 Feb 2026 10:41:30 +0100 (CET)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49CB083936
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 10:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-649e456e8a2so2332096d50.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 01:41:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771666887; cv=none;
 d=google.com; s=arc-20240605;
 b=Iq3lvMkTd/4M/SSvfqTZQfImixjzkNaYNiBnfK5E7COzenbjURVLJUcvyzzgRlcOqf
 yuFMkmqoTN9h6SLDEilpErMgaXy0+f9YlX8Sw4PXcX+BJ8H6pXsoGN2pB+ZsJ4hMaeBE
 ms68Yx2cWLcFs5dwFBlIfPFhrCJ+jtAOY5+EcDEBIwTK1Cpyfu6SklaEAT8bN7KoZtur
 kRGQm3bgTd3CQkmME7/g2yj8f/AJ0a97ZC9Rm6/0O0nPuXg8bl1+4cza5EoeFXOFta2Z
 oW7MHklIn4+xHGPLbuzlNeTQwe7LjmbfhPX9rAUSq3UsWP/Y6NvMCwoSisgn6dOkpCVs
 mK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RT63xDCHTx5R/rxGKKixXYRUQOy1Xlae34V/UcOEGtg=;
 fh=K4fEZAeBJ7c6AMRfLrekQrp68wzyRcp4YARqxxWzoYA=;
 b=SZmIvqj2xB/oPmZGikJ8YPfcz/P9CvAcTOqKzTRPlXvRVZ3+OLGwETEqXAqcU73rnd
 QNcwomyzH6gAKmA6cJOXX0uUaJavrBPx62o5+hvcz2FcGuf41yvgVEf2O4zzXePYbP/n
 EVJSovznzwpwOM1ArRvbYM27MM+kefw+uyC33YDNEVfNnmDk8X7g755Bf0m4v5gjWwAY
 bc9Qg+jSet7iH+NRBuUAOul0i6KjFLsFJcotqNDzz/DaGcue1UABJ9XFg/SacuRvkbv9
 XuM7k1CwTgMroGWKrc57MpcVF4j4aWqU2kCL5sSIpVT+O6QXIuNUk0synTZWmC5nNih8
 /OuQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771666887; x=1772271687;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RT63xDCHTx5R/rxGKKixXYRUQOy1Xlae34V/UcOEGtg=;
 b=YDdcYlo2E6ONIy4FVneVseo1wdVRNskqCGsi5T5ck3ohgK8+GgEsjSFd0bJwXyPrNJ
 lHSqqqfFD1+sRKW3RDqwyTdttMJaz+ELymJSnbFqtyKZSIyKKedPnDMgJVCA1znz9XhG
 oUtBcvUuTBUIAcauviDUzPewr71uMDAsSafAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771666887; x=1772271687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RT63xDCHTx5R/rxGKKixXYRUQOy1Xlae34V/UcOEGtg=;
 b=BKdBYjUQrSEPfwZgLbzLeG1nGbdoLGuR09RFf/gnLnXBicndF4eVmmlbw8IuoENy29
 GRx2ZejoZo5UqDw1EBKiIHlpOPjypEKzVXyjpo0KJhEu9fWxTa4gmiRS9yOCVpk1csKA
 LKfVtIFcDuGoLmLGoIET01w+XL9Hb0K4EcDejlGgkP5/lVSLgkZC8pf7vLwdedq2pLJn
 0rIDEs9kEECRteEbvbDpVd2gQVxbaWwWk9LIXyQCtx56hguZM5CYCeRaIv7VDNUZiC2y
 Mld2s4m3ZzXOvNuLi1DmKWxItZpk9b9dZuIsvM6t9/YuxiL+GrOgHUjAEl8vdnjt+Ip3
 XGYg==
X-Gm-Message-State: AOJu0YxuXH9+x9rft6vdbBHW1JyOp8V4dohGMA2xMYwc5uvfg3EIdb5h
 +k+nz8PqRogDlPW4J0RUmzIWsp7Y/pBSxfiW7GEORJLGkQ/w8FwtQyCVSCYA3qS/ouUNZbPsfny
 0YawoswJnMOvkFXl9L5OvwW1zf+1xoc6nrbE46RSyXw==
X-Gm-Gg: AZuq6aKwlGqJdzZvbZYHCl2WLOVl+UJtD5YG2VlhoqdtS7v3vm4oObh4Aplb+cTl4+p
 cOil6/cP6QtpypZW4FEafpSb/QPEo3YlXY0kJ155IET/IQgekTOymbkZeLBomLWYBZSefsLyD8g
 AH5C8X2lCAsngDWN7j1hUKBXZR3+kUekPXx0ytfBmZLVEUUM7sDeidoW08zYmkjk/aYepTOGQCE
 hPNHhPEU78RWSeKyD0pFdfDq0w7/1kb+QM2A16yA2zTXzh3E33XYEgCSTFbi3pEx4DmWBJQWGqo
 FgMfhoP/ToyIJeF+lnAQE9BD3Wd6dQQ3hY+TiQ==
X-Received: by 2002:a05:690e:4198:b0:64a:f8b9:b892 with SMTP id
 956f58d0204a3-64c78e44502mr2065126d50.52.1771666886996; Sat, 21 Feb 2026
 01:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
 <CAPVz0n3E-v5EZ8THu76dXUeERrq1MCFyReib5rS9N3DV2Tkidg@mail.gmail.com>
In-Reply-To: <CAPVz0n3E-v5EZ8THu76dXUeERrq1MCFyReib5rS9N3DV2Tkidg@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 21 Feb 2026 10:41:16 +0100
X-Gm-Features: AaiRm52MmOD1K8dvlu8u_K2uhZfV1j2QJD_fK7SjX-fsFFPAhAmDqiNKiGEUBOg
Message-ID: <CABGWkvoBxaGUsXLvhFXNJ=xO-JSZ=Lravv10tXSdQ=oz=EtGRw@mail.gmail.com>
Subject: Re: [PATCH 0/8] video: support Rocktech RK050HR345-CT106A panel
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 linux-amarula@amarulasolutions.com, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ion Agorria <ion@agorria.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <simon.glass@canonical.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 uboot-stm32@st-md-mailman.stormreply.com
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

Hello Svyatoslav,

On Thu, Feb 19, 2026 at 7:44=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> =D1=87=D1=82, 19 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:51 Da=
rio Binacchi
> <dario.binacchi@amarulasolutions.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > This series adds support for the Rocktech RK050HR345-CT106A panel.
> > The initialization of this panel requires a 9-bit word length
> > configuration. To support this, I have extended the STM32 SPI driver
> > (including support for the STM32MP25 SoC) to implement the set_wordlen
> > operation.
> >
> > To properly validate these changes and ensure the SPI uclass correctly
> > handles the word length propagation, I have also implemented the
> > corresponding logic in the sandbox driver and added a dedicated unit
> > test.
> >
> > I have grouped these patches together to provide a complete overview of
> > the implementation and its verification.
> >
> >
> > Dario Binacchi (8):
> >   spi: add support for bits-per-word setting
> >   spi: sandbox_spi: support wordlen setup
> >   test: spi: add sandbox_spi_get_wordlen interface
> >   test: dm: spi: add testcase for spi_set_wordlen()
>
> Hello Dario!
>
> You should not need to modify spi framework to support 9 bit len xfer.
> dm_spi_xfer supports this already, you need only stm32 support for
> non-aligned xfers.

Thank you for the feedback.

I initially explored the approach you suggested. However, following
the STM32 driver
implementation in the Linux kernel, I found that explicitly managing
the bits-per-word
parameter was necessary.

In the current STM32MP2 driver, the word length is effectively
hardcoded to 8 bits. To
address this, I needed to implement the set_wordlen ops, which is
already declared
among the available SPI framework ops but had not yet been implemented or u=
sed.

The proof of this approach is that the driver now correctly handles
multi-word 16-bit
transfers of any buffer size, using 9-bit words as required. This is a
significant improvement
over the common implementations that often only support single 16-bit
data transfers.
I believe this provides the necessary flexibility that dm_spi_xfer
alone couldn't achieve
without a way to redefine the word boundaries.

Thanks and regards,
Dario
>
> You can refer to ssd2825 bridge as an example of 9-bit spi
> communication for write and 16 bit reads.
>
> >   spi: stm32: clean up buffer length assignment
> >   spi: stm32: add support for bits-per-word setting
> >   spi: stm32: extend support to STM32MP25
> >   video: support Rocktech RK050HR345-CT106A panel
> >
> >  arch/sandbox/include/asm/test.h |   8 +
> >  drivers/spi/sandbox_spi.c       |  21 ++
> >  drivers/spi/spi-uclass.c        |  19 ++
> >  drivers/spi/stm32_spi.c         |  67 +++++-
> >  drivers/video/Kconfig           |   8 +
> >  drivers/video/Makefile          |   1 +
> >  drivers/video/ilitek-ili9806e.c | 354 ++++++++++++++++++++++++++++++++
> >  include/spi.h                   |  12 ++
> >  test/dm/spi.c                   |  16 ++
> >  9 files changed, 499 insertions(+), 7 deletions(-)
> >  create mode 100644 drivers/video/ilitek-ili9806e.c
> >
> > --
> > 2.43.0
> >
> > base-commit: 7dca54ef4c44c82bdc6716ac6cdc84c22c66e9ed
> > branch: RK050HR345-CT106A-ON-SPI



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
