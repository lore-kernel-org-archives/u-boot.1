Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7851CE8FDB8
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 23:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC6C483B03;
	Sat, 27 Dec 2025 00:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fAfAlVwd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE7283B03; Sat, 27 Dec 2025 00:12:42 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8862383AB8
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 00:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c1e4a9033abso6472480a12.3
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 15:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766790758; x=1767395558;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCQ+0dBLPkdhsfHQrwb+wknZ5AlmdnpxZRkcXgkg1oc=;
 b=fAfAlVwdquf4V4yh+87PFi8Hzd3wKkLuLgh5CMp7oX2FHtwACX9KhjN7qBwruX8Ehy
 Et0FoVt60i6YsD2ZwXfTGMDCdcCwuPZS8UrPGDHmDHBtU7ZaM6X0E72jzjKezA4/mqBf
 zvjJcQfaGPuMLqGaTh0c18fr9vZmZ9iBmnfyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766790758; x=1767395558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mCQ+0dBLPkdhsfHQrwb+wknZ5AlmdnpxZRkcXgkg1oc=;
 b=fcxJPclDs5OtaG3ld0eQ0SvEPnRSGmmjTNUzdfdl+ETyjZkipQ1x3zdfBHRpQTHF20
 mujDMIrXIX6bS+EV8J48TZSkWQAliPaFqL2rtoLxFYJRuMjqS/IXLhmqSxRBMxVueiRp
 ABOBlBdOo5FWgSqI8UKt07jlFmKSmxS+zv1aK+msTnU6MDgkkxhPrDkSONTRfPfi1Q8l
 KvDE1XNvfVVtADgkk/aQ48t0E7mJcbiguxVg8VCSpv3cz0R+Mlw33JN9YAJAWBl2QMTq
 2fLQ/boCmkWtYD6lAEpyedfSOMMyDR0u1XuPR6wE2jbOwaHpGf/U5aQDTVk7FYU0MPp3
 AiuQ==
X-Gm-Message-State: AOJu0Yxy5hrBR6eHNBMV4cfV3RuCfRdrduJe7XTSonr2Re+XUTmorVnI
 pM1Plq9RhpJ2JLjMVpwhc9awpa4GTcD67atLyF64yJ+GAF3rfZM9tOE1TlXYOBdoITDCG/koWPW
 blEw1HqhbtwFiVBnp2cZskYPyznCl/IsvMiViTiglemj9wkUQ8YY5+tkosw==
X-Gm-Gg: AY/fxX40UVF9ihLXizHYYjuIGz5GRv0xE3SeKfe8XJnp6V7N4z6BgAANjuXQjuJy1Cg
 CRo022xt8lQwDog9Od34JqV1rhym45ZVuD5EWV2o/EKGF3nAwIdUh8Keup7n1qM9oW/JnTZNcrj
 mtIIHDJMPjPBdGZgP8nnSDC2RSJMMx0DF9Rianm63JUUdMvh2apwCXeryV6ghWdeWGdN9Vgisww
 p1ZPggqsX8qJtDI+wcRlxBA0GSZPyfuseViyBBy0RzkW0KX94oym93CU83WDjvQHSFexX0NUl0A
 8VzaMMUYFE4YDgaIbMh+TXw=
X-Google-Smtp-Source: AGHT+IEOup3v1d/U+uodXAE+1FAGKeHjlfmLDXwzYhjIgxYseyAmD9G8GRlvzo6TQ6LzoBxBGee3O5bJx1lk5hHKIxg=
X-Received: by 2002:a05:7301:df4a:b0:2ac:2c08:9017 with SMTP id
 5a478bee46e88-2b05ec6fdedmr13990622eec.28.1766790757879; Fri, 26 Dec 2025
 15:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-4-trini@konsulko.com>
 <CAOf5uw=86_NwDM=96Jpz+5o4HDh628KTfhqjJJEmdLNEv55JOQ@mail.gmail.com>
 <20251226185752.GG710860@bill-the-cat>
 <CAOf5uwksV4-nCKKQbeJJR8-tUkgC_fKDYVKBG8K6qtC2zOfOjg@mail.gmail.com>
 <20251226225100.GI710860@bill-the-cat>
In-Reply-To: <20251226225100.GI710860@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 27 Dec 2025 00:12:26 +0100
X-Gm-Features: AQt7F2oj7zvIVti_AZvnlXyJAQL5vkZ7Ut0r65QfQhdBTDNA3-UjIRj5ePAVcNo
Message-ID: <CAOf5uwmsdAfR2p77APbCEWzds-cdpQjx3rbPXPi1C8pcy8Nr4g@mail.gmail.com>
Subject: Re: [PATCH 3/3] dm: core: Default to using DEVRES outside of xPL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Hi

On Fri, Dec 26, 2025 at 11:51=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Dec 26, 2025 at 08:55:40PM +0100, Michael Nazzareno Trimarchi wro=
te:
> > Hi
> >
> > On Fri, Dec 26, 2025 at 7:57=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Fri, Dec 26, 2025 at 07:28:43PM +0100, Michael Nazzareno Trimarchi=
 wrote:
> > > > Hi Tom
> > > >
> > > > On Fri, Dec 19, 2025 at 9:21=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > The devm alloc functions that we have may follow the Linux kernel=
 model
> > > > > where allocations are (almost always) automatically free()'d. How=
ever,
> > > > > quite often we don't enable, in full U-Boot, the corresponding au=
tomatic
> > > > > free. This in turn leads to memory leaks. Rather than manually tr=
acking
> > > > > allocations and implementing frees, rework things so that we foll=
ow
> > > > > expectations now and enable the DEVRES functionality to manage fr=
ees.
> > > > >
> > > > > This turns DEVRES from a prompted symbol to a symbol that must be
> > > > > select'd, and we now remove our non-managed alloc/free functions =
from
> > > > > outside of xPL builds.
> > > [snip]
> > > > > @@ -279,8 +280,8 @@ config DEVRES
> > > > >           released whether initialization fails half-way or the d=
evice gets
> > > > >           detached.
> > > > >
> > > > > -         If this option is disabled, devres functions fall back =
to
> > > > > -         non-managed variants.  For example, devres_alloc() to k=
zalloc(),
> > > > > +         This option is disabled in xPL phases anddevres functio=
ns fall back
> > > >
> > > > Fix this typo
> > >
> > > OK.
> > >
> > > [snip]
> > > > Can you please in the commit message a concrete example on what thi=
s
> > > > commit takes care of?
> > > > In short expand here:
> > > > " in full U-Boot, the corresponding automatic free. This in turn le=
ads
> > > > to memory leaks."
> > >
> > > Sure. So for example:
> > > commit 00e1fed93c8c3e4c9037741ea1b70a9e693a6e65
> > > Author: Francois Berder <fberder@outlook.fr>
> > > Date:   Tue Nov 11 11:30:19 2025 +0100
> > >
> > >     firmware: ti_sci: Fix memory leaks in devm_ti_sci_get_of_resource
> > >
> > >     - Fix temp memory leak
> > >     - Free memory during error handling
> > >
> > >     Signed-off-by: Francois Berder <fberder@outlook.fr>
> > >
> > > Is needed (I'd have to re-read the threads to see if in whole or in
> > > part) because DEVRES is optional today. And barring
> > > drivers/core/devres.c doesn't work the way it's documented and expect=
ed,
> > > the normal unwind path will eventually say "Ah, and devm_kfree these
> > > devm_kmalloc'd areas". This was part of either the discussion for tha=
t
> > > patch, or another one of Francois' patches adding devm_kfree() calls =
to
> > > devm_kmalloc()'d areas.
> >
> > As far as I understand the devres_release_probe should then free the re=
sources
> > allocated to dm_device.
>
> Right. And without DEVRES enabled we don't have this match between alloc
> and free, which is unexpected by most users of devm_kmalloc/etc as that
> path is not optional in the kernel.
>

Please add in your commit, including the typo

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

> --
> Tom



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
