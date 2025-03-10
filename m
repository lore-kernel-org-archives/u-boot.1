Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8D2C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 21:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E453080107;
	Mon, 10 Mar 2025 22:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FMbytdT2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF1D807D9; Mon, 10 Mar 2025 22:49:12 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB2E800C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 22:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-219f8263ae0so90265455ad.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741643349; x=1742248149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+/65f+T8d3Sklf6M+oPeDN92op/k1WXT8CPmHqHGdxk=;
 b=FMbytdT2Uw/Yr3RkT34yT4c45XOJOEigYcnjurki3qipNgcxH5qJ7YUPCsrHkSgPwq
 kzE6ViwURN6uA+qOXu53G3+awXvgl7cv13cSGKdcdphxRrlwEwBh7vYqSS1LVKLp5+2k
 xcgHoegRBD/LorSgBpgkaGfnTuaGSYI9qwXVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741643349; x=1742248149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/65f+T8d3Sklf6M+oPeDN92op/k1WXT8CPmHqHGdxk=;
 b=d+RY0Zp1KQFndGxx21DQQ4FJDTJccRlqw1e0VfkfZl01O6N1anTBGagkd0QVtQop8W
 3Y1qMoom2KBHtCb+dhVuJqoEEAiXyE/axYRLLpOF5ODrZjNR5DMmjBfhFDNTeP6mpx9R
 UBxWv/wFQTdeXLGJp2V15NjDV23DWP1HH/XgDZcX1eNISqfJ8Lr2whRv6k/LkHGJBknQ
 YX4OfwE37hy5UZy4P+0nXFuqWL6P07BEjgItgDwY9exHbnCXOpgvtX1xlDQ3SUURlKTF
 rNDGOos02EeMqwqnkWdl2vKo8bLHmnyp/VJc86ta8LpWQeVQZFCNawo0wyRxtaWJ+iVR
 J8+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfpWPO2fVSXum89pzvHGGKeGAAeROrGHkAQttkzMIhMhuOL5Dh9U5AFuUBPRlrS674B4ot9xk=@lists.denx.de
X-Gm-Message-State: AOJu0YwAMEz0a/7MiuWFDUArcQJB0EA+u9APoi5/Rz0pJlNVhDr5S3C2
 z3VuxRlMJw9amOV7CxIpAFiqzkfraebdlhXAejj1d4kItxhmVsQrdrgrvdcocVw=
X-Gm-Gg: ASbGnctLJ4mEaf9o4yVcKrjdyj0BOiysLcF/QN8TrUYHSZBt50Vy+4MNCnhLc4XrJfa
 5MshW6tcCgtTd77Q/RATX7aDjntJwXr5TyuGwMXd8e2+p1jbtCjIC2vOonqeVi4p7LgcTZjUh/w
 y4nJ4hUKvwzSjAB7BUdXrS/+4WLRowA29S3vTsbrmQtX1OjUBLN1Fz62ZLwhpSSm3QNto8PV0Q3
 PFApXBYeqZEfeIfkLAzguN9/vhD3BfYmUlBzAqKNqpKpfdCDfsq2nME0dnqiAV0RimjIBDTscPd
 iNnw0cDP/FDW4kVMHPmQay56E6b2iEYOE5/4IYX42d3Ee33/5cM5UnMY
X-Google-Smtp-Source: AGHT+IHi+qCECkN/O8wkaiHC2ZoPdvey1LL16U92hDMgQ3zCDRfp9vuXpxI9T34iXk7Bf99XkgN+NQ==
X-Received: by 2002:a17:902:d488:b0:223:3ef1:a30a with SMTP id
 d9443c01a7336-225931ad489mr13602815ad.45.1741643348815; 
 Mon, 10 Mar 2025 14:49:08 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f7fasm83589985ad.115.2025.03.10.14.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 14:49:08 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:49:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 08/12] fs: exfat: Fix conversion overflow errors
Message-ID: <20250310214904.GO2640854@bill-the-cat>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-9-marex@denx.de>
 <393a7b06-402a-48b0-8ed4-5dcaa7ab9383@cherry.de>
 <a7b192b6-48b8-4878-a6dd-563dbb9bdb06@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wTCRC5hjqsW94fKY"
Content-Disposition: inline
In-Reply-To: <a7b192b6-48b8-4878-a6dd-563dbb9bdb06@denx.de>
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


--wTCRC5hjqsW94fKY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:03:37PM +0100, Marek Vasut wrote:
> On 3/10/25 12:17 PM, Quentin Schulz wrote:
> > Hi Marek,
>=20
> Hi,
>=20
> > On 3/8/25 9:12 PM, Marek Vasut wrote:
> > > Fix the following conversion overflow errors. The input field is alre=
ady
> > > limited to 3/2/1 bits using the bitwise and, move the parenthesis aro=
und
> > > to avoid the bogus warning:
> > >=20
> > > "
> > > fs/exfat/utf.c: In function =E2=80=98utf8_to_wchar=E2=80=99:
> > > fs/exfat/utf.c:165:23: warning: overflow in conversion from =E2=80=98=
int=E2=80=99 to
> > > =E2=80=98wchar_t=E2=80=99 {aka =E2=80=98short unsigned int=E2=80=99} =
changes value from =E2=80=98(int)(short
> > > unsigned int)*input << 18 & 1835008=E2=80=99 to =E2=80=980=E2=80=99 [=
-Woverflow]
> > > =C2=A0=C2=A0 165 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *wc =3D ((wchar_t) input[0] &=
 0x07) << 18;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > > fs/exfat/utf.c:170:23: warning: overflow in conversion from =E2=80=98=
int=E2=80=99 to
> > > =E2=80=98wchar_t=E2=80=99 {aka =E2=80=98short unsigned int=E2=80=99} =
changes value from =E2=80=98(int)(short
> > > unsigned int)*input << 24 & 50331648=E2=80=99 to =E2=80=980=E2=80=99 =
[-Woverflow]
> > > =C2=A0=C2=A0 170 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *wc =3D ((wchar_t) input[0] &=
 0x03) << 24;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > > fs/exfat/utf.c:175:23: warning: overflow in conversion from =E2=80=98=
int=E2=80=99 to
> > > =E2=80=98wchar_t=E2=80=99 {aka =E2=80=98short unsigned int=E2=80=99} =
changes value from =E2=80=98(int)(short
> > > unsigned int)*input << 30 & 1073741824=E2=80=99 to =E2=80=980=E2=80=
=99 [-Woverflow]
> > > =C2=A0=C2=A0 175 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *wc =3D ((wchar_t) input[0] &=
 0x01) << 30;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > > "
> > >=20
> >=20
> > Since this doesn't seem to be U-Boot-specific, any chance to open a Pull
> > Request on the project so we may be able to not carry this patch when
> > upgrading (yes, the last commit in the branch was two years ago, but it
> > seems the maintainer is still active on issues).
> >=20
> > Considering that wchar_t is an unsigned short int and that USHRT_MAX is
> > 0xffff (so 2B or 16b)...
> In fact, this error does not even appear in upstream , because upstream d=
oes
> not use -fshort-wchar compiler flag . U-Boot does use this compiler flags
> since 4a85663ec7ed ("kbuild: Enable -fshort-wchar") .
>=20
> So I wonder if this might be the right fix here instead:
>=20
> diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
> index 550c0683d65..8ca112cf0e9 100644
> --- a/fs/exfat/Makefile
> +++ b/fs/exfat/Makefile
> @@ -1,6 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  #
>=20
> +# The utf.o does really need 32bit wchar_t
> +CFLAGS_REMOVE_utf.o :=3D -fshort-wchar
> +
>  obj-$(CONFIG_FS_EXFAT) +=3D \
>  	cluster.o \
>  	io.o \

Your initial approach is right I think, I'm not sure it's a good idea
to mix and match that flag throughout the codebase.

--=20
Tom

--wTCRC5hjqsW94fKY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPXkkACgkQFHw5/5Y0
tyxfagv7BPO3xg3xRbbx2F0BPsQDIXi/VAxFncNIPTcZaZbJE+1v5UYQCh1OT4eL
8ZeSAJeVwBLGXu+wbcUEzWeS+vTPNOb24njI+OInaxRL13Yu4XNrIcvAaziO8mJo
0ew4dzRtGy0BOLQKev5bSGf8kwGDOmNsM6y6znDMGI/G9AuvxV9whouRlYaS2X1j
Nzl1FURPKo4M236SRoT57WTwtWjFxxVxuGZ+y433xz1Cvu4v7XDWOz225YtjEDKh
dOF3fhaBzatqvI0DiHyhcLOcpnyQjHUQGs0OnONt3RNwJb5OITzo3TbYAyaqcHe/
UG2qL8GgmBNbcGyy5odJ94vdIjgAQMN5u83Mn0hmVVFGDDemCxJX7fOdUd9WEXNT
sE6q+KNoT/XvTUSaI7VmIyBFBL0TXAK8mjXVrybshBL+gQqO4LzkEFO8TSWVJFrD
qLfqBoN+l/Qqu6qsAEVjTsKxb2E3cs+8tbZJJ3Jrobr0HNqjLlXF7iHuKk5IWieg
uKHHCqvy
=pEUl
-----END PGP SIGNATURE-----

--wTCRC5hjqsW94fKY--
