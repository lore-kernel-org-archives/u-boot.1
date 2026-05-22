Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A6BCD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 17:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3339B84869;
	Fri, 22 May 2026 19:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mq94DNSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B84884878; Fri, 22 May 2026 19:36:44 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36336846C0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 19:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso4684770fac.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779471401; x=1780076201; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8IdYdXE2AjC8ehdjYsMFHWXRUHjxXDEryLGrb4ykDRE=;
 b=mq94DNShABHygz/YR6UBwpvtsp/4RPE7Bo2CQLcJt72BMw9YZByYyhXQ0qTCHn4Qy6
 NDh68Y7b/bMuO9C74xh+mZhSM5aVSD0hoIf82mzHMF0mjPF//66jvGcoNAka1qEaXOt2
 FFpRw7ihGmJtufcvte4xf88eoeweC/bF9qNEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471401; x=1780076201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IdYdXE2AjC8ehdjYsMFHWXRUHjxXDEryLGrb4ykDRE=;
 b=TS/78PkhduBOIqM03bGQHCW07JfQqN5oV7frBTjAS4h3bpvyJaTYmb2aK66RzLBMXa
 o6TxZwflMi0KP2lJwqQWc29yfg5D3XiYK7DNceUe3w8uc4SQFqY7UMbOh0gEVs03Pnsz
 PGYv8s3IozdkAtBC4cYH0pikUy2lU8inHkljrULlVfdjWYhm7pz84RsL26fWmigG4rtN
 SmF8oWcWxjctu8+pyzX/A8Jlc+Exmjv+ZNmw+FjHHMP6DOJB/yeoOgabE/3JxfBxgHk+
 uyvtbf9vf+cjeyJIPfFZx9thctiXXP369XgBp/YOE9lqhWioCJJ9yQ9S9sazTZEBPxm+
 45Nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sVrHE23aiK4gHKQbVybNqVlLIaPid4d0vOQL6NrxA5DNZztfkYXfRWA/gxA8mV317/77sCIk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyj1KKe9wcvx1B0PPlOztXf+UCqI0zeyzKCp8GrM3BKBmmgWnUQ
 mGxIunonXZkPq/r51JacjPxvp+qETO/wOHBpDhtJU02b/oQeWJVJWPDCpGoof1vvdoo=
X-Gm-Gg: Acq92OErOoXAkU+sXdhqfwKGe0ubE9HupIpAGKucNjpRoPmAbwrdHFQDH2RmpTpvHo1
 ka7Yezo6bq8MrHvVcuD0+i0O4lhQUJjlKvj2caFpsUTJ1Ve8fH6RlmiH4XMKuc/msmXPKUP/zY7
 dyPy7eg2lqdDxabUbxuyHP17n9w1buMVYGCG/3ru0McuLoX9Iad1DnhlDj7EImiWsZIhXk2lmog
 4blcBvl1S5PrR7hDiIrlCXSNmnyDgcr075P7n4GnOAgUdtwYVVhvqJQs85eKQFg6rGCJEnGFps8
 itTPCitP82USG1R66TBgI+yScIsR9I3+USpeiBJzTXvB5/IW62KYc/893geJ0QxG+U1ksWcjkfl
 fn2b6s49wX9WzbCXZbtShJGeatWZngiCXnehUwnKK3/x2ZAzA5R7jwT6KaetxyEQF8B68KpZP5d
 BtFlVsLl/54RQXOReDRoVLBRTilf67BornUvn5Yb6swgs7jtWKU4PsWHrb8+r+GwrAio18DvpAF
 IyAw68GMs6q6SvT3z2s3MFowacAK0HdRqPmqG08EHxa2B9nIl5SK6R7
X-Received: by 2002:a05:6870:56a7:b0:41c:25b1:930f with SMTP id
 586e51a60fabf-43b5ad58b18mr2407370fac.19.1779471400963; 
 Fri, 22 May 2026 10:36:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b639fd7adsm2265280fac.14.2026.05.22.10.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:36:40 -0700 (PDT)
Date: Fri, 22 May 2026 11:36:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shiva Tripathi <s-tripathi1@ti.com>, Andrew Davis <afd@ti.com>,
 Ernest Van Hoecke <ernestvanhoecke@gmail.com>, vigneshr@ti.com,
 bb@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com, praneeth@ti.com,
 kamlesh@ti.com, vishalm@ti.com, k-malarvizhi@ti.com, anshuld@ti.com
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
Message-ID: <20260522173637.GW1858239@bill-the-cat>
References: <20260522061515.GA8642@francesco-nb>
 <0c76975d-1f87-4a6c-87c2-cff99584fa1e@ti.com>
 <20260522162048.GA114365@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="icYRdckQjI6e/SBr"
Content-Disposition: inline
In-Reply-To: <20260522162048.GA114365@francesco-nb>
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


--icYRdckQjI6e/SBr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 06:20:48PM +0200, Francesco Dolcini wrote:
> On Fri, May 22, 2026 at 07:49:27PM +0530, Shiva Tripathi wrote:
> > On 5/22/26 11:45, Francesco Dolcini wrote:
> > > On Wed, May 13, 2026 at 06:36:40PM +0530, Shiva Tripathi wrote:
> > > On Wed, May 13, 2026 at 08:49:31AM -0500, Andrew Davis wrote:
> > >> This makes me think we are at the stage in boot where EFI variables
> > >> are trying to be persisted to some media, and when trying to use
> > >> the fTPM for this it fails (as would be expected without RPMB).
> > >> So this should be harmless, but why there is such a large error
> > >> printout we need to investigate and try to make it less verbose.
> > >=20
> > > Any chance TI can help on this?
> > Yes, I am looking into it. The logs are showing up as OPTEE's fTPM TA is
> > failing to load, since the eMMC RPMB isn't provisioned.
>=20
> Thanks for looking into that, and I am glad you can reproduce the issue.
>=20
> > Even though these logs don't affect functionality, you can revert this
> > patch to avoid confusion. I am checking if there's a cleaner way to
> > handle this.
>=20
> I am using mainline U-Boot, if this needs to be reverted, it must be
> reverted here. Given the release timeline, and the fact that this is not
> breaking the functionality I am fine waiting a little bit to see if it
> is possible to fix it, we have some time before the v2026.07 release.

And for the release I would like to make sure someone has a clear path
on what changes are needed, if any in the end, on mainline U-Boot by
rc4, which is June 8th. We have the last one on June 22nd but I'd rather
not have to revert then unless things are just unresolved. Thanks!

--=20
Tom

--icYRdckQjI6e/SBr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahCUIgAKCRAr4qD1Cr/k
CjIvAP9hEsYVa6p6QoBH9352OfJ7eejXUM/0lCeU05sk/7yfwwEAsJHgesYIppEY
TW4Nd2LiwBUfFgq8FbfeKWLfPxudhAs=
=P82B
-----END PGP SIGNATURE-----

--icYRdckQjI6e/SBr--
