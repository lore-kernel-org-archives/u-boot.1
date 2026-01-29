Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D57CD3F09D
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D439483FFF;
	Thu, 29 Jan 2026 17:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a9n+ZAJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823C784062; Thu, 29 Jan 2026 17:57:37 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8537783F32
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7cfdf7e7d19so1021818a34.2
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769705853; cv=none;
 d=google.com; s=arc-20240605;
 b=KQWgGgCtGHoIvsiWWCFjKp+TgADvtbKyolt6H1NAGbtjxuZvneWJm9uK101YAzTgxo
 KBNwRgN55nBNAeRsS+eA0zQos8kVThtHdD4i5mB7DmAgD/71D7m2u5G+l5Vxago32z40
 p7VW5MYzmiUWj/NgHiWP2SPhzE4RHQlGQPI4KjiTs7pQL90k3mEzipcf4WIyEdmRzDYl
 266MzutJgMqRaY8wBcxx6iwSlgrITDrwr4MSMqQUkHfC6bwHBDzZxpp3PxApype56G9X
 im83QKlsqKVpH6TCAoWsmbNPdrKrLbEKw/+mneT7GG9mhLP17XJzW21/uQ8kMDd7RhZn
 wjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dAl/zWqnwg3KmzD9ImFgReXoTbcWg1/6CR7QjJkxmfE=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=D4LNlU2Y1dmKJZGzguHct+gkoyYP3CE51tCm41ohwc59McD/ii/eTIvgiXfksPefoA
 ekRNu9zVi9nhv0bZ1Am48Cyaf2G40YDCT6VigZt42W/Bnb5jz+uY3vz8gMhcg9+afhVl
 OBsyFyFD/q+YTCYy9bmecvp4cgmal7nl/t/RA6HyImqCU4+882a/yXaT5bUJNJ0SO43p
 vc+NItJREYl7xlO9noGT4LxnWKGHQ2/YAFhmGJiPMY44XN/8u+RdhLwDpy6zG7RA4kw3
 RQXpCdTWHAbyc6PGbeR2LiU8EwCCI1wR4RAMLmQqNhUBn3zxliP6s32ab97ZJCo9azOc
 IgIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769705853; x=1770310653; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAl/zWqnwg3KmzD9ImFgReXoTbcWg1/6CR7QjJkxmfE=;
 b=a9n+ZAJLHCtkelhpmGjb5+4sK6FLDC0ENVMHuaCr7S0g4YYa7ZuGQSXZMPQ+BJ/2Kf
 MAT724RxbJuvelQWacP4TleYJjQYX7QYs5j0ouLom3IP2BHopD00x7ELifFS8lGm3uaU
 0AIZinn7vP0LSOsb0ObFGJgpds9F1tvGHwMX9BOxeHXoU5OYahMB1Y0ZZi/3bdFt97O0
 bhqB7q5rdokxOMdwAjl0psSvnRyw45dN05lIJVQLlWehoRXm3op/cAi9FS14k2Ii2ONH
 3Ewc9/crsFKyOy9kCHMA4OKlhQPrXwPJYxV9r2GVoKBzwUup2ppBrg1ceqGIfTCs844h
 heww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769705853; x=1770310653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dAl/zWqnwg3KmzD9ImFgReXoTbcWg1/6CR7QjJkxmfE=;
 b=c4Wlfgo5BBdD6vVWgePZ68kG+T3C1oTmiKCUkf7F8vXPNWJ3SrfI3F0xONcYJVz808
 692QimH/21+7bV1L7ffMdXGvNOP8rWs/Jlq/xW7hCTZcI+82hTUsNtLCdQYV9Z7xdlfX
 kE31+EzBOTJrIPXhHYEOHPpil30ytKGmSmsCV+oBAKIr1zvK5bi8CZQ3cLJiKR9xrE2+
 84f7KDCt+I1gU24wJT6uPteZOOM306r9WMwpsV53c4p+ejjJtEFG/jGvNHAnuk6gPMGG
 EOupdhWxgoh84f9CkiOFQwl5Xst+l+R2ma2IEfhqttp+RtL4CTmgbFEDrgZhKxY4T7p7
 d8PA==
X-Gm-Message-State: AOJu0YzZKkmFubVBluDUO/r5BMCmJBGNDTORQr47AHFFpNxj+Q1Hep0H
 hHrCytaxDSG+p4ufVXYWdVjqteJeSROxDE4vupFb1iPzbTPT5ptpm1aPwyG8AElILrjl/rVhhjY
 7IY305X8dglKPcLNpkW05x2ANRtNJ9SQJ64+97fiWJQ==
X-Gm-Gg: AZuq6aKk23HyWH3kSTCnGI0RGBSD/hIdpuLC9iegdU49o+X22ak25yygjmtxVFzDnFg
 0jXYEb/kqxBiKclhsbSQ94KbqI+fX34B2pOEqoHcIsMeTLrr5zEsRkY9ZYmQKu+YRZ8WQndYAMx
 6xtlUgW6Uaywpn2+eZWH/FjD44ueQo5ERReP/R4A1eRK+ueGQBy/HQ9HL4URyKEIOma2jElw8fL
 /RP7WcAt+ggOnZkSS6V2f2oYvAxNC86UcVW4ang1imbqlekNK+P98dzeHXmg8d0rOMsov4C
X-Received: by 2002:a05:6830:2aa6:b0:7c9:5bef:e9b with SMTP id
 46e09a7af769-7d1a52e1728mr131236a34.3.1769705852906; Thu, 29 Jan 2026
 08:57:32 -0800 (PST)
MIME-Version: 1.0
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
 <20260129165210.GB2044980@bill-the-cat>
In-Reply-To: <20260129165210.GB2044980@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 30 Jan 2026 00:57:20 +0800
X-Gm-Features: AZwV_QhRf0lTvIeksgPh1r3wQX_t0uRfyyfgbPuZjYk6zJgTd1SITn_aT3b1rLM
Message-ID: <CAN7C2SCuN97VVmCdhdGHHgSY8Kj7eHqg5bbhC3uXuVMrkDu_6A@mail.gmail.com>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jan 30, 2026 at 12:52=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Jan 30, 2026 at 12:43:51AM +0800, Sune Brian wrote:
> > On Fri, Jan 30, 2026 at 12:41=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Fri, Jan 30, 2026 at 12:39:17AM +0800, Sune Brian wrote:
> > > > On Fri, Jan 30, 2026 at 12:35=E2=80=AFAM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Fri, Jan 30, 2026 at 12:29:56AM +0800, Sune Brian wrote:
> > > > > > On Fri, Jan 30, 2026 at 12:22=E2=80=AFAM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jan 30, 2026 at 12:09:26AM +0800, Sune Brian wrote:
> > > > > > > > On Fri, Jan 30, 2026 at 12:08=E2=80=AFAM Tom Rini <trini@ko=
nsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Jan 30, 2026 at 12:07:25AM +0800, Sune Brian wrot=
e:
> > > > > > > > > > On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trin=
i@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian =
wrote:
> > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <=
trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Br=
ian wrote:
> > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Ri=
ni <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sun=
e Brian wrote:
> > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM To=
m Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800,=
 Sune Brian wrote:
> > > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFP=
M Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0=
800, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=
=AFPM Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21A=
M +0800, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=
=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49=
:37PM +0800, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > The commits after c08da5d03=
c2a0b72e81a11ff7ca507e3a6414db3
> > > > > > > > > > > > > > > > > > > > > > > > All Cyclone V boards are un=
able to boot, not sure this patch is the fix?
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Yes, those commits were unint=
entional and have been reverted.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Had tested the last commit 6a1b=
db7e952d5841f42742fefa907cae5dc8d50a
> > > > > > > > > > > > > > > > > > > > > > Same situation that the boards =
are unable to enter the SPL phase.
> > > > > > > > > > > > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d3=
8d8563db135c167077ec works properly.
> > > > > > > > > > > > > > > > > > > > > > After that things are broken.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Please give
> > > > > > > > > > > > > > > > > > > > > https://patchwork.ozlabs.org/proj=
ect/uboot/patch/20260129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > > > > > > > > > > > a try as I think it might have be=
en working before by alignment luck
> > > > > > > > > > > > > > > > > > > > > rather than design.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > It is the revert itself that is bro=
ken.
> > > > > > > > > > > > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6=
221876e00a03c2
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c=
268-dirty (Jan 29 2026 - 22:56:17 +0800)
> > > > > > > > > > > > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Which revert is correct.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > But once dc2d8423b19d30472b02e02b41=
504226908a4291
> > > > > > > > > > > > > > > > > > > > And revert to 431f1ce46bbffff0db8f0=
3437a34400b11b30175
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Then all these broken I don't under=
stand why even file diff cannot
> > > > > > > > > > > > > > > > > > > > show any changes.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Do you mean the revert is broken an=
d fixed by alignment?
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > I mean that arbitrary changes (as par=
t of testing these things, the
> > > > > > > > > > > > > > > > > > > "-dirty" in the version string would =
lead to failing trees now passing)
> > > > > > > > > > > > > > > > > > > can make the difference between pass/=
fail to boot. Did you try Marek's
> > > > > > > > > > > > > > > > > > > patch I linked to?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Yes, I had tried. Cannot boot same as I=
 had mentioned failing commit #.
> > > > > > > > > > > > > > > > > > I apply that patch on the latest master=
 commit.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The other, maybe, thing is you need a big=
ger SPL_SYS_MALLOC_F_LEN ?
> > > > > > > > > > > > > > > > > Otherwise, you'll need to dig more and se=
e why the device tree isn't
> > > > > > > > > > > > > > > > > being found where expected on your platfo=
rm, and possibly where it is
> > > > > > > > > > > > > > > > > instead.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > No the failing point is done after
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > > > > > > > > Revert "arm: spl: Correct alignment of .rel=
.dyn section"
> > > > > > > > > > > > > > > > This reverts commit 380ddb4. Signed-off-by:=
 Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > This commit I tried to boot and works..
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Then this commit
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > > > > > > > count rel_dyn
> > > > > > > > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com=
>
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I manually replaced the old Makefile.xpl an=
d also worked it boot.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b301=
75
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Revert a number of incorrect commits
> > > > > > > > > > > > > > > > As part of debugging the appended device tr=
ee failure, I inadvertently
> > > > > > > > > > > > > > > > committed some changes as I was debugging t=
o master, and not a private
> > > > > > > > > > > > > > > > branch, and pushed them as part of the rele=
ase. This reverts commit
> > > > > > > > > > > > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom=
 Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > This is the point that everything no longer=
 boots.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > But between those commits there are no extr=
a codes.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > After that all things no longer work.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, and I need you to investigate your failu=
re case here. There is no
> > > > > > > > > > > > > > > code change between a working commit and a fa=
iling commit, which leads
> > > > > > > > > > > > > > > me to the suggestions I gave for debugging.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I even tried a fresh clone from https://github.=
com/u-boot/u-boot.
> > > > > > > > > > > > > > Same situation.
> > > > > > > > > > > > > > I don't understand.
> > > > > > > > > > > > > > The commit missed or messed up?
> > > > > > > > > > > > >
> > > > > > > > > > > > > You need to look at the resulting binaries and se=
e why the device tree
> > > > > > > > > > > > > is not where it's expected to be.
> > > > > > > > > > > > >
> > > > > > > > > > > > > You might find it helpful looking through
> > > > > > > > > > > > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgr=
YnPQLn8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com/
> > > > > > > > > > > > > for some ideas.
> > > > > > > > > > > >
> > > > > > > > > > > > So you are suggesting even the commit between rever=
t could introduce this issue?
> > > > > > > > > > > > Aren't the revert only applied to two changes?
> > > > > > > > > > >
> > > > > > > > > > > What I'm saying is that the underlying issue is that =
the device tree is
> > > > > > > > > > > not where it's expected to be. The likely root cause =
is that we now
> > > > > > > > > > > require the device tree to be (correctly!) 8 byte ali=
gned in memory and
> > > > > > > > > > > not 4 byte aligned. In the case of appending a device=
 tree to our binary
> > > > > > > > > > > any sort of change in the code can change the size of=
 the binary and in
> > > > > > > > > > > turn mean that the address where the device tree is e=
nds up being at a
> > > > > > > > > > > different alignment.
> > > > > > > > > >
> > > > > > > > > > You are correct on this, but I don't understand why eve=
n reverting to
> > > > > > > > > > two code changes
> > > > > > > > > > could introduce this issue.
> > > > > > > > > >
> > > > > > > > > > The revert also included other commits?
> > > > > > > > > >
> > > > > > > > > > "
> > > > > > > > > > Revert a number of incorrect commits
> > > > > > > > > > As part of debugging the appended device tree failure, =
I inadvertently
> > > > > > > > > > committed some changes as I was debugging to master, an=
d not a private
> > > > > > > > > > branch, and pushed them as part of the release. This re=
verts commit
> > > > > > > > > > dc2d842 through 380ddb4.
> > > > > > > > > > "
> > > > > > > > > >
> > > > > > > > > > This is my debug case:
> > > > > > > > > >
> > > > > > > > > > Correct boot:
> > > > > > > > > > hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
> > > > > > > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe=
 ed  |..pGo...pG......|
> > > > > > > > > > 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08=
 c8  |................|
> > > > > > > > > >
> > > > > > > > > > Fail boot:
> > > > > > > > > > hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> > > > > > > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe=
 ed  |..pGo...pG......|
> > > > > > > > > > 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe=
 ed  |................|
> > > > > > > > >
> > > > > > > > > Yup, so it's mis-aligned. I guess can you tell me what th=
e defconfig
> > > > > > > > > you're using is?
> > > > > > > >
> > > > > > > > socfpga_cyclone5_defconfig
> > > > > > >
> > > > > > > You might need to do some debugging yourself on this. Is that=
 also where
> > > > > > > __bss_end is? This looks like the exact case that
> > > > > > > 5ffc1dcc26d3df9e2b192151936cb98014fb6e49 should have fixed. A=
nd locally,
> > > > > > > I see it being aligned, and then also just making a trival ch=
ange (git
> > > > > > > tree is dirty) that used to lead to mis-alignment, retaining =
alignment.
> > > > > >
> > > > > > I have a question I still don't understand.
> > > > > > The example you gave me is even earlier than
> > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2.
> > > > > > But build on f4dfa5d3c2680322fd17fcc7c6221876e00a03c2 can boot =
normally.
> > > > > > So what 431f1ce46bbffff0db8f03437a34400b11b30175 actually rever=
ted and
> > > > > > could introduce this shift from first place.
> > > > > >
> > > > > > I really need this to clear out for me to debug the issue.
> > > > >
> > > > > You might need to build with V=3D1 and see what's being generated=
 to go in
> > > > > to the binary file, and look at spl/u-boot-spl.map to see if thin=
gs like
> > > > > __bss_end match. You need to ignore the 3 commits I reverted beca=
use
> >
> > For the __bss_end:
> >
> > Boot case:
> >
> > hexdump -Cv u-boot-spl.sfp | grep 'd0 0d fe ed'
> > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG=
......|
> > 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |..........=
......|
> >
> > arm-none-eabi-readelf -s spl/u-boot-spl  | grep __bss_end
> >   1196: ffffbeb8     0 NOTYPE  GLOBAL DEFAULT    6 __bss_end
> >
> > This makes sense to me because it matched.
> >
> > Fail boot cas:
> >
> > hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG=
......|
> > 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |..........=
......|
> >
> > arm-none-eabi-readelf -s spl/u-boot-spl  | grep __bss_end
> >   1196: ffffbeb8     0 NOTYPE  GLOBAL DEFAULT    6 __bss_end
>
> FWIW, I use: grep -E '__bss_(start|end)' spl/u-boot-spl.map
>
> > So this is indeed broken as it now should be beb'C'?
>
> It shouldn't be 'bebc' as that is not 8 byte aligned.
>
> > Where to change this may I ask?
>
> That's what I'm asking you to figure out. The __bss_end symbol is at
> beb8, which is aligned, but there's 4 extra bytes between where the dtb
> should be, and where it's being placed. I thought I had fixed that.
> Maybe the rule for -pad.bin in scripts/Makefile.xpl is getting something
> wrong (see the reverted commits for when I was investigating that) but
> maybe not.

I made a mistake but I think the situation still holds. I forgot to pull ba=
ck
to master.

After build and fail to boot:

hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG....=
..|
0000bec0  00 00 00 00 d0 0d fe ed  00 00 08 c8 00 00 00 48  |..............=
.H|

grep -E '__bss_(start|end)' spl/u-boot-spl.map
                0x00000000ffffbe58                __bss_start =3D .
                0x00000000ffffbec8                __bss_end =3D .
                0x0000000000000070                __bss_size =3D
(__bss_end - __bss_start)

arm-none-eabi-readelf -s spl/u-boot-spl  | grep __bss_end
  1195: ffffbec8     0 NOTYPE  GLOBAL DEFAULT    6 __bss_end

The byte is 4 byte less, not 4 byte more in this latest master commit.

Brian


>
> --
> Tom
