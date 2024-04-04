Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81899CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 11:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03B928842F;
	Thu,  4 Apr 2024 13:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QSnL0dwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D6B8842E; Thu,  4 Apr 2024 13:00:26 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4002687D8E
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d71765d3e1so10083261fa.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712228423; x=1712833223; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FA0iUOraTpBsPEeXHQtEOFr4nXLqPUe6H615nMzKzDw=;
 b=QSnL0dwX84wdoDy3tk+f73UR0I92urABVOCbusq/3KfSJ1D3EX63PIEdeti/8m0wzv
 y0y3nEPcxgvXcp9yhN/y6AOfXMOvaCNLhxjMkKaJfpbLJtUZPpW+iZFgzRWTFhn6eRON
 XUjeqI2hTkwZceIHpy/vT9iatEiHVlib95L6pPaq3YvcObHTi0D1qPQA5EXzFdHF/yu5
 qX419THIoIjOPONtsltZIQ7a/aUWLn3ct37C8jL0HfNxuM/xPpqQzRZdn11snXBmtXPU
 K7DllZOVeE0I10pa8QQ94oc3CCpJZ7TVwFxI82osRaP3gpVBJc16PDSv7HupyP0Bh0Kl
 LZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712228423; x=1712833223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FA0iUOraTpBsPEeXHQtEOFr4nXLqPUe6H615nMzKzDw=;
 b=aCcLdUwhB8q1Qgmcr6Ydus2RBUqcORNuz3ES+CjGpvnam+hgz+ftajXEMChM4nyIED
 QZF84enMTP05YdTXIdFsAApJbBI3vv6tRj7q1T77mHDXVkZ1l+TyDIlN3S0nK75BIxnQ
 DF9NlQaELKFm57ym6PZEYZ+Snb0Tqp4wjbxqmqLZFwyMrVpQe9/WjH6ao7e4kVc7YeTw
 g3mN7EbEKqkU8C77AneDu79Mpmz5mM2W/MYbL1he/MgokBTw0ZF4kiFHWEHUq3/Lv5Zv
 ii+/rO7H40XtvUnOOxXf1xHHzoWHU4Hjnpxns6/l6vDv+ga+zIbcHNwDa38lTug8WGxc
 dGwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGv7N7I6Af1b8zsbKab6nV5qJOo+J44aYWek0PZL0CneOBJk77U2T5MT8Cc/VGg5KGvTWppgPasqZW5qHVE9FQYQIsKA==
X-Gm-Message-State: AOJu0YyqkDrYr2ZQwd1dpe2+e3tEUHuGfkeyACk0cD0I8lkGV+ErW6ML
 466f2Z3iiKJkhCvcgIZoFNJ13MgjlZ5y+lOvqBqbm7wPjF5QllYp0ILL2CgTwW5eDz4TCzvKrHq
 EkrlErpuG+iMA+RVUkF8CbgFEnAZRt8zYjoh6eA==
X-Google-Smtp-Source: AGHT+IFlaaxHuBEkSCr654mtssIYLt737w+SvjrV46FJE9nYV7ZAX+SCvnsYLEZBeBrnETUyx7rhG8XsfTmufhMCZXk=
X-Received: by 2002:a2e:8e26:0:b0:2d8:5e21:8eaf with SMTP id
 r6-20020a2e8e26000000b002d85e218eafmr510777ljk.41.1712228423435; Thu, 04 Apr
 2024 04:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
 <20240404081352.3224643-3-igor.opaniuk@gmail.com> <Zg5ngbQinAX6bOjM@hera>
 <CAC_iWjL48gDx2dKnB=+OO=3kLMdvU+9cOst4Oj4gtX2bN=7toQ@mail.gmail.com>
 <CAByghJZ+5J7uDzL54_apX3cAb5tGSk5yQmtR7cOaEtNTFZ-dLA@mail.gmail.com>
In-Reply-To: <CAByghJZ+5J7uDzL54_apX3cAb5tGSk5yQmtR7cOaEtNTFZ-dLA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Apr 2024 13:59:46 +0300
Message-ID: <CAC_iWjLCQHRjNbgxoth4cRH8Ju+PBoRXmNwpkZjae2zxCy1cBw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] cmd: optee_rpmb: close tee session
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: jens.wiklander@linaro.org, u-boot@lists.denx.de, 
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

Hi Igor,

On Thu, 4 Apr 2024 at 13:18, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> Hi Ilias,
>
> On Thu, Apr 4, 2024 at 10:54=E2=80=AFAM Ilias Apalodimas <ilias.apalodima=
s@linaro.org> wrote:
>>
>> Hi Igor,
>>
>> On Thu, 4 Apr 2024 at 11:40, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>> >
>> > Hi Igor,
>> >
>> > I was about to apply the series, but noticed neither me or Jens were c=
c'ed
>> > on this. Adding Jens to the party
>> >
>> > On Thu, Apr 04, 2024 at 10:13:49AM +0200, Igor Opaniuk wrote:
>> > > Add calls for closing tee session after every read/write operation.
>> >
>> > What the patch is pretty obvious, but I am missing an explanation of w=
hy
>> > this is needed
>> >
>> > >
>> > > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
>> > > ---
>> > >
>> > > (no changes since v1)
>> > >
>> > >  cmd/optee_rpmb.c | 23 +++++++++++++++++------
>> > >  1 file changed, 17 insertions(+), 6 deletions(-)
>> > >
>> > > diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
>> > > index e0e44bbed04..b3cafd92410 100644
>> > > --- a/cmd/optee_rpmb.c
>> > > +++ b/cmd/optee_rpmb.c
>> > > @@ -87,8 +87,10 @@ static int read_persistent_value(const char *name=
,
>> > >
>> > >       rc =3D tee_shm_alloc(tee, name_size,
>> > >                          TEE_SHM_ALLOC, &shm_name);
>> > > -     if (rc)
>> > > -             return -ENOMEM;
>> > > +     if (rc) {
>> > > +             rc =3D -ENOMEM;
>> > > +             goto close_session;
>> > > +     }
>> >
>> > I don't think you need the session to be opened to allocate memory.
>> > So instead of of doing this, why don't we just move the alloc call bef=
ore
>> > opening the session?
>>
>> Looking at it again, we do need tee !=3D NULL, but I think it's cleaner
>> to add something like
>> if (!dev)
>>     return -ENODEV
>> to __tee_shm_add() instead.
>
> Do you mind if I address that in a separate patch series, as tbh I
> don't want to add additional patches to the existing series?

We still completely change the functionality. So, the patchset is not
a 'tiny cleanup', it instead closes the session every time instead of
keeping it open.
There are a few things going on, that aren't explained clearly in the
commit message
- Why is this needed? Looking at the code it is an actual problem
since sessions tied to the AVB uuid will remain open
- Is there any side effect by always closing the session?
I don't mind merging it as is with a proper commit message, but I
think the alternative is just easier.

Thanks
/Ilias

>
>>
>>
>> Cheers
>> /Ilias
>> >
>> > >
>> > >       rc =3D tee_shm_alloc(tee, buffer_size,
>> > >                          TEE_SHM_ALLOC, &shm_buf);
>> > > @@ -125,6 +127,9 @@ out:
>> > >       tee_shm_free(shm_buf);
>> > >  free_name:
>> > >       tee_shm_free(shm_name);
>> > > +close_session:
>> > > +     tee_close_session(tee, session);
>> > > +     tee =3D NULL;
>> > >
>> > >       return rc;
>> > >  }
>> > > @@ -139,17 +144,20 @@ static int write_persistent_value(const char *=
name,
>> > >       struct tee_param param[2];
>> > >       size_t name_size =3D strlen(name) + 1;
>> > >
>> > > +     if (!value_size)
>> > > +             return -EINVAL;
>> > > +
>> > >       if (!tee) {
>> > >               if (avb_ta_open_session())
>> > >                       return -ENODEV;
>> > >       }
>> > > -     if (!value_size)
>> > > -             return -EINVAL;
>> > >
>> > >       rc =3D tee_shm_alloc(tee, name_size,
>> > >                          TEE_SHM_ALLOC, &shm_name);
>> > > -     if (rc)
>> > > -             return -ENOMEM;
>> > > +     if (rc) {
>> > > +             rc =3D -ENOMEM;
>> > > +             goto close_session;
>> > > +     }
>> >
>> > ditto
>> >
>> > >
>> > >       rc =3D tee_shm_alloc(tee, value_size,
>> > >                          TEE_SHM_ALLOC, &shm_buf);
>> > > @@ -178,6 +186,9 @@ out:
>> > >       tee_shm_free(shm_buf);
>> > >  free_name:
>> > >       tee_shm_free(shm_name);
>> > > +close_session:
>> > > +     tee_close_session(tee, session);
>> > > +     tee =3D NULL;
>> > >
>> > >       return rc;
>> > >  }
>> > > --
>> > > 2.34.1
>> > >
>> >
>> > Thanks
>> > /Ilias
>
>
>
>
> --
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk
