Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864B8FD3774
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F1D83D8A;
	Wed, 25 Feb 2026 18:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Meyjjmyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC2C83DEA; Wed, 25 Feb 2026 18:12:43 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DD783D77
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-46413b2c3d8so2327629b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772039560; x=1772644360; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RXEJ2vRQlXOGZd1OGNpEOaAfAs9L8jx7+B2m1O+o+Fc=;
 b=Meyjjmyvk2JTlqA+GYvbgU4PK5D8ifQc/mUA7Ps4GBVM9Z6MHZeMEz7q0CesJYhx0o
 1cIzVdq0AMyzjqkxb33SqcHRb7iLUM+wcuRKlEesVFdXNeqcUVfMgPgyzO2Qi1Fne1b7
 fqmihPCL7dE7CoaoJHZ/iaKGgppf4FlDCTZ3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772039560; x=1772644360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXEJ2vRQlXOGZd1OGNpEOaAfAs9L8jx7+B2m1O+o+Fc=;
 b=ZzVQDYGDlYlunmer2HCAMRuQmWF5aQBHCiEk3YK0/Qy8E09vRheInuB+LC6S9h4Zp4
 Wjq1Lh21AfHFsQiaiWfEk4LGBUUI6yjK7DHLQch/MOb57xltL5/VPo7vck2dTrju9Jrp
 s7S8y0yvUUCp0hzObplwJkQJoyfdBSjk2sG1KAAilq5F5J3vbcjtxdtW8rBUBSIkQTDQ
 +WYCUXaXiNsKo6CAbnCAaceG9nrM9eSfqk+oUZl1JVsOonoFbG4ZnxEDYS2Kw7QLCD7D
 GW+zrk/cCSUBDzeVGjC1nm7YqAagmUOGjA0Q0bWMyrNmSzn4A3xBh7+q2rG54gmj8ilK
 XCpg==
X-Gm-Message-State: AOJu0Yz1nnRuWyZNQyhAWpdUYT6bp9quB/Y1VBSaaB1oNTPUND1aYM36
 wL+6wmEX8YmkLw7agrC9PpIMTtHBWxyQ0R5IadOvl5d1GDISBvmjMrolcLBiPt1OGHk=
X-Gm-Gg: ATEYQzzLmpCCHa5FEQOQkW29pZE9mSfN8MISKVByGv4opezCZyiFVQbu6GYz22GOLXD
 zigq1tRWNKqIt6AHhoOUEmZGtIC4WoNX/TsAQH/420gUOE1jhIGPIU45JvQ0O/qErrDQeHM1/Ai
 Wl6HVRn5RTVZlIB4j0Eygg/CRQ9gII4Q9Ycf25hXvDyb73blE0CD5Hh4pF6BbKtz8GdEiEi4B1S
 PFK+VCSG1IgJoa0gbNTgLys+iCvlW4sgMQMobyqBBd95s4Qv1Avcc3bp/o2EoMGUepqr7OO/cYP
 hebVC4reQvubfev2h4S/CYYHOQZmXVjmT8+9kiKVWK73sAeojJ3eAhfgfDNL3fh/+rpfLzXEtPr
 P8ERPA6h5FVVJHCKc+qBDe5Oe3+PyQbITHz4FTLevfi1UucEatNMo+cIwRATQGg6o70JNfyvXN9
 hW0nva87yaNxb/YTf1eo4XcT3QHFS9DXHAGbWa+jh7pKY9/dGW43iPNwG1r91j2df0CmyFApSkG
 0Q7n5VNuVmqzHf9HZDvE0Pm/scGCkcOvdfzbPT/OF09VQbnM8g=
X-Received: by 2002:a05:6808:4f47:b0:45c:8dfe:19a8 with SMTP id
 5614622812f47-4644636892bmr8486282b6e.44.1772039560125; 
 Wed, 25 Feb 2026 09:12:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d0725c4sm13904734a34.25.2026.02.25.09.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:12:39 -0800 (PST)
Date: Wed, 25 Feb 2026 11:12:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/6] test: Update fs_helper to support passing in the image
Message-ID: <20260225171236.GP1593142@bill-the-cat>
References: <20260225162357.3449937-1-sjg@chromium.org>
 <20260225162357.3449937-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EcJN7Fk9HxsAM+eh"
Content-Disposition: inline
In-Reply-To: <20260225162357.3449937-2-sjg@chromium.org>
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


--EcJN7Fk9HxsAM+eh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 09:23:45AM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> This function is useful for other scripts, so add a parameter to specify
> the image name, if desired.
>=20
> Also add a flag to quieten the output of some of the tools, since in
> many cases we only want to see warnings / errors.

Please stop doing "also ..." changes. One logical change per patch,
throughout.

[snip]
> -    fs_img =3D f'{prefix}.{fs_type}.img'
> -    fs_img =3D os.path.join(config.persistent_data_dir, fs_img)
> +    if not fs_img:
> +        leaf =3D f'{prefix}.{fs_type}.img'
> +        fs_img =3D os.path.join(config.persistent_data_dir, leaf)

This is wrong (and would need to be reworked again in later parts of the
patch). We must ensure the image goes under the persistent data dir, but
we can allow the final name to be passed, if that's actually useful
anywhere (which I'm not sure it is).

--=20
Tom

--EcJN7Fk9HxsAM+eh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8tgQAKCRAr4qD1Cr/k
CioTAQCGGrNHxiCeFgEtKQdmPg9JOYAD9xwPhoOyC/MviI+epQEAh1edfWt/iptJ
J7ETRv4cE23dEUCA0kL9S0C0eOCLXA0=
=HxVd
-----END PGP SIGNATURE-----

--EcJN7Fk9HxsAM+eh--
