Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D77AC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 13:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881EF80E90;
	Sun, 16 Feb 2025 14:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QkU3NOs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3426C80F3F; Sun, 16 Feb 2025 13:56:46 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5A2180F53
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 13:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5ded6c31344so3717007a12.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 04:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739710603; x=1740315403; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BHltMQeRPgdgLv+R+96U6ATNdVyRqwCFx/LlFM/xPk=;
 b=QkU3NOs112bvYlWeXk0XoDIol3wa0pbox0M/q9jTlBRnTHZweqbKNoX9QMB40opQWq
 84IfMiTJCgT+f5l/JiUVutS7KvsoOLMrfRW1X3VZZ3slo3NQQmy9Ngp5YQGrUMVZb7Sl
 JTB02hb+HEqYsJ3hN34wMeUgVEJ41lUcH/eaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739710603; x=1740315403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BHltMQeRPgdgLv+R+96U6ATNdVyRqwCFx/LlFM/xPk=;
 b=HA0P9dg5+skJrrS8n86RBnqpR8rp+gcs827HtVEV9SUIbIaVeETphtsTocuITzQwFm
 iYswlnimDjEQMNzl90gqeX9eGnDgfq2VevMzcceVcWJrlOnL8J6JcL4KkVAO9v2CO2cF
 N9/aufmu/ZdhW58NZSPS1pWXzUA26lM8EZ3m3OHKI7Lbcbk3DXveJHTA5gZOuiQQOHHT
 cEiR139YuUArImO8iHRmgzJjuPAAf6YwpdCtUr5EdoXmMJxhUqprTWEXYDHlIsay55D1
 kBvHyNB8SEJ6fvY2EiuEjX/ncwPYiZ/NJLHwjjdGHBR2i1JZ7vJ35BAduHfIXmitOJ3u
 z81A==
X-Gm-Message-State: AOJu0YyIM5bYmh7PQADAE1U4uNxgJjDUwE/lcFZDKzW2AnrJ/Rdv4/tE
 DMyVHsDsnmN1ndVJM2ZdLfSlUo3sSQYMoKwbcKGZjI7GSr6YH+2RLIXXXpizIAyOOdwz5pbukz+
 ApJc7Mb6n9p3yt1ffFqnn2a6UR8hOoL/hjKWu
X-Gm-Gg: ASbGnctLhXK1x1UNpdOLEh3XQ0Anldb8Hb97GX6v+gr7JPUuHff9motVOxzk9KqyB6o
 623hDKBxQ+hpghRgP7CG6uRXraPVjo2e7Cx8OCgxxWl6piEorDFzNZbdGgIl9oTIs29tjK4jI/w
 ==
X-Google-Smtp-Source: AGHT+IHJNotmbR2l/jXc9wPgw8jA6LJqEIdlqJdsgs1OGaVrFAOUkVzsAKLvwEiio9IKpgx6b4ubs78xhqna++8n/AY=
X-Received: by 2002:a05:6402:4609:b0:5e0:2ea2:e583 with SMTP id
 4fb4d7f45d1cf-5e03605b96fmr15926061a12.14.1739710603247; Sun, 16 Feb 2025
 04:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20250111000029.245022-1-sjg@chromium.org>
 <173764160279.210100.4402866218713283083.b4-ty@konsulko.com>
 <CALNFmy3gdKBECUWswV4G3ixytQZrHWE1iXbfDDQ-TYKnO8ax0A@mail.gmail.com>
In-Reply-To: <CALNFmy3gdKBECUWswV4G3ixytQZrHWE1iXbfDDQ-TYKnO8ax0A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 05:56:30 -0700
X-Gm-Features: AWEUYZkg6d2tYfmhE1MBnApLaeyZsfYOOLoVdDDKl-FPvJK_3Pk_vvKmuIywQOE
Message-ID: <CAFLszTgAYCaoBGfZcvz7-KkjC5StG-hmVEbLTa4cjjGuF0d56g@mail.gmail.com>
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
X-Mailman-Approved-At: Sun, 16 Feb 2025 14:31:13 +0100
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

On Sun, 16 Feb 2025 at 01:28, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Hi Simon,
> On Thu, Jan 23, 2025 at 3:13=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, 10 Jan 2025 16:59:59 -0700, Simon Glass wrote:
> >
> > > The current UPL spec[1] has been tidied up and improved over the last
> > > year, since U-Boot's original UPL support was written.
> > >
> > > This series includes some prerequisite patches needed for the real UP=
L
> > > patches. It is split from [2]
> > >
> This series breaks booting on Arm64 using ACPI since the ACPI tables
> are no longer advertised
> using EFI. It looks like "efi_loader: Avoid mapping the ACPI tables
> twice" is at fault.
> Never calling efi_install_configuration_table() on
> CONFIG_BLOBLIST_TABLES enabled systems
> just looks wrong (it might still work on x86 as the kernel will scan
> low mem for RSDP).

Thanks for the report. I'll take a look.

>
> > > [1] git@github.com:UniversalPayload/spec.git commit 3f1450d
> > > [2] https://patchwork.ozlabs.org/project/uboot/list/?series=3D438574&=
state=3D*
> > >
> > > [...]
> >
> > Applied to u-boot/master, thanks!
> >
> > --
> > Tom
> >
> >

Regards,
SImon
