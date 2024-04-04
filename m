Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F19CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 10:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E47D1883FF;
	Thu,  4 Apr 2024 12:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRODugdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D39788407; Thu,  4 Apr 2024 12:15:26 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED26B883FB
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 12:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-414953e580eso359775e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 03:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712225723; x=1712830523; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a9qoTUvW1s0hg/Eni8BVqJYy71waekYKnGuLEOh4vRo=;
 b=gRODugdrHBMcS7V8o2jQfUuKymBKz/wMkPHjaZP/SsxYItTLW2MRldka0qwVuvo/7o
 Z14dcOZpjket7413ngS/OcDLXoPsDdiLNY5LHhHsRbwJIYYrY4Ra1o46TykHKfs11UkR
 /SapSJeF0AGd/O50t+lG/30QMBu7RzU7jBf356/MkBqboypz9sH7tfuk2IpHydOhvkhX
 VWfA5dkbucrc3sUttREOzH5eix09p3HAYawbeNYSgSgFf/u8rDM7t9aGR4TNgv4YOO7D
 ZFkGCEYwcgBCY0aHehjUEerTqLLNQTzTX49F1ot5U81R+SvI/pkQfnae9p+atqCt7T4Y
 TrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712225723; x=1712830523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a9qoTUvW1s0hg/Eni8BVqJYy71waekYKnGuLEOh4vRo=;
 b=wH/1wpvqboOxDvSlJABLn/PZIkQWm05/1i8iIRTQFlMgxQwFp4R8uDr1PtL8PT0Bjv
 284zrjO/FGpIOv8DiNDVW7LRsXrqyUAi/hhDs53JVTgHi9XyYwhbeL/guurDWTt+P5sr
 5QCoHmTdNSDJ9DSkQz3LQjOjssZl96AWmU6vB5G7wJYHbbjZMF1BlzQvcN9PurgtIIy6
 Zhox8xlhB95qBl7vGXCzMlgSGo1xoDingIRPIrVDVu2O2yngyAVPaGF5KKnUY4jK3A37
 9AjYUb5aQdG7zHtl21GNFF0dDXxnoaA+KsWap8fdZ9/dPqCYf467yPu1a8H1DSGaUG49
 /kZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2fPnHkmNJyyrRtiv4EgtbY8y6m5FfOlgQCISdOSDTiA16p1HrCBHR9bTxSaBQgOZt0dIUKkdmEfJrkHNAKZgKeN/Evg==
X-Gm-Message-State: AOJu0Yyq9pXBjBGryceRWjZOGcwL+OVYzq/SGFHDXh4hNfEEd49UjCzH
 wIgG5dQICsiVI2DmJCeSO9VClSNlIMdRzMgadA7b+T7NMigsIJe7bRq8XcaeN2ZRWM7yAEoWypU
 zkzQQkveefBdYnc3gFjGEj5ZCl+4=
X-Google-Smtp-Source: AGHT+IE+0ffZVsQsAV5QkBYD63NcCkKDm1hBgT4cmEasRwI1suXoihNTHMQsQ2E8gWDYv1lAJFCER8bTEJARXX77FKI=
X-Received: by 2002:a05:600c:1d17:b0:414:8084:a2e7 with SMTP id
 l23-20020a05600c1d1700b004148084a2e7mr1643112wms.4.1712225723014; Thu, 04 Apr
 2024 03:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
 <20240404081352.3224643-3-igor.opaniuk@gmail.com> <Zg5ngbQinAX6bOjM@hera>
In-Reply-To: <Zg5ngbQinAX6bOjM@hera>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 4 Apr 2024 12:15:11 +0200
Message-ID: <CAByghJa6FG-hUaNr5ZQbzDXehQO0-sD16x_Ni5vKwnRkfagM9A@mail.gmail.com>
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

On Thu, Apr 4, 2024 at 10:40=E2=80=AFAM Ilias Apalodimas <
ilias.apalodimas@linaro.org> wrote:

> Hi Igor,
>
> I was about to apply the series, but noticed neither me or Jens were cc'e=
d
> on this. Adding Jens to the party
>
I usually rely on automatic CC-list creation by patman. Looks like there is
no
entry in MAINTAINERS for this specific file, that's why only Tom was added.
I'll send a patch for that if you don't mind.


> On Thu, Apr 04, 2024 at 10:13:49AM +0200, Igor Opaniuk wrote:
> > Add calls for closing tee session after every read/write operation.
>
> What the patch is pretty obvious, but I am missing an explanation of why
> this is needed
>
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> > ---
> >
> > (no changes since v1)
> >
> >  cmd/optee_rpmb.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
> > index e0e44bbed04..b3cafd92410 100644
> > --- a/cmd/optee_rpmb.c
> > +++ b/cmd/optee_rpmb.c
> > @@ -87,8 +87,10 @@ static int read_persistent_value(const char *name,
> >
> >       rc =3D tee_shm_alloc(tee, name_size,
> >                          TEE_SHM_ALLOC, &shm_name);
> > -     if (rc)
> > -             return -ENOMEM;
> > +     if (rc) {
> > +             rc =3D -ENOMEM;
> > +             goto close_session;
> > +     }
>
> I don't think you need the session to be opened to allocate memory.
> So instead of of doing this, why don't we just move the alloc call before
> opening the session?
>
That's correct, but avb_ta_open_session() wrapper calls
both tee_find_device()/
tee_open_session(), and tee_shm_alloc() expects valid tee device as param,
which
is initialized by tee_find_device(). My intention was to address the only
one particular issue
that was catched by CI and explained in [1] instead of doing overhaul of
the whole optee_rpmb cmd implementation.


> >
> >       rc =3D tee_shm_alloc(tee, buffer_size,
> >                          TEE_SHM_ALLOC, &shm_buf);
> > @@ -125,6 +127,9 @@ out:
> >       tee_shm_free(shm_buf);
> >  free_name:
> >       tee_shm_free(shm_name);
> > +close_session:
> > +     tee_close_session(tee, session);
> > +     tee =3D NULL;
> >
> >       return rc;
> >  }
> > @@ -139,17 +144,20 @@ static int write_persistent_value(const char *nam=
e,
> >       struct tee_param param[2];
> >       size_t name_size =3D strlen(name) + 1;
> >
> > +     if (!value_size)
> > +             return -EINVAL;
> > +
> >       if (!tee) {
> >               if (avb_ta_open_session())
> >                       return -ENODEV;
> >       }
> > -     if (!value_size)
> > -             return -EINVAL;
> >
> >       rc =3D tee_shm_alloc(tee, name_size,
> >                          TEE_SHM_ALLOC, &shm_name);
> > -     if (rc)
> > -             return -ENOMEM;
> > +     if (rc) {
> > +             rc =3D -ENOMEM;
> > +             goto close_session;
> > +     }
>
> ditto
>
> >
> >       rc =3D tee_shm_alloc(tee, value_size,
> >                          TEE_SHM_ALLOC, &shm_buf);
> > @@ -178,6 +186,9 @@ out:
> >       tee_shm_free(shm_buf);
> >  free_name:
> >       tee_shm_free(shm_name);
> > +close_session:
> > +     tee_close_session(tee, session);
> > +     tee =3D NULL;
> >
> >       return rc;
> >  }
> > --
> > 2.34.1
> >
>
> Thanks
> /Ilias
>

[1]
https://lore.kernel.org/all/20240302220108.720637-5-igor.opaniuk@gmail.com/=
T/

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
