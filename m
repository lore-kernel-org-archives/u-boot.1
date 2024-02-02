Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF3AC48291
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 16:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF2A87C5B;
	Fri,  2 Feb 2024 17:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HLYWPazh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C051487C15; Fri,  2 Feb 2024 17:06:28 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E9C87BF2
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 17:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-783f0995029so143316885a.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 08:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706889985; x=1707494785; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TLK+Bo12t6ATyHue2AwEr6zkToyXXFBEtT1HXwcqKqk=;
 b=HLYWPazhfCy30tck/tNlFCNuzZltBXL5aDqiQvyfxvFWgroCWBNFt14LW0ZyEJzXGQ
 KUvE19h3qO/A5mmLZto7MIZRq0HIr93Gn39sgdF18i05basKLxSJDvFnWv6hXD+DytCf
 zreoEzk5P8Z0VdFEY8DIclkZ+S3k/pV0Jv4Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706889985; x=1707494785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLK+Bo12t6ATyHue2AwEr6zkToyXXFBEtT1HXwcqKqk=;
 b=PIvZz570/MOsewm292AUdQqkGTQbtOjC/N5N9643WX1i5bFoDLSc8YBdznFoMFAdR+
 x5toC9JlYrWv1qp3bbQ4pxyqRvn57OY3fnU4Cy6GDSDH2zpZ62bi3vMfX4/JO8R7CuHD
 ftEjWcXJgyG+nYM3wFzs4pIn/JEbf1ff2VEG0/mEdg2P39rqV5M7nlyA3CB/q+c3xGxx
 ZIaWMb7PKQoHijTLhp4eHTsM/s3blM2lxwP/LDVCaYArkebSIylkyIN/YJzjhoX9M2JJ
 4V30Ncje/cyYYf0DZs5zdXraniq5Cn2sN7FgkS8V+BH1cwkOcDGpxs44A4frlkXSeQ/b
 ygUw==
X-Gm-Message-State: AOJu0YzBi18WVb3clAR0kvJwWRePYJExRqgIe6glEiuZ8jEjWtGc+zRR
 px8aUKM2O8oGlEQnAx2PoPDAfmz3jed59ljeViEjzl6lmC62TiNwQXwfDz6pXzY=
X-Google-Smtp-Source: AGHT+IHRDWORw74X6mI8Z0aUnMNmMI8dbrJmY9TOZbuTimn1raOuLpXnHY1H2sUlE5B0iuNrqAWm6A==
X-Received: by 2002:a05:620a:a5c:b0:785:3422:8353 with SMTP id
 j28-20020a05620a0a5c00b0078534228353mr2638144qka.22.1706889985051; 
 Fri, 02 Feb 2024 08:06:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVxO+CrnPqkP5FuM4YG0Wd7hVuK72rjiQwsnKr+pXx85ZFkDxSaC8gXsDhWqk0j+KrAtlDJjDzm5WQEIwfbZkzT6TJZZUQNQcwkE0h3v4H3cQ==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 i3-20020a05620a144300b007854de874a2sm774373qkl.103.2024.02.02.08.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 08:06:24 -0800 (PST)
Date: Fri, 2 Feb 2024 11:06:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Dennis Gilmore <dgilmore@redhat.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] board: helios-4: add config fragment for spi
 booting
Message-ID: <20240202160622.GC1152441@bill-the-cat>
References: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
 <20240202-helios4-spi-v2-3-df085461d894@solid-run.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="crU8LakVNGi1GS2b"
Content-Disposition: inline
In-Reply-To: <20240202-helios4-spi-v2-3-df085461d894@solid-run.com>
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


--crU8LakVNGi1GS2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 04:13:34PM +0100, Josua Mayer wrote:

> Add a config fragment with required differences for booting from spi
> flash instead of sd-card (default).
>=20
> Settings for environment location are based on vendor u-boot:
> https://github.com/kobol-io/u-boot/blob/helios4/include/configs/helios4.h=
#L59
>=20
> The fragment can be applied on top of helios4_defconfig by make:
> make helios4_defconfig spiboot.config
>=20
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  board/kobol/helios4/spiboot.config | 4 ++++

Can you please follow-up by adding doc/board/kobol/ content (and adding
to the index and making sure make htmldocs is happy) ? Thanks!

--=20
Tom

--crU8LakVNGi1GS2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW9Ev4ACgkQFHw5/5Y0
tyy0nAwAkTybZIQuT6BPMjdhbXLQNUFU5AuqqVKyQj+MLWnuJtTvXWMWEtw3TFi+
153E6adunGNYSv/TSAS7Q+MDReXKwzZ0q7u9ZcgYYzaDH3UL0tjfPghr15mXYgz6
ZwTTLmTFgEgRjkyBtTC6PW1AVF2KCnUo0VL+n8grvSfsJF3HQmeU34oZlsiqpbc3
eZosTFpnaf3lbm0kSWO7Oj6PXC/zF/+qxAlPs6RLItqYMxMibtN+xTsWnwD5YPXF
qa32EAWsxtic8FRIo/xTlvTP01RkmwAygTbnw6S7yFN2PGF+xfx/Tgy1jfFhAnvj
Xr2EFX++emrbq/OZKd/x45E43DOzaqv4emgRrxHYoyrgkX1kcyyEn/xtSurUW3Aj
+G31T2WbsHK8r0PKqXRgjAVMP+7bK9iPTucJjEYjGk1YypV6BDjDZjld1tYFiTm+
zOuIO+AcOZ0Mqyxw/UBbyrIePhykGhJXRQ+Gwe9uOC/9iD+9Gr8nRDuR5GgXjHsl
OypaWDiH
=/p+D
-----END PGP SIGNATURE-----

--crU8LakVNGi1GS2b--
