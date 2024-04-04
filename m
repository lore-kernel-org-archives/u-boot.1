Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2AACD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 10:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEF888407;
	Thu,  4 Apr 2024 12:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gU6O0Pwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3658488407; Thu,  4 Apr 2024 12:18:33 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 913A0883FB
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 12:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3436fab3d29so61593f8f.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712225909; x=1712830709; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JAnEEl63IS73fnU0zzQMM8SrNWyuT+pUOqnbk1/7USY=;
 b=gU6O0PwyonSsOK2DOUMBNty42ZUUPvt2agmZWffh5sEuMCiPgNZNoz994MO1UwWfK0
 dlV78QoRVtyrlPyB1Fefpd5uS8twBaXJuIe9wnTqUVXLrPyk9w+yonKXJuSfSOEgfuZ9
 mDAyxVJ3cU3sBrQ+/ugNrYNTox5EvmbvRC5kYTRLYON+KGyHk7neGzcnxGSyqupp52hm
 apc0xo+bJCPbHLhORaP3XbwnN04xh8t+4hzghX2Zkpawyl35XW5wI7ILbgORoCHXZ0kn
 N9yM+lbGm90Adv252PXQXjYFodDUWeSb7spGcG+iTyn9e4uNdmJbWNMep3RfzQlqyBCd
 /zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712225909; x=1712830709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JAnEEl63IS73fnU0zzQMM8SrNWyuT+pUOqnbk1/7USY=;
 b=IjvZmAFLX0LotXBCdP22ksfI0szDeJkKjTuRQzWxdm1EgH/B70TfJEoVad9FHSyLCa
 SbeNodnQoNJIoZviQF7AWqykl9Cq1GUeDl7GEqlG0TJZwRmTSD42RZooOuP4hOj7vSN6
 O4B8Co5J6rl6pDX+tpyg4OUDM+C0P4ni3iqzO3+cdiyGsiJjfk/ElxPPe1lbxsvXpgN6
 SLjv9TNeLfO+iygd3B4lvCmze/24ZETXVkY2rBZK3r6ZeTJFI5aQ0mD91JpKMyrsUjhX
 9xo6hwldbYTwqSp3bJqGPeijd0DjnHn8Ndkl6iiczYBUgS0Fj/B+nRZhr0vLxZlnt12X
 A2iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5U50RoLkikpTqyzt1uVVuM8zpLFhI1CqSlSGzU2mpzf8a3S5E2R6EqvVaK0kspnvBEXRdLthhVDOfT+/UdrtF8Y1fFQ==
X-Gm-Message-State: AOJu0Yz2Enrv4WY8wYy3i1RCmcO18atQSahEQDH7rEPKTo+0VHooZOqJ
 3V3zNO/JN1zVyQLXaYz26F5YYRQWuD36JyIsB5ApdSZ7mWqSLiDFmsCUQDaIelbooLeUhxH79XI
 UKV5L5RQrbjkFNuJpq9L3iwQ4gvI=
X-Google-Smtp-Source: AGHT+IHA6P4KCPPpx5xwVuvbwgY00E8jbS5vxKl4B9KTrWG3M4BXIN7VAkFSiPl9iBpYrMdpoFbAG7Wrerps5qk8rJw=
X-Received: by 2002:a5d:4577:0:b0:343:b81a:9d9b with SMTP id
 a23-20020a5d4577000000b00343b81a9d9bmr1086931wrc.7.1712225908827; Thu, 04 Apr
 2024 03:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
 <20240404081352.3224643-3-igor.opaniuk@gmail.com> <Zg5ngbQinAX6bOjM@hera>
 <CAC_iWjL48gDx2dKnB=+OO=3kLMdvU+9cOst4Oj4gtX2bN=7toQ@mail.gmail.com>
In-Reply-To: <CAC_iWjL48gDx2dKnB=+OO=3kLMdvU+9cOst4Oj4gtX2bN=7toQ@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 4 Apr 2024 12:18:17 +0200
Message-ID: <CAByghJZ+5J7uDzL54_apX3cAb5tGSk5yQmtR7cOaEtNTFZ-dLA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] cmd: optee_rpmb: close tee session
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jens.wiklander@linaro.org, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Thu, Apr 4, 2024 at 10:54=E2=80=AFAM Ilias Apalodimas <
ilias.apalodimas@linaro.org> wrote:

> Hi Igor,
>
> On Thu, 4 Apr 2024 at 11:40, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Igor,
> >
> > I was about to apply the series, but noticed neither me or Jens were
> cc'ed
> > on this. Adding Jens to the party
> >
> > On Thu, Apr 04, 2024 at 10:13:49AM +0200, Igor Opaniuk wrote:
> > > Add calls for closing tee session after every read/write operation.
> >
> > What the patch is pretty obvious, but I am missing an explanation of wh=
y
> > this is needed
> >
> > >
> > > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  cmd/optee_rpmb.c | 23 +++++++++++++++++------
> > >  1 file changed, 17 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
> > > index e0e44bbed04..b3cafd92410 100644
> > > --- a/cmd/optee_rpmb.c
> > > +++ b/cmd/optee_rpmb.c
> > > @@ -87,8 +87,10 @@ static int read_persistent_value(const char *name,
> > >
> > >       rc =3D tee_shm_alloc(tee, name_size,
> > >                          TEE_SHM_ALLOC, &shm_name);
> > > -     if (rc)
> > > -             return -ENOMEM;
> > > +     if (rc) {
> > > +             rc =3D -ENOMEM;
> > > +             goto close_session;
> > > +     }
> >
> > I don't think you need the session to be opened to allocate memory.
> > So instead of of doing this, why don't we just move the alloc call befo=
re
> > opening the session?
>
> Looking at it again, we do need tee !=3D NULL, but I think it's cleaner
> to add something like
> if (!dev)
>     return -ENODEV
> to __tee_shm_add() instead.
>
Do you mind if I address that in a separate patch series, as tbh I
don't want to add additional patches to the existing series?


>
> Cheers
> /Ilias
> >
> > >
> > >       rc =3D tee_shm_alloc(tee, buffer_size,
> > >                          TEE_SHM_ALLOC, &shm_buf);
> > > @@ -125,6 +127,9 @@ out:
> > >       tee_shm_free(shm_buf);
> > >  free_name:
> > >       tee_shm_free(shm_name);
> > > +close_session:
> > > +     tee_close_session(tee, session);
> > > +     tee =3D NULL;
> > >
> > >       return rc;
> > >  }
> > > @@ -139,17 +144,20 @@ static int write_persistent_value(const char
> *name,
> > >       struct tee_param param[2];
> > >       size_t name_size =3D strlen(name) + 1;
> > >
> > > +     if (!value_size)
> > > +             return -EINVAL;
> > > +
> > >       if (!tee) {
> > >               if (avb_ta_open_session())
> > >                       return -ENODEV;
> > >       }
> > > -     if (!value_size)
> > > -             return -EINVAL;
> > >
> > >       rc =3D tee_shm_alloc(tee, name_size,
> > >                          TEE_SHM_ALLOC, &shm_name);
> > > -     if (rc)
> > > -             return -ENOMEM;
> > > +     if (rc) {
> > > +             rc =3D -ENOMEM;
> > > +             goto close_session;
> > > +     }
> >
> > ditto
> >
> > >
> > >       rc =3D tee_shm_alloc(tee, value_size,
> > >                          TEE_SHM_ALLOC, &shm_buf);
> > > @@ -178,6 +186,9 @@ out:
> > >       tee_shm_free(shm_buf);
> > >  free_name:
> > >       tee_shm_free(shm_name);
> > > +close_session:
> > > +     tee_close_session(tee, session);
> > > +     tee =3D NULL;
> > >
> > >       return rc;
> > >  }
> > > --
> > > 2.34.1
> > >
> >
> > Thanks
> > /Ilias
>



--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
