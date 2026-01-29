Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACBBD6B07A
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA61383FED;
	Thu, 29 Jan 2026 16:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UJ7QQHtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF06583FF5; Thu, 29 Jan 2026 16:59:05 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1BA83E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d1890f7ee4so730750a34.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:59:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769702342; cv=none;
 d=google.com; s=arc-20240605;
 b=gOmvrrMemZQTZRDyhUzH9MFizC1iH1Elgub/h1rqSMBPrYlEYI7XOzN4NZCuCbsTL4
 Rk6s46NDiLWCTvQy8VvRQqSj6IrVLVIUXu6jO+XCXp51lE5zE62Y9i4eQgPMJa4qS9om
 waYkqHiHomYktxN2uYm76A/jMsNuTIOKEYfln/gZ9MzCHmoha4L9STZiLlD3luN0Gvyz
 mQLQ3CejVmZJBGMwedMefq0CCRjOUjTwsrpJrB+0Bme+IETzDmHTVVJMCPvBoH+xRnll
 W6BOk79w6AxvY09ALJwGj68ruH1v9ibamXhcB0614ECUFcw946st+spcFhALkTc/we/g
 wKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ddywhL7Vs/oMYUaqp6ZEHrn9tswPltdTF9V6aoyOr1o=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=fIqXlmiIwS7AgdRqlOix15vIWJ0G5AeDKKqVuvjgSEB0e0z2DV6N95nHAom7YqvYcZ
 vTAvHUxzAmLJC/gzBhYyIzJcoYeZZYoWwzDwrf9Ws/aNjsZcToQml49+6dYUyb4d6Sd/
 SzyXSHIxS2BbJKh6m1rgi51H43PPcGqYselh2lj6mZ9WWgr+VNgwy2HaYNyx6OnPbuww
 Md2ZTONU4ZZbZra0pgrCMl+bPWcJDwn4cYSW33PEaGydldorQ6OmCu+pCAXiBFnRJV3f
 SX4Ozy+pTr7nz2fiJuvKBdoCtj/Mr0CO2U+iYz5zWCmw9QuI01+roFCnt2OzQdXJA7RE
 lKaQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769702342; x=1770307142; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddywhL7Vs/oMYUaqp6ZEHrn9tswPltdTF9V6aoyOr1o=;
 b=UJ7QQHtAIuKOU+epYTWPVmWYW0fsX2Myicwj0WJW83l2CHt2kelVyPxwBMcgPHGhZn
 mxsWr6bQBEBQLvij4CXQw8E8tJQhpRXRYJ1WWD575BSy30/XYbVA2NC2JDYtlUCPqYxp
 Lg1DDKGw1JVx6ppCEBXLH027KWssLvatZB8LUj1raUVL/fmDZ/ks34JyX3coMit/sYSF
 SJuXzJ5YFzkzdNCHhrbWoH5ig7/c0Pk6ouivptuRhkr0qkz63JYRgi+vPGRpieeb11r3
 kW89jS5NwgioHodGLt88OzZ5IsJU4iiCeQsrTM2ihwP/4EC2vfu/1NiAPGH5JxMvhbGW
 0Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702342; x=1770307142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ddywhL7Vs/oMYUaqp6ZEHrn9tswPltdTF9V6aoyOr1o=;
 b=uqnK8j/LhyT71oVGIE3lCrxSihWrRT68PGQen/v61k/JDBdHPbqqSDdO2xGEcbgSMp
 g1nvvE0edAnmB4JOc311ULiRsYMbTLSYtMhU/4XRdb5qkpaFIOxKavKMhF+3r6WAAhnG
 ViEkvQxelUpoDp89KXr8vYtrZ+ad4q9TvMz/diFOpC2Ve+MXwUhIGCUBFn7XvCDIkJmE
 twN5iGJcQM2JNxgVodj302tROP7Y2glnQouxxffmgxwAeWV138OXwGsI9veOcUrM+CAs
 Ug57vUwKNEwgkSrEqT36K2rHZjaTOk6Rdj5jK61D3qQh7oWd6tET+sHM8HW0KmVXYUMC
 Tf0A==
X-Gm-Message-State: AOJu0Yxnk2pTO9srqagGdpHoSiekHn4KeMaIpcY2CsR6uqmilsS/H1Up
 VW6VS4AD2kv1VpaSN54b54ClQTdJnVKVcX/6hypflOKQV0t0sFTOlwkJYJDJ+F6PxfOrpI8N+YB
 j97doHgybv6syzTBap862axplbtyOHW66I3mdegs=
X-Gm-Gg: AZuq6aIb2QH7qG1kwJoam65Nw2pjazBFYttPw72t2FKbUas4QLyt/Rh3shti1PNgC1r
 M+aUXopye6OCbG6zI4vR5iXK8TmZkFznJ9az4BakCFxxaWO69Z89kMnm0xtBHsPcB92UhAEHvVb
 5CRHp5rrNitqQVHM9roR1Kj869wZIn2qrl9LmFXy/9HmD6xPdA8pHq+YK58dJfnicz9bptkWh4G
 pRvURPW5Oa9PYeeS5FwwnET8C5vxwIUCnLhVfdHIUvhFMkcAvwd6rDQKUsCamI6XEdaSgNk
X-Received: by 2002:a05:6830:6d2c:b0:7d1:9160:7b98 with SMTP id
 46e09a7af769-7d1a528bbf6mr41778a34.15.1769702341666; Thu, 29 Jan 2026
 07:59:01 -0800 (PST)
MIME-Version: 1.0
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
 <20260129154646.GY3416603@bill-the-cat>
In-Reply-To: <20260129154646.GY3416603@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 29 Jan 2026 23:58:50 +0800
X-Gm-Features: AZwV_QhybQaAWyZSoYCtQk-nPnIwHmiWBf-UGJmsQ8AJGJZz7HvvRKq_KsCN7H8
Message-ID: <CAN7C2SDFkeg8Q=SFjRBBx4LctMPOvj8U0+TdmxfEuvHNp5w5BQ@mail.gmail.com>
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

On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wrote:
> > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wrote:
> > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wrote:
> > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wrote:
> > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trini@ko=
nsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wrot=
e:
> > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trin=
i@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian =
wrote:
> > > > > > > > > > >
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a=
6414db3
> > > > > > > > > > > > All Cyclone V boards are unable to boot, not sure t=
his patch is the fix?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > > Yes, those commits were unintentional and have been r=
everted.
> > > > > > > > > >
> > > > > > > > > > Had tested the last commit 6a1bdb7e952d5841f42742fefa90=
7cae5dc8d50a
> > > > > > > > > > Same situation that the boards are unable to enter the =
SPL phase.
> > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec wor=
ks properly.
> > > > > > > > > > After that things are broken.
> > > > > > > > >
> > > > > > > > > Please give
> > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20260129=
035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > a try as I think it might have been working before by ali=
gnment luck
> > > > > > > > > rather than design.
> > > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > It is the revert itself that is broken.
> > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > >
> > > > > > > >
> > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 2026 -=
 22:56:17 +0800)
> > > > > > > > Trying to boot from MMC1
> > > > > > > >
> > > > > > > > Which revert is correct.
> > > > > > > >
> > > > > > > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > >
> > > > > > > > Then all these broken I don't understand why even file diff=
 cannot
> > > > > > > > show any changes.
> > > > > > > >
> > > > > > > > Do you mean the revert is broken and fixed by alignment?
> > > > > > >
> > > > > > > I mean that arbitrary changes (as part of testing these thing=
s, the
> > > > > > > "-dirty" in the version string would lead to failing trees no=
w passing)
> > > > > > > can make the difference between pass/fail to boot. Did you tr=
y Marek's
> > > > > > > patch I linked to?
> > > > > >
> > > > > > Yes, I had tried. Cannot boot same as I had mentioned failing c=
ommit #.
> > > > > > I apply that patch on the latest master commit.
> > > > >
> > > > > The other, maybe, thing is you need a bigger SPL_SYS_MALLOC_F_LEN=
 ?
> > > > > Otherwise, you'll need to dig more and see why the device tree is=
n't
> > > > > being found where expected on your platform, and possibly where i=
t is
> > > > > instead.
> > > >
> > > > No the failing point is done after
> > > >
> > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > Revert "arm: spl: Correct alignment of .rel.dyn section"
> > > > This reverts commit 380ddb4. Signed-off-by: Tom Rini <trini@konsulk=
o.com>
> > > >
> > > > This commit I tried to boot and works..
> > > >
> > > > Then this commit
> > > >
> > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > count rel_dyn
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > >
> > > > I manually replaced the old Makefile.xpl and also worked it boot.
> > > >
> > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > >
> > > > Revert a number of incorrect commits
> > > > As part of debugging the appended device tree failure, I inadverten=
tly
> > > > committed some changes as I was debugging to master, and not a priv=
ate
> > > > branch, and pushed them as part of the release. This reverts commit
> > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini@konsulko.co=
m>
> > > >
> > > > This is the point that everything no longer boots.
> > > >
> > > > But between those commits there are no extra codes.
> > > >
> > > > After that all things no longer work.
> > >
> > > Yes, and I need you to investigate your failure case here. There is n=
o
> > > code change between a working commit and a failing commit, which lead=
s
> > > me to the suggestions I gave for debugging.
> >
> > I even tried a fresh clone from https://github.com/u-boot/u-boot.
> > Same situation.
> > I don't understand.
> > The commit missed or messed up?
>
> You need to look at the resulting binaries and see why the device tree
> is not where it's expected to be.
>
> You might find it helpful looking through
> https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPXxK=
a8D3Cny5Q@mail.gmail.com/
> for some ideas.

So you are suggesting even the commit between revert could introduce this i=
ssue?
Aren't the revert only applied to two changes?

Thanks

>
> --
> Tom
