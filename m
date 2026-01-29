Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E79DD358D6
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD03683FFF;
	Thu, 29 Jan 2026 17:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BCxo46Wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA89B84056; Thu, 29 Jan 2026 17:44:07 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD51D83A64
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7cfd0f349c4so681766a34.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769705043; cv=none;
 d=google.com; s=arc-20240605;
 b=bHl28aBumn3y3g12aZvwVkAbdx7R1vfJMm9sUOB6AIqL3VDByK7uBS/wYL5Oyv7+I6
 ePTAn4cgdtTlGFgMup2A04a0mQVOsNDdAT/Y2YWhYum18NMOramwlI8h3j1tOskCS5us
 fR7OBQU1a68YiUM22UnoRJaoTNSPoXIhHL0Yhe7ZbXDQOD9/ugJBlqDSSXqzpPq2CGwl
 2L/TgojRL/roKwD4yfytT7ewlktT/d1ZqDZSVeS5NwLIkeP1Z0mHX3f1eBXB0ZPD3+lE
 Me9hAlJwn0zxazFfrRdh5/HewIMQgYq4rUloPbmnmV01PWjNyMrYdnzCD04i9u+yX1S1
 FpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VNxLdjAQwkemJQWlPC1Z2E1llz9jbeVqkh953YU85+M=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=IlP/NjtgEv1tzE5D7j/Ahx1uubGT69FVv+aQ2LxuFMQCf02uL2+0bjOe6kDWN+Gxqy
 6AYXRwnFcILmRTunIXnREqQW9SxQd+zBmqD81znZU2JQLAczGZNg3uf3uNfofngCQqFc
 e2tIawqTCIJMgAX4ucAX895NSivGGgqu5GIeizzt6OH5SK8Tdn2tcmCyr7H8z0KEzv8p
 BJE6yiyY+WHGQU2wJTv5ZRwSXWeXbvpJItdq6wMWhblqOeQFN+KUJaV9RRp/nzZwpJ4x
 32rbQ+32M+a9NsY2XXQiiWuZ3dqa+KVIEEnhAfu37lGZgGC8bpFXkoR8DL9HM0+Z/gHK
 GLGQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769705043; x=1770309843; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNxLdjAQwkemJQWlPC1Z2E1llz9jbeVqkh953YU85+M=;
 b=BCxo46WkOcA06irgvqdQd094oUUjM7SgmdbSWIRTAPosffD8fu5BMnzXy0b0NPZmVd
 eFOCZ7s02X141cXLb8PLvxlEMpKzGwnlqMxox2gfGV/x2ab4D/BJy4k+4Bx+KB804aOt
 AjsqW2myG2KSCIow9fxSEY2kRaK9328WAA7apAteGdTyxZgWy05XNLg4K2t1RmiIKjyV
 oNDuy7pgaEIC49kP38azOULBLIP+K/yJPazfnQi3P9+0cFfx0nculmbPrFQs8sJM3Mp6
 aedQGCGSQgvbJ8ubyksQK+Jyp2DvKEPKY6xUP2De4UGSz6yY+I59D3lXrUySZ41V9MJS
 gd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769705043; x=1770309843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VNxLdjAQwkemJQWlPC1Z2E1llz9jbeVqkh953YU85+M=;
 b=JRRwJX6SEqKg9ZropLGuX0g+9cYg/GrFr8uNdxPT9b+r4oiEGbfRF2fRbkklaDAwbZ
 VeEbFMqw9AlHaCJ3gP1b9GR2dVnpBpgOw9PopUEnbmummgWggtPRCtWFPubzG0ROEsbt
 1GMvaAdDenCVN5zyF2jvadwZU340eEt2hfB5X17cYWK1AX3bzPnS3rIa3uNByq2xWGfI
 u4XrGolG3qpL0JO/cOUOqx1uQOX0m8EsY9/lBUy+2LpQRGu94zeWBAJkY3/pZo/4ulTp
 cQxOOyFETXsPK2AKYlg2tTWsMGs8NXXN7ZVor9NZ6ndTEBpNarMA9//3xZfw/uN7L3z9
 UWPw==
X-Gm-Message-State: AOJu0YzPnsRnfRQP/uftSScvWDfXU1Ls1gESdwnoiMUJ4u4mMHVkbnfK
 wDkR+tAgwzH3fk/bMZC2ariJpGiy5VXUjTWOr2hLTvVZa1J3rvZoay+RcCeMCY9d5AkzXIHl7Dz
 JgYsnlyzaRxAYUrAt2GIeu7YDhUIqf2M6omjmNqwaQQ==
X-Gm-Gg: AZuq6aIicS6S1Fd3YLm7M8vT078jhXuNrHGYeILxv/zRr4Efn63NX7VoP3/btDHZ99C
 I2qOZflurDIT9QLC5jXi/XoLLsXDiCRVE8bDUyjzPo6C/qc8/S4ErX5hnQY5zYZOdK1BlVhwbhL
 j0nFkB0mdzkwLcP2kebeoRRBQ7BL8P4wrPKxjA8DYZwIAHE/NB2szZ0K31wqXjl1nept8H86fS0
 Vah8H0ZUk+LGdINeha/ggpSQ7eb8IQsA1HCt6MUxjJPu6I7ysELdkL7zktNsumXOuO7PUVX
X-Received: by 2002:a05:6830:719f:b0:7c7:2e9d:aee1 with SMTP id
 46e09a7af769-7d1a532b4f3mr110332a34.19.1769705043294; Thu, 29 Jan 2026
 08:44:03 -0800 (PST)
MIME-Version: 1.0
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
 <20260129164130.GA2044980@bill-the-cat>
In-Reply-To: <20260129164130.GA2044980@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 30 Jan 2026 00:43:51 +0800
X-Gm-Features: AZwV_QiGSCQQ48ZAIlctsIX_9PuDW37v08AOK4-vFYh2OaSrpzn_K1OflCW4Y9Q
Message-ID: <CAN7C2SCYYqQviS6pJYd7KiSYvd7tJKLqHPc5tCpyuF1ckYexcA@mail.gmail.com>
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

On Fri, Jan 30, 2026 at 12:41=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Jan 30, 2026 at 12:39:17AM +0800, Sune Brian wrote:
> > On Fri, Jan 30, 2026 at 12:35=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Fri, Jan 30, 2026 at 12:29:56AM +0800, Sune Brian wrote:
> > > > On Fri, Jan 30, 2026 at 12:22=E2=80=AFAM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Fri, Jan 30, 2026 at 12:09:26AM +0800, Sune Brian wrote:
> > > > > > On Fri, Jan 30, 2026 at 12:08=E2=80=AFAM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jan 30, 2026 at 12:07:25AM +0800, Sune Brian wrote:
> > > > > > > > On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trini@ko=
nsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wrot=
e:
> > > > > > > > > > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trin=
i@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian =
wrote:
> > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <=
trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Br=
ian wrote:
> > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Ri=
ni <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sun=
e Brian wrote:
> > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM To=
m Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800,=
 Sune Brian wrote:
> > > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFP=
M Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0=
800, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=
=AFPM Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37P=
M +0800, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > The commits after c08da5d03c2a0=
b72e81a11ff7ca507e3a6414db3
> > > > > > > > > > > > > > > > > > > > > > All Cyclone V boards are unable=
 to boot, not sure this patch is the fix?
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Yes, those commits were unintenti=
onal and have been reverted.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Had tested the last commit 6a1bdb7e=
952d5841f42742fefa907cae5dc8d50a
> > > > > > > > > > > > > > > > > > > > Same situation that the boards are =
unable to enter the SPL phase.
> > > > > > > > > > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d85=
63db135c167077ec works properly.
> > > > > > > > > > > > > > > > > > > > After that things are broken.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Please give
> > > > > > > > > > > > > > > > > > > https://patchwork.ozlabs.org/project/=
uboot/patch/20260129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > > > > > > > > > a try as I think it might have been w=
orking before by alignment luck
> > > > > > > > > > > > > > > > > > > rather than design.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > It is the revert itself that is broken.
> > > > > > > > > > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c62218=
76e00a03c2
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-=
dirty (Jan 29 2026 - 22:56:17 +0800)
> > > > > > > > > > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Which revert is correct.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > But once dc2d8423b19d30472b02e02b415042=
26908a4291
> > > > > > > > > > > > > > > > > > And revert to 431f1ce46bbffff0db8f03437=
a34400b11b30175
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Then all these broken I don't understan=
d why even file diff cannot
> > > > > > > > > > > > > > > > > > show any changes.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Do you mean the revert is broken and fi=
xed by alignment?
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I mean that arbitrary changes (as part of=
 testing these things, the
> > > > > > > > > > > > > > > > > "-dirty" in the version string would lead=
 to failing trees now passing)
> > > > > > > > > > > > > > > > > can make the difference between pass/fail=
 to boot. Did you try Marek's
> > > > > > > > > > > > > > > > > patch I linked to?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yes, I had tried. Cannot boot same as I had=
 mentioned failing commit #.
> > > > > > > > > > > > > > > > I apply that patch on the latest master com=
mit.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The other, maybe, thing is you need a bigger =
SPL_SYS_MALLOC_F_LEN ?
> > > > > > > > > > > > > > > Otherwise, you'll need to dig more and see wh=
y the device tree isn't
> > > > > > > > > > > > > > > being found where expected on your platform, =
and possibly where it is
> > > > > > > > > > > > > > > instead.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > No the failing point is done after
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > > > > > > Revert "arm: spl: Correct alignment of .rel.dyn=
 section"
> > > > > > > > > > > > > > This reverts commit 380ddb4. Signed-off-by: Tom=
 Rini <trini@konsulko.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This commit I tried to boot and works..
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Then this commit
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > > > > > count rel_dyn
> > > > > > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I manually replaced the old Makefile.xpl and al=
so worked it boot.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Revert a number of incorrect commits
> > > > > > > > > > > > > > As part of debugging the appended device tree f=
ailure, I inadvertently
> > > > > > > > > > > > > > committed some changes as I was debugging to ma=
ster, and not a private
> > > > > > > > > > > > > > branch, and pushed them as part of the release.=
 This reverts commit
> > > > > > > > > > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rin=
i <trini@konsulko.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This is the point that everything no longer boo=
ts.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But between those commits there are no extra co=
des.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > After that all things no longer work.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, and I need you to investigate your failure c=
ase here. There is no
> > > > > > > > > > > > > code change between a working commit and a failin=
g commit, which leads
> > > > > > > > > > > > > me to the suggestions I gave for debugging.
> > > > > > > > > > > >
> > > > > > > > > > > > I even tried a fresh clone from https://github.com/=
u-boot/u-boot.
> > > > > > > > > > > > Same situation.
> > > > > > > > > > > > I don't understand.
> > > > > > > > > > > > The commit missed or messed up?
> > > > > > > > > > >
> > > > > > > > > > > You need to look at the resulting binaries and see wh=
y the device tree
> > > > > > > > > > > is not where it's expected to be.
> > > > > > > > > > >
> > > > > > > > > > > You might find it helpful looking through
> > > > > > > > > > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQ=
Ln8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com/
> > > > > > > > > > > for some ideas.
> > > > > > > > > >
> > > > > > > > > > So you are suggesting even the commit between revert co=
uld introduce this issue?
> > > > > > > > > > Aren't the revert only applied to two changes?
> > > > > > > > >
> > > > > > > > > What I'm saying is that the underlying issue is that the =
device tree is
> > > > > > > > > not where it's expected to be. The likely root cause is t=
hat we now
> > > > > > > > > require the device tree to be (correctly!) 8 byte aligned=
 in memory and
> > > > > > > > > not 4 byte aligned. In the case of appending a device tre=
e to our binary
> > > > > > > > > any sort of change in the code can change the size of the=
 binary and in
> > > > > > > > > turn mean that the address where the device tree is ends =
up being at a
> > > > > > > > > different alignment.
> > > > > > > >
> > > > > > > > You are correct on this, but I don't understand why even re=
verting to
> > > > > > > > two code changes
> > > > > > > > could introduce this issue.
> > > > > > > >
> > > > > > > > The revert also included other commits?
> > > > > > > >
> > > > > > > > "
> > > > > > > > Revert a number of incorrect commits
> > > > > > > > As part of debugging the appended device tree failure, I in=
advertently
> > > > > > > > committed some changes as I was debugging to master, and no=
t a private
> > > > > > > > branch, and pushed them as part of the release. This revert=
s commit
> > > > > > > > dc2d842 through 380ddb4.
> > > > > > > > "
> > > > > > > >
> > > > > > > > This is my debug case:
> > > > > > > >
> > > > > > > > Correct boot:
> > > > > > > > hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
> > > > > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed =
 |..pGo...pG......|
> > > > > > > > 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8 =
 |................|
> > > > > > > >
> > > > > > > > Fail boot:
> > > > > > > > hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> > > > > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed =
 |..pGo...pG......|
> > > > > > > > 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed =
 |................|
> > > > > > >
> > > > > > > Yup, so it's mis-aligned. I guess can you tell me what the de=
fconfig
> > > > > > > you're using is?
> > > > > >
> > > > > > socfpga_cyclone5_defconfig
> > > > >
> > > > > You might need to do some debugging yourself on this. Is that als=
o where
> > > > > __bss_end is? This looks like the exact case that
> > > > > 5ffc1dcc26d3df9e2b192151936cb98014fb6e49 should have fixed. And l=
ocally,
> > > > > I see it being aligned, and then also just making a trival change=
 (git
> > > > > tree is dirty) that used to lead to mis-alignment, retaining alig=
nment.
> > > >
> > > > I have a question I still don't understand.
> > > > The example you gave me is even earlier than
> > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2.
> > > > But build on f4dfa5d3c2680322fd17fcc7c6221876e00a03c2 can boot norm=
ally.
> > > > So what 431f1ce46bbffff0db8f03437a34400b11b30175 actually reverted =
and
> > > > could introduce this shift from first place.
> > > >
> > > > I really need this to clear out for me to debug the issue.
> > >
> > > You might need to build with V=3D1 and see what's being generated to =
go in
> > > to the binary file, and look at spl/u-boot-spl.map to see if things l=
ike
> > > __bss_end match. You need to ignore the 3 commits I reverted because

For the __bss_end:

Boot case:

hexdump -Cv u-boot-spl.sfp | grep 'd0 0d fe ed'
00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG....=
..|
0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |..............=
..|

arm-none-eabi-readelf -s spl/u-boot-spl  | grep __bss_end
  1196: ffffbeb8     0 NOTYPE  GLOBAL DEFAULT    6 __bss_end

This makes sense to me because it matched.

Fail boot cas:

hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG....=
..|
0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |..............=
..|

arm-none-eabi-readelf -s spl/u-boot-spl  | grep __bss_end
  1196: ffffbeb8     0 NOTYPE  GLOBAL DEFAULT    6 __bss_end

So this is indeed broken as it now should be beb'C'?

Where to change this may I ask?

Thanks,
Brian


> > > they were debug things that did not work. They change behavior becaus=
e
> > > they make changes in the linker scripts and so change alignments.
> >
> > Yes this is understood for debugging but even reverting and only buildi=
ng at
> > the reverted commit fails to boot properly this is what I am kept menti=
oning.
> >
> > This is why I don't understand how could no code change can even shift =
or
> > change the build result this is not possible or I really missed hidden
> > revert commit
> > from the first place.
>
> The state of the git tree can result in the version string changing and
> so change the binary.
>
> --
> Tom
