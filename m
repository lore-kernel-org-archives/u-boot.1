Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D71F357BA
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 17:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F8EA83642;
	Tue, 24 Feb 2026 18:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CuAz5ICy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 474BF83D8A; Tue, 24 Feb 2026 18:09:15 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7264C82A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 18:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-676c6082381so1860076eaf.0
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 09:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771952951; x=1772557751; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=52g0An7Lp2UpXU78YRf7DLNp7+JJ8HI+9UY9mDinfAE=;
 b=CuAz5ICydXy0Fq4FKelPidnWbv9h4NsGKDu8+Q3Ko5+/pNHfICphhfIg6EEVPRn8t7
 uAFyRBixwNCrNoBNHht8icfb2CTXUB96Ryo9pBgIM5xWuaaf14wnV5rv5bqhk1UA5xdR
 3dr5Mu1oZJ0OBXtMZKoLtEzomk7ww3PislqFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771952951; x=1772557751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52g0An7Lp2UpXU78YRf7DLNp7+JJ8HI+9UY9mDinfAE=;
 b=ue7PFbJZSDp4mTNqfUio4LNQUcZcXqF7f1KE8sQiS/jgtRf2cWNsWLe1SELMvgr5cd
 3zbjPRRzF3y9fdQYqg5W70NLar04QxmlO+dqHramkPgBiBN5K5KpZl/McBMoElPmU7Hr
 9Br/1v77lgUZ3go7oRBVCK7vWESSLsN/t+QFf6eNOYOKeUzzTPaNnLTfB1T0a1D06BkV
 rp59PsUSMlocz4qnYhLxVVeDWNVqkDhBppe3i6dIPOZRufWt59FzQSnpgRc3nLp/as+e
 EjgiUvj8seLbq9UAMond5D0VTj2wzFv+Jse8wn6picNxVeJF0/u74f5c5vevF5IF0OUL
 3xSQ==
X-Gm-Message-State: AOJu0Yzk1Qxs+KxQ86/T8d+2rQM/LrnABjEx17Z7oOcunAHXRbCo/tDi
 9qvEriq0PH/OqXJhLWgndiTPFwR6a69Xf5Kw8JyzW7YYJYKvVsFKuEm8pKtyEhn4Z8ejx19gAK9
 JpHtxDeM=
X-Gm-Gg: AZuq6aJixFbio0rkSqAfUgxbxsQ91EomPQ+O6+27TpSbiDxmhjW4p2kp1i4F5lT3yX3
 SQt4cOU5x9pHa00kP/JNy2xT6yLAw41Lvv45tfsq97WJb5bGJ/J35J9ZWm3hLSgFppDRi8XFZjC
 f4Mz+C7zuNIeO+iGzw6FpQ8ovXvAxn4FQM+Qy0QwB1BP190HLAgu/vvRjhNLjZmlAms1L1ljP/T
 lsNanwjp9HXjwEtjx/xdOrKqf7T1eFzPRQpzllUee4EIP40QrXaj+0vUORJ8bF2N3jvov4oYdb1
 vALedAg+dase/MK6SJRqZdSHeV/4/1wTRA1dq/ttFqjdqqssb/BUaAZqE4+aYCpnWKrNMYIDrAP
 W59jBd+ixaEBeXgWZudTcprz3GVfZukM/MUjkCpq+PQAEHi+dj0t32pqirwb3gKgXt24Qb93J8P
 KSup7iL+qWZgj4pa0OIEJD322djwg32BTtB+vpeuamyTbTJjkfEQyI/0fgR8fKTSzAZnEnv+bcX
 Oz7/VYc2GWWpqqF+oeoU23XAtBeIN73UnG9RqbcQiM8GMoxvzA=
X-Received: by 2002:a05:6820:c82:b0:679:a4fe:f024 with SMTP id
 006d021491bc7-679c44d0e3bmr6731816eaf.46.1771952951072; 
 Tue, 24 Feb 2026 09:09:11 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c56574ddsm8849714eaf.7.2026.02.24.09.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:09:10 -0800 (PST)
Date: Tue, 24 Feb 2026 11:09:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Johannes Krottmayer <krotti83@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: QEMU: arm64: bloblist not found and alloc space exhausted
Message-ID: <20260224170908.GZ3233182@bill-the-cat>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PDW+jlid/GJSrRuc"
Content-Disposition: inline
In-Reply-To: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
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


--PDW+jlid/GJSrRuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 10:26:35AM +0000, Johannes Krottmayer wrote:

> Hello,
>=20
> I'm tried to compile U-Boot for an QEMU AArch64 environment, but get
> some error messages in SPL:
>=20
> --
> Bloblist at 0 not found (err=3D-2)
> alloc space exhausted ptr 400 limit 0
> Bloblist at 0 not found (err=3D-2)
>=20
>=20
> U-Boot 2026.01 (Feb 24 2026 - 10:22:15 +0100)
> [...]
> --
>=20
> Started the QEMU instance with the command line:
> $ qemu-system-aarch64 -m 4G -machine virt -cpu cortex-a53 /
> bios u-boot.bin
> $
>=20
> Also the same errors when I use TF-A and OP-TEE with enabled
> EL3 and EL2 in QEMU and "u-boot.bin" as BL33.
>=20
> Has somebody noticed the same issue?
>=20
> I used the configuration "qemu_arm64_defconfig".

That's odd. We run it in CI, but as cortex-a57 not a53 with otherwise
similar arguments. Running with TF-A/OP-TEE is also in CI, but more
difficult to configure.

--=20
Tom

--PDW+jlid/GJSrRuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3bNAAKCRAr4qD1Cr/k
CktLAPwNluOwpqdzydH5nTqjHO6K0PjM5TDVFDL4auQsbk00KAEAnb61xhlZ7xF9
i8SYfjRtYNDfoonnNEPr1sYyKfaGHgc=
=8U5H
-----END PGP SIGNATURE-----

--PDW+jlid/GJSrRuc--
