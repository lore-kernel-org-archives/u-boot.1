Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F95C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CABC480B9B;
	Wed, 22 Jan 2025 18:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qNIAMEeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 177F480B9C; Wed, 22 Jan 2025 18:24:58 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF06580A09
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d8a3e99e32so525596d6.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737566694; x=1738171494; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nKBXCC3+JPMu02uLrivM+1oF/HVh3UnQgG2xKYc0lrA=;
 b=qNIAMEeCUueessO18wmcex2G9wDJUtGp+RKIuDMtxwcC+BVn5MIiQJc0l4Nw+RTUrT
 Xt7crUvkseWyvFCD8Li/uacnGs6XqeJRWwqaGaLYG3Pvhlfk5u2z0K7+ZXpjKgoazdOB
 Dg4DjiU/Dly9M2CV1WIa6WT5UagdciFGC+THE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566694; x=1738171494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKBXCC3+JPMu02uLrivM+1oF/HVh3UnQgG2xKYc0lrA=;
 b=Q01SzQdH8dX1mTy7RfCtlS3OUt0ElGEmmVM+2yNWTlM9DADma5DA3yR+pVIOoLhp5c
 kWrtX2lS4GCPK1UyD5USyd/2c6xqYraFrddqtiWt/DgG7gZjYBmHu8+cChi2hVp5FFJm
 BWpIm32ZUuLF9qKqb7xZbi5TSVRUI87DdDXBvYjLmUnsln6XDZY+RTeAyN7lQHHkQAUx
 Wzudr1DG+mVXqk+3S3by37wjK1d8OCWgcsHobuKq5fxfLAxytEIe/AK18m/wxeCs+tk8
 KCdIPRPn9v2NOsPOhmikP3BuNBLEVoWuOWNo7oz8Fjx/1ZqepmZwbV6NVM2wDeLR3r8G
 UFPQ==
X-Gm-Message-State: AOJu0YzJnfhSLdGnvHoXR6ShQwNXZFcMoo3ZmfYwsmUZnQJkK1wTFeV3
 TbSIK3XSI+co17taZ1zVe8IYZiBGswbDUiLr48XiyjUoSArWZZ3X7KFJsmpcxuYcgZTMrLrMCfs
 y
X-Gm-Gg: ASbGnctPBIfbVaBrYAwxmhJzJB2IFDy8NtqvJGlbyC9IDRuWUeyKvdfec8wfjTSnPax
 VR4m+WktgLY9paVtwGwtJPYBJrP1ZAVimBrja+hb4bR3okmzVPNeuyVPsJ8/HP4onvIN9606qHa
 jXH0AN4BJLGuQ8GxPBua70c6KOcLqGZVNT8KevlR7qQHDAsCIUiz5DR3PF4lbOKbToVg6i1ACQ3
 Ucq014WbObiXeqt2o+XhPGtp0gh/T9N3pcu33mgVE1iJNLz073jwh84AjAvxnxy1UA=
X-Google-Smtp-Source: AGHT+IEnbMVHaGpuLQv8jsKHdoj9fw9SnEDcABmXRvvMkRHFZ+xzw2kuK5pww9HEIsz2Leeq+Xnn2g==
X-Received: by 2002:a05:6214:2466:b0:6d8:b115:76a6 with SMTP id
 6a1803df08f44-6e1b1b26187mr395233976d6.0.1737566694569; 
 Wed, 22 Jan 2025 09:24:54 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcf4ef9sm63070876d6.111.2025.01.22.09.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:24:53 -0800 (PST)
Date: Wed, 22 Jan 2025 11:24:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Gendin <agendin@matrox.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 00/28] test: Complete the suite migration
Message-ID: <20250122172449.GP3476@bill-the-cat>
References: <20250120215340.617194-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i6HnCH6VhJqQ6R7H"
Content-Disposition: inline
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
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


--i6HnCH6VhJqQ6R7H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 02:53:00PM -0700, Simon Glass wrote:

> This series completes the removal of test commands for suites. With this
> it is possible to declare a suite (including init and uninit functions)
> without needing to write a command.
>=20
> It also adds timing for test suites, so we can keep track of how long
> things take.

This causes ut_dm_dm_test_cmd_mux_list to fail now:
https://source.denx.de/u-boot/u-boot/-/jobs/1001470

There was a trivial rebase needed for one patch, but the rest of the
series looks otherwise fine.

--=20
Tom

--i6HnCH6VhJqQ6R7H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeRKeEACgkQFHw5/5Y0
tyy/hAwAsQTBQhinvQkERO2t4UDLTI6XIZfi9nPMBG1GHVOfitZixiBvr0T/5bK7
ZTkq2BHFpxlWI3haw2jUSFnCdBU/gKRBGAgx2uzbYUB4svvLIxWsCpXk4jRaodIN
khMz6yp/eTAlEgt5GccugSuLiPaU+Fg9MfpJjEuw3eOhKLw/bnqaFGnnddg3lCT7
uxqr7JFjmo7zulDoQy5NI9lIPuDE7A8w+x1VqU9kUkkmilrJRqrUapn8DhDPmxph
NkdZnGt0dx9aiLdLjk4HfrTTm077fKxZWWzBqUY4QEirvyGlu31uMR5TEI9NseMC
7k6FFfYtEFSABCbaIiT/Ue6Gs6ggqSdntXmde8IgtEZQI7FwS/sAwWnb16VVEg5M
GE/vB7CWM32s60IJKLnHwsrrPhavhcDtE3dNWJZ67Lf51agdviLOseAJyvKU7Y0N
MBbxzID/F2NDnBNtmFrNfrNSRYx+wU1c3MB4GLbZ9YdnIls9vZyn1aX2LVzgWqN/
4QNlm87r
=mpkj
-----END PGP SIGNATURE-----

--i6HnCH6VhJqQ6R7H--
