Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45376C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52FBC88CC8;
	Thu, 29 Aug 2024 17:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t/YSFgd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF8B889A7; Thu, 29 Aug 2024 17:03:40 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70BFE88CCB
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a7f86026a0so54967985a.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724943815; x=1725548615; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HaMP6p/zCrYvheNNeFsGcA9ccW1czveLFtx1xMrQgRM=;
 b=t/YSFgd8yj+x0AagiyzfOCnP9d8KOk0XHfCks11pABBnPaQ25hJHE5qL/BRqlhxtXS
 NlYBxz119rk35VyGT77P5rqAzN68C9SGEA2ctMFTdkhnmZjm+MmFSjVHZ3S+fKwMj4az
 uBVAbcmSKyuAo+jSbOmPT6fbsbqQ26cO/cguM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943815; x=1725548615;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HaMP6p/zCrYvheNNeFsGcA9ccW1czveLFtx1xMrQgRM=;
 b=WAASiUOe+Km7Pu5UBlib3P0HhmFlzm7sfhvosTrovJQfqs2BJkcAfTrKUIMbc/5B/U
 kzzFd0lRFpQ/7QKMHOHkvDeZ+f/oASQB5hPRDagtt01KqGakF0Mf8EJFWq0PDfykB2Jh
 cOUa0/HEF135WPcBbJqGk9YnpOo/ZkJBKYqO4dEOc1DW9e+JwLweWdZ/dJTr+e24PvPn
 9G3+PgOjFpfDCehGudozG25jBu2v8l3kCjSrtJE4c+Ezaq3HAzlhT/IeO5AX/SuXW2Vd
 6ALGAnaTUFEHk+oHqWxBy54eKwuhjZCfSdYdEfCNt/5yB6ImOnU0Pf5Oa4n/zOfSwk9N
 mJlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLEx/FR750z0eohTCTyIrIUdOv5I5JPnBrdVVVWzGYsXFCu1bkXgVG2e0KNOZAqFXbg11STdI=@lists.denx.de
X-Gm-Message-State: AOJu0YzwBEvbXFJljrhW3sJEn3g2EnLrt7FTcKLMwuDS4vP1zXoraSS1
 qOuVDywJ6bytwzJ9SYsEPkAKQ3qitOlPVlJFUp4Qnkd53LWgpET4nIma8lXJRXY=
X-Google-Smtp-Source: AGHT+IGuekkTHdE5yeP7TDLuEzOKD4pCZpwCWrEbv8OfuY8Enyd5sLn/t0yPY5KYnr0MjiFBHp6kRw==
X-Received: by 2002:a05:620a:1a9b:b0:7a1:c40c:b1f1 with SMTP id
 af79cd13be357-7a804272104mr362122085a.58.1724943814890; 
 Thu, 29 Aug 2024 08:03:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806d881ecsm57217485a.132.2024.08.29.08.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 08:03:34 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:03:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/2] cmd: booti: adjust the print format
Message-ID: <20240829150329.GB2479150@bill-the-cat>
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
 <20240825122617.3708982-2-dario.binacchi@amarulasolutions.com>
 <CAFLszTgN=GWbrJAmtBrb95i2ovAhfE1BPco5p3whnL-oCAhbKw@mail.gmail.com>
 <CABGWkvpfiduptB9H_5zK3SwKwXjuQN1u1YPGukypviDstuZoEg@mail.gmail.com>
 <CAFLszTg47_=TnQ6qy2UJj0n89B8TWrw0tH4RVk+GQKFS_+Sjmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w0SMhJ/0vwg+/RIs"
Content-Disposition: inline
In-Reply-To: <CAFLszTg47_=TnQ6qy2UJj0n89B8TWrw0tH4RVk+GQKFS_+Sjmg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--w0SMhJ/0vwg+/RIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 09:00:30AM -0600, Simon Glass wrote:
> Hi Dario,
>=20
> On Thu, 29 Aug 2024 at 08:25, Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > Hi Simon,
> >
> > On Thu, Aug 29, 2024 at 4:05=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Dario,
> > >
> > > On Sun, 25 Aug 2024 at 06:26, Dario Binacchi
> > > <dario.binacchi@amarulasolutions.com> wrote:
> > > >
> > > > All three addresses printed are in hexadecimal format, but only the
> > > > first two have the "0x" prefix. The patch aligns the format of the
> > > > "end" address with the other two by adding the "0x" prefix.
> > > >
> > > > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > > >
> > > > ---
> > > >
> > > >  cmd/booti.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/cmd/booti.c b/cmd/booti.c
> > > > index 62b19e834366..ea811244a0a9 100644
> > > > --- a/cmd/booti.c
> > > > +++ b/cmd/booti.c
> > > > @@ -78,7 +78,7 @@ static int booti_start(struct bootm_info *bmi)
> > > >
> > > >         /* Handle BOOTM_STATE_LOADOS */
> > > >         if (relocated_addr !=3D ld) {
> > > > -               printf("Moving Image from 0x%lx to 0x%lx, end=3D%lx=
\n", ld,
> > > > +               printf("Moving Image from 0x%lx to 0x%lx, end=3D0x%=
lx\n", ld,
> > > >                        relocated_addr, relocated_addr + image_size);
> > > >                 memmove((void *)relocated_addr, (void *)ld, image_s=
ize);
> > > >         }
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > I really don't like this...numbers are hex in U-Boot and this just
> > > adds confusion.
> >
> > Sorry, but I'm quite confused.
> > Doesn't printing 3 numbers in hexadecimal format with different
> > formatting (two with `0x` and
> >  one without) create more confusion?
> > At least we should ensure formatting consistency.
> > Also, it seems to me that this patch:
> > https://patchwork.ozlabs.org/project/uboot/patch/20240825122617.3708982=
-1-dario.binacchi@amarulasolutions.com/
> > has been considered correct.
> >
> > Thanks and regards,
>=20
> IMO we should avoid adding 0x to things...particularly for addresses.
> Better to remove it when it has crept in.

That we don't prefix with "0x" like humans generally expect is why
people have been confused why partition 10 is in fact not 10-in-decimal
but 0x10.

--=20
Tom

--w0SMhJ/0vwg+/RIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQjboACgkQFHw5/5Y0
tyxsnAwAqefRwiuhmuiVj3HGsH65jFeMXwYNZQZr3FpZMyC3fkk6MWK2f54/KZvw
JkbkIRdWwnbtBGkswFSYnfix17voU7s1y7XyahJcFO4iKLHREN31xC2tZ9m225Mp
AdKkgoLGEd1PqPypG8LKckls8YAEW6peq1oOr0IWBpriqieGTCD1zpSHNRUvX05o
WJhD4D/vOns93Skq+mt5PGPTUZ1iwMOiSWEh1VSn4T7umzHd67kQmfin5WHJi8TP
Kl9UNfWhLgng2A3o7lZOJI/Ok/yU4YMEpTyVFJiHeQhi1g+KrpxpHF5cAIi1kOVv
NZrv7d2vqJ9YmVqD2xTy7Dyii6vLmXVH49aX8jQs1GyljRrfeAuHO/CNE3X78RDi
4g90Hxq2qzv6yESHNfCXwKLmOXrWFXtjAdDU+iL1m0vrXOuYEord/4XNu/xSRo4I
sw4NlKj9ze/KlUE1+GKoLL8grvaICCnRekI8NCoJ8oq/hXcPTB3YjYgFFONCJVqn
BT16h/Pu
=vNlA
-----END PGP SIGNATURE-----

--w0SMhJ/0vwg+/RIs--
