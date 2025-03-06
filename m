Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747CCC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 17:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D690280756;
	Thu,  6 Mar 2025 18:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tn9TYTRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E418F80E94; Thu,  6 Mar 2025 18:13:11 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4255680017
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 18:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so768589276.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 09:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741281187; x=1741885987; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hNPwwYBDfsa9MQ267CZ6UppwBjVXKL76o8AgZDhQUTk=;
 b=tn9TYTRMT55YrCItDhbJifmfpzb3CUfDjxutr8V7e3WuVnY0KY0ZuJl33VX7nz00fl
 ilfCXN4hp7t4Jrav5mdvLAoDPvbyDgmv4rCyDAmGTxZ9uFIHj+Ge7PtF9Hk3pyiNHOpE
 lJmeD7bHD06li+bKAmECe1FsDWZykwz5EnnSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741281187; x=1741885987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNPwwYBDfsa9MQ267CZ6UppwBjVXKL76o8AgZDhQUTk=;
 b=OyCvaJgxmjq2nKrDvKYyYdJ9bhDN8brOnffH2klmOc3Rnb3gc1iM0CjN7DyP2xOObJ
 cSOYdbhGVb3hx74/MWB+5ycHWMQsCWJ3Qs7WSQWvJLFEIDijKeZT+Vflzanl2yQtemgS
 iTSUwsuNbBxpdOYAkwq18sC1fOI6S8Mb7XL/xX8WzNTUPdFE716a2qIo/KN/ftU7D6wp
 id06UH97YMZ9okg5Qvnah60YG4lxIpHgUvI//mVQUY15kSsmFqBhbQ9+gPBks+o5hZ34
 E0emVcIuogWZoQEP9PQztw1rbcuebvKShg5451B+qIhJOUNMVpv4TW5mUC0AP1e4lKGD
 ggkg==
X-Gm-Message-State: AOJu0YwTq2thGFoMU/pcaQDxAM2L2H/Q4yryZ/nQN65c0ZAGOQbD4fnc
 wqguOJK08gJih/pusE71thgyNBLaCEogXWHS5kfTHMCBQ+NlVD74gRQ5oimWRGSoUQoU7XneGGS
 j
X-Gm-Gg: ASbGncsD2a5qRK0SYLZPzioynb/JK54+Cf/+ru4TKYShT398wGkv7mdbJKrOCE85usn
 kBF1rSRCNsspZHa/zZIzBHDP16dlSDJi4w0bGCQmaq6XmRdQB3qQpQDRhJD0QAwGe532O1E8W6a
 Epz9r/kK4lwkO+qucYrJKRD18KoYqibe6XHeBOzoSrvejmuA5yLZGaMxI3r8fGj+a35YcIFUJI2
 XrvBvulumzME9Sgf05MmhGgRGuSwOL5EekkgRbQoq4fIUdboF0GJVBnxVzMsCWPxA5BXczRZ2pJ
 EgK24Srq06Utt6Y7VFJEqcBL4ldubSXRzoeH5HkMqfM0xw==
X-Google-Smtp-Source: AGHT+IGw+luUxCpGg2uB80o2qHgPfzs3bc4tabEubOhI8oOcQqtMfdqmKwB53c96fA81Z3QvoINN6g==
X-Received: by 2002:a05:6902:2e05:b0:e5e:1389:cb2f with SMTP id
 3f1490d57ef6-e635c1f26b0mr55155276.45.1741281186297; 
 Thu, 06 Mar 2025 09:13:06 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b7357dcsm401462276.12.2025.03.06.09.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 09:13:05 -0800 (PST)
Date: Thu, 6 Mar 2025 11:13:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250306171302.GG2640854@bill-the-cat>
References: <20250224231455.GI1233568@bill-the-cat>
 <CAFLszTiP+wPijf0QbTL0i9Ywk_0tWFwYP-1S1Lp+mFeqN=8zKg@mail.gmail.com>
 <20250227170352.GZ2640854@bill-the-cat>
 <CAFLszTgDms-RC+Qg=FLxtW253jh22eUb1Y-5OyB2U42EygdZWw@mail.gmail.com>
 <20250304161218.GA2640854@bill-the-cat>
 <CAFLszTj1hc7esvd_R3oVEqOpSBNFcRga0wmR3hnTsFELXi+m1g@mail.gmail.com>
 <20250305160631.GS2640854@bill-the-cat>
 <CAFLszTix7phNcsECa5Nwve-1g0fD6G0HZ=eWXxaHTjZp0+K9Xw@mail.gmail.com>
 <20250306143047.GA2640854@bill-the-cat>
 <CAFLszTh47L11V7sbfbd2zaCs7rYpuPLTX4rBKnkUn8oQ9xUeXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rd1CLWnUG29Ic1YC"
Content-Disposition: inline
In-Reply-To: <CAFLszTh47L11V7sbfbd2zaCs7rYpuPLTX4rBKnkUn8oQ9xUeXQ@mail.gmail.com>
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


--rd1CLWnUG29Ic1YC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 09:13:52AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Mar 2025 at 07:37, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 06, 2025 at 06:59:08AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 5 Mar 2025 at 09:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Mar 05, 2025 at 07:18:40AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 4 Mar 2025 at 09:12, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Mar 04, 2025 at 08:35:56AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 27 Feb 2025 at 10:03, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Thu, Feb 27, 2025 at 09:26:10AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 24 Feb 2025 at 16:14, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sat, Feb 22, 2025 at 05:24:05PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Sat, 22 Feb 2025 at 14:37, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sat, Feb 22, 2025 at 10:23:59AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 21 Feb 2025 at 17:08, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 04:42:09PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 06:14:06AM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Sun, 16 Feb 2025 at 14:52, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 12:39:34PM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Sun, 16 Feb 2025 at 09:07, Tom Rin=
i <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 07:10:12AM =
-0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 11:12, Tom=
 Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 10:21:1=
6AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 07:41,=
 Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 04:=
59:40AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > On Mon, 10 Feb 2025 at 09=
:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > On Thu, Feb 06, 2025 at=
 03:38:55PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > This is a global defa=
ult, so put it under 'default' like the tags.
> > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > Signed-off-by: Simon =
Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > > > > > > > > > > > > > Suggested-by: Tom Rin=
i <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > > > > > > > > > > Reviewed-by: Tom Rini=
 <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > Please make v4 include =
the way you redid the second patch and be on top
> > > > > > > > > > > > > > > > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > That's enough versions fo=
r me, so I'll let you do that, if you'd like.
> > > > > > > > > > > > > > > > > > > > > > > > > It probably doesn't affec=
t your tree as not as much is done in
> > > > > > > > > > > > > > > > > > > > > > > > > parallel.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > I am disappointed.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > I'm sorry to disappoint you.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > The background is that I look=
ed at the difference between our trees
> > > > > > > > > > > > > > > > > > > > > > > and the gitlab files are quit=
e different. My CI runs take about 35
> > > > > > > > > > > > > > > > > > > > > > > mins and it seems that yours =
is around 90 mins. I would like to reduce
> > > > > > > > > > > > > > > > > > > > > > > / remove the delta (for time =
and patch diff), but I'm not sure how.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > My goal is to get CI runs to =
below 20 minutes, best case.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > I'm sure CI could be quicker st=
ill with a number of faster runners. But
> > > > > > > > > > > > > > > > > > > > > > if you can't be bothered to mak=
e changes against mainline, what is the
> > > > > > > > > > > > > > > > > > > > > > point?
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > If you recall, I was working with=
 your tree and had various ideas to
> > > > > > > > > > > > > > > > > > > > > speed things up, but you didn't l=
ike it. So I've had to do it in my
> > > > > > > > > > > > > > > > > > > > > tree. This is not about more runn=
ers (although I might have another
> > > > > > > > > > > > > > > > > > > > > one soon). It is about running jo=
bs in parallel.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > And I wasn't sure more runners in p=
arallel would help (as it would slow
> > > > > > > > > > > > > > > > > > > > down the fast runner which is what =
keeps the long jobs from being even
> > > > > > > > > > > > > > > > > > > > longer) as much as adding more regu=
lar runners would (which we've done)
> > > > > > > > > > > > > > > > > > > > and noted that in the end it's a co=
nfiguration on the runner side so to
> > > > > > > > > > > > > > > > > > > > go ahead. And I reviewed and ack'd =
the patches here which exposed the
> > > > > > > > > > > > > > > > > > > > issues your path revealed. I just c=
an't apply them because they need to
> > > > > > > > > > > > > > > > > > > > be rebased (and squashed).
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > You have already added tags for thing=
s, but (IIUC) they are around the
> > > > > > > > > > > > > > > > > > > other way from what I have added.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > I have a tag called 'single' which me=
ans that the machine is only
> > > > > > > > > > > > > > > > > > > allowed to one of those jobs. The wor=
ld-build jobs are marked with
> > > > > > > > > > > > > > > > > > > 'single'.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > For other jobs, I allow the runners t=
o pick up some in parallel
> > > > > > > > > > > > > > > > > > > depending on their performance (for m=
oa and tui that is 10).
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > So at most, there is a 'world build' =
and 10 test.py jobs running on
> > > > > > > > > > > > > > > > > > > the same machine. It seems to work fi=
ne in practice, although I would
> > > > > > > > > > > > > > > > > > > rather be able to make these two type=
s of jobs mutually exclusive, so
> > > > > > > > > > > > > > > > > > > that a runner is either running 10 pa=
rallel jobs or 1 'single' job,
> > > > > > > > > > > > > > > > > > > but not both. I'm not sure how to do =
that.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > So unless I'm missing something, in bot=
h cases the bottleneck is that
> > > > > > > > > > > > > > > > > > for world build jobs you don't want any=
thing else going on with the
> > > > > > > > > > > > > > > > > > underlying build host. You could regist=
er 10 "all" runners and 1 "fast
> > > > > > > > > > > > > > > > > > amd64" runner (and something similar bu=
t smaller for alexandra). If you
> > > > > > > > > > > > > > > > > > update the registrations on source.denx=
=2Ede can you then shut down your
> > > > > > > > > > > > > > > > > > gitlab instance?
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I've put a tag of 'single' on things that=
 should run on the single-job
> > > > > > > > > > > > > > > > > runner. Everything else can run concurren=
tly, e.g. up to 10 jobs. So I
> > > > > > > > > > > > > > > > > have two runners on the same host. E.g. t=
ui-single has 'limit =3D 1',
> > > > > > > > > > > > > > > > > but 'tui' has no limit and is just govern=
ed by the 'concurrent =3D 10'
> > > > > > > > > > > > > > > > > at the top of the file.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yes. And you could move those runners to th=
e mainline gitlab. There is
> > > > > > > > > > > > > > > > no "single" tag, that would be the "all" ta=
g. And "tui-single" would be
> > > > > > > > > > > > > > > > "fast amd64".
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > They are still attached to the Denx gitlab. N=
othing has changed on my
> > > > > > > > > > > > > > > side. I'm not sure that your new tags are wor=
king though. I have a
> > > > > > > > > > > > > > > feeling something broke along the way when yo=
u made all your tag
> > > > > > > > > > > > > > > changes. One of my servers makes a bit of noi=
se and I haven't heard it
> > > > > > > > > > > > > > > in quite a while.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > There's a few of your runners that are "stale" =
and haven't contacted
> > > > > > > > > > > > > > gitlab in a long time. I'll double check the ta=
gs tho.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > If Denx would like to give me access to their=
 gitlab instances, I'd be
> > > > > > > > > > > > > > > happy to play around and figure out how to ge=
t it going as fast as my
> > > > > > > > > > > > > > > tree does, and send a patch.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm not sure what you mean by that? The instanc=
e itself?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes. I can fiddle with tags on my runners and try=
 to figure it out.
> > > > > > > > > > > >
> > > > > > > > > > > > I'm not sure what you're getting at here. If you me=
an "tags" in
> > > > > > > > > > > > /etc/gitlab-runner/config.toml those aren't relevan=
t here I believe.
> > > > > > > > > > >
> > > > > > > > > > > No, I mean the tags in CI. If I fiddle with them I ca=
n probably come
> > > > > > > > > > > up with a way to run your CI much faster. Mine is abo=
ut 35mins.
> > > > > > > > > >
> > > > > > > > > > I'm not so sure about that. Yours runs faster because i=
t tests less. Now
> > > > > > > > > > that we've got some of your other fast runners showing =
up again, this is
> > > > > > > > > > more instructive of current times I think:
> > > > > > > > > > https://source.denx.de/u-boot/u-boot/-/pipelines/24802
> > > > > > > > >
> > > > > > > > > But not this? :
> > > > > > > >
> > > > > > > > You forgot a link. But presumably to some run yesterday whi=
ch took
> > > > > > > > longer. And because Ilias was tweaking the currently donate=
d arm64
> > > > > > > > runners (that have other jobs to run) and also we had two o=
r three
> > > > > > > > custodians at a time preparing trees, things ran slower.
> > > > > > >
> > > > > > > Maybe, but I don't think so.
> > > > > >
> > > > > > No need to "think" about it. You can look at the pipeline histo=
ry and
> > > > > > see what was in queue for how long. And since I needed to be ke=
eping an
> > > > > > eye on two of the 3 arm64 runners, I could see when custodians =
were
> > > > > > firing off tests. Aside from the number of pull requests I had =
waiting
> > > > > > that morning.
> > > > >
> > > > > Your runs are reliably around an hour but mine are reliably just =
over
> > > > > 30 minutes. I only have three runners.
> > > > >
> > > > > https://source.denx.de/u-boot/u-boot/-/pipelines
> > > > > https://sjg.u-boot.org/u-boot/u-boot/-/pipelines
> > > > >
> > > > > I know you have added a duplicate build on arm64, but I can still
> > > > > speed it up significantly if you'll allow me.
> > > >
> > > > I've never been stopping you.
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20241128160011.78055=
0-1-sjg@chromium.org/
> >
> > Indeed. That gets back to what I keep telling you about how to test your
> > CI changes on source.denx.de.
>=20
> I don't understand your response here.

Well, if we go to the next part..

> > > > > > > > > > If you want to make mainline CI run faster you will nee=
d to catch up
> > > > > > > > > > with the missing coverage or argue that some things are=
 redundant.
> > > > > > > > >
> > > > > > > > > Or perhaps I can actually just make it faster without dro=
pping coverage?
> > > > > > > >
> > > > > > > > I mean, I don't know how that's physically possible, outsid=
e of adding
> > > > > > > > many more expensive build hosts. We have two-three fast arm=
64 hosts and
> > > > > > > > that world builds between 30-45 minutes. That's the biggest=
 time
> > > > > > > > bottleneck.
> > > > > > >
> > > > > > > Why did you join those builds up? It is better for throughput=
 to have
> > > > > > > a few runners working in parallel.
> > > > > >
> > > > > > Because I'm not optimizing for the single developer running CI =
case (or
> > > > > > the loads of fast runners case). If we had sufficient resources=
, yes,
> > > > > > the fastest possible way would be 4 "fast arm64" servers and 4 =
"fast
> > > > > > amd64" servers each running if not 25% of the world build, at l=
east 4
> > > > > > easy to make and maintain groupings.
> > > > > >
> > > > > > However, we don't have that many of either. And they also need =
to be
> > > > > > used for the biggest sandbox test suite jobs so that they run i=
n about 5
> > > > > > minutes, not about 10 minutes. So in order to not entirely bloc=
k other
> > > > > > custodians we do a single world build. Because make and buildma=
n are
> > > > > > very good about otherwise fully loading the server. Running any=
thing
> > > > > > else while that is going on will slow down the world build (and=
, the
> > > > > > other job too).
> > > > >
> > > > > They're OK (on a fast machine) so long as the 'other' load is not=
 too much.
> > > >
> > > > Things are OK until they aren't, yes. But just make sure you try out
> > > > some of the worst case (ie more than one pipeline at a time running=
).
> > >
> > > We could collect stats on runs, I suppose. Perhaps it runs a lot when
> > > I am asleep.
> >
> > That's not what your pipeline shows? Or do you mean the runners? Yes,
> > the runners themselves are busy with jobs from source.denx.de.
>=20
> Mostly the runners seem fairly unloaded, so far as I can tell, but as
> I say, I don't have monitoring to see what happens at night.
>=20
> >
> > > > > > Aside, maintaining groupings is a pain. It was very bad with Tr=
avis, and
> > > > > > it's only moderately painful with Azure where at least the end =
goal is
> > > > > > 10 pipelines for maximum concurrency. And with Azure everyone *=
can* get
> > > > > > their own "project" or whatever the right term is, and utilize =
10
> > > > > > runners at once.
> > > > >
> > > > > Yes, but we can update buildman to handle grouping automatically,=
 as I
> > > > > suggested once.
> > > >
> > > > I'm not sure we want make buildman act like distcc as well here. If=
 we
> > > > wanted to split the world in two, making it easy to say "arm not ar=
mv8"
> > > > and "not (arm not armv8)" would be good enough.
> > >
> > > OK, yes that would be better as boards would be more sensibly grouped.
> >
> > I look forward to your results on testing that, then as I can't get that
> > kind of list from buildman today (starting problem,
> > "tools/buildman/buildman --dry-run -v all" is 10 boards).
>=20
> OK
>=20
> >
> > > > > > > > The next biggest is that unless sandbox tests are run on a =
fast host,
> > > > > > > > they take upwards of 10 minutes, rather than 5.
> > > > > > >
> > > > > > > Yes, they are just getting slower and slower.
> > > > > >
> > > > > > Adding more tests takes more time. But the real question is whi=
ch tests
> > > > > > take wall clock noticeable time, and why, and if we can do anyt=
hing
> > > > > > about it. My gut feeling is that it's in the disk image related=
 tests
> > > > > > and the user space verification of them.
> > > > > >
> > > > > > > > But please, rebase your work to next and see what you can d=
o. There is
> > > > > > > > likely some speed-ups possible if we allow for failures to =
take longer
> > > > > > > > to happen (and don't gate world builds on all of test.py st=
age
> > > > > > > > completing, just say sandbox). And if you do the work on so=
urce.denx.de
> > > > > > > > (as there is *NOTHING* stopping you from registering more r=
unners to
> > > > > > > > your tree and using whatever tagging scheme you like) you m=
ight even see
> > > > > > > > more of the time variability due to load from other custodi=
ans.
> > > > > > >
> > > > > > > I can't edit the tags on the runners, nor can I adjust them t=
o run
> > > > > > > untagged jobs, nor can I delete runners I don't want, so no, =
I believe
> > > > > > > I need access to do that.
> > > > > >
> > > > > > You can do all of that with runners specific to u-boot-dm, and =
you can
> > > > > > disable project / group runners yourself too. So yes, you can.
> > > > >
> > > > > Nope, sorry, I wasn't able to do any of this with the Denx tree a=
s I
> > > > > can't adjust tags and can't delete and recreate runners.
> > > >
> > > > You don't have
> > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/settings/ci_cd=
#js-runners-settings
> > > > visible to you?
> > >
> > > Right. But also note that there are group runners on another page.
> >
> > And you disable them from the page I mentioned above. If you disable all
> > of the existing project, group and shared runners (which are settings on
> > that page) you will have zero runners available for your tree. You can
> > then add project runners to only your project with whatever tagging
> > scheme you like. You can then test your ideas about how tags would work.
>=20
> OK, that sounds like a lot of hassle and you've already rejected my
> ideas here. Are you saying you are open to a change? I am asking
> because your last response suggested that my CI was no faster than
> yours, or that it was only faster because it has less testing.

Once again I am trying to show you how to test your changes on the
mainline Gitlab server. Because you said you need your own gitlab (or
admin access to the u-boot space) to do this and that's not correct.

I have rejected your idea because it doesn't seem like it would
actually be a win.

I have asked you to prove me wrong by implementing your idea on
mainline, on the mainline gitlab server.

You have declined thus far.

And I am *always* open to being shown facts that show I was wrong. If
you can rework the CI jobs such that mainline is faster, and is still
faster or at least no worse with multiple running pipelines, great.

And yes, your tree is testing less things. This is a statement of fact.
You are neither running sandbox on arm64 (which exposed important bugs)
nor world builds on arm64 (which exposed bugs within the Dockerfile and
makes it clearer that buildman is very funky about using a "cross"
toolchain for the host processor).

> > > > > > > > > > > > > > > I also have another runner to add.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'll contact you off-list with the token.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > From my side, I have found it helpful and=
 refreshing to have a gitlab
> > > > > > > > > > > > > > > > > instance which I can control, e.g. it run=
s in half the time and if my
> > > > > > > > > > > > > > > > > patches are completely blocked by Linaro,=
 etc., I have an escape
> > > > > > > > > > > > > > > > > valve.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yes, and I have no idea what any of that ha=
s to do with anything other
> > > > > > > > > > > > > > > > than leading to confusion about what tree i=
s or is not mainline. Since
> > > > > > > > > > > > > > > > you own u-boot.org and ci.u-boot.org is you=
r gitlab and
> > > > > > > > > > > > > > > > https://ci.u-boot.org/u-boot/u-boot/ is you=
r personal tree.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > For now I am working with my tree, so that I =
am not blocked by Linaro,
> > > > > > > > > > > > > > > etc. but as you have seen I can rebase series=
 for your tree as needed.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > And you're not addressing my point about using =
the project domain for
> > > > > > > > > > > > > > your personal tree. That's my big huge "are you=
 forking the project or
> > > > > > > > > > > > > > what" problem.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm just making sure that my work is not blocked =
or lost, as that has
> > > > > > > > > > > > > happened too many times in the past few years.
> > > > > > > > > > > >
> > > > > > > > > > > > Again, are you intending to fork the project? Putti=
ng your personal tree
> > > > > > > > > > > > in as "https://ci.u-boot.org/u-boot/u-boot.git" is =
not OK. I keep asking
> > > > > > > > > > > > you to stop it.
> > > > > > > > > > >
> > > > > > > > > > > No, I'm not intending to fork anything. But I need a =
tree that I can
> > > > > > > > > > > control and push things into.
> > > > > > > > > >
> > > > > > > > > > I don't know how you can call your personal tree being =
at
> > > > > > > > > > "https://ci.u-boot.org/u-boot/u-boot.git" and saying it=
's somewhere you
> > > > > > > > > > control and can push to while not also saying it's a fo=
rk. If you want
> > > > > > > > > > to close down your gitlab and CNAME ci.u-boot.org to so=
urce.denx.de, you
> > > > > > > > > > can still push things to u-boot-dm. Or if that's too co=
nstrained of a
> > > > > > > > > > namespace you can also get a contributors/sjg/ namespac=
e. But what
> > > > > > > > > > you're doing today WILL lead to confusion.
> > > > > > > > >
> > > > > > > > > I believe I've answered this question before. It is simpl=
y that I
> > > > > > > > > cannot get certain patches (bloblist, EFI, devicetree) in=
to your tree.
> > > > > > > > > There really isn't any other reason.
> > > > > > > >
> > > > > > > > Yes, that's still not an answer to my question.
> > > > > > > >
> > > > > > > > Or is the answer to my question "Yes, I'm trying to confuse=
 people to
> > > > > > > > thinking my tree is mainline."
> > > > > > >
> > > > > > > No, it's simply that you are not taking some patches in your =
tree and
> > > > > > > complaining about the amount of patches.
> > > > > >
> > > > > > That's misleading at best. I'm not taking the patches that other
> > > > > > custodians have repeatedly rejected and explained why they're r=
ejecting
> > > > > > them.
> > > > >
> > > > > Yes and this has affected my ability to move things forward so mu=
ch
> > > > > that I've had to set up my own tree. It has been working very wel=
l, to
> > > > > have a relief valve.
> > > >
> > > > It's been working pretty terrible for the rest of the project as you
> > > > build on top of things that have been rejected and you're collectin=
g in
> > > > your own personal downstream fork. Igor's email last night would be=
 the
> > > > latest example of "I wanted to look at this but where is it?"
> > >
> > > You make it sound like it is some strange force from the void that is
> > > creating these problems :-)
> >
> > No, I'm saying you're making these problems and I wish you would stop.
> >
> > > The EFI-app thing was killed in review, so I picked it up and applied
> >
> > It was not "killed in review". It was posted once, given feedback and
> > you picked it up for your tree in what felt like a day later but I'm
> > sure was slightly longer than that.
>=20
> Just over two weeks, when it seemed to me it was dead. I had emailed
> Matthew several times asking if he could make time to post his work.
> Telling him to refactor a load of the EFI_LOADER stuff just to get the
> app running seems wrong to me. I believe I already explained this at
> the time.

Waiting for answers to questions, which then did come along with
confusion about the state of the series given that you had applied it
somewhere else by then.

On the merits, I'm entirely unsure without digging it all up on if
factoring out common code was or was not a reasonable request. I believe
there was other feedback on the series as well and it was certainly not
a "ready to merge as v1" post.

> > > it and am now building on it (it now supports arm64). I mentioned
> > > before that I found that whole review process embarrassing (if not
> > > mortifying) and it made me realise that I shouldn't tolerate it
> > > either. Matthew Garrett is the sort of engineer that people should
> > > *welcome* to the project. Yes, Heinrich and Ilias had some useful
> > > feedback which I will get to at some point, but it works. Perhaps I'll
> > > get into it when Linaro gets the lwip network tests running with
> > > sandbox :-)
> >
> > You know what, I'd really love feedback from Matthew about that.
> >
> > > The next step is to get it running in qemu with my lab...but you
> > > rejected that too I think? So it won't be in your tree unless you
> > > change your mind on that.
> >
> > Did I reject making labgrid a requirement for tests? Yes, I did. Did I
> > explain why and offer alternatives? I also did. Does there seem to be
> > any reason this next test of yours would require labgrid? No, there does
> > not.
>=20
> We can't 'require' Labgrid. There are too many loose strawmans being
> thrown around here. But I want to use it in my lab and I want a test
> which boots Ubuntu etc. in my lab using Labgrid. I explained that I
> want to be able to interactively run the target ('ub-int qemu-86') as
> well as run pytests ('ub-pyt qemu-x86 pxe') and in gitlab CI. That all
> works today and all you need to do is not reject the patch.

And I found it both hugely disappointing that you wrote something so
specific to your lab and non-replicable elsewhere and also "yes and" to
the patch. Perhaps that got missed along the way.

> > > Again, it isn't a strange and unexplained force. It is just a
> > > consequence of your decisions here. If you were more flexible, I would
> > > have been able to continue as we were.
> >
> > The only way I could be more flexible here is to apply everything you
> > post without question.
>=20
> That's the part of your thinking which I really struggle with. There
> is a large amount of space in between that (which as you know I've
> never even suggested) and what I am looking for.

And I keep struggling with how you don't see it. You want changes that
have been rejected for various valid technical reasons to be applied
over the objection of the custodian.

> The ANSI patch is an example of gratuitous rejection for no useful reason.

It wasn't tho? Heinrich explained in another part of the thread where
there is a good spec required reason we're doing the sequences we're
doing. You either missed it or forgot it, I don't know which. But it
wasn't "gratuitous". It's a tricky part of the spec where we need to
come up with some clever solution for the case Michal hits.

> Given the number of emails I'm genuinely surprised at the lack of
> progress we have made here.

I'm not surprised because I keep having to repeat myself.

> Again, your decisions and position have produced the situation we are
> in now. Much is in your control. If you are interested in changing
> anything, even a little, I'm sure it would help.

OK. What's one request you have of me that should be clear and
un-objectionable?

> > > > > > > > > At the moment your CI seems to be flaky as well:
> > > > > > > > >
> > > > > > > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs=
/1038174
> > > > > > > >
> > > > > > > > [aside, I think you meant to link to the pipeline itself, w=
hich also
> > > > > > > > passed, but had some retries]
> > > > > > > >
> > > > > > > > Funny story. Ilias needed to tweak the fast arm64 hosts and=
 also wanted
> > > > > > > > to explore "What if we have concurrency higher?" and ran in=
 to the
> > > > > > > > problems you also ran in to with respect to git seeing an e=
xisting clone
> > > > > > > > in progress and bailing. Followed by the problem of multipl=
e non-trivial
> > > > > > > > jobs running concurrently.
> > > > > > > >
> > > > > > > > All of which is why I keep trying to tell you that while "s=
ingle" and
> > > > > > > > concurrent runners work fine for you on a single user insta=
nce it will
> > > > > > > > not scale.
> > > > > > >
> > > > > > > Yes, but I solved that with the patch I sent and it seems to =
be 100%
> > > > > > > reliable now.
> > > > > >
> > > > > > Yes, you eventually solved it with 3 patches, which I asked you=
 to
> > > > > > rebase and squash to two patches (because #3 just fixes that #2=
 wasn't
> > > > > > sufficient) and you declined.
> > > > >
> > > > > In general, why not just be more open to my ideas, even just try =
it
> > > > > for a year? Given the tools I'm confident I can speed up your CI =
as
> > > > > well.
> > > >
> > > > I've never not been open to applying patches to mainline that are
> > > > against mainline. I am not going to rebase your work for you howeve=
r.
> > > > And I think it's terrible for the project as a whole when you post
> > > > changes against your tree and people expect to be able to review th=
em
> > > > and then can't because it's against your downstream fork.
> > >
> > > I've started mentioning the base commit in patman and I think I'll
> > > update it to show the source tree as well. I understand the rebasing
> > > is a pain and I am certainly happy to shoulder some of that load. E.g.
> > > I can send a PR for each series when you are ready to accept it. If
> > > you like. Perhaps we can set a timeline for that (e.g. no comments for
> > > a week?)
> >
> > You are subject to the same general timelines as everyone else. When
> > your patches apply to mainline and aren't rejected. Which is "about two
> > weeks" and has been for about 15 years now. Sometimes I will pull things
> > in sooner when they're smaller / clearer, but that typically doesn't
> > apply to your very large series with multiple changes in it.
>=20
> OK, well again I'm happy to send a PR for things that haven't been
> rejected for your tree.

OK. So looking at:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D&submitter=3D&sta=
te=3D&q=3D&archive=3D&delegate=3D3184
Right now, there's patches for you lab that need to be rebased to next
(and feedback addressed, or set aside the i.MX target for now / make a
new thread about the general problem there). A patch from Heinrich. A
series from Caleb. The last two certainly, and whatever of the lab stuff
applies, could be in a PR for next whenever you're ready.

--=20
Tom

--rd1CLWnUG29Ic1YC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfJ15sACgkQFHw5/5Y0
tyx79Av/e0zOmFsGZ3ZxocXAYAzaq8DXo0FaB/XLTsJhbqbRkZrZwLnU2D/QwEL9
A/NkjwNSDI0e3GreOnDitThXk3tCBkTz2W3+yRlQPQSEZ4HngN5ewpi3BFyDNqNB
KdIOOK4YolbJ6OOEke/8svD4W1OY3Bjjl3Mt4jtTl8a9qi8cYVgMJnyziX6n4lKj
85teoxw5xAIFBD8xi144EsikPLTp0+doCn3gB/rSp/SXimB98Gh9CoFEp1vLIDdF
+YdFwj5N+w823esVIaL+yAfTTlHe3z3fr7C0Oivb54y1L2Z3TW7eh72nC3LtRFfm
3nMGoJK+9uJtMJYLtM/k7+Daup8tBUh1WKcq8I2A/vo6ui0lWoZUqhviDLtPYRon
QdYhr6hGuWq56je51IFQUJow4eTI+sFdOkQe3Ul2/Ge9DBiV+j3OnlmGdhYa/kSV
BE5j4OsVY+3Sn6dDIJCVWnyezlDryNjOJss89VhNId+h+n5bbuCzE9KvN61SX/WO
Zzusl/xU
=U3YM
-----END PGP SIGNATURE-----

--rd1CLWnUG29Ic1YC--
