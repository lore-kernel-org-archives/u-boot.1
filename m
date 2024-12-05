Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27AFE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5101189560;
	Thu,  5 Dec 2024 20:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZGVeUzZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6878889557; Thu,  5 Dec 2024 20:55:27 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B7D8954C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d10f713ef0so4428687a12.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428523; x=1734033323; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYwn4lvlxQnNmGg1NU3P2jkNeDmSPAHtVgQ+PaXJNPE=;
 b=ZGVeUzZF6ln9xfxp7HEbDF5lLG1fXI35Ups2bL2ro5dzPrihC02ZIWXm8qRw3zAS8b
 3K8ok0XUESERzM0/mOT0QGpabmPukjegsCjCuZqNc8scu7JxqEY098AMIL26xm9f/iV1
 UktVv4Db6//E79cmpZ2ioDiXlzIy90OwJLm9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428523; x=1734033323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYwn4lvlxQnNmGg1NU3P2jkNeDmSPAHtVgQ+PaXJNPE=;
 b=W1DzWujsojfekzkii16XdC+zRJwxDHxaZMsmvCbdGktUhrgquph8lW0hQsJ5Xcqbq3
 JGl5tiyPZx0NaxgAV2ae+7pbuNykAJCL9RNCa1DkYSEFTQf6ctyOHbr6HJ60WHqKwBX6
 /5EnHgTc/Ip1DY2tEnfcckUehJynVmJHKsbNXicNmvY/5IOglNpc3sDnyvqEKX1YurYA
 siG7kYwqKXov3PUZCQpXPX0RGvHdxi3wy2eUn1zwe8qzNVxKzCaRvA5gTkQyrKFODA0M
 +cFTqN7p//luP29sYaA9vj+kHoV1lyzPpvhO1tlnG1HxNUEZNFJeq3WGNjZIxUJdEiB5
 QXEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX745dPyYl0RnVKzuF0Y+ai2lGqZqc5J1iJTa6y8pd1ZowNeIp2bHwyeDsBykQzVcGmJSQRHLg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0pgjLDGz6vFNcrRfUIDM9hbmC+joxf3hqW0oSRzZrO07D3Po1
 kaJl7dBw9lErkuZmssucWHkoosOWRtM5widjmyljT7MAnTaptukQ01FgFIRyue/4YdH/lcYahQS
 soJvu+SfZsfeOA66xNmq4N2ZSDcOSzpmCOa+k
X-Gm-Gg: ASbGnct9vC3JdT3vZZ0cj1+2OqEvKX/oVCliCCUZSpe869WN50Vu7LkAV/FEVOJnOmT
 LzwFWiC1vr07jzA3+1zDnDU22yUd+67Q5
X-Google-Smtp-Source: AGHT+IFnLStTV+crKHr5tn7GMdp52kRhUL3eTVsyOKKlMAnx2wQInOFHgzntHCeh7bKCwNItHKOsWtMywvM9HcXdppc=
X-Received: by 2002:a17:906:1baa:b0:aa4:e53f:5fbe with SMTP id
 a640c23a62f3a-aa637474a7amr52147266b.19.1733428522935; Thu, 05 Dec 2024
 11:55:22 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 11:55:20 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPVz0n062d9AiaR8bBX1XkGLwh8a49fLiCz4b3eUQwem4SA-EQ@mail.gmail.com>
References: <CAPVz0n062d9AiaR8bBX1XkGLwh8a49fLiCz4b3eUQwem4SA-EQ@mail.gmail.com>
 <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-3-sjg@chromium.org>
 <CAPVz0n0RGrgUSrNzyT16FKMBcqYs00qb+3jEHsq4tiYyWGR-Nw@mail.gmail.com>
 <65cef924-a16a-4af1-819c-a15410d92f4c@denx.de>
 <CAFLszTg1Na9ziMv4J1Pb9vjw=fYPh+RLGvT-KyYcjGEEonGk2Q@mail.gmail.com>
 <CAPVz0n25b5fQcmp-wW1AmUNtcVXjzNvTHSbjK-wn_p6jpDRzMQ@mail.gmail.com>
 <CAFLszThvnBaOvqNPOxXKHtZy2rwcHAxU+RgOw6dHGmzWOZ4_8A@mail.gmail.com>
Date: Thu, 5 Dec 2024 11:55:20 -0800
X-Google-Sender-Auth: Qf_Yeu6Gg-AeaMGxInHEThJL98E
Message-ID: <CAFLszTg0+mGygLSBa=Xrp4LeYfP=46697R5dnH_T-ruLYKCWsg@mail.gmail.com>
Subject: Re: [PATCH 2/8] Revert "power: regulator: Trigger probe of regulators
 which are always-on or boot-on"
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Marek Vasut <marex@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
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

Applied to ci/master, thanks!
