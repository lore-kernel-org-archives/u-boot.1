Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CA6CFC279
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46CA08388D;
	Fri, 21 Nov 2025 15:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XrtUeRUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18BF8390D; Fri, 21 Nov 2025 15:25:05 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90048382A
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4511750d119so112823b6e.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763735101; x=1764339901; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lt0pGlF4vsUtxabQYhoYK6jldJMsy0rnkWy+psFwZcM=;
 b=XrtUeRUcI7fzE3PB46sZR+6R+l32+PJvcsSQsUr/JMDrmsxIMc+dXTXO92Mh2d3Xix
 3V/hWUUQldLXT1ehHEIkxpEpxvRTkiEIOQpnS87q7wNqiRFv18IPGfNAr6ixJGXGkZVA
 jThLeGJLGDu6T18RaFjyQQ8qKoPllp6o0fsp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735101; x=1764339901;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lt0pGlF4vsUtxabQYhoYK6jldJMsy0rnkWy+psFwZcM=;
 b=Vnz2NZK+NzhWneR7fe2Nx7qv2jTbLbmcF3SwkUMF/480oWKl7RI0DqobDuRP9Hdf7j
 zZhK9CvhYuLuYTvt8NXiglaazThr6hkAHrQdxCkQufW4jQYua2uemdoWFexfl4oGt5M1
 /ky/YYEkSJLoAvQmF2beSZa4ij3q4YuOaz6ss816XtbiOLTLpy5U1rzy9FFkjyc9CCfS
 eD7dKAhUFBtAlzBwvxqYZuautz+/suKtglR9/RpjMB2FUAXpNg1fMfLcvTIdPIfan3/x
 h+/CLz4WrBWj8xIT0uQe2/BRw6fa3gfqi+UE2ADS7EzIVR1GCaGXcmN4cWp9PlQKipn4
 gC4A==
X-Gm-Message-State: AOJu0YzRIfAc3ncwI5rmRFNUzd9mhOJL7WUG64FzqsW4iK2R0Iy8wvfn
 ERquDqJkEmfyoCVPWXr/zkf2Jt9gWzNjbeqzZrI6iEh6rGdJCHQmx/g5QoHXPyWtQ6M=
X-Gm-Gg: ASbGncseHsQDS2/wwhjLP5o37dsnxkRhyavjJXHqIvoqPOo7jBTk2Gtj+HEOWfggv6+
 CxG8XkR9958T6RG2QW16HoB3tlC4lxVybjG4qbvnUmWY6899k9f140kIJ/Ae2fpBP7K7lh5cN/T
 y6N7pqa96LZkFYyESBFqwjmDQYVw0RYZOoxN/uwu67FunXWNxVNdfb/+eEWao1waAOoz041/Q6H
 seRRJhC7cc5nd5aPAZgp4vMa8u7EBocLUVM71Sj9fYJG/OH8s54ApicfrSbk20gOzDILR14P1Cw
 NP3YSq+mGahezcYeKNfik9uRKMJYH2uiYzcec5qv/wC2EOrVpcTdwpNUC+IHEfMlkW5//roNGMh
 mcJPN9FN3bnh1c91GyO59W5965Ae7Xj3d9fVbJOpcK+e5cvQSe2FsfnT+Ucl/OGJALXCqywhT1v
 E9KBsqxOJvf8FTuUqU2G6X3K/QxcQzTWS6oTyU7BdeknXMbHRIPw==
X-Google-Smtp-Source: AGHT+IF/HBGPo+jXC3OkdDJOxXW8gjvvFxPxuUD6sfEKHzV5TjbpIiantZ3JL2B0Qrbm1feWV3ypXg==
X-Received: by 2002:a05:6808:1a19:b0:44d:af21:bf34 with SMTP id
 5614622812f47-4511294e751mr1079326b6e.2.1763735101154; 
 Fri, 21 Nov 2025 06:25:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe2f361sm1658305b6e.1.2025.11.21.06.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 06:25:00 -0800 (PST)
Date: Fri, 21 Nov 2025 08:24:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 2/3] CI: use mirror for gnulib dependency of grub
Message-ID: <20251121142458.GS2125796@bill-the-cat>
References: <20251121-gnu-mirror-v1-0-548e6cd2665e@cherry.de>
 <20251121-gnu-mirror-v1-2-548e6cd2665e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KEbX5XdyakLh7sS6"
Content-Disposition: inline
In-Reply-To: <20251121-gnu-mirror-v1-2-548e6cd2665e@cherry.de>
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


--KEbX5XdyakLh7sS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 02:22:15PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> grub bootstrap script downloads gnulib from a non-mirror URL and thus is
> unreliable.
>=20
> Instead, manually clone the gnulib repo from a mirror URL and pass that
> repo to the bootstrap script via --gnulib-srcdir.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/docker/Dockerfile | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 34713c5e8b2..85274c303c8 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -148,12 +148,13 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,=
sharing=3Dlocked \
>  	zip
> =20
>  # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
> -RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub =
&& \
> +RUN git clone https://https.git.savannah.gnu.org/git/gnulib.git /tmp/gnu=
lib && \
> +	git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \

Right now, the next branch is in a funny spot. Post -rc2 I applied to
master some changes to make CI more reliable which also meant that right
here we do git clone --depth=3D1 -b TAG. And doing --depth=3D1 -b TAG is
something we should be doing here for gnulib as well. Since -rc3 is this
coming Monday and merge to next shortly after, can you do that and
rebase on top then please? Thanks!

--=20
Tom

--KEbX5XdyakLh7sS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSB2NwAKCRAr4qD1Cr/k
CibqAQCtQ2DzDuQE/mF26U9mT+DOyRBo+UnX+WcoOV9yZZkhPgD/Su4UBeVFquTd
+DXYoPahlYm85jIfU0u+r/PmPAvy8wc=
=IbX1
-----END PGP SIGNATURE-----

--KEbX5XdyakLh7sS6--
