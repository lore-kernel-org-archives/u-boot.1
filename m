Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4650E7717F
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 16:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65500800CF;
	Sun, 15 Dec 2024 17:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sHaE8tz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194A28006E; Sun, 15 Dec 2024 17:48:44 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E1F80050
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 17:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d89dc50927so25193116d6.3
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734281320; x=1734886120; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l3qHZ1i3urxpu/YyuPJLRjiLbvgncD4ohGaJ68nU1N4=;
 b=sHaE8tz+R4IxBcvRYonuAV5hyearKCKztl+4a6r9ljT8Ss475tTt5Tss1LLkNZbRwO
 Ov7bkPNN9cvpVAk4kidBZUD1H8kcuRe0xKgxZ1DAKjRJGjnkw/G3jjBoyi+Ri8hcXBm5
 oe+c1JpaEOe0CvalO8i5dhYyIbDQns5g8CqQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734281320; x=1734886120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3qHZ1i3urxpu/YyuPJLRjiLbvgncD4ohGaJ68nU1N4=;
 b=rB60NUA/HLZy/0ihfdPz8fMXdjQ2P98/p50ctDMWr8BaoELvahwmjefRaapYSWUX0F
 ouy8ca99mkR1sbFc1VaB7b5XOXGvXWKogWfMQi9rluhoZ2V+n5V6AJ1dSQeVE4MkEqJF
 kxsWTjZVHXHrnWo1bjYmNA/A6n1VKYYS/nT4jX6vMAdFcj29brt+4tN5VEEvXK1aREdV
 bj2wRgmuDnHXZp3Fvj0iTmHffST2Cz7AoQyJpAQsWJg4l/IU6/dyxVYwLJ1ILEDVjr/j
 tHqWGSeTAavowpp/fijwJZFWLIG4smMN4gnliiZSwLn6OQJZykDJBjuRETxS9jMDblBI
 5jRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjNIZHW/OM80M+eqVpOQV2sKDYqSNrAsjkXPMIX4MO1shdGp9TlBn0ceq2EOtorm4azGjjHW8=@lists.denx.de
X-Gm-Message-State: AOJu0YzRautSEhW1/P3DRNunXnPHUf9Ue1C7uguoOPwIDPw1eoBEaqKH
 zy2pWPPnSixABcVXisnYVUOgTj8ziaOp2n7L8O4EwDOxEfp53NSx/3g4Xy+NGpc=
X-Gm-Gg: ASbGncureaxcFH6TPOKNrYquCD70cS15gPtZNH+QGlWyge2q4wAFXQaGBAWwnUbB37H
 7Hyy7RWGRUvevZfNTwkKyBuzi6Ow5rAeexDeeYRANuDFA/wD8cA4kxwjhSJwVmgWb7ifiK3YxO4
 pOPaD++q4d0vW4E0NnpNv2dPzzubuIYvfUKMXuZmcwb5KxBdZoYThNZ1NGZLqIN1dMWukvh4Q3n
 vfGG44LrUfPOE1AX0oY1g2YbFOcHQXGZyaUJ0KdhsZJwYGyz27KsajL
X-Google-Smtp-Source: AGHT+IHP7AiEyceLVlPslcp7CZ6EYYlQM0vrCO6AFcERJ2RLVVHqEwUTakOS86gt5RlPDJlywCtVmA==
X-Received: by 2002:a05:6214:19c3:b0:6d4:36ff:4356 with SMTP id
 6a1803df08f44-6dc8ca74ec1mr194104246d6.19.1734281320544; 
 Sun, 15 Dec 2024 08:48:40 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd26d07asm18337326d6.58.2024.12.15.08.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 08:48:39 -0800 (PST)
Date: Sun, 15 Dec 2024 10:48:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
Message-ID: <20241215164837.GC1505244@bill-the-cat>
References: <20241213225543.392282-1-raymond.mao@linaro.org>
 <20241213225543.392282-2-raymond.mao@linaro.org>
 <CAC_iWjKwm9uC09mE-Fbq6V_2tzf9DV1GrLmh2Qn=BpNSGA9irg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A363pmS6kV04emw9"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKwm9uC09mE-Fbq6V_2tzf9DV1GrLmh2Qn=BpNSGA9irg@mail.gmail.com>
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


--A363pmS6kV04emw9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 09:34:32AM +0200, Ilias Apalodimas wrote:
> On Sat, 14 Dec 2024 at 00:56, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Get tpm event log from bloblist instead of FDT when bloblist is
> > enabled and valid from previous boot stage.
> >
> > Note:
> > This patch depends on:
> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
> > https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.=
com/
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  lib/tpm_tcg2.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > index 7f868cc883..acaf0acb88 100644
> > --- a/lib/tpm_tcg2.c
> > +++ b/lib/tpm_tcg2.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/unaligned/generic.h>
> >  #include <linux/unaligned/le_byteshift.h>
> >  #include "tpm-utils.h"
> > +#include <bloblist.h>
> >
> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *ac=
tive_pcr,
> >                       u32 *pcr_banks)
> > @@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct udevice *d=
ev, void **addr, u32 *size)
> >         *addr =3D NULL;
> >         *size =3D 0;
> >
> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) && !bloblist_maybe_=
init()) {
> > +               *addr =3D bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
> > +               if (*addr && *size)
> > +                       return 0;
> > +       }
> > +
> >         addr_prop =3D dev_read_prop(dev, "tpm_event_log_addr", &asize);
> >         if (!addr_prop)
> >                 addr_prop =3D dev_read_prop(dev, "linux,sml-base", &asi=
ze);
> > --
> > 2.25.1
> >
>=20
> Tom, this is a mix of TPM & bloblist series. Do you want me to carry
> them via the TPM tree?

Yeah, that works, thanks.

--=20
Tom

--A363pmS6kV04emw9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdfCGUACgkQFHw5/5Y0
tywkvgv/Y8ztnlGEBHv8aRoWLpwM8kYUIFOdXRc7OWGej0vQRtGuopyj3g6bhltA
bhQ0pN/bNjEq4H7bwszh34nYu5ChWd2QnMUXnB/1ZaSuVk2BwKSGMkY6d9AyI6Fu
PmVz/9vgsjKNgcUqK98q4hKkcnGuuAzynoAi6TLM7Lf12QmnTYZV2SsC96bmtN7D
7+4UQqqxh8oabBmLaJ5P849I34S/5RiV3zbW18iekqhWZWOcGAXnhHrYdTSfcR4K
/wlCAb9Tk5EzStp5ybzdSLkK8COFGgGUk/N9GhnLKF4cfyqxqam0SEWBQHfYKDea
c9NJEJlBb9tQwq7OB08jkjDJ/c5PT1G2JOjF1n3bhnD27We5K9NhI6AE6wqJGP55
ug2hH3PaoSH9SIuy0gDFTgCaAhDfrHRjoKGVA/CQ6+1wINg9UoPt3XYcZJB7ee0o
N89aDf2XYHZj01LWs3z5+HAkKKbF4GzJoL0ElK/lDoOdMt0RpxIqso2nFGzmunNx
wkBbBtif
=a6af
-----END PGP SIGNATURE-----

--A363pmS6kV04emw9--
