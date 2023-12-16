Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB944C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05BBE87BD2;
	Sat, 16 Dec 2023 19:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HkmeXvbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A9B87C69; Sat, 16 Dec 2023 19:48:42 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD6F87C79
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d2d0661a8dso14593647b3.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWZKZZOH1HlVUhQLPRqjMjlHLGOPxKKPS9vTyyAgFWk=;
 b=HkmeXvbUoeZY2BKsDu2Avsg5ZTHR4KqB4W91XjEUAAAq6XbLhpP3fwMM8WLTAy7S0i
 L5Rc0IfO78SBNx1NJJi1+gQKKRaQDoNT8C01M44vaHM0Lkq36M/vkZhwg4+43rSpQL3J
 hBKmPccydwCK/Lr9TVNSVDQETVSOUn7P07BzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWZKZZOH1HlVUhQLPRqjMjlHLGOPxKKPS9vTyyAgFWk=;
 b=GiBXS+qYEGBxGwpsOXN93Mh/uWphZFh8/QBxQko0aez/CFSXoMYg9BwNWj4/LEA9t/
 JuMtGB4qoau8EX8lsfuf0lohKNTKoocLUb7M0YyukhzH2WuvBcE0HPMmpOKiIjcYLBbz
 SLotYSmJin2W8zxGb8HGunGwj501pJLgc3mCOCyXzO6rDIYMaHKq//om/xJwBBcfrSlf
 LvnjHb++eoDeZIOUsTmxa9RfYB6cA5fVty/cnG+jytjSAxt5mf4oAvsaMgwhJTvjDIxp
 wTO2Ezy2WPVSpo9MeNsywDJRZ45di9WPdXUK/YOjJT7m+kkBl0DTye6XY4UA4faXVCp0
 VQ1Q==
X-Gm-Message-State: AOJu0Yy8xiS9LBneji6gnLpEzUcBIEIn1HBCX/WwYhk79L/dLU26mBS5
 06U95/AKstvG1ZdBptnb96f8xdbQqwK46f63QOZovgI3vqhPcWDUZwo=
X-Google-Smtp-Source: AGHT+IGR6V0y6WSbyOTCWkXE2hZKFkYB+boy7irxtOoWp3Ln0UlL2xzHjEBI1WIgyUzg5Qp7Ex7OiYQCcW6laB9CQ58=
X-Received: by 2002:a0d:d652:0:b0:5e5:b8ca:c68f with SMTP id
 y79-20020a0dd652000000b005e5b8cac68fmr373453ywd.41.1702752514146; Sat, 16 Dec
 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
 <20231113112309.730323-1-i@shantur.com>
 <CABEcMwUwDypY090MOYSEtBGMRZOBnTk6hKuM2-OcJW-n+M7OHg@mail.gmail.com>
 <20231211205326.GX2513409@bill-the-cat>
 <CAPnjgZ23x6dAwq8UDvTXBikRgC3mbTfH5PV=KVF45pFPXY3cQA@mail.gmail.com>
 <20231213202951.GH2513409@bill-the-cat>
 <CAPnjgZ2=P-kmGFEO0k_fp=XVps0YC16YJ_+yAqk4xVz0CGYz=g@mail.gmail.com>
 <CABEcMwVbb-6670ESQJKFva_jnSPQMzCrzrscDmwnGvQqhXHMSw@mail.gmail.com>
In-Reply-To: <CABEcMwVbb-6670ESQJKFva_jnSPQMzCrzrscDmwnGvQqhXHMSw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:07 -0700
Message-ID: <CAPnjgZ1dvG9visuy4TtnAk9VSnmE11ba-qPOwgZw47b24L+0qA@mail.gmail.com>
Subject: Re: [PATCH v4] arm: dts: rockpro64: Add RockPro64 smbios
To: Shantur Rathore <i@shantur.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, jagan@amarulasolutions.com
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

Hi Shantur,

On Thu, 14 Dec 2023 at 07:14, Shantur Rathore <i@shantur.com> wrote:
>
> Hi,
>
> On Wed, Dec 13, 2023 at 8:41=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Tom,
> >
> > On Wed, 13 Dec 2023 at 13:29, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 12:50:06PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 11 Dec 2023 at 13:53, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Dec 11, 2023 at 08:42:19PM +0000, Shantur Rathore wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Mon, Nov 13, 2023 at 11:24=E2=80=AFAM Shantur Rathore <i@sha=
ntur.com> wrote:
> > > > > > >
> > > > > > > Add smbios information for Pine64 RockPro64 board and enable =
in
> > > > > > > config
> > > > > > >
> > > > > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > > > > ---
> > > > > > >  Changes
> > > > > > >  v4: Change PINE64 to Pine64
> > > > > > >  v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig
> > > > > > >
> > > > > > >  arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 +++++++++++++=
+++++++++
> > > > > > >  configs/rockpro64-rk3399_defconfig        |  2 ++
> > > > > > >  2 files changed, 24 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch=
/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > > > > > index 732727d9b0..089732524a 100644
> > > > > > > --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > > > > > +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > > > > > @@ -9,6 +9,28 @@
> > > > > > >         chosen {
> > > > > > >                 u-boot,spl-boot-order =3D "same-as-spl", &spi=
_flash, &sdmmc, &sdhci;
> > > > > > >         };
> > > > > > > +
> > > > > > > +        smbios {
> > > > > > > +                compatible =3D "u-boot,sysinfo-smbios";
> > > > > > > +                smbios {
> > > > > > > +                        system {
> > > > > > > +                                manufacturer =3D "Pine64";
> > > > > > > +                                product =3D "RockPro64";
> > > > > > > +                        };
> > > [snip]
> > > > > Yes, we should just defer this and pickup the SMBIOS series that =
Ilias
> > > > > has posted.
> > > >
> > > > I don't think it is a suitable substitute, it is just a fallback.
> > > >
> > > > So I believe this patch should be applied.
> > >
> > > Please note that this patch is adding _less_ details than the top-lev=
el
> > > model field contains today for the platform.  The only difference is
> > > "Pine64" vs "pine64".
> >
> > The top-level model is "Pine64 RockPro64 v2.1", I believe. But:
> >
> > - the first part of that is the manufacturer, not the product
> > - the second part is what we have in this patch
> > - the third part is the version
> >
> > SMBIOS tries to split things up into separate fields.
> >
> > So, perhaps a new version of this patch could add:
> >
> >    system {
> >      version =3D "2.1";
> >    };
> >
>
> I can add the above or any more details needed to a new patch
> Will that be enough to make it merge-able

From my POV, yes. Having dug into this a bit, patches like this are
the only way we can get authoritative SMBIOS data. There are various
user-space workarounds, but these should not cause any problems.

Regards,
Simon
