Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060C4C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 21:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B3A7846B4;
	Mon,  6 Jul 2026 23:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i6rs7fxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E488846FD; Mon,  6 Jul 2026 23:50:08 +0200 (CEST)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6216E801A9
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 23:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5bd95de6865so1433663e0c.0
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 14:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783374605; cv=none;
 d=google.com; s=arc-20260327;
 b=Euex4PdnC1zUmylGz6nI0QPAE/jWb12RdzVtgivNv8X3l1ZEdcZadY8wFKbZfegVzZ
 I6VKKSPHcmqpgLS0IFNid1ZgQm3hzhct6Mf/KXJpvCKEP8NcuJgYyBVFMO7IWT719vmE
 IMqtlpe6cGH6325PLPP/BQPj2x7TdBU4cDH+nEHh9w5OzKky1FqyNgrz0fvRmKG1Tva0
 tZAYKGGRaghMkLGV5btqUn3xEbSFXhgmawlMorSaDrdv4zH5SwckbUCG3v0F3vgdVvMl
 /H4VApJBJ9GHh5H5ImFzotUtyMkXHW9k2LJUhh2XV6Dttoo6Bcia/V0wV8CjMXBNpc7o
 YEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+v+lcXNgUDuFgvyQUuPTPcldHQ/WdfYwr9b1mHXuWok=;
 fh=w18+2UwFX0pJMxDj9ivxUi9zztY050LytBkDNSRnQ2g=;
 b=cEu9Ugg1vhKLsDdThxXKEt3A7B+fS0SrO0ErFmz8qvm3BUNcmftB5qroTvVC3B63UM
 Eij3zkojNbKcpMuVMPZeHOWUDXz0O5awqozRYoK/yePjwQP4kTCJHsTjdgWAUE0CUKYq
 /K3EpBWQRlV+GOYNgWa4HoQ12oi7NWK59RCT/Ge9/fg7nFcQckwULKmnc5dxHINltQjp
 zZGVfzZikdeoi/YL/c7gWp2vv1MgmQO0zPJdwjFqBEtMTu6htRVoJDmcJYEDq6GT6tuk
 0e/fyySIjLBsmHaS8FJrhJsp0J1OVa3vko9xAPXEIY6wluJPpE3dNkInlsRWSWGN7Iax
 0/eA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783374605; x=1783979405; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+v+lcXNgUDuFgvyQUuPTPcldHQ/WdfYwr9b1mHXuWok=;
 b=i6rs7fxrOf34T1MxZ41tSQLeevY+U6ySOy8u0POrJ1y0DJd2G2epK+FDwo+UJhtE1/
 rlPNUy3qcICsP1QMjbNT12Y08T98NpiXblJl6uZKCJyawiAi8NwT23mCZoVh3D+MjpVg
 /SzZ4zYgOc6XZRDEkVBhQo5D0UmUJQwUlZTwyUcl9ghaEUep7AWz3E06wXQ0HwkaInqj
 MX++S3Ymw19HJJSP7bW8v5kinZwaJ18eQfQK30NJ2+i1K8Dr5zOUxARPuzIG/ZknLDZL
 kANvmOgolMeBFeEuvt1vmVitMDIa9bnYbpsh55b/u0xDTj1A2PooPU5APUZkUBzQQSrQ
 XZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374605; x=1783979405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+v+lcXNgUDuFgvyQUuPTPcldHQ/WdfYwr9b1mHXuWok=;
 b=E9oX8KrmNPKCaliIl0MRdEfUd/wSxWPY6P6BjNq9FER1bRm7yH1AWodZOKo6WYrcGN
 NyCjPY6GnvtOaQ8G5O3xlYlamnAJ4mwJya8aNE4PC8LXzYZkb4NNv1r+aSbHyGPdfc6+
 WMN9zu4Q+uTI/T5ufnXAHUC7gC8NJUxD+yehLLj90BEL6CEsENBGexx+SVz87SphQkTr
 IN0EUnKhMlW086/kDTtCxi+Dk3F5AqLqQqMXhRHE3CaWhPgs3n0+OsqAcAFxeubP4Acs
 OlptKfCo5lJGJW+5AS4ZM4eF3c1AndH27JRQ5BDa7Hyi0Kbeu14p7HG3G+8ebCk3bOuo
 nvhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvfE4GsujXHHYMn7hpQd+gzTJUyQDnllL/8Mt6U40xE1pnYsVICKD67oElmWsLD6cp13VniEE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4oJnXu+ABjjbZDH6Ysg46PEbXkhJnNr3NL0y66rz9hcMBwQr5
 QGTG5VRcJwKfJcnl/kXOox96+bmJ3e0Z0fodhlOj0p2u30C4K9KqzkVZb6P/9f1gHLy5unBdtgu
 MuT/aGhTiBPxWHZRcrsPSfWYJGlEEoiQ=
X-Gm-Gg: AfdE7cnYZYJ2uTUqKwkKGd6twXLe3s+8PsMVfPzUqxMrr4cDRlgKqtTg9us1btntRrT
 E1UZ9e0LUKkMBww5umsFP+RrQxH2j5kKAeoVi2XhlgcALza9aAQaf+m95BxwA4tnDQLrG8Grxj3
 RjE+ladgkO1hUfT6seYnTwhkNUf/THNb83Aofo3HB1zfT1rGCLo37yhhchcTcazf0+Oi55jVwuR
 AnLWhsd1aWNC29JPIzckWJ9H1CgN1kODxiShb3SqR9cRI8GcxoYuy4sLgJTLm1mNNxnVz7o
X-Received: by 2002:a05:6122:4d07:b0:5bd:aba5:3830 with SMTP id
 71dfb90a1353d-5be89537d9emr1230731e0c.0.1783374605065; Mon, 06 Jul 2026
 14:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <akn9xLl9CGrLtvYb@Vsevolods-MacBook-Pro.local>
 <CAMDkj5wwc=mU=EA_duycozt374gFq=tapuO0u3QoejTpUYwezw@mail.gmail.com>
 <akvjpkbY-69iK7jF@Vsevolods-MacBook-Pro.local>
In-Reply-To: <akvjpkbY-69iK7jF@Vsevolods-MacBook-Pro.local>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 6 Jul 2026 17:49:53 -0400
X-Gm-Features: AVVi8CeMdmIk7_-kCcjvezVyRL751WiLP3BIbU_ZOHmUOwAX5FhyezkQYUY_IvQ
Message-ID: <CAMDkj5zm3MA9q9DfVpSFVh_N7rObFaSxX3yKEMT7b+PDxQAgxg@mail.gmail.com>
Subject: Re: [PATCH] lib/mbedtls: Do not use ERR_PTR with mbedTLS error codes
To: Vsevolod Kozlov <zaba@mm.st>
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

Hi Vsevolod,

On Mon, Jul 6, 2026 at 1:19=E2=80=AFPM Vsevolod Kozlov <zaba@mm.st> wrote:
>
> Hi Raymond,
>
> On Mon, Jul 06, 2026 at 11:38:43AM -0400, Raymond Mao wrote:
> > The direction is good, but the fixes do not match the commit message st=
atement.
> > In the commit message, only the MbedTLS native error code will be
> > substituted, but the fixes below arbitrarily overridden all error
> > codes including the standard U-Boot errnos.
>
> Thank you for the review.
>
> I have re-read the code better and I think it would be feasible to
> convert return values of mbedtls functions to negative errnos right at
> their respective call sites, because there are not too many of them.
> The only exception is the mbedtls_asn1_get_tag function that gets
> called quite many times in pkcs7_parser.c, but a wrapper function
> could be added for it.
>
> Do you think that is the right approach, or should perhaps these code
> paths be converted away from ERR_PTR/IS_ERR entirely and just return
> NULL on error, given that none of the callers do anything with the
> error codes anyway?
>

Yes. I prefer to update ERR_PTR/IS_ERR. Or at least, to have a wrapper
on top of ERR_PTR/IS_ERR for MbedTLS use only. But I think the former
is better.

Raymond


> Thank you and best wishes
>
> > Please see my below inline comments.
> >
> > > Signed-off-by: Vsevolod Kozlov <zaba@mm.st>
> > > ---
> > >  lib/mbedtls/pkcs7_parser.c     | 5 +++++
> > >  lib/mbedtls/x509_cert_parser.c | 6 +++++-
> > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
> > > index bf8ee17b5b8..2c85dcc9699 100644
> > > --- a/lib/mbedtls/pkcs7_parser.c
> > > +++ b/lib/mbedtls/pkcs7_parser.c
> > > @@ -495,6 +495,11 @@ struct pkcs7_message *pkcs7_parse_message(const =
void *data, size_t datalen)
> > >  parse_fail:
> > >         mbedtls_pkcs7_free(&pkcs7_ctx);
> > >         pkcs7_free_message(msg);
> > > +
> > > +       /* MbedTLS error codes lie beyond MAX_ERRNO and are not suita=
ble
> > > +        * for ERR_PTR, but can be useful for debugging. */
> > > +       debug("mbedtls returned error: %x\n", ret);
> > > +       ret =3D -EINVAL;
> >
> > This collapses all non-zero failures to -EINVAL, including valid
> > U-Boot errnos such as -ENOMEM.
> >
> > >  out_no_msg:
> > >         msg =3D ERR_PTR(ret);
> > >         return msg;
> > > diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_p=
arser.c
> > > index e163e16b9bc..1c70a8fcdcb 100644
> > > --- a/lib/mbedtls/x509_cert_parser.c
> > > +++ b/lib/mbedtls/x509_cert_parser.c
> > > @@ -425,7 +425,7 @@ struct x509_certificate *x509_cert_parse(const vo=
id *data, size_t datalen)
> > >  {
> > >         mbedtls_x509_crt mbedtls_cert;
> > >         struct x509_certificate *cert =3D NULL;
> > > -       long ret;
> > > +       int ret;
> > >
> > >         /* Parse DER encoded certificate */
> > >         mbedtls_x509_crt_init(&mbedtls_cert);
> > > @@ -443,5 +443,9 @@ clean_up_ctx:
> > >         if (!ret)
> > >                 return cert;
> > >
> > > +       /* MbedTLS error codes lie beyond MAX_ERRNO and are not suita=
ble
> > > +        * for ERR_PTR, but can be useful for debugging. */
> > > +       debug("mbedtls returned error: %x\n", ret);
> > > +       ret =3D -EINVAL;
> >
> > This collapses all non-zero failures to -EINVAL, including valid
> > U-Boot errnos such as -ENOMEM.
> >
> > Regards,
> > Raymond
> >
> > >         return ERR_PTR(ret);
> > >  }
> > > --
> > > 2.47.3
