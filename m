Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6854AC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 17:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDCD084C2B;
	Wed, 15 Jul 2026 19:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UyZsDdvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9186484C11; Wed, 15 Jul 2026 19:02:01 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA5E84C2B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 19:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-495b27007d0so1592723b6e.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784134915; x=1784739715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fkc51tBb43J02lD7FxuHWjPt0rs4DOPhSqewvTR+ieU=;
 b=UyZsDdvcu+Ml8L9wllSWF7uOwtITK95I+UXYiEzuSHFX8ARg4qh+zCJV9rMdDVKlZX
 yovgb6GsfOshp6wuDhewCZ62yxnfAKg4r1njEKIKW7SpuBWZcDd6CnroGq3WU4TgAwrX
 /U7nTscus+jkugdSEd3vk2wHGTn1PUzR1MSJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784134915; x=1784739715;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fkc51tBb43J02lD7FxuHWjPt0rs4DOPhSqewvTR+ieU=;
 b=Qn5qRlLYxhpkwKFlOdTG6fbavjUg42wAGYMmZkBrvnuoHmGtbgHlxlPTC8yFnWBBnv
 zTBtcCOFSPN2to67eWEHoY8JGywAT75ZQ8/KoZSJrz3BA5YNFIeVsq369vUxI4y64LfV
 hIhYNEL1a4/fYz2aBO770pAKb9n+GBoEI6fc07YdIJiVUUxrY8KQYJWI2yeEGhkJAewX
 qGOWWE0PBRC3xCB2UpYeROTFR9qcSYCIUN59h0yf4iC9/ibHVWoYRkfuUEYys/LdSLgk
 EfKuJwc5OzNEMa0lD0g9S10X/E2ySKjB4EwkrohV/vw/J+mAVCOhAANp5v5q7YBo1FFF
 RMGg==
X-Gm-Message-State: AOJu0Yzr/Qd+7UHdL6qouB0KVUjDwP0agWSJeqMqzgxe8SZWP2ZfYJ6W
 TNk4CuJfMc1NbinhREHcmt3BD+ZyN46FGbLbE67OSypCF18Nyh6YTvB2PRtHW7UthKwBRXo3CVk
 eLyzynK0=
X-Gm-Gg: AfdE7cn7M1W5ediZLQuYNUQjwmwuqi2WlqluE7BU08iKPX1hZBNAiE880wcBYFCe7ip
 zj/eaWlv0VzyhhTTGlHONiUUxnpNc3CbZMsAC5U9us88G61UCKVITvsr3fh9Ld1OVdhBMMBwliM
 WulvDn5nG0GfhzumiE86oSMmpgbd03r1L/ghY6je5srUop5lDPqoxu3eAZtewbh6gN4iy4TNDEj
 rW8OK8K2W6fFHnWKJXQKp/mKBxu0Oep8v+GPk+kfQJ2WlwtvZaczhQjpU9ATuFg1gyy40uFqR7g
 ykHgfbqT9Gh0SVwZnrOjgVkgX06UuW3Lx/vOcehWbPY5+XVeHIyD62ONmD/ld3nMZeH69wDftlD
 OjwBSLFzSVE0Z60JXMtvhkitCe2zopzqUULh0q1FbsZUAFN4x2MZZKaLFNj47oiFMcIRydCw3ZL
 swxPfGfFb5DLfBMLjFGYzKsql0tuQd5CA4SfF24oivi3HlGCXp6/zH+wNOpOcfPKfpMwYsxslCj
 PfEKEL9l3GaTfIBNl6aPNPZuV0gmU33Q0xjhQ==
X-Received: by 2002:a05:6808:6903:b0:4a4:933:b20f with SMTP id
 5614622812f47-4a42ad5ae26mr11887287b6e.7.1784134915458; 
 Wed, 15 Jul 2026 10:01:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a41f5b69bfsm11307594b6e.17.2026.07.15.10.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 10:01:53 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:01:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, u-boot-board-maintainers@lists.denx.de,
 u-boot-custodians@lists.denx.de
Subject: Re: [ANN] Updating branching scheme to use "main"
Message-ID: <20260715170151.GJ749385@bill-the-cat>
References: <20260708161945.GU749385@bill-the-cat>
 <a68ee92c-48b6-470a-be97-1110f3ea5abe@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E0AUX2wfMiD2L8Ng"
Content-Disposition: inline
In-Reply-To: <a68ee92c-48b6-470a-be97-1110f3ea5abe@nabladev.com>
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


--E0AUX2wfMiD2L8Ng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 06:22:16PM +0200, Marek Vasut wrote:
> On 7/8/26 6:19 PM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > As part of migrating from source.denx.de and over to
> > git.u-boot-project.org, I think it's time to change the branching scheme
> > from master or next to main or next. Since we'll be changing the URLs, I
> > don't think we need to (and I'm not sure we can automatically) have a
> > period where both exist. Thanks!
> It would be helpful for legacy build system integrations to keep the
> 'master' branch around and mark it as "protected" or some such, so it can=
not
> be updated after certain cutoff point.
>=20
> OE fetcher for example checks whether a specific commit SHA exists on a
> branch unless that is inhibited via 'nobranch=3D1'.
>=20
> It was suggested that the 'master' branch can be pushed with commits up to
> v2026.07 release, and then stop being updated, while the 'main' branch wi=
ll
> be updated going forward. I think this would cover all the old build syst=
em
> integrations without causing them too much breakage.
>=20
> For example gstreamer kept the old 'master' branch around, stopped updati=
ng
> it, and then kept updating the 'main' branch going forward, which to me
> seems like the optimal compromise:
>=20
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/tree/master?ref_type=
=3Dheads

Thanks for looking in to this. It's not hard to have "master" stop at
v2026.07 and be protected from pushes, etc, so I've done that now on
git.u-boot-project.org.

--=20
Tom

--E0AUX2wfMiD2L8Ng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCale8+wAKCRAr4qD1Cr/k
Cg0yAP9CuR9kpJNbvm9V7p0+DFMCPlTtjRYrlAWv3axJvDo0hQEAidiKK74gw8xD
vyH0uK5MC4RTrh/FrVPzLfml9iylgwI=
=ltK2
-----END PGP SIGNATURE-----

--E0AUX2wfMiD2L8Ng--
