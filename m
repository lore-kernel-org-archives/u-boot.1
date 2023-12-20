Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678C3C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D133B87860;
	Wed, 20 Dec 2023 22:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ey5BB2g/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E09948785E; Wed, 20 Dec 2023 22:02:00 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D558C8784D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dafe04717baso109878276.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106117; x=1703710917; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rSsB9NO0oKANBGV1pbKEyJzbgnEW0DmdIlBRorgh6pE=;
 b=ey5BB2g/iHmJbNWBVfwlx9wL3p3efJkiR+fYtNVQupiSlC5+MlT3QyShwwfHG8QQ5H
 N762c5QWRquT1r8xGiog8Ahx9gxwYnJdrZ9nKxObO7s9x1h5wXob27gefCGTo+Ty1DQ4
 aj3JroBUmgpEqjvyRK0g7SrWY+O+TzTaiq150=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106117; x=1703710917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSsB9NO0oKANBGV1pbKEyJzbgnEW0DmdIlBRorgh6pE=;
 b=Rixqadd7wqyylrqNZKbA8dlhl1DHirwxNUwDqP93vitPuVCkfCy1REhvRu+aTHdpB7
 S9xIzYxWT/jFLpzrnbWaakQ86SYqQk1hae/cUS3QmxPHmZB0JKtGUP+QVfUdA9UE2aYI
 GEGNxdCwWhLJ/3Y1TaAJtHt84MAlx+SAaWpOCpi+uTA7LCa6OVF0I0KCdFUfQcgCGkc9
 6zFVXQ49L1XBZCTWz8KejCp3H6wYLyKfGDGnRJmwiDAsi6Zcf68Chc5UOr/1LsENMn+R
 X2qcr8kGb7lGVwZxzbXYylUNbOmlW1xmRrgWJk3nkYGLkZZUyTmKXkII8W4Y0a7qFDow
 9aTw==
X-Gm-Message-State: AOJu0YwLUtFL5wfxHlpTCvxbeU9HHhYSYW7VU5fDjg/fOqSTQ/lkGmAy
 DgTC4fH7wfONQhWJEaCKG5GE7A==
X-Google-Smtp-Source: AGHT+IEgszcDoqQYyR1ZQB4PpdOLGJ7QPuXldI4UliMhJ0pXfTmn2wzJ0AVk3KvLXzlRTyUz7tRnuA==
X-Received: by 2002:a25:e811:0:b0:dbd:72cb:5f2 with SMTP id
 k17-20020a25e811000000b00dbd72cb05f2mr308137ybd.78.1703106117455; 
 Wed, 20 Dec 2023 13:01:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 p82-20020a257455000000b00dbdab1ae77dsm230125ybc.1.2023.12.20.13.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:01:55 -0800 (PST)
Date: Wed, 20 Dec 2023 16:01:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Piotr Kubik <piotr.kubik@iopsys.eu>
Cc: u-boot@lists.denx.de, sjg@google.com
Subject: Re: [PATCH v2 1/1] bootm: Fix flags used for bootargs string
 substitution
Message-ID: <20231220210154.GX2513409@bill-the-cat>
References: <AS8PR08MB6806D08B61DB1A97ABF68BBDEBD5A@AS8PR08MB6806.eurprd08.prod.outlook.com>
 <cover.1700843096.git.piotr.kubik@iopsys.eu>
 <01aeaae2b87933e8a33a575ec0d23e2d464d6699.1700843096.git.piotr.kubik@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rB3r8gub8gynCPTn"
Content-Disposition: inline
In-Reply-To: <01aeaae2b87933e8a33a575ec0d23e2d464d6699.1700843096.git.piotr.kubik@iopsys.eu>
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


--rB3r8gub8gynCPTn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 05:30:46PM +0100, Piotr Kubik wrote:

> Commit 51bb33846ad2 ("bootm: Support string substitution in
> bootargs") introduced a feature of bootargs string substitution
> and changed a flag used in bootm_process_cmdline_env() call
> to be either true or false. With this flag value,
> condition in bootm_process_cmdline()
> `if (flags & BOOTM_CL_SUBST)` is never true
> and process_subst() is never called.
>=20
> Add a simple test to verify if substitution works OK.
>=20
> Signed-off-by: Piotr Kubik <piotr.kubik@iopsys.eu>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--rB3r8gub8gynCPTn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDVkIACgkQFHw5/5Y0
tyxQ0gwAr+HnoMvfVxM0zPmCqbIM9jzk8JmYf+8t1ohud52jO5b8k89f6pg+dxHr
9LDEfjWXo86+GNV1r5Z7sNZwgddX7aaJDFI/2YhW9SxdkwcohS/OknUIN7RiFGLb
qSsYbhGcmVMymjWNQYWjIG6UllaHEsrU92e9xojoWj5/0A/1ULlmoFmOTQjkx9XL
VrD0qNs37MSlkLOyZ1FFFaxk4zfzkgGVbLqL9NrkRcq7CrgS8Z4qzBsQ3wM0fokk
4Ps/wlpRIBnmAUy3nlXXHb7PKVnMpENiWwQjsdfdjPK4AIFo+Ig4Y3tGOs/9M5Wf
5ESgkfroEt29rul8gFGS3zu2AMtxhgjxAU2ogc5em9qcSXp7o4zOyU9ampdAyKsZ
IzzvCdIWtF2gqjF9qGXXmbpB5q1JNJ8InJ4vB4ZOXx0YXShsYo2Of9HEzTtqdmag
gwHlSynD6pV9E+BTBbKp54rbj+2WH/71cnRa5VldBA038RCohe5Q36jdnUjYjHgB
2u1hB4Q6
=hjJ8
-----END PGP SIGNATURE-----

--rB3r8gub8gynCPTn--
