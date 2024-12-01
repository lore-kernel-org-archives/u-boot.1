Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438A3D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C906388DB5;
	Sun,  1 Dec 2024 16:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Am+O7IRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367E489376; Sun,  1 Dec 2024 16:24:57 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D301788D51
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385e06af753so1105745f8f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733066694; x=1733671494; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=As2doF88mwliQ7su/upY0aGZAefJaUDjWSQLOFzw+7Q=;
 b=Am+O7IRRVxD189gDbbJfjAc9NiI8myGExG19cUw/mcODZAC2nmlcpm8ZQFgUqlc9er
 11h98/ukfjfV09tIq2Ne+UU7KBXAlufjQLHyBxPgxEkYUakogB4TCzQEMx9u5XAGIbQZ
 rUXrTpHiClR5fI1O++LPZzjBpLW/CkDtGsyhHMcOG43AP/KmUd9bkJT9j4WXX1FZ+JSQ
 x+U88UmlsaTUymlbASh4cB7g+81lunarGIFW8yx1gv/s9Io5AXq214++ZYhnab8ZNkAo
 NCWLsrQI3loM/PxZoDY/Cyof9dMJ67u3uPU1ilj6HTOyESvk31ibusBcgPsAjrXLb4EX
 yPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066694; x=1733671494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=As2doF88mwliQ7su/upY0aGZAefJaUDjWSQLOFzw+7Q=;
 b=gD81rz5GNqoitkpPgU/ZeqvLK48jpznwc+87OYXqtNIlICJ1pVWHLdi5YJSdxhvRrG
 /Es9q19xyyeHYf8dSaD/VY8aWUwqmuSDYeUdf/cS+vU/QnAQGVIKFNmnZTceuaz31yfb
 435dK/7sND97XO5Yr7i8CwKATeB+x2s6gCksYF0v0X3gjDMQahLbJcjjitj/7e7C9Gum
 nsQ2xc8+/4+nCjEoVzK1TxJ7bANqld4kt224PaxBwiKKOhlvN77+3s0nqCmJg6vhiKGr
 SFMNf4n0TjxeN6HhTuHSP23P2+mTJ6rOnyo7UqIsixGV4Bg0etJ7bzmuyHsVaYxIliGl
 kzLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIQdu9Gs9dWvRV+NC5FmbInJWUgxWyTyelSObneWWj5PLAADfH5qTRQqBqSGJrti9rSI+9OGU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1qSOmPP/47sI1ueLzxxkZ1h/rUwieR1L3OqqRU8gsstrGpJs2
 wX49TsoywUpHgGvk9M5m7TBJKe+ASb3WIJhipiuwtaqN49aF8QHgvnTaQlqm04NwgwMLqOXzz3c
 qVIBugHSCd0BTNwH43lQFEf41bLw=
X-Gm-Gg: ASbGncvD+jOpMWH+MLB0rGMJ+y72yrW6HRsTLGO1P5sioEGXpvHZ/0Zmt5Hr9WaIN/r
 Bs7TUzW5846bwnmbLmAjmLijz8hH/toSx
X-Google-Smtp-Source: AGHT+IG+lNWa+L04ToSkHA7idRhAROpj3Ik5YX3PFseL2pUlWLR9vuIW6Qi8ADj7Wmxyv3J9+t7qkHSo3l9EHpI3EE4=
X-Received: by 2002:a05:6000:1541:b0:381:ec32:3f71 with SMTP id
 ffacd0b85a97d-385c6eddc42mr16058374f8f.44.1733066694064; Sun, 01 Dec 2024
 07:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-3-sjg@chromium.org>
 <CAPVz0n0RGrgUSrNzyT16FKMBcqYs00qb+3jEHsq4tiYyWGR-Nw@mail.gmail.com>
 <65cef924-a16a-4af1-819c-a15410d92f4c@denx.de>
 <CAFLszTg1Na9ziMv4J1Pb9vjw=fYPh+RLGvT-KyYcjGEEonGk2Q@mail.gmail.com>
In-Reply-To: <CAFLszTg1Na9ziMv4J1Pb9vjw=fYPh+RLGvT-KyYcjGEEonGk2Q@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Dec 2024 17:24:43 +0200
Message-ID: <CAPVz0n25b5fQcmp-wW1AmUNtcVXjzNvTHSbjK-wn_p6jpDRzMQ@mail.gmail.com>
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

=D0=BD=D0=B4, 1 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 17:23=
 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Sun, 1 Dec 2024 at 08:20, Marek Vasut <marex@denx.de> wrote:
> >
> > On 12/1/24 4:05 PM, Svyatoslav Ryhel wrote:
> >
> > [...]
> >
> > >> @@ -288,7 +289,8 @@ static int dm_test_power_regulator_autoset(struc=
t unit_test_state *uts)
> > >>           * Expected output state: uV=3D1200000; uA=3D200000; output=
 enabled
> > >>           */
> > >>          platname =3D regulator_names[BUCK1][PLATNAME];
> > >> -       ut_asserteq(-EALREADY, regulator_autoset_by_name(platname, &=
dev_autoset));
> > >> +       ut_asserteq(-EALREADY,
> > >> +                   regulator_autoset_by_name(platname, &dev_autoset=
));
> > >>
> > >>          /* Check, that the returned device is proper */
> > >>          ut_assertok(regulator_get_by_platname(platname, &dev));
> > >> --
> > >> 2.43.0
> > >>
> > >
> > > It seems that I have found a fix for this issue. Simon, please test
> > > this commit https://gitlab.com/clamor-s/u-boot/-/commit/6149722aa48f8=
4d9ea037ae990141a231106244e
> >
> > So this regulator problem was a tegra platform specific issue after all=
.
> >
> > Nice find, thanks !
>
> That's great! Are you planning to send a patch?
>
> Regards,
> Simon

I planned pull it directly via tegra custodian tree as an important
fix. Please confirm if it fixes Nyan. Thanks
