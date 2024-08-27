Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC430C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 19:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1924288A27;
	Tue, 27 Aug 2024 21:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gOuvitPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B63988A30; Tue, 27 Aug 2024 21:28:59 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9654E87B84
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 21:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a86883231b4so771894266b.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724786937; x=1725391737;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBP1I/3nu2YJ23hqoe69PJx8KMY/ljPaN87fmN+MvhU=;
 b=gOuvitPZl2LdFPbt0qUGTbTVp3e0KA2GvkBNTn6AQX7AMV9T/5RFS5AwHdb1RRYdJ4
 w7i6nIv7HyiRnFH19trTPp4T6kHXt9PMlYAWoPw8jenRAP9xFX1nMTafJhk7cGgxUVVr
 sfH18cfh42fMdDw+9Bf8KiDFp1MSEf7b3qrCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724786937; x=1725391737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBP1I/3nu2YJ23hqoe69PJx8KMY/ljPaN87fmN+MvhU=;
 b=iIPVReHWO+EaP5R1VvjEmpoxXOq5MOKtVef+rCX4ekbjr7GZu1gnXvGQ6U50hyG7Ps
 uGEjek4Q/hwF82DQOQOPKtNxeMvF7WFaX9GlkP0LgmaIzwLkECvLkIkZ6ub+CameWwMM
 qPQ8ns9NB8Nb7FvML+LEJZ6I++ezvjAvYMy8bTcSi/T3iEbzem5PY0Je+Ol0riyngcCn
 nW/gDCDTChEc7x79xW5b+hU6lOOSYcT0a5KCYM1wTlYUjyMzPbbSjdDbw8dZMeeHtKLt
 H1SUEIYGR5quVRy2lPBFEuZ4VAmUw7J4D1wLZl6k+8nOZFjINxdMqiAtvVgHnzIJY+wS
 zNzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0QOGMKt74o+ClHtkrnPQxLeK6P/IRmfBG7Nd3bvOx9w7QkvUYXDxhhnILdY6mwfNTSwK5wpA=@lists.denx.de
X-Gm-Message-State: AOJu0YyHvZ/Qh/tqL4EhAyUF9FKnEtzJm/rjOksH5X0FAHtIXkArOmMG
 fhFIVcc3PUDI1Z9S52eMaHABujd/MloJ8qEra0vS/f6oFNkdstIXGOHDxLE7ddoxKPYGeJOHLRL
 gGtWoERhN1z8UB17krBB77FIbMml2+kpOT7DQvw==
X-Google-Smtp-Source: AGHT+IE/NjcrVYGYkbJzgalyTzOifsz1dyiImW8VY1sSBJwdtQXaOJi4ZSSSzQ30N4u7CNhbEiNiIRhsIq6j5haeeNo=
X-Received: by 2002:a17:907:1c27:b0:a77:b5c2:399 with SMTP id
 a640c23a62f3a-a86a52cb189mr1035360966b.31.1724786936536; Tue, 27 Aug 2024
 12:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
 <20240827165025.GN2479150@bill-the-cat>
 <CAFLszTgD6aeYziHHJrsbYgP+eWTR6GJ+BJNvoitPZCyJpyV-8Q@mail.gmail.com>
In-Reply-To: <CAFLszTgD6aeYziHHJrsbYgP+eWTR6GJ+BJNvoitPZCyJpyV-8Q@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 27 Aug 2024 21:28:45 +0200
Message-ID: <CAOf5uwk2SQZ5TkZgoacyRL0FJY_pRGqko_7AKesnJb-jeUQypw@mail.gmail.com>
Subject: Re: xPL terminology
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

On Tue, Aug 27, 2024 at 9:25=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tom,
>
> On Tue, 27 Aug 2024 at 10:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Aug 25, 2024 at 07:07:23AM -0600, Simon Glass wrote:
> >
> > > Hi,
> > >
> > > We have the term 'SPL', which has a dual meaning. It is both a
> > > particular phase of U-Boot (the one that loads U-Boot proper) and a
> > > generic name for any pre-proper phase.
> > >
> > > You can see that in a few areas, but for example CONFIG_SPL_BUILD is
> > > enabled for TPL and VPL builds, not just SPL.
> > >
> > > I propose to rename the generic term from SPL to xPL (meaning any PL
> > > phase), leaving SPL to just refer to the phase before U-Boot proper.
> > >
> > > The symbol would be CONFIG_XPL but in documentation we would talk of
> > > xPL, with a lower-case X, so it is more obvious that it refers to any
> > > phase.
> > >
> > > What do you think?
> >
> > I still worry this is just another part of the long symptom of needing
> > to re-work how we configure / build as we have 1 case of "build things
> > this way" (full U-Boot) and N cases of "build things another way" (SPL,
> > TPL, VPL, UPL?). And really we need a way to short-hand
> > "fooboard_defconfig" means "fooboard_spl_defconfig +
> > fooboard_tpl_defconfig + fooboard_SOMETHING_defconfig".
>
> IMO my XPL series does this, at least for some definition of this. I'd
> really like to get that in as it would make all of this much easier.
>
> >
> > But on the flip side, I also suppose replacing CONFIG_SPL_BUILD with
> > CONFIG_XPL_BUILD would be less confusing.
>
> Yes. What do you think of E's idea of renaming all the options? I
> quite liked it when I read it, but now I am thinking that having
> everything be xPL is quite a nice convention. If we have SETUP_... and
> TINY_... it is less clear that they are related.
>
+1
I just prefer CONFIG_XPL_BUILD change, or people need to change slides ;)

MIchael

> Regards,
> Simon



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
