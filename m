Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DEFCDB481
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C682686ED6;
	Wed, 11 Oct 2023 21:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jAcWZxsl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023C886E1F; Wed, 11 Oct 2023 20:56:12 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F0D86E47
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so327286a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697050154; x=1697654954; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3cLMwcNgOEZk6x4aU9dWFbpHB6ufLp/CBGLiaFArtk=;
 b=jAcWZxslhIjTdTLBX2iipWiYXQf1DhqgeaahGxLQNqJfbJWvPP8mVMllJcysbfrClm
 TxoWaKpMelDHTJlUz0BC+YMk+Eg2YeCDXlpRkQUtsu8Rk8OltCencWWVAbLRxZ8N1hz/
 LtonJDhxpxQl7L+SHqzCkRl/5HrVqEe4wazy3uaYk903h/xSFXdjmXaUiGbFNP6qsJTQ
 rOT6RL71ActfY2H6ZwPz4sEhS24nrvslVBQke4iNDl+ru10X+jG7elrAqcY/1QTMenb/
 5yADh64kRSyO2dCTxWvtel6T9dlv//l5N6oWwj82OPUDl/GgOX/OY4meqQpCrK4a6m72
 E61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697050154; x=1697654954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3cLMwcNgOEZk6x4aU9dWFbpHB6ufLp/CBGLiaFArtk=;
 b=Q78yb6y1UrqBsdF0IE1+anN6AL23xqyzwQFx+oA/+47YYwBRPIRD4tCLeHyd6TQwZ6
 fexf/7tn/gwpihZvywO8nZCsFZDWxz6wo4RehXYhSlpty9HnnbIZz9BBoWJbzSEhUG4x
 SezbXSfVbglwlfF99qSh8gJ+AOFxtg10IKTL7Q3yBj8wm/0fGaQVFXeAGaIK8KLj0z8H
 S360SlvHlLdd0WHDhZuG54KcoEEhicnSim0r+M+s9H5UUsM4xh5LjEK5x3TkFL7STPyY
 Wp7Ndc0pG5R5GALy7y9Sbumr8UVR4zSa9zsfv5PviiNpLLVJvYRrPsYYYOUxTyMbzP4z
 bYgg==
X-Gm-Message-State: AOJu0YzadzQ/B9xLPmd5VEKAqtjtt/Z7/+3IAhFYNnyQtNZYtllo/E9B
 3sibo/UTba5iyiLMkXc+4dxTbGT7HRgePl0bgXU=
X-Google-Smtp-Source: AGHT+IGCKNvp1UCeAXuuvCgWLKgHWI+8JbcwNeUX23fOPvHi38SalYPDcDbK92TgEbWvRI+AKP2x5h4i6qtfEDcCQiU=
X-Received: by 2002:a05:6402:3985:b0:53d:bc68:633d with SMTP id
 fk5-20020a056402398500b0053dbc68633dmr3288904edb.7.1697050153458; Wed, 11 Oct
 2023 11:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230917230649.30357-1-mibodhi@gmail.com>
 <20231011144356.GA900529@bill-the-cat>
In-Reply-To: <20231011144356.GA900529@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 11 Oct 2023 11:49:01 -0700
Message-ID: <CAJaLiFysP2UPo6BAuuQGSQ15iN1YsWggBk+=j5UYbW2g+=32Eg@mail.gmail.com>
Subject: Re: [PATCH v4] bootstd: sata: Add bootstd support for ahci sata
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
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

Hi Tom,

On Wed, Oct 11, 2023 at 7:43=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Sep 17, 2023 at 04:06:48PM -0700, Tony Dinh wrote:
> > Add ahci sata bootdev and corresponding hunting function.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Revise logic in bootmeth_script() to set devtype to sata for non-scsi
> > SATA device
> > - Rewrite sata_rescan() logic to properly remove all devices before pro=
bing
> > - Add description to sata_rescan() header
> >
> > Changes in v3:
> > - Correct drivers/ata/Makefile to compile sata_bootdev only if
> > ahci sata is enabled.
> >
> > Changes in v2:
> > - set devtype to sata in bootmeth_script for non-scsi SATA device.
> >
> >  boot/bootmeth_script.c     | 14 +++++++--
> >  drivers/ata/Makefile       |  2 +-
> >  drivers/ata/sata.c         | 32 ++++++++++++++++++++
> >  drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
> >  include/sata.h             |  6 ++++
> >  5 files changed, 112 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/ata/sata_bootdev.c
> >
> > diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> > index 58c57a2d4b..96e0ec5efa 100644
> > --- a/boot/bootmeth_script.c
> > +++ b/boot/bootmeth_script.c
> > @@ -190,10 +190,18 @@ static int script_boot(struct udevice *dev, struc=
t bootflow *bflow)
> >       ulong addr;
> >       int ret;
> >
> > -     if (desc->uclass_id =3D=3D UCLASS_USB)
> > +     if (desc->uclass_id =3D=3D UCLASS_USB) {
> >               ret =3D env_set("devtype", "usb");
> > -     else
> > -             ret =3D env_set("devtype", blk_get_devtype(bflow->blk));
> > +     } else {
> > +             /* If the uclass is AHCI, but the driver is ATA
> > +              * (not scsi), set devtype to sata
> > +              */
> > +             if (!ret && IS_ENABLED(CONFIG_SATA) &&
>
> This is a warning here as ret is uninitalized at this point.

Thanks! I'll send the v5 patch.

All the best ,
Tony

>
> --
> Tom
