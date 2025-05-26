Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2C4C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 22:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74F482E2D;
	Tue, 27 May 2025 00:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IcaVw1Ck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6481B82E34; Tue, 27 May 2025 00:02:01 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3874C82D4A
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 00:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2e4bbd9cad6so1300626fac.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748296918; x=1748901718; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WkPCzCeZ/V1FBcevnQ/J914qg8O5ADn61mpxfZoEAok=;
 b=IcaVw1Ck8Dwa96F1KiSjlP3iNJORKXMZg2Upww/0nT/rqFaOuqnczcIcXzRHQTpbLo
 ILrPdRKW5g3wIsTZeovdRosPZOEWU9V0BD4qVuY2ZY0T8GLw+Jhr4LxRM/Kp3UFfl+hr
 z9FGrWt5bYOep9+TzNttqMnbEMBF3SccL8xHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748296918; x=1748901718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WkPCzCeZ/V1FBcevnQ/J914qg8O5ADn61mpxfZoEAok=;
 b=GTfHAb0DPGNQeIsGiEy2ON1hdCCcZ8kxYJZTkOwCQU4eR05yViRsRHJy17vRnCbm2o
 TksdwGml2y4NnHv+BpvPYqbsjR1kECTIbt3kyk0WJS8qSuy0jkRoFXT8UNBPxWf5L7vr
 IGNmYcIhWGJjXE8gYuSOSjtmT0mt03Xvk54KV9HlIsQsDDFft+qbx4yT5SQO7Ch+LbOI
 trKK0bmlx41qqr1lo6is6beA+c/M4ImuHEKMXtRIpTs6u4xLaLpMJ3wSSeV1Z+VWOofx
 8726hjp6z3oalwN08TeIYTrpg0LJo9nP9BSXBm2y4VbwlJIXmtN94Ay2CmGNN1/p71kw
 aC8g==
X-Gm-Message-State: AOJu0YynoRlwDl+Fz7m1hAS9h0qMd1l/PQNCcFnL4uZJQfnvdprvCLv1
 dICjL2NXVVLPJKLPjslZ34pixZrPZDKfB/FjgjC11kUtQotNo7IowR6ZLoCDhgBbO9M=
X-Gm-Gg: ASbGncueowM34U7cWkZ8msw7u6qgDvilrQisbmx7v0Xo8pFkeL8iZAD5eQ2/YAUs+7M
 1TxKMxK2rvLPzACjCQmV5sKjQftPa1FBlrnf4JJ3Kc+O3WtSpm3ffp2xhj7Ll31APPXY5HHk82g
 PcXTYNGeOsAtBXmm/YSSb0d6ci7fLTBc3EEOSaEcnWAweBaNsjvmmotYvJrdkXiPoN4e7MzisX7
 DYQMnvT78Kuni3vqxQb29anwcH+O17h9LLs+YQ2DPzHRMETthQOO7/RrAJN7jK81yBdm9bGinr2
 jV+0MWqasQHsRTmM53f3bauTznrZvHl63fs8GQ5XWFMCW4GUPbcLKMuRXnrhEnuqhtw7/kXR8MN
 XoI2utKilTkxqjmyi5Z6TsbU=
X-Google-Smtp-Source: AGHT+IFNsOj3lYAO1+vs1PedkTUnZULvfwoaOaeWxDHOs+sL+Ul/xRd7jZGFf3wtlXPcSfXMErILVQ==
X-Received: by 2002:a05:6870:af44:b0:2b3:55b3:e38 with SMTP id
 586e51a60fabf-2e861f383a7mr5537754fac.21.1748296917930; 
 Mon, 26 May 2025 15:01:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c075b1fdsm5117089fac.24.2025.05.26.15.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 15:01:56 -0700 (PDT)
Date: Mon, 26 May 2025 16:01:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
Message-ID: <20250526220155.GE100073@bill-the-cat>
References: <20250507121246.518691-1-ravi@prevas.dk>
 <20250522165656.GB2179216@bill-the-cat> <87r00c3143.fsf@prevas.dk>
 <20250525230201.GS100073@bill-the-cat> <87msaz2i46.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ku+sL/Kd2ziupSlS"
Content-Disposition: inline
In-Reply-To: <87msaz2i46.fsf@prevas.dk>
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


--Ku+sL/Kd2ziupSlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 11:10:33PM +0200, Rasmus Villemoes wrote:
> On Sun, May 25 2025, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Sun, May 25, 2025 at 10:07:56PM +0200, Rasmus Villemoes wrote:
> >>=20
> >> :( so we've been relying on that prefetch() laundering away the
> >> volatile.
> >>=20
> >> Which really begs the question: Why, exactly, is it that gd even has
> >> that volatile qualifier in the first place?=20
> >
> > The answer is likely early 2000s GCC.
> >
> >> I'm 98% certain that we could drop that and get better code generation
> >> and avoid a ton of places where we cast away that volatile which
> >> shouldn't really be there anyway.
> >
> > It would be a good thing to experiment with now and maybe try for real
> > in a near-future merge window.
>=20
> So since it's declared per architecture I just tried with arm for now,
> and this
>=20
> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/gl=
obal_data.h
> index 45401d5e3c8..f7a47204b7c 100644
> --- a/arch/arm/include/asm/global_data.h
> +++ b/arch/arm/include/asm/global_data.h
> @@ -133,9 +133,9 @@ static inline gd_t *get_gd(void)
>  #else
> =20
>  #ifdef CONFIG_ARM64
> -#define DECLARE_GLOBAL_DATA_PTR                register volatile gd_t *g=
d asm ("x18")
> +#define DECLARE_GLOBAL_DATA_PTR                register gd_t *gd asm ("x=
18")
>  #else
> -#define DECLARE_GLOBAL_DATA_PTR                register volatile gd_t *g=
d asm ("r9")
> +#define DECLARE_GLOBAL_DATA_PTR                register gd_t *gd asm ("r=
9")
>  #endif
>  #endif
> =20
>=20
> builds, boots to linux, and passes our test suite on our
> beagleboneblack, imx7 SabreSD, RPi 3, RPi 4, RPi-cm4, wandboard,
> imx8mp-evk; i.e. a good mix of 32 and 64 bit arm.

That's a good set of datapoints, thanks. Do you want to post a real
series at some point or should I do it and Suggested-by you? Thanks.

--=20
Tom

--Ku+sL/Kd2ziupSlS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg05NIACgkQFHw5/5Y0
tyzGkQv/ZSUT6MArS2ZLc99kU9otVF0MDwQFWg1rj3W+qP/W51jTWrf8cU1pzL1g
o0fIwp2tVBEfxkKlOGTumFZyQIKRGULyUmOLp4CarYSwCynFD9v2n8K1yqeIdWKQ
NBf1K5glWhekSGt9aGtrSSLVyQW5XHeBGJS1UvtIiXVFKCr7usLRbUqvzWjPo1rl
3Ki8ynDSB3CD281vs5EZLwFoC+xwO80I16Mp0cHGNXOAuGd2i4TywfCTnzXiJq8V
nfHaWmwBNSoKKb6UrexaNI7gcVzRKRcgRUMeHRDTck5nu2X9kfurpEtgrMY8xrZU
cxxTexKrcrG3HA3MMSENUgJ1PnNtwjuytT3Z5Fq4SqKEsCqEuG5yoUSdelH5xRLD
Rrnb9v9xG06OSjr0IAwIau5z6heyhi1eF0b/h3oBPp7NN9SRs2mf57pki02VPEVT
58steVBj+tUBch8jn3tOM6vYrUTFCzfMaAMJPA0YFJPP3NdASu1m02kLZEZHl0O4
sQlXdSxk
=X5nB
-----END PGP SIGNATURE-----

--Ku+sL/Kd2ziupSlS--
