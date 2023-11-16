Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D712CC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 15:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D183C874CC;
	Thu, 16 Nov 2023 16:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y++ejbEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 593F987465; Thu, 16 Nov 2023 16:44:39 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581AD874CC
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77891c236fcso54907085a.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 07:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700149476; x=1700754276; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mSutQi4ItpoME1J98kYghFbNKZCYxYcbCeWhvnxs/cc=;
 b=Y++ejbEAp7694IaRp8osqCbpq0ECI4N9V4c3mkCfwzipOPC4M9pBOHL3ISvSrrHFR/
 VxLpngs7WumTsvf5mg57Dnf8SGc/yNqEKMQAWkoNaHU218T3npOvg7ZVR45WkPtl6Fd9
 DDhjOxDqJkrq5/oFINQHsFjNk4aSoZPrIF21w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149476; x=1700754276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSutQi4ItpoME1J98kYghFbNKZCYxYcbCeWhvnxs/cc=;
 b=jMXmMRI7s4SCVFy9JTV0+cbE7inKJWkChBAc46+Yo736+HuSU4yV25KE67wRAkBIUp
 h6BWtsx6U7jZd9ua+jdw6KISTt/Dx9rsRIQZBAfCpvnUllTZ4kbZ0Q8eX10+AfR7GFQb
 Gn/BNUlxtaj44FjM/jCHefDJwm5UwMpCEyDJyqNNzJapirFv67lG/P7QMFQxw9iDq9S/
 u0Ye/sjjM7C6fWC2XFGCjYJHPs+aYfxZlIgV3FBlpbYa21/snGephHn4o2AS4pSA5M4M
 YoEu3uV/moaUEFkqE1d7o6hAJwyVTj4rBZAmIn6JqcDI9X/nit7JwwNAW6FHXMeXHg3J
 lbVQ==
X-Gm-Message-State: AOJu0YwHItb19sHGmsfHlESRLInmwQRVd9kTQBq0Ze5wh/OAdn7b2YWx
 bpmbBpiHa7/IaNUT1KuqhM3FqS5+tv478Z1QNX5iHg==
X-Google-Smtp-Source: AGHT+IEu9xeVVyYSpsRekI9T5956tkzis4mSb0xmx1aGW6cOyjK7zm79N4ZnuR5IVTkdXT7AlBFIxQ==
X-Received: by 2002:a05:620a:5635:b0:76a:eeb6:dd7b with SMTP id
 vv21-20020a05620a563500b0076aeeb6dd7bmr9255466qkn.75.1700149476206; 
 Thu, 16 Nov 2023 07:44:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a05620a127600b0076c8fd39407sm4360403qkl.113.2023.11.16.07.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:44:35 -0800 (PST)
Date: Thu, 16 Nov 2023 10:44:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 22/32] bootm: Pass image buffer to boot_get_fdt()
Message-ID: <20231116154433.GQ6601@bill-the-cat>
References: <20231116041043.362055-1-sjg@chromium.org>
 <20231116041043.362055-23-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ff7obhXifRRN5Vl5"
Content-Disposition: inline
In-Reply-To: <20231116041043.362055-23-sjg@chromium.org>
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


--Ff7obhXifRRN5Vl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:10:22PM -0700, Simon Glass wrote:

> Rather than having boot_get_fdt() calculate this, move the calculation
> into the caller. This removes the access to argv[0] in this function,
> so we can later refactor it to just accept argv[2] instead of the whole
> argv[].
>=20
> Move the function comment to the header file and fix the u8 argument,
> while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Ff7obhXifRRN5Vl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWOOEACgkQFHw5/5Y0
tyzhIwv+No26aFqFIIsDNE+Y+6/BIfdc+PvQp8FgVv409wxT6tbPS80Bo4KImGMv
BAEpJvZQBeBQ2IXBhhT/4fIXt42S/IdOZ5F+M/VrrMRkE75wryzbB4mRKPDe+382
cAolJghZ7jghXO4BK0ECFYBL8QjPIK1EfnFZF4fm/Z6p5rnM6JKhTK6Yk6HvpUYa
cbuQHmftcRWvObTMjbhaKW2FkGOBBv7pUq9eYsj+53fsBzityH5j8MScvv7bHeKV
tEs4xFI8oVCv6YKb7TN6cM/Fbv2WMmdCklhAmo5vN/e+1m4YMqrJKcpJZjRpn5j2
ReJqTKrHLx6axwpU11CphA6C2X0PRi0Pqntw/nCc7ppb8WZ5kqZZhVKvXSN+pmpO
19F9+a37223XY8DgjfuJSBa1oH6XVco4Eb+wJuLL66EEMlNtfpjG68BgKqpZWTn2
VfMqRKDR1FnOC7vfEip/2kMqgJDA6rGsNhDl6JEKlCPPPBWWdLWccL4y1Xt00kPI
lKfbD6M1
=BEcw
-----END PGP SIGNATURE-----

--Ff7obhXifRRN5Vl5--
