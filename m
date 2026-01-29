Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C6ED6B095
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B34A683FFF;
	Thu, 29 Jan 2026 17:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YnkxLb7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD7683A64; Thu, 29 Jan 2026 17:39:33 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5075F83FFF
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d1959ba05cso477412a34.2
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:39:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769704769; cv=none;
 d=google.com; s=arc-20240605;
 b=EsSL4msZ8WKv9mVfDaFeJOCTnF6gLn6w/LN/ymzv0iLEdSl8l2gLOEdCPXyfy8l9OS
 KKSQ2PVNAr8oeDigtYOHLziEqa2yIHHRPACneJz520m+D2aUJQeqV6xuu5m+9wLYMz5e
 Dmqpr4oNUginkA0nw1cUWewgTKi1gMHYhv71LzDlZDt2zt/AUuW7TLgMfKcmItKUnNvk
 6fb4zEdcDDK1tuKYD6dimVwp2RnjkBHTwY0upPcd/+Mssvcp8wBzBbupCN3Lpq/OXcds
 dVe0eGpYkiQXiBqVfQtbO1DeJetveGs//ISo8TXmvvPye21fvGWC7nxCJYgL7L3f3Msj
 JPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OTe2GIdmmfheoCL99tnJ1R+oTXObiIcmnzClUIDt8Ks=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=h8p4kRxD9Cok5kfSkG47md7nSPqq539qnauvG+Lfj+cvyfRQA7wAoJMZUTSumxqNr9
 /uvuc8dqb9ijyDBV8Z8TyEAecwA51Utn6tgwzddfapt1+w+rr/TnCoOow6NkN0cP6U/y
 yxpR0a7OfdWZgfVN8oyPo1I8bBYaq+b77SwOLIgYoCbDg0PIsOc+85haJ5t/j9jmZW9l
 /TcFLT2qOEuPwNVUfSBnPZA6l7VMgY6WNQoYu2WJzhPr1u+AYKQubSI+6HgwIwVPa5Vr
 ceEICvYnCU+8w+9X6Cu7ugyOEYlGIOEbt7zYYlt/jYZkzIUXiGwQdPtE9yopdRVX/Q+c
 C9gg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769704769; x=1770309569; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTe2GIdmmfheoCL99tnJ1R+oTXObiIcmnzClUIDt8Ks=;
 b=YnkxLb7FgBI/Oddi0cqKGE+OTg/PIvAHA9LUzEKOXXvOxS07jYMOakzkmdOJsbu+Iw
 DbBHnmMbbC3uNlLz8Kj6kgOQ9QensdsSIALDUOPxANFXCPl9YkwKYEY25j4U5QvXCsiV
 IVUnmHoQ39zvwzhDFPB3CCtXlvSPMJt/R/htC5KY8nD16l0vQl1iQxUzk9j/GO5uM/wD
 YJ9cEedfi4BOEemtEgYk+oXZhFPBSu0Qi1ZyivIaS8c8CYv6ZHGtSRCH79EQWoxsKqON
 CAsV7XNTKotW12i7pcfa16LShxjpvnkV0LyWzlxxU2x07VCjsfkA8KgDh3rLsMPl5XES
 NbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704769; x=1770309569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OTe2GIdmmfheoCL99tnJ1R+oTXObiIcmnzClUIDt8Ks=;
 b=INS/XDFkYeChH6Gq0B6CZ0sS1qrcxYidSj2tKxfjiCtBopqPZZ49fmrdZat1wDRCXV
 nRRKQO0KxwhZGyCon7VBbUaL3Nq0JarbGb6xpbj/XA7QeFruLBoafI/nZTEj76Bsz556
 +npwNx2DoTp6Nsv/IzNM5fjyBRxkBIfqDNLM6udUIt9duVvajWy4/sd9xhmTIVaXC4hV
 EpxRmsTPDZtuoysqsaSXe86G4wxW86oSQVf+PhRDTAzF0nW4gY3df8rrWCuDmFz4NkpN
 UmTXq8l2tKg3ehNh6KkGausXJFSjn0daE7c1TXJktrSRa5/hloSJrkFzA1St3IWbZqAL
 xjFQ==
X-Gm-Message-State: AOJu0YzLTwM6Q4R4Z6CPzE/iTUSvPeQ8s8XnJkgV4bXMnLD3jef0Lt+w
 E1M4Jjs/iI6HmXK05a62/tv2Ce62ThYSbwrM5zOjWTghIpeQ9Zne/UuHyOxl7xTv33QvsRUDtPQ
 Orbxk4Q1juuuePa2Q8zoZDifLdj7XXFo=
X-Gm-Gg: AZuq6aLdTIiVeOrR78CYjl2YTCVMQSIjOV1EacqmeNqlzE8ti+UB4d8G3kA6c5zcSWl
 rOgUdkpSWAWYXcSXBrkaxfK+mr+xmUBqCm9DgEF6wqOEshGjK2joSl4xPvwDv4D/8YmHgY0Ve4N
 c5JKGw3c4rgLR3EkTf8UZvjhpFadyvAa+vQjOVCPGLovik68iTK2twnHtGWSp7gNzp0ps8yDkFe
 7oDpBY6tct810j6I6B7Uswk0DVxCKOAP8C7Go9K1aEro7n80Xar8l5u0KTnc/TgG3bTy2R8
X-Received: by 2002:a05:6830:81f8:b0:7ce:2b15:de88 with SMTP id
 46e09a7af769-7d1a531bd6dmr74222a34.26.1769704768805; Thu, 29 Jan 2026
 08:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20260129153407.GX3416603@bill-the-cat>
 <CAN7C2SCV499EAw4f__HEefgh71NfEckd9PQ_G-ZHtDTQbjoRTw@mail.gmail.com>
 <20260129154646.GY3416603@bill-the-cat>
 <CAN7C2SDFkeg8Q=SFjRBBx4LctMPOvj8U0+TdmxfEuvHNp5w5BQ@mail.gmail.com>
 <20260129160315.GZ3416603@bill-the-cat>
 <CAN7C2SDZ9fO-BsjcRj638LtR5QYWUt+PjOyXvao9aXS+J9Pnzw@mail.gmail.com>
 <20260129160830.GA3416603@bill-the-cat>
 <CAN7C2SB0+kNYjho=LDKASfqddgQeCYXu0hhPeK62menTR6VW1Q@mail.gmail.com>
 <20260129162226.GB3416603@bill-the-cat>
 <CAN7C2SC8ZCcD_F4W_R_Ww02px7AV4hOv1WnrOpvKoVnU14gFLA@mail.gmail.com>
 <20260129163540.GA2043007@bill-the-cat>
In-Reply-To: <20260129163540.GA2043007@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 30 Jan 2026 00:39:17 +0800
X-Gm-Features: AZwV_QjFsWq8oYBSqGyO-M1wilK791P99bTyKwg1Bee2UtIKLhXAzed14R4GLIo
Message-ID: <CAN7C2SBwwLrsrHgkS82oGuWZf8K1O9+UgZHOuvsco3ExCMD0Fw@mail.gmail.com>
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

On Fri, Jan 30, 2026 at 12:35=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Jan 30, 2026 at 12:29:56AM +0800, Sune Brian wrote:
> > On Fri, Jan 30, 2026 at 12:22=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Fri, Jan 30, 2026 at 12:09:26AM +0800, Sune Brian wrote:
> > > > On Fri, Jan 30, 2026 at 12:08=E2=80=AFAM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Fri, Jan 30, 2026 at 12:07:25AM +0800, Sune Brian wrote:
> > > > > > On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wrote:
> > > > > > > > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trini@ko=
nsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wrot=
e:
> > > > > > > > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trin=
i@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian =
wrote:
> > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <=
trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Br=
ian wrote:
> > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Ri=
ni <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sun=
e Brian wrote:
> > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM To=
m Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800,=
 Sune Brian wrote:
> > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFP=
M Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0=
800, Sune Brian wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > The commits after c08da5d03c2a0b72e=
81a11ff7ca507e3a6414db3
> > > > > > > > > > > > > > > > > > > > All Cyclone V boards are unable to =
boot, not sure this patch is the fix?
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Yes, those commits were unintentional=
 and have been reverted.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Had tested the last commit 6a1bdb7e952d=
5841f42742fefa907cae5dc8d50a
> > > > > > > > > > > > > > > > > > Same situation that the boards are unab=
le to enter the SPL phase.
> > > > > > > > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db=
135c167077ec works properly.
> > > > > > > > > > > > > > > > > > After that things are broken.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Please give
> > > > > > > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboo=
t/patch/20260129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > > > > > > > a try as I think it might have been worki=
ng before by alignment luck
> > > > > > > > > > > > > > > > > rather than design.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > It is the revert itself that is broken.
> > > > > > > > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e0=
0a03c2
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirt=
y (Jan 29 2026 - 22:56:17 +0800)
> > > > > > > > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Which revert is correct.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > But once dc2d8423b19d30472b02e02b4150422690=
8a4291
> > > > > > > > > > > > > > > > And revert to 431f1ce46bbffff0db8f03437a344=
00b11b30175
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Then all these broken I don't understand wh=
y even file diff cannot
> > > > > > > > > > > > > > > > show any changes.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Do you mean the revert is broken and fixed =
by alignment?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I mean that arbitrary changes (as part of tes=
ting these things, the
> > > > > > > > > > > > > > > "-dirty" in the version string would lead to =
failing trees now passing)
> > > > > > > > > > > > > > > can make the difference between pass/fail to =
boot. Did you try Marek's
> > > > > > > > > > > > > > > patch I linked to?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, I had tried. Cannot boot same as I had men=
tioned failing commit #.
> > > > > > > > > > > > > > I apply that patch on the latest master commit.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The other, maybe, thing is you need a bigger SPL_=
SYS_MALLOC_F_LEN ?
> > > > > > > > > > > > > Otherwise, you'll need to dig more and see why th=
e device tree isn't
> > > > > > > > > > > > > being found where expected on your platform, and =
possibly where it is
> > > > > > > > > > > > > instead.
> > > > > > > > > > > >
> > > > > > > > > > > > No the failing point is done after
> > > > > > > > > > > >
> > > > > > > > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > > > > Revert "arm: spl: Correct alignment of .rel.dyn sec=
tion"
> > > > > > > > > > > > This reverts commit 380ddb4. Signed-off-by: Tom Rin=
i <trini@konsulko.com>
> > > > > > > > > > > >
> > > > > > > > > > > > This commit I tried to boot and works..
> > > > > > > > > > > >
> > > > > > > > > > > > Then this commit
> > > > > > > > > > > >
> > > > > > > > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > > > count rel_dyn
> > > > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > >
> > > > > > > > > > > > I manually replaced the old Makefile.xpl and also w=
orked it boot.
> > > > > > > > > > > >
> > > > > > > > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > > > > > >
> > > > > > > > > > > > Revert a number of incorrect commits
> > > > > > > > > > > > As part of debugging the appended device tree failu=
re, I inadvertently
> > > > > > > > > > > > committed some changes as I was debugging to master=
, and not a private
> > > > > > > > > > > > branch, and pushed them as part of the release. Thi=
s reverts commit
> > > > > > > > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <t=
rini@konsulko.com>
> > > > > > > > > > > >
> > > > > > > > > > > > This is the point that everything no longer boots.
> > > > > > > > > > > >
> > > > > > > > > > > > But between those commits there are no extra codes.
> > > > > > > > > > > >
> > > > > > > > > > > > After that all things no longer work.
> > > > > > > > > > >
> > > > > > > > > > > Yes, and I need you to investigate your failure case =
here. There is no
> > > > > > > > > > > code change between a working commit and a failing co=
mmit, which leads
> > > > > > > > > > > me to the suggestions I gave for debugging.
> > > > > > > > > >
> > > > > > > > > > I even tried a fresh clone from https://github.com/u-bo=
ot/u-boot.
> > > > > > > > > > Same situation.
> > > > > > > > > > I don't understand.
> > > > > > > > > > The commit missed or messed up?
> > > > > > > > >
> > > > > > > > > You need to look at the resulting binaries and see why th=
e device tree
> > > > > > > > > is not where it's expected to be.
> > > > > > > > >
> > > > > > > > > You might find it helpful looking through
> > > > > > > > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn8Q=
52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com/
> > > > > > > > > for some ideas.
> > > > > > > >
> > > > > > > > So you are suggesting even the commit between revert could =
introduce this issue?
> > > > > > > > Aren't the revert only applied to two changes?
> > > > > > >
> > > > > > > What I'm saying is that the underlying issue is that the devi=
ce tree is
> > > > > > > not where it's expected to be. The likely root cause is that =
we now
> > > > > > > require the device tree to be (correctly!) 8 byte aligned in =
memory and
> > > > > > > not 4 byte aligned. In the case of appending a device tree to=
 our binary
> > > > > > > any sort of change in the code can change the size of the bin=
ary and in
> > > > > > > turn mean that the address where the device tree is ends up b=
eing at a
> > > > > > > different alignment.
> > > > > >
> > > > > > You are correct on this, but I don't understand why even revert=
ing to
> > > > > > two code changes
> > > > > > could introduce this issue.
> > > > > >
> > > > > > The revert also included other commits?
> > > > > >
> > > > > > "
> > > > > > Revert a number of incorrect commits
> > > > > > As part of debugging the appended device tree failure, I inadve=
rtently
> > > > > > committed some changes as I was debugging to master, and not a =
private
> > > > > > branch, and pushed them as part of the release. This reverts co=
mmit
> > > > > > dc2d842 through 380ddb4.
> > > > > > "
> > > > > >
> > > > > > This is my debug case:
> > > > > >
> > > > > > Correct boot:
> > > > > > hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
> > > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..=
pGo...pG......|
> > > > > > 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |..=
..............|
> > > > > >
> > > > > > Fail boot:
> > > > > > hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> > > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..=
pGo...pG......|
> > > > > > 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |..=
..............|
> > > > >
> > > > > Yup, so it's mis-aligned. I guess can you tell me what the defcon=
fig
> > > > > you're using is?
> > > >
> > > > socfpga_cyclone5_defconfig
> > >
> > > You might need to do some debugging yourself on this. Is that also wh=
ere
> > > __bss_end is? This looks like the exact case that
> > > 5ffc1dcc26d3df9e2b192151936cb98014fb6e49 should have fixed. And local=
ly,
> > > I see it being aligned, and then also just making a trival change (gi=
t
> > > tree is dirty) that used to lead to mis-alignment, retaining alignmen=
t.
> >
> > I have a question I still don't understand.
> > The example you gave me is even earlier than
> > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2.
> > But build on f4dfa5d3c2680322fd17fcc7c6221876e00a03c2 can boot normally=
.
> > So what 431f1ce46bbffff0db8f03437a34400b11b30175 actually reverted and
> > could introduce this shift from first place.
> >
> > I really need this to clear out for me to debug the issue.
>
> You might need to build with V=3D1 and see what's being generated to go i=
n
> to the binary file, and look at spl/u-boot-spl.map to see if things like
> __bss_end match. You need to ignore the 3 commits I reverted because
> they were debug things that did not work. They change behavior because
> they make changes in the linker scripts and so change alignments.

Yes this is understood for debugging but even reverting and only building a=
t
the reverted commit fails to boot properly this is what I am kept mentionin=
g.

This is why I don't understand how could no code change can even shift or
change the build result this is not possible or I really missed hidden
revert commit
from the first place.

>
> --
> Tom
