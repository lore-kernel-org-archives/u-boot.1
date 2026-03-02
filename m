Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FB9EA4E33
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 16:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 929EF83F30;
	Mon,  2 Mar 2026 17:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ubLz83QD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCC083F4C; Mon,  2 Mar 2026 17:04:24 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF5D83F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 17:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-662f9aeb782so3751541eaf.3
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 08:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772467460; x=1773072260; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6Yz2sBTNtY7i746kpTho7llhphLyuU+TzcJSP/vY5tQ=;
 b=ubLz83QDGpG7JXDFoDheNb74/WyCFUenEgGgShHMYXZPBJzOssh76a41MA0hJ+U/2k
 2Ihmtkb3Ceiit6A57nO+0zS3gfOkXAKyryGfIVcVrYt+VIkMHSD6wi/ftpRcJh0tuyxd
 +L4++ODOUUGui0EO72FgUFzst/m7eA1FX+5jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772467460; x=1773072260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Yz2sBTNtY7i746kpTho7llhphLyuU+TzcJSP/vY5tQ=;
 b=ivJZvL0GL6/Bf5/RaX4b3p8WHiiYCxKR/PqysclLTOKKSVpvMIaMSXHNSy9bWWYbPR
 Tc6BBj6HwLyVDp9u5cwxpxKJFJfYeEAkSBr2sHO3vybg7YJKlLP89l4O+vM+ITib8PR3
 KDrL2bYmioJ1EmgNz8XLe04unUYoyBFtH0o94yhnT2oXTi9QKtlY4y1KAatwyWvvM0oq
 H3TdZ9CW4rt3cCeARlcUJu5gX3Ij+BmtevRqO3flPCsZ1AhwMxkPzYsOPubj2TndVqHz
 TL3NdT8M9VXi3XzgX09cUo4cLd/iuyfaol3iZJ2EaL43j1Qsmy1Komg9V8bXZIFLVlHF
 QaZw==
X-Gm-Message-State: AOJu0YzvcFraZjlxnzKag3xIa3MsOV+Bc80a7c+Kly/JDuaPlVWluob5
 eHpnhEbGmhv/pXjqv1CcHn0R3B1fXwtsZeHHiovU8tU89ex0Kkevy0FMkrjCMfcRF9A=
X-Gm-Gg: ATEYQzwrhr3l1Ex7KB590R9r4g7Now0l7gjFneRe91R2x7a9kybo6NBbLs6GMFqWEVE
 eeS/S6wpAGuO144wVwgmFys6gOXKPO2+BDUwY88EBRQjmV1H/7lc01pSWix4dZb10CQpFpq+Xiq
 Dkzjl1y0h68wvzQRQbLv59G4MLsXZTSQDvg9FFfDW639MNq+xP2UHGZoXoKD8cuu3HlRw/sc7W+
 +tviyrsW3sRBH8n7DQIdO4IwTUpAu8ng6tnHiJg5plwmrYDSrtTDAmEfu7U+de1oThQV9PFb6An
 1rTt0LwTYs7kC+NFN2b3esFV9pZzYbIuWt86MTLeMaUkUJ4tvficoTYWk4LZpmQ7kjQOukhs1LD
 jX7/pu3UGI2GyCd8ZjuwAQqYa0f/W98785IfBeut2r7/eOXpFYM4zpM5HimZJ19qoUcwxaW4CWD
 yaDPGXScHntuJVY3ZFESnj0EQchnhUZa6zRvhuXihUjh8ddoCxsjg7EVpKjhdXZ7yGxPYtsdAgu
 lVsD4ZHH3I4umRMIhMmenyvuTHGB6ObmtLJBWC+xZXWlkaMahM=
X-Received: by 2002:a05:6820:808:b0:679:c549:2045 with SMTP id
 006d021491bc7-679faf27dccmr7133845eaf.51.1772467460385; 
 Mon, 02 Mar 2026 08:04:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41640b99b39sm7494956fac.10.2026.03.02.08.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 08:04:19 -0800 (PST)
Date: Mon, 2 Mar 2026 10:04:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 6/7] test: Add a helper class to create disk images
Message-ID: <20260302160417.GG1388590@bill-the-cat>
References: <20260228182304.3728735-1-sjg@chromium.org>
 <20260228182304.3728735-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vhsQCCO9sMJ7vxkp"
Content-Disposition: inline
In-Reply-To: <20260228182304.3728735-7-sjg@chromium.org>
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


--vhsQCCO9sMJ7vxkp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 11:22:46AM -0700, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
>=20
> Provide a way to create disk images which consist of multiple filesystem
> images.
>=20
> Provide an option to use the current directory for images, instead of
> persistent-data directory. This makes it easy for C tests to locate the
> image.

This is something we don't want, however. We need to not be adding more
files to the source directory as part of tests. This is a general bad
practice.

And in the likely event that you're going to note that python is slow,
please try your suggestion of 2019[1] and see about making U-Boot be a
python library, and if that doesn't work, look for other ways to speed
up python? Given all of the real time machine learning demos that are
built upon Python, it seems like piping data around fast should be
something that can be solved.

> The setup_image() function is used from a lot of places and that code
> itself needs some work, so this is left for a future series.

You're back to editoralizing in commit messages, and since you do
provide a helper for mk_fs you also simply could for setup_image.

[1]: https://lists.denx.de/pipermail/u-boot/2019-October/388732.html

--=20
Tom

--vhsQCCO9sMJ7vxkp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaW1AQAKCRAr4qD1Cr/k
CgUEAQCf82PSRsnz+EsacogCpM0N5I2sCVS4ZfGuMFRUZYWKagEAu0CRbeIq0hCO
mSVf83BSysQTYmAMkYbKp4/9jNwHAgY=
=1oFc
-----END PGP SIGNATURE-----

--vhsQCCO9sMJ7vxkp--
