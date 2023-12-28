Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE64C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 17:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7276187A7B;
	Thu, 28 Dec 2023 18:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PrGx8kEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59BDC87B05; Thu, 28 Dec 2023 18:23:12 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB0B87A40
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 18:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dc05ddb656so927428a34.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 09:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703784188; x=1704388988; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2EKmdOf0yOn8w4QqvRaPNIhUEYct37QuMHgCw4jlsw=;
 b=PrGx8kEEkSWWJ0Xs5c0wPDfhH07YT91UhCb0YaxM0cIGFv4wDwit6SKtGlYXeJbllI
 Z47TbMdZGp/u7H2GbTNYc3wiPqSaD41KnYZQo96C48zO4bT7GM3mNXzXPIjWEr6H+bII
 bVzrXUI0DXzYNPqURe4BAMDYBWZbjfgkNzS98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703784188; x=1704388988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2EKmdOf0yOn8w4QqvRaPNIhUEYct37QuMHgCw4jlsw=;
 b=IsMcIc1axGVvV7AWQLKOayEmNkNVFHG35lcPL4Z4no+s8Cejs7tzmFpVlvbJnzlZjo
 JNoTfg3DazJ2FIi/NF/UQxCa59rbkpxb96DNmbSmdeXRI/ITmbyxkCcUM+Qd7KRAIEEa
 hcE9YwQ9ZixMSBvvi2b9+T8ZFc0YhkbmgC2HY/NzyjNaI0NfQYrAW/PnY5Ry8CNiD0QU
 lCT++jgdfIniVhl5R7YNDNBHu+NnSU2DlCML0F7scV3DN8NfNwbXZDwc4yw5684PJS5k
 xw7ELffjFZc3HPBHDH1vGpTf2iNBREbA2jTqEtCpx7AjFsW9TYHYgdIG3NJrceRluz4T
 kcOQ==
X-Gm-Message-State: AOJu0YzeN+6RnA1rCJ3HTHQm1FVTuBrVgingVi4aioD8k0zaRovUBv1I
 2pwEiLzLl8rSvt0LMWbyOKSAVkOsJFddWg==
X-Google-Smtp-Source: AGHT+IGsatFEd6N0L4Bxm5FQOUbSLtuTL2CVhMjvQXAdgqDLplI47BREIcOApHjO0Fh4RHluxIY5Wg==
X-Received: by 2002:a9d:69c5:0:b0:6db:b8ca:a986 with SMTP id
 v5-20020a9d69c5000000b006dbb8caa986mr7045916oto.15.1703784188427; 
 Thu, 28 Dec 2023 09:23:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 g11-20020a256b0b000000b00d7497467d36sm6164553ybc.45.2023.12.28.09.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 09:23:07 -0800 (PST)
Date: Thu, 28 Dec 2023 12:23:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] test: unit test for smbios command
Message-ID: <20231228172305.GM2652760@bill-the-cat>
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-6-xypron.glpk@gmx.de>
 <CAFLszThrHODfu-ZhHEzRe5wT-nMpXAp=UCBJC3FipTi9owhajQ@mail.gmail.com>
 <f66c51bb-7dd8-432b-9579-598eb3619c04@gmx.de>
 <CAFLszTimwDXjbQrER+808pezWD_1UaMk+g56RzNmo9Bwc9Uuew@mail.gmail.com>
 <15E00D56-2FB7-4905-832E-447090CF9EE3@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fkr0u5Sy5IAmmsXL"
Content-Disposition: inline
In-Reply-To: <15E00D56-2FB7-4905-832E-447090CF9EE3@gmx.de>
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


--Fkr0u5Sy5IAmmsXL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 06:06:23PM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 27. Dezember 2023 08:40:40 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Tue, Dec 26, 2023 at 10:11=E2=80=AFAM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> >>
> >> On 12/26/23 10:47, Simon Glass wrote:
> >> > Hi Heinrich,
> >> >
> >> > On Sat, Dec 23, 2023 at 12:49=E2=80=AFAM Heinrich Schuchardt <xypron=
=2Eglpk@gmx.de> wrote:
> >> >>
> >> >> Provide a unit test for the smbios command.
> >> >>
> >> >> Provide different test functions for QEMU, sandbox, and other syste=
ms.
> >> >>
> >> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> >> ---
> >> >>   test/py/tests/test_smbios.py | 47 +++++++++++++++++++++++++++++++=
+++++
> >> >>   1 file changed, 47 insertions(+)
> >> >>   create mode 100644 test/py/tests/test_smbios.py
> >> >
> >> > Can you please write this test in C?
> >> >
> >> > Regards,
> >> > Simon
> >>
> >> According to our documentation we can use either Python or C tests.
> >> We generally use Python tests for testing the CLI.
> >
> >Not really...there are lots of C tests for the CLI. It is actually
> >easier to code, in most cases.
> >
> >>
> >> I cannot see any benefit in trying to write this in C.
> >
> >I did go to some effort to document this:
> >
> >https://docs.u-boot.org/en/latest/develop/tests_writing.html#test-types
>=20
> As described in that document C is most adequate for testing on the sandb=
ox. I want to run this test on QEMU and real boards with release U-Boot fir=
mware, i.e. without deviating configuration.

The important part is that we have a test. And I really don't want to
re-read too much of that doc right now as I feel like it gets things a
bit wrong.

--=20
Tom

--Fkr0u5Sy5IAmmsXL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNrvMACgkQFHw5/5Y0
tyw6WQwAsXoFzhyiXr1tX/7weKiW/ofqjLMVszttdyu8uJgX912sLLh6qhKh1pu6
NZaSz7qjwGDFbkPP0BnngcdEEd0e6bN94uk5YSnrCdFeI6v4ktrXMV40RfvfB+aF
uNwMcR8VRPBxrjDIV0nJ0v+S0QQzT3Lqb+sUCa8snKtY8MtVDC4K34S48pFiJV8P
Ypl6lqxk5woX57mgJdb3N+xjTd1V7mY8eATc6xTCjy2yduyUuXpqGjEKDhokq4oh
5IM/prMHHQ269a0QWhGXhMZSkkrIlgNfpJzaHSrfUKJkBJivcoNZpL6QC2Yqgljg
pThHVqq5oW1BojRDDQBTQm6XrCl/fWzK43xvgBn5cLgRQ5epGRlXBtBaMzHgTW5t
BVM5bqDHQvVLhEriFDu4vtcUGCuteDNj127YiwiaGfuCbdvsFiDtwJ61bx9b3AMe
I7utSbB1/OSNPx0cTbsv1dusicqBgvJKqkNDuV3mKTpbuOOGEgtgkaI/xmnW41CJ
jjkhqkdV
=cROA
-----END PGP SIGNATURE-----

--Fkr0u5Sy5IAmmsXL--
