Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2229AD6B08A
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D79A8401A;
	Thu, 29 Jan 2026 17:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XWi/69Y5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B99C8402E; Thu, 29 Jan 2026 17:30:12 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2D183FED
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d196a2334fso1068493a34.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769704208; cv=none;
 d=google.com; s=arc-20240605;
 b=WK8jujX1EjEYJp7wPKm5qaSv34cDfwXx27CHmpNyDMjZhIksQw9q2IhrO8cg7PpR7j
 oEWJLCqc2kIMzrt78UOQkkfyd0dDrYM0wOUCZMCxZGLjglLOFzZf7Yt1nxulb0W4UI5A
 rV3LHRxU5O8l8BgCXevwCIHpUmgsBJ4tbaUm9/emEDjfTT1ec+IVA5t47G28qUsw8BG/
 i6tcqOCrg3e3LtZtb9ZMiED6By5JmAEDtGCxVqlc41ZHp/MnE8pTpTGhK1ezBw5gg2S5
 pG7+QaHRbVOPWq8YGEhAuTBl/b7sqLOmuO1aRcE6ruwMsj5ZOhCZWYpXFdKtVcy1t1wz
 7ZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v96d2XA45ZZqyRgr9V0myJ5MomIvdu6ff8IFEkZbXuk=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=kGDkpbyTWk09u1Yx5PbUeOJ4Ask8VvTeREOpCc1mOyjHUj19LJLkBVMLz7h9gXhC+A
 UT8W8GrbSgsrFlouJVpxx0GR1tvSSa3Ey+jZT5aeaEpUNZ9XLxjME0AcPrCtH6BE6Cu8
 uHVyk1mcKrschpJI6XaLALr3I6qzUzIcBm9Fy43saroGRdkcN0p8vSSTQrAyGYdlSz/j
 RZrYo/JxHZtKvIpCG3VtUl/65pMxenICNPrVRTGfABMr46ltg1i/uNves8lTlV1UyvVo
 LezA9DoixMuGrQQX/bKHERp1L32UvQSovF1QwiSWd7fTqEIimUtZt0jItDcOU558c3+c
 40ww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769704208; x=1770309008; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v96d2XA45ZZqyRgr9V0myJ5MomIvdu6ff8IFEkZbXuk=;
 b=XWi/69Y5HxaNOwXoWi48LR1lxtI1Wcj1sTxxA4BDhAqDWIbRFb4jlllcdj0R8miquj
 SXaUCVTiEuRnA/o6I0xsNCycK1/b47WViIxJF8PwBgU3ryiu4mwboLJhzFfmzliTdvo3
 6TOp07QLRRzShGlz9SJ+9ek1qnrcgnYjjms/L5SyivBh8XVlEY7KolHc9v/gUa53myIn
 vQ/F0xRX0qhAmOJj4Bu7bkgpdpYfuFyqglu6h8SvVxpCe1nw0ArTxSL5KDwvv6GliaEO
 IGndxj5wBQamuHKI6tWIZnrOoljIwDeG89CIYwNTvnkoZ30mBslaFpQqHYTRstBoOvhe
 zPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704208; x=1770309008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v96d2XA45ZZqyRgr9V0myJ5MomIvdu6ff8IFEkZbXuk=;
 b=dg17jr7Q8Cp+TL8eijZOrl35/C8weNyrLlyn1xA9o7mOH0lmUj5fJjycztnGjhitdo
 bmyHOQCGfcH1od9Qwqunj08PTfiA4gWlUYCLbW/IlrOryMY8FZe+29QVTmOjdG2cKvYc
 FSHb/7T0G6m43AXeovBOvNKHnpjX41cxLPfup7NLxAy/eRGvzIG/Rm9jhdmJzbylOhte
 /AE83ZnFxY8Cbbug7pyT2cFom4nDfsiYin6jSYGi6QlMmQ+VkAaEZxjay2AkGaCJ0TJm
 DJdJjb9b1NbUEUn2G9Tg6fziEeiEePUXEj63eIVf6OVMEaT7TbGMaHqbkqJrxchQq6GT
 756Q==
X-Gm-Message-State: AOJu0YxwGQ4eefi5ECip/NiEWPkJ9WVDmKej9NZc9BSx27psNtds6dtP
 K1wiCmvCdOjUP6aF8nUEFDnvj+yZBR8QyKA7fYrHaq6i06AJpqhgjNYqYRDdDufBsW6cb/RO9gv
 W9qnfOKZiTBP+9q7350tQLIE5MipDM5Af5br+Shf/wA==
X-Gm-Gg: AZuq6aKjsyyBQS/SBfFQ/GFdzSp97v/zVc1HCUOsvl0Ef7F+M3XPPuavnqv5b0DHnHk
 FO2qm3HPuLle5Ji3BspW1T6rErraLktB2feM/VeDmXP5zNierEmmEsrqrWguOgwade2aEuRht9I
 38jWRrLdEHszmLpjsO+PPnnV/JJtiiuS5PqdaPTrXOxhm7cZyTr934YmUG2mAw3NDAAeC7qwtZz
 oMnKK2NI2fT3wMA/aVx5/IqwLRp4Wxk8cWIvwUm8snupMqWrwdI6Wy3Lo0ZMj08auWL7AaV
X-Received: by 2002:a05:6830:44a8:b0:7d1:93ea:5bc0 with SMTP id
 46e09a7af769-7d197084cc3mr1848005a34.9.1769704207876; Thu, 29 Jan 2026
 08:30:07 -0800 (PST)
MIME-Version: 1.0
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
 <20260129162226.GB3416603@bill-the-cat>
In-Reply-To: <20260129162226.GB3416603@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 30 Jan 2026 00:29:56 +0800
X-Gm-Features: AZwV_QgrgULdxeDBHZC9oY4lvXPhwOlKK20YItj56bUKWIqai7RHx5GEgkznaX4
Message-ID: <CAN7C2SC8ZCcD_F4W_R_Ww02px7AV4hOv1WnrOpvKoVnU14gFLA@mail.gmail.com>
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

On Fri, Jan 30, 2026 at 12:22=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Jan 30, 2026 at 12:09:26AM +0800, Sune Brian wrote:
> > On Fri, Jan 30, 2026 at 12:08=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Fri, Jan 30, 2026 at 12:07:25AM +0800, Sune Brian wrote:
> > > > On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wrote:
> > > > > > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wrote:
> > > > > > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trini@ko=
nsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wrot=
e:
> > > > > > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trin=
i@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian =
wrote:
> > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <=
trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Br=
ian wrote:
> > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Ri=
ni <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sun=
e Brian wrote:
> > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM To=
m Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800,=
 Sune Brian wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > The commits after c08da5d03c2a0b72e81a1=
1ff7ca507e3a6414db3
> > > > > > > > > > > > > > > > > > All Cyclone V boards are unable to boot=
, not sure this patch is the fix?
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Yes, those commits were unintentional and=
 have been reverted.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Had tested the last commit 6a1bdb7e952d5841=
f42742fefa907cae5dc8d50a
> > > > > > > > > > > > > > > > Same situation that the boards are unable t=
o enter the SPL phase.
> > > > > > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c=
167077ec works properly.
> > > > > > > > > > > > > > > > After that things are broken.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Please give
> > > > > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/pa=
tch/20260129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > > > > > a try as I think it might have been working b=
efore by alignment luck
> > > > > > > > > > > > > > > rather than design.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > It is the revert itself that is broken.
> > > > > > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03=
c2
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (J=
an 29 2026 - 22:56:17 +0800)
> > > > > > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Which revert is correct.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But once dc2d8423b19d30472b02e02b41504226908a42=
91
> > > > > > > > > > > > > > And revert to 431f1ce46bbffff0db8f03437a34400b1=
1b30175
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Then all these broken I don't understand why ev=
en file diff cannot
> > > > > > > > > > > > > > show any changes.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Do you mean the revert is broken and fixed by a=
lignment?
> > > > > > > > > > > > >
> > > > > > > > > > > > > I mean that arbitrary changes (as part of testing=
 these things, the
> > > > > > > > > > > > > "-dirty" in the version string would lead to fail=
ing trees now passing)
> > > > > > > > > > > > > can make the difference between pass/fail to boot=
. Did you try Marek's
> > > > > > > > > > > > > patch I linked to?
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, I had tried. Cannot boot same as I had mention=
ed failing commit #.
> > > > > > > > > > > > I apply that patch on the latest master commit.
> > > > > > > > > > >
> > > > > > > > > > > The other, maybe, thing is you need a bigger SPL_SYS_=
MALLOC_F_LEN ?
> > > > > > > > > > > Otherwise, you'll need to dig more and see why the de=
vice tree isn't
> > > > > > > > > > > being found where expected on your platform, and poss=
ibly where it is
> > > > > > > > > > > instead.
> > > > > > > > > >
> > > > > > > > > > No the failing point is done after
> > > > > > > > > >
> > > > > > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > > Revert "arm: spl: Correct alignment of .rel.dyn section=
"
> > > > > > > > > > This reverts commit 380ddb4. Signed-off-by: Tom Rini <t=
rini@konsulko.com>
> > > > > > > > > >
> > > > > > > > > > This commit I tried to boot and works..
> > > > > > > > > >
> > > > > > > > > > Then this commit
> > > > > > > > > >
> > > > > > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > count rel_dyn
> > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > >
> > > > > > > > > > I manually replaced the old Makefile.xpl and also worke=
d it boot.
> > > > > > > > > >
> > > > > > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > > > >
> > > > > > > > > > Revert a number of incorrect commits
> > > > > > > > > > As part of debugging the appended device tree failure, =
I inadvertently
> > > > > > > > > > committed some changes as I was debugging to master, an=
d not a private
> > > > > > > > > > branch, and pushed them as part of the release. This re=
verts commit
> > > > > > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini=
@konsulko.com>
> > > > > > > > > >
> > > > > > > > > > This is the point that everything no longer boots.
> > > > > > > > > >
> > > > > > > > > > But between those commits there are no extra codes.
> > > > > > > > > >
> > > > > > > > > > After that all things no longer work.
> > > > > > > > >
> > > > > > > > > Yes, and I need you to investigate your failure case here=
. There is no
> > > > > > > > > code change between a working commit and a failing commit=
, which leads
> > > > > > > > > me to the suggestions I gave for debugging.
> > > > > > > >
> > > > > > > > I even tried a fresh clone from https://github.com/u-boot/u=
-boot.
> > > > > > > > Same situation.
> > > > > > > > I don't understand.
> > > > > > > > The commit missed or messed up?
> > > > > > >
> > > > > > > You need to look at the resulting binaries and see why the de=
vice tree
> > > > > > > is not where it's expected to be.
> > > > > > >
> > > > > > > You might find it helpful looking through
> > > > > > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z0=
5FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com/
> > > > > > > for some ideas.
> > > > > >
> > > > > > So you are suggesting even the commit between revert could intr=
oduce this issue?
> > > > > > Aren't the revert only applied to two changes?
> > > > >
> > > > > What I'm saying is that the underlying issue is that the device t=
ree is
> > > > > not where it's expected to be. The likely root cause is that we n=
ow
> > > > > require the device tree to be (correctly!) 8 byte aligned in memo=
ry and
> > > > > not 4 byte aligned. In the case of appending a device tree to our=
 binary
> > > > > any sort of change in the code can change the size of the binary =
and in
> > > > > turn mean that the address where the device tree is ends up being=
 at a
> > > > > different alignment.
> > > >
> > > > You are correct on this, but I don't understand why even reverting =
to
> > > > two code changes
> > > > could introduce this issue.
> > > >
> > > > The revert also included other commits?
> > > >
> > > > "
> > > > Revert a number of incorrect commits
> > > > As part of debugging the appended device tree failure, I inadverten=
tly
> > > > committed some changes as I was debugging to master, and not a priv=
ate
> > > > branch, and pushed them as part of the release. This reverts commit
> > > > dc2d842 through 380ddb4.
> > > > "
> > > >
> > > > This is my debug case:
> > > >
> > > > Correct boot:
> > > > hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
> > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo.=
..pG......|
> > > > 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |......=
..........|
> > > >
> > > > Fail boot:
> > > > hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo.=
..pG......|
> > > > 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |......=
..........|
> > >
> > > Yup, so it's mis-aligned. I guess can you tell me what the defconfig
> > > you're using is?
> >
> > socfpga_cyclone5_defconfig
>
> You might need to do some debugging yourself on this. Is that also where
> __bss_end is? This looks like the exact case that
> 5ffc1dcc26d3df9e2b192151936cb98014fb6e49 should have fixed. And locally,
> I see it being aligned, and then also just making a trival change (git
> tree is dirty) that used to lead to mis-alignment, retaining alignment.

I have a question I still don't understand.
The example you gave me is even earlier than
f4dfa5d3c2680322fd17fcc7c6221876e00a03c2.
But build on f4dfa5d3c2680322fd17fcc7c6221876e00a03c2 can boot normally.
So what 431f1ce46bbffff0db8f03437a34400b11b30175 actually reverted and
could introduce this shift from first place.

I really need this to clear out for me to debug the issue.

Thanks,
Brian

>
> --
> Tom
