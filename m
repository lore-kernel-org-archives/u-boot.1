Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4891DC87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 15:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D7383A3B;
	Fri, 25 Jul 2025 17:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WEBYaFTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B8D83A48; Fri, 25 Jul 2025 17:57:27 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B78B0839E4
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-306ab3a49d6so1504425fac.0
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753459043; x=1754063843; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S5ip6nDYc2R6afKt+I8civpKPw+1eS0HlDs/Nc/5oWA=;
 b=WEBYaFTvtMJKVch8Gq/aH5nRqCbW3bPAwDtJkrb+JXDRpU6dn41wEkb5265BPdBems
 2lI7G0XRCFYskW+hXpeqwTy5Mbhj4c7XuChNOUOcmC+albllL3lNUw3xiP8hytpsGDZs
 Pqu7hCum1wALIQ10VKVmyuB/io2YT1YQmQ2Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753459043; x=1754063843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5ip6nDYc2R6afKt+I8civpKPw+1eS0HlDs/Nc/5oWA=;
 b=fZ+nVjtgmg53VxUDr8FMcsTQr070oub97meo7hnhoqwJRLn9eKXzO7H3sqYOFJbjH+
 QYb6PmIgGX33gto3NHQuh/7kjUgXvGgSH/JcqjelWrWAbIVy2Iq0SxfC7xV3n9swvGyV
 l586xYHCMscoY7uRpttax63yPL3DEvl+dfD/25nXwvwKHK1kxDlBOmo+vDq98gQ1ebaB
 dtYkCejTtTlJurMGg99yuxdfgLT6rJZz7w5iiq8qQRRI2bb9vjLa6aB5fLN4WhACxrcz
 Zvfms7jnNDi2mV3NlH2+8f/3LDxHs4ByTNlnAYhb3IV6RSlc0DlLOLu4jqYoz5p4BY39
 wtIg==
X-Gm-Message-State: AOJu0YyMHDQjGp711WHWPOGzgeBY7IozFZGqwiO4zyTvkeCRsjouVCTw
 e2cdORLt1jkDyEvtYVTyaCCBgW9U2K9j2eY3AxjZraKSefwT31pLBb4XhddpB+p10lA=
X-Gm-Gg: ASbGnct0qdnLaGnbuol4cGiKjoJIGCj1bBb+x5vJFKexQH2f6CFyPYOaOpwirzcDwtD
 jvdmckcBc4aUI/iI4FCHfT6C+VdCDF8RbiTUipDDuTIpgja1ClRDCKGSXLo69JYnSt7leRN9i8p
 M3SOVxDEgw907Be0VOjwXPu/6Ie+NIqKbP0jYOke57/aa2dy90zU24RjIftbXaDeiJ05KTTf6IR
 dPZE9tSvQ4RTPM5v8umVFFyHIrmb/dGBeWgtJrUNid5baojchaeBam7sIz3k9EdHnGtmQTM2PiB
 9QRWFAAP1zgDK25bbSpO9ZQdSpYgbLJD4lGheCf6/Q7BRRP3oaAP25SOB6yv8M9SZtFMu4WzA0Y
 ydyITIWYQWLwb15Q2+wzQZhQ+/Y60ToBeQ9sFXuz3PTHu5ozTFV/wYmv0
X-Google-Smtp-Source: AGHT+IFu5FnbIPzHXczTEOvWI6TamqUoJN5g9Pd+ENh9pfQGtRnBcsCSCPFXY7DE3slk2foVEhfREQ==
X-Received: by 2002:a05:6870:3854:b0:2f6:c9a6:4f7f with SMTP id
 586e51a60fabf-30701bdf3a3mr1711339fac.39.1753459043273; 
 Fri, 25 Jul 2025 08:57:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071358fc27sm8741fac.24.2025.07.25.08.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:57:22 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:57:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH] pylibfdt: setup.py: Drop license_files
Message-ID: <20250725155720.GF1807455@bill-the-cat>
References: <20250725151821.2067853-1-trini@konsulko.com>
 <ad876397-a18f-42b8-ab84-47282b7a4f48@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MPvLUk1y/aoIXCNR"
Content-Disposition: inline
In-Reply-To: <ad876397-a18f-42b8-ab84-47282b7a4f48@cherry.de>
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


--MPvLUk1y/aoIXCNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 05:30:59PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 7/25/25 5:18 PM, Tom Rini wrote:
> > On more recent versions of setuptools the warning about not being able
> > to find the files specified in license_files has re-appeared. This is
> > because as best I can tell, it can't and won't look in $(srctree) but
> > rather only subdirectories of scripts/dtc/pylibfdt. Since we already
> > provide both SPDX tags and a license field with the SPDX contents, let
> > us just drop license_files as it's not mandatory.
> >=20
>=20
> IANAL but I believe we need to ship the file, that's part of the license
> requirements for both GPL-2.0-or-later and BSD-2-Clause.

I mean, we who? As part of "we should re-examine how we bundle Python
stuff", yes, I don't know if our pylibfdt stuff is at all optimal
anymore and we should maybe we talking with upstream dtc more. But
$(srctree)/Licenses/gpl-2.0.txt and
$(srctree)/Licenses/bsd-2-clause.txt exist and we don't publish the
python binaries.

> Can you try with a relative path, like ../../../ in front of Licenses?

Yes, and I also tried telling swig -I$(srctree) to no effect.

> If not enough, it's possible it's because it cannot read in parent
> directories? What if we have a symlink, does it copy the symlink or the
> target of the symlink?

That would break on read-only source tree (Azure CI).

> Reading https://setuptools.pypa.io/en/latest/userguide/miscellaneous.html,
> the license_files should then be automatically included in the sdist
> tarball, so the presence of the files in it shouldn't be an issue here.

We don't make sdist tarballs however.

--=20
Tom

--MPvLUk1y/aoIXCNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIOpXAAKCRAr4qD1Cr/k
CoKyAP9KIr0ohfylF/Pd7CW+A7ktj7F/Kf/LddjSZMUZnbHITgD+LWm+JVwSU+Ww
2kh9abo0td4gIctJCGQutDEzLSDW/Qs=
=ax+p
-----END PGP SIGNATURE-----

--MPvLUk1y/aoIXCNR--
