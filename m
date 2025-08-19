Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7E7CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF39830B5;
	Tue, 19 Aug 2025 11:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=silbe.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EE282BF6; Tue, 19 Aug 2025 10:36:07 +0200 (CEST)
Received: from bbox-ptr.sascha.silbe.org (bbox-ptr.sascha.silbe.org
 [46.38.230.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 413D980FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=silbe.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sascha-ml-reply-to-2025-3@silbe.org
Received: from brick.sascha.silbe.org (brick.sascha.silbe.org [192.168.1.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "brick.sascha.silbe.org", Issuer "stunnel Pseudo-CA" (verified OK))
 by bbox.sascha.silbe.org (Postfix) with ESMTPS id AB07E1E165F
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:36:04 +0200 (CEST)
Received: (nullmailer pid 122288 invoked by uid 71000);
 Tue, 19 Aug 2025 08:36:04 -0000
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
In-Reply-To: <20250818165119.3193853-1-trini@konsulko.com>
References: <20250818165119.3193853-1-trini@konsulko.com>
Date: Tue, 19 Aug 2025 10:34:27 +0200
Message-ID: <yh7rh5y33e24.fsf@brick.sascha.silbe.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
From: Sascha Silbe <sascha-ml-reply-to-2025-3@silbe.org>
X-Mailman-Approved-At: Tue, 19 Aug 2025 11:52:11 +0200
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

--=-=-=
Content-Type: text/plain

Hello Tom,

Tom Rini <trini@konsulko.com> writes:

> At this time there are still major Linux distributions which by default
> boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> DISTRO_DEFAULTS to ensure these platforms can still boot.
>
> Fixes: d780965927d4 ("Drop the special am335x_boneblack_vboot target")
> Reported-by: Sascha Silbe <sascha-pgp@silbe.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
[...]

Thanks! Tested successfully on BBB.

Tested-By: Sascha Silbe <sascha-pgp@silbe.org>

Sascha

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7Ycc2t6Wt6eY1E5VwY9q6IEw7ZcFAmikNxQACgkQwY9q6IEw
7ZdePg/+K7a5CONaDMLEwQM+rI47OY1yZeOgnnLhAF3F1Ft0E/nP9qK+r+Ngsrce
QWUvfQaruPidD/knVapzPR7I3TYeoj8Fajr1QYwSb7YJfRf+V3BSFht9DI4S4w9o
2oE51TI8zzB3Lxux5Fqze88LR5Dz3ij++o5guBdgMaTlTaPGqvjMo+ecFKF7Mx+N
PUE+c48G20p194CR1AseKKpEHgnoikegdqchlUHRiFxT+Wi7o7mLG0OVY+Do/HvS
ae9/h5w1yGrC7NdPKNmkk/9U7KwK3LdVaD6bJiAe2SjUnpfjH74kwsbwRSBFQdzY
NktxJNy4j1xLxKoO3S5z+VASbNvAWh0bpPz3dQblGLenyuptgCdkgSVz7l6EWIZ8
wpzsrxEJOYRJz/28cIGhwDHp0gInWBrdRJfHQxZMVTiJfKKeUi+CjcSmTLxNaAKH
hKMDRTDjWJl02rHi1v3yPWnX+OhZRvWwMxTJY7ncEs80H+cygsNY0V5ZSxB/ZVqT
71F2Ol2yZqiif761bmUORSMGqOA+QO/F5hsscZvOJFBs4CBTUpduh785Y+w4MQoE
2PcqsShDt6DFzPSCrQ8zC6k5jCJvk3XyYOdMeGvVyRUGCUKLssdgnwKlADHSrofT
GITcp1Xah2tb6IAW3zvOWRx7fZSMZyN5L6SDPe8yJodjz69r7+g=
=5QJr
-----END PGP SIGNATURE-----
--=-=-=--
