Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710D2C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADACD87AF9;
	Fri, 12 Jan 2024 14:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UGHHcfhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500A48794F; Fri, 12 Jan 2024 14:46:36 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB83587AD4
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dbed179f0faso5175535276.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067187; x=1705671987; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uFPd6A700fnpTvPqHYmOY1+MPMewJoJJj0y3qB0Ioho=;
 b=UGHHcfhsMr4YAoC9emVRfZ+EakDemKKzlKa3yv/wbL11KZPz9wvTJ0jObxqjxUi96e
 eGAUbC9BPLNe8meBVIDRBe9mquZXcnm1/PLr9kGpcChr2bwk6ve/K+05IElaslIfROIn
 r2l7Fdf/8VOUtUI1dPLDl9dsBBuPvxLW0LNKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067187; x=1705671987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFPd6A700fnpTvPqHYmOY1+MPMewJoJJj0y3qB0Ioho=;
 b=Cf1N4rU3u4kLLMxyQx2UiguwT/Lz5cFGAXdfEeFKxQjaErd31cfcypzWLocpZRVMR4
 DmbjY+wJXqFx4epc3PZ1tGCPXhIx2Nau5qpBbFn6GTD/vK9rseVs2/v/pQD2B5Jwi3XZ
 DteAYnS+rcEGD5mVVQHjnnblBlo0tFr4DgX22b7U8QahJAAKbuWbQQnuxJhSQluZsRWZ
 r3EbZ+hQ77wPAu3YLMQbDfndhOnhdiYwB1OomvA2UWjdLqTrWzR461kxcg+hNQaMVGZQ
 Snlqp9VgSnsBRz2wgnPMnNh0GWxGG/7/hmEjecbaQhoMuVt5z1ukHOsYY7KJIUwQQuIH
 t7tg==
X-Gm-Message-State: AOJu0Yx7ZkRrIHqCgY7x5JCs8ABMnGwtaDI25MAujF4jJYbj7G8BSgDA
 PLvHUtSrep16EyMqRLxc+O8VYrb7Qcll3/VoB4DwTWFqNBI=
X-Google-Smtp-Source: AGHT+IFXn+1R6Gwamz3e2ite6TLW384GPgvJ3OvjY8ruNX5sW2SpcpHhCIKalGzKa4nRNOguOqKHTA==
X-Received: by 2002:a05:6902:2588:b0:dbe:49ca:eb01 with SMTP id
 du8-20020a056902258800b00dbe49caeb01mr516975ybb.56.1705067187572; 
 Fri, 12 Jan 2024 05:46:27 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 p15-20020a25740f000000b00dbf2e9d716csm1207913ybc.42.2024.01.12.05.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:27 -0800 (PST)
Date: Fri, 12 Jan 2024 08:46:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Dhruva Gole <d-gole@ti.com>,
 Ville =?iso-8859-1?Q?Skytt=E4?= <ville.skytta@iki.fi>, u-boot@lists.denx.de
Subject: Re: [PATCH] test: fs: fs-test: Move the tests to use sha256sum
Message-ID: <20240112134625.GV1610741@bill-the-cat>
References: <20231219220152.363833-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fiTsVpXIA6UTwHmT"
Content-Disposition: inline
In-Reply-To: <20231219220152.363833-1-pbrobinson@gmail.com>
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


--fiTsVpXIA6UTwHmT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:01:50PM +0000, Peter Robinson wrote:

> Move the use of md5s for recording filesystem file integrity
> checks to sha256 hashes as they're preferred due to being
> less likely to produce clashing hashes. In the process
> generalise some of the wording to use the more generic
> hash term.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--fiTsVpXIA6UTwHmT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQrEACgkQFHw5/5Y0
tyz+pQv+P5ggWe/zgf57T4ZYG3V8pF2uZ90Vat/0OzUKxG1BI6waULNksIzF7nRP
l4LD/oPjvWEwJQajGpbTwBMWsPUfpzFpca0JwXSgiAUr+o+Ztzv/dw51nP3kYeVM
NZ/Y9vaWCO28OmvLZrpvZisv2KfZgLT3ye88SG/1SicAt2sxt1lWIkq1/5R6+on6
zf09EO+fCYiSVekVE24+vRQtLI3Ddt4ZDDcEvx8VNNgkGeMcXGlXjkbL2uZFlbCM
Pkg6VVHtH4mZ+berzsdl3aPYbEeu9kcVG/tan73qTWwd3F8LlgdJ4Szf0skU+dNo
qNx+ND0pfP2/FEqrOa8xnu3ipIa+3GdZGehXN+Ao5MiqhBAD9WXI1WCc8agElXLY
TN1/zDzGaHC86qAkXX9rLmEFYVAqASNhicBHsuvmB1bmW4iiZbhlCXZLCGg0iyJY
m9gVSpT7L15/7sn/OTP86spHKKXoa0la4cdAhZTQCayXF77TzP+E1xEAJhuAosP2
KFt2wUwu
=8Ohy
-----END PGP SIGNATURE-----

--fiTsVpXIA6UTwHmT--
