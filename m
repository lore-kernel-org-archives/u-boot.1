Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA1D6B06C
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BED683FED;
	Thu, 29 Jan 2026 16:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IRm4rd3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1515883FEE; Thu, 29 Jan 2026 16:46:54 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9881083E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45f171cb842so731062b6e.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769701609; x=1770306409; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e7roytDeeh+F8my6MR547qmQ7GxaWeNxu4m87OgIJA0=;
 b=IRm4rd3bBlhaV6mtKhAgHufRM1ufh9QoIVtn8rUCH5UER528zzzXTBZahpS+nYHGNN
 wwYGFlRtdQS0aeIgoqvGIKdwEXFHknDFbo0yhMTsifLGDHSxhcLQ1c83N5TOGulCKAFS
 wQpTJpoUPSPkTK5Ty/wJBXZwEGEmhfbbcWcSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769701609; x=1770306409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7roytDeeh+F8my6MR547qmQ7GxaWeNxu4m87OgIJA0=;
 b=Ar7zdNlSj5HPlSwj0QJXKcCWNPCFCu6WaIpnWH2HmVHH/SsvcprEjQYU04CGCW0Aa4
 rch2whFnPfKwETcaxM80JB+ysP1lXyEZvJNL+amrlVvHnZtaQ80jYmjaj6NeEYB4djYe
 sD78v0ntLPXahTzE+obW8S1uHRiYCiSa+B9V/W8temwoR/54bwdAHRkhjf0nsfGcpUeL
 L7QtrFXfHndmkepr6O6H6EvBqbLfuZT+y9cAsA2dzcHXxsONGEMXE1vLRdGL4Z6VNtvb
 g9fPRTNUHBrdpF6yGmjao7X46RZ7oKsi4rYjJMqMGsmC9PMHIJxenKe7hiDQ0FwHARcC
 jdYQ==
X-Gm-Message-State: AOJu0Yy/cIL+yL1R31P8sBO+OFtvkMpm6B6f5wtw4dljnWaFygLU3r/G
 A/ZmZSDv3XoJYWt0peZ65PiGCaiPlBBbSz2zvUvsHRwqinfXiH4wjqbATF+JzFilR/Bps0qvXkK
 dbDQYzS4=
X-Gm-Gg: AZuq6aLv/9zLYbyMkGDDmJA5iq2tTUatxba0fz2r27zGfUhJJEvPP3K4p6t4Om9kjPs
 uNaVaATjzD+UNPT5tFUlzYwoN4/nVkW8G/WYTlEPsaRVfA7m18UEgodTpxmf11PQZXN02Ax7L1a
 DWHNNSiLRycMitHyy+vBqQcyiQ3B8LkasyT3y8LpdHM7u5UQLT7q08gIkh7kb6qc8TgDY7O9hGh
 ZbXJMZhuj3QKQkor7aC8lkf347J1RwzrCqit9umcqDrTzSXkjTlHU0HkzsL8hmtqr9SVH9/jsA3
 p3lKJfzy8IWuXnrySFy37XuZmSjDSoccgNvgEf16N6MfPMd5lpxGm5RtQZQfNejg/popJs/NDru
 JDNPKYJJF3iC9usndL+wZvScFgIAz1os1ySZfvmdZYMQozMP+E7TiLf2QhsAdNUGuRm9IWrRUJ4
 z27hLky0np+8RKcn5L2OKfZtOcbON/nPgJo7xeGKdlesAVvzLn8NXspoQGtvR631MoWfi1azIVC
 lqjCMdnBmNMBGVIghPxTqB28dhUl5uLguJpaiw=
X-Received: by 2002:a05:6808:384e:b0:45e:f062:8369 with SMTP id
 5614622812f47-45f1e2fb24cmr1583666b6e.12.1769701609287; 
 Thu, 29 Jan 2026 07:46:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f18d5ee3bsm1913654b6e.7.2026.01.29.07.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 07:46:48 -0800 (PST)
Date: Thu, 29 Jan 2026 09:46:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129154646.GY3416603@bill-the-cat>
References: <20260128145118.GJ3416603@bill-the-cat>
 <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
 <20260129145416.GR3416603@bill-the-cat>
 <CAN7C2SC05Gv_WKmNA-3JpEzPUBW27KuZrMOgXdMeL1vQXS_v1Q@mail.gmail.com>
 <20260129151919.GU3416603@bill-the-cat>
 <CAN7C2SBMTxqeN45RiAuz4oW9bKVUYDgJzmHH+eM0pNN3X6QpHw@mail.gmail.com>
 <20260129152644.GW3416603@bill-the-cat>
 <CAN7C2SA85pMyF_Mn4YrwQnaLD4Ks8y3Zr3RGn1hkEds6nM1SYg@mail.gmail.com>
 <20260129153407.GX3416603@bill-the-cat>
 <CAN7C2SCV499EAw4f__HEefgh71NfEckd9PQ_G-ZHtDTQbjoRTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c3c2nRiigHg+XDRN"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCV499EAw4f__HEefgh71NfEckd9PQ_G-ZHtDTQbjoRTw@mail.gmail.com>
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


--c3c2nRiigHg+XDRN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wrote:
> On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wrote:
> > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wrote:
> > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wrote:
> > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wrote:
> > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trini@=
konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wr=
ote:
> > > > > > > > > >
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a64=
14db3
> > > > > > > > > > > All Cyclone V boards are unable to boot, not sure thi=
s patch is the fix?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > > Yes, those commits were unintentional and have been rev=
erted.
> > > > > > > > >
> > > > > > > > > Had tested the last commit 6a1bdb7e952d5841f42742fefa907c=
ae5dc8d50a
> > > > > > > > > Same situation that the boards are unable to enter the SP=
L phase.
> > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec works=
 properly.
> > > > > > > > > After that things are broken.
> > > > > > > >
> > > > > > > > Please give
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2026012903=
5512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > a try as I think it might have been working before by align=
ment luck
> > > > > > > > rather than design.
> > > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > It is the revert itself that is broken.
> > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > >
> > > > > > >
> > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 2026 - 2=
2:56:17 +0800)
> > > > > > > Trying to boot from MMC1
> > > > > > >
> > > > > > > Which revert is correct.
> > > > > > >
> > > > > > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > >
> > > > > > > Then all these broken I don't understand why even file diff c=
annot
> > > > > > > show any changes.
> > > > > > >
> > > > > > > Do you mean the revert is broken and fixed by alignment?
> > > > > >
> > > > > > I mean that arbitrary changes (as part of testing these things,=
 the
> > > > > > "-dirty" in the version string would lead to failing trees now =
passing)
> > > > > > can make the difference between pass/fail to boot. Did you try =
Marek's
> > > > > > patch I linked to?
> > > > >
> > > > > Yes, I had tried. Cannot boot same as I had mentioned failing com=
mit #.
> > > > > I apply that patch on the latest master commit.
> > > >
> > > > The other, maybe, thing is you need a bigger SPL_SYS_MALLOC_F_LEN ?
> > > > Otherwise, you'll need to dig more and see why the device tree isn't
> > > > being found where expected on your platform, and possibly where it =
is
> > > > instead.
> > >
> > > No the failing point is done after
> > >
> > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > Revert "arm: spl: Correct alignment of .rel.dyn section"
> > > This reverts commit 380ddb4. Signed-off-by: Tom Rini <trini@konsulko.=
com>
> > >
> > > This commit I tried to boot and works..
> > >
> > > Then this commit
> > >
> > > dc2d8423b19d30472b02e02b41504226908a4291
> > > count rel_dyn
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > >
> > > I manually replaced the old Makefile.xpl and also worked it boot.
> > >
> > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > >
> > > Revert a number of incorrect commits
> > > As part of debugging the appended device tree failure, I inadvertently
> > > committed some changes as I was debugging to master, and not a private
> > > branch, and pushed them as part of the release. This reverts commit
> > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini@konsulko.com>
> > >
> > > This is the point that everything no longer boots.
> > >
> > > But between those commits there are no extra codes.
> > >
> > > After that all things no longer work.
> >
> > Yes, and I need you to investigate your failure case here. There is no
> > code change between a working commit and a failing commit, which leads
> > me to the suggestions I gave for debugging.
>=20
> I even tried a fresh clone from https://github.com/u-boot/u-boot.
> Same situation.
> I don't understand.
> The commit missed or messed up?

You need to look at the resulting binaries and see why the device tree
is not where it's expected to be.

You might find it helpful looking through
https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPXxKa8=
D3Cny5Q@mail.gmail.com/
for some ideas.

--=20
Tom

--c3c2nRiigHg+XDRN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXuA4wAKCRAr4qD1Cr/k
Cu6RAQDh9T2qPhy31BkJwgFcMmCcK3n1GEop/PLZsJz4zs36aQEApp5Dqdtd7Xcd
yyJOTpkRMja+OIzgW0YLmdu+JHkGrwI=
=JZvh
-----END PGP SIGNATURE-----

--c3c2nRiigHg+XDRN--
