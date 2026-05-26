Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDD7CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 04:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5748F841D7;
	Tue, 26 May 2026 06:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKypHlIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CA9E8464D; Tue, 26 May 2026 06:51:11 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03B08404D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65eb1b25c77so4712742d50.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 21:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779771068; cv=none;
 d=google.com; s=arc-20240605;
 b=ldvjLkt38GbfWhr3BgPdIwLaDT9aIhOMPixH2E3l05KVTZoHSVPvM3HLJa2fN68EzH
 4546G4HiXRwmXhK9h/c4BKg3wMW6+VnLxuwubWRfDhlt9r5jeLibjcb0dtccMAfCVlKL
 xWe1XUkDPQ5NqXrDeiw+P8wTag9duNODlXFRfjPgc//uXjwIwKes07ao/Kae9GnemxvX
 U/6lo4OumAtWXeZwkfbOdvgCzTjpdrY896BxnJ4kbyZ0V4FE3V9NPXrWDFRX2T7cFWxi
 sirqyB6KdfUdLqo58MkipnPxgLVTbnwUD8tysY3GfJ0vKNlPnkfE/tbaSUAYS3OrvOCI
 mErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Oy39vtvpo6zxkRlBjdEjjWMaZgelRAhf0d9QZa7p1Zs=;
 fh=AKjnuBRBPOkEeQ5x1wfVk7a+/19iJ4v2I2zFfh6cWyE=;
 b=Cl3HAvzbXNs+2G+YwDuQ8EjnFSMAUddMRisqJ37/DCjZl6CbC/0DBoPcKJEUHQdxKd
 CxDSfMK1iG32sAaN9/La7YcuqF3tR3rnBYbCUINW4n9Q1INf3ddvez4/Bq3lMRiFmPni
 lgscBZQjCIfHn1Ek6UAEX6UKwI4JrHSnRJuPt1404FGQM9xO4UMQ1gtelmV64mnxALFq
 pLTTSunK33NU0Yy5umbc97s1dF/CG36Zk0u8b8jzAOHPYmx9KLLpGqcC8AaAdQBDO8KJ
 NHMzrKxxLIW3H5eaZ18s/t7fusTlK0lva1z0ql0BgdImZDswqNArdhPx21VHZc5q2lP+
 Ma1g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779771068; x=1780375868; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oy39vtvpo6zxkRlBjdEjjWMaZgelRAhf0d9QZa7p1Zs=;
 b=fKypHlIVbX3fk74h8oDsPEm7yxDR2wUp0l85cdXRibsnD4VvogdxXufgmGy/Ik69HQ
 5WDuJ2byAbwNHltY22lOfb1Bsgmt8xi/eRoJPd4hW+IE6cyVnDjmOpfLRX0nKtuK73Lm
 JSPiAgCo9A6BPHM9k556PvYw/ieQzN3w+rTrXusR+mqzwTbqfhNPDtBHpuUcTjyhzPmc
 /B9T9OdaD0JfSqDPWTIhY7nMUa4XUetTCsVyIzMhg50OqDoD0MaZ3h0M8JRB/fKyxZbs
 Vnrg7LVAAivWw4uG4fOFvoCr+osubaAXkyBY8WrZCN1AvTS4Yky9zcimWXsdhb5lrk+R
 0scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779771068; x=1780375868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oy39vtvpo6zxkRlBjdEjjWMaZgelRAhf0d9QZa7p1Zs=;
 b=NaruaxyssQY5CKLr5Y10i+nc3JBcH6JqR/4x/wCewr72uL7ZmBQJ/Iw5IL2+zzL9kS
 uDP0AiIjSZVUa+J5QpgQ9xog+6rb6vJqUrBzJyfrPDmSCMpI9bN22QZuWvFi+DUzDwHg
 Ug4lBOl5OffEqNdmXwCweQU+yEpX2prsa58fVZDQtO90o9SJCoUIImwcjWD5PbIr/NR0
 +WzPBy1EtRr/bPAM9pxOxPYxtLhVb60fgLkqk4Oeke4iajj10AuSEoigc7PdC1BtK+hi
 iacZYYszK4+aQDMIhy+zVrYhN/3Dv+Z0AY1DPQnA/KHA4cpDh1G2i34G7I0L8IGVm93w
 XMAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VfIsjBkJUknJkYd6Qjvf2P89TRsegYFOufMLnZaHH1kNPvNe9J3t8FNU0JJIh2APQ6uxeYWk=@lists.denx.de
X-Gm-Message-State: AOJu0YyDazk13oY+fo9QnVWZCs33+Hn/vV5Osw2muMP9MfXv1vC0wjKf
 EdGvm3cXEWwqIpe6uQ+9bUCqfaAXImrqp96lW2ZzMbRtRmT6tIrbCOxXrJV+zZkfY3WVJCCGDhJ
 Gt9neXwWqEfmXXFpHnNpFRxYXKZJ7hqOcT5rk
X-Gm-Gg: Acq92OHPtUwuwp5+qvIbK50vAYfrYVOjEmLOAPF6iddfRgeEbeK5XLttF/ScuI9Lrmv
 Gdbgn5+mv1xYjM057IWi5fadrowIYMSITBbcTFfX1vNFFcSYtxX9LrGCTE3byJV2cRA09J1AGNV
 YJ9IQiVehOEDdyZW0bhNBVkxeNhLYFh99F0ZmO7CINXHMPNeL/o1GU2Dbf0J8KBnRfeaS2nNr6o
 gfQUTUVJ9O1vu7j/u10MVAH7JVm7ocB2TcF5WVoJ9n5nzW1L5CgC0XOJQXdd3ubcGzdcOtvdEg7
 jQQ1qfLk
X-Received: by 2002:a05:690e:4813:b0:650:dbb:e79c with SMTP id
 956f58d0204a3-65ec98aa45bmr12611930d50.40.1779771067668; Mon, 25 May 2026
 21:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
 <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
 <ZJ8GNZXD-fYDaXZ4MCGrxvVAtJfaDjWWHRt6LlXWpQJpg3evBb4F-T9KO5yGvmFM3j643wz9PQa4ROK62TL6kKSnBW65XJmBep6yuxh2qUo=@bens.haus>
 <CAJaLiFzyOUV1r0gUAFpgGcQUGzmz_zneiC=AVbAnxKDcOMCvqg@mail.gmail.com>
 <so1abs7pAg9MrPZOVyW7dGcSFp2m4Tf47UW6T_QYYtgqkQ8DqrHNCfPLytOKux86LMpRM9t3fcv_I1uIYIOkdKGFkH5OZ8cEpueoLEK7iwU=@bens.haus>
 <CAJaLiFzGYZ89B7LD7z6Mese0iH3-KqM8TFbn5Vkx11Zjr-7MrQ@mail.gmail.com>
 <aU0JJd40MuUFOULadJri1Poqfq4wrvGMF7zrdOEucjI-loO3N7kZDYa32JIaXoDBcusnMxLPEuRcBTPvSkfnSf3p_0Pn0oZPXHTTZXSn48M=@bens.haus>
In-Reply-To: <aU0JJd40MuUFOULadJri1Poqfq4wrvGMF7zrdOEucjI-loO3N7kZDYa32JIaXoDBcusnMxLPEuRcBTPvSkfnSf3p_0Pn0oZPXHTTZXSn48M=@bens.haus>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 25 May 2026 21:50:50 -0700
X-Gm-Features: AVHnY4LUR9I91LujvtW2ryO-CEYMG4PsmfUL2-1WpI8-tI0lPAjtIqawiCM3M9Q
Message-ID: <CAJaLiFxMirwELHw_nAZ56oHWK9fXmsshisGr2Wr3OnGLLzsyrg@mail.gmail.com>
Subject: Re: v2026.04 crashing on Marvell Armada 3720
To: Ben Schneider <ben@bens.haus>, Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Ben,

This problem sounds familiar. Perhaps Tom can explain this. I recall a
patch recently related to DEVRES.

Commit 217cf65
dm: core: Default to using DEVRES outside of xPL

Added Tom.

All the best,
Tony

On Sun, May 24, 2026 at 6:21=E2=80=AFPM Ben Schneider <ben@bens.haus> wrote=
:
>
> Hi Stefan,
>
> On Monday, May 11th, 2026 at 12:45 PM, Tony Dinh <mibodhi@gmail.com> wrot=
e:
>
> > Added Stefan (MVEBU SoC maintainer).
> >
> > > The first commit to cause problems is actually 217cf65 dm:
> core: Default to using DEVRES outside of xPL.
>
> After a lot of testing, I think I've traced the issue to drivers/pinctrl/=
mvebu/pinctrl-armada-37xx.c. There are two calls
> to devm_kzalloc that, when I change to kzalloc and remove the dev
> argument, my device boots again.
>
> --- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> @@ -523,8 +523,7 @@ static int armada_37xx_fill_func(struct armada_37xx_p=
inctrl *info)
>                 const char **groups;
>                 int g;
>
> -               funcs[n].groups =3D devm_kzalloc(info->dev, funcs[n].ngro=
ups *
> -                                              sizeof(*(funcs[n].groups))=
,
> +               funcs[n].groups =3D kzalloc(funcs[n].ngroups * sizeof(*(f=
uncs[n].groups)),
>                                                GFP_KERNEL);
>                 if (!funcs[n].groups)
>                         return -ENOMEM;
> @@ -724,7 +723,7 @@ static int armada_37xx_pinctrl_probe(struct udevice *=
dev)
>          * we allocate functions for number of pins and hope there are
>          * fewer unique functions than pins available
>          */
> -       info->funcs =3D devm_kzalloc(info->dev, pin_data->nr_pins *
> +       info->funcs =3D kzalloc(pin_data->nr_pins *
>                            sizeof(struct armada_37xx_pmx_func), GFP_KERNE=
L);
>         if (!info->funcs)
>                 return -ENOMEM;
>
> I cannot explain why these changes resolve the issue so I'd
> appreciate if someone more knowledgeable would review.
> I'm also happy to test other proposed solutions. Thank you!
>
> Ben
