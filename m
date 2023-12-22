Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D181C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 12:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7957487874;
	Fri, 22 Dec 2023 13:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="FO5exVKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71B287876; Fri, 22 Dec 2023 13:09:58 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0B787858
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-466a85a7e22so514508137.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 04:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1703246995; x=1703851795;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1fQecBIzuUpCeHOWvp5tHI0cAwnqx1iuQpIQcMwC04=;
 b=FO5exVKDPcIfK+glsYWfi8BKkb3HLbkKlVQLspsjItJKO7rtXZjRZlwWph+Rg91nYA
 tWp7CjmhmDiFWl39jUJReTc7jwue3TUylKambjrD2LpR2LnHbeCpSNsmrKkOsBJExcMr
 2ehrOUfC5bSV1Yrc1M54lAwvD+xEwm7tJ2fxjtuDRs+HN/85rgzVMpNBGNlubysyMplN
 OH2KlMcNkNhBEWD1/PGTbMNNM2L50Ng3aNumJ3IVJqTCHwu9t5IFcJS2W/IyxXQG/xpw
 rwx40GU+bZw9v2Qlocg48wX8HXJEP/BMCiE0UpZnfutp9uwdd6oq+uw43Va7uI0OK7kN
 xsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703246995; x=1703851795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1fQecBIzuUpCeHOWvp5tHI0cAwnqx1iuQpIQcMwC04=;
 b=vjeOJQX1q2TkVXC9wegNGy15oCKHegTv0Dp/iWu5+YDpUI8OR1u2iUUjqSQG8eJpSr
 6bJmSzCfBHz8TTIVQ2nCFj+KUNq4eLo0jUjda/4hgJ2edxOQ6m2JdGydtKdrdAbCemtu
 BDfX4o4/1irFD2yXXsV2BnL6jBomNK35o0ymbeqIy/2+7Iw6Wrp9OCXAfaaStdUFyPZc
 N4L8SK8RB0gPuqDMAlcIzDNmkRSrVxwofqYD7OXO0vXPlkKzTmvH7YMS8CHnlVZwElQr
 ebThSghM0oKTI/j9nkZHD1cu/RpK3J9tj8CfbWO0xISxd6HDv/4fB9v06ZT3QUSZh6Bh
 mX1w==
X-Gm-Message-State: AOJu0Yz8ung57ChXFIofDpu1ZMJmL8nSAIVNsh6U/x+8GLmAyx5SqjLH
 7JTLtNLATaMTe5aJMYP37kiK/+sGj/Qb1l5HEUStpLc6LZq86A==
X-Google-Smtp-Source: AGHT+IGVi40hGIstRswy88cCRg7Kyo7VEDqXoPUosAp7V0J3P008HCcIqSPY5MMMlOSHG4PgmNCboU4+At6x3/VG61k=
X-Received: by 2002:a1f:ee47:0:b0:4b6:d1da:5bd1 with SMTP id
 m68-20020a1fee47000000b004b6d1da5bd1mr632787vkh.2.1703246995262; Fri, 22 Dec
 2023 04:09:55 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
 <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
 <20231209205627.GI2513409@bill-the-cat>
 <CABEcMwXYCczbTRVgqGC=USRJw138tDM0RkbmGoR4zSY7pBj1PA@mail.gmail.com>
 <CAPnjgZ3gEoOFxahZ2mg=MTQTmBPyCBphS8uVcpSSwq2bg4eJwQ@mail.gmail.com>
 <20231211181918.GS2513409@bill-the-cat>
 <CAPnjgZ3+yJCNgO635gSsDbrb-BpQvJTOqo4qHoWxunvbHZ8jyQ@mail.gmail.com>
 <20231211182710.GT2513409@bill-the-cat>
 <CABEcMwUuoHp2JWDkPacadL1X3-x9wVKH-OZuYx6Cvx_kWCCNUw@mail.gmail.com>
 <20231222120700.GW2513409@bill-the-cat>
In-Reply-To: <20231222120700.GW2513409@bill-the-cat>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 22 Dec 2023 12:09:44 +0000
Message-ID: <CABEcMwU521x5_JMsZkGS-hnr2B+w8SNA31-7VXfwo3aPrXytwQ@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
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

On Fri, Dec 22, 2023 at 12:07=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Dec 22, 2023 at 12:05:39PM +0000, Shantur Rathore wrote:
> > Hi all,
> >
> > On Mon, Dec 11, 2023 at 6:27=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Mon, Dec 11, 2023 at 11:22:45AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > [snip]
> > > > > I think in hind-sight too much stuff is omitted without BOOTSTD_F=
ULL.
> > > > > The option itself then enables other stuff too by default, but so=
me
> > > > > parts of the bootflow command itself should be visible even witho=
ut FULL
> > > > > to make things easier on the user.
> > > >
> > > > At the time the goal was to avoid growth compared to the distro
> > > > scripts. We could perhaps add some more things in with BOOTSTD_FULL
> > > > but still have it as an option?
> > >
> > > Right. But now that we've tried this, some of the feedback has been t=
hat
> > > it's just too minimal right now. Like looking at the help message for
> > > bootflow, list and info should probably always be available. And mayb=
e
> > > the flags for "scan" should be re-thought? Too late to change things =
now
> > > but "bootflow scan -b" should maybe how it's always been for "scan an=
d
> > > boot".
> >
> > What would be the preferred approach for this patch?
> > Is it to update the default capabilities of bootflow or we can have thi=
s patch?
>
> Well, I don't see a problem with just adding this to the platforms which
> enable BOOTSTD_FULL until we can rework what's included/excluded by that
> flag, and there's an issue filed for it now.
>
> --
> Tom

Great,  can we have this merged in please then [0]

[0] - https://patchwork.ozlabs.org/project/uboot/patch/20231119172310.13079=
42-1-i@shantur.com/

Regards,
Shantur
