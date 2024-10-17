Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B6AD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E0589104;
	Fri, 18 Oct 2024 01:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LrDCIhH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A738912C; Fri, 18 Oct 2024 01:23:27 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CB189083
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b148919e82so108148685a.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207404; x=1729812204; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TNccz+C7M8MIMlWJt47rz3iwlAeNTQcvG04PwMaGb4E=;
 b=LrDCIhH+9KL595MaOFz+AqyfWEtf6IToRbkJzMwN+YyA8kkniRF1LHLKDjTGtxxu33
 GR9nH9oyi+7fgYlcAa2kPuubjqf1wX7E60HgQLXeHhmYzPNGkv5ZMC/Q7g1gD+2QQQT5
 +OwgNZ1nbClL0TaT9LFZW21RsEtsYJNQ/CBg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207404; x=1729812204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TNccz+C7M8MIMlWJt47rz3iwlAeNTQcvG04PwMaGb4E=;
 b=GHx5Vh9ShrMObZdl8nsXNICFQWxWLHk1R6vsAocrIEGXkPqKUZ7uqEEP2+0aMz+sQQ
 dfwNbxkkInXS1fOjJVbQknW9tbO3Dg9V1nqoJQfiIHhxBNbI9udmUh0UYosJAfEljsL8
 WU41/ZtjTkYbs8FMyeTkjCt3wjnkvy+X1FepBZ1o60j2aj5CQRRLIOLz1AfuIc/lM4NB
 W3g8rfJc84L1ZyECcEbT94tA0V3mg5mwwAUpL/DD0zi1Ezi8amMUOUPGqvGbkHJdNgoU
 nXFGoIF9zFEj4EqWzUEBEFDsdbXNnfxAKh0UZ4lVcY6XNIDDW2Ei0Zq7Vwu8uywmsoXK
 +puw==
X-Gm-Message-State: AOJu0YwdFBKeZSro8ngsaEWaYJZQRobs86ITFhqOv0SIh5UVYP3gJ1B8
 eH8oQ5Vgii+X+yvWmhxiSB0VrDdgcL44T5Rw6lu6bdK8PLzHXGBugUAl63rPvbyqmdfFrxQpFQ2
 A+1GHwe3lPxhcc9zL99GWvRcna2LKQQoB2ZsQ
X-Google-Smtp-Source: AGHT+IFkeOtLdiLeBiGeUA8sUSLkzNnTCsrClkLmvSnpVrHwwDX2ekHqY4NQCSAqSIFWn/MF4tjomu74gz82lAqPhp8=
X-Received: by 2002:a05:6214:4808:b0:6cb:c744:c415 with SMTP id
 6a1803df08f44-6cde1608f98mr7023816d6.49.1729207403792; Thu, 17 Oct 2024
 16:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222734.462334-1-sjg@chromium.org>
 <20240901222734.462334-5-sjg@chromium.org>
 <799c5b5a-a7c8-4f95-aee8-11bdc92f64e0@arm.com>
In-Reply-To: <799c5b5a-a7c8-4f95-aee8-11bdc92f64e0@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:23:12 -0600
Message-ID: <CAFLszTh9fXZ2ggpXbrJt5JhsVHLMPKzS4=KH=M+B9YacdFsnKg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] sunxi: Add a bootmeth for FEL
To: Andre Przywara <andre.przywara@arm.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

Hi Andre,

On Wed, 2 Oct 2024 at 12:03, Andre Przywara <andre.przywara@arm.com> wrote:
>
> Hi Simon,
>
> On 01/09/2024 23:27, Simon Glass wrote:
> > Add support for booting from a script loaded over FEL. This mirrors the
> > bootcmd_fel provided by distro boot.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Put the FEL bootmeth before all other global bootmeths
> >
> >   boot/Kconfig        | 14 ++++++++
> >   boot/Makefile       |  1 +
> >   boot/bootmeth_fel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 96 insertions(+)
> >   create mode 100644 boot/bootmeth_fel.c
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 291919ea1ef..7d6e819bde6 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -585,6 +585,20 @@ config BOOTMETH_EFI_BOOTMGR
> >         the EFI binary to be launched is determined. To set the EFI variables
> >         use the eficonfig command.
> >
> > +config BOOTMETH_FEL
> > +     bool "Bootdev support for Sunxi FEL"
> > +     depends on ARCH_SUNXI
> > +     default y
> > +     help
> > +       Enables support for booting over USB on a Sunxi device. This uses
> > +       the FEL protocol and obtains the script address from the
> > +       'fel_scriptaddr' environment variable.
>
> This is not quite accurate, can you please change this to something like
> (feel free to amend):
> =======
> Enables support for executing an explicit boot script uploaded before
> via the USB FEL protocol. The 'fel_scriptaddr' environment variable
> holds the address of this script, taken from the SPL header.
> =======
>
> (The flow is: The sunxi-fel tool detects an mkimage script file among
> its command line parameters, and amends the uploaded SPL header to store
> its upload address. U-Boot proper will detect the address in the SPL
> header, and sets the fel_scriptaddr variable.)
>
> The actual code looks alright, and it seems to work (TM).
>
> Just one thing I noticed:
> ....
> Hit any key to stop autoboot:  0
> ** Booting bootflow '<NULL>' with fel
> Hello from FEL script!
>
> Is this <NULL> expected? Shall there be anything better in there?

Oh, I'll give it a name.

Thanks for reviewing.

Regards,
SImon
