Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B46C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03AC3881A0;
	Thu, 28 Mar 2024 16:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ui0UeDFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24ECA88010; Thu, 28 Mar 2024 16:08:57 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F82488191
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-789db18e169so66834785a.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638534; x=1712243334; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aWb/4ZrsYGs+Ji1oSeVpKH5WBkb6vzoWw86nOx8yh/E=;
 b=ui0UeDFfX29oQ9k9kAnALlQzq7Dn+UHg1b6Ffdm7ht6+Kc3/qOqVmUJynGP95A/aAp
 5AD5xdwGZ7W/fk7v2TvnM9+AyUi7oLsGTuOB0aeNO9rke5NF8vNLSaBW8kWP/+NT4nfI
 asPhG21k0/r/ZTpwWeQNJAMiULtDsQeZhmaHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638534; x=1712243334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWb/4ZrsYGs+Ji1oSeVpKH5WBkb6vzoWw86nOx8yh/E=;
 b=QgQ8OuaHG9RsGntXss3De4eQ2CxMeaabkoeAeiAo7p207tnW0VuMRxJtZHGta0Ye2b
 H0ltPrmBTP44IsxM1j9if9p3rNeYdW/mAOzU9lu0lPhMU0045XR1RFuj1mbO8bFsg1eb
 CQg1hBnAWxixt2Zp1uxbcdHdsfCvp0zrLug1dPBsNkxb8dGPxo+TQ9iCMamxkuDl8z1p
 B2JzCyeNy58zoFQMbTdsXMZcO/smGLh+GjLWCg4ZwuUcKy6x0TOn0hAuuornp6HyUuTE
 D4ZXRI3h5pe71CDS+bXNUgpHMZCZB4YywyqmK7eV1DiCSGnw0UDsG/pPBDIm54efygii
 k4cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjLed6lzWEz6U81UPC6vw4hxJfwQZPfGf2vg98oOuxMOww2ZJRd4vfY94t/rPXEF/ilh+W58nIwIowHAYu1LYRZFIQhA==
X-Gm-Message-State: AOJu0YwGIpsXBltzFM6v4xhnMemV8k0zkRUZBUHQVr4R4Z4B+ZjnRbHx
 bEnqTxndXKHLlo+ZEmKUr4Xcfz2x1piLPZjEvuvWqlDl/APRiV+DwZ+odR92w9fjWnWW5xOWnux
 u
X-Google-Smtp-Source: AGHT+IEVilWk/byrUZUb4oUztkgkV8PFanSdIQufwe/cKkAVbpxUFxLmGPNdkqlQgeCFXtiXJ6Qqxg==
X-Received: by 2002:a05:620a:1d81:b0:788:56c0:6006 with SMTP id
 pj1-20020a05620a1d8100b0078856c06006mr3168735qkn.4.1711638534063; 
 Thu, 28 Mar 2024 08:08:54 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 u6-20020ae9c006000000b00789e17a55fbsm583254qkk.131.2024.03.28.08.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:08:53 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:08:51 -0400
From: Tom Rini <trini@konsulko.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, michal.simek@amd.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de,
 BMC-SW@aspeedtech.com
Subject: Re: [PATCH] net: phy: ncsi: Correct the endian of the checksum
Message-ID: <20240328150851.GT3442575@bill-the-cat>
References: <20240205080228.140001-1-jacky_chou@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hlcQBgsi8U3R/x8O"
Content-Disposition: inline
In-Reply-To: <20240205080228.140001-1-jacky_chou@aspeedtech.com>
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


--hlcQBgsi8U3R/x8O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 04:02:28PM +0800, Jacky Chou wrote:

> There is no need to perform the endian twice here.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--hlcQBgsi8U3R/x8O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFiAMACgkQFHw5/5Y0
tyxg7Av/c7wNcqfZOGZ9lGVHYn//IUDMOcJnnKVKE61ijWt1r5qcUXy780qOIokx
Zf8ocB122nai/MPB7zLaNovYDK2w7huIchiOlc4G0Deb1dj064uWxO0iPYJEEc5V
+m+CXFYrPT/RshXVs8bKe5gdEk2bLLn4LUcPeJg1MKByXOd2K2Nbn4TW/j04PSCY
9XlTr1UAgi2y5wvmzBqwvGHkYMKO0mk1WHUNtZN9kk8Clj7D612yIVe0ufgPz54X
7Qp1eS2LOKr9sssCRIidevu71Cb2I0PptHegmyiKErGYw1AS9Pgisrbg7+66DuiK
gyNtU346GR7Yx43Zd4Jw68pAPSxgJcdrUAc6IjJvO5d4CiDFYi+pJAVc/U+YP4Mt
Hu7f+hb3jB+roYBFRabQZk5YpAnhMahXCU1+wXpE2s/o1W0WHRho++nzwQopm0Nm
Fk12XQKvcohu+sComFQNOHSKcl2oe90/6TBVY62sYO0r0sqe2r76kcGb1S6TZGTC
c7+Su3Qj
=UdJ0
-----END PGP SIGNATURE-----

--hlcQBgsi8U3R/x8O--
