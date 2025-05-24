Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6CDC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B42831C2;
	Sat, 24 May 2025 16:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZQSKudwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4524683416; Sat, 24 May 2025 16:32:41 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D69BD8294C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2c2504fa876so314573fac.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748097157; x=1748701957; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c6tnZZ77PYBa1jzOsk+eUqpIteU3pjIYASEuzTfNcDU=;
 b=ZQSKudwohkXSjCxhKrAl/WeUxv6e+G75m028DeC8oj8ysbZRdFBSrwG3pozxug+9ls
 SJbXLseJo5EW5lpBD3//p8tslWbFQKTeI49mnGUbRnSOibk374d9+/OIQqbGYC+SeA4u
 DLa+WWbmGtsGA0W1SBsy7oVHCUlHPDGRXp1D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748097157; x=1748701957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6tnZZ77PYBa1jzOsk+eUqpIteU3pjIYASEuzTfNcDU=;
 b=s6YzIMGfY0OVVNQ6rwjQhF65koOqHVEpbIh9kWT8GbxTDOlsk8BpOYq35S9cPqzLpv
 ayXgQV7B1h8CNSy+w4Pr+29BOIHlNbkW+KOCexbY7DFKoUhbnixQ1UDF0q1HlzZNtLW5
 Lick2PVKapdBbYeaa9y/O9xH0616JCnwOGWcjFpiyF4wXZzUzwHwQj5nfvsCOJBVFzIf
 fZZNEocuaohfFm+VIwYygiDXsRUVV+qQrPHW01XRi8wXqYgCkFBO5addhnIAnzOfXAgx
 e5eSAHVLK1zdlVWEYmRsOCht52oIeaIKGscqnxVm0h/0/UjzKWZV1xYUJ+mBULtqSKqZ
 ZSCQ==
X-Gm-Message-State: AOJu0YzJePM0RBCgevhlM9iSgpzBNBhKzIE0t6GObr15TPTk9mN8aFjg
 GKR/kQcpwOeBbpGrj2zBA+GDDF3OJyrik0mI3E7X0H2Y0lXChTKJV4JN1QdhhrgX4O4=
X-Gm-Gg: ASbGncsUzsNXvbemwMVbal/V0AVbMkFBP8v3Qv7+uAtvEtJywrvFaWLmkK57cHyBhl9
 O5XZWqCXGShd82eVcD/VmP0we8az9A/iu0GTaicY8KpEbSEkopQoU1Cg7MoWA60SlIomgxbyRz7
 CDLkK+oYUQzD3YR7igL3Um705sAUzhgS28I3oFiHSCUom3sC1j3VN+uyoX9iBOPNARSAP3hOXCb
 VJGcNF0CdMnzbDFbR3jgPnbW96NGGyoW3ZDDqLNO/a2+BDt4cQGqZbammV7rj4NtpeE6TZkI8Ba
 bS1FHG5Z9jxIkuI9A547KhMcX1A3OTVy6seFmIcumpPBeXA2+ctCtJp3uImGjxKoc96uDrSG50I
 aw/o3QmnaPacgfqFvSG7rsX4=
X-Google-Smtp-Source: AGHT+IEw+eaerxhC2Yut8n57CcION6CCtF3mEu8n7mza+LRb9Xr0hoeWJRcZBhTnVTOQAYzh7TPtwA==
X-Received: by 2002:a05:6870:530e:b0:2d5:817a:9dfa with SMTP id
 586e51a60fabf-2e8620e6064mr1579570fac.38.1748097157570; 
 Sat, 24 May 2025 07:32:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c06bada4sm4059722fac.15.2025.05.24.07.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:32:36 -0700 (PDT)
Date: Sat, 24 May 2025 08:32:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] bootstd: Use -c flag with bootdev order
Message-ID: <20250524143234.GJ100073@bill-the-cat>
References: <20250524054245.409399-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c6vV4H9Uqhwsm5C1"
Content-Disposition: inline
In-Reply-To: <20250524054245.409399-1-sjg@chromium.org>
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


--c6vV4H9Uqhwsm5C1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 06:42:45AM +0100, Simon Glass wrote:

> Update this command to use a -c flag rather than a special 'clear'
> argument.
>=20
> Link: https://patchwork.ozlabs.org/project/uboot/patch/20250501133726.262=
7373-16-sjg@chromium.org/
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
[snip]
> --=20
> 2.34.1
>=20
> base-commit: d0792b0848712a84b5fe20ba60f699b48def807e
> branch: schc3

This is unfortunately not on mainline.

--=20
Tom

--c6vV4H9Uqhwsm5C1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx2IIACgkQFHw5/5Y0
tyzUdwwAhGl7fjf4oqEF3ZoL44Vj9TE0GjWseiszGkg4f7vye5liI9qhmXE+wl3L
VwFeB4rqQNuT4ds/sv5yaN4eWtgNyMckvTjho7nx2ud0vjoAfJ453mQ2ggcNfGhb
uk624vxNqu4AhNpdr6/8xyAz4iI/m0WAmmPX9MH+rhDdTX66GuIQ3OkSJVYhoUnW
E1n8txBOsv4BlXrQz0zwjivhs6JcBQuvCf1oMjI0LE+KurvtpHCG30YjWwSvK146
nKJ3fQx5hmOhYK+CiQOeLN+wGnknppHbjKHuGFeKG6dhyRUGDYjQmwI07OzjH/4R
HvfvWydRpP+PUOwJratqZ0tZkcSgVHOB42L2UvPnL/ooWdEME4YXsRjORCUqTzNe
fG/B2saNaOEzS0Z/8QRSUV68m2GWerURjquN27TAnro/9mMY6JADJ5DDF7sMx6KU
ILb2T7JseHayuDXEmcqG1nfm9Lr8gHeI6wbvQgx8U9yCbF8GEF+U7ZizcNbu6VVr
zcy2re1n
=PTyL
-----END PGP SIGNATURE-----

--c6vV4H9Uqhwsm5C1--
