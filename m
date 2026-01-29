Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969F4D6B084
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D43A83FED;
	Thu, 29 Jan 2026 17:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W2ohPryv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C6183FFA; Thu, 29 Jan 2026 17:03:23 +0100 (CET)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A0D83E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-662f485e58aso615116eaf.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769702599; x=1770307399; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6regyhzQok3Z3+oqcyLxwmnuvDyQ/2ZG0yGIeI6Qp8Q=;
 b=W2ohPryvBAR2NRtCRFlemW59zCmIlxigVqxam+JAL9tCvDzi7bLNgMScP7lKcMV7jT
 3DUP/8AFv8ehcafoOG0dCjw7YxDGTLvzW3CN+HtJkPV7AaKY/Z3VpgQfp+UZHfVx9BQb
 MrnSnKRaEgUZxv1Lrp0TXlrPXiMtFkX8osVHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702599; x=1770307399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6regyhzQok3Z3+oqcyLxwmnuvDyQ/2ZG0yGIeI6Qp8Q=;
 b=qbmok8PPTd6lKfs86IxV2YxVy6R2vEEXrZ6ILzapP3f8IhPHX9Cj9WD9nhkPmjQ9LO
 m4wlcTXKWi1H3stfVci/2WbMGMN7POGX/8ZfQLvGuFVuCpWiX3Iw9cONXSJhkxIDJt9u
 fqBaYMwlMQJ5x6h2XUqr4Fvwm65dVGS9ppCWrNBpiTZMV1LCThtpoNgCkzGRNVqEvVlY
 tlRQ0uqW1AJyPT2GEaNsslK3YXZegvaufsGJDx5UdDBG1XMz4hdYKeUx5Qrg3cxx4k//
 1mCV5jwprPo0IIBJ4mO5YtCUtfL8AtQSgqHFUUGwMOMLutEXtu84NNY4+F3k6v6Fq30Q
 LhVA==
X-Gm-Message-State: AOJu0Yz8jcvz5Su302HpBx73ooxMIprnNGdS+7a/c4a8loXbhaHJ/u8R
 MgT23fdLlSgdTUD0dU/0+WPsNoIxnl9CFYL+UaKseq8dRAwlkDPWKWEynfjkrfCMZ2P+J67D0fE
 sm4gxNBA=
X-Gm-Gg: AZuq6aJdhyNwlUFAe8+oWzm7GcbqoRyU3ks9qZzjuwoxAOjxt3CliHvM9gcLroPnbQd
 i1HpzbrQNIUXqyVs3UhgKiZkKlY1pcoH8ukh4TZe1/iXVHv2upsSR9l7oG9Y112RXaf26PqCcnW
 744RbGt/I3NoKm2EoIyOgoisNxuuE499kxsgUFed+iUwz2yMyy885YdSwPkGf4/2JEard9eDsaN
 awFTA8jzG3O3+dX83wL2L2HJo+zwLfrD3wKNLMjjpeHEs4N3oumZhvZhLRcW3in9BzwvygKoEn1
 87y3waH5s0f8iuNsCSKmgjrOFxso1XqlvG+g51fLA1DSX/aAREkiSUGpoePLO5Nu6aSqXLlsmwK
 by90L++091nsB1n9em4zcQbxeXpwqPXEoInEjQdBBFcCDh4tbaO+QzPGvPi/XrhUstdLrlzfGrA
 tLmqiRd9k/Ze2coRSX2nE/d81SKvdPH0aKuwahpoPPDaDKRVr3jonRGdtBmF4AgGvBD2nlZIlvX
 t/VZHMSgZ7JH2ueqQ8Ce2Uz27zDrkQSgdZaAfM=
X-Received: by 2002:a05:6820:c83:b0:662:f997:8445 with SMTP id
 006d021491bc7-662f9978a82mr3920058eaf.78.1769702598512; 
 Thu, 29 Jan 2026 08:03:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f9a18776sm3346771eaf.12.2026.01.29.08.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:03:17 -0800 (PST)
Date: Thu, 29 Jan 2026 10:03:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129160315.GZ3416603@bill-the-cat>
References: <20260129145416.GR3416603@bill-the-cat>
 <CAN7C2SC05Gv_WKmNA-3JpEzPUBW27KuZrMOgXdMeL1vQXS_v1Q@mail.gmail.com>
 <20260129151919.GU3416603@bill-the-cat>
 <CAN7C2SBMTxqeN45RiAuz4oW9bKVUYDgJzmHH+eM0pNN3X6QpHw@mail.gmail.com>
 <20260129152644.GW3416603@bill-the-cat>
 <CAN7C2SA85pMyF_Mn4YrwQnaLD4Ks8y3Zr3RGn1hkEds6nM1SYg@mail.gmail.com>
 <20260129153407.GX3416603@bill-the-cat>
 <CAN7C2SCV499EAw4f__HEefgh71NfEckd9PQ_G-ZHtDTQbjoRTw@mail.gmail.com>
 <20260129154646.GY3416603@bill-the-cat>
 <CAN7C2SDFkeg8Q=SFjRBBx4LctMPOvj8U0+TdmxfEuvHNp5w5BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X06ffavrbGAZd9XI"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDFkeg8Q=SFjRBBx4LctMPOvj8U0+TdmxfEuvHNp5w5BQ@mail.gmail.com>
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


--X06ffavrbGAZd9XI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wrote:
> On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wrote:
> > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wrote:
> > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wrote:
> > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wrote:
> > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trini@=
konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wr=
ote:
> > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <tr=
ini@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Bria=
n wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > The commits after c08da5d03c2a0b72e81a11ff7ca507e=
3a6414db3
> > > > > > > > > > > > > All Cyclone V boards are unable to boot, not sure=
 this patch is the fix?
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > > Yes, those commits were unintentional and have been=
 reverted.
> > > > > > > > > > >
> > > > > > > > > > > Had tested the last commit 6a1bdb7e952d5841f42742fefa=
907cae5dc8d50a
> > > > > > > > > > > Same situation that the boards are unable to enter th=
e SPL phase.
> > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec w=
orks properly.
> > > > > > > > > > > After that things are broken.
> > > > > > > > > >
> > > > > > > > > > Please give
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202601=
29035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > a try as I think it might have been working before by a=
lignment luck
> > > > > > > > > > rather than design.
> > > > > > > > >
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > It is the revert itself that is broken.
> > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 2026=
 - 22:56:17 +0800)
> > > > > > > > > Trying to boot from MMC1
> > > > > > > > >
> > > > > > > > > Which revert is correct.
> > > > > > > > >
> > > > > > > > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > > >
> > > > > > > > > Then all these broken I don't understand why even file di=
ff cannot
> > > > > > > > > show any changes.
> > > > > > > > >
> > > > > > > > > Do you mean the revert is broken and fixed by alignment?
> > > > > > > >
> > > > > > > > I mean that arbitrary changes (as part of testing these thi=
ngs, the
> > > > > > > > "-dirty" in the version string would lead to failing trees =
now passing)
> > > > > > > > can make the difference between pass/fail to boot. Did you =
try Marek's
> > > > > > > > patch I linked to?
> > > > > > >
> > > > > > > Yes, I had tried. Cannot boot same as I had mentioned failing=
 commit #.
> > > > > > > I apply that patch on the latest master commit.
> > > > > >
> > > > > > The other, maybe, thing is you need a bigger SPL_SYS_MALLOC_F_L=
EN ?
> > > > > > Otherwise, you'll need to dig more and see why the device tree =
isn't
> > > > > > being found where expected on your platform, and possibly where=
 it is
> > > > > > instead.
> > > > >
> > > > > No the failing point is done after
> > > > >
> > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > Revert "arm: spl: Correct alignment of .rel.dyn section"
> > > > > This reverts commit 380ddb4. Signed-off-by: Tom Rini <trini@konsu=
lko.com>
> > > > >
> > > > > This commit I tried to boot and works..
> > > > >
> > > > > Then this commit
> > > > >
> > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > count rel_dyn
> > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > >
> > > > > I manually replaced the old Makefile.xpl and also worked it boot.
> > > > >
> > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > >
> > > > > Revert a number of incorrect commits
> > > > > As part of debugging the appended device tree failure, I inadvert=
ently
> > > > > committed some changes as I was debugging to master, and not a pr=
ivate
> > > > > branch, and pushed them as part of the release. This reverts comm=
it
> > > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini@konsulko.=
com>
> > > > >
> > > > > This is the point that everything no longer boots.
> > > > >
> > > > > But between those commits there are no extra codes.
> > > > >
> > > > > After that all things no longer work.
> > > >
> > > > Yes, and I need you to investigate your failure case here. There is=
 no
> > > > code change between a working commit and a failing commit, which le=
ads
> > > > me to the suggestions I gave for debugging.
> > >
> > > I even tried a fresh clone from https://github.com/u-boot/u-boot.
> > > Same situation.
> > > I don't understand.
> > > The commit missed or messed up?
> >
> > You need to look at the resulting binaries and see why the device tree
> > is not where it's expected to be.
> >
> > You might find it helpful looking through
> > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPX=
xKa8D3Cny5Q@mail.gmail.com/
> > for some ideas.
>=20
> So you are suggesting even the commit between revert could introduce this=
 issue?
> Aren't the revert only applied to two changes?

What I'm saying is that the underlying issue is that the device tree is
not where it's expected to be. The likely root cause is that we now
require the device tree to be (correctly!) 8 byte aligned in memory and
not 4 byte aligned. In the case of appending a device tree to our binary
any sort of change in the code can change the size of the binary and in
turn mean that the address where the device tree is ends up being at a
different alignment.

--=20
Tom

--X06ffavrbGAZd9XI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXuEsAAKCRAr4qD1Cr/k
Cp9IAP9BB315nL+uRstBE1xAK6J/PfHDzOzwz3YgS6PhL4RvzwD/WBXtsOVbTrJz
7+wrwLX9iJfjnCivcYc1UNc3fSIglQ4=
=ftVM
-----END PGP SIGNATURE-----

--X06ffavrbGAZd9XI--
