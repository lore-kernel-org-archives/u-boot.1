Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2389FE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 11:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D9389481;
	Fri,  6 Dec 2024 12:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kc74Hliz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F25589576; Fri,  6 Dec 2024 12:57:29 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52618927A
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 12:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6ef81222be7so16562077b3.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 03:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733486245; x=1734091045; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6iBbWA9QQRlQACnfhO0v7iqfIk99xPn19yLWNTKnD6Q=;
 b=Kc74Hliz48ISOjs5C9tZrRQuYcYaDtPZPSuzhiPdjL91UXHAJ7Xo7XRW54jzO9RbG7
 Ak+DpfjyxGys0ZRbK+8zjYxyDicVS4y2EkiwDqxEbXxgysFJm14ZrQdx+Ulb5gU/OPom
 GP9fOl+hi9R1QpVUbZQEUS6s6CDKJJ8G6BQQGdpQFn1GbYq1hRw/qyjD6SKqWK8gVze3
 mJtvVjCbRaUjb4Jp8qeGpoitYZOGC2c+x7xFxe9q8h2RWF9SoZCESZ8d3bD/0zOx2RMd
 9W9QvhJczjYvDJnmEWqBYrmuufvIwpcyv8lE+AC0Q+sc0LebrSV9KgabFmo1S9O+ZQ8m
 44wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733486245; x=1734091045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6iBbWA9QQRlQACnfhO0v7iqfIk99xPn19yLWNTKnD6Q=;
 b=nsE/yHuxzK3pk9Yk+le9HVpsIx/MXpzVhlDN8yHPUNvrUxSz1sGFBY5JzcndNIG3MR
 //sVuj9Sd/La7rtkWXVDjTzS0hTTAbouw/613m6gAzrN71Jef0AnyWCY6dewp/U0gqaF
 AVq9UjcbgyIABlwjImOYKucCaKu1CIkPYI+zs+piiy/rCFUJ9KOObYXutOqhwI6L8Tmv
 Lb53CwnlWcw+/hya9u8fWitgSv47It6Art0SwENYSis33r0yXJiD2AQaUR46gu2PXaZB
 MexZuIR4AnAq+IAqRemFdLg3hBBzXLEkfokg4a6m8f43tAbw0eOdRcd6ciE3Red7x/Ui
 DPUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVteIn/dVb47U8m1diBzOQrdZ1YRKGVn9GEicDZdqzEfqmdzY2Mx80ybB0hMpEnmOKQeF9pvos=@lists.denx.de
X-Gm-Message-State: AOJu0YxG4Qj/4UVIBOXlO+8Jo8jtW7wXduGCL1rvLKryyVWkDsAux9Am
 JFqD3evDVVy6wkSjA//h+cq+/BUiPi16Woal3y956HcOvajmuTCzPlOTZLH96djm0M+dSAg4kuJ
 U3bVZYX934kinXvQU9/yf+k1v3S3RC9JWJEt8hA==
X-Gm-Gg: ASbGncsKLoLc3Ms/faapsAEGP80XmgS8HLjrW0hvPAu6zJ27XtsMymfSlfQfsSckQQk
 IK7iK5qivka/PZQRXkcdnAJzJx/L3xCc=
X-Google-Smtp-Source: AGHT+IFPZd6ElvMo3QV5e1keREePTuAPAQKQqeOuAd4dPXExLWtmS+j9qLnFjlC1txPb9nhbGzX8ofhxRfA7cigi/Ek=
X-Received: by 2002:a05:690c:6503:b0:6ef:4ed2:7dec with SMTP id
 00721157ae682-6efe3bf5522mr29127217b3.8.1733486245614; Fri, 06 Dec 2024
 03:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20241206105647.2548249-1-ilias.apalodimas@linaro.org>
 <cfe9bdda-59d2-4080-9f04-663c77fb0642@gmx.de>
In-Reply-To: <cfe9bdda-59d2-4080-9f04-663c77fb0642@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Dec 2024 13:56:49 +0200
Message-ID: <CAC_iWjJbt5rxNqPQhJ0-0jw4Bueu5hcn1BDicOyQ3k8_25xNZQ@mail.gmail.com>
Subject: Re: [PATCH] mbedtls: remove MBEDTLS_HAVE_TIME
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
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

Thanks Heinrich

On Fri, 6 Dec 2024 at 13:30, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/6/24 11:56, Ilias Apalodimas wrote:
> > When MbedTLS TLS features were added MBEDTLS_HAVE_TIME was defined as part
> > of enabling https:// support. However that pointed to the wrong function
> > which could crash if it received a NULL pointer.
> >
> > Looking closer that function is not really needed, as it only seems to
> > increase the RNG entropy by using 4b of the current time and date.
> > The reason that was enabled is that lwIP was unconditionally requiring it,
> > although it's configurable and can be turned off.
> >
> > Since lwIP doesn't use that field anywhere else, make it conditional and
> > disable it from our config.
> >
> > Fixes: commit a564f5094f62 ("mbedtls: Enable TLS 1.2 support")
> > Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> This removes a tiny bit of entropy.

Yes from what I can tell though we still generate 32b via the DBRG calls though

>
> For making https safe we need to invest into finding different entropy
> sources. Besides the hardware rng this entropy could come from reading
> get_ticks() in different code locations like after receiving a network
> package.

Yes we can, in the future, redefine that time function

Thanks
/Ilias
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> > ---
> >   lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c | 2 ++
> >   lib/mbedtls/mbedtls_def_config.h                     | 3 ---
> >   2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > index 6643b05ee94d..46421588fef8 100644
> > --- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > +++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > @@ -692,7 +692,9 @@ altcp_tls_set_session(struct altcp_pcb *conn, struct altcp_tls_session *session)
> >     if (session && conn && conn->state) {
> >       altcp_mbedtls_state_t *state = (altcp_mbedtls_state_t *)conn->state;
> >       int ret = -1;
> > +#ifdef MBEDTLS_HAVE_TIME
> >       if (session->data.MBEDTLS_PRIVATE(start))
> > +#endif
> >         ret = mbedtls_ssl_set_session(&state->ssl_context, &session->data);
> >       return ret < 0 ? ERR_VAL : ERR_OK;
> >     }
> > diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> > index d27f017d0847..1d2314e90e4d 100644
> > --- a/lib/mbedtls/mbedtls_def_config.h
> > +++ b/lib/mbedtls/mbedtls_def_config.h
> > @@ -92,9 +92,6 @@
> >
> >   /* Generic options */
> >   #define MBEDTLS_ENTROPY_HARDWARE_ALT
> > -#define MBEDTLS_HAVE_TIME
> > -#define MBEDTLS_PLATFORM_MS_TIME_ALT
> > -#define MBEDTLS_PLATFORM_TIME_MACRO rtc_mktime
> >   #define MBEDTLS_PLATFORM_C
> >   #define MBEDTLS_SSL_CLI_C
> >   #define MBEDTLS_SSL_TLS_C
>
