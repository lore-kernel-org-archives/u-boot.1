Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4524DD358D6
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E8083FFF;
	Thu, 29 Jan 2026 17:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GWF/Fxnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC04C8405B; Thu, 29 Jan 2026 17:52:17 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3CA283F32
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45f0c1f1b54so719576b6e.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769705533; x=1770310333; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cbC3jin+PzkmjsxhjfqfQ9wWRgWN2aFNLlNmNrcCzxY=;
 b=GWF/Fxnw/purNUlRQ75c+kwmh+PcS9ACObpSoQeEWTqmSFDXuWWHpg5Sf4xELYA+n8
 xJ+0ZCZjZ0KXrbtMuMV5Ajn/Q72Jw16FP8vHGlXVfbGjY0tKks8KY214vIKDclKUjXqY
 8DQr9y06xFf4bdy9/cqar84Ky2mzAursECPLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769705533; x=1770310333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbC3jin+PzkmjsxhjfqfQ9wWRgWN2aFNLlNmNrcCzxY=;
 b=FtavErMgjSS+5iZ1NCE2/FGhPpAcCM3e2fuHc3KXjUSnPMua3ypq9IQNMre2pu98Ul
 y3yJqwK5UBu2XpegplcDmLLroqqxKDrrtaaER9KhSjaKOM+V30TrJ2rluCh/lPi4/l58
 fZWm6BH305NJzhdUJR0eTZWXQQMVJanRMqDoA9UV7hiYNdFSGdlVlWCZWr4HFXN7bfGA
 ZD2fv8sHYbR2j+EYpxzpsnT8h2maEQR3ikry4bZi7D5irCRxUmTIAF8C4NADyKQSsF8E
 uzccWYofjB8u5KnwcskS+DCaGAc9UV/xAhLd50+DNqfm8jf7uvQ0sSLFxceugchC39Ei
 6LHA==
X-Gm-Message-State: AOJu0Yyq13YDO+G+s3WcUVJwM14FWdytOB77WsVLZnQC07pSuTOR4qcM
 sGWI7WGCYqeGWWMBxjagTBmUr6PLt3RxzNclFp+zcMv+J/DH83ywAZIUtm4v62ftKWc=
X-Gm-Gg: AZuq6aK0VrxqoWhopD742hwVwBeWChELK7NQLEyQ4LvzxhE2FMJDgbpzMebIC01ajod
 NuVujnIMbB7oyDswHUjGF3zGxHPSNDTBrk/vDtcFiXLhpLOecDb2Pj6GZ0+TYu9A6I5Q8/QxQRR
 FKhq+aNBi2VlZcDJ43jo0kK1I2ufb2x9C7wHQzhqwQsILLayCBNIWxupvXzKztBw30ITH7Fd/aw
 Yoo9V5vsX8zeCnkLtnmggYWaiDvc52cM1p1qFMGi3jjCw9ir7u85TL4c7DnY2p0beFpNDZMA19f
 lJ1zP1ZDCxZyppuWvdjhcIsxhqPr135gQUX1uHux0Dt/P8FKxWgQZhN+aew3hnre4By2pDRzKht
 j1PjP2bsUnyqg+hC2MKSbBYGV718O4qBRKnBp+jOD5OCZT3Mz9ttBGQHt2/+i8U05+PXSNnINVb
 QhIiF7HF60q6eNGaU1h9AcCi7ceaGXWcdL8sIGFzaQkjviLLHyGZEaj0KbjQQWjyBW6qiC9YjP1
 CLt1PKmiJDP/lzF1pN5Uc6rWsSXQK0KOW8PN8o=
X-Received: by 2002:a05:6808:1485:b0:45a:6d11:9895 with SMTP id
 5614622812f47-45f34d8e349mr84491b6e.64.1769705533543; 
 Thu, 29 Jan 2026 08:52:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08f20e43sm3243118b6e.13.2026.01.29.08.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:52:13 -0800 (PST)
Date: Thu, 29 Jan 2026 10:52:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129165210.GB2044980@bill-the-cat>
References: <20260129160315.GZ3416603@bill-the-cat>
 <CAN7C2SDZ9fO-BsjcRj638LtR5QYWUt+PjOyXvao9aXS+J9Pnzw@mail.gmail.com>
 <20260129160830.GA3416603@bill-the-cat>
 <CAN7C2SB0+kNYjho=LDKASfqddgQeCYXu0hhPeK62menTR6VW1Q@mail.gmail.com>
 <20260129162226.GB3416603@bill-the-cat>
 <CAN7C2SC8ZCcD_F4W_R_Ww02px7AV4hOv1WnrOpvKoVnU14gFLA@mail.gmail.com>
 <20260129163540.GA2043007@bill-the-cat>
 <CAN7C2SBwwLrsrHgkS82oGuWZf8K1O9+UgZHOuvsco3ExCMD0Fw@mail.gmail.com>
 <20260129164130.GA2044980@bill-the-cat>
 <CAN7C2SCYYqQviS6pJYd7KiSYvd7tJKLqHPc5tCpyuF1ckYexcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cMZvEHlu0ganLSHN"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCYYqQviS6pJYd7KiSYvd7tJKLqHPc5tCpyuF1ckYexcA@mail.gmail.com>
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


--cMZvEHlu0ganLSHN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:43:51AM +0800, Sune Brian wrote:
> On Fri, Jan 30, 2026 at 12:41=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Fri, Jan 30, 2026 at 12:39:17AM +0800, Sune Brian wrote:
> > > On Fri, Jan 30, 2026 at 12:35=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Fri, Jan 30, 2026 at 12:29:56AM +0800, Sune Brian wrote:
> > > > > On Fri, Jan 30, 2026 at 12:22=E2=80=AFAM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Fri, Jan 30, 2026 at 12:09:26AM +0800, Sune Brian wrote:
> > > > > > > On Fri, Jan 30, 2026 at 12:08=E2=80=AFAM Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jan 30, 2026 at 12:07:25AM +0800, Sune Brian wrote:
> > > > > > > > > On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trini@=
konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wr=
ote:
> > > > > > > > > > > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <tr=
ini@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Bria=
n wrote:
> > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini=
 <trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune =
Brian wrote:
> > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom =
Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, S=
une Brian wrote:
> > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM =
Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +080=
0, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=
=AFPM Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM =
+0800, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=
=80=AFPM Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:3=
7PM +0800, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > The commits after c08da5d03c2=
a0b72e81a11ff7ca507e3a6414db3
> > > > > > > > > > > > > > > > > > > > > > > All Cyclone V boards are unab=
le to boot, not sure this patch is the fix?
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Yes, those commits were uninten=
tional and have been reverted.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Had tested the last commit 6a1bdb=
7e952d5841f42742fefa907cae5dc8d50a
> > > > > > > > > > > > > > > > > > > > > Same situation that the boards ar=
e unable to enter the SPL phase.
> > > > > > > > > > > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d=
8563db135c167077ec works properly.
> > > > > > > > > > > > > > > > > > > > > After that things are broken.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Please give
> > > > > > > > > > > > > > > > > > > > https://patchwork.ozlabs.org/projec=
t/uboot/patch/20260129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > > > > > > > > > > a try as I think it might have been=
 working before by alignment luck
> > > > > > > > > > > > > > > > > > > > rather than design.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > It is the revert itself that is broke=
n.
> > > > > > > > > > > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c622=
1876e00a03c2
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c26=
8-dirty (Jan 29 2026 - 22:56:17 +0800)
> > > > > > > > > > > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Which revert is correct.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > But once dc2d8423b19d30472b02e02b4150=
4226908a4291
> > > > > > > > > > > > > > > > > > > And revert to 431f1ce46bbffff0db8f034=
37a34400b11b30175
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Then all these broken I don't underst=
and why even file diff cannot
> > > > > > > > > > > > > > > > > > > show any changes.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Do you mean the revert is broken and =
fixed by alignment?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I mean that arbitrary changes (as part =
of testing these things, the
> > > > > > > > > > > > > > > > > > "-dirty" in the version string would le=
ad to failing trees now passing)
> > > > > > > > > > > > > > > > > > can make the difference between pass/fa=
il to boot. Did you try Marek's
> > > > > > > > > > > > > > > > > > patch I linked to?
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Yes, I had tried. Cannot boot same as I h=
ad mentioned failing commit #.
> > > > > > > > > > > > > > > > > I apply that patch on the latest master c=
ommit.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > The other, maybe, thing is you need a bigge=
r SPL_SYS_MALLOC_F_LEN ?
> > > > > > > > > > > > > > > > Otherwise, you'll need to dig more and see =
why the device tree isn't
> > > > > > > > > > > > > > > > being found where expected on your platform=
, and possibly where it is
> > > > > > > > > > > > > > > > instead.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > No the failing point is done after
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > > > > > > > Revert "arm: spl: Correct alignment of .rel.d=
yn section"
> > > > > > > > > > > > > > > This reverts commit 380ddb4. Signed-off-by: T=
om Rini <trini@konsulko.com>
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This commit I tried to boot and works..
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Then this commit
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > > > > > > count rel_dyn
> > > > > > > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I manually replaced the old Makefile.xpl and =
also worked it boot.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Revert a number of incorrect commits
> > > > > > > > > > > > > > > As part of debugging the appended device tree=
 failure, I inadvertently
> > > > > > > > > > > > > > > committed some changes as I was debugging to =
master, and not a private
> > > > > > > > > > > > > > > branch, and pushed them as part of the releas=
e. This reverts commit
> > > > > > > > > > > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom R=
ini <trini@konsulko.com>
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This is the point that everything no longer b=
oots.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > But between those commits there are no extra =
codes.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > After that all things no longer work.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, and I need you to investigate your failure=
 case here. There is no
> > > > > > > > > > > > > > code change between a working commit and a fail=
ing commit, which leads
> > > > > > > > > > > > > > me to the suggestions I gave for debugging.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I even tried a fresh clone from https://github.co=
m/u-boot/u-boot.
> > > > > > > > > > > > > Same situation.
> > > > > > > > > > > > > I don't understand.
> > > > > > > > > > > > > The commit missed or messed up?
> > > > > > > > > > > >
> > > > > > > > > > > > You need to look at the resulting binaries and see =
why the device tree
> > > > > > > > > > > > is not where it's expected to be.
> > > > > > > > > > > >
> > > > > > > > > > > > You might find it helpful looking through
> > > > > > > > > > > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYn=
PQLn8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com/
> > > > > > > > > > > > for some ideas.
> > > > > > > > > > >
> > > > > > > > > > > So you are suggesting even the commit between revert =
could introduce this issue?
> > > > > > > > > > > Aren't the revert only applied to two changes?
> > > > > > > > > >
> > > > > > > > > > What I'm saying is that the underlying issue is that th=
e device tree is
> > > > > > > > > > not where it's expected to be. The likely root cause is=
 that we now
> > > > > > > > > > require the device tree to be (correctly!) 8 byte align=
ed in memory and
> > > > > > > > > > not 4 byte aligned. In the case of appending a device t=
ree to our binary
> > > > > > > > > > any sort of change in the code can change the size of t=
he binary and in
> > > > > > > > > > turn mean that the address where the device tree is end=
s up being at a
> > > > > > > > > > different alignment.
> > > > > > > > >
> > > > > > > > > You are correct on this, but I don't understand why even =
reverting to
> > > > > > > > > two code changes
> > > > > > > > > could introduce this issue.
> > > > > > > > >
> > > > > > > > > The revert also included other commits?
> > > > > > > > >
> > > > > > > > > "
> > > > > > > > > Revert a number of incorrect commits
> > > > > > > > > As part of debugging the appended device tree failure, I =
inadvertently
> > > > > > > > > committed some changes as I was debugging to master, and =
not a private
> > > > > > > > > branch, and pushed them as part of the release. This reve=
rts commit
> > > > > > > > > dc2d842 through 380ddb4.
> > > > > > > > > "
> > > > > > > > >
> > > > > > > > > This is my debug case:
> > > > > > > > >
> > > > > > > > > Correct boot:
> > > > > > > > > hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
> > > > > > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe e=
d  |..pGo...pG......|
> > > > > > > > > 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c=
8  |................|
> > > > > > > > >
> > > > > > > > > Fail boot:
> > > > > > > > > hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> > > > > > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe e=
d  |..pGo...pG......|
> > > > > > > > > 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe e=
d  |................|
> > > > > > > >
> > > > > > > > Yup, so it's mis-aligned. I guess can you tell me what the =
defconfig
> > > > > > > > you're using is?
> > > > > > >
> > > > > > > socfpga_cyclone5_defconfig
> > > > > >
> > > > > > You might need to do some debugging yourself on this. Is that a=
lso where
> > > > > > __bss_end is? This looks like the exact case that
> > > > > > 5ffc1dcc26d3df9e2b192151936cb98014fb6e49 should have fixed. And=
 locally,
> > > > > > I see it being aligned, and then also just making a trival chan=
ge (git
> > > > > > tree is dirty) that used to lead to mis-alignment, retaining al=
ignment.
> > > > >
> > > > > I have a question I still don't understand.
> > > > > The example you gave me is even earlier than
> > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2.
> > > > > But build on f4dfa5d3c2680322fd17fcc7c6221876e00a03c2 can boot no=
rmally.
> > > > > So what 431f1ce46bbffff0db8f03437a34400b11b30175 actually reverte=
d and
> > > > > could introduce this shift from first place.
> > > > >
> > > > > I really need this to clear out for me to debug the issue.
> > > >
> > > > You might need to build with V=3D1 and see what's being generated t=
o go in
> > > > to the binary file, and look at spl/u-boot-spl.map to see if things=
 like
> > > > __bss_end match. You need to ignore the 3 commits I reverted because
>=20
> For the __bss_end:
>=20
> Boot case:
>=20
> hexdump -Cv u-boot-spl.sfp | grep 'd0 0d fe ed'
> 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG..=
=2E...|
> 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |............=
=2E...|
>=20
> arm-none-eabi-readelf -s spl/u-boot-spl  | grep __bss_end
>   1196: ffffbeb8     0 NOTYPE  GLOBAL DEFAULT    6 __bss_end
>=20
> This makes sense to me because it matched.
>=20
> Fail boot cas:
>=20
> hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG..=
=2E...|
> 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |............=
=2E...|
>=20
> arm-none-eabi-readelf -s spl/u-boot-spl  | grep __bss_end
>   1196: ffffbeb8     0 NOTYPE  GLOBAL DEFAULT    6 __bss_end

FWIW, I use: grep -E '__bss_(start|end)' spl/u-boot-spl.map

> So this is indeed broken as it now should be beb'C'?

It shouldn't be 'bebc' as that is not 8 byte aligned.

> Where to change this may I ask?

That's what I'm asking you to figure out. The __bss_end symbol is at
beb8, which is aligned, but there's 4 extra bytes between where the dtb
should be, and where it's being placed. I thought I had fixed that.
Maybe the rule for -pad.bin in scripts/Makefile.xpl is getting something
wrong (see the reverted commits for when I was investigating that) but
maybe not.

--=20
Tom

--cMZvEHlu0ganLSHN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXuQMgAKCRAr4qD1Cr/k
CkqQAP9+qwTvUB/CHYJk1fwusm1mvG24hNOaQygrZg6jNtqI9wEAhO2M80X5+ACG
b8jXs+RybRPg8lE6vZkbFruZvavj6gY=
=A1nE
-----END PGP SIGNATURE-----

--cMZvEHlu0ganLSHN--
