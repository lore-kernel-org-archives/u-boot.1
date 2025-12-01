Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FF9D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D6783981;
	Mon,  1 Dec 2025 18:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dlsyLW2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99692839A5; Mon,  1 Dec 2025 18:09:45 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61FC18006D
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e83c40e9dfso7113fac.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764608982; x=1765213782; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+/TR6a+HwTGVwDJH1zKuffK6dIeOExt9nhcFkdToX2E=;
 b=dlsyLW2V/vB9RBe3tHcgx2KdVrjagDn8YUVCR5Tx2mO+EJ9NyuuFW8pB9Giv1kuLTm
 DcBqTlQehyyXOPKhNY4XyULsKGn0h/kPYHFSPt9gh2XtMNCkTiu8ZhTAy90V56iB/cMJ
 96vTbEe+2TbnKOE3KY+xG/Fup11DUzASgisHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764608982; x=1765213782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/TR6a+HwTGVwDJH1zKuffK6dIeOExt9nhcFkdToX2E=;
 b=XFxjpjK10z3mJ+x2gdJsxmkFOY2KoULWHVCIQCN8JBXR8notbVcSG2BSjzf8fGpsDU
 RR5EHzwP1bRHA2/ZayTARKBCXfMXwk8aP1PWT3JQMTziJfysOpP85rciIVN4DfAZGoNT
 yp1DSgDCAq1BIt32r7+5pNO89fsmDMVBDjCJS2KohkEEpqe3JSFI/xhfHoXaCdj28e+Q
 gROmS1XRJ3acrZDJu3Y55Z9pCc8lHBkn2gCzMzxsjt1IQ+hwCxVd9sENfCOSpza8NoYu
 n3u1SvRNhtTRHa2zIZ6GZIQc6QRJdGnZeByHPnYpzVWiMNdtg/LNbXgn7Gl4ltyBJl0y
 XA9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUexbcxAQlTaKPKlFQ6MWcAmFbsS2qO+r8MSYJNDc1jUEabmA6CxOYff//gLuTTgOQaBlXyuHU=@lists.denx.de
X-Gm-Message-State: AOJu0YxAQXE3hw/HbaTjSgj50imqMYOyUais5nzaz5iHOFvB6xRd2ejO
 iKeinJ0Jvvelgir+rDamqAwGOUPppQapZsxoU+pmNAL6puU2wwaOD6xGZCm2t0MNtqA=
X-Gm-Gg: ASbGncuUruHDiAyDOvYw1u1oSDN1Vn0FK5d++a2qRH3WJR6Q3gUWcJwdZQiAN2KlEa0
 MGJVgSWdo5dyTXhobGP0mG023QcPP6pP2PB0JEfyI/KqJuPhu0nQ5kH6umwEmvVcbLziN450bPi
 SFTFmbF6tblHEx4f2WL/F/F3c0AQLCPg2Qt86VSt1KQhcoXWK/3PCKJmvrE4rHk2yq4e5lnvE4D
 CEoaW0Adt0pHW7dYUYTY3IOvbz2r7I8l9GWo2NM2KzDWn6iGTRA42Q1ZQQt2gq1bUmJEltSRbt1
 F2s+6plwz78FJgMz+xOlZedAmODvRdO5Y7qN7n7470BS8+EmYkZW4YgvfcR3bFNK3jrQTuU/ifS
 /Fc37GxuYZ10MG8/M4ezbiVhZvAZB5FQb0A2C6gsr1OHRfxOTko9XE3ES4KXfC2GqwFv5s3MjID
 6pVrfJXFKuZ4JVsQzFcxsnP9t245C1Tmn93o5ONqaSeNSouCMY2w==
X-Google-Smtp-Source: AGHT+IHmjg5CDWMNlRzhdXXXnkXtRI850uBbN+4iLRInNDk3Mp2UV1VmDN/MPPW+5QkA4b/s4XxSjg==
X-Received: by 2002:a05:6808:1456:b0:44f:e3d2:59e3 with SMTP id
 5614622812f47-45112bb838dmr14631572b6e.32.1764608981511; 
 Mon, 01 Dec 2025 09:09:41 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453170cd4a4sm3817569b6e.17.2025.12.01.09.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:09:40 -0800 (PST)
Date: Mon, 1 Dec 2025 11:09:38 -0600
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
Message-ID: <20251201170938.GL303283@bill-the-cat>
References: <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
 <20251201164405.GG303283@bill-the-cat>
 <CAN7C2SBPwcPdUQeufJ+c3XxVKVmU4PE7nbYqLaNy9ynqkWhJgA@mail.gmail.com>
 <20251201165422.GI303283@bill-the-cat>
 <CAN7C2SBP7_kGmuXN2J5CF97ebxSpxtmtZ81_kGPjcV=_n-FyQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="01RzOfuC8HggOVMI"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBP7_kGmuXN2J5CF97ebxSpxtmtZ81_kGPjcV=_n-FyQw@mail.gmail.com>
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


--01RzOfuC8HggOVMI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 01:07:00AM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:54=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, Dec 02, 2025 at 12:52:06AM +0800, Sune Brian wrote:
> > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=
=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > On Sat, Nov 29, 2025 at 08:46:14AM +0800, Sune Brian wrote:
> > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=882=
9=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > > >
> > > > > > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas wrot=
e:
> > > > > > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Za=
kuan wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > > > > > [CAUTION: This email is from outside your organization.=
 Unless you trust
> > > > > > > > > > the sender, do not click on links or open attachments a=
s it may be a
> > > > > > > > > > fraudulent email attempting to steal your information a=
nd/or compromise
> > > > > > > > > > your computer.]
> > > > > > > > > >
> > > > > > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > > > > > > >
> > > > > > > > > > Hello everyone,
> > > > > > > > > >
> > > > > > > > > > > I already have the referenced commit in my test branc=
h, and I can
> > > > > > > > > > > confirm that the same compilation error still appears=
 on CycloneV when
> > > > > > > > > > > certain directories produce no SPL objects.
> > > > > > > > > > >
> > > > > > > > > > > The existing fix ensures that built-in.o is always pr=
esent, but it does
> > > > > > > > > > > not prevent ar from generating empty built-in.a archi=
ves, which older
> > > > > > > > > > > ARM 32-bit linkers (such as CycloneV toolchains) reje=
ct as =E2=80=9Cfile
> > > > > > > > > > > truncated=E2=80=9D.
> > > > > > > > > >
> > > > > > > > > > Which toolchain is this ?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compil=
e our SoC32 devices
> > > > > > > > > - CycloneV and Arria10
> > > > > > > >
> > > > > > > > Ilias, do you recall the solution to this problem from when=
 it came up
> > > > > > > > on IRC a few weeks ago?
> > > > > > >
> > > > > > > Nop unfortunately not.
> > > > > > > Was this caused by the Kbuild bump? I remember the logic arou=
nd
> > > > > > > builtin changing significantly.
> > > > > >
> > > > > > Yes, and I kinda thought we narrowed it down to something being=
 missing
> > > > > > from the update, since the kernel does support this old of a to=
olchain
> > > > > > (or at least the 10.x? someone else this on).
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > Actually I am not sure u-boot itself have minimum requirement on =
each tag
> > > > > or branch listed?
> > > >
> > > > We do not currently have a test for anything other than "newer than
> > > > gcc-6" for ARM, but should have the same minimum requirements as the
> > > > linux kernel, but are lacking enforcement checks (but I also think =
the
> > > > kernel is?).
> > > >
> > > > --
> > > > Tom
> > >
> > > Hi Tom,
> > >
> > > Oops, missing the kernel version. Add it back for better debug.
> >
> > Sorry, what I meant was that it's a kbuild related issue as to what
> > version of gcc can be used. We don't have a check, and should, but also
> > the versions in question here should be expected to work. There's just
> > some change we're missing.
> >
> > --
> > Tom
>=20
> So long story short this patch itself should not introduce from beginning.
> It is a GCC version depended issue.
> But how to pin-point down to which version is a bit hard.
> Distro link with GCC version and not all gcc version can easily checked.
>=20
> Any idea how to easily check this?

We can use the check we have today in arch/arm/config.mk under
"checkgcc6" to check for something much newer. But! It's a problem of a
missing kbuild change I think, based on when this problem was first
reported.

--=20
Tom

--01RzOfuC8HggOVMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3L0gAKCRAr4qD1Cr/k
Cn/EAQCOdKEEqjSHKNMWURPj54rqqGbqq8vP3g/6d6eM+O0lJgD/U7VzffCab2FB
skmj1LGq/H9Lgn0Y4y+iOLLADm4Pog0=
=1pKj
-----END PGP SIGNATURE-----

--01RzOfuC8HggOVMI--
