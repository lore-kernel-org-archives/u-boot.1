Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4756C07CA9
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 20:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13B8B87687;
	Tue, 28 Nov 2023 21:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nWTu2/g6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F6B876D7; Tue, 28 Nov 2023 21:43:28 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C046987021
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 21:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5c85e8fdd2dso56784757b3.2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 12:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701204205; x=1701809005; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Via5dIdVSdqM5WxNXdVmVpEKuvA9CPjax0AThfIrqn0=;
 b=nWTu2/g6szpakbGRjSDd/hS1rdfvjszGuezrG6NiojL9z6MAo1rr3pZ9eDgLt5l+yp
 M7bqpUbypXBjXpfTrqyvPlOwT6tTgGeiwjiLvCC7ygzZZseYm5tvFKnGRjJ3TZpuXO6O
 6qayLrYD/6yhrHAue9AoeM17NkKOf+xOeOz2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701204205; x=1701809005;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Via5dIdVSdqM5WxNXdVmVpEKuvA9CPjax0AThfIrqn0=;
 b=YVfnv90T34xf7d2gDla+KEx3VW1AHeU7YKvBS1M8zw6rz9Rx24fParUzPmHp06bIG+
 DkNw0wsto1/lSbRnNB7K1t9/R0LQPhKeljvfsvM2X8aOU+Juu9HpWo8w+rZXuRem7DZ7
 pMeJOp4H7ZU6q5zh2etNvMM/Mffy4jaULlMCuBWI0412lbtThkErRsXc51hA0ifcU/bo
 +AgiF030jLHaB63OuBzeeMplPvpPEVRZn/o92r2qtV7Mk+nN9x7YFOz4KahZhKp8jQNa
 6A4vzUfMfAMJSyRzWexP7eFZmPAnBNnWKeH3P7ewF6IxO7rVVOZCBXe+KPahEiJ5JRV5
 +pkA==
X-Gm-Message-State: AOJu0YzzYlZBJHl35r89uftYRBmdJ+Co5C7v9b5T8anncuiY6Ch3jxkc
 KljEMiKeSIAvIzfTF8KiHH0Q5Q==
X-Google-Smtp-Source: AGHT+IFLSU4KnVFDQ9w6E9B1eWQycfo7qsVdWmRsL7yYwLQeHGLXEDgTsNqz1Gb9sjq+ajB1xZK8eg==
X-Received: by 2002:a05:690c:2845:b0:5d0:53a8:725f with SMTP id
 ed5-20020a05690c284500b005d053a8725fmr6719015ywb.4.1701204205504; 
 Tue, 28 Nov 2023 12:43:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4f9d-49d7-ae37-6b11.res6.spectrum.com.
 [2603:6081:7b00:6400:4f9d:49d7:ae37:6b11])
 by smtp.gmail.com with ESMTPSA id
 r123-20020a0de881000000b005cc636ddb1esm4136833ywe.41.2023.11.28.12.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 12:43:24 -0800 (PST)
Date: Tue, 28 Nov 2023 15:43:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, goldsimon@gmx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATHv11 07/43] net/lwip: implement wget cmd
Message-ID: <20231128204322.GB2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-8-maxim.uvarov@linaro.org>
 <CAOMZO5AdtdHDnpNUkUieHh7_jhxDOtXp5Mtv2ybkTVLamuxO5g@mail.gmail.com>
 <CAD8XO3bLiTsgaYrYUSJgiwfYQGn6C9+=VN=UhxmZOo_c3ox3xg@mail.gmail.com>
 <CAOMZO5BkNQaMxg1b=Rryrvwfbfe5-0sDLiMe8=D9=NFbdZK-+A@mail.gmail.com>
 <CAJ+vNU0-kB_aW-T_prj-9463+uqGsfsudrX0iQRsW-KQuXC66w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IUBUWIk9sLWiUsRh"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0-kB_aW-T_prj-9463+uqGsfsudrX0iQRsW-KQuXC66w@mail.gmail.com>
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


--IUBUWIk9sLWiUsRh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 12:41:44PM -0800, Tim Harvey wrote:
> On Tue, Nov 28, 2023 at 11:12=E2=80=AFAM Fabio Estevam <festevam@gmail.co=
m> wrote:
> >
> > Hi Maxim,
> >
> > On Tue, Nov 28, 2023 at 4:07=E2=80=AFPM Maxim Uvarov <maxim.uvarov@lina=
ro.org> wrote:
> >
> > > From this log it's a little bit different wget output. My version pri=
nts "#"  for status. So I guess it's original wget. You can spend time on d=
ebugging it but this code will be replaced.
> > > With my code I tried big iso download and check crc. I did not see an=
y issues.
> >
> > Thanks for your feedback.
> >
> > I will test wget again after your series gets merged.
> >
>=20
> Hi Maxim,
>=20
> Do you have a git repo that we can pull from to test for the wget failure?

Note that "b4 am" for this series works currently on top of master, and
getting more general testing on real hardware would be very nice.

--=20
Tom

--IUBUWIk9sLWiUsRh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVmUOQACgkQFHw5/5Y0
tyxMXgwAlNSGaKPWzSdTQmQUsSqoMGtQHsruCcm2uU4rXzXJEagZtV/BAWVFyakf
UY9cpSttmgRXizMMbKtD1ino6fTKV+XMnqjarXX5IZLYFUHwbP65ikMzJHqJSabE
xpSSx72CyT/9PQyV3qsXeUBI7/4/x57HiYfN+nA+u1S5FDWJ9bfcXdVYY+HU7jhT
QVjg5/Ror04ifxdzliOuY1xLgU0D2hc0sVey1Au5lPvHg9cX8Ht7u0mhe2yQJRMa
fXmK6XcCXYqPa/Vc7V4Hu2f11icxKeMnpdcV3HBYzfgr3THNt58qVPR+DEgnTmmy
FEJUlPvV3mmGyzbETu8+QLUMDVtQFePm/JT7HvXZQpxb3FkFEu7Pjjbr/T+AtCZo
lY407VX8OI6fA5qtCekG1RQ6bHC715CUAEoLD3XwJCi+KTDDjH5nhBSS8NxcrTqN
6Ol/7eQjGRW+HA4T11JHNhiUxHLQZ42Pwab0fkbOq1M0sBSSX0y+wifVBtd34FPt
7uwNWOoS
=Mud3
-----END PGP SIGNATURE-----

--IUBUWIk9sLWiUsRh--
