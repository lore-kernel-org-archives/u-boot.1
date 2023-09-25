Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D93DCD54BE
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 19:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F01E886C22;
	Mon, 25 Sep 2023 21:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U80926Xr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8612D86BF7; Mon, 25 Sep 2023 21:18:06 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7A186B4E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 21:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-530bc7c5bc3so8590260a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695669484; x=1696274284; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Fg98r9WcChLuBKncK0+9pM3MmyCfnDgT4N4UJEGztg=;
 b=U80926Xr1HT+1bL8mqdcDeg1f/gVVXis+mCIwVKplkVfz1woG3G4vGI72qxU912rG3
 tAApmrNo/xQf5JA4NDeTqG3N0/tRXCoTQnkglgl3WzAlTYLbLuoAy+x87HSQHGYIzVxg
 659GQyxVWbU4qqgANSu0fiHcCNKhZmVkqzZbBegPR+6lwMN+g6pxhcIkgt8XkmsAgvGM
 j2koVub+qjzkzM42xCoifzR5iY1vZTnr0WhWebIdtHyp+MhHm5J+Sb59Wk+U2v+w+d+n
 UzchRl9nvfMYAl7C2tkIU4BauUME8E9fcbJvvM1YsRYFkUlySQNKKepWyk5XlAFSauC1
 aMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695669484; x=1696274284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Fg98r9WcChLuBKncK0+9pM3MmyCfnDgT4N4UJEGztg=;
 b=K8vHm+ggTcprP2Rjh+Sz/WJa0YJBstcoBJwG2+v/hPCLR64IROyblonW2MuhV3tVT8
 xyHc01dLuZjss03qoN4fzQh0aaw64GenkS4a52krpjufgf7gQLcbYt8HKmT5dhJ0pkpD
 sz9Y2GtkJuLJDJoWhHDQTvQJXSpOV5O4MVRrdbAU0WIvHi/V/9bhpLQczy5Lf88Oftci
 oqX1uGKEpN2Pb+3zOC2y4lMmtfGnIAXAAKYegeps9cbSYPIP3kMDkzjkZ/OaJ1gxWYlv
 s5sIaAvofxh4RMXeiIciPGZLY2uFtpajxam3vcxTQqSMc7xBD3PUeYKqv2BsLo3VJfep
 WXow==
X-Gm-Message-State: AOJu0YyTd6QNNpqARjS2cKnp9qCDz8DSPgjn5z8oyhdp9ROpJORq8hNG
 96+5fPhpoMHrb2EvxZ1d6CLzIRMFd859iaPaTZo=
X-Google-Smtp-Source: AGHT+IFmOGegFXQ+7nq+2oQnWCCRj7tGMsLwCk/ELCItMzui1NOKBRuQevsQOZEP9E7+FFEBfyNov41MU3ZB+bZOQlU=
X-Received: by 2002:aa7:d1c3:0:b0:530:7ceb:334 with SMTP id
 g3-20020aa7d1c3000000b005307ceb0334mr6852853edp.3.1695669483927; Mon, 25 Sep
 2023 12:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230906052242.21568-1-mibodhi@gmail.com>
 <e5f5a68d-9f2f-9c39-b969-508275da454f@denx.de>
In-Reply-To: <e5f5a68d-9f2f-9c39-b969-508275da454f@denx.de>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 25 Sep 2023 12:17:52 -0700
Message-ID: <CAJaLiFxcO906KyJNgUKUrsWbsdvu903Q95s=ph5Y6vxvh+FBVA@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: sata_mv: Add bootstd hook to enable
 sata_bootdev
To: Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
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

Thanks Stefan!

All the best,
Tony

On Mon, Sep 25, 2023 at 1:14=E2=80=AFAM Stefan Roese <sr@denx.de> wrote:
>
> On 9/6/23 07:22, Tony Dinh wrote:
> > Add hook in sata_mv probe to enable bootstd bootdev.
> >
> > Note: bootdev_setup_for_sibling_blk() invocation is a noop if bootsd is
> > not enabled for ahci sata yet.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>
> Reviewed-by: Stefan Roese <sr@denx.de>
>
> Thanks,
> Stefan
>
> > ---
> >
> >   drivers/ata/sata_mv.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> > index 18c7a66db1..55a5365b5a 100644
> > --- a/drivers/ata/sata_mv.c
> > +++ b/drivers/ata/sata_mv.c
> > @@ -34,6 +34,7 @@
> >   #include <common.h>
> >   #include <ahci.h>
> >   #include <blk.h>
> > +#include <bootdev.h>
> >   #include <cpu_func.h>
> >   #include <dm.h>
> >   #include <log.h>
> > @@ -1104,6 +1105,12 @@ static int sata_mv_probe(struct udevice *dev)
> >                       /* TODO: undo create */
> >                       continue;
> >
> > +             ret =3D bootdev_setup_for_sibling_blk(blk, "sata_bootdev"=
);
> > +             if (ret) {
> > +                     printf("%s: Failed to create bootdev\n", __func__=
);
> > +                     continue;
> > +             }
> > +
> >               /* If we got here, the current SATA port was probed
> >                * successfully, so set the probe status to successful.
> >                */
> > @@ -1116,7 +1123,6 @@ static int sata_mv_probe(struct udevice *dev)
> >   static int sata_mv_scan(struct udevice *dev)
> >   {
> >       /* Nothing to do here */
> > -
> >       return 0;
> >   }
> >
>
> Viele Gr=C3=BC=C3=9Fe,
> Stefan Roese
>
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
