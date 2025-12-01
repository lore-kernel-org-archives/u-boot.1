Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F65D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A0E283BA1;
	Mon,  1 Dec 2025 17:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nzTY8MdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB4083BA1; Mon,  1 Dec 2025 17:44:12 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B3683B8C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3f11ad6e76fso1214787fac.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764607449; x=1765212249; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NXndSMTMYSiw1tC3Lbe0FpPzl3L4BYU2sKRFT5dSXYM=;
 b=nzTY8MdGgioZkDJP+ppv67QCcwgSyHeHLB7MID7pvhaGqDz7hkPu1cgQW1UI3mzUPK
 RYa+0/rUz9hzIwycDwTBsJj7mk8EmgCDSJhpz7MmI9cbBxOd4MTlYI0XttUTByUjv5Wy
 6QKk7P5s64SESuU3IxrsEhpCXH7lHtucYKib8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764607449; x=1765212249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXndSMTMYSiw1tC3Lbe0FpPzl3L4BYU2sKRFT5dSXYM=;
 b=pRKUzH7ULkc6xrmT0Ci/M0P0DzTfaTqL7pDfdM42MNlMW7NossOGXcCR8hnaYwi7hL
 3ZJJB4kfvX41qAjrxw8/ijUxMvQgWLLcyaHdaJfz1sDJwPqIf41TLmUT1N1yCPBvszSe
 SZDjs3afMoeSgQEN+Mic+CpeCZVDgBJqsELWJIQHArxyGWMBeHBMe1EAmRT6+zIf0bnl
 OXQob8TsTG9Dv0B3x4XlTMUEjAZmhcelU6fPyp3oddJN/K6Kwz4q39DOpW1NPoTOW3Wv
 KjnzxxpiV1O2ZWV+jA1YEXYy95BMFhT7n52/jhhihqapP/4naYJZ4h/qV8pDk4twP5ad
 c9fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU17DuhilBd3Dj6+malh+D05Oflx8d+vNieIspGUWKezkEteLMOO7KEdXRIkkb6cAfNg2A3Hto=@lists.denx.de
X-Gm-Message-State: AOJu0YxPObrpAHMnqg+eKO95e560rO9zXagSieHMWwdDI0xsfLnvCakf
 PnxMSqJv7cdLRckT1ZadAEVqVMtRvF8MFVJotVm0V/2Qs44pBvUlHKM5zwBp/tBW18g=
X-Gm-Gg: ASbGncv1lEs14zfi3XfgGQvBXI/DZa6l6v2n1EWY4h/VhGa2Apg4wcQSJpAtqJ7sZjj
 5sUbsND3Vo2CWpbG+R85hlYi5JV7+Rf1Epd9pRKb4nmFdORJGqr1GjfF5rt+dCJAIz/cxHwajm9
 iP9p/KhXwxznSwepFajM9oBZK8V450NQ8q3F98oc+QKJ36cSdEp7FrKKyROF/+WxFApvdkTM9h6
 8t1QK42ja5mMW3gup9tVOOP8x4iFemfZc/9R3h3++AqiXMQRpinfxgACNTVhIBpiLzhrA9W98bX
 iOdfk3MQFhHxNYhq0x3enNJy1mqLprcrzZY0KBBLg/wW5eVL2rTOmzrxGQyCGG7XZ9qN0imC/Cv
 cxdc2NBETYtSyU3ExZio8Wn7bcCvNGtIu8mejEQgTYzL1ha5DsfNUFAg64knHsqf7hwyLK1f8RU
 6RX/MJNa8Kfwdy37iM3A1PWnZt2mkLGKddy10jlBKk8UXwU75hpA==
X-Google-Smtp-Source: AGHT+IHDeQJ6QatbJmTQ+NpD7ki+cj3jGMomxvXK1CeJYeTU6mYziL+7eGByuhxSlgVp52KnwYL53g==
X-Received: by 2002:a05:6870:8814:b0:3ec:3d84:3c5a with SMTP id
 586e51a60fabf-3ed1fdead99mr12076566fac.45.1764607448691; 
 Mon, 01 Dec 2025 08:44:08 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dc9ff3f3sm5487556fac.2.2025.12.01.08.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:44:08 -0800 (PST)
Date: Mon, 1 Dec 2025 10:44:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from
 empty built-in.a in SPL/TPL/VPL builds
Message-ID: <20251201164405.GG303283@bill-the-cat>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LI8Tv7uzOoRMmBDm"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
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


--LI8Tv7uzOoRMmBDm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 08:46:14AM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=8829=E6=97=
=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas wrote:
> > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zakuan wro=
te:
> > > > >
> > > > >
> > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > [CAUTION: This email is from outside your organization. Unless =
you trust
> > > > > > the sender, do not click on links or open attachments as it may=
 be a
> > > > > > fraudulent email attempting to steal your information and/or co=
mpromise
> > > > > > your computer.]
> > > > > >
> > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > > >
> > > > > > Hello everyone,
> > > > > >
> > > > > > > I already have the referenced commit in my test branch, and I=
 can
> > > > > > > confirm that the same compilation error still appears on Cycl=
oneV when
> > > > > > > certain directories produce no SPL objects.
> > > > > > >
> > > > > > > The existing fix ensures that built-in.o is always present, b=
ut it does
> > > > > > > not prevent ar from generating empty built-in.a archives, whi=
ch older
> > > > > > > ARM 32-bit linkers (such as CycloneV toolchains) reject as =
=E2=80=9Cfile
> > > > > > > truncated=E2=80=9D.
> > > > > >
> > > > > > Which toolchain is this ?
> > > > > >
> > > > >
> > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile our So=
C32 devices
> > > > > - CycloneV and Arria10
> > > >
> > > > Ilias, do you recall the solution to this problem from when it came=
 up
> > > > on IRC a few weeks ago?
> > >
> > > Nop unfortunately not.
> > > Was this caused by the Kbuild bump? I remember the logic around
> > > builtin changing significantly.
> >
> > Yes, and I kinda thought we narrowed it down to something being missing
> > from the update, since the kernel does support this old of a toolchain
> > (or at least the 10.x? someone else this on).
>=20
> Hi Tom,
>=20
> Actually I am not sure u-boot itself have minimum requirement on each tag
> or branch listed?

We do not currently have a test for anything other than "newer than
gcc-6" for ARM, but should have the same minimum requirements as the
linux kernel, but are lacking enforcement checks (but I also think the
kernel is?).

--=20
Tom

--LI8Tv7uzOoRMmBDm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3F0gAKCRAr4qD1Cr/k
CgLmAQCr+gl4/peHo56vWxJE8flR7QuNKAUQojnwh5kyLlPd1AEAxeZmEVgkwabI
la6BF901YGBCNpy2sA3lP/a4iDHFow0=
=PHmY
-----END PGP SIGNATURE-----

--LI8Tv7uzOoRMmBDm--
