Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E04CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 11:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A0F68842C;
	Thu,  4 Apr 2024 13:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D/zOVGL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE6B88436; Thu,  4 Apr 2024 13:46:50 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00BE1883D6
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d4886a1cb4so10617701fa.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712231207; x=1712836007; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdlVW73c4LSN2MpqDmucKvZQzPPMCfRmddQdCVSzcDE=;
 b=D/zOVGL6tZI88q/tHrhFV9eVRDBNRUPuvcedD5zhPdlHYlp6BpYS5cvxWQb+4oT7IQ
 tMWsX63GOTerGXEDl2Us8JtC/7zJU5hbxB40MJ2VP85xcafCp6Vmjf86Z1bkvICqsRiW
 pPjRuSGiURtqXPP/vhga9cvWJ63DbgUyA8wNvjlkY2QZHcxyLaEVucUJhnIw8fcoJfwz
 3shGPxQ2ULL2L6KrZlmj4D+0v65YoX1yr2MmNGafDzbirM8WbTkFvbwHHEiXVdd26rCQ
 aYUQYP1oqN2sD7eH+5v52olGjMM4JU42IbNyH25R7yqLGwBfLwqbpH5MW5hYQFkytZnH
 bEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712231207; x=1712836007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VdlVW73c4LSN2MpqDmucKvZQzPPMCfRmddQdCVSzcDE=;
 b=J63DDWIf1dh/0ryEdFpGKyNHAfYgOBh9u6Od7P2B43K9MHM4sZ2RenQP7I1QzCV2pw
 LTzlsfW1fnPCMKtOuf2Zdjg9CQM45nTIk4L17ckQtfNa5nduMH7cX/6VBmiApocs8dNQ
 zs8sUULYnRINYqqgO/rJhjlDhL06O/MzuaANAB7tvywS2aTRSxHMRICocWjSTd1MIV2D
 N3kRVaZxdwx4JvS//TS1fJOXDEsu6RUMx1YN8ZuUHK5cYD1GJYGIisKZT+I544HZxZpr
 4NNkzPacm3BMk92vZMVzY4RgYbCbZp/WrOJpBkjqVAEs0gabcS6FgmIJuLxjvdkzPaDM
 X3QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEWUxw02ww2tQXAJoB5RD6QqnkYv1kxtR0gQsL9tBLYTroMdXFSq3jebkCs1tXN0uADCh8V75hvT+y0oniKhbrlgKFTw==
X-Gm-Message-State: AOJu0YwfAor5lnWHgjGmz8cmJZ4UFt58PzSCST1MTfjHUQYu81rMIELJ
 2waprYnsLcT6W+u9x2n83c/CpItIv7YnH2JKYzDT2wWtv7Hk3Rle9hj3/P8doBHArzJk5TU8/bG
 QFVY6t+EXTmKPyi8SPw2xR+vlGj6WckH2K9Z/+w==
X-Google-Smtp-Source: AGHT+IFLYJHupiWaNhjMwaGmYJTzNutnxu9DzZGljBNHTtdz3gOU4YApx1CwWTEjA5JtZ7q9I5NPfQ6O+96BXb6lwF4=
X-Received: by 2002:a2e:8ed2:0:b0:2d6:b582:58b8 with SMTP id
 e18-20020a2e8ed2000000b002d6b58258b8mr1921252ljl.52.1712231207214; Thu, 04
 Apr 2024 04:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
 <20240404081352.3224643-3-igor.opaniuk@gmail.com> <Zg5ngbQinAX6bOjM@hera>
 <CAC_iWjL48gDx2dKnB=+OO=3kLMdvU+9cOst4Oj4gtX2bN=7toQ@mail.gmail.com>
 <CAByghJZ+5J7uDzL54_apX3cAb5tGSk5yQmtR7cOaEtNTFZ-dLA@mail.gmail.com>
 <CAC_iWjLCQHRjNbgxoth4cRH8Ju+PBoRXmNwpkZjae2zxCy1cBw@mail.gmail.com>
 <CAByghJZVRbnFUwJdgU534tvGA+DX2pArf0i7ySik=BrXgADe3Q@mail.gmail.com>
In-Reply-To: <CAByghJZVRbnFUwJdgU534tvGA+DX2pArf0i7ySik=BrXgADe3Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Apr 2024 14:46:10 +0300
Message-ID: <CAC_iWjKkvS_bH=MiYgX00nyRSLga2_J9UaJ5o4VTG3C3WYkyug@mail.gmail.com>
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


On Thu, 4 Apr 2024 at 14:40, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> Ilias,
>
> On Thu, Apr 4, 2024 at 1:00=E2=80=AFPM Ilias Apalodimas <ilias.apalodimas=
@linaro.org> wrote:
>>
>> Hi Igor,
>>
>> On Thu, 4 Apr 2024 at 13:18, Igor Opaniuk <igor.opaniuk@gmail.com> wrote=
:
>> >
>> > Hi Ilias,
>> >
>> > On Thu, Apr 4, 2024 at 10:54=E2=80=AFAM Ilias Apalodimas <ilias.apalod=
imas@linaro.org> wrote:
>> >>
>> >> Hi Igor,
>> >>
>> >> On Thu, 4 Apr 2024 at 11:40, Ilias Apalodimas
>> >> <ilias.apalodimas@linaro.org> wrote:
>> >> >
>> >> > Hi Igor,
>> >> >
>> >> > I was about to apply the series, but noticed neither me or Jens wer=
e cc'ed
>> >> > on this. Adding Jens to the party
>> >> >
>> >> > On Thu, Apr 04, 2024 at 10:13:49AM +0200, Igor Opaniuk wrote:
>> >> > > Add calls for closing tee session after every read/write operatio=
n.
>> >> >
>> >> > What the patch is pretty obvious, but I am missing an explanation o=
f why
>> >> > this is needed
>> >> >
>> >> > >
>> >> > > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
>> >> > > ---
>> >> > >
>> >> > > (no changes since v1)
>> >> > >
>> >> > >  cmd/optee_rpmb.c | 23 +++++++++++++++++------
>> >> > >  1 file changed, 17 insertions(+), 6 deletions(-)
>> >> > >
>> >> > > diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
>> >> > > index e0e44bbed04..b3cafd92410 100644
>> >> > > --- a/cmd/optee_rpmb.c
>> >> > > +++ b/cmd/optee_rpmb.c
>> >> > > @@ -87,8 +87,10 @@ static int read_persistent_value(const char *n=
ame,
>> >> > >
>> >> > >       rc =3D tee_shm_alloc(tee, name_size,
>> >> > >                          TEE_SHM_ALLOC, &shm_name);
>> >> > > -     if (rc)
>> >> > > -             return -ENOMEM;
>> >> > > +     if (rc) {
>> >> > > +             rc =3D -ENOMEM;
>> >> > > +             goto close_session;
>> >> > > +     }
>> >> >
>> >> > I don't think you need the session to be opened to allocate memory.
>> >> > So instead of of doing this, why don't we just move the alloc call =
before
>> >> > opening the session?
>> >>
>> >> Looking at it again, we do need tee !=3D NULL, but I think it's clean=
er
>> >> to add something like
>> >> if (!dev)
>> >>     return -ENODEV
>> >> to __tee_shm_add() instead.
>> >
>> > Do you mind if I address that in a separate patch series, as tbh I
>> > don't want to add additional patches to the existing series?
>>
>> We still completely change the functionality. So, the patchset is not
>> a 'tiny cleanup', it instead closes the session every time instead of
>> keeping it open.
>> There are a few things going on, that aren't explained clearly in the
>> commit message
>> - Why is this needed? Looking at the code it is an actual problem
>> since sessions tied to the AVB uuid will remain open
>> - Is there any side effect by always closing the session?
>> I don't mind merging it as is with a proper commit message, but I
>> think the alternative is just easier.
>
> I'll provide a bit more context here. The problem initially was in the TE=
E sandbox
> driver implementation(drivers/tee/sandbox.c) and it's limitations, which =
doesn't
> permit to have multiple simultaneous sessions with different TAs.
> This is what actually happened in this CI run [1], firstly "optee_rpmb"
> cmd was executed (and after execution we had one session open), and
> then "scp03", which also makes calls to OP-TEE, however it fails
> in sandbox_tee_open_session() because of this check:
>
> if (state->ta) {
>     printf("A session is already open\n");
>     return -EBUSY;
> }
>
> So basically I had two ways in mind to address that:
> 1. Close a session on each optee_rpmb cmd invocation.
> I don't see any reason to keep this session open, as obviously
> there is no other mechanism (tbh, I don't know if DM calls ".remove" for =
active
> devices) to close it automatically before handing over control to
> Linux kernel. As a result we might end up with some orphaned sessions
> registered in OP-TEE OS core (obvious resource leak).
> 2. Extend TEE sandbox driver, add support for multiple
> simultaneous sessions just to handle the case.
>
> I've chosen the first approach, as IMO it was "kill two birds with one st=
one",
> I could address resource leak in OP-TEE and bypass limitations of
> TEE sandbox driver.

Thanks, this helps.
All this needs to be in the commit message, instead of a mail thread.
Can you send a new revision with the commit message amended?

Thanks
/Ilias
>
> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/jobs/792216
>
>>
>>
>> Thanks
>> /Ilias
>>
>> >
>> >>
>> >>
>> >> Cheers
>> >> /Ilias
>> >> >
>> >> > >
>> >> > >       rc =3D tee_shm_alloc(tee, buffer_size,
>> >> > >                          TEE_SHM_ALLOC, &shm_buf);
>> >> > > @@ -125,6 +127,9 @@ out:
>> >> > >       tee_shm_free(shm_buf);
>> >> > >  free_name:
>> >> > >       tee_shm_free(shm_name);
>> >> > > +close_session:
>> >> > > +     tee_close_session(tee, session);
>> >> > > +     tee =3D NULL;
>> >> > >
>> >> > >       return rc;
>> >> > >  }
>> >> > > @@ -139,17 +144,20 @@ static int write_persistent_value(const cha=
r *name,
>> >> > >       struct tee_param param[2];
>> >> > >       size_t name_size =3D strlen(name) + 1;
>> >> > >
>> >> > > +     if (!value_size)
>> >> > > +             return -EINVAL;
>> >> > > +
>> >> > >       if (!tee) {
>> >> > >               if (avb_ta_open_session())
>> >> > >                       return -ENODEV;
>> >> > >       }
>> >> > > -     if (!value_size)
>> >> > > -             return -EINVAL;
>> >> > >
>> >> > >       rc =3D tee_shm_alloc(tee, name_size,
>> >> > >                          TEE_SHM_ALLOC, &shm_name);
>> >> > > -     if (rc)
>> >> > > -             return -ENOMEM;
>> >> > > +     if (rc) {
>> >> > > +             rc =3D -ENOMEM;
>> >> > > +             goto close_session;
>> >> > > +     }
>> >> >
>> >> > ditto
>> >> >
>> >> > >
>> >> > >       rc =3D tee_shm_alloc(tee, value_size,
>> >> > >                          TEE_SHM_ALLOC, &shm_buf);
>> >> > > @@ -178,6 +186,9 @@ out:
>> >> > >       tee_shm_free(shm_buf);
>> >> > >  free_name:
>> >> > >       tee_shm_free(shm_name);
>> >> > > +close_session:
>> >> > > +     tee_close_session(tee, session);
>> >> > > +     tee =3D NULL;
>> >> > >
>> >> > >       return rc;
>> >> > >  }
>> >> > > --
>> >> > > 2.34.1
>> >> > >
>> >> >
>> >> > Thanks
>> >> > /Ilias
>> >
>> >
>> >
>> >
>> > --
>> > Best regards - Atentamente - Meilleures salutations
>> >
>> > Igor Opaniuk
>> >
>> > mailto: igor.opaniuk@gmail.com
>> > skype: igor.opanyuk
>> > https://www.linkedin.com/in/iopaniuk
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
