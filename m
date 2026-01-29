Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B5AD6B086
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F29983FED;
	Thu, 29 Jan 2026 17:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OTekMSI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FD48401F; Thu, 29 Jan 2026 17:09:41 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F77083E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d18a9d2b1aso1145491a34.2
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:09:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769702978; cv=none;
 d=google.com; s=arc-20240605;
 b=IcrlY3D0gRbh0xIoRpwiy2wprYaaqxf7n5G3WvVD5zj2izszlSqdj5PmuNA+xh5unb
 6oxCklw19nr7GoQAMXAgQAHNBhP95hzU02T0O3ESQPksIzNGoXgrLH/hnJfnS6D/Y2P7
 TQ88nd6JwA8PDvy3qACUXQi0DP/lMGzRdsxYtZxN0lZq0NGqBACp1E3kcTFcdJLvJ8Tl
 X36y0zdl2M/dlHZy/ginq4+jPT9tVzBm89o4A4B39T24kwPc6dME5vU1P5LcpzYPtWKQ
 0hTXeognLuyfMyBeJAg/giX6dRPE92jgQRNATrFnFDs1R1x0xYczQ7zREjuO+FmcxXjg
 RyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d0hz/FKseNsqLty3Z878esq3H3Uok0MKqa7MG3cfaIs=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=ahMFZ8RMx9ZSH3q2irK1MpDTkKxLJagSKnlmX4a47v1xMPzUvHuG21sPEAzTxTefb/
 Da76XNSyG2rOO2D1FL+8qc0ofs/SGTnZboQjEcW7gaef5nXU3ArhfX04Yr063waUUd/N
 MPQcBc6Tuc9ioVGZcSzMYvwFf6ongoB6wqbxryrbtOJiYnbckFtayvnWqTq8+BH8NyTZ
 3PP1c9AsWiaP3Kn1B8NA0OBc/uqt0l0T/TwMI5Vi7+BPzwqLnP5vNFt1rxnP/qbngoXO
 Jp2zGfefJ8LTm1/kyDv8AAb5UIZt0Dx57W/Ci8zOF+kG8DU7xwesHH39SRhJmf/C3Btw
 fCnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769702978; x=1770307778; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0hz/FKseNsqLty3Z878esq3H3Uok0MKqa7MG3cfaIs=;
 b=OTekMSI51hIQ+aARrtdvBXJDiiGIo6LIawpbvohjzjdqlJRaig4PWOW2sQQD+heY4A
 KziA8uim2vVuEiEvPiVH2T7A8daokY4HokRoEBdbtKiO2AQgnC3zeRsTGGvl6RMGF7CL
 NjdajXG3hnZ67A3rt3oAl1syJldT4PeX2DXBqygmcpIdDvlOeZyp4SKwS2oMDWSQynEY
 3ZDx3Lwkudf9hK/JFxp/b0SRU7tPw33+9kP7ohi57Guh+/cWP36AA0mNqzOQu5VWSikO
 uD+yKVhwzosKQwXaDuS5Nau8cJbNqCqeBTEUJ+hji9TRQ8bzqGZTUphvF7PyhLjHMQkH
 tC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702978; x=1770307778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d0hz/FKseNsqLty3Z878esq3H3Uok0MKqa7MG3cfaIs=;
 b=CaBvHrY8t0HHNBsNpaXZeRKxc0d+6xiO/K3kZYtXogYcHM997C+WhKqPJyp1cXSVNy
 iqZWPaqeuNSiGdoDuJYo+tLJLJ9QBKCSJ2IbST0v89jCzykw8M0+buKX8v0uCDWYTW+4
 ifcuSyivtRZwu97C1PKYO48/1c0FwABjj/mIuzJxZWjzeZd64sdt25Q65xrm7Pl8Ied+
 A59v4EUT5B9/eqEJLegxhqe0XUGhZJtASK/178wFZQB3UdaN6ahq+8bEr1ku88j772M8
 WCYCqcbWGhH3kn6Iqw2Wyex1NzBeekvYMGyK2CFjcTbOoNbreNhCFyscS29lKRozcmD3
 +9ag==
X-Gm-Message-State: AOJu0YwHWBT1KxK42s2WoNtIQQDGX5ZSSJzCyya1dVEQwUwifQthvf/Y
 yZnYb1Y7WTgxeusBX/2uRC5HbMaOx6m4pm8FtUvFhSPxDRaYOZKONHnor2ammPHOP55o/UEd9QA
 eHt5On22LAd6WGO5sExqvo4jm3P/wAF/YwtrjsiLuLg==
X-Gm-Gg: AZuq6aI+YAlxMJvvmf9rKsxME1i8uO80iINvVZrFoqP1NkF4CF5zBjdRiAO22+vCjLn
 sQj+Z12ot9LyVpPAnDfERAg3VIidZZeMcL1RFLTxWahNzLRPGf7PXy53uueasqvmOXQkHdlzxlX
 ggooItyN+7zW3gTq3XyiBuzsxA6yZ6iBCT8SDFOw0StnlfrQq72KGqw+ZtJWdqB6CT+5JgbXCdK
 Mil8jYUEPPj6eyjPRyF7ijJc3uRp+VlalysllKn0rzhBBELCaxpvAOOBmzdEqSW41PZQfqE
X-Received: by 2002:a05:6830:3903:b0:7cf:cd4c:347 with SMTP id
 46e09a7af769-7d1a534e73fmr37006a34.30.1769702977951; Thu, 29 Jan 2026
 08:09:37 -0800 (PST)
MIME-Version: 1.0
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
 <20260129160830.GA3416603@bill-the-cat>
In-Reply-To: <20260129160830.GA3416603@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 30 Jan 2026 00:09:26 +0800
X-Gm-Features: AZwV_QjZ3MbE4BKVJkwav0u56ShrLU48rnCGq1BipQbOT11V1mAMD3cUYMmAdPA
Message-ID: <CAN7C2SB0+kNYjho=LDKASfqddgQeCYXu0hhPeK62menTR6VW1Q@mail.gmail.com>
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

On Fri, Jan 30, 2026 at 12:08=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Jan 30, 2026 at 12:07:25AM +0800, Sune Brian wrote:
> > On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wrote:
> > > > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wrote:
> > > > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wrote:
> > > > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trini@ko=
nsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wrot=
e:
> > > > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trin=
i@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian =
wrote:
> > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <=
trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Br=
ian wrote:
> > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Ri=
ni <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sun=
e Brian wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > The commits after c08da5d03c2a0b72e81a11ff7=
ca507e3a6414db3
> > > > > > > > > > > > > > > > All Cyclone V boards are unable to boot, no=
t sure this patch is the fix?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, those commits were unintentional and hav=
e been reverted.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Had tested the last commit 6a1bdb7e952d5841f427=
42fefa907cae5dc8d50a
> > > > > > > > > > > > > > Same situation that the boards are unable to en=
ter the SPL phase.
> > > > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c1670=
77ec works properly.
> > > > > > > > > > > > > > After that things are broken.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Please give
> > > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/=
20260129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > > > a try as I think it might have been working befor=
e by alignment luck
> > > > > > > > > > > > > rather than design.
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > It is the revert itself that is broken.
> > > > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 2=
9 2026 - 22:56:17 +0800)
> > > > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > > > >
> > > > > > > > > > > > Which revert is correct.
> > > > > > > > > > > >
> > > > > > > > > > > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > > > And revert to 431f1ce46bbffff0db8f03437a34400b11b30=
175
> > > > > > > > > > > >
> > > > > > > > > > > > Then all these broken I don't understand why even f=
ile diff cannot
> > > > > > > > > > > > show any changes.
> > > > > > > > > > > >
> > > > > > > > > > > > Do you mean the revert is broken and fixed by align=
ment?
> > > > > > > > > > >
> > > > > > > > > > > I mean that arbitrary changes (as part of testing the=
se things, the
> > > > > > > > > > > "-dirty" in the version string would lead to failing =
trees now passing)
> > > > > > > > > > > can make the difference between pass/fail to boot. Di=
d you try Marek's
> > > > > > > > > > > patch I linked to?
> > > > > > > > > >
> > > > > > > > > > Yes, I had tried. Cannot boot same as I had mentioned f=
ailing commit #.
> > > > > > > > > > I apply that patch on the latest master commit.
> > > > > > > > >
> > > > > > > > > The other, maybe, thing is you need a bigger SPL_SYS_MALL=
OC_F_LEN ?
> > > > > > > > > Otherwise, you'll need to dig more and see why the device=
 tree isn't
> > > > > > > > > being found where expected on your platform, and possibly=
 where it is
> > > > > > > > > instead.
> > > > > > > >
> > > > > > > > No the failing point is done after
> > > > > > > >
> > > > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > Revert "arm: spl: Correct alignment of .rel.dyn section"
> > > > > > > > This reverts commit 380ddb4. Signed-off-by: Tom Rini <trini=
@konsulko.com>
> > > > > > > >
> > > > > > > > This commit I tried to boot and works..
> > > > > > > >
> > > > > > > > Then this commit
> > > > > > > >
> > > > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > count rel_dyn
> > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > >
> > > > > > > > I manually replaced the old Makefile.xpl and also worked it=
 boot.
> > > > > > > >
> > > > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > >
> > > > > > > > Revert a number of incorrect commits
> > > > > > > > As part of debugging the appended device tree failure, I in=
advertently
> > > > > > > > committed some changes as I was debugging to master, and no=
t a private
> > > > > > > > branch, and pushed them as part of the release. This revert=
s commit
> > > > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini@kon=
sulko.com>
> > > > > > > >
> > > > > > > > This is the point that everything no longer boots.
> > > > > > > >
> > > > > > > > But between those commits there are no extra codes.
> > > > > > > >
> > > > > > > > After that all things no longer work.
> > > > > > >
> > > > > > > Yes, and I need you to investigate your failure case here. Th=
ere is no
> > > > > > > code change between a working commit and a failing commit, wh=
ich leads
> > > > > > > me to the suggestions I gave for debugging.
> > > > > >
> > > > > > I even tried a fresh clone from https://github.com/u-boot/u-boo=
t.
> > > > > > Same situation.
> > > > > > I don't understand.
> > > > > > The commit missed or messed up?
> > > > >
> > > > > You need to look at the resulting binaries and see why the device=
 tree
> > > > > is not where it's expected to be.
> > > > >
> > > > > You might find it helpful looking through
> > > > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKj=
bqVKPXxKa8D3Cny5Q@mail.gmail.com/
> > > > > for some ideas.
> > > >
> > > > So you are suggesting even the commit between revert could introduc=
e this issue?
> > > > Aren't the revert only applied to two changes?
> > >
> > > What I'm saying is that the underlying issue is that the device tree =
is
> > > not where it's expected to be. The likely root cause is that we now
> > > require the device tree to be (correctly!) 8 byte aligned in memory a=
nd
> > > not 4 byte aligned. In the case of appending a device tree to our bin=
ary
> > > any sort of change in the code can change the size of the binary and =
in
> > > turn mean that the address where the device tree is ends up being at =
a
> > > different alignment.
> >
> > You are correct on this, but I don't understand why even reverting to
> > two code changes
> > could introduce this issue.
> >
> > The revert also included other commits?
> >
> > "
> > Revert a number of incorrect commits
> > As part of debugging the appended device tree failure, I inadvertently
> > committed some changes as I was debugging to master, and not a private
> > branch, and pushed them as part of the release. This reverts commit
> > dc2d842 through 380ddb4.
> > "
> >
> > This is my debug case:
> >
> > Correct boot:
> > hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
> > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG=
......|
> > 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |..........=
......|
> >
> > Fail boot:
> > hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG=
......|
> > 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |..........=
......|
>
> Yup, so it's mis-aligned. I guess can you tell me what the defconfig
> you're using is?

socfpga_cyclone5_defconfig

Brian

>
> --
> Tom
