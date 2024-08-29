Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BEEC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B86DB88C44;
	Thu, 29 Aug 2024 17:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rx81uHnO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC82988C35; Thu, 29 Aug 2024 17:00:45 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1AF088CD8
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6bf7f4a133aso4145726d6.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943642; x=1725548442; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLD4GbrXbRCMmB9UnIp7cpELepp3L4pbA6UIORsTGTU=;
 b=Rx81uHnOWTFz87IHIl4LE8Muwx10jo7jUq1siWYgGUYLq15Kx+nb12UX05ErnknBTm
 45yPo2Oedgj3lX5NSvytIEukIV1nm82+NvGbj5wT5stkFSZQixnWSgKZDLaUgW0sExkp
 Hg0bR4tCda20CdExUmqeBLh7IezjIhhOF0dPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943642; x=1725548442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLD4GbrXbRCMmB9UnIp7cpELepp3L4pbA6UIORsTGTU=;
 b=tkxzNXth2q27DmclmL9Mj2zVYoMgm+WWhq5vFkfPlcdS7ynjuuF+ngF6akK3R67WHO
 gxUE7oX9KoX2ZNH+yQx/4FciRjLUdBY+GM8m4Hvl5ctZelZr972TXAvz+WAqM5b0fuCS
 TIQM1lZA/6Wl/z0GvGM2o+Ue0Hty9QrQB7L7SoguFaxBdGjq9R+tAMEZZcMR2pSCrFBc
 t8cJNc+ihF9I4xwOajdIzBK1NsK8r30ysoE997wh1nMylVmW/okObzDeGqJJ7E8CF383
 PThYfYea9LiLFdm/DmssCix8SvYuI5AYbVceHbSmj6KNiYgyzoX5y7ZVupS0otREGM8M
 4O4A==
X-Gm-Message-State: AOJu0YyCGXOFaTtjzuWKlEr8gykNyVUO5bPTrYiebjPAHKjyQ5jchsA9
 ZvbIIQDdvawLKk0/FCqxC6E0M1nz6+uOp70GJ2wj6BXNXuq5utNFCII2kXiN9HqMjojxlNHmYVQ
 r/MRmCpYSRHtofHBYutP3An/4o2x3TIakM6BX
X-Google-Smtp-Source: AGHT+IFuey3sD7Q58ytoEXnJ+uPNlffNOINYVrIKoRUbj0dygnynm6CLXLf/0U49ftm6C7piB3D4c3xQPCnD7K7/RCE=
X-Received: by 2002:a05:6214:598e:b0:6b5:4435:fe4d with SMTP id
 6a1803df08f44-6c33e6b1cddmr39921686d6.38.1724943641512; Thu, 29 Aug 2024
 08:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
 <20240825122617.3708982-2-dario.binacchi@amarulasolutions.com>
 <CAFLszTgN=GWbrJAmtBrb95i2ovAhfE1BPco5p3whnL-oCAhbKw@mail.gmail.com>
 <CABGWkvpfiduptB9H_5zK3SwKwXjuQN1u1YPGukypviDstuZoEg@mail.gmail.com>
In-Reply-To: <CABGWkvpfiduptB9H_5zK3SwKwXjuQN1u1YPGukypviDstuZoEg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 09:00:30 -0600
Message-ID: <CAFLszTg47_=TnQ6qy2UJj0n89B8TWrw0tH4RVk+GQKFS_+Sjmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cmd: booti: adjust the print format
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Eddie James <eajames@linux.ibm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Dario,

On Thu, 29 Aug 2024 at 08:25, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Hi Simon,
>
> On Thu, Aug 29, 2024 at 4:05=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Dario,
> >
> > On Sun, 25 Aug 2024 at 06:26, Dario Binacchi
> > <dario.binacchi@amarulasolutions.com> wrote:
> > >
> > > All three addresses printed are in hexadecimal format, but only the
> > > first two have the "0x" prefix. The patch aligns the format of the
> > > "end" address with the other two by adding the "0x" prefix.
> > >
> > > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > >
> > > ---
> > >
> > >  cmd/booti.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/cmd/booti.c b/cmd/booti.c
> > > index 62b19e834366..ea811244a0a9 100644
> > > --- a/cmd/booti.c
> > > +++ b/cmd/booti.c
> > > @@ -78,7 +78,7 @@ static int booti_start(struct bootm_info *bmi)
> > >
> > >         /* Handle BOOTM_STATE_LOADOS */
> > >         if (relocated_addr !=3D ld) {
> > > -               printf("Moving Image from 0x%lx to 0x%lx, end=3D%lx\n=
", ld,
> > > +               printf("Moving Image from 0x%lx to 0x%lx, end=3D0x%lx=
\n", ld,
> > >                        relocated_addr, relocated_addr + image_size);
> > >                 memmove((void *)relocated_addr, (void *)ld, image_siz=
e);
> > >         }
> > > --
> > > 2.43.0
> > >
> >
> > I really don't like this...numbers are hex in U-Boot and this just
> > adds confusion.
>
> Sorry, but I'm quite confused.
> Doesn't printing 3 numbers in hexadecimal format with different
> formatting (two with `0x` and
>  one without) create more confusion?
> At least we should ensure formatting consistency.
> Also, it seems to me that this patch:
> https://patchwork.ozlabs.org/project/uboot/patch/20240825122617.3708982-1=
-dario.binacchi@amarulasolutions.com/
> has been considered correct.
>
> Thanks and regards,

IMO we should avoid adding 0x to things...particularly for addresses.
Better to remove it when it has crept in.

Regards,
SImon
