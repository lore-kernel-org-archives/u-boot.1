Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2587D49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92DD8925A;
	Sun,  1 Dec 2024 16:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XKly9wQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FC3E885F7; Sun,  1 Dec 2024 16:49:57 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F83F88D36
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so620405166b.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733068187; x=1733672987; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JIAOf31AVRejDwZlAcGkjtTAfw10aFBxH5pYFliIuw=;
 b=XKly9wQ2vkmM1j2mo9/A9wzVz3mf2sxQZ98ReddiF5CiEd5kbLvTlCdtrZTkXxd57P
 DVWXUvsrNDyh7P/3eG/tjHxU9wXVW1F1/VcFCQ13x9Vpf8sLQEWoauq5aqppMUnCwWtB
 fkrTlb24WRxfHJ4REV/Kdq+PM1+a6mC2rR/Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733068187; x=1733672987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JIAOf31AVRejDwZlAcGkjtTAfw10aFBxH5pYFliIuw=;
 b=WO/fmirmiN0YMxBpu/l7v9tXJMKPKrNkGx1iO2pX6xT7OE/aoAdrHkOguJnJ0I+4q1
 2H0FRMbAfSRd49+52LLYy0XcwihFd+Ea9waav6NfI1iZwY8BidGbG3e9e0pka2VTHo0W
 9upFq0V40HDQ+npWSVRy6m3ESNlX7RTh9TBHhY89r36zsBa9iyoCed7a6cmpnGVbX5ZE
 CsnIiZWwM/zDleQ9ATGat796E3SxO+WcVWFx9QEid1InWNSXFll492h4fnZ/+yPITohu
 C96BmE/JcKddLuTdc+00I9M/0DK8pq/41vFezSBA+Fuv0oRCFW+JotWhwdD1kT0eHCkt
 iQyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUInJnhFppqN7+vKZmUuB2XZfx7Ze1NFvx1p42pmJF19S3V04IO8t3IeNy2VpVInkoPTPFTn14=@lists.denx.de
X-Gm-Message-State: AOJu0YxFofx3jJSn6SBfWzhq8XIHGWXxVm+UuzT/u3EAZ8O4YuKRXBGd
 Yx+ViKeWG0+L5voBZ47pBCDI83QTrKeUWv2JVqpU0AtzOy4Psor6Xvrjf+/Z1AHFqR6VF+4ZN1J
 yK0qn8tEZFYkKLZGhprTBtFFiQ9vT30Q8p+rs
X-Gm-Gg: ASbGncsGyMxsZZrjYNQuXtB/n/IQLv4ZrVAI9yilL3wfIyA9I0PeB4cC3nmCehbaY/s
 DyNR85BxklmlVS2qaV5UH+nKlrwChiA==
X-Google-Smtp-Source: AGHT+IEn9htTjbgxlA2XomBae+/iTcK7p/P5c31yu88oxqdGXl3ldn6HJjPK/n3yMcUb7lXPlbgv2B+gWldb/fSw4pU=
X-Received: by 2002:a17:906:4c1:b0:aa5:c9f4:7bb9 with SMTP id
 a640c23a62f3a-aa5c9f4b3e6mr332655066b.35.1733068187411; Sun, 01 Dec 2024
 07:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-3-sjg@chromium.org>
 <CAPVz0n0RGrgUSrNzyT16FKMBcqYs00qb+3jEHsq4tiYyWGR-Nw@mail.gmail.com>
 <65cef924-a16a-4af1-819c-a15410d92f4c@denx.de>
 <CAFLszTg1Na9ziMv4J1Pb9vjw=fYPh+RLGvT-KyYcjGEEonGk2Q@mail.gmail.com>
 <CAPVz0n25b5fQcmp-wW1AmUNtcVXjzNvTHSbjK-wn_p6jpDRzMQ@mail.gmail.com>
In-Reply-To: <CAPVz0n25b5fQcmp-wW1AmUNtcVXjzNvTHSbjK-wn_p6jpDRzMQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 08:49:35 -0700
Message-ID: <CAFLszThvnBaOvqNPOxXKHtZy2rwcHAxU+RgOw6dHGmzWOZ4_8A@mail.gmail.com>
Subject: Re: [PATCH 2/8] Revert "power: regulator: Trigger probe of regulators
 which are always-on or boot-on"
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Marek Vasut <marex@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Svyatoslav,

On Sun, 1 Dec 2024 at 08:24, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> =D0=BD=D0=B4, 1 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 17:=
23 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> >
> > On Sun, 1 Dec 2024 at 08:20, Marek Vasut <marex@denx.de> wrote:
> > >
> > > On 12/1/24 4:05 PM, Svyatoslav Ryhel wrote:
> > >
> > > [...]
> > >
> > > >> @@ -288,7 +289,8 @@ static int dm_test_power_regulator_autoset(str=
uct unit_test_state *uts)
> > > >>           * Expected output state: uV=3D1200000; uA=3D200000; outp=
ut enabled
> > > >>           */
> > > >>          platname =3D regulator_names[BUCK1][PLATNAME];
> > > >> -       ut_asserteq(-EALREADY, regulator_autoset_by_name(platname,=
 &dev_autoset));
> > > >> +       ut_asserteq(-EALREADY,
> > > >> +                   regulator_autoset_by_name(platname, &dev_autos=
et));
> > > >>
> > > >>          /* Check, that the returned device is proper */
> > > >>          ut_assertok(regulator_get_by_platname(platname, &dev));
> > > >> --
> > > >> 2.43.0
> > > >>
> > > >
> > > > It seems that I have found a fix for this issue. Simon, please test
> > > > this commit https://gitlab.com/clamor-s/u-boot/-/commit/6149722aa48=
f84d9ea037ae990141a231106244e
> > >
> > > So this regulator problem was a tegra platform specific issue after a=
ll.
> > >
> > > Nice find, thanks !
> >
> > That's great! Are you planning to send a patch?
> >
> > Regards,
> > Simon
>
> I planned pull it directly via tegra custodian tree as an important
> fix. Please confirm if it fixes Nyan. Thanks

You should send a patch since pull requests cannot contain patches
that have not been posted :-)

If it has been posted, please can you send the link and I will test it.

Regards,
Simon
