Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534F1C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 13:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC3E88542;
	Fri, 24 May 2024 15:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gLGfi4B/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11D398864F; Fri, 24 May 2024 15:31:48 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B22884CD
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 15:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-df771fa2b8bso851736276.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716557504; x=1717162304;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9ETYomwjOOKaZUm9Y6vDiHhtweSkMhDD8jB2Lj75gc=;
 b=gLGfi4B/8NntgiJd9KGf2anxfMSIVrCHjsVTthh9mp3lS75+Km7H+DBUwwDdxZCM5s
 PtQ7euJQ2MHZgjEF784VQUySHiimpX6maD6o9XmSCoVD+Zvg7L9yapjm9BkKt5kdwNp9
 jxFIDtiKBOfVRePhqS0RSXk7H4iJv0+Hn6Xzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716557504; x=1717162304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9ETYomwjOOKaZUm9Y6vDiHhtweSkMhDD8jB2Lj75gc=;
 b=gsW+whVVHa9aaHV14W003+ayqxEU4PdiETe33wHt9ZtyROtOVHXDuygyPM5SJ+NI+h
 52EN3AeADsYMy/n91qgbSUfK2DpSxjOnaaosDBB7ZZEvjxC9zSs02cIxmsvMutUh9twq
 cRAp+VJq6J9zR1s3IdeaE7ZCoNjHSktSv5pHkAhP9tsAq/E/bt7WrEsw2o9XcfuIZemK
 XrNA8GNa/KV6o0+msG8QW9wkuO522zZs8GLxnTyESapEjsl1FlStTgevGuHTGJ/5pJ/g
 PeGs5GS4kWSRXx7Tl7G10rvB9Ne9Y5+FlMq6Faaj+ZY6qVmxPSBewuFuR9X+/qPLRHCp
 waNQ==
X-Gm-Message-State: AOJu0Yyhrv8oKwWjioyfnwUlaJpeuxP/Ithklqk3y3aw5pk/pHrKKHNw
 FB9ROZ4czRtukdhBPM6AM7D86RwJ+SD+StgoJHtW/ybrTMLZvsNFLMVSFENqCikuI0c/gaLkBay
 TrtBXXDHDBAIGcSgINaCPXlp27ZIKeyB/yHfxGw==
X-Google-Smtp-Source: AGHT+IGajvqVkLoepaV8Zyf48qSIXmJvgY1HJLyv/L20AGyTW+Hk+Io48zCPsNw2/XFYisEiOwbfxrU9nEIP6bvILSM=
X-Received: by 2002:a25:7486:0:b0:dc6:ff6b:71b2 with SMTP id
 3f1490d57ef6-df77215e2ddmr2388595276.4.1716557504625; Fri, 24 May 2024
 06:31:44 -0700 (PDT)
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
 <CABGWkvqxBRhjRFC3szz_WGJmHyzx1ihRADr04f47k+8SRqjFBQ@mail.gmail.com>
 <b10fefbf-ac0e-b285-4809-578cffee7291@salutedevices.com>
In-Reply-To: <b10fefbf-ac0e-b285-4809-578cffee7291@salutedevices.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Fri, 24 May 2024 15:31:33 +0200
Message-ID: <CABGWkvrX2Xv0hEgbNXZrO8rrC_kHay5djo0DULxoA8o1wX0OUA@mail.gmail.com>
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

Hi Arseniy,

On Fri, May 24, 2024 at 11:25=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi Dario!
>
> Sorry, is this patch ok?

Sorry, I told you I was testing it but I forgot to tell you that
testing was successfully
completed for this patch.

Thanks and regards,
Dario

>
> Thanks
>
> On 18.04.2024 09:55, Dario Binacchi wrote:
> > Arseniy, Michael, All
> >
> > On Wed, Apr 17, 2024 at 8:44=E2=80=AFPM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> >>
> >> Hi
> >>
> >> Dario did you add those patches in CI and test them again?
> >>
> >> Michael
> >>
> >> On Wed, Apr 17, 2024 at 8:44=E2=80=AFPM Arseniy Krasnov
> >> <avkrasnov@salutedevices.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> Sorry, pls ping
> >>>
> >>> Thanks, Arseniy
> >>>
> >>> On 13.03.2024 09:46, Michael Nazzareno Trimarchi wrote:
> >>>> Hi  Dario
> >>>>
> >>>> Can apply this series and put in CI?
> >
> > Sorry, but I mistakenly tagged it as 'superseded'.
> > I just pushed it to my nand-next branch and I'm running the CI now.
> >
> > Thanks and regards,
> > Dario
> >
> >>>>
> >>>> Michael
> >>>>
> >>>> On Wed, Mar 13, 2024 at 7:43=E2=80=AFAM Arseniy Krasnov
> >>>> <avkrasnov@salutedevices.com> wrote:
> >>>>>
> >>>>> Sorry, please ping
> >>>>>
> >>>>> Thanks, Arseniy
> >>>>>
> >>>>> On 11.02.2024 02:16, Arseniy Krasnov wrote:
> >>>>>> Sorry, pls ping
> >>>>>>
> >>>>>> Thanks, Arseniy
> >>>>>>
> >>>>>> On 08.01.2024 21:33, Arseniy Krasnov wrote:
> >>>>>>> Sorry, pls ping
> >>>>>>>
> >>>>>>> Thanks, Arseniy
> >>>>
> >>>>
> >>>>
> >>
> >>
> >>
> >> --
> >> Michael Nazzareno Trimarchi
> >> Co-Founder & Chief Executive Officer
> >> M. +39 347 913 2170
> >> michael@amarulasolutions.com
> >> __________________________________
> >>
> >> Amarula Solutions BV
> >> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> >> T. +31 (0)85 111 9172
> >> info@amarulasolutions.com
> >> www.amarulasolutions.com
> >
> >
> >



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
