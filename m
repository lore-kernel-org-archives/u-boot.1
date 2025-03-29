Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860B6C28B20
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 00:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE74D80ECC;
	Sat, 29 Mar 2025 01:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rci3hi7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBF980F0E; Sat, 29 Mar 2025 01:25:46 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D04809A5
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 01:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3feb3f54339so2029306b6e.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743207941; x=1743812741; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XzkoSiXJFb3EUeBMeSKr2Uy41tKWeP5RzlAdOwOYBEM=;
 b=Rci3hi7IRtUOT/V1xnV5MOhDqR1KQpwld94wcsW4+1NWcowad24hBCMLE8djyXcdQk
 +TZzI64pxWkztj/KLQXwFu7OueYF3UY0AgZqy8N8xa83aGfulx91E5qaLas1/FbZEjjK
 x31CdWlgMYVNxlXTafVj8L9uKohABEWlnkSY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743207941; x=1743812741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzkoSiXJFb3EUeBMeSKr2Uy41tKWeP5RzlAdOwOYBEM=;
 b=apFJwnGS0x2P37Q7v2l+BUJeaUo0vxQe8Cnrn89/o4drCpJuTKoJn+eXy+0OkEDKAH
 8H9ZKiMuhd0oajDdC3MmCsvauGdtzI+dg0VWxuBgi1zhJ+YwfZGnccPnAnGBZbyLww8O
 vnWfYOoq+9Bgh1ZZS3FqWVPJxSY1NUGhHoFsoXmvRejJ1N/29mgtZ0CR4AqC44Zx5G0f
 c84J3BEMtPfPQyxltOGCHQP/OQlRfMCdGjIpobWnflaFWBhyWX1ZeNYatWFHu5FXXqt2
 Ge7b9MHinG7L2yqrvLmoKSEjz4TKqCYNTrBHAQdZUElis8bibkDSExw0dNizQK+xhlsr
 SXmg==
X-Gm-Message-State: AOJu0YyO1OzmLWNVTNFNutPxIzD+hxML7maO72RM5hbj6dFG5v/RV4JR
 SWQosH24SUjshLtsn9GkLkcQvQJh825PebZVfLFnbmYaTZ6Cm2BHALqjmbGxXaI=
X-Gm-Gg: ASbGnctmjtTSaALFu0+1iREpizzLTvVIYU6MROsATQCJ45rell06N9mjeULKdMJN8If
 D5orowZNJgXruiYCXMu1CLq01dcKIQ6N2bCCUboxZMDt+uy0fLImncW+bmZoENGthOcfbtLXOFi
 /V8Vm9Pw8Myv9uJc9OZHPzU4mWrEQU3Z8IG7LvcUq9MAKLrR+v2muySY1i/bWIgxrkR4qQP/4lD
 Jd4KbZ0Toun9oj0Xk5NMttAemP4ldMw2fXDpIIytvKfIFLBwQUaSBzX6u1LrVIhD8lYsdbaEvOK
 uQio/ZupNBES04QYG2maiDW+U6VuFzfgjabGUF/xhWDv8fMvXBBSMixyx4Kuj7ZOGq6HVN8u0rW
 maM1eiA==
X-Google-Smtp-Source: AGHT+IFXM1wejn5UWeLPJzFzXWjUQGcsluYR1TdvnBvbvWUTiqWxX1ln3yUICh5XNQjNEfvWsRdSsQ==
X-Received: by 2002:a05:6808:168a:b0:3f7:d16c:e283 with SMTP id
 5614622812f47-3ff0f50fa36mr759212b6e.11.1743207940425; 
 Fri, 28 Mar 2025 17:25:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602846221e5sm532348eaf.40.2025.03.28.17.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 17:25:39 -0700 (PDT)
Date: Fri, 28 Mar 2025 18:25:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250329002537.GN93000@bill-the-cat>
References: <20250227170352.GZ2640854@bill-the-cat>
 <CAFLszTgDms-RC+Qg=FLxtW253jh22eUb1Y-5OyB2U42EygdZWw@mail.gmail.com>
 <20250304161218.GA2640854@bill-the-cat>
 <CAFLszTj1hc7esvd_R3oVEqOpSBNFcRga0wmR3hnTsFELXi+m1g@mail.gmail.com>
 <20250305160631.GS2640854@bill-the-cat>
 <CAFLszTix7phNcsECa5Nwve-1g0fD6G0HZ=eWXxaHTjZp0+K9Xw@mail.gmail.com>
 <20250306143047.GA2640854@bill-the-cat>
 <CAFLszTh47L11V7sbfbd2zaCs7rYpuPLTX4rBKnkUn8oQ9xUeXQ@mail.gmail.com>
 <20250306171302.GG2640854@bill-the-cat>
 <CAFLszTi4hK=oXbtA+67eeZOh8icfMWNtAn98Yyuk_8BaK=7M+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ok3pxGMJNKILftW1"
Content-Disposition: inline
In-Reply-To: <CAFLszTi4hK=oXbtA+67eeZOh8icfMWNtAn98Yyuk_8BaK=7M+g@mail.gmail.com>
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


--ok3pxGMJNKILftW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 11:47:12PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Mar 2025 at 10:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 06, 2025 at 09:13:52AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 6 Mar 2025 at 07:37, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Mar 06, 2025 at 06:59:08AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 5 Mar 2025 at 09:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 05, 2025 at 07:18:40AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 4 Mar 2025 at 09:12, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Tue, Mar 04, 2025 at 08:35:56AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Thu, 27 Feb 2025 at 10:03, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Feb 27, 2025 at 09:26:10AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 24 Feb 2025 at 16:14, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sat, Feb 22, 2025 at 05:24:05PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Sat, 22 Feb 2025 at 14:37, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sat, Feb 22, 2025 at 10:23:59AM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 17:08, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 04:42:09PM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 07:14, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 06:14:06AM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Sun, 16 Feb 2025 at 14:52, Tom Rin=
i <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 12:39:34PM =
-0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Sun, 16 Feb 2025 at 09:07, Tom=
 Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 07:10:1=
2AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 11:12,=
 Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 10:=
21:16AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 07=
:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at=
 04:59:40AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > On Mon, 10 Feb 2025 a=
t 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > On Thu, Feb 06, 202=
5 at 03:38:55PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > This is a global =
default, so put it under 'default' like the tags.
> > > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > Signed-off-by: Si=
mon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > Suggested-by: Tom=
 Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > Reviewed-by: Tom =
Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > > Please make v4 incl=
ude the way you redid the second patch and be on top
> > > > > > > > > > > > > > > > > > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > > That's enough version=
s for me, so I'll let you do that, if you'd like.
> > > > > > > > > > > > > > > > > > > > > > > > > > > It probably doesn't a=
ffect your tree as not as much is done in
> > > > > > > > > > > > > > > > > > > > > > > > > > > parallel.
> > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > I am disappointed.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > I'm sorry to disappoint y=
ou.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > The background is that I =
looked at the difference between our trees
> > > > > > > > > > > > > > > > > > > > > > > > > and the gitlab files are =
quite different. My CI runs take about 35
> > > > > > > > > > > > > > > > > > > > > > > > > mins and it seems that yo=
urs is around 90 mins. I would like to reduce
> > > > > > > > > > > > > > > > > > > > > > > > > / remove the delta (for t=
ime and patch diff), but I'm not sure how.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > My goal is to get CI runs=
 to below 20 minutes, best case.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > I'm sure CI could be quicke=
r still with a number of faster runners. But
> > > > > > > > > > > > > > > > > > > > > > > > if you can't be bothered to=
 make changes against mainline, what is the
> > > > > > > > > > > > > > > > > > > > > > > > point?
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > If you recall, I was working =
with your tree and had various ideas to
> > > > > > > > > > > > > > > > > > > > > > > speed things up, but you didn=
't like it. So I've had to do it in my
> > > > > > > > > > > > > > > > > > > > > > > tree. This is not about more =
runners (although I might have another
> > > > > > > > > > > > > > > > > > > > > > > one soon). It is about runnin=
g jobs in parallel.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > And I wasn't sure more runners =
in parallel would help (as it would slow
> > > > > > > > > > > > > > > > > > > > > > down the fast runner which is w=
hat keeps the long jobs from being even
> > > > > > > > > > > > > > > > > > > > > > longer) as much as adding more =
regular runners would (which we've done)
> > > > > > > > > > > > > > > > > > > > > > and noted that in the end it's =
a configuration on the runner side so to
> > > > > > > > > > > > > > > > > > > > > > go ahead. And I reviewed and ac=
k'd the patches here which exposed the
> > > > > > > > > > > > > > > > > > > > > > issues your path revealed. I ju=
st can't apply them because they need to
> > > > > > > > > > > > > > > > > > > > > > be rebased (and squashed).
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > You have already added tags for t=
hings, but (IIUC) they are around the
> > > > > > > > > > > > > > > > > > > > > other way from what I have added.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I have a tag called 'single' whic=
h means that the machine is only
> > > > > > > > > > > > > > > > > > > > > allowed to one of those jobs. The=
 world-build jobs are marked with
> > > > > > > > > > > > > > > > > > > > > 'single'.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > For other jobs, I allow the runne=
rs to pick up some in parallel
> > > > > > > > > > > > > > > > > > > > > depending on their performance (f=
or moa and tui that is 10).
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > So at most, there is a 'world bui=
ld' and 10 test.py jobs running on
> > > > > > > > > > > > > > > > > > > > > the same machine. It seems to wor=
k fine in practice, although I would
> > > > > > > > > > > > > > > > > > > > > rather be able to make these two =
types of jobs mutually exclusive, so
> > > > > > > > > > > > > > > > > > > > > that a runner is either running 1=
0 parallel jobs or 1 'single' job,
> > > > > > > > > > > > > > > > > > > > > but not both. I'm not sure how to=
 do that.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > So unless I'm missing something, in=
 both cases the bottleneck is that
> > > > > > > > > > > > > > > > > > > > for world build jobs you don't want=
 anything else going on with the
> > > > > > > > > > > > > > > > > > > > underlying build host. You could re=
gister 10 "all" runners and 1 "fast
> > > > > > > > > > > > > > > > > > > > amd64" runner (and something simila=
r but smaller for alexandra). If you
> > > > > > > > > > > > > > > > > > > > update the registrations on source.=
denx.de can you then shut down your
> > > > > > > > > > > > > > > > > > > > gitlab instance?
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > I've put a tag of 'single' on things =
that should run on the single-job
> > > > > > > > > > > > > > > > > > > runner. Everything else can run concu=
rrently, e.g. up to 10 jobs. So I
> > > > > > > > > > > > > > > > > > > have two runners on the same host. E.=
g. tui-single has 'limit =3D 1',
> > > > > > > > > > > > > > > > > > > but 'tui' has no limit and is just go=
verned by the 'concurrent =3D 10'
> > > > > > > > > > > > > > > > > > > at the top of the file.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Yes. And you could move those runners t=
o the mainline gitlab. There is
> > > > > > > > > > > > > > > > > > no "single" tag, that would be the "all=
" tag. And "tui-single" would be
> > > > > > > > > > > > > > > > > > "fast amd64".
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > They are still attached to the Denx gitla=
b. Nothing has changed on my
> > > > > > > > > > > > > > > > > side. I'm not sure that your new tags are=
 working though. I have a
> > > > > > > > > > > > > > > > > feeling something broke along the way whe=
n you made all your tag
> > > > > > > > > > > > > > > > > changes. One of my servers makes a bit of=
 noise and I haven't heard it
> > > > > > > > > > > > > > > > > in quite a while.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > There's a few of your runners that are "sta=
le" and haven't contacted
> > > > > > > > > > > > > > > > gitlab in a long time. I'll double check th=
e tags tho.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > If Denx would like to give me access to t=
heir gitlab instances, I'd be
> > > > > > > > > > > > > > > > > happy to play around and figure out how t=
o get it going as fast as my
> > > > > > > > > > > > > > > > > tree does, and send a patch.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'm not sure what you mean by that? The ins=
tance itself?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes. I can fiddle with tags on my runners and=
 try to figure it out.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm not sure what you're getting at here. If yo=
u mean "tags" in
> > > > > > > > > > > > > > /etc/gitlab-runner/config.toml those aren't rel=
evant here I believe.
> > > > > > > > > > > > >
> > > > > > > > > > > > > No, I mean the tags in CI. If I fiddle with them =
I can probably come
> > > > > > > > > > > > > up with a way to run your CI much faster. Mine is=
 about 35mins.
> > > > > > > > > > > >
> > > > > > > > > > > > I'm not so sure about that. Yours runs faster becau=
se it tests less. Now
> > > > > > > > > > > > that we've got some of your other fast runners show=
ing up again, this is
> > > > > > > > > > > > more instructive of current times I think:
> > > > > > > > > > > > https://source.denx.de/u-boot/u-boot/-/pipelines/24=
802
> > > > > > > > > > >
> > > > > > > > > > > But not this? :
> > > > > > > > > >
> > > > > > > > > > You forgot a link. But presumably to some run yesterday=
 which took
> > > > > > > > > > longer. And because Ilias was tweaking the currently do=
nated arm64
> > > > > > > > > > runners (that have other jobs to run) and also we had t=
wo or three
> > > > > > > > > > custodians at a time preparing trees, things ran slower.
> > > > > > > > >
> > > > > > > > > Maybe, but I don't think so.
> > > > > > > >
> > > > > > > > No need to "think" about it. You can look at the pipeline h=
istory and
> > > > > > > > see what was in queue for how long. And since I needed to b=
e keeping an
> > > > > > > > eye on two of the 3 arm64 runners, I could see when custodi=
ans were
> > > > > > > > firing off tests. Aside from the number of pull requests I =
had waiting
> > > > > > > > that morning.
> > > > > > >
> > > > > > > Your runs are reliably around an hour but mine are reliably j=
ust over
> > > > > > > 30 minutes. I only have three runners.
> > > > > > >
> > > > > > > https://source.denx.de/u-boot/u-boot/-/pipelines
> > > > > > > https://sjg.u-boot.org/u-boot/u-boot/-/pipelines
> > > > > > >
> > > > > > > I know you have added a duplicate build on arm64, but I can s=
till
> > > > > > > speed it up significantly if you'll allow me.
> > > > > >
> > > > > > I've never been stopping you.
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241128160011.7=
80550-1-sjg@chromium.org/
> > > >
> > > > Indeed. That gets back to what I keep telling you about how to test=
 your
> > > > CI changes on source.denx.de.
> > >
> > > I don't understand your response here.
> >
> > Well, if we go to the next part..
> >
> > > > > > > > > > > > If you want to make mainline CI run faster you will=
 need to catch up
> > > > > > > > > > > > with the missing coverage or argue that some things=
 are redundant.
> > > > > > > > > > >
> > > > > > > > > > > Or perhaps I can actually just make it faster without=
 dropping coverage?
> > > > > > > > > >
> > > > > > > > > > I mean, I don't know how that's physically possible, ou=
tside of adding
> > > > > > > > > > many more expensive build hosts. We have two-three fast=
 arm64 hosts and
> > > > > > > > > > that world builds between 30-45 minutes. That's the big=
gest time
> > > > > > > > > > bottleneck.
> > > > > > > > >
> > > > > > > > > Why did you join those builds up? It is better for throug=
hput to have
> > > > > > > > > a few runners working in parallel.
> > > > > > > >
> > > > > > > > Because I'm not optimizing for the single developer running=
 CI case (or
> > > > > > > > the loads of fast runners case). If we had sufficient resou=
rces, yes,
> > > > > > > > the fastest possible way would be 4 "fast arm64" servers an=
d 4 "fast
> > > > > > > > amd64" servers each running if not 25% of the world build, =
at least 4
> > > > > > > > easy to make and maintain groupings.
> > > > > > > >
> > > > > > > > However, we don't have that many of either. And they also n=
eed to be
> > > > > > > > used for the biggest sandbox test suite jobs so that they r=
un in about 5
> > > > > > > > minutes, not about 10 minutes. So in order to not entirely =
block other
> > > > > > > > custodians we do a single world build. Because make and bui=
ldman are
> > > > > > > > very good about otherwise fully loading the server. Running=
 anything
> > > > > > > > else while that is going on will slow down the world build =
(and, the
> > > > > > > > other job too).
> > > > > > >
> > > > > > > They're OK (on a fast machine) so long as the 'other' load is=
 not too much.
> > > > > >
> > > > > > Things are OK until they aren't, yes. But just make sure you tr=
y out
> > > > > > some of the worst case (ie more than one pipeline at a time run=
ning).
> > > > >
> > > > > We could collect stats on runs, I suppose. Perhaps it runs a lot =
when
> > > > > I am asleep.
> > > >
> > > > That's not what your pipeline shows? Or do you mean the runners? Ye=
s,
> > > > the runners themselves are busy with jobs from source.denx.de.
> > >
> > > Mostly the runners seem fairly unloaded, so far as I can tell, but as
> > > I say, I don't have monitoring to see what happens at night.
> > >
> > > >
> > > > > > > > Aside, maintaining groupings is a pain. It was very bad wit=
h Travis, and
> > > > > > > > it's only moderately painful with Azure where at least the =
end goal is
> > > > > > > > 10 pipelines for maximum concurrency. And with Azure everyo=
ne *can* get
> > > > > > > > their own "project" or whatever the right term is, and util=
ize 10
> > > > > > > > runners at once.
> > > > > > >
> > > > > > > Yes, but we can update buildman to handle grouping automatica=
lly, as I
> > > > > > > suggested once.
> > > > > >
> > > > > > I'm not sure we want make buildman act like distcc as well here=
=2E If we
> > > > > > wanted to split the world in two, making it easy to say "arm no=
t armv8"
> > > > > > and "not (arm not armv8)" would be good enough.
> > > > >
> > > > > OK, yes that would be better as boards would be more sensibly gro=
uped.
> > > >
> > > > I look forward to your results on testing that, then as I can't get=
 that
> > > > kind of list from buildman today (starting problem,
> > > > "tools/buildman/buildman --dry-run -v all" is 10 boards).
> > >
> > > OK
> > >
> > > >
> > > > > > > > > > The next biggest is that unless sandbox tests are run o=
n a fast host,
> > > > > > > > > > they take upwards of 10 minutes, rather than 5.
> > > > > > > > >
> > > > > > > > > Yes, they are just getting slower and slower.
> > > > > > > >
> > > > > > > > Adding more tests takes more time. But the real question is=
 which tests
> > > > > > > > take wall clock noticeable time, and why, and if we can do =
anything
> > > > > > > > about it. My gut feeling is that it's in the disk image rel=
ated tests
> > > > > > > > and the user space verification of them.
> > > > > > > >
> > > > > > > > > > But please, rebase your work to next and see what you c=
an do. There is
> > > > > > > > > > likely some speed-ups possible if we allow for failures=
 to take longer
> > > > > > > > > > to happen (and don't gate world builds on all of test.p=
y stage
> > > > > > > > > > completing, just say sandbox). And if you do the work o=
n source.denx.de
> > > > > > > > > > (as there is *NOTHING* stopping you from registering mo=
re runners to
> > > > > > > > > > your tree and using whatever tagging scheme you like) y=
ou might even see
> > > > > > > > > > more of the time variability due to load from other cus=
todians.
> > > > > > > > >
> > > > > > > > > I can't edit the tags on the runners, nor can I adjust th=
em to run
> > > > > > > > > untagged jobs, nor can I delete runners I don't want, so =
no, I believe
> > > > > > > > > I need access to do that.
> > > > > > > >
> > > > > > > > You can do all of that with runners specific to u-boot-dm, =
and you can
> > > > > > > > disable project / group runners yourself too. So yes, you c=
an.
> > > > > > >
> > > > > > > Nope, sorry, I wasn't able to do any of this with the Denx tr=
ee as I
> > > > > > > can't adjust tags and can't delete and recreate runners.
> > > > > >
> > > > > > You don't have
> > > > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/settings/c=
i_cd#js-runners-settings
> > > > > > visible to you?
> > > > >
> > > > > Right. But also note that there are group runners on another page.
> > > >
> > > > And you disable them from the page I mentioned above. If you disabl=
e all
> > > > of the existing project, group and shared runners (which are settin=
gs on
> > > > that page) you will have zero runners available for your tree. You =
can
> > > > then add project runners to only your project with whatever tagging
> > > > scheme you like. You can then test your ideas about how tags would =
work.
> > >
> > > OK, that sounds like a lot of hassle and you've already rejected my
> > > ideas here. Are you saying you are open to a change? I am asking
> > > because your last response suggested that my CI was no faster than
> > > yours, or that it was only faster because it has less testing.
> >
> > Once again I am trying to show you how to test your changes on the
> > mainline Gitlab server. Because you said you need your own gitlab (or
> > admin access to the u-boot space) to do this and that's not correct.
> >
> > I have rejected your idea because it doesn't seem like it would
> > actually be a win.
> >
> > I have asked you to prove me wrong by implementing your idea on
> > mainline, on the mainline gitlab server.
> >
> > You have declined thus far.
>=20
> I'm not trying to prove anyone wrong, nor am I interested in such an ende=
avour.
>=20
> >
> > And I am *always* open to being shown facts that show I was wrong. If
> > you can rework the CI jobs such that mainline is faster, and is still
> > faster or at least no worse with multiple running pipelines, great.
> >
> > And yes, your tree is testing less things. This is a statement of fact.
> > You are neither running sandbox on arm64 (which exposed important bugs)
> > nor world builds on arm64 (which exposed bugs within the Dockerfile and
> > makes it clearer that buildman is very funky about using a "cross"
> > toolchain for the host processor).
>=20
> OK, sure.
>=20
> Anway, my offer stands and I'm confident I can spend it up, perhaps
> 80% faster. I need access to the server and the ability to change tags
> on the server while adding runners, experimenting, etc., obviously
> without changing existing runners, except that I may need to pause
> some for a few hours.

I'm so tired of having multiple discussions at the same time. Again,
you're just wrong above. You do not need more access to show, or see
that you're wrong, about speeding up CI.

> > > > > > > > > > > > > > > > > I also have another runner to add.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'll contact you off-list with the token.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > From my side, I have found it helpful=
 and refreshing to have a gitlab
> > > > > > > > > > > > > > > > > > > instance which I can control, e.g. it=
 runs in half the time and if my
> > > > > > > > > > > > > > > > > > > patches are completely blocked by Lin=
aro, etc., I have an escape
> > > > > > > > > > > > > > > > > > > valve.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Yes, and I have no idea what any of tha=
t has to do with anything other
> > > > > > > > > > > > > > > > > > than leading to confusion about what tr=
ee is or is not mainline. Since
> > > > > > > > > > > > > > > > > > you own u-boot.org and ci.u-boot.org is=
 your gitlab and
> > > > > > > > > > > > > > > > > > https://ci.u-boot.org/u-boot/u-boot/ is=
 your personal tree.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > For now I am working with my tree, so tha=
t I am not blocked by Linaro,
> > > > > > > > > > > > > > > > > etc. but as you have seen I can rebase se=
ries for your tree as needed.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > And you're not addressing my point about us=
ing the project domain for
> > > > > > > > > > > > > > > > your personal tree. That's my big huge "are=
 you forking the project or
> > > > > > > > > > > > > > > > what" problem.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I'm just making sure that my work is not bloc=
ked or lost, as that has
> > > > > > > > > > > > > > > happened too many times in the past few years.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Again, are you intending to fork the project? P=
utting your personal tree
> > > > > > > > > > > > > > in as "https://ci.u-boot.org/u-boot/u-boot.git"=
 is not OK. I keep asking
> > > > > > > > > > > > > > you to stop it.
> > > > > > > > > > > > >
> > > > > > > > > > > > > No, I'm not intending to fork anything. But I nee=
d a tree that I can
> > > > > > > > > > > > > control and push things into.
> > > > > > > > > > > >
> > > > > > > > > > > > I don't know how you can call your personal tree be=
ing at
> > > > > > > > > > > > "https://ci.u-boot.org/u-boot/u-boot.git" and sayin=
g it's somewhere you
> > > > > > > > > > > > control and can push to while not also saying it's =
a fork. If you want
> > > > > > > > > > > > to close down your gitlab and CNAME ci.u-boot.org t=
o source.denx.de, you
> > > > > > > > > > > > can still push things to u-boot-dm. Or if that's to=
o constrained of a
> > > > > > > > > > > > namespace you can also get a contributors/sjg/ name=
space. But what
> > > > > > > > > > > > you're doing today WILL lead to confusion.
> > > > > > > > > > >
> > > > > > > > > > > I believe I've answered this question before. It is s=
imply that I
> > > > > > > > > > > cannot get certain patches (bloblist, EFI, devicetree=
) into your tree.
> > > > > > > > > > > There really isn't any other reason.
> > > > > > > > > >
> > > > > > > > > > Yes, that's still not an answer to my question.
> > > > > > > > > >
> > > > > > > > > > Or is the answer to my question "Yes, I'm trying to con=
fuse people to
> > > > > > > > > > thinking my tree is mainline."
> > > > > > > > >
> > > > > > > > > No, it's simply that you are not taking some patches in y=
our tree and
> > > > > > > > > complaining about the amount of patches.
> > > > > > > >
> > > > > > > > That's misleading at best. I'm not taking the patches that =
other
> > > > > > > > custodians have repeatedly rejected and explained why they'=
re rejecting
> > > > > > > > them.
> > > > > > >
> > > > > > > Yes and this has affected my ability to move things forward s=
o much
> > > > > > > that I've had to set up my own tree. It has been working very=
 well, to
> > > > > > > have a relief valve.
> > > > > >
> > > > > > It's been working pretty terrible for the rest of the project a=
s you
> > > > > > build on top of things that have been rejected and you're colle=
cting in
> > > > > > your own personal downstream fork. Igor's email last night woul=
d be the
> > > > > > latest example of "I wanted to look at this but where is it?"
> > > > >
> > > > > You make it sound like it is some strange force from the void tha=
t is
> > > > > creating these problems :-)
> > > >
> > > > No, I'm saying you're making these problems and I wish you would st=
op.
> > > >
> > > > > The EFI-app thing was killed in review, so I picked it up and app=
lied
> > > >
> > > > It was not "killed in review". It was posted once, given feedback a=
nd
> > > > you picked it up for your tree in what felt like a day later but I'm
> > > > sure was slightly longer than that.
> > >
> > > Just over two weeks, when it seemed to me it was dead. I had emailed
> > > Matthew several times asking if he could make time to post his work.
> > > Telling him to refactor a load of the EFI_LOADER stuff just to get the
> > > app running seems wrong to me. I believe I already explained this at
> > > the time.
> >
> > Waiting for answers to questions, which then did come along with
> > confusion about the state of the series given that you had applied it
> > somewhere else by then.
> >
> > On the merits, I'm entirely unsure without digging it all up on if
> > factoring out common code was or was not a reasonable request. I believe
> > there was other feedback on the series as well and it was certainly not
> > a "ready to merge as v1" post.
>=20
> It certainly was ready to merge. It works fine, actually and I've been
> using it ever since. I'm very happy with it and have continued to
> build on it. My changes when applying were very minor, basically
> adding an include file to a header.
>=20
> Having said that, if people hadn't jumped down his throat so hard I
> would have waited, yes. I think I said that already.

It was absolutely not ready to merge as-is. There was both feedback
major and minor. There was technical questions and philosophical
questions. I would be *shocked* if the authors expected it to be merged
as-is.

> > > > > it and am now building on it (it now supports arm64). I mentioned
> > > > > before that I found that whole review process embarrassing (if not
> > > > > mortifying) and it made me realise that I shouldn't tolerate it
> > > > > either. Matthew Garrett is the sort of engineer that people should
> > > > > *welcome* to the project. Yes, Heinrich and Ilias had some useful
> > > > > feedback which I will get to at some point, but it works. Perhaps=
 I'll
> > > > > get into it when Linaro gets the lwip network tests running with
> > > > > sandbox :-)
> > > >
> > > > You know what, I'd really love feedback from Matthew about that.
> > > >
> > > > > The next step is to get it running in qemu with my lab...but you
> > > > > rejected that too I think? So it won't be in your tree unless you
> > > > > change your mind on that.
> > > >
> > > > Did I reject making labgrid a requirement for tests? Yes, I did. Di=
d I
> > > > explain why and offer alternatives? I also did. Does there seem to =
be
> > > > any reason this next test of yours would require labgrid? No, there=
 does
> > > > not.
> > >
> > > We can't 'require' Labgrid. There are too many loose strawmans being
> > > thrown around here. But I want to use it in my lab and I want a test
> > > which boots Ubuntu etc. in my lab using Labgrid. I explained that I
> > > want to be able to interactively run the target ('ub-int qemu-86') as
> > > well as run pytests ('ub-pyt qemu-x86 pxe') and in gitlab CI. That all
> > > works today and all you need to do is not reject the patch.
> >
> > And I found it both hugely disappointing that you wrote something so
> > specific to your lab and non-replicable elsewhere and also "yes and" to
> > the patch. Perhaps that got missed along the way.
>=20
> I know it is disappointing, but don't imagine that I lack for
> disappointments. It solves the problem of testing a distro boot for
> me, while letting me run it locally. I can build on it easily enough.
>=20
> If you apply the series and I do come back to this, I would like to
> figure out how to make the lab Python files easier to work with.

I already said a number of times that I would apply it, in time, if
against upstream. If you did your part, I will do mine.

> > > > > Again, it isn't a strange and unexplained force. It is just a
> > > > > consequence of your decisions here. If you were more flexible, I =
would
> > > > > have been able to continue as we were.
> > > >
> > > > The only way I could be more flexible here is to apply everything y=
ou
> > > > post without question.
> > >
> > > That's the part of your thinking which I really struggle with. There
> > > is a large amount of space in between that (which as you know I've
> > > never even suggested) and what I am looking for.
> >
> > And I keep struggling with how you don't see it. You want changes that
> > have been rejected for various valid technical reasons to be applied
> > over the objection of the custodian.
>=20
> That would be great, but I would settle for not blocking my patches,
> e.g. providing feedback on what to change.
>=20
> In any case, I thought I was devicetree custodian but my objections
> were ignored with Linaro patches. Same for bloblist. I started the EFI
> effort but can't get anything into that subsystem anymore, etc. I'm
> not complaining, just explaining why we are where we are.

Yes, I've overruled you when you've had things wrong. If you want the
final say on stuff, please just go fork the project. We will survive.

> > > The ANSI patch is an example of gratuitous rejection for no useful re=
ason.
> >
> > It wasn't tho? Heinrich explained in another part of the thread where
> > there is a good spec required reason we're doing the sequences we're
> > doing. You either missed it or forgot it, I don't know which. But it
> > wasn't "gratuitous". It's a tricky part of the spec where we need to
> > come up with some clever solution for the case Michal hits.
>=20
> No it just seems wrong to me, sorry. Of course we can do those
> sequences, We just need a way to disable them when we know they are
> not required. There is no need for a 'clever solution'. Just design it
> properly. If we carried on like that (emitting random junk and writing
> loads of work-arounds elsewhere in U-Boot to ignore the junk) the
> codebase would eventually become a steaming pile of manure.

Again, it looks like you're ignoring the facts in favor of your
opinions.

> > > Given the number of emails I'm genuinely surprised at the lack of
> > > progress we have made here.
> >
> > I'm not surprised because I keep having to repeat myself.
>=20
> You don't have to repeat yourself. It isn't that I can't hear you,
> it's that I disagree. People can have different opinions on things and
> still work together on shared goals. But there needs to be give and
> take.

There has been give and take. And you may leave, if you can't accept No.

> Really, you could just change your mind on some of these things and it
> would make a difference.

I'll re-evaluate things, sure. But I won't just change my mind when
you're wrong.

> > > Again, your decisions and position have produced the situation we are
> > > in now. Much is in your control. If you are interested in changing
> > > anything, even a little, I'm sure it would help.
> >
> > OK. What's one request you have of me that should be clear and
> > un-objectionable?
>=20
> I should really leave that to you to decide. Some things that are top
> of mind are:
>=20
> a) sunxi, which has blocked all future bootstd migration

Hard no. See my detailed explanation already.

> b) PXE, blocked on doing lwip work which I am not willing to do until
> my series is applied

Then you can wait for Jerome to have time? It looks like he started on
part of that recently.

> c) ANSI:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20240926220226.1265965-9=
-sjg@chromium.org/

Hard no. The custodian has already explained that it's done for a reason
and not on a whim. Whatever solution Heinrich is happy with to the
actual problem Michal reported is what we'll go with.

> > > > > > > > > > > At the moment your CI seems to be flaky as well:
> > > > > > > > > > >
> > > > > > > > > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/=
jobs/1038174
> > > > > > > > > >
> > > > > > > > > > [aside, I think you meant to link to the pipeline itsel=
f, which also
> > > > > > > > > > passed, but had some retries]
> > > > > > > > > >
> > > > > > > > > > Funny story. Ilias needed to tweak the fast arm64 hosts=
 and also wanted
> > > > > > > > > > to explore "What if we have concurrency higher?" and ra=
n in to the
> > > > > > > > > > problems you also ran in to with respect to git seeing =
an existing clone
> > > > > > > > > > in progress and bailing. Followed by the problem of mul=
tiple non-trivial
> > > > > > > > > > jobs running concurrently.
> > > > > > > > > >
> > > > > > > > > > All of which is why I keep trying to tell you that whil=
e "single" and
> > > > > > > > > > concurrent runners work fine for you on a single user i=
nstance it will
> > > > > > > > > > not scale.
> > > > > > > > >
> > > > > > > > > Yes, but I solved that with the patch I sent and it seems=
 to be 100%
> > > > > > > > > reliable now.
> > > > > > > >
> > > > > > > > Yes, you eventually solved it with 3 patches, which I asked=
 you to
> > > > > > > > rebase and squash to two patches (because #3 just fixes tha=
t #2 wasn't
> > > > > > > > sufficient) and you declined.
> > > > > > >
> > > > > > > In general, why not just be more open to my ideas, even just =
try it
> > > > > > > for a year? Given the tools I'm confident I can speed up your=
 CI as
> > > > > > > well.
> > > > > >
> > > > > > I've never not been open to applying patches to mainline that a=
re
> > > > > > against mainline. I am not going to rebase your work for you ho=
wever.
> > > > > > And I think it's terrible for the project as a whole when you p=
ost
> > > > > > changes against your tree and people expect to be able to revie=
w them
> > > > > > and then can't because it's against your downstream fork.
> > > > >
> > > > > I've started mentioning the base commit in patman and I think I'll
> > > > > update it to show the source tree as well. I understand the rebas=
ing
> > > > > is a pain and I am certainly happy to shoulder some of that load.=
 E.g.
> > > > > I can send a PR for each series when you are ready to accept it. =
If
> > > > > you like. Perhaps we can set a timeline for that (e.g. no comment=
s for
> > > > > a week?)
> > > >
> > > > You are subject to the same general timelines as everyone else. When
> > > > your patches apply to mainline and aren't rejected. Which is "about=
 two
> > > > weeks" and has been for about 15 years now. Sometimes I will pull t=
hings
> > > > in sooner when they're smaller / clearer, but that typically doesn't
> > > > apply to your very large series with multiple changes in it.
> > >
> > > OK, well again I'm happy to send a PR for things that haven't been
> > > rejected for your tree.
> >
> > OK. So looking at:
> > https://patchwork.ozlabs.org/project/uboot/list/?series=3D&submitter=3D=
&state=3D&q=3D&archive=3D&delegate=3D3184
> > Right now, there's patches for you lab that need to be rebased to next
> > (and feedback addressed, or set aside the i.MX target for now / make a
> > new thread about the general problem there). A patch from Heinrich. A
> > series from Caleb. The last two certainly, and whatever of the lab stuff
> > applies, could be in a PR for next whenever you're ready.
>=20
> Looking at it now there is an ACPI series from Heinrich which should
> go in after my qemu-x86 series. There's another ACPI series from
> Linaro which looks fine. I've assigned both to you.

And this is why I don't think you want to work in mainline anyhow.

--=20
Tom

--ok3pxGMJNKILftW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfnPfQACgkQFHw5/5Y0
tyz/nAv9FnPbN/KJqaiAsuNFAvzkuRuchJfrW1OYUhEPyBBLVlps9BcrSzVGZ7vC
R2bLv41aoyUe/EWUxGst4ufdwXdJNz3hlKfqJL4KmrgKGUq4D5S6CWZmgtRAZ4LN
c5U/nIb78paB//B8NHjX9FztvZWdqi/RCVJDoHa1vCA0kV0VRZPcPJIT4+H68hvC
shCBtKPWhTfd0sSQM0I+UUPT0wYohcUwipGQXLmvwRP2NOhu2shZ01k9uyamJ5vo
/q/XUH26T2Yv+hPpZrqb1ooVwMT61LFQNYI3KO/V5SUMWlOagDLz2/vquo7VjVjq
3eIXJQ6SWsEfmSRnJfxaKnl1Yirr2ZrN4ngtSaipQbl9jOlmhI3QLCNeTbLmDoyw
MvDebB1q0OYxd/jZWRp8XGZ1OsWt2fjJTnsMeageds/M7WKtnaA8cUijyvMwy/JE
5vW+z5EzO29CrxrNCbHYHzj/q0b9Wb/XXLghkM+Vv2rmJWizEF+vntfzctXTHjkr
+H6XYKFw
=VhVb
-----END PGP SIGNATURE-----

--ok3pxGMJNKILftW1--
