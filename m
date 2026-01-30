Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32AAD73EAA
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 01:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD9BE84131;
	Fri, 30 Jan 2026 02:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="ib9qu6A2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A71584144; Fri, 30 Jan 2026 02:46:59 +0100 (CET)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C4183AEE
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 02:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=vagrant@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=U7bfE6FKV4sfqGp20RW/diqUHRt1mpEv/fKmlkcpY+s=; b=ib9qu6A2uzPAuXjnpOv6nqda24
 vWYQfAgFWXfJxXkdqm0VtJj3m62ppj0hq4WAtUKS8ZMEin5H9f/kzuDDAqpz8++E1uqw2sTB/WTJj
 K16pgPWXtKa6K2LZeknUE7yUYurZ4d/HlcCJEJfi5+DKzNQTkjntYOdjdkgaHs+fFGEZ3asysrwp3
 jlNdHEITZQ1UPAMfdR3j93K1s76zt8zboGBYZ4SgjaVQxFJrQylMMPQ/MMVAQN0noPNAqkfl4EMQL
 SMv1QFnIs12u6hNcpXiZMzwk941JlDtPxzg6P4UBn/C5cPKU40Dbt1zjG/Xy9eByh646YsaJgbNAF
 Ehfv31LA==;
Received: from authenticated user by stravinsky.debian.org with utf8esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <vagrant@debian.org>)
 id 1vldb5-001N6B-8m; Fri, 30 Jan 2026 01:46:55 +0000
From: Vagrant Cascadian <vagrant@debian.org>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: rk3588 MNT Reform2 fails to boot from SD card
Date: Thu, 29 Jan 2026 17:46:43 -0800
Message-ID: <87ikcjc1oc.fsf@wireframe>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: vagrant
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
Content-Transfer-Encoding: quoted-printable

Thanks for adding support for rk3588 MNT Reform2!

I tried using u-boot 2026.01 with the rk3588 MNT Reform2, but it only
gets as far as SPL, and then fails:

  U-Boot SPL 2026.01 (Jan 01 1970 - 00:00:01 +0000)
  Trying to boot from MMC1
  mmc_load_image_raw_sector: mmc block read error
  Error: -38
  SPL: Unsupported Boot Device!
  SPL: failed to boot from all boot devices
  ### ERROR ### Please RESET the board ###

I *think* MMC1 is eMMC, which I currently have blanked, as recovering
from a failed install on eMMC is trickier.

The vendor u-boot works fine on either eMMC or SD.

Any suggestions to get it to support booting off SD card?

live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCaXwNhAAKCRDcUY/If5cW
qlGYAP4tn3R34ZFf1rT/DaMRz/0jdhBt+GbGJNhcNI2QVfbFEAD9HwmoeGu4Bb/2
7/PYdJ0Z4BIQ4UoHnKuXCeHiX/Dy7ws=
=Bk5H
-----END PGP SIGNATURE-----
--=-=-=--
