Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0218DCD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 10:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E37188428;
	Thu,  4 Apr 2024 12:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EOnkTvro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF838841C; Thu,  4 Apr 2024 12:58:42 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7378843E
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 12:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4161bee0959so1738345e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712228318; x=1712833118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cc8GWxLh1vqCv6SbVs8EmeyJB+Hp04j6FGDMBwE3ikk=;
 b=EOnkTvro+RNjKpdBnCWmRfC1nCIpKbmiFbHHlpYBWqTEj7AJE9/zonDkQyW2Gxotu+
 U+eO6UvV2EKRniKD+H/SAOu1mzY6fWxRr2SgWSqSWMCljrzXwWD0BBpgZQV9ysDA7CwZ
 HnriJyF+NonEPP/1rMiUW878XnhE/ej4KlK3xnkOLHncQd71psHOzPpkrpO3VNdHAHIH
 47GKE3yFCv15MQLP6gy5Bd2BCL2OpAtz1yrFTCRTVNKUZv0fC09RzDcPDSjVuR5rN5dc
 oHZfSPBV5jrzYZ79j7NOJtTnYWoqPEc/a40xCzJVG2rpW7bgNqHZ5aI45A0XHLRzObrA
 uoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712228318; x=1712833118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cc8GWxLh1vqCv6SbVs8EmeyJB+Hp04j6FGDMBwE3ikk=;
 b=IjlXRtymnFcDXWV9kflyHpE8PCVNqAOCXfTcYtpJZYHVBziE7ywZK3Aycx6Wj2/hox
 EVL1zynMT22qAl5hfbm6UdNFW3MNL7kNeXLIvA21qy6+SJY7gzEuuyP3Tdz+K8qsj9oY
 jXsoygT1vt6mBr8w4/U6uIiv5T7JDxvVwL1x81kwbot2HK78fPS11cLTnu6JCensDP8J
 qthrZ/5QYkpZdmN03XaqvS3xkvmsCoXG5c37Mb4u4M7UsLtDHOyf9aRmPzTC7I1sLLyL
 UL4yC2dF2w1nousqeC75msUKxaHSjItEFnV7fMjS9JG78N3cwCx6D1Zp3rMkmlE7HOk7
 7vqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnBvj/bXXtXaKHrQRoSgB2yJgwIEhec/IcFWRbWFrF6xbZjfY02CKnJ5DOcQx5DJrZCwrSAC9ZjkMvP/tZTcduBE7k2A==
X-Gm-Message-State: AOJu0YywPnPcVIZg2kWc24SkRUzWwhB8+cVcVlZElmqtPLxJP/tE/1ml
 n3ihoZenW/KeRbLQAO9S4OD7LCg5ihV0Nr2F2nrMFC0zekng+0zTcFd9EhoY7J4fTo+i/JpRzus
 5RLnY0ewHP2p+8YOhXr8bU0b3onY=
X-Google-Smtp-Source: AGHT+IEpT5/yuvTDcjibi7fJKTnFsbOrVMhjxrfVMkYZnfSN/IqSU4zJ6mJbiZAkoYyENQyWtzs8n4hFMo6GyZn/eIU=
X-Received: by 2002:adf:f088:0:b0:343:d06e:51f5 with SMTP id
 n8-20020adff088000000b00343d06e51f5mr118560wro.1.1712228317650; Thu, 04 Apr
 2024 03:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
 <20240404081352.3224643-3-igor.opaniuk@gmail.com> <Zg5ngbQinAX6bOjM@hera>
 <CAByghJa6FG-hUaNr5ZQbzDXehQO0-sD16x_Ni5vKwnRkfagM9A@mail.gmail.com>
In-Reply-To: <CAByghJa6FG-hUaNr5ZQbzDXehQO0-sD16x_Ni5vKwnRkfagM9A@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 4 Apr 2024 12:58:26 +0200
Message-ID: <CAByghJa2U4EriJF8a3MEq_PA20e5HzrsY9aR8w+u+bjFbXtXtA@mail.gmail.com>
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

HI Ilias

On Thu, Apr 4, 2024 at 12:15=E2=80=AFPM Igor Opaniuk <igor.opaniuk@gmail.co=
m> wrote:

> Hi Ilias,
>
> On Thu, Apr 4, 2024 at 10:40=E2=80=AFAM Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
>
>> Hi Igor,
>>
>> I was about to apply the series, but noticed neither me or Jens were cc'=
ed
>> on this. Adding Jens to the party
>>
> I usually rely on automatic CC-list creation by patman. Looks like there
> is no
> entry in MAINTAINERS for this specific file, that's why only Tom was adde=
d.
> I'll send a patch for that if you don't mind.
>

I've added all orphaned tee-related files to MAINTAINERS in [1], so I patma=
n
should  generate the CC list correctly next time.

[1]
https://lore.kernel.org/u-boot/20240404105248.3241506-1-igor.opaniuk@gmail.=
com/T/#u


>
>
>> On Thu, Apr 04, 2024 at 10:13:49AM +0200, Igor Opaniuk wrote:
>> > Add calls for closing tee session after every read/write operation.
>>
>> What the patch is pretty obvious, but I am missing an explanation of why
>> this is needed
>>
>> >
>> > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
>> > ---
>> >
>> > (no changes since v1)
>> >
>> >  cmd/optee_rpmb.c | 23 +++++++++++++++++------
>> >  1 file changed, 17 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
>> > index e0e44bbed04..b3cafd92410 100644
>> > --- a/cmd/optee_rpmb.c
>> > +++ b/cmd/optee_rpmb.c
>> > @@ -87,8 +87,10 @@ static int read_persistent_value(const char *name,
>> >
>> >       rc =3D tee_shm_alloc(tee, name_size,
>> >                          TEE_SHM_ALLOC, &shm_name);
>> > -     if (rc)
>> > -             return -ENOMEM;
>> > +     if (rc) {
>> > +             rc =3D -ENOMEM;
>> > +             goto close_session;
>> > +     }
>>
>> I don't think you need the session to be opened to allocate memory.
>> So instead of of doing this, why don't we just move the alloc call befor=
e
>> opening the session?
>>
> That's correct, but avb_ta_open_session() wrapper calls
> both tee_find_device()/
> tee_open_session(), and tee_shm_alloc() expects valid tee device as param=
,
> which
> is initialized by tee_find_device(). My intention was to address the only
> one particular issue
> that was catched by CI and explained in [1] instead of doing overhaul of
> the whole optee_rpmb cmd implementation.
>
>
>> >
>> >       rc =3D tee_shm_alloc(tee, buffer_size,
>> >                          TEE_SHM_ALLOC, &shm_buf);
>> > @@ -125,6 +127,9 @@ out:
>> >       tee_shm_free(shm_buf);
>> >  free_name:
>> >       tee_shm_free(shm_name);
>> > +close_session:
>> > +     tee_close_session(tee, session);
>> > +     tee =3D NULL;
>> >
>> >       return rc;
>> >  }
>> > @@ -139,17 +144,20 @@ static int write_persistent_value(const char
>> *name,
>> >       struct tee_param param[2];
>> >       size_t name_size =3D strlen(name) + 1;
>> >
>> > +     if (!value_size)
>> > +             return -EINVAL;
>> > +
>> >       if (!tee) {
>> >               if (avb_ta_open_session())
>> >                       return -ENODEV;
>> >       }
>> > -     if (!value_size)
>> > -             return -EINVAL;
>> >
>> >       rc =3D tee_shm_alloc(tee, name_size,
>> >                          TEE_SHM_ALLOC, &shm_name);
>> > -     if (rc)
>> > -             return -ENOMEM;
>> > +     if (rc) {
>> > +             rc =3D -ENOMEM;
>> > +             goto close_session;
>> > +     }
>>
>> ditto
>>
>> >
>> >       rc =3D tee_shm_alloc(tee, value_size,
>> >                          TEE_SHM_ALLOC, &shm_buf);
>> > @@ -178,6 +186,9 @@ out:
>> >       tee_shm_free(shm_buf);
>> >  free_name:
>> >       tee_shm_free(shm_name);
>> > +close_session:
>> > +     tee_close_session(tee, session);
>> > +     tee =3D NULL;
>> >
>> >       return rc;
>> >  }
>> > --
>> > 2.34.1
>> >
>>
>> Thanks
>> /Ilias
>>
>
> [1]
> https://lore.kernel.org/all/20240302220108.720637-5-igor.opaniuk@gmail.co=
m/T/
>
> --
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
>


--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
