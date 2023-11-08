Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B10C4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 14:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8588709A;
	Wed,  8 Nov 2023 15:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N4MenKmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14CA78709A; Wed,  8 Nov 2023 15:29:28 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D20D287030
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7b3d33663so85034327b3.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699453764; x=1700058564; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2GGeznGkuI+ALP86AmZLFCxNaVymprUiCqjnP4tOjzw=;
 b=N4MenKmLuqUYZz2QnhAdJwJISqHkC7B/y2o4Hb04iet70tsYBL8Yi8jZZDxzqbtyvn
 Kxgo+8iTxbGZHPVahA75dFy31ojb0muGaVN82RRsJzK7R3iIEHFHH4FN3UNtCNBEAp5L
 su+ww5htFWM0fZmQCkt1HbkHZuNYqUEjs4OBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699453764; x=1700058564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GGeznGkuI+ALP86AmZLFCxNaVymprUiCqjnP4tOjzw=;
 b=JKcrs/xrUoBULOMqkMO45q6Go0TFDAidViFOWA+xDTnSixQIIsmnx0P+zH3KJgxuAT
 4QjHQXlzxR9Pa84hvsFKsn3BT+MPy60N1jsvAQzDPZKh3BJ1iQrbaNMLay9ufzxaXfyK
 fWYQnRe9M3wIckpEeVqWPECDF4V6bXvjN5mBRBQ2L2QtsTy2aG+2DnbjB8k9lCWKk9h1
 AKYj4wLMmBZ6wvshszLNu93kmvWZf8eG1zGOfIZotWPhsNGoVL6tS6tO3+SYbS1Aa3fe
 IYGb/Wwr/4M+CJA8SD2oDn5sZGT6vug8Jcc+fZYXJ81gN8cYeXg6UnxwkYVJu9r25EOa
 GdLw==
X-Gm-Message-State: AOJu0Yz+QWPmlDNEvPqvpHsLLkBvQfXMwUhaNIjfWEtAIE9ULZVNe7Bk
 TGx+/jBp2HmT0s5bvD1yyyfg0w==
X-Google-Smtp-Source: AGHT+IH88l0Iee9ytqwgkjwOuKypsZNiP83gEamaUD3qOBlNU7xUs/NIO8uPyZpbcwd/ZkKznCSnTg==
X-Received: by 2002:a81:48ca:0:b0:5a7:a81d:e410 with SMTP id
 v193-20020a8148ca000000b005a7a81de410mr1945503ywa.18.1699453764547; 
 Wed, 08 Nov 2023 06:29:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a81ff0a000000b00576c727498dsm6920311ywn.92.2023.11.08.06.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 06:29:24 -0800 (PST)
Date: Wed, 8 Nov 2023 09:29:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Alexander Gendin <agendin@matrox.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [tom.rini@gmail.com: Fwd: New Defects reported by Coverity Scan
 for Das U-Boot]
Message-ID: <20231108142922.GN6601@bill-the-cat>
References: <20231106202752.GH496310@bill-the-cat>
 <ZUr_dobret3zW48s@alg-gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/vxHFe7uvCkTqYFv"
Content-Disposition: inline
In-Reply-To: <ZUr_dobret3zW48s@alg-gentoo>
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


--/vxHFe7uvCkTqYFv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 03:24:38AM +0000, Alexander Gendin wrote:
> On Mon, Nov 06, 2023 at 03:27:52PM -0500, Tom Rini <trini@konsulko.com> w=
rote:
>=20
> > Hey all,
> >=20
> > Here's the latest report. I _think_ I passed the right options to
> > get_maintainer.pl such that it would only look far enough back in git to
> > find the likely authors (along with listed maintainers of the files).
> >=20
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Nov 6, 2023 at 2:58=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >=20
> > Hi,
> >=20
> > Please find the latest report on new defect(s) introduced to Das
> > U-Boot found with Coverity Scan.
> >=20
> > 13 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> > 5 defect(s), reported by Coverity Scan earlier, were marked fixed in
> > the recent build analyzed by Coverity Scan.
> >=20
> > New defect(s) Reported-by: Coverity Scan
> > Showing 13 of 13 defect(s)
> >=20
> > <...skipped...>
> > *** CID 467404:  Control flow issues  (DEADCODE)
> > /test/cmd/mbr.c: 217 in build_mbr_parts()
> > 211                                             return 1;
> > 212                                     strcat(cur_buf, mbr_parts_p5);
> > 213                                     bytes_remaining -=3D cur_str_si=
ze;
> > 214
> > 215                             }
> > 216                             else if (num_parts > 5)
> > >>>     CID 467404:  Control flow issues  (DEADCODE)
> > >>>     Execution cannot reach this statement: "return 1U;".
> > 217                                     return 1;
> > 218                             }
> > 219                     }
> > 220             }
> > 221
> > 222             cur_str_size =3D sizeof(mbr_parts_tail);
> > <...skipped...>
> >=20
> > --=20
> > Tom
>=20
> Hi Tom,
>=20
> Thanks for the report.
>=20
> The patch to fix CID 467404 has been sent to the mailing list.

Thanks for the patch, I'll make sure to grab it before the next -rc.

--=20
Tom

--/vxHFe7uvCkTqYFv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLmzkACgkQFHw5/5Y0
tywNKgv+LOaaNhpYJwCOUL+EHj0Ch20mJ2E6K/vgqA+tyqPxn3PaKwO9UOF47JrN
Rf/B4HU5JzkTq2ulC++L9yDzAv8aNikjAE/qAK58cc4pm85RaiOiUVOwwAYJ4Y1g
SpMnN0AwD2VipZdQc/CGjxWN+IaZbbgaRDhXtrzxq43LHUNsmSNdyEl1WKu91f76
xYHF+Jys4DuU7DprQidyaFP0vRolzYCLdmq5SSSS8nmY70XThMIcUSCbpRtupChZ
4zNEbWdpwcWGDzrCbabhgUW7F6xMyeIE4/hyjcQKpGzcdTgOcGLqdLptbDh14V02
GI+VowlgMmG8k2tj7xVyWlTppeuz8da44QIG3lRd7zXjFiCV91VZ81qtyXJ/fvg2
59RFySLk8wO+/CtUOyp0HnqpVvv1IkE1I4qWL94wzuJxo1Z/DC3wbydkGZ7kyWRD
uJ47mVYiot5wp3yI380n6moiw+Y2vzbt5TX1tPbAcpYRMtBBVIXj8u89KNuo3jyb
x5j2r5en
=NQXI
-----END PGP SIGNATURE-----

--/vxHFe7uvCkTqYFv--
