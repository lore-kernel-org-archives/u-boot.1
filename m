Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E965CC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 18:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 633B68850A;
	Tue,  4 Jun 2024 20:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rlWt5Dp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 288DD8850E; Tue,  4 Jun 2024 20:01:42 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D1E88501
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 20:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f91152ff00so35198a34.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717524098; x=1718128898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gDXGpmG5Ec7wqK55L5mlvK45HcKk65WoW5SLTyegrNI=;
 b=rlWt5Dp1J0HUnAIa28mi1jWFLEX0dhtLb5xc9vAvO8RDV5WLzwlMiLhN8LoT3h9Hus
 8/5/BNXjS3BtDkZlsxoQk5g8u9THCy9oq7fOPvv8mRu27uEqhuLasAV43GUtFF+hg0/k
 osXOjPuKzq1aHN0BggKEW2p5z8IoouJsOmHJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717524098; x=1718128898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDXGpmG5Ec7wqK55L5mlvK45HcKk65WoW5SLTyegrNI=;
 b=YaiHXzUEWZi2QPcaKDvxEgDG3pG3+Zq7DoB9pw2ibo/VJsx7eKlJ2dRVVYPiejwcF1
 ERnPial/flEKpT8HufN2h/+yITs0e/t4nIy7Ew2IdXCjt3s6IOYScg8rZdShr9MvJP2W
 P9KOfmZJU2QnvTEkvn1S47sBhav4i7erxePvuof3umKPHbuobGJy0YSqSzD4EnRiSBQf
 b6AgB1HB8hwQcCgbJHpkiR0j0fEQa1tyitag5whGdIJApfXKFersM1YTriVX7i2oUenV
 rJu4648Qe9flNmRKw3654VTI3oUXDTn3beULglNIxhN4rqamevAy1D48jlfOxzTVWBKM
 xJmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFzOjejbB4+dfsx+wTH9s+dOva5ln9Bd3x/g6o54RwNCg0v3J3JiDYuswYcc9nuvvqxROzDSQvuoggUYzw810rL/oW7g==
X-Gm-Message-State: AOJu0YzFVOIAiz//bZOWqM1KJOE4kopnU0j7fuHg6YPmMO8+wH5kYVRn
 u+3vduFxrwxJuSK6HzJ2ejlzVz038ZV4uOwmXmUJ4W2auhWOSw02A1hXXSsKLR0=
X-Google-Smtp-Source: AGHT+IEask/J2XI8zztCS0WOugmDF9WC05SW4zRfOyl2ORFLcocS9VoENs5I0jQ4rGk6boY6VU3MDg==
X-Received: by 2002:a05:6830:124e:b0:6f0:f199:1ccf with SMTP id
 46e09a7af769-6f936df8d51mr1389701a34.0.1717524098430; 
 Tue, 04 Jun 2024 11:01:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9105231absm2034920a34.11.2024.06.04.11.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 11:01:38 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:01:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v3 15/25] mbedtls: add X509 cert parser porting layer
Message-ID: <20240604180134.GN68077@bill-the-cat>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-16-raymond.mao@linaro.org>
 <CAC_iWjJry9zAU0B5P+dmBj6E9m+NZqGEZhGj3FZ08SB3q7B1Vg@mail.gmail.com>
 <CAEfUkUJ64bwK_+mz5o_R1RwMtYoLD6=3xtMn-o2czJh5NHi14w@mail.gmail.com>
 <CAC_iWj+rrSz+1n+9kqjw-gkX3ja6SK-35S67pMkkVFAcQuyjLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0Rzp+2bUWFQ7LL+M"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+rrSz+1n+9kqjw-gkX3ja6SK-35S67pMkkVFAcQuyjLg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--0Rzp+2bUWFQ7LL+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 07:53:54PM +0300, Ilias Apalodimas wrote:
> On Tue, 4 Jun 2024 at 19:05, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 31 May 2024 at 07:42, Ilias Apalodimas <ilias.apalodimas@linaro=
=2Eorg> wrote:
> >>
> >> On Tue, 28 May 2024 at 17:15, Raymond Mao <raymond.mao@linaro.org> wro=
te:
> >> >
> >> > Add porting layer for X509 cert parser on top of MbedTLS X509
> >> > library.
> >> >
> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > ---
> >> > Changes in v2
> >> > - Move the porting layer to MbedTLS dir.
> >> > Changes in v3
> >> > - None.
> >> >
> >> >  lib/mbedtls/Makefile           |   1 +
> >> >  lib/mbedtls/x509_cert_parser.c | 497 ++++++++++++++++++++++++++++++=
+++
> >> >  2 files changed, 498 insertions(+)
> >> >  create mode 100644 lib/mbedtls/x509_cert_parser.c
> >> >
> >
> > [snip]
> >>
> >> > diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_=
parser.c
> >> > new file mode 100644
> >> > index 00000000000..b0867d31047
> >> > --- /dev/null
> >> > +++ b/lib/mbedtls/x509_cert_parser.c
> >>
> > [snip]
> >>
> >> > +static int x509_set_cert_flags(struct x509_certificate *cert)
> >> > +{
> >> > +       struct public_key_signature *sig =3D cert->sig;
> >> > +
> >> > +       if (!sig || !cert->pub) {
> >> > +               pr_err("Signature or public key is not initialized\n=
");
> >> > +               return -ENOPKG;
> >> > +       }
> >> > +
> >> > +       if (!cert->pub->pkey_algo)
> >> > +               cert->unsupported_key =3D true;
> >> > +
> >> > +       if (!sig->pkey_algo)
> >> > +               cert->unsupported_sig =3D true;
> >> > +
> >> > +       if (!sig->hash_algo)
> >> > +               cert->unsupported_sig =3D true;
> >> > +
> >> > +       /* TODO: is_hash_blacklisted()? */
> >>
> >> Is this supported by our current implementation?
> >>
> > This is not supported currently either. I just copied the TODO mark
> > from legacy lib.
> >
> > [snip]
> >>
> >> > +               }
> >> > +               goto out;
> >> > +       }
> >> > +
> >> > +       pr_devel("Cert Self-signature verified");
> >> > +       cert->self_signed =3D true;
> >> > +
> >> > +out:
> >> > +       return ret;
> >> > +
> >> > +not_self_signed:
> >> > +       return 0;
> >> > +}
> >>
> >> the whole function looks like a copy of lib/crypto/x509_public_key.c.
> >> Can you move all the c/p ones to a common file that the existing and
> >> mbedTLS implementations can use?
> >>
> > Per a previous discussion with Tom, eventually we tend to keep only one
> > crypto lib, that is the reason I prefer to copy/optimize a few existing
> > functions into MbedTLS implementation instead of creating another
> > common file.
>=20
> Regardless of the implementation, the common functions should reside
> in a common file which will be used regardless of mbedTLS or the
> existing stack.
> We do not want to fix bugs twice

And please keep in mind we already have _two_ implementations at times
today, and it will stay that way even when mbedTLS replaces legacy
options.  The ARM HW SHA256 option for example is going to likely be
used over mbedTLS SHA256.

--=20
Tom

--0Rzp+2bUWFQ7LL+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZfVncACgkQFHw5/5Y0
tywctgwAj16VOUOTtvNMe9sbqakGZa66I0lAkjL8AYM6uKxbIGUSSEA0Q8rUKVtg
EBfjCYaajISpQyXtFid+UY9JgAbQX5b9Vw+DHfjHTmE4++cUTlS7ELSSPRoPHVXV
ZUHKiVjSXSqkxdfCNm/Uce5VZzSALrb1q1yo4pbZw8l764RE+sAbo1lEd1ldWEVi
sN/TBIpBnZxEkxxJzCNFfPwZ4d5uRL4kPn/FJ9q5VivInhvWSL9j8bkGKteCR3RC
2umgLgO37UyVz5AOhKb4ek1SuiuT0D8ZnwLUDkK/WvySF3rZbDEMtEqgifkhHjjb
72iVZnmxRYO+gHozS5IWONYrArj8tqxbSiMQdib3fb+o0K6SmSaPI/eN8Glkd1Da
20VBPPze3+rX4khNEmgmeyBB/rDsMHh6XrevRn3IBoFF83pNykKm/vlABGzZ868F
sSfo25p4Pk6aHKY4/Mx8IPwJC/wg3S8Wt0PrqO4zT8iezacMU76RvLFA5/mwRQCh
W6A5tXqs
=F2+c
-----END PGP SIGNATURE-----

--0Rzp+2bUWFQ7LL+M--
