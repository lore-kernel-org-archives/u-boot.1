Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24E7CA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEAD783020;
	Tue, 19 Aug 2025 11:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=silbe.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E0382BF6; Tue, 19 Aug 2025 10:32:38 +0200 (CEST)
Received: from bbox-ptr.sascha.silbe.org (bbox-ptr.sascha.silbe.org
 [46.38.230.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6393780FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:32:36 +0200 (CEST)
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
 by bbox.sascha.silbe.org (Postfix) with ESMTPS id AF8241E1326
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:32:35 +0200 (CEST)
Received: (nullmailer pid 122178 invoked by uid 71000);
 Tue, 19 Aug 2025 08:32:35 -0000
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: legacy image format on BBB / Debian (was: Re: [PATCH v6 8/8] Drop
 the special am335x_boneblack_vboot target)
In-Reply-To: <20250818141704.GW124814@bill-the-cat>
References: <20240627082949.357089-1-sjg@chromium.org>
 <20240627082949.357089-9-sjg@chromium.org>
 <yh7ro6sfsbjh.fsf@twin.sascha.silbe.org>
 <20250818141704.GW124814@bill-the-cat>
Date: Tue, 19 Aug 2025 10:29:29 +0200
Message-ID: <yh7rjz2z3eae.fsf@brick.sascha.silbe.org>
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

> It's frustrating that it looks like Debian 13 is shipping with this
> legacy option as the default, I assume for all 32bit ARM systems, rather
> than any of the more modern options. I'll take a look at what the impact
> is on adding LEGACY_IMAGE_FORMAT to the "distro boot" option so that
> nothing else is missing this.

flash-kernel has no way of knowing whether the boot loader used to boot
will be the stock boot loader or the one shipped in the u-boot-omap
Debian package (if installed and manually copied to SD card / eMMC by
the user). Did all BBB rev C boards ship with an U-Boot version that had
FIT image support? The oldest version I could find on the BBBs I have
running and reachable via SSH is U-Boot 2015.10-00001-g143c9ee (probably
shipped in 2017).

FWIW, the main README in the U-Boot repo only mentions FIT image format
in passing (referencing a file that doesn't exist) and then goes on to
explain the "Old uImage format" in detail. To a casual reader that
suggests that the old format is still the primary format and that FIT is
the more modern one that can be used for more complicated cases if
needed.

Sascha

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7Ycc2t6Wt6eY1E5VwY9q6IEw7ZcFAmikNekACgkQwY9q6IEw
7ZdnJQ//VVK9XBdaK3p0WCGR2/B3nJrhykL/7FOy5bHG+iosCEW+Wl3+tsvKtriz
r8Kuv3SKLTRbe5DqwvWg4KndmPo3wZ3XBRGbuOCTufd2JDGIdHtiE/OVWrmi/n6K
cdLAkzyuoPR15ccyPD4jy5gjhXW+6vfLKqXc4G4s9AYEVuAH9npBAj7BQXDPLrqh
tflaOSAzjvRXzAHtIOvpuFBaMEfxyIfbraJW6E4AdtvcLqNeZoEe0533V1pUNIuq
qq4Mz+K0gQywwb8gkznnUIcTzjyCUmcpiW5uWnpSYPG9vPEN7ocpoXNDqdSHIQGl
JF4WM+XbfWAm0mIW+BfqcOtg9q3yYA3fXgV/H+UPWmoMnk4zO2ID6uyS5cx9MJgK
cY+FhgTpol1cqqk7tLIReDfKv8hosJBKY6THvq5etJ96AuOmQ5TI2uYIcY6Od4/n
oZPl+yerfivDs+n26d4KY5lIEOgAN6peCmws46ltnd8BxINc4jRpGR1yyt7PUgXr
o5PkVS/IngpH0cDYATIcZGjRROl2ZP12vDm4rSbz3I28R+SpJlYDNW6seH99aqEo
V8e31ay3+mBiOQtirVtKOPrWoz4TG78BIoyQFqBaZIWYIsZABMNDWONPXxAjS3cP
Y9LfZrbzgSpO4SQxeQucHfYr5JewJ9LocxKjcpVe1lwqY0FgDHI=
=slia
-----END PGP SIGNATURE-----
--=-=-=--
