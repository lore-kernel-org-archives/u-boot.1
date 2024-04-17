Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBACC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 18:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C89E5884DF;
	Wed, 17 Apr 2024 20:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FRyhxwPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24D95884DC; Wed, 17 Apr 2024 20:44:58 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6AE0884D6
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e509baddaso20978a12.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713379495; x=1713984295;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfN1Ped3gE2nNH6qooD7qJDQPEujnaNNkHN7lUGZ3lc=;
 b=FRyhxwPmC6pJzefihuCQqZ4AamwDPnoRy9WmeOuwRK3/dE3BLZsCU7E5U3SPjz0tx1
 dF9BDUpup5B6/vyz+dgWdfM5eDIBJLVYq7vd98N9iSDIXM4cAY+Ie5ZHlNyKJjjQV4kC
 re9thDuOVJmzl04oRlQxabAEWxk9yQmV0Usls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713379495; x=1713984295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfN1Ped3gE2nNH6qooD7qJDQPEujnaNNkHN7lUGZ3lc=;
 b=bjWnuRwArr1fg6gCWcyww9a39v3JBvFBVoeJ4zH09MxrpXYWrSwNaOe+ksnUwlWQOq
 n4uXXBQ1eW4+FpuT/mvLUEFAbuhtb09I+7BgMu5CJjcfzvSSH6u75Bs4m+XU9mSc26eU
 pcZGqS9CFJDUivnTGPx12NzoAmoX2+zANxZlu5x/3YOyXZ5j1e+jRyeQqOLSsBeHcujw
 bz8Lvo+Gg9XznM1id8snTyku2IQ16KHriY1rrLR2cM86sUKB5kIKKWu5TheDmN12fuf3
 X8kkf/IfoxdAyr+Zby59NEtZ1N91RTilQD9wURfd5Nl4ejuG9eMyLx9lJTypyOJ2S8rP
 ro5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjB2jQLzDLDFlGc2UYC1cTtwyKqRj1gYN6OkewRtVFaRM9GCMbVaP/z0W+u6FloxGC0DxWF4k/l3VBzfV1BF0BHRsSQQ==
X-Gm-Message-State: AOJu0YzkZhTl1oh3yhW6O/ZRwHXv3jLTYvoB/jSnFIAyaJS1N58O596I
 MukeRncsnJseJm9C0N8wmJFkigHQCnvbCkwuEskkLUyNVLWQQBv23+bEArDdOoCseHTksnBWs43
 bbdeDPt9sPwWT3ZZ9bliqwtLytalgwsgTaTwXPgHOqYlamTg/RHI=
X-Google-Smtp-Source: AGHT+IFtt45ggrfWKLtC1LXX7FcewqcFuXd42pWpMVbXyDl8SDMZRaZtR43ghWEjKwF8wwJBoqQFsavkjLgAGl5Fw/A=
X-Received: by 2002:a50:f610:0:b0:56f:e75b:83aa with SMTP id
 c16-20020a50f610000000b0056fe75b83aamr385058edn.6.1713379495363; Wed, 17 Apr
 2024 11:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231130112405.92196-1-avkrasnov@salutedevices.com>
 <fa9fc4cc-892c-7c11-877b-330bf173f3bd@salutedevices.com>
 <f79d88f4-0d2e-1d78-065a-5a1f2f2deacf@salutedevices.com>
 <c150440e-191d-bce8-3b99-401186be507f@salutedevices.com>
 <180478dc-23ec-952d-e1ae-6f16d98bd16c@salutedevices.com>
 <969ce8dc-3726-cf66-3241-5eb06f9cb85f@salutedevices.com>
 <CAOf5uw=2hicHHOP1caASJoqmOpZ9vvE3ZMnVQqXxQ0eqbm-CMg@mail.gmail.com>
 <3142650d-4868-c6cf-2555-301e41fadbe4@salutedevices.com>
In-Reply-To: <3142650d-4868-c6cf-2555-301e41fadbe4@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 17 Apr 2024 20:44:44 +0200
Message-ID: <CAOf5uwkmPq4pU0RY-fQtt7Qn5dzpHSf7rr_z5yrepmgP4wRADw@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 kernel@sberdevices.ru, oxffffaa@gmail.com, 
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

Hi

Dario did you add those patches in CI and test them again?

Michael

On Wed, Apr 17, 2024 at 8:44=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hello,
>
> Sorry, pls ping
>
> Thanks, Arseniy
>
> On 13.03.2024 09:46, Michael Nazzareno Trimarchi wrote:
> > Hi  Dario
> >
> > Can apply this series and put in CI?
> >
> > Michael
> >
> > On Wed, Mar 13, 2024 at 7:43=E2=80=AFAM Arseniy Krasnov
> > <avkrasnov@salutedevices.com> wrote:
> >>
> >> Sorry, please ping
> >>
> >> Thanks, Arseniy
> >>
> >> On 11.02.2024 02:16, Arseniy Krasnov wrote:
> >>> Sorry, pls ping
> >>>
> >>> Thanks, Arseniy
> >>>
> >>> On 08.01.2024 21:33, Arseniy Krasnov wrote:
> >>>> Sorry, pls ping
> >>>>
> >>>> Thanks, Arseniy
> >
> >
> >



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
