Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB8D6B084
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8F683FED;
	Thu, 29 Jan 2026 17:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="emq5n74A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8534884010; Thu, 29 Jan 2026 17:08:40 +0100 (CET)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18F883E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-4042905015cso713280fac.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769702916; x=1770307716; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pY6XU9+eeXDN5c72gDrm9eAAvGL4H6i13DorysDzmFY=;
 b=emq5n74AKNkqRhUIEROmbb8mDDtKXHqVxp8Eh6hJvuAby5a3MkGvQRDk6atOUdo2O1
 ZZp2Etxj8Yw+PzTMV0Q019gimSnn+Kr9KJ4v+RDjYQCghOcxHCYqLXFCkBfA1E26cDG2
 k5eeU1iBzviskvc7QAGCGql9eXa2oF7VFtpcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702916; x=1770307716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pY6XU9+eeXDN5c72gDrm9eAAvGL4H6i13DorysDzmFY=;
 b=vi60qFHGk/VRJFAm8HahTA1WZu7RCu1EqsOHVDyJUKxk1omEA+PRd+lCwnODSv58Ms
 N4XvRTPuTc4bPQXVA7A5LMfForhCxmN01rJo4SctrNM6WUjGsIDuUXM8PLg8p79i/ZZt
 mY7WHUeE6iRMgcJsYs7bx8YjYP6NdAce9v1RP93TdFJHwkaujWdzhOE4A1EeY3OlPGv4
 bLCDkofacRzfbOo2ude+SnJQ92DiKJwKnZ8x1azrQWyO3YWHnTE0Z99NsprF/pSG/lLZ
 s0/fzbms2yMUy2GbsCUlLnHTxaK4B9G+Bvv2a8jINQ+IA9YQaFu3V0Mr03DZRWE3vYFt
 tahA==
X-Gm-Message-State: AOJu0YxllrlfDRCBPHTLKCskqBM4V/V9aHL/jxs4vd1XwRqcHaU2/bDR
 2/0WV48OYe3SQJkwgKcOuFkLIuy+SkCx32W0EZPtlsoDWZUKjpETAc818MbWUVmMBaQxMfOt9hX
 DXroxH90=
X-Gm-Gg: AZuq6aJIsDGDQT+fljnYKjKwLWAv62ASNGaHj5pbJbLHelTRNPjOgfSCkOQrQcxtvEL
 qSjqJeNxK19fEsCVRp5IREwyZjfNxpeqqpG2POiOOFMIceQ5WVqDUikpzZTI1YvsZbSeY4nSrsY
 2lf2k716GP0hj0zyJaNhu7dwY/uaGPTXsDvx+4SqvjNk5tpuYKzZZ3SIHgm2yotx/5eF6/oWYvN
 zcKc5PBR96u70DVdRfZkR/3qPLSMi+zARBHEa3L+NHmJlZzMtfCoM+cOESEQuiRUZG6i0jx5KWA
 ksHVSfqek3lffzJnivnrIsJTGI5j4OV/nmUHdsdNNPIzdzvWCNkgpf5AoFIvhYEkzNp/49B5UL3
 w4otlMIBpbJ0Xarv4Mnrp9L2akgzXKigwLO86CUt1KvlPQkuTLd0k7nkbNPNs03ABcq0j0QLLxj
 C+E1JWnIxMwwtiPEID1MnE145Lw6d6djg6ZB2a8B4TxTQrKt/qizfxKwCQyzbl1j5+FdP/Uj79r
 IsVDVRw8MOwIdviIFgsG9XAPr//PgRG4yXLV5Q=
X-Received: by 2002:a05:6871:5813:b0:404:3635:c885 with SMTP id
 586e51a60fabf-409a6f7ec3dmr45805fac.32.1769702913155; 
 Thu, 29 Jan 2026 08:08:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095753b347sm3665868fac.17.2026.01.29.08.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:08:32 -0800 (PST)
Date: Thu, 29 Jan 2026 10:08:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129160830.GA3416603@bill-the-cat>
References: <20260129151919.GU3416603@bill-the-cat>
 <CAN7C2SBMTxqeN45RiAuz4oW9bKVUYDgJzmHH+eM0pNN3X6QpHw@mail.gmail.com>
 <20260129152644.GW3416603@bill-the-cat>
 <CAN7C2SA85pMyF_Mn4YrwQnaLD4Ks8y3Zr3RGn1hkEds6nM1SYg@mail.gmail.com>
 <20260129153407.GX3416603@bill-the-cat>
 <CAN7C2SCV499EAw4f__HEefgh71NfEckd9PQ_G-ZHtDTQbjoRTw@mail.gmail.com>
 <20260129154646.GY3416603@bill-the-cat>
 <CAN7C2SDFkeg8Q=SFjRBBx4LctMPOvj8U0+TdmxfEuvHNp5w5BQ@mail.gmail.com>
 <20260129160315.GZ3416603@bill-the-cat>
 <CAN7C2SDZ9fO-BsjcRj638LtR5QYWUt+PjOyXvao9aXS+J9Pnzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vaVzdYkbdNrE4nEp"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDZ9fO-BsjcRj638LtR5QYWUt+PjOyXvao9aXS+J9Pnzw@mail.gmail.com>
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


--vaVzdYkbdNrE4nEp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:07:25AM +0800, Sune Brian wrote:
> On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wrote:
> > > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wrote:
> > > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wrote:
> > > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wrote:
> > > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@=
konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wr=
ote:
> > > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <tr=
ini@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Bria=
n wrote:
> > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini=
 <trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune =
Brian wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The commits after c08da5d03c2a0b72e81a11ff7ca=
507e3a6414db3
> > > > > > > > > > > > > > > All Cyclone V boards are unable to boot, not =
sure this patch is the fix?
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, those commits were unintentional and have =
been reverted.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Had tested the last commit 6a1bdb7e952d5841f42742=
fefa907cae5dc8d50a
> > > > > > > > > > > > > Same situation that the boards are unable to ente=
r the SPL phase.
> > > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077=
ec works properly.
> > > > > > > > > > > > > After that things are broken.
> > > > > > > > > > > >
> > > > > > > > > > > > Please give
> > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20=
260129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > > a try as I think it might have been working before =
by alignment luck
> > > > > > > > > > > > rather than design.
> > > > > > > > > > >
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > It is the revert itself that is broken.
> > > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 =
2026 - 22:56:17 +0800)
> > > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > > >
> > > > > > > > > > > Which revert is correct.
> > > > > > > > > > >
> > > > > > > > > > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > > And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > > > > >
> > > > > > > > > > > Then all these broken I don't understand why even fil=
e diff cannot
> > > > > > > > > > > show any changes.
> > > > > > > > > > >
> > > > > > > > > > > Do you mean the revert is broken and fixed by alignme=
nt?
> > > > > > > > > >
> > > > > > > > > > I mean that arbitrary changes (as part of testing these=
 things, the
> > > > > > > > > > "-dirty" in the version string would lead to failing tr=
ees now passing)
> > > > > > > > > > can make the difference between pass/fail to boot. Did =
you try Marek's
> > > > > > > > > > patch I linked to?
> > > > > > > > >
> > > > > > > > > Yes, I had tried. Cannot boot same as I had mentioned fai=
ling commit #.
> > > > > > > > > I apply that patch on the latest master commit.
> > > > > > > >
> > > > > > > > The other, maybe, thing is you need a bigger SPL_SYS_MALLOC=
_F_LEN ?
> > > > > > > > Otherwise, you'll need to dig more and see why the device t=
ree isn't
> > > > > > > > being found where expected on your platform, and possibly w=
here it is
> > > > > > > > instead.
> > > > > > >
> > > > > > > No the failing point is done after
> > > > > > >
> > > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > Revert "arm: spl: Correct alignment of .rel.dyn section"
> > > > > > > This reverts commit 380ddb4. Signed-off-by: Tom Rini <trini@k=
onsulko.com>
> > > > > > >
> > > > > > > This commit I tried to boot and works..
> > > > > > >
> > > > > > > Then this commit
> > > > > > >
> > > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > count rel_dyn
> > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > >
> > > > > > > I manually replaced the old Makefile.xpl and also worked it b=
oot.
> > > > > > >
> > > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > >
> > > > > > > Revert a number of incorrect commits
> > > > > > > As part of debugging the appended device tree failure, I inad=
vertently
> > > > > > > committed some changes as I was debugging to master, and not =
a private
> > > > > > > branch, and pushed them as part of the release. This reverts =
commit
> > > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini@konsu=
lko.com>
> > > > > > >
> > > > > > > This is the point that everything no longer boots.
> > > > > > >
> > > > > > > But between those commits there are no extra codes.
> > > > > > >
> > > > > > > After that all things no longer work.
> > > > > >
> > > > > > Yes, and I need you to investigate your failure case here. Ther=
e is no
> > > > > > code change between a working commit and a failing commit, whic=
h leads
> > > > > > me to the suggestions I gave for debugging.
> > > > >
> > > > > I even tried a fresh clone from https://github.com/u-boot/u-boot.
> > > > > Same situation.
> > > > > I don't understand.
> > > > > The commit missed or messed up?
> > > >
> > > > You need to look at the resulting binaries and see why the device t=
ree
> > > > is not where it's expected to be.
> > > >
> > > > You might find it helpful looking through
> > > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbq=
VKPXxKa8D3Cny5Q@mail.gmail.com/
> > > > for some ideas.
> > >
> > > So you are suggesting even the commit between revert could introduce =
this issue?
> > > Aren't the revert only applied to two changes?
> >
> > What I'm saying is that the underlying issue is that the device tree is
> > not where it's expected to be. The likely root cause is that we now
> > require the device tree to be (correctly!) 8 byte aligned in memory and
> > not 4 byte aligned. In the case of appending a device tree to our binary
> > any sort of change in the code can change the size of the binary and in
> > turn mean that the address where the device tree is ends up being at a
> > different alignment.
>=20
> You are correct on this, but I don't understand why even reverting to
> two code changes
> could introduce this issue.
>=20
> The revert also included other commits?
>=20
> "
> Revert a number of incorrect commits
> As part of debugging the appended device tree failure, I inadvertently
> committed some changes as I was debugging to master, and not a private
> branch, and pushed them as part of the release. This reverts commit
> dc2d842 through 380ddb4.
> "
>=20
> This is my debug case:
>=20
> Correct boot:
> hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
> 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG..=
=2E...|
> 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |............=
=2E...|
>=20
> Fail boot:
> hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG..=
=2E...|
> 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |............=
=2E...|

Yup, so it's mis-aligned. I guess can you tell me what the defconfig
you're using is?

--=20
Tom

--vaVzdYkbdNrE4nEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXuF/gAKCRAr4qD1Cr/k
CpSrAP4+r/c+Wb2u0MYmq1YncAFskluehcUUtHfrWN6rykZiFgD/erWrhunfHeH7
ZrwBJM9ogKiUAs9dbvzRV9yYMUV7uwQ=
=iCAA
-----END PGP SIGNATURE-----

--vaVzdYkbdNrE4nEp--
