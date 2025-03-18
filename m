Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5035C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 14:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F92817D8;
	Tue, 18 Mar 2025 15:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CifQTK6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0DF88186D; Tue, 18 Mar 2025 15:22:54 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26D3800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 15:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224341bbc1dso106853205ad.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742307770; x=1742912570; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=acnSIz4kDzi5K4F/ZHEhdRyIuQNTnpuhVxnL+uOewx8=;
 b=CifQTK6ODEpRAo/BctFOEDzVq2ZUO5cJn0wgvhWFZMYOQvsUR5ghUkjeqx5EyxHQwr
 +kyt4jTbpxYtuQDE7DjgCCwlJ9oli6noqMZ8qq+u/YzMKbwJ+bmSchpfygazpLakjN/H
 oFSb6rhOaP1ZEy9siRst6IhDizf6E6gEELWl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742307770; x=1742912570;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acnSIz4kDzi5K4F/ZHEhdRyIuQNTnpuhVxnL+uOewx8=;
 b=EdENb9qHPt1VuZ9Y1QvMq88vNUEziGRSM60QI6/bv9GGtKPpuuIUpdtXsnsEWztuiL
 46I2/WYBUaNbcKTrBKLLVm2wxZisk2udZOquFnrTE09Mcii8dsT8VUISiaVIaDsJoAiO
 wITycTc0ncf1/AyyUIiWaB6NFiIRk/gcN+mUdERW9jMrCsMoZdQO3UFGKMvzkfXBp7Nv
 Zlj2lMjRyiv6hoa1ZghivuP6a96IgejbDRQkUHSeviYcOYQkmnxZfoIyM+neU5CM1v7B
 4HafDQbzshXHg4837flYxTpohHxQWdjuZWm0CuBUU0TbmEVTfu6umt0NR+8Sp2WUxkbv
 hp9g==
X-Gm-Message-State: AOJu0YxSa3J40LOIAvxdu5vXF99q8XT+xXLtzakOZRWulw/7ukb9znjA
 qbcVMRQswICODVxXsOWuTV9ILOTq2mp0tsghHGQC+sLPuRSLtvrWEI1jNlxPsFjjT82mjkhByBV
 o
X-Gm-Gg: ASbGnct7JGDvKK9ITNHqsVs6RbdYuOaqgjNBDnnqyqq2rl0lc/Yu7heuqRtElKw9Zv8
 hz5FOcwnTLk1oR2o+V4OutXJ1srGAM8Hex9U3n6Z2syspBO0o421QkoTVin9/uQSORG1r3L1jXr
 uoFF8vezOxYUcqLotLHgwQWpvt1OZzC6+njxgNeFuwexrGK8qAAkNLUfrXJBeHSpY2H8RyvjtVY
 bIhJnAhShiPfM5HbTUn8p698i1PfX7+UAMwAR5XU4Z/HRaOskOOwHS0FXWlgIASXWRhfYnQLl1m
 LX5cNzoiXv9Kx1eQiewYd7TkXtN4g1d0cfbDRpnga40L2w==
X-Google-Smtp-Source: AGHT+IFCdNLZ5FvhGlclptN8w9WkJLGIbIPGfjzvE3awgh+O57a1smD5lsE6iIGYf9v0m9ITAiUj4A==
X-Received: by 2002:a05:6a00:ac8:b0:736:8c0f:774f with SMTP id
 d2e1a72fcca58-737572d54c3mr4674758b3a.22.1742307770204; 
 Tue, 18 Mar 2025 07:22:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea7f6e2sm9097811a12.60.2025.03.18.07.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 07:22:49 -0700 (PDT)
Date: Tue, 18 Mar 2025 08:22:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
Message-ID: <20250318142246.GZ2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
 <20250314160652.GS2640854@bill-the-cat>
 <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
 <20250315135749.GI2640854@bill-the-cat>
 <CAFLszTjEONSErVbE0O5E0+izUDO8yFNZ+hwzvHjvx-nTczzeSQ@mail.gmail.com>
 <20250317230521.GU2640854@bill-the-cat>
 <CAFLszThJTWD1hejKfr9TfQYJRCiMoVQufkB+4=3K9Vf+bEBPYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3XNkLBAIICW7NY4F"
Content-Disposition: inline
In-Reply-To: <CAFLszThJTWD1hejKfr9TfQYJRCiMoVQufkB+4=3K9Vf+bEBPYg@mail.gmail.com>
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


--3XNkLBAIICW7NY4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 08:32:27AM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Mar 2025 at 00:05, Tom Rini <trini@konsulko.com> wrote:
> >
> > [cc list trimmed and adding Rasmus]
> >
> > On Sat, Mar 15, 2025 at 02:38:29PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 15 Mar 2025 at 13:57, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Mar 15, 2025 at 12:54:25PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 14 Mar 2025 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > U-Boot can start and boot an OS in both qemu-x86 and qemu=
-x86_64 but it
> > > > > > > > > is not perfect.
> > > > > > > > >
> > > > > > > > > With both builds, executing the VESA ROM causes an interm=
ittent hang, at
> > > > > > > > > least on some AMD CPUs.
> > > > > > > > >
> > > > > > > > > With qemu-x86_64 kvm cannot be used since the move to lon=
g mode (64-bit)
> > > > > > > > > is done in a way that works on real hardware but not with=
 QEMU. This
> > > > > > > > > means that performance is 4-5x slower than it could be, a=
t least on my
> > > > > > > > > CPU.
> > > > > > > > >
> > > > > > > > > We can work around the first problem by using Bochs, whic=
h is anyway a
> > > > > > > > > better choice than VESA for QEMU. The second can be addre=
ssed by using
> > > > > > > > > the same descriptor across the jump to long mode.
> > > > > > > > >
> > > > > > > > > With an MTRR fix this allows booting into Ubuntu on qemu-=
x86_64
> > > > > > > > >
> > > > > > > > > In v3 some e820 patches are included to make booting reli=
able and avoid
> > > > > > > > > ACPI tables being dropped. Also, several MTTR problems ar=
e addressed, to
> > > > > > > > > support memory sizes above 4GB reliably.
> > > > > > > >
> > > > > > > > Do you plan to rebase the prerequisite series' this require=
s so that it
> > > > > > > > can be merged?
> > > > > > >
> > > > > > > Here's my understanding of where things are:
> > > > > > >
> > > > > > > 1. You rejected the membuf series and my replies to try to re=
solve
> > > > > > > that haven't gone anywhere yet. So your tree doesn't have any=
 tests
> > > > > > > for that code and still has the old naming.
> > > > > >
> > > > > > https://patchwork.ozlabs.org/comment/3473898/ is a well thought=
 out not
> > > > > > gratuitous summary of why the series as it stands is a step in =
the wrong
> > > > > > direction. Tests are good. They're not a reason to pull an othe=
rwise bad
> > > > > > series. This series should be rebased to not depend on that ser=
ies. The
> > > > > > tests from the other series should be split out.
> > > > >
> > > > > It's not a bad series, unfortunately. I replied with my own comme=
nts
> > > > > and I stand by them.
> > > > >
> > > > > I don't mind if you want to drop the #ifdef (which shows how a fl=
ag
> > > > > could be used and the code-size impact). But other than that, I am
> > > > > firm on this for now. I've already applied it to my tree and a me=
mbuf
> > > > > implementation with tests and without a power-of-two limitation is
> > > > > important for my current work on distros and expo.
> > > >
> > > > Well, you need to rebase this series without that then as I'm not g=
oing
> > > > to take something another long time project contributor said was wr=
ong
> > > > and offered lots of constructive feedback on.
> > >
> > > It doesn't affect this series. It is for future work.
> > >
> > > We'll see if the LTPC replies to my concerns.
> >
> > Well, I guess I'm going to regret choosing to not chime in there at the
> > time and say that no, working against your tree is the wrong direction.
> > There's certainly enough feedback in that thread for you to make a v2
> > against mainline.  Because to be clear, no, your v1 isn't going in
> > mainline.
>=20
> Firstly it does not affect this series, so I hope you can pull this
> series in soon.

A problematic side effect of your large series postings is that it ends
up being where unrelated stuff is talked about. I'm not judging v5 of
*this* series based on membuf.

> This is the first I've heard of a v2 for membuf. From my side I don't

That's what "Changes Requested" means, you need to do a vN+1 of it.

> want to rewrite it to use a different algorithm, nor force it to use a
> power-of-two size. That was not the point of my series. Here is the
> cover letter:
>=20
> >>>>
> The membuff implementation curently has no tests. It also assumes that
> head and tail can never correspond unless the buffer is empty.
>=20
> This series provides a compile-time flag to support a 'full' flag. It
> also adds some tests of the main routines.
>=20
> The data structure is also renamed to membuf which fits better with
> U-Boot.
>=20
> There may be some cases in the code which could be optimised a little,
> but the implementation is functional.
> <<<<
>=20
> As I said, I'm happy to drop the addition of a compile-time flag. It
> was mostly to see if anyone thought it was a good idea.
>=20
> So how about just applying the first 7 patches? I can do a revert of
> patch 8 in my tree. Then if Rasmus wants to rewrite it he can do so,
> so long as the power-of-two size isn't mandatory.

If you want to post a v2 of the membuff series against next that doesn't
contain changes that've been strongly objected to, yes, I'll review it.
No, I won't go and see if your v1 still applies to next. Given all of
the other test/ changes I would assume it doesn't.

--=20
Tom

--3XNkLBAIICW7NY4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfZgbIACgkQFHw5/5Y0
tyzjagv5AXwO2ADm65MNGbuXGTwwWBAtCrZxQ7Y9aDX1S73kWTzKSK24wRMgEmDQ
i1L86lGBebiEQ4e+XOFtnc5iE+KB16twz+vdC2Ot05RXnggy7nygaul13H4AYuFg
C4tooPQiK4r+EYOI3BojMh6inlSND9V1o7T6KojQcrdhWk8z+gwOPNnzqd0Uwoby
0WYbT1dv7WPRm3+zBKEwHw9z8n405Dx2meOL8VKyjbybQibJssnwsVwuB3wsXOgl
ypO7ofU9odn+nmO6bFSOAKgs88RMJioPJDnFVH+vxT6OuAs2Zat7VgfAoIRqWJ7c
DGqtrK6b41Bd+37OeUJbT+0Kugs3RJXa6G4xwgKNzB4855PMB5zxXAZeDMU5hNhD
+wq5tFaGi4yyx4Qp+IFofS7iqcnjIHO22fmO8m8q5jehNwXshGUMB7HCiof1/kRW
gdWKT7gdRsZ+BgJAe0dYLvtiXQoIJrUHOnOwhz7We+Sfc4gDIHsmj6UjIQrL5dUg
U93CFG2I
=E2Sa
-----END PGP SIGNATURE-----

--3XNkLBAIICW7NY4F--
