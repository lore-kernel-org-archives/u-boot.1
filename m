Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20DFC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA5984CA3;
	Thu,  2 Jul 2026 10:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H7Pbs7KP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C46B84CB4; Thu,  2 Jul 2026 10:15:39 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4067C84C85
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664ce3000e6so1407895d50.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782980136; cv=none;
 d=google.com; s=arc-20260327;
 b=K/OQRfqGpwx3RqFnQUvLvGz+Tgf1Yb4DuAeOIK1ke+l6g/AgeuIqh6wAp3NelIxntr
 eVy33emVQ6dSdzf6f5VV5sjxzOxd1v/JbHHbNop/wM5mJqVGhwp//y58tPcM44Vg340G
 oFnIdFgvnaF83Dw+jhYzYgM+8HliNXwqzNCnKAgQIMiV9LGSrqcqYOm1GiOQky8VZ6SX
 wOEDp2kg441xd6xYKWjmZTvAJUWu7x+dPAAeBTooZJ+bSC4WShWQvVf6HzcZJgTP0o43
 +kLiFgjcqO5JSnHcTRb51GK/ZkdFa69DmOhhGICPPlvDPEqojX9qRSdubocqo3whn4rG
 G9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cqCHGHxedByerfr5hEC0ULHHsL2Tt4OxrT4w682RpDk=;
 fh=DbvtPfS6eUiHmbzTbtlc1ukHkEcnSdLK7XCplQWFWec=;
 b=Nb7afSbq6BZoQLXn6JJGv8OeVa6I2hTEoAVvj1wQOJ2vgDkIAFDXxKGZOQCHoyn3mo
 SQLtighq9o/6fE9lXt+s74HbUc+omYkn69kaNtl2EufQgBi0lMA8MKkkVMkvd/ef/oE9
 D/FW9XAfA/Jk/1/tSG5s217NO7e8Q8YW0x/MeNkVz5dQ81MjZCo+rjLleo9X7kIt6q1G
 AD7lm5hH3+7kQllNudwD03W6Nl1xErdThDtAe0gS0fuT/zvn0kXqjIHKUEJa54VOES22
 Prj70RJ0VbxRjvkq4rLd4kJd3G6aKP9kq8alrCsFmfVO2baUU7jKYw/m6GuiRVldYE2u
 AHzg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782980136; x=1783584936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cqCHGHxedByerfr5hEC0ULHHsL2Tt4OxrT4w682RpDk=;
 b=H7Pbs7KPQEe3D6Z6lqm95e81qRTAKfbijmompYDcAFRkMX6QWAqcby9mSau0XYFhqg
 Wu/owCs5xaPGvG6TW27XH1vniuUIG0v+m9fwogLcwhoxosgCgU9WpN6Q9JCUvBQ4A/88
 uhQfZDZvZ1DM6dVbcgHncPe6p7tK9pp9j+ypKbPwJVXuKD1hNjy9zEv7j6/au/r9NZEF
 ZeyonfQI8znNNhuZjpVPdr+TMXCXq+ROclI83ep+a84SfkyE3rZQpab5X7kCqusSnyYx
 pnfm9uOoWKGg8+20m2CsyvchpeI+Ra9NSQiA0FNe0iRWdAW7lWRYKcw25XrRHDza+VVT
 bVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782980136; x=1783584936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqCHGHxedByerfr5hEC0ULHHsL2Tt4OxrT4w682RpDk=;
 b=dJhe/7P095hPc5ATcjgE/z30QrhNq4s6EVjugSGUbYhGRoRAyMxbaJQcm8AQFd05XH
 MsvzASNaSQwQme8OOtXoCGJJRVSyQtVfs2mNYlegeaxUPy/dPbKJekkDajd8A+4kZ5Jt
 LmndrVW4ycAgv+orUGByNEaVKHPaONy8Eh7CiF0QXXJ2icNuqxNW1lkrTSTHLWurr1tp
 iKiG0aESWj8jjSGs+C/nBXocDwArIcwnMCny/hTQlQV5jh6roFGpCt2z3/9QbMSyVLB0
 1/qeO5xwnyxzPpYQZGLFBRZQKWKszY/Tj+GpNeaKnE+UUUlzWAqNYoqbz3Rmt+X6BZ9h
 1NbA==
X-Gm-Message-State: AOJu0YxBk/t7EK0OKgyVZDSzjEweB1aD/KeNREJLi0Olf+szEO+RbadA
 d36njGs4OQmYjOvoFIzzmtX4ttdqAOTR+fbFREeg81wE6WlNdH2yoAU5vKgT2Sb+tASHmuXbpwd
 4uRsuEtU0WmVGtkg3p+Byy9DGkLRYFh9eD304epv7tpvMz02tCkEC66G8TQ==
X-Gm-Gg: AfdE7cmJJaVhAz10ECzL7IiB4alhCYYNurWyuLfAlloIg1Pt+BHYrfWK43lP/C2JrfJ
 gzsNHKRr6VcDNAmKnlWno0JxDFzWqnCnz5+mdxo+/c3RkM6fK86H2XGGuCx0bFRWbhI5WDVy+JL
 PDurPdHLIMURSRSJO4UMBfvlZvExHq2ejwQs2NtdQgiOJWfoXVkSCf11cArZtd6zyZ2ix6VBGyU
 j0Xaphfy4ckBN/ADsP8QeAvIzvwaUkWjh82iKQh6sikcKT2JgOyikkA+BK+tcwX2mG7uPPIJ3Z6
 YPorUkHtQAUTQvpg8DXPqsuAjcwrJIf4pl/dyGkHSQEMKRFfUzD9otiK9ouKwL8YzSgUgqX3JA7
 uddx9rjzqpOqSDLQvt/11FDtBYoilSlXQ2+uNSIm8YRIhVGp5bARnt2vY4K/zJXUrzK7a5swE6D
 54EuSceIkzBd7RydjU+aHVfkAZjf3EMGpOQ00C1424hOf1RZC18O+i/bB7kAcNF9Dr2DV7YiLoU
 +KTnfTKZRwYWAb7mYnr3kd4CW94PsL5wMNpK78u2nS547Iz7nNRwK0P8Jf/1C0OlHlKDAXoyKGy
 pviByWl6vYLSHnaCb4DdcSTwLcFW7F+4LlaKaVMkFH9GV+Z211AsLNWPfErM3bNZRvMXIDI=
X-Received: by 2002:a05:690e:484f:b0:664:f064:f674 with SMTP id
 956f58d0204a3-665965d9cfbmr3105413d50.61.1782980135783; Thu, 02 Jul 2026
 01:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260609070105.525348-1-wojciech.dubowik@mt.com>
 <0ed97c95-dc99-4fd1-a0d8-5300085475d3@cherry.de>
In-Reply-To: <0ed97c95-dc99-4fd1-a0d8-5300085475d3@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 11:14:57 +0300
X-Gm-Features: AVVi8Cc06GFxQ5vRH6Sp8a_tk437J0FNnW4pgjTbyEvW-qsYUgjhs33DUW6Dtt0
Message-ID: <CAC_iWjJGOeDaxRnqSOViU7=smWtTomFN2miY6G1DRCqKxC8-DA@mail.gmail.com>
Subject: Re: [PATCH v7] tools: mkeficapsule: Rework pkcs11 support
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Wojciech Dubowik <wojciech.dubowik@mt.com>
Cc: u-boot@lists.denx.de, Franz Schnyder <fra.schnyder@gmail.com>,
 trini@konsulko.com, "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Thanks Quentin

The patch overall seems reasonable, but shouldn't the same logic be
applied to gnutls_global_deinit() & gnutls_pkcs11_deinit()?

Thanks
/Ilias

On Fri, 26 Jun 2026 at 13:32, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> +Cc Heinrich and Ilias, maintainers of tools/mkeficapsule.c according to
> ./scripts/get_maintainer.pl
>
> On 6/9/26 9:01 AM, Wojciech Dubowik wrote:
> > From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> >
> > Some distros like OpenEmbedded are using gnutls library
> > without pkcs11 support and linking of mkeficapsule will fail.
> > It would make maintenance of default configs a hurdle.
> > Add detection of pkcs11 support in gnutls so it's enabled
> > when available and doesn't need to be set explicitly.
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > Cc: Franz Schnyder <fra.schnyder@gmail.com>
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> > Changes in v7:
> > - fixed return code in import_pkcs11_crt to restore the old
> >    behaviour, spotted by Simon
> > Changes in v6:
> > - removed return code check from gnutls_x509_crt_import_pkcs11
> >     sugessted by Quentin, to be sent in separate patch later
> > Changes in v5:
> > - removed more unrelated cleanup improvements spotted by
> >     Quentin, to be sent in another patch later
> > Changes in v4:
> > - abstract pkcs11 init function
> > - removed unrelated cleanup improvements, to be sent in
> >     another patch later
> > Changes in v3:
> > - remove config option for pkcs11 support and add auto
> >     detection in Makefile
> > - reduce amount of ifdefs by abstracting import pkcs11
> >     functions
> > - add missing free and deinit functions
> > Changes in v2:
> > - make use of stderr more consistent
> > - add missing ifndef around pkcs11 deinit functions
> > ---
> >   tools/Makefile       |  5 +++
> >   tools/mkeficapsule.c | 95 +++++++++++++++++++++++++++++++++-----------
> >   2 files changed, 77 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/Makefile b/tools/Makefile
> > index 1a5f425ecdaa..e85f5a354b81 100644
> > --- a/tools/Makefile
> > +++ b/tools/Makefile
> > @@ -271,6 +271,11 @@ mkeficapsule-objs := generated/lib/uuid.o \
> >       $(LIBFDT_OBJS) \
> >       mkeficapsule.o
> >   hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
> > +GNUTLS_SUPPORTS_P11KIT = $(shell pkg-config --libs gnutls --print-requires-private \
> > +                      2> /dev/null | grep p11-kit-1)
> > +ifeq ($(GNUTLS_SUPPORTS_P11KIT),p11-kit-1)
> > +HOSTCFLAGS_mkeficapsule.o += -DMKEFICAPSULE_PKCS11
> > +endif
> >
> >   include tools/fwumdata_src/fwumdata.mk
> >
> > diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> > index ec640c57e8a5..c3cf48f4cc1d 100644
> > --- a/tools/mkeficapsule.c
> > +++ b/tools/mkeficapsule.c
> > @@ -207,6 +207,71 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
> >       return 0;
> >   }
> >
> > +#ifdef MKEFICAPSULE_PKCS11
> > +static int pkcs11_init(void)
> > +{
> > +     const char *lib;
> > +     int ret;
> > +
> > +     lib = getenv("PKCS11_MODULE_PATH");
> > +     if (!lib) {
> > +             fprintf(stdout,
> > +                     "PKCS11_MODULE_PATH not set in the environment\n");
> > +             return -1;
> > +     }
> > +
> > +     gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
> > +     gnutls_global_init();
> > +
> > +     ret = gnutls_pkcs11_add_provider(lib, "trusted");
> > +     if (ret < 0) {
> > +             fprintf(stdout, "Failed to add pkcs11 provider\n");
> > +             return -1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> > +{
> > +     gnutls_pkcs11_obj_t *obj_list;
> > +     unsigned int obj_list_size = 0;
> > +     int ret;
> > +
> > +     ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> > +                                              ctx->cert_file, 0);
> > +     if (ret < 0 || obj_list_size == 0)
> > +             return -1;
> > +
> > +     gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
> > +
> > +     return 0;
> > +}
> > +
> > +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> > +{
> > +     return gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
> > +}
> > +#else
> > +static int pkcs11_init(void)
> > +{
> > +     fprintf(stderr, "Pkcs11 support is disabled\n");
> > +     return -1;
> > +}
> > +
> > +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> > +{
> > +     fprintf(stderr, "Pkcs11 support is disabled\n");
> > +     return -1;
> > +}
> > +
> > +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> > +{
> > +     fprintf(stderr, "Pkcs11 support is disabled\n");
> > +     return -1;
> > +}
> > +#endif
> > +
> >   /**
> >    * create_auth_data - compose authentication data in capsule
> >    * @auth_context:   Pointer to authentication context
> > @@ -229,9 +294,6 @@ static int create_auth_data(struct auth_context *ctx)
> >       gnutls_pkcs7_t pkcs7;
> >       gnutls_datum_t data;
> >       gnutls_datum_t signature;
> > -     gnutls_pkcs11_obj_t *obj_list;
> > -     unsigned int obj_list_size = 0;
> > -     const char *lib;
> >       int ret;
> >       bool pkcs11_cert = false;
> >       bool pkcs11_key = false;
> > @@ -243,19 +305,8 @@ static int create_auth_data(struct auth_context *ctx)
> >               pkcs11_key = true;
> >
> >       if (pkcs11_cert || pkcs11_key) {
> > -             lib = getenv("PKCS11_MODULE_PATH");
> > -             if (!lib) {
> > -                     fprintf(stdout,
> > -                             "PKCS11_MODULE_PATH not set in the environment\n");
> > -                     return -1;
> > -             }
> > -
> > -             gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
> > -             gnutls_global_init();
> > -
> > -             ret = gnutls_pkcs11_add_provider(lib, "trusted");
> > +             ret = pkcs11_init();
> >               if (ret < 0) {
> > -                     fprintf(stdout, "Failed to add pkcs11 provider\n");
> >                       return -1;
> >               }
> >       }
> > @@ -301,14 +352,12 @@ static int create_auth_data(struct auth_context *ctx)
> >
> >       /* load x509 certificate */
> >       if (pkcs11_cert) {
> > -             ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> > -                                                      ctx->cert_file, 0);
> > -             if (ret < 0 || obj_list_size == 0) {
> > -                     fprintf(stdout, "Failed to import crt_file URI objects\n");
> > +             ret =  import_pkcs11_crt(&x509, ctx);
> > +             if (ret < 0) {
> > +                     fprintf(stderr, "error in import_pkcs11_crt(): %s\n",
> > +                             gnutls_strerror(ret));
> >                       return -1;
> >               }
> > -
> > -             gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
> >       } else {
> >               ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
> >               if (ret < 0) {
> > @@ -320,9 +369,9 @@ static int create_auth_data(struct auth_context *ctx)
> >
> >       /* load a private key */
> >       if (pkcs11_key) {
> > -             ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
> > +             ret = import_pkcs11_key(&pkey, ctx);
> >               if (ret < 0) {
> > -                     fprintf(stderr, "error in %d: %s\n", __LINE__,
> > +                     fprintf(stderr, "error in import_pkcs11_key(): %s\n",
> >                               gnutls_strerror(ret));
> >                       return -1;
> >               }
>
