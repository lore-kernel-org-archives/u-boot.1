Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139F7CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 19:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39AF832AD;
	Wed, 29 Oct 2025 20:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="slyJNoBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC99832BC; Wed, 29 Oct 2025 20:15:42 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D088003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 20:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3d322b3fd7eso126648fac.0
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761765339; x=1762370139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aCRgEy91JcoqA0dYJCE5Zw6KUNXupEfTuga03+wDAdA=;
 b=slyJNoBR68SmXIkijxXoD1Dbm1X7JLiRAEOp9P6XelC9HoMfwpVSBLzjGLK9FFCmwl
 oL+qQSzhp+CNDiIbESVXQsYfIQVcpiCqEZYNdsko86kVWK/55rGWT/Y83R55fEhJ7oHH
 ZOECbLvBmWkkqzocEubaumBIEYSsky41MA3k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761765339; x=1762370139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCRgEy91JcoqA0dYJCE5Zw6KUNXupEfTuga03+wDAdA=;
 b=IDRrVC3OHQo5fKFKHswdL/YiB4GaaawYDsYvN4Cbt04y+gLPXz7v2tWhwZjPH4nFSm
 QW8eoG8dvqFj9TewMLiNXK2gim9gnJv6IxGCk1ooYB0DcrBzFChEEnIkO81T4wI44wTm
 T4lA6dHqGx/j2P+aA8NDsbZ1BMLfUxGNtv/0kEOHWxwkzLg5VHbM4k9Z86spJtcEsJFk
 4X6UbyF7NdCuhbG7VDd2L+jWFESqKB8WP3Db9dmDGZmFO4McO0dMFkA8XAZaEdFn2odY
 becZTyuU0DTi4Rs/VH10RmE80LP7jmQ5+zNgfOW2HNZbyyGhwqYYD9cdSdx2Fkl0AtmO
 GJKw==
X-Gm-Message-State: AOJu0YzmU2TPeNNg2Yk+tp4HUiBviQXaCy+cuUR0XUisxiYvkmiuZfHM
 ZuInRQz28t411eLMtgM3Mn+vAeMJGXAmLx36siAdEc5uHlyLDSpCsJSjBw7qI6ozVcU=
X-Gm-Gg: ASbGncvOs+AgwkyJQVlWaXrAS4kwwb4aWluE6laCYNuaJzDtwVZ936SmjFh7mBqwckd
 VuRBZ1HvZQ4odEJtJFUSoCoDOPwLAsT22HG11R3Bmtn2I4+84JUGqXRKvCNMunJOW+ooJcXf6S1
 HLN9M9mnZjE/2o9lKRXDEDBvAdR6NVY0HtkEJ4CjAUfyWLKzPzBVO8MmC6Ip2K/8rWa6XSehIAz
 11c6ASFbYzZKIkTh58I+BlikCPs3OoW4nJ7AoMVWasbMVOwE7bGcjkscmYT4ejgHkLm6rtq13nF
 NNY2vImSW9bOaJK51zQo3jqjEpmZ5AhaNf8CcSsyHf3GDse0m7ngjiMn/kGd6rpS5+7L7KSoJT0
 B5iw+MfWw3TSGtRXHNX9j+QOEWkU58v3NKslwUCehw3PUP7mf39tizugcWp6wrmg4fMgC8rWPYR
 Yk2Xrf3w32JY8DvNM6VeHceo99zvMtDgiZWl5uPV0=
X-Google-Smtp-Source: AGHT+IFpcOpQ8UJctLIBYWkbb3jhdblTWY4pQLcFlVu0uhyskdG1TFVIHTG2yV1daLUt3vFe1FFrew==
X-Received: by 2002:a05:6870:aa8c:b0:333:7e0:dc27 with SMTP id
 586e51a60fabf-3d7461a44f4mr2175572fac.14.1761765339083; 
 Wed, 29 Oct 2025 12:15:39 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5301189c9sm4457537a34.7.2025.10.29.12.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 12:15:38 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:15:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Sukrut Bellary <sbellary@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/3] pwm: fix typo in PWM_MESON help text
Message-ID: <20251029191536.GN6688@bill-the-cat>
References: <20251029-pwm-kconfig-v1-0-80186567f2e8@cherry.de>
 <20251029-pwm-kconfig-v1-3-80186567f2e8@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EZWN9tTt6ZEa1wue"
Content-Disposition: inline
In-Reply-To: <20251029-pwm-kconfig-v1-3-80186567f2e8@cherry.de>
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


--EZWN9tTt6ZEa1wue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:16:10PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--EZWN9tTt6ZEa1wue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQJn2AAKCRAr4qD1Cr/k
CoMTAQCFRYtj92+6utklAGwQ3dcCDbARubiYqKDula6P1jalIwEAgmEf2rlmbfST
PKRmcMkzOsRjEudXIcuxrsxa+cO6AgM=
=AbGd
-----END PGP SIGNATURE-----

--EZWN9tTt6ZEa1wue--
