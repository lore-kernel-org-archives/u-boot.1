Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109B8C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F3F7882F9;
	Tue, 21 May 2024 18:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uBdGR4Rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B608835A; Tue, 21 May 2024 18:36:58 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3475881C1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 18:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7931a0a4d8fso335345585a.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716309415; x=1716914215; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6JN1YPwCe0lEytHa/BIA2bTMcgP1O3pBYbG8vXvUflM=;
 b=uBdGR4Rgx7mJgAJvKr4AczbGUysz8nqKHaNwZkZiT9+8pW+i8XTLp+T20vbePQGtUL
 fHAAM3/KyI+ZoT/oXSR+06s//0P47GLtIUQ4QFzMhH6miHtqY2dCq28AhTRMsSVj/zTV
 usZIl9IQd0oNBR89NEsSY4hxRFNJHSYieGkYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716309415; x=1716914215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JN1YPwCe0lEytHa/BIA2bTMcgP1O3pBYbG8vXvUflM=;
 b=Edjy/+FIKCmT14su0cr0mKcs2i6x+2Ijtk4Yr854IVGwHGbXwM0iJYkQtT/ygroc/i
 ag+IEBoFJHWUzCfs16kFTACLJ9Ga+dHfdmOQJ+SCOEdufqwxcBfk7Z5q0gQaMWUMXIJK
 Q6QH75Xf3vwvUcb2CoRCArlmtbdWKQiMDzx9OdpRC+gmBofXu2mqdUhDeMuDDvyPfBEN
 SnBbY9UrtrxQUvS9gxAPuD2Mt5XHZ1hUUYHn+ktNloxkG+nuEurFjOOakWNi5Mm6vuDt
 0bV4TECSqZHhgaKLJyW0c3DsGkb5OOu9srif5cy1VoKKHUkKFgQNOjm/1lyXPscKMyV0
 nMJQ==
X-Gm-Message-State: AOJu0Yyq5lUwEeNLI0rrIVtrjQcxDxAUWAO6SzcQZzK9uB4iWO4TEGc4
 zLavOH+dDOMRjlzE/CfDrDIUhMnxAZpbqJIVFiMIjsjtAU29CoCs+oMFTEbqRno=
X-Google-Smtp-Source: AGHT+IHUFhsxhVcPAj3yK0Abz9VYNWgGPNw/cP8DQvfs3pmsdyybnqhcJskH19hDXFyHl8xmDkNkkg==
X-Received: by 2002:ae9:f00c:0:b0:790:781d:f089 with SMTP id
 af79cd13be357-792c7600c0amr3135024685a.72.1716309414701; 
 Tue, 21 May 2024 09:36:54 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27778esm1305784385a.23.2024.05.21.09.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 09:36:54 -0700 (PDT)
Date: Tue, 21 May 2024 10:36:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [v3 1/2] doc: process.rst: Use subsubheading for "Phases of the
 Development Process"
Message-ID: <20240521163651.GV2568172@bill-the-cat>
References: <20240517174930.1028063-1-trini@konsulko.com>
 <b160b75b-513a-44e1-ab1c-cdcb42a44dda@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r2zcFCD+e0v2vShb"
Content-Disposition: inline
In-Reply-To: <b160b75b-513a-44e1-ab1c-cdcb42a44dda@cherry.de>
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


--r2zcFCD+e0v2vShb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 11:23:01AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 5/17/24 7:49 PM, Tom Rini wrote:
> > These sections which talk about the different phases of the development
> > process should be using the subsubheading identifier.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v3:
> > None
> >=20
> > Changes in v2:
> > None
> >=20
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >   doc/develop/process.rst | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> > index 92477d05dd85..a66540a698c1 100644
> > --- a/doc/develop/process.rst
> > +++ b/doc/develop/process.rst
> > @@ -34,7 +34,7 @@ It is followed by a *Stabilization Period*.
> >   The end of a Release Cycle is marked by the release of a new U-Boot v=
ersion.
> >   Merge Window
> > -------------
> > +^^^^^^^^^^^^
> >   The Merge Window is the period when new patches get submitted (and ho=
pefully
> >   accepted) for inclusion into U-Boot mainline. This period lasts for 2=
1 days (3
> > @@ -44,7 +44,7 @@ This is the only time when new code (like support for=
 new processors or new
> >   boards, or other new features or reorganization of code) is accepted.
> >   Twilight Time
> > --------------
> > +^^^^^^^^^^^^^
> >   Usually patches do not get accepted as they are - the peer review tha=
t takes
> >   place will usually require changes and resubmissions of the patches b=
efore they
> > @@ -65,13 +65,13 @@ the Merge Window does not preclude patches that wer=
e already posted from being
> >   merged for the upcoming release.
> >   Stabilization Period
> > ---------------------
> > +^^^^^^^^^^^^^^^^^^^^
> >   During the Stabilization Period only patches containing bug fixes get
> >   applied.
> >   Corner Cases
> > -------------
> > +^^^^^^^^^^^^
> >   Sometimes it is not clear if a patch contains a bug fix or not.
> >   For example, changes that remove dead code, unused macros etc. or
>=20
> Wondering if we shouldn't put:
>=20
> Differences to the Linux Development Process
>=20
> section under the "Phases of the development process" section as well?

I don't know. I thought not when I first did this patch. I still thought
not as I started this reply. And then I re-read the section again and,
well, maybe? Or maybe it would be better to integrate the contents of
that section in to other sections, and rework it a bit too as it's not
quite correct either. For example, I feel like the majority of new
patches posted in the merge window (even at the start) end up in the
upcoming next branch.

--=20
Tom

--r2zcFCD+e0v2vShb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZMzZ0ACgkQFHw5/5Y0
tywVaAwAkdvM0MqMIS5TuVPzGGAKIyxnXm7pCmYOCwGSm9rDytf/RUGg5/oM062u
dXCRXDLinNOd9QXgX28G20uzkLyI5eQJKLDqxbORwRJpA+XcHafAQlC0YBtLUKQN
clqalvvW+LKXk4wGbeQ6dSP8ZokKAwXbqJIrEHzCU1ZZYi6vbCkDWzX06kQB6Wrd
y8HUjgvB0uCztFegePepPjR8oE7kLUGNBw/LZASU9vnsFkBaOSMfUiJnTYsCBV+m
XtqG1Ozwq5yPuH+WpTDXtwsZhuVyY0NR8dUKZMu6v7gutwoBGiBA+6dAtK1M6EEF
AUbzpAMgBRJiFwqSi2BkoZo5RIKHgW/wjJk7srxHQWCaT6LvOcMNSm+CpL8ofQN0
8bEyfB/Ccm2pYK9RL0uYY/ZEeJ5JVmR3lBuLQA//olgBYsD8TjREg4+w+vxA3EC3
9Ohaj0j5vrFzqwtonxTO6NTi4xcYJjorgCjkN/stIOJ3/LxNBKUglc3Y4skT4Dm1
4fkxHMiT
=ioqX
-----END PGP SIGNATURE-----

--r2zcFCD+e0v2vShb--
