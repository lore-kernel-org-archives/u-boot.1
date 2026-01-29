Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA41D6B06C
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A4B83FF5;
	Thu, 29 Jan 2026 16:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iUARI0qd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E85D84010; Thu, 29 Jan 2026 16:43:17 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43F283FED
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7cfd65ea639so695737a34.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:43:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769701393; cv=none;
 d=google.com; s=arc-20240605;
 b=LFzYeCh7mGjiIiY7I7QVBtvo0xRBXP2JLCJqHjeMODIq1OMu0n9Ni9ehZRAJTxGB/9
 BdnQWbkHxTojaFkNfHidVjiGz7yerq5Mwd1kPAgaHOFRm6CaXl784wRVt68pKMN0yh3K
 7YcnzCt1Llt4Kdks3NiIcJiMCJj2ycwia5Mt97vUdQjo8szFteWsjklyI3w90JpqZf5t
 P1fjvail4oTA9kjNxNt+GwsMX40CsEaptm8mwVMTSq0NQXDI7XBbwo1VU+7LV7dCji41
 bmDmkvKCNPg5iFPvNw7z2C7PAcxUqNN1T/bfiI6wvIK8nK9UsatqVz5M8nqoNawQ9ZGq
 A9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eods0yPoHVgQYgxlSy4899GpW8AANzDtAad6Yy+VSbE=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=d2hQQnUpoEpbp+TdD0Ax9Ucd7fNzXpOg2N41ifXu/D+sUwEzyy9A9CdIYMltC6MFIw
 r9bUg1xSZ2K60/d9a0z92qzNJTIYUyCBwDuqp+FQmq9zHla2ixT6PapqNyHZtGqwJRfn
 7bEGuVA/vErBXAsNrYQgbstnz8sfGhmFYqab1C72XiXojGvQx0QjlUgUo1flprEtT3du
 sr8qkngcMa31HugiVaDaGy62lP0s7hQCPBTYQn/JwOTeImaSZEGNsNQt9SRdcLrpCn9j
 dzSTCJKqRs41ow9wbHtoIug2nRhnZrFYjMbeuT90ZilOEtS4hWX3MuSMEY2wJl6+AlNh
 8Jfw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769701393; x=1770306193; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eods0yPoHVgQYgxlSy4899GpW8AANzDtAad6Yy+VSbE=;
 b=iUARI0qdhs7jqA5DX5gC49djwmx6zbWSWaGS41t/9RVJNS31bl40t+gq8St0wYcMQS
 /Ub+SPY01s+vEC+b0FD/q9nL2I5XNu3CH3mRXX4+m4Acej7Bm/c4I/4XRD/RtzYuZx/y
 2bZh0VzH96P9UgykhWh4Y52Uco91MUYRG0eKbQUkUtDWy4A6h9XFDhPP/zGrypBiJV1Y
 TH99mP/fYoV+ejhcmIC7zvncbllPxvZebxt7o2ArPShCKh1tjLKJeU7c3i/HPmAZx18L
 AtG1dF0inpAwNU8sgzcgiBu0Z69ExnOoLZ4hQovXNBqzUsx8jla8vYKasOPSt81Moft0
 cKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769701393; x=1770306193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eods0yPoHVgQYgxlSy4899GpW8AANzDtAad6Yy+VSbE=;
 b=pzg07kUgj1fIJgNRj0kT674nsytvSgyoAKCB30QcT0UzMp5ClO6UngkGFh1Mbsvs/Q
 i0Nq4xMkY9bH4arP5sBqtZz2+kJ3FwP44il68htgfh6gUDa4mqfHYJ3AEV1qsyxSV7oT
 znV90Cj7hWKtlKqasbe5L9D+jxYuBmou4uvotjBDLwNz/DcT39zivfky0S9HIKFDr1R1
 JhdbmdagF5fenc1i8UE1ZvV0s+2Ya/66u3qwkePaHsCyVzDBlO4BPq27Ab6FESnJ2+s6
 ZWjr4sDXQemxffZzP+WnQ/8BmNW3YEFCAGg5HNEm975mF9j1+nIAnK7see5UwS5ax5VO
 5rMg==
X-Gm-Message-State: AOJu0YwOAvZ6/9eQqinm+XuI6tb3EjcEUpBMfURJIfmUbOt4Is4cBfAN
 QNLDMCQ0vSRL2w6FmjfUMc64wUPC8ZgY59/cC/NWaZVQiKmOaTQqkD4b4u7F595lE86Gczm9qBh
 fzZVrlylSD162AuZzqWdIENPiGTMEmlMUNsFXbpWqBQ==
X-Gm-Gg: AZuq6aI8J2POw6TTbn8M/3WQElv76hwYf+LW8t8Mp3qS7jzTiYFodybm74J2bPAGQDf
 MtGltQBCiMOE/nAiqnMP7nld/SeJP2Tg+Mv+mkGFkBwrpBQH+QND82FsBqYuCoBiINectnrH4ts
 h8OU3DBdENPuz84TPj7XkuIJw/5636lx+W+n0pd47lNoqpP+bCYsMRcOVKlaf/DIPL24Mh0r37Z
 mt8J/EqsD6zYuPmVavdZkEpKDeVxQh51vP6Ml/8R2OkCOHQviAEkkaoZHNMshFRMOHODvnB
X-Received: by 2002:a05:6830:67d5:b0:7cf:c69e:2a54 with SMTP id
 46e09a7af769-7d1a52e0121mr13137a34.14.1769701393536; Thu, 29 Jan 2026
 07:43:13 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
 <20260128145118.GJ3416603@bill-the-cat>
 <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
 <20260129145416.GR3416603@bill-the-cat>
 <CAN7C2SC05Gv_WKmNA-3JpEzPUBW27KuZrMOgXdMeL1vQXS_v1Q@mail.gmail.com>
 <20260129151919.GU3416603@bill-the-cat>
 <CAN7C2SBMTxqeN45RiAuz4oW9bKVUYDgJzmHH+eM0pNN3X6QpHw@mail.gmail.com>
 <20260129152644.GW3416603@bill-the-cat>
 <CAN7C2SA85pMyF_Mn4YrwQnaLD4Ks8y3Zr3RGn1hkEds6nM1SYg@mail.gmail.com>
 <20260129153407.GX3416603@bill-the-cat>
In-Reply-To: <20260129153407.GX3416603@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 29 Jan 2026 23:43:02 +0800
X-Gm-Features: AZwV_QhfIiXA2n4Uzw0Vg4i4iBrp6Fasp1xf5M8ArV8oEiojG0gz4y4sMKb6dgU
Message-ID: <CAN7C2SCV499EAw4f__HEefgh71NfEckd9PQ_G-ZHtDTQbjoRTw@mail.gmail.com>
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

On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wrote:
> > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wrote:
> > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wrote:
> > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wrote:
> > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trini@ko=
nsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wrot=
e:
> > > > > > > > >
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414=
db3
> > > > > > > > > > All Cyclone V boards are unable to boot, not sure this =
patch is the fix?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > > Yes, those commits were unintentional and have been rever=
ted.
> > > > > > > >
> > > > > > > > Had tested the last commit 6a1bdb7e952d5841f42742fefa907cae=
5dc8d50a
> > > > > > > > Same situation that the boards are unable to enter the SPL =
phase.
> > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec works p=
roperly.
> > > > > > > > After that things are broken.
> > > > > > >
> > > > > > > Please give
> > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202601290355=
12.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > a try as I think it might have been working before by alignme=
nt luck
> > > > > > > rather than design.
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > It is the revert itself that is broken.
> > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > >
> > > > > >
> > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 2026 - 22:=
56:17 +0800)
> > > > > > Trying to boot from MMC1
> > > > > >
> > > > > > Which revert is correct.
> > > > > >
> > > > > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > >
> > > > > > Then all these broken I don't understand why even file diff can=
not
> > > > > > show any changes.
> > > > > >
> > > > > > Do you mean the revert is broken and fixed by alignment?
> > > > >
> > > > > I mean that arbitrary changes (as part of testing these things, t=
he
> > > > > "-dirty" in the version string would lead to failing trees now pa=
ssing)
> > > > > can make the difference between pass/fail to boot. Did you try Ma=
rek's
> > > > > patch I linked to?
> > > >
> > > > Yes, I had tried. Cannot boot same as I had mentioned failing commi=
t #.
> > > > I apply that patch on the latest master commit.
> > >
> > > The other, maybe, thing is you need a bigger SPL_SYS_MALLOC_F_LEN ?
> > > Otherwise, you'll need to dig more and see why the device tree isn't
> > > being found where expected on your platform, and possibly where it is
> > > instead.
> >
> > No the failing point is done after
> >
> > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > Revert "arm: spl: Correct alignment of .rel.dyn section"
> > This reverts commit 380ddb4. Signed-off-by: Tom Rini <trini@konsulko.co=
m>
> >
> > This commit I tried to boot and works..
> >
> > Then this commit
> >
> > dc2d8423b19d30472b02e02b41504226908a4291
> > count rel_dyn
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> >
> > I manually replaced the old Makefile.xpl and also worked it boot.
> >
> > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> >
> > Revert a number of incorrect commits
> > As part of debugging the appended device tree failure, I inadvertently
> > committed some changes as I was debugging to master, and not a private
> > branch, and pushed them as part of the release. This reverts commit
> > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini@konsulko.com>
> >
> > This is the point that everything no longer boots.
> >
> > But between those commits there are no extra codes.
> >
> > After that all things no longer work.
>
> Yes, and I need you to investigate your failure case here. There is no
> code change between a working commit and a failing commit, which leads
> me to the suggestions I gave for debugging.

I even tried a fresh clone from https://github.com/u-boot/u-boot.
Same situation.
I don't understand.
The commit missed or messed up?

Brian
>
> --
> Tom
