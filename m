Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD0FD49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6038E894C0;
	Sun,  1 Dec 2024 16:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VjUtF+RU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D3B894C0; Sun,  1 Dec 2024 16:51:59 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 409CF89189
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434aa222d96so42623055e9.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733068317; x=1733673117; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gP8jpjyMHZ95ybnd+GXX4F1xH2H9nzOIoM1/DWUwoqE=;
 b=VjUtF+RUOaFDTUr1r/wmMR3oFjHCxyASSvs3Bxm7YFpzwT4+zozdUsrFtXI9//Qw+t
 6zjYPagvcCRhNVaZA0q1I2AhZP7RJ+6d4VzUv4OlF0LiARx0Y6oEOmBAmL3T10k/FJaV
 //xuGKxVK2NZCd+/KnaFUtjvhfDsFz8ECmiaCoKAASMRy2CNyEl5hNNskzev4K0MzrEC
 hs2iF8FfeUDJaMgjEbkxkpk6NTCric/yNBnryN8V+BUiEPpmHBOrrV1ziNQ5fii8ujFx
 osjOcYedzG2lKupbYiccM6DnDKap0FFbBkUzvVKU1CNld3DBeZbytVVcCdb82tlhj4y4
 irKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733068317; x=1733673117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gP8jpjyMHZ95ybnd+GXX4F1xH2H9nzOIoM1/DWUwoqE=;
 b=YIMkzxDWOTSTNQY50VfZYwfhtvWdAhJljUjGQ86ItRKOEjFGILXAb5a37kyEKlHb4+
 x1Iemcnipimg1Shzvf1ITG4jNn0coNTlz0J32VpVA6HSOv0V0unn/GmSMVs/gVmkZN1f
 OYVivPGn6h4s8FcphMkHdKHFGTx1Ei6tmfEoZNRgWU3He0SMdKKAIxF5xwvYcOeuQgK/
 qjXR2TFF/zwfOPJVqlA/FMq4JqynpFpntXrzO3rS8O3v38IzB++wZjGf+e+DSrFJh+qg
 RMw3OGh2zpYX66sW0Z/euONveBYUPRpZ7JLRki0fp3XfXGC9gFFOSOirrTviD4gQBuP3
 Ttvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfvJH8lxSBe0VXC4m1YO4nmn573agzFa8ZgAfcClBGM2EiAYha3OKTbExIoRUQ8eMqkiupwDs=@lists.denx.de
X-Gm-Message-State: AOJu0YwCn6gY+2FrNH17+JMXQDyU+wsrx1HPRWVoWrvES/bcMn6kIRl8
 CQtU6KVeOS9so6Y2XinHjbrB3Ng9kpkqG7YD9IK4ycGhcgs8M2NCelxas4QfBtLCX4FYkbzggr8
 ZdDbJeKjlGu8tj1T2k2Yxbd8GfvA=
X-Gm-Gg: ASbGncsNrvhz6cQxzGLts3TsZNvcLKJiY6jZOKhi3PhpayeDcfJuvDKyVAMkut9haAB
 9F+eB0nrFdxeWvH2YVrEL0djZoGf5x5VK
X-Google-Smtp-Source: AGHT+IEao4X4Cq2P5ZPOEit1xoRQjVi1+xVjiW/0Ca2j/pOFbfOO+bh+K+KvF52Rg21xfWdtjkvnlv5FlNUZCC0xGcs=
X-Received: by 2002:a05:600c:1c93:b0:434:a852:ba77 with SMTP id
 5b1f17b1804b1-434a9dcec68mr218735135e9.15.1733068316625; Sun, 01 Dec 2024
 07:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-3-sjg@chromium.org>
 <CAPVz0n0RGrgUSrNzyT16FKMBcqYs00qb+3jEHsq4tiYyWGR-Nw@mail.gmail.com>
 <65cef924-a16a-4af1-819c-a15410d92f4c@denx.de>
 <CAFLszTg1Na9ziMv4J1Pb9vjw=fYPh+RLGvT-KyYcjGEEonGk2Q@mail.gmail.com>
 <CAPVz0n25b5fQcmp-wW1AmUNtcVXjzNvTHSbjK-wn_p6jpDRzMQ@mail.gmail.com>
 <CAFLszThvnBaOvqNPOxXKHtZy2rwcHAxU+RgOw6dHGmzWOZ4_8A@mail.gmail.com>
In-Reply-To: <CAFLszThvnBaOvqNPOxXKHtZy2rwcHAxU+RgOw6dHGmzWOZ4_8A@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Dec 2024 17:51:45 +0200
Message-ID: <CAPVz0n062d9AiaR8bBX1XkGLwh8a49fLiCz4b3eUQwem4SA-EQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] Revert "power: regulator: Trigger probe of regulators
 which are always-on or boot-on"
To: Simon Glass <sjg@chromium.org>
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

=D0=BD=D0=B4, 1 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 17:49=
 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Sun, 1 Dec 2024 at 08:24, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> >
> > =D0=BD=D0=B4, 1 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 1=
7:23 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > On Sun, 1 Dec 2024 at 08:20, Marek Vasut <marex@denx.de> wrote:
> > > >
> > > > On 12/1/24 4:05 PM, Svyatoslav Ryhel wrote:
> > > >
> > > > [...]
> > > >
> > > > >> @@ -288,7 +289,8 @@ static int dm_test_power_regulator_autoset(s=
truct unit_test_state *uts)
> > > > >>           * Expected output state: uV=3D1200000; uA=3D200000; ou=
tput enabled
> > > > >>           */
> > > > >>          platname =3D regulator_names[BUCK1][PLATNAME];
> > > > >> -       ut_asserteq(-EALREADY, regulator_autoset_by_name(platnam=
e, &dev_autoset));
> > > > >> +       ut_asserteq(-EALREADY,
> > > > >> +                   regulator_autoset_by_name(platname, &dev_aut=
oset));
> > > > >>
> > > > >>          /* Check, that the returned device is proper */
> > > > >>          ut_assertok(regulator_get_by_platname(platname, &dev));
> > > > >> --
> > > > >> 2.43.0
> > > > >>
> > > > >
> > > > > It seems that I have found a fix for this issue. Simon, please te=
st
> > > > > this commit https://gitlab.com/clamor-s/u-boot/-/commit/6149722aa=
48f84d9ea037ae990141a231106244e
> > > >
> > > > So this regulator problem was a tegra platform specific issue after=
 all.
> > > >
> > > > Nice find, thanks !
> > >
> > > That's great! Are you planning to send a patch?
> > >
> > > Regards,
> > > Simon
> >
> > I planned pull it directly via tegra custodian tree as an important
> > fix. Please confirm if it fixes Nyan. Thanks
>
> You should send a patch since pull requests cannot contain patches
> that have not been posted :-)
>
> If it has been posted, please can you send the link and I will test it.
>
> Regards,
> Simon

Alright
