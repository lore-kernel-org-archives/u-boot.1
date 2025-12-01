Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAC0D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EBAE83C61;
	Mon,  1 Dec 2025 17:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BzHfreZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D06C583C62; Mon,  1 Dec 2025 17:54:28 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D02B83BF4
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30cce892b7dso2134883fac.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764608065; x=1765212865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TLhD5LbpLEiPeueNhHiZhtWWNLJSEwpJkxQISR3z5dg=;
 b=BzHfreZ6csNfchoswNkH9kUojLK8lEjdo3sKCmsys3vBitfY8YWflDUBfEwk7LpCmN
 O/bNA7zZ+sltuQ35gCPVBFs/vl0q5V2wH0g7kG52WdXJWiGgmoHgBYKshXziyAX+tGrL
 UiJb7Y+V7BVW2XUBPF/xTjHKLfNg34xrh8278=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764608065; x=1765212865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLhD5LbpLEiPeueNhHiZhtWWNLJSEwpJkxQISR3z5dg=;
 b=qShKZQIHRLPqDqqmlpoRaPNpq6tlVS29qLV9Tn1DHurdb2NqnkqoUomNnjvEMgXsWG
 eMfbuw3u6tVvaKEutbIHnguuMey8qBi2bU7GS7iN8wcTK/9JeXQc1YLvuhjL/s51+aBB
 vXhnlWC8LOEO7ievwTc9Q+lmcljMMCYqkxl4Cx9JTX5zSeGmoA66P2f29THT0pGc8meB
 69c+Nx+neljSnZOIGU6aNY+1ZwVAQITRB1lGiPxR4t8B626RkAogxndJRx5IjwgDHnZV
 npi4DZo7nzloKrWddvsh2MGr4YBT3hMeSoueCql6XqzQvnpY2Hnn8bGU6E1DqfsnSJSP
 5RDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfAoRLrWkHdTnHjhvATeUJxUUInVQBVw05g/SS3aBTg00GU02ud7yqKPhj1KeM2aZngJ4dP4U=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7LcO9j2PXKdetoAiOWh2CPgt1SOIcGAD9l+7E9IyFgTV7oT1M
 PI93bHTNb/KMfbt3Tp7hXPsMguMf6qI/7+HmCSLUd2tUkuPPHb9i/ZpFaqxqFvfA87E=
X-Gm-Gg: ASbGncv4k+6LMg1Ovb2c+W8r/+WWfqjAwL5QIL7FKuFwam20oQtk7WSKUOFohW9jPw+
 OUD0W4H2+g0lfXpRgm167UlPPy4T+tyEeBKQE2KGm3gb7uwlYgsRSow/+rJ5I7lfOVAd6U2Rqn2
 eJtUbmBaD/YQFwxR/s9l+uS8DSq1KH4APHx3MSVen+bF3AgQ4q/oPwRLPouxF/JdQJU5WyM0RH0
 Jgc26jMchQzL5oN2Ubc6F1ThxB0G8Wt4PGPYaR9cbC4ncWawpkT07XfAnJcLHNRX6zbDZTXXC9G
 2uahsEkLHcZc4UZSWSJ4HeIDJaXciMwcY+m5PYcwWRmuo9C+L2SbtCI9V8fNNMdwZgq9OXAK8sq
 BPpxyFfozm5qx4QRCc/+2kSaIDy84Ee/YYnzS5EQqzK+AYb6qTqYl3poLLGi6pn5b2rBfxon+9Z
 lckns5/HnuP2L05FHSO8dYjxrDi+Nah8vgdpJe5zalIN/uLEfZ2HvUiHxdAo5S
X-Google-Smtp-Source: AGHT+IHbXbef0NX+nBzRFrz2+97tlAceegCzKjUlIapDVz55loftJOBJjU27tsNmVv2Axot2iDZwog==
X-Received: by 2002:a05:6871:4083:b0:3ec:4f18:9c79 with SMTP id
 586e51a60fabf-3ecbe244ad7mr19711315fac.13.1764608065259; 
 Mon, 01 Dec 2025 08:54:25 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05bc9asm5470281fac.22.2025.12.01.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:54:24 -0800 (PST)
Date: Mon, 1 Dec 2025 10:54:22 -0600
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
Message-ID: <20251201165422.GI303283@bill-the-cat>
References: <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
 <20251201164405.GG303283@bill-the-cat>
 <CAN7C2SBPwcPdUQeufJ+c3XxVKVmU4PE7nbYqLaNy9ynqkWhJgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KhD2ILSrnpwj0zYk"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBPwcPdUQeufJ+c3XxVKVmU4PE7nbYqLaNy9ynqkWhJgA@mail.gmail.com>
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


--KhD2ILSrnpwj0zYk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 12:52:06AM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Sat, Nov 29, 2025 at 08:46:14AM +0800, Sune Brian wrote:
> > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=8829=E6=
=97=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas wrote:
> > > > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zakuan=
 wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > > > [CAUTION: This email is from outside your organization. Unl=
ess you trust
> > > > > > > > the sender, do not click on links or open attachments as it=
 may be a
> > > > > > > > fraudulent email attempting to steal your information and/o=
r compromise
> > > > > > > > your computer.]
> > > > > > > >
> > > > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > > > > >
> > > > > > > > Hello everyone,
> > > > > > > >
> > > > > > > > > I already have the referenced commit in my test branch, a=
nd I can
> > > > > > > > > confirm that the same compilation error still appears on =
CycloneV when
> > > > > > > > > certain directories produce no SPL objects.
> > > > > > > > >
> > > > > > > > > The existing fix ensures that built-in.o is always presen=
t, but it does
> > > > > > > > > not prevent ar from generating empty built-in.a archives,=
 which older
> > > > > > > > > ARM 32-bit linkers (such as CycloneV toolchains) reject a=
s =E2=80=9Cfile
> > > > > > > > > truncated=E2=80=9D.
> > > > > > > >
> > > > > > > > Which toolchain is this ?
> > > > > > > >
> > > > > > >
> > > > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile ou=
r SoC32 devices
> > > > > > > - CycloneV and Arria10
> > > > > >
> > > > > > Ilias, do you recall the solution to this problem from when it =
came up
> > > > > > on IRC a few weeks ago?
> > > > >
> > > > > Nop unfortunately not.
> > > > > Was this caused by the Kbuild bump? I remember the logic around
> > > > > builtin changing significantly.
> > > >
> > > > Yes, and I kinda thought we narrowed it down to something being mis=
sing
> > > > from the update, since the kernel does support this old of a toolch=
ain
> > > > (or at least the 10.x? someone else this on).
> > >
> > > Hi Tom,
> > >
> > > Actually I am not sure u-boot itself have minimum requirement on each=
 tag
> > > or branch listed?
> >
> > We do not currently have a test for anything other than "newer than
> > gcc-6" for ARM, but should have the same minimum requirements as the
> > linux kernel, but are lacking enforcement checks (but I also think the
> > kernel is?).
> >
> > --
> > Tom
>=20
> Hi Tom,
>=20
> Oops, missing the kernel version. Add it back for better debug.

Sorry, what I meant was that it's a kbuild related issue as to what
version of gcc can be used. We don't have a check, and should, but also
the versions in question here should be expected to work. There's just
some change we're missing.

--=20
Tom

--KhD2ILSrnpwj0zYk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3IPgAKCRAr4qD1Cr/k
Cm/eAQDFemi8oVCpCp6q4NqdHnKfqFy+JfnPT4svO2O39UGU6QD9E0vf4ukKoh2G
qc5yhWvluJmwJY84g0fgjXDX1X2CLwc=
=V7bb
-----END PGP SIGNATURE-----

--KhD2ILSrnpwj0zYk--
