Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB82D6B086
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C4183FED;
	Thu, 29 Jan 2026 17:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lho698x/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98DF683FED; Thu, 29 Jan 2026 17:07:41 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0793C83E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7cfca52ac2dso703997a34.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:07:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769702858; cv=none;
 d=google.com; s=arc-20240605;
 b=OHnWbv6SErlzdhXiX3JldScqRd6iBtnP1QEvL5I6Xf72AatJ97UHacKW3IOvOT7ZRF
 yvaZb25WOei0YSBOAydC6e4BNqwLXtGBBBUjzwCBSSebkIPdHSRlLolcs9oDwxAhyEgg
 Pra4FlobgasqEdU352cNekMGaZ7iqhrMjVBUVlmgnrWe0TwRhA/uDl5VVM8vMOTwfJgk
 AzRIip6EMTml8I9Lg/5Jwf5HnC2ascQ3UC4MKVbs2otl2J9Hxo86Gg4fCQ38WnUtMfuG
 oiV+ctoqe+wOmmDJt9Ch6qiwMoZltxz+oaPG3EJWaUKqnAGQybkT460H/zmXtwpgNMMr
 yRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DNGaJuJ23aB2PtnrWJY5uGel+Eml5wx7aSQiys44rJI=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=GwoDAGWUcYIsuvkExmBxB3H+zf5iNxvmQi0xdZ+PwfUxi9vG3aoUOio9yawryMp8M8
 FlbrREBcJSNDo1yFEvZ6vWNbVxrBXHBXU6e7Y1CvVbsAQfMJH7uXI3/SNj9cFIuaz25u
 BnOvkbX8727LNK97vZ36Vw1NogD9tajB43jO+4smTktjxF4EmnVBL7q7P8idmGsSTm/O
 KmXWIZnrhxrfFpmePe+GjIbkN59yo1fc2iOxgXYA19fx1KHyPeD2s7XynCfd6jP7YXOC
 /GHyDtEOEWJJo+WN++zyQdCJ9gQXcsfpocTD25IRBmfTxOa/7a+N0r/pm5bdthdLbpAo
 FGog==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769702858; x=1770307658; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNGaJuJ23aB2PtnrWJY5uGel+Eml5wx7aSQiys44rJI=;
 b=Lho698x/abw+vJWTPkkhkkwCoiv4xoMGvA05hRkReRFvaIgFKtIIcwD/xD0HHxn6me
 99xO1F4kIRTWrtl8UU5UAs1QaPWeYH3WI1BF9uRUwjwGtVxqSimZAYrfrvIhKoQmU06d
 05KKKC8rcxNBZMs9VUaip4kgA8gpL7jIana4Fjqp2h+pv1AagIHmatMo8vHv3XXJ94AG
 JkFHrdYBAXkpYpQuJBOfvhnk3KgFslJzSn8qO8MxjuMLkb3ry6jEsMrKMYu0nAGP8fdS
 do87pE5YTKIhVfMBRBBRzYEoJCVpUF7GCZBfu58DrGmqAm/AoBR0Es49DnwrFHgKURi8
 vdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702858; x=1770307658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DNGaJuJ23aB2PtnrWJY5uGel+Eml5wx7aSQiys44rJI=;
 b=J4YC9nwaaRS1GVP5CV+Bqk7aLMfbGn02XQ+iFSnOJWxWvN9w+fNj4q238ZP+UTtKoz
 mepqRneKlo2IETHb/kDvmAEnwQPXfSJYOUOFhmcZPxVgafd9m/I3W2r5IQWNxpI8GOnN
 /lrSOsvB+ZelAHk1WobkxbMAXvYDBNWyA+K7KJlu9lvybNX4F2CJKiupoR5xzH72R1wj
 FBHmRnBMGW4c41CI/laoQ0dBmYKQxSIRT32k9wV2/88r2YS2BwdRy03aFGA9OHRHS31f
 d436wdcpwN2muqworcxJgbqiLjm4A5pewvubojIU3TtcAK75DyotShQaTEXsy8vCrbDW
 p65Q==
X-Gm-Message-State: AOJu0YwWJZymqn4YqBJ2qMPyMHe4Vk+c9Yn4gZ+VSofO9BJUs9nZ0STj
 1tkOJIc6jL/FPz+apxoqEl5dHyFk6efrPxbR+kDoe35Lv4mjb4bcUdQs9UcCLvdeqmkTzI7Mhv5
 gmD6CSXlu7Ejpkxmr+5FG1CWuz+PPfSAj70EY3Ey43w==
X-Gm-Gg: AZuq6aIciILiJPoWV/fG+qh03g680mwSWpAmoGd3Ypk/6bsZGEqgTVsZWnQgPf4e+OU
 dsIXwmKx6U0/6KxnxdlsOjWIH5uYCd9Fqkw4u81UgzsxMA9B92aTZ2v6O9+6EmKt3X/dr6NiAv5
 ksFwoqtTv1IzSmeVbMtAtL5ijmjLP/QW98rWS72aShs/NNAhCmQ1zElGqaaBTz1hgH4PpyFq4if
 2ZI/nGFkFR0vqpkWvSN3gUPB/GBvH2d1q1/P0cfyBXkGjx/WScVBEBOeEZWGxLiU82rCDeS
X-Received: by 2002:a05:6830:43a7:b0:7c7:827f:872f with SMTP id
 46e09a7af769-7d1a53426f1mr56975a34.37.1769702857520; Thu, 29 Jan 2026
 08:07:37 -0800 (PST)
MIME-Version: 1.0
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
 <20260129160315.GZ3416603@bill-the-cat>
In-Reply-To: <20260129160315.GZ3416603@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 30 Jan 2026 00:07:25 +0800
X-Gm-Features: AZwV_QgCmq1gzidLkTaQ2P1xf8lzUuOV2IGcxVGBIBjTjrossKGaME8_9e3QI4Y
Message-ID: <CAN7C2SDZ9fO-BsjcRj638LtR5QYWUt+PjOyXvao9aXS+J9Pnzw@mail.gmail.com>
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

On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wrote:
> > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wrote:
> > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wrote:
> > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wrote:
> > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@ko=
nsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wrot=
e:
> > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trin=
i@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian =
wrote:
> > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <=
trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Br=
ian wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The commits after c08da5d03c2a0b72e81a11ff7ca50=
7e3a6414db3
> > > > > > > > > > > > > > All Cyclone V boards are unable to boot, not su=
re this patch is the fix?
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > > Yes, those commits were unintentional and have be=
en reverted.
> > > > > > > > > > > >
> > > > > > > > > > > > Had tested the last commit 6a1bdb7e952d5841f42742fe=
fa907cae5dc8d50a
> > > > > > > > > > > > Same situation that the boards are unable to enter =
the SPL phase.
> > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec=
 works properly.
> > > > > > > > > > > > After that things are broken.
> > > > > > > > > > >
> > > > > > > > > > > Please give
> > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2026=
0129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > a try as I think it might have been working before by=
 alignment luck
> > > > > > > > > > > rather than design.
> > > > > > > > > >
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > It is the revert itself that is broken.
> > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 20=
26 - 22:56:17 +0800)
> > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > >
> > > > > > > > > > Which revert is correct.
> > > > > > > > > >
> > > > > > > > > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > > > >
> > > > > > > > > > Then all these broken I don't understand why even file =
diff cannot
> > > > > > > > > > show any changes.
> > > > > > > > > >
> > > > > > > > > > Do you mean the revert is broken and fixed by alignment=
?
> > > > > > > > >
> > > > > > > > > I mean that arbitrary changes (as part of testing these t=
hings, the
> > > > > > > > > "-dirty" in the version string would lead to failing tree=
s now passing)
> > > > > > > > > can make the difference between pass/fail to boot. Did yo=
u try Marek's
> > > > > > > > > patch I linked to?
> > > > > > > >
> > > > > > > > Yes, I had tried. Cannot boot same as I had mentioned faili=
ng commit #.
> > > > > > > > I apply that patch on the latest master commit.
> > > > > > >
> > > > > > > The other, maybe, thing is you need a bigger SPL_SYS_MALLOC_F=
_LEN ?
> > > > > > > Otherwise, you'll need to dig more and see why the device tre=
e isn't
> > > > > > > being found where expected on your platform, and possibly whe=
re it is
> > > > > > > instead.
> > > > > >
> > > > > > No the failing point is done after
> > > > > >
> > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > Revert "arm: spl: Correct alignment of .rel.dyn section"
> > > > > > This reverts commit 380ddb4. Signed-off-by: Tom Rini <trini@kon=
sulko.com>
> > > > > >
> > > > > > This commit I tried to boot and works..
> > > > > >
> > > > > > Then this commit
> > > > > >
> > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > count rel_dyn
> > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > >
> > > > > > I manually replaced the old Makefile.xpl and also worked it boo=
t.
> > > > > >
> > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > >
> > > > > > Revert a number of incorrect commits
> > > > > > As part of debugging the appended device tree failure, I inadve=
rtently
> > > > > > committed some changes as I was debugging to master, and not a =
private
> > > > > > branch, and pushed them as part of the release. This reverts co=
mmit
> > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini@konsulk=
o.com>
> > > > > >
> > > > > > This is the point that everything no longer boots.
> > > > > >
> > > > > > But between those commits there are no extra codes.
> > > > > >
> > > > > > After that all things no longer work.
> > > > >
> > > > > Yes, and I need you to investigate your failure case here. There =
is no
> > > > > code change between a working commit and a failing commit, which =
leads
> > > > > me to the suggestions I gave for debugging.
> > > >
> > > > I even tried a fresh clone from https://github.com/u-boot/u-boot.
> > > > Same situation.
> > > > I don't understand.
> > > > The commit missed or messed up?
> > >
> > > You need to look at the resulting binaries and see why the device tre=
e
> > > is not where it's expected to be.
> > >
> > > You might find it helpful looking through
> > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVK=
PXxKa8D3Cny5Q@mail.gmail.com/
> > > for some ideas.
> >
> > So you are suggesting even the commit between revert could introduce th=
is issue?
> > Aren't the revert only applied to two changes?
>
> What I'm saying is that the underlying issue is that the device tree is
> not where it's expected to be. The likely root cause is that we now
> require the device tree to be (correctly!) 8 byte aligned in memory and
> not 4 byte aligned. In the case of appending a device tree to our binary
> any sort of change in the code can change the size of the binary and in
> turn mean that the address where the device tree is ends up being at a
> different alignment.

You are correct on this, but I don't understand why even reverting to
two code changes
could introduce this issue.

The revert also included other commits?

"
Revert a number of incorrect commits
As part of debugging the appended device tree failure, I inadvertently
committed some changes as I was debugging to master, and not a private
branch, and pushed them as part of the release. This reverts commit
dc2d842 through 380ddb4.
"

This is my debug case:

Correct boot:
hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG....=
..|
0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |..............=
..|

Fail boot:
hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG....=
..|
0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |..............=
..|

Thanks,
Brian


>
> --
> Tom
