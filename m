Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E70AD35697
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 09:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F2B83C39;
	Wed, 28 Jan 2026 10:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YkQr8/a0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E7C683C54; Wed, 28 Jan 2026 10:44:14 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30F183C29
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 10:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C102460007;
 Wed, 28 Jan 2026 09:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4F1C4CEF1;
 Wed, 28 Jan 2026 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769593445;
 bh=qXnFSaVtV1Ww+H4K+SnaQV/F9+q2/N/HkrxavjPsh9g=;
 h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
 b=YkQr8/a05sX50pCnqOltqbWdbfS3zKOgdocboMXaQzAW0OW0mHnDk04GDQwGte8PR
 piwpTzYoRbmV2NK/UAmznxwz15X3phsTppu261vHp1m7qtWE/QU1kVhfS1tt+J15iE
 ijthiDbzkZnsRuakZSutvn/pn3ORbkF6zL4zUwAFz1MPShFW1vdcXIZTm+wK9IM8Iu
 uDuPXxVi/UTBg8IIfRo9Lnixe9OQD8ralWIQRZaYsDIGPpvVCJd4iYZBkjwhSl1EHn
 sN3UODT50kcTep9VOZuPrnh+0x2Pm3PfXW4T5s4EBI5R0NMvpU4I0IqpD18SV0lhIe
 qcLRrmW/kED4Q==
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=712ce695dc756f27fef29d679f64ea494316a81cac9907750ed761a19a7f;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 28 Jan 2026 10:44:01 +0100
Message-Id: <DG04IS46IUIL.2XFC006XHHTIN@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>, "Tom Rini" <trini@konsulko.com>,
 "Simon Glass" <sjg@chromium.org>
Subject: Re: [PATCH 0/4] board: kontron: add initial SMARC-sAM67 support
Cc: <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260127150401.1177176-1-mwalle@kernel.org>
In-Reply-To: <20260127150401.1177176-1-mwalle@kernel.org>
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

--712ce695dc756f27fef29d679f64ea494316a81cac9907750ed761a19a7f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 27, 2026 at 4:02 PM CET, Michael Walle wrote:
> Add initial support for the SMARC-sAM67 board (enineering name
> sa67).
>
> The board has different RAM options. The exact configuration is
> tri-state encoded with strapping options. u-boot already has support
> for that, but unfortunately, the pull-ups/-downs can only be
> configured by the pinmux and not by the gpio controller. Therefore,
> this will introduce another method to read the tri-state encoded
> strappings by switching the pinmux configurations on the fly.
>
> There is also a sysinfo driver to read the remaining board options
> and is used to apply corresponding device tree overlays.
>
> The device tree itself is picked from the last tag of the
> dt-rebasing tree.

Please disregard this patchset. I was just informed that this
product is discontinued (without ever being released to the market).

-michael

--712ce695dc756f27fef29d679f64ea494316a81cac9907750ed761a19a7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaXnaYRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iVfgF/dljbk8TUiZSeQ7Tpg8jNzMO/O0HbEuB5
5tilwN8TVLWwCVDxMFT9e29UBW37D525AX4vJM3NVBKZaaAdpl5iXzb5uga0llqC
/i6mijp31blcruCCwIxuS4VPleunXhaN4PE=
=0/7m
-----END PGP SIGNATURE-----

--712ce695dc756f27fef29d679f64ea494316a81cac9907750ed761a19a7f--
