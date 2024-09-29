Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C7ECF6497
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 17:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1750C88753;
	Sun, 29 Sep 2024 19:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Eso3AFEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F1A88901; Sun, 29 Sep 2024 19:20:32 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD6A98870D
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 19:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c8952f7f95so683729a12.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727630429; x=1728235229;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/g9kgtE620Ahl7BcQTVLdQXN6f+6kKZO5Eo7czGxhJY=;
 b=Eso3AFEy7Z4PjNHoLuyrE7E6XjloRlCW+iYp3RRRIX37t5fUBz+w3LpH9gZIDjqlDH
 CWo9WOobKAxXarvG8xBbFqOoz1vFMzJkErs4TZWzlUW87DEMxwbY8HyVOuEZ4qf24IIU
 hFPrRyL7dnb7RgdVRIeE69Jn9plO55MtHhxdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727630429; x=1728235229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/g9kgtE620Ahl7BcQTVLdQXN6f+6kKZO5Eo7czGxhJY=;
 b=Q+HWuHuGPP+8eNI6K+3deg4LRsRkAYliMxWkBrFUXvl1VMudh9INBOl+/7/81HNqe+
 K6pzDJpV/j8ED+CVpaR5KFtOscbiW7PsNY2ageN0Kh1oMd7dIMyV+kXuWTzoUdhRQg+R
 pimsHM9V3+JgXiWaPcXJO8MIhEnpMh2XR8gOmLZmcWkL73+cbV6l5R8IVzl6eQY8LA+h
 WzmzfHsftjIjh7eHGIbZCOEluApaHLU7KIyQgzh2KK7b9qeJZEg6wcQjB/F/GpEc3kMU
 8PjyEpWxnv1G8ICWOyZnCLpTyrilYmHHMEXjW6Ol9y8GvMtWXh60knyP4i2QREKfWCug
 Rp7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAMZkfc/qUD1xjvD5mA5f6Ym7nX2CD6JYPDa9m80jpSeSu+Par69NrIJuuhxKDRqudcY0FSkI=@lists.denx.de
X-Gm-Message-State: AOJu0YyUBnTFlx9S+1UhXGV/tn2b4zqnlAat9Z2ViYsTZur3qR36FOwy
 0eOZkNqT35S4l5f2WJ/M2No1bam+7Jn4T+sUW6LwL1K87WVF5aqC9059+O41zkrNb8afiafp0Xa
 XNjB4rbHjaXq3kn5RpjveQGHZR13ZDFDLRra/MFLzoTe9hGEmZFSDurz2
X-Google-Smtp-Source: AGHT+IGX2GAjNjqoLgZRcidchhIeWkOzOCxaJ/a+Lc3zGfC0c8FUclv4yljt6VCQDPtD4ojMmAQvaSsBPXehvmsPq08=
X-Received: by 2002:a05:6402:5407:b0:5c2:6343:827a with SMTP id
 4fb4d7f45d1cf-5c88262cc7amr6425142a12.32.1727630428986; Sun, 29 Sep 2024
 10:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
 <20240916-brcmnand-fixes-v2-2-08632f64c8ec@linaro.org>
 <6baede77753d570d539f9995d960955c@mail.gmail.com>
In-Reply-To: <6baede77753d570d539f9995d960955c@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 29 Sep 2024 19:20:18 +0200
Message-ID: <CAOf5uwn=h243PgXuK1aUCSNATiM6uHG_i7mVjXwr_XDd8nPvyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] mtd: rawnand: brcmnand: Fix potential false time
 out warning
To: William Zhang <william.zhang@broadcom.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
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

All, Dario

On Tue, Sep 17, 2024 at 2:20=E2=80=AFAM William Zhang
<william.zhang@broadcom.com> wrote:
>
> > -----Original Message-----
> > From: Linus Walleij <linus.walleij@linaro.org>
> > Sent: Monday, September 16, 2024 2:59 AM
> > To: u-boot@lists.denx.de; Dario Binacchi
> > <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> > <michael@amarulasolutions.com>; Anand Gore
> > <anand.gore@broadcom.com>; William Zhang
> > <william.zhang@broadcom.com>; Kursad Oney
> > <kursad.oney@broadcom.com>; Philippe Reynes
> > <philippe.reynes@softathome.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>; Florian Fainelli
> > <florian.fainelli@broadcom.com>; Miquel Raynal
> > <miquel.raynal@bootlin.com>
> > Subject: [PATCH v2 2/7] mtd: rawnand: brcmnand: Fix potential false tim=
e
> > out warning
> >
> > From: William Zhang <william.zhang@broadcom.com>
> >
> > Backport from the Linux kernel:
> > commit 9cc0a598b944816f2968baf2631757f22721b996
> > "mtd: rawnand: brcmnand: Fix potential false time out warning"
> >
> > If system is busy during the command status polling function, the drive=
r
> > may not get the chance to poll the status register till the end of time
> > out and return the premature status.  Do a final check after time out
> > happens to ensure reading the correct status.
> >
> > Signed-off-by: William Zhang <william.zhang@broadcom.com>
> > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-3-
> > william.zhang@broadcom.com
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > index 700d1122639f..46a4107a83a9 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -1011,6 +1011,14 @@ static int bcmnand_ctrl_poll_status(struct
> > brcmnand_controller *ctrl,
> >       } while (get_timer(base) < limit);
> >  #endif /* __UBOOT__ */
> >
> > +     /*
> > +      * do a final check after time out in case the CPU was busy and t=
he
> > driver
> > +      * did not get enough time to perform the polling to avoid false
> > alarms
> > +      */
> > +     val =3D brcmnand_read_reg(ctrl, BRCMNAND_INTFC_STATUS);
> > +     if ((val & mask) =3D=3D expected_val)
> > +             return 0;
> > +
> >       dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\=
n",
> >                expected_val, val & mask);
> >
> >
> > --
> > 2.46.0
>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>

Acked-by; Michael Trimarchi <michael@amarulasolutions.com>

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
