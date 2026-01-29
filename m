Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B023BD6B087
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEDF8401A;
	Thu, 29 Jan 2026 17:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jzagJdr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D493084020; Thu, 29 Jan 2026 17:22:32 +0100 (CET)
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8C983E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-66307e10d1dso514898eaf.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769703749; x=1770308549; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0Z47N5v69pGWV08NqTBdBHWd1UC/l+CdQXONyxoGNAI=;
 b=jzagJdr3IoWuSqFhl2YIu681MsFzvy7MjYHr0YTXrKI4csriSMVCE/GG3M1/7QFmYb
 uLp/NLsa5GcrhWoJGH2qPy5DkDu0ZIUreBptHB2EWBbdhZEpz9IctGT/JbUS4uTm7Awl
 1Rn09LRV/K0+FPrCtL3+ed5gOxDw8xxooqyKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703749; x=1770308549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Z47N5v69pGWV08NqTBdBHWd1UC/l+CdQXONyxoGNAI=;
 b=NuGBCY5MqrH/FKSpZeIZuJ1GHBHRY8J7Og5A3C1VtubzabGkuycruk6Rw8KvgWWRiu
 RyEMsWrI+F0+joh5obVowlpNLt5OcT/hpN2kobdkMzC3Nw261ENxFAam7ItGJ03Wfs/e
 nUs+av+tKJjOyxEvrt79ErVFGH3VirN1r51sA/SaTn/UdxutAxnZ32sAeoLbqQBAjTKB
 0RObIPYuCks9+XPWwPbbEltcRwgzuxrXTk75yayR6/DEvWLaCBW7QNht2+rFspQ6Wthb
 kXDfi4+4G/kUJo4zvylI4JJrW5cLT0dDJ1H6ZWjvpIyK+keuYsZsHX8ltt0wDjEc7x/l
 nZeA==
X-Gm-Message-State: AOJu0YxCsJSc/JlxmVKaVwe+bQyICs5aNn64dhf1X7lf3dCyAcTsuyJJ
 MdgaCI97dyrXEPFJo5uyASo+ITrCKKJAGX6XimMQaBt5YCLlma//RUGAlrNnvy5aYM4dH0aKn6p
 UmYFvjCY=
X-Gm-Gg: AZuq6aIZnqMfCrKyc36ZzpCzJdH8ncGbkgHby9LDKavJGccg9LfyVp+6d1Er/AmxnKc
 /X1PfuW5czazXuZEKYBjMUms0Iw5fAspafa4W7iC5WYd/TyGNrQVt5RoaSZJUtlsMTPF8K2M2sO
 PCadgQdJ+GGeUHTGSN46FMwrPFRToZL4Bio631O76Uaz3/Cu1VbDMUXFHcJwafxTdqSEGN8L+lk
 N7im+/AVPIE/cyaFB7FjCW3PDzvVxEJGckXcMLpMX2ao7dMAJ3Lp8QK/xoyBiV5xG8eUC7HAJ0k
 jJhIxfm3wClsRBpCjD3QZ4vPizhgcBCA3kTTu/t5JhpXT3TZaU3D2arx07LInEovTy711/gJ9vj
 uewf7iQ6dZuunh2X2kQrTX8LX52OIvLSQtD62T7cA8hy4JwITq1jcNGay5ysDTP42ddaS26we7t
 S58+L93LNYHMuI2HqVxO9Y0G8Z0v8s9oTrHJqdj002W5a41uhIA6/Q9XVcyF1D7kJ524Nr1Dd8X
 ooJO5HBeedCXuB1oFTNLW/w+ffmTmPpxDnlIPnHDGCojKAWrQ==
X-Received: by 2002:a05:6820:3098:b0:662:f6c8:c2b0 with SMTP id
 006d021491bc7-6630f3ab81emr9429eaf.58.1769703748787; 
 Thu, 29 Jan 2026 08:22:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f9a19cb4sm3340973eaf.9.2026.01.29.08.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:22:28 -0800 (PST)
Date: Thu, 29 Jan 2026 10:22:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129162226.GB3416603@bill-the-cat>
References: <20260129152644.GW3416603@bill-the-cat>
 <CAN7C2SA85pMyF_Mn4YrwQnaLD4Ks8y3Zr3RGn1hkEds6nM1SYg@mail.gmail.com>
 <20260129153407.GX3416603@bill-the-cat>
 <CAN7C2SCV499EAw4f__HEefgh71NfEckd9PQ_G-ZHtDTQbjoRTw@mail.gmail.com>
 <20260129154646.GY3416603@bill-the-cat>
 <CAN7C2SDFkeg8Q=SFjRBBx4LctMPOvj8U0+TdmxfEuvHNp5w5BQ@mail.gmail.com>
 <20260129160315.GZ3416603@bill-the-cat>
 <CAN7C2SDZ9fO-BsjcRj638LtR5QYWUt+PjOyXvao9aXS+J9Pnzw@mail.gmail.com>
 <20260129160830.GA3416603@bill-the-cat>
 <CAN7C2SB0+kNYjho=LDKASfqddgQeCYXu0hhPeK62menTR6VW1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/1n0rZqWS2wYUZBj"
Content-Disposition: inline
In-Reply-To: <CAN7C2SB0+kNYjho=LDKASfqddgQeCYXu0hhPeK62menTR6VW1Q@mail.gmail.com>
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


--/1n0rZqWS2wYUZBj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:09:26AM +0800, Sune Brian wrote:
> On Fri, Jan 30, 2026 at 12:08=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Fri, Jan 30, 2026 at 12:07:25AM +0800, Sune Brian wrote:
> > > On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wrote:
> > > > > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wrote:
> > > > > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wrote:
> > > > > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trini@=
konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wr=
ote:
> > > > > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <tr=
ini@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Bria=
n wrote:
> > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini=
 <trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune =
Brian wrote:
> > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom =
Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, S=
une Brian wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The commits after c08da5d03c2a0b72e81a11f=
f7ca507e3a6414db3
> > > > > > > > > > > > > > > > > All Cyclone V boards are unable to boot, =
not sure this patch is the fix?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yes, those commits were unintentional and h=
ave been reverted.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Had tested the last commit 6a1bdb7e952d5841f4=
2742fefa907cae5dc8d50a
> > > > > > > > > > > > > > > Same situation that the boards are unable to =
enter the SPL phase.
> > > > > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c16=
7077ec works properly.
> > > > > > > > > > > > > > > After that things are broken.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Please give
> > > > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patc=
h/20260129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > > > > a try as I think it might have been working bef=
ore by alignment luck
> > > > > > > > > > > > > > rather than design.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > It is the revert itself that is broken.
> > > > > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan=
 29 2026 - 22:56:17 +0800)
> > > > > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > > > > >
> > > > > > > > > > > > > Which revert is correct.
> > > > > > > > > > > > >
> > > > > > > > > > > > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > > > > And revert to 431f1ce46bbffff0db8f03437a34400b11b=
30175
> > > > > > > > > > > > >
> > > > > > > > > > > > > Then all these broken I don't understand why even=
 file diff cannot
> > > > > > > > > > > > > show any changes.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Do you mean the revert is broken and fixed by ali=
gnment?
> > > > > > > > > > > >
> > > > > > > > > > > > I mean that arbitrary changes (as part of testing t=
hese things, the
> > > > > > > > > > > > "-dirty" in the version string would lead to failin=
g trees now passing)
> > > > > > > > > > > > can make the difference between pass/fail to boot. =
Did you try Marek's
> > > > > > > > > > > > patch I linked to?
> > > > > > > > > > >
> > > > > > > > > > > Yes, I had tried. Cannot boot same as I had mentioned=
 failing commit #.
> > > > > > > > > > > I apply that patch on the latest master commit.
> > > > > > > > > >
> > > > > > > > > > The other, maybe, thing is you need a bigger SPL_SYS_MA=
LLOC_F_LEN ?
> > > > > > > > > > Otherwise, you'll need to dig more and see why the devi=
ce tree isn't
> > > > > > > > > > being found where expected on your platform, and possib=
ly where it is
> > > > > > > > > > instead.
> > > > > > > > >
> > > > > > > > > No the failing point is done after
> > > > > > > > >
> > > > > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > Revert "arm: spl: Correct alignment of .rel.dyn section"
> > > > > > > > > This reverts commit 380ddb4. Signed-off-by: Tom Rini <tri=
ni@konsulko.com>
> > > > > > > > >
> > > > > > > > > This commit I tried to boot and works..
> > > > > > > > >
> > > > > > > > > Then this commit
> > > > > > > > >
> > > > > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > count rel_dyn
> > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > >
> > > > > > > > > I manually replaced the old Makefile.xpl and also worked =
it boot.
> > > > > > > > >
> > > > > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > > >
> > > > > > > > > Revert a number of incorrect commits
> > > > > > > > > As part of debugging the appended device tree failure, I =
inadvertently
> > > > > > > > > committed some changes as I was debugging to master, and =
not a private
> > > > > > > > > branch, and pushed them as part of the release. This reve=
rts commit
> > > > > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini@k=
onsulko.com>
> > > > > > > > >
> > > > > > > > > This is the point that everything no longer boots.
> > > > > > > > >
> > > > > > > > > But between those commits there are no extra codes.
> > > > > > > > >
> > > > > > > > > After that all things no longer work.
> > > > > > > >
> > > > > > > > Yes, and I need you to investigate your failure case here. =
There is no
> > > > > > > > code change between a working commit and a failing commit, =
which leads
> > > > > > > > me to the suggestions I gave for debugging.
> > > > > > >
> > > > > > > I even tried a fresh clone from https://github.com/u-boot/u-b=
oot.
> > > > > > > Same situation.
> > > > > > > I don't understand.
> > > > > > > The commit missed or messed up?
> > > > > >
> > > > > > You need to look at the resulting binaries and see why the devi=
ce tree
> > > > > > is not where it's expected to be.
> > > > > >
> > > > > > You might find it helpful looking through
> > > > > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05F=
KjbqVKPXxKa8D3Cny5Q@mail.gmail.com/
> > > > > > for some ideas.
> > > > >
> > > > > So you are suggesting even the commit between revert could introd=
uce this issue?
> > > > > Aren't the revert only applied to two changes?
> > > >
> > > > What I'm saying is that the underlying issue is that the device tre=
e is
> > > > not where it's expected to be. The likely root cause is that we now
> > > > require the device tree to be (correctly!) 8 byte aligned in memory=
 and
> > > > not 4 byte aligned. In the case of appending a device tree to our b=
inary
> > > > any sort of change in the code can change the size of the binary an=
d in
> > > > turn mean that the address where the device tree is ends up being a=
t a
> > > > different alignment.
> > >
> > > You are correct on this, but I don't understand why even reverting to
> > > two code changes
> > > could introduce this issue.
> > >
> > > The revert also included other commits?
> > >
> > > "
> > > Revert a number of incorrect commits
> > > As part of debugging the appended device tree failure, I inadvertently
> > > committed some changes as I was debugging to master, and not a private
> > > branch, and pushed them as part of the release. This reverts commit
> > > dc2d842 through 380ddb4.
> > > "
> > >
> > > This is my debug case:
> > >
> > > Correct boot:
> > > hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
> > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...=
pG......|
> > > 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |........=
=2E.......|
> > >
> > > Fail boot:
> > > hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...=
pG......|
> > > 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |........=
=2E.......|
> >
> > Yup, so it's mis-aligned. I guess can you tell me what the defconfig
> > you're using is?
>=20
> socfpga_cyclone5_defconfig

You might need to do some debugging yourself on this. Is that also where
__bss_end is? This looks like the exact case that
5ffc1dcc26d3df9e2b192151936cb98014fb6e49 should have fixed. And locally,
I see it being aligned, and then also just making a trival change (git
tree is dirty) that used to lead to mis-alignment, retaining alignment.

--=20
Tom

--/1n0rZqWS2wYUZBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXuJOgAKCRAr4qD1Cr/k
ClygAP97KD5wQmVdGSR5sNIqQMeEr8p7xsFoY2Q+ReQQDpGgogD+PsbOXrhw5HEM
4rfQcyaQ3xLHQqF6OMmcIL4TeNAj2Qc=
=v7NV
-----END PGP SIGNATURE-----

--/1n0rZqWS2wYUZBj--
