Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB051C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB7681703;
	Tue,  1 Apr 2025 19:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lyyASkFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5878D81DE3; Tue,  1 Apr 2025 19:12:58 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACCC80FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2a01bcd0143so6213177fac.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743527573; x=1744132373; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=quE05VbtLWjrQjm8hCqSzfY9tuGXFPu84a5Rsdt2Fn4=;
 b=lyyASkFjF+ibjApB/HbM3kpiw/oeoFg5ZKkUxmg7NYSz6EMENuRAnYBa19V3YQejbz
 CsxyCnNoy8Cin7x5VB5pjZAIrpC90TGpuUk+kF3IHOSKW/uBDhgXf78c8YI1W0VHasX6
 MnTYo3MMSNosnqAYx+INwCfIQzDWW0O1/3tKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743527573; x=1744132373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=quE05VbtLWjrQjm8hCqSzfY9tuGXFPu84a5Rsdt2Fn4=;
 b=uD9GsuMIuu/9axw6sR2GXBJ7f+9hm43L+55VAZ+ek17W7z68Hh+Wx98Tkp/BvNL4ym
 rsyVgcpgUMvoh1IcSwVU0buGgLfhuL4R7cwVw+d2FcGoOuqVeun4b5r3EFdFNHnbjqdu
 66D8VN86U5XfclEST/mL/ztehTtYWYTTXqQ/YgxyBR2yz+RaFSfjFVtHBdP88fJxxg6Q
 3XgUNAUjZ9cS+QTFxVDGpWV5YTZn2pd+s/IN0eqZozO+RCqQO4+rKSgXMjgvSBeXzX9c
 P5n7i1ucjBEJZuT6cL7JewWSeKwwILHI6AMCst2v6IeCcwXrUpv93hvEYCLMSgQ1QINH
 8Ohg==
X-Gm-Message-State: AOJu0Yzzds6IH4Aj4mYYx0GU44aRxJmHV/MDtxemr2oNuF6xJmt5fmOo
 ZS0R0aKFA9UNsUN8Fx4SqhvxbmwCR8HIdGcA8KznDqsLCqgNwJCNLDXpWO7jk7SCZN7f2dfDn7n
 E
X-Gm-Gg: ASbGncsnJKKCKhXNEMs3nS/OO0vB9axuLUKk5kiSA9btM+Jc5epyA0Evhh+q8c3kcjL
 lIhiJmpgsYzFtjH90+aKa2Fp4C6wgcX85Za+EM/Eiuou4X19jwKRRVhgSeskQpU8WNj4eESFqqp
 s6FHVqrMfklZwHrWCfwnphsNPcyJMylsZ3b34dCMIMjRN8YOusGDRhmb0Rryht8mniEiiaj+GBG
 C946BHQB4AsazFBSOTFgRSAM4JX0xOGagycwVmEU4sWOqQ02gmS1xLjJ5w7mjEH5yl9bcgulhUB
 Ruh7liQguE2wHcs7o2XxdCk2w8B+l/b4yrMeme0YMz8ip62w2khakb4Uc6ulQKQN0swX8PZ2JGc
 5q7GsCA==
X-Google-Smtp-Source: AGHT+IFz8gSq/qS3+TIlTAjvWqkizG0uoknr7IjqGoFF2sKADLYe4GEUqp33/o+akk19gHOfUVVv6A==
X-Received: by 2002:a05:6870:e386:b0:29e:48d6:2e62 with SMTP id
 586e51a60fabf-2cbcf4a7969mr8996149fac.9.1743527572130; 
 Tue, 01 Apr 2025 10:12:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580fa72fsm1932875a34.41.2025.04.01.10.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:12:51 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:12:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250401171249.GK5495@bill-the-cat>
References: <20250304161218.GA2640854@bill-the-cat>
 <CAFLszTj1hc7esvd_R3oVEqOpSBNFcRga0wmR3hnTsFELXi+m1g@mail.gmail.com>
 <20250305160631.GS2640854@bill-the-cat>
 <CAFLszTix7phNcsECa5Nwve-1g0fD6G0HZ=eWXxaHTjZp0+K9Xw@mail.gmail.com>
 <20250306143047.GA2640854@bill-the-cat>
 <CAFLszTh47L11V7sbfbd2zaCs7rYpuPLTX4rBKnkUn8oQ9xUeXQ@mail.gmail.com>
 <20250306171302.GG2640854@bill-the-cat>
 <CAFLszTi4hK=oXbtA+67eeZOh8icfMWNtAn98Yyuk_8BaK=7M+g@mail.gmail.com>
 <20250329002537.GN93000@bill-the-cat>
 <CAFLszTiKE_3nLQ7cDmkBGbC1CdLFs48jsxsMzNhgOUG-1zCM_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AygqJRX5M12uqDPL"
Content-Disposition: inline
In-Reply-To: <CAFLszTiKE_3nLQ7cDmkBGbC1CdLFs48jsxsMzNhgOUG-1zCM_A@mail.gmail.com>
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


--AygqJRX5M12uqDPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 04:51:37AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 29 Mar 2025 at 13:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 28, 2025 at 11:47:12PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 6 Mar 2025 at 10:13, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Mar 06, 2025 at 09:13:52AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 6 Mar 2025 at 07:37, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 06, 2025 at 06:59:08AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 5 Mar 2025 at 09:06, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Wed, Mar 05, 2025 at 07:18:40AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Tue, 4 Mar 2025 at 09:12, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Mar 04, 2025 at 08:35:56AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Thu, 27 Feb 2025 at 10:03, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Feb 27, 2025 at 09:26:10AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, 24 Feb 2025 at 16:14, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sat, Feb 22, 2025 at 05:24:05PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Sat, 22 Feb 2025 at 14:37, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Sat, Feb 22, 2025 at 10:23:59AM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 17:08, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 04:42:09PM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 07:14, Tom Rin=
i <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 06:14:06AM =
-0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Sun, 16 Feb 2025 at 14:52, Tom=
 Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 12:39:3=
4PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > On Sun, 16 Feb 2025 at 09:07,=
 Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 07:=
10:12AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 11=
:12, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at=
 10:21:16AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 a=
t 07:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > On Sat, Feb 15, 202=
5 at 04:59:40AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > On Mon, 10 Feb 20=
25 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > On Thu, Feb 06,=
 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > This is a glo=
bal default, so put it under 'default' like the tags.
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > Signed-off-by=
: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > Suggested-by:=
 Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > Reviewed-by: =
Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > Please make v4 =
include the way you redid the second patch and be on top
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > of mainline, th=
anks.
> > > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > That's enough ver=
sions for me, so I'll let you do that, if you'd like.
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > It probably doesn=
't affect your tree as not as much is done in
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > parallel.
> > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > I am disappointed.
> > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > I'm sorry to disappoi=
nt you.
> > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > The background is tha=
t I looked at the difference between our trees
> > > > > > > > > > > > > > > > > > > > > > > > > > > and the gitlab files =
are quite different. My CI runs take about 35
> > > > > > > > > > > > > > > > > > > > > > > > > > > mins and it seems tha=
t yours is around 90 mins. I would like to reduce
> > > > > > > > > > > > > > > > > > > > > > > > > > > / remove the delta (f=
or time and patch diff), but I'm not sure how.
> > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > My goal is to get CI =
runs to below 20 minutes, best case.
> > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > I'm sure CI could be qu=
icker still with a number of faster runners. But
> > > > > > > > > > > > > > > > > > > > > > > > > > if you can't be bothere=
d to make changes against mainline, what is the
> > > > > > > > > > > > > > > > > > > > > > > > > > point?
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > If you recall, I was work=
ing with your tree and had various ideas to
> > > > > > > > > > > > > > > > > > > > > > > > > speed things up, but you =
didn't like it. So I've had to do it in my
> > > > > > > > > > > > > > > > > > > > > > > > > tree. This is not about m=
ore runners (although I might have another
> > > > > > > > > > > > > > > > > > > > > > > > > one soon). It is about ru=
nning jobs in parallel.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > And I wasn't sure more runn=
ers in parallel would help (as it would slow
> > > > > > > > > > > > > > > > > > > > > > > > down the fast runner which =
is what keeps the long jobs from being even
> > > > > > > > > > > > > > > > > > > > > > > > longer) as much as adding m=
ore regular runners would (which we've done)
> > > > > > > > > > > > > > > > > > > > > > > > and noted that in the end i=
t's a configuration on the runner side so to
> > > > > > > > > > > > > > > > > > > > > > > > go ahead. And I reviewed an=
d ack'd the patches here which exposed the
> > > > > > > > > > > > > > > > > > > > > > > > issues your path revealed. =
I just can't apply them because they need to
> > > > > > > > > > > > > > > > > > > > > > > > be rebased (and squashed).
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > You have already added tags f=
or things, but (IIUC) they are around the
> > > > > > > > > > > > > > > > > > > > > > > other way from what I have ad=
ded.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > I have a tag called 'single' =
which means that the machine is only
> > > > > > > > > > > > > > > > > > > > > > > allowed to one of those jobs.=
 The world-build jobs are marked with
> > > > > > > > > > > > > > > > > > > > > > > 'single'.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > For other jobs, I allow the r=
unners to pick up some in parallel
> > > > > > > > > > > > > > > > > > > > > > > depending on their performanc=
e (for moa and tui that is 10).
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > So at most, there is a 'world=
 build' and 10 test.py jobs running on
> > > > > > > > > > > > > > > > > > > > > > > the same machine. It seems to=
 work fine in practice, although I would
> > > > > > > > > > > > > > > > > > > > > > > rather be able to make these =
two types of jobs mutually exclusive, so
> > > > > > > > > > > > > > > > > > > > > > > that a runner is either runni=
ng 10 parallel jobs or 1 'single' job,
> > > > > > > > > > > > > > > > > > > > > > > but not both. I'm not sure ho=
w to do that.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > So unless I'm missing something=
, in both cases the bottleneck is that
> > > > > > > > > > > > > > > > > > > > > > for world build jobs you don't =
want anything else going on with the
> > > > > > > > > > > > > > > > > > > > > > underlying build host. You coul=
d register 10 "all" runners and 1 "fast
> > > > > > > > > > > > > > > > > > > > > > amd64" runner (and something si=
milar but smaller for alexandra). If you
> > > > > > > > > > > > > > > > > > > > > > update the registrations on sou=
rce.denx.de can you then shut down your
> > > > > > > > > > > > > > > > > > > > > > gitlab instance?
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I've put a tag of 'single' on thi=
ngs that should run on the single-job
> > > > > > > > > > > > > > > > > > > > > runner. Everything else can run c=
oncurrently, e.g. up to 10 jobs. So I
> > > > > > > > > > > > > > > > > > > > > have two runners on the same host=
=2E E.g. tui-single has 'limit =3D 1',
> > > > > > > > > > > > > > > > > > > > > but 'tui' has no limit and is jus=
t governed by the 'concurrent =3D 10'
> > > > > > > > > > > > > > > > > > > > > at the top of the file.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Yes. And you could move those runne=
rs to the mainline gitlab. There is
> > > > > > > > > > > > > > > > > > > > no "single" tag, that would be the =
"all" tag. And "tui-single" would be
> > > > > > > > > > > > > > > > > > > > "fast amd64".
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > They are still attached to the Denx g=
itlab. Nothing has changed on my
> > > > > > > > > > > > > > > > > > > side. I'm not sure that your new tags=
 are working though. I have a
> > > > > > > > > > > > > > > > > > > feeling something broke along the way=
 when you made all your tag
> > > > > > > > > > > > > > > > > > > changes. One of my servers makes a bi=
t of noise and I haven't heard it
> > > > > > > > > > > > > > > > > > > in quite a while.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > There's a few of your runners that are =
"stale" and haven't contacted
> > > > > > > > > > > > > > > > > > gitlab in a long time. I'll double chec=
k the tags tho.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > If Denx would like to give me access =
to their gitlab instances, I'd be
> > > > > > > > > > > > > > > > > > > happy to play around and figure out h=
ow to get it going as fast as my
> > > > > > > > > > > > > > > > > > > tree does, and send a patch.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I'm not sure what you mean by that? The=
 instance itself?
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Yes. I can fiddle with tags on my runners=
 and try to figure it out.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'm not sure what you're getting at here. I=
f you mean "tags" in
> > > > > > > > > > > > > > > > /etc/gitlab-runner/config.toml those aren't=
 relevant here I believe.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > No, I mean the tags in CI. If I fiddle with t=
hem I can probably come
> > > > > > > > > > > > > > > up with a way to run your CI much faster. Min=
e is about 35mins.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm not so sure about that. Yours runs faster b=
ecause it tests less. Now
> > > > > > > > > > > > > > that we've got some of your other fast runners =
showing up again, this is
> > > > > > > > > > > > > > more instructive of current times I think:
> > > > > > > > > > > > > > https://source.denx.de/u-boot/u-boot/-/pipeline=
s/24802
> > > > > > > > > > > > >
> > > > > > > > > > > > > But not this? :
> > > > > > > > > > > >
> > > > > > > > > > > > You forgot a link. But presumably to some run yeste=
rday which took
> > > > > > > > > > > > longer. And because Ilias was tweaking the currentl=
y donated arm64
> > > > > > > > > > > > runners (that have other jobs to run) and also we h=
ad two or three
> > > > > > > > > > > > custodians at a time preparing trees, things ran sl=
ower.
> > > > > > > > > > >
> > > > > > > > > > > Maybe, but I don't think so.
> > > > > > > > > >
> > > > > > > > > > No need to "think" about it. You can look at the pipeli=
ne history and
> > > > > > > > > > see what was in queue for how long. And since I needed =
to be keeping an
> > > > > > > > > > eye on two of the 3 arm64 runners, I could see when cus=
todians were
> > > > > > > > > > firing off tests. Aside from the number of pull request=
s I had waiting
> > > > > > > > > > that morning.
> > > > > > > > >
> > > > > > > > > Your runs are reliably around an hour but mine are reliab=
ly just over
> > > > > > > > > 30 minutes. I only have three runners.
> > > > > > > > >
> > > > > > > > > https://source.denx.de/u-boot/u-boot/-/pipelines
> > > > > > > > > https://sjg.u-boot.org/u-boot/u-boot/-/pipelines
> > > > > > > > >
> > > > > > > > > I know you have added a duplicate build on arm64, but I c=
an still
> > > > > > > > > speed it up significantly if you'll allow me.
> > > > > > > >
> > > > > > > > I've never been stopping you.
> > > > > > >
> > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202411281600=
11.780550-1-sjg@chromium.org/
> > > > > >
> > > > > > Indeed. That gets back to what I keep telling you about how to =
test your
> > > > > > CI changes on source.denx.de.
> > > > >
> > > > > I don't understand your response here.
> > > >
> > > > Well, if we go to the next part..
> > > >
> > > > > > > > > > > > > > If you want to make mainline CI run faster you =
will need to catch up
> > > > > > > > > > > > > > with the missing coverage or argue that some th=
ings are redundant.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Or perhaps I can actually just make it faster wit=
hout dropping coverage?
> > > > > > > > > > > >
> > > > > > > > > > > > I mean, I don't know how that's physically possible=
, outside of adding
> > > > > > > > > > > > many more expensive build hosts. We have two-three =
fast arm64 hosts and
> > > > > > > > > > > > that world builds between 30-45 minutes. That's the=
 biggest time
> > > > > > > > > > > > bottleneck.
> > > > > > > > > > >
> > > > > > > > > > > Why did you join those builds up? It is better for th=
roughput to have
> > > > > > > > > > > a few runners working in parallel.
> > > > > > > > > >
> > > > > > > > > > Because I'm not optimizing for the single developer run=
ning CI case (or
> > > > > > > > > > the loads of fast runners case). If we had sufficient r=
esources, yes,
> > > > > > > > > > the fastest possible way would be 4 "fast arm64" server=
s and 4 "fast
> > > > > > > > > > amd64" servers each running if not 25% of the world bui=
ld, at least 4
> > > > > > > > > > easy to make and maintain groupings.
> > > > > > > > > >
> > > > > > > > > > However, we don't have that many of either. And they al=
so need to be
> > > > > > > > > > used for the biggest sandbox test suite jobs so that th=
ey run in about 5
> > > > > > > > > > minutes, not about 10 minutes. So in order to not entir=
ely block other
> > > > > > > > > > custodians we do a single world build. Because make and=
 buildman are
> > > > > > > > > > very good about otherwise fully loading the server. Run=
ning anything
> > > > > > > > > > else while that is going on will slow down the world bu=
ild (and, the
> > > > > > > > > > other job too).
> > > > > > > > >
> > > > > > > > > They're OK (on a fast machine) so long as the 'other' loa=
d is not too much.
> > > > > > > >
> > > > > > > > Things are OK until they aren't, yes. But just make sure yo=
u try out
> > > > > > > > some of the worst case (ie more than one pipeline at a time=
 running).
> > > > > > >
> > > > > > > We could collect stats on runs, I suppose. Perhaps it runs a =
lot when
> > > > > > > I am asleep.
> > > > > >
> > > > > > That's not what your pipeline shows? Or do you mean the runners=
? Yes,
> > > > > > the runners themselves are busy with jobs from source.denx.de.
> > > > >
> > > > > Mostly the runners seem fairly unloaded, so far as I can tell, bu=
t as
> > > > > I say, I don't have monitoring to see what happens at night.
> > > > >
> > > > > >
> > > > > > > > > > Aside, maintaining groupings is a pain. It was very bad=
 with Travis, and
> > > > > > > > > > it's only moderately painful with Azure where at least =
the end goal is
> > > > > > > > > > 10 pipelines for maximum concurrency. And with Azure ev=
eryone *can* get
> > > > > > > > > > their own "project" or whatever the right term is, and =
utilize 10
> > > > > > > > > > runners at once.
> > > > > > > > >
> > > > > > > > > Yes, but we can update buildman to handle grouping automa=
tically, as I
> > > > > > > > > suggested once.
> > > > > > > >
> > > > > > > > I'm not sure we want make buildman act like distcc as well =
here. If we
> > > > > > > > wanted to split the world in two, making it easy to say "ar=
m not armv8"
> > > > > > > > and "not (arm not armv8)" would be good enough.
> > > > > > >
> > > > > > > OK, yes that would be better as boards would be more sensibly=
 grouped.
> > > > > >
> > > > > > I look forward to your results on testing that, then as I can't=
 get that
> > > > > > kind of list from buildman today (starting problem,
> > > > > > "tools/buildman/buildman --dry-run -v all" is 10 boards).
> > > > >
> > > > > OK
> > > > >
> > > > > >
> > > > > > > > > > > > The next biggest is that unless sandbox tests are r=
un on a fast host,
> > > > > > > > > > > > they take upwards of 10 minutes, rather than 5.
> > > > > > > > > > >
> > > > > > > > > > > Yes, they are just getting slower and slower.
> > > > > > > > > >
> > > > > > > > > > Adding more tests takes more time. But the real questio=
n is which tests
> > > > > > > > > > take wall clock noticeable time, and why, and if we can=
 do anything
> > > > > > > > > > about it. My gut feeling is that it's in the disk image=
 related tests
> > > > > > > > > > and the user space verification of them.
> > > > > > > > > >
> > > > > > > > > > > > But please, rebase your work to next and see what y=
ou can do. There is
> > > > > > > > > > > > likely some speed-ups possible if we allow for fail=
ures to take longer
> > > > > > > > > > > > to happen (and don't gate world builds on all of te=
st.py stage
> > > > > > > > > > > > completing, just say sandbox). And if you do the wo=
rk on source.denx.de
> > > > > > > > > > > > (as there is *NOTHING* stopping you from registerin=
g more runners to
> > > > > > > > > > > > your tree and using whatever tagging scheme you lik=
e) you might even see
> > > > > > > > > > > > more of the time variability due to load from other=
 custodians.
> > > > > > > > > > >
> > > > > > > > > > > I can't edit the tags on the runners, nor can I adjus=
t them to run
> > > > > > > > > > > untagged jobs, nor can I delete runners I don't want,=
 so no, I believe
> > > > > > > > > > > I need access to do that.
> > > > > > > > > >
> > > > > > > > > > You can do all of that with runners specific to u-boot-=
dm, and you can
> > > > > > > > > > disable project / group runners yourself too. So yes, y=
ou can.
> > > > > > > > >
> > > > > > > > > Nope, sorry, I wasn't able to do any of this with the Den=
x tree as I
> > > > > > > > > can't adjust tags and can't delete and recreate runners.
> > > > > > > >
> > > > > > > > You don't have
> > > > > > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/settin=
gs/ci_cd#js-runners-settings
> > > > > > > > visible to you?
> > > > > > >
> > > > > > > Right. But also note that there are group runners on another =
page.
> > > > > >
> > > > > > And you disable them from the page I mentioned above. If you di=
sable all
> > > > > > of the existing project, group and shared runners (which are se=
ttings on
> > > > > > that page) you will have zero runners available for your tree. =
You can
> > > > > > then add project runners to only your project with whatever tag=
ging
> > > > > > scheme you like. You can then test your ideas about how tags wo=
uld work.
> > > > >
> > > > > OK, that sounds like a lot of hassle and you've already rejected =
my
> > > > > ideas here. Are you saying you are open to a change? I am asking
> > > > > because your last response suggested that my CI was no faster than
> > > > > yours, or that it was only faster because it has less testing.
> > > >
> > > > Once again I am trying to show you how to test your changes on the
> > > > mainline Gitlab server. Because you said you need your own gitlab (=
or
> > > > admin access to the u-boot space) to do this and that's not correct.
> > > >
> > > > I have rejected your idea because it doesn't seem like it would
> > > > actually be a win.
> > > >
> > > > I have asked you to prove me wrong by implementing your idea on
> > > > mainline, on the mainline gitlab server.
> > > >
> > > > You have declined thus far.
> > >
> > > I'm not trying to prove anyone wrong, nor am I interested in such an =
endeavour.
> > >
> > > >
> > > > And I am *always* open to being shown facts that show I was wrong. =
If
> > > > you can rework the CI jobs such that mainline is faster, and is sti=
ll
> > > > faster or at least no worse with multiple running pipelines, great.
> > > >
> > > > And yes, your tree is testing less things. This is a statement of f=
act.
> > > > You are neither running sandbox on arm64 (which exposed important b=
ugs)
> > > > nor world builds on arm64 (which exposed bugs within the Dockerfile=
 and
> > > > makes it clearer that buildman is very funky about using a "cross"
> > > > toolchain for the host processor).
> > >
> > > OK, sure.
> > >
> > > Anway, my offer stands and I'm confident I can spend it up, perhaps
> > > 80% faster. I need access to the server and the ability to change tags
> > > on the server while adding runners, experimenting, etc., obviously
> > > without changing existing runners, except that I may need to pause
> > > some for a few hours.
> >
> > I'm so tired of having multiple discussions at the same time. Again,
> > you're just wrong above. You do not need more access to show, or see
> > that you're wrong, about speeding up CI.
>=20
> Perhaps you are right and I can fiddle around with local runners. But
> I am reluctant to invest time in experimenting with things like that,
> since it then requires a lot more work to actually get it applied for
> real.
>=20
> I rarely use your CI so I don't mind. I was just suggesting that if I
> could make yours operate at the same speed as mine, then we could
> avoid the delta in that part of the project.

I guess we'll never know then. I keep saying that if you post things
against upstream they'll be reviewed and feedback given.

> > > > > > > > > > > > > > > > > > > I also have another runner to add.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I'll contact you off-list with the toke=
n.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > From my side, I have found it hel=
pful and refreshing to have a gitlab
> > > > > > > > > > > > > > > > > > > > > instance which I can control, e.g=
=2E it runs in half the time and if my
> > > > > > > > > > > > > > > > > > > > > patches are completely blocked by=
 Linaro, etc., I have an escape
> > > > > > > > > > > > > > > > > > > > > valve.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Yes, and I have no idea what any of=
 that has to do with anything other
> > > > > > > > > > > > > > > > > > > > than leading to confusion about wha=
t tree is or is not mainline. Since
> > > > > > > > > > > > > > > > > > > > you own u-boot.org and ci.u-boot.or=
g is your gitlab and
> > > > > > > > > > > > > > > > > > > > https://ci.u-boot.org/u-boot/u-boot=
/ is your personal tree.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > For now I am working with my tree, so=
 that I am not blocked by Linaro,
> > > > > > > > > > > > > > > > > > > etc. but as you have seen I can rebas=
e series for your tree as needed.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > And you're not addressing my point abou=
t using the project domain for
> > > > > > > > > > > > > > > > > > your personal tree. That's my big huge =
"are you forking the project or
> > > > > > > > > > > > > > > > > > what" problem.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I'm just making sure that my work is not =
blocked or lost, as that has
> > > > > > > > > > > > > > > > > happened too many times in the past few y=
ears.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Again, are you intending to fork the projec=
t? Putting your personal tree
> > > > > > > > > > > > > > > > in as "https://ci.u-boot.org/u-boot/u-boot.=
git" is not OK. I keep asking
> > > > > > > > > > > > > > > > you to stop it.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > No, I'm not intending to fork anything. But I=
 need a tree that I can
> > > > > > > > > > > > > > > control and push things into.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I don't know how you can call your personal tre=
e being at
> > > > > > > > > > > > > > "https://ci.u-boot.org/u-boot/u-boot.git" and s=
aying it's somewhere you
> > > > > > > > > > > > > > control and can push to while not also saying i=
t's a fork. If you want
> > > > > > > > > > > > > > to close down your gitlab and CNAME ci.u-boot.o=
rg to source.denx.de, you
> > > > > > > > > > > > > > can still push things to u-boot-dm. Or if that'=
s too constrained of a
> > > > > > > > > > > > > > namespace you can also get a contributors/sjg/ =
namespace. But what
> > > > > > > > > > > > > > you're doing today WILL lead to confusion.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I believe I've answered this question before. It =
is simply that I
> > > > > > > > > > > > > cannot get certain patches (bloblist, EFI, device=
tree) into your tree.
> > > > > > > > > > > > > There really isn't any other reason.
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, that's still not an answer to my question.
> > > > > > > > > > > >
> > > > > > > > > > > > Or is the answer to my question "Yes, I'm trying to=
 confuse people to
> > > > > > > > > > > > thinking my tree is mainline."
> > > > > > > > > > >
> > > > > > > > > > > No, it's simply that you are not taking some patches =
in your tree and
> > > > > > > > > > > complaining about the amount of patches.
> > > > > > > > > >
> > > > > > > > > > That's misleading at best. I'm not taking the patches t=
hat other
> > > > > > > > > > custodians have repeatedly rejected and explained why t=
hey're rejecting
> > > > > > > > > > them.
> > > > > > > > >
> > > > > > > > > Yes and this has affected my ability to move things forwa=
rd so much
> > > > > > > > > that I've had to set up my own tree. It has been working =
very well, to
> > > > > > > > > have a relief valve.
> > > > > > > >
> > > > > > > > It's been working pretty terrible for the rest of the proje=
ct as you
> > > > > > > > build on top of things that have been rejected and you're c=
ollecting in
> > > > > > > > your own personal downstream fork. Igor's email last night =
would be the
> > > > > > > > latest example of "I wanted to look at this but where is it=
?"
> > > > > > >
> > > > > > > You make it sound like it is some strange force from the void=
 that is
> > > > > > > creating these problems :-)
> > > > > >
> > > > > > No, I'm saying you're making these problems and I wish you woul=
d stop.
> > > > > >
> > > > > > > The EFI-app thing was killed in review, so I picked it up and=
 applied
> > > > > >
> > > > > > It was not "killed in review". It was posted once, given feedba=
ck and
> > > > > > you picked it up for your tree in what felt like a day later bu=
t I'm
> > > > > > sure was slightly longer than that.
> > > > >
> > > > > Just over two weeks, when it seemed to me it was dead. I had emai=
led
> > > > > Matthew several times asking if he could make time to post his wo=
rk.
> > > > > Telling him to refactor a load of the EFI_LOADER stuff just to ge=
t the
> > > > > app running seems wrong to me. I believe I already explained this=
 at
> > > > > the time.
> > > >
> > > > Waiting for answers to questions, which then did come along with
> > > > confusion about the state of the series given that you had applied =
it
> > > > somewhere else by then.
> > > >
> > > > On the merits, I'm entirely unsure without digging it all up on if
> > > > factoring out common code was or was not a reasonable request. I be=
lieve
> > > > there was other feedback on the series as well and it was certainly=
 not
> > > > a "ready to merge as v1" post.
> > >
> > > It certainly was ready to merge. It works fine, actually and I've been
> > > using it ever since. I'm very happy with it and have continued to
> > > build on it. My changes when applying were very minor, basically
> > > adding an include file to a header.
> > >
> > > Having said that, if people hadn't jumped down his throat so hard I
> > > would have waited, yes. I think I said that already.
> >
> > It was absolutely not ready to merge as-is. There was both feedback
> > major and minor. There was technical questions and philosophical
> > questions. I would be *shocked* if the authors expected it to be merged
> > as-is.
>=20
> OK, sorry I don't agree.

Then you should look at the series and all of the feedback again. There
was an issue or two with the command part for example. It was also
missing documentation I believe. That is standard regular normal
v2-is-expected type feedback.

> > > > > > > it and am now building on it (it now supports arm64). I menti=
oned
> > > > > > > before that I found that whole review process embarrassing (i=
f not
> > > > > > > mortifying) and it made me realise that I shouldn't tolerate =
it
> > > > > > > either. Matthew Garrett is the sort of engineer that people s=
hould
> > > > > > > *welcome* to the project. Yes, Heinrich and Ilias had some us=
eful
> > > > > > > feedback which I will get to at some point, but it works. Per=
haps I'll
> > > > > > > get into it when Linaro gets the lwip network tests running w=
ith
> > > > > > > sandbox :-)
> > > > > >
> > > > > > You know what, I'd really love feedback from Matthew about that.
> > > > > >
> > > > > > > The next step is to get it running in qemu with my lab...but =
you
> > > > > > > rejected that too I think? So it won't be in your tree unless=
 you
> > > > > > > change your mind on that.
> > > > > >
> > > > > > Did I reject making labgrid a requirement for tests? Yes, I did=
=2E Did I
> > > > > > explain why and offer alternatives? I also did. Does there seem=
 to be
> > > > > > any reason this next test of yours would require labgrid? No, t=
here does
> > > > > > not.
> > > > >
> > > > > We can't 'require' Labgrid. There are too many loose strawmans be=
ing
> > > > > thrown around here. But I want to use it in my lab and I want a t=
est
> > > > > which boots Ubuntu etc. in my lab using Labgrid. I explained that=
 I
> > > > > want to be able to interactively run the target ('ub-int qemu-86'=
) as
> > > > > well as run pytests ('ub-pyt qemu-x86 pxe') and in gitlab CI. Tha=
t all
> > > > > works today and all you need to do is not reject the patch.
> > > >
> > > > And I found it both hugely disappointing that you wrote something so
> > > > specific to your lab and non-replicable elsewhere and also "yes and=
" to
> > > > the patch. Perhaps that got missed along the way.
> > >
> > > I know it is disappointing, but don't imagine that I lack for
> > > disappointments. It solves the problem of testing a distro boot for
> > > me, while letting me run it locally. I can build on it easily enough.
> > >
> > > If you apply the series and I do come back to this, I would like to
> > > figure out how to make the lab Python files easier to work with.
> >
> > I already said a number of times that I would apply it, in time, if
> > against upstream. If you did your part, I will do mine.
>=20
> OK.
>=20
> >
> > > > > > > Again, it isn't a strange and unexplained force. It is just a
> > > > > > > consequence of your decisions here. If you were more flexible=
, I would
> > > > > > > have been able to continue as we were.
> > > > > >
> > > > > > The only way I could be more flexible here is to apply everythi=
ng you
> > > > > > post without question.
> > > > >
> > > > > That's the part of your thinking which I really struggle with. Th=
ere
> > > > > is a large amount of space in between that (which as you know I've
> > > > > never even suggested) and what I am looking for.
> > > >
> > > > And I keep struggling with how you don't see it. You want changes t=
hat
> > > > have been rejected for various valid technical reasons to be applied
> > > > over the objection of the custodian.
> > >
> > > That would be great, but I would settle for not blocking my patches,
> > > e.g. providing feedback on what to change.
> > >
> > > In any case, I thought I was devicetree custodian but my objections
> > > were ignored with Linaro patches. Same for bloblist. I started the EFI
> > > effort but can't get anything into that subsystem anymore, etc. I'm
> > > not complaining, just explaining why we are where we are.
> >
> > Yes, I've overruled you when you've had things wrong. If you want the
> > final say on stuff, please just go fork the project. We will survive.
> >
> > > > > The ANSI patch is an example of gratuitous rejection for no usefu=
l reason.
> > > >
> > > > It wasn't tho? Heinrich explained in another part of the thread whe=
re
> > > > there is a good spec required reason we're doing the sequences we're
> > > > doing. You either missed it or forgot it, I don't know which. But it
> > > > wasn't "gratuitous". It's a tricky part of the spec where we need to
> > > > come up with some clever solution for the case Michal hits.
> > >
> > > No it just seems wrong to me, sorry. Of course we can do those
> > > sequences, We just need a way to disable them when we know they are
> > > not required. There is no need for a 'clever solution'. Just design it
> > > properly. If we carried on like that (emitting random junk and writing
> > > loads of work-arounds elsewhere in U-Boot to ignore the junk) the
> > > codebase would eventually become a steaming pile of manure.
> >
> > Again, it looks like you're ignoring the facts in favor of your
> > opinions.
>=20
> Or it could be that I'm right? It has happened before, sometimes.

Again, it's a matter of facts and not opinion here. It's the "how big is
the terminal" ANSI sequence. It must be done. There's perhaps some
compromise option that spells out we're breaking the spec a tiny bit for
some use case, which your patch was not.

> > > > > Given the number of emails I'm genuinely surprised at the lack of
> > > > > progress we have made here.
> > > >
> > > > I'm not surprised because I keep having to repeat myself.
> > >
> > > You don't have to repeat yourself. It isn't that I can't hear you,
> > > it's that I disagree. People can have different opinions on things and
> > > still work together on shared goals. But there needs to be give and
> > > take.
> >
> > There has been give and take. And you may leave, if you can't accept No.
> >
> > > Really, you could just change your mind on some of these things and it
> > > would make a difference.
> >
> > I'll re-evaluate things, sure. But I won't just change my mind when
> > you're wrong.
> >
> > > > > Again, your decisions and position have produced the situation we=
 are
> > > > > in now. Much is in your control. If you are interested in changing
> > > > > anything, even a little, I'm sure it would help.
> > > >
> > > > OK. What's one request you have of me that should be clear and
> > > > un-objectionable?
> > >
> > > I should really leave that to you to decide. Some things that are top
> > > of mind are:
> > >
> > > a) sunxi, which has blocked all future bootstd migration
> >
> > Hard no. See my detailed explanation already.
>=20
> OK.
>=20
> >
> > > b) PXE, blocked on doing lwip work which I am not willing to do until
> > > my series is applied
> >
> > Then you can wait for Jerome to have time? It looks like he started on
> > part of that recently.
>=20
> OK.
>=20
> >
> > > c) ANSI:
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20240926220226.12659=
65-9-sjg@chromium.org/
> >
> > Hard no. The custodian has already explained that it's done for a reason
> > and not on a whim. Whatever solution Heinrich is happy with to the
> > actual problem Michal reported is what we'll go with.
>=20
> OK.
>=20
> If there is any small thing in which you would be willing to be
> flexible, it would be good to hear it.

Given that VBE is in-tree at all I've been quite flexible.

> > > > > > > > > > > > > At the moment your CI seems to be flaky as well:
> > > > > > > > > > > > >
> > > > > > > > > > > > > https://source.denx.de/u-boot/custodians/u-boot-d=
m/-/jobs/1038174
> > > > > > > > > > > >
> > > > > > > > > > > > [aside, I think you meant to link to the pipeline i=
tself, which also
> > > > > > > > > > > > passed, but had some retries]
> > > > > > > > > > > >
> > > > > > > > > > > > Funny story. Ilias needed to tweak the fast arm64 h=
osts and also wanted
> > > > > > > > > > > > to explore "What if we have concurrency higher?" an=
d ran in to the
> > > > > > > > > > > > problems you also ran in to with respect to git see=
ing an existing clone
> > > > > > > > > > > > in progress and bailing. Followed by the problem of=
 multiple non-trivial
> > > > > > > > > > > > jobs running concurrently.
> > > > > > > > > > > >
> > > > > > > > > > > > All of which is why I keep trying to tell you that =
while "single" and
> > > > > > > > > > > > concurrent runners work fine for you on a single us=
er instance it will
> > > > > > > > > > > > not scale.
> > > > > > > > > > >
> > > > > > > > > > > Yes, but I solved that with the patch I sent and it s=
eems to be 100%
> > > > > > > > > > > reliable now.
> > > > > > > > > >
> > > > > > > > > > Yes, you eventually solved it with 3 patches, which I a=
sked you to
> > > > > > > > > > rebase and squash to two patches (because #3 just fixes=
 that #2 wasn't
> > > > > > > > > > sufficient) and you declined.
> > > > > > > > >
> > > > > > > > > In general, why not just be more open to my ideas, even j=
ust try it
> > > > > > > > > for a year? Given the tools I'm confident I can speed up =
your CI as
> > > > > > > > > well.
> > > > > > > >
> > > > > > > > I've never not been open to applying patches to mainline th=
at are
> > > > > > > > against mainline. I am not going to rebase your work for yo=
u however.
> > > > > > > > And I think it's terrible for the project as a whole when y=
ou post
> > > > > > > > changes against your tree and people expect to be able to r=
eview them
> > > > > > > > and then can't because it's against your downstream fork.
> > > > > > >
> > > > > > > I've started mentioning the base commit in patman and I think=
 I'll
> > > > > > > update it to show the source tree as well. I understand the r=
ebasing
> > > > > > > is a pain and I am certainly happy to shoulder some of that l=
oad. E.g.
> > > > > > > I can send a PR for each series when you are ready to accept =
it. If
> > > > > > > you like. Perhaps we can set a timeline for that (e.g. no com=
ments for
> > > > > > > a week?)
> > > > > >
> > > > > > You are subject to the same general timelines as everyone else.=
 When
> > > > > > your patches apply to mainline and aren't rejected. Which is "a=
bout two
> > > > > > weeks" and has been for about 15 years now. Sometimes I will pu=
ll things
> > > > > > in sooner when they're smaller / clearer, but that typically do=
esn't
> > > > > > apply to your very large series with multiple changes in it.
> > > > >
> > > > > OK, well again I'm happy to send a PR for things that haven't been
> > > > > rejected for your tree.
> > > >
> > > > OK. So looking at:
> > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D&submitte=
r=3D&state=3D&q=3D&archive=3D&delegate=3D3184
> > > > Right now, there's patches for you lab that need to be rebased to n=
ext
> > > > (and feedback addressed, or set aside the i.MX target for now / mak=
e a
> > > > new thread about the general problem there). A patch from Heinrich.=
 A
> > > > series from Caleb. The last two certainly, and whatever of the lab =
stuff
> > > > applies, could be in a PR for next whenever you're ready.
> > >
> > > Looking at it now there is an ACPI series from Heinrich which should
> > > go in after my qemu-x86 series. There's another ACPI series from
> > > Linaro which looks fine. I've assigned both to you.
> >
> > And this is why I don't think you want to work in mainline anyhow.
>=20
> It's not for want of trying, believe me.

If you don't want to work in mainline, you should just give the
community the domain and move on. What you're doing is not helping the
community.

> I think this thread can be parked as it has come to a logical end.
>=20
> Regards,
> Simon

--=20
Tom

--AygqJRX5M12uqDPL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfsHokACgkQFHw5/5Y0
tywaMAv/UwBHqQWFMeycn2vTUNVpK/1xnuqi/40uoIFUmJU0lDnI5qa13DmfSXab
Z/ydLs74Nmu3mmmpHjQCL1lnFGHdcDQoSQ/CEuN55X/2oTFI0YPtCUwpRKwTcR+D
E8Hr6G/fsI7UN6njZpMa4/y4m3sMH635mEisCwNKlwGN/qQH0yUGuJTboAdV04jp
X5yqO373gd2X8SZblGOi2cee1mjcXM0pAdTI0PTKaofnnEYY6T3lLmf1TnPXZ4oY
VAxQ04w9KJNL2FqtIBzjCEr7srMhQMSOtrHK73tTk/Iq5MUBUnGsHyuKC3zyeMn8
YMRCugLkp6eiQpXGRyuvrYbg0eeMozceBA7A9I5uD4M0YpvewZgw4mYN9tQ4qWak
ZSRnXOTRI1+EdR7YfXsb1fA2NN/e10S46WM80mRWslhl8IgTu8dUtDBwh11aZr56
il22D3xawqbBqfY54vtCXNmaHFtc/OvTKSBmAzBMZ6opUxfvCf83R5ozzbp5hKZ0
dGRQAiRK
=Mr/b
-----END PGP SIGNATURE-----

--AygqJRX5M12uqDPL--
