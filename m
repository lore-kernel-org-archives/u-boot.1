Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68531C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D0AF8122F;
	Thu,  6 Mar 2025 17:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JP730Aby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5AD781253; Thu,  6 Mar 2025 15:34:36 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A3C180756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so112978166b.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741271674; x=1741876474; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YfMYv53wMMjgJ2wvcYKrUxOfcwH7gFSkzF8JiZmE2o=;
 b=JP730AbytAPpdfSHeP5hY3nEdauUP/1mUePyBzExdHxWtT1z+Ba+YZ7CHlPJyHBGtW
 ZD3m43n5AUqLirENtBpQoJDpHskmoeDeiUX2y2wx1V7IKFI5tHMRnRAhoRM8RoIAGTP8
 B6wN6lDAU27RvblZGufoKhYhIfwYR7h4HXF0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271674; x=1741876474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YfMYv53wMMjgJ2wvcYKrUxOfcwH7gFSkzF8JiZmE2o=;
 b=aaVB6n0CYBGN+aFwTQOwRsAITtwJ6Rh5U4SVXN6mB7iEHwuCWTaO9nJSMTOihnKHgC
 WCIovkbpEDf9PAhIAO7Re36GzRKReJXA3WoYntMuskoas+DU0gJQkNa84VEISp48VRL9
 HFUBJJFaCgwt6Umrm9BJDqqdiW7S9SnFc+a3eex8jvObn8cSfTkzftHgBRlqR2irQp9l
 fPkbNLQV0rzXw4l+vj72kHuRvxypH3Z8vJPIEE02tad5AvsQz17qWEy31cehv3nemIzf
 IH1bra6i67WRi2VUi5XWb2TC8NfwQt8p+fnRQ1a82NU0Y20kV/VXoAh2MiF27RXTe+sh
 X0qw==
X-Gm-Message-State: AOJu0Yyu67t6Bv5n779U4XXDGpUn3hlbIz8qyamNDrMvWBZbWRaFS2Gw
 s8O/aL64kgyZsHXYZ9x5o4XiCFE29aYROOx6AbVIBNFKJd7Wt0XSQPG1PUPjBFsPGCDCc9qa6g2
 yNdeluP9JTFU+4CzFS6dDU6dfkDiYEZwIXZjx
X-Gm-Gg: ASbGncuX8GlXDcm8+xDe9QXSdZuffwp2H6okvk9ZEkN7i04g/f2pAjL9WYno2U8PYsB
 7Wr757/ECVgodeBVvL/4YZeZqRFVyGHozxjsQGQocJ8hb6fUtvoiYOPvFwH49ZjRzqVyy9xliBb
 vQhfSyEjFUTFroq1Bj5bX5NBXcz7A=
X-Google-Smtp-Source: AGHT+IFCQE4LzY7hdx1AvgO6Fv7gHveK7ja3TqEJpLz0cljpeg9eRnhfegcya2GfYhQDAoM2Xa3d4zimU9PxvbILTLA=
X-Received: by 2002:a17:907:72d6:b0:ac1:daba:c6c with SMTP id
 a640c23a62f3a-ac20d8bf12dmr616910766b.24.1741271673642; Thu, 06 Mar 2025
 06:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20250111000029.245022-1-sjg@chromium.org>
 <173764160279.210100.4402866218713283083.b4-ty@konsulko.com>
 <CALNFmy3gdKBECUWswV4G3ixytQZrHWE1iXbfDDQ-TYKnO8ax0A@mail.gmail.com>
 <CAFLszTgAYCaoBGfZcvz7-KkjC5StG-hmVEbLTa4cjjGuF0d56g@mail.gmail.com>
In-Reply-To: <CAFLszTgAYCaoBGfZcvz7-KkjC5StG-hmVEbLTa4cjjGuF0d56g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 07:34:22 -0700
X-Gm-Features: AQ5f1Jo2UMr1O45r_ufJn1YiD5LnTwIkaqER-nnr0FR8TGOagmMcJeeXm59PCVE
Message-ID: <CAFLszThau3akFBLA61N0Lpb_HfVW4DW5oWHFbdY7um+rdowr=Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] upl: Prerequite patches for updated spec
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
 Alexander Dahl <ada@thorsis.com>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Chen-Yu Tsai <wens@csie.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Cornelis <hugo.cornelis@essensium.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Janne Grunau <j@jannau.net>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>,
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michael Walle <mwalle@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 06 Mar 2025 17:21:44 +0100
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

Hi Patrick,

On Sun, 16 Feb 2025 at 05:56, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Patrick,
>
> On Sun, 16 Feb 2025 at 01:28, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Hi Simon,
> > On Thu, Jan 23, 2025 at 3:13=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Fri, 10 Jan 2025 16:59:59 -0700, Simon Glass wrote:
> > >
> > > > The current UPL spec[1] has been tidied up and improved over the la=
st
> > > > year, since U-Boot's original UPL support was written.
> > > >
> > > > This series includes some prerequisite patches needed for the real =
UPL
> > > > patches. It is split from [2]
> > > >
> > This series breaks booting on Arm64 using ACPI since the ACPI tables
> > are no longer advertised
> > using EFI. It looks like "efi_loader: Avoid mapping the ACPI tables
> > twice" is at fault.
> > Never calling efi_install_configuration_table() on
> > CONFIG_BLOBLIST_TABLES enabled systems
> > just looks wrong (it might still work on x86 as the kernel will scan
> > low mem for RSDP).
>
> Thanks for the report. I'll take a look.

Here is a possible fix:

https://patchwork.ozlabs.org/project/uboot/patch/20250306143134.2549815-1-s=
jg@chromium.org/

>
> >
> > > > [1] git@github.com:UniversalPayload/spec.git commit 3f1450d
> > > > [2] https://patchwork.ozlabs.org/project/uboot/list/?series=3D43857=
4&state=3D*
> > > >
> > > > [...]
> > >
> > > Applied to u-boot/master, thanks!
> > >
> > > --
> > > Tom
> > >
> > >

Regards,
Simon
