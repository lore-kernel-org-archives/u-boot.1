Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44676C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A7388081;
	Mon,  4 Mar 2024 16:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TIY+l80k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C8188095; Mon,  4 Mar 2024 16:28:52 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8977088035
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6906a7870f3so6271396d6.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566129; x=1710170929; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gYxCje38xLmnixFopIjcULpGN1QvVpGHBiE6EYovhgs=;
 b=TIY+l80k3bUWCZFp65yKZ44qrEuMXEwHAkNLEPqdPGiVm3lhVf3P0oJGb/A3OPnyYK
 oeZ4NGarZp8fOx5oNWrj0cdKojOaJDUVdB3cSV7lp/rxPmDjaV7Me/8axdYIMH/0A6Gt
 ScZTbN3pirmtrzCFpn0669WZluoEEgOjR8JWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566129; x=1710170929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYxCje38xLmnixFopIjcULpGN1QvVpGHBiE6EYovhgs=;
 b=KiuohTZPvTC1C6RU0cQS/d5AGIHU/Q5Gr/EjflUMdfVv0DUZTXkQIaWljgfK5lXl2Y
 Bb0PxUr+8ShDJpcsDSYWZRAXwrOUJYBlt7YBkm67Ve69nEPMzrr+TeXqzwRjXLMKXjCy
 ZFax5UhFwMiOcXd6/WLID5tYkFcvG+EJT0kZFfHbOSn7GW7SFkI7G3Ajli7A0QWulsh1
 EeTMHGN1N9qS3E5FYebDl27WtPlBNUSAGBNMTOo5lo3s5GA1yk401JdYqE+hv80OdC8o
 Rcxl5+2pd6H2edEAnqM22+v51iJNlyxSvutgLp928x3iJxsfhZNMaBJ8rz8eRvjyiOLy
 1ABA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUycmnd7a5UsozfrasWLzqZlEroT2OYfX6MBAIn+jjrVFb4R8q7j8zvieJU2oBtXtG+jv84LCjpzYZdRoKxQsXtAYYvGw==
X-Gm-Message-State: AOJu0YwbLruqd0Z0pDMJMuD2szgyFZX6dRKGL0GA5XWClPftoKZUJ3dM
 VhFpq31WL6pp3n486cujQ7/0SfuzWRxW9DL43ZoKexWyHN4TsUWYKdFth/haqZk=
X-Google-Smtp-Source: AGHT+IGCNNWyX6eGm8qQNKEY0QAs74VJn7VfD85FMZ1Buefu1M7kK4O47f22sZ9bLt2UMoZuIA62gQ==
X-Received: by 2002:ad4:5890:0:b0:68f:ddf5:abac with SMTP id
 dz16-20020ad45890000000b0068fddf5abacmr8774087qvb.7.1709566129449; 
 Mon, 04 Mar 2024 07:28:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 y17-20020a0cead1000000b0069051255b1bsm2013664qvp.77.2024.03.04.07.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:49 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] pci-host-ecam-generic: Convert to ofnode functions
Message-ID: <20240304152847.GG1523872@bill-the-cat>
References: <20240214203001.150942-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gj3XbKZ4pGYhLkkJ"
Content-Disposition: inline
In-Reply-To: <20240214203001.150942-1-bigunclemax@gmail.com>
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


--gj3XbKZ4pGYhLkkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 11:30:01PM +0300, Maksim Kiselev wrote:

> FDT functions is not working when OF_LIVE is enabled.
> Convert fdt parsing functions to ofnode parsing functions
>=20
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--gj3XbKZ4pGYhLkkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6K4ACgkQFHw5/5Y0
tyyZnQv/ZlYaMz289Irv/lkvdDNmw1IoGsfWFChDyX9kC/1+6U7ytLncejfxjX42
OZzc1nbmIM/Bqy5qpRZpFEu+ImEHUwmVwTqXMU523Kaemnl9DP0Kq/z3OuXNMIdH
d2N7Vy6mtZsyqL1ONYhehBUSBHxBBU0vVUhwppGs+dqXWjfN8A9tZkHUghDedhOA
lNnLudnyaOQkbdbKergPy1go0gQ0a14uJlNpqi9lQ5HP8wfdoODHBy8uNqJ7s+7f
nzvdX0ozW3DUJJZqFJGdcsC/lUVc5G7/2FtQUEshlFfdxwB029R/er7ma7jdpc4a
eozdD8WQujLqIpB8wp0e8yywrqL+v38CnuQNrjpZF4HSCk/xSF1XUsyml5+uirAo
G4mNj5ljUXMOs2UpHXdUBjJj72gpOgPx1Md/fpxbbEepo+vgX/36UCqFmYFmXyN5
uwGuhFwITrpvuPAxeyi+p8/j7hsHEZeF5SORC1iD6BUqBbxoCQx4pYdQZ5zx7Vmg
N4kXWsto
=xH4R
-----END PGP SIGNATURE-----

--gj3XbKZ4pGYhLkkJ--
