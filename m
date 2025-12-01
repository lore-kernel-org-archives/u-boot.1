Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB218D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC9283D18;
	Mon,  1 Dec 2025 19:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fStekWna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6A083D4A; Mon,  1 Dec 2025 19:38:44 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B78B83D17
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-450b2715b6cso2217241b6e.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764614320; x=1765219120; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JPzLYLIUK19DT7SLjP0vGFV4icYFc9mNHl0VEBxq3fo=;
 b=fStekWna5rqBrEYTYVx9Ib8Wkq3MOS2ds5jZSuFrG0ZHkAbd4WhXivy10mjzx8Nndj
 drNGuhJU6pI+xEHTS2Cs4nTxQRWmz+AHrsA4oHM9QeugQBQsIyP6EvB8dRqPJ/+XBJCM
 m1pXAPurkMw/SfH8U2bSmHM0X0Ne+m9uAlYGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764614320; x=1765219120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPzLYLIUK19DT7SLjP0vGFV4icYFc9mNHl0VEBxq3fo=;
 b=TnKFqnBBQAk/b9Kb5u57ssRqAbOYHBMm6/kkRyvE1ZqGYA00jqPvMPvNjlgyFKNqvh
 Uco9Ns3fSlGjdwhYeO/jGSuwFR5WreA1mgXLwbz0UJGqF1CgIWcQtCmgN0HPidUSJVIX
 OJjuRSjU99Tizqe4umxl+MJnPtdESLCE5oTqTpHSeBOp1+JQFQcfcwkMdfb4eryfzPsg
 u8uVzCXhKxRS33R6ED46Sv2g1YyOObepOPvfCPIz3xjq/mlbpQsyy5Ji10FQq8C65HAC
 gbIRhw9LWN+8YjW3SanttSAHL0/cIfwL66Y02Od1oZUFkGdoFmhP0hoxmyX0dv2hmzos
 lLhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMwz4z4UEI/xA8+zc7YzJgFWPJfhFUE8KtxUIvpZ6aIHt1+p5C7JSNr9llzrC672oqk7MSWN0=@lists.denx.de
X-Gm-Message-State: AOJu0YyAcb3Jhi9igVDJ9+eyIUY2A+neEaH7Mo2oYHRBOQUeVbaoB3Bg
 LkQov7TrXFZqKzukpevjzilH3OuOP9OxGI6/pqyacHtjpNzbcTO/DbfNIeKU5ncN6cQ=
X-Gm-Gg: ASbGnctD1PDJduvTJ9wueqc83UFDm7e02SAuH4Ka2XBYhwjQgmeJJ+GL4ZdPMtQMrM6
 EMCY3oN4ll7kyIEX+5qaG3Ef3D0wrElUnnzPKukwTg43nfQ1ljPNsjbV5qKBXrQFA0OTx8eSQiC
 6HB6vwexwjc3daGiC6KCuRXG/V3L4tbcqDKeCUOi1W8wTO1W7pCrX85XhIpVEcbmrB2hgT7BBBX
 s3J++tFRmodO1ilSNZdK2yVy27Jevv4ckYbMg3rtv/iq39AWhgzcadtib5idVFajbHLafulX5ij
 FRP2W2lrAk7PhyWcoZduaktx19r/y+BnkBqQGvOApLco/IKUWLTp6ziOuVyT7VSKUO+pILtJVjd
 6+SXn+h5eG5OQfWoVkd9eAlIHsFd96HAw1RvIGjpwok/d3ZEEF888feRilofc3otqaRh9Gqdchg
 mMmmzr6wDFTqDB2jkF51pyOQi20NI1LJIJJz92Wk8gWeCBRTmu+2OVUlh09p9z
X-Google-Smtp-Source: AGHT+IGV0doAYrX9/kchninzvk4qEcyKlJeKjegy5JLvk9lYKjgccF1XPEUJQ0QSx3NVzuo1z8J85g==
X-Received: by 2002:a05:6808:1b22:b0:44f:e376:14db with SMTP id
 5614622812f47-4514e79dfccmr10949238b6e.44.1764614320206; 
 Mon, 01 Dec 2025 10:38:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453170cefc2sm4018157b6e.18.2025.12.01.10.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 10:38:39 -0800 (PST)
Date: Mon, 1 Dec 2025 12:38:37 -0600
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
Message-ID: <20251201183837.GR303283@bill-the-cat>
References: <20251128164957.GD2125796@bill-the-cat>
 <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
 <20251201164405.GG303283@bill-the-cat>
 <CAN7C2SBPwcPdUQeufJ+c3XxVKVmU4PE7nbYqLaNy9ynqkWhJgA@mail.gmail.com>
 <20251201165422.GI303283@bill-the-cat>
 <CAN7C2SBP7_kGmuXN2J5CF97ebxSpxtmtZ81_kGPjcV=_n-FyQw@mail.gmail.com>
 <20251201170938.GL303283@bill-the-cat>
 <CAN7C2SDmv=0gubdEy_ikENQWy47UGFa9JHv+E-QZO2GCZnz_Rw@mail.gmail.com>
 <20251201182729.GP303283@bill-the-cat>
 <CAN7C2SB6SbdFgBh9FaM0EWCO-WYNgfmNjYZE+_nMp40WQfz0pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cplcifaJbpuWwXGc"
Content-Disposition: inline
In-Reply-To: <CAN7C2SB6SbdFgBh9FaM0EWCO-WYNgfmNjYZE+_nMp40WQfz0pw@mail.gmail.com>
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


--cplcifaJbpuWwXGc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 02:37:42AM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:27=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, Dec 02, 2025 at 01:59:53AM +0800, Sune Brian wrote:
> > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=
=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:09=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > >
> > > > On Tue, Dec 02, 2025 at 01:07:00AM +0800, Sune Brian wrote:
> > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=
=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:54=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > > >
> > > > > > On Tue, Dec 02, 2025 at 12:52:06AM +0800, Sune Brian wrote:
> > > > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=
=882=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > > >
> > > > > > > > On Sat, Nov 29, 2025 at 08:46:14AM +0800, Sune Brian wrote:
> > > > > > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=
=E6=9C=8829=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > > > >
> > > > > > > > > > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodi=
mas wrote:
> > > > > > > > > > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi,=
 Alif Zakuan wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > > > > > > > > > [CAUTION: This email is from outside your organ=
ization. Unless you trust
> > > > > > > > > > > > > > the sender, do not click on links or open attac=
hments as it may be a
> > > > > > > > > > > > > > fraudulent email attempting to steal your infor=
mation and/or compromise
> > > > > > > > > > > > > > your computer.]
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrot=
e:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hello everyone,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I already have the referenced commit in my te=
st branch, and I can
> > > > > > > > > > > > > > > confirm that the same compilation error still=
 appears on CycloneV when
> > > > > > > > > > > > > > > certain directories produce no SPL objects.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The existing fix ensures that built-in.o is a=
lways present, but it does
> > > > > > > > > > > > > > > not prevent ar from generating empty built-in=
=2Ea archives, which older
> > > > > > > > > > > > > > > ARM 32-bit linkers (such as CycloneV toolchai=
ns) reject as =E2=80=9Cfile
> > > > > > > > > > > > > > > truncated=E2=80=9D.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Which toolchain is this ?
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 t=
o compile our SoC32 devices
> > > > > > > > > > > > > - CycloneV and Arria10
> > > > > > > > > > > >
> > > > > > > > > > > > Ilias, do you recall the solution to this problem f=
rom when it came up
> > > > > > > > > > > > on IRC a few weeks ago?
> > > > > > > > > > >
> > > > > > > > > > > Nop unfortunately not.
> > > > > > > > > > > Was this caused by the Kbuild bump? I remember the lo=
gic around
> > > > > > > > > > > builtin changing significantly.
> > > > > > > > > >
> > > > > > > > > > Yes, and I kinda thought we narrowed it down to somethi=
ng being missing
> > > > > > > > > > from the update, since the kernel does support this old=
 of a toolchain
> > > > > > > > > > (or at least the 10.x? someone else this on).
> > > > > > > > >
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > Actually I am not sure u-boot itself have minimum require=
ment on each tag
> > > > > > > > > or branch listed?
> > > > > > > >
> > > > > > > > We do not currently have a test for anything other than "ne=
wer than
> > > > > > > > gcc-6" for ARM, but should have the same minimum requiremen=
ts as the
> > > > > > > > linux kernel, but are lacking enforcement checks (but I als=
o think the
> > > > > > > > kernel is?).
> > > > > > > >
> > > > > > > > --
> > > > > > > > Tom
> > > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > Oops, missing the kernel version. Add it back for better debu=
g.
> > > > > >
> > > > > > Sorry, what I meant was that it's a kbuild related issue as to =
what
> > > > > > version of gcc can be used. We don't have a check, and should, =
but also
> > > > > > the versions in question here should be expected to work. There=
's just
> > > > > > some change we're missing.
> > > > > >
> > > > > > --
> > > > > > Tom
> > > > >
> > > > > So long story short this patch itself should not introduce from b=
eginning.
> > > > > It is a GCC version depended issue.
> > > > > But how to pin-point down to which version is a bit hard.
> > > > > Distro link with GCC version and not all gcc version can easily c=
hecked.
> > > > >
> > > > > Any idea how to easily check this?
> > > >
> > > > We can use the check we have today in arch/arm/config.mk under
> > > > "checkgcc6" to check for something much newer. But! It's a problem =
of a
> > > > missing kbuild change I think, based on when this problem was first
> > > > reported.
> > > >
> > > > --
> > > > Tom
> > >
> > > Tom,
> > >
> > > For GCC version sub-version do not matters?
> > > For example 6.x.x 7.x.x 8.x.x
> > > Or 9.3 9.4 etc also matters?
> > > So to determine the supported version it just need to pin-point to
> > > the major GCC version?
> > > Then the possible version break only <=3D10 or <10?
> > > Based on the previous build success case.
> > > 9.2.0 fails 11.4.0 passed.
> >
> > Looking through logs now, I see the kernel says 8.1 or newer:
> > https://www.kernel.org/doc/html/latest/process/changes.html which is why
> > I have been saying there's an underlying kbuild problem (missing
> > change(s)) that needs to be resolved. I don't know if 10.x works or
> > fails, but that's still beside the point to me as 9.2.0 should work.
> >
> > --
> > Tom
>=20
> Do this apply to arm-linux-gnueabihf-gcc ?
> Or the 8.1 is apply to base gcc not cross-compile?
> Just want to confirm.

Yes, it's gcc 8.1 regardless of if it's a cross compiler or not.

--=20
Tom

--cplcifaJbpuWwXGc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3grQAKCRAr4qD1Cr/k
CusrAPjOkMaARRGLTzGc8dHxzvqBRBJ9yH80bsPxkswGhVt0AQCtE4RKkzWIwmaj
TMPCSyu/zAk9O4qnvvACUdQ/idolDQ==
=41j2
-----END PGP SIGNATURE-----

--cplcifaJbpuWwXGc--
