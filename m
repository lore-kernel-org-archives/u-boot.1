Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E120AD6B08D
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62BEC8401A;
	Thu, 29 Jan 2026 17:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZGxGZiAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A5B18404D; Thu, 29 Jan 2026 17:35:47 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9448783FFF
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45f053b7b90so738859b6e.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769704543; x=1770309343; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zCyPCSDxVR0wUVuo4TGcClWET7N3r8vQ9pj9kPP9g10=;
 b=ZGxGZiADgicQY3gdB6KgyjO6HPXbKJ8QpLt2nqWrz1PDcWmIjKUjbS3nu08eazMtgo
 ydfTexp2zNri1H+7ZwVeiD8FuHlQ9j7qBmQIVv4LB4bRnowXU0CxazpqvysxGmg247LI
 Z4TnMu+quMed/4wsbLXykX6k6hSSt5MFlKNns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704543; x=1770309343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCyPCSDxVR0wUVuo4TGcClWET7N3r8vQ9pj9kPP9g10=;
 b=gg+4IWySm3HXqkR6ckFmmcCdSoHJMGtw7YgwWfMiaRbgMOua2ZvCL5xVMbrjg13ZCQ
 NDIC0eD+5ZbyGc9EJIgtPKe1BvqLbABLVW+Ldqt7m9CHGfoPsVRoeIq3kbJT+ZcFdgmi
 iex5WO0EEPC8hQlEe7SqpLxQjDGnjtqO4JZrV0/YKG1RW9KcV5/j2pOD5iC0kv1zPhu0
 ehyp3XALxAHwgwMMUKy78yCau0kGOE50TT1hEc1JyA8Nm8xO6o8S/BlgEEvOqev6XNmY
 tdOFIE6fvVF2GG6SIYL2M2k0ZrJY9LgY26wbN+VaY26sNRYiPCXywn7kftGE+i9AU4mS
 X0nQ==
X-Gm-Message-State: AOJu0Yy1EddhVhZuUAaziYmVnIRA0UrnqpyuUq4aGJNSg4T3pDVWB2gQ
 oLjYrBOljsWOee8vVo710nFdj8n9J9ICfnYxnx1+WXkQ76nMmegiK93ZxBj5krF5leg=
X-Gm-Gg: AZuq6aLuF+b0gZrMyQ7i8PrXB9wuHoYbt2ga067JMwSRQiumzWHMqIDE9f33xsdKFJr
 jO2DNFmMKffuIO+U9DPuAB+JBwn6D3uaQ6WZiueUwKdyOAraxCJplVx1tP6jok43S370kiPtO6I
 8y9iSayFVXgiytrhItzgRg1vGiXEzDwlJyyVgO+eQrVHIslXJbrtS+0u/J27W8PJhgUA+YiRLpF
 XyupMmF/iCDlqmzoaPzvtNu9bKTSPjuJm9ICBQSNXSCDk6W+etp8ByaBXBGEz9FJS4LxslXDNJJ
 sByJHaJqyNIwBhfB8AMoRPmBWksMyaSwclzCI2iew9fg+DzGr/HaS79he90/z+rhLX4qQMnTpWD
 JjlIy1+3rSXjN08gorZG2AsluxK2/fjTEstqTHUMgom5hWRoHRK77ZmyFgVgPO6tRj3m9+usiE6
 1YjC84VdzjdZ+Iiii1/Ux9zG3W2GUoahWsBSsmG2Tc+4tY2L2zlTlClZ4Px3OTBawApG0mcsNwl
 KVWg+DfDQQmEKz+235z58949NFZpWbNy2R+hWw=
X-Received: by 2002:a05:6808:2396:b0:450:5aa0:3681 with SMTP id
 5614622812f47-45f34b4f5fcmr82686b6e.4.1769704543201; 
 Thu, 29 Jan 2026 08:35:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08f20e38sm3282813b6e.10.2026.01.29.08.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:35:42 -0800 (PST)
Date: Thu, 29 Jan 2026 10:35:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129163540.GA2043007@bill-the-cat>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cVuYejXOxMEGWRIg"
Content-Disposition: inline
In-Reply-To: <CAN7C2SC8ZCcD_F4W_R_Ww02px7AV4hOv1WnrOpvKoVnU14gFLA@mail.gmail.com>
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


--cVuYejXOxMEGWRIg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:29:56AM +0800, Sune Brian wrote:
> On Fri, Jan 30, 2026 at 12:22=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Fri, Jan 30, 2026 at 12:09:26AM +0800, Sune Brian wrote:
> > > On Fri, Jan 30, 2026 at 12:08=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Fri, Jan 30, 2026 at 12:07:25AM +0800, Sune Brian wrote:
> > > > > On Fri, Jan 30, 2026 at 12:03=E2=80=AFAM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Thu, Jan 29, 2026 at 11:58:50PM +0800, Sune Brian wrote:
> > > > > > > On Thu, Jan 29, 2026 at 11:46=E2=80=AFPM Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 29, 2026 at 11:43:02PM +0800, Sune Brian wrote:
> > > > > > > > > On Thu, Jan 29, 2026 at 11:34=E2=80=AFPM Tom Rini <trini@=
konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wr=
ote:
> > > > > > > > > > > On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <tr=
ini@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Bria=
n wrote:
> > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini=
 <trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune =
Brian wrote:
> > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom =
Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, S=
une Brian wrote:
> > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM =
Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +080=
0, Sune Brian wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > The commits after c08da5d03c2a0b72e81=
a11ff7ca507e3a6414db3
> > > > > > > > > > > > > > > > > > > All Cyclone V boards are unable to bo=
ot, not sure this patch is the fix?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Yes, those commits were unintentional a=
nd have been reverted.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Had tested the last commit 6a1bdb7e952d58=
41f42742fefa907cae5dc8d50a
> > > > > > > > > > > > > > > > > Same situation that the boards are unable=
 to enter the SPL phase.
> > > > > > > > > > > > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db13=
5c167077ec works properly.
> > > > > > > > > > > > > > > > > After that things are broken.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Please give
> > > > > > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/=
patch/20260129035512.639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > > > > > > > > > > > a try as I think it might have been working=
 before by alignment luck
> > > > > > > > > > > > > > > > rather than design.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > It is the revert itself that is broken.
> > > > > > > > > > > > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a=
03c2
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty =
(Jan 29 2026 - 22:56:17 +0800)
> > > > > > > > > > > > > > > Trying to boot from MMC1
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Which revert is correct.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > But once dc2d8423b19d30472b02e02b41504226908a=
4291
> > > > > > > > > > > > > > > And revert to 431f1ce46bbffff0db8f03437a34400=
b11b30175
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Then all these broken I don't understand why =
even file diff cannot
> > > > > > > > > > > > > > > show any changes.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Do you mean the revert is broken and fixed by=
 alignment?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I mean that arbitrary changes (as part of testi=
ng these things, the
> > > > > > > > > > > > > > "-dirty" in the version string would lead to fa=
iling trees now passing)
> > > > > > > > > > > > > > can make the difference between pass/fail to bo=
ot. Did you try Marek's
> > > > > > > > > > > > > > patch I linked to?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, I had tried. Cannot boot same as I had menti=
oned failing commit #.
> > > > > > > > > > > > > I apply that patch on the latest master commit.
> > > > > > > > > > > >
> > > > > > > > > > > > The other, maybe, thing is you need a bigger SPL_SY=
S_MALLOC_F_LEN ?
> > > > > > > > > > > > Otherwise, you'll need to dig more and see why the =
device tree isn't
> > > > > > > > > > > > being found where expected on your platform, and po=
ssibly where it is
> > > > > > > > > > > > instead.
> > > > > > > > > > >
> > > > > > > > > > > No the failing point is done after
> > > > > > > > > > >
> > > > > > > > > > > f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > > > > > > > > Revert "arm: spl: Correct alignment of .rel.dyn secti=
on"
> > > > > > > > > > > This reverts commit 380ddb4. Signed-off-by: Tom Rini =
<trini@konsulko.com>
> > > > > > > > > > >
> > > > > > > > > > > This commit I tried to boot and works..
> > > > > > > > > > >
> > > > > > > > > > > Then this commit
> > > > > > > > > > >
> > > > > > > > > > > dc2d8423b19d30472b02e02b41504226908a4291
> > > > > > > > > > > count rel_dyn
> > > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > >
> > > > > > > > > > > I manually replaced the old Makefile.xpl and also wor=
ked it boot.
> > > > > > > > > > >
> > > > > > > > > > > Then 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > > > > > > > >
> > > > > > > > > > > Revert a number of incorrect commits
> > > > > > > > > > > As part of debugging the appended device tree failure=
, I inadvertently
> > > > > > > > > > > committed some changes as I was debugging to master, =
and not a private
> > > > > > > > > > > branch, and pushed them as part of the release. This =
reverts commit
> > > > > > > > > > > dc2d842 through 380ddb4. Signed-off-by: Tom Rini <tri=
ni@konsulko.com>
> > > > > > > > > > >
> > > > > > > > > > > This is the point that everything no longer boots.
> > > > > > > > > > >
> > > > > > > > > > > But between those commits there are no extra codes.
> > > > > > > > > > >
> > > > > > > > > > > After that all things no longer work.
> > > > > > > > > >
> > > > > > > > > > Yes, and I need you to investigate your failure case he=
re. There is no
> > > > > > > > > > code change between a working commit and a failing comm=
it, which leads
> > > > > > > > > > me to the suggestions I gave for debugging.
> > > > > > > > >
> > > > > > > > > I even tried a fresh clone from https://github.com/u-boot=
/u-boot.
> > > > > > > > > Same situation.
> > > > > > > > > I don't understand.
> > > > > > > > > The commit missed or messed up?
> > > > > > > >
> > > > > > > > You need to look at the resulting binaries and see why the =
device tree
> > > > > > > > is not where it's expected to be.
> > > > > > > >
> > > > > > > > You might find it helpful looking through
> > > > > > > > https://lore.kernel.org/u-boot/CAOMZO5BiQcp2HYJgrYnPQLn8Q52=
Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com/
> > > > > > > > for some ideas.
> > > > > > >
> > > > > > > So you are suggesting even the commit between revert could in=
troduce this issue?
> > > > > > > Aren't the revert only applied to two changes?
> > > > > >
> > > > > > What I'm saying is that the underlying issue is that the device=
 tree is
> > > > > > not where it's expected to be. The likely root cause is that we=
 now
> > > > > > require the device tree to be (correctly!) 8 byte aligned in me=
mory and
> > > > > > not 4 byte aligned. In the case of appending a device tree to o=
ur binary
> > > > > > any sort of change in the code can change the size of the binar=
y and in
> > > > > > turn mean that the address where the device tree is ends up bei=
ng at a
> > > > > > different alignment.
> > > > >
> > > > > You are correct on this, but I don't understand why even revertin=
g to
> > > > > two code changes
> > > > > could introduce this issue.
> > > > >
> > > > > The revert also included other commits?
> > > > >
> > > > > "
> > > > > Revert a number of incorrect commits
> > > > > As part of debugging the appended device tree failure, I inadvert=
ently
> > > > > committed some changes as I was debugging to master, and not a pr=
ivate
> > > > > branch, and pushed them as part of the release. This reverts comm=
it
> > > > > dc2d842 through 380ddb4.
> > > > > "
> > > > >
> > > > > This is my debug case:
> > > > >
> > > > > Correct boot:
> > > > > hexdump -Cv spl/u-boot-spl.sfp | grep 'd0 0d fe ed'
> > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pG=
o...pG......|
> > > > > 0000beb0  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 08 c8  |....=
=2E...........|
> > > > >
> > > > > Fail boot:
> > > > > hexdump -Cv u-boot-spl_a.sfp | grep 'd0 0d fe ed'
> > > > > 00001ba0  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pG=
o...pG......|
> > > > > 0000beb0  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |....=
=2E...........|
> > > >
> > > > Yup, so it's mis-aligned. I guess can you tell me what the defconfig
> > > > you're using is?
> > >
> > > socfpga_cyclone5_defconfig
> >
> > You might need to do some debugging yourself on this. Is that also where
> > __bss_end is? This looks like the exact case that
> > 5ffc1dcc26d3df9e2b192151936cb98014fb6e49 should have fixed. And locally,
> > I see it being aligned, and then also just making a trival change (git
> > tree is dirty) that used to lead to mis-alignment, retaining alignment.
>=20
> I have a question I still don't understand.
> The example you gave me is even earlier than
> f4dfa5d3c2680322fd17fcc7c6221876e00a03c2.
> But build on f4dfa5d3c2680322fd17fcc7c6221876e00a03c2 can boot normally.
> So what 431f1ce46bbffff0db8f03437a34400b11b30175 actually reverted and
> could introduce this shift from first place.
>=20
> I really need this to clear out for me to debug the issue.

You might need to build with V=3D1 and see what's being generated to go in
to the binary file, and look at spl/u-boot-spl.map to see if things like
__bss_end match. You need to ignore the 3 commits I reverted because
they were debug things that did not work. They change behavior because
they make changes in the linker scripts and so change alignments.

--=20
Tom

--cVuYejXOxMEGWRIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXuMTwAKCRAr4qD1Cr/k
CqnXAP99liOTgygAlUf81NXTjGTzVvj42MKdDz/TKHfrY6/n9gD/SjDOZVNgeOxk
+le+6WgPZrl0G/BtPPE8JqEW93Z6PQo=
=vi6q
-----END PGP SIGNATURE-----

--cVuYejXOxMEGWRIg--
