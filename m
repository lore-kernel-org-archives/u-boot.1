Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0899BCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 11:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C41588426;
	Thu,  4 Apr 2024 13:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TC5u6T7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 850088842C; Thu,  4 Apr 2024 13:40:16 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0823A883D3
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-343cb97e7f5so23404f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712230813; x=1712835613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e6r6ACJ1muTvS1ucZPsoTewGhfLnmzffue+9taCKdYo=;
 b=TC5u6T7p/O3L96zyQeOR2ho/fJW5hj64PcDGZGEl4c6l4eoTlEuW7yOl8rJems2BEE
 ZTy+QhA0ZMm/PyU2oLumujs24uAKacvbGoEZg5TkqCqH3sA2ehDoV+wdwgkOE+ovM+AD
 VEaVFuPcHBO1tmAzbU1qppjrOlX+0NKf8amdMe3FZsNvej6aJ68gAsWbeEcK0Bg3wZee
 o9kTkkNqtxv7397IGK3JZybDX6dnfvVRy0z1yIii5W0J9lQFAJyzCi/rKH7JPPkkUWiT
 MqWz0Y6H10NOK4RgRuobNBNaHkpSk3xSmyN0+A3iEh1Hd5JASUfkiFW0HPzsaaX1ODf/
 7F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712230813; x=1712835613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e6r6ACJ1muTvS1ucZPsoTewGhfLnmzffue+9taCKdYo=;
 b=Gf3WmE251SGdRsVKyP8eX55XjE1ggN4g0ZF+xUhro4zntZ3aQl/h6cUGK6tRn4ZXG8
 dpuEvmR47osfl2PMDIliVsEwKByS0Fhl1Mz+qz570UItNfXhOCqQVt+MQ+BUy2p1ymzJ
 WczyXSVkwUZn4T8oq+Fqau9k8qyH0xuwEN6WWaJahIt7fTRU9JDOd7NgYuqeb0qwr0gl
 K/9lo8gtILXRol45fX/OkzMEIylXL8f0KiS8NMu04XdI4RnL4zHg22oakCON4ctHgoIr
 SsKk3y+7OJLa94ZdM2xkyz8ezvRlyBLnfcobW5XVBXnzFKDAB1TIQGhWqlzzQ7oetnaO
 NXxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNb8pADHCfT38kTgj91a00mJ06M/DHLpLQPNoJ3MrWDT23Dv8Np2q1kkvZRkGv1LUoDRh4IXcdvcYWTk9BzhKlmWbKxQ==
X-Gm-Message-State: AOJu0Yzd8ORrQQJk0/+W2qsQi7Sc63K5qC2EWemg/SnwqM2XZilVdduH
 jcjhvyqSrIsgfGaXQkY72JQ34xsyjkMnwr95t1c4QlvOeyVNwN5i6lI+1QKRsOq/FNs0281ord/
 aaC5dKPqd6wKHW4XD4CHrgTQAqGg=
X-Google-Smtp-Source: AGHT+IH5YEd/4kDjhrf2x1AhCB0Q7l/NQrIDUb6RV81yf8wi1qMZepn80SYrxab8Eidm+B0ozsmNMBQcHHwx6HYZ6aQ=
X-Received: by 2002:a5d:6e65:0:b0:343:cac2:c954 with SMTP id
 j37-20020a5d6e65000000b00343cac2c954mr563072wrz.6.1712230813190; Thu, 04 Apr
 2024 04:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
 <20240404081352.3224643-3-igor.opaniuk@gmail.com> <Zg5ngbQinAX6bOjM@hera>
 <CAC_iWjL48gDx2dKnB=+OO=3kLMdvU+9cOst4Oj4gtX2bN=7toQ@mail.gmail.com>
 <CAByghJZ+5J7uDzL54_apX3cAb5tGSk5yQmtR7cOaEtNTFZ-dLA@mail.gmail.com>
 <CAC_iWjLCQHRjNbgxoth4cRH8Ju+PBoRXmNwpkZjae2zxCy1cBw@mail.gmail.com>
In-Reply-To: <CAC_iWjLCQHRjNbgxoth4cRH8Ju+PBoRXmNwpkZjae2zxCy1cBw@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 4 Apr 2024 13:40:01 +0200
Message-ID: <CAByghJZVRbnFUwJdgU534tvGA+DX2pArf0i7ySik=BrXgADe3Q@mail.gmail.com>
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

Ilias,

On Thu, Apr 4, 2024 at 1:00=E2=80=AFPM Ilias Apalodimas <ilias.apalodimas@l=
inaro.org>
wrote:

> Hi Igor,
>
> On Thu, 4 Apr 2024 at 13:18, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, Apr 4, 2024 at 10:54=E2=80=AFAM Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Igor,
> >>
> >> On Thu, 4 Apr 2024 at 11:40, Ilias Apalodimas
> >> <ilias.apalodimas@linaro.org> wrote:
> >> >
> >> > Hi Igor,
> >> >
> >> > I was about to apply the series, but noticed neither me or Jens were
> cc'ed
> >> > on this. Adding Jens to the party
> >> >
> >> > On Thu, Apr 04, 2024 at 10:13:49AM +0200, Igor Opaniuk wrote:
> >> > > Add calls for closing tee session after every read/write operation=
.
> >> >
> >> > What the patch is pretty obvious, but I am missing an explanation of
> why
> >> > this is needed
> >> >
> >> > >
> >> > > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> >> > > ---
> >> > >
> >> > > (no changes since v1)
> >> > >
> >> > >  cmd/optee_rpmb.c | 23 +++++++++++++++++------
> >> > >  1 file changed, 17 insertions(+), 6 deletions(-)
> >> > >
> >> > > diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
> >> > > index e0e44bbed04..b3cafd92410 100644
> >> > > --- a/cmd/optee_rpmb.c
> >> > > +++ b/cmd/optee_rpmb.c
> >> > > @@ -87,8 +87,10 @@ static int read_persistent_value(const char
> *name,
> >> > >
> >> > >       rc =3D tee_shm_alloc(tee, name_size,
> >> > >                          TEE_SHM_ALLOC, &shm_name);
> >> > > -     if (rc)
> >> > > -             return -ENOMEM;
> >> > > +     if (rc) {
> >> > > +             rc =3D -ENOMEM;
> >> > > +             goto close_session;
> >> > > +     }
> >> >
> >> > I don't think you need the session to be opened to allocate memory.
> >> > So instead of of doing this, why don't we just move the alloc call
> before
> >> > opening the session?
> >>
> >> Looking at it again, we do need tee !=3D NULL, but I think it's cleane=
r
> >> to add something like
> >> if (!dev)
> >>     return -ENODEV
> >> to __tee_shm_add() instead.
> >
> > Do you mind if I address that in a separate patch series, as tbh I
> > don't want to add additional patches to the existing series?
>
> We still completely change the functionality. So, the patchset is not
> a 'tiny cleanup', it instead closes the session every time instead of
> keeping it open.
> There are a few things going on, that aren't explained clearly in the
> commit message
> - Why is this needed? Looking at the code it is an actual problem
> since sessions tied to the AVB uuid will remain open
> - Is there any side effect by always closing the session?
> I don't mind merging it as is with a proper commit message, but I
> think the alternative is just easier.
>
I'll provide a bit more context here. The problem initially was in the TEE
sandbox
driver implementation(drivers/tee/sandbox.c) and it's limitations, which
doesn't
permit to have multiple simultaneous sessions with different TAs.
This is what actually happened in this CI run [1], firstly "optee_rpmb"
cmd was executed (and after execution we had one session open), and
then "scp03", which also makes calls to OP-TEE, however it fails
in sandbox_tee_open_session() because of this check:

if (state->ta) {
    printf("A session is already open\n");
    return -EBUSY;
}

So basically I had two ways in mind to address that:
1. Close a session on each optee_rpmb cmd invocation.
I don't see any reason to keep this session open, as obviously
there is no other mechanism (tbh, I don't know if DM calls ".remove" for
active
devices) to close it automatically before handing over control to
Linux kernel. As a result we might end up with some orphaned sessions
registered in OP-TEE OS core (obvious resource leak).
2. Extend TEE sandbox driver, add support for multiple
simultaneous sessions just to handle the case.

I've chosen the first approach, as IMO it was "kill two birds with one
stone",
I could address resource leak in OP-TEE and bypass limitations of
TEE sandbox driver.

[1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/jobs/792216


>
> Thanks
> /Ilias
>
> >
> >>
> >>
> >> Cheers
> >> /Ilias
> >> >
> >> > >
> >> > >       rc =3D tee_shm_alloc(tee, buffer_size,
> >> > >                          TEE_SHM_ALLOC, &shm_buf);
> >> > > @@ -125,6 +127,9 @@ out:
> >> > >       tee_shm_free(shm_buf);
> >> > >  free_name:
> >> > >       tee_shm_free(shm_name);
> >> > > +close_session:
> >> > > +     tee_close_session(tee, session);
> >> > > +     tee =3D NULL;
> >> > >
> >> > >       return rc;
> >> > >  }
> >> > > @@ -139,17 +144,20 @@ static int write_persistent_value(const char
> *name,
> >> > >       struct tee_param param[2];
> >> > >       size_t name_size =3D strlen(name) + 1;
> >> > >
> >> > > +     if (!value_size)
> >> > > +             return -EINVAL;
> >> > > +
> >> > >       if (!tee) {
> >> > >               if (avb_ta_open_session())
> >> > >                       return -ENODEV;
> >> > >       }
> >> > > -     if (!value_size)
> >> > > -             return -EINVAL;
> >> > >
> >> > >       rc =3D tee_shm_alloc(tee, name_size,
> >> > >                          TEE_SHM_ALLOC, &shm_name);
> >> > > -     if (rc)
> >> > > -             return -ENOMEM;
> >> > > +     if (rc) {
> >> > > +             rc =3D -ENOMEM;
> >> > > +             goto close_session;
> >> > > +     }
> >> >
> >> > ditto
> >> >
> >> > >
> >> > >       rc =3D tee_shm_alloc(tee, value_size,
> >> > >                          TEE_SHM_ALLOC, &shm_buf);
> >> > > @@ -178,6 +186,9 @@ out:
> >> > >       tee_shm_free(shm_buf);
> >> > >  free_name:
> >> > >       tee_shm_free(shm_name);
> >> > > +close_session:
> >> > > +     tee_close_session(tee, session);
> >> > > +     tee =3D NULL;
> >> > >
> >> > >       return rc;
> >> > >  }
> >> > > --
> >> > > 2.34.1
> >> > >
> >> >
> >> > Thanks
> >> > /Ilias
> >
> >
> >
> >
> > --
> > Best regards - Atentamente - Meilleures salutations
> >
> > Igor Opaniuk
> >
> > mailto: igor.opaniuk@gmail.com
> > skype: igor.opanyuk
> > https://www.linkedin.com/in/iopaniuk
>


--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
