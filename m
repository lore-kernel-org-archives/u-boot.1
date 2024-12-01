Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE022D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A452893BF;
	Sun,  1 Dec 2024 16:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AnUfQjxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58C9C893D0; Sun,  1 Dec 2024 16:23:37 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F1A89376
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so274266f8f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733066614; x=1733671414; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1d9/8E6zGaPPaKDKjM7xMbWDSsvpZZ6n7zKvCn8lZQ=;
 b=AnUfQjxNYx/K97V7YFZM7iWdQNMqWbHliXtmtm2C9LGfJ/CwZyJrzHK6XAzrIK6xxt
 2JyXK3mg5nbuCb6BTMzhpNZf8Gbf72DPHSKUvu3GIup3PMjJpxLCP/CfY3h4UkvB7nz9
 FDPzRMw1yrCzUbt4aQbdULDCL3SoKVtNjAjm69DVoou1aeIVSWjAHAuS9Sf2QA2ep5o7
 KrabzFDLjVYx7SPYDHWm2tgYYledPuxkZ/z4mvKE4UgRJ+dZIn9nkyApMBoncqL7AVXz
 K2z6PsgeONwjpvC2xuP93wCOtn7Jf9SyZ30LWeSvxvLy7fO64NwZfrQqbvcnXErgR/Lt
 jX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066614; x=1733671414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1d9/8E6zGaPPaKDKjM7xMbWDSsvpZZ6n7zKvCn8lZQ=;
 b=qbIder5Oqeh6eJMrDhEJgqLvQ2QQwlBDWXGklNym++dV/sNmqJyufCbNJexR1lDx3/
 LMNYL8lYSIVNEL5G71uML0sclZEkyEhM+/cTKumjhg3pj993jrUEq1dXC0vdpuSbfA76
 X4N8cJCDyFJcjmIfG/rWbsD8MFppaXyLQsPyWdbBj4opu/oDotvnQ0MLDidkF421ZMev
 ERDwkOlfcz5S53clKSwUXc/tPAhan238ncNq9uz8xxOO5Qd1FgrZgFX2CTxQqlqRsHCB
 72URWjwYGwziIZs6XtpcdgXh4OjmkjBRvceLN+nBYIqk3WSdh2vD4nWnH/Fq8dykQs/t
 zZ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWQTzNTYV2mLVjt6aa/OiC+tY9xMkNEiGp025HQiUq8IOtqwokRsPjn0pmszf7NFXKdAEXZyY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2+efX9e0MEEUsi1IMQbAUW3PBABCQEOlgGcvY5g98+MfB9Piy
 2Dp2Ws9g5GXt1uvfmDvgEZfQ24SbbOYuSnp+B0Jw0GzE/m20s/kVl4uspGyZs8+PKMuws0oYDDB
 B6zXsTi/5dQDuWyp0TiR04D7bu8E=
X-Gm-Gg: ASbGncujqOM16RwGQSFfOsJrfevbz3FE32mPTOZTe7MCxt7r8HQPYZWyZtEWZ3U0Ew+
 xKdpL4P1/iaMD/FKLRJdS0F+yEklJOMwM
X-Google-Smtp-Source: AGHT+IHwnTkNCF2MqgVlg+cSZxavh0uVLfsWdCkjKBPtnX8ajvYJY0ygAlpTWbWn5xiVReUx1wgrhEsme3eSorg9ZjI=
X-Received: by 2002:a05:6000:701:b0:382:511c:b994 with SMTP id
 ffacd0b85a97d-385c6eb8519mr16551684f8f.12.1733066614153; Sun, 01 Dec 2024
 07:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-3-sjg@chromium.org>
 <CAPVz0n0RGrgUSrNzyT16FKMBcqYs00qb+3jEHsq4tiYyWGR-Nw@mail.gmail.com>
 <65cef924-a16a-4af1-819c-a15410d92f4c@denx.de>
In-Reply-To: <65cef924-a16a-4af1-819c-a15410d92f4c@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Dec 2024 17:23:23 +0200
Message-ID: <CAPVz0n18LDW3yiQ+LTASros3tQt1coV9SdhQenwhayag_i0Zvg@mail.gmail.com>
Subject: Re: [PATCH 2/8] Revert "power: regulator: Trigger probe of regulators
 which are always-on or boot-on"
To: Marek Vasut <marex@denx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
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

=D0=BD=D0=B4, 1 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 17:20=
 Marek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 12/1/24 4:05 PM, Svyatoslav Ryhel wrote:
>
> [...]
>
> >> @@ -288,7 +289,8 @@ static int dm_test_power_regulator_autoset(struct =
unit_test_state *uts)
> >>           * Expected output state: uV=3D1200000; uA=3D200000; output e=
nabled
> >>           */
> >>          platname =3D regulator_names[BUCK1][PLATNAME];
> >> -       ut_asserteq(-EALREADY, regulator_autoset_by_name(platname, &de=
v_autoset));
> >> +       ut_asserteq(-EALREADY,
> >> +                   regulator_autoset_by_name(platname, &dev_autoset))=
;
> >>
> >>          /* Check, that the returned device is proper */
> >>          ut_assertok(regulator_get_by_platname(platname, &dev));
> >> --
> >> 2.43.0
> >>
> >
> > It seems that I have found a fix for this issue. Simon, please test
> > this commit https://gitlab.com/clamor-s/u-boot/-/commit/6149722aa48f84d=
9ea037ae990141a231106244e
>
> So this regulator problem was a tegra platform specific issue after all.
>
> Nice find, thanks !

Not a tegra specific but rather timing of calls. Regulator autoprobe
was called from board after clock setup but with your change regulator
probe now is much much earlier. This may cause disruptions on other
platforms as well.
