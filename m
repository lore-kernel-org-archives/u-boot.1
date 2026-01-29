Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58150D358D6
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7E2D83FFF;
	Thu, 29 Jan 2026 17:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZW4IoF0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724C184047; Thu, 29 Jan 2026 17:41:37 +0100 (CET)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD7383A64
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-45c733ccc32so723503b6e.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769704893; x=1770309693; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rk63sd2Xn5LkwNUGVavozDW5elN4KgCDlX5x1dyHQ9w=;
 b=ZW4IoF0n3AXD/45XtwkslROZ4fQt914bk0fTTCOb35N3gYKyrTPFpX9c62noXABKvs
 M8UQNb2tE/i66bDEMxL4g5W3Ciqnli0tbQ41B84KoQBv2omDDVKFXrOxFVNxcvSFpAtp
 cV9rAhxsO8bmqBjcqRku52IlWdbgufsbbPtCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704893; x=1770309693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rk63sd2Xn5LkwNUGVavozDW5elN4KgCDlX5x1dyHQ9w=;
 b=O8SXmH1DOgOwNQOsbSqYmJIH7yIi4EehV4HVAgQWM49+tIVsX4pQCe2DG+V/+XHHMG
 JkRCLt1V7lX0HQunljr0mnQWML/Aqe1I8/WYACGsI4K4MUcXV5cnkmRyzCbfFdxi/f/M
 ziXXkM60tICABxEC8wI68rJChysR32E4V3YQAYhAxfM9gM/TO+thpz144xaeB0mcc5WS
 mzgVphHEewYe1A4DoF5OsOd02mD74pswKdBA6E5iYmLMXmZhIUciahb46dt4lYf5axQk
 qz0sYqithM7m5+aw4ugpIC+4xp5Oc5we5hYcA2HOjcaDdAmGSODL1htlp1Qdfgpds/Zi
 AUhg==
X-Gm-Message-State: AOJu0Yxw3Zp70T/iJ/jmATQuJRU+KIwHF0hgrMqfALsDCuY5kdh5iVNF
 z08eH7viUp6ak5hezKfhJyZH8hH9hfkTeEsvuhMPIvhnl4/2DF48+MKxlSriywoHT2I=
X-Gm-Gg: AZuq6aKF2CxO7bli58KSvcAjNTZoeyror1uaG2GkCxVwNXuf4NYvjg0ZI5sKSHkRVq0
 H3cXg49W5q3yY0tbYztZs3lkrXRvVv+996/fXkExAI7I1RytEXpxI2YBmSnuH2lqZ9gAZL2++fy
 pFYF4dr8MC3A6RBGWpdrPZvowyDgqBZGCGOtrH6pj5ZTa1SCF4aK17VCHCcXT1VgJUQhrI0fAeO
 odO076I0qiKKURAkc9AN/SJ113DHrFvp2/CIEEiyLQL/V/HEE8ann/3D1hLce56HSLrhy0HgwL5
 yNv47aPEH7/3u3ELeJkhChANcs2jNYYlouo1L9HVvO4q5KqjPrtgKyNFz/PKmPIBxigVoh+NoT0
 vXVYrv1T2VLREMSs8/uO9Ef3McXLzKMAyseXon3jP5GSKej7DUPQzsWGuwuDmx799xeJBZadz62
 YfV7Z30RxMUEKQ7KqRmX3BdDsUUcfRXp7VIDdL2nvorfEhHlDkNAiFbgIgUDXVb3BBEjoynub3t
 0BtKiPPKdXYdKY9eWZpKxdt+ZaU2AWJXgK3g5g=
X-Received: by 2002:a05:6808:c168:b0:45c:872a:57c with SMTP id
 5614622812f47-45f34d283cfmr74036b6e.57.1769704893064; 
 Thu, 29 Jan 2026 08:41:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08fb82f5sm3176711b6e.22.2026.01.29.08.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:41:32 -0800 (PST)
Date: Thu, 29 Jan 2026 10:41:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129164130.GA2044980@bill-the-cat>
References: <20260129154646.GY3416603@bill-the-cat>
 <CAN7C2SDFkeg8Q=SFjRBBx4LctMPOvj8U0+TdmxfEuvHNp5w5BQ@mail.gmail.com>
 <20260129160315.GZ3416603@bill-the-cat>
 <CAN7C2SDZ9fO-BsjcRj638LtR5QYWUt+PjOyXvao9aXS+J9Pnzw@mail.gmail.com>
 <20260129160830.GA3416603@bill-the-cat>
 <CAN7C2SB0+kNYjho=LDKASfqddgQeCYXu0hhPeK62menTR6VW1Q@mail.gmail.com>
 <20260129162226.GB3416603@bill-the-cat>
 <CAN7C2SC8ZCcD_F4W_R_Ww02px7AV4hOv1WnrOpvKoVnU14gFLA@mail.gmail.com>
 <20260129163540.GA2043007@bill-the-cat>
 <CAN7C2SBwwLrsrHgkS82oGuWZf8K1O9+UgZHOuvsco3ExCMD0Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HogtUb4ywil7mO4X"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBwwLrsrHgkS82oGuWZf8K1O9+UgZHOuvsco3ExCMD0Fw@mail.gmail.com>
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


--HogtUb4ywil7mO4X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:39:17AM +0800, Sune Brian wrote:
> On Fri, Jan 30, 2026 at 12:35=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Fri, Jan 30, 2026 at 12:29:56AM +0800, Sune Brian wrote:
> > > On Fri, Jan 30, 2026 at 12:22=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Fri, Jan 30, 2026 at 12:09:26AM +0800, Sune Brian wrote:
> > > > > On Fri, Jan 30, 2026 at 12:08=E2=80=AFAM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Fri, Jan 30, 2026 at 12:07:25AM +0800, Sune Brian wrote:
> > > > > > > On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wrote:
> > > > > > > > > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trini@=
konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wr=
ote:
> > > > > > > > > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <tr=
ini@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Bria=
n wrote:
> > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini=
 <trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune =
Brian wrote:
> > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom =
Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, S=
une Brian wrote:
> > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM =
Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +080=
0, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=
=AFPM Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM =
+0800, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > The commits after c08da5d03c2a0b7=
2e81a11ff7ca507e3a6414db3
> > > > > > > > > > > > > > > > > > > > > All Cyclone V boards are unable t=
o boot, not sure this patch is the fix?
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Yes, those commits were unintention=
al and have been reverted.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Had tested the last commit 6a1bdb7e95=
2d5841f42742fefa907cae5dc8d50a
> > > > > > > > > > > > > > > > > > > Same situation that the boards are un=
able to enter the SPL phase.
> > > > > > > > > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563=
db135c167077ec works properly.
> > > > > > > > > > > > > > > > > > > After that things are broken.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Please give
> > > > > > > > > > > > > > > > > > https://patchwork.ozlabs.org/project/ub=
oot/patch/20260129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > > > > > > > > a try as I think it might have been wor=
king before by alignment luck
> > > > > > > > > > > > > > > > > > rather than design.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > It is the revert itself that is broken.
> > > > > > > > > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876=
e00a03c2
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-di=
rty (Jan 29 2026 - 22:56:17 +0800)
> > > > > > > > > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Which revert is correct.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > But once dc2d8423b19d30472b02e02b41504226=
908a4291
> > > > > > > > > > > > > > > > > And revert to 431f1ce46bbffff0db8f03437a3=
4400b11b30175
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Then all these broken I don't understand =
why even file diff cannot
> > > > > > > > > > > > > > > > > show any changes.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Do you mean the revert is broken and fixe=
d by alignment?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I mean that arbitrary changes (as part of t=
esting these things, the
> > > > > > > > > > > > > > > > "-dirty" in the version string would lead t=
o failing trees now passing)
> > > > > > > > > > > > > > > > can make the difference between pass/fail t=
o boot. Did you try Marek's
> > > > > > > > > > > > > > > > patch I linked to?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, I had tried. Cannot boot same as I had m=
entioned failing commit #.
> > > > > > > > > > > > > > > I apply that patch on the latest master commi=
t.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The other, maybe, thing is you need a bigger SP=
L_SYS_MALLOC_F_LEN ?
> > > > > > > > > > > > > > Otherwise, you'll need to dig more and see why =
the device tree isn't
> > > > > > > > > > > > > > being found where expected on your platform, an=
d possibly where it is
> > > > > > > > > > > > > > instead.
> > > > > > > > > > > > >
> > > > > > > > > > > > > No the failing point is done after
> > > > > > > > > > > > >
> > > > > > > > > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > > > > > Revert "arm: spl: Correct alignment of .rel.dyn s=
ection"
> > > > > > > > > > > > > This reverts commit 380ddb4. Signed-off-by: Tom R=
ini <trini@konsulko.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > > This commit I tried to boot and works..
> > > > > > > > > > > > >
> > > > > > > > > > > > > Then this commit
> > > > > > > > > > > > >
> > > > > > > > > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > > > > count rel_dyn
> > > > > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > > I manually replaced the old Makefile.xpl and also=
 worked it boot.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > > > > > > >
> > > > > > > > > > > > > Revert a number of incorrect commits
> > > > > > > > > > > > > As part of debugging the appended device tree fai=
lure, I inadvertently
> > > > > > > > > > > > > committed some changes as I was debugging to mast=
er, and not a private
> > > > > > > > > > > > > branch, and pushed them as part of the release. T=
his reverts commit
> > > > > > > > > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini =
<trini@konsulko.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > > This is the point that everything no longer boots.
> > > > > > > > > > > > >
> > > > > > > > > > > > > But between those commits there are no extra code=
s.
> > > > > > > > > > > > >
> > > > > > > > > > > > > After that all things no longer work.
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, and I need you to investigate your failure cas=
e here. There is no
> > > > > > > > > > > > code change between a working commit and a failing =
commit, which leads
> > > > > > > > > > > > me to the suggestions I gave for debugging.
> > > > > > > > > > >
> > > > > > > > > > > I even tried a fresh clone from https://github.com/u-=
boot/u-boot.
> > > > > > > > > > > Same situation.
> > > > > > > > > > > I don't understand.
> > > > > > > > > > > The commit missed or messed up?
> > > > > > > > > >
> > > > > > > > > > You need to look at the resulting binaries and see why =
the device tree
> > > > > > > > > > is not where it's expected to be.
> > > > > > > > > >
> > > > > > > > > > You might find it helpful looking through
> > > > > > > > > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn=
8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com/
> > > > > > > > > > for some ideas.
> > > > > > > > >
> > > > > > > > > So you are suggesting even the commit between revert coul=
d introduce this issue?
> > > > > > > > > Aren't the revert only applied to two changes?
> > > > > > > >
> > > > > > > > What I'm saying is that the underlying issue is that the de=
vice tree is
> > > > > > > > not where it's expected to be. The likely root cause is tha=
t we now
> > > > > > > > require the device tree to be (correctly!) 8 byte aligned i=
n memory and
> > > > > > > > not 4 byte aligned. In the case of appending a device tree =
to our binary
> > > > > > > > any sort of change in the code can change the size of the b=
inary and in
> > > > > > > > turn mean that the address where the device tree is ends up=
 being at a
> > > > > > > > different alignment.
> > > > > > >
> > > > > > > You are correct on this, but I don't understand why even reve=
rting to
> > > > > > > two code changes
> > > > > > > could introduce this issue.
> > > > > > >
> > > > > > > The revert also included other commits?
> > > > > > >
> > > > > > > "
> > > > > > > Revert a number of incorrect commits
> > > > > > > As part of debugging the appended device tree failure, I inad=
vertently
> > > > > > > committed some changes as I was debugging to master, and not =
a private
> > > > > > > branch, and pushed them as part of the release. This reverts =
commit
> > > > > > > dc2d842 through 380ddb4.
> > > > > > > "
> > > > > > >
> > > > > > > This is my debug case:
> > > > > > >
> > > > > > > Correct boot:
> > > > > > > hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
> > > > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |=
=2E.pGo...pG......|
> > > > > > > 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |=
=2E...............|
> > > > > > >
> > > > > > > Fail boot:
> > > > > > > hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> > > > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |=
=2E.pGo...pG......|
> > > > > > > 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |=
=2E...............|
> > > > > >
> > > > > > Yup, so it's mis-aligned. I guess can you tell me what the defc=
onfig
> > > > > > you're using is?
> > > > >
> > > > > socfpga_cyclone5_defconfig
> > > >
> > > > You might need to do some debugging yourself on this. Is that also =
where
> > > > __bss_end is? This looks like the exact case that
> > > > 5ffc1dcc26d3df9e2b192151936cb98014fb6e49 should have fixed. And loc=
ally,
> > > > I see it being aligned, and then also just making a trival change (=
git
> > > > tree is dirty) that used to lead to mis-alignment, retaining alignm=
ent.
> > >
> > > I have a question I still don't understand.
> > > The example you gave me is even earlier than
> > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2.
> > > But build on f4dfa5d3c2680322fd17fcc7c6221876e00a03c2 can boot normal=
ly.
> > > So what 431f1ce46bbffff0db8f03437a34400b11b30175 actually reverted and
> > > could introduce this shift from first place.
> > >
> > > I really need this to clear out for me to debug the issue.
> >
> > You might need to build with V=3D1 and see what's being generated to go=
 in
> > to the binary file, and look at spl/u-boot-spl.map to see if things like
> > __bss_end match. You need to ignore the 3 commits I reverted because
> > they were debug things that did not work. They change behavior because
> > they make changes in the linker scripts and so change alignments.
>=20
> Yes this is understood for debugging but even reverting and only building=
 at
> the reverted commit fails to boot properly this is what I am kept mention=
ing.
>=20
> This is why I don't understand how could no code change can even shift or
> change the build result this is not possible or I really missed hidden
> revert commit
> from the first place.

The state of the git tree can result in the version string changing and
so change the binary.

--=20
Tom

--HogtUb4ywil7mO4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXuNugAKCRAr4qD1Cr/k
CkZ5AP9Wup3E4lhF3XFhq4X5LCjl1KcxzphTBVJzfoC5i7b0FAEArasqVzh7SqBE
YHjxL8yW9Esc9hKPBGlRmfrJxKcnLgg=
=rscY
-----END PGP SIGNATURE-----

--HogtUb4ywil7mO4X--
