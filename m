Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9078CCD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B35A8840E;
	Thu,  4 Apr 2024 10:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bSEI0Okq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C2EE8840C; Thu,  4 Apr 2024 10:54:33 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B2B88253
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d109e82bd0so6807041fa.3
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712220870; x=1712825670; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BL006ev3pQXxGpgMscmNy2t4nPymeYp2/UXMIxfzDIE=;
 b=bSEI0Okq6MUvgEsW9UbRHQXfLEJshHyPmEy+Tkg3Uxcdro91DTTHlft52viv0rHPOs
 qEd/WajM/HN4mTlyrYOWGtZ/k7TOqsFkTkopiqOctoCIxdlQhGdYgxdEg8ooDo+uGv/t
 oUlkuXnQnCUpZNfUbUv95Gre3oPzu+WdZUxjGqNlGPffQgmyZjpBVOWuvgdh4SmHFJ0E
 Hgh9ky8QSeKZgTcwj2G9BC0XYo4bbV/vGav+1F/JDARw5U0dEIy08Mp4UmgR6W34BQpQ
 ME00wBFdR7z3a0xHoVtdD5n2hZ2LROJNXdG4ILyan2ZE/83wiiKrD9odtSC5amdfNwdw
 s/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712220870; x=1712825670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BL006ev3pQXxGpgMscmNy2t4nPymeYp2/UXMIxfzDIE=;
 b=LfOXdMCGiTZEm17TOt+AYnwUaNbjYQV1TNSHDmDFrMzcye7NOSV1C1KuIaBrmOo8b2
 Ce7E4Qv338tr2PsbZ4WaIyO8uXOarlzXI0oL99pdUV+97RWUE2O34W7kJOY7QJctGhzj
 1grxhlHakImRf5DYdMmE6iTxZEBhf/z3dZVdyI/MvaTbNRLDvOHcSn10Qc5ciEqYkqtG
 v9C88lJPE3vLbSsIaUdQZvthHizQscKXkv6dYz6Iv1SzGVLK7YLiffYz9HrOozAdy4YN
 7gdC/9sV9A/8aHG1ucn3QiGNvl4uW5l/kJItjHwchI2sVhpgjzr82bfXKFO+I1SaNAMG
 sklQ==
X-Gm-Message-State: AOJu0Yw+U/93Ibldfu+U6Wqc6MiidRBnd2raCXQr5BVDd3z06bJIte3v
 hInOVTsRVI0O48fOzq/eYKnJSubWrUzMJ1KtUbHYtZ5MEl0NIPEq0lFVL0RKJyRVATENbiR8SfO
 z2Z4elhagmSjZbk2aneqsc96oNosneRVrcfGeUAxmSXQxKE+VPqA=
X-Google-Smtp-Source: AGHT+IFayNlUxqWpIY5DXJ80j9wxAs75lN7FzZxrGg8fRb8wqieJ/d+Wcl/wPQ7N5oj6rSFm7LMaa/NBry2egaP00mE=
X-Received: by 2002:a2e:b94e:0:b0:2d8:5a90:6757 with SMTP id
 14-20020a2eb94e000000b002d85a906757mr600408ljs.9.1712220870548; Thu, 04 Apr
 2024 01:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
 <20240404081352.3224643-3-igor.opaniuk@gmail.com> <Zg5ngbQinAX6bOjM@hera>
In-Reply-To: <Zg5ngbQinAX6bOjM@hera>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Apr 2024 11:53:54 +0300
Message-ID: <CAC_iWjL48gDx2dKnB=+OO=3kLMdvU+9cOst4Oj4gtX2bN=7toQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] cmd: optee_rpmb: close tee session
To: Igor Opaniuk <igor.opaniuk@gmail.com>, jens.wiklander@linaro.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 4 Apr 2024 at 11:40, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Igor,
>
> I was about to apply the series, but noticed neither me or Jens were cc'ed
> on this. Adding Jens to the party
>
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
> >       rc = tee_shm_alloc(tee, name_size,
> >                          TEE_SHM_ALLOC, &shm_name);
> > -     if (rc)
> > -             return -ENOMEM;
> > +     if (rc) {
> > +             rc = -ENOMEM;
> > +             goto close_session;
> > +     }
>
> I don't think you need the session to be opened to allocate memory.
> So instead of of doing this, why don't we just move the alloc call before
> opening the session?

Looking at it again, we do need tee != NULL, but I think it's cleaner
to add something like
if (!dev)
    return -ENODEV
to __tee_shm_add() instead.

Cheers
/Ilias
>
> >
> >       rc = tee_shm_alloc(tee, buffer_size,
> >                          TEE_SHM_ALLOC, &shm_buf);
> > @@ -125,6 +127,9 @@ out:
> >       tee_shm_free(shm_buf);
> >  free_name:
> >       tee_shm_free(shm_name);
> > +close_session:
> > +     tee_close_session(tee, session);
> > +     tee = NULL;
> >
> >       return rc;
> >  }
> > @@ -139,17 +144,20 @@ static int write_persistent_value(const char *name,
> >       struct tee_param param[2];
> >       size_t name_size = strlen(name) + 1;
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
> >       rc = tee_shm_alloc(tee, name_size,
> >                          TEE_SHM_ALLOC, &shm_name);
> > -     if (rc)
> > -             return -ENOMEM;
> > +     if (rc) {
> > +             rc = -ENOMEM;
> > +             goto close_session;
> > +     }
>
> ditto
>
> >
> >       rc = tee_shm_alloc(tee, value_size,
> >                          TEE_SHM_ALLOC, &shm_buf);
> > @@ -178,6 +186,9 @@ out:
> >       tee_shm_free(shm_buf);
> >  free_name:
> >       tee_shm_free(shm_name);
> > +close_session:
> > +     tee_close_session(tee, session);
> > +     tee = NULL;
> >
> >       return rc;
> >  }
> > --
> > 2.34.1
> >
>
> Thanks
> /Ilias
