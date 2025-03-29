Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7628CC28B20
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 00:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4734E81ED8;
	Sat, 29 Mar 2025 01:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b9HLtsQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1BE681E5A; Sat, 29 Mar 2025 01:06:07 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33F5809A5
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 01:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c40235c34so818364a34.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743206764; x=1743811564; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=liYyc6PBrV9blrv3rvxpNNBRMYG/OVIFJuOTlshVxiY=;
 b=b9HLtsQae2EuzZrhzZ+BZG8ebP9lE8/ZW+3LfdCS3vUxdz5agbNCJVAkHyAcQnu/cg
 YFTlhGwZwrZEk1ttS6dXuhGTYdIDvZnBLbeY7OHsnk552X2KalQAyGtu9+DAs6nSdumh
 49oPsCGpKXToJj6+iLBzfqVb8XRrlKQhIvVd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743206764; x=1743811564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liYyc6PBrV9blrv3rvxpNNBRMYG/OVIFJuOTlshVxiY=;
 b=C5CUiMIlrJV3rSd6oNbG2fdrbj0Tkydvt1zf1dcFhOxjQP5aeq8rCtjVnYSctAi+02
 mzeKT7mfYtBrW/nmaY4XxFpjMulrWkWYuOY05LpIQqg1d0dCgs2CIKvSDfiMCYWasbcn
 VjBORubsv5RuG712GHrIDyERWMi18CKWdXJf4e/6gOuijcTz8RxUUutI1X2KFhs6dZj2
 zb0Mckc6MSTn9cpXtPBz+FiJn0TgX+X1AwcNxPHvK2zSVlY33EKNmWtbfs0Vdr/e9B/i
 3SAHp5v43Ektd2zP2JFNT4aE20kbWXMTHK9/6G3sPS/O/XV8xeqHkLLPoL/roJtajYFS
 ghhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCHaYHzlQ6EHvbDgf/UD3/AKsS06bUwywpgcmnJDjofC/+Mdm9DTllAt5iuHStZgM89cu7BBo=@lists.denx.de
X-Gm-Message-State: AOJu0YyZ42fqk18xg0OExDAaK+reafxyDuW1pg31e3zjvCCZcvzYhyL+
 1u60zrD0Py5nZDlW+y3vpX9s/IV8AF4Dyj7Vj+XvigDqamUjAGF+MRxSTaGTKfME8ppJf2nr3Va
 c
X-Gm-Gg: ASbGnctDRHJC6Mpz2TJ01/yhV9fdjwe8DoQJE3L4cjDcDSXxX3IczJ7CTl/dOg7L+J9
 ceIwWQWPsDvb3md4VTdhP4r4ZrkDT2GffK44jaAwvhpRgUwYJ+0n49Uh6cUPsZYA6qs3N9b+DxR
 gLEDwwXJYr0wqnFTjEJdJBXj1pInX+Hv6aKHFphdC8a2zVgTTSt68cT45hQ4WWLc3alz3HztBoB
 WN9SgIcgEdSKyjQ7L1MwfoviJKMCR9Xm7J9JMzBdxXTN0ed6esM/QzMdy0hRjnL0BxVA9lp1/hx
 Apy3iqgr52zFHylYIVubCStE8GREK1QRd0MtsH1FcAu5SbGt6sYi1mXeksFKFAVt0J6sy90B4EP
 FjtoY6A==
X-Google-Smtp-Source: AGHT+IFIw9D54zylEhqFfxQ8bbfnioq/vC0UL1YK1ZMfjg6jGDbjb9UVZcqVbO4U6K2jcTS7IvgyMg==
X-Received: by 2002:a05:6830:6996:b0:72b:99eb:7ce3 with SMTP id
 46e09a7af769-72c63807725mr946819a34.18.1743206764075; 
 Fri, 28 Mar 2025 17:06:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a3f3db1sm674718fac.4.2025.03.28.17.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 17:06:03 -0700 (PDT)
Date: Fri, 28 Mar 2025 18:06:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 01/18] spl: mmc: properly annotate fallthrough
Message-ID: <20250329000600.GK93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MDV3xwJIlzo/p3bl"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-2-andre.przywara@arm.com>
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


--MDV3xwJIlzo/p3bl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:32:56PM +0000, Andre Przywara wrote:

> Depending on the various MMC boot configurations, we might end up with
> trying filesystem mode when a raw image boot failed. This fall-through
> in the switch/case statement is explained in a comment, but this is not
> visible to the compiler, which still will complain.
>=20
> Add the proper compiler-visible annotation, to allow enabling the
> compiler check in the future.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--MDV3xwJIlzo/p3bl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfnOWgACgkQFHw5/5Y0
tywBrAwAptwoztncvZCcQCSETpwnXH+/fN0ZOAHFjkIqupByiAj345W+kdfyx/PV
dAhSLF1FMnvDwCa91idqzGQHKjbix2bDD9oKEuvD/drTILQ0xuGUdPpFUZAm6mTd
ZSzA1Fwu/wRLpet0C9sES2hOpnbI/K4LIrTLKQG0ARDvd/uBv/9tR67aBtbLIxOX
9vro4rwFpXOTroLGwXPcFeY4TrvsiItsALGh7VIuxTnparERiF+e3nWt5SdnOyCv
I7xZKeXno63QjPdBHSZPTRmUcHncxjoCEvQL2/4ydE/zxWcUOf4EZcRRszliIiyI
N7bqwhShBs1+HV542rFAhD8CBZ9ZnZV848e0mJO0O413TfCkavHPeIuI7xy8UdYx
pWZdXF3E/1cNvvpEW9t2UyNPr0QcTxjZ0Co7uV4a1jgxIWhzshh034UqDLA4P/sg
N3uuo8yRsdAOSGtEfiJO/fzXUVCkeQ0BUh0xj0fzT1G2J7gX/toZjNGT1OYyDTv6
qSWovkWt
=rigl
-----END PGP SIGNATURE-----

--MDV3xwJIlzo/p3bl--
