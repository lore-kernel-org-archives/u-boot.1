Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47275E87855
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 18:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF3883C39;
	Tue,  3 Feb 2026 19:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JiGzZdhJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E99F883C65; Tue,  3 Feb 2026 19:39:07 +0100 (CET)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 246A383C29
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 19:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-45c8b850f96so3977215b6e.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 10:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770143944; x=1770748744; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9BMcLxZnn+fuiuDAyGS+sRYSDCjPVl3i5TwtfrBee+s=;
 b=JiGzZdhJLXaHzFrWyHJqIo+KFVjcVzo5bCVooKFL7vz1zAnyEVQCuYhrnaUO38mbjQ
 kkzSFup5Brp+uoD3V2sr7DwH+U0rge4S0Q4EJdmie2O/Z66uQtzzZCU3e7w76c/WoOVS
 FDNaM/tbVm7C23e8BrXUgUGQPBnwMfcTCK9qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770143944; x=1770748744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BMcLxZnn+fuiuDAyGS+sRYSDCjPVl3i5TwtfrBee+s=;
 b=bF6f/nonvu8SLvb/tcl/gfZUECFg1QUdwYGnO7Re295EEgazuxOMMvqKZC5YirS/Uc
 oRuq2Wf1NLuEPpFZbiiUJz/1SILSd3gJzrz7zKmCZpBMOqnF3vuwHcH3CYnSdbh6w58k
 RSWGWjRgoHJ16J5y1Qh6DZIwG0pDLrNROSSMYcIU/gVOT0L4yiNPYbDcgm4+oBjUjfaT
 26ijx485UnDKdC8jKIlmxU41hugr3KjUSWd/k7I44KB1bmNqW/9TgVUwwXaagms7nAXs
 CAHjhC3QyvOQ+gp8VAvmc9Bw+DNz/TpHREOW7ToIHhTAypmtDVH2jVhKeUHTDwbUVkO5
 /Iug==
X-Forwarded-Encrypted: i=1;
 AJvYcCULaYib6vdrE9oJzfhJcYaROofUxKfzcx1t33Chua+wzh0OAVGX5kbN2OR09OJOOO6O6bAxg8M=@lists.denx.de
X-Gm-Message-State: AOJu0YyXgZ7TksepIlktjgKl37AgI9qhMeyfG/BAR0jInkqhg9h3bMZC
 O0Up+RZAWqHhFKIXM38iD7yPLZ83I4/jKCrvYnSgpOFVAE6WrbzxW3dvpEtt/PiOHCY=
X-Gm-Gg: AZuq6aJTOr9GgHBlJXG3aVydCPCYmHT4lQ1tK592C+A+HYvfKIFX1pOIS2q9V0CJRLx
 V3GqC/v9VdsnRi9Kb+ZoaQ1Z5JxWSyf0Eh3jc6SWRcDxKHGsfu8e0QYvn/bhTOi+ZDv0v8nB4qo
 359jOa03wBMQ6HxjMxWBbs5kwCYnylnPrNI1I9XKJmyMc7181sEEQQgbLPEEWa6eGE5Q8yIDYEY
 YQw655ElOCaTyNRznPIdLJE/CdqDLr7Si7H1j/3xGK/Ke+vb7V0e0B7wCe4xtYSaDk2MqIpZnHe
 6yYPaRZL8Am0jOPHOBem1nocFnNHIJR6d8rtYjqVQ1JrPw+Q4KHllhOcadQC5Uee5bvS6NMP6aX
 BgqvmMv/uvUXVXu9fNnqnMXNX4yP7YujRCizfrAIwwoyOwHt2OoAn6O6B8ZZHq4Xt4rDBzNr+W3
 O0uAmHVIBbYwBeBZu9r5yPclyfre/sVeUzKT40qRzZ6ywBWLA1S/svTdLII6pA0PVXHu8gjoeI2
 OOzbFQmy7jPe+igwSrGsUi5OkBmHJpMA8w1aCE=
X-Received: by 2002:a05:6808:1313:b0:45f:1ce9:3ade with SMTP id
 5614622812f47-462d5902becmr157111b6e.19.1770143943744; 
 Tue, 03 Feb 2026 10:39:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462d6608caasm58935b6e.2.2026.02.03.10.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:39:02 -0800 (PST)
Date: Tue, 3 Feb 2026 12:39:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>,
	Jerome Forissier <jerome@forissier.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 0/2] net: lwip: Do not write past end of buffer
Message-ID: <20260203183900.GR2603314@bill-the-cat>
References: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
 <CAHTX3dK6eybwR+FBcqS=qgFOpX2BVsg3gDQs=mTbshDMDS-imA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ABcwFjGHjHXeh6rF"
Content-Disposition: inline
In-Reply-To: <CAHTX3dK6eybwR+FBcqS=qgFOpX2BVsg3gDQs=mTbshDMDS-imA@mail.gmail.com>
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


--ABcwFjGHjHXeh6rF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 07:35:19PM +0100, Michal Simek wrote:
> Hi Jerome,
>=20
> st 14. 1. 2026 v 16:12 odes=EDlatel Andrew Goodbody
> <andrew.goodbody@linaro.org> napsal:
> >
> > Fix some cases where the trailing \0 written by sprintf is not allowed
> > for in the target buffer resulting in writing past the end of the
> > buffer.
> >
> > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > ---
> > Changes in v2:
> > - Address review comments from Michal Simek
> > - Add a second patch to address some more instances of sprintf writing
> >   past the end of the target buffer found by code inspection while
> >   looking for an issue.
> > - Link to v1: https://lore.kernel.org/r/20260109-tftp_fix-v1-1-64bd50ab=
c72b@linaro.org
> >
> > ---
> > Andrew Goodbody (2):
> >       net: lwip: tftp: Do not write past buffer end
> >       net: lwip: dhcp: Do not write past end of buffer
> >
> >  lib/lwip/lwip/src/apps/tftp/tftp.c | 2 +-
> >  net/lwip/dhcp.c                    | 6 +++---
> >  net/lwip/net-lwip.c                | 6 +++---
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> > ---
> > base-commit: c05dba22f1f2b0b2655ee3971644acf1936cd07a
> > change-id: 20260109-tftp_fix-3ab9bd66a6ad
> >
> > Best regards,
> > --
> > Andrew Goodbody <andrew.goodbody@linaro.org>
> >
>=20
> Are you going to apply it? I would be good to get it in.

I'll second that ask since it's what's keeping:
https://source.denx.de/u-boot/u-boot/-/jobs/1370910
failing and not passing.

--=20
Tom

--ABcwFjGHjHXeh6rF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYJAwAAKCRAr4qD1Cr/k
Cr7DAQCHuvUOmNDH7H+DEME5KjdxFhGnexvcXlgR7eMaIsZq9gEAtLKAVdE8dLLR
WWnMiu9MWQg49MH6CKm6ycClZUHXDwo=
=ZDDT
-----END PGP SIGNATURE-----

--ABcwFjGHjHXeh6rF--
