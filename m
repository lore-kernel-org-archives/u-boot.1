Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4099CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 07:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5661B83E11;
	Sat, 11 Oct 2025 09:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HPkYWu/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDAAA83E46; Sat, 11 Oct 2025 09:21:29 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7B883C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 09:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-62ec5f750f7so4806863a12.3
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 00:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760167287; x=1760772087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B7a+20HaA1pLuDuXBMOfcDEcmk6RQ37D70SQ3JCDpFI=;
 b=HPkYWu/n4YVwN5yPCaraD1/24lmzBvJowCIJL49BduCiIxZfaok/pbuIQgeAmD4vKU
 +ZmM9hG+e7V5PYEyH68E5vRNvLvYlM9W2MIIEMuFL/eIdSQN3rlFMC2YVJxRDG3LzPYs
 QZnbt6eCJvf3IoEIV80NmZwz0K+/aXvsR1DMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760167287; x=1760772087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B7a+20HaA1pLuDuXBMOfcDEcmk6RQ37D70SQ3JCDpFI=;
 b=sk7uqiQN8DZss1ob56egAnq+BvVZRQajg7GI9k8zaPrRubWcOGgWwOCNUg3I1g2fwb
 NQjdzRo2RVL5VFlJMdNhXkLbErByqTajhjuRWriEr6SxzQBq8awogLIShaJPJgmXMHyb
 xPQvrTSEmIBVGDdlaeCILdZuA0qGWM8jP4okquPHM0TM/AEIIzHLPegkXHhD2lANDNMf
 K3tc4UJtZMGyBxUf4SL6j/2x9Bhv/Thb79kBhs5AWn+gGv9fsT0Kk9ADRUuCiLDSCNpS
 QY/deidjjNgcY9w1JyjiGCyTjDkO8pJoySQDo9jQ/hexHEU2axbVM1Fn3X+3bt3i3efj
 TXqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTbPzVD1FGAQJZzgG+80AzkWHT39MFQt5wYH5iMRAqmJn6IR9CPuiwKAle5Mlfy9Ba1mDIMD8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2UrremNce+r16Gni4mi98S1WAD7py6OFPRib99WXCWK2XYIyK
 NqX18Zz390hZF7m2SpgepTXnpyRw9zzo1jYil1Xa/N6Lwi5XZyPo0uCCXEOOT9S4fydZKBVviTS
 9z61PI3KhvHTPIx9bjHNPyQMyPcn5TRhDDjuGUfBT
X-Gm-Gg: ASbGncuvaeYiKsD0SXrehvK+nEVVoYpSJfv9sL/SUBhfpET1Sm4dkR6yECJ42YMpv7x
 B6QZNWGtbfXyozASMKiSem1hzxBnaGO1pqwBlgiNSiQ75GMBrt93oK3YAA5JL2aaE4+u4ECK5JG
 3xvtnHTj8pKOCmjYBdgRK65A9f9pQJMWv6n9yBhLfyj4aGZLqvC+7GlK3+7SeIm4U5ODWHxbiCc
 aYmdGGzDapM6mDud3wHWZ8hDem/f0QIU1Im
X-Google-Smtp-Source: AGHT+IFMyPK+uD7JNmYuiSp33UiYyL7+WFIVfiDjcNjulMgTrYXo3fJ5AwX0xU99VFrNwgVIBSvZ00nSP+ejRUOLNwo=
X-Received: by 2002:a05:6402:13d1:b0:633:7b1e:9aa3 with SMTP id
 4fb4d7f45d1cf-639d5c6f39emr12709644a12.34.1760167286935; Sat, 11 Oct 2025
 00:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-3-sjg@chromium.org>
 <20251009172428.GP298503@bill-the-cat>
 <CAFLszThKqdoRwqSbazWgdw27q9RxJorTwkLmRzZ9FAV48S7gdg@mail.gmail.com>
 <87wm52vobc.fsf@kernel.org> <20251010143950.GB298503@bill-the-cat>
In-Reply-To: <20251010143950.GB298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Oct 2025 08:21:15 +0100
X-Gm-Features: AS18NWBBUoTkMkHISUXPvQ8SM2rCEJ8pYer4Sgh_Q1aoDzmKsHroziNcn9O3OIE
Message-ID: <CAFLszTiYNZpuKpA7JyyjrvCysN3KCsQcv0UkU+RhvLb05u=Vzg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] boot: Move obtaining the label into a common file
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
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

Hi Tom,

On Fri, 10 Oct 2025 at 15:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 10, 2025 at 04:11:51PM +0200, Mattijs Korpershoek wrote:
> > On Fri, Oct 10, 2025 at 11:35, Simon Glass <sjg@chromium.org> wrote:
> >
> > > Hi Tom,
> > >
> > > On Thu, 9 Oct 2025 at 18:24, Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> On Thu, Oct 09, 2025 at 03:29:53AM -0600, Simon Glass wrote:
> > >>
> > >> > The 'bootflow list' command supports looking at the EFI device-path when
> > >> > available. Move this piece into a common function so it can be used
> > >> > elsewhere.
> > >>
> > >> The point of this was to enable the show_bootflow->bootflow_show chnage,
> > >> so should be dropped.
> > >
> > > OK.
> > >
> > >>
> > >> > Use 'usb' instead of 'usb_mass_storage' for usb so that it fits in the
> > >> > column space.
> > >> >
> > >> > This updates the output from 'bootflow list'.
> > >>
> > >> And this is unrelated and should be its own patch. Wikipedia says USB
> > >> MSC or UMS are the common short forms for USB Mass Storage devices, and
> > >> we should use one of them to have the output be more precise (since we
> > >> support USB networking devices for example).
> > >
> > > Ok I can move it into its own patch.
> > >
> > > Are you wanting this to say 'ums' instead of 'usb' ? Will anyone know
> > > what that means?
> >
> > Search for 'ums' gives the following U-Boot documentation:
> >
> > https://docs.u-boot.org/en/latest/usage/cmd/ums.html#ums-command
> >
> > Where the acronym is documented.
> > This is also the acronym used by the cmd (to configure usb gadget as USB
> > Mass Storage).
> >
> > So I'd say it's a reasonable acronym
>
> Thanks.

OK so I'll update this to show 'ums'.

>
> > > Re the second point, at least in U-Boot a USB Ethernet device shows as
> > > 'ethernet', i.e. the interface doesn't matter. We don't have logic to
> > > look a level deeper, at present.
>
> And this is unfortunate and confusing then because it'd be really good
> to know if I'm talking about the USB ethernet I plugged in or the
> ethernet port on the board. Made more confusing in turn by the platforms
> (more historical than modern I *think*) where that ethernet port on the
> SBC itself is wired in via USB.

A user can only tell that with something like 'dm tree' today. Perhaps
this is outside of the scope of this patch, but what would you like it
to show if it is USB Ethernet? Are you asking for code which checks
for this and shows 'usb_ether' or similar?

I still know of boards which use on-board USB for Ethernet, but more
historical as you say.

Regards,
Simon
