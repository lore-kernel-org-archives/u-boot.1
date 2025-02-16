Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D04C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 21:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF74E8056A;
	Sun, 16 Feb 2025 22:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MynMcp/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B21807E1; Sun, 16 Feb 2025 22:52:37 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48155801B0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 22:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220d39a5627so54041825ad.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739742754; x=1740347554; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QfQeSilowL9ybFy12hRz7KUKe0MYg0aOxrsK3YR07RE=;
 b=MynMcp/JqC7Ca/40M28m5rWBqhOIawXjISMCOdGLA1WTCxc9Gs1upJXGz+6yx/x8dH
 U/D5pmJjo2yEdidKg64jQK1A7vfrqTj6i0V4bbpdnUf+JNUyB9CAIvWbuYUDYFCYoinn
 dBKhuuURFY9U093NOvfYdnobXlBEOj+HJ53Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739742754; x=1740347554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfQeSilowL9ybFy12hRz7KUKe0MYg0aOxrsK3YR07RE=;
 b=JID9Vg61F4OqlOLUPnhVjTSBTSJUfWWRVbT0ITcxm4RxLxBxCjrRYExCVGCMS1LjKD
 kviiniJEY3DUUkguXTHOgmt31BAYe6yIYxEMu8wR6DCs2em/cyKdqDNWuyc1Y/vjkwDN
 FYAaUMjLN9QYHLzOar/XUFjaNGHv7UdubgS+b56m/ilyPKlRSiRaOnO8hosW0OQyUxsn
 kYlJ721yjukVTe29ohHoS4uJZPntebACpC7/UUjn1wOA1NprA/ab/rH8jqcRCcO3hBmh
 aGVMVnWlvoWrXfc5UzjcW9U7UpiSmQtuyZTEjeK0/lpCpuJ428KoGQhF77z6XQHzKjsc
 YpCQ==
X-Gm-Message-State: AOJu0YzWqg6WH1FtMdFvNBjndc0lS9jx2sikqE2VUFEXdH2FYKmUA6qg
 EiX715mq4ahBG50+EJ4uE21EQwSnWbL9BPATaLggUK3H27+Q4LtoSLmZEFP2mjk=
X-Gm-Gg: ASbGncuEXFVXbY3/XkvZmqaZdJd3iayJJpD6DI8RyjhjrDkXReljko2sy+KeIxFIDVZ
 tSvog+GMRbmz+QIJ68fmFYo+DJdEcIShUNpxMR4RrvvgL4dqCFffEpIfDpln87RhMaTT8vUhWWt
 hyJVEjkyiT2Pdma9GLCUsmLdKmMZtQl3ITvsydv8Drx8jNzu4O3xxXUZUCG54ozrJvbMofK/gj4
 GKkZ0HUuy67IWwDY2YP/9ohduzcT83ivEkiDQemx6+ARU9rmPSmJq7kTahH/TbEnmilmg6rlgLB
 APScztKIN2xxXg==
X-Google-Smtp-Source: AGHT+IGBfFC6Dt0SNmfWzRI6tVJwKrJdidnsh6A1hoI2LrQxoLpbZT657hVW6vchWzU2nKnaWBYGgQ==
X-Received: by 2002:a17:903:2405:b0:216:57a6:2887 with SMTP id
 d9443c01a7336-2210403dcf2mr113750945ad.21.1739742753721; 
 Sun, 16 Feb 2025 13:52:33 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366b24sm60194895ad.97.2025.02.16.13.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 13:52:32 -0800 (PST)
Date: Sun, 16 Feb 2025 15:52:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250216215230.GE1233568@bill-the-cat>
References: <20250206223858.64672-1-sjg@chromium.org>
 <20250210162518.GA2902864@bill-the-cat>
 <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
 <20250215144147.GM1233568@bill-the-cat>
 <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
 <20250215181227.GT1233568@bill-the-cat>
 <CAFLszThJ11Ph-8zaNV_D0u7-UD18XtULm0kwhgQmMAj5xFgHtA@mail.gmail.com>
 <20250216160744.GA1233568@bill-the-cat>
 <CAFLszTiihyuqFBcdacu+2wfd3ivDzjf4nVqfU0BgKUc0u1s6=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3fN5d75W0bTGLgXZ"
Content-Disposition: inline
In-Reply-To: <CAFLszTiihyuqFBcdacu+2wfd3ivDzjf4nVqfU0BgKUc0u1s6=Q@mail.gmail.com>
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


--3fN5d75W0bTGLgXZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > This is a global default, so put it under 'default' like =
the tags.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > > >
> > > > > > > > Please make v4 include the way you redid the second patch a=
nd be on top
> > > > > > > > of mainline, thanks.
> > > > > > >
> > > > > > > That's enough versions for me, so I'll let you do that, if yo=
u'd like.
> > > > > > > It probably doesn't affect your tree as not as much is done in
> > > > > > > parallel.
> > > > > >
> > > > > > I am disappointed.
> > > > >
> > > > > I'm sorry to disappoint you.
> > > > >
> > > > > The background is that I looked at the difference between our tre=
es
> > > > > and the gitlab files are quite different. My CI runs take about 35
> > > > > mins and it seems that yours is around 90 mins. I would like to r=
educe
> > > > > / remove the delta (for time and patch diff), but I'm not sure ho=
w.
> > > > >
> > > > > My goal is to get CI runs to below 20 minutes, best case.
> > > >
> > > > I'm sure CI could be quicker still with a number of faster runners.=
 But
> > > > if you can't be bothered to make changes against mainline, what is =
the
> > > > point?
> > >
> > > If you recall, I was working with your tree and had various ideas to
> > > speed things up, but you didn't like it. So I've had to do it in my
> > > tree. This is not about more runners (although I might have another
> > > one soon). It is about running jobs in parallel.
> >
> > And I wasn't sure more runners in parallel would help (as it would slow
> > down the fast runner which is what keeps the long jobs from being even
> > longer) as much as adding more regular runners would (which we've done)
> > and noted that in the end it's a configuration on the runner side so to
> > go ahead. And I reviewed and ack'd the patches here which exposed the
> > issues your path revealed. I just can't apply them because they need to
> > be rebased (and squashed).
>=20
> You have already added tags for things, but (IIUC) they are around the
> other way from what I have added.
>=20
> I have a tag called 'single' which means that the machine is only
> allowed to one of those jobs. The world-build jobs are marked with
> 'single'.
>=20
> For other jobs, I allow the runners to pick up some in parallel
> depending on their performance (for moa and tui that is 10).
>=20
> So at most, there is a 'world build' and 10 test.py jobs running on
> the same machine. It seems to work fine in practice, although I would
> rather be able to make these two types of jobs mutually exclusive, so
> that a runner is either running 10 parallel jobs or 1 'single' job,
> but not both. I'm not sure how to do that.

So unless I'm missing something, in both cases the bottleneck is that
for world build jobs you don't want anything else going on with the
underlying build host. You could register 10 "all" runners and 1 "fast
amd64" runner (and something similar but smaller for alexandra). If you
update the registrations on source.denx.de can you then shut down your
gitlab instance?

--=20
Tom

--3fN5d75W0bTGLgXZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeyXhIACgkQFHw5/5Y0
tyxnVAv/S7ebV7YWCGMC0gEgN3r7DWkDnhXzBvXWjJHL+A0vkg8lUWa5oLkbFsiB
Vu65F40t6HDpQ8MYsr/97+1HaGJxZCCRJeNurcNtz6R6+hBojyf5pm3S1770vAAW
pYEJYQYoPInBERehJ2xTNh4SWWxyW8e0r8xrbNDV6rMsvUSISmZnzjQpsuQy7CYI
5WSS1u7fuNQt72JwUGjkeIYWicemYcFbuUl5e1NYyJLQ8S7sC36PTI2c3NIBkbCt
zvVj9WsgXHd5ns+usWUzt9+WHGiZ2JK3BQukjxwD22+Q46bV+rqyBoZPxNFFJQtW
5jH/ZTbq8WyuGsvcsarINjz8hCoO5vpgZZxfG+Rc+h2odA2TgtxFQKzUQqHEXVSB
1s0vPoMhQSmryUv8UnNBCXB/NxpcEpbmBRqFWjeYPpuqQ6cfTWmX9L2eiqIDo2Fu
B5LYFIiFH+ajeQS6cd01qlkzY+ok3JO/eOeKWYCZlO3JC0Y8E3UfGdb5IFelSoNO
Mrxh1QQk
=KBlU
-----END PGP SIGNATURE-----

--3fN5d75W0bTGLgXZ--
