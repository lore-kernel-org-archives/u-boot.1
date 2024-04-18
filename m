Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E2BC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 06:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB9A588524;
	Thu, 18 Apr 2024 08:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DNnrOW6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D61D088526; Thu, 18 Apr 2024 08:56:02 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B7F884F3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 08:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6184acc1ef3so4719797b3.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 23:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713423359; x=1714028159;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdfXDJlwXmZMcVSIhg3nnMmJ9i7zWwfCOCHFZcmR1Zw=;
 b=DNnrOW6LSDF9xJywSTR+mMECMv5PU/66VzYwchNv4fh9a2cCAorWtTTgkZS/a834mK
 XIKAbi2ojQR48Ky8jjfTwHDbFYiEJh8rFMvbNOK3eHnOEdv86jHeQgWTidycoV7e6AYz
 MoABDg8twFqO3URRvSaEFx9wcrWVEx3uou4pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713423359; x=1714028159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdfXDJlwXmZMcVSIhg3nnMmJ9i7zWwfCOCHFZcmR1Zw=;
 b=WMX9TY89OOhAXbaAKiT9FjWuH6F66IcnJcrB5oirsb/G5dLyGepzaghxue4lbEJyFu
 f5byt5/vbhL2yFmF++5bXssVWOJb7AA8DxfMXnSTlpFA1LCTM3lIBK/e7MhaIWuZGA/b
 t5bhAvtPo61KVaqloHfLMstknXn1dIDpqXe/a97JFj1Px4nStTUwdKqJk9SB4+QNuUez
 pwZEFzqmRRdllYnIkFKkc/B3vx6Cjm595o5tgpveJI92QKzMlie3cryvN8Z7os5WHd02
 NE3hA0V7/3mcL3voy+eGetKxD+Em/2OcfrEBSJ8oqzkpXmP35RA4lJezipjfRiR8tUpT
 EGgQ==
X-Gm-Message-State: AOJu0Yw4KmLjD//whfEvdbiRlNOm26pKkbThDBWYGbN+7SORf2I9pq9m
 rmnlj/Cv+VoBplGmvFRONg3GBDWUkjYBs42Q51wyl4bMfjVjRPX33+n9jt5ndul9i5yehZF5I4e
 TRs7x8ubF3UWWYwHob46OAR1ZlrmIvwVtQX1kog==
X-Google-Smtp-Source: AGHT+IHvyjAvHHJZwJQlhAxCyrl3S980BVT8lbmDWvk0IRlwmgJ8WSUTY6Wwuf7m6qtYzTr0mzHd/2Jt/suoeYo6ll4=
X-Received: by 2002:a05:690c:6386:b0:618:9353:1023 with SMTP id
 hp6-20020a05690c638600b0061893531023mr2276359ywb.17.1713423359466; Wed, 17
 Apr 2024 23:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231130112405.92196-1-avkrasnov@salutedevices.com>
 <fa9fc4cc-892c-7c11-877b-330bf173f3bd@salutedevices.com>
 <f79d88f4-0d2e-1d78-065a-5a1f2f2deacf@salutedevices.com>
 <c150440e-191d-bce8-3b99-401186be507f@salutedevices.com>
 <180478dc-23ec-952d-e1ae-6f16d98bd16c@salutedevices.com>
 <969ce8dc-3726-cf66-3241-5eb06f9cb85f@salutedevices.com>
 <CAOf5uw=2hicHHOP1caASJoqmOpZ9vvE3ZMnVQqXxQ0eqbm-CMg@mail.gmail.com>
 <3142650d-4868-c6cf-2555-301e41fadbe4@salutedevices.com>
 <CAOf5uwkmPq4pU0RY-fQtt7Qn5dzpHSf7rr_z5yrepmgP4wRADw@mail.gmail.com>
In-Reply-To: <CAOf5uwkmPq4pU0RY-fQtt7Qn5dzpHSf7rr_z5yrepmgP4wRADw@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 18 Apr 2024 08:55:48 +0200
Message-ID: <CABGWkvqxBRhjRFC3szz_WGJmHyzx1ihRADr04f47k+8SRqjFBQ@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, oxffffaa@gmail.com,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jaime Liao <jaimeliao.tw@gmail.com>,
 Jaime Liao <jaimeliao@mxic.com.tw>
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

Arseniy, Michael, All

On Wed, Apr 17, 2024 at 8:44=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> Dario did you add those patches in CI and test them again?
>
> Michael
>
> On Wed, Apr 17, 2024 at 8:44=E2=80=AFPM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
> >
> > Hello,
> >
> > Sorry, pls ping
> >
> > Thanks, Arseniy
> >
> > On 13.03.2024 09:46, Michael Nazzareno Trimarchi wrote:
> > > Hi  Dario
> > >
> > > Can apply this series and put in CI?

Sorry, but I mistakenly tagged it as 'superseded'.
I just pushed it to my nand-next branch and I'm running the CI now.

Thanks and regards,
Dario

> > >
> > > Michael
> > >
> > > On Wed, Mar 13, 2024 at 7:43=E2=80=AFAM Arseniy Krasnov
> > > <avkrasnov@salutedevices.com> wrote:
> > >>
> > >> Sorry, please ping
> > >>
> > >> Thanks, Arseniy
> > >>
> > >> On 11.02.2024 02:16, Arseniy Krasnov wrote:
> > >>> Sorry, pls ping
> > >>>
> > >>> Thanks, Arseniy
> > >>>
> > >>> On 08.01.2024 21:33, Arseniy Krasnov wrote:
> > >>>> Sorry, pls ping
> > >>>>
> > >>>> Thanks, Arseniy
> > >
> > >
> > >
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
